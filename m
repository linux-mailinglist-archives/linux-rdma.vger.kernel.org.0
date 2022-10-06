Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F65F74BB
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJGHcg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Oct 2022 03:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJGHcg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Oct 2022 03:32:36 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC3C0696;
        Fri,  7 Oct 2022 00:32:33 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id BHN00127;
        Fri, 07 Oct 2022 15:32:27 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 7 Oct 2022 15:32:28 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] IB/uverbs: fix the typo of optional
Date:   Thu, 6 Oct 2022 12:14:56 -0400
Message-ID: <20221006161456.2998-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20221007153227d4e058b16bc5f140be625a815f78c71e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the typo of optional in the function of UVERBS_HANDLER.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/infiniband/core/uverbs_std_types_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index dd1075466f61..7b4773fa4bc0 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -163,7 +163,7 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QP_CREATE)(
 					UVERBS_ATTR_CREATE_QP_SRQ_HANDLE))
 				return -EINVAL;
 
-			/* send_cq is optinal */
+			/* send_cq is optional */
 			if (cap.max_send_wr) {
 				send_cq = uverbs_attr_get_obj(attrs,
 					UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE);
-- 
2.27.0

