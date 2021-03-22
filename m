Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099673438F7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVGAw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 02:00:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:47433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229613AbhCVGAl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 02:00:41 -0400
IronPort-SDR: 1gbbWzWoDKWyRCP+0TSa1Wt+5z6clBbKaU5HOKm8Y6MiBn4EiZqF+6iP02Mo46zqlmO91vxwzG
 MkTbO4cJAPXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="251561197"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="251561197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 23:00:40 -0700
IronPort-SDR: 0/3/Qz8fHQE+kvcr5oVyU4sEN0TSRZZwMbL3rt94BOP/SJARxQGRHeQZS9vyvC363TeNkqNpf4
 rUmtD0UaUwqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441021069"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 21 Mar 2021 23:00:39 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 23:00:38 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 23:00:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Sun, 21 Mar 2021 23:00:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Sun, 21 Mar 2021 23:00:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1Dli9rF3L+HH0SgDpqKjiLA21Yk9X7S3SNeluSJvKqgNFXie2oT/3uaclgeFJyHeP5fSaxUXDhGN4PwnB8hObjA1OEbij9apayvLbYxFFYLbYyXSDCTnIYpFzYca79bjVSRkLgpOhrOKKy51hZn5PzLJoKhyU954kTaA90mHEdZIfHCAvLwEiD/j3DvdksbrzPyxYRfS1oLzCsxKKUvUxmCGbFleg8H/20nF8pBnZnTHBGGR4OJL7jESjnMQlSg6CP42v631h0QqhKtJO8TQqvIZjvQtnlq4TFgCUAZCSzUN1lAvv1F8d0k2mMYRGqKeIeBTZrl5kKiWlm5jGGvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ2jeWKV80VYKgtNwv/Dg/SaGrUQJI06swjbggQkLbU=;
 b=HklNsoZ8Teoda81qrxClzbFgRb0AV0A1IFoyj5xbzyrHkn0oG2A0poMXIvdZRPdlavus1uJUtmoUlau7tX5fO5LvStMzP9wInw0KtH5ExHno08BglMpFLCZaxiWyC8lpYbA6KxyLvxi7wdBK9Gw2Gr11UU7Zmo7Uz62FEqkFZv9cq82LcYNsUW/b6rR17lTFRxcb4OKfGfzidGoMnf8xxD1vW91XkjimV+EfLipElwanwvPCOxj1sBAxAQc6yYg515sEXQpyJQrCnZxf4+dgLjfDEzr+awzzoDUOKHJRPEO5GbF5APwsXx7Gsw9a1Wc8inP7eGqLIbDiNsMQ4UxNig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ2jeWKV80VYKgtNwv/Dg/SaGrUQJI06swjbggQkLbU=;
 b=XtpCtdnXSGMiRP/EuBQF/O8xIvj/5QOyMu9uPP/Hhkm1UFF6hbnEXhnBHkA1jzTwEqr3/AoPwsqNmCmyoCCff1qAAZPtJ4KEmF+sLzhTdKKFQeyiOte4oOyEItSVEDLOzDxvsA+xhQ2TBIeJaY+Jku62IAMRB52aI0jRl3IfY8o=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 06:00:35 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::29f5:c060:e3d3:cb47]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::29f5:c060:e3d3:cb47%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 06:00:35 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     liweihang <liweihang@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [rdma-core] Compile issue with DRM headers
Thread-Topic: [rdma-core] Compile issue with DRM headers
Thread-Index: AQHXHJv3XGIQP1y/YEuHT1qgEOdOZ6qLgRCAgALbFoCAAD8/gIAA7BmQ
Date:   Mon, 22 Mar 2021 06:00:35 +0000
Message-ID: <MW3PR11MB45551494FA14979B4A0D8E50E5659@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <d204d1db15844e45b946125a5452ab19@huawei.com>
 <MW3PR11MB4555FC2C195C0AAB5D804326E5689@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YFc2348DwMqm6e3r@unreal> <20210321155317.GD2710221@ziepe.ca>
