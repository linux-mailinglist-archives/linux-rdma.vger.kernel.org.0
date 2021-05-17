Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18ADA386D7B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 01:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbhEQXE1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 17 May 2021 19:04:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:57272 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhEQXE0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 19:04:26 -0400
IronPort-SDR: 38crZ//stfzvLseKQe4WoucvANo6o4P4AdVEY2n3umk2BgQgzTqLI0YLTb3+Sf//ovZwufyDvW
 MzLlP+MEMdbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="198634054"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="198634054"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:03:09 -0700
IronPort-SDR: OIstmQu8Q/u81oyekW2G6+Iz9ZP6crpBxN2ygL0exMrRJ7CsVX8Fd13ZIag7SOOEEOEt4YEOt2
 pjhRMZ1N9tlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="626835304"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2021 16:03:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 16:03:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 16:03:09 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Mon, 17 May 2021 16:03:09 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Topic: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Thread-Index: AQHXSGaUU9wSirm01EKYaz/j80EGOaroLwcA
Date:   Mon, 17 May 2021 23:03:09 +0000
Message-ID: <c90bd7a612c64f26bc5caa95179e7de7@intel.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <1620958299-4869-2-git-send-email-liweihang@huawei.com>
In-Reply-To: <1620958299-4869-2-git-send-email-liweihang@huawei.com>
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

> Subject: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of atomic_t for
> reference counting
> 
> The refcount_t API will WARN on underflow and overflow of a reference counter,
> and avoid use-after-free risks. Increase refcount_t from 0 to 1 is regarded as there
> is a risk about use-after-free. So it should be set to 1 directly during initialization.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/core/iwcm.c        |  9 ++++-----
>  drivers/infiniband/core/iwcm.h        |  2 +-
>  drivers/infiniband/core/iwpm_util.c   | 12 ++++++++----
>  drivers/infiniband/core/iwpm_util.h   |  2 +-
>  drivers/infiniband/core/mad_priv.h    |  2 +-
>  drivers/infiniband/core/multicast.c   | 30 +++++++++++++++---------------
>  drivers/infiniband/core/uverbs.h      |  2 +-
>  drivers/infiniband/core/uverbs_main.c | 12 ++++++------
>  8 files changed, 37 insertions(+), 34 deletions(-)
> 

[...]

> @@ -589,9 +589,9 @@ static struct mcast_group *acquire_group(struct
> mcast_port *port,
>  		kfree(group);
>  		group = cur_group;
>  	} else
> -		atomic_inc(&port->refcount);
> +		refcount_inc(&port->refcount);
>  found:
> -	atomic_inc(&group->refcount);
> +	refcount_inc(&group->refcount);

Seems like there is refcount_inc with refcount = 0 when the group is first created?

>  	spin_unlock_irqrestore(&port->lock, flags);
>  	return group;
>  }

