Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70C22A6567
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 14:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKDNmo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 08:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729794AbgKDNmo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 08:42:44 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E5C0613D3
        for <linux-rdma@vger.kernel.org>; Wed,  4 Nov 2020 05:42:44 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id d1so9273561qvl.6
        for <linux-rdma@vger.kernel.org>; Wed, 04 Nov 2020 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Y6pLjN1q7V2Yyirv17Ixp1zKgqBOnTfkoe8vOdGQmc=;
        b=AqAK6z8z5bDaRYQx3uZ+Wu3/K8GxaxgEq6AJvmQg+Tf/qpLygesSQiVgxIzS/BeGZS
         24qsbV2i3fUP2MV8ZnRvUMTdaAtgP19PzuLV6e3gSCReguF5aVZJecWN3UzTakyXD9Ew
         gTsJe1gjUIDRuxddTnKdFqD4wGhDshRJlRRfeUTQ516cjJyZBpjbxVOR3Jc8LLcqdmhJ
         hGl4lpxhj/aIv7/9es3cyL5KezyCzVhxC58W9sJiutw5ixNTeVlCxvbmXrubpAOOXEpa
         Or3zZhjxli3lslmghIzCtq/uG3MZ1yMtsWyuW2dGnqTiAPWuczqSRHi5vM87+2QpfM6i
         SN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Y6pLjN1q7V2Yyirv17Ixp1zKgqBOnTfkoe8vOdGQmc=;
        b=N874lqNM1Ztlvfwzouix0y12DswYsaLmFIeh0jpGdY+RJx9qLhBmRjBBgVordRma1m
         2z8EtA+rFNsJ5fCy0XqKa430U0d+7HrsK5v4eSpqce1Y0LTKNnqLBElwfCorBk+cNnQt
         sPMiNpBLV29WgTjF53bmk+pBEx6rejG9S8H6gm8BNDvJcsu4X59eDwta+PArFUL+eZ9/
         e2S61breM3tDRF9YKcIUFWycpBTEaRNs8cABcbYLNZKc40kPg+mZaLbylI4dSNj545X6
         VTAu/UOObf2a8u5S5NvyhJDUezmyJCUuh9XCjqF2TC9Xx7IXc6i0+McYb//q2E1Hxmql
         8BnA==
X-Gm-Message-State: AOAM532QENcSKyxd0ymPuZ2b+trwathblx/tAkBhfc4KhHri5ZvLce9C
        ugJprMEN++EvOxJOEd+8bk+nW+RQxiN+6jZ9
X-Google-Smtp-Source: ABdhPJxkm8cGmbaX4KWGu+7hGSW6QOoE16Ui2TjU3ixwgLY3H1M93rEXy/nBujminVULNL4bE5H1RQ==
X-Received: by 2002:a05:6214:12c4:: with SMTP id s4mr33685780qvv.33.1604497363362;
        Wed, 04 Nov 2020 05:42:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r204sm2314457qka.122.2020.11.04.05.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 05:42:42 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaJ3h-00GVOu-C1; Wed, 04 Nov 2020 09:42:41 -0400
Date:   Wed, 4 Nov 2020 09:42:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104134241.GP36674@ziepe.ca>
References: <20201104095052.1222754-1-hch@lst.de>
 <20201104095052.1222754-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104095052.1222754-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:

> +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> +{
> +	struct scatterlist *s;
> +	int i;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		sg_dma_address(s) = (uintptr_t)sg_virt(s);
> +		sg_dma_len(s) = s->length;

Hmm.. There is nothing ensuring the page is mapped here for this
sg_virt(). Before maybe some of the kconfig stuff prevented highmem
systems indirectly, I wonder if we should add something more direct to
exclude highmem for these drivers?

Sigh. I think the proper fix is to replace addr/length with a
scatterlist pointer in the struct ib_sge, then have SW drivers
directly use the page pointer properly.

Then just delete this stuff, all drivers need is a noop dmaops

Looks a lot hard though, so we should probably go ahead with this.

Jason
