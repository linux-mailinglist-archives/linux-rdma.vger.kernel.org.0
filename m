Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462AD4048CE
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhIILBc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 07:01:32 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:31222 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbhIILBb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 07:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1631185222; x=1662721222;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=uKOWU3TnndiUpABkDd9Pfvuypdl8twPwypgh2ZuG+ls=;
  b=YXmqlQ+TaV0wTUaSjziLCBoxYMLvQ6I9r6OBOoYWVY3IfzfGw05gQj1H
   2EC2GjFsoy1GdsmtZpkORPFChru3bk8UfvGb1boh+OMpxCfFFeiJiwvGS
   h3TJ0WOGvtGVKzH+9s4Pdvlg0oYc9sHBnhib5U9JTHHGtBw1+fUlctj6P
   g=;
X-IronPort-AV: E=Sophos;i="5.85,280,1624320000"; 
   d="scan'208";a="956573303"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 09 Sep 2021 11:00:14 +0000
Received: from EX13D19EUB003.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id EDC723C1831;
        Thu,  9 Sep 2021 11:00:12 +0000 (UTC)
Received: from 8c85908914bf.ant.amazon.com (10.43.160.106) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 9 Sep 2021 11:00:07 +0000
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20210902151029.GV1721383@nvidia.com>
 <f80c3b52-d38b-3045-0fcc-b27f1f7b8c0d@amazon.com>
 <20210902154124.GX1721383@nvidia.com>
 <9ffde1c4-d748-0091-0d7d-b2e2eb63aa51@amazon.com> <YTR4yhTyYi323lqe@unreal>
 <dc14a576-c696-bba7-f7a4-1fc00ff3d293@amazon.com> <YTSh+wU572k00WVS@unreal>
 <2231dfa4-2f99-5187-fa83-56052dad9979@amazon.com> <YTTCycq4KTBk6r/s@unreal>
 <ed19464f-d046-bc10-ec17-180f7c54ef13@amazon.com>
 <20210907113135.GE2505917@nvidia.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <002ea7b9-42b1-84f0-a094-638215ee23b9@amazon.com>
Date:   Thu, 9 Sep 2021 14:00:00 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210907113135.GE2505917@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.106]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 07/09/2021 14:31, Jason Gunthorpe wrote:
> On Sun, Sep 05, 2021 at 05:36:23PM +0300, Gal Pressman wrote:
> 
>>> I can't say if it is needed or not, just wanted to understand why you need
>>> complexity in destroy_cq path.
>>
>> Well, as I said, I don't think the restrack protection is enough in this case as
>> it isn't aware of the concurrent eq flow.
>>
>> I guess I can put a synchronize_irq() on destroy_cq flow to get rid of the race.
> 
> That is a better choice that synchronize_rcu(), IIRC
> 
> synchronize_rcu should be avoided compared to all other forms of
> synchronization because it can take seconds per call to complete, and
> in a reasonable verbs app this means potentially minutes to close the
> verbs FD and destroy many CQs.

Got it, will use synchronize_irq, thanks.
