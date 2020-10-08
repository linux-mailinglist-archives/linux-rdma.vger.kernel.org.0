Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE3287F29
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbgJHXdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 19:33:42 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11648 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbgJHXdl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 19:33:41 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7fa1d30000>; Fri, 09 Oct 2020 07:33:39 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 23:33:39 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 23:33:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcyyBQS4SOXdYtRZKTT4UimfnErNK/DQveqYdCnD9RGyTYY1xoMdFEk235S6sQkvh+TPjozEr/Xoo0mKVcqeKdAypmNcK9B3hNsX+hvNg80uyu1S4NzmLJq/l2Iwt8YMXSJV2v4YOBV+ETk2CmBMLGskdWen3W2plecHRpzCUNrf6hFI7JuyiINarULeomcgRauwjpzWTYuyzNBAF6ZiyaL5LlMULUYe1K4KysCufd+sA7y1Fwmjnocp8BsvfG2hgIyOpcwXvYKL7ZIOaWHwyMhE7+Lt+O97ibc7PeVymyF4UetGCPF6p9jo1CNCisnBK9nJnjk56fdDpEZb/1Uomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEakdjQbuum2hEXyGWgwDKyg/jZqNm+d1lMzfNZCVUU=;
 b=URBQjDG9/jj6ct4cWTEeYX49Sm2gJvyLcU4dbNpnoC5YTycD2LskPzyc9rXZEs8yMNyCH4g2kW3anGpuok+dROYiEZM2MS+CuFJsIZh6OVr4A0Ga9cC9ykBD45JV+8CzfzxQp/fNSl7SQTRzumHyXpZIaGA4ofh7Co4PE4enBmEQ0IgmNJ0eVADs7ArZ3uK61hPjdc5MeRa6Hag3KDjnXD+kTgcvCsPz8wImINj9KB6E2EhjzNVdf6Jqi3EqpspiWni3kVRs/xk9svUA9Mwhk5ZE/U6Y3nGkYzkagWPCpIhlPABGAieu/V01o6+g2I06ggbx6Ue9VT4QWBa0EyJSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Thu, 8 Oct
 2020 23:33:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 23:33:37 +0000
Date:   Thu, 8 Oct 2020 20:33:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] rdma_rxe: fix bug rejecting multicast packets
Message-ID: <20201008233335.GB422633@nvidia.com>
References: <20201008212753.265249-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008212753.265249-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:208:15e::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:208:15e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 23:33:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQfPj-001m5B-PI; Thu, 08 Oct 2020 20:33:35 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602200019; bh=sEakdjQbuum2hEXyGWgwDKyg/jZqNm+d1lMzfNZCVUU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=DiQIVrzyU6sVpF4vAm8F+W/3q8joCwRFDF0arzyHKg+Ma8F0gIT/pGald1Z0KQG2n
         gnnYBRpC8pnFIytBuTlSe8vaEx3ooHP4WMkl9h6H9qlBMhDKDnIwbTFsnqV5TK9myE
         rVQIYRI+H7pKtRjyvarqJCE0VytVIbzq7SHG6ueEqeRHl6qpU3tB2zM9kq4/tRxSKG
         PGj98N8OJpk02Lzy3rjbYVudpC5x1CqcYT+u+hj1R3LS63PlP15syE+zZGyYaXrZNE
         g7f8/D8Sy3fwYcCTZWQw+Xxt+rig8fAe7NlAFVGXRxWDlIxPupqSAbXb1+RnkaNviV
         KZrX/01tUy5pg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 04:27:53PM -0500, Bob Pearson wrote:
> - Fix a bug in rxe_rcv that causes all multicast packets to be
>     dropped. Currently rxe_match_dgid is called for each packet
>     to verify that the destination IP address matches one of the
>     entries in the port source GID table. This is incorrect for
>     IP multicast addresses since they do not appear in the GID table.
>   - Add code to detect multicast addresses.
>   - Change function name to rxe_chk_dgid which is clearer.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Looks right, was there 4 patches? I only see three

Applied to for-next

Thanks,
Jason
