Return-Path: <linux-rdma+bounces-17846-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLP+Dsa0r2kSbwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17846-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 07:05:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AA245B53
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 07:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E40D13011501
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 06:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE443126B2;
	Tue, 10 Mar 2026 06:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YvLIc5+z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5328641E;
	Tue, 10 Mar 2026 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122750; cv=fail; b=qqQiBxwMo6G5TERG9BG5uVK1OsSCCHS13T24iLWKnybsZU6iHi4MgwIjJCgix6tSmhnzrtyGoHJHDApuKtZRYEpfgVnjo4KWbmI8E+mk+CG56K3nar/Q+yCgc8QG+17mmIZyw7TqnpQa3ijEerR9yJ6H5BXJRoyWAMaaVl9rz/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122750; c=relaxed/simple;
	bh=o43tbJMWZecrYE1OPju5gI1U/4OamWbOCCxJ/iLKk2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MQ9En6DkBJZCh1CpSmS0+Aax/bvS+hARduWwPkDMOHq6rbZdbs44vNM6JxU48F82QGKt+hi1dxY7BCeO1fXUzIm7GRG5tIltAA5v9x2LHN1TH0H39HfZBPkwfj6+jUYYfZjLfx+F0lqQOBS0uA7qh2HLC018nYdniHD076vS9iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YvLIc5+z; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ7wN8WUnVNIwh0ObsQdi+3jMn4R0fRtKzjjjCiRQRWyOVBSCSSLOUU791S4BAHy059Zm0Xjgm+HxzWK8Ifc6EMPbg/qa2amXcvEyHUcydyal2oMYflN8RDp2RjyYoC4HS/LMWmo02Y0CiS6wLv0Km680uKvtjUpDVAIZHHiCAsuTJ9EWWeFlV75TX26DPDFkLi5S6v+zH3NP4mizsO6yDRzDE+1GxkRV12kKYG4x8CZX3E1jBwGQy6oHwNTBPMmpU4vbrEj9M6DyjOEzNPa1WQKfwtjM2Jq3Yiwf2wVtJuE/ubFpSUjipQKHMQ98fotLS491cO2IhyQ8s3eHYsklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5MO3cRwFmDjutRXavX8BOpVI+BGVOxgiE7AzNNFwak=;
 b=TLnMjUc0wmHKJaU3bCSK8Z2u3C77XPxdFFe5GBpKOeV6dKsqR4mGlAukQ1UXva81owlrjFTOkUjY+QdSU/dQuhkA8nOhJUxkOo7KJCzCYkhJnDJ7/7OFieif79s9yKq//MaZBtV6QaMxEBccRdu4ZKO4LpDhemJ8TVsuTSlrrWL9FpKuigXebjVeYfq7/9xZe5Njc9i/CQ89cJ93bmb3D/JnwmQ6hkZhdeXyY6wjWMMSpZZ202y4ALH7O+zeSTnw0PKuwc3795awLaQ91CSlF8HcsFtDYdpjIO/asSheIiU2ygBY7p9pwbd1ULfZRVzhl2al2TYVXO/wJsmLtS/wAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5MO3cRwFmDjutRXavX8BOpVI+BGVOxgiE7AzNNFwak=;
 b=YvLIc5+zwHLCd87ybBGjBZpc3/Gf7tk57u45gtIv4O2cXHYyFPG/ZHpczIjNwxfCd7XqzxwABFUSvBMOcFb/1PgxKVlBBuy3zmoi557PELPJf63AfDRmmWosK4jww/8CqkySkr7cvOMAHN5KEm/0dI9YIlsNd0f1d1GJwO0uROASH5S1btTlHc8uzQ3/9zsVXfNncp5005DV7bJiceDtfjZTpVXFL/8mZ2ASUESVGSdwOWgnR+mh5K60rMzaWgCx8NqNlEhJd0xCvfOghuEmspy6faiSf5DB3wtvg709gK/srZcj162sQbCh7YNCyqtQV9OAyT63DUG/ikph4CbDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 06:05:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 06:05:44 +0000
