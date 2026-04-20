Return-Path: <linux-rdma+bounces-19435-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDiyCsgZ5mkprgEAu9opvQ
	(envelope-from <linux-rdma+bounces-19435-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 14:19:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B787A42A94F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 14:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02C70300D1EE
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Apr 2026 12:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAECA386C3C;
	Mon, 20 Apr 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kojOflWI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065A288C08;
	Mon, 20 Apr 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687556; cv=fail; b=Ih8oLdyVWUpNPBWQ1QSfUAZDl/4C0UJVFUjJmNvlLFS+orhWVPcK77M8Cf67zhLd7vdwQa8S1i6BbsFRIExnoO4gIClm+Tr1LwGOQFO3GSr+II9cLFadkMg4UeUu9xATnrkqANF4VAgYSsorZf36s4uiS+gV51hZ+ZsI8Eeht0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687556; c=relaxed/simple;
	bh=BSCvmsXrJImceb5wz5PIQTlmGFF19RoOVmP8WIpB2n8=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NUjyYki0dA9cJSQeL6D+/3aL5v6PUEYi8SV5in8/YfptKne6ugimVH0H+s8/f/W73iLBJCCe4BwR6tMZTU3rxznPbDGRwMzDyjP4ungXQaoUYuFDfoRLXJ7nYvofXRM9y9YPx5zZ8rFy2Os8yIPCqmpGPZBj+X108SWXaEGm3sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kojOflWI; arc=fail smtp.client-ip=52.101.57.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tjc4kyk40pzgWGdT+fglEjUB1kcMYWXUSNczUXlIz7hIxzwTEOUjtM2T/YNdZJCjitcWAzMb5peQebBJOryWaLbVuYo+rtT0Fd8aIf19q1/XhjL8y26aKP+Hqgykw2BNU7wJ92yuwPqlid2L/tZ8SJwCbvkb9f75vUSJFTo0PJWh+LSMTLsw5R/iMD7Mri/7nPiosSmDaoke6X3HMIaV51kDm5B6hwToAUHgkca5a4zJ/5hOQgJHE7yfhZBn+xD0o/FnYtvvZARipDGNAmZQHuS4Acq0HVfzeeMv/oBffiaKrd1bt+zNehpd1SatoVEnoBkpVtgl1DrJTeGMVRZEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrvmOJZikeRqen0LBmSGCL2ecQOm4s8jsvXEDkPrm7A=;
 b=oPH/DSVGUkzXWXmMHE+SfqpBDDHVTkocAkG0oFDVm2ucL5LMkncruhdOMTNILvXGD9xCAP2ee6akhIPEN1aAReB9keTENLUqrIXb59QxTjRm5yYknvOVgAwzMDQfW68M9wUSy/U3groCTgtmaRdifADju7LiA0j9MqqAXGiRbCd6xPReKwl4JX+F8ZMeyjibe7DFyEZ6QXAWnwLzdA2IifjVZZyxkX6XrCsXefygzxZu8nt2W8/iBNZWFKElm879qBuFM8JOem0OHa7H6ozbVDpuS3U49WTXTjNHiZHTbPKAokSSk9B7Hk0+5lncaxGFTMZlpenbRjkINPWLpxPz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrvmOJZikeRqen0LBmSGCL2ecQOm4s8jsvXEDkPrm7A=;
 b=kojOflWIDwzMzFni+S42N+j5B7wf/nQ+ORJkf2k4a94gFffYhj7Od7Vw4FGaCbkqDrid47WHvUbVlJ5j2I7/VDjqPOz2Y89xZN2IKtrvx5dMKHmk8OwTx6tUp3d+J3Y59AwzSK6Ts+M2/R3pzsoCF02mMMljfaPD5aJpcMTKcLKxO0pYTLYJHlNlVqDpaWZurqkBmMl5V4kmui3J9HdtUjxfwm7rD/qdPcqJK3AquylcXptUL4RLLU5S+T3TLxOMWEYGJn0hoQns1Ps1gHUGVZui5kwivgpobFM3prn9dF6+V1JnubWKRBTPewDFA2d63lD5XREtQcsos/SKaIFqmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Mon, 20 Apr
 2026 12:19:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:19:06 +0000
Date: Mon, 20 Apr 2026 09:19:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260420121905.GA2902776@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y5f5CzfEQM9IqwMq"
Content-Disposition: inline
X-ClientProxiedBy: IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: aab67b56-3f52-4495-682d-08de9ed70424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	d4jIwgjH4fXC+88aXb1BzrZBuN0hl0Qu2m3FcyOORtjROq90WXle861MYgXyGJfIW/6F9YjCyVHWm3kLPW9Xt2sfR9EXwGUij+xHiHo8DV0IWGyXDkW3/AWXg9bOj4wTMAR3ljpHttA0jtSLbPdrcDuaJ/qQX3vevZwzyLIpdAw3mMPo+ChecrOMl3Ly6Wyn0mWSrLIGvS+jj0CBElzWJg08GC3/aAI7cx3HcaUE78bT/qb2LIfjkpHAMGgrRG60UPAX87oApZ5isfJ00Mvz3DwFuf66t2ksirAeIdWxLL3JB8+JzeeAYoSz9L6pH1mVGEZPKqYe30UnHWCg6D7rG+gJAYCXpPak6aCwu1X4QJZaBXU6AuQs+JgOdHQY59glMV8dmfql2+oxwGGvGMh8omQnsFww/rzWNzI71y1QHFLfX3L8OYJ+nGSoL0V0iXy4egaJN91vijG/cvRxk9fgSSSyrzx62eVNcrm3cQCbCpIPmwpXz6C3BTBhhWx/s4WXwiXhtVlFnT7D1wDvaFghqWm+Y0FWE0HFW588Wq36MMIbPFELaWamvRDExnqhgiIdnzVmyY1nN0Q8lzrCuhcUTfXNl4m61D7/D/jjTiI5pW3xQSaJBzcoo4KQItCXq4tk5RtqLoiu/9EFgzuciRrmfvRaDgAe9FpF9UiXKuxaLDLdgIoVVPEMYRvtsUArl9I3Yrb4rz2KZZnCQmPw/MtQcPlq0qNzm1YhTatFo3fVK9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGZVSjFMRllWYmxWcDVmTnQ5UlBJRm1nMDl4UXJNd1d4RmZjNWphK1ZZYXJX?=
 =?utf-8?B?dDlsalRlT2RjTnpnaFpOcnE5RWZpdWtZUFAzd1Q2MWtyL05OcUtoWEFUR1cy?=
 =?utf-8?B?YVJjNXlocXZJUk5hUEFiRmNRamhyVGorYXlNT241UjMrbXZETHJJWDh6UTcy?=
 =?utf-8?B?L2dhbjRNaXlNbG13OUZlVktkek9lMko2b2xTK3VZSG1VYW5YcDd0a3J4WVFU?=
 =?utf-8?B?WmxxMkN1dFNJV3NnZmZkanlraFlCLzFpZWtYOEFtbGpkbjhhdXVoRnN5WjI1?=
 =?utf-8?B?S1hUYlYxRFc4NzZJSWRNY1ZUaGZ2bWZET2VWSGtOL0Y4dzNxL1huUTNqQ3Rt?=
 =?utf-8?B?Z1NWUUw0RnQ3d1QwT2tBOVovRHBlZWVZMi9VRHFYeldmL1hPVDNuSmJLZWFZ?=
 =?utf-8?B?OGEralcwdk9LcWhQQUc5Uzh3cGdXZjdxaWUwUTk5MDVaNlRHeGtrM3hHRWRM?=
 =?utf-8?B?S3JDeXUxK0J4aFRUQWtpdmRYcy9LREsxcDNCeCtScEt2d1JUVWs5cyt5Y21B?=
 =?utf-8?B?NUE2czNkeWFuRGg0eGNoZGNxZmlXSmNRbGVUZ3JiWjh2WmZ2cngraXdLb3JM?=
 =?utf-8?B?NmRTU3gzdlR5dURyQTl3dkhPUmxEVzcrUHA0MEIyNks3azBtNHZ2OVQydXVx?=
 =?utf-8?B?aVJ1MUxabytTVDByUkxFVlFaODg3MGFPcVE1R0xnbENvTno4M1JSNW9YeDlk?=
 =?utf-8?B?ejRrQXE4QTVWMTI0N3JxeEttOGYra1duQVlPTGE0aXJlN2srNWVEdlVYVHpp?=
 =?utf-8?B?K0p0a3FtQTV0WGovOVRKUEMzaWpObkxrZjBPRVNWbnZyVk9mL29MVEFXNmxz?=
 =?utf-8?B?eVNuQ3Rxc0k2andlelMxNkVhRTFLT3dtaGE0S1JQWFM4WUw2eEppUXU0OEtX?=
 =?utf-8?B?d2lSaU90SVBoVC80UVdZM2xFWVJhN1pzUGhOZVFuL0ZQei9USWl3NkMya0hy?=
 =?utf-8?B?QVRlNXAzYjZNQURTNFR5THRHQXVGbTRlWDlBS1l4RUlDNGgveXRWVHhVZ3Zx?=
 =?utf-8?B?Skd6K25uaGVocHZuK3JuN0lPTmgzK3NwdmlRak42NEg2a0VTSm5CSVptZEVi?=
 =?utf-8?B?NFNHaDEwUURwS3F4SEVtQWpwZjlrcExmNGo5SVVORmxPWk4vRW5EZWd5TjZG?=
 =?utf-8?B?V29FeUdNdk4yWWxPTUVHTUNabU9lQzRoQ0YzZ0ZSTDRJQTdoV0tnZGJjN1NP?=
 =?utf-8?B?UEFzUHZNRnVmVG5UK0dkelFacVVURFd6NlpWUFc5UVRza09SVWNFZXNOVlBR?=
 =?utf-8?B?Zmc3RnQzRlI4K3pRaUMwdER6VTQrTzNtdXVxTzN5a1VtV25va0I5U1dVSFRa?=
 =?utf-8?B?WHBVMlRwQzF0bktIVkFZZ1hlejJCMG41c3VGYkZBRGFHY0dVUENKWGNIcGJT?=
 =?utf-8?B?VXdBZlJ2UEh5SXhIUllHVGFvWjVDVUVvaHU0YzE4WUJTeklSS0dNbDY0QnRm?=
 =?utf-8?B?WE91cE15aTREZ1FzQk5XaXB3emc0eXVaOFhvUFUvTFhxMm9mUXVqR2V5dEpE?=
 =?utf-8?B?Yi9QZmVTNE9PYjBXd2huQlh0Vnl5SDlTVWJ4SjU1NEZRSWRxYkJFdlJYMmp3?=
 =?utf-8?B?UEVsU2hHamFmaUdKNHJKb21lS1pkUnZqS1B3T3lHa2s2dTFmWUpUcWdscm8v?=
 =?utf-8?B?ZUhOdHhXK1NRakZRTGZmSWhyTUxuVUMreld1QkpXY0F0b0JSelFvTEh2Uzdj?=
 =?utf-8?B?eW1MTG1DNkJmVFJ6N1FqdEtqUm4yNlI5cE1yZ0JNVW5xRXVWUVpFUVUzb2tn?=
 =?utf-8?B?aHBEcjVpVnpnQ1RMZVdjbVN3SERBYWZxRDFNVlJHdjUvZWloSEdraXphdkNE?=
 =?utf-8?B?a2M3NVZsUVFXRDFUWG00U1BZNWo2NW1JcGdab0hCb0MyeTR0Rjl0MFQwSER1?=
 =?utf-8?B?NjdNWG5XczFQYkFIR0c5NWVMaHJsNWJrNm9PL2YrUkVlUFo5RjQ0b211bVhq?=
 =?utf-8?B?dlRkQUlRSGR2MGxIaGc0UjQraTJoSnNqTWlmSWdocGJVS0cxQ3g4cHZ1dDM0?=
 =?utf-8?B?Z3NOek4veUNFU0d1cWdhckVxN0F3b2ZVcmZWRjNqTXQyeDQvTkF2NlhWamJQ?=
 =?utf-8?B?SSs3L0FIalVsSGdFbzh3eHZGaUpHOWRrZGJjdHgyeFhMdDZGd0haWFkrMlp2?=
 =?utf-8?B?VXAzOHhMSDV4ZFh6b1Vrd3VQeUllWnovTWg0YjgrSCtTMmFLRStiV3lwcDlx?=
 =?utf-8?B?S3hHUDM0SStiTDFsWklsNWd1aUdYNkhBdGNTcGZKR2dtUm41M1ptWTlEc0x2?=
 =?utf-8?B?QUhJa0g4T0U0b3QyOHAycldRM3FpOGNYcFM0RHJtWlI2SnZXMm8yaWd6SGI4?=
 =?utf-8?Q?9v66riXmjK9//EeTZC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab67b56-3f52-4495-682d-08de9ed70424
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:19:06.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuqZLq80jh0oJY+UE+f+AuDlQoNQ/XqgSzrspmUfEOzadHkQ0TO5GjATBxcpcnhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19435-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B787A42A94F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--y5f5CzfEQM9IqwMq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

There was a last minute userspace regression reported, so this is a
little later than I usually send it.

There are three merge conflicts this time, one is silent.

1) The struct member wad renamed in the DMABUF tree:

