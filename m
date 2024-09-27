Return-Path: <linux-rdma+bounces-5138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3607988ABB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 21:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183B21C220DA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709631C2323;
	Fri, 27 Sep 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="W347u7uF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0508139D1B
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727465269; cv=none; b=c8ETk0Csl53ThJ5B9bmdG/Epvb7Y8v8mxQa53g7tYA5ott/pFeK/ChUiF+UWMP3gf7zoQetLmsEiu+1mpnHdt9Von65SWS5RRltTeEEhT689JgoM9rRpS9Lt8P9y3iB0qDynYnqXSE3qNi8oyOgGQAeI1Xa6BXq81O6pllI44ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727465269; c=relaxed/simple;
	bh=+6Z8zlYwsiNEwXds5k9H7KKtvVM+H5+chHKO7+K6B/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJu12G29y5pu2F/Qansxf60BWEOEB4wg/qpNloWdjlT+APzIcb8pZo71kJ2xNEm2OqEXfw2Un8RW1c+uPQIY/XXNHjCJ2rlVENkaaanz2pYU3trCjwYPUJ6+k56nYE+7HZH1tACNxKVssKJUr3qTFCUCPghe/dTWkQ4W0DpvTH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=W347u7uF; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id AC6561C2496
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 22:18:29 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1727464708; x=
	1728328709; bh=+6Z8zlYwsiNEwXds5k9H7KKtvVM+H5+chHKO7+K6B/Q=; b=W
	347u7uFRHrVhYkbN191d14BIydsN/RlynclndjmZ102V1KmLdiHbAGCELE2vXDWV
	DZ3ZPD2vfv/Do7c6MIqDTbVCgznn1xSvtWe62lAQUZVFCdZ9NZ8p7LfOy4ARCEMm
	W6VWwvMqNt2b04oac+CNCf7C40A+C4W6EwyE343vQs=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a34ME16U8DLg for <linux-rdma@vger.kernel.org>;
	Fri, 27 Sep 2024 22:18:28 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8EB3E1C0604;
	Fri, 27 Sep 2024 22:18:27 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: ichal Kalderon <mkalderon@marvell.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Ariel Elior <aelior@marvell.com>,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH] qedr/verbs: Add pd pointer null check
Date: Fri, 27 Sep 2024 22:18:18 +0300
Message-Id: <20240927191818.3576242-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible that a null pointer will be passed
to the qedr_set_common_qp_params function.
The patch adds a pointer check before dereferencing.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>

---
 drivers/infiniband/hw/qedr/verbs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 511c95bb3d01..09bb7fbe2bba 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2270,6 +2270,11 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (!pd) {
+		DP_ERR(dev, "create qp: pd is NULL\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	qedr_set_common_qp_params(dev, qp, pd, attrs);
 
 	if (attrs->qp_type == IB_QPT_GSI) {
-- 
2.30.2


