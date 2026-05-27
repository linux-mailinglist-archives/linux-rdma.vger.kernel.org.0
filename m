Return-Path: <linux-rdma+bounces-21342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEIuAgmWFmq1ngcAu9opvQ
	(envelope-from <linux-rdma+bounces-21342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 08:58:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F415E01B0
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 08:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E3233043C29
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 06:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79BA3B585F;
	Wed, 27 May 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oVF8wvf/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F014385D9A;
	Wed, 27 May 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865073; cv=fail; b=LkQxE7O1ZHV4GDqT7bWFhblbu3cEQakQsk9/9krysV8tGhU3FRCFhNoyLSDyjUhxWSzW0PQA8BDWzM0SD3oXCF4UhDZqqDqtnpySUErOs/dJb0PuCnGF3RNgojfrOdkz0RpsA8dWPJwH3+LCXMoJvwcq/trL+Y/4HskMnCXhOjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865073; c=relaxed/simple;
	bh=6Ar3V1s9+4r1GOnWn7bKHWMcpZJClNLxb8HXvaqQC8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWwi563EKaL3ef8e8fqBBBX6VHSaB5FWTXpTU7dAs3hq/mtoFYQZ6EQoVM8ANZhsKK13JblLLJ5ErZyNe7H2fPGXqAVF2MyUp9rMRrrIXXIWN3Z5ZSzlhVP4iIT8DGe7rrlOhM15/hZYnlcrg/FqHu0wVGIdkN5bRGFDiqlbVCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oVF8wvf/; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSP5W+I62kNIDHVhTY2hUZBKBKfo3MnkVfBeesIzhkvOYWPOgXEmuDz6HtEpa4BTgKo6cRbsfydfCy7FEBsHwu//ifefsa7geG/pl49Nce3GRctBnqz3Q5D0D1zKZQI5pS1euDTIaooCsC5KWlXwndCOsHet+VnZxHNUBb4gqk7jUXTdI7IAxbsmIHLjhjDO+izbuF4JSwJXQUghQsqucrWC+mJx/eWRa7/7HLwOxU/6+YCmQXJhW7zKu8nkVoHxvFjJIOVdTSEdYC9lDi0COoHYBiV3ANJVqj0VkabU9ccH5R3T822I5ryJh1yciDvqMY9ZnDdlk410Bss7G6Fmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA0DIWgfXmRpD+ga3RuQ9nW5HwsA0CtRINH+EMwKG9E=;
 b=Sg0x21vti2TW1VuE+muJ5g657BREpA2pxB/RteQU9SagUgL+njCGlYcAsLh4wPVOw51Vrw8mcHU3AizsMnYnZPovHJ66dShYwpAPwwHu8kOVgi8IsUsayosXJSSdQzAYX7im58phr0ZVkCTGmnLFeS9Pp5UR1bZ2PMQfSLKfvIc2OBqYRvHRiOXpniHPgNREVcb9l7eBcfbU4VqZEV/hblEJ4qf8Qraj5SRMzNIuE2FAYdf/9GnqaWxaXtgQMeKZEUR0xCry5ioPUcHirHjI9TRHWoVDgbhJKRFk14KnUbzezzdWiw7gOj+FniUmzmcLc44QjSiipPwJO7BGV26f6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA0DIWgfXmRpD+ga3RuQ9nW5HwsA0CtRINH+EMwKG9E=;
 b=oVF8wvf/DG3G/dzk5FTa9B9R9JU8Y0JLcztkVOdBDBaeIWF98YYC5NOWWFZsAxm+iAKwukFO2n8PCHJZ7UcQBKElsRoKCqYZSk9kVKEtUwkDDJ+NNBIgAsulji90v8bWxjUSZ//9yji3M78ytkXaQ5Ak1EKSBoFlDv2wV77ppI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 06:57:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 06:57:48 +0000
Message-ID: <e71825f6-fd5a-4a46-b832-a207b3988071@amd.com>
Date: Wed, 27 May 2026 08:57:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] dma-buf: add optional get_tph() callback
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-3-zhipingz@meta.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526144401.1485788-3-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0648.namprd03.prod.outlook.com
 (2603:10b6:408:13b::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2914bf13-ee91-43aa-da27-08debbbd4312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|11063799006|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FbYZdoTBnkvAgOvIdnl5Zu778xKYsTC4oYcuVmkjd2AR/Jf37NZSSloQrnnJrB4K0BBQHicSMMHrBexhqIyg7/RkzHkzAtc0idvVhhgBuQ0dIKKDjqiPU7Y9zrITF/OaeuTvCstR1NXvLNlH7Y9GtMhZdrP8/rgnFR3h6xiFSGKzxU9xcxEXC5hQzMkuP2k8OcI37kzOBp/v8EUVyiU/+1XjPuX/04eZ+SxfcmJo9omhuePOD4sv0bAEaheJRSJ3bFoflGIUMZKMFHeBnh+NcHbcS/15+lr6sxElj6Gmrccs/pcEcid5Rexouj6z1K6XJl8zEYPamvcYP24ZLaL6ykF6gSGhQSNKaSUWyZFyrcsorov5HH7Nr9DlO9wSf67AttzDCqSM8mAhk6CA8GlEsm947Arg6q5W7QA4oYQwIPVQKV2jm3H5gGgosgZJi6YGnIOcCnffNotdYxdkyogZoQqTYg0iyUojBlt8Wi6LoJXPPHsQyZ6hJnb/MnyrFGOZh9FN+f5bkQpS0KcC234DsjVnqzq+ALOtOknHXUWY5DkbYVWt2DhhDOGUW0RFQtGovnPLZfbXUd9vl+66ZZ2/7BNrT7U4Y4FrgVK0TPt9RYy4Gu/ArDpSOHUUXbEdlx+OyHxP2YRrpgnuXtPwm/IxotM64vu+FYbQ/ZT35nc4CdLrVWRbC7nuP3BW6mcgIkaW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE5tWWdiK1ZDWnVpeWtvdy9zelpUc2tnT0ZTeDB3T09QVFh0Y3N0Q2phTXlY?=
 =?utf-8?B?VGZUd0xkTFJpaHhWUU9yWmxMODdOU3YrYWhCOVAwY2hNSG1uVUhIV1p5bFNp?=
 =?utf-8?B?QW9YUEVlZThRbHRYYkhlWkNVazJ4ZmdxaUNjV2N2MnVTaDVPb0NrOVoxbWR2?=
 =?utf-8?B?S21Na3BsY3hSOFE2US9rZmMvc3dkVUMwODRhYVh1cXVObjRVSkcvMFhkc284?=
 =?utf-8?B?cFNzUEJrVHpIdzBjUFluWnhtUVBtRnNJZG9pamhCSEZFbUt0TXRtUmxidzk1?=
 =?utf-8?B?WkFKUW1OUzJsR1dueC9DelFLcVZKZVRhTzA1RGI1dnl2eU4xcW1HbDgyVjJT?=
 =?utf-8?B?ZENvR0FRMlI3YkpVem41bDVsWmtXQjdiZk9hb2k1eXNoeHlPTGJ6RVRIcWxk?=
 =?utf-8?B?MVFUTzkwOWhzWWJVNzF0VFlGQ1UyUnNsY3FqMFUxNEZabUU4MkFOekNnRFFC?=
 =?utf-8?B?RUx5UU9UcGhRSnVsWVFxZlNHUXl3RS9PQjNRMjk2dDBrcFhMOHRvRGpLdnVj?=
 =?utf-8?B?a2cxQlN5allNZE9BRlFnTUdWUEc3SDdGL3dUT29DS3BmbHBYeTRNSXRjLzFH?=
 =?utf-8?B?bDlzV2thMTMyM0dGWWxvb1J4MWJEZXhrQXNsTlRzeEh2UHlLL25pTVhrMHdw?=
 =?utf-8?B?RGpMM2tyYUxUMjcyRUpwUzhIMXN6bnpyRENrT2YvWG01NHcrVy92S0ZTRFc3?=
 =?utf-8?B?cmZwU3BjQjNRaHFZVzl2OUVkS05UNlNSQXZZcGNyNVo1N0VpMHQrclB4MkhE?=
 =?utf-8?B?MmdiRXhSNmlXMXpFM1FYV3dreS9qNTlGY20yOGt6S1JObk00c1J6QnA2Z3ht?=
 =?utf-8?B?MXpnb0xKRDBBeTFEaGF6L3BTVnE0cERmNTM2ZENJZkh3ZkFzTjJ3UkZFV1dv?=
 =?utf-8?B?Z25ZSVBWaVVXZ0grclNEbTNaL1dmMloxK2FRYS82ZkZJaGU0RFRxV0ttSGFF?=
 =?utf-8?B?dkkwVzdDalViYjN4d0pGbFJxTmFGb2dsdFI3eXVzVzhyaFQrM2p5WGVFQS8w?=
 =?utf-8?B?TnhiZUpicGpGVE15VCt5U0FVZlp5aTBzUlBTWmVsc3ZORXRnQU5BaHNHVTEy?=
 =?utf-8?B?b3hyQUp0YVBTWmlFR2I1amJSYXJjTWsxRGEwMzBMd3ZBZ2h2bFZOR1BKblVp?=
 =?utf-8?B?Y2ZuWm9Kd2lFek44LzFoOUxYMGZNdXZ3R2pxUFFBMFRzUi9xc25kSnpKOFNo?=
 =?utf-8?B?ZmljcXVBRUxJaFJGQXFQZkoraitxWm9neDlNeG9zbHRBdG8vNVdReTNVOXMv?=
 =?utf-8?B?ZXhoaERwZUtTeVBObzNGS1pqRzNIWHJQeEx0dGpRajZnRXozd0ZKZm5WM0pN?=
 =?utf-8?B?YXFHNXl0ZzJLa0w5bmRrTHlURFFxbmtraW5CYVNDRmlmR3k4R2Y0bktUbXZH?=
 =?utf-8?B?NGlyRG9xUFVFNzlCYzRoUDltN3pKYTZXOXlzV25LZ1puQ0tPamliNUxRenc0?=
 =?utf-8?B?QklaeVJFODRmbDhPa2M5MURUTGU2QThZRlVtOU9qV2xSYTFVTVdYaEtldmp5?=
 =?utf-8?B?Vyt6Q2tPSHEvY0ljcktaVHdpM0dZb3JTTzNINnNpR1hFbGhMVEI0SzI2dUU1?=
 =?utf-8?B?Z2FzYnNJeXM1RmloYlA1R0VVTGxYUjNDMVpSK1I1VVBDWm1mblR4eUNTdmdG?=
 =?utf-8?B?MlpkS2RCbThnSm91RXpVZGphQmhKVnhOT3JnSk1iVU1reTVCSTZuVGo0aG5M?=
 =?utf-8?B?SWdvc1lqVVdsTzE4bVk4bGJWajlmZUltd3NieEpuWXNVUmMrNFZWNllxWG9k?=
 =?utf-8?B?c2tkaXBjUG1MZVhtd3VhRllTR3YzR3A2UHE0N1Vsc0JkR3VKSEx1UE9XSERt?=
 =?utf-8?B?S1JNTWJmcmZ0TFBweGo5K2tjcmJub04wdHVjSmh1UmkzSkRWUmZzQTk5MGYx?=
 =?utf-8?B?L2Q0ZXZXb0pOKzUrd3hUc3BOQlhrSkJmN2dqY1BwSnBSYk9XTlNpRlZ3eGxn?=
 =?utf-8?B?bndVcmVtcjB3SlZhcDJGTSt1V1JaTUc0REhQYktTa25LaHJic2FNM3RmMGxF?=
 =?utf-8?B?aU0yTkkyaHEyMFZOdUNyT3l0eFNNTit0UXBBb2RJdHk3ekZWTElSNGxYZHpB?=
 =?utf-8?B?V0poMS9EZ04vUnljU3RTbzhZbDlEVlRxZzdVRjZWby9CQUhpNEFQMGhGR2Mr?=
 =?utf-8?B?Y2k4ckc1L0xZVTZiN1A0RDFNdlR5V0FaR3hJdjRyeHJOQiszaUZub24wdnhY?=
 =?utf-8?B?K0grOGJVN1NobXJiaEl2MVdXRTM1aWpVZ1NPanpnQm43ajlhRE1leWNpUGw4?=
 =?utf-8?B?dC9oZmRnTy96RTZhQWpLMGNJMzFkc0YwdVZWVWxsVmRiZ2tOVlVEUFJZTVdF?=
 =?utf-8?Q?DlYSHa03fEyI9XQ8Se?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2914bf13-ee91-43aa-da27-08debbbd4312
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 06:57:48.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrGPwIxcCvvC1K63kGEkImAT3FamiFkMgeFu9o8hWZ/bfZMLL/mnsHwxK5+8l9fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21342-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,aka.ms:url]
X-Rspamd-Queue-Id: 95F415E01B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 16:43, Zhiping Zhang wrote:
> [Sie erhalten nicht häufig E-Mails von zhipingz@meta.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add an optional dma-buf get_tph callback so an exporter can return TPH
> (TLP Processing Hints) metadata to an importer.
> 
> 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> ST table and may both be present with different values. The importer
> passes its supported steering-tag width and the exporter returns the
> matching value, or -EOPNOTSUPP if no metadata is available for that
> width.
> 
> The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with the
> mlx5 RDMA driver as the first importer.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  include/linux/dma-buf.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index d1203da56fc5..49eb6ad644a2 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,27 @@ struct dma_buf_ops {
>          */
>         void (*unpin)(struct dma_buf_attachment *attach);
> 
> +       /**
> +        * @get_tph:
> +        * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +        * @steering_tag: Returns the raw TPH steering tag for @st_width
> +        * @ph: Returns the TPH processing hint (2-bit value)

Returned values as last arguments please.

Regards,
Christian.

> +        * @st_width: Consumer's supported steering tag width in bits (8 or 16)
> +        *
> +        * Return the TPH (TLP Processing Hints) metadata associated with this
> +        * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
> +        * Extended ST are distinct namespaces in the PCIe TPH ST table and may
> +        * both be present with different values, so the exporter must select the
> +        * value that matches @st_width and must not substitute one for the other.
> +        *
> +        * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
> +        * requested width, or -EINVAL if @st_width is not 8 or 16.
> +        *
> +        * This callback is optional.
> +        */
> +       int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> +                      u8 st_width);
> +
>         /**
>          * @map_dma_buf:
>          *
> --
> 2.53.0-Meta
> 


