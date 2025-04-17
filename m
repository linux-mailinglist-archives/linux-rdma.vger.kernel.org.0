Return-Path: <linux-rdma+bounces-9500-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C5AA911CF
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 05:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA401907391
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 03:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CC1BD014;
	Thu, 17 Apr 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uj7Tttqj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA81C862A;
	Thu, 17 Apr 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744858807; cv=fail; b=Cmvv8M5w64U/I+fOqTQnDy+YY7zcLo+5lpZTSr+TLApByqxdOMmepRdYGRE3UUkdH3GyxVqJPFr3dkGmwgR1jj8x98ECQlhunkf4KADj/G5bIOgJ7/0HYS2K51VlwYkuDR56h+EYx/uSP51arAL5Fgidl9jZe/mg1119j0loopQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744858807; c=relaxed/simple;
	bh=OhSXqaH44QwU2gJZZh1pVqqo1or0k+yamAmLh2uiNjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f843uIu7IZOIvzN/DuW7T0r1Co1aefpSkcSZUXtCHfa8vsp8B/jl8yae9zqbENHu2FhXBv5Q2GMh79jR8MvqE7q6bdABdasrjPA0Y/lfzBITSBP9nRue2L9xKPiX7ZXBJkRTonSmr+4QsQesTxK1etCjEK4cte5Eutc0bhwoLJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uj7Tttqj; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNIhPjd10q2a1gaOOAqv29+54NXnXICMDhin7qGSrugmh+ns+XPPPPftw4xH/PNU+VyWDHlaROUZRpbXIgKL9si15IHffBGqGmRHL0X8sm7MNobXZMmUtc0PQhG4ekMgnuA0FzITHLYOrNIhFenOlFKZ/ed5iqOlthPiRlbFAwe1uISC9uuNaCUtr2oYhjImi8AiB9hsdSdRal095qL3J55joxpzOum3Y3Sf1BsBKTi7RiFwik7QNZaRpYW0JVH9ClxF6Q5jndNmSXVbs9R/3Wu2N68AtnO//hDwQILxWChz7X8PNWAsh7z823fzSXbKMH3uqbubbi6+9l8a1kqZyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E+LLNQZ+e+ri7RFM5/HcCaewpXtJzuY/jtmln8SkyM=;
 b=DggJ2ATABh3bZAeYl7EzzSotlvKeXjNDdVasWBdmkW0wxJae+1O++I/8UIi59tDJQEkxIX7aXDUvgGV5Z2J6rXfT4WFKy345SBAALpWWi6NgHcN5FF/Dic+Fb98kTH60x43Oms5aE2YhzOTUx43fAjwJObxwZvsqqRzIYQuNbN15pYrjehsp2zOgWmJxZpmV4IkCQyC9Yl1MPmbTUN/O6uH5LPYBb6h0xAWI2KSGmtLw0nwxm22wXOhc2/4RPaDIJCa+B4nyBdSMc6K898hlbKqRDAdNyVYtZDk2OIkNrt5tiuw91kiEAJhS+++hSmRD6NZIEJIBsyZKQzwOV+QNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E+LLNQZ+e+ri7RFM5/HcCaewpXtJzuY/jtmln8SkyM=;
 b=uj7Tttqj/wu2u4yYZfYnkMpZlwLYjzLc1rQYJXVgdzur3ochFRcwfuqxTEoLjHMXLm1MaG+AG0mTyk/Kgaaqn6Qh/muBSo6SeRmuD6Lppe9WS/tiAsF3qRw15v4kT9OjRXFyhEFpUXl6Di2yrVl1Qp0Ux7rEtEvxd2uH+4V9o3esm1vqDGY3ZjWvlc/XOiWmz/iKZoKUQHmFD+tTJBT6WUeSCairVCNK7tCInB3p8PMkd2syjFjZskYB7E5WeyWc2I6IfxFtwOV8aCsqt+eE7oV5Co+GuEaVhJnwCa7mcJxPPBRawe+RIAJPUOMZk8XBrXlWhD3P3xQrjNvOElP8yQ==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:59:59 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 02:59:58 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Ziemba, Ian" <ian.ziemba@hpe.com>, Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>, Nikolay Aleksandrov
	<nikolay@enfabrica.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCABHrAgIAAgVrAgARv/wCADl708IAAJ/AAgAAB6bA=
Date: Thu, 17 Apr 2025 02:59:58 +0000
Message-ID:
 <DM6PR12MB431337B52F88E8E22323E066BDBC2@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
 <c1b9d002-85f5-420e-b452-d6f2a11720d4@hpe.com>
 <DM6PR12MB4313339425CB8921299AB9CCBDBD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250417012300.GC823903@nvidia.com>
