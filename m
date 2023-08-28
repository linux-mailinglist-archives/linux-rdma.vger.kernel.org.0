Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B015878A9CB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Aug 2023 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjH1KQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Aug 2023 06:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjH1KP7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Aug 2023 06:15:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCF395;
        Mon, 28 Aug 2023 03:15:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso387072866b.1;
        Mon, 28 Aug 2023 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693217754; x=1693822554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzRVOybT33QI7vu2JdztDFH9Ke2YOC6asF182TpGm/w=;
        b=LhCPwqvMFdXx1XkbPsbcqsFolML/o5XImTCJ+xfRi4kOeOVgUb3c00z63yDIAI6Zml
         tAeFvtoBUObAKGvaa7TyDsyx8Uzzwe2oOWNskEEH3e6ZJoyqmoJbS1vcut1ePHxvfT/a
         ieoAO4/MZCtYZiu4TdF9Q7knWzq4feBGed4LyZQva9tFzH60G968ItdeoWbY0GV58p8m
         hsM92u0mXsrKDoO+hMvQrO+O+BJM7tgwr+nFphzXJPAXtLSeHcCb1Mjm8cRSGOpfBTvU
         TCGuo5w9k53cXi6pGx48urGOGIepFaykccfGUaMwsK3eHf3/491BFm9Qid1F87t7Fx2j
         unMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693217754; x=1693822554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzRVOybT33QI7vu2JdztDFH9Ke2YOC6asF182TpGm/w=;
        b=aahNbnqF0l8Zut3ezBkxGUd0jUu9X9edcNImpd2yvps9HZPOn+1tfPbqQ3JrIMKZiC
         XYD754fxzDfojsu/r7GIcp0cW1DEBlE2ffgj6Qcg9ZqotJwaWaGFWrCgwOEJUHHI7SE2
         A9UO4JCsVjSZEhlQMwwkBcZjiSAAarWDWh/Evp/vFXGBwrGpswMbnOrVhdKIn643Egbw
         dHUqg/HjrX1mDJsX/2xXjJ3sswWG8jgdR/BTZG0kupdiPbXwpZPDe1Yuy/LnKHOPBbkA
         i1Uq9kmTfbwY2LzNNL4l1BD05JwbQKIwiLn3Sl9tNqGwFXZl1Sop6KU9VRJvFxB/oTfM
         nZ+g==
X-Gm-Message-State: AOJu0YwxRLBJTEbBWZQg77WoXRvd5EUpDsRqF/jcLwegS2tEoeXGaVmZ
        dlCpr0gVvWENAQ3OG9hhokzgbuvcYAOTCpxCbeY=
X-Google-Smtp-Source: AGHT+IHoQsqsI0N8r7g8SkP77saa6FLX8NcotTr2+CMc5JX1CQzQpblaILnP/0Ud7vKNOXHHppZclu212zQlK9mMq7s=
X-Received: by 2002:a17:906:8a64:b0:9a2:34f:9f59 with SMTP id
 hy4-20020a1709068a6400b009a2034f9f59mr9058389ejc.68.1693217754050; Mon, 28
 Aug 2023 03:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061141.258864-1-lizhijian@fujitsu.com>
 <f3f30d46-379a-8730-5797-400a77db61c3@linux.dev> <87r0nnczp7.fsf@jogness.linutronix.de>
In-Reply-To: <87r0nnczp7.fsf@jogness.linutronix.de>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 28 Aug 2023 18:15:42 +0800
Message-ID: <CAD=hENcu4wKELCt61O+p-RtOpaHHoaAQhr7Ygt9pdr9Hc4s2Wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Improve newline in printing messages
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org,
        "pmladek@suse.com" <pmladek@suse.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, jgg@ziepe.ca,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        rpearsonhpe@gmail.com,
        Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 28, 2023 at 4:56=E2=80=AFPM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> Hi Zhu,
>
> On 2023-08-23, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
> >> Previously rxe_{dbg,info,err}() macros are appened built-in newline,
> >> sut some users will add redundent newline some times. So remove the
> >> built-int newline for this macros.
> >
> > This commit is based on this statement "A newline help flushing
> > message out.".
> >
> > All the rxe_xxx log functions will finally call printk.
> >
> > To pirntk, there is no such statement in kernel document. Not sure if
> > Jason and Leon can decide this statement correct or not.
>
> I also could not find any documentation explaining the semantics of
> printk with regard to LOG_CONT and "\n". I suppose this should be added
> somewhere.
>
> However, the above statement is correct. You can see this in the code
> [0]. All printk messages should have a trailing newline unless it is
> only a partial message that will be appended.

Thanks a lot.
Do you mean "a newline can help flushing messages out"?
That is, in printk, the message will be buffered until it is full or
it meets a newline?

Zhu Yanjun


>
> John Ogness
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/printk/printk.c?h=3Dv6.5#n2254
