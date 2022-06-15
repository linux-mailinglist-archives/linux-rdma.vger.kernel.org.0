Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E9954CCE6
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jun 2022 17:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiFOP3g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jun 2022 11:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352232AbiFOP12 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jun 2022 11:27:28 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA9146651
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jun 2022 08:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=m1PuB1qtxm4ghj9lajtZ3bMOFp5guBs3P8avzPP57xE=; b=Qma86r0wiyVdYETOfZXZaduzu8
        l7lzNEU2x1j+Yc19HIErFd0wtMPrJLYpOJsXZqg+V0dz+a8HtlzbamNcErm7WYwxhU329lEkUO7U0
        STWzqbyVwewGaiYqOxIjivrjbIPECeLVSs9n0C8Z0QoBzNYM7ZeAfqPoFqaoaOhPjeNUlAIQapfx9
        p3CIvesoZB9tq4jCKj/WFyh7Iocy/lJ8wC2UVmWHUnPil5nlgVQps37Z7XOkEG5t6mBNn2GiaxZYO
        utgRsfQJrc+0YdlgEEcd04USuGx61CYfqHGKYXfLruODdMD0fsc/RbpSRJVTA1CNQEK3IC2zvVjj0
        3D3TMkKcbhh4sUNZWrIhEONwhSF5w7gwZt/PPKmxmB/k4dW1Ll6jTQuXyYAQwV0Okig7hKl1AXIgi
        2PlVzz2QE5ZrfR1mcK0Rbw0GpNOCF68EV77WPvUeUSdV2M3FXVg8rsIzCTym/oHZleJw96eCxdw1V
        fnAgrupUCuBrqx5OqExxb18N;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1o1UvF-005rt3-Lm; Wed, 15 Jun 2022 15:27:09 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
Cc:     Stefan Metzmacher <metze@samba.org>
Subject: [PATCH v2 01/14] rdma/siw: remove superfluous siw_cep_put() from siw_connect() error path
Date:   Wed, 15 Jun 2022 17:26:39 +0200
Message-Id: <c9e20954d77adac50759babf71f51661222cc590.1655305567.git.metze@samba.org>
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
index 17f34d584cd9..a8e546670d05 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1495,7 +1495,6 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->cm_id = NULL;
 		id->rem_ref(id);
-		siw_cep_put(cep);
 
 		qp->cep = NULL;
 		siw_cep_put(cep);
-- 
2.34.1

