Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302D53960B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfFGTmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 15:42:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46714 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfFGTmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 15:42:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so3618218qtn.13
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 12:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9WlNvlIn4Yu4cKL76GlL2n3cIGFb3fLAppC++UjZiGo=;
        b=OO6pQORKbrWxji9jhleGXtAZhUXSkehfdQlqM2JTYAPNxlK2E010g1wyHb49YIglcI
         bvBad2Mxnyn6o1FHH6a43uSmy0Ha/ddhntVm/xA7TZZLdV5rwOcVQMjPrTZUe85feOZW
         /gtWw1cbqGPkBzc2cbKzaji7P+k56UoIXlum2RoK8xcxZWC9jBAtiTkJqf1eW5chLDSe
         tqSaEK9ZKOpd5lA92dL7V+PIim/4+lc7KxbHtAshnc4mrDZ1Owd1KGDzZ2CyqIX/+X5M
         wKxuIGn+Nv1GVxGifDQxKeyPnZxfWiELvAzitkVTPhOqSMh2Rsw8bsPzvNoDzyaNMmh6
         l8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9WlNvlIn4Yu4cKL76GlL2n3cIGFb3fLAppC++UjZiGo=;
        b=pDxT6mzKCcMbH/V7yZKQg2ykkBeCOpBn/Xvi542mVP/cnfIvVa1vW0YmSls3n3VorN
         aLmgnSouc5HC992eGtn8QlhqSJETli3V9LRoRIZGMH7XpwC6V9MTqIyL1baU497ng6uA
         WHAShOFscOb37Jp7ck9gzZ1j63zi3gSELa8IkY5GVggnQ9wkQtdCYLDZ+koLDaPSuveO
         1jPBOm6TZVDR9VQzIdhXO2U3+zQgTS5N2SeE1Rq7JxOVvG/0yeHywBOlz+4sVdpA95Rw
         EKuFDsS937BMRif0u+epm7Jht1OpRnZIV8uYK2IBfdllyVxEb5pZaEXNRNs+kh5uQy90
         sWZA==
X-Gm-Message-State: APjAAAXM/R6aVIR4snabQ2/el35h4+i8dIUY6UBgRN9n+RoPt+nepNMJ
        lgehUPfBPKuf+uY+g60+aBsARA==
X-Google-Smtp-Source: APXvYqw6vrpwcsz8N88q53i2g8cjP5FctRWJKnNBUIR52owJAkY7FFvb/yQdMoczc1yc1VS+v+vxGQ==
X-Received: by 2002:a0c:afa2:: with SMTP id s31mr45288457qvc.186.1559936536026;
        Fri, 07 Jun 2019 12:42:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g184sm1552273qkf.45.2019.06.07.12.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 12:42:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZKkh-0006KN-4q; Fri, 07 Jun 2019 16:42:15 -0300
Date:   Fri, 7 Jun 2019 16:42:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 29/32] ucma: Convert multicast_idr to XArray
Message-ID: <20190607194215.GA24288@ziepe.ca>
References: <20190221002107.22625-1-willy@infradead.org>
 <20190221002107.22625-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221002107.22625-30-willy@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 20, 2019 at 04:21:04PM -0800, Matthew Wilcox wrote:
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> ---
>  drivers/infiniband/core/ucma.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)

Applied to for-next, but I added these two hunks:

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -104,7 +104,7 @@ struct ucma_context {
 
 struct ucma_multicast {
        struct ucma_context     *ctx;
-       int                     id;
+       u32                     id;
        int                     events_reported;
 
        u64                     uid;
@@ -234,10 +234,10 @@ static struct ucma_multicast* ucma_alloc_multicast(struct ucma_context *ctx)
        if (!mc)
                return NULL;
 
+       mc->ctx = ctx;
        if (xa_alloc(&multicast_table, &mc->id, NULL, xa_limit_32b, GFP_KERNEL))
                goto error;
 
-       mc->ctx = ctx;
        list_add_tail(&mc->list, &ctx->mc_list);
        return mc;

Thanks,
Jason
