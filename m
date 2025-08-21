Return-Path: <linux-rdma+bounces-12864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A9CB309F2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 01:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E11C3AAAF5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 23:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E43279DCF;
	Thu, 21 Aug 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aMwiSoSu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DB026A1B9;
	Thu, 21 Aug 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818662; cv=fail; b=aqyDIGhhDx5fZ7VUZziXyIFA5Pvf72uckDBoYtLuqhPa+Upm4e8XaN6ZwmloLTOH/CbdwbZcB5h3BHYT7/O2ooTX9SFrpT3PWMFy+jqKwrBpEJnSz6xSk92f/UZlvTYVelCJwgXdDg5TmHxGE6su177xMDkYqkhtKuGhQ8npUwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818662; c=relaxed/simple;
	bh=mRwG87oJB7CaJKBYOFDegijFZLUHG7fPKU3alG2hpxo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=mQB9DtLTrCnzaTN7TxoNxAODb3/WeLTd2KOzkQFFPHGf9fqeqZfPlZsVVVwBm9sjiRUmS0LPJPQwYeWnEJ6nevgF+hlMm/dabnyBNrF+Rtve9bA8BE5D+dnSxgKG3kxKuYwpDFNYWaMTQgtxJv55+DZCzUhIPiwRFPtvhT6wZwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aMwiSoSu; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grDCSvOMbYwLrZYu1iwj1XslxvDjwzK74CKZnMXPw8DUKIXJRzzhO3ITObrfZ5ouopDBtOgUDZzmLBpNQhh34G8iwYsKCNtMJPwuOul77Oh66jjEddCo08v4ErDsYOOOG4KeTjRJa0z4i22rJxOlagaZp8Xn2f7bh1eiSIqqVAEJ5beI1SYp9Ily2rgCyyVhGoSU60X2+uscvdFr+QURmWzqO0ob2dsJGtPeamyHWTbqdvm/ulPI1U5t//Hx6sOVXC7yxvf/ramxznvWtDu5D1tIQg2GkJhKQNH39toulR5M/eq2wctnZt0rIPmj6dIX8R75tGtMytsRSggWCiK3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU4YteslC135hWJynJezct/32GE9M5mmF+yDTdGqlmc=;
 b=MuyHVz7rD8CirzG+0HIYD2GFcnxH2VfGw8cGnZd9hvggDByCA0uZVNiBHtmoGXooC4Tie29dEnSzlB1j3sx4LRBt17o3wYBbw0BBsssarSW10LU4rt1TplkcjAR22Ks8kTmSVfS8tL0qdQ3xQQARmFQr6x9XejM/CDl73tXY6Ax6d1e6yhyptmKjuAAl5Rmb3FNhz7UmflV76lpROQlepSO8Yr2tsrHcDQmij3Z7ZHAO/Xo+tx1ynIvCPem09B39dQzv6QdYZvOSOPG9kydrp7UnjirjupjIVlXqpCztqsbvFjK54/1WKJrIBFykBX3xULRH6MStXUX9Ub/PlLmKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU4YteslC135hWJynJezct/32GE9M5mmF+yDTdGqlmc=;
 b=aMwiSoSuAe7RPjRXLo9lM6DZBARkjrzfvhPzUUjBXS1N4Vt8hBEU9+fBal4bMLxhqLAPMO7lUiHH3zPexFhhfIH8Nv31s1nm192ojtAHDXmiJMDHi2UUzayyfEHOfy44jLYSWfFrofULuSUuMon2+BnJqSIZ8auM2U6ELZg+C0MnfaynwmhBf5wJ2cmahcdJ3d8BtpJUZlI3PDwdFMA7yS/7Nay5MSxLpE2nXMIk2uX75kRhLhdYKlWDoUe4jH4T+f1S1Z+JQCdmpFa0ahQODiUbX1zPMGdgsjX8oPGeALB+rw7Z08/Di90WSRupggi95hrTYx2SK7KE5Qt5Bs5NqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Thu, 21 Aug
 2025 23:24:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 23:24:16 +0000
