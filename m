Return-Path: <linux-rdma+bounces-185-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E478780223C
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 10:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2162C1C20911
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CF8C18;
	Sun,  3 Dec 2023 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mJw0/6AV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721EBE8
	for <linux-rdma@vger.kernel.org>; Sun,  3 Dec 2023 01:27:38 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701595655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTxQflORM0ute0ovnCJ1V14VzEpqdJ0ViqQLbjbbRJ8=;
	b=mJw0/6AV4JUEvJBfYNoRMaZX8cFY3dV+VHfs/ZoNRbo167SrKjPEg1ylTrqDOT1aI76xp8
	5JgD1SvOBO1X5MP7vcjwhXmS3YVdacskDpGduIjnnpzI24UsUAae3nwL/bEkVjvn0zl50K
	Q0ouzNQyT+EFNGlyKP0+TqkFYIW1N/o=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH V2 1/4] RDMA/siw: Move tx_cpu ahead
Date: Sun,  3 Dec 2023 17:26:52 +0800
Message-Id: <20231203092655.28102-2-guoqing.jiang@linux.dev>
In-Reply-To: <20231203092655.28102-1-guoqing.jiang@linux.dev>
References: <20231203092655.28102-1-guoqing.jiang@linux.dev>
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

Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
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


