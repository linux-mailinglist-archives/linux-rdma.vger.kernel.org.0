Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4878CF1A28
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 16:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfKFPjA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 10:39:00 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41112 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfKFPjA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 10:39:00 -0500
Received: by mail-qv1-f66.google.com with SMTP id g18so1582459qvp.8
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u31WnNWwrBW/5rJMi9ZaEmzsxfaNkdXgjtOVmXGd+nE=;
        b=HJgchycby9OIVINrmCKgxVk0n251D/Nkw40lFTLvTsUmRP5RYlb1bMqyQhgUB5bw8m
         xlXyJrOsxPOqSZTXj++UQ0Gb4LPRxSPzIvH+tM7+vuAXR9Gyl26Qx8sZ8mspar7mwQsN
         ja337vEQzo9n2UMf4x/tHcZdKzXnQ0x0WvdFhX25KwH9S/Lpwavn5idhy0i2jc3I+heF
         561vYtkTdHO7FqivKJu36RSey/Mf5/8/7YxQ52YRZlO0UTdolzvqBO3JJcjM6wLceW2I
         4LZO8ymYGT7R42pxugjgBDm59K5NNDFzp3JoyePPQtngQTy90E9CYttbXNDVqWxm5X0h
         6UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u31WnNWwrBW/5rJMi9ZaEmzsxfaNkdXgjtOVmXGd+nE=;
        b=ETIGKNrzlhODRf8HGJ/lCfA7453I8RSCLrGnT+gGbKgsyPBSA6V0fPhJ89CfDfBJ8p
         IT7i62nFJMk6I+SqHGUsEv0LIDaivQrQTNM4OjREIenAWrQC+Fq5hKOQDjENcrSDQjh9
         1voAott40cBqoPj+o1yoc5diOCApOzFkC8TyziHaZLYaSTlWUq8cRQXRML/430myfuyE
         nqs7BIpsk4JykG45bTlnDdSN00fIlb5t+MJkXtkTq1JNKu7Zz8XkoKmcICTBybTaUYX+
         0AMWIYNoG1Mdj7kjI1Yll/c1y5TgJ3mZ4ifvq5WHkOkg/ZP1yvRS0j1s3ahhNzU0tLVG
         ORVQ==
X-Gm-Message-State: APjAAAVrJg1XJf9oHHUqu2ul296QF8/P/xdoc7ohUbZ0j2m9zDzFyalO
        g08XeQz5b1STYHYHgDsKirvnOA==
X-Google-Smtp-Source: APXvYqz+uS96RcMcSfyguK3Gk52mNwFUtHIV/aNZMVT5aRNTY3od2jA8X9sFT3yxQ9Mn/tMTp4bKkg==
X-Received: by 2002:a0c:fa03:: with SMTP id q3mr2848438qvn.23.1573054738887;
        Wed, 06 Nov 2019 07:38:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o13sm14182050qto.96.2019.11.06.07.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 07:38:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSNOb-0003cZ-Ky; Wed, 06 Nov 2019 11:38:57 -0400
Date:   Wed, 6 Nov 2019 11:38:57 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     michal.kalderon@marvell.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/qedr: Add doorbell overflow recovery support
Message-ID: <20191106153857.GB15851@ziepe.ca>
References: <20191106075259.GA22565@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106075259.GA22565@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 06, 2019 at 10:52:59AM +0300, Dan Carpenter wrote:
> Hello Michal Kalderon,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 9bcc6597f47b: "RDMA/qedr: Add doorbell overflow recovery 
> support" from Oct 30, 2019, leads to the following Smatch complaint:
> 
>     drivers/infiniband/hw/qedr/verbs.c:1046 qedr_create_cq()
>     warn: variable dereferenced before check 'ctx' (see line 970)
> 
> drivers/infiniband/hw/qedr/verbs.c
>    905  int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>    906                     struct ib_udata *udata)
>    907  {
>    908          struct ib_device *ibdev = ibcq->device;
>    909          struct qedr_ucontext *ctx = rdma_udata_to_drv_context(
>                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    910                  udata, struct qedr_ucontext, ibucontext);
>    911          struct qed_rdma_destroy_cq_out_params destroy_oparams;
>    912          struct qed_rdma_destroy_cq_in_params destroy_iparams;
>    913          struct qedr_dev *dev = get_qedr_dev(ibdev);
>    914          struct qed_rdma_create_cq_in_params params;
>    915          struct qedr_create_cq_ureq ureq = {};
>    916          int vector = attr->comp_vector;
>    917          int entries = attr->cqe;
>    918          struct qedr_cq *cq = get_qedr_cq(ibcq);
>    919          int chain_entries;
>    920          u32 db_offset;
>    921          int page_cnt;
>    922          u64 pbl_ptr;
>    923          u16 icid;
>    924          int rc;
>    925  
>    926          DP_DEBUG(dev, QEDR_MSG_INIT,
>    927                   "create_cq: called from %s. entries=%d, vector=%d\n",
>    928                   udata ? "User Lib" : "Kernel", entries, vector);
>    929  
>    930          if (entries > QEDR_MAX_CQES) {
>    931                  DP_ERR(dev,
>    932                         "create cq: the number of entries %d is too high. Must be equal or below %d.\n",
>    933                         entries, QEDR_MAX_CQES);
>    934                  return -EINVAL;
>    935          }
>    936  
>    937          chain_entries = qedr_align_cq_entries(entries);
>    938          chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
>    939  
>    940          /* calc db offset. user will add DPI base, kernel will add db addr */
>    941          db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
>    942  
>    943          if (udata) {
>    944                  if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
>    945                                                           udata->inlen))) {
>    946                          DP_ERR(dev,
>    947                                 "create cq: problem copying data from user space\n");
>    948                          goto err0;
>    949                  }
>    950  
>    951                  if (!ureq.len) {
>    952                          DP_ERR(dev,
>    953                                 "create cq: cannot create a cq with 0 entries\n");
>    954                          goto err0;
>    955                  }
>    956  
>    957                  cq->cq_type = QEDR_CQ_TYPE_USER;
>    958  
>    959                  rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
>    960                                            ureq.len, true,
>    961                                            IB_ACCESS_LOCAL_WRITE,
>    962                                            1, 1);
>    963                  if (rc)
>    964                          goto err0;
>    965  
>    966                  pbl_ptr = cq->q.pbl_tbl->pa;
>    967                  page_cnt = cq->q.pbl_info.num_pbes;
>    968  
>    969			cq->ibcq.cqe = chain_entries;
>    970			cq->q.db_addr = ctx->dpi_addr + db_offset;
>                                         ^^^^^^^^^^^^^
> New unchecked dereference.

For rdma_udata_to_drv_context(), udata != NULL implies ctx != NULL

Generally I prefer to see the rdma_udata_to_drv_context() as a local
variable inside an 'if (udata)' but this is one of those places where
that doesn't work out.

Jason
