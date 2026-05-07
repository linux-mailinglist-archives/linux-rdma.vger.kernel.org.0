Return-Path: <linux-rdma+bounces-20154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ04A2CL/GleRAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F894E889E
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67CCC304423D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B153F0AB2;
	Thu,  7 May 2026 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="wvd/HRk2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431C3F0AA3
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158369; cv=none; b=rsdlU4E9TEGukVuYn5kruPZErXqEgfiH2n5pzXWk6ZmG4inXKFxCM9nTNPREvBXW7LZ6mC8MdTDYwRDgaz1/1h3DyYRDD9Di8qV5N4B7R1hpIRxLXuE3V7+bneVG6dnXdsWeW+5OG5vluaUzlmzuhVFFlDE8teNUMUCpsthfGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158369; c=relaxed/simple;
	bh=xARNfulnP+rmouuQuCXB+vq0yAL246mU/nb1xdrfzSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPyTfGm8PUuM5CqLOQyp3Ye+54GciWBL/AGecL7fxZyWHNfkO+x5Ub1/e04cM+2wUKdqvAl24aVgQNKyRC8pXDiK4JZwN4CO743DYDTU+MECgZmvcYOUUHoiba68NGZR2oLCMG7uGYt/E1tbKFhBlgzKaIFQV6SsTkH6q/XJTdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=wvd/HRk2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso10123465e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778158367; x=1778763167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0KqJc5+lhPTjZ8eCqGu3r9/U4W15cw3IrlQEog7Uhg=;
        b=wvd/HRk24DE6idhuEEEDfgzSm04zaja7Q+01uWiahNjZt5mCMLEKweTc2D/V6oO0UM
         lGE4qQAVoJjQJEfN0JsPxfEnS2Q3wYRxire2A0i+L+doKXQ34Kjx27yh2z7g8rGaDncB
         uiufWe2R2ZPZSzrINPE/edsTrkfJ76f4QBk4JabcAyI6K2o+L2FIJq5KkkNX4T9KExyj
         scT/Wexj+7es+IveT4jeTDytV6YihJAJ+CpsQFNSoNEjVvSHJLhVelnQYo4LaF9/hpVK
         yxVEGFqdXTLDQboctgxrnXbE7DHWaBVM+UXGQJbN9z7+AfsFW7cBOYXBb8IttCmGLnp/
         eUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158367; x=1778763167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o0KqJc5+lhPTjZ8eCqGu3r9/U4W15cw3IrlQEog7Uhg=;
        b=sqAAMJTrzE1Sbmh6Hs8tPopEyB6yu/isoq2ZC3fz326W7EcBNF0VBZQCUIksu6shFz
         5fd88bZNioatsJuZbrLz2udrBF9WZ+s8U+p+wxrfV+tA0YTRUmyWN50E2GJAPKe7KP0l
         7BX3VU7bQbcswbiczowNspDwHVax57/NwIQl1U0bNuCgmSIDBikh2fiGnNPTCygg/IZN
         hCYbebkvzFAja49SwDv7qWW3N9uUXnydvyRKuYSY06OiGsU8RRWj8GE9DRZTA5eN4mO3
         bY9PMxfl31ykxX/WoovvjtunO8BMi/gwQNn5kwHyAuGbJm2oy8Ai3Ym2vA8FjDOGXldn
         l9qw==
X-Gm-Message-State: AOJu0YzULeVRm5Ku0Pm12OXJZhiBlU1QtashFma8EF2Ipr2bVfBmnABA
	FIsYJixhn1aGM0OOAlJTETelh5Wc6Zzby3i6Yr1f8aNAGAPAg2WQ9fcJVucgE86stIMn7N6cdd8
	3ZDfP
X-Gm-Gg: AeBDiesZssxilAIUTUz1XkXSBtr6RzBQnHoU66qU1pbiIMqY3kZDLLGkuZn8FXglz/L
	gMgz1sN7yMGZvJnyRv4fQUmN9vSjq25pFaG9VzkHX5HbE/B6dyVgHcOVzeDUK+PrGfhuM7b84Zd
	GXR+ZE99P1H8Z25/m69vifjwxXP18OKcxCSU/szTFExbpzTpMYRZ/3jqDR0kOEJ17mMZ5TkSmVl
	p7IDfUTuwqpSArEFdVfoxe/wrC6fHFGNTGH313JTn9vRmbxCqR+85+a4wzj+Rk5Zv+uQLps1RyV
	zcUoLzeu8ZfSBfoW1ve+FKeFJDI5yVHFt6rw5oLNNCsOyy0lhGfrZDd5Cmokvj68MsENZasEyU5
	u8yRCICMLFjU+R7vhGKdc2jD1j5ItDhbnz66A8WlTJrKn4dTIKXmKlU/Ypbday76rp+tbnK/ewY
	uwk7yhWrSVXT4bKXFAXTgnSQbm+RivCd1BNcOkvcEvEUht8QiA1g34wI/S
X-Received: by 2002:a05:600c:a305:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48e51e08362mr87007935e9.2.1778158366736;
        Thu, 07 May 2026 05:52:46 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a517bsm132126855e9.4.2026.05.07.05.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:52:46 -0700 (PDT)
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
Subject: [PATCH rdma-next v4 13/16] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Thu,  7 May 2026 14:52:28 +0200
Message-ID: <20260507125231.2950751-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507125231.2950751-1-jiri@resnulli.us>
References: <20260507125231.2950751-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 92F894E889E
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20154-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
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
2.53.0


