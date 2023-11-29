Return-Path: <linux-rdma+bounces-126-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C27FCD77
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 04:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20521C21058
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 03:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3C2523D;
	Wed, 29 Nov 2023 03:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oi6Q2c3V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0AC1AD
	for <linux-rdma@vger.kernel.org>; Tue, 28 Nov 2023 19:24:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701228290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUNm+K3QdC8Sh7qsblPNC2rl7ScFDfmW+mqWIBh5fr0=;
	b=Oi6Q2c3VhpU7+lRXh9zKzuvOXkIfEaI6s2vFEd7qA4DJWGSgDB4NIGXOAIEEv/40VlCp9Q
	gmtToajLDXuEgz2NI4EqOOFDUIpGad62/jouzJmZpv7alFywHgGOJrLrh0SEEUVruvd+J4
	NdHXRmz04JukkdwX9/jZDu/DaXGEEqc=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH 1/4] RDMA/siw: Move tx_cpu ahead
Date: Wed, 29 Nov 2023 11:24:15 +0800
Message-Id: <20231129032418.26705-2-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-1-guoqing.jiang@linux.dev>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We can reduce one cacheline for the usage of struct siw_qp.

Before,

	/* size: 1928, cachelines: 31, members: 38 */
	/* sum members: 1920, holes: 2, sum holes: 8 */
	/* paddings: 4, sum paddings: 13 */
	/* forced alignments: 3 */

after

	/* size: 1920, cachelines: 30, members: 38 */
	/* paddings: 4, sum paddings: 13 */
	/* forced alignments: 3 */

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index b36d1ec25327..d14bb965af75 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -417,10 +417,10 @@ struct siw_iwarp_tx {
 struct siw_qp {
 	struct ib_qp base_qp;
 	struct siw_device *sdev;
+	int tx_cpu;
 	struct kref ref;
 	struct completion qp_free;
 	struct list_head devq;
-	int tx_cpu;
 	struct siw_qp_attrs attrs;
 
 	struct siw_cep *cep;
-- 
2.35.3


