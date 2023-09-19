Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46167A5BF3
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjISIHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjISIHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 04:07:19 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6D125
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 01:07:12 -0700 (PDT)
Message-ID: <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695110830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZXHK3GWZkIlEJU13b+xE11wlY/8gP4LPqxTUY8gqUTo=;
        b=fO0/ZDDunDKni//vPs6Yhr9HTxgzjB2cXXteeWVbt5r1C7hiPlh3J+cH47tq1dLeTmYw1v
        y/jH5vaUdWda/VDEHg2z0NEUUjWKHiUtToOXUUeBk1AB2Zqmfm1B58yQWUfwpKTi3Zjri5
        IRZMK9DRIEnkrBNuu73pgAX/Ckdur/o=
Date:   Tue, 19 Sep 2023 16:07:03 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/9/19 12:14, Shinichiro Kawasaki 写道:
> On Sep 16, 2023 / 13:59, Zhu Yanjun wrote:
> [...]
>> On Debian, with the latest multipathd or revert the commit 9b4b7c1f9f54
>> ("RDMA/rxe: Add workqueue support for rxe tasks"), this problem will
>> disappear.
> 
> Zhu, thank you for the actions.
> 
>> On Fedora 38, if the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support
>> for rxe tasks") is reverted, will this problem still appear?
>> I do not have such test environment. The commit is in the attachment,
>> can anyone have a test? Please let us know the test result. Thanks.
> 
> I tried the latest kernel tag v6.6-rc2 with my Fedora 38 test systems. With the
> v6.6-rc2 kernel, I still see the hang. I repeated the blktests test case srp/002
> 30 time or so, then the hang was recreated. Then I reverted the commit
> 9b4b7c1f9f54 from v6.6-rc2, and the hang disappeared. I repeated the blktests
> test case 100 times, and did not see the hang.
> 
> I confirmed these results under two multipathd conditions: 1) with Fedora latest
> device-mapper-multipath package v0.9.4, and 2) the latest multipath-tools v0.9.6
> that I built from source code.
> 
> So, when the commit gets reverted, the hang disappears as I reported for
> v6.5-rcX kernels.
Thanks, Shinichiro Kawasaki. Your helps are appreciated.

This problem is related with the followings:

1). Linux distributions: Ubuntu, Debian and Fedora;

2). multipathd;

3). the commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe 
tasks")

On Ubuntu, with or without the commit, this problem does not occur.

On Debian, without this commit, this problem does not occur. With this 
commit, this problem will occur.

On Fedora, without this commit, this problem does not occur. With this 
commit, this problem will occur.

The commits 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe 
tasks") is from Bob Pearson.

Hi, Bob, do you have any comments about this problem? It seems that this 
commit is not compatible with blktests.

Hi, Jason and Leon, please comment on this problem.

Thanks a lot.

Zhu Yanjun
