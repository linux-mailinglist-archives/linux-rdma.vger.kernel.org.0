Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4A5A4E29
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 15:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiH2NdT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH2NdR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 09:33:17 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF948A6F3;
        Mon, 29 Aug 2022 06:33:15 -0700 (PDT)
Subject: Re: [PATCH] rnbd-srv: remove 'dir' argument from rnbd_srv_rdma_ev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661779992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGTDmBTnSUxZ2aPGvbotw8MTs5jZFkG/dPZ3aMTk51s=;
        b=wxQf3/VaAuLxRGXzYOwrzmT2q8Q/2cvD2zrtQWyBFWY77Wpzw7pfPTxmM1MqPJaYm7MiuA
        5o5HUz8Hazyi7Lsc/6nQzFdKvV9grEvlWUbcpYRsvsKuYQsPBxa1hgec5yolpkMu40A1E+
        fw6VmlUYSUBihUueXGSAKhqj8kZxsk8=
To:     Leon Romanovsky <leon@kernel.org>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        jgg@ziepe.ca, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <20220826081117.21687-1-guoqing.jiang@linux.dev>
 <YwxuYrJJRBDxsJ8X@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <d969d7bf-d2a3-05aa-26e5-41628f74b8ab@linux.dev>
Date:   Mon, 29 Aug 2022 21:33:09 +0800
MIME-Version: 1.0
In-Reply-To: <YwxuYrJJRBDxsJ8X@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/29/22 3:44 PM, Leon Romanovsky wrote:
> On Fri, Aug 26, 2022 at 04:11:17PM +0800, Guoqing Jiang wrote:
>> Since all callers (process_{read,write}) set id->dir, no need to
>> pass 'dir' again.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>> ---
>>   drivers/block/rnbd/rnbd-srv.c          | 9 ++++-----
>>   drivers/block/rnbd/rnbd-srv.h          | 1 +
>>   drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>>   drivers/infiniband/ulp/rtrs/rtrs.h     | 3 +--
>>   4 files changed, 8 insertions(+), 9 deletions(-)

> I applied the patch and cleanup of rtrs-srv.h can be done later.

Thanks! I suppose below

> So decouple it from rtrs-srv.h and hide everything that not-needed to be
> exported to separate header file.

means move 'struct rtrs_srv_op' to rtrs.h, which seems not appropriate to me
because both client and server include the header. Pls correct me if I 
am wrong.

Since process_{read,write} prints direction info if ctx->ops.rdma_ev 
fails, how
about remove the 'dir' info from rnbd_srv_rdma_ev? Then we  don't need to
include rtrs-srv.h.

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 431c6da19d3f..d07ff3ba560c 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -387,8 +387,8 @@ static int rnbd_srv_rdma_ev(void *priv, struct 
rtrs_srv_op *id,
                                             datalen);
                 break;
         default:
-               pr_warn("Received unexpected message type %d with dir %d 
from session %s\n",
-                       type, id->dir, srv_sess->sessname);
+               pr_warn("Received unexpected message type %d from 
session %s\n",
+                       type, srv_sess->sessname);
                 return -EINVAL;
         }

diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 5a0ef6c2b5c7..081bceaf4ae9 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -14,7 +14,6 @@
  #include <linux/kref.h>

  #include <rtrs.h>
-#include <rtrs-srv.h>
  #include "rnbd-proto.h"
  #include "rnbd-log.h"


Thoughts?

Thanks,
Guoqing
