Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040B3261852
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbgIHRvR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 13:51:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:6073 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731588AbgIHQNr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:47 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57ad970000>; Wed, 09 Sep 2020 00:13:11 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 09:13:11 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 08 Sep 2020 09:13:11 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 16:13:11 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 16:13:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8RzttGyJlM5VaxhqdqsPEhDsVhuZAdmzi6s8W8ksQHyV93i2E+6FgJozn2pe90VNkKt5zsIy6kwpyaa58d+9zmm3NoKoGfK/zR1rvur8WFMby1TAfK5dSw4rWtN22YqQOVc24Zu/6CDJjv6ygMmqQfv8O+a/D6+sucPn8dAVZ2pQTlW3ZkayZ+ZAP9mXRKE8V/Sgh2IzjcwzWpr5ZLxFgUvfK2+6x0IpfD81Wt7Dz7TlpZh5V0NBu1LwoehPNcjxPRca0PvaNCZYaUHejCx40ko8tROrfuIdlkqjfkzKXkoizlkLh0l3yvuRqThm03J6T6GCzq8Sue337b5yxcVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BH+qo5FLwIl+MFCi9JnZx6U86aiU5cTBYcGWMB5yPs=;
 b=nsKuM5+lzVEVSvGJrOcuJS2tKH+eFjwuYx6t35MhOUENYfeFVwhGwCIIAoM8QC7yYdXwElwZx8o3F/FRDxMgmNNb8/k2GfJzJGv3GM3xFd8ElKV5kJaSX6gxPzEsAlF83wQ5TjDS6fpVxeKOju+bKqjKxCg9JCZTVsy660+5Tu3XcFGt2jZu91kL6MaZSxgelQnVjk67abdYBbz8l97fEZ9srrEw4gMbujpZ/MZlV+b0E4EFOlUhG/jqxrcJJ7MlNqTXWyNvk+9qK/tMB4J0uZFJf1nu7x2TK1myzsTajNKRENKM0sLaCS8DdOYExIy84tErR1y6eynmctaPVG7VwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3046.namprd12.prod.outlook.com (2603:10b6:a03:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 16:13:09 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 16:13:09 +0000
Date:   Tue, 8 Sep 2020 13:13:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Maor Gottlieb <maorg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 3/4] lib/scatterlist: Add support in dynamic
 allocation of SG table from pages
Message-ID: <20200908161307.GL9166@nvidia.com>
References: <20200903121853.1145976-1-leon@kernel.org>
 <20200903121853.1145976-4-leon@kernel.org> <20200907072921.GC19875@lst.de>
 <15552707-c9ae-b76b-f6ff-7fedd5b02aed@nvidia.com>
 <20200908155409.GB13593@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200908155409.GB13593@lst.de>
