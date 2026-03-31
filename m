Return-Path: <linux-rdma+bounces-18816-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMhyKC4Py2msDQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18816-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:02:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8C8362885
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 02:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FBF3043D28
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4E17B505;
	Tue, 31 Mar 2026 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A3Fu1OtC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724428FC;
	Tue, 31 Mar 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915325; cv=fail; b=nTH5nVpawHfQiUMNgLm44uoQRSr/BJAJArdW+L4iAhdf20qifsW/l6Onr0e/2iixF3pI0nnrI/wvm9066t/yyvTmUstLlznSnUxtnGGFaRQrlRJaxURvtXn8isVFiNRBoBIR8PA6DAd//R29jv3FwnAuKvHRMXBNBYZHmXWkF7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915325; c=relaxed/simple;
	bh=ds8jGvX2OO1nWVWyBZt4sNeE2i0m1WcmkJ8fqiUOb6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XNXFaXz9916UYNfh5xKG6ccZ2MP6coMXh5d+K+PdqXvNgsq4fyeydu1WGpPogC7Ma3dTqdzItkLhcuHeVVvZ83N/XohvjNuUA//fljeiphd7IVAvI/qnGUVHgn7XQJTHOsfbzJIttr3xv5PW+tDRCNjO137Zmm5tiPhWsA80V0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A3Fu1OtC; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPZHF1tKEsHk1HBsUG+588P0SImL2POWav2U2OnM/3CSd7srlzckUeM61d7OvB24lxbBurX14rZWzChmXztAivXSIZoPcB5MY3LJH0MQ6OPTQuzUHvNga0eH0V2nCeqPhCZpfmTBDQLhSrMVqEaNESDYnLQPcbXZUQ4h085VJj+GpES4rUgJeH3nf2tSsBCdp9Ub28MQ1wqqK7i2qkg3NhX69+E3L3HD10HHSWA+nCXVsvRHt5JIgUorrrwncQ681GAbehOPU7Mj6DjeMsxZr7wy0jnPwXNt48nFZuMv8f/XZPjp8Oe8XvjK35EbjuymCykQ+k49q2BTO2LLboNrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7jefVcNO14YFQzapvvzUxWNSlvLLcgEYuCpOmcrv18=;
 b=jRNy+pIRcME9RgrkW/YaUZXFgjYPSxMOooR4O+halKRynVctuLEKftd6vu17zkKnd4JXGWZNvWwBFW1il6vLH75fua4s70cInfwA0gef19kqxbQZ1PEvuxuv7cv3U43748w5r1X46CYEyl6EtsKJDnjI8fNttgvJ7Lb5SE/UJ9gNSYDS/Mj25vIiUz/Yj78nM/jfjE+Kjz5qGxyo/wcq8floaSjCBprWv2Iqq08A90Bf05LOpdsIWj9NF+SKbkt/YImcrYRavU0qp+M/R9Q082MuBwZOXBJIukvMcUbaZlM51ME4qitEASeZYsz/9cpcuVVKBW3Qwi5gBdR/gvIWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7jefVcNO14YFQzapvvzUxWNSlvLLcgEYuCpOmcrv18=;
 b=A3Fu1OtCpGZiyH9rsCKdqon3AaHqwWV5rCQ0nRmjfVCakzSifAVNqzYrp/7E2D4guv8gDCmPwASr/4g/dEecTJFFx1YzRo90pzYz+u/AvJpQoTBKMLChD6oF5+uzebFeX1ErL1Ms/3rT7jA9vZY7Su9mMXXtn5cgo7mVHMj9fKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 00:01:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 00:01:59 +0000
