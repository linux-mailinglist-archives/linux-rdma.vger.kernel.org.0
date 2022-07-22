Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD2D57E39F
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 17:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiGVPUD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiGVPUC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 11:20:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1681B3A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:20:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so6767300pjj.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H7PnM7CarmZXTSyzcvqwouZTq8D3FVNEzWH1mHVH5KE=;
        b=GwzknZsrIDuX1TJFyQO9TAilsZlP8pwgM60BoHLMqkqWpBWRZInWVw4aQbP5v0oJjE
         LiE9ZHq1hXGr75TTDvzvMKJyc1xNzkfKIs/HAnpErvYEvgIDlZ4FW2zzpClu71hcbLub
         Z2bEQIOTLfXKqFLhgtL/qcD59dB5fJoLgmu5n3LVnSvMRimf7vI188ZTzfUKbA9+txAV
         6zCA6UEhMGq0H0o3RH7pAxkrsRoQrLn4ONFXj72Mcbe/KKl5Sssl3V9YIandEaXxbrtj
         IzLxSCKKqnfrqmB/9KJn2awV6yVs9V2/Fl8pC/Zn9IMeTBsZgMQjQ4PjW4ZZIO85axHf
         YsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H7PnM7CarmZXTSyzcvqwouZTq8D3FVNEzWH1mHVH5KE=;
        b=a50awqvt6E0ye8HWtwVed31t9FeB+8CYf0vFVJDVPN8Jn9mFCG9GhYoWmGP09UgUJJ
         Qr6jpj/2cFm+MRECxKv2ww9gA7LOhTFbfWA6RH5oCS7/tjOUX+D5qXKlqr/afv6MSRXO
         kjerdu90o6YTwCzlcjymN1C49WrvmlKOpd4zjDe9RYMxdp8BN5+2zQgXxWv2uLxj0eaU
         VuIs+xsHc3V4DV6CRhdgf2St47V2bmf5//N2D+5sJpz/VyESt+XsbdFUYgiGx6xxg1iC
         Alm8U+VC+ngxzob0NOxfeFGJ1s0bpUYUu+Dhiy+vLrxVnpsrbBecjO9fJwJ/LoYApG9e
         pX/A==
X-Gm-Message-State: AJIora/v38DZY0KXVieiyWIvBzomTrsTgqWfptaOt0Lo8kcSPb7lrhDV
        9Q5gi3g7Dbrb/5PJQ5jOjwWOFg==
X-Google-Smtp-Source: AGRyM1vjLiucQ1dDdcUwr4YTVVnq/w6xskFvXY6lzf3Z0fB7rFcscRVCJ+6XQOJz8wqXbyRuAn2sBg==
X-Received: by 2002:a17:90b:1b11:b0:1f2:2d70:70d7 with SMTP id nu17-20020a17090b1b1100b001f22d7070d7mr10639539pjb.59.1658503201752;
        Fri, 22 Jul 2022 08:20:01 -0700 (PDT)
Received: from ziepe.ca (S0106a84e3fe8c3f3.cg.shawcable.net. [24.64.144.200])
        by smtp.gmail.com with ESMTPSA id gt23-20020a17090af2d700b001f25244c663sm969482pjb.54.2022.07.22.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:20:01 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEuRc-000FDw-2o; Fri, 22 Jul 2022 12:20:00 -0300
Date:   Fri, 22 Jul 2022 12:20:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by
 __rxe_add_to_pool interrupted by rxe_pool_get_index
Message-ID: <20220722152000.GC55077@ziepe.ca>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
 <921120a1-28fa-dd2a-b6fc-227faa3c8ace@linux.dev>
 <cc59c87d-39dd-6307-de9e-a67a89acfea0@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc59c87d-39dd-6307-de9e-a67a89acfea0@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 22, 2022 at 03:14:25PM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/7/22 21:43, Yanjun Zhu wrote:
> > Hi， Xiao
> > 
> > Normally I applied this "RDMA/rxe: Fix dead lock caused by 
> > __rxe_add_to_pool interrupted by rxe_pool_get_index" patch
> > 
> > series to fix this problem. And I am not sure if this problem is fixed 
> > by "[PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu".
> > 
> > Zhu Yanjun
> Hi Yanjun,
> 
> I have confirmed that the problem has been fixed by:
> [PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu

Thanks!

Jason
