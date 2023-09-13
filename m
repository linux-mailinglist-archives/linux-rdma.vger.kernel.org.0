Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8079F593
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Sep 2023 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjIMXi0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Sep 2023 19:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXiZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 19:38:25 -0400
Received: from out-219.mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B0BCE4
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 16:38:21 -0700 (PDT)
Message-ID: <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694648299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pb7CcDEnpMYykAOYQZ4LzxwBgmHpJP2O/WJ0BPqmLHE=;
        b=Q5pnPwiR+pia6RjSfDPCV+VB6dHau2sp1GVjWvKZgUJhIeXzBB9rOvuvXGHyG5ZF0hhj2K
        8l5vOuCwUqIbqZZih9gu7AWJvN71ZDcUr9nV7iFjNekY9+2CB5HuY2iKac3s2Riz5oSBqb
        r+2fA+Ji6JXIa/BaOeHQjD7tJR4t1M0=
Date:   Thu, 14 Sep 2023 07:38:13 +0800
MIME-Version: 1.0
Subject: Re: [bug report] blktests srp/002 hang
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/9/14 1:36, Bob Pearson 写道:
> On 8/25/23 08:52, Bart Van Assche wrote:
>> On 8/24/23 18:11, Shinichiro Kawasaki wrote:
>>> If it takes time to resolve the issues, it sounds a good idea to make siw driver
>>> default, since it will make the hangs less painful for blktests users. Another
>>> idea to reduce the pain is to improve srp/002 and srp/011 to detect the hangs
>>> and report them as failures.
>>
>> At this moment we don't know whether the hangs can be converted into failures.
>> Answering this question is only possible after we have found the root cause of
>> the hang. If the hang would be caused by commands getting stuck in multipathd
>> then it can be solved by changing the path configuration (see also the dmsetup
>> message commands in blktests). If the hang is caused by a kernel bug then it's
>> very well possible that there is no way to recover other than by rebooting the
>> system on which the tests are run.
>>
>> Thanks,
>>
>> Bart.
> 
> Since 6.6.0-rc1 came out I decided to give blktests srp another try with the current
> rdma for-next branch on my Ubuntu (debian) system. For the first time in a very long
> time all the srp test cases run correctly multiple times. I ran each one 3X.
> 
> I had tried to build multipath-tools from source but ran into problems so I reinstalled
> the current Ubuntu packages. I have no idea what was the root cause that finally went
> away but I don't think it was in rxe as there aren't any recent patches related to the
> blktests failures. I did notice that the dmesg traces picked up a couple of lines after
> the place where it used to hang. Something about setting an ALUA timeout to 60 seconds.
> 
> Thanks to all who worked on this.

Hi, Bob

About this problem, IIRC, this problem easily occurred on Debian and 
Fedora 38 and with the commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue 
support for rxe tasks").

And on Debian, with the latest multipathd, this problem seems to disappear.

On Fedora 38, even with the latest multipathd, this problem still can be 
observed.

On Ubuntu, it is difficult to reproduce this problem.

Perhaps this is why you can not reproduce this problem on Ubuntu.

It seems that this problem is related with linux distribution and the 
version of multipathd.

If I am missing something, please feel free to let me know.

Zhu Yanjun

> 
> Bob Pearson

