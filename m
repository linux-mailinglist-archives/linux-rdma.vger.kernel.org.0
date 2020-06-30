Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD77720FC91
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgF3TRD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 15:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF3TRC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jun 2020 15:17:02 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0BFC061755
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 12:17:02 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i18so18793093ilk.10
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2020 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Z8G4sY/3BGmyIjcdbfqV1osL+GlJtPN7I10BAIUxWU=;
        b=k1v79OlGEmtKhJ5piARsXMeK1rd/NK3yT/drkmMqpD3sXC7KYiKNDNNbQU+r+V8P4C
         CjGTxiqMrI3i1arOaNM1SxAIw27Nf3eW/fM3T1Wt70BrgGjUbjaUzNNquHHMMcMrvRxo
         Z1WI44Y3ZJ2/0oiL2+dhywTrG4XZSiNWCu2ho2lds0SEwWVpCix7WIVkmTgRV3qSbaVz
         AR0RbFd8IkNo4iwvYwvkXhbLFHgIqYJvTY1+HOPAUDIM7hLWg3aEP7mug/XM8kOhqY7q
         7PjvYb6sWZwyugTZGz5nOG+I5I9rsvncG7r0CNQ8/E4focEU5U6iRJreMTB6yiYhIoct
         jbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Z8G4sY/3BGmyIjcdbfqV1osL+GlJtPN7I10BAIUxWU=;
        b=R3yGDFBDbxzXn8Eg9K1kSkBx6jXBDGMcaQcv+etF/9msci5fa/fLLW7TOan8v/k/0s
         rW8LQAA/A7/1DLXvm1TTt7GUfnhVvqTsG8L/f/VOYLA6YgoKAdn79/eXZL9a/WdLRa1n
         iVQXGkNyNBm5FmrftX7JKeTcF6XJQ0x8snf5+5M+PpCAZIWP1SaeoNEjCjPOqC0ZqZWP
         AXy1wuSaZbpzt3Tpe+x/0DK42cgNRLtXfy5lxwFRaXTJDYt5Mqb0NaJrrl9GCa0v1NC9
         G+8gSXIXg34wZ/OHXxPQuw7sYyo5v1WjA9H2qHg0m2TNikubaEuRCa1m1Xs0aKd80qnd
         zLYA==
X-Gm-Message-State: AOAM5331TLN/b+WBmi0hUSugqW2cfvRXLwv7YA/QLug11sggwdvyoBNW
        3kYJzFVPpQme9LlzY41SBCpGvg==
X-Google-Smtp-Source: ABdhPJzW4EQndHUYdS2/xV0eFxNWR3D/TY/epRvvziYytNeMu+qD0CnLv9714Fptw+qZ4z2bgWiF/A==
X-Received: by 2002:a92:4a09:: with SMTP id m9mr4283864ilf.79.1593544621848;
        Tue, 30 Jun 2020 12:17:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y2sm1815038iox.22.2020.06.30.12.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:17:01 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqLka-0026er-89; Tue, 30 Jun 2020 16:17:00 -0300
Date:   Tue, 30 Jun 2020 16:17:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200630191700.GL25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 06:46:17PM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, June 30, 2020 10:35 AM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> > <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig <christian.koenig@amd.com>
> > Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
> > 
> > On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> > > > > Heterogeneous Memory Management (HMM) utilizes
> > > > > mmu_interval_notifier and ZONE_DEVICE to support shared virtual
> > > > > address space and page migration between system memory and device
> > > > > memory. HMM doesn't support pinning device memory because pages
> > > > > located on device must be able to migrate to system memory when
> > > > > accessed by CPU. Peer-to-peer access is possible if the peer can
> > > > > handle page fault. For RDMA, that means the NIC must support on-demand paging.
> > > >
> > > > peer-peer access is currently not possible with hmm_range_fault().
> > >
> > > Currently hmm_range_fault() always sets the cpu access flag and device
> > > private pages are migrated to the system RAM in the fault handler.
> > > However, it's possible to have a modified code flow to keep the device
> > > private page info for use with peer to peer access.
> > 
> > Sort of, but only within the same device, RDMA or anything else generic can't reach inside a DEVICE_PRIVATE and extract anything useful.
> 
> But pfn is supposed to be all that is needed.

Needed for what? The PFN of the DEVICE_PRIVATE pages is useless for
anything.

> > Well, what do you want to happen here? The RDMA parts are
> > reasonable, but I don't want to add new functionality without a
> > purpose - the other parts need to be settled out first.
> 
> At the RDMA side, we mainly want to check if the changes are
> acceptable. For example, the part about adding 'fd' to the device
> ops and the ioctl interface. All the previous comments are very
> helpful for us to refine the patch so that we can be ready when GPU
> side support becomes available.

Well, I'm not totally happy with the way the umem and the fd is
handled so roughly and incompletely..

> > Hum. This is not actually so hard to do. The whole dma buf
> > proposal would make a lot more sense if the 'dma buf MR' had to be
> > the dynamic kind and the driver had to provide the faulting. It
> > would not be so hard to change mlx5 to be able to work like this,
> > perhaps. (the locking might be a bit tricky though)
> 
> The main issue is that not all NICs support ODP.

Sure, but there is lots of infrastructure work here to be done on dma
buf, having a correct consumer in the form of ODP might be helpful to
advance it.

Jason
