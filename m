Return-Path: <linux-rdma+bounces-20483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJlpJycMA2pK0AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:16:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B92851F338
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 059793096751
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035483B27DB;
	Tue, 12 May 2026 11:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mk4VptlY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969338E8BC;
	Tue, 12 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584340; cv=fail; b=Nyk/53vuWIxgREU8bv4fG3seztGfyCm7R4Uc7hTfMo2WguUQwOWKPRw20zcG0OtaivDByv7SPrIHGFaJnFueQEqe02+Mwx06tm5c3anW7VRyhT+3dNh3aarA/PVWKvdUDNIN5ndKDoOxJzs9fpyVBi4QRQwfzXKF/FKompESREo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584340; c=relaxed/simple;
	bh=CL3ZdRqXsevZE1uluZLBE6M//QpTpfDz0tIpn9Lc1r0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jGpE59W9h2cUxsWiI6ufvM24IOC1OZySmyQNtvFMv+sBtkpn/SeZjRghBd7eokEJ2uP3x8rwhCU7NGaejAA7asTmQ0dHtTJCv9Sis87F2XnpW+yluVa25PzEUiHWXvwEgRdQSo/6AqjvHCORP+jlMs3HDBrKTDR0D5TcXdBf4wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mk4VptlY; arc=fail smtp.client-ip=52.101.57.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5PqqYBhgZ5t2mhZVoheaH1xJlG5NHEw6i3A8kUH6oIlNDlo3aPsXlzz/kiapO+dkUeyrSCLhvDhc9hW0teSdj/AOnTwrwj5qx5gnBLwi/L9KXyc93srZj75Wz5gofsv07tFvbIxes0xRn5HcYXHaHZXw0+QJmGRJMO0oQRyJRkRKGtrZTqyAOvSGFIt9/4guGuI96RJHOG/tTAJlauP6NmNWO2zNqvqH01wcZ8hS4U9bOk+3b4wK2Z4yo9lN7YHte4QYb4qtvO0ARYFQl4xMXlWwAk1NuRNIt5Vo+Ge8he3p+ntXizRBNYllz7Ur6jhjZvdIxvlQfmazzd8epf+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpjVIznPNUYZt5xKCkX2o9qFSDh1dwe46wSuc2oOsSU=;
 b=bM4ET5qBDCQ1rKsA1fS136B+a3Qfk8JvUjiaa3TzIiq9GlMHkuHx/4J/gkX5iznLBgv0ra3Z06YJwEBrot+Lh8DwPN5/LmmvG2gb2+IX8j25KeONy0q/4E6wq4mQ+9dYtjytnlkd6aX4ublp4NVdQxuC/Lal9QxBup9WXB0TAND8gcOVGfVB/ZcTaN1Z+FojarvDi91Lf/szY+I4AcuXcY01Mo4hoelt7ZJyJq/EvtASLXRyvZUBV8wRm7XPBDibtAmVksK4ITEb4PyFVSHDqhJ1eukygvffF3WRp6aLms4Ckd4N0LbwkS1cmsEZg5QwTiM56uSx9GSOdQ18jAeHmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpjVIznPNUYZt5xKCkX2o9qFSDh1dwe46wSuc2oOsSU=;
 b=Mk4VptlYAQXDLL5W5oatpYfAz2PywpoHlgfSAwyOVhCJEcaAo3i5BCoxPDMcEtyN61LDl8c4RnoZNexxtOdU0OeWUefrUcN57Ato5iQ4891dgvd1gokjz7XCGajc9WOT7kwgRtvVwXB05pw8OhBAgtg6rdIr7VBykAStFQ4KMgV/GUwXXcP4ikgXpiMCzjDDD7BlrrGQFLC7/lR8LH3CGp8W8rrJadhT4AeVRo055k9uR3fAn0P6tx0+k5iwXqm2w19YTqi4K7HLOgWe63VPPlDXxsYU81dWfDoFR54SwXHS54gUw8O2/B9u14HxHkwxPgnV4cXKSeTc8dklA9DsBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 11:12:14 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::16e2:19ba:8915:90be%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 11:12:14 +0000
Message-ID: <13777535-96d1-4748-b805-14406e10a058@nvidia.com>
Date: Tue, 12 May 2026 14:12:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix use-after-free in
 mlx5e_tx_reporter_timeout_recover
