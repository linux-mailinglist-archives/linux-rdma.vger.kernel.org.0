Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401AE51442E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Apr 2022 10:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355411AbiD2IaR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Apr 2022 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355349AbiD2IaP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Apr 2022 04:30:15 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D93910FC1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Apr 2022 01:26:55 -0700 (PDT)
Subject: Re: Encountering errors while using RNBD over rxe for v5.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651220809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Al/ZrynyRzlYVZGYgDbxJnjqvbo4TkG+pmBNh8JZxsU=;
        b=hDlwUpBCCXxeD4InBGJRoILqdP+JzqblxpOfZ1lsy5uIXsz1/Yliw1oS6yTChbEx8CnaIh
        5t4cHmh46oXS2V+nmI7+prCyeA2LzvFzG3bVIHunQ5RRt06kNRa5lHXA1VZfoMrYQm2GCp
        pNLfaoh8fjQcA6Dyf5apWqPtX9f5Anw=
To:     Haris Iqbal <haris.iqbal@ionos.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        yanjun.zhu@linux.dev
Cc:     Jinpu Wang <jinpu.wang@ionos.com>
References: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <95d12c5b-83bb-dce6-750a-3827118b9aaf@linux.dev>
Date:   Fri, 29 Apr 2022 16:26:46 +0800
MIME-Version: 1.0
In-Reply-To: <CAJpMwygqY4qwXfHd88wYs+KdKDEB=z=CzFd7jTVos-S3XNT5Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Haris,

On 4/20/22 6:28 PM, Haris Iqbal wrote:
> Hello,
>
> We are facing some issues with the rxe driver in v5.14 (tested with 5.14.21)
>
> After mapping a single RNBD device with 2 rxe interfaces, and with the
> below fio config,
>
> [global]
> description=Emulation of Storage Server Access Pattern
> bssplit=512/20:1k/16:2k/9:4k/12:8k/19:16k/10:32k/8:64k/4
> fadvise_hint=0
> rw=randrw:2
> direct=1
> random_distribution=zipf:1.2
> time_based=1
> runtime=60
> ramp_time=1
> ioengine=libaio
> iodepth=128
> iodepth_batch_submit=128
> iodepth_batch_complete_min=1
> iodepth_batch_complete_max=128
> numjobs=1
> group_reporting
>
> [job1]
> filename=/dev/rnbd0
>
>
> We observe the following error,
>
> [Fri Mar 25 19:08:03 2022] rtrs_client L353: <blya>: Failed
> IB_WR_LOCAL_INV: WR flushed
> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> IB_WR_REG_MR: WR flushed
> [Fri Mar 25 19:08:03 2022] rtrs_client L333: <blya>: Failed
> IB_WR_REG_MR: WR flushed
> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>: Failed
> IB_WR_LOCAL_INV: WR flushed
> [Fri Mar 25 19:08:34 2022] rtrs_client L353: <blya>:*Failed IB_WR_LOCAL_INV: WR flushed*

I got similar message but I am not certain it is the same one, pls see 
the previous report,

https://lore.kernel.org/linux-rdma/20220210073655.42281-1-guoqing.jiang@linux.dev/

Thanks,
Guoqing
