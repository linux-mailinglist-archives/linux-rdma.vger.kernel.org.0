Return-Path: <linux-rdma+bounces-14235-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BC8C2FE59
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 09:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9443F3B8478
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC731196A;
	Tue,  4 Nov 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJjsZ3sd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CC3112D3;
	Tue,  4 Nov 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244892; cv=fail; b=b0dO8G2euvzrpwV7aWWW8YCFGzyNz+w6hIFH3gANe7LWM0ZmejxTT0yNlU0yC1U2VRQE6qnEJx0li8fi5uctEQ2QmYGHbFH+6z55qD1Ho1Pp3iATkeVy/OiTvPrQ/4kTt+KvMS2FnwjxraRFO38bzzSu1h+oANoQvfbtvJdWuWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244892; c=relaxed/simple;
	bh=wIZ+se4XThP6oQLFaCxUk+Ynx4TTXLdV52VCm0MlYtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lQKUoEUVuINW3b1P8+65SG02xQKvU6hj5sHRxiRBZLW9sACr82JrDTXi3PB6veQ7bwHAM/VEw6dqdFDK+1Aku7U0WMHaMj1b4naiZegUix28Scomvu4K0xHDUxNzgwuaUqVy13s47P1A1lXq/K3rkzTAibqBCmuWrYdoWQOcsnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJjsZ3sd; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRdyxQTjdA0Fiwagw9DEOWt8PhlWxRzbeh+cOC83QGr9aEvDBGz7lViQefxVJ0m6L4KJplY2bbw5nkal3qlphA1dMBCC4qTrJjSTqWfyKd9ryIZM2Q2xJti+qsRE8QxpokcjfT8xmKq+WxfcxD0DfPY32QkVx05wvRiR3XL6Svxisb9zU76my4PT34+3W2DNUVtXF93GNKtFPnt0qgevsIxMzqrx5GtBe6pEfZnF4Au8LTvJjzxobaCgK0sPckN9mvN4oaJVSGtVsyZldv4jcaw7pq45F1e29vfCOaNnZr+fDuQ9+zU1Ei/j4mZncn2wZArLhXOmzr22MvkF39U1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHSNfBydgSeGNWmOPzpHP+vW+w/SvP4tIK28akpNLOY=;
 b=owj1nmOJs+SWDBQ7fey1FdjckK0U5aKMsUjXW29D5C7IQyfU6LMVn+HAKMk1WY7EjpAy77XWrZnfTgiBY0kDPwBUHqZ5wzreeNVl8poAf6Wo9f3z2q+MgtOE7S3QRm2m65i0Fa6/ef+JBvlO5FfRxjMNO5LWBOjzNKpOrT4uDGxAXJYodc7Cuo99THHX1Skae92WeCQYJxZIbU7WE4qMJ3/2825i1O6Ezz5THRFe/qhmxMoBxHQK81CLwmEwIp0EJzxCuDiK/0lMV0z72c7Mk3+T6NA0FyNTTwTWXnymMIZnTIa6V7BZgDbN2aNgFLKrLU1INM84WJOfPPnrxwnexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHSNfBydgSeGNWmOPzpHP+vW+w/SvP4tIK28akpNLOY=;
 b=fJjsZ3sdoUKvy51h+JFMo9EYhizXz6IsmPu8W3NAlXs/PLCrSic92PR+WZhebnWq9TcZT0kNW70RK75tLz7YwL2Cf2PM6+d6WMlYI6t6s1b2h0cVaQK+y1MPAUuMpO/0gtWLz9QXN1SKwGg0A4bLskiBHRdTe2JDh19y8ocWcTflF8yziVIs7+tmGNr4ptXS7fDNL+qn5eXfXlNadkhZ8G5svRYdp1+U9ILJPnJsLnyCgU6VHnPtp1iS/viFXaS++iQG1qU5pSoKHG8KE5/rWsnC4I2A41ToluwqUw2mRAR3tsJNhZ5vHMllP4+tRQzrpaZFSOCkq34wOq291OPnkg==
