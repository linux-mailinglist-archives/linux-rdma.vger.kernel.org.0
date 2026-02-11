Return-Path: <linux-rdma+bounces-16760-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJS9MvN8jGkcpgAAu9opvQ
	(envelope-from <linux-rdma+bounces-16760-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 868591249BE
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEAEA3019837
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7059936BCF5;
	Wed, 11 Feb 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A6ULBV22"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976D367F39
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814701; cv=none; b=Z9eCquRDNnIt9ht5VTExh9xDnaoWghGJkc8Jxqo2QrT8RewEY2fSG2g4hrEc4vDIrVaTr0yOxB8uxCvkAW/mn3LDQxweXnz7x9A2w3Yvjwc3ofo4/9s42nwJWEYxDbobIWrqn8Pi6IjxPp3bBnASdTvOHBQaoycy9T0WJdnbBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814701; c=relaxed/simple;
	bh=tCwlJFxaT5Z6JHV4th/5TJ/al7ALOFSuG4tnNwh6r30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/+4+zhPkt5zPvaXkaxYwKdX0m1wNcr9FyuDb4319yra1JrIMYD9dt1NqFRZGSMXgan65P/KDc1vu8ONv0E1GMcnsI9YmjBwMojTX973Y0spIsBYAtNmEo4EkuiTQJNJ4GvRNWJgr+WhmpTTYLfkvaE+o2mudH+y//MzZybfZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A6ULBV22; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7945838691aso11815477b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814699; x=1771419499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItJJ+/T0460JQetHEIqhEsGPdfwTigQjqYsfsdHXRq8=;
        b=IZ/gI+IvQVNaDajNM3R+qxajCCN9q298YGJZarqWN6+cIO4Quqa6Xb1JAYXzzVzLgy
         XxZWuHrQAOzYY9S4CZ3m38AE8IDNeRoKvznx5W2DsIsIvLtExgEVXqPMHd3BmldKGCUe
         hmlTK3hKChbuPPjpIRika6imfrU5vt5n5ryoZ79iIRbdmcR1jevs/DZeWExVtrlXZp7H
         /3w3aKkqO60LzbVouj/lcz6dU1lJNTvB8wD5Es7zkwDhi2g8PIjba05vrGGsZQwKe41F
         Ab6gBzq9PCbOOuzDsgpDLIzOozSFXoncKftJnZAS9OGo38PN7eyKP37S1J05xBxZO3Ii
         pEwA==
X-Gm-Message-State: AOJu0YwUlzkcg28ifYYrZlfQhhASm5EKxY8jsWq4yzY9yfr+VSIDmkZG
	xyjNOfVnZVmC9+yUymfL4gNjYeaT9qhsUmrI2Zdfby87zdNq+kUsyrdpi2ZnfcQSJzh9uqbdk7M
	s6UG/jGy3IeIn/rujbNh6zAsdHofhSt8rTgSUXWutFt7DHYj/CjM5NvP42hD7EUWa6ZlqiVSK8+
	JZER1t+Sz04JFI2Ly12IFXvBgoYFOcOKjy5LlX6Ei6dyslqj0t5CtwkxH1hetyRvKnbOSDF6RwJ
	HLlUsiiAWKbu9m9YiWVHp3zvfJt
X-Gm-Gg: AZuq6aKS2MFvG5UP2ntwPi1l3pM6E/rt+2x9LasnseJlsMQoA3/ts4TspSOd1wD44rZ
	1ICsfv5s3Y+igKSX4Ev7ZE/Gq/goBTQyRMyUHRIsau7hyuCPp3stGctvLd4NZOngHveeSA5upkJ
	VFsqK33L/PwZNB49PRiblMiE83MNtiJdEaIM5yDwsa8uAVLMEE+0AR+RZEXmIywHi8/g3Wr7SSE
	4qRXdjVRQfVZKMRqJfQIRZ8/1VKqOE4hCIgdebW8S75zwZrKKldW/RRDaJkqCgZSzTozBZRV9Qs
	lPAzqmCbIs6iLfxu0m2osp5SSKuQzuRvytzHuzrHL6u3Z07yFYarlNFVV/PRJKJuneCIl5rKIUY
	YZI20yv+9BjKziEv5bIsXll1EgRRsYHaxXdoiIz/cbZJtPc32O5RUMUNswWqpJgg7rpsXoR4cJ7
	5w6Ahpxu5aWx9Rb9DZq4lUzSupo4th8q86EzhdxMOMXdZt30gqnPzus5lgN5bli+TIn7+5
X-Received: by 2002:a05:690c:22c6:b0:794:e22e:20e2 with SMTP id 00721157ae682-7965e2924e5mr44164337b3.28.1770814699012;
        Wed, 11 Feb 2026 04:58:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c24cb57sm1654267b3.25.2026.02.11.04.58.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2026 04:58:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c68b97c0adeso546543a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770814698; x=1771419498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItJJ+/T0460JQetHEIqhEsGPdfwTigQjqYsfsdHXRq8=;
        b=A6ULBV22jC7UqqJ3rH9yceO9Fu1XurDFZmxsYurFWfcpI5U6WxdakKNtDJq3FlDyU8
         yFJYmae1dXv/bZ5AT/AotSCYHsgh3W5cgkPEK6Mk8oUCtIUGH5nu3o3eQR2T8VUKFhJ4
         Av1/VJh9bzG8+3B6vpTdiLnLyjQw868gteD+E=
X-Received: by 2002:a05:6a20:12c3:b0:342:2a1b:870f with SMTP id adf61e73a8af0-39415c37389mr5652994637.20.1770814697601;
        Wed, 11 Feb 2026 04:58:17 -0800 (PST)
X-Received: by 2002:a05:6a20:12c3:b0:342:2a1b:870f with SMTP id adf61e73a8af0-39415c37389mr5652983637.20.1770814697213;
        Wed, 11 Feb 2026 04:58:17 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab299983d0sm22206515ad.79.2026.02.11.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:58:16 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v12 6/6] RDMA/bnxt_re: Support application specific CQs
