Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD046276F3
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 09:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiKNIBJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 03:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiKNIBG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 03:01:06 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86B0256
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:00:59 -0800 (PST)
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from
 rtrs_srv_ib_ctx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668412858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxhHIudOl4+PoXUN6+2pBMa7qEzswlaOFSOAp/vb6vQ=;
        b=Ylpjc1/OtMqJhyU+eSAXKfWaf0oNLvGRmSmB2zMYX0/pe+EF6fbjTJyIXBy9RxgRjM3ngf
        2rT9mtOrIU4pGNYWT6eOShaVnfq4k7yApo6bXo6iT8n//9OCF1ws0aLH7NnwATfgqNlO5q
        ie7iLb48iobAUV54vOJSXnr4MaIleCE=
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-2-guoqing.jiang@linux.dev>
 <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <82038928-59fb-e857-1855-1831252f4a88@linux.dev>
Date:   Mon, 14 Nov 2022 16:00:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
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

Hi Jinpu,

On 11/14/22 3:39 PM, Jinpu Wang wrote:
> Hi Guoqing,
>
> Thx for the patch, see comments below.
> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>> The ib_dev_count is supposed to track the number of added ib devices
>> which is only used in rtrs_srv_{add,remove}_one.
>>
>> However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
>> -> rtrs_srv_open -> ib_register_client -> client->add which should
>> happen only once.
> client->add is call per ib_device, eg:
> jwang@ps404a-1.stg:~$ ls -l /sys/class/infiniband/mlx5_*
> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_0 ->
> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/infiniband/mlx5_0
> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_1 ->
> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.1/infiniband/mlx5_1
> rtrs will be call twice for  mlx5_0 and mlx5_1 devices

Ah, yes.

But still we can only load/unload module once, I guess it was used to avoid
racy condition (concurrent loading/unloading module?), could you elaborate
why it is needed?

Thanks,
Guoqing
