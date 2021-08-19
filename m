Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EFF3F1A54
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbhHSN0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:26:20 -0400
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:23767
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238371AbhHSN0U (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:26:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UidocGagBuQSHKa1z3S48L4a15GmYpU7TD0IMCEt9W8q+qWKiQC8lB20Kj3nkEvTMlUbuSqqktzDqR3jBNLlnFeMdZ5kI+lD0eo2NKHRmii55rREfOD7eTabGx84IYmwrCdUYRNHZbQZ5NvpRdcLWZaxNvrwmQHqG08KWTQUTx7wGQXvpqieeyYWsWm95Qd3M7U9ceULDqZA0vCOACqiXfLB2EcPyu5B8www3m16xhjK3J9Y9iZTU4nREoAT7h84S+cxTDfkv1tqNI1+tt0w44Qak2FSd6nPtTJ8DFHnnXQPZfmA++86rYNs+cYyxgiE4AhQ50eDcnFGktwSXb/eUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3s1ladMXuBho7IC0nyWsegmpPne/sTiFLtwf2wXaZE=;
 b=JbhX7wRXoZvraRYNKZ/Te2m+XIWlCJCAcXRvH0A4BHoEI1vux4jQJFuvll/wPH9UoG/FHRBc6Ei0Bni8QdH7VXrjD4J8nxAmwzltfAjb1nm9jRFA/XlXNnxeYyQ8uWWVXX43nEHbjw6uAa/mUgfnzwP9jVvW13MR9Wf79dcZmUsETNtj1jCLq9SmzJZ+L6N/8YVblmdQkxzwMcBLrgzmQDGSfUlAE0UkGRSebRsTw1B2hT2mOpDdrlMID3LUsNitDSiqOjba2c3XuqFTAOzMcXj5rUpbewaSgkUOmALeY/XfhJnulMyB07470miD9AEX6NnlM9cLpIPbIWlCaRDE+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3s1ladMXuBho7IC0nyWsegmpPne/sTiFLtwf2wXaZE=;
 b=XisLNJKILvsZ67JwnMzOsRA2dLeQrkw87yQ8JVmxRVxWu+lvd0Tz9Xrnra2T/RBGaNBGahWiJSY5kfyfcnDmaZjaFta+wgRO/lCM1/Tb1u4uSzKbZOpPlYTyC3tp7RVO69oIruYcmnVrAUIKk3Iz+9XtDki1eWpeJlYfEjH0LuJZ+j+29BuNhWDFhlNfVryVZVHEcFpIFYZaAGnU4CN1yqO4ZHItVrYDX6LWG/PHWjkrFc7ctHv71+1qiP17bYWGJzHBB8nIf+bo6NInIc6YvsTcQRey5eKDKlP9/RtbFC3XV4pJWZ26eU5Hc7758ahdFXjwIjQXtTCCUSHTFSvCOw==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Thu, 19 Aug
 2021 13:25:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:25:43 +0000
Date:   Thu, 19 Aug 2021 10:25:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2 0/3] RDMA/bnxt_re: Bug fixes
Message-ID: <20210819132541.GA1721383@nvidia.com>
References: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
 <20210819132503.GC282811@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819132503.GC282811@nvidia.com>
