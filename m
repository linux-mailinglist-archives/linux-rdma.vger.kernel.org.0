Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC1D2297D6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgGVMEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 08:04:34 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59429 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgGVMEe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 08:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1595419474; x=1626955474;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NdsfPeUpgY6XMgpaR0sy0QEKs/zhoBxTDs8spyMWLxA=;
  b=nw56dWsPWz4FpCcHxegVdlqqo17KuyG5bBU5j0LXoQypM7dhMFF5pHpA
   YnKdy4Z9pgxHWp1vxAzzJxRUENU4TVypE4ebtEThmUJ/Ud3Viicx7S7DO
   dnJZLSZA+b4mwXU1vslBgCiP2L7rqJPbxK1Zikjz1aygiFf7S4WGv0vBg
   0=;
IronPort-SDR: 1vH2cB/rZW+6Wk38YriqZ6JayLj/Kkz055GPPjVqJ2R3qXxDAwo5jw/Ook+A6g33lmM9fykRYo
 jlhrYF+doaOA==
X-IronPort-AV: E=Sophos;i="5.75,381,1589241600"; 
   d="scan'208";a="61910581"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-60ce1996.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Jul 2020 12:04:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-60ce1996.us-west-2.amazon.com (Postfix) with ESMTPS id 5DB27A0341;
        Wed, 22 Jul 2020 12:04:30 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 12:04:29 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.48) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 22 Jul 2020 12:04:25 +0000
Subject: Re: [PATCH for-next v3 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200721133049.74349-1-galpress@amazon.com>
 <20200721133049.74349-4-galpress@amazon.com>
 <20200722115548.GH25301@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <15fcfced-0f4b-563e-7d7f-d448c66201c1@amazon.com>
Date:   Wed, 22 Jul 2020 15:04:20 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722115548.GH25301@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D06UWC003.ant.amazon.com (10.43.162.86) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 22/07/2020 14:55, Jason Gunthorpe wrote:
> On Tue, Jul 21, 2020 at 04:30:48PM +0300, Gal Pressman wrote:
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
>>  drivers/infiniband/hw/efa/efa_verbs.c | 49 +++++++++++++++++++++++++++
>>  include/uapi/rdma/efa-abi.h           | 10 ++++++
>>  2 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index 26102ab333b2..7ca40df81ee5 100644
>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>> @@ -1501,11 +1501,48 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
>>  	return efa_com_dealloc_uar(&dev->edev, &params);
>>  }
>>  
>> +#define EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)                         \
>> +	(!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask)))
>> +
>> +#define DEFINE_COMP_HANDSHAKE(_dev, _comp_mask, _attr, _mask)                  \
>> +	{                                                                      \
>> +		.attr = #_attr,                                                \
>> +		.check_comp = EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)   \
>> +	}
>> +
>> +int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
>> +			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
>> +{
>> +	struct efa_dev *dev = to_edev(ibucontext->device);
>> +	int i;
>> +	struct {
>> +		char *attr;
>> +		bool check_comp;
>> +	} user_comp_handshakes[] = {
>> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, max_tx_batch,
>> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
>> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, min_sq_depth,
>> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
>> +	};
> 
> This seems like a very expensive construct
> 
> Why have the array at all? Just list the macros and have them jump to
> err

Do you mean:

if (CHECK_COMP(x1)) {
    ibdev_dbg(err);
    goto err;
}

if (CHECK_COMP(x2)) {
    ibdev_dbg(err);
    goto err;
}

[...]

That adds much more boilerplate code for each feature. Or do you have something
else in mind?
