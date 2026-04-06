Return-Path: <linux-rdma+bounces-19011-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPg+HQF502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19011-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 957D83A27AD
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3165300A261
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098F031B830;
	Mon,  6 Apr 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xj1lZXg4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29A31D375;
	Mon,  6 Apr 2026 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466710; cv=fail; b=cVNdzjhdDoU25ra5DGCM2UG6tLT8NV8gt9lPqLnLsj2u3pqRQxaaoo8niiSvG0RCxdZPGZfoPhTyrYRi6mLT8O9l6vT9oprXivVbDNZbxMAXNrwp0oMHp4VJEXN5M5QShTPTKvwvVFHwPKMelVFjiIO4WT4PX3Y0R2ZDQ6vxz0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466710; c=relaxed/simple;
	bh=OCtn3qnFkvcS1A2WnTDmu+NuoqV+KXROwIZrCpgvH0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JA0AG30pZS9UEC3OvdMVQmh4zp2vKW49EkMsm4BjNwBsLcM30By5a7fxPyBQDnGPmIgdm1kPey4WnTj76sMHecTr+OFKEhIXSPEuvJOQcK1xqozNP8DzJrUOGujoLTDNAxwOLXvCNzvKjQOTG0kl6q3Yi7Qx2m3j8/JipjrRsxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xj1lZXg4; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1Q1AHp97spB2IKvrdNlLr+llm0b6cYHpXBE98VxID+g00VXaC0XfqF1ZheG5fgpy/dQ1en7PXaJZxGU6xa42/nE1S/Z3PYoiYdJE1BdMdtIyH2yUsR6lbZMuWF/VmsH/9s0wh/MXhMLIR5YFoI3lYTuvzIFKMt5MqmOTc1/EX9AjuxjxDfxWCHr6Kl3uprZ5xSHyJyvt/APwfnqBAF05VkgX//KlEWEbDudVv+TtRzalRfEwQ2sv+7KUlKCCMleFc4xqkS+8pFiAjinICsPL0GrktMh0KWNnpweF+is64CDtMtl7Via7fyS9x+mYw0P3dUycZejjvT0Col+RyZVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvC0+BWHcKnZIlg4ICoBk8kNOqzkSfYdpvx/S9m/RZQ=;
 b=eobTczzm9DyegbWsETxS+obfiDKVAqn6HIMAUOjjKdeVCWsXAArKMDJ0PFQgX1z7Iq4eXQrQh2n0cBoIG1qu/3HIWa21vIrHIyyfwaSQg9fl+gDO90KPeTrtSloK1uwg5W1kVyjYxBJftLynkyKuKn+3HK9UK7v9dPpJaTHpdRDQRSTgJmyoeLbvT0h5uOotAL5IfocellhQAZztbrD9JVXTHKokPs6i47Un0NLDR+oL98EIFzFo4VPuCTXak652k9oOqxzs8mJO+neGpc6lw+rDTQ+FVUHKX5UOLBhHwgeId3DYsvPDNwrKlyxjOD3inxSaRdDFg7ZFPDkIHGeUkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvC0+BWHcKnZIlg4ICoBk8kNOqzkSfYdpvx/S9m/RZQ=;
 b=Xj1lZXg4raddtSQMpcmnSV44EVPi3VVSe1nqEH/u6MN79sdw+h10WTcxLEbgND98IspRJSU4xMhDMAezng1CiW2FrRjs+w3KVtWhZBGfptoKrezzGy/PlRkvvGlj5CjphhDwsjZ6IHmm1ZJQ9MUgnvi1dGxktYbt7QI4psJTvPZDhobZtHQoYLO2TVwyKDNRqjsoXadHqtR7lBtpDOnGZNQedtPTm5fJ/pEiooyliqSofWI+rX3iPNMy2mQjI6nrPNzyhKVOiWfTBe0/PEVETTMLE7T5jd7OKr4otlhBHG1BZo37G7Q65AGGnZF8afsYmUwBDl5HN+YJgNvhR6sJMA==
