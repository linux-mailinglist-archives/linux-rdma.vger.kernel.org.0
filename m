Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 542B314E42A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 21:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgA3UnT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 15:43:19 -0500
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:6082
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727089AbgA3UnT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jan 2020 15:43:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJYryHWdV+SvQUdCRnTZvezZ+9OFiiuLefD9c0RT+GW/YahO9jsIwY+WhFkFdBgijyRypn/Y0t5EB05pUeaRWTcTqTeCGDFNB8UTQS7cWflWTD9TwNnreo/KarW5XQ5p9/qg7j+tsDegA9A7MXC0nuUgsKA9+gwDontDHX4wOOWNQFd8QaXjh/7l+tiJMwJ0i9pE6c+vKLqf7VQl3+MOfSL4D8mTDVg+ecWoAe6hwWltOnhcqGgAzYS3YZzDU2T8U37fqbJTFpBDCyu5nRB7UyidQXGaIncvAI+hsiuoZn9KUe0Xu319Mrbj+bU20wC2Ppv3QGt1BYTb/Q4ISC4/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtVFfNLYmnC2Hie3CusV1y5rvYGBCFUAz7V3986lOiE=;
 b=N0UKTGKwh+9TB70yqSskccPHsjBogvqGd4w+eSPpPIEYR7nZVI5ygFo5nnxHo8p4es8UjyTC1ZiaqC/jG9HdloYcmOviYTQKckNy2g9lahWDPJXzoXJAhLFLFN9LoeArp1J/Wz5zQKCuyjvDfLx+DSJec1JwOpNvMFchJQp9fUZP+0oJjIN452K5dMO6BsSNIXMlyI/h5h167YtG1xRuaBWhHC1ai1tQGt3qwnwo1fQsIFtg0td3JzhPccwyXwzhhfgX0K7zgaHzDabFnYAnvN6pBxZtszMqRnIi4paJoL7ZF0nrJ3q8v5V8XJBu57plF76mKVME6XRUW2sv3He+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtVFfNLYmnC2Hie3CusV1y5rvYGBCFUAz7V3986lOiE=;
 b=lftES+26FBVrG1b+kjQbKlrLE62p31MavYhCkHm/yHqhNl4t2stjcBx5E2Pq00fP35CSGlTutyDeM/l01UN7Bac8TLS68hV2LKVo+jB71ag34i+ZEzUjFW92QqQlyCkjXVCg8Pa1hP7wSS6T8F/sGpZp4XVAMxL+CbaYvOYcQYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6640.eurprd05.prod.outlook.com (10.186.160.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Thu, 30 Jan 2020 20:43:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2686.025; Thu, 30 Jan 2020
 20:43:15 +0000
Date:   Thu, 30 Jan 2020 16:43:11 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix compilation breakage without
 INFINIBAND_USER_ACCESS
Message-ID: <20200130204311.GK21192@mellanox.com>
References: <20200130112957.337869-1-leon@kernel.org>
 <20200130153426.GF21192@mellanox.com>
 <b619c5ca-dac0-cb02-21a3-68dfeb59cd1d@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b619c5ca-dac0-cb02-21a3-68dfeb59cd1d@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:208:120::28) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Thu, 30 Jan 2020 20:43:14 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1ixGed-00042k-La; Thu, 30 Jan 2020 16:43:11 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0716e06c-a0e2-48c1-c88b-08d7a5c5078b
X-MS-TrafficTypeDiagnostic: VI1PR05MB6640:|VI1PR05MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB66406D1F28DBAD8DB9935006CF040@VI1PR05MB6640.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 02981BE340
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(199004)(189003)(54906003)(8936002)(9746002)(2906002)(9786002)(186003)(86362001)(33656002)(478600001)(2616005)(36756003)(81166006)(81156014)(8676002)(4326008)(316002)(26005)(5660300002)(66556008)(6916009)(66946007)(1076003)(4744005)(66476007)(52116002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6640;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97v/O20KpBJM6+dN+hvwVHFSSApt0jlqNdM9nemw/Oxud9WzgbB353f2j0HOwC53K/cc5QpvPx/+3ty8CIpekWTfO0XEUW11CXX2aUjJn06b4rkQCkfItcJ8vZp1JIV+17r9W7OMt+u4gkZRl/4mbaAkCfdVyVQhMA+hTKN3dIP4lcSOkQqQhK7VqI9Sn7Dma1iTZOUidmbJ1kIapK/R053A1fjN0I2KvQ2OIZzfGPT/6FPEvISM/EHW0ZLQAd24+rYkK0n2b0vrYta8LWfvKokIxjX0cLnN9Pu9A0YDoEjov5Ek6TpiuJxDchcDTJGXY+IKD1+1GeEJ0k7JZ+lNH7UQe7qylLRUmEt05haVNPzIfow6k3btQaL+TUULHnQnz73QUmAAfA41DEj2xpR7SDmM32l7XmAO3AM9M/q9wbFUMDaRWnHZuAyIF3Ju5PJVrkm1Prtqw3IbR845lCCM7JoOeWRJ8mjU/v7UFCq61QCpUmw0E3P41L57A7vmckF7
X-MS-Exchange-AntiSpam-MessageData: atiBTsVEiNdAs8b6edAgKEMkM9IbYaERl9Lvl+Me6ViGJVreRb1yectdWnOBIjJ1McrBVeaEm1kJN5/fCm3bcuAbCreBub37HOX0C5DZXH0P6IY9hI+8gB2uRUPYckAMwPrGlbSmtpy0HAL/eGndUA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0716e06c-a0e2-48c1-c88b-08d7a5c5078b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 20:43:15.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNcgbBb6jykAY+KaKH0+HRjgzxnjSibOkcU5GXgNnH4kYO4sbKgHpw/Q7hm1//g+1qPSlwldqR9k0cYC/9ZbmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6640
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 08:26:03AM -0800, Randy Dunlap wrote:
> > 
> > The compiler now trims alot more unused code, including the above
> > problematic definitions when !CONFIG_INFINIBAND_USER_ACCESS.
> > 
> > Fixes: 7be76bef320b ("IB/mlx5: Introduce VAR object and its alloc/destroy methods")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> Yes, that works also.  Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, applied to for-next

Jason
