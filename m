Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A2287A48
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgJHQqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730235AbgJHQqh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Oct 2020 12:46:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397A4C061755
        for <linux-rdma@vger.kernel.org>; Thu,  8 Oct 2020 09:46:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b1so2144715iot.4
        for <linux-rdma@vger.kernel.org>; Thu, 08 Oct 2020 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xNdHfpNl+xs60A5hj4GJeRNZkdf0T0tc8Mhdcis6lU=;
        b=HnpBxB6WVqH7Z0wl+B5qeIDajKNa58L6OAMwPJO499WN07apNP6oaNcjbQzd49nCdj
         j4hBLKd+dRbXk9YRnvqqlmfmOJ3ZL+p1hxknaoZBeKtml2mSic5yiDMHm9NtMPcwEhX2
         336Jh5fOC0ryjqi+vmDv8PKmkRG42h016GweAxrDFC9SqO+Im60vY2fW5sEpItnSapMq
         ESLwTxp3a1remfX02yIi7m/Pz2Uk5+lLAf4rsT1OF9+kELnkfcz1p/6y1Tl++u8Zx2m4
         cRJO5aOiGInzktoE9auyz5i601CrcbZvO9Q5EvmmF4lajKNyq2e9oWnAO0rmJs2AIvE0
         L+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xNdHfpNl+xs60A5hj4GJeRNZkdf0T0tc8Mhdcis6lU=;
        b=Oynf70IdSQAbxEU5Z5JEhP7dJBJz+D6Gq10JES0HH3+7TPlwOHojpXiF2Za7hbqrH3
         YXD2QiJvEks9o3Sa9GKoYRa3QwUQg1BlhDqRZ1GlGP5XXmgCjgcyZ+X/tIrbYL3bd5JM
         +9X268V/BD1I+ARaB0w9Qb5K2i1o/qRsIoQvtBgwCu8dOAwifKUa5di5VM5ZTijJtYrp
         Uw8ZAeq7/dDFqjlHsckLzBxEmdUmHsvQpUJnRRurKFG0qkNShk/qBrPnKmAnqnbmnwMS
         SVME3Fzk8GJOX9AkfaMl5DbkaawcaQPEQ00jovrmkOLi/1jhlQMQawER1bQx7WNiW/9q
         u/7g==
X-Gm-Message-State: AOAM5323PcGFJ4BxLWLxx2lA5b48OJNpv63iVeHKge0tQTo7bZjSZdVS
        ZwYxCH/tvYSDiqBFrFeX6JxGpA==
X-Google-Smtp-Source: ABdhPJyWWsFoJudtdfWhDicjVnlppaHz7zywkGSMi0Opaa+C6uUjrrGhMedPnFedcO0TTi8EbgwIgg==
X-Received: by 2002:a6b:fb0d:: with SMTP id h13mr1510684iog.151.1602175596584;
        Thu, 08 Oct 2020 09:46:36 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b3sm2428077iot.37.2020.10.08.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 09:46:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQZ3q-001XoB-Tv; Thu, 08 Oct 2020 13:46:34 -0300
Date:   Thu, 8 Oct 2020 13:46:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201008164634.GG5177@ziepe.ca>
References: <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
 <20201006124627.GH5177@ziepe.ca>
 <ad892ef5-9b86-2e75-b0f8-432d8e157f60@oracle.com>
 <20201007111636.GD3678159@unreal>
 <4d29915c-3ed7-0253-211b-1b97f5f8cfdf@oracle.com>
 <20201008103641.GM13580@unreal>
 <aec6906d-7be5-b489-c7dc-0254c4538723@oracle.com>
 <20201008160814.GF5177@ziepe.ca>
 <3AEA60FF-1E16-4BBD-98F1-E8122E85C6B5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEA60FF-1E16-4BBD-98F1-E8122E85C6B5@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 12:21:10PM -0400, Chuck Lever wrote:
> 
> 
> > On Oct 8, 2020, at 12:08 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Thu, Oct 08, 2020 at 07:08:42PM +0800, Ka-Cheong Poon wrote:
> >> Note that namespace does not really play a role in this "rogue" reasoning.
> >> The init_net is also a namespace.  The "rogue" reasoning means that no
> >> kernel module should start a listening RDMA endpoint by itself with or
> >> without any extra namespaces.  In fact, to conform to this reasoning, the
> >> "right" thing to do would be to change the code already in upstream to get
> >> rid of the listening RDMA endpoint in init_net!
> > 
> > Actually I think they all already need user co-ordination?
> > 
> > - NFS, user has to setup and load exports
> > - Storage Targets, user has to setup the target
> > - IPoIB, user has to set the link up
> > 
> > etc.
> > 
> > Each of those could provide the anchor to learn the namespace.
> 
> My two cents, and worth every penny:
> 
> I think the NFSD listener is net namespace-aware. I vaguely recall
> that a user administrative program (maybe rpc.nfsd?) requests an
> NFS service listener in a particular namespace.
>
> Should work the same for sockets and listener QPs. For RPC-over-RDMA,
> a struct net argument is passed in from the generic code:
> 
>  66 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
>  67                                                  struct net *net);
>  68 static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
>  69                                         struct net *net,
>  70                                         struct sockaddr *sa, int salen,
>  71                                         int flags);
> 
> And that struct net is then passed on to rdma_create_id().

Yes

It might help Ka-Cheong to explore how NFS should work

Jason
