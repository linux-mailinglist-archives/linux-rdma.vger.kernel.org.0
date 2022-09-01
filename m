Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B45A98F4
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiIANfE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiIANeh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 09:34:37 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB613FD22
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 06:32:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gb36so13835681ejc.10
        for <linux-rdma@vger.kernel.org>; Thu, 01 Sep 2022 06:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GkqcXxkxbiGAUS3mDZ9ZIlXaqo2ypwaG4SLF3IzWGD4=;
        b=tkpJ8P7txLgCLaajgTyWxraKpmNbXD2ahq6miX/0cQFc3LKU8YlP5w+LoFTWnFrfVO
         6yDZzgrZy/mlnubTM6WmNE3Gg8dIXrU0W62XZwsPa/TpuK7QzdU2JYGZIc43/FjL+W+C
         dIjx9ZRnVsHA3w8p0yKeS7RZ6UvAyLDq4bs6/WjQ0JaMb9a0nNuiyzMd0RpPCKfH7w88
         NcZ6N6GM+wioxWFJox4PZT/Bxgq/vErFeHY6dfOupzUPmXNSpR/2p9TkbVGWI5FeBoDd
         MBpx/zeJmfQBdUZZjgNw2H9/AeTHjWtmm4a5/x+RA9DkkH2CCDWDI62VorgsACZe7AOc
         6dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GkqcXxkxbiGAUS3mDZ9ZIlXaqo2ypwaG4SLF3IzWGD4=;
        b=zY5kRB4BDAf7sMlQkeaWJ0+TGUwCtNtOpYq74SFQRsmliEJEQXKZGO3gnCF03Ti8q0
         gQlY6W77jw9AjYWS+CZKTyEDcrJ4mGcQfw1vXuCPiFJs/mREfpQ8gLdHeRmCUkT94GtR
         cGDkBsYvlFwj9T/wljm0jr1UiCNEfIBSKDo3Qgi+B0jwnt5F+sX4Z55iNZn5Aa/iQu3v
         GRFgvxTiOwLZhZdTwu6QbAc/fvUmHHn714JN+j55PucThp2j7TMgzQ0rvnKW6yE/uexP
         Cj4HJIyB7R1LX40hYS+NYA46rIATf/Dy4RCNLZCTgc8XmhvDAYbTl0ICBuI3slbVdrP0
         EF7Q==
X-Gm-Message-State: ACgBeo3mJAprC8yVeq/k28PFqvubvEvdF+XxxOF/WDmsjIuZ6h/Y2zSO
        i1PtzD93baakUDnjHsqRy0V5qaeHjQXIFqI9caWYBQ==
X-Google-Smtp-Source: AA6agR7EMbR1VhzyEbx3KwgyWcAgNnqnpvQizf8d4bjXBqesyVusbdQz6O0joQ2RKwf/Kfu2EXgvGVOlU4GQMZ6WMtQ=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr24160316ejs.190.1662039163171; Thu, 01
 Sep 2022 06:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 15:32:31 +0200
Message-ID: <CACRpkdZd17c-0h=LLep71LEtLtc9iqv54kEMF+TbXx-K5tPcQw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     jianghaoran <jianghaoran@kylinos.cn>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 1, 2022 at 9:05 AM Bernard Metzler <BMT@zurich.ibm.com> wrote:

> We discussed same thing a few days ago - see PATCH from Linus:
> '[PATCH] RDMA/siw: Pass a pointer to virt_to_page()'
(...)
> Could one of you two re-send?

I updated and resent my patch now!

Yours,
Linus Walleij
