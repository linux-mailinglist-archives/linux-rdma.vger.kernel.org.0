Return-Path: <linux-rdma+bounces-19836-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM3MDjjY9GmfFQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19836-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 18:43:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 356844AE21D
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 18:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C01F3007A5D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1C93FAE1E;
	Fri,  1 May 2026 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gI7ZC8qe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D93FFAD8;
	Fri,  1 May 2026 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653807; cv=fail; b=D3tNDLhD8S44LissSTj+ouD6RcsAzjFtE1/3RMj5wR9+ccA1XaFFO7MH2N9wPomaHBKpAJsOt7tJ9/Z7CuW9fT+Hc5KjbFQQ+ztNF4qaEv94panWUvo78LjShYW6QS3zY9A25uHBDsQoNSxCE5+S7khxR0RoJo0u92nroGSbxv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653807; c=relaxed/simple;
	bh=sk9aaABRQd5AAVhOEJYhmL+auYmTV8efAXWsZPGB8Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nrjj7tEtF9bX7drWLr0a8vrRXweXwyaqhi0UZwVDM88QlscLCEqe3Can8TcbQs7gAFmMoAO57WgdFQmAGJc8zKfEALWZlGBqAYhxqXnam/aBehleexieXH4Fa7biCKbn3TTomFFY455Dh8JmYl4CXR1kcE0qedC1cvhPzGIb8wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gI7ZC8qe; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJ+sSv2XQ/7FE43XCGDIWG2pFckhkDcfkWzqo6wJWrKw2sbRd0RUsqSrQ1f3Gv/3fdKeZff9gz3ik2IbYEGLBaSBmN/NA8RadVqxJg5r8Q8usqHtR3Nf6RqYcKGviajLZnIhjkQSds6+igQ2bvnio4EMpj3SEuA80vek5LFh+wwSi6SwZ3Ax37DDoO09/sIEwF7BZVxGYkz7k1EFprwDycOSSVAmPPOvasEazi58SBPINTr7xo6aUWw6wcE0kBSE4/bu1A+RGn8EJmvBBxHBnTmUZjYsD+QwQSzvLwiKa7/S8yBX+g4b2vk8TrCAwnedMFvkFSLiaNURD4YZTXeRAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVBHX/h2tJHzOIi5eoFpKZibLGe9wiV/sB1WTybCUfk=;
 b=mGHZ2NHClTrm3mQUp+mHhGy7hvDqmbyrfWrDgPNp5OjTg59S7hdI26mKfb/QAhRqHINM2UGo0d3HP0hi1DY529TxAmFmcCqTb6QODtsGrShbHY18BzvblWy17kvZcOJ61hovBf5B844+TIo+BY5ExFklBhqE/fvcPPSeZ2XFu6+hNjFtZ71MljCAtL92Dwlsuy9/gECPANlwhAk9b1dkGCXCNctJWuth3fsSgS6omA/htH8BUBQNTCwCCUcSEflidHL4B3GRJj2UBSeQS1fnep7QYJdJcGXnwDLKXBEe93p4rdIhAPaeL/q+XkrynAAr5NMkDV++6OTVxnyhQ/cxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVBHX/h2tJHzOIi5eoFpKZibLGe9wiV/sB1WTybCUfk=;
 b=gI7ZC8qecbQRviWCzbT1BnbaqJ+AfFZ+7qvu0DFlK6jgrNM07KUCb7A/8UbJRRhJcWRld87GxrKHYtLvgsZscw68B50bOPskCSiZw3XDJmQdv11uzLGiXdUZxKT0dbdUjNRM5Q/P6NyF71y4QVFLbtKkG+C6Gl9/Ad1uieYo1LP+hS599+63q8Fyn3T1nwHV9K+VbJduanB9jVyqRpAhTTNH8KBQUMxRLPf/S5xJBAP/qeGn0vBMwKjlQfkbEPJLHLPd0DHapu09v7otsrVqrbC+9zzHXTAWEfjZgPa1RmMRMbDDal2+vfFwgpU/XXCuoZN6TyMve74Qcm51pEcklw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 16:43:16 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 16:43:16 +0000
