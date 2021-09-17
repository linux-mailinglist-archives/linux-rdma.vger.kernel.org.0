Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A140EE8E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Sep 2021 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbhIQBDX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 21:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242049AbhIQBDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 21:03:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56D4C061574;
        Thu, 16 Sep 2021 18:02:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id u18so8032452pgf.0;
        Thu, 16 Sep 2021 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7ViJaBJNpRfbfuMpbATKW6jynZe2aCXuCQBXD5sfI8g=;
        b=IzrUyOn8ozBvh3mzSzd/0iEnjoDGaRKPXyeVGitJncJYS5cUlmuZnAplug8kes9D5h
         648XwhkCOXgUHeCnKJFHLT6tUtDXAlGbdoMB1d+AycfH+6/ajaAaVYHd1n3O3WuOHNN1
         JHE86rqIu3AA80YeX6Hg9qa4AUaAIXbbE1di8R2882xX8/s+uHaWPTLT20rTt/AlLTxh
         fTkZJbYYF8r2X6hfYajyr+LqL0iTmjTDeiYRe1/Y2CBjvuNNQH2aoMrCl8XDIx/yhYUj
         z8mlQDX44l/qjW9NuAw9zB8jUtKPKODAVg3vC2yqd7HVsuqVF9E4iS9qxCMlcE5JDzGL
         t/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ViJaBJNpRfbfuMpbATKW6jynZe2aCXuCQBXD5sfI8g=;
        b=XgqSAw2SCBz3Qa5cOc5odnu3nQI2jz1y8Tq4uEg6poPJUWK+lWgjfOHF2HVSgQjKRh
         mC/kTRWiaiaK0rCAU8kbPkxlpljTJZlN9HnNjS93wXfVqK34N2ugt7/tGOUsJux+53OF
         rPGrjL+wcGqZtOsFgZUDqyM39z8htuX+4YRHKVZvIAPOiec2IfaBqZXV802zF3bKYb8P
         EGGbeUP4gXPFit+AJhvR95WStwH7E4cPnuYVTHfBVSQmXQgZBAeYHV8ihUsWT759b8Uj
         I2Gs/NExgTPThjhGCfRDDGDDHheVpooGuGxXNLl8uM2WdbTpZzm1l9jhV5Gmgnivrudk
         pdPg==
X-Gm-Message-State: AOAM530f2y6VC3viH9QeqcovlUlt7eOnv0oH+WQkVAriQ2+BDT/DC42r
        F+jJRYkEHDFAW3F6fo4HDd742L23x20htVd3Cmfot6iZ+EZNBNU=
X-Google-Smtp-Source: ABdhPJy4hjm/yVEdp94VuFLxqRMzn14K1593YBvsPr2Fpfahmptfa3e270Mynwr6q9JH1QqT9v1kjQTtQ49Nlm8b5BM=
X-Received: by 2002:a63:e04a:: with SMTP id n10mr7354882pgj.381.1631840521131;
 Thu, 16 Sep 2021 18:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <CACkBjsY5-rKKzh-9GedNs53Luk6m_m3F67HguysW-=H1pdnH5Q@mail.gmail.com>
 <20210413133359.GG227011@ziepe.ca> <CACkBjsb2QU3+J3mhOT2nb0YRB0XodzKoNTwF3RCufFbSoXNm6A@mail.gmail.com>
 <20210413134458.GI227011@ziepe.ca> <CACkBjsY-CNzO74XGo0uJrcaZTubC+Yw9Sg1bNNi+evUOGaZTCg@mail.gmail.com>
 <20210916183518.GR3544071@ziepe.ca>
In-Reply-To: <20210916183518.GR3544071@ziepe.ca>
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 17 Sep 2021 09:01:50 +0800
Message-ID: <CACkBjsa3Fqkp-OkHFQ0LCL+VbP2H3xvpaArFkTPsdw8Cka27sw@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in cma_cancel_operation, rdma_listen
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leon@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B49=E6=9C=8817=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Apr 13, 2021 at 10:19:25PM +0800, Hao Sun wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:45=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Apr 13, 2021 at 09:42:43PM +0800, Hao Sun wrote:
> > > > Jason Gunthorpe <jgg@ziepe.ca> =E4=BA=8E2021=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:34=E5=86=99=E9=81=93=EF=BC=
=9A
> > > > >
> > > > > On Tue, Apr 13, 2021 at 11:36:41AM +0800, Hao Sun wrote:
> > > > > > Hi
> > > > > >
> > > > > > When using Healer(https://github.com/SunHao-0/healer/tree/dev) =
to fuzz
> > > > > > the Linux kernel, I found two use-after-free bugs which have be=
en
> > > > > > reported a long time ago by Syzbot.
> > > > > > Although the corresponding patches have been merged into upstre=
am,
> > > > > > these two bugs can still be triggered easily.
> > > > > > The original information about Syzbot report can be found here:
> > > > > > https://syzkaller.appspot.com/bug?id=3D8dc0bcd9dd6ec915ba10b335=
4740eb420884acaa
> > > > > > https://syzkaller.appspot.com/bug?id=3D95f89b8fb9fdc42e28ad586e=
657fea074e4e719b
> > > > >
> > > > > Then why hasn't syzbot seen this in a year's time? Seems strange
> > > > >
> > > >
> > > > Seems strange to me too, but the fact is that the reproduction prog=
ram
> > > > in attachment can trigger these two bugs quickly.
> > >
> > > Do you have this in the C format?
> > >
> >
> > Just tried to use syz-prog2c to convert the repro-prog to C format.
> > The repro program of  rdma_listen was successfully reproduced
> > (uploaded in attachment), the other one failed. it looks like
> > syz-prog2c may not be able to do the equivalent conversion.
> > You can use syz-execprog to execute the reprogram directly, this
> > method can reproduce both crashes, I have tried it.
>
> Can you check this patch that should solve it?
>
> https://patchwork.kernel.org/project/linux-rdma/patch/0-v1-9fbb33f5e201+2=
a-cma_listen_jgg@nvidia.com/
>

Just executed the original Syz prog on the latest Linux kernel
(ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915'), it did not
crash the kernel. I've checked that the above patch has not been
merged into the latest commit. Therefore, there might be some other
commits that fixed that issue.

Regards
Hao
