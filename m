Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2F585AA5
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Jul 2022 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiG3OB6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 30 Jul 2022 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiG3OB6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 30 Jul 2022 10:01:58 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B54F193ED
        for <linux-rdma@vger.kernel.org>; Sat, 30 Jul 2022 07:01:57 -0700 (PDT)
Message-ID: <37d1ec16-e642-eaa8-3aa1-35317c17ce28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659189715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flhbp1jtObSn496W0hHnoV3ihawJuuAkSrh2WkLkB1U=;
        b=iRPVyROeZf+kKSaoXmNmRdI0Kjfi1jJxMI5RTvuYUI5yjHXyUQTYMKncRivdov20G7xlss
        s/Tv62Ez/J3I530LPQ/vjROAakQWYiJde3PMgHe0w80IcHhK5YBPgpOxn/cahMe2ePHrsw
        O51Gf9Y7UcUwu6x2u5hvfwzuFPNHxOE=
Date:   Sat, 30 Jul 2022 22:01:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix qp error handler
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
References: <20220726045631.183632-1-yanjun.zhu@linux.dev>
 <YuK7lpdGA3e+1jBs@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <YuK7lpdGA3e+1jBs@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/29 0:38, Jason Gunthorpe 写道:
> On Tue, Jul 26, 2022 at 12:56:31AM -0400, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> About 7 spin locks in qp creation needs to be initialized. Now these
>> spin locks are initialized in the function rxe_qp_init_misc. This
>> will avoid the error "initialize spin locks before use".
> Explain the problem completely please, is this triggered in an error
> unwind case?
>   
>> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com

In this link 
news://nntp.lore.kernel.org:119/0000000000006ed46805dfaded18@google.com,

"

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by:syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
"
Zhu Yanjun

> This isn't the right format for reported by
>
> Jason
