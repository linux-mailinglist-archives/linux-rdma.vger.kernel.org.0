Return-Path: <linux-rdma+bounces-8871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B3A6A92C
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B3C168391
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF471E0E13;
	Thu, 20 Mar 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VX6v0puu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B6175D53;
	Thu, 20 Mar 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482628; cv=fail; b=KvfGQV9O+uLOISdmb8w8oWOjoEW4eAozO5UHkGwOZ1ChFc3pYi3dwS1tO5gEbLxLRQarOEg0FFavlq3cel5OIgD7nqCKX2A4O99ZqdpE6dz/GZ19ZqecJgV7PP0GDvqdMSWrMUV6z6wa0KkbIpoJ98qvdWVyNzO4f8QG02ti6uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482628; c=relaxed/simple;
	bh=TcLdCtOT7P7NyeQLEI9r0Kle0lx7nybSfEak1UauLUs=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=djXRe30LbaNvKyCyw9Sx6xYabjXMwJKsQv3Z1R9it8rdTuBs3ptk4klt5dvrCvfTgEG0dK09OLpqsJMeiaGg1wQYEu4zCaMzDbNYXhPbjnwbFx40SnoGY8z8bTE9i9kgsroR25FAX0OrVxxQb+MJk3F/GnYJ4qF2tWi0uzcmlEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VX6v0puu; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzRcDXOPo4b/t2pih683gbQ4uR4ix48efNHKmIvkRS6q4nUEqQLLxl0kKCCW12MkD2T+DgpC0f2JgQYXbziJSzVoslqoP4nCUCAvEgx1Jwg5g6Ieo8MFa6xNsKTN0zImVckIYR1uusqUEF/1v05v3GBxnttDWAudpnweTt7/lQTHgok/GbwRfrJtLwK7UyqDdwANDkKzuPmBbct9c6Myh6+SrpAKn9CrV1gB3YvRkEz8JpcbKnZhab801ScmRvyNAbC28cq6aUyVDYmIyfGc0AjF6LYPqBCQPiabbuvoSjtiOAYSnerZt6wHLkiCvQUDkyj5jZOC0rpAwHO4yvu1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w5rHezqQSxoR4dq/zteA3C3R+sqLkLb32FQy6+zs/Q=;
 b=gntBkoi/G6A9dT2yM+QQQ0iNikUm1iCZlHCQZp/LHesBioG+vZbGpDJVeKAsfr+hejhxnAHp9MSDQs5tdhlui3rEfx/M5LqGdI/Gsf2gPtvEirsbeS635Hi9w4034GWYAwFulL4AVI1Eiqv3hQcEJUO00cw02bdmylAJuGNAC80BS6aw/I4/shyDu5lH+kxY5EQpFCGQJmikT5wd+hVU3grUSksDs4fBNcrEKZd4XBAMt43hMLbPL6zuws8pWTYmg7XMPMklOuzxoKj3eST4h0oTIS087NmEuoI0ANA90IP7ejfn2eYxo+7uASEFbA9nm/7aJYEUVmWrqFXXWLKHhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w5rHezqQSxoR4dq/zteA3C3R+sqLkLb32FQy6+zs/Q=;
 b=VX6v0puun3semv4BNNkgEkFR3wZUBBm/iShYRHZTrWx6KTDL7I57qu3kHNesPKDsduoAMkrI+sXFmUOIeqRjshM+cpXWYQhodoLktltuyi9pR+Cr3YSwLf3YfEMtF9tLKY+eUBcjFgR7a5Vq/s6tTlzs7XPZ+Uqk4uXhbfYZ+6ATCrzUpmRG8SyqjYnTW50arloDKbtNI2zADZUTPlRoBeR0P1lp0Q/AfIHxCVtDbcHXNEPPPUNPHTNUr63lO2xpEXQdY+Okht3DFsWDqpkgg5UDTVIujNgPF8lx5vH2r77ISJflVGyYVhBrxrRnk0l9drXn5xgLwtPufHqr9Wlr6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:57:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:57:03 +0000
