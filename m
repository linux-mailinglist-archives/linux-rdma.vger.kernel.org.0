Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99B4310F57
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 19:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBEQSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 11:18:40 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11518 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhBEQQZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 11:16:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d872e0002>; Fri, 05 Feb 2021 09:58:06 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:58:05 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 17:58:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 17:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4XqDSw6iG++dkcir/K5stZ1ABq32f4V7xF1hm0TqIgYpUND2hh/RFF2IN8oO4YxYFLWMOHXjJcvoHefCf8HDwxgMbc6QB+sqEjrNTRP4eMiwx3ZMtAmP1RITE4N2QfM46fq8MQf0EZcs4uNQf1OPQudWCJ5EBwfHUuX39w+WCozDlojZ10u2dQ2B6j0GzW674qA3FuhJRuyKLNqZkwT/FYZfIhS80KhiVXEdtgEQ5dnIm6fmzUqK7QxRfd578sPt14q32QJ/1zW6SsCzMKu3YdiJ2Tq+uPCqVBK973Sb5zpYZAWtdZuI9tLH7uFQ4D88D1pXfi6Bpx3OH9YlV3MXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IiQIlY/jLy/se1U0h4syI6bexJdmu2bWMmxHWbFQzc=;
 b=IFCowqIN8eltQ+a1J+FHD29hzOw6WDfOz9M/NUSM2bLT0d01y99kVEYOPwjqM1dO2zpAzW2yNSuRcyNxAPtXlwdyOI+ioa77362a72+pNrFGVkXdRp2BkgIE8BiHpG9idCaDPSMX4Tx895/+hAxBeh05gQfNxoqquWzcMyLBh/8DIVTw+TPpzkAiE7/qUoRMDb03YV1UNe96QJjNJ2gc/KNGxnztHmPzlq7XKyP36TcA7Q93mSRCbLYeu2sZbLHJ6x6/gUWqU3vxFcptsqN1gFpV7XhWD5DeS7ms2vNl66PQnoLGWJHgxypD2Qyi2bqiv06emJ+2zkSawWiQ9ePb2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Fri, 5 Feb
 2021 17:58:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 17:58:01 +0000
Date:   Fri, 5 Feb 2021 13:57:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Correct skb on loopback path
Message-ID: <20210205175758.GD968475@nvidia.com>
References: <20210128182301.16859-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128182301.16859-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Fri, 5 Feb 2021 17:57:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l85Mk-0043zs-Hz; Fri, 05 Feb 2021 13:57:58 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612547886; bh=6IiQIlY/jLy/se1U0h4syI6bexJdmu2bWMmxHWbFQzc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=HeIuv6YzsesZGikkbpJ7PbmdAWpCyTCRKBFfV5L+vUkzWgS/78dmWtJea7N7m4651
         I+SjKTtyEftXv0J0zATjL9w142ODaSWS9mxwEvH3LZsVYR160ykUourh/6AKt7m5zR
         DcSt9qsNvI1eVIGZX3mGbPAVqOjfVbCYY06mdJyqSAW/tx8JwGYNOEVbrFawvjTFu9
         SBATbY/XgJwRZBSJCN3KW/y83ttSfrY/3oKpLBqcl0YsiM6LEEVYRp8EoavQeyd5TK
         oqOE9jW5WxqMS+kkAti5T/H6pwgUlJo9whXDrAY+nzMZ1jweLeJYzL8AKSOg2jPc8f
         hi/cSGVaTcn1w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 28, 2021 at 12:23:02PM -0600, Bob Pearson wrote:
> rxe_net.c sends packets at the IP layer with skb->data
> pointing at the IP header but receives packets from
> a UDP tunnel with skb->data pointing at the UDP header.
> On the loopback path this was not correctly accounted for.
> This patch corrects for this by using sbk_pull() to
> strip the IP header from the skb on received packets.
> 
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied to for-next, thanks

Jason
