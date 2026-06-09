Return-Path: <linux-rdma+bounces-22017-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rg0RJ90OKGr59AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22017-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 15:02:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2366058A
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 15:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UxHy2Piv;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22017-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22017-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAD3231BB304
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D22D42316D;
	Tue,  9 Jun 2026 12:50:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B10E421F10;
	Tue,  9 Jun 2026 12:50:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009413; cv=fail; b=tYsYcvuGg6CbKZ4QO+OHEXxSjdShPkPkzkFfHsfkEFsbuXmYTVxWiUak18+uCivphWgIO2W95ebx1GD9pvk3I3NikdPYFZyFtkRr7HiDWheENxjbo73vT3MeMgpZCoP7WA8hbimPHTnPBu8BcsJKf+uxS270bUgfQDBY5Img6j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009413; c=relaxed/simple;
	bh=XH8BX5GDVjj+IbnjciomJQOlbpJxCZi1VkDSn+nJLQo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hLulQXU9C/QfhUYo2pEY18hh3Dlfcewvkdj8jhYwhnB5Aq5473HQYglr2h/BJAxLjfcpZ2/VQORTdO9FmcxxXXF7OrdnSj6VruLON/Cz9N9pGaCPcDjkrlObyfvQ5zCPWnK/5gNHWnzMgv253+7P7kjLg/8HZ7FAafkN/9pNGPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxHy2Piv; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZ3O0Ft1UEzrvv17tvhCgvoSBhnrvBgQrMmCQk4XmlQ90XQFbyjnUxn/eTLBdzR8uzBb+B06xQByvYy1WI5NjrPRZA61KlVDq6a/mC5LPn8B2JY2ZUwbLlaDo4NvnT7X2frQkSpdGe/SLvFpsAZ8ZsAb46/GMjrk1OpTDh3V/QoX0fpVrohK4DkrVi1/BEaJOWv6W4jKsW+jJaRIq+K/Mf2lTIHhfCmVwnGzVpeknd0ojfleIciyeb1+R0k7g7PRy0Wz+dWGX6pjJn1pZRjINdk06cf+Ii+3subDgxjFOviRMTILHDo5us6Dkf+UZwsGFZEHIGRLkYSOJd3xfY9nTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSR0bbeLDVJASq/H80ihgXL1fZmrAfXO20B7qPDWn5U=;
 b=x5ytKfntrgGropz5COwW8qKRqtz3PC/k+bXZ6Id3uUlbXYwhX+tfPx3aW1y9klDPiE6ImkuGDJJ/ogSzIQDPlOCq8XubUkIDGg40moSskSsauDksdqHfRoZA0qob58ZHPDYFrLxM5QDD+JuvrGy1mDznTijbn/UTRsVuxhLYXwz26LPzl6+1ULR/GnaQFG+sX3c1DVBOMRmtoeP+l/B7iXbDclzxoiGipdowLRj/E8oKwKogOmZJiOUnBIKunZSAfSTZe6umgfbpcThs66tc2BZjeC70bOqBHLDSMWurrFmGpiCZSmhsfI3i6QJJ4sJRug07gplG9+YGsjtoqT8Nkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSR0bbeLDVJASq/H80ihgXL1fZmrAfXO20B7qPDWn5U=;
 b=UxHy2PivUn4JQAKgcjSCkEJD2qiPby+a0W2IrvX6lb7dd7ZSsoRLdA1UcFao2YHNI8lRZZOpRpuftAk7vSTW8ROl+9QERuruheuZFLsx8PRqpJowpsCRhzWF9oJtOb3JQx5yQPnKofK4QK5kKAdwi2v6HuUlpGzNDX8xz32htgkFobOpNjJlOeNXpQDvRmVrelgNNaMTCJjDqmfW40LfoQ9Uz6Q7ly9v2xqhDm2ct7qNoz8PN+eutPX5v2R7kyY3FSRSJ9f8RFRcItWkgbziztFhJMg2Yv+WrjJQuqsSQy9X45JibZeDfDJxoSbW5tjDTAg8mVonI6APB3BfqqseSA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 12:50:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 12:50:08 +0000
