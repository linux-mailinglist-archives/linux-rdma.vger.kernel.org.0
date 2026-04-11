Return-Path: <linux-rdma+bounces-19233-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDu+F7lf2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19233-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C965B3E06DC
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A30305041F
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D7387359;
	Sat, 11 Apr 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="aoZpD9/d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE32475CF
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918968; cv=none; b=h5aM6KoBE7/AIH6zU9ZC4mUL/+WuKAACda55a6UApsh+fpDJpWrO9KtiPmDWP7dGL18Ut6QzEVeU98gPiUnBQGYKO3dNXezjLmuvOf5K+P4Co2lO/qhh5VkdL2xFuLK7Sp5JUCmiAkDOi9Qh+Z+afFN5LKZaHGysQvcI/0i/Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918968; c=relaxed/simple;
	bh=GpShu/vFNNIeBLzeS8lcNlpPfqwRPfJUXjTn4sNxN9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky9B8A0nOC5wr+OKt90J3oYYaXHwmMKUUL91HouJwz6HGfaKWLSlnK61lXFffnOOFEKHhA62EZ+qovP9dTYFLFILL/ER9lYAOFEaj0kOouyNt9DEvNxVyOt6lavxKnTPzmSEekcoifolgNvw3mAWIzkOgBmEp7cr2/3HjjL0jMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=aoZpD9/d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso48987245e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918966; x=1776523766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uZdzqhj1JYKAv3ACK7+q61KeHoIqJSyvbBqCOOY+k4=;
        b=aoZpD9/dcdmqCPrbsXyyTig/ORlKrs89Cagv2crpfO3A148/+eHCLYALK0IjWmUpl0
         HMHtsIiD9POGac+2P1x0CnMHrePmkMSLI6Ryxyslr6zApAO/ECxFkbhkGSw/Jmneb5Us
         6zZKGSml0uj3hJfllPzV3MouevjG6Eaun4qO14LPMz01xgu0fXVREIxGZG7f/cd2Gw1U
         SQT6eNa1UsMAg471KgEAO2AT/WqVcz/lfcjEHnh4QtghOUTk4glEg1Ur3jqKUm29JTn0
         k/hIRDqVHIf6FbQTPTQCYYaIBbJOou2vasJETyztdIEYNK6FxkUyun0hdC2RmFxts+0P
         GtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918966; x=1776523766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uZdzqhj1JYKAv3ACK7+q61KeHoIqJSyvbBqCOOY+k4=;
        b=Q/tkGO6PDgjT6lLqPLLAvvKUjQKOlRsDWPAt3/fanFnzDUzrORpgcHMahtnuL6UYD1
         QkEeshmVSHbFl03Ymy8vuIwr1V7DsjRcPqiiquJjVwJtJY6Mr8LyT/IIWBpvsbLmTTXD
         jwhjyJxbceuRUOGjmH4dJzn5ZgE9dBbD7r6VEdkoIfRWzZEO9iHS2dDhONHcVhCc2iuw
         gyUt/vqGfv2AXGlwOTSsQmX8F/2lSHHx0zXz40dVX/6fZl003n0oMVJ/0ScaPYxoelQE
         N1IhSIJkxZ27CyaZLMIP1zhy0sVO0S812kEI2CdRtU40v1SaUHiddIrN43ZDKosdES5u
         GahQ==
X-Gm-Message-State: AOJu0YwUrdLQkvNO6vxCd3SIvELwAeW5g5TS1PDsJLrSNWLFtEB0QFUK
	hdZy5DEcSiABUJgcZiQxsFhbBzFt47y6tGHSlnozVQ1ruFzzd3cmD16gp37XSKiJKcFNBTjJNB7
	bJ3yZ
X-Gm-Gg: AeBDiesFRRsu2jIR199XuIF9/lnLH70HkrfhcHZtsEQmDGmFkx6bMAlJjbfxuriNk63
	TlpN3lJKVzzFbhjPo2kZAhKpjJJQMul7jwRob6UctMFCY7utKslhEn8a40ifRgsAvGBN1TFzrs0
	QbQWMkkEn3rHQYavFSxoCxLhL9WoA4lONcthWGEyYyC46HFIxuTckY0xzviRfYTn0gyCs/PDz+f
	PKiSknZTHygBx3heRV9Olz6f52VD77dkX4SsOD7UNq6KEfX+LuSpMmfLbvrMkZ95LQgSVwqH3xx
	4EnO15Rs12Nk3I8qce4VsbT3eLsu9m/IZJZIa4NQ+cHH9WhBY68HHZ+ZXNIv2QAckLBVxDlyzG4
	vKuDEXEBxtA786IFbAuN9u6YHZLUR3PyLgSqv7T8vm8rMzPFbAwSkhF4iD79Qp8ng7CugQN//xF
	SCn5NaSoJ1SeazMa/BpGpjrhrvz07sZlH5z47Rmv3H5HM=
X-Received: by 2002:a05:600d:1:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488d67c720emr82471425e9.3.1775918965846;
        Sat, 11 Apr 2026 07:49:25 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm16732672f8f.24.2026.04.11.07.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:25 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 06/15] RDMA/bnxt_re: Use umem_list for user CQ buffer
Date: Sat, 11 Apr 2026 16:49:06 +0200
Message-ID: <20260411144915.114571-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19233-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C965B3E06DC
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
2.53.0


