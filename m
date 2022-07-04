Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56944565877
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 16:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbiGDOSX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 10:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiGDOSV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 10:18:21 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A72AD4
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 07:18:19 -0700 (PDT)
Message-ID: <b3b9c17e-11f3-531f-bd13-2b0573312126@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1656944298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qk/7WyyqaHpHucT6YtJx1Qu8XxXt42U1gVo7YDInSqs=;
        b=XD8/A0Y/Edom0r0XOPi2qgug4UsJk5hPXfOpoitcsz088ORJcfhUJ8meWeXn7Xdpi0oo7z
        GkyaFUO50ZN8z8q4gmkcE6cALp7Qo/Ci1CIGjCAPi96MQ2T2rnr4adUsrnqtPfhJP4RgPS
        HmR/5c5S5eA0ELvRUdNM2Ec2LaZrX40=
Date:   Mon, 4 Jul 2022 22:18:06 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix qp error handler
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Haris Iqbal <haris.iqbal@ionos.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
References: <20220526025438.572870-1-yanjun.zhu@linux.dev>
 <CAJpMwyhLuygVe3dsg=QkOWwmDSFxpRRjCWNAPr_YknPjub9WNg@mail.gmail.com>
 <20220704130623.GA1410451@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220704130623.GA1410451@nvidia.com>
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


在 2022/7/4 21:06, Jason Gunthorpe 写道:
> On Wed, May 25, 2022 at 02:29:06PM +0200, Haris Iqbal wrote:
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
>>> index 9d995854a174..d0bc195b572f 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
>>> @@ -432,7 +432,6 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>>>          return 0;
>>>
>>>   qp_init:
>>> -       rxe_put(qp);
>> Does this mean that in case rxe_qp_init_resp fails (rxe_qp_init_req
>> had succeeded), we will NOT end up calling rxe_qp_do_cleanup? If so,
>> would we miss shutting down and releasing qp->sk?
> Zhu??

The latest commit will come very soon.

Zhu Yanjun

>
> Jason
