Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D902375D8C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhEFXjZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhEFXjY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:24 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33610C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=pP9BzoMZjNMJ0mB7ftvb70BJHJszpGFSWVB6rbAoomM=; b=BqtmOIccP8IHEMpGM7FWZLyymF
        Sbwq5Iv9qtVgsV21SrkkyZ/bfFo6EAxS2ysjLrxLEt1ctEef1se9QIf2OeLezQymeopvxuhAQbU0s
        MYY3ydeLq1J2Utz+brPS+DF2l0zUKe3r5wCl5hpLrAMCi7ipqTXgPUFdpDI8gNcjcUK04m+7nXfU4
        HyKqyv2uUcPTCGEYQBtFM13y9hSKesaMg8uc6EuTUgoSaavJgSxmsbTAO0iKYWwsPIrtV8R90AmII
        Cpot7p2MHdoQNlNCdQuG1+LtKMJ6YUyK0nlq8/U78z4gqmWTbkGCPaPEr12/DeWa/w6jEdtensrZp
        mKZvn42MxfaiL6mJl1Noh7DIJemvzUyYZ1UYStWLS3QC+ebxfJG/6z0Oa2jHelSMqbLqsST1CbLBF
        C1Z65Wgw5PqN7d3pxGmc8fLKQMsdckUcTDYGSZ7OAe1ltxuSfiDwgs9/qc73B8yekkmIqrZEe06PZ
        gW6TZaKeE+HJ5xnlvdUxcqcZ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZV-0004L1-66; Thu, 06 May 2021 23:38:21 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 13/31] rdma/siw: handle SIW_EPSTATE_CONNECTING in __siw_cep_terminate_upcall()
Date:   Fri,  7 May 2021 01:36:19 +0200
Message-Id: <d02191b24aa880a2be8136ae6c96f69baefcd394.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The final patch will implement a non-blocking connect,
which means SIW_CM_WORK_MPATIMEOUT can also happen
during SIW_EPSTATE_CONNECTING.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index ed33533ff9e6..8e9f5ce5ce29 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -138,6 +138,14 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 	}
 
 	switch (cep->state) {
+	case SIW_EPSTATE_CONNECTING:
+		/*
+		 * The TCP connect got rejected or timed out.
+		 */
+		siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
+			      reply_status);
+		break;
+
 	case SIW_EPSTATE_AWAIT_MPAREP:
 		/*
 		 * MPA reply not received, but connection drop,
@@ -202,7 +210,6 @@ static void __siw_cep_terminate_upcall(struct siw_cep *cep,
 
 	case SIW_EPSTATE_IDLE:
 	case SIW_EPSTATE_LISTENING:
-	case SIW_EPSTATE_CONNECTING:
 	case SIW_EPSTATE_CLOSED:
 	default:
 		/*
-- 
2.25.1

