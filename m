Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA2D1D34B8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENPNk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 11:13:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgENPNk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 11:13:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF7Mtx169097;
        Thu, 14 May 2020 15:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=SnLRrNJyWtxDcPen7hjnltyPV/uBbBruDCJ+cga3f6U=;
 b=xTWd7vUyb2R6+xENXWxaTMZBQ576CvkPFf1MvOmBrMwob5hDQ6qKa+O6zE6hGtarKikI
 86LrgftUspTVZ5Q9VNBiTsos0BulZskfQ3K/2z9MWTjTOr+dmtvD96woJ6hWobBguDDP
 QLKCVpbMuAg1V8sI/77zonsXw3vhK7ykra7etzqtwByUbGCu25KnH3Asl4y8SubwvPf/
 iQOyfJKthXftrvz2v3wrYeCB8vqRQEu5wb7JjFwJ5CeVZ9YFYoZPRcRFW36r83LPYJYU
 Oguw0xJHMSoJeiqZNPDVkvryABPN6opRtR8MO4WJ/NvJkdkgwoIt52UrMNcO5fDNXZUQ Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3100xwu4tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 15:13:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EF8JBQ134513;
        Thu, 14 May 2020 15:13:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100ycugtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 15:13:20 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EFDHIh007010;
        Thu, 14 May 2020 15:13:17 GMT
Received: from [127.0.0.1] (/137.254.7.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 08:13:17 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
From:   Aron Silverton <aron.silverton@oracle.com>
In-Reply-To: <20200514120305.189738-1-maxg@mellanox.com>
Date:   Thu, 14 May 2020 10:13:15 -0500
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140133
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+Santosh

You probably meant to copy the RDS maintainer? Not sure if this should =
have
also been sent to netdev@vger.kernel.org.

Aron

> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>=20
> This series removes the support for FMR mode to register memory. This =
ancient
> mode is unsafe and not maintained/tested in the last few years. It =
also doesn't
> have any reasonable advantage over other memory registration methods =
such as
> FRWR (that is implemented in all the recent RDMA adapters). This =
series should
> be reviewed and approved by the maintainer of the effected drivers and =
I
> suggest to test it as well.
>=20
> The tests that I made for this series (fio benchmarks and fio verify =
data):
> 1. iSER initiator on ConnectX-4
> 2. iSER initiator on ConnectX-3
> 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> 4. SRP initiator on ConnectX-3
>=20
> Not tested:
> 1. RDS
> 2. mthca
> 3. rdmavt
>=20
> Israel Rukshin (1):
>  RDMA/iser: Remove support for FMR memory registration
>=20
> Max Gurtovoy (7):
>  RDMA/mlx4: remove FMR support for memory registration
>  RDMA/rds: remove FMR support for memory registration
>  RDMA/mthca: remove FMR support for memory registration
>  RDMA/rdmavt: remove FMR memory registration
>  RDMA/srp: remove support for FMR memory registration
>  RDMA/core: remove FMR pool API
>  RDMA/core: remove FMR device ops
>=20
> Documentation/driver-api/infiniband.rst      |   3 -
> Documentation/infiniband/core_locking.rst    |   2 -
> drivers/infiniband/core/Makefile             |   2 +-
> drivers/infiniband/core/device.c             |   4 -
> drivers/infiniband/core/fmr_pool.c           | 494 =
---------------------------
> drivers/infiniband/core/verbs.c              |  48 ---
> drivers/infiniband/hw/mlx4/main.c            |  10 -
> drivers/infiniband/hw/mlx4/mlx4_ib.h         |  16 -
> drivers/infiniband/hw/mlx4/mr.c              |  93 -----
> drivers/infiniband/hw/mthca/mthca_dev.h      |  10 -
> drivers/infiniband/hw/mthca/mthca_mr.c       | 262 +-------------
> drivers/infiniband/hw/mthca/mthca_provider.c |  86 -----
> drivers/infiniband/sw/rdmavt/mr.c            | 154 ---------
> drivers/infiniband/sw/rdmavt/mr.h            |  15 -
> drivers/infiniband/sw/rdmavt/vt.c            |   4 -
> drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----
> drivers/infiniband/ulp/iser/iser_initiator.c |  19 +-
> drivers/infiniband/ulp/iser/iser_memory.c    | 188 +---------
> drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +------
> drivers/infiniband/ulp/srp/ib_srp.c          | 222 +-----------
> drivers/infiniband/ulp/srp/ib_srp.h          |  27 +-
> drivers/net/ethernet/mellanox/mlx4/mr.c      | 183 ----------
> include/linux/mlx4/device.h                  |  21 +-
> include/rdma/ib_fmr_pool.h                   |  93 -----
> include/rdma/ib_verbs.h                      |  45 ---
> net/rds/Makefile                             |   2 +-
> net/rds/ib.c                                 |  14 +-
> net/rds/ib.h                                 |   1 -
> net/rds/ib_cm.c                              |   4 +-
> net/rds/ib_fmr.c                             | 269 ---------------
> net/rds/ib_mr.h                              |  12 -
> net/rds/ib_rdma.c                            |  16 +-
> 32 files changed, 77 insertions(+), 2447 deletions(-)
> delete mode 100644 drivers/infiniband/core/fmr_pool.c
> delete mode 100644 include/rdma/ib_fmr_pool.h
> delete mode 100644 net/rds/ib_fmr.c
>=20
> --=20
> 1.8.3.1
>=20

