Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06559375D9A
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhEFXkl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhEFXkl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:40:41 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26AC061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=suRtG7wCehN8DQZCt/GewGNzt5u6D3ch0EGVmqJ1cvw=; b=2LaG0ihGbW6NcZpneqZ/rkBq11
        mhevPOXy03b47WpgNX3pqS7CTHPwoUI/1BbsveMbThBifH0eWEV+xfT6ePAEDDclqCbQoRR9umBJc
        sVQ4pkp4M++GgobpMZrt9DzWHdXKpzQ1YGGs/HOGMt7b+FDmTC1PmaaEnAyF2ibNkcX5Xra/BsiC7
        Y8gBNYph5zRK9r+l6x0j+qE4whbhMtdvNs20wm1f19p56xEMjCY+1XbqOJ3S7+hr5uG91mQaAOfn7
        7N1NhcxqblMM2p9bxNwp95jQHxA/qyjfiQn02hkYpZPRbErFu+UqNmPHVtvrkauByw45fC9HvxAT7
        mLYH4c8aAFhbFqFZs20TVfzUdVX18DXpRESNFMQIDBfX/wCqTfuMTE4Nr/sOm55sauHyMT6iYU7y6
        R3ScHRGMdfKf4a1AYCxnEfUoSMbCDknfBX1RAP8qFVHhOhak185RVRZLaYMmgAtvaUHgaeHCalbw1
        8CFV3TOuYjcQvcVqLiD+Q1mU;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenam-0004Nw-NA; Thu, 06 May 2021 23:39:40 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 25/31] rdma/siw: fix double siw_cep_put() in siw_cm_work_handler()
Date:   Fri,  7 May 2021 01:36:31 +0200
Message-Id: <5f9dda492f0ff3ff0f858c9ee604f7ca8f179336.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We never do an additional siw_cep_get(cep) when calling id->add_ref(id),
there's no reason to call siw_cep_put(cep) when calling
cep->cm_id->rem_ref(cep->cm_id)!

I saw this happening quite often while testing my smbdirect driver
and the peer already reseted the tcp connection.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 31135d877d41..a2a5a36370af 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1252,7 +1252,6 @@ static void siw_cm_work_handler(struct work_struct *w)
 		if (cep->cm_id) {
 			cep->cm_id->rem_ref(cep->cm_id);
 			cep->cm_id = NULL;
-			siw_cep_put(cep);
 		}
 	}
 	siw_cep_set_free(cep);
-- 
2.25.1

