Return-Path: <linux-rdma+bounces-8768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC2CA67046
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4560880AA7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959E205AC1;
	Tue, 18 Mar 2025 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="v8GjwoVv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEE207DFB
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291354; cv=fail; b=lCiTA9MOw6J5J9pr7Wn9inTBhTlwBKcdq+QHoN8kwa1jleAzMKCX4tBe6TDCjaeUO7cBYDroUnZnYgH6j+D1QAQVvpAR2tktKBZj4LMk+X4MGnd8fgvM78g+UY6FV6eUEr6TeYXykv0zmjmxRUP9lP6RuQF/xtlctnJ8ASjdOFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291354; c=relaxed/simple;
	bh=5vLsgyvLT/7Lq+XSCmz8JbTku8Rt65bCWXhp4xzf478=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rb1E6mqP1oHeTkOPoILWskXmI6MtDB5t6IRBsoUzqY/sxjivV4jqyZtzEPDbQFNcx1GfH33CPhvc3rr9nXcBFogjeNr//ka9/yZUQSWH/NxC3yTSFbfjaoZolkbI2BRZksqGhtcensGp32EBBDAdM8iMJevqjG+x19ycuBF6nn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=v8GjwoVv; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742291352; x=1773827352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5vLsgyvLT/7Lq+XSCmz8JbTku8Rt65bCWXhp4xzf478=;
  b=v8GjwoVvsGmxVFnQKg99zy9xtQwzK+y77/sFkcIJ9N9p6rdV+dTBGK+x
   jIIJsqQn6HhTcBdlrbhLqNSV4EOwL+nCVmbWaSJA2p+oukMgWh/384gLN
   t4S7xFhBXSRcuvQ67cD7YM/PFYZlwJTbAIRqHm7mbCogYPRDQeernJEVE
   AsL1n6EJKSlx8va2cGYxgUgUp/p2gC0AzZgvx7JHKMHec/RNHJg2y6TDp
   x/P0qbP4tfmnvP3LwFFPs2wWbUQyYL/8zljao1I8BA8UR2If8BAPeyZ+5
   rdxHHQLvXUqTXd+zbovXvzleIj59i4SGfx6VL71PpHdhToxQofXO5NCEg
   g==;
X-CSE-ConnectionGUID: 4tKVTu0BTXW2Fx6+sqbkPQ==
X-CSE-MsgGUID: yej1NSqvQYmIyNujLKWQWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="149855150"
X-IronPort-AV: E=Sophos;i="6.14,256,1736780400"; 
   d="scan'208";a="149855150"
