Return-Path: <linux-rdma+bounces-19185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDreHAvu12kbUwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:20:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F03CEA42
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAAFA300877A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D3331209;
	Thu,  9 Apr 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="afcFUtFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68563204C3B;
	Thu,  9 Apr 2026 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758855; cv=fail; b=tXJBcdMGocZA4aSIL9iUyq6DrKvoYDT9C8Hp4oM8+h/6P80q2cAHNQ8T/mOPn2FWFeLL7SCuW2EjiyROVxTNm2reyrAE0phbwumWXl/kounA5/6OYGgbGDst+n7F7gg5AuRbjGoAOHUwefUETldyprMaprVm7mI/qvMEI9IJUr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758855; c=relaxed/simple;
	bh=w4ZfGkIvl1wl7Nvz09gdIRD3edH2YAKH8KGCm4EqdAk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjmXhvBZNe1Qh51ai96Rv/46ibaHD8EgRDea5vZydTmVhZhIs8+hQOCb+FqvKENWEl5rQU40b+F7sD/yd7LgZiCzvYljPyhSSjEYBBuggQubN/H4QrhQafClMEKeDbWBTMM8wz1w5/uhKjMzcRyVOm5k0ZKIN+nAPeUGk1NcsJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=afcFUtFj; arc=fail smtp.client-ip=52.101.62.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC5+a7HeH1uUl9T5uPo9xMjYOzwci11bG8Gsngvfru5WwdKRS3Bs44B42mzPpVwOFSNp7KpEN9S/0x4jRGa+IF7iMqRtJIU9gCqrZbCiemTNDPT6Eoi6WfPu48VUgTgyyz6Pb4m2S8KxmuahGNpfFKvE66zFOAhIKgwR9vhAK0vKoAYMiq3CcaJSXbZNFv7fESyhWSKyzhEO2ODcqtfMr3u05SPE4KXfcvCNTHfZ49wRXkxCvZwP81GH4Gp0ZxIHZYrhxxZY3LhHAsgdyWGmxYWfYSRbyb09YqNfxvGaLM7JiDQpcBTO79VtoIUHuTQp170sbZOy7WFGmP2/CxTgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbrJDvN1NnrYFKYsJ/AxsfAQAziBTbM8z+FaNjFkWpU=;
 b=ABq7/MNl/iEdR49TPsxmtXc133m0dRLYbVCIAMMHK+fB3ExJakWd3dsQP0W8Y4XOPIuOwn4N6UqxeHOMZLOqG3cohrX4BBOFpgw+g7IFVj6TlD8KBAufT2Bd3I5hj7iV36nhIuLFewAv9HrGqKn6Ok1rZrCgxcyhjdVT/HrQ4AQb7RxrHcz4QcaSYKn0CVl1JP+9CSYg0y1hY+XGIwtOKOBc5I2PApL5YQphMltQ2iYLgylW677wQrNj9jIzRhME4iH80+6HOaqM84p4oTxjtsoeUr24jIVnndwrcotVGvuTmXYI6kQLN4LWV8z2kMPGPNviuadPvyTgvrHh7/2b+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbrJDvN1NnrYFKYsJ/AxsfAQAziBTbM8z+FaNjFkWpU=;
 b=afcFUtFjT1EJOdPLR0Gz/OlNVg1KKzVpdsXLD7+pjho/KBuo0wqnkzTqmypiHV6gQ3xV7NNJXUF2d89x46jsXEW4BpK9ski9OO69dVcbmEahcvAKrZDQ0BoGVDjgU0aufSrMawqf9MhO5LKaUmn4DZ6vangDStsAEF19XlrqbSvEMY45cb8P/J6LglAGVo2H/hPRytyGMSGjYQx9h/E3ihxdGdeH1YVB3jLvdX34mWjWeHdiTQvCfNY2rPL2uAsQvoa1yKI7uehZcjbRLQK831RBbCoYWoeqdzOzjKsnDVgJGgXR6fWeN7ApeJM7fj8h0vOK6NzcK18jRG7Xhg7iaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 18:20:49 +0000
