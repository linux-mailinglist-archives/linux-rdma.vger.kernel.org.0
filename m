Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE641149A3
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2019 00:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLEXED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 18:04:03 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13052 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEXED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Dec 2019 18:04:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de98ce60000>; Thu, 05 Dec 2019 15:04:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 15:04:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 15:04:02 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec
 2019 23:04:01 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec 2019
 23:03:56 +0000
Subject: Re: [GIT PULL] Please pull hmm changes
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2f915b2d-ad97-a314-40f0-d0e571f896ba@nvidia.com>
Date:   Thu, 5 Dec 2019 15:03:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203024206.GC5795@mellanox.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575587046; bh=58n8MbBrDbCxymLe3Kyll3zOVQ8b1tLoEUpp/Z4Zoqs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q7nfY8GJBc7/Kc7WDjpBD2YyDTmm4YSkTULrbZJdXbn8ucp6paxWBEGf97Qp3LVka
         sMJlM7NxrxyO8aRWP5b1FEtBBvqn9VHLmUdJCSYXpYeIyVx4R+9CetRhsu59frhppi
         unCtKjZwsAEE3QEsyz/AClVylckUdbuGslURaqRRZn8ALqzyS5H09jcsPcHg7ASNi+
         4BabjcbL7eDtznbkI5Ep/Y05V4gpOkIfDY74NPFGTAPBn6ckaV8S3/0oK0lAuCsWrh
         3ESGW/PA7mEnVe/js0QRtLpFYxiltndgWXNNZrLQILJA4kV1odPGreqsVHCn1zcTSU
         L9Oo/EFBpQx7g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/2/19 6:42 PM, Jason Gunthorpe wrote:
...
> Regarding the ugly names.. Naming has been really hard here because
> currently everything is a 'mmu notifier' and the natural abberviations
> from there are crummy. Here is the basic summary:
> 
> struct mmu_notifier_mm (ie the mm->mmu_notifier_mm)
>    -> mmn_mm
> struct mm_struct 
>    -> mm
> struct mmu_notifier (ie the user subscription to the mm_struct)
>    -> mn
> struct mmu_interval_notifier (the other kind of user subscription)
>    -> mni
> struct mmu_notifier_range (ie the args to invalidate_range)
>    -> range
> 
> I can send a patch to switch mmn_mm to mmu_notifier_mm, which is the
> only pre-existing name for this value. But IIRC, it is a somewhat ugly
> with long line wrapping. 'mni' is a pain, I have to reflect on that.
> (honesly, I dislike mmu_notififer_mm quite a lot too)
> 
> I think it would be overall nicer with better names for the original
> structs. Perhaps:
> 
>  mmn_* - MMU notifier prefix
>  mmn_state <- struct mmu_notifier_mm
>  mmn_subscription (mmn_sub) <- struct mmu_notifier
>  mmn_range_subscription (mmn_range_sub) <- struct mmu_interval_notifier
>  mmn_invalidate_desc <- struct mmu_notifier_range
> 
> At least this is how I describe them in my mind..  This is a lot of
> churn, and spreads through many drivers. This is why I kept the names
> as-is and we ended up with the also quite bad 'mmu_interval_notifier'
> 
> Maybe just switch mmu_notifier_mm for mmn_state and leave the drivers
> alone?
> 
> Anyone on the CC list have advice?
> 
> Jason

No advice, just a naming idea similar in spirit to Jerome's suggestion
(use a longer descriptive word, and don't try to capture the entire phrase):
use "notif" in place of the unloved "mmn". So partially, approximately like 
this:

notif_*                                    <- MMU notifier prefix
notif_state                                <- struct mmu_notifier_mm
notif_subscription (notif_sub)             <- struct mmu_notifier
notif_invalidate_desc                      <- struct mmu_notifier_range*
notif_range_subscription (notif_range_sub) <- struct mmu_interval_notifier



thanks,
-- 
John Hubbard
NVIDIA
