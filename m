Return-Path: <linux-rdma+bounces-682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1136836A2D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 17:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513BF2837AD
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7DC1350D9;
	Mon, 22 Jan 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivkwU4D6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2C1350C4;
	Mon, 22 Jan 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936443; cv=none; b=kSjgHsSSyi4Vk3VHXW8a0+5N5UHPurz/RVE6gFWqmEelUhKlVVMClGy0tJ91Wlv+wYdQj+sGVYZhXUVcXG0kEH8fR3Lj6o53MCFkhzoHzs69umxEXhxqV6hfJif1K48dCoPLNLFS+xK4BdnBoEzXAY4IOakgyz/bQ5yEPvXbWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936443; c=relaxed/simple;
	bh=49DOsppfut0mOCCl9wIiJI0PeW1RP+JBVyHchyr9KPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqafIv3MIjd9R7Rx8PlJvGLFDN/Amo682D8RdEu4TDUrT6Ukhrt3bFPnHFQhe2OkH8n5nwv4zaojC+BCQparN1yaVJuvJoJqIS/hnHuGQskeSCRz1jbSmzE+swSfEeqCcZLSwDLfhDaeKHjm7p71adCNJgzks8j5wke2MMVZO3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivkwU4D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB7C433F1;
	Mon, 22 Jan 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936441;
	bh=49DOsppfut0mOCCl9wIiJI0PeW1RP+JBVyHchyr9KPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivkwU4D6KF+QI+oh7mobB3FkfNBfTkG1UXvODUvyylV1VVwx/SD47KwxgSbrkGSyg
	 GX42oWV/rGiymTAwRvYbzlYc8okjT6xlcFAisHRNG8vTWcPhU4RYy15kNuEKDx9EkZ
	 6VBy41SjCfKpYHlMNuART+QMRMcgZEaRg2NNGwmRkTlCNZ8miVKgwFu/ldPUnRNQi2
	 2LOfI2GP7lfSHpJBJKJErVb+xOPL5G48FzOR0nldvoa7Ub+lauZCyJvSqwhwVLCOPL
	 2MD6olhtDNy23TdqrrOPnHEUx+kRSl4jc3vPXBi+sq62TOv1xm4nIJMeK9v3p1ZQE4
	 gwDIq9tStKSkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Vacek <neelx@redhat.com>,
	Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jinpu.wang@ionos.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 22/35] IB/ipoib: Fix mcast list locking
Date: Mon, 22 Jan 2024 10:12:19 -0500
Message-ID: <20240122151302.995456-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Daniel Vacek <neelx@redhat.com>

[ Upstream commit 4f973e211b3b1c6d36f7c6a19239d258856749f9 ]

Releasing the `priv->lock` while iterating the `priv->multicast_list` in
`ipoib_mcast_join_task()` opens a window for `ipoib_mcast_dev_flush()` to
remove the items while in the middle of iteration. If the mcast is removed
while the lock was dropped, the for loop spins forever resulting in a hard
lockup (as was reported on RHEL 4.18.0-372.75.1.el8_6 kernel):

    Task A (kworker/u72:2 below)       | Task B (kworker/u72:0 below)
    -----------------------------------+-----------------------------------
    ipoib_mcast_join_task(work)        | ipoib_ib_dev_flush_light(work)
      spin_lock_irq(&priv->lock)       | __ipoib_ib_dev_flush(priv, ...)
      list_for_each_entry(mcast,       | ipoib_mcast_dev_flush(dev = priv->dev)
          &priv->multicast_list, list) |
        ipoib_mcast_join(dev, mcast)   |
          spin_unlock_irq(&priv->lock) |
                                       |   spin_lock_irqsave(&priv->lock, flags)
                                       |   list_for_each_entry_safe(mcast, tmcast,
                                       |                  &priv->multicast_list, list)
                                       |     list_del(&mcast->list);
                                       |     list_add_tail(&mcast->list, &remove_list)
                                       |   spin_unlock_irqrestore(&priv->lock, flags)
          spin_lock_irq(&priv->lock)   |
                                       |   ipoib_mcast_remove_list(&remove_list)
   (Here, `mcast` is no longer on the  |     list_for_each_entry_safe(mcast, tmcast,
    `priv->multicast_list` and we keep |                            remove_list, list)
    spinning on the `remove_list` of   |  >>>  wait_for_completion(&mcast->done)
    the other thread which is blocked  |
    and the list is still valid on     |
    it's stack.)

Fix this by keeping the lock held and changing to GFP_ATOMIC to prevent
eventual sleeps.
Unfortunately we could not reproduce the lockup and confirm this fix but
based on the code review I think this fix should address such lockups.

crash> bc 31
PID: 747      TASK: ff1c6a1a007e8000  CPU: 31   COMMAND: "kworker/u72:2"
--
    [exception RIP: ipoib_mcast_join_task+0x1b1]
    RIP: ffffffffc0944ac1  RSP: ff646f199a8c7e00  RFLAGS: 00000002
    RAX: 0000000000000000  RBX: ff1c6a1a04dc82f8  RCX: 0000000000000000
                                  work (&priv->mcast_task{,.work})
    RDX: ff1c6a192d60ac68  RSI: 0000000000000286  RDI: ff1c6a1a04dc8000
           &mcast->list
    RBP: ff646f199a8c7e90   R8: ff1c699980019420   R9: ff1c6a1920c9a000
    R10: ff646f199a8c7e00  R11: ff1c6a191a7d9800  R12: ff1c6a192d60ac00
                                                         mcast
    R13: ff1c6a1d82200000  R14: ff1c6a1a04dc8000  R15: ff1c6a1a04dc82d8
           dev                    priv (&priv->lock)     &priv->multicast_list (aka head)
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ff646f199a8c7e00] ipoib_mcast_join_task+0x1b1 at ffffffffc0944ac1 [ib_ipoib]
 #6 [ff646f199a8c7e98] process_one_work+0x1a7 at ffffffff9bf10967

