Return-Path: <linux-rdma+bounces-19807-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGhjBsXv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19807-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:11:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B54554A9290
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE8E306545F
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA11A13C9C4;
	Fri,  1 May 2026 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XmfQcuQg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24527732;
	Fri,  1 May 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594136; cv=fail; b=P5yilgCJwow1Bqj8WKn9GG/RYAVL8oEVNDYBhiX8OyL02dl7+UX6QgE0Dx0YrX6LBQUMv+O4ppg3D9dRNSzPgTZ3ToaQ33I+wg0mJE45l7MO0Uk3qFc26UWIm4IQgvABC8ilUrXkChbZp1XYSsfNZVqz2B7iYDS8l6oVljjfOJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594136; c=relaxed/simple;
	bh=jPtcJEny00JETsh2WIAML6GY3epHdTvDTM8hS+KS/D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uif+w9maXn2wmhMe/Upwe5+d5bUUvETnuNnYnP6gadJdKGqGIL3Jt5LqFcUiBykBUpX+i55k6VZL2vNGw3vOsZwjWAispLPjleHUMOxJ/Bj0dNgx5n2Dvn4Fn+mi71T/2AOd/VBRx83WYLMFYeugTyI3+oGNIJ4G1ZtGevFaud0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XmfQcuQg; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuFBdYWXV4yrwQ4s+f2YqcZbzLh85mTlOp/TgqpUvDv0s58mXZv432FRSMeZXSf4Q95zeS/fDQgFEvx/x2zx5iLcssDrkSJFOUb9rBDw3JOIDtIJzBHo30E6BXOn0dZ7vLG9yL+g+hJbGpP464qRyx4atq2I9kvmPDjXqIA/qPmWDagCXxPT5H0sy9c9CNNz4vFF5gqwm0OI8PiaTlV0rDEsP5l/twHx5ryhGtZzLMjiKbAd+vaoOZIfmh1QCEyf9xkeDe+dFHU9zHLG9OmwHDhdqMcTI9YVHGdttm4xEZdxy2tiFyWrgnHyCW3nWN5eIQxBqcT64x6vzn4tr898Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JZRDS5dEbrYkWtjv6mM1oK1IM3sheDdgJm3RvIYq9k=;
 b=Fjq++hXuhNWwODzF7u2zkgV2uUybA8fVvb/nSMYvonG3af85ypcM8lE49jLG17ZuNM0aCfkKnupTSr0igaLghAdftW2saw6UBpfzwi/DuIx3ijCg2mdkv+mEhEEbwPRj5C713xP+JJ0sVQxsV3IQVpOXZQPZ/r2gzmVI1kWdVIRMemYjlFmOwdtsKvkDOLROm0arzghFa9GgEa6VXs2paNvgBrbROPQOi0qtT8YoeNqk6AxBZwysKo7UxsH5bWeEoEt8ZLJDVsV+Npg/ReoYfHQ8ERfa9i0XI/OpkRh6XjU+jDVcFVIaaU5TOI3Su/S0yey7QpRR64Kw8i/CCLHkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JZRDS5dEbrYkWtjv6mM1oK1IM3sheDdgJm3RvIYq9k=;
 b=XmfQcuQgiKCtBALXcGqZTIRPb1tntAPccVdD489pTjHvmV0ILZMhn/v9N4+jc+FBkQEzm4ZEeE4cOFHtIsYDGdYAM0FwwXpqXdKAfOT90QMP3QQmm9+vJILU+JEf/K5UjsQa5BxLO+YaE3W4ccluSuB99E0kw00SsCDtFADOihw1L5um/BXAqHu90PnR00++MwXsrSonmhHHe/JtBQcc16ruCgufxr3Kaz6B7clyD1SrVrvRxjZSz+Qd1mPhRXVuIEOavJm4YWkCB6LVPwyOLuU9oKxz6wK+p67r6mKSBohU3jw0pxUIA0W9Znk2fzuDk3DIL8m/7q+gPtZ1zaQWAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:41 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 07/11] vfio: selftests: Allow drivers to specify required region size
