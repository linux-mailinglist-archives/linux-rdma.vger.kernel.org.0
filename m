Return-Path: <linux-rdma+bounces-5110-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A39871EF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5D828B439
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2024 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EBA1AD3FE;
	Thu, 26 Sep 2024 10:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b="feSwu8lb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2107.outbound.protection.outlook.com [40.107.96.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8C1925B5
	for <linux-rdma@vger.kernel.org>; Thu, 26 Sep 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347629; cv=fail; b=Wk/ClCq+Dmlo5m3K5gATMT//r/pESDXASTN+5e8LGuf+pgygopJVn/HfHYeVkYNVAm7IICH6usQOkQPrsEsNSg3gQP57QA1M8jVJybj8TVKBK62miMbOSefJwuosz35CJHB1BTtL87nAyH3kVwXKiIdUNgeHQGLweU+aXZ7C0Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347629; c=relaxed/simple;
	bh=9u5FHSENDmPJ7ITVKfv1IzYlqw2AdqqJbUd6YogPaV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AK/V5nLgidxnqcrwyUcVdomzRNCj1xla+dYOIm2yx1YuFors9Kjxp+F9f4LPEdpt9gyk80R1XM9h+g9SJ01HKVDxmbj55JUzbWKQFhgFH8JoeMDUZQbgXM/SJomftOx1tXnPqJxJPjzKK8e4dCJIUH7P1R0TcrEXszSsMABNazk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b=feSwu8lb; arc=fail smtp.client-ip=40.107.96.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZQEaVGhIWxwDB65cBvdFy5jgvM4BAwKBrTV9DcaCtGwUgVmyYtnJkb/s4CujzVr31PrEbzicVvdm6x4UWXawUNsUnH8h1jTUvca5/TCMOJwLEzQ7CYvDRGUaVQTVPUW2KxtJuMqiXlKGeNmGUHTUJKiFxLY8uOOyA9mxHUHQbBGrkVg05kZgxWAaajPX5+vJ1eLPPcHyDAULkTz+49BOMyjYsnTHUpO1Rln0KJVOcPR2nHw00XvuXj8CMzmvVGQ6fGKkhtyg6xDODrcqMiNrn/IYZWDHcqP9VqHCNTK47TJp7sGdOB6B7ZkGDlgW8vK9RYDuAl9c4JnzwYE1TXUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUiIHT2fFvabhyS4ZaPp2ok5/WtcltDDdpC8Iq1upCc=;
 b=Px4S/dTWDdt0Oe/DeQimpYRNDOcX12FXhuPcPTDqSfZPSCRW40Nt8Si9hGgYikGMV0EQ34NdnSkN0liIpDukvwsmK/Ei9nQ0nbyrHOXIN8SvyfAapvd7jDMuvj6l2zLwaJJg0SSXQAvzZAx23Faditl8gIVEkEdI59A4aegG3B8X1Vp6/QlR0hWU+U4AgG7OlLDhiqY1ZDoZhrkUoOPgS+bWLan1upjOyEoMtty3qQEIx++ERku4ZRmhc/IAwt4OdW/62lOl3Je23fKJ9QlRMAntzfjXf5GUmDtOl8k+FCjyHc34nkFesVyRT8lHEzs1iraq5LLR5RC36YsjZD12lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUiIHT2fFvabhyS4ZaPp2ok5/WtcltDDdpC8Iq1upCc=;
 b=feSwu8lbGiqQ8Y62E+AjI7ptfn+hlGRcKhGbYMGaaBEXY2sqpuALahYT0Zh8FU2y/a+98plyjyBISMLTW2CHcKz/AoG9u/Ni5jrrCfTal0/FRE3laW8j1PomHUwN/ZdiF/KVwV9oYJFfazlPur2Kl6Gbpq3rKJ433UlmFuNrsr0=
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 10:47:04 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:47:04 +0000
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: Leon Romanovsky <leon@kernel.org>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: RE: [PATCH for-next] RDMA/cxgb4: fix kernel panic for RDMA loopback
 test over VLAN
Thread-Topic: [PATCH for-next] RDMA/cxgb4: fix kernel panic for RDMA loopback
 test over VLAN
Thread-Index: AQHbD9iOHTj3pzsef0qDualrFZ55FrJplHAAgABOQPA=
Date: Thu, 26 Sep 2024 10:47:04 +0000
Message-ID:
 <SJ2PR12MB79638AF1DB54A084897823D3AD6A2@SJ2PR12MB7963.namprd12.prod.outlook.com>
References: <20240926055705.77998-1-anumula@chelsio.com>
 <20240926060520.GF967758@unreal>
