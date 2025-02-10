Return-Path: <linux-rdma+bounces-7643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8617A2F141
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 16:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FE5163780
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2025 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1112528E1;
	Mon, 10 Feb 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ir4vpCYb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4C1F8BAA;
	Mon, 10 Feb 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200675; cv=fail; b=FuhY6CunygS2PUaPln/L3fEPk56qcnAlfhqHJ2vNcPKArdTTVf02huEWFt/z9sl371i26/3W2GDleIEW5C1IdMWO+hUt4Lcdv4fxrfQvqrrsxPvZZmJMSZafNpj+j6YJcsY49Fz6xo51n01cl2LtdMyysBwm/IeSp761GwrcmDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200675; c=relaxed/simple;
	bh=26NoCE8meqVmsoXAFZrTlFkIxJg0EHca2CyL5IMOb70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MBSm/UwFS/heS11ICMc/L2CA1r3jh2ayQ3Ej2pmbYUgJGYcz3oolGpbXAyLSZBgYJl0zOTom94GQXa8QICqLfpqerK5hsbRmpYNybdnmXAy8BXwK0v3LQ8Y4IA1vac7W5ri24YpWsDoRFDVicMwRW8KCytdw7uxqpZus2zxAxZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ir4vpCYb; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egg91ea4/Zw3KbC8AWxvlHMxOlq4ITAkI1gQLKH1s+/23BBK7iS9Da6euPT7owXDiROVnXsvY1YDK765SyxR7kCBFkumX6/PlvoGyNqWfzv64a15eA4Jm3zRV8vTb9plrXUKx6okfFjd3Av4v3mWQ17WbQnUaSs1eLjnNJeygLSVizeokj3yZHJImj4wFuzLk2z1EaTz8FffPDDiDj+caElA87NOa+2wztxsWH3gHcjKroHwmXL9DFbvN7NL7zdVmTrkFYVGn9LHy5VSHJi2bSkAlXJBNmHTP46lUKNWoTDQNKa9xxzR1/dQcjxNkE534fcUm9NSmlonM2iH5fcSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvZIF4IXvtdxF5mvAZQgX9s1yn2mrpzxDATLMtOLwlw=;
 b=y5YeXojBzc6nub3wMMH4l7Qevp6dzCoAkM+QOliwdOFlB76CcDjkC9nT+G7/cV4UaSkrq1Pu2I1jftoYwNVB9p3AaHZacu3xnHVWhH45DZu8aMq0d8Oz89uipn1lbh4hKlIelUaPauNcvAP1GskNx3+CtjeqmpStXl83O35DjV1MifUtGuh93bKKA/Lk/vIr/9ehv7uz7zRr8/nXgiwHaPub8fpS5A4A1o8jL7bcp7N7ZCo0+SwFYqUhBoqT43+2KCVfeJmKLRHG1cjToAL3XwFW9wgd1p947xsaePlqgWWULNb02EPYkCsjp21xwlGHy+y34izSYjsO6hR415hC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvZIF4IXvtdxF5mvAZQgX9s1yn2mrpzxDATLMtOLwlw=;
 b=ir4vpCYbSqDTPx26QJ5QP6CwZGpFkJpWK69mviiTstDKZISgTaMT/qViOGa9mqhqn+k9MqU17gphTzii5pGmvzqxV8N3wRp3dmz9VazaLXTnjPsoGwaNo2RoUQpvFOJGpKcBCDBRwFYZkOV+VPCBjjkIeEl0qd4dOEq39Df+2Z82ud8GJNn045Rwgiy9bwb0z3/Q3CcqFMVt+HF2BoCaaWG+q/1NbaeiS5zB9t5+i41NYU4JnTeYi5iWnxNQ8yDkRSQUOAnmLcwiRmyfdALGJRs0Oni1L6dqsjje0rWPzWPYMK71lyk5VpuCuefAGBcSZw18zQRN3efn2OYJlY++5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Mon, 10 Feb
 2025 15:17:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 15:17:51 +0000
