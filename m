Return-Path: <linux-rdma+bounces-10364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF194AB8FBB
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 21:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266631BA3974
	for <lists+linux-rdma@lfdr.de>; Thu, 15 May 2025 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6A28B407;
	Thu, 15 May 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/Qf9Zm9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27582259CB9;
	Thu, 15 May 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336340; cv=fail; b=lpA+KR6QT9bIoAIesD4HsGqUVZxyt1svBGKoJH4+gOWo4YJ/+CNns024wNWsJL50b9xw0e6TEziqFCr2m74JNu2Bb94noo0vUqX8QzxKir3zJJtQ75NN/xSpgIfvERvlH+Lv299o/8onc5BznENR5a62hSmw5hooitMPZP9OZqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336340; c=relaxed/simple;
	bh=Q5lq4Ey9/CKs0MX7ENVarOVWqHrP+uctE450JXthzR8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=baqwWzPmADCxpCFSGVYYUFWAP4ING9z30vug6SA8Jx+F7Omtk7r/acOPHMJ2IKf1Eh/7WM5nNB/Fmt8Pe9V9eoL4+VH+sRlH4MIT/ozHVr5ehadnurUjXbzTaqn9Pop8oAPmaV2c/eQxLxNux9R9nB+GMb7oKZ0EfCZdZmBYooE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/Qf9Zm9; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZLQdwSvtOUk6nK/Dn1NJ8pWbmZI7b5M4smw0vw0yWqjZgNE6R7yukmSgqFH7ngYCy6f/xyMU+6xh7KMSgNROnDZYK/Zo2EwVjxGCOKz6d7t+O0TQtWy4OCWJtazd4ZgVpBrQ9D7rSERSjwdP7P8r/mLFu7hNIm2ZwsWzWqb0Oke06hKn3PPgOwMsQTr50y9h5DAGaLTIrBpjtxaBgGmAEA3FkfjJrYfdvY2wifxw6bQgwORtOrbfNEj6EOYqfJMZofkEbqiZ4BJT6xUfNf6M7JrrLw87PMjp7rhW+KPxGsVAD0BaZfzGiQEOKagz6RSU+3dOAnWeUXzZVz4IawOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uEi59CDg/p/U/9k8FDw7uNf8/xnKxvvAZeRj/vi36M=;
 b=YF+a9n1QXc0iULCSpd8t75vxbXIEQWslbQUnYkCAMo4C2YnG/vVqYAtheOPE4mgnB64XTarGFOJGY0M+7r1yyr0QwhDX9fO5h6Eqg9AhUEF1ZPwr2+wyZrGgDTIYB1mkd1aKsmZa5mK8HDQXbP0ortLwrz5NvUT2Yjw0+8CGaW3/DYabLvyU/c02ziGxQviIDOZfU/aR4VQQommrVLqpklAxbG9xcFZCqH8Oqm5gJw+mjSIzWMz34b0BBKbmBTiktN0OnU5syiD0eIVLZ8b8+9Gm/PiA7z0uQ/yjbEOsJIvfL1NPdve/eURG8Y5a1nFqTXanVxNnHItZ++E9ETH8Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uEi59CDg/p/U/9k8FDw7uNf8/xnKxvvAZeRj/vi36M=;
 b=I/Qf9Zm9u8ArLG0bsVgiy+AkrSC/ChmiQTo2l/G65mNISdvJqO/yxRxjuWUtoR993dm41d4u++KCVIdmiiQHO3i5c2KKtIYj0DytDizF7B9HI+rBN3B/K0JUrLM0YDTT1lMJWA39bY70+CK3eWBGQsyvo5Nbbe7Na0Hy01ZmnAfNTR4UZAm0FAXNfGny7X8D/7BzEfQCDtcPbg5zffPBuqZRlNcRqPjnYmbqNUDBc6yhDQ6iWiwnGgJKPZegAF8qfBjOggfEUpBgoU4DBme+UMXVfN9ZPv04PpBuhPCuf9BXsa4HDwnv3f6fFD2MrN7jd0GHsyxiZ/8BJmC5HUZe2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 19:12:15 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 19:12:15 +0000
