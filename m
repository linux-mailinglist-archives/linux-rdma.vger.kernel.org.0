Return-Path: <linux-rdma+bounces-21624-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4d6OEfrWHmrfVgAAu9opvQ
	(envelope-from <linux-rdma+bounces-21624-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 15:13:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B01B62E596
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 15:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PokTYaYg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21624-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21624-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1962931166FD
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 13:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674A3E5A2E;
	Tue,  2 Jun 2026 13:05:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B67B3E1D08;
	Tue,  2 Jun 2026 13:05:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780405509; cv=fail; b=ZJuebQjJx5tJTZLq+4fZ2kUpSKc5rjS77Gf+GZgRjrNws8kf7jLTV/AbRnl5x/CYQ6bSqYhhr0ZMsPVqIuXjTGIl4f8vy/xrkj6tMp+dronKOh0SlDPp5zotmQLakjtU+vJvstMmlhTJLrUFhMg1Hurktah/4EGZJoF2rJTCRgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780405509; c=relaxed/simple;
	bh=mYOZgjgOIcu/Gu2Ydm4lQRJNcRDecJSBqFckkv5ZcBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhluqTpCYuDCboVFWATG/ep613eAAZPIvgxf2SNNXuEe25thyD4bTVkfhQN4HtsapPEiUaOi4gxcRXr7da4eVbao8Dlz0H+0LnrL1hozwvqKL45P2QW6olfY60vPyS+iXg5lJKnv9+bExvNI1kVV6FbmKPGmvgwBBtllpEGoet4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PokTYaYg; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wp0EfFmG1TjOWgP0r3Z/fWMx8f/RPtE7xu1LHHb00vnJjJoV3JK1ot4kajd8kco/Sshs1wMUx8UVkQQC4uGWNjHa+eVHQqAo3707x4XWezVWvVAzFnoFSOpgsPtLTjSg3F32NaHjIbvHUdQ1msXQqqAVIUw010jkDuAaQU9KfC1zyQ8bKVmuJatYpE4qaWqyAspkAbLDWn4de8QMgUTJPYkMsN6Lqx2gBdVUBJXMYD1ZMUByLNfG0KcvUOteEWVtnh7lp1sLQrLQTzHTxxNXK3SgRCKnr02G48+0o32ITAUYxKidOQfB0macmyWZy5aDNlGrfr9MR87k3pcNJsfqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJS/bOfP3mH/lUxqIYzsu1vJBmCzfh2C9kwla2ZlDKk=;
 b=mSZ3TXuaLuo3SSfp152c9tgvV9STjB5ATzJZr7EMNSf9AnKDDA7u4imlK83giJn/NkbfV/2YA93DV0JK2jIuIryFyDr6iY898VMafxSPwNzUiJpQKeQJ3+aaRm7+9Yp58ijTFzhqgXiBV2h8JREA1h5fhvnhk19nOvYL5Po4lJlpF9OK8B0yoQyJLUugNvbFDa2JBoq9a3zhXlH3M13ayecwXpLxxmh3gZF7xx6YCWRKQ4dnc6eNa2AfwAXzvIyqGRabvokKy5GvZ8Fx7tAsVJF4QJHxmRf2HB7FWBb2IvI5gqx01/2a1lPPP5WvG6xFRVrsYSzMyEUzXfWbgQgvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJS/bOfP3mH/lUxqIYzsu1vJBmCzfh2C9kwla2ZlDKk=;
 b=PokTYaYgRO7K/s6DyRJPwO4+I/9WTcppbljn2Hh2vjZPjMXPciwoEH9UUcpxbYUTez9LPUFdYb+cY4UOXTNU9tOwdtSY9WhUdio5j15drxxfSQyAGEFTwlLsQk3jIODHEe0A4hWV12Tfbkh6RVYImKHfs+Tb4AIbbA8i9NF1xAL71wInzxOPWkaoWOUIv39RZUy1UDJMALMKERn4ZUM16QahJux10c3TDn7YTp2U66ClD+6LrXpFwQf0K9n98ZVPmcdIAsvYNo9zjFP58F74Nqh5KPwo1xvvXwJ0fE4siWshRSri1IW7e3COvc8w0iC55Mdm+eHT8zf4l8orlvZWnQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4359.namprd12.prod.outlook.com (2603:10b6:208:265::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 2 Jun 2026
 13:04:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 13:04:51 +0000
Date: Tue, 2 Jun 2026 10:04:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-rdma@vger.kernel.org
Cc: Chiara Meiohas <cmeiohas@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	patches@lists.linux.dev, stable@vger.kernel.org,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rc] RDMA/core: Validate the passed in fops for
 ib_get_ucaps()
Message-ID: <20260602130446.GA910183@nvidia.com>
References: <0-v1-fd9482545e37+1e25-ib_ucaps_fd_ops_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-fd9482545e37+1e25-ib_ucaps_fd_ops_jgg@nvidia.com>
X-ClientProxiedBy: BN0PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:408:ed::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4359:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2397c7-d147-41ed-dd56-08dec0a785eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|6133799003|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	BDXYGFZSppOgcPBrG83lsufa/0asETNkQEeyaQB08K2KAOlWeMlXqxsn+v3EXrfep1+8zNO5sSYSYg7sH5Ds+yyUk/r0lXHaXoBz5ZbUIvEZxe2hjxJqbUgJl7K/Y6KWRrss/QfHjjERUHTVUoqDk1sDPcFw3Us+6EVKLWuiF0zAS6VfqPeRDczS/06ePC+z6uhiXopnQUBUgtES5DcZRUYkyPF+Z251mBWPzzuPM/2CZ4rcLDcF3rT/420c6WU+l147GOKFcjWGAqZuSsx4KvNVghfscWmjklYDf4T0Ezv8dOlX4C+XstGVV9toh4xzUuWyNkgcah2I2evc/HMpwBRc6m6amxT9rw6wqrPloUDxUEn6slRtAH2kWLtkEY9ML0vGTbAohHTvfaZFXQZ+aACEZf+NJoJ9HRvcoJXgEp3idRjqCi2FzO2iSNUHyKoZ7kXKen3Q7YG8Dp8FssZNDx18uP57eS9b3y9YQsTydNvTMvVQHGjr4GDYLPZ4rJI5UyU601WdT2qonKt6TJ2ELdtwhpn4OpTkIRUratZ9rIcpvBvD5XaKlOXFx6NHcZkNfTJjwrjKpoxdGmPNG4yBM9xobCtguoq0+mxRHGq33iyHJsWz8hzlfmV6cBTBgoyr+Hccg0sBnqAaGn9QHoAqPDFK84F5ZlO8lIR7Kk89QcbQ3otA1YMRCl3lHhV8i1/T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(6133799003)(11063799006)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iMh6xQ1tRIvXzr/cwVw2rmsFCQcWsAedVIi+RsAtY6/mBybr8KDgzGxRYsQl?=
 =?us-ascii?Q?p3+wPyEhsD2HCxVMyF15wKlkrl//wJszvi9R2xZyyroP3vbQBVytraxV0tPM?=
 =?us-ascii?Q?xKzeQrry31VLTdDcBmt6RdC5BGnkM7Yhpu44N8IOdpZCZU1T0+WjMRjhcEY0?=
 =?us-ascii?Q?xdEs7dBS0XvB6NB1MY9AMcCW0e4CePxFss0xVVzDVjzlQ9Hdwgr9HFdD/MWn?=
 =?us-ascii?Q?5OMFuyySIk18uq55AP8TXybGMknxKIqYAk6kGNrnJsODmQpoNf0Wv9NUyy3v?=
 =?us-ascii?Q?qqhCn4FMnASzHi/E/fQnN6I1CdaSaOkOJOigRyqIr4B5JaRSjVo6ayLezqpe?=
 =?us-ascii?Q?GG0XKWaJaDo9I1p0NCJo1Ib1MyEwkqQZvAX3wsKKEIZl+0kaBMcB97Y3rE/8?=
 =?us-ascii?Q?nS+KmvLSfeHKHedxFMpPhdPgwhwRRaJ78ijnz2oZJn/ePer1Ck20YY4bPEdc?=
 =?us-ascii?Q?9OFtXWU7UCrMRWYxJBZrvEKL0ntXCrafh49gXLV7VJNitDLazWj1T0c5M+lU?=
 =?us-ascii?Q?qMn7sxr1Ek+NvRFYSby75IJGehwaI74c0d23qHCahvsBL3WwwXq9HRZefNwB?=
 =?us-ascii?Q?W8Atyuru7bdkAqzLcgPy6pRIMBtwl7jXcIMc4SY4DFNTR7fEU0luwHhqknqy?=
 =?us-ascii?Q?sq7Z/Dx0S8yvvxwvr9UfBRTRpuvF3rQiW5vTu1tNET/AgT+dGkzvS08V9jGt?=
 =?us-ascii?Q?Lt3uqO0ELgq17ZqyvFbQaTWMDRMMxxCaDWoXRplrNwXtp0ItzS3dAFyLV5Bz?=
 =?us-ascii?Q?0HmTy8SqLa9ZHvujyI7SnNd8jf3VNpat3JYomsPmE7UHnh+wzbU+LFsMHNfw?=
 =?us-ascii?Q?w100RZH+QOdaYjbo1pNbJ9x/C6bW5/4fCiG9DfF0k6gQW9Sa23TRVUe2AFfc?=
 =?us-ascii?Q?d9EDLEDM3npFsJ9AD4C4OvNWnyo53/c7KLpzwncp7IW+QHo8wNsBXiMoTUGF?=
 =?us-ascii?Q?VW7gueSxSZva32m1NjMstj8dwMM6Jv63i7ht6pXUdxUuF7JMfvTSN+wdQD83?=
 =?us-ascii?Q?Ta0QYWkB2R4hUaDd2Oj4vuP8O4B1udFWJSXizxNAhIW+4SBchPXw6QvGh4A7?=
 =?us-ascii?Q?yUSyUoKygv8grByzgpGBJHTAMDejLLjdF3gLVFEolhryWPmL+jloU4ZskwlT?=
 =?us-ascii?Q?HKvC6kaX9ZpxBKqTXnuIWWrft8VAYIpwqKBN0hEh3owByVeaPUKbiZWO8odg?=
 =?us-ascii?Q?J4LJIM+8pKhUrOX0vmxt2h7zVaczZOapHTPnzNmIvLWyp2IKiH7/Aqwi/WFw?=
 =?us-ascii?Q?By/Vy9x3k7TDjdG3yL6x1TKp6VNhtC3Dz7Y7Bmls6K339n6xkUOG2b5beaVQ?=
 =?us-ascii?Q?zEum8WfWtgtZScNPvulfIj8reqcogYmZahMarH+GFKTwzXIxsX7c79Lush8F?=
 =?us-ascii?Q?8IpcZ+NgKw3Oc1d+7PROS90VdYQCwVnHccq6d4xKzsEYZxMd8o179MwV+V4a?=
 =?us-ascii?Q?7dgtiJV6wr65hDi1jYKh4TveLCeSLy9qDPS0QPD0j8pd4Mb85n8nqWu8/5sE?=
 =?us-ascii?Q?JvJItxjNraEf9XCl48JhICNcuPVTqWYtKJ7VuMMeI0TPf11499D71o9PYbwj?=
 =?us-ascii?Q?ucOfcn0lQf82StypUsTklntGu/hL/uA157IdigRJB4D7c3uFXrjYnOZbmvd5?=
 =?us-ascii?Q?TH51RR95GuhAAO2Om3NMH7+S+c8K43453tjm0dQ+c2xe9fkJ/4gu5E4WF3Tn?=
 =?us-ascii?Q?j+F59Fop3CL61bwkqIZVGIh5BGGP0Qmcz/L9Rzyu0+pkcR5C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2397c7-d147-41ed-dd56-08dec0a785eb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:04:47.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4h3nOzkEADzPnXQYmM8MefTd0X0Va5J/6OwwDLSarWL4mgt6X7LlIxovWS58JOlR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4359
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21624-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:cmeiohas@nvidia.com,m:leon@kernel.org,m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:yanjun.zhu@linux.dev,m:yishaih@nvidia.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B01B62E596

On Tue, May 26, 2026 at 12:40:25PM -0300, Jason Gunthorpe wrote:
> Sashiko pointed out it is not safe to rely only on the devt because
> char/block alias so if the user finds a block device with the same dev_t
> it can masquerade as a ucap cdev fd.
> 
> Test the f_ops to only accept authentic cdevs.
> 
> Cc: stable@vger.kernel.org
> Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/ucaps.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to for-rc

Jason

