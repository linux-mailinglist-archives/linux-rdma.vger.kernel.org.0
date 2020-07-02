Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFBF21263E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 16:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbgGBO0f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 10:26:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:50154 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729675AbgGBO0c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 10:26:32 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efdee940000>; Thu, 02 Jul 2020 22:26:29 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 07:26:29 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 02 Jul 2020 07:26:29 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 14:26:24 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 14:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbZ/oPY088Sw3QZVl5fj8oPoDOJp5bp1u9RHDEdLs9yYhzWFEcGB1JhvSarSbFkeJuTSlKaBtmsa/djWhtg6z0jHLJ0+lrehf9GnojbPE/lhJ0br/Oa1BB1zeLqif20jYM0jv//oCQ69hNuQK5rA0a5GxYSVmCNyH2Qv07Tlf1cO52yny9XC+z+fdZZ1AwsnYm/3eVdTd8gL3qxKVMVR7STAu+1qIeGJ6dPUh+pH6E8+Es+/7QymVM9mng3zBJRgmTzK/qYnfJrtXrowFyfwQSU6QWGRVJIt3945zb/qLRXsWm65xkbXdSurLv1BrFaVt10ibL1OyrN0th6X7ZytnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs0z+lIOV4W67PKp+DKJ6IAOz914FX8jb8f/nDgCt7w=;
 b=U2Q+vuaGC/r4tSSGoRvvKtai4YWRl7b45gtRdyAmK31CP5HJSEmy5KwcTpuQWV7RFkzfC7posZGenUD75NO/UxHwyDt0L+sKzaCK/YFpxC1wfWrzv98AOheNoi73sP3Qfm3KIUCD/+k7AyscTtScM6kWiasZ+4XiZsJh1p+lVjOvCQswzwQWVnN0yPifEt+mgR9NBjDK1ZP/O4UbfA1lUgcnR31KlmUGDj1nRq+uwwZ3QzFMMADggn1/y7gcayMAoC4uzQVXjWWYlTZ0tVtQ5oVUehIGh0VRNwlxv+8Ool7OSOciTOJyaikBAoyliwN3X6PR7/PdfuBVDFfl5r6Z0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 14:26:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 14:26:21 +0000
Date:   Thu, 2 Jul 2020 11:26:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
CC:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] IB/hfi1: Add explicit cast OPA_MTU_8192 to 'enum ib_mtu'
Message-ID: <20200702142616.GA702824@nvidia.com>
References: <20200623005224.492239-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623005224.492239-1-natechancellor@gmail.com>
X-ClientProxiedBy: MN2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:208:1b4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 14:26:21 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr0AK-002wqR-IN; Thu, 02 Jul 2020 11:26:16 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8487fbd1-d99d-4f71-3995-08d81e93e47a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4578A049607C198DF6244CBDC26D0@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOnr1QEwCsSdE3WMie5JE6/YLVcnXx3ofGJqyULlYAxL5funEg1sVkmVKbdfK9IB+b1l6yUiRII/L40gIRP4JgDA2Dt/0Q4N04u+SwoDzLUsXnMjNVTjY9ylZEDxlBKoTSP5lgpE9RaM8ez2x5+qSGxpkdM6PJ4lbNIVwAjqLecnY2ap9WJhzfZ40x3X5xGeaOZORNW06uckDErau3bbwlNfbriAwh1JUscGsvInl7NMH4qj+eo39aUB+O+a0q8dcBtKPxCt+lPmbqgvnFKUEa/qXcuujg7ShZ9eecaF38FIuq4PaLDFFEPnP43E5YGbsjUIaPN5OIEgo/NKkuMGjgWnA5IeuiaeGeB4zpGm52HwQMYD+tQljQCnE3Y/pq7BhbUx1iqMltJyFnpvVdbcOyVeBJoa0jg8I7YxtZDq3Eq0HsCaJNjnKNa6SUO6LGCb3M4QRvgV2pqymu8QxkzXgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(26005)(966005)(9746002)(4326008)(9786002)(2906002)(316002)(33656002)(478600001)(1076003)(2616005)(426003)(8676002)(8936002)(86362001)(66946007)(83380400001)(54906003)(66476007)(186003)(66556008)(5660300002)(6916009)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A+bSCtAyQGsu2CjCuCLuxYxs4Iu8wFXkCNzTRn/yOKWk2omMW05pZrlodrZtB6YrRXb+m7rhARoXojfy2yQPyYRbC0/i0FTcHVYtGX67g6FqpPwPolq5BTuBCQNi5jEjzt1BhaohxQKdG4AktgsQ3DlezWuvoG8FlQxMW90FfIUoDrhXSmnSQPvR13xelgDj9ywKWXTsQoNG+NazlZZCrxGAEDMPCwID7OzxUTXzWblptz7WQnzrbO5YqXsvo/fRIb78JhnGOejc3TRzVX/4KvUSWlK8UUbuTBT0yw+6e3NwT8McsY6FrDnYD41Meaxm6Ro8znFemVMYq8Yer47S95zzgDJ+ZQjqHfQi5w1U++D3nXeMTN2gFXrQhlCaXa7ZtLIRTU1dRbnd7k4gkuqbi7Iw2F4X16zRfBIq/u09wMFTcfEt4n/KWTDPpSr3Cg/42gArWIAcEm/w18iePh6ibyxoTxZETJIcDp2S/SK4qWRGV0h7DFWeVXPWbVo/If99
X-MS-Exchange-CrossTenant-Network-Message-Id: 8487fbd1-d99d-4f71-3995-08d81e93e47a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:26:21.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLbz1d7qgV4XryQrDebhtxhzyGyn40RBfxBFfz9XUeK7CJ7yMThMRBWu7QbGVke1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593699989; bh=hs0z+lIOV4W67PKp+DKJ6IAOz914FX8jb8f/nDgCt7w=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
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
        b=p4CLfPqaJezPfDoxq93s7LvcR2O8+TqCrTnhHwSlCCD0nrgSoUk2TQ11tYB3nAf4R
         AFEqKAPjbpEZCb7GPwT5h6X7j6apMnwoz5X478bFfecDMo5ayVfxI25HJWn9TzTWlf
         TD7UZyHap3XU9z/k+LmYoEHESdafzDTYuf8EXkjDI02tFAPkYNx2A9ryOBiUos9fhf
         8lO6oVPqbwvRBsgTCgUiK+g2GUi+RW9nAtaY1YryjAe9qBAKapDV6Ngbw/n6XTMoQ3
         DocLgK41J1KAOEIqOL2e6YN02SZlrD5+O8sRsaEofpniZuzoHmDeV5f6285d5vqD3X
         JJL4+SfktN/YA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 05:52:24PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/infiniband/hw/hfi1/qp.c:198:9: warning: implicit conversion from
> enumeration type 'enum opa_mtu' to different enumeration type 'enum
> ib_mtu' [-Wenum-conversion]
>                 mtu = OPA_MTU_8192;
>                     ~ ^~~~~~~~~~~~
> 1 warning generated.
> 
> enum opa_mtu extends enum ib_mtu. There are typically two ways to deal
> with this:
> 
> * Remove the expected types and just use 'int' for all parameters and
>   types.
> 
> * Explicitly cast the enums between each other.
> 
> This driver chooses to do the later so do the same thing here.
> 
> Fixes: 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1062
> Link: https://lore.kernel.org/linux-rdma/20200527040350.GA3118979@ubuntu-s3-xlarge-x86/
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
