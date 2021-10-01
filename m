Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCD41F16E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Oct 2021 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbhJAPq2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Oct 2021 11:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhJAPq2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 1 Oct 2021 11:46:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E0CC061775;
        Fri,  1 Oct 2021 08:44:43 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i13so11011305ilm.4;
        Fri, 01 Oct 2021 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jqe6G+RxeN+0BQAUW2ZnGRw47yGNXZWVfO1Qg7DdDIA=;
        b=VTbZeN2++noIRr5Q3U/1u50CfNgnsNrjRR4NMCRqamavXNKWCXvH5R+w6DIpXO6dba
         ZFRcpYNmFCOwQb4CzYMDA7Q4vvN3TS8RRMv1k1SD2WTfUVbBdV0QEsr5FNhzJlFEhRoG
         D4heFu5/N18KK6diOyUAaVCX8OyY+FW2CnVdlayzHqcOtqefU122VW0RHnMmKAO/KgE5
         GVfcuKInIJBoLtRe9c7mWHQeYfMG5pGbGQdT+lC3bpGs8aGO4PebEluEIR/u7oqYm0Dt
         aISAhtE7Hlo616NTQuAeUNM3mYwh4mh19HEOqxJaVInoNgN4kscdWeyG5xoa+Zuyo9vT
         sE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jqe6G+RxeN+0BQAUW2ZnGRw47yGNXZWVfO1Qg7DdDIA=;
        b=TuYORm7btZbFdjqvtbZTCgn7dppzYiJglu8wDJC5J/ruGB73EghBvtqxzC2Nk/knOw
         Q3ctdEBfoxSfBVtrD5VQSCfQdjZkXHG0ftoj+n5cwzE2YbPXKbQEBne1WaRcLVJCm/ew
         Ct/70D9ub+V0jYVJvfYuNgi6bGRuo/5skZo1M4ZEgrqI1rLoc2E1USJgaqdaQNU7dP7O
         /SMIIzw14VEkTQe5o7EnDvhuB7HDFT04mENTA9G70GffTgDMXIPqF84ZeqZv/A7wTXKX
         lt78HVCuUOxRRXSIXjsw78IxU/8AQKm5VRRerMI/FlV08yuYjCQNsyV4xH2QDl6Y3fnt
         imig==
X-Gm-Message-State: AOAM5305ir2vwzWgbSQyJaN3wV45UWsfPOvjkJuI7Os9tOKhOKy3ODi+
        3dxxcJ2cJ2SsLNdsFh03EejF3HdLmNxWNpA/eRk=
X-Google-Smtp-Source: ABdhPJwWGZxblICOjXvnFDbNPoZLCwIaabQrx7fMZxWYWPD3BnV6tO3eyOrlfShjqOjI9tOg3Q1oLixsZncTerHuquo=
X-Received: by 2002:a05:6e02:1a89:: with SMTP id k9mr9320598ilv.77.1633103083103;
 Fri, 01 Oct 2021 08:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUuacTuaWXopzH_YC3pCa3FPB=GReJ6BwE5zJ1j2WB_ew@mail.gmail.com>
 <20210927214715.GE964074@nvidia.com>
In-Reply-To: <20210927214715.GE964074@nvidia.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 1 Oct 2021 17:44:13 +0200
Message-ID: <CA+icZUUEmCR25dPfK16JB2V5wJfkuDLj3Dm+_BOAsfn_vUPRBw@mail.gmail.com>
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

For the followers of this issue:
Commit is now in Linus Git.

- Sedat -

[1] https://git.kernel.org/linus/3110b942d36b961858664486d72f815d78c956c3