Date: Thu, 20 Mar 2025 11:57:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250320145702.GA204190@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uH4oyP5wEG8hMYLK"
Content-Disposition: inline
X-ClientProxiedBy: MN0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: efad80eb-af31-4ee8-e02f-08dd67bf79d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGH99WGVQpJNUSMcIVLJh/uhhl6EgJg3w8bVBLpGHKCq5qaeI7FX/PkGxupP?=
 =?us-ascii?Q?2TRcHbvpOzJvqAYc1KgJDAY40+wY+AKHYtD7hFG68cpxzStgmW3x6C/60jLl?=
 =?us-ascii?Q?s0oC8XFspQ5smWBRY3CrnQ7Di4McPXLSVDtXqgulV9rz71eQd8O1XPXHHiPm?=
 =?us-ascii?Q?Rlh+WULifkBRf0pUHl44/hrMBHMFTYEBB2YZrHjwSl5rueTe53PpbhBMGMRN?=
 =?us-ascii?Q?eGjjBlowM7WcgfZXAkP2FBflnmNtbl4PBaWAOY8UtL+gDSQ3APkTsKQdchdJ?=
 =?us-ascii?Q?t7Nq5aotEiUW+CEmrzG2EJ2d6LM746KgnSOEUZxtVtSbsZQVrp8pEIRlPPv6?=
 =?us-ascii?Q?N6tcJ1phCuYqaItkAqmUOYYNz8xmD5EgI3RI5aeA5QmMttprnmYDXydqgWOo?=
 =?us-ascii?Q?CgHCuXCl2mAttIDAUFqrY0VpJJYkBiKKjXxdZLUHw66FU6jSuTXAfYNDYXm0?=
 =?us-ascii?Q?Iue30AacvDpBDmMVQPLfQ9BxjtKbgRwnSiFiDfjmbhv9o9U3fn8XcvaJaAjh?=
 =?us-ascii?Q?b9ZRWU+5s0dwzbWDBUaXNFsyOlez1MsxR+vo0+4f7f3VCMLJJgQyb5it2dSs?=
 =?us-ascii?Q?jRims/9U2WxyV5AhUoz3KPxny3cJ24YqsJNj7iAB/Cpl6QPMqBuHyBDTSU/O?=
 =?us-ascii?Q?64mtv3JqioisaOlNG3KVurs1B7la2cYOPRDiBy3cwlKr/QddBrxISMJvhWF7?=
 =?us-ascii?Q?pGoTRlL1q24Z62gEbFcoy5q8f0W2gEBDYsNPuIqU3fxBssf2xeglxe7Wo7Kt?=
 =?us-ascii?Q?N1EE1QxbHi8gaqy/8NUU4ArMoWkhUWg30+li+zbd+h5CNBzYKrIqYdKVFrw0?=
 =?us-ascii?Q?2nRxCzYfQmez5vWWprW34ThjFgocueK+RT8/XQeDfu6oj/SKIJ3VwfVfBc9Q?=
 =?us-ascii?Q?l2TC/KCrtTV8vCeh5oawa6CG+ArU5nxMK/xASJcOVoxAtZYLw1S4ZFe2CSb4?=
 =?us-ascii?Q?SIxzXX4goZsCsuOplVYi8bNbxbWN+wUKt/++zgK6vFjyODMPdzt6Wpg7ciDM?=
 =?us-ascii?Q?3ytXHpvyXWptJ+EIZ3z39kZDbzmw4ID7Cle62r4svrbT9kROT/L8TMyM/HDT?=
 =?us-ascii?Q?YlT02p/seLJp6ECru6E4iu29NhJG+LfpX6rYVGNrdo86MzWQx45x28XmqKYS?=
 =?us-ascii?Q?Aohdha2IDOLAmWG2tAi+O0Ece5PksCb0X6VJM17G3DaBrzXMvOYn/omezKIn?=
 =?us-ascii?Q?DGPtyhwuy46yslQKD8lVWjj+9psHXFb3azee9onIdlctLQhXQIzz2nohmi0I?=
 =?us-ascii?Q?O7prSZa258JwoXezK//9KsdjhEpEB/ZdJ0/iW4lXt7vTeiMHjol4pQVuKBdH?=
 =?us-ascii?Q?hXYjZYwzcQVOTVxvie1L+7HyGX7do9nRpo64hZDhAf/0jMORVjyJj3XgkD0e?=
 =?us-ascii?Q?+iP/aSX4drtmC4A4l2pGkXyNQlmg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mP4bkOzdZv294rO2K1gDYb84QDHLJCNpoR6CKgedRy2nepUoG/mbppQHcTXh?=
 =?us-ascii?Q?YiY6biKol0rRd46JIlcKQk/SGHvXahYFTS2j9oKNZ9xBNtyeFxRU5GF9uTXk?=
 =?us-ascii?Q?D0kY8qiC2VANSFcHLWrEzSdxlbdPQKSEOipYeHraWXifTKDo76aKypPUHJP8?=
 =?us-ascii?Q?zZVw2+0Gsivqsol8MWw/ToExlOuxM9JR3q2DMXjL1YMPv2VnsKR7GrWjdnAk?=
 =?us-ascii?Q?4EW1NVAzZXnZoo4uhASr4QtiWqao2PInbp/+myZWqnULNXvypF9E/3XWKGWF?=
 =?us-ascii?Q?vEQf0FoQic30s/09VWovtr8SX8syDY+KBn0s8/OdkJZHcLRDDsAQCNoc+amw?=
 =?us-ascii?Q?xEPupT+p1pYi1M55mFP1hRXghnYnNdeL89k97BaMNTj7penwNtcwmcmePLGd?=
 =?us-ascii?Q?i16CoA6rlaapysvJqo8GI6pRVL63IG5LAwJ8zoRu8eMK3ekpQ9GK+C869nYy?=
 =?us-ascii?Q?7gCEfe4s8lnjTnWGD8SyiLZ5+Vfv0vwJ4rpnklD9laiW6AlPeQPultKItfch?=
 =?us-ascii?Q?/+ctQMy7Xgg5pVwIUlw8r5MsrpcTPhHMtQ3D/lQ+wiNw3ykI3Lr2b6XHix2z?=
 =?us-ascii?Q?YX3dSlvHOIs8Bdy/He/L0IYnOvCVaCRaX6yNJOjdwPskgrMWZ+p16jgdKUk7?=
 =?us-ascii?Q?mQJpPXdQXB5QE+dib96A37O+J/ITMpZh3AeIMzxBNQYL04RZJx1crgoRemo/?=
 =?us-ascii?Q?yIkds5WdnDAyLQgfMKBeD+QBn+nJog+Kmhgt9SKnkf82fBS8Ys596bpB2gjK?=
 =?us-ascii?Q?E518l/qQJ6UJFs8KcK/Ms3lSInPmsqX8wD1khmrh0oilZD2bFxVYvzD2szlz?=
 =?us-ascii?Q?0m3pJvYoCkvY6EV5Hmo8e8daFccmB6Aj9BPHwlnxt+dko3HHQw3VnwfM/7Lk?=
 =?us-ascii?Q?+HprM8ssExgRrE6OEbKgCy2gnv/iwKkw/G8Rw1GB0F7pSIVWNzSMfDw5QX1c?=
 =?us-ascii?Q?DiSeJORLe6bxzUrh28cDjaoriFrmLUp9pHV/vhe5ALi7tVNo7D9AkvPegK7x?=
 =?us-ascii?Q?MobcO3OsE8bPepY0SdfUBqXVWNimzbUNUgGaw4gKM+YQKz7nP12J96gcchq/?=
 =?us-ascii?Q?ouDZruVSa2URKgnTn68dyQAakf8Z44MoyUa2Ftjbvm9LwuTz1x0DX/VlE+3n?=
 =?us-ascii?Q?kU5kF62DJ9nnUlgw6FSygCPzArbwb4t6Bz0MZHfhNlhiqop5tAyp/oKt7LTs?=
 =?us-ascii?Q?Rb4yockdzV1bXsxUmXQQ1LXtdnQm+F3BOwSaYUqHck3gPOwba8FiESGxfjm2?=
 =?us-ascii?Q?ZmYybAw0YqhqO0EMvAGfT2tsq9H7R7qRq4SO7awkcKDiYnVdNWTGygGGFieK?=
 =?us-ascii?Q?cm1c62nYCqUEJFG4vprlys1yuWTTR8rF+GuiIh2OIed6l/yKub+E5XaGdsrJ?=
 =?us-ascii?Q?wNAxL3MEX1eZ+BRAHavfhsCgcdqYgrCjpkbDGnYghi0kBNT/HeaimxREzJ/w?=
 =?us-ascii?Q?nfZSR3woVfRFbcWEnECAWTfpq3XFvWYazRWqrLd9Pzdi1DMO4hK8Z/B+rfgD?=
 =?us-ascii?Q?mB/Ai+W9tWt77yLJ00ziVwL++phV+3jKBdmWsjQF45JQ4n0q9liC+EgAdP2b?=
 =?us-ascii?Q?whGQ7rWWBN0B4balpP8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efad80eb-af31-4ee8-e02f-08dd67bf79d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:57:03.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRVwVSAa4yrNHIooHo1mMb9wbY6NWwZN/z5qn0ygoRoyt1OLd4Cntm6HayY1Vdrt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

