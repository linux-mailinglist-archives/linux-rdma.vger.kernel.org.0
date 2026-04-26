Return-Path: <linux-rdma+bounces-19555-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBGeNyTZ7WmXoAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19555-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 11:21:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AE4693E0
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F1B1300D14E
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D031327F;
	Sun, 26 Apr 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HynIc5Em"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4721EA84;
	Sun, 26 Apr 2026 09:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195159; cv=fail; b=aWgeTNQt0CZzlR04iEajnXAvvMc0KeLITro3/jCPldmcbuudjNZTAjv5fgha8+NOW+jVT8noRWX1crGJC6pqlStqvJ+Z5lqsloX3ooGknI/TAa/fabIjgE26mTrGLNzKTAkaZ5GUBL1QNseeYkXfy1GSfUiYR+7ggt0hxtjUVWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195159; c=relaxed/simple;
	bh=vYnIzQjmDjfVO+H/0v4y7akFLlQ/WpJn0BXt0qiJH58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cd/wUNw2yLITN+zu8+uKtQMfxvp7eoeGe+7Zuj61Om0lMqU3MLF1ZL8pyFJOUXmdQnLMUH0afXRwio0ULOu7gtJNDQShcDL97QD2SrTG2ByN7vWNKw8WPRt7NFWTLuSaGsz1SgmOQIcth41/oGUgmnqhWrLFdoSIDw3LiiXyhvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HynIc5Em; arc=fail smtp.client-ip=52.101.53.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YngsKggKgLmkb5U93ZUe+PTfRZh9DoAAd28KwNKMpWR9Fezs6WbzkmEoKlfnszJCZLEYyhkIO1IaW+Ly03/DDTUWJkTj4YXUhNC28xFWlCngCN4WgW0vuHqehp82WYVDOII5L5sudqBieommN/Xj6eJjWgsuUiD2KW3b59BDCTa0GrrbQvYePkFIhlqNmASGgIL0oKBKfQP0kmqc0j570eLg8PkUOMOhruV0l0y5qsTvDQGmmCoKUy+sCuBjk0YLX+x9J3NTLnK/rAE3i1WGYuo1rdmxlxqbmeX1WmQOaH7ZdIwIOFbsmsLmpB0W+VAm8UMAYAqjdVF8lHvhyvfa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn9OeBu6n07GN/I7KrNJeQLHTCvlMyyqghMEQO9tQv4=;
 b=YhO3RaCDOaZhtr9qukjfiK/Xk9gdeIsNOVL+gv31DeoJ5XzRIWqyV02ZmDvHaMzXGk6/V9ChGbHByhDcqpCiTYnliIeqRsLMWz7e+E7CiVG8XdS9ifL3szZWQqpERNqioTRb2IlxTvWmC6xqfQOGd6TWsRtuFAbbmg0ReuK/TLuHpzm0ybwKRU8CjxPMSvooFdj8qd37yNQ6FoaTmQxzHYe+2nmDcUHDMUE7eZCO8USnkDhHVdx2C2oKlnRx10ItE0wmmmLTPXRM4Da9hIu7wa8b6QujeWVlc3uyZhlP1ql+Xv025uDLrs/oNzVcLuq5MvFP2RVu+Rc8byNeJpXS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn9OeBu6n07GN/I7KrNJeQLHTCvlMyyqghMEQO9tQv4=;
 b=HynIc5Em4h0ogrM02ggIFfV/sNBTccFxJPNB0qmTCSF0ZvzL86IRYK5Qt68Cg9d7qGaWEHJ1zyWkeScPLjfukP0WrgwPvtjvKC/NiQv3rST6jGH3OEQjcQkvFu1+skNNZQo5fx2Apy81y3v7Zc9CteK8ddWEJDa/uNbn0WGTMMPQETQGZm8yZsrvWedJXm+cthDRijj6p2XyaZf0E6fYQTQZQC/LAOxBzHdgYlBjRbPWWuzNfv4Z8QLwlBjgWhd7nzUawjS+EEbrvQVRpm6/9ZVl06HzTr2shjuedC+ls7MhS8dk/GycWUCAostKLwWErJip9w7S8nnn3Dqd+hHJVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.12; Sun, 26 Apr
 2026 09:19:13 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%4]) with mapi id 15.20.9870.012; Sun, 26 Apr 2026
 09:19:13 +0000
