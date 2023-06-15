Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640DD731814
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jun 2023 14:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344613AbjFOMDx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jun 2023 08:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344714AbjFOMDk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Jun 2023 08:03:40 -0400
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52875FD5
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jun 2023 04:59:34 -0700 (PDT)
Message-ID: <ea05a59f-b13a-dfca-e7eb-4a873ea799ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686830371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKOVkl0zQJl3ULL+IRn7mGy3loW0Luzo3dFf20Jun+Y=;
        b=fr5u4ZGcRYN4I4AShHGQ5pxCpyDybmXSNqHamfho+TTu5+Ses1hJEW8ZGC1MBY7JiR4l4A
        f/z/ST0h6IQiVz9b665suWS+SUB6SYBlKD9ASO4AhZCJNQP+YqkDTt07G+rg1lIdo0CbjF
        FYUM9N5zgqLbfIm8J/y3LbhhF3ekrIo=
Date:   Thu, 15 Jun 2023 19:59:24 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/4] Handle ARPHRD_NONE devices for siw
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org, BMT@zurich.ibm.com
References: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <168675101993.2279.4985978457935843722.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/6/14 22:00, Chuck Lever 写道:
> Here's a series that implements support for siw on tunnel devices,
> based on suggestions from Jason Gunthorpe and Tom Talpey.
> 
> This series does not address a similar issue with rxe because RoCE
> GID resolution behaves differently than it does for iWARP devices.
> An independent solution is likely to be required for rxe.

Thanks a lot for letting me know. Look forward to the independent 
solution for rxe.

Zhu Yanjun

> 
> Changes since v2:
> - Split into multiple patches
> - Pre-initialize gid_attr::ndev for iWARP devices
> 
> ---
> 
> Chuck Lever (4):
>        RDMA/siw: Fabricate a GID on tun and loopback devices
>        RDMA/core: Set gid_attr.ndev for iWARP devices
>        RDMA/cma: Deduplicate error flow in cma_validate_port()
>        RDMA/cma: Avoid GID lookups on iWARP devices
> 
> 
>   drivers/infiniband/core/cache.c       | 12 ++++++++++++
>   drivers/infiniband/core/cma.c         | 24 +++++++++++++++++++-----
>   drivers/infiniband/sw/siw/siw.h       |  1 +
>   drivers/infiniband/sw/siw/siw_main.c  | 22 ++++++++--------------
>   drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
>   5 files changed, 42 insertions(+), 21 deletions(-)
> 
> --
> Chuck Lever
> 

