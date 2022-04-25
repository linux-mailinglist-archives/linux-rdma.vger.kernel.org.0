Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C8250D61F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 02:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiDYAHr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 Apr 2022 20:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbiDYAHb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 24 Apr 2022 20:07:31 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF85DA62
        for <linux-rdma@vger.kernel.org>; Sun, 24 Apr 2022 17:04:28 -0700 (PDT)
Message-ID: <98ad3df7-b934-ad2b-49c6-bb07a06a5c4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650845067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwTvPTR1n6rq482gqzu5T5/OpWQzJgKqmTM3CPfqiFk=;
        b=Iox90Mzj1LFBexEgfup86+aE5JQGkYskSVhAdDCUd/YrErKKFMriZiJW8shP0KTFQbiWpN
        jCDsEmAUG0U2OD6F3QWrthcOMWqH78mbyLe5A71fTb4w+9ra6ZDwpzXKs+Njb0rk1DLS0C
        mbHFcypy0pEL8nwVX+1nekSZGctu5Z4=
Date:   Mon, 25 Apr 2022 08:04:22 +0800
MIME-Version: 1.0
Subject: Re: bug report for rdma_rxe
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <5de7d1a9-a7ac-aea5-d11c-49423d3f0bf1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/4/23 5:04, Bob Pearson 写道:
> Local operations in the rdma_rxe driver are not obviously idempotent. But, the
> RC retry mechanism backs up the send queue to the point of the wqe that is
> currently being acknowledged and re-walks the sq. Each send or write operation is
> retried with the exception that the first one is truncated by the packets already
> having been acknowledged. Each read and atomic operation is resent except that
> read data already received in the first wqe is not requested. But all the
> local operations are replayed. The problem is local invalidate which is destructive.
> For example

Is there any example or just your analysis?
You know, sometimes your analysis is not always correct.
To prove your analysis, please show us some solid example.

Zhu Yanjun

> 
> sq:	some operation that times out
> 	bind mw to mr
> 	some other operation
> 	invalidate mw
> 	invalidate mr
> 
> can't be replayed because invalidating the mr makes the second bind fail.
> There are lots of other examples where things go wrong.
> 
> To make things worse the send queue timer is never cleared and for typical
> timeout values goes off every few msec whether anything actually failed.
> 
> Bob

