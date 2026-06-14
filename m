Return-Path: <linux-rdma+bounces-22201-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fTtLBRNTLmqdtQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22201-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 09:06:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DD680818
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 09:06:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=H38huAW7;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22201-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22201-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADB7E30234EC
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 07:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE023914E4;
	Sun, 14 Jun 2026 07:06:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DF3242BC;
	Sun, 14 Jun 2026 07:06:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420806; cv=fail; b=TDabW+hpKySThZjpH0mzRvtANt+QU1Km6pKsbXEZcFqN9WgQKBIiCA4DfmrCTpOyX5ky3kdgq38jXjz/SaP6M8Ffekmrzhe0FZVfRz0r6CQkYAUeamQS8rWAYZ6KS78wumzvPcJnOlT0hS3Y5VbHr2o4V3yrhjwzU0iJA17y+ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420806; c=relaxed/simple;
	bh=huwP4YaqJJc5s1xUZ81CgSeh625Jfekx6RPlYvDkKk0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbekglQ3rnArH6A6dZXtsjAewpj924Z3tNCzJZ+CfX625OZlQGRfqWBSGIjd2yYu8DpYGj8vbq4bb3xL14NYWrnQuRyeFDxQyB59g+Kweu58/GncFax1go6MkPErJNEzl4V66QRyM7sAHxUiUztZ7WbZkaWQlwUMa5xzna44fXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H38huAW7; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v04IG7k/bxejBQC77qJcfbr2JJBjiu9hBztC4QlcLMN9rZDXU4bngeBBOh8r4J8NJTI+GlEwOP9opXsVJr9+WlweIrwpWsb4NQSiSguMrqlE77fv0rcUU7LmpJ673ql4HEcM+Je/0JO8CvxB/ydjqHhtl0eSyzUdWyJCBaP/7fp+s7EHVzsjjYSaixmpUlBDFQPy2ZiQS61WVK1HHPqTj3MYAVWdrw7rvYR/8wfhlugFeg6Ei0OhaNwkqZ4LPlJ8iy4p3HAau7QzwNJCeNl4u0UmR+AublZt39oVr2ip4VGeNgqoHS2Lo6mmaEbLRvhl+MhgQLCLl/WcPqXSD07aEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Y8U4VVar/U7P3CogtXUGlmsQmYsQNLmnXsyOIF+OWY=;
 b=b9eFDUfkL6GED4zRYoMInoAVJfv0vbvV7rIGAotsltjkZCHiFsvZu6Uhiadi1urf+c/Pjyv+NrusdRr3hyy8R4srJ1IALoLv9d0y0LNA753ZtIZQ6Bir6yHvP1+nPbIxz6oBDoSA6Z3UR8iHpACweDFyj8Vf7tue8N4nVUY4qA03h1KEkXhdu4sctMb0bMkTFw5Vq964GV5CSp61ZIcX5owAcoCVwpP980ivjwGz3QbO6oPReKM10dyToJks6zE0hFRw/O7uk7GRasOmqHpbwETrYAfBIzWSnkEaC+mlfoiqhj108CPVtmF6DKKY+4fgj93EFN8N69MmN0VJKwGXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Y8U4VVar/U7P3CogtXUGlmsQmYsQNLmnXsyOIF+OWY=;
 b=H38huAW7vXP5dsMi1FJW/ImHy9ZU7Wo6BTOecJSGPNEf57IqM+NNMFGYT7Mzf1tqQSNA9FdoQ2eBHxRACrLL9lUqzasAXBrWm2WyqitXwMhuLTubtAePkECnkv5rnNSmcpTMAa4+GgqMhhHu6URmlLksdPVXivzq90r7dhAfvKbKQj+5NT5iV5yzMfqT6Ywg/scUeS0f/z2ySVmSkdaWBg+sJ93thldwFjQH/UPkXtkiZiYtBIvHOMKXhuwFS7jzi1tMX6JN1KinwFRjk9q2vQOZ2Yxkk0nHDkdyCwVBwtve27YsGHYYlXzlcSNx1RbA9eIuIFxueULgf0FFbvvBsQ==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sun, 14 Jun
 2026 07:06:40 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0113.015; Sun, 14 Jun 2026
 07:06:39 +0000