X-ClientProxiedBy: BL0PR1501CA0001.namprd15.prod.outlook.com
 (2603:10b6:207:17::14) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0001.namprd15.prod.outlook.com (2603:10b6:207:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 16:13:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFgF1-0032Uf-OU; Tue, 08 Sep 2020 13:13:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c9c331d-d3ae-4f0c-329a-08d8541213e6
X-MS-TrafficTypeDiagnostic: BYAPR12MB3046:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB304681E112D5CAD306EE363BC2290@BYAPR12MB3046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NZJA1ulTl6Ry73kbrTKJ8VlxaV0g+T+BBjDCWrlUHRvjd3M8hAPDSdEDR2BW0yXW1fFhmWA186CgLMP8GL2VzpwlwH6NSoHn8rDsaz03d8v8dQDIdot0w7qbodU3pT/t/SHmGl+MwR3JQ1agljW/0UG2m2lm2FA9nGTH4uFU0LL6V18bPx+I/4FX1N4/obG0H6n2Yha+HtCbGKb8S/ZBtfvkNK67ewQZUG/B04ttM/rL5Fxwy+S2NsRE2gGF1Hx432iRAzw93h9qsM1x1axYsYaVqWVPDbPXmTAXRNqzWPjfxbAH6XRGMuAEJszEDGqshVwy76/DlU0IJIEuuuvHGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(426003)(6916009)(4744005)(8936002)(66556008)(66476007)(66946007)(2616005)(33656002)(9746002)(9786002)(5660300002)(316002)(26005)(36756003)(186003)(2906002)(8676002)(4326008)(478600001)(86362001)(1076003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q227uxBi3BWMnPnoGG4I6H0UbD8d4bSdlqx3ssX5vEt4409HcygwlUNblejGOnrOLEmeMNuUFSStG2bdFt6Tgq5XA7zCARdlIMLUrb2rMfg5yavpFQHIdTWf0EbKU5W9XT5CiS+bcTMzxvQiUCv50vn7ReYvOTdUQNWgKLehjKM9K+R1pESYnD1CYz4TRx1UjJeNeZ2l6aRxa6tT/Z/uTrwVxx1rOXx5fvzSv2vnylkXpSXo5PmdpnqC8pox4nBjuz9eAg0I52AnU35xbq4Mk2QEt+DY9iDoIDXfbR5wCkqPSm89zHZYaNvWd1/OijSM74843g0EHVO/sDKjX+y7zjgSSzQyPLsRlheV9FYEylYZhXQAAwBbZyeeQwd/qQVNxdVF8MV1bpn2m7V3cWXFFeLu5yBqGjnxIcu4ETIzADe8LWUMfFfH9TbkZrBqqaRFk+AYDxYvbrZkgqde1j5xmxVBTYvCNScLxM8uo8i2FNrDVGgGekbxkh3zs2bkVllRRmZ7MyxR/66BPUa6gKao+65GGDQ/PPGMxOyLgB976+lAQdlqTmY40mVi/hcpJPQ0ngB4k8bOAmdgZJXA8A1SQw0fXuhYwSkxRKMRaCbHTrhbycc/d5nIwzMHtK4m8IeMCWq4jHTcPvn3BepmsXbt1Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9c331d-d3ae-4f0c-329a-08d8541213e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 16:13:09.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+u4gb4oho9+1HLKaBRWPPJ10aAZA1GN2mp/pz5VzyFg+pDxSHseK5n1VLdphfAz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599581591; bh=9BH+qo5FLwIl+MFCi9JnZx6U86aiU5cTBYcGWMB5yPs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=dxJgIEMRC7RwathNT4K88+W3reCXGMyzWKI4oqDGEiZhZJUCVuzzSyxgsTAbXoMFG
         rij3NjjZpKxWDwLW8xpxtuZ0ts3kPwdJ0HkXJzdmuw/kStSOufs82kIeF0Rje7gYgo
         giuO+wClAT2ip9kogWqn6+wpdpU5BZUdGsc+/jBxRDXfylztXV3Brcu5bNuvlDdg68
         g/MdNbNNLmQgy+AhPfm8JfKUa0BxCmic1GcbdWPBNOKbPoP6km3p/lJwHsnocVdfbF
         t1TPXTCossSPPPO8ptrkY0tOh2MxTp923F+xJ7Wmknq4kMcwSuZZbm6YgPg5tzreJu
         L1d3c6m4v5ClQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 05:54:09PM +0200, Christoph Hellwig wrote:
> Given that ARCH_NO_SG_CHAIN is only true for alpha, parisc and a few
> arm subarchitectures I think just not supporting umem is probably
> cleared.  And eventually we'll need to drop ARCH_NO_SG_CHAIN entirely.

It would be fine to make INFINIBAND_USER_MEM depend on
!ARCH_NO_SG_CHAIN. alpha and parisc are not supported in rdma-core,
and the non-multiplatform ARM sub-arches are probably also the kind
that don't work with the userspace DMA model anyhow.

Jason
