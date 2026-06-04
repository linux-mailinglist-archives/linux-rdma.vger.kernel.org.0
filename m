Return-Path: <linux-rdma+bounces-21735-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VdOlHEoUIWrZ+wAAu9opvQ
	(envelope-from <linux-rdma+bounces-21735-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 07:59:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B963D1C6
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 07:59:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="AX/WXJWM";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21735-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21735-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E3F0306BAA4
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F92D3CC33F;
	Thu,  4 Jun 2026 05:53:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2D39A4DF;
	Thu,  4 Jun 2026 05:53:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780552437; cv=fail; b=PyfiuwGAkJ1TQcIAh7tzxWJhgmXaFUsc7dtc0o2OSNqJbTw0bEVKoCa55RppMxVTAL39/Ovqi39S6s8UYOTc40bhYM8u8sBhW1HLCkJSUEvgxTJhMSe6kCQRHCXvg0Qa/2Mf8X8CESIZcyZjWUkpVx9EnwIlDirJ75mRjnRiWjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780552437; c=relaxed/simple;
	bh=qe9N3qYHF+6WMMCJeKQcW8lyM5v9ukysWU8F8kt84ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=itiqqoUUeNE3RJyPq1SVB0Em1i5QIVNlqNS1zgICMuqpmNaEcOs4wLiOJOsKvNuo4vQgAJ7rORT7AIEeEV6MmxN+gLsvsTAMF4AUoMdPX+C5BoOtLjhxVWg+bRq0oqZ2bQKXouJUjRzvmODtA9V8ghw5eQHYVaJhrWhMEiXk4/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AX/WXJWM; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxDKjkmzC0CowG5gBEwokZLhDxfqCq58fhaeeVee1SwRtvDyDD9Ky1ni38GR4ie8/07tKaImyNrL0ZMuuC8M67Dt5zLLgtcq20482k23msu9T+VSlWKuAmIxdjzmBkYYj0TBjswRAJzzQyWgqKrrLMrCdCLUP8Tz1NN/UzGNZvXkgoq04P/e5tpjDbB1Ose0wQCArKEqjNeTh147b/Wfj5AP0lvXG26YsbSzlSpD9p7cMrwOC0PGKSozYr5UwSlHMW+GNKIMdz2P/iDgESwxSXPi0DDnyuyYYPrOWOW3X0npt6EVvANCNGIlWom+Zbkb45mw4TswMk0dvhND3yYBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV4LYmun7RFNekCmv8yEaoEGT4JGY5anNONBZniHsf4=;
 b=iVa5mo4BNVoguqXXvgFS5hAQ6FJcdhGJ/zZputMAWFYbMwWWTLzqT+upD6Ty2NBtuhoSeLASKAYK9+ST4uV1qZzAjTC5X92iv8EKc3K9dOwfSAeKirBaPa60k5oSwzlPO1jFYsq8aIpwhDDiV2w1YC4hihqkDEPuH4IY39fUsZ9jtJbASRHXfh9C58UmBej8LS8inkH/mdz2qp8Zld3oUw4VZzeOSSl0/l6vy5XIE69ne+/mZedD3orT3yWNKdM6cw2sZwcebJjLZURpBx95fsAzhsbwYHatAtv1DxaV1n3hVu69QbBE1nr+m0ezAOpjVQm4/hoPUjVfNKYBKPFA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV4LYmun7RFNekCmv8yEaoEGT4JGY5anNONBZniHsf4=;
 b=AX/WXJWMKPCTawHPfidL3ioPHSBYhE3HEJW1JaB3HWSstSMp3RZCpHzbQ6+/h11OVZGQpfBT07+5Sa0JOr6ADTajl6vqP9c9JSFPP+mWcwNiOKgYtMFEu8I4myh7hmvM52U8u8vvTa5iyFWd+FlAg0DHoZFDIbCPpJhStU7BSFXAmI4t528I2jC8i/MJuXL3v+JlGIvQQhXB9Iywbqkk2Y7GfiHzMLhohD2HgTbUMzqGYxzl/dkk9Vm9ve7JmGMF95Nv5llnSu8og5QGvg2REl0a2AxuEd7n7Y8qWpUzapUqhqsl2TVdDtIZmJ1e487HSbwHbq5ltyfZP+VeiLLkog==
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 05:53:47 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::6e) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 05:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 05:53:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 22:53:28 -0700
Received: from [10.221.198.226] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 22:53:23 -0700
Message-ID: <7018a27a-29fb-4c8e-84cf-dc90d1b3bd9c@nvidia.com>
Date: Thu, 4 Jun 2026 08:53:22 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/mlx5: Only consider online CPUs in affinity
 subset check
To: Fushuai Wang <fushuai.wang@linux.dev>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <tariqt@nvidia.com>, <mbloch@nvidia.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <parav@nvidia.com>,
	<moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <wangfushuai@baidu.com>
