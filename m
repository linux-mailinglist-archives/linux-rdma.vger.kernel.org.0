Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD23E461F1F
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Nov 2021 19:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379562AbhK2Sn5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Nov 2021 13:43:57 -0500
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:20961
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380022AbhK2SlM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Nov 2021 13:41:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpsz7bchj8bPJDfh+rz1RR7+/gxzNbbtkaR4rxsJ+vItapr09CCEYT1fIElI1x5iPxPpFQM/fb/3rOMsw10kO/1OfoDKcQCEFSfryq7Vi3UcOtpBapHIKrQqzVbks7Kml27AkCpyg9FPSyzoXIYwPHLqU6/Be/cbzC2Usd6Wa0YAemwbRjxPtsCYhvye1yBTN5S51L3+xfIZvd8I0s7/drWzOqedp/FvdCodDubatNsC0GRsZLGASE8Z2Qoc+53mMR6quouroruCSl3gYZNchgrkbscn2kcoXBZLaukxhW3WeztKq6fWh29+y4Q3KMQbbM9pdGqETzl25gEfGu0zaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOag+vGbtNkOuVIQLhKMW2VXnOTS7KfnPaQ2yOJESCU=;
 b=AcoqXO0Uu9FrqiRxUqFAEKgUbfqSVwLfeSjLDfkZjhBLSnph4E7/n3tcmGXPRaQxINl2gwQ6d9fsrE1vlMCMi8UpOMvyIf+KAWRDPUWdQUh1WL7GBfonuASot0BbYv9l05tfF1dCM/57IX5I8lVjuxiqx3Lo+Du0POQpFAO9BoRzuQpkeZYw2dip/CJ2rkvn0r/+17JIyJmfbfJIMqHxWUitdWuo2RadKmP38YIHxRH6FYpQ+UG1PbUHxsn+2LtHowNC8YQQExSWu4Y7OjNpcqjs1FYhEKF2MVi64FavB5wWv19x/MXPWdSKSDbfW7hk0wMhtwAJWS/Pf/1xUfyYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOag+vGbtNkOuVIQLhKMW2VXnOTS7KfnPaQ2yOJESCU=;
 b=FioHZTvIu0Rg95ZjBYxeMbz1eTx9n2enQnNt4rpKaDr9Qf+YiW1jfAxnqi59Cpe7XCqQ7qww2+rGKmfVz2vw5M/hv2asFECOCIY0Zw66ATkA5OybMu+jLKGnlRBmTYYySMC7Wnt7faRleNJFq1I3CC9G8BMdltdfKA5bwmvPXQ7Xqd4qjdGQTmPiU2qrx60KghBGFUHyHV0iCo15iXXhXmUP40QvmKtZHfMc+WwJ4fA6HxSoFM+IDbjlDumyDLxDIkQYZgfkzy+diO0958oO8uEAIeZE05pm18TrMYquMlGqtK24SZam8fth/UswdXI6B+g4j/w/RwwY/QB2XeXsAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Mon, 29 Nov
 2021 18:37:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:37:03 +0000