+++ b/drivers/infiniband/core/umem_dmabuf.c

 +static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_o=
ps =3D {
 +      .allow_peer2peer =3D true,
-       .move_notify =3D ib_umem_dmabuf_revoke_locked,
++      .invalidate_mappings =3D ib_umem_dmabuf_revoke_locked,
 +};


2) Overlapping removals:

+++ b/drivers/infiniband/hw/mlx5/mr.c
@@@ -46,15 -46,14 +46,13 @@@
  #include "data_direct.h"
  #include "dmah.h"
 =20
- #define MLX5_UMR_ALIGN 2048
-=20
 -enum {
 -      MAX_PENDING_REG_MR =3D 8,
 -};
 +static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
 +{
 +      if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
 +              return MLX5_MAX_UMR_EXTENDED_SHIFT;
 +      return MLX5_MAX_UMR_SHIFT;
 +}
 =20
 -#define MLX5_MR_CACHE_PERSISTENT_ENTRY_MIN_DESCS 4
 -
 -static void
 -create_mkey_callback(int status, struct mlx5_async_work *context);

3) rxe_ns_pernet_sk6:

+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@@ -141,9 -138,9 +141,7 @@@ static struct dst_entry *rxe_find_route
        memcpy(&fl6.daddr, daddr, sizeof(*daddr));
        fl6.flowi6_proto =3D IPPROTO_UDP;
 =20
