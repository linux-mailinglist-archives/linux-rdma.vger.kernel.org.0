Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DE375D85
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhEFXig (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEFXig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:36 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB923C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=EttQSPx9qFq19Vtxe3NdZwcx7Qs093v7/weRoUUFNU4=; b=rEB0e+35SWfDhFzNVWTXPp+HZW
        rraYPY30fcbctlb4D5Cv/TnT1pgxFVuqGxagftClO1GqV8GGjw/8lWBdRcEZo8hMc8CDUiwdfVRF9
        LZRAfnKFKKW5AM8Q8BAtZKV8cfz71dpdoj+/dxMykiSCVHOyrEM/bvZnN5vDcsdvxVYgdC+Yh8iyN
        7SropswS2LxVHq3PR7lrL46kkbcP7XWZVw3jH4aOmKSDidhDzP8FhZVXPecjMA0uwB0UypBvXO1mC
        tf7j1QR9QMiLoEsvtMEg1+Z9WNc4FM2NciPOfO9Pj6VJtx6gH9+/tEBHQl3rpJKcH0e6JVRgToiva
        tognghL1bPK7PmseN4B6dUHVzXwKzzvXPTw0C+RlTNfYRc8Do2/LuUNHvNYvhAPoSUVa/ZzRGDEct
        hGwTak5rLF+PZRC07/YolUTGpjzJLnuNwz2+NahEjIB6VkE0i5+/4xB+9OEN69WNKVX/G0lD+kDTz
        PGn96m90oZu2qJJhCbqCyc38;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYk-0004JO-VB; Thu, 06 May 2021 23:37:35 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 06/31] rdma/siw: make siw_cm_upcall() a noop without valid 'id'
Date:   Fri,  7 May 2021 01:36:12 +0200
Message-Id: <3a85c3d589b8fd86193c871c84ae4c4e0a60bf4a.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This will simplify the callers.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index e21cde84306e..2cc2863bd427 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -324,6 +324,9 @@ static int siw_cm_upcall(struct siw_cep *cep, enum iw_cm_event_type reason,
 	} else {
 		id = cep->cm_id;
 	}
+	if (id == NULL)
+		return status;
+
 	/* Signal IRD and ORD */
 	if (reason == IW_CM_EVENT_ESTABLISHED ||
 	    reason == IW_CM_EVENT_CONNECT_REPLY) {
-- 
2.25.1

