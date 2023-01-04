Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C617A65CAB3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 01:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbjADAVY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 19:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbjADAVV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 19:21:21 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B5F165B2
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 16:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672791679; x=1704327679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hN8aqKR191A9Cg6xxcXhoRAteApv+9SXnU/bmhu2IE0=;
  b=ADIc7DeSXoLx7u5B/zLxyx7Q2SfhSJVlD+KpILohGw464NiS3gjhuRYd
   /Tq4XbZGeI0lEARAWtGeuQXvsMYJw1+V1uflXlqQrMAYLilWLJr4mVU93
   FGrLbMDwnJ1PmUMMglg3JtRFp0y+hYNjbg6OBGstms2bmpApHdQ82uE4d
   bYJhtzA2XDuTMH765aj5e3eZNNDOf46bZAM84VTdB1W1rieSr7Ato3txc
   yislD0ORJSma5bp2Y/mO4VVcFPw6k/S6qfF56QxXkhWaOKi2G+IczaagR
   9NF/hgOjw0mO9joJIOMPJ9fMo7ytNnDih4FoKy945VaYBATH3taIOVsmv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="321861081"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="321861081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 16:21:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685576118"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685576118"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 16:21:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 16:21:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 16:21:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 16:21:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoNkDQ9AIxRJv0abOfRyMXDg11Hxs81IxGDSD9LbJ6TqDqlEbWhqJcCWPPJDlVy4fOc5kcXpEUXdINj/NGfP9pzeVUgqnn33EylpCDg0DvtiHb2fbBQkoT3a/m9X/KF/NfP9VziYbBIPNeb7QTYtmRx8r00sdQBs6PhR5OD0GwNb8wZ0SXKHxdWcsjAwPwFQmyVTuzOVA5x8WZ1wrL7Vn7JkrYdbxBoym3IZcPtVJgbVyY47k4F7ijtPBhB/29LrvAEqGhjtTZ9aisJNcl7fQn9u2CIWBdg/woK3pqbe3kJnQ8XbFKU9ouswEV8Dg/E8WbEzFlFQhXElBYEj/c/04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIOo3WOW8rPcFrfj3opPvdjiswO6ovzh0CY54yNJ/9w=;
 b=GbJZqbFeTbBLepba0A6C77rNtV1UgxbX3tg+0QOUKkic9c6aA2czL7ucpMFbtyt96HKYzpumP2AYkai0P5UPSeRH6rrOpvBQ9ZoXqRVIcKdbARuuC9wfquZaHIQDJR9e1awgZlFBXnXfGDRczrLSxjpLCnM/gTazHEwJGVELeXLFT4888thcoENyzaBidYWdsD2o8wNzT5T7KhSrfu1JZh/ZMMOKXSnfZA7EWaF0dekknfeEQLkPdCs+UZ6Vr93+lwYkpkjeACc/XT6KsnRjsxLIJkWN1AlWUWMxdOBzrNIAqAAe8/lx4B6HDVc+hyHzlsgB8eD+eaw0MTvEUSXkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DS7PR11MB6125.namprd11.prod.outlook.com (2603:10b6:8:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:21:16 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:21:16 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
 regions
Thread-Topic: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
 regions
Thread-Index: AQHZHq/4nu0DPELUqE6mVZi+6ke8S66NUWwwgAAPXvA=
Date:   Wed, 4 Jan 2023 00:21:16 +0000
Message-ID: <MWHPR11MB0029214136E67C609CA87C61E9F59@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230103060855.644516-1-yanjun.zhu@intel.com>
 <MWHPR11MB0029F8368BF8A689F9CBD311E9F49@MWHPR11MB0029.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB0029F8368BF8A689F9CBD311E9F49@MWHPR11MB0029.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DS7PR11MB6125:EE_
x-ms-office365-filtering-correlation-id: 1adf22c4-7e7f-46c4-2fdb-08daede99863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33ll6gBzS4ZQQcYfWi53Fhj1x/pzr/hjGJj6/GFsHg3AzjP3+AjdVBH3r1P+P27ikm1kXayA16eciEPv1BzFMfwwy+Sd6ukdfKPcczNv0RjoR9Spabj3qX6QcXxm28RDwaE743ZwbepX2aEGH/UTIdVNhpmcb6fmLipjz7OgQF5bQigSyVP9MsPB0tV7f8jRzDe0VDbsFkqt6KcCGtMnWO1IUmB2He2n960cX5sfDoTxYfj88VBlJMplTIkNPaTmQuWe3VZRfvn1zP76aRBPSwyCe/76FiDwquyJk5AfowRVIbFuiot8twNwKJsoA9D5T7uyjwXd1smmW8ut5GbStwJ9p+3+oU7d0SPDh5zWA9mz3ZCQ3ZO0wy4mncptdvK/X7BJStehMS/LzklVYAVbaEWVL0MiRX9Pl0jyulcFwduPrkrz6g8lGPKI0LC1+2F41QqlFl2V3xH37teIAdM+nF4Akc9uZ+AC4vtqdLaMrnht1+ctKrHmqPCgi18Tzl1nCT50IWd5tgWXNZ7fVRRGOe+oF+NP7WOvYgxEGndtD4YWnyUjARqL7PaH0KW7YOzx32SOrMa4QXzXmeaAUdavK8+Xw8BUsyxttOdBWld8Qx5riQQOQ3Z9344Ou1hCFfgka0jjYMOsYC1fdx82WowiGSYPv8knUX9Ih1QWOTS5rpjYPAgPnlU/2Y/4jHo1mKrE6LDeM9V1jkR0wbsVo0P7nOi3V5xKKxsPn6ai4oRLTtE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(41300700001)(316002)(110136005)(8676002)(4326008)(66446008)(66556008)(64756008)(66946007)(66476007)(76116006)(38070700005)(86362001)(38100700002)(82960400001)(122000001)(83380400001)(55016003)(5660300002)(33656002)(8936002)(52536014)(2906002)(6506007)(478600001)(7696005)(9686003)(71200400001)(186003)(26005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6MVBy2oHQ5VJtvdE5qCKMqZ1/5hhATshIZTRa64X9+10J2oRrtYVQf8Og4FH?=
 =?us-ascii?Q?/AjQrTWEYpHVzPcLCvxbuzzkTyYtmmR7YvylOdykf0uAxWlYtczRy9qbgUi2?=
 =?us-ascii?Q?vOZu5xQYfGQ63iuT5/sT9sL8DzemNcY33p1cwx1yZQybRm9us2hcF9H55tAg?=
 =?us-ascii?Q?crl8JOV+6P1wxSGAm6bnvoSL/zsIbUhgWs+/r3YeGheehfU5ywPe5jCWxsUI?=
 =?us-ascii?Q?SaL9X5QpenKndaaMc1Zs/H6mc7MlRYLiUOOgOwuFQZ8qiNvJ3TvThNGYbOQn?=
 =?us-ascii?Q?rZWgU3uW5AiRl3LyatciWExmh+GlCp/7Tiyu8U4q6yrnG2lze1mZB82Bhf3P?=
 =?us-ascii?Q?BkqPDqDpp6hJkybbBWcfARImHrnxa1GfkL/uXaAhSogkrTuzigUgPyLKpYA2?=
 =?us-ascii?Q?Um5j3vWOcGoE4de7RQ2GuCdqChht+DfRQpspapIVxUY4rW53DkYgmjSqWLRg?=
 =?us-ascii?Q?cgVGVdUxfWf5D+6qujoTDgwarG1CwvIH8ihAn/wwe6/9ZeKbvRUqIZ0cuOtK?=
 =?us-ascii?Q?7kZb2D6VsVQfWB9MS0mbNWjMxvBrgzAXEP/LrA3ynSZyEakUvc6NBzpdWe/3?=
 =?us-ascii?Q?HyXOSdt77oUTr0FBAViRtzb4+xeTTtDcNf5DOSPkPNB04pfDyaEGFZqbPQ0R?=
 =?us-ascii?Q?1J3hxDdBl8VyBmyMA/CXLKWs8UTnVxdBfQXXKCgNZTVtsMU9RbvuDA2NGIjF?=
 =?us-ascii?Q?c6GzJ/WOjX2lmCFlxa14ASZ77ibuK4Qn++4etWrhcg5DBidEPLOdSfcjU8DK?=
 =?us-ascii?Q?ihX0vX/3c46qv9ipbbxaah3cF6Ajsebe98N9PbP7n+OGjLRJzSzXe3OPyxHR?=
 =?us-ascii?Q?pQB8vMmq39vU6ZQYlNXX+9/bw/bNvitf5xsbzsS0Qpicbx/3RPp7WO8HusuM?=
 =?us-ascii?Q?5sDsucDGM9ZEcho1VvUhB4k7T1fodDS62nK9qlQ+iuHERQsF2WQzc8JFcxmf?=
 =?us-ascii?Q?AgD++9h88R3jdkxTHmTHRB1YnngqZk7L2KA3l/GLuk9K3pXCPBXSM1VVi0OH?=
 =?us-ascii?Q?mCr9zVPpRHSXO4Bbh2Pgz53JrMJH8cBff7cmKRcttYjxvbc27rhqTqyoguIg?=
 =?us-ascii?Q?bPley7eFnkCGFaRzldz67Yb9Cd3PaibUxOb7tttTYGQLlQOXkkp9g+VvFwCY?=
 =?us-ascii?Q?mjDswenX+xddCqPvK7Fn+m1OUDZY6JdE3SC486gUZQZ+77jcvUJKi8JBiGyr?=
 =?us-ascii?Q?4+4sUbZYOHdUsFWOc2yNHXCk2MC7924AzYZWaObHNn7gmFQu/uX/X39bPjNo?=
 =?us-ascii?Q?QhTzkahsveOKqQF56xLflmy00IVd8v/v/AgAADe3NE1eCgFOFMswwQguJ+Zg?=
 =?us-ascii?Q?9Ju8jUjQjvoh82qasVeqlCs4wup4WLaXxKZuybWq3LX+OFwKZatW4UhEsIub?=
 =?us-ascii?Q?ZTqkOleMkrk//KerWK8fZcSVf/qbRxGHzEcAqaURiTulM2IOpSBhHZ95taWR?=
 =?us-ascii?Q?KEXZPwmtAc7JeC5QYZDcC2vdJ9SAGoUeXhcY4IIqy07rUR8j4cb7kpUIbWfs?=
 =?us-ascii?Q?ll861JSTKvjAq0S67brNnDcsL9yzP3PQF8fPFHgkZllvouDOULVvKkTX047R?=
 =?us-ascii?Q?EJzxl2swlExDL/qGax4Z+4jSwGNx1H9e+wmpGXXr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adf22c4-7e7f-46c4-2fdb-08daede99863
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 00:21:16.5677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEaAtKpKjbbqA5beZdVsmOo1gSWOaUDtHOpwvpPMSDI35vI27vjjyAILfeLI4ADmWCWq27rjNEHMqZxOOnypzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6125
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Subject: RE: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
> regions
>=20

[......]

> > +
> > +	switch (req.reg_type) {
> > +	case IRDMA_MEMREG_TYPE_QP:
> > +		total =3D req.sq_pages + req.rq_pages + shadow_pgcnt;
> > +		if (total > iwmr->page_cnt) {
> > +			err =3D -EINVAL;
> > +			goto error;
> > +		}
> > +		total =3D req.sq_pages + req.rq_pages;
> > +		use_pbles =3D (total > 2);
> > +		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> > +		if (err)
> > +			goto error;
> > +
> > +		ucontext =3D rdma_udata_to_drv_context(udata, struct
> > irdma_ucontext,
> > +						     ibucontext);
> > +		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> > +		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> > +		iwpbl->on_list =3D true;
> > +		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
> > +		break;
> > +	case IRDMA_MEMREG_TYPE_CQ:
> > +		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> > IRDMA_FEATURE_CQ_RESIZE)
> > +			shadow_pgcnt =3D 0;
> > +		total =3D req.cq_pages + shadow_pgcnt;
> > +		if (total > iwmr->page_cnt) {
> > +			err =3D -EINVAL;
> > +			goto error;
> > +		}
> > +
> > +		use_pbles =3D (req.cq_pages > 1);
> > +		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> > +		if (err)
> > +			goto error;
> > +
> > +		ucontext =3D rdma_udata_to_drv_context(udata, struct
> > irdma_ucontext,
> > +						     ibucontext);
> > +		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> > +		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> > +		iwpbl->on_list =3D true;
> > +		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> > +		break;
>=20
> I don't think we want to do this for user QP, CQ pinned memory. In fact, =
it will just
> be dead-code.
>=20
> The irdma provider implementation of the ibv_reg_dmabuf_mr will just defa=
ult to
> IRDMA_MEMREG_TYPE_MEM type similar to how irdma_ureg_mr is implemented.
>=20
> https://github.com/linux-rdma/rdma-
> core/blob/master/providers/irdma/uverbs.c#L128
>=20
> It should simplify this function a lot.
>=20
>=20

Actually I don't see a need even to use the irdma_mem_reg_req ABI struct to=
 pass any info from user-space like reg_type.

Shiraz

