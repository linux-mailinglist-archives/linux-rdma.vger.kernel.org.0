Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA994B336A
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Feb 2022 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiBLGOa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 12 Feb 2022 01:14:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiBLGOa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 12 Feb 2022 01:14:30 -0500
X-Greylist: delayed 2528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 22:14:27 PST
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB41E289BA
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 22:14:27 -0800 (PST)
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21C5W0XN054639;
        Sat, 12 Feb 2022 14:32:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sat, 12 Feb 2022 14:32:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21C5VxJ8054636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 12 Feb 2022 14:31:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ccd04d8a-154b-543e-e1c3-84bc655508d1@I-love.SAKURA.ne.jp>
Date:   Sat, 12 Feb 2022 14:31:53 +0900
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <8ea57ddf-a09c-43f2-4285-4dfb908ad967@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/02/12 3:59, Bart Van Assche wrote:
> On 2/10/22 11:27, syzbot wrote:
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.17.0-rc2-syzkaller-00398-gd8ad2ce873ab #0 Not tainted
>> ------------------------------------------------------
> 
> Since the SRP initiator driver is involved, I will take a look.
> However, I'm not sure yet when I will have the time to post a fix.
> 
> Thanks,
> 
> Bart.
> 

This problem was already handled by commit bf23747ee0532090 ("loop:
revert "make autoclear operation asynchronous"").

But this report might be suggesting us that we should consider
deprecating (and eventually getting rid of) system-wide workqueues
(declared in include/linux/workqueue.h), for since flush_workqueue()
synchronously waits for completion, sharing system-wide workqueues
among multiple modules can generate unexpected locking dependency
chain (like this report).

If some module needs flush_workqueue() or flush_*_work(), shouldn't
such module create and use their own workqueues?

Tejun, what do you think?

