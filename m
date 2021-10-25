Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E95439685
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhJYMqW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 08:46:22 -0400
Received: from mail-dm6nam11on2078.outbound.protection.outlook.com ([40.107.223.78]:61601
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233157AbhJYMqW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 08:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfLfE4jmSqZTMn+fKmzs/1mvsm4KwRlonR++BJ1El4Uw7p+nQQ2Rfvd2aGpTih8JLvXhRuKaGDktSX5x3NDvya9lq1sERkC4gvvBSxS0DIrBnIvhjZzGTT4sIggZ7xfia12Hioy/0r7vd4TPwLeh/Y5vtk/QhJZs03B7d/pGZTPNj+XfQVelTjW80/eKnns719RxPmHfLwsu+aDPMz1BPMwL6tkuws3QnvI9qoa6gu7dn1H82N8g4Yd2dsIi/heT4he9FcEnTTDQihoGKToU2J4W1Yf5rz//dOc4NqGEKd4F5QHzTdjTUrUkVCsp1eYSEIUZAvv7LCq6SiQBJfy4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcPLmG64+nupi4FS/dqEGuB82qzQZ632id9p2FAQqko=;
 b=DPk+DSeE58bfRIC39Hm6zZsfk5Ytd8/wXQeMihMHd8ViGmrjxTLBz+SDNtZ6yAAhONvx4jnJVxUWCRO+8i+WbsOIDxyjepQwlmxYiEy9rAsXv0VExR6EYXulnZorbP/c9ARP6t6QRqADkFQWuWGID9mx95F+gHUGxEQfkvG+b3RIWkc6kL/F/gQ1y0tCijljLhTZcPmPmVjevGaG7jz3RUYnQYstqBJiZv/A6EV148v9jCbsOsvxYyTLnr2DrbkFaUuqZKxBGVfrWQaQ5m7pjeX5ao/DgnjjTZzvLWpd9HysdsaYyW8H9NB7NJs+3xNZEh1IQ+z3PtAoBN/198bEnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcPLmG64+nupi4FS/dqEGuB82qzQZ632id9p2FAQqko=;
 b=pDY5S88Jc0OGao8LZl0CYM3yb5P3HwXhQQFbs6siBGiqt4wGwmRVF3KOhXLRh25bSkoS31p1dzRJpfLhr2/OwTlA3EAUeTa3TKe19C5Gc3mrWn+los37A3o8ajj93dvFUp5gR57FKCJjJsseNuAD4fHq000vjCHahOPLaW5wmJJ3NF3J1orRRUHVGDQ2zymvYZRi8f4BZYLlHSfiL/DK7JWfvoQ7ZNnO8r0q1yDJjztbe9Tr6LS4R6wCDKiIWxK+KY/WlFpJTf7Qa/HArRkxDPdnzfoqJaqO2/NtU/17e13HlqriW7AcLxRxIXC3YMme+9i+RA4lJEqZsuwS9Eu1TQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:43:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:43:58 +0000
Date:   Mon, 25 Oct 2021 09:43:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/6] RDMA/rxe: Make rxe_alloc() take pool lock
Message-ID: <20211025124357.GS2744544@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-2-rpearsonhpe@gmail.com>
 <20211020231653.GA28428@nvidia.com>
 <21346584-a27f-323b-e932-042fa7cd94b5@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21346584-a27f-323b-e932-042fa7cd94b5@gmail.com>
