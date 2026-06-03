Return-Path: <linux-rdma+bounces-21706-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JudLEdJ2IGo/3wAAu9opvQ
	(envelope-from <linux-rdma+bounces-21706-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:47:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9750B63AA08
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 20:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=b9nd2RdQ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21706-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21706-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC7930134B5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337FE3F1664;
	Wed,  3 Jun 2026 18:41:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2363F787B;
	Wed,  3 Jun 2026 18:41:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512089; cv=fail; b=Ksm9qdYYTH9+GV2/Mok0xPQf7gbk9LoYeE5s4j7Ep3UJrmMPAF3e3uFVB1LwisnHCWXRxIVPBHcAed72ZvTjoYQBwizeJCgLgXVry2fmCByHnASfx1wzPVEy2kWwanvYbV9y1Zhj/tUKTKGg48lAJDZayQEGSU+dc6X3Wu6kuZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512089; c=relaxed/simple;
	bh=u/S4oPsNcLOcn8+xd5YaPho0PrLRkjUGBg9yoC8TFZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pURmsfx1CuexdRGpVFz7xu2v7B/u9Dvk4TdTreC/RXzuaFpp4OuGYmE1urBxpx+7haY4BSH0shM0efMDYjpCMpUEWS+uoEogR+bA2wpfaXB4qr93QTC9cwIZ/44VedMRDavT0DJxsNJ7lZMQ31YGnFZXc0nUpLfEqnwvVqDbcvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9nd2RdQ; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=if6veWZBPTl6Ex5o4LRuJGKSceR5SqiS/zVbxmilfT7gP4WkNeA9FJmmiWtF6z9YCJlXCO1rmjHpVEnMrCO6SXkQAV1bJLPbWVCAqWstqamDXqrIxWxoZeclzm2frPegDRnJQY/9O4lWwD17FxEvBw77xgo5Vq2nrhJqosvvq3b138XBskd9HCqJlz/3/S8KKZNoaqdDLuvoCoLcG1tRPL3pGrPpeOakQGNmnCjcsN7EbQCxrJqXu6rYX7qqFjse3psZuiCDiYhugSp1gjOsceaCfTJhsN29vccQa8Ih8vTYZO+LWFYVedkEYCNrMIl/1A8idbRTGusR5FBeLLCXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92vNOiRa/wqk3+QR+8hY8d260YPIavT/pyBYCHmeq28=;
 b=mD4J/xDEVcCIOzetHQ70Ia3heMrqZZuOkjewY+JYiYCukeFIQIzVNDMbL7BzRyfYOW1jXF+qb/4XfAIaw3QxsNJvu2ZqQT4cc043TJP8IAtNeALVCUaViT5J56cgHy+Mb/LEPMyeGAC7+kwlAOymJD0h0ScZpZSX3BVExaq90CsIs74CxZVa727nPz5/HYbJc18zOOUlz4CW1DFXTaECISdv5U7FNpU+CHgT/m56Zq8nf4ITgIMrCXw0FcdHZ2qDeRqQlAmi7e1dzfxKEzt/wPB4XdVNvfM+INZZadPohZuTCRzKAg+GbhvfJHoZXoEWSbrqLtapn1JaADjExt+a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92vNOiRa/wqk3+QR+8hY8d260YPIavT/pyBYCHmeq28=;
 b=b9nd2RdQ0MxliBWueFJblmPfT3pWflajilsigHZaez9uO+oPS9nyMZnC/D0IjrWtHYhfkpSRPTlRsfO7FitcJ1zLLs9eOUN70GIhGGWXd0ChsHOQz1SbIfT1WGk5DTLJTK6LUcRE9+rgPuF2919YIszLJRLQcOUGlBpjUlF7K1PGDTC+1vwij+PvoHfQWXbE9hheQt3RvJUVDvURhfaVxtaQ0JGyOynYke5ljkfUTJNsVo++AO02DhVKWmCuwWICGq113MgmVAAB9CEntQ7x1I++slrPmWmg4Fpw+6XZ6wfIHPQqV6EAKQYmcr01dJwdjBaMSpnlM7ght0m023kdEA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 18:41:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 18:41:20 +0000
Date: Wed, 3 Jun 2026 15:41:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Bob Pearson <rpearsonhpe@gmail.com>, Sean Hefty <shefty@nvidia.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] IB/mad: cap RMPP reassembly window size
Message-ID: <20260603184119.GE1170766@nvidia.com>
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
 <20260520154715.1457495-1-michael.bommarito@gmail.com>
 <20260603175455.GA1554392@nvidia.com>
 <CAJJ9bXyva8La+ZLbG5cwaE87AR3GizLH9U37XKgKR1xxOHB6kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJJ9bXyva8La+ZLbG5cwaE87AR3GizLH9U37XKgKR1xxOHB6kg@mail.gmail.com>
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: a9193297-53a2-4efc-094c-08dec19fb460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	1QPs+Xxr9khj16GwRXv0qT8Z+GFM0UXp1u1BnbphcGy3VjunYPxS4OY6oauWFHEvvzP8jcepJ5V+O7facMBfmKm30LvcRCTgsWlsiolGVYNQ65hATcufBZKAgR/dNn0atpmgYYvv1iKejLXYCpI1apF91WYzilqXGwX24Dj/tkz5zjPlKw5okC7PG/Q+eC3sKzGIc1npZY6Hkm0zwKI1ucJZ6JH5wlrQzvbNOJScF/ydo5jPM1pVetHSU6EmVNTaHTQA6XQNB2ZDloFEVeGm2keNSQPMSkokQuz5FFdcGfzK1HFvtICOLIkMzon8KaulNw6/ETNpgye8v4iY9TKWHBEQsYKO52XCeTs/+6OD/plHDnKuLJIcwt28r8zyLBGQ18vaX2zACn+CbWqL17HqPl4oeNAOxbfu7B6GTHh0grSDA8TmyRXAKinWYo8JHh1lZI66Z8ocyCKnh5HaeqQNt3HWpM5wQbdtpvETQzUJuEaNeniJVLSZiHN/BUSvfHtJRZrNC7C7TYGcLAqhoGqnFMKbaJ58HwtHwfO9rJtFzQ2kmkh51a5KCvyTfa8lA03Hm0ZxLyaG3H3NhNrYZHId7cYtX1IxR6FvDR8VlTSyspNoSFaA/ptk4NIdCosdMJRxsxGGA089a410SH7CIV+NHO8Ybc6AgwjjGAZJ9tGtRgiqcjjhdXYMHq4jLeNUjnKv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXoxblpMT0RpdG1DdkhUR1E5Z2tVNm1uaXZoUlZYQ1dBekJGcldmSExhY0Uz?=
 =?utf-8?B?T3ZvdVIyb1ZIZElKY1VjQzlOVjQzVUhWOHBGLzQvUk1yRjUzMnkvMEpZc3lq?=
 =?utf-8?B?OEl4bXpMTWx6UHR2V1RLS0xhL1JpTlA5cVBFWGZ6N1RianpCMzQ4M3ozWmxj?=
 =?utf-8?B?NlpYSmhHaERvU0dMd3ROSWE2dE91OVBkcmJSTk5uRlJPUzNlQkZWdndyWENx?=
 =?utf-8?B?WmIvaDEvVS94aHNFMTBQRDg2RWFpR2ZWM3hvcHY1S2xWb29zdCtUeW1ETlNj?=
 =?utf-8?B?SUZDQlZHbGZleThzQ0RpcU4vN1NHN3dWZmdOUXNhTHAwVEZ0cTRtMzR4UFU3?=
 =?utf-8?B?cjBGa1RjNWFQeUpLcXlzMlJvWER1bVNJd3NGekwzVG96c3luNzM3NjBycGlT?=
 =?utf-8?B?MVNPT1NvNHM5Y3haTmRoWStLMERGNG5aOWNlUGtuQXpQWWYwWjNHMlRIekV6?=
 =?utf-8?B?QVp0YitVT2Ria3NZUHR5MDlDbWpEYmRjbVpTZHU1Sjg3bjVBN1NnSkMxUkti?=
 =?utf-8?B?WmYxdHlScHQ5NzNaUjh5TlJRNU5ZaDdkeHlidkFSbEhJU0ozci9XTXM2MnFo?=
 =?utf-8?B?TmFzU1lsVnJyT0RueGR3TEdMWlNyV2ZtcW10UGhVYlZIMUgwVWxrTkt0NXFV?=
 =?utf-8?B?VldlREpFL3c4YVliS05od1daZXRBbHBPYnd2VTRKbHhDZ0ZhV1I0MnNadHJq?=
 =?utf-8?B?NS9uMEVTdHpicnI3RjdyREJBanlnRGNLbi9JbnVvZVJGaXdKZm1YcU5WcHNM?=
 =?utf-8?B?VTBJSDM4Vk9KSTVFR0kxNk9uUDUzNEhwTnk5N3BwQjg5VWxDbGJMeTJGcjgz?=
 =?utf-8?B?ODVZVWRpbHM1SjJONzdhZ21yTEI4MEdXbjFMb1Y1SnNJaWJlZEgwVU1SaU9o?=
 =?utf-8?B?SGxjWU43UEY1MFdiYjNqaVVCUHBHYWRaMXhZMUFoN09nWEVtYzZWS0k5b2FS?=
 =?utf-8?B?d21oRGVacC8veFVEdFJWWDE4M0VqZ0lUV3dSY0x0ZUFVRllScktYVFBvRGFG?=
 =?utf-8?B?cjlPNi9UQ29oTFF5T1h1MDdTRkY1bWdsM1M2VEdpQTZjbUN0VHFaanFpUTM2?=
 =?utf-8?B?QW8rNHlYVVhodnlQUDNkOVVaUExRMmpzak0wYlUrY2p0TDFpTVJlZnRUVVNQ?=
 =?utf-8?B?UEExWDZnUmNqVGwrVXdhY3BkSlA1ZnhyNmdIZGhlME9kY1BZbmJJZTdubjZ2?=
 =?utf-8?B?YTc5VWlDUFMyeTJaOXRJNG8vRlNPRVJPTUZqUjVPYXl3eXNFakk1L1gyblpG?=
 =?utf-8?B?RzJna1hCbjN4WlROeUprRSsxZ0ZOZnc5U1VTdDcramx2Zkx6Q1JydC9FOVVy?=
 =?utf-8?B?Wi9nZVBFQ3N3RWJLK25lRHdSVTZQTnNRNjkyUWhjZUo2MmpJT1J6Wlh4ZlhY?=
 =?utf-8?B?Qk1wRE1pbWpHVWhqV28vU1A1WmorSSthek5FdU5kdFV6NVJTenduZlk2M1Bn?=
 =?utf-8?B?MlNZdUU4YS80eGlRUWlhT2xNMTVmc0phb1JpUWVSNmJxeUFDV1Qxd0c5NmI1?=
 =?utf-8?B?S2pzQjZjUnN1eW5NeHdzUklWUWtWSWgyeTB4NU9jTmZhOVZpdkZBZ3JkQnVi?=
 =?utf-8?B?NDVpNXdWUEhMNytRT2d1OFV6dVFoYnh3bDFXWU1xS1prYkYwUEZ4NHlYNmlW?=
 =?utf-8?B?UGU4dnVTdWZvUDhQMTJ1WFdEN2czSWlRZlFKWmdETWt6ZGVFejVpbjcxelJV?=
 =?utf-8?B?bEE4Ui9CWGluc3BheFdwMGlFL2V4NnBaZExkZFAzTDkrcFo0cDR0b2ZRM2Q0?=
 =?utf-8?B?aHpmeTg3TDg4VjdMMUZhczV6WGtLZ0lyN0JwQVBVWjJWMUpvR1V6eXhFYk9w?=
 =?utf-8?B?SUd2dzMzV3ZSSnNmVkJFZFFvckdDeEsyRUluaU4wNktQSlRISXN1Vk9CQVlC?=
 =?utf-8?B?bEduS05vR3RlNmRjRVRlTTZlSVhpVTJNOFJOZFJhZmtYZTZxR25pQWtwZHV0?=
 =?utf-8?B?Snh3SlFxR042YXJsYUNZelptUU9GZXJmVlovNFhnbWZTTE5hWThoQlZRWGdq?=
 =?utf-8?B?enRCMjlxeW9rS0liR1B4OUdSTkFoODRxQWJFMEFXMlVoYTI5aWhzZUpTajBj?=
 =?utf-8?B?MXFlTHY1b0hzRW9WV2NXMHJabktjQkNleWtQSE50OFliQnlockJGT05Gc1Nl?=
 =?utf-8?B?eXVZbEtaY090aE90MndKNDJQUzRBZjBoNUZZZ2FmS3J3VEtUT3U5ODZ0ZHgx?=
 =?utf-8?B?TmFMck01enJsRTg1OGhRUG5MWGg2RVlMc21VSmV0SzArQ2U4czd6SzZiem9X?=
 =?utf-8?B?OFhjVVFnTTB6NzFvYlkzazdmUVl4b1pVNzE4Y2FoUkJDSDNncWxXdmh0K3U4?=
 =?utf-8?Q?CtpiMwKZNH1CvPJibN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9193297-53a2-4efc-094c-08dec19fb460
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 18:41:20.5056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh0rNDGVH7jbo3GFkGiCVt3m8HYh2m7dLXm8U86yXoM+trJYAnppSob8jTrr0qYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21706-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:leonro@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vdumitrescu@nvidia.com,m:ohartoov@nvidia.com,m:rpearsonhpe@gmail.com,m:shefty@nvidia.com,m:kees@kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9750B63AA08

