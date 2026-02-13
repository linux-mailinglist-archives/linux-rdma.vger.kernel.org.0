Return-Path: <linux-rdma+bounces-16799-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEQGFJZxjmmrCQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16799-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 01:34:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A720513215D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 414AE304E32C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48CD1A5B84;
	Fri, 13 Feb 2026 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2/jUL6R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311831428F4;
	Fri, 13 Feb 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770942866; cv=fail; b=m5sOOwm6yJAnlbtmkdYkLnYqN6ogRvG1v7/gjN96O5XhGLm2d0TlqT/nu8fmNC5e2YpCCBRkOpceI/iZnCp5ADOlDVY8Sios7gfjGf1o8W4iaUcY8sl4MUMRYSb7lv4jHod72L4abQEgoQPA2+08ONTByt/l6CYCkE7jONbVbvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770942866; c=relaxed/simple;
	bh=PGvDCeOUBz7VKZhWSZYc91sleuZ99M6WHJHZQVxdgS4=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MTWdQVR80yXhwXaYiq2OP2dZ6sHbM/YZgskdprc4kYqoze6xd6Uyvv+hAVPsS0JzEskzKSPfaDlWmykF5L8Jno3ruzjGmnLZZK725Auc4gWr8AaB9DpBvye+RNULQ+OTAHxMRESZ155We7gqx/DbGE4OID9CovzVEPXGJJWycDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g2/jUL6R; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWdPAscS3zkJzDNoGgWnZI35MvXXqVNUO5GU7+OQaoPc4GIpATnaiLyXD80pXbqg6AwfMawMuiSQ/jIgbqZdkzzXpNDpdlg03a9kuxGrFt6mUnmLqBoNUW2MYn4Ek57LB7TNFdoUOGTvyatAyoS0uHJZFtARR1zbSMYZNuAx/x8VrTJ0WoVlwsfWae2e1seic9O3gggTaV6Jqfjjc9fruLdNhZpN/UxIjU8npdRWgIPHsyA+9d+aSUiN6uMZ5ONRS1Vg1SMOrK5ZKWhTFa7cPMMfxGMVDKNfx1hrqDLUvANP2SVGpGRp03yfP4CXsEpgUKXYpeSKnM01NOem2syaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5RXvHg9CY8xfPb9vz1ix6QHyMTpSa92qEN27NYuwAM=;
 b=wFVCH5EHHnxSuOKdsAkvXfXVV+ztfkkTNJJS961pmde0Xvei325+eRU78RzGJO3qiQxXYac5KRZhxcIu0ucycCl9Ey6OdCd9BDt3tjjrKFHPshYyMowsAAJKJUXxmpFmaPIzZ1pwa+qBt2XNr9jCKim6QMFgOb6FYhqwAjO+Tj7hoh4HSplCOaJiQ4gMwR4raY9KPEsPjs6cBh0hZSy5zL+WsHy4pNBuplijCVbDncQVERQbVukM1bPSV4p5/T99zO2lUDttvTc158dC9bnkKRgvEiPkdjba2ou/cD6P7XmCxNkL7k89PgolPOeSE/HFTo+YJlYHDvLYTs4EmdgEEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5RXvHg9CY8xfPb9vz1ix6QHyMTpSa92qEN27NYuwAM=;
 b=g2/jUL6REuM7szdFJtZVGokp7whwZhsTrlfOcwkBVb+AtXkYXB1tijAO2S/pFLUbXsiRFk652PBRdZBMchNKBAmGFUTF55jh/jMKsNJKoBvr7RrmJMiB6wC2/QnDOpHBPwizDkA8szDznZC/0ovXi0fOkuJbcnpY1wKMy4U4qlH/7ZIlE1Vq1FwVV6gSxgi5dPqFyZdi7uCEGHklu2trzOrSeYOTYBiKsf5kW84qdzZ0wf6IS71govtGzfvmtPWmk/G1FXzA8lZkvvovbxUnoASEAbzlaeo4REqKSpCqUcWtnyx0zAs8m4ATEtmo/YpydgKpWis/noGtIAOpRlep2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 00:34:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 00:34:21 +0000
