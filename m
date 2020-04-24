Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F33F1B7DE2
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXSa7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXSa7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 14:30:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08045C09B049
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:30:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 20so11157063qkl.10
        for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2020 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqCHWwhSDHX5zfBjUeg9vybWKAEuvU5XiAKpnxIJ7dI=;
        b=oDxMBsR4Ay1Geaph5rrO5Sg88g+aQunPRwgt5qQ6cRhp7Dv84S9obdFZX3GGpCKkXY
         gsx2zPTOHo6q8FCviTXm/Kqo21eXQe9YqImT6zzm8+K5fISEZjz13TRr04VzHiyiBvHI
         neUOfrR6mZ3FeTyXy8N/GVY+zE1a5vJh+c7XVcgDYMnRmSfi5TmFzbGQ3L+kxXJN1t1m
         hUmwYTUzt00ozn4r6mJ+JXUC4PoCR1mtVw1trZbgHMmg8POwvtrM+8BSYLlnB9exBnop
         HXV4je/VVWmRJU0lFq9PrHgblJfypjJemr1TmBIN5kf2q2sMY4++PDSy89GSZE9vsLSJ
         KE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqCHWwhSDHX5zfBjUeg9vybWKAEuvU5XiAKpnxIJ7dI=;
        b=T1HtT9ZbEk8TqWTimmkz/VEIdOvPXXtI891tG12nwS5pLXwKLGaN8oeR76cG38Abps
         pa3uGYtAiZgcho0VwjgTm3uOIi1g4lYo67+wNHSRsGykMX1FaJTItQtK4EFs0eIiDNIa
         eCwbi9jZyC6H08XbxHCOSKfChcp6q/Dqsk5+uUEltU1A8EqoJH3fuiCW3i7ZeoEUEn2i
         CijdgxgLKJ3PkxpZ2aK73lrWiGwQpcNSEByQrFWEVK1ZoWtYHDLstA0polaseNFyItQj
         RYu2I3H4WdYCRIjxcb1E4W4LVz1I9KKHmgVBlUX4LL0emLA3W2jnBmYh64VVHpT4P3iH
         OSiA==
X-Gm-Message-State: AGi0PuaWEU+6V5XnT5QPeuSJVuihtLGAvebpS1Bem1cZRWdgTTIA4IP9
        UwjF2ntrY2JBfTOJXQ6fj+mtvA==
X-Google-Smtp-Source: APiQypIJEBo60zbGiJf+lB4Wlibq08c9iXWx6zRWF+Q2YMAmJ+SPJboBwzPT162TV6N9+bsoaIPgew==
X-Received: by 2002:a37:9c0c:: with SMTP id f12mr10361275qke.347.1587753058208;
        Fri, 24 Apr 2020 11:30:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id y9sm4297975qkb.41.2020.04.24.11.30.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 11:30:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jS36G-0004fV-TI; Fri, 24 Apr 2020 15:30:56 -0300
Date:   Fri, 24 Apr 2020 15:30:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: check for error
Message-ID: <20200424183056.GA17877@ziepe.ca>
References: <20200423104813.20484-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423104813.20484-1-sudipm.mukherjee@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 23, 2020 at 11:48:13AM +0100, Sudip Mukherjee wrote:
> rxe_create_mmap_info() returns either NULL or an error value in ERR_PTR
> and we only checked for NULL after return. We should be using
> IS_ERR_OR_NULL to check for both.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
>  drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index ff92704de32f..ef438ce4fcfa 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -45,7 +45,7 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
>  
>  	if (outbuf) {
>  		ip = rxe_create_mmap_info(rxe, buf_size, udata, buf);
> -		if (!ip)
> +		if (IS_ERR_OR_NULL(ip))
>  			goto err1;

Same comment as for the rvt patch - do not use IS_ERR_OR_NULL. If a
function uses the ERR_PTR stuff then it should not return NULL. Fix
rxe_create_mmap_info and check all call sites

Jason
