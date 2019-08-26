Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE69D1D1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 16:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfHZOji (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 10:39:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39271 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729753AbfHZOji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 10:39:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id 125so14192414qkl.6
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0k5/+Y5VKXj7neG5X6VrgqhNhf9FivAl06TLGcqnZMk=;
        b=Zh76jB3eQ7xCieoS9chHiylQvIosustRRm/FGU1E2VukQRLpa3OmJU/dzugjioeLii
         E56Iixc5mS4/jc3o6vNZ8s4tvmmWbBPAeonZVSvMk4749S5ggzruV9J2TfB10T8p8J2V
         KlBFqSjgO0jZfiOVWZysMhZes+l8fxWjS4GUg4koJSwS2gxOjXewr3Mw9In/YfxDQYVX
         fde6d0zexkk2wg461+UYtfiO3pKsatoa0Xfu186lrukeWZb+X3zl42I0m9TDresZq6dt
         plvj4LvkDMuOOEKxKdDFCqyXZ3BK2lbIEpSE3ahgLIbqT+xpEDnrX3fN/CvbfVe+c41I
         AL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0k5/+Y5VKXj7neG5X6VrgqhNhf9FivAl06TLGcqnZMk=;
        b=sUj5RK8YX9XIizlm8SSU1BhNDGrgnklBCVG6cuwRiBlNe05xVVU93G8tak5APmz6GL
         Vcf4+b3P1ORvIEz7Cg4XKnCwc9ej91KdlLsafBnn8jK7aQ8m7oEEwFR3TY3pkTApxH4z
         UfeFKDTIC1uddNgi6LxozrXT2TJ57cM4LRZmslGninkZswPtle6/iHTMd4iDdhrz82jl
         A4cAkIcdOxZ/6mLEfqjejtZLL8hyFL/vcWw4U+8lgyMLDmE7JsZxE9zXPOP06IxCl9JM
         vuIighb4enira/2YDuS2u/EW4mKWVXDus+QVRT8XU9v472OOkGRhpEMk5pcJdliAUaZZ
         5akw==
X-Gm-Message-State: APjAAAVP7/UDPjIzJj0hJm2L0sZK0QzNO2b4xedHi0TCreQFa1hz1m1u
        RfpIFfxujT/BElm+NkinxXPiqA==
X-Google-Smtp-Source: APXvYqwbMSn3ShURz5fd0L4o5RO2JbfsMX6vrPIdeL+u9KiyHO/d43XXwmgpxdT8KYSbG64So6PsBA==
X-Received: by 2002:ae9:ec0d:: with SMTP id h13mr15058593qkg.407.1566830377329;
        Mon, 26 Aug 2019 07:39:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id y47sm2141619qtb.62.2019.08.26.07.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 07:39:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2G9g-00060g-Ej; Mon, 26 Aug 2019 11:39:36 -0300
Date:   Mon, 26 Aug 2019 11:39:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>, Christoph Hellwig <hch@lst.de>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ib_umem_get and DMA_API_DEBUG question
Message-ID: <20190826143936.GC27349@ziepe.ca>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 05:05:12PM +0300, Gal Pressman wrote:
> Hi all,
> 
> Lately I've been seeing DMA-API call traces on our automated testing runs which
> complain about overlapping mappings of the same cacheline [1].
> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> same address, which as a result DMA maps the same physical addresses more than 7
> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
> 
> Is this considered a bad behavior by the test? Should this be caught by
> ib_core/driver somehow?
> 
> Thanks,
> Gal
> 
> [1]
> DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000004a0ad6c0
> WARNING: CPU: 56 PID: 63572 at kernel/dma/debug.c:501 add_dma_entry+0x1fd/0x230

I understand it is technically a violation of the DMA Mapping API to
do this, as it can create incoherence in the CPU cache if there are
multiple entities claiming responsibility to flush it around DMA.

So if you see this from a kernel ULP it is probably a bug.

From the userspace flow.. We only support DMA cache coherent archs in
userspace, and there is no way to prevent userspace from registering
the same page multiple times (in fact there are good reasons to do
this), so it is a false message. Would be nice to be able to suppress
it from this path.

Jason
