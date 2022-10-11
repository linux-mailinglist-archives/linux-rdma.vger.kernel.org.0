Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246615FB6CB
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Oct 2022 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJKPSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Oct 2022 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJKPSS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Oct 2022 11:18:18 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E69C225
        for <linux-rdma@vger.kernel.org>; Tue, 11 Oct 2022 08:10:16 -0700 (PDT)
Message-ID: <0c399db3-a9a6-0b07-fb99-060c3bba418b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665500912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2y+5u/z5QuvNLy5NIDgGeDT1SVABaje+l8jy8v+LGE=;
        b=MR/YySLHWM83E+BnBGxDjeYUJtYX1FCBY9FXzvqJpaSXhGhYK/l/vXknbr92IMx4IAaCFu
        3sTBRqkSHGJ2o1bIbPUyvK889OCdp6/Gmx46GbVP6tNoqjdYYaxNdEYRiwsmewv7BZ4Pbu
        YaYOCbRR2KPEXUNfb3SukYTv5x5PDIo=
Date:   Tue, 11 Oct 2022 23:08:26 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 1/1] RDMA/core: Fix a problem from rdma link in
 exclusive mode
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     yanjun.zhu@linux.dev, jgg@nvidia.com, leo@kernel.org,
        linux-rdma@vger.kernel.org
References: <Yz/FaiYZO5Y0R7QP@unreal>
 <20221011002545.1410247-1-yanjun.zhu@intel.com> <Y0VBhhhSfzRQ8GY9@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y0VBhhhSfzRQ8GY9@unreal>
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

在 2022/10/11 18:12, Leon Romanovsky 写道:
> On Mon, Oct 10, 2022 at 08:25:45PM -0400, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is not an official commit. In rdma net namespace, the rdma device
>> is separate from the net device. For example, a rdma device A is in net
>> namespace A1 while the related net device B is in net namespace B1.
>>
>> I am curious how to make perftest and rping tests on the above
>> scenario. The ip address of net device B is in net namespace B1
>> while the rdma device is in net namespace A1.
> 
> Use "exclusive" mode, "shared" is legacy interface for backward
> compatibility.

Got it. Thanks.

> 
>>
>>  From my perspective, the rdma device and related net device should
>> be in the same net namespace. When a net device is moved from one net
>> namespace to another net namespace, the rdma device should be in the
>> same net namespace with the net device.
>>
>> In this commit, when all the ib devices are parsed in exclusive mode,
>> if the ib devices and related net devices are not in the same net
>> namespace, the link information will not be reported to user space.
>>
>> This commit is a RFC.
> 
> Please don't send patches as reply-to.

OK. I will send another commit to fix this problem very soon.

Zhu Yanjun

> 
> Thanks

