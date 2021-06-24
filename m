Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936C23B3561
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 20:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXSPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 14:15:54 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:58817
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232469AbhFXSPy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 14:15:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIIEQsfIYdAh02qsdq7PDDUctcl7XHaTwl4VvyxE05/fHB/svEi0Lc9vLKFsc6LDuN3s9jbYBmonTPcZ1VZ0PEUf0lDooDbmipN0H+xsSpAg9sGGkJhZ8WmsCCH2jW3BJ98G+5BkduG4LTKiwM0C0t8W/hZ71y0gcR0uKOLbX+FPgXjre2kQ7PWtf0kZBvps2ENsA69vTW10dkSPNidWBfdrTldy1E9wf6EyBn0ii1Iw9v2ccCTbzJInaPUxCTPpGHnuHGwZnKT+PAnjLXQzgSA6+TkESkTY/ZDzTM/4UiD6VQzk3RPe9mM20dpZetFAvcZ+fMlPmYj6WU7ASR+2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcR9bgF05ZXm/jVUoaZN1FhJlgFnFk4qjUX1qwYT0YY=;
 b=XNhbZUm1vQXUE0JBXgJU5n3w91yQctvncDRIUfoaowF6DEOwGiMImyLFw20k8YzhQMPTMajEI4/N0A0VIwGmfYisxqfJ6ATf+71T3rhAgDkqlEAvF0LgDZZ0Uth3bas1IeqWYG2v+Cq1ooMcwdVcelKNnzWynhZrIoukDiYLWB1VP6dlqxIkMacbDdB2roOUBXEZem74L1OtFgAifvPmjZXZDnNFa6siX99xaIJEeKqUkpJZnnFCypM4cq/l/65yzOjhpq/4W6Dfhj+FHCQuupSu4TLgCcAuSrK6OWUOPu66kdHrH1nL9C+fcfgh7Bh9qMLLNjnA/5Ry0cz7icP7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcR9bgF05ZXm/jVUoaZN1FhJlgFnFk4qjUX1qwYT0YY=;
 b=Z5Kx+9FlOTh/VknIPWQC9LznUjtEWI6OfGYOqkKNGGYYmY9wzuBYpLk0OZeI/LCb/bJjbzWbuaw8nLHjFDMufAFwt5heeDrw539Rniqp+KTtZmGjQVRVpx3nnJzZOqf5ystxgJlAKXX+chE0rn9Yb3H6tn1TuoSnQSBZGJpSFc4QlG1SRc6sRlQOQRA+MB9i6uxswuumqda08iwhh8oF0BrYHNmmFMCkf0vwD8OyUUw7Idzym6+EDaITg1gFxO5UUZWXMlpoFYUMekyoWeVN0H2KPl4ymZBqSGlE632BUphz6/rErHOrCDNxhotDqAU51cF6BCeT2qvzYPOY1efeOw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 18:13:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 18:13:33 +0000
