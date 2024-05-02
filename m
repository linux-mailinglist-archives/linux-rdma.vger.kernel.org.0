Return-Path: <linux-rdma+bounces-2204-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95678B94D9
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 08:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E661C2119D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93AF8C15;
	Thu,  2 May 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYyqX81f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066079FD;
	Thu,  2 May 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632604; cv=fail; b=R+F3joV9IsR+khtT4bx3+cCEl8ZwYDl/IDapQxbViWLO1p7Ic5eXObH7ZYkMo2RXIS8idUISHhs/fV6YVchncSUwzDTCwbMBZBQbpvX/MiTICwXnSXHDoQF16X02bSPXdpYyCIkSord6ZJ3XoVR+95D3+WEPs348MQHwiOjIwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632604; c=relaxed/simple;
	bh=DXJ89rVRQRZNrPI2wiqUvo0ctJVkcQ9fo+QeA/78Lzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=czSUUcmG7wYEvVk1xdOg7kjYwF95hhZR3Zb6zl6nEvFmzX6xNwSexd0RK4h+iYbRnmF3q1p1829daAxAk8ud+vFZMll+VTwWwK2mRi2APh4Y1nfHsw6uIUGB0dGyCVMYk/oDbT3s6eorh0Qg32TE1YmNfzQ2sQ45flgvfp1XNgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IYyqX81f; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2uE8uT171oqlQ2JHF4hmplUrVhoLQWmCgrDNJckNONrMyb8NAr19yH/YlueXMA8JnX9sTKYqTqcuk2uxV4mTIXER3LMRyGUdk1gqhE+TfBhLAMtxJ3BFFgK0KU4Jeaty5SYA5yjlOJ2bBnwIGCesnqwpj+350wLopJ2gLnaF0x0OPs7GzZIPVYP4NhHM7DaAA3TuOwbeOk+MVgpoUe+nbY5/CKH677vtfwdpw/pDojmIoN1Uq+SxwFl7LA+dOUEyz1V+/2pVTedOYlIQkMPKq0FK9WPPMsg4BkAGu3EjpJjcDdp2RXAn9StcQ2iQv/HOxjKWlgQ15KBYegEdvpK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7LVfnv0A3t0H9CguN9uCvrjJRGpXpW+5NVI4Uk1K9U=;
 b=XOHp+Zv1ABwYZBDTHlLBSP6+mi+0ApGVorGOj4UZbCslVOQZQPYgtz7gtEA/KEYl+kX7WVzcBvwcbxRea8svKBN1dddVPvnCSm0nrWYyD/StF3J3XYm4gPvFG4q+sf0tB7K6e6AOfhcNxO6kDQt2HnHdCuV3qL9UuO55mZ1uaZzeS1i6G+4RofaDBNBA2Og7Jo42CnIrrC4oceog9q5oeLX2h6bZIR7O9o6jGtsjjh9Ind5YToeHAXFPGfbazVbu+ovgzpw3jyg9G1aldcXWSoOtQ6rixZmWPcDMFcWBQQ/SvuJx7qsnXDWxPaXLLEmMBF78BA9LPtiSFXD1Gku2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7LVfnv0A3t0H9CguN9uCvrjJRGpXpW+5NVI4Uk1K9U=;
 b=IYyqX81fxwSJoiv4LatSaotp/94t+FNxQ9d2/JRKpIHwBKwynqwoJikVTLIPeQKqAwK9woH8VN0HNDIIUjdkUtLIjA/D8/vKEhxOv6WLP6Wgc+mjlUTmBwZHvby72UFGy08LPnn2irYjEMr40SFJnVgPJ+UKK7vX0lwlHrXBbHXUlhsEDIWDlGZh75msotNBKJIoP+12asCMOF+A7AfaPG+gFsrCbRWUh7OkCOeTNeIlITB0qpz7NjEPafx5y11RDjKkqaB5o6pU8F1xZtlMLh5YQ7GZp66IGwThkhwS0LbBNrF6efve0G5JP9bhA8CUN9xnvPoWq3sqd0IrzYdlNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 2 May
 2024 06:49:59 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 06:49:59 +0000
