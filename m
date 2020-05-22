Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03BC1DE8EE
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEVO2d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgEVO2d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 10:28:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C511C061A0E
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 07:28:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so8364174qtn.13
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KhVHSvsx1IIcDHQmyE3Q1FWI6jS+mdIvVR2N/hzufVY=;
        b=aF0VgOXTDmPeONhvEGOhpcSxKP0hKjBMDv6maxwoRJl4UCotqckxkUkC8dgWUJnbbR
         ZS7BrsjxQBacCtyq5fUAhoipLjsYrKVKGNOllgdTrJvO8x9kw8XYuUsAlOhCrWefdD5v
         E2c+0L7JXQC0wtzq2l5wx/yB3SeT30bDlNE0Fi20sluKVp+mwWIziK74S3Qf4vlPy3+T
         LkPQM/Gv/pxpyz5rFHouPJmFG+8zqmqAdyrpAdimm2rihiklrbPcWo+volZr+aac3Ed9
         wWps7sA63OaNr1muxm0PdwRdd9vZs/vvij7oRlkcwuEmtDxz6FYFKNUQpEzrEYSNGHLL
         OJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KhVHSvsx1IIcDHQmyE3Q1FWI6jS+mdIvVR2N/hzufVY=;
        b=EE7V+WZN/9ioyin0RcBAgmYnoztAZiZIX+292R6lNpDOJsQhJIcNMvM9eBcIKkVQYn
         eqbODngCEBpIeAhDvFwF97ujgekKlUSJr7LGn4Eyw5B87uC9tL0nWl19X+KsBsIYApqJ
         +YfoV8nzIqeHyvtWdg3RovGjnRa2AlLn6TMGRlsRxJ8Cl3shGXSYOwkAOZ+tzPADxtMv
         DgPmET7w92BJ1BT/rCx9mCBnyZVhoWBlYWOg6e8UdM3FnGSAinp5Ju1c9KUEFKyFW60e
         uNzCe82NSATKmefTz4ce4i0FzJ1kdoR3d7UY2NI54+O/XQu2lWZek4Z/j1yDYUaOslln
         kWtw==
X-Gm-Message-State: AOAM5336sWZxkpa0K52XXpiInOQa8C149h1jPr4fvrSBybIJ3XCwmn2e
        Qp8IehbswhH0B0RB8Lr9ctmy+EIfc10=
X-Google-Smtp-Source: ABdhPJz/Rg8ZHEgAVPwqNxq2JjTyBL8EWzUvZKnPY7/KGHsC9s8VRMk4qyX62p1PVfgweAad21bRYg==
X-Received: by 2002:ac8:4645:: with SMTP id f5mr15420873qto.379.1590157712396;
        Fri, 22 May 2020 07:28:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l184sm7354184qkf.84.2020.05.22.07.28.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 07:28:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jc8f0-00031y-QZ; Fri, 22 May 2020 11:28:30 -0300
Date:   Fri, 22 May 2020 11:28:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     liweihang <liweihang@huawei.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/9] RDMA/hns: Various fixes and cleanups
Message-ID: <20200522142830.GG17583@ziepe.ca>
References: <1588931159-56875-1-git-send-email-liweihang@huawei.com>
 <B82435381E3B2943AA4D2826ADEF0B3A0236A7A2@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A0236A7A2@DGGEML522-MBX.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 22, 2020 at 07:39:31AM +0000, liweihang wrote:
> On 2020/5/8 17:46, Weihang Li wrote:
> > This series contains the following:
> > - #1 ~ #2 are fixes to solve issues found from previous versions.
> > - #3 ~ #5 are fixes for recent refactoring codes to 5.8.
> > - #6 ~ #9 are various cleanups.
> > 
> > Lang Cheng (2):
> >   RDMA/hns: Fix cmdq parameter of querying pf timer resource
> >   RDMA/hns: Store mr len information into mr obj
> > 
> > Lijun Ou (2):
> >   RDMA/hns: Bugfix for querying qkey
> >   RDMA/hns: Reserve one sge in order to avoid local length error
> > 
> > Weihang Li (3):
> >   RDMA/hns: Fix wrong assignment of SRQ's max_wr
> >   RDMA/hns: Fix error with to_hr_hem_entries_count()
> >   RDMA/hns: Remove redundant memcpy()
> > 
> > Wenpeng Liang (1):
> >   RDMA/hns: Fix assignment to ba_pg_sz of eqe
> > 
> > Xi Wang (1):
> >   RDMA/hns: Rename macro for defining hns hardware page size
> > 
> >  drivers/infiniband/hw/hns/hns_roce_alloc.c  |  6 ++--
> >  drivers/infiniband/hw/hns/hns_roce_cq.c     |  4 +--
> >  drivers/infiniband/hw/hns/hns_roce_device.h | 15 +++++---
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 53 ++++++++++++-----------------
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++-
> >  drivers/infiniband/hw/hns/hns_roce_mr.c     |  8 +++--
> >  drivers/infiniband/hw/hns/hns_roce_qp.c     |  9 ++---
> >  drivers/infiniband/hw/hns/hns_roce_srq.c    | 10 +++---
> >  8 files changed, 56 insertions(+), 53 deletions(-)
> > 
> 
> Hi Jason,
> 
> I notice that this series has been marked as "Accepted" on patchwork,
> but I can't find them on your for-next branch. Maybe there is something
> wrong :)

It is in the wip branch waiting on 0-day to test compile it

Jason
