import React from 'react'
import { Routes, Route } from 'react-router-dom';
import { lazy } from 'react';
import { Suspense } from 'react';
import AppNavbar from "../components/app_navbar";
import Loader from '../components/loader';

const Home = lazy(() => import("../pages/home"));
const CreateSurvey = lazy(() => import("../pages/survey/create_survey"));
const DesignSurvey = lazy(() => import("../pages/survey/design_survey"));
const PageNotFound = lazy(()=>import('../pages/page_not_found'));

function AppRoutes() {
  return (
    <>
      <AppNavbar />
      <Suspense loading={<Loader/>}>
        <Routes>
          <Route index element={<Home />} />
          <Route path="/create-survey" element={<CreateSurvey />} />
          <Route path="/design-survey/:surveyId" element={<DesignSurvey />} />
          <Route path="*" element={<PageNotFound />} />
        </Routes>
      </Suspense>
    </>
  );
}

export default AppRoutes;