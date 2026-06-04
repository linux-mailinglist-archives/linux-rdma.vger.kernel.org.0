Return-Path: <linux-rdma+bounces-21718-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NIcxCrfUIGon8QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21718-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A19C63C31D
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:28:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=rFTRGcpk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21718-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21718-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A436230209C3
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB63125B08F;
	Thu,  4 Jun 2026 01:27:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1E23ABA7
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:27:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536477; cv=fail; b=ZHcPhXfPFfVfThGv7+BMHWOP7evQtV5DNCU+onV0Enw/FN7zn/tkLqzsOi4V3emFqfcpMoysBzPZUvwb/CxOeeU9MPEPtsAN09aTm5PlS9Uxfdwb98EQPnf9Kk3uFLePIsgTx9Uak7QH2UHKujfEN70iGhH4PSizVP87U0jWq34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536477; c=relaxed/simple;
	bh=AijzWbqGaF8q1GgWxXSAFkt11GnwcD3QKiLp9KwOeMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PeYRhoxK1WK1+Zv7WwD7VRQPKBl+aeeFnUWjj9cN7WI0Ro4Zxb66VzVpnqnVy9h2k3cOYisFmvofEr6QsjfMIAVNzu7+MySX4OSiDolmx+6RSuArTKhYqtDLVJ8oLnWiczAq70au1OnR71aTmo+TNJptIQ3rP53SgxPgE0/zrC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rFTRGcpk; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+elCDr3ulsBhq5dr36C1c8s4t7iJ5HdXahTJuuKRqyalPKLbX6EsyJYbGXV8bIO+WVKCbHTZ/UJQ9KXkEf3FB2QuQ6OSuVNQCBOGFuYIAL3zvCWE8FTlzvM/0GcqekGmPvMlmeZCqp7OZyCE/YCgZm31Af2m5yHG5YjQpYp5HTNTtX4pSpK+9mQ3ExKdZvqgTAa+usxa8iBg0cTY7TVVDzAqvRAlhoruEDXGlqDMpmai7RlWUJtTgUt5QQn0jkTOP4JQumhd8y07dmScW8RuOgcu4VsshRyVofk6OcHHM+8x5AUiMNYjWohDqVhn0SxXSw/8DiwAoaNhgdaOqNzYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBiYiU/SOAHP++A7wGzvnPp4COxwp5aAusg6SAgWZOI=;
 b=Je1qVUA8iPdL+oMFFM0tq8ClJH+jN4lnJy48YhcXWe67FqqciWBVkczMNu8ueaqwkCNt+U4rbsjuIV6Us6vffqnZmrlny7zgHGNrFh1H6U+OTtQHx4w6DQY7YA0KSJUK4HO2Ad+w8xmQ+Fo/y2WCqHqfigWoRp/yNS9/NFmtvwHFOyaS38nKiE0ffuGrQn1/G1/c3vgdI5vLTAAGsgAXb3yLA3stJngJGfHTz33Pz8vsOv5z50d3SqY2iiH6oeDl0T/opl12nSdhCGto/puzbiqgMI8IPfKb/oj1ol35mUsktlc7o+hnN4SxCaeSrw6Z9XUoXkNxV6Tz3ePCbjaU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBiYiU/SOAHP++A7wGzvnPp4COxwp5aAusg6SAgWZOI=;
 b=rFTRGcpkOi7+aKBgyPLIfSgqUJZ0fGJ1xbl154j/9zCub6UDPD+kXbSGApLTJtVCRvsJBL6SQR74WOyc4dhPMbDM1jG08NxdQcHJmfzvANnPS9mlCbzUJHjTla5QP5PiGcATnsaBuPONvUZksiV0/b8HV2Awz+9PuiNU6BUgSTVv/oZasQ21UsSTssf+SS02zoIxTTQDz6FNjZdUtvMo9kJ65e2p42JZ2rdIxthja9LSjjYCLXzXp+jYcqgyWsObFcGZePm/QIJwrZcYn+kC4fZPS6a8KJKokRE4WN5BLTPdahlsnJ5PRFShkhpWY65BA/vYs46GXSl3XpQwot+Ruw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:51 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 02/10] RDMA/mlx5: Create ODP EQ for non-pinned dmabuf MRs
