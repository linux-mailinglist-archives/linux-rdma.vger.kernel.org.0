Return-Path: <linux-rdma+bounces-2544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3E8CA2CA
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 21:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AEB1C20AAB
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058001B28D;
	Mon, 20 May 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ecY0cSRs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2097.outbound.protection.outlook.com [40.107.243.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE41095B;
	Mon, 20 May 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234023; cv=fail; b=hv2248DXqu12UEeYHeZXzPqR0T67lrBdN9dnJirccYu9QYfZp3xDxu9o3w9SUxpAklwtJPicqO3x5lsIzjtlBAVA9hoUdTr+bYrCNToa9zX/3IyFx/0LqDI3G48HUE6D9cXZhnE2FgQ0L24dW24I7xQXbA6sTHS9GC+vNazdmvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234023; c=relaxed/simple;
	bh=OwJOtvmXlGSqnzDQ75Dt9wr5shUixSxAS7SoygpN+JQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qyEtKjYFysCu5Wejsu2R7pmxPNWeaq598DZ/OZDCp8Yu/YF1wCkTQ5gWEwODtY1q2oVNZ2gCo8rSYrOIyHiuHcFQuocmUxux1nfcUxaFNEJFpWVvx7hRAgG+Uxu4pQ7hsjMHrbd9Of+OwaxTWXLLqtYy/xhFBlIsX0ZwuL58KBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=ecY0cSRs; arc=fail smtp.client-ip=40.107.243.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDI/9x5mcffcKA6rEPPdCv+T4ltQyoD0CCr6BDRsjycRq1rDorR0jvh+eYtCZL0vUhKZFNtr+ChMUFKLB9eWA+dRTlaD3xGQONlkHvOUfEBOnXavhEXlR7KItnE1lnMqL9GFGx10vbssDH2tQxQUQFJFEFKN/72SUglzWzExsydCTcpdFdHNU89+KDsZ/BcJdfb2ZXid6SJN+eNVk4IgbQEkUZRenkFJ7YGNI8DKR2aZrRMLOi6nylgGgoxCyWdVafYOqmpnATNbMU4udkfF2EgTqGCNkFtYwcoWcBLj/6DCc3+KWy6dOUS2qsK7KQ7+aKYvVu5Gbp96nAq0blfozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwJOtvmXlGSqnzDQ75Dt9wr5shUixSxAS7SoygpN+JQ=;
 b=LvEmRSoShwTptrBNl1zysMCgcv2Kqtre/JCkse6BVVqxeo5wnuhnXPuX8Z0BFMeONk0j24UsOiuPgOzinWvvKOoPeT2NKPR9apNLBChCcWNtd69u2c8LwVHt9v1utSeNnYM1OxqluX0rvEapmqo1hcCNbFqY3SY0aSXm1DZ8VKMvUy31HN029RNuEHTt0pAKAcEdiMq4dxS/3XZ6DpIaSXyx+Jsz9dkV12R3xWworMJwdRnoQ35+lfbUjdTnFmOpwT8isX2gnqO09fQPp4VngpUt6tXYyuFS1GFYpJfaiU/Tn+PRxT5yDCOWNHijbdJM7B3gxMAECNcXMPlCjgdO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwJOtvmXlGSqnzDQ75Dt9wr5shUixSxAS7SoygpN+JQ=;
 b=ecY0cSRsVW9yC/li0NKRMn/VAWjejGnDnhkSCPd0VdcBeZQoCpUP5SupiE0BgwN3nRfaufH9T+viYx+eTwycLImo1TgaggG1ey3fjfZj+oPsavlJnT2KznI1djnCt/VFms2iKNIxpp0G9cZshREItdqrmV/vX7AHBJaUbHrbg3Q=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by SJ1PR21MB3456.namprd21.prod.outlook.com (2603:10b6:a03:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.0; Mon, 20 May
 2024 19:40:19 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%6]) with mapi id 15.20.7633.000; Mon, 20 May 2024
 19:40:19 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/3] RDMA/mana_ib: Create and destroy RC QP
Thread-Topic: [PATCH rdma-next 1/3] RDMA/mana_ib: Create and destroy RC QP
Thread-Index: AQHaoGRmS3lu0CflYUSPC0b9UVbGLrGgmkMw
Date: Mon, 20 May 2024 19:40:19 +0000
Message-ID:
 <PH7PR21MB3071DF00F6D22AEFF9DC1B81CEE92@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <1715075595-24470-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1715075595-24470-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5c077ae2-c61d-48b4-8357-703441c5f0ba;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-20T19:40:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|SJ1PR21MB3456:EE_
