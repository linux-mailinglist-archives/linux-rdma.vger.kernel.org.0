Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752D52906DC
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408632AbgJPOL4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408630AbgJPOL4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 10:11:56 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DEC0613D3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 07:11:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so2745165ilo.12
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HPXoxu79axlTDJVQIxIG8QUlu16nOKhGS3CzRhj1ZMc=;
        b=KFS9cTK79o4EoRuF9ed5XQZZmdxqn9ICALvcpd94PNb3kt7mzqAXfVUE5u7MddmR+K
         79K5QzhEqNUQprrChH3nLn/VCcN9uibrtaEoo6QjitkI6FDZIsqi9Mxc4PBp+OX3U2M6
         25UhwAzyGUD+Pu1+jgM6CueaJjIyv8efWpooKqc6N5Uiq2aDwT8AyX+KrLGFH6Eji1lw
         bHboEbG6CdHvMrdXA8g5KEr+5MiRiE8N3ngrrj16sBkLZgjC/wt2SWVOId1NKuPI/xpu
         WB558S6pNvBpdWJnKbrlpkwNYTOCyKsuovYq+PT98cfiN3KCBvmutNhwv77NewC8Hhv9
         0CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HPXoxu79axlTDJVQIxIG8QUlu16nOKhGS3CzRhj1ZMc=;
        b=sirPcAISUJHD0tKXSlfBW2bf3dm5JI7077qKx4cV3c0RRExqbiXVS3huPf5zrAd0IW
         0pxSZc7n/2ioLIgJ75zvFXLYjt6bK0oqbhJiuAhlrmEUswnK2boIc3xNrVkKQ67Gat76
         rEtRblI4jZMmYGZkMzX5mtWZ+eFBOJpy4sktf/X4byyqaHOkGSDi3xo8ZmriuVE1jjrR
         fYctP6DMvP2Gx6U0AINjQ8nlf3EKC/VwEpTbCIbvj5qP/YQsAX2fI6E/zU6jPlo6q+Nd
         6I97YYCmqrP+ilwd4+vWLh80F14N76JYMjha8nU8o4oS/GlZXDJZSJc33CkAvDoALUn/
         egqQ==
X-Gm-Message-State: AOAM533nYPmkkFtLhl+5QGGJe8BIjcoP/bHSi3e1P8qldGgopmflmpnP
        xB6uAF/Za0d9FNAFhQsy9h5sqw==
X-Google-Smtp-Source: ABdhPJz4tvYKJglbN1lonM9e4+1p0JSAq7kEAPmdSjLyzk2pt8NgXt3J56wCLkoUEt8wp4TerOcgQA==
X-Received: by 2002:a05:6e02:13e8:: with SMTP id w8mr2969156ilj.139.1602857514321;
        Fri, 16 Oct 2020 07:11:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 69sm2350676iou.42.2020.10.16.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:11:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTQSW-000VCO-IF; Fri, 16 Oct 2020 11:11:52 -0300
Date:   Fri, 16 Oct 2020 11:11:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Xianting Tian <tian.xianting@h3c.com>, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Avoid allocing memory on memoryless numa node
Message-ID: <20201016141152.GC36674@ziepe.ca>
References: <20201010085732.20708-1-tian.xianting@h3c.com>
 <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba33073-044c-9da6-a90d-4626e6441793@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 12, 2020 at 08:36:57AM -0400, Dennis Dalessandro wrote:
> On 10/10/2020 4:57 AM, Xianting Tian wrote:
> > In architecture like powerpc, we can have cpus without any local memory
> > attached to it. In such cases the node does not have real memory.
> > 
> > Use local_memory_node(), which is guaranteed to have memory.
> > local_memory_node is a noop in other architectures that does not support
> > memoryless nodes.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> >   drivers/infiniband/hw/hfi1/file_ops.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
> > index 8ca51e43c..79fa22cc7 100644
> > +++ b/drivers/infiniband/hw/hfi1/file_ops.c
> > @@ -965,7 +965,7 @@ static int allocate_ctxt(struct hfi1_filedata *fd, struct hfi1_devdata *dd,
> >   	 */
> >   	fd->rec_cpu_num = hfi1_get_proc_affinity(dd->node);
> >   	if (fd->rec_cpu_num != -1)
> > -		numa = cpu_to_node(fd->rec_cpu_num);
> > +		numa = local_memory_node(cpu_to_node(fd->rec_cpu_num));
> >   	else
> >   		numa = numa_node_id();
> >   	ret = hfi1_create_ctxtdata(dd->pport, numa, &uctxt);
> > 
> 
> The hfi1 driver depends on X86_64. I'm not sure what this patch buys, can
> you expand a bit?

Yikes, that is strongly discouraged.

Jason
