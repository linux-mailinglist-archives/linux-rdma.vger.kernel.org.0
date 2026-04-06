Return-Path: <linux-rdma+bounces-19064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCjFDpYO1GkbqgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:50:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A97473A6C35
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 21:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93BA13019117
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403E3976B2;
	Mon,  6 Apr 2026 19:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bBIBWzb4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F2390222;
	Mon,  6 Apr 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505042; cv=fail; b=ifjGC0foCq9I1rQFKv1FePV0OFqWQ07c3h0EpyL1NVbonoQskAYscUTbh1MFn+mHIQPIZjppVU9Pu7wG4WYk8XfyT9ML9Af5zWKpbd78k7mDUsJ/I8MGiwFEtoc00EPMVPg5/Ot7eQ6ZZv3cfi7pfINK4CljMhZ8bl/UfPYmZ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505042; c=relaxed/simple;
	bh=hckn1WewW3KWidPBzLa2H+PCjkTNmLqKWd2vERHooTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nrl+Up35FJs5gQgP+czARmKuP4qnb4fxg8gE5kPIRBuDbJ65Wcb2FQOYePKndBTrl3C538T4iLAokpWeuKdPeHUTcNzHa0fTwt6fhzzdkG2ZetKCyaxAMDotu34Ugf8YFvFB6Hg+rKvnKD9MhhA3lLv/abzV+TIbGKaagSy9RSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bBIBWzb4; arc=fail smtp.client-ip=40.93.194.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3KxFdc2Jsdswl3mXVnTbNXHDmPKHrQAgXSbFGVObIrg2y7Qm2UoqNhqChXyIiwsYWtmOc53lbV6Y6GbYdJqVSJhhEU+J54bKmhM1SVOSq5pYNwO4VDic8weYB4aSCTnnqYcgV9kzX8BWZs4R5l2DRLmguGmp7c5Zw4gFm0ezFH+4CpUPlw6Fx94FLqVYL5tDymQJRI726eAdmzjqgdoD21oDh9o6DVKA0L08FDcdhzFyR14pebuA/tc9pjjVL9l12jT9cfzMMfgKZtcQ+ddpTVNNmucuuUo4UGBGeyqm5e942Qx0pRwZcYv/e9chnW/QjunVVBHBC8aGlsctXibGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62T1WwBsrt1It85pXELWJLR6+fkZQTSAOo55uE3amt4=;
 b=Ts0vEhSe5EuUmXZ0Pu9Ug05FXVJJO/IUReejuI5mfnO/4mJzCq0hxHsZoWcsea62yigGikr6GnfjSsnVcBK8cvieLj/z/Kv9F7cS/zS13jniVO66xGfKUmZSoJdJIj/g/HWj+v3n7v126KW8AER0X4t2YvtCXdjBH9dcY94WDKybGx46Mo8WATDA6hg+5VYq1SWwmkLrzSK/EDUUCcZy6kUFzYKfVteisbwvqlb1L3RPI41CDhd0CA5dRyDzi+acHbjYzG7pTw3QeTpBizq/u0GX4YzsX4cE+qYCiLm6Br7ugLWcHE8Fp9g7H8Fv2f3xw761fLGEYHBP752m9WztFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62T1WwBsrt1It85pXELWJLR6+fkZQTSAOo55uE3amt4=;
 b=bBIBWzb4j07Wicbam8hPNYGQgBeWTY8P7ZN5h6xQIsZdgod933p4+FBetz1RUpXDO7CKI6qlelfeLKd9q15wzkbJ5CuahbNdA5nUFFYzr+qtyA1fDXuxfe5YLYUEIO+rQQESRZu03CpWMYqpWKtPLNhzuK6HteelbcSS4OwJjXZMaRavhjKPkDJALZnd12CzaTpfHtw/SpiPFHYu5OEt70GrNcIC7nyrd9b1Va20ngXp0OcVuwAsB1K7yJkXpfJxiLy9YKQIitUdE6f4m+ct26HrsVR17a6sjOvZ5wZjS/nIA566qdsiSJ5AuyUUOevnKpxghZBVg/A51GwpY+s5aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Mon, 6 Apr
 2026 19:50:37 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 19:50:37 +0000
