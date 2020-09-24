Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F32277C2F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIXXKc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 19:10:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:53606 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgIXXKc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 19:10:32 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6d27650000>; Fri, 25 Sep 2020 07:10:29 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 23:10:26 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 23:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTLDnKIlpXeilTyGwUd2QzYF35iqtVZFj9rj/eUe7evnP4gys7t09Y0Gs5GyPVdAdQ8vRJArEd4DNDwF3qeaT6QKCB2CDGLVtPwPRKbWTD3TBZXkBOTOacgMvkk/T2m5g6mpB5Y9l75EmLjEvue5a5fNyr9gWEHHoHI5zvrt13ndeQZZ6SYYKmKq1do5cOfuOMnvwS075OgAMN/IQt7zPI659hbkq/8VzcbysQacwIrKAqHlHJPILuxB1RG/ikxUfi2ygDhIxCNTWGQknO3KZYAmOBbHNyD3LS3M+KkCXOYriH/14N0FDGrdN3CG58LHUx9Ev+z44fhD8WJUocBHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z5drjAhHvr/NqvlNJKF3Z0Zy/uhlpWZw6FtA7IYkSs=;
 b=JgWPmezoWP1r5dDZNNbhI+t6ueCf4jN7y0HofhWrtv5YY0iRjvSsywzH1gpUivy8oC74p1qZZtoX/5kDKAfUGwe8j3iZO7ncSHa20EDRtmYAX946MX/6xHzFlUkorBNIt3E3e6qVjWtTfCjiruSQLi7vYUjuJpI68TPxwHLBwXrzULp07HFuVFYgU6OPKxxeQtwus/C4NgSpmFsXxFBqGWdsJYD985oy3OU55iN5RuKZFvhRdC9WJOmOaWPgfQewXr3QTfITeip1r/ZD4NkzG5iPtP5DGapHfCm6lhLRjCtivGafp1VCQIyqRCyrIu20hVf4m326SQqaM1Ueo5LgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 23:10:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 23:10:23 +0000
Date:   Thu, 24 Sep 2020 20:10:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 04/10] RDMA/mlx5: Delete not needed GSI QP
 signature QP type
Message-ID: <20200924231021.GA154642@nvidia.com>
References: <20200910140046.1306341-1-leon@kernel.org>
 <20200910140046.1306341-5-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910140046.1306341-5-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL0PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:207:3c::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 23:10:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLaNZ-000eF6-Qh; Thu, 24 Sep 2020 20:10:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82bba8d-a905-40b0-29c6-08d860df040d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487F75B91221E768EA2ECD6C2390@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLrdjS1Eood+bbmMuEefqRApve9SgUk4ns4LGtCQuCq4hDlFUzirZBSeMmmvhUrMFLHHwWIIysJqfBkqvnoiTZGYwrwQUKkgyGWmhTBC0hgqCrTjed7xaVQ3hYjJIcBnLmFHfR98rM27XxDesJWL9GjUUhgRMbVZOM5bX2xl1IUPH4M1YxB4VzlhDwAzES1PiZE3mKFtcwdvmSCLMcD9W93EjCngy/Biwa3fxLyOGJyXB46FmKIWjNITJKuCiHhuYR6tWrTocRh/KizEnyB+/AGEO03Fl97rigBO8bW5EPJQeeajxu12q3UUR28rd2BK4YOcHFy1+mq+OtmmEBRed6vkEaXJn+PJOgN51SuahlWLz3TwKsVE4urNH067UB6Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(54906003)(2906002)(316002)(4326008)(86362001)(107886003)(426003)(5660300002)(66556008)(66476007)(2616005)(1076003)(478600001)(8936002)(9786002)(36756003)(186003)(9746002)(66946007)(4744005)(8676002)(33656002)(26005)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QI4kj+zmI5nqVzb8oYJU6GBmXj47KtWsiMHDk/SYqpugEe0lLvVIJemGbXxZkZTd2A/eq+fbm0PTA8zZW+svKk1KvUnKNR84bturBV+qQeIMtUsY0zuJ0RhW2tsLvhDPa4XMw3YiHEqYHi04Hjz8kYcBH2lzl9V4TTcxuJVQo/TnRILmvp32cWblOVmZDBLCvAjYB6ncGvVDD55xyXJh2U7d/VYoF7lezKRTVVaUBr1Qdr35mnNaUhb6YJnxw/3aEkCD+stcglPvAhHJmuy4f9PvWrhu/iis0yPJVGr6kkscririLr/7o+O4yDhects02FBAIdYv2E8rQNmf3NS2T786JjKZQhEnY+1gjRWXwGeTLoqLw2zXAfPy2mz/8ys3lzRnlf1A6kXY3hPNeJsakwvHr+GGI7rWOTRkbmo4g/GOmohPTcEXGsgPXiEjgtlb9LbvpLJBb0v5Y/o2zeRNAM3+IQ8KZeqBlOGj+5phkqPaoLO8/QwH5x3+u/Lq7rugyIZTHjl8XWoBfSXqckVJkC1vMpn1McTwEeO3Ux9b3ECFm2cfYl4wxX4MMDLEoqjt6PSRd/PBIlcCL3XB5kP0z0SC8dX7ghRfO+gdzwkeauySUvTc0t9iHaMmr5bIkh3a5j9i+ki0FJtAPMN+DlSQxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: a82bba8d-a905-40b0-29c6-08d860df040d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 23:10:23.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izNOV0iUHGDg2Ceo5Sl8zjXvfilO4lDxa4wP8fELFhz0FtECZYU/qTA3wqXC4+dm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600989029; bh=3z5drjAhHvr/NqvlNJKF3Z0Zy/uhlpWZw6FtA7IYkSs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=SuZlierRpr8LNy3swhzllfxVT9if2iVAVB2CbTd+DtRj8/I5GkiK53YqwaTCgY4LL
         XVzQoHxTjuPY3nqHLSO6iBnXCZTAimxt+PtVjXktOR77+1e9aEUek9FpKNyEgE5Ux/
         JgDhHpk4MzXB0fcuROvSKG4+PDUps/myZGZhaHwXRmCGD2rHxCiqxtJP7CQ7/UYBoO
         Av00SJ3eTBZuG/6gCkaGFSwZvetWWJvLsQ+S5RS4h/0HGluqj5csKPPGXC4hHHoh4B
         Jm8ST5kxvnMELoLCimja88ARkp60TvrfkEupCGKw5cKTkIdIhA6cWBUlSgvR58jY3j
         4MhyOAKfKqNCA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:00:40PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> GSI QP doesn't need signature QP type because it is initialized
> statically to zero, which is IB_SIGNAL_ALL_WR also wr->send_flags isn't
> set too. This means that the GSI QP signature QP type can be removed.

sig here is "signal" not "signature"

Jason
