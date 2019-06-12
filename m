Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD142F4D
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFLSsz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 12 Jun 2019 14:48:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:62325 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFLSsz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 14:48:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 11:48:54 -0700
X-ExtLoop1: 1
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2019 11:48:54 -0700
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 12 Jun 2019 11:48:54 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.88]) by
 FMSMSX161.amr.corp.intel.com ([169.254.12.26]) with mapi id 14.03.0415.000;
 Wed, 12 Jun 2019 11:48:54 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Latif, Faisal" <faisal.latif@intel.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>
Subject: RE: [PATCH] rdma: Remove nes
Thread-Topic: [PATCH] rdma: Remove nes
Thread-Index: AQHVH8WaElvEFprbXUuXyCrHBlhG5qaYXoJA
Date:   Wed, 12 Jun 2019 18:48:53 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A5B2A8BB@fmsmsx124.amr.corp.intel.com>
References: <20190610194911.12427-1-jgg@ziepe.ca>
In-Reply-To: <20190610194911.12427-1-jgg@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzhlMWU0NTItMjE5Mi00ZDEwLWJjYjItMTU1OTcxMDBhMmZkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWW9GM0I2RG1ZTlJxVWh3ZGdmRlJxMDU1SnRBVkJRVDZjVGpEenFrQWRcLzNsUWNnbGNcLzBUaVV0VjZNMEtvaGdzIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] rdma: Remove nes
> 
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> This driver was first merged over 10 years ago and has not seen major activity by
> the authors in the last 7 years. However, in that time it has been patched 150 times
> to adapt it to changing kernel APIs.
> 
> Further, the hardware has several issues, like not supporting 64 bit DMA, that make
> it rather uninteresting for use with modern systems and RDMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  .../ABI/stable/sysfs-class-infiniband         |   17 -
>  MAINTAINERS                                   |    8 -
>  drivers/infiniband/Kconfig                    |    1 -
>  drivers/infiniband/hw/Makefile                |    1 -
>  drivers/infiniband/hw/nes/Kconfig             |   15 -
>  drivers/infiniband/hw/nes/Makefile            |    3 -
>  drivers/infiniband/hw/nes/nes.c               | 1205 -----
>  drivers/infiniband/hw/nes/nes.h               |  574 ---
>  drivers/infiniband/hw/nes/nes_cm.c            | 3992 -----------------
>  drivers/infiniband/hw/nes/nes_cm.h            |  470 --
>  drivers/infiniband/hw/nes/nes_context.h       |  193 -
>  drivers/infiniband/hw/nes/nes_hw.c            | 3887 ----------------
>  drivers/infiniband/hw/nes/nes_hw.h            | 1380 ------
>  drivers/infiniband/hw/nes/nes_mgt.c           | 1155 -----
>  drivers/infiniband/hw/nes/nes_mgt.h           |   97 -
>  drivers/infiniband/hw/nes/nes_nic.c           | 1870 --------
>  drivers/infiniband/hw/nes/nes_utils.c         |  915 ----
>  drivers/infiniband/hw/nes/nes_verbs.c         | 3754 ----------------
>  drivers/infiniband/hw/nes/nes_verbs.h         |  198 -
>  include/uapi/rdma/nes-abi.h                   |  115 -
>  20 files changed, 19850 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/nes/Kconfig  delete mode 100644
> drivers/infiniband/hw/nes/Makefile
>  delete mode 100644 drivers/infiniband/hw/nes/nes.c  delete mode 100644
> drivers/infiniband/hw/nes/nes.h  delete mode 100644
> drivers/infiniband/hw/nes/nes_cm.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_cm.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_context.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_hw.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_mgt.h
>  delete mode 100644 drivers/infiniband/hw/nes/nes_nic.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_utils.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.c
>  delete mode 100644 drivers/infiniband/hw/nes/nes_verbs.h
>  delete mode 100644 include/uapi/rdma/nes-abi.h
> 

Thank you!

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
