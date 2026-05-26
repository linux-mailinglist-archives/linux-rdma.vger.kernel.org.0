Return-Path: <linux-rdma+bounces-21275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JGmH8FWFWpPUgcAu9opvQ
	(envelope-from <linux-rdma+bounces-21275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 10:16:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E4A5D2520
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D120B300B9F5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD53F3B6376;
	Tue, 26 May 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OueVxiIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C12FFF8B
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783358; cv=none; b=n29Up0nmJNfsAg6XNmkgFeTT3+i+blzVudeOwoRvUjdjwR8bIsbcNBP/MT4wsgjZvWBgq7tqH4EI6blIy+D8LCUbjsmcMYWlyOdwmkojA8YR8qGbN92m8hD/9hLXitmnEQp9ay79+bnIcACiNnhj0Pk2avd/JK7Ta7xvkokhts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783358; c=relaxed/simple;
	bh=fF4vvZ8uuDL6vM/xBpS89mo4qka3xdV/D6kpWEYMSPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJtpBBvZlVjuxQdY+5PYKiAyr5v1PAdfVug7lCUa0rmTmJfhFzLes/UAqcLrtkL7ZSMUzl0U2eFazwvQ4G5LWgtW9rogZdhAE0vDw/1odu5ZgOfzqgPJbigw+bbJGQo71hF8k+fT/oSlehI+YGKNBiHfwVsLONcTbVCF68eu7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OueVxiIY; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1779783357; x=1811319357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yxfQLJOD9aDALl9RRgcZj9Ipn9e/KRO/IJqtaAuGan8=;
  b=OueVxiIYgd2zF9FDJ+7+SJTX3DWw2SwOozfTIHkuIm5yIwZrzyF8GkUG
   9agcGaGAHvpB07sfeq9+ndHPerVKFJqP8gB6h2StOH/OLGJFxE3wIXBTU
   urROgbk5aG7j+o2C6NMivE4NzOnTGXwDJh/ThLvIYdqCFA/+TBxRmx0xg
   DiahZ4HqaxFMPENqteH9Y/p5bRns9q1kaJofLwBuMmKMRyxHtiB0OJsuB
   TK81zi3FBIVXcMPXPe9f1xSPYTUwvKOPRm59AjO38mirnfAE7HOs8QdHX
   ylqQLfX/ETpA+xVKGm1IxMgb/ydKrUVRYNKUweP3s5KEEyZhpu0mpmo9j
   w==;
X-CSE-ConnectionGUID: GLuK4DSpREiruSnYilQpUA==
X-CSE-MsgGUID: ILtKVZzvQZ+6+l4YPWeRVg==
X-IronPort-AV: E=Sophos;i="6.24,169,1774310400"; 
   d="scan'208";a="20485536"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:15:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:21290]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.130:2525] with esmtp (Farcaster)
 id 4ccd1ae2-c10f-4f03-8866-1265dd171d5a; Tue, 26 May 2026 08:15:54 +0000 (UTC)
X-Farcaster-Flow-ID: 4ccd1ae2-c10f-4f03-8866-1265dd171d5a
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 26 May 2026 08:15:52 +0000
Received: from dev-dsk-ynachum-1b-0ecf7b87.eu-west-1.amazon.com
 (10.13.226.176) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 26 May 2026
 08:15:50 +0000
From: Yonatan Nachum <ynachum@amazon.com>
To: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC: <mrgolin@amazon.com>, <sleybo@amazon.com>, <matua@amazon.com>,
	<gal.pressman@linux.dev>, Yonatan Nachum <ynachum@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Validate SQ ring size against max LLQ size
Date: Tue, 26 May 2026 08:15:36 +0000
Message-ID: <20260526081536.1203553-1-ynachum@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21275-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynachum@amazon.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[amazon.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18E4A5D2520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Validate the SQ ring size against the device's max LLQ size. This
ensures that when using 128-byte WQEs, userspace cannot exceed the queue
limits.

On create QP, userspace provides the SQ ring size (depth x WQE size)
which is validated against the max LLQ size.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Reviewed-by: Michael Margolin <mrgolin@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 395290ab0584..aa1a615bb341 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -598,7 +598,8 @@ static int qp_mmap_entries_setup(struct efa_qp *qp,
 }
 
 static int efa_qp_validate_cap(struct efa_dev *dev,
-			       struct ib_qp_init_attr *init_attr)
+			       struct ib_qp_init_attr *init_attr,
+			       u32 sq_ring_size)
 {
 	if (init_attr->cap.max_send_wr > dev->dev_attr.max_sq_depth) {
 		ibdev_dbg(&dev->ibdev,
@@ -607,6 +608,14 @@ static int efa_qp_validate_cap(struct efa_dev *dev,
 			  dev->dev_attr.max_sq_depth);
 		return -EINVAL;
 	}
+
+	if (sq_ring_size > dev->dev_attr.max_llq_size) {
+		ibdev_dbg(&dev->ibdev,
+			  "qp: requested sq ring size[%u] exceeds the max[%u]\n",
+			  sq_ring_size, dev->dev_attr.max_llq_size);
+		return -EINVAL;
+	}
+
 	if (init_attr->cap.max_recv_wr > dev->dev_attr.max_rq_depth) {
 		ibdev_dbg(&dev->ibdev,
 			  "qp: requested receive wr[%u] exceeds the max[%u]\n",
@@ -676,14 +685,6 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	ucontext = rdma_udata_to_drv_context(udata, struct efa_ucontext,
 					     ibucontext);
 
-	err = efa_qp_validate_cap(dev, init_attr);
-	if (err)
-		goto err_out;
-
-	err = efa_qp_validate_attr(dev, init_attr);
-	if (err)
-		goto err_out;
-
 	err = ib_copy_validate_udata_in_cm(udata, cmd, driver_qp_type, 0);
 	if (err)
 		goto err_out;
@@ -705,6 +706,14 @@ int efa_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		goto err_out;
 	}
 
+	err = efa_qp_validate_cap(dev, init_attr, cmd.sq_ring_size);
+	if (err)
+		goto err_out;
+
+	err = efa_qp_validate_attr(dev, init_attr);
+	if (err)
+		goto err_out;
+
 	create_qp_params.uarn = ucontext->uarn;
 	create_qp_params.pd = to_epd(ibqp->pd)->pdn;
 
-- 
2.50.1


