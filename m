Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF481C009F
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgD3Pmu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 11:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgD3Pmt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 11:42:49 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F9C20661;
        Thu, 30 Apr 2020 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588261369;
        bh=pqrAnBTQXaLtqlBB7XQQmew+vzgM2Rf89Vxvq0xVIEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJheI4fArveG8hiuIkT2Q/2Qn9ja6I6LIaOcB8cDOd9drS5Rq1T83DDlnMWNHGKdP
         GK+6LLpIb/wCwHc5HH6FEjwjGoTHHDSS/HhRDXSuiS8lfTO5T2P7428ZpF76lliwmT
         Q/e8kxO93ArzsizP724lKtmuk1qN6NGEfSIBzdNE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-core 1/4] Update kernel headers
Date:   Thu, 30 Apr 2020 18:42:34 +0300
Message-Id: <20200430154237.78838-2-leon@kernel.org>
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

To commit ?? ("RDMA/ucma: Return stable IB device index as identifier")

Change-Id: I6b6f4fac35220c2976b869ee1a286fcaeb8ee529
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 kernel-headers/rdma/rdma_user_cm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-headers/rdma/rdma_user_cm.h b/kernel-headers/rdma/rdma_user_cm.h
index e42940a2..cef0436a 100644
--- a/kernel-headers/rdma/rdma_user_cm.h
+++ b/kernel-headers/rdma/rdma_user_cm.h
@@ -164,6 +164,7 @@ struct rdma_ucm_query_route_resp {
 	__u32 num_paths;
 	__u8 port_num;
 	__u8 reserved[3];
+	__u32 ibdev_index;
 };

 struct rdma_ucm_query_addr_resp {
@@ -175,6 +176,7 @@ struct rdma_ucm_query_addr_resp {
 	__u16 dst_size;
 	struct __kernel_sockaddr_storage src_addr;
 	struct __kernel_sockaddr_storage dst_addr;
+	__u32 ibdev_index;
 };

 struct rdma_ucm_query_path_resp {
--
2.26.2

