Return-Path: <linux-rdma+bounces-5945-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4119C5989
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 14:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F821F22FEF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727A1FBCB4;
	Tue, 12 Nov 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlI9Fq2C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE21F7084
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419420; cv=none; b=d4Du4jpYaByVxNDIexgaF9sVfznEiq26FlYYV3TXNoDMO+AVpnr9KnUrrbWYWlEe+jDMqppHjD+25f/fFDEKMajSEnoDA6y+y3ltubkUPRfzbl2ogx0l4Qo0Spedpi6DeiCmQJjG7gCaTbt8qM9fQpZ3D7OX1pf57lQlHckVRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419420; c=relaxed/simple;
	bh=nSOskOd9cmif+82CK5bd9zlOpXVHHGQGCb+Liwu2Csk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z50HjQu8mtX+OWidJ8PT+52A3qcVrBkUdNtWmum3XjaxjYmm5wFlqjOHfsTri8a4bHcutVQkJjAIhEbYFFtjTqxUb0GtvPZw/8YxQc2Nd/PmH7NjXARhfGolx7CyXQh4r/89296ARqdE8z8GPUudxULSNCI+HGZTuLotUe+qgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlI9Fq2C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731419418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/WX3p8cdeb2T0ayeSkNyCI7S/yaoWFFExVswly9zdi4=;
	b=hlI9Fq2CCNc57Fe3DxfApFwxnKwaMnKnotihaHcNfKnNc69pWRgaYhpEWXZss2pA0nYt2F
	oaz2RCLztgxhFQv2PvJX61F37LI9Ahiw/61UUyt61WtVkAwI6rh0B4e3VD42o31JeOCCRg
	P25RUYWyaN9p4QjR7N/FoWzk15dNjXg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-xAa1S21cPgqKL2zG9lAh2g-1; Tue,
 12 Nov 2024 08:50:16 -0500
X-MC-Unique: xAa1S21cPgqKL2zG9lAh2g-1
X-Mimecast-MFC-AGG-ID: xAa1S21cPgqKL2zG9lAh2g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97BA41955BF4;
	Tue, 12 Nov 2024 13:50:15 +0000 (UTC)
Received: from mheiblap.localdomain.com (unknown [10.47.238.97])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D3D7C19560A3;
	Tue, 12 Nov 2024 13:50:13 +0000 (UTC)
From: Mohammad Heib <mheib@redhat.com>
To: linux-rdma@vger.kernel.org,
	selvin.xavier@broadcom.com,
	kashyap.desai@broadcom.com
Cc: Mohammad Heib <mheib@redhat.com>
Subject: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid accessing invalid memeory
Date: Tue, 12 Nov 2024 15:49:56 +0200
Message-Id: <20241112134956.1415343-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If bnxt FW behaves unexpectedly because of FW bug or unexpected behavior it
can send completions for old  cookies that have already been handled by the
bnxt driver. If that old cookie was associated with an old calling context
the driver will try to access that caller memory again because the driver
never clean the is_waiter_alive flag after the caller successfully complete
waiting, and this access will cause the following kernel panic:

Call Trace:
 <IRQ>
 ? __die+0x20/0x70
 ? page_fault_oops+0x75/0x170
 ? exc_page_fault+0xaa/0x140
 ? asm_exc_page_fault+0x22/0x30
 ? bnxt_qplib_process_qp_event.isra.0+0x20c/0x3a0 [bnxt_re]
 ? srso_return_thunk+0x5/0x5f
 ? __wake_up_common+0x78/0xa0
 ? srso_return_thunk+0x5/0x5f
 bnxt_qplib_service_creq+0x18d/0x250 [bnxt_re]
 tasklet_action_common+0xac/0x210
 handle_softirqs+0xd3/0x2b0
 __irq_exit_rcu+0x9b/0xc0
 common_interrupt+0x7f/0xa0
 </IRQ>
 <TASK>

To avoid the above unexpected behavior clear the is_waiter_alive flag
every time the caller finishes waiting for a completion.

Fixes: 691eb7c6110f ("RDMA/bnxt_re: handle command completions after driver detect a timedout")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index f5713e3c39fb..eaf92029862b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -511,15 +511,15 @@ static int __bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 	else
 		rc = __poll_for_resp(rcfw, cookie);
 
-	if (rc) {
-		spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
-		crsqe = &rcfw->crsqe_tbl[cookie];
-		crsqe->is_waiter_alive = false;
-		if (rc == -ENODEV)
-			set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
-		spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
+
+	spin_lock_irqsave(&rcfw->cmdq.hwq.lock, flags);
+	crsqe = &rcfw->crsqe_tbl[cookie];
+	crsqe->is_waiter_alive = false;
+	if (rc == -ENODEV)
+		set_bit(FIRMWARE_STALL_DETECTED, &rcfw->cmdq.flags);
+	spin_unlock_irqrestore(&rcfw->cmdq.hwq.lock, flags);
+	if (rc)
 		return -ETIMEDOUT;
-	}
 
 	if (evnt->status) {
 		/* failed with status */
-- 
2.34.3


