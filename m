Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF2E38829A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 00:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhERWJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 18 May 2021 18:09:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:39731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236372AbhERWJR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 18:09:17 -0400
IronPort-SDR: LeH26PNEiWy0Io9lcialYSnNIMNXKXjue3mq8JY6mWP004wroI6Eigu30Jj+GS/ZOaSWqB6jkr
 Z0J/ukMv7M9w==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="262058150"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="262058150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 15:07:39 -0700
IronPort-SDR: k0jIFLkdusG9zKUDbdmXKcGLn9eDLwGroA23IKUldrDC4H01ulzY5jY+6bNU9bZuEOAw9yNlpS
 4xcXflT5SlJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="542148207"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2021 15:07:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 15:07:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 15:07:38 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 18 May 2021 15:07:38 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from the
 userspace
Thread-Topic: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from
 the userspace
Thread-Index: AQHXS+WIu57S1D4IoUWORM74T0nFLarpy6QQ
Date:   Tue, 18 May 2021 22:07:38 +0000
Message-ID: <b40b9bac4f3e4a628bee17b5b5acc61a@intel.com>
References: <0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com>
In-Reply-To: <0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com>
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

> Subject: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from the
> userspace
> 
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mlx4 and mlx5 implemented differently the WQ input checks.
> Instead of duplicating mlx4 logic in the mlx5, let's prepare the input in the central
> place.

Maybe some more verbiage about what the bug was in mlx5 that prompted this patch would
be good since this an -rc fix.

Shiraz
