Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3629EB11
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 12:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJ2L5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Oct 2020 07:57:40 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:9671 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgJ2L5k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Oct 2020 07:57:40 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9aae320000>; Thu, 29 Oct 2020 19:57:38 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct
 2020 11:57:38 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 29 Oct 2020 11:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyWkBefaZKyZDh7KT+eUhG9IJY5rMUiLqhK9I5V/rZ2XNOVM0wSXUyW313uVqAYiAKppyf/Yu7VPp6hEtoAZwz1GhwlpM0FZdLcFK0uCd0vMfF+uy3HczgfnSy5lTr0i5WoyuSl/9rzQZqrpktJmFy1TZgjBkUri0v6kB1OHiTuyfFT3JMIN3opHBD5VFFrtVoGxZug8CpAFr8/3pfhk9m8OFCSG51DKKti3q2KbvFWSMQa1kS7YZ8WTZwoUyTJdIB9kIMmwuLtw9CkU4nHoLJp7pjDFTCepgs0nAdQBpw8tKl433vMlEdiNWIzb4Vz89RMy8yzTNGe4C6v9jGJH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKoTNRWIFo4dkxw2rQj/D3BbdmP1Tx9qdTmSqba4/Tw=;
 b=e01kdMAH9gJ6+H/sZYDOA6ZJo9YNEug0v4YogErLXQuvLmmpKqrvA3/TzXJ/nsDJaZrsCD/vF6gLeRkExAH6ckfHmpNgQ5qzdZWzsWkHN+8GCeuvR+U0dAjqhdbpQ5h/wLy6QKy0FsGnDCxqFuOnJPAjb/IUTvM0leaJ2srLWkUU97xOBerxotasU09yWKzFY23+2kN13Z0J51VDkKfGhbPR93nTIGu594IB58I2zpi+oZr/f8DhYpLJxeXwcDpQeMWi9IpyseZH6blFNBkWspX3JHxu0XvuU5Zojcqhp5u0XszScsjYtX5rm7XWx6up3L++/C3kUFxCJO+3gDtLKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 11:57:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 11:57:35 +0000
Date:   Thu, 29 Oct 2020 08:57:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
Message-ID: <20201029115733.GA2620339@nvidia.com>
References: <20201028231945.6533-1-aditr@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028231945.6533-1-aditr@vmware.com>
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0034.namprd20.prod.outlook.com (2603:10b6:208:e8::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend Transport; Thu, 29 Oct 2020 11:57:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kY6Yf-00BH1r-Rq; Thu, 29 Oct 2020 08:57:33 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603972658; bh=jKoTNRWIFo4dkxw2rQj/D3BbdmP1Tx9qdTmSqba4/Tw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=IOaltoCg+rFWPEFB4p4aL1yYfX4zidIwbU+2piAumk+nCuMaFTq59YTD4GmzoDvQE
         lb6bo/KbvcA09ivhz/y/UsyT2crYKkMFBYKhMvQzGXvvbe9XBO/43xk8ICEM1qyE8m
         Gr2+k6bubBPPADmKi+7h5luKxZzGbpq2un6joa1UkPSvEIB4GN+qM2f9xu495ba9v8
         B1orEYXEkffm7FEh4ZcncH5ZdtPiXrrh15IRD4eb44/EXLsI061xPQybiyFp1QiBFY
         bZv7KaI0fiYXjYeHvhPymBwIj1N7xht7UdhTDrrsImgM/tkhEgwrWMPMkVFKQKmeLb
         i0ObmJcCeTklQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
> The PVRDMA device still reports the active_speed in u8.
> Lets use the ib_eth_get_speed to report the speed and
> width. Unfortunately, phys_state gets stored as msb of
> the new u16 active_speed.

This explanation is not clear, I have no idea what this is fixing

Jason
