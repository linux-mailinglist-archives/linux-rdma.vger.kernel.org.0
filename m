Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C597E780F01
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 17:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352986AbjHRPWT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjHRPVx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 11:21:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC5B3C1F
        for <linux-rdma@vger.kernel.org>; Fri, 18 Aug 2023 08:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692372102; x=1723908102;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E6Bw9fGtsy+Jw0aNVM2zBJUzeA16GmskILq3Utt5s8U=;
  b=kk9wqeHNFjaKF0C9qzbbfN4EzI5LRqqoDcMVM0psZ+oO0Wmh1WA8iDdG
   7qjvxVMw3aNJ1RLULEk3ofW1UnVHuHqMTsGks7EEpNaOyTswEgYPYdhXv
   RzTrOUEx2L0umSrYA2wU2fwgVn6Dv/xLu5MNxI0ai1CUWnSe03yzOtzhl
   qWgoi2uH9tCS7MIHcCuTCqz2y4/j0yYs2/gGSxxN5YCevrP3RIxDo7hw2
   Ffbd84UursxgajeO3fuFIFS0PEi/Vtti5ASH73pR6+be/8rA/gxAHck0t
   a4Vqs6o/oZ+GzEHkMnFp4p39Plfohd02M33UGHHFE8PWuouil5ODxnosG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="375901369"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="375901369"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="805195203"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="805195203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 18 Aug 2023 08:21:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 08:21:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 08:21:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 08:21:40 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 08:21:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5BR64EE4PP0sracw7g5UFpDtuLi01lD9tJwBiVJ1P+CjcYkXrDv+Z9xVohoQRngX6ksjj0CGKA4yU375GVnLFCSOIg1bM0J1vQF8KtJd1Do+QoE/xD4jhNB6LiIr+LwiyoCGz50MCQ43u2Jnyf8aTf8UUiyeLmytAvsnRSKoRmH8E/h3H8mLmNfGL0Z7p8wXrWBbRKNYf4EoB+dqLuAheOj9PPyu70lGuNf6pJSF0daNyuRXcXIrOGFOn39wVvD2hHQ8hnDNbkQ9JtKz5XGuBSkV9vTPZLSG+x1vyytUsUtOXFCmEkn6DjX1kASdP5ylfYBu2DupcT3CLM1Ygs7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggYvPzP8RalJT0r/Tsevyzz7yxleDGUQa1SiL8IjlQI=;
 b=g2Pg2BfBrxVCqu/eM1fRAZJ00NWrnBPANB4yOtPiMjl72tSgvF2x5RILrLC7Q2ZB9n984MDnSp1oQl9kGa/i1XPNL/ol18mYbn8xel+rb12N32HoyoCsgEadiFSbzYY6BEvsaKUQGlK6m27xuGjaqJymdmLAJxrdnT+Mj17iXJNJkGEI0FwmpI/pVzJLZ6L3WYbX38DKZc3HhZaavZSeapHOO1GVxEWCNahIFfXmVE0oZ7FQuacbct4Q+jkG3HIKnH63qFqxnXjZZxNixm7XzWnF8cq9ZYDYHEGIi3wm3rO+H6ZV0FfiOz2j9L3KmxBwRxLn6WCi46PbwNWo7oC7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 15:21:38 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fc26:895e:efab:9269]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fc26:895e:efab:9269%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 15:21:38 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>, lkp <lkp@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "Sagar, Youvaraj" <youvaraj.sagar@intel.com>
Subject: RE: [PATCH rdma-next] RDMA/irdma: Add missing kernel-doc in
 irdma_setup_umode_qp()
Thread-Topic: [PATCH rdma-next] RDMA/irdma: Add missing kernel-doc in
 irdma_setup_umode_qp()
