Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7680C50E915
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 21:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiDYTFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 15:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244809AbiDYTFe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 15:05:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410B12C434
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 12:02:29 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c1so11501258qkf.13
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7SmwLkL1l/qnb1tA+Urtp4xHwhHaSRSqtuZKQUqrKOg=;
        b=TTqtaH0qT4Mn1VvQCzNziGVihqJ5zCGPDkayi9IFPDpju8MTNtgwebs+CfTafbjA2f
         kdWXDcWf6uMV8jKsbiv3YRFcHiCIQV6tgYlnHiHMQwWuKH378dvV56IObE2aUmOhJsYD
         8a/rlqHKwD2XDU9fQBAECk83ymswL/fH7eIMUpgwlGLKW5LDQCjTOQYEA7MGH67CdoZv
         fvDiQUfm552nJ/al8rdVyTaVbnfz2FHriznqNrTlugCQGey1buGouladaCTiu1nAEqjx
         0wunCCD9tV5OuoekDTq3gwUMSsua2psjNWn5NvzOYJlO5jvgQLQTLikX5me4uun4iIac
         XqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7SmwLkL1l/qnb1tA+Urtp4xHwhHaSRSqtuZKQUqrKOg=;
        b=ntxxlQSnCXRWFdU7szK/VByBsVTEbx3T9mNyitG0pvBihxBy7iJreVQG6HZpseF2Cu
         cQwBH26gR0h8ZYrhzhDfC3L/M38RLjc6050Wc/AyQhWmFLgl5BrBidgot0mWV8Wp/eKO
         Wl0zGBhyTzGsk9Qw6q5ZBEPthRQefXSg7lrVemJutqFrXY7ESmw2LdYmdU2S7C/I8gl9
         GXdQG3d270FCR85sU4wS1Rj7CRGmRHQxoHUQvuTyzW2pkaRCaald86xWg2pCrx7L7u73
         Mh9TPA1CRe50B+74vyYBf8F8NmM53PqUj7IlLXj+2sq2kYuoHwtmE2iRK+0pSsU856Mj
         o4pA==
X-Gm-Message-State: AOAM5312wU/FpRjkFDCniGIhs7RpmnOx1h9Wfha2tNtLrbeqD4eaDMtr
        O+tujegypsmbd4BN89jTzDLB7Q==
X-Google-Smtp-Source: ABdhPJzd7LAm8WZIDdPIL4VaZkihbVjKGa9erl2AkBpYLHJls9nnSDhCLkz6qUKJRbpbfVz4TJsorQ==
X-Received: by 2002:a05:620a:424c:b0:67d:2bad:4450 with SMTP id w12-20020a05620a424c00b0067d2bad4450mr6651425qko.171.1650913348584;
        Mon, 25 Apr 2022 12:02:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a00cc00b002ebdd6ef303sm7130472qtw.43.2022.04.25.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 12:02:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nj3yd-009R4C-5P; Mon, 25 Apr 2022 16:02:27 -0300
Date:   Mon, 25 Apr 2022 16:02:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Message-ID: <20220425190227.GX64706@ziepe.ca>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <MW4PR84MB23078B439AE048978D67F42EBCF79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 25, 2022 at 07:47:23AM +0800, Yanjun Zhu wrote:
> 在 2022/4/22 23:57, Pearson, Robert B 写道:
> > Use of rcu_read_lock solves this problem. Rcu_read_lock and spinlock on same data can
> > Co-exist at the same time. That is the whole point. All this is going away soon.
> 
> This is based on your unproved assumption.

No, Bob is right, RCU avoids the need for a BH lock on this XA, the
only remaining issue is the AH creation atomic call path.

Jason
