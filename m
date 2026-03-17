Return-Path: <linux-rdma+bounces-18263-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEYrLpZouWmZDwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18263-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:43:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3C2AC30C
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EDC73027CBB
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC573E8661;
	Tue, 17 Mar 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ibCS9Y4l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02323E6DE6;
	Tue, 17 Mar 2026 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758385; cv=none; b=U4mNeNmN0E+tqx2VI40ETnFw7/1kS9uNFptyhKkrUk7asH1cZHSk39mJFZeUr6sYz7tkuxmsgJz3tBtsQogeEjF8r/kqX/fhOqLvmu9UQM+KgxXOFoVbU/R9mNzhannwkLj0YzUf8EYDQl4nyrwbk7NjE5GITtibk2yeeDv0dUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758385; c=relaxed/simple;
	bh=c+cdIRdM7Ez0D3peqQh+Zj3EK0hbiQwcJaAr0FS6Mro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWiJJVCb10kdxcwNQ4/19kyX9wTZDQ2C53a2ieijdV37Jbi2ohi3TvcvnBuVOrGYpyC64Pe8VoD8feD55ZnuIxacdlWm2Rzt8q1QIwajRrnZjHVyGCe7lb4V3/OG83acvk3Ux0chYS6m1Vt5CNpIFx6J5bd/L0fNyx9vw4wXPkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ibCS9Y4l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id D0BB420B710C; Tue, 17 Mar 2026 07:39:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0BB420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773758383;
	bh=Cs8wF+eyZi4CAp08CRR5vmK1gtQ9FCuuRGfTeThvTgU=;
	h=From:To:Cc:Subject:Date:From;
	b=ibCS9Y4lRNXbMXVh3iQsDqQCs1qGJtNPmVChk8eGVKZhgtgBoEe5nNLx29wGPgK6Q
	 EZuCQwpLzl5aAeFvtAIxMAXhH9gkf3VP+aKMg+sz/C2EgQxKxSVJ5RCa95m0Rcq4+3
	 Zy4DKJCUAmJ0I/WnNraIzHzJB4OGU8lx0tZbUUwY=
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
Subject: [PATCH net v2] net/mana: Fix auxiliary device double-delete race
Date: Tue, 17 Mar 2026 07:39:43 -0700
Message-ID: <20260317143943.1329271-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18263-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC3C2AC30C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Make remove_adev() safe to call concurrently from the service reset
and PCI eject paths by using xchg() to atomically claim the adev
pointer. This prevents double auxiliary_device_delete/uninit when
hv_eject_device_work races with the service reset workqueue.

Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
---
v2: rebased on the latest net
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9017e806e..9ae5f01d8 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3410,14 +3410,18 @@ static void adev_release(struct device *dev)
 
 static void remove_adev(struct gdma_dev *gd)
 {
-	struct auxiliary_device *adev = gd->adev;
-	int id = adev->id;
+	struct auxiliary_device *adev = xchg(&gd->adev, NULL);
+	int id;
+
+	if (!adev)
+		return;
+
+	id = adev->id;
 
 	auxiliary_device_delete(adev);
 	auxiliary_device_uninit(adev);
 
 	mana_adev_idx_free(id);
-	gd->adev = NULL;
 }
 
 static int add_adev(struct gdma_dev *gd, const char *name)
@@ -3481,7 +3485,7 @@ static void mana_rdma_service_handle(struct work_struct *work)
 
 	switch (serv_work->event) {
 	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
-		if (!gd->adev || gd->is_suspended)
+		if (gd->is_suspended)
 			break;
 
 		remove_adev(gd);
@@ -3684,8 +3688,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	cancel_delayed_work_sync(&ac->gf_stats_work);
 
 	/* adev currently doesn't support suspending, always remove it */
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
@@ -3774,8 +3777,7 @@ void mana_rdma_remove(struct gdma_dev *gd)
 	if (gc->service_wq)
 		flush_workqueue(gc->service_wq);
 
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	mana_gd_deregister_device(gd);
 }
-- 
2.43.0


