Return-Path: <linux-rdma+bounces-18552-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA/3EaTvwWkgYAQAu9opvQ
	(envelope-from <linux-rdma+bounces-18552-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:57:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D543300C9A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 02:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E20023077D08
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D5D37B400;
	Tue, 24 Mar 2026 01:52:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792215B0EC;
	Tue, 24 Mar 2026 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317151; cv=none; b=IFhHIJQ0P3gk+U4aJPOMYmBeN/gT81eHfqLHLj0ssqSSDXf+qRs6t7DztXrpyDPOf++fgPVxuc4S7XB5wVr8V/vqhmsvcMbF7i5G31HpLHMo4yRQGLyX4lKwfDAKS6XTeiX+6IawMEbNIdcd/1a/Z/A9M9PS1Yv6/VyLZ91CjZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317151; c=relaxed/simple;
	bh=LFMZUsx+fOfF0tWZJMVsgeJpCrkFVtKN43zUgSqKNME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nu+ubctd819IHtEdQUngmDx5Q6S1cFUJa81pPgRVP0FM01WLTBTjnFDB1QAe+g+r3iN31UwdCfYuH0gd+TvQ5RwXCRPLuV0fP9FtsFUFRmgiFuFkfZlXgzo9Ir/uJEWavczFBpb8padqfHvUEBYOIvB1h1MzPl8f4CrJu9OwlE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowACHGw+b7MFpya5JCw--.4485S2;
	Tue, 24 Mar 2026 09:44:59 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] RDMA/irdma: validate AEQ QP and CQ indices
Date: Tue, 24 Mar 2026 09:44:59 +0800
Message-ID: <20260324014459.93348-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACHGw+b7MFpya5JCw--.4485S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1kZF1xKFW7tw4rZFyUGFg_yoW8WF18pF
	WUXF90vr98JF17K3s3C3yFyFWYqan5tr9rCF1a93s5Xas8AryjqFn3GFyxuFZIyw43tr1I
	yw12vF45Ca1jgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18552-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid]
X-Rspamd-Queue-Id: 9D543300C9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

irdma_process_aeq() trusts the QP/CQ identifier decoded from the
hardware AEQE and uses it to index rf->qp_table[] and rf->cq_table[]
without first checking that the identifier fits the allocated table.

Reject AEQ entries whose QP or CQ ids fall outside rf->max_qp or
rf->max_cq before touching the tables. This keeps malformed or stale
hardware event records from walking past the end of the driver-owned
resource arrays.
---
 drivers/infiniband/hw/irdma/hw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index f4ae530f56db..32d7ac7d3885 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -313,6 +313,13 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 			  info->iwarp_state, info->ae_src);
 
 		if (info->qp) {
+			if (unlikely(info->qp_cq_id >= rf->max_qp)) {
+				ibdev_warn_ratelimited(&iwdev->ibdev,
+						       "AEQ reported invalid QP id %u\n",
+						       info->qp_cq_id);
+				continue;
+			}
+
 			spin_lock_irqsave(&rf->qptable_lock, flags);
 			iwqp = rf->qp_table[info->qp_cq_id];
 			if (!iwqp) {
@@ -413,6 +420,13 @@ static void irdma_process_aeq(struct irdma_pci_f *rf)
 				  "Processing an iWARP related AE for CQ misc = 0x%04X\n",
 				  info->ae_id);
 
+			if (unlikely(info->qp_cq_id >= rf->max_cq)) {
+				ibdev_warn_ratelimited(&iwdev->ibdev,
+						       "AEQ reported invalid CQ id %u\n",
+						       info->qp_cq_id);
+				continue;
+			}
+
 			spin_lock_irqsave(&rf->cqtable_lock, flags);
 			iwcq = rf->cq_table[info->qp_cq_id];
 			if (!iwcq) {
-- 
2.50.1 (Apple Git-155)


