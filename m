Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362163541FB
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 14:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhDEMPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 08:15:47 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:22886 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbhDEMPr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Apr 2021 08:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617624941; x=1649160941;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nRvdDHS3SWYJkDXmG8PykaKJn5vUYA42yTtwcy4+eHM=;
  b=O8zf+AN6LdtmKNLdG2+ytRneuaf1Lfxjkfqw6RcRTOBXKIwvShLql4lL
   CWZx3g1UtqJKsAA6iNjllZDMs7w9jsu8jI4kNdOvLuhtTJ9mzywPGzyQs
   FM9buxf9XwGfkawbS10Rm16VOSNEOJOgppqgMLPtfai3mkc5LngIfWyUY
   E=;
X-IronPort-AV: E=Sophos;i="5.81,306,1610409600"; 
   d="scan'208";a="923598929"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 05 Apr 2021 12:15:28 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 32CEFA1939;
        Mon,  5 Apr 2021 12:15:26 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.244) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 5 Apr 2021 12:15:23 +0000
Subject: Re: [PATCH for-next] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210405114722.98904-1-galpress@amazon.com>
 <YGr7EajqXvSGyZfy@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <d8ec4f81-25a6-7243-12c4-af4f5b64a27f@amazon.com>
Date:   Mon, 5 Apr 2021 15:15:18 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGr7EajqXvSGyZfy@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.244]
X-ClientProxiedBy: EX13D08UWC001.ant.amazon.com (10.43.162.110) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/04/2021 14:57, Leon Romanovsky wrote:
> On Mon, Apr 05, 2021 at 02:47:21PM +0300, Gal Pressman wrote:
>> The new attribute indicates that the kernel copies DMA pages on fork,
>> hence libibverbs' fork support through madvise and MADV_DONTFORK is not
>> needed.
>>
>> The introduced attribute is always reported as supported since the
>> kernel has the patch that added the copy-on-fork behavior. This allows
>> the userspace library to identify older vs newer kernel versions.
>> Extra care should be taken when backporting this patch as it relies on
>> the fact that the copy-on-fork patch is merged, hence no check for
>> support is added.
> 
> Please be more specific, add SHA-1 of that patch and wrote the same
> comment near "err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK,
> 1);" line.
> 
> Thanks

Should I put the original commit here? There were quite a lot of bug fixes and
followups that are required.

>>
>> Copy-on-fork attribute is read-only, trying to change it through the set
>> sys command will result in an error.
>>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>> PR was sent:
>> https://github.com/linux-rdma/rdma-core/pull/975
>> ---
>>  drivers/infiniband/core/nldev.c  | 19 ++++++++++++++-----
>>  include/uapi/rdma/rdma_netlink.h |  2 ++
>>  2 files changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index b8dc002a2478..87c68301c25b 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>>       [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]      = { .type = NLA_U32 },
>>       [RDMA_NLDEV_NET_NS_FD]                  = { .type = NLA_U32 },
>>       [RDMA_NLDEV_SYS_ATTR_NETNS_MODE]        = { .type = NLA_U8 },
>> +     [RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]      = { .type = NLA_U8 },
>>  };
>>
>>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
>> @@ -1693,12 +1694,19 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>
>>       err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_NETNS_MODE,
>>                        (u8)ib_devices_shared_netns);
>> -     if (err) {
>> -             nlmsg_free(msg);
>> -             return err;
>> -     }
>> +     if (err)
>> +             goto err_nlmsg_free;
>> +
>> +     err = nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
>> +     if (err)
>> +             goto err_nlmsg_free;
> 
> Is it important to have an ability to fail here? Can we simply ignore
> failure?

Should be fine.

Thanks
