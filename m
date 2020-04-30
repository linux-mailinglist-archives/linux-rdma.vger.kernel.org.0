Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5D81C00A1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgD3Pm5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgD3Pm5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 11:42:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A0D20661;
        Thu, 30 Apr 2020 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261377;
        bh=EHKA3xbJGOotu/aTLwj74wfPrtCUFRMeobst6PzitWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH4+PBzO4qnS7rWvNHyWIq0SorO2CE36qZBU6bJtj3MrxwD17jkPHhCRDBzd6r+WV
         YwlDdlOdnzW3E8OoFl8FlwaB+Hx+Obpuz+Dp5QJB1Fm45iAbGRMLgjzc1EZ+tk5DRC
         uGToVw7lUwIbeRaw1lYNp7c8WiHxo1YtVq1YxEps=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 2/4] libibverbs: Fix description of ibv_get_device_guid man page
Date:   Thu, 30 Apr 2020 18:42:35 +0300
Message-Id: <20200430154237.78838-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430154237.78838-1-leon@kernel.org>
References: <20200430154237.78838-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

There is a copy/paste error in the description of
ibv_get_device_guid(), fix it.

Fixes: 7aca81e64aa9 ("verbs: Switch simpler man pages over to markdown format")
Change-Id: I6ab12d6e2f231a9c52139c187a4aacf817bf5433
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 libibverbs/man/ibv_get_device_guid.3.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libibverbs/man/ibv_get_device_guid.3.md b/libibverbs/man/ibv_get_device_guid.3.md
index 683900f9..6dc96001 100644
--- a/libibverbs/man/ibv_get_device_guid.3.md
+++ b/libibverbs/man/ibv_get_device_guid.3.md
@@ -22,7 +22,7 @@ uint64_t ibv_get_device_guid(struct ibv_device *device);

 # DESCRIPTION

-**ibv_get_device_name()** returns the Global Unique IDentifier (GUID) of the
+**ibv_get_device_guid()** returns the Global Unique IDentifier (GUID) of the
 RDMA device *device*.

 # RETURN VALUE
--
2.26.2

