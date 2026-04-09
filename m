Return-Path: <linux-rdma+bounces-19182-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCgaO7vp12msUggAu9opvQ
	(envelope-from <linux-rdma+bounces-19182-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:02:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DB3CE66A
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C39E2300A3A3
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7273AE713;
	Thu,  9 Apr 2026 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lMc8pwY0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88991A682F;
	Thu,  9 Apr 2026 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757748; cv=fail; b=rrjgezcJcjGGpJXw4QWWzkyp3VhK/vsaaii6DRmHIrB76Uo9u0eJ+WkC4N+lQhkIyT97vm9eJVZsgo3glGO0gwEi68uqFnRGKuYdxmlSxs9VhLZ932ltw1S9o0O14ABxxZB0G4br+8tpGFQgDiG2YFMO6ei7IxvY9sG56ULb648=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757748; c=relaxed/simple;
	bh=vL3pYTYIfuFpmj2H/dYWWd7v1OLWAXcm8l3pNTa4CtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a7P06TP2AluntWTfzT7h9wDHCKmSTGGTQRN2ru9ni0ZcYFjh5QDdZ8XLwZ/1Zxm1Q5hZ41COQ5nh8nxwHpkyIHRdtCThaJnvGFgC/gVKWTXDwBMjDnuMr3NogZv9xu+CvpFJFZB5oZm7BTrlSoaZleY7FUp5PN2smKFE1qP8aso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lMc8pwY0; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePSX24uGXJHxIgsrcF2km3O8B5wi8vc4tu2QvODKQUMZzFamm0QdegiWZBuY2cxNT9oT28k7iInxBFJtdV+YzasGEpLEcNKoWytiRb8acJlO3xbIZ+kjinbFa6HkCRu3e56355Z7x3TrVfbIKVQbEMtvZip47k1GgvXR+/kf9YhNtipZ0uLeBhLSrLvCuqZlhwI3xWlXl8io08k19zK6rBntpe/9SnMX6vw1uK1btgW5P4KC5yNNWhnxStmahcQZY81RR5FiRR3dUwj/hNueo16CJsVNmEWmj8s1GJcT2MQS2EAEmA/oc9POyTzfXq4UIUjaHAZauU7G40FAkUdItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPxw+I8iaQ899hP61gkED7c+bAoWDuPn9FESOxXC/vg=;
 b=Vg98zENWWfN2/erpbsyfxT7tWZPA1k3vZbjKNuqgYWKlrKM4wWJ+gBxzx9nq4WB3tz1Havfdulsf9mbCQQlzN4PDJVAETNr++Rbwgr2xZjIFE6FjVbYxf3+A9z7hmNTS5Ck8GYHVBDrRzznKDDkOGtPSiNL2bBLObZKINe2lZ2fZpe/6At8aQ+o2pw9F+Es98ebaTNbJbUAQGpBSlD8r0QpfiSMWv/np0t9vTr8Ac1S7w0cJ9gzHqWXnzwOHhhvDFOwHgFkWtQ/2w0a3zlGGZ8Meu1It/U0frxhUmpN0JHgWuPsRXwReqDPcrKYVPmGj3Tj5BNwFouTTMPEFhw/lNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPxw+I8iaQ899hP61gkED7c+bAoWDuPn9FESOxXC/vg=;
 b=lMc8pwY0hqFKneJkRDluS+8AW+ZH1naYaH8vMcBNqal4kJdL2QbOcCaidH+UHqEl5mvSVteDlZS5oiiIEthZgQpP3jM5vwy8pvh6YFB8JRmTjPZ48kySow7xJ3mF6rCwzQ5BsnlJyMMpWtyMAQR20PJ1yrXjKMukjYRl1WN0A/aJlWdKLEaOfUkJQlgrVcMGpMH8k4x75NwkSkfqW1UmmZwcLc/EYukqq+lvTdpoaoCEieHj3BhE3bjRXxDw0KnGB5l15E+kefpEseXf5mlNtAJmlIp+Nx51QT5r4R9jbrf5PVcqCDBx6/0CU5ZIr4KhuwPoFFmu79zAiyXSDC7A2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Thu, 9 Apr
 2026 18:02:04 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:02:04 +0000
Message-ID: <27ff77e7-ff33-41cd-92c5-6dff25cb0fd4@nvidia.com>
Date: Thu, 9 Apr 2026 21:02:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] net/mlx5: E-Switch, block representors
 during reconfiguration
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Shay Drory <shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>,
 Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Kees Cook <kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>,
 Gerd Bayer <gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
 <20260409115550.156419-6-tariqt@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-6-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0023.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::12) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5e24ab-04cb-42f5-f478-08de96621acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	DLXCPDRCKIQj0PWHEs1Uu43kk7ogZw5Ikv8JGJMiPguw3q+7ho8cWg3BiWbjroo7iLCCJmea8bh9wMlT2A80g1BV11MzLID5ovLuAE1OEwnnRrGhrcPXNR+9LeOAuqwxQn3fkZkCmBUV7NaCZjNi9av85MiJLp4bgLI+9j3iLlyOhc7F7io2QvE1/+tIL20i3i9iDGX5JlR16w6A3yYkxlm4cxQIeyZD5YxLVkbrbl1M551nN7RzEf5hsxwi2Cc7LvqJ1mZZEu5WNfaiDRNImzHqUC4EOPNEuklb8VCQ3TyjxtXaEgWgr3LBz2qAvNExeCLfTkONA3cMY819sAa+Qmtz+rq1nAAlRHb6RdwufK+DoLMAT77JSC8odx/ddvAitRHoC0WIdcnpmjEPfwe4QFSH9CVoXmwjRIqUtQYWObtOHtUNu0mmwuQSnMBCeXIhymPcgs5CHEv3MATcWbRQiUvGpMyjLOAVvD4DlNxYJJUc3ERTPWqP+5XDuXniQKdeSGPTBbCXLp00LtgvB9n+B6AYw7dUuUaZWLFmqzqtImku3Eb1H93n7z2eZqWf03Brv1ChFUk5nD28H34HLwlO1ObZMOjLEMmMKFoGB6BQ6Bu5uDZgK7g0t2OsGr5pSfP6sI+/TowMDM3gnUp1uvs4Dv/KERA6yhvqGRihlkmRgPGRfjJN4NB5P/Z4bCnbXOuKlKSpkL5zQYtB4s1w3gmAsagkQqvQpQTy4nnm+JcOWJk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXZMOEVIQUFmRzl1NXBJSXk0ck9MNnFtSEE2bkVHdTZQNEtuaER6dGVrNEh6?=
 =?utf-8?B?dlczdVNVYisydURpS3RmUlM4YWR4N1h6dm44dkphTkFvTzlCVTRZY0cyN3c0?=
 =?utf-8?B?Y0dtSWdxdkl6aW8xRWxwRFlaTXNFdVdycVFSKzNIV0lhTFlINEJJSTNRK2xn?=
 =?utf-8?B?aHFucHEydkRuK2hBRS9sRGtta1pMci9Vc0hFR0JEbTA4OUVrbCsvMHNHTlNZ?=
 =?utf-8?B?cHNoY0xmbW92Q21hSVU5dThWQmRObzJZMTFpLzNINXBIWHl3MWhua09hWUt2?=
 =?utf-8?B?RGtHekMxSlYxVU9jd0poaURFUms0ajFjemtYWXZzTlJwbTBhUzAyQThoSzRj?=
 =?utf-8?B?R2EzSG4vMk11QjFNRmFQOFR3MW82akVPU3p4RGNTbi9ZRnYwNzhheWpkNHpq?=
 =?utf-8?B?dS80M1BUdUQ4cGJmWUdRdURMbnlKV3VCNFlwRDU1QzV3dmJtVXFSWWVRTUtG?=
 =?utf-8?B?QVZzWVd6REN5OTJPbWszMGdURHdkbi8rNzRNRXJNNUVHcjJQaklMVlJnTFFP?=
 =?utf-8?B?elM3RGFCM1pJK0llNDFsOWRtYXlORnJBbTRkN3QwV3k1d29xVGJQKzQ0V0JS?=
 =?utf-8?B?Nk0xNGFBQTNwNUpFdmdrUThaeStlTHorSVI0UlhiRGFZVVNXd25KTy9uZXdJ?=
 =?utf-8?B?eVBacFJHSEwzMWIyTmVPMXNwMittUUg4aFV4dTRrcHU4RHdBdmdSMkFQMWRh?=
 =?utf-8?B?bC9BWUE2Rm9JU2NIc2RJMUNSS1VkVjZ2TEFqbkkzSTYwMGtBZkdNSVJVYWRQ?=
 =?utf-8?B?Y0l4a3hhb0x4dmZ0aFlmYlRkcUlYWFVpUVVTV1ZTendGWWxsakFKWHRNeXhN?=
 =?utf-8?B?VUpNRHl1dHJqamFqN252d3ZRVUJZUFRwSitVYlR4NlkxeE42L3Z0bWhSSXJN?=
 =?utf-8?B?Mlorb2ZBRGd2RlVFOEIvNktpSFkzNGdSRXJUQkdLRGppMDBNYWhPZEdWb3Y5?=
 =?utf-8?B?MkN3K0FXRW9pcFRzeEFJQmlrMmtnWE96WUpkOFNGeU00RTc1czJOdHAyNy9Z?=
 =?utf-8?B?Y1N3NGJBNzdNRkFjZWRPL3EwOXFzL05laUhGY0t0MVVoM0x3TFB5cW5VUWl2?=
 =?utf-8?B?R2xIbDBxSzFlcjRXUGFabXNBN0o2bVREY3VsY1NEWnNGWUdKUUxpR2xvNDBl?=
 =?utf-8?B?NXhtL0hrSE9GYXVlUkwvZXdpK0pJdXpVTkh2WEF5Tk5pb1VZVEdGdnJHTVl1?=
 =?utf-8?B?c0xsdEJVK0l0SVV5TXB1akU4RHBYNTFDUEp2VXQ4VVZSQnUwRnRkdW9mS0xq?=
 =?utf-8?B?bHhqKzNHTmsrWGhDV2pMeXpxaDRPenR3YjhMSHgzc2dMSFMzaFpCMjRjSHN5?=
 =?utf-8?B?VkJTRE5aMjQ1d08rTkZMaEYxUHBsbGtWVEIrUCtKUlRZeWFQYTRwaTBLOURY?=
 =?utf-8?B?Zyt3b2NsUEoyU3o4R2p3NmdycnovQXJxbC9ZZUtVbU52TTlsQlZxcTIvVEkw?=
 =?utf-8?B?aFlZbE1Sbnh6LzVJTU5xMlcyaENQZWExdm9VQXBzMlUrd284Y1pZR1JQVmo0?=
 =?utf-8?B?L1RSQU9hWHQwNmJKME55RWtrbTVMZlZteTVoTW45aFkxbXF1c25Uazk4cVFn?=
 =?utf-8?B?TmpRNmNSZ3g3NmFQWkViMlBlZVlrYjk3bnVmMElPU2lWOG9OSk1qYlllTGRJ?=
 =?utf-8?B?QTE0TmpHdUhaczJnOEZLaFZSbG5SZmN4QkdHcy8wSEdNZzFLRWJZSXJxRnUx?=
 =?utf-8?B?QU5ZODZSVzVjRnVQaTFVRXFjdUw3TWRqOHB4UEIrOVQwc2ZRSHY0WDVhRXB1?=
 =?utf-8?B?VjlzWlhJaE1QcE9kUENnOHEyNmtlMThxbTFKTFNKWG0zeUlNNFM3SjFJVnBj?=
 =?utf-8?B?TmhvaFN3R1h6ZWtub3pkZksvdlUzWE9xUVBzREdlNEhDaUhydk5Ia1Z3aVhs?=
 =?utf-8?B?ZVhqWjU5Z2FRVU9NTlpmSWVrQVRKemlYMGxWSEVEZ3J6RkpaQnZJdmxJMHF0?=
 =?utf-8?B?c0VGMXpNYkVPbVl5THd4VytZL3EzLy9takd1ZXRtKzFVQ002RFYzWmI0RUhI?=
 =?utf-8?B?NnJIVUtMTWN0S0pHQjdmQ2Rhblh4b1VSNzNSOUdmRlhHMVlFSWRvWS9acFpG?=
 =?utf-8?B?UHNLem5idW1rQUZSdlVSUmE3OSt1ekE3NnZqRkVtZXh0eFVyeGc0bkgwYWx6?=
 =?utf-8?B?Zmtvc2J4cGluMUlHd3FKTi9jWHNtVS93UUdWMCszSk1nYXllcmFJQ2pVdTE1?=
 =?utf-8?B?Tk9weSt4Y1JHRVlPSFdnWFNVeUtGdjJCdm1nbE9hTklPeVY3eVRMWVk4Nlky?=
 =?utf-8?B?eUlXMFJRWXgzNkZxa2JqdnZ3WjZrM000QTZmcXdBYmZxdXhFSE4xN05ra1h6?=
 =?utf-8?B?aS9MRzNDbVhUOVZoMUlaT1hjenpiV1BlUFFsR2ZDK2NhL3dnUldxUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5e24ab-04cb-42f5-f478-08de96621acf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:02:04.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMf5lDrTjzMJkMpa4D0Q6rGmPScwTqV3NPGGz9iTgbI3r8XaJwKNFGtkKnDoUT3F4kmg/yoo4IRtRoXewOM9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19182-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D6DB3CE66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Introduce a simple atomic block state via mlx5_esw_reps_block() and
