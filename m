Return-Path: <linux-rdma+bounces-16735-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDY7FUpni2kiUQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16735-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:13:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A742811DB2E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 18:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBE33308E529
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CD3EBF2E;
	Tue, 10 Feb 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUoRmeYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF03803FD
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770743327; cv=none; b=NuSydRC0K66Wb3GWSOUBUV8SpiPtSNY3VM+a42L4sS8NaV4SaEU2IkP9PRbIbaYop4fgLRU0sazPEErw+DzMVYCR64k8R3BqI0AVfg2+jNfArtk164A5esaSIvkqy4U+ktjaxAW1a/8/K/nO2VeCdfSnl2tlRWo3Dm6mS35hOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770743327; c=relaxed/simple;
	bh=ohBiXHd58kpU9ZftvYCZ4rq34SruNQcja+2Xtt01xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zxo0lQwsRH9eTC119xBeQZ8Ves3pwzsboREhcnhNRjyZryidaIhMuJhqUudmmt7vN6nEePP1Rklm7zcHAXa7jdHyQo4SQJyKiMVlZSI/tOZ0ydU5KdZlLAomesBV9942YCP3UBnd/5Ta3GXQJY/vU9fCU/HWLaTgE2PeKYpROT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WUoRmeYT; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8220bd582ddso769242b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770743326; x=1771348126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A0kOBvvkqLimiigHgVwG9HhriCqD/eTab/bxgezvIng=;
        b=euboKT/I8XEQyDGkLXW/wpI2CSKGjKImSZRguSZCwbuhT0h84nGzRMgym0C3ELa+7w
         23OGaXkaE/aEnNYhDWB7R+D34aREUnh2hPdxAVFqXo64bVlN4pVg+02Ut6lSkbQ8DD/A
         ieMbmdkolYo/9tYjlne5i66X4gMgUz788wBjgiW7As9adeI7SbJOQxPZV2hotrXq0nvM
         dx2J9kTb1QgHBZhDkWCRoKBiJtexy/rZTVKhevKn2KwYqVyexX774S7aMQdoCu7wY51R
         rmgKvoocLMvE0s6WC73l2Q5uW63Z+jdjp8VlLkflGN5L9Kc35bN+t9A+chvaJCHj9yI9
         KqpA==
X-Gm-Message-State: AOJu0YybbTK7A9/x1LtNXaNoOxPrMxiF4zqVgBDzM2xBub4UXhEITsze
	RB5VH18uLXXCE6YpjqOWfbOw5fJeVtomPXjv0MTQogZ7taYyhQsJCwNZ2MYfQW4/Yf7R/YoaJto
	j0xaIPAlifMyWZBJ0Ld/0sN6yObIs+uNF9YLK/AjxkzPo7ffp+CC8AoEaXscN6yJv9uwv8JtdaD
	z8YK/L0Hby39KJp1+2lqvmNtAzzh2jD3sfkURU41psH3pWgxq3ra9ZTYi2bM9W96vwOXa75qU0+
	CHMV4qhSZ9w1Garzwzz9kZPQWJY
X-Gm-Gg: AZuq6aJ+t68PbCDcyu4SvPjnhUVS0MLXb/yAJLMh4Kulgi5bvJHXybGleD3lEfxDJoI
	dH39I7qExOfy0zGVTb/c6qxUZW8btzcSxI4Y7IfAyyMcBgM97XeMF4Bnt4kMjkq0O9Suv2Wjy6J
	eKx6600juH0Nrj5JwXWBuW/1tL8ghP2jZM91dor7k1TKxLlHZ8USfV0diX3czI576VKMod8jIls
	0SRjGvz2nioOM6pmljMLDGrrkfDpbpoc+8YfW0htynuWl4koXKUZ2Z4+iCLSUqEmruk+wgR45Fn
	Q2XjOik2FSKYh1gTcNnU6XLH1r3z1Xo3PkH3YjVnmUJtW9JdB8NHaIwn0O9nYxd9cLtlHTNPma4
	0ZUu1BuFKtXR/8zghoM8/0v73HMqOoRKZ2Xlaxd9BALajuGbtCmgg10oZd0GMOlcmxPqu5ZOL1C
	u2l6TxjGMOpfGqY6DU+EaWCn7UZm9gXSocKBSaZf0SapTlGtM9bd9TDWqUt7hebU2Ik47E
