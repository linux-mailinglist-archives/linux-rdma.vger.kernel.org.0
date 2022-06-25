Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7074455AA46
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jun 2022 15:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiFYNAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jun 2022 09:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbiFYNAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jun 2022 09:00:13 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64D111163;
        Sat, 25 Jun 2022 06:00:12 -0700 (PDT)
Message-ID: <3ee9e8d1-01dc-0936-efde-b07482a5e785@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656162010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zAt4rLrvNcaq27+5fdC96DdrqkdI6Xy/AK+vU9KiLnA=;
        b=fyzCPYhQEJKWDjOUf7aWvbsrpflNxyl9ZdMAKtH78GmKDJUX5SCNHydxTNxEkBpK/VQJ6q
        ZLBfQagO1PxTHvUCvc96tFPOOFgu9mWRjZqnetAYaSNCp7R0K7C2s2iTkcqr8/vaQ6od2R
        mJoeAB/Ox84Rz7ihJV5aB8mVTaGw6CQ=
Date:   Sat, 25 Jun 2022 20:59:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/6/7 16:32, lizhijian@fujitsu.com 写道:
> Hi Json & Yanjun
>
>
> I know there are still a few regressions on RXE, but i do wish you could take some time to review these *simple and bugfix* patches
> They are not related to the regressions.

Now there are some problems from Redhat and other Linux Vendors.

We had better focus on these problems.

Zhu Yanjun

>
>
> Thanks
> Zhijian
>
>
> On 16/05/2022 09:53, Li Zhijian wrote:
>> Since RXE always posts RDMA_WRITE successfully, it's observed that
>> no more completion occurs after a few incorrect posts. Actually, it
>> will block the polling. we can easily reproduce it by the below pattern.
>>
>> a. post correct RDMA_WRITE
>> b. poll completion event
>> while true {
>>     c. post incorrect RDMA_WRITE(wrong rkey for example)
>>     d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
>> }
>>
>>
>> Li Zhijian (2):
>>     RDMA/rxe: Update wqe_index for each wqe error completion
>>     RDMA/rxe: Generate error completion for error requester QP state
>>
>>    drivers/infiniband/sw/rxe/rxe_req.c | 12 +++++++++++-
>>    1 file changed, 11 insertions(+), 1 deletion(-)
>>