> mlx5_esw_reps_unblock(). Internally, mlx5_esw_mark_reps() spins a
> cmpxchg between the UNBLOCKED and BLOCKED states. All E-Switch
> reconfiguration paths (mode set, enable, disable, VF/SF add/del, LAG
> reload) now bracket their work with this guard so representor changes
> won't race with the ongoing E-Switch update, yet we remain
> non-blocking and avoid new locks.
> 
> A spinlock is out because the protected work can sleep (RDMA ops,
> devcom, netdev callbacks). A mutex won't work either: esw_mode_change()
> has to drop the guard mid-flight so mlx5_rescan_drivers_locked() can
> reload mlx5_ib, which calls back into mlx5_eswitch_register_vport_reps()
> on the same thread. Beyond that, any real lock would create an ABBA
> cycle: the LAG side holds the LAG lock when it calls reps_block(), and
> the mlx5_ib side holds RDMA locks when it calls register_vport_reps(),
> and those two subsystems talk to each other. The atomic CAS loop avoids
> all of this - no lock ordering, no sleep restrictions, and the owner
> can drop the guard and let a nested caller win the next transition
> before reclaiming it.
> 
> With this infrastructure in place, downstream patches can safely tie
> representor load/unload to the mlx5_ib module's lifecycle. Loading
> mlx5_ib while the device is in switchdev mode has failed to bring up
> the IB representors for years; those patches will finally fix that.
> 

