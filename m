Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8F9356D07
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbhDGNPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 09:15:17 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:17242 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhDGNPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1617801308; x=1649337308;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Io2xHX/3/x7uKpuAlzG/EzFRA28ao0Akn/KWiLDPlsg=;
  b=nEp844GMW9lN61oQOwP5AqxYwA/g2EcwQvFrAFXD6SuifCSHEqphCKR6
   XkUJp0ocLlPWolsV0TlONYOO8UV8QBSvRJZzz+QjlrhUJptHFXwZpBFRa
   cyAb8zyQPeBOOV1WT6Sjp3xfEXhyiZ5MUnHlpSTDKRFjayNfm1bd4Y282
   0=;
X-IronPort-AV: E=Sophos;i="5.82,203,1613433600"; 
   d="scan'208";a="125825008"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Apr 2021 13:14:57 +0000
Received: from EX13D19EUB003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id A9C56A1E5D;
        Wed,  7 Apr 2021 13:14:56 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.48) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Apr 2021 13:14:51 +0000
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
 <YG2n/nDhhQEGefFq@unreal>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <6d62496e-6bc7-4981-d3ef-5035c6fee93b@amazon.com>
Date:   Wed, 7 Apr 2021 16:14:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YG2n/nDhhQEGefFq@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.48]
X-ClientProxiedBy: EX13D02UWC002.ant.amazon.com (10.43.162.6) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/04/2021 15:39, Leon Romanovsky wrote:
>> @@ -1710,7 +1721,8 @@ static int nldev_set_sys_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
>>
>>       err = nlmsg_parse(nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
>>                         nldev_policy, extack);
>> -     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE])
>> +     if (err || !tb[RDMA_NLDEV_SYS_ATTR_NETNS_MODE] ||
>> +         tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
> 
> Why do we fail if user supplies RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK?

It's a read-only attribute, if someone tries to set its value I assume it's best
to return an error.