Date:   Mon, 29 Nov 2021 14:37:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] RDMA/pvrdma: Use bitmap_zalloc() when applicable
Message-ID: <20211129183701.GD1065466@nvidia.com>
References: <33e8b993bfa6b7164e9bee95e3c27fb2c53949ce.1637870667.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33e8b993bfa6b7164e9bee95e3c27fb2c53949ce.1637870667.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Mon, 29 Nov 2021 18:37:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mrlWP-004TDB-VC; Mon, 29 Nov 2021 14:37:01 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b424a94e-d805-4032-62e2-08d9b3673c81
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5109C9E105A5598262A1D7ABC2669@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVIYwjIAknPaSNHiFuo81Op1W8p1EMDpB4JOPA+LGvnW3EKR4yWe2I0MSuJ9rDU9NLU/konr1Wh8JuEjTqxMMrg3fqQ5Xh8ifmThYDihwiEoJL+YpwayjHQ8FUoCKeP0KqUoiwYiAQCLJf5uhg46WXFS1MC9eopZq+znzt8wf4XbeXyqN4ZeW7YP4BdeqM8OMKDFG1VlnFVRZ3xYSXMdEj/6jl7IXzrKg++HX0nUhaAM3UNgSZ7+lJdqGnTcmXypLXzo+IMs16W1T8GENz/KbVRS4KWytTksDSLsnOgN7SxxiYQu0+XXWyDyi0JeQFymcVmSsjIfBBkdE8B98+mV04TI9oGHPRsovxBm10ENUjGjswQQIjBFtN4xR+VosCAohHqN4nQQWAJ986WthShP8OWsokEKOHczGJmPL/QV8hqB3rfhgeGTjOXo7WY7eLvC/7axDCj6RUXFGVS6RpxrGsacKxPSuEoRnLTj6SQ5KVD3/yD7BpFG/anoKiHiLLmFarI+KPxt8nc9f8QsgsNKqGdsJPtI6+ne06SvVwEydhCSWWDmmiRYITvtln3oKrRz1GbJvJIgYm+YANOj06YLJresmTsIiNeLfx2UQIgMPvBItBodTkqijifPas+XRLsESeNfExXAGoaGS2krz8Hn7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(66476007)(66556008)(5660300002)(8936002)(4326008)(316002)(66946007)(9746002)(4744005)(6916009)(36756003)(26005)(86362001)(426003)(1076003)(9786002)(508600001)(83380400001)(8676002)(2616005)(38100700002)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5zIKBQT+Yx+Rz63lq3Qd9Kp/ITqvyUqi8EC5iTj/6leSJalRzTT/lDN9KDX3?=
 =?us-ascii?Q?eMaNadpFjby/57Ms36DyjL3LORcsxptzSE6J4+ynJfNKZz+g6PxEtf9E5/Nv?=
 =?us-ascii?Q?sh9jEhZ8LBZ4jrCPAAjA4l/YioBuUiEV+Kurl2mAqlx3tlx88a7HvMCsRrEg?=
 =?us-ascii?Q?Gjzetd6U2KWBPqIk4cRr4UUIjRoBe3W2l+GbQbWIEvOuL6lPFEd3ZZzfBOpx?=
 =?us-ascii?Q?XT6SYr1GkdjPaRLOsUclZEQzvXQwofXShONXHJCHq+MnNZg7RjwcH74VthXb?=
 =?us-ascii?Q?Wet1RcPybf+/QRVUQPjruBUsDEm8VlCkFrGQUvSCWwEpqLdYk8efLTeJ4Ozk?=
 =?us-ascii?Q?vdc5V4wqEp6gA233bCeEs28xrJQx979/UA2USyLpfT0TjEQZN+IPYv8+hqCH?=
 =?us-ascii?Q?wuF+WEti+JSMJbLfqt8gXuRlJltSbCO2SCCBO5d/DK01ELiHgFy6r/FmzpAy?=
 =?us-ascii?Q?46fZnq/adGTm8rLDl/oiaUQRHXALtUTotZWPJfTJqWYy1w1tigGCwOWNd5yo?=
 =?us-ascii?Q?L4iTgqSnYCig8/3p4yNO7mv2DNbrgjRih4JB8kUIw2IA1ENiYJeWtp4yEi/B?=
 =?us-ascii?Q?FRw/pNdF68KKjliVEP+nybZ21FYua8SywIZJUrd1+0/tGQwNz5j7SPC7L6e3?=
 =?us-ascii?Q?WaAo8/bPWJ0ZK6GL/3w3dWz3LFBn8C6CVgKobPz/wotAGDbwSU4iEJckDbd6?=
 =?us-ascii?Q?ciIiDSPAfSvBN2Y/b8Mgg0Fb8lRT8C85Jpdft8QElSgdVQ3OfHcaB69rXNWa?=
 =?us-ascii?Q?B5BMhPTNsR18WlFQlXZ0EAb5MH3gWzomg+EjQN9JeSX3/zYMWSBn3bQqPdBV?=
 =?us-ascii?Q?aPmy7Q1Bdf5VBDuSSKr3wE0ly3cVzTDZBDHrsnKAam6YSCEAplhbR6wLNDXw?=
 =?us-ascii?Q?ZWpzekSTkp8vfrkO1aUtEPsIUHaePNdD1jYLtkX+aZjN2Jj/qfg7SUCDdhVX?=
 =?us-ascii?Q?dEe/SFRQ6xz5yPpjCvT7pOLCz+8qoY6pIlC25eeK5eccwWoITDWMjJpmoXxt?=
 =?us-ascii?Q?okfN6JuG8w4InqoBZgcKi1H8FMVrQUGRlhjXoe0P0UO/r72d2PTA9vZ7twNA?=
 =?us-ascii?Q?vM7tI4d4Ts9PPJ5crINILGtEnrO0BdF0AkIa2/F0mhlPMOTx4z7uht3GXCLS?=
 =?us-ascii?Q?BB4y0zGQQwyzH2h6R3lbIoLrx5k8JxmFTCTzLLfE/hU4eaRtxZ8EJF2QThzP?=
 =?us-ascii?Q?zo8plOEUBxScqLm0TQz7NcaopdhZvbBPqPSv36yNDL9qZOvsxYEuvCYoDRTQ?=
 =?us-ascii?Q?l0QcA+Hl7gSv511ykb0F+yDSdTq5cSrrmuMMT/oALqPO+t2n/iX2kRrtXaQM?=
 =?us-ascii?Q?Chp8FwH/ASh2SIyGS2aZO1bUvAJUBvUhLfh+HIRrNr/aBdFtXt5NcO4yBXZz?=
 =?us-ascii?Q?w1Rj3TNLfFi9kDXYHPEMdVcEbfSQcQbMe7qzBlAgdxfG4ZCGbqRy22ckXg0o?=
 =?us-ascii?Q?RFZmpxEVMquytl+CnxyYysUHLgvy+Sv8BlnW7ZbZt18o9Ql3fKFV1ErsYgr4?=
 =?us-ascii?Q?RXiJTPFaxG2uomAcIfj9bFJd6Kg0TLYCMiFe/Fut7oI5Yz+/TchZII0yYvOz?=
 =?us-ascii?Q?ReWRoF23OI0znO/93qg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b424a94e-d805-4032-62e2-08d9b3673c81
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:37:03.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjxhhMLYChOQic0lscOmZEN2zyz2UzzAkR0N8OHeTbOuif+OyqT6pXSYhCgs9cQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 25, 2021 at 09:05:40PM +0100, Christophe JAILLET wrote:
> Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid some
> open-coded arithmetic in allocator arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_doorbell.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