Received: from CH0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:610:e7::21)
 by PH7PR12MB6933.namprd12.prod.outlook.com (2603:10b6:510:1b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 08:28:06 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::b6) by CH0PR03CA0226.outlook.office365.com
 (2603:10b6:610:e7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 08:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 08:28:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 00:27:52 -0800
Received: from [10.221.224.195] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 00:27:44 -0800
Message-ID: <be552e0e-164b-49c0-b1ea-d35d4c64e3d9@nvidia.com>
Date: Tue, 4 Nov 2025 10:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Edward Srouji
	<edwards@nvidia.com>
References: <20251103172830.GA1811635@bhelgaas>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20251103172830.GA1811635@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: f4169202-1a8f-4115-44bd-08de1b7c13e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUlTc2tFcFdSdjZGQ2EyYS9oNm1iOWRlT2FGVDB6aXJHajBIYUt0WGw3Yk42?=
 =?utf-8?B?S3hQRnZNakN5SFZrZW5OZVl3UDhQL09nTmxEQllNNFlxek1RbXptcEFGRHZj?=
 =?utf-8?B?djhuRVEzZmNYZEpESmNWL1ZkaEhJNXFPaFkyTE5xU3hGTWhnaTdYWHV3a2VM?=
 =?utf-8?B?RWhtTWdvZWZxUUZpUzBUVno1Q0FRZGY1amZwYkxybXlMTi83MHhiRGhNV2pk?=
 =?utf-8?B?NUxjSUVJYU9pdllTZUcyeG81R3orMlYzY1l2TFI5ckZtVks3RnpiVElSOU9Z?=
 =?utf-8?B?SGV3UGFIWm03SG16czQyaTZsUmZzQ2U4YTdMQjg2dTZkenhQcS9saFdWVG9C?=
 =?utf-8?B?OWFXeUx6S1VDT2greDNhcmt2RTc2RVZQWkxTZnFVMTcyYndwbkQ5c1dGTjBq?=
 =?utf-8?B?bUREQ0E4cXFpaHpkY3JUMnl0ZFNIa2g3S1BlTERtREp5dWN6aWx5QTkvM1I2?=
 =?utf-8?B?MXBxK0RVb2pVOTM3MFppS3I1ZkpocnZLYTVCNjcvZ1lzeTY2VUFid24rZFFq?=
 =?utf-8?B?ZDhvdlYrNENqVWd0UkJ1b1BFKzJqWFlRNFFDVmhiTkRkdlA0bWxRNWhwak1R?=
 =?utf-8?B?L296WWdmZWxNVVFMMzhvN2lVUGYyblZIQ3J2aCtpbFBsQ0IzMzJnREYvS0M0?=
 =?utf-8?B?bHJSTGkveCtyWFJ5TDUyRER2Mkx6U2czcFBMbGNXbG9vSnR6QlVueHhvRGdB?=
 =?utf-8?B?MHQ4UUZZU25GODNZR1I4NGJqQ3pIb3hKWFV2RXdhVjBvaXJvZUdqK3ZsNmFF?=
 =?utf-8?B?VDVtcjBWRWQ4eEp2N0FIbHhYcGNNQlBJeTVnSlRRZjY2Z2krbko2eHJ0YXU4?=
 =?utf-8?B?U0lmeDQzSldLSWk0blZWTFZhNUtxS1htSVB3S3FIc0IvREtxTktpUXBRUTdQ?=
 =?utf-8?B?bkhFcFRIR3RXS0ZhWThWc0VKbGJleXYvQmJrWkRkVGdMNHhGRXc0T0MwOEpX?=
 =?utf-8?B?M0tLalNlR0p2SFV6WC9iQW9rMXNtVHRmbGhtM3RkUnhLcWNZUUZuMmJYZWYz?=
 =?utf-8?B?K1VocXNtekpqRWwrdisxZzlMN2lsbWwvTnBBLzdlcEJmN2hBNE9idVN4eHJX?=
 =?utf-8?B?OTVFM2ZzdnZneTllUStTemVLb2VFcmN2a1ZmWjROWk9yT3NnWksvS3FPeGNr?=
 =?utf-8?B?N0RwSXMvU0ZjR1RHNHpaZThQSjZZR0p0Rnd5dmpIVVA2eXdvNlRoMnlLWXZ5?=
 =?utf-8?B?RWJ1bFF5MXlhM21mYUwwbFRiYTk0NWZXRmtQVEFTQkZ6bXZ2VkZDQnhOTjdo?=
 =?utf-8?B?M2RoWkNWLzJHWmZtNmcvZGRRQ2Z6US83NmZIQ3JNbUNHWFh2bnZOSEJvNEZu?=
 =?utf-8?B?T0t3b29XOW41M2pNdmlGL1pORnFFSkVCMWVIaHlZdGcybkNPR0Vnb1dxeTQz?=
 =?utf-8?B?SG9tWmdIKzlmY1QzdSs0MWUwaW9ZL05qRlNkTkg3cjhlbVZkYXRxWDd4MDBS?=
 =?utf-8?B?N0x4SWxJZWxyaDV1K3lvQWlTLzlTbXJXNm9BUUZpekxtM3N5dGh5Y3N6ZTZv?=
 =?utf-8?B?ZUVBaW82S1ZWNVFqNEQrd01LK1VuZ0RSd3BnL0hsUG5yNTZMcG1iVTBzMVZT?=
 =?utf-8?B?c3dpdkJQbGpyalJlRWlnNTNZNHJqWXlyWnJ4NnlrZXFjbk51Qnp3SklFeGw4?=
 =?utf-8?B?RVhRRXJLN1NqVXF0SDZJbHJ5dnc3SHNGTkI0UnlEWXh5dWVaWWxwSERMK3R4?=
 =?utf-8?B?cW94VzRWQTUxMHZrY1N1ZWw2K1ZIVlJlVk5CcWN5UzIvMzhmN1hIbVVBN3l4?=
 =?utf-8?B?NFNxVVF5ZXVndktXMVFHTVdnejNGSFRkVDY1eGlXYlZsS3JqQlhwdU1jRVp2?=
 =?utf-8?B?K2xZSGswMW9UUlF6NWpPM0JhSVV2bVo4QUF1VnM4SGlmN01icFlCTnZOQVc4?=
 =?utf-8?B?aCtwbWlEM01iRlhHeGM5M3BmWW9EWlpVR29VVXlPRUZrK1htY0RhS2VwaVdW?=
 =?utf-8?B?TS9MNEhSQjgwOXFRQjlCSld3YVRWZlVReGN4UjhLVzFrczZ3OUJFaGdyOS8w?=
 =?utf-8?B?Yzl2dmI5QkgrSUZMZHE4enVldlVsMEFacWF2NVJoRUNQU0NhbnpTRmErTmNG?=
 =?utf-8?B?dHJ1RktOaVAvN3c4N2xJQ1ZqdnRhaVE2dk44UmpCbERKblBWN2k4ZXVjSUhG?=
 =?utf-8?Q?j79I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 08:28:05.5293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4169202-1a8f-4115-44bd-08de1b7c13e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6933

On 03/11/2025 19:28, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 06:23:26PM +0200, Yishai Hadas wrote:
>> On 03/11/2025 17:43, Bjorn Helgaas wrote:
>>> On Mon, Oct 27, 2025 at 11:34:01AM +0200, Leon Romanovsky wrote:
>>>> From: Yishai Hadas <yishaih@nvidia.com>
>>>>
>>>> Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
>>>> in the next patch from the series.
>>>>
>>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>>>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>>> ---
>>>>    drivers/pci/tph.c       | 7 ++++---
>>>>    include/linux/pci-tph.h | 1 +
>>>>    2 files changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>>>> index cc64f93709a4..8f8457ec9adb 100644
>>>> --- a/drivers/pci/tph.c
>>>> +++ b/drivers/pci/tph.c
>>>> @@ -155,7 +155,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
>>>>    	return reg;
>>>>    }
>>>> -static u32 get_st_table_loc(struct pci_dev *pdev)
>>>> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>>>>    {
>>>>    	u32 reg;
>>>> @@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
>>>>    	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
>>>>    }
>>>> +EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>>>
>>> OK by me, but I think we should add kernel-doc for the return value.
>>>
>>> With that doc added:
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Thanks Bjorn.
>>
>> We may add the below hunk.
>>
>> Can that work for you ?
> 
> No, because (a) it just restates the function name and doesn't say how
> to interpret the return value (you would need a PCIe spec to look it
> up) and (b) kernel-doc syntax would be "Return: " (see
> Documentation/doc-guide/kernel-doc.rst for examples).
> 

