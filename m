Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD05469E82B
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 20:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjBUTUO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Feb 2023 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjBUTUL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Feb 2023 14:20:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCFD2FCC7
        for <linux-rdma@vger.kernel.org>; Tue, 21 Feb 2023 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677007208; x=1708543208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gIHAawwSnekoR6AkRQNXafqd8Gtd53Nt//j9PMEzTWY=;
  b=f3Z6425TFZ8i9kdNcwqlSCrq46AFnpGdbC4FjSYr8FAuRuHbMFtk5Hbu
   ZSL8EYt2bjxgcfl0I+/tDVHr9SExCnMhvODZA1Rqnh4ZzK6+vI8WfgXLY
   bEDW08e+dmLsNvx0V0Nx/poI6g1tdAwjDMKdKFRBIuUjBU697qmI9CCkk
   Wja+/iUFmGRcXsc9b5kHP6a6RGJc1S8ShmlMD5n+ciPga9wzqOxSPAdRt
   wrxyWenP0VtkVg75JygBOHy4HovfYMFt61m4DQEr2barQSimI4L0TTsF+
   XXprIpWPpKj9Q1/kEVieO1ofzFr55ZTCKMYR4MN7e6WTxBiMLkJ7ROz9i
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="334926792"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="334926792"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 11:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="740524059"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="740524059"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 21 Feb 2023 11:20:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 11:20:07 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 11:20:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 11:20:06 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 11:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avAX+/OzW/7HcLirrthTAM0P39+TcS4RJSPNxtTbX8FL24x6WVlkF7w+obB7wLj/tRGsFvkhbYTY622IPpgP6+l3d5W59LptEjD8yIljUPy8epNh9VUTEe+xTP/UVhNNK4hMwX5Aye8pG+lma6GVQiNXcuJ3xA+WFbEZ7k1wOv7bUZOMIxufdFVTcc35n/jr+CqLi5PqQaBFeyxP92teXNGpssM+dhDxmqyaMfx6CwCjdXU70Le0NHlSl9G/q+ke0K5Xum5jPP+DhHPKY4AT+w1HJ1Jl5411Eb/X4bLJegaTCJfKUzccLvraHAGL73IFM3DSiPJVJp84O2drUkzABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3/LA5tT+YYEvTgcayVM1MUXARJP7smBitgqFC71Gc8=;
 b=NxnEnvkqQlBamQchuYuarehesjWDuMmCAaQNeYPYmh+iTPKoO1j82dBs4DJPUoOWo5hMFDlOipGA7g+pcB8Yg33/kNGEcoH1JwrEJRaNNtZLkmWfodcZz8gVO+z8FKQgZJjz2cm20I6hpWV7vE2oPkWqfI979gTSZBKZGfmtyqKPoXlGPgYQL4fEc/nHbWWowkZ0CQsIndmEAIKbpAwHWHnNLllbHjq+8PbOEEy1zPBZWZLsJovV3RB14dGcUwlVbkSB9c8y+bA0OzxBHP4wl/XdDgjGjAeYqQd/6KPg6AxDfkOIXDJ9TyTcqDK3GVnvnnqN6XxFBVWVqPPPdl2pFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 19:19:59 +0000
Received: from SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e]) by SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e%7]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 19:19:59 +0000
From:   "Devale, Sindhu" <sindhu.devale@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
Subject: RE: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
 deleted
Thread-Topic: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
 deleted
Thread-Index: AQHZO9n7xhlxIGtjg0i/FkA3UrsejK7LogwAgAFUeoCADOOskA==
Date:   Tue, 21 Feb 2023 19:19:59 +0000
Message-ID: <SA2PR11MB495317E34938F8A4929F0C40F3A59@SA2PR11MB4953.namprd11.prod.outlook.com>
References: <20230208162507.1381-1-sindhu.devale@intel.com>
 <Y+kq5JZ6/BjZgy4e@unreal> <Y+pIgRtPanNmqqLN@nvidia.com>
