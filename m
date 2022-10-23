Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2FB6093B6
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJWNmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiJWNmO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 09:42:14 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F866DFAC
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 06:42:13 -0700 (PDT)
Message-ID: <ac6228a7-52a6-3b80-6b22-c4444b67d360@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666532531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2F61FKumLUxWAW0yVbWNBv2N5pJbDFwhwzqHUBRjsQ=;
        b=fcgJp7wo8n4N3fJzvZbdxdmo3MLIjVrD+WsbDFKcwDWyyJzTNKJSd3KFE5CwKTy9SSQcou
        Ag0d3E3/RLHl+PuPwgy+Fo6DpoEL5FIUKdsus56+71CdV/DtyB40Qx+RnoIAA3q+YqYcRm
        FFqnzst1dZbWjZw7e+mVYoJ6d2LWmMs=
Date:   Sun, 23 Oct 2022 21:42:00 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] RDMA net namespace
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <Y1U7w+6emBqrQnkI@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y1U7w+6emBqrQnkI@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/10/23 21:04, Leon Romanovsky 写道:
> On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> There are shared and exclusive modes in RDMA net namespace. After
>> discussion with Leon, the above modes are compatible with legacy IB
>> device.
>>
>> To the RoCE and iWARP devices, the ib devices should be in the same net
>> namespace with the related net devices regardless of in shared or
>> exclusive mode.
>>
>> In the first commit, when the net devices are moved to a new net
>> namespace, the related ib devices are also moved to the same net
>> namespace.
> I think that rdma_dev_net_ops are supposed to handle this.

Yes. rdma_dev_net_ops can move ib devices from one net to another net.

But these functions are called by a netlink command "rdma dev...".


In my commit, to RoCE devices, ib devices and net devices should be in 
the same net.

That is, when the net devices are moved to another net, the ib devices 
are moved

to the same net automically instead of running a netlink command to move 
ib devices.


To legacy ib devices, this netlink command is needed. To RoCE devices, 
this command

is not needed. When net devices are moved to new net, the ib devices are 
also moved automically.

Per our discussion, if RoCE's net devices and ib devices are separated 
in the different net, ib devices

can not work.

Zhu Yanjun

>
> Thanks