Date: Mon, 10 Feb 2025 11:17:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 06/10] fwctl: Add documentation
Message-ID: <20250210151749.GA3755183@nvidia.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <6-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250207144249.00000521@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207144249.00000521@huawei.com>
X-ClientProxiedBy: BL1PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:208:256::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 426672a0-8ee1-45d2-bccd-08dd49e6157a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6rQYV0lY+DgW5UoGEqST9eKAhrxpVShmDip4FmXqMnmHHMM1h30U5QNnYjQ?=
 =?us-ascii?Q?6nmdyvCQQncDlH9anfUSi37CsEZUshR2uB2z657hkOtoviCLJrtVfFANAHoH?=
 =?us-ascii?Q?cRGMq/nzzrBTUhj6L/dzxRkLP/D1vmxqpGZ8eP9OZcBncbY2dyLWymqavtWI?=
 =?us-ascii?Q?ZZvbP6VjSN/mIhAEsejrfcmtDTAT1Oi6XYHxW9Iksj34Gt+GJqHsMrSk62h3?=
 =?us-ascii?Q?Txs2Kn1Z8vHSw8i5GDeaM0mrm/KsCgxB8SHz1RzgGyYRc2iOSjud+pOGNKCo?=
 =?us-ascii?Q?E27FVc0/7mSjK6S/USiM4v+Zqsy1tU0/tVR8mC+qf8aTAHqDpKr9UN4qaOgM?=
 =?us-ascii?Q?psf0CwmulwLfRey65lBZ22sJiXVe7HEiHpm0kGLrj2rFB4u43VfxRKncx/Nq?=
 =?us-ascii?Q?r/Pf70og7ZEq/zkjoCMYiSfmaMLo7xeGgetGDgxgEgo3I3g9D68CUgjzWOwz?=
 =?us-ascii?Q?rg9nuz6RMfDiCQdH4gXPVfxj38fKIw9E7gAvaXb8s7UZBsah30wLjqf+xAI5?=
 =?us-ascii?Q?vPJyVvJ1RF4ZqSRe79D4xCDnQYSVOZYEu9Cj8OW5HU8q5kyvZro9BaPZiecD?=
 =?us-ascii?Q?9f2FUsIr68f7NyODrf4AOPXs38NjzCK98yQvHiKM9AsLP2fiXVx5xlwD9GBu?=
 =?us-ascii?Q?lubiAZIv7j2UqwVWkz7ZaLnqEFuHHrKIBelUUGunsr/KjTmjbUDBLosYwbVc?=
 =?us-ascii?Q?3ufEXxrmP+iVdFgtTkXBU+9EOcaoP0C3Fp0F+PgWUlhmyo+IaOzchLcjJyCv?=
 =?us-ascii?Q?Y2///LXeYSdCgkxzHZc3GWKLMczeoPZ2DGSMcQHc4Ms179PLc0DhYzJFSB0c?=
 =?us-ascii?Q?tzl6rj7gaNVo3h9FeNHG8/ELxWBLdSTBPPCAItJx/4/TEXmwlohx+XQxOj1b?=
 =?us-ascii?Q?sM/ROuQNO7V5ZeAMs07L4g857E7L4lOnKf1XKbpLzb9qKkue+19ggDSe1NqK?=
 =?us-ascii?Q?5uWWsoGsnmWLQXpqcPwsXMh3Xi1FobeWtJzCJ8TdUHw1YqJhjptuVtoWzjyj?=
 =?us-ascii?Q?cLm3wqNjYX6cM+vltYhNw3/hd66xPAiKAa+Oz2mvOiPKGRjbD+MRLWUoAU/s?=
 =?us-ascii?Q?9W+YYW3zsQqNY8pYjRBbBoMj5l7cyd2WvtwSiwFeGhJwSJFqvxbntlKW1FGr?=
 =?us-ascii?Q?hk9M1L6P90ZLBxM7OANGVHO7GECPRrFV4rMMwnGGYKVUbJa4nam7hnw7GBl8?=
 =?us-ascii?Q?+CUcYqfbDQ+Ycqn3buT672CTS7u1QJAI+n22LZCXUl93XOEON5R1QDOK04Ph?=
 =?us-ascii?Q?wekkfFBed5C9fvKXPURkgeNYgqGTV5S+0XwEnXOkSFBN5TIiOW2ck+HYx7hN?=
 =?us-ascii?Q?cSDpkS0mXklcg9xB7l2zwBMZ6Ee1RWtbDr7z0kmc/Y6L9cQ3u+hpQLvhals0?=
 =?us-ascii?Q?EvX+UWOAmtYqCcpoFPjgaKICXGzQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izrwnwFqOXuKFbtPA/IOMc+kS/FJAp8/x+d2Xi4hVcSTigu2ncOGnOCHeYpm?=
 =?us-ascii?Q?EdEOVHzLwbUmZFPzyThUuiBpBJOGiWO0n0mWrJfiXzJwl/+BCKL3KwZJpyrE?=
 =?us-ascii?Q?R9ZUJem/rT8B+rXMwQiIfnw4iZk/Dtoryo67a22UfQgC9X6uVXgkbpm+SU5O?=
 =?us-ascii?Q?DG/ktEFsVbPoRsP2BWnExSZV5l0OrkGdPIuJqgC7YiumHoHrcxUCyH5W3zdX?=
 =?us-ascii?Q?t0dkr8C0jKUe9eadNykZMd2HCj7+QA19raQJr5ft5bRYEIAdnfAv/p0+tY6Z?=
 =?us-ascii?Q?3OWTdtRgGEZ645yMXtyjzuPok6lS+KxR3BazAtnVeNe2xJLBZRoeihloq6RG?=
 =?us-ascii?Q?uUDlnzPLEIYAzJmOkTgUJD8Dw+1oGeswa1ef2FE1uQRVxjIsKH6RrbbS13bn?=
 =?us-ascii?Q?5dIGqhvqCkIsde4a5uChukPBBDXL2bQxpUM2EGjP4gAER+qRsNqHNTmhM6da?=
 =?us-ascii?Q?2VrxzoDk9IviM9/Okp+wy0sRUCx9oX1zgd+l1ajKZKG0Q1LPbPGj7hs+INzC?=
 =?us-ascii?Q?ywLtptcqTvKnXWdr1Sw24NnABq/i97hxV+ELfkMnklqGm9o6Bl3NM6SYCo2j?=
 =?us-ascii?Q?eBq/NPGiadTpb9/j6kfDNEHufWyMwwVKloFeRbbKf44crrLnlF5XmuZJStnW?=
 =?us-ascii?Q?NyBeYCqhPB/HGxnCYdO+0ENylCAozW1cQoHQ896frfZL72OHqGIooVsMokUz?=
 =?us-ascii?Q?smSShgRdUS/hwdwkc+XpvTCY7VZvi2AUZPtIG5yX+fhP59TX9+pHvmeb0TBv?=
 =?us-ascii?Q?n0uo6Ad6qpovXTMzP6y7bKcxcCI9amHCTEr++vS/XA8Ra7T6wihJC7a5DhJD?=
 =?us-ascii?Q?5FU2WyThheDK6I3vnl39vWUHXW0CMBY71rPiGkw174x/hmd3/Fbbdbpsg62i?=
 =?us-ascii?Q?HfTgHVe1bPYJ/i4FaVZR1vIxtp+8ghKJaTsBHdQRMA50eF+3BNrC26Qvo63Z?=
 =?us-ascii?Q?1wjW3tiVLnQdVuCNLKnywNwyVERncasdlolk86Pe4gGphdZplw9XGEkZWWLu?=
 =?us-ascii?Q?aaiCVF8hjmenj4sV5acNPmkhGkOqVXNTYYPlJzAS3utiFdx5DE+QVskhaH4B?=
 =?us-ascii?Q?P47C+Wm9GEmKBzSGwAeFXH2RnZH4CrGHxZr1XdnDtSVDJTE670ALGGtj0MMY?=
 =?us-ascii?Q?lfuvrwte0pqZgA+m5NGO/xXwQNYD9re+eDenH0oZz84pAAVFPIwA1/pakZje?=
 =?us-ascii?Q?e8vpC8o06DRNt9pTAe2xJaZErcSraRyA226hZDLoL7b1OzV1fk0RXIeEdIRR?=
 =?us-ascii?Q?jMy6lFO7l2U4W9vRVGia8RFvjccYm5MdrgtDMIWiAuqYX6vgoR94DZuL1tfI?=
 =?us-ascii?Q?Tx64qtWwcilhYvgXA4ZM7GtuFJB7GPUGzn0ZFpwp1ydNgzlUm/msaOFj9wAY?=
 =?us-ascii?Q?uPUyoCBbPxNplqkwhI5TY9kzNvfV7dimReyMd8EwyAlUqWllntjmCA1ahcUG?=
 =?us-ascii?Q?mpbiqtIFqEKgBeagHPFwoWT/mMzLMSl265vKNwaBl1OTTAJXnirs53jAsB4j?=
 =?us-ascii?Q?Huw6iN6OItJJCjIskgbrv2AMQuno1bdxDIAEURZ621nf0g4zXhryuIS1LQz5?=
 =?us-ascii?Q?J5WwAUOyqvqfdettWQU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426672a0-8ee1-45d2-bccd-08dd49e6157a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 15:17:51.0704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unC43Fb7XtRNr1lePKoR4AzKlKgQBPbwScWnovF7dq8iNLVH9VSbkBqhsJKPlmVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

On Fri, Feb 07, 2025 at 02:42:49PM +0000, Jonathan Cameron wrote:
> On Thu,  6 Feb 2025 20:13:28 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > Document the purpose and rules for the fwctl subsystem.
> > 
> > Link in kdocs to the doc tree.
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > https://lore.kernel.org/r/ZrHY2Bds7oF7KRGz@phenom.ffwll.local
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> A few tiny things inline.

Got them all, thanks

Jason