In-Reply-To: <Y+pIgRtPanNmqqLN@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4953:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: aab32594-ad08-4cec-a9fa-08db14409fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxqavuS4KxeHYrmT9AKGOws0JxgmE7Eea660n/uwcTeTG/8ZA4pfcK5oybYRg2ZLuF4TpxGpD1mrUFRxsA5c3q5tia29TDR+5L6qKC0xygSjoplUOFDtdVL6GXbbLOqfXWRhskYexG7htKCItkWBLKaO7CwSVqByd1fAtKL1IzAeVh/80DpMY2yxDSeL1/qkX2bl1KrIfktbQ52j94La/08J0YvFf4m90/fl27ORwGia9QX9U9u5rJq0VOYzlmhVQrW1foW4E8rA+JCodovsO3XWBXU2g9Sn9vRQssn0KiHe8fxeynVmxxWEI43K7W5k2UJ/i+WdT6umoqDoCrl2oKBCh5rgWWYDZsaNvq1pumMxKt339uylhaaDT2AhsqAsK1Qcb7WHIR+T3hECgkJVBpGXZTDacTlqmjtlFg1gzCUJCvYwmLelQXPJr+1X4a5R52iqmaKg8IlyRvcD7mfClP8zj1TkA3K4tqAmTyQNHwpzjqq27fcD6QLKnvxpQD56xo9kIHsk6BLInvtVpmf8kys1EKFfo0V8JReF/PL6klbxOLCunD78jEU2V//ITvy1uuLYkfTBOjrr9LHY4FOnXz9erCRWUds8wVdBRa1hxFjdVcnGopLDfhCSyiiBTPUJ+UmRujVzuY1XRN2OG60PrFlwP+3UALdGSrtDk+MPS3dGtuCIDEULLHKWZmsLBpcU6A2YEh3uabM8N6cGvJnHBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(52536014)(26005)(9686003)(186003)(8936002)(38100700002)(4326008)(6506007)(5660300002)(83380400001)(107886003)(38070700005)(478600001)(55016003)(7696005)(64756008)(8676002)(122000001)(41300700001)(82960400001)(66476007)(66946007)(76116006)(66556008)(66446008)(2906002)(33656002)(86362001)(316002)(54906003)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m18F2Xrz8zfS5n9wE4WBlt0cesYNh7Te02D996Aebqz4J3GwpvS//mWzjq4w?=
 =?us-ascii?Q?7R0gNIvqP+1PYrcgtLOekvnocFX4SN2ioWCkCblioIeuqbekDeYxACUFu/QE?=
 =?us-ascii?Q?bbjm7Oh82tBrhPLtnJ/sG3CcIToACODnL6rYgbL87a+DXXQ6ZSXeVD4hKQqC?=
 =?us-ascii?Q?qxnEk6v8SCgUCGctCI8KQPk2H22D8RLKHkIw+1nvijjf/bAMhgHW4iT9fh5d?=
 =?us-ascii?Q?DdGt3z+F2sQKiO235QU9sjMFDyHA9qzpC9qjoJSLALxcfYNxtxvxC/5ZHHTn?=
 =?us-ascii?Q?b54mbToOmEySCBSgLlU52oDKg0U2cgheBKlKZgL4bgAiUkyV8JDWsvclPvZR?=
 =?us-ascii?Q?e3PBh4hzA5QCymF6TJrmuEV29na67TbHZsfFdxt700uiV3YYmQjgaN3nXOla?=
 =?us-ascii?Q?dz6HpGLyAewX0VYFTBQ+f+BQq6pNMfEFe44zpKC/VuPOaSKpgAQiFFMRAYBU?=
 =?us-ascii?Q?wHikA4PELc6Ou+Ry1RWdfGjbn0vxEUAM78GgPy/ZEgj45llI+Zrbo5aOrMJW?=
 =?us-ascii?Q?QYmGZqx0Qa72bqJeZ/02jtf0YDlfLp/W8Icro6qhD2WQ35V6PKLcsKf5C+zX?=
 =?us-ascii?Q?28mACJ3lOspAgKAVc5PdH6h3Jo3u+Nc45EOQyCScn+oJe3jjvC/n5IQq98ue?=
 =?us-ascii?Q?SBhFkGE0d00uKNZFbEMbSUe06wWyp+fRXv9s/3Kkbw6wkuLMAJ4zzl16B1jh?=
 =?us-ascii?Q?/n7HyqHK+6lHljam25OtJ/6xd/F1z+wdyqwNSPq1VwOViwc7G0tLzSBMpa3v?=
 =?us-ascii?Q?qKfNeMi4blpMoiwOsttlg8b8uK0za82wTNm228QBNQ/7IqUz2sBOxAx5jTlb?=
 =?us-ascii?Q?2Omr6uZOwWcSbTu9yi2e6erpDChHTpNmi7zCsG/RwPppHagrRuD6tilteezt?=
 =?us-ascii?Q?BZ9E0gVezkGuCNTX0MOthiSmKnv0WHcq35JIucr+3HaN4F8Z7KY+WNVAzHn/?=
 =?us-ascii?Q?0fkL9pMBZy/MrKBYRI6GlHUBp9hJDA1VWg6RR6Ilukk/K9Ym6eGVBwph3tr3?=
 =?us-ascii?Q?XKJj4mxOAXqHjhQvyR7dP4lhLS2eD0qHR7Im35azBvZDNQxAoD362pcZsAv0?=
 =?us-ascii?Q?rMFdwN1kmGrdW5PLBJhlIob7RUa6/0gR0lh92XJRbNok1xyQEpanroMCSJPh?=
 =?us-ascii?Q?F67yB0e7ImJ9lz6EjSrgBDrDOBbU78QJ9FSvQJxZUOnl2FO56QI8kLs88veH?=
 =?us-ascii?Q?VDYY/37/MV0yoMwMFl3QBrZ32+Vj6EtU1/lDrXUECFhQToNWQFCjy3ZrmqTT?=
 =?us-ascii?Q?oMP3CVl5xCsliA/UuNBPEZLrq0yXV7MrdCEYhWe7fZERueHJbdq0wLo5uCeq?=
 =?us-ascii?Q?VO2NFgsA/K21ZdJy30Y6X37KzoL1G2AaqvBMP00Xr64QI4TEETfGKhFM5PdL?=
 =?us-ascii?Q?37nkZNkcX2THW+9HwRLS950WA0vsFSZfszOgndcPPoi8EBbmBrtM6bdIjylL?=
 =?us-ascii?Q?SzXl3phJ6ySNuw+WOtzA3faqD8lfocyud/EclXRuvFM/eQnuX8aXotHWB0Gk?=
 =?us-ascii?Q?BEBjLjgf5EOHzFOv6p1pxO/oBXG1yZ/bUilMuVLyt8w6eyjBunuDhdzxq3qB?=
 =?us-ascii?Q?tbxYIZCK6kPD8SrSV83Dmjrr3vIYkt8ydyMnaSWD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab32594-ad08-4cec-a9fa-08db14409fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 19:19:59.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7Sux9L+rXXgpFoDRFjup26UO7lMOzto8tAh8y21GEg9R/Bp1Cc767UbsCJaojau5ygp6Jm8Xtn62h5wAbwmSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> Subject: Re: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