To: Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 "matt@readmodwrite.com" <matt@readmodwrite.com>,
 "leon@kernel.org" <leon@kernel.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "mfleming@cloudflare.com" <mfleming@cloudflare.com>
References: <20260408184458.1274662-1-matt@readmodwrite.com>
 <00ce6b5b1081bea03195a39c525b9230e3524256.camel@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <00ce6b5b1081bea03195a39c525b9230e3524256.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 579388ca-1112-40c1-619d-08deb01751dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	yfs0tZEQkfGfCu8zDLpuAKNzmr7aOUPK8MlbllaEypcute4z5Df/Fq0d/pg2t2MlexIpN53T4x2K9C9fd4zHLyK++rl1dXdbTJwQshmJ/d+KBxVPXMoB8V4TOESPm/TwQ2KzBZ4NEgLP9tEOmwuiofwTCxMXNaARhocpXjB5yjdZd5s1e1yhat/mxPgxEtP/k4exOV6OXVG8wb5PXj4GP4dgm3L3CyHcnH+Udli+0xztg6w1Lky8llgJMWkN3M54oH2Pt+tqEUr78ge2IPAkR2SnsyRUS8avZrMcrrj8uDpP2OxlCoFIb/c1B4EBN/7xncdJ93AORNqciDUS0dpMd6jaq6VVD5Ld2e1T0hHOb/qBZMm09aMkfII8LX97fOkJhF5pUF1lbP3aDb7WVTfipxFhQFc6L+9cck7MX5/oczOre6j9+TPQLruC+nu+mOWtZFTLursY2q60nJ5jfJxMm42iTzMq2UPMBj8/FuQu1ctsTgmI+LpR4TzkUU2KMfpFdsn3lwa6pvUneC4qoPxQQ0cx5jW0fMKQk50PGa8/Rhph+9umvV9mKB22rI3ish8Cx2Q9EsLZaD6ktZHv5SMbPPYbUWXgkklOPEgPdEpUUV/J+IqpdNK1OIye3TSvh9H6Z0oHJjt3d+Yrb/rgeAAC+PLAjv/CANtBONTpk/Q5ONUxiGLfN9v0eDY5qa4/z3V1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2c0eGQvc3c5Mm05blc5ZFNINThKWnR4Z3BiemNJNXZZZ1VyVTNObnhpR3dX?=
 =?utf-8?B?THdoVm9ka3M1SzJ4K2g2bEVzS3pFRjJoU3JYUG1wS2o5RjRHVW5RbmF6UnRt?=
 =?utf-8?B?LytRb2VwRi9DTW1RYytQVDBwUUZHaWJuRG00QzhjUlJxaVRaelg2aVJ5Mkdr?=
 =?utf-8?B?V1lGeG1zQmovaEE0ZkhSbVdiZzNSWkhLQ0JhNzRYdzF6ejBxRkp0OG5VT1Ri?=
 =?utf-8?B?M2Jlbmh0c3cvdFp6TmRiZ1B4eGF2LzJUYU9OT2dMVmZLcVZtaU5QNEl1V3NQ?=
 =?utf-8?B?Q2FrWHQxUlFCMnBzQ0VhRmlXYWRSOE9ZSk5Ham42MEZvZkhpb05FbEx4SlFa?=
 =?utf-8?B?R0cxWFNjbi9pNHFTWVhFYWJzelRGWEpSdDRYNTRDdVBZV3JCazRMUEpvclRx?=
 =?utf-8?B?UkJ2ZmdZSWp2eFBlZDJsZDJIakl3bDdxN1JFVEZFUmw4S1lKVDRWWUFhUE41?=
 =?utf-8?B?OHFPYXVsTVVQM3ZsN1lselNObTRsdko0Si9tNW9od0lqeWg4NWZFWTF5aW9j?=
 =?utf-8?B?VXo0Z1VlRlhGR2tkUGpONzZjZXE2OEdWcnc0ckhYRVdYSTY2WExtT2o1ZVhn?=
 =?utf-8?B?WnJxdUtvMzJYSi9FQ1ZOR09WNEN5Z1dLOFFaY3lhdCs1YnRaQ1JkSGg2T3Fi?=
 =?utf-8?B?R1BRc0Z6RVQxMkorVHgzSWJEVVprS0JIeENhQmMySXFQM2xSa3RQMkZHRTJW?=
 =?utf-8?B?WWdNTU1HVnc0bkllbUZsS0tnd3F5ZU9JLzV2SkhGUXZUMjhITWdEMzBjc1ZC?=
 =?utf-8?B?NnV4TER5a1RkODJ4T295WnBKMUFidkI2d3A2clNPaWQ1d2VwSmxWbUc3WjNG?=
 =?utf-8?B?UFlhUGVIOEd5RWQ2VnBtR3RLK3lpYmZobWprOGp3eGdOUkgrcVB1V2xOZjIz?=
 =?utf-8?B?WjI5c3ZCMFIzQUpVM0R0cDdYSW5jT01acFdoc1M4VGFnOUFXOTdZeUczSXJw?=
 =?utf-8?B?TlNwanNmT0tHZnBYNUl4b2VUWFhPbTdjcGNkd2swMHZDMm9BT3k0UnA3Q2ZL?=
 =?utf-8?B?RW1GU2ExWlBDZUpIbmlBcU0wUE1aMjdjcEpUVXBzdGVrQk5CMEtEUGtVNDdh?=
 =?utf-8?B?M2thK0U0Z2ZxQzBWUi95bEdISlU2K2pwOTlQVm0ySVltbEtLZGp4SEZSYmhS?=
 =?utf-8?B?NVlrMmJTWWkzSnAydTM5L0NQRHFhWEE4eXJUaFFFT0NheEc3SllxZExVc0VG?=
 =?utf-8?B?WjU5YnZzZ1hES2poYXdQdlJpT00rbjk3azFzZHJ1Z09SbUUvSUlZMTJXZTM5?=
 =?utf-8?B?bGM4SWV5bEJaM2pYWlQ0TkVhRFR2ZGJqWWtDbThwaVB4M0NxN3diS3MvbVFG?=
 =?utf-8?B?U2dMUnB4RVd2MTVCU0crR3ZFVElBdUNYL21yNWUrdGhweVZiSlJEazZ4ZkhS?=
 =?utf-8?B?OGpZN0RXY3NnRy8zajgzdUF3REc4ekVWSG9Xa3JpWXdyZ1dRVThXenEvNTFs?=
 =?utf-8?B?aWYrNnE5Zk5lNTRBU1J3eDhNWVdDMkV5UzZXT1gxcWthWFNVVkljZFpTSG9H?=
 =?utf-8?B?ZEVjNnhsTm9oczI5RWluWm1MR1FIbXcySFAxcnZEbU5tS01RV3dPT2RRTWV0?=
 =?utf-8?B?eXcyMXNPeGJiZ2Fyc3RqbUdEM2lQUWVaVXY4ejUveFptTm9LSDJGaWpkc1RY?=
 =?utf-8?B?N0RyUW1DTTMvNHJiN0NMMW16WndiQm1wYmNmRU9USDA5RmhNSFVoaCthN3dY?=
 =?utf-8?B?aDhiZmxmeWJFSGwvOEZDblVaQkM2RStEejhzYk5ubUJzUE52elVWam9pdDM1?=
 =?utf-8?B?bCtwakdpK0Q3YXMyZGRzejBlYkE0OW5WL1VjbHVuL2ZLbTN5a3FLYlhZdmhN?=
 =?utf-8?B?enlEQjl2bEN0QWNIL2MzN1VHWERiVStxN0VmSzVwSkY3Z2I3U05OT2JvVkZ0?=
 =?utf-8?B?M1R2ak45N1RDUy9mSWI0VVRDWnhLOTlsZ3QyNm9QZERGeFA5clM0TFZqRHVC?=
 =?utf-8?B?N1c0clB0ZWRGaDVuUUpMbWFVd3M1WnN5b3BGd0lTblVKcjNRVGhhTmV4Z0Z4?=
 =?utf-8?B?SDhHL1lZZlh4QTZQZXpES1pnTUZoWDJzUjVyZlZiL3RWSmtpWURodVpPM1d0?=
 =?utf-8?B?ZTJleTdpQ0c3OGFNTTVCN0NZd0RMWThoM3JuUU5pL3VXb2dPOU51TGxGRUoz?=
 =?utf-8?B?ckJkckQvOE5NMExVRVVRTkU1MllqcllzVHZydUUrclo4V09XTXpudlVIdWg5?=
 =?utf-8?B?V2hNUkZrV2hRazVURklJdW5aNjhkL3dMMkZVZkZmUitycmNDMGk2ZGJsK3M4?=
 =?utf-8?B?NzU2aXBzUFprM2V1bzZyVEtYeWh5a1MvaGRoK1JsTHdsNDMycEVXOGs2TkQw?=
 =?utf-8?B?VW9CZFVsOEhxZU5FY2ZLNVd0K3plK1lYbkpaajNKK3ZNMzlORi9WUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579388ca-1112-40c1-619d-08deb01751dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 11:12:13.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZjOteoSwH6hE0ZNicT01xyRdQAX557Ov5oPXEWnvNkPSOONY5upQ1Aucxc/THFQ5b9Lenlhz1vspAOBhsBafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
