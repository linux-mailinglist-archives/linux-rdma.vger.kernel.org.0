Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 988F147066
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFOOVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:21:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOVI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sEhX+5INXIgfDveglz8gCZJwRNPPLquY/78YPpDhP50=; b=LeqG71y6vq8cRRf0pGteG7bcH
        HvoPvv9qFjmSsTBZ9o0j+/SJhwGrrOJkbpoG+GwXablTi80OMbKwnEw7mTByKiIBk489iaKOVoA+D
        /OiesUxDChOxPgq/dSVYfc5Hdkd7XstEEuVVfytRleA6Jllqcy3xuLWIVdHLMYeYiMqgMMpHNHa7i
        xFl/EEzXp/7foQuyKq+ZHcAO773G0dER0i17hYTQ9Z9HMFVxIbRP0LdNLpEFnnqw3bQ20PvXCKXNV
        MQ2L6Y6gwRipK4Onamw/OH/772GYRdkgi/R+hfrOssVzYum29EhgKmkU2oAYA+Ad1rlB+AO6Aq/hm
        ZjNsVwdSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9YI-0006ZY-6Y; Sat, 15 Jun 2019 14:21:06 +0000
Date:   Sat, 15 Jun 2019 07:21:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190615142106.GK17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-12-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:44:49PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_release() is called exactly once per hmm. ops->release() cannot
> accidentally trigger any action that would recurse back onto
> hmm->mirrors_sem.

In linux-next amdgpu actually calls hmm_mirror_unregister from its
release function.  That whole release function looks rather sketchy,
but we probably need to sort that out first.
