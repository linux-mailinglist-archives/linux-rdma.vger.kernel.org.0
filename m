Return-Path: <linux-rdma+bounces-22028-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eRDMLU1kKGrUDAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22028-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AC663858
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 21:06:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=movQjLdU;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22028-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22028-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC49304D744
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB04ADD92;
	Tue,  9 Jun 2026 19:01:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F213C10AE;
	Tue,  9 Jun 2026 19:01:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031666; cv=fail; b=B1O3qMNuDr9rAxqkYmzHjZK1l6JyjMnpGzHxAAGCfcpcSBLDwMcTmoJQiG/BZQkXaob3mQ8O4IyoVKCYI4cHKzgkFJfG1lozPS7tzGZzvtDZKgRFmgwXVRLMCWttkdN8xHrt4rzguI2VDk2sRNk1aW+nFKmWPDZ8vTEd8x1Gkvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031666; c=relaxed/simple;
	bh=N4HUI12n4pqRV0u+lERbJI/rHwof6WwrdrMfgcbpWck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UHQGD0zeYVg9hWn/Wn6xVFXb7qny4f8YbdXuIVBhz3+pwa0NhgFPQyQc6po2aPbqlrBQO5ES2p3eWPzluZZjtm2C8NRBNk4+HgHiP8yUZ6ZHTjT6uu5zN4MDVJe5aWnSkB7A7RG2xpN/7lwzKR5jY1PvMVT1Z8zVEr+drHXeW8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=movQjLdU; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ2lXc4XIzx+QCIRFKT6kMCRbDL5gs1lpKFghdy1ondzGbioJqKd81dOq0cLo2XvqsIQcYAgvFhkY3fHHiPeY6Olv9fWka05C3xiJYoCor6INR0b793ntMOVuhYnzvyLYZZHIGJw08YZqv4Uq25+U2CYJKLWG+QjOeejhdPwPkPSmDaifCr01mGxrwwVFdAvKOxE0fNefVg0Q5KBwbIvHRgmi+VSYhx9/ftzyvndkJGfJvdF8Pt1KpZUnCHJAFPi0XwI/Y2fHPLz9WXBiJDFJ3KeNaQyALv8s67h9HZyQb8tQzYgCKYnss8mi/QGDK7LUe4sg20yKoNfJKrQYgM9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7OCo73cwt+4iC3xvHLBr8CFLhOHC7uU4+M5S+dnrFc=;
 b=ZthDjOhfRCEG0bQd2pZAO8fm86R4QpbQNU//Grj1jWutyvJut6pB2qamhVGZJZiFnYE2TxtmbYDk2YEU9vKpOVCzvnVq7U/XblNY9bOKQeIbH3NZhqgR6zjMy5feXuHZR+wEuQTOzED3/h7bTTRqRUuYaW+rPM586tZc9nLDAOma4wZCGJcma+NgnNzZOykwMkqHZvt6/fIzNtHJkvSElld4Mw1kecZuHau8MNlmnxk9PlvCn/troS5ylZIwDP/m1juuyHCI7ycNHG5whRT1PSiaDJ0Xi044V25hxHdkuZSy/yRQKboDa/PZ3bQgmDeH5MaqBOBumH4rFg9YQUt69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7OCo73cwt+4iC3xvHLBr8CFLhOHC7uU4+M5S+dnrFc=;
 b=movQjLdUs56xMr9++toPpkw7DiCO2YN1/fnAEXabhO2/hXO1ZzKLGW3BxthglauPfN71DoBtNP2xgfCch0leAk9QFv/nwHdA9/3Ts1FEGAkyyGfRjc2FX7op8/+6G+JE4F4G41tFpVgZ9KP4DAbjfojkRceqExLI9jfadB446Yj5+gb1uKU8Dn4O6rJwxbtKAK79d4Dcc09wl82NCNvFYjwOA9kVAII63yo2wXDR+udzYTBM/HgXabMVFx9dXpnNhH5MATQ40hxQ0XCqUjcd9o21N7IbWYN6LiH53MMTo2o4GYdqZ9Y0LVN6/jsLf9cAn4tujT2m9DgZ5ejJhO6CVA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ5PPFFA661D690.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9ab) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 19:00:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 19:00:58 +0000