X-Received: by 2002:a05:6a20:431c:b0:35f:b96d:af06 with SMTP id adf61e73a8af0-393acf88d68mr14182050637.14.1770743325645;
        Tue, 10 Feb 2026 09:08:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6dcb641467sm1083274a12.10.2026.02.10.09.08.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2026 09:08:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82451f11c4dso560955b3a.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770743324; x=1771348124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0kOBvvkqLimiigHgVwG9HhriCqD/eTab/bxgezvIng=;
        b=WUoRmeYT9kWj1pRGY0QeIqCrQFsLn4xTxOCBCSK1ssN703Nu1uT3Y8b/DvmBfqgmbi
         sG/Ya10zoPDr8Utckuo266nwNi0knv3VdfF864fJ7WcEEHeQkz6+IzQlrpfDZArN/QKm
         pxuva7yq3SUDoJ4nc6hBW1H7OPOJSZld0/92k=
X-Received: by 2002:a05:6a00:1395:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-8244172ba54mr13919244b3a.48.1770743323841;
        Tue, 10 Feb 2026 09:08:43 -0800 (PST)
X-Received: by 2002:a05:6a00:1395:b0:81a:b602:daf6 with SMTP id d2e1a72fcca58-8244172ba54mr13919222b3a.48.1770743323305;
        Tue, 10 Feb 2026 09:08:43 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f269sm15620806b3a.7.2026.02.10.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:08:42 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v11 6/6] RDMA/bnxt_re: Support application specific CQs
Date: Tue, 10 Feb 2026 22:29:39 +0530
Message-ID: <20260210165939.41625-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
References: <20260210165939.41625-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16735-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A742811DB2E
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ++++++++++++++----
 include/uapi/rdma/bnxt_re-abi.h          |  2 ++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index dc73f0072528..04588b4f79c0 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3372,6 +3372,9 @@ static int bnxt_re_setup_sginfo(struct bnxt_re_dev *rdev,
 	return 0;
 }
 
+static u64 bnxt_re_cq_cmask_supported = (BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT |
+					 BNXT_RE_CQ_APP_ALLOC_ENABLE);
+
 int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			   struct ib_umem *umem, struct uverbs_attr_bundle *attrs)
 {
@@ -3382,6 +3385,7 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_qplib_chip_ctx *cctx;
+	struct bnxt_re_cq_req req = {};
 	int cqe = attr->cqe;
 	int rc, entries;
 	u32 active_cqs;
@@ -3404,11 +3408,17 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 		entries = dev_attr->max_cq_wqes + 1;
 
 	if (udata) {
-		struct bnxt_re_cq_req req;
+		rc = ib_copy_validate_udata_in_cm(udata, req, cq_handle,
+						  bnxt_re_cq_cmask_supported);
+		if (rc) {
+			ibdev_dbg(&rdev->ibdev,
+				  "CQ udata validation failed: %d comp_mask: 0x%llx supported: 0x%llx\n",
+				  -rc, req.comp_mask, bnxt_re_cq_cmask_supported);
+			return rc;
+		}
 
-		rc = ib_copy_validate_udata_in(udata, req, cq_handle);
-		if (rc)
-			goto fail;
+		if (req.comp_mask & BNXT_RE_CQ_APP_ALLOC_ENABLE)
+			entries = cqe;
 
 		if (umem) {
 			cq->umem = umem;
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 1f7685665db1..26eeb78193fa 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -103,10 +103,12 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
 };
 
 enum bnxt_re_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
+	BNXT_RE_CQ_APP_ALLOC_ENABLE = 0x2,
 };
 
 struct bnxt_re_cq_resp {
-- 
2.51.2.636.ga99f379adf


