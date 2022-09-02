Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8965F5ABA93
	for <lists+linux-rdma@lfdr.de>; Sat,  3 Sep 2022 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiIBWCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Sep 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiIBWCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Sep 2022 18:02:35 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA1F37FA8
        for <linux-rdma@vger.kernel.org>; Fri,  2 Sep 2022 15:01:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so4322770edc.11
        for <linux-rdma@vger.kernel.org>; Fri, 02 Sep 2022 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=X2ygozQyBm6cAvEpqCdHcgYhvvowICsnm856eESGrmQ=;
        b=vre1Hhrq6UWw3Hh93Etn3MOzxkC1ZvC5vOhXnROsOJ5nsy1ykZWNKA99+Bfwmbiq9d
         e7fFjX0wgk+/UcC9AxGqpI5TWjK29dCAJ6lLH/eHlLNi3BIAg1QPClMrtfnFrDg4COLT
         GlJ/wd1OGAcQSTlxeKOCPqboCATFkIkCokOGQjmIM0S+j5glk7LWgL+CImGn88a5M53v
         jBLgJrdz82pLEW1e/0akw6Tursp7SsfP3GDPNi95hCyTCj62FCHjeIc13QX3bU8qiq8B
         wtlhvcwTK+7MkNxcbzo1qBZsKQ7VGaeDnDk/Ba3+obx6tHimrt08e3ZELcsIs5ngyXk1
         T29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=X2ygozQyBm6cAvEpqCdHcgYhvvowICsnm856eESGrmQ=;
        b=K3cLelWQc0fiyqDMw9E8Ds6Nzq268edo8e9WmuuvoqSP6MEBvOjJ5vUSkdoyVAh+3F
         GU3T6cbrD/G/yAHY4lyDXHQZIHojKNiiYNPWGQzgHWt5HyY3AE7XBe0wwb52vIiZWS7H
         Oup903qRCE2O6dERitCjbKO0fUKq4Pazodw6bHuyEfuvZoi37SO8J6hv9TxKlPY5aOvK
         haZ2prBQWjcGdgNen0A2LkUC6fwav+TOCC8i0CuMIgZDOLqczGs/trC5pAaMY9UYAdXX
         YqP53OM2wDZ7hEFUlYiZ9mo95L8FH0qXXt/1Tf9n97x7QC8ikUfeYMLO2URVFksF4zgG
         YdnA==
X-Gm-Message-State: ACgBeo1Z7T9X2j9QJIFQvRXkhubPJqan7t0BN3O0BIVQzp6B3Zm8qIzX
        UmZsyWpoeabO/xXbY6VKb6DDyYm9YF0hLq0xZWyY5Q==
X-Google-Smtp-Source: AA6agR77vJPBFHJS3QcyTB954ZTFsKZTU1n5/3PCkL1nLZl1zyKrPVcFnKQabwIfGKmZC0cwrKkB3EmFnay02jCyXXs=
X-Received: by 2002:a05:6402:641:b0:446:d:bd64 with SMTP id
 u1-20020a056402064100b00446000dbd64mr34562834edx.32.1662156069307; Fri, 02
 Sep 2022 15:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220901133056.570396-1-linus.walleij@linaro.org> <SA0PR15MB391974392E37FF66792171BA997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB391974392E37FF66792171BA997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 3 Sep 2022 00:00:57 +0200
Message-ID: <CACRpkdaseb5BfRebewQ6_4mgu_1nmtLXEvNejSF1OUfuRaNekQ@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/siw: Pass a pointer to virt_to_page()
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 1, 2022 at 3:47 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:

> Thanks Linus! Code looks good to me. For a decent patch,
> add a Fixes line and resend. It fixes commit
> b9be6f18cf9e rdma/siw: transmit path.

OK added it and sent v3

> I also found the description of what your patch does
> a little to verbose, but that is maybe just my taste,
> preferring a very crisp and short description ;)

That's a matter of taste so I wouldn't know what to write
other than that you want less. Whoever applies the patch is free
to edit, cut and write whatever commit message they like.

Yours,
Linus Walleij
