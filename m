Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14452300CBB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbhAVTeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:34:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17816 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbhAVT2M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:28:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600b27230001>; Fri, 22 Jan 2021 11:27:31 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan
 2021 19:27:31 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Jan
 2021 19:27:29 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 22 Jan 2021 19:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mluwH5B0V9t64Qe8OrZCUoRjcyxcoXyaK63PUxuG3NukKvAcEfS+H87oOW7bsO4POGP4KBFk0Fa4eaSK9dBCaQ9RTuQ6aMqlfyDmoIgJ5ADNBDMG20eb59mG1vmt8SZtBPUmDcdyWWIB+yd9j5ZbITbc57bU8/yp+n+bZjZraIm51+X9fK7Xa7Aco2sHGPGS3zhz9IRDYKGe7iqjgB+sKOIzDjXw2p3jCLq56h8A0MLJIzmTJTFevYhNOkrJ0ZrBwoqBJCWtpeTS1COuj3gK6yXShAIIHmD1rWK1RpRCjYIQqbsrGs406YWgn/BoiUjM47ppGgn7NalnOdbQDJ9TpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxlKRPbqb2oBJ1dvorSwa0JzBqMggQNwkn6HUThDw7k=;
 b=cIbKYWLq10j4rZVjGE8JY1PPlmfd90mTtECeWcKdbJzhkWJ8wBzZh325Dl0jEptYrTUkZFv6BQpvKOyh4lpdvT4OKEC509wsY8Pe2pfPIUVy4gh1ZF1AOxkDGT0xvkpaEldIwrQCNMTwd95cc4v0iaendpCScuOBNJi4iyVPDRg7aybW6n6yL6KDM8DMMWtvaLMD+PRGJI+OlwkhwQMYhvegMhLlI8qt7ppI/8zrUyNdoRaXP+esFNt+lGfw3eyDHhFdzlcKir9wAAJMayd9tGdU1S8voJmlyNNbK9mxTJqz3wmwIJniLhQ1yS3IfCf6iINsHt8NwbeKy5AqZga2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 19:27:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Fri, 22 Jan 2021
 19:27:26 +0000
Date:   Fri, 22 Jan 2021 15:27:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH for-next 2/5] RDMA/rxe: Fix misleading comments and names
Message-ID: <20210122192725.GG4147@nvidia.com>
References: <20210122042313.3336-1-rpearson@hpe.com>
 <20210122042313.3336-3-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210122042313.3336-3-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0220.namprd13.prod.outlook.com (2603:10b6:208:2bf::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.6 via Frontend Transport; Fri, 22 Jan 2021 19:27:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l325d-005c6R-20; Fri, 22 Jan 2021 15:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611343651; bh=qxlKRPbqb2oBJ1dvorSwa0JzBqMggQNwkn6HUThDw7k=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MtXsr5aL4QzQZTQCvBq3MC2Je6UEFUv3Wh9WPbpQ8fQhPYycGkRgM75WopBldpGPE
         gfdCVoSW6QURHznPyCXcii3fNFOIBY48UxJovBWvLsqp3KkoUx27tgUQ8YcfeS/sKn
         nAaFsKpwoAO2bkiR1isJFKu7j0mgWkvqz92adk7xKHjmAv+PYbxXCP/8Jk00qje9Za
         44rEARVHeH5B9fq5Q1dL8ejeW+jW9ajULA1cCjzLr2HcVJuWEOwejXZGxRCFCmLxzf
         Jp9NRsfkyNCTaKvCseJLGCOCGU7ObdEKyfuc0jvHTX4n42xPiUHGlG+5ZiWsfKZ/Xn
         HrfL2ElgTWXPw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 10:23:10PM -0600, Bob Pearson wrote:
> The names and comments of the 'unlocked' pool APIs are very
> misleading and not what was intended. This patch replaces
> 'rxe_xxx_nl' with 'rxe_xxx__' with comments indicating that the
> caller is expected to hold the rxe pool lock.
> 
> Reported-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mcast.c |  8 ++--
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 22 +++++------
>  drivers/infiniband/sw/rxe/rxe_pool.h  | 55 +++++++++++++--------------
>  3 files changed, 42 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
> index 5be47ce7d319..b9f06f87866e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mcast.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
> @@ -15,18 +15,18 @@ static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
>  	int err;
>  	struct rxe_mc_grp *grp;
>  
> -	grp = rxe_alloc_nl(&rxe->mc_grp_pool);
> +	grp = rxe_alloc__(&rxe->mc_grp_pool);

Everything else seems fine, but this trailing __ is too weird

If a lock is supposed to be held then name it foo_locked() or locked_()

If it auto-locks then name it foo()

If there is some #define wrapper then it is 

#define foo() __foo()

Jason