Date: Thu, 12 Feb 2026 20:34:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20260213003420.GA1062479@nvidia.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WRm97GXGObhkaxx9"
Content-Disposition: inline
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1b8574-baa2-48bc-4428-08de6a97a134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3Rhc1U1UkJqUVgwM3JKWDBEUGZ0ZFhyUGVCOEVvbXJuMk8xdzhzQWEzblc0?=
 =?utf-8?B?WXJKYnVPdkhvRk9HWklndElNRzZBRE9vT3owUldLUGpraUJuZzNFNjRIM3di?=
 =?utf-8?B?REkzMmtMWGZjNFE2RngxVWZwc3NGK2daR1NaWktINkh3UUlpNEdreEduRzc3?=
 =?utf-8?B?TDRtUURoTDdzclc2bjNCc3hMbFZUbTdCL3ZaajZaSFozbGdmNFFpMWQ1cHFY?=
 =?utf-8?B?QXBXUE9FV1dwc2JEMHVYa2dTbkRiQThIemEyTWg2TVZjaHRMMjJoWnUxTWNt?=
 =?utf-8?B?ZFF6NlVPZXRMNlUzTE5YKzJDZnYyWkkwRzl0akNXdTFZUVZJdG4zbWJnMWFj?=
 =?utf-8?B?RWh0elZOYnhKM1ljRkl4U3NlczJtbTluZ0JEaERWNGNxaHRQMEZ3TkNiaXV4?=
 =?utf-8?B?aml2WldiRklINzFsR2htcnlYWXJyOTFkd0JZSmNQU2UzMnBHMTdTb056QWlq?=
 =?utf-8?B?VmZJZ2R1TGNKUnA3dXErSTdFS2VkK0JmZ0M2QVV2N283NUtXZk9IQXZoL2FK?=
 =?utf-8?B?TE9jRXJmRlhTM0lzQ1JqWWR5aUY2T0FNNFR3dFRDQVhqNFJLcURGcGxsYlhC?=
 =?utf-8?B?VEQzZnhqcy9RODNpUFJTNHQ2MElkUDAxNXhHc2R3ZFJzL0h2Vm1xanBtSkZ5?=
 =?utf-8?B?cVJyaytDb1IvUkxMdUxHVUE3YWFwRXFVRGxnYU5tNmNpZGtXV3BPUC9UQjdm?=
 =?utf-8?B?RjJ5QVlnYXQvcXhIUVVIMlZ6SUdVZThyS3AzSmZ1clBENUtvSWVqUXhDdzlX?=
 =?utf-8?B?eXJPL0t0c2k3L1R2TkZiYXZSL05Vb2ZFaTZpaUxDMWhWRG04cHpWTkVmZFhX?=
 =?utf-8?B?OTBEOEY2ZDVodzk0bmwwbUNscVY3d09NMStFQ1pORkN6VXFTcytoMjB2TzM2?=
 =?utf-8?B?UWJlOGlaaXBneDZrNld1NjgwSjdDUUNCU2kwTENnUFJiSmxhOS9aSU9FaDVt?=
 =?utf-8?B?QzZ3WXFZZGRZTDduMlZFaGJYbEozUnU2M2NCRkVjUVR3RmZxYVl4Q2Fib2dP?=
 =?utf-8?B?ZndKd21NenZ2R0V6cVI1R0d5MVJGemJCY1pVdlVMYURSdnlUbGhpK3JQb2JS?=
 =?utf-8?B?VzdIZlNKdmd6U2tVYlBHQ2RmMTRYcG40UzBaRlJyaTRFTXdjcmczOFY3NkFZ?=
 =?utf-8?B?TTBSSjZKWnhZM2VpTndtWVNuUjRsRzNGeTVsdHJNRFEzRVVsK0M0UEVEZHlh?=
 =?utf-8?B?Vkw1UEFpak9RK3RvZHNrS1hBNVR0dkJrdDZrMis5WmJQRjBiMzZlZTFuK2E1?=
 =?utf-8?B?MTlZYVJEeDFmN2ZFZFRaZ2xkNmpzWlFwU1VsTGtEQk9tVzVjNlBUVnNXbnNU?=
 =?utf-8?B?QnhlbDhuMjZ2aExwNm5LdkVSVmgrVklmUzBXYlovbGcrZ3lPVWpXajZoSkNH?=
 =?utf-8?B?SDk2QUJvNXZuOHVBeDc2RjFFWlJaSDUyWnBSK3VyVDdYZSszbXN4VDJNZnFv?=
 =?utf-8?B?RS8wM0RNdllvaVo1ZDZqQzN6T2RjYWJQMnJJbnNMSjVSbWtHK3NGZEZrY0Jj?=
 =?utf-8?B?a3BjUXd6aHhFeHY1TUpDOEdGSlpRMEdtNUNYdHJqNFFtZWFRZTc1eUEwaDd6?=
 =?utf-8?B?THQ1d05yMW9YS0xXdzljOHpjRnltcGFWMFh1eGkxUW9PcVJnWVpRYjNmM2dU?=
 =?utf-8?B?RFFBako3NG10Q08xeHpIaE94QWlqVll0c0FlS3IyZFFUbmZ4SmRLU2hPNkRS?=
 =?utf-8?B?ejRJV0R2R3p0M3MyZEoxaGlkcHFDMnBHMVZaUllTbDdVTzM3KzY4WWYwand0?=
 =?utf-8?B?RFFvRXdKVkNLemJhTkRoWjh0dnc5dWhGQmRIU0VSdFZRbmh4bWd0T3g1djc1?=
 =?utf-8?B?Szk3WXlzMkhqd2Jsd3BNSGFaaHVZNVZUMXJ0dkFramJveCt0Z3AycGdleWxx?=
 =?utf-8?B?T1VXOHpkK2pLQzQxU2JSSHVkelh1c2dpdU44ejVHS0JmUDVXOFN1bnFIVW5Q?=
 =?utf-8?B?bTNjb0dnb2llWndDR2REandlWHFRYmJoU09QRkJaT2tON1d0SFppdCtLam9C?=
 =?utf-8?B?QWtTWUpCNUpFTUJBUVViWndXMHhVZ2ppTC9ZWEdLang1K2RHbUR2aEg1N1NC?=
 =?utf-8?B?Q3VjU01tL0hZdlhZdG1Wd3NEMHdPaDYxVnpNQ2d4N1Y2K0VDTmJZUERnb3Fq?=
 =?utf-8?Q?MUA6vIzQ12lnde/R2EXeiac2w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmx5bWhhQ0lnNmx1SFIyTVZkUm5pb1lTR3Y0bUhEcFRIVy9TOThmL3hkN3Iw?=
 =?utf-8?B?WVFsSEJaRm1jRUo0R2Q0RXB6M3MzVUVCREI0OXNhM0R1WTlUY3hZdjBpOHlB?=
 =?utf-8?B?ZW1xUGxBcHVhczV4Z2pEd0xJbmlXLzVqNDlOKzhITFZSaU5TVGRpa3NLMGVV?=
 =?utf-8?B?UzVaM0dtejZLUkpzU2kydk9qaDRXL0NEOHhKZ3VqMWZteUM5ZHExMW8zdUFD?=
 =?utf-8?B?cml3K01yNTNtbGlVTXl0NWVHbk9rc21ZY1NZL2xUVnUyTDIyUVdXVWRGcWZs?=
 =?utf-8?B?Vy9rbVVaeVBMZXRRYzQ3RExyam1OZkxDNGMvdFR1alZmMVowbjNEVW1ObjlV?=
 =?utf-8?B?NE9VQmFGYVJJaU1PT2MzT3FMS2kwZUNuSkF6MnFvOU56TG1Fb1R0UkhJZHBa?=
 =?utf-8?B?MjJCRkQ5c3hxM1B0c2YyeVhDZStrd2NQRVI0Y09QcDNXMldoWjZKUGlGOWpk?=
 =?utf-8?B?U29xRHVoRlgzZ00wQVJCYnNOam1ETGR4dGgxWlo3bDRJYUt0aE5OVjFJeDJ3?=
 =?utf-8?B?WSsrUnNqcnNyeXphdTFIK3JBWFRTRTMzSlFQcVlaNjhqNmxkQytSRlZsZ1Fu?=
 =?utf-8?B?Qk05V1NtekZCdnNjOHhUcWk4QmdBWFFJOUdBL0YyL2pCN0tlNGhaTjA5Nk1J?=
 =?utf-8?B?ajBRdVYxaHdaeld2UW9ITVkvRGJpWXhxbWt0WkRDRnFmb3E1bXRNbHg3cC9R?=
 =?utf-8?B?azVMeG13RDg5UVVxbzRXaFpJdFE2TWJsRm1UdHpZd21UOCtDZzFBWTBBeTho?=
 =?utf-8?B?cldEUURKVjVXSjczNmhCV1JxQnhnY2cvUmtXYWd0SGUzWHI0N1F3eWY4Y216?=
 =?utf-8?B?UXBnSEI2b3MraDRxMHZjU0MwcittK0VwM2JUSDhhcGhsVXZNcFFsUkZjUWxx?=
 =?utf-8?B?LzMwbFlSVFJlNWlZaTZuMWtSa2ZtaGM3THhlZlFWNVdhbnFLZmNMYThrdGFp?=
 =?utf-8?B?aTFkWm9LV0d6cGhvb2pBZmpIQm82bFM4TndLaW9RNGJTRFVIVHg2QS9nSlMw?=
 =?utf-8?B?NjhBemVNWFNKc3g1ODRDdmNpYXhOMkxhTTlJbGs2OWJCSksxOUthQVZkVzl1?=
 =?utf-8?B?bkpPS0g0NHdranRvU2tyOFk4NEkwWmRqTXFYZk9Ob2RSbXlldmIvZXJpbElN?=
 =?utf-8?B?SnVzT29PUWVYNE9DOW1ON0VxNndobmtXZ3VZeXZIWjh2Qjc5eHZ1NUl1a2ow?=
 =?utf-8?B?UnQxaGxXeU5FWkhDQzdiR3g2VnZWZXR4cDlBK3UrLzc0SUE5WGlPeXBoeUFC?=
 =?utf-8?B?VWlRQlUzU1lvQ2k3Rm9KdC9pTlNOZ0hBblBTUmRlTVNrOHdpMEw0T1FpcElY?=
 =?utf-8?B?bkpvSENvcHVpZ21IRFBQVlJzVy9wb1JRR2kzQXprbzhTeGxGUWh2ZkM0TlRF?=
 =?utf-8?B?SUV3bnlRNCtzTUlOU01DN2thZUZvc1dDYmFocXd1YmVIMTg3R1NjMno4eENj?=
 =?utf-8?B?dVJmY0UxWVljSVFMV2FvZEVKczY0SURkd05HTG5NMHJPSjNMTjJRM09USENn?=
 =?utf-8?B?b3ZpUHd4K1lhRyszcXpxcGg5VGFQSXZNZXRXa2ZZZ1B2eTI5T1N6YU55U0J2?=
 =?utf-8?B?ZFd5S2hBWTcwZWdPWlJsdVE0THgwb1VNWXVYbFVNNW01aGMvcXBReXhibmxL?=
 =?utf-8?B?QW5LSFl6WlEzVENjRVJPVHlPd2s0RlBUM2NEUk5ISVZsR2VMbVAxekk0QlU1?=
 =?utf-8?B?cTRDcjg5ZmsxSVlZWWFvWFd3VjJheXpIN2dmTEUvcDdxSUdHMGtzUE9xcVRK?=
 =?utf-8?B?ZGllT1YrNDN3NUR2bWlqN2d5MUMycGs5aE1oaWJRM1Jwb3I5d0diOFZKVk81?=
 =?utf-8?B?dUtoSXpOVjdnbFBtdHVGczlCVGR0ODhlVzZhcDVubS9sdWsxYkxhVzRmSkNE?=
 =?utf-8?B?cW5PU0FaQm5qMWwzeENRM3pUQWFnM1JoYVlETWZXWUFQS3JMdWdTNlo5MW4y?=
 =?utf-8?B?NlhYc3ZKM3FMSmlLcWNFYTVGV1hJYXNnUzdHdXhtcERYSGxFVjBiVm8rMk44?=
 =?utf-8?B?cXJiQWNGajlrMFNTSmJEb1JqdlBrNXFFazFJWG5BMFlJWlNldE5OSmoxT1Vh?=
 =?utf-8?B?THJQK2Fpa2h0RVhsZXE1WXB6R01zeEJsWXJ4d0dmUWVsMTlvM3ZhYzJObVkr?=
 =?utf-8?B?Zys3eXJzREdQMzJQUzRQM3BZL0o4S2xsZk5CMkhVTXQ4T25kWUk0NjYyNmta?=
 =?utf-8?B?cjAvNFU2S2U1K0QycGFnaHpyMDZVWnZMcVYyNDB4Q3VPVEtkbGd5VDlKaGlw?=
 =?utf-8?B?OEEvNU9xdDNON0hhSjlUeXFsc1dPSDlDZEI5eUxoazV2YkZSRk0xZHJ0N1pj?=
 =?utf-8?B?VGh6TmxoS2t1dk9IaUFhcjhFbEU1ZEJ5ZlBGMjF1QWcrbUJmWjBhdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1b8574-baa2-48bc-4428-08de6a97a134
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 00:34:21.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg1dXggfh15nA79lQk/AldB8dqslChoyEIDV6pEbfyrp+fpjnU6vn2DB+Oh4LbcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16799-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A720513215D
X-Rspamd-Action: no action

