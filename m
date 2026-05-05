Return-Path: <linux-rdma+bounces-20017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCWmAhwL+mlsIgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:22:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD9E4D01E8
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C095330CD3FC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31F480969;
	Tue,  5 May 2026 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eJV7qz1W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4F3A783D;
	Tue,  5 May 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994265; cv=fail; b=r3lZUtdIFmQyKAM8cshvbUERj7zOG3rsrSzIuNnejh6RwJAlV1kTr8hTQCa1s1b30EyWMIeUSh8QPJ8Q3cibNaPsZjSLK9mMTbrkBX+VmSDMzVKa2lxxOIslRWl4OcK8NvX6036IFdqJsmIwRH+WJ9XbfrS0VAX/CnxjtkSG/AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994265; c=relaxed/simple;
	bh=CHyKb+Kj0PrM/jFVHgFkC54HUEqlbQC875/zxJGHh5s=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ep1DKpN5sOEvFCbTymwpuKQ7lXUR8CrfhlyLJ2u6gTcFZiMLhvMTFh1StCg/Dh3GA5E7fIr83Temt7rCc1GjN+Q1htVPMRzx5wTppo1shsqYyYWk0OkQGpFJOEkL3Kmf23gEWO9oAQVodMXd/ytIomm9S4ll2YMkMzuOptY8tiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eJV7qz1W; arc=fail smtp.client-ip=52.101.53.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKb8PhG+e3L7QmSqsRioAwcYC9+4Cs257x0ju2tyk8I+RuB+/HI8QEPx3MClHARgVEZYnsbfM66N3p7AyNDFXTdjva3e4GUCgfM9nAxB/qKQ6MFICHpFoOq1sIEJ5cH5nZEoHWUtNb0vMAM2qxmmH4GYgjEW0uPALzOwIp8jtVDRluKSRIqH6Xf2U6s1xFR7J3o+m7aKX550Rfs6HLwXMZGd0yfTrPWl17Md3hgYyAK+68uaPDvOOCkCeD+eALDD7tpXzYDlB81wf7uF2azZZbEXj2hMVutojRCQ0GYmtv7a/IRdH8esUe7Z9BkqiPNpQSxV2EH9CouQpo75IPNq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpAIQ5IFAvYcrvDvZMcWsfvd76fyYoegvxtFxXxP2Ig=;
 b=pFCTsXBXSdV5k5ekncAQgAdASmjcDYl556HZbFAiRJrIu6xx2O9oswYTiGrVzkKVCMN2qhAyl8/OFmFIXinWyrMKBz8RIorA7dVvF+j2UMOnGdSmv7PMA00O6WkFXoGz96650gaiwiGpbWluuHLPDAQCuoU/ox9vbe0qrZOr+jfa8ei+K/y6tnn23IxDGATLrJoJYtH/mxjaeHMLtkGZYWMxmA7lh4JDwfy8O2LanoHbS161gqhL9XDcKd1KBA1hue360xXu3ZUbXPbiJ6DPHoADOKxzHjtwp/U4dCz7X0HehTCJq1741XtQyHRK8nj6jrbC5y8EfO2KSI86COHb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpAIQ5IFAvYcrvDvZMcWsfvd76fyYoegvxtFxXxP2Ig=;
 b=eJV7qz1W1dperuY1fD8R0bGJT5gYmgPNtmpbsIGX3ayA0Gs4yxcyVLGxh7oS0SZSPAlttWHM5CSOIcjKXLvUXTuRMi7J7yO/C5niwzXV3B4IiZ+FPvo8MdjgUEDZKsLkmufdEW6RlOEpQxrYP5VTFCGBEiMZ60p6P+SdC9q837Xe2LkEEFLWjsDw/6QUcRpphGkhZIOGfqB/vbiIh534ZJK1zT3lSXj0kswZ5ThfihSfaYC1eJRzrnnupsEH0TB3PhhQxNxBbuthmg9t1JvJ2BJu7rr+NcZfLLj1LcvuV/tycHn0kQ9vlLoCYImWF+6Odzqy8Kt/panRk3GV9J00kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:17:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:17:38 +0000
