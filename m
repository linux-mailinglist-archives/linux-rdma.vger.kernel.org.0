Return-Path: <linux-rdma+bounces-21695-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rAz/E+VcIGq91wAAu9opvQ
	(envelope-from <linux-rdma+bounces-21695-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:57:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A044B639F8C
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 18:57:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=D4X5SSDd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21695-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21695-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764BA315502E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AD3E92BB;
	Wed,  3 Jun 2026 16:25:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012032.outbound.protection.outlook.com [52.101.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80182382388
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 16:25:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503946; cv=fail; b=F9KLmnd8I/6htus+xTfs4PFDqULUS/eBPMRdAQkTMAHQ5nw5yb88FhYjLC+DbSEIS00yZDl2zMz5ZMdDPBx1CnHyRqywxaknHiAmE8e5WS9D1lc9N9uxNnqEsu9j1boRd2TZZmvEl0OKZZfbhE0Y3PTziN+TFd9CGqjnOzKDjAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503946; c=relaxed/simple;
	bh=rF0EX796IUY7BF1YhB14EasYr/s6fagjlaFRIBFkzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VPTS5BXV2ehcFLicWm1NbsjUvmtl5Yt9J94YBMEHOaIg/lxclYpZ9AZGS6U3cBHNZL95dl5uNo1Oc3aHRDL8tplY6N2ks68rBgeip+5Z1k+esmgyBwtr2UU4Xe3kT9OwQ5O279wx51+wDMWT1DX5NP77Bq7UhFdVlWGmy9sg5Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4X5SSDd; arc=fail smtp.client-ip=52.101.48.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pi9T5jgqjTdZPWg+cXkGvk7XRrDVqTlcQwhuC86zJLe2/J+G/dvK4qmS6koezEALQnZ2tXjeqnQ5JNCxBtPAQHQECQZw6OvGCVXeAxlLGGRKXUjgk8SxKAxUtWB1s7tI+Xy32fHc5WS7ASntxkwfpKxBPvkBdr2Ozpd7k3WX8+k/rFiRkY37hMA2Zj8hYWIpJFDyEpb/KVQpZSjq4pafC+c4shs6mue7+CL+q8fFug9Kk6WgMXsObISK3KlBh1CgY2mI5bgbluju5w7Yc/BwPCgDqtiIvNJcEasx9HUZPES5WuUJmLLZqx0ZyvuFsVXLIB3hkzsXA4ON5LBsieLYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cc8FcN3+3Q9vRZhYtM8/JlvFkn9YUDuS4mS7uZaGco=;
 b=kC1YtKTjEj64+bhz4XgJqWcMUE50JV9Ugw/nApAc9i0XOEiEV0+A0Ph8c2RhIs8oQbiEHwerOxtzideSYf2gWZL4zkglLFgYpUCjdk6P0nk1qZlDSK5PKH8k+RyeFQpqJm/vQhiP9bRh1seRGEjXaOi3dt4CCFrAHakhAV6FvsNDyzXJ7MNtbZwFwZVEe8JVwQXDIpdNj/rvGmlW4LCwFB50BysXLxriJUpddJSQHXArjO4VjaniEkKc+TkQzlnziCgL5Z9ebKnqmImVipvYQQ+tureZQfVJ3+T/0zDqq1zeuE6kR82FslpMr5N3PdR7vllvmcK3ZAMzb5Ce6mwiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cc8FcN3+3Q9vRZhYtM8/JlvFkn9YUDuS4mS7uZaGco=;
 b=D4X5SSDdtbB1kRdffv95MOT8nkzX+cdTlxkXTjDoXq7d6DTlZ5YrMw4VkzhSAuF2fHZL7bPAV/A+5DTWlPyLoJxTbgi18JmikQkbr3dtYiGQhFHl3MNL1MzyafDFcJDorFE6mxpeb1uYf3BtYUpABKN11G9KmBaQTdAIp+imgJ30Igl2IBJ2HgAPZxf5KpCf4bn5UOP2C1kobOwXoVeWu+itH0AzewrBfi2i8E8jXIbjyhn62joJkfePOivhY8z1RVdSOt3nzBR1lp/s53LrPPUcZ987YW8QLGsKGvkAwrRtqIxzGubDY+8duES586QDk5S3U4A8EuagHvDa/SW7xw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Wed, 3 Jun 2026
 16:25:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 16:25:38 +0000
Date: Wed, 3 Jun 2026 13:25:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Fix Use-After-Free problem in
 rxe_net_del
Message-ID: <20260603162537.GD1170766@nvidia.com>
References: <20260519023541.8594-1-yanjun.zhu@linux.dev>
 <20260603012532.GA1188713@nvidia.com>
 <3cdac159-4c61-448c-8327-d39ac0f87fe3@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cdac159-4c61-448c-8327-d39ac0f87fe3@linux.dev>
X-ClientProxiedBy: BL1PR13CA0422.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: 443df6b1-4a10-4e3d-9afd-08dec18cbf16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	LzKes13aL8ZSt1Ma7ICuntzLmOIqKffiWsZUmJrslO02kvpeB6FhrSxtKCBTIQHNXeKHQGD4uPdtUKvogvfldYXwZONMxb3WmmPiagsRSRk5YlXBzuQgxzvcpKwrCM1mApwKMhJw7Antx6kTVnpxeYwG31OIeU+fy6QhZTtFkmCZC3jLJGHJyalIDVkEuhNexlq5PmE6tJXFXdi6LMAF3Doob1I2/fedSpk0qzxA4sw/i7P0Dafr5p1q0Cr0ZC79ex9UzHV8k/Xkg7fVgvuB1fSF9iobcVEZFi5iOAfsbm8TRkGuY0ch+8Uoy8e0sQ0Gks7pxLU670b9hyJb6Muj+T6vA79ICAZfXdkBkZy/QkdH1sMrmAj4pSliaAz+kZ6qy5M3H4WWzN1YQiLegCZbYmEr1kjVQh5IxVZO+Ud6FJbwYHg8/o0sCLtZ+wKVMjDollYoLrE+RkKBWJHH5MbLhSQqVBBY+MTCdvP9Dq1WRm2f3NlIW6QSaRHovvN7W0UprcGRvWz4OIhrRuhjh1rYUr2nLkECGEqHbB8YoDNKgp2xn1VnKRmg2hy8yJKunzQl2dN/lePKa9qlUI1lSM5SlOm1n6guGHe2Cnwx3ixsjUvjgD0vdEKplZOAYzG/b7DkMt7bnuAyTNGj35wsEtYM7V7mLRPztBEtNO4I+rMSpBJkBA4O/NM6QOHGYmQXpFBi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnZPT1JsNGZkN1FZeEMwdlg5amY0YTk0OXVXNURFQUhTZUlTcFg0K2lCZi84?=
 =?utf-8?B?eS9YZm00M01YVTN6NGU5YXp0a2VudHhNcDFJUSszbjNyYUQ1bWxOTEJ1Rm81?=
 =?utf-8?B?eU9VVjJXQ1M0OXloangrN0YwVkJSQnIwdllUck90ekVGMGNlNUp1Z0EyRUZw?=
 =?utf-8?B?aE9IQmIzSTJxQ2R4L3N1aE12cU9MaTYxNDN1di80U0tCR3F2b21seTZxQ2ht?=
 =?utf-8?B?T0tGZ2oxT09DMjByYnYrLzBFRitsVzFnRFpnTVVOZURCc01IbVZGeW0vamMz?=
 =?utf-8?B?Z1NSV3FMSTVRemRHdGdCcFliYm5NYVMxd1ZCYmk4TGtlWGtxb2t2Zm5qcHA2?=
 =?utf-8?B?TnRORVNYT3NUZngwRCtDcEhPekxZYzBVRHhDM1I1RnpEYlV1K0Z6c2tsTGpW?=
 =?utf-8?B?OEhKbEJtbHJ2bnV2RlFhZXN6ZjFmeFVlN25BMUR0YlBodGMwY0M5eDhXQVVB?=
 =?utf-8?B?Q0hKT0RpeWJaNU9Mb0JLMGNXUWF6RXdSaTFuN0lpelZuemk3WXVlRTNXQXdj?=
 =?utf-8?B?clVFZnBwdTFKY1cyRktpQ0ZySUhjOHF0dVRvNzNPMVhRVzBnK1FPeWhnQUta?=
 =?utf-8?B?VlRNUlVQdmdHOWppNWErbkNDbmJuNzBIK1dBR0x6akZFWW9ORmFOeUY1R1RH?=
 =?utf-8?B?MzVoWTBpQ0M0NDlucHB6dGNndjI0bGJFTGhvVXZTaXF0MU5Vdks3VjhmUWY2?=
 =?utf-8?B?VDMxaHdZSW1nUndpNVZFaEozUm9yMUZjT0JrVmNMeWlGS29NcFhTY2pMcFVV?=
 =?utf-8?B?VmNpb2hjSG9PTmVTSnEwSGtWQVh6K1BQRG5seENYUThHNVYrNDBPL3VsK000?=
 =?utf-8?B?Nnk4R0ZCSlV5OXZoMkx5Rmw0Q3paUzh5d1B2REZqaDRJbFg2cjZFTmhrbWJH?=
 =?utf-8?B?MnhQRnlKd09jQ0tBT21laGRFR1BWdEFWK2o0ZDlVdXcwR1h0YmkwWGlVcTc1?=
 =?utf-8?B?ait4TmdJVHQyVkdxcjV2TlNBeTRFZml5V1pNUnhsWnJjRnFsQzZDYWRES2pM?=
 =?utf-8?B?azFESUk0cnJEeHp3RkUyaXU2bElSUEtXb3BzdVhCQk9KVjN0STBEb1F4dHBV?=
 =?utf-8?B?TzAyZXlURzNOUTdPcG4xSHhuSWVJbkhYSkRqTHF6Q3poYU52cm5qMkh3aFY1?=
 =?utf-8?B?SUV5bGVCUHVPUVN0OW5hSGd4dlpqR254NlpLeDlKT2dZYzYrMVJHMUVEWU5z?=
 =?utf-8?B?Wjk0QlBmTkF0djRzL0xCQllaeHljanFaQ25LaHZSR0hkcllEZk5OUUdOcGlC?=
 =?utf-8?B?RWxOSk9UeFJlZ3h0VUNXQ3hJUms2UnNwTWdmbU8xeFdHdnZBR3MzbzJNeFBj?=
 =?utf-8?B?bWJLaHl0UXZ3TGN1K1ZXcW5KUHZkWjQvcnBLL29HcVBtSm8xWERKNkxOWHF2?=
 =?utf-8?B?eVliT0NPN0lzYmJoVmptZmtMOHQ5TW8zSUtYaW9pZUVYS2FwN2lqYnFwVm9U?=
 =?utf-8?B?Y3BmRTF3MldwVGNwVEd1Vi9hVU1wODhSQXYvZFN6M2IwZUxlbkZCc2tuckNz?=
 =?utf-8?B?K2sxSXV5cmhaa3ZYUGp6QzNLclgwc1c4Q0kxSEdKYzgwSzI4aS84Qnd1R2ts?=
 =?utf-8?B?K3loRnc2R2lnc25BbEwxb2ZtRzY1Y1crTVhsZFNWZHRRSVp2Qm5RcCsrR2hG?=
 =?utf-8?B?MTNHcmJPa08wckFFOFh1eFR2YzIrK3R0clBNUVN3NUFJaitNSnJFSWdSVHlL?=
 =?utf-8?B?VFBydGpSVXF4cGpJcGs1VUlodndXZGFOalJvaW9TZUJHYmIyQnVsM0FDd2pE?=
 =?utf-8?B?Zzd1bG12anpLYUxXSkcvWkZBS3FVWXRkVnZSQzhIRlVvUXRtK1pxL1VySTNq?=
 =?utf-8?B?cU5vWCtvd1JiSFpaQ2VIdmtLNmpFcStEWmlZazZ3Z283Qkcvbmh4Wnc3RVVJ?=
 =?utf-8?B?ZWxKWHk5bUlBRmdUaW1wL1czSGY5RTVmUG44SmpabkpWRVIvY1RvRWRPZUlS?=
 =?utf-8?B?WlZ4OFRkbW1sK2JvSEdSNUwrblpmN3UzbWoybVdid3ZuQXJWTTlwYlhXVVBV?=
 =?utf-8?B?L1hQOEtXOVQ4UlpkbzJjM0xDdFZKTDRYckEwMm1hTUFFa294UzY1WUJkRWZT?=
 =?utf-8?B?MndxckNtbmFnMlVMRGhDVFhkQSsvUG0rcWNxUTk3NVZPYmtTSlJCUWRiUVlr?=
 =?utf-8?B?OG9VejRyN2kyUkZ6bms1UmNhbHFCaXgyZEQ0cDkvbU1ta2tYQ2RBcG94aWJw?=
 =?utf-8?B?VElHeHlxK1laelR5TUYxZkR1Rk9ZbVJCZmtma3VNQ0ZtTWV4Yk1UeUV1ZWNX?=
 =?utf-8?B?YXJRc1diTmRxTEx3RTFMVE1YcXNJWWluR1p6OWc5ZE5mNjh5bDlocy9CczJR?=
 =?utf-8?Q?8k37nE6kq01VG8i3cK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443df6b1-4a10-4e3d-9afd-08dec18cbf16
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 16:25:38.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ybfdtl0B4f6HiRG1rhCSmXRUFX0xPev4sqkIOFWY7847Q+/EHA8NCPY+zywhz0g2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21695-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:zyjzyj2000@gmail.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A044B639F8C

On Wed, Jun 03, 2026 at 08:43:31AM -0700, Zhu Yanjun wrote:
> 
> 在 2026/6/2 18:25, Jason Gunthorpe 写道:
> > On Tue, May 19, 2026 at 04:35:41AM +0200, Zhu Yanjun wrote:
> > 
> > > index 50a2cb5405e2..0bf5b0eabc7b 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_net.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> > > @@ -135,13 +135,21 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
> > >   {
> > >   	struct dst_entry *ndst;
> > >   	struct flowi6 fl6 = {};
> > > +	struct sock *sk;
> > >   	fl6.flowi6_oif = ndev->ifindex;
> > >   	memcpy(&fl6.saddr, saddr, sizeof(*saddr));
> > >   	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
> > >   	fl6.flowi6_proto = IPPROTO_UDP;
> > > -	ndst = ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NULL);
> > > +	rxe_ns_lock(net);
> > > +	sk = rxe_ns_pernet_sk6(net);
> > > +	if (sk)
> > > +		sock_hold(sk);
> > > +	rxe_ns_unlock(net);
> > > +
> > > +	ndst = ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> > > +	sock_put(sk);
> > Sashiko says this crashes when sk is null, which it can be.
> > 
> > But this really seems weird, the rxe can be in only one namespace, why
> > not reach the listening sks associated with the ib_dev through
> > qp->pd->dev and not do net lookups?
> > 
> > I would expect net lookups to only exist in the add/del link paths?
> 
> Thanks a lot. I will send out the new patch, following your advice.

I was thinking later I don't really know what rxe did here and normal
rdma core code has multiple namespace flow. IIRC the namespace
flows from the selected GID entry and the namespace mode selects how
gid entries are created from namespaces.

So this still looks quite odd, by the time we get to RXE we should
have already locked down a source gid entry and that should be where
the sk really comes from??

Jason

