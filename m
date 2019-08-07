Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C3284621
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfHGHon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 03:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbfHGHon (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Aug 2019 03:44:43 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D66E23426;
        Wed,  7 Aug 2019 07:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565163883;
        bh=i5ql5p171PyInS14xeMLHfauUmAD2fgUH4BRHR3Jqus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0VVkJTT3P9eCkF36XEQ036AjRY/O7djTRNVz6D2kzn1YgD7VGBdjZtf74Br0m0xxd
         1Nj8/MUT1ykVgaIKzYUHSnFHlBM50+gEHcQTlva0rRV1+xni8Q3Uz1/HAsCHNvvOjZ
         FnS3RllYWVKpCMdtd73wW/4s3rJsXiZSNe8vJYpM=
Date:   Wed, 7 Aug 2019 10:44:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Vladimir Koushnir <vladimirk@mellanox.com>
Cc:     Haim Boozaglo <haimbo@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Message-ID: <20190807074439.GB32366@mtr-leonro.mtl.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
 <20190806155206.GZ4832@mtr-leonro.mtl.com>
 <AM5PR0502MB2931A53B02F2615B967F3B30CED40@AM5PR0502MB2931.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM5PR0502MB2931A53B02F2615B967F3B30CED40@AM5PR0502MB2931.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 07:26:35AM +0000, Vladimir Koushnir wrote:
> Leon,
>
> For comment #3:
> We are not planning to change implementation of libibumad.
> The patches were developed with existing libibumad code and extending existing capability to provide list of devices on the node beyond 32 devocs

You are proposing patches for inclusion in upstream rdma-core and
our request is to use the same functionality as already available
in rdma-core. We don't ask you to rewrite existing libibumad code,
but don't submit wrong code.

>
> For comment #4:
> Hot-plug is out-of-scope of the libibumad as no persistent data is maintained by libibumad.

Fair enough.

Thanks

>
> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org>
> Sent: Tuesday, August 6, 2019 6:52 PM
> To: Haim Boozaglo <haimbo@mellanox.com>
> Cc: linux-rdma@vger.kernel.org; Vladimir Koushnir <vladimirk@mellanox.com>
> Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
>
> On Tue, Aug 06, 2019 at 02:38:52PM +0000, Haim Boozaglo wrote:
> > From: Vladimir Koushnir <vladimirk@mellanox.com>
> >
> > Added new function returning a list of available InfiniBand device names.
> > The returned list is not limited to 32 devices.
> >
> > Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> > Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
> > ---
> >  libibumad/CMakeLists.txt              |  2 +-
> >  libibumad/libibumad.map               |  6 +++++
> >  libibumad/man/umad_free_ca_namelist.3 | 28 ++++++++++++++++++++++++
> >  libibumad/man/umad_get_ca_namelist.3  | 34 +++++++++++++++++++++++++++++
> >  libibumad/umad.c                      | 41 +++++++++++++++++++++++++++++++++++
> >  libibumad/umad.h                      |  2 ++
> >  6 files changed, 112 insertions(+), 1 deletion(-)  create mode 100644
> > libibumad/man/umad_free_ca_namelist.3
> >  create mode 100644 libibumad/man/umad_get_ca_namelist.3
>
> 1. Please use cover letter for patch series.
> 2. There is a need to update debian package too.
> 3. Need to use the same discovery mechanism as used in libibverbs - netlink based.
> 4. Does it work with hot-plug where device name can change?
>
> Thanks