-       ndst =3D ipv6_stub->ipv6_dst_lookup_flow(net,
-                                              rxe_ns_pernet_sk6(net), &fl6,
-                                              NULL);
 -      ndst =3D ip6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
 -                                 recv_sockets.sk6->sk, &fl6,
 -                                 NULL);
++      ndst =3D ip6_dst_lookup_flow(net, rxe_ns_pernet_sk6(net), &fl6, NUL=
L);
        if (IS_ERR(ndst)) {
                rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
                return NULL;

The tag for-linus-merged with my merge resolution to your tree is also
available to pull.

Thanks,
Jason

The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 9091e3b59f2bef11c0a841096327565ae0ca220b:

  RDMA/core: Fix user CQ creation for drivers without create_cq (2026-04-17=
 12:16:00 -0300)

----------------------------------------------------------------
RDMA v7.1 merge window

Usual collection of driver changes, more core infrastructure updates that
typical this cycle:

- Minor cleanups and kernel-doc fixes in bnxt_re, hns, rdmavt, efa, ocrdma,
  erdma, rtrs, hfi1, ionic, and pvrdma

- New udata validation framework and driver updates

- Modernize CQ creation interface in mlx4 and mlx5, manage CQ umem in core

- Promote UMEM to a core component, split out DMA block iterator logic

- Introduce FRMR pools with aging, statistics, pinned handles, and netlink
  control and use it in  mlx5

- Add PCIe TLP  emulation support in mlx5

- Extend umem to work with revocable pinned dmabuf's and use it in irdma

- More net namespace improvements for rxe

- GEN4 hardware support in irdma

- First steps to MW and UC support in mana_ib

- Support for CQ umem and doorbells in bnxt_re

- Drop opa_vnic driver from hfi1

- Fixes:
    IB/core zero dmac neighbor resolution race
    GID table memory free
    rxe pad/ICRC validation and r_key async errors
    mlx4 external umem for CQ
    umem DMA attributes on unmap
    mana_ib RX steering on RSS QP destroy

----------------------------------------------------------------
Chen Zhao (1):
      IB/core: Fix zero dmac race in neighbor resolution

Cheng Xu (1):
      RDMA/erdma: Remove numa_node from struct erdma_devattr

Chiara Meiohas (1):
      RDMA/mlx5: Move device async_ctx initialization

Dean Luick (4):
      RDMA/OPA: Update OPA link speed list
      RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
      RDMA/rdmavt: Correct multi-port QP iteration
      RDMA/rdmavt: Add driver mmap callback

Dennis Dalessandro (1):
      RDMA/hfi1: Remove opa_vnic

Evan Green (1):
      RDMA/rxe: Generate async error for r_key violations

Florian Westphal (1):
      RDMA/core: Prefer NLA_NUL_STRING

Jacob Moroni (6):
      RDMA/umem: Add ib_umem_dmabuf_get_pinned_and_lock helper
      RDMA/umem: Move umem dmabuf revoke logic into helper function
      RDMA/umem: Add pinned revocable dmabuf import interface
      RDMA/umem: Add helpers for umem dmabuf revoke lock
      RDMA/irdma: Add support for revocable pinned dmabuf import
      RDMA/irdma: Add support for GEN4 hardware

Jason Gunthorpe (29):
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
      RDMA: Consolidate patterns with offsetofend() to ib_copy_validate_uda=
ta_in()
      RDMA: Consolidate patterns with offsetof() to ib_copy_validate_udata_=
in()
      RDMA: Consolidate patterns with sizeof() to ib_copy_validate_udata_in=
()
      RDMA: Use ib_copy_validate_udata_in() for implicit full structs
      RDMA/pvrdma: Use ib_copy_validate_udata_in() for srq
      RDMA/mlx5: Use ib_copy_validate_udata_in() for SRQ
      RDMA/mlx5: Use ib_copy_validate_udata_in() for MW
      RDMA/mlx4: Use ib_copy_validate_udata_in()
      RDMA/mlx4: Use ib_copy_validate_udata_in() for QP
      RDMA/hns: Use ib_copy_validate_udata_in()
      RDMA: Use ib_copy_validate_udata_in_cm() for zero comp_mask
      RDMA/mlx5: Pull comp_mask validation into ib_copy_validate_udata_in_c=
m()
      RDMA/hns: Add missing comp_mask check in create_qp
      RDMA/irdma: Add missing comp_mask check in alloc_ucontext
      RDMA: Remove redundant =3D {} for udata req structs
      RDMA/hns: Remove the duplicate calls to ib_copy_validate_udata_in()

Jay Bhat (1):
      RDMA/irdma: Provide scratch buffers to firmware for internal use

Kai Zen (1):
      RDMA/ionic: bound node_desc sysfs read with %.64s

Kalesh AP (3):
      RDMA/bnxt_re: Move the UAPI methods to a dedicated file
      RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
      RDMA/bnxt_re: Support doorbell extensions

Kexin Sun (2):
      RDMA/uverbs: Update outdated reference to remove_commit_idr_uobject()
      RDMA: Remove outdated comments referencing hfi1_destroy_qp()

Konstantin Taranov (2):
      RDMA/mana_ib: cleanup the usage of mana_gd_send_request()
      RDMA/mana_ib: Support memory windows

Leon Romanovsky (27):
      RDMA: Move DMA block iterator logic into dedicated files
      RDMA/umem: Allow including ib_umem header from any location
      RDMA/umem: Remove unnecessary includes and defines from ib_umem header
      RDMA/core: Promote UMEM to a core component
      RDMA/core: Manage CQ umem in core code
      RDMA/efa: Rely on CPU address in create=E2=80=91QP
      RDMA/core: Prepare create CQ path for API unification
      RDMA/core: Reject zero CQE count
      RDMA/efa: Remove check for zero CQE count
      RDMA/mlx5: Save 4 bytes in CQ structure
      RDMA/mlx5: Provide a modern CQ creation interface
      RDMA/mlx4: Inline mlx4_ib_get_cq_umem into callers
      RDMA/mlx4: Introduce a modern CQ creation interface
      RDMA/mlx4: Remove unused create_flags field from CQ structure
      RDMA: Complete k[z|m|c]alloc-to-k[z|m]alloc_obj conversion
      RDMA/core: Delete not-implemented get_vector_affinity
      Add support for TLP emulation
      RDMA/core: Remove unused ib_resize_cq() implementation
      RDMA: Clarify that CQ resize is a user=E2=80=91space verb
      RDMA: Properly propagate the number of CQEs as unsigned int
      RDMA/bnxt_re: Simplify bnxt_re_init_depth() callers and implementation
      RDMA/bnxt_re: Remove unnecessary checks in kernel CQ creation path
      RDMA/bnxt_re: Replace kcalloc() with kzalloc_objs()
      RDMA/bnxt_re: Clean up uverbs CQ creation path
      Merge branch 'master' into rdma-next
      RDMA/umem: Use consistent DMA attributes when unmapping entries
      RDMA/mlx4: Restrict external umem for CQ when copy_to_user() is used

Long Li (1):
      RDMA/mana_ib: Disable RX steering on RSS QP destroy

Maher Sanalla (3):
      RDMA/mlx5: Refactor VAR table to use region abstraction
      RDMA/mlx5: Add TLP VAR region support and infrastructure
      RDMA/mlx5: Add support for TLP VAR allocation

Marco Crivellari (2):
      RDMA/rtrs: add WQ_PERCPU to alloc_workqueue users
      RDMA/rxe: Replace use of system_unbound_wq with rxe_wq

Michael Guralnik (10):
      IB/core: Introduce FRMR pools
      RDMA/core: Add aging to FRMR pools
      RDMA/core: Add FRMR pools statistics
      RDMA/core: Add pinned handles to FRMR pools
      RDMA/mlx5: Switch from MR cache to FRMR pools
      net/mlx5: Drop MR cache related code
      RDMA/nldev: Add command to get FRMR pools
      RDMA/core: Add netlink command to modify FRMR aging
      RDMA/nldev: Add command to set pinned FRMR handles
      RDMA/nldev: Expose kernel-internal FRMR pools in netlink

Michael Margolin (2):
      RDMA/efa: Rename alloc_ucontext comp_mask to supported_caps
      RDMA/core: Fix user CQ creation for drivers without create_cq

Randy Dunlap (4):
      IB/cache: avoid kernel-doc warnings
      RDMA/umem: fix kernel-doc warnings
      RDMA/iwcm: fix some kernel-doc issues in iw_cm.h
      RDMA/restrack: fix kernel-doc indicator

Rosen Penev (3):
      RDMA/ocrdma: kzalloc_objs to kzalloc_flex
      IB/hfi1: kzalloc to kzalloc_flex
      RDMA/core: Use kzalloc_flex for GID table

Sriharsha Basavapatna (3):
      RDMA/bnxt_re: Refactor bnxt_re_create_cq()
      RDMA/bnxt_re: Separate kernel and user CQ creation paths
      RDMA/bnxt_re: Support application specific CQs

Yonatan Nachum (3):
      RDMA/efa: Rename admin queue attributes struct name for extendability
      RDMA/efa: Expose new extended max inline buff size
      RDMA/efa: Use extended inline buff size for inline validation

Zhu Yanjun (4):
      RDMA/nldev: Add dellink function pointer
      RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets
      RDMA/rxe: Support RDMA link creation and destruction per net namespace
      RDMA/rxe: Add testcase for net namespace rxe

hkbinbin (1):
      RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv

zhenwei pi (1):
      RDMA/core: Fix memory free for GID table

 Documentation/driver-api/infiniband.rst            |   15 -
 Documentation/infiniband/index.rst                 |    1 -
 Documentation/infiniband/opa_vnic.rst              |  159 ---
 .../translations/zh_CN/infiniband/index.rst        |    1 -
 .../translations/zh_CN/infiniband/opa_vnic.rst     |  156 ---
 MAINTAINERS                                        |    8 +-
 drivers/infiniband/Kconfig                         |    2 -
 drivers/infiniband/core/Makefile                   |    6 +-
 drivers/infiniband/core/addr.c                     |    3 +
 drivers/infiniband/core/cache.c                    |   15 +-
 drivers/infiniband/core/cq.c                       |    3 +
 drivers/infiniband/core/device.c                   |    6 +-
 drivers/infiniband/core/frmr_pools.c               |  547 +++++++++
 drivers/infiniband/core/frmr_pools.h               |   63 ++
 drivers/infiniband/core/ib_core_uverbs.c           |   27 +
 drivers/infiniband/core/iter.c                     |   43 +
 drivers/infiniband/core/iwpm_msg.c                 |    6 +-
 drivers/infiniband/core/nldev.c                    |  298 +++++
 drivers/infiniband/core/rdma_core.c                |    4 +-
 drivers/infiniband/core/rdma_core.h                |    3 +
 drivers/infiniband/core/umem.c                     |   15 +-
 drivers/infiniband/core/umem_dmabuf.c              |  138 ++-
 drivers/infiniband/core/uverbs_cmd.c               |   40 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   87 ++
 drivers/infiniband/core/uverbs_std_types_cq.c      |   41 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |    8 +
 drivers/infiniband/core/verbs.c                    |   59 +-
 drivers/infiniband/hw/bnxt_re/Makefile             |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  894 ++++++++-------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h           |   25 +-
 drivers/infiniband/hw/bnxt_re/main.c               |    4 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  305 ++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |    8 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |   47 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   10 +
 drivers/infiniband/hw/bnxt_re/uapi.c               |  469 ++++++++
 drivers/infiniband/hw/cxgb4/mem.c                  |    2 +-
 drivers/infiniband/hw/efa/efa.h                    |    6 +-
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h    |   23 +-
 drivers/infiniband/hw/efa/efa_com_cmd.c            |   55 +-
 drivers/infiniband/hw/efa/efa_com_cmd.h            |    3 +-
 drivers/infiniband/hw/efa/efa_main.c               |    3 +-
 drivers/infiniband/hw/efa/efa_verbs.c              |  123 +--
 drivers/infiniband/hw/erdma/erdma.h                |    1 -
 drivers/infiniband/hw/erdma/erdma_eq.c             |    3 +-
 drivers/infiniband/hw/erdma/erdma_main.c           |    1 -
 drivers/infiniband/hw/erdma/erdma_verbs.c          |    8 +-
 drivers/infiniband/hw/hfi1/Makefile                |    4 +-
 drivers/infiniband/hw/hfi1/aspm.c                  |    2 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   54 +-
 drivers/infiniband/hw/hfi1/chip.h                  |    2 -
 drivers/infiniband/hw/hfi1/driver.c                |   13 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |   20 -
 drivers/infiniband/hw/hfi1/init.c                  |    4 +-
 drivers/infiniband/hw/hfi1/mad.c                   |    1 -
 drivers/infiniband/hw/hfi1/msix.c                  |    4 +-
 drivers/infiniband/hw/hfi1/netdev.h                |    8 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c             |    3 +-
 drivers/infiniband/hw/hfi1/qp.c                    |    1 -
 drivers/infiniband/hw/hfi1/user_exp_rcv.c          |   14 +-
 drivers/infiniband/hw/hfi1/user_exp_rcv.h          |    2 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |    2 -
 drivers/infiniband/hw/hfi1/vnic.h                  |  126 ---
 drivers/infiniband/hw/hfi1/vnic_main.c             |  615 -----------
 drivers/infiniband/hw/hfi1/vnic_sdma.c             |  282 -----
 drivers/infiniband/hw/hns/hns_roce_alloc.c         |    2 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |   16 +-
 drivers/infiniband/hw/hns/hns_roce_hem.c           |    7 +-
 drivers/infiniband/hw/hns/hns_roce_main.c          |    6 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c            |   23 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c           |   54 +-
 drivers/infiniband/hw/ionic/ionic_controlpath.c    |    6 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.c          |    2 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h          |    2 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |   44 +-
 drivers/infiniband/hw/irdma/defs.h                 |    4 +
 drivers/infiniband/hw/irdma/hw.c                   |   29 +-
 drivers/infiniband/hw/irdma/ig3rdma_hw.c           |    1 -
 drivers/infiniband/hw/irdma/irdma.h                |    1 +
 drivers/infiniband/hw/irdma/main.h                 |    2 +-
 drivers/infiniband/hw/irdma/type.h                 |    2 +
 drivers/infiniband/hw/irdma/user.h                 |    4 +-
 drivers/infiniband/hw/irdma/verbs.c                |  121 +-
 drivers/infiniband/hw/mana/cq.c                    |   11 +-
 drivers/infiniband/hw/mana/device.c                |    3 +
 drivers/infiniband/hw/mana/main.c                  |  141 +--
 drivers/infiniband/hw/mana/mana_ib.h               |   10 +-
 drivers/infiniband/hw/mana/mr.c                    |   92 +-
 drivers/infiniband/hw/mana/qp.c                    |   69 +-
 drivers/infiniband/hw/mana/wq.c                    |   12 +-
 drivers/infiniband/hw/mlx4/cq.c                    |  258 +++--
 drivers/infiniband/hw/mlx4/main.c                  |   14 +-
 drivers/infiniband/hw/mlx4/mlx4_ib.h               |    8 +-
 drivers/infiniband/hw/mlx4/mr.c                    |    1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   82 +-
 drivers/infiniband/hw/mlx4/srq.c                   |    5 +-
 drivers/infiniband/hw/mlx5/cq.c                    |  183 ++--
 drivers/infiniband/hw/mlx5/devx.c                  |    6 +-
 drivers/infiniband/hw/mlx5/dm.c                    |    2 +-
 drivers/infiniband/hw/mlx5/fs.c                    |    6 +-
 drivers/infiniband/hw/mlx5/main.c                  |  172 ++-
 drivers/infiniband/hw/mlx5/mem.c                   |    1 +
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |  102 +-
 drivers/infiniband/hw/mlx5/mr.c                    | 1158 ++++------------=
----
 drivers/infiniband/hw/mlx5/odp.c                   |   19 -
 drivers/infiniband/hw/mlx5/qos.c                   |    2 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   68 +-
 drivers/infiniband/hw/mlx5/srq.c                   |   17 +-
 drivers/infiniband/hw/mlx5/umr.c                   |    1 +
 drivers/infiniband/hw/mlx5/umr.h                   |    1 +
 drivers/infiniband/hw/mthca/mthca_provider.c       |   36 +-
 drivers/infiniband/hw/ocrdma/ocrdma.h              |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_main.c         |    2 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |   56 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h        |    2 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   44 +-
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h          |    2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c       |    5 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c     |    3 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |    6 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c      |    6 +-
 drivers/infiniband/sw/rdmavt/cq.c                  |    4 +-
 drivers/infiniband/sw/rdmavt/cq.h                  |    2 +-
 drivers/infiniband/sw/rdmavt/mcast.c               |    1 -
 drivers/infiniband/sw/rdmavt/mmap.c                |   22 +-
 drivers/infiniband/sw/rdmavt/qp.c                  |    2 +-
 drivers/infiniband/sw/rdmavt/vt.c                  |   10 +-
 drivers/infiniband/sw/rxe/Makefile                 |    3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   38 +-
 drivers/infiniband/sw/rxe/rxe.h                    |    2 +
 drivers/infiniband/sw/rxe/rxe_cq.c                 |   31 -
 drivers/infiniband/sw/rxe/rxe_loc.h                |    3 -
 drivers/infiniband/sw/rxe/rxe_net.c                |  144 ++-
 drivers/infiniband/sw/rxe/rxe_net.h                |    9 +-
 drivers/infiniband/sw/rxe/rxe_ns.c                 |  124 +++
 drivers/infiniband/sw/rxe/rxe_ns.h                 |   26 +
 drivers/infiniband/sw/rxe/rxe_odp.c                |    2 +-
 drivers/infiniband/sw/rxe/rxe_recv.c               |    3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |   56 +-
 drivers/infiniband/sw/rxe/rxe_task.c               |    2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c              |   33 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |    1 +
 drivers/infiniband/sw/siw/siw_verbs.c              |    6 +-
 drivers/infiniband/ulp/Makefile                    |    1 -
 drivers/infiniband/ulp/opa_vnic/Kconfig            |    9 -
 drivers/infiniband/ulp/opa_vnic/Makefile           |    9 -
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c   |  513 ---------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h   |  524 ---------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c |  183 ----
 .../infiniband/ulp/opa_vnic/opa_vnic_internal.h    |  329 ------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c  |  400 -------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c    | 1056 ----------------=
--
 .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c  |  390 -------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   67 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c      |   11 +-
 include/linux/mlx5/driver.h                        |   11 -
 include/net/mana/gdma.h                            |    5 +
 include/net/mana/mana.h                            |    1 +
 include/rdma/frmr_pools.h                          |   39 +
 include/rdma/ib_cache.h                            |    4 +-
 include/rdma/ib_umem.h                             |   66 +-
 include/rdma/ib_verbs.h                            |  194 ++--
 include/rdma/iter.h                                |   88 ++
 include/rdma/iw_cm.h                               |   14 +-
 include/rdma/opa_port_info.h                       |    8 +-
 include/rdma/opa_vnic.h                            |   96 --
 include/rdma/rdma_netlink.h                        |    2 +
 include/rdma/rdma_vt.h                             |   10 +
 include/rdma/restrack.h                            |    4 +-
 include/rdma/uverbs_ioctl.h                        |  101 ++
 include/uapi/rdma/bnxt_re-abi.h                    |   36 +-
 include/uapi/rdma/efa-abi.h                        |   11 +-
 include/uapi/rdma/ib_user_ioctl_verbs.h            |    1 +
 include/uapi/rdma/mlx5_user_ioctl_cmds.h           |    1 +
 include/uapi/rdma/mlx5_user_ioctl_verbs.h          |    4 +
 include/uapi/rdma/rdma_netlink.h                   |   22 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/rdma/Makefile              |    7 +
 tools/testing/selftests/rdma/config                |    3 +
 tools/testing/selftests/rdma/rxe_ipv6.sh           |   63 ++
 .../selftests/rdma/rxe_rping_between_netns.sh      |   85 ++
 .../selftests/rdma/rxe_socket_with_netns.sh        |   76 ++
 .../selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh   |   63 ++
 186 files changed, 4726 insertions(+), 8149 deletions(-)
(diffstat from tag for-linus-merged)

--y5f5CzfEQM9IqwMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaeYZswAKCRCFwuHvBreF
YSHoAP49ErUYHJK4Bo70ratg4Yv4qRnzBTzAe8braqRGkC3sigD/XKs/yOZh0spM
cxYDIqWo4eduluCMYLAUoI6ZeZHFxwM=
=M1zF
-----END PGP SIGNATURE-----

--y5f5CzfEQM9IqwMq--

