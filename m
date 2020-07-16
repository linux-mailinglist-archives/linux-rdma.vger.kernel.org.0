Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CE5222B8B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 21:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGPTIH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 15:08:07 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:48041 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgGPTIG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 15:08:06 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10a5930000>; Fri, 17 Jul 2020 03:08:03 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 12:08:03 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 16 Jul 2020 12:08:03 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 19:08:02 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 19:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA3pPg2nYrI3jlIANRcvQYk0IkwDBI7YuNwSWJkiLRDQ2xSFfVm9Llc8XFXv4Hv5wUHKZcBJquhL4rjPcAwwflX0rz6iDf5sl2FXYtxFEQ/tGeA51nrp1YZKYcO4MwaDz105Pxr3Fkmm3SvCv0BWalgQgdQExw9FvmMFgLRkD3/h6FWEZaab2ECzF2d4W5ScKgGtRqEr4V49uyucQpI6XhEznjH/J+hQfKPXTe/i0y0DQKzpmYqYmvFYwM+ykbXKfY2mOtqUHw7vvSN3iKCf6ePQPThHd0wzC2TGF73OQIZ+oi1wjvDi3S+Efn33wC4jtrkv9+fMkACV5uM6bgyL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DG3fnMKcYNUOdfeTlUNVV9EL6c9NvE463zYPFu6Snmw=;
 b=i1rAn0Ja702Ndo6lMgEpRackqrZtZQTzKzAuNi8NSgIDd1+kUxsoixnlJ6IPtac56s4c+/SxtDAmGn4BNQA71ETVV0/Ku7lN1jxl/IWwRhbJX9O2gjDR2mqUDTOKe2IXKYy1OIs60ZC5pqvdRs5MlofkWJ3xU6rJOX81jgpGI3t4DezlVqVwd/vZL0dc9y9SSwqHQTFXdxlofzpHXaAHsqPJsS9iC+wVhBhyzcMyFNd99BHC4CIqX2v/6Kmiu2IsTdvv+jtg6ZHtvfbPGXzZIyOscUnX//Vtm3gSmZ4CqPokmxH3I38HXmKiRgf9nj6BXyXmV363THx93HZCNbZG/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1242.namprd12.prod.outlook.com (2603:10b6:3:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 19:08:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 19:08:00 +0000
Date:   Thu, 16 Jul 2020 16:07:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <dledford@redhat.com>, <aelior@marvell.com>, <ybason@marvell.com>,
        <mkalderon@marvell.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-next 0/2] RDMA/qedr: Add EDPM kernel-user flags
 for feature compatibility
Message-ID: <20200716190758.GA2682412@nvidia.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707063100.3811-1-michal.kalderon@marvell.com>
X-ClientProxiedBy: MN2PR22CA0022.namprd22.prod.outlook.com
 (2603:10b6:208:238::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 19:08:00 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw9Ec-00BFpD-VX; Thu, 16 Jul 2020 16:07:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57e9a00c-ffba-4eb0-3a44-08d829bb8ea0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1242:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1242649BEE7AA13E171682F8C27F0@DM5PR12MB1242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbyU8gNnHr9nsOm57qZF3F9sSdYIPcM+PWfXVGxS97FaBUIj2RNZksjthJuP+TbFOWapPCYvH+rbVyHc0J3gEbVBe8h20gOSRwD6VtoijM8AdkTHjCL3dyQtS6iklSEVKfJinLtm8KyE+jawVSJnoyLrdlRRkUwck1Hmh2dRG8bsrSFBlhiACcFrsqCrrApZSwbfHDzN5WWf7YASwbAasYgtTdmMR0UZklPQJfQvM1wfB6qeXzMKMY+1VUqcwnTzK4hRJMokMTUYopgtQ58dkp1GGa4XBOEvl6piebhObF3feO2by6Bdq68eQi7Zh111PGL9+V60k5M5RP0/0UyjErQqb3LQ0BWDftuVp+aGe7Tdj/W8hTPFbwDsWiE5CsarPVvCgkHIxYcnBydisHwJZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(8676002)(186003)(966005)(2616005)(1076003)(66556008)(8936002)(478600001)(66946007)(426003)(36756003)(66476007)(86362001)(33656002)(316002)(26005)(83380400001)(6916009)(4326008)(9786002)(2906002)(9746002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AQYyYr321mXZ2VCisfvSs+OTQxKfpSau9lzZgIDoyYteS4/pGpbikeS8HslznqQW4Rd4+fGXY9dy4XS0LbzTNtWu8ONbZBcjfqGvTHylHpg+9qfiEnp09fLpGnjrzTz6iAYSFOwvsYhH+pTJlw6eFeMUTqeb0sKodgPfxvM5TDpRvGf0KUwFDXjwTWYj4lnTlMZ9C3PpG54AAlEzLtTba80892p80ofytT0EGqWgjycoE4X6sCYyzsrAjXJIHVk3NPDBy02RPZEveqOmi88/xjXsVdsAr2XXgSxr4CQDxHWbhrHOJ9JcpH3Yxe+p1Nq6buR30wwGCXSWFf+g/F7VVcUi18cr0NfQcJEclpL0j8p0hFm6w8xN5E9EmEpNSqujXQn/JGVvCJcY9+sBeXD5wjlM5DHT2Y7rLGy7+0zu7ciReo3UnWd58n+phtZBns79Vv0IiNXK9/kkjRi9FBGR2Ak5gQfEX9NSkPQx1ky/V6Y=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e9a00c-ffba-4eb0-3a44-08d829bb8ea0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 19:08:00.4651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVPoKzzqh7kVKWv6g1NVavbGIA00FnBUq9haw+JW28FtAblmZdgYc9PYPOVffaww
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1242
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594926483; bh=DG3fnMKcYNUOdfeTlUNVV9EL6c9NvE463zYPFu6Snmw=;
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
        b=aoSxz6CqcJRPENz5maatJu9md7C1nnKjTkO0fIpmj5yYvCx6lIT5ZdZmpvG6jg2Ag
         wlD4uShHva/2PQyhE3QWyTKQ6HqUqfwD504XasF6slEBM1oqMlianDS9tW+1OeW8oq
         xVEfByLANiJ0V4siagkvYxm65FN8+OLPzOkIyj5Ym0qfejN42PONBGsgUDyGAxqaBo
         Tx3GAEya4hJQLstNnQ46NXEv1VPjp0P9kdrtq+lFnYCMgS0b/nAY54/UiqHRWKS7xk
         aN93sbym7Tw0AW1oIrA5TJkLSNUA4R2cxfEI4hWOHOCU1XxZA68xFhb4JJbEVXX7l2
         1HRa9JluVUJDQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 09:30:58AM +0300, Michal Kalderon wrote:
> The two patches in this series are related to the EDPM feature.
> EDPM is a hw feature for improving latency under certain conditions.
> 
> Related rdma-core pull request #786
> https://github.com/linux-rdma/rdma-core/pull/786
> 
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> 
> Changes from v2
> Remove mis-use of !! when checking if a flag is set.
> 
> Changes from v1
> Add explicit padding to struct qedr_alloc_ucontext_resp in qedr-abi.h
> 
> Michal Kalderon (2):
>   RDMA/qedr: Add EDPM mode type for user-fw compatibility
>   RDMA/qedr: Add EDPM max size to alloc ucontext response

applied to for-next, thanks

Jason