Date: Thu, 21 Aug 2025 20:24:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20250821232412.GA1361976@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHmFZwxtXnE6XokK"
Content-Disposition: inline
X-ClientProxiedBy: ROAP284CA0210.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:10:2d::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c17aacc-d2fa-46d5-bbb2-08dde109d8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNxxASGgk9FfWhO/v6ZWWBaJ+oNL1Y34+ZUXmQD5qTRrtVGmsSK1z8o3+k1T?=
 =?us-ascii?Q?ZkQgRZy34p6KhczrMfel//40hi3Cgx/3SCJ4v4uK7M5NJZBT10kNAKGZ69RY?=
 =?us-ascii?Q?qV3hRb27VzJTMF6HwmYXhaupolnYChfDMrZIujXk9dQo6f8vB/2Nj4fmiKGC?=
 =?us-ascii?Q?TJKFtSiRaqI3bwJh9PQw4H8evIPNAsC0NKbLf1888en7fm3zF6BiIBkqX3TN?=
 =?us-ascii?Q?XWEopRTdMuK2L2elqQyyh+Al5iSa/DrTMbtIkSf9QCQnxS8ehZXGmY+LXirZ?=
 =?us-ascii?Q?dih6z9LOHDaFB5U+/FLPny/ZQckAayLcUlTk0Xpcx2dYwoaP5HITxLof1SAy?=
 =?us-ascii?Q?F9rAKZavdkhRZi+pqu96IIrFgZIyazFO3LclRNNhfK8yeywygAZWeLCh69bw?=
 =?us-ascii?Q?9KEhJiorAjpfnSRsE4AYs5dyr27KwVVLXdmWrdX3YY4j5XtaOMsmZmTX+Dbm?=
 =?us-ascii?Q?II5Hvxq66NqqKRMFwnhBZZJ7WGy1vNtWGLC3DVkr+ICqyx9qLTfXzpwoyfCO?=
 =?us-ascii?Q?azNfYYpbvOXA8zxApsddSqwq/zt6FovxOAYuVJa5EpoTilccmCef7FRNRBqH?=
 =?us-ascii?Q?aPCrvnQoG2ynt7voBTYcAKtwnleOpXZmNCS8UF6gZpES1Er8S1jvPlHhP0ky?=
 =?us-ascii?Q?STcIBdQysLlVYMak4Cb31nobFoPZ+G3fXI3GTEltiOXlkSAyI9mAQdlljp+u?=
 =?us-ascii?Q?YHMpLOFE6u5CN5uL4FvgOGpTF5A+V3LBV/jkNAoMnl8xIlV3Jfas4d5KYe0Y?=
 =?us-ascii?Q?iyhhJGOPJ4BcMtOgEqTL+K5UT21FRTwvKbEfefUh3pF8fLAhVlxIz+v68iuR?=
 =?us-ascii?Q?N34dZ6TUv11IDGeCHjRa9sYgNPDsc3WN/ogGVE62A3866mQyplfs46kMDiSR?=
 =?us-ascii?Q?I55g8Si+5+kAXg5zFTD7fk9Ia3xXL2WcRYN9CDOEJC40rRG/Pn9ljQL/gNGn?=
 =?us-ascii?Q?OMMxrdfVDYBEfRCbY0OTX8MpvkbCxnWdzsI9BcMoKBe0u/PNqy+Ynw77P/8f?=
 =?us-ascii?Q?Y4EmSznKz8zOHhO7uWZHio7RhDtGBh4n0JpMfgJkpKYx+2u+WnuetS0C3SAf?=
 =?us-ascii?Q?G0M5Rwm8GF/FTda9fJUb3ilmD0XiA1PgcukRI1IKm53HQ99A6Kky7fK2xRqg?=
 =?us-ascii?Q?I4TQyGjBCWMaAYFTmZDg3g+0TfV8EDJcFjo14eDAjWNO6bOypVCvXors3hhA?=
 =?us-ascii?Q?dU2Yv1Q299AydcTP/k2Ouj2hLaQWVoR/sez5Nc2jnsMYjONybMv2P51MIJZ6?=
 =?us-ascii?Q?j1tztEI5D8+Q2oijoixS4gX0wM9R5A9bNvALGoTs0PnZlDTpf8QCFRw56SZl?=
 =?us-ascii?Q?as4joCW/gok/NN6oxqGdcvoXYHwkhxqO9J9pjUgI95FM4Cd5A80PoBXUM9Ps?=
 =?us-ascii?Q?tO0XOAkktAFnupz6C4444RU9Op1H1Bt3IcfM4JR1K3L2bjTeX0CcWZwsr0Zz?=
 =?us-ascii?Q?SKmesL+25KQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmr886G8m6BDpWlSX0TWGicc8VmTneVbW28S28OqegSTm49L8tkzby7dq3UI?=
 =?us-ascii?Q?4QPeYae+EhtVzeHpJwn8jRbFYBtVcSvdYwKupeZ3YWCZfyATYWQBp45HxozU?=
 =?us-ascii?Q?mSZcGKCyyBjyi2duL3ib0j8okJsS4QPLPxCd3aDEQJVR11LwEF+gA8lyrahx?=
 =?us-ascii?Q?ShaHRd+kNnXG+mVQI2a/f4KYQ2iuMGQeGrLoMnZCYZnXp7axVZiFtzQnnARC?=
 =?us-ascii?Q?Q93QI3uYvyYbREPhqb3Z/qMQxpVVlEG8Oy3E+m2rV+KXGtaJLsl+U/PlNXZ/?=
 =?us-ascii?Q?S8VVn28HLmP4P6kKJEP8+3DGA/oUU3yROgPfRfmr9tIyRpZpbDzHiU+1CtqE?=
 =?us-ascii?Q?ka+GayR6bpeGtEEoxw35gb8Fhmm+xHU1z7+N81Rkg9MiDnFkX5IlqejuEbWO?=
 =?us-ascii?Q?8E3XGv0eYhKrJg/ElaYSCLG8ym7L7DdgXHnGi4+4Fm/0fnA4iF9GT99aZ4fq?=
 =?us-ascii?Q?E8gj5RSbKfFe1h0ZENcey0J2i+hvf/zSQANItU6xvHXPa8K4t81ngtB7Nnfo?=
 =?us-ascii?Q?vfIY3UHzsyLncGmbI0PvVrpWHPrYD4f6UxOJ6Gvo7ecPMeSiF1w4ESnve81j?=
 =?us-ascii?Q?thpSlgoDEIZXpaBQua3nRvud3JsAt8szwqVLPjAPif95HnRfZ13nDtgMR1yW?=
 =?us-ascii?Q?Y/xE7FG6DBb5YD4BbkOxdQCuygTfMHhJ5ErBYjyUZSOgu384AIgwoYEUnK/E?=
 =?us-ascii?Q?gJTL22M6QFaZeHIl/cADnGF9F5ofM7Nex455JGbnfW8UfWP9xzQX6r/2SNgV?=
 =?us-ascii?Q?BUewPFP0QFCecQhF54LQ1o5PYjfK4cYrvBhrFWqzvy0UjE2VMnBIgGjXknJn?=
 =?us-ascii?Q?cIt1oLqQmSkupvjj3FV/Q1KJ2GeHNAek0lrf0bn/RGqbP6oBvG3D7/KR3LFY?=
 =?us-ascii?Q?1n3dny0u998odfjjV9h+V6EMUNMWc3NwjtiTso5X3n2UWCJJHj4oIWyPrrhd?=
 =?us-ascii?Q?304w2r+fiwL5nCvy1asH5HYGVd1iIo9MmjXGuTUl0EIjvTUdqOz2txcoaDkW?=
 =?us-ascii?Q?WD/KWQpsy1ENn5hvaFt3gaV/Vr+aho9oK/xA/pr4n/kuOCM9X9jTnO1+zK3W?=
 =?us-ascii?Q?zSq8PaP2slSanAnYpbVN4uWQKgAljZzUdsSt9OVYIhEM1tPp5qKxZ7Wbtis3?=
 =?us-ascii?Q?lFbUI1byNXPBpaBX3cJxeodxqSEZHW/Ru3touQJ3R/bhUSNX9C+VoefB7Df7?=
 =?us-ascii?Q?0fFXRkBiAgveMVnfNAgwF0i9FvBG3q7lBZkcuX4dT2TnAf9qxw0QRmxHYtL+?=
 =?us-ascii?Q?cCy2TnP5106SVXZBCmFWUcDrbC1f7HiYXjNA9tkdmmsMgjRb/u81zoGv+q6p?=
 =?us-ascii?Q?RLI8rs1S6Xh0l9tpInjdoYhsxpbMNhzJ3o1vjWIZ9tuonUOnEd9sTbxt8x3Y?=
 =?us-ascii?Q?FN3WPVw0koXy6/6NOah9XOBAmxio3hdfjPHRgvdxblSBqBg1lu/vuF3nHyYd?=
 =?us-ascii?Q?Jh/QraFesCgt/AnWYUBtSHyhAnjYgM9gUtYBUgz/hxNmjwSoHe8rJH/ebzvd?=
 =?us-ascii?Q?vXaPm9jzbCm2ZsDS39WbgQR3uhn1Tb1fwP7s03SrnyhxUzxyHpzAvGj8JirU?=
 =?us-ascii?Q?DNlduVKdGYzquhFMtjw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c17aacc-d2fa-46d5-bbb2-08dde109d8bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 23:24:16.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNff2d8CynuSpN5PG2w+zbUIV0a3pVij1jjqqgWh5VSwT56RjeG1c6ai0Qj56Z4u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

