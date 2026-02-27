Return-Path: <linux-rdma+bounces-17263-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMi3I0bvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17263-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 492C21B1653
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E95C7304275C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065D3280A29;
	Fri, 27 Feb 2026 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/4UHdDJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8561E2765C5
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154686; cv=fail; b=l/75Oqb+vT/GgRySyEv9F4s8zq4OVnI/K9cY08Z08SsvKej9U2fgrpvkJkKcdBLzTNh6RrIKGZXyLMZ8sxXlAuHDl4mTvsAyam4cDA0qz4gvAs0WjsnVubhnR8ChX29AecBQi+bsGru2iaPZq7lWF9sN/mdR9oN2NRJQ2OjHGP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154686; c=relaxed/simple;
	bh=HfiB/i0zmj2Hj9X81EMQ/CQvCE7HL93oIx/50Fiig0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cQaVPjN1AbZ82s5Av1Mkf6QxgB2HgUlGq2b5uNioPVODDCSa+ZScHv2uDhW31ujUoRw4bAcB+qLVBfpUcJDfHyplKqH9PavAcsFXeMS6OgNTJA+RH0L8cIoh+xAev/OY8PhV5+CjYg9QlMTBSSZBoYm6s/L+L21Vo1w5MsuGFdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/4UHdDJ; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKXcq0/9ZPF9TxG7p+kugcNerLpKVuSJS8pY0uxmImvrSkgRQo30aUF48wWZHLMElxC1wbuMMq/jf05p+efFRK1IKxhzbAOLvoPYNRBTPWVMUSDv8Z8ymMQtwWu2RAVJlkNW9KNUoYZy7VDVlul70DHhQlI1tXa8DOUWO0lqQX9iggD8hCGZ015AsVC/lJMtAQcJaDkZwL+DIni0mlDjBOKVwgDbF27DnG6jHHy5rmDaoioDHmvSg0C1EzGyliHq8gQazQ8yc2iWqcyGmtdjP1druCk7erSbavt5Afay+R3YnAZapR12M80If+UqL0w6otBZ9LoqKZwS0zQrcQsOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJMnlo9GhZdyPoMScVXZVjt5j3fVVs3Y6rkc6mUnINw=;
 b=MPvM2l0Ec1N89HhoE06VoF2mggCDkV1/FCVhK3XbWolrcAuSTz0JTiW73Ga+rNOJIc3nc9DbVCfiezAaIKJ2yJg27arBDjhgvW+MQXC2U7K9EuCkAzlvr32XkeXKgaSfePCpEyOEUpt7tF+avexNYW9Ri0J4YZyl1t8Kg3DFhZeZJJicz5tZPPRW+wBvuPp8VnwFNh+nC4hXE9OXtKu83TBnv9IdUcNnYkD8HBMBNR8fy70UyGJTyZZQOjIszWsDigJWV6lBBi61Bqp+KFY2EnFrQlak+skuwheOFRWXQx1tTsFMCoylm6vr4DJ10oLbKiNmCz3nM2QerwbfcE8OFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJMnlo9GhZdyPoMScVXZVjt5j3fVVs3Y6rkc6mUnINw=;
 b=N/4UHdDJxIriLhdzWy4UNM55CsXvbIO4oSYDwX48GiPuzNlM6XjZPd3E1VEI5Au8lXjgyUmKCUPhYD1a7YNPDMTsoYbH0YKDDPWz2C+qBnnBKAfkPaMx9uC5hnpZS4TaRdY3111KJTZdSQpQlLGwokeiXG/wWT+91lsD8b3Sa1nV9CIZHNrB+YyhBAfxhupPSKi6CO5YaCq7809w1aKLR7DxizgbI9vsbPd1GdgmMmFlKsz6j1ZpvpLpB6XW49LdBI6YvvMDEee2gH1bM+rzupsaYUJIxLo3wT8omxBYl3QoZAYZm9CdwXhw120pAQXRgQ2LXGxs7UsVoT2l2zOBaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:17 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 00/13] Provide udata helpers and use them in bnxt_re
