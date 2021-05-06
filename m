Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A148375D8D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhEFXjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhEFXja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:39:30 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD629C061761
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=ofug5v24UpU4dzRHZOy8hbAsCgib2HTwXBwMiFH4lEU=; b=Guh6ZdvpodlKLsniPJf1s61d2T
        o1z7ydZw8QXTFz7ogQr8wFHHSSgPJyMbzOuaEL0jeeRxKtYv9zuhpKPM35L43krdz1HL0Nf5f0UTq
        SBcXJB/sUx5WLnVw+C0lOA5tp57oukowJnl49ny06OUPMAA0nL/e199o7AIATXOtcI49FkhO+AQiu
        1ne1OYFPsgI9IdO5L7GJTvBkOsbxdvmlbFML7KVx6dY0eRWU5euC6TLwTGH5o8Q5nYZc0ICGLaFPd
        M96g3hQYt5VJV0UBhwulbwaFNnis7rrJsC98eR3oRFk/hO+xxlt0Pn2DUcxONdqpAGn1zcghZE8iQ
        52mkEH8XHGOJTWgKvO+7FqEZhwWDeFd2VY5TEMJU2zjZLj6xHtxx7KW6UhJ9GgM2Jb3JNKEpiwnrG
        cxFPJjLeI5hZ1tRY7tOKIHhWytedCJZoCS5SxaM6jjN87eI3Z20MP6ar1e7pdZOrAluaFwL+4tVvj
        N84jh/chAikwnvPnyshGdFMl;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenZc-0004LD-Ss; Thu, 06 May 2021 23:38:28 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 14/31] rdma/siw: let siw_connect() set AWAIT_MPAREP before siw_send_mpareqrep()
Date:   Fri,  7 May 2021 01:36:20 +0200
Message-Id: <ec66fa24f5b9cb320d1ce067139bcb3a5f46187f.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There's no real change made in this commit, but it makes the follwing
commits easier to review.

The idea is that we stay in SIW_EPSTATE_CONNECTING as long as
we only deal with tcp and not started the MPA negotiation.

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 8e9f5ce5ce29..027bc18cb801 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1477,8 +1477,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 */
 	siw_cep_socket_assoc(cep, s);
 
-	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
-
 	/*
 	 * Set MPA Request bits: CRC if required, no MPA Markers,
 	 * MPA Rev. according to module parameter 'mpa_version', Key 'Request'.
@@ -1521,6 +1519,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
+
 	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
 	/*
 	 * Reset private data.
-- 
2.25.1

