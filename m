Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD2670DF1A
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjEWOUz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 May 2023 10:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbjEWOUy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 May 2023 10:20:54 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66999E9;
        Tue, 23 May 2023 07:20:53 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q1Ssb-0007OG-Pc; Tue, 23 May 2023 16:20:49 +0200
Message-ID: <71346a9d-d892-c473-ddff-53475191d4b0@leemhuis.info>
Date:   Tue, 23 May 2023 16:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: system hang on start-up (mlx5?)
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Leon Romanovsky <leon@kernel.org>, Eli Cohen <elic@nvidia.com>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <DM8PR12MB54003FBFCABCCB37EE807B45AB6C9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <91176545-61D2-44BF-B736-513B78728DC7@oracle.com>
 <20230504072953.GP525452@unreal>
 <46EB453C-3CEB-43E8-BEE5-CD788162A3C9@oracle.com>
 <DBFBD6F9-FAC3-4C04-A9C5-4E126BC96090@oracle.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <DBFBD6F9-FAC3-4C04-A9C5-4E126BC96090@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1684851653;7436f8c1;
X-HE-SMSGID: 1q1Ssb-0007OG-Pc
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 16.05.23 21:23, Chuck Lever III wrote:
>> On May 4, 2023, at 3:02 PM, Chuck Lever III <chuck.lever@oracle.com> wrote:
>>> On May 4, 2023, at 3:29 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>> On Wed, May 03, 2023 at 02:02:33PM +0000, Chuck Lever III wrote:
>>>>> On May 3, 2023, at 2:34 AM, Eli Cohen <elic@nvidia.com> wrote:
>>>>> Just verifying, could you make sure your server and card firmware are up to date?
>>>> Device firmware updated to 16.35.2000; no change.
>>>> System firmware is dated September 2016. I'll see if I can get
>>>> something more recent installed.
>>> We are trying to reproduce this issue internally.
>> More information. I captured the serial console during boot.
>> Here are the last messages:
>[…]
> Following up.
> 
> Jason shamed me into replacing a working CX-3Pro in one of
> my lab systems with a CX-5 VPI, and the same problem occurs.
> Removing the CX-5 from the system alleviates the problem.
> 
> Supermicro SYS-6028R-T/X10DRi, v6.4-rc2

I wondered what happened to this, as this looks stalled. Or was progress
to fix this regression made I just missed it?

I noticed the patch "net/mlx5: Fix irq affinity management" (
https://lore.kernel.org/all/20230523054242.21596-15-saeed@kernel.org/
) refers to the culprit of this regression. Is that supposed to fix this
issue and just lacks proper tags to indicate that?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
