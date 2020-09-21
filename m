Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC1273377
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIUUEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 16:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUUEP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Sep 2020 16:04:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F70C061755
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 95so6232375ota.13
        for <linux-rdma@vger.kernel.org>; Mon, 21 Sep 2020 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M7BIC7Z7C3jI/XKbqemRcZf71vYA9NpYcp+JzUeoZek=;
        b=Whw81BzMdTA3ams+Ctj55j5YUR5F/v3gQsF4NZlReU0qVfbROjIbCWNiJmvefmbm90
         lOtSX9g9G6ks1Gil/7wHVN4ph8Y2zzo5JHxZMsbw26xOPvZlzeYSD+xDtawxRSOEvBxs
         M6bL2SLIQLA/0Sdp/nm5oGdwDThpTaFVPTTkuMBkXW+6Zsr1lrrnvr+oU4CmP+mpe/Ay
         Q3eFoUKbtJMhiYb/qiKXFFVAu2rcwkuRkTT8XzHsypWAG91wMNAwQrzYrOVOCXDBraVP
         ZRRQZQFfRII5MUgYLZjctFRrxCV7+JbwThahAySD7CBw8nVVPRehLXJ8RcGDhISc2qYa
         QiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M7BIC7Z7C3jI/XKbqemRcZf71vYA9NpYcp+JzUeoZek=;
        b=hFcq0CKNm3wqJ8JjSHM5JYElWnQovAFh3hqhvQ+rKoF6Pf59iehnm9ZB3kfFMrg7Mb
         22/GzkTGUhNfZs/yM4VALKCh9EI8em8E1KcHaT1HUHf9GIpnhk7cngVEHk0L1zaiIW9k
         1iOF/dSLYaly21oifMAeqAZ4xiJVwH2h+S/o3vkB2WITls37IY5zTqgn3VZBgf52Dx4N
         q1lVGhBZnL4ojyjbPhbWdNMyd+9Pfq5aSyTzNSP2zPvw9El2WkAWAUGvGF468brUzZ55
         Atqp8Moo1XNEC3o89OSb9BN26AYVULTKEtNA192LQ7N0sYYPkWgC+26dcVacMrneLy/p
         5tgA==
X-Gm-Message-State: AOAM531YB/7Vuz/Fq3axztdrC3xC7cnTc2dygGn/tNFA0Ou1LmEUF4Hf
        uWTymwD5/0+T4YVbwlaNNyA=
X-Google-Smtp-Source: ABdhPJzqR8d3kbFeoBWh/V8UywO0FdwR3kmfDwHIGaELktsff+NdT5sxR1HgmTZcrnunolrHMt7ytA==
X-Received: by 2002:a05:6830:1be9:: with SMTP id k9mr386638otb.315.1600718655181;
        Mon, 21 Sep 2020 13:04:15 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:9211:f781:8595:d131])
        by smtp.gmail.com with ESMTPSA id l3sm6384054oth.36.2020.09.21.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 13:04:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 09/12] rdma_rxe: Add support for extended QP operations
Date:   Mon, 21 Sep 2020 15:03:53 -0500
Message-Id: <20200921200356.8627-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921200356.8627-1-rpearson@hpe.com>
References: <20200921200356.8627-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add bits to user api command bitmask.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 594d8353600a..7849d8d72d4c 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1187,6 +1187,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 
 	dev->uverbs_ex_cmd_mask =
 	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP)
+	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
 	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
 	    ;
-- 
2.25.1

