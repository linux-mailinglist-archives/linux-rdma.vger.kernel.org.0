Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898104E8A37
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Mar 2022 23:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiC0VcA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Mar 2022 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0Vb7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Mar 2022 17:31:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0932FE56;
        Sun, 27 Mar 2022 14:30:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qa43so24911871ejc.12;
        Sun, 27 Mar 2022 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xA5oCyfiJYaNAgB/bEJJxA3FBMRY5wTuBnv+OuT16p0=;
        b=nr5PYmuLrwHeD+CAZyhPp1njB9vkYw9iEoobgsjwJuQBkEsAMYyCaXy7+pSryMHqGE
         O40dA/lxPRmnGVyey6vTn2GgAMt9C83v9wv/Y6Arj5sPFLZG6o2Cy1GZoRo5VKlyjLAU
         jHFPg3Ayqe26hFtuMIirIgizJzlsHDlFVOzVAx8mrc808pif1VD9l1xb1AkfCWv3CObc
         5jEI3BS7ZebORO+Px+trRXOzuF9nbmVwo7jvMFXVP/94t5iLmE11diHOXc4+GM/ZWZhT
         JLsWOHve/BdN0K2a5UEEDDh9OKfxORrLkAVpL/vso7JuDozduEbGbj0kijf8Ih6LJrxt
         2Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xA5oCyfiJYaNAgB/bEJJxA3FBMRY5wTuBnv+OuT16p0=;
        b=Vq02RuajnHeN+gWKhjQ/RkaAGVWw8eyZHnuKXcg66BE1HaulFnhazra/I6f9OoZsU4
         Jr1Z6qC80POpS6BK1GriISJbLlCKHPWzaezdNbng8LlWdEyVpOpSfxdnf9sdK9uLfOJ+
         qGHAqPUe4oc6qCpep8XabsMBxb0SDsjEUjzrwyUgeRMz3a27k05h4wrk55o81iPYRZ0g
         4JQmEXWaR8/44M0c4C3MTtR/St9paEsOQErzWdeVwzihy2rKSEDuiXAouXEZUb8tyziH
         nUjCCTu0xhRgGBme4ekCWuivmsETsVQaTaZbQ2k2iCu5mUGjLoLrlgOoBA3gUi6Chpwf
         Xhpg==
X-Gm-Message-State: AOAM530mvthWor0F84bv+0G9ECNi+lpIrGXVZzefUuqQxZIiDE1qr2WX
        +Prm/fejyCl/4y5UMdesOBo=
X-Google-Smtp-Source: ABdhPJx56d7M0sdeJ6YeQ2Nvz0sSKeO6gH6+YQw3oxJeqRPM1YlM/4LGsulwh2vKvwuoldcVpqXfqg==
X-Received: by 2002:a17:906:2991:b0:6cc:fc18:f10c with SMTP id x17-20020a170906299100b006ccfc18f10cmr23664954eje.744.1648416618303;
        Sun, 27 Mar 2022 14:30:18 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g20-20020aa7c594000000b004194b07bbfasm1707968edq.10.2022.03.27.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 14:30:17 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH v2] IB/SA: replace usage of found with dedicated list iterator variable
Date:   Sun, 27 Mar 2022 23:29:43 +0200
Message-Id: <20220327212943.2165728-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

v1->v2:
- set query correctly (Mark Zhang)

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/infiniband/core/sa_query.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74ecd7456a11..ed26066b706f 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1035,10 +1035,9 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 			      struct netlink_ext_ack *extack)
 {
 	unsigned long flags;
-	struct ib_sa_query *query;
+	struct ib_sa_query *query = NULL, *iter;
 	struct ib_mad_send_buf *send_buf;
 	struct ib_mad_send_wc mad_send_wc;
-	int found = 0;
 	int ret;

 	if ((nlh->nlmsg_flags & NLM_F_REQUEST) ||
@@ -1046,20 +1045,21 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
 		return -EPERM;

 	spin_lock_irqsave(&ib_nl_request_lock, flags);
-	list_for_each_entry(query, &ib_nl_request_list, list) {
+	list_for_each_entry(iter, &ib_nl_request_list, list) {
 		/*
 		 * If the query is cancelled, let the timeout routine
 		 * take care of it.
 		 */
-		if (nlh->nlmsg_seq == query->seq) {
-			found = !ib_sa_query_cancelled(query);
-			if (found)
-				list_del(&query->list);
+		if (nlh->nlmsg_seq == iter->seq) {
+			if (!ib_sa_query_cancelled(iter)) {
+				list_del(&iter->list);
+				query = iter;
+			}
 			break;
 		}
 	}

-	if (!found) {
+	if (!query) {
 		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 		goto resp_out;
 	}

base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
--
2.25.1

