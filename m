Return-Path: <linux-rdma+bounces-19557-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGu5OQTt7WnkowAAu9opvQ
	(envelope-from <linux-rdma+bounces-19557-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:46:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EC4696D7
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 12:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625D03014646
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44E2FE05B;
	Sun, 26 Apr 2026 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIgQscCJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8F914A4F0;
	Sun, 26 Apr 2026 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200381; cv=fail; b=lfeMj13UxyK/qxHkbbzGDlCbY0QojHQ/dymjNxticjjisSu3hkpKz67DHjh0ufbBZceZbLcVkdeSadHBHQ87dbhJaEuACZ19F8S/Rk55vKxbvg8XpHUCSBLUghTROEHm0X4y0g8IHD08nruMUzNHOO0r/YNlGM1TKN684oRVVGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200381; c=relaxed/simple;
	bh=ONyzqwe64KV3alS2HpcITT8/tcfyExCSAHd/QjaYYVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZtCZ4cZjyA1x1utN242MB2Ke6yspbtDy9JWxYr6i3sjU8zIhJqe15/ZR6O8mWA6TqeI69ozLqpjli1juxdgA9ldGWY1/eEn/TX0Jbsgk8sNoSDWrtH8qLlY4ASup4cepXfclP6twDiIuiKnQI6c9leSfy83YouaRoj59Nqov9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIgQscCJ; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFT99RORWOEz3O7fyU9gMNLOb5KKr9kpTlFOalEdJAoAkH7jvb07nghqFUHwjRcl5vuISbhChyMNcb7OJJGnuuwoWbmUR/Y6iJvj5NWzdcUnHYqyZ4mgn6BuqB8Gtew0WN2W8kicakmtOiJ3HJoAuHgyriMO8yv3QPFH/69oWkiL4ugRWyxqBhbILbHcfBwGqD4roXb8sn2DowjXCbdB7tNPBBakjix5dkbHuh1SANBj2BGzHx9OTxkYEPLPOaeWFAuz+RFWbsY3fdd6JdFtJLYjOfETgHK2OcJhYeDBBkQCkfGszSAlbv0pU62EtzlvwTn0SCZ9ugmYRNYutjFTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LxHZQ0WHf4NkGWpnXHXERYvYQQLArgEjFugr7+JyEo=;
 b=gh+eDezLqbIel9zAlddidkvIYNrg1jZRK5EkyWKAD/du950owd2Fg6WJKOqnUEsSRdEqyNjf87tJ+Qzg4YcApNf6qGOgABsw4BgoNU+ZPjxtGlYNneqMjNFStrRo2SsC/myIv8UZb6VssKisEhApPJDKej+PcY8jQFQAPkj+r1oPRjf8KQ7/Qn0k9RqhUjF1CHjE6+2sBgQ5SJgNVKlWg/hdQy9vX+3BGvQ/GQlPN/SAJLBC4cQ9A8CRx6uIhNVbOWtVIVcYuVpyWabNjFx6p5ySInY5Tqs6g5vJC4U3CLa6jQea2BQe2dwHUwQk/VVn7VnyanxwPetdfPEu4nF61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LxHZQ0WHf4NkGWpnXHXERYvYQQLArgEjFugr7+JyEo=;
 b=gIgQscCJbwqlJb2MmNJBubde+GfekdTlMVfTOOcGqcT5egIST6Wg4whYlHx5NNok7kdHLMexzTH3Ts2rC5iMmTTlxPAY5eZgIAGgmQsT/qlzjxwWxx2JhFTjQf4rbbhxQbCDbSBooXxtVfeUpDRKjXit8o/h6ic8FbyLmnIOelw452k7djiFze+wOKKb1jEPsUVaelW7Ud5nu+FYD8SX753eZLZ03cbdgYt6/YHYSR0HFdUwhsfPuRahioeeCbLMijnICt8ZE3M2lA7zzHrrFZGz55MJESqjuB6ZZnOKLi0mrZsmvYpx9L3It/qhQhxd5cMbv/lV3rljLzeUG5CLww==
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 10:46:11 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::36) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.25 via Frontend Transport; Sun,
 26 Apr 2026 10:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Sun, 26 Apr 2026 10:46:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 03:45:57 -0700
