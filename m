Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37C17ACDDA
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Sep 2023 04:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjIYCFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Sep 2023 22:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjIYCFv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Sep 2023 22:05:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F88FE;
        Sun, 24 Sep 2023 19:05:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59eb8ec5e20so65009327b3.3;
        Sun, 24 Sep 2023 19:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695607542; x=1696212342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3Erv5jPUTJ6NOpgZnVC8ZDSsiaEDPSD4W7GSC7tyo4=;
        b=Bi1shG2CLDCY3BuMYL0NnCLxi+af/HNG0P6Q4Bj6OjpGwZTMboMw9EquA0oq+BN6WH
         1JzASvtDdloPxJe3H4AzEANwtg0EW0M8maJzSfffgcOPQm7N+6jz0kfNQyfBxuRBHCH3
         zGcJUsLM2a6vC1rYgaEAH1WoU8uSjrxSQYYuZmYJZUqaWuDAhuj9vJuXKXwcnj5IbU2/
         iiWVqOzDu5Pnz0FEVAQPVoo89bbdmVL6a7qaeoiKAENXA+JhZEBuhqAc1yRxS4jFV14B
         DKifjOYLNuBKjzY9Z5stdXjlDeLxNBIjidn8pHICyeLpLft/jJDU/Icz3TRER+jcbuob
         HWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695607542; x=1696212342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3Erv5jPUTJ6NOpgZnVC8ZDSsiaEDPSD4W7GSC7tyo4=;
        b=UkRFnz2iuB4Us0WVYOyZHxcfgbYLaa21QDCSjBJYNoeT47XAvsRHZkUQGI3RxOBS1v
         22wAV5Zud78s9ebsvnLUEJ/S/B4PJw5xP+aBiDdlsAPANIxioGjdsMb294vTDYsiYY19
         SkfKbjFVT0eTm1QaQGFbCysDIC816BGlDtCu0TJ8Et4putOMz+C4XHRIpXC7wd/toVSJ
         mulhF0OiMRRS2RMtW15YfAf1dewGbeXzO6FEfjEPQ/Fu64xuimXzwzojEC97gJIAosGJ
         7VoE/mzBDxRGJYdrdzenWPtQKVnEIgpAgU+jQOvztbxTTO2NzXhiDULXHFOMP2C0Uj37
         0lrw==
X-Gm-Message-State: AOJu0Yyb5qp0+TINNdC0vOC4jOCxrQf47QuHpLubFB0dCNPB3kMCtZEe
        SyXfGpln2VsgaKt2n1l1V55dgNYmPL0=
X-Google-Smtp-Source: AGHT+IG9HCuFwY+0LujiihwL4awznOH0oe6O5Sn3e5QdHFqMyDHQcOf0mONLO9JzR91UyWARlF+Sqg==
X-Received: by 2002:a05:690c:c99:b0:59f:5da9:d53c with SMTP id cm25-20020a05690c0c9900b0059f5da9d53cmr4176407ywb.35.1695607541693;
        Sun, 24 Sep 2023 19:05:41 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id cn32-20020a05690c0d2000b005927a79333esm77968ywb.28.2023.09.24.19.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:05:41 -0700 (PDT)
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
Subject: [PATCH 4/4] lib/cpumask: don't mention for_each_numa_hop_mask in cpumask_local_spread()"
Date:   Sun, 24 Sep 2023 19:05:28 -0700
Message-Id: <20230925020528.777578-5-yury.norov@gmail.com>
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

Now that for_each_numa_hop_mask() is reverted, also revert reference to
it in the comment to cpumask_local_spread().

This partially reverts commit 2ac4980c57f5 ("lib/cpumask: update comment
for cpumask_local_spread()")

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/cpumask.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/lib/cpumask.c b/lib/cpumask.c
index a7fd02b5ae26..d341fb71a8a9 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -117,27 +117,6 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
  *
  * Returns online CPU according to a numa aware policy; local cpus are returned
  * first, followed by non-local ones, then it wraps around.
- *
- * For those who wants to enumerate all CPUs based on their NUMA distances,
- * i.e. call this function in a loop, like:
- *
- * for (i = 0; i < num_online_cpus(); i++) {
- *	cpu = cpumask_local_spread(i, node);
- *	do_something(cpu);
- * }
- *
- * There's a better alternative based on for_each()-like iterators:
- *
- *	for_each_numa_hop_mask(mask, node) {
- *		for_each_cpu_andnot(cpu, mask, prev)
- *			do_something(cpu);
- *		prev = mask;
- *	}
- *
- * It's simpler and more verbose than above. Complexity of iterator-based
- * enumeration is O(sched_domains_numa_levels * nr_cpu_ids), while
- * cpumask_local_spread() when called for each cpu is
- * O(sched_domains_numa_levels * nr_cpu_ids * log(nr_cpu_ids)).
  */
 unsigned int cpumask_local_spread(unsigned int i, int node)
 {
-- 
2.39.2