In-Reply-To: <20250417012300.GC823903@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|PH7PR12MB6668:EE_
x-ms-office365-filtering-correlation-id: 332ea428-452c-4cc1-679c-08dd7d5bf096
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?gW4M1z9PB4sXWr+pR+arHeMrnPK6+bQ03SvghhOAsAHFQm+rxQIzOzV6iWPJ?=
 =?us-ascii?Q?dOUzc66TC8N7RgvSTbJr3YcmZtD5w4gZ2J8FJ5fxrEMHBifyqd8WLr5BUpBk?=
 =?us-ascii?Q?kEulcMpeaauxIJ/1LbPf4gvh+i2orWQMWVhMISGdAucIQa2GWD450URtLSt+?=
 =?us-ascii?Q?oz2bqVSUBwjEg7X2LSBAE9tXMQxBbWgL/6W/CXYrXwEyIRZbSSTbrh68oO7x?=
 =?us-ascii?Q?0jgR+l2C9AgvMpMkUFHMPi8QVKK87a784amkot6ydv0Iw1BTHQ01q2puJLQi?=
 =?us-ascii?Q?WKCWow9zZlaSphikH/QD88VI/INNB0zsjibo3j2ti++P72qZs04CWY3WNRxp?=
 =?us-ascii?Q?pfTdFbf7miOYAx+rBZLUA9F27kGvU+XZAUYkIbG/o26KUrWEgaVeqkIM32Bo?=
 =?us-ascii?Q?F1n0BoscOj1xrle5RJ19Qhdc2/ruC1gnrZ9PaSYmFH625EahwlIwRUlOM6Jg?=
 =?us-ascii?Q?lNibKLFTEOTPidDSDmjDQiXh5xNJ70d4q01hX2S3UmYxaHDKZr6Qu1UacB90?=
 =?us-ascii?Q?exwBryTdag7Mz+6gjLtUXACJCkScMSMWFcCoBKpnPOhChhG3AtBjCDgs4/iP?=
 =?us-ascii?Q?lTjgxKgTjGQ+3osrmy1RRcs34sZYtudV2Vy1GhJ9c1Y7cvbzNdk0JEOT8R96?=
 =?us-ascii?Q?0+GWf8u8eEiMblu4PGp0TWjbdkhdJEM5EMK6KIfTwESv5101/m3sEjlq0/xy?=
 =?us-ascii?Q?v3s12WJWmYnJQy3lR7zDa7FKGO+zEeSvecrw5SgjtbkknrEoqgDo2Yl2rOId?=
 =?us-ascii?Q?Gl/dRpn+JtiabnA6t93nvmFFUH0E2j+EjQMojDMGlhICc5vOvQ6KpuiWlQVu?=
 =?us-ascii?Q?xpgUra3x1z8AFhxVuWOUwi+j4KQttdb8lmdemD661vg3jN5ncyVD4/erqYqy?=
 =?us-ascii?Q?EytBIiQW02+/+GwJTVWIFwKkOO7SGzhnJcUepbSoQD0iCxDOYm1xE8eer9fR?=
 =?us-ascii?Q?LqMcuehFl+i/hqwZN+dINjGVCnS6jZJRfX9udhnVZJf9naEA0X9WQNoykEl/?=
 =?us-ascii?Q?xadGkFvi/hh/hj/orjnbwJ3KUZgoQghPQiv8DgABEjdmLVaam4kogv1WHEwy?=
 =?us-ascii?Q?TeeNkfVI5f2IQ7GhIb3kkoIbfVKh9++5Lqxv4o93CsIs5dCGCKVJcITao0It?=
 =?us-ascii?Q?Zkx+Hmtz52Z2EA/dC01MTZswemzpieYKc29eozjoHpAfYEyDm+EXhxiecKRE?=
 =?us-ascii?Q?YyhSIXWtxe1RDXhTxw9Im20+HEgBNJ600+EAn4jdPMJFuI3j7R1oNLLix24v?=
 =?us-ascii?Q?1pgtoiasCXdva5lMTM/waH55QCpBCJLJL01dwcJTW1BWVOlEMuyQT9Fu77kw?=
 =?us-ascii?Q?Jp21BWgldQ2S1gsp6zkdwY4N4vTjCf+zTjIF0WRAew/UpnDrBaZuIjMgDlMx?=
 =?us-ascii?Q?6OXABYUDoL9OLQDiz1odwXVHosHbamPZNKk276ZHXkdJbJ1U0/9nHVkiXgp8?=
 =?us-ascii?Q?iM+U6YaaofH7uYhKBLjqTRgn160/NrTApokXvDN8aTFRthDBPyR2lg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GzfKYtsq1QN7swDsyL4Vz65p2OxDWUMboehDZKeNylGxn2/It+ao3w9PTnza?=
 =?us-ascii?Q?5ml43I8f8Q4dX0rL7fsqJ1r05Gb8MFpXzxXsjmkS+UHnJwQ0KpFa8GP169WA?=
 =?us-ascii?Q?ijTxDhNWYejDByJG3ZmUGBgi12fruNXEB9+qLS5sAhhLNd00VyKhou3bum2t?=
 =?us-ascii?Q?BE/1QfUGgQJVIXxNHHnm0daabC1f3pBSkyOPKYxA5tqPBQjiEiA6vDLUCVQw?=
 =?us-ascii?Q?q9Q6aHWHeCDg32HuLVP4/LKopg4nbc90ikJdLNsxtP+SZdx1GjA5LgWzVTiw?=
 =?us-ascii?Q?+ZY7v5OK3z4JOTWwnPKFbN6wuY1p7/hM65trFn5uSvW4263t9pCPJVtRTDwZ?=
 =?us-ascii?Q?lpsQj4QzUCt/Sb7w8Q4cLLqsZsGKkEtzWnjqFZZ2iNd6G5ZJ2ZNrzkwOXbpc?=
 =?us-ascii?Q?OSzxFww+HanWCakLR6OMMCCkqOHECQ8om+Rovzbxq3vn6PBO8I063A/MIwH3?=
 =?us-ascii?Q?OKfQVW7NakDvE81UnC+xt3WRMUnNYY3eQ1CGVYjAlOmYe/lFF3n06vOiiC76?=
 =?us-ascii?Q?g2GrVwZgoTQQAWNkLKVMl5RAwQrT0T5WEMtvT8tPXG4HJJ3Wb6FwOhJ9T5iL?=
 =?us-ascii?Q?q+WTtFCFgzvaC1aeCq/G8W5yz5RzFs5yEZ+vgvdIcz3meKTGs9mfqInFj5VK?=
 =?us-ascii?Q?Xl7lsptNXslKGDZ5T7eHQGX0WukkDP8AavE9UCTN5UXfp6zgolvbQPIj96Tl?=
 =?us-ascii?Q?5JG+IUAtjYRWB6f0CTuDA2D39yx/6nr1ai8nHi5+c7VTpZ3BxZ4BcXKJA55K?=
 =?us-ascii?Q?o6aX21eEbxuBz0rNq3GyWl0nv4GxHieI35tZ7FTbR/Bavm3wJtsiM57LWDhi?=
 =?us-ascii?Q?mU4TMAhCPOLRi1pNGqSHnrMkVOMfQ7OmwQsXfgRlkbUTqbkLZ94sqrGJd8cB?=
 =?us-ascii?Q?+vf8pFtH45SyH6/EbGq07jJnLumwPfC/dzYo/TJxad6w6XXKo7Q0J7kSnnMb?=
 =?us-ascii?Q?A19MJisG+7KgGPgq5+aUNJMSBPFreKu7O3wX+a4RyKQygCAPdO2ls0QgV5dL?=
 =?us-ascii?Q?6UkDS6T5O9r4xE6aibgI6iv31YPMmIvuVGXySPgSShyohT6dskXQkNsKHUGc?=
 =?us-ascii?Q?ZYG9EKXnhCIrcnRcNaqA01Y9rqNo1Ma9EPkuw4yIRag643eTGwbzHvC2ipI8?=
 =?us-ascii?Q?+C61MGVo7i5Tu5b9k6lvHvFYjkRXSD7mBCuINKoQh3nh8hafnkqcqrbdIuVn?=
 =?us-ascii?Q?nk6dOzJFoaYoOLlJDl2nTRRhNLGA1qcFHd/cr0PbXbb2ILlPcBkaMsjFgJNq?=
 =?us-ascii?Q?7+YxsrUqbqgU8+6tMDGVbb5MSMRFanVHrULR1TM16wvn67XngsN3gb8irDyC?=
 =?us-ascii?Q?2wuRVlBuS/V9Az0lq1obKzlvz0jcUgRFqfZ3Hx2kv4GRq2NYh4r0CoQL4Iss?=
 =?us-ascii?Q?i4sC6LuCFfHbcSCdRSMRyKzvFkG7gzcx/4EsdB+zpUEqLk3hdd8UMF3umgh8?=
 =?us-ascii?Q?vdFQHUjgPNR/jAF4szZvUy8JYELNdRXWJZDm3bU743mNbW6U7qktP8DXd4VX?=
 =?us-ascii?Q?uKdYn0XbXv1Oj2Dqi/FfHxOw0ao4oj3rzhb48SGeIXGzPM0DM/VUHyw+XdJM?=
 =?us-ascii?Q?EFDjxVYutJgmAGFo4t7JASs3YC5FgylCf3lDhwBc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 332ea428-452c-4cc1-679c-08dd7d5bf096
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 02:59:58.7789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eFKEhajVmKAOmqI01pFsOHAKYJbw7czgW+9iGW7zPJHsrcmQIualHnMYcGOAkrv9cfAKrML41B4D/jRv0L+Rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

