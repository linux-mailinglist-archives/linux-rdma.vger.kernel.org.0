Return-Path: <linux-rdma+bounces-13807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE26BCA354
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Oct 2025 18:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A6D3E39AF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Oct 2025 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B1A223DEC;
	Thu,  9 Oct 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="C8js4s8p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA421578F;
	Thu,  9 Oct 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028052; cv=pass; b=Eiwia41OBqNQQ6Qwa70dAx8hYAAzinyrcHznPzg3rSeonP/PKmhEVTe+u3KB03qcz6fAc1iCfIH2s6Hb/2Snj1HoNxlAyMhnpsCc/Ak/N19A0vl2AW3Ejysv9gwTN4ghHofPEElMgfZvOp9tnn3DnVbVlCTd/jqF9xk/yjx5dKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028052; c=relaxed/simple;
	bh=ZgglZCFn/EqdBXtblPV/Dy7Plq4UOu1BOvKiyezBek8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JwL2ekiuut7eXH+7kTSaOtz/NSNEvjVxuABGIZqEb+m8xatOTuXyxP9oMfl7+gQ6i0lqsDDTeb+gFngPlvrK3QMjm51akRBEzsX4/Y5TY5bBjawI29E6+2IJYWb6hnBz+UwZhgjrG7dm+1BrbBV41BhRuXIMiiYi1+3OluCvYQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=C8js4s8p; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from homelab ([58.82.196.128])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 599GeWJY2322644
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 Oct 2025 00:40:38 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1760028039; cv=none;
	b=TtGeO6YNynZkZbfi7/Q6jWyYneuSXL+tmeg+y0G3vIx2Td4iGQ0ZCQ8J5Mvu31qwJjqbUuzvMwiWptfyJH0F3vpbrIuWFYHOxeea81Zo1NYU6y0A6fMdkV85noZwfmZYbiLfJTsLxeJ7uS1/eJzD/miooduLwF5JZ23tD4HEaWE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1760028039; c=relaxed/relaxed;
	bh=UkRi9jREwhqturCXCcWA1NMVii1+Vza1YGGjAvcPQd8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=WGoPOMJ5A5JSXlzp0cXhJg1mPnQ15FosfAE5xx4Diex3qGnzuhl9BWELor9XzzraSu6cq8DKHR706a0XTDrehVAc6WpZGXlVuO937k4QRAhFr8X9hleqOX3zlYpHtijgd0BBslD3PeqTp7GZ9pVjC4m4j8IoREXa14caNKkVgl8=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1760028039;
	bh=UkRi9jREwhqturCXCcWA1NMVii1+Vza1YGGjAvcPQd8=;
	h=Date:From:To:Cc:Subject:From;
	b=C8js4s8pkBtGuEmWNY7T7IRFc0Qj/mK/mPgeIRlmJOdfMRqOTqUJbOPNeHRgXEEwn
	 hnfqRx8olX/lXUC/z/vfPXPv+WbxwKvevl971ufWUyPM+sn6z9U+Gxet8otitmpU/q
	 SjsL7y5/s9IbhQWqiu1BhR743YmKBxZGlgWT8g0E=
Date: Fri, 10 Oct 2025 00:40:26 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/uverbs: fix umem release in UVERBS_METHOD_CQ_CREATE
Message-ID: <aOflenF0XHtm80G9@homelab>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Env-From: sfual

In `UVERBS_METHOD_CQ_CREATE`, umem should be released if anything goes
wrong. Currently, if `create_cq_umem` fails, umem would not be
released or referenced, causing a possible leak.

Fixes: 1a40c362ae26 ("RDMA/uverbs: Add a common way to create CQ with umem")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 37cd37556510..9344020dede1 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -193,8 +193,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 
 	ret = umem ? ib_dev->ops.create_cq_umem(cq, &attr, umem, attrs) :
 		ib_dev->ops.create_cq(cq, &attr, attrs);
-	if (ret)
+	if (ret) {
+		ib_umem_release(umem);
 		goto err_free;
+	}
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
-- 
2.39.5


