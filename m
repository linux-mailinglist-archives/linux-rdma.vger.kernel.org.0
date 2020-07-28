Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F014230AF5
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgG1NHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 09:07:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:19182 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgG1NHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 09:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595941666; x=1627477666;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=blxymvvGiIyMik9b9B51yKzQZ6Rwaipe8gIm6l3w0l8=;
  b=uujA63iyptKUW/2EilYSJTkJ4EFM6wN5nXPBE/n7vdlfRgcorEDLRDB3
   8F+Y/djVHBUUuqKE/cNaVYCtCriA0uA3XSR6/iTfDlETR2VAbG7PmYYFN
   20neBEG3G1SQJh9f69aTIm2GVgEc/ZrXug83DgNedWLkNiDl6uCppLhaD
   4=;
IronPort-SDR: 4NFVWAu0zLwImUZ4b7nDgpnTXIDKBZGUvrg0ktX36ZYM9yej+kgGQpwmftzp/GQ+ILBDvcfuU2
 Fc8frbDfpjEQ==
X-IronPort-AV: E=Sophos;i="5.75,406,1589241600"; 
   d="scan'208";a="44472984"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 28 Jul 2020 13:07:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 4B7FDA27B7;
        Tue, 28 Jul 2020 13:07:42 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 13:07:41 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.34) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 13:07:37 +0000
Subject: Re: [PATCH for-next v4 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200722140312.3651-1-galpress@amazon.com>
 <20200722140312.3651-4-galpress@amazon.com>
 <20200727185633.GA70218@nvidia.com>
 <1efd7d21-2e4d-46b8-fbdf-47c4bb5553fe@amazon.com>
 <20200728122823.GA16789@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <16763489-c528-8603-7b8e-718576bfdac8@amazon.com>
Date:   Tue, 28 Jul 2020 16:07:31 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728122823.GA16789@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.34]
X-ClientProxiedBy: EX13D34UWC003.ant.amazon.com (10.43.162.66) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 28/07/2020 15:28, Jason Gunthorpe wrote:
> On Tue, Jul 28, 2020 at 02:50:18PM +0300, Gal Pressman wrote:
>> On 27/07/2020 21:56, Jason Gunthorpe wrote:
>>> On Wed, Jul 22, 2020 at 05:03:11PM +0300, Gal Pressman wrote:
>>>> Introduce a mechanism that performs an handshake between the userspace
>>>> provider and kernel driver which verifies that the user supports all
>>>> required features in order to operate correctly.
>>>>
>>>> The handshake verifies the needed functionality by comparing the
>>>> reported device caps and the provider caps. If the device reports a
>>>> non-zero capability the appropriate comp mask is required from the
>>>> userspace provider in order to allocate the context.
>>>>
>>>> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
>>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>>  drivers/infiniband/hw/efa/efa_verbs.c | 40 +++++++++++++++++++++++++++
>>>>  include/uapi/rdma/efa-abi.h           | 10 +++++++
>>>>  2 files changed, 50 insertions(+)
>>>>
>>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>>>> index 26102ab333b2..fda175836fb6 100644
>>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>>>> @@ -1501,11 +1501,39 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
>>>>  	return efa_com_dealloc_uar(&dev->edev, &params);
>>>>  }
>>>>  
>>>> +#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
>>>> +	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
>>>> +		     NULL : #_attr)
>>>> +
>>>> +static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
>>>> +				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
>>>> +{
>>>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>>>> +	char *attr_str;
>>>> +
>>>> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
>>>> +				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
>>>> +		goto err;
>>>> +
>>>> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
>>>> +				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
>>>> +				attr_str))
>>>> +		goto err;
>>>
>>> But this patch should be first, the kernel should never return a
>>> non-zero value unless these input bits are set
>>
>> But that's exactly what this patch does, it can only fail in case
>> max_tx_batch/min_sq_depth is turned on by the device.
> 
> My point is the series is out of order, the introduction of the two
> uapi parts should be in the same patch
> 
>> Anyway, the order doesn't matter as long as the pciid patch is last.
> 
> Oh?

0xefa0 devices will not turn on these bits, so as long as the 0xefa1 patch is
last this order is fine.
