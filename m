Return-Path: <linux-rdma+bounces-9238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96AA806CB
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026061B65F2F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03126A090;
	Tue,  8 Apr 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DalaKPXo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A22698B9;
	Tue,  8 Apr 2025 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115025; cv=fail; b=dc+u5nrYtNZiqkApsF2VfAmXVq8MwYegOo3VlDyEFml3f4zLmVM1LFBh5WSxmHDcDTeRVGYfPD+vB1QAAllvtNipfZew6ttlSEiPT3FF4J/0RBf5CyetIJzKUnXOdP9U3Ehfufhx2MUNs+G2Efx+y8lCPJSQlIlK7H9bO3CIsqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115025; c=relaxed/simple;
	bh=JAMmygxUBUn+QQNivfH4i480GQFeEbWGJrOp3pTRudY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jQsA3pwiYB/evGdXH4xCQlYKZZASJZYqYlWxxJjhcECVEx9rHjselfGdgIUPVuXn/8vE1mx8hevTJEN4Aj4FMN27t5BbNQO27gKYDdfbYcbfGpRp44ysShp+2rowq9sCH8grp/UZd3tFkyAnftz5ipE5ucxhS+AyMQQA48KSjYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DalaKPXo; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSZuMibD+wtWTiJkFlrpb0MoEVleY++rUc0qjcPWdLZaEFGaMlzmRK4X4Ugdi77qHDuKlAWu8C5qjGrqQ3uL+/V+SYrIcUV+S8BYz1nHFXTD2AzuGwwigRDdu75QU0QUAZuqhu6lkug0jGg5YFLA2uIAaMiAdBBF8w6hIyehjN3DT7ZzI+gbPGwaamYrmh1/kOfngQqn9L5+edV3LdznZ7+af1nh/atK6dZzksqb83mbwIAjh5mPDINhTQWWldgPvIbJEdy8sPet8I1EQKkOPhMuAvwf2YOemrAiGMFdSAgd8xI6bqHouFxkruTLE3xDkdYdnbfZ0ihWH1ZrpK1DRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FHTbXTv2KvzDkPPErz28HmzwRNNUxaPmpqJJVcJYLE=;
 b=AS23Wr9Sfk3irNOSqJLBtqVcz+pHvZ8sLoUS0kkItk99Z7EPU6Tc86KixQ+wfng6635HtjIEhx8Tiq0N+pBZMNxtQKWW8el+Raayd2y8fgv55yn6yZtvo0ZPWyOn49KtYl1v7zS8t8KBFLZYojW3tTUpZj8/sVq9baui2jAnv/QnnwuBU+z3XG4RNiMj4mmgD9vwPQ5lSWxGTl6argn8YjqgcIQ8qTS/lE562bbgjrTejgh02Djby9XQC4Ck926kB4GPM9rr3tul2kmnJn/bLr9cwL9Y5C5ICOe/qnQEj+/ElPYH5vDqYGo1aeBs6wcIdTio0jFt3u9QzBe2q9Clhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FHTbXTv2KvzDkPPErz28HmzwRNNUxaPmpqJJVcJYLE=;
 b=DalaKPXoKJZDW77bbE2Jie2g8NheG6e5MWg3+Mva1UGwn3rHFfJh1p7dDl0gHuu0P4tjegl9Tq85LlHREqne3OBYh8JYiJyjswGxE5LnL5456lVMeAuBXYryrTqN1jpjtvzVwHrMLug0n5L4gkQ7NFecjmpvIXxnDml7B50FCtJoSce25/n6giavnlFXK0cE9guzlWGqbF+bBfYn9mRJV716eQTycoeIxNB3eh/qcoKa2bEJuu74aMzqmFdNJ6cfTvc2d591XUo3KUq1u5W8TOIT4v6l9Lw3ap/uXswi9xYYANJpM2LFl6dWNDOdWrt6EfAryCvVuu72X/0S/kXI6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 12:23:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Tue, 8 Apr 2025
 12:23:40 +0000
Date: Tue, 8 Apr 2025 09:23:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH net-next] rds: rely on IB/core to determine if device is
 ODP capable
