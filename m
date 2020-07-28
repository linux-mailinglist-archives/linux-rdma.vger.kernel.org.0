Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78F9230925
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jul 2020 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgG1Luc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jul 2020 07:50:32 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:51812 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgG1Lub (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jul 2020 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595937031; x=1627473031;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=w2VazeQFh+Bwsj8mjcpuPT1Eb2J7hZ/26Ei0Nu6XEio=;
  b=G/yCWPWA9/62wN46cFA2kXZn2bt+6TLJ9Igunxunx+ayOevy0ePkciaT
   wn1GkWh0TAtkSg2CN2o3CuM7Ka4AUT16pexIOE2LsxpPehqLXAYQKbtV6
   LgaQEs3bECOj837VK5aN5H0I8sxOGkeofFJFgJbJWiznOknmI1sWcNbOi
   w=;
IronPort-SDR: y559Otk63xTqggDHpLqEeNdf9ZUHI24Xabmq9CVKgAiJ5BV2/dT9GuHDGSnka8j3y2s4bPoymX
 ZVx/EXPhsV/A==
X-IronPort-AV: E=Sophos;i="5.75,406,1589241600"; 
   d="scan'208";a="44526273"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 28 Jul 2020 11:50:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id CB58EA2618;
        Tue, 28 Jul 2020 11:50:28 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 11:50:27 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.100) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 28 Jul 2020 11:50:23 +0000
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
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <1efd7d21-2e4d-46b8-fbdf-47c4bb5553fe@amazon.com>
Date:   Tue, 28 Jul 2020 14:50:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727185633.GA70218@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D38UWC003.ant.amazon.com (10.43.162.23) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 27/07/2020 21:56, Jason Gunthorpe wrote:
> On Wed, Jul 22, 2020 at 05:03:11PM +0300, Gal Pressman wrote:
>> Introduce a mechanism that performs an handshake between the userspace
>> provider and kernel driver which verifies that the user supports all
>> required features in order to operate correctly.
>>
>> The handshake verifies the needed functionality by comparing the
>> reported device caps and the provider caps. If the device reports a
>> non-zero capability the appropriate comp mask is required from the
>> userspace provider in order to allocate the context.
>>
>> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>  drivers/infiniband/hw/efa/efa_verbs.c | 40 +++++++++++++++++++++++++++
>>  include/uapi/rdma/efa-abi.h           | 10 +++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index 26102ab333b2..fda175836fb6 100644
>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>> @@ -1501,11 +1501,39 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
>>  	return efa_com_dealloc_uar(&dev->edev, &params);
>>  }
>>  
>> +#define EFA_CHECK_USER_COMP(_dev, _comp_mask, _attr, _mask, _attr_str) \
>> +	(_attr_str = (!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask))) ? \
>> +		     NULL : #_attr)
>> +
>> +static int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
>> +				   const struct efa_ibv_alloc_ucontext_cmd *cmd)
>> +{
>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>> +	char *attr_str;
>> +
>> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, max_tx_batch,
>> +				EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH, attr_str))
>> +		goto err;
>> +
>> +	if (EFA_CHECK_USER_COMP(dev, cmd->comp_mask, min_sq_depth,
>> +				EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR,
>> +				attr_str))
>> +		goto err;
> 
> But this patch should be first, the kernel should never return a
> non-zero value unless these input bits are set

But that's exactly what this patch does, it can only fail in case
max_tx_batch/min_sq_depth is turned on by the device.

Anyway, the order doesn't matter as long as the pciid patch is last.
