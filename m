Return-Path: <linux-rdma+bounces-414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E8811A63
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE94281060
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 17:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB09C3A28E;
	Wed, 13 Dec 2023 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="So0zNrRw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEAF3
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 09:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702487155; x=1734023155;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/+LYKQuxTh5lPh3DEQNUwPRNxzcNkwApILOs9WLJc44=;
  b=So0zNrRwHNoEMKGpC8FL4w1ygjMlmylIA7JcUHlGs9ivZVqtefpFP2iw
   BzL6COSqgJRSlyPRGq0G2Bvm/UBd2Rr7Nyq/aJckbzQqqXMRhrUmQMSfy
   vOrZm+iAfQK5hdhBcLTcZ5RXC2F/9BbXeZcRGsp9G+qw8jHadzu7qs5ra
   o=;
X-IronPort-AV: E=Sophos;i="6.04,273,1695686400"; 
   d="scan'208";a="382710510"
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 17:05:36 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id AEB9A895A6;
	Wed, 13 Dec 2023 17:05:34 +0000 (UTC)
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:20096]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.6.151:2525] with esmtp (Farcaster)
 id 96edc5f9-5b6b-4696-8808-2becafdadfa4; Wed, 13 Dec 2023 17:05:32 +0000 (UTC)
X-Farcaster-Flow-ID: 96edc5f9-5b6b-4696-8808-2becafdadfa4
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 17:05:32 +0000
Received: from [192.168.67.49] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 17:05:29 +0000
Message-ID: <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
Date: Wed, 13 Dec 2023 19:05:24 +0200
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
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20231211175019.GK2944114@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 12/11/2023 7:50 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> index 9c65bd27bae0..597f7ca6f31d 100644
>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
>> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
>>        * memory region
>>        */
>>       u32 r_key;
>> +
>> +     /*
>> +      * Mask indicating which fields have valid values
>> +      * 0 : recv_pci_bus_id
>> +      * 1 : rdma_read_pci_bus_id
>> +      * 2 : rdma_recv_pci_bus_id
>> +      */
>> +     u8 validity;
>> +
>> +     /*
>> +      * Physical PCIe bus used by the device to reach the MR for receive
>> +      * operation
>> +      */
>> +     u8 recv_pci_bus_id;
>> +
>> +     /*
>> +      * Physical PCIe bus used by the device to reach the MR for RDMA read
>> +      * operation
>> +      */
>> +     u8 rdma_read_pci_bus_id;
>> +
>> +     /*
>> +      * Physical PCIe bus used by the device to reach the MR for RDMA write
>> +      * receive
>> +      */
>> +     u8 rdma_recv_pci_bus_id;
> What driver is bound to this other PCIe bus and how did the iommu get
> setup for it?
>
> Jason

It's internal bus that is not directly exposed to the host. Addresses
mapping is acquired from accelerator's driver as for any MR residing in
accelerator memory, and the translation is owned by devices on that bus.


Michael