Received: from mail-japaneastazlp17010001.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.1])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:47:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UW6kwEj9aD3L6cMQ/FzhxXU4c+hfrd18nywlojLr3pTgcgAuV2LP5ofBEcNGG2q+Tp+jwSKqaHpjgbtE4Uk8n7rTmxnInlPR/0e8kGooN8Kvc7p1UNjOkR/9vHdRC5U22//a/egF6iXJFDwdcDZJr29BJ+wclHPaC+vCvr8qo7+alotL19ZOcRBDJB84ZviFyjjJ9uDx1u+OZsystrQj/QRpsyEcDANPGCPTTWl0io4hYCLdrcFfbsKXQj/yIY9F/NEMfM30bM+2PjgkTZNI+x1NrhlHkEmAHL2ly5feNWtgu0IRrQfvKHY02wjiUlvFUVnqutlmaqTOKwsYnI3t7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vLsgyvLT/7Lq+XSCmz8JbTku8Rt65bCWXhp4xzf478=;
 b=I98a81mGMSYcWzszz63QglgYx/t9by6R8tTkU/BRERN6hwVeuO2kg2xhW73xmJLmqkQgjck/NaoOzHU8eVm6Q1Qqk/kNqV+TErzk1w6enKg09djUM/JaqbZydSZJtRQ6bm4oz9Z994d6bLS4fpLWu9+0fmPlGPNwkzW1My1f47TIBy7wtR42hewz+gzIj+ueQ8picCCjTRuVtnfVVNZ5xVIrPR3NrP7UY0Yr8kz0xl/IUBPjQLKInvTfRRwlaGssKeho5feBNos+kb1f7qUCg1bkWrII189mN0bXdnuGLiMFzyMhWpZV33EHigLdKAgoF2qqeVvkzPqo4U/jgfzdCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by OS7PR01MB14348.jpnprd01.prod.outlook.com (2603:1096:604:38a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:47:56 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:47:56 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Leon Romanovsky' <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "Zhijian Li
 (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v1 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH
 operation
Thread-Topic: [PATCH for-next v1 1/2] RDMA/rxe: Enable ODP in RDMA FLUSH
 operation
Thread-Index: AQHblLknRJS5mU7vnUeGBAA2RKmlnrN3qbiAgAD6FjA=
Date: Tue, 18 Mar 2025 09:47:56 +0000
Message-ID:
 <OS3PR01MB9865DF9E286B0F3DB1109C84E5DE2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
 <20250314081056.3496708-2-matsuda-daisuke@fujitsu.com>
 <20250317182247.GY1322339@unreal>
In-Reply-To: <20250317182247.GY1322339@unreal>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ODJhNDQzMzQtZWZhMC00ZTM5LWE0ZTEtOWY5MWY4MzRm?=
 =?utf-8?B?YmQ3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMThUMDk6MTc6NTJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|OS7PR01MB14348:EE_
x-ms-office365-filtering-correlation-id: 7cc0cad8-d449-488a-9766-08dd6601f5c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVNwaVBNRWEzSWZ2YllqN09mKzlhK2ZMTWRrNEIzWWtkM21hU2k0dUZscW1m?=
 =?utf-8?B?Sk9leitoOWw4THdNWVlhTzFYZ0tINVRFRUF6eWNjaWVDcGFaMTJhMHFXVWtx?=
 =?utf-8?B?Q3M3ZEJCZzh6cnFtT3NoT2xyWHptQkMrSlg4b3pGTFNYZUZ0ODFScXVxczZy?=
 =?utf-8?B?ZlFoVjRvUGs3TTFqYUp1QXd2dDBteTUxYXArbncrSm1TSXRmZmV3MjZ6NjNV?=
 =?utf-8?B?VVlXMVRZNHovMFo3aGlEWE9UaG1LMEp0WnFndWhCWGZ4WXJuemZxOXpRUUxY?=
 =?utf-8?B?KzQ2TEVsUlFuVDY4OXNVTDBwdXJta1BjSkpDVitVWUpJdk9OMW1uakUxQk5w?=
 =?utf-8?B?eGFWS3RPMGpjVmgzYkZnMC9VMURoaWV3eE1UMjlISkxaVlFVU2JRbVlpTStH?=
 =?utf-8?B?SzlCejhZVk5yNmNEenRGc1pBZ2pEdVorWUJhQnFIYWR5bE1PZHltZ1hkcWtD?=
 =?utf-8?B?NEwwRUxiVnpaeXBiUWtNUjJqZmVsZG5iY3FrWTEvYXBXdmJNcW9vcVVxaTZp?=
 =?utf-8?B?S2ppMTd0UWlEWFVmOVJSbDJHWDQvM1BZQmNwanpLbFpwVVBaOGliczJDRlp6?=
 =?utf-8?B?ZWo0Und5SHJ0Z2xYYzJHOVVvc1VMTHo4Uk0xM1o1L0h2TmRFdVlLVGRDdjhJ?=
 =?utf-8?B?bDMrZzdsRG9oVVJPaFMvdXlGZUxJdkE3TUFRQUx2UjBLVDFTeDc1cWNTVURw?=
 =?utf-8?B?QmU0MjNoTXR2blQzbUFNdUdoZjFwOTJNcXdrWWRCSjgrcExGVlJOUXh1TEVu?=
 =?utf-8?B?aitPTEpSeGYvU0tIbkpXR1c4a0ZJZllyTWkwT3ovR2toOGJtQXNaSXRzUmVm?=
 =?utf-8?B?WEZrY1NRbmt3cEc0WG9jVHU1Z2tGbTZIdXQrSWpWUVArL2xvdkJzUE1iZ0Na?=
 =?utf-8?B?aDRJbkRLaTBKVXJnenIzekVrSThvY1diNTZTUDFDZUFGUlMrZEhqV3ZtaHRr?=
 =?utf-8?B?aFF2T1JiMkJUL3IwWTVHb2J5em4wWHltbldDY3R3RGVET0FhYnBCZVg0Y2hI?=
 =?utf-8?B?V0VLY2ozNDMvQzdqRWdLYTV0NTBqL0x2L0JwSWtySUx0RExtR3JCZDVyS01G?=
 =?utf-8?B?Nm50N01RRjQreHQ0NlpjbFE2Q05qc0Z6U1J3MkFqMXltcGNyYXovL2ZTL2Vh?=
 =?utf-8?B?WlU3YVlnc2JQd2JBQmpkRzZoM0VRMkZjMG0vckhEbjJwYjlTRC9mMmpFZFBs?=
 =?utf-8?B?ckNvWjdBcUZzZktid0dBZTBYTW13NWxLV1JWYW9RdTVicnJoWTBLc3FPc1A3?=
 =?utf-8?B?WVFQQ0tyYXhsbmgrZVZtaTkvKzFkR1JjSGM0OU1vU3hDd3RXbkh3VnRFVFNM?=
 =?utf-8?B?WUdsc0VERmJhbURCYTk0SmtoSVBwOVZ1TmpuMVl6TEMyd2pZMHp0b0c0ampD?=
 =?utf-8?B?OW5iemlobFRJZ1psT2xkZWFGbnVMQTJXQkgveGg0NWt1MzlzaVk3WEMvWU10?=
 =?utf-8?B?UUtpOXR6ajROd01qLzRNRVJ4T1lFNDlXNFVOYjU2VzJoVWRPMUtJSXVuS1I0?=
 =?utf-8?B?Y2tmWXE1dUdEVGFWWTdGWVlUbmp3aEMyekhDbkdQRFdBMFF1N2pOQ0ZpMnJB?=
 =?utf-8?B?Wk1MYy9oZXVZSko0dE8wNXhyMHJ4OUFET0svUENFYi9pYUZuVGdMazNxYXNV?=
 =?utf-8?B?OStYZVNhcjdrYmkvN0xja1JJZ0xvS3lQbStKSHExN3lBTUdOVFgyMUpQdjFy?=
 =?utf-8?B?T3JsWGQrRnAyc3VqOTRrcDZ1SGFMdHYrTS9zSGRNMkc2SzFoM095UGF3SUFw?=
 =?utf-8?B?SUtBL2FHUVZrd2VncWZlc0RYbWVXbkYzV1FSN0x0U2ZLaWZmMjNvemdXZEdk?=
 =?utf-8?B?cVJFVnpJNFNOdkxNYnVSZG5USEZRd1BVcndGVHRmRm90WGNNYlYxT3gvbHls?=
 =?utf-8?B?ZlF5K0JnRDIxdDdPZ3gxNVFvQXJpRlhEZXVWMEJrekdPbVA4Rzh3VUpqeFNO?=
 =?utf-8?B?Nk5UeFFFVENyenlyQ3A4ck1vRHR5VUt6V1FPTzl4djdnaElrYmpVQStWL3B3?=
 =?utf-8?B?U3Q3djVxdjVnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTNzdFdXNkJKQ0NMWERWTTVWWm5iMWphakpwcm1zZlF1aVg3aytsSUNBd1Ey?=
 =?utf-8?B?bG5uY2ZUWlAxbFZwekhqME1DR3pnbUdta205SDlrdnV3dzJzSVloOW9Fc0Er?=
 =?utf-8?B?aWwwRTVadjV0U1ZmZXQya040Yit5aTUzVkVKQUFJaDdBT3ZNcmRsZmxUWFYw?=
 =?utf-8?B?c0FHRXRPT1AwWjRjNEZ6QllNYWw0eTFtRW5OZFNOYUJSZkpaeGtUNVZINTZC?=
 =?utf-8?B?aENEbGc3RXlrRVZsVDRWemhzN1ZuR2NzUzd5a3pEUDFrd0ZjK3lUM2hVZHIv?=
 =?utf-8?B?dm9oOGFUa0Q5SHBENnRSK0c4ODI1elBIeHNlTEtOTE9uQjZBc1orOGcwSmcv?=
 =?utf-8?B?cklSYjJNclltNy82QVA1U3pPaTA0Vnk1S2o3bGVkQ2gwQzYrZFFzYkMzdkhP?=
 =?utf-8?B?ek9OTTJORG1TbXNhNDFWVlZOQUgwYjFjckZ3WnY3QlRHOW9ldW1FakVRbmRT?=
 =?utf-8?B?OU40aUw4clJBWVYwRVkxckxhTUxWR2hEbG9QRVRHc0VrTlptN3Q2YW9hUkdq?=
 =?utf-8?B?WDZQVlBXV1N3N0dTS0JJNmhFb0k1L25FakF4VlZ2Y0RjMWFkdmg0Zk5hZVV5?=
 =?utf-8?B?LzFkdmpSd2k5L1Byem9iK0VSV3BIZDBodlpObzYzMlFVdkNaYlZ0Q1BtS0hx?=
 =?utf-8?B?a0NkM2thQjVXNHE4SmEvRzc0Y3BuZ1hEaWE0eExjditwZmRiTGdSeU9hMEk4?=
 =?utf-8?B?Q3E0MkF5OE4wQWhtS2diL0Nqd3h2TVFmckJ6TlFPeVVueU5aRm5URVN4NmdQ?=
 =?utf-8?B?bXp5MTMvaDlmVURoeSt1K3FkUGU0REtXWVZQdG5MRis2ckk1WVBIcDhuOHBy?=
 =?utf-8?B?ODhnR1BUUElzN1UvTW9lK2NrRkVOWUxMUmd0M1hZYmJBYWFrNjhCUmNnY1Bh?=
 =?utf-8?B?eVB1UUJNTXdGVEU0OUpiMzRESDVLTVpoOWR3RGVVeW1tVitjZmorZUVFOXNq?=
 =?utf-8?B?Q3EwSTcyc1NrdnVUSGNPRGFSMkZkaGt0blMvT3JGQTBHWk5vR055YjFLdk9P?=
 =?utf-8?B?KzdZaFQybjNSMWM1VWxoWFJCT2N4Sy9iUDI3Z0RkaGJCZkRWQVNGODk3WmRv?=
 =?utf-8?B?aVZ0V2RnWWZTSkZKNG0rRnluVThCZmc5ZnhwU0lLR1puMndVY2Q5cHl6aHJj?=
 =?utf-8?B?T092SkJTMUM5WGtqTWVGMzNpam1VRDRSNXpCSFJ6ZTl0WXE3d1dGSG12akdm?=
 =?utf-8?B?L1dieUhwVncyWTdQcWdYUmQ3TkhyMk1EaEllblhmT1pSUmNDL21rd0dzdTVm?=
 =?utf-8?B?MVoxZzVRbTJLeFFLZjE2MHpEVnRtaXIzSzd2M1Mva2EzZnJWZWh1K1NEYWI0?=
 =?utf-8?B?Yk1TTXlUK1p6NGU5b2tzVEx6TFdGN3NIZ3R4eFVKZHlIK1lKR05aY2wvMm5O?=
 =?utf-8?B?NzBmMHFVNUt1Wm5CZlB4RXNzZlBhTFQrY2s4elZocitvVmdVbWpZU3ZoUmRr?=
 =?utf-8?B?SDk0ZXVoVENLSnBJeE1xbi9TRnAxRitMbVRady9PMGRDUzRMK0VuWkcrd1hy?=
 =?utf-8?B?NTNvN1NVMlFnTzljcVkwZlU1VlFYYUxhQXpLNWw1NFJZeXh6endWSUIwZzdr?=
 =?utf-8?B?RmJvcDlLNzJsc3E0cWJHOTltQ1dOenlCT3NwM2FjOGVERFdpUG9MSU1SeHB6?=
 =?utf-8?B?MlNmNVZhd05WMWpOeGtoQUxvMnFwcUJnRE50eUFzRTFmTS9zbmwxUXE3OG5M?=
 =?utf-8?B?dFZwYWNqY3dDRmVPTXdBczIrektMenFOSnBsYTAwTHdYZUU3bWI3bHdlTmQ4?=
 =?utf-8?B?WVpGYjRZSkhWYjlPQmJNcDF4S2E1NnBEcE9FVWM3R0FielRBMmZLK2FBeHFC?=
 =?utf-8?B?UXN3eUdMZUNZOG9yQ20xbm1BT0J5MEx0SWtxY0x1VkF4c2d6R1hFQjZHQlpV?=
 =?utf-8?B?bnRSOGRMS2piNTkyNWdFSUM5ZTB5cWhkVDhUYTVtbFY5dS9vdG1ERjBsWkZp?=
 =?utf-8?B?NU1SdkNJQkJ3N0R0T1I3TEdCQ1crdDVEaEtjOGFYSzVJSXlYTE5SancrWXBW?=
 =?utf-8?B?OGRHM3hFT0ZNQTRqcGV5WXV0U2czR013dW83MWViZVBScjdubFo4RXNZOUtU?=
 =?utf-8?B?UHB6dVhRWFlXNUorZWVpb2JBWTc1ZHhCek1pOEUvVFJrWm9sVCsvYTBIazJW?=
 =?utf-8?B?azNLUXphdVMxN0xNQm9lVXJMUXo1N01PVDJ2YytUZUJJaGNvTXZOM1FxbUM3?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OWhvMWczSnJ4R1CaPxPrAWEqhH34FuuBLl97SDv0nqMnQUMllHdPFJU4Ea/WfJ5DcuQ9loEET5FLwj/ldO5nW29W8bujLqcKXsqRNHBjqTJM8Nlsgu9AlkQ3xrSebkhUpaXKtFDeKiCZDmrHvF1Yy5jOIX+ZExhJrQptboK8tk7975rZedz9//A/fgqtEea/6gzOlS17wcHx3o6e7yrfQeybEDqnWbmFywOw6GUe0LmS3paoMaWBtzyWA3orZxwZse+ocWs3iaK+cE/ssawOKQlu+X75FDlf2waTqCoCfpOJ+mCs87s2YYoN95PvFn8uE8fgMKMon6FeioirVAdlFG+Ouz2T1WozlPasYm8AaZNaCugIqgBBeUO65CFx5PrhitEc2x/Thc2zsPSDg3KeZbz6y5M3yUask1inBXtEJkfQJO1huJWnM1vl2HUeHVRSDF1D9oDZCP0WrDG4FNDQOtz6IUfOhnYeL9r5xc07xBawVZIw+SZNMiSP8ImkkkXwSfdjN/qux0h7yvUb3BHSAmkOk8Dmd5eFE5YiV1u+JqSQoejjucD1bpMbMgkIqxECTN2nWStivBKSWQfVfLiYvVyUWMWSFHC3wz9W9zy1F/QsxaYuPF5So+PsA/C2hDey
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc0cad8-d449-488a-9766-08dd6601f5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 09:47:56.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POatoAJBYwUYQdzrfkwLcQ5+cV6TTH3lMAs8jNkCEzlqi6dP4Ud4pKkHUmhTtk41ffhcbdm2Thw+9TE1/tl8sRfdVu5i0knNtbXOF0cFEZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14348

T24gVHVlLCBNYXIgMTgsIDIwMjUgMzoyMyBBTSBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+IE9u
IEZyaSwgTWFyIDE0LCAyMDI1IGF0IDA1OjEwOjU1UE0gKzA5MDAsIERhaXN1a2UgTWF0c3VkYSB3
cm90ZToNCj4gPiBGb3IgcGVyc2lzdGVudCBtZW1vcmllcywgYWRkIHJ4ZV9vZHBfZmx1c2hfcG1l
bV9pb3ZhKCkgc28gdGhhdCBPRFAgc3BlY2lmaWMNCj4gPiBzdGVwcyBhcmUgZXhlY3V0ZWQuIE90
aGVyd2lzZSwgbm8gYWRkaXRpb25hbCBjb25zaWRlcmF0aW9uIGlzIHJlcXVpcmVkLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRGFpc3VrZSBNYXRzdWRhIDxtYXRzdWRhLWRhaXN1a2VAZnVqaXRz
dS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlLmMgICAg
ICB8ICAxICsNCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbG9jLmggIHwgIDcg
KysrDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX29kcC5jICB8IDczICsrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfcmVzcC5jIHwgMTMgKystLS0NCj4gPiAgaW5jbHVkZS9yZG1hL2liX3ZlcmJzLmggICAgICAg
ICAgICAgIHwgIDEgKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQ0KPiANCj4gPC4uLj4NCj4gDQo+ID4NCj4gPiArc3RhdGljIHVuc2lnbmVk
IGxvbmcgcnhlX29kcF9pb3ZhX3RvX2luZGV4KHN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9vZHAs
IHU2NCBpb3ZhKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gKGlvdmEgLSBpYl91bWVtX3N0YXJ0KHVt
ZW1fb2RwKSkgPj4gdW1lbV9vZHAtPnBhZ2Vfc2hpZnQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0
YXRpYyB1bnNpZ25lZCBsb25nIHJ4ZV9vZHBfaW92YV90b19wYWdlX29mZnNldChzdHJ1Y3QgaWJf
dW1lbV9vZHAgKnVtZW1fb2RwLCB1NjQgaW92YSkNCj4gPiArew0KPiA+ICsJcmV0dXJuIGlvdmEg
JiAoQklUKHVtZW1fb2RwLT5wYWdlX3NoaWZ0KSAtIDEpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBz
dGF0aWMgaW50IHJ4ZV9vZHBfbWFwX3JhbmdlX2FuZF9sb2NrKHN0cnVjdCByeGVfbXIgKm1yLCB1
NjQgaW92YSwgaW50IGxlbmd0aCwgdTMyIGZsYWdzKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaWJf
dW1lbV9vZHAgKnVtZW1fb2RwID0gdG9faWJfdW1lbV9vZHAobXItPnVtZW0pOw0KPiA+IEBAIC0x
OTAsOCArMjAxLDggQEAgc3RhdGljIGludCBfX3J4ZV9vZHBfbXJfY29weShzdHJ1Y3QgcnhlX21y
ICptciwgdTY0IGlvdmEsIHZvaWQgKmFkZHIsDQo+ID4gIAlzaXplX3Qgb2Zmc2V0Ow0KPiA+ICAJ
dTggKnVzZXJfdmE7DQo+ID4NCj4gPiAtCWlkeCA9IChpb3ZhIC0gaWJfdW1lbV9zdGFydCh1bWVt
X29kcCkpID4+IHVtZW1fb2RwLT5wYWdlX3NoaWZ0Ow0KPiA+IC0Jb2Zmc2V0ID0gaW92YSAmIChC
SVQodW1lbV9vZHAtPnBhZ2Vfc2hpZnQpIC0gMSk7DQo+ID4gKwlpZHggPSByeGVfb2RwX2lvdmFf
dG9faW5kZXgodW1lbV9vZHAsIGlvdmEpOw0KPiA+ICsJb2Zmc2V0ID0gcnhlX29kcF9pb3ZhX3Rv
X3BhZ2Vfb2Zmc2V0KHVtZW1fb2RwLCBpb3ZhKTsNCj4gPg0KPiA+ICAJd2hpbGUgKGxlbmd0aCA+
IDApIHsNCj4gPiAgCQl1OCAqc3JjLCAqZGVzdDsNCj4gPiBAQCAtMjc3LDggKzI4OCw4IEBAIHN0
YXRpYyBpbnQgcnhlX29kcF9kb19hdG9taWNfb3Aoc3RydWN0IHJ4ZV9tciAqbXIsIHU2NCBpb3Zh
LCBpbnQgb3Bjb2RlLA0KPiA+ICAJCXJldHVybiBSRVNQU1RfRVJSX1JLRVlfVklPTEFUSU9OOw0K
PiA+ICAJfQ0KPiA+DQo+ID4gLQlpZHggPSAoaW92YSAtIGliX3VtZW1fc3RhcnQodW1lbV9vZHAp
KSA+PiB1bWVtX29kcC0+cGFnZV9zaGlmdDsNCj4gPiAtCXBhZ2Vfb2Zmc2V0ID0gaW92YSAmIChC
SVQodW1lbV9vZHAtPnBhZ2Vfc2hpZnQpIC0gMSk7DQo+ID4gKwlpZHggPSByeGVfb2RwX2lvdmFf
dG9faW5kZXgodW1lbV9vZHAsIGlvdmEpOw0KPiA+ICsJcGFnZV9vZmZzZXQgPSByeGVfb2RwX2lv
dmFfdG9fcGFnZV9vZmZzZXQodW1lbV9vZHAsIGlvdmEpOw0KPiA+ICAJcGFnZSA9IGhtbV9wZm5f
dG9fcGFnZSh1bWVtX29kcC0+cGZuX2xpc3RbaWR4XSk7DQo+ID4gIAlpZiAoIXBhZ2UpDQo+ID4g
IAkJcmV0dXJuIFJFU1BTVF9FUlJfUktFWV9WSU9MQVRJT047DQo+ID4gQEAgLTMyNCwzICszMzUs
NTcgQEAgaW50IHJ4ZV9vZHBfYXRvbWljX29wKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwg
aW50IG9wY29kZSwNCj4gPg0KPiA+ICAJcmV0dXJuIGVycjsNCj4gPiAgfQ0KPiA+ICsNCj4gPiAr
aW50IHJ4ZV9vZHBfZmx1c2hfcG1lbV9pb3ZhKHN0cnVjdCByeGVfbXIgKm1yLCB1NjQgaW92YSwN
Cj4gPiArCQkJICAgIHVuc2lnbmVkIGludCBsZW5ndGgpDQo+ID4gK3sNCj4gDQo+IFRoaXMgZnVu
Y3Rpb24gbG9va3MgYWxtb3N0IHNpbWlsYXIgdG8gZXhpc3RpbmcgcnhlX2ZsdXNoX3BtZW1faW92
YSgpLg0KPiBDYW4ndCB5b3UgcmV1c2UgZXhpc3RpbmcgZnVuY3Rpb25zIGluc3RlYWQgb2YgZHVw
bGljYXRpbmc/DQoNCkhpLA0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQpJIHdpbGwgc2Vu
ZCBuZXcgcGF0Y2hlcyB0byBsZXQgdGhlc2UgZnVuY3Rpb25zIHNoYXJlIHRoZSBjb21tb24gZWxl
bWVudHMsDQpidXQgdGhlIHdoaWxlIGxvb3BzIG11c3Qgc3RheSBzZXBhcmF0ZWQuIFRoZXkgdXNl
IGRpZmZlcmVudCBwYWdlIGZldGNoaW5nIGxvZ2ljLA0KYW5kIGl0IGlzIG5vdCBmZWFzaWJsZSB0
byB1bml0ZSB0aGUgZnVuY3Rpb25zLg0KDQpUaGFua3MsDQpEYWlzdWtlDQoNCj4gDQo+IFRoYW5r
cw0KPiANCj4gPiArCXN0cnVjdCBpYl91bWVtX29kcCAqdW1lbV9vZHAgPSB0b19pYl91bWVtX29k
cChtci0+dW1lbSk7DQo+ID4gKwl1bnNpZ25lZCBpbnQgcGFnZV9vZmZzZXQ7DQo+ID4gKwl1bnNp
Z25lZCBsb25nIGluZGV4Ow0KPiA+ICsJc3RydWN0IHBhZ2UgKnBhZ2U7DQo+ID4gKwl1bnNpZ25l
ZCBpbnQgYnl0ZXM7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsJdTggKnZhOw0KPiA+ICsNCj4gPiAr
CS8qIG1yIG11c3QgYmUgdmFsaWQgZXZlbiBpZiBsZW5ndGggaXMgemVybyAqLw0KPiA+ICsJaWYg
KFdBUk5fT04oIW1yKSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlpZiAo
bGVuZ3RoID09IDApDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJZXJyID0gbXJfY2hl
Y2tfcmFuZ2UobXIsIGlvdmEsIGxlbmd0aCk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJldHVy
biBlcnI7DQo+ID4gKw0KPiA+ICsJZXJyID0gcnhlX29kcF9tYXBfcmFuZ2VfYW5kX2xvY2sobXIs
IGlvdmEsIGxlbmd0aCwNCj4gPiArCQkJCQkgUlhFX1BBR0VGQVVMVF9ERUZBVUxUKTsNCj4gPiAr
CWlmIChlcnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPiArDQo+ID4gKwl3aGlsZSAobGVuZ3Ro
ID4gMCkgew0KPiA+ICsJCWluZGV4ID0gcnhlX29kcF9pb3ZhX3RvX2luZGV4KHVtZW1fb2RwLCBp
b3ZhKTsNCj4gPiArCQlwYWdlX29mZnNldCA9IHJ4ZV9vZHBfaW92YV90b19wYWdlX29mZnNldCh1
bWVtX29kcCwgaW92YSk7DQo+ID4gKw0KPiA+ICsJCXBhZ2UgPSBobW1fcGZuX3RvX3BhZ2UodW1l
bV9vZHAtPnBmbl9saXN0W2luZGV4XSk7DQo+ID4gKwkJaWYgKCFwYWdlKSB7DQo+ID4gKwkJCW11
dGV4X3VubG9jaygmdW1lbV9vZHAtPnVtZW1fbXV0ZXgpOw0KPiA+ICsJCQlyZXR1cm4gLUVGQVVM
VDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWJ5dGVzID0gbWluX3QodW5zaWduZWQgaW50LCBs
ZW5ndGgsDQo+ID4gKwkJCSAgICAgIG1yX3BhZ2Vfc2l6ZShtcikgLSBwYWdlX29mZnNldCk7DQo+
ID4gKw0KPiA+ICsJCXZhID0ga21hcF9sb2NhbF9wYWdlKHBhZ2UpOw0KPiA+ICsJCWFyY2hfd2Jf
Y2FjaGVfcG1lbSh2YSArIHBhZ2Vfb2Zmc2V0LCBieXRlcyk7DQo+ID4gKwkJa3VubWFwX2xvY2Fs
KHZhKTsNCj4gPiArDQo+ID4gKwkJbGVuZ3RoIC09IGJ5dGVzOw0KPiA+ICsJCWlvdmEgKz0gYnl0
ZXM7DQo+ID4gKwkJcGFnZV9vZmZzZXQgPSAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCW11dGV4
X3VubG9jaygmdW1lbV9vZHAtPnVtZW1fbXV0ZXgpOw0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0K
PiA+ICt9DQo=

