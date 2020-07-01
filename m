Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61C1210B1B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgGAMjI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 08:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730393AbgGAMjH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 08:39:07 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D9EC03E979
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 05:39:07 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so944695ilh.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EReZ9zR+8dR7+SqZwrHpYhqfU0mqXK8g1rPXbw0a8vg=;
        b=SfPRSzciQBj9U+kUBv3LL6CSEIP+OdxWA9MWlf3WVnnrT6g8Jn01dyaFA2d++YKNDu
         9BidrCCAEfQJ3gAtsDa7dZTgcbIpGYSHEZ3WgmGt5JNHu8E951cQhvJmlGrEzIba3KZH
         fbA/zKJqG0hvbHy+O8/2mM432+tkjNORD31D/eUOweRR6hXWOeBYCK3pAG4qBnu/eqF3
         NQ5vFHo794GJx5y9TG4r1COjGNkSSgzG0U9n21pHng6PNWeNijUw67x+YW/Kpw5qjELI
         WcyrtXgQcd+iWMr1Uqc+OkwHzwOFC3x/IZbUzt8mMQf9AJoTRQeLjs+dY44JU4kH2ubO
         cNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EReZ9zR+8dR7+SqZwrHpYhqfU0mqXK8g1rPXbw0a8vg=;
        b=quf9m41hJetjjEHK+7qh0nDk7G1Gu+rhRCcPDm+9Sa/qkW54iaLk+xzx7o39fwvu4l
         z1TaEcOcyNeLCcVtyytvq8iUeInZnvG5v9+jSHm6HMGK5GMyIWFK2QmB7aYz6OhXEL8Q
         thpfslWfo7QHgiCXqLGOhfF8uVHNk0df44dGlFj05A2IaOgZYvdwbekwuLbMqMYNzuKc
         CNkLffzfegTcz9CKIPtMUugxoWq9PZqErQHDRU+SscydKqVcV30jgn0OGNl4PbZBNLgz
         BhuDsQYe2gqOjzR6qZdkq7ppwzraipHnBJUMBD33KNDywzHbNbLTUVIW0PwUXTzaF8LL
         9puA==
X-Gm-Message-State: AOAM532IDdkc2qWUthSr18HhS4LKoZ/qETSGTHG5TVvTz8UfSfGlwLx+
        7bN3TCy+udN6V8e7sl3oriMisSS0xWFnMQ==
X-Google-Smtp-Source: ABdhPJw4evjNLH6QP6FR949PBuo7Ouh6EjJX5jpIIQIDva0wjtbaOuDdYinorz4vuLNeDWslW6UmfA==
X-Received: by 2002:a92:cd4e:: with SMTP id v14mr3896335ilq.247.1593607146307;
        Wed, 01 Jul 2020 05:39:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id k3sm3175065ils.8.2020.07.01.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:39:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqc12-002XBF-LP; Wed, 01 Jul 2020 09:39:04 -0300
Date:   Wed, 1 Jul 2020 09:39:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200701123904.GM25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 11:03:06AM +0200, Christian König wrote:
> Am 30.06.20 um 20:46 schrieb Xiong, Jianxin:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Tuesday, June 30, 2020 10:35 AM
> > > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > > Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> > > <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig <christian.koenig@amd.com>
> > > Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
> > > 
> > > On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> > > > > > Heterogeneous Memory Management (HMM) utilizes
> > > > > > mmu_interval_notifier and ZONE_DEVICE to support shared virtual
> > > > > > address space and page migration between system memory and device
> > > > > > memory. HMM doesn't support pinning device memory because pages
> > > > > > located on device must be able to migrate to system memory when
> > > > > > accessed by CPU. Peer-to-peer access is possible if the peer can
> > > > > > handle page fault. For RDMA, that means the NIC must support on-demand paging.
> > > > > peer-peer access is currently not possible with hmm_range_fault().
> > > > Currently hmm_range_fault() always sets the cpu access flag and device
> > > > private pages are migrated to the system RAM in the fault handler.
> > > > However, it's possible to have a modified code flow to keep the device
> > > > private page info for use with peer to peer access.
> > > Sort of, but only within the same device, RDMA or anything else generic can't reach inside a DEVICE_PRIVATE and extract anything useful.
> > But pfn is supposed to be all that is needed.
> > 
> > > > > So.. this patch doesn't really do anything new? We could just make a MR against the DMA buf mmap and get to the same place?
> > > > That's right, the patch alone is just half of the story. The
> > > > functionality depends on availability of dma-buf exporter that can pin
> > > > the device memory.
> > > Well, what do you want to happen here? The RDMA parts are reasonable, but I don't want to add new functionality without a purpose - the
> > > other parts need to be settled out first.
> > At the RDMA side, we mainly want to check if the changes are acceptable. For example,
> > the part about adding 'fd' to the device ops and the ioctl interface. All the previous
> > comments are very helpful for us to refine the patch so that we can be ready when
> > GPU side support becomes available.
> > 
> > > The need for the dynamic mapping support for even the current DMA Buf hacky P2P users is really too bad. Can you get any GPU driver to
> > > support non-dynamic mapping?
> > We are working on direct direction.
> > 
> > > > > > migrate to system RAM. This is due to the lack of knowledge about
> > > > > > whether the importer can perform peer-to-peer access and the lack
> > > > > > of resource limit control measure for GPU. For the first part, the
> > > > > > latest dma-buf driver has a peer-to-peer flag for the importer,
> > > > > > but the flag is currently tied to dynamic mapping support, which
> > > > > > requires on-demand paging support from the NIC to work.
> > > > > ODP for DMA buf?
> > > > Right.
> > > Hum. This is not actually so hard to do. The whole dma buf proposal would make a lot more sense if the 'dma buf MR' had to be the
> > > dynamic kind and the driver had to provide the faulting. It would not be so hard to change mlx5 to be able to work like this, perhaps. (the
> > > locking might be a bit tricky though)
> > The main issue is that not all NICs support ODP.
> 
> You don't need on-demand paging support from the NIC for dynamic mapping to
> work.
> 
> All you need is the ability to stop wait for ongoing accesses to end and
> make sure that new ones grab a new mapping.

Swap and flush isn't a general HW ability either..

I'm unclear how this could be useful, it is guarenteed to corrupt
in-progress writes?

Did you mean pause, swap and resume? That's ODP.

Jason
