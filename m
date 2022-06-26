Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4D755AE86
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jun 2022 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbiFZDaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jun 2022 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiFZDaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jun 2022 23:30:01 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D105111804;
        Sat, 25 Jun 2022 20:29:59 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AUErOU6OzLIe7VGDvrR0xlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQTs0TNx3jxSmmEXW2mCbPuKMWCjftElPYWzoBwPvcWGm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/jzSbn9FzydxLnZKtS?=
 =?us-ascii?q?wY1JbCKk+MYO/VdO3gkY/QYo+KbcBBTtuTWlSUqaUDEyPVjCk4nOpAw/udxHHE?=
 =?us-ascii?q?I/PgZIjkHZ1aIgOfe6KOyTOtxgIIxLNTDOIIZp2EmwTzHZd4mSJnARKOM78JX0?=
 =?us-ascii?q?zoYgdpHFvLTIcEebFJHaBXGfg0KOVoNDp86tPmni2O5cDBCrl+R460t7AD7yA1?=
 =?us-ascii?q?3zaioKtbQc/SUSshP2EWVvGTL+yL+GB5yHN6QxhKX83+0i6nElEvGtCg6fFGj3?=
 =?us-ascii?q?qcyxgTNmSpIU1tLPWZXaMKR0iaWM++z4WRNksb2kZUPyQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AEcZ7e6lIXPVwcbq8CPpBP8x2a4zpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="126163549"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Jun 2022 11:29:58 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id B71594D17168;
        Sun, 26 Jun 2022 11:29:53 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 26 Jun 2022 11:29:54 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 26 Jun 2022 11:29:53 +0800
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Yang, Xiao" <yangx.jy@fujitsu.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
 <3ee9e8d1-01dc-0936-efde-b07482a5e785@linux.dev>
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <83cfdf23-7a2d-0776-85ee-7314187e9980@fujitsu.com>
Date:   Sun, 26 Jun 2022 11:29:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <3ee9e8d1-01dc-0936-efde-b07482a5e785@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-yoursite-MailScanner-ID: B71594D17168.AC98B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


on 6/25/2022 8:59 PM, Yanjun Zhu wrote:
>
> 在 2022/6/7 16:32, lizhijian@fujitsu.com 写道:
>> Hi Json & Yanjun
>>
>>
>> I know there are still a few regressions on RXE, but i do wish you 
>> could take some time to review these *simple and bugfix* patches
>> They are not related to the regressions.
>
> Now there are some problems from Redhat and other Linux Vendors.
>
> We had better focus on these problems.

+ Xiao
I do believe regression is high priority,  and I'm very willing to contribute our efforts to improve the stability of RXE :)
Yang,Xiao and me tried to reproduce the issues in maillist and we also tried to review the their corresponding patches.
However actually we didn't find a unified way something like bugzilla to maintain the issues and their status, and most of
them are not reproduced by our local environment. So it's a bit hard for us to review/verify the patches especially for the
large/complicate patch if we don't have the use cases.

BTW, IMO we shouldn't stop reviewing other fixes expect recent regressions.

Zhijian

>
> Zhu Yanjun
>
>>
>>
>> Thanks
>> Zhijian
>>
>>
>> On 16/05/2022 09:53, Li Zhijian wrote:
>>> Since RXE always posts RDMA_WRITE successfully, it's observed that
>>> no more completion occurs after a few incorrect posts. Actually, it
>>> will block the polling. we can easily reproduce it by the below 
>>> pattern.
>>>
>>> a. post correct RDMA_WRITE
>>> b. poll completion event
>>> while true {
>>>     c. post incorrect RDMA_WRITE(wrong rkey for example)
>>>     d. poll completion event <<<< block after 2 incorrect RDMA_WRITE 
>>> posts
>>> }
>>>
>>>
>>> Li Zhijian (2):
>>>     RDMA/rxe: Update wqe_index for each wqe error completion
>>>     RDMA/rxe: Generate error completion for error requester QP state
>>>
>>>    drivers/infiniband/sw/rxe/rxe_req.c | 12 +++++++++++-
>>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>>