Date: Thu, 15 May 2025 16:12:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250515191213.GA612809@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrmCbAKEYJqGwNX4"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f70cd4-635d-4396-cdce-08dd93e46744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nov3GYrm3GBGwd/z+X75gFKNxKZUYyb8w9/q1TcKCvQOoEOO6PgAGqICU4QD?=
 =?us-ascii?Q?+ahP72PCCvXN2Bs+85ENopzt2X9kpWxIMp+phAgpJ2RDh4dQGjMCpIZod4MS?=
 =?us-ascii?Q?2DzDTuWnCQ6JGQLB1Tz15j/h2gdaR6CZu5RlZel+Bs2q+JLYWhrHBL2+JQru?=
 =?us-ascii?Q?ydhddqeo81vALbnttpzCB7j8QL2lx+MN7CidVkGjxrlx96qGIj8nUt4J1873?=
 =?us-ascii?Q?0MMUuZqdhu4OKB1HbESBkiWGaq1MlpZbRhXPpJICdjr+NadfYT3i4cEcsNR0?=
 =?us-ascii?Q?tqLGUeBauTQ9AIcjNYaXM+9nCq4QSWEoDHlf2GEJCfsNVbnuNN8yLSFhYDhp?=
 =?us-ascii?Q?mXqn3G3ny07aMX72JFJinViFNjRGfAiR8xOvB37CRmRCPitSxS/TNhGNGNuu?=
 =?us-ascii?Q?ebMP14VZ6qR+iIEPiwQQTlhOnyViSk9BpJ8Mp0oxQKTfgGgC/ln/y1A7hjHC?=
 =?us-ascii?Q?E7vTk4W6C+qVN4BMjAits1XaU762Mp8Cf5xJtreY/UbkkeWSuYGCc5eq9vC/?=
 =?us-ascii?Q?zsB+o0QfeV1b0H3v+Sbqni8UGgY63uqAWmgfaFsCsll0FEzA857bI97ktcsv?=
 =?us-ascii?Q?XDfoP19Q8Nj9eDtZPw8lZ17l+oCQYllHgE+nBQbEyu+Lk3cbY1pEunO1fu8U?=
 =?us-ascii?Q?rCVtpJt7wQ/ZdUIqk1rlGOp2EiIDOvb8P9UtOGxh+1BdTgD4xGq0zF1K002w?=
 =?us-ascii?Q?ZfRUY8fLWg4NkmCa67Fm5w+JxahFyt1dznVqRYwAKuPjhXRPekJ9cUUbvddL?=
 =?us-ascii?Q?l4mpaVYJ5R5rYD2b6LTED4JjAbenV4x1bjSsWdbtT85gxfnyTCxtWt7Xqijk?=
 =?us-ascii?Q?HjnBKtKtwwP2+T8scOLTm7vS18IsP6V+UtpkHB0F34eFHvJqqB+uwaMV0hpn?=
 =?us-ascii?Q?dERqfMm8IJJfcgxph0M1E8LhmJvD5b4ovXKwNLGPwLbOocQ4HRmLYg3nDJRX?=
 =?us-ascii?Q?SbGeTZ7VM9KE1PqEcL44lCA+vocpNQD95qVSxm++oK9iRK2uTkOOpUPmMXI9?=
 =?us-ascii?Q?wlb5YrZ3kdwnfROfwOSk1NOu6lKu5/HwYAMelK53OlOyKQhLabHDW0aP9WU2?=
 =?us-ascii?Q?YCkqA1y3W2yK23qkylOtqEOve4gWl6MXLb0Cpt9tY4N+fPvDZ8nTwDgSvKds?=
 =?us-ascii?Q?sLRCCGbhFmQKqSemrI1Xepv4gGcWBzrVW/V0S8oKzScm5Qljho/IWrfRIaY6?=
 =?us-ascii?Q?NuUuh6OKGgwdT9Sb1WRhuv1z8dK4zFKVKzQyQuJa/xiO8zTerqHaWLIevUis?=
 =?us-ascii?Q?XwZDe3PkNc50ORUNWZZnalXjx3H1Er9W14XLmT8/DgFdPSGUMNEjPRYomS6c?=
 =?us-ascii?Q?4Rtt/bfs1jz8meL2i4casuSwJnen7Q7gm9sdNR7ZqcqMhR8/Bw6oYEhzQKhx?=
 =?us-ascii?Q?DCy3UUe2f4/mCN/kHd8P5QhFlfPilveDWtGeNmHy/G4svZ3uvLXzLk4MZAq6?=
 =?us-ascii?Q?5GqA239UY/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hac44iVkrR76a/jGxTkPOPy9b85e15Y9tQJ0gtoScAY5z6DVDvZM7CRaXDp/?=
 =?us-ascii?Q?voTDC+3tRUmnOWYcpmPinsyZnV9k5Iw7cAE2O0rlK5/FRpLqyisM/OrxvoQB?=
 =?us-ascii?Q?cD5yY+aB6lQwTVi9WW/khfXIF6mWba0r7ON60htz2n0YB84+BXZxY8AdCR0A?=
 =?us-ascii?Q?HtEtJSmvdmgDt/xJUu7bTAbhHNJT1SFVSkhuSMnX98gV44EOY/fA9k0mSIej?=
 =?us-ascii?Q?ujQ8LDeUa/nxyeXnlHzS8LpNVf26pIxXD2UPpCPvBXNliqp4ePv/KD/JvqAw?=
 =?us-ascii?Q?kSSzURyRzMu+7f0CIXaR0Yvpu3iXNZ82oEir1ihjbXCInE8zlihudlWf6ifV?=
 =?us-ascii?Q?HSjYuTFZVBevzrAX47PyyfHt2XWyQVMkwqQZ/iSJXtQb4LDZPxAG9s/6iAmg?=
 =?us-ascii?Q?wtd6NMmEpy8AaE2vYbEnbTScAgEYxj2btpGHV4IjmvSUNfBEPOehzAY+iv5M?=
 =?us-ascii?Q?MCWhJq/0PFWeYDL6WvHbVp0WIbZ3yKDrGzYZS7/3S66jkat3+wqtOG5zcrEp?=
 =?us-ascii?Q?MhEnCbcGwomKc76mtpLF9ytvZxttnVx5bZdzItcGXCMpT6A5ns4qMbGvBqF/?=
 =?us-ascii?Q?C5xr5v7Q/gkYhyBd1eyRT5aMhLm/zHKo0760aKF5zn4M1ZN400tEQjHPjpMl?=
 =?us-ascii?Q?sMzri4TzkHMxo7dPf/D8yHYam8sBgO4HSx2NLNrX74Xz53OmjfFGtkKKHcOB?=
 =?us-ascii?Q?eIt6aLai1KLjkaBrxqkozo51L/fzLPwdcIvlVVsQvNtpj2AD3d+N1//JDd5i?=
 =?us-ascii?Q?UbNDHP4ropVd+jonJ0QYPj53dQvML6h6RWS1AyVhD/YehARl1pxT01NR715p?=
 =?us-ascii?Q?SoeZxCTvAKfFxtHz4UMStRE3mO4mDZFR63SAPVQHmsZOodMGMgKPTgAIyee2?=
 =?us-ascii?Q?l/lZcUvJHkWJc1bsMyuvAzcyq63+3rIBbCD2PtvFAn0aEBSY7NWYbliEv4Wx?=
 =?us-ascii?Q?OivSfnBxjojifnBjP7Yl3k1sCVJmcX2L1fCACQx58cbz43xOjJ3dk0X+DODh?=
 =?us-ascii?Q?V6afCvccoM11x+jumdgAHXNPcCkUYLGIHyG5fXn28sqfr0qsKOZvoYwziLON?=
 =?us-ascii?Q?BIa/f/UjRiVzptydqgX4+LglT3q0628m/M9SNeGiObcGa7VLeY9JJ0PhT4/W?=
 =?us-ascii?Q?eu228a5q2WBuRMnI8hECDk5ohLQY1HiA+IdNmP474+z5k8nhddRd7VeleCE2?=
 =?us-ascii?Q?QqBD4wZRH/aGO1W/C4ilcj3gZ6LGEOK3vssFDZ0t5rNpZlEzh7wba/adRiJ1?=
 =?us-ascii?Q?I6vZIZJwlRBT17U7d/6sTFTATa/kua7H1sxLb6l1FhkMd54XsRsqXNXktOXK?=
 =?us-ascii?Q?UAqcqy6NGeO3/L9toVYDfpYdsJqMM/FFlDYaF3K+riitsJN0qV6OwJZvbalm?=
 =?us-ascii?Q?k1SqeI6derxXAl8Tbs3K3OoIxaGZ69MOavwJlWpkPT0CSGFFm+mKdCXVkQhs?=
 =?us-ascii?Q?kdyKdLzlzroL0qUP3NS/FgwGRoNsZMk2nRD8axwlpMCwLHHNyx+u3wl8D0xP?=
 =?us-ascii?Q?X13YqphdVFafuXgEG2sH+l0VotNR21jVJ535YLouRUli6DXMf+Sr5XXVnSMp?=
 =?us-ascii?Q?j3wLef/yTNMmqlCwjV93appLE1LwhlolxUZg8SQ/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f70cd4-635d-4396-cdce-08dd93e46744
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:12:15.2927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAIb+jmgWUHn2KbSR+YIaO8tG0RcunVi6h0vuPM4clXy/a54jNYhViIhJM0I5ghK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

