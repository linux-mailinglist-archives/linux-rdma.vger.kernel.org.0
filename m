Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBC064D544
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Dec 2022 03:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOCSc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Dec 2022 21:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOCSb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Dec 2022 21:18:31 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E31537DA
        for <linux-rdma@vger.kernel.org>; Wed, 14 Dec 2022 18:18:30 -0800 (PST)
Message-ID: <116df3dc-0ace-d764-1a59-8c1424cfbdc0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671070707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnTpNrhdL4sLHx+7xMLZDMAiYovf1R7LxcODHM2B+Ag=;
        b=UgmKj8KgyYxAcNXyOITEWOpgTp8ic1DUl4TFDjgAUZwzTzXQ6dmNUrhwKhLaKOADfPcWId
        yDb1Gzfg+tHcG/f+huMuh/7Glfxt+JCR3LTukY7pzsmntMQ91KmAnj3lDu3P1Om1Ws8SFa
        YCHV/QqNF3qWMNnw/Lcf8x2Q/QSJFSI=
Date:   Thu, 15 Dec 2022 10:18:22 +0800
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
References: <Y5jpKmpwhTAf+r8B@nvidia.com>
 <7601dc11-f1b5-5488-727a-13b4016c8aa5@linux.dev> <Y5l97q27hU5d8pU2@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y5l97q27hU5d8pU2@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/12/14 15:40, Leon Romanovsky 写道:
> On Wed, Dec 14, 2022 at 10:23:29AM +0800, Yanjun Zhu wrote:
>> 在 2022/12/14 5:05, Jason Gunthorpe 写道:
>>> Hi Linus,
>>>
>>> This cycle saw a new driver called MANA get merged and more fixing to
>>> the other recently merged drivers. rxe continues to see a lot of
>>> interest and fixing. Lots more rxe patches already in the works for
>>> the next cycle.
>>>
>>> Thanks,
>>> Jason
> <...>
>
>>> Zhu Yanjun (2):
>>>         RDMA/rxe: Remove reliable datagram support
>>>         RDMA/mlx5: Remove not-used IB_FLOW_SPEC_IB define
>> I do not like this subject. I still like my old one.
>> With the old one, it suggests that IB_FLOW_SPEC is not supported in MLX5 in
>> subject line.
> Right now, mlx5 doesn't implement this IB_FLOW_SPEC and define is not
> used. It doesn't mean that it is not supported.

Got you. MLX5 has the capability to support IB_FLOW_SPEC.

But no user will use IB_FLOW_SPEC, so it is not implemented on MLX5.

Zhu Yanjun

>
> Thanks
