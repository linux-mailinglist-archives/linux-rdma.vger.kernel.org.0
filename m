Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08B375D89
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhEFXjD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhEFXjC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:02 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA8C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=6ZjFxhlfrxPhnxtbN+9Rvmz4gSbJh7L75ocIj3yOLoc=; b=MqrbQvWpUpcS3Sn+viqbxwO8xN
        BBsBLQ25W7uonyoPdpPuXfX3nZN2vlTLGx+EsK6dGAN6msAztSw3S96F+V4oMlUvgHg5SBpt1tV7J
        T/SfdzadA1dM3WpvkIX9A7OjtPiVpedQZ6eds2Dldq6Twrn1SDDqD9LJdAbNdAketbquoSErX8Nne
        gEuYT+YCEXYC6jvo+c10VbezRyBwB40m2YddT1NNw7DmJzAZ9DbBDoHIlM71Em5+jjlHmxbblYyCO
        uXIfa9Ge/aS4uyAcC2HUKKjWBVLnpNnc5V6pr4FEJkrIAWWmaKhBHgD2NyhVRglrHr9M8U12CxJlI
        CGwQ4SVVLWA2s3nwG/oYJlfPycRp8nrJAnYgbgocbrCFqF8riQby8bolwX5R8G6C8i/guYbMLYKac
        DmYlebUsq9P0MAn5BKmwbQjwqXd9c7mBlbWK+c6AXV+f7TeUcBUjqPyAHJUlGlX4DxDKLemo/l0Q1
        ilcJMa+12dOhsYmT8v30Yw+Z;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZB-0004KO-MG; Thu, 06 May 2021 23:38:01 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 10/31] rdma/siw: use __siw_cep_terminate_upcall() for SIW_CM_WORK_MPATIMEOUT
Date:   Fri,  7 May 2021 01:36:16 +0200
Message-Id: <6ba824c412e5535b70683676734bebf82a4f325f.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's easier to have generic logic in just one place.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 31 ++++++++----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 5338be450285..d03c7a66c6d1 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1127,31 +1127,16 @@ static void siw_cm_work_handler(struct work_struct *w)
 		break;
 
 	case SIW_CM_WORK_MPATIMEOUT:
+		/*
+		 * MPA request timed out:
+		 * Hide any partially received private data and signal
+		 * timeout
+		 */
 		cep->mpa_timer = NULL;
+		cep->mpa.hdr.params.pd_len = 0;
+		__siw_cep_terminate_upcall(cep, -ETIMEDOUT);
 
-		if (cep->state == SIW_EPSTATE_AWAIT_MPAREP) {
-			/*
-			 * MPA request timed out:
-			 * Hide any partially received private data and signal
-			 * timeout
-			 */
-			cep->mpa.hdr.params.pd_len = 0;
-
-			if (cep->cm_id)
-				siw_cm_upcall(cep, IW_CM_EVENT_CONNECT_REPLY,
-					      -ETIMEDOUT);
-			release_cep = 1;
-
-		} else if (cep->state == SIW_EPSTATE_AWAIT_MPAREQ) {
-			/*
-			 * No MPA request received after peer TCP stream setup.
-			 */
-			if (cep->listen_cep) {
-				siw_cep_put(cep->listen_cep);
-				cep->listen_cep = NULL;
-			}
-			release_cep = 1;
-		}
+		release_cep = 1;
 		break;
 
 	default:
-- 
2.25.1