--nrmCbAKEYJqGwNX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Last few fixes for RC that have been pending.

Thanks,
Jason

The following changes since commit 834a4a689699090a406d1662b03affa8b155d025:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2025-04-14 10:24:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d0706bfd3ee40923c001c6827b786a309e2a8713:

  RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem (2025-05-06 14:36:57 -0300)

----------------------------------------------------------------
RDMA v6.15 second rc pull request

Four small fixes for crashes:

- Double free in rxe

- UAF in irdma from early freeing the rf

- Off by one undoing the IRQ allocations during error unwind in irdma

- Another race with device rename and uevent generation. uevents access
  the struct device name and UAF when it is changed.

----------------------------------------------------------------
Dan Carpenter (1):
      ice, irdma: fix an off by one in error handling code

Michal Swiatkowski (1):
      irdma: free iwdev->rf after removing MSI-X

Zhu Yanjun (2):
      RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug
      RDMA/core: Fix "KASAN: slab-use-after-free Read in ib_register_device" problem

 drivers/infiniband/core/device.c    | 6 ++++--
 drivers/infiniband/hw/irdma/main.c  | 4 +++-
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 drivers/infiniband/sw/rxe/rxe_cq.c  | 5 +----
 4 files changed, 8 insertions(+), 8 deletions(-)

--nrmCbAKEYJqGwNX4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaCY8jAAKCRCFwuHvBreF
YVudAP4rPnCjSZ2juLd40vM7QAQX+9n+Ye7SZvL+2Dw7FRGW+gD/WOGsEqPArFcZ
OJ7fzRky8emeqbn6lncC2NsGkvvb5As=
=vVg3
-----END PGP SIGNATURE-----

--nrmCbAKEYJqGwNX4--

