Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FED2C8056
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgK3IyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgK3IyA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Nov 2020 03:54:00 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82875C0613D4;
        Mon, 30 Nov 2020 00:53:20 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b63so9947332pfg.12;
        Mon, 30 Nov 2020 00:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UKBkSD6v63vR2xw4n2OFGPSxFTTo4opuha2BS8j1btE=;
        b=MNZe4pvMXob+x871SJIO/R+A8ND+7heg97BgMOlG5p0VQ0uSeeJtkaOcg5OsmD2JxL
         SmNdZzgSjcZQwM+ypVRfLUrXN3NW2Y9QN5f1uNXTG+zexo1t9Y4TZjX7jCeXEZuYUuwk
         4kvqlLoHZQPYDgLAU8h+SgutPrNJhdTGrLZH/21ouT8+7P6ybS1HT9Hq47LdgHbbiT1Q
         OKIzfuRvXh5pA70OtgQaLpts1oXEu9c/u1gnlRi23raBKQAsUISybo8xj0zf7xRWjkG6
         mWmrhadEI+2KoUATQsLNt33ZZz6iT5Ji+8aDB16yjkwS/pjcy6tPMmG0YNr/7auB2NBr
         mGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UKBkSD6v63vR2xw4n2OFGPSxFTTo4opuha2BS8j1btE=;
        b=kFP3sSTyNAKtRgUrDHpWyvPzkspFxfOs1XmdsXltg8Rqse2zrAF4cmnS1LWWoYtcKi
         JjcYaZgLl/Im0sQcMyHwNxA0yFKUEjgNUMi/s5F+Y6wUd++FS5vt2q5eKH1BujuONdjN
         f/Qy4M8RkDBBYeSdL83EAnfv60V9KhfUYfM42CVAe4mlYL328hFB+rZVpFlHpWBOXrh3
         ZiMbFIKxz/rCe7CVVdMBasyJoh0yohzlUbARvW+NKUZnQZ1Wi8Y1mU+frJxEqGeMdbsa
         d0mnQgAcUvTa2KpBDehJt7niJB/szaBRLWl9j0t3oVtZm0/o+U0OT6xjJMP7GgmLk3YH
         5dhA==
X-Gm-Message-State: AOAM530tbvOcCOgaIh/9XIAcMj00vbplnYklEbZvr7BHlFxuMrCl+W8l
        m6S8snpBDoqD6moX5fWn9cI=
X-Google-Smtp-Source: ABdhPJwhuf3HBs3oocbNkAep5NfesI0ggJIaGFmAwNjaBzYI1bWgGNSbzn6/ce7af0v/J3XVkqRutQ==
X-Received: by 2002:a65:460f:: with SMTP id v15mr17068970pgq.406.1606726400118;
        Mon, 30 Nov 2020 00:53:20 -0800 (PST)
Received: from localhost.localdomain ([8.210.202.142])
        by smtp.gmail.com with ESMTPSA id 85sm15697784pfv.197.2020.11.30.00.53.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 00:53:19 -0800 (PST)
From:   Yejune Deng <yejune.deng@gmail.com>
To:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        yejune.deng@gmail.com
Subject: [PATCH] infiniband: i40iw: replace atomic_add_return()
Date:   Mon, 30 Nov 2020 16:52:56 +0800
Message-Id: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

atomic_inc_return() is a little neater

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 3053c345..26e92ae 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -2426,7 +2426,7 @@ static void i40iw_handle_rst_pkt(struct i40iw_cm_node *cm_node,
 		}
 		break;
 	case I40IW_CM_STATE_MPAREQ_RCVD:
-		atomic_add_return(1, &cm_node->passive_state);
+		atomic_inc_return(&cm_node->passive_state);
 		break;
 	case I40IW_CM_STATE_ESTABLISHED:
 	case I40IW_CM_STATE_SYN_RCVD:
@@ -3020,7 +3020,7 @@ static int i40iw_cm_reject(struct i40iw_cm_node *cm_node, const void *pdata, u8
 	i40iw_cleanup_retrans_entry(cm_node);
 
 	if (!loopback) {
-		passive_state = atomic_add_return(1, &cm_node->passive_state);
+		passive_state = atomic_inc_return(&cm_node->passive_state);
 		if (passive_state == I40IW_SEND_RESET_EVENT) {
 			cm_node->state = I40IW_CM_STATE_CLOSED;
 			i40iw_rem_ref_cm_node(cm_node);
@@ -3678,7 +3678,7 @@ int i40iw_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 		return -EINVAL;
 	}
 
-	passive_state = atomic_add_return(1, &cm_node->passive_state);
+	passive_state = atomic_inc_return(&cm_node->passive_state);
 	if (passive_state == I40IW_SEND_RESET_EVENT) {
 		i40iw_rem_ref_cm_node(cm_node);
 		return -ECONNRESET;
-- 
1.9.1

