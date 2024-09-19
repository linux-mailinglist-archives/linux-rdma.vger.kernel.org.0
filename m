Return-Path: <linux-rdma+bounces-5010-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB7C97CD4A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DEFB22910
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Sep 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28CD1A0B08;
	Thu, 19 Sep 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZOOneB0d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C21518C31;
	Thu, 19 Sep 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768130; cv=fail; b=mtyiAkAqoE6i05PNTsCYXZMZrOUwvQp6vf8fJme8yRBXqfAvoxU2sW0ntKv0c4s1fBRfOO6dSaT/FQdhaiSFwdqX+IkawU/MeGd89OrFYRGIPOr87OPhNwZsIpsXCEc0j/rEIwntjSAEeC1j16wcMMi1LUN8ACzuG6xueWNUrNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768130; c=relaxed/simple;
	bh=c4/vU0S1PbeOFq0CCKdCeiAk1uVKVh/VDR7KoN59A1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e7HpwYjwdXawfgnDhHhf2W7X2vG5qehkc6kAdexp/vnkQ9Uq5IF98k8UxMfGRMM5f2cEA1jZKxORak5oeytiUzwJGxu+hl1F3Hy20/oSvE6dJQrgXZVJh9YOfWyoFDU7Fa/86EMYGpz1jTYhm3XsBShhghf89Voew5cvXJzKTEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZOOneB0d; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMwUKzTeRx9BNiCsn/XtlnbYx2CmSKzr5eAZXIMpr2aehYz+mtoo9FUMsLCLYJsqkhYa0czg0n9sEZe+ZiBcOA2uZ5ySTr1QTEAh8Xg5wV+kwpRy86jnYB4ngXO/DUvWDd0tkKE9gzQcr39RLl5VTBIoZwDVtjcMvgPWzjLggQomtduYNtu8m0JsdeaC6Vyv8DOCyf9pLYicegsWoJ8v6yDQgotPerJZ5KvdtN9nlQU994iUgZCnp+rNXUk7HBHJ/b5Uy0PZb1zTB73+OuyI2KKpEDOzj5nDVqdrv3ZiQ3h2kDVQbBP8q0YnD+yV3QGlQefBPjZ5ljeAfa7rgmeM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26dBL0TKcQWwcV4WB6dE1XC+U3Z4guhbzQUFm4Lj3PQ=;
 b=Z2x07NonBeSiBonwj0ifW4pm6fvVjK4nJ2/CoDg1tKz/BA873OZJWlVnxILKsDiEy+n9Qn9JxEQsILtqPe9z2IWO5+erVXpKUyFSfDLP60ajf5uQKStiF5nKUGTLyZGPbsTE8fy+rEiN6iR0OXdO01Vs8CdUMPZ1hjQLZnjKBA0mO2/q26v4HnDFzC1qF9u9eEvdJ5PQgs/ywLAdUjEpNGdLSfTqqg9y8cfHwdPLZoA24xBNKG5lCpZEDhMzKFkEeYJou1MAkYBOzuT2GtA9/rLxdYHD+ciS9kGsEcZnGp+dzp5imnjBmPE+0fL/6Jg94THm0r8nWg47JDjg4YFVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=purestorage.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26dBL0TKcQWwcV4WB6dE1XC+U3Z4guhbzQUFm4Lj3PQ=;
 b=ZOOneB0d3fHHkPN6AmLqHALGvZpMrUmlqG5OC6g5gWNdVTyNIi6HfzvvQXirTOM6CaZLbVXkgEpUse5V+orYhxnWAdrWtSqzINJvJs6YW6bh+s1dJ1cDnTtCSqLkcKrB/B0mRsagzeL6fZdaEOphQCRghFJox7BapseoiNRE2ANC2QX9f3uD7wepowznwUZ0I4FBLFpRzTuI89HY56OxNafC7y6jn9Zs84qUJPjIpfeTmTTnp2dBPnnadrMcQPOLg3UGE43VmsZ2yuEXIj5UmLWkbhSghqpXHUo9aJ1lfMc+Z7o4T9KZquV9EIbQw1ZUiJU1jt8ex2kAC2BxykN56w==
