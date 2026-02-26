Return-Path: <linux-rdma+bounces-17234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pn1H9VroGk3jgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:50:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE40A1A91B3
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 16:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 691FA317C0C6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4BF40F8E2;
	Thu, 26 Feb 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eyzoOnkn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40E40B6E1;
	Thu, 26 Feb 2026 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120177; cv=fail; b=DlkkEuhgRGr9Aw7wDei2oj55jScMAAUVVqAuorBMOspCw6qjL9dgVREL/Ayl5SsRFBpEebus9bj5+j6dVhYrhXODIgl0wfGIhsWKGIf2lgenSIAfc8p2qztBSaIQxGTPLBGtSbcfkx9yBVit9Myi2Uaw2ov4lkLZOGgnqaZXUVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120177; c=relaxed/simple;
	bh=nkA8nWhQvauyiFmKIREMy585yabPD+v2EPx2D/9X5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RaCEcLZKZu7/rPxkAO0nh94iDBjFDElASoEAq/eZQg3I4+jIxS6gsUUmImNwppu7Q0hpEPL4Fvmx5Q5v6PO2PEt6UsTefoXk8BoDg/xl+mw6JsggLvJ6E2RGurSTI5fGbSu0BURSyyTzR0xSps7OotfJmlQX8p8BT114URXOcL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eyzoOnkn; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxRxqomiaI990WY4bVTXcVfzJQRp51ugmX5GB5f+bqUXRZWDjy/JCCSw24IKmaV3WCHJCiCtLHYOPxfwiZE5Ua6xgukljlsOP1cZxF03vfq6sKSf86yL6VjVOlzfULldRqGeQTLy32riiYqUJjvgXFT0izRp+Mmg2DSSSbTQbiwi8+wHFWaYcHWCF/sLWc/ZeKYiqv5iVVW5YR9lAYknWlhN/oLpugEwSFvR1dE/qWYbjfxHCtNzhz1sOyjG0FGpklnqdkC1eJy+EzDEpAMx1yHQ6/aB0ecCHaDmEG7xNPYRvZOkBequrXu/EdloO3xvbacODXau16ChWYaQLbVsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFlP1Nm+g0a2zmjUTfZ1kyPMWCg5LeOMRfjnr0HCv5Y=;
 b=wzHg+GtyjOUlcxgCnPP+PN7cHs6An7hLUetdd5wiYqcLUjPvmsaKHpvhBNI/zJ/EFiniMwW9g9n2jb3H6q2SQ1GMlIJW7FR3bI06Yb7Yr9/S1e30WAjPuNliaMEewcWzVrcPJyIWOM+pn1dBUv++KCRnkHovhQz5sGgdBbPZuuGUOpl2TxYHKYRqQ3/wvNGrLSU957qEGcTvffofX0mMYtxbxwM9nPkAdJhzJbiewXW14vvo3FbCne1eEBE7GxfyqE90E17KWww7DKa75hBCGRtZnCB1seX/kg44eb9vYXw+41QhHRQQxYmcVWl8n5+jEW5RHtgWe3JUYAKplZWycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFlP1Nm+g0a2zmjUTfZ1kyPMWCg5LeOMRfjnr0HCv5Y=;
 b=eyzoOnknlHsUecs2Vo/sJSwTkOfQH84TmKaeZwcE57rL4HvqmmwrZwH8sMP3bcsqridiCazUEe0dny9r/jZMskB0RXLd7fdIVmk7xECWs6C/dqJmkFDnJeDPGEVuV7LKiBPyyryUlyXL2GObOeB5WzrOZHRLe26eBUU7LfmthEhHo5vAl7oPrSfthPAykZosRj3LlV9AJs8NqOAU+IKRAEcDj5DbFnRoR8/uiJCOJ+UHR0t2P9Bq6Uoy2YvcCXjPz37GwXdZPiPEhTSAkm7CZ982sbTlI2W1szJ9a50mUPHfiXUwYKVLkynvNzEJ03uZf7tMtKVaXEOqHYKdNRPDig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:36:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:36:08 +0000
