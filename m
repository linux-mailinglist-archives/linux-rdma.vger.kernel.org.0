Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0A3C6AD9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 08:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhGMHA6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 03:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhGMHA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jul 2021 03:00:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BAC0613DD
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jul 2021 23:58:07 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 141so11868121ljj.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jul 2021 23:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U13ajV0+Tm0kAe3vI+k5ecc49icHDfpIrYQ3pdP12vc=;
        b=E4GuTQc1PMoeQfapVwFmJlHTnR2clZsp2RPG306MxMQtVPCETEsuNqLXQw+KNrY+nW
         s3Qjwo2PICCWgkvzZ9lOtYb32FeZdbo1c+BMFq1ZZCD+hB7iB1U6UjQL43drnoEh3clv
         Kx83Ug0CdKrIlBTQc0M7THkxZnD8kg5Pft4RzOiNzbBT6L6PYaezxdNhrYKgyPhZM/gO
         256YOf4cIvMZHmdZueGY9dZ5wJwJHLLHR4N7lA8sOcW7R3BcTcQt/8znsL6PfBcAaDfY
         NxD/pUgAZJeLxDhPrKhP7Ugdbtq1JfUMQObHWBcrVjKp+4Msd4099rEhfUVJrpWkh/Ce
         p5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U13ajV0+Tm0kAe3vI+k5ecc49icHDfpIrYQ3pdP12vc=;
        b=PnSyAKOCpZuLsZsXU1PAS+MO46gZj2BkK2H49UVBXBRhCzQIbL7YLfDfMDwwIiyg1V
         AqG6HXY3hJwTTgGm+RNBvkG4J/a8pWFhkES3K8aoZVp4nxUdT1hHBImIBHVCBDzKtjzB
         D1fEa9f0NzyT5rGMsPiaQoYdhgqParSGmt5K9B8EJIIL0pSpG0B6tOcnkVfwNjW2KT/E
         Ch3D1U9TkJnjF3AT67QJONb/lsyBCBmiJkcU36ANsnt3iFcUGtOwI6dMV+e5cXOEXfKg
         xu0+1dP96NI26e4wYgoU1o1It4SCCXt3aee3sVGr53Qf7YIwnrTZHXZpZVULku8108d+
         8Q+A==
X-Gm-Message-State: AOAM532lGRnmtXhwM0GS1WeA4cZRJUwyWgkT4GRtRB8jYMzo/+V/jAc4
        oRG9JEUfJrbnqqSMRKB185SFrDGDJuBBoHS8mDYxOA==
X-Google-Smtp-Source: ABdhPJxh9w+rflMLPkkKXoUmf9R1f2xuq3gU0UutW3/i4ndQqp3k1XjF7MMpAc4+WQ1YsjKhfmACfve6aYjDGtWESVA=
X-Received: by 2002:a2e:535e:: with SMTP id t30mr2866641ljd.224.1626159484742;
 Mon, 12 Jul 2021 23:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANXvt5oKHQFcKm5ypgS1FyMm_K9KntpmDVHDQRH3fsKXOXoc5A@mail.gmail.com>
 <YO0iDpxD2pJYV3t+@unreal>
In-Reply-To: <YO0iDpxD2pJYV3t+@unreal>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 13 Jul 2021 15:57:53 +0900
Message-ID: <CANXvt5pMnCeMjAH02LM0szoJz526DRMZ9wZMC4-v7s-e=N33iQ@mail.gmail.com>
Subject: Re: [RFC] RDMA with Continuous Memory Allocator
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Takanari Hayama <taki@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,
Thank you for your reply.

> Sorry for my question, but why do you need it?
I'd like to write data to the buffer, prepared by DRM (gpu) driver as
a frame buffer, using RDMA.
There is a similar project as follows.
https://www.openfabrics.org/wp-content/uploads/2020-workshop-presentations/303.-OFI-GPU-DMA-BUF-OFA2020v2.pdf
They prepare a mechanism to share a dmabuf fd between DRM driver and
RDMA driver, in order to update frame buffer using RDMA. I'm trying to
develop that in userland.

Some DRM drivers use CMA to allocate the buffer. I met the problem in
an environment that CMA used.

> From that I remember, CMA memory is used for the devices that doesn't
> support scatter-gather, while RDMA devices (umem) need SG.
Yes, the CMA memory is allocated for a device that doesn't support
scatter-gather.

Thanks,
