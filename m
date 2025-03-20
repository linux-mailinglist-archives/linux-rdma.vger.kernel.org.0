Return-Path: <linux-rdma+bounces-8883-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733CEA6AEF3
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 21:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E7E42415F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 20:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616C227EAF;
	Thu, 20 Mar 2025 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWi0bb9L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ABF2F28;
	Thu, 20 Mar 2025 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501110; cv=fail; b=GlgwMIxL4o0hK6oaAsR+EAOyjOyYujkHwVjw9ufusP9rYAYIYbfSm9KFGze2c+f9xV1lPRn8kHAmWCmIJSlfzJArnUVSRR0CnUGGTo0tUe9dHVh7Q2LgyVtpiGmOO3DYi6/zau7neAlIBtAzwR/lbSBJ0y0CQ2ZbLpnugtaObj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501110; c=relaxed/simple;
	bh=Ogu1B+5lBqFIkzp290fA0pU0WUWJrP27tPyTtETgvc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVMqWmNvnqOcIu+W9tsaOlUTD0JJ/WOfPhAxM9naQTnKkTPFOzj3q8NrP9u/dOgecELYuezQpMW4IdfqKIF1ueZi07Z6U3ozMpa5FfTQjLGZHS4fxuZwrpdBAf5BG2MPQQ2QWlPZhTaHJrCIozz43TFflNkdBFp6zp8fpYhNWyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWi0bb9L; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqwobP191P0/hFtIP6M76UL1F9OFj/OWrRtpRrMQt1q9CIaM181qvxdPQj8PAziSDx1t5tVRltWlQ3Z1+CSAcuypj8ovepUrWeGwPAtTd+2bjOkVuY1bUSuo4KaFvTt0/kA2nsZOQL5GlFfRBor93h1OGHyvV8X1OIRHDzexyPntfJn+vIU7ojvqLu7fHukWpETbydcENFLmlfNIJNR4FAAiCPZs2k1rO2mEe8dippp6w5Yr67BFe//AJMwIZOSls+QMd44mSWK3iMaQvEwPV72YUz62/XBCn7CvYJdMqiShHmqQpatfwvz+M0WO7tV9Msd86MiJwjZ8snZpgxXVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MYJkytrjCsnRH0jHgII1NvXGI3LqQyrNtrh7OQ7wFQ=;
 b=M2E6GiXLUQCTjbgrtT/IyYjwyQUnFnMjRSwDeq7PMg+KE+6NTZArgz3UpW4gE4ybyj7EeXS87l8+fGmUD4kk/6pu6YORF7Do22XMnIw2/YPfG2GXKkVTX3VBRWai9VkWmW8gsHZxPOTK2YVHm7wlibZTkHDr4an6psWchHrOSd2ubkfvn9pqI8+tB5LxtDbnXo36kBJxHqkhdpLaPoP8JkXOVaSuKvIcFUXtzOLt4t/sevrjNLyi95VR1diA85FWhWScgc3OFEHQzhGscoLW3mvQQ36pb/QS8Dc4MYYMbSOQyK8tDNwvnL1Bj42e8A1yYl6ScJCgyfLv4diOhRJGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MYJkytrjCsnRH0jHgII1NvXGI3LqQyrNtrh7OQ7wFQ=;
 b=CWi0bb9LbYjNp063EC7S4wPEXCFNMUOrzr2Pu/9qclBcwh6yee+5HUbTrDwHG9s/efXC+VrNl5t6Dspp+wJIPiak2cMD0TpTQMRAbTgGICxMvWdBeR0M4FcrhCS5PK2kHYqVNCA0cqp2hkXFarqNbLiDj4EuF2gK2A0AaNke1t5NgD10qLUynBQyVNxmcmAZaJv3Z0DlUgcwhanEr5H/MftsfcAYYmMzW40JSuwZc4LJpwtffZTBKQmL7bBFKZrckR+0irzy/cgyrE4z8jsI5+yieR0CP2XSRfHqBEkqlvKlOuRLUQ8Y2Yao9rArdU24pNMj/yqw7NsVajMkTlzX8w==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by DS5PPF1ADAD2878.namprd12.prod.outlook.com (2603:10b6:f:fc00::646) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 20:05:05 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 20:05:05 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Yunsheng Lin <linyunsheng@huawei.com>
