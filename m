Return-Path: <linux-rdma+bounces-22673-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BWu7GvMNRmp0IQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22673-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:06:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 213406F4015
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 09:06:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=kKafYXwM;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22673-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22673-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AC0E3033AD6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 07:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A02038F92A;
	Thu,  2 Jul 2026 07:06:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64EF38E10F;
	Thu,  2 Jul 2026 07:06:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975983; cv=fail; b=BUpx0O34qcNdDmcDRpkg5yXnJHKGGG0cycQqHb/HZ/ICcZfwA4nbTTnzGNrjXb4+DaexSDkSq2Uk5cfWj+gAM0yYxFTsLo+m/BEn9zYdGrUIsR/pB7/rKYfHRdfL1iJOKOjnU+6+8kJXkv4e6Kt+84LnudPczMgiDiqWe+jTjpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975983; c=relaxed/simple;
	bh=dOxZHWkJRmgmItT/IQ2LxekZhrN2zFvc9/XBl79ew30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JmA1QFrbedIBUwRaxrC65ICWnNOeOzfhsyo93u5vQMIKf1vEuueC/PrKSp+pz5Ia5HsgDk9cNwWjZBgJUWCCi4C+wzZjOYvkYhPTy596FSwNED/6fc1liB9g5dZrgRHfX0zakhKNQbPR03kc4ecJ5e0gl4pX7OTF25hq0X6gxtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kKafYXwM; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+OxBJvB7+2zb4YpqU9UPx0pQcakKZwgjHyK16z7sW/iLiniPYaitxz+Y/UVK3MilB9r1EMd+mbzjppW1jvfzdMd1lIkIxEVXngs2ECF7EnBlXofZ8tKZV/8k7mA2HN8E68fr/ujor69gkz+aIc9lGU75fXm5fRVId/j/kiafZOpc5BQDMi4hh/HlMMQTP7Il5GXiQ+pttOwqJ0uY22lxkfw9x7vKKclOgfHekOvokSKsry5il2GOScr8nsEKTIFFcrL0TRZ321r5ZbLUv2eC78VEUioAtNLdblRNkR4WR4KTRMN+NK/G9uhfXKJDAGvKuqpEsAYQyCV+brTqdWhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rie2QwxcnOrVMRJAm2WhJBliIsPtpEsle0F89Ea7ZII=;
 b=ZavQrg+oqbWgHK2q06XL/nOG3uZkko9aRTRQuCz/jTxaipQ6mQrFQ7WjaGk48Kr9vHO2sPtOUW0AWjB7ZYKX51qZ3TCQXYp7YZuRrdOGOAASCDY+o2HyOeIBXNzu/a48PG4mjfTyJ4+OifHd5IzBOkHX0x6knjo7NlF2bLKbu+vh7PMrc6QMDurOK3kGG83p19czIJQg/YInjc8XhpE+2Ap3ncyNg3iAeQOg1rxbgpUKpNVqcCmNJBD4em7LXVbEY3EO5ym1b7VfFpTZxKkHOGot43FJTMWmO6RqoAqhXt87XJcqf7ow2smaTJGxHbrHJc5C1dQ+VASsbGJvtclYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rie2QwxcnOrVMRJAm2WhJBliIsPtpEsle0F89Ea7ZII=;
 b=kKafYXwMt/V84Vb/i4os4CwOGfx+2r5oQ34tn4UxGToHp5ZEN+FNez9/RnpdTWhXn9eBzcdJRLoMnOMc4UKmpNr0zDolbBYsmPRj5c2zQxA7BW+AGgKMRHbU77twfvIuzdnzAb3UNpgEyLpuEJEgW8yt8976FAAp0SxYfjj+tEc=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 07:06:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 07:06:15 +0000
