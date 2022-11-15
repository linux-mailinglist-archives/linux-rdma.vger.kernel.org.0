Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CAC6295B1
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238258AbiKOKXG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 05:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiKOKXE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 05:23:04 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74321829
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 02:22:57 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668507775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsJzs1aBYxDuDWsukjQiaZUcSsloxENZ9RNhRaMcFUE=;
        b=hvZdqMCgyuMp7x66hiZIDaNLRLpe7dPq0mSVbkZhpK+wfBa78+bjq5F1CV63wdGS076WNk
        YUKEl+h/HEhi4s+1PL8vTm7dQmNDXotk06trXaO0Z4pSIay4/qo4Ru4Vmz3nD3od3D0VRD
        i/bpHcVp3Fd7NXeuZzEGH9AA7qmTEgc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from
 rtrs_srv_ib_ctx
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-2-guoqing.jiang@linux.dev>
 <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
 <82038928-59fb-e857-1855-1831252f4a88@linux.dev>
 <CAMGffEn4eUrSX-v3Dr-iOD_LOFvqneGDYCuvAgqpTYBZTDFRYA@mail.gmail.com>
 <2b99778c-9819-adc4-59fe-c8023c932247@linux.dev>
 <CAJpMwyiQcMWqaLNuGvDJ2DJhrAR8R3Ac97pJ4rc=xiKVppN5tA@mail.gmail.com>
Message-ID: <8a55e3ca-ad3c-baa2-75dc-6ce975b3598b@linux.dev>
Date:   Tue, 15 Nov 2022 18:22:54 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwyiQcMWqaLNuGvDJ2DJhrAR8R3Ac97pJ4rc=xiKVppN5tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



Hi Haris,

On 11/14/22 9:36 PM, Haris Iqbal wrote:
>
>>> The change was introduced due to  a bug report, you can follow the
>>> discussion here for the history and reason:
>>> https://lore.kernel.org/linux-rdma/20200617103732.10356-1-haris.iqbal@cloud.ionos.com/
>> Thanks for the link.
>>
>> I probably missed something but I don't know how rnbd_server module can be
>> initialized before cma module since we have the dependency chain as
>> follows.
> Hi Guoqing,
>
> One of the ways this was happening was, when one builds the RNBD/RTRS
> module into the kernel bzImage and then boots up the kernel. Depending
> on the module init sequence, if the RNBD/RTRS modules are picked
> before the RDMA one, then this issue would hit.

This is what I missed since I usually build RNBD with M.

> With the changes, RNBD/RTRS just register itself to ib. If any devices
> are present at that moment, for example when the module is modprob'ed
> later into the kernel, then .add gets called through
> ib_register_client. If no devices are present, for example in case if
> the module is built into the bzImage, and is inserted before RDMA
> module, then ib_register_client simply registers RTRS, and returns
> without calling .add
> Now, when RDMA gets initialized, and it detects devices, then .add is
> called for each device, which will land into rtrs_srv_add_one

Thanks for the details! It explains well why ib_register_client is added,
and rtrs_srv_rdma_init is guaranteed to be called once too. Will drop
this one.

Thanks,
Guoqings


