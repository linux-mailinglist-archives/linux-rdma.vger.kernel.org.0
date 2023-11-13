Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE417E9BB0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Nov 2023 12:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjKML7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Nov 2023 06:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKML7f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Nov 2023 06:59:35 -0500
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F67D70
        for <linux-rdma@vger.kernel.org>; Mon, 13 Nov 2023 03:59:32 -0800 (PST)
Message-ID: <3d34553d-f6c3-df40-56bf-db10af8472cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699876771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ba/iTvwX7U1rcb8p3YfpC1ootop+YbyWbSBICB9HcPM=;
        b=N7Mll2XjiZ+Nb5BzdChmiP1FQThQKLWV/Y4eIcSC6Iz+ZpjpUZYRRr71MhAjdBa4j+44Ar
        4oUVTGYFs+pWpky0J4fX3mS+R9MAKNVi9kRHlGTZdW5tbRcitVycMdby7uFQL0VkPoVKy5
        C5puHuqVihlhFBk+BywvOvTFbunYLY8=
Date:   Mon, 13 Nov 2023 19:59:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V4 00/18] Cleanup for siw
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     bmt@zurich.ibm.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231113083826.GA51912@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20231113083826.GA51912@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/13/23 16:38, Leon Romanovsky wrote:
> On Fri, Oct 27, 2023 at 09:26:26PM +0800, Guoqing Jiang wrote:
>> V4 changes:
>> 1. add Acked-by tags.
>> 2. update patch 3 and patch 12 per Bernard's review.
>> 3. update patch header in patch 18.
>>
>> V3 changes:
>> 1. add Acked-by tags.
>> 2. drop 2 patches and address other comments.
>>
>> Appreciate for Bernard's review!
>>
>> V2 changes:
>> 1. address W=1 warning in patch 12 and 19 per the report from lkp.
>> 2. add one more patch (20th).
>>
>> Hi,
>>
>> This series aim to cleanup siw code, please review and comment!
> This series wasn't sent properly and it doesn't exist in patchworks and lore.
> Please resend it properly.

Done.

https://lore.kernel.org/linux-rdma/20231113115726.12762-1-guoqing.jiang@linux.dev/T/#t

Thanks,
Guoqing
