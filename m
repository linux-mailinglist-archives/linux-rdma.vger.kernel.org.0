Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D3414A1F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhIVNHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 09:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhIVNHn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 09:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F7D1611CA;
        Wed, 22 Sep 2021 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632315973;
        bh=oNdKNGeEDSMsQZb0QR79jAvNFQsEnJOIQSDq8mmnnzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmZut9FaGDBMBk0SNp1LqarjL1dNIa9LJeP0D32JOFaldMmVLyxNsVJ5ye+/213Vb
         Y046E+hu85twyYidfc5wmzc5AmSKuc+XzHEgENvVUzw8bRu5CSGd5JJ2siUC9sjmmK
         cX83OJtY+o4t2AZ9D3hXac09JxL7f/a4uYR9TLVg0j7ZYKpSPvFrQlq30WzyPHa6OT
         5AIha5qJjIg+YSHBe58gEGciD3IPjh9f1quU8Ay3WYTdk+GbuatGI+3QG6cPJuNp/0
         fru4jCWvG50H6w/4YLaxXYgzhZL82FCR5vR0sbMrjZzxgDsHUFugPDQDkbA25HUO1j
         O7AhSCzM57NFg==
Date:   Wed, 22 Sep 2021 16:06:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junji Wei <weijunji@bytedance.com>
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
Subject: Re: [RFC 0/5] VirtIO RDMA
Message-ID: <YUsqQY5zY00bj4ul@unreal>
References: <20210902130625.25277-1-weijunji@bytedance.com>
 <20210915134301.GA211485@nvidia.com>
 <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8353F66-4F9E-4A6A-8AB2-2A7F84DF4104@bytedance.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 08:08:44PM +0800, Junji Wei wrote:
> > On Sep 15, 2021, at 9:43 PM, Jason Gunthorpe <jgg@nvidia.com> wrote:

<...>

> >> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
> >>   But it is impossible to change a key of mr using uverbs.
> > 
> > FRMR is more like memory windows in user space, you can't support it
> > using just regular MRs.
> 
> It is hard to support this using uverbs, but it is easy to support
> with uRDMA that we can get full control of mrs.

What is uRDMA?

Thanks