Message-ID: <79a63282-867f-41d9-988e-ff6ae70d3d9b@nvidia.com>
Date: Wed, 1 May 2024 23:49:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Pak Markthub <pmarkthub@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <87r0el3tfi.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 73705d09-6750-4fe5-c57b-08dc6a74156f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmlaUDVGSEhTaEZocXBjeVl6UlhNMU9Lb2VFQ2U1VmI5amh2RFBubjVTTTYz?=
 =?utf-8?B?b2tKMTZaL1NWbFpLTkJsZDgyNk4vV0tWZ3d1VVVVb1NtQ3RWcDArMGJ1dVF1?=
 =?utf-8?B?ZjBiN2VuTVJ1Ync1dU5oWGpWZE1neEJ2RlpXMzRUTXVmQm1WZ1U3QkExTmYy?=
 =?utf-8?B?S2c1YWxhUktrY0tPQm81aFBlcW5zZHhEUit6c0ZkR0lFWE1TdFBxczd3SUg4?=
 =?utf-8?B?L1VNSVdJb1BzNS93aGpKY0hjNzYwSWZJUHB5STluYzZEbkZKZUdrNHQ1RmpX?=
 =?utf-8?B?a2U0RWRrVVdGclgrRVpHOEUwYkh6MGplaDBRcDFoQ2F6TGNQVi9VSkt4WmRs?=
 =?utf-8?B?QzdPOGhvblVQMGEvNW95Y2VncTAyYUd2WHhiMHo5TGNzbFhoSFdXbGcyUDJ4?=
 =?utf-8?B?M29zSU84NUR2SlpkQkdqb3BRdGRLd3U4czNLdDJmZjRoM05QNncwWjNqTEVP?=
 =?utf-8?B?TCtkVUZ6Ui9RV0dvUTJpdGkrVm9OeHA5ajRxOS9JTHNqM29GQmFvNWdPbWJL?=
 =?utf-8?B?VDhLeTJvY0w5UW5ZV3lPN2VPUGhiNUJ4V1o1dXhsTDNCV2V2b24wUXNWc2ZT?=
 =?utf-8?B?M01ubG1yOXhlODV0UXJSV2Yra2ZEWDdQQ1dxYTh2aWd0ZTl3RVZuc1djL1BE?=
 =?utf-8?B?SkhjNFJvQnpOMW9uaVNGSW5qV1NsTzNzZFc4QzVIcXZOK2tvSVczQUcxRDF4?=
 =?utf-8?B?MW9LNU9zWVJoRXZ1VzJUU3I5YS9hWW4rci9IMmVNOWU1bWFFUDlmOFM2a0R3?=
 =?utf-8?B?YUtHTVpCL0tJRm92Q09YQVpwUUwxZExKYXlKY1NCOTFuT3B0RDRQR1Qzdks4?=
 =?utf-8?B?Z3pRTWhpSmVScUxBekdVWlBydWxTU1VUbUJ4ajZXTzREQ2ZrU0RzRGVsS0k2?=
 =?utf-8?B?RkJ2ZC9wamtob2k1SVRNRlp3MkZ4dmY2NkRXMmtlZFROam4xYUN5QkQ5NXhQ?=
 =?utf-8?B?Zm1uN2crNXcrby9ma055V2ZvSDN4RE9WSkNlYVkzKzhiMitpMkNpMC8vWkY4?=
 =?utf-8?B?ZE4zSEZZYlZaTFFpemlOcXl2d0R1ai9qRng2V0o2SGxMOFVxcnd2eWRoWHN6?=
 =?utf-8?B?VlhxNEgrR25nL0ZjZ0JFaVpYZk9iblZSQ2tyUmdVZkJ2TGNWYjl6R1Z6bjZl?=
 =?utf-8?B?ZTR5RlM5QzNqUlR4QkdDMTZtS3A5a09aNlZudHJxYTVVeDB2NkJmOEVHcTNP?=
 =?utf-8?B?N2pGdW40YlpwMHk1bkFXTkdTZ3RacnhpTFlBTXBmbUtDSDhYMUdDMlNseTVz?=
 =?utf-8?B?ckxLdStvV2ZjQTNuOFpRd0hkMWJiMUZDcGtTNzZ6Y3k3cUN2T096dTk0cDh2?=
 =?utf-8?B?NGZMelFQb3FURmNrcW9GNytwaUxaNTNVZXlWRXdVMytsVXZTK0RORlljZTVD?=
 =?utf-8?B?R0Z2akptV3l5bmg5UFBHVUJ1am00TVJmZWxTcndnMERoT2hPYUwyMDc4cWVa?=
 =?utf-8?B?L1ZOTjByNERKMGJGM0FCbEhObTJ6OU5qVVRTVjhaMWN4M01DbC9FZ2tnQkpw?=
 =?utf-8?B?TWJOMlR3QW4vUXFHQ0VnVnJGRUlNWjNLdGdUUjYvR2lCaGk3ZW11dzIxN081?=
 =?utf-8?B?Y1VETjlkMlU0OUtpekNyR0trdkdENzg1Qmx5RzZWVFdVZmFNVzZ1VFRDdDk0?=
 =?utf-8?B?ajVoY28yVmpJYXpONklFL2lRVWs4YTFHRlBTWUxXL0h4ckllV0tkcnpYd3RN?=
 =?utf-8?B?STRrTjNEc01lNHpUOHJ2aFRPTGRMQlh5c1psNUJsU3RxUlA2SjhDNXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHpzSWNoaDF6cThaLzc0K3FVTERlWWNIOXBOWCt4eVl6UXQ1L1JmVVMrdmRX?=
 =?utf-8?B?N3ArL2h2bVI1b29EWnBScSs3VGlVLzVVb2x2c2RSSkRmcWUvUGNoVjdWSE5v?=
 =?utf-8?B?ckpJdEVIMm5yT2pTS1o2UmFsRWlsQlNhS1UzbEFtN2ttSjNLdko0TFJicWZ2?=
 =?utf-8?B?dVNnVndFU3RicFI3Zll2b1hFbWJIWUNmeWdpZmFqQVFoOVlRVHJqN1JoakVZ?=
 =?utf-8?B?OEJxb3hjWUJBT3h4Yy8rSnl3dWg3c21EcjlPN2RzaWJ4ZW9SU094eWkxdHRy?=
 =?utf-8?B?bWI2UHhaTjgxaGVRUFhuaU0xMmROZVgrYzRjZkRFbHQ4aVE3OTBHTjRaWmpp?=
 =?utf-8?B?cnhCcUtpZVF3OHYrVzh3UlcrdGVLQkt4S1B2TXc1U2tjVWtFNjlCbXpKWVF6?=
 =?utf-8?B?bjR1V2xWVmRWMGNEaklkMFNEQTFSeVkzVGlHaXVGd2QxenFKQXl1ay96eThO?=
 =?utf-8?B?eDgxNm9TSEluQVJaZUc5dmtKT2lpcXBkeDByTFk2K3JSdWtUbGNncm05a3ls?=
 =?utf-8?B?ZkFPaFFFQXB6M2hveStsMDVIc2ZpUmZDNHZJQUNWaDlxcmNMUXhMNm1nSGVZ?=
 =?utf-8?B?bzN4UVFxd3BUMDFVY00zODNqMURIaUFrQ2Y5dFpWOTNwbGhKT1piOWdyUzRs?=
 =?utf-8?B?WHQzYVhBczNTaFYvNWw4Q0VFRnh5TUtZWjk4Q0QvOFJzYm4rL0p2Q09Qd2RT?=
 =?utf-8?B?S3BkVkdJejlld1B4cEtCL2txd21meHZuV2l1Qm9mNUQ1ODBVRHJISGpZeTQz?=
 =?utf-8?B?OXRtaDNaLzExK3puaFVLSTZ2ZlVGN2d4dTJZUTkwUFFuZVNMYmpSVmNQZElX?=
 =?utf-8?B?Sk5HZlJGeW9YVW9tR0pJNjNpZVExK3pjVXVmK1JsQ2FEcVdSNHo2eks3SkVy?=
 =?utf-8?B?dWVKcHcreE5Dd0ZTUkhDSVBlV2JORCs0UXA2ZnM5N2NWcHp6aFhsOVhZcUl1?=
 =?utf-8?B?cmV0M1JoQnIrT0xQYVYxREpDcVRPWk01cjlNT3grdTlvVWg3ZzVHeS9BUUNH?=
 =?utf-8?B?T0Y4VHVqelJJYkczVzQ1UlpuZkNKTWNxSVU5SndoUlZBU0E1R01pWXo5OHNP?=
 =?utf-8?B?cDFmS2hDdm8wOHY3UVN3dlVsR0M2bzVrdFB5OGUvdTF5ckFFM1NoeDlqWEl4?=
 =?utf-8?B?eDBPODRtaUtadkwyTFdJdHd5RldIaHVJOTJEOXUrdkZtVWNLRGVXcDVXWDlG?=
 =?utf-8?B?VHVCWmJ3YlFBRmpaQzFlbm5qRVZtdnlwckc1WStYZ0VpTHdlWWo5YWlJc3Bs?=
 =?utf-8?B?VWx5N2MwVTY4M2NsdWFlQXlpMnYzRzF4bjZmM3p2c0d3STNhOG91aUlPQkZu?=
 =?utf-8?B?YjNoY0JMOVVVUDRoZ2FLeXVFQmMwUkYySG1nZGV3eW9yNnU0MCtIbXFyazJ5?=
 =?utf-8?B?anlqbkJtMW9kbW8xaUhYbEsxM0xBRHA2QlZQN3BiRXdjSTMvN1R1N3FvZGQ1?=
 =?utf-8?B?RXdjMEhXMG1oTkVYZ2JLdVVkbXBGM0F6ZmFnMk8yUWZTRTRGUEZKU3hmWm82?=
 =?utf-8?B?Qi85MDNjL0l6RmlwMlRFVmtPN1E2NkJzK3JldzhldnFTZTBwY3liMGFBS2Nm?=
 =?utf-8?B?cGs1RlBwRk95T3JYUkZTSitUVXZ5N2h6TjZJeXN0ajk1UnMzclJnbk5IdFh4?=
 =?utf-8?B?bGtNWExzMzhWQjduRHdjVXVaUlRGd2o1dVNsVml5MDFpUXhsamhUTU5nR0Rr?=
 =?utf-8?B?UkZTYWxjdHBCY0JUdlFubjRkU2U3czhYcEhwU3JiWGFmVS9qb0J4aGhWVUtC?=
 =?utf-8?B?VGdadFBVSm0rd0VGTXRta2llOGhmYnhYeDlJWFltZXZKd0RpdHp5SDhkUFlH?=
 =?utf-8?B?RkFSdXQzbEJnU0NKdlQ0aDNIdWhRcGpOclAyeE8ySzhjNjNJUDU1eHM2N2ZU?=
 =?utf-8?B?b29XdUNzMU9yNGZZaGhSQ0lxUmtXVEFZNUk1U0NJaGluNWVJTmFyWWRQQzV5?=
 =?utf-8?B?NlFVU3BYSVc0V0duVE9OakRaSGcwQlhKR05udE9qMDNjZ3ZqSmlDRXJpbDRB?=
 =?utf-8?B?bkVaT09LS3V5TDBsaFZwMDlxYi9CWndTYkVvWExJdUFBcGlob0pBRlB4R1pU?=
 =?utf-8?B?ZEVySU1kcHFhVXRWRmNzUnVHbUlUc1pia0pWK0NlRGlDOEgwUTI1WGg4NFBp?=
 =?utf-8?B?RnFFRmx4cVhEaUd1ZlAySGpwRUFzWHdkY25BS21jMUg0NThWWEtVSXpLZjRs?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73705d09-6750-4fe5-c57b-08dc6a74156f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 06:49:58.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XlIozhf3hYs9Ns6I9YwCvPWzEojpeunT+okOq0O3RdY2DNWtQPMJI+UU9Lid/rMD/a7PVY+xW41ZOIbMjiuSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

