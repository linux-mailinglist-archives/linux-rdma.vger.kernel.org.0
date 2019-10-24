Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95480E2803
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436824AbfJXCQa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Oct 2019 22:16:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436605AbfJXCQa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Oct 2019 22:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n82/LvZl+GucMZK4YinIAcI1lwtheo/oC9RuQSaBEMw=; b=B8SvHU/rhOG2NTh0SA61tiq9d
        /tnJ+Pnfo/sCYaSQnLryDLbk+1rrK/SmAQd3WgNQLcZ7DwqzDGBG2mMg4QObmjgvhVa1gpSnTZo/T
        MdRG+p4o4mSxouvzqD3Zxa/sJBs1yeIWfiJbuntnoyXmhmjn2qHcktB6zH0bb8si41epnCyehBnVg
        5aJP+oYOuo5EFYwmpGPWXa4wippARZBVovs68kwbw+NXXmMsZCdb5vkavMox6M/adYn0OKU/0WRVb
        OrohiMBsAKyzJxA3L3gWuY7NZRpkuW8v4tRtHZMOTo05gMp+AUh7bS5kexyR4NrOJtDqQytRomB+3
        jrn0SJR6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSfp-0002vA-89; Thu, 24 Oct 2019 02:16:25 +0000
Date:   Wed, 23 Oct 2019 19:16:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191024021625.GA5893@infradead.org>
References: <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
 <20191022075735.GV11828@phenom.ffwll.local>
 <20191022150109.GF22766@mellanox.com>
 <20191023090858.GV11828@phenom.ffwll.local>
 <13edf841-421e-3522-fcec-ef919c2013ef@gmail.com>
 <20191023165223.GA4163@redhat.com>
 <20191023172442.GX22766@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023172442.GX22766@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 05:24:45PM +0000, Jason Gunthorpe wrote:
> mlx5 is similar, but not currently coded quite right, there is one
> lock that protects the command queue for submitting invalidations to
> the HW and it doesn't make a lot of sense to have additional fine
> grained locking beyond that.

IFF all drivers could agree on a lock type (rw_semaphore?) for this
protection you could add a pointer to the range which would clear
things up a lot.  I'm just not sure you could get everyone to
agree.