x-ms-office365-filtering-correlation-id: 78724c6f-b976-41fb-8223-08dc7904ae7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yOb7m03dHtZ07r3k2IBSyuuOEZfurZTY33NLPtrbH2UbRR3d+7My8h18rE8v?=
 =?us-ascii?Q?dVHIYALRAvHB9yDPffUWMBkjjBP6FPbHfslDWsLqAdOCvwU/T1qynnr45C+V?=
 =?us-ascii?Q?3jEQSNAtXDo83Ud2GdzgiMvA2+nfEOcxcuThWNdGym0CHVoMtupYJE1RfUBc?=
 =?us-ascii?Q?N3FY4SyORQAaguw7DpdNVGM5H/tHKcVEEs+ef+eJEu6mjRg/PAJqH3j9kRYK?=
 =?us-ascii?Q?R3tssV1UKA8EyEeZgGKyqrTUZpnoOQPWpmC/1ejlvYokbk+Qow/zfXku/Dco?=
 =?us-ascii?Q?3eP2FMMK+FLazFZiuycN4vk3Q5Q6AhgqMWOy58kwyKv1zDwhPcnOwecEdHcA?=
 =?us-ascii?Q?miLGsDy4P+M2WqmYfrYBw1TS7ZLcvTQmhRE98btszrtELbyiQPeUoasKmaPV?=
 =?us-ascii?Q?l6NH2WJz4J6OB5EYMkP6QWuX9o4G2Bb896j9SWL7i/Xat5DlDg1RSKbcI6uO?=
 =?us-ascii?Q?eN89xI3YvmvPmTz/LguaRjns/4CZiCNrp57b7rT/IWKNf4xu0MndsEl1HXt9?=
 =?us-ascii?Q?pWOXxp+EAd6ukQEheEiNE9p+4qvWPub4NdFlVOU0FZ6scfihobu5gaAkhYYO?=
 =?us-ascii?Q?iq+UBz75/cOJod8vTgRvm7k1bBqhVfZYCrcYFpx+SCaSrTTATFUB4ueFJpXs?=
 =?us-ascii?Q?7S4vqGVjlq19x5mN3j9ZA6Wnaztg906CG2sZD1CUqxtGf9zRPuCc25WFtBqA?=
 =?us-ascii?Q?CqpWDZfcVCY8S6Y6fV0QKkQp2cTHzFl9lK3fCS/6C/24qyccNL5lKW18z4HC?=
 =?us-ascii?Q?xvn6j+U3JNFiRRLnRgpRog2Jj+sLqKInstwmM4Wcr4FXCYPeo9QqVo5/OzGi?=
 =?us-ascii?Q?l3oxrQuuh+yXR5SU33hLciFO1RabVw2NJudnDD+tqQIxRJ6xGdCS21kZ7Ene?=
 =?us-ascii?Q?CpAozdl0x9L/zJEK6XeVa81SoCRRQ+AAzCtt+p4lsHofTb1lB/gGm7hnSTyN?=
 =?us-ascii?Q?NSLD+st3Xjoo2/hi+7IPAKwXthUjzUqrPv1knZLAqXXGHtyoZnRSvrQ8KKRo?=
 =?us-ascii?Q?Tc1u5qBNWW7bEyrTSPXZWJ4E5uZ5gazYslHphxln5NLGKhkJweBTrlUNIgfX?=
 =?us-ascii?Q?eGy1+GHIzRldvqIydEREaZ6LBTKgjmWooDq3JZBNiW2wVnMBuzO9diDnGMyH?=
 =?us-ascii?Q?zbkB3oEJuP4hRbZcbm1apehI/tsH6muDybwuicENPdDgxzAdl7VzGPHwreWn?=
 =?us-ascii?Q?JDWdWxVxU87A7b1aBnkRDXqN0/dSpAIX8Np5o5vCrWSBFWevgIsZSdSVKHws?=
 =?us-ascii?Q?+ExU/BHpvAFogrrgB0LuIDaMXzHSq47B/ue8smK1qJ3RdUgUHJSRJODYAaK3?=
 =?us-ascii?Q?96VfM7QS7hxt4kQB5yNVga0BbEXRKhhrqHiR4VBlJ8I4PA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cft7vGhWRfZSbSOvb11H6/szdCXO3pBb8zexELyPSQ3zlkPrKgiSQ4G/ZTYc?=
 =?us-ascii?Q?D0FcT/bdcMcpu3a8O9mkk5yM9UN0Qk7cVuNYdV5xwiKiwAL+87X2rNW4pxAp?=
 =?us-ascii?Q?FWOD8DCy7niPyal6TkBNZLsn/mL5cbm7GQcxNrfHHmZXbvx30UdvyxggxXxH?=
 =?us-ascii?Q?BiN9xa8mKCPocJYK4rgwVvctLQNFJNu1C3sjFHxhhyRCXRysAeMXfUKgN8Iv?=
 =?us-ascii?Q?P8VH2alcd0tQH9j1T65ZJn2G3pz6Wejt1D6kpf0SDlAFg+YvTOUDHnCnejrI?=
 =?us-ascii?Q?PsQwNpfW8CSmtAQmniaX7XFGXQYt7ZN3bVmBT1TKfBSytKbKtKspXI0Ive6U?=
 =?us-ascii?Q?jlp1P6qqx7cFEVK05/s037L6GfFk08TB9ZPrfb6NoRsJPsqddo3FYgAtMBMr?=
 =?us-ascii?Q?jiTkIHoCFZ/i7DyuZA4LNyLcX5BB00tlK+TZOvgw2oML+gjtbuiyGvvtzb8y?=
 =?us-ascii?Q?NjNc0RGAkR0TsmFbrZcF3IXIrBs1nimCd3gnc8YOzA4/tPjky4pULO8FDFX5?=
 =?us-ascii?Q?sL7BjdEkyaeKtrL1Qjdc0YjXuzQe2gekGF+mEllO00d0xoihBw0VFULct30B?=
 =?us-ascii?Q?61LO7KQbA7Cl+Y3QeKWhM+sSVevc826z2wU3lpVvvcgNwFwq/khkTl7BSe2J?=
 =?us-ascii?Q?vQW6ZzEW+NmdvNJS7Smtteu3qAtykandZenp4OIwVG1IByMFkBSPr89NGPDg?=
 =?us-ascii?Q?livQ8hSXpvTuOTHwJ0935BZr+aK3h1up+W9j/T2niumxsjfqg/Mmv70IaIci?=
 =?us-ascii?Q?tuZOk9LAcyx2uoNmu3m9hhnBOhvZxjq0+JUXLV4ICbajcdCt/fbE4UsguTkM?=
 =?us-ascii?Q?glJQM8idykkuam/oGn/7ZzRyfT3a2iwRgKPFLtwGus+TRtWL5Pn2PuXagPoE?=
 =?us-ascii?Q?L7C9THUtCUP2Fhr8AT5q5cptETwglVLQWkfC26A9BAjWtO1B0qYgzFa5WkXe?=
 =?us-ascii?Q?x1GbCZ85ja31qk4fnuiI6MTPdQIbGnX9Wg3WHIZ2+cBCWGz+PRlzVSFSZy4R?=
 =?us-ascii?Q?2ybyPxPTwh8YUlxzqWMA2w2d3nZ6m5M2USt1g7JurkTvcLeRGKbQhvO78zat?=
 =?us-ascii?Q?B0sQ1Z4CatRvV1yVwzkb+6vO9IrKqGmHU7KaqDNjtglWIWhSMO5dcltHD/uo?=
 =?us-ascii?Q?2bJHoWdRcDf85hklzROmYusYD/Ke63YShFftb7s95Y6BynGOJRiNP1EDnFT0?=
 =?us-ascii?Q?oqZH1pKuPDKT8vmviyZXZblhNzhNabTdlZU/itUlM3KxoKXdym2gk+UwkWUW?=
 =?us-ascii?Q?BuqcurXO1OIb2psNTAIN1rxgGgfknml04pdEp3XlwBj0NzUNFCGw3f1ItEuE?=
 =?us-ascii?Q?0XcmsZSk04IMGx9EpYt988Mrw+XpJx+mnXTOdFLIJ1Ch5RHqlqEODBNv5zU8?=
 =?us-ascii?Q?yo2g+ozsNn/fcVrpvsbhLU+wlK6WDLkSpR4QNzikK+eMN7+S7kWb3FHxa7gQ?=
 =?us-ascii?Q?WqMnEnv3HLQpntcBkjVB2z86FvDOutj1AsLVJtSS4wEW7qV2MN53aNgLx+s1?=
 =?us-ascii?Q?bPscJUNigW5NMSwgfLB8a2iVvOQ1cxtGb9e4YRx2prM7Z2Jp4cajEy/4iWYk?=
 =?us-ascii?Q?6KL+A+IiQW8sJ9lgkSmc4BFwNaGY619Cb1VPp3vH?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78724c6f-b976-41fb-8223-08dc7904ae7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 19:40:19.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3f5CthlvqlM7KlzLJF5eR12uUWJFEqzSNb4Q/zSJ3F/QdEqH8m4ofdXZ7uR2xzsD0hGNRb2TE2JIJE0LHokfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3456

> Subject: [PATCH rdma-next 1/3] RDMA/mana_ib: Create and destroy RC QP
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement HW requests to create and destroy an RC QP.
> An RC QP may have 5 queues.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>



