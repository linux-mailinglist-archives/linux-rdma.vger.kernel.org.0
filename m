Return-Path: <linux-rdma+bounces-17436-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN8DCo88p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17436-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB841F6727
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FAAD30BDB3D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B13976B2;
	Tue,  3 Mar 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D65eCdZJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C5B37C93F
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567427; cv=fail; b=PFvvotUk+BLk491jztZcMqmuouttY83ZCoAx9yGpqhOe1usyI6NYIsWpsRMmxmTdUrjQsXj9vYIHQQecjINL9uym30IRkKubv4k9QQM3Gt9dWndWnh0aKMpNi14GD5+r43JRDSKaxOtLhs1TeVR8cM9QPNGcaaKYqDP6J08f6W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567427; c=relaxed/simple;
	bh=pZLEIvCH1f08hyfz9ONfZG1dg4F9YcMeiK4TkDCh7ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buAUweS5Rpve+fbKWAfxMW7lwCp+6gxNFhCCkbu7EpjkSaSfzFcRm7v1MYjYx6fZ3PG3mKSJkJoVQ9fR+fptOQ0fDXnnV4fYHA04mz+VClMOfsZH7p1ucsdVp22QYux18ijZFQ9lzYSXOBQq0Fv2bv2+0+YqNa4TClmVdnJCP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D65eCdZJ; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlJdXnotbS6r9R8e6dInJM4sSzUw9N+F+FYbaf49XbYrj5BUOP+IFnl/9JhZ0vm/8uCI1bZGwYOMXxUTz3nm4AzGgGvzbbebn8RPOMlS/oP11T+pDsXkVVI9JIWprZxraeHGXtWOUMG31FICEhuybuMlQCIDHCDuFCSoJD99r1+mRvxxOO9h9JTKosgob5ygOxTlUROKSeHOPb+lLYf3zRx4+ru8MrFGvEfiAFaV+uLrh4kH3HCo90SBkq5Z4j3u1I8Bwvby2jMbOZItTUdi3ne5GfP2Lsqhf0y82x8Pu4UaFFStsA0nw6A5hmAr4gTfIob7wwGc6pX9v40SrRSxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d4+zHFLEDn1Ku4rMLpm2gIwb4UJdC+eVcB5Fcj9Ymc=;
 b=uN/PO3LnEOr3tqgHm6miPISX9ykvGapKyS7j5+p9ZMJEg/Dj73g7nA0A6rUo61ixEeZ+7I/hK0KLIrVD63ot3qd1zWAxEGwP9/nHNm6TIvHkp6dji6W7h4n6fYqaGYC9bQmi8BEkJ1OZ6ErP+RU+6hZ8LHdRrQmoOyQkoPQL++1lsDQivNMDuhZjMotbzdbL+8zT3UZavgpk0b06teTpDC5sRn0T+AH9MgggqQb0qa/CWArXriNYoY86QAScB6dAj9Hg0jptNzOCYvqYMqCwyk9j9Zt3rd+Pa4FmyGGI/HpObq7Y7g6g5ohFS6RaQCFkv/TZyGBHXzBARn2v5zxHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d4+zHFLEDn1Ku4rMLpm2gIwb4UJdC+eVcB5Fcj9Ymc=;
 b=D65eCdZJAlLbY2PUtfvy/3NxJ6cIj2VjX7txoQOBJruv2NDMoepu7SWxdvjuN/GLoMnQ+pF+XxeTTUA+QpXhGof8n2r+B1u6knJDAky3y5fPcOfq3tT0V801XHMlubhGonPLhduoTmtv3uPPy5U4TSgGki4pXfsj2Rr5lSX2Dq6FLQbF4ZHIKtkNrMfmQzTZl69jUX5gdskG+bQigOV5aAO73mwnO5TxX1ygDg3x4PMgY2KTipIrFjd08/DmQF+Kkv+AMBUQVawkz9k1Kx9tAg7aEsBxBBqtQblwszDd/QRPLknq0GVFTJ7WHF9a38rh3jn58vubGeEkZyDXZe3e2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:17 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 07/13] RDMA: Provide documentation about the uABI compatibility rules
