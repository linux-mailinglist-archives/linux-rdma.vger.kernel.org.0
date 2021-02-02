Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244C130CFE8
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 00:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhBBXfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 18:35:48 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2917 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhBBXfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 18:35:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6019e1ac0000>; Tue, 02 Feb 2021 15:35:08 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 23:35:08 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 23:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReDmRbhSaP2li1ho81weX12ZrN2kjNlnAVoGimpIEjNPjHpIiNk9NaO/zi/nLj4Gremx2e8XvV0bo7OqF5cjIT57B+eGTFE7+nlNHq/1i8PB7leDN3t+m7hcoCgSDMUayzObkFFFH+8SPBHc5CVVwgRu/XstqxDO0nvPPBEzM+LwPlvSRoSwHBYNjeAWUaRiRvjmkfKZkQe46ykKBKdbU+XiaS1c827xbsK9guzRkeVMmX++ryoCsXBF7LNu4BjisGBQmIExu9U6Wx2/UQ9RnGq3o+thv1OavzsYEGfYp6cxP4tk70Or/L+xHwqRRei2fVLfn+WkE8Iy9BXzG/Pp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8ac65KVrCoieCpeGVYGXLdbkyckNOj6c6UBO4Ln1E0=;
 b=AwbhOzD2Symd+6RTWmSJg+PYC3lymn7c8zLICtj5HnPxVwXDMmNRjaq+oOpcv7r27Cv1T//vj1xBVx70PDkW+k5MtteCJ+9uU9cXVpA/DnKHmXT/s2XcPuwKWAIJ+zM+tnKv97YM6JBnAaWich9G8RdcZwJj1iGVBPaGKeVdHlyJphvcLWaqDJ0zBDhJtxPAvW60tsk1RsixZigZdMK4L2GPfvTx+1Izez8QZ51qtJ5XjKjOnfBAFJTqlflrOsYtsUbxfn8/HWHi1Qw7Sc7GbLBFwUjL+O3/ojNXIBjdmL9HtpHi3mqaQiQfctw2mDcJ+xWi7rDJkgsIKL/x4k+T+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 23:35:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.025; Tue, 2 Feb 2021
 23:35:06 +0000
Date:   Tue, 2 Feb 2021 19:35:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next 00/10] Various cleanups
Message-ID: <20210202233504.GA677751@nvidia.com>
References: <20210127150010.1876121-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127150010.1876121-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:2d::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:2d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 23:35:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l75CK-002qMU-Ht; Tue, 02 Feb 2021 19:35:04 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612308908; bh=P8ac65KVrCoieCpeGVYGXLdbkyckNOj6c6UBO4Ln1E0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=CjpQ92HV5Q26kMRHDY4Ahs6NmnRtdeas9q+B1S8t1g6D3HDGiUMFgrnV/iN4wNp7u
         IcoKpw93T4vyP4iA04ej2mw96B6KZ08FKjNlYbVnNX400SKPeZXp73uTpqicSYny83
         zfrqto5G3d2X+6+8vr53xCyp6g7Svb9iSMnTe960iUZcCroq/N8fQ/5j9lBhdFkKjq
         17rP7nOtcnUTdhUu9OVU77pGRgdV5AHlPQT1+U6VNI5QfhqsQatRewdW3oPRKLxBh3
         bh+tB2Gsj+xdT9Rwoo8kh5a5pSR/TUdUfKdpG4etcqXyIrbhRoepCxjhB0qSoEPk+8
         woFAm/qRbEfVQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 05:00:00PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Various simple cleanups to mlx4, mlx5 and core.
> 
> Parav Pandit (10):
>   IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
>   IB/mlx5: Avoid calling query device for reading pkey table length
>   IB/mlx5: Improve query port for representor port
>   RDMA/core: Introduce and use API to read port immutable data
>   IB/mlx5: Use rdma_for_each_port for port iteration

These didn't want to apply, can you resend them with that other thing
fixed?

>   IB/mlx5: Support default partition key for representor port
>   IB/mlx5: Return appropriate error code instead of ENOMEM
>   IB/cm: Avoid a loop when device has 255 ports
>   IB/mlx4: Use port iterator and validation APIs
>   IB/core: Use valid port number to check link layer

I fixed the misplaced hunk and took these to for-next though

Thanks,
Jason
