Return-Path: <linux-rdma+bounces-22045-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q9M8C8CpKGqGHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22045-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE942664E09
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=gi9lhJMx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22045-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22045-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0796303EB82
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290A8C1F;
	Wed, 10 Jun 2026 00:03:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B40DF6C
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049785; cv=fail; b=glcnby+hNvYmYZkN9lHG91/TBRwytXvhvXiPSRbxfDdQisfVbCdm9e6jsPC3ZSZ5pdHKgmlBJDMQtCVNpvlD4MWf0CK0HLo7l8gDabQ4X/GUNBkGib1ycU1AEB5qLIufuM/IZ0UdfLP2KSo/miUHUDld0X3XKmUUxCxVA5w/1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049785; c=relaxed/simple;
	bh=cpxGytSqL7bCYWuKju3rqqMFkxOwY6BJLM3C1U8h9eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKtUXvFRpvoq2bRvEwVRs5IC1prW+gew5X6Ru5c2RNq244gZQPyOZQ012t5YFZd6mO0iG0Iva8r8tc3u3IKwjKM5oCbvMMdw66QIQ9xfS8/Tz2CsnKZcqjpaixfHXUVIFM4cKbXYr0Zq5PIcZ08fKDpi3wOBAcNWXiOYLHnHtXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gi9lhJMx; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KijYotKM2EujMUG4mGgds6DzXee9+b6wl3qDiD00R7uxI2w7b5eeyEunNEvBr5ThKaaTcknvzNDxuXEHiOyr50/UVZGGPmq9v12tY2HjhpYiEiVShSy1DYPBmDtoJciaMU5+vwBmdmsZA4yK+uE7ECMiV9X0bsngE2oCTgoqWCl/+jH9aJ3nPJ1HM79xG3RfO+DBTBkeDEWaGKYB2Ywn/wkgoOvUHcfh1qDfRtygOSMsMyjklT3eff+5syHvH4YrgwAUapFX+GSTgw/o+kwWMPl8i1fW03PgaSquSk47XjweHP+IXwCXfzjb000DSmhYj7hmZcX1j4anf8ZBohR4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqErcfJ1Tcc4cuC3R2Qhih9rxcFf6bVXl/itqJtpiDk=;
 b=k+V7YIhIa/NnARPWsGejtnRwJwbRL5cUZxk21/RkQ0rFYlBBeHqnBBURTs+GTjBsgAA35+biSnUOPbzjPhtcc0Llzw7xLKys82NwdmzVKH+DGc4lfxaSqai2DouaB3ITwAFkRFoVOpR8SP5yIAMcnb1l9Y1S3JzpbmCr3RtENSoioZejPEpgsMz3iPoQOLYQizwb1+3BQR2XYi4GWAU+LOLe3jp/goFq+SH+MI2tTRFkLOEDSUt6cmRwe+0wtU/Gsyqqh0OsNVznjGfWWN8f3hf/WRHuPx//rtqcGabK6o1aL3p2iLJi1DPuObp3zFhEn3nbkAZ4K7xhH5VXTSH7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqErcfJ1Tcc4cuC3R2Qhih9rxcFf6bVXl/itqJtpiDk=;
 b=gi9lhJMx40hROjb61J5sGXjGvkLFts1ozrOdPt8HWQE9gZy88vGHtnKTfQP/CV/E6CJjm9mN6eTneYJDQOyUaht1zO8Sr9fjCIzJOfmoBn7HglZqwk+TGVhsbnhyetQJrh4KKsCPom3jMSvPEZMBU4G3160SCJV5+2gkV8+wDgc5SKqDCiI9T3IhxEgBgf+ImNsabLRexKNbRPq8N3KwMBKhRg0lg334T5bbI+QplI/jIJT1ChSaUxuvdfDZ1Jt+w/q8hU/zyY5i+gmYVHahgEJRXUwM9lLv7gGiknqRlfiX34xvO2fWQUr4/6NpkyF5MCAhHoMEHger7YAcbGxNxQ==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:03:00 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:03:00 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 5/9] RDMA/core: Fix FRMR set pinned push error path
