Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40E6553C7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Dec 2022 20:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiLWTHX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Dec 2022 14:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLWTHW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Dec 2022 14:07:22 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE591B9E0
        for <linux-rdma@vger.kernel.org>; Fri, 23 Dec 2022 11:07:21 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id a66so5258005vsa.6
        for <linux-rdma@vger.kernel.org>; Fri, 23 Dec 2022 11:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HGw9oRroFvPZ2dyQcKWKF0FY4soMbEIhC7lZPLQhPjY=;
        b=HmlyjN0EM9c5k+W/8twiDyNwtL4iIkEk+itfoYVQWrXjlJAflSsOolovl+8prOU0XE
         l3/x47GBmfyqzrLb1Cp1GyaQU9sS4GHbnvznDR+Yx/j6IjI+4xIgzdLttkx2R/RRrQfv
         7cm4SVHqjoc5mTYMdO646JC/I8jyHL7Ryehsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGw9oRroFvPZ2dyQcKWKF0FY4soMbEIhC7lZPLQhPjY=;
        b=QnA/RIZzUTUeNlCK6cGD8/WLcYbJD3k+6YRcsTmu+Kg7Bxnbj4y3ofzN9gLwhX37X5
         WIjTAgcUT4agMSqymhn32mqfeBWXtJ2qP11JfAHIQ9Q9f+eceqFxi3+9aHO/ZzmftC0w
         XuBWAk0KRxpKrSnc5LDmTU/Rg6qiXMzuTvMTRGZTLp4iaB+NK+UgR+Rh+ehM2g82fp9u
         Ie+9bXyFXV33PNkB0RHOXyS6qcUqbo+wqx6QuXVVoV9QV3W2hims/k7hyGi2yWYFdiud
         yf/+RiBDa+KDQIoNJXVmSqLuKVgabkZ3c24Yiqq4jRBsIrcgFQY1Ssrm27CzpMFnukS1
         Ab+Q==
X-Gm-Message-State: AFqh2kpJF3aqAhwUEvyxIOv1jGOZBwbhtkSfF4ci+9wRzI8UlhOB7022
        FDpFsljzp5kl7VU53D3zNka4hR49Ei/4K11K
X-Google-Smtp-Source: AMrXdXvBqpbWwWITuk3vk6YOwuCIjqPpJRdLgW3F6js8aFIaJUITsWYyBVn88j/k1svS35ck+io4gw==
X-Received: by 2002:a67:ec09:0:b0:3bd:cae2:1724 with SMTP id d9-20020a67ec09000000b003bdcae21724mr4926040vso.18.1671822439748;
        Fri, 23 Dec 2022 11:07:19 -0800 (PST)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com. [209.85.222.169])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006fa43e139b5sm2793513qkp.59.2022.12.23.11.07.19
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 11:07:19 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id pj1so2761600qkn.3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Dec 2022 11:07:19 -0800 (PST)
X-Received: by 2002:a05:620a:1379:b0:6fc:c48b:8eab with SMTP id
 d25-20020a05620a137900b006fcc48b8eabmr347377qkl.216.1671822438709; Fri, 23
 Dec 2022 11:07:18 -0800 (PST)
MIME-Version: 1.0
References: <Y5uprmSmSfYechX2@yury-laptop> <CAHk-=wj_4xsWxLqPvkCV6eOJt7quXS8DyXn3zWw3W94wN=6yig@mail.gmail.com>
In-Reply-To: <CAHk-=wj_4xsWxLqPvkCV6eOJt7quXS8DyXn3zWw3W94wN=6yig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Dec 2022 11:07:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgrzisX2_MCcw3Qqa0J3d7mL14aab9F0JkjGF=VfAk5Ow@mail.gmail.com>
Message-ID: <CAHk-=wgrzisX2_MCcw3Qqa0J3d7mL14aab9F0JkjGF=VfAk5Ow@mail.gmail.com>
Subject: Re: [GIT PULL] bitmap changes for v6.2-rc1
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 23, 2022 at 10:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, in this case, I think the logical thing to do is "check that
> the upper bits are the same". The way you do that is probably
> something like
>
>    !((off) ^ ((nbits)-1) & ~(BITS_PER_LONG-1))

Note that while the above is probably correct (but you always need to
double-check my emailed "something like this" code - I literally write
it in the MUA, and I make mistakes too), I'd never want to see that as
part of one big complex macro.

In fact, I think I am missing a set of parentheses, because '&' has a
higher precedence than '^', so the above is actually buggy.

So I'd much rather see something like this

  #define COMPILE_TIME_TRUE(x) (__builtin_constant_p(x) && (x))

  #define bits_in_same_word(x,y) \
        (!(((x)^(y))&~(BITS_PER_LONG-1)))

  #define bitmap_off_in_last_word(nbits,off) \
        bits_in_same_word((nbits)-1,off)

  #define small_const_nbits_off(nbits, off) \
        (__builtin_constant_p(nbits) && (nbits) > 0 && \
         COMPILE_TIME_TRUE(bitmap_off_in_last_word(nbits,off)))

where each step does one thing and one thing only, and you don't have
one complicated thing that is hard to read.

And again, don't take my word blindly for the above.  I *think* the
above may be correct, but there's a "think" and a "may" there.

Plus I'd still like to hear about where the above would actually
matter and make a code generation difference in real life (compared to
just the simple "optimize the single-word bitmap" case).

                Linus