Message-ID: <f139ee1d-296e-4f3b-a960-88d992e7010e@amd.com>
Date: Thu, 2 Jul 2026 09:06:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-3-zhipingz@meta.com>
 <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
 <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 46157854-8dd4-4f34-49cb-08ded808685b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kNCAKRVrl4rg7st3x5/5X6C0GIziEuntXrqXLGTvPrOwx/fJ1Dq4QPNxu8Cghh03Q9ZshL9cENkSkqv256gwiqwHAcTbLIX9YLxuXWeCUql8Mn5BYz2oXh/810b9adUhlm/PpeHLI8GMMMyRgNK7SIc3Fo28fKhvsixPntJb7xCjCS1ePjX2S2s2jByQ2gzYbUn9EJwy3G7NTfdnJXuLYRi2kEmeQq3dALN7j7lpCWjK+AkYA3VvcNHEAhUgM4aoo7/q+ghVcrelTDjtLugEsPeJczWFCuuD5hbabm8LmORJL8qMZBUW8zlQ8ZAKr2UbM2Fk4rrLyLeVAXQpokw7mKONWDIhsRFV8D0kS9CueoHXS9n0vlHwwU3TllFI9VP14h9UQBD8uUNEN1TS3RNccBx/nHcg3FZgExmxGeWb6ph+91d3MRLV44OL3+NMpbdZFKTuJR0y4VOL0hC3jaSA+iKE6Qi0B23LLfMIDwyu85+Y3ddrtW/UKxLDLzCklsEtYJOVUDDwlMb45L57vQAd/Oh9CvGP9RCTkuPhGAc5LACI8pboBhlRTgAWC6PYLh8DSzVDPrPYv5IttDtVy0pYgo3fmls/fYQlXGqJGXyDgQk39jo6oO09f2lUXlMb1F21/osbP3hIGa2TRtkd37fikQBBDdWn8Qo9o6T2PAnQMqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akd0WHhQNnArVkZmNGFPRldFeThaRDVpUVV4eFRBbEx4ZWVIVnFXOHdMZFIw?=
 =?utf-8?B?bFVCejRxRi8yVkJ1N3VDdU12WWlKaWVwQ3p6MFo2bUdUc0JwU2szOUdybEQv?=
 =?utf-8?B?aFJjLzc0WUhMVDYrd0tldk8xc0RrTUNtdEYwTEFXQXFicXRuVk51ZmlFb2pr?=
 =?utf-8?B?U1NvTEJUOTJPelNYK2RZMFRVSjNTSDhHckFVdzVRN0puYWRCUzNIeUxKRCtQ?=
 =?utf-8?B?bTFXMXJYRkhvRm1NS3dVUmV0K3lWdGNNQXArVkxEcXZURG1na1dNQU9tVGRR?=
 =?utf-8?B?UW1zYjI3N1hMSmdHcG5FUWZ6bGF3MkE5ckxlUDNxQ1A5Tk9zKzZGNjNIaXdU?=
 =?utf-8?B?d2h3c3hkcTlEMERVNFk0NUZLeUpVWHdoc0cwQ0tUMXFIK28zamNTVkFFdkJ3?=
 =?utf-8?B?ZVpiUEFZNjFFUW1yK0RQVk9jU3g5MlhvNVFDNHNnMEV6Zm4vd1h4dTk5LzFN?=
 =?utf-8?B?MWhsMGxwcEllNGUyai9qOUIybWU2UHNPcXpDTkh1dTdxZGQwZE8xLzBNajdM?=
 =?utf-8?B?U01SeE1lODF4c25LSGFEenN2WHQzL0ViWTVMTFJYTkN3MkZZTUErdDlORGVX?=
 =?utf-8?B?NWVXV1F3U1YvbVJNRkhPOWdJU2dBUmJ6MG1KRWlCK1poWnAzRkdLNTNTM0M5?=
 =?utf-8?B?WmdPOWR1dmhHaWxKd1FCdTZxeHR3bHRITSs2ZlhwYS9ZaU9xSEhMRGc5dHVT?=
 =?utf-8?B?NmUwcTFEM0xLekNybkhUcU1qbzAvM2ViZHo3R1IvTzJ2d1phUHRrSkVzcFU4?=
 =?utf-8?B?S0xyZk1maXFhUVVkWE5WUmRqSUpMaGxSZm1LcEZpQmt1am1nWXlOVXlaTVVi?=
 =?utf-8?B?cHJFclBYYWg5eGFRWDFDdmtFdTRrNS9xVDNXZW13T3JLQ3hXdittWDhyUWdG?=
 =?utf-8?B?SU4xcG1Nb05SSFRZT3JTdklLbG1kMUxvNTlLWlJpNmcxOTRydmV5SzB3LzBO?=
 =?utf-8?B?L2l1UDZBUS96blBISDhNdkNWK2lhc2FRQWdmY3VDR2wrMElpK2NONEZoTE96?=
 =?utf-8?B?YjhWazJ0dkNia2RGdUdrUUZoY2EzbzcyM0RXSnpqV3JmNDhVWjcrUjRGT2Vj?=
 =?utf-8?B?MUdFeVd3T2tGNWVrRVE0T0hzQVIyNXBkWXY1RDR4dk91NnV6UVNxUk5IYUZH?=
 =?utf-8?B?SHFsWE1Sa1dEZGpIZDBpdU5ORC9CRE95THZaeHNtQzRacVNaOHA0NlNQMy9Q?=
 =?utf-8?B?aXJqTGFxSDZpem9uY2xWUEdhdXA2NG1QYUVSdkhIOThyZlEyWXRNUFdpLy9D?=
 =?utf-8?B?VEwyTFhCdWs1RG5YODJjcUFIdThCWEdrT0ozU1FqTFpKcVNwRm5DcVJaWklH?=
 =?utf-8?B?SFVkQUVRU1RYWFp3QjJMQXZmWkQ1UlVvMGd1dVRxaWFWUmR5RjN4NFAyRHQ4?=
 =?utf-8?B?UHg4cHlhRXpiTVZWN2tVL0tuSU1lSUZKYlpKOTBjN1BWTk1tWHoyeFRyZFJO?=
 =?utf-8?B?M2FXRmVRVThWVWdkK1N4UWxKaHNmdEs4bE1XaU1aQmZtaWRhZlEvTU55THd5?=
 =?utf-8?B?emYvYkFVSWZ0QVJEKytHUmpLZ3QydXZRdUtpWGYxbWZ6UmRHWm9CVnVhZHNp?=
 =?utf-8?B?OUlHdUtGaTdMZzl1bHBGMmF5U2VScDFTVzY0amRUUWlWek53Z2RNOFBpMUMx?=
 =?utf-8?B?cHFGRVlwQkVqNjJhbXZrTEg3dlJuTlY4NUxzVkVHTE8rQ0gxZXZiclltWlVJ?=
 =?utf-8?B?UUpubGpCZVRIZEpGdWJvMDd5MS9FQzVlOWxSd2VLQ2RqbWtaWEJoVVFRaEw1?=
 =?utf-8?B?MlJwQndLTWdBQUUzZm1jREdxWHBEbnBpSXZnQWMyUE5kOUVCdmFMczhMTGRO?=
 =?utf-8?B?UzZiT2NYcFZlVjYvNDR1OVVuQXhjRjAwQ2hCcFl2M0VtcERUR0NjZ0M4QmlT?=
 =?utf-8?B?WnBUT1p5dmpJcXROc0VycFVEQm90RkFLeG9odko1OFZta09VU2FXQlpjbzlD?=
 =?utf-8?B?cHZpSG9aM3o2Z3YwbXdHdS83Q2taNE4rZGdZenRYK0xnbGUzaXc3OUE3RFlR?=
 =?utf-8?B?Y3A4RVFXdkVYc2QzdlZKbUdzMEtialNLeVVIZGUzS1E0TTRxS0dWcU9UNGc0?=
 =?utf-8?B?anRDb2hZeXR4MUh6bVdsR3hVWW05ZDR5M1NhUkhqY2dPcFBlU3JtaG5FRzM4?=
 =?utf-8?B?RXdicXh5TVJCWFFGTHo3R05rTG0vU1M0L1JaUXhQMExKdmJxdi8rMTZlSW84?=
 =?utf-8?B?QXQyWXpYTk1UTE9taDJ0ajJNeG5IeUdkdUdWdlNhckNGR1lUTFYwNXpwaG5J?=
 =?utf-8?B?c1RaY2dheU9aUE1hdzIwUFBhY0tDYmRNREtYK1Bud0J1TUlVMTdsaGFibmQz?=
 =?utf-8?Q?o+GEGP6DMP2yQJ+XCx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46157854-8dd4-4f34-49cb-08ded808685b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:06:15.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRGfSlNQNpHISCoeOofXNZ73ESt5PnnPZLlRaPDE927O7S8w53cN9dgDOGOemIWp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22673-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:mid,amd.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 213406F4015

