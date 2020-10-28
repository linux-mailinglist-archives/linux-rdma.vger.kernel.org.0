Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BA629D979
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbgJ1Wyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:54:50 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16475 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389712AbgJ1Wyq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:54:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99728f0000>; Wed, 28 Oct 2020 06:30:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:30:51 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIT8HE18ev8MtQKD+PWqB3hvv+wwYbJVlWUi9sSuEV5YJX/LrkgJ8esmFcCVYknQEXl+mW70K5AtPOHLPJFJmNrbOx7BAV5HAeMcU1tmuy8Z42872uoEp3ZEMfeiYTytjS2RDNgNy+MB7N4X93HA2Vc3UJv0i4tNmc40ErRefijXVqsQvav36fKHejHJIlLiQyQmqQA87or1qcyxHlQNjKPeXq7VLyq8TycsnAB0xMokJ+0rbl5s4O2hsBukCkzZqZjqMI/wQc3BvtvC89rKh/+0IzWg8WxXMy49oOe9F8A7m2NI+meQ/csKZ1XJvLZbaPzW9A7zf9OSGSH7MLV24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irEPFy+7WXrSL6ffq4cjb3Cxj0XjBZJBO4D8J1WsKG8=;
 b=ntvAI/Zg2/+mKgnYOa80vJl/KheOY5weruIiPfFAR/LIkCov8cffS1L9/EBDOeIZPWsBXO9loTzum86hJEZZ/hl3NoQuNO1YHJJVA3IbkE1IZjMS5oW8c+vkoM/RhItuQK7ZQmBaxIs6/STbV0Uxj3HSwzguLuoJefYZoU8OT/3W7Pevc40jHNlE2YPhKd8F8wPpYOMlGgX2zPJKk6X1F+QsyG560WESL+7GB2kIGygXg+NEX+kLMTzkxeF2VB8GB6jDtX5N9KHRHtoQRpq2vz9OkGEzvJMWdqoCunLDGhrZgMFPjR2DNuJz1XWDyIHKrFVOhyPf6rtvnv7GcPBHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:30:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:30:50 +0000
Date:   Wed, 28 Oct 2020 10:30:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/verbs: avoid nested container_of()
Message-ID: <20201028133048.GA2406668@nvidia.com>
References: <20201026161549.3709175-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026161549.3709175-1-arnd@kernel.org>
X-ClientProxiedBy: MN2PR20CA0029.namprd20.prod.outlook.com
 (2603:10b6:208:e8::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0029.namprd20.prod.outlook.com (2603:10b6:208:e8::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 13:30:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXlXM-00A66u-Jo; Wed, 28 Oct 2020 10:30:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603891855; bh=irEPFy+7WXrSL6ffq4cjb3Cxj0XjBZJBO4D8J1WsKG8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=M0/Evwi66wduOry7TDsfPaMUCBAT0AoBUodYbqS0mQ7YW4NXI0PByKDqSAKBaERum
         MFDVmNX4FK8awltB4P+E1fylDEyoXyO08M3u1aldRH/I0FxNFrQe+rjt8oh/XTtKpn
         9wwWcyX85r1KDCGyV8zZz+2aWwe9iyjB/W8Q8ngV2hRr7xBZunyga2zjuxaJo+3YAj
         36Mxp7zsT6ox4Jo0ta/1z3ebD1CzFRAbwhAciNYc86CtMYEJPOx4h0AxsfG7wzwcaj
         /ocPJTAWl8T4QMHymcrbU0C3KGOsvr+Iv/CYn012+kH1ixSwTdiZnS1V1fvwtBPPZJ
         +6FKfEgtmhKFw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 05:15:39PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Nested container_of() calls work correctly but cause a warning when
> building with W=2. Invoking it from an inline function like in
> drivers/infiniband/hw/mlx5/mlx5_ib.h means we get hundreds of
> warnings like:
> 
> include/linux/kernel.h:852:8: warning: declaration of '__mptr' shadows a previous local [-Wshadow]
>   852 |  void *__mptr = (void *)(ptr);     \
>       |        ^~~~~~
> include/rdma/uverbs_ioctl.h:651:11: note: in expansion of macro 'container_of'
>   651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
>       |           ^~~~~~~~~~~~
> include/rdma/uverbs_ioctl.h:651:24: note: in expansion of macro 'container_of'
>   651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
>       |                        ^~~~~~~~~~~~
> drivers/infiniband/hw/mthca/mthca_qp.c:564:35: note: in expansion of macro 'rdma_udata_to_drv_context'
>   564 |  struct mthca_ucontext *context = rdma_udata_to_drv_context(
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/kernel.h:852:8: note: shadowed declaration is here
>   852 |  void *__mptr = (void *)(ptr);     \
>       |        ^~~~~~
> include/rdma/uverbs_ioctl.h:651:11: note: in expansion of macro 'container_of'
>   651 |  (udata ? container_of(container_of(udata, struct uverbs_attr_bundle,   \
>       |           ^~~~~~~~~~~~
> drivers/infiniband/hw/mthca/mthca_qp.c:564:35: note: in expansion of macro 'rdma_udata_to_drv_context'
>   564 |  struct mthca_ucontext *context = rdma_udata_to_drv_context(
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from <command-line>:
> include/linux/kernel.h:852:8: warning: declaration of '__mptr' shadows a previous local [-Wshadow]
>   852 |  void *__mptr = (void *)(ptr);     \
>       |        ^~~~~~
> 
> Rewrite the macro to use an inline function internally, which makes
> it more readable and reduces the amount of useless output from
> make W=2.
> 
> Fixes: 730623f4a56f ("IB/verbs: Add helper function rdma_udata_to_drv_context")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/rdma/uverbs_ioctl.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

Applied to rdma for-next, thanks

Jason
