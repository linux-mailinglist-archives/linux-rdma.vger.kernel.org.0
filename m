Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5291BA0491
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 16:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfH1OP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 10:15:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35724 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfH1OP6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Aug 2019 10:15:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34so3173068qte.2
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2019 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N4PSQewEPl9bY8WmAcPLY/0moR24IlS6rPkNZqDl8vU=;
        b=c/+U+LVtJoJgZdjXBRquJ6VlPoHsozCdKR37glql70WwPP6LCFATULkORW3jV9Mcp+
         EGtgX3Ma08DQrbTkGp+Du21ZfvMHkskkwTt5eh/u165afpw9aQkV7xlweeoZ4eE8tPXW
         F7ioO9Jjm4JVWi+Z2DnS1p/v0D1MS43d2M+yRUxNHofTjSAqOjgM80ARYe4Tmy7qpRnh
         GMA6Gpyg8pgSkqTPO8JvFHBje+E6mV+vu6pUqwvuTtsDggMQt8sN/0nYRbbaaRSv/l0T
         jgT+eyWZhW3Au/8v/tspee7n4YoK53VmEETP8uCSNql7hRxuBOox162TWdZfmM75SZSJ
         4vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4PSQewEPl9bY8WmAcPLY/0moR24IlS6rPkNZqDl8vU=;
        b=bRTwur3gw7VInqCCoCDsZykLcbwoad71hehj0tBj9OQI0STxm7/Yyuft50u4D7hUix
         zrsvuVon+aiZXjJBFoWafjCHm6SdrS4mR6jq0uwihTxFhZwLcerHQ04yCHObo5qcff9I
         lzYs2V4HVkVI/qrfxAMtb34fF70kYlTsHOncHPy6ESOhV4Fudvr0ZrCCyDCmW/FwHdPk
         1FN8xqHtpEeARxg4pyjeabRHThLuocReS5yamUoBor0iCev5ffRnNkMIn1eUOTQ5fxji
         nG86T4J2IrS+66RSEY5fgS61owLk52lYEfZujDAApMrXtctRpCDb5oQ9oLzmykgVXoDn
         TyCw==
X-Gm-Message-State: APjAAAVj/ydim5VbZ0uXIY1gIuSOTh96u2bNooH7HYwotMEqorKOyruC
        nPZCTvy5ztLUtNMTX6aNtEJuAg==
X-Google-Smtp-Source: APXvYqyhE/or8r/E51n8Lt/jZqE2flKwyVZx/GDcdUGwh1ZdhDDQT3LGo25jJX6hUyZnl5ZT5hJLug==
X-Received: by 2002:a05:6214:1254:: with SMTP id q20mr2945253qvv.164.1567001757796;
        Wed, 28 Aug 2019 07:15:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id m21sm1278378qkk.131.2019.08.28.07.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 07:15:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2yjs-000267-Oo; Wed, 28 Aug 2019 11:15:56 -0300
Date:   Wed, 28 Aug 2019 11:15:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: ib_umem_get and DMA_API_DEBUG question
Message-ID: <20190828141556.GA933@ziepe.ca>
References: <526c5b18-5853-c8dc-e112-31287a46e707@amazon.com>
 <9bae7550-35cf-b183-1e1c-fd1f8e01ef79@amazon.com>
 <20190827120011.GA7149@ziepe.ca>
 <b58d77f3-b9cb-2cab-b068-60a6bf42d8b0@amazon.com>
 <20190827131722.GB7149@ziepe.ca>
 <53d882a0-8f2b-802e-b985-5a85419ccecd@amazon.com>
 <20190827133719.GC7149@ziepe.ca>
 <c8c058a9-f9ac-0228-646c-0ae1739652a2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c058a9-f9ac-0228-646c-0ae1739652a2@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 04:53:01PM +0300, Gal Pressman wrote:
> On 27/08/2019 16:37, Jason Gunthorpe wrote:
> > On Tue, Aug 27, 2019 at 04:22:51PM +0300, Gal Pressman wrote:
> >> On 27/08/2019 16:17, Jason Gunthorpe wrote:
> >>> On Tue, Aug 27, 2019 at 03:53:29PM +0300, Gal Pressman wrote:
> >>>> On 27/08/2019 15:00, Jason Gunthorpe wrote:
> >>>>> On Tue, Aug 27, 2019 at 11:28:20AM +0300, Gal Pressman wrote:
> >>>>>> On 26/08/2019 17:05, Gal Pressman wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> Lately I've been seeing DMA-API call traces on our automated testing runs which
> >>>>>>> complain about overlapping mappings of the same cacheline [1].
> >>>>>>> The problem is (most likely) caused due to multiple calls to ibv_reg_mr with the
> >>>>>>> same address, which as a result DMA maps the same physical addresses more than 7
> >>>>>>> (ACTIVE_CACHELINE_MAX_OVERLAP) times.
> >>>>>>
> >>>>>> BTW, on rare occasions I'm seeing the boundary check in check_sg_segment [1]
> >>>>>> fail as well. I don't have a stable repro for it though.
> >>>>>>
> >>>>>> Is this a known issue as well? The comment there states it might be a bug in the
> >>>>>> DMA API implementation, but I'm not sure.
> >>>>>>
> >>>>>> [1] https://elixir.bootlin.com/linux/v5.3-rc3/source/kernel/dma/debug.c#L1230
> >>>>>
> >>>>> Maybe we are missing a dma_set_seg_boundary ?
> >>>>>
> >>>>> PCI uses low defaults:
> >>>>>
> >>>>> 	dma_set_max_seg_size(&dev->dev, 65536);
> >>>>> 	dma_set_seg_boundary(&dev->dev, 0xffffffff);
> >>>>
> >>>> What would you set it to?
> >>>
> >>> Full 64 bits.
> >>>
> >>> For umem the driver is responsible to chop up the SGL as required, not
> >>> the core code.
> >>
> >> But wouldn't this possibly hide driver bugs? Perhaps even in other flows?
> > 
> > The block stack also uses this information, I've been meaning to check
> > if we should use dma_attrs in umem so we can have different
> > parameters.
> > 
> > I'm not aware of any issue with the 32 bit boundary on RDMA devices..
> 
> So something like this?
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 99c4a55545cf..2aa0e48f8dac 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -1199,8 +1199,9 @@ static void setup_dma_device(struct ib_device *device)
>  		WARN_ON_ONCE(!parent);
>  		device->dma_device = parent;
>  	}
> -	/* Setup default max segment size for all IB devices */
> +	/* Setup default DMA properties for all IB devices */
>  	dma_set_max_seg_size(device->dma_device, SZ_2G);
> +	dma_set_seg_boundary(device->dma_device, U64_MAX);
>  
>  }

Hum. So there are two issues here, the SGL combiner in umem is
supposed to respect the DMA settings, so it should be fixed to check
boundary as well as seg_size too.

Then we can add the above as well. AFAIK all PCI-E HW is OK to do
arbitary DMAs.

Jason  