Date: Wed, 10 Jun 2026 03:01:41 +0300
Message-ID: <20260610000145.820592-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 47aaa4ef-725b-4b72-63e5-08dec683a24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gVc5QbO1mclr4HodwXs5tFLq0pJR6RuYMznuWkjCjmHZpR5W4lryihvhQmqWPszgFXR90bLZH6kG9F11wfrLNVQxjS8JCuxEYd6oXGqxxwOs/B8f73AG0FarxsmD7QO7Zn7xurSefOMLACJ5k4HsnJBE9Z8c1s7YYd2/VlKX4vk/dxSQA2rJX7Jd4gPpPlllHhjf7YQjAi0nAabr6V2rtQokWeV01D7Z3U0gbBBYXu7VSMW/YkmOuPy4fpCeypRji2iku74h4uf1YWS/+cKaMmBFv9AwYy1hpkktHfevS9tnnKP7+YLtsNexLRFeiGee9MH0pVXIXtUjSzw3PYUPWVL8c9F6zjRFdaAxjhfPTUZfmJDlZ/W4Oxc1ZrvKWxsiqLmjUzS2F/M01e3POaZqgfwkbgrZfoEfIE0lFcmb5cZNBP9NjMa/OVlM5JAIsxNnlTDN3BrvELuR/Q5j2zdpcqw8Dpro4iNiFxnIMLgLUx4WOzt8wVhsz4qvXrALhq3y+wqM3lVFu5Xldefz2Cq4WrZOFsSnPiouKKttovw4tMDpWxZgLItcB55JIMpXvG5VmBARpWNeuJIZiqwy+HRLgMHAH3VqSDzNFchw6JhV6BUW/cY9omzF4E45+d+DAmSEVBFWtpDBZ7JiquNazQnEvYGxuOmzxopqesfNKPr3XpPq2T/N45aoVzVZJqOpPbW7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FKCwVWo8/dMEGxoDf6liIAZAEqgZFqD7UPjzz4mgP9Wc3XyP9v7WMj0sfckO?=
 =?us-ascii?Q?Gz9dzaKSp/C4v3vyFYzs7RebgoXkwHKDvqVf5zSw25ma2Qdft0AUaRuLMx7N?=
 =?us-ascii?Q?xVZGOOfi/fjypFl+SE9Jz+KxhX9LTCClXZ/X67BFen0/3Iem0/w7MEx9l8+O?=
 =?us-ascii?Q?3xm+2hnw51tHIYcdrhJoCwG4ktk+Xi3Na9EnJ6fanjTtBvFlBXDI34ympZtJ?=
 =?us-ascii?Q?g4Fh1EayP+UKI5AUmPrdmiLJQZNf+nRt5tL/dak0klpl6jlM4xUk5krlHIAw?=
 =?us-ascii?Q?LBM8Vv36EcJFNm4H1NG3rUNmVWRc84wmxpRHMgLYwlwnftNWbCw13MgKWWcF?=
 =?us-ascii?Q?zjIk3kvRz6uCAmfNzUs2sfj0lFeUTbPn4JiYixInrXjcE5fg1ejmsTosYGQR?=
 =?us-ascii?Q?OuWOUG4mekGyk+pRyoTRq35i5elQEmVb8tcYP6zgCu0130WrPg61dDKoaFZ5?=
 =?us-ascii?Q?sBWzQJxwiHInPX+vf7XEFtg/M3umV8J51KSnrgzYnitZq9/jmRdXJHaqTUuk?=
 =?us-ascii?Q?OaTkzbimBoP6dVIlqAAY2fntETsgzKDNftGyUkzY0cfZeQbS/+PwVLAzrjPU?=
 =?us-ascii?Q?sfEhrdrls10z7/Sdkv22UMtOCcqvN8Hce+GjPzKJB6z7qBXCetkzxvGkpIUf?=
 =?us-ascii?Q?Fer2IXQVZOjBMC18DjGZDYvmepIyRellzTzkZ3zEGPUMp1UP21/5O2vJZZ/X?=
 =?us-ascii?Q?7H718hsm5k4412nJOl2bmM+9Vlvaa0UYeImWcdk4HHtjYFPKBhxt1tt0waQc?=
 =?us-ascii?Q?A5FSJ3AGPsuLUY7x1OziUFkBSI+QTLMbG77IrrSHHrUb0VsOxQNvNZIvSneH?=
 =?us-ascii?Q?ioswa+6MZROYKpV/yxkSUzAJBFDKlhGhyHHkuq1GPeWzZeOYKnwgj64BabHg?=
 =?us-ascii?Q?4mbSodXp1u+Ks4X4XemleYBkQjWIIfQGUqKR0mVoVMPYJ2JhR9ixDLdzaVWt?=
 =?us-ascii?Q?5imREiDhwllCsHdaJgPLnNJ/PkCVMaRJ/+E36L5KQ1r30I25yScFJSsva6An?=
 =?us-ascii?Q?1yPM+wo4x47HC5eX7Y3+MPAUok5NSNUoj6xRRdb/YJWKSm+fg08+SfeEOEI9?=
 =?us-ascii?Q?53cSSwnPAaitOY0kykWJ1DdWZkdrZFg2OgyEtwQ1O10xgY+waTSnFUcQWUA/?=
 =?us-ascii?Q?5f8mw9M92lst6vCkjAzj0hLi2mDKibvIS8LtPFboQHRmD8Z9WcUohu76aF8a?=
 =?us-ascii?Q?6J+PxLFs8bUpEnHt7YHImov1JTYhuGBryPbZ8x3Vgfp3ZtVy8OMj4QfTBCBo?=
 =?us-ascii?Q?SHtYR0cYlrbiO3qJI059bfB59J9gLkgO7CmC4DZDmRvhxMfQg9T3kUdX0HMa?=
 =?us-ascii?Q?eQMS0cGqT0k9cGYJMMxOP/ClNuoOGFl8BusCTbVmK0sCWblWaXFDAgU8b6kP?=
 =?us-ascii?Q?/G9YLBNhi7YohiQ+r8YVvrgwObriW9Mjjj7vyY0o3LIuZOTc0P4Dy1nZ/S5v?=
 =?us-ascii?Q?4q0IVYe9QDKCZ/XbO9bsW2mQF0ym8squJp7TIUGcLDKq1nnTRBuKsLZHHnnj?=
 =?us-ascii?Q?/JSIuV7MVQ9yoC7Iaarpgf03zhBZRhoXdha1a3h8WBKmNRbmhYAwaodHlKk1?=
 =?us-ascii?Q?yowcGE81SEWRtwz8mK7mSQvJXD9t7NtIztqmSGLaE2tIkQ6JHZwNv4Of6AxR?=
 =?us-ascii?Q?lq8TEYdbOWCqq55s0SOapexylsNPU9TQwnszaAGEL+olt08/uv51EMTeQsHP?=
 =?us-ascii?Q?lFOn52/ois4EYaDeNZiyGmgOq4IYZIo6KLnEm3mhxLe2fSe5ux98Sh+2ObQT?=
 =?us-ascii?Q?q45QRXN5uw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aaa4ef-725b-4b72-63e5-08dec683a24c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:02:59.9882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVk+ANq3MA1e6r/aLMjkrpRDy7wo2t0zrZzvpTNuFdscqNusqt/6+ozjhkqg9jHW6jolvek5f0mQRB1B6yN8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22045-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE942664E09

From: Michael Guralnik <michaelgur@nvidia.com>

Add destruction of FRMR handles in case the push to the pool fails.
This prevents resources leak in case pool page allocation fails.

Fixes: 020d189d16a6 ("RDMA/core: Add pinned handles to FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 927642c06f3a..1cfdddc3fcda 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -461,11 +461,16 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 		ret = push_handle_to_queue_locked(&pool->queue,
 						  handles[i]);
 		if (ret)
-			goto end;
+			break;
 	}
-
-end:
 	spin_unlock(&pool->lock);
+
+	if (ret) {
+		/* Destroy handles created but never pushed to the pool. */
+		pools->pool_ops->destroy_frmrs(device, &handles[i],
+				needed_handles - i);
+	}
+
 	kfree(handles);
 
 schedule_aging:
-- 
2.52.0


