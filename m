Return-Path: <linux-rdma+bounces-658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59E832229
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jan 2024 00:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E918E1F21E92
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jan 2024 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF5E1DA51;
	Thu, 18 Jan 2024 23:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="JxjcJWIk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2130.outbound.protection.outlook.com [40.107.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0724728DA1;
	Thu, 18 Jan 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619660; cv=fail; b=IQfbVW6YaOTK7M8EbHqA6ERTLh4UL/MD82FHE3CElJFS/2lzCpyZFIC1hNrta3KN29EGnGON+2rV5qtN5x2PkObT0FYB+ZklMQuM1xoduoYdVpQ0ukUxzHkMbyMDXRYkSInssvBf4h5wZB8UiTwxtWv12e/08jVIg1kP+oLwCSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619660; c=relaxed/simple;
	bh=IwLKRfz35/0Ixzh7L8Ae13vAaNZRfFGbshN6K3U0eEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R9euo6hqY0xi15dyZzNxAZtb+URxRuRKPeuyY7s+Ir5IKvp7KaSDckYeW563PAwPcPrGc9vSHUT/geU29CE/jvf0pejrkSFtZ2D3tJOEKrGD/Vh2bAMDAMyzQMQ4vURk2KWxvkb9bRGgLbPGudU0rvySNXtSvNkNQzzM6gnstSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=JxjcJWIk; arc=fail smtp.client-ip=40.107.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tziyl2CrdNJ9c1PLK1Lx2IPAPWHWklXyY5nIZtnmrjBb84EHsr2Vhi6vNL6S+CwHwy0fWL/BErORtvm9Qbxtm8JnxIwX15cSySmlAtO8Q/+zM5ocM73bwGau2DHDGU90uPO3D/xiKa6aXMzyYbBlAJ8+KZp/FyHjwarCwY70f9lihYzHfL1HfowACRkzPLtwL31v1/WYY1WYmuLFUAp1nBOk78SDkUt8SuVgN5rkE9kuoIcwGlqgOCCLyF8PnagtyhcrZAaK0lyP3pc5a8nilekH+f30F0E0gMgiWyaKy/idNnmyTyp4q0P34yCEQiZyC+jgxZBtruC553/HBHuTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qmlhdvq7cAbrOwTdAy3Pjvqf9jLoh4z52NGx23VBvnM=;
 b=aQUEl929y/m2OlrzI6ML9DNOTXZ9X7aa8n6fGzjE+WxjQ2uO0OEdNejGWNlBiaOnHaQ2k9KyE/tKS6y387H8Su92XppWnbPR46KslZVMMBASR7T+Lmkr8NYuTmc6Aq2cZKYhJYjnlKzbCwXl3LVi+3hlP378Bzm9kDtjq0vTy/okdiXr3K6qG4T5MpkV4ZKWuhPdntFzOvuU1DdokFgItbtAXXolzU2FkOxPI4hBqmSDOi1nAyZiQCnZa9vrSETAzNthu8B78lymdhVBWnYoEHaOm2/7XcpKG/MSUSNMRZ0ELCktKxkWt0nmm9FqOL7X5orU4Z7wvprLTPWISBCqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qmlhdvq7cAbrOwTdAy3Pjvqf9jLoh4z52NGx23VBvnM=;
 b=JxjcJWIk1oJXE+olF9E/Gu43x7Ak2o2j0lnpmoxzlm6wUkZWCkOSLo5QwKXSC/8w1mlabqteSL/tDTSU/EHZ1ssZGdkblmUz6Y09X0XZx9UARINzyW8VjQKVEJ0CGecnIAlGl2SWtSfZ570NZ3Q03jBo2Kah2q4JFk81fAqZJlfrYzntPui1zRw8ppBPc0ItCpvqxbV9LLfJu0bNXDbDKqrFQjPIC2BSFjoW6Itr/O9DGlmu4zH1cpSEmXAdXa1wOXueQCjKOahxtssmfVpVuMYNc6gDUx+iHBiHs8tTBwM7hirPyEiWLz1pPPR7CA7xMPao7DToxKqpjMlHpGqNDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 CH0PR01MB7020.prod.exchangelabs.com (2603:10b6:610:109::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 23:14:14 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::1840:13fa:59b2:40c5]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::1840:13fa:59b2:40c5%7]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 23:14:14 +0000
