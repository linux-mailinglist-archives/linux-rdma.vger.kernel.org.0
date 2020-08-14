Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC26244BB8
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Aug 2020 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHNPNh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Aug 2020 11:13:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19329 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNPNg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Aug 2020 11:13:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f36a9b30000>; Fri, 14 Aug 2020 08:11:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 14 Aug 2020 08:13:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 14 Aug 2020 08:13:36 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Aug
 2020 15:13:36 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 14 Aug 2020 15:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvr3rLphr4Z2dDUo47sazdwQE8c/yAGwvgtXSJAH42XD1+BQDfgOpxt3BRf9oc0ifvVlA16NKG2/CqYuz44pqwzsWxdFDlM9bDiaxcIs0GVcmiGddxnK9LswUEBMcBD3mf+RskA08yWH13E77pNFon5Sgn9o/bCmxqzj9TcM47DtFmjbMBpkeTXPE6IlMV1Jh3KpKJYpP4rSZWE0FelNVtK5+vd7O65jnl9A820txlJrozQM/2RocXfkjnQdbvnBIdwrCbs1yUBffgbdy4UBTiigEczz56WjDwxOFxOoGUvHCyrmU59D1Wlc4xcuo/Ukc1u8JjqRIP6oaNFvKvrl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXgiqcw5aotrx/A03NJLGEHTifggk4Cx4X30QIsej34=;
 b=haorxKZgJuYdCbD+H4iHPTi5dh2DoPeCQfdPRbFA9oNw4cFHvWTnzJxRj81V7J15wGhkw97l99Aq9nBvyFAdhEzaErXqHsh0xafIl1+zmcvf/AER2VC4tiIexaOeK5o3Z25mkiqJC4qSbMr9fpHrNS3nQtcGd5ZVlXdJ3s+Yzn3v/hdjHP06I7VOtTXe7wgmPmhfNFQN/r20mVTyeG7WoaiIaLPo+ARqnAOBItAf2JOWJTm0EquNq1AHKLbfoPtq96jQ3p0rB5DQ3oIgCqegfHBDtWSmLNbROYNBNWoDezns+gwj3BtVL9DjMlus2FuNjwJkF0KyBK/KeJigAFRlGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Fri, 14 Aug
 2020 15:13:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 15:13:34 +0000
Date:   Fri, 14 Aug 2020 12:13:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Bob Pearson <rpearsonhpe@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH 1/1] Address an issue with hardened user copy
Message-ID: <20200814151332.GM1152540@nvidia.com>
References: <20200811191457.6309-1-rpearson@hpe.com>
 <20200812055255.GI634816@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200812055255.GI634816@unreal>
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.10 via Frontend Transport; Fri, 14 Aug 2020 15:13:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k6bOe-006ieM-O8; Fri, 14 Aug 2020 12:13:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88ac3a4-996f-444f-4cee-08d840649c7c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB248760326D217B85302107CCC2400@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 158Y4CvuhPHysVEBxp6d/SKYRtIoktlKAgzvXeHoTsTM26J9zBmQvV6m6rT2TgjGsIENIaD1whSuL8iixhwvNeETBHApgvF/PqWNzBHkSmF7+KG1nnzAjsAeSowpPwDTiXbMhiUCPckJDHqZ2mxACSEY76rIC4Hf785Q8c2w2Rpyp/D0NMaWf2egJlw3ucX2qfSphCzzF7nAGZXkpXcu3uCp/fVGlFMj3V2T2yeryGRBRq/T6dYC8JpiCsI+PE10Dwpnf4XMYOnDonfuLuNp6GMqTYQ+yPCOfAxRSlFUw/dsNcGQPepOG8dwrtjuTWU/Joaosr0ffp9Qe153BC1lxjfOQDAyWdSU5MLqxFvwh5yW40hTlgKlQHnIJ1dhWRMA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(83380400001)(33656002)(316002)(4326008)(478600001)(2616005)(426003)(36756003)(86362001)(54906003)(6916009)(4744005)(5660300002)(9746002)(8676002)(66946007)(2906002)(66556008)(9786002)(66476007)(8936002)(1076003)(186003)(26005)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7sazem3aThBB2ujfRFjZRAgNZ5hut4vBWIwNO9/t5wqWdgbYm35exunLzPrgwtk8QgD8xsb4Sg+1xhY+XaX5lsjuwGjihNGYi4r/IUsQiZJDFDYgur0fVc/V/ZC5y3y4tM8VgXm+b+TmlGATdb0hUVeP1PzOwPFVO0wUKZQOxi0VX6UHH0vCz16inunJK/wpwEwt+D9PLiugwOQaMLJAKKZzYX2l1jKEMMAZVm2/mqFQ4RD9Jag/IN/3klMDO7R9UjF87nTXVB7VbY5p9qPxTA79ySkIe7RwW16NatRdOPYh/tgixhVaxFvna5Nj0/v4C2nxpbQMBzJGNSORNxq7sIp6x/lvvr9/mWQTZlseG5v6s0IhVqZo0la6J82rpSy50CDktERS+wBj/DyuVRvwdUpQnccsoq7xI25h+bnK4RkdzM0zqEG34QuaGM4Qdd342VOIcnxqZSSW76tH/MVQeB8nDrPb/SNeyW57pKEJc0+Jrr5wzMBQoHu2X68di6ojytVK61NYC7S+VkFvs+g5HSE2cuUBXm9jlEluVcIlhhuSUEe93/GakGRx5gX0QBUUYCuurFFQ1tnArDyvx0SS+qXiM4XOQR6xKCKxKKXU6roDnnE+eBGEgysI6uUH2pX6IS+kJU8ICnp1j5DV6s6hIg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ac3a4-996f-444f-4cee-08d840649c7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 15:13:34.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9mcSW1De4kjhLefoyJyVvVVyZsWRjxpx9QBcDvbcbefDKlmg79ZXCgZGk3y1uSH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597417907; bh=ZXgiqcw5aotrx/A03NJLGEHTifggk4Cx4X30QIsej34=;
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
        b=R07sK+1fB2zyzL3AaDaMvEzbEwYbOx3MOluGT42YrsyBfoG8R69sPgxmnT0c0FTkO
         9lEnXyTZo9denjnb4OOKR3UIvDUv07cYZ+/A9GFCvJ4gLiKpKb1IsGaCKtJUAU30hh
         70t6JMvUo5XChiD5uDFl38a4btxaiQQDTy6Ul21/flcTCnYn+rDrMPMn6tHJEYz3d+
         rE8GxjKddxkMOPxKxhjHD+LAJArIRhBAKWmu/AD9tee7Y5NBWKTlgx7PStgCoisPgV
         N3rSaE8sv0dujcV5ZMX4SR2b4JWjQ3dDKw0U/aUSrqDn+e498bDC0MvsuM3PtY3JVV
         FCEEiGrp0QbJg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 12, 2020 at 08:52:55AM +0300, Leon Romanovsky wrote:
> On Tue, Aug 11, 2020 at 02:14:57PM -0500, Bob Pearson wrote:
> > by copying to user space from the stack instead of slab cache.
> > This affects the rdma_rxe driver causing a warning once per boot.
> > The alternative is to ifigure out how to whitelist the xxx_qp struct
> 
> ifigure -> figure
> 
> > but this seems simple and clean.
> 
> 
> We have multiple cases like this in the code, what is the error exactly?
> And what is "hardened user copy"?
> 
> >
> 
> Signed-off-by is missing.

Can't take any patches without signed-off-by

Jason
