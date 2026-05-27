Return-Path: <linux-rdma+bounces-21392-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB9eA6AlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21392-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A12DC5E832B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75EDE3031B59
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5744CAD3;
	Wed, 27 May 2026 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="mJe4gjr1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B931A382F05
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901837; cv=none; b=kwGpDd//Zvbo8w4MqrQtMOq3AJq7HBNOyuTFcLqjz5Y+yUjy+QDWH7ZxYPkf+/xIW58phGMqqRvnXk71M3v5D5yyN84URyTS/tlQvTeYO6um19mD1fuX8HUL4e0XCC2nPlgr3FMKOO2sqe/DM16OpLBsXSuqw0RFGwr4hIOBxlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901837; c=relaxed/simple;
	bh=+wL1FcN1eICk2dnt8zTL2y63dZGFrP9K3uAsYbtQs3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVKVdJ5BVUe8vQXB8xGqEXGaSeWQPax859Mw8FpqZcuWTDKqlXPVtvYJXE1K3qIq6MA63ncKGYM2TpXOOEnHtzpa7oJIcDTdLQ15e3Ekmy8iM/r2C/wevXj613dhdYZP8B2w3p38iVBsYMJjpyflYTOJmtDud8vOqYBjJ2Ee9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=mJe4gjr1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso63446375e9.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901834; x=1780506634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=mJe4gjr1ZGQYMF6OzDeDMlZPBm9WgAo5l8jpkRngrDnHAxu88JTs1o/RnsH0AaaPOY
         wyRvdEPB1EQnrKPQuyDjDIIf4XhwGq0egiTTjgCQw3a33WNswOdPAlUKh1EkvDyco8Zl
         aLGe2PmGBaf2/xsHaz0Rxy+1Tke+w/c3WvYBiMVH1AsBsk95zk7jFZSpYg7IfQUTKC1m
         k1N57uyXn1/13xuv/b8mTEn5O23tV5rJE0Pfo9D9Um0v7AGezZ0Qq3gLRH1Sp6K6Em5q
         1vu/mLolzB9ZPHPBFBVZwA1ebDRdpWzB3YCZ5U9rWZ9+fuNhqh42AJ4/sdWCgjCmGcHh
         MhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901834; x=1780506634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCJSlalGXxlF7SxA7Qmp6JgjO0XPwfr98mt2V8cAV9I=;
        b=VUw6MX+QDA74xGUeFprCyBZOILaVRt/lfgajs2SP5WmVd5tObFd+lnSZqq9ExCLIJB
         MqgJZfXkldyX37ODe8izR8mURG25qswwWSjROb/Sh3i1673IzCLuDaDw18ps58aGf6CI
         2hkWtbh38YTrkCFd4pXhG0fkV//S/reU8CVTuWACceS7aQ6LU84Ql5tpO/hoM+bjn3sU
         gYFoXRlTF+DM9UVO3kflIqIw1JDO1lUrph1pigQG6+f5UUo8z96JpUZSDS1yJHz6q/Pe
         EQyzRWZlLGkdE6R0EDBeqOuAPMxE4qogvtzy2geh+dwrXfOdun5o047oWOR6sv3ybWHD
         61oA==
X-Gm-Message-State: AOJu0YwDA9UiGiHsICyYT5fD6S4sdpJ7bMVWU87uu7Hbo/AYBxB0tpCd
	Zo4sNCwOInv/JkfiG5L8PYF0TOa2YGj9uxZxxzG4esl0827rHuOgJbQ7e4ym9XTf8CocpC/JM13
	wvJ1wVLkNWQ==
X-Gm-Gg: Acq92OEbGzfYOWe91wa62h8pYixoIq27f/4e0CIlGiKbd6MDSWOGIXESLfdccokRKup
	Xuz+3mc1iL2t8VGb/m2gkx5NT5Ctw0UNSXE+gcTXfPLDFws+u0V6+EaRzhgZmNkyO7mBNEclVMX
	OMT0Nammo7TvPA040rmCUpptR6VXtkZ7KHlfwo0U31MaQEdckb8CeIIHy/Kt8NOolTfobRfAg81
	X+44q8eH2kF5jzYlficYmeuDs1VkUo4eRSGvWW0QQWhpbZju97FNe0RLyMCSEWHsIBlyoIhdEaH
	Qcc8RiCWfHoLHEhV31BMtxe8quXpzj/wFSGpm8WFto6v2wovoB8AsG0h0nOKlpIqfkD0s6kuam5
	ptgnXTzSyU2R2P1CwfMdoYysoRE46+JLV7cyUUfOs8bGHNIaWv388DVDRo9mhnayi8gbGtl4T6Z
	CEtG4TmuZuWMxZX0xZoP7xM/SLZUhWSWxH/mnOSP2nQA==
X-Received: by 2002:a05:600d:6414:20b0:490:4b89:5359 with SMTP id 5b1f17b1804b1-4904b895514mr265153625e9.1.1779901833913;
        Wed, 27 May 2026 10:10:33 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809be09asm24662015e9.27.2026.05.27.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:10:33 -0700 (PDT)
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
Subject: [PATCH rdma-next v8 12/15] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Wed, 27 May 2026 19:09:45 +0200
Message-ID: <20260527170948.2017439-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21392-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,resnulli.us:mid]
X-Rspamd-Queue-Id: A12DC5E832B
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