Date: Tue, 9 Jun 2026 09:50:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260609125007.GA450183@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciswxa8QyaujiWE+"
Content-Disposition: inline
X-ClientProxiedBy: MN0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:208:52c::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 2136ba73-9f17-4018-ed15-08dec625a2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	70uKKBHe/CSBmmR7tOK2hWZB4E15ZL785ynUZV/Tnyw4eTDQpk0f9S4HvIOy6+fe0gn1xCu/qe8/7+PU2vm0ChTXvPWSTJbqp92H5x38xgJNJPu7wkvW57KLYoFkiJM3OvhBj5J5zh86iIDKrCOjC+Ic1WWcX85ktIKLAQk5jVfoOZIZf5CMf+yGk6Li1dwPpAl4jp5fZH7XvBzK0swaXfoCPmDb9Qc3PE0/1sOzfCLWYFKFkJ5wKrkii5UHC0kRF5/bVDD461XjNMnEw2xpIsDvuilqxq7/875OGbt23RQw/TOBf1x/cEvCvXH3K9nhO4IiTu3XN6T0i6E4Ln8qpq3y+l5aNJ04UxxL3YdokDUnZMDprhsKagAGeay7Lgliuii3dgxeDBM7iVdReS24mOeGONcjHFuftlaqWkGKNjm1UGK6hvNzVhQQmUuz3c6lVWsTRWTSb+5Ee5fP0S4INJDprRlD0vyT8u3g1IIW+u61+bYMsSIpsBWmIOj1k9H1EZ5WpcnF25ywgJQ904ILvB+jzg4uKE8e6ve2DhUKeu0xiE429pZedXnkFOED9uSdlNtV+RBvmYHmQLOW+QKc0u9ZdsvDgIo72p6hwac3OiExLIdcx5dPHknCvZVKHaLNhEo+prOBQucpwiGTNMNvQDaPJPEd8/1mh8vA2Wqi+lfs7Wa+z4xBbMdUzUs4A1Do
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/hv43bNjuPdaI4YEdjoJ7kXmezZ6i7EJsjSMj7N/HErTohXECPq2/h8cGLk?=
 =?us-ascii?Q?Bro4GppKA2LOtNqZ7YpMhnhcML7J+xvPAsHIDfkyeiOVZgPAH+kamHgVv/Le?=
 =?us-ascii?Q?vwJDGU7n5tKF9pZ6MSG52G0XIDdfdwRiDOXqOLZnZ1an/5929+HJr++hu0SI?=
 =?us-ascii?Q?Lr5BYzP2kQonKD3gLHVJYkNfpvnUXk5eJQiwa6spRiIx3r6vcHbD8a2K8R8V?=
 =?us-ascii?Q?7uyXh/WOUS/EiMyvYNyCzWqZyggrglcrddgPDifDytGG492fMa6+niUxaS3k?=
 =?us-ascii?Q?MGP6rdh//WeCR9H/V/YwtMVKUwZV7QkMoj4kAyBCUXILUMQ0fnJNAYydvZeQ?=
 =?us-ascii?Q?Y2wC3wFCp24e9GLhwCLkOF43urfAWh/w4CRgnL4WJ4OUIc4dD124SgLQh6Ld?=
 =?us-ascii?Q?HLREv2NjxkuBvYbPyHp802lJhBeYX60HYqaFLWG2cQaXJKraTJrhpj6V51Su?=
 =?us-ascii?Q?rNMXxFJ+NNjroedez1ddBFKbZTHlDMPTc0kFv7tkFdf5VVkQANas8fSOyPhZ?=
 =?us-ascii?Q?WySkHg0Vvzaye8zrapWEt6mJvzvrTIADMuTQFavMvv6PIJBUYxwSrH+8d7gf?=
 =?us-ascii?Q?XYc4sH8k6s0Hqqwv9C9jEKsd/xY91o+EK3KvTcSpTVt+1JB8lwracmyQyENQ?=
 =?us-ascii?Q?6OywyJu9S7NAY0a5cxRjZH9HmnCxXYES0cpmoGtBPc9MQejXTxguX+/RZJUQ?=
 =?us-ascii?Q?3lmRWmGdHADhdz0J7K7AL1GRWLiGY5ksTGMxYUfyVjhB+K7l01hu8qO99bTp?=
 =?us-ascii?Q?YaJLMa5K7JAxrjyMSiYgz3OtJonKZUPogOEOvIyD3kXLdhEF9iwMQtYjWsHz?=
 =?us-ascii?Q?0D0EgohtyHchFRimNaImz/DH2/xAic0uzwFfL9EL8ub+yr3A75gNT2XZAljL?=
 =?us-ascii?Q?YcOnk1jSDnY++/SbSa/3c0DE0jjl6WF3yYzgXCDwz2k9BoDYgKxTDJ8bqtnm?=
 =?us-ascii?Q?DrIDexP5vTdtA7/e5iiCLQPNpaWnRadEbGrh6/hC4IlYGrjYkF4pkciowlqq?=
 =?us-ascii?Q?GKafqeKvCxfL/+lH4htm0CjLRPBP0dvDFUHjydN+6Dxze1i2XLAQaOZkQX0Z?=
 =?us-ascii?Q?tz0IVt3KDM6qLTKPdXOaE089OKnePD5SYJTjyDUOx/dPtGZ+8UlRhkwiK2Vn?=
 =?us-ascii?Q?9CvzHLS0JLcxxYIg0kCWyav1EHVJB+ANDnsvvJXQBhlndwqzwjR/p2g0J404?=
 =?us-ascii?Q?RFKUh6dgTF6YbQV8GB/9u5VqvML0U4bEJv3zRpGUAJN7DAVcMROlDNTnepvI?=
 =?us-ascii?Q?AOMNotDEuqtr0TF8r68MvQ0IhwJmtXhwNrCfzg4+lYToAOrdVo//l4kZTcr7?=
 =?us-ascii?Q?sZ8syBiXkZS/wI92/QXpZT2EoGZsf3hzA//iq5ijwjRfKsXCkFsgoACy2jIg?=
 =?us-ascii?Q?UiNmrOi+6DSYDGsw1dXANeOycGkzynojdDi8z3r+AGtqjwUjXYzoSWRL0ocI?=
 =?us-ascii?Q?lIXn4gy9upLDp//R/ZB4YHou9dS/DHI4u1iitFYx9DtjQtQNFY9SwJtJIU4q?=
 =?us-ascii?Q?duOVZuEb4y+woRa68N3IJwqwUFe9fhxXa/8mnJ2U4pHVF0OQudhex9WVwyb9?=
 =?us-ascii?Q?DnPSWDg/UHcs0WbcvCmvZOoQAj1feraDZvS1rWXT7Hz/uIiCESM1koi16HxF?=
 =?us-ascii?Q?zCRm+xRw7cuM/5QoggMGeg/x2P8l4MP4jJqMwccbo3M8IWoZ/xm4TUCSWpve?=
 =?us-ascii?Q?KjfdmQk0mDd4r99kQr1Mggi1ZLMHt7ZIgSweBQr8aaNs0REb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2136ba73-9f17-4018-ed15-08dec625a2be
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 12:50:08.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiJOODb9FwpsUTYeLSe0AoQYqtUE6leyq+Qu4cz7ZYpNelaFJduBKVNPRp3yU/UH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22017-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[Nvidia.com:query timed out];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leonro@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-rdma@vger.kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AC2366058A

