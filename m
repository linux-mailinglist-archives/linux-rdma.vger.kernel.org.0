Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A018925E16C
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 20:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgIDSUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 14:20:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17531 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgIDSUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Sep 2020 14:20:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5285230002>; Fri, 04 Sep 2020 11:19:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 11:20:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 04 Sep 2020 11:20:03 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 18:20:03 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 18:20:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJJaJhMM/acbxf/xvV6wqbX/vXLCMwsJn8OVXzSukvpEPWcc3fMB0xj/khCUQcA8rLmKpWV5RnFz3y82Ky/offDBKLOhL+NUzt8JcOkGrUJDhrlaw9tGslwudkFvP9Pjc2Qmt28X5YSmRO++Dvw6nWthik0E2cD4UlrT/PQIPQ9BgXACOk05MIFAjaJqCDO+ivs3dfqzBeyiY+D8osg8h0W2qvxWw31TrhuuGJv+6zAqC3CVqx9qSsjsOAW4KQVRCxgKL8rbBrWx5htBVDwTKFl3AWzs2ZHWYjb9FCcdvRCDpNY1fMObe4eih2l1Nu/wC45zAN/LNCwFqE/rK1eUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnAmq+LyRAR85Dk6LSOa7DIsARbi97dLn4rVXSsjK38=;
 b=lOsGxemq0cXT7Vnav7vagcLS8mphEIyJca52Nj4iuou8VktHPETNwfVcqAltf3SSGHgMnRtZwi7hJ3tu6nv5/1eNqcg4rp8GCTYPOuSosEniVP0g1CGkvlA64eYvtaCkSZQxrvAD9TgWa800mv9t7hYZ7ZLsKHl/0PYV4TrHOkYyeCEQ+6yWA2Lo/yXI/qh5nE28+0/HBjgQaMg/ahDoJSIskBHiHTj+xPHYNY83TY3ml+V5G9SBLkO8YZjPGTjgvl71Pq7+nqBkqDbdU6VkGMSFw7U8PoyYeA/mMNdGpVgpVZFGqzO4CgY7JDyIm4sc5tRGNXwZihxrrkP1y/WRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 18:20:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 18:20:02 +0000
Date:   Fri, 4 Sep 2020 15:20:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs testing on rxe
Message-ID: <20200904182000.GA9166@nvidia.com>
References: <96da1311-18a6-f6a6-be18-9ca034ae1d7b@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96da1311-18a6-f6a6-be18-9ca034ae1d7b@gmail.com>
X-ClientProxiedBy: MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0029.prod.exchangelabs.com (2603:10b6:208:10c::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 18:20:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEGJc-000N06-Dh; Fri, 04 Sep 2020 15:20:00 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66294c19-7e3c-4547-3ef3-08d850ff23ad
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB010754CBB091D8916E28E4B8C22D0@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0guM3xE8i4G9sBVlKhjDCsRp59BIo7TryZSVqp+XuTiRGllbIXn7RfXAsO3ACZ+vjBKFHDJ1vOCJig34sTjUaEgnNKJsztCtlyvnhI2WOnq66Dr8BVpHzed7B349FfTQ9qUxF3EHCgH4sOroRhkIxkJc/BhfC0MNMyTWrvufpd+rOVY4pOzyUesLHVwntvhJ/IDgCuYisCHRHSN9EYXImajWATd0QRgoHveg/c6jGBBjxUj6jiRPi9X2n5dPavrdKRuyrmsYsN0erOk+2T516PMJ3RUIw11EPeZg2EP+FPlfll2vNy36QRu158zoXj3q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(33656002)(9746002)(426003)(1076003)(4326008)(3480700007)(478600001)(6916009)(186003)(66556008)(36756003)(5660300002)(66476007)(8936002)(2906002)(86362001)(316002)(9786002)(2616005)(26005)(8676002)(66946007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 01AA38EfkhlcvtIluXfx+wWsz5ZYgHR4CDCGvFhrelRFJMNThfctJfjYqqszE8Q9zx1TeM8E+rESXc1SJpDFlvaJL+mnoupGKq6ZLmDA/7+pyCKkLwJYAWpAiRH0hpI0Nj/C5TbfYE/sNBnCAioRkWtBYMSwTYK/tERbd2yV3ZjVnzUr8wv4tHM/5gWR7aw1/vai4DpmdqAkvCnlGIV4p+hDzJquDg2XAz907dJiA+xZm6RgHb3lHtS0RUffjElHVzm+ob7zHDkzemanbCN3SQ6N66dVI43rpjBTC5P+G2jqmoNEkbLkyXDtwLacvU3B8y2fQySErXGQXoEMIj2WOBfXvGWP6Whh63GTn1d0kO2I8h8EcjV/Kw/1peet4GzDuYmwJA4txwJ0O8OAtH6Y2a3zaRXzEOq4d4DKr7Ger+1fFec2sgia4cEaY+vqYr9GMXQZMMNoxzMnXTRcRqvqw4lNWw5nfzFYjaR3WaRfGFnBm8K44w9hWOss+Ytp3qRW044Q+QYscIxeDFy2b19ItZOZayQtq/j0m8bAi7C0mCQ8A9UpfiIdIuErmNla1yaBrw9YVuks30NFV9qgDZSoyypnxr0CGItc4lpPDDQ0UjJ2tGYRBqsyTEAug71g2MWn3o3ieYe9ZanGEqXPqVZUhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 66294c19-7e3c-4547-3ef3-08d850ff23ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 18:20:02.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0Btr6LeHXxmzjFeEAA82UiqdVMa/4GxLKp8TwyPjAHv3PlerWHOgWr5ZIWONjJS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599243555; bh=GnAmq+LyRAR85Dk6LSOa7DIsARbi97dLn4rVXSsjK38=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=SLOHu0l7QlF7+a0jxMpap0wNqqJBWRU74q3XX+BgTnTxt8bC7ugffatyoYT+T5ti+
         S/O+MFciJ7WYLmSYGNxDQBhlN5b8e4doNJf5qEfH8H3VlfdggVf5XN85zy8iX/a/Qf
         lqs0bwdmOxEnt+YwjrCB/NATBHV0sPj536BH5DX/ZkH4TPSmnmsqlKautHF6XXHNHl
         3C2m4m9JsEWsrqEAF84+Bxbb476jr0hqH1I/tzjlPkr3qmOso3j1GGiRIiSK3g94FZ
         0gXFEgQcRqd1DeVb32gPYAISZivRTwH8qwjhOBdpAA5eTDSJPfzjYRPmxMyu428aY9
         oiCzAZALnJVhw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 01:03:40PM -0500, Bob Pearson wrote:
> The unicast IPv4 address is 192.168.0.21 which does have a gid table
> entry. The multicast address is 230.168.0.21 which does
> not. Presumably the driver wants the gid table entry so it can use
> it to provide a source address for return traffic but that would
> just be the unicast address I think.

What is the call stack like around this?

It should be using a route lookup to get the src IP to map to a gid
address

> BTW I got around the other addressing problem I was having by just
> adding the eui48 IPV5 address by hand with ip addr add.

Hum, seems like this is still a core code bug that should be fixed
though

Jason
