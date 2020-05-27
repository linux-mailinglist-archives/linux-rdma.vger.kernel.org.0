Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B064F1E42B5
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 14:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbgE0MxF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgE0MxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 08:53:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E130C08C5C1
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 05:53:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q8so7689842qkm.12
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZ5Hkc9BmdHfwmqI50h3z3C9tvO8+AykjGQNp/6/YXI=;
        b=fb7hl+KSCixSZhMp/AAy4KHgUQJPrSfBM75cHjA1TARkbDIEl+tWHdtu6FF9bK66cf
         2dcmAwAKv7y2BWm31zvq3N/ZKg+TmKBWYfiMG3CeCEYSODU09cHcMIhFSNve+9mxvNJJ
         PVb5GgQ8sC4+gX/ObtHWhE+LN1UNwWaIfr8aPMfERqkpF2Y+GHBWjb19AC4olkFvRM5I
         FEjtMsX8j++dTYmStE9D+9ggAdkXGuPpFRWDsYLA+KGKqM752PRAyFaE+g+DE4QJ/Y5+
         EYBRRjyZx4PFaAdssZeoYxQ3SqAFPUzK7rRrHMWdS3eABJqSLz1Go+TwbXmR8/AZhl14
         nFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZ5Hkc9BmdHfwmqI50h3z3C9tvO8+AykjGQNp/6/YXI=;
        b=pra6zx1t5oZp21e+ccLE1xl9fpNYH2aZE8bvOdkbeTuXytBwnLMbYPKjEnY7uvQqn1
         h8wU7oQsh0j6UULg2jYHKMogbnEEcUt1wqy0sO/h8xQv5ebMgvLj4LaR5FXFy27ibuRE
         TJCpX5DJqIe36o1NaqJRh3RafpStEKBALgxf56kI56g+z4OtxO899mivx3g7VqfitBQm
         tQDpDj24AA8MK2h4SJDkjP8tQbygPCu2Outs1kDdwJ10mVjQAPN2g/UifZaq55C+dJqA
         A4myreIyt5cnEbOR3SWxcj9uO7DulPhAaZuJj0Fhx3MwSsp75H67Qdzza0wS7fpqcDu2
         YVwA==
X-Gm-Message-State: AOAM532IXGmgFFjOXBmy9J6bUTUSXPOTxh9cUs4bueKo/N33QyogSv2C
        zbogBatcogk9wSSYKZ6C+ntulg==
X-Google-Smtp-Source: ABdhPJzB9RCyVNOjfVH13WoUmdCEqinHqneT2GSgz7laQg6V0aSRwkpc7K1WRnZoSvlrQuFa1k2uMQ==
X-Received: by 2002:a05:620a:2287:: with SMTP id o7mr3734702qkh.238.1590583982551;
        Wed, 27 May 2020 05:53:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y129sm2192230qkc.1.2020.05.27.05.53.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 05:53:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdvYL-0001kW-F9; Wed, 27 May 2020 09:53:01 -0300
Date:   Wed, 27 May 2020 09:53:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, "Leybovich, Yossi" <sleybo@amazon.com>
Subject: Re: Issue in "Introduce create/destroy QP commands over ioctl"?
Message-ID: <20200527125301.GP744@ziepe.ca>
References: <948a84a4-a8f7-5554-111a-4b191ed0344b@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948a84a4-a8f7-5554-111a-4b191ed0344b@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 03:34:33PM +0300, Gal Pressman wrote:
> Hi,
> 
> The recent transition of create/destroy QP commands to ioctl broke the EFA
> provider in [1].
> With the new ioctl the 'ibv_resp' part of the response is all zero'd, opposed to
> the write method.

It is a bug in the efa provider. It is not allowed to touch the
'ibv_resp' parts of the structure from a provider.

Something like this

diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
index 5f8e7b800210bb..92bb7432a92a2b 100644
--- a/providers/efa/verbs.c
+++ b/providers/efa/verbs.c
@@ -541,7 +541,9 @@ static void efa_sq_terminate(struct efa_qp *qp)
 	efa_wq_terminate(&qp->sq.wq);
 }
 
-static int efa_sq_initialize(struct efa_qp *qp, struct efa_create_qp_resp *resp)
+static int efa_sq_initialize(struct efa_qp *qp,
+			     const struct ibv_qp_init_attr_ex *attr,
+			     struct efa_create_qp_resp *resp)
 {
 	struct efa_dev *dev = to_efa_dev(qp->verbs_qp.qp.context->device);
 	size_t desc_ring_size;
@@ -559,7 +561,7 @@ static int efa_sq_initialize(struct efa_qp *qp, struct efa_create_qp_resp *resp)
 	desc_ring_size = qp->sq.wq.wqe_cnt * sizeof(struct efa_io_tx_wqe);
 	qp->sq.desc_ring_mmap_size = align(desc_ring_size + qp->sq.desc_offset,
 					   qp->page_size);
-	qp->sq.max_inline_data = resp->ibv_resp.max_inline_data;
+	qp->sq.max_inline_data = attr->cap.max_inline_data;
 
 	qp->sq.local_queue = malloc(desc_ring_size);
 	if (!qp->sq.local_queue) {
@@ -840,7 +842,7 @@ static struct ibv_qp *create_qp(struct ibv_context *ibvctx,
 	if (err)
 		goto err_destroy_qp;
 
-	err = efa_sq_initialize(qp, &resp);
+	err = efa_sq_initialize(qp, attr, &resp);
 	if (err)
 		goto err_terminate_rq;
 
