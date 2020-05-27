Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818141E460C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 16:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgE0Og6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 10:36:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389308AbgE0Og6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 10:36:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF662207D8;
        Wed, 27 May 2020 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590590217;
        bh=ZKanhQJK0P/djH+WNpQI7TX6FSFCpbdAlBTPqGNAsog=;
        h=Date:From:To:Cc:Subject:From;
        b=YSD+ZGCItrXkd1UID3bNMcDqtjMYtcaWkWR/jbiZi+m6f00sd5fV2w2LtxMDmqNVx
         nn9JF+KjKberrBy+2S0xaU79c9o95nS1uUTTAC8qQy7puJvTVh72gh1HgPweYrUXGQ
         fG2LQN5mleXFZtua1j9s0LsOSQep5IedKWhcFSzc=
Date:   Wed, 27 May 2020 09:41:52 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] IB/core: Use sizeof_field() helper
Message-ID: <20200527144152.GA22605@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make use of the sizeof_field() helper instead of an open-coded version.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/infiniband/core/sa_query.c     | 8 ++++----
 drivers/infiniband/core/uverbs_cmd.c   | 2 +-
 drivers/infiniband/core/uverbs_ioctl.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 5c878646ff62a..8f70c5c38ab7c 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -190,7 +190,7 @@ static u32 tid;
 
 #define PATH_REC_FIELD(field) \
 	.struct_offset_bytes = offsetof(struct sa_path_rec, field),	\
-	.struct_size_bytes   = sizeof((struct sa_path_rec *)0)->field,	\
+	.struct_size_bytes   = sizeof_field(struct sa_path_rec, field),	\
 	.field_name          = "sa_path_rec:" #field
 
 static const struct ib_field path_rec_table[] = {
@@ -292,7 +292,7 @@ static const struct ib_field path_rec_table[] = {
 	.struct_offset_bytes = \
 		offsetof(struct sa_path_rec, field), \
 	.struct_size_bytes   = \
-		sizeof((struct sa_path_rec *)0)->field,	\
+		sizeof_field(struct sa_path_rec, field),	\
 	.field_name          = "sa_path_rec:" #field
 
 static const struct ib_field opa_path_rec_table[] = {
@@ -552,7 +552,7 @@ static const struct ib_field service_rec_table[] = {
 
 #define CLASSPORTINFO_REC_FIELD(field) \
 	.struct_offset_bytes = offsetof(struct ib_class_port_info, field),	\
-	.struct_size_bytes   = sizeof((struct ib_class_port_info *)0)->field,	\
+	.struct_size_bytes   = sizeof_field(struct ib_class_port_info, field),	\
 	.field_name          = "ib_class_port_info:" #field
 
 static const struct ib_field ib_classport_info_rec_table[] = {
@@ -630,7 +630,7 @@ static const struct ib_field ib_classport_info_rec_table[] = {
 	.struct_offset_bytes =\
 		offsetof(struct opa_class_port_info, field),	\
 	.struct_size_bytes   = \
-		sizeof((struct opa_class_port_info *)0)->field,	\
+		sizeof_field(struct opa_class_port_info, field),	\
 	.field_name          = "opa_class_port_info:" #field
 
 static const struct ib_field opa_classport_info_rec_table[] = {
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4859ac0df17c7..2067a939788bd 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3741,7 +3741,7 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 #define UAPI_DEF_WRITE_IO(req, resp)                                           \
 	.write.has_resp = 1 +                                                  \
 			  BUILD_BUG_ON_ZERO(offsetof(req, response) != 0) +    \
-			  BUILD_BUG_ON_ZERO(sizeof(((req *)0)->response) !=    \
+			  BUILD_BUG_ON_ZERO(sizeof_field(req, response) !=    \
 					    sizeof(u64)),                      \
 	.write.req_size = sizeof(req), .write.resp_size = sizeof(resp)
 
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 42c5696f03bd7..2d882c02387c1 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -137,7 +137,7 @@ EXPORT_SYMBOL(_uverbs_alloc);
 static bool uverbs_is_attr_cleared(const struct ib_uverbs_attr *uattr,
 				   u16 len)
 {
-	if (uattr->len > sizeof(((struct ib_uverbs_attr *)0)->data))
+	if (uattr->len > sizeof_field(struct ib_uverbs_attr, data))
 		return ib_is_buffer_cleared(u64_to_user_ptr(uattr->data) + len,
 					    uattr->len - len);
 
-- 
2.26.2

