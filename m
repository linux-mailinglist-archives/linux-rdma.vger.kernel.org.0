Return-Path: <linux-rdma+bounces-9178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDE4A7DC0D
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 13:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD83B2B2F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 11:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455FB23AE64;
	Mon,  7 Apr 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uES1Mf5F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683EA235375;
	Mon,  7 Apr 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024601; cv=fail; b=aH65yadJGX5RFuydOplEalyixl1q1kRzfz1BRloI+ubs+FJRHNKKLYvb5I98XiJ0KaMpOL/LP+OIy9smQrgm03kbW+q4vyV4OZu71n7mfHh7S1BmDJlAdLK9Xd5fWLCYB/IEDtzJxU84aSCjUWv8ZET/pYQR8ue/nAyXCASi6uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024601; c=relaxed/simple;
	bh=tXqNH5435dzVwJnZbH3jDFKxEfEolurygK02w4vzSXM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Axm9UGWxyQHqRgIbEMwcWBMDJldb+xo1AhuEQIZX8p1FypOJ+ZCOQePHdPLXr2bhvy89Z/zPgw1eRctA5mTLwsjqT81vmInDeImqXJalqXpiB3FR5vTNDv/mxbrXDO0CbdkwHvfwZiJpvMvkK1zcRKcy7xSqhVMHp066sCwtlbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uES1Mf5F; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ld5/mA6fY0L5OX/WeqQ9vGMp6Uh6PeGqao9X8z7EILLOHBkUVM5tXL/O84k4agh9Id5Prooyg1G9lQXw/cnpuHTV8m3bg2GkLWTKlJU40NbmQ98qMGI5Kr1rbFpk73awGatOyeaedHBMZhBrAHTaifsRV9o1qcAN39QM4YEXrA4AAvgacXYoRhjBebogNWme9eAq23q7N5KGi6T7LiZmgnwXF0kAjSchV5PTfSPg2XEX7qk+VC/3YIRwTfArLM8cuLM5U009QM4jPsE0LYJz3CgOwTy/H67Uw5Z+tgru6fcRC+xV3J3VNz4S3XOaQWRv1o4YiyB+xAvS2P0JtWFxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXqNH5435dzVwJnZbH3jDFKxEfEolurygK02w4vzSXM=;
 b=QMpBlRwxwDYArMnx1PUjbrRgMR8/Jk5UORVePNM0Ehdsq4zBlwmzgDCdxI7I+vVlqMUIN8cwAEEf45TDhS0y5z+aSgFn+mp27nmoub08hozNCrveHz9G72TwE5twhbFoKhY/Ce/OHrU4Ae6WMED5dxI+iG9jgVY+2O+vGklOz0Dplpbpl63ZKnPBn18nDrAiXNP+vvIkO0FsghLKUa73ZzD+O9x+skBnOGlVtQZ5GYXKG2U5UEaAD3rWYVlQBNj6I8XOnowjOKPuipm4M564cQycijAAShWy1HLgeR8YWCFsPO2nl84Z6knQbxwnlC1sJvXbDU8g+BMyNGjXHG1sRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXqNH5435dzVwJnZbH3jDFKxEfEolurygK02w4vzSXM=;
 b=uES1Mf5FDL9kE63o1yZOoNqP+9d3kHPVz82ITaHQNTyUE7S4YbGFmHBg0Wl/wu0AXGpsFu8KM1VTqUlBR0I79iHfisQR9bcFJYRy8Rp5+TgBNSxmb+4aXbczZIqe8TtBAuG+Oc3sutGAjxVfRV5GaqlF22p0nLqCcPdsYPrBL/9mjz3pBun1j/R2TTOyHK9vOD6VTezXJLcmScKH2hSPHaGb3ukLh6KiDnR6p+P8Ns5Ezk3VHKDsPz6Pocj2wBhyFAvxaZ7poRBTuoNr/s28OYZ/CQmxMZFaYYWAIdl67JdxGCdcJcWEuXja4GRmBErFnp4kHDykBrALU2acgsuGcA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 11:16:36 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%5]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 11:16:35 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAAC8yAgAMUPoCAAV/nEA==