Sashiko writes:

> Note: The format of this report is altered to provide a free-form summary of
> the findings without directly quoting the original patch code due to system
> recitation restrictions.
> commit c88c0130c17d45e785dce9dae505cf3bd9664ab3
> Author: Mark Bloch <mbloch@nvidia.com>
> net/mlx5: E-Switch, block representors during reconfiguration
> This commit introduces an atomic block state via mlx5_esw_reps_block() and
> mlx5_esw_reps_unblock() to guard E-Switch reconfiguration paths. It uses an
> atomic CAS loop instead of standard locks to avoid sleep restrictions and an
> existing ABBA deadlock cycle.
> The commit message states that an atomic CAS loop is used because the
> protected work can sleep and a real lock would create an ABBA cycle. Does
> introducing an ad-hoc busy-wait lock to protect sleepable sections risk
> soft lockups or priority inversion when the lock owner sleeps?
> Furthermore, does bypassing lockdep with a custom loop hide the underlying
> ABBA deadlock rather than resolving it structurally? Could a standard
> synchronization primitive like a mutex be used while fixing the lock
> inversion?

What we actually guard here is the assignment/clearing of
esw->offloads.rep_ops[rep_type].

The root of the problem is the current mlx5 architecture, where
mlx5_core and mlx5_ib are separate modules. The auxiliary bus was
introduced to decouple them, but it also introduced additional
complexity.

