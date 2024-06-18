Return-Path: <linux-rdma+bounces-3254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22D90C370
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 08:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FE21C23309
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F81CD32;
	Tue, 18 Jun 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fvsr/HLe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F37482DA;
	Tue, 18 Jun 2024 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691569; cv=fail; b=eWXBF9O1ovdufPw91N4KvZxg2144kk0ESkcJhioFxanQRWFH2y4RV8S7Lw0W76eNQWViBZDSJ0XowQuK6+Y27ksbPJzW3RhfS4Tde9Xvo0H3EvAtcZy+nfu5ruBS2XzG/24QuXqi8ebhTV5JXbQ7lNda65HONhltkwx77jyJpoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691569; c=relaxed/simple;
	bh=WAgZaRQAOOocxmXXogo3hcoh6gPuoq3xVTF4hW50H8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sZUmhPf4zoZBDxQCjzm2VquLfdVR0j+5qiQiqfbuwRpXMacSUdDlO7lPYcVsV0yKtx2i3CB5Sk20qR5nAtrUdGyiGvAqvWc5CR131kxlTXsbu7vEk8lfwzO+ld5ZuLX0QwB4xS1+QSulUxN3XfGVwm2mBgYQmqlDX5qGFksUeUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fvsr/HLe; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5OeIofrQATaI3Uv/Cy4oDPk/3UB79gLxXUj4HMxqwxlnVhD/v+2D2ODDvPmEUbCAn2BmzkU+Z98zhNeNdcZVrW7Q16/xTEywRbV0aULKnky6ntcnNM5iNT7npSpm/TROD+ssTp0D0IaWXjFXOen1lHI2CazNEB205PVHOsPLpxRiDD8TrPuDkB6gTFlSop1se+Fpf3Zcp+uWZjTrPLtKlVMnNEtbs5aykMZblc5MHkXuMoyy+TVsxIT4nqZTB6TGBvrydOoKlHKg9A2WxHWWqdu48FMSJ55fXOXGfbZ0NvTh/KwNiviTa9mlc5ZWlA43l0JDsysFm0GVmb/jDVW9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29mDQ+FfW74auChyd9b2qgM9TJh8sU/Tg5JfNT6uPOE=;
 b=SWBIQnbYioFyHZivMHR+ZDOGYgtSXS9FVvaPyU8C7Cn78BQLon9yXjhtLmZTzLE/ao0gYvCdJJfwxIv/eiD/d4MuIOH5erhnfiJ+mbhOig3y6XzdyM8TS98uxHKaMJa/H0zn55ZONgWu9Ee//b2Ufsd1mbGrmWDD/nNNgjKjHI2zcsMsDr/TMswW6CAc+/hmaNbZXpNpE6a1ukSXpVpGaoUcBC+h4B9RRu7UwkzsHFP9EgtBzxT2bgqS+7/14bliI3ZVntp9OZwVQgBTIkTL5ElFtOf9/Y+AIEKBKowx/lJAtMYqyFleMFxojcooe/QU5CQH+2TnGWhDTIGubclG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29mDQ+FfW74auChyd9b2qgM9TJh8sU/Tg5JfNT6uPOE=;
 b=Fvsr/HLe6OMR5BUUGh1yBNCTKroDnixehbGUuW5i+5lNt2oQpY2eCi04DqUjxm23fpSthZj50U6vJR7krfkHO6TGLtK4pnRwwMytFzo4vrxqlYvjnPibulfJuq253PCzbZK2CsgL32OPtEM0Gihc0GgDgEhgSVlhy4/Dz4HDi0XMVPoYsviNI2Af8RIlF6Gis012z6T7nx8EAhFTvoLIExe+ngzZaZFbnXR/Hp2uPkHnx5VjT66DMN6gEKg607ALKZmwQ8Ok/0aKoNC4ZEPeGxbbYBRYAcs3bIX0djsbPgVeZCyQowA2xkAnsx5EyKVwnzUtJodqSvookcCkdbCjlw==
