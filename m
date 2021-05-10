Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF6377C5A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhEJGiK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 02:38:10 -0400
Received: from mail-m176216.qiye.163.com ([59.111.176.216]:49726 "EHLO
        mail-m176216.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhEJGiH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 02:38:07 -0400
X-Greylist: delayed 484 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 02:38:07 EDT
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m176216.qiye.163.com (Hmail) with ESMTPA id 673CFC20186;
        Mon, 10 May 2021 14:28:53 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] RDMA: Remove unnecessary struct declaration
Date:   Mon, 10 May 2021 14:28:42 +0800
Message-Id: <20210510062843.15707-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0xDSVZPGE1OSxpLGUxLSh1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6PAw4NT8SET4iKDk#KCpN
        KjEaCQxVSlVKTUlLTUlDSkhIQk1PVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKSENONwY+
X-HM-Tid: 0a7954f6d6d0d976kuws673cfc20186
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The declaration of struct ib_grh is uncessary here,
because it is defined at line 766.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/rdma/ib_verbs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 7e2f3699b898..18a7a786711f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2139,7 +2139,6 @@ struct ib_flow_action {
 };
 
 struct ib_mad;
-struct ib_grh;
 
 enum ib_process_mad_flags {
 	IB_MAD_IGNORE_MKEY	= 1,
-- 
2.20.1

