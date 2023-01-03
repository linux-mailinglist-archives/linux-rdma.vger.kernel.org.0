Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241CC65C111
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbjACNpJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 08:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjACNpI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 08:45:08 -0500
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CCB11444
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 05:45:07 -0800 (PST)
Message-ID: <d442a8e7-8988-1fae-0944-0fa54e36d902@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672753503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yO8PZrwTSrBbnWhjmHMOc49KylAbEdL7YoC6ePbHbCA=;
        b=a2DYPFtyZMOktcgoIjM7K62M4BNrCKaJt3o85smIcV4B4Ox+FCD7od6vscQliDiz2MCMjM
        20ted0vhcsYAF7fM5buSX7JybH0VwTE6pi5O8Awd6NUxIw5R/dhA5yF/MAKakaQBwC5CO7
        HMPfolNx0nX+5gnNxkdZ+eo1Qnh7pM0=
Date:   Tue, 3 Jan 2023 21:44:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/irdma: Add support for dmabuf pin memory regions
To:     Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230103013433.341997-1-yanjun.zhu@intel.com>
 <Y7P3YR6Huf/cS+bS@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <Y7P3YR6Huf/cS+bS@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/1/3 17:37, Leon Romanovsky 写道:
> On Mon, Jan 02, 2023 at 08:34:33PM -0500, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a followup to the EFA dmabuf[1]. Irdma driver currently does
>> not support on-demand-paging(ODP). So it uses habanalabs as the
>> dmabuf exporter, and irdma as the importer to allow for peer2peer
>> access through libibverbs.
>>
>> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
>> This function is introduced in EFA dmabuf[1] which allows the driver
>> to get a dmabuf umem which is pinned and does not require move_notify
>> callback implementation. The returned umem is pinned and DMA mapped
>> like standard cpu umems, and is released through ib_umem_release().
>>
>> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
>>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
>>   1 file changed, 158 insertions(+)
>>
>> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
>> index f6973ea55eda..76dc6e65930a 100644
>> --- a/drivers/infiniband/hw/irdma/verbs.c
>> +++ b/drivers/infiniband/hw/irdma/verbs.c
>> @@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
>>   	return ERR_PTR(err);
>>   }
>>   
>> +struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>> +				       u64 len, u64 virt,
>> +				       int fd, int access,
>> +				       struct ib_udata *udata)
> 
> kbuild complained about this line, it should be "static struct ..."
> 
> And please use target in your patches: rdma-next/rdma-rc.

static is added.

Please check V2.

Thanks and Regards,

Zhu Yanjun

> 
> Thanks

