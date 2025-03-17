Return-Path: <linux-rdma+bounces-8736-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD1A63F89
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 06:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269DA16E338
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9785A219301;
	Mon, 17 Mar 2025 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jM+oZ52i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3B2192EF
	for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742189017; cv=fail; b=cBDlZIQu9QtuXnlEUKvrZKzEFzuY9qIs1W3d/OhZGOlQcqzlKRsEcAFvB+jRtW5WkD/y8xfKzwDQjD9Lcmcc1nEe2KRyMgrcFsDr2ylEr3GgDY5t2ZFZZGCSpQarmayVYpkzxreHCzw/ZvK4h+g0ddcM23PJGyKH5BA3oNlr7TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742189017; c=relaxed/simple;
	bh=jYuz1jBJLdjfanbw/0Eq+OU3yGd1W0oDTWEd0d5touw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YaVH8J9g/klYm7UMnQAoAT23ZbAPfIEsm21ufczlQHxeTmetLgTtxLoLUmLxnT7YRFzb5/UYkGfHg2RnRSiLs/DAmeqBeVJmT87kxC6yyVkKENBBye2wh6kpVs9jQbVD7VGP1jvks3a/YM6MnXWUJiGBxuviy7O92+SxTm3QDu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jM+oZ52i; arc=fail smtp.client-ip=216.71.158.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1742189015; x=1773725015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jYuz1jBJLdjfanbw/0Eq+OU3yGd1W0oDTWEd0d5touw=;
  b=jM+oZ52iJiWfAT1j5phZf7YfZzqTypD+ugL7AnE/6JSXUjS2doQ9FMAm
   JcRg+UiCbNcNT9A+iylliEwMoE747DrKVWnx3KNy7pAqeN2OOQG+RhC+u
   F7UM6qUoqH+tbNU4xo1jx5vcVGXV/05lUdh/KDhVq+gffvHfJfLGhSl61
   3DinBUCk8+wbELayGIi7OkX+AXOrJPH3aBFRY5TKS9AiUohY4+qYdxapa
   tTo3Yus6zaiwfdi53upM8373QHlYfM3205sa73+ggPtsoq0X/oQjLiKP6
   FcgpiHsR3lRlZrrgqz1lbJy2GleQHGf2xlpMGobqdw77WVMm06u3uCuQR
   A==;
