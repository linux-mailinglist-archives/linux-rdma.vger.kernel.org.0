Return-Path: <linux-rdma+bounces-3905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8607935225
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 21:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC261F22678
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094791459FA;
	Thu, 18 Jul 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxjRmpRg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275F12F375;
	Thu, 18 Jul 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331118; cv=fail; b=oP909kWb4pYzMKqPC1LHt7DlDLcn8aaoVRSNGvWG8emP5n3xHgKlFMy/AgHrLecNJ4+9xkaxfrnsDOvLHz+SSZpxL+1/hXD7tPct9hHpPydcEY7mKvaPrRFZmJw6hb3uOP2knHeccuNYy8y1zyC0TGAIB1aIga2y3dzmQ09EJho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331118; c=relaxed/simple;
	bh=MlUmU6WakrYfijO1AUiUAbekWdMOLQMgfQgt/ktizoE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b4qX/7aYbJp6ivJZx9E3kRp3QBf1jReS4WBGJaZAPDCRsEeBYevEPoNJoiXsDWtBK4e9M3bN3v4BUeeea6klyiXNHCEKiQw9RVPQSHkU181Yg4SNP25tnMglWZG95MZijXITWLeR90pJJwCCETun6+8QoXWtSnPi9jtEKXBmmOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxjRmpRg; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfScXS34GS5Avh0T8ufoyNscNToQCyJIFSO67oFlMInTTH/5YIiiwJbGwSYhMgkRdqQ6yl4Nk7Z7mQonMpWrTvrinK4T0nBVAIY6A/paB+liDkAogsEK367UE35P0Zou6HUT/WS6+1gqmfLvl7w5FCMm0fFp9yJxNV1GDgfw/yS65n5NTVEc3imtQNWuqP5TqPMvPnp387/GagUcrw5TgOOLff1OQSwqCrf+EqWLA2VZ0XAZOhME7q4p272qo+sdCR1KHkZKno1zm18zIhCn2b4q0dd6VW8nb+3+hbat3/Jnmbyp7cjcgpQFNYdDyRQELhYeg8QIaNUzsiP/CbuH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80MhVICz7l0KRYHPCOnLsBK39RPZ6F+On3MwMQguoHU=;
 b=bZ2+RHMfQSAfcg+w9cf0HtgrePsCNVAdS+duv9SBC/nWXzON6YsPzHvaQTStRBaNbjre8RaBZjZmSJDsLV8d3v6IPz4l2ZO+PJMBCR9KR++kkP9UlJH07buTeNdr6jYhPzYqEH9imJm1pBsV2TAnGgnyLZM6ci5C+4ZnFEA1QsiyOcJD3pe0KE30Kfg/T+7lL1VI3TQAwxR84XGzj076u0AvskiiSs+q+cXgNOptP7kWgKFOcAv3BfKrgZmx8wG2hxiJNGxjrTzbgwv/a1G93WRdPrkhq5Gf33qrOn1YJyDF0/tET0UKTDhnwowJgTjzNsEOtwN9pyC2rVscPLnjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80MhVICz7l0KRYHPCOnLsBK39RPZ6F+On3MwMQguoHU=;
 b=rxjRmpRgliryI+Q7nQZkCSRFrAEONsi+UWqduk9cMhtgcpqRpAvVipsSs24NKPOmO7vjUPZi0ebM6mU0jhbcG7rZryTKsDM8ngz7lcZtb1YvHytavjGecjr4qkoguIIfCxEwDW2Fauuo5dCx7czE/sGWQSFns2Lgd6FSOBl6ezrviWmnaMPaCU7y7AEQ50Xx3aK4JlGcQEy5h4Y1vo0cXX7Hc6BvdS+J53UfW0YfprNPF4VO1VNnzslV5sm15/j5EtsP7NzjVq74oIuaO8OEGULr6LqyuhjasW9F8Rl1EPXOgUdHBBYE3vyaeCiOX9lM5Bdlz2cBs7yN7GL/5DODXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 19:31:52 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 19:31:51 +0000