References: <20260603072657.10868-1-fushuai.wang@linux.dev>
 <20260603072657.10868-3-fushuai.wang@linux.dev>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260603072657.10868-3-fushuai.wang@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2201ae-5450-4942-2c29-08dec1fda42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|56012099006|18002099003|22082099003|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	4wtGmnI3rvJ598KtXIfrjC7uaa0XoDbpnEJxHXKD+GHbCo+MVNsoyNbK2B68JNjQjq+iMMjiqpNDIrsU9rpAgxN7Pz1Ns8xahhIhHNGu1yVOwS7ueEHjpsNQmGlLIFWNQjFTPYP90rikOGgx4AQSb8NQupaGRCteDsfatdDNF0cCm71H/ueby7XoU2F1TxGpYWtp+tid/lKCmk02/INDpLZva0jfVaCCFYH5ETG1Pc5SnU+Sx8E7fqkYa/VaBobH3CEcT/t9R3i73uEQotIHYj0gW9HEp1HvlskVvtHFfP/0GPuu1RcCphH7j+hDWhoUF62feDL2mNsm9lly4P1x5Br3VDO3IahlfH7EHEYmvROOknvKDUxWLyaBzOLwHoYeljO/8LDfCd9Yfz5kgG6zRrgDO8Vi4ZLnAP9hKwCKXj385NpB2p//XGiRgXht5avlFTamiBsn/w9vEyGE5A8dCAXCLHjDaGx0qZPFifrE+pqGjnD4IEn1mJXOXdqRXFFh6Epnc73O/nJPByH4OPAjabDpw3IbGe32YQirfMf1ZYPGFZdMzmcHMcm/S67/x/pMRCqzeCzM38Epazi/j1u4F11LnN4Rf0V7UBcIbat0+asVN15oWzEqP/AKMm+PT7VQOgiwblCG1TS5DVPpM41xYe3DiJKa5YAjttVJx8ruT9JWdxMTKaK+ezblanFHLH6ofJNnipaKsTyePoVAm+n20tiVqIrwibQH6/5xrFFTXDP173CojepeazaTGY7KPDaA0EcgAC18dLPvvCsXtnimQw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6XL3R6Zr6ybEdYDu5hzAvzzEaK2BS4yXvQqXzDeBlRGmBpPpc2GHDdg+NNaWAlO4q52ZPALHfyp3m65QDKXz+68IoBdnWB1V32odO/X6hnw3rB22lRUnyxjucKrYWg4RDa2bh2IUIhybgp06FoeHg7OmqY/pgq8syZqJ9k3LcmBR80JTvjAC8pgOud5Pl4dMgSMMTJZaZvAn9/guh+G4ll6ToV8WIjKLcovg6C/YQYd1201UNNfuq3YGGHK81EODhs6KR01QgNlkCv2CONJXR8LUDlVvaseihlWSCTidCTC+unJqbtM7bSw6CBAb5fZ4psI70LxzMCC2UDBoefMqFL/UTpcn9KWr9l/ClbN6eDa3eFTxXot8yLyNMz68/skX0UiygTRxzTV9qJEz2hCkBRfwQYkkRKqsj/hQQG8P3nLojtiJTeJDqTvp7JYkN2D3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 05:53:45.7114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2201ae-5450-4942-2c29-08dec1fda42e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21735-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fushuai.wang@linux.dev,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:parav@nvidia.com,m:moshe@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wangfushuai@baidu.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C21B963D1C6



On 03/06/2026 10:26, Fushuai Wang wrote:
> External email: Use caution opening links or attachments
> 
> 
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> When an SF is created after a CPU has been taken offline, the IRQ pool may
> contain IRQs with affinity masks that include the offline CPU. Since only
> online CPUs should be considered for IRQ placement, cpumask_subset() check
> would fail because the iter_mask contains offline CPUs that are not present
> in req_mask, causing SF creation to fail.

Thank for the patch!

can you please provide a full example? for simplicity, lets say the SF
pool is of size of 2 IRQs.

> 
> Filter the affinity mask to only include online CPUs before checking if it's
> a subset of the requested mask, 

won't this cause the affinity mask to be empty, which is kind of missing
the point of this API... :(
can you check if irq_get_effective_affinity_mask() will solve the issue?

Thanks

> ensuring SF creation succeeds in this scenario.
> 
> Fixes: 061f5b23588a ("net/mlx5: SF, Use all available cpu for setting cpu affinity")
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/irq_affinity.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> index 994fe83da4be..8c0df240b888 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
> @@ -102,18 +102,26 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
>          struct mlx5_irq *iter;
>          int irq_refcount = 0;
>          unsigned long index;
> +       cpumask_var_t tmp;
> 
>          lockdep_assert_held(&pool->lock);
> +
> +       if (!alloc_cpumask_var(&tmp, GFP_ATOMIC))
> +               return NULL;
> +
>          xa_for_each_range(&pool->irqs, index, iter, start, end) {
>                  struct cpumask *iter_mask = mlx5_irq_get_affinity_mask(iter);
>                  int iter_refcount = mlx5_irq_read_locked(iter);
> 
> -               if (!cpumask_subset(iter_mask, req_mask))
> +               cpumask_and(tmp, iter_mask, cpu_online_mask);
> +               if (!cpumask_subset(tmp, req_mask))
>                          /* skip IRQs with a mask which is not subset of req_mask */
>                          continue;
> -               if (iter_refcount < pool->min_threshold)
> +               if (iter_refcount < pool->min_threshold) {
>                          /* If we found an IRQ with less than min_thres, return it */
> +                       free_cpumask_var(tmp);
>                          return iter;
> +               }
>                  if (!irq || iter_refcount < irq_refcount) {
>                          /* In case we won't find an IRQ with less than min_thres,
>                           * keep a pointer to the least used IRQ
> @@ -122,6 +130,8 @@ irq_pool_find_least_loaded(struct mlx5_irq_pool *pool, const struct cpumask *req
>                          irq = iter;
>                  }
>          }
> +
> +       free_cpumask_var(tmp);
>          return irq;
>   }
> 
> --
> 2.36.1
> 