> On Wed, Apr 16, 2025 at 11:58:45PM +0000, Sean Hefty wrote:
> > > > There's discussion on defining this relationship:
> > > >
> > > > Job <- 0..n --- 1 -> PD
> > > >
> > > > I can't think of a technical reason why that's needed.
> > >
> > > From my UE perspective, I agree. UE needs to share job IDs across
> > > processes while still having inter-process isolation for things like
> > > local memory registrations.
> >
> > We seem stuck on this.  Here's a specific proposal that I'm considering=
:
>=20
> I still think it is hard to have this discussion without information flow=
ing from
> UET..
>=20
> I think the "Relative Addressing" Ian described is just a PD pointing to =
a single
> job and all MRs within the PD linked to a single job. Is there more than =
that?

Relative / absolute addressing is in regard to the endpoint address.  I.e. =
the equivalent of the QPN.

With relative addressing, the QPN is relative to the job ID.  So QPN=3D5 fo=
r job=3D2 and QPN=3D5 for job=3D3 may or may not be the same HW resource.  =
A HW QP may still belong to multiple jobs, if supported by the vendor.

> "Absolute Addressing" seems confusing from a OS perspective. You can
> receive packets on any Job ID but the OS prevents you from sending on
> unauthorized Job IDs. Implying authorization happens dynamically.  So if =
you
> Rx a packet, how does an unpriv process go about getting OS permission to
> use the Rx'd Job ID as a Tx? How does it NAK the Rx that it isn't permitt=
ed?
> Why would you want to create an entire special security mechanism just to
> partition MRs in this funny mode?

