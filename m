Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362D62B7E69
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 14:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKRNiA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 08:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKRNiA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Nov 2020 08:38:00 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B576EC0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 05:37:59 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id z17so971242qvy.11
        for <linux-rdma@vger.kernel.org>; Wed, 18 Nov 2020 05:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oL9ZE4upvJh/oljpGLb+sWVGETmgVz7ngr+ciRfT49k=;
        b=l5TZbxeXgAkmWP/0QupXAj21lLzhwHFL71oJFi0ryBJTgN2cC1MaMXFrwCr+IoRqs0
         jfPlLDkX+6FQ23YvwnK7igz5Stx0+NnzAYizy6pVLDWelaxH4jsY1/w9sug1o2/9apmy
         w3fuMOplq9d3QDLbGQmAYX2RN7RMTRj+IEY0m1QlGLncnsyqERcC0VZdZx2/0VIfrU7X
         9iq6JWZvpJo/RgnVfeGfEaDnWlmRWfvDjwSShZIpbVtil/YLM749Srvs6MdNfoEbkO0Y
         EKc5HEUegjk9i57tY+F5Dw5KqkKLihh3Egr/jmYcM4ZSZz1F+TV+0aKYhDYPRDrEwGbo
         bjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oL9ZE4upvJh/oljpGLb+sWVGETmgVz7ngr+ciRfT49k=;
        b=cjbXLUL18Lgok32X/tScu7koAVzNY6/aLPEksDgDhfSAKPbOivUfp60G0bIRyxKSPr
         4xVrt2HPW60DIbcwfUUz247mm6qimHfurM2ctGjR+Qbq0GEwIvNZa2MNSAyXrBPp5JwB
         Tnnx27bjpxomT/So8cnIVCetwD0Y+LXGWlRIlp4ya7cjlsF8QT1j7ccbGA3R1WbKjwbw
         IEAA3Sne3krkXJ7oFlxlXn/Fin5WOFcbGnEnS9wNG8rhYVYYp99tZHOYLSZHkOZx34He
         OqLU0AIwwwztN4yvIauYA9vDPYyLSCI/J2YRDLOb5RZUV7eAFcY/ZSPW7l+maLrfk4+q
         yY8w==
X-Gm-Message-State: AOAM530zlqYI+1q2OXU6UPA+Cz5ic5sxJ6bZD9dUsAr9URsHFMZ2X6wC
        ALG98dkSyrh2u2ktxUsk8usbrw==
X-Google-Smtp-Source: ABdhPJzXpJJdjKVdK0fjPS7bypm+rDnXdoigZ9/odAR+ixDpQu8oeaX5z0CA+4HrqTocRzqofwDkQA==
X-Received: by 2002:a0c:bd19:: with SMTP id m25mr4930191qvg.52.1605706678862;
        Wed, 18 Nov 2020 05:37:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b8sm14904247qtx.73.2020.11.18.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:37:58 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kfNem-007jKp-VZ; Wed, 18 Nov 2020 09:37:57 -0400
Date:   Wed, 18 Nov 2020 09:37:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     syzbot <syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com>,
        leon@kernel.org
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in _destroy_id
Message-ID: <20201118133756.GK244516@ziepe.ca>
References: <0000000000004129c705b45fa8f2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000004129c705b45fa8f2@google.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 03:10:21AM -0800, syzbot wrote:

> HEAD commit:    20529233 Add linux-next specific files for 20201118
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13093cf2500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4fb58b6526b3c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=1bc48bf7f78253f664a9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Oh? Is this because the error injection is too random?
 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com
