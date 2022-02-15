Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7B4B6C9E
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 13:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiBOMt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 07:49:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiBOMt2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 07:49:28 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B228D28E27;
        Tue, 15 Feb 2022 04:49:18 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21FCn2cr076466;
        Tue, 15 Feb 2022 21:49:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Tue, 15 Feb 2022 21:49:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21FCn233076461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Feb 2022 21:49:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fb854eea-a7e7-b526-a989-95784c1c593c@I-love.SAKURA.ne.jp>
Date:   Tue, 15 Feb 2022 21:48:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        syzbot <syzbot+831661966588c802aae9@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
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
 <a07e464c-69c6-6165-e88c-5a2eded79138@I-love.SAKURA.ne.jp>
 <76616D2F-14F2-4D83-9DB4-576FB2ACB72C@oracle.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <76616D2F-14F2-4D83-9DB4-576FB2ACB72C@oracle.com>
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

On 2022/02/15 19:43, Haakon Bugge wrote:
>> @@ -6070,6 +6087,13 @@ void __init workqueue_init_early(void)
>> 	       !system_unbound_wq || !system_freezable_wq ||
>> 	       !system_power_efficient_wq ||
>> 	       !system_freezable_power_efficient_wq);
>> +	system_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_highpri_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_long_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_unbound_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_freezable_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_power_efficient_wq->flags |= __WQ_SYSTEM_WIDE;
>> +	system_freezable_power_efficient_wq->flags |= __WQ_SYSTEM_WIDE;
> 
> Better to OR this in, in the alloc_workqueue() call? Perceive the notion of an opaque object?
> 

I do not want to do like

-	system_wq = alloc_workqueue("events", 0, 0);
+	system_wq = alloc_workqueue("events", __WQ_SYSTEM_WIDE, 0);

because the intent of this change is to ask developers to create their own WQs.
If I pass __WQ_SYSTEM_WIDE to alloc_workqueue(), developers might by error create like

	srp_tl_err_wq = alloc_workqueue("srp_tl_err_wq", __WQ_SYSTEM_WIDE, 0);

because of

	system_wq = alloc_workqueue("events", __WQ_SYSTEM_WIDE, 0);

line. The __WQ_SYSTEM_WIDE is absolutely meant to be applied to only 'system_wq',
'system_highpri_wq', 'system_long_wq', 'system_unbound_wq', 'system_freezable_wq',
'system_power_efficient_wq' and 'system_freezable_power_efficient_wq' WQs, in order
to avoid calling flush_workqueue() on these system-wide WQs.

I wish I could define __WQ_SYSTEM_WIDE inside kernel/workqueue_internal.h, but
it seems that kernel/workqueue_internal.h does not define internal flags.