Date: Thu, 26 Feb 2026 11:36:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260226153607.GA87547@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="76CjwLLuB5bddHwY"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa3fbb6-b78e-4a10-28ea-08de754cc30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	8iGU/OizSjki/EA/Q6KdT8a+4w6Mk8+ZHKmN7rtSw9R+b2yXxW346731aPM8+YGBNZ6LnxvND8QlpDZp57wf8zFT30714rALJEjiHWchCOWpVXT8dsU5XiIMY3tMoubeH1ybEPC34JFHVWUTg4E1B+gYlPiSciUDLyKs/NrUtWqXLMEwc/xbdaTHkqJ9k9jilq7MnGgx3PXTJEvDtcAH7V+/hH1ykqvHTDsLPuicV4B1x9DEl9WeCCxo4ZFEuncXIXVCMPWPh9HnLUJzA/hUBEh4EZ6GHy9t2ivuvib2PtPfzTQVll5+SAQruRRiPbRz4r9+9Rom1uNqYtCa0e4w9CagMU1COusXL8flaM7RaADhEYQZ5O4vCQrIZd0AmSBPuLE9lNhFY86C5PU/ukofC+uIsyXlSuSqPrGEzuAePLtIZ1bs/9kzaPAoex9N2nm/7psi7SnJkWEgHeqi+ExbVz4O4MdZ/KUMnQGEPM6aupnck2arH1H94sqv0y6dlgTq6fb7XNqkuMlMmNgXlfpDPwXdJcBniBfAkVL6n/cgIeWm1JXlKJsziUArtLnt7+rraYJ78y+1fPHlHjy4FkdZVIJvwNdtzJ6cYXjhW1X2WdGht16M4Rd00Ya0QbduuSbx4tZnMJ3/ulcjgig6EiB33YUh75lLDoXu/DCmWaJJx++Jz7+Yd6tbc/RqUeqy4p18urv5p1uTO7XYpbDkcMjJNqnyR+776H6t735ndEzFVWM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KUPqcbRfopUPZrMrOdsRdHJeZLt/xAKQiHy5dgQeoOVPxCNY3CXBflQI4TUy?=
 =?us-ascii?Q?+jLhzZj28wVb963y/Qb3ryuQRThv2ANmt6RE8zuP+yiqoeeCRmB74H+yHduO?=
 =?us-ascii?Q?agsDHvtjJqQCNAKNuwBbjSLrfv+U5n6/n5xFGJYTg9jBrDpeovxiPkbDkG2s?=
 =?us-ascii?Q?WDy8uNwjpfvg9XQNSdSM4K+u70kdDDhC4jfq7PIILzLdmpO/iwAiaSlLdu17?=
 =?us-ascii?Q?HQTgg/QrP0HXIHkZZS4d+hC4CDmz0BMcvfIkBXXa3zuzyWZtwk1WiMrkA5fR?=
 =?us-ascii?Q?EZqMszf5ZA3wKF5NPX+Ec1XG5xbJ57lSGRHlTc0fOQ0IEtZIG6xKwa7JIxsb?=
 =?us-ascii?Q?9uzUGTEyuIAqnl4ADwrRFt4904CrP9nqvlWqU2Ma0Jpf3OuAHF6lzN3JQf/S?=
 =?us-ascii?Q?/juxoQC+m4sIBFQDOKu9WXFyLXiNkgAWEH/u54Y2+4rHkvBG3ZJvMathqanU?=
 =?us-ascii?Q?URWa54nU+0AJuoUvCHax0M9QVe1JPuvLIxGRNaarETGEzBINC+3VYSefFafo?=
 =?us-ascii?Q?6d6LVS9Ht9egCSNQmT6D7RffF8WUoAHCWZMkgcrsDoCy92r1B5dgn2IQLM1l?=
 =?us-ascii?Q?9oE1rYyzMcB7jlsslNva08yY7Ig05S8zxZLKD6/VMuiomQJmE15y8tq2onB9?=
 =?us-ascii?Q?AxbORS1/rQCEvkK13LvWjWebps22aQwboylBRrly/EROPY6tyq3lK/vDjuh5?=
 =?us-ascii?Q?pRiosZt62b5UZ9tjO2nQqh5ol9JMV89+70HQO9L3LATrBL+Hiu090MS/RbT+?=
 =?us-ascii?Q?o6lUJdc8d7m0rqpwWYE62iBNUmDIDDRqMtAngM2geMfk9bap3DSEpvTBcuig?=
 =?us-ascii?Q?GSyVn69+Uif2c38SpJlX1ge2L/sxQWv6F55iQRrQbiZnqVnUphjcMhIaIg+P?=
 =?us-ascii?Q?p4Xp6EMssujNwm7d8ocEG7AzmYRKE0jcgaU7HvhW+qM8y+lSyfshjH+w6MVZ?=
 =?us-ascii?Q?3LJkj9Xx1JOyK1B63sBJ/AyUtVWQ1itSUiyrPuOPtsYMOgEqOTUnimZqfODZ?=
 =?us-ascii?Q?dUZPrRk6Keutp7TuSUM0WJHLGTGj7f7yrvHKONje28nnkFq/8t045ifZK4n9?=
 =?us-ascii?Q?MOgJilPImiDAAwPofxAN6Yqx7B/AY0h6/PeaPGcVgun2ciGBg4znZdQ2RBje?=
 =?us-ascii?Q?MRke50P65XbHyPZVighF3ky0uoO+Bmag5LfXmAm1y4LoArGCvWF/N3gaRGGx?=
 =?us-ascii?Q?sXyaCm/el+E0uAQHO+ZwmFmzw/t51iVY/u8wI6SyvxKS/TgrKVrvcwEhhBvT?=
 =?us-ascii?Q?ex9jxKlFC61qjYrfPa4YNvVPG7olkC1hoNVVgjge9mu3Ny9qtUY8Wz8fbgvK?=
 =?us-ascii?Q?mVB0BVnB56yRO6fZkXA0nTmHQB4Wcc1GPlS6qmL91BpCTZFVbIUJ+0Mes24y?=
 =?us-ascii?Q?he2hVS1O2cqcZa+OiA63GZWX4aAYYQpWvIpT87il0uDjGlxz1QWkOPvfBWwW?=
 =?us-ascii?Q?pawC47RaOX0uqhrm2YGl92yedAcWhzaoE96Ql3MYEXsds9ywyNu6stC21MtP?=
 =?us-ascii?Q?EbVp11A3VBhhXch107pgTbzKOHKivGpQslHzuEjUKhITe0WBCiYRctys39oY?=
 =?us-ascii?Q?JvdD7esVl9G4Y23nAPzwptX5F4wI4fIBB0KKvb4DzPBqoyu3MOu/E++v5u/L?=
 =?us-ascii?Q?pN7AQqRGCHyJNqyGqr1i+HT2dnqDibuU+On1a5b6KLJu9hCtTL8+/eBYUqen?=
 =?us-ascii?Q?ddHsO9ebgD7ZIVPpAeXsCOMf+ezmni1dQ8Qkydc900D3pXxnbpVJUQGJV+TN?=
 =?us-ascii?Q?a+MVAH1UrA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa3fbb6-b78e-4a10-28ea-08de754cc30f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:36:08.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8HwV1KQ4pvVMhB02+mJY67ydL73kOIjjZUyrSkBA6BJX4JDIk9ey20lRtKDwKal
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17234-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: DE40A1A91B3
X-Rspamd-Action: no action