Message-ID: <2790d732-0974-472e-ac0f-fded6aea3b18@nvidia.com>
Date: Mon, 6 Apr 2026 22:50:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 4/5] net/mlx5e: XDP, Use a single linear page
 per rq
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Cosmin Ratiu <cratiu@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Lama Kayal <lkayal@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Carolina Jubran <cjubran@nvidia.com>, Nathan Chancellor <nathan@kernel.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
 <20260403090927.139042-5-tariqt@nvidia.com> <adH5yAsPJ8rNgT0k@x13>
 <20260406084344.5d315f01@kernel.org>
 <e0ac9755-fd49-4620-92ce-0f5e4203a95e@nvidia.com>
 <20260406113038.212d91c0@kernel.org>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20260406113038.212d91c0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::9)
 To CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b057d9a-a628-4a1e-8e07-08de9415c601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	D7LKxLuJMdycxMdKN17HWUWL03K03nTLkQjFvJsIlf+YCOfL8p6OPlDH2U9xMz0v9jKQ8Lt9a9nJVuLZ+Ld5/Ewqy9S41owqzqNA8ZuKXzKs12b4fnpbCx7fvqNwi1ERmGHKNEnOsPh5n8IdzXQojGDx06IPk28ciWZ/VoNDvxDOtemExJVkDyWCPtvB6A9hiAgmbWOA1/ADB0qYs/rfdUW5fJCNx39qOTgDWtKrgUdLlVNOCGpgbi4qO1DlgyYi7yBSzUaGe0oeHHfNuA32UI/2KsvinAtQC+3RmxxyuuL1EDPJE6OHzju1cgsJeebQ0awZH/tWWRQHT7OvUfFEvnm13AqqBiFFfMgiUiRTXYDtCTvaUXCTpv4gr3CsnQffCZgeJ7ZJ7MXhKF/a1hYA5vW9Kmv3tXITB7GXuge7SNAwhKFphYWLHg3gmuHoPeKZnSvwF61w0X1x98axZLk4InykPVHCXpAwQGywcmQu3uswpEst7o6upcF2JRexX2dS2P1+iI4JleWfJzqK5/1KgaAgKuCaeC2a9Z+BUkrhtl+IT0jURX0vcarCyZIoXQniDS5xPQLxJ9rZRa50l/92YWonVjSz5P4ud+Wj2zXw8siScXsX7BlKgv0sZZ2Ycqd2ktVa7gkIiGCvL2Vps6r2FQvCZw4JqYKBo+/shLyVTK+X7dVp7Eq3c6sA69Y0tV5Nou5o5MkMLkhIILEwRTFPfmIxos0R6EqC6KLQLwx+z2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWx3MWo2R2w1VkhzU3RlU3NYdVNYbVp0a0dSdHRLRkg2WWRxRVpzR2IxelN4?=
 =?utf-8?B?cjQxUHhjRlpkUTQwSWMrN1VLT1FQaDlHSDBTeDROMENnY05NdlVFbEd1ZUpL?=
 =?utf-8?B?Mno0UmNvM1EwSGVZUXdKN0tzSTY2ckg2WU4ycmxSTGViT2Q3aTA3clRLNXhC?=
 =?utf-8?B?K0hIMEFwOENQMklQOVdVMzNEak5uL2dZUkhvK2FMNUxZSG1ZSlYvc21SUE4x?=
 =?utf-8?B?Rmw5bWZCVVNIOVpFZVh3RjVGRmQwN0VVdW90TUtnK01Lbnl3bkJjZGUrb1hw?=
 =?utf-8?B?aXNkVHhRVkdOODc1WFpNbkVWYjRZRWx2R091VzY2VzAzaXRsYjh2TWZYL2Rw?=
 =?utf-8?B?aVR2QlV6SGs5SUo1U0pDeFhRS3IwNG01VGxmQmUzUTNSMThqOUFPeXhMbGxY?=
 =?utf-8?B?MmMvL3hWNW05T2pDOGFZL05rbVNzNmRaV2Q3M3lBWFpDall0S2ZoOUo5bUtJ?=
 =?utf-8?B?c3E4UlRaMWRZNVYyNmJ3QUR3b0YvQ2ZDM2pxc1BGYjlQbHNsMWU2Y2dKaGMv?=
 =?utf-8?B?R1lmaGhlTEg1dUNsSERyT2FBN01oWTlMc29ld2NxN2tzZ2FjRFpERUdCK29y?=
 =?utf-8?B?a0VrZy9OMU8rSytyM0p6eUpwaHJISXcwOGMrb3V3SFp2bWh1QVMwSzE2ckJi?=
 =?utf-8?B?VXRINDc1dEE5V0t2MmkvUVhpKzJNbFUvelJLaXpjampFeTJpMFdKU1J0OGxl?=
 =?utf-8?B?MXFWUEM2UENPZG5SeXFXSFZPazhCemFBNW1KeTdGa1ZFdXRaODhyMGx5S01H?=
 =?utf-8?B?ODhUR2M5bkxEQ29IQmI1enJvUlBzZVAyUllaTlpJSndCWTZzMmt2L0tnNTY4?=
 =?utf-8?B?NjVaemhMT2NMcnpLdEFHRXE1bkFMUFprSlZib0ozQWkwUEM5eTVoNEg0cEQ1?=
 =?utf-8?B?UU16bCtGbFpmai9yc2NEaXNESXUyTWpTdUZ2WDhhcW9WTjZpRmRvYTVRc201?=
 =?utf-8?B?ejR0QUdQaG5Ma2NjTi9kTTh5bXNJVU9Wb29ORCswVGFzWWNvWjRFb2JhamFL?=
 =?utf-8?B?ZWNnT0NjRGdnQnJqOWxUekxiWVZsL09xV0NyMzgrdHdvRHlxR0xVaXpUb0pM?=
 =?utf-8?B?T0gvc0FjNUlLVXZZK2xlcTFXWHdnWUZjQml2QXM0MWlxa0xnNTVVbVN3ZS8r?=
 =?utf-8?B?VVVHQ0VtK3NneXFQVTZWTEtBcDJrM3Z4SlJ5WTZCcFI3TmxJek9IbmMyU3Bu?=
 =?utf-8?B?c01NcUp0Ym1vZWhGQUxJUFp6UXhkWVQ0QU9Tem1seWpwaHdWbmdwamVuSlBC?=
 =?utf-8?B?Wmw5SEZ1OGhXZkM5c0hZTHU3VjN5ajN3dGxWbGRoMGJhemJpZEgvS3pCRkho?=
 =?utf-8?B?ZzFER0xnc2l4MGl1WlpXdWxDaWl0S29VVi9XTEZvSkd5Vk5ZR1M4NHVpQmE3?=
 =?utf-8?B?djBwV1hOR1hEMHllM2dxNzl3NkhhbXdoVGQ1b3JjTDdTNjIzMkdJdEJxOXVS?=
 =?utf-8?B?c0pDdkpMNXRRaG8ya0tveW5nTVVyQ0l1d2dSVHYzd0pHbmdRNkVvTVY0VUZN?=
 =?utf-8?B?bGJiS3M2WDJ1akJLcU1sVGEzWSs0NmJYZE9QZXluTVJsVnlKbll5MnMwNzN5?=
 =?utf-8?B?bU1Jd2pKQmlQUVpKeDhxZXRLVVpKRFh3KzhlbUJZK3JoSENJdkFobk54ckEv?=
 =?utf-8?B?QjBSMGlJUk5CM0xZYXhFYmxEWkpjTnJLQTFZK29zMExVT1FwRzZmYWV6SG1n?=
 =?utf-8?B?T00wZ0ZmdmlqK3pPT1VWUlNkcHJpY0NkNnlPclRTcktjSmhqR3pHSUc3eFht?=
 =?utf-8?B?VEZ2ZEo4ZXBPeUVIWkJ4cFprVWZiZTJFWldlTHExV1VDeHpQaWNwcDJZL2xa?=
 =?utf-8?B?KzFJb0hFOFRpMTZYTXlyeFR0NVFpL1VVdHNFVG4rb2FvUFFzMW5zWEFEZjZ1?=
 =?utf-8?B?MDF2UFNoTUlOK1h3MlNTaGlNdDd1VW5yTEsxWm5Pd1ppMVVFZUtDRFFxSmVv?=
 =?utf-8?B?SEwyelJ2Z0tlQmpiRWpNT0RyUWgzVmdhc2xJV0xMLzRxYjVuWUg3TjNuUnRh?=
 =?utf-8?B?d01sb1Z1LzVYdU9KRDZBWHhKWUhNTExUcEw4dCtEMUdmcVpjK3ZFOXUra2NN?=
 =?utf-8?B?MnNQL0xKR3pJVEJNdmFIUDFHamJLeEh2a3pRVXRLUm1xWFVvNGNIRXo1ZEJx?=
 =?utf-8?B?eWZIY01rcWVpNGNwUm5JdlUwMG1ZTk13dk9JbHp6SlFLUjc2ZEIzR3YwelpE?=
 =?utf-8?B?WGVYNi9PVU9ONDdWS0Q2clRLcTNTSDlXWWRmYi9kaUVaL2lJS2NweXNYL3VO?=
 =?utf-8?B?ZzAwQUx6QjJwcExLbkxveHRmamNmVmM2STFBbHRDa05GLzgxelZCQW92S0RM?=
 =?utf-8?B?SGVIaXFManhKQmpoWVBjQURPcDViTnlVeVJiTUI3MTVzV0dGaGQ0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b057d9a-a628-4a1e-8e07-08de9415c601
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 19:50:37.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4kpeyZNWBxNZepTP42JPbCvnWCIgB9lzCFK/w5yPAQHkeuPvWuxQStqRE34lyHY8fwEOhdL+W5DwFkxLcFmpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19064-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A97473A6C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 06/04/2026 21:30, Jakub Kicinski wrote:
> On Mon, 6 Apr 2026 19:31:03 +0300 Mark Bloch wrote:
>> On 06/04/2026 18:43, Jakub Kicinski wrote:
>>> On Sun, 5 Apr 2026 08:08:06 +0200 Dragos Tatulea wrote:  
>>>> sashiko says:  
>>>
>>> Thanks a lot for reviewing the review! It takes a lot of maintainer time  
>>
>> Just to add some context: we started running Sashiko internally,
>> so hopefully trivial issues won’t be missed. I don’t know if
>> you remember our on-list discussion from a few weeks ago, following that
>> discussion right now we have three different internal AI tools reviewing each
>> commit.
>>
>> At the moment this is still manageable, and I think developers should
>> look over all comments from all tools. In our case that currently
>> means three review outputs per commit. It would also be useful to have
>> some official guidance on what authors are recommended to run before
>> posting, so obvious issues can be caught earlier and less reviewer/maintainer
>> time is spent on them.
>>
>> For example:
>>
>> “Before posting, authors could run a recommended baseline of review tools,
>> where available, to catch obvious issues early. During review, tools such
>> as review-prompts and Sashiko may be used to assist the reviewer.”
> 
> Please send patches if you think something should be mentioned
> somewhere. It'd be awesome if y'all participated more in upstream
> reviews so that you recommendation could be rooted in what happens
> on the list not just what happens within nVidia.

Fair point.

I can’t speak for the others, but I’ll try to do more upstream reviews
myself. In fact, I already blocked regular time slots each week for that.

Unfortunately, the region I live in has been affected by a certain war
situation recently, and that has derailed quite a few plans on my side.
Hopefully things will settle down sooner rather than later.

Mark

