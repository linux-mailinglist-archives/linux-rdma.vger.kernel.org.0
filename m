Return-Path: <linux-rdma+bounces-18625-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UALsID0DxGnOvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18625-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:46:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E695B328576
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7233142A8A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CEA401498;
	Wed, 25 Mar 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WQTjNxPW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9984A401494
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450862; cv=none; b=qi6Tj+t951Dkz83d5n7oF1FgzVvZBDYUFgBGPO3m+2E3MwX/GWmQAO8Gu6oMqwxmnESSDatM2HQqYuptqhJTOx3lI5Us99sudajr0jBoFF9TLyCAjAqaWVaT1R+t7087ohHiiH9I7pHlVwJyU+4Ahq9pqj7G9rqfh2VrOrUpRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450862; c=relaxed/simple;
	bh=OKuxl8nK8id/a4d2oC4n3uS/DUhGp+3YX80Oi3uA038=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnJmc/caWcvBjFHH3ssr6jMdpamwVWw0Ec/llKijcUlrPM/0Vt7VztoiyZiE2wdRhCB5vs4HPqUv7p/LRoiNiE0DWY0TShGpFXX/BCHBL1V4M4dwaSlMrEzTyUfwhVCV9nsur0FOt0PG3Ou2fDEUR/Ey/b4zwEtdGEfVF9s9t9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WQTjNxPW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-487035181a7so30261585e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450860; x=1775055660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRAYVemTcRekKZx5UEUJ2GAMg9yk7cb+HqPH9PPGl+E=;
        b=WQTjNxPW2QAyfdgmNPEeVs5qKJDJvvdrW01FBXSSnJX0iYPlb9wPbB52sFM2yQ0ugW
         HRibp300V5/I+363qA4Py+u9aUiz1XHHwLdFyY+lMXaaOcmvtFlwR6F6WeCBZHCDIiC4
         lL7lpQpX8WDcIZVEx3IiFJUeTSEDAdDfoYzm73WN9YJXOqUe2uwHlP7j5y/vPnv1gEGn
         pIqJ6DmJLF6oGedG/Il4iX7kqjZjlLp6NQekBTm5bcg+nrnTvC2HfLCeLJZzZpVg16/X
         FtpR22kqAoUSzJeMKlXeRHbY14V6Zn09uF4juiAVs4lXiGEmb5k+1w63foSs6G3vDyVU
         Phnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450860; x=1775055660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRAYVemTcRekKZx5UEUJ2GAMg9yk7cb+HqPH9PPGl+E=;
        b=LU6RdKIrAMAUZ/OfmkIaLgHNqAsGWEYPQcfOB2+GZekufMOG2mtDvJfBOFf1qCZysK
         shcNa2WmCHq8roZDZtPCi2c0tY4E8Zv/hd3sfCx8uPlgJXuiqCMkyotXtkrOrnFLk6yp
         qocD882UykeBECA3p5m23S1pm1MxNrT34ZrhBXkpTq29TZfzNMuPtCk6KvSVPszoSFYq
         7X6eSEEAMi1zibSgz4uDGiEcASCnGeOYhQpYCZs/pB2tGgRhFKHUqDG2UlbkniduYCDz
         CBXoirC9KemzE2nloK8N6Sk6B5UJO7UeWgjx1msfYMfitjOb9xHtbr26+vmJYQDekQ+1
         Nxyg==
X-Gm-Message-State: AOJu0Yxx9oxyRHOsiNFBC9Y06L+3s4dzwyPIzLy6DXk3zjpv//l8w6zb
	mmIgZkps1I1ri2F2TzdvHmUHY1O1AYpGG6nz7JRmcj/h74Ztm7oXR2vLOt1svQ95WxLMEVjx3ha
	l1SarxuY=
