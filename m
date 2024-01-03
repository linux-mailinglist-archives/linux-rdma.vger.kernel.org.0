Return-Path: <linux-rdma+bounces-529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B285F822E74
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 14:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33162285FD0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960C2199B4;
	Wed,  3 Jan 2024 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fMWCicNp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE74199BA
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jan 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704288840; x=1735824840;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=aRiyHuKVhplaaR4ZrYoRsp7G1qLFtEBaPv09/IVXP+E=;
  b=fMWCicNpLMKqMzlknI5y3wTe2FkhzbQFK573888MYlmkI8nAaf+t06nC
   3U0w2QgKLz2zaJEVu4awLR4hQVf0cmyyTPjUmPMP1DjjICtw0tuegnb+3
   8Dwin2KZHSmAs8JTRe80SWWs1KueCf8LbLNYbnoshMq5qtx3aXMQjz5+v
   M=;
X-IronPort-AV: E=Sophos;i="6.04,327,1695686400"; 
   d="scan'208";a="387239734"
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 13:33:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 19FEE806BB;
	Wed,  3 Jan 2024 13:33:51 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:47336]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.193:2525] with esmtp (Farcaster)
 id 706db23b-d43e-450c-88d4-7c912731312a; Wed, 3 Jan 2024 13:33:50 +0000 (UTC)
X-Farcaster-Flow-ID: 706db23b-d43e-450c-88d4-7c912731312a
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 13:33:50 +0000
Received: from [192.168.136.251] (10.85.143.178) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 3 Jan 2024 13:33:46 +0000
Message-ID: <d6394917-802d-4d37-8141-c4f462583943@amazon.com>
Date: Wed, 3 Jan 2024 15:33:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <leon@kernel.org>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Anas Mousa
	<anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
 <20240102234713.GL50406@nvidia.com>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240102234713.GL50406@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 1/3/2024 1:47 AM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Wed, Dec 13, 2023 at 07:05:24PM +0200, Margolin, Michael wrote:
>>> On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
>>>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> index 9c65bd27bae0..597f7ca6f31d 100644
>>>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>>>> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
>>>>         * memory region
>>>>         */
>>>>        u32 r_key;
>>>> +
>>>> +     /*
>>>> +      * Mask indicating which fields have valid values
>>>> +      * 0 : recv_pci_bus_id
>>>> +      * 1 : rdma_read_pci_bus_id
>>>> +      * 2 : rdma_recv_pci_bus_id
>>>> +      */
>>>> +     u8 validity;
>>>> +
>>>> +     /*
>>>> +      * Physical PCIe bus used by the device to reach the MR for receive
>>>> +      * operation
>>>> +      */
>>>> +     u8 recv_pci_bus_id;
>>>> +
>>>> +     /*
>>>> +      * Physical PCIe bus used by the device to reach the MR for RDMA read
>>>> +      * operation
>>>> +      */
>>>> +     u8 rdma_read_pci_bus_id;
>>>> +
>>>> +     /*
>>>> +      * Physical PCIe bus used by the device to reach the MR for RDMA write
>>>> +      * receive
>>>> +      */
>>>> +     u8 rdma_recv_pci_bus_id;
>>> What driver is bound to this other PCIe bus and how did the iommu get
>>> setup for it?
>> It's internal bus that is not directly exposed to the host. Addresses
>> mapping is acquired from accelerator's driver as for any MR residing in
>> accelerator memory, and the translation is owned by devices on that bus.
> So if it isn't visible to the host, or connectable to anything Linux
> would call a PCI RID, why are you giving it such specific names? Just
> call it 'interconnect path id' or something and make it opaque?
>
> Jason

I would like it to be as opaque as possible but on the other hand to 
express that the mentioned 'interconnect path' relates specifically to 
PCI path.

I think that except of this, since 'bus_id' is quite general term that 
cannot be used without proper context, it isn't likely to cause any 
unintended use of those fields.

Michael


