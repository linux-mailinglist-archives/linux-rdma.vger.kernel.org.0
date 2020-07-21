Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8232286D0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgGURKV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgGURKV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 13:10:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EDC061794
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 10:10:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so11036395pfh.0
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jul 2020 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijLcrIKdMxEslvD+jmX5vh8r2VprMB5vKT+BEwrD43I=;
        b=jbNCKuWrF3z0Bg7Dr36LnwZDXW3G2F6aP0bwh8/t049mnjHR0d/sR727j+RVyU9jCn
         /TZOB8HyVeohJR6IVzPXUxnyh4swfljxyUlhoVMwi6MxQCDnBEL39kl7XZRO+fgtHlma
         ES8YVwy+jPIEvWcGC2MLxCAbsk+vvEU7aZ1C/Nx8fRYY1UxFn2vMngfQQQ0Sf0xgRP5i
         eSrB6tQDpResfVmJuoLMqySe9Edc287xcCQ5H52DJaWvL/+qd2Lk0VlW7qPOy9xtatZP
         udoLPJ2JA/w214qE6Xfjy0un/BXgwWwuvKZSBawrkikE8DTMNa8R3dvJfZg5AOixDdCy
         R4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijLcrIKdMxEslvD+jmX5vh8r2VprMB5vKT+BEwrD43I=;
        b=OepbrgxxakdPl/jZKIiHed1X7meW7S1e6sm5JXAKnVVnGf0p2r2jwB0lhhKUzfkvhY
         5/y4qGLZXrJXY7p843HVfhmVo6TWfvahCkObNyEZ2PwXq/7PCE5YxBLdrBBon4AoOP9t
         5mpPvxzcwSvKDoyclc8rG9psW5N0u/GohPlpnHoonF4F4Etf/xmzTbxYGofDIrRisOwE
         m7vNOgh0s3GlO4zDBGQPL1Dyi/8t9Y99K41LDr+NvcWdVX+utwXLKi7mVbb6vusx9ltV
         j2hVM1s7HNbar4uASsZ+KdbncHsQ+0WUya//L5Aa6v5Bz/6F0OY9AWiqjV19npTaKrCV
         Be0g==
X-Gm-Message-State: AOAM530OmIkZS/z14DOn6Vg+f/fiyyFCUGv+y5h/imqM9828X2N5+BPc
        j+fhei12USQVFng4OBfzNEok70gOWOIFUkKlFkv0nQ==
X-Google-Smtp-Source: ABdhPJwQ9lHmm0r4hO1qeg0VIz7/oth+VOhLnYujVBL0ZKyRnL5vBI4uz3Q2xi47jPq/DZF1n7mk1Sc8MxtsryVRbWM=
X-Received: by 2002:a63:a119:: with SMTP id b25mr22913481pgf.10.1595351420130;
 Tue, 21 Jul 2020 10:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200720080113.13055-4-galpress@amazon.com> <202007210118.fF0Xv5Jy%lkp@intel.com>
 <99314564-cb73-5a25-3583-1afda323d2b3@amazon.com>
In-Reply-To: <99314564-cb73-5a25-3583-1afda323d2b3@amazon.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jul 2020 10:10:07 -0700
Message-ID: <CAKwvOdns6+LVqLO_aZgXOYi33xskO860=BEU-=Q7c3nGYkHs2A@mail.gmail.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
To:     Gal Pressman <galpress@amazon.com>
Cc:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 21, 2020 at 4:27 AM 'Gal Pressman' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On 20/07/2020 20:08, kernel test robot wrote:
> > Hi Gal,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on 5f0b2a6093a4d9aab093964c65083fe801ef1e58]
> >
> > url:    https://github.com/0day-ci/linux/commits/Gal-Pressman/Add-support-for-0xefa1-device/20200720-160419
> > base:    5f0b2a6093a4d9aab093964c65083fe801ef1e58
> > config: x86_64-allyesconfig (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cf1105069648446d58adfb7a6cc590013d6886ba)
>
> Uh, looks like I use some gcc specific stuff here.. I guess it's time to start
> checking clang compilation as well :).
>
> Will fix and resubmit.

>> drivers/infiniband/hw/efa/efa_verbs.c:1539:18: error: invalid application of 'sizeof' to an incomplete type 'struct (anonymous struct at drivers/infiniband/hw/efa/efa_verbs.c:1529:2) []'
           for (i = 0; i < ARRAY_SIZE(user_comp_handshakes); i++) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

is user_comp_handshakes forward declared but not defined for an allyesconfig?

-- 
Thanks,
~Nick Desaulniers
