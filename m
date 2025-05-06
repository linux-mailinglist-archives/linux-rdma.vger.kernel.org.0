Return-Path: <linux-rdma+bounces-10108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B939AACE8D
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 22:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00D61BC22DF
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 20:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454A154C15;
	Tue,  6 May 2025 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyF75l/5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA73D3B8;
	Tue,  6 May 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561774; cv=fail; b=ZCIYptCprAhheZ6Mz5xasPcN25fsBpdftqjdNHLdYMghbEvvrCCf0mjRPi2+HrHx1RUqbc6F95xSHNhbY+PGB4yrsftsq9O2YYZHJOLrhCLipjtkKY5HYlc+4fOMic25HJ9JM0SyWAPLuHiSv+xPbNQ/EBxfYExfKbcBqzabNE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561774; c=relaxed/simple;
	bh=MjLWPfSvUCMobGj0Tcuyas9RmbQpbqe1IiDBpgtJIUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FKNpS3Ryz9caG+fLcRV3phvISHt9sSnBqY7pMO7FAwL4NPJwKQ/Xy573EfXbmFNv0DlQhV3gtGIQRr1kWYLwsi2OXf/PmrANRBOyXbwoVPfRxyKo8tMpY+kgS/NPCS3PmYVb17nMwRVdhmcTJSRPgRnfNjnTA+73tCCrGtQKyHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyF75l/5; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8dkoop895gUVXsU2IM7ekZy7xPFG/HyQsRmzzfqmGIemzVkLTPJ1lMGZ5paqc5oP5oKX3sy+STHxfcSoTgapxf8T/AqEPpY0cjscttVrKm3O/htSZzA8OOtKjCeSTIl61RlerWoSlqN+l8QJ5d3LzS/BrDqQ9daAlbiIOs+vZeGlArxeRvZ6AjnTgv+En8BYo+4ga5Obc9PFNscxJqtxl/6ojrYCh4Lb9r2QibW3rLQ2lIhkZyQrCKng3o+MExxfrUitaoOlehc7SEq9zAGcsGqTIVlVytwzUg1nnr1SRO2drDCmVUlEsYgW1VgbiFl+KHtkzBV6QM07H4c6POZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkng1EAz8eloMmcSFwqVmXe1aWl3q0aVEJtjoWu4Eeo=;
 b=MR4/kyOAZat9oZVFHhbuzTxyc3gwR87oGp2q/0XdK8I28OfsppMwwaGBv+FWi6KhgMTq62ukr1ljB6y8M1F2HCIrXJ9JLCuIjyFxO6i3T6h/BmP+BWa3XxLXRA6JHRpy95+Xll4r3+7nQWkugR10q18mAM/Yv97IAzIG33Dsve12AoW3kcXfrCuxFEbDlajzhU/XNA0eHfm2k6tOPxEbmuQVAXzexec0SmBV6Nt6V7t3yXCfLKrIrT3DH3yjVAuxqsVQWfyofl4bjCn/DdOEw8a9zbNpFYUiPq0NDtijG9zC5880fc4VKOlsz4rgNvj3r+0Mu/ZQyxbpL39n7pPgFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=wunner.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkng1EAz8eloMmcSFwqVmXe1aWl3q0aVEJtjoWu4Eeo=;
 b=TyF75l/5XSJoq8L7TM7dE62dGXYgW23EvurBUXJ3htMw03sAObyuleJLYiYAmyXdGbvsF2LfcwD/OGKm5RM9lDRScpYul9IUFA8afWeJNdCkj5ZEdkr/cISyjbyntRVxNdhecFHkr8Bp7J/YyHYcL11Y40P+aOiSmqA2LP6MyNLT1nQLthPuFuQISrI71CVaBnJ5wAe9F7SKKwRAeUYTrywFpueE6hdp/6sfVWv7OOi8YXkxGyGI2QfNRirBftPFbI+Xj87h9R74TqmyMrRKeHrtjTpKKHjUByK69eKer+DZt1s0EFCzXZ95eXtJElumOQpTQNEnjRSltcv+FuHa+g==
