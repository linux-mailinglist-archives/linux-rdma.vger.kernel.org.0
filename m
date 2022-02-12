Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF584B36C1
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Feb 2022 18:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiBLROb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Feb 2022 12:14:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiBLRO3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Feb 2022 12:14:29 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD7B240A4;
        Sat, 12 Feb 2022 09:14:25 -0800 (PST)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21CHEDgr055636;
        Sun, 13 Feb 2022 02:14:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sun, 13 Feb 2022 02:14:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21CHEDvD055633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 13 Feb 2022 02:14:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
Date:   Sun, 13 Feb 2022 02:14:09 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
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

On 2022/02/13 1:37, Bart Van Assche wrote:
> On 2/11/22 21:31, Tetsuo Handa wrote:
>> But this report might be suggesting us that we should consider
>> deprecating (and eventually getting rid of) system-wide workqueues
>> (declared in include/linux/workqueue.h), for since flush_workqueue()
>> synchronously waits for completion, sharing system-wide workqueues
>> among multiple modules can generate unexpected locking dependency
>> chain (like this report).
> 
> I do not agree with deprecating system-wide workqueues. I think that
> all flush_workqueue(system_long_wq) calls should be reviewed since
> these are deadlock-prone.
> 
> Thanks,
> 
> Bart.

The loop module is not using flush_workqueue(system_long_wq) call; it only
scheduled a work via system_long_wq which will call flush_workqueue() (of
a local workqueue) from drain_workqueue() from destroy_workqueue() from
work function.

How can reviewing all flush_workqueue(system_long_wq) calls help?

