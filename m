Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00164B51BF
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 14:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiBNNhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Feb 2022 08:37:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245347AbiBNNhU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Feb 2022 08:37:20 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156F825E89;
        Mon, 14 Feb 2022 05:37:11 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21EDax4h064843;
        Mon, 14 Feb 2022 22:36:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Mon, 14 Feb 2022 22:36:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21EDaxGx064835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Feb 2022 22:36:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
Date:   Mon, 14 Feb 2022 22:36:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YgnQGZWT/n3VAITX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/02/14 12:44, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 14, 2022 at 10:08:00AM +0900, Tetsuo Handa wrote:
>> +	destroy_workqueue(srp_tl_err_wq);
>>
>> Then, we can call WARN_ON() if e.g. flush_workqueue() is called on system-wide workqueues.
> 
> Yeah, this is the right thing to do. It makes no sense at all to call
> flush_workqueue() on the shared workqueues as the caller has no idea what
> it's gonna end up waiting for. It was on my todo list a long while ago but
> slipped through the crack. If anyone wanna take a stab at it (including
> scrubbing the existing users, of course), please be my guest.
> 
> Thanks.
> 

OK. Then, I propose below patch. If you are OK with this approach, I can
keep this via my tree as a linux-next only experimental patch for one or
two weeks, in order to see if someone complains.

From 95a3aa8d46c8479c95672305645247ba70312113 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Mon, 14 Feb 2022 22:28:21 +0900
Subject: [PATCH] workqueue: Warn on flushing system-wide workqueues

syzbot found a circular locking dependency which is caused by flushing
system_long_wq WQ [1]. Tejun Heo commented that it makes no sense at all
to call flush_workqueue() on the shared workqueues as the caller has no
idea what it's gonna end up waiting for.

Although there is flush_scheduled_work() which flushes system_wq WQ with
"Think twice before calling this function! It's very easy to get into
trouble if you don't take great care." warning message, it will be too
difficult to guarantee that all users safely flush system-wide WQs.

Therefore, let's change the direction to that developers had better use
their own WQs if flushing is inevitable. To give developers time to update
their modules, for now just emit a warning message when flush_workqueue()
is called on system-wide WQs. We will eventually convert this warning
message into WARN_ON() and kill flush_scheduled_work().

Link: https://syzkaller.appspot.com/bug?extid=831661966588c802aae9 [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/workqueue.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..5ef40b9a1842 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2805,6 +2805,37 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	return wait;
 }
 
+static void warn_if_flushing_global_workqueue(struct workqueue_struct *wq)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
+	const char *name;
+
+	if (wq == system_wq)
+		name = "system_wq";
+	else if (wq == system_highpri_wq)
+		name = "system_highpri_wq";
+	else if (wq == system_long_wq)
+		name = "system_long_wq";
+	else if (wq == system_unbound_wq)
+		name = "system_unbound_wq";
+	else if (wq == system_freezable_wq)
+		name = "system_freezable_wq";
+	else if (wq == system_power_efficient_wq)
+		name = "system_power_efficient_wq";
+	else if (wq == system_freezable_power_efficient_wq)
+		name = "system_freezable_power_efficient_wq";
+	else
+		return;
+	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
+	if (!__ratelimit(&flush_warn_rs))
+		return;
+	pr_warn("Since system-wide WQ is shared, flushing system-wide WQ can introduce unexpected locking dependency. Please replace %s usage in your code with your local WQ.\n",
+		name);
+	dump_stack();
+#endif
+}
+
 /**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
@@ -2824,6 +2855,8 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
+	warn_if_flushing_global_workqueue(wq);
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
 
-- 
2.32.0