Thread-Index: AQHZ0OLcyf6FScGAAEqvmnfXOfbN2K/wLTpw
Date:   Fri, 18 Aug 2023 15:21:38 +0000
Message-ID: <MWHPR11MB002926723E28BFEDEAB63D78E91BA@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <2c9bcd2b773c400a1699bd7973e22bfba1e4b379.1692260011.git.leonro@nvidia.com>
In-Reply-To: <2c9bcd2b773c400a1699bd7973e22bfba1e4b379.1692260011.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SN7PR11MB6851:EE_
x-ms-office365-filtering-correlation-id: bbab2836-3d46-45cf-f345-08db9ffed174
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L13AdEUkKVao1o7swQi8qgRMsyFXRgI1CIA6wzujin0ae3OcPnnLTPx1p650n71QZ58mNnPA6xkSkK0N1Dn+ZM20M58GwME+lkq/FgJCjCT9mO/d+3VJMgbKwpJy4wQTNvOEIVGBPUv4ZeqQ68tY7oA36CUf2GNbNHQCZWIEPhgxJqGZ4d8+fhZuC3K99Q9YzvsaK/bqViTYr6D0VweCT7dFxRIzvmcNKBeY3KhkI6NkX0JcvN1dFQWg4oeI1E0QL3p5sC1JPQ+J/vwz+NR1Sj3B77SpCv5kRl02AfnGv5Mo5zfBFPe/LK7Y3A17cnMUWDB7y0M4771Nn04fTAcYaDv74b+GkfEIzF8i4CmKeqjJj2IqCzOBv86+pmjEjm2kSrtX0hrOqh5ZxKBOs3+Rz7m5JLydPMOOeBnLDI7T/mDzTIWVFVEFTsEC8uta5N0n9/UuQC6nJcHZhFpepvdf73mpuj44mrYekyHAOFk2JRGC4Jd1RQYiWZ3x0ruFOkS3OGTQlaDR7BqzH9esI0z1sNfREI83yURk239X8KMusT1l1b4/1CuNtRlHUK0m6oPQM1NegDUwFyA16//bEMrlAqiBBkU+O9aW0e3NOJ/7G4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(33656002)(86362001)(55016003)(83380400001)(8936002)(8676002)(4326008)(5660300002)(2906002)(52536014)(41300700001)(26005)(6506007)(7696005)(71200400001)(107886003)(9686003)(966005)(122000001)(478600001)(76116006)(82960400001)(66476007)(316002)(110136005)(64756008)(38100700002)(66946007)(38070700005)(66556008)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?odVpd1w0B5Pcf7C5ewDxV0YB/7v3fIb09V8+fuPW4Gxb7Dmfj7yW9JD4aVlc?=
 =?us-ascii?Q?VHngJsaA05VOnoF1AfvTT0k4orKxsgTLNuXIEt5AZEG+u9XEt3zEv3mu5Z88?=
 =?us-ascii?Q?L0fPtCNZH84FEjzkQrsPJuzcFzt3ZD6PrYLugXHoFbdnQYO2NavR7QAR3Jq6?=
 =?us-ascii?Q?L9Yfjpyj330F+OhHM/kSF9Y6UOkVRlODu9urhIW8+nGDwC3atxPZRnF9P94k?=
 =?us-ascii?Q?tei/RMSQ1Of0TKxhzpuHNEDXRAVV0a09x+9rAunEVN6g+BMLaANWt3Jgml42?=
 =?us-ascii?Q?AlcVR/ShyJfclP/r88JNYlz9WL0nPeYZfvZrdNQ4OaC/4BIVoHE8X1V/LARA?=
 =?us-ascii?Q?hmjpa/wm4q9x4Ww22S837FmFzP3unazn1ptjwqDLSKlvHG+qLmhxWuWSo6Rc?=
 =?us-ascii?Q?C0vYoE95LwcHA7Tjmbw9eEp0yUcbg45CgsOlVT7JQIvEmAMzes9ZMATuyReq?=
 =?us-ascii?Q?Up9Pe0B9gGCygawh+rSbJBzFbGjhn65i3P90nXF6gvUmQjE6LGA/wX1x8X5a?=
 =?us-ascii?Q?VD38ucXJBbWJSIo7TkTb9gba9ZI2F9DQDtExBos3ufVyBb6cn4QVskUVxa57?=
 =?us-ascii?Q?NELYhuuymhRGd5Y5sIhuOMQxSfyzg6ghR/GETua5VXe4epxlI8tX7OyzxZ/X?=
 =?us-ascii?Q?K+gzRCnFV+qSS2Zt4l0boWHuRaOus/8b6d6OJVSC14ADVHM/bGJFCCofCZf/?=
 =?us-ascii?Q?wCcJfQb64EYg8GQesZrXsO+AirUdCXlpA36zsznMyQcHEhVmyS5H2xYNk+lH?=
 =?us-ascii?Q?hS3qjii7KoD6OYO48ttelq+yHEw8arXhE8UJctoQc2Pi+oJtNV2i/YmJ1JpJ?=
 =?us-ascii?Q?fPHnyqsGDFmCje+S6WTIdmZFB63EX0ucHEZpzbBFts8seeVYKrfI7rso9hKW?=
 =?us-ascii?Q?3apbFyI78siDtlnH3WhjAc0SnECqIzoOnBagEvMNV1iG9cOZi6rND/Fh5VeI?=
 =?us-ascii?Q?K5/hVY4nY46cD2qKztGyipc3+HLATOiqjCATjcu/Mpzpbo7V1VE0kUYkQqIl?=
 =?us-ascii?Q?wiwnhL+NjeLnjy6ZtL048JkLT2M+KQGYC8ka23qwkjXBqm55QMeS3T1n6KHF?=
 =?us-ascii?Q?cLJWx51JxIJ/PpunsCNq0mzadJe6Ha8JjDbpIjPZ9vgRpSe691FOccCBih4f?=
 =?us-ascii?Q?WHmv8YBtAbDD4mgeUPn15rZLFVkCkG9okYy+C/ynzLbWIctkDtRZz2QkagbU?=
 =?us-ascii?Q?0UnNLCRm/Mo4TFgu6h/PRDWwXfO0EPvOdUNhWo6RoiU1mavveD4L6/AIVpaj?=
 =?us-ascii?Q?qLI/w3MXMbYxMquODxSLOtAVRPVECGRDNpi/z5sm4NQsC29nKx43OT+6JZhG?=
 =?us-ascii?Q?nAXwcbFu03QQY95k6j+hrD3p1EvuxBrP++o2FQgVmTgWQmbI0DAongI/7/ii?=
 =?us-ascii?Q?UvgD2yMeEFlFt0MVetiEDkPgCAzyYi3fZQILessMxC3jd4LOi6AZl8zYUUYi?=
 =?us-ascii?Q?mNmagB4HVrxvm+bMByiOWXovXOYRiWNSRFN3cdg1Y+974ohPkTbtkQlwhDOA?=
 =?us-ascii?Q?4v8hbC67UurD9MOEBMZ0T8kKKgQsO8g1+Pd3y+yv8n2gY8xv46Js9OgcfDTl?=
 =?us-ascii?Q?iAOGXqcAVWRsPQoxnqWzsdI9SN7d96/yoTNss47N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbab2836-3d46-45cf-f345-08db9ffed174
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 15:21:38.7062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnGWU3M6VGBjn3mDNXUnfF5XrsYINotgWwO7JVRkK3ZrTmSssPaus02wPqGEzJrwcVXc9uBswnch+Q2IDefxng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH rdma-next] RDMA/irdma: Add missing kernel-doc in
> irdma_setup_umode_qp()
>=20
> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Fix the following warning reported by kbuild:
>=20
> drivers/infiniband/hw/irdma/verbs.c:584: warning: Function parameter
>             or member 'udata' not described in 'irdma_setup_umode_qp'
>=20
> Fixes: 3a8498720450 ("RDMA/irdma: Allow accurate reporting on QP max
> send/recv WR")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308171620.m4MNACWz-
> lkp@intel.com/
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 660be7f13060..6cffe21558fe 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -573,6 +573,7 @@ static void irdma_setup_virt_qp(struct irdma_device
> *iwdev,
>=20
>  /**
>   * irdma_setup_umode_qp - setup sq and rq size in user mode qp
> + * @udata: udata
>   * @iwdev: iwarp device
>   * @iwqp: qp ptr (user or kernel)
>   * @info: initialize info to return
> --
> 2.41.0

Thanks Leon!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
