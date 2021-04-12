Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0C35B595
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbhDKOJ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 10:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhDKOJ6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Apr 2021 10:09:58 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE2AC061574
        for <linux-rdma@vger.kernel.org>; Sun, 11 Apr 2021 07:09:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id x2so10902775oiv.2
        for <linux-rdma@vger.kernel.org>; Sun, 11 Apr 2021 07:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjTFlrGjFEXmk/rywniiPq5DECbZIerfKG/0gr/ohVU=;
        b=F3B5FIAyiPiq9iSSu6Nx6FGEskBAUpj8uboFWxrz73LyKeM1tuYLfvtN0Nh/N5GIpz
         UzqNxwXIEXRYKmTlVbi4i57xrPX+eUuh34Y8wpLA1VVYytMuhYS5lcEZh4g8hLZEwp1z
         gELQcFrb9A84T6tco8BbN76/cjmvL1iJDCVICKDyv2PgviBo3rNqJnraBrDdzSlUIAYy
         bcFkY/tQQdznEljKbTdaitax6RUBboA8NCOaMUWEVpdbEf+7vmly5jBOBECzRRov/XN1
         bP5UGhUhrgy3mmCjR1jSnRMFUpA97sYeNcEOFvYvwDNB9lYARzbw0apOt4oc7ibzhV7d
         n2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjTFlrGjFEXmk/rywniiPq5DECbZIerfKG/0gr/ohVU=;
        b=Rwc3rya15zHTTsYIDB5kJU32b0l+RsW3T/lM7M+ZkkjKIJS/dcJdfnmYHM3MoOlJFq
         t3CS2/+n39Dhi2U5TdyXPxhJD6b6Y+3MkRcXwegWmaKFtMo8FhUITW0IpvBHzrYOfWEH
         hA/Uq/fgGUL/Zbpos7rMOxS66MCoxG1OrgR0O993AEw2Ks0SGcKo31G2BiLFqUffLpKZ
         923wSNMwCVCtKGgGrGlX1FrxMz7quaie5xUvBwk5ucqz2oi4N7BVk5Olhj8bMri6C24/
         nnqDJ/RsaYBW752OWk3ym1FwinOHJ5CyBYBeU6zlHV2khrm89/AkcFDgK2EjZr01bZtO
         Ptnw==
X-Gm-Message-State: AOAM531ST9gbRxCyeBW1x6Ew8tMAdJO2ztvZzccBp4tv9dbvLtb1VYvh
        PDcB7jhA1p6g6kPhNVepeIuaQX8yoAwEhMq7T74=
X-Google-Smtp-Source: ABdhPJwc8Pyor7arM3ELnIv8tYDNYKX4kE7aQZTPuvwrky8c2r1rwaJ4k9T3AjqJZuK9lYVbhEM+rRQLLzBU6U0FTX8=
X-Received: by 2002:a05:6808:1cb:: with SMTP id x11mr16220197oic.89.1618150181568;
 Sun, 11 Apr 2021 07:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210326012723.41769-1-yanjun.zhu@intel.com> <20210408183359.GA676678@nvidia.com>
 <CAD=hENehGzGn=nxNO0B8u=nevFx1CGsiovxtir3OCZ2ffVB1gQ@mail.gmail.com> <20210409133727.GX7405@nvidia.com>
In-Reply-To: <20210409133727.GX7405@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 12 Apr 2021 02:34:12 -0400
Message-ID: <CAD=hENezZFODi2m+3syBf1MCyn2mves=EGdYp4sDH0MrUStHsQ@mail.gmail.com>
Subject: Re: [PATCHv3 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable set in cmdline
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 9, 2021 at 9:37 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Apr 09, 2021 at 10:36:42PM -0400, Zhu Yanjun wrote:
>
> > > What is the actual symptom this patch is trying to address?
> >
> > This patch is try to fix the problem in the link
> > https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
>
> you should ignore the -97 return code when creating the UDP v6 socket

Got it. I will send V4 for this IPv6 problem.

Zhu Yanjun

>
> Jason
