Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD1050EBE2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Apr 2022 00:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiDYWZP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343668AbiDYWFJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 18:05:09 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ECD2AED
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 15:02:03 -0700 (PDT)
Message-ID: <8d8413e4-d30c-9e65-914e-231cc8e9784a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650924121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1R1E/JDRb2Oy45G5VOjsCxH3aTtrWflbwZKm9fp/FkU=;
        b=ViQKDPXPyd9xpfqfwoqkyQfRPtVLjopwRlKKkSMNCBJVK8NqQV6jyjWuGowNSryzE7gc8V
        ww674yni/PbWiusHnHHq6I+EGplk1T++upDuD1FM1u1GHiCPqUdBA5JXBb9IYGnupI1rFS
        tkP1146pry/zhaset0Y7cDmKaXdm5jQ=
Date:   Tue, 26 Apr 2022 06:01:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <MW4PR84MB23078B439AE048978D67F42EBCF79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
 <20220425190227.GX64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220425190227.GX64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/4/26 3:02, Jason Gunthorpe 写道:
> On Mon, Apr 25, 2022 at 07:47:23AM +0800, Yanjun Zhu wrote:
>> 在 2022/4/22 23:57, Pearson, Robert B 写道:
>>> Use of rcu_read_lock solves this problem. Rcu_read_lock and spinlock on same data can
>>> Co-exist at the same time. That is the whole point. All this is going away soon.
>> This is based on your unproved assumption.
> No, Bob is right, RCU avoids the need for a BH lock on this XA, the
> only remaining issue is the AH creation atomic call path.

If RCU is used, the similar issues like AH creation atomic call path 
will become more.

Zhu Yanjun

>
> Jason
