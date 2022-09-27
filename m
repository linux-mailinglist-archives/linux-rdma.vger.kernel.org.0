Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D55EC3ED
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 15:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiI0NOn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiI0NOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 09:14:40 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25351A8
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 06:14:34 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c19so5952784qkm.7
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RXa1QP7RkhKDxBJccCpdGbr5kpNbd8JjkCsyuCRoAPE=;
        b=gTKkHliNEjvy9mwKLbm6Prz/1bjvtM5WTHX11q4+jebNCf37895zxPDJdFZL0ZXdb+
         U+n0hjaX7NM1RVeYHAxlqNdvwuEdeFgC6FbZzeOo/DCJGM42iR8QE/5Qhh4X1JCjVEp7
         icZ7oB/dc8MDPyuxFqhExo2YAX5EPARR4VOuDKzNpH/ttIpWic22HMZPaXKlMU6fIgq7
         3y7cEVteRv9nXGFc/RU1GtsW9YLRz+eWUtvww2IxHsQw5sTvDoq6He35KkdHMvjt2w82
         E+41xWD/8DA3GmNacO4Idzput8rxVxBnpPJWDiaf36ukSFAJr/QlDlZJhiQPZx8D4Kf+
         eF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RXa1QP7RkhKDxBJccCpdGbr5kpNbd8JjkCsyuCRoAPE=;
        b=rS2B/HDhuh7H9/Lvmeu+I32MOOutuKpEDhLs1nqS4jduYdTEiFir8dNvwMil0Nwfc2
         dfor+FxuglnShcxxzTom0LNN+/UUf0pHug0o1aQGtitAc1ZuHOMGrQ4zNKYUw2YkznVf
         BDLWvsjgtuDgGVq+wbfQsrNcx8ki0/Z8+nV5U2uv7VMwcK2Y8S82aK2i7y55lVmnfAus
         UUzaMhkOXgXB+Yl/lltf/8A07BTrjTcvzhJ2oWlM3bNjPp3mLKDMSMZwJOXrHk6br/Ov
         fQbzScXE+7sntSod2je/YGrjjH59rV3m6uyCU59gxi0+SApxVJaAn7YearfFt+nLCFY7
         ZZZQ==
X-Gm-Message-State: ACrzQf0lqaD85cIDlywWUw2h8hId6GjTj9UCU3bg9HkbBaiafy6y7GOu
        EEyUzfIAql1appeaeoDdXsilzw==
X-Google-Smtp-Source: AMsMyM5Sm/taIzdPlq6yt+IAtC8nTuEGl4w4jlGdFPTeEob9XB/DGNJFYpByMhip5Yed0m9WQqAdxg==
X-Received: by 2002:a05:620a:10af:b0:6ce:40f7:3dc4 with SMTP id h15-20020a05620a10af00b006ce40f73dc4mr17017011qkk.345.1664284474098;
        Tue, 27 Sep 2022 06:14:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id 2-20020ac85942000000b0035d430d4315sm847817qtz.19.2022.09.27.06.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:14:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1odAPv-000YjT-S4;
        Tue, 27 Sep 2022 10:14:31 -0300
Date:   Tue, 27 Sep 2022 10:14:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH jgg-for-next] RDMA/rxe: Fix pd refcount_t: underflow;
 use-after-free
Message-ID: <YzL3N533TE8T3k1c@ziepe.ca>
References: <20220927052530.21397-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927052530.21397-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 27, 2022 at 01:25:30PM +0800, Li Zhijian wrote:
> In the error path, both rxe_put(pd) and rxe_cleanup(mr) will
> drop pd's ref_cont.
> rxe_cleanup(mr)
>  -> __rxe_cleanup
>    -> rxe_put(mr->elem)
>    -> rxe_mr_cleanup(mr)
>      -> rxe_put(mr_pd(mr))
> 
> [342431.583189] ------------[ cut here ]------------
> [342431.585051] refcount_t: underflow; use-after-free.
> [342431.586677] WARNING: CPU: 0 PID: 660500 at lib/refcount.c:28 refcount_warn_saturate+0xcd/0x120
> [342431.605247] RIP: 0010:refcount_warn_saturate+0xcd/0x120
> [342431.661981]  __rxe_cleanup+0x1c3/0x1e0 [rdma_rxe]
> [342431.663260]  rxe_dealloc_pd+0x16/0x20 [rdma_rxe]
> [342431.664883]  ib_dealloc_pd_user+0x95/0xd0 [ib_core]
> [342431.666803]  destroy_hw_idr_uobject+0x46/0x90 [ib_uverbs]
> [342431.668514]  uverbs_destroy_uobject+0xc8/0x360 [ib_uverbs]
> [342431.670232]  __uverbs_cleanup_ufile+0x157/0x210 [ib_uverbs]
> [342431.671920]  ? uverbs_destroy_uobject+0x360/0x360 [ib_uverbs]
> 
> CC: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 0d0e4b528c3b ("RDMA/rxe: Set pd early in mr alloc routines")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> I have to say i made a mistake in previous review, I missed this WARN_ONCE messages.
> And the V6 patch that i had applied fix this problem in another way.

Does this mean I took the wrong patch? The patchworks got messed up
for this series somehow

I'll squash this diff in..

Jason
