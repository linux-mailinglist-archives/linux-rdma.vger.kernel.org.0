Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21144414B3E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhIVOBJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 10:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232199AbhIVOBJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 10:01:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB94611C9;
        Wed, 22 Sep 2021 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632319179;
        bh=36IWk6It8GnKx4IJa/NIBW4AEPYji1iLwvfilDyjCXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pekUNLVhn+YYL/CO9fT43ZTrfotwbsqxmeiiHiPuOBIeanmiMbOApgFDPqoNg+gAi
         FNfFzj4CVqKEkpWuEoityr4Fee26sPBLpdCW39J/fCQEof/s14b+FPdM/QbKO0vPyo
         mdSeGCVBCTeMvzIkPSLrKd0d4dAJTVt0TG1x2DifZ3HpedfaMgO3YSeDZYjyc41pqE
         +ynfgXqeKMTFJyJPIXU3ubLtBvCUSwAbLWtUjZWVRAmReoXHHKPsgq2use649Fq3Mu
         YcRyiBs2S/5gpSCSaQtZHwJwQ93fUbCD5ariOReFV469g6gw2K8SBJBO5JFRJDR8wU
         XbbWiNMzFfhpQ==
Date:   Wed, 22 Sep 2021 16:59:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?utf-8?B?6a2P5L+K5ZCJ?= <weijunji@bytedance.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, mst <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, yuval.shaia.ml@gmail.com,
        marcel.apfelbaum@gmail.com, Cornelia Huck <cohuck@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Yongji Xie <xieyongji@bytedance.com>,
        =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        qemu-devel <qemu-devel@nongnu.org>
Subject: Re: Re: [RFC 0/5] VirtIO RDMA
Message-ID: <YUs2x9tUEgdC5lpr@unreal>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com>
 <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
 <YUsqQY5zY00bj4ul@unreal>
 <CAGH6tLV=9ceaUH_zdevtTyL5ft4ZxxX8d0axops4DmbFdFYFjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGH6tLV=9ceaUH_zdevtTyL5ft4ZxxX8d0axops4DmbFdFYFjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 09:37:37PM +0800, 魏俊吉 wrote:
> On Wed, Sep 22, 2021 at 9:06 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Sep 22, 2021 at 08:08:44PM +0800, Junji Wei wrote:
> > > > On Sep 15, 2021, at 9:43 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > <...>
> >
> > > >> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
> > > >>   But it is impossible to change a key of mr using uverbs.
> > > >
> > > > FRMR is more like memory windows in user space, you can't support it
> > > > using just regular MRs.
> > >
> > > It is hard to support this using uverbs, but it is easy to support
> > > with uRDMA that we can get full control of mrs.
> >
> > What is uRDMA?
> 
> uRDMA is a software implementation of the RoCEv2 protocol like rxe.
> We will implement it in QEMU with VFIO or DPDK.

ok, thanks

> 
> Thanks.
> Junji