Date: Thu, 30 Apr 2026 21:08:33 -0300
Message-ID: <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0061.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: 832d0314-f222-4305-cea8-08dea715cc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	V7cte1WwbSHsEHkxOVADPMRi6iLF1wEzlp3o2Z8O+0HSfPf3oVr26r8NwQpurIt18nMfcVAoYUcD6dJY5ZETKjM/E7O5j0+dg6jVRdYLqeaHCZ5bOMPFb95EvPmJ5mkyyxG1lx27gQdSc9/HIX8SgF0Z5OQoA2OYq1w7EsIeIIvynoWqLORC9153TT8oUBftpU9Jztp8jTXEsSVt+rrY8eLP5/vUizQ7c3njIzMYGfIDk7mMPkKX1dTJ2uB75aR1sBS6HfMOttY/GlahjuNCjH5MPnohGa45Ty4a75nbdtutwWgQnAz8QuJhN0XaMX6IQywm76QD57wbNak1XSJCZImgBO5HHFHVqUE50RwdVODFxchcb+R23oC6IObWXeX9QxBa1cIBlNo0Ax2Thjo08YLm6VW9lVJ2TktQ1/zWNg/E19QDT9ZgNH2fh3Wy2KDR5uLXvS0vXJxQVUlq2ACyCBSIrgm7ouzPAe8R/9EEL9HsWcxgV4xWecJcMF7SSPzdcIUyopwDZ1zCakR/98eHS8WDdDO96dICPzE0OmfkgVnFwq0nHXBAcVAW/yBaDd51vjKO03q5toWmytOI/YceCodr3s/fmHiU8eEU71oRXXzDqI68D3LFqkHm2L7vJs5N/gmvo1SfWmVNR8Vz3m9eOd9i6Agix89xYqN3XiOrv1yGkOIMKqF9hYW2H6gCQl8uicUB9rllpJJBR9q9Mjr+wMtCatjSTl8eKKvD0jcZTgo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SwEkcP7WUSGH+gkO6wOucfKVEZgI+rnaPrp8kDSdUwQwrsBeiHDvIPvF0xiF?=
 =?us-ascii?Q?QKtzcht/4PFfHbWwH315XHBSbEymvQ+wgQM97vtsUFoDs6jj9Gy5y7r/2Cyb?=
 =?us-ascii?Q?F9JyXPYjtpPNzysm7qGUCR84CLDuL4NAySvwCrhno1DKSGNyQS+hz35R+Q9Y?=
 =?us-ascii?Q?T5Oo3fP2Jxb2ydVeiTXiJy3KeXfAZybLUPSCi5JX8kg09CPUK+Wt8ktZD5lh?=
 =?us-ascii?Q?K5p2zlyx15CXM26rxkr6CsL5dk4KaYq2ugPs+KXwZ0QJ1gzISoLjJTiOZZHU?=
 =?us-ascii?Q?1A1y/Uj6yhOC3yiZkJwX5Tuqn7OKvW8lD3ZgKqLicvSXW6kVhJY0Es2/BTyF?=
 =?us-ascii?Q?orynbfg55JI+McWi0xyFnnZIJkMx7NAr4ZGRPjjia/lCLbi3xsOA6mHvAC6b?=
 =?us-ascii?Q?BPlMjjpePyvgM8BrkbV6ztbb++uadqNrmSjGrkS+gr7nWQBPRZlUQP1zXu3F?=
 =?us-ascii?Q?WZce8I58m3EhV8OMvmtnxftr7Kxe7KBMzYUjGJGN7GvbjBJJKrlSXYFGbdsf?=
 =?us-ascii?Q?OJ5Il06wBMZuzxUz3vncs9fb4BqANFneOqw9PaGPhTqQTn0b1OpRHdRZKfZb?=
 =?us-ascii?Q?+N5xM1qzKE1O0Dt4mlAcwfVUoe4wDOC7c9ywoFiHFtnzSqODJydpIZM8BSGt?=
 =?us-ascii?Q?quuEoQ3CNQ+hgV3OKw79egHW75w3+dbzVimSOnv3YVzzUUBtlcQBsRJVEyp4?=
 =?us-ascii?Q?pyVfbV+CIYjnh8cCtoFZD2eZqJMmh8h4IpeWgSNMZMHrJ2PybRjZU7anSpxo?=
 =?us-ascii?Q?d7fLmhTiYWLCR7b2s1pFjdlOXb8OIboQ33kQtgzd8z/d1GYA3GwBueL899mk?=
 =?us-ascii?Q?G7f3RStWGQw3fh+Kdtkdb58Za8GVRlqbEGUmh8TZe4Em9DgPxCRtQvSl6pO8?=
 =?us-ascii?Q?JeM0nnrvEShN7f6pUCdSIMgKsIPVZ/bzzw0Po7ZuDPiDjKd1oRag656FYiJf?=
 =?us-ascii?Q?YPXUdLOBReiBBx5uVAxMz2RCHLZT6k0UzER2PnJLgCjvWiXjYDzaRs5O3OcI?=
 =?us-ascii?Q?A5w2gufmxl6aqEWpYDAvt9kyu2tx0dcyZ9YKcpvQ0JClo1JT3W1QH/Z2Sgb+?=
 =?us-ascii?Q?rRklasxqRY7MPnLXjFYvFGjB/CVQZNfqQMWb5Q0/xBUtpbBbrT9noGZts22F?=
 =?us-ascii?Q?28tIhojHk386Zc7sjFAQCxFJ8ANQ+fi8dIvdfjH3hHYbsd4mZpYIc5tIeL9r?=
 =?us-ascii?Q?3/jBkNRZ4ih81tz8hA0QfcEeK2EhwcAZAKZaqOLZAoJSsUuuzMxSxoFStLgc?=
 =?us-ascii?Q?/AYr1ROdqTe4T5SZ6/QQp+x/RAWDGCGnB+W0OS0LHHUF/9lFXcy5V0PCpEjP?=
 =?us-ascii?Q?EGc8N1m7XOmFAichrx9Ovcmxx7ndODzRPJCOVx6KiYL5Ee+VlsCVzYcfCqob?=
 =?us-ascii?Q?IHyPbiuqTqyjwqiYar6QcgriDj0cyucSKozXvDwsAKzvtG87ALsZ78aGhOgR?=
 =?us-ascii?Q?ASf8CmFF4OKkWaCxVe5lE3mQl7DaDDYGJYBGAVLl107d7h49+TDGJGuMdEQ1?=
 =?us-ascii?Q?YJ4bDjxKmfXicaGugFJsKeD5b67VHIUTUCrPuMnsjmxo39VAAB9C7UWHNpwU?=
 =?us-ascii?Q?4qm3DBTFECd6GIhKIgEocjYsSvwMLRLcEpmvOREac6B5QVBUq3HZ5Dmxv+Pk?=
 =?us-ascii?Q?kwNtQCjcY0k/YXT6l2fFCoW5MqzwVvMY5Sxxm11HnFIkpGXvB6HloTucnWZu?=
 =?us-ascii?Q?wawTF0sb+vARRG3jgil3jL2EQIJ8OidRxd62ssiUBM4oiyAH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832d0314-f222-4305-cea8-08dea715cc34
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:39.8933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra/+xMzyNHEPy5NMs4nS4vzEsQ42L8ytjtzfZqdXKYnmAPe/Ebwkd9cDMPVLy1PJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: B54554A9290
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19807-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]

Add a region_size field to struct vfio_pci_driver_ops so drivers can
declare how much DMA-mapped region they need. The mlx5 driver will
need ~18MB for firmware pages. Existing drivers leave region_size as
0 and get the current default of SZ_2M.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/include/libvfio/vfio_pci_driver.h       | 3 +++
 tools/testing/selftests/vfio/vfio_pci_driver_test.c            | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
index e5ada209b1d102..fa172635632453 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -9,6 +9,9 @@ struct vfio_pci_device;
 struct vfio_pci_driver_ops {
 	const char *name;
 
+	/* Minimum driver region size, 0 = default SZ_2M */
+	u64 region_size;
+
 	/**
 	 * @probe() - Check if the driver supports the given device.
 	 *
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index 761bf117d624f8..97eea34825f88b 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -87,7 +87,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 	driver = &self->device->driver;
 
 	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
-	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
+	region_setup(self->iommu, self->iova_allocator, &driver->region,
+		     driver->ops->region_size ?: SZ_2M);
 
 	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
 	self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);
-- 
2.43.0


