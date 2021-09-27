Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F73341A183
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhI0Vvo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 17:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbhI0Vvo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Sep 2021 17:51:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96149C061575;
        Mon, 27 Sep 2021 14:50:05 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k13so5662174ilo.7;
        Mon, 27 Sep 2021 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tikSQPAyzklwRveDS3Z5YihXzUXmcK3zSUGwoQRh0mc=;
        b=WCJ5uXuAys8JIc4FJY6+TyBLOu0iSZALBoDMh0XWbTcFi2aJIETo/yqf/AjfnKtxnn
         0FmAeBYXE43yDnmGh9+2yI8bTsS2TUpfLqJj3PpAWGwH4bvr76+eM6jXCTkqJwsTU4ah
         s09X8BGtUm9sz3QLPJT+w6fBCYO5NRCjdqFWRY7Jb3kQ/2d9PzKi1CxLJpg/7IXjXfAf
         zvkPACfIKQcKMjSZQS2htY6U2oN2RappU9rck9T9eC84EV80vWi7kGFYXT4PdfqI5pbk
         u2Zt5JCsvKsQiinEpuDKtzunYtNGHFd6GPeBbz8+FdOso5NcIf8yK5JWXcHEfJnx2ii+
         RR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tikSQPAyzklwRveDS3Z5YihXzUXmcK3zSUGwoQRh0mc=;
        b=cUogIRPQNUy2CVIROWSQiPp85C6+KpGmo3A4WDpBdOjM+fR6HJTko1UeEK3iXBVu80
         C4I7WH6XoI0qSI5IxJnJSmdQC2Ju1LMEuN/SltxxVbKiSN7WcpNA0/Mrs+hxRMG75Occ
         N7feb+Iq1k1l1YBIrOYGbbQXnER1I/V/lGPiN2T4TBD3l3M/Chi6fN6Lhr6Pm0Lc/+n7
         mSoCv73P9Mm94Cz9ygZd3HFENs2J/h4kga9iSeYO6DUse6RexdrgdyRk40dPcYoKV6hw
         sg9Bw0LoZ6RppvbKlQw/qsoGdbBFEJjHAQENwKc2Xps4JBQBvs6ckYbNSSiTan0pV/yy
         hUOw==
X-Gm-Message-State: AOAM530Xahm4r4ILXFoegdnm8aRYuKuS2CWOL8DgSBDGyLwH9dM6bpbv
        5cPCUdJy9CQYUKyLAQj4xoMrb3cxmXvvpvvJUyI=
X-Google-Smtp-Source: ABdhPJwI1HhPHfNS/jXu1lg9HT/GpcVmrGU610X6rk5pu8ryCEJDbylB19fni9LnAz0JzfBioEfmzzvsqBecthg6Ss4=
X-Received: by 2002:a05:6e02:1a46:: with SMTP id u6mr1723814ilv.214.1632779405064;
 Mon, 27 Sep 2021 14:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
 <20210927214715.GE964074@nvidia.com>
In-Reply-To: <20210927214715.GE964074@nvidia.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 27 Sep 2021 23:49:29 +0200
Message-ID: <CA+icZUW3=-FiUebSEsqgBQcHGrk=ket906V9mAqd_COJAmTDhA@mail.gmail.com>
Subject: Re: Linux 5.15-rc3
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 11:47 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Mon, Sep 27, 2021 at 10:48:42PM +0200, Sedat Dilek wrote:
> > [ Please CC me I am not subscribed to LKML and linux-rdma ]
> >
> > Hi,
> >
> > with CONFIG_INFINIBAND_QIB=m I observe a build-error since Linux
> > v5.13-rc1 release.
> > This is with LLVM/Clang >= v13.0.0-rc3 on my Debian/unstable AMD64 system.
> >
> > For details see ClangBuiltLinux issue #1452 (see [1]).
> >
> > The fix is pending in rdma.git#for-rc (see [2]):
> >
> > commit  3110b942d36b961858664486d72f815d78c956c3
> > "IB/qib: Fix clang confusion of NULL pointer comparison"
> >
> > Dunno if there was a pull-request from linux-rdma folks.
> > Cannot say if it is worth taking this directly...?
>
> It should come as a PR this week, I don't think we need to do anything
> special urgent here, do we?
>

Personally, I am fine with this.

- Sedat -
