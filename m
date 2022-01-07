Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA3487D78
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiAGUHE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 15:07:04 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:61024
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232029AbiAGUHE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 15:07:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmITFr7dRYmGMoWG+Th/1VVHR6Gv8sZBLRQkwEaoyThwsYNHoQzeTuwgVX7iYgi8uK8nV8DagjpBV5SqiQXcADCz273edl1U8gyWtHeqanV13or+Dd1YHw75tPcGFTBh3lnYu4ZrcCeYnoQRizk3n9pEqhKh9RNFgHlPrRUMZG6gTy1fzvjqLzKYpnlO3rewAeiLz0hrhyD0eckTWPaLhfd/dZ06DgWG6HcXGwLbDvh4lo/w24hpwnb1r3K2Xknrwzyfl+HkAFlq1vV1o0veauSDEjEY8nqXKhFOyoVfVejaCJSsNJHmBkpcaD9euaXsCEaCNL51rEz7O4P33yA7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYjR2zy2SG58hTlmFtrMnJ8JUnn9feqFAB0juJ/CZlE=;
 b=BxIegbzdlyVt1ObTcV3Bud22ZXS+9yQ65pDbRePqke41cIF9Ls+ttNy2lKF3tS+mdhU0kfAXfk6N/3gKHq+imXn939fkQ7RBJ6aEaEQk7xPiXBUdyrd493LWBCI8r4QXUIyuKOznFDi5VIr+5spoDcOQtvtrwPnuAcetrLM8UADct3ufmbRr4z0zOsY1qIXfKOg/QAMWZuak3Mcv+B39Rf6XI2SKWsI3GsrBj29JzxRBAo4kwRel3PUwG7P+InzeVU1bk1Ab3KJqRQVlZN0gv2T9ikqQdjLYB65zzGnPoJUuvTIhM1Gc2LxRJ9lXIx9mK7M0EDbvoPSsLLH2lpsveg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYjR2zy2SG58hTlmFtrMnJ8JUnn9feqFAB0juJ/CZlE=;
 b=RkVYFEboNBnYUR+egjaMaPXNYlHOyugnEmzisAjamWbIaBVxCvokBEUYvu7CWsylsaLfS868hTJw4jy0jDq+QQwMNyW5iZ9KUptU0bfPHBO6Z/mOdqQClXFEs0wWvDehkiorYrbaW3D4+dcVSHjnj2fmoVnEVS7t/9J8jH66CpqThGEG0F2QgESbFPQEEYQhGMYA4S8yriNNSgfTkvc2emEEIxnFsUmzEwYZFqx94wFMfld+/jvGQoy/H3emQ4BC7hMJxC2BgLdCSIiGfwSgUDL90c8giGkF1/13KDzkVC3AEUwiv90eYbQq3A2RfxnFSYujDXkY9jwqF8lZPNbGcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 20:07:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 20:07:02 +0000
Date:   Fri, 7 Jan 2022 16:07:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 1/7] RDMA/mlx5: Merge similar flows of
 allocating MR from the cache
