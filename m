Return-Path: <linux-rdma+bounces-347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6D80C6BA
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 11:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59C41C20B9E
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Dec 2023 10:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6F125541;
	Mon, 11 Dec 2023 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WZfGbbwF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091691
	for <linux-rdma@vger.kernel.org>; Mon, 11 Dec 2023 02:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702290960; x=1733826960;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=cMniPBwFWa7g1/nAQ6OyLg+yus8pJu9UWK0tI2iwpLI=;
  b=WZfGbbwFxDTfjn4E3929Ccv25Ojnkd3PiaMem2sjI7LbMkJc9qORG4C0
   MeDaf8C+OCdRuRmwlIcFRnge5stf5zHiHG/TSTQ2S/rCn1xkcpFC9ha/3
   pmYJF+kCpO7tFZDXIUsQhdzUKppYGAyrNtJiU/JJG/GPemDeNfSiASFf0
   U=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="690253807"
Subject: Re: [PATCH for-next v2] RDMA/efa: Add EFA query MR support
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:35:52 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 08A2049269;
	Mon, 11 Dec 2023 10:35:46 +0000 (UTC)
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:49568]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.156:2525] with esmtp (Farcaster)
 id 0e0d7ed7-6ab5-4070-bb9b-64d9c0a5b7a2; Mon, 11 Dec 2023 10:35:45 +0000 (UTC)
X-Farcaster-Flow-ID: 0e0d7ed7-6ab5-4070-bb9b-64d9c0a5b7a2
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:35:43 +0000
Received: from [192.168.131.194] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:35:39 +0000
Message-ID: <c9bfd0e3-3640-46da-8a9b-4391c90ed1aa@amazon.com>
Date: Mon, 11 Dec 2023 12:35:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <sleybo@amazon.com>,
	<matua@amazon.com>, <gal.pressman@linux.dev>, Anas Mousa
	<anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20231207142748.10345-1-mrgolin@amazon.com>
 <20231211081032.GB4870@unreal>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20231211081032.GB4870@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)


On 12/11/2023 10:10 AM, Leon Romanovsky wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Thu, Dec 07, 2023 at 02:27:48PM +0000, Michael Margolin wrote:
>> Add EFA driver uapi definitions and register a new query MR method that
>> currently returns the physical PCI buses' IDs the device is using to
>> reach the MR. Update admin definitions and efa-abi accordingly.
>>
>> Reviewed-by: Anas Mousa <anasmous@amazon.com>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>>  drivers/infiniband/hw/efa/efa.h               |  5 +-
>>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 31 ++++++++
>>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  6 ++
>>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  4 +
>>  drivers/infiniband/hw/efa/efa_main.c          |  5 ++
>>  drivers/infiniband/hw/efa/efa_verbs.c         | 77 +++++++++++++++++++
>>  include/uapi/rdma/efa-abi.h                   | 19 +++++
>>  7 files changed, 146 insertions(+), 1 deletion(-)
> <...>
>
>> +     /*
>> +      * Mask indicating which fields have valid values
>> +      * 0 : recv_pci_bus_id
>> +      * 1 : rdma_read_pci_bus_id
>> +      * 2 : rdma_recv_pci_bus_id
>> +      */
>> +     u8 validity;
> <...>
>
>>  #define EFA_GID_SIZE 16
>> +#define EFA_INVALID_PCI_BUS_ID 0xffff
> Is 0xffff value guaranteed by PCI subsystem to be invalid? Why don't you
> provide "validity" field to userspace instead?

The 0xffff value in only used internally in the driver to indicate an
invalid id and isn't exposed to userspace. For userspace there is a
validity field as you suggested:

+       return uverbs_copy_to(attrs,
EFA_IB_ATTR_QUERY_MR_RESP_PCI_BUS_ID_VALIDITY,
+                             &pci_bus_id_validity,
sizeof(pci_bus_id_validity));


Thanks


