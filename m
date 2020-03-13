Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DE184C95
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCMQdt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 12:33:49 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52114 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMQds (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 12:33:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id hg10so471590pjb.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 09:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gqXtojhoEmVn7L9BsOh24l7erKEJLD548EVbGfm9zd4=;
        b=hN3Hu1uE+LL8Ya+OdT/n0TL8YhJ8CkAY5HNBjfOpIogLuebg3DAnl9KO5CKfh20A2L
         jo/HkQg8+xcXkss5UnxuiM1UJRtj7D7S4UxVZynVMbnE4ykMm1rlzBIzuXnzWvZiKNkr
         m75lFdJlmF7s0mby3uZUdEpKzQbqE2opN4AH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gqXtojhoEmVn7L9BsOh24l7erKEJLD548EVbGfm9zd4=;
        b=TIgqBwJel7jOnBuPambWv5U6yMHshSmIe8rfIK3PojBfamRMpTBuHL2/TWaSmjrjbE
         6OugTMyYk5sZxtQGg0+QNFMuJll+NYDHK4dSklMyiobOanerMmbxfl73e7vJ0M5YxiMk
         /1as7AcVICEo+eTbojQsQ6++XyDwDQBYecStb73TELhYJTwqLvcPPbqE1PwutuCcrAET
         Y7gbGdltHaWN5qJ2f/2s988335X08nJcWGy1UTAgLGjsLraKQFihqsmz7+qp2Dmg50rS
         YQOtC8Ww2PiZkSntZPyPU4Tm+Bk9AymSsKLI0ASrMr/JdzUxvE4ZvJApq/YHYNfUb7X6
         39JA==
X-Gm-Message-State: ANhLgQ0XrANq13D9SmK0JqSxDoq/zGIuHrzOOJbLIgtlKmox5MvcT8Zq
        OudMvZ+Pypvc/DnJbqd797JY5w==
X-Google-Smtp-Source: ADFU+vvhOr7dBEnUvn6JGckKzk4rgr0YlpTfwZBpvQls8LD8y4QayH4LJavDgASD7QiNqWQ397pOQA==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr14185118plo.220.1584117227758;
        Fri, 13 Mar 2020 09:33:47 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id v5sm2338344pjn.2.2020.03.13.09.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:33:47 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 for-next 3/3] RDMA/bnxt_re: Remove unnecessary sched count
Date:   Fri, 13 Mar 2020 09:33:27 -0700
Message-Id: <1584117207-2664-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584117207-2664-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since the lifetime of bnxt_re_task is controlled by
the kref of device, sched_count is no longer required.
Remove it.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 1 -
 drivers/infiniband/hw/bnxt_re/main.c    | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 407141e..a300588 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -176,7 +176,6 @@ struct bnxt_re_dev {
 	atomic_t			srq_count;
 	atomic_t			mr_count;
 	atomic_t			mw_count;
-	atomic_t			sched_count;
 	/* Max of 2 lossless traffic class supported per port */
 	u16				cosq[2];
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c494e11..4a8fb1a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1667,8 +1667,6 @@ static void bnxt_re_task(struct work_struct *work)
 		break;
 	}
 	ib_device_put(&rdev->ibdev);
-	smp_mb__before_atomic();
-	atomic_dec(&rdev->sched_count);
 exit:
 	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
@@ -1720,11 +1718,6 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		break;
 
 	case NETDEV_UNREGISTER:
-		/* netdev notifier will call NETDEV_UNREGISTER again later since
-		 * we are still holding the reference to the netdev
-		 */
-		if (atomic_read(&rdev->sched_count) > 0)
-			goto exit;
 		ib_unregister_device_queued(&rdev->ibdev);
 		break;
 
@@ -1742,7 +1735,6 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 			re_work->vlan_dev = (real_dev == netdev ?
 					     NULL : netdev);
 			INIT_WORK(&re_work->work, bnxt_re_task);
-			atomic_inc(&rdev->sched_count);
 			queue_work(bnxt_re_wq, &re_work->work);
 		}
 	}
-- 
2.5.5

