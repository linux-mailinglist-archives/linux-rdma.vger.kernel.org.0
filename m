Return-Path: <linux-rdma+bounces-10188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA547AB0CF4
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 10:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37208507C86
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 08:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3992274FE1;
	Fri,  9 May 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SJkxpIem"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655B274FDF;
	Fri,  9 May 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778708; cv=none; b=sL6dE0nwolx7hKssAtjDSEwSgw1JjaYouiaGZY1JBb6mE4pApkZjQrRlq01o8qQ74yIT0KSN3I2ZNrCYXXg+2C5dnjgLhe7Iqf+iK9tS+T/l15+0gxFiVLR08ODYZIoV2yIryUh+h+bEednViMNI84BL0+Y4uQLwa9+c/17YQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778708; c=relaxed/simple;
	bh=qTDrVslHRModJfH+fXdAa5T/N1RdiaWo/7f1Q1waIYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQtXPtXV3pNj+7nUXMY9pChro/RlzGCEkU0tPEjlx1nUJODWRP8g4ReCy1p6VpM+5ecnsSI2jKyEML88qUp3DC8u8yrVTT3gq4G7zlaGKj4fLzCQz/sVCla2nJkKso03Ik2AiPwbBTdP5zSY2cYblZUtkuhwVho5/AeKfnv+23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SJkxpIem; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1746778706; x=1778314706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qTDrVslHRModJfH+fXdAa5T/N1RdiaWo/7f1Q1waIYY=;
  b=SJkxpIem6rlANQP9VyssKSFirne0riRu0du1smVQy4+b3OIUuzy4/CDz
   rV3u3eoEanYnO1bnFGqGHgPP3N5jTvPrc0U3PNgt7NY1pAAWijKRli8KZ
   TK5PAFad97BVM8gBqBnv19/1qsE4c0DyoTDZEz4qXnr8HmCMY/QIq3ml0
   RLh/68xMggX4spakZgAFixLAW7vlS5xGqTDe/skQkIiTxiZIgeGOcEYNp
   sKxMB5fSq6fUQSYZqKY+g6F7si5Ce7SggqvtIXOgD3JXStSiFeXQfDo55
   TL75GEHwIzudSVieoviAWv6wYLFZiKB1PBa+m3lI2T+YlcllIPy2ikQ1l
   g==;
X-CSE-ConnectionGUID: v2JD8Ve1TreBvhRIQLP8Ow==
X-CSE-MsgGUID: 5MTvQcvnRlOYbOHXyC4t8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="199286265"
X-IronPort-AV: E=Sophos;i="6.15,274,1739804400"; 
   d="scan'208";a="199286265"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 17:17:15 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 82396D480C;
	Fri,  9 May 2025 17:17:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3880CBDC9B;
	Fri,  9 May 2025 17:17:13 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 595581A009A;
	Fri,  9 May 2025 16:17:12 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] IB/cm: Remove redundant WARN_ON in cm_free_priv_msg
Date: Fri,  9 May 2025 16:18:40 +0800
Message-ID: <20250509081840.40628-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, the blktests triggered this WARN_ON():
 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 1330889 at cm.c:353 cm_free_priv_msg+0xaa/0xc0 [ib_cm]
...
 CPU: 3 UID: 0 PID: 1330889 Comm: kworker/u16:1 Tainted: G        W  OE      6.13.0-rc3+ #3
 Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
 Workqueue: ib_mad1 timeout_sends [ib_core]
 RIP: 0010:cm_free_priv_msg+0xaa/0xc0 [ib_cm]
...
 Call Trace:
  <TASK>
  ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
  ? __warn.cold+0x93/0xfa
  ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
  ? report_bug+0xff/0x140
  ? handle_bug+0x58/0x90
  ? exc_invalid_op+0x17/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
  cm_process_send_error+0x64/0x1f0 [ib_cm]
  timeout_sends+0x1e5/0x2d0 [ib_core]
  process_one_work+0x156/0x310
  worker_thread+0x252/0x390
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xd2/0x100
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

In cm_process_send_error(), cm_free_priv_msg() will be called
when (msg != cm_id_priv->msg) is true. And all other calling to
cm_free_priv_msg() cases, msg is always the same as cm_id_priv->msg.

So it's safe to remove this WARN_ON

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/core/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 142170473e75..1a8e5b0e4d85 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -350,7 +350,7 @@ static void cm_free_priv_msg(struct ib_mad_send_buf *msg)
 
 	lockdep_assert_held(&cm_id_priv->lock);
 
-	if (!WARN_ON(cm_id_priv->msg != msg))
+	if (cm_id_priv->msg == msg)
 		cm_id_priv->msg = NULL;
 
 	if (msg->ah)
-- 
2.44.0


