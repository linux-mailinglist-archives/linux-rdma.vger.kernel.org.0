Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02FE203E4C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 19:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgFVRsK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 13:48:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:29007 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbgFVRsJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jun 2020 13:48:09 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0eed60000>; Tue, 23 Jun 2020 01:48:06 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 10:48:06 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 22 Jun 2020 10:48:06 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 17:48:01 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 17:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqSaaeoauvXnk6RgxOEn39/AAqRCsix0aXjWZ/HWaqiqNt/0zob6Foa3xJ3HwYcAOuyJYCd48qZCxU8HDh7i4h/cMY3UKLuTrn8IDXaQEnVguGneA6Hfo6LwObEZuQQh2vBuym64fcUf6MIwvluf9kBYz9vDGOeQtNEH4w8Easwa2DKAUzOReV0VsToNn/QDj4mhEiILRoVCUt73pWuAlvyN0CK1lYsl1poTqo4bssBTPUaPlvSrJBUjF6hlcWHeXGO3gXO6MrEF2ZzH52lq0JPLb0Ta76noAzeRdXKMje6NJeJhjaaOHci8LSBMLn/JMKJaesw0i1Bu9zFssycZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eksFY+CqnjhKo8xOqwz6VzSION81QScvaA7TwAtSxk=;
 b=beiCHpbGfHzJgm8qybkJmiIWDW5DC29KGO8etycCvik6ONq3TiPHZ4V2WAVD5xOu3VOS2kf30CPraQ0X17ARenAZCk4/mom61jJG/CidL/yAa86IadVXAed1tDYnZQDMQy9VMcCvXytY2GvvMY01jBbFcoAeSgaqrA57NsHpy18S7c2P/y2KWCqqaKsTbsEDDXGoB9+c5N3VQlaRt3rzr5OE5rbTNVdaxNbkDtUdT/COrKhuBlIth5ITPwomRjsg2Bq9UtIncaQ8lEyABcb3SNj0yJv2V/0e3g+ZFP1LXygdxFLjelz4Ni12dW5kQPHAOb1Aq6K0AIBHRpu8FKj8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 17:47:58 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:47:58 +0000
Date:   Mon, 22 Jun 2020 14:47:52 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/counter: Query a counter before release
Message-ID: <20200622174752.GA2884277@mellanox.com>
References: <20200621110000.56059-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621110000.56059-1-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR18CA0016.namprd18.prod.outlook.com (2603:10b6:208:23c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:47:58 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQXw-00C6LO-VI; Mon, 22 Jun 2020 14:47:52 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dcd9157-4716-461d-2289-08d816d46689
X-MS-TrafficTypeDiagnostic: BY5PR12MB4147:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41470FDD6C397CD01447D75DC2970@BY5PR12MB4147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYFuT3H3zYVKruxCYXCaeJlimnlyS8hk/XM/GCSp+PkdURZ9d1zpCW5BKotEvyhV15JaYrQ1tvgs9XJLN9Wxa2U7gAwSmeVS2dcr941JDGQnnqyxOksZ0h5F9iM/6PyXkzCoZ+wm6560g9HJmahzfmGd5Q8T7NX5FbpxflHvwi5zpgzNugZvx/xvBZqXIZmx2KPcaoiSRrXdw+QaCfPjQFk4+OPd2ZraqUAr4H8gLcJdPXARmePUbhpzcj5pnT6tN8C8jvVy1iabzB4k6nasmSqD0jwYJ6IquIaOhazo2CuAkDdFuIfb1tS5vXlAPcPw31Hgb99VM6rktlvYHmp6aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(376002)(39860400002)(366004)(396003)(83380400001)(26005)(54906003)(8676002)(316002)(2906002)(1076003)(9686003)(186003)(478600001)(5660300002)(4326008)(4744005)(66946007)(426003)(66556008)(36756003)(8936002)(86362001)(9786002)(33656002)(6916009)(9746002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NSW1/i3iMLyl/LHlHBt+zsL8z4pxytbYX6w8WBIMZB0r9bB3oEl5AcT4dE40gV7dJAWw4jPshQMXg4UogWkwQ8f4/JeOtWNgDpi9lRhAzHl8QnCkMtF4R/H0Ft4TVUecefWMmlWBcWJICaW2r6QNIqBwxe0dXJ7p5x1F8+4ewOd9zTNSEbcnp11o9OYast54WWuEnj1lI/hT65bfmE5rxySkiQjE/gA4DmXNFUr5kUOO+JQ99O78kHN0YPtZ3Ah4HhXFFT8ilvdkT2HTwcjDqEXd+gaTVXbztsxWPBOgTxJhvXYq6I5wMmlQbwH14IaZkya0PgYyF0oGmAvYEmI9H3Y8VTDZ/jajDtTUOMz9I6zI22HTmzvRAHTphjRuDfB6IULdfWHZgGkhl59NXU2Klk/0WGynntYpFBGcBSufnQWkAyUYKucQyTwmJVaveePJUS83mmNZfMo44faUMMxmnv4B1bpXmbuE1LTe2RS/gNDS44xgyXunttHxEczyZdNX
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcd9157-4716-461d-2289-08d816d46689
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:47:58.8692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kw1h5JQjSUgI63vpBc7ADHSEcWIcTStnVECLnx6rjFR0zUCpb6UVKrj/kH5LzG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848086; bh=1eksFY+CqnjhKo8xOqwz6VzSION81QScvaA7TwAtSxk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=WUulK6Q1V6IfvaphE9SxFOuJ92G/LGsJfkjd6ylLTOv1nURrMkrefo0qn8sPLz7mh
         Cpg+pzsnmG5dJ+Ba2TH0VGHXO8KBSmvOV7cYna55mLGBFN9/PH1grWugangyd+/U5f
         Ra+tzh0ZTn5SUR15tpYS4s88Dh1pKL274iU4kzZHr+ovVyiD3GRI2fT1kw2zwW8Wo5
         +mlcNlKvhbzfrsgPG6zwuL5V+yXBWDAsKC+ig3ibkgTeOCwS5BB3MWoT0++rFcR8BA
         xLtdDMRSk7pFLQruPd2dB1/ecFnmxvjbpOq9Q4tGCUDhIOw6xCjwJN5OA4zYlgVUN8
         iaAGdac8EahMA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 02:00:00PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> Query a dynamically-allocated counter before release it, to update it's
> hwcounters and log all of them into history data. Otherwise all values
> of these hwcounters will be lost.
> 
> Fixes: f34a55e497e8 ("RDMA/core: Get sum value of all counters when perform a sysfs stat read")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/counters.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
