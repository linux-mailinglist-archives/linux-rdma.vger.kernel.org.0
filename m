Return-Path: <linux-rdma+bounces-21045-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDf7MFaKDWpKywUAu9opvQ
	(envelope-from <linux-rdma+bounces-21045-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5B258B999
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0164230FE67E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFDF3D6CD8;
	Wed, 20 May 2026 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="o2pjVfyo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B83D647B
	for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 10:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271919; cv=none; b=lfajTj3+4kbgMvskSduhw2+I4Lats9rX5cPJCDXaVFkfQOkCdVqh17PL9TqqlLAYjwCHt31j98cH5+5T/02E72Ulc5UJcGRLg3WxHE+8EsEmX0i077w2UeQ5JN7U1/Q1jysUegTlytQ1bNMISU6/X3zS6jA2wyCjWm78iRYlI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271919; c=relaxed/simple;
	bh=+wL1FcN1eICk2dnt8zTL2y63dZGFrP9K3uAsYbtQs3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CI/mM8h7bur4fgXAI3FKVQqgEgCaAjoWHukHQwkJ3Ej+mXVWpkqufAtGjUwrzWhAHxXPN0gyJjoiXqmqWTu1rcZWpe/hlMRqqNvhSf8NBa3bl1uLfPtAZcBG3VWxG2goBQ0kVx70/3wwydWfWvj0OWHXEDDgNnE7xG1k5aAlbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=o2pjVfyo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a5174670eso2647810f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 May 2026 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779271913; x=1779876713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=o2pjVfyoa5Exu6jBbH3xgB+i3ncKfuyv1kJ972D7uk4VCVf+S24QZeFNGapQYBwe2Q
         Pwn1gAMAbFnjePGvXR/mQo1vckarE+Z/uZG4vWof/H7rTyA9cBvTYwhmY1xPalhqZVsF
         nZ1V6n5usIlf2bW6uij5S0stwUIKLHxBBemJNmgHOWEViXdSCaGuY1qvweqcUMdch8jG
         FUsT1SPL7WpVFGb2nU+IUEaCtTdFvC1WgDjl22tOuaV8m1yLugEkWi5elM7z41Wwf/ZL
         gXN8kA6niQ3YCeqTHr4wmXAQ4HSFm/eXuVWuCCBG4wslEifmSjIK8Mxvy9L+jmTe9Hx4
         a+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271913; x=1779876713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=aufgIL9Hjj688qwgdd+zp8O2WbiTEDhNzur2fHw1o/iZsJlPxiVNF+POfSqCEpf18o
         sZjyS5KEelfiAJOS7q0ojPJ26YBLH/RhExKeU0EUmoBWfifjLcHwMwzQ4hfr9YT8PLOS
         kDBaqTGvShxzwmcisjte35AjA1sRBotC+Ob+H00+uS7w1PTAEPXK92lOPcGXXf6TWMPP
         zcGXx+zGCkdon+87NP5hRzRuo/qxx3wHCgmTwtyeJxqDkeuPAsJdR2a4qnNfvtr9jpZG
         qHdcY7MjEjVu7lze0kSEfZS0EGzb1lj9wNdgRfCSFYT54TXZpy6v9Y6bC5Fusg7bzC29
         wYKQ==
X-Gm-Message-State: AOJu0YzPL2+isdpboH88rGJZDkOjWk7bbQgRUui0u/K6pCdDFXBYIs3D
	yA4/2qI/UvhwAH8nVZ6IMJ+ysLb/eiD2IhSMUZD4EJ7kQbfyBTosqQgnghI3NH4gFFMZSCERmsD
	kWGK/RvbAQA==
X-Gm-Gg: Acq92OF4Kmblwf5OiGH7wggXcjpAzrSDv9jAKWyzGr1QDuX68Uwgf0NB/P/X3n2Mu0G
	M+xZ0XooPTqBJuG4gelM7mNH0UE6jBj+W/vMAz1ZOZf3NTp0wu+01kyy79Bo0dzEQfCq6ZG01mx
	/RLdDPExHEpsLzAHqSFkIPcXSG5VaULYbHrgYbqbuM+zZmTsFORVYHB8pL+rGRdNBiVFmeDsv0w
	3c+dZJDYurebsxYlPFurrxq5uMUsYsYuYfWKSxi8R76SxElUViEYVzFp9oN5QbBujirN5cGWaP2
	/KkcM5wPqzMM4Dnqyg0/ppVB+nkEpXAOQVPYjtzg+u3LkFpRvV1w9Opjfm/xXvbpEWB6hCUkAO2
	/NDXH3AnC7Ks8ujhInlJELhMHGky15NJOf/R/l8JM051SclHGrS0qx07RqQSNW+FTZwt5R5cmgk
	cjSAYcth6HtPwz0S8q6Up5Ua/iTER3y0xG
X-Received: by 2002:a05:6000:2c10:b0:45d:7bf0:e61b with SMTP id ffacd0b85a97d-45e5c5e6af9mr39681423f8f.42.1779271913273;
        Wed, 20 May 2026 03:11:53 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45e6a135f0csm34093374f8f.27.2026.05.20.03.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:11:52 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v6 12/15] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Wed, 20 May 2026 12:11:26 +0200
Message-ID: <20260520101129.899464-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520101129.899464-1-jiri@resnulli.us>
References: <20260520101129.899464-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21045-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid]
X-Rspamd-Queue-Id: CE5B258B999
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


