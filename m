Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C7A29A8BF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896730AbgJ0KBF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 06:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896051AbgJ0Jvo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:44 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B536924198;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=/+WizXjKPpyHjvSoygOYgiSt/yZZwGfH0RVEUoUmQJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7KMZfoTHzUI7aCWexvHTfnFUnNkPHcK2eyiLOZLsEZxbcREbixU4/rUCg3jC0VC8
         BhOwlIJc+EOFS2xUYZVQSutbubvKR7EwNPHMmTXRGGOSGsUqBjZgcNoBsgzKS0GjBF
         SDfZDHJpnAjRiUBahQID1T0xDlXmUgnYsuF6RQqI=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FFL-K7; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v3 20/32] IB/srpt: docs: add a description for cq_size member
Date:   Tue, 27 Oct 2020 10:51:24 +0100
Message-Id: <df0e5f0e866b91724299ef569a2da8115e48c0cf.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
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

