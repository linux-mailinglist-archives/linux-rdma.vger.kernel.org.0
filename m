Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB2458647
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Nov 2021 21:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhKUUZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Nov 2021 15:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhKUUZu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Nov 2021 15:25:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF0C061574;
        Sun, 21 Nov 2021 12:22:45 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l22so70563412lfg.7;
        Sun, 21 Nov 2021 12:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRweFMVog2aHsU0N6H/aidV/g7xHJC1fx25ZnuGgZpQ=;
        b=eSKwrNYYO2iofFhzHJTxYOEEIzFaH5XSMpN1E1EMREe8nsJo/yyBAF8tHJXVUG4aRf
         EOrx9NRyWZ2qQtB6awThelCivp5xzgrAK0P2Ue2glyQK3hLcXZ070+666GAjw3n9AD0e
         gFCDZ1s4Ioh2C5hP3KTAJqk0T0GGrT0fgqlP2eDHOZwL01JEHd6ISxu8ejDTtWucwhN8
         QNPITMcGZNnMjtqhHxsKAvEGzmIwfpgN0tQ6uFw+DAGAM7B0wbAgG8DIUVONvovPI7iq
         7lAFLWXu5RXU/EFRiekZjLmx9YTnqou0CdR2neVR5GPuSsmQpjC/eqIIXAEPHxUqYq2U
         xtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRweFMVog2aHsU0N6H/aidV/g7xHJC1fx25ZnuGgZpQ=;
        b=cc3bDtSrPFr7LIcmXhKFi9soF8B/UVOnIGRU6yRmsprsu0nYu3F+wEpGRNs/z77H1m
         lWGvgiGzF3LGLZRcjBmAOw+gXu/JmuSzQPVRPCvTcXqlREdEAFd8GJs9IQOJgJhMsoCy
         xT1qst+DqB37afgLikmGzkCF44Lab2LwfmPk8LyBBgVDczsRv9ageKs0QLHAa8JIgx/i
         5CsOxfc0lklvauLnD1CN17I45o3bGURTzQ1Q0UMgq3qMW4bAw/c5eTt2lXaKa0/IOh5y
         JQT8h264JQIMqDzCrNB+UMCOcltYzN+ILms4KFItLkh8OOyzRsBGdqdmuQLb9aTPpRkW
         OjzA==
X-Gm-Message-State: AOAM532/gISdmaF8ZW7d6TZ73fKi6uJ5OVVZZu751u6GKvGBx+zxuIs8
        mSl46E7PYpdWQQmQBIHp3M0=
X-Google-Smtp-Source: ABdhPJx3YOB9aYPu4+BI7zu4n6h85bz/460L3Jz/7ow5gDHD2lQLBTs18O4u+SYDjvci6JYJnkA9zQ==
X-Received: by 2002:a2e:2e0e:: with SMTP id u14mr45632583lju.28.1637526163262;
        Sun, 21 Nov 2021 12:22:43 -0800 (PST)
Received: from localhost.localdomain ([217.117.245.63])
        by smtp.gmail.com with ESMTPSA id a25sm850936lfm.250.2021.11.21.12.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 12:22:42 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     zyjzyj2000@gmail.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
Subject: [PATCH] RDMA: fix use-after-free in rxe_queue_cleanup
Date:   Sun, 21 Nov 2021 23:22:39 +0300
Message-Id: <20211121202239.3129-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YZpUnR05mK6taHs9@unreal>
References: <YZpUnR05mK6taHs9@unreal>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On error handling path in rxe_qp_from_init() qp->sq.queue is freed and
then rxe_create_qp() will drop last reference to this object. qp clean
up function will try to free this queue one time and it causes UAF bug.

Fix it by zeroing queue pointer after freeing queue in
rxe_qp_from_init().

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Reported-by: syzbot+aab53008a5adf26abe91@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 975321812c87..54b8711321c1 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -359,6 +359,7 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 
 err2:
 	rxe_queue_cleanup(qp->sq.queue);
+	qp->sq.queue = NULL;
 err1:
 	qp->pd = NULL;
 	qp->rcq = NULL;
-- 
2.33.1