Date: Wed, 11 Feb 2026 18:19:27 +0530
Message-ID: <20260211124927.57617-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
References: <20260211124927.57617-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16760-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 868591249BE
X-Rspamd-Action: no action

This patch supports application allocated memory for CQs.

The application allocates and manages the CQs directly. To support
this, the driver exports a new comp_mask to indicate direct control
of the CQ. When this comp_mask bit is set in the ureq, the driver
maps this application allocated CQ memory into hardware. As the
application manages this memory, the CQ depth ('cqe') passed by it
must be used as is and the driver shouldn't update it.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 9 ++++++---
 include/uapi/rdma/bnxt_re-abi.h          | 7 ++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 30aefbd0112e..46850e92bbf8 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3378,6 +3378,7 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_req req;
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3400,12 +3401,14 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		entries = dev_attr->max_cq_wqes + 1;
 
 	if (udata) {
-		struct bnxt_re_cq_req req;
-
-		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+		rc = ib_copy_validate_udata_in_cm(udata, req, cq_handle,
+						  BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE);
 		if (rc)
 			goto fail;
 
+		if (req.comp_mask & BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE)
+			entries = cqe;
+
 		if (umem) {
 			cq->umem = umem;
 		} else {
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 1f7685665db1..0f631c65c63d 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -103,12 +103,17 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
 };
 
-enum bnxt_re_cq_mask {
+enum bnxt_re_resp_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
 };
 
+enum bnxt_re_req_cq_mask {
+	BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE = 0x1,
+};
+
 struct bnxt_re_cq_resp {
 	__u32 cqid;
 	__u32 tail;
-- 
2.51.2.636.ga99f379adf


