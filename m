Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C026277FF
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 09:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiKNIpm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 03:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbiKNIpj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 03:45:39 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D71BE8E
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:45:37 -0800 (PST)
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from
 rtrs_srv_ib_ctx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668415535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DndS9ebqtLVaFbyLTvkGUjxBH2nXudJgKeJKWezsr9M=;
        b=r/BgnjbWM9IzJeyUcOv0l5QTMCIMFXExsKwyFuAcym6XnezUDXlGwV9ikpPb+TBE0AzRCa
        qBAuBadDmwStsmvQYPxtFDH9GO1f030rkahw4NjG6PR22CMn7bBW0Yv8Zg3bVFa4/I+qZb
        XYySC4AToEAyGMDr5BHqFxjzgcXvteU=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-2-guoqing.jiang@linux.dev>
 <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
 <82038928-59fb-e857-1855-1831252f4a88@linux.dev>
 <CAMGffEn4eUrSX-v3Dr-iOD_LOFvqneGDYCuvAgqpTYBZTDFRYA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <2b99778c-9819-adc4-59fe-c8023c932247@linux.dev>
Date:   Mon, 14 Nov 2022 16:45:18 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEn4eUrSX-v3Dr-iOD_LOFvqneGDYCuvAgqpTYBZTDFRYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/14/22 4:24 PM, Jinpu Wang wrote:
> On Mon, Nov 14, 2022 at 9:00 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> Hi Jinpu,
>>
>> On 11/14/22 3:39 PM, Jinpu Wang wrote:
>>> Hi Guoqing,
>>>
>>> Thx for the patch, see comments below.
>>> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>>> The ib_dev_count is supposed to track the number of added ib devices
>>>> which is only used in rtrs_srv_{add,remove}_one.
>>>>
>>>> However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
>>>> -> rtrs_srv_open -> ib_register_client -> client->add which should
>>>> happen only once.
>>> client->add is call per ib_device, eg:
>>> jwang@ps404a-1.stg:~$ ls -l /sys/class/infiniband/mlx5_*
>>> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_0 ->
>>> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/infiniband/mlx5_0
>>> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_1 ->
>>> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.1/infiniband/mlx5_1
>>> rtrs will be call twice for  mlx5_0 and mlx5_1 devices
>> Ah, yes.
>>
>> But still we can only load/unload module once, I guess it was used to avoid
>> racy condition (concurrent loading/unloading module?), could you elaborate
>> why it is needed?
> The change was introduced due to  a bug report, you can follow the
> discussion here for the history and reason:
> https://lore.kernel.org/linux-rdma/20200617103732.10356-1-haris.iqbal@cloud.ionos.com/

Thanks for the link.

I probably missed something but I don't know how rnbd_server module can be
initialized before cma module since we have the dependency chain as 
follows.

INFINIBAND_RTRS_SERVER depends on INFINIBAND_ADDR_TRANS
BLK_DEV_RNBD_SERVER depends on INFINIBAND_RTRS_SERVER

But commit 558d52b2976b ("RDMA/rtrs-srv: Incorporate ib_register_client into
rtrs server init") did mention this.

"and if the rnbd_server module is initialized before RDMA cma module, a 
null ptr
dereference occurs during the RDMA bind operation."

Thanks,
Guoqing
