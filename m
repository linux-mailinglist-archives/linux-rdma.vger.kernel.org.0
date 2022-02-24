Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDC4C21A8
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 03:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBXCO1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 21:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiBXCO0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 21:14:26 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6EF1DDFFC
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 18:13:57 -0800 (PST)
Message-ID: <28fab09c-3895-67c0-5332-be2f97dc8d75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645668834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eav0XdSqSUYuYHk/dOIwph+bJ3TxGtTu+SfSDQVKIGI=;
        b=rx4GiW7CTkEevrCjekob2knYBSXGZG56if5NvSa6QAzYD4ObqptYMGh8nFZrWyQU1kqTNN
        yXDkyMmQRDCo6dt9kmaO9c7+J9oxhH1HxnloCUb+SaGpiU4uDyvodNKFRaWg9rew9uLl1g
        y1D24E9aZEAGqtp7m7rm0UHhIx6CKeg=
Date:   Thu, 24 Feb 2022 10:13:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Make irdma_create_mg_ctx return a void
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
References: <20220217181938.3798530-1-yanjun.zhu@linux.dev>
 <20220223193202.GA419090@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220223193202.GA419090@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/2/24 3:32, Jason Gunthorpe 写道:
> On Thu, Feb 17, 2022 at 01:19:38PM -0500, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> The function irdma_create_mg_ctx always returns 0,
>> so make it void and delete the return value check.
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/uda.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
> This doesn't apply please rebase it to commit 2322d17abf0a
> ("RDMA/irdma: Remove excess error variables")
Thanks. Now the latest commit is on the commit 2322d17abf0a

("RDMA/irdma: Remove excess error variables").


Zhu Yanjun

>
> Jason