X-Gm-Gg: ATEYQzzlyUBT1GjCMcsRzO2pfu+i7p29Slr4ielwLss5D3QrOERls6/mfdQf9vD3S7y
	4FfBA+6IGHFU5b5jmcEbuVkxTEFAQ3uktN6CIbj0N9CKJ6u/f1bxhoyAdkHNp5Ot9Ba4yfRQ3N1
	APuOPbokuEpy86x6ZvKz5ZJd7uh4aBNy1C4JnkD3Q1eoqWVnHiK0iGEqHPvWjEIXzqQME+O0q64
	zITOPY4jmRSC/wyhJZxwhXwnQuFYo+YAM77t67MSjo9KcnQvJBak5pBEOZSHzY2oRpnJkUq5hjt
	A3Wy37CdHRQ7jTiUTz9Mz9n3OYEjJY4fOba+S26gYtTWIhIzuixtWvlxnrE7220ivkAjYRT6HjR
	akJgTbY6k3z3R8MqnRLe/ESpTaAZno8ZiCG6f5nAJfHCYxYV3w+x68QmLV3LBfAORBE2rdJlTR+
	CZvusz8JTkDjeluHq9W5gOjpsO
X-Received: by 2002:a05:600c:4685:b0:485:17a7:ba0d with SMTP id 5b1f17b1804b1-4871606cbcemr61183445e9.32.1774450859842;
        Wed, 25 Mar 2026 08:00:59 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487172f909asm32544675e9.6.2026.03.25.08.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:58 -0700 (PDT)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 06/15] RDMA/bnxt_re: Use umem_list for user CQ buffer
Date: Wed, 25 Mar 2026 16:00:39 +0100
Message-ID: <20260325150048.168341-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18625-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E695B328576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use ib_umem_list_load_or_get() and ib_umem_list_replace() to work
with umem instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 7ed294516b7e..5c6fc81fad6a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3379,6 +3379,7 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	struct bnxt_re_cq_req req;
 	int rc;
 	u32 active_cqs, entries;
+	struct ib_umem *umem;
 
 	if (attr->flags)
 		return -EOPNOTSUPP;
@@ -3402,15 +3403,14 @@ int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		entries = bnxt_re_init_depth(attr->cqe + 1,
 					     dev_attr->max_cq_wqes + 1, uctx);
 
-	if (!ibcq->umem) {
-		ibcq->umem = ib_umem_get(&rdev->ibdev, req.cq_va,
-					 entries * sizeof(struct cq_base),
-					 IB_ACCESS_LOCAL_WRITE);
-		if (IS_ERR(ibcq->umem))
-			return PTR_ERR(ibcq->umem);
-	}
+	umem = ib_umem_list_load_or_get(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+					&rdev->ibdev, req.cq_va,
+					entries * sizeof(struct cq_base),
+					IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem))
+		return PTR_ERR(umem);
 
-	rc = bnxt_re_setup_sginfo(rdev, ibcq->umem, &cq->qplib_cq.sg_info);
+	rc = bnxt_re_setup_sginfo(rdev, umem, &cq->qplib_cq.sg_info);
 	if (rc)
 		return rc;
 
@@ -3516,8 +3516,10 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
 
 	cq->qplib_cq.max_wqe = cq->resize_cqe;
 	if (cq->resize_umem) {
-		ib_umem_release(cq->ib_cq.umem);
+		ib_umem_list_replace(cq->ib_cq.umem_list, UVERBS_BUF_CQ_BUF,
+				     cq->resize_umem);
 		cq->ib_cq.umem = cq->resize_umem;
+		cq->qplib_cq.sg_info.umem = cq->resize_umem;
 		cq->resize_umem = NULL;
 		cq->resize_cqe = 0;
 	}
@@ -4113,7 +4115,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 	/* User CQ; the only processing we do is to
 	 * complete any pending CQ resize operation.
 	 */
-	if (cq->ib_cq.umem) {
+	if (ib_cq->uobject) {
 		if (cq->resize_umem)
 			bnxt_re_resize_cq_complete(cq);
 		return 0;
-- 
2.51.1


