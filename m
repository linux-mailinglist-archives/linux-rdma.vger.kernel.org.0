Return-Path: <linux-rdma+bounces-18998-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOevBJyf0mkPZQcAu9opvQ
	(envelope-from <linux-rdma+bounces-18998-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 19:45:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 758BD39F3E5
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFF183006500
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75F2D8DD6;
	Sun,  5 Apr 2026 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MStBipqt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010043.outbound.protection.outlook.com [52.101.61.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B6E1AB6F1;
	Sun,  5 Apr 2026 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775411096; cv=fail; b=AZtO/XU/nRfiIpBlvJ1NPi4ITAzvUIX3pzzkStxuT8OL9njMWl43fQlx/iEgONiRfZQtKfxSHtavNr3e7/UfGl3R2v6tJsHMGF8O31T7T4g53UVh24M2pG9T7e6NChmhATek+820wdINbkkTmsczwa7p8hZzVFRZNcXtWcLiKhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775411096; c=relaxed/simple;
	bh=Ukywa8DPfDj81yTaEj8i3J0SB4VkI/LFLvc5FOl/vC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSytMeD1iNwRZyVKlp0esDyc1VB1omETyIBeKgc54nfD1qcGQop/TqqxfIH1QaJ6EA72yhab6pQpu5mxt23ABVRTIc7jAmAYrMFkw2RNShDNyVLxT7F1F/6ysHKhn7G3JKt+SoKjSzXnTZ+QzKL8ldSj6r6zBSk1ACa6KTYjK14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MStBipqt; arc=fail smtp.client-ip=52.101.61.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uj8BNy6N3EQJUa0CWCO+ptS14IkDAPYmCft4WENiI6VuPVnTyd5ddlU2Vd36cymEmCYUJYyvAcRedQ6WddQkZ4ldhPJZ83wwb89FbISAOdFYpIp8fdQqisWSQnJQk173CkAu3FZ1mLZn+/IwMgC6669lJYsZ58K9M3OlmukWW18esRFjy9g7Id3MpFN28dxe6Ie2FT57oSJp+ya2pC/35Kg6Wf+qjq4f/iPuXPnJX0mNK+xUhyrhnFa0TsCG8mQrem+MVD7sxEhbC0Zfe2u0PwVIpG/iZq+6dWPJ5KdTrtKYZtd+aVWCDhcKHkXnJQMfeWui2tuT/bIftMQicpdGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha/DO0g0oOoZHWiN3qT8l5qzgZWOqPeyGBuvZnojLyU=;
 b=UvyhqxdlL2IauzRx65Ib3JuxIdAkITtp/gHEYk+jd4oqvi+VZFvkHH6PC00y3LilLzwQo1N59awJ10UO6w+5e/r7WhMarbXuOGtQwL1zxm8tsOUt49d7veVKWlz45wZgYPaX0HU06xahFew7OVZEzf7gOvKLcDKnFayr52BK7b3Q0n7Y1QAs/I6c4ipMAz5DwyngvsktZ+0VOA0UpQIo1IQzr6msi1G2bcF1UbdFvASEmrfKcU//Gdmkrd84P5tA8Q0CDh51e19R5cRCwi+sKTkHbind2j+XSjAnpxqPIhLltoen9ahFAALqkt5+aMF7cCqyrp3dX/3UWf6O4gqzTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha/DO0g0oOoZHWiN3qT8l5qzgZWOqPeyGBuvZnojLyU=;
 b=MStBipqt0Rgvs/MiAdkUJu+5F8RTgmElW4Kbt4dz7pblbyieDlzeRM584C9x8gaXB918LgSaqaXNqS6s2nRAEO/1Jjtvd99HZte9SSUibTo4FTlLgmT7JEwHv9daFiX0W8lji7aqaBGx6bGDSQLGDMus5wLo1FRPyR8FhIx36RUpYwLTp5AUtflyhAVGs05PQ53jkXI16OCT0B6BGn9gaQ1RFDmiaEoAnpmbBoi1FLHBFa4Ac2O7xxYj4qhWLQo2fQgqRIKYBTye5ISgU1KAFC6LkNb3mhGplrr7dmDYS0lZih3W0r7g1e/FP6ZUwImj6Q4V7U6+WCWbQs8OI8x7Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 17:44:51 +0000
Received: from SN7PR12MB7023.namprd12.prod.outlook.com
 ([fe80::e329:4fcc:313d:2e3e]) by SN7PR12MB7023.namprd12.prod.outlook.com
 ([fe80::e329:4fcc:313d:2e3e%5]) with mapi id 15.20.9769.017; Sun, 5 Apr 2026
 17:44:50 +0000
Message-ID: <e2b4dd83-a331-4b37-867d-c5ef8e86dd72@nvidia.com>
Date: Sun, 5 Apr 2026 20:44:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
To: David Ahern <dsahern@gmail.com>, leon@kernel.org,
 stephen@networkplumber.org
Cc: michaelgur@nvidia.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
 <a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <a441f862-1ebe-4fd9-9ef5-aac718fb008c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::10) To SN7PR12MB7023.namprd12.prod.outlook.com
 (2603:10b6:806:260::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7023:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: c70aeb53-9413-46e6-6c31-08de933b09a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LySHza+evTSvM0QqUhUGTriTaK4D/4ll90EQgJfUN1BhigHQK7+efeEGZf9pbGmBRpt3Zmp0LG2XPRmNHISxrmpj3bc6myeGsyBl39SF9BGpJMh2mWSrzIMUfhPHN6SiiWpR68OecSJoa0Q9ydykuzINrK4oY5Fl9LUBITFiIWzzE8Mtrbq1IOBn2gd7GnMuTtipdPgDqi8PR+tZIxBXqt8Rs6MTaG8Q6exeFZG7PjNtN6oOShhd/WaV3MED0pNYEL4A/S97ybG6NWNVDP4HFFcV2BKDJvwlItH6cD1rGamA0to56g9r6OOXGhaHK/Te3qD5nNC6V3DJaJoBnBrnISZLY+rLMwvatWQoWNgc50pdfeb+Pmhf9x3gWjv6zmsyGLf8omxQEQA5vCbRkqYgdWmJ1sHWylqSard0um2mave6uGZnR3VnWG94NqVwt7Kg7+g97IiICIzH7W7aeJJBGXPG5uTIgWJ2AFdHg76ZJgNojUY8ECVTYr3mFzzF9Ktqkb5iE6om7Iiw/Rf+MEHRu2hlZcwuTEe5p9AT0ADJZtYcwnF/tX5KIbk7ArQWWMLDuKNUiixuzOnbgm1FqIX2PSXAHp6VVRjClTZkXSu8HOiKzLgKSyolekn1zT9D1eqcFVsAVHmDm3yrtpvyprn/xgJwVxuZL8AzmPUQxz5Nz3TTG+i2FPL3wEq0XzT2EzbjNbfKNxrQpa7oOUGaUA1nfeqeqhzlhzckbci9F2S8kTQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7023.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDhIalFObHlJaklXaXRlMC9FNmVTakI3Z1FsR0FZRjROVG9CK3lzdlRuTGo5?=
 =?utf-8?B?THB6ZWxUMHN6bks2VkVaeGNvY0U1NGp2WUNUK2VOdjdJdUNhWldINEc0ckFt?=
 =?utf-8?B?RXdDYVQwVEhyQVBOdCs0TFlPSVZ1N0RYU3ZZQk5qd2lDVFNqamUydWlnenZX?=
 =?utf-8?B?S3NjZGMxTUw2RFZnR1JSTml5V2pOcE1uM0V6VkVyYmxSeVFveHR1eTVPdlpU?=
 =?utf-8?B?cTk2Qm1yaGRxbjc4NmNLbU05Zkt6ZFVadFo0UGF2bW5ZeVBJR1N0MGF1TkhI?=
 =?utf-8?B?V3Q4SkZxRDhwWW9NUUlhMkNYSmZsMXVrQnVtWTVrZUZaQllkK0tqSmU5N0tM?=
 =?utf-8?B?T2d4MUlqMVBWdXlrNGlRZGtGZ2FST3N3dnQrSElpeGJpTDBhQmd6MUxPbDF5?=
 =?utf-8?B?c0ZGYzBnNmh1MEhxeXRzelp0Z3pKT2tXK25aQVAxaldXTUNvVWhIM1JMcnM1?=
 =?utf-8?B?OXBnMS9mS2t2NkVLbGRxV2pjb3hVa1hGOXhmU3lLQTdFU2NmZFFNcmJESFUx?=
 =?utf-8?B?dWVnN1E0cmhIbW5ObGlndHp3NDJtT1lNdUVVeWk2YlFBbHJRSkxaa05TL0Rz?=
 =?utf-8?B?bmx3bVRuYU1oZDVIbisyNDhpN0FDZUJkQzRsNy9PUWdscVlrV0pPaFZubEpv?=
 =?utf-8?B?b3dMUW5UR3djZXR4MHMrSTBqa29USTNxRU05ZGdtTXE5UWNCZGdRb1VqSWNG?=
 =?utf-8?B?cW1ETlhIbGRybUpDcXNLTHIvQUJubkFNc0Z3OGZSUGtjeFF2QnM5SWQveDRC?=
 =?utf-8?B?MzFBSU9UdUk5M3NlWGdQc3NxYTAwTkdnSWI0d1hqK2VWMjZMU3ZUNGZjOEor?=
 =?utf-8?B?cHo4TkI0OFNGNkVGYUp1RDNGekh0YVh3YW9ZQ3ZPTjEyL0JQbFhyMG45RXNs?=
 =?utf-8?B?WE8yakh6MklOT1VUK1Q1RGxMdWlEbksvNmVoWU40bzJpTlo4cVVOUTRzai9S?=
 =?utf-8?B?cENYUFhlcXZnTk9xQzEzRkErRTRmcUQ3eTRudjN3UG1Gb0pjSmtQa0cvTE9m?=
 =?utf-8?B?Rlhkazd4OEhJaHhsSms0a2NPMGRPT1FHS1RVR0srMTBpWkkxbG9xenkwQU9p?=
 =?utf-8?B?WXhHOHF1RkI4SkJTYXg3cGUwZlVJOEZFOVNBK09hVWJEdmx1bksrMnJvUjJQ?=
 =?utf-8?B?K1Z4a3N6Uk5uNUZhaC9xODhOTUhLRTJkOUtzclB2Q0llNXVLbTl4YlQ1Ukpt?=
 =?utf-8?B?bUJXQTVMeDJQYm04NWFlQWgxUkFFOVhMZC9GM0JJQ3I4MG9TdHVvTVM4Rndk?=
 =?utf-8?B?c01UcGVmakxJN1VvRkRtZm9Xb1ZUOFg5QVB1bHFuNnZDK05jSEJGdGVQWXpi?=
 =?utf-8?B?TXdrSUhpRk1yTHViWkZZZlFCY1dZSkI3Q014QjUvTWxVRTQ2bHBPdEpobWpm?=
 =?utf-8?B?cUtIZ3FUY29BUi9mYXRZMEd4ME5nT2FQU1IyZkcvbmYvVWI2NS9MK2FvZVRH?=
 =?utf-8?B?dkoxL0p1OXVSZ3lBTHFhNkYrYjd1UkxlMnVqS2pwb3dOZ25uQS94RUViWHl6?=
 =?utf-8?B?M1J5ODU2elNyc2tqTmlscHFKOEVJZmZEYTdJaUE0UDQ4ejlUOU41OUZSc2VY?=
 =?utf-8?B?ZUtGbU1CZCtjVkZZdjkrVFhvMkQxdDV5eWJGV1JTai8rR3BMbzNvTTBRaDBj?=
 =?utf-8?B?WEFSS1FRWXVFWW45SjdkUGxqU1NGUndSYlBHRHIzaDVLSHJiR293dm5LRG5r?=
 =?utf-8?B?TGY1a3dKRUpUcHNRLzlIdmF1aTRFZ2hVb05IVkdqMloxcjFpZkpKYTh4cWpX?=
 =?utf-8?B?Q216S3VOQXV0bTlIRkdreFNBT0U4clBwbEZmbXFQaFZUU1oxMmJsbkw5cVph?=
 =?utf-8?B?RVlVOUVkOEgraEZhWVZIaHJRNzJMdm43dUh1ak9tUU1qbFZ4NWU0SlNwVVRv?=
 =?utf-8?B?N0V2TURXRVdiZEtHWFExUDZlenlDZGZLZ3M1WW01QUdtd3BlUEdEVUVhZVMw?=
 =?utf-8?B?bld0T25iSW9qUWU1bHM2YnZ5S2RNaVhaamQyM3pyVS94d0JLZ3hjZXhRQWd4?=
 =?utf-8?B?S2pEcWRHb01BdGRJczVJY1ZTQ1F1bTQyc0p5ZW1SeG1IV3EvQ2h0Q2R2clor?=
 =?utf-8?B?b05md3ByWGg0ZURGN1cvTjVySU5SZC9GTElSMy94bC90MlpqOGVHelp5Tjdw?=
 =?utf-8?B?d0ZpbzhJZFZ2ZGM1NzNIdm56blFhWnBxOUwxTUpuNU9kSTBrQ1RESDYycS9o?=
 =?utf-8?B?V2VFZ3NMbC9wTk5LcE1CVEcybFFVcmxyY1RXV2l5N3pzbFFjanJkZTNNMWFt?=
 =?utf-8?B?bzhSWDNXclR0dm85aUFLdzJOSGplNnk4Tm5vb2NSa1JwbFJzb3d1V3BIRVVJ?=
 =?utf-8?B?dnYraStrQU80TENnN1Y0SGFmOTh4UXA4Qkw4azBpcjZ3UVRIdXJTdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70aeb53-9413-46e6-6c31-08de933b09a0
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7023.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 17:44:50.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVwBD6qvlUsN7j1ZSLh49MB0Kq5fXUTB0WQEhzMWZlktE74/zhllIK2CPMd+O60vANzsga46SDg+PfO581T9jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18998-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,networkplumber.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 758BD39F3E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/04/2026 20:09, David Ahern wrote:
> applied after fixing up a few nits.
>
> Please clone the ai review prompts from:
>   https://github.com/masoncl/review-prompts.git
>
> Run the setup scripts and have ai review patches before sending. This
> should really be part of both kernel and iproute2 development workflow now.

Thanks for the note. Sorry I missed that — I’ll run those review prompts before
sending the next patchset.

Chiara