In-Reply-To: <20210321155317.GD2710221@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cc71ede-10ba-481a-48f0-08d8ecf7cf85
x-ms-traffictypediagnostic: MW3PR11MB4538:
x-microsoft-antispam-prvs: <MW3PR11MB45387037E330F15DA59E988CE5659@MW3PR11MB4538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOimIDYXbqp4bQWbLHVr+J+HIcSZvkX6XpkrGmhqv6ae4+pqpXiG29YKguA0svLEeXkYXpvomMwUUseSTRvk3kqUIDnUulg/2yOlGQyPnO316F91+hcHi9ecRLqhzqZHWUn/Lh/jvmkVcziWjiB/SGeAHX0xScOZ3KVbJrEelXP08XXu1zOCGttUg99TkbXh6zZ8Q3QVjqRMAiRkc+wblSmeDfMQI835l7J6MlP1LCde5TWctx8RNCaJO83jy/6H1E+vas8w2rfs+OoFMfQnjzy90X5M+ui/5MmYF7rC6CkLKq76qVgPfBLbOVpWq9ssQybLECCu05SoMFvI9XXMDMATBtK/mvSlsP71i0XlzBZ3A0anTXKCgdlmGFaEQip3HJOlNWuztI7meyXpGyImBRRGsAmy7FDBa3s3tUFbsu5EBigDblpnrEDemGNj6N641Uha/IUZLG4Qfgs3DiVaBT0Frx0DpFlfokab34xxGSMrids8dmkol3qBttzS9y/QxDFErXCIm8T05oQz9Kx7jxTsPdP78DkLwtrI/IE/7uu2g2U2GshK6faoslbMSRDtjYWyNgrlbTsvaQyxwx3Tl7r/HdfpklksHXv3TM+oohN45AgyAEhxa73iQmhTqJCyZ6tCkRrps7aUKpHuyTv8zu2FOZ0OGl0ITKCZUzVcyh4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(64756008)(66556008)(66476007)(66446008)(76116006)(110136005)(478600001)(38100700001)(86362001)(316002)(66946007)(52536014)(8936002)(54906003)(4326008)(5660300002)(186003)(8676002)(26005)(55016002)(9686003)(53546011)(6506007)(33656002)(4744005)(83380400001)(71200400001)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QstApUYZsrB/ZFPnqhaPcOqZ8o7vJ2dno/Lkerp/U04YkkzH3ZAt8RH86lVm?=
 =?us-ascii?Q?RWz/ZNbLJnrpcrk0dQirVIn/xkPd1swppxmRNFNbFG8iLYlsXtUCGnrUxKCb?=
 =?us-ascii?Q?Lw4PhSrrbMiAF0X7IncGcvMXNzNy4z6TPaXTFyvAv/YBKSJpZ3XT9+RtcKrr?=
 =?us-ascii?Q?/90c578lDabODqIPX+i3vIs9LeF4wUMuSO/dCrQh73cr7HTgtRMGn1IM6qv3?=
 =?us-ascii?Q?E7VPytiSQtiUpksWVTKTfvi412r6YgI2sqm8u86GJLQ/DjBZCtppbwqJ5s0/?=
 =?us-ascii?Q?y6meaBo/H7ZS5GuIt4R/12h1S3cAmSGTK3gC11tWzul2QEoDTUmzrrnronfA?=
 =?us-ascii?Q?iPDRQe5mgwrUD6OVN19mzXyZn6cahImGitb0PU9jKyoWGrVYKfTzBzg6tOYE?=
 =?us-ascii?Q?m44s3auQ3wMpJEnSv9gTv3n9I7U6SsvZ+q7gLr4JLjGib2QFZ2FDVsUHDrsk?=
 =?us-ascii?Q?9TgtMDVL+wH1vVcAPy3VJJ4zoQj8T6xdT7pOLdPor4vwpM+eqRH+3xNNmoU6?=
 =?us-ascii?Q?o1BlASpbwBgxq7zj+ZJraPxmnwEklvfZ3CqcdkmsirDqkQGtY/7inevrv9EE?=
 =?us-ascii?Q?tIwLLyNC8F7+XwOkZ/Y59V4mbZZwC5O8vqqbGddoskTkoxjIHf+/EyXTuxKv?=
 =?us-ascii?Q?Znya2jmWgwhcDwpjrjiH3rZcIZf326C27vJKKLX25Q4uNLQpruBrbTFd4eZD?=
 =?us-ascii?Q?wr5a6R76XlpoKl5YOfaVl5IrXTovn2eihfCozK9SXHj1/ReNMnDxwjh62wZ4?=
 =?us-ascii?Q?JWbIErv32GLGwrwphFQi5s4Mk0S0mURY1cEJbimSfIL7F+CSz4MrS+QN5iKn?=
 =?us-ascii?Q?Or8K7GaPLH9vMbgpqBVhLTKEWFF0Ee+HXo7m3PxnQY0tlNms1ujCiFV3KE9G?=
 =?us-ascii?Q?bw9v8XklY3V8WCFdRHvlstPilae9YF1amHWISt5r+2M93PQDfyvn5oRHUq1Q?=
 =?us-ascii?Q?wZJ81YzK3BrXfpFVg7uy6qSAEFMic/8t1WDvjNFViJzeObxIWiOSYyPQIAe1?=
 =?us-ascii?Q?lf9sKaUFpgxE/hdYAkb8yG0Rs+Aie+QuIw2yNBaTsrUcVUQWJ6eGiwGS59ii?=
 =?us-ascii?Q?3meBkfBYPXG2+SZhjZ7bYISDYIZYcCHb8pF53OG4jkHGwFVqugzE/Sa0ms1k?=
 =?us-ascii?Q?89G3xWZeP0g6PzFRnWe17cZYGX1IPcm4zvVnhup2Jt73rmLaQEEZ1cBziA0D?=
 =?us-ascii?Q?y+MC83cK/myTswGb44r2i+u4jiHZ33AFm8/d3qzbjSOGEZ0GBS7+B0fmlXtX?=
 =?us-ascii?Q?ufeW7xzufoYWPcYWS2MTHPmuAsWnOP0AlrKFr5e/fnV9cW8UCuBlUOvPUNFk?=
 =?us-ascii?Q?VT8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc71ede-10ba-481a-48f0-08d8ecf7cf85
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 06:00:35.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCOmym/D8vu65TL4nxp/641UTxiaHzt/x/71vULYR+5wKdA9+1T0U/txMt+hNlJdaYR4Zta0FYzaJp5bMwrufA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Sunday, March 21, 2021 8:53 AM
> To: Leon Romanovsky <leon@kernel.org>
> Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; liweihang <liweihang@huawei=
.com>; linux-rdma@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [rdma-core] Compile issue with DRM headers
>=20
> On Sun, Mar 21, 2021 at 02:06:55PM +0200, Leon Romanovsky wrote:
> > On Fri, Mar 19, 2021 at 04:50:53PM +0000, Xiong, Jianxin wrote:
....

> >
> > Let's add compilation test that checks all those files at the same time=
:
> >    14 #include <drm.h>
> >    15 #include <i915_drm.h>
> >    16 #include <amdgpu_drm.h>
> >    17 #include <radeon_drm.h>
>=20
> Yes please
>=20
> Jason

I will work on this.=20

Thanks,

Jianxin
