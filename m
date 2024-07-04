Return-Path: <linux-rdma+bounces-3643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA5927418
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 12:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47A31F26E1B
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD21AAE13;
	Thu,  4 Jul 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="FimWWvXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cluster-b.mailcontrol.com (cluster-b.mailcontrol.com [85.115.56.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2D1D696
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.115.56.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720089114; cv=fail; b=mFWWtKIzqPcQaBMZVcg62HaxJv5bphNW7oZAhNLkmTENf6YuKY/PE6A4cJ/TjBja2Ur64zdOLvOmHaTePfB8g/W6Qr7UuIj+khBwjSZCFIOr7S5ZNAbcIhQTt8PRG5yYzmZ8evteGW+29EbYSKd9Sx1wSbo9lMGLo2VtcQ4PHmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720089114; c=relaxed/simple;
	bh=6yROPO3MnS7jiDG7uvnkQk0Q4FJ4RzbseUCC6f4PDx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPAcUtHdgrRrRtLCw424elYLDC8Y/jgDlq30mKi9+YVsr0O6V+kfGGtW+abLdU5MqMNE6vWT94tW8Tt3cEGm826mXZENeGy/JOP7Zvh7R/pqRLQaQhFiLOXUj1J0yCsVviFl0oSLv5SAaskG5AEN/K0/5wC3HoTDr85MbL8RpAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=FimWWvXI; arc=fail smtp.client-ip=85.115.56.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: from rly16b.srv.mailcontrol.com (localhost [127.0.0.1])
	by rly16b.srv.mailcontrol.com (MailControl) with ESMTP id 464AVWd4426954;
	Thu, 4 Jul 2024 11:31:33 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly16b.srv.mailcontrol.com (MailControl) id 464AVLL1424089;
	Thu, 4 Jul 2024 11:31:21 +0100
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03lp2232.outbound.protection.outlook.com [104.47.51.232])
	by rly16b-eth0.srv.mailcontrol.com (envelope-sender oshpigelman@habana.ai) (MIMEDefang) with ESMTP id 464AVK2M423854
	(TLS bits=256 verify=OK); Thu, 04 Jul 2024 11:31:21 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWf926wZCkE6RSNSXRNyAIjX+M/M16aoS0nn89BX+yzWMF+REbB6rRKdYZrPskJQUvwguYRIKLGmFsOx7uvrmONoibP6VZCizxoZWus5dTk5272m8AZYAxn9IX35Vz6MhGs3uBGz5zDUJsQdHOyLk2E8W3odgifdhqfU/StMCZ+eXhlLuEc/9omMFiHZqXpQEBzm+ZH9OQZZ4l0Qmgtn9mh2l6uzU6oqs7YtTdMxEjqeNHZx2a/zz/3Eso2uDnvQ/HH1KAgB5vzUFtcPyuxXhDye7mZKcboKDHZ+2DDIC757SllXWcSs9WZ9cOmrtgykFWZCv4vML7L7yJNWIVePNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yROPO3MnS7jiDG7uvnkQk0Q4FJ4RzbseUCC6f4PDx4=;
 b=JfIPx+usBTYnNUUFl1mjm86w9+qRU8OedIbUmufdpxjo+7zmdb5VOrN/4m4DANZBL9+tVbNgEi3r0Zhn86gBUxjHtQbIFOqWS0uWF/0Ope5VnOKqIqeU1WnM1ElQu0ZiucpKyTGpyGpqZzKT6QCMmVPbx1ssVvPzdoGTVIsJmUvEwkwEjnfXTK7gy+nzz3ZCbEV6Y3njnpllrIInWiXIMgW1sqsmyla0GIVKOVorlubPo1BSn8OCgabyJPs+qTfVKAMcHlkD9H+R5b02C1jFm6Jx/5jR6UYEmX+IcQnRelLtMO6TVgvq/vzT8PTSlOkFsQfVrDK4UjvQuOFwOxH2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yROPO3MnS7jiDG7uvnkQk0Q4FJ4RzbseUCC6f4PDx4=;
 b=FimWWvXIkpisj5i/K2YH9bOS94hbMZDv5t5CuufcMJmYvNE59nbkXjCgaXt1S2qgIKXK6jNsWAzoUQzMF2d82F0syiYfHfO5+vNkwgJa7zqMwB7yhARTbZukvvPdzLPktcDnM2pHyjED5WbfssrsXrfn7ow5ifieyha/jL66NIRUkRsJdBpLdIQJJ3IaH8iRjIS8rOAwb4iRBaew4X65FOBjV44b8XkaC+vzmyT/JXjJCHUnb5c6f+SS56KqmqzN+qb2zac7pJAfD/p7tG3BOQAu5ST3kzu2/ga3wbGqhvQef1P3pyUi8CQY8H094Hcf5xbavlqXzlnO/giqJh6eaQ==
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com (2603:10a6:102:33d::18)
 by DBAPR02MB6454.eurprd02.prod.outlook.com (2603:10a6:10:17d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 10:31:19 +0000
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9]) by PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9%3]) with mapi id 15.20.7719.029; Thu, 4 Jul 2024
 10:31:18 +0000
