Return-Path: <linux-rdma+bounces-12619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 841D2B1CC00
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 20:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EA3E4E383C
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 18:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82D29B21C;
	Wed,  6 Aug 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVu23IgS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9091F63F9;
	Wed,  6 Aug 2025 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505382; cv=fail; b=bUuEwxAhcoF8AV2/Q8PlIvsh2GWeljx+b9Uk618vQ0Tze7IDGQMawAF/or5tahiZGX2vUsHPMWUKIM/rngE6FbcnoWKEQ3c1VB+6tvKOiGLsOe+O6EFi7bExPOZIAsMjJs4BhhoKze3hzQFBQryE35KB8SJWNi+DJhnMmAB0b34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505382; c=relaxed/simple;
	bh=EjZomxrKk7Ubin8jSos44os+xrQJzR3b70S0c+GH/r4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Uj5KoyxrbRcO4XuDdhNkhFvgk4fzbldsb+Lel33OEQoRmQquVpsHo0ueqhlKH+pUEC8DJWTSEMtYJLbFPJVe2N58Oe220K+ATiue9AMqSx/ZVkgsBD+n/8ybDX//ZUlqfzms3juQAMxTjSQqkAwM4WCcpLSaO470hgUxSiuhJ+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVu23IgS; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyOC4JG6QLIddI7H0ocUVjNECFHWZGoap+BkVCX8proHVwJJmCHUSs1kWC32R0991/hbWD2moxr6wJ3gpw7rjBZdFy+UAWiUMfA3AD6b/tKIGxXevhk7lDm/Gow6W/0qn04UF4BOP+AhhyErRo/zvPkOnsFgCrKSV9fKlCFCmGtrdBY/EWN0XYTS4A3bXd/yk26QvgGn74+z0VovX4xnbkFqY6J0rCKM6KS+YqPMwNX25ig52Jr4kG6hMtRpuuk4KizveVFkvZJqfse17MPIXswIPG80Tgo1eCEDWa7oicJTuC4lTMIfkDayuXOTPk5YNKP6ginzhHDbDou+olMWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVCo4rY8NeU4nJfEqjWfCY+OLJVG/Q+btzJ4fK7BCSs=;
 b=qLdrjNIAT58d77zKffB8UbNkdtkE4wE6hzn8IjYKV3H1wnW9mdKAchjpt9DbVSKW0e/PISSENGaFG102/KU5ZkLxhv3Ut0BrEl1MktUlOWpclL4qRmyohQ1tu9Br7pudst6j9MRt12XEj7jtr0SHC2wCp//T7ICRkgFkejYQ1mrtMviY62W9fwYUz9weUqp4GkKoOrBMphKrWHO46XMME+5dEewF5acAYrb6GTNzBrxFe/LUhviMWvneB/+pcoCH0+74Ebfv0RTwWwEjPAKUFyg0K0xWtjVZwhLuCIIJYv67fmzchcbutpnzj/r17S22gdaOb5k5oNR7UTVRTNpUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVCo4rY8NeU4nJfEqjWfCY+OLJVG/Q+btzJ4fK7BCSs=;
 b=TVu23IgS5/ciyrE8NGaX0KGWoycAhoRUjSKS7obyrbaOTW0cfbtx+31GmOvzqDI6GjEaix5D2CT+UjtV1ne8nX8MK2W4/kHvpeI74OymnaU9nGYoTmoeN4QAVJDRCAYp1lJN2maNRMwjN5bnQzPvEObBs+mikKMzbF7JBZzOEppyFBOi2O2wC+EYBtGcOaPv/gdVN96Wsz0012QleVtzOBtw/dPGoRvDmxZYrm+yO2eL7vK8UN2n1yzdy1olp3QpWXPfZvCVHWxHCBpSav/9sTNFGr66FLcJT5sONhMTPFgaAU6PzRvJzldirzNFChNk3QfZEY3Qkl5WWOzj3BwpAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 18:36:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:36:18 +0000
