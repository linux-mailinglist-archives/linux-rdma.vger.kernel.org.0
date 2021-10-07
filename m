Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B54259A7
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243322AbhJGRln (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 13:41:43 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:35518
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242882AbhJGRlm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 13:41:42 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1FF973F22C;
        Thu,  7 Oct 2021 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633628383;
        bh=AGmPEyKfrMO2SB0GuUzpEOSqBSptCQbYUMRwx/G05Wg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=PDcBRlwNR0KSI7F21Iul29r+ViC10Ua6ZyXlsT5HvH0BLFL3fYopja0pAHYHDLUJQ
         xRyMa2BIYSVpQaAhTDarxTrDS52rCHwaXvm0McpIsRmtHL3Y3ikyaqha1LvL8EapoG
         O39oj+Vz3yGirhMoxJGHNKYuNJqll5uCAP5KdT9+vnqEjf4g/I/4xF9EH7NOmuLfIA
         lgE0dUqEEmRptGkNTticRSB6UevJGsGJFp7VUiEUeNB7gHL/q8MxCvQ/5USooMNIL9
         5gGs/1dZ7BzzU/FhS37koLmo17bUjBZ24QwyH202qgaxrXDfIIQnyQIBdopkZnvF62
         JW2g8VM5MlZ5A==
From:   Colin King <colin.king@canonical.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/iwpm: Remove redundant initialization of pointer err_str
Date:   Thu,  7 Oct 2021 18:39:42 +0100
Message-Id: <20211007173942.21933-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer err_str is being initialized with a value that is
never read, it is being updated later on. The assignment is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/iwpm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 54f4feb604d8..358a2db38d23 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -762,7 +762,7 @@ int iwpm_send_hello(u8 nl_client, int iwpm_pid, u16 abi_version)
 {
 	struct sk_buff *skb = NULL;
 	struct nlmsghdr *nlh;
-	const char *err_str = "";
+	const char *err_str;
 	int ret = -EINVAL;
 
 	skb = iwpm_create_nlmsg(RDMA_NL_IWPM_HELLO, &nlh, nl_client);
-- 
2.32.0

