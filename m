Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D7326A69
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Feb 2021 00:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZXdv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Feb 2021 18:33:51 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9655 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhBZXdu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Feb 2021 18:33:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603985360000>; Fri, 26 Feb 2021 15:33:10 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 23:33:09 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 26 Feb
 2021 23:33:08 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 23:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMHOF9gnTxeZlVVGOqgMgO951Q3XoYpJLNJIDF5ZIM3FcgQD/lLZ+HB0V+qqDC+9futtzb7RTDM2c8AKGmcMs14OFn4XOzXX1uV6ft/g7vCvCRb+VYv3VR5fjSgf50dSofW+8FzBmEUUq2AQKXEz7fG9S2cbjXaOFm0y7SJrR83v4oceWX4rDc4L9+pVjVTGDZhsX7C5eb07eHyLnX1QwOeZKdVz5XYBLCOPP/xYDcAdfYZcGmcI6uVEhz1DUdj3loLtzZG8Ne7UOv0bEz3oDEGZpzlO+vvA+vpIXJ7OqvrRH2eavr6T1Gi8GfwU6bqxXBFYzaY2cncse7w1IX5ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CHqVbFJXLfeb9MmTHIv3qEQPqsZiwjaowEo5g/3NWE=;
 b=lO7ILfkdWrPYcNstQk7KYuzUsJr5B0tigH5/T3TUciW5iWVHDT1lVGFn6i7y5+D8kxB7rPJ9tzgXR+I9pW/72xJeXEGTjTF/dGrkJYhjueBbxqFSmrBdEIBPvcel5QMwUrdO6tkup+4PgskktOrWSEIVFLidEJOLH32YdOi2MOFH31ReAFX5Zahh/KFIZjl4WdTNqJG6RH3ckaqPEQJ2qqmnHvKAaeWLouse/1cCMXsN+vDgVub4ZDsjgqB2g+NTT5tJQoc4vfd6tFT3g3zs1FvQqbCJGBzzVtaEFM4nEbbABSA9kSuV0uKauUz3Z+xLjZXLXHjSd4jXvZipiCWhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 23:33:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 23:33:03 +0000
Date:   Fri, 26 Feb 2021 19:33:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <20210226233301.GA4247@nvidia.com>
References: <20210214222630.3901-1-rpearson@hpe.com>
 <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48dcbdc5-35a3-2fe3-3e3d-bff37c2d8053@gmail.com>
X-ClientProxiedBy: YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31 via Frontend Transport; Fri, 26 Feb 2021 23:33:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lFmbV-001QGp-Jp; Fri, 26 Feb 2021 19:33:01 -0400
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8757
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614382390; bh=0CHqVbFJXLfeb9MmTHIv3qEQPqsZiwjaowEo5g/3NWE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:
         X-MS-Exchange-MinimumUrlDomainAge:X-Header;
        b=Si/whNhsIS4lXQQz1Gz9qEs3nkt8HhUh6zf40VjBBlmOuVi5TnZOGzhlCN6zRDM+3
         UYqgNl2t3MlKlAm60a4knOwBVySODMU4iGEgtAFARXNlwTWX0zEaOa3PJ63MnMpUPg
         faQZsRDnvDyKTw+bRTNgtDBX12MOU5PTD0wLPeiAEcfvLNdUetY5ca2GkJxrk6UjaI
         3T48c1oRWeZLhEbyXsOmQcZ53oiyOD/hA6+236L0NBHc2FIdAquS9/fJOe5mwZFcOm
         hveF2AKuRKD+RwOt0wpA2futhMPRmAGPF9QyFHQqGPb3v3ejItQudqmvJwfFf2IuU3
         M5GT58+Iths0Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 26, 2021 at 05:28:41PM -0600, Bob Pearson wrote:
> Just a reminder. rxe in for-next is broken until this gets done.
> thanks

I was expecting you to resend it? There seemed to be some changes
needed

https://patchwork.kernel.org/project/linux-rdma/patch/20210214222630.3901-1-rpearson@hpe.com/

Jason
