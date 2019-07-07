Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6561431
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2019 08:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfGGGlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Jul 2019 02:41:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:38605 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGGGlZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Jul 2019 02:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562481683; x=1594017683;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dKP9M0+vzclBAEnmS7e0EM7X6v0OgkjfEhKfNTVpEJE=;
  b=cpXRCUhhr5r/OYwWxqBoILks3qEnpJLhIbIXXXSrCVRIiDn1dChO8Mvi
   MsVMZOezJVKoD2FkNYrtmt2+1RbKaq0HbveIqG2kwOLlllhKmSXbj9waC
   b0qSnExXiDDUdWUBPZa3RE4ITZkZSNgRnvgrh7Z6N4D7Xs80R1GWVXB9s
   8=;
X-IronPort-AV: E=Sophos;i="5.62,461,1554768000"; 
   d="scan'208";a="684065715"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 07 Jul 2019 06:41:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 62C5DA06F4;
        Sun,  7 Jul 2019 06:41:19 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 06:41:18 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.128) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 7 Jul 2019 06:41:14 +0000
Subject: Re: [EXT] Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
 <20190704123511.GA3447@ziepe.ca>
 <MN2PR18MB318240185BE80841F1265D2FA1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705153248.GB31543@ziepe.ca>
 <MN2PR18MB3182F4496DA01CA2B113DF04A1F50@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190705173551.GC31543@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <4d8c8c9e-df8a-6555-c11a-b53a5dd274fe@amazon.com>
Date:   Sun, 7 Jul 2019 09:41:09 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705173551.GC31543@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.128]
X-ClientProxiedBy: EX13D16UWB002.ant.amazon.com (10.43.161.234) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 05/07/2019 20:35, Jason Gunthorpe wrote:
> On Fri, Jul 05, 2019 at 05:24:18PM +0000, Michal Kalderon wrote:
>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>> Sent: Friday, July 5, 2019 6:33 PM
>>>
>>> On Fri, Jul 05, 2019 at 03:29:03PM +0000, Michal Kalderon wrote:
>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>> Sent: Thursday, July 4, 2019 3:35 PM
>>>>>
>>>>> External Email
>>>>>
>>>>> On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
>>>>>> On 03/07/2019 1:31, Jason Gunthorpe wrote:
>>>>>>>> Seems except Mellanox + hns the mmap flags aren't ABI.
>>>>>>>> Also, current Mellanox code seems like it won't benefit from
>>>>>>>> mmap cookie helper functions in any case as the mmap function
>>>>>>>> is very specific and the flags used indicate the address and
>>>>>>>> not just how to map
>>>>> it.
>>>>>>>
>>>>>>> IMHO, mlx5 has a goofy implementaiton here as it codes all of
>>>>>>> the object type, handle and cachability flags in one thing.
>>>>>>
>>>>>> Do we need object type flags as well in the generic mmap code?
>>>>>
>>>>> At the end of the day the driver needs to know what page to map
>>>>> during the mmap syscall.
>>>>>
>>>>> mlx5 does this by encoding the page type in the address, and then
>>>>> many types have seperate lookups based onthe offset for the actual
>>> page.
>>>>>
>>>>> IMHO the single lookup and opaque offset is generally better..
>>>>>
>>>>> Since the mlx5 scheme is ABI it can't be changed unfortunately.
>>>>>
>>>>> If you want to do user controlled cachability flags, or not, is a
>>>>> fair question, but they still become ABI..
>>>>>
>>>>> I'm wondering if it really makes sense to do that during the mmap,
>>>>> or if the cachability should be set as part of creating the cookie?
>>>>>
>>>>>> Another issue is that these flags aren't exposed in an ABI file,
>>>>>> so a userspace library can't really make use of it in current state.
>>>>>
>>>>> Woops.
>>>>>
>>>>> Ah, this is all ABI so you need to dig out of this hole ASAP :)
>>>>>
>>>> Jason, I didn't follow - what is all ABI?
>>>> currently EFA implementation encodes the cachability inside the key,
>>>> It's not exposed in ABI file and is opaque to user-space. The kernel
>>>> decides on the cachability And get's it back in the key when mmap is
>>>> called. It seems good enough for the current cases.
>>>
>>> Then the key 'offset' should not include cachability information at all.
>>>
>> Fair enough, so as you stated above the cachabiliy can be set in the cookie. 
>> Would we still like to leave some bits for future ABI enhancements, requests, from user ? 
>> Similar to a page type that mlx has ? 
> 
> Doesn't make sense to mix and match, the page_type was just some way
> to avoid tracking cookies in some cases. If we are always having a
> cookie then the cookie should indicate the type based on how it was
> created. Totally opaque

I'm fine with removing the cachability flags from the ABI, but I don't see how
the page types can be added without exposing them in the key.

If we want to mmap something that's not a QP/CQ/... how can we do that? I guess
only by returning some key in alloc_ucontext?
