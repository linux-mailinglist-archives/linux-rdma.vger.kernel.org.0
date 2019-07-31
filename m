Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB59A7C832
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfGaQJu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 12:09:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:28194 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfGaQJt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Jul 2019 12:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564589388; x=1596125388;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u/iKZf/NTWKeYtuv+X+3F0b0UJUZhY5LP6X5dvuvxTw=;
  b=m5rErEExtXwfaiTNuyu/bfqQgtckFFugQj5dDwsmPdJ49KTlNsCM3KNG
   rQ8x6OAI3FDgeC+mwjbdiZiqjrrBcI56bTJbtTK5Q8j/TyL7gzylWRLj8
   alNTzmNOELNZ/8PJzJPZczS3hTAaWKNfA9ymlDCMXoNCmAl5iAZ6t/COT
   4=;
X-IronPort-AV: E=Sophos;i="5.64,330,1559520000"; 
   d="scan'208";a="407469620"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 31 Jul 2019 16:09:41 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id BE5DBA2784;
        Wed, 31 Jul 2019 16:09:40 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 16:09:40 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.137) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 31 Jul 2019 16:09:36 +0000
Subject: Re: [PATCH for-rc v2] RDMA/restrack: Track driver QP types in
 resource tracker
To:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
References: <20190730133720.62548-1-galpress@amazon.com>
 <20190730152216.GF4878@mtr-leonro.mtl.com>
 <3c9eafe8ae94190128b82329711f5f3772756406.camel@redhat.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <61a6cbd6-770d-4653-d854-33efde3e11cc@amazon.com>
Date:   Wed, 31 Jul 2019 19:09:30 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3c9eafe8ae94190128b82329711f5f3772756406.camel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.137]
X-ClientProxiedBy: EX13D05UWB003.ant.amazon.com (10.43.161.26) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 31/07/2019 18:36, Doug Ledford wrote:
> On Tue, 2019-07-30 at 18:22 +0300, Leon Romanovsky wrote:
>> On Tue, Jul 30, 2019 at 04:37:20PM +0300, Gal Pressman wrote:
>>> The check for QP type different than XRC has wrongly excluded driver
>>> QP
>>> types from the resource tracker.
>>> As a result, "rdma resource show" user command would not show opened
>>> driver QPs which does not reflect the real state of the system.
>>>
>>> Check QP type explicitly instead of improperly assuming enum
>>> values/ordering.
>>>
>>> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create
>>> and destroy QPs")
>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>> ---
>>> v2:
>>> * Improve commit message
>>
>> Please finish review of v0 and give enough time for reviewers to see
>> patch and post their notes before resending.
> 
> Gal, Leon was right in his comments to the v1 of this patch in terms of
> the original code not being broken prior to the existence of driver qp
> types.

Driver QP types existed before EFA was merged, and they existed when the
restrack commit was merged. So if driver QP types should be counted the restrack
commit is the one that "broke" it, not EFA.
If driver QP types were introduced in commit X, where X comes after the restrack
commit then it makes sense to target the Fixes line to commit X, but this is not
the case here.

Anyway, I'll change it to EFA as requested.

> This fix isn't needed until after the EFA driver is merged, and
> the Fixes: tag is used in order for scripts to know if they need to take
> a patch because they've already taken the patch prior.  So the Fixes tag
> needs to be the EFA driver, not the original resource tracking commit,
> as there is no issue unless the EFA driver is placed on top of the
> original resource tracking commit.  Please resubmit with a proper commit
> message and fixes tag.

Thanks, As Leon mentioned I posted v2 before v1 discussion was finished. I'll
resubmit.