In-Reply-To: <20240926060520.GF967758@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chelsio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7963:EE_|SA1PR12MB6847:EE_
x-ms-office365-filtering-correlation-id: 87d3730a-fa60-4f77-c6ab-08dcde188f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NwerLrdWU0SyD/P9H+sQqQLSqUgjBjT4rXVGTq7GHOFDPrHamCJpl6l0+JhA?=
 =?us-ascii?Q?4A7cTBhkqQRVmD5EXSUhX2ezxQpWPjT1Yw9x+KszGHnag17DBsm5gfcdodVr?=
 =?us-ascii?Q?OEI6h8JPO0zpVswTxD4u9DmWDlfIrPu8Xez5CZn+w8ldq7ZmQ0iipgGtdy+B?=
 =?us-ascii?Q?abD1GX5G1+0nEKOh0L8cVvQXfa24jWUCU41gfEoVewM51A2bFMocpl7+CFow?=
 =?us-ascii?Q?cbPJfSiNMpFru1ZvTcAfz0ZSN4wHUHLtSm3ljgm94/nGwSe2hgaJlsKy+77d?=
 =?us-ascii?Q?f97B1AXhyCQzbFsFkjS93nAbLwQ8KaqeuzaxDxFcUbcFJ/s2SbDd9nBHOCSV?=
 =?us-ascii?Q?wwn4s3wCA08Bf7w9GbbxXtbhPLWWng6+JKxNBbB8tCyRJsRDQFQOWzdnmN4N?=
 =?us-ascii?Q?zs10rCPJY3otKfdDofYJXjciHXTIEXGHDBHBLt0Tnfq5vd4/lycEWwlXWy14?=
 =?us-ascii?Q?EKDcM6yDsQnQuoLlBSSSDwYWZBggZUR4D5IemHh8lub//PehHo8a0s7bFP05?=
 =?us-ascii?Q?qRu0ebHuP1bUE0khTV96E1JfWSlvQzD3J0Cz/pXvhVSEKmZMOSjQQOAPi1aF?=
 =?us-ascii?Q?AuGDY1AU0+PV1Chg4tO+YbOCelVOzF0i8IjwdtEzhZHfmUl17dYAhDW8A6np?=
 =?us-ascii?Q?b+I/oRsPwwc+Z0es0a283fdIdwGP7HcCzFHyEXQJmw6k+1TVegtiwALDRIfH?=
 =?us-ascii?Q?E8FolvYg6Qg6CKRMzZvGqi2lLzi78ue5GEJU1KlmMLvB3Yqcg4YCKE9SCOeG?=
 =?us-ascii?Q?en3K3Z6W7a4AtWJ4/b50/iSYQZdQ8aNM57YGtIF63GHTeS26PmD9tjpW9nGj?=
 =?us-ascii?Q?8W/lgYGR9QuFSjUxl0jt7aAYE8qcrIS7XE0mywV/7KCxqcZY79DcSqnGvCQ1?=
 =?us-ascii?Q?Jz73rAp3hYNVdbl3CnO+XFD1DHTKTc3p4APCmo1caErtjEaaV3sYT64R/vMs?=
 =?us-ascii?Q?0wkY1JHzYUyxZYpj8TySb8VBBSLLVArLTLgXIAw48oeus87F2E0MWWTo8ZXY?=
 =?us-ascii?Q?MkrF8b9iUe0kvD86gY7tdx9Wc5XxgP5cATDkwlRRkwZxbZSUUKJ0nzN6Ky2R?=
 =?us-ascii?Q?sPplt3EG8xelqqbyoRaEdaDhwXLu7L5cfjXH7LxrskZsMFRzpGfSwxpNvOUJ?=
 =?us-ascii?Q?bFABJhA1FFIV9EtIRKY9HtTbUaYrNfqw4h6lImMNcvIDex8fE5TnbBOIqgu1?=
 =?us-ascii?Q?Zw/YqQjoPqaOMYUCe9pDs1iG+82jqIQ1V89APj3ATqqts8IAJnkwNBUpXKH3?=
 =?us-ascii?Q?iZnAoH+/clqs/MOh19V+rIwddd18nWpCK1JZ49te//aR0vk/fsPd4vf373Fb?=
 =?us-ascii?Q?94URiJ30naKUS7GcYJNV3GZUFWSNwMJ+ZbEBbogzCa8xHQDhQWW7nfugBcmj?=
 =?us-ascii?Q?AJEElVq1GxuPDiYJmypnPio+3j8i+YNA+QDtwXUa3t2YF1Q1bw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HvI1aKzcbe60eJdx+LL2kS/IRQyZxdm2Hvj+U+a2Bnr1Fw4TqW+UsLcjTZ84?=
 =?us-ascii?Q?HkA4S1mLlebWlj64Ap1JINTz5OfTaa+yHwkJ93NdCH0dAnCzCT12eR3iwwsF?=
 =?us-ascii?Q?/mheSi2PYVKtNOVqdBooKrJq9zhCYpduJLs+FFkHjmbG4YtMeCwzZ/FZmi6A?=
 =?us-ascii?Q?TpemDTU94DPL8maG5guFL+BfBVqN5NLrxxF/VYX+pUfR4Je9gyHeHmvjej8m?=
 =?us-ascii?Q?PVftpy+TIb9wY1tgxNp3xEISQckvUKY+zvWmvLFB2oy9zghC3SMwGhxDHT+g?=
 =?us-ascii?Q?3PpKkET5ZuUAhdEZH7wyv2DISS5BHHjM6p6hQvV06dPdTtT2/nAXlv2abgVq?=
 =?us-ascii?Q?MN2D22BzKZQFZF0cPRa4Z4/ub0yOKzRGms9+0FPzKcHvHEymQ6gDfrjVFE97?=
 =?us-ascii?Q?gF57NAdu6filpp7bnetXcBsYYEj0JWveJnXnb0zbxEz0TFjj1cdm8uUe6pip?=
 =?us-ascii?Q?8UFi5S/vFMG39kQwTxdRhkdeY/kt3v9OiZateL84G0TWGbZFCr4ldvM/xQTd?=
 =?us-ascii?Q?41OinCyTQ5usPkDhsqFK2t9L9wexO8FC4/FzJHwsYoM9TlUpvg8fPIUxwcc5?=
 =?us-ascii?Q?q5dNf8DaLKz5I1ZtNRdEWphXnbEa3Rml9yIwJV18rLjUXarvADO/PCdi13mD?=
 =?us-ascii?Q?4l3FTMp8wyWdDI31fJpMuUDMQpXQ1cljUo/Xedp1LMMRRSYNJlNhcQYkZBcP?=
 =?us-ascii?Q?pzElxOeGVszNyMhNfwOwQ0mG13jVB8GguvbWauCethPFsxX09c+iblBpNh4i?=
 =?us-ascii?Q?WBnj+nnUEy+u4kNsJdhN0NQ7rQJ4wqwiFw9PK1OC0wCPWCbpTE4w2VhylSHA?=
 =?us-ascii?Q?SojW2dk3oa/91N1DxGyJt02FQWlAtUb731+rFqt+1HdNSuHTgPSwRphXLVlu?=
 =?us-ascii?Q?IRVoesLMaywYzy6glugik51OJekqqMEMwvH+Nft9ca3Lh2g8jHJDxnZB/DaO?=
 =?us-ascii?Q?wSmce8CLNBUUE+r3kE220v74REqVhGoqhphsADN5ADOnBpIAv61ACcE8EFq2?=
 =?us-ascii?Q?vCiXHvAief0qU9CtdViNgDBY9vEsABk8AcX0LGCWguH/9yMaxip5WJda6pO9?=
 =?us-ascii?Q?0Ou+G47eQ+QzFZzqF6Sbhr0ipQReI+c+vDveGJ2f0a9EwpH1jM1Iy7X9t5Au?=
 =?us-ascii?Q?Gq+9r9Mhw0ab4MXnw97n54hLj5d/nmtnPCN4JjBpTakHQcAgv9Sm0+4RQHRa?=
 =?us-ascii?Q?Gi/Uf3ZvgaH8VAffZLc2SoWT0Gm3rOb8TGBwgf7aqAXd2zr45tt/cb3lLYVI?=
 =?us-ascii?Q?B+txmDeOYc5Mxc3V4KfMR7XTT4a13de1J+EoqtUxw5J7McYgKto8tKFPwig9?=
 =?us-ascii?Q?1geGr1vlPBtwCm4VPg3ZxxJw6lcpcEL0TehztrWIb90P94UxVOZZ9A12BWhO?=
 =?us-ascii?Q?nvLDhBWF++YmC21exNWRsUJtrf/Onw2X4ad/bqsSFdLpNwzw2J2RFXwhQrVx?=
 =?us-ascii?Q?w3RVyaGrMdVnAWXaVb3f2MoFAzb2hvS7KVtn3w+nCgL7t2AVqCqxyNrbJx17?=
 =?us-ascii?Q?ZsHSbKRBpcIFEuxP722q8Ty77NToTbXSYK5LjgTyayqJQQDlFAJ1qFxxCaQf?=
 =?us-ascii?Q?aGPoAVW7sQWc+VltpkAlJZZOpY4OuTD/qCeTbMT4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d3730a-fa60-4f77-c6ab-08dcde188f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 10:47:04.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: miL/Uv9Ki19JhX/BGu9EOf4MuiQhhWJ/ZuHZobSO8YBhnhO5mfGJeKHWQNcNFwazu2JqrdziPT2kvKXGfut8II3Ov6IX9OJDE8PjgilFhGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847

Hi Leon Romanovsky,

My apologies, I hurriedly mistyped. Issue is not panic but a connection err=
or .
Please ignore this patch. I will send a new patch with right subject line.

Thanks & Regards,
Murali

-----Original Message-----
From: Leon Romanovsky <leon@kernel.org>=20
Sent: 26 September 2024 11:35
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Potnuri Bharat Teja <bharat=
@chelsio.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: fix kernel panic for RDMA loopbac=
k test over VLAN

On Thu, Sep 26, 2024 at 11:27:05AM +0530, Anumula Murali Mohan Reddy wrote:
> ip_dev_find() always returns real net_device address, whether traffic=20
> is running on a vlan or real device, if traffic is over vlan, further=20
> derefencing real net_device address leads to kernel panic.
> This patch fixes the issue by using vlan_dev_real_dev().

Please add kernel panic message and Fixes tag to the commit message.

Thanks

>=20
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

