Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7335353C37
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Apr 2021 09:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhDEHoq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Apr 2021 03:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231523AbhDEHoq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Apr 2021 03:44:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19B1F61279;
        Mon,  5 Apr 2021 07:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617608680;
        bh=WdJ6GZIMwNuvuuvXrnwrda5GFONTPH75bo5JtuE/Edg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZFcTQZu00/QYtOhBzpdazVnftIqcWeXKE2dhBb9MQmyjXKvFiggxnOOgTr6QIZPBQ
         DiM/imL5oEI4DzPMg7KKeXxcnN5zBZfEnRYa+FOpmPuL5rnVid78KnBMndVjwcPztm
         wQy1ZV58z8gmGqhurrUQzGsq+LfKpXLhngsPDe3W6DQDECX7xOxC8qWJoZsDGlvtlO
         0Y5bXHFEnsZkeksq+ySFO/JINjJKNw52FGsNjhPR7ZOluktliPVqnZQQk2BbTZNQXm
         aMaSnqBAQVd7P9XS1+PtgQy7z4yDG037KG0xnDIbBeQ7vC+vHKv+VA+Yr+5rkb1yFR
         a0aucWmZDMMHg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next] RDMA/addr: Be strict with gid size
Date:   Mon,  5 Apr 2021 10:44:34 +0300
Message-Id: <20210405074434.264221-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The nla_len() is less than or equal to 16.  If it's less than 16 then
end of the "gid" buffer is uninitialized.

Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 0abce004a959..65e3e7df8a4b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -76,7 +76,9 @@ static struct workqueue_struct *addr_wq;
 
 static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
 	[LS_NLA_TYPE_DGID] = {.type = NLA_BINARY,
-		.len = sizeof(struct rdma_nla_ls_gid)},
+		.len = sizeof(struct rdma_nla_ls_gid),
+		.validation_type = NLA_VALIDATE_MIN,
+		.min = sizeof(struct rdma_nla_ls_gid)},
 };
 
 static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
-- 
2.30.2

