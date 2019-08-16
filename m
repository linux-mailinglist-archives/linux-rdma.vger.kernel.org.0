Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6E90109
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2019 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfHPMA0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Aug 2019 08:00:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39216 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfHPMAZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Aug 2019 08:00:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id 125so4450136qkl.6
        for <linux-rdma@vger.kernel.org>; Fri, 16 Aug 2019 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/qVVc4Ndw3gJRn05szSsROp3wT6CgWctxV/oGRNQyFY=;
        b=BliBDuOTmmzKb1fvdGpULffy3f7D31KlMce4kKpsDB4HhfWNYAVF7cdWYedmHCvps+
         Yy4rU3veUasaiPjR+JFdarWxq5/w+MRAOlYTlAaEKz3LXWTIkqxQAvnu9ysOpHbQHpOz
         E/+rbZggmUz6RXqDwfxxxFeO86d6MjsLC75TucC4ghMIEYtXBYEulUM4hlA2Vp1iCo4c
         GRql5HU5VPQ5G2v/bGbK8VhGC5hiJL8X4rkVFmidNlPHUNgUr7yFl0SZPx+oboVicYkx
         63/BLg7Vnm72d8hj3lcBlWW9jM9NWflKEPsonrpMcmaIn+i9B1jYWgNp/VvYWoyG5BrK
         m4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/qVVc4Ndw3gJRn05szSsROp3wT6CgWctxV/oGRNQyFY=;
        b=RCp50vaa0v5Yp0kSX+GSL0JYUTnUKxaSVT/V4Ng4sxz65Ksrgo4oFZR0yclZmXyyAE
         Lo1XY7G7o+IdNPl2Q1MnBUv6azBIz2VjUa0yNJh5Udq6usqNzbDUKLH73pAygezUw8hO
         gK4ltBc3bMynRV0BXRwIY9V4YEbm4RtWn5g0WJFF66cjmhG6xPZoBY/btYXongpPMvwf
         m4qCODLXIgq8BCwgmVjFSIoNpplJF1yU/X+g7A4AhY7z15rT3bt0vPvFHre6GVtG3/HU
         DxxFL8xFMr6pPJIJ0YxTG/CSSEUplg2ihjT2tmYQt5BEGrFWNFR7JG0pEc0XA34VpKh4
         JT6Q==
X-Gm-Message-State: APjAAAUvWKwOTO9e53hhxTvvELWQtBC7rvkkLk06pDXhQgMist1gh/0k
        4jQKjMcVfqJukcQIvDiV9imTwQ==
X-Google-Smtp-Source: APXvYqwYwZr2eR2eaki6T7+FJRijLead5BP8XCVapIfim7hY1JGzAaFHL4bvfsXXp9FNK4hmtim+1Q==
X-Received: by 2002:ae9:ea06:: with SMTP id f6mr1105102qkg.372.1565956824609;
        Fri, 16 Aug 2019 05:00:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x69sm3037646qkb.4.2019.08.16.05.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 05:00:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyau7-0001fV-Ep; Fri, 16 Aug 2019 09:00:23 -0300
Date:   Fri, 16 Aug 2019 09:00:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in
 bnxt_qplib_rcfw_send_message
Message-ID: <20190816120023.GA5398@ziepe.ca>
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
 <20190815130740.GE21596@ziepe.ca>
 <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW3t2=bCpYjkuNQeT3LSFcL9n9=awHYpSrB6VZBna4dWhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 16, 2019 at 10:22:25AM +0530, Selvin Xavier wrote:
> On Thu, Aug 15, 2019 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> > > @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
> > >       req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
> > >
> > >       rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> > > -                                       (void *)&resp, NULL, 0);
> > > +                                       (void *)&resp, sizeof(req), NULL, 0);
> >
> > I really don't like seeing casts to void * in code. Why can't you
> > properly embed the header in the structs??
> Is your objection only in casting to void * or you dont like any
> casting here? 

Explicit cast to void to erase the type is a particularly bad habit
that I don't like to see.

You'd be better to make the send_message accept void * and the cast
inside to the header.

> These structures are directly copied from some auto-generated files.

Fix the auto generator? With a proper header struct is the best way to
code this pattern.

Jason
