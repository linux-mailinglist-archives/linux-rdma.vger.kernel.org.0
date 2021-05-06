Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B605F375D81
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhEFXiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhEFXiR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:17 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827D0C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ubyzdjgArwbl4wlyloJfQHZi7RLBbfptfNOQg3lc/+M=; b=pcux5lkKe25AvO7tzAdqbXHhzS
        pwMicnijMT1FNPmoaZTS9qptzhKTGRZseDdO7+3OEQTa0wzsjNrsBV6YgByTAJ02ck+dksQrBgvdS
        mZERa57JCWkcT4GqPwLiebovgxJJD2KQ+jkawaUH/XMgyYNAiljndnPMcah2XuX3NcVH1BItXpzHt
        Ap/EIKY2M2zRiE+FrKnAP+lsLrJKybkNk8u5LjJrAENSxfHbZhy3ExA8MSWSjMgfXNTEIu7I+KWJ2
        jWKOUFw5udrEeOmX6jal1KyYiOjwIuRiD6Rq9rmL+RI1nx8cHLM/yoiMMx7tAtX/JDp47a6O5DCEM
        p7I9WQqHGzYmWswQvx9g+0DIn91vF7iqWPvVbLdIegiIE5oJnq4q4IvNli/zsp95zWHZLrFi3A5TA
        W2RKYWu4tUA99V3uFZNmhZhAQFTQxsDAjIJI2DXN5oeStU+tGVnV1c11jd5cbdSYOtvBWRimQjlAk
        l/VK6QBO39j+sj8XglZO7jXi;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYR-0004Ib-LG; Thu, 06 May 2021 23:37:15 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 03/31] rdma/siw: remove superfluous siw_cep_put() from siw_connect() error path
Date:   Fri,  7 May 2021 01:36:09 +0200
Message-Id: <66dd3e80886db4a9fe1795ecd906330255923625.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following change demonstrate the bug:

    --- a/drivers/infiniband/sw/siw/siw_cm.c
    +++ b/drivers/infiniband/sw/siw/siw_cm.c
    @@ -1507,6 +1507,9 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
            if (rv >= 0) {
                    rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
                    if (!rv) {
    +                       rv = -ECONNRESET;
    +                       msleep_interruptible(100);
    +                       goto error;
                            siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
                            siw_cep_set_free(cep);
                            return 0;

That change triggers the WARN_ON() in siw_cep_put().

As there's no siw_cep_get() arround id->add_ref()
I removed the siw_cep_put() following id->rem_ref().

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 7a5ed86ffc9f..da84686a21fd 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1494,7 +1494,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
-- 
2.25.1

