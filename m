Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71A3992B0
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhFBSlZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 14:41:25 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:35552
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhFBSlZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 14:41:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYW2Vq3pryTMqG50y5lUKNBWcac7sobffUI2L9rPe5RcAgMRDB2BYe2Zu0BfHyiFYo3MqCNBh82KKjBientYEmWhvoZdDnMzKr6QxIeQWb0TEkMO70oQq6zBEMO1qWecRdKeR7HMyy5E4SWruQL5JXlkDJCQETN7hyYgDL/UuBxnr+F4tRh0AFp9+3Q1x11J56dTShopnlS4Bf/vwwjqdoEzIcwByynz3v52WvaQbkjxx0Oa/Jw8PHms+onz4vMhmJQIoJjbcoRkhfuMN/SVnhPnwMEv/fqEdUU8QEZVAMfceiw3a0MLvcdzltQNycSdr8uT0Sl69W6MQn9QhT06qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxO7BkMRFUh2X3fHOhv/RMeQTy8lLoWUXBEFRrSGsBs=;
 b=MkN5hPtRRZyh5zt293/WbEVDBLoLLiMDO3pqllbzAzPsXlLWY2VUjVSj9hCDsXCLSm/EawUTCqlCWkec/tamhXwJI9VP/G5rVxIle77LVKl/FTzqBTlln5CCgEZGNf6ESlYD+hEAuzR2glHYQefPc1M8V14A5GM38wixZJev3/pxRIMvlkP37nFtOI+DusLhpM3VISuYinAbd4NONAhymrK0MGQShBg1AnkmXSvHQ7hspxrP0vWPAXVz7j1hmi0pxZ4GTPEosyJ1vKOLx0vUji54I99szR+vzrCj4JOpxlD3G2YcY3BUv/mljnpSMG8cvvNOMVTW4As7sau7iZUMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxO7BkMRFUh2X3fHOhv/RMeQTy8lLoWUXBEFRrSGsBs=;
 b=A7hVyTqDVr5reYv5fQ7a1tUQ4djFeIZNXr9i8fMsY1Wf4hwz268crSJ7s0bUdncoQ/q8LPpKca0dHdssvspOujJ1JqPqqwrb+if+TuaWeEzGwq72izw9XHs3+d5wLuHHs5YKC3JcjlemhD7yP5OEQlGxZZH4Xwz0482A2ycbEDZTEYWPG04L90kak/uU271KDUQqwnNuVKNU3qm2yZUHx0EY+mvnMGukKSlBqkr744/8wZw8nodFeeS+dUt47CXU3VazioWZXeigDrqeHYeanFMQoyMF0niZs5N4VcPI91xZzp+oMMiOkdjRkxRqpOyt25q9AqGGVDnq5AF5k+FKwQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5111.namprd12.prod.outlook.com (2603:10b6:208:31b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 18:39:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 18:39:40 +0000
Date:   Wed, 2 Jun 2021 15:39:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Sanitize WQ state received from
 the userspace
Message-ID: <20210602183939.GA124521@nvidia.com>
References: <ac41ad6a81b095b1a8ad453dcf62cf8d3c5da779.1621413310.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac41ad6a81b095b1a8ad453dcf62cf8d3c5da779.1621413310.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0447.namprd13.prod.outlook.com (2603:10b6:208:2c3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Wed, 2 Jun 2021 18:39:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loVmF-000WPW-Mm; Wed, 02 Jun 2021 15:39:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4865c70a-4cdd-4cb1-1529-08d925f5c83c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5111B9B243123725C795D609C23D9@BL1PR12MB5111.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leH2tzJtreckg23JBQjn7WlrFzYusn9TEVejxqTsUMcoduKRVzU4C1brWykDjytFgg1S35Ya5/xlqX4N0JcxGgCqQbvblIBG6SLoSGZkMdwci+4+TrTL4PT72w18W+S1Ng6LEalPYoQTCCJ3nM8+8weiB4yI1Vnup/Iv5OwY5EYCn+9LTuIaZDVXDLuRO+BgbDlR9sAF9JWF0vuOl5Byi7gh0K9ZoUdL0yTkgCFIczKHHTTjP7Dm5MJFCTWsokddrwnMOZsPcXYIsNW7Jx5eU/Vn8Gp7pG9hYt24NpWzPo/jr1CzakVVu8MX+YAVjNbYFC/fK8sKG2JpSaxBh/lnOmfEtfOpgvuPIXTcLiOaD/DdxJ2eC/Mi/96xQk4m5qk05I88sT8/nuFSbCvjoRLabi7omubJcwGOFVmtcQq85z0ijCJq1e01DwOD3BCg8X4XpCxD/crcLq22WVKtl9VqfmQ309XBKncnCmeqLM9+1oJC3ElUKTvJ66z3po9cH0zI+3GlC0XgjeWMrF1Scw8hAuALV/MKaLYR4MXvzjvNeMdWkXSRR4eZqOs+5jXpgP0nhThK/7dScewrYIVDrSfn9NaGIGcyZwDEDLrv7FI3evsmv/LqiWK8KHHmKEyMuFLo3XX0YtnkC3KUInElBDfVZvQITHx2Gj8GfoM9Bn3Uh4uzYlWi63fVyjDsOvkCdH9ovGGLCtlYF7hO+jibcd2OT5gVxeAGY6Bu23HX87BWFGtbvOEjTzmAnIdcNMFFxfGgk1bGo01Y4WU2e1QOpD22wZBEciSYTY9ySv5qaTxXwT4x/5IaJflvVubuz6WMz5lD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66556008)(5660300002)(498600001)(186003)(966005)(1076003)(6916009)(26005)(36756003)(2616005)(83380400001)(2906002)(86362001)(8676002)(4326008)(9746002)(33656002)(38100700002)(9786002)(54906003)(426003)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Bv6HB3/rqMzwNDehlKsZU89Njy+0fMs9QpiQ1AqNlazMuDRgnrYx1sNbhnaEnWt1PYp2+ADPnBrCzOqJRgKq3BmFL+UnRdECHc2u2WZtllvc+PjAcnrs22keuGKVJCXkooV+51qhhdLUp2p/UnwlopdNYrq0N8ZuYkwIuLZaSUdo3i2S2K+KSBTthFYIv/aOIcBQE5lUj9cYqFCqbazUN2/e4V5v2d+8ZQNPZb0s16y+cR1s8wIoW9wcn35+LJNBX07evLzN2AFWiEsXBPO1tuLZumaK6t1n1ZlznDWN96ezwVMCUpqg7WlgJ9DzUjYLSoMTwUPO2DBnL57kqS02UgmT1scjmm/kWuPLAXcTGPypqAHNk0GF9wo4vf611thIM3tVSHDzSGgB6bNd2f7huPW5t4pnEa3Y3a9ZiVPPp7WBfexUzOFwRGKvslFRPSIaSsr2l2Eo02MGVihVGrHkG/tejCVAAXM2YrRIXCSJDq4fexmgbjkHJ8ZX1SqB9+q5DTeJlvf0Jqw05sUuzq6eDikT/9EGmRM23twL9p+wpwtiwj3FKxu/DLYxC5y0o9vQeDa8+aUzaum1OHD2NuQiokd13uRBmKV8+c8hAfl9mXnOuBdtw0oyL90jrVKGhWLxVbc14CQpMSErEogT+VZqzOjMD9bNgoYUKHgRRd0XTRx/7gHExUrZn4QAP2d76OP3LcZb2H63j+V3w8hlcx05WNbi5hvS5RUPKaeGKnZdATRFgOyyhurS7uWNJDZSP9v3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4865c70a-4cdd-4cb1-1529-08d925f5c83c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 18:39:40.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWH0d4MDHPuhBglKF5jmKfvF2f+OFvclCGYkQHa+oGd3N1WXlcXz4EiURjiaTN/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5111
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 11:37:31AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mlx4 and mlx5 implemented differently the WQ input checks.
> Instead of duplicating mlx4 logic in the mlx5, let's prepare
> the input in the central place.
> 
> The mlx5 implementation didn't check for validity of state input.
> It is not real bug because our FW checked that, but still worth to fix.
> 
> Fixes: f213c0527210 ("IB/uverbs: Add WQ support")
> Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Extended commit message
> v1: https://lore.kernel.org/lkml/0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com
>  * Removed IB_WQS_RESET state checks because it is zero and wq states
>    declared as u32, so can't be less than IB_WQS_RESET.
> v0: https://lore.kernel.org/lkml/932f87b48c07278730c3c760b3a707d6a984b524.1621332736.git.leonro@nvidia.com
> ---
>  drivers/infiniband/core/uverbs_cmd.c | 21 +++++++++++++++++++--
>  drivers/infiniband/hw/mlx4/qp.c      |  9 ++-------
>  drivers/infiniband/hw/mlx5/qp.c      |  6 ++----
>  3 files changed, 23 insertions(+), 13 deletions(-)

Applied to for-next, thanks

Jason
