Return-Path: <linux-rdma+bounces-5578-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2149B37B0
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 18:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A61C219FD
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C71DED46;
	Mon, 28 Oct 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="nuw7oGQo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA918BC3D
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136751; cv=none; b=hFwmu/uwagZ8/8ITNJTxMDI/W4GktqzFmMwU0LF7lfw9KJ9dylsZUHfHAU9Z2wCmWQew+mWj09g3K3oSElfa48ZoDVAErEFfWzt/sgs9Tr62TAgGoT8MwerQS/W+6YqxkYHACozEo/9KDeGaRdzDM0Wf7s5RdmB30+BV8VbVxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136751; c=relaxed/simple;
	bh=jyijJcs2qxU2htOc75n6okVi8HxiWO16YN3gdjhhS0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1An8Gz96BuMwZkSTs+3AirzvNRmYM4Rd9FsXEG5q9RmDbClx1DWB4WVHXetP6s8ChmBuc8udRYUM2lusbLWH56+n1COnk/WI+KMr1a4ef9k7dpkfifweuvWNp1jqKFdjV3/JWtKMSB0YlAZsc6oPL8JipUcnLcyeEL0yYCQ7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=nuw7oGQo; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XcgSQ0pwDz6Cnk9V;
	Mon, 28 Oct 2024 17:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730136738; x=1732728739; bh=190It0XzcCPDLi0JUhUNNBE+
	/u5r3jlUdylTLxr5zCA=; b=nuw7oGQoWDVlf8Z7RQSkR7mnQz7ddFvkbxKJH9N1
	sbn9/ZvvAG0zZMwosFREjn4a0XWthHIO6/e++7gB4EAHOyEorW/OLbCujllLZy7C
	llBfMt9Q+OCXD9LfrlEGETOg8ydqwH8kTkg894xAJkUAL7Cw6JyYLaws/C5gpkE9
	nC6U5fhEmTUIELqkhJeH0FPPunsOA/QsyRyjyOXkyFKXzxx/pbYmaIKRzblEipvl
	p4Xg0Nkv5ndV8SEhRfWssteoCZFWlmZC7NokDl4k7DDo4+0+bbGUTl2XmklwXvbC
	4jlxO5urbJAbf5RL/Z+E+EsA07q+fi1TMdmSZlpBbJmMHw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VfuTzQsswdsj; Mon, 28 Oct 2024 17:32:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XcgSL3ky4z6Cnk9T;
	Mon, 28 Oct 2024 17:32:18 +0000 (UTC)
Message-ID: <2108afcb-1bfa-48b4-b1bc-42dac83b6229@acm.org>
Date: Mon, 28 Oct 2024 10:32:17 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Iser target machine hits kernel panic while running iozone
 traffic with link toggle on initiator
To: Showrya M N <showrya@chelsio.com>
Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com
References: <20241028062246.10997-1-showrya@chelsio.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241028062246.10997-1-showrya@chelsio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/24 11:22 PM, Showrya M N wrote:
> case 1: Reverted commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()") and kept a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()")
> 
>          Before 'commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()"), cm_work_handler() takes single lock to delete the work and checks for
>          list_empty. After the commit, cm_work_handler() now takes separate locks for each operation.
>          However, there is a scenario where cm_work_handler() processed all the work in the worklist and is waiting to acquire the lock to check if the
>          worklist is empty. Meanwhile, cm_event_handler() may take the lock, check the same condition, add new work to the same worklist,
>          and queue this work, assuming the worklist is free. Since cm_work_handler() is still processing the same worklist, it will continue
>          to process the newly added work as well, since cm_event_handler() queues the same work, this can lead to reprocessing of the same work, resulting in below error.

I do not agree that commit e1168f09b331 can lead to processing a single
work item twice.

> case 2: Reverted commit a1babdb5b615 ("RDMA/iwcm: Simplify cm_work_handler()") and kept e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")
> 
>          After 'commit e1168f09b331 ("RDMA/iwcm: Simplify cm_event_handler()")', cm_event_handler() calls queue_work() whenever work is added to the worklist.
>          if the work is added while cm_work_handler() is processing the same worklist, cm_work_handler() may process the newly added work as well.
>          Since cm_event_handler() unconditionally calls queue_work(), the same work can be reprocessed, leading to below error.

The above doesn't sound correct to me either. cm_event_handler() calls
list_add_tail() and queue_work() while holding cm_id_priv->lock.
cm_work_handler() obtains cm_id_priv->lock before it checks the list
with pending work items. Hence, the order in which cm_event_handler()
calls list_add_tail() and queue_work() doesn't matter.

> I am in favor of reverting above commits and restoring the previous
> code, since these commits are about code rearrange. Please let me
> know your views on it.
If anyone can point out anything that's wrong with these commits I'm
totally fine with reverting these commits. However, I haven't seen any
evidence so far that there is anything wrong with either commit.

