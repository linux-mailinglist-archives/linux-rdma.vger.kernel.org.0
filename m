Return-Path: <linux-rdma+bounces-14213-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE636C2D1AF
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 17:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49B594EA0E8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC3318139;
	Mon,  3 Nov 2025 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q6BCEA2w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B0315D41;
	Mon,  3 Nov 2025 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187110; cv=fail; b=uBXqMCxgPw4ndR5B67BGokmRIfGp6xuFqMjk/M2LERE4v4rPFjGW0nPQ3zKj06Qor87SmLIGMUS6vlezwZSVgDN6SJRiboxR/bAXBYyLfPmDAKkK9Z1RSqOgzl6DWmAuBoSV1/meXfFGai7glc2KZ6KsIRNdgFkF8NpmBre6elY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187110; c=relaxed/simple;
	bh=rsBT9udCFKQa7El+qqRQhSFb29y2r6/bIBcoeppoUaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sM8twTnkHHBPGTFwTktloIxxwfykL7IcM/OvvlztCqp25LCuIHtBE3SI6NRgMmdRHFiL/GR6h+cDTHVLQBzUpQTZyBRtELFIpKkcy8golL6Xn8UVeexGwdubkh91Ncn+x1Ucvb5/0D02MZ7cLF/UA6FBaJxNo5sj25BFJGOH8W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6BCEA2w; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5GxJ2GomrNu/8DK1u80QQk/HpT5hzXDBjRfnY9hr69+QZMs/e8+Gmz5bHN6PLMI/GbA5dW8rxAWuTGVbuqbQ5GOomL89v1HO9o5dJ+ds+k5tZwxal/g0d1prF57/ybJBjoe1VxeAnHi01bQC5aCDrYhEwicnWEKLQzwAGNJEH0sqHgWhInCKzj7l8rwG4xjIg9+JkniWkb2zvkoRoZSweLK0wwsKJMh3oCsY7ybcYHq+WOKRkfpZnSX36aXxaxETSDMRf8mN/Oc5N4Ct1Uf7wLVg0JkPmuXWZB0Pm6hPkHhjj9PmuvRYFAly0SKtaeoVnaSQACATt1eQQAa7Btm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZacZaIGXoBj3bNgkTt9zVWK/Mtj1yNde7U2uLHsPB4=;
 b=VOLgLyaJyomSu8XUXcP+O4xKHnl2N9mSmy0VzNZ3RriXZvpUjYYAkh9rZ6zYnub8TZChV0OVmSnljh1S43hk5YXM5RJXRxOiyEuOon6pfCr8r/xZ+2Pspc2AYmduzliS4Ne0KoTC+nIffkCAsvgehIKjkSJHDtN1gioRDZDMnJBJTYfxQ5k6heuwxSHXI0V9698M0bB7LqNHHoAphGkcrZgLNeXZlh+6gSASLpoejaKP12UnUqmLWIjk2CFDjGiCQn7qHDdP/smW0p5KMu/4M/okzynpPtqvsnQpRWtCCy+FDwy2pdwGLt8m891Jy/sv6xmPF9/o5gcajLfvQkq0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZacZaIGXoBj3bNgkTt9zVWK/Mtj1yNde7U2uLHsPB4=;
 b=q6BCEA2wWQEBmOhLge47gGXjNm4rMwtIqSKV7yXSeZr7meGLQ5yNhnswwQ+Yh0QG1P4qsSPtubZtFjVLkIYnkti6r1jfgaFSvJpb16eKWWETQvhmN7wlCbRCzzwYByOnGfGVG7ZT2TScZ2b+4K39JHLyiLjREXbknPqhRI0+TbUJEEl8Uxkrm690eMpnLR+6lAJfQScmatkYvrWGdn10FMxBX/opVYbYhdza8xsu/8DRLhAyPp4BzGvkbtS3nJpCRS6nN0yzDEX/eY5FfPbWUyw4ZfxKPQnw9eg/ZUxx8hn8ZyMMoRSuOg07bEkpJtvcVwI3m/zT2yX/1aZ1JyYQ5Q==
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 16:25:05 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::39) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 16:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Mon, 3 Nov 2025 16:25:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 08:24:37 -0800
Received: from [10.221.199.87] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:24:30 -0800
Message-ID: <c9cb13f6-570e-422f-b988-035a31e85330@nvidia.com>
Date: Mon, 3 Nov 2025 18:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 1/2] PCI/TPH: Expose pcie_tph_get_st_table_loc()
To: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>
References: <20251103154359.GA1806626@bhelgaas>
Content-Language: en-US
From: Yishai Hadas <yishaih@nvidia.com>
In-Reply-To: <20251103154359.GA1806626@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d614b1-2f00-4fca-276d-08de1af58bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjFERTc0dFZYZ0IyVlRzNkUxY200bXFpTnA1azh6ZFlqQXZKWmpHY0c3UlRh?=
 =?utf-8?B?WVNmZ1FQS3dTelZvQ0FoSVU2L1hVdW5jaW9ZTWY0emZvN1VHcjJTOUZ4VlF0?=
 =?utf-8?B?VFNNK092ZmFIRjhoQWNTMTFnc1VKUG5iRUFSWERyTUh4QThSaXhMRGo1clBC?=
 =?utf-8?B?cGo5Y0kwWm1Rckkxbi8rekpVV09mZ1VaVWNyd1d0M05ORktEYldyMVpXdmM1?=
 =?utf-8?B?Z2FvNU5yckNZY1VvenZUSzdTeU5XclpXWWFXNTdrWGZZb3BVd1RKbVJFY3Jr?=
 =?utf-8?B?Q2VsTEd4TnpEVmVJQklSS0daNmhKbW5PUE1BNjVHcmZ5MytTeEZDeDNYMEgv?=
 =?utf-8?B?a3dXaWZaU1M2WEwyR0Y5ZUFZRmdTLzVOZ0ZEVXIyKzFZblpyVC83RFZ5WHVY?=
 =?utf-8?B?Wlk3clRUTG1qTjBaeTdqemx0Smt1SWorZ2JMRkRJRm55RXJ5Ky9TcGhNNWda?=
 =?utf-8?B?L3VEbUdtSUJFODJPZFRvMUt1QThlamY0cno3NEMya2tRQWpQck5kMGttOUpB?=
 =?utf-8?B?RnI4YnVzRmdwUVVkeVFOMnJaMkxZM28zR0VCZUwyeWRwTStIY0JpYkNZd3pl?=
 =?utf-8?B?MHJkY2FUTmx0cU8zZjM5cmVqcXAvT0VjbTBMc0M2YzBoaDhFbldSczlXK3Ix?=
 =?utf-8?B?NGZQZm1vOWNrOXlWQ0QxUnhxQUtpbDBUT2EyeVBLbHUyUmJtUG1MdmtlOUVR?=
 =?utf-8?B?dEMwdlNvKzZhMzlkWmtVY2QxcVFlM0N3L2l4dFF3MVJ3aDNtUS9FeFRKTTVV?=
 =?utf-8?B?RVJSY1Z3N0xYalMwUWFDVHI1aTFpSHdwbWZZQVJWa1FrUEJRZWlFbGNsV0xT?=
 =?utf-8?B?bTc1SjhxZjUxQzh6T3REaENuRXZGeUE2THhDd2lYQStsZmxGa29aT1BaaU9o?=
 =?utf-8?B?ZFRqYUtGZFMvcDh5QldGRnNOU1p4YUVDYWRKM1pscEdYQmUyeFMvcE5ySi9Z?=
 =?utf-8?B?MGM1NUYwT24wczNuSXN3TnZFclNUbVFoREhVRDdMOURrcmttVDhrY3RhY0tT?=
 =?utf-8?B?NDloNGovb1JRNUxUeGlZNTRhN0Z6dk5Wb3NlMnBMT2o4dTZTVzNEMFhtL2Mv?=
 =?utf-8?B?TEpiOHl0WkkrV0lnUjJ2NjVZZkdWSS8xcTRqOWU0d2lUZjVYTWk3c2RaWm1R?=
 =?utf-8?B?aDVJQUQ2T0ZHNjhoaTl3dGFHZy9rRXpuQUR0MXhLKzVaNVp4TG5VeDl2YkEr?=
 =?utf-8?B?bDRCVGhUanphR3R4NUkwNlJRRHJpN0RSeVhhcHBMMHphWXJZbWttYTloay9r?=
 =?utf-8?B?MUNkenJBNUJLZVgzeHg1VGNOQW5JdGhqZEZZeFM3L2RVYmwyamxERjFKL0tK?=
 =?utf-8?B?bTlJeDQyZ0xwaFFlN3FJaUMvRWJ1Z3MwMmYwMituSktXM05DOVhhcmlzWXNM?=
 =?utf-8?B?T3V1NW1kMlNCWkdaR3h6eVBRSjB2ZXM2dUVGNjVDekRvSTUvZGRmdjJFbmxq?=
 =?utf-8?B?cFFhQXdxblRLZWpJRkdDcUFoZi9hZU8vQ3l6OE9SV1FCUElrb0t6ZzRkMXNR?=
 =?utf-8?B?S3JpMU1QZlRWaHZGTXpnLzJrc0FzN1NYMVhVbUhBM3ppY2xWby9aT1E2c0dQ?=
 =?utf-8?B?aEl1WmlCVGlEbDFQWWJlbzB1c2FYdTV0THhSYXd0OEFZQ1VIL2VvUGpsYkk3?=
 =?utf-8?B?RHhPNmRLSmZpck5FMXJPTVhBa2txRE9Ra3o1RklkMEFkVkhuOUpNL3lHVHdP?=
 =?utf-8?B?azM4cTcrd2pWOC8vai8xaXRIZ1c5dFZSbDhmZmpNL3R1dGE5K1A2Mlc1Q1V3?=
 =?utf-8?B?OFBvT1J6OC9VUXpORUVwYVhTQmpGTlV2YkN4S2NPVVkwVE42UHNoM3ByN04x?=
 =?utf-8?B?NGQ3MXRSODNkSHFwVkcvU1N6eUttb01TRUw4NDRrWjgzQmE5L0FaWitKcW9n?=
 =?utf-8?B?bjZ5dUR2MGNDYnlDR1d5bk95bVY3bmdOMG1DcWh1Y3dSYkFvaFhSUlp1aXBO?=
 =?utf-8?B?SmdVQUxKbW0wR2EyMko0VHNsZzJFYTNnWDVoVnBqS2VXbkQrQ1BRTjB3YkFz?=
 =?utf-8?B?dCtyNy9kc1lIek90ZDh6akJLZ2d6WTI1MVF1M0ZGQ3hRYlRUakZPdFhrK1pv?=
 =?utf-8?B?bVF6U2dWVGZjdDJST0NEODZHbTFkdXQ4ZnhRUVN5bDlZbnF6NUJ1UmE3dUlP?=
 =?utf-8?Q?BtgA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 16:25:04.9286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d614b1-2f00-4fca-276d-08de1af58bf6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

