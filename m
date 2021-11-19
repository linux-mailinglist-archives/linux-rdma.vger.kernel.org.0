Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B29B45760C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhKSRok (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 12:44:40 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:64993
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237462AbhKSRoU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 12:44:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdBv6LaLNRZa1cKX71yWeVGCX4rCYw7BpsOOKsuf2vp34Pc552phf48P7LAagofJpACMIiK9t5XIlhwMoQl7e5rl/r+THXB4SWIWFcuwtxGfEYkT7GAOGW9p28LHDASHkzgmBJVr2EH9F3/BjblKykdmwbECm9d2Af/X6CtfbiEth5nC90JIpUsarStIiyFcEqHRjwYy2EQthbo5/76qbBp+AmcSHQWqrD4osiYJWjcDdTRgoCQJMsDcU6HMZ1tXW3ngJ6t4cpTfal+wX28HUqMsD976rHA9+PFuxcoduHfK+/62CqJTV93j/QB9SEGsz9+da1MSjnZWDgtvfUBbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpi0btqQqrKK4T6z+Yi1ARiTCpX5ZPAZMU01TutalvM=;
 b=AETM5eA560u+ehd476s2C8hlHpg/b7u8nYjUJDAOLNafmV61dUsck9tKkFLk9XHvJrtiHu8t6wdFtZnsVUAIz7ZK4UL/NzSth4BgTWkeS4f6s3zKptSMw+eORSWeu8Za0qJfJLI82ZsSe7tKuDAgIye0yPaM+q5Flet3f1bpdV5U+0c7oBHeTwj/4gp7BKkCrJk6aMcS/bGbpRXsOo9jpmgse3FqnAaF8laOWTI2CS71qhwnZIhnWPcZ3A2ikLia9PJ2BPvYfn4eWyVnq97H+84PPNrCw9Ak3yuSXdDWiEJF+S27L6n2zLGiEekAUNglsQbX5/MFkf54JrQD/LdZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpi0btqQqrKK4T6z+Yi1ARiTCpX5ZPAZMU01TutalvM=;
 b=Uz+WRVnmM7UM80FabICIh3/jLQqdacbIR9onI37hLld5WSlOC1NRsLWpdG+rGUhVpH4AkzDFqDfxrS5Lm1ObZZET6VVrbvO/pr3fBlSIJvABoOpLZAIKCQryRRg3qdnMbBMt+tzcD+aKBVJf10QlM8ksteQralqQeGwGjbRF5oHMciG2MAqm0lJ/JoUDGtmwsubW/brL96VDJtNVeUQb1xMZWcZ2RODkjUn6jPUwS1D6dNpJ6p9EO/Jp2Qm+N4P1XB54Z/U0DMYepZB8JUXEGq8sFaHUUFKMeHWscJB+NyqkjGU3rDeAb84LHvHkq6dZAVV5LPFXPizzHGY2AZ/CqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5238.namprd12.prod.outlook.com (2603:10b6:208:31e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 19 Nov
 2021 17:41:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 17:41:16 +0000
Date:   Fri, 19 Nov 2021 13:41:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 09/13] RDMA/rxe: Replaced keyed rxe objects
 by indexed objects
Message-ID: <20211119174115.GB2988708@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103050241.61293-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:208:d4::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:d4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 17:41:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo7sx-00CXfd-7o; Fri, 19 Nov 2021 13:41:15 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff74717-0002-4387-9ada-08d9ab83c99f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5238:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52383BD6E35B338470159938C29C9@BL1PR12MB5238.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNqk1MNKxq1q1fzIVIId+9v7XBSQx6nsZEBIJnRTLrNGqg3w9YUWjYc9Nc2KwMb/G5GVEFYIQyWSOgEPV/xtOEg+BODHox/2x9Tx4Wm+O+jxlakOsMic426cPldKivNHIhIipH5zHKkwA2LIxRJiDuoKv1xrCdsqW/1ASnZotJjFcAM19N9We9OdQbbO7LCstjEZ4VvQR1PyPd01R/dbgHP3Lpo9y8bF70hG9NZdgVpErZQh4ybEZW8TXHZX2Zc42TlvatgDYVVH/VuF0FoexX+SjStDha1akP16riWdnuFk5UCQB+KZJyoYhE26nkyBvu9kmS5w65F4aBQJVehQ9FPIUfSXjhoiutewpK71m/ReJLA7ga5eRM8swMm3QcvNZXDtTyBiou80yHks4+ycLqd8WKGFsJOA0rX0qDW2ZziHh3Mz+iC2dKJ083t+0S729WMM40Vc08cXZuxf8UEhNS1D201hr0mXJMcfFm0kq7CXc/1MuXS/cR74NUEtCXJ6HFOtdu0OhTYYt0AxXzcuqsqg6eBPSrSKTne++vCUQ0RmpxsTdv2HVPv3NO3e1SQ2BeiTqi/jWTqLheqrRAV02Jv1RDdph82DOETflEGCtXLwtA3p8rJQF4mNskeXZPNa0qFaizEeOoYIV6Ekfm+EOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9746002)(86362001)(508600001)(9786002)(8676002)(316002)(66556008)(426003)(36756003)(66476007)(4326008)(2616005)(2906002)(33656002)(66946007)(38100700002)(186003)(1076003)(8936002)(4744005)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?up8ugAEI/LqKGEd/li6IRTQRIRrcbh1hzDNjjl0VZY9ZxrJaB60HFQadyJN8?=
 =?us-ascii?Q?tHkvHEsT5MnNJckNgPWGchjXy3/KWoqss2P87LKs+u9psetwPWx50zRKua6J?=
 =?us-ascii?Q?N0/y56iOSMThCFi2UXVgDeQxLLOqdU41e+LRFHOs2fvgG8mYMj+FXZKUwW3X?=
 =?us-ascii?Q?kdTmJn+gz6sUcIbR2YKSKvxpbtYYGTwM4hGRiMwEORMExI7hCmZYsgYoPmjN?=
 =?us-ascii?Q?DQT7e/mlSXS9aQbZp8CxaDAdAzS6WQZYus2XhRUXK09w8UX54K1Hot1XixVw?=
 =?us-ascii?Q?YUGNqLkR6xHgW5wqMj6dgUtCRlN/uqpOK06MOq6vskPYpmYV/MZcFgXewwmN?=
 =?us-ascii?Q?2dM4WE9NPW5X+v2PUjdv0dz0yWqazHm9OdulnLv/DhmUgo7F4H+NprJiqr1J?=
 =?us-ascii?Q?/W6l5NtjfcwFjV6a9cmBqDl1B0r+1zLr3cln1Q7OQ7KO6Qi7hY1MsdEKaqhe?=
 =?us-ascii?Q?OoZSNtytBuXISvo40S9RiHRl3S3mgT7RrlU+i5uTrCYEdPCKiMQFTwttgDC3?=
 =?us-ascii?Q?KCTRaTrIUpYOIYQnbE9z1l2NdEfWufLpo1Ij/6Uiz5y5j/I8V1c59fV9xAIG?=
 =?us-ascii?Q?GoH49TzdOz6t+Hf+MUFQgGX5Bg+6if+CzWxrw7QAs1yWjvUUy5bCNSD+uJ88?=
 =?us-ascii?Q?w2GtNqGzAORInyBSotmSPf4ALA81KdEMzWKYryBkgkoTznE7b91mgkeag2S7?=
 =?us-ascii?Q?kEm8LlZYpu5OAVLyOjx7zKRMPfoGIl6AAeVXSCZpI/jFBtCLd7PLmtbmCtkr?=
 =?us-ascii?Q?cTdoXde65XgZ5qAxUEmcwwavVjL1AiriqPD1LzeOupj8ZSefN/ZbpWSMa67+?=
 =?us-ascii?Q?s7lWltrju4u+y5SwhS+gakYLZv9368khgidNjPj7vnxUUF3x5uShVraUdVDb?=
 =?us-ascii?Q?R8nD02WhHU8JEp0p/YcFzuFWLngTx5718I6iPgKtNgJsswwxlsHyI0Zbv7wf?=
 =?us-ascii?Q?W3AKHLQFCh3Rh7p4ce3Pkdb6OBdtbqH/sMzfaf2Us93SVfiLjQi07G4UKEJ6?=
 =?us-ascii?Q?dLVl3RkRojYknIsYoU+OyrWNcipTR3s/789Ld4FcWbWIEx2FTiW9djYL9rAL?=
 =?us-ascii?Q?E5rFNG1Z2oDXNeCkk6yNmlLv/MY1iQwVypJOd6bfYXSIGeCefI5Zdit7BQGJ?=
 =?us-ascii?Q?0l02GKKdLzTc2hMpxhnVKPN7KlhLjBd72y83rONtl46s7YxFn+3Ny3+Bx08n?=
 =?us-ascii?Q?BLT7O0W9u3hb6BrZXJE0EhrkcbD7fTA2Utw/jTkS+jq560DJiBunoKnCa5cz?=
 =?us-ascii?Q?V8Ki84EWJuE11QABLbKODQ5+KfkO/YUUwwhGbx86sfXDvBk9YNYVg1aZGkeZ?=
 =?us-ascii?Q?R2imqimwLCmyWyRl5YiBU3dJmOq5sHoQbCFadGU4xkulwB9PyZWaKkddetgI?=
 =?us-ascii?Q?KIP9DGZz+iPSMn1FoQaU3L9EH4if6AyyFAt5LFZz8OiiRAnoMcTzQAq5eI90?=
 =?us-ascii?Q?9Q5q1VvvCmd7C+3xV+xJBJMjqdcMIuvYOnUDeZCHPfJ6aXkzWqmv7C2mveal?=
 =?us-ascii?Q?DC2CFrYP1IE6naDvBXxtYYeds3tq6BURDlPSS/nqu8qJIN8fdnMTihvkoS6Q?=
 =?us-ascii?Q?3yENFkyjFGHpOCopg8I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff74717-0002-4387-9ada-08d9ab83c99f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 17:41:16.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRLSVkL+rnGtLcPxAZUDYmwEJShaN6hXRppb7T7xw2bnNSayKiUve/uqMcx5HZit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5238
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 03, 2021 at 12:02:38AM -0500, Bob Pearson wrote:
> +	if (mgid->raw[10] == 0xff && mgid->raw[11] == 0xff) {
> +		if ((mgid->raw[12] & 0xf0) != 0xe0)
> +			pr_info("mgid is not an ipv4 mc address\n");
> +
> +		/* mgid is a mapped IPV4 multicast address
> +		 * use the 32 bits as an index which will be
> +		 * unique
> +		 */
> +		index = be32_to_cpu(val32[3]);
> +	} else {
> +		if (mgid->raw[0] != 0xff)
> +			pr_info("mgid is not an ipv6 mc address\n");
> +
> +		/* mgid is an IPV6 multicast address which won't
> +		 * fit into the index so construct the index
> +		 * from the four 32 bit words in mgid.
> +		 * If there is a collision treat it like
> +		 * no memory and return NULL
> +		 */
> +		index = be32_to_cpu(val32[0] ^ val32[1]);
> +		index = (index << 32) | be32_to_cpu(val32[2] ^ val32[3]);

I'm not sure failing is such a good thing, can it chain them on a
linked list or something?

Jason