In particular, during eswitch mode transitions (handled in mlx5_core),
the IB module may be loaded or unloaded concurrently. While this may
sound benign, switching into or out of switchdev mode requires creating
or destroying an IB device, which makes the interaction non-trivial.

To handle this, the eswitch code performs a fairly complex sequence of
auxiliary device reloads during mode transitions, to ensure the system
remains consistent.

The api here is intentionally minimal: the critical paths are
mlx5_eswitch_register_vport_reps() and
mlx5_eswitch_unregister_vport_reps(), which are invoked by mlx5_ib.
These functions primarily assign state and ops, and the goal is to
ensure that rep_ops is not cleared or reassigned in the middle of a
representor load/unload sequence.

There is still a known issue on the unregister path, where representors
are torn down. I plan to address this in a follow-up series. This patch
does not make the situation worse; it ensures that all existing cases
are handled, with the remaining gap being that unloading should not be
performed directly under mlx5_eswitch_unregister_vport_reps(). This
will be fixed separately.

> In esw_mode_change(), the representor block is intentionally released and
> then reacquired to allow mlx5_rescan_drivers_locked() to run. Because this
> custom atomic guard lacks owner tracking, does dropping it mid-flight open a
> window where any other concurrent thread could acquire the block and mutate
> representor state? Does this defeat the mutual exclusion the block was
> intended to provide against concurrent operations?

