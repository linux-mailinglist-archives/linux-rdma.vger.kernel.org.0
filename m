Return-Path: <linux-rdma+bounces-19393-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOHqEnHv4Gl4ngAAu9opvQ
	(envelope-from <linux-rdma+bounces-19393-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 16:17:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6B40F791
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 16:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841A430413AA
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 14:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01141A8F84;
	Thu, 16 Apr 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gd2C0G8R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35B33120C;
	Thu, 16 Apr 2026 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348719; cv=fail; b=s3mcwW/eJUUmmc+v9mKVOFTg/zmQiQzAhb/C/MZ7ZWVrSguOjzDNa5hGrRb9oWnyDfK+IqCAIjvsFSbZwav7s1iQBV8jKcUqcfLphdswQISoeNPnP8P5DDo4HnGj1At9SsRBfp5pT+qTLGLPu1tR4WOQiGe+PuJI0xB6PeBa3A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348719; c=relaxed/simple;
	bh=rBBEIjML0hsRfD5yo2Hp/zVqbK7sLeJNUMTZ8OY4/hM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=daouaXm9mAvIzQFkMeaHaJhujuQlV+/bY31xZ75M1F6mzsKXGYRO8HFkrSrf7wS43tvb4fn1FRSicQVXYgp0+1ypH+AoU7hKfdro34F662pgYolxHh2nxncUziHdKvJpePQPQ6ha2Abtn/uuobCBkYCURMnWQ7+RA3hqTV8yQ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gd2C0G8R; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFXW5xGy6/xGs3wASFAvqjo67O7pWlKef1F9/GiQMyzBnzqSTwsMHvE7o+fdLbdWbC2v1onPwp/unPktLFC08vuddYj+DLEy/6zHk5qJqGfuf51SObY5b0gV1oE4ForVBksAmTGrV9Y3F0iBof7uYCIT9G8HuJ2TSJh5MNwCR/P/+oRanzwwIC3Ejq4C2/b2PJ1nbZLDqBo2dhQSdvfagl5x3NX1+Z4tzWCdRvV+xD9LcZNjTwlvJ6yqPcLhZa2m/u5rvOuz77TmPxFZme2ZBmnnLLk5PnWcplQF/G84lrRkBGk1OUbGhsb5Q/TDjQB/sN7IdxbQsG+cwX7mtvpz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IgrbqAjKd0bwuWqFVEIhtsqma9bKwslORbTF/ZDsYg=;
 b=C31NkpzPedX5wKs0W2wUw9OJIqHzx4DqjheTStLBhlslQYPMihdcO36TCXRoaWrGaN43AKAQV4X3YpshIluXvifPp7tFR5Ya/Fqgzkc2aRQSorpmDUeA1NXn8RFXNFrulUjMlvC+ucyW9lacEvZyTlxhmJGnZjflksGMDQan8IP9EFoXHSNAilHZQWeLdK8unUMYK5+xrUNPeDeMYy7JlxBneDGeCkZTTl0Co1PUVLSggvoMpjTE7M1D32pK2+0niSiOlZop8B8ROO0ZvZLTaSPS4Gu2ijumo5nZX5Wdh7oLd+KUcjpxilI7GwwQP4KWGINx1TbvESdDXqUCqgZTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IgrbqAjKd0bwuWqFVEIhtsqma9bKwslORbTF/ZDsYg=;
 b=gd2C0G8R1ShezgimayqGC3HDtfNSIVGMPDke9+sMqpmxlH3HNmZU55PElfsgrOvS84GfxTxHVf+xxAPWLX1GuwinIsHQ4CwUEe7qw3mDZAOsYTdmOZxlry8jxvLdcw5GRU3wjegyK3IngJpomGb0la1TNs9odgmtLwD2A+sR1LofEdqStqepYe/StqA72vHpz/nMo/4guur9KRWAB2o6tl6FX5tpaGjwsgNBcSRiyGwXRBZkBBB+AlJ3ryP/ixQVMRvS/So/FDRvTuLHq3OxhB4rWm1H68X1Y73cWKV/bsxc0rg4BbBJg/YbQfBQt418YgYOlcXy2eSowIelhFr4/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5907.namprd12.prod.outlook.com (2603:10b6:208:37b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 14:11:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 14:11:54 +0000
Date: Thu, 16 Apr 2026 11:11:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [GIT PULL] Please pull FWCTL subsystem changes
Message-ID: <20260416141153.GA1646988@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n+R94BSBfpwtzvW3"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0010.namprd22.prod.outlook.com
 (2603:10b6:208:238::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5907:EE_
X-MS-Office365-Filtering-Correlation-Id: a5149a2a-baed-4ef8-213c-08de9bc21ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BfV7q0IUwajm55BE1lie4zMKjlF3ti72pUDpANAUfKs6Nb4cQkqeeoKbFQd1D5iGXS1jFut6fu4SdR+AKukoyWqoGrRwCMwGM0OWkqZd3nAwS8Js2F93GCkAQCctwAy9diJFUsTA7bIuW+fi0pqtBdl/L4Ww8ClX03qcS8BSJNkGzj1VCgRhiyc4pGWzjmbqX3tjL6ybs9COtezoPG8E7k2A6grRpmrwgZJyijPCrgVG1jyjE9AdHv1sYEffF0ELMH4GOmm2J4AncSza1R0n9ytT37He1UZgsZq7xpF8nBdZD+h5TLv0JN/VHPBDAGPzupPIkpy84jw5bmvRRYmjKwp0kHw/y349Fw9EQ89odbo0HHMsDCx1DNUPFz47nXuO5jfgdRBEUYtx5RSugUty2YQIKi7kdqKONFTX8vxXeAmoYXkFx1QfgSOKKRZPPySLmBdYJ1ezs1vjhAu5ews9k+SQdGRIiCJCDAbimAt3mMAKUwtlV/j2VQonvWgCYNAwshvpD48oc3dbYhE13aY6HkTEx65YE37PY2a1Bf0kfA5sMYgDcy9IxJRytMe+J0EokyGlUHaO39s7BGfikJkLjtLrsVzC3eerwwtNneiMYCU5yG2jCg9grsUUmR9O2xtVvXTK0GQ5CcbO395OQ15b01nA5xc7+P+s0/0UMAWY9Y+6cMm/k5TQpQI+noIdj9uQ878z31K6qly9SZLUqa94WXYJ8+bmcj+Si1oYG+0B0ng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6qqpvovc+eR0qZHkDM8pPeQ5eDVKQeYINBtqzNfDjYhiuZNlzVekArV6XxkD?=
 =?us-ascii?Q?0XCqsNKUk1oWGij4VnI7fuucNyRicn7Sme/u1Em/TzjjtFPgMl0hGcca+AUy?=
 =?us-ascii?Q?spl9m/0eWwX1beAs8GqqPOPUbepNEPuzkAJhPyJCF+5CTe32RM6tvmE1eH/f?=
 =?us-ascii?Q?s3WDLdZs2/3TxINYzSqRkNoCQwd8sJopyiRTDQnD5ShgRkrDsRZi01r4y5jn?=
 =?us-ascii?Q?T4DN9tEIlWK28iIySBTzTAVTSk/2HZ2Y0KWUEGv8hF46aDMgxWDOQfxv6ujr?=
 =?us-ascii?Q?6C0sYLQOuohTxkOuJqfkzU9a2wdZdoSxnGwvjO21WlejmzwiQ+1Gm5VT/dvu?=
 =?us-ascii?Q?bbxYBYrMQWPa3+2B2k+yZGRVebKrDD0y6b6Cs1SyL/VxUpQIypnG5GdJqvgF?=
 =?us-ascii?Q?RJStQK6q17ALtQgA2b4E/IclsghYIqYKauQr3tmMYm91F3n86uVta3iL+lO5?=
 =?us-ascii?Q?fTtIPp1SbT01G8nrfsMk0SDxDOlk5S8uCISsz15u8TI2vZcdHq+nzrqCmKps?=
 =?us-ascii?Q?z6Hp8AWpvA0zL7ziRLDlFxbvoywhczaXhrOR0P3Satc3uIvc/5xB2Pk2g9B1?=
 =?us-ascii?Q?1PLXuTgSPk33aLtW7q5DaKIeuQwOY0Syxi6dojv3aav0J8jxoap4+spEU4zh?=
 =?us-ascii?Q?nN8KtGCaIs/+NH1RV7TmKE4skrNWknmjURwgaWztNjaFbBYzJ5hwqAC0POkr?=
 =?us-ascii?Q?tdo4LMy7JVaEhgeMEJS958BQ11r2GmuBIpR7dYBEqlRXyweg8VO/Xs+dQjyQ?=
 =?us-ascii?Q?xNv3CH0NUoMdQcepfUaaflYKWGhx+4s9mCT+hTVPGyJl1TDI6vy53CArlz3a?=
 =?us-ascii?Q?Kk9zoCgGw1rveU2lepesh8V8clQDc1FT4IbCbWtAjzv9XWi70LN8i63dTbsd?=
 =?us-ascii?Q?mqPaukxiP+o9lhydjJomffxil6XOGyR/4mlR+bCNRGdnM/rm8RJVFcTYNVpu?=
 =?us-ascii?Q?buR12S8+d398qdA/K/YMJdf0hz/e93gkcmvfhaA7bBV9FeCfGkzF49t/AEDm?=
 =?us-ascii?Q?N21Vy9Tj9rweKhThRoHLauArEsXicVUcZ8kQWNkzNq6f476pYID2LVjvgSZN?=
 =?us-ascii?Q?7o7BcDw2f+hNUwuy+kMjmsBbi2hAZ+aBkr1pt1Ct2DoUxQ9GMO3/8epJrNFw?=
 =?us-ascii?Q?ZXrQHhubWvtODz9uzJSwB79NPlQsz1NAhq2glyFaCg+2rjha241lo//Qjfmo?=
 =?us-ascii?Q?4eBjdDqmj+ucUyIwJX6cVv/wMB9UlMULPMi2cGBG2hYAxTh3zbyWnmc9sNH9?=
 =?us-ascii?Q?F6CWIhdFKsb4hKfpobMqAkJHuvv13ySAbUqY518PD0/ZAbv4lllSr54DcGTL?=
 =?us-ascii?Q?1GZqB+U83KTaztEduEU7cQY0JC7QzAau67+4R3kmT1bAXEWjFfxz1zUilzoH?=
 =?us-ascii?Q?eYY8YnB8AyM60ffwhUPv6oS0mfBGHAuBsApIIEhFbXwPpj4/cg5lSlAHeGMI?=
 =?us-ascii?Q?iW9cjPaG4SokY7aVRDXS+IDvG2lzUaWh6FvPqbV4Pf4TBvvajNEVfFnDQOQx?=
 =?us-ascii?Q?csHRMzbkRIN66u3CnbIT91xlp1XuyVeU4zxvIn53do/jZ+srLdA9nIKtRerZ?=
 =?us-ascii?Q?DNdF5SUGsoXhG8R8XvybPuhAC1DnbiGdKP2cfaPBuWDdUZP06W/mu7MBITYx?=
 =?us-ascii?Q?vmLgsx1DA4dRLReFo1C4H4yNLx6PiA3wd9Wj9NqewVVrsC6njW9nvW11y1Rb?=
 =?us-ascii?Q?/5dgSekhiq2IuzGFDkTQcVJeTuwa/HtArrddfkICjzVazDQx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5149a2a-baed-4ef8-213c-08de9bc21ce8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 14:11:54.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzF5Tu0y6gfe+E4/JKOlf9V0CM30Iarm61WFeGlA2FB4Zv4OJyFe4s9PXhUGx5dG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5907
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19393-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 9BB6B40F791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--n+R94BSBfpwtzvW3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Small fwctl update, another new driver for Broadcom RDMA NICs.=20

this brings the number to four. At least two more seem to be in
progress, and there are some WIP rust bindings for the subsystem as
well that we may see in future PRs.

Thanks,
Jason


The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fwctl/fwctl.git tags/for-li=
nus-fwctl

for you to fetch changes up to a55f80233f384dc89ef3425b2e1dd0e6d44bcf29:

  fwctl: Fix class init ordering to avoid NULL pointer dereference on devic=
e removal (2026-04-10 11:21:06 -0300)

----------------------------------------------------------------
fwctl 7.1 merge window pull request

- New fwctl driver for Broadcom RDMA NICs

- Bug fix for non-modular builds

----------------------------------------------------------------
Pavan Chebbi (5):
      fwctl/bnxt_en: Move common definitions to include/linux/bnxt/
      fwctl/bnxt_en: Refactor aux bus functions to be more generic
      fwctl/bnxt_en: Create an aux device for fwctl
      fwctl/bnxt_fwctl: Add bnxt fwctl device
      fwctl/bnxt_fwctl: Add documentation entries

Richard Cheng (1):
      fwctl: Fix class init ordering to avoid NULL pointer dereference on d=
evice removal

 Documentation/userspace-api/fwctl/bnxt_fwctl.rst   |  74 +++++
 Documentation/userspace-api/fwctl/fwctl.rst        |   1 +
 Documentation/userspace-api/fwctl/index.rst        |   1 +
 MAINTAINERS                                        |   6 +
 drivers/fwctl/Kconfig                              |  11 +
 drivers/fwctl/Makefile                             |   1 +
 drivers/fwctl/bnxt/Makefile                        |   4 +
 drivers/fwctl/bnxt/main.c                          | 281 +++++++++++++++++
 drivers/fwctl/main.c                               |   2 +-
 drivers/infiniband/hw/bnxt_re/debugfs.c            |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c               |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  49 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h          |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |  10 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      | 349 +++++++++++++----=
----
 .../bnxt/bnxt_ulp.h =3D> include/linux/bnxt/ulp.h    |  26 +-
 include/uapi/fwctl/bnxt.h                          |  26 ++
 include/uapi/fwctl/fwctl.h                         |   1 +
 22 files changed, 698 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h =3D> include/linux/bn=
xt/ulp.h (86%)
 create mode 100644 include/uapi/fwctl/bnxt.h

--n+R94BSBfpwtzvW3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaeDuJgAKCRCFwuHvBreF
YfVpAQDbs2KNRMD7BZdKqXQBhF+WGbClT7MnDxKM5UWN6AbT1wEA0KHNAARU8JBz
E55vaniOK4kTnCZsDXm2oixJ0n3zFgI=
=4wUh
-----END PGP SIGNATURE-----

--n+R94BSBfpwtzvW3--