Date: Wed,  3 Jun 2026 22:27:41 -0300
Message-ID: <2-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0052.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bbc03d-ef2d-4708-cf5b-08dec1d87e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	pcuxaL/xNRgiShdvLOnnDuwNgPaV6olm1u9jazVI9KO4beuuK6PoyDz2aS2BLcqRrL3zoN9owOvaEywmJvzV5a5//Clm2KwMcFPQm1904okmprjKZ5xEYQ9omzt/Dixx0WVeXJyR2b6Gqs4df/y/tek9x9fv6wL2pl1LM2LI5t/w1ZwWL2qw52NovvcKr42J2kWNu4p1n5N1v2wi2w9F1gpXami5faQrzFl0f5TM2xIYTqldtjHSVNX4lBFLMM+NlYIXfkNVoFgJgD+M8cB/ibBR52PCeyMerKdtHNg7AHC3XfsUIY+Wdw+Ma3XuVUeMiuc1B+XMuHDiWOFnk4AsHQjknjdOc/NZRmHkRgV6Zrh0xagfdsLMYdiQBbQ3GwDrtdj4iQkLH5kkIv8ztoVXe3W92qTL9IuG7KK40vwg7+XupFNt+mGdvyTwDE3fXCadzgIkRHBlQkhncpJpwNCHuEwZqh9CHX1nZhrxp+3uuxbHhXhSxg/uUA2dgqHZ9ZM807Bm+MWgkzL29qum70p+90u0kxFugsO0R/1sRZheZ8tjB0XgZ08tXiTCkLz59VzyP8Privy+RohG7K/spp+hhGlAKbRx+ouP/Ub23Fo+zX59h/AQr06cgv1T7HSJnkLh01kMryO3vjtQ9lkNmJX276vI20pLzBuCk28WI0KybW1ZxrhWY4LY2N4F16GHL6PD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sl0VYCytyj9GgNZf2swe0Zse+EZv19PTHo0WXOCFmU5eSQhqz8i9pIPazVD9?=
 =?us-ascii?Q?TmikdzyceWDYhn9bpd4Rjtfy3XUXjc5J+J+AbWGcfTMQZpoLuomPNOVpDSIu?=
 =?us-ascii?Q?nfApSv4buT1ZxrorOXvwLnhvIi1yEyv3y4NkQhUIh3ofmAzewLTb9TchtgG3?=
 =?us-ascii?Q?RhEIt0axWr2qysmPS4psoXRCjLqZsCj9OL+5trvimF6Q+nyMZAxCNu+eIuUi?=
 =?us-ascii?Q?n+zy1Ks+m6m9vA2bAAfqU4Mpsp48bOqTVOVqP95Gf1XMcVMPMtjLYcwwzXCO?=
 =?us-ascii?Q?wWICoK+MmuClLMh+8Qkwl0wxUoaFWAaBlc32i7b12X4xbB9ohSzfUhMTcp6M?=
 =?us-ascii?Q?T9hcp8SCWUfsAY4QcZh3dbhV+LO9TTZ7HXkNtpn81wzqOmSaHNjANvMCt4Mt?=
 =?us-ascii?Q?L8O33NnG6bYZ1fEcK6OgIBtEqDx+ZqWIE2c0KxVBPxJLuFvIEFKw2juk8nw1?=
 =?us-ascii?Q?UB1soyLCMYiRMQVECbRbc9kNHhlnul6LPtNgihtQLuH1GquHDPCUGMVFs0nw?=
 =?us-ascii?Q?7Mxf+VNKk5+bwsEXkmehw6aHlHyMfaokB9fYiHGnUT4ADd30vUGmNfeyuNM4?=
 =?us-ascii?Q?8MD7mcHJARp7Xth/tDevqtcNP/j5/oN45oppLhIZI5fnXxxiHba7kXO3G3+o?=
 =?us-ascii?Q?FpehDPnXBjCIO7M+uI7gDuG0+53t58O2aW6lYtFO+YbgBfuQh74dPLNT1dyc?=
 =?us-ascii?Q?e9bt+zpkO5i0+QoBPhlIE256CPaKtED4QMK2yk2dlyxztyNTNKoWJcCKiYb4?=
 =?us-ascii?Q?sxtdvxo8QmMMS1QOfHrk/QFSGd9JTXX7umVoRdcXKWq1BGwyGfRte/O7VQJo?=
 =?us-ascii?Q?UcJfDcSr8dGaH77UIRjA28IcZdpmSC2OnblB9N5BfFIy+Z3jHmhO2/BNd9CR?=
 =?us-ascii?Q?TMWdWLvfboFOKMP56Uz0nNIXgOBa9jUJwe95upDjGm3tO3HBHVJkoa5xmH9A?=
 =?us-ascii?Q?OCRmiCUghVkC9qc19JxSglnG17y0ZyUyflS8VxvdUZ2aoZwqPJp6Vh2mC4x7?=
 =?us-ascii?Q?do9mYLf5+3s+NHWC3wC5cqGrU4chooUrFP+GpSZ2x+4VdeVdts8JFFqaFK3W?=
 =?us-ascii?Q?rxYhrQxF3ubQZAUi41N80yuf8H9wa3gAdkmZ/kOOKa3c8LvBvUqhbQ/v5LJF?=
 =?us-ascii?Q?k85GXkuuv/8Bi8jrI+CUA+rKUVE9GRfYE+QepXjMBsmExRE0KxxCMW/T7esk?=
 =?us-ascii?Q?2NwsSu8qI4M5YwppsMlxdAtCy/a4WUaYLgwd1XcJZAirz9x4bp0Ru7aaHPD2?=
 =?us-ascii?Q?VK3jybnkEuN8Gz2FUzaibGCMjG4f2jylnZj0RLzDmcak+sNmavOj4dAGHkH6?=
 =?us-ascii?Q?S78MjJbB0ok9QmUmL6CDwJZeaQto1bTyuW15T7BhU6sNc4gAg6DJmxjL6rDp?=
 =?us-ascii?Q?azoT9OytvI9ukFJlkvFCJZJMYYuQw3H8cc2dyaoQx0RqqzatyLkyY6qAZ13M?=
 =?us-ascii?Q?olEK6YPCzcdFR/0IauUKN9SToNE/nmK6LIHU7PIXZLwyKUIbbIB+ptbFp0si?=
 =?us-ascii?Q?4uAk+VTK6rZbrj/NRwePOKBSf+7uQDs7t/SPL8L5JmIVEnBNw68kyDCCSjnN?=
 =?us-ascii?Q?FiqhAWklFTkX2sL6IG9iIK05qNWaEtfo1EEE3L4eTRLuGM0Douc9ekEQuiTZ?=
 =?us-ascii?Q?nKGDlDQ3BMFniDXh1+tGEaZ8mn2prKWDcjf9ndQKZv3Ux8APQjqiNUvqYCUy?=
 =?us-ascii?Q?IlelrsMqFqWfdHhGmAe35g7IVOlAdGotCtud8ZCp1sQ/OEpd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bbc03d-ef2d-4708-cf5b-08dec1d87e40
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:51.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgwR5kS1n3Ji/gZOKjy4VZ1HBuIaWM9HbJXqJ+i3ix0+BOuNjAUi0I4iwo+2T4TS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21718-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A19C63C31D

