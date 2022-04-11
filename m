Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1254FBB55
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiDKLwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 07:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbiDKLwf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 07:52:35 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461A45AD8
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 04:50:21 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z14so1831873qto.5
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYKlpbInSVi2kWjadcO+xwlKXyAqxDdBQNrxNvWjuVU=;
        b=Hx94opGZFvJS4PSHhQFprTvwYfvoh3pFGcECifD9kOhnQVfGZJu1X4ZeZbCAc4yCB1
         S9b7nSzC9fgbeC9V23xRQVY+iiCZK8a4UJ8kBSzP6j+69zX9OH+MBzosaKiwlBhd9hPO
         TNgQPZ26NKkBfYYO3VK1hY22AxgahsXkBZQxj0tgcNErzwfImBHJ21ry7WEP0FyPe4dk
         f4E4E9jti0Jr+jJj69mXLrDZcAeCUmPU1Qe2HVpEBHhSp22KoV/sJFOncfIPS0Wlf4Sf
         wNcneO9B4xkd/xdC1wd3eYUyY21oHuo/DBsOhk6IrP/ubUeaSvRb2alqBgWnKS6eDRoF
         THxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYKlpbInSVi2kWjadcO+xwlKXyAqxDdBQNrxNvWjuVU=;
        b=d2b4R0tihhmsGEka3706Kz1w20I/VzXXMeE304fCvHp6npUQK8SdRKo8g0tuuCzu3k
         azuLowsBTvEkbQj3jcWODPWHmhDsAcBaXFVI95cEAKJFGROzgsGSHp35tbv7LHO808h+
         8DnoAsNrJBCFnn34vMx5o+AW75kq8s0uLtZltMs0ISoo2VaMW2viSt3kiuul4/oikOn0
         rb2MIQrUoEJxjlCzbdz1CjWhGHL4p4GbWrBOpMf37yX8jVWaRtVWS2oU5Jcj5TK3Dbbl
         zwR/Uuf7R4fhQnhh8dTJFXhw2YmnwgjDUpastanOuMLhSgYiLCYYVWPv61D32VSIYld8
         hB8Q==
X-Gm-Message-State: AOAM531yMY/sfVcsrXJQXKyA84DFqDZ9QhV8dPsLfK3PGJUvCRiGE5pY
        5jNLfirYELnR3U7FIOJe9dtk3g==
X-Google-Smtp-Source: ABdhPJxSfBoB+/zEXxpz+SssqmVIVy8y/b3XOQ1QxT0jEktgkc2EaT+HL41RN7fRIfpbuB7wwdkvGA==
X-Received: by 2002:ac8:5a86:0:b0:2ed:1434:4492 with SMTP id c6-20020ac85a86000000b002ed14344492mr6008916qtc.17.1649677820682;
        Mon, 11 Apr 2022 04:50:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q123-20020a378e81000000b0067eb3d6f605sm18704645qkd.0.2022.04.11.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 04:50:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ndsYl-00Gj15-9z; Mon, 11 Apr 2022 08:50:19 -0300
Date:   Mon, 11 Apr 2022 08:50:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220411115019.GB64706@ziepe.ca>
References: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411200018.1363127-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 11, 2022 at 04:00:18PM -0400, yanjun.zhu@linux.dev wrote:
> @@ -138,8 +139,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>  	elem->obj = obj;
>  	kref_init(&elem->ref_cnt);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	xa_lock_irqsave(&pool->xa, flags);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +				&pool->next, GFP_ATOMIC);
> +	xa_unlock_irqrestore(&pool->xa, flags);

No to  using atomics, this needs to be either the _irq or _bh varient

Jason