Received: from SN7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::7)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 20:02:45 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::e7) by SN7P220CA0002.outlook.office365.com
 (2603:10b6:806:123::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 20:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 20:02:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 13:02:31 -0700
Received: from [172.27.33.235] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 6 May
 2025 13:02:20 -0700
Message-ID: <6687db3a-33b2-4982-b65a-c6ecea130cc3@nvidia.com>
Date: Tue, 6 May 2025 23:02:18 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/16] net/mlx5: Handle sync reset now event
To: Lukas Wunner <lukas@wunner.de>, Moshe Shemesh <moshe@mellanox.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <linux-rdma@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1602050457-21700-1-git-send-email-moshe@mellanox.com>
 <1602050457-21700-10-git-send-email-moshe@mellanox.com>
 <Z-g6pzpZu_TU0-nA@wunner.de>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <Z-g6pzpZu_TU0-nA@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 499ea63c-49ee-43ef-d17c-08dd8cd8f696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODdxRDEreFZSTEZ4NVdTdWd2Rnp1d29aZVBlN3QrMEJ0SnVVM3BzNUpJb3ZI?=
 =?utf-8?B?WVdneldYM1BkWmJPLytncGE0YXcwMWZkdHZoMmxOQnJDcHA0UnBhZ0hOYnBF?=
 =?utf-8?B?TGliQUo5ZFZESlF5MlFTY2M1bzRGd1F2dTZLdVB6K09VOG9WOFVobytmVFJw?=
 =?utf-8?B?cGRrUzdIMEFlTkVSMk9KMjlxV1l4YmdXdXNHOHhiOG15ZFltZTBZUmZ3SjlU?=
 =?utf-8?B?dkkwMFNwSzlrWG5hNXNpTldqMDFwVjh1TzJrZkRWL2JIY2xwUWErSHlvblow?=
 =?utf-8?B?cy9jMGkwTWJta3QvekYxQzVJTFU3K09pRWZRcUdjR2ppZklCZFdQdklwN3Ix?=
 =?utf-8?B?dEFiT1FGLzUwZjlwckdudllrbVU0a2poVHVqQ3VoVkZ3d2tab3RnVDlEMjN4?=
 =?utf-8?B?Q3B3aEh1VFdIV0hqNXJ5dTh6a1VCVHArL3Q4TWptdUg2Z1pFZFFXcjBuTEk2?=
 =?utf-8?B?Qk5WSkxBaUV3cHkzb2FhTWF6Z2dqbkNWNWZsU2hWZ3JTQXkyWkhSc2JUWTFt?=
 =?utf-8?B?MDlMRkRuOU5uQUdtN2Y3c3JtRG5vRTc4ODJtVlhOMzN3U294eVdRdG9mNml2?=
 =?utf-8?B?cFpGNmo5MHJPeE9SZUJoM21yRkVES0U3K1FuOVRxbUJldEtZdjErZ0hRbGoy?=
 =?utf-8?B?QklYSXZnSUJxVHhhS1FtQ1phdDZEKzB5VWowZlFLYUlLbmExQ21kbDluM2NQ?=
 =?utf-8?B?bjNwSEpsbGJpN0pFbTJYTEtvK2xqdndNT0tkUm9SQk1HN215Y2M4UXdwblJF?=
 =?utf-8?B?TStxRGc2c3NNcVlPMnRCVld5T1JPblNqQUJoU0NmMUpMcDNsbmFKSERHQ2Vw?=
 =?utf-8?B?bHp5UWdic0pzNXRONndoSUJibTMrVFFURmNaVlV0LzBFZjRxeFlEWXl1K0ww?=
 =?utf-8?B?NnBsVDNmMDZQUnNJTVgzTjZpazlPTFB3aGJBc3RZM29WdmxwU0ZYOXVVWnNx?=
 =?utf-8?B?c1l0Ti96azZPQ1p2aHRIUUU2SEJTMmFFcGY1U3dkdXd4UTFlRFFjQXFGd1FI?=
 =?utf-8?B?NDFVdXJ5M0E5SXhmQzlzSFdWanhzb3hXWjNYelVKOS9SWlZYRE5FQWhxdWw2?=
 =?utf-8?B?aDNwQWI2UlJtSFdYWnVUUHcvMWdkdkNBTE9NMG5aZk1xdVJQVTFWNzl5TW9u?=
 =?utf-8?B?cjFRY3FtdVlZeWRxODFBc1BOYzBwVXN6N2JyKzQzQWJiaGlOTW01aEdmN2Zj?=
 =?utf-8?B?LzdtSUtlWnJjSUxXS3I3dnNPTEhtTDJ4cEZDY2Y4L1phZFZCa1IwT1BJOWVs?=
 =?utf-8?B?M3NFYTk5ZVlCVTJZdm5EcVk3STdXMDFqSzJCazRUYW9hRmw5djZOdVplNnNy?=
 =?utf-8?B?eC9Xb0dINWZPQTRjYjE5OVYwMkxlb2JzQXJqdXVwbmdGN1NzaGNabTJKYWJP?=
 =?utf-8?B?OUpMTnBiZXBvMVBHUE5kbFphcGUzNENvdTBlZVh2UVQxZkhlNXI2M3Jta0hQ?=
 =?utf-8?B?UVJJcWxWMWRZTEpPeTBDRVZJL3ZMN2doczIrSFVkR3RPQVpGcHNJRVhGMTd3?=
 =?utf-8?B?dDdiYXFEZDc2UGlxQ3RjZEVjTTlNV0tPZjFLSXdtdUtyVStPWXVOd0gvYkFX?=
 =?utf-8?B?Z1QxQldYUmpYaHhaMXd4eXEyeUNmNURyNmxaaHA4cXVGaU5IV1BUNzhtT2Rt?=
 =?utf-8?B?MXdJVFJiTWtqaGFRWTlpK3NrNGRtZEtieGFUbmt0cXp3MzV2Z3ZHOXlsUk1D?=
 =?utf-8?B?MHhoMmduNHlZbTQ3TlRab3hFUW84NGMyeVRYcXpKN1lwam0wdzZxTmYxaFc4?=
 =?utf-8?B?Z2E3eHYwLytBNk51ZGZkRXlqYjZxcDc4S0NDcjZzcW94WEZmZ2ZEeXBJWWtW?=
 =?utf-8?B?VW1LVEY3enN2Qldxcm5JQkN2T3BHQlp6MnhhSVR2bmEwOGhMV3NIaHFMQjFa?=
 =?utf-8?B?cEUvV0VIa0RnY2U5U3J1UFFRbFVFQXdpSnZ0NFBiamwvaXZRSEVsQVRPR0hv?=
 =?utf-8?B?RFAwK3FvYW5SS2dURmozVWZBM2tGWVR6c3BFbVljamdrUk90OFRRN1kxc3NK?=
 =?utf-8?B?bFBuYXUrT0xMYkVwN2hnZVhqOFNhU1Q2Sk1KWDFNZ1NWWHAvaGVlOTJNY1Rv?=
 =?utf-8?Q?xC2HSu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 20:02:43.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499ea63c-49ee-43ef-d17c-08dd8cd8f696
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294