Date: Tue, 9 Jun 2026 16:00:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Nelson Escobar <neescoba@cisco.com>,
	Satish Kharat <satishkh@cisco.com>
Subject: Re: [PATCH next] drivers/infiniband/hw/usnic/usnic_fwd: User
 strscpy() to copy device name
Message-ID: <20260609190057.GC584729@nvidia.com>
References: <20260606202633.5018-11-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606202633.5018-11-david.laight.linux@gmail.com>
X-ClientProxiedBy: MN0PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:530::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ5PPFFA661D690:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ba2a09-e523-4453-d5ed-08dec65970e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mtwSrjsxPacytuhpidymxbKMfME69ZnrKO4hlDwHjbEwtx3YsJPhymbL2dD218vcckFaBA4oinBiVjt6LagLJejjgZg9hxRgIa4OBQJAERL0zaXOUROVWc/I2BeVH4R68HmwfevpD7O5bB/TgzaXQvs6U1+p3o1oMBMa/lqIjQaf8MinvoOguDmF/DV6zGKXVteDtAc3Wuf1E7/D6PR3YZDtumCjSkoc8dlBVo5QActPbF4ZShUdklE1il93Gi+G8cJPp2vIm5b6J0O7C8KDgidHqglrEt3oopjJUvJM5W7KCvJz3PZuDMzTgLDBt8O0I2NawT1tnX9Z7bx4ZUzHkKpnIsrgYTYS28IEZnsvftg6o4dy+CYfaF89Ht7sqFWiqSMlqJ1l9AnoBIhKHjuwqoiXHsDiId4xrF7Q518t6BCqbgaOHIMwtnT/wt1IIvlQ3XS+6IeB8wnJ3lwWA+86fdIcYZYhyppgBSrDb0cw6Y14aunoGGnqKqoMXc8swkO4VrsphLdFj+ZGtRc+GBWxabbBO55rcFdmxgTlPh6wBWrEDP5b94mCynEwah0pG1SORGNWH/HTrZEsNbmB9g4oiGskFSvI/BoxAijUvDWirGRkBw6P/ECHJQtpnEP3kzKAsqRhOo1NyoqgrI5C6wUVhTNzCfPZS8tCBjAk5bPrMtJJt7eHRQpv+WCTkjmxOK37
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gmLKZQdlJtb1yxP/sdLji3EviPnhcvI+yW+vWW8uxyW7LkJDB3nUu41oq4w0?=
 =?us-ascii?Q?bohrGP4z7L8Wf8FZTP0N+IBGu7iJoqmrpfffPJU1ltJmcaTA4sTfRyZf682K?=
 =?us-ascii?Q?kg4zygWXIBmfr+avXNdhAhDAfuvPIXD8vD1PFEVIq4Po2XZknS9Jiz6MMW/5?=
 =?us-ascii?Q?f9a6oK+gnUkwbaJwNy40g19K3Rory1WvkBZOZ2WvWwSTDKfsQVna4GBKorVB?=
 =?us-ascii?Q?mMa8/lJ/lsdmoH7x8zfte4WEpoXD2fg/j2ArBaPJ/eaJ6esggn65ZFBjwaIT?=
 =?us-ascii?Q?J7O47RdN1HW7DYCkU6GOf1Rf94CjxgQXYQ/1A0LxTLxvNR0SU/64qH85CxGY?=
 =?us-ascii?Q?V6dL7jac7KxTjSyFEUBvy3iAYFpEUA7sxUwBEfmZlrmN4Dr2z6obn6UpJq82?=
 =?us-ascii?Q?6AqXX5hcQURafpnGyHAMUB/AQlNCvv0OdH4uZgPkzqD1Zj8JKEPGsA+gfxZZ?=
 =?us-ascii?Q?GTb90RHsY0Mss5A1hKdQTBhmaVk10Vv7jXYo03kYk8OA/+3YRPuYmKGmuKgS?=
 =?us-ascii?Q?mZrQ514eeIAMzM2G+r5cw7kaWCUxG12WH+fdivdJA68qOi3Y8U4WwsVTSMIR?=
 =?us-ascii?Q?B2CMLaMsZz4ClNP81AJYBAqDUbVytjRz9Eui8L+mPYd9p1/vbM9OWUVPN0zq?=
 =?us-ascii?Q?sWittUvg0Emlx/X275oa6Kd9m4Vyq5OJt4+cTMoO4aHY722fOnmxmWEa4tp8?=
 =?us-ascii?Q?OAlBuU8jlu5GGnBvnWgSOsv1j2unW43HFXdMZIraDaGF2TMWjM2HO6spxnqM?=
 =?us-ascii?Q?8ShF2Xj93nPiZLuAIP+TbTBUvdfh7a9fP42RVBgnd5g8zoS8Ia6L742OYZWD?=
 =?us-ascii?Q?MfOfIE71mmt6ItEj4izikOLtXPhgrLI0R/ROcS7lRZm669b3ys+4zl60GWqZ?=
 =?us-ascii?Q?t0W2oIn8XpXl4P2hI+oe9ae4iIz8ddAbvLAVlsllgmphoZaP/EoxGydStC1K?=
 =?us-ascii?Q?rwe2EHSFcbnHyYbIwYgp4Hofvm+4gaeWWcxQ5O0q3MZvgSTQTifl9gbqg90y?=
 =?us-ascii?Q?RZUUBUgZg/Yk/pDyOscAJChAVSuq5G1gEjzn6icdXCsMcH5d533mZZuEQTkF?=
 =?us-ascii?Q?RlTj32lf0u/fJV81z866hTuVmbBk4eu7BlxxGU2aOMOuFhTGZBdNqzgidzXX?=
 =?us-ascii?Q?owpFNS220W4u+XdTq6uwz1Sg7fbh490V/Yq1a3y+3leSUaTcZoqtfowfjVvq?=
 =?us-ascii?Q?Qtb1Wk8IxpAka7kW5VYcZKZw8oWuuKO5L3HheH7686QonubqsU0XuMTI5uG9?=
 =?us-ascii?Q?/OcD0HyvQIsiKzC8McGBYe93nwPFnEgin3F7eBzhSj1g1ZwHmHIv4yDg/aHo?=
 =?us-ascii?Q?9q21Sm6uWSE7Ac0oFruVYAM8jyJHS+YujMAqDNEbc3izCX9batGzjbeipE1p?=
 =?us-ascii?Q?uKB4+BYOWaUdanNlF8ezIAgCga4PyPI72owL6NhM1/KOY0p0HaLoCmbydRd+?=
 =?us-ascii?Q?pOpZg2JsjUFvWINlTZDnQ9qj8jVie0YhI90Rks4USPGlHhcjj0zZ7RfxhZGc?=
 =?us-ascii?Q?o8JoaVFLmGiQplWiz8ARaUl8nozYk4/4tXuynlnJ/47WUMzo0t5m8hIvB0/g?=
 =?us-ascii?Q?DTnpqTfnUXnPbbrsUVhgGWPpiK1jRLkmLZirzpErYFAtQdKmBrPYZrRFzLLU?=
 =?us-ascii?Q?AfDhprspukrjHPUL61m6bOnp5sQRE/E/sYqJ/1aBl0Y3bvawnEsmVemGLuVZ?=
 =?us-ascii?Q?E2Bhpj1vTRBKyjiHO2DHDDfS9uJJ4hxHFMIlYzKZFvYu4eIA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ba2a09-e523-4453-d5ed-08dec65970e6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 19:00:58.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7y61Z/iSE3RC/iCiedTlrG7Uys42xyyhAuBk68s6tqkIWORwT585TDky7ksUGvB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFFA661D690
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22028-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leon@kernel.org,m:neescoba@cisco.com,m:satishkh@cisco.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B3AC663858

On Sat, Jun 06, 2026 at 09:26:05PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_fwd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason

