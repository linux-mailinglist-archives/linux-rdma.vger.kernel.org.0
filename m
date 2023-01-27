Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2067E9A9
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 16:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjA0PjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 10:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjA0PjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 10:39:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955351F914;
        Fri, 27 Jan 2023 07:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674833944; x=1706369944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UPkTDtGgLhf9brgHaGe2T/vFv6Na8Vt6zvL7w1Zf+6c=;
  b=XdvAKiNtOVi7Tog1iVTWN8h92M7JDDU81FWJ5iAMTxQg1Ewh25rNppo7
   ym7+fD5tCUzXw+ZgIK/k+49zFEt//Fb0/2aGDi5n+mzUuWbBHi6Nvr1GD
   /INhxugP7FRCdu63/S3/5NMeCAm+M9iHX4v4vXUOf2+kVtbZ1VBdtCBLi
   QcYcIkMGFhw61G8v1JbrYf3V/zXgmUOYee1EksmQ9Gc9oSrzjA03Kn9IO
   ZaPk1cAszL6BcyvSd2vVzlh+HAPRcZpMbj8uQUYoUJLQ1dHO6v5oeuBkr
   c4qQiJu4HrGFGqJ/30zjYzqSU+p6EBAopO8M75B2DJr9DeR53rr8vczJC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="324803510"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="324803510"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="695568442"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="695568442"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2023 07:39:03 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 07:39:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 07:39:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 07:39:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 07:39:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7Gic4qt67hHrtm+PCFZodqQseTGL5QSL6VXJ0jLvRrhXwPOWAvJtC/OWnK5D54ozTAnZbtpdXIJATZDIiIxe6/L1Qj8jrkLKaa5xvAzVjqk+VrZi1JHKgPl/V0rb2cGIytCB6EdLMYbjRH+S7S6HW3lT/tXBFKgv48FD6DGpGuiGElXBd4UCF6C4kZcsN/khCCld60C4Ou9AEdYAPQ2vv/hnZG+quCwMOT8f0WKGP2bD3GL/tII7zwUYdE6Hv/fLwGD7M4pFh1XxQUPnoSu8B0iejMPopvSaDG1HVkelfXEbR4ri1dO9dymLNC1wLFmQ98ATUzTuTwEF+r90xAqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnGQ0jYY7qy1tsDbDNH+e1s2ocDr7o0wec09/Wl5Le0=;
 b=VYl8iCn3GW1PEMOqiucT8xtbCFhNLgYyoQaXAvTZAK2V+8jlxiN5E5qZTDX60voEtOrEAgi5S23Eqj3vnD6quN9wdiiUv74B5HWLZkt4MmCP7yUYmgUeo+hm8hjAyGfTR0wzKbzMtoCT9m9x1F6C0MTBtOlmPCHI0510csIr1QIii+WrOik0+GLS7mL4IzMTDXfdNB1BxsedorBZOBDHtrO5b/Hdbp6eViKZLyMgUS/xcXWicCdP0VkzWPfCQNaJuyMdJW55ftxFNoTteldrMVhHGei5AG/tI1SVWzTxWWGnCtN3g3gVHXKcsQYoysJ5ItOG7EkV4rDcXaNYAi5agA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 by CY8PR11MB7106.namprd11.prod.outlook.com (2603:10b6:930:52::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 15:38:58 +0000
Received: from SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e]) by SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::ecec:1324:dd06:313e%7]) with mapi id 15.20.6043.025; Fri, 27 Jan 2023
 15:38:58 +0000
