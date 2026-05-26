Return-Path: <linux-rdma+bounces-21316-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGQICf6zFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21316-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:53:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104F5D803B
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06043173CC0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE1405C35;
	Tue, 26 May 2026 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ixm6RJAH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F027405840
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806562; cv=none; b=TXXR4bwdN9y4rVe2WuRV3c1TxjcD+ZRc8/Ogfy7IjfDYiQERQBidfdKP5CGuwhbzdvfZfPopyQXLtVouKd0RmiAOhf/ZTTyYbIMgjnaGSiFrusCjzf10noT2fqpLTDLh/nMUOMxuxC9lKPDw001KmdJGHN05wqr/T6elqLsVBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806562; c=relaxed/simple;
	bh=+wL1FcN1eICk2dnt8zTL2y63dZGFrP9K3uAsYbtQs3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5bAfM3JGWgV9i/L2SmoKz+2WwdUhQKuyiEvwRFfRvXGVxnjQw5XKBddZfoAUmN192oA+mg4wdugNNCsgtvpCHl+nj8d0d+9i/W42RAxFhbwAXNrTqQ5cIN3e0y64pAb7+fOEtMFQ9o29BffpuCLtN40gRGg+I0H3ly2m0PXU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ixm6RJAH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so43460425e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806559; x=1780411359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=ixm6RJAHN7YTghG4v/IO5LkABQh+uc0s1qyBaE5CvtRr5RFxjYQUweO6T0nme1jbfn
         TfSjtceEz/2OorLZe6nvG+J6KGZgTz6bY/M7KGVxfPlZtciLl1oJmF3GHpg6wbTqd/vA
         yJ3+rTufj0qC+VAxdm+8uUm7y5BMlNNamEP2ADTOnHB+p3+0PWotFJmBR81rl2y0DLF0
         Jh7XJ0X07Mq8NMTZVOMz/oWdsueYkGpvEI/MM1AVKBMFK6owOsua9CJMIIuskZK/X10d
         SMgNd36/K2GoRw1VnvvyHQAgS+rUJbG8G3spfg0iwsYHF44aU1dnQmwmlhlXBpHEp19t
         OOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806559; x=1780411359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=nQf6x9OddiArP8zi3ZD+P0s6mwm0dDbJXA8NzvFMsaSol7SwCElZq+o11SUV2mCboJ
         jJOi3R5zoZyiIaNcTK3FEPQq0o2K/5dX6fFhI+o3vNTM4lXO6ebxxVxGKXG9IW9kbWlc
         ++staXjgMGLet9MyTIoYGy7jkdjT1AW1xlrz0zTKzUpLzLAVpyOZlA37TjKA/C6WAVHS
         N9WM6Oc2kT5KfEwIA/ljQ5eTK9Nh1ieZDDZqWadUFhTAZlX5aLH9F/leb+TSfNO5QYGG
         FjfYE+HbfOwTrBvmZq8Yd4Xw4pL/0qFXbF5eXCW9kC+Dt4bEDHyVQNtEqLqbZEh/wwSA
         MIkg==
X-Gm-Message-State: AOJu0Yw1avsy31dQ9ovITk5iq1JapFshb4zKfWC6j6vfuQmHDbcoo80G
	iwy5WMMPGsRYOL3jEFXoy7/VMkmoJvZtOd9jaB63xZ6hKpRY1p0gXH1lsQWJcwQzj9P5wURGxPK
	7FLX7o0g0uw==
X-Gm-Gg: Acq92OEgfpqKloyhdivz5zb/sl8R5onhZTx0dWNKvzMOBWy9YusEnNNAnI3tnVw0xQy
	4Zys5e9+ZQFDQuhLr4eXM6XrL92mKlPTLIN5CW91M00mA4Y53akan7NJ0SobfqBoDZp2B/vCQFk
	9BrWkvW3jRhEDZNZ6iGfzcKVW/IvADRNB7QNmtPMrTRZKk0Z6jbNsQKTfrWO4A08/u7MmZRigvn
	cUrmANmdrHGnr0zhP96fFrBvV7jZXfbaajzHO3dnpNe5yvjYZuYIYGyDNgKFC/XU9PIzVh27Z2q
	1ir3mdC1/d15FFLd+wNm4BMyjsQQCfMKlvf4nbzhFgGDl5MRukZ0OqRk1KYSAHUIEk3Tab6VMux
	yMeNZhWyfjez5AZX0xTYrryeYC6zPmw6eSMcG3RLcLAoAC78+5evJn4rLzcSHEV8TFxJ77w+/WP
	Ib8bYpmGut7QJJielrKnUTAAK5pt7E88cO5ou/jhTlI0o=
