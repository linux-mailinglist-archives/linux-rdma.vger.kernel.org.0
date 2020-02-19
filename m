Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD416451F
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 14:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBSNP7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 08:15:59 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43084 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgBSNP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Feb 2020 08:15:59 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so122468qvo.10
        for <linux-rdma@vger.kernel.org>; Wed, 19 Feb 2020 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=11/IclRebsHuCtxNtlOzgF7Y6OmjSQTPuINhPnWbmd0=;
        b=hfyde/Z3DJG/nR4W0LtIMa3xmMHyYUr4jd3hYJ6XN4JPzeSHyuyM7e6ImbLX0TW1Qk
         BSfJFOdkMgtygXvscFs2xANxHgbi5DxkluOttn2wzqVqj7BT9N8JvYE4MQulKKHNHaoV
         IlT/wnzmZ73LRqUHXW8JLIRx1KLoCEw4Tuai4tBO/8MjbM6f2tAPlR4Mm5uTHkA9UQKI
         pkqi5HVYEdge+8cBq9/C074Kor9wLQ691vj1Nr4FT/T3gpnxHdo407g74K8J4NaXDHCZ
         jT/erG59hIFDWUxbftmAN4b8i1SBrTYBpyKtXio2/MUPtosJtUWnyscfcEuwCrGRK80j
         RiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=11/IclRebsHuCtxNtlOzgF7Y6OmjSQTPuINhPnWbmd0=;
        b=h5iSuHJUNxSNF6mq8zL+wKQ48kozC/4I9G8BpB4QVSBd+JALxCtYicwJFOp3d0s4M5
         mu7s+Yt4vg39I+D7aofRRnz4covzLkc31L+BVovkzHPy0HLWX61QkGxrthmrSe+7TpTq
         tjEeMYnWNa2TM8nhlOJ0nWx8S+W3Zbb3a+Fz04u3+CKG5QpOJI/JtWD0P2+a4EaRXghU
         0OpqOl+qWKVaoQg0wxOs6DeLuhVbv2smaVeMQIMMXIi/HUuE9ZoWy1sZPMn+vRGt/qs3
         6jp/VtjWvBpTVCf+SbvmX+Q1ta9A2riDinjBNKSJYGMjZgkCflxbVgWFew1IPie2RiBU
         skgQ==
X-Gm-Message-State: APjAAAXQG7gCimxN7P9fh1UUbSG4+TKCE7zJgi7ThVxqtmKv82DV2dgG
        1bW9BiJdPGfav8xjJqpdCV1JyA==
X-Google-Smtp-Source: APXvYqxErDGOQgIOQ3iPHrUGwolgqfyBbcikU4i5CqT08aVXJ6xat7AXjTl/SQtbX8INJHP5vIct6A==
X-Received: by 2002:ad4:518b:: with SMTP id b11mr21316393qvp.195.1582118158391;
        Wed, 19 Feb 2020 05:15:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l6sm946725qti.10.2020.02.19.05.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 05:15:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4PCn-00017g-B5; Wed, 19 Feb 2020 09:15:57 -0400
Date:   Wed, 19 Feb 2020 09:15:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 5/6] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200219131557.GO31668@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <1574671174-5064-6-git-send-email-selvin.xavier@broadcom.com>
 <20200103194458.GA16980@ziepe.ca>
 <CA+sbYW0_o62UXae1h_U7+F9uH=qTOh0ou3w47jNdfHDdB0Ebtw@mail.gmail.com>
 <20200219001550.GK31668@ziepe.ca>
 <CA+sbYW0-wrDQPCNKSBqAJvqmv9Hs7VxqLA9mbA3PJhviqXg_Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW0-wrDQPCNKSBqAJvqmv9Hs7VxqLA9mbA3PJhviqXg_Rw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 02:57:45PM +0530, Selvin Xavier wrote:
> > > On hypervisor, if we don't set rdev->rcfw.res_deinit as done in this
> > > patch, when VF removal is initiated,
> > > the first command will timeout and driver will stop sending any more commands
> > > to FW and proceed with removal. All VFs will exit in the same way.
> > > Just that each
> > > function will wait for one command to timeout. Setting
> > > rdev->rcfw.res_deinit was added
> > > as a hack to avoid this  waiting time.
> >
> > The issue is that pci_driver_unregister undoes the driver binds in
> > FIFO not LIFO order?
> >
> > What happens when the VF binds after the PF?
> 
> This is not dependent on PCI driver unregister. This particular issue
> is happening when bnxt_re
> driver only  is unloaded and the new  ib_unregister_driver is invoked
> by bnxt_re driver in the mod_exit hook.

Oh, now I remember, this driver sits on top of netdev using the
notification stuff so things are a little weird.

> dealloc_driver for each IB device  is called mostly in FIFO
> order(using xa_for_each).  So since PF ib device was added first, it
> gets removed and then VF is removed.

I see.. You could probably arrange to remove your VFs first, then call
ib_unregister_driver() to finish it up and serialize away any
races. That would be reasonably clean and much better than hacking
special stuff in.

> Shall i repost by removing this hack?

Please

Jason