Message-ID: <020de4ef-17bc-43a3-83e0-469073ffa22b@nvidia.com>
Date: Tue, 10 Mar 2026 08:05:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mlx5-next 8/8] {net/RDMA}/mlx5: Add LAG demux table API
 and vport demux rules
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
 Alexei Lazar <alazar@nvidia.com>
References: <20260308065559.1837449-1-tariqt@nvidia.com>
 <20260308065559.1837449-9-tariqt@nvidia.com>
 <20260308085248.2427feed@kernel.org>
 <a10faf04-36c2-4070-ac8b-86b110e6976c@nvidia.com>
 <20260309143320.1cee163d@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260309143320.1cee163d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 532d5368-33a4-43a7-c8e3-08de7e6b10e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	llmY2RJzEOLwebEuIiOE8KXn3O/Tomxze0HGZ54bOktaohHnUZt08fB6vIaFssZAwJibDKC7iip6Uvf65XqVKijq4uq2psGtQ4329hRViBiaqhD9TtDkE0H0wNyJjV2kG7fd4H1VE6QeSroO5PBDRsxipia01F6EJYSPcywuNx6J6APBgNcthv7N6ffJ2paEQ7rhAx7R0B4DDNAL6GhMDjRH5LNdcM4LEuT9bBWyImVtlb9wwINtZHZQaOFp7VOIco26/Ad87PZanjU6Qr/0sYrx49qUYsK51NxxR06dtmo6DcQntHZ+XkLr8aArYPQDTvHXvJ0AsZEpmYqRrCuud2UHp3yugIpOkFnMeaBvV3kN2+I4n1u9+0HqoIakNfqGU/SvHcvItfda3WUXn4hH/N8dmB4HvgrCkivGeda8BhE02tNzwei15TDuVfCU30hexgWJ3l3SVGkyysOmV9TH1M4oykY6ML1hFT73/N+A+7EGKtziBr7wIuWiIkxx/q+moTjHDKqLhzvVpurW/I2QIcdhzilJJdHV4wSUErG5nBoi6JI04bKwhAPb6uoA0tc5vjDCuAil2NAx25Timo23yIym2Bea1L9wEPGUz+uI31IPtiDq5WoF/H0EZJggp1H0hPbDL62csF06FBXcO4/tx+jODby7/x4GGzsg5BMgs8FwbO3qf6uouuSfBxaCDudFWf7F5PF622uJ1xxjlpn1TflarqF1I8VvGfIzkNNbQak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alV0MWNsSml0ZDNFeHdVNDZyWDJUNXhNN1pJMDV1cUphK1NGY1AvOFJvZ3F1?=
 =?utf-8?B?UXRXb21vUUEyY0VLSVpWT2xMbkN3YVFtdXQ0ZlhXUEZORThIRlRjc0tKcEhp?=
 =?utf-8?B?WkErbkx2dUY0MU9hTlBzR05FK0pXbnFCaFpYZDZtcit4YlZPUzZGV0cxZXlV?=
 =?utf-8?B?K1BMVUVpZHhKS1BkbmFvWnZMMnZHL2IrKzgrVkdDTFE2SXJSWU9xUkFkQkYx?=
 =?utf-8?B?eHJaempFMjVsNG1aVWJ6T3F0cy8wajduZDFuMGQ4US9uUU40dDdKWVBpbTQy?=
 =?utf-8?B?RFNCZU0vS1o4c205UEhiWTJjOGtmTFZMWHRTbDIyakZFZUFGbHc2Y3Nueit2?=
 =?utf-8?B?djVlZ1p6bDJaaWtJaEpUd2ZpaFZrajdHUzkwZGgwL3p6MlpiR1NBSWY1TTdt?=
 =?utf-8?B?Qm1XdkFCdnpHWHd6Q25WM1FVeGdwVjMyVGI2TVFsYWxrMFgyNTBaNW1KMlli?=
 =?utf-8?B?UWthU3phQ013dFQ2WEVDLzRTVUJvVWhJSUtHSHAxeldROUZlcWh1ZnVZQU5B?=
 =?utf-8?B?VHZhMW1uRCtIOC9PK2t6amR0SUtZeUZLUUxvdnhERlNXU3NtVWp0cGlLYUxt?=
 =?utf-8?B?Q0ZGQ1paZmlRRVdXZ1dXTUppOHkxTE1GclJLelBuc2luaTM0Nm1TM0ZsaHRI?=
 =?utf-8?B?TWg2L0tmWVhoN0NRSlpWYkJrdkZwTlRiVE1LUGJXRTVwYi9IMm8ydGUxQ2xC?=
 =?utf-8?B?b3BqWkhRakNTS1BSaXBmOXFnV0grSjIzb3NIaGw2RmNrVHA3ckR5dmE1RDAx?=
 =?utf-8?B?eXlBK3lpTzRMVEsxMXRqMm5IcE92Wng1NHNOaU53c0ZydGU1aW04RnRxeUI2?=
 =?utf-8?B?ZFVMSXZDQjMwNGR3cjdaUFJrUHVxWEw3dFd4bDRLZFRIVmtPdlZCVERXT3pa?=
 =?utf-8?B?by9NTEZDcnVpeFFqYjBWdDRUaVY4VGFxTTdtT0w5RVpTQlRJc0hBL1ZqdUpN?=
 =?utf-8?B?Y0JyYzQyMWxuUjNIelYrZ3h0YjM3b1hiSXZHZmdrOThwSHNzZCtieG81cms3?=
 =?utf-8?B?NTh0eFBkR3IxZk51RjludmM1WUNzbnlQc0F1S1Fyd2I2UlkyaDVQQTJpK2Np?=
 =?utf-8?B?NXVwcXR2bjR2WncrT3U5RUU5dUdZa3daQ09JWXBvdXNQYTVCRWZ2MXFxL0lp?=
 =?utf-8?B?bFRQYisvVlVmNFM5TkU2d2J5a2lRVDhQWkMranNvK085b0RTUDRiOC9xYUFy?=
 =?utf-8?B?aXFRU3J1bngzNitnTUsyQlJxYmpDcFNWZ0Y3RkNRZ2FhNm5DSEluVjJnWTBx?=
 =?utf-8?B?a0NnbUpFL0EvNXR1ZytzcytvclNoQ1Q3Tk9VaDFSSFV2ZDJ6eGtmL2hvcWRX?=
 =?utf-8?B?TjNPYTB5SXdUYWkwSVdleDhVUTZqYmFkbkc3OFRDcUFITk1Od1FWNGxXQTlv?=
 =?utf-8?B?U241aUZ1cXBSOFE5ckxzR0t2RWZKRmNwV24yWGl5YmVTTDJQNXQzTG40MVFk?=
 =?utf-8?B?SXJzaEpRbDQ4WGprZWpLc3FVVENjN3hRVU8yVld1UGhtTTUxaVROUzBDNkQ3?=
 =?utf-8?B?QXZ2SVQ2MVZrdTIyaUxIQkJHYVd4SUdOTnZPQXNSbzNINjNpVWpDUUY5Q1Nn?=
 =?utf-8?B?VW9Wb1l5TWFwclZCSm5LbEZybXpHaUdQN085K1JUdHdBSW9rR090QzBXN3hZ?=
 =?utf-8?B?dXRneUVaYTVScXZ5ZXJUM3JZN1pybTlRMDZuRVhwci9NaFM2Z3hZb25Hc0F2?=
 =?utf-8?B?QUtsNjk0S21LeVVxblpCank3SVNGUjNhckJkRGhtRVNNVXEvSzFrUUhsaGw0?=
 =?utf-8?B?ZTZqeUxFTVRGV3NlWjM4TkZocHRqL25ZVjl0bGtkTHNvaFBQS1QwNGZzNTZH?=
 =?utf-8?B?WWZkOTZLb0IvZWhwWC9PQWliTysvRE44dWg0cjhpTndRbEtZVDRUMjdDMkdQ?=
 =?utf-8?B?eUZkQ3lYZmZqQnA4TUZVQ001Tm04TC9rTGRLVG5PUWd6NjQ2OXZpb1B3TkFC?=
 =?utf-8?B?TTdtNWVyeGVDazFnTTRwR3NsR281L1B2dDhuUlFJRDdYUVZSSkJlMFc5ZEgw?=
 =?utf-8?B?QVJFNXpJR2ZFRjNXVkVSWGp4THBCSzZCNkgyUjhJbEVUNGhGMnhMa2RhTmd3?=
 =?utf-8?B?Q2h1OUl3ZmNKVXhBdllzK29oRUV6M3E2MEhNeFJVaUd2aDB4MlBGT2R4WTVZ?=
 =?utf-8?B?RWpYRWNpL1ZLekNMTjZFMWVmYVhFQlVSMkpxR0VUcUltc09tZmVaaXNWVmdF?=
 =?utf-8?B?bmJhUG4veTZpM3RJSHNJRkFodmVQc1RrSHNKbjBaQkd4MC9RbTBZS00wUGF6?=
 =?utf-8?B?WjIzOEl2ZlhXT3NxTkgvQUVoeDhlb1d5dDJjRUU0Y1hnYmJwckROTHptVHR6?=
 =?utf-8?B?WjFqSHExSWtYRUs3a2dUNWpZWk9XUTdMbzlTMWo2S0hIQTlZVUc4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532d5368-33a4-43a7-c8e3-08de7e6b10e2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 06:05:44.5142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyx47aUbDZn8TuKw8VZNN9eE7fPwvna4ZUGpHg1aNljbkLngkDg/F5SkpwiZNyOhw/v8pqDKtrPA3vcfTb/4JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837
