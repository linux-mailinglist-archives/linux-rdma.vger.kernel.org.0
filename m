Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2339BB02
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFDOls (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 10:41:48 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:31969
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229656AbhFDOls (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 10:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7pfsVL1r8zBUv52SWq4HqjzL6uhvxMI7j5CQ+CjOQX7K+hcgijJTpEgY9XHAVM2bca7fTs1QZQhPJl5oxxnCDtvIsou8vPIPExkDlXHnMn6Y6mJ5qvMZAsUpezoPlyxTSDCeWvQlYS1cZAv+kxeWIX4JGMNFZI6ClQnM/NJzpbHKMVhoPH9+H6mSY8ht4bl7e/Ll42A3GDnP+X9S1jtFJExzbGU1rjWtegockPMn47O8IXOAN8ts4vu5TVJH88wCtb8fqZ/GAw9tZyDz422BrAwfHO6PC3BvYPnFoGqqg2SSuHOWI02InYJmzzSiArMUWUXmLwPFsIqasQC41B0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPGGhSZLUCgkqRi/jBVbdxTrakOY0ttYCnd2y2Oghe8=;
 b=GHZmAWvS25OMYjNHLvu3CUFNJEDzKswNSjcjkWUfEsnbU0PA0dXDAsMWO5LlPD+LUI3iDmOe2Ppua33mufZojTUJFqA5Q+iMn1XnBGoDlaLs39t9SkYEoGHEoWcvajQrncL+9fRIs23voLhHNBS1/cqnR4cd4JcgumAsg/QU/xgars0iRfReVizWltqiHwfE9P3i2uL89lP4JluRZTtUDk+tt9KnMmoEZ7sOzp0es4PdVlKLWjYhjuRDX6DtMOBl4GODfpyBE/KQIdSoe6dZuc7CHwjTDoiAqxwwVjT3CrbKB0qfdpfT4DsNVocif2zMlFx4jswTe/3Hv4MoxhMguw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPGGhSZLUCgkqRi/jBVbdxTrakOY0ttYCnd2y2Oghe8=;
 b=pRvFz9vcdVfdO30pKmzzZpmrJhzPo3NOz9Bo0hQ15Pg2p3yA2xyde87vM/6z/+AlO623DSSjuO5kOcIG2tUL7EoZFFNAdXnfmN0en5FnlEnxxRCFNiJR8WxHMJ2RJjmeiNYPhN+2Pq0JDNui0x3ylnt3W7HAs1eusf9G+COQVv3tw4yCB5Zj3UrcK/OGSA9Tn6BfH3KXf6WNPLQR+43bcXQNHQ1NbX06Nudn7x4eMWX/W/vLQvjQ670twKNfCepChcmtFMKh6LOYpkX7oUc14r4Ro1vf9gVui1XBX+Jh1GRlldfkK481UEO7Tu1LHpW0MC07ezRS3jPb1DuSgpjATQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 14:40:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 14:40:00 +0000
Date:   Fri, 4 Jun 2021 11:39:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH rdma-core 0/6] libhns: Add support for Dynamic Context
 Attachment
Message-ID: <20210604143958.GA404564@nvidia.com>
References: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620652384-34097-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:208:23b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 14:39:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpAzO-001hGd-Jf; Fri, 04 Jun 2021 11:39:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8aca13d-2d80-4e76-04bc-08d92766a171
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538AC31CED66D465BEA347CC23B9@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grt12rQWSAdygveo0CM/12X+t32zQyVXQ3mGaw86AOpFh1H6PMA84EK194ZrrDrVptelpCXB2O9kchG9rzcmCal5XPn3mUvVJnfOJlPYpok0Ogvy1kPYlAg4xEC9p7GuYD49m3V94Pdx5UtZ3LO7ISJg8TFDITVkRAezSmnsbhH8sVlpz2B4evucJpp2KFA9s7WKxrnL5LFXaLmsfFj3/kM8fKostfSyj8kq+gJdAH9ehVb77IHOPdCPtP/oawQVwX3GhjewGwRRryAG+1aLLXNnEIaR7qN15UGYKK9Qn/461bfDmE4llbjFB/fkJsGC3ygF257ok61jl9TiipNMTVLchZnr6m7i/GRrjKh6vQYIaERg16wiTiOjVcoPBdc7K0Hh+6ic940/vjqYvWwOyI+bIFm9xo+x3O5jZFHDZOKrraz32EvQ9alTH69N1bgidKdLnTWdwsLk7li4cet9f7z6quMch+wMO8L9q+UEFTVhpSCmxPS5ohHojjeqMn6Ez1jzhoJ1LgHg+2F8eq5L2GXNPXrm/gju3sOIVRG6FmQpq7jlznaPjFRfBY/vZiXwuc5aLU0q+OVHnpgVuO+56Gdyejg2YUXXJSvy1vGikSV8y2+TuQw644MLv//Hhf06Owe3Q1L4/w805hdQeoSbiZMjz8YPMGC44UzxpxZ93R+0D4X58Icow9/+UnCaLZcdTyC1c2pf/2ZZgpdIe4otJYw8RSCRT1/kyk02TERqbWx3WHQppm88mUhWOGLpiRuxd3KzH1BFpRFegucFwuO9dRuRwBgyOMUmjhp28QJYTPomWMHlia3zxtVunGpHCHjh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(966005)(478600001)(8936002)(38100700002)(5660300002)(8676002)(66946007)(9786002)(66476007)(426003)(66556008)(9746002)(2616005)(83380400001)(2906002)(6916009)(36756003)(316002)(26005)(4326008)(1076003)(186003)(33656002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?V+ECMkNIn+fbMl1m71CgpTpnu16Vqz9g0+b8hoefctvTRM45/4oJfGDY8kkB?=
 =?us-ascii?Q?6163f+j+iifI6ACB8YLkJPEr6nkBaxKEIDz4FjswRTjkdafvZFvGVDzDlexV?=
 =?us-ascii?Q?MfDjFwEC4v9C7kaiT6ZW5nyOlFr6zrkzoLpIvElEYvxbsa4KWUXSChLj/7wz?=
 =?us-ascii?Q?U09/slPhP2PUOqP7KgFTDPRDZmPFrr6gQch9sPfw2LYElnn4KEcH/g+774sI?=
 =?us-ascii?Q?YVfChd1+QRkxx5djdNpeppNwui0kSeMZJunszYNbvxeG6Vp0z4kOhFGN0KlJ?=
 =?us-ascii?Q?3GXyTdwNc36zoUuZosxXYP9l56DQcil9XCYgijMqlRGaiQmDpkacrsG56Qmo?=
 =?us-ascii?Q?5L/RDfRoDFgvrFs3eNSNY/eoe3MY9JfN8zc0v9whRTiSlDOobtw/ktZBvV4p?=
 =?us-ascii?Q?K2k1sTzkgB3V+LgJ0KntttADA7koXIMidpiI4BFHXEMFQOrBI3nxMAGrZcVn?=
 =?us-ascii?Q?KRCfHy0ah+neMDPetd10AaT7buPq113PBcAFF9heRz/QXRWLn8VCpJUN6Peo?=
 =?us-ascii?Q?Q3VDqP87UXVHETJg1IVr9TQ3XaSMlGPCOle4R1TaxBh4rADJQBaOR9cGfPwY?=
 =?us-ascii?Q?upAOqFeaDyvz5yUSkfw6WC//2m7tmCZ2SQHcIWBEGssCqJjnaPXGv/782HfK?=
 =?us-ascii?Q?iXYH7ooKNaH2NC0oVpTGi1/NKkT0Wtxz2Nh66+P1cavzbPCTgG9v9+gDH7+a?=
 =?us-ascii?Q?mbx90cZUJKqvkPOnqJsT+f6m+149oa6dX7ymlU+MZ/95psxL31XVLzgyCh87?=
 =?us-ascii?Q?eNxtDAZYdDvbSfisfuP0DxtAL5jj+5zIDBh1zYieX+PXe1K/u0qrRlabSxAE?=
 =?us-ascii?Q?Wphg1Bm6aoj4IPr8//KINbSI3uAed9M6ODQTnlo0eRDXRL+hqzCX6mHv8bmJ?=
 =?us-ascii?Q?hLgCR4qvvNBAEVrwoy0QMOF7wSDS+rR4e1axDPifQioz9K5az4L5qDdQbne0?=
 =?us-ascii?Q?JddftSr/2RKhNxQ11Jzf7UnqTGeK9e6ksz1JImWHqGzmagFTk/USuSehESC/?=
 =?us-ascii?Q?7twTjszC+Mx10/T46i8gQZeKn7ZaSAkstw7Rg1im1gMdDuqI14VC7hqk1DAO?=
 =?us-ascii?Q?j/MNIFJ3Bkj67gmRafYDxEsJ7SrbKrzutX6FygIXjTzc7oRFnwVdM1qEOCHQ?=
 =?us-ascii?Q?yLMzZPU+/JwyI2jit1QN1uupf+9FZWdpZBSScdVzxvH+e1fPGrDSZRZJZdv+?=
 =?us-ascii?Q?re3MefekKVsT75A0EEceZ7QeVOMPQFmlmUYEBidJucLUsGHJJ+oecTNgOB+5?=
 =?us-ascii?Q?9ntypbKOyOoIIS5hNDm3Ry2P4dsqQWpF2xOo9mDJBRTvwpxJFFGxIGRR/xzv?=
 =?us-ascii?Q?80AfsIa5/ymgSbCoPJo5jSoS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aca13d-2d80-4e76-04bc-08d92766a171
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:39:59.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsveT7QK/FcXXgmTXyKYw3e6u+Rlt80YniYLbzoQX34KniLQoTxGytPuOA2in89x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 09:12:58PM +0800, Weihang Li wrote:
> The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> enables DCA feature, the WQE's buffer will not be allocated when creating
> but when the users start to post WRs. This will reduce the memory
> consumption when there are too many QPs are inactive.
> 
> For more detailed information, please refer to the man pages provided by
> the last patch of this series.
> 
> This series is associated with the kernel one "RDMA/hns: Add support for
> Dynamic Context Attachment", and two RFC versions of this series has been
> sent before.
> 
> No changes since RFC v2.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1614847759-33139-1-git-send-email-liweihang@huawei.com/
> 
> Changes since RFC v1:
> * Add direct verbs to set the parameters about size that used to
>   configuring DCA. 
> * Add man pages to explain what is DCA, how does it works and how to use
>   it.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612667574-56673-1-git-send-email-liweihang@huawei.com/
> 
> Weihang Li (1):
>   Update kernel headers
> 
> Xi Wang (5):
>   libhns: Introduce DCA for RC QP
>   libhns: Add support for shrinking DCA memory pool
>   libhns: Add support for attaching QP's WQE buffer
>   libhns: Add direct verbs support to config DCA
>   libhns: Add man pages to introduce DCA feature

This should be sent on GitHub

Jason