Date: Tue, 5 May 2026 12:17:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <afoKDicC2EmULhF+@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaspfrE8evi+nL4O"
Content-Disposition: inline
X-ClientProxiedBy: VI1PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: d1de71f9-be51-49e0-a906-08deaab97128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SFb5sv2dZgyAAbh/neMKfc18bER4mA/oqquzYK0d7+t/r87NHKF+aYmJenaT8xVUuYrRRjPGjdaTsxxbG3B/zuF8wF0Z3xWOWpTFksWu/BwitQ5xUYjRkZa3qmyya4E6wH6FmsdcZcbce6lu7rqDLvBvRHG6QLo75mm2IukcGLkW47BQY+BHuiY+l4CiKJjP6tdGKq3cQhcFsU6kQe3qYN/PdfYwws1SgVwxhJCnojCVRkRdrl/lAVOrKCoNQ6LLTAx3JaieUlD0mZ8HOC2tnbSIIiMximRxEvjaLR+bxYjRe7HrofFkReD6UA82klKSwyaPW07uf46OS2P57P/U3DtxC13+IrQHvS2ESWv+yvwwaL36OqY77y0gUN6QMSCJ7LTwhyB7W8bDgf8AyrlzwlPOzD9ClLu6hPtF9q56wlVL39AQWLfbol64gJIcTu8l89TpREbZqFH1GkKiZHz/1Tfk6wWNdJyGgDvfhs4ZmXrUM0eqeFQ3VhvR16k6DR4jRXKDHJqfB8E9Mi7gWbANt//AK/p9+cnRtXeGlm+pASnFUBDBszu8MDpYmQMujsP9gXRkKYK0YPuZFggaf+Cu/xB7cz9IiPoXMLdU+ZJSPti584AACAi5XeQOh2dQNZxRbh7ieE22OoiAnH1QgXWxSDDv+v88w8AcGj+Zkw4TLPSnFpG9iRsVk0nUv2a25meD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTJethx4XW0Kde7cTyztugHkrU0jWIW0RkVlmXcT1QwNN4+Tg7KrQQ98KpGQ?=
 =?us-ascii?Q?eZ7HgH55WlU+k6aGZrr/RUzkbyre0qa0InH1W7Ilg/fFL3cqNlDw/EciB1NK?=
 =?us-ascii?Q?38NtURKwwQt3H5k6pzexXHPSeh4BVtI9vHxmNvfkHgW6m4NUOEPPxuEhcfgZ?=
 =?us-ascii?Q?kC7Mrq8dKsQL7qJhb8R3zFt4paBowIdNucwgr35pfP+4WPX3bBczxHZKAEST?=
 =?us-ascii?Q?P3vDa14vm2m6JnHCR9HDJxzeODFlyjm9LTIUAiBLng7w5Qw/z42VQVKcig9L?=
 =?us-ascii?Q?z1kqbth2UIeM+lUsTX7BUui3fZM7wAzBI4LBXWrVW8lUwutZvQiHeg71B1P0?=
 =?us-ascii?Q?SX1F64zANBtBJ6Uj1U/RlDgq/Y3PG+59aTvYRqJDwOJ/ovvw8N60yBinmyFY?=
 =?us-ascii?Q?fif9xl5KTJWqtJHfNkEvt1mzwjVhXaSraHBhlOudQL/kTmz7SP/Q+BOtiCGH?=
 =?us-ascii?Q?x60+sv2hhqocFEYJwwVywjSgjDOuP5Rb5G2jkMABPkISRN1/0oyu0Wc9609e?=
 =?us-ascii?Q?0jN6I34TAbTZTCg4rPtHYFbYy5LFYchDLiMRV0JsL8hugFkx+SlQipL0bqPy?=
 =?us-ascii?Q?vcKCoQjngflaO0wV2YwvNQe5jWt3OvliULuGkllDIfaYwxNxfg6KXns+4Vcv?=
 =?us-ascii?Q?j6hRaupomjKA/hiF6MG4KrNwJDyETWtWlr1IMOxdnjnU7NMD+ksOjPQSHuYJ?=
 =?us-ascii?Q?djmp5GS6jXcolVl5hCkGsMe62m/BQeIYwvYR6ywVfrV8L8UqBxszeH/UNqL9?=
 =?us-ascii?Q?U46LlodfjXPpruQWdB6+q+GwwXAvM2CoCR/8svWywIS5ustC22ysEDG0zVPx?=
 =?us-ascii?Q?dwXso+oVmG9XODzANOl9r9gluWI/5eD5dweMXvyYOWUBi2kgwErdSqrNi7jF?=
 =?us-ascii?Q?a68ArGxNgL/8HpiXQhuTcPTSHD19XrmYzjZ8j0Pp1z6musw3d4nNy1lGaDJ4?=
 =?us-ascii?Q?ihoSwkZodkn33r624yTZLwHiLATz8JcTe6xz3zSTbqqfM9D31tya9QLTB+T3?=
 =?us-ascii?Q?YmR0CNSMCOEKTAjjxvtFBK9qZlMbS4njTx9RDJcqUcKl1eM3OnHM8pv6tCpr?=
 =?us-ascii?Q?v7SM6QNHXZzJ7vH6PW+F7CkpzE8/kr1asLjBrDeSk4bWtZ/Cov06TZsacDS7?=
 =?us-ascii?Q?/0gxexUZs435SPOLzz9MolPDyN5/rbK+NIB8iZLyDJh9EKqld7DHmjCzpRIo?=
 =?us-ascii?Q?xvETIaCv8/7yISJIRhL7mPsTRj66dbqOeYph0JrY+MhN2CF7XYvpfmGBGnGv?=
 =?us-ascii?Q?4G4AB7+XlNpQLRJfGr72avfBsVCAHsaIA8s8wcC7VKDPFEVqfElkqOb49lEc?=
 =?us-ascii?Q?3kBcOfJTm0ASK0fA5auXGFVvmz0PGm1bKmlQFMKja0LwbPjcj4fXz0SVz9SZ?=
 =?us-ascii?Q?+w5x1xd0r6RnDabnexXHXCI3Nc5bic9GvzjqAHpDUfh9CTw/V2NN/GK0RQdZ?=
 =?us-ascii?Q?uNb68Sl1FfGK1wWEWhpyyohxqohGybzHgLGyhShJdEf/OUqnuFh2MhuTqGbu?=
 =?us-ascii?Q?sjl69YAL2pRVuAcsvaWOrlO+dCYvP1dbwh75L6jEn7MbmXi1hZSvPv6vcmw7?=
 =?us-ascii?Q?Og2sIGA+ST+vIMJkgwA7AJdbMl+h+10npTxUWcUnn9pIEAyDW+gh5CSsymR5?=
 =?us-ascii?Q?tuHJyKn0nDqxjeZ1NU0bRFna0uoss5sTmJTtdZ6tDACrmz3Oud1yamd3u7am?=
 =?us-ascii?Q?HTUjQxrMV03T+ibbTzYktg0bAOCxEI30edD2COPItq13srEs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1de71f9-be51-49e0-a906-08deaab97128
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:17:38.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQN6THjd2BGmC1B1Bv9DFGW3kxg40DWPbsshkRK+wCNBrzwT7tBMsv7afNX8lCFm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641
X-Rspamd-Queue-Id: 5CD9E4D01E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20017-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]

