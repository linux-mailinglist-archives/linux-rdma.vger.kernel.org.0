Return-Path: <linux-rdma+bounces-22209-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7qBGiKPLmqVzQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22209-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 13:23:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB748680E7F
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 13:23:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Bqfj9Efi;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22209-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22209-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330AD300D451
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 11:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00F8313E24;
	Sun, 14 Jun 2026 11:23:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E6238171;
	Sun, 14 Jun 2026 11:23:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781436189; cv=fail; b=VUcaHrHFBo27muRBebEe7g4oLR0itQ0/kNcZt0OFhOiShDa5JSJZ2FZTKySlItZy6UT7lN8Y48O3DQ25/sVhZU78ZUohQwXaPL26BOITlpoSwOv9dStwSENXqF4l5fuhI98R4wqhFhzT1Qfdv02FnCVocGaO+vqop4DCDeeRoqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781436189; c=relaxed/simple;
	bh=NWaSrAhlZWaazZw8zlCQChvv6OXOJ35HnWNicw65nQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhRSVTzZZhvwYfurNnAq0FuNmgFR26uAuLSxWaDlpbFnzCeet16WPNwr0a8y9E/DsvCRcbkH6GOiSnS4RAgbfVMf5lvb7tcnor9pBgn1tHdMT1uWt+MSg6TZQXpP/9EpOuTLxxRhDhHznrq/RnbtjKjFZqB97AzVtsSDbJKM+c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bqfj9Efi; arc=fail smtp.client-ip=40.107.208.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTYnDNLf1iibYh0NTBtJpIupgpTJ9bBpVAtjR4JKtsRpVsEy88VSgfP6mJVAn9fCrB5GFEXUzM6h2D+OrMI5Byyg8YdMD8kHcvUY+0I9ypdmtpGomXenlKU/o8BwDNgyRW3D2HebX6n023thEUmLRJxKoHSOtHK1hVNufYBCo3F6BQdzPurLesBTNp9Z0iO2K0Dwoi2nTYKCsVIPhyB3v5fzE3OV3LgXUKUtzq1ar5hii25hGsMe9+dTiG/yCOhEabaDlKT3QqsQnMGylbsre7pGr3hOS4JOnPV0kUALYXgwqDy4/1U1f4JHDXN1KSlKv/4zePVC0RiLm3JXF3jwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7gc7rYzTdGhEgnbKTnwlxzB9t/1nQpjKudzJ50FWq8=;
 b=BPF9xDqq9p7NC6sWe49SV4ozeb9kbYWkup0ogGCVIDwbxyptYUJlYMpXSaybSy7HAJhgm6m4odfTVrdO0CxIw++Q4fnBDRLrQs7zGLa9yEvHpYFkXZIFhY+fHCb0ijvt3BQb9Ycl/UQxsLEK7pkJaoLXz3ldwRRrNdZCLrUXr3adsixfuF7GNNgLQEUmYh/ai06wkp4IHrAzylTsDxjmFtB2+HkijyWvz5GxBsTI9NM5YGylqTW9HfBMMwz7yYfjAsaCjWdd4/5BqAVvrqCnvmKfIka+tgWT0BsS5V0TbfF8fJR8RxxAU/0+krJyL4ER9rZ+KgsuB/yHEp6Lv/BELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7gc7rYzTdGhEgnbKTnwlxzB9t/1nQpjKudzJ50FWq8=;
 b=Bqfj9EfioxSyUOngx9Lve3TkGDhgPekDFvaESb0RoM5OK3dAmE198sdN8bNe67JegYpjNhb7qbEnGi7M8/wno1v89sFI5zzzGfLPBltiVBojBIc1GW1IlgTmnNPO4q+J5ajxZIKhzxvswJf9fvzCHX56QKsFTEPmVeyd7w+G5eHY3JqTkmduc7SO7dctmscYa90vNnyD3jw5tBnx+Q1KPZhV/7vWoVBDs/i8IeO6lgJVe8mDX0Tejjk9GbS/9zTTBPRgCVPYN9Est8/6m1PNNKNUc1p7Q0Z140kZTcd0eb1rmHg66FSWedtwArkxwLOqt1Ka6aIdmxIROO8ULG9E+Q==
