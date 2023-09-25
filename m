Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62FD7ACDD0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 04:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjIYCFl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Sep 2023 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIYCFk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Sep 2023 22:05:40 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1574CCA;
        Sun, 24 Sep 2023 19:05:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59c0d002081so65067137b3.2;
        Sun, 24 Sep 2023 19:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695607533; x=1696212333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ofetUYGKfUn8Y5bB/sKf2dY2Hbj366ZFweBVoXSLdk=;
        b=RR5ooqax/xkraHGJ/4sPxKmV2y2co0eHz78bqOv2mdzOKizZmgSNipt9iGK1UOprq8
         Q3+jx773UEegEUhBt0yKAqFyXcYk4T8GCDOg0fAEkwYgKcYK1OCCx13Yr32KxibQOGAE
         XsHnfN5pvHwIxhYFUFy34odXW+NqWvThH9zgEhIaqgwdgm+AieKLEHdBwjCXVPHMU8T0
         ROcma4CqYUq9HqBQyNWzhVMM/wQzw80uEgo2A2eudSwgPfDTIspTC2fGbx9virjiJEQ5
         BhVe8DXzoGg7avmbrKi5aSWOoDaM9g0jMdKizzdFFtHzNCDBPxZHQjgdHuYe7QFxSr6X
         GRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695607533; x=1696212333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ofetUYGKfUn8Y5bB/sKf2dY2Hbj366ZFweBVoXSLdk=;
        b=aKou8ilEVwvUfuVo5LpHLH46InESDWT1LAU2GqOQ6CQhUmOMgKN0hyE+oZN8IfEY8x
         +lnAwJWUD0JCxbOZXnfxoz2dFM9BahmaSETiUS9OUGbJ6S8x0a5mGQUoS6Dyz3e2UR7A
         XfZouvgKv7NUzmuFlj3Zz8MPDTPTH2DpEFbYnXQLy2VKMqG+60nBqgAMJrSmoMI7LeU6
         jcHlqK/eafAkfLV75U+Nd7b/P968nIfzTtCW5ktcgK8I1VuSs9goJXAUW8hyReUcpCa4
         DAkkSDXRjGgc97Qq+79FSx4doPxKwIBt893fn1kkepNASGCcgRwm72q443cNFfwRpwQ8
         M2uw==
X-Gm-Message-State: AOJu0Yxt/XdM0njheX1hzASh8DB6FCEfJQAG+s13w0PsKonF5zxE3RKq
        N/Sa7D22e+6JyaAIlRY7h4HhXuMMW1Y=
X-Google-Smtp-Source: AGHT+IEV0y8VzWJxet49qM1rIgLG05Ph3podhumDhLkyFgatTAhH70X71TzeU9R0NgBnqz06DfgVmA==
X-Received: by 2002:a81:b186:0:b0:59b:f152:8998 with SMTP id p128-20020a81b186000000b0059bf1528998mr5416624ywh.19.1695607532826;
        Sun, 24 Sep 2023 19:05:32 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id gb8-20020a05690c408800b0059f61be458esm810048ywb.82.2023.09.24.19.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:05:32 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 0/4] sched: drop for_each_numa_hop_mask()
Date:   Sun, 24 Sep 2023 19:05:24 -0700
Message-Id: <20230925020528.777578-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Recently added mlx5_cpumask_default_spread() makes for_each_numa_hop_mask()
opencoding cpumask_local_spread().

This series replaces mlx5_cpumask_default_spread() with generic
cpumask_local_spread(). And because mlx5_cpumask_default_spread()
is the only user of for_each_numa_hop_mask() machinery, drops it
entirely.

Regarding for_each_numa_hop_mask(), I've got a small series introducing
a better version of it - for_each_numa_cpu():

https://lore.kernel.org/netdev/20230430171809.124686-1-yury.norov@gmail.com/T/

But with the lack of interest, I believe it's wotrth to drop
for_each_numa_hop_mask() and put for_each_numa_cpu() on hold
until further updates...

Yury Norov (4):
  net: mellanox: drop mlx5_cpumask_default_spread()
  Revert "sched/topology: Introduce for_each_numa_hop_mask()"
  Revert "sched/topology: Introduce sched_numa_hop_mask()"
  lib/cpumask: don't mention for_each_numa_hop_mask in
    cpumask_local_spread()"

 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++---------------
 include/linux/topology.h                     | 25 ---------------
 kernel/sched/topology.c                      | 33 --------------------
 lib/cpumask.c                                | 21 -------------
 4 files changed, 2 insertions(+), 105 deletions(-)

-- 
2.39.2