X-CSE-ConnectionGUID: H1ivjBnMRnGqnzdmBCLg4g==
X-CSE-MsgGUID: CGsPAzzZQq2cAkmne3UXFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="149506064"
X-IronPort-AV: E=Sophos;i="6.14,253,1736780400"; 
   d="scan'208";a="149506064"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 14:22:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Onxe6JsKIG/ucVEKpSGWIx1r6jBM66V8/jyqhV7rC3Cu/XwzopVAai3yJYNIUx2GQlVOdTqMwQt+fvQv5fRJ0bZSJpD5WEU/xIEuLVHis6f/xU1A+ETOW08fgsMZHrmy06gMhw6pmNmfvhOb4K5Rh71iu/vGC482Hu9PHBgGQld9YIyT7LDEjbs6LwUdAYvpjD91CE8cC9AatwQyZ3Dz6GUkOcH0vD4Lu2Qa8TXHQwm576jLkvODPEADok9ZgS5PvJwiqUW+c26aHtuexSyah/BSVMcTUfgnc1nu0t4l1yvxp/b2P2GrbvgVl77dBnlqL+k8ZaM31HT9RYrv7AxSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuz1jBJLdjfanbw/0Eq+OU3yGd1W0oDTWEd0d5touw=;
 b=gcKW2jxWIrM0vhQyyiXR2Mg/dh0sD2pjeDSzfm4j4JW5sDOqYk0HXtO1t6NZKxf8pQy+r28nLmIiOeNJBDCVnUnCwMSYZu3LyclfOFK47DOEr4QsrLQ+HdND98/Cm5OCzF4+MjsUi/yStubP2UIOXkK6ly9Jlc6es4JZt+f3hC9J3TFEIpkiPNTrYeKQQ1I1T0Bn2hZDhY2Iti/rYpDRq5+R0wYacMBr4fXSGCM4F9MvYvF5HbPt0Fes4tUC8Qb6xY5av4SpudP7P9RYg7DLB7ErM7M24j7GCfXAmos1r1W8UwD5vDn0kHZL3lBHniSGmEyso+19EpP1HQ0ppCk2LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com (2603:1096:604:1ec::9)
 by TYWPR01MB11361.jpnprd01.prod.outlook.com (2603:1096:400:3f6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 05:22:19 +0000
Received: from OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff]) by OS3PR01MB9865.jpnprd01.prod.outlook.com
 ([fe80::c38:6bea:5be1:b3ff%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 05:22:19 +0000
From: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
To: 'Zhu Yanjun' <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: RE: [PATCH for-next v1 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Topic: [PATCH for-next v1 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE
 with ODP
Thread-Index: AQHblLkaDvJJYPSV90Ce7Wv+d+s5bLN0lWUAgAIMyYA=
Date: Mon, 17 Mar 2025 05:22:19 +0000
Message-ID:
 <OS3PR01MB98655C96394F628592F064A5E5DF2@OS3PR01MB9865.jpnprd01.prod.outlook.com>
References: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
 <1e4e16ab-4db4-471b-8c80-aae2e8886093@linux.dev>
In-Reply-To: <1e4e16ab-4db4-471b-8c80-aae2e8886093@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ODMwMmFjZGUtZjE3ZC00MjlkLTg4YWEtZjg1MmRiNThl?=
 =?utf-8?B?ZTg3O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjUtMDMtMTdUMDI6Mzk6MzJaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9865:EE_|TYWPR01MB11361:EE_
x-ms-office365-filtering-correlation-id: 975ef01f-9961-4547-70e8-08dd6513b069
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?utf-8?B?M3RydWJWTGFRRndhVUJqOWJrSWNGdGV2bnF6c1FTcEpGdXk5VXZJNmFSOWNw?=
 =?utf-8?B?aHZ4NGZ2N1dLb1E1YWVPdFpzWmpDVXo2MURuTEt0RmZWRTZPRUZFL1Z1REJ5?=
 =?utf-8?B?OVkyNDZRMjFFNHlZREtvbjhFaXdtTUtPMWkyQUhVeXIzbFdlUnd5RThmWndJ?=
 =?utf-8?B?dG9FS2lTNGxkS1ozb2trdkhVbW5JdWhiUTRMTldXWGtoeUhyTHN4K2QrZVE0?=
 =?utf-8?B?ZFY0aHpGZjY0bFFWaGZMdERXcHRsVjh1L2lZOTlHS1E5a2ErbHRkRHAxaGFp?=
 =?utf-8?B?ZVFUSTkvN3pBMzYrZXVMMFltSklva3dabDZYT1Q2Y0RySk5YZEF1WUZVcE5F?=
 =?utf-8?B?YkRiSGRNUVAxdUppY1N1S3Nwd3VscERvN3FEME8xd0lnYnhGYzhNZnRZMC9D?=
 =?utf-8?B?MUNGRGJmbi9lN1p1aFJBQTRMQzFxM0p0S1RHd05iQ2xpY282ZWYzT1orUDE1?=
 =?utf-8?B?SkV5NVBkYkF6YnNxaUFNeE01NnlqUjlhZ3dPU1FjNHY5M2dHRTRkRlYxVmRt?=
 =?utf-8?B?S2R0N2RNT3ZKMlAzYVJpMXpVaXVPWDV3WW1iT1lTWVRlaWlNNm45ZG56QWNo?=
 =?utf-8?B?aTM2aHVxM1RUbitmTFlML1ZUTWVoOGpKenBBcXZranJlc2pDZVVUL28xUFNr?=
 =?utf-8?B?T2dGRHkyTW5hclZCaG5ZYkU3YVVoeGV2VmhkN3dQbzJMQzBmSXhIbE1wUXVG?=
 =?utf-8?B?Y0ZMb1dJR2wzNUFDRG1jRDB4WGxvV0VjK2dCcWtOYVltdkpncTFEVDAxQ3VE?=
 =?utf-8?B?OUltakRVc0hKZUFZTzJQb2o5b1Y0cTJXQStRUGt0RE5MenVISmpqaFhkMEYz?=
 =?utf-8?B?NmFsTEF5S3JYWFc4RDlrWWhaaDRuTlI2cUhnL0ZleWRXK0xSR3k5Kzd3MGJH?=
 =?utf-8?B?KzZvQm9YNVB1dDhiMDk5MURrSzRlNkQ5RC9abVBRbHdDdHNybkxydVZLbGk1?=
 =?utf-8?B?TllSTDRld3dFckpmWStZOC9lblJGM0hhZk0vRzVzZnNYQk9KL0NRZFN6bEtT?=
 =?utf-8?B?V1c3b0ZkUS84M1lQeEJyYVQwZ2phOWRIYm1DYmVCcXNpMjdlMFlQbUY0M29O?=
 =?utf-8?B?b05ldnZWOStnWWo5RjhkM2lxNTJHdTd1UzFsbUtTZkZvMFQzMGYwREg0a21N?=
 =?utf-8?B?Y0g4ZmIzaFNrT3cwcGtZUW1HTm1UQzZlQVBnd0ovbTJMSmx1OUZSWk9EbDVi?=
 =?utf-8?B?emhlSCtMaGZ0VWxtSXl4dHFvVFBBN0lwdWFWN3JONXJsWW43OUxCL2Q3clRs?=
 =?utf-8?B?T1dJNW4vbDVsenM5NzZvenVLSGFXQ1Uyejg0Z0U5eGY0RStTWWE0NGczVTRI?=
 =?utf-8?B?OTNjbWNSUnVDVVEwM0xpandlSXJ0ZnE2Q0pTeEJZbHlUdDhTS3ZvVXN2dDNJ?=
 =?utf-8?B?a1ppano3ejdxeGR0cExtd1ZOQ2hGK3RzY2I1VDBJbTRZSkF3WnJ6SXpOUW1t?=
 =?utf-8?B?VDIzTEFnNjRUcngrM0NVSzI5eURicDBjWlJVZkJjTThhWDBnSmx5RlV3MzdE?=
 =?utf-8?B?NWNzYXFXNU4wc1pwdjl5enIzOFBrR3JTd1ZXWGZ6b1hEK2c2U1JsWWR5MGVD?=
 =?utf-8?B?RGMzem9zdXJ4NGtuOTA0VDZxY2s3QWNEYTA3WGJ2cXBLSkQrWkxOMzFFeW5z?=
 =?utf-8?B?bEdsa3QxUjM3TTQ3REowYVBCM08xTXZoZkhFTzZUQTlmZHlWUEhCcUJUcFI5?=
 =?utf-8?B?WDk2aGpQRi9pYkpZV3Z4UmVzRGIxQnd1cE0rWjN1bVV5SVZka0VIaEEveDRD?=
 =?utf-8?B?eTNPUjBYd2dleUdKQ0Zubnh1cldRdDFHTEFnVElHdGhlQjJ1aVlZaThoUTNL?=
 =?utf-8?B?dGVzSXIvdHhzNUMvOHltTllOc3hJdHRWeGM3djZHcisxdng2MGs4eVFFMXpX?=
 =?utf-8?B?NTNodnJKd2JHUVAvNkJEbkZSZEI0c2RxWWtVZ0tHQ2ZibkZRVEE3Y3dIQ0hZ?=
 =?utf-8?Q?0NAO5WJYohQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9865.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEdLaG85ZmRrU1BBUHR3b1VnQUpDQzhaaENCSzMyMS9DM1VnZ2lncmtDU0NW?=
 =?utf-8?B?c0Juc0NVYkhTcWJKNlk1Y3U4ekFUMnJ3NlZNOW9yaXVJcmEzT2VpVkUyODVp?=
 =?utf-8?B?WkM0WVpPeUhLNlpQQTl0K2lyYzRwL29GZ0FBN09EOGxzU1U1QXRCU1paWlpG?=
 =?utf-8?B?RG5xU3owdmJuRHp0K28zN010SWtIZ2hZSyt6eEFXRk13ajNKalpUZWJYOG55?=
 =?utf-8?B?enlDb0RSU3pVOHpHOGYxZ0ttWHVqTWJRWWwycHE5Y1QrUTZxVm5nSWRJSTNK?=
 =?utf-8?B?Q2tHeFhvRkwzS0FqWHlxcjRRVFpVRldGelJndGNsR09mSDcyMDFLTGhPRXFP?=
 =?utf-8?B?M0QxanBqRUhNM1pVeEtxVHpKdkNseEVtWmN3bVJuMjlyVk9JV3g1Z2l6d2ti?=
 =?utf-8?B?QWJTa1U1S2FKblJOZVpEMFlwUXZPNGowL1c5VnNTN254UkYzU2JFN0RXQTQ1?=
 =?utf-8?B?LzYyQlFjOVZ2L1V1WGFUSzdDSDNpNGlZNG5Db2ZVREVWSTNzaGJ5aFAraVpV?=
 =?utf-8?B?ZSt3YXdvT3FKa1poQkV6Nk9lcVYxTENqUTFVM2VBR1EvN1p5WWNycGNFSGRY?=
 =?utf-8?B?MW44cVQ3TUQ1cnl6YnkvMHEyTVR4NlZsZTRpeUtadTBDcVY3ZVlRZkVxaWYv?=
 =?utf-8?B?OWN4cnJsVWZiU2t0bUdYNGRPZVdtcHhwMi9adjZBWUU2dGxuRm12VkNkSldN?=
 =?utf-8?B?cjh6aFM1K0twcTRMUVY5V0F1UTY1MUJBeGNIZmZxVGVwd2xjWUxTSVpmN0Yz?=
 =?utf-8?B?cTEwdFVXU2VvOVpmdUtvWUxQelNnOFdCSFRIeWZKaEMzUXpkNE1CZ00wam53?=
 =?utf-8?B?NjlsZ2JJbHpiclQwaG9nZzVWRWJWb294WHFBbkxLa0JlOUVqM3VqcVRvWWV0?=
 =?utf-8?B?ZVpQK3dYL2pFdUxlZCtlUTJYLytLMVQ0SXI3bDkrUFpNaW1BNkVGd21mUXFn?=
 =?utf-8?B?bG9FZGNUZXRFZUhwR2p2RGZrMVlxYnN3NHdwQ1BrU2dWaW9zaDFGejYxQVZr?=
 =?utf-8?B?SXFQL3AwRGtCb085MFpqSkppKzVHaUNvcjZ0eFRCWTI5OWFRblBDMDVJOFgw?=
 =?utf-8?B?TVI2bTJJVE5IdGxFcGVkTXlwUWJ4TjFNRkgvY0RYK2Z2elVnUVVKbXdTRzdY?=
 =?utf-8?B?THpFa3llWGRFalNuQW9Vd1k4ckpLU2VvRmlISWc3WHVkZU5yanFTYzFleFBx?=
 =?utf-8?B?WnpybjdwQm1DYTg5WE5NUUxzQnAvVDdOZ2lxTUxuRWoxMXZYdThmanNodU1p?=
 =?utf-8?B?YjFUeE5aZDNtRG00NVlUY0hDU2NIQlJhaXNETCs3RlFEUVVqQlo0N3Y0eVRN?=
 =?utf-8?B?M3ZsUDRPQURGTy9lbkJZdXVpeUFtRkFqNXVGbGN1MXdCbVRFYUpwNHMzdGc5?=
 =?utf-8?B?eXRHMlFHL2I1RDdPSTRpeUtBYTA5aFlPVlMvME5pZ1lkMzNDWkFidGxzbldK?=
 =?utf-8?B?MUJxWHhWL09uNW55YW9EaEJXUVlnbjR2SVVjUiszeml2VkY5eGxsZDJjaXBF?=
 =?utf-8?B?N2FtOWFDRDhFU1Z2dHdyMXJkQVI4YVNEQTY5bHdSZE82bGp0MXBKdzlyZFdl?=
 =?utf-8?B?a1RaU0UxRjhPcWY1cVJ2YlRwYUsxM1RDUGRhOW9KbDNmNG5jNTBEV2dyT1pw?=
 =?utf-8?B?TEV0OG5icE1TWjFsZFMxRGhpekpmVmZ5Z0l3bnovd1E0L3RDYU1qdklYeUlu?=
 =?utf-8?B?c1dMd3RLS3FwMnd2Y0lUbGJTVW5UYkU2MnJNM09LWW55UXM2d013YjhQbU9m?=
 =?utf-8?B?UC9IT1JUTTJ0ZjIzZ0tFYm5JTXpPd0g5YXc3aFlaeHFMRUs3RGpVNXZPdUhq?=
 =?utf-8?B?aXpMOHhNYjVYNEdvQm1HNUl5ZC9nSHhjWlZ2RDJPZnF3YWQ1SVZNUjhXY3FV?=
 =?utf-8?B?a2w0QkpGWE9aZmdQVmVVcHlSaDNndWh1WlJCWm9DK3RDT3YrNFF6NW5LTUZt?=
 =?utf-8?B?RFpsbjFOdlgzU3EycURZZlJXdjJQSDNMbU1TT1gyMnBYaHBGZlhYampobDhJ?=
 =?utf-8?B?NldBbngvbzdRSVozSm41dVBFMm8xRGZ5TU5NYXdwMjkybkx5c0gwLzhjcDJF?=
 =?utf-8?B?b3o0VmhVZlVqWGRlME9IRDVkc01MU3JaejVacmJYNll0TnR0Q0ZzMFZpS2hD?=
 =?utf-8?B?S2FGdmxlb1V6b2JHdHF0V0VnblZGNkVCZ1RObU5zeVRQbHFkUDhqc1RWcGE4?=
 =?utf-8?B?cEE9PQ==?=
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
	gVtOzLaEvNruq/hPojQ7Ed8zJGFx3Sq4J/BrqwMlxv1/J2iqDamWoGbVjCWzINY38ZFL1gH5MLHS4MgMomBpQKEnEwOs8PlbGy4xuijEcy9r0zELrYpX4IQK0j07drWJQ99WdCt2OVa4HG4tvU9YK4rPPNM12S5P3sRdFmO+maimZbeveX2+ki7jfDkPR/pSvzDjIXObSvuUf4PGPVdnaJL2fXNVJZQ7tonEEeHSvUG9sVCM/lXhc8TAeK8G0lEUBiKNmfoe7qu72SILIvKjjRCwTOrWhiYTU0c1BG21oljGqJWAJEXzRvNc4cHB+N8lZiAkXkX7+7t64UMR/8jrXj3I1EAqWCI0JnWK/ddqRQKIe2+nAcXh5HyLCtLSXSINNTFKrBN+jedXkLt/eauc/xJI48LltyWck0H/MJFgZVemWtWVUNRcS3k84i1JQ/oJ+ZiU93VgtRiW+FbTs6QYWmHTiy7WYgTm1AumWHUn7su1ude2t55q4w8Z8UCbv1jP4A44QzHPZUjI5ESLLrD8YAOMaYebSsll+IRcJ9yV3Ro0Bd8r1999fZk61kjqplKNJE2PPBrchCzqMY0iWJh/D5Dq5HUGMFVOQg3aO2pvo6G0MxIeY667FV5ucJJbypLD
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9865.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975ef01f-9961-4547-70e8-08dd6513b069
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 05:22:19.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWPzrYPahZBywXbNT8PJLvBe2OL6EbFq/SVx7XcwT+qxnsV9e09oYXsCJMcFIZTaC0HBwp+C4yKHrZx4lQCMIvzpuoT1J0xyxRFj9vtIACw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11361

T24gU3VuLCBNYXJjaCAxNiwgMjAyNSA0OjIxIEFNIFpodSBZYW5qdW4gd3JvdGU6DQo+IOWcqCAy
MDI1LzMvMTQgOToxMCwgRGFpc3VrZSBNYXRzdWRhIOWGmemBkzoNCj4gPiBSRE1BIEZMVVNIWzFd
IGFuZCBBVE9NSUMgV1JJVEVbMl0gd2VyZSBhZGRlZCB0byByeGUsIGJ1dCB0aGV5IGNhbm5vdCBy
dW4NCj4gPiBpbiB0aGUgT0RQIG1vZGUgYXMgb2Ygbm93LiBUaGlzIHNlcmllcyBpcyBmb3IgdGhl
IGtlcm5lbC1zaWRlIGVuYWJsZW1lbnQuDQo+ID4NCj4gPiBUaGVyZSBhcmUgYWxzbyBtaW5vciBj
aGFuZ2VzIGluIGxpYmlidmVyYnMgYW5kIHB5dmVyYnMuIFRoZSByZG1hLWNvcmUgdGVzdHMNCj4g
PiBhcmUgYWxzbyBhZGRlZCBzbyB0aGF0IHBlb3BsZSBjYW4gdGVzdCB0aGUgZmVhdHVyZXMuDQo+
ID4gUFI6IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC1yZG1hL3JkbWEtY29yZS9wdWxsLzE1ODAN
Cj4gPg0KPiA+IFlvdSBjYW4gdHJ5IHRoZSBwYXRjaGVzIHdpdGggdGhlIHRyZWUgYmVsb3c6DQo+
ID4gaHR0cHM6Ly9naXRodWIuY29tL2RkbWF0c3UvbGludXgvdHJlZS9vZHAtZXh0ZW5zaW9uDQo+
ID4NCj4gPiBOb3RlIHRoYXQgdGhlIHRyZWUgaXMgYSBiaXQgb2xkICg2LjEzLXJjMSksIGJlY2F1
c2UgdGhlcmUgd2FzIGFuIGlzc3VlWzNdDQo+ID4gaW4gdGhlIGZvci1uZXh0IHRyZWUgdGhhdCBk
aXNhYmxlZCBpYnZfcXVlcnlfZGV2aWNlX2V4KCksIHdoaWNoIGlzIHVzZWQgdG8NCj4gPiBxdWVy
eSBPRFAgY2FwYWJpbGl0aWVzLiBIb3dldmVyLCB0aGVyZSBpcyBhbHJlYWR5IGEgZml4WzRdLCBh
bmQgaXQgaXMgdG8gYmUNCj4gPiByZXNvbHZlZCBpbiB0aGUgbmV4dCByZWxlYXNlLiBJIHdpbGwg
dXBkYXRlIHRoZSB0cmVlIG9uY2UgaXQgaXMgcmVhZHkuDQo+ID4NCj4gPiBbMV0gW2Zvci1uZXh0
IFBBVENIIDAwLzEwXSBSRE1BL3J4ZTogQWRkIFJETUEgRkxVU0ggb3BlcmF0aW9uDQo+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMTIwNjEzMDIwMS4zMDk4Ni0xLWxpemhpamlh
bkBmdWppdHN1LmNvbS8NCj4gPg0KPiA+IFsyXSBbUEFUQ0ggdjcgMC84XSBSRE1BL3J4ZTogQWRk
IGF0b21pYyB3cml0ZSBvcGVyYXRpb24NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1yZG1hLzE2Njk5MDU0MzItMTQtMS1naXQtc2VuZC1lbWFpbC15YW5neC5qeUBmdWppdHN1LmNv
bS8NCj4gPg0KPiA+IFszXSBbYnVnIHJlcG9ydF0gUkRNQS9yeGU6IEZhaWx1cmUgb2YgaWJ2X3F1
ZXJ5X2RldmljZSgpIGFuZCBpYnZfcXVlcnlfZGV2aWNlX2V4KCkgdGVzdHMgaW4gcmRtYS1jb3Jl
DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzFiOWQ2Mjg2LTYyZmMtNGI0Mi1iMzA0
LTAwNTRjNGViZWUwMkBsaW51eC5kZXYvVC8NCj4gPg0KPiA+IFs0XSBbUEFUQ0ggcmRtYS1yYyAx
LzFdIFJETUEvcnhlOiBGaXggdGhlIGZhaWx1cmUgb2YgaWJ2X3F1ZXJ5X2RldmljZSgpIGFuZCBp
YnZfcXVlcnlfZGV2aWNlX2V4KCkgdGVzdHMNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1yZG1hLzE3NDEwMjg4MjkzMC40MjU2NS4xMTg2NDMxNDcyNjYzNTI1MTQxMi5iNC10eUBr
ZXJuZWwub3JnL1QvI3QNCj4gDQo+IFRvZGF5IEkgcmVhZCB0aGVzZSBjb21taXRzIGNhcmVmdWxs
eS4gVGhlIDIgY29tbWl0cyBpbnRyb2R1Y2VzDQo+IEFUT01JQ19XUklURSBhbmQgQVRPTUlDX0ZM
VVNIIG9wZXJhdGlvbnMgd2l0aCBPRFAgZW5hYmxlZC4gSW4gdGhlDQo+IHJkbWEtY29yZSwgdGhl
IGNvcnJlc3BvbmRpbmcgdGVzdCBjYXNlcyBhcmUgYWxzbyBhZGRlZC4gSSBhbSBmaW5lIHdpdGgN
Cj4gdGhlc2UgMiBjb21taXRzLg0KPiANCj4gQnV0IEkgbm90aWNlIHRoYXQgdGhlcmUgYXJlIG5v
IHBlcmZ0ZXN0IHJlc3VsdHMgd2l0aCB0aGUgMiBvcGVyYXRpb25zLg0KPiBQZXJmdGVzdCBpcyBh
IHN0cmVzcy10ZXN0IHRvb2xzLiBXaXRoIHRoaXMgdG9vbCwgaXQgY2FuIHRlc3QgdGhlIDINCj4g
Y29tbWl0cyB3aXRoIHNvbWUgc3RyZXNzLg0KDQpIaSBaaHUsDQpUaGFuayB5b3UgZm9yIHRoZSBy
ZXZpZXcuDQoNCkkgY2Fubm90IG1lYXN1cmUgdGhlIDIgb3BlcmF0aW9ucyB3aXRoIHBlcmZ0ZXN0
IHJpZ2h0IG5vdyBiZWNhdXNlIHRoZSB0b29sIGRvZXMgbm90DQpzdXBwb3J0IHRoZW0gcmlnaHQg
bm93LiBIb3dldmVyLCB0aGV5IHNob3VsZCBpZGVhbGx5IGJlIHN1cHBvcnRlZCBiZWZvcmUgSFcg
SENBcw0Kc3RhcnQgdG8gZW5hYmxlIFJETUEgRkxVU0ggYW5kIEFUT01JQyBXUklURS4gQWZ0ZXIg
SSBjb21wbGV0ZSBteSB3b3JrcyBmb3IgcnhlDQpPRFAgZmVhdHVyZXMsIEkgdGhpbmsgSSBjYW4g
c2VlIHRvIGl0LiBVc2luZyByeGUgd2lsbCBiZSB2ZXJ5IGhlbHBmdWwgaW4gZG9pbmcgdGhhdC4N
Cg0KVGhhbmtzLA0KRGFpc3VrZSBNYXRzdWRhDQoNCj4gDQo+IEFueXdheSwgSSBhbSBmaW5lIHdp
dGggdGhlIDIgY29tbWl0cy4gSXQgaXMgYmV0dGVyIGlmIHRoZSBwZXJmdGVzdA0KPiByZXN1bHRz
IGFyZSBhdHRhY2hlZC4NCj4gDQo+IFpodSBZYW5qdW4NCg0K

