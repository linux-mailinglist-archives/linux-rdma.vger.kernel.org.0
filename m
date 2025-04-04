Return-Path: <linux-rdma+bounces-9157-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C2A7BFF2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 16:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8924716D953
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC11F3D21;
	Fri,  4 Apr 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DVoewWJc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBE41624C9;
	Fri,  4 Apr 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778417; cv=fail; b=jejBvHAhQT3xHJRMoUcO0lvoFZoXMVgmwkrczqC+0go2AG2pvq4hPD3PW6Ksbw5/dEIRgz2ljaWc/8+xGS4FJL/0trOX0YYX30UGKby802bks1Koi9WZOzouJeQrvil7G2VgNlYnZV3h1RRXq+2+z+iUGoDTX365Rf5L0qe0H2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778417; c=relaxed/simple;
	bh=lDwoqwOpTYKChAijE13zxefpfwKda7mYEWI5Ygauh9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lz9xCHNZFgXbQdcMzr432FoIXAdLk00MAySBnmg5J2DY15KMqe//Y+0qWkM0ysqljfyBQ4O7Pr8yqWke0CZPprVPCZVKW7dpH1h7U6TEKkBEjqtlTMV4CLACgi69JQL4MD4hV6mnbw3t8hBlhGq+NCwVfAk0ZyUM//Y4mgjXNA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DVoewWJc; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY3y93CnwNaivq75QePe/KdAXUD6pLz75YPqVRBI5Jz6rHSVndA7CHA+q8YfSNy5iTofZxlFmkTR4MdBrWbTH1Z9tk29Hlvjio5IktgzQ9o/pXzMr9kjBLpEPofiC5PKdm0SuF8weNpI3+rPA3ycmnEGUb0xKYn6yfS0wrY5BvMTbfjbTR2UGtspConoBil+krWQ29oprE8FtAZzs73Q3nkTr4l79dMRWPwGTyR5Fsd9PORCsFgI4Fli0Eew50EjUUFm7129J18e5XbErgCnl2Zus9xKt9Qjv0PisvDTT7w88PTizStmWhaX4iaGBg0mf6RhInUDyQ+ANHRjuECyLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UgGDCp0Fr1cJJHfkCq2csuwZ4xp10nbj/qatCGMb/Q=;
 b=agp9kPtX/Yxop4sn8uSwGyZGAMZQfvQ7jFav78cW6yMxenIxA+IC2DSmx8hjab8WRjuzDurZ37ZuNHrN5IElDuBlBs4ClmID7uwveEPavRvwyiyRod08gYpwQ+B1lp3d2s+fc2+qxOfmNGDK9VftxJHn2X9q9qXpnV4+k8flxOnDJJNPOifceJBxtbpAufYyO4LPwYlV4Gn0/LWBSFsA+YOvoEMSnjzsC3McB87Hf69s412wO8zVySh/82bsvRtwPUCSo7JCGD7fbTIseypvGMlQ0VpIQNbyYITH4DA2rX2+Z4O1wCxFH71MnZ+rsd26jriBW5tMqUyDd5ijF8kmXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UgGDCp0Fr1cJJHfkCq2csuwZ4xp10nbj/qatCGMb/Q=;
 b=DVoewWJcUGTRsi73lvOS3FJJ4JktQMx5pf8V0jAtqWEZ6SUrt5L8RopWkakFQw3om4HapZJVe1L15lpFM5HY1Au8a9KcniXlUwjs6DlKVd1ISWnA7UQT6IBMkboVCxtjZMBDFPFahLPfJavYcEQLFPkKV2Hl1qmsaczdN0U+85tDHHz5yH7swrphmctgDqHzWhob8DFoKNz5uyaMFtlxaZVaNF3RZgK6BIAI55W9ZOSjQqbh5nmRMpBI8Wt94u21CYap7ZDvfWFGk33KBgbKTT1VuqHql3tIrkecaRCTkKfj8ZSjlm4HZUHkigTwXWhGDTf3fGe9aqPRem/Cv3CVbw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 14:53:30 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 14:53:30 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Eric W. Biederman"
	<ebiederm@xmission.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "serge@hallyn.com"
	<serge@hallyn.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUA==
