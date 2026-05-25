Return-Path: <linux-rdma+bounces-21238-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LfXEfZeFGqgMwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21238-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:38:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F605CBCDE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 16:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15AD6301324E
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 14:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146F382396;
	Mon, 25 May 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2uYwRGj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA62D94A0
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719923; cv=fail; b=a6bHaXuTEOuLuUs3u8TqQUeEqzN9DWQWisybuthLOgVp8yJqb8sFiGaQuaF5rJLRStNOLCtHXlJwcs5IN+4kEnXkzFjB1V3c4NR9zQKNpr/q45VhJvGoevY7qLIbvspNn5/gM07W0nE1RJ9Ur3hqj6mN061wbhYA2C3Aa4MTpIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719923; c=relaxed/simple;
	bh=WGh2ZK1ZmmyT+shWou6rNQLAYDPXV7Jhj/QdH++dMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CZk9JKQ2tya396JRyugvYQm6yqJfgrt8B+nsSVbN2n0gZ30dbYoiJlZmKfIvr8RI6ZDgoEBBrS3k6izvKmCWd36NmVQiPqfb4rf1Pzw4QbqYN/NA+n7srbH0hUROA+yDOd4Lf9QmqXUBknJiiZoVDwhHvlp1LHIQX4dc5F8cF8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a2uYwRGj; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJX+Wf7geiFf8kbDwtESK9vWhdoWklBc2nYyPkfW5oaWVpqUXv9JA3FXNAFNcLLCXCJ8P+j2oBpHShmoN2jCjvFOCXueF6TFw+NGtX48A2J+qMAuyWX11t25VxKk5eEr600BOUKNQUmjJZbmPAubJS172d7HFZY2iqUPGppXqmimKWIVvGo1oIeJOvHz6pjmK8ISppp9cnNqkYeUOhcSNEqDFWfAFtBUe/BCjAnGBP0i4RU+H6TLOQBrFn/j1Xb8PpEkz7db/aLjbopqWejxcvTGKg+04YPcEo3pZsa278csi+WD3ls/RBg5ay5TaOYUpueejbkWOgakcmyzr7Z3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9bLdWk5ZbAx/QifHUgrvEfegrQKd3jeEKjbW68We+0=;
 b=K4JI/870xHRmBW6MwwcnGp6oAZDfD1Dg62tsn3AUm1EK68GnMRwiNZVZvsFhkf1ZSYx1PMHleI5zPLF6yTesbOnc3IN2TeY8anmqAhDrC/+orKQtmPHSVjMIK9QUYCgnqFL/TgGz8l36v9PFBkG4BNW2sFPamCSYYkzme5kQQn8cbvyREVJpTKCYFesvZMK5D+mAGusPkfnOyXIDl6rMG4uNGqu/xNaTCr5h6C5gDllltJ2zPNGFT0nMbxxE4Og1QYgO3uawL00no7D5SNunH1Bxd+XDMq3gMX0iShuon6FTO0gFqpsYUuu5oF102yMsh9eol5so8Jh65He8/1C9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9bLdWk5ZbAx/QifHUgrvEfegrQKd3jeEKjbW68We+0=;
 b=a2uYwRGjfqVr1bp8MCq1g5BF7jCCpHsJGAgg09eHpjdz4LZYjTwy/CzBc4mI1c9fwntrBpZdrQgBy5AwVfnmIAA20FI8CdhN6jg3ppLZuepgyBhmmFHgVt/aE3C19tirla4J9m90FmVzOgWC9pjvOsAbsmEsfJOX6QBJtMonGKRYwHSQU33lgrXGxd5MQ43FNUSLciCgKPl9Cy8nRGi45mdiUQMvfazepskzw0TVGQkizfypr6TirsgcJuAsh+wc+LhbUiVYu2h7HbdC03qJMu38A0FN6oD+P6GIHs7vdF3lZQSdc6ZkvYHzr+9+dC9p8KkarUyTPnNqimJDBNDdTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:38:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:38:39 +0000
