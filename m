Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0D94A1CB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfFRNN1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 09:13:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44724 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfFRNN0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 09:13:26 -0400
Received: by mail-qt1-f196.google.com with SMTP id x47so15134578qtk.11
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfhednnMko0J/Gc2EkI7pHwdsX7U0u0gJ5ATooY4GNw=;
        b=IpiFSBFYBoTwYfqvmxe8FloHMIqrMYqzAICMX/Tb1PQC8juV4R8QgNi8F2dTL850tB
         tOwbQTRNRQoTa3xOCOwC0OMtxDoNRGuOeI46BFC3kNaAvJiY4P/iyf7RzcsFxc8G45SH
         49zuAflb0zkgaDa+XIi2Wbzs2rUuPcOYneeddw2YI9zDMI26K+cYLBKrGFj8ybuggLo0
         cQrcA8DdzOTHcCXD3549+9H4FoxLRnXA5ooKkdIrNAGnGy1kdMiPech7iq2XGAhKkjdI
         ubP4uCFkrQKLP+0w6s5evp9n0tqrCRE+4lbHqXQX1c3CzOmVczeuL07tv7hCBLVhCB3b
         0WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfhednnMko0J/Gc2EkI7pHwdsX7U0u0gJ5ATooY4GNw=;
        b=olq8ID3yOe9abzA3o9Oz0QqWkKcSdGR9eTe8VuJ+tS3LzX7DKNTZvWNXqEdSrizC7G
         FbeKPdcHNjOkHp8CRMwe4AWSk8NwhnVJ7o7jFXOYBUCOBy+VwawypigSubXd8xcMMuGC
         QPDIxRph1SSXTiMZq3ve57hNpypzz5q236gEGYOmOPXqzfhe6udxhT2PMVgNdP6IqASv
         PgLKviQfU+Saw7+H7iLdKBZG9XMyo69T28nlgX/gNDCzehhLnS6WL+00xJpb5ezsa5dm
         Uy5p1ySn3wgW6s7ZfB9DBGzM1dz/88DRqBYOLQSOTXL3VoL3sdShwiZ/jOpwHIMsnr+Q
         zdGg==
X-Gm-Message-State: APjAAAXOSh3YOPFTq16gekwA4FBvSD6gYNQNEjHw+AuWb8P8QPOR2PI8
        CyZn0uVmefD+BP8v0p76cHSb2Q==
X-Google-Smtp-Source: APXvYqyc4kGixlViSKnI/I5Z67eQQFGhrtX0nDRpvMdx2bumrawkhX26fgDCqWaQXW/nU4uS4gAM1Q==
X-Received: by 2002:a0c:b095:: with SMTP id o21mr27915778qvc.73.1560863605800;
        Tue, 18 Jun 2019 06:13:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f26sm11997359qtf.44.2019.06.18.06.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:13:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdDvQ-0002cw-RL; Tue, 18 Jun 2019 10:13:24 -0300
Date:   Tue, 18 Jun 2019 10:13:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190618131324.GF6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-9-jgg@ziepe.ca>
 <20190615141612.GH17724@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615141612.GH17724@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jun 15, 2019 at 07:16:12AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 13, 2019 at 09:44:46PM -0300, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > No other register/unregister kernel API attempts to provide this kind of
> > protection as it is inherently racy, so just drop it.
> > 
> > Callers should provide their own protection, it appears nouveau already
> > does, but just in case drop a debugging POISON.
> 
> I don't even think we even need to bother with the POISON, normal list
> debugging will already catch a double unregistration anyway.

mirror->hmm isn't a list so list debugging won't help.

My concern when I wrote this was that one of the in flight patches I
can't see might be depending on this double-unregister-is-safe
behavior, so I wanted them to crash reliably.

It is a really overly conservative thing to do..

Thanks,
Jason