From: Omer Shpigelman <oshpigelman@habana.ai>
To: Leon Romanovsky <leon@kernel.org>
CC: "ogabbay@kernel.org" <ogabbay@kernel.org>,
        Zvika Yehudai
	<zyehudai@habana.ai>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Topic: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Index: AQHavWrPBqHPlb7SS0KqSAV7MpL0ALHmf8YA
Date: Thu, 4 Jul 2024 10:31:18 +0000
Message-ID: <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
In-Reply-To: <20240613082208.1439968-13-oshpigelman@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB9149:EE_|DBAPR02MB6454:EE_
x-ms-office365-filtering-correlation-id: 0d06eb76-6106-43c3-7c0e-08dc9c147102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Ni9Tc0Q5aUVVc1lDSFkyazZ4WGxRWlZPRDN4T1oxcThrM2VORTY4L2dIQk5Y?=
 =?utf-8?B?NDF0cVNqSnkwSXFOMGtjUllTSWVScHpYOFF2VE1jSWp6NDF2K2ZBK3BnRUJ5?=
 =?utf-8?B?TEY2dXkyV29ucmt6S3BkbjRNNXB1ODVBUUUwVlZWZWJZdTRJNXJUTFlQelFC?=
 =?utf-8?B?OXVpeExsMGl6bDhHSlFiOGw4RDlJbTdmUWVOQjlkQXlXczljeXRtcUp4TkVQ?=
 =?utf-8?B?VjRzekMrYnplWGdMYU42QjFSOW1ESnlYckhtcGZwejFpRWc1REJUdEpqV2p5?=
 =?utf-8?B?WktMQ3ZVNUUwbDVMd3ZhempBMVBiWk1pckxja0RVV3ZoeHZtOGFhN0dveER2?=
 =?utf-8?B?Z1ByRFFna3U2WW84bk9KR0N3dW50VEtRMzl0UUtBWUtuUVozQWNRdFYvb1FL?=
 =?utf-8?B?dGJ6dGkzYUt6Q2tKS3AvdUhsUkdYSXcwcXR0R0ZuS2c5QTYvYnlrdnFSZTNF?=
 =?utf-8?B?ekM3dFg0U2FxME45THJ3YXhHYUg3NzJCajg2MGNhd1JhN0tINzZHSTBHVHlK?=
 =?utf-8?B?c0xRY0dqUWZ5L04yanRFdHZWbnNFcTNBQzNnTmlhZGZUa0ZHMmp0OFdVYVpG?=
 =?utf-8?B?LzVuZTE5QU5vNWhMNjlGZS9jbm42Skp4amx2N3ZlTitrc2owQ25QUWNLVEl5?=
 =?utf-8?B?enFjRmVvZ3BoclBJTXhsTlF0Y2JMbGd5enFKTFNwaXdKdzYxcUFucEd5MDNN?=
 =?utf-8?B?SnRHNFZIVlltOW9WSDZwejFwRGNjNzBCd1p6SEV4WTI2MiswQXJyUXQvWjlM?=
 =?utf-8?B?NVgvZVlQWXBKT3c1bE80NEZoakJySkV6OXp6WWtqdURvbVB0Q25DRkExL0JZ?=
 =?utf-8?B?cVlVb0JxSzBWSW9COHVOeWRmZTBpRmpHT0QrOGpUWjhPQ0k3MTJVU1ZXeGJv?=
 =?utf-8?B?VGgxWGJvblZSM1dLUHZFYWJBZ2k1K1Z6MkJlVEo3dDdCZEtGMUo1V0RWajV2?=
 =?utf-8?B?SHpXbjZtaEl6ZFJuZFIxQTIrK1ZaZ0NtVHg3eDl3NFZqRDhBMEErQ1kwRUll?=
 =?utf-8?B?VXFqQXhOaElpSUZydUpwS21XeVFpWHIxaDlCTDhvSWpneFNhTW55d3VRQmx5?=
 =?utf-8?B?K09wVkxBb0ZPNkRyL2xLRFJOZGtLd0h6cjdITEtUQ2w4aTkzdUJObzQyL2JV?=
 =?utf-8?B?Qyt5MjlaWk1PWTAxaExWR1lyZjhBbmxzU2NPYnpmSnhnZUtJbS9NcnFCOFMz?=
 =?utf-8?B?RkIwWjJhcHVtOWtoUVo5d005OHBHME8vSVZjMFVXdzRzL3lvb3F1NWp1UUZB?=
 =?utf-8?B?V2diZUdoMFB4dGlFaUxFTEw5QkFYNWNuQXhrdmhTVUZYeW9pL3FtY1JObml1?=
 =?utf-8?B?bGF1aHdaRXA3THVvR3JFaXdaQ095aGc1WFJham1UWE4xZ1JPMnNDUDdPc05R?=
 =?utf-8?B?V0Q1eURSMER3VTBsVGxUNHRtMC9NdlFLclJLUGFqd05may9BYkppNlBSUVhF?=
 =?utf-8?B?S2hPZ1h3bldoRGtmSlBQNFFxZzAxUjdUTFVjaUMvcG9TSkhKbG8rK2xCU1pv?=
 =?utf-8?B?TmNwL2hZVGJvcTFDcmtsRmRya0lSNWFPYXA2NzdqQ3FWelpUY3BKSzlGdHNX?=
 =?utf-8?B?NUpYWFlOL005M0RvakluQktqdG5LbnJHeVZPUDVxaDFFcXBZZFNDdk1admti?=
 =?utf-8?B?VDVYZmJTY2tDcjEvNzNPdi9WWDEwNDVQdUQ3djlCYzJmY1ZzRXBrc3ZIN3hJ?=
 =?utf-8?B?ZmJLVldjamx5UnZmNUtZcytuQkpic3JIRWU3dU96UjdjQlZSNTJNSnVscEgx?=
 =?utf-8?B?a0dPKzhTaVR5eWhXbWF2bjFlVHZhaWRKMHZmN0VNVlp6OC9CdEtlK0VFM3d0?=
 =?utf-8?B?Znd1cXdSL1dpZ2VuTTMva2VzVXdLaUdEc0NZMDRZV3JnM09xTlNabWlJSHc1?=
 =?utf-8?B?TUdQRGJUTEJjRVpUdHBIbFJYSlZKYXV5VFRDR1JtN3Z5dlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB9149.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YkNJREFJNEI0QXJZQ0MySFlOR1NGQUc2enh3aVRBUmFiVkRRTVhwUWNZa0sw?=
 =?utf-8?B?OWxwTm02UmhQek1tM2treitDVHQ4bzdEanVrMDdUaHBnRGg5WWVETHRoUVZt?=
 =?utf-8?B?VXlvYlZLc2RRc24wT3FQemZONFYzRW5zYVlZOTVOSWFhV2F6Tzc3U0k5TUo0?=
 =?utf-8?B?S00yV0N1eWh3dkhqeFpkSkI3dmY0KzdVekxMVWRpOURBU0l5TmRzbUo5RTFZ?=
 =?utf-8?B?M0I0SGZxQ09jZ3JTZFRzeHZSL0NBRTlYVmQxd043V0NXMVp3c2FQeTZqZTZ0?=
 =?utf-8?B?aG5xdnhNbjI1TGVRSHp5UE9aQ0h6aDBybCtjczRSQkw2WEJoY1JJa1VZdGdr?=
 =?utf-8?B?WW9jQmJaaE1MblNvV0JHOWExRnJSSXVMajc0NXZWdk53SnRPRzNzSmE0OXRh?=
 =?utf-8?B?WXdMK1VJSU5iSkNWS1pSMFJOc1Qzd2JaQnNkMEtTaU9oNFV3a09SYzFGd0F2?=
 =?utf-8?B?T29SMzErZDJ5b2I1Zm03dVJPZUxRK2hITm44dTRUQ1BpNFcwNjhYZTNJSUtW?=
 =?utf-8?B?eEVtQmJzSUQyNDgzcENuMWxFQlNkS0JyRzd0aURjb1ZleEI0cndGYWFaZjVi?=
 =?utf-8?B?ZjVXbzMvV1MxdXVZdFlyNTJZQ3VRZUxhc2FyQWZQemJHbUgzNTU3SXkrRStZ?=
 =?utf-8?B?TFJaMW1MeWZaZnJYS2tBajBtYnVNRWJwUkcwOFBnYVNIakovYUZDaWIxa2kr?=
 =?utf-8?B?K0FnZzRWbmV1ZEhUVGVpSWhoWVBDblFFQTd1S05vZzhRVG9aSDVTZThob09u?=
 =?utf-8?B?Wi90TC85bDJGR1p4V3BydHBVZVZPZFRMZWtUSlFFWlBiREVhNVhQamFpVTZO?=
 =?utf-8?B?bld3SWZUN2pJZk44LzFuQXBaYTRFWW5haE9uMm44eGt3c0M1b25wVkpWQVEz?=
 =?utf-8?B?L1p5V2oxKzErNHJmUnFha2F3L21acFNsQ2VlZzMvSzBISm0rTjZ5V3lOMWU0?=
 =?utf-8?B?VW5qc204NXliOEFDZ2NmWEU3MXNKNlJSTzZNa0w4ejFBSTEvMWRQWDZ2cGJU?=
 =?utf-8?B?a2cvSUVlZXFRSVdiSzMxdm1ZZUNXTjBkVGdYUDMwRXNGNm9TZW05ZnUrMy94?=
 =?utf-8?B?YVkrS2dwNHF1RkFkSEFkcUwzK0h3NDRUWU1IMVN0bEJjVjUzeThnRDROYVhl?=
 =?utf-8?B?N2FkRlo3RWlkWmEyNUF0UHd5VmF3VHBidktYZXI1L1ROSC9UbWFUbUV3UHVq?=
 =?utf-8?B?Ym1mYVVDUWtTZ0pKQ0o4bmM5dGtLbnJHV3RZWnBncGhQSERMUFRtMEdRcTNS?=
 =?utf-8?B?RHBPZUEyT09JRk0rc2lvbmF4cVNlK2JsQUxYeEo5OGlGakg5d0g5RVZLclBD?=
 =?utf-8?B?UmNWQWg5c1o5V1grYzl3NGxkOXVQdVpLWnU5ZWYrN21yUFVVWW5JRW5kWFBt?=
 =?utf-8?B?TmZROXV1NUdXTXkvN2psVXlpY1BNYUprdHZ6L2YzR3RteXluMXdsbm1LS29j?=
 =?utf-8?B?ODdmYW12ZWUrcEQ0TFVQTW1HM0VBSWFadUtRSlg0MlhtVFFvOVpXVlBKbExk?=
 =?utf-8?B?QXZPMzhJRHZtVnFnbFo2Wnl5MGVrSmJwMm5Qd2Z4Q0RwbmVCVklyVDY4cmxI?=
 =?utf-8?B?cGtqUmJnYjZhLzBoZ0JTbm5JNjhQVnhOeSswMUxtUXZ5eTByQW1mL1RCMXNl?=
 =?utf-8?B?dlFRMGxjMWNtZUVpaEtObDV6Y3MySy9wRnpEa3NEY0g1WHlXZ0FNQUNEL2Jw?=
 =?utf-8?B?N0hzYTdvMlMwcUNzVU85SGpmejFnZkdoMVE1eGc0ZjZKdGhRRU5RSTArQVU1?=
 =?utf-8?B?RzRQbzZuUU42ZHFIdWliZENCYkYzQzRiVTdtMk9UekMxQ3p6Q3BKMmcrV1Q3?=
 =?utf-8?B?eC9qcUhFWnF2SjlQN3FlWnlyOVpyRDZEaG1yTzNQTGRGQ3U4SGJ0T3J2TGZt?=
 =?utf-8?B?bktJaEVSdXVzZkxUREJMYUhQRUlMeUJQYXppQno1MWtwbC9uQjV0T1p3ZVI3?=
 =?utf-8?B?b3hCNnFNbWhUQW5YMzlWS1FtY2ZCSkZoejZEeDBSRUFvNzFydnZGck1tc1dZ?=
 =?utf-8?B?Ly9FYUcvVUpOSDFLSVlaSVM2SHRTS2hPUHlwelgyZTJWQ2RGR2hSam5WdFZj?=
 =?utf-8?B?Zm53WU5hc3Rpc1J2MkIvK3NJdHlhaG53Sy9JZWdjMmxwNjBNbk12NmVnTlk4?=
 =?utf-8?Q?Lj101TM1mVZs30r3LmfTPPLng?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C47B5689AF52B45A4E1E629AF7BD55F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EL47m7h2jnfSMxK1ie/xsiwWYr0ipOQeEiE3Lq6MoGVt6youapd5MsUE+z1JkfrgOEE+nCom+KXO6850/MpcbUb73h+NLS+sHWsPpd747IPpPBQC5edd+s7axyYoJZ0ZjuRH6h5kAqHnM1Qlk5MTUbdhnFO7/jnSa16Qjcqj+z5Zbo7AsF6lFX3jYPYE2YFH8BjjyT4H5xy16uMAk8Xl5T86WweLOwRK6XyxlThjGLM4E8XXPTBGGagiN7sO+QvgGq5qiw7UibaC7JwnLciR6JMSjVuC66KTPlaYJtKNPtydOJ+9QtWN69rhY8JqvnsgzZYe7psMfW4gO1kqJFfEiZuJYcNTSR9XinYiTS4Gx0tee4gn/IoHXJXrlIg0doa7ox15XAi6Dmh853kBkwZgY9AVZDZFeaOUMbh3HEk8ePitVhvmEoAxuKabIq1vV8SFet/ZFH8hq61UcpySD/XmbqNkmmkbAVc4qZuX4stgdqf6pXVaqTaOjEst6lDTKzaRwqhg+j+VgOtKHTuS6PQQsIUKjv6sranPo/8ERtkK7mwKn1E5gsX4mekTAEE8YjOzo4GAufcbZNqg+dem31Jt9fPSNxzYGCsTOD975C87lYqvyVwxfXlWCX1nAzPI9ck/
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB9149.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d06eb76-6106-43c3-7c0e-08dc9c147102
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 10:31:18.8421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLz1hV978uyC/K45PR2DqAqGPXDIsXqOZkJNJnZaBanNfTO68eHHZy5gpVSlZk8xpGVn3En2sCBPN4RdVWFreg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6454
X-MailControlDKIMCheck: cGFzcyBoYWJhbmEuYWkgW3Bhc3Nd
X-MailControl-OutInfo: MTcyMDA4OTA5MzpGUEtleTEucHJpdjpmJR9BI0WbMfhpoDLWlHihYYmDIIusBF4tD6aBkeWZFLyVeEzrw7RHiNGYYiLqW3JgzRE24GdLWunMSccsoAugipD8T4J8B1NPcOCjfHqyWG2YZMP3ZTf1zdNNE0OfL9XAB8Up1mfaeEKebSJOdHvMX/bVfWEU6UVP62MX3Uhkm8D30wmbQSqvObFLn3Rt/vVFN6CfAA66cIgbe/2SfxtEDk5bGoRfXs7tNME6lH7RtaUuLkyfj+K5kRzGNGbspBIJuaCo8Yowgo+yDyrJXZ/V8xu/FtwT4jB7AZhYoYeESU40N8X3O4j5OTumgbU/OIwbp+/2WJi5T8shUgN/OBEI
X-Scanned-By: MailControl 44278.2145 (www.mailcontrol.com) on 10.66.1.126

