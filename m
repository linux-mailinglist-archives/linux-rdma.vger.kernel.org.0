Return-Path: <linux-rdma+bounces-19012-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OHrNAt502nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19012-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 214DB3A27BC
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 280D6300AD67
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB22831987D;
	Mon,  6 Apr 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdQbyiQH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF031E107;
	Mon,  6 Apr 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466711; cv=fail; b=QkpJtIUqlYUfRUEqYdniRfkCJM9e2p6Eo9izbJVdkw73GsmRoyovkmbdSPATAhAjvFnbXR2be58k9zqF2vUTfxHO1Lb1EZVwHhA8bOspFhLSsEh4aiRiZPbrMI07SvDK/xLTtxtmaq3yOLti5m4J839UGHxzc6aH7vzmyuZuUqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466711; c=relaxed/simple;
	bh=8NzoPIweU0aXMY3QofGsC+56iuNTl86+BMC7GUySLQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pGGf6Uk6/FG+8YpsyOiM1k5iSa3bcLUuD7olQBzWyrG4hUfhO0LTxCLFGpKzFWPAvdNvEckntZt1I3TjNaaDi9HK4307lX+Gg8r63TRWtGaGPiymvYSxEuVHa5hAYczymboE/KUJPgFY2RxPg4YZ4dmdbEku3Xj2p6AKXC+eauc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdQbyiQH; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+x+lGuff1KBX9cnEvpKXE+YZZ5viwYOmsLcNWnB90CPODPf18cnpkx27wVMDETSSasYbPbdg+74dCSVc5mNpU5v2Dow3bwGAf6PwDNujH4rZJz/C1tU72ZI2pbFn6okG0nczkbpfvPO7M8DizcdlM6P0nfb15ltbqHUXBy81V0j0hlg+UBLzTWiS8fXXgRbk/zHT/pGnj25rPwP8MqXxIkKl74gvC4NjmHmUvGz9lRhP/bQbgXvcL8Gk5HtVhGVs3rrtFHZO8HRiH0USb066BDQsInFLmx4XlYo93gTDR3jCcLnnWsUrjwTm8xLqevDZ0UqTVXckgwu95XVN8wzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi9O8PCxr66le4OCF4pQgoClXNiuHSFSXI8ayytGkYs=;
 b=enVGLI5S5Tgi1Zi+Kg/gSZZIkCiOXAdYgcTyrXICiy+1xOIdTAuT2Lt0oQ7d/IrjXPQsvSIirDc5iTOsdbi3GZ88nnB3SbZqJaMZ2cmwtBp0nWPQPYfjPONxKu8Rafs8vHq2cS4mn0ZO3EeC9WgdD14awRnoO5WmJ2+GycS3ZrMOmuQb7/wbgXEDfQeWHfa5g5bS9Q8Dd6VyvgsOK4/shilba1u0DKI03j/Fzdct0GQch0Y4N/B7xFd7R/DjrF2f7FNgYd3wfly1YPKLoVZ/hKzP4EA6VQAbuCoBSiI2LRauV38y7f47rMnIJsALYIw1H5LMd+ezLeOmO1LFBhT6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi9O8PCxr66le4OCF4pQgoClXNiuHSFSXI8ayytGkYs=;
 b=kdQbyiQH2swmb4pWi7snjPzeoZ+PF5WEQPipgMmuzd5MxBVkITotLkBKNS80Tp66uQUEJVNkVR7wJVsM076KJIimDwy1YzdMYb8iy0yDthRpkTpFxaKvyZ1VMuhRG3hfyIWqVdH7Lqg8BcMMRmoez6mkXPbLyJSgcBiLN8iIBdk+Ox5xcZJmumSkWzzS7rtpMjtAiqlnA4t9+Y8J5u2G7XUd/6vcAGtnBVG6Fa3S07agzXlAWD4gZzhpiGwZ4ct7ixw2b6NpASZsWMkf/3FmQkVNdvzzEMMET6CpeBKmzYTx1YGz4uhVU2hmYQ/eQqXBOiqSyDyOUnKCTFEf1NJ1Vw==