Date: Mon, 7 Apr 2025 11:16:35 +0000
Message-ID:
 <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
 <20250406141501.GA481691@mail.hallyn.com>
In-Reply-To: <20250406141501.GA481691@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|CY5PR12MB6323:EE_
x-ms-office365-filtering-correlation-id: 14204dc9-46fc-47a6-1349-08dd75c5a8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4WjKw2r2FJw/HpUnXM5L0v/CFQsRb7RHY+HQsCWP4W09heMQcOCFPvK10Zgh?=
 =?us-ascii?Q?6S4jQ9wNYNY/X+aPab/4VG6PStWyfTv9hVZ+UfWQEnnmJWcZZ99I6OFPiMvN?=
 =?us-ascii?Q?ngf+P+1245Onqq37RVOm5VUH/qGV2QgtWAB1TXxoSZDYzXT1XSZdqCOXjMww?=
 =?us-ascii?Q?+3oGBwsJMSajhcc4HcAxo/YHbYz4qGEBuHzOeZxqtxciKZxtNFfuCrq+Fsp4?=
 =?us-ascii?Q?Qwyn7zAwjjkt/nAKRQ4z95TgwmvybNRRg98cLRvwTr7lEu4/2XtQUo0lqkBQ?=
 =?us-ascii?Q?kdKf2toiX0kZseXhGZGSIbH35Rsvpil/qcuzK19RElvNRQ6Nm4NuIzEGdWPW?=
 =?us-ascii?Q?elBvDIMDt2v2TwxEDpEgWG8x2fX8nvbcWBNGVWMA3ysINjUu4Sxtt+auUTYP?=
 =?us-ascii?Q?MaMXgbA1Y6jDppuuljealh1G9oLiET2fYgpNkRTap2iyAaTbekzDPnXh1FYo?=
 =?us-ascii?Q?rmqsjcC576tNOPifzBkeQZ8jPXKI3KohQ0NgBq38k2ViduGXSKZJeLq4AQFT?=
 =?us-ascii?Q?Kn9v7pcSbm2+SinDjs7fT9N4T9v1aeSvjQiLQeSnX4Ab6JxV9xJHXDMygrWR?=
 =?us-ascii?Q?Yq3e41wEh7iMZIwI4VLXBlJGAiqyA9StoZ1kLgLmDLLu9esDHelV3pgcFdvj?=
 =?us-ascii?Q?poemoee3Id+sNnAfKkU98chbyAOngIjkDVQLW8+qN/vTOWv+z7DJ82oU32Sr?=
 =?us-ascii?Q?RGXO3m3ExU0ZeixZpe8FnVbMq3YG470S4iFLlf6nZe+sJt2YoxKI5IeUfuv9?=
 =?us-ascii?Q?ywBOPZLsB2s5FOqhztJEVvivt2rfoheISb/EGbt2JpyPHMQtCgwR8j61aGeE?=
 =?us-ascii?Q?E8Gtb4AL6vH/3AItjNep7B2f1ZKI30dcxbQK7L1HyUyBLLsqImnBkRHLaPGp?=
 =?us-ascii?Q?hQuP2xqVaV+QxcAT7vC8l8s4vhQDqG97kjv4viYnPWJzMBtL+mR/AvQ9IKYU?=
 =?us-ascii?Q?lnckU5D88Pmy5A2d1F70yrPdL+Jq4+9fdhx5lNSpyPjrMCAT4fe81p0UJ2se?=
 =?us-ascii?Q?ZPrNsaCCQl7/q2HMEWglzFZuSVA/CySRxRhoHRvAHSZGgonAdn5fzuJU0kz3?=
 =?us-ascii?Q?BvisoovJ+JRcyu5PwnY+j6JsyOwrFXcTTiVe36sFg6E9ieFYwY8c6dDk3Tnw?=
 =?us-ascii?Q?3pe5FZUCmtKn1sq7IHHS2FyK8cOwqGHgPS1hOH77XKF9pGCl7N0afqCftIlj?=
 =?us-ascii?Q?aEkcl5S3x1IWSNvDh7phuSzeHW4w5WT8F4rnU2i0OsY1iYyGKMWiH6alx4C+?=
 =?us-ascii?Q?4dehk9PyfObvrU8LPRMS4YcvT0t2CgrvHd/717Sqnln2auA9LBNnupvI+eyj?=
 =?us-ascii?Q?qlBctbfu9ZlEhARriDERrjQbzpEPz6dNlfqoUuqPTnC6OFMVGitKn9xAc9vZ?=
 =?us-ascii?Q?pcHlM7FOoOKvpZJYGSoGBQOlMzsW/refKBg/51Hf7I7amntcOaR9zJngNXU2?=
 =?us-ascii?Q?miv6CYFazovAupkcoV9DhuFW8XjKOK7m?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WWimiNYaH9axBlwqxLvfn0RMk7YAtCT2mi9wSWZw4Di1YQegrz8u14rSOULf?=
 =?us-ascii?Q?NlV1Ppsk5lHPpubemYDEcMfo1cvKAcU9nzFHwENOgqFolCmdiZsDAH5LWslO?=
 =?us-ascii?Q?7Otv8LF81vsAJkoJOjqZYk7NU3X00bEakYlqR1AyeBiyI6UPaTas74WHfVL2?=
 =?us-ascii?Q?lyKVr5/ZC8UxNN7Dd7ZHkXyK1ZaejGcbTO1dDHyqF1cVNBBQmKu1CuKraKFt?=
 =?us-ascii?Q?B4B0uJtauJ7PdaD225ZNZlsnM+Ty3vaJ4ZG/0Mfnk8IRjgqnZJt837K2M4vV?=
 =?us-ascii?Q?srp01VPddIE8XWMqcwpVVd++zZi748FeaUnGPie2GRN1MlGsgCCmiS/IEqt4?=
 =?us-ascii?Q?M/ASmH+MGm/33ZdT9PVNC/BH2IJR/frmOWhZu7RPyk+doQd64ekjsMwV5tOw?=
 =?us-ascii?Q?Njzu/isqNLXPgv7MjUHIMl+bTBCwtuvnPVEK6XKnHQbeMpjtWRnb8KijSshC?=
 =?us-ascii?Q?dXGy8ihgs8Uuo5HOSQm7Z9ZSSO1O40ioGVc89BS+AxvrXvMX1O6/C9JHu5hK?=
 =?us-ascii?Q?Cx0+Sg5+Vq4Ib+aWCTJF3KEXLpmwOh0k6vjDaqpBUzF1rUiPx69FMYiBqLwS?=
 =?us-ascii?Q?AHbwVGhBipOOJ3lKoabgjaVDw2nEJcRKU/dceilpavWVCyeQu3d8c5WRrU/1?=
 =?us-ascii?Q?cstng2CaCtpAcxHjzrjrPkUsicJu+3W2iUkGgP1NfpYf9T6nYI6yvY7N+9rW?=
 =?us-ascii?Q?cCzBarD0XFh9PBjWsrpLgcLOic6T+p0gK/1O5AA6wNjRtjsHadkJFpHlsZj2?=
 =?us-ascii?Q?byCmdGhA1pL3jJI3W7q4hftFBesmsFsScxnmeFwoCMv9WysM+JrMXLLQm+pd?=
 =?us-ascii?Q?NJVCU9R6lDv06vMQpKK75rS+Z8IksOfQ1D2uF9aWYTmQNsHwyVZgdSpBBJf1?=
 =?us-ascii?Q?g5Odbs4FlFSunRjRpnmi+bgkWuYEweqpd1Xk6SkKNx4ajPyL+/kZDJMICyZA?=
 =?us-ascii?Q?5U7UYof647JeyzlP+i3NzDAgvYGFU71tDrrwNNEXV8SPP/ABgBk4d7H1uWcu?=
 =?us-ascii?Q?qs5wtvlhXilu4tiN7HOqtdvrjqQ0lpwoVZOrSf0fWbPveBlF/sT76yy6A+Da?=
 =?us-ascii?Q?caQWzYkxUoL3KLqOWnL1AQP1lIZse+GEMbXFAwleONXaDIBr8KOm/ySQWfQ1?=
 =?us-ascii?Q?h63A/Fg/EPPXnEbMPLB44wIbmx5gSEMK05PXZsWaL96UC52iTYkfbDbWmj14?=
 =?us-ascii?Q?lp7syDTLhPkwKtG9gMiJbb8+YhLSQXDO6w240XC+NBMHl6/Jx1XOMCi23ivN?=
 =?us-ascii?Q?GiJC69bWdexxDHIbg7KXiCRmQfeR7xdH8+qa8D9DFJIXO4sPXll8bZz4I6VG?=
 =?us-ascii?Q?TDLLGkzy5A08CHxfq13snnhGqYGhrwb5rfBHWb825rto++ORIrIfsuuTcwQ6?=
 =?us-ascii?Q?eBslIRIYrds2IRYMCucdciEr93puxFNmy0+BUd7asbb4+RoVgFI4G8yRr1BS?=
 =?us-ascii?Q?3X++jl9HdEmI2pplPeRFUF887LA5D0GJteF7hENkGVy5TpRB9bptb9FJsfUV?=
 =?us-ascii?Q?wpZuptMAO9eiehYj4yk/Il+u4PJyWeu67+y6N5lY5dbKRwvZ8Fw2HA2oHceE?=
 =?us-ascii?Q?C+fVC8cwiEya2U3nIrYRL5n0x6k0Sgqf0FLpBwiVg/T+ABaV61XSSbMc8F+L?=
 =?us-ascii?Q?s4dnDjYgi4bC6Z1I1s4nXzc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14204dc9-46fc-47a6-1349-08dd75c5a8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 11:16:35.8691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQ2yRXCJ5USNKJbjNCtICRFnVSvCnHm9JRVLXIuTXmzyZVEu03D7OmpXKkQy4BPJKXs04Cx8xLeQTYNu87HwhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Sunday, April 6, 2025 7:45 PM
