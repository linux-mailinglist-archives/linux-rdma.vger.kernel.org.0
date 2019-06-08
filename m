Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FC739A0C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbfFHBhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:37:23 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15354 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfFHBhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:37:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfb11520000>; Fri, 07 Jun 2019 18:37:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 18:37:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 18:37:22 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 8 Jun
 2019 01:37:22 +0000
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
 <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
 <20190607123432.GB14802@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <771c9b7b-983a-934b-a507-76aa0e8aceaf@nvidia.com>
Date:   Fri, 7 Jun 2019 18:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607123432.GB14802@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559957842; bh=M2sIXUfHOY4caJ1/GSTT6zN+FY4XjAfM+4N4CfP5+0w=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FjXO3DJQC3v99wu3gjrQndwbgGxJGQ3SEeqG6TFvKt1w8r53KkjAm5XGISySd7/Dm
         KLix8M+qphUJiEIxz8Y3hQB0oYZaiIAeoBkX9pa0tzwdBg2beA71/hN66V58sKJ/Gl
         GsBt0SeJWOAr27yT3YO0qWzVqE+qm57g4x2hJ0tPPIcDxmY0MVfpMNRJpBiNZRA5+O
         Hlr8TVddXcJqFVeZwSJrflfkrUQ/oDXy6uzdvHLmWUjJrkAsi7dR/wNzUdJdnlq0ll
         D7efeHpKaM+iJpMEls+jYjF7AMwgFUPpMleyuHXmzsG1896UdCqXNxclh3QfcubGCq
         PE9i3yKPcaVHQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/7/19 5:34 AM, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 07:29:08PM -0700, John Hubbard wrote:
>> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>> ...
>>> @@ -153,10 +158,14 @@ void hmm_mm_destroy(struct mm_struct *mm)
>>>  
>>>  static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>>>  {
>>> -	struct hmm *hmm = mm_get_hmm(mm);
>>> +	struct hmm *hmm = container_of(mn, struct hmm, mmu_notifier);
>>>  	struct hmm_mirror *mirror;
>>>  	struct hmm_range *range;
>>>  
>>> +	/* hmm is in progress to free */
>>
>> Well, sometimes, yes. :)
> 
> It think it is in all cases actually.. The only way we see a 0 kref
> and still reach this code path is if another thread has alreay setup
> the hmm_free in the call_srcu..
> 
>> Maybe this wording is clearer (if we need any comment at all):
> 
> I always find this hard.. This is a very standard pattern when working
> with RCU - however in my experience few people actually know the RCU
> patterns, and missing the _unless_zero is a common bug I find when
> looking at code.
> 
> This is mm/ so I can drop it, what do you think?
> 

I forgot to respond to this section, so catching up now:

I think we're talking about slightly different things. I was just
noting that the comment above the "if" statement was only accurate
if the branch is taken, which is why I recommended this combination
of comment and code:

	/* Bail out if hmm is in the process of being freed */
	if (!kref_get_unless_zero(&hmm->kref))
		return;

As for the actual _unless_zero part, I think that's good to have.
And it's a good reminder if nothing else, even in mm/ code.

thanks,
-- 
John Hubbard
NVIDIA
