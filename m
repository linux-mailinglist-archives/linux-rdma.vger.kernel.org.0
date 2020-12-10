Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29ED32D5BF9
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 14:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbgLJNgl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Dec 2020 08:36:41 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2524 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389516AbgLJNgk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 08:36:40 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CsFKR5yNGzQr90;
        Thu, 10 Dec 2020 21:35:23 +0800 (CST)
Received: from dggema701-chm.china.huawei.com (10.3.20.65) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 10 Dec 2020 21:35:52 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema701-chm.china.huawei.com (10.3.20.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 10 Dec 2020 21:35:52 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.1913.007;
 Thu, 10 Dec 2020 21:35:52 +0800
From:   liweihang <liweihang@huawei.com>
To:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next 00/11] RDMA/hns: Updates for 5.11
Thread-Topic: [PATCH v3 for-next 00/11] RDMA/hns: Updates for 5.11
Thread-Index: AQHWzvgoo94IrxrbREGFBGMWXx2q3A==
Date:   Thu, 10 Dec 2020 13:35:52 +0000
Message-ID: <c532de50a832421e88d5b0979819818b@huawei.com>
References: <1607606572-11968-1-git-send-email-liweihang@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/12/10 21:27, Weihang Li wrote:
> There are miscellaneous updates for hns driver:
> * #1 fixes a potential length issue when copying udata.
> * #2 fixes the unreasonable judgment when using HEM of SRQ and SCCC.
> * #3 fixes wrong value of Traffic Class.
> * #4 and #5 fix issues about Service Level.
> * #6 ~ #11 are cleanups, including removing dead code, fixing coding style
>   issues and so on.
> 
> Changes since v2:
> - Remove WARN_ON() in #5 when filling QPC.
> 
> Changes since v1:
> - Only do shift on tclass when using RoCEv2 in #3.
> 
> Previous version:
> v2: https://patchwork.kernel.org/project/linux-rdma/cover/1607078436-26455-1-git-send-email-liweihang@huawei.com/
> v1: https://patchwork.kernel.org/project/linux-rdma/cover/1606899553-54592-1-git-send-email-liweihang@huawei.com/
> 
> Lang Cheng (1):
>   RDMA/hns: Fix coding style issues
> 
> Weihang Li (3):
>   RDMA/hns: Do shift on traffic class when using RoCEv2
>   RDMA/hns: Avoid filling sl in high 3 bits of vlan_id
>   RDMA/hns: WARN_ON if get a reserved sl from users
> 
> Wenpeng Liang (3):
>   RDMA/hns: Limit the length of data copied between kernel and userspace
>   RDMA/hns: Normalization the judgment of some features
>   RDMA/hns: Fix incorrect symbol types
> 
> Xinhao Liu (1):
>   RDMA/hns: Clear redundant variable initialization
> 
> Yixian Liu (2):
>   RDMA/hns: Remove unnecessary access right set during INIT2INIT
>   RDMA/hns: Simplify AEQE process for different types of queue
> 
> Yixing Liu (1):
>   RDMA/hns: Fix inaccurate prints
> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c     |  13 +--
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |   4 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |  37 +++---
>  drivers/infiniband/hw/hns/hns_roce_cmd.h    |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_common.h |  14 +--
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |  42 +++----
>  drivers/infiniband/hw/hns/hns_roce_db.c     |   8 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  87 ++++++--------
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |  44 +++----
>  drivers/infiniband/hw/hns/hns_roce_hem.h    |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |  41 +++----
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h  |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 173 +++++++++-------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  19 +--
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |  25 ++--
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  13 ++-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  82 +++++++------
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |  48 ++++----
>  19 files changed, 298 insertions(+), 368 deletions(-)
> 

Sorry, the patch #10 causes a compile warning, please ignore this series.
Will resend it later.

Weihang
