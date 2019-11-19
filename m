Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA1102FC9
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 00:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKSXNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 18:13:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35387 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKSXNh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 18:13:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id i19so19571796qki.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 15:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17yvYiAWU0HGRGp9KcOWNDREPdtmfZAOUWmEXa5IV8Q=;
        b=CFH6B8zXYbvy1pYUJJbcu8xh9P/QVD9z5JiNaOpP03dFNMTRSirDeSciisIuN1TsQA
         As/ijGNvAx9+OyE4Hnp1DTwaPgjRcoWWq+wiBHbdq7EhD17YdSipISWg1TICLdaMuIXY
         lM/H1EChksx8g0UiRlsq0Y+KPp0tlPL8gbAsgj2UFVJ6GZ56v1/7ShRrNC83MmE56Mty
         /F4A+sZS8mMHYRF2AmUmsD/CJquhlsSwT99zGQSlFyFCQj7eYOxXZCzRsxMIwt4BzBwB
         HTtkNUPosiSiG5VzFAK0aWuUW9tXvIFDKo/43Zb30icp121XVTBDnTlDnBB4yim04UzW
         KUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17yvYiAWU0HGRGp9KcOWNDREPdtmfZAOUWmEXa5IV8Q=;
        b=OsZwvHDoJAAmjroiBLeEr0m5vQryn6e1g1RmuGlTOX3L7XDbBKj4kctJZnl12PSvdP
         O+M3DA1z2TdoTwaqtCXqagq3088E9dYcUqSggpAvtNmtESOuteji9rKUyWEgf+5RV3Je
         FiHBHiM3X0NTdA2Jp5YLKcaCaDc8D8HsSWfwfCzFXP9S76M03yjWyBvX6xR0n7qaEDbG
         CICKh5j3wp+hgtJU+sJWuRa5DsyKeFXXxEe5R0uAhkmYG8tHCd6CVtG/6yAoTMW1YxdG
         NRJ3+bJBluQtrGCOoY/LYzHzd6NfnNIz95A0eAfF5wXpuhd2a8D1DWcqqpZq39mtyAlU
         vsuQ==
X-Gm-Message-State: APjAAAW2iCXoeDWD/eksENfl2w57xkoRIcIxwWLjLXZCSqOCbv6y41Lg
        7Qe/CnneErdCPdh2E84MiwLesA==
X-Google-Smtp-Source: APXvYqxkAxQNe/mh+W9e4zwMrMhZARAyEI1xOqHgisjcDpSWmv77QsRLXTnzw8xWHepRdkYoW9QjIQ==
X-Received: by 2002:ae9:e702:: with SMTP id m2mr106007qka.269.1574205216019;
        Tue, 19 Nov 2019 15:13:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b4sm297485qka.75.2019.11.19.15.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 15:13:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXCgh-0004m0-03; Tue, 19 Nov 2019 19:13:35 -0400
Date:   Tue, 19 Nov 2019 19:13:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191119231334.GO4991@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 02:38:23PM -0800, Rao Shoaib wrote:
> 
> On 11/19/19 12:31 PM, Jason Gunthorpe wrote:
> > On Mon, Nov 18, 2019 at 11:54:38AM -0800, rao Shoaib wrote:
> > > From: Rao Shoaib <rao.shoaib@oracle.com>
> > > 
> > > Introduce maximum WQE size to impose limits on max SGE's and inline data
> > > 
> > > Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
> > >   drivers/infiniband/sw/rxe/rxe_param.h | 3 ++-
> > >   drivers/infiniband/sw/rxe/rxe_qp.c    | 7 +++++--
> > >   2 files changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> > > index 1b596fb..31fb5c7 100644
> > > +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> > > @@ -68,7 +68,6 @@ enum rxe_device_param {
> > >   	RXE_HW_VER			= 0,
> > >   	RXE_MAX_QP			= 0x10000,
> > >   	RXE_MAX_QP_WR			= 0x4000,
> > > -	RXE_MAX_INLINE_DATA		= 400,
> > >   	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
> > >   					| IB_DEVICE_BAD_QKEY_CNTR
> > >   					| IB_DEVICE_AUTO_PATH_MIG
> > > @@ -79,7 +78,9 @@ enum rxe_device_param {
> > >   					| IB_DEVICE_RC_RNR_NAK_GEN
> > >   					| IB_DEVICE_SRQ_RESIZE
> > >   					| IB_DEVICE_MEM_MGT_EXTENSIONS,
> > > +	RXE_MAX_WQE_SIZE		= 0x2d0, /* For RXE_MAX_SGE */
> > This shouldn't just be a random constant, I think you are trying to
> > say:
> > 
> >    RXE_MAX_WQE_SIZE = sizeof(struct rxe_send_wqe) + sizeof(struct ib_sge)*RXE_MAX_SGE

> I thought you wanted this value to be independent of RXE_MAX_SGE, else why
> are defining it.

Then define 

   RXE_MAX_SGE = (RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe))/sizeof(rxe_sge)

And drive everything off RXE_MAX_WQE_SIZE, which sounds good

> > Just say that
> > 
> > >   	RXE_MAX_SGE			= 32,
> > > +	RXE_MAX_INLINE_DATA		= RXE_MAX_WQE_SIZE,
> > This is mixed up now, it should be
> > 
> >    RXE_MAX_INLINE_DATA = RXE_MAX_WQE_SIZE - sizeof(rxe_send_wqe)
> 
> I agree to what you are suggesting, it will make the current patch better.
> However, In my previous patch I had
> 
> RXE_MAX_INLINE_DATA		= RXE_MAX_SGE * sizeof(struct ib_sge)
> 
> IMHO that conveys the intent much better. I do not see the reason for
> defining RXE_MAX_WQE_SIZE, ib_device_attr does not even have an entry for it
> and hence the value is not used anywhere by rxe or by any other relevant
> driver.

Because WQE_SIZE is what you are actually concerned with here, using
MAX_SGE as a proxy for the max WQE is confusing

Jason
