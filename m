Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4223ECC7A
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Aug 2021 03:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhHPBqH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Aug 2021 21:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhHPBqG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Aug 2021 21:46:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD67C061764
        for <linux-rdma@vger.kernel.org>; Sun, 15 Aug 2021 18:45:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x7so24814546ljn.10
        for <linux-rdma@vger.kernel.org>; Sun, 15 Aug 2021 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LF6XItYYVcrsbbclsFDWWYgjBCxXVAUdf3tBYT+hoKc=;
        b=Y5Hz8BhXH41eH8XuU2vv9SpQuTeITFpgj0uYSZqvj8lRsMNn4QI8EZRpCOqUGEt3Es
         orlc3Lq+jlOdizc5kFdKZndyKiUYOClcgN6gLHvmlbIj35NHwgzBDCuJhKZpvvjNLKwf
         WLYj8/Q61a8BLCm7I4AaaNSlgHiDlVVg9rCQi8WjOA+XfiF0VqRGAPkJ7xdCNCzjzUOH
         2JX9X7EBS1fh9elXkDYy6o6XL2f4yO6p4RqfGMa8rjeF8Bwkvl6OvEteFaZhYlAWGOV0
         7a1eyes3a0o0PA1bZqTvaaETR6p4V1wrvAfRlEa1EjCm6HbrDeoSxhzzIbUCAy0r2bTb
         I+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LF6XItYYVcrsbbclsFDWWYgjBCxXVAUdf3tBYT+hoKc=;
        b=G6ZDfV7XlUNPZ+CjDVlBRm05So/1JxR+NsvCOHsaN2URVYQJvk1ymr2yY22dnKaL29
         P3NFPCTwPjX90amQLXBaCQp7K8WhDgYLG8h478jpqium9NyJjy2hXB9UDPeGHD1fWEGt
         a+5vn/5uLI50ZIR7r7tcmPLghmb7SgybG4URRX4ahwYZky+A67clMwtdz0BafGi+P1I7
         IRIrHz7udfFI6ps/c6k0yXwvRCaSe/3lyUC/IEvVOtK93eQg1wLdA1rgXazC9zSQFg3h
         W19YXLRe10r2uZKngSBHivloultX9IRCWWIdXzz1sKJJLhczmvT/EhTGXvhnBR4kKOwH
         jAfA==
X-Gm-Message-State: AOAM531T80p7/UShD53pE5mzhKMTXpDo1sS4GaBqisNFP5kz49lnnvv4
        wb0so0ToKHs/tIFMtuoxiU5hkKSk+JAh2guZ8xe8/g==
X-Google-Smtp-Source: ABdhPJyDssyQQQHX+qWqgDBMPsNnWHzgsufpBidFYCpS9aicJHAGRzhYfSpbrtPEttiiygzyCMotuTiBF+C246eBbnQ=
X-Received: by 2002:a2e:1f0a:: with SMTP id f10mr10584125ljf.435.1629078333772;
 Sun, 15 Aug 2021 18:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210813055729.19885-1-mie@igel.co.jp> <611657C7.1080100@fujitsu.com>
In-Reply-To: <611657C7.1080100@fujitsu.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Mon, 16 Aug 2021 10:45:22 +0900
Message-ID: <CANXvt5pOEetx=8ebkE7FtfFmRDL-XSQB2nMc92YqkHM=JNWg-Q@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Remove duplicate umem assignment
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

HI, Xiao.

> My same fix[1] has been merged into for-next branch on rdma but it is
> not merged into mainline for now.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?id=cdbdb7724740f62d11519679e11cf673cd9d6c8f
Thank you for the information. I had missed it.

Thanks a lot,
Shunsuke Mie
