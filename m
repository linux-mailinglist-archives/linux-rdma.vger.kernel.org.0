Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD71C7EC40E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Nov 2023 14:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjKONtH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Nov 2023 08:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONtG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Nov 2023 08:49:06 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 396ECAC;
        Wed, 15 Nov 2023 05:49:03 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1099)
        id A779420B74C1; Wed, 15 Nov 2023 05:49:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A779420B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700056142;
        bh=6bm+G+2Har0LNkfawvlVKFLAqfQ3KYMWeofqY6dFb2o=;
        h=From:To:Cc:Subject:Date:From;
        b=A3ku9EjRqyGx9ZmVJgN5tBccal2hOoVgWTxA4gsPfgo4V14RrsGMkp5wUovzA1a1p
         hrzJPr3fIGjfPN4Z427qL8K/U6IMadBHXfaciuHRSzwa3qfh0R1H6oHixCHPiEURwO
         2IJlAvMaj1IbFM8NCOSV3lOYfxCxE0YCtNaq393c=
From:   Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
        sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
        ssengar@linux.microsoft.com, vkuznets@redhat.com,
        tglx@linutronix.de, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     schakrabarti@microsoft.com, paulros@microsoft.com,
        Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: Assigning IRQ affinity on HT cores
Date:   Wed, 15 Nov 2023 05:48:45 -0800
Message-Id: <1700056125-29358-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Existing MANA design assigns IRQ affinity to every sibling CPUs, which causes
IRQ coalescing and may reduce the network performance with RSS.

Improve the performance by adhering the configuration for RSS, which prioritise
IRQ affinity on HT cores.

Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 126 ++++++++++++++++--
 1 file changed, 117 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 6367de0c2c2e..839be819d46e 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1243,13 +1243,115 @@ void mana_gd_free_res_map(struct gdma_resource *r)
 	r->size = 0;
 }
 