Received: from [10.221.206.176] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 03:45:51 -0700
Message-ID: <1e048f26-d295-47ec-8aab-42ee0b34d892@nvidia.com>
Date: Sun, 26 Apr 2026 13:45:48 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V3 3/4] net/mlx5e: SD, Fix missing cleanup on
 probe/resume error
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Simon Horman <horms@kernel.org>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Gal Pressman <gal@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>
References: <20260423123104.201552-1-tariqt@nvidia.com>
 <20260423123104.201552-4-tariqt@nvidia.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20260423123104.201552-4-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8a2387-8467-4941-d057-08dea3810826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PUqUx23ttcQ8u7JqfmfnqIbYn23bB++pz1BfMFO8Dnb1fD872vQzDs84HUcnc540K0xiUNcKL/mOXoNtKGmBxrmlMw1DDTujW+gWgW2oD3UQhbbG/GzSOo1kV5eTJpqxW4Kt5+/LgLiuhR1+4fnoHRXnMjlbNC6230ne3y87cVmhGMPxQeTy/Ng1qeeaid3K0VPkTuswOvw3wHlzbgnwyR82m0v2xs5GQA1cw3sCuexlqLhiJYx5iHz9amUARTaVMr5tAZFtEJrpCLCh2Bs5xrN8e/rf9qmmUPbXSbFueZSSzEW+2VPgL96zAagbPAD9Y3Q7G0inX97Jeb6xoW4Di7W/NVc9LdHuDkJYpc9WDGGLAg2IG39zTBAHiQd3WSJ/Y7f9YGGxxgT5av7xjX8WCoG1gDcxrxA7sNj4XMUYtrExz/7d8cGVzTlujB2l/0nReEIONHB2D3I1v630BUsY4Ku7vs/K90mn6ZBALCVxycr3M/7a6XG7CoA8OAy44oLX/7Fc+290aqHA+mVzrJVYhbiPizvve4qLnSYiyZ/1QqrcqY+XpFVEVmvHx7BcVGxlAhyJP5qwkyenlWvUuWHrypdvqxfNBZOVpgvg8lUpwKHuEYMXdN8zq8hhpa+kOdi/WaCXm3kZ/foKnwrueMO21aU0ZxVB0Qti1rG4e+Yst9Rc/sy7I9fu0MKpw0K/4d5nzflO4i6FdXY6d/T7KFocnv83gOSsFBx3Qv5rAlhuKR+wcMP+4hIhBdMU7Z4rURZcs3FdgsaaL6Ih20QVjJFBzA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pP3owzy6gM7K0AF0UPna2ny65m3LeOLy/mq3X1befD0A9Smj1116w3/lvDLTUB/z8a3vEgycIaUl6QfiXDsbzrbZdpIgVjk5Vzk9jefmA/f+0zOsFpU714ybY/1eUy2v8Qk52z9+JVnVCK+b5zP/GjG6k8JNDL3mg+lI3NZBboAVx9APYwNGuNCdBdt21ykzZ5w0cSxd2lWIG0ZA4PrB2GyfmwKZMIhunyPhp0WuA4jhm9pMzeBykJ3ZvuQDWP8q0DNjEmK7iFo0k3NguPDxzwDuxNPHFo4Fgi31d/IU+RwcV453r/9touyybZ304Onh/XaxBuaEgZwxCfh6cWiXc/BKBdh3lbaTK6Qhvn+Y6FMwX/dhHkLKcLJM2J5EsjylYQzkCmURGAA3p16+n9gPMgvMT3Dfs7fOqrt9SLBrGTZkcJGooTQyUO6uAECe4RCf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 10:46:11.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8a2387-8467-4941-d057-08dea3810826
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Rspamd-Queue-Id: 8F7EC4696D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19557-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shayd@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]



On 23/04/2026 15:31, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> When _mlx5e_probe() or _mlx5e_resume() fails, the preceding
> successful mlx5_sd_init() is not undone, leaving the SD group in an
> UP state without a matching cleanup.
> 
> Call mlx5_sd_cleanup() on the error path so the SD state is reset.
> 
> Fixes: 381978d28317 ("net/mlx5e: Create single netdev per SD group")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 22 +++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index 5a46870c4b74..9c340ad2fe09 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -6774,9 +6774,16 @@ static int mlx5e_resume(struct auxiliary_device *adev)
>   		return err;
>   
>   	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_resume(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_resume(actual_adev);
> +		if (err)
> +			goto sd_cleanup;
> +	}
>   	return 0;
> +
> +sd_cleanup:
> +	mlx5_sd_cleanup(mdev);
> +	return err;
>   }

Sashiko:
"If _mlx5e_resume() fails when called from a secondary device's 
mlx5e_resume(),
mlx5_sd_cleanup() is called on the secondary device. This frees the sd 
struct
and marks the devcom group as not ready.
Since this is a resume failure, the secondary device remains bound to the
driver. Later, when the driver is unbound, mlx5e_remove() is invoked on the
secondary device.
Could this result in a NULL pointer dereference?
When mlx5e_remove() calls mlx5_sd_get_adev(), it returns the secondary adev
itself because the sd struct was already freed:
mlx5_sd_get_adev() {
	...
	if (!sd)
		return adev;
	...
}
This leads to _mlx5e_remove() being erroneously called on the secondary
device. Inside _mlx5e_remove(), auxiliary_get_drvdata() is called.
Because drvdata is only set on the primary device during probe, this
returns NULL. Dereferencing mlx5e_dev->netdev would then cause a kernel
panic."

That is correct. In next version mlx5_sd_cleanup() won't be called in
mlx5e_resume(), and the commit message will elaborate to explain the
different handling between probe and resume.

>   
>   static int _mlx5e_suspend(struct auxiliary_device *adev, bool pre_netdev_reg)
> @@ -6912,9 +6919,16 @@ static int mlx5e_probe(struct auxiliary_device *adev,
>   		return err;
>   
>   	actual_adev = mlx5_sd_get_adev(mdev, adev, edev->idx);
> -	if (actual_adev)
> -		return _mlx5e_probe(actual_adev);
> +	if (actual_adev) {
> +		err = _mlx5e_probe(actual_adev);
> +		if (err)
> +			goto sd_cleanup;
> +	}
>   	return 0;
> +
> +sd_cleanup:
> +	mlx5_sd_cleanup(mdev);
> +	return err;
>   }
>   
>   static void _mlx5e_remove(struct auxiliary_device *adev)


