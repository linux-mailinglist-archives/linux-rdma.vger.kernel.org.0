Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5447206B3
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjFBP6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjFBP6u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 11:58:50 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9F1AD;
        Fri,  2 Jun 2023 08:58:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q57Aq-0000I3-Sx; Fri, 02 Jun 2023 17:58:44 +0200
Message-ID: <2becd7c2-7aa1-41d9-117f-b118c4a6cb30@leemhuis.info>
Date:   Fri, 2 Jun 2023 17:58:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: system hang on start-up (mlx5?)
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
 <bf2594bb-94e0-5c89-88ad-935dee2ac95c@leemhuis.info>
 <5b235e0f-cd4c-a453-d648-5a4e9080ac19@leemhuis.info>
 <AAFDF38A-E59A-4D6A-8EC2-113861C8B5DB@oracle.com>
 <bb2df75d-05be-3f7b-693a-84be195dc2f1@leemhuis.info>
 <ZHn8xALvQ/wKER1t@ziepe.ca>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZHn8xALvQ/wKER1t@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685721529;1eb502b5;
X-HE-SMSGID: 1q57Aq-0000I3-Sx
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02.06.23 16:29, Jason Gunthorpe wrote:
> On Fri, Jun 02, 2023 at 03:55:43PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 02.06.23 15:38, Chuck Lever III wrote:
>>>
>>>> On Jun 2, 2023, at 7:05 AM, Linux regression tracking #update (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>
>>>> [TLDR: This mail in primarily relevant for Linux regression tracking. A
>>>> change or fix related to the regression discussed in this thread was
>>>> posted or applied, but it did not use a Link: tag to point to the
>>>> report, as Linus and the documentation call for.
>>>
>>> Linus recently stated he did not like Link: tags pointing to an
>>> email thread on lore.
>>
>> Afaik he strongly dislikes them when a Link: tag just points to the
>> submission of the patch being applied;
> 
> He has said that, but AFAICT enough maintainers disagree that we are
> still adding Link tags to the submission as a glorified Change-Id
> [...]

Which is totally fine for me, I only want the links to the reports, too.
And I for now don't even care if the latter are added using Closes: or
Link:.

> When done well these do provide information because the cover letter
> should back link to all prior version of the series and you can then
> capture the entire discussion, although manually.

I kinda agree. OTOH I like even more when subsystem put the cover letter
text in a merge commit, *if* the cover letter contains important details.

>> at the same time he *really wants* those links if they tell the
>> backstory how a fix came into being, which definitely includes the
>> report about the issue being fixed (side note: without those links
>> regression tracking becomes so hard that it's basically no
>> feasible).
> 
> Yes, but this started to get a bit redundant as we now have
> 
>  Reported-by:  xx@syzkaller
> 
> Which does identify the original bug and all its places, and now
> people are adding links to the syzkaller email too because checkpatch
> is complaining.

For syzkaller it's redundant, yes, but for some other CIs and manual
reports it's useful and nothing new afaics (a lot of people just were
not aware of it). And FWIW, it's a warning, not a error to indicate:
there are situation when this can be ignored.

>>> Also, checkpatch.pl is now complaining about Closes: tags instead
>>> of Link: tags. A bug was never opened for this issue.
>>
>> That was a change by somebody else, but FWIW, just use Closes: (instead
>> of Link:) with a link to the report on lore, that tag is not reserved
>> for bugs.
>>
>> /me will go and update his boilerplate text used above
> 
> And now you say they should be closes not link?
> 
> Oy it makes my head hurt all these rules.

In case you want the backstory (which I doubt :-D ), see here:

https://lore.kernel.org/lkml/20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net/

Ciao, Thorsten
