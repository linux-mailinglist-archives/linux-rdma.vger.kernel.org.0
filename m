Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770687E24F9
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjKFN1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjKFN1I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 08:27:08 -0500
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C75EA
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 05:27:04 -0800 (PST)
Message-ID: <0f190158-d39f-45b0-be07-73977bfb40b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699277222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+YWIL8DRhgyBRrnJbxX08BtK+MpExpfO8w6zLIH38J0=;
        b=kG8hm5xhlHA1ETN4Acuqf7CXRcEQ8M64f2IYLvCf9jGUOOaKoYsoTpXMYq8qoRy+PRo+7k
        4tHCouab5MH8LYhJK4OspvkhUgXN55170SM7PeqrjgqKKOmLwkikFApMZxtqn2uoq8wen6
        OAEsh8WWlUooDHsN92yZuHklfqmeQe4=
Date:   Mon, 6 Nov 2023 21:26:52 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        linux-rdma@vger.kernel.org
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
 <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
 <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/11/6 4:19, Bob Pearson 写道:
>
>
> On 11/4/23 07:42, Zhu Yanjun wrote:
>
>>
>> Using reverse fir tree, a.k.a. reverse Christmas tree or reverse XMAS 
>> tree, for
>>
>> variable declarations isn't strictly required, though it is still 
>> preferred.
>>
>> Zhu Yanjun
>>
>>
> Yeah. I usually follow that style for new code (except if there are
> dependencies) but mostly add new variables at the end of the list
> together  because it makes the patch simpler to read. At least it
> does for me. If you care, I am happy to fix this.

Yes. It is good to fix it.

And your commits add mcast address supports. And I think you

should have the test case in the rdma-core to verify these commits.

Can you share the test case in the rdma maillist? ^_^

Zhu Yanjun

>
> Bob
