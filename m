Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D22C25A3D1
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 05:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIBDKt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 23:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBDKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 23:10:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122EC061244
        for <linux-rdma@vger.kernel.org>; Tue,  1 Sep 2020 20:10:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so4046921lja.7
        for <linux-rdma@vger.kernel.org>; Tue, 01 Sep 2020 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q0TA0JzQJqpIlJrl53Y9fuEwpAWDrBOTkllzb7qWp7k=;
        b=OuFCudma/VpFBCKAf54ByEVIui09931cO+Omp7jAlyj1QeZCdtMFkRvvppOijRzN7F
         szxJLqH2OwskKxhDb3L9o4BWhxl9GcC0l/n+4JE1vXbrPhbK91IE7ELk2nTLN+67eKRk
         +TGg70I2W5tf4OUB70f13gbMVy1/ml6Kyyewjyx2lCFSuKYPykjhO7fz+KHM7Rs6g/U8
         lOKaM0M96aY7wIlVRzo8zuxOx6LQ5Xmrkr8O3+9fEQlUP1oJN8rUbqd2UleVSiAqkl6x
         aSK8YVyjsfkHOQwnHoSA4UOWP1MoxQvjs/LS0Nflqlp6Znz6PP7vYNoMzzGWMDGUbMfG
         w1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q0TA0JzQJqpIlJrl53Y9fuEwpAWDrBOTkllzb7qWp7k=;
        b=j+hN4U6AaNQz94mUN9RpPRDl47ZNsU8pBtBfVJRgwhZBknbqRErq5J2rXPiWiNjjC0
         aprIyIwHWt4/iVSMWdypPyL1nlDGabSPvcol4UYbEcOaM4S5kjF1dr5wbke7AjUPiYeQ
         838KATkosAEh1ADXrqPIiVdi4GGc3kxDH9IEqYTTZ6CHbkCxDFlohnSsEyqHYb11Nd0L
         QElhR8hH46sksAdpck1Sy87QQnoohzpJDbsOdKil+a9RjaV4kmXDuNYsYN16Qnc97PRi
         80Pz2WbzZ5nK6md7lpzdB272ezC+sdICw16O5gJvVYH1ZOc520HivQGGl6gghWiVfsOR
         xesg==
X-Gm-Message-State: AOAM532HUElxFMieJto5Z+m/goh0TZ7L2n66DhCDYNwR4q3y+0phQ93f
        MofRNO8CBxU//XOXe0oXTvBPjzKyDqzAxdwF6o0=
X-Google-Smtp-Source: ABdhPJwil5J/arb07zwuUJXQttUfbGl9HAScGwMs1cdZn3OowsvER24Hc5DOqir+3bf25z/dQTPQhVEbtLGJDUNu3sI=
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr2177796ljj.29.1599016245261;
 Tue, 01 Sep 2020 20:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com> <4-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <4-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Sep 2020 05:10:34 +0200
Message-ID: <CANiq72nxN0QkiwWkYbreBknOuC1cXriJetdO7K8WijrW1f1rsQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] RDMA/umem: Add rdma_umem_for_each_dma_block()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        linux-rdma@vger.kernel.org, Weihang Li <liweihang@huawei.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 2, 2020 at 2:43 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
>  .clang-format                              |  1 +

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
