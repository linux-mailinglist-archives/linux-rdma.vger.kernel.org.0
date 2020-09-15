Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FEE26A579
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 14:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgIOMpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 08:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgIOMpb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 08:45:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D13C06178B;
        Tue, 15 Sep 2020 05:45:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z19so1854512pfn.8;
        Tue, 15 Sep 2020 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLvKC1QgKkHaTyoOvehGhV+Ht6Yp+maIHFDFeeVXq8M=;
        b=U5TrWgn8lEBzlVwpiipMur62Lm5Vpbnbt1ijTULCsAAOrzIK9+Qm69Aggok2xEYHxb
         /vCWXARkKZO26GJYPXyLmoK7V+Gz7n0GF2xhC2pveIV9XLUAihKLvURt28xed3TWUynR
         7QxCO3GYgw1aG+Cu9NDkBPJ91F40lhlwdlFghCore2RpK8gnmCKyfr8LIy0gaFdG8xHQ
         /mzbSYdzlu3860JCuALGlyHW0n5PJBNnUCoTEQ8OnVFyVSbcgd4HIHr6A4Zao0TR049m
         eipWdvq3ZfrurEIRpiWgmsWIL5Tnd9Ha7KTwwh0ffyclogguk8QELt3fSpxMQzoE09TR
         0QWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLvKC1QgKkHaTyoOvehGhV+Ht6Yp+maIHFDFeeVXq8M=;
        b=iIgWKC2Cvc/At6hkgdYzWAy/TmZCMDBNW5s7nuEGKtGzJtdwoNNmyCiOc+QqyZ4t3l
         KqUZbzVekPMNKfFSJgrEERCc5x6dOZw0MbAA01N4erRcA1tsKeXwjXXTSDQBkAlsRbq3
         lX3DxYwIK6N9CpiTtZmtAhtyepjKcqQa3QPiLnxf4RM/2Kfz+9YJP5+W+NXOMO694k/h
         YaUz2KcVZUn10Oevlg/6dn2+KGzsSzD0VgxVYDKsZbkj2gbuGvT8mN0GrOsLjnaqmYjI
         ZtOAC/xaOaWcBCjuU7RMjASzgApqCgOYy6+BLyi7GsbEgEDkSX+7ojTcDXHBP608/era
         zd3g==
X-Gm-Message-State: AOAM533YOuf84krH6e7XDYnQoM289hX+raGsYRXtNGqVRIDLd40celLZ
        rmsc9rN6sC7jLg1ZbqeQXRsDIv6aff3KK6J7OeI=
X-Google-Smtp-Source: ABdhPJwGJUPVEVWbhzPPDlRLJ7w8+OtzA3zxmhxY9wEbd9cZp9qKfZZDo8HrD5NKHnTBl9DAZ+5l7JvG+cRpReQFtFE=
X-Received: by 2002:aa7:9e43:0:b029:142:2501:34e3 with SMTP id
 z3-20020aa79e430000b0290142250134e3mr1632591pfq.60.1600173924139; Tue, 15 Sep
 2020 05:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200915101559.33292-1-fazilyildiran@gmail.com> <20200915112341.GU904879@nvidia.com>
In-Reply-To: <20200915112341.GU904879@nvidia.com>
From:   =?UTF-8?B?TmVjaXAgRi4gWcSxbGTEsXJhbg==?= <fazilyildiran@gmail.com>
Date:   Tue, 15 Sep 2020 15:45:13 +0300
Message-ID: <CAODUWC5j9VZYedQ620RvunxHO4AnaQokhGniT4FgPyjE=Vzgjg@mail.gmail.com>
Subject: Re: [PATCH] IB/rxe: fix kconfig dependency warning for RDMA_RXE
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Steps to reproduce this for v5.9-rc4 on x86 machine (using make.cross [1]
to cross compile for arm64):
1. make.cross ARCH=arm64 allnoconfig
2. make.cross ARCH=arm64 menuconfig
  a. Enable NET
  b. Enable INET
  c. Enable PCI
  d. Enable INFINIBAND
  e. Enable RDMA_RXE
3. make.cross ARCH=arm64 olddefconfig # WARNING: unmet direct
dependencies detected for CRYPTO_CRC32

[1] https://github.com/fengguang/lkp-tests/blob/master/sbin/make.cross

Thanks
Necip

On Tue, Sep 15, 2020 at 2:23 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Sep 15, 2020 at 01:16:00PM +0300, Necip Fazil Yildiran wrote:
> > When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
> > following Kbuild warning:
> >
> > WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> >   Depends on [n]: CRYPTO [=n]
> >   Selected by [y]:
> >   - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT || ARCH_DMA_ADDR_T_64BIT [=n])
>
> ?? how did you get here? I thought the kconfig front ends were
> supposed to prevent this.
>
> Jason