Received: from SN7PR04CA0182.namprd04.prod.outlook.com (2603:10b6:806:126::7)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Thu, 19 Sep
 2024 17:48:45 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::71) by SN7PR04CA0182.outlook.office365.com
 (2603:10b6:806:126::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.26 via Frontend
 Transport; Thu, 19 Sep 2024 17:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 17:48:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Sep
 2024 10:48:29 -0700
Received: from [172.27.52.179] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Sep
 2024 10:48:24 -0700
Message-ID: <0d7deb6e-f12d-4cd9-97f5-2661ddaab25a@nvidia.com>
Date: Thu, 19 Sep 2024 20:48:20 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] net/mlx5: Added cond_resched() to crdump
 collection
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Tariq Toukan
	<tariqt@nvidia.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <yzhong@purestorage.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shay Drori <shayd@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905040249.91241-1-mkhalfella@purestorage.com>
 <20240905040249.91241-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20240905040249.91241-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fcc71d-ace4-4aab-d64f-08dcd8d34eac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzd3eVRDZUs2RXdBTEpTVDkyYXVjVjQ1K3RycWNZYXBWeGxmbHFHSzNhd3do?=
 =?utf-8?B?N1prZ0lGU2VLS2E2WDB1VVNCYUpIdzJEVU1IWmpna2h1Q0NwQVY0cVBvTXcz?=
 =?utf-8?B?VEhNUWFidmduMWl5VXBMaUl1RzZYSFFwNWp4dVdRM1hhdjBnYU9DVVJBc2Zo?=
 =?utf-8?B?dGh5WFpYamUzL0hOUjN0bXJLWDIvWDRUdUpmeDUvaEw2NTBBWnJXQWpITnh5?=
 =?utf-8?B?NElYc2hQMkhaMU1FZ2tGd21ScWJwSjJXeU9DeVV3QmhhMmhUZzhkSGx2OE1y?=
 =?utf-8?B?Qng5R29QcjVEMW9JSERNVEtPYnRNSkhqRVZxaUhqd0lueUJuUlRLc2VjWnRl?=
 =?utf-8?B?Z0MwU2Y4VEx1UEpXdlF2R2RSb0UrUjlTUmRFUlltakI5ay9kRkZBelhpcTFn?=
 =?utf-8?B?S1pRcUcxaHFvbW1yU0VkUEg0WnNkVkZwQVF1SlJrbTRPKzQ0QlJoaHRXZFlQ?=
 =?utf-8?B?L1N0THZ5c1U2eVpyRGdDdjgrbHFZT0xEaVh5YytCbk1sRUt1V2xzZlI2NmZ4?=
 =?utf-8?B?aHpZUktHb054L0E5dUQ0MTN4cnNxYjBSTjRMTWFobUdKNHZ6eHhjeUtNbnNi?=
 =?utf-8?B?Wmt1N0JGYjZXdjZFdnZUdllYbm1JRWpqaXFBakhPT0doWTVNc1NHMGo5S1ds?=
 =?utf-8?B?MTgzUkUzQnRmVG5uTzRDbDZhdXU2Vk5yRTdyK2lSdjZwbDNFRUNGdmRQSVQ3?=
 =?utf-8?B?UjZxV2JQTDFtK1RUdHVacWNPVTJodXBHN09vM25Odi9GSXR4VGJsV0JidDFI?=
 =?utf-8?B?cVJyZmRLSVdwRi9pOU9HK2RaTURiMWtSWDhEYktiMllJMWVRd0hoWFBrZWFa?=
 =?utf-8?B?VUVKK2JoUjN1RUgxWW11THVOTytHSWdDZFpmMnRQK2dLbElaa25NRUhpZTJK?=
 =?utf-8?B?QXRTL2xhMjk0S2JhZ0hPYjBFeGl1V016RnZVcGoraURMWHd3MG1NekVtNUdD?=
 =?utf-8?B?Nk85VmhpRjdwVndjekk4aDl4cmw5RXA5SlQwTXlSRlNDTDJ4eXRJYzZyekJh?=
 =?utf-8?B?c0RFSWRMVjVNZkswc0ZXRXlWeGxGVUFwcUFLYlNSa2VkQTNmeHVGcEhhZmpY?=
 =?utf-8?B?Q1pkemFSekJsRDlwVzliaEIvVDIxWXV4M3ZsVnJVYkNIaGc4YUlaZkYyT0U4?=
 =?utf-8?B?VmI3TVBJeGF4VFlaZlJXWXB6N0Q5WE1LN01MTmNMTEZWajVEN0k2Z000Z2Y1?=
 =?utf-8?B?Z2pwdE01SExIVU45cHM1NUlDMldmVmFTZEdSQ1hCU1BFd1pGRGtyYmVzQ2sz?=
 =?utf-8?B?TFcwTlF4ZDBKUG1GY1VMSmlPUCtTaG5tTWxWRTRrejNjajg4QW9uVGEzOCt1?=
 =?utf-8?B?QXhaZGNueW41RE9MZnlBTFJ0MHNUSUdOM1F1QncvWWJMN0hYbWNwTXFlYjd6?=
 =?utf-8?B?YVdBejhYQnBJQlhoSGZvNGZFa3pYUTJ4ckREdjV0Z1JGRDJPK3RIeHBzbnlE?=
 =?utf-8?B?a01QanJyNkVtNWx0OUVtL1dnK25HWWZRenpteG5ENFlhYjdneWtlN3k4OVAw?=
 =?utf-8?B?bDZSNHVIaWRmdFZEenhEclJQd2xvdHZldzRKMG5GeHI5M0R5eW9RUDJNWHI5?=
 =?utf-8?B?ekpwOWZBaGk0dkZZWXRDQkt0bDNkY0lzQks4c0ZXYnRLYzhFV1BMTi9maFN4?=
 =?utf-8?B?RGJZVDRiOWVOTENqTW12MUIxeGNQQTQ0RUdkVDhtdTVTYzNLbDlvRmYzQ1hx?=
 =?utf-8?B?OStIZXdhTnAzaURQcEluZ1YydzdKK1RsWUtuLzhEVVJIdUNLRk85QXZkT3Yv?=
 =?utf-8?B?djF5R1g3NWR0Yk9WTG80SFlPODE3bXkyV1EvdzlMUVhOOE5ZVDJvTW05N0Z5?=
 =?utf-8?B?c0p1Z3ZqVk1QcjV2KzNCOHRxZ3ZwdkF3QkJaN0J1SmYrZVBIWkplSFpNVTA1?=
 =?utf-8?B?ZVRhdXRiWkxpbnExd3ZDZ3Vub3pubWtWZ3RDaVdxV2VPUGdxUmNsaTZjMkpW?=
 =?utf-8?Q?auZx5xYFiiiRG/Gi4tPhOTZ74YV7eJkj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 17:48:44.8010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fcc71d-ace4-4aab-d64f-08dcd8d34eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932



