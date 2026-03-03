Return-Path: <linux-rdma+bounces-17432-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJiKOIE8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17432-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8181F6700
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3E293095950
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685F37C93A;
	Tue,  3 Mar 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gzK4PBwQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410D4384254
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567423; cv=fail; b=LBYKtQPU1lCA76V0+YCD9VDMXti8fu9tQojF30s5IVRD5/V/bQclZXAKlsyc4nG2bwNot7/IJnOEse5XYgJvzMoNw83cBq44QsVt9bjHGVwdHUMlQaDT0LP2ny7K+OO3rYZGi99cAaRfNobBGGo2drqlW/AscXP42VZlK0QeM9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567423; c=relaxed/simple;
	bh=oLeSoNie7Lt/X9nPW+UyoXErttlBW3IlskffajQ+8bA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hl2bMZPLj37cQqXbQpaxZhLIIzgQJVuQZPlDsdfMlre506nQdmmbfNcK3bMH4wrM9sElOwYu4V7kTx3JrtOj4wrGSD5tsA5im4FMRqxaD46l/MCHt725U2dR5ShBzV/W8c40rc3bt9c7K1YhkLJpYThSoqAti24+Phgif6bahgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gzK4PBwQ; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr6+edsRnxFhN0VYDhSSIhIBfot1zK/7+4xjH8EqsLin0WfhevKsdGpZYDeJ1DhIUXwI/nNIaGeXkGwebGLUokLFn2LNVIIf+0PQUiBx70SvdmSOTrr4ODE0DCPGunIklXypoZiVidaOU3yZ4YyfmkuM4oeGD2RIC6Te6ABpnJTy9/AzHsrXHVNNdARU95NU53jQ9/9b3lANjZhT/qhl08B/y/y6gLnPx1MfBivI9QbwK4nfURnQC3YIxITHqy06xHLHAPc0Gx+wn3egp4LIzMFSoR0+YP4Dyc5WgY3jfLjbop1yFI3mW+qohJ4MRLdr+QyKJN87qavqsbjeoPg43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0o/L41vZMYZs8ZEsrHNuQBJNy3Cv/ny7LK2qxu30Lo=;
 b=UzNQIPU0HfVNJ2IOImOrx8I1DxOFth5aNe1zmyEXRPOFt4xnxTKL96NB+a5mfNP4QrUoQZPITV9N0tbEsMemhhY6NIo+OqXYuupjpfpcA6ZLjf+3DFp3fsYfLeI/cmAQd3OtvfTjQTFzbqhjVoeyp7c6lMJNQHXuZb+mpwcm7G/oKnM5dzw4CfLHCrQbJK8AkecdAh5rkaEXwiNeLmMnixmG7GcsaJImiw2wDVKSgT64Ye1Lu7xpbcyzZIpryKv7NwTpCY5zhMHyLHMkKeRQEnyVdZgtTGZ7UxE/Lo5cAdcwVMkOYz+EBk5tnzPZzhTn0O2uN0ppGY52rPjE7Nf+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0o/L41vZMYZs8ZEsrHNuQBJNy3Cv/ny7LK2qxu30Lo=;
 b=gzK4PBwQ9/t+5V3SIZlKkLmx1lEV9wXvoUoeTTMoONm9HhBA/MibZujiu8zxXU64ucMNNWj0tOwArHuHyW0msT96mtgjbnU/mHHZkkQDQBHvK3FVNeCYdeNWk5y519/GXk0nWyOQShabeGmDf2X0w5NH+ADoxeZy1lQsrzEAD+KWvLDLJg/7MQ1+bQGg6mvI7LQUqxawOZaDSx03L4KaJQGQKRVF4cBlzFfzWkbjXGZ2TUAXQA8dWyy/zAXOS0DcnGO/8p2yqksVi48EvtsNxrOSQMyq9z1Qlfr/zceTdJIwsj81rOtY0zcrRFuH4C46p5hxKcFYzTJzdmnWEXhQxA==
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
Subject: [PATCH v3 00/13] Provide udata helpers and use them in bnxt_re
Date: Tue,  3 Mar 2026 15:49:57 -0400
Message-ID: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f34ff13-b173-4da7-fc08-08de795e1514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	aY2NJotJgAWGNgCVmp1fUjSpLNGgeZNfYrSOG3bi35fD73qn9m8dS8NNQ3xXG3YxWo8+juW4DEWWZ/pt96OpwqhADnn64zeDxttCHf6TpZJq+QR6gLbc37G7wA6ASvBR4cvnvQgTpJECfBCqx/D1z3KGxNHWtv461B49MjVLH2a+7LXEBRSSO+N7Z/EzubhkxbMYx5YvLfeDTmAExucPMfH5vj37KYRET025XUZQB3vv2PiPn1Z5T7ZZ7xF6y570uQsquJ0MlemHTD1vUJeB4pP+VABJQMszVTvZdkfaVMOdKOm/sc+cD8vSoS/G/Ivg7O07CdrvA6fMNzmddHNagtyPvS3NHEFQQPkGoHIHeDV47fR36pD4mlE25XbIki4ZGkOLaY70iIOBqzLBbsXCVjCMBlKrJArnhB4P5DfLUobb7dZSRFC2hBtDnrLiyxrb0ZBN+vFoGW67YodBqD/dQHKoqWJExe0f+IrTrnyrbmFU/8TvbWFspjb+MTJ8SFrZQvtJ3eTSFpgc8EK78GvKeHJAyL9gD7VPdKAO0vBh1NKRXERNcZk6zvVmCv4YSJeW8RX3npvZoMhxrzF8wyyCQTGHpgSkDYvR58YZpLC5cJ/xuD4o+ZX7BYMt9SacYjTfrhoTEmiK/W7lIdvTzFWzQP8q2g8mjpmZ1PQ2fI3U5IMjWRGfnn1sjXAPAm+xfzh9H6ixd7QHEfSUa771+SyZcROwxHEZyd5rODb8RTvYOgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NAyw3agLqrOq9hJ4D6W8zFrBRfuS1i82vceCpAw6mDGC+28yrl9ooxbpysY5?=
 =?us-ascii?Q?Jb6iY9K+McBjZ1/zIxHqIbPE2VHoRjOe2S0ZDg6xiZJ04Efx3mj8jx8Z5w6X?=
 =?us-ascii?Q?wBZ66RFS5Y+uAGXHEOtmugj0XKiIURzId3nyj87MvdJnwwhA+RKw0Qhb+Ppx?=
 =?us-ascii?Q?R1GSVsXeb4I3/eIRKmvbRNA7/vhwClO2PI+6s84Iu+peVJejEUO4MQ682Su1?=
 =?us-ascii?Q?6cIeRnc0/Yd0+hINth0DZX5+kkj9AzNQz8cut97nSBkqHCKFsq6zbp+K1LOO?=
 =?us-ascii?Q?rDjBK0MRR9brk9vtcBJUa/BTRDfb+xmxj8jycDdC1SH0daaDUU8KP3xltBw4?=
 =?us-ascii?Q?RkJKkdc5ukRb+sJA2aEmEHt7uGcnb8vWvdd6QppTFjAMnfVf8NsS0kbviL0A?=
 =?us-ascii?Q?0CGSdsKE5ZbM5XUp1BaBo6ID0oH8wxOp704cfRA8cq0V1h9yoR56eB4JB5c4?=
 =?us-ascii?Q?K8bDOaf9gvCrg5TA3M5Wf9sYgabFG7GtEi7VkW5+r2wCzy6WZ+jyyEG9fNgJ?=
 =?us-ascii?Q?HUsHbrr3/QnRWxOuxkPXfMq5KRCxj8vCPe47u7nmka8xtNKy8HHGLEKXCUAV?=
 =?us-ascii?Q?VeKkvrZSK/ix/Tf4S+RakR5ntkV0KxEzftn5FFm3+Js2oV7wWU2lc9oIKwj4?=
 =?us-ascii?Q?81rT0GUIttkpkPn1X69ElraNFdzWcQzyP+RxpdNoXQbHC7/KBfzMZXQZLDMk?=
 =?us-ascii?Q?z82QSEp1YZFpXeq8JuyU0U7InQ5Q7QyNXqUV1+uMBTHYlo6hU6qTCJUccqUC?=
 =?us-ascii?Q?vk3+g1IRSBJX2WAc9AtBUFN3SkUG5/G7pN9SwAPutv3hlkoM7rYe8NJ5TuEm?=
 =?us-ascii?Q?1HYSYKtwFpvY9V6WTTcQESus++b/XMuWBq+v73JlvLHBO3GbDlpUPn+WS8vo?=
 =?us-ascii?Q?bdloUvrUNRFgVWD371YrqVAATwqhRJdtKuUeEM4sAfoYbkqJ9m3HjTKhCM05?=
 =?us-ascii?Q?4BPTP3UhUcKaZcJ5/4tky2Jw2jhfSHQbc0Xvg2G1cH2zNqM32JfKZY2BtSwZ?=
 =?us-ascii?Q?iU7C28zMjASohhcTSgGdlv8ErtigSRr2v0YvF1zsSvnMsls7Ey9VZUDKSa1X?=
 =?us-ascii?Q?YI5ZveOZyI/gV80m1N9PtMnXts8QP9yscVhlqUEe8u5zTvU40uSHQ0WDfFDR?=
 =?us-ascii?Q?wH+ZMYFQkb75EY9sgKuDQcLbANDgfh/8SpgpjfFmc48jh5FbE7p5Z5N6JGCR?=
 =?us-ascii?Q?5gGQObQFwA+exoKj4Bk6azaYH/B7yZU+IX7GhqH9IczM0wCjm/wTKDBuyESB?=
 =?us-ascii?Q?WRfkMLzMlow1TsrLhQkx5oyxm2PwKXDBtAHBjynIcXJ1cNFvwHSPgTzGio52?=
 =?us-ascii?Q?MNaiNJ3ctz8fDpiMZealJgFlACFBIVGkauaWZ9UUv9kiDan11sqqJHSVTbgq?=
 =?us-ascii?Q?MmZ5mHf1+cg76cUqUOSzxXaRpikYpdjfytXiswO/WQ9pjYWHFVEyrJ2IU2mY?=
 =?us-ascii?Q?scl4U0hRFVLVh0cNvkBjOZ8SmfhGp4n0aAzPLq2NVARetdDMeZpBeXEN7+6T?=
 =?us-ascii?Q?WCxuPxLPxYTnC7k3ZAYeqUq70ZrEoxhw17Y2iDfRJY+mTXJgxrRWQzwWCdAI?=
 =?us-ascii?Q?lH4bjub9mKLE/yglwbpeH9LRbTpC9rsw6VV/hBm3DuPUwTLIG+pcOgC8D3Lz?=
 =?us-ascii?Q?aiym6N5Uzwg0mzoeElVYftw9vNbjTlKOjTx24fTA6wo4dC2lTGw+WyR7lnPX?=
 =?us-ascii?Q?s5P8RSQxZBfFeU/577foVXkFNTqUP9g01TV2oZk+ZUEnZx10caAyxEbE6Bd5?=
 =?us-ascii?Q?yvYujpOEQw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f34ff13-b173-4da7-fc08-08de795e1514
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:12.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loUAiQXbNLC4y8Rr1898gl0qaVAjSnWJIqGFxu23cGdHMMXPZKXbDEOwTn1MKWuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 5D8181F6700
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
	TAGGED_FROM(0.00)[bounces-17432-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,Nvidia.com:dkim,msgid.link:url]
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

v3:
 - Fix the EINVAL typo
 - Change from BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED to
   IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA
 - Rebase to 7.0-rc2
v2: https://patch.msgid.link/r/0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com
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
  RDMA: Add IB_UVERBS_CORE_SUPPORT_ROBUST_UDATA

 drivers/infiniband/core/device.c              |   1 +
 drivers/infiniband/core/ib_core_uverbs.c      |  27 ++++
 drivers/infiniband/core/rdma_core.h           |   3 +
 drivers/infiniband/core/uverbs_cmd.c          |  24 +--
 drivers/infiniband/core/uverbs_ioctl.c        |  87 +++++++++++
 .../infiniband/core/uverbs_std_types_device.c |   8 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 145 ++++++++++++------
 drivers/infiniband/hw/bnxt_re/main.c          |   1 +
 include/rdma/ib_verbs.h                       |  93 +++++++++++
 include/rdma/uverbs_ioctl.h                   | 101 ++++++++++++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |   1 +
 11 files changed, 428 insertions(+), 63 deletions(-)


base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.43.0


