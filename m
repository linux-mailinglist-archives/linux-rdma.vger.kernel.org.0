Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B782A3769
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 01:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKCADB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 19:03:01 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:41640 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgKCADB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 19:03:01 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa09e330000>; Tue, 03 Nov 2020 08:02:59 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Nov
 2020 00:02:59 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 3 Nov 2020 00:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzuSzSrDEi+PpeO6vfqv9veCr+4JoVTysvvFV+gLaojwqHF3vhucXbss0J381zN09WPqNjY+htKhqmxUwu5YblDqGO71GGsZgi2xRYFVdxjDtqTUh6z7YmN6kLp2d4XFI3lF07tnHEmi9kxoTY1CB1CeVn1MDiHWKl3FsU8AKRMecXleE4tVwZgJK1nKCO7ePDVYxfIIsRvR5Wzx/HPnjfjKLgHJXIg48jwQRuBWJTp9fbvz/ZfbrxqqAFduEWf6lu3gOiSpj0kH3yLSI57XiSTb0ZPUgkp9wBCjbixoRtI+lXFfLnqstDjxwaqb4LZAp/w9Qu3427QXypkjgYFhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEWTApxt69eLdJiVh4Bas5DprF8ni9T6ufOBEtdjudo=;
 b=DUi7uwOrHf5mDAfTFm89SmCLH4Y7Eu3ZYdzRoLO6N0+xAZEn3YqLnfuZEJLAMzkHL6WGzFAn1aOyAf8+xDyIsS1z/B6RHVzXV8/IwdO9d4yV7VsN4vJJ4g1u5jiopKYyKVgupJn6rwoJAs3ckdUei+1o41EKI8ESrT2EM7NiRtnQeamvvy7NpHKZx89ocM07gxDA2Rf279Er465g0eq3I1sliExaPTzlpXj2O9Uz2b/BYR47cZ/F3vrntnaCMF5wymM2Ik+FMnMiZ0/NLzcGqWcBQWvSmDX83d+HtJ/rf2Uu9Jf8wm8Ws5HcFqoYf+WZsfsJg8m6PWJxIorbhq2s9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 00:02:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 00:02:56 +0000
Date:   Mon, 2 Nov 2020 20:02:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
Subject: Re: [PATCH v1 for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
Message-ID: <20201103000254.GA3741762@nvidia.com>
References: <20201102225437.26557-1-aditr@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102225437.26557-1-aditr@vmware.com>
X-ClientProxiedBy: MN2PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:208:fc::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR02CA0034.namprd02.prod.outlook.com (2603:10b6:208:fc::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 3 Nov 2020 00:02:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZjmo-00FhQs-5H; Mon, 02 Nov 2020 20:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604361779; bh=tEWTApxt69eLdJiVh4Bas5DprF8ni9T6ufOBEtdjudo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HW8VJaq2qy8IafKQ1kAvzYkqZ6U/IuYH/MN/+YC9QbfoNuPRpKDMmdOmND7cs2mLZ
         h9qvNsd8zebWVMhivpbls5mNRGg5t269BkdJy6RUxm4awkeQ7Zqpwu3x3uIxuuSnUg
         RLUE4UTrbaOyHPSHoAqUiwKsXjGhpTSQo1I9UgMBiabbCdmJv9hdLRWum82fYT3F/O
         jnGggcMI3m0lCdMaw6I770tv+muyhxcHqcEkJffj6UUJHZFGfsuqKrsddjxNka9NZr
         Ze0e/oLV6qP8K6oOHMtz6j5Spb6EoxvsrNZ/Jh2Oqv2vQ0Y5VWOi/J7vzIUHjR94Nh
         tWgIKrNiWBAcQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:54:37PM +0000, Adit Ranadive wrote:
> The PVRDMA device still reports the active_speed in u8.
> The pvrdma_port_attr structure is used by the device to report the
> port attributes in the device API query port response structure -
> pvrdma_cmd_query_port_resp - and shouldn't be changed.
> 
> Fixes: 376ceb31ff87 ("RDMA: Fix link active_speed size")
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Adit Ranadive <aditr@vmware.com>
> ---
> 
> Changelog:
>  - v0->v1: Reverted the structure layout only as per Jason. Updated description.
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc

If you think it is better you can send another patch to use the
ib_get_eth_speed() function

Also please send a patch to move all of these ABI structs into the
pvrdma_dev_api.h - ABI structures should not be strewn randomly over
header files, it leads to mistakes like this.

Thanks,
Jason
