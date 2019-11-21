Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD310591D
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUSNr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSNq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:13:46 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D232068E;
        Thu, 21 Nov 2019 18:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360026;
        bh=cBF5EzpRLP8zba3+uMC181Ty7ovdm1c/rDN73Kw60aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uemhXWQJG5KbNFMUIX/vcC8VJjQAOkan/w9qydDVbc3UHZ3h4CSlhHQARagDMS/SO
         w3lOqvm8sxSGwCoD8hOqM/D9SFAFFXjxqjhanI7wZcJI0RgQ7KJ5nHiqjgGSck9YmN
         Za7FSK/pwJMbVjCHJERbdFUa5TyDPyQ0r2FNhGE4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 02/48] RDMA/srpt: Use private_data_len instead of hardcoded value
Date:   Thu, 21 Nov 2019 20:12:27 +0200
Message-Id: <20191121181313.129430-3-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Reuse recently introduced private_data_len to get IBTA REJ message
private data size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 23c782e3d49a..a0dd17f90861 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2648,7 +2648,7 @@ static int srpt_cm_handler(struct ib_cm_id *cm_id,
 	case IB_CM_REJ_RECEIVED:
 		srpt_cm_rej_recv(ch, event->param.rej_rcvd.reason,
 				 event->private_data,
-				 IB_CM_REJ_PRIVATE_DATA_SIZE);
+				 event->private_data_len);
 		break;
 	case IB_CM_RTU_RECEIVED:
 	case IB_CM_USER_ESTABLISHED:
-- 
2.20.1