> 
> iwpm_register_pid: Unable to send a nlmsg (client = 2)
> infiniband syz1: RDMA CMA: cma_listen_on_dev, error -98
> ============================================
> WARNING: possible recursive locking detected
> 5.10.0-rc4-next-20201118-syzkaller #0 Not tainted
> syz-executor.5/12844 is trying to acquire lock:
> ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_release_dev drivers/infiniband/core/cma.c:476 [inline]
> ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: _destroy_id+0x299/0xa00 drivers/infiniband/core/cma.c:1852
> 
> but task is already holding lock:
> ffffffff8c684748 (lock#6){+.+.}-{3:3}, at: cma_add_one+0x55c/0xce0 drivers/infiniband/core/cma.c:4902

Leon, this is caused by

commit c80a0c52d85c49a910d0dc0e342e8d8898677dc0
Author: Leon Romanovsky <leon@kernel.org>
Date:   Wed Nov 4 16:40:07 2020 +0200

    RDMA/cma: Add missing error handling of listen_id
    
    Don't silently continue if rdma_listen() fails but destroy previously
    created CM_ID and return an error to the caller.

rdma_destroy_id() can't be called while holding the global lock

This is quite hard to fix. I came up with this ugly thing:

From 8e6568f99fbe4bf734cc4e5dcda987e4ae118bdd Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@nvidia.com>
Date: Wed, 18 Nov 2020 09:33:23 -0400
Subject: [PATCH] RDMA/cma: Fix deadlock on &lock in rdma_cma_listen_on_all()
 error unwind

rdma_detroy_id() cannot be called under &lock - we must instead keep the
error'd ID around until &lock can be released, then destory it.

This is complicated by the usual way listen IDs are destroyed through
cma_process_remove() which can run at any time and will asynchronously
destroy the same ID.

Remove the ID from visiblity of cma_process_remove() before going down the
destroy path outside the locking.

Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 4585f654f88369..c06c87a4dc5e7d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2496,7 +2496,8 @@ static int cma_listen_handler(struct rdma_cm_id *id,
 }
 
 static int cma_listen_on_dev(struct rdma_id_private *id_priv,
-			     struct cma_device *cma_dev)
+			     struct cma_device *cma_dev,
+			     struct rdma_id_private **to_destroy)
 {
 	struct rdma_id_private *dev_id_priv;
 	struct net *net = id_priv->id.route.addr.dev_addr.net;
@@ -2504,6 +2505,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 
 	lockdep_assert_held(&lock);
 
+	*to_destroy = NULL;
 	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
 		return 0;
 
@@ -2518,7 +2520,6 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	       rdma_addr_size(cma_src_addr(id_priv)));
 
 	_cma_attach_to_dev(dev_id_priv, cma_dev);
-	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
 	dev_id_priv->afonly = id_priv->afonly;
@@ -2528,25 +2529,31 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	ret = rdma_listen(&dev_id_priv->id, id_priv->backlog);
 	if (ret)
 		goto err_listen;
+	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
 	return 0;
 err_listen:
-	list_del(&id_priv->listen_list);
+	/* Caller must destroy this after releasing lock */
+	*to_destroy = dev_id_priv;
 	dev_warn(&cma_dev->device->dev, "RDMA CMA: %s, error %d\n", __func__, ret);
-	rdma_destroy_id(&dev_id_priv->id);
 	return ret;
 }
 
 static int cma_listen_on_all(struct rdma_id_private *id_priv)
 {
+	struct rdma_id_private *to_destroy;
 	struct cma_device *cma_dev;
 	int ret;
 
 	mutex_lock(&lock);
 	list_add_tail(&id_priv->list, &listen_any_list);
 	list_for_each_entry(cma_dev, &dev_list, list) {
-		ret = cma_listen_on_dev(id_priv, cma_dev);
-		if (ret)
+		ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
+		if (ret) {
+			/* Prevent racing with cma_process_remove() */
+			if (to_destroy)
+				list_del_init(&to_destroy->list);
 			goto err_listen;
+		}
 	}
 	mutex_unlock(&lock);
 	return 0;
@@ -2554,6 +2561,8 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
 err_listen:
 	list_del(&id_priv->list);
 	mutex_unlock(&lock);
+	if (to_destroy)
+		rdma_destroy_id(&to_destroy->id);
 	return ret;
 }
 
@@ -4855,6 +4864,7 @@ static void cma_process_remove(struct cma_device *cma_dev)
 
 static int cma_add_one(struct ib_device *device)
 {
+	struct rdma_id_private *to_destroy;
 	struct cma_device *cma_dev;
 	struct rdma_id_private *id_priv;
 	unsigned int i;
@@ -4902,7 +4912,7 @@ static int cma_add_one(struct ib_device *device)
 	mutex_lock(&lock);
 	list_add_tail(&cma_dev->list, &dev_list);
 	list_for_each_entry(id_priv, &listen_any_list, list) {
-		ret = cma_listen_on_dev(id_priv, cma_dev);
+		ret = cma_listen_on_dev(id_priv, cma_dev, &to_destroy);
 		if (ret)
 			goto free_listen;
 	}
@@ -4915,6 +4925,7 @@ static int cma_add_one(struct ib_device *device)
 	list_del(&cma_dev->list);
 	mutex_unlock(&lock);
 
+	/* cma_process_remove() will delete to_destroy */
 	cma_process_remove(cma_dev);
 	kfree(cma_dev->default_roce_tos);
 free_gid_type:
-- 
2.29.2

