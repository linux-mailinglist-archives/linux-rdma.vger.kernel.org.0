Return-Path: <linux-rdma+bounces-21928-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id siVHLBS2JWo/KwIAu9opvQ
	(envelope-from <linux-rdma+bounces-21928-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE92651376
	for <lists+linux-rdma@lfdr.de>; Sun, 07 Jun 2026 20:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=cwaJJPJD;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21928-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21928-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 843E0300767B
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jun 2026 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB03148D3;
	Sun,  7 Jun 2026 18:18:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280D1DB356;
	Sun,  7 Jun 2026 18:18:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780856335; cv=fail; b=E24Am8xcduuon3wfXsVSCugDE91nTluArpM9+iZbaWk9zjYBbkSOLCP9kjk4iBs3rXrYKJxiQEteneOSOcRdqXWTkSVmZfuSsXkuGZcSDR7G9vPbppnttArTZAvuGdLE3u/DZjBTTmhFxwbyEPP/JznHWpglwjqE4Ti9omG42Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780856335; c=relaxed/simple;
	bh=tnWsi7hP1kr+6qOXEDajMLmwUQczZktE2zegLvuSPVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WMJIXQm3xxpCi92Ktr/0CohhJiT8OkdvpOapN7zGGqOufEuHkAfF3X4QojfrQySk4HHRSz0ZvrWdZqv9uT/ALgv3n+sbX5D1en8ZUJ15nX3bUDmkV/xDoGTjuj+XhdRw1eBw9l+ifosRKBw4nex+2/Wy7biuC6+W5vDzOXKChDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cwaJJPJD; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcJnNA0qktn/P6RHDRwxENgOqtsbC5quBYV2lv+gBLwvI6YbqpKqZDXBz8wflkrb197n22oPJvjmQ/ymUy7mIdLI7cTv88mdoqQl1QV+onhdXzcKo3d4jsYDuwZZw512oBOaIvl4DnSrWfMUVJVumY0xbq4y9F4svt9SQJmBpn1pxD/Khl0+vetpeY44zlEyqteAv4b4I2qk4gnuv4mdt8VCPHbhbY3QL1R8MBb7sE2j8vmaQGzHbF3bw4oe84FK/s3kFmeVGuBCbgvMSj41pLJQlNX9q3AbZMSdepFBLaE9P7VpT2i5lR3hb4RD0FXVdj7kDrGMe6JRWw6z0H1Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8NAQVSTCp4D3cLjFn2VXuuGRkO1tKiay3f/TiEUst8=;
 b=EgFroGytu+M2wqjpO62DS/tW6yVr4fU2O/xlh4au84/nYsHMM6xdsCSyfdH/iSdGyKmd53mvk/bAvlmWm3WcDH2HG/sB5W3AHSU5VAR0SFJ59QxI92zekhHKCzW5PLF9mzbKq6VpS004AMpNulyWbZisLhrMPF48HHjT4iUmkSK0qkD46aMbQN4NIH19FuyiDdK3DwIJRmZmP711IZ7qLgyGSw+O3khAS9RXSDvjVYkqSmaiQ/qa7WeHDNaOcgsvVVXLkXZn/+8n79NxNqSPUWPtZ1IFuF00FnMfPwXLTaffcwZrXq9U6Wm3VmLXmyeXvDjrx22wibCOJGDS+lo2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8NAQVSTCp4D3cLjFn2VXuuGRkO1tKiay3f/TiEUst8=;
 b=cwaJJPJD1gN7sBDGW2tIqkv17LvV770N4aw5mlSo+oQZEWAEg+3P9WU3SLXsVyr3mofq4y+ivz3buagLqv5epYaM4Azh34RPmKMxrPPmsO985OBjXE/f2ZMTKA5X5rFFksxspAUkSoFx2i3eeVLrl2j6VEmeK5vuIXcB9+cr2RxAtFeTvMSHsIuYqNl2idPgl62xhyAMqSx0YyiW9dOxyefGC4XrvdMNyCJ/rYd/0DEOkawvdXY6Q6oielfHZkQvtqc68i3paQ3uqKIHbVigT/crCbLJGsfyKE/FupYhPcoEp8YtLqcz2Y0Q9q9jL82mTDh/U/if/tQc9678QFkjqw==
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 18:18:49 +0000
Received: from CO1PEPF00012E81.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::52) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.12 via Frontend Transport; Sun, 7
 Jun 2026 18:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E81.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Sun, 7 Jun 2026 18:18:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:37 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 7 Jun
 2026 11:18:36 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 7 Jun
 2026 11:18:33 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 7 Jun 2026 21:18:08 +0300
