Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75F439682F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 May 2021 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaSyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhEaSys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 May 2021 14:54:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F99C061574
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 11:53:05 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i67so12010876qkc.4
        for <linux-rdma@vger.kernel.org>; Mon, 31 May 2021 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEkk/ITpvHkKdtzNaLnzY0QISIdFdpY29w+84yI8yu0=;
        b=GKhOEDol+D6tp+hLfkgfkbr/5pJcfv8SaJxLfmM6rumHk+16ax5iL2EFttaq7WF4Lk
         o03wYDlx5CE3cDwSsrCbPHCf5VAjti1s8wmYmlO3ebscoEKJli5mLa/XEAhm8gQb8Xtb
         NMTnXnJKPIkG+8S5ztF0J7n8rA8yvrAm0sMl1OB02zxgO/EmSFFErziuvz9gSk88HXY8
         MXZRpHOap3JSPxQWk0uVLDTXKqHuFs38p8F7bzV85HTilyt/pGrgt3Na2xuh4DiIpORu
         /VSzXPJWMHvWoKGcx8ITuz7wjaTlZ8nYAujZ+rG9pG8GK0qsIB3VkVfYebjZHUxa4GIf
         hX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEkk/ITpvHkKdtzNaLnzY0QISIdFdpY29w+84yI8yu0=;
        b=Ni2k5/nITZUJMbZMQONybGbQjQn+0Hnn2ZDBwKy9zWzF4CRULPcgINjCOAo6UciCpG
         PqC0NG5yk7d5/Qipogeak+c7Wafgo2cN9E8HgP37mrXTQGD1iWxLChvlwjT6cE68thT/
         SMOgt2ZWp7Pvxo8JqMCebLg7Q3EDES5QUwhR9CVO0MJDQOqrYI0/4FKOPmgWNvfb6ZsA
         OnAA6ktUyuD1SrOXETJoGPoeu761AdctSZYtXdnDljjpZuNmJ99RBtlDHMtc7dvB0a4U
         THwN8pOkRocwix8TjBUhbVyLXtQBe6KequNzuI7DHavTpXNXxTm9nZQT/H2zxrUEdxGB
         HCoA==
X-Gm-Message-State: AOAM532cEBrdcYD05iycKgan7vK+Fpc6Y5tqbDTCpxCmHEfZss88nAki
        8SaHPqFG4Nf6fihadd+TS/b2rULu9gMroA==
X-Google-Smtp-Source: ABdhPJzMJBBNHOyS0zhaJ3s7HuKY3W1slAuHyBQOZ0MRu0iQhJkk3xSwWhA0cZjEQT0+i0gveHkvTQ==
X-Received: by 2002:a05:620a:1368:: with SMTP id d8mr12191619qkl.283.1622487184717;
        Mon, 31 May 2021 11:53:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id o5sm8839227qtl.85.2021.05.31.11.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 11:53:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lnn27-00HDzW-O2; Mon, 31 May 2021 15:53:03 -0300
Date:   Mon, 31 May 2021 15:53:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH V3 rdma-core 0/5] Broadcom's user library update
Message-ID: <20210531185303.GM1096940@ziepe.ca>
References: <20210528093946.900940-1-devesh.sharma@broadcom.com>
 <CANjDDBi6VS+yyR7BjWY6_=YUEoxYojL6Yy=82i2sfbRzybGczw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBi6VS+yyR7BjWY6_=YUEoxYojL6Yy=82i2sfbRzybGczw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 10:09:06PM +0530, Devesh Sharma wrote:
> On Fri, May 28, 2021 at 3:09 PM Devesh Sharma
> <devesh.sharma@broadcom.com> wrote:
> >
> > The focus of this patch series is to move SQ and RQ
> > wqe posting indices from 128B fixed stride to 16B
> > aligned stride. This allows more flexibility in choosing
> > wqe size.
> >
> > v2 -> V3
> >  - Split the ABI change into separate patch
> >  - committed ABI patch using standard rdma-core script.
> >
> > Devesh Sharma (5):
> >   Update kernel headers
> >   bnxt_re/lib: Read wqe mode from the driver
> >   bnxt_re/lib: add a function to initialize software queue
> >   bnxt_re/lib: Use separate indices for shadow queue
> >   bnxt_re/lib: Move hardware queue to 16B aligned indices
> >
> >  kernel-headers/rdma/bnxt_re-abi.h |   5 +-
> >  providers/bnxt_re/bnxt_re-abi.h   |   5 +
> >  providers/bnxt_re/db.c            |  10 +-
> >  providers/bnxt_re/main.c          |   4 +
> >  providers/bnxt_re/main.h          |  26 ++
> >  providers/bnxt_re/memory.h        |  37 ++-
> >  providers/bnxt_re/verbs.c         | 522 ++++++++++++++++++++----------
> >  7 files changed, 431 insertions(+), 178 deletions(-)
> >
> >
> Jason/Leon,
> 
> Both user and kernel components related to these changes have been
> posted quite a while ago. Could you please take these in if there are
> further comments.

Where is the kernel part here:

https://patchwork.kernel.org/project/linux-rdma/list/

?

Jason
