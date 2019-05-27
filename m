Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A632BA8F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfE0TMu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 15:12:50 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43226 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfE0TMu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 15:12:50 -0400
Received: by mail-vs1-f68.google.com with SMTP id d128so11193024vsc.10
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DDviHOtsxusWnOlAhiLZnd4GLm6Sq0zvvnS+jtdVWoE=;
        b=H+MT+D+qhOc67FUjiLtXFXQ+JoPD5S1DdC7CSc4dUolQU3JyIJasuwCyeRcrJ0PgNf
         bn8Chih4N853uCVFO25N5GX7p9RL+5D0yBI23Dj3DCO1rNJy1hSLJM5Pymyb1Y7u9fCj
         wuh78HiXJf7rrFoSgLBgwngyDm7eaovdd20ZaYVrQX6zm9XfqAjJG2AUO8Dl4fs08Cdk
         yAbgDtOcJYKveAP1EhrvJE/N8b1nhAIAs1qTQ625JOgpAYRB5cQ4wmxqfMtu71CJWoVY
         /2vs/OIWvzjVWfYHCgN2L1FahPam1FZBvcupwUncDJTjYqt1OfNHBp3EgxmEX94n9d7K
         RZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DDviHOtsxusWnOlAhiLZnd4GLm6Sq0zvvnS+jtdVWoE=;
        b=l98mywr0cE1JmvaWBiQm/Fj8pLEo8bjmMkg34ZXY2+tJOd4jbSTK8X1/MvVwkUs22I
         uH9XOEkca0J2JWcJcMC16XlV5FlpkAtInYzBx5jbmiv5o2vSIKThC2nf96XnR9pAtLFJ
         +Q+H/71nEqwg+Q/pCXlT/KabVlRxslVnHazkij2J82D5KWXU75Otd+8VTxh6PQW97p7H
         N7PyeKYopzYnHMCkSN7iq279LS6yNN+x1ZiTQprCBknovA5VYILccLuVXx1ykwPC6r90
         hhutusmkX6kTxDJObNSmRgnYh/EET7ZxLZ5RVAiKIIj8oIvheEAoTO4qH5j9BiMRvjNT
         t+DQ==
X-Gm-Message-State: APjAAAWFQ2bTlcqoWyOG8b/hLN4GtHkQlu3e210S5gtNSYXrIAvhja73
        1cARKu/44EIwv7cJZf2YLUm87g==
X-Google-Smtp-Source: APXvYqz3S6V5VX0DS9Gw1Glb0NcMYV9JcZsL2/HpeHZOKpnuHyIw3v1JrcSgwxDKXpph1YUf5NB65w==
X-Received: by 2002:a05:6102:2008:: with SMTP id p8mr31279114vsr.73.1558984369444;
        Mon, 27 May 2019 12:12:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s78sm5202319vke.1.2019.05.27.12.12.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 12:12:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVL39-0003MZ-Q1; Mon, 27 May 2019 16:12:47 -0300
Date:   Mon, 27 May 2019 16:12:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jerome Glisse <jglisse@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        linux-mm@kvack.org, dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: RFC: Run a dedicated hmm.git for 5.3
Message-ID: <20190527191247.GA12540@ziepe.ca>
References: <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
 <20190523182458.GA3571@redhat.com>
 <20190523191038.GG12159@ziepe.ca>
 <20190524064051.GA28855@infradead.org>
 <20190524124455.GB16845@ziepe.ca>
 <20190525155210.8a9a66385ac8169d0e144225@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525155210.8a9a66385ac8169d0e144225@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 25, 2019 at 03:52:10PM -0700, Andrew Morton wrote:
> On Fri, 24 May 2019 09:44:55 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > Now that -mm merged the basic hmm API skeleton I think running like
> > this would get us quickly to the place we all want: comprehensive in tree
> > users of hmm.
> > 
> > Andrew, would this be acceptable to you?
> 
> Sure.  Please take care not to permit this to reduce the amount of
> exposure and review which the core HMM pieces get.

Certainly, thanks all

Jerome: I started a HMM branch on v5.2-rc2 in the rdma.git here:

git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=hmm

Please send a series with the initial cross tree stuff:
 - kconfig fixing patches
 - The full removal of all the 'temporary for merging' APIs
 - Fixing the API of hmm_range_register to accept a mirror

When these are ready I'll send a hmm PR to DRM so everyone is on the
same API page.

I'll also move the hugetlb patch that Andrew picked up into this git
so we don't have a merge conflict risk

In parallel let us also finish revising the mirror API and going
through the ODP stuff.

Regards,
Jason