--WRm97GXGObhkaxx9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Fairly normal pull request. The NFS biovec work to push it down into
RDMA instead of indirecting through a scatterlist is pretty nice to
see, been talked about for a long time now.

There is a small conflict with v6.19:

@@@ -55,11 -54,6 +54,10 @@@ int mana_ib_create_cq(struct ib_cq *ibc
                                                          ibucontext);
                doorbell =3D mana_ucontext->doorbell;
        } else {
-               is_rnic_cq =3D true;
 +              if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
 +                      ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->=
cqe);
 +                      return -EINVAL;
 +              }
                buf_size =3D MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe *=
 COMP_ENTRY_SIZE));
                cq->cqe =3D buf_size / COMP_ENTRY_SIZE;
                err =3D mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ=
, &cq->queue);


https://lore.kernel.org/r/aW5bFiqwjxpet-Tj@sirena.org.uk

Thanks,
Jason

The following changes since commit fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b:

  types: move phys_vec definition to common header (2026-01-06 05:47:54 -07=
00)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to d6c58f4eb3d00a695f5a610ea780cad322ec714e:

  RDMA/mlx5: Implement DMABUF export ops (2026-02-08 23:50:41 -0500)

----------------------------------------------------------------
RDMA v7.0 merge window

Usual smallish cycle:

