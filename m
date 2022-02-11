Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E2B4B2D1D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Feb 2022 19:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352840AbiBKSsm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Feb 2022 13:48:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiBKSsk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Feb 2022 13:48:40 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA0B9A
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 10:48:39 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id bu29so13060695lfb.0
        for <linux-rdma@vger.kernel.org>; Fri, 11 Feb 2022 10:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=2lKmw3BAfK3Hmt1Qrh1Q51qY1plygnjgQcF1MZQIDMc=;
        b=CJGbkNiwqZzOUVigrKqtAzSUuNpT6KY1t/Q3l5akTlj99Nah87oO0tbSySFu/NtCiY
         mQuV7kN58dcGI3AS1XokA9P3pLcyV8lIpi+Fkri+5+bUX59Ep0u3VnrfxAjD3GOxMLDv
         2ISV9vbbB9JGtMBtZuAtrlAz8GpjkGajODVth0A+6furzqTgx4NgVIeTagFLb+k1e6PV
         FO1jymCfG1byu4f0SWySoVRTPr5OjG+z6C4xbi23SVUt2aKZUiZN/BixJ1/xGH3v1N41
         l6diXXCveT91mEpc0sQ0XZ3pllTBRH/reD2BxeLmdQ+7290lFnnbTsurZ4DjmT2sJuoT
         TYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=2lKmw3BAfK3Hmt1Qrh1Q51qY1plygnjgQcF1MZQIDMc=;
        b=lTKHhU4V1tnmS1TjgwYDk6JsopZoKFcqdh2L35s6XurwXjDlh8VONSzUnaXl/oAFYG
         HqImgvzoHgf8IXNPnvW4EzDei3gRP7QaLVODLH30mKNxbVi4oO7zI4Ujwt8hm7WB8BNO
         LeTaLyzp+0kfYuMr5N2MINTjOlJCC+ZNmejRNX9blySwJaFdpoQTcnrG3MEu5Qse8wi9
         iltSrUQVXFZUMlIGGFdUAcQmqwnfxrxGkXprM78hlFjflJBuHAEF9F3oflEG4Qgp5wds
         zW+traKt6PyFNVvb9Pgis+hsjFioVWNxCdJ7aiQQv3s4RoN3wISki96DojOBKzTlJlVs
         8wCA==
X-Gm-Message-State: AOAM532R2hRsiBvRexmLuhpL8eEd7AtnAZK9tlcHRv+BsFaFkw7QpXK4
        F52GheQ+q6duGzM77em7rT/S88uOTYQeVVQPSy4=
X-Google-Smtp-Source: ABdhPJxNXCzGBqlTQD6AWNP27wLEWGFI+f9T2KvJYpNUFK+iZuAMiUIj3fIfSx7e+/+QvaEK3hYZxgBWRh02xbuc8Po=
X-Received: by 2002:a05:6512:1596:: with SMTP id bp22mr2142587lfb.144.1644605317764;
 Fri, 11 Feb 2022 10:48:37 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:43:b0:19a:a3f0:a0af with HTTP; Fri, 11 Feb 2022
 10:48:37 -0800 (PST)
Reply-To: douglaselix23@gmail.com
From:   "Mr. Douglas Felix" <legalrightschamber07@gmail.com>
Date:   Fri, 11 Feb 2022 18:48:37 +0000
Message-ID: <CALi75OqoF4qYNSmPSiY0jYpjaYFv8nY8cAkTGMKJEb3NcwGofg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a retune mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Barrister. Douglas Felix.