Message-ID: <9b31fd6e-9c26-4f4d-804e-832fc64ca512@nvidia.com>
Date: Sun, 14 Jun 2026 10:06:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Zhiping Zhang <zhipingz@meta.com>, netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260611161546.4075580-1-zhipingz@meta.com>
 <20260611161546.4075580-2-zhipingz@meta.com>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260611161546.4075580-2-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0136a356-cbb1-4740-ded8-08dec9e37b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	vw4AgVUWDdXBhDdqENHC3BQOe5Nf1OfKwRKePb7XPjH6Me2gnNQjSXmayzjujhCfQ5sHQwNDlsVbQKHJMHfA4ZR4M8hA0Zmei9cVi4oy1/irP0bDqzWfkeVnB/q0GpUGOowTkkQsRGuXkjBYBOH51kOW7O/6Vxl+qIFKrvtsbMSsmR1wvULbLkTK/pNokeZbUx7PWFPSfkLdlHa86nMFb8lmEEv0zJTCQW4e5xtSTGaAy1FZ+a9eonE5lXZfZR4JNlMlr0DLmDMa4LZxfbhXIMSSRhdXsEsU11pZHxDC0LEEKhzLmO9U8LVuKkzEcrShq2EL/Wz3Y+8VGwd8yDAo5PzV7+X/luqXaDmU66OKz2VtoK+bCx0D67B/UzIzoQ75IRO+cOXCiZ7aG4+zqV2krV0TngMDMZso6KF0SCFYNF/QScFrA/ynNXCLbQAwNScJ13Qh7ftCLTHhYtdGZ1CrdTq0Gymv9/8O7R+j5uym+j3Eih0DwiaRHfGDbkZkHrEiqRc2xmIboqJWMgN976bRulXNr/ZJrc/MJgBq5ycPXRMKDk0gEmdK6VTtWYRgpqqK191Bj4GO9eMD45SC/Jur9w2HOqs4ebfh3yQwfj5eXjyv1nYXUNkFg+XgZL/8sVKsvM1PclUDi5sq3flmNXL5lrGphQVj+hPqRum4JzIbazC3xC449dB2PtxxeW/X2Q7r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVkwWlY3dTlST0VsL2dVK25jbmhvSjJPNFFISFlPc3dWN2NZRWx3WS9EbzVQ?=
 =?utf-8?B?T3RoQlhDd3AvNndMd0Ivbld4WHh2c3FnTEJXekRxamo0OU44RUJuNHJydjEr?=
 =?utf-8?B?eFVzUU8vUE11ZDZTdGtOc0pSaURGMlJ0bmc1UVdKT0NiUkYxYnZJVGRxUUlr?=
 =?utf-8?B?QzRyTHowMUMrZzA5UFZhVWlhNFYwcFN1QkRKVm1BVFA4SW9EY1JkQWJpcTRH?=
 =?utf-8?B?UkhpU1BQTWw0WWV5anhhSm11OGdFTzdzd1N4akxCMjgwMFpIRjRCM0JHZVdT?=
 =?utf-8?B?Vmw4bFlLUHVSQUpra1hkeVhqL1BidE1FdUswY2U4ZHEyUGUxN05Yd0tNUGtl?=
 =?utf-8?B?V2ZKcHBEUlU4bnRFM01LWnNBN3BpaldZY1ByTmlVajBJV2dFNEMraWJrbVRL?=
 =?utf-8?B?dnFVaUdrZW45TEpJQWFhZ2l4ZFdLay9LeWRyajl6OTZTQyt6RzRzbVljNkln?=
 =?utf-8?B?eDR1Q0FOMitrcllsTEtta2xoaUZMNXlWWTBSZTRoaWxYSnprYW1RemwrQm5G?=
 =?utf-8?B?MVZteElFV0lzYnpYMlI5andBWGhZVW1UeXVkSk9BbVUwOG5KajQ3WTlxa2du?=
 =?utf-8?B?ZkdzQWp1VDErcHc4ek50RGdvVTRzamJHbXpBYXBXUllsZ2hJdDkzWElLWElG?=
 =?utf-8?B?d0JWb1VvTHZCTHVEL0RGczFMRnl2KzRmelZWcnBCck5ucVVqUExqd3laZWlG?=
 =?utf-8?B?QVFEQ2E0VG8zL1VCTVFZYVhCRU82UmFLcjhkQU9RWE82dlozb1VoangrbTF5?=
 =?utf-8?B?YlFLRVl0TjZOa0dnZnJSRnc5STB5bTZNUGYwbkJ5YTlKaHNjdXlFN2J2V2tW?=
 =?utf-8?B?MWY5TVl6aFFiSU5uVGZUK1BHNnhuNkRaL2NJdktvekVMdEFFNDRiRXZ3N0Q5?=
 =?utf-8?B?NS8rQ01FakhvTkN3b2k4SHJmMmJySkxWcE9ZTlBUOUd6NmYzV2twSll1bGFU?=
 =?utf-8?B?U1pObzgrb09lcTB3QW01aXdYS1RqRnhuS3IyV1pxdU5xaCtMbzBvR3RjSjNr?=
 =?utf-8?B?eW1wcWVjZStxQjVKWEFyR0kxSWhmQXVTbG1QVWcvR3BpbU9yM093TGc5dG9j?=
 =?utf-8?B?V1VzZWlzWVViN0IwVU1ETjNwR3JFZDRGN1EzbXhVc1FmdmtoeFdDdkdkOFJa?=
 =?utf-8?B?Z2VmbU4xbmxpeTlzMFhQL2t0VHMxZ0FMNnN0c0xtaEdnRFRDSnNUc0pRTjIy?=
 =?utf-8?B?SHdDN1I3a2JTV3dueW16d3g4YTV2M1diMkpERzI3WnpDbHNPSHJxQ29kUzE5?=
 =?utf-8?B?a3hKMm5acElJQ1Z2OVU4b2I2dC9taktBQlNRRlk2d0N3ZnhDTlZyalo0QU40?=
 =?utf-8?B?NlFhUFp2Vk93S040eUtleWtWUGNHKzV2dEdxYWFHZjRDZ3FUbi82R1BTN0VI?=
 =?utf-8?B?azhSem4yMUFUVGgraCsrRnQzQWI4ZzI0aFIxY00zZlFvQUg2S2o5Sk16aXI4?=
 =?utf-8?B?TngrNWhYVEhlUHlrenFSTnlNTW1qV242N2Nkb2YrQ3VOd281NU9hOXUzQjl3?=
 =?utf-8?B?Smk1THZ4QVJFODhyT1prZ3FGVEgxRmU0TnRNZXRIUTVndENzM0JDVmp2bmJ0?=
 =?utf-8?B?MUlITzhURUNHQjJKczA1aUlYblB0V0QxcW9UTEhLUWxnQWk3WURzSkhpMGtl?=
 =?utf-8?B?eDdZMUNDY0doK2VSZGhFd3RFWU15KzgvSXdVU0h6WVJPcUQxVGo3TEpwRmQy?=
 =?utf-8?B?M29WWmE2c2IwTjQyQnk5V3Q1T0NzOWJrN1hQNCtmeVN6Z0VEN3BXTnQ4TUJP?=
 =?utf-8?B?ck5HR3FKdVRuVWE0a1k4S1k0RG5OK2psVGd6emFVczdPMVlUT3JOVmNPZGdj?=
 =?utf-8?B?ZVFsM3BmVjZ5ZDluM0UvOVBCNm50dUd4NmxaUzNIZGMzbE91ZjV0dUNPSlcx?=
 =?utf-8?B?Z2Rpd255a01QS2YxRWdqNndLQVNDbjRkL25rNExCelZ1WHQ1dFBKUHdLYThm?=
 =?utf-8?B?Wm5iQlZuWGp5dGcreVAxUTE4Sm5vTklobnUrdWl3dnZELzhZQllLRVMyNVNC?=
 =?utf-8?B?cFREZnlocFVIU3pUU0RCdzNpYml1a0VhbDZaOCtHRlpscjI5bk1lQnFYblVs?=
 =?utf-8?B?dWp1eDYyb2h1MFpxNVBWSEQzVXdDN3pLRDdmZCs2RkYwV2JLVXVzSEo3MFpH?=
 =?utf-8?B?WHZtZGg4SHo4TldtNDdtK3hsNEtaRnJaOHNxRjJrL0w3TG9pcXd3N3ZJenpK?=
 =?utf-8?B?Q3lQVUs1MzFjT3JsMU95Zjh1djdiMGZQVlgrS0pHMjlzTmxQKytIbGRtMHRE?=
 =?utf-8?B?eHE4azBETXlCVEs4TDYzYTRtaEdKcmFKMDlKNXQ0S2szRlVwcjMrOWlpamNB?=
 =?utf-8?B?UFhheVBYQTFpWmJXSXFIN0xkUGtFNVVnbDBYbDlwYjBEdW5CcVNKZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0136a356-cbb1-4740-ded8-08dec9e37b59
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2026 07:06:39.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tW7wRCbDQIXXOMizw1Xj5+M+rQu7YY4HdFOtwingCIq0DRD6xejlyy9cwUe2TsDPaPnwWJ+7xX3iCpxYqps4Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22201-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 632DD680818


On 6/11/2026 7:11 PM, Zhiping Zhang wrote:
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> index 997be91f0a13..7cedc348790d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> @@ -175,6 +175,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
>   
>   	if (refcount_dec_and_test(&idx_data->usecount)) {
>   		xa_erase(&st->idx_xa, st_index);
> +		kfree(idx_data);
>   		/* We leave PCI config space as was before, no mkey will refer to it */
>   	}
>   

Reviewed-by: Michael Gur <michaelgur@nvidia.com>

Thanks.


