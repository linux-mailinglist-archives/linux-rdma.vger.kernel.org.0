Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18DA356D55
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbhDGNb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 09:31:27 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:32678 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDGNbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 09:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617802273; x=1649338273;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=i7hlHMG28rhEXW1gdvzu6kYB/Chk8WSxsF3sJB/4Zi8=;
  b=W1Mq2OYNwva+X07B9Vn2DDJYbMoG/yKmnkUVLkhBnFKRj5z1A2/BbvhK
   gYNXKXkLzzkX2U6drpTyKS+2Eq+VvbvnbwYsAoidmml5mgYg53qIv63j1
   N0x2FY2X0myP2h2djVPguCf4zbFkgXVBz7Rmu8IwYtIodes1SrmZUrhJQ
   E=;
X-IronPort-AV: E=Sophos;i="5.82,203,1613433600"; 
   d="scan'208";a="100027995"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Apr 2021 13:31:02 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 85741A284D;
        Wed,  7 Apr 2021 13:31:00 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.161.102) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Apr 2021 13:30:56 +0000
Subject: Re: [PATCH for-next v2] RDMA/nldev: Add copy-on-fork attribute to get
 sys command
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210407101606.80737-1-galpress@amazon.com>
 <YG2n/nDhhQEGefFq@unreal> <6d62496e-6bc7-4981-d3ef-5035c6fee93b@amazon.com>
 <YG2yY2PW2AJgA02J@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <010c6b45-a9b0-67c7-82e3-78533a532225@amazon.com>
Date:   Wed, 7 Apr 2021 16:30:50 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG2yY2PW2AJgA02J@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.102]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/04/2021 16:23, Leon Romanovsky wrote:
> On Wed, Apr 07, 2021 at 04:14:46PM +0300, Gal Pressman wrote:
>> On 07/04/2021 15:39, Leon Romanovsky wrote:
>>>> @@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>>>
>>>>       err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
>>>>                         nldev_policy, extack);
>>>> -     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
>>>> +     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
>>>> +         tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>>
>>> Why do we fail if user supplies RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK?
>>
>> It's a read-only attribute, if someone tries to set its value I assume it's best
>> to return an error.
> 
> Not in netlink world, you need to ignore the parameters that
> you don't "know how to handle" and check for must-to-be input only.

Not sure I understand.
So you expect the set function to remain unchanged in this patch? Isn't it bad
that a user can request to change the copy on fork value and get a success
return value although nothing happened?
