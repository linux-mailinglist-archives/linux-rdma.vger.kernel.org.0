Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2C50BD84
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Apr 2022 18:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449854AbiDVQwM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449836AbiDVQwL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 12:52:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD16D5F8D3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 09:49:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id hh4so5890425qtb.10
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 09:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4YMzXqCtJOmW7ZMrgUTPPMhbH/Ycg5fw/d8JD4mp3A=;
        b=BiYMih/T0LciSr5fejE2O5KBZasfvYSEZRxnWvabriuJQzjJxVhO6Nwwuwmo41S3KP
         97StoBreGeuIzhWGvJuJAuNDAjxYRDQ+dVhbyO4sZjWJYLRBckuC2yqiyGKMrMzugrK/
         aCjBr/K9a+QD/54inORiBaNfTBl2CVTsDrB9uHLcGnoVW7oFn+Cv7HBcDWjQS6UXKbrW
         FwHzSTqOad7qPSeeOAvlPdeKhuv2JhU6R/Vj6udLo/espYQ82GJiXtL0ifgIVvdkEryt
         rRCQvN0BrxlIia1hqrJpfN7qMD/J2P3FVqm1rtTBepd3xKwHzNzoSYBxCY635JaFfPJ4
         Uk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4YMzXqCtJOmW7ZMrgUTPPMhbH/Ycg5fw/d8JD4mp3A=;
        b=hGxoJYk2twUzlwyH/gpxQKt2+HaySymxbLzseLd5APtOPUNaYgdU6zlMyBNL6adMhb
         pvvvzbQLlwVT1blC58uJF4I9mIlKqaQh7iDLywWCYAzN9oBp8z7jUmw1E23sxupYNyGg
         Swh1pMUqhQJymOPKL2vX7Wb4URg8ggJHXG/DcfT4ku9eIpY3J4YRDqJkGcsoE+8uu/ga
         LgmRX6d6MtgsIUVAMxh7J+zsBXvzw4KlF3VKk5p69m9jx+mX5L5+O93tGR2Xm4yvs40G
         0J7fgdqjDj/uTLJIyn+gXK/EI6KvQ15aaPslJSxYzKe48KmTU9hXyIHsbboiVfetK+3z
         StGw==
X-Gm-Message-State: AOAM533VMPnV93Zm2dzQ2sxeoCQPbE/WKwMrBu1iXT5GM3WSXx5ALXfT
        e5rxMlcsWJQ1srQFnqKvwQXfjPBsEcW6QA==
X-Google-Smtp-Source: ABdhPJyj5UlJT307L5Ao3E7ph/NJvZXD9kzTE02F5xTr+ob7VRnS236RbdJia8vqdfgBsvk4iuJd5w==
X-Received: by 2002:a05:622a:2c6:b0:2f3:591e:68ac with SMTP id a6-20020a05622a02c600b002f3591e68acmr2524641qtx.17.1650646156821;
        Fri, 22 Apr 2022 09:49:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f11-20020a05622a1a0b00b002f1f3b66bd4sm1455764qtb.94.2022.04.22.09.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:49:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nhwT5-008Fbr-7h; Fri, 22 Apr 2022 13:49:15 -0300
Date:   Fri, 22 Apr 2022 13:49:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/4] RDMA/rxe: Check RDMA_CREATE_AH_SLEEPABLE in creating
 AH
Message-ID: <20220422164915.GV64706@ziepe.ca>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <20220422194416.983549-4-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422194416.983549-4-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 22, 2022 at 03:44:16PM -0400, yanjun.zhu@linux.dev wrote:
> @@ -166,16 +166,18 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  	elem->obj = (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
>  
> -	if (pool->type == RXE_TYPE_AH) {
> +	if ((pool->type == RXE_TYPE_AH) && (gfp & GFP_ATOMIC)) {
>  		unsigned long flags;

No test for AH should be here, just gfp.

Jason
