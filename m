Return-Path: <linux-rdma+bounces-8504-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2880A58079
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 04:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472C71890B0E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 03:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB7B1BF24;
	Sun,  9 Mar 2025 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ST8n8/nj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15807168DA;
	Sun,  9 Mar 2025 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741490505; cv=fail; b=bFeAc8uddGV6sR68f5ZgvZPHKCugwbWBbg+sUz9XnNPh5iFD9+rej0A4rfuSNFZVawS5qoujRpywN0K80rtAzr9WyiKJfnZw+uei3Zi1qkd2AdFveslsc9v/Bf1sa7nmDEnFMwRtXYpAyreLbLuddlEYwMQ0PEuVVk9XAIL4Qo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741490505; c=relaxed/simple;
	bh=Idn7J/pKfXwDfw/zPIRn08takwiBp6KcOnntK/OzDJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIrEpvG27jFX4dCXQo05Chvkyt0NcdDeMQTMQ1HertIrvoTg+oNLO8Er9wReHIppqONnM2XVtgUCR/0upGpjcGkuO1eL1QIemBhAkaq9aQAPcjJl4n1F8WRXb3kCl43Dbj8Bbc7/cgOH1vnsT6bEED4VytPbRK9IsJeOfwLZql4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ST8n8/nj; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUl0X0BGQicWfde5wI4oWs4aS8+9b+FXWBzD7HS6vh/tQvGKgU9gaD7EYsQfjZvguideEbUzFTiEXPHnPDNbp3oV98uvRcI4FwazWtYoaRxh54+AkHFyKtYCPaHyMr20b+G4ucGxRQPWOhhWDSzSVJSiM3nuYs9bBHeYiAJJAvfMmXESziMloz2k6xWZdPLIq0nfOdihVu05nX2wbEuJfOpZPRHc4LBsOR2GInvJn1jMXpRhE2KpR36XZ9gngM4gx4B0cq+Tw5vf46Nls2nZDP1PyI71ydtE6mHsLWGKV4dMTt+DQZ13mIOCrQa31e0INXlDbfMjZtnCE+L4RWzTeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Idn7J/pKfXwDfw/zPIRn08takwiBp6KcOnntK/OzDJ8=;
 b=o8SPgqytYZZwfjyn0fVEPZj6fiXW6KKFaTSM2Q7Hf5WKP4H8xMzpXDYvuj3Lgj80Y7OW0buHuPGLeA74N0hhiNfJyHmz5knM9SIGL0g6HaVo/4nhdiNwEIQiqpUFy4Y3zwRKk86ZY4DwvLrDbN+AspCMod+huxRSI1Yt1ZkLmpsZWfTxIEyzincqWJPv8Uw2ymrG4sYbGzJ/1EV34q2FDm48NZtj42XnApgxxs1YFwMKOXRDLFfxzoK3I5p83ih6QzZ6wQ+bXrmS+LQQwoxs4dP7zgc4cXBBaHmGHQXsJx7PIDcq7W9raxv/4tDSBbSVVXqw7uxUVwAZ/MJV9Mm2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Idn7J/pKfXwDfw/zPIRn08takwiBp6KcOnntK/OzDJ8=;
 b=ST8n8/njo+T18tr02i3Pp0s/T6V1A79B+86OrLmDZrrQc0hpG7A44tOHLW73Pp035/BKVdCVeFlpECIhQ/PwVj1TWxagaRV0q10Hjg/l8xgxeF9K1XaMLKf/qhcJpvNgxP6LJKWBEIFBvx8UCFmcvK3epWo0D9qqhCnco5JjqugtiJW/kdIndUw+tct+rkkaP9YrqTLCQ770BGKnfX7mWQbkkZPeNHyuKU3GoCHwycbaFtKOiZaMcYhl6UkjWMC0RN/0fC3Gtvn52F5/7jAms5hrUSGIDgzs5t6TT13rK/OVM8uZKgoTHxCeR+7AZa4B4L8Y32+P4ScnlYZAGGGEQA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 03:21:38 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8511.023; Sun, 9 Mar 2025
 03:21:37 +0000
From: Parav Pandit <parav@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Nikolay Aleksandrov
	<nikolay@enfabrica.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "bmt@zurich.ibm.com"
	<bmt@zurich.ibm.com>, "roland@enfabrica.net" <roland@enfabrica.net>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	"kheib@redhat.com" <kheib@redhat.com>, "parth.v.parikh@keysight.com"
	<parth.v.parikh@keysight.com>, "davem@redhat.com" <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbjuwTiXdUl3rkakim9XZbHzbYobNplw8AgACPWvA=
