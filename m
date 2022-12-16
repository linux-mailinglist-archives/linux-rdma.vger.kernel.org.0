Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669BF64E7E6
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 08:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLPHq3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 02:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLPHq2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 02:46:28 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EC1A80F
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 23:46:27 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3f15a6f72d0so23127667b3.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Dec 2022 23:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ARIVIEhVzMm1WujOb1fU30+/MTpfDpTpcOdBHHIxXDk=;
        b=Z5PSY+rr0YZJxo/46BRMCBdB4+s9PPJNaHDSr458cvabhd/8lnV55pEzoVPmA8SnhX
         70edyROSqmwWqi0xkou5GKw2I12PGy6+CrstPQ00LQcsLJLV7tqSOnu6fc17gggNY2l3
         DX+XP0IImJ8Iaf7zwKbZMBQ82m2WLv1jLwOxCgF5OXHt6+egWBzxB88wxhf08y18dEvd
         S5+4YXDkf9TKmemBuMSui5mAjqx3XulBR/HwoWjz+kQyyOQZq5ARw3Ys03j0GL+pW6fI
         lq9uNEZUjqE1p+OmlTyo1rKgDlXERWBfduoYdOscFhvrPzsTpPRfrpliARIg3X1kjxG4
         dhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ARIVIEhVzMm1WujOb1fU30+/MTpfDpTpcOdBHHIxXDk=;
        b=xgzXee9lcEi668fGAbMOCMU4HlacHkJ9cMR3TRnHs/RImM87CO8AGNKIR3GXWrasl4
         lwCAfspn/bqf3syQB/oscQ/qtriuPitdSfCHivVlJVZi8gC/6kB6HS0bIg2Mcw7ouPXs
         jOhZwoZKNLIA4IMvcLQ6gX7u6wz+I3frSQQur238jQQT1A/gD9YPLTUO7Ddvo49kak2P
         Iqlm5iBDxLoY7UqadplEiP0sqlE1hJWGKtGHuFpR+z1qOmAGUkNN/hhhiGqwq/cwpY0j
         KZmfGWepO/xOnb5WLpX+S/pVqhY30Pm9Pmr1jD+7l7QNKVea2BQe1iEGbcyqHmjbSxjs
         WBzQ==
X-Gm-Message-State: ANoB5pmQqAvIY8Y9NESkOljPMRvdanJSus7929Sdg8p4IMw6fUsh5a8x
        8njoqqbIA2qv1bZhjXVTRwfr+/2FtZ78hDZRfMoAZA==
X-Google-Smtp-Source: AA0mqf6Hom5y28YCRuuXJUd45mqxKlr9fHvmLaBYR1OjpL6PudA+t7yhbCi5diIApiEcgIqa90KLoklYtPsFdIZARjc=
X-Received: by 2002:a81:6fd5:0:b0:402:3dcf:a262 with SMTP id
 k204-20020a816fd5000000b004023dcfa262mr6776445ywc.31.1671176786835; Thu, 15
 Dec 2022 23:46:26 -0800 (PST)
MIME-Version: 1.0
References: <20221215170347.2612403-1-arnd@kernel.org>
In-Reply-To: <20221215170347.2612403-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Dec 2022 08:46:16 +0100
Message-ID: <CACRpkdZf15MxtqpTRVq6bYwZoCM6dTFJc2khRt=+cfxf-sOnow@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: fix pointer cast warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 15, 2022 at 6:03 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The previous build fix left a remaining issue in configurations
> with 64-bit dma_addr_t on 32-bit architectures:
>
> drivers/infiniband/sw/siw/siw_qp_tx.c: In function 'siw_get_pblpage':
> drivers/infiniband/sw/siw/siw_qp_tx.c:32:37: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    32 |                 return virt_to_page((void *)paddr);
>       |                                     ^
>
> Use the same double cast here that the driver uses elsewhere
> to convert between dma_addr_t and void*.
>
> It took me a while to figure out why this driver does it
> like this, as there is no hardware access and it just stores
> kernel pointers in place of device addresses when communicating
> with the rdma core and with user space.
>
> Fixes: 0d1b756acf60 ("RDMA/siw: Pass a pointer to virt_to_page()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This driver is a big confusion for me too.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
