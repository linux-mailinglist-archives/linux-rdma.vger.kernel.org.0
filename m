Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13031AC52
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2019 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfELNTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 May 2019 09:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfELNTL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 May 2019 09:19:11 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA642146F;
        Sun, 12 May 2019 13:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557667151;
        bh=SIxXdwiderYT6yIeK6/FAmlhhA/KajerspaKdKA1wfE=;
        h=From:To:Cc:Subject:Date:From;
        b=q0qyXSsDbXlI0GkzHbg8oW1ag0yjp4qqqIFKVfM9HmZCPFvTCqikgBGxLNYhtGQRE
         ksPbTsTdf0YZRXdom7Y/5vZmUvV4m8tN+BS1crtUUULk71nO3TRW2e+yicpmXHGJM/
         rRgn/17R0nXG6NPRh6aghMVlSw7JBEreiYi25W4g=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-core] kernel-boot: Fix build failure with ancient libnl3 versions
Date:   Sun, 12 May 2019 16:19:04 +0300
Message-Id: <20190512131904.2414-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Debian jessie provides a very ancient libnl3 version without NLA_NUL_STRING.
In order to do not disable persistent naming on such systems, we prefer
to loose our netlink type validation.

Fixes: 6b4099d47be3 ("kernel-boot: Perform device rename to make stable names")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
PR: https://github.com/linux-rdma/rdma-core/pull/526
---
 kernel-boot/rdma_rename.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel-boot/rdma_rename.c b/kernel-boot/rdma_rename.c
index 547b3579..3f796142 100644
--- a/kernel-boot/rdma_rename.c
+++ b/kernel-boot/rdma_rename.c
@@ -47,9 +47,11 @@

 static struct nla_policy policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_INDEX] = { .type = NLA_U32 },
-	[RDMA_NLDEV_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_NODE_GUID] = { .type = NLA_U64 },
+#ifdef NLA_NUL_STRING
+	[RDMA_NLDEV_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_DEV_PROTOCOL] = { .type = NLA_NUL_STRING },
+#endif /* NLA_NUL_STRING */
 };

 struct data {
--
2.20.1

