Return-Path: <linux-rdma+bounces-16763-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ASpL4yAjGl9pwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16763-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:13:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5BC124AC3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2235D3015D1A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Feb 2026 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65C32D7C7;
	Wed, 11 Feb 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mgNAHQLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013001.outbound.protection.outlook.com [40.93.196.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FC2E414
	for <linux-rdma@vger.kernel.org>; Wed, 11 Feb 2026 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815625; cv=fail; b=WHknn1bETgXqCHlbmgj6OcWrx68iYmMLaOc1YaA2G9yq/o27aurV6z29AzkI0qx5f373Z+SdHjOOmZzAm9BnoBp0fau83Z2go+BA5odunCZpaIE8o9ZQUNnLgcbkminsd62paQvb/ci45eSkBEY74pMv/RxgFQqZ2pYAWef7evk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815625; c=relaxed/simple;
	bh=qUJnoCwnsHhhT7Lrmt09EsmPb6Hq8RpRMvCw0GIyiyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MxFdgUa+ASEp6feF6MiIz3HnCRsP5IkkxUAvOWQSakif/e8c3/w5xNJW7iiKoSi2hWG/INoAdbmymUTS2DQhKinzoHsvG91edWKx2TyId2Ia8oFJevrTlY2Xg1t5E09S7MqVH5iI1uI3xOFAxAEJKyMIpTQytC8GBbdB86R0OP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mgNAHQLm; arc=fail smtp.client-ip=40.93.196.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU9sxFqpQIULjdDheq/BsjEUhrSSmROiGoEmleV/fT8gT6hdT8eao62YqP/2DuzXeG5rMOSJSf0xvf2ZQxSA4RcGCG/OUL/VusCif6sK7x0dZBsy/h6x1agjUIcka95NxpNXIQgnlShfXupT3iKOPy2TWh29aAfkLcXfdZekNbIg7LN6EdixB+smWeC6Gj/QTwY4f51f1aP4/8fqc2nHdCG3UJX83usXRlre8b0xfgnoBHZi6HYNRHFU8Vdk3fR4zt17ev6zV9jRDhdNQ6mGw/InfHyCKe6A7Tp3FUvQGcPi9gcQqe+qvT8mDKQbGqtFEf3wZ4MdyNHF3fGIARPcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfvMGpxVnzkRUrsd3avCXnqTQfp/9DjEfizOaFC4Hu8=;
 b=M6RwgdxikyCGyp15iTzET6b6Lmh45+cudvpsqwQIMPNhBjM91S/pQJ+7wCEzwWp56vGrLawpQwhQmaPwYaArUXk22oAfrumqrPZuv2PcbMLRM69JbW2A85hAzC9oAw1CL5TeCoh1oI8ttdedj2vGnIeSV+z3EkxSrHkr/3xpJveOQYbAazATcPzTqILVkuIfT/kOTTxCaGGELZOJXuJuNSjilOJU8pLZFC23Wk4TZPQDVbOwKEQQr7Ce8Of+EIvTV9qu+1MB+MdO4966Au7NRJ/xkoL8xBuwr8p+rVTpboV14UtCJTPNFjBr8Bo0DwKYWPcW1uzZslP8qHEi9Z6U9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfvMGpxVnzkRUrsd3avCXnqTQfp/9DjEfizOaFC4Hu8=;
 b=mgNAHQLmqvSM1xcUvwZCa9Q6mFxOS13skxzP/9UNM2mV8xaM+hwZBd/OaSjtE4wABJbGCARl6JL+iD8qx/wW57yJFNUSElokylRns80Q4SEvAuaJY4lzI5yx2xlUwIg6hNMV0FDLVE/Y4uU1MJfx5VzIaHOSsY1GClMYkzb3KmKn1Ge5k8buJoXbVmExd1aae22U9jxmAZqQ+BSI1nJbHmuQL0IbjKMau+gO8x9wK0abfFWtJeVA3VxLMsczpmvRbn/qeYzBILtg0sT2OmJuM/TIPikkKMtE0v2aX/EfP9Q4rK1ieL3szlWfFDoh6FdnhvkBnXFvkHSM3auf0xpD7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 13:13:40 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 13:13:40 +0000
Date: Wed, 11 Feb 2026 09:13:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tom Sela <tomsela@amazon.com>
Cc: mrgolin@amazon.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
Message-ID: <20260211131338.GA1218606@nvidia.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211131048.36217-1-tomsela@amazon.com>
X-ClientProxiedBy: MN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:52d::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c2f9bd-6274-494a-bc30-08de696f5f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bIM0sbmnUDB1tSldwnfNUY220W6dQ70bg0GgskUirCx0sHYzmU0P7iZQOBCa?=
 =?us-ascii?Q?qyEGHcFId2ZoNRLrlWdG12ZVideTg6vZSKjihVtc+SbZHZtC4oPPtDAWDcmj?=
 =?us-ascii?Q?wQGCKgR1v2+jJ2A+LNyUBhLX+1eFOsjY9ueyspnL4yiVcNQI0yLnQgwLJm32?=
 =?us-ascii?Q?iefp6PANoFrZgHcu8MeTVchc9rlvPXsfC5WfQCPqtLBUwFIKAkwPsC/QTeeF?=
 =?us-ascii?Q?iQ2hIotw14qejhOJo6PcgVCTz5Gt1O8V0c2eC+eOuRjHjjooCqKXe4VWdWyM?=
 =?us-ascii?Q?F32UWuliWe26qteiMC2b1wfW0gs+8M6MyJJYWPAvyXvhpPGOGyDIBhsuaY4R?=
 =?us-ascii?Q?GIWvFZtf1RXbOEalYOJr52OD8aejfiURHhbyoDFkzsxOV6t2WXvC4uQAR7tf?=
 =?us-ascii?Q?lykd84gdGWfUbhp2A6mQcCTddXLGvNBNpmtEJcpPHWcf7gwJWiILxCMxOxpl?=
 =?us-ascii?Q?YlPNoXNtZXyhOwNRXbEelRxSuX866XKSoNn0Zz4shEecqdsTSJYsTdougcSq?=
 =?us-ascii?Q?h0lu5u2e98Ls1TKgMlb4DoQQrxSkmAGHRy0exDOkgmZ0Qsn7PTZY5LG1zss2?=
 =?us-ascii?Q?fhF3OqdlctVEn2yE1KUw4DJFtQMvqzK/JdvbuRbsTQkqZga55A3JSZHBCP6J?=
 =?us-ascii?Q?1hJDsdm7sGXHIPRzGwkXWufrIXvd4qkzRR2E5hMVMBqW/EhcRqFUXhHHKxjP?=
 =?us-ascii?Q?P5skHzsWyUIbTiEbuaMkyIYIXCOQZDJCdJdoGyQE0Ip4IEGskWNFbE4UZP0c?=
 =?us-ascii?Q?4Sl7poa6g8M26ma584xa8yHKebs38UkiRaooxQBTEe1WJBfSYgG0zO2vcXOV?=
 =?us-ascii?Q?dj1G4hhgxUpQGOobdkPoE/286sIeFu8eTO0ZiB66Wt032AQAwSUYgcE8oFXM?=
 =?us-ascii?Q?RX3GMTd5knPUKpLEyGmIHW2fYL71HSsdrAnHMhXgJavFidvWTEivUsoRPNKs?=
 =?us-ascii?Q?j2d+kxl+Rplg6SboKGXIoiuKMccRV7GBqdnXDckdfnwdQf7FoCQlssPpr1+C?=
 =?us-ascii?Q?9E9Jiy6N7+8BRswv4Ad8ttvIJNosNPzJNNSECMYnKalbWEM/kwb3JgxJgfP5?=
 =?us-ascii?Q?Dev23wTZgQxvv4oxul+/KszXiShiOBQNNnj5MecvtnDOCfu23AG3yNax++yL?=
 =?us-ascii?Q?qvhZg0k+23wjGQCBvhKtDnoGh/IdYAPqqendkEW9YUph+15l5HbD8m9aHRfZ?=
 =?us-ascii?Q?gAeAOQi1FqOKws0VJPjzcakEbwYnBuZnnKJxM2duQ57oeL6w44BQrMKTntT+?=
 =?us-ascii?Q?NAJVqLIYvIDyyY3d1Npk0c2/uyjpoQfrQGkFCdGgY+ZR2UHICmGtI9YOc5IJ?=
 =?us-ascii?Q?P1YFfjeLDdsUKFkLy5zjSvptIKphRj4w8eQln5s5h7uf7zBBdjlyCmRG+JBO?=
 =?us-ascii?Q?B8X4LYuS7hbT2L+/+RPY72emRaBDgInrC3Lhuya+9EkXTBJ1aylYiY17pjb5?=
 =?us-ascii?Q?PqxQOIEYXanhjJBAFo7YuU4wq+hgOTWSWEC5oZTd3ku86p3kUB+c98d78baT?=
 =?us-ascii?Q?dzFwFcAY8u8nyXHBnn6FVXklHc+cwtUxAHeRm6mBwuNwxbjhTLBx7z62EPYA?=
 =?us-ascii?Q?shbLuH8pbmlwyX1jxrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?do996bdIkS1/BlkVYqM+1Ln5Z+nl9kmw/6FIwAlOY83W1s+GNIoC1mIgU0bI?=
 =?us-ascii?Q?LSNtncUukyvKnwxST3mIAmqvWrsTpHGP51NF6Ip/8h87Z+Xpxeq606tM311K?=
 =?us-ascii?Q?u40/jKL4tIklK0LHH1iwnm+g38YX9djh4xat4ATV6JfUa2hboLAkxeegwwxX?=
 =?us-ascii?Q?3b/tM1kHmYpNlzNxVkjgYsjFiOQbM9pgJQotpa+LsYc5k5efVwtfpG+v3cpc?=
 =?us-ascii?Q?QkdROsoMmTYIiFXL1F961KmXjSXkDoVe+G+jDPex69C2mUWQnWkHwtSq/VXQ?=
 =?us-ascii?Q?qy041z5W5lgX7c8nWXVD7QZyWdqiNzIiEIeJQ3rS71Z/r/wFA/X0IYowf6Ja?=
 =?us-ascii?Q?usXtZAKDRmrhLw+B4lzbYxF7K6Ad+GLjroamLKmu73o11GQi4URpcf6dRtep?=
 =?us-ascii?Q?NYYVuNijV5JPySo6NZU++UEY4KOvp+iiNy4VXKy+jthPI3UIQsimWpoTeojF?=
 =?us-ascii?Q?JclnXxafPFj0jxwOCLS6RD0iejleoa+WSeNKdRu1OqgRT8xtWVwraGrXCnCc?=
 =?us-ascii?Q?LJbG1d3uEs7k5so73/WXUkzROZOJBId8OUrkG3fq63Oqbu4mzMix/TyykCsI?=
 =?us-ascii?Q?sF5fxaNZxUn6FSI3UdoEITjUKqoNhikGxDqkmS86MvB85UzpddftKDtkpH7s?=
 =?us-ascii?Q?r3GIqxOTIBASiLMgUezf9SL9JuZeyQgjPFKv4HIcAHcWtERDLS8e+fAsGMGL?=
 =?us-ascii?Q?n8GVfAVVFp8Ojga0jqnkW79UGrYgXhra9GJ5IOWXi5M1i2v9mXwH9WFKpNuR?=
 =?us-ascii?Q?ETDzcs/OjGSVzMRmCwO3S1Qs4aRQUz9c9ahloQ1yf6WBfCb4cyE1YhFaVpXy?=
 =?us-ascii?Q?E87aiXIu742h3slCRcbfSXTboKY6xmY5Cw5vS3XVBt/Ab87HzqlDEaVU9m4J?=
 =?us-ascii?Q?WHtmB5z6j2/d3yaBvJuocPg6MLprq1rEHTTRvAEAcxb+WPqnbFc3DlHDG0ZM?=
 =?us-ascii?Q?zK2Iz36fL6vJUPBnEjNtbdu+7X/dO6/sKUN6+9xM/6qIaoAyrj0edDPUNLgd?=
 =?us-ascii?Q?zEmsFcanG2U1M/I/5/eDjMRC1lMudSGnbvIexSCmN57t2TSBTE7hLKYeuyo8?=
 =?us-ascii?Q?cVHCkKa3O5w5kc8J+gG5XHCfUysXm9yz+QOydadz8pXLxdFZIzVS53hWVv5t?=
 =?us-ascii?Q?EGuymOvTU8DDHuH9IlUnV7EG11clODRqq7ZB+7Gy8RktdzWXyh4W/4rzDsbD?=
 =?us-ascii?Q?cPUZVYPjh1+ylaxkJ5UaeOHr/FWgf3sdAqowG01ELrXfV5q1u75lAUvBTUT/?=
 =?us-ascii?Q?ErnngpwbQ4OwgCBHdlyt67TdqMuXIKUbJmHKr1t4BBRYMtIwrxndo43pdNXP?=
 =?us-ascii?Q?IxMuNZ5OIzWj1nj0MYLPaZuTX50mRTecKJbPB36b1gKFI6QaJiThMt75q3/S?=
 =?us-ascii?Q?AQO9TLIQMKQHAxg7ghQmk7g72nkPe5EpG9dIWCgJS2h8nmxWFshCXwpkGto8?=
 =?us-ascii?Q?Ygva3FG/ie/bvxgKjsTnMcL/tSm13/pP32+fhIa5aOZjjWDktqidA2ofllyT?=
 =?us-ascii?Q?rmJXA+UbqwHdgEsAuOWeozcNZqLGc4tRosRoiLIWDrac+0ioTT3a5+Vic6fE?=
 =?us-ascii?Q?mYnPJhQ2gwL27WqmyJzNQlHfpJWI0dEASxPT7AL47P9TDHH4Z9TXGtFxRHKH?=
 =?us-ascii?Q?Q3YTpwTBnN1J7htMcuhzwfhP1BJeie3lxN0OU2hw1U0jwLBLVKp77NEB5zGq?=
 =?us-ascii?Q?aLrdceJCC5rla1hGRw5uU4z4t0mE+uAb4SLMJzuBiRoCHQ4zwV0rgvQy3uYM?=
 =?us-ascii?Q?nM9yHc6gnQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c2f9bd-6274-494a-bc30-08de696f5f85
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 13:13:39.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Cmq77bjAZ2ckCcBNnEIXJTUlofY4zU3oE3tb4i7tjmDM6wc0nk1aM2Hc1BJQEo5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16763-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B5BC124AC3
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
> +
> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
> +}
> +
> +static DEVICE_ATTR_RO(ah_count);
> +
> +int efa_sysfs_init(struct efa_dev *dev)
> +{
> +	struct device *device = &dev->pdev->dev;
> +
> +	if (device_create_file(device, &dev_attr_ah_count))
> +		dev_err(device, "Failed to create AH count sysfs file\n");

This is not the right way to use sysfs in rdma drivers.

Also we have netlink counters as the prefered approach why are you
using sysfs?

Jason