Absolute addressing means the QPN is basically relative to the IP address. =
 So, the HW resource can be located without using the job ID.  Job IDs are =
carried in the transport, so every send must indicate what that value shoul=
d be.

As an example, assigning MRs to jobs allows the server to setup RMA buffers=
 with access restricted to that job.

I have no idea how the receiver plans to enable sending back a response.

> How does receive buffer job key partitioning work? UET will HW match rece=
ive
> buffers to specific packets?

Not directly.  Libfabric has 2 features useful to consider here.  The simpl=
est is tag matching.  Different jobs could use different tags bits.  MR par=
titioning can enforce one job doesn't try to jump into another job's tag sp=
ace.  The second feature is called scalable endpoints.  A scalable endpoint=
 has multiple receive queues, which are directly addressable by the peer.  =
Different jobs could target different receive queues.

> > 1. Define a device level 'security key'.  The skey encapsulates encrypt=
ion
> attributes.
> >     The skey may be shared between processes.
> > 2. Define a device level 'job', or maybe more generic 'communication
> domain'*.
> >     A job object is associated with a transport protocol and these opti=
onal
> attributes:
> >     address, job id (required for UET), and security key.
> >     The job object may be shared between processes.
> > 3. Define a PD level 'job key'.  The job key references a single job ob=
ject.
> >     Multiple job keys may be created under a single PD, if each referen=
ces a
> separate job.
> > 4. Support creating MRs that reference job keys.
>=20
> This seems reasonable as a starting framework to me. I have wondered if t=
he
> 'security key' is really addressing information though. Sharing
> IP's/MAC's/Encryption/etc across all job users seems appealing for MPI ty=
pe
> workloads.

I've gone back and forth between separating and combining the 'security key=
' and job objects.  Today I opted for separate, more focused objects.  Tomo=
rrow, who knows?  Job is where addressing information goes.  Since security=
 key is passed as an attribute to the job, an MPI/AI job can share encrypti=
on/IPs/etc. across processes.  (Btw, I prefer the term 'comm domain' over j=
ob for this top-level object, but I don't know if that makes things more or=
 less confusing for others.  Job starts taking on different meanings.)

A separate security key made more sense to me when I considered applying it=
 to an RC QP.  Additionally, an MPI/AI job may require multiple job objects=
, one for each IP address.  (Imagine a system connected to separate network=
s, such that the job ID value cannot be global).  A single security key can=
 be used with all job instances.

> But is one job key under a MR sufficient or does UET expect this to be a =
list of
> job keys?

One, I believe.  Libfabric allows a MR to attach to a single job.  However,=
 it does support derivative MRs, which could have different properties, but=
 share page mappings.

- Sean

