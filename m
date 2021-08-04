Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5013DF92A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 03:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhHDBKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 21:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhHDBKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Aug 2021 21:10:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66EC06175F
        for <linux-rdma@vger.kernel.org>; Tue,  3 Aug 2021 18:09:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w6so966814oiv.11
        for <linux-rdma@vger.kernel.org>; Tue, 03 Aug 2021 18:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KhCEqoK9PozD4lG2vOd8B030yK5msuNRjt2qTmRSzHk=;
        b=c8b/FUHTPynmJgIk++iy2aLEW9EEbo+LidjZwZ25kLk4OxxvNLzSq1fGtokahkz59Z
         Hoi2sSSBb53oZinmBn/GI/wLf3P+hKqrUYPhAlhrVARm1eZ+GjKnGgCU/HLLhQLq7yI9
         C9yMAzpY37xLayIkHBXloQoM5by/WzlxEgM/4VZDLnNu2h3P7rQJW83qFheVRHpUSs7J
         BeNB2trAEGVN6grG8FMBq22hNjR0ZnfJXITVEsgJMnvo+OSelcS7nofjM/ZC1LLwzzcs
         lbsnNyzTuCv6U40vUo1WSKaZ++3s5JuWH51MO4acT+ss8mvIxzWeyrMVj9cQEqYZwN5G
         XoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KhCEqoK9PozD4lG2vOd8B030yK5msuNRjt2qTmRSzHk=;
        b=j7xP/ZdhT3coHS6fFInZEsibOby4pE1GIzT6OMXaV2ZlYhggdPHJnO7p40VkaKumNl
         6ltydmary96crLRNHRcK+u9ZIGq6eJsBQ0NlBlsdHCTAkh1jLnuqecc/F0je64O0M8aA
         WqqDXZJPB+DP362oOq4LdtAIo98R2yXEIz9uPVuGtpwaQPhQIQ/RxnofJrCUQR7iSTZF
         zCHsDPfnqn0AzGAaMyiZv2zHWaAcCnJ/B6NWZisPtKEGc+J7LSA9IYUdM6gZy4dnEtIE
         2GaTlsHDg7/hobCcq5iJqehM9YyFXWbOM5Hp5eaC5r+/FASy2avXggKvE3oXQ1TdNXeD
         8WzQ==
X-Gm-Message-State: AOAM533ZdQRsUxkdHVNkq+yHUGnebSGu9It1dhyUy/D6cDnNduVfAa8q
        H9BlTEN7DM1E5lY3MfcBfY5lrz8TlJxwYy9qZQA=
X-Google-Smtp-Source: ABdhPJxMyBsg2qA0pO8GwrCNb8SXsD7Vh0K0V081r0ntTuaO3+PJf3spErGglVEkf4sCM5dMrjsGJJpr+V0gyYTBgqc=
X-Received: by 2002:a05:6808:490:: with SMTP id z16mr4992126oid.89.1628039393387;
 Tue, 03 Aug 2021 18:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <YQmF9506lsmeaOBZ@unreal> <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
In-Reply-To: <CAD=hENeBAG=eHZN05gvq1P9o4=TauL3tToj2Y9S7UW+WLwiA9A@mail.gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 4 Aug 2021 09:09:41 +0800
Message-ID: <CAD=hENfua2UXH6rVuhMPXYsNSavqG==T3h=z4f=huf+Fj+xiHA@mail.gmail.com>
Subject: Re: RXE status in the upstream rping using rxe
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 4, 2021 at 9:01 AM Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>
> On Wed, Aug 4, 2021 at 2:07 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Hi,
> >
> > Can you please help me to understand the RXE status in the upstream?
> >
> > Does we still have crashes/interop issues/e.t.c?
>
> I made some developments with the RXE in the upstream, from my usage
> with latest RXE,
> I found the following:
>
> 1. rdma-core can not work well with latest RDMA git;

The latest RDMA git is
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

Zhu Yanjun
> 2. There are some problems with rxe in different kernel version;
>
> To 2, the commit
> https://patchwork.kernel.org/project/linux-rdma/patch/20210729220039.18549-3-rpearsonhpe@gmail.com/
> can relieve this problem,
> not sure if some bugs still exist in RXE.
>
> To 1, I will continue to make further investigations.
> So we should have time to make tests, fix bugs and make rxe stable.
>
> Zhu Yanjun
> >
> > Latest commit is:
> > 20da44dfe8ef ("RDMA/mlx5: Drop in-driver verbs object creations")
> >
> > Thanks
