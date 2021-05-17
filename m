Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519BE386D87
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbhEQXHs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 May 2021 19:07:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:57473 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344345AbhEQXHr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 19:07:47 -0400
IronPort-SDR: 5JBykKHk/KibgblG2d/tj3TdwnD/821m2OoeK9lFFtnSchG2dsPccDwXuayXoIA+Fs0ZCuDBaQ
 puWTgeK703fA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="198634488"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="198634488"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:06:30 -0700
IronPort-SDR: pDyoHFTs/5L7q+uRu55DZXnWSDL8cumi/ATf8LCyAqyHUf/AOc7GUNTX/PjqaAv9oOr79iR3LQ
 tzXQNN2gRxBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="460506495"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 17 May 2021 16:06:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 16:06:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 16:06:29 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 17 May 2021 16:06:29 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "Zhu Yanjun" <zyjzyj2000@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Topic: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Thread-Index: AQHXSzxfKpiSrsBJnEi7XaP3x/HUP6roAbcw
Date:   Mon, 17 May 2021 23:06:29 +0000
Message-ID: <b6045737954e4279939669a1f229c835@intel.com>
References: <0-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
In-Reply-To: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and device
> variants
> 
> This is being used to implement both the port and device global stats, which is
> causing some confusion in the drivers. For instance EFA and i40iw both seem to
> be misusing the device stats.
> 
> Split it into two ops so drivers that don't support one or the other can leave the op
> NULL'd, making the calling code a little simpler to understand.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/counters.c          |  4 +-
>  drivers/infiniband/core/device.c            |  3 +-
>  drivers/infiniband/core/nldev.c             |  2 +-
>  drivers/infiniband/core/sysfs.c             | 15 +++-
>  drivers/infiniband/hw/bnxt_re/hw_counters.c |  7 +-
> drivers/infiniband/hw/bnxt_re/hw_counters.h |  4 +-
>  drivers/infiniband/hw/bnxt_re/main.c        |  2 +-
>  drivers/infiniband/hw/cxgb4/provider.c      |  9 +--
>  drivers/infiniband/hw/efa/efa.h             |  3 +-
>  drivers/infiniband/hw/efa/efa_main.c        |  3 +-
>  drivers/infiniband/hw/efa/efa_verbs.c       | 11 ++-
>  drivers/infiniband/hw/hfi1/verbs.c          | 86 ++++++++++-----------
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 19 ++++-
>  drivers/infiniband/hw/mlx4/main.c           | 25 ++++--
>  drivers/infiniband/hw/mlx5/counters.c       | 42 +++++++---
>  drivers/infiniband/sw/rxe/rxe_hw_counters.c |  7 +-
> drivers/infiniband/sw/rxe/rxe_hw_counters.h |  4 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c       |  2 +-
>  include/rdma/ib_verbs.h                     | 13 ++--
>  19 files changed, 158 insertions(+), 103 deletions(-)
> 

[...]

>  /**
> - * i40iw_alloc_hw_stats - Allocate a hw stats structure
> + * i40iw_alloc_hw_port_stats - Allocate a hw stats structure
>   * @ibdev: device pointer from stack
>   * @port_num: port number
>   */
> -static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
> -						  u32 port_num)
> +static struct rdma_hw_stats *i40iw_alloc_hw_port_stats(struct ib_device *ibdev,
> +						       u32 port_num)
>  {
>  	struct i40iw_device *iwdev = to_iwdev(ibdev);
>  	struct i40iw_sc_dev *dev = &iwdev->sc_dev; @@ -2468,6 +2468,16 @@
> static struct rdma_hw_stats *i40iw_alloc_hw_stats(struct ib_device *ibdev,
>  					  lifespan);
>  }
> 
> +static struct rdma_hw_stats *
> +i40iw_alloc_hw_device_stats(struct ib_device *ibdev) {
> +	/*
> +	 * It is probably a bug that i40iw reports its port stats as device
> +	 * stats
> +	 */

The number of physical ports per ib device is 1.

> +	return i40iw_alloc_hw_port_stats(ibdev, 0); }
> +
>  /**


