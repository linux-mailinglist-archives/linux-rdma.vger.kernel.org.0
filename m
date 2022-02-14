Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275784B3ECA
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Feb 2022 02:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiBNBI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Feb 2022 20:08:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiBNBI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Feb 2022 20:08:27 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B973527D0;
        Sun, 13 Feb 2022 17:08:20 -0800 (PST)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21E183vd050563;
        Mon, 14 Feb 2022 10:08:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Mon, 14 Feb 2022 10:08:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21E1825Z050560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Feb 2022 10:08:03 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
Date:   Mon, 14 Feb 2022 10:08:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <0000000000005975a605d7aef05e@google.com>
 <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
 <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
 <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
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

On 2022/02/14 8:06, Bart Van Assche wrote:
> On 2/12/22 09:14, Tetsuo Handa wrote:
>> How can reviewing all flush_workqueue(system_long_wq) calls help?
> 
> It is allowed to queue blocking actions on system_long_wq.

Correct.

> flush_workqueue(system_long_wq) can make a lower layer (e.g. ib_srp)
> wait on a blocking action from a higher layer (e.g. the loop driver)
> and thereby cause a deadlock.

Correct.

> Hence my proposal to review all flush_workqueue(system_long_wq) calls.

Maybe I'm misunderstanding what the "review" means.

My proposal is to "rewrite" any module which needs to call flush_workqueue()
on system-wide workqueues or call flush_work()/flush_*_work() which will
depend on system-wide workqueues.

That is, for example, "rewrite" ib_srp module not to call flush_workqueue(system_long_wq).

+	srp_tl_err_wq = alloc_workqueue("srp_tl_err_wq", 0, 0);

-	queue_work(system_long_wq, &target->tl_err_work);
+	queue_work(srp_tl_err_wq, &target->tl_err_work);

-	flush_workqueue(system_long_wq);
+	flush_workqueue(srp_tl_err_wq);

+	destroy_workqueue(srp_tl_err_wq);

Then, we can call WARN_ON() if e.g. flush_workqueue() is called on system-wide workqueues.