Message-ID: <28aeb877-c0b4-4236-87d5-0bbaeb185656@cornelisnetworks.com>
Date: Thu, 18 Jan 2024 18:14:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/hfi1: fix a memleak in init_credit_return
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Zhipeng Lu <alexious@zju.edu.cn>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
 Ravi Krishnaswamy <ravi.krishnaswamy@intel.com>,
 Harish Chegondi <harish.chegondi@intel.com>,
 Brendan Cunningham <brendan.cunningham@intel.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240112085523.3731720-1-alexious@zju.edu.cn>
 <20240114090434.GD6404@unreal>
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20240114090434.GD6404@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|CH0PR01MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9f4a11-d5e0-4ac5-1bf6-08dc187b2f64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G6Z/HPsaENPhWlNqAsmeERQUsFY+fRKi7Y+oYIuNXpy7q+5HS5/pU+MOIWoaXsCUbnRownwmSluO1PFMagEl3Bxc10qCSJWYFjruiXcTA02If9I6vYqjLBK74XRsPefwknAZ2ySNYRjWFoFhD1mtJ51ATNP0kmXL3K/QTdZ5iDt1zg1qGfcnn7sRmUVOVO0HuEn3bvwPnlP+3S3n5UoT4b0HxGuL+HJ/SoA6+eQ3FVL1mytHB4qiMW0z5fCs/UqtDyMBiE4jgHBrzw9t+JjH/nDNVVBNXzWPyCPeSEe6jSx5BW0ERdDWhAfUdneTRQlDbmqt4n7vcUIPZTrlf4nt0EGzZE0dokyftVgYRjTHo1EXFPUhJBSTv+Zx58TdPS96drGLXgCoP7HM1vve9m90QfBZKhtzCD40cSYpPZ9sq60r0J2988yXNf5Vy+sa/zLkHO3rSiMbQoLEYmxsDqrVWlELmIGxv27ezuR3IQodTd1cp3b4k5zaNHphTrbFoRrN8qB6KxaqLT90Zbe8IbculDfM1/51nkCKeJd9UJZktbdcNDhZ0qLKh9jmSLndJmT5IBQ7Sr7TPNP3802pcbCH+u6c7VfivId5V8nbwTF//dmBho5i4WeYyso7HdHXc8qa4ileDkAFl6ez8bPddaaTFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39840400004)(136003)(1800799012)(64100799003)(451199024)(186009)(6506007)(66899024)(38100700002)(86362001)(36756003)(41300700001)(31696002)(38350700005)(2906002)(110136005)(66556008)(54906003)(66476007)(66946007)(53546011)(52116002)(316002)(478600001)(6512007)(6666004)(6486002)(2616005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(26005)(44832011)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhLaEVMNHBCaFhMMUtWMWVSTllicHhJZ0UxbWtpbTg0U0VWSVVVWDZPYndr?=
 =?utf-8?B?MFgrWGozaS9UbGdVc2JpVmVNUDMwa1o5M1JlL0RZT3A0dHZyaEZFY1ZvZGMx?=
 =?utf-8?B?WlR3RGVGT1hNNVJXT1UrNVl3djdnVWVzdDVOam5QNld0Q2wwczRHNjRvc09D?=
 =?utf-8?B?WGNpTnpvNUhPNlAyQmdSVXMrNHF3aEFhaU55bHYveHVZWmlwZUdSZDRaV3Za?=
 =?utf-8?B?QjljQU9UK2NoU0RQSGJzME5iSWkydVdsYWx1Tmo0dWg0eStyNTRmWjhRZWlQ?=
 =?utf-8?B?V3FsOGdINzdUa00zOVNYNlBwcEdnTG8rcTRFZCtLa3hWYjgwbll5VXE4dzZ2?=
 =?utf-8?B?Z2E2cUoybkRPby9KNjFaQ00wM09YUHA1ZWdBWUIvVmliaStrdHJxYW9qNFhI?=
 =?utf-8?B?S0w4WjNpNEJ4S0V3aFJqWHRjaW5HN3pZTUlMcWlTZUN6REVqM0cxWldXY0VO?=
 =?utf-8?B?Wi9OUHE5NGVBSXV4UnZ6aHJKNStLeUtESGJINmpWRWl0Tm9FeG4xbVhJSnhy?=
 =?utf-8?B?SjduT0V0MUJIZ09uWXdUc2k1bHZMRURVOUQ3OHlwUlNqZFpweGJGSXllYjlr?=
 =?utf-8?B?WGwvdWViYjNwMFRNenJWWHl1RC9HVlJzR1k0TXFINkhWNkZUQlo2OTdBdWVF?=
 =?utf-8?B?VlBTcFdaVTBkeHNTNWdZTnZTM0tjem1XcmZHNHJ4RXdKMm1uR3FWQlBiM3Nn?=
 =?utf-8?B?aWFkdmZjcVBVQ2RVbVJUL2VMKzQ4Z2dYSUJxNFJTazdVa0o1TDVHdVgzSS9C?=
 =?utf-8?B?SVRLR080c3JFMWl1SmJzWTg5WmpoR3B5N3YvaFI3ZnhuSC80UXJaSkVzalVN?=
 =?utf-8?B?WXhJS3pMOHpVMGJsYVZXQitpbXBxMC9KeU1FUERXNjRMWFVnL3RKN0tqMWFB?=
 =?utf-8?B?M29JRzIxUVR4NjRzUHhKd0dEUE9CbVEwQ3l0UFNkdXd3d3JQamN5cStmd204?=
 =?utf-8?B?L2lnemZWYTB6ZTN1T3lWYUJNMWFrNlQyWEFqc2dYQjRXRmlYNTBIS0tnbjdm?=
 =?utf-8?B?TUNTVkJGcGNxODJMWGh5akZFcTRpS3YybEI2Zys1aVZGMjB5V29OaDcwbmNy?=
 =?utf-8?B?NEZkNlllYTJ4SGdpWlZuUWI2SlBRWmwrTWhTWTJYZGJ1UnRneEJQWGNFMlVr?=
 =?utf-8?B?bVl6VjRqdmgvWnBQRTRTZ3czT3BESmhvL2VxV0ZKK1prY0t6RVNWZWl5MytG?=
 =?utf-8?B?b1hwdzhvQzdKOHpVQkdwNVRtbk5Rayt4eHV6ZmNmRUUzZFFKMUFHd09TV3pm?=
 =?utf-8?B?a0MwYUt3dTE1WXpkOXJXMDljY2k4UzYvV0ZmQ0prZWVqM1RtUXR5WSszSEoy?=
 =?utf-8?B?Y290aVNOQk4wQU1PdzNpaDFpTkJNU2ZJNW5heU1kelp1WUMzOGxwS09kK1pa?=
 =?utf-8?B?bGdxTkFRcnNRa3JYbm9HZ0ZURnRmQjh0dEphdXRBeW5vUk52NVE0aXN2TG5o?=
 =?utf-8?B?QjZMdnMrdzVaNi9NcDZ4QW1kR0pCRUdta2hONVk2Tis0UzlGMVpEbGhSYnUv?=
 =?utf-8?B?YnJHRlRmeUtOeFN3bEc4NGJyRkM1TlRxQW1BeDAwNEd1VXp6bXZxT2NpSTc1?=
 =?utf-8?B?UWxIM3ArN1NWaklXS3pRZ1doRXgySXBwWEZoTnBTQ1RFSXdxQnFqK3gwcUti?=
 =?utf-8?B?ckJpQmJpVlQ1ajU4dzZtRnM2QWVneGdnL2FLREs1UzE0aTBsWlNqYll4L2pG?=
 =?utf-8?B?SlRnK1BacHNrckRoZ0hxb2lsbDZRaDBTay9WSXZ5aDBFODdRZjlhRTc3citE?=
 =?utf-8?B?bHJUR1JrNkVsUVgxN09HeGo4Q0s1QTdHemQrUHMvK3lva0dQTExRdnhsTGUr?=
 =?utf-8?B?YlZ2dGl2VXA5c3ZQMkFtSTJSYWhYcUdPcUtyL1NWNW9qUjlOdjJYVUlMeGwx?=
 =?utf-8?B?dy9RNXhydG4xMzhzM3RYY1NRcDdxWWtJSzFoYVNMeFMrblFKWk1TbndhWEhz?=
 =?utf-8?B?WVJrWEJHLy9PZVpuUEx0MU5ZR0RtOXQvZ0VNUUd4dDJ3S0ljcENyN3RkYTdP?=
 =?utf-8?B?eEo5Z2JaRzlVcnNZRXpuSXZ3VitkWEtCcU9mdjJ6MHNBR1lTb1gxdUFWYmRs?=
 =?utf-8?B?V3BjVk9XeWl6Mys5V29yQlhJQVNCUm5rL3diQVlZM3IwYVZoQUczWnVxdEt2?=
 =?utf-8?B?QUNQQklEVEczaTFCM3pVWi9TUHdneFd0eEZVZEVzWFFOc1I5T3NKR2hvMTEv?=
 =?utf-8?Q?03h4krMy3H1QV0UfP2mu0ME=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9f4a11-d5e0-4ac5-1bf6-08dc187b2f64
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 23:14:14.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qR1YBePYYciK9md0bZO2iOD/S33SLRrEnd117ywx9ApSG7nomDI8kLs/iYfgZ+rDpo70mIe72SooszryAAgGsMzjKpH0CT3JBeiqma7RvdGnrV2KE9n/GgK44uFgPSjv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7020

