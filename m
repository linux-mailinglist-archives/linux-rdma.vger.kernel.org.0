Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B431205463
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbgFWOYG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732691AbgFWOYE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jun 2020 10:24:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DDEC061573
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 07:24:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l188so5893706qkf.10
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jun 2020 07:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9JIavCsfL8D1rgwJrHGnA2KvuiN5OKxgBU0Bt6DYuVc=;
        b=guIsePbz9htXvlL08j34eEmeHNqEHNlDJxuYq7stPAl4OT4aMzQGE3iIo1yXeQqXxe
         eX5mALfVPbXQzlIYbvn61CTE2H0WE3VVvw99Ka62XpbjwX1YLJetJDZ8uIQmbnJ9ONWb
         StX08KyUEmrFwnzy/Os3vIy+w148OcETU3RZic8wo0kJgGhzx5htx9lEAm0suFtNCidH
         q9ajkdscGvw1ihLxC77c/Q6Yxa/I70b7uikmLM8JzUXemEyfiw3StlP3qIsHIT42OwJy
         Se00MQM3opBDls3rZeJB/glyl0LzCKX8uhm8iopyR58BGiJiI1qRNwSTmMfgMZazSoN5
         yBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JIavCsfL8D1rgwJrHGnA2KvuiN5OKxgBU0Bt6DYuVc=;
        b=soNIAbyiLPZ5Kb1n0HJfvrXmFVT2NK1ckm5R55z45GsvDGmjNHSswfpz1OBtg3mCbV
         CqPn6xa8LmznJeQw1+BPaZ54p7Xv9K6gnKqwa2TmjNUj6q4HdMl09JdhY1qY671fZA+T
         yzeVcnR6RAHq6me4gWi9BOfrR9QV3pNUAp4br4PhF90pgUlce61W4g5HE4wTLr7c8hou
         nbQ8vThqqiOl+cQ4CeETyTkz8iULEWJ03MJKhQ/RMIIzjlV5eWZAJ8mix40i1jnw6TMQ
         xzlvBevG6kPMiE6uqgc4aEngiGyFJFhH2LHNXJSlHU6YM/EqMjNDuhaBhD/qJvTopAz8
         1mQA==
X-Gm-Message-State: AOAM532mL18pGAQAXkagsAHJGb3APER195AujvXjFXMD12hzDjZAhex3
        yQBoenQOydO72ORWGaJCrOIqdg==
X-Google-Smtp-Source: ABdhPJyEQb7GwZqxn6OkBfJZzOtz4itsDUrIXYKsx+K+lNSQNNCju5aw4K0nk3p3pQ4Gef3KHQWsNw==
X-Received: by 2002:a37:9581:: with SMTP id x123mr20361736qkd.163.1592922242205;
        Tue, 23 Jun 2020 07:24:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a25sm759818qtk.40.2020.06.23.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 07:24:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jnjqC-00CX3b-CR; Tue, 23 Jun 2020 11:24:00 -0300
Date:   Tue, 23 Jun 2020 11:24:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Haris Iqbal <haris.iqbal@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>, dledford@redhat.com,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH] Delay the initialization of rnbd_server module to
 late_initcall level
Message-ID: <20200623142400.GB6578@ziepe.ca>
References: <20200617103732.10356-1-haris.iqbal@cloud.ionos.com>
 <20200617112811.GL2383158@unreal>
 <20200617182046.GI6578@ziepe.ca>
 <20200617190756.GA2721989@unreal>
 <20200617192642.GL6578@ziepe.ca>
 <CAJpMwygeJ7uaNUKxhsF-bx=ufchkx7M6G0E237=-0C7GwJ3yog@mail.gmail.com>
 <CAJpMwyjJSu4exkTAoFLhY-ubzNQLp6nWqq83k6vWn1Uw3eaK_Q@mail.gmail.com>
 <CAJpMwygqz20=H7ovSL0nSWLbVpMv-KLOgYO=nRCLv==OC8sgHw@mail.gmail.com>
 <20200623121721.GZ6578@ziepe.ca>
 <CAJpMwyj_Fa6AhYXcGh4kS79Vd2Dy3N7B5-9XhKHn4qWDo-HVjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJpMwyj_Fa6AhYXcGh4kS79Vd2Dy3N7B5-9XhKHn4qWDo-HVjw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 07:15:03PM +0530, Haris Iqbal wrote:
> On Tue, Jun 23, 2020 at 5:47 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jun 23, 2020 at 03:20:27PM +0530, Haris Iqbal wrote:
> > > Hi Jason and Leon,
> > >
> > > Did you get a chance to look into my previous email?
> >
> > Was there a question?
> 
> Multiple actually :)
> 
> >
> > Jason
> 
> In response to your emails,
> 
> > Somehow nvme-rdma works:
> 
> I think that's because the callchain during the nvme_rdma_init_module
> initialization stops at "nvmf_register_transport()". Here only the
> "struct nvmf_transport_ops nvme_rdma_transport" is registered, which
> contains the function "nvme_rdma_create_ctrl()". I tested this in my
> local setup and during kernel boot, that's the extent of the
> callchain.
> The ".create_ctrl"; which now points to "nvme_rdma_create_ctrl()" is
> called later from "nvmf_dev_write()". I am not sure when this is
> called, probably when the "discover" happens from the client side or
> during the server config.
> 
> It seems that the "rdma_bind_addr()" is called by the nvme rdma
> module; but during the following events
> 1) When a discover happens from the client side. Call trace for that looks like,
> [ 1098.409398] nvmf_dev_write
> [ 1098.409403] nvmf_create_ctrl
> [ 1098.414568] nvme_rdma_create_ctrl
> [ 1098.415009] nvme_rdma_setup_ctrl
> [ 1098.415010] nvme_rdma_configure_admin_queue
> [ 1098.415010] nvme_rdma_alloc_queue
> [ 1098.415032] rdma_resolve_addr
> [ 1098.415032] cma_bind_addr
> [ 1098.415033] rdma_bind_addr
> 
> 2) When a connect happens from the client side. Call trace is the same
> as above, plus "nvme_rdma_alloc_queue()" is called n number of times;
> n being the number of IO queues being created.
> 
> On the server side, when an nvmf port is enabled, that also triggers a
> call to "rdma_bind_addr()", but that is not from the nvme rdma module.
> may be nvme target rdma? (not sure).
> 
> Does this make sense or am I missing something here?

It make sense, delaying creating and CM ID's until user space starts
will solve this init time problme

> 
> > If the rdma_create_id() is not on a callchain from module_init then you don't have a problem.
> 
> I am a little confused. I thought the problem occurs from a call to
> either "rdma_resolve_addr()" which calls "rdma_bind_addr()",
> or a direct call to "rdma_bind_addr()" as in rtrs case.
> In both the cases, a call to "rdma_create_id()" is needed before this.

Right rdma_create_id() must precede anything that has problems, and it
should not be done from module_init.

Jason
