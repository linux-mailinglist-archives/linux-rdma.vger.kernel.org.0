Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8965CB357
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 04:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbfJDCta (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 22:49:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730566AbfJDCta (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 22:49:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DAE6AFB2;
        Fri,  4 Oct 2019 02:49:27 +0000 (UTC)
Date:   Thu, 3 Oct 2019 19:48:19 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191004024819.ux2osxcpobgnel6j@linux-p48b>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org,
        walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191004002609.GB1492@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004002609.GB1492@ziepe.ca>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 03 Oct 2019, Jason Gunthorpe wrote:

>On Thu, Oct 03, 2019 at 01:18:47PM -0700, Davidlohr Bueso wrote:
>> Hi,
>>
>> It has been discussed[1,2] that almost all users of interval trees would better
>> be served if the intervals were actually not [a,b], but instead [a, b). This
>> series attempts to convert all callers by way of transitioning from using
>> "interval_tree_generic.h" to "interval_tree_gen.h". Once all users are converted,
>> we remove the former.
>>
>> Patch 1: adds a call that will make patch 8 easier to review by introducing stab
>>          queries for the vma interval tree.
>>
>> Patch 2: adds the new interval_tree_gen.h which is the same as the old one but
>>          uses [a,b) intervals.
>>
>> Patch 3-9: converts, in baby steps (as much as possible), each interval tree to
>> 	   the new [a,b) one. It is done this way also to maintain bisectability.
>> 	   Most conversions are pretty straightforward, however, there are some
>> 	   creative ways in which some callers use the interval 'end' when going
>> 	   through intersecting ranges within a tree. Ie: patch 3, 6 and 9.
>>
>> Patch 10: deletes the interval_tree_generic.h header; there are no longer any users.
>>
>> Patch 11: finally simplifies x86 pat tree to use the new interval tree machinery.
>>
>> This has been lightly tested, and certainly not on driver paths that do non
>> trivial conversions. Also needs more eyeballs as conversions can be easily
>> missed (even when I've tried mitigating this by renaming the endpoint from 'last'
>> to 'end' in each corresponding structure).
>>
>> Because this touches a lot of drivers, I'm Cc'ing the whole thing to a couple of
>> relevant lists (mm, dri, rdma); sorry if you consider this spam.
>>
>> Applies on top of today's linux-next tree. Please consider for v5.5.
>>
>> Thanks!
>>
>> [1] https://lore.kernel.org/lkml/CANN689HVDJXKEwB80yPAVwvRwnV4HfiucQVAho=dupKM_iKozw@mail.gmail.com/
>
>Hurm, this is not entirely accurate. Most users do actually want
>overlapping and multiple ranges. I just studied this extensively:
>
>radeon_mn actually wants overlapping but seems to mis-understand the
>interval_tree API and actively tries hard to prevent overlapping at
>great cost and complexity. I have a patch to delete all of this and
>just be overlapping.
>
>amdgpu_mn copied the wrongness from radeon_mn
>
>All the DRM drivers are basically the same here, tracking userspace
>controlled VAs, so overlapping is essential
>
>hfi1/mmu_rb definitely needs overlapping as it is dealing with
>userspace VA ranges under control of userspace. As do the other
>infiniband users.
>
>vhost probably doesn't overlap in the normal case, but again userspace
>could trigger overlap in some pathalogical case.
>
>The [start,last] allows the interval to cover up to ULONG_MAX. I don't
>know if this is needed however. Many users are using userspace VAs
>here. Is there any kernel configuration where ULONG_MAX is a valid
>userspace pointer? Ie 32 bit 4G userspace? I don't know.
>
>Many users seemed to have bugs where they were taking a userspace
>controlled start + length and converting them into a start/end for
>interval tree without overflow protection (woops)
>
>Also I have a series already cooking to delete several of these
>interval tree users, which will terribly conflict with this :\

I have no problem redoing after your changes; if it's worth it
at all.

>
>Is it really necessary to make such churn for such a tiny API change?

I agree, and was kind of expecting this. In general the diffstat ended
up being larger than I initially hoped for. Maybe after your removals
I can look into this again.

Thanks,
Davidlohr