Date: Thu, 26 Feb 2026 21:11:03 -0400
Message-ID: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d50c7e8-f307-4c67-0cee-08de759d1be2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	bFvHCyBJH27ToDTFW/GgEK06/9fJ6rCgVy3k1/YlJzcaJ6SBa6yt4fTKN7IqxVzyye/3cF/FZCuMO9xTLMB9gPOZ8sOO8tPkbWauNE562OXvO+ARon2mrL5C2C6EpKakY26R9jje8ue0nkm5PVpUuHlpv8prWIIzrgxtZv3QDIrdOVR8nVoRNkFY4W03cNtG+Ecp74+f6J+REWI5Zk4YDTnZ6iM1Fy06LAkdfGr/6n7BA/04OEYaovejJASSsNz4OIV70WVlyBgbt70wICxRro4PNfSpR+45ujrUZtUh/ZdNOiIqzEwS913qs/QWoLsaKxhjKb43kH4qD77GjtlGk+/QR2ebqVXXhAOrzS1rifVsEVRAQuAmmvYrVzDm/WYcAHK91EzHj4GSHnBGKsGnZzKUnKZKYV0iJfOSYOtMBmYCIbrSu3cpbjV0zytvfxdZoI1KXgAgjMcugptrmnDmwohH0q0AgiBdw5U1vVBkJ0EywDQtsNFaAJc0s9DK662Xzd5OtCEO25VMyxA43E0G+yd2iBulG4xgQ0TWlufZhuXzL+QcyHO95esMNYfdGtf1nCdeY+9Cs9dviPBXevKbINrT0NalJZIvEnF3o29z4tC6wAheuNxKslCHFaBBrb9WF/aFadmg/GflE3AVEmwtEH12TKHF3EnL86HEIyCYymHNvCnBTCrSQiYC3HqDXb9Le6bohLBGGRxl9p5Naj0KIfAYyPD4roxKX7Xp9z96+vU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/i6gFuFGSgpgFTdAaWMHi3Ey2/R1N81PE33HGHsH7ey7zx4YpSxFXNIsvp8?=
 =?us-ascii?Q?rE1RFaKoNHSB2ryDCS0pZT9hWq8Fl0nuHiBFA2C0Dfw9E3HHaMBHale7rR+C?=
 =?us-ascii?Q?1F0jdr8mn5g0ebruG5Y3VjYKBZL4d84pUa/3EO+wpgKUKANy0/9zWwkWRxX2?=
 =?us-ascii?Q?DkBs2VkIoi5BtJb4yptp3noO0tl8oOmvjIs+45d9CvxKDdqpHWCXnXis8F5t?=
 =?us-ascii?Q?bBoXHOnCPcQp4ACCghajh752d1lU5tLOMjV1pFJW6aLAasMAXzJgjYa970RI?=
 =?us-ascii?Q?4Pxv7GZELS2tW5czYdmzRXRbUadDnlNhASdN9/Xn8NhIEt9MsGY6qSL2tBRI?=
 =?us-ascii?Q?R21QMgYOYxpFeEPAe0h+3SUvjJSBc6mlVjAiEiGGJRS97+epTiE5ZMMtv3ft?=
 =?us-ascii?Q?sA+LpSY3cX/hSmt+JOjgcTbTVPuziR6+gBt+0gLdmF5alkh+OeY0iejR0kus?=
 =?us-ascii?Q?waXNQDul44f5xLLQudce0deqDq5EsmPpxelYyr+ySRXUsT0ny9HYlcOmvOZm?=
 =?us-ascii?Q?U/YhVgdA4VU5yWIjyfVBF0KQKNGRY/vq0T2OddDKHmnE63LNUPHtXapfZrNs?=
 =?us-ascii?Q?sLqFJQ5rXpc8bMUxViezCG3DuNAEFNtBLK2sA2q2sjGKTOWMZAaFpuTyK93/?=
 =?us-ascii?Q?Y1uocIGqhKRlwr6OP9Wa2JxwpEHRaesVkovlW0Xu6jsSsJuc8tRIieGexBYo?=
 =?us-ascii?Q?M+b5G9sjmDJSu4kKWZDefCI9owCrc/6QEIOUHIfqy3TdoyJbydr4oWVxeyjS?=
 =?us-ascii?Q?/J/wOIFb4iYzmJoAI1RvX6uIcftRLSuChBcHdKHa5QLKUNbGKOOAFJ+ADSK0?=
 =?us-ascii?Q?dNaJzOYmGyoUiD9gSgeO7mzum2vP1ifeh4GG1qmqIy7+1BEHYLcs7rtMzzn/?=
 =?us-ascii?Q?8g5G3g6X7rCmDboyPgibmj6EeBfH1ouyUbDo2U76wqnCW43dhAjr6Aavlr1G?=
 =?us-ascii?Q?ZKXQfBZZ26uiZFCsQkjypVdj3IideexaR/TGYmgSghvZPc90rJa28puD5Yyn?=
 =?us-ascii?Q?mjyTVoVeT63RCLiX+QYUS4o2J3MeZrip59MkrS3rpC8QY0wA3otwghSubwSF?=
 =?us-ascii?Q?vxv9f89iIjaeze0v087WgMdC7MdfyLffxsbbXoGKygsurzB0ZWw+blwihnnF?=
 =?us-ascii?Q?vCbqSYQ4mhNVKVB2obajiqAPfV9t3o1VFHqv2amUnEazkCv13oT8chGoKa/D?=
 =?us-ascii?Q?WWy61XYqxrsk9abC9NkObyOBjL7l2BzkL6RHzqSJLXn9J3O6LhNlruviUVdZ?=
 =?us-ascii?Q?GvjT85ujKS/wJeB9TN1wwAqtiKaTsc/5V8Ja0vrW3bgDCFOGZtJf8mFOQss+?=
 =?us-ascii?Q?bV1zszXRDFm8S5LYPho+gFnv5yh6T1kojvqvUiB+46yLfgyeSzp3YRcXaYln?=
 =?us-ascii?Q?CGwOT6FUJC1s0Y8bYsR606G0zDApU5cE5cLg+JAKtIe5MApYMJDSGqeQsUcX?=
 =?us-ascii?Q?vcmKayg76gTbji6B1O/xKV4nvlpFt4KxBZum1L/3+rGnsi9yWPrZ3b2UUqgV?=
 =?us-ascii?Q?gxbQXy7c02p3U/B66UnCRahoFPK7uiaTtD7bo3gh3T5j0HX2M8JNIcZsxalq?=
 =?us-ascii?Q?uZXzVTcjLDzqnGV6SsLwCeNwor0hxo6EOJ55zxEp/KjTqjoP2yFN1nKe5+WS?=
 =?us-ascii?Q?iIKOVcAzgPHKgmOb/I9BZuLCsyNhn2sazI7uVrnaBRJv2M5Isk8u3uEDiNVm?=
 =?us-ascii?Q?HA31565FTIfMgj7rHavjGx1W3b8xvwSAYRjezR9FgMfx3gTFYIUGzfm4gwe3?=
 =?us-ascii?Q?HPSistnIjg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d50c7e8-f307-4c67-0cee-08de759d1be2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:17.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4m1epyWSdVS01y18JPKxLofTowxY1CTXEozyVUQx6zIWw2ZAcqfozQI+24eU6mG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
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
	TAGGED_FROM(0.00)[bounces-17263-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 492C21B1653
X-Rspamd-Action: no action

Add new helpers that entirely execute the expected common patterns for
driver data uAPI forward and backwards compatibility so that drivers don't
have to open code these.

The helpers were developed by looking at the entire tree and moving every
driver to use them, but this series only converts bnxt_re as it has a
pending series to extend the driver data uAPI and the lack of correct
compatibility handling will be problematic.

This handles both the request and response side of the udata using the
following general rules:

1) The userspace can provide a longer request so long as the trailing
   part the kernel doesn't understand is all zeros.

   This provides a degree of safety if the userspace wrongly tries to use
   a new feature the kernel does not understand with some non-zero value.

   It allows a simpler rdma-core implementation because the library can
   simply always use the latest structs for the request, even if they are
   bigger. It simply has to avoid using the new members if they are not
   supported/required.

