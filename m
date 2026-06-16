Return-Path: <linux-rdma+bounces-22284-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7MM5C6WJMWoNmAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22284-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:36:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F76934DB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=OBB9Ssru;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22284-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22284-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97843304843C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4FC47AF57;
	Tue, 16 Jun 2026 17:30:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872B35DA78
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 17:30:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631054; cv=fail; b=hfWFQIEMVp5/cB8J3gsVNNzk1wMGdg/YPHrVe3e77riL7BUQbEMxookiShPHhoQD+uUsj2CilbnHa8v7Sw3+70+CtQBr9146ClOqZeC91MrproXo9kVbCOEalp0ndLtasr1fbZ8tyaGY+EWbN8B2Mu/g9VvIjwV+eIYWO+PXqdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631054; c=relaxed/simple;
	bh=FMNP+r4vYHmyk1Rbojusl5drxvvqfHlpvXlEv+j/7dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B0BY9ma7CHx195X6tO9BRH7Zcql6ehWbrbet6GIIR3t43RgJx+26fh5ASOBAntRNL2d7PIwZ3XhgQmLdiWO52FvUPn+Ec37ZwyMZ5NcLeuUoG8Ti3KE4RlZfzaz77WY49m18z9doULUaWH6FMLBj0McAZVpl25eMzxRj1qNkMfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBB9Ssru; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4dlRAG+dcJRjjkmvbceCBgNAkDcbPkJR3eF+UfG08daNxS3X0+Xm6swTkeT03ciuP61VWiq7Fna+ZD6PVeq7DvKkUL/1OFSUE1CYHZcfRcaltCLTSE0upHwmoSbdvXZ494xxtWEwie97tMwMVO0MDDaNPLImyBojrPGz8zSSuisCMtehxxUVqj90skZMYu3+sj0dRJTldwVpmLjUNAFNGQHJT9DrrcjOfJpV+VIvoR7WRs8nBLpVE13tfaI2PXPz4THsWR68ZNqbxxYF51TY+Bgr1MtC97cX9wRmasbmtH0qd92aQ/tbVlVGhngb1LRWvS/ecs0n7ZYh/9zo8ZRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsegtV1ok8D9vLcAHITBt0JEfRGD50wkzUyByHEfXdI=;
 b=HnDltFfaphWPvfKDOV9fzqKofxo9WRq97a/C+gYYnMRAybEDBxVPS4Qfz9ZzPTs+T1x5JfbKhXgdkAJ7tsB5AW6k/dU984xEqkzNTqV52hh6VxL9xF5T0SKKpb7eOlrSjFJ1xr+LInFZ1BaxHGIgJaOMY6hHKumghTgZZ0xGL2+ORzAe04kFQ9wHyGX8YFmJubjl7LI6nEyM8iSn+m9+0hVY866KnQ5QssfF0h2mPDupARR2Pi6Yb2Km67WsW2XWAQIirsqvBNSQPQwGzcfpEhjdNZMCffaMdhzh2J+av5yEO37VxYfurmheVM/Prff3vFsTnylyZg8LCL/W78VCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsegtV1ok8D9vLcAHITBt0JEfRGD50wkzUyByHEfXdI=;
 b=OBB9Ssru+bLuALclmAIa/OzXVdklhzKxc4Xohgt/RnWn3gznvl/PJCj0BdPa5axeywcsZFPVp2dR9jr30c5oFPV7HtNOh0adfn6BQgxiD5uJz6JrVuIPqnqHjAV6rs70cN/lxEyMeCd9mEliGmE7ec/yry5UIutY+JGd2vWwAToMTh1Ww4BMFXu4+nZR1+VSGeISTjEMOcpfeDmGE9PP9mQ4CaT/dwsQJ59EGklsZ2yHhZG56zigiqWmimxnY5phbbT14XdWuyAFeeGVqrNKImDl18qNlQJXjv3/ih1ov0Vd0SQcmRAb+yl+x7pWw4DLVkKaXO+tjXFYHx5n/d2IRw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 17:30:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 17:30:48 +0000
