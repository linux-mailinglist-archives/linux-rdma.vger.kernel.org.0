Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A07641DCE
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Dec 2022 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLDQKU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Dec 2022 11:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiLDQKT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Dec 2022 11:10:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAC614000;
        Sun,  4 Dec 2022 08:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=SscHgH3J9KK5gfwuEQ2NOCwS2DgWLcQspsrNrdeeHD4=; b=jDpJg29vy+4h0K9DFPMjwTY5M8
        +0TmBmtO9LdaEph0FTtUB5sF/FeEnBywhKv9/PB2hnenbh26uCsJxK68IYS1V6+yQK70Fagas9Rh1
        V0tMiKY6AmjfgZggJikY/OmK/ecw2IBC9Gj/9hXyi5u/7x3Be6V58uxv8HXe/GTJqU0Mh2BbkVsZA
        RVtNUZx5s8y8j36ogLeurNY0OVo0OdjaZIkhY1w0nFfbiXuhU4g9pYyq5g3f8tjMJjkZmBrwBi8LO
        SRCC0gjwhmwQtVDdRAhfGCDjlsdiDMqgYmSFYThAfWiUbOb3pS/saYaitzuALlMT9VApMgXMU29fJ
        v+S2g5VQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p1rZI-009Y2B-Lh; Sun, 04 Dec 2022 16:10:16 +0000
Message-ID: <12a78373-024a-1e50-01c1-10985815ff1f@infradead.org>
Date:   Sun, 4 Dec 2022 08:10:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
References: <20221202211940.29111-1-rdunlap@infradead.org>
 <Y4ye8YOWk0V/BqKL@unreal>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y4ye8YOWk0V/BqKL@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 12/4/22 05:21, Leon Romanovsky wrote:
> On Fri, Dec 02, 2022 at 01:19:40PM -0800, Randy Dunlap wrote:
>> Disable all of drivers/infiniband/hw/ for UML builds until someone
>> needs it and provides patches to support it.
>>
>> This prevents build errors in hw/qib/qib_wc_x86_64.c.
>>
>> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Suggested-by: Leon Romanovsky <leon@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> Cc: linux-rdma@vger.kernel.org
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: linux-um@lists.infradead.org
>> ---
>> v2: just disable infiniband/hw/, not all of infiniband.
>>
>>  drivers/infiniband/Kconfig |    2 ++
>>  1 file changed, 2 insertions(+)
> 
> I added rdmavt to the mix and applied.

Sounds good. Thanks.

> https://lore.kernel.org/linux-rdma/20221130200958.25305-1-rdunlap@infradead.org/
> 
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index 6ee97c898231..a5827d11e934 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -95,8 +95,8 @@ source "drivers/infiniband/hw/qedr/Kconfig"
>  source "drivers/infiniband/hw/qib/Kconfig"
>  source "drivers/infiniband/hw/usnic/Kconfig"
>  source "drivers/infiniband/hw/vmw_pvrdma/Kconfig"
> -endif # !UML
>  source "drivers/infiniband/sw/rdmavt/Kconfig"
> +endif # !UML
>  source "drivers/infiniband/sw/rxe/Kconfig"
>  source "drivers/infiniband/sw/siw/Kconfig"
>  endif
> (END)

-- 
~Randy
