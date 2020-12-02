Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3392CB1B5
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 01:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgLBAvU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 19:51:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1984 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgLBAvU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Dec 2020 19:51:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6e4e00000>; Tue, 01 Dec 2020 16:50:40 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 00:50:36 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Dec 2020 00:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQA+tchWY927L0hp6ATndGIOBO4YMWUpg+8/7qSiYg2B8d+ZWKAgmG/T3KsJcKV3I0BbMmOjnPlMZe7iG0ZsR2N66aLX/6xU9fhI5ida6gxc5AHcJUiqUc0VIjEhhjxpzw5DaqXNMynLSTqUTQuw8ZvB6BpvtWWb1z1wdhlxT0NMwJ4ctfDaVc5hukvYxYhui2tO6/OQFZ7IbLfBhjMqb4++KyR5pDcWWDCV/ji9ZoG6cNwSKCaaBjWH573GEwz+T0nrA+mcRS/og9IUMJ8Z7pHH4LDZXm9Dqlj/9H75Q2Tn+/2+8ius5iBAYartPsPWjLjdj4Swf9ucpUF+q1JIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kSUuURVTYaEHPpTeNdGAJo2O5BzRJtfOY3AtNEhFZY=;
 b=WbSbFLPJsBLjtjaSV4K7jZ8GDFtFprxvUuoQHLLYUlg+DJMATbJQ4pswGRDQJPX54A1OUJmYR9njAhftX97HcuCpUyuRUmKemknzXFnSzdFaN/rhF1SS6YnomvqrFpBO9h5Ej0mtfGeXvE+IVCrP9sfzDPJ+Bne2nVraryXYf7/JL+q1aR2vHHlIQCByG36W4Aq+gjhrM6xhE+Fb+oRXRrrdgezHlRiT9w6KuFMQJTtbjEzVwh76ARWqD7FkDQFSR707mkTw9XC4RwZi9q6s3tuMo9YezUNlMIeWHH3Kh5ioLQwunVLz+5NNbkgG+hqTGsVBQnha32IsqVyt0pccEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 00:50:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 00:50:34 +0000
Date:   Tue, 1 Dec 2020 20:50:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <stable@kernel.org>
Subject: Re: [PATCH v2 2/2] RDMA/i40iw: Remove push code from i40iw
Message-ID: <20201202005033.GA1131799@nvidia.com>
References: <20201125005616.1800-1-shiraz.saleem@intel.com>
 <20201125005616.1800-3-shiraz.saleem@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201125005616.1800-3-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR15CA0036.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0036.namprd15.prod.outlook.com (2603:10b6:208:1b4::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 00:50:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kkGLp-004kRX-Gq; Tue, 01 Dec 2020 20:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606870240; bh=/kSUuURVTYaEHPpTeNdGAJo2O5BzRJtfOY3AtNEhFZY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=UBR/yR1+jnsVwCABq2n4lWwf7iXsu4i1i710TfQDYEs9RiDAz8NiP48Ay4/7s7Nhi
         UWNshdpV2Tt1+l4jpeE18ej3UyRzmZRfJVbWytBZrDqFv6ZugvtmkwfPk1pQQFLOCJ
         yF8Ka6b7lSCtWZaFeb4TQ1w9hSRY/06soqWSSVxD4S/kGD78xsebMAVa8GccUjUMBb
         cHfrir0O2gnfwKoN7WADueYn4oynJqkiWgvs6Qle980R8/Sq4Q94wk7Piff3ag4nmS
         oaLWnc6VKlBZ8epPPkJ1wb+8MWaNCAGy2imN0AOobtWKIPYzr6Qi6cphRF9sEMdMSN
         xmbP2ZCmEW3Mw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 06:56:17PM -0600, Shiraz Saleem wrote:
> The push feature does not work as expected in x722 and
> has historically been disabled in the driver.
> 
> Purge all remaining code related to the push feature in i40iw.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h        |    1 -
>  drivers/infiniband/hw/i40iw/i40iw_ctrl.c   |   52 +----------------
>  drivers/infiniband/hw/i40iw/i40iw_d.h      |   35 ++++-------
>  drivers/infiniband/hw/i40iw/i40iw_status.h |    1 -
>  drivers/infiniband/hw/i40iw/i40iw_type.h   |   18 ------
>  drivers/infiniband/hw/i40iw/i40iw_uk.c     |   41 +------------
>  drivers/infiniband/hw/i40iw/i40iw_user.h   |    8 ---
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c  |   86 +---------------------------
>  8 files changed, 18 insertions(+), 224 deletions(-)

Applied to for-next, thanks

Jason
