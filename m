Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC673931D8
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 17:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhE0PKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 11:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbhE0PJc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 May 2021 11:09:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99832C06138A;
        Thu, 27 May 2021 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1s+6QDFBX8Mw27bzQ3Jot3pBebhUbhaY0z0KFk7Dj10=; b=OEuTEn+54fMK3IBeWKRZDhlbYy
        R/+jQl96Q8ceGti8Qp9+IXuX5PhFiu++DcZrNrioYymQEClUivGaSPq1xOyMxUUdyCS9QHdC17MEt
        1L6QZSTo4AtNceJwCDCwFYNpVwfijo3/O/ujZJxcxAxvit4TFhiWCnq4yFllydkbdbnLCtBKbTAiQ
        /hBswydB20IPRDxGE4wC5k863nU62HBjsDxJUOQQ/zhspWhwMkjZmx4rCanWDfLb2m7hNDTnOppqd
        bbi7hDgaORAFRj3gmEqfl8xqZffjvgDGQlVdmA+COxWf08KE0La0zzWI8dr4oWOCTHchytNYigdex
        l4S5JyUA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lmHaM-005efr-6M; Thu, 27 May 2021 15:06:20 +0000
Date:   Thu, 27 May 2021 16:06:10 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/mlx5: Allow modifying Relaxed
 Ordering via fast registration
Message-ID: <YK+1YoO8SR5Z/4b9@infradead.org>
References: <cover.1621505111.git.leonro@nvidia.com>
 <9442b0de75f4ee029e7c306fce34b1f6f94a9e34.1621505111.git.leonro@nvidia.com>
 <20210526194906.GA3646419@nvidia.com>
 <YK992cLoTRWG30H9@infradead.org>
 <20210527145710.GF1002214@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527145710.GF1002214@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 11:57:10AM -0300, Jason Gunthorpe wrote:
> >  2) IB_UVERBS_ACCESS_*.  These just get checked using ib_check_mr_access
> >     and then passed into ->reg_user_mr, ->rereg_user_mr and
> >     ->reg_user_mr_dmabuf
> 
> Yes. Using the kernerl flags for those user marked APIs is intended to
> simplify the drivers as the user/kernel MR logic should have shared
> elements

I'd rather map between these flags somewhere low done if and when this
actually happens.  Usually the driver will map to their internal flags
somewhere, and I bet not doing a detour will clean this up while also
removing the possibility for stupid errors.

> 
> >  3) in-kernel FRWR uses IB_ACCESS_*, but all users seem to hardcode it
> >     to IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_READ |
> >     IB_ACCESS_REMOTE_WRITE anyway
> 
> So when a ULP is processing a READ it doesn't create a FRWR with
> read-only rights? Isn't that security wrong?

Probably.  We probably want a helper that does the right thing based
off a enum dma_data_direction parameter.
