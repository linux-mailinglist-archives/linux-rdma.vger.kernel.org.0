Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8351C2DA077
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Dec 2020 20:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502710AbgLNT2S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Dec 2020 14:28:18 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5554 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502690AbgLNT2I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Dec 2020 14:28:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd7bc9d0000>; Mon, 14 Dec 2020 11:27:25 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Dec
 2020 19:27:24 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Dec 2020 19:27:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G50paN20f5EfSacbjpuG7Z0zDW0tnNT0dfvTn7Eb094DW+oAerLldf9Keh90+nYwcfXVxT11jhBG7kVsgo01yl0LNgE1CP89Tco94SzJ3IYHYvqKdczhE3/A9sREopchgs8/wLuq6tmn9Stisus7ONpW6Cj8L+dkyXrWaRhAefpE35TCRrLmwubL31vmu10P2wJKkZhoZ/DkxpwlHaeFE+7CDwCEQzvR4Tou6v12DJ3Bk39Wt8E/83nLkDgPiPrdDnRNP1sDe2cwFA3og5FG+XNt8e0MzxljFH+BU+qFWIwEkkLGVsFwkJjSC2MGlcCNZfI/bXSid1q4bTSfLBx9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlT77IXDfu+iLZPv52mByUd9SjIeBF7P2b+4lvabqfE=;
 b=g9O6uILKrR64ckHxWAol6akSY+Xm9+OUau/b+PPIccjSz6xx4U6lJOJ71C6T/0QPj7T68zxNNhq1Mwo7MKR5L3Zm8OYeRzdDa2U2Ng5jrRZGodbGB70RUlr/Xaso9mMQDlIPMRFOxQtumjfySto+2kNyUba7K7v12+3PaNaigHkIZARURx0yyzAwlxIlldh4/P0Y1jucaSigPbeegLtPecsQBZmqAOerNEFVA3QB2cM+cgb5lp9fdNJzmQokVZTRY8lhYDsbCAqAlpoSLey6OpwN4IYUsvt5DgNtYBGJSuFeLGTcw7J3rZnsu07cHGCPFW6lt4WdQvDq4Sk5d/R/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Mon, 14 Dec
 2020 19:27:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 19:27:24 +0000
Date:   Mon, 14 Dec 2020 15:27:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Parav Pandit <parav@mellanox.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc 0/5] Fixes to v5.10
Message-ID: <20201214192722.GB2551375@nvidia.com>
References: <20201213132940.345554-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR1501CA0032.namprd15.prod.outlook.com
 (2603:10b6:207:17::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0032.namprd15.prod.outlook.com (2603:10b6:207:17::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 19:27:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kotVC-00Ahkf-Ec; Mon, 14 Dec 2020 15:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607974045; bh=NlT77IXDfu+iLZPv52mByUd9SjIeBF7P2b+4lvabqfE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WU/R8iDcHzJqk1i6KkucaLBGvW9kzvEKI9xT04kMfSnBdV9ga68qlh8Dsa57GknKp
         wjUM8uSY61db02RyvhP7XTgVpfTMdg/mwx0t9YDzr728pQ5r6oVRKbVtaPTbrkXuTh
         YLIsGHwoL+CMDZ0vOuKzx31w/bIUsOhI64Sda6MwhwPlTvXXSIba1+tSW+Cu4fMDpK
         Vbxm0HXCDgNsCRg0n47FahYufTmCurjoN3jDnxYwPIX6GdXZ/nLq25bl9JbY9DxtXz
         tNAi2w8ylomUBaAj9ZFeS1VerTwA/ywPUhNmfj3FjnSC1RtTpSaj8YoFH6sMWX1jJO
         uAc8pjpP1SnMQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 13, 2020 at 03:29:35PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is another series with various fixes that can easily go to -next too.
> 
> Thanks
> 
> Leon Romanovsky (1):
>   RDMA/cma: Don't overwrite sgid_attr after device is released
> 
> Maor Gottlieb (2):
>   RDMA/mlx5: Fix MR cache memory leak

Applied these two to for-next, thanks

>   RDMA/ucma: Fix memory leak of connection request
>   IB/umad: Return EIO in case of when device disassociated
>   IB/umad: Return EPOLLERR in case of when device disassociated

These ones can wait till next cycle

Jason
