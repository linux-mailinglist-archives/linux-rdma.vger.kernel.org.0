Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB028519C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJFSde convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 6 Oct 2020 14:33:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:1687 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFSde (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 14:33:34 -0400
IronPort-SDR: LQPx8/g5GvMz/EDXzRq2adBTF0h4ya2tTFumnVNvlpBitAsSUOM9I7SADZqPF8OsvCZa+/NCWO
 9q9euQaMBEAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163853894"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="163853894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 11:32:56 -0700
IronPort-SDR: +mPQsLC1Gek0s/5tFO2Go3M+tlPqX1bS4x2FyK4i+wthWhtA90huwOhoNv6EyxeBIQbUwa8eKR
 4eZuu4lgP5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="518409118"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2020 11:32:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:32:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 11:32:52 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 6 Oct 2020 11:32:52 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: RE: [PATCH 00/11] Reduce uverbs_cmd_mask and remove
 uverbs_ex_cmd_mask
Thread-Topic: [PATCH 00/11] Reduce uverbs_cmd_mask and remove
 uverbs_ex_cmd_mask
Thread-Index: AQHWmdvP2obtsksLE0+HxK622bhh9KmK6ciA
Date:   Tue, 6 Oct 2020 18:32:51 +0000
Message-ID: <6d2ac29f62f640e5b1e37c70692359d1@intel.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
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

> Subject: [PATCH 00/11] Reduce uverbs_cmd_mask and remove
> uverbs_ex_cmd_mask
> 
> These have become increasingly redundant as the uverbs core layer has got better
> at not invoking drivers in situations they are not supporting.
> 
> The remaining uses are only in rxe and rvt for kernel datapath commands these
> drivers expose to userspace.
> 
> There are many, many weird and wrong things in the drivers related to these
> masks. This closes a number of troublesome cases.
> 
> Jason Gunthorpe (11):
>   RDMA/cxgb4: Remove MW support
>   RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
>   RDMA: Remove elements in uverbs_cmd_mask that all drivers set
>   RDMA: Move more uverbs_cmd_mask settings to the core
>   RDMA: Check srq_type during create_srq
>   RDMA: Check attr_mask during modify_qp
>   RDMA: Check flags during create_cq
>   RDMA: Check create_flags during create_qp
>   RDMA/core Remove uverbs_ex_cmd_mask
>   RDMA: Remove uverbs cmds from drivers that don't use them
>   RDMA: Remove AH from uverbs_cmd_mask
> 
>  drivers/infiniband/core/device.c              | 33 ++++++++
>  drivers/infiniband/core/uverbs_cmd.c          | 26 +++---
>  drivers/infiniband/core/uverbs_uapi.c         |  5 +-
>  drivers/infiniband/core/verbs.c               |  5 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 10 ++-
>  drivers/infiniband/hw/bnxt_re/main.c          | 30 +------
>  drivers/infiniband/hw/cxgb4/cq.c              |  2 +-
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h        |  2 -
>  drivers/infiniband/hw/cxgb4/mem.c             | 84 -------------------
>  drivers/infiniband/hw/cxgb4/provider.c        | 24 ------
>  drivers/infiniband/hw/cxgb4/qp.c              |  8 +-
>  drivers/infiniband/hw/efa/efa_main.c          | 22 +----
>  drivers/infiniband/hw/efa/efa_verbs.c         |  6 ++
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  3 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  9 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  3 +
>  drivers/infiniband/hw/hns/hns_roce_main.c     | 35 +-------
>  drivers/infiniband/hw/hns/hns_roce_qp.c       | 14 +---
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |  4 +
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c     | 29 ++-----

i40iw bit looks ok to me.
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
