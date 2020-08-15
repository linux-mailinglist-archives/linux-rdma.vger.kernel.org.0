Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358CE245300
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Aug 2020 23:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgHOV5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Aug 2020 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgHOVwG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Aug 2020 17:52:06 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692EEC0612A7
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:02 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id u28so2336777ooe.12
        for <linux-rdma@vger.kernel.org>; Fri, 14 Aug 2020 22:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8saovlFiJ1HP/0sHmhYkqR6KqLV+uMKX5f2u2I1MM8=;
        b=MWkvOgJoAHcNJ49DlQ9JPTj3FivmsmyLvPY/wrJWTS/L2GRWdrwj9uoyEiBX3aGHP4
         fQPRQ4t2aDJa5XAaxGwNSdTUw/4WW6YdnUTYjacQgbWL5h9YLTlkWtdpruaKrMBigiGx
         be1w3Xuxl3PqdtwXNVTZn0RaIgP6HqETgo9Ykvx0ioovv2Ua6W3QIxOFFu0XTy9d76hK
         9Z8vsH8gZ0xnFazgaQMXNp/tBtUEqgqoDPZ74VNnhr6mVGD2KgbYs+1ucVhDm4LFlKc+
         TaulRT0PQ9SgTFcfdGFZ89qYmMp4xJJoq9nFao4QMOxbR0s4MJqi/zfxYXC76dauGYca
         o1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8saovlFiJ1HP/0sHmhYkqR6KqLV+uMKX5f2u2I1MM8=;
        b=GQU2IP1oyzPxlHzI/Dn2SnmJmPGLwylhaZbs5Fle1ZlXdn+ejpll1iRn6WQjuQE2id
         +lHPonBmNi4HQx5aafO9oCR7rbcVHdfF5UB7oyfv36B8DsXM1A9Yh4NYeMZ4SCITD+9o
         //7gqeufJ0zqHazruw+NRKtgyUGGWp8rlAHFrChPRk2oHAucxikPdaHi6MPHOghWPlN1
         IZp52tb5OXH6AEaH5sfBzCs6Z7xZeiWHUeqxBzHGoNgXyyx0RR5iEduGcCXvkdABfnYi
         R2iv5F/LJl1CP2yMowmBokpFv0XHs5v9kRU7iRBs3CITACVG6QnzslWUP6rPCZgIUEUa
         HQkA==
X-Gm-Message-State: AOAM532WJG755TbQZsGjdZ1Ll24tOvdHQbgExXy9838bAEeqm0Dz8mMI
        kEuIcLnia/duYZ8K2h6KYY3j3sw1aF5LpA==
X-Google-Smtp-Source: ABdhPJyzKIg8byscNSnEkJ3EEnrgqulf/E4lbGSF1XgJhQauIuNi7GeYySWSwVgSeaMh3Jjb46wa/g==
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr3981071oom.27.1597467601416;
        Fri, 14 Aug 2020 22:00:01 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:b453:c5f2:2895:a54c])
        by smtp.gmail.com with ESMTPSA id z32sm2084160ota.53.2020.08.14.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 22:00:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 09/20] Fixed error logic in rxe_req.c
Date:   Fri, 14 Aug 2020 23:58:33 -0500
Message-Id: <20200815045912.8626-10-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815045912.8626-1-rpearson@hpe.com>
References: <20200815045912.8626-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixed returned status so each error return can set
status. Now the bind_mw verb returns the correct (error) status in the wc.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index b402eb82b402..e0564d7b0ff7 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -740,12 +740,14 @@ int rxe_requester(void *arg)
 	skb = init_req_packet(qp, wqe, opcode, payload, &pkt);
 	if (unlikely(!skb)) {
 		pr_err("qp#%d Failed allocating skb\n", qp_num(qp));
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
 	if (fill_packet(qp, wqe, &pkt, skb, payload)) {
 		pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
 		kfree_skb(skb);
+		wqe->status = IB_WC_LOC_PROT_ERR;
 		goto err;
 	}
 
@@ -769,6 +771,7 @@ int rxe_requester(void *arg)
 			goto exit;
 		}
 
+		wqe->status = IB_WC_LOC_PROT_ERR;	// ?? FIXME
 		goto err;
 	}
 
@@ -783,8 +786,10 @@ int rxe_requester(void *arg)
 	 * state and no more wqes will be processed unless
 	 * the qp is cleaned up and restarted. We do not want
 	 * to be called again */
-	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
+	// ?? we want to force the qp into error state before
+	// anyone else has a chance to process another wqe but
+	// this could collide with an already running completer
 	__rxe_do_task(&qp->comp.task);
 	ret = -EAGAIN;
 	goto done;
-- 
2.25.1

