Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6F3C222F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jul 2021 12:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhGIK1p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jul 2021 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIK1p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jul 2021 06:27:45 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCFAC0613DD
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jul 2021 03:25:01 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 11so3237261ljv.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jul 2021 03:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7eYg2OORZqFMxEkSST4c5MTXIQq7mqljuPAsGPZpLPI=;
        b=G49PFH5ygg3gH93BnCgxj8e6m8bKrsoQK6Bo+D/LwEy+oV3GHLXqc1FDuAC55BFCnX
         UoNrx5Iv7BHj1ZLz533xL2RBi15jHBeRHTCJwD8CTqEFw4BLCHBv18ZXZHwZ+lkhqt2g
         ngxTQ5j40jCjpBnkJPhLqWSfJBLf+8TMgSfnidJ9mkBD0dWD1tEIKUhqJ4fuB/tPlT4H
         ueehsCTtQoGo0ShFH3vK6e0buub6sGRV+QBw1Yzvc0njbO2td4qzZmO86GDAmm1bvAnT
         FxGUptVLlB1OUI+JPeQoNvNfSGXnD9r4Ey4MQ7NdxfBNPbbl7J0SLOQJnknT6+F/Bf88
         /r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=7eYg2OORZqFMxEkSST4c5MTXIQq7mqljuPAsGPZpLPI=;
        b=tsQXVTg6KaZiblL2gJFnnrBozrFYLl2Gdq368ri+YHXr6lp1W5ZVcRSQz6Ncp/oGCy
         l1qjLIKpaiHBc+plz9pdBZDinM883CJmt09lUup6rEgVmEukGdINWOESlgGgF4B/Y2Y/
         FOKOyWtuDj81Co7VvRIZhnSouxnzgreB947jLJIUfI2Ny6BS4UUuDOHOQ+DQ7CEbBjl2
         alfHToSmeVS3f+S9dJ0J42fnnjDC8KdE5xtVltCo6hoJTsWNkgb7w6Cs5hE75qcLW0yN
         k3p+YJ2qlv7NwPKkgFTw1gS3dPI/brb07c/ou1ux3EQ1gKBO+kRcf7ZQRMsC7JQhwEFn
         M+Bw==
X-Gm-Message-State: AOAM533pxR3GO64eRgMOfCdtil5hjpEfxww0JCaJw60htsCapmgUHtRp
        jfNjsqFu6ClniZDSlUPRIwFx1H4LHyEwEOoalMymfCwJNI2wAyPz
X-Google-Smtp-Source: ABdhPJxwPpQi6cah3sxjlzwFMPXnNvcsN1KEUS9vt46PfZiSnuZMVXlt82MKifMCy1oqoxKfCKMchb7urylv7dAw6bs=
X-Received: by 2002:a2e:95c9:: with SMTP id y9mr28170948ljh.401.1625826299581;
 Fri, 09 Jul 2021 03:24:59 -0700 (PDT)
MIME-Version: 1.0
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 9 Jul 2021 19:24:48 +0900
Message-ID: <CANXvt5oKHQFcKm5ypgS1FyMm_K9KntpmDVHDQRH3fsKXOXoc5A@mail.gmail.com>
Subject: [RFC] RDMA with Continuous Memory Allocator
To:     linux-rdma@vger.kernel.org, Takanari Hayama <taki@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

I tried to use Continuous Memory Allocator (CMA) allocated memory for
RDMA transfer buffer in userspace, but it failed.

For more details, an ibv_reg_mr() API fails when I pass an mmaped
memory region of allocated memory by the CMA. The reason why, a CMA
mmap function, __dma_mmap_from_coherent(), sets  VM_IO and VM_PFNMAP
to vma->vm_flags, and an ib_uverbs_reg_mr(), kernel function
corresponding to the ibv_reg_mr(), tries to pin the memory region but,
it becomes to fail. because VM_IO or VM_PFNMAP regions cannot be
pined. As a result, the ibv_reg_mr() returns an error.

I think the ib_umem_get() that is called in the ib_uverbs_reg_mr() and
pins memories needs some modifications to support RDMA transfer
to/from the CMA memory.

I=E2=80=99d like to know your comments, ideas, and other solution.

Thanks a lot,
Shunsuke.
