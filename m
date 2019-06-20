Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21DA4D9AD
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 20:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFTSpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 14:45:51 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32925 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfFTSpu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 14:45:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id f80so2945272oib.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VxtaXvavuIj/WSwZHnAHCDIqk0MlZk9aDQYd+gdFk4=;
        b=PvhKM5V+6yqnt2aU5HxaJksE4uPAQmNs5skwhuJ6n8y5XgZlmqj3eeb150T7SBN6SE
         gIm81w+vU1PtiVJorKQJeZTOHd5OFru39TU4SqL/hr3Rtekmt9KMOkokl1EdfE8VlZMk
         1NkJs/r1WvgIbwR5DJQ0DbUyxIuHbh3jBXe8LKcbCXSMEinhkyK/xlaSv+78VovqYMtg
         q1DEjNCTrdAytojICVF4MAcW1VhW5C6b2MEs9t9SRvlyLXj7Lh7Yhv74YAr6kla9u8Qp
         j8ElcBqtPWtUqgwrRBxPPxQ++W67n8FbK6X2OdqDEGZA60ahsSfATor7gBkpcrk+yQzG
         znqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VxtaXvavuIj/WSwZHnAHCDIqk0MlZk9aDQYd+gdFk4=;
        b=gplC13VHr836VgLuhH0nvqrNo2OC3/3moqDQEuFwEHXag3rCb4AyKW0O68LIc4Nqix
         mPseYMn1xBw2v+ZzhIq9rscU3RytzoHhDlSPGVkW3E13kdAM68hMfG1byVSGjX5VCS9V
         dY626K5LAorwg8YXLR90ZW3dCYDpk78rBEo/1WNFEk4ke0rl4HqUzkV46TmrCcw2QL7q
         +heU2M2/Nla3UDUk1voNteO60H2VbDoWBB+XCbYJZwjfsSmOByqA2DMyVTAAyW9SBZ13
         MpeVPoppn+iE0kGhUvCdVz8cPk6ncZW0rGPgHjJoYih1WWvvwSCLscnF8GeOXckiekRt
         poSQ==
X-Gm-Message-State: APjAAAUWzahcW6f5f9oBBgo6+jLM4NuSltYqOJW8mt8gYVsO7wyvBQgN
        GlH3eTY+j53aBEPHUbHr6b5Hi4thvZlEg5CMrUmqTw==
X-Google-Smtp-Source: APXvYqxzQJlp4UblxkfvTerY7hS4anNKGD6JaiZlLO54L7p3q2W7RUsf+utlNLQ8WFVB+mqDyi2X0jOIR79GoWAQb9A=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr222240oih.73.1561056349598;
 Thu, 20 Jun 2019 11:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com>
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 Jun 2019 11:45:38 -0700
Message-ID: <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 9:13 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> For eons there has been a debate over whether or not to use
> struct pages for peer-to-peer DMA transactions. Pro-pagers have
> argued that struct pages are necessary for interacting with
> existing code like scatterlists or the bio_vecs. Anti-pagers
> assert that the tracking of the memory is unecessary and
> allocating the pages is a waste of memory. Both viewpoints are
> valid, however developers working on GPUs and RDMA tend to be
> able to do away with struct pages relatively easily

Presumably because they have historically never tried to be
inter-operable with the block layer or drivers outside graphics and
RDMA.

>  compared to
> those wanting to work with NVMe devices through the block layer.
> So it would be of great value to be able to universally do P2PDMA
> transactions without the use of struct pages.

Please spell out the value, it is not immediately obvious to me
outside of some memory capacity savings.

> Previously, there have been multiple attempts[1][2] to replace
> struct page usage with pfn_t but this has been unpopular seeing
> it creates dangerous edge cases where unsuspecting code might
> run accross pfn_t's they are not ready for.

That's not the conclusion I arrived at because pfn_t is specifically
an opaque type precisely to force "unsuspecting" code to throw
compiler assertions. Instead pfn_t was dealt its death blow here:

https://lore.kernel.org/lkml/CA+55aFzON9617c2_Amep0ngLq91kfrPiSccdZakxir82iekUiA@mail.gmail.com/

...and I think that feedback also reads on this proposal.

> Currently, we have P2PDMA using struct pages through the block layer
> and the dangerous cases are avoided by using a queue flag that
> indicates support for the special pages.
>
> This RFC proposes a new solution: allow the block layer to take
> DMA addresses directly for queues that indicate support. This will
> provide a more general path for doing P2PDMA-like requests and will
> allow us to remove the struct pages that back P2PDMA memory thus paving
> the way to build a more uniform P2PDMA ecosystem.

My primary concern with this is that ascribes a level of generality
that just isn't there for peer-to-peer dma operations. "Peer"
addresses are not "DMA" addresses, and the rules about what can and
can't do peer-DMA are not generically known to the block layer. At
least with a side object there's a chance to describe / recall those
restrictions as these things get passed around the I/O stack, but an
undecorated "DMA" address passed through the block layer with no other
benefit to any subsystem besides RDMA does not feel like it advances
the state of the art.

Again, what are the benefits of plumbing this RDMA special case?