X-ClientProxiedBy: YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:25:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGi3B-001Bc8-EQ; Thu, 19 Aug 2021 10:25:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171c1912-a9b3-495b-8d45-08d96314d891
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5207F9B2BB02BDDD6C6D6BEBC2C09@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:171;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4YdcZnhBBGT8v6lLrQXfvq07/3amnkcWSNblRWmsVp19+FsSAJwBeVHaW2WGGX0sanL+rDL3jjtT6gvJYuuary4KhrAG6tYM9TC61OzIF93T8u3lX3IrAiTj23qqFfUS/kLgoHudONgJaVP645O0cPkrBFgUOesK5icDXa3iFC0wYrXQsxNxVZprE4aWi8Dsbj/rawApYkKeEPQLGV1x3w/Z3Kv/6aFdDP6ZSx4zR3m4YQVREWrkne+rjp7GRkcX9WK/nfI95dldA7posmqFCznvPsblWhzgWdLxGhXZXzZSQrBNtH002RKYdyw5Z89JBXe2CDTiMjMca1bnlFtOyIdZHvcX2DjCUmZ8GLrKS0PoRMKLdvq0cPMmUeY//qTkGHHYWY1lR/b6Kouq76Yjef/hK15SFJuoviHy7v/KPJ7J+ifsjF2oaCzVNtKskwxFFIb+yzewLmiEiDhR4SurP6bhcrS/wOrSXxebQm1C4Z94k8gDEFHcbGBB/UE5pFWi007f0FWZutOd62QJSLgCJp9ynTdRufwFm+haNmtQUo9z9k0phRpf9AYGMS0H97xIQrqpBvBrAKVinaRs4IdllOTXAPqfOpPZ0ZpuSCByf5fQtueWiygLtJH6z5HaaxRmvmioGVO3LotpJZNz0KyXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(8676002)(186003)(33656002)(26005)(4744005)(5660300002)(426003)(86362001)(316002)(4326008)(8936002)(36756003)(83380400001)(9746002)(66946007)(478600001)(2906002)(66556008)(2616005)(1076003)(38100700002)(9786002)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T4Yl6+5FYYzNWnU0bUUF6ezFJlrl/lNxaW9NowAsb2bkxmp88lff/SMGRVIm?=
 =?us-ascii?Q?BR/dsUFgRqRHt79M0/hsIbek0D1bVGUMrosPudDviteZ3cviMv4hTbD2vUvQ?=
 =?us-ascii?Q?KrCC8O/DFGBRRSWMKQOD+Nszs6bRr8gDL6HQzraEiS9LdwIqak9kGdy6S6tU?=
 =?us-ascii?Q?cCHSBKHKIKMCisavyQXeosjPOSDBatHGzfOyysevYBweKj0ogdDwjAz5Dgtg?=
 =?us-ascii?Q?qVXLyVG5g5IMgBWyiliV5+N7uBedQfWBWuPzMJpcWq9r9+7YCGYwhdEvkW/n?=
 =?us-ascii?Q?J9RDT22ezl7sJG2Bw/upgvfkTSioI4VBNzQd/HeljWcS0KdryxKMc7LtnsAh?=
 =?us-ascii?Q?JpUjfvXZNrr6jQnUf133F2U4HONo7tSJ+8AG8qdFHpEnvhPmvs2Lir3kvtG0?=
 =?us-ascii?Q?Ba6+Ezmf/XPNWlkuUNYHvcw0EwLkQ0eDqgJSZbSsHPzNwGXwfurJTSpnHWX7?=
 =?us-ascii?Q?JYD+HqlmakoWSt+rNY05GO5OPO3c+40rwA0tYJi4tT67zOgOWxpaxUxcur0q?=
 =?us-ascii?Q?scbZM+q0IVpO/ilLviseF0TyvrXRbD558uHc957CQZWAflKP/jENjTbOTi+f?=
 =?us-ascii?Q?iEEBQq42gnX8XVXdOQtmCQ0l9l1iAkPh295E23TQ6p3IwP2txE9ZvnpmqJMv?=
 =?us-ascii?Q?ILQteDsUp6cwo9zUz+j8PBKpMBNR7OXKlbpu/pScYcRTQ7/uLluI6WEfRA5R?=
 =?us-ascii?Q?4M4BsYJLMd0HyoQe6LsVx68MvPJBLaX58/lTDatWl2wqud3QVisbCq/vPoXf?=
 =?us-ascii?Q?NtMNiPYOnDjVGtZA6FgWLqMo+juQatC6otKI06ptxA6oKN8YHRviF3o44+b6?=
 =?us-ascii?Q?6E/TC51xTdExT1XdqhmIzWXOSBpD+wFG66JhCHWAA4dUtPvOg28aYAvhaqwt?=
 =?us-ascii?Q?3dcfR5CWdg6s812cDi4M1c27MeU91oT53POfZRBZ2o7dTi9p80fpcWY7iY/B?=
 =?us-ascii?Q?hgD/26hO0ybJJne7Njsyt6jGE1s8tjSqj1Ja1wk8LQ6DF6/NIl7n3XS3X+Se?=
 =?us-ascii?Q?yxPgM3j8k5cSq2z5iTFJC8zGyHbYYMdXWt2DJd/0rV08A1c/pOhth/IXFBvo?=
 =?us-ascii?Q?10H0ohlOXVVlOg4RF9+7GpXBjmgP4vgn1U3U0VlF7AY5z6Io2HJM5B9BvyuN?=
 =?us-ascii?Q?N0HzxV60CZJ63HTnohML0in9bqLceV7zAAu7Pfyek7taPoaawfHCCdVRdiy8?=
 =?us-ascii?Q?qXr53J8CYe22W7jnPZCTaVrY66Xq328oewV3Jb1hQA2b7sfoolUCGjv5rTOU?=
 =?us-ascii?Q?YktvN1z6rHYtk1SqjaKjIFhnhafQkPHo4KiLQE50G49zXXe8f6lyaTZPye9N?=
 =?us-ascii?Q?t4qTfjJk5M+JDCc+6YGoMy+2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171c1912-a9b3-495b-8d45-08d96314d891
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:25:43.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpGql15v6jE7RZkvO35Natf4biG04DnX/XBNu4UL3mnDCrMGJYMKLydH87cj/vAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 19, 2021 at 10:25:03AM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 18, 2021 at 08:25:50PM -0700, Selvin Xavier wrote:
> > Some simple bug fixes
> > 
> > v1->v2:
> >  Fix a build issue
> >  Reported-by: kernel test robot <lkp@intel.com>
> > 
> > Naresh Kumar PBS (1):
> > 
> > Selvin Xavier (2):
> >   RDMA/bnxt_re: Disable atomic support on VFs
> >   RDMA/bnxt_re: Fix query SRQ failure
> 
> Applied to for-rc, thanks

Woops, I mean only

   RDMA/bnxt_re: Add missing spin lock initialization

The others need resend with good commit messages.

Jason
