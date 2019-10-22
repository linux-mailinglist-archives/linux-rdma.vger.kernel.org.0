Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2052CE069B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfJVOkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 10:40:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39821 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfJVOkk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 10:40:40 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so16449960qki.6
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXR8bdF1j1UWpJda4zjZG5ZWnSZwhJ/YG3rbNvI1l80=;
        b=K6FVZrpp7A4+znXebag+HfetJE3WNBNJcSkNuIbcZ47BKrJkiRFvI9lt4JJ28Ddu9d
         YrZu2LE13L/6wyi2ng9u01XFhYMxJohuoJDUymVQEg7BSxms0dcaDNW8sMuYChfvNz/H
         N7l8jvZBxSNcULBr5Spxiopa+I/qmLsPN9rTLlzo2K3umYs8UnHVKOlirohIUwMHSNwy
         SvcniMbnjagfxNEv54bB06nA3xMYxeYYCx/n0vSS6YBhryoz5V3ybN2aUG2RsAwtULXm
         BMCGRfHlRkwkObXKKcIyGkjzQr/BAtLD8ayA6MVcXhaeRsUAgP9QCVT33yBOot1uOzEF
         PuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXR8bdF1j1UWpJda4zjZG5ZWnSZwhJ/YG3rbNvI1l80=;
        b=D7w9uF9fR22JeQ6DyGkLX3iKU09v4M4nmLDGEX3Ac8AlnSscXub8PPyeWUucK1XRiX
         UBGIZ8YHM/+VM8Hf5ALEb0v/SDIZzUyiGRqdKIi6f97Ve+Zl2Scxyl0eYPG3+bONPYTs
         qjEBJL59+D0YeqvoG9L0yPRssNMVTIZEVdYaJ+Ftg0WfQY13uefueNE/IjRJttdLnoRQ
         37o6cPcH42AwDskytD2lk85gNO/NVcuCM6CtXMr98FqQdnsV2jbNogC/HJFA76DWB36o
         wdItRGa43Ew+FXg/WjcWKq4hXa588NAWhyyJQNXp++v7dQW3QXnTfecBc8BtVNfxgRkw
         h2NQ==
X-Gm-Message-State: APjAAAV/6xevtPcuFyyzzZgGHBzlK+3/oilikDcbtproQ16HuMBc8X5r
        fwQdvFPBWCOatBIz0H2gNf1DjQ==
X-Google-Smtp-Source: APXvYqzM7GNFgS6gwU7tsp07N8fbNxgAlzrinz74VAAWvXF5Ch/7ZBP51TWKPytYzPTulZqeHcloNw==
X-Received: by 2002:a37:e116:: with SMTP id c22mr3069091qkm.261.1571755239830;
        Tue, 22 Oct 2019 07:40:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w131sm10261282qka.85.2019.10.22.07.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 07:40:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMvKw-0008UT-Jq; Tue, 22 Oct 2019 11:40:38 -0300
Date:   Tue, 22 Oct 2019 11:40:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Adit Ranadive <aditr@vmware.com>,
        Gal Pressman <galpress@amazon.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH 2/4] RDMA/core: Set DMA parameters correctly
Message-ID: <20191022144038.GA23952@ziepe.ca>
References: <20191021021030.1037-1-bvanassche@acm.org>
 <20191021021030.1037-3-bvanassche@acm.org>
 <20191021141039.GC25178@ziepe.ca>
 <61d89948-de40-5e6b-f368-353476292093@acm.org>
 <9DD61F30A802C4429A01CA4200E302A7B6B0D6EE@fmsmsx124.amr.corp.intel.com>
 <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d1fb001-ead8-81ce-893e-1ff94214c389@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 11:10:12AM -0700, Bart Van Assche wrote:
> > device->dma_device could be pointing to parent if the caller
> > did not provide dma_ops. So wont this update the parent device
> > dma params?
> 
> That's correct, this will update the parent device DMA parameters.
> 
> > Also do we want to ensure all callers device max_seg_sz
> > params >= threshold (=2G)? If so, perhaps we can do something
> > similar to vb2_dma_contig_set_max_seg_size()
> > 
> > https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/media/common/videobuf2/videobuf2-dma-contig.c#L734
> 
> It depends on what PCIe RDMA adapters support. If all PCIe RDMA adapters
> supported by the Linux kernel support max_segment_size >= 2G the above code
> is probably the easiest approach.

All drivers chop the sgls up into whatever size they support, unlike
block we don't need the dma mapper to produce sgls in specific formats.

Jason
