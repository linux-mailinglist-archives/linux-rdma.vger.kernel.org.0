Return-Path: <linux-rdma+bounces-2023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E381F8AEA18
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 17:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF521C2204E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73113BC19;
	Tue, 23 Apr 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aWr34/cW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483AF13BADD;
	Tue, 23 Apr 2024 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884602; cv=fail; b=rlWfvt3yvNo4cDGNixf3WqNtt4BwakZn3X+Usuplvzppa+P6nuwTVLxjbigKQ3MFMLWsNYFZRghT6tAQUu0IWPqZRPwdBikbpzpD9CC99gLa5chR142sSri1OlN12CINhZvHhmb4aD1wMIbwifn1XhBizFY+QHTXbPl3hRE3f58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884602; c=relaxed/simple;
	bh=+a45vB54BTu3mlxsEpw4/NqoBEE+tm6qUccuEiTxoyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TIDpKHWCwyup3Q1HUD71fxEkB3VIjq8KmPkBOo6//MB0eZRwmpsGlstTcfYdDAKLmYqDRfnDXpvi7t6EWmqs9UeMnn310cnMf0UuQrnsiZfFjpTYgy4ltgmwjy0b3KL82zSYj81ehksjybVOaecs4kD1PLucBLMVNmb3YBZ0USc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aWr34/cW; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6K2t4bEwbT1VlJUhTBaAalzqmv3a0XuBxVm118aM1aWSshFM2bjswYnGVFLERpiH8rxAn3u0FuIZUDpQVABrYIh5HIUFGEhRQfrUzvBT1WWgX7tsN3gir3Wq4nfP/Z8oHaB3Wu4WNvR48wsWqdrcKu7Hb/V40rGjA6WwWtmfcBR5MXe4AcSVf8dqCpvHMElBI040dP9n4r8bxPcKVjfrmqPA6VYjYx44tiTvLCYa/bHh+WFML0KM/r0gE+7BWhOqmapDG2lNwfHPc2JnqzkroMibN2aE6n1VygU6ETwpAnXPdOcc+7uSzdnVaYHvavi3+FzqFMtiE/luZPwW/UuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECheSrA1Xj0S3IqwN5PhssXKfuaf82e4I6he5Kdvydk=;
 b=iMjAhzPMftQMaCpcuiNV9Y89DGR5UgZBEJJrN2dz6ra9d7L+RKrXxct1mKVhXpWwF4wETOzzBf0vdCGoPiPVxf5J8q33wLU4Tjfwvr/NfiLvzMTjOggXafpKwIt4A5zL3iiY3w8bqyPuFpJfVEZ3IGD1Kkt/+jB3MnplSfz9yJ8SNcl3PJ6k90p1xaSmi9NLZDYfogshPMNOR9yJoB/PZwVuT+FnZx4sx1VGccBRNBcuezE5+pemQw3Vmt5CWcEnzo4ZxTNrywF0/ZqwkNEudGJkFiE5I907odp8/9lZcgcdJbMHwVCoXv0XVeFY9Hc5ELXZRnhfaftNIG5qI2OGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECheSrA1Xj0S3IqwN5PhssXKfuaf82e4I6he5Kdvydk=;
 b=aWr34/cW6cJlNwOVwWDZ6AFlam2S5+i1UM6AcR9slMlvkTb1nVlKtuSJkVRwiibyKGPsoYV5WKdZrWlHdQYUBYxdgf8HXnQ54Ta7rDpy1gWiCTw1j33tcTIHXCs2jfU0hTDdmgdgGtaC+QeujN7JMbmFu7OyncFAEB3HfMsYsBx0siS1ZM6UIL8T3ezQdbyk5EbTYLAtmZ8CyN7vbQnhAPYVya1pmmMGZPVC41LU6o14UCA+zBpdb40Zql7JkzV1/jSjMhoKotV2wAiNRRrbppO8EzAfTF8P2l1igyASeBa//TrExevIDhUbK7SjDpVW/A6rXGEgJPidWRLZGZkLTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:03:17 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 15:03:17 +0000