Date: Thu, 18 Jul 2024 16:31:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20240718193149.GA1670333@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g4C1gQ2ooTM8qF6w"
Content-Disposition: inline
X-ClientProxiedBy: BN0PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:408:ea::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: a00b6bb8-b517-4b0a-480c-08dca76045d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4pUx6ZRnVgPzCF8JvplCdz5pRND4ztacXTBbgYXb4BIEFQFqcAsD134WKTnP?=
 =?us-ascii?Q?35dVFkeb2FxyH0UgUkufbU5EPPdQXK69GDq68dxlg1x5MsFb1jCkKSNiT9Xn?=
 =?us-ascii?Q?iwl0GWu2WDewvcHBNBs1yuP5LH6k7vUZDom+JrBUBNQ8F6pDBKaa9qI/a3zo?=
 =?us-ascii?Q?HHrvyxKyifs1loJS12NZ9j6dgJDZ15zA0zxLozuKHQKpXqXrIo1goocCgwU7?=
 =?us-ascii?Q?FmJJdE1LCvlbmlUithE1TbPWaiHgE6k0tVNbsOI3qrnZ9yiKsnnJoLnKd3SE?=
 =?us-ascii?Q?+s470eCDYRmITYustz/uIohoSDQ5gzQrsjcPOj4YzKnNwi1Yev+MX0vg5WbI?=
 =?us-ascii?Q?JOBCexDxN4dcKgQwlGe2flqKsijAk1Dypgg5qJqAs7pRXfQ8xkAXJjWUf7Cn?=
 =?us-ascii?Q?6Unf9zw4cBG2pzR6zM6m/fXdes8nkSWmWrx13DZzZaanZnZPTgG5D7bfHZjZ?=
 =?us-ascii?Q?ygECZBbIevachGsWvqXtck7CG/5sTX2JXmwZL+uPJgxrihH6uOJrrmFWOtvY?=
 =?us-ascii?Q?SHA8BXobfofdrcBRWbl1R1NO4uZgmRCzpxtFgzIlEk4MOS/Ji3qtgWZ7nVmA?=
 =?us-ascii?Q?ZWi/UP2Xs8BD3bgsx/tUbP+m026ET27xkgzgaGjNFASGXaVpgKiVxfwBpCxP?=
 =?us-ascii?Q?DBVV7WDtJ+C3SgRIQ3ipKeqd2Nzb9lDKUV7gyrIVexkhyeIw5qh8ZzZRls9h?=
 =?us-ascii?Q?bsLcfjSTcHuL7Dkp/pLB7EKROyhW+az9zhMxYhkwaEtzXbn3WPdKCIPvHN6K?=
 =?us-ascii?Q?TDas6soV1Jns8dlM29TY6UwXwunCTFdpE64Xpgyft5Z5Ep4VO1FHKc3btYpG?=
 =?us-ascii?Q?pFVu7Lc44O/GHaTLra3PWo9Jmj84fkMj+qd8Clxm0VhQA69uCHtTwcFgVjwU?=
 =?us-ascii?Q?tOXQ6IZzUT4NtjaosIkVMXEOngq/Wht8LkLSjdX5yTPQcoIOhEisGhJDJhap?=
 =?us-ascii?Q?wbNSqeTW0CXyK1pteO/2WahEm504qaO8dCkU2rY0CLzPh/rM7GTAF/zHyjCd?=
 =?us-ascii?Q?RaOHf865V6SU1CNFJZUcakhK7Z6q1I7kkxm77jLfUo9ha+ffYKQRGKX7NSOb?=
 =?us-ascii?Q?+6L7PZBAsZmjkF05n7rImL16LXbIsiEIdaBuia4hPXA0WalwXsFXe6XlH9ew?=
 =?us-ascii?Q?ZWkvHT5fv9ZRrOOB8mKphf0bj93HnxIYOThxLLUxxKR/Cec5oI4vze5xSMgR?=
 =?us-ascii?Q?Me77aMvUMNyHl7vEgy7S5Qzop1CUizG+jgcPNja+bjIa100b9f/oBN5C9b0Z?=
 =?us-ascii?Q?Q2XB0YWfQxaK29VYwa8eyTq1Y6pq60xkBAyI917yTlSpyq2TIpfMtl6bTlKy?=
 =?us-ascii?Q?qCXiptp2LQo1bwqHqubsuCWbRrBtL98UFk6E17n6LuVPkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbuHAas4mo24vcDuoVH7TUhv8eNvd4AIP/QfJ0rjBWY7YeZVzm/yk7Fmucp7?=
 =?us-ascii?Q?p1SQBLA1059PXpUNDb0hs8nMFKjer++KHjQBboc8CkUgmc+cnwpEo5ORVmdQ?=
 =?us-ascii?Q?UdoMZ9NleTDFhN+JUFb5iwnnB2Zt4MKcH+YxITgwYysWqRY1mq62y1wphStY?=
 =?us-ascii?Q?i/UlzIofooNpKG5avHBWOjAOpQityuCCb+RL2HGQMATi2vAgu2eRcfuG8MG7?=
 =?us-ascii?Q?KNrrryvpaY1LsU0vhee3FEFlJP+AAa+Lq+MG/0SRRZXFzjec5Vn5V6EG0VOM?=
 =?us-ascii?Q?fC+rZne+NnNlbJ1WlNbXBB86HN0GiBuhOzMWj5oem0Yd4Jt0l6NPh5is/pt8?=
 =?us-ascii?Q?y/EHncIHqb5bY0JMnNlswjulS4ItD9qM4WYMk81Y6XvoRNaFGwIS0pg0gBEk?=
 =?us-ascii?Q?ItL3n4eD8OJy197AKWiWPM1fyBLd5CrNhulM++ngW9yAv2AE16LFryml451J?=
 =?us-ascii?Q?5vOwb/oSwzxBz936ePZtPRRWNyPjBNO4RrAn0cwlXoI+3DiDKTk2DAceTTnZ?=
 =?us-ascii?Q?yiASqSY6bHhVdjslAYIHXa9A0kSCidg9Von+Q/IbwC1EKbdsvHFMWwUsa5D8?=
 =?us-ascii?Q?izXYpskAnqLhyem1guu5XNplMJi/ceDgJpF0suWmmFmxoYe9sv7TJQt4IaVm?=
 =?us-ascii?Q?W2aKw/tayb7+Xg5toSdhOdD3AvcZGh3S7z/874T7549SwY09BR6FXH/G8ET5?=
 =?us-ascii?Q?YJD7X8Klp4/SF5earvJQ4Y0IgTROVigOJWt4/X5xO+zWU1LPIJUWD6rWRRLP?=
 =?us-ascii?Q?v1tyisEueQPzqE8ITdinhuwz+Sh3kpcYL2jxOXeQiVt+u7KcNThvpIpDP9lq?=
 =?us-ascii?Q?JiT1X0ehsvr8PDOneazB3kGZzFzyjGZh91230lYEhW7u7Wxuajwcz7TUq8EW?=
 =?us-ascii?Q?xpLQdk2nBvlPldPtSB3S9T2vgAHDsmqKmVArgoJzb4igIF0fhO2q/hgxODbV?=
 =?us-ascii?Q?Lyo/dUKPPhmUsgxAAZ6Mu5Y9gp9yiNADGhTAjZnpKX7fBvKpnQqyt6F9cMuF?=
 =?us-ascii?Q?xEGgN+3b8lYzfCf8hWDa3XmOJJ3dMOSAYpfi7Z16EbHj1cuxmGAvDKHZjFQp?=
 =?us-ascii?Q?cvmIymQuYrvPOR+7ushFh3ZYAjRqrFGf289WSeSyMh69GJRoR+3soSipskTj?=
 =?us-ascii?Q?1lHjZQBuAtyzpERN479Wy+FcY/gdjFAy4gTIK4Iy66OoNPGfg53KV/+JauUq?=
 =?us-ascii?Q?bZRqYVMOj2IiwqZL7uspl+jlTK/5D1O4AXMMOMeTYNsgqqjCScjuF98vwj2K?=
 =?us-ascii?Q?p3H712f06G5TBKdWpRKOcI8akz/7ia2nznS6dxHdZF9pNLJ3aLjz9+UA4saY?=
 =?us-ascii?Q?DUxe6EdjpxqE2IJr2u7v3ldb7S7KILNWr7hizHnPL/SV67ZBG1m6SG0skmih?=
 =?us-ascii?Q?CZ70VKp9NJe2SV4bCxlV2edTnW9BA7XeRuLOG/IaPKZDcxQ98IK/FadNY8MZ?=
 =?us-ascii?Q?B6wNMaR5TDLPCvDs9gOL8FBDeBAET80p640UxovCc6iCh3krf1Wq94gXdxSs?=
 =?us-ascii?Q?dcr0fHbFbP8UhCxHXeS/Me0Acg7mC/8CkAZyscbcQ5WdrIlxaMjsTY3R6Voe?=
 =?us-ascii?Q?BMmKXdAbYHc62uFNF+0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b6bb8-b517-4b0a-480c-08dca76045d3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 19:31:51.3464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dQ3Dr8/FsYueWXh8UY2VvzpmiGYQPqiZqZFLJBzMEbQicqBCs+44bSHAcD8ovGn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

