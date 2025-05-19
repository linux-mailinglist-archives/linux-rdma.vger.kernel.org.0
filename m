Return-Path: <linux-rdma+bounces-10406-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1AABB67A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8974A174E56
	for <lists+linux-rdma@lfdr.de>; Mon, 19 May 2025 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473A42690F4;
	Mon, 19 May 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ke5Oc9aa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N7HsKevP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65598257ACF;
	Mon, 19 May 2025 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641413; cv=fail; b=mBrQwcZ5ARt9A+OE/hnmqPP3FWUzHZohFIrlhly8tqEtjhvLtQXKsOe4xDuFI+gv9jyCVpvqVGZJ07IKvNPBKl3BvU/+TO0CVvIE66XqXsX08MXbCxATER6Bujf+9kCYgC4Y+CAs39kRpdaQHEfMLUA3cytgG8pK5UlTE+kYEkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641413; c=relaxed/simple;
	bh=D4B2iwww8TAzA2V+MMnekDG+mCe4NSk+VYUdvft7Tio=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WuguF13d5847/ApEh0By8pCJ99MXYVQVvwa/UHlc5PjMSmP6+7IO11wA+xxHwx2r2yLS4/H//M0mKozmgcDQPgK8TrHOPodhDEqMlZyD8yurN71MKcAedyBrbiPdL8VYXYKVY+KO3xBWmx3UZXck1q7iWPkANiTEQfxS4Et1byg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ke5Oc9aa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N7HsKevP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6ijBE014380;
	Mon, 19 May 2025 07:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uSXrYdGz0C1gnkyJ/MnPx5ggHolVbKCiMQRN8UyD8Ds=; b=
	Ke5Oc9aaPaK+PcnD3aYqOtSlBVoPDvHsAytDkZSyZThqITMiohZCog/nYBd+czR4
	/1i69OGaUJDMcwl6AbKmxPZqo+6bZjKenaTbUc4IcFde89P6mciTRKtFH8/Db7Ht
	Q2uQR4WmdaaqwAiodgDxqergA/5PYV/fmyKBxfoe9WXyfNDGfyQb24o2CqvaDxDJ
	G7OY1CTJ7gdtHnebsXkdLJ0JLj1efxcBO17iC899ir5A31Wwgmy7HpogHbmQP37Z
	1cn4BAI9FlYXNILPdcq7bt6l+iuihBWdbXO9HuchVlnZ3JGU+UjlPx5jm/QSPnJN
	FjiIE9uVAg81cx2LdH9AGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84jbu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 07:56:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J7Lth9011877;
	Mon, 19 May 2025 07:56:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6meu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 07:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C49L1LjfgfWICnMDOKC3oMVPCY4Tou/lui/b+t7lhj8UGb6DiRsDdCXu7sSFL3sTYn+qjoLQA8jjI/9b7ZQL/KvCNJEnNkRE+dr5EzJuBGuEEZo8LMtNJZ5HcTZ2enf1ofdlgW/D632W331WUISQXdrehhO6PcZEd+5lebygEU47yiMrCAxOCgoKd7E1sX4pku8GDrsz72li8K48X8BpqHvVykqML4pbcLieDxCsZc7RogORTivrsRGs97fogMpeNe56kSXXOdCjQxEGCiKWk/AstWYLhMOw3J5yGfscTC1ulUkLu+nfrPlzuJi556Iy6xtFsjRmgNpNiCwTSb4HlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSXrYdGz0C1gnkyJ/MnPx5ggHolVbKCiMQRN8UyD8Ds=;
 b=J1DfXEtnyf3+8v8SVqPhZ8VdO3oJQ9jdRZjje6eOhMIdLIjchdNr6Krqjzo/D6JD+TgdBDFiFs1GA+mZNWDuhN/G+zqWtfP5bpoaVst0miT2MN+JrG1PrmqEoD4NoWZBNogBdLXHNh28iQoyJjERFMxeczRSbjVYWGZevnVu+Iy/c7mHGOqZh7pEWu1fMDMosn32CdBmLAwAml48TYOartF9IKDEnMOzvx+cq+3xg4FkZhr7d0ByC9ituDoxFe1NtNDqlEDNtMIcXmTqfTku/dRe4k0kccfrqWA5xJibIC+4xT/CfsMgmRawQ3JDzEhKDWKJiluoMYzoIEVw8QUGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSXrYdGz0C1gnkyJ/MnPx5ggHolVbKCiMQRN8UyD8Ds=;
 b=N7HsKevPC7lmpIVXWR84oBTlGYlwNZq+SG7xG2x2rayXQ9bilbZovDInPGWqua197Ycb+iIUh3zEfFz7251o9umeVlAsQRZrgDlk6fbGWSik3oWghZNND+YP4AI8+i1TgHcaMaRA9T0DQfKB5C20hU4GFdscYH8ocxlVirjuv5k=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB5723.namprd10.prod.outlook.com (2603:10b6:510:127::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 07:56:28 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 19 May 2025
 07:56:28 +0000
Message-ID: <3d64750d-e394-462f-8356-9571f1b70173@oracle.com>
Date: Mon, 19 May 2025 13:26:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mlx5: vport: Add error handling in
 mlx5_query_nic_vport_node_guid()
To: Wentao Liang <vulab@iscas.ac.cn>, saeedm@nvidia.com, leon@kernel.org,
        tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250519070114.1320-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250519070114.1320-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0016.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ac5e0a-512a-48c0-b636-08dd96aaa8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWZEK2xrN3p4K1c1SERqT3dmbWxobVNnSHBvWWJKeW1nMktFUmdTeDV4TGdT?=
 =?utf-8?B?MDM0NzZybStYcndzbTk2dkZXSnJIc2V0bE9KbUZURnJmN0J6V1N2UnR4cUw4?=
 =?utf-8?B?WFZYeGFLYkNGeC9WY3VFeHV2RW9ubGtMcFpDb0tQeVNmOEtvanU4WW9majFh?=
 =?utf-8?B?MVVISmU5cENuZkFoV0VTQUJ4U25EQjhxbjM1cjNjSEI1T201TjV3SmFGb3Z5?=
 =?utf-8?B?S1RPUzc5aXozdVhtQWNCRmhtU0c3REsrUitTaWpjQ0lvQkMzdklaYnpOL3JD?=
 =?utf-8?B?M1JxbXdiTVovUnk1d2NCd3R5Y1lxV21CRWlhYmpDMnQyVGk1UGZzYU5iOVd6?=
 =?utf-8?B?TE9MMWs4UGp3R3pHRWtLS3JtNGVJcUdUbTZKc3YvRExCQXl4cFNjRUtyakZv?=
 =?utf-8?B?clhNOWZXTnVTdEhPdWc2cFo4MzM3elR4SEdVQ09GaU9vSGhvYVdUMnRLcHd2?=
 =?utf-8?B?cjFvWnNFWm5vWHhPd01VZU80YUVDTmpOS2NYMTRHS1JQd3FMM05wdTVET3Jy?=
 =?utf-8?B?VnpnNkpXQk1xVzFBOEZQL3dhT2ZsQ0paUVQxdUpTY2hSbUxiOVo3Z2Y5ejVM?=
 =?utf-8?B?dkFhdTBmREFQYnI4emY2bTFhb1BHTFZMMVRwL3lHWVZKbkhUcy95RHEyZDdR?=
 =?utf-8?B?dFJ4L0pnNlhkMS9wYkZ3MVpMcWxmbHJHQ1lDWkVrbG10SDNFWFFpeW9PVHlY?=
 =?utf-8?B?NzAxMFk3RWd2bU9JdHdDVjR0WUl0M1J3Q0hRNytabEl3RysxemFoV1laNFpp?=
 =?utf-8?B?aEFOYXFpZUZIcjhhcldBRnViZGZ6c2d4QWtTSkdmQmt0NVpISzNFTGtYbnFP?=
 =?utf-8?B?NFprQlFEZEt6MGd0aFRzQmZYVG9ac1RzYnlRMmpXeDdZdGxFSk4wemNoY1R3?=
 =?utf-8?B?anpWS3RCaGNLdEwwVHB1YUhHNFZOQWtxMXVIUXptZFlIazRsQjhGNndReDhG?=
 =?utf-8?B?TWI0eFBOdUJlS2RMUUVHVTFsaTFJbzUxUkRWQVpUbHFldFpWNm9wRU5hbGk5?=
 =?utf-8?B?TFlFclpwZWdBL2Z6SlpzbVpiaHYwT3M5Ui81U3l3MkY0VGNwQy9NYkZRNGl6?=
 =?utf-8?B?cXN0aHRRVXh5MGp4c2JHUExQRXBGaVliOVdxVlRmc2pSZnVxRjhkb0ZXQnNm?=
 =?utf-8?B?cEFrakRmeGFvZzVaTXBDMUkrc0xIbVdnM05aNGgxMWd2U1I1djhIb3dYbDQy?=
 =?utf-8?B?ZjhJYVdBZUt1Zy90RHBCcFFWeEQzalFpYmZhdk1QNFNQMGZjbk1MK0NLUGk1?=
 =?utf-8?B?VXdsTEYwOVBleUpoK3loOEQ4c1hRaDZJdzlaVDN6dFIxTkRldU9xM05EWWZL?=
 =?utf-8?B?UzBuZmF6L0J3OFZESzRyZ2VUMTZLLzhGT0lDSzJhbXpQalFoWCtLSEpJVlcz?=
 =?utf-8?B?Y1l5VjFkdVhTWEdyT2ZFc0MwODRUZDdsaWRHangyakJUandMNUdCMGt2L2R1?=
 =?utf-8?B?bnZ0clN6bUsyVDRPMng5ZGtNQzcxV3pmNzY1MVJkVmkxcHpVayt5NGFsbmFn?=
 =?utf-8?B?Z2ljSDNySEhZbFgvU09jVThxUHpZbG9tRG96SGVYTTY0V1JyK2puWEIyeDdN?=
 =?utf-8?B?MjhpSU9sZUMrNnh2S1hyTlpRb055elZtK0o3TDV1SDZVSE1uQjF3Z0toc1lM?=
 =?utf-8?B?T3NLd2w2TmI2OUNoNDBzdndaaWQrRmFMUXhweWN2d3ZXZWZQTE9YUjBZd3Vn?=
 =?utf-8?B?ais5aVdjSkVRa0hnbE9sZFp3YXlUK3FjNjkwRUo2RXBDblVMdTB3eUIvcjMv?=
 =?utf-8?B?UWJ3RGh3cEloNmlDcExDS2ZqTkJQYytrTmQwK1VZQVc3djEvdThNK0FncmR1?=
 =?utf-8?B?cmxlaEsyZ1BoU3V1c0tNdzJpU0NkNHQ1RlNKeElYN3pTWlBBeXlxbDdmc0Zs?=
 =?utf-8?B?VW5nODNnaDJGSzY2bGZXWjJpZTArdU1JZnZKRStJbEU4aWhPZUJPVHNkWW8x?=
 =?utf-8?Q?mtqs7tqN2DQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFmcWRkakdHUCtlU21aTUt4UUtCRXc2bzREN0sxQmVOU2NZdEt4N3oydGZa?=
 =?utf-8?B?Y1ExbkhQN3c0SnlkZGlyOU5YcldIQTVYM3dEU1BicnQxT2NCbk9JSis0Y3dB?=
 =?utf-8?B?RzNaSmlvQXhDYlQ4cTVvU2RHSmk5UkZOWDh1TzNHeEdFbU9wNDcxcjViSU5y?=
 =?utf-8?B?M3BsVEFZT1NVRS9lRGQrY0sxZkVQcklJSVUrbnVuU3F5N09tMFREaXNhQTFN?=
 =?utf-8?B?QjltRC9WY1gzU2liZVVyR0JVRjAxeENueVozV0VJdGxqZmhRdmttMG1hbmpO?=
 =?utf-8?B?bVJmZ1dnWkwzT0ZsTEtsS2JPYndkd2MrR2xWOWdESERiVEY2aUM4REhVWnBz?=
 =?utf-8?B?R3NORytoeUd1ZlZmcDRGYzJtL3RwMnRvVTNmZnFPL01TYW43Q0o2bVgySWk0?=
 =?utf-8?B?WWtIMmV0QkpjSEUvbGJ1aFIwbFp0NS96RmlIMm9UREdQS0hCREJUOFJ1T2hW?=
 =?utf-8?B?dmFUSmgzeTU2TnVROXRFOUViSWliQ1BnN0lNcmo1akVLU0pRdTBoSkFvZTVO?=
 =?utf-8?B?blVtbU9jUHYvM29JQnlKOW1KV0RKZkdCbDZSeHhXRnljdms3amxUdXNidXFa?=
 =?utf-8?B?UXJSbExYTllIYU5GRTgzNGh1bG9wbjVyTlJEY2FxTHpuQXFaVlowVHNMMU9R?=
 =?utf-8?B?YjBvY0xyejFRV0VOZ1h3eWlUN1BaZ29ldVdabVNXc3B2Y0pEZjA1M3I1TkJJ?=
 =?utf-8?B?KzZ0Vit6NUpyaWpQdGN0Rm1YOTNCYjFzL0xkSWVxZFcrb0V0TUJQaUo3VzNU?=
 =?utf-8?B?Ty9HSlBZMk9CWFk2VGFoeFp6cFVQbXVuQy96NE9lR2lqbUF2US9KcTBDdzNp?=
 =?utf-8?B?dnJQNHlPVDZlSlVkMFp0L3dNd0doakZGVWpSeURuSEx3ZFAyZFpIZ01aZEk0?=
 =?utf-8?B?NjM3RDIzQml3S29CbjZpTForTUFyNnZKeGkyODh5RE04emhoa0FXeEZqTWpo?=
 =?utf-8?B?ZHhzWFZhNU9RaW83QkZaVE1NTmNIWC8wOUhxTEJhMVdIQzVhbHFJbER5aEE2?=
 =?utf-8?B?Wm00cU4wdFdtVjgyRFhFKzVESTlBbmtCVW9HQTdpNXNHRTdoMjZVeUcwQmNk?=
 =?utf-8?B?cEhYUU5jZFg2bHQxTGhpbmJZeWh4Q3hNVThsOVhKUEJTQURhbW9UTHZjR29x?=
 =?utf-8?B?OGphRllRdEpjaUVBNVp5N2hkdnR3VmpCREYrYmgwN1MxMkFiejdPcEJhSHN0?=
 =?utf-8?B?cmpqQmphWEZvQzFTVHE4RTIvdTMwRm1yc2poZHhUelJaMUhlR3ZjYzNPdXBM?=
 =?utf-8?B?NkYwMXhxbE81WTY3V3BCWGFvdjhEZHB6QXhrL09aZ0F3TFM4MDZ0d2NkdVNS?=
 =?utf-8?B?a2F6V3pWRVFncHlrcExFQWV3clN3OVBBUTQvZTNiTnlVK2o5eHpnblVpZkty?=
 =?utf-8?B?MHZ2REJaakZ6dlhGOElkYmRtbjFIN205VGlFZXRRN3JMdUdtd3l1TnBhZDZY?=
 =?utf-8?B?ZENZbTJRMWE5aHpRL2ZvLzdocGxSc2pkSytzZngyRllFalgxRXRmZDVFT1Z2?=
 =?utf-8?B?RnQ1WEFWVS91ZFRDdVh3QzZ2UmhnUHQzMVA2VmpJanBMdzA2YVdaV3NERERy?=
 =?utf-8?B?amo5UHZiNGJpc0Rib08rMGZOcWx3NkNBMnluUi9EY1lGT1EvTVorZG9XSWRa?=
 =?utf-8?B?UU9sT0pKaUc2Z3hUVE8rd1VvazR5d29VRldzbW16dVFwcmVVeWlFeXZGSG5w?=
 =?utf-8?B?eVlXVVgrT1JqWVB6S1R1SmkwOGd3aHBPeUU0dUtJejgzaXZtaFlZNFlGejdi?=
 =?utf-8?B?ZHlVRVdjTndZVGN2RmVaWURJMldrcWE3QXZNeHBpVVZreDc2Sllobkl5aHpK?=
 =?utf-8?B?S3RGcTJhVUZFZXJkTklxb3BRZHlxeTZ2U0ZLTFdzYlRSRzUycEk4U2xQYm5G?=
 =?utf-8?B?RWtCVjZrSEE3emgrUEU3S1ZQNUZ4bDIvMmpvR25YK2o2L2ZrOUlud3FOK205?=
 =?utf-8?B?WVl2ZzVWejNLNmpMYmR4amE5djV6c1I5d1UwUXRvRXN1aEhndEVhdFdhRXhn?=
 =?utf-8?B?L0lQUmcxZ0RkUmFqMlhSTE0zTXVSSFd2eXFTZURrOVpxUWlqYXl6VkZkMW5S?=
 =?utf-8?B?UzFZQ3lxaVhGcDFVdXZ3L0ZsbVN4dHM2N3RUS1pGTEExSXp0YmJ0bFYrUVA5?=
 =?utf-8?B?cEQxMFBYbFcrRUlVSjRxbnBZQmpudTFtcFJ1aTIyS1NIQitXS0RWZlVZRGFr?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zu0tSOwSsBaEV4PpzPwxljtAjkz2zfizwK9TikkLJqFwREilHeN4rzLVEm27n/HckUw1UaXvKRSq9/jwxsSkeC6frrd5V6vgkr7bXWzNeq8DapfgrdG0a81WuazC4OF+xHVnH38/SLyvX0Gv/8uB+PgggVCpvybObERB/QYycuIKCZLckmsRdTNW68NS5dXL1gdBWZ5PoKVhNFdY0l2tpEirYAuDkliZb/4V8X3lmPncsB3ooAFD9SkS9oj/+fZpSRSTwoaw95RTRCYQeMizL5DXXGlREYKSIwf21uDFw3B8tEpfM/hZg5pqbpUaeCS5SHyRU66MG+EU4Qlh+WOr7KBewP9wr63DIdS/atVIxFVCprRvdDxEjBWGiqlGYRy68PEiiaYe83y2VcOGIq4i/vHL5cLGraNAblt4Z6NvLXINtdzMRU3WuB3ZzYUAgfn4nM10CWd+GsIReaA5CYblQdyXa1fsxykZeIpv+6vPxdLlVELR6YYEAa2qg/BCi49I8p1kiGSg3qzgD/vWsG9r1EdQpMFX0fo9KshXtTTqHzeK3xewpQgPjfpOHGbwATQkf+SqhLkyNRKYPfEAF3c7J3zMFrt26i+gyThPe7DW2i4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ac5e0a-512a-48c0-b636-08dd96aaa8dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 07:56:28.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0O9cKIo8HG0Spd5WOOOyWjtiFfGocZFlIVOtZciUnumhVwZ/yTz1RbRl3UqGs6Pi8C71idOuQuP4BzXDZGBodDFPDtwZfygK0YGP/ieypw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190074
X-Proofpoint-GUID: wXdNa4-RLpmaPEV4w3RRllSrK-Sw2ZcV
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682ae42f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=EmztcY51te3QCq4j7zUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: wXdNa4-RLpmaPEV4w3RRllSrK-Sw2ZcV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA3NCBTYWx0ZWRfX1VL7IOr7MuhV Y9HidjHvSQY/N1+0wC70qYBk/MgCHTq4FRdaViZO4BfgJ/UB/innkUadKU5aUWpemCwAqIPofxs C3t8/1Szu/pdCPcVTOxNcV8rGTW7oK6zDVDj6++zBPbMobUaRrE1QrLgtdgyaVC/1MsIZrz0iyS
 nohyfim6UAA/GnYjhSTiAzr+ktJlYleU9aNLQqVepfMx5HwkSRU1CGU0AD+nnFAOYCqzXT4oqRw C6HzKoQeZPhd078Y7em2Zb1bFLQDHP+dJJcI+kwvGNOkOnzoaOPDxEr2lgxG9kwpoCnEkVKSMkg MGODj5L/FJmEHhvKSCNdqLjcsMwDTsx2GYkBa4gi8SMNJzfzr1gP9etHOva4kvhwpw1y4XKpHT7
 Ynou9Gxmg4DgqKDnQNNyVGhScjOcinu9qGS4wXxBoYz/sFrtnp58wz9/FLdvu7uEQlOMjiSY



On 19-05-2025 12:31, Wentao Liang wrote:
> The function mlx5_query_nic_vport_node_guid() calls the functuion

typo functuion

> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")


Thanks,
Alok

