Return-Path: <linux-rdma+bounces-5529-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE59B1640
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 10:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C7E282F9D
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Oct 2024 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7491189916;
	Sat, 26 Oct 2024 08:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QMbOoEkH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CE1632D3;
	Sat, 26 Oct 2024 08:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930205; cv=none; b=g4AUOUA4PpVp5Y5maqFD+Ijltrv5X2LQl6XAaJkmdGkgtVi1VO0RyDRnHp79wrvczsVfS3cWnJsQiEQBUjULRWYwR8NKYgBLpAl+oDJIFTvt8lwnkGgqbjzRMURGpzNtdm2fpfq+dXPIp7/dmHUKPtOePqs60Q6MFC0eZuA3hEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930205; c=relaxed/simple;
	bh=roMrdDhWbQ7oiH7wmvK8cHSGZYmjLemzi0RKbT3G3RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXfX5zLCprokplpY+m7vbWbPFTEDtfUg2TAvuL6kT+yOksWDtWoIyzf1puG2e+bXxApp6VYk5DKcstInkcSiIPxZjHYGfkxjUlKvXlkyZ7gUPDyBJtQPUL65cVIpk8DChOmzJAWiXrX7zebyDHcKcqo9qaGx1uVjV+uiFMb/JsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QMbOoEkH; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 4brttJTpvLmOL4brttUbV9; Sat, 26 Oct 2024 10:09:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729930194;
	bh=UszODcSUisBsMEcSbF3Qc7T3xxScluRVwcisiRg5FVs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QMbOoEkHHFvEPGDvhGNYyCK4U5d3MFkzNZm25BE1w0bhTKLz8a1L2eRVCQd9CJRYK
	 Yz/DPQKoynVxk/4U+72ZjuVoSZ2dTMd4VtsPAZf6hDPuphY3QpFd78Av79XPpZPk14
	 Vcwnc3iZKT/ajES6D6F/GbDXhkBpOTYjOU++VO5hjxH9Bt7boM626KvXQSagi48/SH
	 w6IzjeLVb/xrsRqvj4+52XW30H0mpgpQL1nM2PHvNw0IHzR5b84Fb5kNWaud4CrR1F
	 JYcnRPnH22QMkyD50C8fybE7CczlcfB0nfURw2VYzJ7E2u9MCrVpTN392GjyrhLvRc
	 cqnX8g2uFnq3w==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 26 Oct 2024 10:09:54 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH 1/2] RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
Date: Sat, 26 Oct 2024 10:09:42 +0200
Message-ID: <580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bnxt_re_add_device() fails, 'en_info' still needs to be freed. This is
done in bnxt_re_remove() with the needed locking.

The commit in Fixes: in-correctly removed this call, certainly because it
was expecting the .remove() function was called anyway. But if the probe
fails, the remove function is not called.

To fix this memory leak, partly revert this patch and restore the explicit
call to the remove function in the error handling path of the probe.

Fixes: a5e099e0c464 ("RDMA/bnxt_re: Fix an error path in bnxt_re_add_device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only


Another solution, maybe more elegant, would be only call kfree() in the
error handling path. In fact locking and the other stuff in the remove
look useless in this specific case.
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6715c96a3eee..d183e293ec96 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2025,7 +2025,15 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, en_info);
 
 	rc = bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
+	if (rc)
+		goto err;
 	mutex_unlock(&bnxt_re_mutex);
+	return 0;
+
+err:
+	mutex_unlock(&bnxt_re_mutex);
+	bnxt_re_remove(adev);
+
 	return rc;
 }
 
-- 
2.47.0