- Various code improvements in irdma, rtrs, qedr, ocrdma, irdma, rxe

- Small driver improvements and minor bug fixes to hns, mlx5, rxe, mana,
  mlx5, irdma

- Robusness improvements in completion processing for EFA

- New query_port_speed() verb to move past limited IBA defined speed steps

- Support for SG_GAPS in rts and many other small improvements

- Rare list corruption fix in iwcm

- Better support different page sizes in rxe

- Device memory support for mana

- Direct bio vec to kernel MR for use by NFS-RDMA

- QP rate limiting for bnxt_re

- Remote triggerable NULL pointer crash in siw

- DMA-buf exporter support for RDMA mmaps like doorbells

----------------------------------------------------------------
Carlos Bilbao (1):
      RDMA/irdma: Use kvzalloc for paged memory DMA address array

Chengchang Tang (3):
      RDMA/hns: Fix WQ_MEM_RECLAIM warning
      RDMA/hns: Notify ULP of remaining soft-WCs during reset
      RDMA/hns: Support drain SQ and RQ

Chiara Meiohas (1):
      RDMA/mlx5: Fix UMR hang in LAG error state unload

Chuck Lever (5):
      RDMA/core: add bio_vec based RDMA read/write API
      RDMA/core: use IOVA-based DMA mapping for bvec RDMA operations
      RDMA/core: add MR support for bvec-based RDMA operations
      RDMA/core: add rdma_rw_max_sge() helper for SQ sizing
      svcrdma: use bvec-based RDMA read/write API

