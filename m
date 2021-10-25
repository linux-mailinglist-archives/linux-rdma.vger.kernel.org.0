Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4643988B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhJYO33 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhJYO33 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Oct 2021 10:29:29 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C91DC061745
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 07:27:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id h20so11749446qko.13
        for <linux-rdma@vger.kernel.org>; Mon, 25 Oct 2021 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E+RXaAad/88bi58SgYaktuE/naqAZxrWdHMADOFintY=;
        b=eenHDFbsTVvt6vxVNODxcIXsTN0l4jCt25gps8xTah5IPMExjPizIIAoUUJuzRWJQZ
         4xouG4B6LJ/xJoQ6QWKRR9MSCmtyhKmfkCsl1kfX+RBJAc3B/p4LLYdtHxNm0Rs8TRXW
         8cUlOF/nIXBbKyHIsbF3HgruvA6+Sv6Bx3bwCShSdY/z2EfCtZE6t2NQJtDwig/b7Cwp
         MA8hX+a/u1M4XQWZKM53ASBrTj7cyYVCcDPjcGEyc1saxTGAmNrcBVh6LJilJ7PZU14l
         30v+iaCy92u0Xn55lgfidWCOzh1YNYNDwpa8v8pSh+mIF4vigUmuSPswU8dEmjaxCCax
         iu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E+RXaAad/88bi58SgYaktuE/naqAZxrWdHMADOFintY=;
        b=UrIq93pVyKdXHTYG+Cf84xI2jSihHWlNyPju6guFapLLwJ7i+ey6hocY4/YmXWqk0A
         ywjk7ujXg3GZ7hWf2jJIDIBqDGvKX4vQblXsbg60YJKPNJyPAjbk+OQ9Lgwu2lmBFT3u
         kUh5p2hRJMuCvTniqWcHrPCSru6kb32ZInBQlFQFN1PMkxpGQDVc0vtohUTtIVq8lzhN
         +RiXGeQWLLvjyZJF4h99OxlusS8tQTuViSQaJiU4XrKP30Ah/17XWsgZon2gZlwIIBbh
         h/HGgzSQWdZbUNrvqjOejJG/xhaGIPh7nvedwgxc57vZolJCKT3my5T7f3Y5vTse5M/s
         Uiiw==
X-Gm-Message-State: AOAM531WJ7ARkW65L07P9uFa3OsCyRmPjzfoV/OKer+aPqnDpOTKmUoD
        m7NVt1F+ejRmXMv+F5WRPCJYaQ==
X-Google-Smtp-Source: ABdhPJzwfXE/vJH5ay8sIo5JK05TG9h2QRR7fwxS+SJpNe5lWSNq/eZbgVE/MtYv3NZRdOq1XfQktA==
X-Received: by 2002:a05:620a:4488:: with SMTP id x8mr13760936qkp.32.1635172026417;
        Mon, 25 Oct 2021 07:27:06 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id t22sm3422658qtw.21.2021.10.25.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:27:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mf0wK-001Tc3-Ow; Mon, 25 Oct 2021 11:27:04 -0300
Date:   Mon, 25 Oct 2021 11:27:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Ariel Elior <aelior@marvell.com>,
        Alok Prasad <palok@marvell.com>
Subject: Re: [PATCH for-next] RDMA/qedr: Remove unsupported qedr_resize_cq
 callback
Message-ID: <20211025142704.GK3686969@ziepe.ca>
References: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR1801MB20576F5ED830B11E8F83A037B2839@DM5PR1801MB2057.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 09:24:41AM +0000, Prabhakar Kushwaha wrote:
> Dear Kamal,
>  
> > From: Kamal Heib <kamalheib1@gmail.com>
> > Sent: Monday, October 25, 2021 9:27 AM
> > To: linux-rdma@vger.kernel.org
> > Cc: Michal Kalderon <mkalderon@marvell.com>; Ariel Elior
> > <aelior@marvell.com>; Doug Ledford <dledford@redhat.com>; Jason
> > Gunthorpe <jgg@ziepe.ca>; Kamal Heib <kamalheib1@gmail.com>
> > Subject:  [PATCH for-next] RDMA/qedr: Remove unsupported
> > qedr_resize_cq callback
> > 
> > External Email
> > 
> > There is no need to return always zero for function which is not supported.
> > 
> > Fixes: a7efd7773e31 ("qedr: Add support for PD,PKEY and CQ verbs")
> > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> >  drivers/infiniband/hw/qedr/main.c  |  1 -  drivers/infiniband/hw/qedr/verbs.c |
> > 10 ----------  drivers/infiniband/hw/qedr/verbs.h |  1 -
> >  3 files changed, 12 deletions(-)
> 
> Have you tested this patch? I afraid, there may be a crash because of  this 
> 
> static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
> {
> <snip>
> 
>         cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
>         if (!cq)
>                 return -EINVAL;
> 
>         ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);    <<<< No check for NULL.

The NULL check is here:

		DECLARE_UVERBS_WRITE(IB_USER_VERBS_CMD_RESIZE_CQ,
				     ib_uverbs_resize_cq,
				     UAPI_DEF_WRITE_UDATA_IO(
					     struct ib_uverbs_resize_cq,
					     struct ib_uverbs_resize_cq_resp),
				     UAPI_DEF_METHOD_NEEDS_FN(resize_cq)),

Jason