Date: Fri, 1 May 2026 13:43:14 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Message-ID: <20260501164314.GA1381708@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0104.namprd03.prod.outlook.com
 (2603:10b6:208:32a::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 09414d99-7fb9-4a43-d09c-08dea7a0bdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f43ZZUCuXsiqGu9hkkowHDCn/vhLltvEcQV2DNa94WG6QSks5T8nK8VnvaN1B6iFXSr7Q88A6ZUJ2vmdNELKkPkH4EW9rMUpdCmRJPZ2psTRKmvpFLM71G8tDs2xp+MeFsLqoycWoihtEy9T2wMIYoR4f47/RZK1XSlLHmwaKrLK9r5VO2obMwPATQoil1mcmYTjmMdcdtKktJoxV4UkosV1iMuSKw69mrfl6TiH2bJxHHY6bEsGCw1r2uE87RNqc5nHYDCBWGECjC61q4cSmF8vns82/xxE/3r/gXJIlw4w1zXkTxpYbyNGH3BZBKyQrabkP5f8RwJU1XwZ1lkGxdAHPsmEXmXrM04/VudVUaSVpJQ2HVBMJhJT7SDsnX2vz9j9FfAIOCYVUFbcIQIjfqvj1yrZH4v+TBLpuWJ3spX1H84S2lMJ1s+d877GL5TSTgniE9CmwByaGZDm0tvc0orDTAYJDrQahvDybINUiu2NjkkQC+QPKSmlSgiKZrV1AOq4/z4bVnDSPU9fTyBQsXTt11S75QpN5PmOo/6qQVXoaHsKgKGjVWAm32hsjHi6I1iq/6EjnVs4RO+VbLkOi/fpwVd3z1g8o72YR4Gc77PRpRWdvdCbnlg1TwLMX0PpsoAy9F2iRiiEWIuKsY9K7AtAT2KXlapSOMjgGd0/+DS1XSZ9ig8XseyZw/wp+tKRVRhAlyqeiM+IHnYVbJ4zvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE4yL1ppdXIrNWViZFdrUk1PMnpmN2RackkwaW9seExVQmRqWHN2M29SdzBB?=
 =?utf-8?B?bmFKV3ZnaGhNbHBBb05RTzRXbzVnZTRnS0F0R2xLTHZMMGxkeHBNN01tZ1JE?=
 =?utf-8?B?b0ZneVV6VGZDMzFUeUVuWGtQMXd6QSswOFROdlNCMGZNUlNtWnFzU3BvT3lC?=
 =?utf-8?B?NG9tcWlpdUdEekNKci9RRlhXRWUwYy9palZNN2QzWnJqUUI1dHFwZ0ZWc0Fn?=
 =?utf-8?B?WjhZTUxZRDhIK1A4NkVsV0R6U3VVOVJETjFGdGlkdGIzaUpoTnZjdDlpMU8w?=
 =?utf-8?B?YjJFcTRhY0ZLWWRPUFI1dHpwQlRBdUl5L041S2NVc3Q5bDJydDRmcHo5cTJr?=
 =?utf-8?B?U3JMZGx0Vlg5Z3lCUWRLUVNJYUJEei9ERkZDdUlvMVlTemNiMjd1cWs2RUIy?=
 =?utf-8?B?V0x1RXBTUE5UVVJMVjBXbGZDdWhJQmxzcTVLVVVxelhraVBJcFJBUFlZN2do?=
 =?utf-8?B?ZUJkYUMzQzRmV3o4YnZyd2tCWU02U3M4VG1wOTh4SENiYVJ3K1NuVnYxS21n?=
 =?utf-8?B?VU1KVnNHSzZGaTVIelArYUZXTis4cWJXWGNmc1lwMVVXWmtMSnZHMEV3UW1F?=
 =?utf-8?B?bnlBRnpPb0xnQ3ArdkpwcDlmQTFKUjZPa0J2ZWFWWi9SQnZRa3UvaTJuT2lQ?=
 =?utf-8?B?U2ZpNzd6MXFMVHV2TmRVUk1WQ3RadlFudmdFZXpWbkNNdUZoSURLZ0kwY3Vo?=
 =?utf-8?B?YzRFamlpWmRZSU9VUzQyYjcxNDRkd2kyNHVUbkZma080OU9DSlhPMk05b1BS?=
 =?utf-8?B?N0FRTVJOZk1YOU05d0M4K0pFRDkxL3MwbWpxT1VYN05FYW1LdWI0VUJ0amt6?=
 =?utf-8?B?SU9LVGlmU1lDVi9sWlRZQWNYeitta3RKa3lQWmJZZ1FVUFFOdzB4NHJ0V2Qy?=
 =?utf-8?B?Q3RIREhMSGlyTFYvL1J5dWVZYmcrbGFwaC9ZcFlwSXk5d05MMEJKSlpXdHNu?=
 =?utf-8?B?eEJNaWhHa0M5ZTJWSmpWb1JGKzdKL24rSjBWLzZMQTR2djlsenZZQTIzUmV4?=
 =?utf-8?B?ejJEdldrOGQvUkpRNzRVWUV2bGN0NFlSRWFGaENpemRQNFJpMEpaeVdXNHh3?=
 =?utf-8?B?YnhlUDdheU82aVY5em1sbjVoTHZmTGpqUzhiZ3BXdUdTNzJnMXJVS00rUmNO?=
 =?utf-8?B?ZjFmVmE5S1ZHcUc4TGZicmc5V1lva0xwbkQ5cnJkUVpjRmkvL0NwdFlPVkJs?=
 =?utf-8?B?R3BZRGNNT1RyRGJNQUliWGE3b3J4aU5BWCtVL0xiNmp0ak9vZ3MrRktGZm5D?=
 =?utf-8?B?NHMzRmVhdUpZT1NaTURyanR4Y2dDY0VMSXZDb1VtR3dPb3NJSXZOS291MFVW?=
 =?utf-8?B?dVRNUlhMTnoyb1N3YkRQdVVpZ2hMZmVrYWcxcVBhN1lJRGM3ZTZ2cGtMTTlo?=
 =?utf-8?B?REFOQlJQZmZVN2RZamRtd2U2OHJ3Z2xuZ3hneGNSMGRqVUFaS2ZPRHNBUFBM?=
 =?utf-8?B?clBubFVlRno4VUI1QmVSVk55MVlTZnNOdTFHUDJwODJjeE1odFhmOFNrTlFt?=
 =?utf-8?B?QXd1bVBNT3NtK1E5aG4vWmdpKytRR0NtTXYveDVzMS9PcnFOQVVRbU1aZ3Zw?=
 =?utf-8?B?UFhpa2J1WXhtalc4cHhVNjJlOXhDTkdkaEV2ekdzaUgyZEJULy9MUGcxSnls?=
 =?utf-8?B?OUhpQjdCNWlUci9hT3RFQm9SSmdaTjcvYjYzUk1pMjM3ekcvaUkyQ2YydTlJ?=
 =?utf-8?B?WDlmc2psM3RaTjE4bmNLRTdQdlRFdk5wMnVpMUxZSkxRNVdXTTNZTXFjSlFw?=
 =?utf-8?B?UGRXNGpJallCMTl5SFcrTGJaSnhGVWxaQ0Yzb3JFNUtybkJWdk1UcEFWKzZj?=
 =?utf-8?B?TTZRZVJuWHpFOXQvOENCcHNYcEVzWnZObFZWMEZVN3QxVTMzenVrMGI5ZFY3?=
 =?utf-8?B?MjQzMEVqSXQ1bXYzUSt2MWZBdnRWT3VCYm10Q2pNSEdEalpzdzZoa0VlVUlZ?=
 =?utf-8?B?OG40ZHZmQ2JsRDRjVkpxSWJZZ2wva0p2Q3ZaSCsvcVZDZTQram1peklQRFA0?=
 =?utf-8?B?UkxHUGVZbXNSMG5peHVyOWhKajZiNDVlVGVBdWdhK3h3ckk3aTRWRGRnUmJI?=
 =?utf-8?B?QWxvVkFWY0lnd3I2NGpBVUU3MEhYMjdvUGNDNy9LMXJnMmJXVmxHRXJwWlVy?=
 =?utf-8?B?c214aWNscXE5K1psTE9Fbm83bWl4M1c0ME1yOGZyYTFiSkl3djNDbUlzUE42?=
 =?utf-8?B?MUFRNXJtVEdmV3NRTEw4MmUzc3NYSWlhQnN2NFk2SXBnNmhnb3l0eWRDbU15?=
 =?utf-8?B?RmlLUHZPSExuTnJLRndXOGxnSjYrMnIvWVJwUXRoMlFMTWNQVVovbGJpVEpq?=
 =?utf-8?Q?UZ/ayMmnw/vatThVbz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09414d99-7fb9-4a43-d09c-08dea7a0bdf4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 16:43:15.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Qp9pH1lKh9ILiB0hCFPLWX3+OdpMvZs8Cpxb80+RVpSvc4FITZwEXyr8SPSTFGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-Rspamd-Queue-Id: 356844AE21D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19836-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,qemu.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 09:11:11AM -0700, David Matlack wrote:
> On Thu, Apr 30, 2026 at 5:08 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > Add an mlx5 driver to VFIO self test. This is largely a remix of the
> > existing VFIO mlx5 driver in rdma-core. It uses an RDMA loopback QP
> > to issue RDMA WRITE operations which effectively perform memory
> > copies using DMA. Since mlx5 has a stable programming ABI this
> > should work on devices from CX5 to current HW. The device FW must
> > support the QP loopback configuration.
> 
> > This entire series was coded by Claude Code in about 4 days.
> 
> Very exciting. Josh Hilke from Google is also working on using AI to
> create a selftest driver for Intel IGB NICs so VFIO selftests can run
> in QEMU [1]. So it's encouraging to see you were able to do it with
> mlx5.
> 
> [1] https://www.qemu.org/docs/master/system/devices/igb.html

Yes! I would feed DPDK in as well in this case? Combined with the
kernel driver it should be doable. It is much easier if you understand
how the NIC works, of course. This worked out significantly because I
guided it through sufficiently small steps and knew where to find all
the quality reference material..

> >  - Make it work on a PF too (this is surprisingly hard!).
> 
> Can it work on CX VFs? We're interested in continuously performing
> memory copies across a Live Update using a VF via selftests to
> demonstrate SR-IOV preservation (when we eventually get there).

Yes, I started with VF because it is simpler. The PF support flow
requires a bunch more complicated stuff.

Jason