Received: from BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 11:23:04 +0000
Received: from BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81]) by BL3PR12MB6473.namprd12.prod.outlook.com
 ([fe80::778:72e1:e792:df81%3]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 11:23:04 +0000
Message-ID: <dce83cca-79c3-44fe-ac05-0eeeeaa60890@nvidia.com>
Date: Sun, 14 Jun 2026 14:23:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Fix integer overflow of user QP
 buffer size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 Jack Morgenstein <jackm@dev.mellanox.co.il>,
 Roland Dreier <roland@purestorage.com>, Eli Cohen <eli@mellanox.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Maher Sanalla <msanalla@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
 <20260611-maher-sec-fixes-v1-2-cd8eb2542869@nvidia.com>
 <20260611191723.GA1516987@nvidia.com>
Content-Language: en-US
From: Edward Srouji <edwards@nvidia.com>
In-Reply-To: <20260611191723.GA1516987@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::19) To BL3PR12MB6473.namprd12.prod.outlook.com
 (2603:10b6:208:3b9::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6473:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d6a64f-a93c-4f28-d117-08deca074d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gyE5lwacVtHV7EStnavQb5bqtOWcrxpLe8t3hSkoWPKbnMSwHqIX8KQCEOmaH7bcbcObLNd7Y39s0C79dGMSaLKtiszA2ZMLf/vYUTlre7+3mFOUpFAAoAt6znmTEX6kzVB3h4COsbroNNR+AwW8ty+jCbViG+yZ4UL2OCnVifSwjwCABeCpW8J01am26k3tWUvufyIrFxsWZEUuuZJueL+2eRTI63iI6eo2qu85NKERYQLUm15D0s6HezUX2cNTAm09QlahL3s+TsYonHQ5CTH2jmbLS8sjlUoD4zqH7Rx+aNf310Ouz4lwmxaJT0vvktGSoBQihnqo+b28SEthxQIp3GS2K/OV/qaz00brR5OjONObnauua46S8hiTe4CAoP4ZDqR1njUikhtqEhBeTAatEd6BD3JY1HiuBiTTfEhWxkx3YJ4tpC7Hc6VZ3qJJCBDnMX7XyM4VW8kvgB7pyf5tuFHnpv64bTpbzVmExPu5MGFF8qqQoB7IAjMZ0PTEY+eik0mPPXsE6lNzPt1OlkEzV2hBXf2lLI3xqS1ILqPlllufL8Skg6PH3z3jQ4ohaj5tx4XQAvC4rVocEnCG2hLZdYNEJdXJvOQGSvo9dg+OA8lk4URPL4zmyVRJqgZ98hOe+6OPH4Ipk+VYyJb64aNl6A2LD9TpqCGHV0tdG/ChDqw0BbVEkHwFT6mUlgyN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFpVY2dhcTcyVlR6L2dualpVRXhMZDEydTl2Smt6cW04TVUyZXY4MW10RS9B?=
 =?utf-8?B?UFVEeTFUeGRSZmZyY3FpRDhEU3EzZCs4ZkNUWGhYM0ZOUHhPVlh3RThFSFg2?=
 =?utf-8?B?TUZkQjcxU3EzdDJBY2pvYjk1Z0hlQ21vd0ZFZmlBdmtjVk55MVFNRlQrRXh0?=
 =?utf-8?B?ejN5dGxmV2tyVVdiWnFsMlpTV25oSGkyY1plTzg0ZzdqRGYvTmd6dWVFa1A5?=
 =?utf-8?B?LzYzQUZCQnBhQjhzaTFSZ2NtMmZVa0h6THN0Nzk1OW5wVFFadlpxdzVQdHpJ?=
 =?utf-8?B?NThFQmRpM1V2bXZEUzdOaXY3b09TUnVUV2dFKzhqMGVhbDNDZ2JEN0hvQ09t?=
 =?utf-8?B?RWFUdEx0bUdNS05KWWxONVZYU09BeVpJRFlramUyVHVNQXBZaWxZTmsvbG9y?=
 =?utf-8?B?RWNWbWVWNGJiQTVUZStmb0NXemtadWpBeHM3a3psK3RDMVN6ZXQ1SjNkaUc1?=
 =?utf-8?B?Y2p1aVRrU0tWL1BoYVJnZG5ZcnRqNUczTXlaTC9kdWNHRENYKzN5K2lJTUd0?=
 =?utf-8?B?RENFQWQ0c3A3bWl5NkdFYlcvR2pFQ0V6WmZrUGZ0aVVZWHhpQ2x4K2lYZWpV?=
 =?utf-8?B?YUJiZjFra09aQmVTTUNDR05CTGg4Z0VFV2FUSUEraTBPZm9SbnI1d0FWSXV6?=
 =?utf-8?B?ai9yQjYwYXJHVXhWWmppaTRoRGt5VmxzUmJNWFRLSlFYdDIwZ3B6c09uSlJm?=
 =?utf-8?B?bHpjR2htUjkrOEY4UVJXa0FuQjdqdVZPcW9aNUVhclhXNXljS3o0eG83ZWI4?=
 =?utf-8?B?K0lwTDd4L0JvZHpZRURsMXF3NzVBN3JQNG04THN4cCtyKzJrbERLdkpLSWVK?=
 =?utf-8?B?VW5QZ1ZRcmtwNFRVVCtzMWRsUlhaRFZIYVZXRmpUa0hpY2hDNWNmbCs4d0lB?=
 =?utf-8?B?R0oxcFVBVEd4emdtU2ZSbTdZaXNjeXpndGtkSWIyVXJFTFZWVlNBSEJIdHlI?=
 =?utf-8?B?L1YrTVl5VXdENS9iMW9td0g4RXEwSUtBcVRySWVrQkxIZ1lGbUVlOUVxYmxn?=
 =?utf-8?B?cnB4cDE5RUMrRE80SHhRTmk4eHFVYnVoaE1oem50Z1Rmd3dqNkQvbmsvR29p?=
 =?utf-8?B?bXU2aENLN1JYUFh6OFNZdGh3NndSSXE2NmxNblNTd2VZSXRuaUdHSW9mVHZl?=
 =?utf-8?B?VUoyTS9MNnM1TzBPRlFxY3FvRE4vVkhMRmNPYkJxYkdKUUc5cmdjZlVvYStw?=
 =?utf-8?B?TXk3OVpuU3JBRVFrdXJwWTJpOWFkc1AvOWs5ei82ai9HSy9SSWlnRVJDcnEv?=
 =?utf-8?B?Y3lWZXFwUWRiNk15L3c2THF3eENSWUlDVE12WXlsSkVyei9rK2VwQUZnY0JQ?=
 =?utf-8?B?d2diVmVqMkxyTXhQK3Z0Nk5yb2Nvak1teWI2MTdXOTd3am9tSTFjT2pROWJC?=
 =?utf-8?B?dHdiQ0Nmb0p5L0o2TlV1Y1FlckMxTHc2eGlaMXNmSmVwQndLOGd5bkRKK0Q5?=
 =?utf-8?B?ZG9rYzZoVXlsaTZHSFhHNHc0Y2JYWC9QbGRSSlJoRm5nVzl3MUw3V1c5SEFx?=
 =?utf-8?B?d3VqZEZCMVRIMFhLUk9vZTJ3eWlWYTNwVHFycXpHeWd3RENaOTR4d0I2R1NX?=
 =?utf-8?B?SmhoWkVnL2FDcFNhcjliVU9QS1MzMmNJV29RaXlaeFlOa0NzUVkxcVpvN3E3?=
 =?utf-8?B?MEFQTHAxL0xTUEJjeXEzdGo2MmgxSzNzTDBxQVZaUDBaWUl6Nms5OWtZc3Vr?=
 =?utf-8?B?QW12RUtuakdUekltUlMrcHdCNmtjU0llOGpHcmpVYlNhWnlPd0JnR0FncXFW?=
 =?utf-8?B?d1E1QTQ3ZnRIRUZ2OHZER1lUYk1JT28xRnR6S2JyRDBXVnphTnF0S1pWdTNk?=
 =?utf-8?B?VEszUFA1dmVQdkgwNFJ6M0lyNnViNEV2NlkzQjJXTlVRaHVxa0MxZEZWbWtI?=
 =?utf-8?B?RG92cm1XUWdRelFwMDhhOUtLMlhCb2p1bnhEOUhxQzlENnJnZUJaVTRtYUdk?=
 =?utf-8?B?MHRVc3dRVEFjZDhjc2NPN1UrbU9KUlVSeGZCc01CZDlldVNuY1VWcGQvYWRN?=
 =?utf-8?B?Vm51S3VNNUplbkNzaTdITWZ3cE92ZlhmR2JMTWtsRVRRZ3c3UmVETW5HK3Iv?=
 =?utf-8?B?WWhDUXJDN2RkL2JDbTBwb2kzcmZCaldLRGpYZ0k5RUtreUZRSHg3b0ZjQmNJ?=
 =?utf-8?B?V0FFV1h6blBHS28rc1AzanMrSWwwMEE0Y1hUMmV6QllQREFhQlNmMW9uVUdX?=
 =?utf-8?B?b3JGOXhETGMzTGVSOGM0YnJBN01HVSsvSWorMGZsdVZzWDlhNHk3eFIvd1Ft?=
 =?utf-8?B?RE10MGRrMGkwM3RoT0tGMzFMNG9VTStZN0ovSUFGb0o0UzlhWEJBYWVtR0Rk?=
 =?utf-8?B?aUF0UFh5YS9hSnhBZ1VRa3dIYTd1NGRCUHkvbFZkOFB3VG5SL3R6dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6a64f-a93c-4f28-d117-08deca074d3d
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 11:23:04.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iultKPrqLOWh/AfEG38R4BpfAytXM4P315hq3UX8apmoxvK+HYmUbRa/cEhd9Q/X6psFJ5u+lBXabs+GuPxdxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22209-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leon@kernel.org,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB748680E7F



On 6/11/2026 10:17 PM, Jason Gunthorpe wrote:
> On Thu, Jun 11, 2026 at 03:50:43PM +0300, Edward Srouji wrote:
>> @@ -664,11 +666,36 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
>>   
>>   	if (attr->qp_type == IB_QPT_RAW_PACKET ||
>>   	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
>> -		base->ubuffer.buf_size = qp->rq.wqe_cnt << qp->rq.wqe_shift;
>> -		qp->raw_packet_qp.sq.ubuffer.buf_size = qp->sq.wqe_cnt << 6;
>> +		if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
>> +				       &base->ubuffer.buf_size)) {
>> +			mlx5_ib_warn(dev, "rq buf size overflow: wqe_cnt %d wqe_shift %d\n",
>> +				     qp->rq.wqe_cnt, qp->rq.wqe_shift);
>> +			return -EINVAL;
> 
> No prints triggerable by uapi.
> 
Right, will drop them.
Note that set_user_buf_size() already has a pre-existing mlx5_ib_warn() 
prints, which is equally uapi-triggerable.
Should we clean that up in a separate patch? Should we drop such prints 
entirely? or convert them to mlx5_ib_dbg()?

> Jason


