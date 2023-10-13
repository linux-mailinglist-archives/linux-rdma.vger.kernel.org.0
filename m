Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E02A7C8625
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 14:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjJMMwB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMMwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 08:52:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDDF91;
        Fri, 13 Oct 2023 05:51:56 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qrHdz-0005GC-6y; Fri, 13 Oct 2023 14:51:55 +0200
Message-ID: <f831fbbb-c750-4fba-9b37-d6e6ded9b451@leemhuis.info>
Date:   Fri, 13 Oct 2023 14:51:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info>
In-Reply-To: <e8b76fae-780a-470e-8ec4-c6b650793d10@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697201516;78bf7307;
X-HE-SMSGID: 1qrHdz-0005GC-6y
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 22.09.23 13:06, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 21.08.23 08:46, Shinichiro Kawasaki wrote:
>> I observed a process hang at the blktests test case srp/002 occasionally, using
>> kernel v6.5-rcX. Kernel reported stall of many kworkers [1]. PID 2757 hanged at
>> inode_sleep_on_writeback(). Other kworkers hanged at __inode_wait_for_writeback.
>>
>> The hang is recreated in stable manner by repeating the test case srp/002 (from
>> 15 times to 30 times).
>>
>> I bisected and found the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
>> for rxe tasks") looks like the trigger commit. When I revert it from the kernel
>> v6.5-rc7, the hang symptom disappears. I'm not sure how the commit relates to
>> the hang. Comments will be welcomed.
>> […]
> 
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 9b4b7c1f9f54
> #regzbot title RDMA/rxe: occasionally pocess hang at the blktests test
> case srp/002
> #regzbot ignore-activity

#regzbot monitor:
https://lore.kernel.org/all/20230922163231.2237811-1-yanjun.zhu@intel.com/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
