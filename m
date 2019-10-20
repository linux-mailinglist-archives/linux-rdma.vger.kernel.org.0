Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3610DDD2B
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Oct 2019 09:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfJTHTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Oct 2019 03:19:51 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:40847 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfJTHTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 20 Oct 2019 03:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571555989; x=1603091989;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RqFm/wTgGu0GQw5w2cyNIyZxO7MJYX+4KqfR5gj8Kow=;
  b=oRoXBOhzSPDMdVxPQ8EfgzUlCFwJJjl+mGGP4DvKXXoYVpBP4c2WN3Ct
   Xp/osuiD+iwFQfPs4meG4mPdnSJOhYYrk7VGvDp+SeVH6p5sGeKk4writ
   b89NVaK54WJFMaNu1hv5F3tKfJJpAcmU8LjmBcGFLJq29ccO/n27qIIU/
   E=;
X-IronPort-AV: E=Sophos;i="5.67,318,1566864000"; 
   d="scan'208";a="424858393"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Oct 2019 07:19:48 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id BBF4A2821E9;
        Sun, 20 Oct 2019 07:19:46 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 20 Oct 2019 07:19:46 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.180) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 20 Oct 2019 07:19:40 +0000
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
To:     Michal Kalderon <mkalderon@marvell.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
 <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
Date:   Sun, 20 Oct 2019 10:19:34 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.180]
X-ClientProxiedBy: EX13D12UWA003.ant.amazon.com (10.43.160.50) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/09/2019 12:31, Michal Kalderon wrote:
>> From: Pressman, Gal <galpress@amazon.com>
>> Sent: Tuesday, September 24, 2019 11:50 AM
>>
>>
>>> On 23 Sep 2019, at 18:22, Michal Kalderon <mkalderon@marvell.com>
>> wrote:
>>>
>>>
>>>>
>>>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>>>> owner@vger.kernel.org> On Behalf Of Gal Pressman
>>>>
>>>>> On 19/09/2019 20:55, Jason Gunthorpe wrote:
>>>>> Huh. If you recall we did all this work with the XA and the free
>>>>> callback because you said qedr was mmaping BAR pages that had some
>>>>> HW lifetime associated with them, and the HW resource was not to be
>>>>> reallocated until all users were gone.
>>>>>
>>>>> I think it would be a better example of this API if you pulled the
>>>>>
>>>>>    dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
>>>>>
>>>>> Into qedr_mmap_free().
>>>>>
>>>>> Then the rdma_user_mmap_entry_remove() will call it naturally as it
>>>>> does entry_put() and if we are destroying the ucontext we already
>>>>> know the mmaps are destroyed.
>>>>>
>>>>> Maybe the same basic comment for EFA, not sure. Gal?
>>>>
>>>> That's what EFA already does in this series, no?
>>>> We no longer remove entries on dealloc_ucontext, only when the entry
>>>> is freed.
>>>
>>> Actually, I think most of the discussions you had on the topic were
>>> with Gal, but Some apply to qedr as well, however, for qedr, the only
>>> hw resource we allocate (bar) is on alloc_ucontext , therefore we were
>>> safe to free it on dealloc_ucontext as all mappings were already
>>> zapped. Making the mmap_free a bit redundant for qedr except for the
>> need to free the entry.
>>>
>>> For EFA, it seemed the only operation delayed was freeing memory - I
>>> didn't see hw resources being freed... Gal?
>>
>> What do you mean by hw resources being freed? The BAR mappings are
>> under the device’s control and are associated to the lifetime of the UAR.
> The bar offset you get is from the device -> don't you release it back to the device
> So it can be allocated to a different application ? 
> In efa_com_create_qp -> you get offsets from the device that you use for mapping
> The bar -> are these unique for every call ? are they released during destroy_qp ? 
> Before this patch series mmap_entries_remove_free only freed the DMA pages, but
> Following this thread, it seemed the initial intention was that only the hw resources would
> Be delayed as the DMA pages are ref counted anyway.  I didn't see any delay to returning
> The bar offsets to the device. Thanks.
The BAR pages are being "freed" back to the device once the UAR is freed.
These pages' lifetime is under the control of the device so there's nothing the
driver needs to do, just make sure no one else is using them.
