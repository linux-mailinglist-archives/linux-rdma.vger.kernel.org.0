Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956CB440068
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ2QfB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 12:35:01 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:53153
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229623AbhJ2QfA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 12:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD7/7wFGXE6NERYw+RXFTNOmL3IE5v5KyM4K4lWTcYxd15qOkf+TWAfI1bfxS9dmYUYznJI+hmNV/R22BsSqqWiT9f+4g+XGjFkWGOAr22+IJTVc0NrhKLcYpT+OmK9+AsUAK3xcH/+ABH75Xow7jgFS6o4DfGkuga39qBsvaw5INR1rCUCI1JUaPgygrk9DwXAdV/FycMAyq3fR/WM/i2xCvFtGGkAtwAmAr/l4E9jA8ZZJEBqOWTdUzAk31ElvgvqNdMGP0IKEgpGUpZoJb+PUAIFRrKbdKJSuLq8kqs5tuelvkhk6xEpjLKAhr3/jFIDb3At9yJEai0V/rs7R4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsob30w4C0XwoXxwM0kMtp3RL6V6FZRiOPGTiPd32JU=;
 b=el3AjUQK+FjPVN6V8jyh78B0eaxK0+ydplUuC6i6StaKtYJ9Fsld+TOWHW8QiuBqhqsD7brY33VbUow2A/4NaFEBpzJwrOc9feDwW+5/8Yxx9azqe/dOXWOPStaWxsXiPzm4bqkGg2jkQ9c4fCuupluQoniCYdtgr8svtbC6xKnmYuS3bYpBx0DSiZHtOAFxWvf47SiGUAs0tt1mxg/dtBY6la+PJaeNrI/MumkfalVAwgy9bVvvW9VDYQ60F91EwkCHv1tc1ZfKiCStG3AmCMeg02E74ILNDznhtikuihPfoFqqzpj3yFCMTm0+/hYeLlNtlVjNGaGfgDGE7HcgIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsob30w4C0XwoXxwM0kMtp3RL6V6FZRiOPGTiPd32JU=;
 b=YBA958XasFNtA/B3iKNipSop2/HryiVCTXfZ6o+mNn61ZLOlrHjcJ+9egpa+y+Ben4GWOZPM4aUXWkhSVNrWajULi7Qsme2niEvVJIBjXZXa7dG9wRHr5EZVeUAti1xHARTGRQ53TvTXspo5K2V4i39WZIOCRANhsBiStYWuqS055G32n/mlC0QUJAPTU9xd+luu9naaOhIOb5Ppcn+SHU5cgGYriNAQuvQjDZdPCG7W7eR3AbpUd2hk0XwhBX2G+DptHSi7Wz5B5VW68s6VofX+0ivyW6pZBKA2leiDkvMBoziC7sOirOA6MgYvzQSXs+EBjTn39jPBNXnOe9PvwQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 16:32:28 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 16:32:28 +0000
