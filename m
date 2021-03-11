Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D15336A7D
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 04:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCKDOh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Mar 2021 22:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhCKDOb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Mar 2021 22:14:31 -0500
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8804EC061574;
        Wed, 10 Mar 2021 19:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=zCNqttcaFW
        TtybUdDPtqNAqitPAbuSHYmg9++K2KPdI=; b=ZYqnpU5yM0UAXUDrvL0LGlf6DE
        ARG+QgAVsl6PgTFpiMv3OfuUtI+BVcRBQ8xYY5WDdZbQQWj+tWM18hC4swsmmxTK
        /vyp74fPf6xmG6U9gscNczrRC4NAremHgpejiRoS/slUimItyy5EG7X8vHcXkTix
        7g79KQOkeVXK7AkkY=
Received: from ubuntu.localdomain (unknown [114.214.226.60])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygA3PT0Ji0lgttcIAA--.842S4;
        Thu, 11 Mar 2021 11:14:17 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] infiniband/i40iw: Fix a use after free in i40iw_cm_event_handler
Date:   Wed, 10 Mar 2021 19:14:14 -0800
Message-Id: <20210311031414.5011-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygA3PT0Ji0lgttcIAA--.842S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1Utr4Dur1rur1DurW3Jrb_yoW8XrWxp3
        y8Wr9IkF4DXFyDur9Yyryqkry3Ga4ft3yDK3s5G3WrGF98u3s8JF18KrWjvFZ8Aryfuw47
        Aw4DKr45WFW8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
        648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOl
        ksUUUUU
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In the case of I40IW_CM_EVENT_ABORTED, i40iw_event_connect_error()
could be called to free the event->cm_node. However, event->cm_node
will be used after and cause use after free. It needs to add flags
to inform that event->cm_node has been freed.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index ac65c8237b2e..447b43c2d21f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -4175,6 +4175,7 @@ static void i40iw_cm_event_handler(struct work_struct *work)
 						    struct i40iw_cm_event,
 						    event_work);
 	struct i40iw_cm_node *cm_node;
+	int flags = 0;
 
 	if (!event || !event->cm_node || !event->cm_node->cm_core)
 		return;
@@ -4211,6 +4212,7 @@ static void i40iw_cm_event_handler(struct work_struct *work)
 		    (event->cm_node->state == I40IW_CM_STATE_OFFLOADED))
 			break;
 		i40iw_event_connect_error(event);
+		flags = 1;
 		break;
 	default:
 		i40iw_pr_err("event type = %d\n", event->type);
@@ -4218,7 +4220,8 @@ static void i40iw_cm_event_handler(struct work_struct *work)
 	}
 
 	event->cm_info.cm_id->rem_ref(event->cm_info.cm_id);
-	i40iw_rem_ref_cm_node(event->cm_node);
+	if (!flags)
+		i40iw_rem_ref_cm_node(event->cm_node);
 	kfree(event);
 }
 
-- 
2.25.1


