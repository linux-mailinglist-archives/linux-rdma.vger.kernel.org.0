Return-Path: <linux-rdma+bounces-2183-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0AF8B83B6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 02:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C033283F3C
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2024 00:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D38139D;
	Wed,  1 May 2024 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="INeQAww0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59996A20;
	Wed,  1 May 2024 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523486; cv=fail; b=nn27rv1GRJNFmwWtOb6yUJZQxmxPLzw95kdBEqEsqQ0AAlSXrxZEoloILDOtthRy/nyNVkqy/vVFnrunGq2q5apDslYn0MGYT/3rBDCsogffa/w5gI9iwImnQ+Zx68aRtvUPPnJK7RsZBVSNl0oZC/zH5s50m1Po1aQOMXaHsSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523486; c=relaxed/simple;
	bh=q8lBEVbKzZmLBls5g82d+3gvg5Zc4C7xN9TglS11vBs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ar8Xw9xLcyIcJ4ZpzZ4tffF9vcmTXbZ8fDwY67GBNzi17G9LNX6wCNSvEZgV9Ci0I0wFxvsfuDRrKHAaYUHwBSL+3xD0fSLco9hKJgnAJ/BWte/kHkf9ACRdjA4zyIxqoTXRlf7kM7Du9L/9lTibH9Cdh9Mr6W27XGlXhvT8qfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=INeQAww0; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wgcn/WiV41qUDNuH6DMOrrkOQXuA6N11o6lHgf3c2iecoXS3rrbMF4DH7TAS6J9pFgvhexo5gh0TYyhdDCoMuEWUAm/pfUElyh7n1I73EJ9elaEszN+WrnVI5rUwBfrZwC3zkgO0tfXyxgkNYI3gKNOGxjqwi+zaf8jxukSZ7N66iEhU5Zh7cB3ogU5hhYEf5bQ9t3ICmpBDwNYxr52uqYJNx3LaR/9WS3xwW5tpiXZUmqewymjCdW0VD6hTLcQX56bPLKud3qMR4HEwX4rfyqmSO75KohtMpqJMmzY+utLjSTsN5WoQLCln2fyMPJWohQQtIP4FtnR/O5C47PkgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2LgVUGJSIxGqIt845MEA68GeKD12DPNwOYOT71mnYE=;
 b=bgCGW06k+QNmLO/kVmCMYM1gP6VmOdvABwkZC3veFAFKcqKuAsDjL8LWwjt5oIrlIqWlHdFaKnUsUkJLKPA4gl7yNEMDKvlgkjDGhjyNMJNnMazRlZDJeI7LAuq5El0DUU1jmmICgmvBYCdYa1+x+E4SazxtQ8fMM2g+TiGRBqIUj7NPMw2JX7XxLz65fY/tzdkIhV8UwRtrIN3ZO3q9H0OXeSXwFLBd/zvJ8c88dUjMquAOSSHnqZmuokdfIMry81SasT1ucaF+8Vrf8Peh/lNA7B+QLKTVae0L3kyLtReol+3A6CZzc4uVzezD7dwjtYJWpDCqjUvfVjcdbYk6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2LgVUGJSIxGqIt845MEA68GeKD12DPNwOYOT71mnYE=;
 b=INeQAww0AGKcqZapeqGJyBofUL9mJZPoaxhCgaTEd+4ZSbNqBpWE/BXpICt0Cccf8L56X83VH/ISRcpf0y9haELl/rK7nlOHAUqbd8mdqhOIvN/A++PyWBfHLBM/MoY7SVdKcNQYN7hhF5mzT2TNhbWDBVC1frVkczh8+VVuFSVwL6gtz4X1EkyMEg2UtQ2zL+2FtjaAtC4TkPpLMEfOrhkuTrFJ1dd6Hd013tBafSwio1hmYy3B18csfJRX/cReAtX5j2L+1ZEWoXq4H8r7xmqOr0WzT8ePShDRkn7QtbGegGC9wG9b8Ni0hHnmP0zfbWOyvHH7HWX1ChK5oPvgzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB9075.namprd12.prod.outlook.com (2603:10b6:510:2f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 00:31:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 00:31:20 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-mm@kvack.org,
	John Hubbard <jhubbard@nvidia.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Artemy Kovalyov <artemyko@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pak Markthub <pmarkthub@nvidia.com>
Subject: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to migration glitches
Date: Tue, 30 Apr 2024 17:31:17 -0700
Message-ID: <20240501003117.257735-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d415bd1-c514-4726-8bc0-08dc697605e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bav24N4tm63dYodSlva77w/6UMGu1BB+IRxuqYLUttcqJ6A73tE2xc9mpFpj?=
 =?us-ascii?Q?A+geG4cuXplvX6bLl5TMLfqh/TwSzkmEWMJKl5JkVGqOR4El2yVYoLNkFdc3?=
 =?us-ascii?Q?3uogdOPZvHEnTnujFgAJPvQTxBuJMzvA/8ONpjTD1qxW8F85k83RDonM553l?=
 =?us-ascii?Q?y5/3wtEyuzTjbRY7NmL+6uPQYeLrISYdr5qvniG9khJuFHqWoVDZrcRcmF+N?=
 =?us-ascii?Q?9Mha+mQBxBfe2a8CeseFAnsbdUDdFANmAIH04BMnjfuDQwZh0H9aNt6gfOZZ?=
 =?us-ascii?Q?rlve+LbyTxQaEVjJc/2rZIsHYtPP26TpUWO7cxIrfPhLQ/B1dx8k/mImyJGn?=
 =?us-ascii?Q?FIgDMCrMBh7sMrnuebv9wwAzkMLNBtFfXh1wRJwdpFaXOLfYa+n4+14B6hp/?=
 =?us-ascii?Q?t7EcBEKWcF4+Q7jnTS/ReWGPjVXoEbfbm1r+sjrncSrH5qKME4D5MZICG4Os?=
 =?us-ascii?Q?S79yVDL1rrZDwb2CvouxWQwljQrmCOt1AHK0pX4iZ+6gfRhZexfMtbSx/osu?=
 =?us-ascii?Q?REhgtm4TprfxsFjvRKg3z+7DKelMQDPgkZ0McGyYrZGnC5yFSfAeDB+YpTbJ?=
 =?us-ascii?Q?p1P755mDJkL6M1bmpgjoPPAM68VsFJiF/yHGdv08TwxXEYNxZSiPCPJAhjJ9?=
 =?us-ascii?Q?qu1i2WBW7C0m7Cm8YFDESYLcXQuvu0mFgXjyIL5cWtC9YEJibf7xeE/Q+PD9?=
 =?us-ascii?Q?gvsLtiI7jPKKkxVFrAWHJTqILmHxxsFzSyqxZWVEfvNnyHJEZi1/UfcGME6/?=
 =?us-ascii?Q?XUFv+XdyEqnCq9vYHtFgLFfxmtJr34bHQu/02+PhAnD2bRwG9/Fv6rAVVBQ6?=
 =?us-ascii?Q?iy7mkQ9K4wxz2+gRg/o2O1XHzS97xz1nuw9y5V43qgJMN/6c1odeEq09N9+Y?=
 =?us-ascii?Q?tTT2afz9vFr04Al/nrTacGRxcQWzofN7suOIWVFo3/Hm6l7Cn7LTlPu40mUj?=
 =?us-ascii?Q?GkEWCLLPExm//WGjJFG/G2K/o/VH/6MvmnzHBIWdMajUnZjinAdvEbNBG9F0?=
 =?us-ascii?Q?1Oos4I5RAaVcvvBTD1HfH/B+lE3gq3KmLPJ2EFSiQWOF3ozwXqsFDWhQWO0q?=
 =?us-ascii?Q?XcxeN5hueAVaiyLLQX6OrqUvw120wQ/3jdK8ZDhdlVqSgWyCLYPDKpk0GKOy?=
 =?us-ascii?Q?3h2b11kXRHbzhs1KbPtTZsIw3ISKQbjOv1Ke5sC0PiDKM/4xAN21FpVVSQWC?=
 =?us-ascii?Q?CYM3iYoED+iKgDcDwLfSSpHMXiiUfAVf6j1BmXyQP1Y+OG8hI2i7wD64WnAD?=
 =?us-ascii?Q?mWTxCHcxjdC7kuxta2kJyApS7IBMuQeFCyq0am1TQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5H/TClfK3PD0hdPBo/i43hADtqwITcUpF9L26iCK2gFeZvT1dB6ocvYzylqZ?=
 =?us-ascii?Q?zZIjQAlg8ai2s8dKb/AvFhcWoKYp8jcjUL6ioEP323XoMFf2BT1O+9zjV/zS?=
 =?us-ascii?Q?9HPsUsMUficVSWgglHNhfjy6JC3T1VbqAPX8R6fT/+Ki/SqpPn4zwTp6XZ5u?=
 =?us-ascii?Q?XRzELVMt3dpml7n8MpMRq+0O6Jv++6h/UIpqKYlEid3ciBFcJKVTaRSn1cDu?=
 =?us-ascii?Q?OTeHto7VFt+G738uUDlkpQ7LwubX5TN76P1B8IJCC6OV2KYIds6nd5RfK8OD?=
 =?us-ascii?Q?/OLw1wtU/xQT56IxARjJfH9TNNFpXj2mpjMax07WXPLKYd8IKNmo0RotWyab?=
 =?us-ascii?Q?wdON/RNdicFOZmboirYQ2He3jz0fIPeT52FolzjfWudG8qMUWeFxq9r3JZtP?=
 =?us-ascii?Q?S9sskZmKXyf3XevL9XULeN8UzXTwZesXrOTBJ3wD7vY+W+gnGj/kpBat4FWI?=
 =?us-ascii?Q?7T1te/kdBQxD1vvaPFAgGcL/rCjYAyEp8ghTsoQpN4F532tH4gzT3m75tHEn?=
 =?us-ascii?Q?Znkch/RKul/xyynpwvPDEJUA7GpXTUjOTCe9nFBWoeNAJDXuGM17pbTyixF4?=
 =?us-ascii?Q?BBokSYgUGHWFg8xe28Xcuj4en5H0F2IfvJ6AoNHjQfeRoL3ScImMhCy8pH0P?=
 =?us-ascii?Q?ndBAlG0xZHXIC5hMCpdIFY8biKhHfifbirx/E2A8YUEnc2xtPU75zE2WZKVf?=
 =?us-ascii?Q?qYsg8AkHG/bPTYHD8XDNah1HLqvYsZ6Um1qTfJZITjrCxKsNinnge5iuwjaM?=
 =?us-ascii?Q?Q1+JJcclmZ8iu/0ZeqUo74mAuq55oV/Mh3YSLKASyJzlBFMsf3qjG/Ke6iQ8?=
 =?us-ascii?Q?z8uWs8RBn9517J2AUf2ICzkcxeubuExUFDGssAyMW88bhz2DQO45+3Uvu9Qt?=
 =?us-ascii?Q?3RPnjWCbYwcsJZrIe82AOfQ1IrrYZBsg2G4MC91/lpWkxTmP9BjEF6g2/MT2?=
 =?us-ascii?Q?+AfvPFRTwmj10BR5IzwQaTeTgRQF+1dAAEdZUQzmRBBePH1RBYHsHyFGhsfY?=
 =?us-ascii?Q?MQTJv8J6bjz8ujvIprMqMA/0T9PHzoUHw0sc2x4LZMhKgqRHh5YAg7LLfmNG?=
 =?us-ascii?Q?r1SzWD2kjevJYwH4NQFwdmBbEkQW4W1vmWZhYcJuWSV192sPK+xY4fpDhHAb?=
 =?us-ascii?Q?XKYhr/+qu0PaqwNKkOtwSG3oZqXgn7SFKQwQKQQvOpkVrIhNf6zeco7xsE+7?=
 =?us-ascii?Q?HKLK4yWGbQNC9dvxd+eJi13adqFym1oqrz6UYnhEljOUox1PFcps6VbWGmGg?=
 =?us-ascii?Q?ufXHaIDDRMc9R1WbUmq5xznLGqGmpW7F6ZjzYnuU1s18sMsLAzBzGmCm54P+?=
 =?us-ascii?Q?9f9qHjbDlA44B9quku25QdUPibrcNP7c6aW0S0i3SJhWa12KdKInwTpt+gaR?=
 =?us-ascii?Q?YM0Oiv1wYPAq0eOpBhPmAlHs8TbW7dr9JhPdymRaA5SzSyCEuOeVxjyGZtrv?=
 =?us-ascii?Q?d6x3OW5sLPtjDcaQvsTmAz3nKXlMwOoX2KhYO4+m7/WG9DL/5fU5c57xKklb?=
 =?us-ascii?Q?bqQYMRDnweGUZZxnBuLt5TvCGozxWTmyCJlsmVJ58rTIwCpl0MT4NnYOfRxk?=
 =?us-ascii?Q?FQyU1sWnFmcj6mLcgsigZPv33YWTaRbUnwGJC40a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d415bd1-c514-4726-8bc0-08dc697605e9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 00:31:20.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNzgy0MO4alX5MmJFOtXz3vXysOmGsGxNSMBbl9jQfOvI4LT2lgro3TdzIYt4wYk7nzbUODRPdIls5Yc+AZNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9075

pin_user_pages*() occasionally fails due to migrate_pages() failures
that, in turn, are due to temporarily elevated folio refcounts. This
happens because a few years ago, pin_user_pages*() APIs were upgraded to
automatically migrate pages away from ZONE_MOVABLE, but the callers were
not upgraded to handle any migration failures. And in fact, they can't
easily do so anyway, because the migration return code was filtered out:
-EAGAIN failures from migration are squashed, along with any other
failure, into -ENOMEM, thus hiding details from the upper layer callers.

One failure case that we ran into recently looks like this:

pin_user_pages_fast()
  internal_get_user_pages_fast()
    __gup_longterm_locked()
      check_and_migrate_movable_pages()
        migrate_longterm_unpinnable_pages()
          migrate_pages()
            migrate_pages_batch(..., NR_MAX_MIGRATE_PAGES_RETRY==10)
              migrate_folio_move()
                  move_to_new_folio()
                    migrate_folio()
                      migrate_folio_extra()
                        folio_migrate_mapping()
                          if (folio_ref_count(folio) != expected_count)
                            return -EAGAIN;
                              // ...and migrate_longterm_unpinnable_pages()
                              // translates -EAGAIN to -ENOMEM

Although so far I have not pinpointed the cause of such transient
refcount increases, these are sufficiently common (and expected by the
entire design) that I think we have enough information to proceed
directly to a fix. This patch shows my preferred solution, which does
the following:

a) Restore the -EAGAIN return code: pass it unchanged all the way back
to pin_user_pages*() callers.