Message-ID: <20220107200701.GA3107651@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
 <b35e219a9895101459862bf0e6430d8cdc7622dc.1640862842.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35e219a9895101459862bf0e6430d8cdc7622dc.1640862842.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1701284-986e-4d7d-011b-08d9d219452e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB51896187014A192969847E28C24D9@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai9Y0GWoNm9Ll9VdfYcL+8T+ygW1AEj4ZnDdkAAsubQ40tyitEnK5vtI1aLXwJzH9jOlv+/Y1rfeSNuMQlP+C+7n7q2KLUi6wIgUbZ0Qfnd8zy4/4iz7f+SLURfC4Kuz4Dw1OFVdJ7EWkH9MSf8YHugf8H0WLkk8NH6zHPzDsotoRyakIkVzTssWi+ol44nqpal0GIKrLyCWPkXnt1fR1TSLY2GtC7DVe3EPXFRp6szLUloYYBZ1J4XxsiogVyDxdxINdwIz5Qpmgzrn0EpiP06R6mdI1oY0WKdL8q3U9QxlM8AI4r7/m7LR1uvJ1qctFHR7z27Rt099lH0Z4TFixpGXLt433utcQ6X7REzSw0tMp/5UOjqBPT4V6JyA4xq7zWq2j2tDBofwRShyo+gsGmbiKJYqf8ETuF8ryQhDR1cCZNCwCVQVHTPfcGAW7rAJSBC5icJje0a3yWKfS2JlzWIiwgfV4G4D8HT4tf8FbWrDLz3vHLfMKUcsDJcrpGYixtmgX3zRx7HMzn7pEfY+XoMNvHtZW2K8n0jtHcZjj7sgtpfgnDrl1HOC3DX2tauc/t7cOIFDhnUJzIc+hPDXfqMRWtwLgV4KjPXJseyJcsHPyXxxV0u3dMB+ARVA3Hujn5DlDg5h5IDrg9p+sX1YZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6486002)(5660300002)(8676002)(1076003)(6512007)(33656002)(8936002)(86362001)(2616005)(508600001)(2906002)(186003)(316002)(83380400001)(66946007)(66476007)(66556008)(4744005)(4326008)(26005)(6916009)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Xt/sTN/NGLbXbAQRcH88VGDB1SxH9+V9H9tpfXXVdCAMWrHUzh2AKjvJ5zO?=
 =?us-ascii?Q?zk5WeW4wfPE9GsbZ6OmwbmXT5EjmsL4GEdmHGmknVbkz0Gf+ylF95R/p3hZo?=
 =?us-ascii?Q?f3iX2lufbJt58c4mbAtQ6LS/GT2PiN8pnYaO8eLu7ira0nk7+WY0y2dkhMdr?=
 =?us-ascii?Q?3g0xXOykM2TgzBysubanimTgIHdA2vcxoAdNp5wZySIHHNjbCWbyBFjkzLA0?=
 =?us-ascii?Q?lno1KE5WFR4EsMIaU4huCdKGN0ujRQNYIIPqL9jJCWhozaN1LkAnrYO3qsN8?=
 =?us-ascii?Q?4mQfg5xdNY/gdEhT+aB7OCi3yznrfBVFZvnSn3DtTDzSHd7NGJjnLEPRNx5f?=
 =?us-ascii?Q?YrZPwwKRN71GARCVyYO3Glo+hppgaEZ63Z85RMzpwa0mMi6FpSy8hIYjVhU1?=
 =?us-ascii?Q?js3QBpmhy1zn2GPlzow0j47rdsF1LDPE4PZoN2F8MDVasA6Q8wfpAdjMx+cU?=
 =?us-ascii?Q?jngkz4/bOOyOId9tBdO2NaR9QV84OjtmIvqPGTR6tXR/kOUq45xij7IJKDu0?=
 =?us-ascii?Q?AHWZhhp/IQ+VQ4RUjhTD8hJtB9ypffp9bms6Bpp0d4Y/UPV6zBVJj2LdDPsu?=
 =?us-ascii?Q?OjbNW0YO/V+utCW7nMJcVDgPeKwPYJ64ptxMJmRNntlJT3Mi/t4nYnY3ZAcl?=
 =?us-ascii?Q?gzDGhosKhEnUoUOxl7uhQC2XXr3FQVRvK2j0GAHEZZs2zlkBpcuZ6VclWN/2?=
 =?us-ascii?Q?IhEqjbKW2AviG17syMg6qpf4EcKVvW+in2Z2n69RM16QyHKZfVwnM6MTIfJr?=
 =?us-ascii?Q?7UoKKXYkGyAXoJEy6oqJfCRoSz3ZnFS6PXY8UONCoT5LPiagj/XcN7kJAAyQ?=
 =?us-ascii?Q?dbFHiRIAnIa7Gf9gNrpXxD7iiqmAKJ5SRZgAeZmvHnXllrUtAcekbsrn3t9A?=
 =?us-ascii?Q?aj2qk4yu2W63tg3C9FriiCvKRemW60ibbBeGJyjqjDj9tbNXlxtGPpQU+fkY?=
 =?us-ascii?Q?nl2N0Ssg+7zD355TZKI4WBxVfs7YwoMqGIMRTqEFAAn8CeDcEfxwmBrgDVp/?=
 =?us-ascii?Q?3UxQAOVWJxY6gfbYzAqES/vm1yw60T+qZe/bs9tS0xN2FeHGK8SzkIzrahod?=
 =?us-ascii?Q?gtO+zJ8FNa0qVVcQRFSOhDl3tPF5RkIogdGe40ESXy5pFoz2n2+zpVAz99ed?=
 =?us-ascii?Q?N0PuK59r9el3ltmmH0Y2dSMG2rjja3zz2Ft7H+fT7gc/husLuJQ5MIie2Hu+?=
 =?us-ascii?Q?ITlXxKPROhnoIdR0Dwp4Y407qOxXtAGzYWSKTYfLAsjG9/wP9z2gRyDLwj3a?=
 =?us-ascii?Q?/pQdkiqCjahRIlKoUTdpM+RauoKQlmyhvJ+oFZPhOWVtfH/yd5+jmXmNlXtR?=
 =?us-ascii?Q?JJSU2N5fG/n59nbOqbJfIYer62yfaraXTtIHmS93vH5nvaM97Hu3MeMgXGr/?=
 =?us-ascii?Q?LQSj+nvporlBAds+7m2v3Ckum6e2ndOJ55SlTWEhL5v8IewZAqaw3dvIRsPK?=
 =?us-ascii?Q?nyHhcRtDwr8taXvn5MRH1tdFHOBD8Fk0JuHTwaUcrZS8pe0LQzpTQWbWEZdU?=
 =?us-ascii?Q?BdkF7OK7QxjiBOGaqak/IfN9tG+7UFzM3nQm9Pwg8gqkVqzQ5L2XPDk65ikQ?=
 =?us-ascii?Q?Zto7lLZTYqioLJThSos=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1701284-986e-4d7d-011b-08d9d219452e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 20:07:02.8168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6/Y5ob5Ig8g0KBrn24V5n1ovqNX6kqEDk52xYAnxp2LSH2llstbliaN0a4CZtp/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 30, 2021 at 01:23:18PM +0200, Leon Romanovsky wrote:

>  	if (list_empty(&ent->head)) {
> +		if (ent->limit) {
> +			queue_adjust_cache_locked(ent);
> +			ent->miss++;
> +		}

I don't this this addition of ent->limit makes any sense.

The only case it triggers is the two ODP callers and they should
definately increment miss.

queue_adjust_cache_locked() is an effective NOP if limit is zero as
available_mrs should be zero too.

Jason
