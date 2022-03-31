Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BE74EE452
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Apr 2022 00:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbiCaWrd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 18:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241797AbiCaWrc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 18:47:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0222FDAB;
        Thu, 31 Mar 2022 15:45:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so2306527ejd.1;
        Thu, 31 Mar 2022 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uF1iw34nBOmvCy+IoOEYEN0o0eVJME4dpDsIt52fKzo=;
        b=aPycjAp/tX8nwU1bGGtaEufvaZd94yMHK81doo7beIqR8q2WqX8BY7UX+6EZVRXwMQ
         00SGBYsfk785awB5L/QKJv2fB0ql5v9QmyLoW0vjZ4NKMWZU78W7l16L2E0niLeRF68h
         u5KRICnBsaZMWvkB9j3suFj0XxGSxx4691BOfj5ft4TXd7A1AKMckpb87svdgFvXTZYH
         oR2SN10Wt0HVLAPBqZgq1eD2jEKYznOydMBjeWd518IeaPZ6LE3aLr3Hujm0PvX+aeY2
         bQZirIonhayIt7WuwLuQV897/vcBRMZ8jL6Q5Sh5P65EJ/oISQlRgQ8VG9JsDpF6SS06
         H7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uF1iw34nBOmvCy+IoOEYEN0o0eVJME4dpDsIt52fKzo=;
        b=QyJ79dZZrKpo3XnsnlZpq6XiOIr9gzpT0ebjWIJR3DLpvqI66AojEmq4rH0q5kXSt4
         TD60ERGAH5ijzdnNRXZ7ITvI3jHxXK9vgvtWd/4s8VxzF8p67zG8pQDIJs6CNNduQHNm
         fW8xj60RCYsDGLP2zKMMD6gDgWM+5SnkbndhorzCnChPFyw5brLM3vfRIa9RsUJEkv2o
         GWcCwfd7g+pxuX/VLby+pasA62LtshOECConnJmk0ve2fyxza/+Y8iEM4t2doNHYj2zz
         iyqUTjgJpWzrf04lxU/AKUkL+DlqTDKEGziVQRu8TxyNfAB7musZO/Dd+LxDWQcP6YcF
         blwA==
X-Gm-Message-State: AOAM530KYW9TSnhy4P9NMI1RIbz8h7JI9nRrTEQ5tjxgId869tzbeqBN
        1Q2YRmptvcqKpH0uYev2uyg=
X-Google-Smtp-Source: ABdhPJzTNkbHeej/N8xjS5O7X32jfYc3HfvBboNDrNzRNf5JSoyElhkEcyRc0CjkT75X4oY78ltmZA==
X-Received: by 2002:a17:906:7d83:b0:6ce:fee:9256 with SMTP id v3-20020a1709067d8300b006ce0fee9256mr6944062ejo.647.1648766743211;
        Thu, 31 Mar 2022 15:45:43 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id do8-20020a170906c10800b006dfe4d1edc6sm285696ejc.61.2022.03.31.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:45:42 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] IB/hfi1: remove check of list iterator against head past the loop body
Date:   Fri,  1 Apr 2022 00:45:01 +0200
Message-Id: <20220331224501.904039-1-jakobkoschel@gmail.com>
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

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/infiniband/hw/hfi1/tid_rdma.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 2a7abf7a1f7f..b12abf83a91c 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -1239,7 +1239,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
 	struct hfi1_ctxtdata *rcd = flow->req->rcd;
 	struct hfi1_devdata *dd = rcd->dd;
 	u32 ngroups, pageidx = 0;
-	struct tid_group *group = NULL, *used;
+	struct tid_group *group = NULL, *used, *iter;
 	u8 use;
 
 	flow->tnode_cnt = 0;
@@ -1248,13 +1248,15 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
 		goto used_list;
 
 	/* First look at complete groups */
-	list_for_each_entry(group,  &rcd->tid_group_list.list, list) {
-		kern_add_tid_node(flow, rcd, "complete groups", group,
-				  group->size);
+	list_for_each_entry(iter,  &rcd->tid_group_list.list, list) {
+		kern_add_tid_node(flow, rcd, "complete groups", iter,
+				  iter->size);
 
-		pageidx += group->size;
-		if (!--ngroups)
+		pageidx += iter->size;
+		if (!--ngroups) {
+			group = iter;
 			break;
+		}
 	}
 
 	if (pageidx >= flow->npagesets)
@@ -1277,7 +1279,7 @@ static int kern_alloc_tids(struct tid_rdma_flow *flow)
 	 * However, if we are at the head, we have reached the end of the
 	 * complete groups list from the first loop above
 	 */
-	if (group && &group->list == &rcd->tid_group_list.list)
+	if (!group)
 		goto bail_eagain;
 	group = list_prepare_entry(group, &rcd->tid_group_list.list,
 				   list);

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

