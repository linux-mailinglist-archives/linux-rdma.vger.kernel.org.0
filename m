Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93CA6FB004
	for <lists+linux-rdma@lfdr.de>; Mon,  8 May 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjEHMaK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 May 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjEHMaF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 May 2023 08:30:05 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545D3A5CC;
        Mon,  8 May 2023 05:29:54 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pvzzy-0005Mf-LQ; Mon, 08 May 2023 14:29:50 +0200
Message-ID: <bf2594bb-94e0-5c89-88ad-935dee2ac95c@leemhuis.info>
Date:   Mon, 8 May 2023 14:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: system hang on start-up (mlx5?)
Content-Language: en-US, de-DE
To:     Chuck Lever III <chuck.lever@oracle.com>,
        "elic@nvidia.com" <elic@nvidia.com>
Cc:     "saeedm@nvidia.com" <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <A1E5B427-897B-409E-B8E3-E417678E81F6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683548994;8b2ac2fc;
X-HE-SMSGID: 1pvzzy-0005Mf-LQ
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 03.05.23 03:03, Chuck Lever III wrote:
> Hi-
> 
> I have a Supermicro X10SRA-F/X10SRA-F with a ConnectX®-5 EN network
> interface card, 100GbE single-port QSFP28, PCIe3.0 x16, tall bracket;
> MCX515A-CCAT
> 
> When booting a v6.3+ kernel, the boot process stops cold after a
> few seconds. The last message on the console is the MLX5 driver
> note about "PCIe slot advertised sufficient power (27W)".
> 
> bisect reports that bbac70c74183 ("net/mlx5: Use newer affinity
> descriptor") is the first bad commit.
> 
> I've trolled lore a couple of times and haven't found any discussion
> of this issue.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced bbac70c74183
#regzbot title system hang on start-up (irq or mlx5 problem?)
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
