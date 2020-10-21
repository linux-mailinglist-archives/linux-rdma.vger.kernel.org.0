Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2597C294C71
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Oct 2020 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442298AbgJUMRo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Oct 2020 08:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411504AbgJUMRb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Oct 2020 08:17:31 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC0502224E;
        Wed, 21 Oct 2020 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603282650;
        bh=R5tTbGRMnL+G/4kIQwAcFB68a+Pe0Pw8OIVcMvo5sOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E+1TTlMka96hx9ciNdtzvswoXZlwMYCfuZIlV8mtyw5u6CHXy9Q0iRjXRHSk22vRl
         tMVnBtwomei7k1ts4arSNTTeXfsjlftuvDpcszJj5uwyA5sCTO8HzQ6R9sgKoUqlbA
         c2z8o+3OWgFFQTeXQsiJNfawsuUzgGWBusK+/2CA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kVD3Y-001U2f-En; Wed, 21 Oct 2020 14:17:28 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH v3 4/6] IB/srpt: docs: add a description for cq_size  member
Date:   Wed, 21 Oct 2020 14:17:25 +0200
Message-Id: <32f4060a4300c20894b38f2504ee76ccfa497215.1603282193.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603282193.git.mchehab+huawei@kernel.org>
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changeset c804af2c1d31 ("IB/srpt: use new shared CQ mechanism")
added a new member for struct srpt_rdma_ch, but didn't add the
corresponding kernel-doc markup, as repoted when doing
"make htmldocs":

	./drivers/infiniband/ulp/srpt/ib_srpt.h:331: warning: Function parameter or member 'cq_size' not described in 'srpt_rdma_ch'

Add a description for it.

Fixes: c804af2c1d31 ("IB/srpt: use new shared CQ mechanism")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp/srpt/ib_srpt.h
index 41435a699b53..bdeb010efee6 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -256,6 +256,7 @@ enum rdma_ch_state {
  * @rdma_cm:	   See below.
  * @rdma_cm.cm_id: RDMA CM ID associated with the channel.
  * @cq:            IB completion queue for this channel.
+ * @cq_size:	   Number of CQEs in @cq.
  * @zw_cqe:	   Zero-length write CQE.
  * @rcu:           RCU head.
  * @kref:	   kref for this channel.
-- 
2.26.2