Received: from IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7]) by IA1PR12MB7541.namprd12.prod.outlook.com
 ([fe80::4445:7716:8576:62c7%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 18:20:49 +0000
Message-ID: <e4708c37-ccd3-466f-b08c-653d241260dd@nvidia.com>
Date: Thu, 9 Apr 2026 21:20:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net/mlx5: Improve representor lifecycle and
 fix work queue deadlock
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
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To IA1PR12MB7541.namprd12.prod.outlook.com
 (2603:10b6:208:42f::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7541:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf0376e-e0d6-4e8b-1d9e-08de9664b9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	39GJNWoAGpPkS8mjmqLAVG56Q8SeE9ClRNrUX5r1G3ECQiNbZq/Tu6p67UoABQ9HzRsVwd/BDuHNPa44uAMzH5B8HAgttquYcLsVtHtHLJtE+u0lEiL46/FF575W+9Vhs2ptmoH43iIuAkVwVOJeBEnOxkjAgXi1jfWauuNcZFa1LzkrcDHWDXS2ECX3JdGvFwXl1iR7MmrIrMdHFg5NUMrJ9Yjdgsyp6s1vxLFymcnddktTySzNKa8ZMTuY3NgmmGez/FN8cqn+w2qMNQCoWpz/AVpP8P+8FNCv+LFt10m99rHH3mJvPHoHQpJcwXz8T5H0+WwP5z/UGPfgV43BtLIHwbRgx2mtIid+4xkIvf54E5fPKRQ7KtnqN8zgzlcACREa3i2fcZiMzw53PsA9DlKm9nHL/BO71nf9tQQtTfjf7IgisKQhmaZXn0vjW4Ek04inpqwXYemRZd5xFkqfZNQwACqfOh0B8o3hvQ5f2RjJJT5AWZUBoSPEALg1VPokWJADHjbp5DcTzvwmHSX5KQZtpI0reUxMIBWQBrFdFk9f+NgwcXshoXCOpyd/AmwhE7g3PGoy9ZAfU/PqKMqA8rr4/q8GeQj8MysJ1wdJlKv5mcWg0Mrdoao1Nv31TEXAjSP0PtVBkeCAFgk3vGjGfaEjn/0ZnDuclWSyQTLnbnXIIGIWHXgRnZNFfl5seYePaq4ORUaClKeqc89VGCxeCRm+HAB5wUBK/HFcYSwc5rg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7541.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDEvYnBBZEpLTlRBRCtqdjE5K2J4WVdZZ2ExQ2F5M0U4aXhlUmJrcjl2N3hR?=
 =?utf-8?B?VU5oZ2pqTXBvZ01mRWhSWk9GU0JvdkM2bGNPM2kyR09GUzdzb0t4V2JPQ3c4?=
 =?utf-8?B?SjZ0Y01zT3oybnJYVW8zT0h6NEd4enVHS3RrNWYyQ3ZydWZwUWx5Z0E5VkFD?=
 =?utf-8?B?M3lkTVBBakhLam1BTUhwYllWOWpaZnFnQ0NsbHFqdURGdzBJbUlHRkpGeU41?=
 =?utf-8?B?OWF4NGl1T0d5cFpzZkE3a3U3QU1XQnNrb0I5Qjg0MFBDTllhTEZ0WnF4MGZh?=
 =?utf-8?B?TDBVOGZqWWVNbUkvZ3E1K0NDNnVhZEpRTDhib01DallpUlRJSXNmOGVndldZ?=
 =?utf-8?B?ajA5OXFncHR3UmUxUzBVdXdWa3QzaHhlSWIwZjFaeVYwbXZPRkJqd1lJZzl3?=
 =?utf-8?B?Y21KWCtCbk9YN1VDMHBuNFlZQkVVb1M4cStmWWpacFpBNTlCRkVNdEc1b3pB?=
 =?utf-8?B?YmNyZVY5MnhvaElSL09LMGRPT2FvMFBEaUVHc2xka0YxMmdodUdhSFJDcmRo?=
 =?utf-8?B?V2ROTkppdGVMKzB5VXNaU3RkZURtbzJ4ZjI3dUY3VVVnT2tUVnVsbFNSUHRm?=
 =?utf-8?B?RjJYR1hkb0R2dmtVaHErUUxWV1BXTGRxTndoc2Q3L0JLQkJUL01FV1dkRTBx?=
 =?utf-8?B?OFgxQVhBTC9wTGNMV3BGM3RXd2p0aGNkQ1dhOFZ5SERacUljOEZLNU5VVDdt?=
 =?utf-8?B?ZXRTQ3BZQVhLbDd1MHNKNHBUcHdTL3M5VklBalVRSDZoQXZmMTV0eUJKRUhE?=
 =?utf-8?B?U0U1RzR4NmRjZ2xiUnhmRzhhZjVFMERwZE12WHFMeEw0SHZaQmtnRldTZ0dh?=
 =?utf-8?B?dFNUdHJrRTB3bCtqajZ1NzJGL0FRNHh4b2ZHZE5TOHM0M0t5aE93Q2xYWjND?=
 =?utf-8?B?ME5EeStXcXhsTk0wQmhuUGdTSFY4c1dKa1ZrS1hLQUVYQVdGSVd5WnpkcXla?=
 =?utf-8?B?aU5oQUFuQnVpZjkrRXF4MDh5WkdhS0lQbm8wWURGZ2l2YVJHRTRhd3JDcjRo?=
 =?utf-8?B?azh5emV5ZzlWQStlM0w0RWJHTE8xU0R3V0tFUU9DelRLb2NxV2dlMldyRGlU?=
 =?utf-8?B?TTgyK3pXaXNFNjRwOTVZZWc1VnV6bWxtd0dadzRaN1R5bzNMRldBNFM1cnpP?=
 =?utf-8?B?QlFQSkg0NDJQMWU1eUZtNCtWWGJxZVdCOWQ3Nm9HNTB0U1ZZZEtONzZyRGE1?=
 =?utf-8?B?dkcwVG9jUE9OV1U0TmdHVkxuSHY4SzRPR3ZYc0hPYmVjMGVzdEk4cjFzOG9Z?=
 =?utf-8?B?RklDYWFhS3VHRDFYOVZwK2E4TVllKzdMWGZOWWlsMlYxa3dya2l6RStMQXIx?=
 =?utf-8?B?MEVJcFFKVmRuUkFsK0M3Y0hVS016TkQ1ZHg0TFpDQWpzMGdZQUtocVZGTnlT?=
 =?utf-8?B?NG55R3M5VjBRaDJNZUtwaDBSbFVGMkY3UStWdjJTbTNUZDJ1MHRGT095UHFK?=
 =?utf-8?B?UE1CazRTTU9IY2lvME0rdlJqMlFKcmNEdkVNQnlqMVJYd0lIN2pPSzFuM0tM?=
 =?utf-8?B?dEEwZlR5bm9Vd1dkSElreWcwMjFxUXFoMHl4MU5EQUg2Nnd0Z2IrVGp6K3l5?=
 =?utf-8?B?NzVIWkZyQVZKY3IyV2NFNXJoNVBsL2Rqa3g2cFVuQjd0cVBzc0FIUEtNK2sz?=
 =?utf-8?B?NnowN2tGMkQwZCtHN3YrTzZHWkZKaUUzMWl4OXVtWWJrUlZubkdWdWlremto?=
 =?utf-8?B?WnZGRVM4eTg5T3gyS1N4NFNxLzBOcE9mdXRRMVhxQnFJUmtJL0pIaWZGN0hw?=
 =?utf-8?B?dVMzWXZCaUlrYlVkelgvU044VTRCNUY1VW56Y1JYYVZ4R0NRVkxRUFJUVkFl?=
 =?utf-8?B?Skptc0E0VWZKaVA4ejVoK1hZU3h6djM0SmNES29nUk9zaEg0N01qNFhpdzV4?=
 =?utf-8?B?K0dTdGxZdFBZWW9YOUphQnFZSTIwTDFrcTJlREFXcUExbmFuR0lWMWlSQjZS?=
 =?utf-8?B?d2ZZRFJRa2FjeStVNThPVm5KZWlXenRYaVYvb0l6dVNGSysySjZMeStDb1Bh?=
 =?utf-8?B?UGtudDlTcHdlY1NaNGk2MHdpVWtYdVVqSk4yVjhzbmJVRHVzemNudmNZd1Uw?=
 =?utf-8?B?Vm5vcGtUZER1S0xuekNmR0hVbTc2YklUVTdGSms4L0UyNEhWa2RzV2h6Sk9E?=
 =?utf-8?B?S3RqTEVSN2FaWWtnZWgwSmpsbWtVTU5HWlcxRjBvZ0RPTHNzc1FyckZ0UzBp?=
 =?utf-8?B?R3BwZzJDMDdrbTJ1WG80eUhiQ3N6VFVXNFdnTk0rOVRIZnQ1R0lrQlRYU3oy?=
 =?utf-8?B?R21FTjdtbGF2RFNNU1ZXZ080OXFKYWtFU0g2RDFaVzZVMnRsLzkrcXRuRE4v?=
 =?utf-8?B?bWdlQSswcTJTSGlOOEF3OE45ZENtc3FKa0Q3ODFaZ3A1SnJ6LzdRZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf0376e-e0d6-4e8b-1d9e-08de9664b9d9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7541.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:20:49.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fgp5rIOt5mQCTM61sea+tfzOwJmqCrOJY+pqaKJqNyqmRZG/g1DAgZt4EiF+bVLGP69utQ0kWfzUEWsH5Gkdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-19185-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 1E0F03CEA42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 09/04/2026 14:55, Tariq Toukan wrote:
> Hi,
> 
> See detailed description by Mark below [1].
> 

Sashiko flagged a few issues in the series. The main ones are in patch 4
([PATCH net-next 4/7] net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq).
These are known, and I currently consider them acceptable trade-offs rather than bugs.

That said, reviewers/maintainers may reasonably see this differently.
Before sending a v2 focused on patch 4, I’d appreciate feedback on the overall
approach and direction of the series, please see sashiko's comments here:
https://sashiko.dev/#/patchset/20260409115550.156419-1-tariqt%40nvidia.com

I've provided my commetns on each patch on the mailing list and
included what was found by sashiko.

the patch series can be broken into 3:

[patches 2/3/4] – workqueue deadlock:

During teardown we must ensure all pending work is completed.
However, since the teardown path already holds the devlink lock,
we cannot have work items blocking on that same lock without
risking a deadlock.

[patches 5/6] – reps block/unblock state
The interaction between mlx5_core and mlx5_ib (load/unload),
eswitch mode transitions, and auxiliary device handling makes
this particularly tricky.

Several conventional locking/synchronization approaches were
explored, but they either reintroduced deadlocks or created
even more complex issues. The current approach is admittedly
not the cleanest, but it has proven to behave correctly in practice.

[patch 7] – switchdev by default
The long-term goal is to have switchdev as the default mode
for DPU environments. Flipping that behavior globally in one
step is risky.

This patch provides a controlled, incremental way to move in
that direction, allowing validation in real deployments before
making it the default.

Mark

> Regards,
> Tariq
> 
> [1]
> This series addresses three problems that have been present for years.
> First, there is no coordination between E-Switch reconfiguration and
> representor registration. The E-Switch can be mid-way through a mode
> change or VF count update while mlx5_ib walks in and registers or
> unregisters representors. Nothing stops them. The race window is small
> and there is no field report, but it is clearly wrong.
> 
> A mutex is not the answer. The representor callbacks reach into RDMA,
> netdev, and LAG layers that already hold their own locks, making a
> new mutex in the E-Switch layer a deadlock waiting to happen.
> 
> Second, the E-Switch work queue has a deadlock of its own.
> mlx5_eswitch_cleanup() drains the work queue while holding the devlink
> lock. Workers on that queue acquire devlink lock before checking whether
> their work is still relevant. They block. The cleanup path waits for
> them to finish. Deadlock.
> 
> Third, loading mlx5_ib while the device is already in switchdev mode
> does not bring up the IB representors. This has been broken for years.
> mlx5_eswitch_register_vport_reps() only stores callbacks; nobody
> triggers the actual load after registration.
> 
> For the work queue deadlock: introduce a generation counter in the
> top-level mlx5_eswitch struct (moved from mlx5_esw_functions,
> which only covered function-change events) and a generic dispatch helper
> mlx5_esw_add_work(). The worker esw_wq_handler() checks the counter
> before touching the devlink lock using devl_trylock() in a loop. Stale
> work exits immediately without ever contending. The counter is
> incremented at every E-Switch operation boundary: cleanup, disable,
> mode-set, enable, disable_sriov.
> 
> For the registration race: a simple atomic block state guards all
> reconfiguration paths. mlx5_esw_reps_block()/mlx5_esw_reps_unblock()
> spin a cmpxchg between UNBLOCKED and BLOCKED. Every reconfiguration
> path (mode set, enable, disable, VF/SF add/del, LAG reload, and the
> register/unregister calls themselves) brackets its work with this guard.
> No new locks, no deadlock risk.
> 
> For the missing IB representors: now that the work queue infrastructure
> is in place, mlx5_eswitch_register_vport_reps() queues a work item that
> acquires the devlink lock and loads all relevant representors. This is
> the change that actually fixes the long-standing bug.
> 
> One thing worth calling out: the block guard is non-reentrant. A caller
> that tries to transition UNBLOCKED->BLOCKED while the E-Switch is already
> BLOCKED will spin forever. All call sites were audited:
> 
>  - mlx5_eswitch_enable/disable/disable_sriov hold BLOCKED only around
>    low-level vport helpers that do not call register/unregister.
> 
>  - Inside mlx5_eswitch_unregister_vport_reps the unload callbacks run
>    while BLOCKED is held. The one callback that calls unregister
>    (mlx5_ib_vport_rep_unload in LAG shared-FDB mode) only does so on
>    peer E-Switch instances, each with its own independent atomic.
> 
>  - mlx5_devlink_eswitch_mode_set acquires BLOCKED, then calls
>    esw_offloads_start/stop -> esw_mode_change. esw_mode_change releases
>    BLOCKED before calling rescan_drivers so that the probe/remove
>    callbacks that trigger register/unregister see UNBLOCKED.
>    esw_mode_change re-acquires before returning, and mode_set releases
>    at the end. This is an explicit hand-off of the guard across the
>    rescan window.
> 
>  - mlx5_eswitch_register_vport_reps holds BLOCKED only while storing
>    callbacks and queuing the load work. The actual rep loading runs from
>    the work queue after the guard is released.
> 
> Patch 1 is cleanup. LAG and MPESW had the same representor reload
> sequence duplicated in several places and the copies had started to
> drift. This consolidates them into one helper.
> 
> Patches 2-4 fix the work queue deadlock in three steps: first move the
> generation counter from mlx5_esw_functions to mlx5_eswitch;
> then introduce the generic esw_wq_handler/mlx5_esw_add_work dispatch
> infrastructure; then apply the actual fix by switching to devl_trylock
> and adding generation increments at all operation boundaries.
> 
> Patch 5 adds the atomic block guard for representor registration,
> protecting all reconfiguration paths.
> 
> Patch 6 moves the representor load triggered by
> mlx5_eswitch_register_vport_reps() onto the work queue. This is the
> patch that fixes IB representors not coming up when mlx5_ib is loaded
> while the device is already in switchdev mode.
> 
> Patch 7 adds a driver profile that auto-enables switchdev at device
> init, for deployments that always operate in switchdev mode and want
> to avoid a manual devlink command after every probe.
> 
> Mark Bloch (7):
>   net/mlx5: Lag: refactor representor reload handling
>   net/mlx5: E-Switch, move work queue generation counter
>   net/mlx5: E-Switch, introduce generic work queue dispatch helper
>   net/mlx5: E-Switch, fix deadlock between devlink lock and esw->wq
>   net/mlx5: E-Switch, block representors during reconfiguration
>   net/mlx5: E-switch, load reps via work queue after registration
>   net/mlx5: Add profile to auto-enable switchdev mode at device init
> 
>  .../net/ethernet/mellanox/mlx5/core/eswitch.c |  25 ++-
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  15 +-
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 204 ++++++++++++++----
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  46 ++--
>  .../net/ethernet/mellanox/mlx5/core/lag/lag.h |   1 +
>  .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  12 +-
>  .../net/ethernet/mellanox/mlx5/core/main.c    |  26 ++-
>  .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
>  include/linux/mlx5/driver.h                   |   1 +
>  include/linux/mlx5/eswitch.h                  |   5 +
>  10 files changed, 267 insertions(+), 73 deletions(-)
> 
> 
> base-commit: 9700282a7ec721e285771d995ccfe33845e776dc


