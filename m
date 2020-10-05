Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1909F283664
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJENQQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 09:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJENQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 09:16:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD9C0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 06:16:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so11795856qkc.2
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L9ru4Sqlhf2p0KE+zcoL9gXJ9Z/ZudEwwCB7ok4Wi+E=;
        b=o+rtQHCVK6nQbRJZejNGS1aIfgQkSLk08A/mJdPkE2UwflbMne/ie+SEIG/Iek3DPI
         aKMRglqplDpIYwV2QQXFJs9S+AxgdHVi0hcfBTufx44ORpUfI+J8q8GeAznc/XDsvbyF
         E3GkTCpmiBwrK7WkelGKhVO7CLw8z4nUgEW6xvmdT60DLP+We1iwFMJo5fFBC8nLzMSC
         2U69V4TFHu6Y0WrIeCZ7rEsiD+MmPCE1qWCf/fN0wQcVFOUyHRoPm7jNRmPI45wOqMQP
         XIDPHqddY7a1+1BaWrvv/43rW8zN+DmhsB5b7cBwAocVOZ2mi8T8opQqlErsGZMojY/x
         L38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9ru4Sqlhf2p0KE+zcoL9gXJ9Z/ZudEwwCB7ok4Wi+E=;
        b=hrf2wasNeGCUuxz6t0bVLHM1rRVn45ymmLS55Jti7N6ZHdwm6UxLD7jPPR4IX4tnC3
         awzU49w0QsdsYgs9U1L1bccfVliU3J71tpdftP0FPF1NZ1VYy2Af4eBAgcgSxDaTA+pw
         kJEe4QQGPyVpb22LzgT4xSJuZQVMKGf20wBrjDgLpLUAuCXwc+tgejANGiMkVZzHxgh/
         qhAyKkC2OpMw48B3eBRnIsa8x1bJtkOXkpdkH+9TSuR23oZ6VVGHVG9uEnN0ghyFA36z
         pvkH7G+J4kN5fteH/EcuOa0sWvh9a6ewlcJ24HiQCQtjr9ZHVTdEBJ5lAwO60WqQm/EE
         pEVg==
X-Gm-Message-State: AOAM530coa27KqasmHj4xYI82qrqLIN8vb7F3hy1m96AJjkgc8iG7awu
        RFujsa8M/rTO0cpqKyUXIjhuiULRZUjox3U6
X-Google-Smtp-Source: ABdhPJzUP6oxnZNcbbXBFbXoJB8RdvZge/U5wbaKb/+we9vkB/vBT26d8s5OBmx6xJCk3QmT7R9SWA==
X-Received: by 2002:a37:9b97:: with SMTP id d145mr4523377qke.274.1601903772754;
        Mon, 05 Oct 2020 06:16:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d200sm7187802qkc.109.2020.10.05.06.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 06:16:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPQLb-007cuf-8T; Mon, 05 Oct 2020 10:16:11 -0300
Date:   Mon, 5 Oct 2020 10:16:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201005131611.GR9916@ziepe.ca>
References: <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 06:27:39PM +0800, Ka-Cheong Poon wrote:
> On 10/2/20 10:04 PM, Jason Gunthorpe wrote:
> > > that namespace to use it.  If there are a large number of namespaces,
> > > there won't be enough devices to assign to all of them (e.g. the
> > > hardware I have access to only supports up to 24 VFs).  The shared
> > > mode can be used in this case.  Could you please explain what needs
> > > to be done to support a large number of namespaces in exclusive
> > > mode?
> > 
> > Modern HW supports many more than 24 VFs, this is the expected
> > interface
> 
> Do you have a ballpark on how many VFs are supported?  Is it in
> the range of many thousands?

Yes

> BTW, while the shared mode is still here, can there be a simple
> way for a client to find out which mode the RDMA subsystem is using?

Return NULL for the namespace

> > The new cm_id starts with the same ->context as the listener, the ULP should
> > use this to pass any data, such as the namespace.
> 
> This is what I suspected as mentioned in the previous email.  But
> this makes it inconvenient if the context is already used for
> something else.

Don't see why. the context should be allocated memory, so the ULP can
put several things lin there.

> > I'm skeptical ULPs should be doing per-ns stuff like that. A ns aware
> > ULP should fundamentally be linked to some FD and the ns to use should
> > derived from the process that FD is linked to. Keeping per-ns stuff
> > seems wrong.
> 
> 
> It is a kernel module.  Which FD are you referring to?  It is
> unclear why a kernel module must associate itself with a user
> space FD.  Is there a particular reason that rdma_create_id()
> needs to behave differently than sock_create_kern() in this
> regard?

Somehow the kernel module has to be commanded to use this namespace,
and generally I expect that command to be connected to FD.

We don't have many use cases where the kernel operates namespaces
independently..

> While discussing about per namespace stuff, what is the reason
> that the cma_wq is a global shared by all namespaces instead of
> per namespace?  Is there a problem to have a per namespace cma_wq?

Why would we want to do that?

Jason
