Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F42656B37E
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Jul 2022 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiGHH1f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Jul 2022 03:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbiGHH1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Jul 2022 03:27:22 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F287C194
        for <linux-rdma@vger.kernel.org>; Fri,  8 Jul 2022 00:27:20 -0700 (PDT)
Subject: Re: [PATCH for-next 5/5] RDMA/rtrs-srv: Do not use mempool for page
 allocation
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657265239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4k14x8GV8ZlgaPKIhCKNQBCt42IVLjaz46rfH6pIgE=;
        b=rQPmUWQd9o8DtPT6Y2M9BTcjho0KCQeiEHYG7lNCFlf0W/Q26ILhfaz/qPvCdb4up+Pumh
        gU413Oy7ntlIgtJFk7kB041dtJ0LwoPibRFfhVJ23XS+KDnS27G3lKFtcfbTMd1PUR4L2q
        3UyNOkX29/es5ekgTUyMo8xHSAgf9Wk=
To:     Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
 <20220707142144.459751-6-haris.iqbal@ionos.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <f25b46c3-d1c7-29e2-813f-1c221481387f@linux.dev>
Date:   Fri, 8 Jul 2022 15:27:10 +0800
MIME-Version: 1.0
In-Reply-To: <20220707142144.459751-6-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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



On 7/7/22 10:21 PM, Md Haris Iqbal wrote:
> From: Jack Wang <jinpu.wang@ionos.com>
>
> The mempool is for guaranteed memory allocation during
> extreme VM load (see the header of mempool.c of the kernel).
> But rtrs-srv allocates pages only when creating new session.
> There is no need to use the mempool.
>
> With the removal of mempool, rtrs-server no longer need to reserve
> huge mount of memory, this will avoid error like this:
> https://www.spinics.net/lists/kernel/msg4404829.html
>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> ---
>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 23 ++++++-----------------

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
