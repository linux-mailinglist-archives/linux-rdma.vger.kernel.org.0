Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9B51DDF9
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 18:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443985AbiEFRBK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443979AbiEFRBJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 13:01:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750516A072
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 09:57:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq17so15589953ejb.4
        for <linux-rdma@vger.kernel.org>; Fri, 06 May 2022 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWTfFwPUe+akq8O9xoc+GEwOhm09+8e/D5W4UvY4gD0=;
        b=ceuvAqXdWvZeF2C0Y5EDLKK77hsGHUE38ZdM2vcpFkVoxaH8YseTLQnxTfC7bMDIvD
         1kTp25IZh3PciTkBUs79hUfk7bwcW4lK6yeFGtAhg21SmiEZbuqdeo1nDpMVLZhL4Zpj
         tcEZogQAbi8rzX8rgTUf8CXMGeP9r8q6PuGtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWTfFwPUe+akq8O9xoc+GEwOhm09+8e/D5W4UvY4gD0=;
        b=J61+sGOn1HJL8EqQOZmKjLIq7pAlm4VYPRE/k196+ju/S0aI8j7IsDtsszsKAAikg6
         PYu2CQm41gs9CYJY/cmg+qdq1zEXc4DgIciAk+bEV164IYvT1ESKHQvOUr7y5VDAiHS1
         Nj18ljVrrPuqC9h4S2QmhRvK4T1mD/jjzgqpDlVa91KN9JKW6KHIc9EmMvkXDRN0esxY
         w+YHFXqw63FbWTx4XOABuSwihT92Zj5HSWOUT9OMleTitMAUURGfZZYkJlVU/PvbXGsY
         lWtgUfMGpqX465g+eknYJdkAdVu1Ie383kcWgjBpVa8bRzls1zhodVvKlhf3PQi6JeX/
         YdYA==
X-Gm-Message-State: AOAM533efe/dJnlPuKIEg7f29WLkTnvCyQoiLaL6lm9Mr8k1npkftmIS
        IFxtQbC8xTui5vmoiNtQ2WjanrmNQdIi2gImvPA=
X-Google-Smtp-Source: ABdhPJy+9oayneNbqqFHVj7ODlrnQLVWxvJxH93UXQ4tNjf4GC1zt7L7AqIvxflemI20NunHvL/Kfg==
X-Received: by 2002:a17:906:7954:b0:6f3:c1c8:f814 with SMTP id l20-20020a170906795400b006f3c1c8f814mr3882123ejo.230.1651856244788;
        Fri, 06 May 2022 09:57:24 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id m26-20020a17090672da00b006f3ef214e06sm2079070ejl.108.2022.05.06.09.57.24
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:57:24 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so7156529wms.3
        for <linux-rdma@vger.kernel.org>; Fri, 06 May 2022 09:57:24 -0700 (PDT)
X-Received: by 2002:a1c:cc16:0:b0:394:61e1:94f with SMTP id
 h22-20020a1ccc16000000b0039461e1094fmr4204147wmb.38.1651856243921; Fri, 06
 May 2022 09:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220506160151.GA596656@nvidia.com>
In-Reply-To: <20220506160151.GA596656@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 May 2022 09:57:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
Message-ID: <CAHk-=whZZvzpMHPSWSUWV3tq7VEZW_m-SJqwEDMzYVHdYV_UDA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 6, 2022 at 9:01 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>  6 files changed, 92 insertions(+), 103 deletions(-)

I couldn't for the life of me understand how you got to that diffstat,
since everything I tried gave me

 6 files changed, 85 insertions(+), 96 deletions(-)

instead.

Until I realized that you must be using the '--histogram' flag to git
diff. It seems to give quite different results for rxe/rxe_mcast.c.

Better? Worse? I dunno. But it threw me.

                Linus
