Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10558414AAA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 15:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhIVNjk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhIVNjk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Sep 2021 09:39:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421AC061574
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 06:38:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z24so11975355lfu.13
        for <linux-rdma@vger.kernel.org>; Wed, 22 Sep 2021 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+7/vDhCfCO8GWmmOXQpC6JsvYwIxZSEZsQxTfXaYv84=;
        b=Uz2MxzdoNDX6dhOp3IF4xD36aO4yTDgSbarHOatUa/6SEUxBBs9B65S72lOjRcir+3
         LQO0S81gpRY0/YtTCExxSfLwLiJY4PoAcrEdwmr2zJXx3oTSD/z8wUZ5WDGRkbKKLvau
         0PqSIPkXWwN5I5ZXcb1B2nYKA+sBFZgHUZFZs6XDUd/kdvoGfyKroXcu10aBrHYcg6FQ
         EcbxYA3ZEZkOclUCNljq+ptjnU7qKE7rfBEx33RXDdje19VxROu2iKcN9+qwdzb1Yo9H
         sM9OOAmff+GaVK4KJ4TKyGLcsO7mkxLmA8ICWQRv12OduMPchMmMnUTYEvFFzMkgy/aQ
         Urmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+7/vDhCfCO8GWmmOXQpC6JsvYwIxZSEZsQxTfXaYv84=;
        b=bZKVcOpBot4AXyljFMu5bzdL9t54StUpHov1z1miJMf+dZvqd6XMekKJF/jKlrs55B
         MKoyV45ejMI0NxwVdP6OMQnzsL02JqNgwVLocf+faIPQYqzO3ydkZcsfspX4JX+8Qf8U
         MkouWdWcebtlF1fME6Az9qfCtZe4S2s5O5svPKFY6/FgKZm+ch0+MgvcTcmEkEMErBXR
         5VxXNQ2l4xRnKipSsKiRGbmjYSm6XQRqxMRIPj/EtP9hE6mTkQ2hbBmOpaHtwLUznmR7
         1teMWpiNGMwX90fIQcqF6bRmiO3XM96WSVgylCmT+l0yhCX5ZdD66eJsEAUMSJ7vW92+
         7+Kw==
X-Gm-Message-State: AOAM530NOkdd9OMWtVxlIQqpcLmt/xm3i6BA2ONyBDxRBhZHUoo0BlEI
        izbp35C22czgJW+ZJRYYlVSUiYh3t/0af1bwgIsLKg==
X-Google-Smtp-Source: ABdhPJy4U/Qykgh56rsm1XZU4iCOHZMNsgVDIHSbm3kDqtpvbS42/cDQJ3rB1ATulDZXKq9b8/9Gt0dMgBvDBrrYvMI=
X-Received: by 2002:ac2:59c7:: with SMTP id x7mr25401159lfn.662.1632317869289;
 Wed, 22 Sep 2021 06:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com> <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
 <YUsqQY5zY00bj4ul@unreal>
In-Reply-To: <YUsqQY5zY00bj4ul@unreal>
From:   =?UTF-8?B?6a2P5L+K5ZCJ?= <weijunji@bytedance.com>
Date:   Wed, 22 Sep 2021 21:37:37 +0800
Message-ID: <CAGH6tLV=9ceaUH_zdevtTyL5ft4ZxxX8d0axops4DmbFdFYFjQ@mail.gmail.com>
Subject: Re: Re: [RFC 0/5] VirtIO RDMA
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, mst <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 9:06 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Sep 22, 2021 at 08:08:44PM +0800, Junji Wei wrote:
> > > On Sep 15, 2021, at 9:43 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> <...>
>
> > >> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
> > >>   But it is impossible to change a key of mr using uverbs.
> > >
> > > FRMR is more like memory windows in user space, you can't support it
> > > using just regular MRs.
> >
> > It is hard to support this using uverbs, but it is easy to support
> > with uRDMA that we can get full control of mrs.
>
> What is uRDMA?

uRDMA is a software implementation of the RoCEv2 protocol like rxe.
We will implement it in QEMU with VFIO or DPDK.

Thanks.
Junji