This is intentional.

We do not require strict exclusion with respect to IB representors
during mode transitions. The requirement is that the eswitch and the
driver remain in a consistent and safe state (i.e., no crashes or
corruption).

If userspace races IB module load/unload with E-Switch mode changes,
the worst expected outcome after this change is that no IB device is
present. That is considered acceptable behavior.

> The mlx5_esw_assert_reps_blocked() function checks if the global
> reps_conf_state is set to BLOCKED. Since there is no lock ownership
> tracking, if one thread holds the block, wouldn't this assertion silently
> pass for an entirely different thread that failed to acquire the block?
> Could this provide a false sense of security compared to a proper
> lockdep_assert_held() check?

This assertion is not meant to provide ownership guarantees like
lockdep_assert_held(). Its purpose is to catch incorrect usage of the
api.

In practice, there is effectively a single call path that manipulates
representors at a time, and triggering concurrent access requires deliberate
effort. The assertion is therefore primarily a safeguard against future
code paths accidentally bypassing the intended sequencing.

Mark

> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c | 13 ++++
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  6 ++
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 77 +++++++++++++++++--
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  2 +
>  .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  5 ++
>  include/linux/mlx5/eswitch.h                  |  5 ++
>  6 files changed, 100 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index d315484390c8..a7701c9d776a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -1700,6 +1700,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
>  		mlx5_lag_disable_change(esw->dev);
>  
>  	atomic_inc(&esw->generation);
> +	mlx5_esw_reps_block(esw);
>  
>  	if (!mlx5_esw_is_fdb_created(esw)) {
>  		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
> @@ -1723,6 +1724,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
>  		}
>  	}
>  
> +	mlx5_esw_reps_unblock(esw);
> +
>  	if (toggle_lag)
>  		mlx5_lag_enable_change(esw->dev);
>  
> @@ -1747,6 +1750,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
>  		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
>  	atomic_inc(&esw->generation);
>  
> +	mlx5_esw_reps_block(esw);
> +
>  	if (!mlx5_core_is_ecpf(esw->dev)) {
>  		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
>  		if (clear_vf)
> @@ -1757,6 +1762,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
>  			mlx5_eswitch_clear_ec_vf_vports_info(esw);
>  	}
>  
> +	mlx5_esw_reps_unblock(esw);
> +
>  	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
>  		struct devlink *devlink = priv_to_devlink(esw->dev);
>  
> @@ -1812,7 +1819,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
>  	devl_assert_locked(priv_to_devlink(esw->dev));
>  	atomic_inc(&esw->generation);
>  	mlx5_lag_disable_change(esw->dev);
> +
> +	mlx5_esw_reps_block(esw);
>  	mlx5_eswitch_disable_locked(esw);
> +	mlx5_esw_reps_unblock(esw);
> +
>  	esw->mode = MLX5_ESWITCH_LEGACY;
>  	mlx5_lag_enable_change(esw->dev);
>  }
> @@ -2075,6 +2086,8 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
>  	init_rwsem(&esw->mode_lock);
>  	refcount_set(&esw->qos.refcnt, 0);
>  	atomic_set(&esw->generation, 0);
> +	atomic_set(&esw->offloads.reps_conf_state,
> +		   MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED);
>  
>  	esw->enabled_vports = 0;
>  	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index e3ab8a30c174..256ac3ad37bc 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -315,6 +315,7 @@ struct mlx5_esw_offload {
>  	DECLARE_HASHTABLE(termtbl_tbl, 8);
>  	struct mutex termtbl_mutex; /* protects termtbl hash */
>  	struct xarray vhca_map;
> +	atomic_t reps_conf_state;
>  	const struct mlx5_eswitch_rep_ops *rep_ops[NUM_REP_TYPES];
>  	u8 inline_mode;
>  	atomic64_t num_flows;
> @@ -949,6 +950,8 @@ mlx5_esw_lag_demux_fg_create(struct mlx5_eswitch *esw,
>  struct mlx5_flow_handle *
>  mlx5_esw_lag_demux_rule_create(struct mlx5_eswitch *esw, u16 vport_num,
>  			       struct mlx5_flow_table *lag_ft);
> +void mlx5_esw_reps_block(struct mlx5_eswitch *esw);
> +void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw);
>  #else  /* CONFIG_MLX5_ESWITCH */
>  /* eswitch API stubs */
>  static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
> @@ -1026,6 +1029,9 @@ mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
>  	return true;
>  }
>  
> +static inline void mlx5_esw_reps_block(struct mlx5_eswitch *esw) {}
> +static inline void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw) {}
> +
>  static inline bool
>  mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
>  {
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index 988595e1b425..4b626ffcfa8e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -2410,23 +2410,56 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
>  	return err;
>  }
>  
> +static void mlx5_esw_assert_reps_blocked(struct mlx5_eswitch *esw)
> +{
> +	if (atomic_read(&esw->offloads.reps_conf_state) ==
> +	    MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED)
> +		return;
> +
> +	esw_warn(esw->dev, "reps state machine violated: expected BLOCKED\n");
> +}
> +
> +static void mlx5_esw_mark_reps(struct mlx5_eswitch *esw,
> +			       enum mlx5_esw_offloads_rep_type_state old,
> +			       enum mlx5_esw_offloads_rep_type_state new)
> +{
> +	atomic_t *reps_conf_state = &esw->offloads.reps_conf_state;
> +
> +	do {
> +		atomic_cond_read_relaxed(reps_conf_state, VAL == old);
> +	} while (atomic_cmpxchg(reps_conf_state, old, new) != old);
> +}
> +
> +void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
> +{
> +	mlx5_esw_mark_reps(esw, MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED,
> +			   MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED);
> +}
> +
> +void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
> +{
> +	mlx5_esw_mark_reps(esw, MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED,
> +			   MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED);
> +}
> +
>  static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
>  {
> +	mlx5_esw_reps_unblock(esw);
>  	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
>  	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
>  	    mlx5_core_mp_enabled(esw->dev)) {
>  		esw->mode = mode;
> -		mlx5_rescan_drivers_locked(esw->dev);
> -		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> -		return;
> +		goto out;
>  	}
>  
>  	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	esw->mode = mode;
>  	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
> +out:
>  	mlx5_rescan_drivers_locked(esw->dev);
>  	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
> +	mlx5_esw_reps_block(esw);
>  }
>  
>  static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
> @@ -2761,6 +2794,8 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
>  static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
>  				   struct mlx5_eswitch_rep *rep, u8 rep_type)
>  {
> +	mlx5_esw_assert_reps_blocked(esw);
> +
>  	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
>  			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
>  		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
> @@ -2771,6 +2806,8 @@ static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
>  static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
>  				      struct mlx5_eswitch_rep *rep, u8 rep_type)
>  {
> +	mlx5_esw_assert_reps_blocked(esw);
> +
>  	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
>  			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
>  		if (rep_type == REP_ETH)
> @@ -3673,6 +3710,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
>  	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
>  		goto free;
>  
> +	mlx5_esw_reps_block(esw);
>  	/* Number of VFs can only change from "0 to x" or "x to 0". */
>  	if (esw->esw_funcs.num_vfs > 0) {
>  		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
> @@ -3682,9 +3720,11 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
>  		err = mlx5_eswitch_load_vf_vports(esw, new_num_vfs,
>  						  MLX5_VPORT_UC_ADDR_CHANGE);
>  		if (err)
> -			goto free;
> +			goto unblock;
>  	}
>  	esw->esw_funcs.num_vfs = new_num_vfs;
> +unblock:
> +	mlx5_esw_reps_unblock(esw);
>  free:
>  	kvfree(out);
>  }
> @@ -4164,6 +4204,7 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		goto unlock;
>  	}
>  
> +	mlx5_esw_reps_block(esw);
>  	esw->eswitch_operation_in_progress = true;
>  	up_write(&esw->mode_lock);
>  
> @@ -4203,6 +4244,7 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
>  	down_write(&esw->mode_lock);
>  	esw->eswitch_operation_in_progress = false;
> +	mlx5_esw_reps_unblock(esw);
>  unlock:
>  	mlx5_esw_unlock(esw);
>  enable_lag:
> @@ -4474,9 +4516,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
>  	return true;
>  }
>  
> -void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
> -				      const struct mlx5_eswitch_rep_ops *ops,
> -				      u8 rep_type)
> +static void
> +mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
> +					 const struct mlx5_eswitch_rep_ops *ops,
> +					 u8 rep_type)
>  {
>  	struct mlx5_eswitch_rep_data *rep_data;
>  	struct mlx5_eswitch_rep *rep;
> @@ -4491,9 +4534,20 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
>  		}
>  	}
>  }
> +
> +void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
> +				      const struct mlx5_eswitch_rep_ops *ops,
> +				      u8 rep_type)
> +{
> +	mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
> +	mlx5_esw_reps_unblock(esw);
> +}
>  EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
>  
> -void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
> +static void
> +mlx5_eswitch_unregister_vport_reps_blocked(struct mlx5_eswitch *esw,
> +					   u8 rep_type)
>  {
>  	struct mlx5_eswitch_rep *rep;
>  	unsigned long i;
> @@ -4504,6 +4558,13 @@ void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
>  	mlx5_esw_for_each_rep(esw, i, rep)
>  		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
>  }
> +
> +void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
> +{
> +	mlx5_esw_reps_block(esw);
> +	mlx5_eswitch_unregister_vport_reps_blocked(esw, rep_type);
> +	mlx5_esw_reps_unblock(esw);
> +}
>  EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps);
>  
>  void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index c402a8463081..ff2e6f6caa0c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1105,7 +1105,9 @@ int mlx5_lag_reload_ib_reps(struct mlx5_lag *ldev, u32 flags)
>  			struct mlx5_eswitch *esw;
>  
>  			esw = pf->dev->priv.eswitch;
> +			mlx5_esw_reps_block(esw);
>  			ret = mlx5_eswitch_reload_ib_reps(esw);
> +			mlx5_esw_reps_unblock(esw);
>  			if (ret)
>  				return ret;
>  		}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> index 8503e532f423..2fc69897e35b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
> @@ -245,8 +245,10 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
>  	if (IS_ERR(sf))
>  		return PTR_ERR(sf);
>  
> +	mlx5_esw_reps_block(esw);
>  	err = mlx5_eswitch_load_sf_vport(esw, sf->hw_fn_id, MLX5_VPORT_UC_ADDR_CHANGE,
>  					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
> +	mlx5_esw_reps_unblock(esw);
>  	if (err)
>  		goto esw_err;
>  	*dl_port = &sf->dl_port.dl_port;
> @@ -367,7 +369,10 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
>  	struct mlx5_sf_table *table = dev->priv.sf_table;
>  	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
>  
> +	mlx5_esw_reps_block(dev->priv.eswitch);
>  	mlx5_sf_del(table, sf);
> +	mlx5_esw_reps_unblock(dev->priv.eswitch);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
> index 67256e776566..786b1ea83843 100644
> --- a/include/linux/mlx5/eswitch.h
> +++ b/include/linux/mlx5/eswitch.h
> @@ -29,6 +29,11 @@ enum {
>  	REP_LOADED,
>  };
>  
> +enum mlx5_esw_offloads_rep_type_state {
> +	MLX5_ESW_OFFLOADS_REP_TYPE_UNBLOCKED,
> +	MLX5_ESW_OFFLOADS_REP_TYPE_BLOCKED,
> +};
> +
>  enum mlx5_switchdev_event {
>  	MLX5_SWITCHDEV_EVENT_PAIR,
>  	MLX5_SWITCHDEV_EVENT_UNPAIR,


