Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAD2A970E
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKFNhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 08:37:16 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:32594 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgKFNhQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Nov 2020 08:37:16 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5518a0000>; Fri, 06 Nov 2020 21:37:14 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 13:37:10 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 6 Nov 2020 13:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaHg/qLc4c/8Hvi1aKBUYht+HUSwS1kkGWUNUfVVSBL/huYLYT2yIpPK3MMCAOkUf2jjZfSWeTbrFAB2AvGIE2r4ngtq1BzUm/buRWOJYTVZ6zT4U5NnAaBMq/2e5W7AgZcO6waxypI3Xfsg+QxACDis0hPWITmWQEUvKWJIGgLk7ttosMmMAY+Q5wrbDaBSHVWAyToXfCFJ5FzF+T5H47il+dpziK8DjJHtDy5V27BZ6U7Mf/ttqJ5ZT6wL7tuzpLpTIiSycneJMGFz1qSPTXC2tKix4BIlqfbl78HkpMQhd6qP7AHbJHUevZxHKE9io8TZds/l3sd2ZscS6py+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+0PHJwOdghkMuPgGhHB1b213OVeiJinPi6j+hiBh6I=;
 b=Epm56kCWxplkx/0N3ji0SlTJTCjUa3dTiwOo35weoE+rRRGsNmb/vntiodVljanOPHHIbzOj+aWbtkqNFNe7WnGFhearh6JfVUGKzBKhelKKRHQNnzAU949Rk0A2rCWD2VHfLZFFXUDtx7LEA4RMIZ8Xm+uBIxbODr2hI4QBH62cvkGSXc9A/JMCVoKg159Rk7OuHxQPl9MqItL/tfP2WgKoOH2ymxkSuaihDqtp6JCjRqeyiRupuLTCLW1+ErxnjclZOVVVSKC7FJrlHqDY+hIj8IWZoCPnCc5T9N819c4TlYtXYk98MJ6fkqXzvFl5VelPC/5TP/xB9+z8XAV7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 13:37:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 13:37:08 +0000
Date:   Fri, 6 Nov 2020 09:37:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Message-ID: <20201106133707.GV2620339@nvidia.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
 <20200918142525.GA306144@nvidia.com>
 <115588ae632747f29e977f6abf0a5733@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <115588ae632747f29e977f6abf0a5733@huawei.com>
X-ClientProxiedBy: MN2PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:208:d4::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:d4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Fri, 6 Nov 2020 13:37:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kb1vP-000nOy-4u; Fri, 06 Nov 2020 09:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604669834; bh=j+0PHJwOdghkMuPgGhHB1b213OVeiJinPi6j+hiBh6I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Tbug+NfKJiLnUZcst5OSTKK7yDQ4Vtdwoy/PerpNzn7RjSQDhPDl6W0fKAC5jQd1A
         JvZd23ZGNOu6p2gG2BkV3AMBveHiZjMiTi1UrWPQqOOWGoF6rgW1F5aZMd3/DJ5nCw
         +9OyDeO2RKUdXfV3veUIx5XaR4sck9ru0KI6G+EsBJDnLWPL8xkdtj7XbWg1N+NtKt
         QlsSPmYKeneEus6HfSKuW5awH4wmxMo6QIHJB2LPxTaLWCUERY4r/k0GfSnUKiWIlI
         CpUuBC8G/marRi/09mJsmms83f66zyE21ouxDce5ZhQpb9DgMtanb1MGBa8ktlbepf
         1EN7xLn/2P3NQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 06, 2020 at 01:52:57AM +0000, liweihang wrote:

> There are 8 banks and each of them has a counter which represents
> how many QPs are using this bank. We first find the bank with the
> smallest count, and then try to find a QPN belongs to this bank
> according to the bitmap.  The ida will find an unused ID starting
> from 0, I think it can't meet our needs. If we use ida here, the
> code may looks like:

I don't understand, why wouldn't the ida give you a free QPN in a bank
directly?

Jason
