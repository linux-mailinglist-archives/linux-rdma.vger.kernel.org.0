Return-Path: <linux-rdma+bounces-17804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oItyL5sCr2lmLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:25:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EED123D9E8
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFEB3302E7DC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F93E7144;
	Mon,  9 Mar 2026 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lyy8CGmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE41DE2AD;
	Mon,  9 Mar 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077084; cv=none; b=SLKuyFluG2Wm1i9h/d6gM2FJLK9O9FGHHVvq9ULviPuCF2ccwRnt82DestlRcOXEi7WfA+lesNP0WBfix42zXGZAXOeItmFJU/Nxx8c+VoUotCrfDmHcJs+2azBJVOMFRnYSZPKP2wXQOpstfCH/qfZstUdoK09GghTthKjlOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077084; c=relaxed/simple;
	bh=wv4vh+1l8yNkJSBy4DVeFyLqWOhQtBa56ZVYIJnvzPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=geS2lExB3ABY9iXRBLH3XUiJ5HBI/yJJ2zsDygcRk6YKUzV2/mZ4dRu4mH9BJIIuFlACtL2dXHKzCaXKVyTcrdNv7iPN62gDYe3DVLvdHB3T6BFEzyuGZ1esAcWYLsAqDFnnxLZCn+OhgPLlhK1IKSGTpM4tZ3WT47vZ9m8zp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lyy8CGmt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id A4D3020B6F02; Mon,  9 Mar 2026 10:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4D3020B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773077083;
	bh=CVUw3DVnM/0STCEBHsDAe345inWLl6va8IY3OGPZZLg=;
	h=From:To:Cc:Subject:Date:From;
	b=lyy8CGmtqKGdooC7PdYQ0aC1bpIXeveXhHgatOXkTvtcllOjT0gqzjTWRriAWvbtv
	 ps3Yy8EMiQtMSypI2B7KSjCF/GsyutowQiLYzL1HVzYYAoaJEd3S2Othj3K18s2kxD
	 a+18AUW5nYfYud6s4weHOwuMwacqtWKhOd3Hsw0U=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: shirazsaleem@microsoft.com,
	kotaranov@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net] net/mana: Null service_wq on setup error to prevent double destroy
Date: Mon,  9 Mar 2026 10:24:43 -0700
Message-ID: <20260309172443.688392-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EED123D9E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17804-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Shiraz Saleem <shirazsaleem@microsoft.com>

In mana_gd_setup() error path, set gc->service_wq to NULL after
destroy_workqueue() to match the cleanup in mana_gd_cleanup().
This prevents a use-after-free if the workqueue pointer is checked
after a failed setup.

Fixes: f975a0955276 ("net: mana: Fix double destroy_workqueue on service rescan PCI path")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0055c23..e879344 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1934,6 +1934,7 @@ remove_irq:
 	mana_gd_remove_irqs(pdev);
 free_workqueue:
 	destroy_workqueue(gc->service_wq);
+	gc->service_wq = NULL;
 	dev_err(&pdev->dev, "%s failed (error %d)\n", __func__, err);
 	return err;
 }
-- 
2.43.0