On 3/29/2025 9:23 PM, Lukas Wunner wrote:
> 
> The following was applied as commit eabe8e5e88f5 ("net/mlx5: Handle
> sync reset now event").
> 
> It does some questionable things (from a PCI perspective), so allow
> me to ask for details:
> 
> On Wed, Oct 07, 2020 at 09:00:50AM +0300, Moshe Shemesh wrote:
>> On sync_reset_now event the driver does reload and PCI link toggle to
>> activate firmware upgrade reset. When the firmware sends this event it
>> syncs the event on all PFs, so all PFs will do PCI link toggle at once.
>> To do PCI link toggle, the driver ensures that no other device ID under
>> the same bridge by checking that all the PF functions under the same PCI
>> bridge have same device ID. If no other device it uses PCI bridge link
>> control to turn link down and up.
> [...]
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
>> @@ -156,6 +157,120 @@ static void mlx5_sync_reset_request_event(struct work_struct *work)
>>                mlx5_core_warn(dev, "PCI Sync FW Update Reset Ack. Device reset is expected.\n");
>>   }
>>
>> +#define MLX5_PCI_LINK_UP_TIMEOUT 2000
>> +
>> +static int mlx5_pci_link_toggle(struct mlx5_core_dev *dev)
>> +{
>> +     struct pci_bus *bridge_bus = dev->pdev->bus;
>> +     struct pci_dev *bridge = bridge_bus->self;
>> +     u16 reg16, dev_id, sdev_id;
>> +     unsigned long timeout;
>> +     struct pci_dev *sdev;
>> +     int cap, err;
>> +     u32 reg32;
>> +
>> +     /* Check that all functions under the pci bridge are PFs of
>> +      * this device otherwise fail this function.
>> +      */
>> +     err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
>> +     if (err)
>> +             return err;
>> +     list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
>> +             err = pci_read_config_word(sdev, PCI_DEVICE_ID, &sdev_id);
>> +             if (err)
>> +                     return err;
>> +             if (sdev_id != dev_id)
>> +                     return -EPERM;
>> +     }
>> +
>> +     cap = pci_find_capability(bridge, PCI_CAP_ID_EXP);
>> +     if (!cap)
>> +             return -EOPNOTSUPP;
>> +
>> +     list_for_each_entry(sdev, &bridge_bus->devices, bus_list) {
>> +             pci_save_state(sdev);
>> +             pci_cfg_access_lock(sdev);
>> +     }
>> +     /* PCI link toggle */
>> +     err = pci_read_config_word(bridge, cap + PCI_EXP_LNKCTL, &reg16);
>> +     if (err)
>> +             return err;
>> +     reg16 |= PCI_EXP_LNKCTL_LD;
>> +     err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
>> +     if (err)
>> +             return err;
>> +     msleep(500);
>> +     reg16 &= ~PCI_EXP_LNKCTL_LD;
>> +     err = pci_write_config_word(bridge, cap + PCI_EXP_LNKCTL, reg16);
>> +     if (err)
>> +             return err;
> 
Sorry for late response.
> The commit message doesn't state the reason why you're toggling
> the Link Disable bit.
> 
> It propagates a Hot Reset down the hierarchy, so perhaps that's
> the reason you're doing this?
> 
> If it is, why didn't you just use one of the existing library calls
> such as pci_reset_bus(bridge)?

We need PCI link down on all the device functions (can be 2 or even 4) 
for full chip reset, to activate new FW. The hot reset by 
pci_reset_bus() has the link down only for 2 ms, not enough for sync 
reset on all functions with pci link down for new FW load and boot.
> 
> Thanks,
> 
> Lukas