On 1/14/24 4:04 AM, Leon Romanovsky wrote:
> On Fri, Jan 12, 2024 at 04:55:23PM +0800, Zhipeng Lu wrote:
>> When dma_alloc_coherent fails to allocate dd->cr_base[i].va,
>> init_credit_return should deallocate dd->cr_base and
>> dd->cr_base[i] that allocated before. Or those resources
>> would be never freed and a memleak is triggered.
>>
>> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
>> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
>> ---
>>  drivers/infiniband/hw/hfi1/pio.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/pio.c b/drivers/infiniband/hw/hfi1/pio.c
>> index 68c621ff59d0..5a91cbda4aee 100644
>> --- a/drivers/infiniband/hw/hfi1/pio.c
>> +++ b/drivers/infiniband/hw/hfi1/pio.c
>> @@ -2086,7 +2086,7 @@ int init_credit_return(struct hfi1_devdata *dd)
>>  				   "Unable to allocate credit return DMA range for NUMA %d\n",
>>  				   i);
>>  			ret = -ENOMEM;
>> -			goto done;
>> +			goto free_cr_base;
>>  		}
>>  	}
>>  	set_dev_node(&dd->pcidev->dev, dd->node);
>> @@ -2094,6 +2094,10 @@ int init_credit_return(struct hfi1_devdata *dd)
>>  	ret = 0;
>>  done:
>>  	return ret;
>> +
>> +free_cr_base:
>> +	free_credit_return(dd);
> 
> Dennis,
> 
> The idea of this patch is right, but it made me wonder, if
> free_credit_return() is correct.

Yes, I've double checked the call path and if init_credit_return() fails we do
not call the free_credit_return().

So this patch:

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>


> 
> init_credit_return() iterates with help of for_each_node_with_cpus():
> 
>   2062 int init_credit_return(struct hfi1_devdata *dd)
>   2063 {
> ...
>   2075         for_each_node_with_cpus(i) {
>   2076                 int bytes = TXE_NUM_CONTEXTS * sizeof(struct credit_return);
>   2077
> 
> But free_credit_return uses something else:
>   2099 void free_credit_return(struct hfi1_devdata *dd)
>   2100 {
> ...
>   2105         for (i = 0; i < node_affinity.num_possible_nodes; i++) {
>   2106                 if (dd->cr_base[i].va) {
> 
> Thanks
> 
>> +	goto done;
>>  }
>>  
>>  void free_credit_return(struct hfi1_devdata *dd)

I think we are OK because the allocation uses node_affinity.num_possible_nodes
and in free_credit_return() we walk that entire array and if something is
allocated we free it.

Now why do we use for_each_node_with_cpus() at all? I believe that is because it
produces a subset of what is represented by num_possible_nodes(), which is OK
and doesn't leak anything.

-Denny