Date: Fri, 4 Apr 2025 14:53:30 +0000
Message-ID:
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
In-Reply-To: <20250318225709.GC9311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|MN0PR12MB5954:EE_
x-ms-office365-filtering-correlation-id: 1fc59e2f-45fa-46de-d611-08dd73887720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aF4IOBtvlw1yLT/TE3k0po34BJUHR+7tAmg9Sv8/HxhBaCbYO6dKk0ODr1vH?=
 =?us-ascii?Q?2i39uUHKRK62oKnrCRSm4cuIIurjDp9ELbnDAeBU22zEf14WtqzVNbuzjlGq?=
 =?us-ascii?Q?oMPS9FFtnZArPSH77clFN8Nv+umHf8/93SpsS7YgnESgt/5hKyVhpsYrmkoq?=
 =?us-ascii?Q?TXcnm5y3+2vWsqGXUIi52s1SYLZXtLRWHgbGb23DoUWE2PJNkAsY+txAHLIB?=
 =?us-ascii?Q?NY7tb8NRiFN3k3E2RE7AyoZ1CcEvy/UldgjQ7Zjq8zTOJAKJaoE4KpuJLnK5?=
 =?us-ascii?Q?oBMrkjsDsk0qHbAjWmSbQ9wildUG4w8gdU/xFQOQSiQ31mom3qqIwqoreoWy?=
 =?us-ascii?Q?N9gjs/8uVbv17KiVAEb30KZuqyMx2nfoHf8GiShEs6uZC6auU2XQCYvaim4p?=
 =?us-ascii?Q?hUglztMIhqRcAaeoWTkxtflBePiQ4GqmVIGAooPgnEK6G5KGptJ39QCTLTyx?=
 =?us-ascii?Q?h93+z80J10O0IXzG8fIPCo8Btvx9LL+Wf/1kIeuQtwHmFpdndowfcYtsKyUn?=
 =?us-ascii?Q?k3PTCk7ce/mC+YApQHpDJubfs+A6zXHtQaswVybGKSHOE+htMXLdGggw4cBN?=
 =?us-ascii?Q?fBvIThK1cJGfldSggAQVISKDVSn1qK4/Cwxcejn0Ig4YN2sVDK5MiikY0Z9q?=
 =?us-ascii?Q?Du6bwjEKKKLbEqFR2su3IrS94s2YVSG7nWLYSQf/hRTvpAaibvbZtCTaulIV?=
 =?us-ascii?Q?y2RRwo2B11e/OQOaH63+B9z5/x6ThRXopqdMJuuDHtPWM7zokHuZt/4PJ23n?=
 =?us-ascii?Q?X9ZsDB1kfoNXh9ZErCZMMbLJvjdVwpjDTbT1WNJeWsv0ZGwKvWafxcw+6E24?=
 =?us-ascii?Q?2L2YIMUUH3P9YPEet9FeTJvs82WXUUmOx53TXYp1gRphgRhS4YC1mOaD0EQL?=
 =?us-ascii?Q?nDgs+H4YumRCwBKDyZvtcTBu8CQtsJpnGfNlD0bUDtbDxewf/RYV+u8spBuF?=
 =?us-ascii?Q?QYFOJNHuc9NKwShuv2qGWNabTl9shDGOKwQLHna6pzf2/ojSYHgFZxfSiwQ9?=
 =?us-ascii?Q?3JVm/JODbL24xgugViqJ8Wz2pGVs70GmOBthclvorLc7gkDH2d0btMoPLDA2?=
 =?us-ascii?Q?XGIdCHG5K9tHXV9XD2XcfTBUm6c7YEImrjKmKGKdzs4w9mZ3heWG1RHIWn24?=
 =?us-ascii?Q?9N11AKH34Fas7uEPZjhiNkvQkzxGrerdEyLUCiuY56dhK3CGD42v7KLhSbys?=
 =?us-ascii?Q?dKJfMKvq6KNheAVYjX7TjQH0wGTtrCM0hkatSN5iCbOYiXr1CL36T3jd71d2?=
 =?us-ascii?Q?0911oKSYa8aqtzJEpsYUcHkCapVefaJZrXfrl9oOZrTX7vIKZhAP/Kb6cKHd?=
 =?us-ascii?Q?6dgnk4iPiLm2PkkM11oNvnnF2ky+5gcLM9mkqK0zo4s+r3mq+2a6Ahz2NFJl?=
 =?us-ascii?Q?Hm+gatWW1IubhL8QSCgaT+FkyQFlXjj//+TOH8dYkA4YwuPVfL5w53QF15ae?=
 =?us-ascii?Q?tE3nAqYM0c+BAME+Dy0VT/+bSodYckNyVuXrHFqXbWcHrnt5YFaMNUupEGxk?=
 =?us-ascii?Q?JnFrvtWcgetF73M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u+f2wTaeiytPDBXtxjyhJUaDX+A92JgLQcx26OTDwPGBDZCpThJ3NIlBW41s?=
 =?us-ascii?Q?cucVtrze5Vp1+pTo1My1vbZRiT1UYansQ5mDwNCjZ8cPp3HnjqKGPPw79/Ic?=
 =?us-ascii?Q?6W5lqLAScxIMLQGxrfjfERc/TQybWDdvrQ97dD7llVJyOZ2fOpjRgz8ufYh4?=
 =?us-ascii?Q?ly+AsIsOylxwvTmEbTYq7g1yU0v1AUscLhun25Uzsl3hvsfqL0+AjvNcHiuz?=
 =?us-ascii?Q?1rmtyYaQCWCEtEFlxDkKu5gHoqW+nGfe0FO7bVhfIIAgU1ZiIuId3tja3Jsr?=
 =?us-ascii?Q?YWIBiwRmNsTNOR6rQ2DP7uvWUbhv2nLFw2u9KZUWHdyjw95J373Nfw5TjqyJ?=
 =?us-ascii?Q?kBqMS70bj8kf6Tbl4kjWycy6epfdvJEW+8E7JWWy4l7APVaoQF5V0Mh7W/2r?=
 =?us-ascii?Q?tvgz4/1gxXbqMYk05/NDCzYtrFU5R2/nbPadVh+On5AdwDzhKfBVublt0cLy?=
 =?us-ascii?Q?yYSqKcprfpEMTQpVEJdDTgkTPnJoio89KUO0AUMwXc7PMo2ecVcLcuU5n2C4?=
 =?us-ascii?Q?xpA6AK+Qj+5L9nalOgi82VgXDpMFeBphOa1Oc7r/rws+hKAqmq6h1DZBqbj2?=
 =?us-ascii?Q?yimpQ21ncyR+tZj9yqiqrVSUE1czVPBVYghEq1DxOtsH2/XvFavbf4Ql0cBo?=
 =?us-ascii?Q?0Kl/R0B0VK9v9/kAzkBclD89xAT/2BOq6ruPnxaWdXEoZacyapRUgxctVfYj?=
 =?us-ascii?Q?RxCQUNtJvuliGG2CNu+3kBu/TsJg+GH0tnd8lwA6RJ6hxQ6sFEQ4ecghTgr1?=
 =?us-ascii?Q?GGjpebIRSgm3EtTfbOGWDPh18vwTDQ14Pl52/xUYqUhgului/4a3V6/Qn7Lj?=
 =?us-ascii?Q?cZRkShcdPqeJf22AOV+cigMf6TF+Mfpr/dSvghfNzEnElRS8rJPpo+PBm9wh?=
 =?us-ascii?Q?XCiaiKQ25uM+vYPVLWfE36q6Qqwjr8L4DZbFPy6BwuoKJULYjit1xCoaY3ep?=
 =?us-ascii?Q?8IJKIe/Gg5YNlSqO5rmRhoPy2pPIPfDE8uE+oprhHZOnTpP6ELDESWeJ74tr?=
 =?us-ascii?Q?1fhh5WwRoFHw7DZQzJkrL9av9ofXRkhIrXVDNkYgSa+UzkfgSksauV+p5f0d?=
 =?us-ascii?Q?dg64XR+BmSGY9eLNbgqxsmKRjqYceCFFP2UDF8dVjdRRdEAIjHKOyDa0NsiJ?=
 =?us-ascii?Q?Sr3djOg/Wn73QWrEESzJH5ip+o73JQD/fK/kLWtizHR7FxLSwxCDoJ3nfkDJ?=
 =?us-ascii?Q?BZS3HenRqpdrOQR1bn0coUlAtmcp+X/d8+FVIhV9i6TqQindRWHaZJLRdm7x?=
 =?us-ascii?Q?JXjgspZMlVfLTOEZ1ElfXFWI4p/bvGmrKDj6q1QRJfwY8bhtOr0K+fwGpizl?=
 =?us-ascii?Q?BlRZ0WVKTDXJ9lUi4R5bTbhylRz4FmcsMjkf+VYDxsvQkxzJq3JH4UZCObPW?=
 =?us-ascii?Q?3zGsVJx0WCNjj6b0a/BoG7m6H0w0oyTvif3O/UcPEvbcBMxGEK5W2zPMp5na?=
 =?us-ascii?Q?9UvIe66BbyNiqmIwp1ERGMDEx6ZZwZKHd+VhzHwTJTzNoyl5Hj4TA/fOfKgx?=
 =?us-ascii?Q?qFDkLltJPa/z2aFRG90uNwRVSQkFuuKK5zDoM9EtL9g5Rk15bOAxn7ffh9EM?=
 =?us-ascii?Q?OkfaY/wjnszuc8d0+2cuwc1CoZLQ8VfXBoOW0PpgZm17s/yKyr02oZs2l6b0?=
 =?us-ascii?Q?AgJ4mH0pBwJ7V9pChMLydpM=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc59e2f-45fa-46de-d611-08dd73887720
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 14:53:30.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHC4lnt3OQxW7mTjR6tTvbAeuQF6nuzZonN8IvBYXhT4PllfVHvIJ8RNnz7lHuWTKd4tdjW2K1p10rKqpJna0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

