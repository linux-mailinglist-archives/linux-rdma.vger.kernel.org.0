Return-Path: <linux-rdma+bounces-22026-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zJ8GRxkKGrEDAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22026-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB0663841
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=hhJRCCQJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22026-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22026-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 826F23024108
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C6047F2EC;
	Tue,  9 Jun 2026 19:00:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B64C955E
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jun 2026 19:00:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031634; cv=fail; b=sT5Pk6p30h7b60vT++zLEAWeLg0UZGjY9ghuzDop8eijQjU4yt3Pgdfnj+sND2bl7lCIouRlvVy0Ez21VbSMsK2jDfVl1FvDCopROdKSzv68eGndQ/wpESiVu+rNYQuLXiMj5EHpzmjcmO/yea4CJQ9rTmFsgKGASHfysEx+i9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031634; c=relaxed/simple;
	bh=PPmLSR0U3m8+S1BqKbNlELoDsWoiz7jwnQMJGSKgth8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FSMKT2kVzY1TKiP188Oc5R8T7oXR2scU7bFiuLB3wpZkemHn7P1B5Uu9vWQOMQ3YAQHaAzfOnHIhZlyjbFzG3cTpVTYQJKDKhF+QtsA0PYhcyBE9motU4oEgWOERbhtxJ8CmwaYrLz/HFHBTqV9SSyaHD5vR3WZ4lDjEYTicEGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hhJRCCQJ; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgMTzCrBy8kJMIoGtIFgz/5ysdBVKR4/SRMf4fuXRNq16GUz7Yh1K+xtL1F0m7erjDrMr7WeY5nhsJfHWmvbOBLQGKVrz2oMq0Bl2qu6CmQOoyYSdNdZ2RzA92csNot9mOzqxhYHjE6QdA0pU5whZ6/9qece56lOoimrmOskjBNZNl/CozYV/L19WtekgHmqeF98VofW9KJGEMv3b9CvWWObs/pqoXSK7jysZVAc+MS9mK4MLbghGTbriihsDqbVuyxvA8kTFz3gQdBUv/Iij4yvpuHBL1qiDZzlohz6I0LwLjW3S56ac1F4X9DDqkPmQ+gQdjmIs9wVEDZl82AR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FCJJgLvPAtloO90lGGSTI9Cv4SUPBoGGEJ6o2nLxiY=;
 b=MiiSBpMC4MCLDKdqWrcSvNFY8+i4rQSMTpIFGnpKNxC/rOtNg+acU5kqhHSXBN+NuqslKnb4Un1xAqjsTi17+T6pZ5y46rLULBNRZkncTaLfSxQXVMkYPncleM8QYmSlEf+LGTyciuQLz2aaip84ifPeSBFn4dGDdsSWv/LsHg331M+jzmVyv3L0WpCBaoVXPwMjgO9L+pwT5obx8+i9ycAMUCVqYOUgTPmPGvMOTcxGzQgqkzbQPVIEmT4MG2Ofkqy08P9/pPCy0L2bZXW4N9l30CB1+k8GTOT63HDWPivWkrdjpXbXxIpdZYpLx+Ur0163M0cCytiL+CvyFhsUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FCJJgLvPAtloO90lGGSTI9Cv4SUPBoGGEJ6o2nLxiY=;
 b=hhJRCCQJ3IqGT3otHFndSxbofzhXPgRCsbr3YcPZhnDu0mmMvxRqCIsIHrC4Et2Bb2Nmb38vA0yzuGwIh5pcQ380dSrWqrU5OrfVZWc/OkbFfxpbQI6pqU6sCEXOQCxaEul7milAqy+EY+gNPAZ7DNrXbtcJ2GEJdPLvdic9X5b8jTDOYHSrhCGsbS+KvHlAVqFhq+oASh/7zBU8cIwjyGtG1l1NvG9HGuny88UfS5yWJxBNNL6XCndNG6TdFh3j5zQ2lgRZTLPpmBTlYyS3fa9Y/wj6SeWC95fdxQSXUk5xIVYTL/2R6I1bgCKvSI4bo4TfOaMj45k+Lg/tuVOpbg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 19:00:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:00:22 +0000
Date: Tue, 9 Jun 2026 16:00:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>
Cc: Matan Barak <matanb@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
	patches@lists.linux.dev, Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH] IB/mlx4: Fill in the access_flags if IB_MR_REREG_ACCESS
 is not specified
