Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08D821FDED
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgGNT4J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGNT4I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 15:56:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD150C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:56:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q3so15267860ilt.8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XJYp41wiroyh+xRMpnsGR4ro938m5OeCIjTvbqr40tA=;
        b=bE2IKh8sfv2dGh6SxOeh51Lox7xvEmw6cE2OjgTaB/mSWvGqr1Affm4sJT+be+TCV7
         xyMku9I+BHTSpbMNVjMcd94I/aECtEEw1fF95yGOx3bHfZ0uGJhmsL6azTIBNP0sCLtq
         UUaIS+djyVoP7CB0a0DIj0o3GkGmRAwG4J5GNg75FReWBcq5iervY38MiLtF/g8hsRkr
         QLDZ/uLnz3T0nWtm7240ekzDI4FWfwGZXnEZZUpJA5d87QSh8+S6rH/PMm3UmGvf0TSp
         wqxghKyWs29XfXLeOQSIGcSCVAe0MCRyCZx6+NEVYpjopjv+Do5+V6ctP8iWFYjGze0q
         dDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJYp41wiroyh+xRMpnsGR4ro938m5OeCIjTvbqr40tA=;
        b=SQcVitBTOUtuZ0yeDsHW8I6aftKHo80HjQyj44xi/g1YlpbS7IN6r7Dh4Hu2jPDCE3
         q6wQ7vKS5vhyR9QtSSsPXgakXsDfGECB/lnESfIfxIAPsxCWBMaoi10IQVYekOPYHNof
         FTqenCFFbUdd0fMzr5Bqhq//lD98qKFa2AZT1GYzRrCEJkLXV0DZ041AlXDReG+6YG6L
         VVtycR8MBDRK95+V3B6Qqrq6T+RhYqG/scSTMtNgcV2vnBqs1nYEVpUiUv5i1eIiqxQ5
         bEmEHwRT16USM0MWrzJShBN3/Efwd79buP7ns1Ei9+aIe3+J3dAs2lAL0CV3p94Ve63A
         ucpw==
X-Gm-Message-State: AOAM532EqQfEUy/PwCe6w5xqvA3e2NwRS92YPnqGYoqVt64hEz0IX2QN
        VO2RkS+XekKqMGfeOmhPRAJ2kQ==
X-Google-Smtp-Source: ABdhPJxxPeJDXmY4eIoIS6+Zq99Qa3a5gQAI4QAJNMoWAajXc6uykWb2eaE6hdAyvICeVL9ygpZ6SQ==
X-Received: by 2002:a92:c689:: with SMTP id o9mr6448593ilg.302.1594756568259;
        Tue, 14 Jul 2020 12:56:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f18sm10361320ilj.15.2020.07.14.12.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:56:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jvR26-00ANrc-GD; Tue, 14 Jul 2020 16:56:06 -0300
Date:   Tue, 14 Jul 2020 16:56:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: Re: [PATCH for-next v1 0/4] RDMA/rxe: Cleanups and improvements
Message-ID: <20200714195606.GE25301@ziepe.ca>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
 <20200714081433.GA13271@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714081433.GA13271@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 11:14:33AM +0300, Kamal Heib wrote:
> On Sun, Jul 05, 2020 at 01:43:09PM +0300, Kamal Heib wrote:
> > These series include few cleanup patches to the rxe driver.
> > 
> > V1:
> > - patch #4: Fix commit message.
> > 
> > Kamal Heib (4):
> >   RDMA/rxe: Drop pointless checks in rxe_init_ports
> >   RDMA/rxe: Return void from rxe_init_port_param()
> >   RDMA/rxe: Return void from rxe_mem_init_dma()
> >   RDMA/rxe: Remove rxe_link_layer()
> > 
> >  drivers/infiniband/sw/rxe/rxe.c       |  7 +------
> >  drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++---
> >  drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
> >  drivers/infiniband/sw/rxe/rxe_net.c   |  5 -----
> >  drivers/infiniband/sw/rxe/rxe_verbs.c | 24 ++++--------------------
> >  5 files changed, 9 insertions(+), 38 deletions(-)
> > 
> >
> 
> Hi Jason,
> 
> Could you please tell me if there is something blocking this patch set from
> getting merged?

Just hasn't reached the bottom of the patchworks yet, follow along
here:

https://patchwork.kernel.org/project/linux-rdma/list/

Mostly stuff goes bottom up except for trivial, rc and resend of
things I already reviewed..

So for instance you could answer Zhu here:

https://patchwork.kernel.org/patch/11585485/#23417655

To clear out that patch..

Jason
