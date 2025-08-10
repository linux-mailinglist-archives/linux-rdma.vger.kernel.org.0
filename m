Return-Path: <linux-rdma+bounces-12639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D964DB1F9CE
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45AE1765F5
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40DB242D9B;
	Sun, 10 Aug 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlqX8+t5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F005614884C;
	Sun, 10 Aug 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754826754; cv=fail; b=jypMF29Fs1rClsYLzH3wRmlFb71iLt5WVE0lpNKGCms9+veFBbdHm1PweDhrm/8m5tIPo8ZH5iqxVGedH0YfbmUfemmVm8j0j/feoaoSVThRrcfAxZVnE7MraO7V1WIe6IwCfHszUAwuf3ZXLJO6jeyDOTHo9WgRJjVuN740v1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754826754; c=relaxed/simple;
	bh=ppzyAsLtXQt92LcMDQF5tHbFO1OSL/HU6Dfwj6jlzz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=btAXAFRtedHoPqR7momKjDOB/jrnEiizj7ycImMmBymuAvwRn+KBC0WzAtG+HaUgARlIH2qpooodX+WSKHMFQoAUm6bf+uJX3cIJ9AWqL9B/id2q7FCHpPu6D3MqczBnBbfIrllUNveGWMY9Sk4TXnqm3NvnDQTeJTBi8jviTKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlqX8+t5; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nA4c8zrdG0TPDWuIqEpdLa2vLYZv4fZU65qUl9RVtvDgPwxGolEIGkcAZXhmyIqrHrh/TfJa45bwwGbd2/OmnAmh2zeR+6OFV2SPsEV/JjbbPON3BYDgYhKn4P0NFdCXgWiPKJoaABZbHQVAqwdI95dHVTnGEEQJS6kyC/+fmIoKGrlezInBRUD6qcUq+B/UW/r2XQnej7p4XI8CPSAlrQ/zz6gVPDGhEbPQzV0sofNIN7dlGDgYOaxTResStaaDl5ostJvLKKGpm0ALydY6zwv0VYgTXbSQVbuUWIOl/weKkwea98sMgaNWAu2jnbEbZb0epfZf3JnPryJL/H0MKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDi9Lz5dG6wtHTiQmjH0uieRMeE23dISRZKS+sjjyHE=;
 b=SMrBJ0WpCa01CpdAA4mNVgQA/pWZFncOKJy6WdQNqWsigTHoKNAx1+849Vmb9bYczSTidpR2HP9RR66w/xYGSnIr66p+AhqZb/c7OY5UjIHBtfGYsBuYlRqtVzQwo2KAEjCAZaxmUE32czAw8Wca+/4YGoe/m6h4n1eHI2gJTy/7Kd5S+pGPdWBJSiLrvbJG2HiodwV00cXUNkREOYaQsB0sRN9PH/Z4eRP2AqyvO4jUkH59LTkJF9AeiT3/T8c/xSusPgQgoJ53Xe2jQoKVCJCh4L9IGGIIe4kghHr3xlc9vDpSOoGjHwMJNHFagIKssBilynx1OHqFJvnuGcnfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDi9Lz5dG6wtHTiQmjH0uieRMeE23dISRZKS+sjjyHE=;
 b=VlqX8+t5ybnkP/BYnoJ2bufoPeG4TFkIPZTONg15vteMLQFPVHmWnJGdrIJ7q2ToSZ3GkxElkfOZIVj+9IwhmdcNAzfR3SIWKwfgOih7+BQqtY3P/gebluzF85FM39eLodCWDuZxHUeoerEqtBZO+Ihx31xXzB5806ZGrgCGY8acNKWalj/uaEdV/wPNHKzdyJ8mlVPhxhKee6VbcfpqUGpmWHvQd+gc8Ho4SEUXLkkiIEyaDYhK3SbAwIvhOEzjxV+bbLHNJmbs/KSJ0H34UN1Bx1kb7dPbowb9CWsggWFHfVkoscWsm+6uCCLoe0eELjeiJTnn7z9H1zOMbZUO9A==
