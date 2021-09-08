Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF28B403913
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 13:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351501AbhIHLqG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 07:46:06 -0400
Received: from mail-dm6nam11on2082.outbound.protection.outlook.com ([40.107.223.82]:25505
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349231AbhIHLqF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 07:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3pupj8kR+xb0dLQlb4dCN1We3mroDIPC2wyi62roZz/tnM9iIgzVKIH6k3JIbo9dGW+RfWLQAL2SwKyxuwEp7HL19hxvYOCPwRTLQbVoZCsoF9i0ii3UnrEjfZ4wH22w7sHKvKOt7eqb722jp2jDwaU5mxUx8X6F0jCRVoxHdk1unoD5BHJgC4Htaa78X1BDj+hdx+u8YtyYyplGWYYFQ77unpbh8kaB7lV51ytg8wPR9gxOp53gDWqzUZHbmY+sqedFrYom3bnM8ZT1iA0Wm1/wjwR3Ic6BrTFCOFeOhjOmSKaDtoVRAq4q1N3nk2rSWp58X2deEVyJRlAEZXfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aWj+45kXg1ugWo4J5sWElTta3JkK/KfPXl28etUZ9lU=;
 b=WvxukJa1UYb+hCEztofa65z8GExBqYx2cqx0pIuzUYs/1xF1WycuO78nCbJaXzyttmHLtOo8d0DjR5I+ye62ERogzkLlbJWcL7eXBgxk8doxWbt+8xr5GYQcZH82d855GxOeYhLIDnECzPiqbVpE6k2t4t2fHOi4dpbbWdjXtvOoj/PjPwtL3ZazV3AON4MySVBVMgO6nwjvjSZnycbtSmfWj5Vpb/wGZ3SF3av2NwJ69cgiBrbCElIrl2xSvbAi68SVG1CoWw67wF2X/WOPTpf7txKfjo0E45ASJCLFPxyM3PaZ2/ATMPt0iZ/ZqybTMwU0OkRDtlZmHOZMxAiFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWj+45kXg1ugWo4J5sWElTta3JkK/KfPXl28etUZ9lU=;
 b=krcqhXPTl/WZghbfVQu/C2S6Sd8QMfGK0qmzoeau7Xth3561NXBXYYysELYzXB8xecgJGJPf21u2twU5yElDON9DHaxIMM7InYOLfnIw3MAiBpcQ7f30Lg5MrpKSuiO6mPRi0dokQ9MfjWHgigYESV7rzbif0kw0xW41bPgrcXy587wOG36VoEwHnIzaBeThxUL+wWBfECNiy+uny6WVfpnjg4MXyXsYuY/+gGXz4trPrUmN8cTP3agu3Q6ZixqjnRergckTSGUQQcxeqEIlb7GfAi6jgE3nNCCclOUOJKukfgxJ9WZEoYUMVS0cFc956HFP5ZInptytKC/FA2wXGA==
Authentication-Results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 11:44:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.014; Wed, 8 Sep 2021
 11:44:56 +0000
Date:   Wed, 8 Sep 2021 08:44:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: make hist static
Message-ID: <20210908114455.GC3190597@nvidia.com>
References: <1630921723-21545-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630921723-21545-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-ClientProxiedBy: BL0PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:207:3c::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:207:3c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 11:44:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mNw0d-00DO43-Ig; Wed, 08 Sep 2021 08:44:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 647c4642-0808-425a-48ac-08d972be149f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51584FE85CCD6E2F60C2889DC2D49@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmNmGFhrp6akvyRs/VNbh5O2fYpRxjyEC0mNL9eEE3AntE+48RftAt9bubTKlvTeB0550aFmSw3XME2ib13rTOG3L7yx/N8AXzJ0gKOhWGdQX96outii7RleAqhD1/CWWwqxQ7uL1N+qVap3CX+dl0u8kgeaygy1evSuOUGdJTWl6Ripjc8il/fwrTMCkNPcCztBOe+Xif9CIXEmU6lqrPispQ8cn6MHaspQgd+9Wp3axjAbXqTiM/goU+YV3pEUlb1vmX8rNSs/9BkzcvamCfr4esVtlilowVuIfIdtcxjNlB39Y4fSWeiG6Y7agpFCu1/W75NTX+evSjTBknOS4KPifVQSyiI7fAFhBunPq+4DMQTRci+WRX203NlrqeSeDBTC41V1rCVwVOKALd9OwE3BrXqeVK9tc4oniTuJec30JwSubb5AgBhvr16ltkBuhGC7RVt5XRWqzdjOtuc7GiAmhB/WwHqN0OHVPNHifMZgFfODf6TJO8w5ut9j34RCgSJOjIq8nnBmKZGl/fui0yrtzNKbBAZEcoW8wVm/+4WKZTyNOGvrJNwWO6cEIyYctt72bDIXh6hfTqI1n/6lGN5Ti0u2Xar8tKJv+4uw4CBUhINjhYxViiI14ovYLQuGqeIQ7sbcFhhBeWMKuJVVsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(4744005)(66476007)(9786002)(26005)(66946007)(66556008)(2616005)(8936002)(478600001)(316002)(426003)(5660300002)(2906002)(36756003)(86362001)(33656002)(1076003)(83380400001)(38100700002)(8676002)(9746002)(4326008)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fcrhsqwZB9w1ssin/indnTMxDUrnTTx3DU5e1jpRPf3Msggh8sKiYd6ASyDr?=
 =?us-ascii?Q?L9h0djq8dVLJTwxZSrRSmSMZTJWG+1mjszVnXRB42iK7RsEpclsAM3U/HEO7?=
 =?us-ascii?Q?TpAw/JrRT8zprAt2i+bbgTk8mQsR7eI6izQ34jVgH2JfchUhufEh/F35uMwG?=
 =?us-ascii?Q?a8fm/lb5Pe2Ppsr6Zsj3F1Yxt/itOStKRXoNhLkfN9WSYJpCB2nDrrICvU16?=
 =?us-ascii?Q?/ihpmU8fJe+3pvZXyNL5TIHSj8gUt0VvKHArssc8Ivrv9fD/YvXcUz+GEHei?=
 =?us-ascii?Q?Nml+Mr30+n6LRpKQnse8DtOm7wAlzytZHIg83ydsIiyrOweDkp1jJSWJkk4l?=
 =?us-ascii?Q?MbSAW7RMQ2aUC665Q24vPBXrGxZQoN1+2+XEJH4vGbp+lsqc+LAsjqA0DI61?=
 =?us-ascii?Q?tOIjqcU3JgOp9GQhJIiyHk7xdz4Cg/iZVNm5Ld7PKPoLahxFEVJZfNoBkF/w?=
 =?us-ascii?Q?fIKvd1Pidipt37nBX4aRZhmaTG0mgBZAllk5sZZFDBxFiLpTOsu07bPD5x4u?=
 =?us-ascii?Q?otiPyNWY5LcPd5/GtvoZlIpB32IRRUUGbyJmrujYlv/ROMaELcI+BeOodZ03?=
 =?us-ascii?Q?3SC6NU0VjU2LyWqaNSlArQqPfBM1Xd6YHzaTRs+QaChdC1F02nnWtojG9IF0?=
 =?us-ascii?Q?Q7vC65EYK2RQxHkpYoxrGPph8oiSrAedfNZQVj6KOcYIY5D/jjbfjp1TRoub?=
 =?us-ascii?Q?5jehykaQ1VHbmxek4BeBaNcHVua49xacZcLoCU3Zjje69aJ95HJY/R8hQr9r?=
 =?us-ascii?Q?W+sNWHUKahuHwc04atZO56pksD1zhA4vXVXhBmsLepR1bs+ZYGOYHCjj3sAx?=
 =?us-ascii?Q?32JfcQpYEgkJB47FdpWthIG4L42w9wv0Ko4ah8FIeExAzlYK/XHCi8kim6h2?=
 =?us-ascii?Q?2LtWW0PKf2OXMhnCTgYxfNz5wjUoqB19XOLmoDWRY9HeT3d5xpe6W0Hz42uL?=
 =?us-ascii?Q?oQpOQOgdyDs6Rkez7+Rlm0DJm1edRDxX6Mm+3M5B/EQdR6+TvQmG38PZ3EWh?=
 =?us-ascii?Q?XsogQn+TpeEkD4G5inGcjuv5S30OUaz1YT1sEj5BJAVOlDDKEn4XvFkjUG0S?=
 =?us-ascii?Q?tvO5jPm1d9WIZHl05HCA29tE8Q+a843ZuY2UuZJNHIhwgoH1xhdp3o8JOfDA?=
 =?us-ascii?Q?RZmby4zp5uy+TJaSzz//MBxAxm6w8e+giNk1CGG0F1vbOWEJCfC+QeaF//ta?=
 =?us-ascii?Q?eTP3UCZ3I71ylhouIsLxqYl1KT1k+zl1I7mtAOBh5FUVW+MKCR83qT+ObgNI?=
 =?us-ascii?Q?Hgi82roLLtcmRPXDWfyxyGTBnbOyO1dq7cIpwCAbeGGCdMxXxS+ePFR/YD76?=
 =?us-ascii?Q?EFhVbhjb8jTdy1YA1s5Ojond?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c4642-0808-425a-48ac-08d972be149f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 11:44:56.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I6SQGiTBtaVEaKf7vQYToUotRXMFlNNaqmi802EdOjgm32P5Le9jekrD8nX1jCT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 06, 2021 at 05:48:43PM +0800, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> This symbol is not used outside of trace.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> drivers/infiniband/hw/hfi1/trace.c:491:23: warning: symbol 'hist' was
> not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/hfi1/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