I see.

How about adding the below as part of V1 with your Acked-by: ?

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 8f8457ec9adb..510173cc8b63 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -155,6 +155,15 @@ static u8 get_st_modes(struct pci_dev *pdev)
         return reg;
  }

+/**
+ * pcie_tph_get_st_table_loc - Return the device's ST table location
+ * @pdev: PCI device to query
+ *
+ * Return:
+ * * PCI_TPH_LOC_NONE - Not present
+ * * PCI_TPH_LOC_CAP  - Located in the TPH Requester Extended Capability
+ * * PCI_TPH_LOC_MSIX - Located in the MSI-X Table
+ */

Yishai

>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index 8f8457ec9adb..385307a9a328 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -155,6 +155,12 @@ static u8 get_st_modes(struct pci_dev *pdev)
>>          return reg;
>>   }
>>
>> +/**
>> + * pcie_tph_get_st_table_loc - query the device for its ST table location
>> + * @pdev: PCI device to query
>> + *
>> + * Return the location of the ST table
>> + */
>>   u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>>   {
>>          u32 reg;
>>
>> Yishai
>>
>>>
>>>
>>>>    /*
>>>>     * Return the size of ST table. If ST table is not in TPH Requester Extended
>>>> @@ -174,7 +175,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>>>>    	u32 loc;
>>>>    	/* Check ST table location first */
>>>> -	loc = get_st_table_loc(pdev);
>>>> +	loc = pcie_tph_get_st_table_loc(pdev);
>>>>    	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
>>>>    	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>>>> @@ -299,7 +300,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>>>>    	 */
>>>>    	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
>>>> -	loc = get_st_table_loc(pdev);
>>>> +	loc = pcie_tph_get_st_table_loc(pdev);
>>>>    	/* Convert loc to match with PCI_TPH_LOC_* */
>>>>    	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>>>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>>>> index 9e4e331b1603..ba28140ce670 100644
>>>> --- a/include/linux/pci-tph.h
>>>> +++ b/include/linux/pci-tph.h
>>>> @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>>>    void pcie_disable_tph(struct pci_dev *pdev);
>>>>    int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>>>    u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>>>> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>>>    #else
>>>>    static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>>>    					unsigned int index, u16 tag)
>>>>
>>>> -- 
>>>> 2.51.0
>>>>
>>


