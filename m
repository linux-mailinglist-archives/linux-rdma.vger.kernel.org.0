Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2CCB0DE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 23:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfJCVMG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 17:12:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727789AbfJCVMG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 17:12:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E09AAF2A;
        Thu,  3 Oct 2019 21:12:04 +0000 (UTC)
Date:   Thu, 3 Oct 2019 14:10:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next 00/11] lib/interval-tree: move to half closed
 intervals
Message-ID: <20191003211050.5xwndt7ua4gw4tfq@linux-p48b>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org
References: <20191003201858.11666-1-dave@stgolabs.net>
 <20191003203250.GE32665@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191003203250.GE32665@bombadil.infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 03 Oct 2019, Matthew Wilcox wrote:

>On Thu, Oct 03, 2019 at 01:18:47PM -0700, Davidlohr Bueso wrote:
>> It has been discussed[1,2] that almost all users of interval trees would better
>> be served if the intervals were actually not [a,b], but instead [a, b). This
>
>So how does a user represent a range from ULONG_MAX to ULONG_MAX now?

I would assume that any such lookups would be stab queries (anon/vma interval
tree). So both anon and files. And yeah, I blissfully ignored any overflow scenarios.
This should at least be documented.

>
>I think the problem is that large parts of the kernel just don't consider
>integer overflow.  Because we write in C, it's natural to write:
>
>	for (i = start; i < end; i++)
>
>and just assume that we never need to hit ULONG_MAX or UINT_MAX.

Similarly, I did not adjust queries such as 0 to ULONG_MAX, which are actually
real, then again any intersecting ranges will most likely not even be close to
end.

>If we're storing addresses, that's generally true -- most architectures
>don't allow addresses in the -PAGE_SIZE to ULONG_MAX range (or they'd
>have trouble with PTR_ERR).  If you're looking at file sizes, that's
>not true on 32-bit machines, and we've definitely seen filesystem bugs
>with files nudging up on 16TB (on 32 bit with 4k page size).  Or block
>driver bugs with similarly sized block devices.
>
>So, yeah, easier to use.  But damning corner cases.

I agree.

Thanks,
Davidlohr
