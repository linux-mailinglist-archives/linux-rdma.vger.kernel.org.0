Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B323D630
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 06:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHFEqP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgHFEqO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 00:46:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD81C061574
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 21:46:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so24249487pfm.4
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 21:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kMdOOodLF1oIRPKIxevKj4Pyql30VqbbSah5ZNEjdd4=;
        b=KkEjcmYAWD7ehkWgC72Z8esbduMedxaC1YVmMvXba2cleGEOGGI1rGnEBtoVdoq2hC
         EdnsWObgw/23Vrk4EEusrU73baCJ+aaJpN0KGAwX+Cgi1+oQ1LOxLwF14RXpg+hx/FNb
         IHyT0WVYr0Du/hLfVZGUZmBBq3cikzglgeMLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kMdOOodLF1oIRPKIxevKj4Pyql30VqbbSah5ZNEjdd4=;
        b=OF0UV1DMuskcrH05ALpr8TlNOEYDRQog1XIPEhXG6vPo52T5ttLyU0nQGtXR8wNyNA
         2PGn2rEEQn6J5hd94CR4A+bqLzSu4BiNGbIL9Lh89EYGHAdi7BbRuZR1H+OtCOocYsJe
         CRvas0+QSoneEG3gkI6oTFJGpZyxVF7qqWprmkbAtpB8hfZ7FvdL8Jyuzw+Yqom9ZL/Q
         m4AoWP48Vpvx7YrfRz3/hcdI6qkrLIPpdVD9OKiMyhj1HwvPo01r8RIKsDDTOTpAAT2J
         0y28YkfZF8t77UcGhPun+GHtMZOR/VANTDeLDjfNXSw6uE7vC9O6H+AiwLt1G79kavUE
         +yrA==
X-Gm-Message-State: AOAM531rYxoDsuIjDqlT3A/jpp/epfCF4wtBGKCAL1xxMDx8qkqZdU2w
        dfHehgMOvQdSu3VgEL12qJG2AA==
X-Google-Smtp-Source: ABdhPJyGGZshYPwClY5Bso3AYKHzHXBio/K+rKWheRPn/ZnKE2vE2V0Tsqg40A9NB5hf7oY/ejwFmQ==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr4380577pgm.253.1596689173299;
        Wed, 05 Aug 2020 21:46:13 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id e14sm6024376pfh.108.2020.08.05.21.46.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Aug 2020 21:46:12 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc] RDMA/bnxt_re: Do not add user qps to flushlist
Date:   Wed,  5 Aug 2020 21:45:48 -0700
Message-Id: <1596689148-4023-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver shall add only the kernel qps to the flush list for clean up.
During async error events from the HW, driver is adding qps to this
list without checking if the qp is kernel qp or not.

Add a check to avoid user qp addition to the flush list.

Fixes: 942c9b6ca8de ("RDMA/bnxt_re: Avoid Hard lockup during error CQE processing")
Fixes: c50866e2853a ("bnxt_re: fix the regression due to changes in alloc_pbl")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index dad0df8..17ac8b7 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -821,7 +821,8 @@ static int bnxt_re_handle_qp_async_event(struct creq_qp_event *qp_event,
 	struct ib_event event;
 	unsigned int flags;
 
-	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
+	if (qp->qplib_qp.state == CMDQ_MODIFY_QP_NEW_STATE_ERR &&
+	    rdma_is_kernel_res(&qp->ib_qp.res)) {
 		flags = bnxt_re_lock_cqs(qp);
 		bnxt_qplib_add_flush_qp(&qp->qplib_qp);
 		bnxt_re_unlock_cqs(qp, flags);
-- 
2.5.5

