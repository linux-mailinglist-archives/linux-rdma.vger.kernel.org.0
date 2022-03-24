Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE44E5F21
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 08:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348435AbiCXHNS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 03:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348428AbiCXHNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 03:13:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B982998597;
        Thu, 24 Mar 2022 00:11:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so7344684ejb.0;
        Thu, 24 Mar 2022 00:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScT1N7/lT5zBShi77/Y7VpSisv0PuxrJFygXYwGxCSc=;
        b=NCJHIvzITK819g/AraI9S5Khd5ZmpxE6SBbBb7kNqvcrFK4CAGQrSCs7OoG0/azTfR
         loiReFmMF01tZU7sHvSDZTyJAuTajFpY010B1LoAlZe9pB2khm/6DavIiXvlBqzYf7F+
         U3H2RqMjDTH0X0bgTTIZIpv7rXZJUpoNqV7m8g35J7XvIWJHw1jnU04NjcrqxZN9BIJs
         n7hx3pzCnOxMVJ5FSbQ5K8ol0Jne/tIS0oHhcbbB2zyB0cclKP4+sjBLC6JFyDgETvrp
         FutlOfJqO/yrksQCg5l2GVyEJNbWMqb/nunL2hljXBseYgJWrKryvbxhQFj9A9ScrtMg
         dcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ScT1N7/lT5zBShi77/Y7VpSisv0PuxrJFygXYwGxCSc=;
        b=DwNsyoByL+gcvKRyRMYDgoN9utxE8UGUemfG6lnYZT5K6UNJFXcUMm4d4UrWd747rL
         CmhvXaMYWq7/0KqGM7yjdnVemKcAISiq2LTWxWOm5//vOeeSVwB2lsbLGiMgxO2IjO0N
         BYVyP0VlFoTJKDYPQv22f2RE0RD0WvRIYiTVlzUhjedDEswKejePfNUFruSxNCCSztjW
         akjE0F1JCeznzrA3dizSegoeCUJkJarUYksAxl0hG+ZzdEu5SL35rykMeSVhZBMrk+/o
         GNDUkDXVmNgkw4W8UW0+Q8Bp0s+L5TBlvIVMoJf716I4ThgiW1SsEYbebamvwyrvz1/e
         6y6Q==
X-Gm-Message-State: AOAM5330i/yxhP792ZWG39mam+4+5hTA1eMtasAynfhOLEMayrBq/KcE
        yMK0JhHgpXZhp1qr1zquMFg=
X-Google-Smtp-Source: ABdhPJwTOj8uH3IpGqcP9I4gWZC0KuDvvKH1DU1VmphfuUNO/KS0sMCPi5L1Ip668H7RtgIJAjdBhA==
X-Received: by 2002:a17:906:d554:b0:6df:c373:9e5f with SMTP id cr20-20020a170906d55400b006dfc3739e5fmr4115063ejc.645.1648105901332;
        Thu, 24 Mar 2022 00:11:41 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm981781edu.76.2022.03.24.00.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:11:41 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] IB/SA: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:11:24 +0100
Message-Id: <20220324071124.59849-1-jakobkoschel@gmail.com>
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

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/infiniband/core/sa_query.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74ecd7456a11..74cd84045e5b 100644
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
@@ -1046,20 +1045,20 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
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
+			if (!ib_sa_query_cancelled(iter))
+				list_del(&iter->list);
+			query = iter;
 			break;
 		}
 	}
 
-	if (!found) {
+	if (!query) {
 		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 		goto resp_out;
 	}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

