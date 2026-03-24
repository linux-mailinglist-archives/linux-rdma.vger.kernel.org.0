Return-Path: <linux-rdma+bounces-18565-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE2nJGeEwmkAegQAu9opvQ
	(envelope-from <linux-rdma+bounces-18565-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:32:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26965308484
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E2FF310B558
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE0937C931;
	Tue, 24 Mar 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OSPd5L1C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013062.outbound.protection.outlook.com [40.93.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E828D386443;
	Tue, 24 Mar 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355405; cv=fail; b=OqGb3Vn0cQ1Q6yJPxXRI9F4kkCTuF3tQimcK0s+AXvdQtCWzY/FCMBrvw0u3rh0Ii0SAtDQD7+tHpG4h1eEB9XoxNO/9mPUf2AxxGlGPl6owVCsgem2YMhBDIj5H6PjEkcB0TdnhjCbGNAFtHuDDZlf/4yEMRdQDWWCem3D9V1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355405; c=relaxed/simple;
	bh=rVg+TMWTFvd84MmL6AgZ1GR7mtWchw28kpPxxvTO9J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/GQjXh5l4zGCgovJm7dWmOKzt2e43QOiO49ErRoE+26dwqgHozAd0yCBAqBovGfO345dQmVakiBGWBRqfcKZGxz1BWj1U9gLe9LsokMRfzYiAmoy8+MtCc/oMd8Tpf1wxFpmEkXmQeA+h/iRy2O/cirs9Bri0k0G1aWkegxdAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OSPd5L1C; arc=fail smtp.client-ip=40.93.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf52Xit7bziysqO9VhP5KHECn7MgyWA94K9RVbR9wsaz2fCNMD8yAh9UCMVLCPa6afdUUmt2Wjigz+pD0DC2YAescVJmJ+HnbNcSMktlMNqsEei9jw5j0dk5IGn9TEyqUWzslemVMUVRNKGeGW0pVJxMHWDVJ4S4L91KjvpmZdR7PYBo8Ysv63g3u0t+wGB4RomnvJgEl9v8kla4i5u6yeA4MqRtNAXdC2Ag7I6oOJBeCM841KdvuZCgLHM1boT95iLi/cc+H5qEmfsG4BAL3EqqPj6hCeaVv1shR1TSeg33eJJ1lHhXMSv1l6y11mSZ72UO1hoJRCmRH32pCVeDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWsTYEXkESQDWpVGX2UqaFDMCn/DNM1NXLnY74SaiD4=;
 b=geDpXX7a43+imBWvl4/is/OwYZ4oatj+LLeey9SFUF/eniRFsPsduFcUBl7kx70tmvFgdRzRLUsjUUdsjUwma/E89YIwotQqaddLbJiWqODglN1KCXrDfCK2+NY5FyVXfUyO9oFmONXWTwlQuO/Ti7erWxE2yKp2eIcOhhW7Elv6ZfjrnqqHldcyVXPx/Z4hsPcTH7h3eqqLlTozZ4P5o/xTSQvUxtgEFHe/EfKuY3P4Avj6jfP3mTah/NybBVcS4pxd2RK8YPbX29y4Bvccbv2VUYZ5IkS/nfhJkAtJe2B1Zw1wW8uvoO7lVymBVoZ5gAqOHlt8XN7CezSDoEVC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWsTYEXkESQDWpVGX2UqaFDMCn/DNM1NXLnY74SaiD4=;
 b=OSPd5L1Co2A5id1Cb5RtqwRaLWMJIJGkhC6LtMMuv0KMVLbXHaJerQyRlhRFmRVIkHzF2Wt+mHKPdr073NrrnyuJBngBEFe2H/cNOvzqxbrlNVFK5XmOQpBCNQ62RUwgjg3do6wIFunk3LUqb7BUG+hpKAgf9TBmLcsjFvGY1OECi1OIxKW3QJgll0iK1RuO6hJYVqmtL28T57UZZnujPJul4kku8/Q4Wval3mFZjelFPE8ukLJ2sinhQkcEOVi2NSnp467rpyiZBfmQ9yuK5BNFsQAETDt983NpY9slQ3JoktGrQB2r1H/81qMA1HYlqeUwrygAYIgFy/6/gUey/Q==
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Tue, 24 Mar 2026 12:29:57 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::34) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:29:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:29:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 02/14] devlink: Add helpers to lock nested-in instances
Date: Tue, 24 Mar 2026 14:28:36 +0200
Message-ID: <20260324122848.36731-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: c068a965-8753-442f-dde2-08de89a10f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sijv+7bXgeeUYZx08rDeqvAl4UiQmjY11o2AB9cuOhoyjNaKNvIWjtLq2b11WbVbASdPzBmYWktIHlxTVx8zitTpJtM/h/0NCsvq1IU4KZVl/vHSUlBOmxuTPR7Tjvw+Lf1iLUssjwY1Y7nMOme37DUsER2t+DsoW0+VNZkTfNOStS722LZ50vdSGw3DwoRBmI1Mmp+gMYJMQS8R7bGagi+9A9rhqY+mIxOSimaj85THinCqo3eUeg3R5M60rCKbdVjyndgd57nrHZHxsgtuxObES/c0HcVSBJcQcg1mRQLK+TkozSL9u/vjXKqCOck9ueZxexPz6x0gtx4QvnX+iH6TJOB/CNFIcEUoQeWLhQzPEdHJ0tJxaSKJCnNcjPIZaFyKJJmi5okNZivBk+Z46eb38XIgYwm73Zkq311OfQESTIvckvhoTJLKml7G2TLBzN1XZHQmHL6rZ24+zWdUZn7Pl1VVaqr+COUk/9A1JPUgrnW3nxqFJ5fkb4eIxb2CcGlcHlWDa4mKtszCxKgnoP8mF4BZAaQWHFIGdpiN2OK56FM+TCPZrm7/tj62w5zI/Li808qIEWynImtaW7JQ3oyZvNtprGxp/qa/KCCSyZC+V+S19Bzb8F1axcrcKATSdGQddCzxoA3nNveFFGCMmzsT0OOM1r61rO2JyLYJN9yeTlYNYY9Dn+l5rxMKI4iI3IFCKmKspHclPcApfRUNSq4HAz7tgtJGDAAqNgIPi5bNz28gDZKost4k0WQU6rpD6+eiJ6S6irQ/U60n10oSJg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7y5sXvjV6kAmV/t418WA3SGgHsaV2sz6FOC5sQb+/YBLt6Xw1M/CAAYREkHIuiwq9ZZTaEZVgLuY7WRODdYWeudrgLY2Ziex4ZmH5KMBsjiXUImXes79Knw+w5XQ0bM6Per/rFmeidISH9zekfsXlZuuGW4b7mr/H9BmDo64hGmuQbQXiM9XmZO5EUEMwUiCusQPbJKTriH2KZboAFV8eN/erWd8oOMCIprctHBHY5tZcZP0AzonYaORzgLCWA7AN7sJ46j5ZUw9A6tqo/4jMboKMHpyTyqXsp9cQVj4QzhEkgMXPkzdcDQteL/rlOcU5t3/O6lEuo1Yc8Jf1AXeY7FMi+0f/g/XBb+AoprJU9HGclXtIOBUL4BBJeb1pu0aiBLqBNybVaR1vDVp4URvFP3aVhOVLzPNLNHBcu+2xPEtEnHptAQGFU/02xPbOKd3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:29:57.4489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c068a965-8753-442f-dde2-08de89a10f7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18565-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 26965308484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming code will need to obtain a reference to locked nested-in
devlink instances. Add helpers to lock, obtain an already locked
reference and unlock/unref the nested-in instance.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          | 42 +++++++++++++++++++++++++++++++++++++
 net/devlink/devl_internal.h |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..db11248df712 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -67,6 +67,48 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 		devlink_rel_free(rel);
 }
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+
+	if (!rel)
+		return NULL;
+	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
+	if (!devlink)
+		return NULL;
+	devl_lock(devlink);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_unlock(devlink);
+	devlink_put(devlink);
+	return NULL;
+}
+
+/* Returns the nested in devlink object and validates its lock is held. */
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel)
+{
+	struct devlink *devlink;
+	unsigned long index;
+
+	if (!rel)
+		return NULL;
+	index = rel->nested_in.devlink_index;
+	devlink = xa_find(&devlinks, &index, index, DEVLINK_REGISTERED);
+	if (devlink)
+		devl_assert_locked(devlink);
+	return devlink;
+}
+
+void devlink_nested_in_put_unlock(struct devlink_rel *rel)
+{
+	struct devlink *devlink = devlink_nested_in_get_locked(rel);
+
+	if (devlink) {
+		devl_unlock(devlink);
+		devlink_put(devlink);
+	}
+}
+
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 7dfb7cdd2d23..3b4364677b18 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -136,6 +136,9 @@ typedef void devlink_rel_notify_cb_t(struct devlink *devlink, u32 obj_index);
 typedef void devlink_rel_cleanup_cb_t(struct devlink *devlink, u32 obj_index,
 				      u32 rel_index);
 
+struct devlink *devlink_nested_in_get_lock(struct devlink_rel *rel);
+struct devlink *devlink_nested_in_get_locked(struct devlink_rel *rel);
+void devlink_nested_in_put_unlock(struct devlink_rel *rel);
 void devlink_rel_nested_in_clear(u32 rel_index);
 int devlink_rel_nested_in_add(u32 *rel_index, u32 devlink_index,
 			      u32 obj_index, devlink_rel_notify_cb_t *notify_cb,
-- 
2.44.0


