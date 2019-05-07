Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE99E168D8
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 19:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfEGRJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 13:09:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36562 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGRJr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 13:09:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id c14so2239735qke.3
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRY6mepAUzetYwvlQRliutkiA56prNy9/A7KoI2aT7w=;
        b=CLkLlIPU/xEz1AFw3zgb5smF/7C+sy+tfwMomit+fzg9iMB9qDWAgnGTrx7WNBNUHa
         8eKl5KS0UJuniJuUQPYHyFzVq1JlgwK6dSIdbtz9v4Q672CTafPqT+X7yaks36gD9sye
         sORBSyqStEtBns1xX5IqQdAaqv28luTmudcJhzGhLfPbru6D1oZULl2ly38RE97RQt1V
         ZI5kwFLH3rcuHtPL/3T1xj5NY8dWPYWcNu7UvIXfgxWdPt2U+WzF4MnssOmYBUpcLmcb
         EtncOIjU7iUJ4PzQVdhnwRVDuJt09Hw+0GvIdyFC2RXZsJODnjiuNpvBmq2K/+E/3yXi
         hvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRY6mepAUzetYwvlQRliutkiA56prNy9/A7KoI2aT7w=;
        b=Ia3X1Djz2pvDI9JCty6p1NCUhhPG27fYYRPTmmGCURR/lQd7r/t5kwlfiuBpttko7s
         QlfnoCOCG2HskuGekRqF6hqbWKIoOlVo3zlpiPEkJonXhP/wAqYuiO/ErMDOz4vj46zI
         +QquQc1Luy8M78nQM9yV/JJG0oP5aptw4cpD9c/zAmfqvrYaZwPqNZg2pnvuukOz9nMu
         a8S9SX0+R2pLPe9FZhk1xWr3YnAh//hhWK1UaiOo1V2OkL1EcERzZnpCYsnOskmsE3pM
         IY/wyT9cCnVB8iptQX2B+3xE9jhG2JiY1eb72ry3LZrHc5JKZ1reyB/K9E0gDvHVULyc
         1Hvg==
X-Gm-Message-State: APjAAAWfrAbQwELCIJRdHu0/6NYdrojUAq2Rvb6D7fhyTWXb6oZUs+Gd
        szvVpBoNPlkuRNZ+KdqKDUpJl9JF8hk=
X-Google-Smtp-Source: APXvYqyBh6XksJw91yeQb6QYAPkhL8bbV/TjgQunJ7exDATKJHC8Z+xlCDJCP5N6pxfiKFdBdAckfg==
X-Received: by 2002:ae9:f00d:: with SMTP id l13mr19257782qkg.110.1557248985900;
        Tue, 07 May 2019 10:09:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id q5sm10020421qtj.3.2019.05.07.10.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 10:09:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hO3b5-0007Mw-66; Tue, 07 May 2019 14:09:43 -0300
Date:   Tue, 7 May 2019 14:09:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v8 02/12] SIW main include file
Message-ID: <20190507170943.GI6201@ziepe.ca>
References: <20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 07, 2019 at 03:54:45PM +0000, Bernard Metzler wrote:
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Leon Romanovsky" <leon@kernel.org>
> >Date: 05/05/2019 07:10PM
> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
> ><bmt@rims.zurich.ibm.com>
> >Subject: Re: [PATCH v8 02/12] SIW main include file
> >
> >On Sun, May 05, 2019 at 04:54:50PM +0000, Bernard Metzler wrote:
> >>
> >> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
> >> >From: "Leon Romanovsky" <leon@kernel.org>
> >> >Date: 04/28/2019 01:07PM
> >> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
> >> ><bmt@rims.zurich.ibm.com>
> >> >Subject: Re: [PATCH v8 02/12] SIW main include file
> >> >
> >> >On Fri, Apr 26, 2019 at 03:18:42PM +0200, Bernard Metzler wrote:
> >> >> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
> >> >>
> >> >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> >> >>  drivers/infiniband/sw/siw/siw.h | 733
> >> >++++++++++++++++++++++++++++++++
> >> >>  1 file changed, 733 insertions(+)
> >> >>  create mode 100644 drivers/infiniband/sw/siw/siw.h
> >> >>
> >> >> diff --git a/drivers/infiniband/sw/siw/siw.h
> >> >b/drivers/infiniband/sw/siw/siw.h
> >> >> new file mode 100644
> >> >> index 000000000000..9a3c2abbd858
> >> >> +++ b/drivers/infiniband/sw/siw/siw.h
> >> >> @@ -0,0 +1,733 @@
> >> >> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
> >> >> +
> >> >> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
> >> >> +/* Copyright (c) 2008-2019, IBM Corporation */
> >> >> +
> >> >> +#ifndef _SIW_H
> >> >> +#define _SIW_H
> >> >> +
> >> >> +#include <linux/idr.h>
> >> >> +#include <rdma/ib_verbs.h>
> >> >> +#include <linux/socket.h>
> >> >> +#include <linux/skbuff.h>
> >> >> +#include <linux/in.h>
> >> >> +#include <linux/fs.h>
> >> >> +#include <linux/netdevice.h>
> >> >> +#include <crypto/hash.h>
> >> >> +#include <linux/resource.h> /* MLOCK_LIMIT */
> >> >> +#include <linux/module.h>
> >> >> +#include <linux/version.h>
> >> >> +#include <linux/llist.h>
> >> >> +#include <linux/mm.h>
> >> >> +#include <linux/sched/signal.h>
> >> >> +
> >> >> +#include <rdma/siw_user.h>
> >> >> +#include "iwarp.h"
> >> >> +
> >> >> +/* driver debugging enabled */
> >> >> +#define DEBUG
> >> >
> >> >I clearly remember that we asked to remove this.
> >>
> >> Absolutely. Sorry, it sneaked in again since I did some
> >> debugging. Will remove...
> >> >
> >> >> +	spinlock_t lock;
> >> >> +
> >> >> +	/* object management */
> >> >> +	struct idr qp_idr;
> >> >> +	struct idr mem_idr;
> >> >
> >> >Why IDR and not XArray?
> >>
> >> Memory access keys and QP IDs are generated as random
> >> numbers, since both are exposed to the application.
> >> Since XArray is not designed for sparsely distributed
> >> id ranges, I am still in favor of IDR for these two
> >> resources.

IDR and xarray have identical underlying storage so this is nonsense

No new idr's or radix tree users will be accepted into rdma.... Use
xarray

Jason
