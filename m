Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99594248DD7
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHRST5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:19:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8718 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRSTy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:19:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c1b590000>; Tue, 18 Aug 2020 11:18:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:19:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:19:54 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:19:54 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:19:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2cVaI68n9MhQLKSnXEcVZY+2ywPtzxHUJzDTwNEKFzYuD/TXFx0yMJ4Zjv8MXGnzWwNOweD5zND76bWoKFaVUMJwFs7RDUXsjInU1YfdBqM4NMHK6Fe2086LpH/5/OKNVQZ4el8eUvkIdrlgbLl44E0ofdPH68/dBXRe3qbRzrwYmLA1uDOUWxjVSUnlfttSC7sT6yaYRuFD11eVQez9zb1kovswZ1sr+4+s46osEIhvkOVGTOrZ8Ek66nlB2mUc5N7HQyB/Zlis+SPwSP5XVUqNsGzBT8534CO1VIvupEPwqOOWjaP6ZuUQiOG30Ih1/8usos3BTGu6U93jIOyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3W1LZK5mwnbKHhPf9LCIBgtZjqYMUeMGDQZW+dqoLE=;
 b=KK4SAM1h7zTjnJBqWjaReoR+NxMNSEaIlPGe1UxoAIbAZlGgXnDUGn0AOuvD0Y9lrGVewbyAH/GgaeXUwpPiYJwrCv9OWJg8j4BMmHzRZU4R+KsXpaEoTncMCfBUP2szoZUjxywCNDaJvq12bipD3xHc1re2jYsaC53rEBGt/WM1fZoN1tfSr6w9Bcwx1nXlRz9GSsqIEVycJs+nDrHOQXhxQ+0IZL0QVitIwfN15tre+H7P5aen1k+Bl7JY426HCyrRG+KdS7I03dh3JgAhS6UaDjKj8x0uCLYOSAb0k4/kVYg/Oedb6iQ8w56GMzwXXcmFgRa9GMH9hTHvbpQFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 18:19:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:19:52 +0000
Date:   Tue, 18 Aug 2020 15:19:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add new IB rates support
Message-ID: <20200818181951.GA2057810@nvidia.com>
References: <20200802081712.1993490-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200802081712.1993490-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:208:23e::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Tue, 18 Aug 2020 18:19:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k86D9-008dLi-3u; Tue, 18 Aug 2020 15:19:51 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 298de9ad-e3f7-48a1-6a44-08d843a34cfc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17553CE6A84FDA011281A17EC25C0@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJYowISJiVzEnFoo6cyChEj0u1yd9nwXFS190t6T/Xc2eBzHrLR7pG5w97tTWOVeV9TfIbNs6kdooLtK9nTFQdg9q/0lOFZYk46ID0ML+mbiq4oJ852o2mfH9uJZeEWwKyFtSVOH6kDPs9nVdLr+FtgrCuIjJBFZH1k/hwkv6a2we/ES/rrlJNQ0nVnHkFNZIRBJRo9BryQamTSxCiXwSs6AOb+GauOxGpc19Hiffov/XHLNqbDnm4VnnQhpShvQOL+bOD9h/DBXTPaRbKkMy+CdxIfAmFevYlbtlp197iqQBWiN6xc2Di/nUNbH0XYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(316002)(86362001)(8936002)(5660300002)(4326008)(4744005)(8676002)(66476007)(66556008)(66946007)(9746002)(9786002)(1076003)(2906002)(83380400001)(478600001)(26005)(426003)(33656002)(6916009)(54906003)(186003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AVhXoU9okFK+61RwMP5T0CBexkcaxbnH3tBkekajyg7RCBu7d5RhgyoISOPfUYFa+7VD/E3IHvR5dEKmRMLV69Y6zPM62AuNwngrcUf8G6E3LOx7zymlVXqxIJlYeUPsI8K1jXHBjByvbxv7T2As1NdkiXbjfZwb2+txpvQbvxw6bo9s5zTFgRUK+zxkdcP9xfVG8ZDs4N4nl+WJ+uZu0u71gKWeWwdbUBtKeaExQwRzCuR5Jbzbqyc0dxEqVa2Ai0aU9djTvivZEWsivwZOiSXzG5oIbWYVKdDwVEeRCklF4Mg2YnntTelSsyG1Pj/X4YHmKok8Ul2e7XOXOuPqhN8t8jf9x/OwfVbQM4C7d9eKf9GMgETlO97a8jNYtuHcCAs0yS5goaSmY/ghdwNvJNfR3Vy8remTfmh51eUzvC7vfwyV/2XY9npcCCpOO6UscGW4ri0amaD+CY8rOSeICXT0ZZoQSu7zTCJ00Q4kers2AclD1roy2cppRmbLDkXR1nxWnwJdJ0kOKiDrKkeXBRqOxQujEYVpC/uG/TNzWRD6vPxQAnHXtyLjDYM0tblHcWynaigqvtdx9jkVdLRoNH4k1w8oQnjgAAxsNTFb3+aDTXO8lKiSZNqlfRFJao3yrf5Bujom6AG39VI55e1VUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 298de9ad-e3f7-48a1-6a44-08d843a34cfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:19:52.5414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mV+MoSYFXp293J69I3jrDGTWMT7uFI9rKK/46xMBOuDP6Zk/ppCCMUemnVpa1rX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597774681; bh=C3W1LZK5mwnbKHhPf9LCIBgtZjqYMUeMGDQZW+dqoLE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=nnze3C1WUMFVb5VWh4teYJH5Cidv41WvSb0tfFNYcJCXeRNbLIn9CPc02bkj44R/r
         9XMRvykI2V/ptIdiz67DXPAjkb16RAsCrQvLOgO9Gd+yu32MinZLHvbwV3eG8aJTam
         sP4fhxy75it8EC8HBzyv50tjiiN3jGof7ekak/K3LOw25x5s+HgFSut0bhZB27qfLe
         nC7PqlQKhCeRW06ikoq4hL615Ox1bpepRsF58AJM3gWd9FHxk2mEFYvQT066rfVlD5
         1AThNM0J3SteDogmvU8MqNUa8mEbepA+Su9cny2IgvQrurZQ2mU+kahAsY7VxESoV5
         rfLmwsbdab/Vw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 02, 2020 at 11:17:12AM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Support 56, 25, 100, 200 and 50Gbps IB rates in mlx5 driver.
> 
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Applied to for-next

Thanks,
Jason
