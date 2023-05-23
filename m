Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098670D2A0
	for <lists+linux-rdma@lfdr.de>; Tue, 23 May 2023 05:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjEWD6Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 May 2023 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjEWD6K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 May 2023 23:58:10 -0400
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [IPv6:2001:41d0:203:375::19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E20C1
        for <linux-rdma@vger.kernel.org>; Mon, 22 May 2023 20:58:07 -0700 (PDT)
Message-ID: <e0d9f667-06b3-802f-8e9c-739eae14f8ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684814284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+l87Hpar9mvl8WdHQoVBboBQJwVyZRSK9FMUxoP/jMo=;
        b=HuOciLxkWXiIIiobvBE1TmuY2l1BIxlDVwBkv5lLjEIJDA7JVJsJDy4zfNYuoocHSuxjeY
        tEx6cH1LdNKrA3qMqlGDu3LGe8YDsC4mZbdiuRkBFn8sB8CY3fysUABYt5qjew1YelNHIE
        tcVGcBWXRsZLpb2QmDRpfVpEAvxFCbA=
Date:   Tue, 23 May 2023 11:58:00 +0800
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] INFO: trying to register non-static key in
 skb_dequeue (2)
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     syzbot <syzbot+eba589d8f49c73d356da@syzkaller.appspotmail.com>,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000a589d005fc52ee2d@google.com>
 <13528f21-0f36-4fa2-d34f-eecee6720bc1@linux.dev>
 <CAD=hENeCo=-Pk9TWnqxOWP9Pg-JXWk6n6J19gvPo9_h7drROGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAD=hENeCo=-Pk9TWnqxOWP9Pg-JXWk6n6J19gvPo9_h7drROGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/23/23 11:47, Zhu Yanjun wrote:
> On Tue, May 23, 2023 at 10:26 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>
>>
>> On 5/23/23 10:13, syzbot wrote:
>>> Hello,
>>>
>>> syzbot tried to test the proposed patch but the build/boot failed:
>>>
>>> failed to apply patch:
>>> checking file drivers/infiniband/sw/rxe/rxe_qp.c
>>> patch: **** unexpected end of file in patch
> This is not the root cause. The fix is not good.

Could you explain about the root cause?

Thanks,
Guoqing
