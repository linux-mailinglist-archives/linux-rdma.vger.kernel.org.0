Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E78744849
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jul 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGAJsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Jul 2023 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjGAJsX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Jul 2023 05:48:23 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE531FE7
        for <linux-rdma@vger.kernel.org>; Sat,  1 Jul 2023 02:48:21 -0700 (PDT)
Message-ID: <6a9d7bc5-4905-fb77-5476-b089d4049942@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688204899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y6fFnBYenannAyvKkp0ww1h/zdTzbusUWzdl0bhRnY8=;
        b=W7sIzhp22eSfUpGVAKJluvIDZeEVh3kdGydOEG5t6yP5JuRsu3Z2S1urb1axhvEoxTMDtK
        1F7xsU/SDCyhHuism53nbl0s3hnzwncFbQjzCvb0jpKAbm7H3A9bWIc7rPFvjNnyrg0DpC
        6gGfNAANoth72g+kMvcx97CePbG1UWU=
Date:   Sat, 1 Jul 2023 17:48:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 0/4] Handle ARPHRD_NONE devices for siw
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com
Cc:     Bernard Metzler <bmt@zurich.ibm.com>, Tom Talpey <tom@talpey.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/6/29 23:16, Chuck Lever 写道:
> Here's a series that implements support for siw on tunnel devices,
> based on suggestions from Jason Gunthorpe and Tom Talpey.
>
> This series does not address a similar issue with rxe because RoCE
> GID resolution behaves differently than it does for iWARP devices.
> An independent solution is likely to be required for rxe.

Thanks for letting me know this.

Zhu Yanjun

>
> Changes since v4:
> - Address review comments from Tom Talpey
>
> Changes since v3:
> - Clean up RCU dereference in cma_validate_port()
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
>   drivers/infiniband/core/cache.c       | 11 +++++++++++
>   drivers/infiniband/core/cma.c         | 26 +++++++++++++++++++++-----
>   drivers/infiniband/sw/siw/siw.h       |  1 +
>   drivers/infiniband/sw/siw/siw_main.c  | 22 ++++++++--------------
>   drivers/infiniband/sw/siw/siw_verbs.c |  4 ++--
>   5 files changed, 43 insertions(+), 21 deletions(-)
>
> --
> Chuck Lever
>
