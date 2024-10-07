Return-Path: <linux-rdma+bounces-5289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA8993B71
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5763283A87
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 23:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26819069B;
	Mon,  7 Oct 2024 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="bOOFjsYN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7198318C00D;
	Mon,  7 Oct 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345215; cv=none; b=JfT1e1o4a2R4T/r0Ut4OjFtimmYKv+YZr1dy+2NGQCqJMHxxv/Nh1jUDy8cbk+SSaPKRO5idyX1c8xXmQG5RFWcaAvE0T9y3SfobuuKfy6331qb7enuUeyIZv2cSJG0pDuMzYJIOJ2uEUrb2+Q2VmvIdwCkNvDkWBOEyA3DpeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345215; c=relaxed/simple;
	bh=Wsr0H1CYpJtmTInG+9Qw6s4j9i9noobUlHgs7WKH3dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LYR/cs/yoF/ZVjudR9pgOcU2Yb+F2ySKjRJ8/nnZfrBdSvR/6eWYSxLkmNhdJywPduSRjpbGXtQthZ7VgYpT8y4adaaVoJWhY4RQlaxRe6w52c4HGch9oTiwtlE7iFct8e8FDJomNcfdf0rmZ0sSP6qEvepfP3pUtg18DsoV3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=bOOFjsYN; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=kyp9XIhblqRm/Nv1X0TqQEnGfq2MESv4xLxTpYLtz+w=; b=bOOFjsYNZV1MgWVI
	iBle+9MYz4xsWWUxkuDgaSq3jfGDspQyUYs98y1I/uza8HfGOWS1pMnWgiJvZbQOAY202TWa5aWnJ
	vgIgNdIriVYx36VPKqd/6B/gnEhrIno1Uk+YpnQk5gNbxXWAnM9BjowXHxBmFKPhGawR2NiwTadgj
	TjG9TXZBLsTUisVM7SlS25lpzcfVxIVyTCCsZT+djPB5tLsiDqSvByK6d4EHgLX+UZOv2vMj0v5g/
	KSGP4G0M9zHXd7BXnDyXWRLg20MtTiyc0NS3pXnodCHDYloplWyLKkVq8TKLtwRcxy2chc/oQ8E7F
	axK6+P1ka7LreLs+wg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sxxXc-009aUF-1f;
	Mon, 07 Oct 2024 23:53:28 +0000
From: linux@treblig.org
To: dennis.dalessandro@cornelisnetworks.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] IB/hfi1: make clear_all_interrupts static
Date: Tue,  8 Oct 2024 00:53:26 +0100
Message-ID: <20241007235327.128613-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

clear_all_interrupts() in hw/hfi1/chip.c is currently global
but only used in the same file, so make it static.

There are also 'clear_all_interrupts' functions in i2c-nomadik and
emif.c but fortunately they're already static.

(Build and boot tested only, I don't have this hardware)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 2 +-
 drivers/infiniband/hw/hfi1/chip.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c52e6b2c9914..a442eca498b8 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13235,7 +13235,7 @@ int set_intr_bits(struct hfi1_devdata *dd, u16 first, u16 last, bool set)
 /*
  * Clear all interrupt sources on the chip.
  */
-void clear_all_interrupts(struct hfi1_devdata *dd)
+static void clear_all_interrupts(struct hfi1_devdata *dd)
 {
 	int i;
 
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index d861aa8fc640..8841db16bde7 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1404,7 +1404,6 @@ irqreturn_t receive_context_interrupt_napi(int irq, void *data);
 
 int set_intr_bits(struct hfi1_devdata *dd, u16 first, u16 last, bool set);
 void init_qsfp_int(struct hfi1_devdata *dd);
-void clear_all_interrupts(struct hfi1_devdata *dd);
 void remap_intr(struct hfi1_devdata *dd, int isrc, int msix_intr);
 void remap_sdma_interrupts(struct hfi1_devdata *dd, int engine, int msix_intr);
 void reset_interrupts(struct hfi1_devdata *dd);
-- 
2.46.2