Date: Tue,  3 Mar 2026 15:50:04 -0400
Message-ID: <7-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0459.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: c41dd49f-ab0d-4135-9a5d-08de795e15ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	pkcG+QyxjeNAUhQBExy4WerX8hmeCNr7fIjLIxKlAU4PVskZXk4ZdLCEg76+fKqJS+i6fgyLsp3ankOx45ziwFy+gP3c8L+oaLm0FFpwl5hiQadvbfHldWLoCvBxQjWsmKJfOUcMNgIBia7XL1uUUOe/gztz4IinD0+krmGzZEC9hF7H31F0FiLvpyQLIeE+pZN47EZiTC5mOH9GFPq9+HIPaqB9kwRmiOpyfrA+Ro9roc01Hwr5wfS9O0AwcqG2ZTZ1sPoVympvTbVF7/kcs//eEG8F6EBKJLSDQnLC7F06JtkF/alSrfJHzM7OQsetnj5yRwD0N4Sa0AQB2O+azMuRYUTat1+72nCLdd50vUHlXVDPLIo2s7GcOUMl6p0l1iVqi5dtY/OjdhUYMmSL5pO66engMqTOlbeoTEj9nKUNssMpwQVWi6KE7b2zRcg0S6cz7mcmBr+W+WvegUja2SFWjhmzyEj4cXg+sH6m2lE+tIF0qGNLM6Oe67puWixZ4kEurYtZc4Dg0Ej+x/M0Cel6rwG7ZvfGfhXtttY6NhE+d6r1QXYcf/yuSToWQ5kF/GrADoIZA4npkb+ZlYzNvg8am8pVqIzCZ29Gg5CdjhKwivZzTo8TvOIxbpLBDggrC8f0ZkrLAPI3XdImcdzmLS+37DRwzveGGDKzVkeYvCtfhy8D0g3hj9sqBcqvDYzE6fqEChqO4x+n/T40mmo2KC+ehREIqYfYWPfdlLkvq0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BYI9C0aYpZ5172vrgqzjKJsIIu0jxWV+04cRxn1bdbnYo/0w4RlmA+y5S0be?=
 =?us-ascii?Q?KoE735fACbLmbnN9ZMDpgB2FmJgxzNS4WBE4CaWJdqIsNaeZ9MxJXblD1Gny?=
 =?us-ascii?Q?eOqayUtcDpQ/eP1cMlqDSeX5HXUvZXfdI1oUImO1NiAMOBuBmE61sWLGfANR?=
 =?us-ascii?Q?/yYKAR22Z9P2wyZbr7I1IQdNwjNj0wa1l392OPPRLacnX0m5k9nZ+FIxQ2P9?=
 =?us-ascii?Q?aCcyqtQi+HU13VZE/OaVd9Pr4sAfPPGKGKrCDlpn/nKRWeqzeLu+Ks/QOVmz?=
 =?us-ascii?Q?pFoPD69ZmnhavLUpVRjjVEAyO2B171uGYArSf5kOW+5QmiVOndRc/IDvMwSx?=
 =?us-ascii?Q?S1Rl3HFZNfOl0sUwJsvz38yn6kTCZmbBIMc1poe3SNToydu43RoFMsAKV7G/?=
 =?us-ascii?Q?4r0LtaHPQ4MBO7sJ7xFogaMwW5zy+9aKQWFWS7sp6AnkkdbVHEW0lnyOls+g?=
 =?us-ascii?Q?4hx6ZyKMkk+oQKG9UloQ8gLsJfgEOgWvM2I2UbS+FhPF7YXqdjZt33z1wp29?=
 =?us-ascii?Q?tzMRGPve+T1bwUL9/1ywouxUVeHY5lfvC5BKHhRvi+52QlvFVYFBHnA8cx1u?=
 =?us-ascii?Q?XMqOLOAKPIEyEKK/sByChiP/jMnAVZeWNQd1VvKjFrjxN9KGM01gt/ozIk2i?=
 =?us-ascii?Q?BWeX8/a9h+G+H2Y5+3OiFN3448khrq6OP0mIdJz71NzFpdxNh8zOzq5XSIvt?=
 =?us-ascii?Q?Xh5JxagBrPB6oN8157f2ZMoyVvItFu2W6E9rJmcYw7KOUk7ZwvLfiVpqfTSx?=
 =?us-ascii?Q?AdkY9EvDB7P2DgqMMZOOyoVFWjLBG+2dLSMefqL3k9M5U71r4TdNC8sbXPyz?=
 =?us-ascii?Q?h2MRlJv6fL/M1EFvBNd+hMS+fTdcxlXJRQq1oxNMwwH7g2A4uHoNybb9DiNI?=
 =?us-ascii?Q?NFvXbk8WuMpwR32cWuP3sTPrlSw+2Q9jkoiZI0bHwifxAaC4rSLbmY0Y+krk?=
 =?us-ascii?Q?k/JJKI6A+x0PouKv3/FHGOkxdl6qwi9Fmc/hGtx+G+qCYS95jbC8wpzjt1h1?=
 =?us-ascii?Q?2AjtEMrsA2wmidcssuuBhYZJg0/apIYk7cphli7fWQM4RHlMSTov7vEs7Ty3?=
 =?us-ascii?Q?m/rU37fG2/LqrZXvKBSgtPLiLrZ3rpJXqvISl37bek76h0tZsTre8rbhFbE4?=
 =?us-ascii?Q?drwEcVKiM6OrlzuxKx7U894BecRJmovDx20D1pJcb5Z7CYVvlOzxSVgtVgie?=
 =?us-ascii?Q?p+tsn3aBygxDwsDgVjZ8+21fdEFsCzX0cMNIli9t1Qmyiyw8IRc1uVclhzen?=
 =?us-ascii?Q?C71dsnOpcUy5poRCcdkAHEWf27pM7dBCu5kZonkp9csnVuH8AAmC74KgfAkn?=
 =?us-ascii?Q?LToGOgzflBeondFqBVLzsKS2wXOledQKAOk/2W8JOcoJK31nNR/3g/K/TOdz?=
 =?us-ascii?Q?NI9+sNHArvRwE5Q5a/gzXrIIAO1d0LmdscgXhqsvo7C4z3m4u/WmbTiyrRev?=
 =?us-ascii?Q?KikiyH+t0qXerBpkUnXaa8a3SpcLBouTc1oPwTbEE89cXuzxcyWkw2xr5JAR?=
 =?us-ascii?Q?5r2amTS7D/N5lAAvTpsOYpN9s50DruWcSUiSP/Ig2qByv/kfYRoAD2Aaq695?=
 =?us-ascii?Q?yLQakBk2d2kbgcuABpA15cCG5LD5RBQ7u68gJi3Cd6CTAwHJ7rCp6jGLpSC/?=
 =?us-ascii?Q?ONvWEcdgZxsnilMNhVWc3fHHNewrHsV6VJDBKZIP1ku7ZDdHl+8pfkUbMnpS?=
 =?us-ascii?Q?6u3qg/wh43WXqJeRk9S/PS4jTr6UsWTJcH+1Nn5sOtSL7NomozUZBKi24uFE?=
 =?us-ascii?Q?NRxMWFi/zQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41dd49f-ab0d-4135-9a5d-08de795e15ca
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:13.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqnWxoWuqc3oU7SjRw6421OdJKBQ1nvTi9wdUvpj9IcFcl96/LKyS+7DBwo9o7GY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: DAB841F6727
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17436-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,broadcom.com:email]
X-Rspamd-Action: no action

