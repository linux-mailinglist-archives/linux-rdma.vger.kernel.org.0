Return-Path: <linux-rdma+bounces-7076-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06FEA15F50
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 00:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2471F3A52C7
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 23:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94881ACEC9;
	Sat, 18 Jan 2025 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HwKGre1i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ozVsyPMr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FA61E531;
	Sat, 18 Jan 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737244382; cv=fail; b=fu1lc8WICDffDUJoZuPFwKZ5aOKGJ13AZrrWAuioHyHr7ePvgNoskXavz0IyOVEfEXQ0NQEpDlpRanqTegRiJlsMxDi9NnSdp1ECJUmvfnh6+Ma5gFO2Cyh/KGFoSoUehTD+bxs0n3Wk97BoSQ3L0N4uu18Y+bJy4bhXFEVVfsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737244382; c=relaxed/simple;
	bh=NJ8zZEBBCYVQ3KW3UIM4zZJG8cbsLjdDKkmuzlO7ADw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u/LY/woWHQxiNyI5w03c44I84HsJpzpYRAaKYY/pkDaQJ/goXJhbMCrxL98EU2bDpibKM8Y8TbcLx0FmzyUvLJABuum87Xv2tD19sPt/jVGVcMaORIMZAOMFOHug9s7yddc5ajNH9HwR105PMHhHsxURF+7NJi5dxSfKsagrt44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HwKGre1i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ozVsyPMr; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737244380; x=1768780380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NJ8zZEBBCYVQ3KW3UIM4zZJG8cbsLjdDKkmuzlO7ADw=;
  b=HwKGre1iyJcR5wCXMloAodhGNTqWBWsbZG/lY8j8wXFZJuImwUHJLI5Z
   0qqgiynR6XZ5quv/Qzy06MSwrM6B9tp2nLaKVi5HDeVmPl9BtcnG6L0Wt
   EOkKhMRUp0dUQMOZImA5NpuZXWl3fO8ToamdZdl+XG9OpTdIt5QwCx9S0
   7xZOLLiL9CpKt+NrEal4CkqAErZRBm3ACQNLUm6ss+j4pUxcdQ7TRxiPM
   UzOex73dZ2rmLE2VtgvA508NWae7WNKTvFQjUAwox7Ii5Xv33f22SSOtm
   Rat/4V7hWBs1AZy2Nz8PLdOtVrIi0pocfTSB8h/ThkCroWjaEii0ZOTol
   g==;
X-CSE-ConnectionGUID: 1IxlkJKnRsKx7N6i7y1nDg==
X-CSE-MsgGUID: icXuOw1XR+KQGGHsPXpS4w==
X-IronPort-AV: E=Sophos;i="6.13,216,1732550400"; 
   d="scan'208";a="36035975"
Received: from mail-mw2nam10lp2048.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2025 07:52:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1vhW3pMn2eb3gKv2mwjjLAcQ03YeprzJbI61Pyu7ZItgn/7Aj8jrHTHedQuvW5RxbtbCFeOuIFpe5eS7kjb8TcybydC54+EBZ4WCxzc3tbvdKrwKcFwXpoRR9cPAz1e/rZJOA0qw1XVzTPq8U56sTmJ5O7FkT+E8uLpjrKk5EhE55U9rHTAAEHYkNNfmX+cYGPJbQUoEu66FYXC8+TV1FWe1v1PHioJelj2FnSHnq81m79+QIWqySfXD8br8FzvdAfSvoXreD+rVM1bcGDb8JKpiYKP1CxBN4zUkfqploscyXEk+OOW8jsA5mO/z/Uzj4qwhu8Z9nfSrqyJF1qjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHH7n5TCSw0D4zFUxI17UyUwc/N+CoUUzDbLIxkcJ8w=;
 b=uG2Upt6xmlV1KZBkFK60VSV4iH4r8U2MxPE5nmrfXu3yLH8i6ocJuRpVuNopJYPcdYtYN3zIDhagW+s0XHrClN8uIufpw8Q6kd82o6SVAQ0uklHkIXy54bpUWJCK3+tBtt9ycRIvV4AgIngdWytxIUkBD36goXH+cjT+wSQXMdnIuwFsdEmDFOT9kzdeS1p/+IM6/j0Wuw4NRpjNb9F8A+FTLnKgcn6uz3/umQM/A/vTMNVXxMNXSXZbUUbBGuZUd8vnobL2mgq0VhuiGp+14bdwnMeeOs/bmGMwydMn34VI8fr8R7m+VmL/wrUPDeF4bsZMrDNn1ZNomk8QH9xkLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHH7n5TCSw0D4zFUxI17UyUwc/N+CoUUzDbLIxkcJ8w=;
 b=ozVsyPMrs3sSvpIwqqHb+7nn1BpJkeTnTiKQMPWAv/ldTNVqWjKDuImDZ+BTNzFsKeFHsKMuLdTs5s1K/5v3Ibdui1jX8JnhwWAW9VJX2LuLni2xiehvuBrfCxQ4pzOV/WrT4f8VTQ0/w2s8MRsg9VK7S3ICV+nwESeDbRzjjOY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO1PR04MB9651.namprd04.prod.outlook.com (2603:10b6:303:272::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.16; Sat, 18 Jan 2025 23:52:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8356.017; Sat, 18 Jan 2025
 23:52:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH blktests v2] tests: Remove unnecessary '&&' in requires()
 functions