Date:   Fri, 29 Oct 2021 13:32:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/3] Rebrand hfi1 from Intel to Cornelis
Message-ID: <20211029163227.GB851638@nvidia.com>
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: BL1PR13CA0336.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::11) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Fri, 29 Oct 2021 16:32:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgUnr-003ZZ9-HT; Fri, 29 Oct 2021 13:32:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bd3892-d07b-4e63-db45-08d99af9b283
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB517402C6C26EDB479E1CFAFDC2879@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbfAYrT0cNtm8XZ5156BbS3LhkBAOORurQebVVXTnulxmgxXK9prHNx2VjUOoF928tdZlCGMfbcuUi/ihv644REjS4XxnOQIJuABoH7C2wm3JiDYRq0BO/DVvZiTIBVi9Z6zcN8i9pZvzLAC54kcIbldL/7+RKRXEOtPiaQIsoVa0oVpAWZEeowTVybq9p+sqYddjObqt9cWiiepja9myp8Cxk8NX2/PSb8UqTHKnHv2jzNB8GM6QnnOoVuFX4CjBMRC5oumwUFixbjU3t6ZrbWz2AVYHnBdr56AR7f1ihKv2HihtiCHk/F+L+df4b+/IFFYznHBaa7KBdvSli21a4Ujn7mIjIH0sikPtCUxicJzUfIOkLZGvN3opRYCi2nQuhCaZ+1FApCq3no5dmmFNQEDQWpjARYbF+mzPqJuwnJgJvzyVOLWoU7MQflvzN2LQf2pLUcxpBP0P2+lUL22JGWcE6JIyYYgyeKbzv80i33Wqv1ejmkH10Z40GTMifF8+5IGMowVaD84MDJRwbaXDpPH4HWj3VY4KwS4346ewOGndudkSP+xcYAb98e0QMOBmHAPCnFkIiGp33vwbC/1ZO8GaJ/LkRHJcvWMprLkxwoph4qaq6/zN8mFsDFMMiGgQKIpCXkU5yHGtbGS27vst5gklrPxquOEhI2UwaarMdyrxrqbgWtg/8eZFUoiloiD4PPP5MHFu9wFazPx2PIYSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(186003)(316002)(4326008)(66946007)(66556008)(6916009)(426003)(26005)(33656002)(5660300002)(8676002)(38100700002)(86362001)(1076003)(4744005)(2906002)(36756003)(9746002)(9786002)(508600001)(2616005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yz3cBJq0xzXm38f2qgwwXm4MdNk/hkV1pS/ByeMReqve1MxHChWhIWLMU196?=
 =?us-ascii?Q?zhiSAwTJRp9vFZD8uZBanNyVu+19/VkGUkNLtEerVKIe5YsmMyLecQvLPIMF?=
 =?us-ascii?Q?vDHall2agyEiwK6nR/W9M7pc0W/zzGHBBv7pJyhvkRcuZfzeagpRg+iN7CPE?=
 =?us-ascii?Q?bNPc1nQs7HMcabHRCB5cCRRB9ngpbwJzMSTf3nJdYKsQ8wtjILjUH4DOyTu0?=
 =?us-ascii?Q?9HOOgJnqv/z0FBwshop+lDptqFvMM3TSEyZ2hfcNa/OIxlJ7+O72VRzuz5yP?=
 =?us-ascii?Q?SqXFSS5ImcuHx90fN00sUA08d39g0NzU4C919gS6ZlsqI4B+0MPTR0s6w7yf?=
 =?us-ascii?Q?OTNQFjOv2WHmGtoaF3o1hJaKDlzJHYaUI37zx1WkOlNmAqHxCuBAkhiFkCsV?=
 =?us-ascii?Q?YfNgMg86vGZEZR25LYqQyUBP/ZlkO91ecGdcnk8VbOTZah+xOB8c0QepnJIN?=
 =?us-ascii?Q?mqmUEyosZbY8kfeJ5+m4n5rOraceP52y2lmn9SWfBup9sXU5cb+eYm4U5gbw?=
 =?us-ascii?Q?0OZh5ahERU1Y60u1LKKcTw7spYRB/Ss1l2TqOig/JLiU8AcVJH83M5CdfWgk?=
 =?us-ascii?Q?1nRXUDsRN8N2kq+eots6D61sduoHG/iQyw1rz0iwLaovKwtJVh3y5Pp7Ov1/?=
 =?us-ascii?Q?DZvxuERZiBe8/1EWxZzWPv7PYWfXtX8VTmNbmqcUEnV4uyCfzv+vSiKKyTaf?=
 =?us-ascii?Q?T3CRiVubMqWe5OSoCIn0Fmc+BEuBGjuMoCgiiZD9RKWUucZuHWjOVDI8KRsK?=
 =?us-ascii?Q?HOUDVWl6clTM+tB00o5JHb1gjLqXPjvK9yfbvdzrKtuknU93EfcBm1Rls7K7?=
 =?us-ascii?Q?U49vW5wCnBcEbvxP1KwS8LHUHsTyqtrra+ZTDT4FG9/M4nmS/Ukr80sXqqff?=
 =?us-ascii?Q?scGVdq9cQJurGMProcTlg373iZQ4XsDmgz2RnS5d1e14mApmibY0xDFyAyJ7?=
 =?us-ascii?Q?iX4nDlby9x90KbtdItjTnfB2I0k5TztK+tIO3OG3CHI0f8XF+A65riglkn1H?=
 =?us-ascii?Q?tATYPEMFymyEmaKQu1/dp/Kwf9Vy+qmhUsyJADjLuuqrnLtv9/CW5x47EVsY?=
 =?us-ascii?Q?2uJIbk/SojZy7reFfLxLe708IJhDNosJ2gVOd/j+sXth+noMQj5Ijmy6YMlo?=
 =?us-ascii?Q?m7YCneTVU17fdxm+pVQ0654yxqwqotQQOzNohalS+ck+1ALZEkfroBiPsZvN?=
 =?us-ascii?Q?Hlhm5/D/3M0A48DD7AiyAc4WjUW7DGfzcMSKdiY/YzHg86mvTGjc+ANeLaC0?=
 =?us-ascii?Q?0OnydLEWfb0pFHcjSE4kpKXeIQGkOs3d1i3Ri0gWOBPahURBBeBOTReuP7ni?=
 =?us-ascii?Q?y97sX6DdCs3Ej8lRGntdtP8PqtJNp8N10VSXLfgjQ1/QxGvIjY+kxeQzw+Iq?=
 =?us-ascii?Q?bMGn4xbCEa3tnKxUNmuRPK/WouvL8TKgS/mVeaMTHTmE2TR/tYOWCj0G9bmm?=
 =?us-ascii?Q?JiLEcdLRbZQSwDomAYT+Xz24BK84eZbfNFrYV1Wqb3CFkgqj9SZ9y+VdQh8d?=
 =?us-ascii?Q?5VSgktfi05IABItUgobEy79SbEP95JLg8EiC9Nxh2NRcdBi9a4Y6nSQu0u59?=
 =?us-ascii?Q?BLkQwhzuInRxmSlAw8A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bd3892-d07b-4e63-db45-08d99af9b283
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 16:32:28.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUFXcZebjzQXIbzizbxgbw0/p5FEvJy/o0uWQp4JSVB6tJZZPHSFX38MYS7qpUiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 28, 2021 at 08:45:55AM -0400, Dennis Dalessandro wrote:
> Touch up the Intel related branding strings in our drivers to reflect Cornelis.
> Note rdmavt did not need any changes.
> 
> ---
> 
> Scott Breyer (3):
>       IB/hfi1: Rebranding of hfi1 driver to Cornelis Networks
>       IB/qib: Rebranding of qib driver to Cornelis Networks
>       IB/opa_vnic: Rebranding of OPA VNIC driver to Cornelis Networks

Applied to for-next, thanks

Jason
