Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9E5B5637
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Sep 2022 10:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiILIae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Sep 2022 04:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiILIaR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Sep 2022 04:30:17 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7A1A059;
        Mon, 12 Sep 2022 01:30:00 -0700 (PDT)
Message-ID: <7d30b552-a737-9f19-dea8-26978a6601ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662971398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ko/M01mjxRdaswWjLV+NEVwlojpcTrguLl8c9fDwroI=;
        b=rvaOSKdYwVlUfJroDJhCBq6ntfqFHL8SbcFkneCZfF5tR0ktlwo6gSd4FZVjVsIHewZxp+
        QN2w9xmTZvsx5att7O/aO4DqKQs8zfGBaVMjxDSPl2VdqqI9YnDTYjVNdUngXRGH6hWRMw
        svEl0BhCzh6qwS9/ng6HF1jpWEL6mOc=
Date:   Mon, 12 Sep 2022 16:29:51 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] RDMA/rxe: Convert the triple tasklets to
 workqueues
To:     "matsuda-daisuke@fujitsu.com" <matsuda-daisuke@fujitsu.com>,
        'Bart Van Assche' <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Cc:     "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
References: <cover.1662461897.git.matsuda-daisuke@fujitsu.com>
 <41e5476f4f14a0b77f4a8c3826e3ef943bf7c173.1662461897.git.matsuda-daisuke@fujitsu.com>
 <0b3366e6-c0ae-7242-5006-b638e629972d@linux.dev>
 <fd1d7c49-a090-e8c7-415b-dfcda94ace9d@acm.org>
 <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <TYCPR01MB8455D739FC9FB034E3485C87E5449@TYCPR01MB8455.jpnprd01.prod.outlook.com>
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


在 2022/9/12 15:58, matsuda-daisuke@fujitsu.com 写道:
> On Mon, Sep 12, 2022 12:09 AM Bart Van Assche wrote:
>> On 9/11/22 00:10, Yanjun Zhu wrote:
>>> I also implemented a workqueue for rxe. IMO, can we add a variable to
>>> decide to use tasklet or workqueue?
>>>
>>> If user prefer using tasklet, he can set the variable to use
>>> tasklet. And the default is tasklet. Set the variable to another
>>> value to use workqueue.
> That's an interesting idea, but I am not sure how users specify it.
> IIRC, tasklets are generated when rdma link is added, typically by
> executing ' rdma link add' command. I don't think we can add
> an device specific option to the utility(iproute2/rdma).

In my workqueue implementation, I used a sysctl variable to set a value 
to choose tasklet or workqueue.

You can use sysctl or driver parameter to decide to use tasklet or 
workqueue.

And finally the Macros like #if ... #else ... #endif also acts as a method.

Zhu Yanjun

>
>> I'm in favor of removing all uses of the tasklet mechanism because of
>> the disadvantages of that mechanism. See also:
>> * "Eliminating tasklets" (https://lwn.net/Articles/239633/).
>> * "Modernizing the tasklet API" (https://lwn.net/Articles/830964/).
>> * Sebastian Andrzej Siewior's opinion about tasklets
>> (https://lore.kernel.org/all/YvovfXMJQAUBsvBZ@linutronix.de/).
> I am also in favor of using workqueues alone not only because of the
> disadvantages above but also to avoid complexity. I would like to know
> if there is anybody who will bothered by the change especially in terms
> of performance.
>
> Thanks,
> Daisuke
>
>> Thanks,
>>
>> Bart.
