Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FD47BE20
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Dec 2021 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhLUK0O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 05:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLUK0O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Dec 2021 05:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE36AC061574
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 02:26:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A728614FF
        for <linux-rdma@vger.kernel.org>; Tue, 21 Dec 2021 10:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB1C36AE7;
        Tue, 21 Dec 2021 10:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640082373;
        bh=GtSnWBOAHSm7pwSCodjahr/S1Yl5KZ07wz5aHw4CFD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Meg1lReErHD4Vvk7+rIuPgin38KczouQo6h4zDFK97gqGnSMPDxHT76cFN0xpGFj4
         egRF6MP/HhJ6Lof3VlJ1lpcq6HcgQSHVOR2swJi84b4WQGmZbAvjWlY7/d2SARtQ+c
         Zn5sruqEeMSs07dv56EP+eZkwUAPUt5Ye1DRddny4BBogXrecouiJ1CU8FS/bVcgAZ
         jz6NKbQ8SjX0bbo6vdm5i6apdhe3LXUx6sBEqhqLgg9RF8tHmY5AIgNLCJ8rkwNgd7
         IoKXUlc0rX0vNhmZ4DtKRoxpxyUqSS1xAffAZS7+QQQRxbU0ATGuM7j9LvzNjmwMAB
         70SmPuo/lcRvw==
Date:   Tue, 21 Dec 2021 12:26:08 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Karsten Graul <kgraul@linux.ibm.com>
Cc:     Tony Lu <tonylu@linux.alibaba.com>, Alaa Hleihel <alaa@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: RDMA/mlx5: Regression since v5.15-rc5: Kernel panic when called
 ib_dereg_mr
Message-ID: <YcGrwF3xQOh2o0rp@unreal>
References: <9974ea8c-f1cb-aeb4-cf1b-19d37536894a@linux.alibaba.com>
 <8b764027-4f25-e27d-15f9-7466343cf845@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b764027-4f25-e27d-15f9-7466343cf845@linux.ibm.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 21, 2021 at 09:20:28AM +0100, Karsten Graul wrote:
> On 21/12/2021 09:04, Tony Lu wrote:
> > Hello,
> > 
> > During developing and testing of SMC (net/smc), We found a problem,
> > when SMC released linkgroup or link, it called ib_dereg_mr to release
> > resources, then it panicked in mlx5_ib_dereg_mr. After investigation,
> > we found this panic was introduce by this commit:
> > 
> >     f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg MR flow")
> 
> +1, this panic in our environment:

I assume that this patch will fix.
https://lore.kernel.org/all/f298db4ec5fdf7a2d1d166ca2f66020fd9397e5c.1640079962.git.leonro@nvidia.com

Thanks