--g4C1gQ2ooTM8qF6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Normal small scattering of changes for the merge window.

Thanks,
Jason

The following changes since commit b339e0a39dc37726712b9f0485d78fe4306d1667:

  RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded (2024-06-16 18:53:23 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 887cd308fd46a1c6956e9ccda1aaca830edc8ed7:

  IB/hfi1: Constify struct flag_table (2024-07-15 10:24:21 -0300)

----------------------------------------------------------------
RDMA v6.11 merge window

Usual collection of small improvements and fixes:

- Bug fixes and minor improvments in efa, irdma, mlx4, mlx5, rxe, hf1,
  qib, ocrdma

- bnxt_re support for MSN, which is a new retransmit logic

- Initial mana support for RC qps

- Use after free bug and cleanups in iwcm

- Reduce resource usage in mlx5 when RDMA verbs features are not used

- New verb to drain shared recieve queues, similar to normal recieve
  queues. This is necessary to allow ULPs a clean shutdown. Used in the
  iscsi rdma target

- mlx5 support for more than 16 bits of doorbell indexes

- Doorbell moderation support for bnxt_re

- IB multi-plane support for mlx5

- New EFA adaptor PCI IDs

- RDMA_NAME_ASSIGN_TYPE_USER to hint to userspace that it shouldn't rename
  the device

- A collection of hns bugs

- Fix long standing bug in bnxt_re with incorrect endian handling of
  immediate data

----------------------------------------------------------------
Akiva Goldberger (2):
      RDMA: Pass entire uverbs attr bundle to create cq function
      RDMA/mlx5: Send UAR page index as ioctl attribute

Bart Van Assche (5):
      RDMA/iwcm: Use list_first_entry() where appropriate
      RDMA/iwcm: Change the return type of iwcm_deref_id()
      RDMA/iwcm: Simplify cm_event_handler()
      RDMA/iwcm: Simplify cm_work_handler()
      RDMA/iwcm: Fix a use-after-free related to destroying CM IDs

Chengchang Tang (5):
      RDMA/hns: Fix missing pagesize and alignment check in FRMR
      RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
      RDMA/hns: Fix undifined behavior caused by invalid max_sge
      RDMA/hns: Fix insufficient extend DB for VFs.
      RDMA/hns: Fix mbx timing out before CMD execution is completed

Chiara Meiohas (1):
      RDMA/mlx5: Set mkeys for dmabuf at PAGE_SIZE

Christophe JAILLET (3):
      RDMA/irdma: Annotate flexible array with __counted_by() in struct irdma_qvlist_info
      RDMA/hfi1: Constify struct mmu_rb_ops
      IB/hfi1: Constify struct flag_table

David Ahern (1):
      RDMA: Fix netdev tracker in ib_device_set_netdev

Gal Pressman (1):
      RDMA/efa: Use offset_in_page() function

Honggang LI (1):
      RDMA/rxe: Don't set BTH_ACK_MASK for UC or UD QPs

Jack Wang (1):
      bnxt_re: Fix imm_data endianness

Jianbo Liu (2):
      IB/mlx5: Create UMR QP just before first reg_mr occurs
      IB/mlx5: Allocate resources just before first QP/SRQ is created

Junxian Huang (3):
      RDMA/hns: Check atomic wr length
      RDMA/hns: Fix soft lockup under heavy CEQE load
      RDMA/hns: Fix unmatch exception handling when init eq table fails

Konstantin Taranov (7):
      RDMA/mana_ib: Create and destroy RC QP
      RDMA/mana_ib: Implement uapi to create and destroy RC QP
      RDMA/mana_ib: Modify QP state
      RDMA/mana_ib: set node_guid
      RDMA/mana_ib: extend query device
      RDMA/mana_ib: Process QP error events in mana_ib
      RDMA/mana_ib: Set correct device into ib

Leon Romanovsky (9):
      Merge branch 'mana-shared' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
      Delay mlx5_ib internal resources allocations
      Merge branch 'mlx5-next' into wip/leon-for-next
      RDMA/cache: Release GID table even if leak is detected
      RDMA/mlx4: Fix truncated output warning in mad.c
      RDMA/mlx4: Fix truncated output warning in alias_GUID.c
      RDMA/device: Return error earlier if port in not valid
      RDMA/qib: Fix truncation compilation warnings in qib_init.c
      RDMA/qib: Fix truncation compilation warnings in qib_verbs.c

Mark Zhang (13):
      RDMA/core: Create "issm*" device nodes only when SMI is supported
      net/mlx5: mlx5_ifc update for multi-plane support
      RDMA/mlx5: Add support to multi-plane device and port
      RDMA/core: Support IB sub device with type "SMI"
      RDMA: Set type of rdma_ah to IB for a SMI sub device
      RDMA/core: Create GSI QP only when CM is supported
      RDMA/mlx5: Support plane device and driver APIs to add and delete it
      RDMA/nldev: Add support to add/delete a sub IB device through netlink
      RDMA/nldev: Add support to dump device type and parent device if exists
      RDMA/mlx5: Add plane index support when querying PTYS registers
      net/mlx5: mlx5_ifc update for accessing ppcnt register of plane ports
      RDMA/mlx5: Support per-plane port IB counters by querying PPCNT register
      RDMA/core: Introduce "name_assign_type" for an IB device

Max Gurtovoy (2):
      IB/core: add support for draining Shared receive queues
      IB/isert: remove the handling of last WQE reached event

Michael Margolin (3):
      RDMA/efa: Fail probe on missing BARs
      RDMA/efa: Properly handle unexpected AQ completions
      RDMA/efa: Add EFA 0xefa3 PCI ID

Or Har-Toov (1):
      RDMA/mlx5: Use sq timestamp as QP timestamp when RoCE is disabled

Peng Hao (1):
      RDMA/ocrdma: Don't inline statistics functions

Selvin Xavier (5):
      RDMA/bnxt_re: Allow MSN table capability check
      RDMA/bnxt_re: Expose the MSN table capability for user library
      RDMA/bnxt_re: Update the correct DB FIFO depth and mask for GenP7
      RDMA/bnxt_re: Enable DB moderation for genP7 adapters
      RDMA/bnxt_re: Disable doorbell moderation if hardware register read fails

Shiraz Saleem (1):
      MAINTAINERS: Update Maintainers for irdma driver

Yonatan Nachum (1):
      RDMA/efa: Remove duplicate aenq enable macro

 MAINTAINERS                                        |   2 +-
 drivers/infiniband/core/agent.c                    |  32 +-
 drivers/infiniband/core/cache.c                    |  14 +-
 drivers/infiniband/core/device.c                   |  83 ++++-
 drivers/infiniband/core/iwcm.c                     |  41 ++-
 drivers/infiniband/core/mad.c                      |   9 +-
 drivers/infiniband/core/nldev.c                    |  74 +++++
 drivers/infiniband/core/user_mad.c                 |  29 +-
 drivers/infiniband/core/uverbs_cmd.c               |   2 +-
 drivers/infiniband/core/uverbs_main.c              |   3 +-
 drivers/infiniband/core/uverbs_std_types_cq.c      |   2 +-
 drivers/infiniband/core/verbs.c                    |  82 ++++-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h            |  12 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  14 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |  78 +++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   8 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   6 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   1 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |  30 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   3 +-
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h             |   2 +-
 drivers/infiniband/hw/efa/efa.h                    |   2 +-
 drivers/infiniband/hw/efa/efa_com.c                |  30 +-
 drivers/infiniband/hw/efa/efa_main.c               |  32 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |   9 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c          |   3 +-
 drivers/infiniband/hw/erdma/erdma_verbs.h          |   2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |  30 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c                |   2 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                |   4 +-
 drivers/infiniband/hw/hfi1/pin_system.c            |   2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   9 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 164 ++++++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   6 +
 drivers/infiniband/hw/hns/hns_roce_mr.c            |   5 +
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   2 +-
 drivers/infiniband/hw/irdma/main.h                 |   2 +-
 drivers/infiniband/hw/irdma/verbs.c                |   5 +-
 drivers/infiniband/hw/mana/cq.c                    |   3 +-
 drivers/infiniband/hw/mana/device.c                |  19 +-
 drivers/infiniband/hw/mana/main.c                  | 109 ++++++-
 drivers/infiniband/hw/mana/mana_ib.h               | 130 +++++++-
 drivers/infiniband/hw/mana/qp.c                    | 198 +++++++++++-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/infiniband/hw/mlx4/cq.c                    |   3 +-
 drivers/infiniband/hw/mlx4/mad.c                   |   2 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |   2 +-
 drivers/infiniband/hw/mlx5/cmd.c                   |  12 +-
 drivers/infiniband/hw/mlx5/cmd.h                   |   2 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  31 +-
 drivers/infiniband/hw/mlx5/mad.c                   |  71 ++++-
 drivers/infiniband/hw/mlx5/main.c                  | 336 +++++++++++++++++----
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  32 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   9 +
 drivers/infiniband/hw/mlx5/odp.c                   |   6 +-
 drivers/infiniband/hw/mlx5/qp.c                    |  11 +-
 drivers/infiniband/hw/mlx5/qpc.c                   |  13 +-
 drivers/infiniband/hw/mlx5/srq.c                   |   4 +
 drivers/infiniband/hw/mlx5/umr.c                   |  55 +++-
 drivers/infiniband/hw/mlx5/umr.h                   |   3 +
 drivers/infiniband/hw/mthca/mthca_provider.c       |   3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |  22 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   3 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |   2 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   3 +-
 drivers/infiniband/hw/qedr/verbs.h                 |   2 +-
 drivers/infiniband/hw/qib/qib_init.c               |   2 +-
 drivers/infiniband/hw/qib/qib_verbs.c              |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |   2 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h       |   2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |   5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h    |   2 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |   6 +-
 drivers/infiniband/sw/rdmavt/cq.h                  |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.c                |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c                |   7 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   3 +-
 drivers/infiniband/sw/siw/siw_main.c               |   1 +
 drivers/infiniband/sw/siw/siw_verbs.c              |   5 +-
 drivers/infiniband/sw/siw/siw_verbs.h              |   2 +-
 drivers/infiniband/ulp/isert/ib_isert.c            |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ethtool.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |   1 +
 drivers/net/ethernet/microsoft/mana/gdma_main.c    |   1 +
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 104 ++++++-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c |  27 +-
 include/linux/mlx5/device.h                        |   1 +
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |  61 +++-
 include/linux/mlx5/port.h                          |   5 +-
 include/linux/mlx5/qp.h                            |   9 +-
 include/net/mana/gdma.h                            |   5 +-
 include/net/mana/mana.h                            |  11 +-
 include/rdma/ib_verbs.h                            |  57 +++-
 include/uapi/rdma/bnxt_re-abi.h                    |   2 +-
 include/uapi/rdma/ib_user_ioctl_cmds.h             |   7 +-
 include/uapi/rdma/mana-abi.h                       |   9 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |   4 +
 include/uapi/rdma/rdma_netlink.h                   |  22 ++
 107 files changed, 1889 insertions(+), 445 deletions(-)

--g4C1gQ2ooTM8qF6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCZpltowAKCRCFwuHvBreF
Yc82AP40nYHZEcRwZowV5gvuKHR2OBY4emSzMP+RL1Bsc1j78QEAlW+tgloSxTnI
JsVN5FycwLXBu6s7kKvJD4pey/y/Zg8=
=VvJ/
-----END PGP SIGNATURE-----

--g4C1gQ2ooTM8qF6w--

