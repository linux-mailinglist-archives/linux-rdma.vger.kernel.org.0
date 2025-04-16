Return-Path: <linux-rdma+bounces-9493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94259A90B54
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3934189DFC0
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 18:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC9E223323;
	Wed, 16 Apr 2025 18:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KEt+uzO9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022131.outbound.protection.outlook.com [40.107.200.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B4217F53;
	Wed, 16 Apr 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828298; cv=fail; b=CuWLC5iLHa1CJn+yzpwi56dHrPDL5TQYJNdYYxUTgVX8sFcFqKu2mTidC+IYbB3XWVRxjmPLvb/1KeS8pxK01yudJ4E+UfGgUORlja7jgknG14LVyON4tXkshmgSlDpAIBtBf4UnKf4kKxRVAnzYThSzteX6cNIbfKeiX/thAOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828298; c=relaxed/simple;
	bh=IK/DJbcJ+KIzQ1Ldu5EFqHtIcZlkQ+BK9oGS8/e4iMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MNI1OtWi2rtmG3bYGo1u886JVmPmcsD1S4UbICH3JRarehoCORb6k8FCIvXM4AkdZ9PjLVBTG/sL4EBrlz5uk1in+fgft7vUjb0bZHTJSNS8911DDPJbz6s+XwUNZM5HFXfeuWWanPSNku/oXDFInwq1pLWe+j1qh+VH5e7smqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KEt+uzO9; arc=fail smtp.client-ip=40.107.200.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfwynXGuG93hL7GKbNKywS84K7MaH/lfiG/V32hD3LrokqeZuWL6ikzIE8V1jRUcoEH2uIUtw0vlWXDE/NgfrCk392J/6iBusKnwH5RH+3k8PcEmsYUn37mj9YSRh6vAVlWyKGtU+8RwGzpuu/VY1PyY/HKntlwN0vZdjP9LaB4Ky/1H63rSW4MQRgpj07gaF3Ghs1hzz/HNT2GK6Z56/ATNEYdYuLj60YTuf27qTwPcaeq920N6FEnoK55Zsn7ax2XMUfowR1KpIdmZr9TeArdwieBbNnmnWevyPhLKkJCg2LNciB0J9Aj9YrjUsO79W9ZWWCEJYIITEJRbnbisQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/VtLPyHaQ0TPWw/KFc7cSvkKP8rL5ZWd1lJQgAdH+c=;
 b=VEf+p1/9o8PpN48hK7Qu1bT/BrWM1feQ5yJQANMbYpMgTIyA7k6e4ekKwNtXb/vs8C+AfrTmF6RCaU4+E1XdG7KgeFV6FiRyBO3OC+FAox0nFqoFoC09XDwbxvt35O9j69df8qMaAAkBwF6Oa6QOcb2Y2GTN8vPtw13MYJYvP9uMhMRFghio3h8NBGgckAG/7mjjaBsPVbtIL6KuDXRY86vDTbOrwpbNqD1jer31/bI/LSH2OaapGyEnlDsGEHr5aTl4huWxp7YPQB3kwSj+ehWt5C0U+ICVTmEh2Pb40KsPyEz+77Cf2CDOvlFwqXfjtBM+wde+jg+S2qkvsf/EXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/VtLPyHaQ0TPWw/KFc7cSvkKP8rL5ZWd1lJQgAdH+c=;
 b=KEt+uzO9qF2vzeQPVI3aVavD+pJFodS6LUvd74386XiMhxN6HRrsGZaScF6IP9bOlHmQ0eQAd1L3cKowbIMj/cfMLSrPHCvo1GS1FhKMnKk+rRYIKWi3WHWMhXsTnGunugQ4fCF127HwAfMxxvDCQsAMf5v7AP+jNNAEmEjyJ4w=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4461.namprd21.prod.outlook.com (2603:10b6:806:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.8; Wed, 16 Apr
 2025 18:31:31 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8655.012; Wed, 16 Apr 2025
 18:31:31 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 3/3] RDMA/mana_ib: Add support of 4M, 1G, and
 2G pages
Thread-Topic: [PATCH rdma-next v2 3/3] RDMA/mana_ib: Add support of 4M, 1G,
 and 2G pages
Thread-Index: AQHbrRu1HRrqZxufAE2i+YKgKOPbj7OmoTlQ
Date: Wed, 16 Apr 2025 18:31:31 +0000
Message-ID:
 <SA6PR21MB4231ABCDE90C9420D521EFFDCEBD2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744621234-26114-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1744621234-26114-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e32c46f5-3330-4934-a137-1ebe98b54bc2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-16T18:31:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4461:EE_
x-ms-office365-filtering-correlation-id: a2423dc0-4234-479a-2fbe-08dd7d14e8c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sDCUrXVzeLOy/SvtzJVcbtIg5ZldtyS2pkkpv3ZWv2Nd/SLedC7/0ZTzOZoI?=
 =?us-ascii?Q?NdTwCYCDoCOM/U+/FFAk5nNpAmtOkA8cOO4O1Kv92usUuT37rYn8T4QDAmSA?=
 =?us-ascii?Q?z3/pbykqz+7HebavJxH3Kx6Pqi1QTjAvZZjK06a1YoRy8iuy7gx/zES4OGbo?=
 =?us-ascii?Q?AkCufuCBuhZ27Vub05QYL9fyTYX4t8QFhKOa6LC1UlC9A2+y18GmyzMHmlqq?=
 =?us-ascii?Q?1Oocj8/YnkIwRSiVin+c1uv0x+K2R5zpnDxsDAvs3NCVQWEkLXT4zYDSIj0p?=
 =?us-ascii?Q?SB8BT2GAYOvuhtW4mzq+Eq0iy/tmcK088pJtE8sfFDrqGgDPNAPvNBwmCF/6?=
 =?us-ascii?Q?3V6ieRJ9HqhbX4/pI9aWC2o0tkG6VrNnFavNO9IOv6NUMOhSXNdbaCgwQK25?=
 =?us-ascii?Q?rumeFloQ/FeEM9kQiojoq0hvzqViQ/XagnPk3Tr3xbmbu1M2OMqAwr1JM1xu?=
 =?us-ascii?Q?CYw2kDtllZdkou2mu/lIJb5hz9qQG2m1nKI8tvm6RMnYqTUJ9PTzei9oXF/5?=
 =?us-ascii?Q?H8OM0Q+YbMUjwrUOBEKsynW5DzASsB8ageCWX9HHL7W0/nu+lw4t72R/QNeE?=
 =?us-ascii?Q?KQJES4TCPjER1rbv0SiTsJh9KB+4nTQwK0laLZrcdigXowhD9o39OwnK4nSi?=
 =?us-ascii?Q?aIaWs0yIzNW/2lxtrMRFAFJ5+8AwU/AoxJRBSXNrXNd7t0aA5fs9y85HzSLn?=
 =?us-ascii?Q?Fs5CEZA98XbtrIcZ6fKdquWtn6d4PDTRkViSb7snct5/OAjVESDC0WLDNjgw?=
 =?us-ascii?Q?l2NxgcrI1M0HzM/mP5hzdtVVln6bky36U7bQBe1cyb0dXUR9WcXo+67oLH+0?=
 =?us-ascii?Q?dcOxRMA2fw9EMbhIed1k39+o0paaI7uVdXlVWoPjfEJztjXA5HCx/r7QYGg6?=
 =?us-ascii?Q?ZXd83NH0NRYabP4bGACsnuChjsVkyCDujRop8XyzXSploZrHv2EA2eTzDoNP?=
 =?us-ascii?Q?Ba55eYTRUP9l3Ca+0ky7hwpVQF37jstav5qumRfJ4Ofz83JR5KMTjmWmfDzr?=
 =?us-ascii?Q?lB3UEAeEW8FhDJF7CI8OvXer10aHzGwnrLVLkYSpXnt+bIfuaB24F1IRj+W0?=
 =?us-ascii?Q?ZCa988aOfY1LqkDutYq0QwfGkNSZ6NuC8QxAhxKrSHqNEzhqHnDXY8v35Oke?=
 =?us-ascii?Q?IY2O4i67OJtphY6Yt2KVNOFUaIz4dmtjaNoadSyVJvkx12+I3k3agXiyhe2C?=
 =?us-ascii?Q?P2aE36LX8KfBTTzJ8wQEIoTnDY5HHoTDvUJn1OLjodqdECTlwgAgU+RvSbuW?=
 =?us-ascii?Q?Y2rScUrcLK6wqrdCdxnCc1iydH6Osw0tTxsB//s9WqQxGgr3ES6m/z42Eye6?=
 =?us-ascii?Q?lyYyUtiwQOfOhT4CXrEd87ySUCPf64nmEqeVh9YO2yDWYIPFc+e+ZZ0wiC77?=
 =?us-ascii?Q?wJ9lHDyN23jVrIEtpk51w6I8+b49u2mYtYPDearqblegQqA+y9NkZKXymTuU?=
 =?us-ascii?Q?G1AgNWJoElkdKK4qmgXMomhHyYAt3L0K0/wkrxpt/8zANRIo8buRlp/JEV5n?=
 =?us-ascii?Q?p/EkgkBIfafgGhs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DLsRzRtbgfMLWPCUUI9bIotgjsKikNoQ2Zog3g0DTe6vFRRaVa3r4iy0x+VQ?=
 =?us-ascii?Q?AHG7n3XJFinkUUqIlAd72hu4TLAMYKOQighb2YAS/VxsOpTfuQ0kTodNfcCT?=
 =?us-ascii?Q?cozzA8HXyJK0DrdQoeRdLHkXMmol7hIg1j4LoqD9/5KVUxdI3cgUVI54pyR/?=
 =?us-ascii?Q?8XEbhnXPzKIohVu07YXSyY9KcXl0EJTSRdPZVg+RjssS9QwRIhNvS7EAWITT?=
 =?us-ascii?Q?HS6WRyMYHA+AAm4HpDFuDlj5Ny15pWiX1YpQ+fSBJdgE551cCc9OKjZhliYd?=
 =?us-ascii?Q?gPwbTB7MRx1qXzUHrSmvXX2vYI37LX19/vJU3kEFD4R0D2MDouSiGEV7Yqq7?=
 =?us-ascii?Q?NY268sSH2HvNuichfxTyPcPRqkk0GkWuQ96iePdem1uSwdxjdKww9hAiyniQ?=
 =?us-ascii?Q?+mhzmHfEaEACZqX4KK29g76oIuyW2kwQbT6G5r7Y0HP7mnZ0e1koyATdb4di?=
 =?us-ascii?Q?IiKRaCpv1fo9PYgDDlkEBBqeLZdUu8NphWGAhjazbcJprua4B8HfMUA999rn?=
 =?us-ascii?Q?d/RY355Sm03rIVffEjmbxcRjTvucoww52yG4lb7uCxbt2JYy0ydkJiRc+4I1?=
 =?us-ascii?Q?/PkBRRvPC3Sn+HrKBa+hykJjSqPQkv8MOIuarFxcgrPCVrUpgn2B3ni+lklp?=
 =?us-ascii?Q?/5rMaOnYsLG3hXPvD84/6XZK1MDcpG4CBhxBiVEl5ppZcwidx8Vjb81kCRbl?=
 =?us-ascii?Q?Iljx25hyZ3TfaO8V6CB4FcvmjNXVPh1ijD0XtR0MpFlEyFUerneT0DD2NRTn?=
 =?us-ascii?Q?TXbbrTq9XQiH0kmEVYJCgroHt0BgKLLoJIVbMLvG3MKrY3i7vunpMQfYRrLB?=
 =?us-ascii?Q?YnUxM1pWSRfwKurhsVT44dD7VULpdGS5dXiUt+5020nDfpN288o3od3XnsRb?=
 =?us-ascii?Q?jJexcyGIv1xFOLy+Aau3bcvX46cE+0f0Sw2qrZBchi2yyHja14ds9riiQfSQ?=
 =?us-ascii?Q?HpEQZvdGyvetRzB0wvxCo8uN9jLZjCpuHbXU+atSVYUksmjjKntEZR0ol9iU?=
 =?us-ascii?Q?CPa6UZrHRfpQULaI8KksoZW2CpBIS3TxMpjjy8TnF/QCbbeqyU2AQPlblEd3?=
 =?us-ascii?Q?YeAAspZHMQLXeEf0mrX/zB5JKjr60ZhaR3EbUEXktFrelCSE3wpCxXzWLJJM?=
 =?us-ascii?Q?PgVTCL5AnNp/kWxwVO61XT/Yx2417knbOxSzcyjyKsSUkrFj5Kl68rQcC3RF?=
 =?us-ascii?Q?/VAnhEsLnrwfuhN/yoibippMp5CGjC7OpLuUIFKRcvHtj90554U3/ZwIjkb5?=
 =?us-ascii?Q?nTVbMnt+Jz80A1n4k5tCvFuNAqetK9kOJ4611vlmmbYwHTnlc35sL+SKaqKi?=
 =?us-ascii?Q?rG6CgM0IH+gYqBugrd6ftGf1S2VcdJ3FLE90mo72mkd+tgrAtReefy6e/wbD?=
 =?us-ascii?Q?5xmrV6+u3YhLklyXdgHl1HNkGDECI35cGmI3zYDBg39MdRprC+BrhP+jItT7?=
 =?us-ascii?Q?ODoINcUa3U8ENNLediL9Xuvl7+GDKy8Amb4zXkm2XTD/TB2j6IEg6/l7grVv?=
 =?us-ascii?Q?nbTtAMtGHncm9sENkAYtCN/c2yVFSIOrLMs+eAlZjxp/MmcM75i9WTeemii/?=
 =?us-ascii?Q?6ALfF+HyqDCbY7Pa8ChEen5qWqFovmtpais2vrcO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2423dc0-4234-479a-2fbe-08dd7d14e8c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 18:31:31.4258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGEW7/Xhj4UOvEGIDi6WqBQ/8UZRNcR71N3Y+g9FYarwlx6BqJU0BvUfjMJTRJWgbbgBFO8/0XKakUALVLAfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4461

> Subject: [PATCH rdma-next v2 3/3] RDMA/mana_ib: Add support of 4M, 1G, an=
d
> 2G pages
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Check PF capability flag whether the 4M, 1G, and 2G pages are supported. =
Add
> these pages sizes to mana_ib, if supported.
>=20
> Define possible page sizes in enum gdma_page_type and remove unused enum
> atb_page_size.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/main.c               | 10 +++++++---
>  drivers/infiniband/hw/mana/mana_ib.h            |  1 +
>  drivers/net/ethernet/microsoft/mana/gdma_main.c |  1 +
>  include/net/mana/gdma.h                         | 17 +++--------------
>  4 files changed, 12 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 730f958..a28b712 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -479,7 +479,7 @@ int mana_ib_create_dma_region(struct mana_ib_dev
> *dev, struct ib_umem *umem,  {
>  	unsigned long page_sz;
>=20
> -	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
> +	page_sz =3D ib_umem_find_best_pgsz(umem,
> +dev->adapter_caps.page_size_cap, virt);
>  	if (!page_sz) {
>  		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
>  		return -EINVAL;
> @@ -494,7 +494,7 @@ int mana_ib_create_zero_offset_dma_region(struct
> mana_ib_dev *dev, struct ib_ume
>  	unsigned long page_sz;
>=20
>  	/* Hardware requires dma region to align to chosen page size */
> -	page_sz =3D ib_umem_find_best_pgoff(umem, PAGE_SZ_BM, 0);
> +	page_sz =3D ib_umem_find_best_pgoff(umem,
> +dev->adapter_caps.page_size_cap, 0);
>  	if (!page_sz) {
>  		ibdev_dbg(&dev->ib_dev, "Failed to find page size.\n");
>  		return -EINVAL;
> @@ -577,7 +577,7 @@ int mana_ib_query_device(struct ib_device *ibdev, str=
uct
> ib_device_attr *props,
>=20
>  	memset(props, 0, sizeof(*props));
>  	props->max_mr_size =3D MANA_IB_MAX_MR_SIZE;
> -	props->page_size_cap =3D PAGE_SZ_BM;
> +	props->page_size_cap =3D dev->adapter_caps.page_size_cap;
>  	props->max_qp =3D dev->adapter_caps.max_qp_count;
>  	props->max_qp_wr =3D dev->adapter_caps.max_qp_wr;
>  	props->device_cap_flags =3D IB_DEVICE_RC_RNR_NAK_GEN; @@ -696,6
> +696,10 @@ int mana_ib_gd_query_adapter_caps(struct mana_ib_dev *dev)
>  	caps->max_recv_sge_count =3D resp.max_recv_sge_count;
>  	caps->feature_flags =3D resp.feature_flags;
>=20
> +	caps->page_size_cap =3D PAGE_SZ_BM;
> +	if (mdev_to_gc(dev)->pf_cap_flags1 &
> GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB)
> +		caps->page_size_cap |=3D (SZ_4M | SZ_1G | SZ_2G);
> +
>  	return 0;
>  }
>=20
> diff --git a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 6903946..f0dbd90 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -60,6 +60,7 @@ struct mana_ib_adapter_caps {
>  	u32 max_recv_sge_count;
>  	u32 max_inline_data_size;
>  	u64 feature_flags;
> +	u64 page_size_cap;
>  };
>=20
>  struct mana_ib_queue {
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4a2b17f..b5156d4 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -937,6 +937,7 @@ int mana_gd_verify_vf_version(struct pci_dev *pdev)
>  			err, resp.hdr.status);
>  		return err ? err : -EPROTO;
>  	}
> +	gc->pf_cap_flags1 =3D resp.pf_cap_flags1;
>  	if (resp.pf_cap_flags1 &
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG) {
>  		err =3D mana_gd_query_hwc_timeout(pdev, &hwc-
> >hwc_timeout);
>  		if (err) {
> diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h index
> 3db506d..89abf98 100644
> --- a/include/net/mana/gdma.h
> +++ b/include/net/mana/gdma.h
> @@ -407,6 +407,8 @@ struct gdma_context {
>=20
>  	/* Azure RDMA adapter */
>  	struct gdma_dev		mana_ib;
> +
> +	u64 pf_cap_flags1;
>  };
>=20
>  #define MAX_NUM_GDMA_DEVICES	4
> @@ -556,6 +558,7 @@ enum {
>  #define GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX BIT(2)  #define
> GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)  #define
> GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
> +#define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
>=20
>  #define GDMA_DRV_CAP_FLAGS1 \
>  	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \ @@ -
> 704,20 +707,6 @@ struct gdma_query_hwc_timeout_resp {
>  	u32 reserved;
>  };
>=20
> -enum atb_page_size {
> -	ATB_PAGE_SIZE_4K,
> -	ATB_PAGE_SIZE_8K,
> -	ATB_PAGE_SIZE_16K,
> -	ATB_PAGE_SIZE_32K,
> -	ATB_PAGE_SIZE_64K,
> -	ATB_PAGE_SIZE_128K,
> -	ATB_PAGE_SIZE_256K,
> -	ATB_PAGE_SIZE_512K,
> -	ATB_PAGE_SIZE_1M,
> -	ATB_PAGE_SIZE_2M,
> -	ATB_PAGE_SIZE_MAX,
> -};
> -
>  enum gdma_mr_access_flags {
>  	GDMA_ACCESS_FLAG_LOCAL_READ =3D BIT_ULL(0),
>  	GDMA_ACCESS_FLAG_LOCAL_WRITE =3D BIT_ULL(1),
> --
> 2.43.0


