Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F011299D4
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2019 19:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfLWSYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Dec 2019 13:24:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37617 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfLWSYv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Dec 2019 13:24:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id f16so6666134qvi.4
        for <linux-rdma@vger.kernel.org>; Mon, 23 Dec 2019 10:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KNSp0xKzXXca6h2YP8X3emLAqK9GuJuCbstCZTI5ulI=;
        b=FctYOOrJ074bGu2erxfD+ggi+amf34vJ2+/SB/OaLs8ZFEcoEOPSKxrX7J7vfW72iX
         iaD1ph6XI9oWEr/nnku4Pr+MbBh9He5Xr+rBPzoju6TBhM7n5pqaYtl/oqkKFK9Nr8fH
         Us04jbJ3zTX0WDIVdGhJyQO5EPn2JUvIhBvTug4ZRXtCzaFxharK0qUYwO9ZIkwiEqhS
         c9Aa/tUvtqh3RdzKBnkDvwefmOBkVu9RUXlbwmdawA3jtTcA8wQCgHrvBfiWYN8r7VQg
         T/hlkSjI6vXJcCVxYIXrbbrRmfsaCa4t09oEgSwlogc3AYXQW7LtDW06LM/jq8bAmut6
         WCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KNSp0xKzXXca6h2YP8X3emLAqK9GuJuCbstCZTI5ulI=;
        b=mZC5IO4BXV/Xt1bXXLPREvjLF1HSnezkYnyPYhXfCfKuxJqQk2jTJxkWDv2KhcFPBh
         i7HznzZGxWQOSr+nlvNTE3D9VPQGiPar3yWGsKeZ4FhaAXHL5YXWIumcWKGL5cZ+fe3P
         ZnJBAAoU1AGjYgeWMOINPn/kB+HwlD78NqWIHgI0mqmTjCeIT6pj5RG279IKZ1N2mk2x
         R4v0kqff8/wBKPZ7+GrD23cNCPGYG7LC7FSYW3VWYQ9umerYrRoLztBLyJIlI/I0Whxk
         u/7+jSsYMJb34/42n+/5fyy/vfOzvMUheKu3mclHgVc4J4TT8U48E6D588czI27K/YBu
         d12g==
X-Gm-Message-State: APjAAAVgorRix6AZ8DB2ZqE6JySE+/Lm8VL+cWvS/ptg8yxbYiGxBzmy
        eQu2Yclxa4CoiQJ/CSGxEu/zag==
X-Google-Smtp-Source: APXvYqyOJm+HA/OOXOk1TxOLC8pk6pJEfZhfUy8M7as0rtMhyNSoNfAsriRZZomXf9eRLN7qDrjm+A==
X-Received: by 2002:a0c:e150:: with SMTP id c16mr25637620qvl.51.1577125488455;
        Mon, 23 Dec 2019 10:24:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b7sm6449933qtj.15.2019.12.23.10.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 10:24:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ijSNq-0007Pv-LV; Mon, 23 Dec 2019 14:24:46 -0400
Date:   Mon, 23 Dec 2019 14:24:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Netdev <netdev@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH v11 00/25] mm/gup: track dma-pinned pages: FOLL_PIN
Message-ID: <20191223182446.GA28321@ziepe.ca>
References: <20191216222537.491123-1-jhubbard@nvidia.com>
 <20191219132607.GA410823@unreal>
 <a4849322-8e17-119e-a664-80d9f95d850b@nvidia.com>
 <20191219210743.GN17227@ziepe.ca>
 <42a3e5c1-6301-db0b-5d09-212edf5ecf2a@nvidia.com>
 <20191220133423.GA13506@ziepe.ca>
 <CAPcyv4hX9TsTMjsv2hnbEM-TpkC9abtWGSVskr9nPwpR8c5E1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hX9TsTMjsv2hnbEM-TpkC9abtWGSVskr9nPwpR8c5E1Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 04:32:13PM -0800, Dan Williams wrote:

> > > There's already a limit, it's just a much larger one. :) What does "no limit"
> > > really mean, numerically, to you in this case?
> >
> > I guess I mean 'hidden limit' - hitting the limit and failing would
> > be managable.
> >
> > I think 7 is probably too low though, but we are not using 1GB huge
> > pages, only 2M..
> 
> What about RDMA to 1GB-hugetlbfs and 1GB-device-dax mappings?

I don't think the failing testing is doing that.

It is also less likely that 1GB regions will need multi-mapping, IMHO.

Jason
