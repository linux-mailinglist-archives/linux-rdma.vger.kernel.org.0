Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F956E1251
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfJWGk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 02:40:59 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55989 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfJWGk7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 02:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1571812858; x=1603348858;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NKaK3t49bbVBVNWjMYywB6uNwSewTXIml7JVFPCNVTs=;
  b=pFJjIWIFzZhlBvfWa8L+oOFT9RyG1KOdI/+P9B5kVyQnZmwH7o+Gm5q6
   RVTRtphoOLh2A+brtkK0lncJgUMRn2IH3Jz6LUSBMPfj6WILFoZcSviIN
   SYbD/28tTqVa+gzPglooOftKYdTrNeDBz3M7tvDKmy2+5v/ldJqZYXhji
   o=;
X-IronPort-AV: E=Sophos;i="5.68,219,1569283200"; 
   d="scan'208";a="762194683"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Oct 2019 06:40:55 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id EEFB9A2353;
        Wed, 23 Oct 2019 06:40:54 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 23 Oct 2019 06:40:54 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.223) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 23 Oct 2019 06:40:50 +0000
Subject: Re: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
 <4A66AD43-246B-4256-BA99-B61D3F1D05A8@amazon.com>
 <MN2PR18MB3182999F3ACFC93455B887C8A1840@MN2PR18MB3182.namprd18.prod.outlook.com>
 <f7f91641-6a80-2c06-2d4a-9045b876daff@amazon.com>
 <20191021173349.GH25178@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <215079fa-03bc-1b5b-dfbe-561f6072de94@amazon.com>
Date:   Wed, 23 Oct 2019 09:40:44 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021173349.GH25178@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13D27UWA001.ant.amazon.com (10.43.160.19) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 21/10/2019 20:33, Jason Gunthorpe wrote:
> On Sun, Oct 20, 2019 at 10:19:34AM +0300, Gal Pressman wrote:
>> On 24/09/2019 12:31, Michal Kalderon wrote:
>>>> From: Pressman, Gal <galpress@amazon.com>
>>>> Sent: Tuesday, September 24, 2019 11:50 AM
>>>>
>>>>
>>>>> On 23 Sep 2019, at 18:22, Michal Kalderon <mkalderon@marvell.com>
>>>> wrote:
>>>>>
>>>>>
>>>>>>
>>>>>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>>>>>> owner@vger.kernel.org> On Behalf Of Gal Pressman
>>>>>>
>>>>>>> On 19/09/2019 20:55, Jason Gunthorpe wrote:
>>>>>>> Huh. If you recall we did all this work with the XA and the free
>>>>>>> callback because you said qedr was mmaping BAR pages that had some
>>>>>>> HW lifetime associated with them, and the HW resource was not to be
>>>>>>> reallocated until all users were gone.
>>>>>>>
>>>>>>> I think it would be a better example of this API if you pulled the
>>>>>>>
>>>>>>>    dev->ops->rdma_remove_user(dev->rdma_ctx, ctx->dpi);
>>>>>>>
>>>>>>> Into qedr_mmap_free().
>>>>>>>
>>>>>>> Then the rdma_user_mmap_entry_remove() will call it naturally as it
>>>>>>> does entry_put() and if we are destroying the ucontext we already
>>>>>>> know the mmaps are destroyed.
>>>>>>>
>>>>>>> Maybe the same basic comment for EFA, not sure. Gal?
>>>>>>
>>>>>> That's what EFA already does in this series, no?
>>>>>> We no longer remove entries on dealloc_ucontext, only when the entry
>>>>>> is freed.
>>>>>
>>>>> Actually, I think most of the discussions you had on the topic were
>>>>> with Gal, but Some apply to qedr as well, however, for qedr, the only
>>>>> hw resource we allocate (bar) is on alloc_ucontext , therefore we were
>>>>> safe to free it on dealloc_ucontext as all mappings were already
>>>>> zapped. Making the mmap_free a bit redundant for qedr except for the
>>>> need to free the entry.
>>>>>
>>>>> For EFA, it seemed the only operation delayed was freeing memory - I
>>>>> didn't see hw resources being freed... Gal?
>>>>
>>>> What do you mean by hw resources being freed? The BAR mappings are
>>>> under the device’s control and are associated to the lifetime of the UAR.
>>> The bar offset you get is from the device -> don't you release it back to the device
>>> So it can be allocated to a different application ? 
>>> In efa_com_create_qp -> you get offsets from the device that you use for mapping
>>> The bar -> are these unique for every call ? are they released during destroy_qp ? 
>>> Before this patch series mmap_entries_remove_free only freed the DMA pages, but
>>> Following this thread, it seemed the initial intention was that only the hw resources would
>>> Be delayed as the DMA pages are ref counted anyway.  I didn't see any delay to returning
>>> The bar offsets to the device. Thanks.
>> The BAR pages are being "freed" back to the device once the UAR is freed.
>> These pages' lifetime is under the control of the device so there's nothing the
>> driver needs to do, just make sure no one else is using them.
> 
> What frees the UAR?
> 
> In the mlx drivers this was done during destruction of the ucontext,
> but with this new mmap stuff it could be moved to the mmap_free..

Dealloc UAR is currently being called during dealloc_ucontext.
The mmap_free callback is per entry, how can dealloc_uar be moved there?
