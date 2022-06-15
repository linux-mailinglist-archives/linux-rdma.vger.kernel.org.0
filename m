Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77A854C3B8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 10:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbiFOIle (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 04:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346532AbiFOIlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 04:41:21 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDE44AE15
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=8lmA+8ryXLmsg83Rufbtg4k6StXa61BzR9Q+RfHAEIk=; b=eFdnVhYbZP4B2ZuuX1vfiy9JR8
        qw5eppitylKPtuDbcjM2Vh/0EcRYFZBLhGxeTbwUBPI6NRoUooDxfwQOb0pAgZ/Bz0CN1UGRN5oWE
        gDij2uWq5Idxf73HXHWcww1nAEYDiuzqKZVNz3O6LXZsJ8UCu/FN/1fWXuc/AxtL4bb4oIJGe5nIg
        OoYaE5r7CYEtBomSkejfJGPQu1Y/UhjFDvkH2MdRVmsL0SMunqIlpzVs+0ySt6Rv1gQBYnTtLLoya
        IdVP4IORGfvURI3CZ5fbkxT9UApU2CrYueu4rZMR54R03hCeZpnxGLT0XKPl9nZfAk63W6MwwKTTO
        gHz+2afQKz6aY5OwbI1qomhxsdtULFfjUIA7AEz/fBfUOi5B/N0BXVcjgo2eDOJwBSV8Hj0EuOoia
        RJUS38x+XsurxojgU7jAk++kRk6+LGhRL5teBRilGOCW6qvJDBvtMp2vjyZyWC08qvvrbkzBALAYQ
        4cTQwVXGs4kkk81J7n0pEvfF;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1OaU-005p9Q-Pj; Wed, 15 Jun 2022 08:41:18 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 2/7] rdma/siw: let siw_connect() set AWAIT_MPAREP before siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 10:40:02 +0200
Message-Id: <d8604eaf61350d8e43e73bba03a26c6e45005ff1.1655248086.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655248086.git.metze@samba.org>
References: <cover.1655248086.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 644c7d50e991..8d1e7f497cf9 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1425,8 +1425,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 */
 	siw_cep_socket_assoc(cep, s);
 
-	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
-
 	/*
 	 * Set MPA Request bits: CRC if required, no MPA Markers,
 	 * MPA Rev. according to module parameter 'mpa_version', Key 'Request'.
@@ -1469,6 +1467,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
+
 	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
 	/*
 	 * Reset private data.
-- 
2.34.1