2) The userspace can provide a shorter request, the kernel will 0 pad it
   out to fill the storage. The newer kernel should understand that older
   userspace will provide 0 to new fields. The kernel has three options
   to enable new request fields:
     - Input comp_mask that says the field is supported
     - Look for non-zero values
     - Check if the udata->inlen size covers the field

   This also corrects any bugs related to not filling in request
   structures as the new helper always fully writes to the struct.

 3) The userspace can provide a shorter or longer response struct.
    If shorter the kernel reply is truncated. The kernel should be
    designed to not write to new reply field unless the userspace has
    affirmatively requested them.

    If the user buffer is longer then the kernel will zero fill it.

    Userspace has three options to enable new response fields:
      - Output comp_mask that says the field is supported
      - Look for non-zero values
      - Infer the output must be valid because the request contents demand
        it and old kernels will fail the request

Since bnxt_re has never implemented these rules correctly and now does,
provide a UCTX flag to tell userspace about it. If
BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED is not set then userspace must
not use any request or response fields beyond the current kernel uAPI.

Using any new fields is only possible on kernels with the flag.

A series converting all drivers to these new helpers is on github, I will
send it later:

https://github.com/jgunthorpe/linux/commits/rdma_uapi/

v2:
 - Revise the core function implementations completely to use
   EXPORT_SYMBOLs and integrate debug logging
 - Have ib_is_udata_in_empty() return errno so it can propogate the right
   code in all cases
 - Remove debug prints
 - Rebase on linus's tree
v1: https://patch.msgid.link/r/0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com

Jason Gunthorpe (13):
  RDMA: Use copy_struct_from_user() instead of open coding
  RDMA/core: Add rdma_udata_to_dev()
  RDMA: Add ib_copy_validate_udata_in()
  RDMA: Add ib_copy_validate_udata_in_cm()
  RDMA: Add ib_respond_udata()
  RDMA: Add ib_is_udata_in_empty()
  RDMA: Provide documentation about the uABI compatibility rules
  RDMA/bnxt_re: Add compatibility checks to the uapi path
  RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
  RDMA/bnxt_re: Add missing comp_mask validation
  RDMA/bnxt_re: Use ib_respond_udata()
  RDMA/bnxt_re: Use ib_respond_empty_udata()
  RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED

 drivers/infiniband/core/ib_core_uverbs.c |  27 +++++
 drivers/infiniband/core/rdma_core.h      |   3 +
 drivers/infiniband/core/uverbs_cmd.c     |  24 +---
 drivers/infiniband/core/uverbs_ioctl.c   |  87 +++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 148 ++++++++++++++++-------
 include/rdma/ib_verbs.h                  |  87 +++++++++++++
 include/rdma/uverbs_ioctl.h              | 101 ++++++++++++++++
 include/uapi/rdma/bnxt_re-abi.h          |   1 +
 8 files changed, 414 insertions(+), 64 deletions(-)


base-commit: 3f4a08e64442340f4807de63e30aef22cc308830
-- 
2.43.0