On Wed, Jun 03, 2026 at 02:20:03PM -0400, Michael Bommarito wrote:
> On Wed, Jun 3, 2026 at 1:55 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > Why do you think it is OK to only search back 64? Where do these
> > numbers come from?
> 
> 512 >> 3 from IB_MAD_QP_RECV_SIZE in mad_priv.h and max_active.

I mean from the real world - the purpose of this window is to deal
with network re-ordering, by changing it like this we are reducing the
kinds of re-ordering the network can perform.

I think reordering is basically something that should never happen on
IB, yet 20 years ago someone decided to have huge reorder windows..

> > Is this a real issue?  It looks to me like all this code is gated by
> > IB_USER_MAD_USER_RMPP and no in-kernel user makes use of RMPP.
> 
> I originally found these issues looking for reachable quadratic
> runtimes with libclang+Claude, and these are in my notes on
> reachability.
> <CLAUDE>
>   - sa_query.c:2436: the in-kernel SA client registers its GSI agent
> with rmpp_version = IB_MGMT_RMPP_VERSION and flags = 0. So
> ib_mad_kernel_rmpp_agent() (mad.c:856) is true for it, and
> ib_process_rmpp_recv_wc()
>   → find_seg_location runs on its receive path. ib_sa is always
> loaded. Not a umad-only path.
> </CLAUDE>
> 
> So I think the reachability is wider than you expect.  Perhaps that's
> the real fix you'd prefer.

Hmmm, I didn't remember SA left it turned on. AI says it is only used
by SA IB CM service resolution which is so obscure and rarely used in
modern systems. Yet it opens this whole scary bit of code.

> > So I don't see why we should be changing this and risking regressions
> > with the window reduction?
> 
> It's obviously your choice as maintainers, but I'd encourage you to
> test the pathological worst case from an unprivileged peer to see the
> impact before totally writing it off.

I'm sure the pathological case is bad, but I don't know if lowering
the window size will somehow break something someone is using.

If it could be fixed without changing the behavior that would be more
interesting..

Also the way this works the peer sending into this isn't
unpriviledged.  On IB it is using a restricted qkey so it is supposed
to be trusted software under the 1990's security model IB uses..

Jason

