Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43662375D9E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhEFXlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhEFXlH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:41:07 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9E5C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=JbXbd0iFD8gwymEMDg823u7WKB24KxLxzjjSRxw9Ws0=; b=fp/VzCJubSnG8Yuso7CqXGZ3yt
        EJlhEk1DjLQj3eH9RICS6iY6xAF58i8peLW1sSmgYP6ZPJjv/1BuooP6TNboQZGhfIupuSoVCI6IF
        2HqBDDdw6TgTB5t4TUAKfFQ1/+yEsUUVyS4OSRiC9UA0OzBW6otrrtHANDcfMJdCNqF4eUH/0LKic
        pie/TjkMlMLQbbhiioK16iufJGXK/ZXSxWHBKbNzcqIHf0f2Dy9amfuBajs/QQLChEbBg98yI9sY0
        0/4GznWhUsLnnf91HA7goHXTBoKw/kYgdEaXy+rYcT3Q73Nv24RhO7qUqmXurgIXRaGB7+UhpHNC1
        X93Y5SsxwG4laJAeTQZIHIY6E2gVmXtzO5LD8733CkZlFMX6m7qCLxaSFJUOAqw8M2abun4guJLbw
        eDekhMzvEnYgiWfivpC7HhOzTJ8t8HSndO0fJqvaUDIbok8l6lUn2+hS8SJqSwMkGpgEg4/+GfeXq
        Lr6PzXpZ4h8uwje9ZyFHwCUc;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenbC-0004Op-C1; Thu, 06 May 2021 23:40:06 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 29/31] rdma/siw: make use of __siw_cep_close() in siw_reject()
Date:   Fri,  7 May 2021 01:36:35 +0200
Message-Id: <41aaa6bb913455f197b189a36ebc033f31de66fa.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is more or less a consistency change, we should always
go via __siw_cep_close() to release the socket in order to
avoid problems in future.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index d2b1c62177ea..4b789379f676 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1841,12 +1841,8 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 		cep->mpa.hdr.params.bits |= MPA_RR_FLAG_REJECT; /* reject */
 		siw_send_mpareqrep(cep, pdata, pd_len);
 	}
-	siw_socket_disassoc(cep->sock);
-	sock_release(cep->sock);
-	cep->sock = NULL;
-
-	cep->state = SIW_EPSTATE_CLOSED;
 
+	__siw_cep_close(cep);
 	siw_cep_set_free(cep);
 	siw_cep_put(cep);
 
-- 
2.25.1

