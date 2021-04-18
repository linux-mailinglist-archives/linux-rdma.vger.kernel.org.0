Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85CE363503
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 14:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhDRMKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 08:10:08 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:11671 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhDRMKH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Apr 2021 08:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1618747780; x=1650283780;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IyL4wV7d4St/aLsgOtW7WJD7XT73SBKwdI9woHpZ1Ls=;
  b=Rbp9CHEQUY6HV5WU+YS8l+SxH/9qHIpFQVswdwL/CicXhSC2mZhwnFxZ
   EJYXpJ2Is1+iX7MFyLqDXbNh6ZBeNCNtmW9yTwKw33tpFBp9lKze81SaY
   UB16Bu1aZs3tHYK2TnpnK3FJZuwcAJejWDlcKE4Rakn61n1oAFe/HjPUI
   w=;
X-IronPort-AV: E=Sophos;i="5.82,231,1613433600"; 
   d="scan'208";a="108138122"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 18 Apr 2021 12:09:32 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-8cc5d68b.us-west-2.amazon.com (Postfix) with ESMTPS id 81AB8A071A;
        Sun, 18 Apr 2021 12:09:31 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.41) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 18 Apr 2021 12:09:26 +0000
Subject: Re: [PATCH for-next v3] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210412064150.40064-1-galpress@amazon.com>
 <YHP8DBn2lImpOUMZ@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <ebf47b5d-baa7-8e2b-fbc1-6d5a8dc3e3bb@amazon.com>
Date:   Sun, 18 Apr 2021 15:09:21 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHP8DBn2lImpOUMZ@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.41]
X-ClientProxiedBy: EX13D46UWB004.ant.amazon.com (10.43.161.204) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/04/2021 10:51, Leon Romanovsky wrote:
> On Mon, Apr 12, 2021 at 09:41:50AM +0300, Gal Pressman wrote:
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
>>
>> Don't backport this patch unless you also have the following series:
>> 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
>> and 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm").
>>
>> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
>> Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> ---
>> PR was sent:
>> https://github.com/linux-rdma/rdma-core/pull/975
>>
>> Changelog -
>> v2->v3: https://lore.kernel.org/linux-rdma/21317d2c-9a8e-0dd7-3678-d2933c5053c4@amazon.com/
>> * Remove check if copy-on-fork attribute was provided from nldev_set_sys_set_doit()
>>
>> v1->v2: https://lore.kernel.org/linux-rdma/20210405114722.98904-1-galpress@amazon.com/
>> * Remove nla_put_u8() return value check
>> * Add commit hashes to commit message and code comment
>> ---
>>  drivers/infiniband/core/nldev.c  | 11 +++++++++++
>>  include/uapi/rdma/rdma_netlink.h |  2 ++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
>> index b8dc002a2478..4889e06a581a 100644
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -146,6 +146,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
>>  	[RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID]	= { .type = NLA_U32 },
>>  	[RDMA_NLDEV_NET_NS_FD]			= { .type = NLA_U32 },
>>  	[RDMA_NLDEV_SYS_ATTR_NETNS_MODE]	= { .type = NLA_U8 },
>> +	[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]	= { .type = NLA_U8 },
>>  };
>>  
>>  static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
>> @@ -1697,6 +1698,16 @@ static int nldev_sys_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>  		nlmsg_free(msg);
>>  		return err;
>>  	}
>> +
>> +	/*
>> +	 * Copy-on-fork is supported.
>> +	 * See commits:
>> +	 * 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
>> +	 * 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
>> +	 * for more details. Don't backport this without them.
>> +	 */
>> +	nla_put_u8(msg, RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK, 1);
>> +
> 
> Nit, it is good to write here that we don't check nla_put_u8() on purpose.
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Thanks Leon!