Subject: [PATCH rdma-next 1/6] RDMA/mlx5: Remove DCT restrack tracking
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260607-restrack-uaf-fix-v1-1-d72e45eb76c2@nvidia.com>
References: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
In-Reply-To: <20260607-restrack-uaf-fix-v1-0-d72e45eb76c2@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Maor Gottlieb <maorg@mellanox.com>, "Dennis
 Dalessandro" <dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Steve Wise <larrystevenwise@gmail.com>, Mark Bloch
	<markb@mellanox.com>, Mark Zhang <markzhang@nvidia.com>, Neta Ostrovsky
	<netao@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	"Michael Guralnik" <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780856308; l=2029;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=I3eCSvjor6tOhN1n50Dr+ed/Yc2Brub1ml3jF8a9GI4=;
 b=C6zh3fM+ZeiYygyey8/z1WzcjvIBHoMsBeutom5ch/jioQH0c0C7wh4XMTSmzCSzrZQpWZ8dR
 PEA5LIlC7N6D5kd0I8LS8q4sQayLH4gB0FXDqkN5HOPJj6ow17Oj5EV
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E81:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2b04b0-69e5-435a-3297-08dec4c138b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	deCN3RniN8VyO5Z74K5ycKnV/T9rZNi1fNyMoyTvhjbr9XJSLBnVichCCjGdRuwaGPXm5Fy28re94WW+Yw4wMYVIPobBBVfwJxwn0//bcPOkOXeIfln8RmE0KUOork7U4erZkdNqSeDnRUQkAjg81XTxN556bRyXluvbdQ37fjSeKo76wVXI4JltH1I3TD0SwcOsNLVI25g3sEV3A7ebkY5ypys2hZ1kPLYjNSu+frUhbebXS+bJQ0pHENA6ttZvSdefuWtYpW2BZSB+dDwb6DYlsTBrWTG3uSGbrzKeyGJs9x/8TI90Bxofe52+Oh5mjDQcQm/EUmbGqXFkQAZ6GcvhKTEiYL4sttM6z4n/tb/y4Z8cK0N9tLixXmVym89inB5q7AetrZJXQj00qqhTtOXtq4EDZteUxiEg5imkGvOlggGUYSuvj586OdXhPuf4b2biA2TfVaaeJTL8ob1TQT5CKy2zXjnbVbQtMeivfrYvjDwL7r0tcjscw+mwhLXeTZdwIvF1XRgASUXw/pHB/FetECb7PPKeMrJkwIg30BwM80HL91c8Vch8QCnZD5u7gmPdg4U0XBtsICCU+z16oLCNgKSPFmeIJk4UwJp2Y1NZIYmNxNQm0YFz9VeyHdjIJWw0IakOiqfDBilVukwbnWe1ADs97Loequ8kbr7GrEG1WDx4hWK0sT0EUQ8TGS7sscL5xWzkBCbxVSl0EClgzLGXwt/rii3jpmiJAhAlH72ziV7hY7WeOlAa5SLzjw6O2uICkeefaLBEys4HhS/5ZQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(921020)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MFKjTLlIrmfsBYIR9ft9moNfM71D5oCtTDmZqAY1+cBqsIrveZVTK7Y9RgKXZkppBC+H5qPtQBh1+BtB0c7buNys1xNSkoiBo+fzQYXsXF8GgeeKvYgyRRL/xK5p03ML+ZeW3Oa23AtMViNBeHZDaGje/4t44t9WUSLF+SCHUNR3jN/Fb615F3t+N37of3iSam58WMJsN063ySzZa+GhZE9lSsIptEicq+6QEkupbD2pl04nqXu4rcLkC50q5RYLuCo6BgQd9NYjlVhGJQ7cSeFwqoTKR1m3y/1aDvQf7yIRc6OBzIWQ68HHf4XEmk3UMHZOShUSpl7SxJDsjLkroX8cStlFaUk6YINSpNkGW8hOlGCal3YStwnHS3xXcKOjhlBL+bcPw2wTjVeH6HldGV9rQbbNekYs8vg3berMdvTGQsHChE5aaqhNv9/mFKm7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 18:18:49.0717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2b04b0-69e5-435a-3297-08dec4c138b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E81.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21928-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:cmeiohas@nvidia.com,m:maorg@mellanox.com,m:dennis.dalessandro@cornelisnetworks.com,m:galpress@amazon.com,m:larrystevenwise@gmail.com,m:markb@mellanox.com,m:markzhang@nvidia.com,m:netao@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,mellanox.com,cornelisnetworks.com,amazon.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CE92651376

From: Patrisious Haddad <phaddad@nvidia.com>

DCT restrack tracking wasn't working to begin with as it was only
tracking the first DCT which was added, since at creation the DCT number
isn't yet initialized because the DCT FW object is only created during
modify. The following DCT additions were failing silently.

Since the fix isn't trivial and there were no users that required or
complained about this issue we are dropping this for now instead of fixing.

Fixes: fd3af5e21866 ("RDMA/mlx5: Track DCT, DCI and REG_UMR QPs as diver_detail resources.")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c       | 1 +
 drivers/infiniband/hw/mlx5/restrack.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e8d34d54b43527e0595ec9e2fb93dc7e9bedba92..a16da733d99fa1f6fdb9ee864465acf45a6abb3d 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3135,6 +3135,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	switch (qp->type) {
 	case MLX5_IB_QPT_DCT:
+		rdma_restrack_no_track(&qp->ibqp.res);
 		err = create_dct(dev, pd, qp, params);
 		break;
 	case MLX5_IB_QPT_DCI:
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 67841922c7b8770c86fb5a47588e09560d0004f5..00a9bcb2603f0b094bcef8a4ffe6564699a85769 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -178,9 +178,6 @@ static int fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE,
 				     "REG_UMR");
 		break;
-	case MLX5_IB_QPT_DCT:
-		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCT");
-		break;
 	case MLX5_IB_QPT_DCI:
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCI");
 		break;

-- 
2.49.0


