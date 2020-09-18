Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4426FFC1
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIROZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:25:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41424 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIROZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 10:25:37 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64c35e0000>; Fri, 18 Sep 2020 22:25:34 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 14:25:29 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 14:25:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwhhJQtg22f87jFdT/lJtg3xApDStWICejviVv+UqD0PetIsp684mOlPjdhbPL99x2FNqayrmrkQsWzs5mL1NOUH2Acer40zTqvhlHN+484loBI0XcjCa5ELiLIU167CDeV5spViDR0JfKXgpWxs6gBZParm+RiqWfVEupp2lR8uHQC15xz/BwSQZfbRxIMUEJiQnxz+IuOUHt3SxMQXGSA5m9CO8h3YKS41dCoROKxNq76ixBUVb4aELp+r21kdnPMwxd56JXvZxp8yzuRjz3cBRgsp/pTAbctalKomTPjz9SiS3EkCFzlaVRlUoAYpqd29AQ+CovXy5MU67L2XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/Wd25+kwUR1MCDuJvuM4nNFULuvKfP1tSugT/usP/M=;
 b=j+xA34uc6qrKLfj+uksmPVb0ymLvHnTusCiR6k5upQ9lqLuWYyQ85vPndAHmENzKHm+9TZW4sp/OfxCzNKA0oqx3aduHOND/1SaY+VFFgGA7iv8LlDMbk+i870U+fatjDi2/s3qBpwuZGX3gJba0UCmrRf/nH55LHgbVKso1E8viPDig8MvDClkB0uQPyrJ2bPWd4uvUJyTUEFgp5s0qrmpWbWpUcW5UFwsR4VTD8Fz3nSXGeCMyW2yVxATl7ZVonkSpCIXTIuJv/SWanGaRuKpWDc2ntqFJOoPWP8nvUlGmq/FyTnjxbFFkIEpdYV9Q8YnRnMe/NGBPpnP9Abi69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 14:25:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 14:25:27 +0000
Date:   Fri, 18 Sep 2020 11:25:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Create QP/CQ with selected QPN/CQN
 for bank load balance