+static void cpu_mask_set(cpumask_var_t *filter_mask, cpumask_var_t **filter_mask_list)
+{
+	unsigned int core_count = 0, cpu;
+	cpumask_var_t *filter_mask_list_tmp;
+
+	BUG_ON(!filter_mask || !filter_mask_list);
+	filter_mask_list_tmp = *filter_mask_list;
+	cpumask_copy(*filter_mask, cpu_online_mask);
+	/* for each core create a cpumask lookup table,
+	 * which stores all the corresponding siblings
+	 */
+	for_each_cpu(cpu, *filter_mask) {
+		BUG_ON(!alloc_cpumask_var(&filter_mask_list_tmp[core_count], GFP_KERNEL));
+		cpumask_or(filter_mask_list_tmp[core_count], filter_mask_list_tmp[core_count],
+			   topology_sibling_cpumask(cpu));
+		cpumask_andnot(*filter_mask, *filter_mask, topology_sibling_cpumask(cpu));
+		core_count++;
+	}
+}
+
+static int irq_setup(int *irqs, int nvec)
+{
+	cpumask_var_t filter_mask;
+	cpumask_var_t *filter_mask_list;
+	unsigned int cpu_first, cpu, irq_start, cores = 0;
+	int i, core_count = 0, numa_node, cpu_count = 0, err = 0;
+
+	BUG_ON(!alloc_cpumask_var(&filter_mask, GFP_KERNEL));
+	cpus_read_lock();
+	cpumask_copy(filter_mask, cpu_online_mask);
+	/* count the number of cores
+	 */
+	for_each_cpu(cpu, filter_mask) {
+		cpumask_andnot(filter_mask, filter_mask, topology_sibling_cpumask(cpu));
+		cores++;
+	}
+	filter_mask_list = kcalloc(cores, sizeof(cpumask_var_t), GFP_KERNEL);
+	if (!filter_mask_list) {
+		err = -ENOMEM;
+		goto free_irq;
+	}
+	/* if number of cpus are equal to max_queues per port, then
+	 * one extra interrupt for the hardware channel communication.
+	 */
+	if (nvec - 1 == num_online_cpus()) {
+		irq_start = 1;
+		cpu_first = cpumask_first(cpu_online_mask);
+		irq_set_affinity_and_hint(irqs[0], cpumask_of(cpu_first));
+	} else {
+		irq_start = 0;
+	}
+	/* reset the core_count and num_node to 0.
+	 */
+	core_count = 0;
+	numa_node = 0;
+	cpu_mask_set(&filter_mask, &filter_mask_list);
+	/* for each interrupt find the cpu of a particular
+	 * sibling set and if it belongs to the specific numa
+	 * then assign irq to it and clear the cpu bit from
+	 * the corresponding sibling list from filter_mask_list.
+	 * Increase the cpu_count for that node.
+	 * Once all cpus for a numa node is assigned, then
+	 * move to different numa node and continue the same.
+	 */
+	for (i = irq_start; i < nvec; ) {
+		cpu_first = cpumask_first(filter_mask_list[core_count]);
+		if (cpu_first < nr_cpu_ids && cpu_to_node(cpu_first) == numa_node) {
+			irq_set_affinity_and_hint(irqs[i], cpumask_of(cpu_first));
+			cpumask_clear_cpu(cpu_first, filter_mask_list[core_count]);
+			cpu_count = cpu_count + 1;
+			i = i + 1;
+			/* checking if all the cpus are used from the
+			 * particular node.
+			 */
+			if (cpu_count == nr_cpus_node(numa_node)) {
+				numa_node = numa_node + 1;
+				if (numa_node == num_online_nodes()) {
+					cpu_mask_set(&filter_mask, &filter_mask_list);
+					numa_node = 0;
+				}
+				cpu_count = 0;
+				core_count = 0;
+				continue;
+			}
+		}
+		if ((core_count + 1) % cores == 0)
+			core_count = 0;
+		else
+			core_count++;
+	}
+free_irq:
+	cpus_read_unlock();
+	if (filter_mask)
+		free_cpumask_var(filter_mask);
+	if (filter_mask_list) {
+		for (core_count = 0; core_count < cores; core_count++)
+			free_cpumask_var(filter_mask_list[core_count]);
+		kfree(filter_mask_list);
+	}
+	return err;
+}
+
 static int mana_gd_setup_irqs(struct pci_dev *pdev)
 {
 	unsigned int max_queues_per_port = num_online_cpus();
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_irq_context *gic;
-	unsigned int max_irqs, cpu;
-	int nvec, irq;
+	unsigned int max_irqs;
+	int nvec, *irqs, irq;
 	int err, i = 0, j;
 
 	if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
@@ -1261,6 +1363,11 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	nvec = pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
 	if (nvec < 0)
 		return nvec;
+	irqs = kmalloc_array(nvec, sizeof(int), GFP_KERNEL);
+	if (!irqs) {
+		err = -ENOMEM;
+		goto free_irq_vector;
+	}
 
 	gc->irq_contexts = kcalloc(nvec, sizeof(struct gdma_irq_context),
 				   GFP_KERNEL);
@@ -1281,20 +1388,20 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 			snprintf(gic->name, MANA_IRQ_NAME_SZ, "mana_q%d@pci:%s",
 				 i - 1, pci_name(pdev));
 
-		irq = pci_irq_vector(pdev, i);
-		if (irq < 0) {
-			err = irq;
+		irqs[i] = pci_irq_vector(pdev, i);
+		if (irqs[i] < 0) {
+			err = irqs[i];
 			goto free_irq;
 		}
 
-		err = request_irq(irq, mana_gd_intr, 0, gic->name, gic);
+		err = request_irq(irqs[i], mana_gd_intr, 0, gic->name, gic);
 		if (err)
 			goto free_irq;
-
-		cpu = cpumask_local_spread(i, gc->numa_node);
-		irq_set_affinity_and_hint(irq, cpumask_of(cpu));
 	}
 
+	err = irq_setup(irqs, nvec);
+	if (err)
+		goto free_irq;
 	err = mana_gd_alloc_res_map(nvec, &gc->msix_resource);
 	if (err)
 		goto free_irq;
@@ -1314,6 +1421,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	}
 
 	kfree(gc->irq_contexts);
+	kfree(irqs);
 	gc->irq_contexts = NULL;
 free_irq_vector:
 	pci_free_irq_vectors(pdev);
-- 
2.34.1

