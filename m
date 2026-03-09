Return-Path: <linux-rdma+bounces-17803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOOlK3ACr2lmLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:25:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AED23D9D1
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 18:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3EB930062FA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 17:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20323E5ED7;
	Mon,  9 Mar 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gEyoWxGv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D53A9D96;
	Mon,  9 Mar 2026 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077056; cv=none; b=AiwU5Ncl2GD45g083GOCnt1zIYWLZa60HCbSA81pn1RRqs0M6qoysywunk2MW7vSPOL8GG1z0JWo+ErjbHPRuAQbbZbsB386Lwo5dLCIMmHU+Z8QiTQK5pZWYqD7UflvFXVIjCIpiY4Vw7KJwN3oYwuFepz9azagWaUZr1beU6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077056; c=relaxed/simple;
	bh=TEA8Z1RMhIwJ8rfPk95lzlqXvQpSV+OtRGw70HkcJsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fhfl2qxY1zMp5Kc40Cp2c9aIvjaITxzAR7f7AoblugOR1lE9JT2dcHhALGcd2439HELyBNdgLa1jxJS80tv2XxOSVAUNJ/1BYUehRrtm3GK5O6NryvMXTgDW4j1SW29vLVPqLDMHJK04sGAysAWO+ZdpsIWWtrefSCjS8n3tuTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gEyoWxGv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 4ABFB20B6F00; Mon,  9 Mar 2026 10:24:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4ABFB20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773077055;
	bh=5s6WGcMrd8sS9dHOP8IAPUR7V2j7zATVSCb/pL5az3o=;
	h=From:To:Cc:Subject:Date:From;
	b=gEyoWxGv8x939KBkROM0w022bYdrOeJV4D/ibJXhQIPLMENSApEHILtAAB3YfLgC9
	 vTPPkCPI/rapoLCPsmYZVDqOeMjRuFLUfCpSeHCrveDf1iT3gyWIfq99fYgWTgTgaJ
	 d0PuuJJxVxZh5bUTA4UHCWKSiySYOknmXjmqtMhQ=
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
Subject: [PATCH net] net/mana: Fix auxiliary device double-delete race
Date: Mon,  9 Mar 2026 10:24:15 -0700
Message-ID: <20260309172415.688342-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68AED23D9D1
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
	TAGGED_FROM(0.00)[bounces-17803-lists,linux-rdma=lfdr.de];
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

Make remove_adev() safe to call concurrently from the service reset
and PCI eject paths by using xchg() to atomically claim the adev
pointer. This prevents double auxiliary_device_delete/uninit when
hv_eject_device_work races with the service reset workqueue.

Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9b5a72a..c45a66e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3402,14 +3402,18 @@ static void adev_release(struct device *dev)
 
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
@@ -3473,7 +3477,7 @@ static void mana_rdma_service_handle(struct work_struct *work)
 
 	switch (serv_work->event) {
 	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
-		if (!gd->adev || gd->is_suspended)
+		if (gd->is_suspended)
 			break;
 
 		remove_adev(gd);
@@ -3676,8 +3680,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	cancel_delayed_work_sync(&ac->gf_stats_work);
 
 	/* adev currently doesn't support suspending, always remove it */
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
@@ -3764,8 +3767,7 @@ void mana_rdma_remove(struct gdma_dev *gd)
 	WRITE_ONCE(gd->rdma_teardown, true);
 	flush_workqueue(gc->service_wq);
 
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	mana_gd_deregister_device(gd);
 }
-- 
2.43.0


