Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F131F284B11
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJFLqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgJFLqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 07:46:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE2AC0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 04:46:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c62so16278618qke.1
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=khls/uJRiiihhpviNhiZwsjCwrKDMmXzS3nICWnkoE0=;
        b=agizYAIKwE8nBdCa5FoqruUUgBMZurpzsRC/wNwcTfsnDpXFpX+QcbtpQZNad/gVxa
         Ejl6u02QYnFEvkiLjpKZ89TQcWssfDx6i1puGgdAIuUB6ND5BzNSJb8mCyvibixY/EdF
         pgB/nl85OHsSwiBYpCSL7eI4xgkqvC8eyTW5baeGzGZtamDu1VrTEVHS2Fh2e5EwIdCa
         l+bmTT2IpUpEbcBgO/Vn+7GdNx0SxYlBrsPTJWV6ElQQYg1Sr5wjBNab9QjBywAk8rRQ
         P2SnLftBpoJJDcabtclfyifyvMC+FfaH8IiaW3kaxddjvGyMpMoG34dBGPgpiVQuLKfY
         N8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=khls/uJRiiihhpviNhiZwsjCwrKDMmXzS3nICWnkoE0=;
        b=W+/0FwSsgleNVNz9kDMHDBN72lsPSghrzDXQTiqGoRo3GAKH056K+FrS2VDqkbS9X9
         6MKwuZvbeQdsNl114dSeU8QPAEq4aa9yc1Rv+AwK7dYfUOC0SyLGSmsxvLapzQKVx9g/
         cfcH+QVVCwj/7QUyi1P/D0coEqcZb8r6GnUfJpSBhtKunGVuAcMyyHXS4pvY0ELDmVY8
         PdkMvRmxbWs8lIuqZobhFVZGv8p3r5JrtET7qYI7uBhabE41RkzekLP7/kY7fmh1rexv
         VYbPQ6AKoOGg9Hb9E1sMkhlh0EksCtdmHGid6OoCCxiBwi6U1jHugu2xkcVgE+TWrYRJ
         i0lw==
X-Gm-Message-State: AOAM530o8XiYYHSy0pTbh0ky6qjdSbf7q+EM4q6iheAA5xTslwSKc1Wl
        L3B1Zz9hU3kk6fG9GceiN1UawQ==
X-Google-Smtp-Source: ABdhPJxGjy8GMWaeQn4E93BfLwEPNtp1gYfctvZFDUSCXr33xy4Gvvi+lX1EpAqLKazySn71iDwf0Q==
X-Received: by 2002:a37:4e45:: with SMTP id c66mr4918962qkb.36.1601984789486;
        Tue, 06 Oct 2020 04:46:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j88sm1989818qte.96.2020.10.06.04.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 04:46:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPlQJ-000VYo-SU; Tue, 06 Oct 2020 08:46:27 -0300
Date:   Tue, 6 Oct 2020 08:46:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: Re: [PATCH rdma-next v5 0/4] Dynamicaly allocate SG table from the
 pages
Message-ID: <20201006114627.GE5177@ziepe.ca>
References: <20201004154340.1080481-1-leon@kernel.org>
 <20201005235650.GA89159@nvidia.com>
 <20201006104122.GA438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006104122.GA438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 12:41:22PM +0200, Daniel Vetter wrote:
> On Mon, Oct 05, 2020 at 08:56:50PM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 04, 2020 at 06:43:36PM +0300, Leon Romanovsky wrote:
> > > This series extends __sg_alloc_table_from_pages to allow chaining of
> > > new pages to already initialized SG table.
> > > 
> > > This allows for the drivers to utilize the optimization of merging contiguous
> > > pages without a need to pre allocate all the pages and hold them in
> > > a very large temporary buffer prior to the call to SG table initialization.
> > > 
> > > The second patch changes the Infiniband driver to use the new API. It
> > > removes duplicate functionality from the code and benefits the
> > > optimization of allocating dynamic SG table from pages.
> > > 
> > > In huge pages system of 2MB page size, without this change, the SG table
> > > would contain x512 SG entries.
> > > E.g. for 100GB memory registration:
> > > 
> > >              Number of entries      Size
> > >     Before        26214400          600.0MB
> > >     After            51200            1.2MB
> > > 
> > > Thanks
> > > 
> > > Maor Gottlieb (2):
> > >   lib/scatterlist: Add support in dynamic allocation of SG table from
> > >     pages
> > >   RDMA/umem: Move to allocate SG table from pages
> > > 
> > > Tvrtko Ursulin (2):
> > >   tools/testing/scatterlist: Rejuvenate bit-rotten test
> > >   tools/testing/scatterlist: Show errors in human readable form
> > 
> > This looks OK, I'm going to send it into linux-next on the hmm tree
> > for awhile to see if anything gets broken. If there is more
> > remarks/tags/etc please continue
> 
> An idea that just crossed my mind: A pin_user_pages_sgt might be useful
> for both rdma and drm, since this would avoid the possible huge interim
> struct pages array for thp pages. Or anything else that could be coalesced
> down into a single sg entry.
> 
> Not sure it's worth it, but would at least give a slightly neater
> interface I think.

We've talked about it. Christoph wants to see this area move to a biovec
interface instead of sgl, but it might still be worthwhile to have an
interm step at least as an API consolidation.

Avoiding the page list would be complicated as we'd somehow have to
code share the page table iterator scheme.

Jason