Date: Sun, 9 Mar 2025 03:21:37 +0000
Message-ID:
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
In-Reply-To: <20250308184650.GV1955273@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BY5PR12MB4210:EE_
x-ms-office365-filtering-correlation-id: 37dd5910-7ffb-4ab5-9e5f-08dd5eb980a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XcOmKNFUy8Mhj+8GXkm/5R7HNl4+HmaiMtXAcRxl42ySSv6Pm6Nt443cSMt1?=
 =?us-ascii?Q?6ulvCktovKb3ywK9EEqejpOoc9oz0YkgXvTkIxt4FtIOW1X9O1GBxQ0mqbXr?=
 =?us-ascii?Q?dk5oW75OacnMsC2G/ArZxVR4WvH/vfdq5TTNpKgXCkyBgi3FpFgsHHkjORt/?=
 =?us-ascii?Q?evSowBfodaDNft7G3AORzJDtYgc+IPLas9k22BzjATxrwxm1Qu7ZN4rrvXfG?=
 =?us-ascii?Q?CmVvc//C57GH8CcpMLVrMlApHIB0Y/0VtAw1SiB8YDxdV9SGTuoT5Fb8y9s5?=
 =?us-ascii?Q?Y9q76cbsRu2nsYO7il6hFmjOsePWMKdOtC7nnTFV36k5C5U2d6W4V3z1gHZq?=
 =?us-ascii?Q?Gf4wn+IxYAip7fzUCfL+dwPsA8yPLxkjsZBdMYqWQhMYAttlkNNqgJZ21+YJ?=
 =?us-ascii?Q?GMAnn/gJKtElmIdmQOUAlOlZ0gjkuT4PBtRvG18ybrn/s8CBH5DapN9kKNjT?=
 =?us-ascii?Q?lmROQD03ZLg3kzRemG0ca/epvm253MDkek12c1BdElX9F0b2/QUdCQ7d/N+k?=
 =?us-ascii?Q?/V0CjTq67D77yFeAzJb8uX0Z3qW10zDyL9vpAGdFl9ckiKtWgkcQhvBb5dJd?=
 =?us-ascii?Q?iKwicyP0yRNDSPeRCzb9cf0UXfUG62u31H+9uAoQe23vp2H5NU5b2gWcRIv7?=
 =?us-ascii?Q?PmzW2WsOpg1JXg/bDixrZIS2zu2C6StRTFVL2kJcvORopaEu/+T9z5Bn2VA/?=
 =?us-ascii?Q?dACGBC4BIsnwmzWpaDjX+SwIX4HUKZshZ5oYv315+mzrLLzFIOFnhy/Ri4PW?=
 =?us-ascii?Q?eKBQHra1PB6O//lzuUd1C+dLb4gm8vvOsiAztnfyp+WIcsN+4S0R7R5yOVpc?=
 =?us-ascii?Q?16gNg9ZGoJbJPP04YgTh/hTXzin1H5joTgWZ4pdhanG7Hq7IJWcQByFE2aKF?=
 =?us-ascii?Q?wHU+17VM+FAYPlJXvCEqHRy8e8yiWvfZ3aUDlElNEsUqXSs4pSLYi0EVhjta?=
 =?us-ascii?Q?+E4L/3Ahh3C6Fi76D9SfHnQr9s6qfu4nNCq+y6Azzfz5y/JSHVuZ+N9pyQA2?=
 =?us-ascii?Q?ufHhPlHGeb9hS7TR2jNRSb9xCJRzFeQAyEJzmAKd2GH33C0Id4oOu3UJU87k?=
 =?us-ascii?Q?EtjMmehPyilke6JuC5wuZk12tV1WGI9vPSDSbK+eFtgF2tHy12ADJgM58hH6?=
 =?us-ascii?Q?OwUPVQTxZPYAXYLiJ9BpD2ZvcytrovFXc55H/bWkMhv8fpQk2QIYbeLCPKjN?=
 =?us-ascii?Q?j4VpG/nUTC7A6O9APuofzIHggz1xgQ9+nBVHlfUsYFgINKA1wSHIKWav33P1?=
 =?us-ascii?Q?0h56FBZPjA7A8NiIb/3cWoNPAO0UcJuJhrGdEUledJeZ4khAWEYwwb/sRDI/?=
 =?us-ascii?Q?C6ZEFf5pFUsNQgGNtaQ1YytNrWLuf/4l15p1ubjzm/aVTE/uzkplcQ/b/zDX?=
 =?us-ascii?Q?LQsEanY5rM9FCM/IfVYY6G8iGQ01TvGqrL7//EIYwVrjcggeuNA/donA1bPH?=
 =?us-ascii?Q?7Jc+av8CL4M7bzZspKLGrWtAEPrlVolm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q9373WsRx1yF/RCmOWV2Am/O+mQvVmdfUZriRPwZpwIUhxJX1Imue2ICqZPx?=
 =?us-ascii?Q?s4UPj15/Tzl3TSsbv/f+6YNl4TsD24uEx22R+GtRxEO0L76cJv0YndFzfUUR?=
 =?us-ascii?Q?68n18NRAGtc7KKu+4yqTkZdLNKGG8GbFB+c2KF3wbgn2gFZV6SBst7M2iyXt?=
 =?us-ascii?Q?uN+CHHTzjh8c/W1/1rlhAYgjz1nvWaVWLkrVHnKwCJy6ucowSN3Xi+9T3/w7?=
 =?us-ascii?Q?9hqozKST8OHB6SEmZlf6xpyZDC0oNkSkDwMIaSdLR8Hm7/yDXOgqc+lnBDr4?=
 =?us-ascii?Q?9//yBcGXe1VEcCRey00xlVX6wou25mnL5qbPTDg8gE/JMs8+01X91tKZ7+3h?=
 =?us-ascii?Q?MUCvcrtwsVuyVLXCw71pS6LY85zLGgRa0piscj8PXJKpyoGDkKkJqfh7utFr?=
 =?us-ascii?Q?UiwkDtnO5CYtbz9N0SEhl8sU8kzwDRTsx80ZcE4vnBgyduGcFxpu9z4JTdC7?=
 =?us-ascii?Q?lzJXGDiHdbm+OJ1yCgYKZjuwRz6/WlfiJrVRx4XubQYoBwK5JsI7utwTErTZ?=
 =?us-ascii?Q?H+GLw5hftc6KIxoVdQJE+RyEuZfGfYNajCPUCD1xamd8TRNJOJE/lyPflGdF?=
 =?us-ascii?Q?VtDtJsG5bzjo2fFaOiG+Gfe+0zhmzDqrdVqdyeRkt9AezSWNFs4tKrPYNF3H?=
 =?us-ascii?Q?n0A9zekHRYaMzBAVfSSja8RFAfQrhUtO3qCSV5Gd5Fud15iNRIvev17J9S/I?=
 =?us-ascii?Q?PeXx9SGvVyEjEC8zGRQOdAwcG7xLToNSbFTyhSRFYKLP9pveUNn96QWQUeBF?=
 =?us-ascii?Q?ogb5ZOwtfwzmKbYMKe771qgIfMCdL4smUyERWn64C5U3n6+DXNA8E52t1UlF?=
 =?us-ascii?Q?cGbLKDyFpp2QS6+N8fwU3OCPxAB6xridDr0WHhPEaOb2VV3MVqv5wAYlSK5V?=
 =?us-ascii?Q?CnQuCUrhZioyVGGftIyokoHmrw0DkA7LRQrIwhPQZ/1z966l/miS5TNUWS35?=
 =?us-ascii?Q?ZpTz3Hrk5rvO+Fu5hn03CfKYhjlMeJI0cX49PoBYd73v8R63ITA+SsPHdlDi?=
 =?us-ascii?Q?PbUEqJANP3LGtn4tw3dhqLW1uFFlcS/yucBBLbIPVCRrEWv6QpMdl0VMAuvK?=
 =?us-ascii?Q?dhelKff7ACqC2wnc9tqFP5SrErjec6vv1jIT9AmoEXmj4wV3EZCXR5bToliw?=
 =?us-ascii?Q?rXE2TgVceExQJhSHWizWbuoR+67IAGHzAdITwHjkpJz17ZDEoYDH5nrmYKMz?=
 =?us-ascii?Q?5nqtJ2XZnZ8ywu0HdOg+8foixW5zvc1a6VFUqPNkMUUMH7UByKvU0jKU36eO?=
 =?us-ascii?Q?htAJhcdHx5whT8w22einn288dnlNr/ubMLI68MAaMjF6k0fON2C5s7CKBJ85?=
 =?us-ascii?Q?+DIML6YloNNQ4B+AVtKCbBRx8JI8jio3Dlr1OooEVKf6FMo8/nyY+hxiQakc?=
 =?us-ascii?Q?5kYdDxqfVhO+K2BjooYuA52VdSeupfoiSGe/4vLg0hlWUhn4bifhhpUIJOyA?=
 =?us-ascii?Q?WcbiTtBCLxSdtMVAOOKMReMtpo4AXmhYOntEQOytliPTqNJPyOEEvVdekPTn?=
 =?us-ascii?Q?fwsUCJKkR4Ts8jFnTCNHbQUC5zh0H1ggzCgEx5Wlr/NDnWMLzbvFQPMGEesh?=
 =?us-ascii?Q?bKzCsr4D9mIqAxJ9mXo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37dd5910-7ffb-4ab5-9e5f-08dd5eb980a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 03:21:37.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F61vss6lfOGXXUoCTH192RtoIHt+fjC5anzy1N5UXZ8SL14T0mCCKaZjCUhyEOpmqL2N5xiifsd65ygCecZAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210



> From: Leon Romanovsky <leon@kernel.org>
> Sent: Sunday, March 9, 2025 12:17 AM
>=20
> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > Hi all,
>=20
> <...>
>=20
> > Ultra Ethernet is a new RDMA transport.
>=20
> Awesome, and now please explain why new subsystem is needed when
> drivers/infiniband already supports at least 5 different RDMA transports
> (OmniPath, iWARP, Infiniband, RoCE v1 and RoCE v2).
>=20
6th transport is drivers/infiniband/hw/efa (srd).

> Maybe after this discussion it will be very clear that new subsystem is n=
eeded,
> but at least it needs to be stated clearly.
>=20
> An please CC RDMA maintainers to any Ultra Ethernet related discussions a=
s it
> is more RDMA than Ethernet.
>=20
> Thanks


