Return-Path: <linux-rdma+bounces-20818-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGpWCIRgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20818-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0155F7C2
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05A0F3008D41
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC623E320;
	Sun, 17 May 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xk4PxkNd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F75223702
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999421; cv=none; b=idT7wb0V1IdstjlmDu2rJTMpP31do3KTfAthpO4hWJ+9TJHEvrl7FdfIIpLrr27RtoH2OMdCmkChDYQL75K+FeMUy3ilQm1mqV8M69qPhlIwB7Tuoufv3twYfNGt43i110xY4SJg3r3MnsUU5mFBuMEKBE55Tb5eF88qxSUznAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999421; c=relaxed/simple;
	bh=7+6y5cGf89GqucibQyhP4+uj4qAYP9wV3lS1aGLuZp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owDOULU61AMiRn5o/i4VVvfWAr7ui6R2GFSuTVVeINApKDZggXGLYkhruWWRNQqlR1QfUimfmOVEnDwi8U9RnvVmWFCYAn1Dpj4ojdH60v+gG528D1V3XQXysEmGVtG9Mw+tdzfz+U6fSAosj2SlVrn1xeqZfR2u2NLbFa2mAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xk4PxkNd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso14324665e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999418; x=1779604218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ippWZo9nATu+IojNwpqtgatP0iAwhHO9Sa3cpIhx6B0=;
        b=xk4PxkNdaoCISCdVM+KjwcTygNarl/e2efr6RfoDsh7RAXNSGAwzE73s6Nd+YXLL5C
         BC8lEPm1MDsMk0Yw+q2qafB3x8qlcCaS49/jA7HKifxWk1AAVTj5ulWC/J0BQaYG4qtR
         sZyOpOYfyM7Q/7qBXeFU+dAzX0hyCQm0NOYb382j543EyAxzW/8i3jhR8FVZABpc1Flc
         kihGypKrp7OvJqyUQxpP71fzqQH1ZjuA2Nom7TvNPFyup8mZ5qHR6LglIUX5z+isrqvR
         zGNGE22aFEgXVKP+JyB4GOD5YPsZnAC6r7fg9vBcEMtAvwRDkIkecfpKV9DxbCwS91LX
         pEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999418; x=1779604218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ippWZo9nATu+IojNwpqtgatP0iAwhHO9Sa3cpIhx6B0=;
        b=o6g7KDl9w9BYQS7V+xK+nxbzpquTJjFglg6yhnPyuR+Rr7AzNvUZ6Gm2pQroqX5/0C
         1bguTvmmal7h6/pv1BwFgtqf+uGhTkVSONlslDPqpCz/O1xO2gI8UcECa3qr3ZeaPpVJ
         ltL2v9iOwlFBSAS1MJzQUOrbOerSwUIruTvqj8gwlYFH1p5qHLXDpYYOiRCfFzd35i4b
         VMfzJx3VRbY3gII7oJFd1HKhAU4HLHNU5WkHEPH2nD6lcqiq/3qrWJFdGyqk13USizqn
         u8WABmiz6DMSvJwE49WwpOpzh7i7STfyueknLD0hL/rpve4D2XmyzAW39EgbVs5ZEK7d
         vyCQ==
X-Gm-Message-State: AOJu0Yy0ZVJdxzTI+U8lgmIKo/0BE9U1g+U5R3CycUL+qVYdRMI+iCJw
	Ym580FUd16g0CSFKYffz2+XLzWSQFu/MkGUpBxJOTk+izpwdOrpTu2O2a8Mix02K/H3tuGT3Bvt
	q+DzPNonReqDf
X-Gm-Gg: Acq92OEN2OiLcU0b7WaqhsWkrE67OthYVlJ6iK+T6wBSTI7/uL+eO2bsmHe+nZzxcYu
	pxHli8op47rKO/j920U5oIJl3ZboIzzQpRQWyTwOjf6NRhetI/DBnX/KsF41gHudvRIoSOUWp2u
	49AiK1zwcV9TLsuXXMx1ZBCa8pgP3jtwFzEOtyCMr/KG6LvAt0i6luEvDM+s60jOU2t8vo6FaWC
	VFFG5gOXTbsTJElVJ7cKX9dngx+JisAcgEBsIeuAFOnCmAkm5Ha4mUmlmymdXzs4/pE50gRHPwj
	SqRCc03fC/qKB5AkOHfNp5zajh5lmEg2rJK12h/umf5pTgH1rPmIE2V28y6UWaBh6Xj/vkaZ9KC
	jcxk56Dv8PpHISEiP2gLtiCPjk6t9zhN9f7vP4sGMmo3OnPqpfoDWEAvT3wQQJjvArL7qhMSuVT
	egLkOYx7pqkRHVa/QpUjZIQok7D5vvnpmzJwzxu8mk/YYHFw==
X-Received: by 2002:a05:600c:82c3:b0:490:778:4fe4 with SMTP id 5b1f17b1804b1-49007785080mr11725415e9.26.1778999418549;
        Sat, 16 May 2026 23:30:18 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm175398095e9.3.2026.05.16.23.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:18 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v5 07/15] RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
Date: Sun, 17 May 2026 08:29:58 +0200
Message-ID: <20260517063006.2200680-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8C0155F7C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20818-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Pin the user CQ buffer with ib_umem_get_cq_buf() and take
ownership of the umem in the driver. Fall back to the
existing kernel-DMA path on NULL.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
- replaced ib_umem_release_non_listed() with ib_umem_release()
- added release to efa_destroy_cq() and new error path
---
 drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index e103d1654a69..aebae70b882c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1072,6 +1072,7 @@ int efa_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size, DMA_FROM_DEVICE);
+	ib_umem_release(cq->umem);
 	return 0;
 }
 
@@ -1124,6 +1125,7 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct efa_ibv_create_cq cmd;
 	struct efa_cq *cq = to_ecq(ibcq);
 	int entries = attr->cqe;
+	struct ib_umem *umem;
 	bool set_src_addr;
 	int err;
 
@@ -1172,26 +1174,29 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->ucontext = ucontext;
 	cq->size = PAGE_ALIGN(cmd.cq_entry_size * entries * cmd.num_sub_cqs);
 
-	if (ibcq->umem) {
-		if (ibcq->umem->length < cq->size) {
-			ibdev_dbg(&dev->ibdev, "External memory too small\n");
-			err = -EINVAL;
-			goto err_out;
-		}
+	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
+				  IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
+		goto err_out;
+	}
+
+	cq->umem = umem;
 
-		if (!ib_umem_is_contiguous(ibcq->umem)) {
+	if (umem) {
+		if (!ib_umem_is_contiguous(umem)) {
 			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
 			err = -EINVAL;
-			goto err_out;
+			goto err_release_umem;
 		}
 
-		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
+		cq->dma_addr = ib_umem_start_dma_addr(umem);
 	} else {
 		cq->cpu_addr = efa_zalloc_mapped(dev, &cq->dma_addr, cq->size,
 						 DMA_FROM_DEVICE);
 		if (!cq->cpu_addr) {
 			err = -ENOMEM;
-			goto err_out;
+			goto err_release_umem;
 		}
 	}
 
@@ -1262,6 +1267,8 @@ int efa_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	if (cq->cpu_addr)
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
+err_release_umem:
+	ib_umem_release(cq->umem);
 err_out:
 	atomic64_inc(&dev->stats.create_cq_err);
 	return err;
-- 
2.54.0