--oHmFZwxtXnE6XokK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Minor rc fixes for this cycle.

Thanks,
Jason

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to fa2e2d31ee3b7212079323b4b09201ef68af3a97:

  RDMA/hns: Fix dip entries leak on devices newer than hip09 (2025-08-13 07:22:18 -0400)

----------------------------------------------------------------
RDMA v6.17 first rc pull request

- Syzkaller found WARN_ON in rxe due to poor lifecycle management of
  resources linked to skbs

- Missing error path handling in erdma qp creation

- Initialize the qp number for the GSI QP in erdma

- Mismatching of DIP, SCC and QP numbers in hns

- SRQ bug fixes in bnxt_re

- Memory leak and possibly uninited memory in bnxt_re

- Remove retired irdma maintainer

- Fix kfree() for kvalloc() in ODP

- Fix memory leak in hns

----------------------------------------------------------------
Akhilesh Patil (1):
      RDMA/core: Free pfn_list with appropriate kvfree call

Anantha Prabhu (1):
      RDMA/bnxt_re: Fix to initialize the PBL array

Boshi Yu (2):
      RDMA/erdma: Fix ignored return value of init_kernel_qp
      RDMA/erdma: Fix unset QPN of GSI QP

Dave Hansen (1):
      MAINTAINERS: Remove bouncing irdma maintainer

