Return-Path: <linux-rdma+bounces-20823-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC9/JIxgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20823-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5565255F7D8
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFA56300B1AC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57392BEC43;
	Sun, 17 May 2026 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Rb4COc0L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4C223702
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999428; cv=none; b=Hes1TRtudtbZE0mBwwa7DTJUS8QsZfgMs7PDhgOXT44PCA2eYAcOMvNdncA5F8VwRO5A/XQzt1VK/9E44IAFj0gCRLPE5JMSG1yawxtlX2dJPnsQnZ0M/qntCtFUytS14Q5otHGoN4xMb6eZFz5l5Ow5O+MaaMLbV0nkPlybYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999428; c=relaxed/simple;
	bh=+wL1FcN1eICk2dnt8zTL2y63dZGFrP9K3uAsYbtQs3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgWQE2PJh46UEMRRMvBqgRzaPKHipz9rj6jV+VyPGOtuX+8eqhFtwgD6APZzkTostGOnKpjOOd/gK/rgCsK8y+SjAFeoKtoAnGCTLSBWpXB3NimRhlTPn0SZ45fA6Qd5VhYqNAOoNZYwwBPkRl4O/tTF8weorhLBoM+2MFIuYXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Rb4COc0L; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so1059829f8f.0
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999426; x=1779604226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=Rb4COc0Ly/Mnr7Yq8XDWrMRpvE2DhM7aFOci3B63cnpm+e4AIti+GRXpDTwz6o/6AR
         +AxJ99DLHDNeYa2awbC4K8geNl/X6HsvJRW6s+/WdQ4GO1BaUQL2i+NYS5ZmyxNyaAed
         llDt4cK6M0bTM9RnrL58z+VChyxAxcM9zyMLIWDrNpKgVQsc/4Sws7SEYrVzfthMTxli
         BK/pa/pUFqyOFusfSJOMNSOif52VUREOLSYA07qcz6P/piR5y4fJFwcnCRZ1yngHmXBA
         DB6qIP+gku4foNvJwm7flkUmFDuZmUFT9rIgM4JRxKlNdznwEGuTpzhID3xd8sWQXpvG
         HUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999426; x=1779604226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=RejTbBf+87yM7+kChAEvRlirkE8WykasFdYMwBzaa2l9sK2Mou1oOAToCNN0AufZlD
         ls1YyU6M56Vn6Y4bv38SuquNnBsiq4FvO+xFXgDOmqHXdbOFyCl/tu4c17PFsPHBvZ2y
         iUKF0BIhfURGATVpMPrGxYBlmRICU+6FO+EMjgiczMUv8Q9Mhwh2JnhonF2uRmIPpk2p
         Ynx4nV3jrzR8u7vJVxUOjiBQ8dKVAFUjDG5hLRbqaNJaip+gh3lZmBbvOIE9/BWsYEhy
         uWzGw7TlbQb+jUD+amaNrIBXbpB1Yas3usfXFOYoN3YTb5pxQDNSxSLUk4S6mMmWS4dJ
         w1uw==
X-Gm-Message-State: AOJu0YzUgiQDrBsWzEwzzdQDNjnluKD8QbCIj1GA0Tz+VY7mGpptJxjh
	me9mN5G1KUhPiZTywOop9XnHzxTnT9yygadSd8yMgzaVL2x0vlyJi5CO4OwYHCDc13GKssOGHrX
	+BXCkDzhu8N4Q
X-Gm-Gg: Acq92OFcOayLsoLuNKigoSkK5K78ghKhdGAibChS08GNsV/H5EwHbW68pNK/9iXqQMk
	7TekDgEJEdyh9gVS3I7MK2JEPWbjASwlA1BKtnEHeMJZLFt7g4C9R5IVwUE/7EDMkCR30ukfPCV
	y5KZLQlXKzXCC+lzUA0her1WKeH1hfLyr5DQKKgVPNiBQ7aZbRQ85O8neaGyEbfP0IhDwAzPjry
	WSDWMFGf1lMypwH/Ry8NXdBEZzPbYpwUHD/sfQc6zLo9NI0FkJ2vZM7KWW1UcKA+TwL3GfKUyiB
	SJ/Qk9yw/+NhOysYdm/f1oeKCjOSkxVxpjcUR6mqRvSDZtt380Rhk6+12k1nu36MArc04U/uXLM
	sZn5WaLFKubTKUqRmSVsB/V/4E7QTUsxfTgXJiFbOfvZe7akRrH7tQUs/pJmCzqdxOnrbhdP/AH
	MYwcOpJ54Vwnv1pUe5uJe97BvTOrK8BY7TICEB2rNlqRMelQ==
X-Received: by 2002:a5d:52cb:0:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-45e655d0715mr6423573f8f.24.1778999425604;
        Sat, 16 May 2026 23:30:25 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768c4fsm27600542f8f.8.2026.05.16.23.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:25 -0700 (PDT)
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
Subject: [PATCH rdma-next v5 12/15] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Sun, 17 May 2026 08:30:03 +0200
Message-ID: <20260517063006.2200680-13-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 5565255F7D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20823-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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


