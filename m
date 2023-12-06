Return-Path: <linux-rdma+bounces-288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B039807793
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3033D28103C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC9236F;
	Wed,  6 Dec 2023 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bpMv3trU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB218D
	for <linux-rdma@vger.kernel.org>; Wed,  6 Dec 2023 10:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701887460; x=1733423460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ine9jAKgz4KEErI4Q2ykU8++pbSGgJfhb0e0KC8JIcM=;
  b=bpMv3trUB/7CQvkq3q32RjHNGNJFhvt5EKjoY2Misizm1rlWNyqC+QUD
   FIo4b6AJMan5M++wkPgzqav4XCZqKsD7szkp3QXQ+0kpgNUAb8qkw874T
   C3Mt4cVtqgIpEgg4rl+Ezr82Q6knxZRm9W2pV9WDvKvu3fl05iItoFvrm
   I=;
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="689372261"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:30:54 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-8c5b1df3.us-west-2.amazon.com (Postfix) with ESMTPS id 133EE40DAE;
	Wed,  6 Dec 2023 18:30:53 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:42486]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.81:2525] with esmtp (Farcaster)
 id be744477-a396-438c-ba3f-f1a719ff9d93; Wed, 6 Dec 2023 18:30:52 +0000 (UTC)
X-Farcaster-Flow-ID: be744477-a396-438c-ba3f-f1a719ff9d93
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 18:30:46 +0000
Received: from [192.168.128.189] (10.85.143.179) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 18:30:43 +0000
Message-ID: <3df3da6b-9c8b-4bea-b9e0-25f2a06f71e5@amazon.com>
Date: Wed, 6 Dec 2023 20:30:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] RDMA/efa: Add EFA query MR support
Content-Language: en-US
To: Gal Pressman <gal.pressman@linux.dev>, <jgg@nvidia.com>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <sleybo@amazon.com>, <matua@amazon.com>, Anas Mousa <anasmous@amazon.com>,
	Firas Jahjah <firasj@amazon.com>
References: <20231205221606.26436-1-mrgolin@amazon.com>
 <08c5ccbe-1f9a-4e4d-b6bd-91ef62ef1b5b@linux.dev>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <08c5ccbe-1f9a-4e4d-b6bd-91ef62ef1b5b@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)

Hey Gal,

Thanks for your comments.

On 12/6/2023 4:52 PM, Gal Pressman wrote:
> Hi Michael,
>
> On 06/12/2023 0:16, Michael Margolin wrote:
>> @@ -432,6 +435,9 @@ static int efa_ib_device_add(struct efa_dev *dev)
>>
>>       ib_set_device_ops(&dev->ibdev, &efa_dev_ops);
>>
>> +     if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
> EFA depends on CONFIG_INFINIBAND_USER_ACCESS:
>
>       7 config INFINIBAND_EFA
>       8         tristate "Amazon Elastic Fabric Adapter (EFA) support"
>       9         depends on PCI_MSI && 64BIT && !CPU_BIG_ENDIAN
>      10         depends on INFINIBAND_USER_ACCESS

I'll remove this if statement.

>> +             dev->ibdev.driver_def = efa_uapi_defs;
>> +
>>       err = ib_register_device(&dev->ibdev, "efa_%d", &pdev->dev);
>>       if (err)
>>               goto err_destroy_eqs;
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index 0f8ca99d0827..d81904f4b876 100644
>> --- a/drivers/infiniband/hw/efa/efa_verbs.c
>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>> @@ -13,6 +13,9 @@
>>  #include <rdma/ib_user_verbs.h>
>>  #include <rdma/ib_verbs.h>
>>  #include <rdma/uverbs_ioctl.h>
>> +#define UVERBS_MODULE_NAME efa_ib
>> +#include <rdma/uverbs_named_ioctl.h>
>> +#include <rdma/ib_user_ioctl_cmds.h>
>>
>>  #include "efa.h"
>>  #include "efa_io_defs.h"
>> @@ -1653,6 +1656,9 @@ static int efa_register_mr(struct ib_pd *ibpd, struct efa_mr *mr, u64 start,
>>       mr->ibmr.lkey = result.l_key;
>>       mr->ibmr.rkey = result.r_key;
>>       mr->ibmr.length = length;
>> +     mr->recv_pci_bus_id = result.recv_pci_bus_id;
>> +     mr->rdma_read_pci_bus_id = result.rdma_read_pci_bus_id;
>> +     mr->rdma_recv_pci_bus_id = result.rdma_recv_pci_bus_id;
> Why is a query_mr ioctl better than returning this data through udata on
> MR creation?

We need this for both reg_user_mr and reg_user_mr_dmabuf and it doesn't
make sense to implement it twice. In addition, those two verbs are using
different mechanisms (write and ioctl) and extending dmabuf reg_mr will
require more extensive changes on rdma-core side.

Michael


