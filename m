Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A263FF0DF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbhIBQOt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 12:14:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:56610 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233599AbhIBQOt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 12:14:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="199397373"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="199397373"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 09:13:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="499874370"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2021 09:13:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 09:13:48 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 2 Sep 2021 09:13:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 2 Sep 2021 09:13:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Thu, 2 Sep 2021 09:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkdafkrdaPXWjd3++zH81SCqoVfzK7NOHQFsOL46ajir257tZsJF4g1tJUAmUxq/PHeQS2GeJSZLPBrVBnlz+aoEYO8lx1Op/bEV7ZNq8V4kzAvX+XOYltIHZ9cdA50Enn56S8mnklCp6STbvfs4ZnStGMMpoXrneC1Ac5WCFxlFh3t5GeL7Wz8p9nzdH/q+SB379y8oHw/73zP8tpE3X8bCqTiT6fnZM/2IQ8T3tQrNoMzSrUdn3t4JNsJRsMaLCUN1kW9p8RGylGlBJSFJ6ESoY4hKEjQrG6yqMCM+f5gkfBSkw3xAgqi9TZ31g764ejjQCF4tHIHlARMd8DJZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=64xLK3ezoBV66H428AvNQZgPX8yWxMTFcGe5BT/azrY=;
 b=bnUCG/VtRLdIYjA1C2W0Z8Nh3RyYLBXkCz5SrtLxmTnFEkQ412fZUN/1BxBnxLHlceE5tw4DGj7SbaHA9i4PNecM/ZREBGQGlDbzn4SBGH7mMqcXtcL6Z0uJNNApBnY1hHGpbJEveNZdwaSq73H3FnOjAMmn2Plqe5DyS+ZqzT8WsNlMS+YdjfdY8H6CLxm5s/Grsxu2RLs0agDSALfFIfs7Lwqr4iln/fJbE5zYJeP0pkmrlFm54AKYi7pdKwbhickZHLheDREwZXV2rSeZ7fRTYnNnADCo1F2cLQq8mrSds504/KpVpGGCim8uk37FqDdgvShYMkFfAPXwyqx3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64xLK3ezoBV66H428AvNQZgPX8yWxMTFcGe5BT/azrY=;
 b=oI16iN/LQMwl+qWrkXUANkWlX+7Yvi1KKI4ggv/KqyRblBkgtGNX1WIt2XY15NViPiqlkbvPfqzTK8W6qZF3pglkqwiVH5xf4q7blQowivRDozuVlkMk0bOaU3EsHWHzdj/p4aorZwb+ZTLeoPxlHqnq4hGP0wOmqzpQZY+Z6YE=
Received: from DM6PR11MB4692.namprd11.prod.outlook.com (2603:10b6:5:2aa::11)
 by DM6PR11MB4155.namprd11.prod.outlook.com (2603:10b6:5:19a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 16:13:44 +0000
Received: from DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32]) by DM6PR11MB4692.namprd11.prod.outlook.com
 ([fe80::31db:f34d:bdc9:8f32%7]) with mapi id 15.20.4478.022; Thu, 2 Sep 2021
 16:13:44 +0000
