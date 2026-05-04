Return-Path: <linux-rdma+bounces-19931-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YH9+KZCv+GkPzAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19931-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:39:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D14BFD15
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AFBC3044462
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0E3E1D12;
	Mon,  4 May 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EKLzPc6F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3118A3E0C4C;
	Mon,  4 May 2026 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904827; cv=none; b=FT1p5+xri7W65gXdAlftgNsaqy6Us25UjQF4xAiuhBDDMwCeraXlE/5pJZGQgludzwDAwQpZ9CepXM/LpM2klBkNI5dz40odZI/GKy1MBbuNae2z2BqcHIdA/g8yDStUupLlu/O0Ocb5WdjsV/mSYJOaLylXx4iDAs6uslMLFH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904827; c=relaxed/simple;
	bh=CEQ2eJVlBY0MBBnYJPAwGrHd1dsTp96QIqY5diczfEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pwYh5MyU1hJ5JBdBGcD/v0NxlOErjZru3yIJAGohqhbh3QvmeznU14Fqr/DMPKc/M3iekk0Fj3Sg8WUDJp51DEx/2CC0QIF4g2UlS7xlRksoljEpd05gnAyHtsf19R7Z0GPazpTjb8NkIDS/xamZTpmCmGP1CyW1nyEuaeHvXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EKLzPc6F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1186)
	id 65F0920B7168; Mon,  4 May 2026 07:27:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65F0920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777904824;
	bh=kuovHcqF7R2ksxoktodkXKRikTI9yOb7xF6NJ5FrWvw=;
	h=From:To:Cc:Subject:Date:From;
	b=EKLzPc6Flk78IuMUi5gFVN4DO6mTCdEIxXSiCM+vwsAZsoB478VW0ybjB/hlAA5nF
	 ygHvCpzixElz68G7YW9TQGpkOeOCmbi7S+JJ78SpXvZSxxBBcaQmYR/IeWSsYiPi2Q
	 K4yk/kZcyqUQ2xuXkVSfOGF46UkUPld4p0GBYVY4=
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
Subject: [PATCH net v3] net/mana: Fix auxiliary device double-delete race
Date: Mon,  4 May 2026 07:27:04 -0700
Message-ID: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B8D14BFD15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19931-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@linux.microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

From: Shiraz Saleem <shirazsaleem@microsoft.com>

Make remove_adev() safe to call concurrently from the service reset
and PCI eject paths by using xchg() to atomically claim the adev
pointer. This prevents double auxiliary_device_delete/uninit when
hv_eject_device_work races with the service reset workqueue.

Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
---
v3: Separate the xchg() call from the variable declaration in remove_adev()
to avoid calling functions with side effects as variable initializers
v2: rebased on the latest net
 drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a654b3699..dd4f4215a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3465,14 +3465,19 @@ static void adev_release(struct device *dev)
 
 static void remove_adev(struct gdma_dev *gd)
 {
-	struct auxiliary_device *adev = gd->adev;
-	int id = adev->id;
+	struct auxiliary_device *adev;
+	int id;
+
+	adev = xchg(&gd->adev, NULL);
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
@@ -3538,7 +3543,7 @@ static void mana_rdma_service_handle(struct work_struct *work)
 
 	switch (serv_work->event) {
 	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
-		if (!gd->adev || gd->is_suspended)
+		if (gd->is_suspended)
 			break;
 
 		remove_adev(gd);
@@ -3753,8 +3758,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	cancel_delayed_work_sync(&ac->gf_stats_work);
 
 	/* adev currently doesn't support suspending, always remove it */
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	for (i = 0; i < ac->num_ports; i++) {
 		ndev = ac->ports[i];
@@ -3843,8 +3847,7 @@ void mana_rdma_remove(struct gdma_dev *gd)
 	if (gc->service_wq)
 		flush_workqueue(gc->service_wq);
 
-	if (gd->adev)
-		remove_adev(gd);
+	remove_adev(gd);
 
 	mana_gd_deregister_device(gd);
 }
-- 
2.43.0