CC: Nikolay Aleksandrov <nikolay@enfabrica.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>, "rip.sohan@amd.com"
	<rip.sohan@amd.com>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"bmt@zurich.ibm.com" <bmt@zurich.ibm.com>, "roland@enfabrica.net"
	<roland@enfabrica.net>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, "kheib@redhat.com" <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	"davem@redhat.com" <davem@redhat.com>, "ian.ziemba@hpe.com"
	<ian.ziemba@hpe.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, huchunzhi
	<huchunzhi@huawei.com>, "jerry.lilijun@huawei.com"
	<jerry.lilijun@huawei.com>, "zhangkun09@huawei.com" <zhangkun09@huawei.com>,
	"wang.chihyung@huawei.com" <wang.chihyung@huawei.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAE0uoCAADfYgIAAOC0w
Date: Thu, 20 Mar 2025 20:05:05 +0000
Message-ID:
 <DM6PR12MB43132490CF7D1CC16AF6D42CBDD82@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
 <20250320143253.GV9311@nvidia.com>
In-Reply-To: <20250320143253.GV9311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|DS5PPF1ADAD2878:EE_
x-ms-office365-filtering-correlation-id: 66945909-0e78-434d-a4f6-08dd67ea81c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bnbFBCAMvPQBQg0bfZOwcF/Rq+4QqcZdAEzuLp05kuSx/o+7pybonvT+zQOa?=
 =?us-ascii?Q?QsMeSG8ID5VdxzHGo16G3cdOwOllRoB6HOXNlkDaiCL2IsJoAEM56W8ry0fA?=
 =?us-ascii?Q?B7Q8hhF1AX4D+vUZ7WfgqfeIT4ET5BD/m1yiMTRZ34m5yln+UIGTZwltOtrQ?=
 =?us-ascii?Q?MxicdJ6x/E2zznZM/VSJRj6HPbQyfxO5+yDxUog+ccB8503MjfZz6f17t5EW?=
 =?us-ascii?Q?QrX1b69AGxR3B13k5ECBzgcA6ryJa3KYkxzLnC0dDjk7GLZdNY9ITOA/qtYK?=
 =?us-ascii?Q?IOZu2T5JIBMgzo/b01YZnuHZ3jGC9f00m0AZlTOBQYQdGPS+/SOKBEz/kwa8?=
 =?us-ascii?Q?IrHth7+mWbzr0X29Cy7Yl1JOuYXvrNTGsCx5ZWckT/NFVeyi+ZdP/Zo67Rea?=
 =?us-ascii?Q?ukIJ/fIf5v7r0lFVRQm6+HA3NaBfwbmQDGzRa+stgMTQCbFHATF02usIe6LV?=
 =?us-ascii?Q?NVVx40KzBOlUBZabyKIvymX6EfBSZYSk4fA69ptOL7KEWlohaOkqPvwGjZiS?=
 =?us-ascii?Q?ROW6KDpkHSwI0HUICWDr3EZ2768krwdVFUFnGwL72hBgozKc7oMk3mUx42d/?=
 =?us-ascii?Q?bprDJd6ZC8cNjTKthOejWZtZBU0InnTQynlrsiEGFnWWZ5Q3dmV5Y3mg03ib?=
 =?us-ascii?Q?jBQhgdh+4eCv8Ji/x4H91VsSY027TUfw6Z2DRMm4hNr4P8g7KqA1cOnXQuQt?=
 =?us-ascii?Q?+ReqYxI2Im1imp9SOzReC+Z2ZePONc1GVeVNjMaJ9FYar6zqA/noyKxnsV38?=
 =?us-ascii?Q?Jv1I4f25nbdQBmzs+T3kggBtOTww20E0hQ4K+yTMRkAW96kGk5OFFdzA/jIl?=
 =?us-ascii?Q?GL2XWQgeTOelZI0hD4AE2hecSis6MsbeI2CJ94u3yOunmOH5Nw2sC5/BwDOU?=
 =?us-ascii?Q?QaupHk/CzKDLiZBR81pLduZvRJN/UVr8IW5a8V4dMW21S83neexNHGj/18om?=
 =?us-ascii?Q?CBos9gysgfWwtF+wjiJWuR5HzWrQC/tGxGM6ebWQ+wEPhrL1hqSFdoh0oI/i?=
 =?us-ascii?Q?jMisuqJOTWS7X9isRprxK0ulQitIphNdvsL+eSFs2kgwUht50fTTLy363hlq?=
 =?us-ascii?Q?mLFC8bOrO0mHHqZZw7xcb/SNhiQSmxtj/wPvpw/ZTRM6rIRzaZY+N02BM37c?=
 =?us-ascii?Q?yW86P2GvBbsqKmfApJmnoYmYf599U9jxjbAszFyf38jwa4wLsdlHazULnWya?=
 =?us-ascii?Q?oosgkKiy+WGk9YIJ2lzXeboSyLgodrnUAwQ8GziuAxEiNeU0PcPu64QEBGag?=
 =?us-ascii?Q?LeCxvdTAx6O7sTdIXgV0sY2IVI68CHEBCunR9M9/zQd3Cn0qLzMKiLD+6gV0?=
 =?us-ascii?Q?/J/a4ePNT0xY403LjqGiMH+0jP1m/75oyd38m19boNENO+YxAfEn/v3y39Zd?=
 =?us-ascii?Q?L3k6GGfMnL+dh+wEBZ9fH42RTPIhrcijcrjXwGjiWchXItlDoS6URr3F1Ql0?=
 =?us-ascii?Q?kw4+lzGawXbXC4eReLmu/v47hdTcicns?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1GoeeanHp/GR4HZcfHj3k5Z7+xR7Ib4KQkdnAmas4tx80p+fKzwpj3PRVPBX?=
 =?us-ascii?Q?jQplqk/uxg6Zk9n7I78103HGow/vKpl7P43K+l4KggqUq48B25Rfrdhy+VZj?=
 =?us-ascii?Q?eJNVvlNp3mYeH9aa6THkpXelF9IyRjTEvjfA3K/xLUi80E66zGSHD/jj+Bx4?=
 =?us-ascii?Q?0fK0oALqA7ZGI4ZWQg5SpaTZVHK49qDME/3FiCBt3F9QQ1XZNWM3zTfjEMWI?=
 =?us-ascii?Q?oJZBUWuSsEEreqqNMwQcwMI6tkR4mbSNFsJCAfaxB29gHJH2SkjhbylEd3kj?=
 =?us-ascii?Q?9OINUfzZ+ukN7FCVAKJdCL88tBhn5XxkNFsBAGYfLL/9uaHWnkUe83y4zgM6?=
 =?us-ascii?Q?GGilXZa7eC+xB84s3THbDJrDnUvA3jcEm7jZP0jXFceOUSh9zsDAIx1CF1Fn?=
 =?us-ascii?Q?5qGcuYkOHBD10o6rq9Hyoumx3/Cc1+pbOvDj1IMLrYliL4Y/4kF0PysdqnAO?=
 =?us-ascii?Q?SsSBLBs97yUHmozFsuhikeRxM1bTpNAp40Yf7XticJbJaBocdgKVp5075gS1?=
 =?us-ascii?Q?OUEnNrc7B346PzJec6zPB4lakkewgPbJySsw9KM+/y6WNgKPU8S7se9pEzfY?=
 =?us-ascii?Q?hiIG+AdJx7gGPjfWpXjOBJrh0DyVmNYDvMK57d2dDp4tqCs0KGo8YOx2B7yq?=
 =?us-ascii?Q?B3zywgSpmJyMYWBrb9+TpiEWaKA0Z15ScG0VO/DUKujxLsZ27ZYDVLSCVify?=
 =?us-ascii?Q?0Cj11hnxy2LViiLm1nqC/Q2v4pbpREoQ3SKagBiKNSbZi+wpTG8SceTBzuBi?=
 =?us-ascii?Q?gtlNhfiraBqcQ0Nv2oceMSNjy+F6bRQuq5vIInDIZmvpIUbWQYr4LlwuWT6l?=
 =?us-ascii?Q?OntMRF2i1wiqs8M076lKpbL3rhVR0g+TN+osaann2Fl+XzvD41DGlnLUHWA5?=
 =?us-ascii?Q?bp8UqNii+/aqsFtiA3eKeH82kj5PX5gD3VoK86G5YU0/4WSlXFj+8/6t0pU6?=
 =?us-ascii?Q?fAfVDYKwFsMG6zNILHtX6YuXetcUarn/tc+gt2tHeDB+mwV+Vr00r8oKhOzC?=
 =?us-ascii?Q?/zHSGgBrebBjbuG8jF2nXA9tzXiwSVQUifBb2p7NlkCUE3siGcR6wXj6LFJT?=
 =?us-ascii?Q?cMPoMr891mR20IghS/NX5lBadpDslP2MdGrMVs9yCosYEZStTAn1jw+EBQUD?=
 =?us-ascii?Q?DPoP6Ywsqt2L190c47psEMrjr2aRhMllQ/3XoIUb80nLwipIEJBbdVTFqHbu?=
 =?us-ascii?Q?rU9YzUfIss3BJTW8BX/EFy4poAldHEaMh3RZH8aRMh/E1W1Z1mKUBf6Ji9TF?=
 =?us-ascii?Q?Cs1Yri4Ts6Xm/qsHh9J0FGNgOTKN7u6OJEa3SRoentGNPTV4EF6DZejkDlyo?=
 =?us-ascii?Q?SCPhb75B7HF2r3Z1/kH7HXwPOliEvkZlucUW3Xx7KL0kQ2lRTCr20Up0SSSO?=
 =?us-ascii?Q?LogP/71xIaj+pgSZdkSEpO4Z0TZd0ZfhjcD3N1zVd2cGca3HenPkEvc+P33z?=
 =?us-ascii?Q?6Ir53OFZvddeJ64uATHd+WLilePK2PbIZg2ho22rdesJa82gUE2GDUvslp/r?=
 =?us-ascii?Q?Btny+9CXu6mzw80EWLdF3tdd+j5GNrB6xefQ1esorxe6KN7bN1VZf1QKYGaF?=
 =?us-ascii?Q?XZxwyOPjRc9V83r3mmw6ndyA285ruNgtP95UaAoDL4xjYehXdgQsmixNDifW?=
 =?us-ascii?Q?Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66945909-0e78-434d-a4f6-08dd67ea81c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 20:05:05.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HK+L3jz7VeFHBfxH/S9/KazgkCO4+H3RRlmWR/71Trv1m6Tl7MEW86XE8snHYgY5ry+oS6Qf8YbOYqJABVHKTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF1ADAD2878

> > As the existing rdma subsystem doesn't seems to support the above use
> > case yet
>=20
> Why would you say that? If EFA needs SRD and RDM objects in RDMA they
> can create them, it is not a big issue. To my knowledge they haven't aske=
d for
> them.

When looking at how to integrate UET support into verbs, there were changes=
 relevant to this discussion that I found needed.

1. Allow an RDMA device to indicate that it supports multiple transports, s=
eparated per port.
2. Specify the QP type separate from the protocol.
3. Define a reliable, unconnected QP type.

Lin might be referring to 2 (assuming 3 is resolved).

These are straightforward to address.  I don't think we'd end up with a pro=
tocol object (e.g. SRD), versus it just being an attribute of 3 (e.g. RDM Q=
P).

EFA defined a custom QP type with a single protocol, so they didn't try to =
standardize this.  However, it could fit into the above model.

- Sean

