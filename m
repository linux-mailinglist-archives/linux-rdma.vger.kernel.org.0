Return-Path: <linux-rdma+bounces-16612-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGTgBlZIhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16612-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6EF90AE
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DB9304BCED
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803AD1DDC1B;
	Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ASqAe6p3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013037.outbound.protection.outlook.com [40.93.196.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18446248F72
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342353; cv=fail; b=gL5+Ylhzv7uqdDEPcIYCv85GQWqHq5ZksyQGRirVktw4t37nP5fDCiWFHZjK4W0SKeEUpxXvwCmYXtx9VVQ725K1prPqb7qySuwSk95ra5Ayb/C54itGJbvVILtfkMeDMyMKPc0h07h82bOb0ANYlNIx8fobM29SJj/JLLFGQ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342353; c=relaxed/simple;
	bh=Gt5x3xc+vnKA+KdckTkgUsMI9kF4AVtzCAaTnCiPNjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXoPBu4ARaBfxLMnKFPfOtwl2Sk5QnfJMXZV8E9h3NSfEnyh6qPyjMlgQb3u/Ktm6NdKeRjBq4InSX6pHpfGDtGz8eiRxqGWqcGKPn3sny+gGrOFMaEr6HBunL4UgszE4mVbBgdi0Ta3/QHb44UyBE/BBNZvZpYx74jOV83aoJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ASqAe6p3; arc=fail smtp.client-ip=40.93.196.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqYCqqaQ1H/fwPcDAO0FA6gi5cCiG9pYOZh5b+KzwhvLVNRxF2WgqFrJG/6tdO6CI/OTPgkLY/PB38ZZWygXxqL0k3BtJ7y9jOajnpJ62EzJED7I46w5gdVkR1lAA6nGew27yP8LY00C3YnKwvES+ZDfD8t0imQswqwwFvYscWFWRwGwdipRf4cHDh/wCtNapTeWOMsXs+7u6O/bgQNfUhgBYSPSB2Ze2TTa7yUc2SVZv0ojaclerqvkl5X9CDt6EBH5HfUN9bbb0EfDfjfnVRlFZJl6Iu+Hcx+28BHZUs5tPDQHy8p/ATiLNop55Nn+8od0ZtTQSETH8lr10QRD6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K89haZdaLz/LFAyirWio307AHL+ZBOMSS3LeQz5/NyI=;
 b=Jsv4JcGxD1RTE0Asknof/Pg2mc+qwqDIIbZw2r39DnHcX83Uuv/IhdjSPNLL9+C0RFKYC88tAe3Ck/3Txqfsd+lOPgeJynsoethvrWXuEvfTF5kCWRagbHUJ/c/K5SBKfcYrYTRSdUEG0SCv2bUzy8Hay35hmI5tG2qMWWsu3EdVBAg4yURmCM5P7NTl96ME197WGM00kJC4/cMH71snYTvLZtXrs/lOl0vr7Jlrthw6NwEvCQj6q0BeIG5J3HMY+ok3BqCs7i1ewLkNFlZw3dsboVE9IgadOQ6jChB9NKhYwpy1XF3sbXZu0yXSyPW+uIwjbSedAZK55Wcr2INsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K89haZdaLz/LFAyirWio307AHL+ZBOMSS3LeQz5/NyI=;
 b=ASqAe6p3GTzYz2tUuhvydlmkm8SX6mPBzfr5iZBxiLz7jhHuJSBVRsrCHWusqMohK0auJoJiu0/8mM2w5zY4NGMNqa6vLZXEBF+YCYFgOeTcq2P2HUZo/cxqEjEiIu5NwOX5Bn+8SbGbf+RzWCE7jB4+2Zh2GLDJdBHmmAK4bAv9yKpHwEHs8lMBD4xyPi4SvTg+CBIb6I3xoXakLZNdWVRElxhFzL/D0F0tMEVUv9Z6kkkWctYEz84cZ22ahSr33qD34pKO87UAyDPGP3O4RV7B32s+3GC9vXiCnW7uRW84CYCK+blZKLoxn2QwJAcR2odZNGfGrEZNiC6fw86hRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.12; Fri, 6 Feb
 2026 01:45:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:45:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 03/10] RDMA: Add ib_respond_udata()
