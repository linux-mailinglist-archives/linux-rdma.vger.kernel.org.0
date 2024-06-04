Return-Path: <linux-rdma+bounces-2820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D022B8FB09A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DA81F21975
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1697C144D3A;
	Tue,  4 Jun 2024 10:55:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDF1420D7
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498524; cv=none; b=HcYp0uLDQjWCIqZLKmEXBZ30hKBXdZiMZmd+iBlbKwp3MWjhHk1QFCbDx8ujcvZzgH8DHRE36+UCJBHSmUccDS8lPjEp9e0nId62n3ZS/ADgF8yESNHkYYfMkB9VPbvwHd9WTsCHbn+T/OTrUG41d9qfWq/ynf62EFI7ySOxJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498524; c=relaxed/simple;
	bh=wV5Cq68GjGdP5oijvBuOZFA7zgkjpyxF8ip/BZcMOw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcMqIsuW7guZ0YRwepRjAYUCJaa2OBKxGc2dCXOQpZh5wxyLUv6ezHiS6Up6NnLCZnqqRCUqRQRoKJkRcqRowkNzQq6+CL5zZAVhEhG/OLWS2b//opy8IfH+bvG+dwZXZZ5mCXKZ4irVAqLiapDCqsI9Z0Zlu+ASiDXlz+bEUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.129])
	by sina.com (10.185.250.21) with ESMTP
	id 665EF28900003DE7; Tue, 4 Jun 2024 18:55:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3986503408482
X-SMAIL-UIID: 0DC135B6AE7141AE9B325C5C6B26B03A-20240604-185508-1
From: Hillf Danton <hdanton@sina.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep worning
Date: Tue,  4 Jun 2024 18:54:56 +0800
Message-Id: <20240604105456.1668-1-hdanton@sina.com>
In-Reply-To: <20240604080958.GL3884@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org> <ZljyqODpCD0_5-YD@slm.duckdns.org> <20240531034851.GF3884@unreal> <Zl4jPImmEeRuYQjz@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 4 Jun 2024 11:09:58 +0300 Leon Romanovsky <leon@kernel.org>
> On Mon, Jun 03, 2024 at 10:10:36AM -1000, Tejun Heo wrote:
> > 
> > And KASAN is reporting use-after-free on a completely unrelated VFS object.
> > I can't tell for sure from the logs alone but lockdep_register_key()
> > iterates entries in the hashtable trying to find whether the key is a
> > duplicate and it could be that that walk is triggering the use-after-free
> > warning. If so, it doesn't really have much to do with workqueue. The
> > corruption happened elsewhere and workqueue just happens to traverse the
> > hashtable afterwards.
> 
> The problem is that revert of commit 643445531829
> ("workqueue: Fix UAF report by KASAN in pwq_release_workfn()")
> fixed these use-after-free reports.
> 
Given revert makes sense,

	if (alloc_and_link_pwqs(wq) < 0)
		goto err_unreg_lockdep;

err_unreg_lockdep:
	wq_unregister_lockdep(wq);
	wq_free_lockdep(wq);
err_free_wq:
	free_workqueue_attrs(wq->unbound_attrs);
	kfree(wq);	<-- freed
	return NULL;

the difference 643445531829 makes is double free.

	alloc_and_link_pwqs(struct workqueue_struct *wq)
	if (ret)
		kthread_flush_worker(pwq_release_worker);
		  pwq_release_workfn()
		  if (is_last) {
			wq_unregister_lockdep(wq);
			call_rcu(&wq->rcu, rcu_free_wq); <-- freed again
		  }

