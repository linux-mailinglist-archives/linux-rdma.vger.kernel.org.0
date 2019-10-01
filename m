Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02853C3664
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbfJANyc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 09:54:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38903 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJANyc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 09:54:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so21692063qta.5
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BlIRQGk1pr2xNfAlAuq52KNMvxNuXtY13udgYZxJPDQ=;
        b=XE4xuttdIhnl4u6Y/iBs62HmAUIyp5ru9LZU1lct2oxegtgkMkl71CeYp9Ma5bEC2g
         DMBhfJn99zfMBlmu31T9t1c6CFyP4qfaVYJUlZgeV9bhdcqH9Gz3kVBEZJgsHyAJD24I
         WKsLDhrE4ZRFwx+pDoBDPSdkUztqcxv+h3341Gp5A1eB2dBGBAG9HwcRNGRGodIlIwR+
         GHengGUZ5yaQU0PZoDZZzqUT6BXyKgLP4ghrI30HwLRGgG6Bm6cOqdHwBZ4TyJfJo/X8
         1MXdNeNrnn3nH4w3QbUgdlzppJMJJzUZn15H/DRLa186a7ow9mjrmYBtn9E2lmQMpYu5
         ZOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlIRQGk1pr2xNfAlAuq52KNMvxNuXtY13udgYZxJPDQ=;
        b=HHwSl2+UemI3klwQiI97lcF58gEQIyWn69i2uLE8VXo3GC0LaiIjxKi6Av1l9IpHoa
         jgP0uWYTTtdmsMDkFbcBuImy0bxsH4E4QvUkFjjiX9/jQ5YuHz71MdifksYe1ezIKdmg
         N27iYtMzqroFgavEYyt4hTUcQ8W4f3Lu6dGNXB4jWcpE5RqL2EG8WWswz21viUG58tzb
         lC4d5/zjW4eHWolIKZjNG0J6lEZgLHhXkdFYfOA+09Y8kN0KMphC3ZGn51gV6wqx85Gk
         MakwYORSAIPrgnFgPXb1HJ+sKImuU5gWzhiRSPDoQNde7rpS+3zNELSHZpYjnN43TtnO
         weQw==
X-Gm-Message-State: APjAAAX7IM2ChRiEW/xa/QwDfZMjWLAwtJxofAfLVYW7g7Aidbg78zAA
        NbEE8Kir6iT7A0SYFo+TUIOZRg==
X-Google-Smtp-Source: APXvYqzcSPa2CE4T3TD0U+DLWNizMhHBjoacjTw0iHRjOVAb0codaIbWWfjADA/A776+fzV4c/ZGMg==
X-Received: by 2002:aed:2726:: with SMTP id n35mr29910659qtd.171.1569938071033;
        Tue, 01 Oct 2019 06:54:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c41sm13595334qte.8.2019.10.01.06.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 06:54:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFIbm-00073R-5P; Tue, 01 Oct 2019 10:54:30 -0300
Date:   Tue, 1 Oct 2019 10:54:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     leon@kernel.org, emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA: release allocated skb
Message-ID: <20191001135430.GA27086@ziepe.ca>
References: <20190923050823.GL14368@unreal>
 <20190923155300.20407-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923155300.20407-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 10:52:59AM -0500, Navid Emamdoost wrote:
> In create_cq, the allocated skb buffer needs to be released on error
> path.
> Moved the kfree_skb(skb) under err4 label.

This didn't move anything
 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>  drivers/infiniband/hw/cxgb4/cq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
> index b1bb61c65f4f..1886c1af10bc 100644
> +++ b/drivers/infiniband/hw/cxgb4/cq.c
> @@ -173,6 +173,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
>  err4:
>  	dma_free_coherent(&rdev->lldi.pdev->dev, cq->memsize, cq->queue,
>  			  dma_unmap_addr(cq, mapping));
> +	kfree_skb(skb);
>  err3:
>  	kfree(cq->sw_queue);
>  err2:

This looks wrong to me:

int c4iw_ofld_send(struct c4iw_rdev *rdev, struct sk_buff *skb)
{
	int	error = 0;

	if (c4iw_fatal_error(rdev)) {
		kfree_skb(skb);
		pr_err("%s - device in error state - dropping\n", __func__);
		return -EIO;
	}
	error = cxgb4_ofld_send(rdev->lldi.ports[0], skb);
	if (error < 0)
		kfree_skb(skb);
	return error < 0 ? error : 0;
}

Jason
