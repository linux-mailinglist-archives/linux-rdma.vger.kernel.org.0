Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799A44B77B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 13:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFSLy1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 07:54:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSLy1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZMXqazDQazrKKSlfFDYmUFpilZIibnGHtDfXdH5dHKE=; b=k0xGPIpKWDBE1uNoMaB6BA8Rj
        J14iEyyGUyAtE4tSq7WhsgKGCuRN9es82gkxyNp9nSgEg7726Fp5Q6j8njKnjZw1TL2kIzgkhhW/B
        KNeWruWnKckQqgS6VEq6LV0yJnSYlTho5MCkjXZAbyoi1aFDSWffvabKy9p1PRMW4YP8nhrqvgXZe
        EB7qiBw+50HfBshE8hvrxSxfpGqjP4LVX2zgDyH8wUfEe3zTn3IN+1WKe21I1yyVcdCz3X5t8c3G0
        chcINAU+cS2mR0PgkXz7kwPZ6jT4aWdw4B+PfSbOUGeJagOxjTH/Ku4GUj/Cvtahzx7Xje2r6IiHm
        EK+xNL6wQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdZAU-0004pM-0A; Wed, 19 Jun 2019 11:54:22 +0000
Date:   Wed, 19 Jun 2019 04:54:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 06/12] mm/hmm: Hold on to the mmget for the
 lifetime of the range
Message-ID: <20190619115421.GB19138@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-7-jgg@ziepe.ca>
 <20190615141435.GF17724@infradead.org>
 <20190618151100.GI6961@ziepe.ca>
 <20190619081858.GB24900@infradead.org>
 <20190619113452.GB9360@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619113452.GB9360@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 08:34:52AM -0300, Jason Gunthorpe wrote:
> /**
>  * list_empty_careful - tests whether a list is empty and not being modified
>  * @head: the list to test
>  *
>  * Description:
>  * tests whether a list is empty _and_ checks that no other CPU might be
>  * in the process of modifying either member (next or prev)
>  *
>  * NOTE: using list_empty_careful() without synchronization
>  * can only be safe if the only activity that can happen
>  * to the list entry is list_del_init(). Eg. it cannot be used
>  * if another CPU could re-list_add() it.
>  */
> 
> Agree it doesn't seem obvious why this is relevant when checking the
> list head..
> 
> Maybe the comment is a bit misleading?

From looking at the commit log in the history tree list_empty_careful
was initially added by Linus, and then mingo added that comment later.
I don't see how list_del_init would change anything here, so I suspect
list_del_init was just used as a short hand for list_del or
list_del_init.