--ciswxa8QyaujiWE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

I don't usually send rc PRs so late but this cycle there are some
urgent user triggerable bugs that should be expedited. As per your
request I've been putting most of the discovered bugs into the merge
window stream, these ones stood out as particularly significant.

Thanks,
Jason

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 13e91fd076306f5d0cdfa14f53d69e37274723c4:

  RDMA/srp: bound SRP_RSP sense copy by the received length (2026-06-08 13:43:23 -0300)

----------------------------------------------------------------
RDMA v7.1 second rc window

Several significant bug fixes of pre-existing issues:

- Missing validation on ucap fd types passed from userspace

- Missing validation of HW DMA space vs userpace expected sizes in EFA
  queue setup

- DMA corruption when using DMA block sizes >= 4G when setting up MRs in
  all drivers

- Missing validation of CPU IDs when setting up dma handles

- Missing validation of IB_MR_REREG_ACCESS when changing writability of a
  MR

- Missing validation of received message/packet size in ISER and SRP

----------------------------------------------------------------
Jason Gunthorpe (3):
      RDMA/core: Validate the passed in fops for ib_get_ucaps()
      RDMA/umem: Fix truncation for block sizes >= 4G
      RDMA: During rereg_mr ensure that REREG_ACCESS is compatible

Michael Bommarito (2):
      IB/isert: Reject login PDUs shorter than ISER_HEADERS_LEN
      RDMA/srp: bound SRP_RSP sense copy by the received length

Yishai Hadas (1):
      RDMA/core: Validate cpu_id against nr_cpu_ids in DMAH alloc

Yonatan Nachum (1):
      RDMA/efa: Validate SQ ring size against max LLQ size

 drivers/infiniband/core/iter.c                  |  4 ++--
 drivers/infiniband/core/ucaps.c                 |  8 +++----
 drivers/infiniband/core/umem.c                  | 16 +++++++++++++
 drivers/infiniband/core/uverbs_std_types_dmah.c |  5 +++++
 drivers/infiniband/hw/efa/efa_verbs.c           | 27 ++++++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_mr.c         |  4 ++++
 drivers/infiniband/hw/irdma/verbs.c             |  4 ++++
 drivers/infiniband/hw/mlx4/mr.c                 |  4 ++++
 drivers/infiniband/hw/mlx5/mr.c                 |  4 ++++
 drivers/infiniband/sw/rxe/rxe_verbs.c           |  5 +++++
 drivers/infiniband/ulp/isert/ib_isert.c         |  6 +++++
 drivers/infiniband/ulp/srp/ib_srp.c             | 30 ++++++++++++++++++++-----
 include/rdma/ib_umem.h                          |  8 +++++++
 13 files changed, 103 insertions(+), 22 deletions(-)

--ciswxa8QyaujiWE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaigL+gAKCRCFwuHvBreF
YcciAQDNoT4CXA6/05nXQMFu7Ikr8GDa8RRRhzSvPH/dBG8f8gEAvK9VnR8bOXru
2AjcKnFTiKDAMsfffXqw+i7pwJeYhAo=
=a/gW
-----END PGP SIGNATURE-----

--ciswxa8QyaujiWE+--

