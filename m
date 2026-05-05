Return-Path: <linux-rdma+bounces-20022-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFZQOIES+mkWJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20022-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:53:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3E4D0A88
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01B2A3034D94
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F47D48AE09;
	Tue,  5 May 2026 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LelgPCX+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583E48A2CE;
	Tue,  5 May 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996257; cv=fail; b=hhHx6AQWGW6SP56qXVrdQnYmWoQIx+4T/FQ45rjYkapbTzzZFf7T5SYYhNph2a/BhSrHdMAGWWP7yYp2OSjy2ehy99QtAybEVRmD5sntpxnnWDIoPyx5otVi8/M1uBGfzQlDTM6SgJ9FzI7/4SPFVIsIgIfCVc4FKqXLo/6Mxzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996257; c=relaxed/simple;
	bh=LzZTlr4PRutu6+1h4NpaX87shhWyvaGzHMqVuKBKcJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cp+oUXF5R0MxCSldF6e9OUwrlvvZsZeF1eapG5QXXdFowQqgLvFi4O5kVRb6nhbPSLwrMu1gbLWzqXRXw6EpIuSaCmjRabgjhAREbwk3nKDJ8pxXXC9Wyi85bH23GwZlG4wpQ89a50qAMrVigIjmcC05CfsBcV6wrXmp94gzYY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LelgPCX+; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2yqH3TFqxatibRE/I//EYfinb1EfTZvumQv0mT0yETWcxDiUBGkYfTRQo1N3X4+Q7t3wywb20I7spqips9E5ngrCDky3lFVD4ebalp3kXAyOjKeOFmKAnj5OQpBicqVadUd8YBBZ9J2esfc5S5d3Mb8YXNRXnYXk/IzhEbPUSL0rMo+gbk95Vi4w5U+W1Q80cUV2hUqdYonDoIxG45tYq1mDK0ghUdpAxMmGi3GPv3S7p6MKJhjDRns2Dot1hMOhx7wkV0Mb8HlJlO6KDDAq99Vf7TScaHAWaO36bwtkyjwi7IsGKI/KB3fIUhZPYWt6K7PVJfuwcA07BoJPLSRiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duZzdMj9uB6iqS1TT9HpmtFXfLHLfydrTVrr97u/RpA=;
 b=t/BHSYnsFFADoIHfvYlYfGB1MN7Jk7kWjBCEvsljxJl1FEJE+Jnp8tDahQ9nZ1UedFCLKL+Sabe27LM5z9613Msnj6/7HiZaDZFt56kJ2zGYdwYWh18J+e68ryQCJD3DVRY5z5Xdf25I3yDIh8AOdS7fSUrD1mUSsi1zhv+cUiYFXbfOdgBjc5DeRt+cQmxvyYT1vJ4XC4EucSzxp6rlSFVHqu3W/Q3gLjr2BoBredLk+i4bdu9gUIyelh7l4aNmYN96cizNmtrlqd0+NgEATjoqwFGsuntMZVCN7MF8R8TOc0hAQOev1dGX9e4OvwerGTKW0RnFrNLRZVRNmM3a6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duZzdMj9uB6iqS1TT9HpmtFXfLHLfydrTVrr97u/RpA=;
 b=LelgPCX+5Lyu6doX4+HWW9wlTwIU8/3L1UlMcInFWP1HOW6xtRWrgXk5SuVG0A2swD6FOQaValsuliFDECLcyjKWRgaCcWL6OVJgMawU+ewZoadKXJsZNafP/DA/C6QqaAwJRECCXLLkMkAxApbQiRktSGehpQA8aUlA/tnQhuCug9zOp+AyiystwfD4TfrQ/fMjuxfwaK7kBUKniRo7WmYB7a48itC55dEWdVQttGttSYC5HEe55anK7xllKXDjvyb395HDPkrk6JqOgbRPORp8TJiXwamI+d3DSH0rev/nS+ehJrlEEsmyI9OkduTko1kOWhOE6ljRiUslCxGz9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:50:49 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:50:49 +0000