Message-ID: <20250408122338.GA1778492@nvidia.com>
References: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc8ffb7ea207ed90c777a4f61a8afe1badef212.1744109826.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: af573b4d-dbf6-4d01-6ab5-08dd769831cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6T6Byi23b98JrY2p8f+iC5vr7Jx5/litHFn1O0qhu/J/skjUxsYSU+a94JKs?=
 =?us-ascii?Q?IM3iKSY3/hTJk6MWBOo2q6za3d+RzvObQRJJfXCn/Xdl3zqc36ycHa5AgW05?=
 =?us-ascii?Q?zIt//Fyn1lQClkB5Z14UR0rwMDPLLPnqNvzxXAHYXWQjozvnMfdVivG04ch1?=
 =?us-ascii?Q?tagRVof2StIUhnyJ2YMjA9LtNJ5p0EuOBJu/Jl4EXj8tuH/DNwP8pYEbpghz?=
 =?us-ascii?Q?zA21KxNqIONzSw/7OefM8sjyoM3fYy/GGgpEaXm9JP25u3ouF6ATVEdS+6Kc?=
 =?us-ascii?Q?qse7hIq+uWzvF0+duNt7tSJFcU7dtiv+j4EiMhYanWDJhX+/Tm7GUHZmfXV4?=
 =?us-ascii?Q?yxHYTx/3sVdVuwoUQzqscc7J2wIwpEMoOpSbsqJrkvFuEjIXOWovunYuVmTR?=
 =?us-ascii?Q?l9KU89QluNN1pFn2yrWG0HYUMreatPUFzisgM6CKCFGjUOdN4QhoW0Ocvwq1?=
 =?us-ascii?Q?rruQ2GOPvvb/5MQOy4ehsZhPkEk0ZW3fnjIQcoeUnmfvPis8z9F+cYecjR3O?=
 =?us-ascii?Q?QOX6Ud4vaV/jTWAidSH9hQoHDqOonlYv2fnh6M2AfZ1n+uu52OqmkjTa8Tcr?=
 =?us-ascii?Q?HoAdm1rttCGmI7QnP17uSmGwy9cBDJFSHJ0sahJ0RBGQGuMypj4IvRznFG/r?=
 =?us-ascii?Q?l6nrrhq30vPbFAOCF7wlTWwAQw6Pzjbrb1M6VjYy/U6cS4r4OkCFgxb7IDwd?=
 =?us-ascii?Q?iHnh7AwH2zYKoSZqtt6ST8QhiCx0NkcF9C0Gl5BRroP9B6+Av6Zc4UdT9xEC?=
 =?us-ascii?Q?1TEqzX+BqATaSak2EJbCvD4dMfd3r4P1kJcWTNrvvBUFQY3R1SssrUTo8kvh?=
 =?us-ascii?Q?vG7U9sDQysU0kXu9ptLATpdgalApROQCiZ2WrJru+DB3Acr9biUJiwW7fz/h?=
 =?us-ascii?Q?tPP5CarK5Rhv6fQWp1pJNyUPKxyjIRluvJLy0izaDHIJnrySMq54DboRJEW5?=
 =?us-ascii?Q?ACPxznmf0+i9cCGShbMPOEe/eolKmWFtiTpRFQq5gFR3uL1bvh5FJaEGQRAE?=
 =?us-ascii?Q?oWOfqMXcGmX8OYoIwP0c0ZyhhVRj5JqPlTHZhlwfOGBsAVDALW5CZTXyAUMa?=
 =?us-ascii?Q?jtS07kUQhk3jVkDY2Cwa/gvXZ5VLnrfAzfI82dkc+ieYBy04ggUyZKnUaCX6?=
 =?us-ascii?Q?CsRlzYh4FwXh3UTGlh6+Ao6y0SRQDxN0AzIyGJ2EwRPdjvTNhvNVIlQOjh8i?=
 =?us-ascii?Q?28kl9YjXsOCY8UBSdU9R+Vfd33l+QD5+k6/tCa/T3c5zSZQWuBbPmw5wGNwf?=
 =?us-ascii?Q?nII72Goef9uLsfzqEM9HXYnJvYfnq5+GOplAQMUiwYztOEScQBtCOFgIB+Aw?=
 =?us-ascii?Q?dvxb1TFjha52bbImhAbzdZH4GywKwHx9eUpF6p7s7nkcnPr6cJN8DpyON9EU?=
 =?us-ascii?Q?Vf8eXju0+t1/t0Dc/Yg9Vuy2G5lE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bhXbINjdPJl6PjPssz5pnDVi2FJnLT94YiUygqF/vwLf7JOcH4bAPtEA01D0?=
 =?us-ascii?Q?utss9BXIMdyL/HjzgQDQLdF87uajKMEx9KIptRzEStEiXnCkWM9t6FYcvLgn?=
 =?us-ascii?Q?MIBtgmNsv3L7GuuamfaX2BA41bwgr0XtKvokMOFdCvrnQ85SIZLl5raoWLJD?=
 =?us-ascii?Q?PkfzDC6cG0/k9IkevB3GEFJ2ukmu2sDIMHQudiUhSSoU9LZa6vqKxK3EZSx8?=
 =?us-ascii?Q?MYTgiLUJDE/z56Y2zhwhpOOe3vmgCprgQQReF5mCVF91MpyzvjXf6+tQvgk4?=
 =?us-ascii?Q?jCPkDs6BeApEuWTSYcxfl5absfPe0XgMLX3DRTIRDixsj33ht2mGY5niixxh?=
 =?us-ascii?Q?AaTezQeYaORvB87K+JnRxgs3Wws+u9AH9O/gRSoeDuxcuzIQ7fNolvDHe76p?=
 =?us-ascii?Q?PBQnZ/QZkcghJ9lcwVnsvnsb9ID6XAOJjF5qhvNuI6mNeXKG+pwHPfcORa8z?=
 =?us-ascii?Q?19EAAUycwLAE9DU494pOsMJYoSclo7kyjHy4BxnPpX6erkudNfqnVTFzp5dz?=
 =?us-ascii?Q?FQM89YMYCWBZ66omZ6vTWM2z/KJPspBx7Kwi0ywPTR77HhHvxjUjwQPBJS5x?=
 =?us-ascii?Q?1t4i+CQ98ebBswsFF8ohYd42Rs74/GwumkPGKFFI4SKhRxGgCyn7fpv6IEBw?=
 =?us-ascii?Q?1oKyTo0nuFeKm0Ge3fc7j0MO4mYwNnc54FKCQlq+xJ03y2ZsUtwwCAWIj7Xp?=
 =?us-ascii?Q?h/N7BloWE0lUYfhlGZWPPlhc1L3dT1x+suMIjZW0xvkfyUrbZ6Cb4gaJeEqK?=
 =?us-ascii?Q?zZtU7+5AY7R+PxuKE6ufEQ0ZOR8GJP/L1yoZe7c/mc4BR4VvFlNsRUqcBAex?=
 =?us-ascii?Q?DZQE+72W7K+qrLdJ1ddZoajA6nVVJfl0wq6eIqVv7S6RoLusHxwULJ3gVbpl?=
 =?us-ascii?Q?g0UwiP5cISGl6vnYKKxOCM2gph2JKbCcYDNsXr4G3VaVkNW5oaPy3sZDOJtz?=
 =?us-ascii?Q?FkX6h7Z2NukAxVamoufDSQaZRTXLSNXL5EGmEuhC+lj3E4l9eoc0cdm9HzJz?=
 =?us-ascii?Q?mjpy+YD29AFdyVo8UKv5GN+BYsuf2LQG4AsProkX3oRhXykHcLxfsuHFLRsx?=
 =?us-ascii?Q?c7RwdQVXXFdwdrdWrXrHh7/eP7iLAT6UNgTDsZeDGhrK7f8TVA3qAuIpTcJu?=
 =?us-ascii?Q?P9IDupIeOZEevDzI8ulbR2PiSAeZaBy3WI2Z6tA0xztzZjkFc7rQu8W3KvLZ?=
 =?us-ascii?Q?rwbFaB6YFcNrEYuWg92hZ+Ib8AsXzOXpNkVGoeanyTbA1Rl2oDN3kaod260u?=
 =?us-ascii?Q?cBnq+kCoYPV6ZsdNt5wTXoJssvEu4qPbUq1aeWCvxiKr/6qxPncjLEWzOXnf?=
 =?us-ascii?Q?8uZdsQooFzYuVrIsoAKN6JZBTfVbbBYRvDSp9AtffIF4Xik4bIFxbVfjy2ms?=
 =?us-ascii?Q?AXKJmuaHGKk4GowtXBNxBc6x+x7xh6gn0r2rPfn59Oz8VwwiuALnFRJ8d27A?=
 =?us-ascii?Q?LZsrVQXJUorwaUc7/+exT+6LXe38hPAJBzfK1O1wrDERWnTYtyYCH8UD/LRC?=
 =?us-ascii?Q?9tPAI0NLRzKL6aJcCGT6hdBIJelRAjovFRMoKR7hklToHb3S0RfPbE41v/tw?=
 =?us-ascii?Q?5/+n2lsFTorXPpzZ7ohuHZN8I+xk1rHU4XcukWtP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af573b4d-dbf6-4d01-6ab5-08dd769831cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:23:40.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYgKEJ/Lmi3RAKlh3c4Qp+NNgZEG7LM61zwsyKvMH8pu8T/amWVlyT2E8DU0MhT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

On Tue, Apr 08, 2025 at 02:04:55PM +0300, Leon Romanovsky wrote:
> diff --git a/net/rds/ib.c b/net/rds/ib.c
> index 9826fe7f9d00..c62aa2ff4963 100644
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -153,14 +153,6 @@ static int rds_ib_add_one(struct ib_device *device)
>  	rds_ibdev->max_wrs = device->attrs.max_qp_wr;
>  	rds_ibdev->max_sge = min(device->attrs.max_send_sge, RDS_IB_MAX_SGE);
>  
> -	rds_ibdev->odp_capable =
> -		!!(device->attrs.kernel_cap_flags &
> -		   IBK_ON_DEMAND_PAGING) &&
> -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> -		   IB_ODP_SUPPORT_WRITE) &&
> -		!!(device->attrs.odp_caps.per_transport_caps.rc_odp_caps &
> -		   IB_ODP_SUPPORT_READ);

This patch seems to drop the check for WRITE and READ support on the
ODP.

Jason