Etienne AUJAMES (1):
      IB/cache: update gid cache on client reregister event

Grzegorz Prajsner (1):
      RDMA/rtrs-srv: Fix error print in process_info_req()

Honggang LI (1):
      RDMA/rtrs: server: remove dead code

Jack Wang (1):
      RDMA/rtrs-clt: Remove unused members in rtrs_clt_io_req

Jacob Moroni (5):
      RDMA/irdma: Remove redundant dma_wmb() before writel()
      RDMA/irdma: Remove fixed 1 ms delay during AH wait loop
      RDMA/iwcm: Fix workqueue list corruption by removing work_list
      RDMA/irdma: Add enum defs for reserved CQs/QPs
      RDMA/irdma: Use CQ ID for CEQE context

Jiapeng Chong (1):
      RDMA/irdma: Simplify bool conversion

Jiasheng Jiang (1):
      RDMA/rxe: Fix double free in rxe_srq_from_init

Junxian Huang (2):
      RDMA/hns: Return actual error code instead of fixed EINVAL
      RDMA/hns: Fix RoCEv1 failure due to DSCP

Kalesh AP (5):
      RDMA/bnxt_re: Add support for QP rate limiting
      RDMA/bnxt_re: Report packet pacing capabilities when querying device
      RDMA/bnxt_re: Report QP rate limit in debugfs
      RDMA/mlx5: Support rate limit only for Raw Packet QP
      IB/core: Extend rate limit support for RC QPs