Date:   Thu, 24 Jun 2021 15:13:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] RDMA/irdma: Remove use of kmap()
Message-ID: <20210624181332.GB2915863@nvidia.com>
References: <20210622061422.2633501-3-ira.weiny@intel.com>
 <20210622165622.2638628-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622165622.2638628-1-ira.weiny@intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:208:329::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 18:13:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwTr2-00CEZG-Bt; Thu, 24 Jun 2021 15:13:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564662b7-2d28-48d0-f378-08d9373bc6fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5144224516AA5EDBEC3FD15BC2079@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ed0uVl8y9OLtKplgNdnycEK2sMYaaxWE+Cl7V77lxS4i4ysAnjI25FV7Fup9MJwuniyDjSX1wC4hMKUMZMj+85X4F3VoYa60RQD+oyiLR5n4HLtdmniAfpQ1bIycaY2EGrPZRYyXbtokXQRKOQP0NlyIo6LHZX2DR4dL5tXlobXljPOEEyQF05jpZeESHNsUnefrb5Zldv70n/DNVLWP3KLqljwjGCV0D7wjp1xvyMcC+D/3SUBvF1bdGIZpkUmD8VsdKgG/GHXaETLsJlCyOIcW8a3ajpbYWCv2nL+j9H2G1aQ+58gzEzk0rM4EmcKfzIWqXYuZWtDAa/L8J8tFxZZppgZLrZF+DUdcjVwAG5G89z/OIjKbomAvSotoRRf+JJqNdOQDL/Md9SAkHE7FNQzZC49cYr3PDnolRgkmlYveFXHWU8I8SMT1legwJal7FisdZbegYZwAXdoYDJKXnrai6PTwzktikgjni0bi4/mSezygmaDYif+mdufmp4RpPJmmwoiakTKq8jXnTsTKyUBs3nSL5v8mf7MwoAXz5REKMqLMTLq7drjyMOq+Ik0t8L6MU24C0UG11GDVCxRgciwFWIF2lrOlWFfDbHtGw/LAB2vulvHjwp2dNzEIgJb0aI2A7eI2QmVnBLKo29/js2epopvNrQnlQzfMSZzNf+oAVXqhz3A94z6HrNwCDMVhNVfTyKwF+oKIDB1uqe4o9D66ZSzY3bSIl9H+/iXyB0gyfbu4qSDdDxmAiJbbTs5pjpXyI5SA62UQr625RPeD8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(54906003)(66946007)(66476007)(66556008)(7416002)(4326008)(1076003)(9786002)(9746002)(86362001)(4744005)(38100700002)(2906002)(8676002)(5660300002)(2616005)(8936002)(426003)(83380400001)(186003)(316002)(36756003)(478600001)(966005)(33656002)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IiuvtvswMpoC1McmzJLNeZ4232kEKi4+1rT9XeiAQtkhsH9F/7ucHW00lvd0?=
 =?us-ascii?Q?bYgLuQDUue0yzo1TTB7mO4rmTqFZl4ZjxejWfTYNLSaYKNWmMixnUA3343ME?=
 =?us-ascii?Q?KmM5zmI1LzJdqY56JEtY3GuK1pyvdHaba1QI6/GAXQfX/GDSgd+6/fJOhvpo?=
 =?us-ascii?Q?LjTxKYyxbRmLeqdxjbW74E1Y8YDqzoz5QSXnscygywF1QPD/WJ7tCsSwfksf?=
 =?us-ascii?Q?inPleVA5yBQpUxALhusjlqDDUT+8ySiSRpNUNn3FXc4Dqg/f6ZiP/IwzrXG3?=
 =?us-ascii?Q?2xgKj1xKky70r8ZisqvXmqtWYVd5fxEbljdxw1eQp3ScsC2q2bsFJOMkuX/i?=
 =?us-ascii?Q?qxfpAI9/uQTrwBbdlShnzUR0jHm877AgmbbJm9YzduPIYOgbUSbDFBSLVzHN?=
 =?us-ascii?Q?Pp0YH0ANVOS1zU05x2Y8X7ua4kJj003SVsuih/Lsc3/1Ny7dMKVqf6hSpYcA?=
 =?us-ascii?Q?o33VNRDDHjl+1SiQAVjPGabreYZ2/jlhRiQY8/pnOTNCuza5/vljaEzfGBoB?=
 =?us-ascii?Q?RO5PoTG+H8hn3Bs5tnvn/xyisfQ1yXRHICt5MDupv2792eei+b9i3B5Iw8vd?=
 =?us-ascii?Q?TkRJrREiZa7ZfiqZQP181/lwiUj/hUC7U59Kltl8UPXBK1oF/fg3wTIZziCS?=
 =?us-ascii?Q?xUpoAJWTzeDRfa7b4+S63+oVNlhMAqHdh2YiSwBWsINrRiCUzns8AC32MyLz?=
 =?us-ascii?Q?J8e7TZpz4SajhBlPJvugifMddxPYZjSeGRAMHxlxYJpY8Vy4DFqhXdcqw74a?=
 =?us-ascii?Q?5gkNIhOFFsBwJuEGKMrfQdbiMmT0vXGruZgeQz9540tZu1tvrQJstJ6WQaDI?=
 =?us-ascii?Q?0aIzTAZUEADqFfIEVRNOpQWjSXoItG1he4rx6NNQ+wmgHYmmAYWlDq9/QLri?=
 =?us-ascii?Q?cD18T45ITjFof+oZlQeDzR1xrsBQB7Ezc06PZY+wykyO97Gr4ieYAGWWwtTo?=
 =?us-ascii?Q?LEeWSgHQ5WHCf3eC2E50F3iX3JBuEHtrRCU1ZNd1QAd37h63tuS+XuJTflaW?=
 =?us-ascii?Q?KOPIhvK5ezU5JUC0UM4N9ViTn+Q8DqGPEjnoQabaQheB0DRALqQ7qorQDEEE?=
 =?us-ascii?Q?ERgYbKkn53KjlDIJ0zImAZZrhbAjinamzZxYr+nx0yHO+wRe2uAFnn/0yNtA?=
 =?us-ascii?Q?pxOqc4k7Te4jY08bYPSksVDqxFzOLAPW0D+/GY18mgkl048xt3SeS/yhq1o1?=
 =?us-ascii?Q?zqqwFL6PhR5TYRnhBc4ZstX3MS7JI8cqDrYSZlLMn6w2FycdKc5j8C2aclHZ?=
 =?us-ascii?Q?Ar9D8cgygHwCA2xSYRGimR94/TmsNg/nH5wj+bfKhiESoFvqiQ7IBvVp8b8e?=
 =?us-ascii?Q?dv+RvIrYSwJyzq2VNivSvpjE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564662b7-2d28-48d0-f378-08d9373bc6fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 18:13:33.3187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWBVbdWjQjEjPh/qQR1S7ime70jBtT+rMHa+h5d8SPaysX/R2acRPCudNdEDHMr9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 09:56:22AM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> The kmap() used in the irdma CM driver is thread local.  Therefore
> kmap_local_page() is sufficient to use and may provide performance benefits
> as well.  kmap_local_page() will work with device dax and pgmap
> protected pages.
> 
> Use kmap_local_page() instead of kmap().
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes for V2:
> 	Move to the new irdma driver for 5.14
> ---
>  drivers/infiniband/hw/irdma/cm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