Received: from BL0PR01CA0019.prod.exchangelabs.com (2603:10b6:208:71::32) by
 DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.21; Mon, 6 Apr 2026 09:11:43 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::ce) by BL0PR01CA0019.outlook.office365.com
 (2603:10b6:208:71::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:31 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:27 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:13 +0300
Subject: [PATCH rdma-next v2 02/11] RDMA/mlx5: Remove raw RSS QP restrack
 tracking
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-2-ee8815fa81b7@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=1265;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=GR51MqDuerkWliBLJ+S2gJCb+sD+W3iDTE8IzL/1NZQ=;
 b=XjzMb+GPMmGJYbZTkGxKU9fUnSRx1i8+AIdrx7plBb5hgDz2huhV4R/9o8+dcI+JawkWDH9qE
 XRndnnILQvtBvJwCv6bq5sLPY2ub6/cPyWSdb7nu+lRxf61VT/6sOZ5
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f37c62-1e7a-4091-cf9b-08de93bc854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	puEHeZPCJtj842WErygHOSi8IrIk2yXzmUidHm5vMQDe5VBceXte3GiKnWuC+0IOpViUpgkHywiV7RRS4pXFlOVHl51nt04GdBVN+HD1tRp523wdQU6dYZR8mFzPzvEFYQYGyFdb1y1sWOy/DTEgxg/dmtp8PmeF1CtjUTgARCfDavqKJju88DcmRJJZM8TzK6Tvdn4GGkKWU/TGOzIRlptBMtIVmQKsaYAQeE0gcxBomsnmthhrrUjhXxp8EmBV0DjfIO8Gbbd/GVjrDCkXXsDD8eys/53x3n7/8iBbnaZfLEaFTeF4RZ/FIh7iVeg/Lrcr5/3UurERgpHF2kgrE6USXoZKo+YZSS4DkqNhwxsSUi99zkHbEg7xg0jZ7qDR+FGYLZ01jV5aqRcVj2H0sWL55KmDmfCW5sogiQMZYDboxJl89etze11YjBDMem1Yu4yzw4/Wu0kBqbAKIcpqptlIo6IZbWZxgNSBxZPTxneccx0YNkgFfZXUIaNRXhN+nCvJ3jCJq1sKK6mH1jnIIAMieomLslurQuiwEMhReMwjOMu5KwJVYg3KpZjfHIdxEOa5ur9cnvEdClPtByQ6EbHSmEpfuYyiAdwPUhEc20JOx7ct8Xe9G6RAmzM+zBFLylz2HG74sxtaz882UZ5KgHF1XgYAgFOwlTod13Xx/RIVeO8WPuUE/V0lH5Y4mjsVkAcCN8HM0xmE8B1tIgl19HCwBNxTSQCfnrNaaY5REltAgScBAGpoXNCuL1EHEiiHZg1gZwMv0K8QxjUHmbQH0JYyB+kpzqYVpkXdUvxavVG6NBlPp1zGPnrFMsFGrEXL
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MjPi1wq2CGA8SZnOWg3q7dAOF5av2gIIrToWohPdn7jkn6qMC1Qo0gNhq5tD9bGiifNuCsh6iFX3oh7lHfrlwZlAS2NJTFUNjojWYsIfwCHuisOyhPgC3rsMBTGWDPMH6m4kQSfPhsMK71XX032nfVIEHZ4mp9r5en62OI3uVdvQ0KcW8fJ2ruW8ithH1vpK61I9EdgPrgXabq4tAg86Azr08xy7hesIUrOACsC7D1WnQYScx28YHq+64pScCST22/gwQT1HLsNHFmyOa4m5+uaGr9eVjVRNd8D2fkLBLMpGk3MxuBkig3GYlN08YOhfa7fuohQJmf8SGtedDetxBtCzAWzP7c0qqKr1M58AuXEvZlZB2ZimRzJgnI9TQO4BK3t+kq/5ZVtvjldD+CfbelezICh/AySLAdFJHdPKqnhTJM+rBtuykOrbM7kyY79G
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:43.1070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f37c62-1e7a-4091-cf9b-08de93bc854d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-19012-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 214DB3A27BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

Raw RSS QP restrack tracking wasn't working to begin with as it was
only tracking the first raw RSS QP which was added, since at creation
the raw RSS QP number is reserved so the QP number for this qp type
was always zero.
The following raw RSS QP additions were always failing silently.

Hence remove the tracking for the raw RSS QP, support can be added
later for it if needed by using the tirn for tracking.

Fixes: 968f0b6f9c01 ("RDMA/mlx5: Consolidate into special function all create QP calls")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index c54e7655763844b10943e12a70431da291c58b8a..69914406156c448e9f1cafbc8165d04e120e36bd 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3104,6 +3104,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	int err;
 
 	if (params->is_rss_raw) {
+		rdma_restrack_no_track(&qp->ibqp.res);
 		err = create_rss_raw_qp_tir(dev, pd, qp, params);
 		goto out;
 	}

-- 
2.49.0


