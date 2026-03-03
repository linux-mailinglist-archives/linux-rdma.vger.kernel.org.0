Return-Path: <linux-rdma+bounces-17431-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPHwFQ48p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17431-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:52:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCB1F66A8
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF12F3035292
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36338424A;
	Tue,  3 Mar 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PNEe+w5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46737C93F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567422; cv=fail; b=rRW8VnL1Au0p1tnQBpUCYpkmyKL9e2tGUeVmdRRDuJGCF6bQQ4vFbyet2S4ydWFG8uu+GS1cIBaz7VvNPwESJ6P86+z/Ya4hZscMQSBInBC3E/sdfMQ1d5XHLP9O0buQu8ELGc4phJtikczAZrZKCss5vDKDUr/JDbeUSjU28oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567422; c=relaxed/simple;
	bh=tIvYykfLtc3a/LvEZPNe4Qo3FrAg5sHtbgJdvtSGheQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deqRadRN1Xh88bTGxQaLt3m/lF0OajIP9dsNgiz3zbs/+LamREp9TB+5afY5jXD9eP3iBld0wBM4xvo3tvDsZ3ganXEhtBMi5zdMps9yza0nGOug91sabKViNTB9QxYFVkM0ZgTCw8UUGTwB2GQ94FFPnzhH2gGE9+RC0/5Ne3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PNEe+w5o; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFy0JEE3DmDe4KrAPSkhedvgrmRNVxwT+XQkZVVIxC452vMpr8KGaf1POB4Em5RZCNUkDpaZ6VmWhvBr/kZCW1y9TZ6n5LwnKJaBbV7OQUHctKxBaPaDzK7fo0/KFfkeuV0xaOz7DqzzuQuLkLRUg/3xmlIjpgda22RfOUfLd+vS9zfIll7ON8jO1P5DWBzil7skPqTftejHJNh7GX7n/z7sQ60y6++36MFTMsg4E0Z6mou35b5Y/IVk3EDOmlMEW9pxwOGRgNNu5kEjC3GbkdMEneuhpDN5zrlHrjXgIjuJJflnM3BFi2kmoz40IF8jZTJOoeZb/I+F3Kd3wSuKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrezUzHULeata28nRnTkKbpvDkkG1Sq7PRbS2m0a1QU=;
 b=fYnGKKLnzPF27WZuaNLf8B/DaiFcryirGMP0kJwFyk8UgLGSnQNXQS1v8oP6GRKKNauYnzWhfjxEC90TJLRzsux7doppnZLbij77Fil+NVjwfFf7eg0qOuQyAYEFgOQBGV3B0x482YY8dt4F0sPDp9FezgqpocWv9MQ54p3Nv2C6PR5aJDJwZTWniIHIHCkpw55wVUWolethKA2V5gly1l5inZy/SukEnz41OdSNbOC5ep4rJl4XKdVpMRah2NtCPcqehwEG6amA/Fpwy9D/DcZgH3klcmEXr1XWtk05lq3wFlwPFtQxkYgRj2mFB9ucBAUdSJA+5M2DstHYlnj/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrezUzHULeata28nRnTkKbpvDkkG1Sq7PRbS2m0a1QU=;
 b=PNEe+w5onOU4nn2KDoJasECEH5RzQ5zjPjxAzlWGwN0E+S03v47AdFAVXfyvQk1Qo8hHOqUyD/NG+6K2Rr7+sDrReFCLu1IOu/boOT8CHHRRQYHifnFwntTeuHWd5uK1xkxG7HZQf9m5iJgkv6G/2SSyNHFLbKXiAx2iPcyXlx44iXO1wqOknGir2NCjlnK2gAB9HE7su9fUgavjEOmtjsl86oPn72S20fFv+UMxi/ufDV1+xBccBKM5WFDvcYjpWK7aIh3BLVTTBmF0gTFgfxFMl9B8MIcW4EGX66zaGIPNT10M7fCWsJiK2+YxcyyRm9J3q6S13AV3hz3H6H8M3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:15 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 06/13] RDMA: Add ib_is_udata_in_empty()