On 9/5/2024 7:02 AM, Mohamed Khalfella wrote:
> Collecting crdump involves reading vsc registers from pci config space
> of mlx device, which can take long time to complete. This might result
> in starving other threads waiting to run on the cpu.
> 
> Numbers I got from testing ConnectX-5 Ex MCX516A-CDAT in the lab:
> 
> - mlx5_vsc_gw_read_block_fast() was called with length = 1310716.
> - mlx5_vsc_gw_read_fast() reads 4 bytes at a time. It was not used to
>    read the entire 1310716 bytes. It was called 53813 times because
>    there are jumps in read_addr.
> - On average mlx5_vsc_gw_read_fast() took 35284.4ns.
> - In total mlx5_vsc_wait_on_flag() called vsc_read() 54707 times.
>    The average time for each call was 17548.3ns. In some instances
>    vsc_read() was called more than one time when the flag was not set.
>    As expected the thread released the cpu after 16 iterations in
>    mlx5_vsc_wait_on_flag().
> - Total time to read crdump was 35284.4ns * 53813 ~= 1.898s.
> 
> It was seen in the field that crdump can take more than 5 seconds to
> complete. During that time mlx5_vsc_wait_on_flag() did not release the
> cpu because it did not complete 16 iterations. It is believed that pci
> config reads were slow. Adding cond_resched() every 128 register read
> improves the situation. In the common case the, crdump takes ~1.8989s,
> the thread yields the cpu every ~4.51ms. If crdump takes ~5s, the thread
> yields the cpu every ~18.0ms.
> 
> Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")
> Reviewed-by: Yuanyuan Zhong<yzhong@purestorage.com>
> Signed-off-by: Mohamed Khalfella<mkhalfella@purestorage.com>
> ---

Reviewed-by: Moshe Shemesh <moshe@nvidia.com>

