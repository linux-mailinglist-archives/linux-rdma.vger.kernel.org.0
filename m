Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC22F66AD
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 18:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbhANRFA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 12:05:00 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30439 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbhANRE5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 Jan 2021 12:04:57 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600079900000>; Fri, 15 Jan 2021 01:04:16 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Jan
 2021 17:04:16 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 14 Jan 2021 17:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1FcmX1BLDmh4auy9l0XANqqIdAtP0Ft4HUcIR7wx7tKcxeKKIJRFp4AgOvKuRFoBW7ejF4N7bH7qYr/GEtCd/kOfE97r1uoIABEbesKsQ37crzCwT0CDK4P6aiHumukDmtQGtP98Kk/27jRZw5O4ED2sMLt2v0bpMhTHb7M9mcz9ONt0tBQpY+NY8xpjBRgi9X2DZHsnGUfuFpvEOuKlPyRNA5sgWxHVNiP53Y2004wzBEiAQ+GoV4thb225Y2OhIMfGTbsVCvg7DlMSp4souwISAmnr3qsI2argSxZfZ+SWijkSUxGdV4b+mvjkC91gsoZFI88rN0xVE0YDSQj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XY2yq0cHdX24U9ylkLCXPCCjPXtAouqGRDGNKZqXKY=;
 b=fqTImTGHiVXrWGflS6iPIwu1MVfnmaEY/FinUg3tloUNY/cdJh98XhKFHMX+udZOFNURBRax+vZlUlb27vy+tHxvnGoUCmX43ainQPW/vybEFb8bFad5E2K4wESeUstDPWkQvNKpXcWbJTsb7wdr6OWAFRWUiZVaJZOB6HVGAnhjCBtQaRzx40gOs/MMOm9nGDO+rOqWPhoSeER6KRTbEYbc8147SkMnOGt4KHcY7ZteIZ0dbtJ+/fy2USKcYpxgRD/UUDdVwfsZUnOnlArgk4HJN0X1HKJPIL0ZmXR9T7M+PIop74MfMyzFRDL2aJ7oFsr4Y6nsXLCOvDBw0G7Dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 17:04:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 17:04:13 +0000
Date:   Thu, 14 Jan 2021 13:04:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Set of fixes
Message-ID: <20210114170411.GA316809@nvidia.com>
References: <20210113121703.559778-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR14CA0009.namprd14.prod.outlook.com
 (2603:10b6:208:23e::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Thu, 14 Jan 2021 17:04:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l062d-001KR5-UX; Thu, 14 Jan 2021 13:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610643856; bh=3XY2yq0cHdX24U9ylkLCXPCCjPXtAouqGRDGNKZqXKY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=sRKy4ZXGclOqseG2p4+ezij2YEfrIJxzgDWeBDkxhYzGM8XodtG8Lr1yAw17ImGLW
         lyzIZTiNtiXXaLd2BOGNupCEmrW8tI/Gib1t7YlftpYpLUCTHXn82pNDDc2gGHnbla
         ctc46XnWnIKUCVcpFn7fUoyF1Uv+2U5FC+CsVECRTH+knEo3MnSBY+PASDh//7YdL7
         sTcZEpaaI0xQ/OJnj7qzFIucn92GluDbwZm769eBYitzqXlfVljDboJpHjVmPdVhM8
         8FUDS/o2u8hq/Xmsr24yTna0HW6NF2llpPaPX+O9pqvuPZK+xHyHuM/nSA/r3NCBjp
         /5IWD9J+nIToA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 13, 2021 at 02:16:58PM +0200, Leon Romanovsky wrote:

>   RDMA/umem: Avoid undefined behavior of rounddown_pow_of_two
>   RDMA/mlx5: Fix wrong free of blue flame register on error
>   IB/mlx5: Fix error unwinding when set_has_smi_cap fails

I took these ones to for-rc

Thanks,
Jason