crash> rx ff646f199a8c7e68
ff646f199a8c7e68:  ff1c6a1a04dc82f8 <<< work = &priv->mcast_task.work

crash> list -hO ipoib_dev_priv.multicast_list ff1c6a1a04dc8000
(empty)

crash> ipoib_dev_priv.mcast_task.work.func,mcast_mutex.owner.counter ff1c6a1a04dc8000
  mcast_task.work.func = 0xffffffffc0944910 <ipoib_mcast_join_task>,
  mcast_mutex.owner.counter = 0xff1c69998efec000

crash> b 8
PID: 8        TASK: ff1c69998efec000  CPU: 33   COMMAND: "kworker/u72:0"
--
 #3 [ff646f1980153d50] wait_for_completion+0x96 at ffffffff9c7d7646
 #4 [ff646f1980153d90] ipoib_mcast_remove_list+0x56 at ffffffffc0944dc6 [ib_ipoib]
 #5 [ff646f1980153de8] ipoib_mcast_dev_flush+0x1a7 at ffffffffc09455a7 [ib_ipoib]
 #6 [ff646f1980153e58] __ipoib_ib_dev_flush+0x1a4 at ffffffffc09431a4 [ib_ipoib]
 #7 [ff646f1980153e98] process_one_work+0x1a7 at ffffffff9bf10967

crash> rx ff646f1980153e68
ff646f1980153e68:  ff1c6a1a04dc83f0 <<< work = &priv->flush_light

crash> ipoib_dev_priv.flush_light.func,broadcast ff1c6a1a04dc8000
  flush_light.func = 0xffffffffc0943820 <ipoib_ib_dev_flush_light>,
  broadcast = 0x0,

The mcast(s) on the `remove_list` (the remaining part of the ex `priv->multicast_list`):

crash> list -s ipoib_mcast.done.done ipoib_mcast.list -H ff646f1980153e10 | paste - -
ff1c6a192bd0c200          done.done = 0x0,
ff1c6a192d60ac00          done.done = 0x0,

Reported-by: Yuya Fujita-bishamonten <fj-lsoft-rh-driver@dl.jp.fujitsu.com>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Link: https://lore.kernel.org/all/20231212080746.1528802-1-neelx@redhat.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 9e6967a40042..319d4288eddd 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -531,21 +531,17 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		if (test_bit(IPOIB_MCAST_FLAG_SENDONLY, &mcast->flags))
 			rec.join_state = SENDONLY_FULLMEMBER_JOIN;
 	}
-	spin_unlock_irq(&priv->lock);
 
 	multicast = ib_sa_join_multicast(&ipoib_sa_client, priv->ca, priv->port,
-					 &rec, comp_mask, GFP_KERNEL,
+					 &rec, comp_mask, GFP_ATOMIC,
 					 ipoib_mcast_join_complete, mcast);
-	spin_lock_irq(&priv->lock);
 	if (IS_ERR(multicast)) {
 		ret = PTR_ERR(multicast);
 		ipoib_warn(priv, "ib_sa_join_multicast failed, status %d\n", ret);
 		/* Requeue this join task with a backoff delay */
 		__ipoib_mcast_schedule_join_thread(priv, mcast, 1);
 		clear_bit(IPOIB_MCAST_FLAG_BUSY, &mcast->flags);
-		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
-		spin_lock_irq(&priv->lock);
 		return ret;
 	}
 	return 0;
-- 
2.43.0