Message-ID: <20200918142525.GA306144@nvidia.com>
References: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599642563-10264-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0036.prod.exchangelabs.com
 (2603:10b6:207:18::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0036.prod.exchangelabs.com (2603:10b6:207:18::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 18 Sep 2020 14:25:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJHKH-001HeR-BD; Fri, 18 Sep 2020 11:25:25 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f535ef82-9250-4140-5a84-08d85bdeb00a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301860B036A1A8505413DA63C23F0@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SkjJzD9iExceHQUNzlD0Wn3kYrZEA4a75qeZUbvZM+knOCAAVU2+P3+ed63JzU5TZvy2jrcrjNl/Abrp5uL06LJnqa7zSTfuSUQl5y03/TjkCSFPPcRYoVkio676wGaEUrl1jmPRXSk+YZ9bQVrKTLT9hioJzHt8EE+5rNkObngUihzMGsAJhrcC6Orf8sZSaA3vjmlSUIIH/N0Kk9yAAC5X1BQdA7zGLLK2rTxGafUSsIrrxHSP4LJbdihCDXSLI89pa5p76vz6RX6cL9Sl8aHDWTY7YbZ4Q9KqDzeOkGKK75Crg14zoTy7jqTkIY7i9MiEcAxryxUPLxj3/2jD2gEKc5cO5Wmz7B9OOhErYFRyR3jkxOg7QNWGtHDBDI3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(478600001)(9786002)(1076003)(15650500001)(9746002)(426003)(4326008)(316002)(6916009)(33656002)(66556008)(2616005)(5660300002)(26005)(66476007)(36756003)(86362001)(186003)(2906002)(8676002)(83380400001)(8936002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mKfq65WWNBODxVKatEAeF4rhp3zcvapOrLQHN54dnu9NqH50wS8mYv6PJzdZrBs/0TuP8CFTHk0pcu26khpvrT0HpWVQXJ4jKlPBNSf2YGsOMvvb+UiXbXla/YUy/8+UwY8sdjb2Y27Tmad+p4/jJePFjqycDCd54n2XFzbsQ+LvJo0Z5Mh9vv6sKuq8eZTZQ7awOkJgILHdGMrNYxbRuRIMH8Zzz3bi1gtT6Gy2+HXuRaSc9A1544TAhqSoXzQl8xvVn8lxFm/Dx7qGEd81RtgAHK90WPEjWGjyY5YRC9LzAUvjyHL8plaAztHKJHncnsWoN1M6Ie9tvSuBbQee8beeEef5mICkIbcBWf60LQzMhMOT+SS0iISzR3NxoQ9a3uIq3fV6Lta4KUJnxJ9cr0Qttl3RNkB83mrKA8/sVryNis5hbfTnj7ezcO7XUGNBWn6PUIQMxOsWuAiKMh9YO8hWJHU9RCrQ/O7nIlndxcMiCZKLLLtEWlwnh+bZJcTTPoOv6c8um+gQ16WSW5CAYQEc2Q0vc/yhnM0v1VfTQwbzLsLDNerBzYzt50Hk1zFWUj4FjtYYHi8DULG0jpQN3xRGEx3jo38d32BjUhdkhvgf5n2DxKWCjM6/FKe5/hn/IdjZJZZqzzlycGkc7yhHkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f535ef82-9250-4140-5a84-08d85bdeb00a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:25:27.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjh3JM9PUPAjPpCz1W4YN0iptNQTpsQ7A4vdcifrTZy2yyPLnU3nT3mZVuu9C8o5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600439134; bh=r/Wd25+kwUR1MCDuJvuM4nNFULuvKfP1tSugT/usP/M=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=NcdhLGujthvW6CedM+giQrS5h/A0IVGxwpp28YohYlvObsEH/uwI6O19Op+3Kmdho
         2xaBKSkC1yus15sKCLxkqCIoq83DyT8G4JeH6htXWCi56dStk6HSffcAF/8jQh3CuC
         zUeWc85tQ6ffULQ+97sntCroa1JMDyc0Ka3Dppe+gt3i7C5zTbkBFFI7jO8lcbFM9L
         +jY8ep78BKltCIYTD6Of138ZWfOqyhy5iKvk40nFy7U/txJJuVabPSNYcWPcSOMspu
         C1dLaIb1t+u2oc8SkHgE8cKORgl0RliRbYDnT12+K33OzNVRBi1Bsb289O4dUBP3M1
         kcwRRdLllkN/A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 05:09:23PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> In order to improve performance by balancing the load between different
> banks of cache, the QPC cache is desigend to choose one of 8 banks
> according to lower 3 bits of QPN, and the CQC cache uses the lower 2 bits
> to choose one from 4 banks. The hns driver needs to count the number of
> QP/CQ on each bank and then assigns the QP/CQ being created to the bank
> with the minimum load first.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  | 46 +++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 38 +++++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +++++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 39 ++++++++++++++++++++++--
>  4 files changed, 128 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> index a522cb2..cbe955c 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
> @@ -36,6 +36,52 @@
>  #include "hns_roce_device.h"
>  #include <rdma/ib_umem.h>
>  
> +static int get_bit(struct hns_roce_bitmap *bitmap, u8 bankid,
> +		   u8 mod, unsigned long *obj)
> +{
> +	unsigned long offset_bak = bitmap->last;
> +	bool one_circle_flag = false;
> +
> +	do {
> +		*obj = find_next_zero_bit(bitmap->table, bitmap->max,
> +					  bitmap->last);
> +		if (*obj >= bitmap->max) {
> +			*obj = find_first_zero_bit(bitmap->table, bitmap->max);
> +			one_circle_flag = true;
> +		}
> +
> +		bitmap->last = (*obj + 1);
> +		if (bitmap->last == bitmap->max) {
> +			bitmap->last = 0;
> +			one_circle_flag = true;
> +		}
> +
> +		/* Not found after a round of search */
> +		if (bitmap->last >= offset_bak && one_circle_flag)
> +			return -EINVAL;
> +
> +	} while (*obj % mod != bankid);
> +
> +	return 0;
> +}

This looks like an ida, is there a reason it has to be open coded?

Jason
