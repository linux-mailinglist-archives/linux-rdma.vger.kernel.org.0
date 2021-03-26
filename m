Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3133834A67C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 12:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCZLe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 07:34:57 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:47966 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhCZLel (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Mar 2021 07:34:41 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id EDF259802E6;
        Fri, 26 Mar 2021 19:34:38 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] infiniband: ulp: struct iscsi_iser_task is declared twice
Date:   Fri, 26 Mar 2021 19:33:46 +0800
Message-Id: <20210326113347.903976-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0lJSx8YSEoZHkgeVkpNSk1MTkNPTEJKTENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Mww*Sj8PQzxITBg9Skgc
        AREaCRdVSlVKTUpNTE5DT0xCTkhNVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTU5ONwY+
X-HM-Tid: 0a786e5098fcd992kuwsedf259802e6
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

struct iscsi_iser_task has been declared at 201st line.
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 78ee9445f801..9f6ac0a09a78 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -297,7 +297,6 @@ struct iser_login_desc {
 
 struct iser_conn;
 struct ib_conn;
-struct iscsi_iser_task;
 
 /**
  * struct iser_device - iSER device handle
-- 
2.25.1