From:   "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Topic: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Thread-Index: AQHXmDZjOykQbRhbB0OylwgVwYR9l6uBQpMAgA+prJCAAAtggIAAAhuQ
Date:   Thu, 2 Sep 2021 16:13:44 +0000
Message-ID: <DM6PR11MB4692524C197F055A727468F4CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <YTD1vWjFToPt7JLC@unreal>
In-Reply-To: <YTD1vWjFToPt7JLC@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86e5510d-73e0-4d21-23ee-08d96e2ca32d
x-ms-traffictypediagnostic: DM6PR11MB4155:
x-microsoft-antispam-prvs: <DM6PR11MB41552A274031EBF0521A9BB6CBCE9@DM6PR11MB4155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +UQwJuLNSBE4JrWHShjoLzD37Oj+6KeVUpgAMsx7L/zqao0GAjVzNYNMwolyyA6o9oA0kn2XBZa2nP0r2EMsD8E5hj8yRUHs0Jq7XcL9JKE6S+o5PiOBHSu9YnEB64WJIRjYRt+ZCpS0Ng9BK6/2HYsUPHRtvobZcvbMlqdVjpcqnAgiMQXlC4JXrMZJ+UrsjxYfFcv0E3nCRXyQyWG/VbM34GYnhpCT4Pt6bobF3reIGhhZdn72qoD+UxCp/7/MdhBi3bmO25GqNKRqxUyMxtYdXkNEeHgH7u1g0yB6IV9kIGr/ZZNVKAxODAz+hdaWUikigIgRkYuavkn9hSXOzryPXMqZenvr53nA0Br3Ug5wN3FldmezxJQI4aXEUEo8Pqho83NOZafS70RPvbEHZt/6igtPgp0OTBW6CbDz/R/BHx3iPOk4PPYJ+ee7E823dnnhZZdl2t/5tBupL9O04io1vDrqt0ql9Ms86mz/wz114WxNhsrfzcmkRCPCVWXWH3MK4FKejonBprZVvGtljr/5tFjPrEgwVr7Qaefrw6luWgqK//aP0Y4wG+HVLe/SVpBkTKeFhF9DA+gTn7LXT+YkIMtIf8azcn2SNhD7EfrCWDhDET7TDrklt6cDHMDPpQrQvj3D/mUcrtzjIT3NIyPjJSZyF2ctwkmOKU+MlnIzxiBX9j8eYF3lnF+YBqA8yP+BeLT8d0ORh0ellChkLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4692.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(4326008)(83380400001)(6506007)(316002)(55016002)(66476007)(186003)(9686003)(86362001)(53546011)(6916009)(8936002)(8676002)(478600001)(66446008)(54906003)(52536014)(2906002)(7696005)(33656002)(71200400001)(38100700002)(64756008)(5660300002)(66556008)(66946007)(122000001)(38070700005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?957nx2XQOMCB/k7i5NbLScqrwQ5n6o3H+L7UAqoTqe2Eqa49gGKCeSP2IUuS?=
 =?us-ascii?Q?g4JCQkJgX1Id/HNCq1WPMUweAo723QsUo7dLMiLwMXRkWj5oXXUGMo0lQz6A?=
 =?us-ascii?Q?6AzOAWDbr+dFm1mhU+Pdjn2MxFIa1hvuh2KpxKsfM8SNRKZuqe+VPdR6hm5X?=
 =?us-ascii?Q?dz7Fqz1cXXFVrVJZE2SwhyfIgPen28QMF+XvNtQfBReIft8ScqEAuD875vz8?=
 =?us-ascii?Q?0oOIrY4xbPgSSDXgs6RvzCcwd4D6UBSL7FPq2tE8SdRziPlos7sv5nkOGhGq?=
 =?us-ascii?Q?5/ouBs7Tm3SnWh0ocG7exYzsA6dxGwEnJgzwSv8qUOBG71MgMo3k/rojuymH?=
 =?us-ascii?Q?uP03ggyyK4W+zQX9mOJ7Y5qx1H01G0A5hszW5JSwBzKDOQZXglqkmDt0mxuk?=
 =?us-ascii?Q?FtYJ54ec7ZpAzvuJDBzT666aCZVwRpEfyvs6K0pkbtjnga+CU66W+1F6O1qT?=
 =?us-ascii?Q?AiRdOn5Jp3vfA4IjhcNj+/9lShVnmszSliXAjy1pRBP+rn1vOCFbyLx2CFp1?=
 =?us-ascii?Q?adQeWq8bd0pDNaxouSmpPqRgszL3qgzD6lmw+3OUd8Mi8emvlHMKrphJDIk5?=
 =?us-ascii?Q?mDw1ndQAlByS7VJF9EWwsJWgcCLGhoNi93i8EME7ZPwQkKGqIO8G0j76pumw?=
 =?us-ascii?Q?M7uAbkJ4me0Pxjhx68w3TvjkHIGyekLjeZ2c3F5tDXZp9OA62QB7a/e+kmKe?=
 =?us-ascii?Q?xITte2EoLB0bBWwldLb/oFORm28diAepOAhQ2DTpf+9GXDT/DS2/DETmSuhw?=
 =?us-ascii?Q?2Vn/AsK9nv2K7MjeI9cYGqeXRbapUIEdVFATKDVH4NurGxPdoHVANznF0MlD?=
 =?us-ascii?Q?FNLXkYrIJt2GvnV5C5ET6SuJL3n/PDwa0D2AGJ+JdOCLAF20CsxivJeHjnEc?=
 =?us-ascii?Q?n9IOh1QoXiLq+mntGCSH4zGL8EYKsV0bRqhNdI7cyeYpLeLY/0yMDGm5rkR3?=
 =?us-ascii?Q?GyzfZy6HnO5tTekTcaCzraH3pN+GIsGv+KcN1qM82mRdMXsrH/+UvuRbGzxa?=
 =?us-ascii?Q?jCRfBq7LjEqpqEe0RboGWJa29PNy0fOa+e4KPrqht9laHOIoc374aWiw0ZQD?=
 =?us-ascii?Q?eOk6hf7Nz4jba38ZbVEUcyXeakFycXEYirv8md7FMIKaiRJCSQFvmUGIZb5B?=
 =?us-ascii?Q?5MqBnwcsdlrYRphYTwFp+uhaAJzjPD/sBqq9mGBsaVfOQouTc8pOaLoZ0x/r?=
 =?us-ascii?Q?Uumc+byXK4V9gtVckHO2u1cKW40aIKlPHL1ZsGle0CjB8TiF1Jf1MPhnygPc?=
 =?us-ascii?Q?7XvX72mun+eP1e7FovQ1KxIFSAuBNnHfYIMBosSx0eBfD59q+aYz/Tlq4ifP?=
 =?us-ascii?Q?/9+46mrkx+fyEKSGdxoLJVeOP7CF1vDaIxvB+s59i1BJbxV7UzqouONF8bVo?=
 =?us-ascii?Q?68EIHxovBKRKyGEMul2QJU7gJLRp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4692.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e5510d-73e0-4d21-23ee-08d96e2ca32d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 16:13:44.4219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZOZ69Sd/vg746f7l/gU7V+gNsVPxNGSMKvSCCZJ6ClIvVzsgLdVHKrCnkHR3RhA4bOnigF7ndrKHK4cEZe0oOsCZIlVtDghHYkpbweFv1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4155
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Thursday, September 2, 2021 11:03 AM
> To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; dledford@redhat.com; linux-
> rdma@vger.kernel.org
> Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> rules
>=20
> On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> >
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, August 23, 2021 11:11 AM
> > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to
> > > kernel-boot rules
> > >
> > > On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> > > > Add ice and irdma to kernel-boot rules so that these devices are
> > > > recognized as iWARP and RoCE capable.
> > > >
> > > > Otherwise the port mapper service which is only relevant for iWARP
> > > > devices may not start automatically after boot.
> > > >
> > > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > > kernel-boot/rdma-description.rules | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > >
> > > Given that ice is both iwarp and roce, is there some better way to
> > > detect this? Doesn't the aux device encode it?
> >
> > Hi Jason,
> >
> > We tried a few experiments without success. The auxiliary devices alias
> with our driver and not ice, so maybe this is the reason?
> >
> > Here is an example of what we tried.
> >
> > udevadm info
> > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
> >
> > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DEVPATH=3D/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: DRIVER=3Dirdma
> > E: MODALIAS=3Dauxiliary:ice.roce
> > E: SUBSYSTEM=3Dauxiliary
>=20
> Everything will be much easier if you follow my initial review comment ab=
out
> auxiliary bus naming when irdma driver was added.
>=20
> The RoCE device should be:
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: MODALIAS=3Dauxiliary:ice.roce
>=20
> and the iWARP device needs to be:
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
> E: MODALIAS=3Dauxiliary:ice.iwarp

Hi Leon,
=20
This is what we have now. We just provided an example with RoCE.

>=20
> Thanks