Hi Eric, Jason,

I would like to resume and conclude this discussion.

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 19, 2025 4:27 AM

> On Tue, Mar 18, 2025 at 03:00:15PM -0500, Eric W. Biederman wrote:
>=20
> > There are also a lot of places where inifinband uses raw read/write on
> > file descriptors.  I think last time I looked infiniband wasn't even
> > using ioctl.
>=20
> Yeah, that's all deprecated now, and it had some major security issue wit=
h the
> 'setuid cat' attack. IIRC it was mitigated by disallowing read/write from=
 a
> process with different credentials than the process that opened the FD. T=
his
> caused regressions which were resolved by moving to ioctl.
>=20
> Today you can compile the read/write interface out of the kernel - for th=
e last
> uh 6 years or so the userspace has exclusively used ioctl.
>=20
> > > You would not say that if process B creates a CAP_NET_RAW socket FD
> > > and passes it to process A without CAP_NET_RAW then A should not be
> > > able to use the FD.
> >
> > But that is exactly what the infiniband security check were are
> > talking about appears to be doing.  It is using the credentials of
> > process A and failing after it was passed by process B.
>=20
> I'm not sure what you are refering too? The model should be that the proc=
ess
> invoking the system call is the one that provides the capability set.
>=20
> It is entirely possible that the code is wrong, but the above was the int=
ention.
>=20
> > Taking from your example above.  If process B with CAP_NET_RAW creates
> > a FD for opening queue pairs and passes it to process A without
> > CAP_NET_RAW then A is not able to create queue pairs.
>=20
> Yes that's right, because the FD itself has no security properties at all=
, it is just
> a conduit for calling into the kernel.
>=20
> Process A cannot create raw queue pairs in the same way that Process A
> cannot create raw sockets, it doesn't matter what where the FD came from.
>=20
> > That is what the code in
> > drivers/infiniband/core/ubvers_cmd.c:create_qp() currenty says.
>=20
> I'm not sure what you are referring to here? That function is called on t=
he
> system call path, and at least the intention was that this:
>=20
>         case IB_QPT_RAW_PACKET:
>                 if (!capable(CAP_NET_RAW))
>                         return -EPERM;
>                 break;
>=20
> Would check the current task invoking the system call to see if that task=
 has
