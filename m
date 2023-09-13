Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81C79F557
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Sep 2023 01:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjIMXMQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Sep 2023 19:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMXMP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 Sep 2023 19:12:15 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15311BCB
        for <linux-rdma@vger.kernel.org>; Wed, 13 Sep 2023 16:12:11 -0700 (PDT)
Message-ID: <20fb88a8-6c68-671c-7791-be1df6f708d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694646729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMg32N4cjhug3Qckc7pNVslAjZgHfLwzhY4rlKC92Ks=;
        b=mFJgEEEi/XEuA92s9B4IQVE0hzCoM/ktjRACY2EDdcY8Ayr4iOVm+wBI3D7zU0y99FK8uv
        BmAAgOO+1Zzgfn2H2dj03Ad6JEAu22fWVslpA0T6inhthsxGuZyS150w1tBcQQSf6gace0
        5jmDRgrRY7cFLJbe2WquH8kfimA31Ho=
Date:   Thu, 14 Sep 2023 07:12:04 +0800
MIME-Version: 1.0
Subject: Re: newlines in message macros
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1fbe7ebb-6501-10c4-b9eb-8435661f6046@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/9/14 4:50, Bob Pearson 写道:
> Li,
> 
> I see that you removed the built-in newlines in the debug macros in rxe.h which is ok by me. But,

I made tests for many times about adding newline speeding up flush 
messages. With or without new line, I can not find out the difference on 
flushing messages. Not sure if Li Zhijian found this difference in a 
specific scenario or not.
And even without new line, after output the line, the message still goes 
to a new line. I suspect if a newline is appended in the PRINTK subsystem.

Zhu Yanjun

> for some reason the rxe_xxx() macros all still have built-in newlines. Why shouldn't we be consistent
> and make them all the same. (Maybe they don't get used much or at all.)
> 
> Bob

