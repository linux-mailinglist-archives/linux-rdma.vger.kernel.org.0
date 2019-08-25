Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB959C2E5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Aug 2019 12:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfHYKkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Aug 2019 06:40:14 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:45247 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfHYKkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Aug 2019 06:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566729613; x=1598265613;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Kv9VlaCzW1X8AAcO78RgJktV7LOpRCe1+UJSNhqF/zw=;
  b=BFUT5EkGKtYTooniVz6TE72WLQb5FY+1iOl/KQ7PpGAiJ8l2HQFA3YD8
   B+ajCkzIehau+hRp1/vBbRnIOs0AuNrFnYSEowi80sGGuZGt7f3RVxRLy
   6HK0zjty+rjdCYn3NaTPJOnL1N15zQszDn1xxXOvGw3K/P5IjBgyj+UHI
   s=;
X-IronPort-AV: E=Sophos;i="5.64,429,1559520000"; 
   d="scan'208";a="781268488"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Aug 2019 10:39:58 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id AAEE4A1DFA;
        Sun, 25 Aug 2019 10:39:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 25 Aug 2019 10:39:55 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.67) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 25 Aug 2019 10:39:51 +0000
Subject: Re: [PATCH v7 rdma-next 2/7] RDMA/core: Create mmap database and
 cookie helper functions
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Ariel Elior <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190820121847.25871-1-michal.kalderon@marvell.com>
 <20190820121847.25871-3-michal.kalderon@marvell.com>
 <3b297196-1ef6-c046-d0b2-c68648a50913@amazon.com>
 <MN2PR18MB31820859BDBA0B87D0830935A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <10dc3958-7968-a3dc-3ab5-a64a270bdfdb@amazon.com>
Date:   Sun, 25 Aug 2019 13:39:46 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB31820859BDBA0B87D0830935A1A60@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.67]
X-ClientProxiedBy: EX13D01UWB001.ant.amazon.com (10.43.161.75) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 25/08/2019 11:36, Michal Kalderon wrote:
>>> diff --git a/drivers/infiniband/core/rdma_core.c
>>> b/drivers/infiniband/core/rdma_core.c
>>> index ccf4d069c25c..7166741834c8 100644
>>> --- a/drivers/infiniband/core/rdma_core.c
>>> +++ b/drivers/infiniband/core/rdma_core.c
>>> @@ -817,6 +817,7 @@ static void ufile_destroy_ucontext(struct
>> ib_uverbs_file *ufile,
>>>  	rdma_restrack_del(&ucontext->res);
>>>
>>>  	ib_dev->ops.dealloc_ucontext(ucontext);
>>> +	rdma_user_mmap_entries_remove_free(ucontext);
>>
>> Why did you switch the order again?
> To enable drivers to remove the entries from the mmap_xa otherwise entires_remove_free
> Will run into a mmap_xa that is not empty. I should have mentioned this in the cover letter. 

I don't understand.
Do you expect drivers to explicitly drain the mmap xarray during
dealloc_ucontext? I didn't see that in the EFA patch.

I still think the xarray should be cleared prior to calling the driver's
dealloc_ucontext.