Date: Thu,  5 Feb 2026 21:45:37 -0400
Message-ID: <3-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: d6071fb0-969f-439a-09ce-08de65217323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?kDH8VdtmR0GCRPJWm7Hrvz1X9vUQJQMIBi4CqUT/wQBdHmrGSJfv+oT0dJQ5?=
 =?us-ascii?Q?3daoOtWRG14fpDyVZS2G1D/W0r9ZSAWkbFNlIIsxAcmWFw8rXDTEKSUTa0v/?=
 =?us-ascii?Q?wcsHAzEImW/YE0I3nbLHl5ZiFyOKHedJ5o22eS1ya51gQiVE2bYOXDeHCgPM?=
 =?us-ascii?Q?psMx9UHAGYG4ZoPcZtg9PKX3wZVuw7MVN8f7dkBg6sLD7nn9mpz8zyEHPjAo?=
 =?us-ascii?Q?ownOMvZFoBJBL+te4Ak2vevfDDxy9GYHvNmm2qlrdcxKmKndVetGAGyJpk1x?=
 =?us-ascii?Q?RapIXeOrRnzKWHsL/t4/TWxniCTx3LcuDiFwl8vsieGgfU0fd4ZvHi014k0x?=
 =?us-ascii?Q?PBmVKmM8gebyJG91tEUcJGg69l7A6Gp046xkyScY9QI+5kITEdyW9CZdryjB?=
 =?us-ascii?Q?dD75GI3tJ/W8engCSdyHTW2LOXhhOnZoKpHiqUb63RGf26YAMe0kqf8SGnYX?=
 =?us-ascii?Q?D08q0Lgk+Jm6D8LYfjUQdX5pIfs3c0tECFZR6kPmvQAmGcAf1xaFFvwhdTmN?=
 =?us-ascii?Q?ZqHulvYtiUZT0NCHDdjQlesq4RJvQxjQeKWFZ9l00gIZifz2Z9I+jYZ7YbgP?=
 =?us-ascii?Q?W29ndog5Yl5PEtbDE3dn0S67lSNmFC8THmB69ibKoxpkhQmK/4nVPKKsfQLk?=
 =?us-ascii?Q?sm4HIHCI2/sS4bkR4hHMluEnklR2ebdpxsG4a2eQkMa6whgVsnnIRzaV2DYn?=
 =?us-ascii?Q?v1QgsTGdbwGye8ErOpKRIdcAbee7zrzjqiaIxKQk2jRmWKs27T1qbEZBFqCY?=
 =?us-ascii?Q?0KQCVxyyBA0PGEtu1cZj03/VJ9ULPG3WMokKYE/XzC9kAFMuBfUg8wNtHObb?=
 =?us-ascii?Q?Z0JF6U//SjTMdfHYt1VD+v6C1AJOmqtwUIIa3WGaVe3UWWdznhQLwgT3GxFm?=
 =?us-ascii?Q?U6rIkxw7nw1ZtxeAU1REfymdPKtwpneA0iJN2PPPmF5LKBLvJgprR7866Rrd?=
 =?us-ascii?Q?fNwkoqN1vivnwgY0sfsoBGBMDTnDZFEHiEw6v5iXSHRkMMNz+Su9zi/fPm9y?=
 =?us-ascii?Q?wLYOyy6m4DlzOSc7vinc4RK8wDpr1YEgncgLNwAVSRdbFs52syr26SpoPbQR?=
 =?us-ascii?Q?uXjU/qbThm90Mvnhyu1Q9Q1H3S2Y/Rhu+W3U4Cr0IjwqAoB7OcvKyo270Aom?=
 =?us-ascii?Q?zl9sqTd3KPBHiRTdrH8vpoKHe99hti+JSY7O+r0cLi/BXWdyrICT6WWaDplC?=
 =?us-ascii?Q?E/Qxq/t08OhHaYFxvbkGbXVtW5BVDT5/BhU3mOWbQDZnjqbiQWUnDAE4MBTr?=
 =?us-ascii?Q?IXhHTSy8U8X/aEqw9mVkqzzZLgO9DTcXq/BBT8rVzuxoQlPe7EZhXrIhqtcr?=
 =?us-ascii?Q?qzFHO0Wu2SohB+tfLIkKTpm9VFUcMdtSxfDP9N7jiYD0iN6x0lfGTVePR8VQ?=
 =?us-ascii?Q?6W2bCbbnCX/FVLiZzOJdFBl/wb7lCtlQmsSHTorsCq/UkHpXhBTLW4QCxhmp?=
 =?us-ascii?Q?M/V8buWgWUvs0XGjogkQGR+hhrIKduPlVv1GmIWJTAEnduFHrnubmobKtgx7?=
 =?us-ascii?Q?BPRzECuHja4ElyF0UGWs50Ll4T0BUDhqHA3nEY1zOenAXn5RZXuthbWki9cd?=
 =?us-ascii?Q?jdava3uR8AJxdwDyZjM=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SBwCD31r99JY6y96VBcRv/el1y6LQtE5vlho4y0PV507AAJySlRrv+TQxHtf?=
 =?us-ascii?Q?JWkWyE3Vn1XnpO8kHBWlJbY/+rnNhe5xpAezYQonEZqwP1kSjImG3gqkZXVW?=
 =?us-ascii?Q?Gv2P+Z//2mUPU5IckigBbW0WLOXVeq10TSMQuprnRzWqKHYfdAlqMAs0/JJY?=
 =?us-ascii?Q?Y1PBnfUwHTOafJWB3/Mv5o8KaO/i6G6H2bl+yw4nHRAT9pOxJgvjY0SuoE5W?=
 =?us-ascii?Q?GBxW2890vPdipJa31FRc1nuSzO+bzESFm8Ft9bvfhzHtLvIlh1tf11FfXJov?=
 =?us-ascii?Q?vlNPIA9GTfEtyvEXCVsTK3lezwzjVH8ZW8Vup/HKNlbq+z5axLvEkmP+pNMF?=
 =?us-ascii?Q?lA+J2hUQiLCQBLLdlYHv0GkPWXylrwywFfdsDmcZL5zvr0oSidhw56pDMfxb?=
 =?us-ascii?Q?AJ3zUt7JsKtfYaT9jYmP7K30cQhkUY3qs1Kca8Rz7SkADKCHOxSzTW9y4ZrQ?=
 =?us-ascii?Q?sBDNLTRIhhzTtcvrOa7YGYpq+lsRlfIdTYEncAAAI++FuXmqQAA9EoyHSuux?=
 =?us-ascii?Q?h35FJD8L8JntsCVj4SrjAsUSKkuQEHRnTUzxfwD+o8x1Btp1lFlkc37i/MDz?=
 =?us-ascii?Q?f9yndKC9zCMNylO1OR0dnN9pLB2cZ2wTbxvGzNi452EmHZzuHUYEhc4UosAm?=
 =?us-ascii?Q?TSnPjK0/Ifa2nQjbGzoOUajScDtDYvKAcWAG6C/gRnWf6fRZarStU1qApmXi?=
 =?us-ascii?Q?mi3tj9kQzpMkjAebJpvaP9NhoIZvgHYJqJZmOyt4WCe7vhK6WaqC/dU+UGyL?=
 =?us-ascii?Q?cBVJ2LGz8iHWmlRG4tBE+bT3teM/6A9XC+xWVdmv3RozFDODB3R/ZrgqBFJs?=
 =?us-ascii?Q?V/vAmDjz8Nx5AWqtM9klMgAG/C63eB0CTWSHX28CWCiQ/rArDLjqVA9QZkTU?=
 =?us-ascii?Q?w90DXDexzQ8sl9aETHNRfssk9tyKLvlKNFjciIcTOK6oge99U2RhdR4j9bul?=
 =?us-ascii?Q?NNAj9lDbO/UTdthmgwyg/o3z9q6LfQdNofW4YAUhZmGhZ2mUxTmkJnh0HDFv?=
 =?us-ascii?Q?UXZxjuMeLf3qIep15HUfpxUYsaZmbgNBz4oGp14AxCQJe6Fz3dBDRtfbmmOK?=
 =?us-ascii?Q?xvftrU6b+paNMcre7grCsp0e9+aBAMyJ620XcAT3ErgDg+hmANqrliBFbZp4?=
 =?us-ascii?Q?KYmY3oNtgRB1weBn2CsfQ4Y96ik/ZFK7vtqObWzhgXxzp+0ZC7RjOPN8INsb?=
 =?us-ascii?Q?uC50rdPpUZVcuhjn/oFZOAeV1Ey2avg7E/78nnocRsXOcd2DkOIYTS+iDfde?=
 =?us-ascii?Q?B5GJVHGLgDMlbIQQUEwh9AzcNKiZtpjhhBgnXphoUsqt5Qy84lF6nZW/vsAG?=
 =?us-ascii?Q?PXzJ2mRHWmXMnlaFNKaNsbO6m039PEmwx5AWRFrSgrq9vwHSGecnuBuDb3Nx?=
 =?us-ascii?Q?rX+/scn6lW/kzyH/SRdnMKBrQ9805mbf/qGt2AcgnsE28eDRjelv3TuSwGDK?=
 =?us-ascii?Q?oQXYDCIptabVD2WZNdn6d+3sesWQsCRUrLmSqHcMc0jqhS39bVFRElx268gY?=
 =?us-ascii?Q?6T99x1e0S7+G10/SwGvTHzAo3rG8hCClOMDdSbLJYyjZ4iz5czMOyMqfgOaM?=
 =?us-ascii?Q?Q1GzF8rsNp/tIgEu7ia+QwBLzN9LZ3TJSP9q6RZsdPRg4ZgWbzlN6djxzAJM?=
 =?us-ascii?Q?woyVmROYyaVtaPQMGsUGwKr6YtG/sXvlAesFjkLEsZM+63G9qzvxfP/tpaca?=
 =?us-ascii?Q?v/YFmIBKZFYxpM34GMtey/xjVmeEqvEHMbDmzUANHlEEMLTrmFPmbiJ7juBy?=
 =?us-ascii?Q?Bqyu8+zFkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6071fb0-969f-439a-09ce-08de65217323
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:45:47.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8FeIu6U7J0H23p5GpPvypnaD8gCKmjXyPdGXlGpPVpKgfDM5RrPK98bVJmJb9FH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16612-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5C6EF90AE
X-Rspamd-Action: no action