DMABUF generally relies on the ODP EQ mechanism to safely implement the
move semantics. ODP requires a device-global one time startup of the ODP
machinery when the first MR is created, and this was missed on the DMABUF
path.

Call mlx5r_odp_create_eq() when creating a ODP'able DMABUF.

The core code prevents using IB_ACCESS_ON_DEMAND unless the driver
advertises IB_ODP_SUPPORT, so until now, mlx5r_odp_create_eq() cannot be
called unless the device has ODP support.

However, DMABUF has no such protection and a second bug was allowing
DMABUFs to be created on non-ODP capable HW. Add a guard at the start of
mlx5r_odp_create_eq(). This is necessary here anyhow as the
dev->odp_eq_mutex is not initialized without IB_ODP_SUPPORT.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c  | 4 ++++
 drivers/infiniband/hw/mlx5/odp.c | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 35125bbb380c47..c0ef50d04a2698 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -956,6 +956,10 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
 	umem_dmabuf->private = mr;
 	if (!pinned_mode) {
+		err = mlx5r_odp_create_eq(dev, &dev->odp_pf_eq);
+		if (err)
+			goto err_dereg_mr;
+
 		err = mlx5r_store_odp_mkey(dev, &mr->mmkey);
 		if (err)
 			goto err_dereg_mr;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1119ce163ea783..10c11b72f41247 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1807,6 +1807,9 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	struct mlx5_eq_param param = {};
 	int err = 0;
 
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&dev->odp_eq_mutex);
 	if (eq->core)
 		goto unlock;
-- 
2.43.0


