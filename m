Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F31AA97A
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636452AbgDOOJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 10:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634083AbgDOOJO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 10:09:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264E3C061A0E
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:09:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o19so9969983qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8l3fJ3svvSnnpPWSwQODVx9E9WXp25t5EtCooxlqAaI=;
        b=hyvfWRgZ8ds04OSvqKNyo/oyMGZudplvEgKzicRUdSRA7vp3TtY92WjQnivcZ2zlVx
         YGsqo2pSYCsL5gyfWH8KskcNoRlysYM+kZ0YMhf7DLoAEcWPb/meAwW+z9VwJ2o/zAKQ
         Mf+CeCVpXGS0CxgIfgYWqEVHzRfJuIxFifI0IN17pIpclN6zHTtbdISuE1qxEgPYEinv
         zriEbOBxBnvwhV/nxT6zLUvApM7+qCMNvIP3vvk6tOHIAUhKGQ7aOSziauK59XBka8Yb
         9q5QkXsZZ8JueNWbHr7Un1tx9r6Rd7XMa3nsavZAziqQL6icouVnhboeNjAADXfnuT7U
         u74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8l3fJ3svvSnnpPWSwQODVx9E9WXp25t5EtCooxlqAaI=;
        b=X+rY8AnXXPZL7gpIk2hiAYnzBQUNPGdmrhvJh7GsdeDcnC2DhMj9q4AowuAs3XGnwX
         eaGyjDAkT+4ou5ZL/B5QOSnHudV45BBcHAwi7s7ydVf7wpXdhOTaVubt69Dcr44zrJfj
         p/Xtk5Jb+j+JDBI9TsSNsgHavAMKgQ0KGDKYppqNvKVnlU2lxjORmhj9+6NtwRYI8peg
         +2UZS8yf2Sn0LEefdwZ9nXtuk+N2PqqOAY4Ox1ldBkrcR8LQz+fd/vbzhS4otPXuczlj
         JknIXBjlVhN7myRnQ49ZSNI32nnSomkcnzYKnoeISnn4VY2jTcjBYFtrQkiEezmUI/IC
         a06Q==
X-Gm-Message-State: AGi0PuaSNYyxGA3fKEuueCOV4lzctgkTxPLR8pEM6suslvdrlIC75Y1i
        y2cgKpBKO32g/UIQUupgUDcFBfdAo9X41g==
X-Google-Smtp-Source: APiQypLbb8LS8qXo73NMCiWFh1QIqqzNTocUAzDQFGF4qT8gB1BW0a9iIzLUAA/BXDJ9RXfzbpXISA==
X-Received: by 2002:a05:620a:5fc:: with SMTP id z28mr27186371qkg.346.1586959752226;
        Wed, 15 Apr 2020 07:09:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o94sm13137882qtd.34.2020.04.15.07.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 07:09:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOij0-0005Px-OF; Wed, 15 Apr 2020 11:09:10 -0300
Date:   Wed, 15 Apr 2020 11:09:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn,
        kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] RDMA/siw: Fix potential siw_mem refcnt leak in
 nr_add_node
Message-ID: <20200415140910.GN5100@ziepe.ca>
References: <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586939949-69856-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 15, 2020 at 04:39:08PM +0800, Xiyu Yang wrote:
> siw_fastreg_mr() invokes siw_mem_id2obj(), which returns a local
> reference of the siw_mem object to "mem" with increased refcnt.
> When siw_fastreg_mr() returns, "mem" becomes invalid, so the refcount
> should be decreased to keep refcount balanced.
> 
> The issue happens in one error path of siw_fastreg_mr(). When "base_mr"
> equals to NULL but "mem" is not NULL, the function forgets to decrease
> the refcnt increased by siw_mem_id2obj() and causes a refcnt leak.
> 
> Fix this issue by calling siw_mem_put() on this error path when mem is
> not NULL.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
> index ae92c8080967..86044a44b83b 100644
> +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> @@ -926,6 +926,8 @@ static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
>  	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
>  
>  	if (unlikely(!mem || !base_mr)) {
> +		if (mem)
> +			siw_mem_put(mem);
>  		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
>  		return -EINVAL;
>  	}

I think I prefer this version, which is what I'll use if nobody has concerns:

diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c b/drivers/infiniband/sw/siw/siw_qp_tx.c
index ae92c8080967c5..0580bbf535ceb7 100644
--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
@@ -920,20 +920,28 @@ static int siw_fastreg_mr(struct ib_pd *pd, struct siw_sqe *sqe)
 {
 	struct ib_mr *base_mr = (struct ib_mr *)(uintptr_t)sqe->base_mr;
 	struct siw_device *sdev = to_siw_dev(pd->device);
-	struct siw_mem *mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
+	struct siw_mem *mem;
 	int rv = 0;
 
 	siw_dbg_pd(pd, "STag 0x%08x\n", sqe->rkey);
 
-	if (unlikely(!mem || !base_mr)) {
+	if (unlikely(!base_mr)) {
 		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
 		return -EINVAL;
 	}
+
 	if (unlikely(base_mr->rkey >> 8 != sqe->rkey  >> 8)) {
 		pr_warn("siw: fastreg: STag 0x%08x: bad MR\n", sqe->rkey);
+		return -EINVAL;
+	}
+
+	mem = siw_mem_id2obj(sdev, sqe->rkey  >> 8);
+	if (unlikely(!mem)) {
+		pr_warn("siw: fastreg: STag 0x%08x unknown\n", sqe->rkey);
 		rv = -EINVAL;
 		goto out;
 	}
+
 	if (unlikely(mem->pd != pd)) {
 		pr_warn("siw: fastreg: PD mismatch\n");
 		rv = -EINVAL;
