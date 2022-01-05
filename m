Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E44857B2
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 18:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiAERyR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 12:54:17 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:23738
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242575AbiAERyO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 12:54:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV21ehdp3nUYmGS+RIVgNiH6KQn2knD3q8oVCGRYbrujpQLl8l44QDOXZpXLkf8TD9VvuAIYTR/Hj6ufG8XRMXCVnYj9jMe2IINo//aZSoqVV6WMjilPRfzn2U+jSRM6dDr1YMptYdL5Pu8rTEhFbBgujZ+j0aOsKShs46qj7jrSQI3/o0RNCWN8VAuAsPkPm3CvBo8tnFDXXLyz/pWH2aGiXqIj3uaznKsAVaHRQy7/pNPYgc2SRoT/3CdKdnYnLeGcJyL5FUSUt24ZAb4OzfVN4AQzREFkYYdvM1bykCQY+WVR+EIVFcLl7UWSQMktzvsRRHEyn7rurIBCDPjIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmdoJChsGxe81fLgjFXd06+ZuPe4apXlSIAHmle6IyI=;
 b=I34uO9wJMJ3IOLYY1xq+hqdYIs5sl/Fk8cw+J7xEpxhdXBNWoIZVNfowkX2qk/d4wVqJuO4Q/kFg5qzByHeSNp65i5z1VwUlayEmdlUV5K2TNGanCzqD/wiIov2XIqO457h796E35smysO8FkhCbxHDy3Ose/w0Gw3Ug7tDRzcoEFC02rLntPKZqGvuCW17dmSO0GwmHHDIUV5SMRpq96oQUO1S4raNUZe7EMNZtGtG+myCMfICnTuaOWIJ7CJ2HOXE/HO9GgRRSyHf/u4cRC5E+3kazYoI/jh28S2/WAFmloFztP3g5TMUqx7dUuEczGKEtYe85fb7B0ij88p9Vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmdoJChsGxe81fLgjFXd06+ZuPe4apXlSIAHmle6IyI=;
 b=XQY6739ana494qJiGKFj+KOjLeJ8DyexYG1+OTrbGFUpdIrcah0t4oHeYFlBp+yXXSXGOxTVBDqRAg/JZqvboj1Z9gCnOGLtI46Xqk1w/5ATCw8TlNWQwimPlzPYi23fqs2rhATrjb4b6JbSb+ZIx28SCF3aHx8IMJThkCK9w+s4eW+KCF6AjwFJ/RzBFzTrEXAvr++BonsfNb8ParJ1oTunxDL/kp46VzFbSVK8wnXXGVAU5c51xXh0jdAHO45y5qG6z3Neqmw/HFDZRx/JT+lphvfFNY5i65PPZDKkQbdfWorJs3f8eXeM0RwAn5CyQdPuuEw9gKiYv19hIgGfXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 17:54:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 17:54:12 +0000
Date:   Wed, 5 Jan 2022 13:54:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, dennis.dalessandro@cornelisnetworks.com,
        devesh.s.sharma@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mbloch@nvidia.com, selvin.xavier@broadcom.com, trix@redhat.com,
        zealci@zte.com.cn
Subject: Re: [PATCH for-next v5] RDMA/ocrdma: remove unneeded variable
Message-ID: <20220105175411.GA2844588@nvidia.com>
References: <20211214235015.GA969883@nvidia.com>
 <20211215055421.441375-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215055421.441375-1-chi.minghao@zte.com.cn>
