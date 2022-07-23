Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364EE57EAA8
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jul 2022 02:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiGWAfk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGWAfj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 20:35:39 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32601F620
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 17:35:37 -0700 (PDT)
Message-ID: <bde7129f-d9fd-39fe-02eb-81672816fa99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658536535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jHFYCh6N4Cw7qdEitgyoZTsNJfztHBX+uO+n/cb6ic=;
        b=J3f0mvZ4OyIJIazxSnq+c/AXiyA11Ity2zJkeDbgrA3M+4ngs9syCKtj0wXgHNfDjyb41e
        h2o75lph+CHSir68XSm8FUtVHGflPticdniahJjQpPNIexl/La+FDGjvYPiplleFjMbCgp
        v26kC1gaHto0yx9zyuows7ZveJTHnDk=
Date:   Sat, 23 Jul 2022 08:35:23 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
 <921120a1-28fa-dd2a-b6fc-227faa3c8ace@linux.dev>
 <cc59c87d-39dd-6307-de9e-a67a89acfea0@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <cc59c87d-39dd-6307-de9e-a67a89acfea0@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/22 23:14, yangx.jy@fujitsu.com 写道:
> On 2022/7/22 21:43, Yanjun Zhu wrote:
>> Hi， Xiao
>>
>> Normally I applied this "RDMA/rxe: Fix dead lock caused by
>> __rxe_add_to_pool interrupted by rxe_pool_get_index" patch
>>
>> series to fix this problem. And I am not sure if this problem is fixed
>> by "[PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu".
>>
>> Zhu Yanjun
> Hi Yanjun,
>
> I have confirmed that the problem has been fixed by:
> [PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu

Thanks.

Zhu Yanjun

>
> Best Regards,
> Xiao Yang