Received: from CH2PR12CA0026.namprd12.prod.outlook.com (2603:10b6:610:57::36)
 by DSWPR12MB999153.namprd12.prod.outlook.com (2603:10b6:8:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 09:11:46 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:57:cafe::37) by CH2PR12CA0026.outlook.office365.com
 (2603:10b6:610:57::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 09:11:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:35 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:31 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:14 +0300
Subject: [PATCH rdma-next v2 03/11] RDMA/core: Preserve restrack resource
 ID on reinsertion
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260406-security-bug-fixes-v2-3-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=2282;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=gcx/gxokEE4A3sI5jvtz8aq2s339e2gUf/pCqpu6bsY=;
 b=OBMofc/oGo9BrYNZ82pLhprPTt60ScUWJ+Mj6SHpPgi27D/LY9BotKZghkURdE0sClDIfM6et
 iyez3TkqK1cBzoq87Pdm+9KuNxZVt0Ntq8QPuoHG9UvrBsW+hRD2VZ4
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DSWPR12MB999153:EE_
X-MS-Office365-Filtering-Correlation-Id: f783789d-a58c-4283-335e-08de93bc86ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R0Ac00/EZt4M7GWBt0Y+D9vknx39UUlm37yo88aX8XCsZRSnGpVXTJ8+aSy5PBK6Vj7jgTAnM8+e97OciOUtrpPR2XDtOJRy0YMrAHz/XIDm+mfXOHKOUZdrIgS6buZzVIkc+kdi0RwX6eXZBBDMI2NfNVjPZOLswHSqY9y76ClWIoopS1fL1Q3wsAFvSML1y/zh+qFRrR0Gu09SGP0jjOeLNjOjFNOKGAlJUs+wkHY8WXvFQBO66fnXMYMeZvd+0hC9g0/kVh6EMmxxe7k1TTJGqJfJnpagS4QammzBGzuBm6Yj65LadIp8ou/SFD/fb+xFzlZSGdWwd21hkyLLCSKecHf3Ya/NVJvaWWMBTcFsx0Ols4fY24NJQMuMPU8Q331OSjmzvGvdod4peUg1/U4Kk6ejspqi1pRm6OKmVhcw/wIuhnOm5YnNQ96xgHLeUid2zfJo2tAFRJDZOzjwlQMPH9foHBC5Ia7WmnywuPDI7nSvPtonVKfYndsbH/9t40SHNJxlKi+YiHlx3VUL74HdBSagQnGwcNSZepgg/6UyT1YRKd/Xcfy4uuCcBEim+UGxWk7pvyIuqxkEsqaYBSqQ9nNgTmdDmTD3Cak2du+xAhXmfS4y2/GpX+xKl//hjDIhOMLbF+JiyGNHz8mgr5Fr34PAny4myhOfd97xZeuuwIGyE3X2AdF0dhh3irp8FRPsZ+k3tV0FLNdmhJHrMJrgjvWSsG0zn6UejsY4B7sOV0Nrh4bhfqCradFkuBEcTXdO3JmrlBfN1kIRQRJpTta6EBPpT5Wrp9/wou/yWiagJ1m6epFLLA9qb9pFE3R9
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	npEZsrutb7QlSxtt6y4lgRgENZQoy2RGOCYC9H/m6LOYApmFfLWDaUwD6Gxku2ymbg8c9ZzzQAusugSIHNZAX3UMZaaep+4r1Tliro58qCpZ7VOKGoXfx6XIGjZ6VwRID+RCjaEXR8ung/vnVtKo/G0gN4CqJXksn9tQLoyzHhk3xPsIsUIdTAY082iZDD7ivzcHCtxxnyu53rJpjKuVpkyQXdVX6WXOKr29joyu59Cdbj/qp/g5gAC8aWMC69QxLOPG29eVPVwnaBCgF/n3wzXOE1O3uBD/g0mt26dVATIKeAGvyUiFU3e0hnzXTrrXJfNS28tc0kWTwt0SlFMYb+Mr/0cYXp5ImQxhT/CzKHQjv9Qqs12yO4rrKeFqfJcDYAEKhMnF0HlbHDFYCwQSc14FlUykZzAufJMDwJZ+Ov9i6gLTZXHWSvC/AGeZMTjz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:45.8326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f783789d-a58c-4283-335e-08de93bc86ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999153
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-19011-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 957D83A27AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

rdma_restrack_add() currently always allocates a new ID via
xa_alloc_cyclic(), regardless of whether res->id is already set.
This change makes sure that the object’s ID remains the same across
removal and reinsertion to restrack.

This is a preparatory change for subsequent patches in the series
which will do rdma restrack removal and reinsertion.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/restrack.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ac3688952cabbff1ebb899bacb78421f2515231b..485e7357c90a5ff9660feac38a0ec01c0deb0000 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -32,7 +32,7 @@ int rdma_restrack_init(struct ib_device *dev)
 	rt = dev->res;
 
 	for (i = 0; i < RDMA_RESTRACK_MAX; i++)
-		xa_init_flags(&rt[i].xa, XA_FLAGS_ALLOC);
+		xa_init_flags(&rt[i].xa, XA_FLAGS_ALLOC1);
 
 	return 0;
 }
@@ -71,6 +71,8 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 
 	xa_lock(&rt->xa);
 	xas_for_each(&xas, e, U32_MAX) {
+		if (xa_is_zero(e))
+			continue;
 		if (xa_get_mark(&rt->xa, e->id, RESTRACK_DD) && !show_details)
 			continue;
 		cnt++;
@@ -216,14 +218,24 @@ void rdma_restrack_add(struct rdma_restrack_entry *res)
 		ret = xa_insert(&rt->xa, counter->id, res, GFP_KERNEL);
 		res->id = ret ? 0 : counter->id;
 	} else {
-		ret = xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
-				      &rt->next_id, GFP_KERNEL);
-		ret = (ret < 0) ? ret : 0;
+		/* If res->id is valid, try to reinsert at res->id index in
+		 * order to maintain the same id in case of a reinsertion.
+		 */
+		if (res->id) {
+			ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
+		} else {
+			ret = xa_alloc_cyclic(&rt->xa, &res->id, res,
+					      xa_limit_32b, &rt->next_id,
+					      GFP_KERNEL);
+			ret = (ret < 0) ? ret : 0;
+		}
 	}
 
 out:
 	if (!ret)
 		res->valid = true;
+	else
+		WARN_ONCE(true, "Failed to insert restrack entry at res->id %u", res->id);
 }
 EXPORT_SYMBOL(rdma_restrack_add);
 

-- 
2.49.0