>=20
> On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > To summarize,
> > >
> > > 1. A process can open an RDMA resource (such as a raw QP, raw flow
> > > entry, or similar 'raw' resource) through the fd using ioctl(), if it=
 has the
> appropriate capability, which in this case is CAP_NET_RAW.
> > > This is similar to a process that opens a raw socket.
> > >
> > > 2. Given that RDMA uses ioctl() for resource creation, there isn't a
> > > security concern surrounding the read()/write() system calls.
> > >
> > > 3. If process A, which does not have CAP_NET_RAW, passes the opened
> > > fd to another privileged process B, which has CAP_NET_RAW, process B
> can open the raw RDMA resource.
> > > This is still within the kernel-defined security boundary, similar to=
 a raw
> socket.
> > >
> > > 4. If process A, which has the CAP_NET_RAW capability, passes the fil=
e
> descriptor to Process B, which does not have CAP_NET_RAW, Process B will
> not be able to open the raw RDMA resource.
> > >
> > > Do we agree on this Eric?
> >
> > This is our model, I consider it uAPI, so I don't belive we can change
> > it without an extreme reason..
> >
> > > 5. the process's capability check should be done in the right user
> namespace.
> > > (instead of current in default user ns).
> > > The right user namespace is the one which created the net namespace.
> > > This is because rdma networking resources are governed by the net
> namespace.
> >
> > This all makes my head hurt. The right user namespace is the one that
> > is currently active for the invoking process, I couldn't understand
> > why we have net namespaces refer to user namespaces :\
>=20
> A user at any time can create a new user namespace, without creating a ne=
w
> network namespace, and have privilege in that user namespace, over
> resources owned by the user namespace.
>
=20
> So if a user can create a new user namespace, then say "hey I have
> CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
> resources belonging to my current_net_ns", that's a problem.
>=20
> So that's why the check should be ns_capable(device->net->user-ns,
> CAP_NET_ADMIN) and not ns_capable(current_user_ns, CAP_NET_ADMIN).
>
Given the check is of the process (and hence user and net ns) and not of th=
e rdma device itself,
Shouldn't we just check,

ns_capable(current->nsproxy->user_ns, ...)

This ensures current network namespace's owning user ns is consulted.
=20
> -serge