--OaspfrE8evi+nL4O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

This is quite big for rdma, it is not a lot of regressions but a lot
of long standing bugs have been discovered and fixed. I think we will
have some more of these in a few weeks.

Thanks,
Jason

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 0c99acbc8b6c6dd526ae475a48ee1897b61072fb:

  RDMA/hns: Fix unlocked call to hns_roce_qp_remove() (2026-05-02 15:30:48 -0300)

----------------------------------------------------------------
RDMA v7.1 first rc

A collection of bugs, many found with inspection tools:

- Several error unwind misses on system calls in mlx5, mana,, ocrdma,
  vmw_pvrdma, mlx4, and hns

- More rxe bugs processing network packets

- User triggerable races in mlx5 when destroying and creating the same
  same object when the FW returns the same object ID

- Incorrect passing of an IPv6 address through netlink
  RDMA_NL_LS_OP_IP_RESOLVE

- Add memory ordering for mlx5's lock avoidance pattenr

- Protect mana from kernel memory overflow

- Use safe patterns for xarray/radix_tree look up in mlx5 and hns

----------------------------------------------------------------
Edward Srouji (2):
      RDMA/mlx5: Fix UAF in SRQ destroy due to race with create
      RDMA/mlx5: Fix UAF in DCT destroy due to race with create