Message-ID: <77145fd5-25be-4791-973e-b9e111589763@nvidia.com>
Date: Sun, 26 Apr 2026 12:19:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma v1] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate
 failure
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>, jgg@ziepe.ca,
 leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260425011739.21557-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260425011739.21557-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e859213-956c-4984-f051-08dea374e1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	99zdDb3Zd1qt0c0vdDbAIoYic4JhwU+o5I9v7uMgm0nmEbXTBH2cVAWlJMvXTFyTTpD86+oNswuWLDRR9PMl7v4ekciRzB5fhTAK5SgwfRL/0nATllqk9DMnDLgOwzeXJ9UIeoeI6iLlfI7Jty+I8BnDWZM5lWDzmGqVSP8fTE6SL33uyK8zG2x+geS+12I0lLb6eSlsFIPEJy/ym72+48oaFmZUdHURY+DEqOPGN5Uhey1uK3qVm8lsQCG89rDjKEpdJxoreoKs3qz9KqNToKEg0crEGK6fmLUwZd6DAjLKkXfSfsGCnH18rTtJqi9fuiClX20lElWJu5kKV1XR0vroa/aRBdwBpy5NS10HfHeaXT+OPvVY3uWbzb1s+GkGDndxo7XiINLmBkx0VHUHjBLiMl9C8gwrpBng97xPAsAbIu7OCK8D/fP06GjmMz3LYnTSO3dqH1Vwt0ARhPYuBNekAQ8lMHMS5rMdK1WKwmFzrpZ2j3f8YLfcVhZ4SRG3PmA2aZxsw+sav04E/alTqoVikuxDZBPL/KIq6kZt/4aeFqi7Duljevxt/g+Tc3DgEl09iaYwKoLnpAFOVTl6HLFssA1UpbsNra348ORn2qrmskNXJ7ci9W2lEjU55hsRxqRYJytgcylgn387MsmXsUwmvss8e8kNrvjzs8+qubZv/6iMaUUZFY14noGqm0xP1u/siamGn1WgSM+BjkFgAUcI17qsuWyD3p/4bzthUWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NitJelRiUEgxTnowNmpsYVRvbmpMZmI4djkrdnZERnlmQjkxa3F5WVdtcEE3?=
 =?utf-8?B?a2w1NEJuUXNrUnY4UGhTSmRIR2ZkVWh5T21TckpHM1dNY3lNbW1HWUgrL2g5?=
 =?utf-8?B?bFFBZHBQVmVwODRzZGFNanVSQUJxMkJGNEQ5dTA2c2RiSEFRYlVpNDZ0UjdJ?=
 =?utf-8?B?N0YrNFd6TkdOa3ZBTHpPN1Rjb0NuSTdPMXBhNk5FeUFFMnZ3TEV5Vkg4Z1FR?=
 =?utf-8?B?WjZ2SGRsaVJmbG1zaHNFQzVJdndhRlRNKzVwUjBpOUNpdmd4amd1TXFJR2pD?=
 =?utf-8?B?L3ZwNEtLeGd2S3dkWmgvbXNncEhBZkUwaGFhTFNEbmFKUlhpKzVOSnhoVWh5?=
 =?utf-8?B?YnljQXkxdEFZd3VsVUhTTDdjT00vbWhaRXNSRWZzbEk1OG9iOEdGempKajB4?=
 =?utf-8?B?ZnR4dUxYTTkwV1QzZnlnWFZ6RHI5RjFBTDRTYzErUnhpNU52K0RyUDNYR051?=
 =?utf-8?B?MG5wUUxoQ3RwbHY5aVVoTTRMaHd5TXEzdVdUUmw0Mk95cUU4SElJa1pkWVRT?=
 =?utf-8?B?Sm1wUWd0enhVSnc0MlUzRWVqdTVKTWljTE5VUURYc0w5RDd4bzlQbFhQRytw?=
 =?utf-8?B?VjhiTDBTcERLcmJLYTl4bWt6SHVFL2xPbnRMNFkyazlVWCtmK1VFVmJvdWZB?=
 =?utf-8?B?dkl3djZ0aUVvRnltSFNnenlFakhxU0llWDg3VHAwbTU5WDVlTmxKSVlSMmc1?=
 =?utf-8?B?OXFubnhkYXNlODU3N1Btdk4zWkV1WjR6Qml5d1ZFTm1HNnI4RGlXbXhubTZn?=
 =?utf-8?B?elpzU1VsVk5DTU11YzY1c2NBV2ZreHJrL2ExOEM0dVp6ZzdXR0ZudWkyMWpM?=
 =?utf-8?B?ZlJCcUNCclV1M0VnK0xGY2ZkS2lTVlFveHM2Ukg4ZFBKUnovOG9sclpBWnhQ?=
 =?utf-8?B?b0NkWDFXdzdxcHBqTlhubHhjZzR5WlNleklVc1RXZmJ0OGczdVJia2M1Q3lz?=
 =?utf-8?B?VkpUczdMWWFLS05DT2VqYWp5YmVrVDAwRm5WbEdpUmtRaEhEYnExN1ZDem1q?=
 =?utf-8?B?Z1ljUXVwTUFEVW5XNFM2WDdYVi8wTkp3TUtXWlR4bzEzSjZ4RGJIUVlpOHJZ?=
 =?utf-8?B?T2NCclFubCtOT0dWOEowYUZBSUU5Wjl0emw4NTB6MHRpNlhlelBEZGszK2tF?=
 =?utf-8?B?YjhGOHdjWjBNenRWTjVJejZ6cmRhbVljY0xGNVQvSjduaWZsOHdIdzY3bWox?=
 =?utf-8?B?TU8rMDB1Rzd6YWlteExnd2M3NnR3R3F3NytmWnB4VjFZYWRqTHJuWFpORjF3?=
 =?utf-8?B?VjgrWVNrbitXaUFBMWdKOEJSakRTSkgzQ3RVT2Rub0RjZFJGa2FpeTNnbHU1?=
 =?utf-8?B?Q09MbkkvcTBodUZkVDVPWDNIWElObUI0TUdSSzlXRGxUV3BIQ3ZIbW40dDhM?=
 =?utf-8?B?ajdvcGoxbFcwemxiUWxmaU5SQ1lhYzQrWlFVM2dZSmh2VmwweTJTSTErVENl?=
 =?utf-8?B?VWxXU1EyOTJ4Ymtsb0JhQ1dCazVLRUlsRUxHVTlra0NERjRHcW54L1hDNkdU?=
 =?utf-8?B?SHgwVG50d1RJWFN5eUhjU3lQNmYyTGhKWEZpRi82Z2hmQUR3R2pxTFZoODV0?=
 =?utf-8?B?em5VMXBobzg2OERmM0pYNUdIWXBYUlNxcnBwdy9yK1FBVkxWK2RoRXMybmlO?=
 =?utf-8?B?TTdRSG4rdEpYZHhGU0NWWlpxWW1CSnR0cVhDMUlTdVlTY3B2OFhPY2QvbE9a?=
 =?utf-8?B?TCs1T0d6U2pRN2tsd3lSV3cxcEZJMzFYeDQ4K2dKMXhIelN0TzhpV1dUTzNx?=
 =?utf-8?B?YUt6VUJuMnV0WVpOYWtFYkxSRTNyZEhwVXJ3WnZkUFdsZnNNaVdkRThJdGQz?=
 =?utf-8?B?TWtiWEl3MTMzWTdFY2o5WmFqcTJtSm5JUXFRM1NPSHpTZVVMcHBpVWFXR3lQ?=
 =?utf-8?B?eFRsMU91YjFxSzFyY2NLb0RYM092OWd4SThpdFJYQm9uTkNOUUdkRkg3cXNK?=
 =?utf-8?B?WXY2VnlUL0VhRjBrQW43R0FhQnl6Skl4czJPUTl1TXFPTnFPKzlMMlZXNWR6?=
 =?utf-8?B?STAvUXVUODBWNTBCNXVPVzlkZE9DVS9CRjdrQXRiNlN1ZDdQaHpQYWtMUnly?=
 =?utf-8?B?emVqa29NdmgvcTNlVXR2Y0NTeEhLN2Q2bk5ISnNtdUw3MTJEWUtWZEdPSEc3?=
 =?utf-8?B?VkIxWHVFMU5pNXFYTVhyTDFJajRneFllMk42dzJvOVk5b3J1LzN2dFFZS0JF?=
 =?utf-8?B?Y000K1RLckhzNklkMjRkNG50SDNVTm1sRlVPWjBqNFltS2ZDZ2dVY2R0S3BO?=
 =?utf-8?B?NUJILyticm91ZFJoZTdNUEZrcVdqekh3djRJczdWaEcrR3lTdnAra29xVS8w?=
 =?utf-8?B?b3Rxa0lLZXJMQ2xsSjlwRUw3MVMvaTZjVkhMWWFaSE4zRVluVU90UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e859213-956c-4984-f051-08dea374e1d8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 09:19:13.6019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiUkuEtiOMvXgxN4vy35VGPPDY3Qr7ZOTaBPqsl5+DPITZClKgqSofXDDAuSF7YoWzETLGfd90TV9VZeugcAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Rspamd-Queue-Id: 602AE4693E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19555-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]


