Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADC231E89
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 14:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2M2n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 08:28:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39194 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2M2m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 08:28:42 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f216b770000>; Wed, 29 Jul 2020 20:28:39 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 05:28:39 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 29 Jul 2020 05:28:39 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 12:28:38 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 12:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJqmm3UaP0dqn1ylc5jgmBNwPXiYqm69pug20g+5CEnqGypR8r1OmCiPfNABzj8Txkzdauy4OdQRxHhJjTeP7BNCFlY8TSmwbD28KUQ1dmzv45tfP6L6RywzIHLNFqRKkx30AdV1vjksZkcmrDJY4SqmI3zozRaLqiz+Fzw2y0+NgS0Sub2jL+nJBgnD+jNmPCw5TUBSgAvFr7Zfnm/gCOWFUbbgFTR+xltzyuh+3SAyRMn1KicPOD+BGj7q3nkKJce/KFNUp4QT38ti9jF+X2iwcR3lTWRQXiCG0JVcpd4aIxicGMrdbXsBdLMwDvVdqiAyaZw5ugMhau3vbnZlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFy7YFHEB3yuqoWUI+zP/ZxZUs7Xn+n2+X0IIOtltu8=;
 b=DfSEAea272NxUIl77V8vtA60tchjQszy1s4vUa8FuKpa1keCktzGxCC5l1eZDD9yTf2PKVzTYNk0svIU7vOv2RjeXkZ+TbsbZJFnQstY7EVYrHyw1DggJaLFs45ZBEakIunttbYrXyMS+Q1rFmufR8O0BgBmPHcIlPAJYZoVRfmSLpjA4ecVoUPvdDfCUiLKp+tsTSDDeLvkH0onMwj4d/+sHkIW2h2x47Q6AZcKHnlgqv5tNHlzxHhgObLEl6Y1VMtvEHoeip6f66w+lOp56Uz6THi8BvIvPbjaZ5ucEdHK9gbtuR+qcd0UnxlWOr3QfgAwjEqsJeX3LdWWaWk8mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 29 Jul
 2020 12:28:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 12:28:36 +0000
Date:   Wed, 29 Jul 2020 09:28:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next v4 0/4] Add support for 0xefa1 device
Message-ID: <20200729122834.GA220079@nvidia.com>
References: <20200722140312.3651-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200722140312.3651-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:d4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 12:28:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0lCE-000vGT-Ih; Wed, 29 Jul 2020 09:28:34 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15d0fe0b-d60d-4095-d23d-08d833baea1f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB175471CF6F267739095EB724C2700@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaJ2J/BW95BrLK1Aohgmvacc58BRD87udpElxnNYfh5FPjb1AZnLc1j3Zl5eE+8iEhiD7aLMGaw0DxGTpD8HvOzbBl9YxuV9bftz9ZpMyKRFZd0BSk4gv+V3LtLAXv8nuNkEwOTc9DFpKTmsxaqARCXyESuzREmJZbzwg8U4T4Nn0/SgP1RnFdkDGKHPhXoYiXZaxb7PtCxoyC20/8jdwcm4i8LTuswARafhkOj0h9NcuvDWhqd/23tq52PtfALHA1SDAzQje93BRZj22sWPSl9OfoTQjybHGuutM0WpXI+mxWvcuPhbMzYkWAcgS7yW0+7B7S1WB41nXNOqGlKFWdHy7IaQRiykloUe1wn+iGvRgB8qMe85heS6kBNo8XgOcFFRuPhHyzlr1B2/XJ/SszyZC+xTFVMgZKx/dcz0kY28Q6yRRWbOyaFoVAQuxKIuF09guLKMyngqCfwQ2plt3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(66556008)(66946007)(66476007)(426003)(33656002)(478600001)(966005)(2616005)(83380400001)(6916009)(36756003)(2906002)(26005)(8676002)(316002)(4326008)(1076003)(54906003)(8936002)(186003)(5660300002)(9786002)(9746002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AddgUN+feFZMvdXo2IqDSbzVm1spJwtEHHHeD/Mym4TOLX28JcqlbLmhEMjcX/YmEbWzeAZQDNVTm0zCH8XgonrOeZzcFgia9Xh/vMZO2QI5/hN7yVVIfynn5xtkzOAkMXpJqhDZXlvK2Hl9cx3KY113cTAUOUZJORZz3gEuX2DfvKADcOMkvK6wgokt+QfgLExv9QwULrWtAqLHJ8SONCiCVgFwCt73emAaqM4EddjrDjwAzWchDi92BoFOyT1V2JuL0I54Dq9hKxaDWvTrJ8emA6d84bCV0HN7DT9ACT86km3I2zo+0Q8MXR0YzbQF54gezR3a87Ci+r1LHaP1DfBJ3uZjuXHAF2CkXn7T4F25ZCLJdsTJq7Jk0FMrktLgsNyPO2/94KN5NNrAc+S7SN8NBICbWwuuffm3iO5ShweAwb69WZNK3NVJdHcyqm0xXLI1tzb5V4MPGhhZBL06kuuuVUjSLFeiX+VlZTH+lIY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d0fe0b-d60d-4095-d23d-08d833baea1f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 12:28:36.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jCb8UjootaN8z6mFUniU6fEmOfWJjLnD2q5pwo+7/w1eHopJg2Vfc8Axb6VxNet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596025719; bh=TFy7YFHEB3yuqoWUI+zP/ZxZUs7Xn+n2+X0IIOtltu8=;
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
        b=gHq0UyuvYAdK4JHrsBPa3NTUIN8zH14BMOR4Xy5qX1+6nlASRt1xMFlCBUnMJbOdF
         u0eP0iIlETJ155/3EO4OS7/Tj3KT28POE3B4wfpY1JF8EowXGQcxcU0dTHObJeeG2B
         yMVgWupWGftd2sMwmsIAnsybUhSW7g7CXqNxOwfzoCM+7LFllpWlx4Vkei2ifzEHP8
         IyPXnnlVFjDNq14nr/qg36//y9yDTSm8HoD8mCiWBIfqU2hlDBwpnXaiuSVbOM70EL
         ArrlEa7KHO2I4DBgiDjNQL8Su54BBh6yapUPzhVyMWj0c4HNGtkSxJySsWGuzZ9/hG
         UcXslJyGilvdQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 05:03:08PM +0300, Gal Pressman wrote:
> Hi all,
> 
> The following submission adds the needed functionality in order to
> support 0xefa1 devices, and adds it to the driver pci table.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/789
> 
> Changelog -
> v3->v4: https://lore.kernel.org/linux-rdma/20200721133049.74349-1-galpress@amazon.com/
> * Remove the user_comp_handshakes array and use the macros explicitly.
> * Make efa_user_comp_handshake static.
> v2->v3: https://lore.kernel.org/linux-rdma/20200720080113.13055-1-galpress@amazon.com/
> * Remove gcc specific stuff to fix clang compilation.
> v1->v2: https://lore.kernel.org/linux-rdma/20200709083630.21377-1-galpress@amazon.com/
> * Add handshake with userspace provider to verify required features
>   support.
> 
> Regards,
> Gal
> 
> Gal Pressman (4):
>   RDMA/efa: Expose maximum TX doorbell batch
>   RDMA/efa: Expose minimum SQ size
>   RDMA/efa: User/kernel compatibility handshake mechanism
>   RDMA/efa: Add EFA 0xefa1 PCI ID

Applied to for-next

Jason
