Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2761654CCDF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiFOP3A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356054AbiFOP2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:28:44 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D841627
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=w617rm3oZUEYJKGoyPrQTxhDUo13rDhgNJvJO7+eoSc=; b=T21IigJT9qYcPyqIPYE7rYhxGO
        THvKb5TtLkdaAueUtbsj/itoH3DfSDxOhzKhqhSgk+KpQ2iy3/w9esl7E0ZtG3W+mxgbVDRhcmzlV
        eDs26mmxLJ0EFbZHyK0OK3WR0rLM+YlRVK5D0hVU+ujHeGBvn5xCl2yI5thvrtY2v5m2AZa+lbIeQ
        36zuyxXuNvGNwAflT4FGHOTKOf61wSEhqFNaCakUI/kHC8AuZKZFLxeq5soLriuaQ1EV/RQkyWP6Y
        ONf8frHAIwB7vRYk9/IeXgl8wWNW9Zb9uxqb+WYrAEGnbKrUlvZ08atbsHtSlRLGb2pIFfTDGfzw+
        fgxu5EbddF1eN9euUr3i581SXhMf7HqNJY65j5ffck8h9cg3bMYFah0JT6oHXp3YzAulblK9X/Z41
        xr8XkM3YPckykYCVxmyhDJQRUxN3dfdA/Ddg+TItE45pMmWkVUddC8VtGqK3iKqPr6jy1yVjrdYwr
        xFK2x5H9S+tlt3///p1/bPPM;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1Uw7-005rvh-Sj; Wed, 15 Jun 2022 15:28:03 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 09/14] rdma/siw: let siw_connect() set AWAIT_MPAREP before siw_send_mpareqrep()
Date:   Wed, 15 Jun 2022 17:26:47 +0200
Message-Id: <b1ee74975ad57b75a4a8ca59af30be108a843b20.1655305567.git.metze@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655305567.git.metze@samba.org>
References: <cover.1655305567.git.metze@samba.org>
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
index e8e29ce609b4..c980e5035552 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1438,8 +1438,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	 */
 	siw_cep_socket_assoc(cep, s);
 
-	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
-
 	/*
 	 * Set MPA Request bits: CRC if required, no MPA Markers,
 	 * MPA Rev. according to module parameter 'mpa_version', Key 'Request'.
@@ -1482,6 +1480,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	memcpy(cep->mpa.hdr.key, MPA_KEY_REQ, 16);
 
+	cep->state = SIW_EPSTATE_AWAIT_MPAREP;
+
 	rv = siw_send_mpareqrep(cep, params->private_data, pd_len);
 	/*
 	 * Reset private data.
-- 
2.34.1

