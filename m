Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157804B95CA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 03:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiBQCDr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Feb 2022 21:03:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiBQCDq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Feb 2022 21:03:46 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4379F13A1DA
        for <linux-rdma@vger.kernel.org>; Wed, 16 Feb 2022 18:03:32 -0800 (PST)
Subject: Re: [PATCH for-next] RDMA/rxe: Revert changes from irqsave to bh
 locks
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645063410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTuZ9SlgnH6GtS3v264CCPWBybHvJJruhHqZmUYzt34=;
        b=I0CMJVJxDa0SvbuFmEsUSljG+2mAxYHLJF2QVewTTAfhFZKiaPsVuaK5qJIIlyYFT/9JEU
        xfyOatzYib2Yv7ZZyEo+6StEgAqBhWEY1YTaRreZ5kJ73r6gAF54nT46D4FiDqlUOEIVtc
        rYMX8GpDkzCOMh+p51QNcA3Yi8pE0fo=
To:     Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, zyjzyj2000@gmail.com, bvanassche@acm.org
References: <20220215194448.44369-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <17e36066-ccbf-27fe-6f26-302e73f05df7@linux.dev>
Date:   Thu, 17 Feb 2022 10:03:24 +0800
MIME-Version: 1.0
In-Reply-To: <20220215194448.44369-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2/16/22 3:44 AM, Bob Pearson wrote:
> A previous patch replaced all irqsave locks in rxe with bh locks.
> This ran into problems because rdmacm has a bad habit of
> calling rdma verbs APIs while disabling irqs. This is not allowed
> during spin_unlock_bh() causing programs that use rdmacm to fail.
> This patch reverts the changes to locks that had this problem or
> got dragged into the same mess. After this patch blktests/check -q srp
> now runs correctly.
>
> This patch applies cleanly to current for-next
>
> commit: 2f1b2820b546 ("Merge branch 'irdma_dscp' into rdma.git for-next")
>
> Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 21adfa7a3c4e ("RDMA/rxe: Replace irqsave locks with bh locks")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---

Acked-by: Guoqing Jiang<guoqing.jiang@linux.dev>

Thanks,
Guoqing

