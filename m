Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1720F26A414
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgIOLYL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 07:24:11 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11097 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIOLX4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Sep 2020 07:23:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f60a3b40001>; Tue, 15 Sep 2020 04:21:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 04:23:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 15 Sep 2020 04:23:45 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 11:23:45 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 11:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avb/kYHD+SZpl4nQkogQeEoOBILrg3HATm9Nzfacag1Fga4Gcawo/3NNFCfBDXaokN1IOK+WC4y1AlJe7ZZ+0Lp2Aa/ztlb/3Rzs6zVgyaHxyn1CxCKj0BsDzykUMp2h9NY8XZalqDWdpvf9/DyPReA9Eh13xGJOXoeQbzZLp+ofQqBdX5ooPwM3diWky8K6C8vvEPCYEDx0Q366bS4oPyjmox+R5vU52hR1NPbmCUNaaDSoogc4H3E+1o3dG+UjoWUxWR7G73SQKRerNZK92mg9d2G+tv14hf2BwMCHTyW8AmJiNR3KB3JUPLCx0MSuUtTFl4KekxUDP+YFxmCAtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDmZN9SE7/2UeF3nHxLbemjG5GsLJk0eyAqLRAa7+PM=;
 b=DzdPvzUaNyb6J2nh85FT4GHXktvHqAkinWgag2w4DW+ppVVK7KRGTk735VonoBfJO4fL8mE6PhDrW/EQl/vbBKRdRDVj7KE3gPJ4Jdc3/MaHSrvfNdjan0BRmgQCV+2+u9K6XWOBDBs584QO4ykiajF+BUR0iUEMCde5sRYu2F37Mdq5GVjfvqioH+T5ieI1QppuUOqfE5wxlyVLUgJ48CC+gNH8uf6L1NTvKyXkozj5A6+vf9UozNirzpeiRwm9K5GH4QSEIKXJELb0ORmMMZTE9suqFVzNOJ2xAr0reznVGJxF2GmQBwXO26fm83ru55IoM95RZaVNw1FlmtClKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 11:23:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 11:23:43 +0000
Date:   Tue, 15 Sep 2020 08:23:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <paul@pgazz.com>,
        <jeho@cs.utexas.edu>
Subject: Re: [PATCH] IB/rxe: fix kconfig dependency warning for RDMA_RXE
Message-ID: <20200915112341.GU904879@nvidia.com>
References: <20200915101559.33292-1-fazilyildiran@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200915101559.33292-1-fazilyildiran@gmail.com>
X-ClientProxiedBy: QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by QB1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:2d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Tue, 15 Sep 2020 11:23:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kI93l-006Q71-NY; Tue, 15 Sep 2020 08:23:41 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89dca83b-74ff-4a53-04f1-08d85969cded
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440E1BFC9F01241E65A12C2C2200@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7s+Z4kIcmGfoIMDjA4k2qXKkHF0cgjFLE0IsMDZs9Qqy9xb8ZRo1ddjeMKBS9Sbke9hlumYDaR7WRR9rWoZHX3fqRuWiOn01vhFwkWDnyc5MApywFrJSwRClr5vUcwliU0EOm8cCCL06rJnnhI8PVg/6FE1ZevPpuCt/VOcdOx2iCBTtg8H+cQ1c3cB769kXbsGAN66MqDelyl99HXA8MKZmf7wg78m6QcVAi+CedBApH4ZPLT0puZveULulgfx9dE6/dsiUQqJOR1ucNaNrRTCqs4fpoDU17ORidsWHyg0fEpJxTE0XILE2tPfHPDqAQ0IcyEGIZUQAqSKJ3nHJPrO3V/3G6xBqL3Pq2jWSXYTfVHrLC8COxPYkF11d0z7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(6916009)(9786002)(8676002)(186003)(9746002)(83380400001)(4326008)(478600001)(4744005)(1076003)(33656002)(316002)(426003)(26005)(66946007)(5660300002)(2906002)(2616005)(66556008)(66476007)(8936002)(36756003)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zurEOtk9hRZoKEOiLaiNLBQj9X6raupMqCOFrNYsnesFLsyt6K8IiGZZf/1Q3uboWv4OxrQXzjXuWqk42FIDB19XSPKiJNnY1nkuaUkO6mycdjYCc7IWbxPMmY4hNl61fjdK8e5IdwQ652Fv4N2HIUUvhAoVeQwmXJNqvi4f6PEmaJOB6LUnn5o93ZA7d4R5KYkJTpa9zr0nCXYBTtdWYuyABdIoQplIyJrwLJNHBDf0dhMrE2JwRpxMJ5+nm1sGW0s48SGYFp539xeTgNdqZnE8q6M3f2iTUah317c6v/rtKs9NzJWMkRtfcQbY45ppGEQF6YY0B8tHph+pAIiDsRZDMnBJtDAMi4nEducBLTGfA3JTKr6ROWHJ6qoc4LlIOnO/gknneSofplBlHCwoN2KzmtjF/25P0h9v16yutVTQ4/wj5FlrnDaGxGFCAJgYWd/Tvw6CeNkCNDL5plra1HAC/o5Gi5paBtUoeC5dnRhVK/Bi1pj+6qMp+upNoO4fZFAF2cl/3Yw0cUhgLWLa0sl+37Pu6jskfkujnyRqnu8oAffh9q51iLcGjyK1aGGbIiUMRTYmuHRKIiTDnOUCbqsflei/8BDEA6G6lkC9nyGZNsLeMV4aIi25uNo2cnJ1IQDOjwjNnd5DDXS4nOTBlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dca83b-74ff-4a53-04f1-08d85969cded
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 11:23:43.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CA6ZQyyujIQMvQ+6Iem0DvO05hui6IbnJFju6pmbfOu42uTOfs0bZKku1QELItc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600168884; bh=oDmZN9SE7/2UeF3nHxLbemjG5GsLJk0eyAqLRAa7+PM=;
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
        b=gY7skMV0CtviafZDO+soNzGbhKcH57cVFtwP+XB2KSkzDpB4O9+7emYWyFXmXgmI4
         dAzcmoG3EjZb/qHnLeeUxnLBsrPEGAS3cX9znAPJiWzL/7uRC2kOsmeEsdoLwZNf+J
         cMaIoWy342bb2S0mB5cbopyUxzOFLSKJOGoQ9lZpg8eKWtnkZ1v5Zp2MXhg2iSR5MO
         njXJUf3jwy8bhz3T7BXDGm5Hj5umMctfMSneWuqY30OxEyC0tpwKl1WIf7KBOdbXgL
         7L3YbWvPTMTFVGPlPky9M8a0EBx6ACu3+k4tXTCy/lw/Mc6NRWpJgpc6OGD1mm0ggZ
         3LCXWyRxSMAbA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 01:16:00PM +0300, Necip Fazil Yildiran wrote:
> When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
> following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_CRC32
>   Depends on [n]: CRYPTO [=n]
>   Selected by [y]:
>   - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT || ARCH_DMA_ADDR_T_64BIT [=n])

?? how did you get here? I thought the kconfig front ends were
supposed to prevent this.

Jason
