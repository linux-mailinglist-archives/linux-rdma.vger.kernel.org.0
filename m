Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148BF1E10F7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbgEYOuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 10:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390960AbgEYOuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 10:50:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC5C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:50:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so13881534qts.9
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XrApQCjmBDPCseqGGtk2ziQJpJBh+aMj0VjM0uXHtwI=;
        b=HEcMbJwnlkQrmUaq+dg9jfURv4C7HfjGM4eBY3RKUD3xj27Ih6i5roW+6LOHHSR4jj
         N3wsHW9VhR0kmfJA6cVOJcfjQ0av6btHjb1hS4ZBVhCvJyBQE33F00Wk5PS33Q+LIskf
         y069kRdTlrP7HA9BjIu8+QNEj8vzF67wad4jWdvXprO645udmh9YzPLp6q5EkUp6ast1
         GRiSbkMg4T36EZ/0hOreZLQ6FXje2kfNJjRr5PpdORJMrOthmDDOGHxcc/j8im06hbr/
         JeD1P+Oa5mgXLJH0Mc6h8zE1wrCfVmyC7UimSvFIMrY1T0n382a3tzMurgLln1fb7ylu
         uj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XrApQCjmBDPCseqGGtk2ziQJpJBh+aMj0VjM0uXHtwI=;
        b=Nzxq46Q06bEANOdquSXqngjHlUc8TehpMHgnMqQXDieaitrybBrXAWM4CmUmDux+dP
         CgCUn4FO/JuZ19oy0htrWLHqsrCl0JZTz+0vnvduNN6+Sm3KkINWWsvZ5uxLibG3jFem
         SyKNktQIwYiizJEIAnMVwesCBzsXPKiXZVs5fk8LoMNHY2g4cdN5l3paSf7AXnxl+TJd
         Fc5uLKNznReYwFDgsMVvnIvY8b0LpBjxfoXtXLLxBA2ty4AkeA+geToeyEQEOD3q+7U5
         9AKzEiDq0lUjyMHHhAvrE5opgaF5TsHykpk8fFHjMGVCah3CNHCxyRpFH8LPZ6totCmM
         7/aQ==
X-Gm-Message-State: AOAM530o3Ik6tgoPF36Bf5ZlpWAdlLbbtP325KhYNr6D7N9lHqMVGtLX
        1MQ6mjWLUMOTHvm2+WJ+DPZrlg==
X-Google-Smtp-Source: ABdhPJwsKoF/s/dtu14D6p8zLrz0fIFJoQSf/Y2992cYVJ1IA6D9OjNJwug1sPaVypOnxjOdR8AdKQ==
X-Received: by 2002:aed:2d02:: with SMTP id h2mr26864129qtd.83.1590418202724;
        Mon, 25 May 2020 07:50:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a16sm13782194qko.92.2020.05.25.07.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 07:50:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdEQT-0005y8-RP; Mon, 25 May 2020 11:50:01 -0300
Date:   Mon, 25 May 2020 11:50:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 14/14] RDMA/mlx5: Add support to get MR
 resource in RAW format
Message-ID: <20200525145001.GA22893@ziepe.ca>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-15-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095034.208385-15-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:50:34PM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@mellanox.com>
> 
> Add support to get MR (mkey) resource dump in RAW format.
> 
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/hw/mlx5/restrack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
> index 9e1389b8dd9f..834886536127 100644
> +++ b/drivers/infiniband/hw/mlx5/restrack.c
> @@ -116,7 +116,8 @@ int mlx5_ib_fill_res_mr_entry(struct sk_buff *msg,
>  	struct nlattr *table_attr;
>  
>  	if (raw)
> -		return -EOPNOTSUPP;

Does it make sense if raw is requested only raw is returned?

That whole thing doesn't sound very netlinky to me..

Jason
