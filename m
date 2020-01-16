Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4C13DF48
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 16:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAPPxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 10:53:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40108 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPPxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 10:53:04 -0500
Received: by mail-qt1-f196.google.com with SMTP id v25so19232267qto.7
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i7NTAXzB1w6OZi8wh7MAxhZ8SUZX2K16pqrakSHjTlY=;
        b=B0xCPtFkmozoeMJuWIrPg29xNBiRYvxx2MFQp/T8Iz5yO/XRPSFzRiHjYsQ0uzELXd
         06avWwsMbilXdNArYAtbry06RDtA6XOKKX3Urzg4PpzYYOl1VKN5qsStgvt8IMIj6d9G
         D7hN49JOSCSZJKx3GbX2xt1vJXVS3dUbRpmF6zZ0EiiqpiXwyAFFPcAys4amG86eJjxR
         GlKVLZkMNhqz7nHril/QyFSqtI6X6Zws9OCJ+tZJXeJmZ8OjDFEtmKKjKD3HZxgAoCe6
         bdBqRS4QKF/iaFnKgrNuWyvLnJUbecDatWU9uBETQbIdyiA2OFW059AlKZvP44Y+BEnG
         coqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i7NTAXzB1w6OZi8wh7MAxhZ8SUZX2K16pqrakSHjTlY=;
        b=A2beWxRgjw2Vd6pgUtXszXLZOeMcTOnqsGmql5ACROHyF+F3+QUpeHkC9mz+jp7a1i
         0ID9LfL7/E96iwc/2USIJlk/eRoYJNCcHU16ASPithN/7YgTOGgWoymu70ba7pSLkc0A
         Xi3nCiiITdyEukCwF62+76nTlGY58qJorS7QQKDnEEBOiU7EFtFNcW9xlNFKDYc9ULFH
         mRiX1qX1s65bbWhxClzc+q7TV3TsL7zVUBapM3i7WGuT+tXf+VpMst7FDh9dJjJa+x0A
         CrB+1y3p4JltP8iL/rHaBBu7huI82hInPAP9/D9AmHXqeXhkaC7yEkXscEfPciVkQGZN
         qWZw==
X-Gm-Message-State: APjAAAWdOWdWLJUqJ40gRxZx7gLdSJM4oyBhPsvv4YKUrt0yKvhmVOFX
        VeTXu7ebeX5YWuC7zZIDpRVqCQ==
X-Google-Smtp-Source: APXvYqyx4lxthDx8vBkWHLxM4URs/uWRwPfgqChXoksGLx97cT2Uje2lMGgFGNulOk2sEmv7KWsBAw==
X-Received: by 2002:ac8:1c23:: with SMTP id a32mr2966994qtk.119.1579189983893;
        Thu, 16 Jan 2020 07:53:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c8sm11250513qtv.61.2020.01.16.07.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 07:53:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is7S9-0006D9-84; Thu, 16 Jan 2020 11:53:01 -0400
Date:   Thu, 16 Jan 2020 11:53:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200116155301.GC10759@ziepe.ca>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal>
 <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> > > +             wake_up(&clt->permits_wait);
> > > +}
> > > +EXPORT_SYMBOL(rtrs_clt_put_permit);
> > > +
> > > +struct rtrs_permit *rtrs_permit_from_pdu(void *pdu)
> > > +{
> > > +     return pdu - sizeof(struct rtrs_permit);
> >
> > C standard doesn't allow pointer arithmetic on void*.
> gcc never complains,  searched aournd:
> https://stackoverflow.com/questions/3523145/pointer-arithmetic-for-void-pointer-in-c
> 
> You're right, will fix.

The kernel extensively uses a gcc extension treating arithmatic on a
void * as the same as a u8, you can leave it for kernel code.

But is generally a big question why code is written like that, always
better to use a struct and container_of

Jason
