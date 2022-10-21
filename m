Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B676076C8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJUMUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 08:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiJUMTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 08:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF2399C9
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666354788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7y76rMK0l0e5eWAROAZYTUlkl1SI1ptrjBCD2DTCug=;
        b=RbEgplK6AVxbm50g+vAk9gxnaMxylxm207DjiUnHPnTPXq5C7JlHRD2TRTjPflpzI356RB
        iOu+gT/R6T1YSU617CANZr8zsH8qTMkVPG1USOnbR53aeCzsV6VMgBWRcC2T/1JPchTo7x
        dWFrwdVhT91ft//wqQymstCaYUHbmD8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-193-_VWz9H0vPu-uFKvNawXh1A-1; Fri, 21 Oct 2022 08:19:46 -0400
X-MC-Unique: _VWz9H0vPu-uFKvNawXh1A-1
Received: by mail-qk1-f198.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso3397848qkp.21
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 05:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7y76rMK0l0e5eWAROAZYTUlkl1SI1ptrjBCD2DTCug=;
        b=PKgJSWQyTUrHza1M9bdOBTrhclRyTx9+debYOwQPvDkQtBPDW/BEZuuPo3C9GzOHZF
         5WVYctqEqGHN3vxn9WKD4RBewTBjnsn8f5vJBuvAQwbnmQ5vRHjTZ7aw4q+AXzcr9mFa
         n8uQKrZ3Ge0kLM3gLxwfTnjOAD3eV9HgZKGa4tfEGW60KZM9XN0A1GUgTjbIxtQuNjqu
         mEMLK1kj92AHctZEPJz9l7rAFvVfAohMFxGKH4pIpgHeZd6S1tzXnXMsbXlpyQE7q8s0
         38JaVIFE+0YHcliT6BJtHquVtSyomSjzzdJhAlQZc9KJ3BAyGVt3bvz/KphugJWiR2W6
         89WA==
X-Gm-Message-State: ACrzQf3izeDbW0WyTW6HgCMlvt4yDadhx6yFk6+htiYhaSQG2YF1b7Pw
        onUdmRjFZsXO4y3HuuEucKaG9/prrxgQbndSRyVzU44hiCGI3CwQrhl//ZHI2LRjnxsw9TjiwGd
        YtYlq2J3JYEcHWUK/MiQsAw==
X-Received: by 2002:a05:620a:2a02:b0:6ee:7de4:9690 with SMTP id o2-20020a05620a2a0200b006ee7de49690mr13676783qkp.172.1666354786336;
        Fri, 21 Oct 2022 05:19:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sLH8bXS413+XFYWVIbbJohIxgwebM1DnPUPbcd/4ZL1om8uQre6ceLIx2LKvMRh9mvgd8Tg==
X-Received: by 2002:a05:620a:2a02:b0:6ee:7de4:9690 with SMTP id o2-20020a05620a2a0200b006ee7de49690mr13676761qkp.172.1666354786116;
        Fri, 21 Oct 2022 05:19:46 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i9-20020ac85c09000000b0039a610a04b1sm8043410qti.37.2022.10.21.05.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:19:45 -0700 (PDT)
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
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH v5 2/3] sched/topology: Introduce for_each_numa_hop_mask()
Date:   Fri, 21 Oct 2022 13:19:26 +0100
Message-Id: <20221021121927.2893692-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221021121927.2893692-1-vschneid@redhat.com>
References: <20221021121927.2893692-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The recently introduced sched_numa_hop_mask() exposes cpumasks of CPUs
reachable within a given distance budget, wrap the logic for iterating over
all (distance, mask) values inside an iterator macro.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/topology.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 3e91ae6d0ad58..8185e12ec1ccc 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -246,16 +246,36 @@ static inline const struct cpumask *cpu_cpu_mask(int cpu)
 }
 
 #ifdef CONFIG_NUMA
-extern const struct cpumask *sched_numa_hop_mask(int node, int hops);
+extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
 #else
-static inline const struct cpumask *sched_numa_hop_mask(int node, int hops)
+static inline const struct cpumask *
+sched_numa_hop_mask(unsigned int node, unsigned int hops)
 {
-	if (node == NUMA_NO_NODE && !hops)
-		return cpu_online_mask;
-
 	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif	/* CONFIG_NUMA */
 
+/**
+ * for_each_numa_hop_mask - iterate over cpumasks of increasing NUMA distance
+ *                          from a given node.
+ * @mask: the iteration variable.
+ * @node: the NUMA node to start the search from.
+ *
+ * Requires rcu_lock to be held.
+ *
+ * Yields cpu_online_mask for @node == NUMA_NO_NODE.
+ */
+#define for_each_numa_hop_mask(mask, node)				     \
+	for (unsigned int __hops = 0;					     \
+	     /*								     \
+	      * Unsightly trickery required as we can't both initialize	     \
+	      * @mask and declare __hops in for()'s first clause	     \
+	      */							     \
+	     mask = __hops > 0 ? mask :					     \
+		    node == NUMA_NO_NODE ?				     \
+		    cpu_online_mask : sched_numa_hop_mask(node, 0),	     \
+	     !IS_ERR_OR_NULL(mask);					     \
+	     __hops++,							     \
+	     mask = sched_numa_hop_mask(node, __hops))
 
 #endif /* _LINUX_TOPOLOGY_H */
-- 
2.31.1

