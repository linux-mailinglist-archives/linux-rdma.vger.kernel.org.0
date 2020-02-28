Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA7173D0B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2020 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgB1QfZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Feb 2020 11:35:25 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43847 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgB1QfZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Feb 2020 11:35:25 -0500
Received: by mail-qt1-f193.google.com with SMTP id g21so2423961qtq.10
        for <linux-rdma@vger.kernel.org>; Fri, 28 Feb 2020 08:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cYqJRi1QOe+wlryQ8p8t2fHcUcw0sswVbNddR/pNzUk=;
        b=bTUpqVQyuzQPG14Zv/QoPWp3lpR03zH94VNMyBpgepmlH94o/m75w5h79GdwL+Dr/R
         cqFpPH0ubOWrgtyLWNXqWukQ444OmyRezpRNqq8wOZPJjhGAb9oPP84E7kPj5YB+LcaT
         oAgYIriADXHN9kkCQEz54+yRhGx+niVm1If460HGnYzWzw6WyOeAPRIgkpDBlUAvS+bI
         zIACL9TbmVTAn4sfIbSh5mt1Mjs8Xipa4pBFJDJ8l85Lq0P4C/QMg21EfD0zM35hBXK4
         59cxgxosJNVwDfDFGA12hWTaDaN4dbQiOxp2T5EM92aopsxn9cn+kKPH7WTT+OXqOc4I
         /6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cYqJRi1QOe+wlryQ8p8t2fHcUcw0sswVbNddR/pNzUk=;
        b=pyKcXrylJEn493tG8zOUjp0CkAX22FE+lEw2TdbOBVVzP4eEF4f/i8MaNbaJTqX09G
         lel6iyslJJ/Om3o+URUB9HUnU/msNH8qCK/LN9DbkumhK3ob3Fxkqdyd6nH3TiS9Y148
         oh5fP/w4XoB2jPlkGSugm5bndZH33KdD4wafrUI5uepoj8IAYcxu7K7DMvWhekJQOvru
         d1J32aqbjUraORXfFpfaF2ZvwwMi+TV5V4tAkG7BBsumwss2lJ1pRgpKc/pBAmk8qfdt
         uJ0M/PIPb1WY0EFwAYXQO7nw6evig0Xi4nQPgkiRzs49bL+kOP121wehmT8eIsInObno
         AhiA==
X-Gm-Message-State: APjAAAVEiAnHJFjFCOEEuLvBUgFUvzyFVhMZUDuEdBazv7QKe0akKnl9
        H5+En3JHBOHjPynIqbyelMX1XwUrVLKtaQ==
X-Google-Smtp-Source: APXvYqxFUwEfoVgLOPAKK+/TfFJkchim281DC7MHAsswbFZ6mtnSkdN6fZfraLVAcYZgl/FM+ScRRg==
X-Received: by 2002:ac8:5486:: with SMTP id h6mr4959016qtq.17.1582907724022;
        Fri, 28 Feb 2020 08:35:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w83sm4758870qkb.83.2020.02.28.08.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:35:23 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7ibj-0007G7-02; Fri, 28 Feb 2020 12:35:23 -0400
Date:   Fri, 28 Feb 2020 12:35:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 2/2] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
Message-ID: <20200228163522.GA27288@ziepe.ca>
References: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
 <1582731932-26574-3-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582731932-26574-3-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 07:45:32AM -0800, Selvin Xavier wrote:
> @@ -1724,6 +1714,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>  		rc = bnxt_re_add_device(&rdev, real_dev);
>  		if (!rc)
>  			sch_work = true;
> +		release = false;
>  		break;
>  
>  	case NETDEV_UNREGISTER:
> @@ -1732,8 +1723,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>  		 */
>  		if (atomic_read(&rdev->sched_count) > 0)
>  			goto exit;

This sched_count stuff needs cleaning too.

krefs should be used properly, carry the kref on the ib_device into
the work and use the registration lock on the ib device to serialize
instead of this sched_count stuff.

This all sounds so familiar.. Oh I tried to fix this once - maybe the
below will help you:

commit 33d88c818d155ffb2ef4b12e72107f628c70404c
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu Jan 10 12:05:19 2019 -0700

    RDMA/bnxt_re: Use ib_device_get_by_netdev() instead of open coding
    
    The core API handles the locking correctly and is faster if there
    are multiple devices.
    
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fa539608ffbbe0..bd67a31937ec65 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -504,21 +504,6 @@ static bool is_bnxt_re_dev(struct net_device *netdev)
 	return false;
 }
 