Jason Gunthorpe (15):
      RDMA/ionic: Fix typo in format string
      RDMA/mlx5: Restore zero-init to mlx5_ib_modify_qp() ucmd
      RDMA/mlx5: Add missing store/release for lock elision pattern
      RDMA/mana: Validate rx_hash_key_len
      RDMA/mana: Remove user triggerable WARN_ON() in mana_ib_create_qp_rss()
      RDMA/mana: Fix mana_destroy_wq_obj() cleanup in mana_ib_create_qp_rss()
      RDMA/mana: Fix error unwind in mana_ib_create_qp_rss()
      RDMA/ocrdma: Clarify the mm_head searching
      RDMA/ocrdma: Don't NULL deref uctx on errors in ocrdma_copy_pd_uresp()
      RDMA/vmw_pvrdma: Fix double free on pvrdma_alloc_ucontext() error path
      RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
      RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()
      RDMA/hns: Fix xarray race in hns_roce_create_srq()
      RDMA/hns: Fix xarray race in hns_roce_create_qp_common()
      RDMA/hns: Fix unlocked call to hns_roce_qp_remove()

Junrui Luo (1):
      RDMA/mlx5: Fix error path fall-through in mlx5_ib_dev_res_srq_init()

Li RongQing (1):
      IB/hfi1: Fix potential use-after-free in PIO and SDMA map teardown

Maher Sanalla (1):
      IB/core: Fix IPv6 netlink message size in ib_nl_ip_send_msg()

Michael Bommarito (2):
      RDMA/rxe: Reject unknown opcodes before ICRC processing
      RDMA/rxe: Reject non-8-byte ATOMIC_WRITE payloads

Michael Guralnik (2):
      RDMA/core: Fix rereg_mr use-after-free race
      RDMA/mlx5: Fix null-ptr-deref in Raw Packet QP creation

 drivers/infiniband/core/addr.c                  |  2 +-
 drivers/infiniband/core/uverbs_cmd.c            |  9 +++++++--
 drivers/infiniband/hw/hfi1/pio.c                |  5 ++++-
 drivers/infiniband/hw/hfi1/sdma.c               |  4 +++-
 drivers/infiniband/hw/hns/hns_roce_qp.c         | 13 ++++++++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c        | 12 ++++++------
 drivers/infiniband/hw/ionic/ionic_ibdev.c       |  2 +-
 drivers/infiniband/hw/mana/cq.c                 |  5 +++--
 drivers/infiniband/hw/mana/qp.c                 | 16 ++++++++++------
 drivers/infiniband/hw/mlx4/srq.c                |  4 +++-
 drivers/infiniband/hw/mlx5/main.c               |  9 +++++----
 drivers/infiniband/hw/mlx5/qp.c                 |  7 ++++++-
 drivers/infiniband/hw/mlx5/qpc.c                |  9 ++++++++-
 drivers/infiniband/hw/mlx5/srq_cmd.c            |  9 ++++++++-
 drivers/infiniband/hw/mlx5/umr.c                |  4 ++--
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  8 ++++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c            | 11 +++++++++++
 drivers/infiniband/sw/rxe/rxe_resp.c            | 14 +++++++++++++-
 drivers/net/ethernet/mellanox/mlx4/srq.c        | 13 +++++++------
 20 files changed, 113 insertions(+), 45 deletions(-)

--OaspfrE8evi+nL4O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCafoKDAAKCRCFwuHvBreF
YX6CAQCrgAwqbibO8PhQeqija6ZhgFitBqBrQROykEJAFUJeyQEA183pmYtXkQ9x
kG3TCGgQF8trXZpVoD/Egi4tuonofwo=
=xhis
-----END PGP SIGNATURE-----

--OaspfrE8evi+nL4O--