On 7/1/26 19:53, Zhiping Zhang wrote:
>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>>> index d504c636dc29..7a4c9b0d5dab 100644
>>> --- a/drivers/dma-buf/dma-buf.c
>>> +++ b/drivers/dma-buf/dma-buf.c
>>> @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *attach)
>>>  }
>>>  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
>>>
>>> +/**
>>> + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadata
>>> + * @dmabuf: DMA buffer to query
>>> + * @extended: false for 8-bit ST, true for 16-bit Extended ST
>>> + * @steering_tag: returns the raw steering tag for the requested namespace
>>> + * @ph: returns the TPH processing hint
>>> + *
>>> + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
>>> + *
>>> + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
>>> + * exporter does not implement the callback or has no metadata for the
>>> + * requested namespace.
>>
>> Please add something like this:
>>
>> * The returned information is only valid till the next invalidate_mappings() callback from the exporter and should be re-queried when a new mapping is created after invalidation.
>>
> 
> Thanks, Will do in v11!
> 
>> Apart from that it looks good to me, but I still think we need some kind of example that this works for other DMA-buf users as well.
>>
>> Just demonstrating that this also works with some simple FPGA or similar PCIe endpoint should be sufficient.
>>
>> Regards,
>> Christian.
>>
> 
> On v10, I have validated a second importer: another vendor's NIC
> (driver not upstream yet, so locally patched to
> call dma_buf_get_pci_tph). A PCIe analyzer confirms the TLP steering
> tag matches the exporter's for both mlx5/ConnectX-8
> and this second NIC — two unrelated importer drivers exercising the
> API end-to-end.

That sounds like it would be sufficient, yes.

Thanks,
Christian.

> 
> Thanks,
> Zhiping


