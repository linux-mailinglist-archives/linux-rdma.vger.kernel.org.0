Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2584974B3
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiAWSnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiAWSmH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:42:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C298C061788;
        Sun, 23 Jan 2022 10:42:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so13504407plc.3;
        Sun, 23 Jan 2022 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tLzjpnOADmNqLEv3y7RAP4vzyys1NFYghrGKziaABc=;
        b=khLdulZwVjToAAKsGPnVUTUcnSPw7gBK/gucAq2M+Jhnco/kZMbd3eY8aFWgX4ugKJ
         7k+577Q/M58DQZd93gqoQYYcOYaxBVnkv5vFtyRh5jLDXRz4dHZ22XFzyvEzVigCqsfe
         KELEEKI+T+GTTCEDGx8gKeDamtVKHpIQ1xaCL6/PdkSahphjpKm9WIn49Og/34rufImJ
         hbjG0GfhOIvrGodBhGF98wMT4qBTUKamvsIMxxuN+3xpMeMpv8ToXjyI3NXBEEzJSmIP
         r5QQQNMMVWUxA35xSqj71hqMNWyUkUBFAjI9uGyb4qYvlskV5J++DcBZXbHJUMVaYtzp
         upKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tLzjpnOADmNqLEv3y7RAP4vzyys1NFYghrGKziaABc=;
        b=XHyygYXuf0JfQ4PWT7N81cl7nfGypNcUQurFlg09zAlznNUGcY3Q59ucBos0uuj/lX
         AdsQVcyDOL+h8k/bfOICMckhJQ2ciuAPOyIKzMPpYUUETiUAeSUu3VL7k5wB1LLilsbB
         4qLENV4Nafu7n6drOQ4MKNVYSL/GxntRelU0HagCSPxS336mt0nEKJKgCWyvrpVYaYJO
         SSL0dplUIfhtZ5CEQYddj5VIev2NVCEmxwhPJFG289UqTSHohifSFNKuoUaokq9OcWpH
         Tdteb46leda4hsNAuG/Aq0wpBUGtTS9zWyy9ax+UmiIhBS+c5wWmWVgLyaJh6Wk4o3/t
         3UGg==
X-Gm-Message-State: AOAM531/Dno9xEi59lHCy49aNifiLa2wtNJ4znYORISjKJQJP/Mub2tN
        6qS1ff6Ha7oFoIx1+BpuTQE=
X-Google-Smtp-Source: ABdhPJy02pmad9QwzHaMHfP8LQid/ly1qUr6qMXANtQBkQB6BCcJa3GDae9da0jqfsH81LIjOzFggg==
X-Received: by 2002:a17:90b:3b46:: with SMTP id ot6mr9845312pjb.104.1642963326516;
        Sun, 23 Jan 2022 10:42:06 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x12sm9977539pge.58.2022.01.23.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:42:06 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 44/54] infiniband: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Sun, 23 Jan 2022 10:39:15 -0800
Message-Id: <20220123183925.1052919-45-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Infiniband code uses cpumask_weight() to compare the weight of
cpumask with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/hw/hfi1/affinity.c    | 9 ++++-----
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c  | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/affinity.c b/drivers/infiniband/hw/hfi1/affinity.c
index 38eee675369a..7c5ca5c5306a 100644
--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -507,7 +507,7 @@ static int _dev_comp_vect_cpu_mask_init(struct hfi1_devdata *dd,
 	 * available CPUs divide it by the number of devices in the
 	 * local NUMA node.
 	 */
-	if (cpumask_weight(&entry->comp_vect_mask) == 1) {
+	if (cpumask_weight_eq(&entry->comp_vect_mask, 1)) {
 		possible_cpus_comp_vect = 1;
 		dd_dev_warn(dd,
 			    "Number of kernel receive queues is too large for completion vector affinity to be effective\n");
@@ -593,7 +593,7 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 {
 	struct hfi1_affinity_node *entry;
 	const struct cpumask *local_mask;
-	int curr_cpu, possible, i, ret;
+	int curr_cpu, i, ret;
 	bool new_entry = false;
 
 	local_mask = cpumask_of_node(dd->node);
@@ -626,10 +626,9 @@ int hfi1_dev_affinity_init(struct hfi1_devdata *dd)
 			    local_mask);
 
 		/* fill in the receive list */
-		possible = cpumask_weight(&entry->def_intr.mask);
 		curr_cpu = cpumask_first(&entry->def_intr.mask);
 
-		if (possible == 1) {
+		if (cpumask_weight_eq(&entry->def_intr.mask, 1)) {
 			/* only one CPU, everyone will use it */
 			cpumask_set_cpu(curr_cpu, &entry->rcv_intr.mask);
 			cpumask_set_cpu(curr_cpu, &entry->general_intr_mask);
@@ -1017,7 +1016,7 @@ int hfi1_get_proc_affinity(int node)
 		cpu = cpumask_first(proc_mask);
 		cpumask_set_cpu(cpu, &set->used);
 		goto done;
-	} else if (current->nr_cpus_allowed < cpumask_weight(&set->mask)) {
+	} else if (cpumask_weight_gt(&set->mask, current->nr_cpus_allowed)) {
 		hfi1_cdbg(PROC, "PID %u %s affinity set to CPU set(s) %*pbl",
 			  current->pid, current->comm,
 			  cpumask_pr_args(proc_mask));
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index aa290928cf96..add89bc21b0a 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -1151,7 +1151,7 @@ static void assign_ctxt_affinity(struct file *fp, struct qib_devdata *dd)
 	 * reserve a processor for it on the local NUMA node.
 	 */
 	if ((weight >= qib_cpulist_count) &&
-		(cpumask_weight(local_mask) <= qib_cpulist_count)) {
+		(cpumask_weight_le(local_mask, qib_cpulist_count))) {
 		for_each_cpu(local_cpu, local_mask)
 			if (!test_and_set_bit(local_cpu, qib_cpulist)) {
 				fd->rec_cpu_num = local_cpu;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index ceed302cf6a0..b17f96509d2c 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -3405,7 +3405,7 @@ static void qib_setup_7322_interrupt(struct qib_devdata *dd, int clearpend)
 	local_mask = cpumask_of_pcibus(dd->pcidev->bus);
 	firstcpu = cpumask_first(local_mask);
 	if (firstcpu >= nr_cpu_ids ||
-			cpumask_weight(local_mask) == num_online_cpus()) {
+			cpumask_weight_eq(local_mask, num_online_cpus())) {
 		local_mask = topology_core_cpumask(0);
 		firstcpu = cpumask_first(local_mask);
 	}
-- 
2.30.2