X-Rspamd-Queue-Id: 3B92851F338
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20483-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action



On 12/05/2026 14:08, Cosmin Ratiu wrote:
> On Wed, 2026-04-08 at 19:44 +0100, Matt Fleming wrote:
>> From: Matt Fleming <mfleming@cloudflare.com>
> 
> First of all, apologies for the delay, I missed this and it seems
> nobody else reacted for more than a month.
> 
> Next time, you will probably get more immediate reactions if you
> directly CC the people involved in the patch which introduced the bug.
> This will also make the patchwork checkers happier.
> 
>>
>> mlx5e_tx_reporter_timeout_recover() accesses sq->netdev after
>> mlx5e_safe_reopen_channels() has torn down and freed the channel (and
>> its embedded SQs). Replace the three sq->netdev references with
>> priv->netdev which is safe because priv outlives channel teardown.
>>
>> The netdev_err() call already used priv->netdev for this reason; make
>> the trylock/unlock and health_channel_eq_recover calls consistent.
>>
>> This fixes the following KASAN splat:
>>
>>    BUG: KASAN: use-after-free in
>> mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
>>    Read of size 8 at addr ffff889860ed0b28 by task kworker/u113:2/5277
>>
>>    Call Trace:
>>     mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
>>     devlink_health_reporter_recover+0xa2/0x150
>>     devlink_health_report+0x254/0x7c0
>>     mlx5e_reporter_tx_timeout+0x297/0x380 [mlx5_core]
>>     mlx5e_tx_timeout_work+0x109/0x170 [mlx5_core]
>>     process_one_work+0x677/0xf20
>>     worker_thread+0x51f/0xd90
>>     kthread+0x3a5/0x810
>>     ret_from_fork+0x208/0x400
>>     ret_from_fork_asm+0x1a/0x30
>>
>> Fixes: 83ac0304a2d7 ("net/mlx5e: Fix deadlocks between devlink and
>> netdev instance locks")
>> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>> index afdeb1b3d425..8409ae73768f 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
>> @@ -160,13 +160,13 @@ static int
>> mlx5e_tx_reporter_timeout_recover(void *ctx)
>>   	 * channels are being closed for other reason and this work
>> is not
>>   	 * relevant anymore.
>>   	 */
>> -	while (!netdev_trylock(sq->netdev)) {
>> +	while (!netdev_trylock(priv->netdev)) {
>>   		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv-
>>> state))
>>   			return 0;
>>   		msleep(20);
>>   	}
>>   
>> -	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq-
>>> cq.ch_stats);
>> +	err = mlx5e_health_channel_eq_recover(priv->netdev, eq, sq-
>>> cq.ch_stats);
>>   	if (!err) {
>>   		to_ctx->status = 0; /* this sq recovered */
>>   		goto out;
>> @@ -186,7 +186,7 @@ static int mlx5e_tx_reporter_timeout_recover(void
>> *ctx)
>>   		   "mlx5e_safe_reopen_channels failed recovering
>> from a tx_timeout, err(%d).\n",
>>   		   err);
>>   out:
>> -	netdev_unlock(sq->netdev);
>> +	netdev_unlock(priv->netdev);
>>   	return err;
>>   }
>>   
> 
> Thank you for the fix, it is a real problem which can happen if direct
> SQ recovery fails and all channels need to be reopened, which is
> apparently what happened in your KASAN report.
> 
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Thanks for your patch.
I think that due to our delayed response you'll have to resend.

You can add our tags:
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