On 4/25/2026 4:17 AM, Prathamesh Deshpande wrote:
> mlx5r_umr_update_xlt() allocates and DMA maps an XLT buffer with
> mlx5r_umr_create_xlt(). The buffer is released by the common cleanup path
> through mlx5r_umr_unmap_free_xlt().
>
> After mlx5_odp_populate_xlt() became fallible, its error path returned
> directly and skipped that cleanup. This leaks the XLT DMA mapping and
> buffer. If the emergency XLT page was used, it also leaves
> xlt_emergency_page_mutex locked.
>
> Jump to the existing cleanup path instead of returning directly.
>
> Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/infiniband/hw/mlx5/umr.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
> index 29488fba21a0..14ed8e8182f8 100644
> --- a/drivers/infiniband/hw/mlx5/umr.c
> +++ b/drivers/infiniband/hw/mlx5/umr.c
> @@ -915,7 +915,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
>   		 */
>   		err = mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
>   		if (err)
> -			return err;
> +			goto out;

The loop already checks !err in its condition, so a 'break' is 
sufficient here to avoid adding a new label.

Thanks

>   		dma_sync_single_for_device(ddev, sg.addr, sg.length,
>   					   DMA_TO_DEVICE);
>   		sg.length = ALIGN(size_to_map, MLX5_UMR_FLEX_ALIGNMENT);
> @@ -925,6 +925,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
>   		mlx5r_umr_update_offset(&wqe.ctrl_seg, idx * desc_size);
>   		err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, true);
>   	}
> +out:
>   	sg.length = orig_sg_length;
>   	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
>   	return err;

