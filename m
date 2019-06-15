Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D874705F
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 16:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFOOQO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 10:16:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOOQO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Jun 2019 10:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gD6VIqBkLgYyVrhSIGdqF3irdAhekwacGCLxmHhYe7A=; b=qJnhMHAZBgQNHi8eUuOeP+8LI
        JxIU15mLHHerFUAADAGOP6itU3lIQb2h1qGivB7Ml7JzdNmXu2f5C2gevwIfVeOAmTRUggKSAIJoY
        l9T0oRnfDSCSkHCdqyMj6u3Y5o3reIYdhf8DdeR2dUPCvNrWxOOqHOO5UZMcmDf2QL2I05fSY3NSw
        ij7iywxXUP2MwChDJ/tZqKJ9MiVKfYktf42nkE0PVJzgVi05btfij2DbfWHgKAYVJ/5+fM+TxXQ4t
        DCCAo80gjD34vxw55WwgMV7Hv7Jj4RYXj/nbUtd5kQe/hk1oFC6PFPvPZWUDzWqT8LVwa2b+p6aHs
        AIBLPQzaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hc9TY-0004Oe-PU; Sat, 15 Jun 2019 14:16:12 +0000
Date:   Sat, 15 Jun 2019 07:16:12 -0700
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
Subject: Re: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190615141612.GH17724@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-9-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614004450.20252-9-jgg@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 13, 2019 at 09:44:46PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> No other register/unregister kernel API attempts to provide this kind of
> protection as it is inherently racy, so just drop it.
> 
> Callers should provide their own protection, it appears nouveau already
> does, but just in case drop a debugging POISON.

I don't even think we even need to bother with the POISON, normal list
debugging will already catch a double unregistration anyway.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
