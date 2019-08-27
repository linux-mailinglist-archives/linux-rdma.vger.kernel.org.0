Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 696EC9F66A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfH0Wu5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 18:50:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44999 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfH0Wu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Aug 2019 18:50:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id c81so320695pfc.11
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOEu9xUSDVrsGM6W3Flcox0RxExlMvx/ACbW1pnrPBg=;
        b=Usm12moHUHac03LVvijuSRXEZBvccvhXSPy1aGZptmGTyOJlv9HwXwsEHdqFXO4Fjy
         oJjqfDRkaK7VUPH4iq5Z8rILoMIkn6m9JCNM6H4QIMSxqk9jAD+Oevb9x69xcP84m5cE
         Lg2/MGISpiT3slt9ksiZN8SPUlU+UcL8GidncWuemmZCmHTY6Xz7LzvTKno7sCq/IY/3
         opXEgstVYldu6h1foTnU9ujFEcBzuq4MO/iJqviUjNpKDbi0MhWC9y97nLbn5AeFPrEA
         d8+jX/Jck3fmEVavrg9+D004WeqLpMx35UEME4kKaai+EKtaosFbxvZ/UVCMo6Y5HmxF
         RuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOEu9xUSDVrsGM6W3Flcox0RxExlMvx/ACbW1pnrPBg=;
        b=DWLTAvGDblnjTegwJCe86MWjtzoVJh8b0/e+3wTJ+3TdQ29eQSvQHHqg5uZZADHVX8
         TPYQLAI8cj0prfh/do1CaKt6Otn/5j/QEt/BKVoqD5NhMe1dlpvNFviPF5gC3cxPuJLE
         ZgO3DmegtqlX0z1APMY12dTt7EGK0NdaXi0wH000NIheKpjgvu2+xLozSFAqSLAduxzn
         PHAb2DtPKasNgOOMwOFnMYQkUxc3eXywDLo+7ynWqJd4/lnj5PWvOHP55ZWEzU4FWu88
         9ehHbj0SAf/rGi07fRami8fGDy9KHuWe7qCrvOlx6RQAL5Vcqs2USJZGPq93n67GadVZ
         KhMA==
X-Gm-Message-State: APjAAAXl1FNSd8yP1iEibGE6LhzwzwmsrkJU/onGaiJmH+mtuh57113H
        4xD28YehBUS1WlZv9tezRac08vvAwfDtozx6tEnqOw==
X-Google-Smtp-Source: APXvYqw23KIT1k0Xi5MgAknrnDtZVrBXQFptxEYv1UgQ0hbLWHN9Mrvq15ViFtifwG5yvUo07vfeKobCoXeNgNntFxU=
X-Received: by 2002:aa7:984a:: with SMTP id n10mr1036503pfq.3.1566946256177;
 Tue, 27 Aug 2019 15:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190711133915.GA25807@ziepe.ca> <CAKwvOdnHz3uH4ZM20LGQJ3FYhLQQUYn4Lg0B-YMr7Y1L66TAsA@mail.gmail.com>
 <20190711171808.GF25807@ziepe.ca> <20190711173030.GA844@archlinux-threadripper>
 <20190823142427.GD12968@ziepe.ca> <20190826153800.GA4752@archlinux-threadripper>
 <20190826154228.GE27349@ziepe.ca> <20190826233829.GA36284@archlinux-threadripper>
 <20190827150830.brsvsoopxut2od66@treble> <20190827170018.GA4725@mtr-leonro.mtl.com>
 <20190827192344.tcrzolbshwdsosl2@treble> <CAKwvOdk3UTT5jUTuG_wRizdpUtgv3qFB3w3NCtJ7ub5DnptYRA@mail.gmail.com>
In-Reply-To: <CAKwvOdk3UTT5jUTuG_wRizdpUtgv3qFB3w3NCtJ7ub5DnptYRA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 15:50:44 -0700
Message-ID: <CAKwvOdmq3VRLt+SUM=Do7OqasLqzoj4R00-JZGBWFjj8TccNgQ@mail.gmail.com>
Subject: Re: [PATCH] rdma/siw: Use proper enumerated type in map_cqe_status
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 27, 2019 at 2:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Aug 27, 2019 at 12:23 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Aug 27, 2019 at 08:00:18PM +0300, Leon Romanovsky wrote:
> > > On Tue, Aug 27, 2019 at 10:08:30AM -0500, Josh Poimboeuf wrote:
> > > > On Mon, Aug 26, 2019 at 04:38:29PM -0700, Nathan Chancellor wrote:
> > > > > Looks like that comes from tune_qsfp, which gets inlined into
> > > > > tune_serdes but I am far from an objtool expert so I am not
> > > > > really sure what kind of issues I am looking for. Adding Josh
> > > > > and Peter for a little more visibility.
> > > > >
> > > > > Here is the original .o file as well:
> > > > >
> > > > > https://github.com/nathanchance/creduce-files/raw/4e252c0ca19742c90be1445e6c722a43ae561144/rdma-objtool/platform.o.orig
> > > >
> > > >      574:       0f 87 00 0c 00 00       ja     117a <tune_serdes+0xdfa>
> > > >
> > > > It's jumping to la-la-land past the end of the function.
> > >
> > > How is it possible?
> >
> > Looks like a compiler bug.
>
> Nathan,
> Thanks for the reduced test case.  I modified it slightly:
> https://godbolt.org/z/15xejg
>
> You can see that the label LBB0_5 seemingly points off into space.
> Let me play with this one more a bit, then I will file a bug and
> report back.

Something funny going on in one of the earliest optimizations.  Seems
related to an analysis that's deducing that the case statement is
exhaustive (so the GNU C case range is unrelated), but it's keeping
the default case and its comparison around.  The analysis is correct;
the value should never be > 0xF so there shouldn't be any runtime
bugs, but this would avoid an unnecessary comparison for exhaustive
switch statements and save a few bytes of object code in such cases.

Filed: https://bugs.llvm.org/show_bug.cgi?id=43129
-- 
Thanks,
~Nick Desaulniers