> Here are the logs from crash file:
> 
> [21088.907704] ------------[ cut here ]------------
> [21088.907710] WARNING: CPU: 8 PID: 134019 at kernel/workqueue.c:1680 __pwq_activate_work+0x90/0xa0
> [21088.907814] Call Trace:
> [21088.907816]  <TASK>
> [21088.907818]  ? __warn+0x7f/0x120
> [21088.907823]  ? __pwq_activate_work+0x90/0xa0
> [21088.907826]  ? report_bug+0x18a/0x1a0
> [21088.907831]  ? handle_bug+0x3c/0x70
> [21088.907834]  ? exc_invalid_op+0x14/0x70
> [21088.907837]  ? asm_exc_invalid_op+0x16/0x20
> [21088.907844]  ? __pwq_activate_work+0x90/0xa0
> [21088.907848]  pwq_dec_nr_in_flight+0x28f/0x330
> [21088.907852]  worker_thread+0x23d/0x350
> [21088.907855]  ? __pfx_worker_thread+0x10/0x10
> [21088.907857]  kthread+0xcf/0x100
> [21088.907861]  ? __pfx_kthread+0x10/0x10
> [21088.907864]  ret_from_fork+0x30/0x50
> [21088.907869]  ? __pfx_kthread+0x10/0x10
> [21088.907871]  ret_from_fork_asm+0x1a/0x30
> [21088.907878]  </TASK>

> [21088.907888] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [21088.907960] Call Trace:
> [21088.907962]  <TASK>
> [21088.907964]  ? __die+0x20/0x70
> [21088.907970]  ? page_fault_oops+0x75/0x170
> [21088.907977]  ? exc_page_fault+0x64/0x140
> [21088.907983]  ? asm_exc_page_fault+0x22/0x30
> [21088.907991]  ? process_one_work+0xbf/0x390
> [21088.907994]  worker_thread+0x23d/0x350
> [21088.907998]  ? __pfx_worker_thread+0x10/0x10
> [21088.908001]  kthread+0xcf/0x100
> [21088.908006]  ? __pfx_kthread+0x10/0x10
> [21088.908010]  ret_from_fork+0x30/0x50
> [21088.908015]  ? __pfx_kthread+0x10/0x10
> [21088.908018]  ret_from_fork_asm+0x1a/0x30
> [21088.908025]  </TASK>

The above may indicate a use-after-free of struct iwcm_work. Does the
untested patch below help?

Thanks,

Bart.


diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 7e3a55349e10..700e60bac909 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -141,6 +141,8 @@ static struct iwcm_work *get_work(struct 
iwcm_id_private *cm_id_priv)
  {
  	struct iwcm_work *work;

+	lockdep_assert_held(&cm_id_priv->lock);
+
  	if (list_empty(&cm_id_priv->work_free_list))
  		return NULL;
  	work = list_first_entry(&cm_id_priv->work_free_list, struct iwcm_work,
@@ -151,6 +153,8 @@ static struct iwcm_work *get_work(struct 
iwcm_id_private *cm_id_priv)

  static void put_work(struct iwcm_work *work)
  {
+	lockdep_assert_held(&work->cm_id->lock);
+
  	list_add(&work->free_list, &work->cm_id->work_free_list);
  }

@@ -158,6 +162,8 @@ static void dealloc_work_entries(struct 
iwcm_id_private *cm_id_priv)
  {
  	struct list_head *e, *tmp;

+	lockdep_assert_held(&cm_id_priv->lock);
+
  	list_for_each_safe(e, tmp, &cm_id_priv->work_free_list) {
  		list_del(e);
  		kfree(list_entry(e, struct iwcm_work, free_list));
@@ -172,11 +178,14 @@ static int alloc_work_entries(struct 
iwcm_id_private *cm_id_priv, int count)
  	while (count--) {
  		work = kmalloc(sizeof(struct iwcm_work), GFP_KERNEL);
  		if (!work) {
+			guard(spinlock_irqsave)(&cm_id_priv->lock);
  			dealloc_work_entries(cm_id_priv);
  			return -ENOMEM;
  		}
  		work->cm_id = cm_id_priv;
  		INIT_LIST_HEAD(&work->list);
+
+		guard(spinlock_irqsave)(&cm_id_priv->lock);
  		put_work(work);
  	}
  	return 0;
@@ -200,7 +209,9 @@ static int copy_private_data(struct iw_cm_event *event)

  static void free_cm_id(struct iwcm_id_private *cm_id_priv)
  {
-	dealloc_work_entries(cm_id_priv);
+	scoped_guard(spinlock_irqsave, &cm_id_priv->lock) {
+		dealloc_work_entries(cm_id_priv);
+	}
  	kfree(cm_id_priv);
  }