Date: Tue, 23 Apr 2024 12:03:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: nathan@kernel.org, kotaranov@microsoft.com, sharmaajay@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: fix missing ret value
Message-ID: <20240423150315.GA891022@nvidia.com>
References: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713881751-21621-1-git-send-email-kotaranov@linux.microsoft.com>
X-ClientProxiedBy: SA9PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:806:27::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 890ca73e-cc6c-43a2-8858-08dc63a6816f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8a7ifqmRF/UOnTbmO1wJrFZCoPb2EvcW22zJSXEAmB1mjAiDGIqDygEsvRo?=
 =?us-ascii?Q?MDKVX2FaRSADu2DoMskmKIz/ozNFpLKKBLPylkLM1uXK2EgEzDYVozkCpeYI?=
 =?us-ascii?Q?YfFzusXzDK+EYn6tx133QzPSHqsua2lGbhroOQN+DMCwAJg7pP2vEZ/zMc5s?=
 =?us-ascii?Q?JAPhyl4XNqK8c+LVxyQ2d5kDffwTQJ0s4vefXdj9OvK6kOqRy/zx4X9LQM/A?=
 =?us-ascii?Q?eTwLj9zxr93VSBxXLCQBmDHCvTuwfqmwm2WoA9mGDHBrR+SdVf9I+ZS4AsQG?=
 =?us-ascii?Q?u9jIUfI/1p/6rW/FpE861QE5nKUUkBSRuJRT4HfyF3MbYaSHELGRBKSeOoGz?=
 =?us-ascii?Q?utq59YNFm+kPvJqXcZLUkThiBrFRnU25EAuRFUrnU3Gu1jiXvGQjSdyHveQa?=
 =?us-ascii?Q?hJjhmzGZFEO6wB46E6BjU39q0ecor+ZCW4G/0oie4RsMFGVmLW+4CizvffWL?=
 =?us-ascii?Q?RR4hNEdZZvg+jJWxlGH3KgSf6na1hiA8cpaOnpN3IaDp8Tqjyk1MB0GmavGX?=
 =?us-ascii?Q?p9yMZM6LqbqUiuQlu7kBX6hrDnxODqD962ZOlhlq08MvQDAISmIdKJslb4hW?=
 =?us-ascii?Q?Qyrb0n0O1LzRLoKuVtw559g0AXHCVDxrN9XMG2EsL89G6+Zu2izdfvfGqqCq?=
 =?us-ascii?Q?sAPAh+68X0PQZjMtgrQQ5t8FTZPSjV3UphKP5Vf6PX6RxvRDrq1kRznEpR69?=
 =?us-ascii?Q?41aUg5zs1RY5MT8NWRq0IDoez6WHysshgL1k9o6KY5iueYo8ESaLo9kZoSHa?=
 =?us-ascii?Q?Gn+oTos3+kDEMXzAVtJ1rXvayBgsWf7aNfcEG9oJAVVGc20nu23W0KvDEeOh?=
 =?us-ascii?Q?QJN1qY9Avvt/C9XXVKcprNwsyxMINQ5wwnDYy3wY3ZtfVgryekdIr40Zvce2?=
 =?us-ascii?Q?fk/IOam4V5ORb1waRtqdpEf8FXpb6Hcq0lVBveSrw5xBB+tFbi57L+cjGFs2?=
 =?us-ascii?Q?0qCjVj+PZBBeIgwTryrsjhY+psTa9g1euawORHClKP6xFnET7U8mmNqmMy9e?=
 =?us-ascii?Q?0NoSlbJfgJKsyNF3pXy47jcDnqAK33jqXRW1qXbRnmFPVpE9G21x60vQDsqC?=
 =?us-ascii?Q?U7iWrPpA0t2g0yR5Y14VRKIcLIqZ7Eb94pTeataFxet+F2/CDv/P7SnsOJPF?=
 =?us-ascii?Q?UM0AFbbFM0g5dPQe+6kEK7+WBHgOdQ6plBSRxJ3j4Bc4DVOVTEnpod3wNlJj?=
 =?us-ascii?Q?3VQ+inyx1bt9xN/edS9ANAVInPBj9wR/CoaWCeIgbPFrWJOuD4C4eTUYvph4?=
 =?us-ascii?Q?XV5CliiidVS/yYwfdv4zbcD+WviZ2cdaRcb/AlKhsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVN+P5LZrHZplTepGhnNlNlZqQUONKmlJXfU5JRFX8HaXAsn0pV/ej4w9/8V?=
 =?us-ascii?Q?MuD0+ZuHnK94M2iU+7JcJ+6OMbCfev8oZQZ9QmmwobN1x2kqF7HMfY/uPEid?=
 =?us-ascii?Q?ZWuU9pJNeg7X2wJDsmqr0XlNeAqQxScwJxS/rk6bx16kycOSy4hLtGPVQFqa?=
 =?us-ascii?Q?cwXrRpaMePpEVRQtO3U5UTjvXJVoBy6s87pJJnJuvIqrhvpaHNWUIQgzCL+H?=
 =?us-ascii?Q?u4ddk4mdADWdD1t0LboKZ5HeMpEbKITRGpIXWN91OiG7E/mcleba4cjHLcyD?=
 =?us-ascii?Q?KV71TKDoF+V3zw02AYCzD/Dz8kHBz6BB8qkYdd8ME0J83i1WXd1lLJrRqJuc?=
 =?us-ascii?Q?lhMstbCo6OhaKByDtOwLLS0XOpPJwp0iDvrvnthGPGP3/mjFLhDrMU2mLPqR?=
 =?us-ascii?Q?st0Hi0T/WeSSsltvbCKU54VdFtctpfl0ngu737LW1sHBHIUKxZ2RCh2dTiEy?=
 =?us-ascii?Q?c+B/T5oZW1aJ3V/miTwsaQxJ/X1qgscOeYlB66dwnC7/zl4e0xvyVbsLirIs?=
 =?us-ascii?Q?KRLfXV6iwsFeCU3pGH6gwLYI7UCs7LCrWU6VtKwa8YyQ/QybLVAXx5IDTqtX?=
 =?us-ascii?Q?bSIyVocfQbu7RmxzVwNqinfCmL8RaTzHYFGMJiW+zJG4nCwKI217zJJZ7I8O?=
 =?us-ascii?Q?CNT5uqGlmLyzxI3r70MouuMX8j2U4jupPekQzYxXGgVsSmK9LcgNpn2miNFY?=
 =?us-ascii?Q?EgTy5JQ3+vtVto5CvjDaEaFCmoLazMdNRVNApWzC4OwQOHu7/y+aOTvHve6q?=
 =?us-ascii?Q?QH9U+tJ/pAAuoI2hKXuu6xSMKznQdoS88O770EHGVao7wa7PEub3esyeqlVG?=
 =?us-ascii?Q?UW/MQQGV4sWezylIGKPbn/MM470DtFlUSuS/Gl0GbCF+OGR2C8YMcIb+a1hI?=
 =?us-ascii?Q?660H/5yWg+3IF/EfAonyOyvxpsTW70FFJzsw0fnQyQSOOJpD1YuIqNrelYOU?=
 =?us-ascii?Q?INzzgPXEwHN8uXTdOKlh3bfVl+UJmQ6/W9jM8Kona3CMQ9/LA1kWcKlKaMkP?=
 =?us-ascii?Q?ARoeHtr673HQQfM37O8B5DXnl+HtP6tL4gCSVXu2+AtzWKRaMFFi09ydDuvT?=
 =?us-ascii?Q?4cfCeb+U0KJUqWdRQAR+5Ke4Cu3tbPredWbYetSsMpINyovZTtbIX5Nfox9b?=
 =?us-ascii?Q?XJPbIpx6I4Rm0dJ6MMBzccwPb6eSj5qVnYIhTJtOHOYGagnu2OxF/zXGZCiv?=
 =?us-ascii?Q?/TzK0yLkoF0CZKtcGP9AR9d6dBIjegI2cFrKYyFHnZmsOfP1DCzc97QFK+JR?=
 =?us-ascii?Q?K1GHcTTYZ75WWekD1Lsz77B7fl3i+hiqaund1XIDuXD0JasjNGIr1MmRkhyv?=
 =?us-ascii?Q?ZE1O6RiLnEhLXQKGxPLk0kg7Ssj76FNA4iYHUadTqJU2475zBddWW9UKeiec?=
 =?us-ascii?Q?HntAngWX0aIdDYeKoxYRPcrdMTYLF0gSzw6BWYT5w5t7Im1Sq0VMLcSQ4ML1?=
 =?us-ascii?Q?jjzgzTfCcUyfjkad/KWYBjluVRxf5zcvwLXHktUxFh/OpydSRJWC3vbyAcJt?=
 =?us-ascii?Q?yfE9aq1eZxKFNkRD81NtpeZ8GUD6wPinntFlaVFvowVS0Xr7gkoOQ/ArVXvk?=
 =?us-ascii?Q?4oeoalTuH9maAOHxVnY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890ca73e-cc6c-43a2-8858-08dc63a6816f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:03:17.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0sv2ulTZZduy5dKsIpkobqepr9AopiixHFg60+HIF0ac6JKOjmuU9390zz5GZ5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

On Tue, Apr 23, 2024 at 07:15:51AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Set ret to -ENODEV when netdev_master_upper_dev_get_rcu
> returns NULL.
> 
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason

