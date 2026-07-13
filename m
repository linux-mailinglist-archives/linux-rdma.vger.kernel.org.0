Return-Path: <linux-rdma+bounces-23127-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yLumA1HiVGqsgQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23127-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:04:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C074B3E9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 15:04:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=g80RNEYW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23127-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23127-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34F753046B13
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D8413D96;
	Mon, 13 Jul 2026 13:01:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E798411695;
	Mon, 13 Jul 2026 13:01:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947719; cv=fail; b=k80MWwpc/h+jIa0lr9ZQqJ5fKYhfQdUbv1WZ4/W8q+UASPLhbVlVBbE4xbMRtuqXtw89lSlBkVBpdMSfejaiF1Ck/EEff7c8UoIY78l2Aa8Q+9/m0iSVa0NqsCmfP2H0YG7ZR2eRbEDODft4/hcDIP3PuovPFKHDZv/FByIu6n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947719; c=relaxed/simple;
	bh=lzOysRR3vOTCLjizFZktsq21j0wCeIzw3RhnkdnjITE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=C/Ql4N3BB+v63IzFZQwt9F22EFTaDEYbS8Y/CebkU1h+Kf5qqcpaE1EeBmLtVZT6r5U0VCkP2sodW36J4vWSVtrgO6fRSKl0SJ2/tp6fAwcYNKk8SnIxxJnxOq/1biwxknYfQShnNDZN3uosoEBfgOuLM+BTEocRyOarIWO9Pbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g80RNEYW; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnOJie4426zVqKnWnRw1Bld70qgnQ0QZnbUfvPjR1LutaAWbsIeyLLycdtrxjD/X1V+Yh2ca+A6C1q4uuFLmI82gK4zlYFWWc1z22Mj8if4jjCBUNmRHgPVOIK/YqzT4mCJNOzYje6+LwkZMBjNvaeanI4dfJCJn17kcTiKjOxfqMkXFlN0CQEFrH8xmKMj289+0+jqHjsI2nE/hexZKolXvdC0qDf+cLfLbhJ42mtv5aJkoWrsKMe9UzklVB36MixU0j36xkjEDylRqk3ppvDoTOBRHNOoGDFcDtLLgkxPnbbQzOAn0XCLRHh4FAwwCbSuOO9wtqDWc4c98CkKVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8d/GFviUAt3gWQJfaboPfu7Rxszzjn7848n8nrhTYI=;
 b=YwHUvyrTdYC2ZV0l1FGUZCs2cYoYUu6REQSSr1Zj/RtQBtD+ADvTo0sbjSvrJKL7B69koDotDR44eRJ5mnHe9KGrwgTHN3Wh5D/xikpCPZy+ID1HdYQW7BqG4hBUHnlLJoa8Nb2vqJVhQCK+uF5CmThs3GmTJfBvhPgy1HNxXuwfcUhy8oPxT2+2smyMmQNg1bYlgnmBNtEbuFStOFBdREfYp0KdjzLrLzs5nsRxlpvnSdHK3OOyTYbZN4MCHr3FFGXZQT+/Z8W5ZJoklwJvVE2QeUD2HO/86puI3VVvl+5LAkUAVWjFWFv65AFOg89H0vvpBZ8bgLPyNHuFjRR+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8d/GFviUAt3gWQJfaboPfu7Rxszzjn7848n8nrhTYI=;
 b=g80RNEYWHV9NET/IDJw8KtwwRWi444cYFeofFRHJeZ2s7KX2LjRzwvqr2lcQAkCJGBOUxtYzU9cDlKMJtdzmn5AlCnqUL2Q4PQSrPiVwczWb95RtjGgS3HhZGU2UIwdhcCeYbskCHccmS4jw7gaeT5UY2fC99CO6aXqwF/2QzI2DqsGAiI0FiCptS44nTovpJBngIgZqymeAfd8T83f/uB0dqVXNwembGQvtfV8YfUFLQEWCCJycK4uWusDui/MEzgPrVwHrVEOo4YfRzkcg/GrodmAuadY33iv6jDRD4mpzZEZPGBpubiBkEWmUNwb4wjiNpK7GtEDCQPSYkWPYuw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 13:01:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:01:51 +0000
Date: Mon, 13 Jul 2026 10:01:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260713130149.GA3130810@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XLO+GqW22OLVb+fg"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0343.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: b1736465-563a-4dd2-501e-08dee0dee7b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	++qbgHhTnYqm9NrVGzs9pD7o6tG/qssOT7FOQoL0NIof3bcBe48Y752ORWdqv1ZqPPvKLGizW9OtajwcW4dzyp9MRY/T3swqRwEa67tqoFe6rreA+lhTe2iSR0x04C0FWuUeLsDwlLxvrsR/gX9zEgyiU1jXtgTRsfHOBI2Pf3hxTw483RyqIBs6lvDnPBHPUaFinH/hyestoOFfUpv25KcrDqgx0thc+fNGE2WJ1Ul0jeKrzSv4gr8NwiXS09sU1C2iFhZFy6V/aefSmt/QXCiwSxgBjGtE5vixWC2FwlPN+HyziBb2jEVbtlaEWPFl31SBaBPc3YkGhFCl5Y20RVmMPq1oRDdb1TFZUoOhOASANFn5R+E7cMiPR/JFGSQcfgf3cwP4XDktvTmuoIBP5e9jjHxPAkq4Ika5Ree5yaXcFjkdREV36w+XjSBvRo03pGQDGYhdsnD2bsdimLNOofqWSTgMLEhun6rgOqWNG8OHVQSvASX3+0xQMvf+n0Z0Lhx73f61d0x0UU4y8e+2N4zhVGk1UhlnZ/qBexDtVc5LYzKtJ4/AA+04RU72e+WFFD1yHI+YYc6eHZOgiD2JqNY9vyqjOKN1r3gCkuKQtDT9JdIHKaFcZuELKaBz7r3hb1DWkrtLe4KiyRH9RM8UIQ1OEzOFqRSuAFQIJ8yJQ94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(5023799004)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aeZWam48f2OMVjVMR5CNyD+TLRmW+H4rUQ/NiMRjjBvya69/YFyoeYY9p5r?=
 =?us-ascii?Q?jEoyl87x1j63wCs5v61sNRx11hIIkoZLgdXZZOpDcdjHd2A4jDKeMUBlePCX?=
 =?us-ascii?Q?uIQ13iLI9GAXzoWLCB3ZG1PVQxYESMwitmsqLK61wHNBEuOB7evAE+jFhJG8?=
 =?us-ascii?Q?rVrSZO91pSrdsqNSqf13JLgKZx08IH5e3drZ5xH7flk0MHuiQaiCLaq3RBcp?=
 =?us-ascii?Q?GDsEPiJPWCK5W3D6lDbteDm1iCKRNkACEhW7+LAuAaZ5E0AfEqSZ9bASPqF9?=
 =?us-ascii?Q?C7GiZV52aY4aqwHoUqZzVh2ChvjQkr6Q4Zhz08VQXq5oU1l0dmr7h1VrOtN4?=
 =?us-ascii?Q?PFtlbbBUolqctqHjRdD2/vZj7pEekefXHtUnIDa0EdpB5H/H5tzgLbFS4BOW?=
 =?us-ascii?Q?U67ClxKWrfN8j4hxHnzcKi9rFyizAPcuCdaZnNYoNYCntIhASKieMtHsf5YB?=
 =?us-ascii?Q?CWD8j+LMS3U3WOZqaIPfJ92SFNhV/Kjp/nhchoXLLYlIpv0XhPK6SLrMsdSq?=
 =?us-ascii?Q?O8HWvQ2a3C7f54XzdmDwCCnRyZhu/BBQTAXyMI5scxekeaDAcmHCzmVh3OWy?=
 =?us-ascii?Q?6H55mwDD0ILkhY7SSY+aolYHJY3NSH5GpiE2hniw2lB5Y9W+VNYRJxNP1uqw?=
 =?us-ascii?Q?eSx44mbXb6NKlNlfTzmLjhOynkOiQJ+CZxXcaH5ablzOj3lMCMEUqmSQw5n8?=
 =?us-ascii?Q?Cec4KetzS67H/NqFcPdl+Zy0OGtX18v98AbDuryYtI0TsPHnLglvfTcnnbFB?=
 =?us-ascii?Q?8O0MCS/cUi0nH9FO4SVHbUd4qjgiKbI3t3z1D/jcU6bV+Lq0pk4rtJkQX3AX?=
 =?us-ascii?Q?BDfUlm46BXXYKaZmaNi2Um9SZviu6Usyt4XgxqGq9hkEtcO0P89f+AE33M8g?=
 =?us-ascii?Q?vkCTp54N7QVCMOtE0kauKnpRFcrbjdzKugVf3oF9VOWcjCGm4RePXqVy2/Pw?=
 =?us-ascii?Q?MP8IsUXbNihkE61k/vCSr7MPm0Ci4JauAYsur3c6PT/XDVntJXKLo1un8y/W?=
 =?us-ascii?Q?WHGkNMZ8oqHupuf63ndMju+FxSekC46dNNdrjKwRXe4ydFEeIaBvYtZvx8Wi?=
 =?us-ascii?Q?1IU3r4jyhn7F0iVNJz0GnhKKE2LHrdupVncVqY1/6nY83hFUjsCxGUaqeMHc?=
 =?us-ascii?Q?2GPMgvQUfGRD+HCMyPcmPkw28uQ9B2cfn+NjRD+JIRk7h1IqRMazaQwynFtq?=
 =?us-ascii?Q?3ht45RjbqC2F1rGqyBb/vqKfaDkKRheeNRJXUjf6fZSGL8IcjnpUlJxKFag/?=
 =?us-ascii?Q?vscJXY+cnBf8goY7ELaqi+uV3ccShcwCzF0Jnq5n9XS3oQ0QifeFOTOpKK7R?=
 =?us-ascii?Q?aEqIL6xKOF5OR8ACroOAbUHln2h08b88/MdQxvc4OCb/Bvkteo5Amhf16KwH?=
 =?us-ascii?Q?EnquRvNutEtEziMaoJ7GIZ9PQeqntDmsO4K0AqvXvuPhaPVd8DU/BJ4S621c?=
 =?us-ascii?Q?2NqjsUhvLdItpWya5qdSV5mp+MeUtGZlqrjruPeooANSlIBNYya/hZTg4Xha?=
 =?us-ascii?Q?pyZwOWOpQuqsMpIrqclMJh1bE7LZRLIznGU92Vm/MWS3yVLhBj81+MZFkPSD?=
 =?us-ascii?Q?IWVuWao4Op1zlCQ+TDJnWMynfnAsdELh54B2+nl+kwvwgXvazLlTnwY82KJG?=
 =?us-ascii?Q?8yFz73BJSb45YBuGbGcwO/NDDl43QK/u4y25YdbicWbPQdqtiNRBDVgfF8CX?=
 =?us-ascii?Q?hQ4ddXJXOInLZ98+XwIBHH/6kKhJ65psNUHd2jUmZHQYCe15?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1736465-563a-4dd2-501e-08dee0dee7b1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:01:50.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG3ONgpOA3g11geiks/soarcY6jd1bIU30qdHxC05Gkfdf1dH+jOnMTXqPdy/l8Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.26 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23127-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 890C074B3E9

--XLO+GqW22OLVb+fg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Nothing unusual here this time

Thanks,
Jason


The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 3cda0dfe8c651dcbb9e38977905d3d3b1750c4ab:

  RDMA/irdma: Prevent overflows in memory contiguity checks (2026-07-05 07:02:35 -0400)

----------------------------------------------------------------
RDMA v7.2 first rc pull

More bug fixes, many found by tools:

- Protect from a possible DOS with certain RMPP traffic patterns

- Correct mac address comparison so CMA works properly on IB

- Some crashes in irdma around memory registration

- Uninitialized value in erdma and mana

- Wrong order setting up a QP in SIW allowed a network packet to reach an
  unready QP struct

- Catch math overflows in hns and irdma

----------------------------------------------------------------
Aleksandrova Alyona (1):
      RDMA/irdma: Prevent overflows in memory contiguity checks

Arnd Bergmann (1):
      RDMa/mlx5: Avoid frame overflow warning

Chenguang Zhao (1):
      RDMA/core: Fix memory leak in __ib_create_cq() on invalid cqe

Danila Chernetsov (1):
      RDMA/hns: Fix potential integer overflow in mhop hem cleanup

Jacob Moroni (2):
      RDMA/irdma: Prevent rereg_mr for non-mem regions
      RDMA/irdma: Prevent user-triggered null deref on QP create

Michael Bommarito (1):
      IB/mad: Drop unmatched RMPP responses before reassembly

Or Gerlitz (1):
      RDMA/cma: Fix hardware address comparison length in netevent callback

Ruoyu Wang (3):
      RDMA/erdma: initialize ret for empty receive WR lists
      RDMA/mana_ib: initialize err for empty send WR lists
      RDMA/siw: publish QP after initialization

 drivers/infiniband/core/cma.c            |  2 +-
 drivers/infiniband/core/mad.c            | 30 ++++++++++++++++++++++
 drivers/infiniband/core/verbs.c          |  6 ++---
 drivers/infiniband/hw/erdma/erdma_qp.c   |  2 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c |  2 +-
 drivers/infiniband/hw/irdma/verbs.c      | 26 ++++++++++---------
 drivers/infiniband/hw/mana/wr.c          |  2 +-
 drivers/infiniband/hw/mlx5/wr.c          | 16 +++++++-----
 drivers/infiniband/sw/siw/siw_verbs.c    | 44 +++++++++++++++++---------------
 9 files changed, 84 insertions(+), 46 deletions(-)

--XLO+GqW22OLVb+fg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCalThuwAKCRCFwuHvBreF
YW0qAQChh6D+HBaQ0qH0d6GZAY902DyopLVSiHIoxos8/WmnvgEAtnL9R6HB5b8w
dVAWty3Cfo2lcjh9fTm+3amwkDJqSQ4=
=E6of
-----END PGP SIGNATURE-----

--XLO+GqW22OLVb+fg--

