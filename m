Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0B69978C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Feb 2023 15:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBPOgh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Feb 2023 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBPOgg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Feb 2023 09:36:36 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AFC4AFD3
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 06:36:35 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so2251672qta.12
        for <linux-rdma@vger.kernel.org>; Thu, 16 Feb 2023 06:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vssBkC0GvcWgz+s16+7qU86pZwCPBDe4FdQ3pwhKCw=;
        b=haU3Yro2mPjw3+9EioqRSh1p871fvSLTLJyaVugVT7CWjnHkt/og8K+0dL/3XVSkaS
         D03y3bDwyzgzvc/Yhz7zYfokoeoWTJo4BGw/1eTxhU2IPuvyr388ABNsir+0hGvg41tO
         LG/yLdKIv1yMqM2Ilz3274YtRRBheKRaml6NE9SdIcx89Ey0aZGTs9W8AqnUypRXmPv9
         fAxPeBbvvGfMq7PqWIC8Z/cW4sGcNkN9Nv7CMMVnUlT8M5DdAZy7nZmS77qL2aoocBV9
         +Kuo4PZilQSNEzO6eGsWjV830ll37mOG1vcv8ZSCH5F5CNbeK8viMERfdnpT+YR0A3uS
         v1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vssBkC0GvcWgz+s16+7qU86pZwCPBDe4FdQ3pwhKCw=;
        b=1oQzoY0UbFms75cK9tRewcm6dj56LY8nM0de4HsNfTb2PoF2gydywDMYAQRKij4w2h
         jDYF3V1MUzo1I6fNHcoWILQQsodujpTt31fXxf665qxU+37SzPn91jbt9KSfGUSpPaus
         inmZLEFxu/aQtARbi0a6ZZBPy7QD+nI1X/sgLhE9th8ifhKRS8h1gAA4Qk1d3i9Sb2Ea
         sI2LFx3o/fvNg8umFpjubF0iDZrArJ6uIShJC5HSYwdv65ncrhKwLdjRjqQB7pJe/He4
         /WZ1e/M1mLNQdcihAoDEBfzW4CXv8MnuhgSlhm6sJdl/LFSxQ5gIVi3M9zRZutR9V6hY
         OxRA==
X-Gm-Message-State: AO0yUKXrGV8/hOpJsD1WqY82YRwMN6xTqr4c0W/20edQvKoxcdGDa0z1
        tGhoVrjqtD44AXxcKTy1viqUBAD60KIhmYze
X-Google-Smtp-Source: AK7set+Tvfn74VuwrqA/wNXJW8Im+jnpGwjD3oKrcfYmGc0eM3buWO+uoCe9vN01n+q95bwFriUNew==
X-Received: by 2002:ac8:5c15:0:b0:3b6:30b6:b894 with SMTP id i21-20020ac85c15000000b003b630b6b894mr9615855qti.20.1676558194769;
        Thu, 16 Feb 2023 06:36:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g1-20020ac80701000000b003b6325dfc4esm1303137qth.67.2023.02.16.06.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 06:36:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1pSfNB-002TxB-6K;
        Thu, 16 Feb 2023 10:36:33 -0400
Date:   Thu, 16 Feb 2023 10:36:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     kernel test robot <lkp@intel.com>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [linux-next:master 7236/13217]
 arch/mips/include/asm/page.h:255:55: warning: cast to pointer from integer
 of different size
Message-ID: <Y+4/cQRZ0j0sTPGp@ziepe.ca>
References: <202302162019.2WhIRkSA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302162019.2WhIRkSA-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 16, 2023 at 08:31:00PM +0800, kernel test robot wrote:

>    drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_set_page':
> >> arch/mips/include/asm/page.h:255:55: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      255 | #define virt_to_pfn(kaddr)
>      PFN_DOWN(virt_to_phys((void *)(kaddr)))

Er.. Something has gone really wrong along here.

1) The type of DMA mapped addresses is dma_addr_t NOT u64, so things
   like this in ib_sg_to_pages() need fixing:

		u64 dma_addr = sg_dma_address(sg) + sg_offset;
		u64 prev_addr = dma_addr;

2) When ib_uses_virt_dma() == true we should have a function:

   struct page *ib_virt_dma_to_page(dma_addr_t dma_addr)

   That is the inverse of ib_dma_map_page()

   That should be called in all these places. virt_to_phys is being
   used because ib_dma_map_page() called page_address(), but arguably
   this is all wrong and the dma_addr_t should by the phys_addr_t of
   the page and the inverse should be phys_to_page()

Jason