Message-ID: <20260609190021.GA584729@nvidia.com>
References: <0-v1-29ca7a402625+ddd6-mlx4_rereg_flags_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-29ca7a402625+ddd6-mlx4_rereg_flags_jgg@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 006c262c-16d6-44a6-54f7-08dec6595b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CdYoFS1u2oTgy4NvkkHxebmPafds1QQPVUwlKiQyx2fNwvVwtLJgz6yJmnqy4QX7gCBLskaA3J8U9FN7tLCiNFPdRwUkQczvWrv8SyxfuHpZLHkWiqhsy0cHc6ZE7auTh5prODVq5Lz4IhnykApXR4eeP7z5MWvD3huWUYBKa0mqhzrzdBQnsbxj8qMxq/2bB7InlIMM/M9LfJggD98EDkgr9j9B3K43k+9OUdGWPC8z7RjS7BLFjVXWZrYCUQDSmb36xOBA13ZaerMMpYDRRC/bdp8yXsXu2DiuGAvOPNDc8khg3kSfM8optlGCN3jm93EbghJ14TT9BQqcXUdBDdA20znVwJVGtqzfWr8+kQzklzx2zav5HXM3hCmKah8EPjl6OVO3Q/AS7Xc/4624VoYur7KVtGcC1q/oUbMWLRapXTd66Q2yu/V+v2yVCLxFkomd5mo/IHml5SPutVbdlhCiOaORUbjL39gUDSkFGTZc9hTA8AF3pv6X98iDALEqjTDWa9Enc/hzMM78HY0XJub62Joikdt9p9PxwiOuRVxfpIfoXMdcJHRLebncJh/vFv13xGho39QMTRDCHgZaqmRSAIxKBSSVLswuVH3LdFeJAzh1RvuN6wGp7xOwZhfXu9xxuwATBC6AxjQKMNz2ckkKMrAZ1/hhQpSS6hWD2OLdSmF2zjT410cJhVjdQbId
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OE1TRwBWUS4milMPp6vvqKJy1N8AUth5w8fFowPJ66FS2y9gjZvX+sh4ZCB?=
 =?us-ascii?Q?g6FEHSLybfU/t/MsiLGR+h2GDQD9hH5SA3tGX94a6QhSQiGbwlrk0Ait8KXb?=
 =?us-ascii?Q?apYRkpxC7UzHoB+S/6wDFpisPnlfu+Q8PP21D7mtvSAyV1b3NIa8pvSNOG7r?=
 =?us-ascii?Q?fjGEpaBk0xabObQeRm8OKKJLa5f2RinkGcJVK2fMBfZHQ13SvCGZ4w4T99+B?=
 =?us-ascii?Q?F2Oj9CIAkCLFu2hgR0kwGjFCvULBjEFfnHrPHIzhM4SHHITGqPpu8etjlkRa?=
 =?us-ascii?Q?I+oxFUUHoIxzTetpjhTqjIlV348dx0fr2Sp7ipFf+lBIshoNWj0/yABQ/Z+L?=
 =?us-ascii?Q?eoO0+NUPgvYuZdKoaHYvo83oHweRsfGpRyiPg0+NvewG8FaptkIXf3g6MwLp?=
 =?us-ascii?Q?QTfj5dzfDRL5QcJ7NG8wzgNAOBXt3nDalNvVIMDETxmdhBDONgBX+A+AWkKt?=
 =?us-ascii?Q?l1aTfj7HJyv48wDcLJ+mA12ZGVQhSR/Ag/3p4qLdpWJvlNOoS2eK7H61GF/G?=
 =?us-ascii?Q?7hsB1eAHRNrjOrxVycuCKj7zo9/YER0xK02gBb/jL8LSyX56PR+9OFs2XvNu?=
 =?us-ascii?Q?uYypiX4vKGx11yhwafTqDQ4nRNYRR1Qhdxnz3hB8RdzxH6Dj7XJxt3mlKZb5?=
 =?us-ascii?Q?CTD9SKvwLOekix/GxoO7grTvylWJsi3JmnPba1EbBOJ7iP1+aIBiUOGH57HE?=
 =?us-ascii?Q?dTKbv+0OWZrsFaqp0WEEFRxZZFf+KwUnBW8JKz+wQOKNO7h8RTnMTShjppCg?=
 =?us-ascii?Q?+Cq93I2M/up6upIPtNShTh5vZNBP5gMDl4ZYXqQwEgx3HDSOIXpq9sd33Lh2?=
 =?us-ascii?Q?Ztd9KqrGcLxtuReRe6cZ8tWlUVF1XpB0v8WQ3YbTDGg/GaEeyshiisAdlebQ?=
 =?us-ascii?Q?AGRQX+gKsUruD8ZsVRD1j0c67/vy0RErJqDXjLRSDqknKBzwk7zudqf0X+OT?=
 =?us-ascii?Q?9voTX91vdGlzjDy82DCQTw311gwclEpgHHgtWHXjrFlJyWmP44R7moBtbKp7?=
 =?us-ascii?Q?NDiQQEPTnWXp+1Wc3H8p8jE2G/PgudSFFPTBOgYm51HcQGruaokR+XDpBtB5?=
 =?us-ascii?Q?thTbZ6VLBZbeBcVei/BW5rAsvKKmCAFCkpP/3XgjO0N5elGVYAmhDTH9j2F0?=
 =?us-ascii?Q?9SjpaCS4y+y4hXsDn8pBVTcf85gd4R7jPIo1DNkOYzGaTLuGWRtVoTpQ8DSi?=
 =?us-ascii?Q?sz6eJh//Quk/Zdl1Z1Yq95p+sOTlYa80JlQC0Vf0wceoB+3W9gNX2KRUfNrZ?=
 =?us-ascii?Q?PahK4vRagJVWg14rWjngiJKRiYkf5XovRDlwxIAGZx2sj0MaRFqm9Xk9F03M?=
 =?us-ascii?Q?kIzbmOf2r3GK81n0Arb6jiWQb0z0qNg54UAAOpG96JggrbZHbGitZYwCBvcW?=
 =?us-ascii?Q?kGvtUP9DR4z+0tbmGghxXdqf90Hymt0l1DcMnr+dy1ZNms4TKultIJZymy3m?=
 =?us-ascii?Q?B9zKYhGtFhwd7al003Iu89xe6KVmmGOJVO3D74n7eBQDkCTKn2Eh9G9vDl9a?=
 =?us-ascii?Q?5uzQNi/UX6P6mGSZl+j60QqJWYwd3sa6OcfwyfP92CddFj/4ctiu5+4sc/wc?=
 =?us-ascii?Q?glhq8vjZJxkQT+N6GWOkkHQaiWhyUjk7PbghJffbQC4GnrA32o18szNe6EuJ?=
 =?us-ascii?Q?orsSCXloy5TPvPqit8pSpjoRXDOzGcGlNyjSSib/pB5Kf2wPyvucAcTV9bu6?=
 =?us-ascii?Q?1lUwSgUVG489F1knU1obdexrpi9ad9mrjq8tgmFmmuLDbXB3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006c262c-16d6-44a6-54f7-08dec6595b7b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:00:22.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiFjhuNX70ohk4mGbrEUSJlVablxebzFuIOyu8sDRFparMfd6xiclXRiy/KnRC3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
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
	TAGGED_FROM(0.00)[bounces-22026-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:yishaih@nvidia.com,m:matanb@mellanox.com,m:ogerlitz@mellanox.com,m:patches@lists.linux.dev,m:roland@purestorage.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5FB0663841

On Fri, Jun 05, 2026 at 08:53:35AM -0300, Jason Gunthorpe wrote:
> Sashiko noticed mlx4 was using whatever random access flags were provided
> when IB_MR_REREG_ACCESS is not used. Since IB_MR_REREG_TRANS needs
> access_flags it used the random ones which means it doesn't work sensibly
> if userspace provides only IB_MR_REREG_TRANS.
> 
> Keep track of the current access_flag of the MR and use it if the user
> does not specify one.
> 
> Also fixup a little confusion around mmr.access, it is the HW access flags
> so the convert_access() was missing. But nothing reads this by the time
> rereg_mr can happen.
> 
> Fixes: 9376932d0c26 ("IB/mlx4_ib: Add support for user MR re-registration")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/mlx4_ib.h | 1 +
>  drivers/infiniband/hw/mlx4/mr.c      | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> Sashiko also noticed the error unwinds are broken too, but properly fixing
> that that requires switching to use the new mr replacement rereg flow which is
> not worth doing for this ancient driver.

Applied to for-next

Jason

