Return-Path: <linux-rdma+bounces-524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBB08225B1
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jan 2024 00:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2331F236C7
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jan 2024 23:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E717985;
	Tue,  2 Jan 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QZzeqDFW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAB0182AA
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jan 2024 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqa/8RApTOgRX0HmycI2wS2X7iErtPQsOLYOJjaurQJ0fKFjMf/18NjLpNuo5L6WVDLv64o207lPtSCJeUrioWbW3oz9o8h/r0+C3+k5gqh/p5SbvHzKuwCh7qpRy68w6h4iLiPUUNz7oj1JYZ9lLZvQM+2MTVVx0R5j5fxJV2/uGHy3QCPEGoM/wxYZiku8ZBDv1/xZZ4luXhrl64540hMs1Yc/poliNwaFjYXEO91owoRSNQzK2Tw5rRvzofIqSh9mho7AJ3Upv73xR9UHH7ZLmq84gBhe5P2UpzDCwJj9eZd+EJzyYW38em39htsCsw1jr0cwN3iZa5HNBVyYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14rrm7dFweCNvlzjOpLcmlJbTWgg90BnPvXeqJCdIpw=;
 b=BCeiEzvNy8cMye4V974bWj+uXvdsIyHcPhSbj5+FGOefO88L//cWs2nlCQwOzfSV5h1JEf1u4um5YwScChsif01k0OSWcx+CI/+Bo9d6mAPMb9F0psQa/1+jB9j5HPHYNuiB/GPXr7w+jml81uSNe3CtKnvWFdd3qbH6lXnNQCI6nlhW2x5RwVQMdswxN3tSWhcjn7C9rmyQ7iRrZ213EM1Pg+OYki7iJU2zfVgNtef+yq/YNsvU7ZbB7q42Hn8MLvAhsLXHYFejBr91WtZXJd50/o0P+UFhNiCNICyKcYGEpi1oBIy+NjQLiL2pbAdRSyJdTB81TZXTysa+w5vigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14rrm7dFweCNvlzjOpLcmlJbTWgg90BnPvXeqJCdIpw=;
 b=QZzeqDFWdUXeDKlPn8v/rISgsTZpeDL2e9wvENtddhJ1tiem1rGel6Bcd7+owuFndbKywsmjZpB815Hbzn4tpNOjSaD21/JPC1wYe1tTcEnlhkvT9ZByvZIXrKAlWLz6DORTcQgKEQ8RJpLy4lLgeOS8Mh9hgoxBT675WKDq03yNLBSHY9KJ+dccuLjLTOhjm8KS4AWMBkwvadqus+lofkHj3YERxJAKFCb7Flxg6Z7yfthokELx1Yqvv69rwCYcMOVLKTcYBWoxTqTvnIUDhSqddN7OP8Fgnm+60LOTzW1ufrPczokrce0C2smhmGZk8brZAcJkaHtAP0TqRcPXtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Tue, 2 Jan
 2024 23:47:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 23:47:15 +0000
Date: Tue, 2 Jan 2024 19:47:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, sleybo@amazon.com,
	matua@amazon.com, gal.pressman@linux.dev,
	Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next v3] RDMA/efa: Add EFA query MR support
