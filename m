Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FB4B7A2B
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 23:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbiBOWFr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 17:05:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiBOWFq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 17:05:46 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34BD1EEE4;
        Tue, 15 Feb 2022 14:05:35 -0800 (PST)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 21FM58u9053588;
        Wed, 16 Feb 2022 07:05:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Wed, 16 Feb 2022 07:05:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 21FM58hL053577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 16 Feb 2022 07:05:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <06b2f59c-3c96-9443-7a23-f1c957a41d9b@I-love.SAKURA.ne.jp>
Date:   Wed, 16 Feb 2022 07:05:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [syzbot] possible deadlock in worker_thread
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>,
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
 <fb854eea-a7e7-b526-a989-95784c1c593c@I-love.SAKURA.ne.jp>
 <1b70929f-1f73-c549-64c1-94cea2c1a36c@acm.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1b70929f-1f73-c549-64c1-94cea2c1a36c@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/02/16 2:05, Bart Van Assche wrote:
> On 2/15/22 04:48, Tetsuo Handa wrote:
>> I do not want to do like
>>
>> -    system_wq = alloc_workqueue("events", 0, 0);
>> +    system_wq = alloc_workqueue("events", __WQ_SYSTEM_WIDE, 0);
>>
>> because the intent of this change is to ask developers to create their own WQs.
> 
> I want more developers to use the system-wide workqueues since that reduces memory usage. That matters for embedded devices running Linux.

Reserving a kernel thread for WQ_MEM_RECLAIM WQ might consume some memory,
but I don't think that creating a !WQ_MEM_RECLAIM WQ consumes much memory.