Date: Tue,  3 Mar 2026 15:50:03 -0400
Message-ID: <6-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8838d8-4a03-40ab-56e9-08de795e1513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	U2FCVT5B3e3YM/PSJzLF0a0D+yn6uN8OqcM7r7A1CqVhu6U/b6rsQXmD9+kXlujBB5N+INGfNoxuvSnUgEPBJXk2MDcaeo7Nl26Q9hde7Pin6Kv/Igf8GVrEHdTjpSXsRCz5TXGZmTJG/FADRW8p3lSVXkJO8YPDxZoyS8aVAjYPudNAbFeUmaUVSjisA/gYip0efJw3qFxazjB1Py8jl/zksQ3FEeXbx5f6ttyoBE8t90oH/LS1h/TxDmh9NqGO1J23wt6IFLNcbeq3NTRn9dFfE7Y2uE07GDt8KLyjdsrqZ4/dPq+VtUDGCqAJ0/3W8azja+mEQv4eTMSXusZtJG9PRNCNvIHwlSoWqWczhd8lYP7G2j/DpxCeOiLo8q2DcnJR/sV8oNoE/ok+Zpg/mH4why8Y17dRpoIoEMMBhO7mppWu7PabPnZ5lTa3kiRfZzKnR3fidJ+ZjOaH34/V34pZVl+yHcABK/3CmFtdrpebL7Dj5q2p7QTWkYNmok1ZatLJuRaTxbKNNH+lIYV+1Lb1VGnQ9FrlqvTbq6VN3wDVTwoecdOanJoNRs+1GMp7pX6VXRVP9ypTcAf6O3R6VWdCTycAS5CmXcm3Hx470TR2/VAd5ivroqF3aj6ikSVX+Ke+T0ZOJOGDD6rcZYw9tjgvPqIjFrIbcZHqTZ4Vwe08NhhpzxYHhmgmircBnSC8iQIPcyGSLIj8BS+MYPkVt+yzBrE3/21VNIOAfYkrQCQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kwdxcx9fcYQ0obtep1knK3/6exE48eHJ3BkWP/R7knyTLXhcYToE0Gi76zYq?=
 =?us-ascii?Q?WM3sTpEblDmlSCSNJfG/Txa/QTybhGxW1xRe5eGBNgaOY/r8y6wafq22LONC?=
 =?us-ascii?Q?q+2iwVg/rZ/H0AepVBxhbgmLy93a4J+UJVEIdLqN9/HM1cENqqkPJ04u9b4n?=
 =?us-ascii?Q?1rVhJGkFtuQ4EZIlNKnALf0BasviH4BMCFE5A97GkHQw6yr6LBWao4xRMDt5?=
 =?us-ascii?Q?A+brmJCtaab91XhYaN8l3OBoG1LLpdQqdkrAMRiQTnbbfclPQkCeADwN780k?=
 =?us-ascii?Q?yIOjlYKl/j3N4fjI4RrxGCaZImKtJw3oAwHAfU2wZ0+TFsXG4RJRhefTYXH/?=
 =?us-ascii?Q?cK2ldWujYqFGhrST9p46pul3SvctfZj4/+ifB8ro+mVkOCy5ho/jhs9007pW?=
 =?us-ascii?Q?UC11aNKgN1Yze6ACLJ+dTUgTgyaZJ0tdP/+BuUV/pY/72nhUzKugDxAh5Ybi?=
 =?us-ascii?Q?Hpyxlk3qTHC3Cefm75LXbs6kkXFWQNQKsIhJA8pYQ4DYwpi+Gr9cmU2lOPr0?=
 =?us-ascii?Q?pUVytXM93f5AWkvAHJ+S4Ur6cTu8HEg+gWhyEpC07bPDfrjEuY5qjd5EcgDM?=
 =?us-ascii?Q?PQN9zniexNkbnoiC6zMzPy2gDBcgre7jeAzJKwpMrfVU+LR/Lf6SsSWRGUwK?=
 =?us-ascii?Q?s7ISDwYiD4iyUKVO6Pyc9M1y9l0OVVDfJYnGImYv4428eE38l1UQHGUVekQd?=
 =?us-ascii?Q?h6kx47akwcS+YiwhMwg2ysfoP5YNAq1P34ErUh4cfnMofK0bf+dGyfgDC1oD?=
 =?us-ascii?Q?s4u/K7UflMKZ1tNlzZlwqSRwshe5WOoD2GB1NL3JPMQVO1J+Lnq7WFKEioWP?=
 =?us-ascii?Q?fNwJdUA+P7NSCZkpOgMOje+s3oSu9KFvXspQd4OsBT8aERmMHuIHDyiMBl0p?=
 =?us-ascii?Q?RXS5U32rVatlNaSvyjeS9ZRM7l2g/tH6yrvjsFM6MRfpkM+Y+zpwhuKMe5cb?=
 =?us-ascii?Q?Jxzykr2JxxQjGvjAwpex3051wATk2yhUz98gP5rbQIyZFg2ZSbSFo+UIhKF/?=
 =?us-ascii?Q?A/OTQnAxH2bhYFa3iNYRRvpL+sJvU1Hwm65EN5Rm7F1KkDGPHD97xJ35UkuK?=
 =?us-ascii?Q?6dKiY9/ZDF/vEJSTOVGy4LwT2MQP89UIV4F7Z/6FRSgUoGFC+b1QjOyD31CO?=
 =?us-ascii?Q?tLSFNdh3avn64XVKl5kvPZd/qspywuX33B9oWph+FimhEGTh4B3Y8DAGnNpi?=
 =?us-ascii?Q?ul4rAITqFLtCeV0z1kV99UHrfE+S4P57qU47jO4Koc/ihsvozA1j/pkplOqR?=
 =?us-ascii?Q?h063+zpDKeCsOoQOClf5rW5M9uOXaxNMD6U/WkAKb7zAVGxeIaip++tHu9Aj?=
 =?us-ascii?Q?D3noYjlE86Jpo5WlxpG/GWLxAp4f3eKNW3SFsvRKJhSUR3qIb28tW84aQWbC?=
 =?us-ascii?Q?X+Oh8/TMbpb0PMi+gKpg2cKCtdmLVpS7RHcBqOWXlQ4j48xfWduVK5gBwK5z?=
 =?us-ascii?Q?PKTtHr35K8OapywBfeB1bRa5QTqOycfdSWoWAHO7PP6F6GYzox8af+zjMIcR?=
 =?us-ascii?Q?FRKPrbhsydiopBXx49xI3+l+B7w+rn62pDyGymwN7JYY1IlESbv9iOS2leV7?=
 =?us-ascii?Q?+vDlIe6/YQ5Auhngs9JQJY5gOOF6ltnEuQ9P8XJfqbLKeOqlQqHht1oCFrJ8?=
 =?us-ascii?Q?whl6br0zKe2fttoVIfF7uvSWCi3nqlx+nsB+VRoRH8Oymjq7/O30T2MZFPOA?=
 =?us-ascii?Q?CSbTCUh8gahc0NDoo7WfRNmC2vV6CFKX+8yqYd0Wz9+cnlLRyoh8PtD57LBM?=
 =?us-ascii?Q?HzZx4KN/Jg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8838d8-4a03-40ab-56e9-08de795e1513
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:12.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGyVefFyiF0ByWowhjgFIMlW7Nj5wN2C4FeiY92nVF0hDxysMiNKYzqblYiqmPQy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 8BFCB1F66A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17431-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Action: no action

If the driver doesn't yet support any request driver data it should check
that it is all zeroed. This is a common pattern, add a helper around
_ib_copy_validate_udata_in() to do this.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/uverbs_ioctl.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 38a11bfe137430..e2af17da3e32ce 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1075,6 +1075,21 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 		ret;                                                          \
 	})
 
+/**
+ * ib_is_udata_in_empty - Check if the udata input buffer is all zeros
+ * @udata: The system calls ib_udata struct
+ *
+ * This should be used if the driver does not currently define a driver data
+ * struct. Returns 0 if the buffer is empty or all zeros, -EOPNOTSUPP if
+ * non-zero data is present, or a negative error code on failure.
+ */
+static inline int ib_is_udata_in_empty(struct ib_udata *udata)
+{
+	if (!udata || udata->inlen == 0)
+		return 0;
+	return _ib_copy_validate_udata_in(udata, NULL, 0, 0);
+}
+
 /**
  * ib_respond_udata - Copy a driver data response to userspace
  * @_udata: The system calls ib_udata struct
-- 
2.43.0


