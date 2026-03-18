Return-Path: <linux-rdma+bounces-18304-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC1HGSl6ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18304-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:10:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807F2B9A98
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E9B3055639
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37FB38655B;
	Wed, 18 Mar 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7KH/EtS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51943BBA0F;
	Wed, 18 Mar 2026 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828553; cv=none; b=sIp/CqQYgyDHwAH0lUoT+0xCw+AKHwA8JRLEYG4CngQYZa1czX8FYETeIRLuNNxuuQmfEHWN/KVI97EyHkUjyFcVjUbRAxwP6bMiB2T6ut7Z+24zHS/YY1IM90QTSq4QGKa11NIU23XsUgUfwfgRDgh6LPbcgKCOomazpVtDF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828553; c=relaxed/simple;
	bh=ncxl0MunJglavLbnABmWimFxVQWUekOXGMOBEDMdKlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pl/B9Lpg0Y1mbzaNSPIPuD1NDF2DDvgYjVcKR9slmLaweWteqN5x8ql0lc8smcI04a3NDU53+6B3n0gdWnLjYYVue7AtQQGVA+ioH2TOJ42Iddc/36I2QcejIfUM2/icjQ42I4REKLR2TBQuCwAPD0SfP0JOxbhObW2GrSn6G0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7KH/EtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4FFC19421;
	Wed, 18 Mar 2026 10:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828552;
	bh=ncxl0MunJglavLbnABmWimFxVQWUekOXGMOBEDMdKlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7KH/EtSqIFKgEK/EKeWFc2oOYMlzMkCieBqL9HzpKQUXw+Mt79/El+rLHNM+43od
	 uL+Kze+Y6b1/y0yw2MXdKCkvJdQOAeVK2TKMqL/AESZvM1sY+K/R3Alq8aXvK/qPqB
	 IB9HFYVYpS8VaqT0kFJfiY02Z2OVuhhpU3Vl6K2ulklwmKZ6n0ktA13EzAkYm25pxN
	 YtSgnC8KwysKpTOIg4ziQCVVXMS/oKSjV13vjHIcweWr0045YhXuoPbdV2vfTamSeK
	 IkHV2GtedWP6Qw0Rf6e6MHEi3lfiJDtUR7NTf7Y7GzCxWadb7bNliSKAUqsOLIf66G
	 rVs6l8yvV6ucw==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/4] RDMA/bnxt_re: Remove unnecessary checks in kernel CQ creation path
Date: Wed, 18 Mar 2026 12:08:51 +0200
Message-ID: <20260318-bnxt_re-cq-v1-2-381cb1b5e625@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18304-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 0807F2B9A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

bnxt_re_create_cq() is a kernel verb, which means udata will always be
NULL and attr->cqe is valid. Remove the code handling this unreachable
case.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 40ac546f113bc..cb53dfdf69bab 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3471,31 +3471,21 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 {
 	struct bnxt_re_cq *cq = container_of(ibcq, struct bnxt_re_cq, ib_cq);
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibcq->device, ibdev);
-	struct ib_udata *udata = &attrs->driver_udata;
-	struct bnxt_re_ucontext *uctx =
-		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
-	int cqe = attr->cqe;
 	int rc;
 	u32 active_cqs;
 
-	if (udata)
-		return bnxt_re_create_user_cq(ibcq, attr, attrs);
-
 	if (attr->flags)
 		return -EOPNOTSUPP;
 
 	/* Validate CQ fields */
-	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
-		ibdev_err(&rdev->ibdev, "Failed to create CQ -max exceeded");
+	if (attr->cqe > dev_attr->max_cq_wqes)
 		return -EINVAL;
-	}
 
 	cq->rdev = rdev;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
-	cq->max_cql = bnxt_re_init_depth(attr->cqe + 1,
-					 dev_attr->max_cq_wqes + 1, uctx);
+	cq->max_cql = attr->cqe + 1;
 	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
 			  GFP_KERNEL);
 	if (!cq->cql)

-- 
2.53.0


