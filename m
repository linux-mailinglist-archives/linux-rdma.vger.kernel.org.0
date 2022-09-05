Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A565AD21A
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Sep 2022 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiIEMHt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Sep 2022 08:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIEMHs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Sep 2022 08:07:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B27402D1
        for <linux-rdma@vger.kernel.org>; Mon,  5 Sep 2022 05:07:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e18so11099624edj.3
        for <linux-rdma@vger.kernel.org>; Mon, 05 Sep 2022 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YXgDGnGPbcMXwq+a4S/pdsy0ebtRyj+q+fEdeo0JA9k=;
        b=kfMNXOEugqSCXjioLZtKkqItgxpYwyqzJb9sjpze4u+5yJqZ7Oz759AvYnLlivm5PX
         A0D0s+Jymm07dN0/9RONc7YoN5Zo6nW3DR+GgUXEFqWuWQjXZXmevE6cyJYK7slFGRZs
         FXMJST8TBaQJiXLww548Nj8+i1cQtrKjSDzW3N4cU7gDnmogu4MIUaSozTe3P/dQfjs7
         VRwlINrgdbtuImc+xtYm77UqPfNTLNTHXeZ70SUFqEEJSEi6mUran7u6c2122/Jv6GAW
         pUKiriD+GT6Q3UFTIBqP2phpJMb7MUFT7cIwEAU0kRuRCUW3ADdfFJ5KF309goBqg6ZE
         ze8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YXgDGnGPbcMXwq+a4S/pdsy0ebtRyj+q+fEdeo0JA9k=;
        b=0uJo84RpgHNw+nNPE95+r7q8TZo0DqTiBRADUNfBgeYD/Qum0dt4vWeDi7stWpCldb
         3xVVUqwVUjEUpC2+9i2UHemwLOD5FhtBX3g0H6c6Tu0kh1GgrSLSF3jRrdkP5SnJ1/l8
         /HufbR+8qHTS5yQWJTok1JPYU9vKFcGbBHk2fKrsBlF+6Mxw09+dODGhUwdHf2d5geGJ
         b9rddA/K73CD05Ej4aPMkspQ69nQUMqqqlHP8j6Tu2Mrwvjv5x1I7bF6NhnMRaOxP7EE
         cIl08HL0Yn48Dvj+njvxEadZK0Zrcl+gI2VsX8SxhTW8/P16hyOyxFGBaLYT8l92IFUr
         Py3Q==
X-Gm-Message-State: ACgBeo2FIX9fJQNWBot+s+9USCSZZdjXMr7JlT9KrGeTeUfhyQNI2J8e
        sHhpz/gX/zeAC3jgLR+CVT88rgZy3c0mpQPtOLHu7g==
X-Google-Smtp-Source: AA6agR7NYRPDcM5iX9LkGjGSDJzSFC5i+2F8xe5HADECeTMhas075IgtSAnFdl+Q0LHSPS1aKL87xKzQX6b22BB2QEs=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr7327495edr.32.1662379666280; Mon, 05
 Sep 2022 05:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <SA0PR15MB3919314166F86C36B564961E997F9@SA0PR15MB3919.namprd15.prod.outlook.com>
In-Reply-To: <SA0PR15MB3919314166F86C36B564961E997F9@SA0PR15MB3919.namprd15.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Sep 2022 14:07:34 +0200
Message-ID: <CACRpkdYRvncv=CL_Jrsy5enTvaOeMpwCG+ssq17J_=2xrg0mWQ@mail.gmail.com>
Subject: Re: Re: [PATCH v3] RDMA/siw: Pass a pointer to virt_to_page()
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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

On Mon, Sep 5, 2022 at 2:02 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:

> Can we easily fix the two line wraps introduced by this
> patch? Without sending an explicit patch on top --

Yeah Lean can just augment it when applying.

> I'd
> suggest adding just two line breaks to it. I'd be happy
> to see siw code continues to adhere to the 80 char's
> per line style.

You will be fighting an uphill battle since checkpatch (which is
what we use to check syntax) now accepts 100 chars/line.
commit bdc48fa11e46f867ea4d75fa59ee87a7f48be144
"checkpatch/coding-style: deprecate 80-column warning"

If there is infiniband consensus to stay with 80 chars per
line, you should send a patch to checkpatch so that it
warns for this for patches to drivers/rdma.

Yours,
Linus Walleij
