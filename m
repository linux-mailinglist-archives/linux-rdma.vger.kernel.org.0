Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063A5283B8C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgJEPpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 11:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgJEPpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Oct 2020 11:45:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5E8C0613CE
        for <linux-rdma@vger.kernel.org>; Mon,  5 Oct 2020 08:45:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so12452912qkj.7
        for <linux-rdma@vger.kernel.org>; Mon, 05 Oct 2020 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HdiLxL+XgJHj89adxKS6WROG6H4m0IsM+YfXaTJqQI=;
        b=dYuS7FCxJmuHvWGDqvaoZYldRON/qbpkU6VZ5IInJY4EFssUkegf12NN4kpOOO4D61
         v0Xf6V8leLtCXXHkQlz8GG3HUuLIxke31AI9h8hscI5pVnRHuoZe6CSFaRMiWpX7W41a
         FXazpUfuKvR+fj/rtcyjjCvEjmQrcLWYW9eKpPwXN7jcF3PfWK/k51blD3uiszoc9dQS
         3B9Lk7KY1+8tiL5zoII708Oc2xV0LJjCO4c9T6Exg8Ap5fzJpA7kN9D8ropkzISd+TB7
         Goq9tGNZGPiYDpKOdkXIj5MHImLRYbw/l4EBldX49wv2+0Xk9FDhQf4RRoU9QBNKYMVu
         vfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HdiLxL+XgJHj89adxKS6WROG6H4m0IsM+YfXaTJqQI=;
        b=apP5dDHN1pRSvbjEDYNu69WGmT2xYJsD1vKuLR25cHmkDEu2965HJTJRY3KKMGX7TU
         iPoxU7/KrUWRzNGDMab5IHxlrfjXJtCAZ7UkBj2zBC0UV7DU6RIQz7w9NIi9IDonXFT8
         u0bR2iZkeds1qrLN7fl/UvoxL/GWy5HLF/15yHZPVUL9OOa6R052gQQgKAbs3XrKMV8w
         e1EBA7c94OPPlGkbVkvv2l08JxvkNNesHeZ0BV1+VM5HfD3F4bp/ZhvxGwqMdI8ECC/A
         AKNKjwIcog7UfxSVQxOG18ZXAKTLJknd99ePo0XBhFQ5XeOdpqnyiCKEc2dQIaJxhY7t
         rmPA==
X-Gm-Message-State: AOAM533GQdgkw3SIzyfvdyfC4INNHFxaBAmjglribKY1xc9hjCa6x5le
        /42QQUw9pRrxHSwdTVpeT/hfW/hZ54JQMIw5
X-Google-Smtp-Source: ABdhPJxb1MOrgLl9LwCCgZEirA6X37bfvl1YMskERVCTRqgDeG1BE3ern2Y+GCMcvWmaljVdV9gkPg==
X-Received: by 2002:a05:620a:389:: with SMTP id q9mr580865qkm.349.1601912750572;
        Mon, 05 Oct 2020 08:45:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g12sm248745qke.90.2020.10.05.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:45:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPSgO-007gWB-UO; Mon, 05 Oct 2020 12:45:48 -0300
Date:   Mon, 5 Oct 2020 12:45:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201005154548.GT9916@ziepe.ca>
References: <d0459663-e243-c114-b9d1-9cf47c8b71e0@oracle.com>
 <fd402e39-489e-abfd-a3a7-77092f25ced8@oracle.com>
 <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 11:02:18PM +0800, Ka-Cheong Poon wrote:
> On 10/5/20 10:25 PM, Jason Gunthorpe wrote:
> > On Mon, Oct 05, 2020 at 09:57:47PM +0800, Ka-Cheong Poon wrote:
> > > > > It is a kernel module.  Which FD are you referring to?  It is
> > > > > unclear why a kernel module must associate itself with a user
> > > > > space FD.  Is there a particular reason that rdma_create_id()
> > > > > needs to behave differently than sock_create_kern() in this
> > > > > regard?
> > > > 
> > > > Somehow the kernel module has to be commanded to use this namespace,
> > > > and generally I expect that command to be connected to FD.
> > > 
> > > 
> > > It is an unnecessary restriction on what a kernel module
> > > can do.  Is it a problem if a kernel module initiates its
> > > own RDMA connection for doing various stuff in a namespace?
> > 
> > Yes, someone has to apply policy to authorize this. Kernel modules
> > randomly running around using security objects is not OK.
> 
> The policy is to allow this.  It is not random stuff.
> Can the RDMA subsystem support it?

allow everything is not a policy
 
> > Kernel modules should not be doing networking unless commanded to by
> > userspace.
> 
> It is still not clear why this is an issue with RDMA
> connection, but not with general kernel socket.  It is
> not random networking.  There is a purpose.

It is a problem with sockets too, how do the socket users trigger
their socket usages? AFAIK all cases originate with userspace

> So if the reason of the current rdma_create_id() behavior
> is that there is no such user, I am adding one.  It should
> be clear that this difference between kernel socket and
> rdma_create_id() causes a problem in namespace handling.

It would be helpful to understand how that works, as I've said I don't
think a kernel module should open listening sockets/cm_ids on every
namespace without being told to do this.

> If the cma_wq is re-designed, number of namespaces should be one
> input parameter on creating how many threads and other resources
> allocation/scheduling.  One cma_wq per namespace is the simplest
> allocation.

no, it will just run all CM_IDs concurrently on all processors.

Namespaces are not cgroups, we don't guarentee anything about resource
consumption for namespaces.

Jason