Received: from CH0PR04CA0094.namprd04.prod.outlook.com (2603:10b6:610:75::9)
 by DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sun, 10 Aug
 2025 11:52:29 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::a) by CH0PR04CA0094.outlook.office365.com
 (2603:10b6:610:75::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.20 via Frontend Transport; Sun,
 10 Aug 2025 11:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 11:52:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 04:52:16 -0700
Received: from [172.27.19.226] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 04:52:10 -0700
Message-ID: <44d0f39d-890e-446b-a2a1-3d52e2592a95@nvidia.com>
Date: Sun, 10 Aug 2025 14:51:04 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Avoid deadlock between PCI error recovery
 and health reporter
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Moshe Shemesh <moshe@nvidia.com>
CC: Niklas Schnelle <schnelle@linux.ibm.com>, Alexandra Winter
	<wintera@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Yuanyuan
 Zhong" <yzhong@purestorage.com>, Mohamed Khalfella
	<mkhalfella@purestorage.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250807131130.4056349-1-gbayer@linux.ibm.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20250807131130.4056349-1-gbayer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: f9220373-fbae-4191-40cc-08ddd80461da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akdVL0hLNnVJSjRCdWJyanF3ajlGdDVna0xLTXFsdXJodm82S3gwSVl2NUo3?=
 =?utf-8?B?cndhT0MxdnlvQ1hWakhZb09WakhpTis4NGxKTlpXSHlRbTBlMERwRDBXY3dV?=
 =?utf-8?B?UGRmUVZMbjl5TzJyV29iL0lXeGh4dnBhWjNQTjA2K2NiZkl5eWRNY0tUdk5M?=
 =?utf-8?B?YjhyYXpHZmxxc1NlSTQwYkYrTnpxc0VQdTRZdTA4TnV3a29JV2lwbHdFK3RH?=
 =?utf-8?B?T3RvczJKVnN3T3VFNCswcnpjNDgrSEhYVzFvbjhaeFVsZ2RmK1Y3blZ0cVpj?=
 =?utf-8?B?TWFZQ24wMDEweDdKWFkxZ3RCQ2FoVDZEdmdpNzRDNnltVTg1WFhDTEJtZjBa?=
 =?utf-8?B?akE5dUdpSGFwQU9qbnA0SEFSL3BPaEdKN0VuWFlhLzZtY2VOMzAwd1VXVTVw?=
 =?utf-8?B?SHFLSGdLdlZWVnM1V2FtWG5qY2hiazRiblA5N1owZ05DZlc5ODlYdlJmNVlh?=
 =?utf-8?B?Mlk3OXQ0R0xLV2FTQUhpdkMrbkFWSDE2dWh2bisxaW1XRmR3L2hNeXZhV090?=
 =?utf-8?B?ZFdqdC9RcGxzZC8rTUZQcnE2cmlHdVRxWlZwWWRtTXoyQWc1U3Era1QrcUQw?=
 =?utf-8?B?d0NVYkNYaUpJNTlBbXphOFZRNXdqUllzcHhmVStYQW5FRnRhV3Z2SkJZd0Yw?=
 =?utf-8?B?RW9EU3Z0WDJZRTNNUmxxZFVSUWYwUEpGMWMvdEYwZGRkMXRmRDN5YnVLQ3hU?=
 =?utf-8?B?S2JzYTJ4TTExTFoxMmJvc2s0TzBORHZPWHF3VUFSdE1lVVZQTzNFNVViazJB?=
 =?utf-8?B?RFVhaUlpdHhtYTk0SE5Pa1BzdSt1RHpBcmdsdkNaN2ZIMlA3eUdtZzV2dGpx?=
 =?utf-8?B?MnBWdk1DN2VPcmlqeHBkd0MzNnVmc2E3ZjltUWF6MEQzOExiRzR5bjdZQjMw?=
 =?utf-8?B?dEFTRm5LV3FEUGhJdlJ2Nno3YTNaa1dLbDYvTXFaOUE3R1NXL2I1SWhVdXpT?=
 =?utf-8?B?VWpXKzh5Z0lPN1kyVDVCWlMvbXBvYW9PYWNPWS90L0xyT0xMeDlGVjdGUTVl?=
 =?utf-8?B?amhLYVJOZVFKMG9zd0h6aU5BYmdiTmp5M20xdCtHT1hSc2x5TnNrT2dUMlp5?=
 =?utf-8?B?bmR5U0pvWnpxMFhaWGZ2QjNKM205WWFrUENQM1o2U2ZYYlAzdXVySmY2UTNj?=
 =?utf-8?B?eTNBL3ZiTnN0OWxGV2FZM0I5Z05SLy8wdXRnRCs1V0owanAzSVJEWHl4Sm5R?=
 =?utf-8?B?aHBZdFAwRWdubzRub053b09xQThPRVdwQWU3NFVHQkEzaHpBcjJ6TmZvOEtT?=
 =?utf-8?B?bXZQWHpJd1hiSmJWbXhPUXh4QmZLOGhzK3IvZVBPQ3d4bHVWdEhhRjVuNTYx?=
 =?utf-8?B?SzdXdDJod0ZQSGxBeFFsVkVpNklHUUVmS0grMW01T1YrbWlvbGdOWUFRVVYw?=
 =?utf-8?B?cEtYdUU2b2gzTXl1RW5lMStJaXpYcWVqOHh4OGtqT0FZK2IzZUJQSFFnTnlG?=
 =?utf-8?B?Z0xOdUN6RlNaUk5aVUREZEowM3FIWnhOcExrZTY1d2JzemswdkZHYWhZeGhE?=
 =?utf-8?B?L01wQzB1MFJlOEJxQlFyZDYzUXYxTkRRUWk3YmNBazVQQ1Z6NFhsbFNTb3R5?=
 =?utf-8?B?Wnh0NmZNbkhRZnQzNTBpeHdXZTA3YUtuTk5QVi9FWnhsdFBGa0QzNHN0MFFY?=
 =?utf-8?B?RTFpTEg1a3pYTWt3Uzh5TGNQTTF2Z2tZRWZYT2haNFRqOG5MckN6Yy9oVWRz?=
 =?utf-8?B?a2xQWjRXdlZNSmF0b0dUMGJRbHlzM0VaUzRnd2xjQjR3ajJFNDRoYWFvMzQ4?=
 =?utf-8?B?aTdiMDF6UXd6cmVmMDYwUXJMblliZERGUU4rSVl6eXJIOGx0SlhNZnRIYXAw?=
 =?utf-8?B?by9hRFp3aW9MSTBJSzZ5WVBTSDVjcUxDOGFqNXliTkF2cTB3T1phNVFHcUpQ?=
 =?utf-8?B?eklMbWR2NGtFYzI1WWtMWGIwUUZMMFJ0WFZGNEJYNGxlODRHaVpMUlg2S2JE?=
 =?utf-8?B?RC9mSkJrZHQxU2NGY2RNN1o1UGhIN21CMXlMNzFVNlBmQmEwbGtQcUM5L3dG?=
 =?utf-8?B?TmNWc1Q3YVdpT0ptZG8vK1ZYUFV4bmxjRTFKckdlTDNmU0llZmN3b3g0MFc5?=
 =?utf-8?Q?LqfFcf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 11:52:28.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9220373-fbae-4191-40cc-08ddd80461da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422


On 07/08/2025 16:11, Gerd Bayer wrote:
> External email: Use caution opening links or attachments
> 
> 
> During error recovery testing a pair of tasks was reported to be hung
> due to a dead-lock situation:
> 
> - mlx5_unload_one() trying to acquire devlink lock while the PCI error
>    recovery code had acquired the pci_cfg_access_lock().

could you please add traces here?
I looked at the code and didn't see where pci_cfg_access_lock() is
taken...

Thanks!

> - mlx5_crdump_collect() trying to acquire the pci_cfg_access_lock()
>    while devlink_health_report() had acquired the devlink lock.>
> Move the check for pci_channel_offline prior to acquiring the
> pci_cfg_access_lock in mlx5_vsc_gw_lock since collecting the crdump will
> fail anyhow while PCI error recovery is running.
> 
> Fixes: 33afbfcc105a ("net/mlx5: Stop waiting for PCI if pci channel is offline")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> 
> Hi all,
> 
> while the initial hit was recorded during "random" testing, where PCI
> error recovery and poll_health() tripped almost simultaneously, I found
> a way to reproduce a very similar hang at will on s390:
> 
> Inject a PCI error recovery event on a Physical Function <BDF> with
>    zpcictl --reset-fw <BDF>
> 
> then request a crdump with
>    devlink health dump show pci/<BDF> reporter fw_fatal
> 
> With the patch applied I didn't get the hang but kernel logs showed:
> [  792.885743] mlx5_core 000a:00:00.0: mlx5_crdump_collect:51:(pid 1415): crdump: failed to lock vsc gw err -13
> 
> and the crdump request ended with:
> kernel answers: Permission denied
> 
> Thanks, Gerd
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> index 432c98f2626d..d2d3b57a57d5 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
> @@ -73,16 +73,15 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
>          u32 lock_val;
>          int ret;
> 
> +       if (pci_channel_offline(dev->pdev))
> +               return -EACCES;
> +
>          pci_cfg_access_lock(dev->pdev);
>          do {
>                  if (retries > VSC_MAX_RETRIES) {
>                          ret = -EBUSY;
>                          goto pci_unlock;
>                  }
> -               if (pci_channel_offline(dev->pdev)) {
> -                       ret = -EACCES;
> -                       goto pci_unlock;
> -               }
> 
>                  /* Check if semaphore is already locked */
>                  ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
> --
> 2.48.1
> 