Date: Mon, 25 May 2026 11:38:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-rc 1/3] RDMA/hns: Fix memory leak of bonding resource
Message-ID: <20260525143837.GA2457236@nvidia.com>
References: <20260520055759.2354037-1-huangjunxian6@hisilicon.com>
 <20260520055759.2354037-2-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520055759.2354037-2-huangjunxian6@hisilicon.com>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: f16b2981-bc73-4e4c-2d75-08deba6b4f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ilLu0AJuTg5eMim2bnGtcDlpciRTlJgNZqUg6nPGqAhzG2qIOL0rzVqXM8KTm7MU62xAQRiJdqFIKBUmdVA4rQWifxq+QDe8OkdA+5C1qKC7zTfgp2PAEbPgAGV6//8sLlwizw2JkgyBW32cqCY727ft1Fug40qTeImhh8MaW+/jpdrrT86WVUQIDD13LtGKU+w1N+3QvvUjWxvqQURG2rWV00jFKA2puGH+p6lIFQGqXb8tZErOYgQ2nce7m19zWbTHK3r9L0BuaA8PU6dOhtI6FJxy41eJc7ynsbjLT8W4Zev7zveotMZyAwQ6tydu3Bhue90dN3tmZFWt9koKOiCy/mDeWEUkIQLAuInrRgLmsEPKjHgFi3xkZ9o5e2yUcuXUMXgLkIMSFKlbne958gDBNhme1sJfHxt0EWTZHI1Sllp+CzohWQBhRMi1kK/4gf6irUX+EVc013btl6Sgw+bzYoPF7DwLIrVCbKXz3amYfuIylTaUiZoWPBSjGKI/cgZvN3qhsJ6NiR43Y61+/qSG5MxJFKlmenIeWNmQO8Pem4j/5gY/8Z9a3id28QzgBAsL1b8I/CzMx+gY0tCIhJ7bXJjBalKu2I3YnFUyje34xaHZ1DVEez/23fWsjDMkBw1lUHUq0pjxbJf92c7bwG1sHAS7pb4oREKAxmDTmaS5ED2Es1rWAbcOZsTMWg7K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rlEN8Pvb5LGDTjI+35WHCKbT3BfGfGzUesMTgKGjDDaI5qJTutbOp2vGwDmg?=
 =?us-ascii?Q?yhdHZncbSlbIFIIYyey6bKHGF1A7xt8aLqeMYvGqRrm00GQ6S9eQmEHPBLfa?=
 =?us-ascii?Q?XbPTwn8gwRQiARVBpuns0WFsuS8Md0nxd9SGbS5UisK076xeKUWv3bk3JVhg?=
 =?us-ascii?Q?UbfSuBjB+k6FDpeYIgUBSds1Nnrbw1bA3jMbjswtN6AvsQ39vIS2AoUDOZz0?=
 =?us-ascii?Q?51S/Prv3namAkfLbWtSQ74Ghjc1FqOiVMbNsa1lXVO2FHbUVIWvMhOrAv3OF?=
 =?us-ascii?Q?AkiQY6CZ7c5C4zDlC7J3blHzlbeFJbuDMng0tSHC+HcW69ou4jSgN2Ft85QN?=
 =?us-ascii?Q?Z52dSJRmWZeJASUqW5HM3G7wTxvJjWE5c6yiJ/X7whO4ULy91fCNx19bWX6b?=
 =?us-ascii?Q?MaKmXn4j+c2RYqE7utI/VJNRtRUrqfYs225mBHLM41Hl+kW9h9aTCCHph6WC?=
 =?us-ascii?Q?flT6D9FQqZSYmiqqxHUE5S9yWDr00bNLO2J0t8Ed4v9LV1J2Pce/jP+WEWA1?=
 =?us-ascii?Q?XS2ftAYVWMpgS5xgnNUky3/QrTc8hES+zy/US6HEhndeckJYXe0f3smuP1Mi?=
 =?us-ascii?Q?Vc1GQB7SgUUIm7HLvCEG6TqVgCpj05g0L9p6HK7aHfsVZimejyUhPk/bnQCS?=
 =?us-ascii?Q?nKxA8WYD50XSnQu5tV5uJd/sUHvjHjWD7iAAXpy6WpSq+YlhtkIq5jYnUKhx?=
 =?us-ascii?Q?9PNpjCWqwDUppbXzVmyW0i4FfjcqXYELksB2FUm5VEiGiVgN8DwjpgiZm11i?=
 =?us-ascii?Q?CPnsrA8mjzqFkwwvBF5NM8uOS+Ud+Lw6NEKz+9nFv5jR5csYxNs1FqGYiQRN?=
 =?us-ascii?Q?m0G1TwHStLuFv0dShHHxzc49M5RrNjXBWo4TqPBBvSbSbpE7r8ZyHtsBqrSZ?=
 =?us-ascii?Q?ETI9rfd1s2Vu6iOMEkg4yV87R/MpUeuwb0G2Z3KEFxRJ4+T8h7Q7m5wgah7V?=
 =?us-ascii?Q?6/v2izoIp/24Ar66oQOZWjhBIs/nDOSCQleApeEFR6LidM6lqCmQmppdWkJA?=
 =?us-ascii?Q?0Q7bLOZvxIatDIfSpfXC7WDSEU8ziR4P7ISjspEiWyFtdZZl4JlOdehHPWwO?=
 =?us-ascii?Q?YsFwUfVQjl7JPJp374P3S3emiga2Ts3k8FtI7mUe5N7/a8v0xErdGP3YpwDJ?=
 =?us-ascii?Q?c9oth9Q14SflolgReMDxtMTyMbCH94wcPbxY7XjKrI9N8urLzoWFbTTAm7L3?=
 =?us-ascii?Q?8a+dpuzXCGEcwQy0fcfawkqPfSZWAFwOSxvgeFQc7l8o0M+fpXqE7PrV60CC?=
 =?us-ascii?Q?cyZJOl8kObMH8C2Bc2sXcdR/U0eZYilJQ61B3H0kL/A2/e6ZzCYKJR1vjYTg?=
 =?us-ascii?Q?tGk+cqiJOguNZRoczi/8/T61hz5ntPDHvbd5JIqmLDTISUpN6olYaE9Z25Yw?=
 =?us-ascii?Q?s0RZiOzG53V1qzy8Dhv0JEeuYJoONuhnjrYfpspx/pIhjFsZXJDTaAPXbrc3?=
 =?us-ascii?Q?88V3zbXjBuHOPGZymori45adfd2yFDG38InQThzUlFIvYSvrO2eDfUlAEMZM?=
 =?us-ascii?Q?2xhc85t+qNB+gbZETNOCgQFC3ejIPUQ8XIm7evYFsXBFBOprPM+0xgoMBLnb?=
 =?us-ascii?Q?SkDQWxjH+wXfT5m17t5xmL3ZcTHlo0jzbj0BfIWUVl170od+VX9xXDHDBNsp?=
 =?us-ascii?Q?ZqPLX97q5n3KRYeO03XSJuXKFAhn2c8IgqInVLZ0sjryvdMiSTDFzmrv+ug8?=
 =?us-ascii?Q?vBzh7qCrRLCCJPCoiNa2NAdbNCRorD423L1fUPDWytXZzmGS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16b2981-bc73-4e4c-2d75-08deba6b4f68
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:38:39.1229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4HzcjsrC2VgKPTov6lv4YH5IHf/03U9ibpxSKPjlNguZUxsgvY3UnfQyoOoub5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21238-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sashiko.dev:url,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 56F605CBCDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:57:57PM +0800, Junxian Huang wrote:
> In a corner case of concurrent driver removal and driver reset,
> bonding resource is first released in hns_roce_hw_v2_exit() during
> driver removal, and then is allocated again in hns_roce_register_device()
> during driver reset. This leads to memory leak because the release
> timing has already passed. This may also lead to a kernel panic
> as below because of the leaked notifier callback:
> 
>  Call trace:
>   0xffffa20fccc04978 (P)
>   raw_notifier_call_chain+0x20/0x38
>   call_netdevice_notifiers_info+0x60/0xb8
>   netdev_lower_state_changed+0x4c/0xb8
> 
> Bonding resource allocation and release should occur only during
> driver init and removal, so don't do the allocation during reset.
> 
> Fixes: b37ad2e290fc ("RDMA/hns: Initialize bonding resources")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index c17ff5347a01..a7308a3c586e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -795,6 +795,7 @@ static const struct ib_device_ops hns_roce_dev_restrack_ops = {
>  
>  static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>  {
> +	struct hns_roce_v2_priv *priv = hr_dev->priv;
>  	struct hns_roce_ib_iboe *iboe = NULL;
>  	struct device *dev = hr_dev->dev;
>  	struct ib_device *ib_dev = NULL;
> @@ -838,7 +839,8 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>  
>  	dma_set_max_seg_size(dev, SZ_2G);
>  
> -	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND) {
> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_BOND &&
> +	    priv->handle->rinfo.reset_state != HNS_ROCE_STATE_RST_INIT) {
>  		ret = hns_roce_alloc_bond_grp(hr_dev);
>  		if (ret) {
>  			dev_err(dev, "failed to alloc bond_grp for bus %u, ret = %d\n",

The sashiko comments about inverted teardown seems pretty reasonable?

https://sashiko.dev/#/patchset/20260520055759.2354037-1-huangjunxian6%40hisilic

It would be better to fix it that way instead of sprinkling this
around.

The other comments seem less interesting.

Jason

