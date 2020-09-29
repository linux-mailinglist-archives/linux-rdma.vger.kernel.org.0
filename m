Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F5327D49D
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 19:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgI2Rkk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2Rkk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 13:40:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD9CC061755
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 10:40:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g72so5150267qke.8
        for <linux-rdma@vger.kernel.org>; Tue, 29 Sep 2020 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YJe/rb+DuKM4G4scwUhs1bq13h4LKL8VG8YtuXYZp7s=;
        b=Ppw8j6xIqGzdNGikUJa/62w4eSIiEla3NiHAUfPn4WPtdMWDUgZoOQNOgIMpFim6If
         ON3E1W1EYskkwReD+Mkv0H2hBNnLkLTCP3Dj89Yd3WULB7uMTkK+KmZXlEWqPYqD+QyL
         XIU0aeGbHQFSJHpWFzT5j9LjZKhNfujEu9B3VL1FaICE93GtHdqcOQAlwto2Q4AGmS+k
         CZ80NBIeP1IpU9jcGl+7+LCJ+oXwdmFzrqObdLdIseF46t2N3LBsmHfVGGG4Bzv1v8Rh
         /02vlj3VMWI3QoJ3bBUkqCHBwtMEdIH6n4/RdKuprLC2C27zXZDeDZvmg6djTZGOXdUd
         n37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YJe/rb+DuKM4G4scwUhs1bq13h4LKL8VG8YtuXYZp7s=;
        b=H+IR/2DMVjg4weYWxjpEAT1k7zvv3DFx7aEt3hxpKh3MWTXPcRGjRq2QsBWfKtXsy8
         5YdWLCYvNh9g4UlpdFCZv2fEycTQerSziJx/FbfGnAzSC3qo5VyUEDuUTpLpcxqLREMW
         qpTNj+JxwzN2YAMSVNQN7LhsFAb3Izfp9lkwzt33TN6mUm2wWMoABgaO6F0t47XbPs+Q
         XGTiiUqjXhvmosjOhVm6aXWLGniPtzAy2DGfe+Ozl03ExP0pVqoW9iPnN5xa2+N0vzKx
         XRKLJTgB8SNcLtjYvEt+1yPBqbN3LWGZj31jpFRgUxXO14JT1vG6iMTGPECJKGPbx6pj
         zhOQ==
X-Gm-Message-State: AOAM5322SXwYmHuT3OxkhQg35eLQco4ciSi754aO/RL6STWIsU0PpDya
        QoOfrJVii5KICZug1kQrsSR/iHIqztezkFbp
X-Google-Smtp-Source: ABdhPJz042i8JGNAfIUUWGfV9bI3b8tGN9v44+1p4ieURc2WL585LjX/fw7MFsMBWHR5rFThKlo7ZA==
X-Received: by 2002:a37:794:: with SMTP id 142mr5571635qkh.114.1601401239182;
        Tue, 29 Sep 2020 10:40:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s10sm5544492qkg.61.2020.09.29.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:40:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNJcD-003D2b-RB; Tue, 29 Sep 2020 14:40:37 -0300
Date:   Tue, 29 Sep 2020 14:40:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20200929174037.GW9916@ziepe.ca>
References: <be812cb4-4b80-5ee5-4ed8-9d44f0a06edd@oracle.com>
 <20200906074442.GE55261@unreal>
 <9f8984ec-31e4-d71e-d55e-5cf115066e96@oracle.com>
 <20200907071819.GL55261@unreal>
 <69fdae5f-5824-9151-0a00-a7453382eee0@oracle.com>
 <20200907090438.GM55261@unreal>
 <27a60d6d-0e86-6fc6-f4e9-2893c824ba56@oracle.com>
 <20200907102225.GA421756@unreal>
 <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 12:57:48AM +0800, Ka-Cheong Poon wrote:
> On 9/7/20 9:48 PM, Ka-Cheong Poon wrote:
> 
> > This may require a number of changes and the way a client interacts with
> > the current RDMA framework.  For example, currently a client registers
> > once using one struct ib_client and gets device notifications for all
> > namespaces and devices.  Suppose there is rdma_[un]register_net_client(),
> > it may need to require a client to use a different struct ib_client to
> > register for each net namespace.  And struct ib_client probably needs to
> > have a field to store the net namespace.  Probably all those client
> > interaction functions will need to be modified.  Since the clients xarray
> > is global, more clients may mean performance implication, such as it takes
> > longer to go through the whole clients xarray.
> > 
> > There are probably many other subtle changes required.  It may turn out to
> > be not so straight forward.  Is this community willing the take such changes?
> > I can take a stab at it if the community really thinks that this is preferred.
> 
> 
> Attached is a diff of a prototype for the above.  This exercise is
> to see what needs to be done to have a more network namespace aware
> interface for RDMA client registration.

An RDMA device is either in all namespaces or in a single
namespace. If a client has some interest in only some namespaces then
it should check the namespace during client registration and not
register if it isn't interested. No need to change anything in the
core code.

> Is the RDMA shared namespace mode the preferred mode to use as it is the
> default mode?  

Shared is the legacy mode, modern systems should switch to namespace
mode at early boot

> Is it expected that a client knows the running mode before
> interacting with the RDMA subsystem?  

Why would a client care?

> Is a client not supposed to differentiate different namespaces?

None do today.

> A new connection comes in and the event handler is called for an
> RDMA_CM_EVENT_CONNECT_REQUEST event.  There is no obvious namespace info regarding
> the event.  It seems that the only way to find out the namespace info is to
> use the context of struct rdma_cm_id.  

The rdma_cm_id has only a single namespace, the ULP knows what it is
because it created it. A listening ID can't spawn new IDs in different
namespaces.

> (*) Note that in __rdma_create_id(), it does a get_net(net) to put a
>     reference on a namespace.  Suppose a kernel module calls rdma_create_id()
>     in its namespace .init function to create an RDMA listener and calls
>     rdma_destroy_id() in its namespace .exit function to destroy it.  

Yes, namespaces remain until all objects touching them are deleted.

It seems like a ULP error to drive cm_id lifetime entirely from the
per-net stuff.

This would be similar to creating a socket in the kernel.

>     __rdma_create_id() adds a reference to a namespace, when a sys admin
>     deletes a namespace (say `ip netns del ...`), the namespace won't be
>     deleted because of this reference.  And the module will not release this
>     reference until its .exit function is called only when the namespace is
>     deleted.  To resolve this issue, in the diff (in __rdma_create_id()), I
>     did something similar to the kern check in sk_alloc().

What you are running into is there is no kernel user of net
namespaces, all current ULPs exclusively use the init_net.

Without an example of what that is supposed to be like it is hard to
really have a discussion. You should reference other TCP in the kernel
to see if someone has figured out how to make this work for TCP. It
should be basically the same.

Jason
