Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15D6CDF5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2019 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390258AbfGRMRw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jul 2019 08:17:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35483 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfGRMRw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jul 2019 08:17:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so26896196qto.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jul 2019 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N9OHbaXIVnD5HYmXh2ZV597R04zlW0jKbtB8472RTcE=;
        b=J8T3eXs8ibFY1AHSa6g5SNT+ggWhfprtqCPLljFG4+o9RFV1hfjDnUY4lair/bSD1+
         KBmAl7Tf4wZHpxCEhpOwe+AN3bRr19B1ex5N1b6e5Ja3Sz1Qm8cpOq7G4TayRZPAH4C1
         3ZBWKYDH4V8ViDodJaoA0Ya4r8clgxfZaWJJJ+ZjoTFu8HrBdzuniu9E1WirJJOtDNQh
         YsoXP2p7ivd/vajfihsXEtD6TKU9OE2H8gSWgftkTDbRIvd4peF+OjD3dtnDKUp3e6Vm
         At3xa52aB53TWKDpHbR+CVRYNg0pF3yS2PdPgaaDGV6Bf8oshAlx69S3O/Ltgi00O/fA
         D2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9OHbaXIVnD5HYmXh2ZV597R04zlW0jKbtB8472RTcE=;
        b=PB6qRnJOGvPW20kiTZMHi4+D3wvyFwZezXFor9lNTlChJdBs2PPJQBQ/Do9Ty/rxqx
         6z3UkY6PA6pBZTPWdPdCJJd/kms/E09HqrL+4CUDlAwcoty6H/0PLC8+eAi5yjypvnuA
         16RI8T72FHTxrzYfyJwaU8opHs/nSWQKjL4hHjYbQJX1NgfgayJbQLQtaCqou7MkneYT
         2YHtWzMpNK7n+2se2NnVEKW1mw9SWqmAhBumgsd5sJ2OaGdDrdKRWTIhru/0sAzj4n6+
         jfsdvFCknCfQFripfUTFYcCpmFqRwK2RsmLS7PaS8YR5rKa9H1YRXdKHZjpVJKriJqEt
         CWyw==
X-Gm-Message-State: APjAAAXfQLltDiB7/gjMcXFCW1tCrECUrKf1Ufr9P5VOZROLUGOnjSPk
        LlsANvCzq0IcdQWUilsyXZzYBA==
X-Google-Smtp-Source: APXvYqy8aL9hvIO/4j8x9Z/a94ee5k6Mqjf8LocpZuSU70C9jxZXfwpRxBhsAFwUQcDS4cYr9ouTaw==
X-Received: by 2002:ac8:74cb:: with SMTP id j11mr27960622qtr.67.1563452268126;
        Thu, 18 Jul 2019 05:17:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id h1sm13671294qkh.101.2019.07.18.05.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jul 2019 05:17:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ho5M3-0000eh-3A; Thu, 18 Jul 2019 09:17:47 -0300
Date:   Thu, 18 Jul 2019 09:17:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Shamir Rabinovitch <srabinov7@gmail.com>, dledford@redhat.com,
        leon@kernel.org, monis@mellanox.com, parav@mellanox.com,
        danielj@mellanox.com, kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, johannes.berg@intel.com,
        michaelgur@mellanox.com, markb@mellanox.com,
        dan.carpenter@oracle.com, bvanassche@acm.org, maxg@mellanox.com,
        israelr@mellanox.com, galpress@amazon.com, denisd@mellanox.com,
        yuvalav@mellanox.com, dennis.dalessandro@intel.com,
        will@kernel.org, ereza@mellanox.com, linux-rdma@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 08/25] IB/uverbs: ufile must be freed only when not used
 anymore
Message-ID: <20190718121747.GB1667@ziepe.ca>
References: <20190716181200.4239-1-srabinov7@gmail.com>
 <20190716181200.4239-9-srabinov7@gmail.com>
 <20190717115354.GC12119@ziepe.ca>
 <20190717192525.GA2515@shamir-ThinkPad-X240>
 <20190717193313.GN12119@ziepe.ca>
 <20190717203112.GA7307@lap1>
 <20190717204505.GD32320@bombadil.infradead.org>
 <20190717213636.GA2797@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717213636.GA2797@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 18, 2019 at 12:36:37AM +0300, Yuval Shaia wrote:
> On Wed, Jul 17, 2019 at 01:45:05PM -0700, Matthew Wilcox wrote:
> > On Wed, Jul 17, 2019 at 11:31:12PM +0300, Yuval Shaia wrote:
> > > On Wed, Jul 17, 2019 at 04:33:13PM -0300, Jason Gunthorpe wrote:
> > > > Like I said, drivers that require the creating ucontext as part of the
> > > > PD and MR cannot support sharing.
> > > 
> > > Even if we can make sure the process that creates the MR stays alive until
> > > all reference to this MR completes?
> > 
> > The kernel can't rely on userspace to do that.
> 
> ok, how about this: we know that for MR to be shared the memory behinds it
> should also be shared.
> 
> In this case, i know it sounds horrifying but do we care that the process
> that originally created this MR exits? i.e. how about just before the
> process leaves this world we will find some other ucontext to hold these
> memory mappings that driver holds?
> Or how about moving this mapping from ucontext pointed by ib_mr directly to
> ib_mr?

What are you worrying about? My point is we don't need to *anything*
if the driver objects for PD and MR don't rely on the ucontext. This
appears to be the normal case.

MRs already work fine if they outlive the creating process.

Jason
