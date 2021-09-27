Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D4841A3D8
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 01:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhI0Xic (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 19:38:32 -0400
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:56096
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238080AbhI0Xib (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 19:38:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHbBUYp+RLQPjCOcVcWcQzJGF3SiQL44ylomn3lADIY5seT/EBmy+yZP7OciJwxwuEdW4I1GaK7JmEFYEHIli46j9HXIqCqQuqyr8ZYpzALjp5u5urT7yTjCJ+9TnwbL6R/pKRmNY/NiBNJAYBaiJoPCItoR6D4AzIfWU97dDvfhI3Xf9GuGbVWyry1EPGuPBRTLjTc6TB7zwweAXx8oxRQMtrB+8Em4gUI8m52jOfDay//py6X0cTIm4PNFodRy4AGLEKSm/Ks+cNJCfvlGdOOSOUGchbAxG888lJmFW3zWRrq6eCiglpklOaqIHnx8zL3xe/DUlQQ58kEWHnPS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sYzlTsIE9o2yNFTvIwby0D3MGFFRVBGRTabb5GS2L9w=;
 b=kufinYavWIk50WId7NxMW7eDGN70lSEc+ICP6i+8/qcSh9Ojk9hO1EhUFPO1ynD26QSCsftzxO42bpRdI/Vh25xh5HqKgE6eWI2VZYcb2NUBxFl809Wh4Wva7ab8Jb+c+87LTSUYxs3EkbhVFAvRomNLed4fzgWqVgjQxreILK7nD2WOotDsUwesr0hh1hvuU6VTlVpXMvz30n2VEL5k8fb3c8KyMNAJQRBTmaSTfqR8yGsNzw48zRCTfIQ8eYvsmLCHy6Zsu1fh4vH9NDoN/OuYx+R03gYqjby44l/g5cbKjEh7bpWAJnuoW3HaoCYpg8pPMGRjOTpPLG2529Jp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYzlTsIE9o2yNFTvIwby0D3MGFFRVBGRTabb5GS2L9w=;
 b=sT1AyD4Wx7iVGZWsp/YiM9UY1GAthmRqSkkuJilbQs46FRMcJ5XwLidRhpVh38S39chK1Ra3eCHZLw98QpzvGzS+MHjc72kAGBybF7mgeLFUcB67+AX2S7JU0xdcA6qL8IWNIt9z1fRi/yW36RmDAhFciEuJCACGuSeyQ9ZyLH9Ki/kAC3AWrqnsd7GvaRij6tKqK5Yb+9HFYVHh6HyYthXlcaJLAWy+cLBSbXaf52xwVdRGdoqIIqB5yOn/YXC58sTRVRGjl0DXthwXUDVQIjPKDCFzmhUtZxiotyx1NIQkBpnJz0c1hb4Jv+h6yEB7hX4O1WqnJtboXsyrrGPIEg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 23:36:51 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 23:36:51 +0000
Date:   Mon, 27 Sep 2021 20:36:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hfi1: Use struct_size() and flex_array_size()
 helpers
Message-ID: <20210927233650.GA1629838@nvidia.com>
References: <20210927225333.GA192634@embeddedor>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927225333.GA192634@embeddedor>
X-ClientProxiedBy: BL0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:2d::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:2d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 23:36:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mV0B0-006q0W-Ma; Mon, 27 Sep 2021 20:36:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7500c4a0-5414-43b3-7fcc-08d9820fae97
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB507819043B3280E1CCC99561C2A79@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArI8Wr2fh8KM1gTNPZkPf+VxE6//Hs/cUpTgkFsqOca1TdsfN9He3wJSCNGVjHs+rSVCf9YMcC4BxjCQz8YY24wWVjqArorNr14Oq2PHIXT6XZZpBU8sNLXAOn8Udj0FaJXdgqklMVHbBQ/iDJyyIekP49kDU/ZWlKPGkJ7LhXTomz3WltDQFgbEiwK26O8t0HVPJffusJXPSIob14UIyHwr8DL0kerJuwpv45mwizSDrUIZSDxk5DecP2N22IV28YZ+Y6aMNJP3sI9Gjqn3AmCTFEq5tZUzTXMKg+5agUk0b/Ca5STturjtfRzaTD+ZnW9e8nCn2+UAkEqp8VepwkHhabVnJv18RZm8NW9OI8WmOVpa2Osw9iSOxQZqYtCg5jk96Um/NO+biBXLwEPA9LGtY2sBkjKLXRaRRXU6eXYRSbG9d5JqZkkRb9sHzEAoJ6biJWkWwgWCXlxQvkQlekaKkuMBcrIAwttbkn2Cv+c7XsriK8k/VmPopm+za8hcsRiu8R49AaXCSsUeik9+SVs/PRU3uXg69AEwLLLpL0NM5uwQsyFPN2RMXAxgRWmwM4D1ermPXKdHeGHvVwJb6HXILK8xU+CaLtpwSaVYYxRszdAyUN4l8aUFgiRbHyjbLG+d6bwe/JRBwEbES+6Ubt+iphAOzy1nWY63w5Va9lYKj/KkRifbTQCC+KGj6uZ5633w80Wmvpy9yhw07dpnVETgFfsAhwxJt8T67jXFx7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(33656002)(426003)(8676002)(66476007)(6916009)(9786002)(316002)(9746002)(2906002)(86362001)(66556008)(2616005)(26005)(83380400001)(508600001)(38100700002)(54906003)(36756003)(4326008)(66946007)(186003)(4744005)(1076003)(8936002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uD1kYMI+vK2sNiJAixZ1BFmTtJP0euozWMVvaydvVp3x+8Ee0il2C6qT4IND?=
 =?us-ascii?Q?nR3IuCqAyV92RoYtGD64w/ntvslALagWfLsTF8VRZIBi7fHB1L9uiNJLE0Qv?=
 =?us-ascii?Q?Jj9UyGLvEsPQcMN7davoPg6MGr6dYRUJnMYc5QKJkD84nSxGCAq+twLXvqAc?=
 =?us-ascii?Q?8kKWW9OZlP6Bk0K3JwzB2d3DCLzI4NMh/+RpELxJIrvAbyS81Vp/h7P+RpxN?=
 =?us-ascii?Q?X2nqAQZhirpxKv6K93UYSVHl7IdNoz4++EBvA2vExsTtOt/Hvc/0Oyx5aiXi?=
 =?us-ascii?Q?AKIjZbrDsZoqFXim4gckF0v3wA82mjPHIXUyYzdijUl0tFEYzU4/IoNIl9jE?=
 =?us-ascii?Q?jZQAyRhtMr5hjd7KlICM1NXZHR6AiIuGQigEQRfQ1ueo2c7qUk0RhlOIY9dp?=
 =?us-ascii?Q?U8ReS09gPlJpJHwoP0qLZ05YWwSyG7mUIzOn3Hd7TNahdCasvWiOUeeP/O8k?=
 =?us-ascii?Q?tGBTp1E0ZzyMWTiRn4sWmXWvu0S7xJtcxhSOPNUx4ktsiTvrw6gf/L0e3hbn?=
 =?us-ascii?Q?47tMNGVsJ7rjsik0LvkwEijti36fEJp9pamKg16WWNZiLBhst73olQLXoNzd?=
 =?us-ascii?Q?7EhWpQVsMaEwKgaNsUo30w62vZeJ9wKEOHcnrzpQPI6vctpm+XA6m/0/gidF?=
 =?us-ascii?Q?NmzgHOg2UTttW+VakBVDoMFXia95/y8kTV/3gmPk7MbUl74Do5NK9eWGsneG?=
 =?us-ascii?Q?GamygJq86Fu813/PN9+FX+iv5zNHGYtYcSxl/R7ZXzZtuCQd3CBe7MAd9D+q?=
 =?us-ascii?Q?ep32zEqgjuP1YsL3x5mmkHEZaS+LhS/NyfRMim8i+JqJCH0fLocujqnqxjMH?=
 =?us-ascii?Q?4oedp5KjMKZXDRLr1IAnOQX8Ch5QNEt6NcsVTyYCjaNhSPo7HDY8aIIdhr8P?=
 =?us-ascii?Q?CXVlYT9ykI4DjEv8ndBpdH2Kn2dccD46ykeL4ovABhuIzgfPxAeh4EtA0/Jt?=
 =?us-ascii?Q?BeCW0fsofVorunt2z18fkH/frWWo3n7fEuBI3H17CLbPSLOEDWz/GRtuPScr?=
 =?us-ascii?Q?YCosIQq1bLCT5dv7QGCPOOS4TEngqdkv6A1C5mfezD7nEQUWLrqy+6+NfPtH?=
 =?us-ascii?Q?OwtGJoikpZFuoYwkn/ilsXsa7QmzUy4ZbmVfjSZUwDD21I7THtCjAMkqApBg?=
 =?us-ascii?Q?kdev5GBG9hfd8td9n4zlNs5QiWnilYxn9IK21JLis3a+Gg7r86nXPwtpv3My?=
 =?us-ascii?Q?kD9dXF6hEitH6yy205SAcbxPBCsH76rX3wv0quBo3kHVvfEp3qXSAftEVgcK?=
 =?us-ascii?Q?KnOj5/ZLk63Z8jJd4X3lYFT5fCn60pxWL5j8YZOMKp7GWphSnqIxnIToHZiz?=
 =?us-ascii?Q?KGxk17t2sqCK74DjOTMqOIzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7500c4a0-5414-43b3-7fcc-08d9820fae97
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 23:36:51.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9zh5feftum9oIodh4aEPrFGEwi06OS3NSlvMsYL5x7FCjCXzhnB/PqIOwcWBmr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 05:53:33PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() and flex_array_size() helpers instead of
> open-coded versions, in order to avoid any potential type mistakes
> or integer overflows that, in the worse scenario, could lead to heap
> overflows.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/hw/hfi1/user_exp_rcv.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