> deleted
>=20
> On Sun, Feb 12, 2023 at 08:07:32PM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 08, 2023 at 10:25:07AM -0600, Sindhu Devale wrote:
> > > From: Mustafa Ismail <mustafa.ismail@intel.com>
> > >
> > > Currently, traffic on a RoCEv2 RC QP can continue after the IP addres=
s is
> deleted from the interface.
> >
> > Please break lines while you write commit messages.
> >
> > > Fix this by finding QP's that use the deleted IP and modify to the er=
ror
> state.
> > >
> > > Fixes: cc0315564d6e("RDMA/irdma: Fix sleep from invalid context
> > > BUG")
> > > Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > > Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> > > ---
> > >  drivers/infiniband/hw/irdma/cm.c    | 113
> +++++++++++++++++++++++++---
> > >  drivers/infiniband/hw/irdma/cm.h    |   6 +-
> > >  drivers/infiniband/hw/irdma/utils.c |  27 ++++++-
> > >  drivers/infiniband/hw/irdma/verbs.h |   9 +++
> > >  4 files changed, 135 insertions(+), 20 deletions(-)
> >
> > Why is irdma special here?
> >
> > I don't see anything even remotely close in other drivers.
>=20
> Yeah, this doesn't seem quite right
>=20
> The GID table entry is already made invalid, this should cause the driver=
s to
> error their QPs.
>=20
> IIRC the GID table entry is not reusable until all the refs held by QPs a=
re
> released.
>=20
> So, everything seems fine already.
>=20
> Any driver support certainly must not be driven from new crazy net notifi=
ers.
>=20
> If you HW can't handle invalid GID table entries properly then add code t=
o
> the GID table handling path to fix it, not this.

Hi Jason, is the suggestion here to move the code of erroring the QPs whose=
 IPs are deleted to the del_gid function callback under ib_device_ops?

Thank you,
Sindhu=20

> Jason
