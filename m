Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AAC596210
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbiHPSL0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 14:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiHPSLF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 14:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C986074
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660673407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Cxl1yMNjN1JWkJUDea+B9kQSTSEbSpFhOYq99gTDk4=;
        b=GLcfCGmsV7L1Q0SMm2EXJtO6wrhbwGqL0fr3aFu3NaFrlNLZEzBaKVvawixlzCaaB8vNEp
        iTZqVWQoK5lzO7Lf99OwI8rsskGvP0E7K1BB4d7ZAS+9N8a5ieDC/cR7oFg7pkY0BJk/Hz
        EDiEg+bOq9t8fvTw0bkAh+9mRaia4fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-385-Fzzv3mRvMnGw_uzHQEnqNw-1; Tue, 16 Aug 2022 14:07:39 -0400
X-MC-Unique: Fzzv3mRvMnGw_uzHQEnqNw-1
Received: by mail-wm1-f72.google.com with SMTP id y3-20020a1c4b03000000b003a537ef75c7so2204372wma.3
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 11:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=5Cxl1yMNjN1JWkJUDea+B9kQSTSEbSpFhOYq99gTDk4=;
        b=yrEM01bpvxHI2zIJcFtV64xdG5NJ0GkirEMvq2MdPRuTVk/gm7m85aXf4cTnehRMMz
         9bR0CwyQGQ37uUrvgmyma77lIQ8IDnTPxC4iDKjGeuFBh9WXaVY+EsA6TMYptz528yfL
         bT0DGzeWCszkNLZFR/lra8wTRYWSDE8+MWmRPtgDwGI37zcjNUi1KJTDr/Du+4z5IqEF
         0eGcyAQWxYRA67C4ewoLqPhGrPQNyi1TKJ0JcWbT/0M6V6dI1qBKnSgkULQGTDuPdcsQ
         SLeZ7WlciyZml0YOqiJanM1azN/B6lTSxseOI+p5DEE7LGwOM9gp+s+KKOYQwX/j40d3
         rXqA==
X-Gm-Message-State: ACgBeo3mol6zZVVYRZb4JQ0VIMIneBDtQUd4vQaMABuruSjIFefkfCXo
        aI41IcCnLA1pByWqGa0ZjF+9S4u+S2LNaxS6408oRar3FF4m7Jqm4huZGfyrLVlRs0bgZ2Nll4M
        Wir4WSqpkwv3vXRSRMk7NmQ==
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr12446506wrq.625.1660673256725;
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uR8z5D5D8T/gAXNcIujuyju0f7+AmovqCm4Vq6ys0+45zUiErhIRXXQQ3OhAWcNPgXMOXnw==
X-Received: by 2002:a5d:4912:0:b0:220:6633:104f with SMTP id x18-20020a5d4912000000b002206633104fmr12446491wrq.625.1660673256534;
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o8-20020a05600c4fc800b003a319bd3278sm14694961wmq.40.2022.08.16.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:36 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH 0/5] cpumask, sched/topology: NUMA-aware CPU spreading interface
Date:   Tue, 16 Aug 2022 19:07:22 +0100
Message-Id: <20220816180727.387807-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi folks,

Tariq pointed out in [1] that drivers allocating IRQ vectors would benefit
from having smarter NUMA-awareness (cpumask_local_spread() doesn't quite cut
it).

The proposed interface involved an array of CPUs and a temporary cpumask, and
being my difficult self what I'm proposing here is an interface that doesn't
require any temporary storage other than some stack variables (at the cost of
one wild macro).

Patch 5/5 is just there to showcase how the thing would be used. If this doesn't
get hated on, I'll let Tariq pick this up and push it with his networking driver
changes (with actual changelogs).

[1]: https://lore.kernel.org/all/20220728191203.4055-1-tariqt@nvidia.com/

Cheers,
Valentin

Valentin Schneider (5):
  bitops: Introduce find_next_andnot_bit()
  cpumask: Introduce for_each_cpu_andnot()
  sched/topology: Introduce sched_numa_hop_mask()
  sched/topology: Introduce for_each_numa_hop_cpu()
  SHOWCASE: net/mlx5e: Leverage for_each_numa_hop_cpu()

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 12 ++++-
 include/linux/cpumask.h                      | 32 ++++++++++++++
 include/linux/find.h                         | 44 ++++++++++++++++---
 include/linux/topology.h                     | 46 ++++++++++++++++++++
 kernel/sched/topology.c                      | 28 ++++++++++++
 lib/cpumask.c                                | 19 ++++++++
 lib/find_bit.c                               | 16 ++++---
 7 files changed, 184 insertions(+), 13 deletions(-)

--
2.31.1