X-Rspamd-Queue-Id: 415AA245B53
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-17846-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Action: no action



On 09/03/2026 23:33, Jakub Kicinski wrote:
> On Sun, 8 Mar 2026 20:34:26 +0200 Mark Bloch wrote:
>> Thanks for catching this. We’ll address it.
>>
>> Also, I saw IA flagged issues con
>> “net/mlx5: LAG, replace pf array with xarray”.
>> Just for context, lag_lock is already a known problematic
>> area for us, and we do have plans to remove it. I ran the
>> review prompts locally in ORC mode, so I assume I saw the
>> same comments as NIPA.
>>
>> So the issue raised there is not really a new one. lag_lock
>> already has some known issues today, but we do not expect to
>> hit this particular case in practice, since by the time
>> execution reaches mdev removal, the LAG should already have
>> been destroyed and the netdevs already removed for the driver
>> internal structures.
> 
> Ack, I haven't looked at the AI reivew TBH.
> As usual with known AI flags - should the explanation be part 
> of the commit message?

That's an interesting question.
I'll try to give my 0.02$ about the general case.
Out of curiosity I ran one of our upcoming internal series
through both Mason's prompts with Claude and our internal
AI review tool.

Mason's + Claude reported 3 false positives.

Our internal AI tool also reported 3 false positives (interestingly,
they were different issues) and 1 real issue, which I already knew
about since the author hasn't fixed it yet.

So in theory we could add a note like “AI tools may flag issues
X/Y/Z but those are not valid here”, but in practice it really
depends on which tool is used and how it's configured.

At the moment it seems that netdev/NIPA is using Mason's prompts
with Claude, so if anything that would probably be the default
reference.

The larger question is that running NIPA before submission is
not currently required. Are there any plans to make that part
of the submission expectations, and not just encouraged?

Mark