Thread-Topic: [PATCH blktests v2] tests: Remove unnecessary '&&' in requires()
 functions
Thread-Index: AQHbZ8vqXf7hBM7rqk2eXSRJL31jnLMdOJCA
Date: Sat, 18 Jan 2025 23:52:51 +0000
Message-ID: <n6smucmg5cuihm6qqmgb4jvxj24b2tnd2w6ugf4go6rtqgwbt2@qggqqfpdpx2f>
References: <20250116040525.173256-1-lizhijian@fujitsu.com>
In-Reply-To: <20250116040525.173256-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO1PR04MB9651:EE_
x-ms-office365-filtering-correlation-id: 0e68e0a4-f2de-4a17-2b01-08dd381b3876
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sLPjLxTIhEZmlsTwBLdOYLQpdfUYZ5sMXoz+5/Cf6OaP3i3NQ/0G53CKLdk7?=
 =?us-ascii?Q?jspeEdn8Xr0A4vyyPp+kujutwkYRRN15Yn0JcqGBg8RYLEYYgkmYlHm6ADrH?=
 =?us-ascii?Q?Pglj+A9yOK1xO85OnBjFCqME1ScDgoWcDUjveH90gV2yYLd9yiMLWobINC1s?=
 =?us-ascii?Q?x/sPw94BEiSmYTbsuKCD1LD7+YL0EbiETC0WJlvjQc5lw+9voWtBcGFNJwx1?=
 =?us-ascii?Q?JZlvgQg1aMdZV0JVaPoU/VBNUTCT3byOpb1rEsFtGCHEj0yrqdHn5VLBV5NK?=
 =?us-ascii?Q?pc9J9JXcAQIPuo/v37BrRWYETd7z13II/bDW6/oiuOPDeNp2SeUA9mOoQnSW?=
 =?us-ascii?Q?ndkANaazq1BQeVt5vxl7JNu69TcEBfNOigoRumJEnIgrf6Pz1stSlgyuGYR0?=
 =?us-ascii?Q?eI7/oAoxDK9WWSIR3rCJse0EZFXiOFyiL5QZuzNDInwXqLG6D5NrDtOxNF/3?=
 =?us-ascii?Q?j43MiR5JPJMVmyZyMLcQg+2Fjh8A5pcv+9oEFSO8+vQzwS/TYK8FZQdRjECf?=
 =?us-ascii?Q?92rCwTKGDaCypb3wRARjYuZeE3vhadJIDzpBavLlO3X+sK8l26YZVOFUT4cr?=
 =?us-ascii?Q?RnMvEzG+Uf6MfwCFTZZ/IqlsdYjSeSKvLPXg+bwb2MOWNrK1DsZUkvjdYr00?=
 =?us-ascii?Q?fjre/ANnO11dAeojbrKZWK58TJTC4lMywFg1ZxI7UWzW/Bv7a29iKfgVbiWU?=
 =?us-ascii?Q?Blqn9L/VtNnkBL+r7oKiBzMP5XOb+ZVt+0KULmzomeE7QDLi7wo/SYZlKghQ?=
 =?us-ascii?Q?ivxp8yr0CNOlrdVraV7qEg6c06c1xpvP2rXjjAsdhT7QsT20p8WO663oo9OX?=
 =?us-ascii?Q?AEq3tl/l3HR3zsOf4n721lKPa+1rAMpzCepM4RG3aHQR1oPaiNe4Dn/gumFM?=
 =?us-ascii?Q?fDXGJZHCYK7VkXxCIWUSTdLl96bdjSCs13ThRtLCaffA9kiWv4h8LxZFUOQq?=
 =?us-ascii?Q?gCJAKhSZXfidEYaL2h0aG92KjkOEyVgC8hgVzk1hOKVst5TgZnsnocLw348s?=
 =?us-ascii?Q?kR3CMXIhjDIrbACLD1tKiBXMvyL3x58xGkbPPxvmV0tGxhrbIbhr6PyRpa9V?=
 =?us-ascii?Q?Q7Eob9K+xMOefzd9wYdllsVAUaMR28N/VDWGezN98LvBaasRz+66ZYhLdmDT?=
 =?us-ascii?Q?GIM11EqkCtNKiIwWlfkZiGlIcJrHCHwEG4udpVTc8MKrOq7t5VxXRN5GrAEe?=
 =?us-ascii?Q?64ptublrq6byEDTOCCPLYK+aKLpJzTxe8A384ypUGIky8kW7eqD0xST81n7q?=
 =?us-ascii?Q?KF6GWfBeUIGnBjLe7YhTX33Ypc+uLY5WipxsFHDl13aSGGfHA1sMNhyIu8yY?=
 =?us-ascii?Q?BMcOO8y+/1UazGbudMP7Yv+YKy0m4uXUOpB06519PfNgIE/CXPHN5uUxCJ8k?=
 =?us-ascii?Q?s/WLCSCzUpbkexEZEYs4XF7nCVemM8VO00h79/HbE3JyrbbKy0d8JKtWJN3W?=
 =?us-ascii?Q?/Az0n/Q2E8D5S+np5lcqHAAKOcHISC7h?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oGAa86be5Wcej+Yvn7uXWfsP3I0c2FSHYk5ZOSlALpek4HU9aIjvSCPrMwla?=
 =?us-ascii?Q?OzSGceW086hBiwDerIFxh2+/O+CDSCgQcjlHSM0VLdzTrhPWRWA8F8869lGz?=
 =?us-ascii?Q?iYZkteMxSLVEumEZIb1d/TbKufM+owXBvNF0wem7Vv/NXvnvcEx25bo1oaGr?=
 =?us-ascii?Q?G9uS0huBhDcDyw8gfM0iGvBIRFPIag5TRzlnRfK1Bd2TFhklRkSZjp3Lim/u?=
 =?us-ascii?Q?sltTP9AR0DEgqNF5Kvb54NGPgdswjOp4jdA0dszx4U8Vk1MbGQUkfbTHP3jc?=
 =?us-ascii?Q?tcCCiFgTHGEInmWqcIUn6lS5QQYOezGBrXT06X43LaFeu0ya6HKDPA45VsT+?=
 =?us-ascii?Q?hpCujkz1Hgs/7jpsDYWkS8ClKyt2kahblPvaHNLA9oAsZX1p+MSOodNz7MU4?=
 =?us-ascii?Q?ElPSEsH+knpeiD07wHlTsxwigEnCnXI7vUMYH6EwZpYEAuZacyiJ7MwuJ2IS?=
 =?us-ascii?Q?RnfBOZhV00xS+4yJmv2ksnqbYMdsGCWQtwYBMP//NPVT1W4Y2uyL3q9vfzcJ?=
 =?us-ascii?Q?nvG9B/n8LQhsZJ+7fBhob4SPqIwC+rUfQuTUlmkQ23Oy64gWxaVbyxl+ldms?=
 =?us-ascii?Q?cvME9zZ09bC9TjRXepf/8gKWfZLyIPENmvSZEeepZQYeAqBPTb+Nlk0QTF0p?=
 =?us-ascii?Q?vEiDRdpt/7il5gGY5y+u9/ww9AwV9QSsUrpdbyzI/+g+DimkkihzdI1tvQ23?=
 =?us-ascii?Q?Ax91HmIlRU9rWuSJj/bO940UkSrXU5TkYl2uryW7pA02EMv0WJdohtojTL3t?=
 =?us-ascii?Q?Jjxd9Bm8J1HpQKIlisMxKuvxLIOD+U4jns8P1C5rnsC2fLlU2amm4UVYsHzO?=
 =?us-ascii?Q?oQf4E0u00niRIWj2oj/J03+BrB/HAzdO/ZTMiqGgGBWItWb/uUVyaAI/aJN1?=
 =?us-ascii?Q?NjlDiMSQjJgP6EA5mQOAwcGX2akZhErLV3J/F2+2oJs66lseC7k6Q2E/JQJ9?=
 =?us-ascii?Q?RhYlQTEatLcmMgPljSox/PfUvSfPMxb7KAXbHdVRJZAPzgdX89ZJ67koAdsn?=
 =?us-ascii?Q?/2rJHfqipYh6X01zoIcY386Zy4lpf+JIQZv+PxqIdYRcsyG33ExRd7XIcphG?=
 =?us-ascii?Q?Ex14vVVWC0oOJUwScdu8mhsXqP+3ZR/BsG8sb9ESUXmlVtVWyS8nznRctPwE?=
 =?us-ascii?Q?3j3mXR0RlpKfUsXzZrojFWLrDbnRatuxusZdK86jCXl8wPtCEEaMrh5eWY0g?=
 =?us-ascii?Q?3kSIduxbnWBGKKgbxNb4B9MoIYsQvivwFdFcf1QLXBY9+a5DkJ0XqqDMGHX4?=
 =?us-ascii?Q?dfcurvj8beH29PMTrQVF8RCgrBIIrhx5qcZKhMpMheTy2aPy1v2VQBSeiMyi?=
 =?us-ascii?Q?L0CVEZNU5Ef4RHzSml/1/WVmjTbZtmJG5q7K0ZZNVpU5fy0PARxARI+iS7hU?=
 =?us-ascii?Q?t00D/Teu80mBu5CccRy8a/EBjk+5mUcb5HiyW/6RAfqT75Gc/fnGRMIx4qyZ?=
 =?us-ascii?Q?nwgIhMtaVWGA9/WPzQVMOdcpAgD5as907WFor1bhrCUthbhyn+LoB8eH5ejp?=
 =?us-ascii?Q?n3Lqv/4Ry07WirDP8gy9Vcul2YVZbK042vAEkEksplABGgW12bcEiCnFnJM3?=
 =?us-ascii?Q?OACNmm8Le34CgMkLC+dlkx6F5x6bliFcQnKZEDXjGRbPXJoryp5UgJjHmAOx?=
 =?us-ascii?Q?9qm8hFljBEXQafbEum4ZuxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90E380CC657F944891F13BFF6B02CCFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VoVRKEM9IUhG4dx8Szcce5aruLXl45QelBIM4GnDZ24pGHIPjmIHkYPBv4eJto69d3kmYPFHJ4z8FiJ6Gb1CzYlIDsxhBEwJKt25ANL+3wz58FS6lKgafqQuXlQcXyybOLWwFInZf1Rmk1qolt116XWSa26d5ymb2NjH1v9PMJu2eVkL6uVX37JaPxNZisORtxKaSIESWkMSJTOS6NkCAcybciWv0WAQIE7jmvQxIH2r3oxBC31EaBcxeM3CFoXlaqrymoLyAybjxTFkGeD9nGj0lcrJWHLaUF+f+Af/fG8rSOnLKzWIHis5y2tQN0yoHZd0eLYil0TX/gOXgZ6xirjIusNaAcfFcn/1W8nqRrcih+3HDHJiTrP8MijozxqxvUB8167WRAQKHdNXfO5bVOYsAWn0QlN+K6isBmKeUcH/p9o0qjYJxWNYGf6HLKvKI+3qW0JGgu2PJteX8Or6MbUl3qLkhD7SIcfCo4KiUJsXitb/wpUHOkB21nK4JjHsIqsHpYYDWkJS9qPuGiDWvmgQFK4lMvephu2cyUdV7w9ikW44k09y8CfwtgSzEgABJVGg5B+J6bPF13zqs8fqq4d0Yc4YXGSNtiUTu0lfm5QaxrxqFgn2qMpMQ74+kzPV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e68e0a4-f2de-4a17-2b01-08dd381b3876
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2025 23:52:51.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44RNa+QPvpEUlgp+ZTG2D7MDUk7CwwqQl+0jDUaOP1MzmPmKKsGUaJppFV4lF5OF2j0S/Qbo8N+EgHq9Y9ysb+n51wTuDV4DqnfUIW7FXW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9651

On Jan 16, 2025 / 12:05, Li Zhijian wrote:
> The '&&' operator should only be used when the second operand
> is dependent on the first. In the context of requires() functions,
> we prefer to evaluate all conditions independently to display
> all SKIP_REASONS at once. This change separates the conditions
> into individual lines to ensure each condition is evaluated
> regardless of the others.
>=20
> After this patch, there are a few '&&' remain
> $ git grep -wl 'requires()' | xargs -I {} sed -n '/^requires() *{/,/}/p' =
{} | grep '&&'
>         _have_null_blk && _have_module_param null_blk blocking
>         _have_null_blk && _have_module_param null_blk shared_tags
>         _have_null_blk && _have_module_param null_blk timeout
>         _have_null_blk && _have_module_param null_blk requeue
>         _have_null_blk && _have_module_param null_blk shared_tags
>         _have_null_blk && _have_module_param null_blk init_hctx
>         _have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
>         _have_program mkfs.btrfs && have_good_mkfs_btrfs
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2:
>   rebase and
>   Even though '_have_null_blk &&  _have_module_param null_blk' can be sim=
plify to
>   '_have_module_param null_blk', I keep it as it's so that we are safe to
>   have updates in _have_null_blk() in the future.

I have applied it. Thanks!=

