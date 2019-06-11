Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8B3C3AF
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 07:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391183AbfFKF4I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 01:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfFKF4I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jun 2019 01:56:08 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C733420679;
        Tue, 11 Jun 2019 05:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560232567;
        bh=QK42B6EpRMnQWquBKrt4oLNzLMinSonJyfznuMwWeac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5GtdPwRLLZkpaOwSSLWYu5ueFAulc93Jfr18PhtVN677zacsDn/R5XDEnFjm/niw
         0IunrZs3EiBVOabmz73pqe7PZlbrnZz+eSvEmIbizriTFwBW4Neq2oZEx0E6+HGIXm
         E6Hx+0CJ3LE6+ex22fLXf/TWTUIPdXwU6fv4znZg=
Date:   Tue, 11 Jun 2019 08:56:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     wangxi <wangxi11@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Lijun Ou <oulijun@huawei.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
Message-ID: <20190611055604.GH6369@mtr-leonro.mtl.com>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
>
>
> 在 2019/6/10 21:27, Jason Gunthorpe 写道:
> > On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
> >
> >>> Why is there an EXPROT_SYMBOL in a IB driver? I see many in
> >>> hns. Please send a patch to remove all of them and respin this.
> >>>
> >> There are 2 modules in our ib driver, one is hns_roce.ko, another
> >> is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
> >> this function defined in hns_roce.ko, and invoked in
> >> hns_roce_hw_v2.ko.
> >
> > seems unnecessarily complicated
> >
> > Jason
> > .
> >
> Hi,Jason,
>
> The hns ib driver was originally designed for the hip06. When designing the
> driver for the new hardware hip08, in order to maximize the reuse of the
> existing hip06 code, the common part of the code is separated into the
> hns_roce.ko, and the hardware difference code is defined into hns_roce_hw_v1.ko
> for hip06 and hns_roce_hw_v2.ko for hip08.
>
> The mtr code is designed as a public part in this patchset, so it is defined
> in hns_roce.ko. It can be used for hi16xx series hardware with mixed mutihop
> addressing feature. Currently, hip08 supports this feature, so it is be called
> in hns_roce_hw_v2.ko.

Combine v1 and v2 into one driver (.ko) and change initialization to
call v1 or v2 accordingly. The rest is handled by ib_device_ops
structure.

Thanks

>
> Xi Wang
>
