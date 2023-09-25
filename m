Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E648A7ACDE0
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 04:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjIYCFn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Sep 2023 22:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIYCFn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Sep 2023 22:05:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1967BD;
        Sun, 24 Sep 2023 19:05:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59f7cc71e2eso10037637b3.0;
        Sun, 24 Sep 2023 19:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695607535; x=1696212335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPAXd9AbKmHdNRTfsq4M17cXn9dGkWOfPxW2lTik09I=;
        b=e1+qZ34p+Y1xPs7h14RDeJHKNxvyO8f2v9ikIxlr83HVPY2A6kLYhCxO2VmCG1WjWN
         JQiFuyqmVYQc0MTJwiFDKLehAIzYrZl+tgHIOBD4uQMhClPQwF/lePevDe+gMlxuZ+Nl
         mH4VAeg/LIkFMxexYSuNYh0oAjmhhhYxxY0iWFVgmY9JH4rUk1JOHCl/wVX2p/FccJxj
         kv1dqLayPse0P0iHJJj/MieBosfJsJIPLIv1V4atulaYXyr3k3sWMwZl+LvhoaGlmPAi
         KlkLd/OJPUah5wvirYfC+j72gBfRH+rpWU1vCSnspYgJhDleymFg3x+kJijV5Hyy0on2
         s4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695607535; x=1696212335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPAXd9AbKmHdNRTfsq4M17cXn9dGkWOfPxW2lTik09I=;
        b=DMmMxyBu27TfhERpyCS2ReHAgh3W1yzbABBTK6lmUGO1cU/j7uNNdqkcUZrEbt6hkm
         YLH7l3POFZ/lWHVNiFSlqDmJBIHNoq7ByX8U3AJlGuErAKi2nbnubcU+uYZPlkzafEBH
         elqKrsXoPPZ7vPek8bPosAiWz3KINCRmX+xv2Pih1DdxpYPyGbs0Xx1rcDE7qC7Hqxu1
         SHIRdLvs9EHWGYpf2JksG4E++38OVo8tT5ED9l9rRNgHlpLaKy67OUei4AxDvSeYD+v2
         3ts+WwhNR3YOjeXb8iv5Rxuzdppzdi5Cgg5aM0lyrtJCs2E0zkouOsvux4B+Hyq7BoPZ
         Qhcg==
X-Gm-Message-State: AOJu0Yy1VqS4Xdf5ca6ckGO4k5Pud9H8e0r610bZ6L9ImrtHeURf3EUo
        tGjGxwkeJ8dFcJfVvSU2ccYB0+mJo7s=
X-Google-Smtp-Source: AGHT+IH8+eYi14F/2p5M0KFhVc6wMfpNm88zZOHympPW6B300GTbyalXgqm+PukIn00bNFRCPOBWxA==
X-Received: by 2002:a81:4e42:0:b0:59b:14ca:4316 with SMTP id c63-20020a814e42000000b0059b14ca4316mr5342751ywb.43.1695607535532;
        Sun, 24 Sep 2023 19:05:35 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id gq10-20020a05690c444a00b0059f5828346csm957265ywb.3.2023.09.24.19.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:05:35 -0700 (PDT)
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
        Jacob Keller <jacob.e.keller@intel.com>,
        Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 1/4] net: mellanox: drop mlx5_cpumask_default_spread()
Date:   Sun, 24 Sep 2023 19:05:25 -0700
Message-Id: <20230925020528.777578-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925020528.777578-1-yury.norov@gmail.com>
References: <20230925020528.777578-1-yury.norov@gmail.com>
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

The function duplicates existing cpumask_local_spread(), and it's O(N),
while cpumask_local_spread() implementation is based on bsearch, and
thus is O(log n), so drop mlx5_cpumask_default_spread() and use generic
cpumask_local_spread().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 28 ++------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ea0405e0a43f..bd9f857cc52d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -828,30 +828,6 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 	mlx5_irq_release_vector(irq);
 }
 
-static int mlx5_cpumask_default_spread(int numa_node, int index)
-{
-	const struct cpumask *prev = cpu_none_mask;
-	const struct cpumask *mask;
-	int found_cpu = 0;
-	int i = 0;
-	int cpu;
-
-	rcu_read_lock();
-	for_each_numa_hop_mask(mask, numa_node) {
-		for_each_cpu_andnot(cpu, mask, prev) {
-			if (i++ == index) {
-				found_cpu = cpu;
-				goto spread_done;
-			}
-		}
-		prev = mask;
-	}
-
-spread_done:
-	rcu_read_unlock();
-	return found_cpu;
-}
-
 static struct cpu_rmap *mlx5_eq_table_get_pci_rmap(struct mlx5_core_dev *dev)
 {
 #ifdef CONFIG_RFS_ACCEL
@@ -873,7 +849,7 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
 	int cpu;
 
 	rmap = mlx5_eq_table_get_pci_rmap(dev);
-	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
+	cpu = cpumask_local_spread(vecidx, dev->priv.numa_node);
 	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &rmap);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
@@ -1125,7 +1101,7 @@ int mlx5_comp_vector_get_cpu(struct mlx5_core_dev *dev, int vector)
 	if (mask)
 		cpu = cpumask_first(mask);
 	else
-		cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vector);
+		cpu = cpumask_local_spread(vector, dev->priv.numa_node);
 
 	return cpu;
 }
-- 
2.39.2