-static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
-{
-	struct bnxt_re_dev *rdev;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(rdev, &bnxt_re_dev_list, list) {
-		if (rdev->netdev == netdev) {
-			rcu_read_unlock();
-			return rdev;
-		}
-	}
-	rcu_read_unlock();
-	return NULL;
-}
-
 static void bnxt_re_dev_unprobe(struct net_device *netdev,
 				struct bnxt_en_dev *en_dev)
 {
@@ -1616,23 +1601,26 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 {
 	struct net_device *real_dev, *netdev = netdev_notifier_info_to_dev(ptr);
 	struct bnxt_re_work *re_work;
-	struct bnxt_re_dev *rdev;
+	struct bnxt_re_dev *rdev = NULL;
+	struct ib_device *ibdev;
 	int rc = 0;
 	bool sch_work = false;
 
 	real_dev = rdma_vlan_dev_real_dev(netdev);
 	if (!real_dev)
 		real_dev = netdev;
-
-	rdev = bnxt_re_from_netdev(real_dev);
-	if (!rdev && event != NETDEV_REGISTER)
-		goto exit;
 	if (real_dev != netdev)
 		goto exit;
 
+	ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_BNXT_RE);
+	if (!ibdev && event != NETDEV_REGISTER)
+		goto exit;
+	if (ibdev)
+		rdev = container_of(ibdev, struct bnxt_re_dev, ibdev);
+
 	switch (event) {
 	case NETDEV_REGISTER:
-		if (rdev)
+		if (ibdev)
 			break;
 		rc = bnxt_re_dev_reg(&rdev, real_dev);
 		if (rc == -ENODEV)
@@ -1676,6 +1664,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		}
 	}
 
+	if (ibdev)
+		ib_device_put(ibdev);
+
 exit:
 	return NOTIFY_DONE;
 }

commit 6c617f08e749ee0f6c7be6763ea92e49ae484712
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu Jan 10 14:40:16 2019 -0700

    RDMA/bnxt_re: Use ib_device_try_get()
    
    There are a couple places in this driver running from a work queue that
    need the ib_device to be registered. Instead of using a broken internal
    bit rely on the new core code to guarantee device registration.
    
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 666897596218d3..fa539608ffbbe0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1137,12 +1137,13 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 	u16 gid_idx, index;
 	int rc = 0;
 
-	if (!test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
+	if (!ib_device_try_get(&rdev->ibdev))
 		return 0;
 
 	if (!sgid_tbl) {
 		dev_err(rdev_to_dev(rdev), "QPLIB: SGID table not allocated");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	for (index = 0; index < sgid_tbl->active; index++) {
@@ -1163,6 +1164,8 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
 					    rdev->qplib_res.netdev->dev_addr);
 	}
 
+out:
+	ib_device_put(&rdev->ibdev);
 	return rc;
 }
 
@@ -1545,12 +1548,7 @@ static void bnxt_re_task(struct work_struct *work)
 	re_work = container_of(work, struct bnxt_re_work, work);
 	rdev = re_work->rdev;
 
-	if (re_work->event != NETDEV_REGISTER &&
-	    !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
-		goto exit;
-
-	switch (re_work->event) {
-	case NETDEV_REGISTER:
+	if (re_work->event == NETDEV_REGISTER) {
 		rc = bnxt_re_ib_reg(rdev);
 		if (rc) {
 			dev_err(rdev_to_dev(rdev),
@@ -1559,7 +1557,13 @@ static void bnxt_re_task(struct work_struct *work)
 			bnxt_re_dev_unreg(rdev);
 			goto exit;
 		}
-		break;
+		goto exit;
+	}
+
+	if (!ib_device_try_get(&rdev->ibdev))
+		goto exit;
+
+	switch (re_work->event) {
 	case NETDEV_UP:
 		bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
 				       IB_EVENT_PORT_ACTIVE);
@@ -1579,6 +1583,8 @@ static void bnxt_re_task(struct work_struct *work)
 	default:
 		break;
 	}
+
+	ib_device_put(&rdev->ibdev);
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:

commit e64da98a182a2cae3338f28f6e581f189b5f8674
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu Jan 10 12:02:11 2019 -0700

    RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
    
    A work queue cannot just rely on the ib_device not being freed, it must
    hold a kref on the memory so that the BNXT_RE_FLAG_IBDEV_REGISTERED check
    works.
    
    Also, every single work queue call has an allocated memory, and the kfree
    of this memory was missed sometimes.
    
    Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 814f959c7db965..666897596218d3 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1547,7 +1547,7 @@ static void bnxt_re_task(struct work_struct *work)
 
 	if (re_work->event != NETDEV_REGISTER &&
 	    !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
-		return;
+		goto exit;
 
 	switch (re_work->event) {
 	case NETDEV_REGISTER:
@@ -1582,6 +1582,7 @@ static void bnxt_re_task(struct work_struct *work)
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
 exit:
+	put_device(&rdev->ibdev.dev);
 	kfree(re_work);
 }
 
@@ -1658,6 +1659,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		/* Allocate for the deferred task */
 		re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
 		if (re_work) {
+			get_device(&rdev->ibdev.dev);
 			re_work->rdev = rdev;
 			re_work->event = event;
 			re_work->vlan_dev = (real_dev == netdev ?