Date: Tue, 16 Jun 2026 14:30:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	sriharsha.basavapatna@broadcom.com
Subject: Re: [PATCH rdma-rc v2 00/15] RDMA/bnxt_re: Generic driver fixes
Message-ID: <20260616173047.GA3947802@nvidia.com>
References: <20260615224751.232802-1-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615224751.232802-1-selvin.xavier@broadcom.com>
X-ClientProxiedBy: BN9PR03CA0509.namprd03.prod.outlook.com
 (2603:10b6:408:130::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d287119-a4b3-4243-6146-08decbcd0174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	McWW14BfAFDyBgULuZhhc9F+cN3JPZ46NI26JN8OgeUGDZiiiMcq5qHWLhNyJMCSXGDRGLmqfWG8SALQsJAYqOtVi+6C5W48QeCyhF9XZQ1LZsd2OIa9R+7YIJDQ9kRr51FyIVQHXg7rFewQuU49kZMdh8nTisjq2zwNKo1Fjjjfz3oY2rLZ3pZaSXxJBSwlSCjSohqOZr5Tkx0qiWb4Pl0C3XaUlZyQKBpVLq+CtX3dZUbZfCjESFzr7rFr0J2/jFOfYzFlA16SF11ZcgaDgdpd+NmDpO00HiP/nuGq3Ir5Q+TECQHKexfXajxy9fh3DQg85iKfhZQmu7pvKi+p1yGPyMYyBL3uniBceRm7nNmld8sNCWIGI7BoTn8wU/hSM5E6T8VxPOZdvKz3JEfwC5Cil2qRrrFzJ/KlZnbBAtCb2SF+v4xNadJH1I627RPpT6JVIFTHD8Kd6UCaOrXldkCf+so/tt10OOGIi5fFEqGVJkJ19s0nkB+bAoMTVkfO0WG1mm9NfRhrwpvmk6Qo0fneG38vXG2BHMBNnQuZs5gD+TT1nDN6amGumeCOcCrlFs5ftESadG8kVO7DWqSnAPRxM/wuO3x9fErq8GJ64f4jSUK6PMQ6pTKvlR1463BlqUWIL7RUuEr1zAGx4mdq6N2xsjCSPWJ63jG/UIQ7XWiTyzYdRtUfzlHvOwp1R8HR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUROUesZiI2X0DLWNPQ+1JGntkMRHpAFZygfAL8YQ63c2FFAOzmiQSx3ct50?=
 =?us-ascii?Q?IIllv75H6S0VELJayxvWQXW9QUnXVMK0lntwbczmoYI2eIz0G8gcpljFZzAv?=
 =?us-ascii?Q?PfmRh6+Xxds+A0ahDLU4hUPbZdW8T0XOd1sGVQu3IF/CMfkWCyfPDtaokHMn?=
 =?us-ascii?Q?5FtXbYHy3rNZVz20UYLO4YYUnR6LVs1doJNoOYg3mrkBLoeItkZu7DTXI/xr?=
 =?us-ascii?Q?wyze07l9dQ3ADvv7MHou70XJgSW5gbCC+XbppTAzP6fhBtmcRlJrjUxmGv1S?=
 =?us-ascii?Q?QaBLa1kLw1w/YSfajtKqxMLT8jkedKPaemJhiVXUn5O/kbqcc1wc7WsWaRED?=
 =?us-ascii?Q?S5C8VkbtH8tRjfhifiDZs29TIBo3BVLBfGe32yFAOzmQjs4uo+m3sUXr38WA?=
 =?us-ascii?Q?XSx+1q+H6hj0C9h4ci68XFG4WetDl4nSYaXiUMWweGzg2vl6Gx7eq0TgXNqM?=
 =?us-ascii?Q?jfYBSN2ZddUyjccD2DAAXfp7667HkqueAtUwFli1jy6LDwMcaBhc9mUpMq2b?=
 =?us-ascii?Q?CoHfz1jVE+FAogbEEF5P/UzWdK2qv48/pXvsk9k8exNrWQMGyPbt/ofKrkYp?=
 =?us-ascii?Q?aCW30mNGwshx5ImNOd097rtBQNWNSZQbIOovGq22CbKbs5eN2wetxEsLxv5w?=
 =?us-ascii?Q?tjUT7Rsbk3LHKZe778rJfBlU38gIH23m6X9R1+2o8lfTOwWX95OxmbSaQ2iH?=
 =?us-ascii?Q?ceLO/TY3e6SC4CaG5sZRhT2AurLMRN9XZR0T0UI699EH3nL+Kut1iNj9GS1R?=
 =?us-ascii?Q?N6xH51f6KKvh/PiXAq4K71rDdri0sUVlA2sgIf4Okaz2KU1Nb1C15/w39KTn?=
 =?us-ascii?Q?v4ym8NCN5GY5UjP6sOS0fIJNzc9aqNgX+yWAs6LUxyvAQCDRyCm38RRqm7tP?=
 =?us-ascii?Q?e/aJfBGS3n0LlcfXTdUV+3rHxOU8PsNoOyUw5N7MyILibqJYsCQn7ul+BsJJ?=
 =?us-ascii?Q?WYEaNSEbsxtXbG7+NfoVKzmq9sc5I09qfYmhJ4UCoDZ1Gvx6HWmNG2cmvuM5?=
 =?us-ascii?Q?8+LrTZSiOAKW4pVIkn5dGjHLJIzyzdVd3pedML53+dH7dL1NLglM6jY+X8Yf?=
 =?us-ascii?Q?yhLbqP1cCb3Pfq3sEpMEQzHyZxoqh5W/1zc7XlCD003LBewQGaQDD1TTOhAJ?=
 =?us-ascii?Q?oYqs0Kx8tms89Prv6zQq1QtCthYT0Ixb6JQrj2jvElT6afI11vStftLudLEh?=
 =?us-ascii?Q?6kaQ13KGcMb+YGsRjweYNZSuhz3pZOxTB3RHhyE0Gic4dDy7lRFiUVqh1K2y?=
 =?us-ascii?Q?r8sMG2bW4gjXEawwRDkoOmqpFD/JheWktpjceiiXYd81obL9DLqpnfJKKppP?=
 =?us-ascii?Q?9owpHdSIY7CvztKfX/tyGloSyjT3v+duovLY2DNCkpLcD3JDUkt5jwUQ36jw?=
 =?us-ascii?Q?0fZy5its/8ls9A3alp5DQxw0cm+GvJAlVmRlAISOZ+1AOTvrHGjdn7YP3icu?=
 =?us-ascii?Q?HL7rN2Z9vU/PafwyFswazb9GVYlcYdNDvnUvHYCVwzkRUsqWMxZtZtbcM1/x?=
 =?us-ascii?Q?P7MhmR/Mmc9imL3FIG/kERCuCOy4Rqg7FnCne3wmmVN0t/5tK0tmAdkZ0vip?=
 =?us-ascii?Q?P6PP/IWkAxhOxvVVcWGEFz57f+kpL/O+2Y6h9Wf/EdHgF8dWlSvXBfzWmiaV?=
 =?us-ascii?Q?ggQkdqYjdUW3j6nf0wa7G7Dm6qyX8AWXf3g/rSdvhC1lpWo8f9ViAS+vf+yH?=
 =?us-ascii?Q?X7J/y4EqKIBKEtFRJY2fBwWbiNMj7/cTMCVYv4lJTAD1ba9M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d287119-a4b3-4243-6146-08decbcd0174
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 17:30:48.8856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in6KH3eRfVxRTKznwDyvG5liHKCjpA8RvXS6l6r3kGNv4OgAVZjF4JbHA8db4xsR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22284-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:andrew.gospodarek@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:sriharsha.basavapatna@broadcom.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 400F76934DB

On Mon, Jun 15, 2026 at 03:47:36PM -0700, Selvin Xavier wrote:
> Selvin Xavier (15):
>   RDMA/bnxt_re: Initialize dpi variable to zero
>   RDMA/bnxt_re: Free SRQ toggle page after firmware teardown
>   RDMA/bnxt_re: Free CQ toggle page after firmware teardown
>   RDMA/bnxt_re: Avoid displaying the kernel pointer
>   RDMA/bnxt_re: Add a max slot check for SQ
>   RDMA/bnxt_re: Proper rollback if the ioremap fails
>   RDMA/bnxt_re: Avoid repeated requests to allocate WC pages
>   RDMA/bnxt_re: Fail DBR related page allocation UAPIs if the feature is
>     disabled
>   RDMA/bnxt_re: Reject GET_TOGGLE_MEM when toggle page was not allocated

I picked up these ones, please redo the uobj related ones

Thanks,
Jason