> the required capability.
>=20
> Jason

To summarize,

1. A process can open an RDMA resource (such as a raw QP, raw flow entry, o=
r similar 'raw' resource)
through the fd using ioctl(), if it has the appropriate capability, which i=
n this case is CAP_NET_RAW.
This is similar to a process that opens a raw socket.

2. Given that RDMA uses ioctl() for resource creation, there isn't a securi=
ty concern surrounding
the read()/write() system calls.

3. If process A, which does not have CAP_NET_RAW, passes the opened fd to a=
nother privileged
process B, which has CAP_NET_RAW, process B can open the raw RDMA resource.
This is still within the kernel-defined security boundary, similar to a raw=
 socket.

4. If process A, which has the CAP_NET_RAW capability, passes the file desc=
riptor to Process B, which does not have CAP_NET_RAW, Process B will not be=
 able to open the raw RDMA resource.

Do we agree on this Eric?

Assuming yes, to extend this, further,

5. the process's capability check should be done in the right user namespac=
e.
(instead of current in default user ns).
The right user namespace is the one which created the net namespace.
This is because rdma networking resources are governed by the net namespace=
.

Above #5 aligns with the example from existing kernel doc snippet below [1]=
 and few kernel examples of [2].

For example, suppose that a process attempts to change
       the hostname (sethostname(2)), a resource governed by the UTS
       namespace.  In this case, the kernel will determine which user
       namespace owns the process's UTS namespace, and check whether the
       process has the required capability (CAP_SYS_ADMIN) in that user
       namespace.

[1] https://man7.org/linux/man-pages/man7/user_namespaces.7.html

[2] examples snippet that follows above guidance of #5.

File: drivers/infiniband/core/device.c =20
Function: ib_device_set_netns_put()
For net namespace:

         if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
                 ret =3D -EPERM;
                 goto ns_err;
         }
=20
File: fs/namespace.c=20
For mount namespace:
        if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
                goto out;
        if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
                goto out;
=20
For uts ns:
 static int utsns_install(struct nsset *nsset, struct ns_common *new)
 {
         struct nsproxy *nsproxy =3D nsset->nsproxy;
         struct uts_namespace *ns =3D to_uts_ns(new);

         if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
             !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
                 return -EPERM;
=20
For net ns:
File: net/core/dev_ioctl.c
         case SIOCSHWTSTAMP:
                 if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
                         return -EPERM;
                 fallthrough;
=20
static int do_arpt_get_ctl(struct sock *sk, int cmd, void __user *user, int=
 *len)
{
         int ret;

         if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
                 return -EPERM;

