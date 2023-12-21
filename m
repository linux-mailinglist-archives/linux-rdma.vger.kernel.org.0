Return-Path: <linux-rdma+bounces-474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AF781B8E7
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Dec 2023 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7331C21A93
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Dec 2023 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD555E64;
	Thu, 21 Dec 2023 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KboBhy5T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDF539E0
	for <linux-rdma@vger.kernel.org>; Thu, 21 Dec 2023 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1703166368; x=1734702368;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject;
  bh=BCXvgIBHtbV2195+AAR2FPJnaN62M9F/8YFLMu7OxyU=;
  b=KboBhy5T9Vg60v8pNNhxfP0Fq+aHhFL3Gks7dfTVYyCLZ4OixBZyWN7R
   xLUuH+bA4pLJLAQMqRtt0R7rrhPnfVXNCnXE3KotEEULAC0NQFyss4EOT
   nnwZsLQI31sgZ7K8c5/Z1j1iLqYXYnVwHZxxYgvh5EwqGLPVZQw0SEra9
   c=;
X-IronPort-AV: E=Sophos;i="6.04,293,1695686400"; 
   d="scan'208";a="53062826"
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 13:46:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id EBB1510170A;
	Thu, 21 Dec 2023 13:46:05 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:44907]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.246:2525] with esmtp (Farcaster)
 id eebb7e9a-eb43-444c-8abe-a5ab9ce21a64; Thu, 21 Dec 2023 13:46:04 +0000 (UTC)
X-Farcaster-Flow-ID: eebb7e9a-eb43-444c-8abe-a5ab9ce21a64
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 13:46:04 +0000
Received: from [192.168.66.225] (10.85.143.174) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 13:46:01 +0000
Message-ID: <2a4a71b1-4a85-40fb-87c0-59ff50a956c2@amazon.com>
Date: Thu, 21 Dec 2023 15:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Margolin, Michael" <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <leon@kernel.org>,
	<gal.pressman@linux.dev>
CC: <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>, <matua@amazon.com>,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
In-Reply-To: <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

On 12/13/2023 7:05 PM, Margolin, Michael wrote:

> On 12/11/2023 7:50 PM, Jason Gunthorpe wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
>>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> index 9c65bd27bae0..597f7ca6f31d 100644
>>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
>>>        * memory region
>>>        */
>>>       u32 r_key;
>>> +
>>> +     /*
>>> +      * Mask indicating which fields have valid values
>>> +      * 0 : recv_pci_bus_id
>>> +      * 1 : rdma_read_pci_bus_id
>>> +      * 2 : rdma_recv_pci_bus_id
>>> +      */
>>> +     u8 validity;
>>> +
>>> +     /*
>>> +      * Physical PCIe bus used by the device to reach the MR for receive
>>> +      * operation
>>> +      */
>>> +     u8 recv_pci_bus_id;
>>> +
>>> +     /*
>>> +      * Physical PCIe bus used by the device to reach the MR for RDMA read
>>> +      * operation
>>> +      */
>>> +     u8 rdma_read_pci_bus_id;
>>> +
>>> +     /*
>>> +      * Physical PCIe bus used by the device to reach the MR for RDMA write
>>> +      * receive
>>> +      */
>>> +     u8 rdma_recv_pci_bus_id;
>> What driver is bound to this other PCIe bus and how did the iommu get
>> setup for it?
>>
>> Jason
> It's internal bus that is not directly exposed to the host. Addresses
> mapping is acquired from accelerator's driver as for any MR residing in
> accelerator memory, and the translation is owned by devices on that bus.
>
>
> Michael

Hi,

Just want to make sure if there are any questions / comments regarding
to this patch that haven't been addressed?


Michael


