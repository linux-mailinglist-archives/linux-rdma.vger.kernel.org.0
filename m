Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B6F29C954
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 21:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830600AbgJ0UAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 16:00:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38229 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1821556AbgJ0UAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Oct 2020 16:00:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id j129so2454018qke.5
        for <linux-rdma@vger.kernel.org>; Tue, 27 Oct 2020 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVbP6x6GqhbFdX3SvBtVLuaibpsey8Z2kthNc2qn85Y=;
        b=b6xNoHNCcqQ6iZUrN6FudWHoKff/SeoAiEzMcYFT9+/VtUC7pQ3LuxCoyR+nEK9eE/
         XdcNrv8ysE+MTfrEhG0jts7JRtOx19ChU/Qqb1hqj9ZtB0rAyzVa2Q9u1XhhHd8n0E+1
         dWJDJCfielErNYrBZPnpk6l4K86U4NvUIrEl+mRM/Hlml8FvUajH6qOhfIe/FgCz5JQa
         2yV3BfI4tPnPJyLolwYeVnfHDQhUn+dIOLM8MkMBqr3aVSll+ZklZl+2PFMwwRIM+4dn
         U2LiElMP3ag5Ny28BLiHp/m4F/yJvegH40XdeBIvrSJZ+1gFX2pOLoOWt/MF5npglDg9
         TMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVbP6x6GqhbFdX3SvBtVLuaibpsey8Z2kthNc2qn85Y=;
        b=qSmb7MVrBurkIKyz08+uqk2hDoZVkFLqoggT0q2FJDWV/p+2QKaeJWVSTA7aYnZ7mf
         xZ3PDdKMpkFLtRpT8hdXH0zA4wbQZh+dJAyiB/0DtWMZ/XlvZFPfxkJEDlHMue3k+wwa
         62h2jn4o9bUlRZa9LecOYviqnDIXSuP+jiDkI94ceTpiN09xrfli8b5FTMkja6y+8O19
         +oW7mFUONN8DEmUjaLAsNrh07Vn5Ik/1ZYLKhIFdsFhI96zJVVNAwE8nuzgk1SL2Ib8V
         xW6RAxTBUuUY6vVIKQl/p9AMU35j3O7wsXgNSWkOQtLaPGRlKlr10azBLGKMhD5nMNZt
         cXIw==
X-Gm-Message-State: AOAM533pFpPA52qBv5PUQfMOH98hW4uKrV/0ldJyPfK18wxkkrfH9HHF
        VK/1HoZznQKhyRjMzn4SYxlZZg==
X-Google-Smtp-Source: ABdhPJwtgyMNvAoGXqOUUW6O2zP3QFbdm3IPJDOnLnfti11DiqNucDutXZi21XVsAmyglZKaoSiw0w==
X-Received: by 2002:a37:67c3:: with SMTP id b186mr3780543qkc.26.1603828812127;
        Tue, 27 Oct 2020 13:00:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y77sm1361941qkb.57.2020.10.27.13.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 13:00:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kXV8c-009fFB-LK; Tue, 27 Oct 2020 17:00:10 -0300
Date:   Tue, 27 Oct 2020 17:00:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201027200010.GW36674@ziepe.ca>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 23, 2020 at 09:39:58AM -0700, Jianxin Xiong wrote:
> +/*
> + * Generate a new dma sg list from a sub range of an existing dma sg list.
> + * Both the input and output have their entries page aligned.
> + */
> +static int ib_umem_dmabuf_sgt_slice(struct sg_table *sgt, u64 offset,
> +				    u64 length, struct sg_table *new_sgt)
> +{
> +	struct scatterlist *sg, *new_sg;
> +	u64 start, end, off, addr, len;
> +	unsigned int new_nents;
> +	int err;
> +	int i;
> +
> +	start = ALIGN_DOWN(offset, PAGE_SIZE);
> +	end = ALIGN(offset + length, PAGE_SIZE);
> +
> +	offset = start;
> +	length = end - start;
> +	new_nents = 0;
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
> +		len = sg_dma_len(sg);
> +		off = min(len, offset);
> +		len -= off;
> +		len = min(len, length);
> +		if (len)
> +			new_nents++;
> +		length -= len;
> +		offset -= off;
> +	}
> +
> +	err = sg_alloc_table(new_sgt, new_nents, GFP_KERNEL);
> +	if (err)
> +		return err;

I would really rather not allocate an entirely new table just to take
a slice of an existing SGT. Ideally the expoter API from DMA buf would
prepare the SGL slice properly instead of always giving a whole
buffer.

Alternatively making some small edit to rdma_umem_for_each_dma_block()
and ib_umem_find_best_pgsz() would let it slice the SGL at runtime

You need to rebase on top of this series:

https://patchwork.kernel.org/project/linux-rdma/list/?series=370437

Which makes mlx5 use those new APIs

Jason