On 5/1/24 6:05 PM, Alistair Popple wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
>> On Tue, Apr 30, 2024 at 10:10:43PM -0700, Christoph Hellwig wrote:
...
>>> This doesn't make sense.  IFF a blind retry is all that is needed it
>>> should be done in the core functionality.  I fear it's not that easy,
>>> though.
>>
>> +1
>>
>> This migration retry weirdness is a GUP issue, it needs to be solved
>> in the mm not exposed to every pin_user_pages caller.
>>
>> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
>> then it is pretty broken..
> 
> I wonder if we should remove the arbitrary retry limit in
> migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
> they migrate? By definition there should only be transient references on
> these pages so why do we need to limit the number of retries in the
> first place?
> 

Well, along those lines, I can confirm that this patch also fixes the
symptoms:

diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..faa67cc441e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1728,7 +1728,9 @@ static int migrate_pages_batch(struct list_head *from,
  				else
  					goto move;
  			case -EAGAIN:
-				retry++;
+				/* For ZONE_MOVABLE folios, retry forever */
+				if (!folio_is_zone_movable(folio))
+					retry++;
  				thp_retry += is_thp;
  				nr_retry_pages += nr_pages;
  				break;
@@ -1786,7 +1788,9 @@ static int migrate_pages_batch(struct list_head *from,
  			 */
  			switch(rc) {
  			case -EAGAIN:
-				retry++;
+				/* For ZONE_MOVABLE folios, retry forever */
+				if (!folio_is_zone_movable(folio))
+					retry++;
  				thp_retry += is_thp;
  				nr_retry_pages += nr_pages;
  				break;

thanks,
-- 
John Hubbard
NVIDIA


