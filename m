Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2922F4C2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 18:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgG0QRu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 12:17:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4267 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgG0QRt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 12:17:49 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1efe1e0000>; Mon, 27 Jul 2020 09:17:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 09:17:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 27 Jul 2020 09:17:47 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 16:17:43 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 16:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cr+Bf5aAbOYMzo9dXV+L4rLDc5lYFmaV4DGiSQEFxUSIxY+0ZPhQuNlePIr7+WAyDHYsQX0mt21yCX8nTvgpv7vJz9ObOcJsJ2Mq1xxSpM5+wJpEjTxpf7/gZLzwaizYIe9vKYAsVlY4N5B+pcGj8wu9eVEmOc/ODH0p+ZTjA2d6eXfbdI6VeqDQXSXFGJlKUqzOf05MzuJD7NeosCrTFDt8c0v+CIt+QCxlCbnq7kGFbir4tOurdfxE4tyrjPRblM07mTuvd9dXLlvG/paJ1dNubEDXbiBXNSRKGZd6KXvpKL0GtHVI7YeqiOKLnQYbzvk6SL1lDROuHoeY9ggk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITjagY+5fmaN0QFmpLWh2IwmGPom7D+XzLTEiLGEjt0=;
 b=Ypn1KmmrgzKNcnLHmg9FOxo2xpyB1HDtmCtmjx4csjt2Apk8uxO0ASRz1jSv25BkXNZvS7KSYjRp0AB9M8ltIJ9ILksBc0CXX6z4qcQUuwZa9heQerO0OK6FdjqqqEzyo7s67bMNRTXyrdjYotLkLtfiSLezI6gsR/ZyIAh+3KaNB5DqrLRmkfSpIY9exR2kOKjs8fTN01Xf2/LC2JRDqfNH8Znh6iEhs8AseI+VEraRSd1q71S9QAHAvaoh6485WgaOT9EJiNb2EYja59odnZhKd3Qsr1AHibt8HJT7C+MemSL4eY43ig+JyAYIJzPK6taWwTKBahIYPhaxcG73Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Mon, 27 Jul
 2020 16:17:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 16:17:41 +0000
Date:   Mon, 27 Jul 2020 13:17:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>
CC:     Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Alexander Lobakin <alobakin@marvell.com>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] qed: fix assignment of n_rq_elems to incorrect params
 field
Message-ID: <20200727161739.GA60250@nvidia.com>
References: <20200727141712.112906-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727141712.112906-1-colin.king@canonical.com>
X-ClientProxiedBy: MN2PR05CA0060.namprd05.prod.outlook.com
 (2603:10b6:208:236::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.10 via Frontend Transport; Mon, 27 Jul 2020 16:17:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k05op-000FjP-82; Mon, 27 Jul 2020 13:17:39 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 632edbe3-d606-489f-f66e-08d8324895ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2601862D5C48422DD31202D7C2720@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvWE3YPXyj9W1+DSMtKUrc+1lZ+RdoQ4d1tf+wNc8rvC0sCqxaYSOrSV3eeGMV/K6ewaZsjaWlxzipMpS5HaP3fL+o075ULL82l+v2KueneHshqtkf2UtYgkprhvDT/XdHpg1D+I3zTKrZ7H/aMrfPT1tQ8T0RzpcNr+l7NIoQHdFMbk2qUZUeecTXbQ1FUszCkqYPXvFVAIT5Ffu2boMebLHcDHqcwYSmrM0kib03bsu2NQNqfZw0nVqKQt7lPn/Y54LRIyCaKWoK+1Sk3F3lPe96mB4eAIkE/k9D6y+EGfQ9RwTN6CrrCpUWyrKpSMScXg4Ze4x0v9fTV3jKDJdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(110136005)(54906003)(83380400001)(316002)(4326008)(86362001)(5660300002)(9786002)(33656002)(1076003)(9746002)(2906002)(36756003)(4744005)(478600001)(66946007)(26005)(186003)(2616005)(66476007)(7416002)(8936002)(426003)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ghdDI4IkX0klU1kgAJXjvesTOyfa1C91qDKzg7ny5z0xd55EHUg0EJU69a9bdSjuHl1atJ6W0ss03fqKoXn9up4skLNoIefFH/jJqtk1g/ei2kyOWPusZiqfDXUgd6CcLMD1N3o7X9ilcFJnKVK5iX9zn2Eup6Aham/pxqUhmI7ZYmNFkxuND+O3d9tIqjsiJOeOs6qcbiYqnBG9z3cdWo182f6Jxse9H8NUwQLcD/lI7Ps5XWBEPVC2ur4gJXvDQtNl0cU/CtOQ6lK4luvJ6GRQ7PxTL20TMtc4hOV1WQaR2mryoOPECSjHcY6mOz16+5y1AtAHTUMGpPvanFu4yCGfLRhP+hyNCkWxxPN1J5Y6lgODHqdmhf3iDnGCx9NQSZL9IOVZz2E/V7+g/kM1geSyRtpYJU98SVEAnBGTXm+4RLQrhMzj3V7Elov9vA/30wfR9fEL2qMvUmGwH/JyD07h9IIXL7lpwRsY9Mzu+G8=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632edbe3-d606-489f-f66e-08d8324895ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 16:17:40.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZJB6MjpqDs2GzBr9Nz2IkESaW9kV5HJa+GMNI9U7AYlq8jXMvetX92EcWud+gK9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595866654; bh=ITjagY+5fmaN0QFmpLWh2IwmGPom7D+XzLTEiLGEjt0=;
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
        b=N0aKyKBuQLbohWRsMYf9bMBLCYeAXUgUpXcAOYO2b4QCAeMzmsppODn7kYkdA3a4K
         2N67gyS8plUmldOxQ78QDb+tXDzJiiSFxpNfBrzFV3OwRq6wpwV1ZDZlyG6cCaomaw
         WhxnPc1rqsl6E5doHb1PqF9kMB9iWoD+VOHbCxnNrChEBeJXejDilbBCEQtPWqFdsh
         qHMgO5fI0fUkbdEGYw8AIhHSNyU33gd6NfxuH0HAlBoT9SSOVm+7wruZIdtx3TJHao
         e5B0QG19YgypNGQ1A8whOATFguTR4bD1MUCBCr0knDHOe+ByxD5gFRIYEpT00i+B9o
         Vl8Ni37Dr6XSA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 27, 2020 at 03:17:12PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently n_rq_elems is being assigned to params.elem_size instead of the
> field params.num_elems.  Coverity is detecting this as a double assingment
> to params.elem_size and reporting this as an usused value on the first
> assignment.  Fix this.
> 
> Addresses-Coverity: ("Unused value")
> Fixes: b6db3f71c976 ("qed: simplify chain allocation with init params struct")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

DaveM will need to take this since the Fixed patch is in his tree,
thanks.

Jason