On 03/11/2025 17:43, Bjorn Helgaas wrote:
> On Mon, Oct 27, 2025 at 11:34:01AM +0200, Leon Romanovsky wrote:
>> From: Yishai Hadas <yishaih@nvidia.com>
>>
>> Expose pcie_tph_get_st_table_loc() to be used by drivers as will be done
>> in the next patch from the series.
>>
>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>> Signed-off-by: Edward Srouji <edwards@nvidia.com>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>   drivers/pci/tph.c       | 7 ++++---
>>   include/linux/pci-tph.h | 1 +
>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
>> index cc64f93709a4..8f8457ec9adb 100644
>> --- a/drivers/pci/tph.c
>> +++ b/drivers/pci/tph.c
>> @@ -155,7 +155,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
>>   	return reg;
>>   }
>>   
>> -static u32 get_st_table_loc(struct pci_dev *pdev)
>> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>>   {
>>   	u32 reg;
>>   
>> @@ -163,6 +163,7 @@ static u32 get_st_table_loc(struct pci_dev *pdev)
>>   
>>   	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
>>   }
>> +EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> 
> OK by me, but I think we should add kernel-doc for the return value.
> 
> With that doc added:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks Bjorn.

We may add the below hunk.

Can that work for you ?

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 8f8457ec9adb..385307a9a328 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -155,6 +155,12 @@ static u8 get_st_modes(struct pci_dev *pdev)
         return reg;
  }

