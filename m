Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD0108A2A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKYIkO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:40:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52683 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:40:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id l1so14435469wme.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KFy9Pc54+og40BCKJ07VzGkp54TwLhEqGBhlNfNaDpk=;
        b=GlLvqa86v3Tif4eb4BdAk9KpHVtmoIipyta/FOSAwR3Cq8N36SaeRDczf2e2z9hR26
         d+mXcUJtd+uV3hxUKsF+LTRd2T+n+W0dMVldqhjR6e8MHi5/yozYWEVyA4XeDGcmmwEq
         oYqk74p8+yNiDwMopMrzy68y/Q1yCnVjD3HxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KFy9Pc54+og40BCKJ07VzGkp54TwLhEqGBhlNfNaDpk=;
        b=AlYVogw/uZfT9um2Fy6r3DnXL9W12okXonBG+KcfCDMtVvdB9B9SsmV6wAQ0ywVXxd
         A20vBsPaCGTj1qWuqvavUFSyi2pT9a7Nv2p/r1crk1bchI0UWq8VOxDVp2se1ud9HB2v
         WHI1ktWcNY796H+UDzHEQCyzMW3uHWay4a8zCJYK0Nr1Vqwo0gZa4+/MSC2lVbRqv6ju
         w0WL7VBhUQOjDJrTLW2uvUbNa267dEIBFjOWuqqxTbIvnlQs6ErZ7HZLksvR4g6gAQm1
         gya7KKXeeDp2KsfMV6uxknEgJkBlRGPOQDjF4yxOIBUtpq3YJ8aM91trB09hDoMfyNV+
         YjWQ==
X-Gm-Message-State: APjAAAUpF13zHCaGIvXyhoOtu1Tk3TN3u0bv9MAholr1cpKg89t7xwY1
        MNjCbN7wWpNYwks30kw73kG1+A==
X-Google-Smtp-Source: APXvYqyCmNZEolpUM/O1DnlVPr6M+KVRBszl4lcaLnkumg4dhGPD177y6Jm8xOu4YjggKnwheMkDiA==
X-Received: by 2002:a1c:8153:: with SMTP id c80mr9641209wmd.58.1574671211238;
        Mon, 25 Nov 2019 00:40:11 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:40:10 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 6/6] RDMA/bnxt_re: Report more number of completion vectors
Date:   Mon, 25 Nov 2019 00:39:34 -0800
Message-Id: <1574671174-5064-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Report the the data path MSIx vectors allocated by driver as
number of completion vectors. One interrupt
vector is used for Control path. So reporting one
less than the total number of  MSIx vectors allocated
by the driver.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9ea4ce7..2e400da 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -669,7 +669,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
 
 	bnxt_qplib_get_guid(rdev->netdev->dev_addr, (u8 *)&ibdev->node_guid);
 
-	ibdev->num_comp_vectors	= 1;
+	ibdev->num_comp_vectors	= rdev->num_msix - 1;
 	ibdev->dev.parent = &rdev->en_dev->pdev->dev;
 	ibdev->local_dma_lkey = BNXT_QPLIB_RSVD_LKEY;
 
-- 
2.5.5

