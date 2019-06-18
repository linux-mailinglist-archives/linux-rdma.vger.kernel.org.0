Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC25A4A214
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRN1a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:27:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRN1a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R8Y3KUjrFsX7X/g2S4dMsmTowqPuT9Y71h6/+llmgw0=; b=n3ZDxpzbEjb8R1YKJLBpAmwI5
        fg4UHLI0YBDL1Xe27VYvdUCGF95z2vAUdWoaWGPThlJIFk6rgNQuGjNp5TDE1LLU9ECS4LxQw96ML
        +RCnUJDGNPupO5iWQgPgY71z5jdI6LT9v+5khZpolVw0InzMNQKiIn4/PHhnOF17eUM1E32oFnzqC
        iWauMQoWTacJNZ46XZqRsJeWRwGpaq1/Dv10jtsfzimXcwJGM/5zSO47R/FPNsz/wwBuKwfpsz2uG
        yZpfrSudQW9FDkAJR2C2gjZlV/jsEeePTa3LPRYnyVcRAYJnFrHd7UlJ5Qr1Dwk10+mVVNEVELOb+
        AJSeWlhpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdE8w-0000uS-GG; Tue, 18 Jun 2019 13:27:22 +0000
Date:   Tue, 18 Jun 2019 06:27:22 -0700
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
Subject: Re: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190618132722.GA1633@infradead.org>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-9-jgg@ziepe.ca>
 <20190615141612.GH17724@infradead.org>
 <20190618131324.GF6961@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618131324.GF6961@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 10:13:24AM -0300, Jason Gunthorpe wrote:
> > I don't even think we even need to bother with the POISON, normal list
> > debugging will already catch a double unregistration anyway.
> 
> mirror->hmm isn't a list so list debugging won't help.
> 
> My concern when I wrote this was that one of the in flight patches I
> can't see might be depending on this double-unregister-is-safe
> behavior, so I wanted them to crash reliably.
> 
> It is a really overly conservative thing to do..

mirror->list is a list, and if we do a list_del on it during the
second unregistration it will trip up on the list poisoning.