Write down how all of this is supposed to work using the new helpers.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 87 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3f3827e1c711d8..e1ba20c3974f08 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1576,6 +1576,93 @@ struct ib_uobject {
 	const struct uverbs_api_object *uapi_object;
 };
 
+/**
+ * struct ib_udata - Driver request/response data from userspace
+ * @inbuf: Pointer to request data from userspace
+ * @outbuf: Pointer to response buffer in userspace
+ * @inlen: Length of request data
+ * @outlen: Length of response buffer
+ *
+ * struct ib_udata is used to hold the driver data request and response
+ * structures defined in the uapi. They follow these rules for forwards and
+ * backwards compatibility:
+ *
+ * 1) Userspace can provide a longer request so long as the trailing part the
+ *    kernel doesn't understand is all zeros.
+ *
+ *    This provides a degree of safety if userspace wrongly tries to use a new
+ *    feature the kernel does not understand with some non-zero value.
+ *
+ *    It allows a simpler rdma-core implementation because the library can
+ *    simply always use the latest structs for the request, even if they are
+ *    bigger. It simply has to avoid using the new members if they are not
+ *    supported/required.
+ *
+ * 2) Userspace can provide a shorter request; the kernel will zero-pad it out
+ *    to fill the storage. The newer kernel should understand that older
+ *    userspace will provide 0 to new fields. The kernel has three options to
+ *    enable new request fields:
+ *
+ *    - Input comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Check if the udata->inlen size covers the field
+ *
+ *    This also corrects any bugs related to not filling in request structures
+ *    as the new helper always fully writes to the struct.
+ *
+ * 3) Userspace can provide a shorter or longer response struct. If shorter,
+ *    the kernel reply is truncated. The kernel should be designed to not write
+ *    to new reply fields unless userspace has affirmatively requested them.
+ *
+ *    If the user buffer is longer, the kernel will zero-fill it.
+ *
+ *    Userspace has three options to enable new response fields:
+ *
+ *    - Output comp_mask that says the field is supported
+ *    - Look for non-zero values
+ *    - Infer the output must be valid because the request contents demand it
+ *      and old kernels will fail the request
+ *
+ * The following helper functions implement these semantics:
+ *
+ * ib_copy_validate_udata_in() - Checks the minimum length, and zero trailing::
+ *
+ *     struct driver_create_cq_req req;
+ *     int err;
+ *
+ *     err = ib_copy_validate_udata_in(udata, req, end_member);
+ *     if (err)
+ *         return err;
+ *
+ * The third argument specifies the last member of the struct in the first
+ * kernel version that introduced it, establishing the minimum required size.
+ *
+ * ib_copy_validate_udata_in_cm() - The above but also validate a
+ * comp_mask member only has supported bits set::
+ *
+ *     err = ib_copy_validate_udata_in_cm(udata, req, first_version_last_member,
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_A |
+ *                                        DRIVER_CREATE_CQ_MASK_FEATURE_B);
+ *
+ * ib_respond_udata() - Implements the response rules::
+ *
+ *     struct driver_create_cq_resp resp = {};
+ *
+ *     resp.some_field = value;
+ *     return ib_respond_udata(udata, resp);
+ *
+ * ib_is_udata_in_empty() - Used instead of ib_copy_validate_udata_in() if the
+ * driver does not have a request structure::
+ *
+ *     ret = ib_is_udata_in_empty(udata);
+ *     if (ret)
+ *         return ret;
+ *
+ * Similarly ib_respond_empty_udata() is used instead of ib_respond_udata() if
+ * the driver does not have a response structure::
+ *
+ *    return ib_respond_empty_udata(udata);
+ */
 struct ib_udata {
 	const void __user *inbuf;
 	void __user *outbuf;
-- 
2.43.0


