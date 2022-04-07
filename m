Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081F74F87EC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Apr 2022 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiDGTSD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiDGTSC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 15:18:02 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7420B37A8D
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 12:16:01 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id k17so4468079vsq.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 12:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfcE4FqxH5IY2AADBN4I8a9X+Fxc7TeuA+3O2knJSv0=;
        b=jCu1Sp1QrDsxW0xahipvfYuXRa6CZdbPOJ56r9IEwQNJuuo2aA3piDUpCzQjpS2Exn
         QfuoyuMN4Px/H8F+14uC+8JKKwfGxRhtLGj/EGqi6RepT+TjOVHXt88EZ+mUzrsZBCH8
         OtTz9VOKYV2EBuOEDsXfqJ0ewncOxu3PtsjwfuFogFQzK4+MmZp1seFg55vSgWf5JWZ/
         +wW22HtLOip7yy9wsC4lnMsK3ysF+TqOJBLNEMudm2yNUXxiyB4Q/N2Nq8dMEfXozEDg
         imaonN2pwHwe1PvywgivzEZr4BNKBC/RU27e36TbaNwCTXi3p0fciFf3cHEmnwDJ2l00
         dh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfcE4FqxH5IY2AADBN4I8a9X+Fxc7TeuA+3O2knJSv0=;
        b=BY8P/5tU81ofiHCCLHn6QYqFHh1yKicWtuSNF2++eSLgiSTHY6fRD2lXO2cOQNI7y4
         rc5OHmtM+qrz+5FtS/ASM3B9VPr1WhZNHOMECcH1IIKg3/th4P1iobO+JCCN6mQHPchB
         0q5kdrYexQ5zLjMypYiuGptkxsYDH+95nqyDzQPhfb7QBtN65i39tfHJHwORB16Jensu
         KUSEvFXWUxNJ26J/VtmkwoaaSjrj1+esj9MU/MOzMy1c8tf/dyY0fDWari+s/W7ctxrx
         WMiVWeOgTrJAySxRYQjYs8tb7ftq5tk7NyUN9mWPqH4pY+bgFlFpoolM8blkUaFNYkae
         Aaww==
X-Gm-Message-State: AOAM530EL/iquG0EyVvtVpfq6dLnkFjgKcXOUvr2XvNyj3gJvHx8anCm
        p5TKPgwut9jwknpAQmC+sXTel0IOS1+fXk+JmLw=
X-Google-Smtp-Source: ABdhPJxPu961XdJKa2uS6ZmDT8XMCp7yK1k6vSxzBD2JwmCX3CayrphiCpWwKu0E6lBgpMRqpavorlgEWD7fPtZxTMo=
X-Received: by 2002:a67:6147:0:b0:328:1669:86a0 with SMTP id
 v68-20020a676147000000b00328166986a0mr1304974vsb.71.1649358960481; Thu, 07
 Apr 2022 12:16:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs-MT13RiEsWXUAcX_H5jEtjsebuZgSeUcfptNVuELgjYQ@mail.gmail.com>
 <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
In-Reply-To: <1c16f053-0183-8343-9b36-62027c7260a8@acm.org>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Thu, 7 Apr 2022 14:15:39 -0500
Message-ID: <CAFc_bgZ5oYtK2doybVT5fhrU+Ut-RfPT+g2z1bbf9V3jTtRTUg@mail.gmail.com>
Subject: Re: [bug report] rdma_rxe: WARNING: inconsistent lock state,
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bart,

I would say it is very possible. There was a period when the pool
locks were switched to _bh spinlocks but that was later reversed back
to _irqsave locks which cleaned up some failures.
I don't know which version Yi Zhang was using. The root cause of this
bug was caused by
librdmacm making verbs API calls while holding _irqsave locks which I
didn't figure out until later.

Bob

On Thu, Apr 7, 2022 at 1:51 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/5/22 20:08, Yi Zhang wrote:
> > [  296.616660] ================================
> > [  296.620931] WARNING: inconsistent lock state
> > [  296.625207] 5.18.0-rc1 #1 Tainted: G S        I
> > [  296.630259] --------------------------------
> > [  296.634531] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> > [  296.640535] ksoftirqd/30/188 [HC0[0]:SC1[1]:HE0:SE0] takes:
> > [  296.646106] ffff888151491468 (&xa->xa_lock#15){+.?.}-{2:2}, at:
> > rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>
> Hi Bob,
>
> Do you agree that the root cause of this issue is in the rdma_rxe driver?
>
> Thanks,
>
> Bart.