T24gNi8xMy8yNCAxMToyMiwgT21lciBTaHBpZ2VsbWFuIHdyb3RlOg0KPiBBZGQgZGlyZWN0IHZl
cmJzIChEVikgdUFQSS4NCj4gVGhlIGFkZGVkIG9wZXJhdGlvbnMgYXJlOg0KPiBxdWVyeV9wb3J0
OiBxdWVyeSB2ZW5kb3Igc3BlY2lmaWMgcG9ydCBhdHRyaWJ1dGVzLg0KPiBzZXRfcG9ydF9leDog
c2V0IHBvcnQgZXh0ZW5kZWQgc2V0dGluZ3MuDQo+IHVzcl9maWZvOiBzZXQgdXNlciBGSUZPIG9i
amVjdCBmb3IgdHJpZ2dlcmluZyBIVyBkb29yYmVsbHMuDQo+IGVuY2FwOiBzZXQgcG9ydCBlbmNh
cHN1bGF0aW9uIChVRFAvSVB2NCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbWVyIFNocGlnZWxt
YW4gPG9zaHBpZ2VsbWFuQGhhYmFuYS5haT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBBYmhpbGFzaCBL
IFYgPGt2YWJoaWxhc2hAaGFiYW5hLmFpPg0KPiBTaWduZWQtb2ZmLWJ5OiBBYmhpbGFzaCBLIFYg
PGt2YWJoaWxhc2hAaGFiYW5hLmFpPg0KPiBDby1kZXZlbG9wZWQtYnk6IEFuZHJleSBBZ3Jhbm92
aWNoIDxhYWdyYW5vdmljaEBoYWJhbmEuYWk+DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBBZ3Jh
bm92aWNoIDxhYWdyYW5vdmljaEBoYWJhbmEuYWk+DQo+IENvLWRldmVsb3BlZC1ieTogQmhhcmF0
IEphdWhhcmkgPGJqYXVoYXJpQGhhYmFuYS5haT4NCj4gU2lnbmVkLW9mZi1ieTogQmhhcmF0IEph
dWhhcmkgPGJqYXVoYXJpQGhhYmFuYS5haT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBEYXZpZCBNZXJp
aW4gPGRtZXJpaW5AaGFiYW5hLmFpPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBNZXJpaW4gPGRt
ZXJpaW5AaGFiYW5hLmFpPg0KPiBDby1kZXZlbG9wZWQtYnk6IFNhZ2l2IE96ZXJpIDxzb3plcmlA
aGFiYW5hLmFpPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpdiBPemVyaSA8c296ZXJpQGhhYmFuYS5h
aT4NCj4gQ28tZGV2ZWxvcGVkLWJ5OiBadmlrYSBZZWh1ZGFpIDx6eWVodWRhaUBoYWJhbmEuYWk+
DQo+IFNpZ25lZC1vZmYtYnk6IFp2aWthIFllaHVkYWkgPHp5ZWh1ZGFpQGhhYmFuYS5haT4NCj4g
LS0tDQoNCjwuLj4NCg0KSGkgTGVvbiwNCiANCkknZCBsaWtlIHRvIGFzayBpZiBpdCB3aWxsIGJl
IHBvc3NpYmxlIHRvIGFkZCBhIERWIGZvciBkdW1waW5nIGEgUVAuIFRoZQ0Kc3RhbmRhcmQgd2F5
IHRvIGR1bXAgYSBRUCBpcyB3aXRoIHJkbWEgcmVzb3VyY2UgdG9vbCBidXQgaXQgbWlnaHQgbm90
IGJlDQphdmFpbGFibGUgZm9yIHVzIG9uIGFsbCBlbnZpcm9ubWVudHMuIEhlbmNlIGl0IHdpbGwg
YmUgYmVzdCBmb3IgdXMgdG8gYWRkDQphIGRpcmVjdCB1QVBJIGZvciBleHBvc2luZyB0aGlzIGlu
Zm8sIHNpbWlsYXJseSB0byBvdXIgcXVlcnkgcG9ydCBEVi4NCldpbGwgdGhhdCBiZSBhY2NlcHRh
YmxlPyBvciBtYXliZSBpcyB0aGVyZSBhbnkgb3RoZXIgd2F5IHdlIGNhbiBhY2hpZXZlDQp0aGlz
IGFiaWxpdHk/DQogDQpUaGFua3MNCg==

