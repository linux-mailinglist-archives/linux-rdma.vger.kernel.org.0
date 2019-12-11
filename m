Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92311B8B9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfLKQ05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 11:26:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46351 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfLKQ04 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 11:26:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id g18so322419otj.13
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2019 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z6zdU/xrkKE1DcOraB+HKtpGPsk3EYPT+vSqo90xQK8=;
        b=CaW8ujBXnOth7gzj1/yTbWXBB0zw/xzfLeR+oez1pY6varRdlaJda+WLsMdpouROKO
         rHf5xGhjp0BQxAAxsK+Qz53wPMUkC8ixRAf9epqgy0o1d5yuk8aF8ZfWVDQMA6lCvisk
         k7IpYRD57FfHHzRhbKGGZT3thtXY9Sr5E1FnNW9Xx62TK0MB2XqENh93qMRbHHrFno2i
         k/BgUy24YVt+8MmsveGZlpU/SgGTIVhL+/5IVp6EWoH+yzARD8aITWpcJdaet/wZQlY/
         PtwERhu+kS18Efh2dzwQy0lN/gF3AkkoHiT6UeqNPfs0XiGoiRKosmagKRP1ElvnXYUo
         fPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6zdU/xrkKE1DcOraB+HKtpGPsk3EYPT+vSqo90xQK8=;
        b=MDcpNt/I/x3hK3cs3KQ1S2C6bUQA9tiJQiSVl8E+NOZ/mxHTms/t2D6mOFJJdysB8I
         cAAahoBjxt+TgrA60Cs12m7UBU/lnwzQP5h3nrjaC8ycc0j+oWT4XWwfd24r9mCnfgcO
         BgrUMqHjM4OfiChYtXM7NeFUJnuCKCNifbxHV+Qv3GUBjPGl+Chjy/N2irGc3LM7aD3P
         FSeJQbk5FdRSwuwCBJ3/rSwIMeo7nGW8QfwusNAV0Nr7DdJwguRxJ6tEP4sD953sWN/O
         Ws7ZS1K7CrRq7GFfPo7ehwsrTbhgXWCtQ0N8FQiA4Qx7CqsxhBYd7O9jLC1k4GdZeYgT
         zxwQ==
X-Gm-Message-State: APjAAAVXAiB+A7jxnFSLo3Yz/vrgqcwj5V+fJqNxyjkj7yLvBh7jdfLp
        kO0wAgj0BT6eLF+f/NtfAq+QieQ/6Jk=
X-Google-Smtp-Source: APXvYqzDPcIfKmYiNqIZudbnrsEtajQSOgxKei4/X6mu9+jpsjBeyvf0gsPeDXOQteLqPsfBJeHOUw==
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr2974798otb.85.1576081615921;
        Wed, 11 Dec 2019 08:26:55 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id t71sm949802oif.45.2019.12.11.08.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 08:26:55 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1if4pC-0001vW-Tt; Wed, 11 Dec 2019 12:26:54 -0400
Date:   Wed, 11 Dec 2019 12:26:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Hirsch <max.hirsch@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Danit Goldberg <danitg@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dag Moxnes <dag.moxnes@oracle.com>,
        Myungho Jung <mhjungk@gmail.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Fix checkpatch error
Message-ID: <20191211162654.GD6622@ziepe.ca>
References: <20191211111628.2955-1-max.hirsch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211111628.2955-1-max.hirsch@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 11:16:26AM +0000, Max Hirsch wrote:
> When running checkpatch on cma.c the following error was found:

I think checkpatch will complain about your patch, did you run it?

> ERROR: do not use assignment in if condition
> #413: FILE: drivers/infiniband/tmp.c:413:
> +	if ((ret = (id_priv->state == comp)))
> 
> This patch moves the assignment of ret to the previous line. The if statement then checks the value of ret assigned on the previous line. The assigned value of ret is not changed. Testing involved recompiling and loading the kernel. After the changes checkpatch does not report this the error in cma.c.
> 
> Signed-off-by: Max Hirsch <max.hirsch@gmail.com>
>  drivers/infiniband/core/cma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 25f2b70fd8ef..bdb7a8493517 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -410,7 +410,8 @@ static int cma_comp_exch(struct rdma_id_private *id_priv,
>  	int ret;
>  
>  	spin_lock_irqsave(&id_priv->lock, flags);
> -	if ((ret = (id_priv->state == comp)))
> +	ret = (id_priv->state == comp);

Brackets are not needed

Ret and the return result should be changed to a bool

Jason