Message-ID: <2ab40ebb-6ce6-490f-a22b-6b2ee873c085@amd.com>
Date: Mon, 30 Mar 2026 20:01:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
To: Bjorn Helgaas <helgaas@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michal Kalderon <mkalderon@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alexander Schmidt
 <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260330214253.GA92498@bhelgaas>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260330214253.GA92498@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2bb523-c2d7-404e-02e3-08de8eb8baf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1AxeTpa3t+7+gwF4n7YHqtfPSNJvjE5uZbn4ygx2W0aWxTcG0nZz6hSlXIbpc/iv3kZc0DwygaUZoksxyDhpzi/oGrpuok5GScYjmPgMG8ldImhVJYGnsR0SlMuZNhHFDh4ek/0nv5pRhghO2uBldI4OAg9fdXOKTpKzgpxlKaIlmIomcvAwFFxv72sf1BXKpe3b1+9jimyKe9Qyz7uy3oB/pqftzsB94L7i9CWplsV16WHdv+KwynpKQQWW/QF2Ufo2n6Xn1Ji/fezPZn62c/vxRRrvlWLlbR23feNp1VWDLB/c8L1JfM01TdOW5UxWS5IN+sG0fJgGkRPUIzlpj/7voavBQCWCN4+ORYNI/YknCNaqggzX6sz5mYcQ6zuOtwrbiaq6VvbFaSSZqJkzktb4r44CAKhAFNQU1ynkvoUDboi0GOY7SEeGIgnLUpUZI93yjKE2l4zTby8zjx4PA/jCyENtMfTN2PXk0x5dLBh8++2oLBDbpgzSnPpJPOFdK3Pb1NenLcwBIaH6C8S99QvRmfZOk0rMRLwp/HW68r1vOQPhAT5bS3OGmhaAHDQ4BayV7QzUfrjXTXAdLKPizTPeGlwCtatSFFEGlA7/mq+pJkQGmdjKu/eL9yB4sRbVP2PGvuXt0Nig8e5R3swD/L8L8/5FZxFCyJ+W6iHQfhv4dkZ3aukg+/44gTVZwudmnjo4/9S39/R8e9LSEdex714vzAadEtYgI4HKa3ATeHu9B02YIm48ooCxDAodozD1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFdtbloyeVhrRjRWekdqVjhBV05XODhpVy8yVExVbXIzRWhxdERHZU9VVTN4?=
 =?utf-8?B?VGg0Ym1BRjhwT2doVGVnRWUzVTJ2VjI4LzdhaWhiSFhPaWhuVzltTXBITWFz?=
 =?utf-8?B?dzhRQlFvQWJCSjQwT2xVM1hrTHNEQ0EwMnYwNWV4UWxxajNMSVNzZVV2T3dD?=
 =?utf-8?B?UStlbC9LNWdFMk5QY3h6eUVBQk96TmhiTkhyRjhmdTZuN3UrTEtQZG0yQzJF?=
 =?utf-8?B?R3E3REF0RElYejFIV01maWlDOXNDMCtLN3NrUkNEQkhiNG1KMHBoZXdDMm1I?=
 =?utf-8?B?QTdmdUZOQ0dGRlJRVG5GM3RlUU5UYTJpZVREcTdJTm9Cay9heHJFWm4zVmtF?=
 =?utf-8?B?SmdocmRJbmtFK2FFMkxKZ2pMN0wyQkFmbC9uaEJDb1JEeWF1Tkt0WFBZdW5E?=
 =?utf-8?B?T0hHZWNjL3NiaE5zYXpYNzdqKzFDTEtLTkpEbkk2UVFoOWwzQzlGdm1ZU2lB?=
 =?utf-8?B?SUJTeDNJQ1pTVnRqZkt4MkR5R1pUNVBuUkdKTUpFVlltYUpmcnl2cmRFSlhG?=
 =?utf-8?B?WW9TSjhGdENUc3N3KzE0S1hGYm1Fd2dmTjRpSXg2UlN0RzEyaHdEQ1lLM2F2?=
 =?utf-8?B?TUJuQTMxNFlyQ29weE1lN3N2eEFhdmRadzc0N0FaUzVoZ0ptNVlOdkQxNnFV?=
 =?utf-8?B?bWE2UzBMMi90KzZSc3JZcklXb3ZGeTRPVVZ0ZE1TMEsreC9tOUJmRU1OMG51?=
 =?utf-8?B?SitFeTdYd0lJTHZSemRrMEtGWDR5S1M5aE50VmFYemtJM1dhbkRseHVXMWlp?=
 =?utf-8?B?bE5QT1NrQUtqb1QyeHFXWUtLTTBDaXFRUmdwNEpMZDJrYjNTN001OGVMQ2NM?=
 =?utf-8?B?am04S1JFOTJxQ2pZWDExamFwSUlwT0I0U0JUOVljMjZRamwxT0IrNktOZFNY?=
 =?utf-8?B?elUxOU5YUjVZMmhMd0FsWkhGWERLRVQrYUQrYUQ5Lytnc0xKcHpmV3Jpb2t1?=
 =?utf-8?B?Rm4zZ09xdE1ESUZhR3ZReUg1ajNTbnk3MENnWjZUenEreGZkblVZVm9yVmdD?=
 =?utf-8?B?azUyVGNHU00xVXBBZTA1M2hvc3JmMkV6Y3BSR2prTUpQRUFyQ2lzZElCSHpt?=
 =?utf-8?B?T2doMWdKMk5QNHJ0d1ZLdmFwaFRBaUV3ZkQ0bUtiY0xDSit5STROWjhKS2JS?=
 =?utf-8?B?TjdlNmsycm8zTHQ0MGdHb3pEbTdXTDA2V2tiQjNKVkZvVUxYUk4rMnpoeDJN?=
 =?utf-8?B?WHU3ZXhUVlpwZjVadm81ZFhIcUl2M1dIcFFaZkN3UEZtRlcrVDFZcUxuOTNq?=
 =?utf-8?B?dGxxa3lJbHJHMjRBYjVEV2FHekk0OWZFMmVlMGlpdGNrS0U5aFZvdUcwM0I1?=
 =?utf-8?B?Q21OazNrcWk5MG5qNkt1ZmUxNHJnTzJ3VnIrbFM1L3R1S3lGbWpvM3MzTkFO?=
 =?utf-8?B?VUoreXVXZGN2WG9PWkdmc2xrSzkwQkxFd0NTT1pqbVZNNXJaZ1hsNC9iMlZ3?=
 =?utf-8?B?WlVoaDBUR2JidHNZWFlHTzAyc21YYVA0bjR4UTJHUUkzVUxIK25aRER3bWUr?=
 =?utf-8?B?SEFnYUNibXNjU040Wno4RzNGL2hnWWdnc0FTOGRqcnorV2o1MjYyczVwZVBj?=
 =?utf-8?B?Ly9VOUFGVVorMERjd0x1ZVdHZHpZZFNoUmxaRXVhRHhrWW9scjZ6M3NYdEw0?=
 =?utf-8?B?cFVtbW5kZlRkZzc4LzdxeDN1R1dtb250ZTJOLzBKRDFnV1gzT1FRdHpRZ1hW?=
 =?utf-8?B?WDQyUFNpT3lFK0JCNU9FNFd6OGRleDRTaWVwMWtMcWRNc2lsUFRqYU1wRHZE?=
 =?utf-8?B?aGFFZkhpWWpST29md3BraEc1UFluck9Xdk1HVVBaZWNvRWdWaEFrL3lEaGFm?=
 =?utf-8?B?L29zWUNyMk54NTdZVlJSR3g0L1VBcDNRS1RNZEZJMkVTVGt6cFdmOFdNbGxv?=
 =?utf-8?B?L2RiTHZuNURBd0U4NVQxT0UyaVFGMmlLT01kSkQ0eUdIZlhtK2xWWGpidHdm?=
 =?utf-8?B?OG9BMFROZDBsMHNLQ0FZcDJGL0F5OVh2dXdjVzFobFBhZ2VZc2FrRFVHVUx3?=
 =?utf-8?B?YXQreHVMRmhsZ0JremwxWnNQdEMyWC9IaVQ2c3drbDFrUTc0cEtseTh5cUt3?=
 =?utf-8?B?aFdZNzUraFA4NmxLRVIxa1ZLbDlhUUdoUkhocFpab3pqRnUwTjllWkg0dVV5?=
 =?utf-8?B?OVVxZHZTbTRrbFhpaWk4TlEzcTJEalZMVitOY3RNeFdLcDlqdnpEaFM0NFh5?=
 =?utf-8?B?ZUd3TUxpWi9HUGJZQTFJTExVUURLbjdyVjg1UCtiaWptVzR4Rm45cUxWdkhy?=
 =?utf-8?B?djUrR1AzaTNndUhHRWFUdzFKR210TGJwSnVlUzNyckxoNnVVdkQxQTJCcUVk?=
 =?utf-8?B?VC94UUl0OER0RkF3azBNemVzemM2bDdJVDljVTBxODN1RlZtSTJ3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2bb523-c2d7-404e-02e3-08de8eb8baf0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 00:01:59.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJym0xETwCogM9zK0EWdZ9j80Rq4f41/SCwOim5VaL8zVN1sgShhbUSy1/fh+ZnRrUgE9JNZV1/YGZNDZyUtUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18816-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F8C8362885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-30 17:42, Bjorn Helgaas wrote:
> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
>
> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
>> Since root complex integrated end points (RCiEPs) attach to a bus that
>> has no bridge device describing the root port, the capability to
>> complete AtomicOps requests cannot be determined with PCIe methods.
>>
>> Change default of pci_enable_atomic_ops_to_root() to not enable
>> AtomicOps requests on RCiEPs.
> I know I suggested this because there's nothing explicit that tells us
> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> implemented as RCiEPs and would be broken by this.

FWIW, on AMD APUs our driver doesn't call pci_enable_atomic_ops_to_root. 
It just assumes that the GPU can do atomic accesses because it doesn't 
actually go through PCIe: 
https://elixir.bootlin.com/linux/v6.19.10/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L4785

Regards,
   Felix


>
> These drivers use pci_enable_atomic_ops_to_root():
>
>    amdgpu
>    bnxt_re (infiniband)
>    mlx5 (infinband)
>    qedr (infiniband)
>    mlx5 (ethernet)
>
> Maybe we should assume that because RCiEPs are directly integrated
> into the RC, the RCiEP would only allow AtomicOp Requester Enable to
> be set if the RC supports atomic ops?
>
> I don't like making assumptions like that, but it'd be worse to break
> these devices.
>
> [1] https://lore.kernel.org/all/20260326164002.GA1325368@bhelgaas
>
>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8479c2e1f74f1044416281aba11bf071ea89488a..135e5b591df405e87e7f520a618d7e2ccba55ce1 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3692,15 +3692,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>>   
>>   	/*
>>   	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
>> -	 * AtomicOp requesters.  For now, we only support endpoints as
>> -	 * requesters and root ports as completers.  No endpoints as
>> +	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
>> +	 * as requesters and root ports as completers.  No endpoints as
>>   	 * completers, and no peer-to-peer.
>>   	 */
>>   
>>   	switch (pci_pcie_type(dev)) {
>>   	case PCI_EXP_TYPE_ENDPOINT:
>>   	case PCI_EXP_TYPE_LEG_END:
>> -	case PCI_EXP_TYPE_RC_END:
>>   		break;
>>   	default:
>>   		return -EINVAL;
>>
>> -- 
>> 2.51.0
>>