Date: Tue, 5 May 2026 12:50:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
Message-ID: <afoR1izCEe9y0MZA@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com>
 <afkjkBq8B-4KjhS_@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkjkBq8B-4KjhS_@google.com>
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c41502-f937-4b8c-03b8-08deaabe1457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oEuUlsQF9TPoqfbzGRFUKVoEETk06fXj3TefXev1rgv90N/UnbvZTO3mMfY+FgIBLN4OQH5r+41Cb6Qfz8++Ymi2HIcm61ByyIjNxgVZ+JCKPh4AhhYea1LtEAPKi7ds0YFtgX0BWbMTvdQ3oV3aAEyrffaRAhjAg3HZ/Ce2V2ZtLbwrxkGBTvj3qvFNNhtc3a1gjytwkns13clQNNBKCYUtz2qlwkE7zWOliOUSFw2ddJjLFHKHxOXhVdxt0H+js5NAPcF/28/N1I599YrC+4H6eFfImrjbx4MsHsuBUKnkLOt7XUlSit7A/lVx2uQQwGWSmi0VydUh5SLlX+PB3m80Ar6AcWUD06/xSfaTldAzot0sn+ZLx/+89JXygrRySUWNMOke8ldEG50TTLr2HBcZR7XSI7TEP3vSDb1MxhuXeaRCI1uPyxscXMkJfW1BV8NM/XIcT4xpqc44uKM2gfJkqve+qZ8TbabsQmVW2QiW412w4F3xz4bJDc6DPJ+Q1beYEjPzWIco/E5lVG5Oggpzu4EmLg76lCdRTEtW+mUdA3KprvG335sxKzksZdUcPlvJxCjJRHXL+J3Xdwh+ye1sQDp783GWkDVM3F6N3TfYdKMyeeZ4jvdDYIWDFhWdXKVnsiDkRQfqYvQ+ydW6doHQGKHrO7lGD/Utl9lcGz30MKuq9P50Xfh86EuruQqc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZt/J1JJVJ1o2KFNwVDyGgZETlDjSjnqF9+zDpuQMFELZtSvgFhceQdABo2U?=
 =?us-ascii?Q?+3zd0hD4tALa6YpiFiTx9SPEP0KgC/0j2VyG5QozBbKwnPyR3cx9TwxvS2Y7?=
 =?us-ascii?Q?At3vjGaI1zE/yBy9yALN2RsYWHfw9jsflB/CvK1XCNmh8NzrK1WELAYyJf+M?=
 =?us-ascii?Q?/bBiTRvQQGXcaRadcEbFFI4rq0GGxrQaxsrLwlT+7BiS5LcDdLsFPEbwp+76?=
 =?us-ascii?Q?t8oRNRt5VVXVUfPY+q1ipbMnARoCdv6DTm+4YN2C/5Zq6OPNy+pVFlP4Oi77?=
 =?us-ascii?Q?Mibj7jNnaDgQC3YnjatDKE9oFtczfN6SZ8PL9xZjbfQfm5mOaYJ3d4cqJljB?=
 =?us-ascii?Q?8TlA4F0cW+gBGZg/YuPoWK1jMYtXm03Rh2mz0hpO5FR4R+/6r6o7J0oywL2o?=
 =?us-ascii?Q?fNcJ0yeTK+Vd+4wdzbiia2T4R+cLOpTngna+L5Nhjk0Xf8fiBzuhzAFGs5au?=
 =?us-ascii?Q?xHXYlKxUqFOn9H9xygQA6HKSxbWPRDh+ttjD0ubKs5h43qk/pRtyKGMhSJwq?=
 =?us-ascii?Q?+hkOY5It9tbUG2JWS/mq6ewofxo2KpGS8B9BZEVAHFm+ehPhrbBdmv9UGDkT?=
 =?us-ascii?Q?djs68gtEpgIfKiuU7NPduDeue2FSA9/23KqHSDDDBCH27aI0MZEcnEunoW1m?=
 =?us-ascii?Q?nSowwBw2rd/6U1B0TDldCKjyIVqGF1gbfwecCmKM+s/mnzsoPmM6quO5HclV?=
 =?us-ascii?Q?yQAuoi+xtyvQI8c6fleqlazJCzoSqO94tND/BISL+AvTUpX9wc4ZY+2TvZuX?=
 =?us-ascii?Q?EYYIajpiJUElf2QSb5qlYa0F82sx7RaVqEgx/+HdvH0ih5XTfwVfXl+sg3iW?=
 =?us-ascii?Q?ORHOfCVN78TlX/k5XijNnTh4bUtLpahFAEfhDU8s08IGpzp3qcbh2EWbgedg?=
 =?us-ascii?Q?IXTelONibf7SZRiI2414KXtA4D8pbWccSwFaGMnium3QKch0S+qEg4tqp5Hs?=
 =?us-ascii?Q?Rrm8M3w6SEBPuTJABk3KevFlJoBTbqs+FkgnBwebiRRwuJGdLuAX/t9a05jZ?=
 =?us-ascii?Q?aQasUoZQEgJF4bxl3exJEe8nJvU85W+iYTb1LLp0iDFqR9DoA3xL5GSrEhYZ?=
 =?us-ascii?Q?rEJu/nRdLAAsT1uUOQEHti6Wmc+M3Cc6BVSCsNYc9hSh9L42MEvexye+Fwiu?=
 =?us-ascii?Q?q4hpqbyxT0XtmDFz17LH9ux9YE/LYBlfq1ngIjnSg0Pti7aCCTSStzb2x8Nq?=
 =?us-ascii?Q?DtkhhaPtyqyTEGvdPcTQpWJVRmApExrJuabOuIwqGPRI+Ki8alXbrL2gJJbA?=
 =?us-ascii?Q?K7h0L17F/KYkO+fFPQdpy8Kkb1DxKJ/KyvL8hSdYngIMA2VpNoJBfwMhEB2M?=
 =?us-ascii?Q?As84VFgKzjb2YPTgcqULa5EBMHN1lDxAa4T1bINMuzu3UttL6+cTPlAyjgvq?=
 =?us-ascii?Q?M4w2gs/Ml4sJoOqSQrLAJro6NPPzfR2Zlj999BfrkkIAwQRH1SBJu0BfAC2g?=
 =?us-ascii?Q?Zyudh9BukmbFz7iQA+o8Rws89JtUBjh7TR1IvZAiOYZHe3GHQrfe7SuLzoVE?=
 =?us-ascii?Q?I9fV8/S1M8uKQQHCPgysldX2rGOHsrEC6LDx+pNrHD3Pw/FB7KbiAKxgZsQQ?=
 =?us-ascii?Q?2pjhJo49zLuPtiXOkfboiS9tNUJKa0vBAhNLNAQBo4Rh2DPF+3QzBB42q9bv?=
 =?us-ascii?Q?RtSFwNWIFWJeB0YwqoIpY+2gO+5EfeJgkHHviPWKILbNSUtQY2PpiQc7nq0f?=
 =?us-ascii?Q?6rQ38eEFdg4bqEH+n2Ph7ABRR0V/6MKiFSSGgjpGCngEi/7w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c41502-f937-4b8c-03b8-08deaabe1457
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:50:49.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2snwYu672j7HdWDgdgkYK47AQeMXbJQBvVY2Er2Z71TVmMYL+Q+qG5rYAP9TEdDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
X-Rspamd-Queue-Id: CFB3E4D0A88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20022-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

On Mon, May 04, 2026 at 10:54:08PM +0000, David Matlack wrote:
> > The PF support flow requires a bunch more complicated stuff.
> 
> Do you think it's worth supporting PFs? If anyone with a CX NIC can
> enable SR-IOV and run selftests on a VF then we can keep the driver
> somewhat simpler.

It turns out my test system cannot enable SR-IOV due to iommu_group
problems so I rather prefer to have this :) I had to hack a kernel up
to do the initial testing and it was very annoying.

Jason

