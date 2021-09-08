Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634CD4034AA
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347966AbhIHHCf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 03:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347962AbhIHHCe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 03:02:34 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4BC061757
        for <linux-rdma@vger.kernel.org>; Wed,  8 Sep 2021 00:01:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so1767098lji.12
        for <linux-rdma@vger.kernel.org>; Wed, 08 Sep 2021 00:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzXaUAalZqbrYv6j2stFbPFR8gVHfPe6iNbwkck2gaQ=;
        b=I1O9kC6SsLJK4g5PyixqNxAjrnfsTIyox8pmgc6TZJICHzT2LP9NxZK8qLXv+rRlJA
         htYN5ABJjJ4+wr84+nsWuut0jYihhpds2TBbcZzI+azmDpj96X7pVXz6FfwFJpyxmpwt
         ezfrmkfKFGFMkT1mOqemRXfryDV25SDYPHj0mxz3AeJbn5OQpZCdHsB+bD9JZjSlL3t4
         JUHsOYfs1Jz+Ro3wOtl4O104qhq6DWne2x815Y10W+SZssAZAlzmGl+G9tXZ1G68uUBF
         kDyjCISsiV72NcZPju2V6W+u5TGHVlsJwczfhhUtCy+YjuYhT5Nz0oRPRgcMV2yxIT/K
         41kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzXaUAalZqbrYv6j2stFbPFR8gVHfPe6iNbwkck2gaQ=;
        b=radZczxGDobAax/d5/Roa2jefYZIbqKBKnlmL0JaipFJpcoFOoSVMpst5ggB3MEe14
         yTqPxlWrH9WuGM+FsQJZvIpQrPCvlLpX9A8xMKpmso6OnoIfvthbMKw3sPKL4PnSg5Y9
         Ur34Zd+S1G8vqL5mlyvpUxWncFe73A5FyPnfjma4mbTFYF+Ibsxm+y/B3kubUf5edcat
         j8/4Dsq8XRi9XboKaHm6i9xSrxplw/FTqhviJCZStGWNpk1gkYbCdx2Jeopcs8l2qTpw
         xDn4lDBTuZ/ANmwRtGqepsLQfs38q4BXXNgUmLfpj62uj6vuK5BmR0QroGKpzQQVy7Ce
         qQbQ==
X-Gm-Message-State: AOAM533Sgs+TtY9K50DlIbd55rAy0+gSqk23yhZWvYadVNVGgdA94tNF
        SOydXjA14IaDGpjUbwlu9JhV5wNkYaQ+Klwam4z5Mg==
X-Google-Smtp-Source: ABdhPJwuTMM7db+CKbywV5n8DOBaJdUVZ9/pm9vdpYvhauCZICpdO2MsiV8vTp6ey6VXwezzc71z0pbJc8YuXvHEyKs=
X-Received: by 2002:a2e:b8c7:: with SMTP id s7mr1738648ljp.105.1631084485315;
 Wed, 08 Sep 2021 00:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <20210908061611.69823-2-mie@igel.co.jp>
 <YThXe4WxHErNiwgE@infradead.org>
In-Reply-To: <YThXe4WxHErNiwgE@infradead.org>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 8 Sep 2021 16:01:14 +0900
Message-ID: <CANXvt5ojNPpyPVnE0D5o9873hGz6ijF7QfTd9z08Ds-ex3Ye-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Change for rdma devices has not dma device
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Christian K??nig" <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>,
        Tomohito Esaki <etom@igel.co.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thank you for your comment.
>
> On Wed, Sep 08, 2021 at 03:16:09PM +0900, Shunsuke Mie wrote:
> > To share memory space using dma-buf, a API of the dma-buf requires dma
> > device, but devices such as rxe do not have a dma device. For those case,
> > change to specify a device of struct ib instead of the dma device.
>
> So if dma-buf doesn't actually need a device to dma map why do we ever
> pass the dma_device here?  Something does not add up.
As described in the dma-buf api guide [1], the dma_device is used by dma-buf
exporter to know the device buffer constraints of importer.
[1] https://lwn.net/Articles/489703/
