Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A864B6945
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 11:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiBOK0w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 05:26:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiBOK0v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 05:26:51 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9AFAE54;
        Tue, 15 Feb 2022 02:26:40 -0800 (PST)
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21FAQMF4069468;
        Tue, 15 Feb 2022 19:26:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Tue, 15 Feb 2022 19:26:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21FAQMhM069464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Feb 2022 19:26:22 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
Date:   Tue, 15 Feb 2022 19:26:18 +0900
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
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <YgqSsuSN5C7StvKx@slm.duckdns.org>
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

On 2022/02/15 2:34, Tejun Heo wrote:
> 
> Instead of doing the above, please add a wq flag to mark system wqs and
> trigger the warning that way and I'd leave it regardless of PROVE_LOCKING.
> 

Do you mean something like below?
I think the above is easier to understand (for developers) because

  The above prints variable's name (one of 'system_wq', 'system_highpri_wq',
  'system_long_wq', 'system_unbound_wq', 'system_freezable_wq', 'system_power_efficient_wq'
  or 'system_freezable_power_efficient_wq') with backtrace (which will be translated into
  filename:line format) while the below prints queue's name (one of 'events', 'events_highpri',
  'events_long', 'events_unbound', 'events_freezable', 'events_power_efficient' or
  'events_freezable_power_efficient'). If CONFIG_KALLSYMS_ALL=y, we can print
  variable's name using "%ps", but CONFIG_KALLSYMS_ALL is not always enabled.

  The flag must not be used by user-defined WQs, for destroy_workqueue() involves
  flush_workqueue(). If this flag is by error used on user-defined WQs, pointless
  warning will be printed. I didn't pass this flag when creating system-wide WQs
  because some developer might copy&paste the
    system_wq = alloc_workqueue("events", 0, 0);
  lines when converting.

---
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..9e33dcd417d3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -339,6 +339,7 @@ enum {
 	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	= 1 << 19, /* internal: alloc_ordered_workqueue() */
+	__WQ_SYSTEM_WIDE        = 1 << 20, /* interbal: don't flush this workqueue */
 
 	WQ_MAX_ACTIVE		= 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	= 4,	  /* 4 * #cpus for unbound wq */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..dbb9c6bb54a7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2805,6 +2805,21 @@ static bool flush_workqueue_prep_pwqs(struct workqueue_struct *wq,
 	return wait;
 }
 
+static void warn_if_flushing_global_workqueue(struct workqueue_struct *wq)
+{
+	static DEFINE_RATELIMIT_STATE(flush_warn_rs, 600 * HZ, 1);
+
+	if (likely(!(wq->flags & __WQ_SYSTEM_WIDE)))
+		return;
+
+	ratelimit_set_flags(&flush_warn_rs, RATELIMIT_MSG_ON_RELEASE);
+	if (!__ratelimit(&flush_warn_rs))
+		return;
+	pr_warn("Since system-wide WQ is shared, flushing system-wide WQ can introduce unexpected locking dependency. Please replace %s usage in your code with your local WQ.\n",
+		wq->name);
+	dump_stack();
+}
+
 /**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
@@ -2824,6 +2839,8 @@ void flush_workqueue(struct workqueue_struct *wq)
 	if (WARN_ON(!wq_online))
 		return;
 
+	warn_if_flushing_global_workqueue(wq);
+
 	lock_map_acquire(&wq->lockdep_map);
 	lock_map_release(&wq->lockdep_map);
 
@@ -6070,6 +6087,13 @@ void __init workqueue_init_early(void)
 	       !system_unbound_wq || !system_freezable_wq ||
 	       !system_power_efficient_wq ||
 	       !system_freezable_power_efficient_wq);
+	system_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_highpri_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_long_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_unbound_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_freezable_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_power_efficient_wq->flags |= __WQ_SYSTEM_WIDE;
+	system_freezable_power_efficient_wq->flags |= __WQ_SYSTEM_WIDE;
 }
 
 /**
-- 
2.32.0


