Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9107ACDD7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 04:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjIYCFw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Sep 2023 22:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjIYCFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Sep 2023 22:05:46 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB13CA;
        Sun, 24 Sep 2023 19:05:40 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d86574d9bcaso3590768276.2;
        Sun, 24 Sep 2023 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695607539; x=1696212339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYYVzFPKU+1ehIbHqAxMjCLIu/yAEcO3F57HxWyY/K4=;
        b=TCjD8OX/kxMbatsUokTUPD2mhhjwj5XDqfj+oFCvVxaGkFk0aKz65mMmR65Zb6/IDr
         +c9cR6ZjXgmdIV736qXc5/FVLeTWbuqGwrqYWMB5RkurfxDuWwCjLxhkNpmSInVFJeTm
         hfZmPLYdYgfkquwZYFhH0xLNdqUMo2Xjieri6pp0cWbQ+AtbTj+QpkTlIL25RoM8xXnO
         dMY2QMcVdPI+9PixO/TdaWD6QJmfG2DoxJMsJ2DHs1zAMKFqKX1zLtGogUgQ5EcP0O0q
         9tTSmmIaf0f0pwnNkYv2bhIhtn5AiU30e/W0+26YH7vGVjRf1V6Q/CVu4gvhA5eQvhmc
         nMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695607539; x=1696212339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYYVzFPKU+1ehIbHqAxMjCLIu/yAEcO3F57HxWyY/K4=;
        b=NHaZUUs0JpO9zeNwvjmxEGKyolEk9lNCrUgytvBuMfgGuC9upp8VDRuC0F158jO2+s
         Xrzvsc66QV8yCW3PZjXOsQzYCsLGy0RQ1+b1OMcRXN6hiDcFq0Sx9Sfa0xjNoCv94zZR
         o9Scq/jw5hlMh6ehLy7ApbBmcUiWGy1Pe/k0OrojwZoI/uTURnBkrcJIHXr1BUIZhuuU
         fkLrbHPQTyp4zxla4bqct3Q8AAYX5Z+b5xS5Q6IgkT4+lJTqmx/s6xmwXqEmzqjeU6du
         g+TLJoCCV0Rakk8Vpr51lJpTkzGpeRA4Hip2MMhLW5mvlC89tSyERdv5l0DZFrEbVOUP
         5fdg==
X-Gm-Message-State: AOJu0Yx/CsYl2PGc9kMXzjx0kuMkh/E9H04defnzzor09ry0ft5aYdVK
        ukAPJo53N2U1bkCSC+PV6rGU1JLxP3k=
X-Google-Smtp-Source: AGHT+IFL6pmeSmZk/RqQs4QZxi6TUUCsuCnak+Gj76eOWpXw9fX9S/Nueb/v5qEQnli1HkYHcIDCmg==
X-Received: by 2002:a25:f05:0:b0:d81:582b:4652 with SMTP id 5-20020a250f05000000b00d81582b4652mr4410347ybp.21.1695607539032;
        Sun, 24 Sep 2023 19:05:39 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id o187-20020a25d7c4000000b00d7f06aa25c5sm2002474ybg.58.2023.09.24.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:05:38 -0700 (PDT)
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
Subject: [PATCH 3/4] Revert "sched/topology: Introduce sched_numa_hop_mask()"
Date:   Sun, 24 Sep 2023 19:05:27 -0700
Message-Id: <20230925020528.777578-4-yury.norov@gmail.com>
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

This reverts commit 9feae65845f7b16376716fe70b7d4b9bf8721848.

Now that for_each_numa_hop_mask() is reverted, revert underlying
machinery.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/topology.h |  7 -------
 kernel/sched/topology.c  | 33 ---------------------------------
 2 files changed, 40 deletions(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 344c2362755a..72f264575698 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -247,18 +247,11 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 
 #ifdef CONFIG_NUMA
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node);
-extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
 #else
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
 	return cpumask_nth(cpu, cpus);
 }
-
-static inline const struct cpumask *
-sched_numa_hop_mask(unsigned int node, unsigned int hops)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
 #endif	/* CONFIG_NUMA */
 
 #endif /* _LINUX_TOPOLOGY_H */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a5bc678c08..3f1c09a9ef6d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2143,39 +2143,6 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(sched_numa_find_nth_cpu);
-
-/**
- * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away from
- *                         @node
- * @node: The node to count hops from.
- * @hops: Include CPUs up to that many hops away. 0 means local node.
- *
- * Return: On success, a pointer to a cpumask of CPUs at most @hops away from
- * @node, an error value otherwise.
- *
- * Requires rcu_lock to be held. Returned cpumask is only valid within that
- * read-side section, copy it if required beyond that.
- *
- * Note that not all hops are equal in distance; see sched_init_numa() for how
- * distances and masks are handled.
- * Also note that this is a reflection of sched_domains_numa_masks, which may change
- * during the lifetime of the system (offline nodes are taken out of the masks).
- */
-const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops)
-{
-	struct cpumask ***masks;
-
-	if (node >= nr_node_ids || hops >= sched_domains_numa_levels)
-		return ERR_PTR(-EINVAL);
-
-	masks = rcu_dereference(sched_domains_numa_masks);
-	if (!masks)
-		return ERR_PTR(-EBUSY);
-
-	return masks[hops][node];
-}
-EXPORT_SYMBOL_GPL(sched_numa_hop_mask);
-
 #endif /* CONFIG_NUMA */
 
 static int __sdt_alloc(const struct cpumask *cpu_map)
-- 
2.39.2