--76CjwLLuB5bddHwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Some rc patches for this cycle, there are a couple of compilation
fixes here that need to get cleared out.

Thanks,
Jason


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 7c2889af823340d1d410939b9d547bf184d5fa54:

  RDMA/uverbs: Import DMA-BUF module in uverbs_std_types_dmabuf file (2026-02-26 04:58:24 -0500)

----------------------------------------------------------------
RDMA v7.0 first rc

Seems bigger than usual, a number of things were posted near/during the
merg window:

- Fix some compilation regressions related to the new DMABUF code

- Close a race with ib_register_device() vs netdev events that causes
  GID table corruption

- Compilation warnings with some compilers in bng_re

- Correct error unwind in bng_re and the umem pinned dmabuf

- Avoid NULL pointer crash in ionic during query_port()

- Check the size for uAPI validation checks in EFA

- Several system call stack leaks in drivers found with AI

- Fix the new restricted_node_type so it works with wildcard listens too

----------------------------------------------------------------
Arnd Bergmann (1):
      RDMA/uverbs: select CONFIG_DMA_SHARED_BUFFER

Jacob Moroni (1):
      RDMA/umem: Fix double dma_buf_unpin in failure path

Jason Gunthorpe (4):
      RDMA/efa: Fix typo in efa_alloc_mr()
      IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
      RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
      RDMA/ionic: Fix kernel stack leak in ionic_create_cq()

Jiri Pirko (1):
      RDMA/core: Fix stale RoCE GIDs during netdev events at registration

Kamal Heib (1):
      RDMA/ionic: Fix potential NULL pointer dereference in ionic_query_port

Leon Romanovsky (1):
      RDMA/uverbs: Import DMA-BUF module in uverbs_std_types_dmabuf file

Siva Reddy Kallam (2):
      RDMA/bng_re: Remove unnessary validity checks
      RDMA/bng_re: Unwind bng_re_dev_init properly

Stefan Metzmacher (1):
      RDMA/core: Check id_priv->restricted_node_type in cma_listen_on_dev()

 drivers/infiniband/Kconfig                        |  1 +
 drivers/infiniband/core/cache.c                   | 13 ++++++
 drivers/infiniband/core/cma.c                     |  6 ++-
 drivers/infiniband/core/core_priv.h               |  3 ++
 drivers/infiniband/core/device.c                  | 34 +++++++++++++-
 drivers/infiniband/core/umem_dmabuf.c             |  4 +-
 drivers/infiniband/core/uverbs_std_types_dmabuf.c |  2 +
 drivers/infiniband/hw/bng_re/bng_dev.c            | 56 ++++++++---------------
 drivers/infiniband/hw/efa/efa_verbs.c             |  2 +-
 drivers/infiniband/hw/ionic/ionic_controlpath.c   |  2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.c         |  2 +
 drivers/infiniband/hw/irdma/verbs.c               |  2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c      |  5 +-
 include/rdma/rdma_cm.h                            |  2 +-
 14 files changed, 86 insertions(+), 48 deletions(-)

--76CjwLLuB5bddHwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaaBoYAAKCRCFwuHvBreF
YTyyAP9usma4rc+d3t8p36lVYZ0RR7aZMlLQIgjMnyrgQrApRgEA2tE+uX2Pr4k1
3pSLMjikmJj4EUHhx5dXtlLR4J5omAY=
=KmCf
-----END PGP SIGNATURE-----

--76CjwLLuB5bddHwY--

