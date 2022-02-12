Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0034B3239
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Feb 2022 01:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354164AbiBLA7f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 19:59:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240377AbiBLA7e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 19:59:34 -0500
X-Greylist: delayed 53374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 16:59:32 PST
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0FD7E
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 16:59:32 -0800 (PST)
Subject: Re: [PATCH 2/3] RDMA/rxe: Replace write_lock_bh with
 write_lock_irqsave in __rxe_drop_index
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644627570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQMhAGfgLr6yfb94o2tVCQozP0LbioBDoAO5nMbre6I=;
        b=n1mwuLnE+FrXK+7jEPwrJJK+tDh3pyg1k4KBBOGwQsBWmAcTsn0w4Xh9jG7fNNXqFzCwnA
        X1j/gkFDFqGxUR8pQNBgrDf/n6CZX0rp3NhntyRWDXndoYsESUQKWU81RZBdVY77ZziXTH
        q3EAzbBLY/UZHXQGNW64EDoQ4KgMk00=
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20220210073655.42281-1-guoqing.jiang@linux.dev>
 <20220210073655.42281-3-guoqing.jiang@linux.dev>
 <CAD=hENd6GiLggA5L9p_jQk9MA4ckh3vNB=EKXZ6BZxKrgNCoAg@mail.gmail.com>
 <cd90c0e1-0327-4f0b-1b38-489fd18cf9d5@gmail.com>
 <b9d5b243-2397-42bd-d833-1a1e5e4ce32c@linux.dev>
 <0bfd4e4f-0311-ed02-d23e-7bd5a2a9750b@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <1452f4e8-454e-665e-4967-dc081efc1cb5@linux.dev>
Date:   Sat, 12 Feb 2022 08:59:26 +0800
MIME-Version: 1.0
In-Reply-To: <0bfd4e4f-0311-ed02-d23e-7bd5a2a9750b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/12/22 1:37 AM, Bob Pearson wrote:
> Guoqing,
>
> It would help to know more about the test setup you are using. I.e. which NIC/driver.
> I mostly test on head of tree and things seem to be working.

I runs a  5.17-rc3 inside VM which was configured with e1000e NIC, and 
the three calltraces
can be reproduced 100%, as said, CONFIG_PROVE_LOCKING is enabled.

Thanks,
Guoqing
