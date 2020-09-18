Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610D526FF8C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIROGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:06:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16087 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgIROGS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 10:06:18 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64bed70000>; Fri, 18 Sep 2020 22:06:15 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 14:06:13 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 14:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx8Qp4M1Q4I9uUNqwUvqXURoYU+xF9yUvqNolxIWbdJznkaQ7TaMT6yFhl1Yi9Sauxhek0VUGGrKtlucfH02r+7PvSwq+FBn++ubdA/b0mF+8dOp5fPIDLMqJLvGBbXd66CUPHlNZ4MvK1Vzwj+WeZxpfXvAHJoRmAnMMqz2WEldLbJhiOlK0s1tov93cGrw3KF7IB8NKtnVfB7zwbQJbs6vDL+5fT4oVTT8hW/Up+wfoVZhbH/1LJW7TE0KfIB9zXRkqZ5VeLZCLXCSinC2vHaBNaWA4W65S7Zm953k2WAvQPrHxTKmeMRvJcsbKtqjoSxp4UNh7Bcm643XY8FxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDTb+wQ9JAse7iEUEk5Y++iEW1JxRxGQLHhgUOQTtng=;
 b=aK87M6KyGUJoKtudmCS/aQ4sM+LrSdbIG4JqmXPY6geaf3j+CpFvpIcw4YEnDrcAnnTUO+Lvv52uimejglpYpjtMTxkPUahRblaBORaSYEf5/SC8bYjJ3E8cvwEVSy9mLFmRcssA2hBdruQVHDWieWPo3D3ea9SkzTVzq49ZKhOF55d4xnK4C1fxpDkZYTxpL0GD4qJYsJw1NR57zbFzKb1rbySIQGTl4F2AYbFXk46CRGW6Oi5JtG6tfMqjODtZYkme6cy7EtqACK1kbhVPYx0owt2CSo+wUBXwKImUq95TMKUy/thWmudnLsWfjrgRz6bCDsa2gOWrhYLVoT8j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 14:06:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 14:06:11 +0000
Date:   Fri, 18 Sep 2020 11:06:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 3/9] RDMA/hns: Add interception for resizing
 SRQs
Message-ID: <20200918140609.GA305039@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-4-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-4-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0034.namprd13.prod.outlook.com (2603:10b6:208:160::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.6 via Frontend Transport; Fri, 18 Sep 2020 14:06:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJH1d-001HOv-6J; Fri, 18 Sep 2020 11:06:09 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db69aad9-99e9-4321-40bc-08d85bdbfeb5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34023F7224A26AB5709D7E43C23F0@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOtexIcKqG1YCL+igMn1VsMAdquOxj9BorXYNKgFmS9Hhbmyafji4Vwk+48i6YhLYQoz3TfHYM7nGkvetHbO5RAHE3cIuO2slNMDwaQ21TFFWVraf9PVOttSIUgqAjZ2KUuYGbxdWHCNpNkNU4YVbzJepnLI3x8WHKOwW3C6G/FIQtG1X3u6CAvHmoYylLTCXV8OEiw8O8IKVGfGbQEWz2XetcAw7w+HKO3bbOp3AmIcqcSReUG+mWy4tCTQwepWX+A1od8JkuHemrNgGf8psHUewE69CD8retfSt0jknYV1g+Bj7uOIaMKShpXXmHjFKq2GiIdtnmrrjtfEUJSjfoOf/SGgBrcChRzb+mnSXCpOFHK/6ks2Lw7ZQvDGYG7K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(5660300002)(478600001)(4744005)(1076003)(9746002)(9786002)(4326008)(426003)(316002)(6916009)(33656002)(66946007)(66556008)(2616005)(66476007)(26005)(2906002)(86362001)(186003)(36756003)(8676002)(8936002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mtgqc7uNPKK1qZshCzASbO4lhX0NOHR0wTrcViG48E8V8wkufocfF7sJjI+BoCTAB2g3MRPIhP22u3b/bXOlaPMwqpfD2QWHm2Ya/AWcZHfC8idLDFGquNql33y8UuLa1+H9QdLPNHBr3ME1CeM0Z7THuNmXEFM9yJXOCfJhP08ckwrO+xSxnofU/rg6g36QT5qN1tNXxPVrf9urxp4DD3FnIEgAMVgvV4HjKLp1ciVJ9G97uINFAXX1wQnCPD9fY6bE+87ReFrl52tOujWP68CIGZarY+8eGszjxReN6ccz+StDjJ6WvXL8VikETZe87bWOSUfG83wSQjNWsIuKm+ycCM84eIYEysjKcMUIs3gGwqAKGdBvnik0YFlMxvTJJbeCjXcgekmrXU/LWhOf0T2zsQo8cyTsWth4WmkMrP87wa38UssUy+wNTpReCu5XEgGJRLiEQ9Y39sQUes+KQuKTwAa00N18sdAatwF65mSesej/DD3rXm6Uv7WdEf7wWAI0fVmnvSw1s8FFw/ffBVXBIW374XMGe7nVmo3mJglvrUPvx/Gt9PaZ0Zgv/MqT1BZ+nabXXbEEVMbIbSBvTB6mfiyScmIi0lO52vNCREl5tU3MBiEr5n+nqOUZR5kHsd3lS+PlkcI1B5JtQlRA8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: db69aad9-99e9-4321-40bc-08d85bdbfeb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:06:10.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl0Fw/vR37UgNiKmpYVPqSo8SFhQwv1UPkblFL1pczIcAtFtILpRHkLPbSj1n5Vd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600437975; bh=nDTb+wQ9JAse7iEUEk5Y++iEW1JxRxGQLHhgUOQTtng=;
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
        b=OXoTLrTjND/DlvCYJ+PtTU1a9kYos8sPYfLQsTcRErCV7fsuMKHzWT4OunjSB9sKS
         kkip/ccUQh7ENaGd7PAx3MmOyuEoNlHbkVDoBhcHJYEhmoGLIDx+QUYU1Zh/eKL1yL
         vTtvrNNH05RNAPqtmMzz0oRLWkAFJX7wAsY6FBCQoa7jA3nI67Uyq3qOglqJIYBaYo
         qLOKtb1mTNrqxq1zZDOnsom9ycXkiPeMXleMypK+IFN6h5F8rziKf9ZQfcAe+39en5
         OQhyAGx4OStPVJyV72BqfQPrZQMCW1kSaD3m351cMy0eoPM+VSQVhO3nbHcIskpKUC
         spUrD5vVgnA7g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:28PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> HIP08 doesn't support modifying the maximum number of outstanding WR in an
> SRQ. However, the driver does not return a failure message, and users may
> mistakenly think that the resizing is executed successfully. So the driver
> needs to intercept this operation.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++++
>  1 file changed, 4 insertions(+)

Missing fixes line?

Jason
