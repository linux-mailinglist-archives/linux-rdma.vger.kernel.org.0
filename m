Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7148560A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbiAEPk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 10:40:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:16310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241599AbiAEPk5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 10:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641397257; x=1672933257;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VLgVtlmIpqq2oA0axgr7pVSbKP4UaudZC5j4KpHI38E=;
  b=VORrLYgIPhczhld9qhj2RyD2Nxr7hzX08yH8AVb/uH0eNFNVITUtHIfK
   SuUINStoJDmM8BzQp2c0PvY3o550YHfBLpoxGroKT8R5EwtoVYZrGhJhy
   PZZjyw3ZL10jVKXbj9pH9DGmZRQb+VCPUzwRbuAPSJ33jT2tq/tDhKWSc
   ZecliheVkH6tJqz4oW+OqfF1c0md6h04P2SeNISjaM15KZ6RQ0kSJ2dnU
   pNkFWmCB8GZL9VpHUrNxVJnfvlDN0Lqe/KuN3MWG8bupv4oo1vd/oBJ+a
   C+PuoAH2FTnSf9vraHbC48gpjIbtaJEMDcTybDCW3DW2FduBbhKY+Iv8n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229785512"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="229785512"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 07:40:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="617991915"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2022 07:40:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 07:40:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 07:40:54 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Wed, 5 Jan 2022 07:40:54 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "liangwenpeng@huawei.com" <liangwenpeng@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 3/5] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCH 3/5] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHYAfgQjfrMrPjUbUadP1LGxF00AaxUkPmQ
Date:   Wed, 5 Jan 2022 15:40:54 +0000
Message-ID: <4fc2f6513b4348349f13cf2443612381@intel.com>
References: <20220105221237.2659462-1-yanjun.zhu@linux.dev>
 <20220105221237.2659462-4-yanjun.zhu@linux.dev>
In-Reply-To: <20220105221237.2659462-4-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 3/5] RDMA/irdma: Make the source udp port vary
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues=
.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