From:   "Devale, Sindhu" <sindhu.devale@intel.com>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>
CC:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] RDMA/irdma: Fix potential NULL-ptr-dereference
Thread-Topic: [PATCH] RDMA/irdma: Fix potential NULL-ptr-dereference
Thread-Index: AQHZMbdt9s3VMA6xBk2Hs2PupjDdx66yZUBg
Date:   Fri, 27 Jan 2023 15:38:58 +0000
Message-ID: <SA2PR11MB49535D7458DA7CADEAFEA24DF3CC9@SA2PR11MB4953.namprd11.prod.outlook.com>
References: <20230126185230.62464-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230126185230.62464-1-n.zhandarovich@fintech.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR11MB4953:EE_|CY8PR11MB7106:EE_
x-ms-office365-filtering-correlation-id: 9af9c6c1-19c9-4273-1fd8-08db007c9b51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uA3Sg7y/GWhoYZg39jdUE4a5Xjes8pJaz2GLxzxv7IdGYPfMNEZgdMGevLdfZbTuu2QfkppeM2zoWC67Oee6kiGJm2QH6YA5HCMCErrPy8k5XY/Ij7xaeGxh5I5+IuAV17gQzoW+aqautCMgx8UqyE/08oIPkTREggsJTMAWKeZ3QvXDK+y/F7g33wDICvimghaAbnwv1P2QOpSCm+9U46hOkFCo3VNFpijGVUQWRW1xwHoZy/EdJe3mfwvVfj7NI9N6INKwx0sJe8nocD9bo7SKQgGBAPbGcpM9Ujl280F8fy+PQcfc95r5DlG1uGPgS9vbNQ02AO+2rbj+kDVY2h+kfMVeg5gTXORFXcrNKdHGQ9ycB5MKcURG25T6AGafQmB4j2ExL9JmVIcqoZKoL3JjNSFsYA1Rrox3iKAkXpCptpiEQQ8Vy70bZZKdu9icPNsU6mzuhaljKUM0+sof9TId1J/IRlv9THqNgyN5kqWhxpEGWVwCnNBpWr8Iw1zWgkJCIqkAx280xSWnOgYWPKCJSW1x1RSrLTA4F7XGI45r29dHLSMCw9LH/GCTjxS/yze3emO6MnKdB+Y4i6TLvNx4Ii6WKO0aDZ03cdOz+YRsveVTVSdKWE466W6vxdymX3coZ/YxesAEo3aTw4W5nuLyxN8si4iIHqK6D0ACqw8LJ24QL2DxMWSO/SXVRO22hGeUsEk8ZI0Oh1uL4uCshg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(8676002)(71200400001)(33656002)(7696005)(54906003)(55016003)(122000001)(38100700002)(9686003)(38070700005)(110136005)(26005)(83380400001)(86362001)(186003)(52536014)(66946007)(478600001)(6636002)(6506007)(82960400001)(316002)(53546011)(41300700001)(64756008)(8936002)(66446008)(66476007)(66556008)(5660300002)(4326008)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b8U75mIu8N/uNt7sUE/FgB/+Pj9xdu/GPnIfLcASx/KwHv3OA3xiHBJee3az?=
 =?us-ascii?Q?5p55odYCrVr3TiCrZv2dAOrNtl4gLWJfLFjVUe5lvwWjZg+VToQy2T3TioV/?=
 =?us-ascii?Q?iVhCdOw7UR4I7A6dEa0bc95SA7kp3KPmYtLpDEOJyXE9bCSVJ4xw8FXofXMQ?=
 =?us-ascii?Q?1HJXzKtu/RlThnawsquYwffhPiHgZTZJivVoV6OISImPJlj6MCGyHTlUnlUh?=
 =?us-ascii?Q?/loQds0helcfaI9UTPYladNKKblQHQO00bc88G5OKP6K67oZZoWcUyi4X2y8?=
 =?us-ascii?Q?dAjxtXOWj4bxiTI7+z5Ey8chtrzflxN6mWWCzrg1t5X6rac/jkL4dff+u6dn?=
 =?us-ascii?Q?bGz9BdtzAFfQSXc9JeYImHFO2kBSpuiUW1jBbHBjwB2UYx0Tn5VrhPto5gIJ?=
 =?us-ascii?Q?5NKBfvyVKISiUgmO/c6Ovdns2INh2pSl0yV25u/YmYxHOdhVsorfIhaqHCio?=
 =?us-ascii?Q?vOdav46HPsv9tGOcm//KnyOeBdLxDG9hEU8ZXiJMdQmDkbn38NJhR5+D/F7G?=
 =?us-ascii?Q?sbjzEfIt+8ay1wCQaxhGME/4V9XsicttC3qF7iF4fezVYZv3d3SSk3mdgeQJ?=
 =?us-ascii?Q?ywPW7bV8MkRgLZ21+k+hzkUlGKvT+K+jp28Dty82jBZ2MUoQQ2zNtnF8aiXd?=
 =?us-ascii?Q?q2HIruDuDVH6DlG0bF+GeIOlKkVroeDFCzSAxVWsJlbqT6gcd/V+n9z4qpp8?=
 =?us-ascii?Q?OkfXcpU+SEPkfCDWnrjZEjnCUFY6hlFPpsp2RT0rvu/J7zuaZZeS8saX9ZTo?=
 =?us-ascii?Q?S5oBL2YlTKMaLCN4IIDrartYEk9UQ65+sPUc/SdcCkteKl6dnoxOKfXZVRAe?=
 =?us-ascii?Q?C3e+1f8WDjcJpY/kil6amX2aaPAbx+st9cFGDK2sMUbNs6bJNIgG8j3CCELq?=
 =?us-ascii?Q?YmKeCBHcHdkEY27cHUPjh9TQ4qHD6VRoluBFb8QOVTJcK5FSoOD3fNKe5apD?=
 =?us-ascii?Q?fGQx3Zvj338zB/zvX9jhRaF7e4L0QHzz+HEo1u3aEAKCgrEjIEtmA+V6/UWB?=
 =?us-ascii?Q?MX+3Y+7CWa69DBLbOP1crXXNLrXLl7IGCGTrVf4bBTPimMmqX/vYLCEMNIQ0?=
 =?us-ascii?Q?VY7GkLvQbWn9PRfwgfwR/Gr6J4ph8Zl8NF2GVA4hjDBsdIbG6uMeKa88/OeA?=
 =?us-ascii?Q?otU76+Qy/stbCxDlnSHasLm3goWRflDGJ1lrmcfmOYe4cgtvehKbPqP/4GoF?=
 =?us-ascii?Q?eNa+pGFwpDtW+DjSbgFr5Vr92idFsItF4cKnhnfaV1l1MlNx72jtbSheUhzf?=
 =?us-ascii?Q?SfHdPeCB64uvTnwyGc2y5aIqg+znwudGmBNKxRZx9DZYO8+v+EnnhmsOy6mB?=
 =?us-ascii?Q?CaVg78O9aHCqXREZNSnS4ybFqIMXDrDEoNtb511c6O/RrIZ42egnlPK5Nf2R?=
 =?us-ascii?Q?cQmhqVjK0ybHzk5km2G4BJTB7/chljS6JzY3sgAryE3TiQJ3/y+txPYJj54P?=
 =?us-ascii?Q?QO6seIbw4gSWzR+Fk4vc5w4Yh443U3xDwt+uY0IveKxvolxzvP58Ck0eABBa?=
 =?us-ascii?Q?372BBbjfWTg2mm/GYoRldelshDXsmaqzQcAT+AtQwXxUOZD9mW6bmA/T+lr6?=
 =?us-ascii?Q?YIv+3uBSkQdjxi2Q0yVz/0gmjhHMDRmNjo3dM8WD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af9c6c1-19c9-4273-1fd8-08db007c9b51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 15:38:58.4474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJFcg0KQwDrcC/Jw6nSBxABhG+eRd0JfciwKS0v4zvV3H2sQPaUAsNmwawCkeF4rXyMFjBF8MPPA6gbMxUJ4yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7106
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> Sent: Thursday, January 26, 2023 12:53 PM
> To: Ismail, Mustafa <mustafa.ismail@intel.com>
> Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Jason Gunthorpe <jgg@ziepe.ca>; Leon
> Romanovsky <leon@kernel.org>; linux-rdma@vger.kernel.org; linux-
> kernel@vger.kernel.org; lvc-project@linuxtesting.org
> Subject: [PATCH] RDMA/irdma: Fix potential NULL-ptr-dereference
>=20
> in_dev_get() can return NULL which will cause a failure once idev is
> dereferenced in in_dev_for_each_ifa_rtnl(). This patch adds a check for
> NULL value in idev beforehand.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 146b9756f14c ("RDMA/irdma: Add connection manager")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>=20
>  drivers/infiniband/hw/irdma/cm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/cm.c
> b/drivers/infiniband/hw/irdma/cm.c
> index 7b086fe63a24..195aa9ea18b6 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -1722,6 +1722,9 @@ static int irdma_add_mqh_4(struct irdma_device
> *iwdev,
>  			continue;
>=20
>  		idev =3D in_dev_get(ip_dev);
> +		if (!idev)
> +			continue;
> +
>  		in_dev_for_each_ifa_rtnl(ifa, idev) {
>  			ibdev_dbg(&iwdev->ibdev,
>  				  "CM: Allocating child CM Listener
> forIP=3D%pI4, vlan_id=3D%d, MAC=3D%pM\n",

Change looks good. Thanks!

Reviewed-by: Sindhu Devale <sindhu.devale@intel.com>