--uH4oyP5wEG8hMYLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I don't usually send RC PRs so late, but due to some travel it is what
is.

Collected driver fixes from the last few weeks, I was surprised how
significant many of them seemed to be.

Thanks,
Jason

The following changes since commit b66535356a4834a234f99e16a97eb51f2c6c5a7d:

  RDMA/bnxt_re: Fix the page details for the srq created by kernel consumers (2025-02-23 06:57:56 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 6b5e41a8b51fce520bb09bd651a29ef495e990de:

  RDMA/hns: Fix wrong value of max_sge_rd (2025-03-12 14:35:50 -0400)

----------------------------------------------------------------
RDMA v6.14 second rc pull request

- Fix rdma-core test failures due to wrong startup ordering in rxe

- Don't crash in bnxt_re if the FW supports more than 64k QPs

- Fix wrong QP table indexing math in bnxt_re

- Calculate the max SRQs for userspace properly in bnxt_re

- Don't try to do math on errno for mlx5's rate calculation

- Properly allow userspace to control the VLAN in the QP state during
  INIT->RTR for bnxt_re

- 6 bug fixes for HNS:
  * Soft lockup when processing huge MRs, add a cond_resched()
  * Fix missed error unwind for doorbell allocation
  * Prevent bad send queue parameters from userspace
  * Wrong error unwind in qp creation
  * Missed xa_destroy during driver shutdown
  * Fix reporting to userspace of max_sge_rd, hns doesn't have a
    read/write difference.

----------------------------------------------------------------
Junxian Huang (6):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      RDMA/hns: Fix invalid sq params not being blocked
      RDMA/hns: Fix a missing rollback in error path of hns_roce_create_qp_common()
      RDMA/hns: Fix missing xa_destroy()
      RDMA/hns: Fix wrong value of max_sge_rd

Kashyap Desai (2):
      RDMA/bnxt_re: Fix allocation of QP table
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Preethi G (1):
      RDMA/bnxt_re: Fix reporting maximum SRQs on P7 chips

Qasim Ijaz (1):
      RDMA/mlx5: Handle errors returned from mlx5r_ib_rate()

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

Zhu Yanjun (1):
      RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  6 ------
 drivers/infiniband/hw/bnxt_re/main.c       |  3 +--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  2 --
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 +---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  9 +++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 12 ++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  3 +++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 ++-
 drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  1 +
 drivers/infiniband/hw/hns/hns_roce_hem.c   | 16 +++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c  |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 20 +++++++++++---------
 drivers/infiniband/hw/mlx5/ah.c            | 14 +++++++++-----
 drivers/infiniband/sw/rxe/rxe.c            | 25 ++++++-------------------
 16 files changed, 77 insertions(+), 59 deletions(-)

--uH4oyP5wEG8hMYLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZ9wsuwAKCRCFwuHvBreF
YWc7AP9IUB3UQpWYVrZ63Kvm9gpDd0/0oek1PivXr0QqFSWUwQEA+QnnO4f/fNW8
Rm+C1jOj5RCrPlMfjxPnp5gjgofDqQA=
=uok+
-----END PGP SIGNATURE-----

--uH4oyP5wEG8hMYLK--

