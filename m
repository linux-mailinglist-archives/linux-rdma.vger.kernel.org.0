Return-Path: <linux-rdma+bounces-5700-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E4D9B9503
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DC1F1F20FB7
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836651CACF8;
	Fri,  1 Nov 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="cBKXzMSC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09E1C9DF9;
	Fri,  1 Nov 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477552; cv=none; b=oDAPnJHijvfj3vTRam4CuQcoe5aBQ81oy3wf9rV3woHaIO/AIEZNWVrXnFgYEZAOeARL2+gJPT1mzdoks9WbOe7gexUdffhVEDFjk48Jl43ffYzzLr5o2jrIIsRgprTy7mFo3WD2kF4U/YOSe/X06DLxFaN+vS0EgmtUaynDvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477552; c=relaxed/simple;
	bh=ZdNtmwhmE4Sfo8kJ135RuDz63vpJTWBG4/q2lu1G/j0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOUFRXPl3ubmFxP/k1j+CshxvMhQrTI81Zuf0a9xIu+grpgPj4qU0Ui7T/wR5i19GwGL7pAuDd/SJfdWbEbFYES2o8FcDmYpmHQipy6lA3BX8DDX8jp1pfpljTTgfzWSLZBRIzIASuDNno1zmuKyP/IrbcQlIsuJx8U1rUcCfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=cBKXzMSC; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 6uEutykeYoG5N6uEutJmjq; Fri, 01 Nov 2024 17:11:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730477469;
	bh=wPMa1eF3oU3GrJIfNJgQ+4u1f7TLWzdyiv5eXacAmhE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cBKXzMSCK4fF5GcjbHlogDm9Vgf5AmTPoLOK28CixExetCFELJjqXx7ZSgvPwjj8E
	 diKcDtPPgm56/knHDqMtiTSlkIxlbxjHfmWVLtK6JjOsL+BA/4W/XMVxTAAZFzAuqG
	 jbwhbUV2VHT649/piuW1lAcSIcYWxVc35ngvFJXGc1LNwHSmgvVNZ/EjnukfPT2SyY
	 +IC5Ux4CZIPv5x/POMhUc/Zlx7YbLu1kgRjYUNZNiuhiykkBL4iBJWeDm3oPIiLfU6
	 iXfNNvK08FJMIxgXfV9uwmEywhGPVIy/ZAL/bLswNMSfIVxDlD0yr8o3RzCh+Gvzpo
	 s+W2HkCbZa5vw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Nov 2024 17:11:09 +0100
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
Subject: [PATCH v2 1/2] RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
Date: Fri,  1 Nov 2024 17:10:56 +0100
Message-ID: <9e48ff955ae55fc39a9eb1eb590d374539eab5ba.1730477345.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bnxt_re_add_device() fails, 'en_info' still needs to be freed, as
already done in the .remove() function.

The commit in Fixes incorrectly removed this call, certainly because it
was expecting the .remove() function was called anyway. But if the probe
fails, the remove function is not called.

There is no need to call bnxt_re_remove() as it was done before, kfree()
is enough.

Fixes: a5e099e0c464 ("RDMA/bnxt_re: Fix an error path in bnxt_re_add_device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only

Changes in v2:
  - use kfree() instead of calling bnxt_re_remove()

v1: https://lore.kernel.org/all/580de136ad9b85b0d70709e912cfddd21b7e3f6f.1729930153.git.christophe.jaillet@wanadoo.fr/
---
 drivers/infiniband/hw/bnxt_re/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6715c96a3eee..465cec4a1bd4 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2025,7 +2025,15 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 	auxiliary_set_drvdata(adev, en_info);
 
 	rc = bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
+	if (rc)
+		goto err;
+	mutex_unlock(&bnxt_re_mutex);
+	return 0;
+
+err:
 	mutex_unlock(&bnxt_re_mutex);
+	kfree(en_info);
+
 	return rc;
 }
 
-- 
2.47.0