Junxian Huang (1):
      RDMA/hns: Fix dip entries leak on devices newer than hip09

Kalesh AP (1):
      RDMA/bnxt_re: Fix a possible memory leak in the driver

Kashyap Desai (2):
      RDMA/bnxt_re: Fix to do SRQ armena by default
      RDMA/bnxt_re: Fix to remove workload check in SRQ limit path

Zhu Yanjun (1):
      RDMA/rxe: Flush delayed SKBs while releasing RXE resources

wenglianfa (1):
      RDMA/hns: Fix querying wrong SCC context for DIP algorithm

 MAINTAINERS                                   |  1 -
 drivers/infiniband/core/umem_odp.c            |  4 ++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  8 ++-----
 drivers/infiniband/hw/bnxt_re/main.c          | 23 ++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      | 30 +--------------------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |  2 --
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  2 ++
 drivers/infiniband/hw/erdma/erdma_verbs.c     |  6 +++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  6 +++---
 drivers/infiniband/hw/hns/hns_roce_restrack.c |  9 +++++++-
 drivers/infiniband/sw/rxe/rxe_net.c           | 29 +++++++-------------------
 drivers/infiniband/sw/rxe/rxe_qp.c            |  2 +-
 12 files changed, 55 insertions(+), 67 deletions(-)

--oHmFZwxtXnE6XokK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaKeqmAAKCRCFwuHvBreF
YWzAAP43HvKMbMx1rL9YMRP66iX246xe36ZUc+C2IbuiXLDpqwD9G6J4WGjqi+Ya
AZNNDtL+Jc8mFbXXGy5Y4I+hGsE4OgI=
=Vdy0
-----END PGP SIGNATURE-----

--oHmFZwxtXnE6XokK--

