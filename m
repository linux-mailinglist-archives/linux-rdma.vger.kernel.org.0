Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAB4310F54
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhBEQR7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:17:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10145 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbhBEQPj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:15:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d87010001>; Fri, 05 Feb 2021 09:57:21 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:57:20 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITJPqTBOnZPWWsh7clgVU3IulblLf7QNXiH6iob5qYxQOAwG1QE/SS4/o5s/YHw8qK6w5Q9iyAstR45Xd5CVEW4sApGQpNtlUCohuM/HwnDcGMJsqjlfh9E3MFgST32g4EtUqbDRWgj3NV+9uDONN29XrN/eGeC1ed0zTrnUw8v4jDGlSHFGBRhMv0iF+3LOpwIn5x9zoPAsBa1bf+DsTApq8sZA8oEO3fz0kymB/WtPEVhKqpAWFBFhimUWnLQ/lz8sc+s4C3xE7MJ9WtvWnUdMgbsz46VXLwTkOuPdzRvM4bOcR3LCb2xEr4DkuJXF79W4I8rKIXtMzn6lA572oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oZOfh08Ok7tYpfoERPUsBdG/YU8Qe6+VMSN6VfL6Fg=;
 b=HOc2YAusqR5R8Tc9GdpignmyWvyNpRkW+HNDkoY9oyN6xcJ2RfPZZOj5xrD2MkBfZzbIqKR6C0/cDJOAhEkF0quvCsnwaWs7oUjbt2AVzXPyyHsTxog7AN04Zo2vtr/Xb8/i9/P1CYIOc6MiBp+G3jLbkbnkSrKZ5P5QCBPclv5yNaL/LsUX5NCzBBMcbWOLQovwO0NPFFkT8J0xXNBM+jMc0aIsnqG58RJ7OK101EVVYqKeisosVQ3VHF9ey+cO7cCuQajRbCPwEweUqzf2B6N04I8c0TDeF7e04E6ClvJxSgzGFqe2Vwenbdhc0CmaoJoNeneNIdNJBx3UKFTfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2581.namprd12.prod.outlook.com (2603:10b6:4:b2::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 17:57:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:57:19 +0000
Date:   Fri, 5 Feb 2021 13:57:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove useless code in rxe_recv.c
Message-ID: <20210205175717.GB968475@nvidia.com>
References: <20210127224203.2812-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127224203.2812-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR10CA0020.namprd10.prod.outlook.com (2603:10b6:208:120::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Fri, 5 Feb 2021 17:57:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85M5-0043z8-NM; Fri, 05 Feb 2021 13:57:17 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612547841; bh=4oZOfh08Ok7tYpfoERPUsBdG/YU8Qe6+VMSN6VfL6Fg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=mxhCLcRBpe/jbfJqc+b5anIUWVO6Oy3ebx0RT7B2x0TLlPXylbZ8P3coqvj6AOGom
         Bwx5nwSpfnRI5hpekORDDHROjE2GiQwBrSc3Z+J5WnRYn/ytH1hCw8PBz5tdU7VfVV
         Ck+b8zWJfq3GUv+g2VzayCUZHne9WMlq7v0JFZDCu42PK4XnI42OgF0uI/+R0i0XOA
         e0oO5DDjsc0sZnkfGGCELxzO5ztCgbNqSSAY0O7A0VZzv5EH5uVHmkjGhHRf1U5n3X
         ybwOGMUk6c791dzYMU/ytL+5L1HgOEc6iIbSAPjQ9vvFbTjYlknpoMWSbmB00sJTkx
         8kqsUrj1mieWg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 04:42:04PM -0600, Bob Pearson wrote:
> In check_keys() in rxe_recv.c
> 
> 	if ((...) && pkt->mask) {
> 		...
> 	}
> 
> always has pkt->mask non zero since in rxe_udp_encap_recv()
> pkt->mask is always set to RXE_GRH_MASK (!= 0).  There is no obvious
> reason for this additional test and the original intent is
> lost. This patch simplifies the expression.
> 
> Fixes: 8b7b59d030cc0 ("IB/rxe: remove redudant qpn check")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_recv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
