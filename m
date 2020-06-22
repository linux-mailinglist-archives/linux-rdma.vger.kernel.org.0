Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FA2041BC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFVUPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 16:15:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728361AbgFVUPw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 16:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592856951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TSUweuZT4DKGDzPl0W0mgX7uetKvmHq3b3GY3r5obEQ=;
        b=AvujDWVv1fJT1dJn+N4SkW5GMmDU7IzbCKKcFRWYUi39vcyRdTrOXRiPgl3E7M3zge/VvR
        ZkRQMMmnk1YvVdlxpk+BsrqFbmZI7D1S3R3L9QdDGE/3EqgrbhDjYqVmFyvP22lTRRtz4m
        8LgSdLETYuzgVcOxuBQArD3DxdwY2O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-f7cc3XQuNW-UeEjQYsAiCA-1; Mon, 22 Jun 2020 16:15:47 -0400
X-MC-Unique: f7cc3XQuNW-UeEjQYsAiCA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03BD218FF665;
        Mon, 22 Jun 2020 20:15:45 +0000 (UTC)
Received: from redhat.com (ovpn-119-159.rdu2.redhat.com [10.10.119.159])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8972560F89;
        Mon, 22 Jun 2020 20:15:42 +0000 (UTC)
Date:   Mon, 22 Jun 2020 16:15:40 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200622201540.GB9708@redhat.com>
References: <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
 <20200619195538.GT6578@ziepe.ca>
 <20200619203147.GC13117@redhat.com>
 <20200622114617.GU6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200622114617.GU6578@ziepe.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 08:46:17AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2020 at 04:31:47PM -0400, Jerome Glisse wrote:
> > Not doable as page refcount can change for things unrelated to GUP, with
> > John changes we can identify GUP and we could potentialy copy GUPed page
> > instead of COW but this can potentialy slow down fork() and i am not sure
> > how acceptable this would be. Also this does not solve GUP against page
> > that are already in fork tree ie page P0 is in process A which forks,
> > we now have page P0 in process A and B. Now we have process A which forks
> > again and we have page P0 in A, B, and C. Here B and C are two branches
> > with root in A. B and/or C can keep forking and grow the fork tree.
> 
> For a long time now RDMA has broken COW pages when creating user DMA
> regions.
> 
> The problem has been that fork re-COW's regions that had their COW
> broken.
> 
> So, if you break the COW upon mapping and prevent fork (and others)
> from copying DMA pinned then you'd cover the cases.

I am not sure we want to prevent COW for pinned GUP pages, this would
change current semantic and potentialy break/slow down existing apps.

Anyway i think we focus too much on fork/COW, it is just an unfixable
broken corner cases, mmu notifier allows you to avoid it. Forcing real
copy on fork would likely be seen as regression by most people.


> > Semantic was change with 17839856fd588f4ab6b789f482ed3ffd7c403e1f to some
> > what "fix" that but GUP fast is still succeptible to this.
> 
> Ah, so everyone breaks the COW now, not just RDMA..
> 
> What do you mean 'GUP fast is still succeptible to this' ?

Not all GUP fast path are updated (intentionaly) __get_user_pages_fast()
for instance still keeps COW intact. People using GUP should really knows
what they are doing.

Cheers,
Jérôme