X-ClientProxiedBy: YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 12:43:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mezKX-001Rz1-5n; Mon, 25 Oct 2021 09:43:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de4a6c3a-52ff-466b-78c2-08d997b51d36
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52699578AF13F98A76E7B5C5C2839@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XH1uHBiu+y4G72kExMONXffTgo10Th0MBpAqVC5ZEH9EB3bLU+byvKHJz3fj2cUKCnlDF8NwiKPkwznkCoXEZlQ+djy7HB+Bqf/xVTdT+o2fbtACa+S0Wrjx+2k1o0+KPNR9pn8q12B53A2PHm08mxCeT6OEWeajNo23ENyR395kqHr7mHQcRdcT8u6e+QNC6tKHlmbBYfcNEiFcSDMa02FTgi4BePIA7ohY6H7Gc5y7pQ5xdE9gkl5UkueZV9uwu9MTf3MGnvJM0zNfniCv3qXvAMRjGNcGsbO/mizh3VPpmbQcImuzmCqih6JFTA88+vrw7SZYvicG+YU70479BAp+oVqnC4ehTr9czBQK7+ffHU6rX100YpHAnjS2YUQKRRO8E5ufHq4eETmHztthkY4h3qq6io6bpCizAmhVsvSgggHRx3ZqUCzUJT/Fm5e6wlCt1Cvscaq0ZeOJzxwIGmmP5UH0LsDYQqvrGQcrzb0KmUVURz8RLh4FixiRcedWe7ggKUlrxHE0l6qCmogkzFE9AgdpsOr5+kKgR/DEZAmwdzEtrcdQYU9ySZyQPG181Q1tqB/JDhMcpgTa4L21Q+2aZSWTAWtrDp+do7Us+eWuOFdSPSLUFSVi2J9mXT2MoqE5WATIv9zIB9vQDuvEZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(426003)(6916009)(36756003)(66946007)(53546011)(26005)(2616005)(4326008)(316002)(9746002)(66476007)(66556008)(186003)(86362001)(508600001)(9786002)(83380400001)(8936002)(38100700002)(2906002)(8676002)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g4G0kwyuyZbSSdoV4LD72knX8BevQNcGbmCu+rYEXkI94XFcCC4IsQWPtTJ3?=
 =?us-ascii?Q?CrlTfPzvYIZevy0Qo7Tt0MRRwSMbWQGG3HTw0hvgyxDj/PmslwWP8A1dotf8?=
 =?us-ascii?Q?w7sUg5lNM9pZEswDsRVTy08yf+tZP1kp8M6iHP8mvz2Pg6MngWWdD+tvUkB1?=
 =?us-ascii?Q?BwnbuhIksK/jya20bliIj43VgtCoB6LyQR5j0XuvvgVaXucmL1m9ni//Z+p8?=
 =?us-ascii?Q?ayu3K6rEzn098aNw1/1QjZKAz5aVTj51mVr3paYBngo3IBeCKBgGLtQ+XXew?=
 =?us-ascii?Q?O4cGrxeNctGw+4tL4y+usiorZxhwRDD6xdY60RI0YAYr4Q5dUwmpYvO9IUqC?=
 =?us-ascii?Q?xE27cR+MkuO/qsTSL8ldAgAO6MBLDReEd/B6rNAuUx5bNQef880nG1cES30X?=
 =?us-ascii?Q?IyE17RgaKQQyCqVHKf9gqj0G3CJ52mdfVd48ZuSXR5H3JpDTSu/F5xrLjv7Z?=
 =?us-ascii?Q?yPj2a1dzkvccjYGMJRMG9vYdxel8iOOW6H5aHx2O+sAvf2JPEZ/3uQDq6OEq?=
 =?us-ascii?Q?TOeWG+anms8WPXaSlKu3+zXF1cCjzSguYBjXIpnnH1z5PsMPsr8l8+VtKFZT?=
 =?us-ascii?Q?K1i8YVZwJu6yOklwN/To3Lft8aElzU5X2hTgECJBV4HQPIy3Smqx7xqnvWW2?=
 =?us-ascii?Q?/sorZsZn21Gdn32h4U1nnK2lBcSB52npifbqHijh+MT9cZgzzUR/tp/bvGm8?=
 =?us-ascii?Q?QvUlJ3VDxkGvnwRcQOSFD4KA3onHaf0eCbrfZsa5vlNecP02NGizZoOzwjGR?=
 =?us-ascii?Q?Bn9Chfv/wtC31ByHx0Z9Dw0XBsqG83F5cstv9hYv96G90Sf8DW7J77sAamai?=
 =?us-ascii?Q?3sWX7uufkBnaOKnq0Q6vJJGSWRo+UMbNNKUUTqUDM2toiF7ycMCtpZvBekdv?=
 =?us-ascii?Q?6O+wOpahaZ9QlCZkZCLb3J0WVM8d2YfGPpYFH8WbYHdbmFPS/tyIJoBSg2OF?=
 =?us-ascii?Q?1ZEfTV/UOYrRmW7pjHStkgRUytv8If1izHuxE6g4JSNWJZl9MmEOzzfj+DUv?=
 =?us-ascii?Q?ZpEdkJ3xi6yxpmTggBveoo/CEKOR7Js2T6HW6PUDjIJMq/qRRYKkcGhnXapc?=
 =?us-ascii?Q?lyzyFQWLeO6DWp6mV+DgdeNeTPmf1y8bKcrGgfC9MPWDy2H8myap7IJwGHdJ?=
 =?us-ascii?Q?0m6waCWrADQ0V0mYAS9GE8xnW9bEqnNZHIT+u3HIo3IKFmjxZds6fpoOx3RL?=
 =?us-ascii?Q?ekRMif/rEECvAzqhizWm6O39dwpXClxcG0gWvKkpClxZSuiEig6oEtGB8+v3?=
 =?us-ascii?Q?/ZCdk/m/Dntt1mI4XFvPW/m/f3ps9Pqf9Top74niyqTgL+92ISYhWLEiZoxn?=
 =?us-ascii?Q?H+z7wla27/TNLtojvNWQF3iZaHbuH4YhmfSdbDBy7Zi8pjfhdyguke9vHBxQ?=
 =?us-ascii?Q?KS/1e0FeUAmPyHOFBIZtznZUXd3vW1popgLzKnXmhOx1iOEnJRFyT7Td9l51?=
 =?us-ascii?Q?+I65LV6ZyynojVlbSuY/BiUwVoTEwtMPp82QNlTUfw9L0WOlPwWV1rBVVP0P?=
 =?us-ascii?Q?JzYKWBpLT+Lniyw32j+hwWOLhyRYXqKQCtzP23edhrDn/LqYgo5WZT9JhDSM?=
 =?us-ascii?Q?rgE4zc2Zw3Ic7BxLN+Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4a6c3a-52ff-466b-78c2-08d997b51d36
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:43:58.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szcIfAO1aaMkXOPdFobSN5KXIvOzFhN04qixOzawP4OLzQbprIImMlcHHnhm7X8e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 21, 2021 at 12:46:50PM -0500, Bob Pearson wrote:
> On 10/20/21 6:16 PM, Jason Gunthorpe wrote:
> > On Sun, Oct 10, 2021 at 06:59:26PM -0500, Bob Pearson wrote:
> >> In rxe there are two separate pool APIs for creating a new object
> >> rxe_alloc() and rxe_alloc_locked(). Currently they are identical.
> >> Make rxe_alloc() take the pool lock which is in line with the other
> >> APIs in the library.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>  drivers/infiniband/sw/rxe/rxe_pool.c | 21 ++++-----------------
> >>  1 file changed, 4 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> index ffa8420b4765..7a288ebacceb 100644
> >> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> >> @@ -352,27 +352,14 @@ void *rxe_alloc_locked(struct rxe_pool *pool)
> >>  
> >>  void *rxe_alloc(struct rxe_pool *pool)
> >>  {
> >> -	struct rxe_type_info *info = &rxe_type_info[pool->type];
> >> -	struct rxe_pool_entry *elem;
> >> +	unsigned long flags;
> >>  	u8 *obj;
> >>  
> >> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> >> -		goto out_cnt;
> >> -
> >> -	obj = kzalloc(info->size, GFP_KERNEL);
> >> -	if (!obj)
> >> -		goto out_cnt;
> >> -
> >> -	elem = (struct rxe_pool_entry *)(obj + info->elem_offset);
> >> -
> >> -	elem->pool = pool;
> >> -	kref_init(&elem->ref_cnt);
> >> +	write_lock_irqsave(&pool->pool_lock, flags);
> >> +	obj = rxe_alloc_locked(pool);
> >> +	write_unlock_irqrestore(&pool->pool_lock, flags);
> > 
> > But why? This just makes a GFP_KERNEL allocation into a GFP_ATOMIC
> > allocation, which is bad.
> > 
> > Jason
> > 
> how bad?

Quite bad..

> It only has to happen once in the driver for mcast group elements
> where currently I have (to avoid the race when two QPs try to join
> the same mcast grp on different CPUs at the same time)
> 
> 	spin_lock()
> 	grp = rxe_get_key_locked(pool, mgid)
> 	if !grp
> 		grp = rxe_alloc_locked(pool)
> 	spin_unlock()

When you have xarray the general pattern is:

old = xa_load(mgid)
if (old
   return old

new = kzalloc()
old = xa_cmpxchg(mgid, NULL, new)
if (old)
     kfree(new)
     return old;
return new;

There are several examples of this with various locking patterns

Jason
