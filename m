Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062D21846EB
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgCMMcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:32:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50792 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCMMcB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:32:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id a5so9738873wmb.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CX0R/ZzCkv41Xb0fuIeFH0zC/H0pc2ea5hZtg9No/Xo=;
        b=YQdEiVQCkjqN4qAnFmyzgtZVSdJuwxbZOMFDy6KowreYmy2PaWAx0uFpFo5ue6GzUv
         ElfRlvgbRRhCj47n6mv6Mzq72scIxND+fb87Xy/fjRkyMTeTWzyCASyLYg0vEbnr6PRd
         wAFCGddgAljtmQEdpUTge6PEI4YCt8hheobNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CX0R/ZzCkv41Xb0fuIeFH0zC/H0pc2ea5hZtg9No/Xo=;
        b=TuSiAnMo4sXdZWGGU/HkKh3yD19njI4ry6HpXhPkOqbgMsV1t6kGWifr8IUn953QEZ
         DYPefTBeJP9DJrMF+w2sYVSWATTEVnSMX+FoknPAu/ZiLczyUOcLE2mKP1NDxFFlyfkw
         ySbPtvqtNIZMFunpBYgljMWT+blAfc/ufCMjfkb8mhP32g/eE3EsXzZs4gBK9C8hT1ve
         gKUakFe/9aKkpp2DYiZp4ygoXSVIx/SooP4GY7zeHcQ8uvZR1jrw5qe0N56ZrwtTxY1N
         GNJN9Adj0vxn3vWVm5SlX7/zPg3aXx3ml3axZzKB0aabqMz4Eu30B1j+ajVsO4zacLPm
         RqNA==
X-Gm-Message-State: ANhLgQ3hArFLmoGYTykIRrI3yKj0rRlLLDi/P6sKDBYd0b0HDwxfjUu5
        YVXpUOfbsUGHeJrkBM1jALemQQ==
X-Google-Smtp-Source: ADFU+vvp/Dgjh/qXMXr21k+7thtyhI4uNClrGd5TgC/uI3hrxAR1h9gCsUvuEtv+iAihWuwLLpKWxw==
X-Received: by 2002:a1c:a50d:: with SMTP id o13mr10435210wme.128.1584102719196;
        Fri, 13 Mar 2020 05:31:59 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g129sm18015910wmg.12.2020.03.13.05.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:31:58 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 3/3] RDMA/bnxt_re: Remove unnecessary sched count
Date:   Fri, 13 Mar 2020 05:31:34 -0700
Message-Id: <1584102694-32544-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
References: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c    | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index c736e82..e35cc6c 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -177,7 +177,6 @@ struct bnxt_re_dev {
 	atomic_t			srq_count;
 	atomic_t			mr_count;
 	atomic_t			mw_count;
-	atomic_t			sched_count;
 	/* Max of 2 lossless traffic class supported per port */
 	u16				cosq[2];
 
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 82062d8..4df0f8e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1670,7 +1670,6 @@ static void bnxt_re_task(struct work_struct *work)
 	}
 	ib_device_put(&rdev->ibdev);
 	smp_mb__before_atomic();
-	atomic_dec(&rdev->sched_count);
 exit:
 	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
@@ -1722,11 +1721,6 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		break;
 
 	case NETDEV_UNREGISTER:
-		/* netdev notifier will call NETDEV_UNREGISTER again later since
-		 * we are still holding the reference to the netdev
-		 */
-		if (atomic_read(&rdev->sched_count) > 0)
-			goto exit;
 		ib_unregister_device_queued(&rdev->ibdev);
 		break;
 
@@ -1744,7 +1738,6 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 			re_work->vlan_dev = (real_dev == netdev ?
 					     NULL : netdev);
 			INIT_WORK(&re_work->work, bnxt_re_task);
-			atomic_inc(&rdev->sched_count);
 			queue_work(bnxt_re_wq, &re_work->work);
 		}
 	}
-- 
2.5.5

