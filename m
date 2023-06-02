Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8917203CE
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjFBN4X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBNzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 09:55:49 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE9BD3;
        Fri,  2 Jun 2023 06:55:47 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q55Fn-00007i-GN; Fri, 02 Jun 2023 15:55:43 +0200
Message-ID: <bb2df75d-05be-3f7b-693a-84be195dc2f1@leemhuis.info>
Date:   Fri, 2 Jun 2023 15:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: system hang on start-up (mlx5?)
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "elic@nvidia.com" <elic@nvidia.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <bf2594bb-94e0-5c89-88ad-935dee2ac95c@leemhuis.info>
 <5b235e0f-cd4c-a453-d648-5a4e9080ac19@leemhuis.info>
 <AAFDF38A-E59A-4D6A-8EC2-113861C8B5DB@oracle.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <AAFDF38A-E59A-4D6A-8EC2-113861C8B5DB@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685714147;d9538cfe;
X-HE-SMSGID: 1q55Fn-00007i-GN
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02.06.23 15:38, Chuck Lever III wrote:
> 
>> On Jun 2, 2023, at 7:05 AM, Linux regression tracking #update (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> [TLDR: This mail in primarily relevant for Linux regression tracking. A
>> change or fix related to the regression discussed in this thread was
>> posted or applied, but it did not use a Link: tag to point to the
>> report, as Linus and the documentation call for.
> 
> Linus recently stated he did not like Link: tags pointing to an
> email thread on lore.

Afaik he strongly dislikes them when a Link: tag just points to the
submission of the patch being applied; at the same time he *really
wants* those links if they tell the backstory how a fix came into being,
which definitely includes the report about the issue being fixed (side
note: without those links regression tracking becomes so hard that it's
basically no feasible).

If my knowledge is not up to date, please if you have a minute do me a
favor and point me to Linus statement your refer to.

> Also, checkpatch.pl is now complaining about Closes: tags instead
> of Link: tags. A bug was never opened for this issue.

That was a change by somebody else, but FWIW, just use Closes: (instead
of Link:) with a link to the report on lore, that tag is not reserved
for bugs.

/me will go and update his boilerplate text used above

> I did check the regzbot docs on how to mark this issue closed,
> but didn't find a ready answer. Thank you for following up.

yw, but no worries, that's what I'm here for. :-D

Ciao, Thorsten

>> Things happen, no
>> worries -- but now the regression tracking bot needs to be told manually
>> about the fix. See link in footer if these mails annoy you.]
>>
>> On 08.05.23 14:29, Linux regression tracking #adding (Thorsten Leemhuis)
>> wrote:
>>> On 03.05.23 03:03, Chuck Lever III wrote:
>>>>
>>>> I have a Supermicro X10SRA-F/X10SRA-F with a ConnectX®-5 EN network
>>>> interface card, 100GbE single-port QSFP28, PCIe3.0 x16, tall bracket;
>>>> MCX515A-CCAT
>>>>
>>>> When booting a v6.3+ kernel, the boot process stops cold after a
>>>> few seconds. The last message on the console is the MLX5 driver
>>>> note about "PCIe slot advertised sufficient power (27W)".
>>>>
>>>> bisect reports that bbac70c74183 ("net/mlx5: Use newer affinity
>>>> descriptor") is the first bad commit.
>>>>
>>>> I've trolled lore a couple of times and haven't found any discussion
>>>> of this issue.
>>>
>>> #regzbot ^introduced bbac70c74183
>>> #regzbot title system hang on start-up (irq or mlx5 problem?)
>>> #regzbot ignore-activity
>>
>> #regzbot fix: 368591995d010e6
>> #regzbot ignore-activity
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> That page also explains what to do if mails like this annoy you.
> 
> --
> Chuck Lever
> 
> 