X-Received: by 2002:a05:600c:4f53:b0:490:7136:ad05 with SMTP id 5b1f17b1804b1-4907136ae08mr77802145e9.31.1779806558745;
        Tue, 26 May 2026 07:42:38 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm325398695e9.4.2026.05.26.07.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:38 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v7 12/15] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Tue, 26 May 2026 16:41:49 +0200
Message-ID: <20260526144152.1422310-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21316-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8104F5D803B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Apply the per-attribute UMEM model to the QP create method. Add
three optional UMEM attributes that drivers pick from based on
how their user ABI lays out the QP rings:

- CREATE_QP_BUF_UMEM is a single user buffer that backs both
  the SQ and RQ of one QP. This is the common case where
  userspace pins one contiguous WQE region for the QP.
- CREATE_QP_SQ_BUF_UMEM and CREATE_QP_RQ_BUF_UMEM are a pair
  of user buffers backing the SQ and RQ independently, used
  when the two rings live in physically distinct user
  allocations and must be pinned and addressed separately.

Existing drivers would map their current umems as follows:

- mlx5: BUF for normal QPs (one ucmd->buf_addr covers SQ+RQ);
  for IB_QPT_RAW_PACKET and IB_QP_CREATE_SOURCE_QPN, the RQ
  side comes from ucmd->buf_addr (RQ-sized) via RQ_BUF and
  the SQ from ucmd->sq_buf_addr via SQ_BUF.
- mlx4: BUF, single ucmd.buf_addr covering SQ+RQ.
- hns: BUF, single ucmd.buf_addr covering SQ + ext-SGE + RQ.
- erdma: BUF, single ureq.qbuf_va sliced by the kernel into
  SQ at offset 0 and RQ at rq_offset.
- bnxt_re: SQ_BUF (ureq->qpsva) + RQ_BUF (ureq->qprva, the
  RQ side is skipped when the QP uses an SRQ).
- vmw_pvrdma: SQ_BUF (sbuf_addr) + RQ_BUF (rbuf_addr, the RQ
  side is skipped when the QP uses an SRQ).
- qedr: SQ_BUF (sq_addr) + RQ_BUF (rq_addr) for whichever
  side the QP type actually has (no SQ for XRC_TGT/GSI; no
  RQ for XRC_INI/XRC_TGT/SRQ).
- ionic: SQ_BUF (req.sq.addr) + RQ_BUF (req.rq.addr); both
  are skipped when the rings are placed in CMB instead of
  host memory.
- mana: raw-packet QP uses SQ_BUF (sq_buf_addr) only; the RC
  path uses multiple per-queue user buffers (ucmd.queue_buf[])
  that do not fit the SQ/RQ pair semantics of these attrs and
  stays on the legacy UHW path.
- efa, irdma, hfi1, ocrdma, mthca, cxgb4 and usnic do not pin
  a QP WQE buffer via umem; none of these attributes apply.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- extended patch description with BUF vs SQ_BUF/RQ_BUF semantics
  and per-driver attr usage mapping
v2->v3:
- replaced the array-form UVERBS_ATTR_BUFFERS attribute and its
  uverbs_buf_qp_slots enum with per-attribute UMEM attrs
- dropped qp->umem_list field, handler allocation, write-path NULL
  arg, and the umem_list parameter on ib_create_qp_user()
v1->v2:
- fixed umem_list double free
---
 drivers/infiniband/core/uverbs_std_types_qp.c | 6 ++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..e44974abc6b5 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -340,6 +340,12 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_BUF_UMEM,
+			 UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
+			 UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 02835b7fd76d..839835bd4b23 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -159,6 +159,9 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_QP_EVENT_FD,
 	UVERBS_ATTR_CREATE_QP_RESP_CAP,
 	UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+	UVERBS_ATTR_CREATE_QP_BUF_UMEM,
+	UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
+	UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_qp_cmd_attr_ids {
-- 
2.54.0


