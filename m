Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792FA25D766
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgIDLdC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 07:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbgIDLcu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 07:32:50 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C5C061246
        for <linux-rdma@vger.kernel.org>; Fri,  4 Sep 2020 04:32:49 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id w12so5937089qki.6
        for <linux-rdma@vger.kernel.org>; Fri, 04 Sep 2020 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=przGtC/GACBkh9fYWt057mWQgDPtk/XBjjLtmZvZQ+g=;
        b=CiTKYzFR1SlCmJbwj/xOxE6xWzBs6RH2zeSKaKFBjBhcpFr4pkn/ah6RdybJU7yao4
         nSdHLMr+/Tm4mTOX7WrRjWYt0kOE1RCPRD1EMTcEvHf16ybZxa2JmNYgfgZDyYIft6eo
         M9Z6J+QbdywHuN+kIBlZeeKbYydh0o9vQXFEd6EA9Ghc6klb1wMnKUeDxXiCfLzwmz2U
         FP6rn86BkcnHOZIzPDarVVTdZw3tHAuX2C76Tmwm+NmEV8tY9mY1LUpe7hg3mIRH+0x4
         r0sh/fTm+FJ/ClJ9ccDWXH6iKGclrM5VCr1/58yVyqQ/pjm3NbUxNznIhPv3k+jZbpiK
         FN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=przGtC/GACBkh9fYWt057mWQgDPtk/XBjjLtmZvZQ+g=;
        b=kjt4QJ0up+X2440gVDrKQDAuHbpDLvOpnbIw2eP5A0nBhxiFic7StPj+8Z/hBsilmX
         j/DpvgqUoj/yfciKuX1JnrCs60DHKXI1z5jtJJoTUSHUZUaPt60HASEvuqTOdzBmPQe2
         HOuJ2jHA2Q4VYMqBAlw7gWlUNG67MIR/68Cj1q5d5NGGLcRR2I2wb/pkqG0sJuytJjcz
         fXCVBhIchONhNLRM5CIZBpiq+iVt31nlttYfYmTIVyPk2MmJDgpdUhCRD0Q+nxQ3oKns
         xl3oXOahxJmn6UYR8mc0ZzLXdCw/D/wN8HlE+F25rSjA5Z1mqt/NKQXrCzk9TxBvJyqN
         qt9g==
X-Gm-Message-State: AOAM5315L3vk+1uUfgycFPjgWrPcGAspoX6lKX7CvaPGjTkE0jvycv/h
        RciEVpd91Zigm6epXXjepem1LA==
X-Google-Smtp-Source: ABdhPJxtn7W3x3cg4A/eat2jqT4UIQl71B/vlblXAnYVQniU5ZIznFdsZeENPAauF5e+G/27DTfeaQ==
X-Received: by 2002:a37:a143:: with SMTP id k64mr7760038qke.266.1599219165446;
        Fri, 04 Sep 2020 04:32:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b187sm4277907qkd.107.2020.09.04.04.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:32:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kE9xU-007H6m-17; Fri, 04 Sep 2020 08:32:44 -0300
Date:   Fri, 4 Sep 2020 08:32:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Finding the namespace of a struct ib_device
Message-ID: <20200904113244.GP24045@ziepe.ca>
References: <5fa7f367-49df-fb1d-22d0-9f1dd1b76915@oracle.com>
 <20200903173910.GO24045@ziepe.ca>
 <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5899aa9-4553-1307-0688-f07f3a919ce8@oracle.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 12:01:12PM +0800, Ka-Cheong Poon wrote:
> On 9/4/20 1:39 AM, Jason Gunthorpe wrote:
> > On Thu, Sep 03, 2020 at 10:02:01PM +0800, Ka-Cheong Poon wrote:
> > > When a struct ib_client's add() function is called. is there a
> > > supported method to find out the namespace of the passed in
> > > struct ib_device?  There is rdma_dev_access_netns() but it does
> > > not return the namespace.  It seems that it needs to have
> > > something like the following.
> > > 
> > > struct net *rdma_dev_to_netns(struct ib_device *ib_dev)
> > > {
> > >         return read_pnet(&ib_dev->coredev.rdma_net);
> > > }
> > > 
> > > Comments?
> > 
> > I suppose, but why would something need this?
> 
> 
> If the client needs to allocate stuff for the namespace
> related to that device, it needs to know the namespace of
> that device.  Then when that namespace is deleted, the
> client can clean up those related stuff as the client's
> namespace exit function can be called before the remove()
> function is triggered in rdma_dev_exit_net().  Without
> knowing the namespace of that device, coordination cannot
> be done.

Since each device can only be in one namespace, why would a client
ever need to allocate at a level more granular than a device?

Jason
