Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA781FD11F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 17:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFQPgl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQPgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 11:36:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773E8C06174E
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 08:36:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so2402485qke.7
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2020 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dbk/1jSQdwOR1Cb8Zc/nPFu1ivkGyHkghRgO8SztVXU=;
        b=pPYxfQnED654JAVK2LdD6AVZx1QEwmZWhfPNyjlCoZhlM8sa3qhXCMxdrkGp8142Wh
         DtxDsN23q/ulr9S6Y+1zzbf4jW3Z9dFZ/0YeayffUabFyka3Lgzx1eZXTLkiMhDDey4m
         UogpKXsYTqdsBfQ9jP80lmHPG88L/pOrXMY+hIwSyhlang0aR6IJI0e02qxnv5evApUG
         wlbgjC0zyYMskDH5xBlAMv2HN3yxwGDVgiytjBX39gVlIvRoyMO8EnURVPVhyOd9ZKvk
         PLNlzpxiRwOl2sWlKYsD+uA62RXOFH5aU5DpBmm4K9sf7EOL/+Ls4Akpz2DpLoheFhEe
         +l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dbk/1jSQdwOR1Cb8Zc/nPFu1ivkGyHkghRgO8SztVXU=;
        b=JZ3HMXwTcfvwqpnvGwjqlyRfU4WynfDKtv2gbGmLmXS0uXjMPynkiOBly4KgaOKR54
         xkvRDRjHknuRUCWOcqb6Uy3ztZX0k5FEWI1lzh52V9n4NZEvSQm3YNn1Tuz2m4ZbYIqA
         avLJum1SFzuTuqhZeXeX2K87cy/lmV2BJz+sEQIeDfZjR0+Fc33mZk1V2b8MiMZLj2hu
         1xzJqf8h+tqu9/Mas5TdQ/RCNXA1kUiPDVNTYz7uTjUMcw/AwfprVR+YsrguxfMtH47p
         nWJzNcpdcQWJBvwDbcW7nCJUAV/7aKcNIqVIdKIkD9EmhYTH5v1kRmaw/pw6hXFlVFOM
         C+eg==
X-Gm-Message-State: AOAM531RNB/ilfPX1xW+Va4j6IHmqhEWKJ7l8PcIXWyorbI1BNQQ2V9c
        NoOq7FsGqzj/NE5+L4lwlrS08A==
X-Google-Smtp-Source: ABdhPJxKyVnemogejXmn4cJcqyCy/SptnP/oz0wNctUYLem8ceHnPoVsFkwirnsuXQEsJCERqk/k7g==
X-Received: by 2002:a05:620a:9d8:: with SMTP id y24mr25406506qky.274.1592408199997;
        Wed, 17 Jun 2020 08:36:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e16sm198959qtc.71.2020.06.17.08.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:36:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jla7C-009dI1-Th; Wed, 17 Jun 2020 12:36:38 -0300
Date:   Wed, 17 Jun 2020 12:36:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Move provider specific attributes to
 ucontext allocation response
Message-ID: <20200617153638.GH6578@ziepe.ca>
References: <20200615075920.58936-1-galpress@amazon.com>
 <20200616063045.GC2141420@unreal>
 <cba7128b-c427-bc26-5f43-69a22463debc@amazon.com>
 <20200616093835.GB2383158@unreal>
 <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6773480-5954-b58b-21f0-f5ee4ec7238b@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 08:44:37PM +0300, Gal Pressman wrote:
> On 16/06/2020 12:38, Leon Romanovsky wrote:
> > On Tue, Jun 16, 2020 at 11:53:11AM +0300, Gal Pressman wrote:
> >> On 16/06/2020 9:30, Leon Romanovsky wrote:
> >>> On Mon, Jun 15, 2020 at 10:59:20AM +0300, Gal Pressman wrote:
> >>>> Provider specific attributes which are necessary for the userspace
> >>>> functionality should be part of the alloc ucontext response, not query
> >>>> device. This way a userspace provider could work without issuing a query
> >>>> device verb call. However, the fields will remain in the query device
> >>>> ABI in order to maintain backwards compatibility.
> >>>
> >>> I don't really understand why "should be ..."? Device properties exposed
> >>> here are per-device and will be equal to all ucontexts, so instead of
> >>> doing one very fast system call, you are "punishing" every ucontext
> >>> call.
> >>
> >> I talked about it with Jason in the past, the query device verb is intended to
> >> follow the IBA verb, alloc ucontext should return driver specific data that's
> >> required to operate the user space provider.
> >> A query device call should not be mandatory to load the provider.
> > 
> > Why? query_device is declared as mandatory verb for any provider, so
> > anyway all in-the-tree RDMA drivers will have such verb.
> 
> I don't think the concern here is if the verb exists or not, my understanding is
> that query device should be used for IBA query device attributes, not other
> provider specific stuff.
> Jason, want to chime in with your thoughts?

query_device should be used to implement the ibverb query_device and
query_device_ex

It should only return rdma-core defined common stuff because that is
what that verb does - there is no reason to return driver specific
things as there is nothing the driver can do with it.

The only exception might be some provider specific query_device dv
that needs more information.

query_device should not be used as some two-part
create_context. Information related only to create_context that is not
already exposed to query_device should not be added to query_device
only for create_context's use.

Similarly, information in query_device should not be duplicated into
create_context just to save a system call.

Jason