Kim Zhu (4):
      RDMA/rtrs: Add error description to the logs
      RDMA/rtrs: Improve error logging for RDMA cm events
      RDMA/rtrs-srv: Rate-limit I/O path error logging
      RDMA/rtrs: Extend log message when a port fails

Konstantin Taranov (2):
      RDMA/mana_ib: Take CQ type from the device type
      RDMA/mana_ib: Add device=E2=80=91memory support

Leon Romanovsky (8):
      Support effective VF bandwidth query in LAG mode
      RDMA/umem: Remove redundant DMABUF ops check
      RDMA/mlx5: Avoid direct access to DMA device pointer
      RDMA/qedr: Remove unused defines
      RDMA/ocrdma: Remove unused OCRDMA_UVERBS definition
      types: reuse common phys_vec type instead of DMABUF open=E2=80=91code=
d variant
      MAINTAINERS: Drop RDMA files from Hyper-V section
      Merge tag 'common_phys_vec_via_vfio' into HEAD

Li Zhijian (3):
      RDMA/rxe: Remove unused page_offset member
      RDMA/rxe: Fix iova-to-va conversion for MR page sizes !=3D PAGE_SIZE
      RDMA/rxe: Fix race condition in QP timer handlers

Lianfa Weng (1):
      RDMA/hns: Introduce limit_bank mode with better performance

