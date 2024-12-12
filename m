Return-Path: <linux-rdma+bounces-6469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759AE9EE3FB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 11:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E41188904E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6102101A3;
	Thu, 12 Dec 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fGyuvlyL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3911F2373
	for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998862; cv=fail; b=NqotYofFbRw0ES4/mjp/83E5HVcdeioE0Z6yHGKv25tXz0LrBwk9Pt/7Z6Tq4dTuVfaN2KLAqWoyEK+IhNuG+CiGP6WJcXhztLAPAPXt2+BMdp2shBQIhgPAWUO/CFZUE5u6apTfKVpWVKzuJR5wUh45zYbvFm5iolkfiljm4h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998862; c=relaxed/simple;
	bh=ist3IjniAy8iBJvlDFn0XvKTNhjvbMZ4ylM2Lm8hKec=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rtcLNQuxiCMDLnpefHFi1GdtNQ9nVhoY8/iG+/25zXledlj6Y/ljwxPAUGSpYIIk1DRSEySs+TvgCUyEFpaxtO7LBMflg2R6mcLzUfrbd7Bufzw5kNlAR88J3c78p6pkLYldG8i7X4/5iHjuG//BzYE0wi0jZdL4K3kw7O7CTF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fGyuvlyL; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC717WP003603;
	Thu, 12 Dec 2024 10:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ist3Ij
	niAy8iBJvlDFn0XvKTNhjvbMZ4ylM2Lm8hKec=; b=fGyuvlyLJxt9/WebtG0MOs
	AHJyRz1eYAMTRB6IlKRmA9wcOgCctzso+h2/CJXu3ODMEvkRMCU7e1EWFhGiFlkU
	kLcwzhKZtqPHwYjkY7TSVI2Isk2HJCm/uRLuMK5PlhUYtsFk2OS4MiKzGzo0N7Cw
	WG24Gu7rhXZt4NCch0STqPMkCMOp4oXDNkjAsVp6b2H42l8STaGLpjsNxq0CxjSX
	yzH8NS/n28uxBZFUA4TtuKUv46fwPpLXDGYNAdoPFUXRQ9yHFyFLfL4jIVU15vne
	PhCc77p0hfhvAoKqnxhdkD7u1ejiytvdf5Zu2DmEfNK2DjHyuSpBHcXa+FGF4e7g
	==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xt647-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 10:20:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLeaJvm228nJECjPjeNQxbD8e1+IH4gDA/p5ju9KRnNkO9ju/UHJ+cgpqf0J90fw6XzSxtLlcZTGMpze0bHVuer+PynstKDEc/3AcQ+movGrqW0eyft2Pl6hT6IZGIhbYk6nyc62GGQZaJGmXmxRJERQQfkOi+XYonOQxFksz2xEyFcTYZKP+GjV9q7O5OURIdmjCglxg/IKOEoDnFX6W0/hJEBjmF+NB2701fTksIPMjLAyDuSqLsjgfOeSQin34G+gXcduuJbZzRZhzIbB7wDewEKrFBdcaRKBKdHJ5ejbebF3nvPYBjvlssxDRr45YSTCAqUzWaqzwyT1KTqdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ist3IjniAy8iBJvlDFn0XvKTNhjvbMZ4ylM2Lm8hKec=;
 b=QjOW6W7Bqk8EEMCh9H0bsHgArJDMrM/Lly6SlBxqsaOUlylnkTcV73S9osULrqrS2dbeU8tDNSWUMxetFT1oD12sIjEAUrxd/+lKOKAeZVfT5VtdYQWyu8VKomcTQSrUab79I3PX1xQ9NhXOCi9mv9ImrQl9a5Baeo4OQPa9vgRbDRCUoOy9v85xEjB/VTTe4g3KfDA5FuRMHie17CqM0+fvFoe6079RBdJUcNcLOilgw0TEvOiooCXppGfgb8HFkNnD2arfTETZ+FIottnCK73DzrYy+WrzogZQMhtz6POSeoC6n7KNkF4joN05t+qEyHMI0DHpVHNG67Wzjuh5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by SA1PR15MB4903.namprd15.prod.outlook.com (2603:10b6:806:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 10:20:52 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 10:20:52 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: Remove direct link to
 net_device
Thread-Index: AQHbSwQv3cnSLCjGOEepm6Xze1BjgLLfkViAgAAKSlCAAD1ngIABTeiA
Date: Thu, 12 Dec 2024 10:20:52 +0000
Message-ID:
 <BN8PR15MB2513A5425BB295C9A08C44EF993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
 <20241210145627.GH1888283@ziepe.ca>
 <BN8PR15MB2513CA1868B484175CB61E88993D2@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20241210191303.GF1245331@unreal>
In-Reply-To: <20241210191303.GF1245331@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|SA1PR15MB4903:EE_
x-ms-office365-filtering-correlation-id: 20398c1e-e41d-4231-0976-08dd1a96a813
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODlRTDVyaVpXaUhiWUZFbzRsNi9SU2IvajNRbFhON1ZBaG1hWDI2NzV6Umlq?=
 =?utf-8?B?Qm05QnBPdTdqUktrV2JRRjVGSXp5QXBrRE5RVkpYNWUvWVV3R2JTK1hDTjBa?=
 =?utf-8?B?Z2M2eHB1bnpCWU5xaytaemNTUkptbjFUUm9ha0JJSWwvazJVWk9HRjZKbkFy?=
 =?utf-8?B?dXhUTTZqVkcxdS9qdXRIWjJIamRvSnorUDBxakdESHQyODBKNlVaditoVUlk?=
 =?utf-8?B?SlBZTzB6a2FZQWdhSmlOK2ZRanlwUEV6R1l2ak1vc3BDeDBVSEtTemtmWGMw?=
 =?utf-8?B?OHFYNDlTT3MyQk1OSHJJNXRkVUlxVUpiZWVRUnpJYlo0UnB6eDgweDh0aTls?=
 =?utf-8?B?bzdnQXg3Q2dzcTQ0NWdBTWpCTEIyZHA2WWQzSHd5bjJGYmhCRlpOOFFIQ0lP?=
 =?utf-8?B?WEsvbDVaSmg4WDN5Z0RMM2tpcGk0QlgxQk05QmErVTJsckNzNGZxRllHYmVi?=
 =?utf-8?B?TXh1dDFkL2txVGo1K1UyTTU5U1lrRDdRMSs5WXRIQ2FhY1VVVTE4MGFpdHR6?=
 =?utf-8?B?Q2h2RWhEaTRacjk5VVBBRzdNRjJrVTRlNWlRbG5Gc1RzZThxdWFhUXpvcEYy?=
 =?utf-8?B?TFRSdXo3N3lpV3NBY0NsZndwRHlaYXRLTTZqVHNPK2p3OEV2cWRpRUxpMFZr?=
 =?utf-8?B?bEhJbjVzaWNzYWw4VEJNN2RPQ1YxYXExY0FnUlkxZU85bnFUaG5oZG9XUDBJ?=
 =?utf-8?B?c1ZaV21JbnJVb2NxZkNROGJQMCt5QkZpTHBPVTkybUhDdkFTeThveGJxemRH?=
 =?utf-8?B?S0dFck8xNmdETjlSQnYrdnFpMDY5VWRCY3JwUjJ1TUpvOWJpSnBEam9SZGdx?=
 =?utf-8?B?NkRvMUJnWTdBZnN4cGhKenVjaEdUNi9mZUsyZHZBV0Y2eDd1Z0p4NG5vOVJI?=
 =?utf-8?B?a25yNU1GRlk4SnJSeENLbzdwc0FsK1ZoN09lS3JBSDg5OCs1WUkzTG00OCtx?=
 =?utf-8?B?dSs3ZUlmMERHRjNZNVN4aVJDczNuNUJPZUp5SE9NRE1zY0xCb3BnK1ZpbFha?=
 =?utf-8?B?VnpZTC80UnlHa0xxQlN1cXcwOHNMZDFtaEsyL1MwY0NqbFlnUWpPd0l1SGMz?=
 =?utf-8?B?dmpESzBzZDNuWkdkRzQzNCtFZVdsV1JkeC9obkswTkNyMDhra0RaZVdVaWlN?=
 =?utf-8?B?UGd4Lzl1V1VrL24zeXRMOUxNVUliZDJKWGdZVGNBamJIelhjQ2hsck8wZ0dH?=
 =?utf-8?B?TTYxWFpUd1JoRkYyejVFK05CN1VsVTdQTmQ1cEg0Ymt5VWpPbldWR1BGcFBz?=
 =?utf-8?B?bHNqWkkwZUNaajNXS1BzZjkxdjJqd2M4c2QvT2haLytDQVdOejRqcUc4Z0tK?=
 =?utf-8?B?K2tGV0F6ditVQkg4cDNNWUw4TEVrQjJTeHp5VWsrV3UrdjB3Z3lUOFFjYnFG?=
 =?utf-8?B?R3hucWVkWjd0cXZVTjh5OGNPeTBYRDV2T082QkVqUXgwNnlvTXpOYk1tbWd5?=
 =?utf-8?B?UHdqMHUwYlEwbEx4bU1wY3VCRnY2QVE2bU1HdGp5VWxuUldtSWZhbGlzQVpI?=
 =?utf-8?B?VWpOcUg3bnR0TXo0ZitqSXpmV080UFRUQml5Q1h0NVo5MHR4UnhYa3ZMNFUr?=
 =?utf-8?B?V1hEN3BUVjJYb0M3dmdDOE9zNkVEdEprRUxsc2U3KzFPcFVjOTVEbXZwOCsr?=
 =?utf-8?B?WHN5cGxwOHVEcDFjVStZU2tpOHRXVHJwN1pualhjSjZjQ0ZPVXNxUldrc3lo?=
 =?utf-8?B?N3RZZDFrenplUlViQmFpcVNkV3ZoVWxSUEZsM1MyeklYelVZOHJRand6N0Nt?=
 =?utf-8?B?QTBtOVl4eVRoa2xqWG1MOWV5Y0ZTakVnaDN0YnZoVHZuL2JuVG5uVGNUWTRm?=
 =?utf-8?B?NXV5ZFN3UHdpbmhHczN1N0Vkb09CTmZVbXVSV0x5UGR6ZitEMUVsdXhzbjlG?=
 =?utf-8?B?MlVHdFV1bjdDZklxdVduSzF5WWx4a290Tjl4bmR4MHlNWEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUd3dzYzQ3NBY3hNZUd5bDNpWW93TnYvVWxCS1hFUEJhcm1zUU1kampwQmw3?=
 =?utf-8?B?eU00Qk1iV2dxWUMyRXNKblp6S2JZMGxGb29lZklWV1ZjcE5RU2xwZU1URVdS?=
 =?utf-8?B?ZTJCWHd1ckV4TkJRbnNVL2hHa0Z1R2s4WDMvQXdteWpHSEg5ejlHVkV3eFhW?=
 =?utf-8?B?WWdCZFpZenFSVVYwZU9xeFZiSEZPR1NTUENVOHR0TUx5cW9ab2Z2TDFKTmY3?=
 =?utf-8?B?aU5SNFJ4RHdGaXRCQnJUWDhudnB0VkNrdGFQekV3S1I1YjRNckdqMHpTY3Bq?=
 =?utf-8?B?WmlkbURNL3V1S2NxSjNrejE1T3pLbCtUWS9VMFg4RXp4SDVHcG8rQnMxRTh0?=
 =?utf-8?B?RGhVVWpta3Fna2piQlBWZEVBSlkxeG5oZEtBeUpGeXlHVTAwZC84bmlQY2RB?=
 =?utf-8?B?M01Jb2VxZmpMZ0xyZVJRb1JiK2RnRzd2ZEVNalJ0TzNabjUxQ3h0Ri9oenhr?=
 =?utf-8?B?U2lPZEVMMHY5cmgxQ2NvT3BQZUx0ZVIyYXl4NzN0STI0L1l4S3A4WjZpbjVV?=
 =?utf-8?B?dkhTR0s0Qk1FNVkxajZPeElsWVZYNUJuRzJjdmtoN1ZyVDYrYWxPMkR0RmIx?=
 =?utf-8?B?RGJIRFdZK2YxU25kMlc5SjdwbHp0NDZIQTF2Q3o3TWt2MHAzK0lQLy9IVmtp?=
 =?utf-8?B?aU1FTVRSNmR5cWNqMmVmQ0RqVmVLbEYrNnFUZVZYekZxTmc0SWpVNURpbUZH?=
 =?utf-8?B?Z3ZVVmx6MUh2MGZ2VXhDNW5ub25qMkZKSDJmMDc3M3hyaXpEQTNSZ3Zvb2pl?=
 =?utf-8?B?UGdxK0xMckF1QXBtblZIRVFJbXlPYzVFcUxQQ1ovdUFTbTBPeE5yaEtWYlha?=
 =?utf-8?B?Q2tqMi9meTJmdnFITGw1Uk4ybExxdDk3WWVIUjJJUzgyeklxN3hudXdPK3cx?=
 =?utf-8?B?RUIrRTZhbWlESitYRUhBeFhnSE9lQ3FrZEgwZENtbVNFTllFUmFCM1VvK3cx?=
 =?utf-8?B?VGJXOGFZRGtidmpBcDN1R1RiakdOVWJnbGRsTVppVFVNQjRpNmlQSjl2WmU1?=
 =?utf-8?B?NFdSenVmYk53TjlnYWxYWVRZSVpZY0dFVzR4OUw1VWdiNitSbjJKTGFaN05y?=
 =?utf-8?B?dmxxMEhqeHJOb1BYRjZBbk9OakRlTGVjRzVFYmZGdm1uZmd3QVUvWXlzZ2ZE?=
 =?utf-8?B?VW9EZUgvUE1pWTJ0ZEhjZXNpcTFEMTZzSjVtRzZlMEtRengxMlJubnQ1NC9w?=
 =?utf-8?B?azZYdE04WlhzWTVseWN2d1JOKzI1WkhteHFHbFdWbVo1WDJsejgrZm9jb2hl?=
 =?utf-8?B?RGJCdll6aVJBS3pwT0kzLzRmRENtYVJRbEZ3ZkVVaVFBUzRaZk1wTHU2NGt3?=
 =?utf-8?B?akRIaWdYa3VGdDc5YkZwSU5DUVk0dExtN0RNMkd4Z1VUUlJ6VkZiRVNJQ0RQ?=
 =?utf-8?B?V21HNWpBZXFCeUI4TkJZYjNaSmtIK3pDOGpjenBjKzd2UDJRZzUyU2s0ZjNv?=
 =?utf-8?B?aGxrUi9HRkRRNDRDU0RpUW5Rc3hYWDJHVGMxdkdkSjArUEF2ZmhKYzc3YlZh?=
 =?utf-8?B?R1FKQUl0OStsekRZYlZ4eTBoZUd6dWpXZ3BkaUtoV0F0S1J4M29IY2NuSDhU?=
 =?utf-8?B?MkIrdTdzSDdSZ1QrWGRVYWhva1BzODZBRFkreUcySEU3cGF2Nk51eG5ONk9W?=
 =?utf-8?B?WnFvSXlEQUxoMUdMSHlYTklrbG1ZbE1MZzFUVHFXb3FrOVVEOG1TSmhRekdR?=
 =?utf-8?B?bWt4RDN6YzJpL1VCZTBrQmZqbVNKdUY5N0xjWXd1WnVyN1ZKMWJncmtsa3lu?=
 =?utf-8?B?aTJmV0xFWkc5cFNNWVNGbVdHcXZVWUgyMWhQckxJK21RTUxTWjk3Um9lNVBh?=
 =?utf-8?B?RnM4b2RnSVoxSVVzZERadHU2MC90ZCthcy94NDhQNUNHcDRRc2VjUjhGdm9o?=
 =?utf-8?B?ckxlU21nQnNuSXU1eCsvVXhhZW5xNlVtckVpUFMrWjRlZnVhRk1wd0FFc2ly?=
 =?utf-8?B?YmJFdm5GUVJ4NFFBK1BWTFhRRkRWUERXS2pyL0lBWXd4MjBJRkJ4UzZKKzdv?=
 =?utf-8?B?TDlyRmV2S2xjRkVualk5NHgvTldaeW8vVEtLenpmTElCblBJS28rSmZyM1BK?=
 =?utf-8?B?M2pDb1VleWliZ0NvSmpYVEZkbnhMTGZaYitRQXZZcUNZOWVrR3M4ZXZjOGRv?=
 =?utf-8?B?TG0vUDlQK29nQkRiR0gvTHJtOWlJMTE0cWpwRjhRMWlYd2ZjdWZyU2YwS3py?=
 =?utf-8?Q?8mLVje63UeJOxMX/N9wQtDc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20398c1e-e41d-4231-0976-08dd1a96a813
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 10:20:52.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXlx4WPNyl0vUuGpB0UAFatrSx5JyC554nEsCMQjzzjHcUcvV+PMCAeidEnEGHLy9ndGUPtt+Bhnv5QLe7p8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4903
X-Proofpoint-GUID: jhJMN-kPih5kOxUXso7MUqcRh9iADVaj
X-Proofpoint-ORIG-GUID: jhJMN-kPih5kOxUXso7MUqcRh9iADVaj
Subject: RE: [PATCH] RDMA/siw: Remove direct link to net_device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=988
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120070

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEwLCAyMDI0IDg6
MTMgUE0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzog
SmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+OyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0hdIFJETUEvc2l3OiBSZW1vdmUgZGly
ZWN0IGxpbmsgdG8gbmV0X2RldmljZQ0KPiANCj4gT24gVHVlLCBEZWMgMTAsIDIwMjQgYXQgMDU6
MDg6NTFQTSArMDAwMCwgQmVybmFyZCBNZXR6bGVyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEwLCAyMDI0IDM6NTYg
UE0NCj4gPiA+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gPiA+
IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZzsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC0N
Cj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IHN5
emthbGxlci0NCj4gPiA+IGJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsgenlqenlqMjAwMEBnbWFpbC5j
b207DQo+ID4gPiBzeXpib3QrNGI4NzQ4OTQxMGI0ZWZkMTgxYmZAc3l6a2FsbGVyLmFwcHNwb3Rt
YWlsLmNvbQ0KPiA+ID4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3Npdzog
UmVtb3ZlIGRpcmVjdCBsaW5rIHRvDQo+IG5ldF9kZXZpY2UNCj4gPiA+DQo+ID4gPiBPbiBUdWUs
IERlYyAxMCwgMjAyNCBhdCAwMjowMzo1MVBNICswMTAwLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+
ID4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPiA+ID4gaW5kZXggODZk
NGQ2YTIxNzBlLi5jOGY3NTUyN2I1MTMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXcuaA0KPiA+ID4gPiBAQCAtNjksMTYgKzY5LDE5IEBAIHN0cnVjdCBzaXdfcGQgew0K
PiA+ID4gPg0KPiA+ID4gPiAgc3RydWN0IHNpd19kZXZpY2Ugew0KPiA+ID4gPiAgCXN0cnVjdCBp
Yl9kZXZpY2UgYmFzZV9kZXY7DQo+ID4gPiA+IC0Jc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldjsN
Cj4gPiA+ID4gIAlzdHJ1Y3Qgc2l3X2Rldl9jYXAgYXR0cnM7DQo+ID4gPiA+DQo+ID4gPiA+ICAJ
dTMyIHZlbmRvcl9wYXJ0X2lkOw0KPiA+ID4gPiArCXN0cnVjdCB7DQo+ID4gPiA+ICsJCWludCBp
ZmluZGV4Ow0KPiA+ID4NCj4gPiA+IGlmaW5kZXggaXMgb25seSBzdGFibGUgc28gbG9uZyBhcyB5
b3UgYXJlIGhvbGRpbmcgYSByZWZlcmVuY2Ugb24gdGhlDQo+ID4gPiBuZXRkZXYuLg0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCj4gPiA+ID4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfbWFpbi5jDQo+ID4gPiA+IEBAIC0yODcs
NyArMjg3LDYgQEAgc3RhdGljIHN0cnVjdCBzaXdfZGV2aWNlDQo+ICpzaXdfZGV2aWNlX2NyZWF0
ZShzdHJ1Y3QNCj4gPiA+IG5ldF9kZXZpY2UgKm5ldGRldikNCj4gPiA+ID4gIAkJcmV0dXJuIE5V
TEw7DQo+ID4gPiA+DQo+ID4gPiA+ICAJYmFzZV9kZXYgPSAmc2Rldi0+YmFzZV9kZXY7DQo+ID4g
PiA+IC0Jc2Rldi0+bmV0ZGV2ID0gbmV0ZGV2Ow0KPiA+ID4NCj4gPiA+IExpa2UgaGVyZSBuZWVk
ZWQgdG8gZ3JhYiBhIHJlZmVyZW5jZSBiZWZvcmUgc3RvcmluZyB0aGUgcG9pbnRlciBpbiB0aGUN
Cj4gPiA+IHNkZXYgc3RydWN0Lg0KPiA+ID4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggd2FzIHN1cHBv
c2VkIHRvIHJlbW92ZSBzaXcncyBsaW5rIHRvIG5ldGRldi4gU28gbm8NCj4gPiByZWZlcmVuY2Ug
dG8gbmV0ZGV2IHdvdWxkIGJlIG5lZWRlZC4gSSBkaWQgaXQgdW5kZXIgdGhlDQo+ID4gYXNzdW1w
dGlvbiBzaXcgY2FuIGxvY2FsbHkga2VlcCBhbGwgbmVlZGVkIGluZm9ybWF0aW9uIHVwIHRvDQo+
ID4gZGF0ZSB2aWEgbmV0ZGV2X2V2ZW50KCkuDQo+ID4gQnV0IGl0IHNlZW1zIHRoZSBuZXRkZXYg
aXRzZWxmIGNhbiBjaGFuZ2UgZHVyaW5nIHRoZSBsaWZldGltZSBvZg0KPiA+IGEgc2l3IGRldmlj
ZT8gV2l0aCB0aGF0IGlmaW5kZXggd291bGQgYmVjb21lIHdyb25nLg0KPiA+DQo+ID4gSWYgdGhl
IG5ldGRldiBjYW4gY2hhbmdlIHdpdGhvdXQgdGhlIHNpdyBkcml2ZXIgYmVpbmcgaW5mb3JtZWQs
DQo+ID4gaG9sZGluZyBhIG5ldGRldiBwb2ludGVyIG9yIHJlZmVyZW5jZSBzZWVtcyB1c2VsZXNz
Lg0KPiA+DQo+ID4gU28gaXQgd291bGQgYmUgYmVzdCB0byBhbHdheXMgdXNlIGliX2RldmljZV9n
ZXRfbmV0ZGV2KCkgdG8gZ2V0DQo+ID4gYSB2YWxpZCBuZXRkZXYgcG9pbnRlciwgaWYgY3VycmVu
dCBuZXRkZXYgaW5mbyBpcyBuZWVkZWQgYnkgdGhlDQo+ID4gZHJpdmVyPw0KPiANCj4gT3IgY2Fs
bCB0byBkZXZfaG9sZChuZXRkZXYpIGluIHNpd19kZXZpY2VfY3JlYXRlKCkuIEl0IHdpbGwgbWFr
ZSBzdXJlDQo+IHRoYXQgbmV0ZGV2IGlzIHN0YWJsZS4NCj4gDQo+IFRoYW5rcw0KPiANCj4gQlRX
LCBOZWVkIHRvIGNoZWNrLCBtYXliZSBJQi9jb3JlIGxheWVyIGFscmVhZHkgY2FsbGVkIHRvIGRl
dl9ob2xkLg0KPiANCg0KWWVzLCBkcml2ZXJzIGFyZSBjYWxsaW5nIGliX2RldmljZV9zZXRfbmV0
ZGV2KGliZGV2LCBuZXRkZXYsIHBvcnQpDQpkdXJpbmcgbmV3bGluaygpLCB3aGljaCBhc3NpZ25z
IHRoZSBuZXRkZXYgdG8gdGhlIGliX2RldmljZSdzIHBvcnQNCmluZm8uIFRoZSBpYmRldiB0YWtl
cyBhIGhvbGQgb24gdGhlIHBvcnRzIG5ldGRldiBhbmQgaGFuZGxlcyB0aGUNCnBvaW50ZXIgYXNz
aWdubWVudCwgY2xlYXJpbmcgZXRjLiBhcHByb3ByaWF0ZWx5LiBVbmxpbmtpbmcgaXMgZG9uZQ0K
dmlhIGliX2RldmljZV9zZXRfbmV0ZGV2KCwgTlVMTCwgKSwgb3IgaWJfdW5yZWdpc3Rlcl9kZXZp
Y2UoKQ0Kd2hpY2ggdW5saW5rcyBhbmQgcHV0cyBuZXRkZXZzIGFzIHdlbGwuDQoNCkdpdmVuIHdl
IGhhdmUgYW4gaW5zdGFuY2UgdGFraW5nIGNhcmUgb2YgdGhlIG5ldGRldiwgaXQgaXMNCnByb2Jh
Ymx5IGJlc3QgdG8gcmVtb3ZlIGFsbCBkaXJlY3QgbmV0ZGV2IHJlZmVyZW5jZXMgZnJvbSB0aGUN
CmRyaXZlciAtIGp1c3QgdG8gYXZvaWQgcmVwbGljYXRpbmcgYWxsIGl0cyBjb21wbGV4IGhhbmRs
aW5nLg0KU28gc2l3IHdpbGwgdXNlIGliX2RldmljZV9nZXRfbmV0ZGV2KCkgd2hlbmV2ZXIgbmV0
ZGV2IGluZm8NCmlzIHJlcXVpcmVkLiBJdCBjb21lcyB3aXRoIHNvbWUgZXh0cmEgb3ZlcmhlYWQs
IGJ1dCBpdHMncyBtb3JlDQpjb25zaXN0ZW50Lg0KDQpCVFc6IFRoZSByZG1hX2xpbmsgaW50ZXJm
YWNlIGlzIGFzeW1tZXRyaWMsIGxhY2tpbmcgYW4gdW5saW5rKCkNCmNhbGwuIEZvciB1c2luZyBz
b2Z0d2FyZSBvbmx5IGRyaXZlcnMgaXQgbWlnaHQgYmUgYmVuZWZpY2lhbCB0bw0KYWxsb3cgZXhw
bGljaXQgdW5saW5raW5nIGEgZHJpdmVyIGZyb20gYSBkZXZpY2UuIEFueSB0aG91Z2h0cw0Kb24g
dGhhdD8NCg0KQmVzdCwNCkJlcm5hcmQuDQo+ID4NCj4gPiBJIGp1c3Qgd2FudGVkIHRvIGF2b2lk
IHRoZSBjb3N0bHkgaWJfZGV2aWNlX2dldF9uZXRkZXYoKSBjYWxsDQo+ID4gZHVyaW5nIHF1ZXJ5
X3FwKCksIHF1ZXJ5X3BvcnQoKSBhbmQgbGlzdGVuKCkuDQo+ID4NCj4gPiBUaGFuayB5b3UhDQo+
ID4gQmVybmFyZC4NCj4gPg0K