Wrap the common copy_to_user() pattern used in drivers and enhance it
to zero pad as well.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index bb61cab2ef9a06..c0dd82a77e7a13 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3177,6 +3177,38 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 		ret;                                                          \
 	})
 
+static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
+				   size_t len)
+{
+	size_t copy_len;
+
+	copy_len = min(len, udata->outlen);
+	if (copy_to_user(udata->outbuf, src, copy_len))
+		return -EFAULT;
+	if (copy_len < udata->outlen) {
+		if (clear_user(udata->outbuf + copy_len,
+			       udata->outlen - copy_len))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+/**
+ * ib_respond_udata - Copy a driver data response to userspace
+ * @_udata: The system calls ib_udata struct
+ * @_rep: Kernel buffer containing the response driver data on the stack
+ *
+ * Copy driver data response structures back to userspace in a way that
+ * is forwards and backwards compatible. Longer kernel structs are truncated,
+ * userspace has made some kind of error if it needed the truncated information.
+ * Shorter structs are zero padded.
+ */
+#define ib_respond_udata(_udata, _rep)                                   \
+	({                                                               \
+		static_assert(__same_type(*(typeof(&(_rep)))0, (_rep))); \
+		_ib_respond_udata(_udata, &(_rep), sizeof(_rep));        \
+	})
+
 /**
  * ib_modify_qp_is_ok - Check that the supplied attribute mask
  * contains all required attributes and no attributes not allowed for
-- 
2.43.0


