Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2E50EC73
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbiDYXQP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 19:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237124AbiDYXQP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 19:16:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1B46668
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 16:13:08 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e128so12002371qkd.7
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 16:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=859SzIAl5s4qyDYzHMnInkzDTVU0f+lfGR9c6BypQKU=;
        b=VFMKBb4spKVN4vXzZmGlcljUkn8jDXuHsiypBo8IpuM+TtBh+LnxNjfREzL8kMHQ+/
         GyN6Hve3dAxf26J8NV9n1G2dLOP6w4d8Wi+PdKWvN0RNtdhCshdN4Kj01Aa42XW/S7Rz
         7Q9T6F4NBS917g8xR2MU60I8vn2Zp7N/VQteaEwXAVlbERBnfvYLAPKIunkG0MAt3gtV
         0vk3il+3Co25IWYnl2IT5zWZ93sJcqqHpmE++7SkTInXHWwN35cr4URvGhyuj6pyWyBf
         iKRcbEl3hWk6wBiIdAdnote+DN2WS5js6dUKvdufawLmRDPL4DDEEFUTFynGLDs50qLB
         BnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=859SzIAl5s4qyDYzHMnInkzDTVU0f+lfGR9c6BypQKU=;
        b=7xDsxR++//WdjTWf78djYOATqTksolt2UJJEnRLClCta2V73159GO6JJGeMPdZ2vyI
         bZqK6ybaCv6LoeggEXCHyODUAi1ax08JKkfhNLO5CxBg/S97xGj5BAW7iGpYjDj8pAh8
         jp0Hhn1CoIQSWNOEggNyfnqbaZrRk6mI4wzio856p4PRh9tGcp0zCCodH23fkdu8QZK2
         pS4MhRmeqyjuPSuk5BfmpG6Dl58NuvWcJRPqwb7rRuFJ0pHFrXXLO3QTE/D7u/LoBf/M
         JwpYFrNqFkEf7lfr9C4YGOSkrsHQZ++Yaqi8Qyy4RBHLjl+/s0k1cO4JEhRFHggQ6KL/
         R3gg==
X-Gm-Message-State: AOAM532NkOAn7ATWb0RtmfSrh9Qubwmcl9bdNLxNwtkDnP6uG9iwnSq+
        bDAvbkPcb1JOAh/en5lwlOoVyQ==
X-Google-Smtp-Source: ABdhPJyBm1rfe/bIM2Tf4Z/VxltzqOD4aEPfsMfKA3H69l46JBqz8Rvc4A+jnw7zX9p/YaPB+m+lPw==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id s70-20020a374549000000b0069f556c4e38mr4588420qka.202.1650928387552;
        Mon, 25 Apr 2022 16:13:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h23-20020ac87777000000b002f3604761desm5115402qtu.35.2022.04.25.16.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 16:13:06 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nj7tB-009VkQ-Qg; Mon, 25 Apr 2022 20:13:05 -0300
Date:   Mon, 25 Apr 2022 20:13:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: "mm: uninline copy_overflow()" breaks i386 build in Mellanox MLX4
Message-ID: <20220425231305.GY64706@ziepe.ca>
References: <dbd203b1-3988-4c9c-909c-2d1f7f173a0d@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbd203b1-3988-4c9c-909c-2d1f7f173a0d@o2.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 21, 2022 at 10:47:01PM +0200, Mateusz Jończyk wrote:
> Hello,
> 
> commit ad7489d5262d ("mm: uninline copy_overflow()")
> 
> breaks for me a build for i386 in the Mellanox MLX4 driver:
> 
>         In file included from ./arch/x86/include/asm/preempt.h:7,
>                          from ./include/linux/preempt.h:78,
>                          from ./include/linux/percpu.h:6,
>                          from ./include/linux/context_tracking_state.h:5,
>                          from ./include/linux/hardirq.h:5,
>                          from drivers/net/ethernet/mellanox/mlx4/cq.c:37:
>         In function ‘check_copy_size’,
>             inlined from ‘copy_to_user’ at ./include/linux/uaccess.h:159:6,
>             inlined from ‘mlx4_init_user_cqes’ at drivers/net/ethernet/mellanox/mlx4/cq.c:317:9,
>             inlined from ‘mlx4_cq_alloc’ at drivers/net/ethernet/mellanox/mlx4/cq.c:394:10:
>         ./include/linux/thread_info.h:228:4: error: call to ‘__bad_copy_from’ declared with attribute error: copy source size is too small
>           228 |    __bad_copy_from();
>               |    ^~~~~~~~~~~~~~~~~
>         make[5]: *** [scripts/Makefile.build:288: drivers/net/ethernet/mellanox/mlx4/cq.o] Błąd 1
>         make[4]: *** [scripts/Makefile.build:550: drivers/net/ethernet/mellanox/mlx4] Błąd 2
>         make[3]: *** [scripts/Makefile.build:550: drivers/net/ethernet/mellanox] Błąd 2
>         make[2]: *** [scripts/Makefile.build:550: drivers/net/ethernet] Błąd 2
>         make[1]: *** [scripts/Makefile.build:550: drivers/net] Błąd 2
> 
> Reverting this commit fixes the build. Disabling Mellanox Ethernet drivers
> in Kconfig (tested only with also disabling of all Infiniband support) also fixes the build.
> 
> It appears that uninlining of copy_overflow() causes GCC to analyze the code deeper.

This looks like a compiler bug to me, array_size(entries, cqe_size)
cannot be known at compile time, so the __builtin_constant_p(bytes)
should be compile time false meaning the other two bad branches should
have been eliminated.

Jason
