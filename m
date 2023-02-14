Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224316963F3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Feb 2023 13:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBNMyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 07:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBNMyK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 07:54:10 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9C522783
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 04:53:57 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Ruokph5lwOJaFRuolpOzce; Tue, 14 Feb 2023 13:53:55 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Feb 2023 13:53:55 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/restrack: Reorder fields in 'struct rdma_restrack_entry'
Date:   Tue, 14 Feb 2023 13:53:52 +0100
Message-Id: <d47800d9fd5ac7c33d01af04b12b6d43ad23c96e.1676379187.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size from 136 to 128 bytes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct rdma_restrack_entry {
	bool                       valid;                /*     0     1 */
	u8                         no_track:1;           /*     1: 0  1 */

	/* XXX 7 bits hole, try to pack */
	/* XXX 2 bytes hole, try to pack */

	struct kref                kref;                 /*     4     4 */
	struct completion          comp;                 /*     8    96 */
	/* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
	struct task_struct *       task;                 /*   104     8 */
	const char  *              kern_name;            /*   112     8 */
	enum rdma_restrack_type    type;                 /*   120     4 */
	bool                       user;                 /*   124     1 */

	/* XXX 3 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	u32                        id;                   /*   128     4 */

	/* size: 136, cachelines: 3, members: 9 */
	/* sum members: 126, holes: 2, sum holes: 5 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits */
	/* padding: 4 */
	/* last cacheline: 8 bytes */
};

After:
=====
struct rdma_restrack_entry {
	bool                       valid;                /*     0     1 */
	u8                         no_track:1;           /*     1: 0  1 */

	/* XXX 7 bits hole, try to pack */

	bool                       user;                 /*     2     1 */

	/* XXX 1 byte hole, try to pack */

	struct kref                kref;                 /*     4     4 */
	struct completion          comp;                 /*     8    96 */
	/* --- cacheline 1 boundary (64 bytes) was 40 bytes ago --- */
	struct task_struct *       task;                 /*   104     8 */
	const char  *              kern_name;            /*   112     8 */
	enum rdma_restrack_type    type;                 /*   120     4 */
	u32                        id;                   /*   124     4 */

	/* size: 128, cachelines: 2, members: 9 */
	/* sum members: 126, holes: 1, sum holes: 1 */
	/* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 7 bits */
};
---
 include/rdma/restrack.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 8b7c46daeb07..da53fefe6f9e 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -80,6 +80,10 @@ struct rdma_restrack_entry {
 	 * query stage.
 	 */
 	u8			no_track : 1;
+	/**
+	 * @user: user resource
+	 */
+	bool			user;
 	/*
 	 * @kref: Protect destroy of the resource
 	 */
@@ -106,10 +110,6 @@ struct rdma_restrack_entry {
 	 * @type: various objects in restrack database
 	 */
 	enum rdma_restrack_type	type;
-	/**
-	 * @user: user resource
-	 */
-	bool			user;
 	/**
 	 * @id: ID to expose to users
 	 */
-- 
2.34.1