Date: Wed, 6 Aug 2025 15:36:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250806183616.GA441213@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nlj69cpZLyOQ3HdT"
Content-Disposition: inline
X-ClientProxiedBy: YT4PR01CA0470.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 46bfd412-83d1-41ca-55dc-08ddd51821d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OgafSIMgjL8Uz5I5Sf4UKIcHRd7AdIOWwpngYLnXNNHiGZuj9R9Q5GpyGRZa?=
 =?us-ascii?Q?muJvK+uAAHOf7jkujkxVmNK757/QLFjLBmbEgV/JM2WN8y+dy1aH/qjDMuKS?=
 =?us-ascii?Q?+Pk/qgXV65ihwUTnGLJBsgjwUljNJaMpEe0ZX5z3vXysi1IOQGtfGx/FRkp4?=
 =?us-ascii?Q?Ydsy41jg5FnCROB1+vFgwoRlxqH1X9/ZDzBD6pirtm1GLqCde2WBpGvF4Xdv?=
 =?us-ascii?Q?upg1S2OibDcxLQzPFcg74iToHprTaKoRqag6Iq1Xvxxmr7uSOcGpg4KTKdXg?=
 =?us-ascii?Q?rFEmo1bZqPIG2JnjSYPpLB7m1ca2WtZ3SVPvNQVCPDaGjy1I87Jt6qFJHUq4?=
 =?us-ascii?Q?KLYOu0ocjlXbh9LaamA4N7e4cKMu9r1z7s4gM9cgzErdF1gI4rkymRaTHE2z?=
 =?us-ascii?Q?HO2mcKBKroYpPmVnjPZHzZfniC4nIa8m/pU0kbbwTZ60bC4Ad2ehiEvykjMz?=
 =?us-ascii?Q?dR+uIZM6zNxBzUKCbbsDiKBxnzKFPehUhgG/fKWTFn2JJRSxO613Ekueczbf?=
 =?us-ascii?Q?c45GIiZ4DI2BzA8pNwFbxM1Ic7jeIrHcfhoOG5Ov6qJzAuC74q1rJ8wwhn1M?=
 =?us-ascii?Q?E+JfBWaWoca1eADOnZ3EKsIb1IKyJfStSEtcYwhe9B6UwjRNkcR+JblCv19R?=
 =?us-ascii?Q?q7gmTXVAu9FPtXCqcNLb3qiyVEsAgTwpRPSLd/jAD63S9F5sUMJ/GNesA0K+?=
 =?us-ascii?Q?FrJa8EmwM6/8rFJk+GhGEyAzgw596Mj4A56OnivyIaJsmByyraIur/olHuMC?=
 =?us-ascii?Q?fvouqpDCNFHiOL7hMAC/xcRfq5JcZBSp0q3MGCpPi/Ni2wjvKOCR43lpeHFu?=
 =?us-ascii?Q?mPwTYKd43932N9m3/kwl5bn4XuddVu0j4eMCmlzVo6sZbK0AkDnye1RTspUQ?=
 =?us-ascii?Q?OTmZcZp/sWVrM3UZ+usY0YiRTZAl9p9YpIy5d9cqhaSTUrzaCNz8mfp8XJiU?=
 =?us-ascii?Q?9/rn0XteOSTRXxZ6HdxSJMxGlFxK+AW1pQyLZZrwvYYbNYNX4yssSYgcolmW?=
 =?us-ascii?Q?7N6Dt91xyDU1Kumy0eTY7ueG070Su6ke2ccSJbcK3NoWBb36fZ69SNN70iE9?=
 =?us-ascii?Q?Cv8KpMixQjnzjM03KnO7GB4HgkJoefKHuDPW9lH7pQt08qwMs/KwLClMARN2?=
 =?us-ascii?Q?fqSWZR/hCBQ2L77rDLInknnWK3fRVb3u5Yy4+t6DU8BlC+FQ7hiLJ7Dfhk36?=
 =?us-ascii?Q?CaOZwi+hJ+2G+u3gq+cLLOI/xlssVrLkgxGrrLKSflEbIdWYaEPIKMq96AGH?=
 =?us-ascii?Q?HynBrJCaZENAbEeSyChhwJmKgso7+U6f6TcwI/INVXgEsRiA7pANH6+NQO2x?=
 =?us-ascii?Q?TdDpG1TrxjyRp32UOPXKog9qklXANSI0rtasvLT+RSDa5HQw38HapmuxYKDs?=
 =?us-ascii?Q?tODVAaY4JuOLvJaBRXQXSmjfGxZgMUBJlMdg0QBsiD0UyHXq5R8lPUQL/FxU?=
 =?us-ascii?Q?qfoez1WlW2w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCUusGqCd8/ZYPwUsLRWHzbTH5A1oUFI9hIgckn08uRXzBhRJu/rLtsai8Ff?=
 =?us-ascii?Q?CaXe37cAnsFE1vRP5rTAgwVo07UN7+hSK0QZZ5rbUAUTxj7cAi2LawOTJGVt?=
 =?us-ascii?Q?cKiNvn9ByfilvTaH2KiBt5K6YwHqFlWz5fztwE2bsmtfZGrWWrOB2ti3Ti5h?=
 =?us-ascii?Q?pPX5WtLRzRlgHef0pFTJTq5HKityyu1DuC1kveXI2DHpBv09tvrNBWqjfHxU?=
 =?us-ascii?Q?WKKADbzBg8TyGsdcXtykg+Gr8YaILUjd6kUEiDgxV37Bk39n0K72UcG/s2fr?=
 =?us-ascii?Q?HEMEW0stY1wpcV0tbPpOKkp9DUX1HjA2foJT7lEkag0H7O/H8cUBQS3AJhI0?=
 =?us-ascii?Q?rYMYBsMn3u1O7NFXuWkSQg3go6QrXafSZEQtVurYyP0Thc14YkpWQ2Ie3iI4?=
 =?us-ascii?Q?MpvYp2V8os9yKpRcGg9VSO82TRB8gLiAYNDJUbP3desdouRJWy0L5EojyBKC?=
 =?us-ascii?Q?bI+2U7GAlrSRKH8969Vn4Dbd/3eepzciPFKFpU58B5JB0liyUDCieVJvIKzI?=
 =?us-ascii?Q?GR3C37ShGjLaaIW4DPDnEsaHtFjZtMxYW2j3ZWwXykMrLfuql9qLVrkeCaOy?=
 =?us-ascii?Q?NaXomDVNaJRmQ63sPkwiNbXPkYH9oKyTly/3vZkrxgZJ0/+VNTI174gx1qpt?=
 =?us-ascii?Q?Dhs++foX0neD9HPvi7+RbjFp7cwVSI9oKJRqxlcHWHei/T3MYd3KxgeZJPIz?=
 =?us-ascii?Q?W263hr5jJ9qQz53TnWKtTv0pFfNL4C4WGpnSVPzgeqZdPnG3DWQz+c8/yHRm?=
 =?us-ascii?Q?bSanIVfflZnl1ZEQ3n8HL5K0xhSJBWPYwtmPWG3nua/0pMwgmg+x2e+Sop+L?=
 =?us-ascii?Q?JDoH9T65+grTKt2UBggQehQm5KrP7IcPnLjSbyGkeGhrjIDwUu9IplBWYKoU?=
 =?us-ascii?Q?SO7QTeT73O3aZfryG+QpHl/JsQ4lw8hlocJabE2Uu73yKvTO4Kj0Fd88RxCO?=
 =?us-ascii?Q?rcC4zpuE0I3wgMb/FG5TsxVaAtMhccTkr0Ws32E0RWuAMbKlS+qpYs5ui5l4?=
 =?us-ascii?Q?f0DKs8t2sl4+fK3E8Hdq0wTMrTDz/r5bWAFaqU/e2u5JVqWAOhO90Y7b/Fu0?=
 =?us-ascii?Q?CDXAynKusEO7HXJrvFxYlij04KDBL70NWQiv0pM6r5eIsZbfOdosPJGEUBXR?=
 =?us-ascii?Q?3JAMYpGefpp3xsSconKXn0Ei0i3gr1yhRav32HEgq2YF55e8+bO297zuWSn6?=
 =?us-ascii?Q?bGJu9DcfTYw0XFrLxFVxyq33nviqZlzGjN5Xl/gQ3TMQ5R8XWNTHASVQwMbn?=
 =?us-ascii?Q?rD1GNxaPI/ZCRRkVYdOHEdgBjcno5YACNc7KsqlsnpyV5kJL5ahwdPn4hyew?=
 =?us-ascii?Q?F6LJ5sPrRC/8LVwxamz70KLhHtUwZdTTqmDUmQOmU11HESZ1KWXbvsXUuM4J?=
 =?us-ascii?Q?hskCpfwoX8d/kggjBIzKfyp7NS+zm3IXkASTeY/vHtQiNUAl9NFb6SzXn/hi?=
 =?us-ascii?Q?Pnwby31FwZMa/DprmEUA3oMW69b/efamwFpod4FNMgTTnFnJWwvEvzgBC5bx?=
 =?us-ascii?Q?wfZBUzFIwUsWRYmXwjkOcKE9MZRQDb3CK0DQsZIfw3tSUjbN0vpSoaJifdYq?=
 =?us-ascii?Q?x6RusZskM9gWeMP+3s0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46bfd412-83d1-41ca-55dc-08ddd51821d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:36:18.2613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLP6/AfEH1Wk448z80O8e1rNHb1bKToNDAvx410+fb0uNCRBBpVnrXtYPp6kKnxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

--Nlj69cpZLyOQ3HdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The slab bugfix patch we discussed, thanks

The following changes since commit ee235923d205c6de73bf5035f3cdcaee22f3291c:

  RDMA/siw: Change maintainer email address (2025-07-24 03:20:47 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to c18646248fed07683d4cee8a8af933fc4fe83c0d:

  RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages (2025-08-05 11:33:10 -0300)

----------------------------------------------------------------
RDMA v6.17 merge window second pull request

Single fix to correct the iov_iter construction in soft iwarp. This avoids
blktest crashes with recent changes to the allocators.

----------------------------------------------------------------
Pedro Falcato (1):
      RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages

 drivers/infiniband/sw/siw/siw_qp_tx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--Nlj69cpZLyOQ3HdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaJOgngAKCRCFwuHvBreF
YcWyAQCCKxRWNh0oCijHWRU/6rclWSB97lb/9HVq+a9W4IYNSQD/YSaTBoJ5Hjwn
61/Ul4T/1r9dsH/+622yGRIFHOft7Qs=
=AWgD
-----END PGP SIGNATURE-----

--Nlj69cpZLyOQ3HdT--