X-ClientProxiedBy: CH2PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:610:59::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a57ae33-4e68-4fb0-e0fd-08d9d07461a2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB507896362D3744F94001F5A2C24B9@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKI3MoBgnq/1xPAKj0CLqNROhyN6LtrNoBGpBEsP8k2hbMYPPDMpf8hT2y47+FK5a71RzObYSpmJWnstT/C8BcJxJSzd8YMa9zuBc8NZ7GSpnZYiUUwPwAe1BiG+hscdUP9aPagNlR6jOH9IT3jFkw+3zrzZ+h113RGC6vzz2UNaDiXcIwK8KStYKM7iNjVD5pWm/o0bTtRyHLRERVLV7E9iZyAXWwW6XVx23rudeS3Tr3nvcd8nS4WWjUrRs8BhtITa4voz53yhoiNP0qV7vX+h8x0j1RxOsQSqDSr1mEe+hczKwlyZzVDaQhddZDapGe7J9ObqTkTk3MEaFl5JYBqevfVllIsog/RyPNjR6y4wUhpEKBabEx89RVjCElUQcIFIlf0qzsxmpTsKnrRZkpvZWb9j9zZsvEwYTXn8lSexnCbLhmW47p3m4XvMz+2iODAA0E2slEF1s6ZtinKNplCeqJE7gfNj/uY5dSN84hcu7o2UMJcISvSvi7/X1BT9HlDjmFjm3M4DYfJOPd6GYKX9tA+gzt6eyMeGCd1wHovgXxFlG5RN0FmwTcrW2m4Ox7NoUZHvLMc67l88+lBVKA4w3MkeYrFKZ08W2v3Pt+d3Qu7syYr2psWM1USlYax8qazafEePgQR7wv+pGk+D6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(4744005)(7416002)(86362001)(2616005)(38100700002)(186003)(6916009)(508600001)(8936002)(316002)(33656002)(4326008)(6512007)(6486002)(83380400001)(5660300002)(6506007)(66946007)(26005)(8676002)(66476007)(66556008)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pB17/eUB8T3GG2+rs4Nu2Hv/06ctfwVDUoWHYOlmZEkgLGqznzjsL5MnkNNx?=
 =?us-ascii?Q?j6s5hOWbOjSYAO9xidQ3m6qQauvbKaVA2MKXtTNGTz2ZDTodFpD6e0YW6G/k?=
 =?us-ascii?Q?DWydNbq0DKRqOuTWMw3XxzzTYU9RVgkxvQwUFarljuWqsac6nljCUMKvukN7?=
 =?us-ascii?Q?x22SweDzC7FbjBP2+e196eaCApNuAMxdj97ZhpQgpM055yfNltFMU0aN11j9?=
 =?us-ascii?Q?CwpEU/jnjbrevV948OMYxcxFg8P41flMk1o3lgvFWEgMoOPhSrEbftKAq4xH?=
 =?us-ascii?Q?WMZom2fvb2NgyqKzinLFl7zYLcZau7mAGIEpy9zUBnHKji2JDaTp8xxB4IC7?=
 =?us-ascii?Q?kjplRBIRrCSIr/MiqJxmjRqIzsqWbv6ByMzpIGu2oElWDHX3/Mu2V6F7sQuf?=
 =?us-ascii?Q?ME9MIPLdk9UQcJKpiDyjbZHwHtbz9Q9twKjv2K01dJQb/SnION6SFfNIaTgI?=
 =?us-ascii?Q?d3/edyiQo42klaeGm6PXQI+Qpl0F83LHevqflnFsgCohvLGgN+wazi5f8ov4?=
 =?us-ascii?Q?iayTKBgsub+f0AjFWni5FjWyFEOgqksSt3AYkacMoaP2w8s9w0i0LYBT4BcG?=
 =?us-ascii?Q?i5kD+ifE7j22xMqdn7KZrx+2I+8UMVClY7GUP3SECjWGwEzcXomT8pvPabQZ?=
 =?us-ascii?Q?WatEZEktosf3MzXGZeSEWpb9lb2ku81LXflu/36DOm7v/eMSAVxae4iCIzM7?=
 =?us-ascii?Q?IExMfyP98BVMeR7Udi19KULXB61FLVwxJ+bFE9o+fyi33Zw2MhcZA7aNDgci?=
 =?us-ascii?Q?UkcdX8XCO22xSPLjtHpcP/2B/PGT8ymjIPLvCChZvIuMqHAjo6GP4N3rLjza?=
 =?us-ascii?Q?PzwBsfgDC6X8wuh3c+0iVY5pbnrc5WrKjYuJxqiImqi2/wXtSPUBaORQq9BI?=
 =?us-ascii?Q?uDXO9MVka0TOXbLnU9bk7pQ6djLZ9KmHOs/ELQxYkS2kdlJufJI1A0RQdCiH?=
 =?us-ascii?Q?ELC1g9c+Izw0aQ2b2n+Sju0hK9dr5Vnr8ZVTX91ZMYvX6gN/TwtSXlg7TZtN?=
 =?us-ascii?Q?az2n1FKHskiu1cKEkq9yDwdYrFhFH2VObvqQZWtKaqDQqCypl9YIFNAOeklv?=
 =?us-ascii?Q?HqZNgmkzySw0DHt2u2EiIDjfvlPpu3sSwA5HyYj5h5+RBNvjg8zjnpOhRNTm?=
 =?us-ascii?Q?o1uFZ1BDJT3LoShRiMDundhWAImatLtbwI4yXkc6ZweUnMTodptrki4G44Nb?=
 =?us-ascii?Q?CExSSztbcoxsBudqQvmi/vJCXpuma33asJLN4RH4PrKcz58d6Ef4eKSzUCXt?=
 =?us-ascii?Q?QPeDpEPgdQkL2mDMh2ua3aFcsY2+yuIlN7v1VBpDNGeuVpX7IIVQ8nvEzj8p?=
 =?us-ascii?Q?ECWHvgRyC0Z26cu1/GrDB9UpJ3qYlYCNq5VK0i5IfU2qTC4btL6QKcRFxKdR?=
 =?us-ascii?Q?weXPd0Y0pGyyGU80IBAuwYG0t3lPwkDp5L43mZvgi4cwtmk0253Zg14RP3pD?=
 =?us-ascii?Q?xb3YHwfXDPjdDpGWi5TpErVSQz13+XHF51Mg1ydWVB9/DzVoVaZHOP642mxF?=
 =?us-ascii?Q?UAfHYSBgWJtmiLdUoDfPUDFX1QjOVc6wMgl1pv7JGiNZ4DUtsTkNdHYf7/3O?=
 =?us-ascii?Q?gJSTN4NQ1OGsb3ar2ZI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a57ae33-4e68-4fb0-e0fd-08d9d07461a2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 17:54:12.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6aVv7Iv6W1qfup9/2z1FB/qWbQwoyY0CqKalKDDvSHKbPJs7H0MVbQau8+4t6ju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 15, 2021 at 05:54:21AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return status directly from function called.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