Received: from CH0PR03CA0280.namprd03.prod.outlook.com (2603:10b6:610:e6::15)
 by PH8PR12MB6987.namprd12.prod.outlook.com (2603:10b6:510:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 06:19:24 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::a6) by CH0PR03CA0280.outlook.office365.com
 (2603:10b6:610:e6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 06:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 06:19:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 23:19:12 -0700
Received: from [172.27.63.78] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 23:19:07 -0700
Message-ID: <8e33e2db-3f4e-409c-8c8f-bb32431a4bad@nvidia.com>
Date: Tue, 18 Jun 2024 09:19:06 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Greg KH
	<gregkh@linuxfoundation.org>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <david.m.ertman@intel.com>,
	<rafael@kernel.org>, <ira.weiny@intel.com>, <linux-rdma@vger.kernel.org>,
	<leon@kernel.org>, <tariqt@nvidia.com>, Parav Pandit <parav@nvidia.com>
References: <20240613161912.300785-1-shayd@nvidia.com>
 <20240613161912.300785-2-shayd@nvidia.com>
 <2024061306-from-equal-e2fc@gregkh>
 <42af42b6-ccdd-4d0d-8e5a-306c74f330f4@nvidia.com>
 <d51d74da-9a0e-4602-bf6b-fa314a3a7e8b@intel.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <d51d74da-9a0e-4602-bf6b-fa314a3a7e8b@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH8PR12MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: d304b62b-16b8-4852-91ea-08dc8f5e98ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek80eDJKVzJUTkVKMEZURTJreWNoNEZIR0lncDV5dXhHYVpVWFVrclFDUWJJ?=
 =?utf-8?B?aWVKaUU5VDREd3VqQytvcWs5S2NrZXZPbE9LaDZuNXFRQktKN3lFMmhLTCtO?=
 =?utf-8?B?bmNBTzlQRGgrVG1LM0d0VU81Ty80ZDN2aFN0WWZyRm5RK2dxbmhmSXFZRFlx?=
 =?utf-8?B?WS81dmc5Y2haUkR4VUV3TVhNOWNXWVBhV3AzenhhV3BJaEt4Z05BVUt6MXpz?=
 =?utf-8?B?cTcxeCtOQ3NmSFEySTQzaENrdWdyTFFMQWMxcURxZkpicWdLa2JUbFFJT1lU?=
 =?utf-8?B?R3ZjUnFGNzZSV3Foa3lkNzFCY3FPY2VCclF6bTRmekR1VUFOZTZtVVFSQ3Y2?=
 =?utf-8?B?YUFRdXBXSHZHTVd0T3dlRzVFbFRjVS9pZGxidXhKNUxEVUZvSEVIeWJQUlpC?=
 =?utf-8?B?aGoyYmFMMHR5NWR0RUZuMTdneUVZbzZBdWpSRll5dU43U25VeGdrY3BWMHkw?=
 =?utf-8?B?VlhqZk54QmJBajUrek5uUmRheEkxUnlUYnJ2N3dCRXN1c011b0NmM3hFQ0hs?=
 =?utf-8?B?dzF1QU82RC9OWWQvZjB6QTZrNFZvRXB1eEoyN1dSQU5na2dNUkdTVk1vUnB4?=
 =?utf-8?B?RkdiT2wyb0lYWFZFeTNnejVqcDJNS0dZdkYrcWlvSVpSMklUMXFtQVo5YW5v?=
 =?utf-8?B?bHpTT3dEUXRRUDBZN3c0eS84M1pST1lQM3liRWhGckNnbUE3NW5XdCtmWmpq?=
 =?utf-8?B?TjI3aVlsbFJCMGNrQUVETmFwem96TkNZaTFDZkpweEUyRmFQcitmRVZxVUFN?=
 =?utf-8?B?amJiWUMvT0VOKzZ2YkFPd0EwVlVIcWRjWHBDTnNHUXo0U2xxOTJnZ2h3OVRa?=
 =?utf-8?B?b09yR0ozVXBNWkxhaGQvMnNYY1FtOHN6ZWIzOWRSNFNvRUFicXRjK3dMQTNK?=
 =?utf-8?B?K21ybGE1T2VPWHY3Ny8xbjRVK1FvMlh6amhkNWh4NWM1L09sYmRnaU8zODR5?=
 =?utf-8?B?Q0twa3M4RGxIMU16Z2RxSFlnQnJvaGx2SVRQT3VhVGZGNXR4RVpPWktGVnI1?=
 =?utf-8?B?YVl3MFQvNy90YmRrZXN1OWpJeDNZVDNvd3VzdVowMkNuUHB2WmQ0NjVES2J6?=
 =?utf-8?B?UnRrWjYraVJHWEVWSXFXSkkvdG5kT21kckpLUUQ4azA3cjRzNFNOdXh1VE0w?=
 =?utf-8?B?aVFlbi84UDRwaWpxQm15Tk4zdFZ6Yi8wOU5sMUNxSzl4UzIydmVpRmtVa09r?=
 =?utf-8?B?MFArYURHU0duR3UvdDErR1ZoNHE3ZXU4b0hvL1BnbzY4YW9rTE1ESFlSd0ZY?=
 =?utf-8?B?d0FOS29lREp2NnprVHJxb2VXT1c2S1Q1bnVWM0h4RTNQMURNWnN3MmNKeU5T?=
 =?utf-8?B?Y2FQUU05dzlRcFF4U093SUlCWlZOVTdUdk13bkdoSnMwMTNjYUFUYTZFSjNS?=
 =?utf-8?B?bFBHL2JvdElwalErWTdSZHJCTko1NkQxL05WQXhVTEtsdlBzRVlDTjhJdDRJ?=
 =?utf-8?B?VGNBZlNabG80dW0zYS8xTjV0ODdXd0VOZU9HYWdvZFlJL0dac0p4UkxJNStL?=
 =?utf-8?B?Z3FraWUxN0VRQUc5ck1aSUwrY2pNTGpwNXFVeVBJUEwrODVLVVZ0WVhHaTJP?=
 =?utf-8?B?R1U3NXF2ZjNkb1RLSWNrZDBQUElFUFRtN2E5RzZYbVBKMDc5N1dSMU42VnM0?=
 =?utf-8?B?SCt4NzVQb2owcFRRT0hIbTJSME0vT3JRcUNoamc5RjZTQXRBUlMzdU0xMjNm?=
 =?utf-8?B?SEl0WkZWL0h0R2VROXRQN1o0U3pJMEwwRGpwZDNxQ25wMmIrV0E2U0FNVmF1?=
 =?utf-8?B?VTZyNUZXSzdSMXEvc2Y3RWZib0Q0T0J5UUpIR3V4SDN2SkRGRTQ0SFk3S0JD?=
 =?utf-8?B?alh4NXdQWEJtemJjQm9vdW4ydFI3OXJrNk8wa3NJQXBkVGNiS01UOTNaTU1F?=
 =?utf-8?B?Uk1tUnE1cElpeTJDWEgyMXAydzBGQnBqQWZWa2dsS1BuNXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 06:19:23.5101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d304b62b-16b8-4852-91ea-08dc8f5e98ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6987



On 17/06/2024 12:52, Przemek Kitszel wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 6/17/24 08:38, Shay Drori wrote:
>>
>>
>> On 13/06/2024 19:33, Greg KH wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, Jun 13, 2024 at 07:19:11PM +0300, Shay Drory wrote:
>>>> PCI subfunctions (SF) are anchored on the auxiliary bus. PCI physical
>>>> and virtual functions are anchored on the PCI bus. The irq information
>>>> of each such function is visible to users via sysfs directory 
>>>> "msi_irqs"
>>>> containing files for each irq entry. However, for PCI SFs such
>>>> information is unavailable. Due to this users have no visibility on 
>>>> IRQs
>>>> used by the SFs.
>>>> Secondly, an SF can be multi function device supporting rdma, netdevice
>>>> and more. Without irq information at the bus level, the user is unable
>>>> to view or use the affinity of the SF IRQs.
>>>>
>>>> Hence to match to the equivalent PCI PFs and VFs, add "irqs" directory,
>>>> for supporting auxiliary devices, containing file for each irq entry.
>>>>
>>>> For example:
>>>> $ ls /sys/bus/auxiliary/devices/mlx5_core.sf.1/irqs/
>>>> 50  51  52  53  54  55  56  57  58
>>>>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> Signed-off-by: Shay Drory <shayd@nvidia.com>
>>>>
>>>> ---
>>>> v5-v6:
>>>> - removed concept of shared and exclusive and hence global xarray 
>>>> (Greg)
>>>> v4-v5:
>>>> - restore global mutex and replace refcount_t with simple integer 
>>>> (Greg)
>>>> v3->4:
>>>> - remove global mutex (Przemek)
>>>> v2->v3:
>>>> - fix function declaration in case SYSFS isn't defined
>>>> v1->v2:
>>>> - move #ifdefs from drivers/base/auxiliary.c to
>>>>    include/linux/auxiliary_bus.h (Greg)
>>>> - use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL (Greg)
>>>> - Fix kzalloc(ref) to kzalloc(*ref) (Simon)
>>>> - Add return description in auxiliary_device_sysfs_irq_add() kdoc
>>>> (Simon)
>>>> - Fix auxiliary_irq_mode_show doc (kernel test boot)
>>>> ---
>>>>   Documentation/ABI/testing/sysfs-bus-auxiliary |  7 ++
>>>>   drivers/base/auxiliary.c                      | 96 
>>>> ++++++++++++++++++-
>>>>   include/linux/auxiliary_bus.h                 | 24 ++++-
>>>>   3 files changed, 124 insertions(+), 3 deletions(-)
>>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-auxiliary
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-auxiliary
>>>> b/Documentation/ABI/testing/sysfs-bus-auxiliary
>>>> new file mode 100644
>>>> index 000000000000..e8752c2354bc
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-auxiliary
>>>> @@ -0,0 +1,7 @@
>>>> +What:                /sys/bus/auxiliary/devices/.../irqs/
>>>> +Date:                April, 2024
>>>> +Contact:     Shay Drory <shayd@nvidia.com>
>>>> +Description:
>>>> +             The /sys/devices/.../irqs directory contains a variable
>>>> set of
>>>> +             files, with each file is named as irq number similar to
>>>> PCI PF
>>>> +             or VF's irq number located in msi_irqs directory.
>>>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>>>> index d3a2c40c2f12..fcd7dbf20f88 100644
>>>> --- a/drivers/base/auxiliary.c
>>>> +++ b/drivers/base/auxiliary.c
>>>> @@ -158,6 +158,94 @@
>>>>    *   };
>>>>    */
>>>>
>>>> +#ifdef CONFIG_SYSFS
>>>
>>> People really build boxes without sysfs?  Ok :(
>>>
>>> But if so, why not move this to a whole new file?  That would make it
>>> simpler to maintain.
>>
>> sounds good. Will move them to new sysfs.c
> 
> your proposed name combined with the directory would suggest that this
> is base sysfs for drivers - drivers/base/sysfs.c
> please add aux_ prefix, or similar


correct, Thanks for the suggestion.


> 
>>
>>>
>>>> +struct auxiliary_irq_info {
>>>> +     struct device_attribute sysfs_attr;
>>>> +};
>>>> +
>>>> +static struct attribute *auxiliary_irq_attrs[] = {
>>>> +     NULL
>>>> +};
>>>> +
>>>> +static const struct attribute_group auxiliary_irqs_group = {
>>>> +     .name = "irqs",
>>>> +     .attrs = auxiliary_irq_attrs,
>>>> +};
>>>> +
>>>> +static const struct attribute_group *auxiliary_irqs_groups[] = {
>>>> +     &auxiliary_irqs_group,
>>>> +     NULL
>>>> +};
>>>> +
>>>> +/**
>>>> + * auxiliary_device_sysfs_irq_add - add a sysfs entry for the given 
>>>> IRQ
>>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>>> + * @irq: The associated interrupt number.
>>>> + *
>>>> + * This function should be called after auxiliary device have
>>>> successfully
>>>> + * received the irq.
>>>> + *
>>>> + * Return: zero on success or an error code on failure.
>>>> + */
>>>> +int auxiliary_device_sysfs_irq_add(struct auxiliary_device *auxdev,
>>>> int irq)
>>>> +{
>>>> +     struct device *dev = &auxdev->dev;
>>>> +     struct auxiliary_irq_info *info;
>>>> +     int ret;
>>>> +
>>>> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
>>>> +     if (!info)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     sysfs_attr_init(&info->sysfs_attr.attr);
>>>> +     info->sysfs_attr.attr.name = kasprintf(GFP_KERNEL, "%d", irq);
>>>> +     if (!info->sysfs_attr.attr.name) {
>>>> +             ret = -ENOMEM;
>>>> +             goto name_err;
>>>> +     }
>>>> +
>>>> +     ret = xa_insert(&auxdev->irqs, irq, info, GFP_KERNEL);
>>>> +     if (ret)
>>>> +             goto auxdev_xa_err;
>>>> +
>>>> +     ret = sysfs_add_file_to_group(&dev->kobj, &info->sysfs_attr.attr,
>>>> +                                   auxiliary_irqs_group.name);
>>>
>>> Dynamic attributes are rough, because:
>>
>> Your response after "because" is missing.
>> Can you please elaborate?
> 
> you have "complicated" (compared to "nothing" for static attrs)
> unwinding/error path


Dynamic attributes are needed since the number of IRQs per SF is
dynamic,  one SF can have 10 IRQs and another can have 15 IRQs.
In addition, SF is requesting the IRQs on demand, when the SF net-device
is opening its channels for example.


> 
>>
>>>
>>>
>>>> +     if (ret)
>>>> +             goto sysfs_add_err;
>>>> +
>>>> +     return 0;
>>>> +
>>>> +sysfs_add_err:
>>>> +     xa_erase(&auxdev->irqs, irq);
>>>> +auxdev_xa_err:
>>>> +     kfree(info->sysfs_attr.attr.name);
>>>> +name_err:
>>>> +     kfree(info);
>>>> +     return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_add);
>>>> +
>>>> +/**
>>>> + * auxiliary_device_sysfs_irq_remove - remove a sysfs entry for the
>>>> given IRQ
>>>> + * @auxdev: auxiliary bus device to add the sysfs entry.
>>>> + * @irq: the IRQ to remove.
>>>> + *
>>>> + * This function should be called to remove an IRQ sysfs entry.
>>>> + */
>>>> +void auxiliary_device_sysfs_irq_remove(struct auxiliary_device
>>>> *auxdev, int irq)
>>>> +{
>>>> +     struct auxiliary_irq_info *info = xa_load(&auxdev->irqs, irq);
>>>> +     struct device *dev = &auxdev->dev;
>>>> +
>>>> +     sysfs_remove_file_from_group(&dev->kobj, &info->sysfs_attr.attr,
>>>> +                                  auxiliary_irqs_group.name);
>>>> +     xa_erase(&auxdev->irqs, irq);
>>>> +     kfree(info->sysfs_attr.attr.name);
>>>> +     kfree(info);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(auxiliary_device_sysfs_irq_remove);
>>>
>>> What is forcing you to remove the irqs after a device is removed from
>>> the system?
>>
>> We are removing the irqs _before_ removing the device.
>> Irqs removal is following the exact mirror of add flow.
>>
>>>
>>> Why not just remove them all automatically?  Why would you ever want to
>>> remove them after they were added, will they ever actually change over
>>> the lifespan of a device?
>>
>> IRQs of the SFs are allocated and removed when the resources are
>> created.
>> for example, devlink reload flow that re-initialize the whole device by
>> releasing and re-allocating new set of IRQs.
>> Certain driver internal health recovery flow can also trigger similar
>> re-initialize.
> 
> I read it as "removing all is what we use 'remove-one' for",
> I'm correct?
> 


I am not sure what you meant here.
what I wanted to say is that SF is requesting and freeing the IRQs one
by one and not in bulk.


>>
>>>
>>>>   int auxiliary_device_init(struct auxiliary_device *auxdev);
>>>> -int __auxiliary_device_add(struct auxiliary_device *auxdev, const
>>>> char *modname);
>>>> -#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev,
>>>> KBUILD_MODNAME)
>>>> +int __auxiliary_device_add(struct auxiliary_device *auxdev, const
>>>> char *modname,
>>>> +                        bool irqs_sysfs_enable);
>>>> +#define auxiliary_device_add(auxdev) __auxiliary_device_add(auxdev,
>>>> KBUILD_MODNAME, false)
>>>> +#define auxiliary_device_add_with_irqs(auxdev) \
>>>> +     __auxiliary_device_add(auxdev, KBUILD_MODNAME, true)
>>>
>>> Ick, no, that way lies madness.
>>>
>>> Just keep the original function:
>>>          auxiliary_device_add()
>>> as is.
>>>
>>> Then, if someone DOES call auxiliary_device_sysfs_irq_add() then add the
>>> irq directory and file as needed then.
>>>
>>> That way no "norml" paths are messed up and over time, we don't keep
>>> having an explosion of combinations of function calls to create an aux
>>> device (as we all know, this is NOT going to be the last feature ever
>>> added to them...)
>>
>> Thanks for the suggestion, will change in next version.
>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>
> 