Maher Sanalla (1):
      RDMA/mlx5: Fix ucaps init error flow

Md Haris Iqbal (3):
      RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
      RDMA/rtrs-srv: Add check and closure for possible zombie paths
      RDMA/rtrs-clt: For conn rejection use actual err number

Or Har-Toov (7):
      IB/core: Add async event on device speed change
      IB/core: Add helper to convert port attributes to data rate
      IB/core: Refactor rate_show to use ib_port_attr_to_rate()
      IB/core: Add query_port_speed verb
      RDMA/mlx5: Raise async event on device speed change
      RDMA/mlx5: Implement query_port_speed callback
      IB/mlx5: Fix port speed query for representors

Parav Pandit (1):
      RDMA/core: Avoid exporting module local functions and remove not-used=
 ones

Roman Penyaev (1):
      RDMA/rtrs-srv: fix SG mapping

Yi Liu (2):
      RDMA/uverbs: Validate wqe_size before using it in ib_uverbs_post_send
      RDMA/uverbs: Add __GFP_NOWARN to ib_uverbs_unmarshall_recv() kmalloc

Yishai Hadas (3):
      RDMA/uverbs: Support external FD uobjects
      RDMA/uverbs: Add DMABUF object type and operations
      RDMA/mlx5: Implement DMABUF export ops

Yonatan Nachum (2):
      RDMA/efa: Check stored completion CTX command ID with received one
      RDMA/efa: Improve admin completion context state machine

YunJe Shin (2):
      RDMA/umad: Reject negative data_len in ib_umad_write
      RDMA/siw: Fix potential NULL pointer dereference in header processing

Zilin Guan (1):
      RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler

 MAINTAINERS                                        |   3 +-
 drivers/dma-buf/dma-buf-mapping.c                  |   6 +-
 drivers/infiniband/core/Makefile                   |   1 +
 drivers/infiniband/core/cache.c                    |   3 +-
 drivers/infiniband/core/device.c                   |  33 +-
 drivers/infiniband/core/ib_core_uverbs.c           |  24 +
 drivers/infiniband/core/iwcm.c                     |  56 +--
 drivers/infiniband/core/iwcm.h                     |   1 -
 drivers/infiniband/core/rdma_core.c                |  63 ++-
 drivers/infiniband/core/rdma_core.h                |   1 +
 drivers/infiniband/core/rw.c                       | 521 +++++++++++++++++=
