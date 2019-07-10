Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5A64B6A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGJRZJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 13:25:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39784 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJRZI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 13:25:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id w190so2523052qkc.6
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2019 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWts3AWfLnZY/8+mDzywCA4nm3cpMgjgcvkY/eDGR8o=;
        b=ncmtdtrO5IfRIdy6defB/gA1akppNcnrs/xDXn6wjW/eWkMukIrAk8PP/ePQIhRMbi
         54aoWJB5p7Lbx+mF1/hicNwDphXcetqHU2j3iUsddC4fGCH8bY5TnJZPD0//g/Xjs2S4
         EaekTTVYdUM3ylNuE2NNtIDnRIsxFjhSmM+8ID1PtZvKbRC8kIkioM7t4qzCbvtPIsBF
         D/WZ5xnPT0XBrlT6C4zpOkmQkMBGLwM4KPXvEw7cBt64OJZYFRJm5qA2SqbuzsBeqOUd
         ZH1QM+bLzcENhT+4B0d/ht/Se7EBhN48Jur9ancatz4ItZPZuNjxzihfLyr9B5f0kq26
         eK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWts3AWfLnZY/8+mDzywCA4nm3cpMgjgcvkY/eDGR8o=;
        b=P5Hex1dpDoQmHvp94KQs8YVs98oR3erPhANhpZVlAzfaQBv7FCg22qfrhlTcmquZZz
         h12l1l+AbJC/RY0X7Nz4Xipwk2S+Pd5OBTLkb7HxmEkOJfCtTNi8nnXBrYk/lbFkpYln
         bDpr/D7ph3jSXwT2OrI8In4HPqoW0tJacwgK2MXWGRLT2PR38onz8tUgLDEmLzNEQqLH
         YKvHFhpqtBNQayYlIgkGx8EAlZns6Ap2UCTjgxA57ekDevH9bO78kQIfIlSUmbL2VdGN
         TOHVumPse5Ql7kgQVK81gxHWaw7Gw73Os+2EG41/r+IX89PX1X6AAOjucdSZBC+mXFHj
         x0yA==
X-Gm-Message-State: APjAAAVf+68BP6XDbIKGGDB+QtTPPCnAKzJ/4M8lecuTgbXQBdJsWP6I
        jK8Ogw1/fgUk1njGsg6yunkwzg==
X-Google-Smtp-Source: APXvYqywp1nQDJSnPdloNfzGTdBxnieSDQEVi61zIVsJYQritxdbe6jGkDlH5zkBnCGtuhW9rBbfIA==
X-Received: by 2002:a37:b045:: with SMTP id z66mr24424150qke.501.1562779507861;
        Wed, 10 Jul 2019 10:25:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id y194sm1420543qkb.111.2019.07.10.10.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 10:25:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlGL3-00046r-EV; Wed, 10 Jul 2019 14:25:05 -0300
Date:   Wed, 10 Jul 2019 14:25:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>, bvanassche@acm.org,
        dledford@redhat.com, Roman Pen <r.peniaev@gmail.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
Message-ID: <20190710172505.GD4051@ziepe.ca>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me>
 <20190710135519.GA4051@ziepe.ca>
 <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 10, 2019 at 09:25:05AM -0700, Sagi Grimberg wrote:
> 
> > > Another question, from what I understand from the code, the client
> > > always rdma_writes data on writes (with imm) from a remote pool of
> > > server buffers dedicated to it. Essentially all writes are immediate (no
> > > rdma reads ever). How is that different than using send wrs to a set of
> > > pre-posted recv buffers (like all others are doing)? Is it faster?
> > 
> > RDMA WRITE only is generally a bit faster, and if you use a buffer
> > pool in a smart way it is possible to get very good data packing.
> 
> There is no packing, its used exactly as send/recv, but with a remote
> buffer pool (pool of 512K buffers) and the client selects one and rdma
> write with imm to it.

Well that makes little sense then:)

> > Maybe this is fine, but it needs to be made very clear that it uses
> > this insecure operating model to get higher performance..
> 
> I still do not understand why this should give any notice-able
> performance advantage.

Usually omitting invalidations gives a healthy bump.

Also, RDMA WRITE is generally faster than READ at the HW level in
various ways.

Jason