+/**
+ * pcie_tph_get_st_table_loc - query the device for its ST table location
+ * @pdev: PCI device to query
+ *
+ * Return the location of the ST table
+ */
  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
  {
         u32 reg;

Yishai

> 
> 
>>   /*
>>    * Return the size of ST table. If ST table is not in TPH Requester Extended
>> @@ -174,7 +175,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>>   	u32 loc;
>>   
>>   	/* Check ST table location first */
>> -	loc = get_st_table_loc(pdev);
>> +	loc = pcie_tph_get_st_table_loc(pdev);
>>   
>>   	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
>>   	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>> @@ -299,7 +300,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>>   	 */
>>   	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
>>   
>> -	loc = get_st_table_loc(pdev);
>> +	loc = pcie_tph_get_st_table_loc(pdev);
>>   	/* Convert loc to match with PCI_TPH_LOC_* */
>>   	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>>   
>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
>> index 9e4e331b1603..ba28140ce670 100644
>> --- a/include/linux/pci-tph.h
>> +++ b/include/linux/pci-tph.h
>> @@ -29,6 +29,7 @@ int pcie_tph_get_cpu_st(struct pci_dev *dev,
>>   void pcie_disable_tph(struct pci_dev *pdev);
>>   int pcie_enable_tph(struct pci_dev *pdev, int mode);
>>   u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>> +u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
>>   #else
>>   static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>>   					unsigned int index, u16 tag)
>>
>> -- 
>> 2.51.0
>>


