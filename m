Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003BA51F530
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiEIHWP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 03:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiEIHAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 03:00:46 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51991498C3
        for <linux-rdma@vger.kernel.org>; Sun,  8 May 2022 23:56:52 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nnxK6-0003RF-Ta; Mon, 09 May 2022 08:56:50 +0200
Message-ID: <09333bbb-25b0-031d-a208-a81de34ad6a6@leemhuis.info>
Date:   Mon, 9 May 2022 08:56:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1652079413;3a235561;
X-HE-SMSGID: 1nnxK6-0003RF-Ta
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced v5.17..v5.18-rc6
#regzbot title rdma: hangs in blktests since 5.18-rc1+
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replied to), as the kernel's
documentation call for; above page explains why this is important for
tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

On 06.05.22 20:11, Bob Pearson wrote:
> Bart,
> 
> Before the most recent kernel update I had blktests running OK on rdma_rxe. Since we went on to 5.18.0-rc1+
> I have been experiencing hangs. All of this is with the 'revert scsi-debug' patch which addressed the
> 3 min timeout related to modprobe -r scsi-debug.
> 
> You suggested checking with siw and I finally got around to this and the behavior is exactly the same.
> 
> Specifically here is a run and dmesgs from that run:
> 
> root@u-22:/home/bob/src/blktests# use_siw=1 ./check srp
> 
> srp/001 (Create and remove LUNs)                             [passed]
> 
>     runtime  3.388s  ...  3.501s
> 
> srp/002 (File I/O on top of multipath concurrently with logout and login (mq))
> 
>     runtime  54.689s  ...
>   <HANGS HERE>
> 
> I had to reboot to recover.
> 
> The dmesg output is attached in a long file called out.
> The output looks normal until line 1875 where it hangs at an "Already connected ..." message.
> This is the same as the other hangs I have been seeing.
> This is followed by a splat warning that a cpu has hung for 120 seconds.
> 
> Since this is behaving the same for rxe and siw I am going to stop chasing this bug since
> it is most likely outside of the the rxe driver.
> 
> Bob
> 