++--
 drivers/infiniband/core/sysfs.c                    |  56 +--
 drivers/infiniband/core/umem_dmabuf.c              |   3 -
 drivers/infiniband/core/user_mad.c                 |   8 +-
 drivers/infiniband/core/uverbs.h                   |  21 +
 drivers/infiniband/core/uverbs_cmd.c               |   7 +-
 drivers/infiniband/core/uverbs_std_types_device.c  |  42 ++
 drivers/infiniband/core/uverbs_std_types_dmabuf.c  | 200 ++++++++
 drivers/infiniband/core/uverbs_uapi.c              |   1 +
 drivers/infiniband/core/verbs.c                    |  61 ++-
 drivers/infiniband/hw/bnxt_re/debugfs.c            |  14 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |  34 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c           |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h           |   3 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h          |   6 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c           |   5 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.h           |   2 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h           |  13 +-
 drivers/infiniband/hw/efa/efa_com.c                |  97 ++--
 drivers/infiniband/hw/hns/hns_roce_ah.c            |  23 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c            |  12 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |   6 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 220 ++++++++-
 drivers/infiniband/hw/hns/hns_roce_main.c          |   5 +
 drivers/infiniband/hw/hns/hns_roce_qp.c            |  49 +-
 drivers/infiniband/hw/hns/hns_roce_restrack.c      |   4 +-
 drivers/infiniband/hw/irdma/ctrl.c                 |  67 +--
 drivers/infiniband/hw/irdma/hw.c                   | 108 ++++-
 drivers/infiniband/hw/irdma/main.h                 |   2 +
 drivers/infiniband/hw/irdma/puda.c                 |  14 +
 drivers/infiniband/hw/irdma/type.h                 |  18 +-
 drivers/infiniband/hw/irdma/uk.c                   |   6 +-
 drivers/infiniband/hw/irdma/utils.c                |  11 +-
 drivers/infiniband/hw/irdma/verbs.c                |  21 +-
 drivers/infiniband/hw/mana/cq.c                    |   4 +-
 drivers/infiniband/hw/mana/device.c                |   7 +
 drivers/infiniband/hw/mana/mana_ib.h               |  12 +
 drivers/infiniband/hw/mana/mr.c                    | 130 +++++
 drivers/infiniband/hw/mlx5/main.c                  | 305 +++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   4 +
 drivers/infiniband/hw/mlx5/mr.c                    |  11 +-
 drivers/infiniband/hw/mlx5/qp.c                    |   5 +
 drivers/infiniband/hw/mlx5/std_types.c             |   4 +-
 drivers/infiniband/hw/ocrdma/ocrdma.h              |   2 -
 drivers/infiniband/hw/qedr/qedr.h                  |  20 -
 drivers/infiniband/sw/rxe/rxe_comp.c               |   3 +
 drivers/infiniband/sw/rxe/rxe_mr.c                 | 282 +++++++----
 drivers/infiniband/sw/rxe/rxe_odp.c                |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c                |   3 +
 drivers/infiniband/sw/rxe/rxe_srq.c                |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h              |  11 +-
 drivers/infiniband/sw/siw/siw_qp_rx.c              |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c       |   8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c             | 131 ++++--
 drivers/infiniband/ulp/rtrs/rtrs-clt.h             |   3 -
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c       |  12 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c             | 192 +++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h             |   1 +
 drivers/infiniband/ulp/rtrs/rtrs.c                 |   9 +-
 drivers/iommu/iommufd/io_pagetable.h               |   2 +-
 drivers/iommu/iommufd/iommufd_private.h            |   5 +-
 drivers/iommu/iommufd/pages.c                      |   4 +-
 drivers/iommu/iommufd/selftest.c                   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 215 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  11 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  39 ++
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |  14 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  24 +
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  74 +++
 drivers/vfio/pci/nvgrace-gpu/main.c                |   2 +-
 drivers/vfio/pci/vfio_pci_dmabuf.c                 |   8 +-
 include/linux/dma-buf-mapping.h                    |   2 +-
 include/linux/dma-buf.h                            |  10 -
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   9 +-
 include/linux/mlx5/vport.h                         |   6 +
 include/linux/vfio_pci_core.h                      |  13 +-
 include/net/mana/gdma.h                            |  47 +-
 include/rdma/ib_verbs.h                            |  70 ++-
 include/rdma/rw.h                                  |  22 +
 include/rdma/uverbs_types.h                        |   1 +
 include/uapi/rdma/bnxt_re-abi.h                    |  16 +
 include/uapi/rdma/ib_user_ioctl_cmds.h             |  16 +
 include/uapi/rdma/mana-abi.h                       |   3 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  | 155 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c           |   8 +-
 97 files changed, 3057 insertions(+), 755 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_std_types_dmabuf.c

--WRm97GXGObhkaxx9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRRRCHOFoQz/8F5bUaFwuHvBreFYQUCaY5xigAKCRCFwuHvBreF
YRDbAQDmwgMCDlpobZ6VKcl9S5vgvQbY61PladPkeR1vFxXAagD8D0z8cZWUdqgH
wWGdyCXaWiHwdR91FrlGDWQK+8OMigA=
=JUsY
-----END PGP SIGNATURE-----

--WRm97GXGObhkaxx9--

