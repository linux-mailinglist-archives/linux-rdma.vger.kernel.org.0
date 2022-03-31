Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F54ED6A1
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbiCaJTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCaJS7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 05:18:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CEB4A;
        Thu, 31 Mar 2022 02:17:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y10so27389858edv.7;
        Thu, 31 Mar 2022 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPHn1LL6zDM+73MSZ/MbfXeBZkpfR8F/aK1wIS6jVAg=;
        b=F0WlmgYX19BNZbar9zSIc+QPFMYvfmXQ6JpvRv/ZUvcab4U1wG/P8uze3G4+5odule
         JsEON2sQQ9M1dfsiV2R9W0a7E4epQllDieM9VPDDclMsRYSl+WNuxH2Wau1R+iBu4p6y
         LoSQmtBC9tug4aY3OiP+pX6pRbH+MtbFURTSarAo+De1LYRCIK2bdP4viYzrWuXuRkAI
         yI67Ggqh8fymEGSFrdwVZrcwQxck6NDvGbIlgI9oX/jy7ZF4aH9zxzQuDecfFmtt2v1d
         qPp1Hn+bTSPrP7b1rP2xFdISMWqb+jhNZa/aOvhUpJY6kZmPGnKQGypqDSge5bHtAwHD
         VIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPHn1LL6zDM+73MSZ/MbfXeBZkpfR8F/aK1wIS6jVAg=;
        b=sIiTEeRYqEFE0YG7hMOCZ76aOk1+zqkcKDzzKOvk0oT+7jw6OK4e9zzSaTpz2NmBuq
         gOSdpyTfrMy+w7YEkLgz45pZSt7yO8fj2wXr8ncYUXFqzCl57C7YfQxciakxTW38sLTA
         fVzV+WFzRYZk+ZXP39xETi5rxV/NUlkQJFJBbNZpO+SjUOtyKJm/PpeSIfKnJgT4fsgr
         sZcHz9M2s8dWBUXqZj+Cn+4OdQqiq4Hrv9qYF5ENJqBIOxs5ooFUbawXRJozJq6OOUkX
         R+d0jp4I5JC2Ol+QsY+KDJBC8wJ6NIu2CtI46+q9wNNfhEX+6P0LjJP+CtSY6PTFUqmi
         e8GA==
X-Gm-Message-State: AOAM532WTvoI8a6rjD1LO9YTXNoIF42l4K/mvZ7nSfgtPwT/BGmjYtqq
        1INndizxxbCPsaprEx86mxc=
X-Google-Smtp-Source: ABdhPJwXnkeKt0tZOtmyngdNDbthxKjW3poK14nKMRl9ULo/YcYUeZJdJc4By3aYT1lM6A1OrOk2wg==
X-Received: by 2002:a05:6402:3689:b0:419:d380:ddbc with SMTP id ej9-20020a056402368900b00419d380ddbcmr15535362edb.230.1648718231272;
        Thu, 31 Mar 2022 02:17:11 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id e1-20020a170906314100b006e48a47a0dbsm1586245eje.55.2022.03.31.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:17:10 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH v3] IB/SA: replace usage of found with dedicated list iterator variable
Date:   Thu, 31 Mar 2022 11:16:34 +0200
Message-Id: <20220331091634.644840-1-jakobkoschel@gmail.com>
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
found boolean.

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---

v1->v2:
- set query correctly (Mark Zhang)

v2->v3:
- remove changelog and link from git commit message (Leon Romanovsky)

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/

 drivers/infiniband/core/sa_query.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8dc7d1f4b35d..003e504feca2 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1034,10 +1034,9 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
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
@@ -1045,20 +1044,21 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
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

base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
--
2.25.1

