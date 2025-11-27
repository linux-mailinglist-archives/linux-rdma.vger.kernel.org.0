Return-Path: <linux-rdma+bounces-14808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE43C8EC57
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161854E816C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F12333344C;
	Thu, 27 Nov 2025 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsmNEvZD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD36332EAF
	for <linux-rdma@vger.kernel.org>; Thu, 27 Nov 2025 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764253940; cv=none; b=nWMzNW8L5V8qP5K91ytL+vE74Of/C9xZdF0IvGsTuPDmllsEIh40UanjF5R+mcKepgmSF8GJmczy4R9jxoUP1OToVOaRmTbJE7p/q0y+kOroDx4EDesfA1nEa2GWXYusFcXruDiiWFnIJK8jlAoZ+DslCdXQ0cDGxXIE4L+Fi0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764253940; c=relaxed/simple;
	bh=0kwzv6pFxzHtGaJnxCuZYa8K5c8rzoCEBUvt8o7dX/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XA5eXE/StWEsQ9SAyvOmEyA7IqbND4IJ6QQQtVYRxv3/YUV9sn10GkaM7geE3bp72nmpUTmNU+it0mlqE3CQKxWq37Mm2fyNGrUIIQfRdGKNwlzGpu84hKhLc0OWXF8OjVWho24SM+kgNf/ViGGq3o+z6dsZMqfoMtyCT/pxh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gsmNEvZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764253937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cwWSpzAZ8o+kEIvUvxCYtrV+7teolmZBzgeeBR8Mg1s=;
	b=gsmNEvZDEynDYJpPsbSUMX0j7kKGIeAX//PzrjygJ081EfnECjNge2mZRopiCyPmbpLGsc
	bt3OmxIB5b32jwUPFjWDZtmiqiiGp2udk6vk/tBtF4F9Vtc6wd/epq6cu8xjOyxwLRqcN3
	2zFh//mN+9/9lWm2x/zuCkp8xeu/A0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-w5PffJQdNEun3dr-Kmttyg-1; Thu,
 27 Nov 2025 09:32:13 -0500
X-MC-Unique: w5PffJQdNEun3dr-Kmttyg-1
X-Mimecast-MFC-AGG-ID: w5PffJQdNEun3dr-Kmttyg_1764253931
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C4011956089;
	Thu, 27 Nov 2025 14:32:11 +0000 (UTC)
Received: from rhel-developer-toolbox.redhat.com (unknown [10.45.224.138])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AB4419560B0;
	Thu, 27 Nov 2025 14:32:06 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/irdma: avoid invalid read in irdma_net_event
Date: Thu, 27 Nov 2025 15:31:50 +0100
Message-ID: <20251127143150.121099-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

irdma_net_event() should not dereference anything from "neigh" (alias
"ptr") until it has checked that the event is NETEVENT_NEIGH_UPDATE.
Other events come with different structures pointed to by "ptr" and they
may be smaller than struct neighbour.

Move the read of neigh->dev under the NETEVENT_NEIGH_UPDATE case.

The bug is mostly harmless, but it triggers KASAN on debug kernels:

 ==================================================================
 BUG: KASAN: stack-out-of-bounds in irdma_net_event+0x32e/0x3b0 [irdma]
 Read of size 8 at addr ffffc900075e07f0 by task kworker/27:2/542554

 CPU: 27 PID: 542554 Comm: kworker/27:2 Kdump: loaded Not tainted 5.14.0-630.el9.x86_64+debug #1
 Hardware name: [...]
 Workqueue: events rt6_probe_deferred
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x60/0xb0
  print_address_description.constprop.0+0x2c/0x3f0
  print_report+0xb4/0x270
  kasan_report+0x92/0xc0
  irdma_net_event+0x32e/0x3b0 [irdma]
  notifier_call_chain+0x9e/0x180
  atomic_notifier_call_chain+0x5c/0x110
  rt6_do_redirect+0xb91/0x1080
  tcp_v6_err+0xe9b/0x13e0
  icmpv6_notify+0x2b2/0x630
  ndisc_redirect_rcv+0x328/0x530
  icmpv6_rcv+0xc16/0x1360
  ip6_protocol_deliver_rcu+0xb84/0x12e0
  ip6_input_finish+0x117/0x240
  ip6_input+0xc4/0x370
  ipv6_rcv+0x420/0x7d0
  __netif_receive_skb_one_core+0x118/0x1b0
  process_backlog+0xd1/0x5d0
  __napi_poll.constprop.0+0xa3/0x440
  net_rx_action+0x78a/0xba0
  handle_softirqs+0x2d4/0x9c0
  do_softirq+0xad/0xe0
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0xfd/0x120
  ip6_finish_output2+0x55d/0x10b0
  ip6_finish_output+0x549/0x12e0
  ndisc_send_skb+0x92d/0x17e0
  ndisc_send_ns+0x9a/0x100
  rt6_probe_deferred+0xe1/0x1c0
  process_one_work+0x89c/0x1ab0
  worker_thread+0x588/0xd30
  kthread+0x2d3/0x370
  ret_from_fork+0x2b/0x50
  </TASK>

 The buggy address belongs to the virtual mapping at
  [ffffc900075d9000, ffffc900075e2000) created by:
  irq_init_percpu_irqstack+0x1f4/0x310

 The buggy address belongs to the physical page:
 page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x180d209
 flags: 0x57ffffc0004000(reserved|node=1|zone=2|lastcpupid=0x1fffff)
 page_type: 0xffffffff()
 raw: 0057ffffc0004000 ffffea0060348248 ffffea0060348248 0000000000000000
 raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffc900075e0680: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
  ffffc900075e0700: 04 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffc900075e0780: 00 00 00 f1 f1 f1 f1 f1 f1 01 f2 02 f3 f3 f3 00
                                                              ^
  ffffc900075e0800: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
  ffffc900075e0880: f1 f1 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ==================================================================

Fixes: 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/infiniband/hw/irdma/utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8b94d87b0192..b6c4ccf38eb7 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -250,17 +250,18 @@ int irdma_inet6addr_event(struct notifier_block *notifier, unsigned long event,
 int irdma_net_event(struct notifier_block *notifier, unsigned long event,
 		    void *ptr)
 {
 	struct neighbour *neigh = ptr;
-	struct net_device *real_dev, *netdev = (struct net_device *)neigh->dev;
+	struct net_device *real_dev, *netdev;
 	struct irdma_device *iwdev;
 	struct ib_device *ibdev;
 	__be32 *p;
 	u32 local_ipaddr[4] = {};
 	bool ipv4 = true;
 
 	switch (event) {
 	case NETEVENT_NEIGH_UPDATE:
+		netdev = neigh->dev;
 		real_dev = rdma_vlan_dev_real_dev(netdev);
 		if (!real_dev)
 			real_dev = netdev;
 		ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_IRDMA);
-- 
2.51.1