Message-ID: <20240102234713.GL50406@nvidia.com>
References: <20231211174715.7369-1-mrgolin@amazon.com>
 <20231211175019.GK2944114@nvidia.com>
 <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9790d7c-e904-4014-a238-343f376a08b9@amazon.com>
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: b3604a84-91af-4dcf-22fa-08dc0bed25cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2IvxnSCEx23Tk24IKa1dE7rNyQuYBMUsDejVFYK/IFrECSwKOFFsJqsxoPFns7DS6P08GGU5F6PYU16S03dzPqTECqiE74zAthA4+eijl1DnFEM9kvZW+NmX5CbYTSEXkUJZniaMwUZf7BXiME0OXh/ZKkHArdp/L47NdSzj6d/wG5AazlcoW3K6qW8bQm3e2zod/vJY3hk2jmA1W+SI2IlGXe4dQUTaCDpFZmo2ZJBTj3s425kHaeCoSfeXxtGJiB/ercBcopzJWWE1xpU+fvZSOQU3XSxgtJ3l4PjOovTNKsVKGjxPVkq6RF9mvis/CZgl/nlxSxJd2tLheNZP1YgM6k+j0Le1t5U2hYzYYkbY0rXRkVPnEpqMdaDr147A8moQTfMdlQqs6pGSXZ2uPZIRmLcyIIUuPw+FuqxxnF1GR7KqW2ODvzk6CjJdBEoeANGDBj+o53MUbsLcQByPbSzNYSHOC3Wx5vUVH2LofbtOo6MY0g8m1+ste+3n0w0TyCjV2bW33l2gvS1T6S9U/TVa+loNtQRp9E2buY4i9AmGRvPOXX+hyxQ3Ux68cqQ7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(38100700002)(6916009)(316002)(54906003)(66556008)(478600001)(66946007)(5660300002)(66476007)(2906002)(6486002)(8676002)(4326008)(8936002)(26005)(1076003)(2616005)(41300700001)(6512007)(6506007)(33656002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueUxlxfn33lMuAAZTgYdnEt9g5aW5SJPYGWis3LkXsWJb1g2ch8kcsZSkXgf?=
 =?us-ascii?Q?IY3rMDLQfBNcCYzZqKUEjGI0h26MCyhIyga0spRIZIQ4J+X7joVzBzp6r+jv?=
 =?us-ascii?Q?DnAPIwmGDt2GhNWcHVf/fVSk/qbgr5rEZl/BmmZP8kJgnqzcplL/K/1SEYWh?=
 =?us-ascii?Q?URzU9GBvz4LR0G+4aQKSSpZi/QtLNkbzeq6phKuY01Pj9dKujHsudA1sIWfC?=
 =?us-ascii?Q?HWJB+DbNP3sWF6xLBPOyRAZwWVYpPIxO0iHseqluzJ2vLiaWfy/qAM4nUo7J?=
 =?us-ascii?Q?Lcvw6QwpwV4KL9AxS28Tq1q9M2hy8/iIOgzPxgc9ymRN2YGdvmo6Yw/d6hNW?=
 =?us-ascii?Q?FwL57voFEGgGb7dKFqHDxoHpKXKME0rsr8EAYkPUl4ffdGnUSKViKL1zjeZM?=
 =?us-ascii?Q?FTM0VzRmIDa5fiU7zFIuxCu2zr7x1sZi9IhH7VA9BfQR5QRM2hsmp7F9odZF?=
 =?us-ascii?Q?naBgxXtm10OzTVKDNZ6n+It3AwTJC/PlgLutxgPgBkyAVIrHKGjSaq72rXpH?=
 =?us-ascii?Q?PIX8xyagvmV7ZYLwYpMbHbyvDcLodtimg2zR1xFnWtWSYC/UGwYi2H5DT4ZS?=
 =?us-ascii?Q?Gha8Il7t2mwNfN/U6M0cLeMnejwtFj96pqt1B1NL1zv0QVCWyBA/LOycz5mC?=
 =?us-ascii?Q?06Y9Xm+Z4gzyIVJ9rVXVfsViPKlwDyT92I+MIQpL8GUGm5mZ//UQK3qMB8jA?=
 =?us-ascii?Q?CCb1+Fzkeyt2E+OCIy6Xy6DGzbtsoDLXTEfSbugtAIwmu1Z4Ih8miynOyYBF?=
 =?us-ascii?Q?k3Wr9gVhhVszYs3uPSChepZUduPSHL1rbvIEF/eYWi/kr6q/Ei0C1Ytu740C?=
 =?us-ascii?Q?0v0831lomACyy528QcyLc03oaWiJxTUeQjiGojV+Zi9KpRtyVHC+vZwFIQFR?=
 =?us-ascii?Q?C4M7LDLsV1EoXZ2xdImteZ8ud7qs/fOxcIdhKbPZ97Z7CkG4IBsKTeelHGKh?=
 =?us-ascii?Q?K4/NAaOkLJ7LXHAUYsFfKmOn1gIaptmMXJSKf1AYp2sw0vAN9r7iGt7eRm8x?=
 =?us-ascii?Q?wPLEEjb64Qe7IYFJlMu0xh798aJP8Oen9ZvHbRPNwLc8rNYz3u2dYmd+EoUc?=
 =?us-ascii?Q?rbcJ+coV5pa33Ce6YwPU+ER4m+xUTJTsSMyEcfXLhLCWn+8G0lPgE8m6exKm?=
 =?us-ascii?Q?0/j2+O80Qoi7EGVR+JB2wTMUCcKfNVEA9Whc6ZSSuhiti/GXQ9T43VuTIDrz?=
 =?us-ascii?Q?hIydJvw541caNXCOA8H3UM/1j60ISc13u4gMuMZWLSEIgL6AtgO3Pe9t0llT?=
 =?us-ascii?Q?X23zqMQDBZoHfeA8TF0T96gy6FUbuP80wnRr0TFqrIEtMm7Wi7KyFgAkg1LB?=
 =?us-ascii?Q?CZkXIJ5amnp72LKV5eri+Ultn+3MVi5btaaYMvuekhli74zqRkXPd23uIvRU?=
 =?us-ascii?Q?4snhXoPQvnMCJv1wLLQ/OY53hOzUl4yaKC2fM52h8uC7yoGx9nbDPbInh7zB?=
 =?us-ascii?Q?3RGnCAOmmUludvc3RkTsxPJsO1/brrjVI7mn7uxekiCIyC4r8bJnYmauMMXm?=
 =?us-ascii?Q?quwzWGteNV6Dg+hPQVaYTfqOhmDsuc3HpmZxNMR3P5Lx3TunCNGRqn7/Cef2?=
 =?us-ascii?Q?a4ko46izjdbGYRrG+n0SjEfefBP/Q9PL0No031iH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3604a84-91af-4dcf-22fa-08dc0bed25cc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 23:47:15.0504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfDvbu/p3IJFf/mBBYGJAwSov83B76x54DPdaJzCZHjtiLLlvT8b5nfvMGlBb6tI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341

On Wed, Dec 13, 2023 at 07:05:24PM +0200, Margolin, Michael wrote:
> > On Mon, Dec 11, 2023 at 05:47:15PM +0000, Michael Margolin wrote:
> >> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> index 9c65bd27bae0..597f7ca6f31d 100644
> >> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >> @@ -415,6 +415,32 @@ struct efa_admin_reg_mr_resp {
> >>        * memory region
> >>        */
> >>       u32 r_key;
> >> +
> >> +     /*
> >> +      * Mask indicating which fields have valid values
> >> +      * 0 : recv_pci_bus_id
> >> +      * 1 : rdma_read_pci_bus_id
> >> +      * 2 : rdma_recv_pci_bus_id
> >> +      */
> >> +     u8 validity;
> >> +
> >> +     /*
> >> +      * Physical PCIe bus used by the device to reach the MR for receive
> >> +      * operation
> >> +      */
> >> +     u8 recv_pci_bus_id;
> >> +
> >> +     /*
> >> +      * Physical PCIe bus used by the device to reach the MR for RDMA read
> >> +      * operation
> >> +      */
> >> +     u8 rdma_read_pci_bus_id;
> >> +
> >> +     /*
> >> +      * Physical PCIe bus used by the device to reach the MR for RDMA write
> >> +      * receive
> >> +      */
> >> +     u8 rdma_recv_pci_bus_id;
> > What driver is bound to this other PCIe bus and how did the iommu get
> > setup for it?
> 
> It's internal bus that is not directly exposed to the host. Addresses
> mapping is acquired from accelerator's driver as for any MR residing in
> accelerator memory, and the translation is owned by devices on that bus.

So if it isn't visible to the host, or connectable to anything Linux
would call a PCI RID, why are you giving it such specific names? Just
call it 'interconnect path id' or something and make it opaque?

Jason