b) Then, retry pin_user_pages_fast() from ib_umem_get(), because that IB
driver is displaying real failures in the field, and we've confirmed
that a retry at this location will fix those failures. Retrying at this
higher level (as compared to the pre-existing, low-level retry in
migrate_pages_batch()) allows more things to happen, and more time to
elapse, between retries.

Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Artemy Kovalyov <artemyko@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Pak Markthub <pmarkthub@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c | 33 ++++++++++++++++++++++++++-------
 mm/gup.c                       | 14 +++++++++++---
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 07c571c7b699..7c691faacc8a 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -210,15 +210,34 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 
 	while (npages) {
 		cond_resched();
-		pinned = pin_user_pages_fast(cur_base,
-					  min_t(unsigned long, npages,
-						PAGE_SIZE /
-						sizeof(struct page *)),
-					  gup_flags, page_list);
-		if (pinned < 0) {
+		pinned = -ENOMEM;
+		int attempts = 0;
+		/*
+		 * pin_user_pages_fast() can return -EAGAIN, due to falling back
+		 * to gup-slow and then failing to migrate pages out of
+		 * ZONE_MOVABLE due to a transient elevated page refcount.
+		 *
+		 * One retry is enough to avoid this problem, so far, but let's
+		 * use a slightly higher retry count just in case even larger
+		 * systems have a longer-lasting transient refcount problem.
+		 *
+		 */
+		static const int MAX_ATTEMPTS = 3;
+
+		while (pinned == -EAGAIN && attempts < MAX_ATTEMPTS) {
+			pinned = pin_user_pages_fast(cur_base,
+						     min_t(unsigned long,
+							npages, PAGE_SIZE /
+							sizeof(struct page *)),
+						     gup_flags, page_list);
 			ret = pinned;
-			goto umem_release;
+			attempts++;
+
+			if (pinned == -EAGAIN)
+				continue;
 		}
+		if (pinned < 0)
+			goto umem_release;
 
 		cur_base += pinned * PAGE_SIZE;
 		npages -= pinned;
diff --git a/mm/gup.c b/mm/gup.c
index 1611e73b1121..edb069f937cb 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2141,15 +2141,23 @@ static int migrate_longterm_unpinnable_pages(
 	}
 
 	if (!list_empty(movable_page_list)) {
+		int rc;
 		struct migration_target_control mtc = {
 			.nid = NUMA_NO_NODE,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
 		};
 
-		if (migrate_pages(movable_page_list, alloc_migration_target,
+		rc = migrate_pages(movable_page_list, alloc_migration_target,
 				  NULL, (unsigned long)&mtc, MIGRATE_SYNC,
-				  MR_LONGTERM_PIN, NULL)) {
-			ret = -ENOMEM;
+				  MR_LONGTERM_PIN, NULL);
+		if (rc) {
+			/*
+			 * Report any failure *except* -EAGAIN as "not enough
+			 * memory". -EAGAIN is valuable because callers further
+			 * up the call stack can benefit from a retry.
+			 */
+			if (rc != -EAGAIN)
+				ret = -ENOMEM;
 			goto err;
 		}
 	}

base-commit: 18daea77cca626f590fb140fc11e3a43c5d41354
-- 
2.45.0


