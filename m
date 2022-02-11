Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E904B22D0
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 11:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiBKKKD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 05:10:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbiBKKKC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 05:10:02 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07066E93
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 02:10:01 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644574196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05XIsBCwP2JDmPpLHTOQzSMax8AwqFvQHEX1W1QlfmU=;
        b=cAazMaGFSYACTrdIbuoqsvsUDKC0hT4X+Tq1i3dzE8O7AhiUwOCxqfKDibPz9zQF1MVUlt
        qsuolgi25pdmm/8va4XRBPacHQRdqD/KaJp9gqGapZ4k9uNm4MnVwF0mAfs75LLTRmtTz+
        Bio7Mea/p7SKmc0jBlXHPm1kRSyTwLI=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 2/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_drop_index
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <20220210073655.42281-3-guoqing.jiang@linux.dev>
 <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
 <cd90c0e1-0327-4f0b-1b38-489fd18cf9d5@gmail.com>
Message-ID: <b9d5b243-2397-42bd-d833-1a1e5e4ce32c@linux.dev>
Date:   Fri, 11 Feb 2022 18:09:49 +0800
MIME-Version: 1.0
In-Reply-To: <cd90c0e1-0327-4f0b-1b38-489fd18cf9d5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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



On 2/10/22 11:49 PM, Bob Pearson wrote:
> On 2/10/22 08:16, Zhu Yanjun wrote:
>> On Thu, Feb 10, 2022 at 3:37 PM Guoqing Jiang<guoqing.jiang@linux.dev>  wrote:
>>> Same as __rxe_add_index, the lock need to be fully IRQ safe, otherwise
>>> below calltrace appears.
>>>
> I had the impression that NAPI ran on a soft IRQ and the rxe tasklets are also on soft IRQs. So at least in theory spin_lock_bh() should be sufficient. Can someone explain where the hard interrupt is coming from that we need to protect.

Since rxe is actually run on top of NIC,  could it comes from NIC if NIC 
driver doesn't switch to NAPI
or from other hardware? But my knowledge about the domain is limited.

>   There are other race conditions in current rxe that may also be the cause of this. I am trying to get a patch series accepted to deal with those.

If possible, could you investigate why rxe after 5.15 kernel doesn't 
work as reported in cover letter? Thank you!

Guoqing
