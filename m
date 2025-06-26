Return-Path: <linux-rdma+bounces-11670-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16587AE9D28
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E121C454B6
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA6276048;
	Thu, 26 Jun 2025 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NMbWuOuk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D617BA1;
	Thu, 26 Jun 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939140; cv=fail; b=HZuIg1L9CKDs0imynD9OPo2bitn1BB+sQ3F61jEzGz5d0lgAiiBBp7M7VEXJia0mEESD072Av2Haae1l1QkoG1t/Q0VLo00jU9jwuNCmt+KTm70mEOM74fCD31SbhpWiCkTSM9Z1Fd0xJWGEE0Kkmxe8pe3+eKL2CPR7Jwoj4Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939140; c=relaxed/simple;
	bh=dD2+09CKuEr+yhckXcWHvDNVTEEfCtN2sa651IQiyFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k3lN3ybnZEpJf4em8nLXKK5aw+sH+oIH18PKDKAZGH83JnNGSzq764cLi1Z1oS0dZeoVfrsRgtjfAJgwyoo/LWIHCy4UTfHZt66+d9rjJZB5k2S/4vSrNgGlrBisNMSQO99oisx1CPcPxw+No2tIi0cWW/RpRXtTwZUdI8Cv7Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NMbWuOuk; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ci+vjW3a/7Dy3oew+uKSPF+3lTMgROi5FXRnGzjNgQnHdyWhGqrORP5Flen2flbO+cpxQkDVpepL2VJJT1krxOKK3tA8qdMUjOyBXzbvwSslHA4fhB1T3RKDBN3RGJWXs1dHcWx0ZJ2CBVLVg+317avPjzW3jdOfOd/rtgIavddSt9iwmq54UmWT146si3xhBVlL+1u1Jk5olExAK1eeZGIYH4VX25QjaHycGlmCR3iLCsWV1QIIU+6hlhsH8pOfVRYWiF6iRfiSTzflRtT98mRKDYbDYc23WQhBSK1IgMJBDV6rDzzAhn96mKt60YnyEnTgfvqOk+n8cqkBYWzARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/pNT9/mjyVldFSSekUjm/SBjQkJTqlumXFcONTtzqk=;
 b=m2BMiUnK0WzzfYMyijBnLkJmkJ8J82mmpD0jRIydpPREzM01DTcht3OUJYITzXr6xTnM5YP+QTGOlTDqc0t8rf7Fp7yEkHOfgy75Mt66zsSMesJJ/azv4Bd1+gewUN5xnHOpWuCqVnzsHvjl6DhROFNSpGZD4CPVPMdj6KDZI5W+chqbcSUoyHbNZABdqYaGZF2efQ9pTZz77kxalqh942RvfdlL03W1BEW/Pmmiiivf/wWxPIoSyLW+l+Ph+nnu80fPtIEUNc+Cl93CqDk4cMsj2/TeQnbZ1IL7d8SAnTVUONW0Ht4zWr0Kx3tO0Ib3E0VdPhv7XVBThNAwmEX2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/pNT9/mjyVldFSSekUjm/SBjQkJTqlumXFcONTtzqk=;
 b=NMbWuOukx2BTa9gGiojrdAgdE3Hn6fwcx2y+rJvkrgjc2X8SypSYj93aiMwBXyMD6Dm+tOZHjQiLFsi86PGQfqmHvpcpUlh/OqUwJ43QBkJW6CxNic4ME6m8EGtMP8BPGyjkU03yxKipy2i4PQizGqEwsgMYCxk31TqudJKZnEny0EdLkqaVzS15A8kZ1K9VceZcMngW/I5kj3Mbn6NQUqN3J8wAGPn/E7Ke/u7HbAwrnW+88jCF5+2fe7w3WVECIRwiwRoIQWWBFA+IMYgU4j26ksrB+DBSa6N7ofzbQjD1/4pR7A00g2E1S0TaJuS4S1C+zVpDMjG5x1rYY8qxtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 26 Jun
 2025 11:58:55 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%3]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 11:58:55 +0000
Message-ID: <2fc66048-36be-408d-a79f-0393ce2b4040@nvidia.com>
Date: Thu, 26 Jun 2025 14:58:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
To: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org"
 <leon@kernel.org>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
 "shayd@nvidia.com" <shayd@nvidia.com>, "elic@nvidia.com" <elic@nvidia.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anand Khoje <anand.a.khoje@oracle.com>,
 Manjunath Patil <manjunath.b.patil@oracle.com>,
 Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
 Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
 Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
 Qing Huang <qing.huang@oracle.com>
References: <f4e25a98-5d50-4c9b-b891-c4ac042debd9@oracle.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <f4e25a98-5d50-4c9b-b891-c4ac042debd9@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: ec818b63-52ac-4ac9-3535-08ddb4a8d32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBSWWVKTFpiU2xHWGlld0t5WVlsNXU2eDdPemxpbTdtMzdWcFBpbUFCWjBO?=
 =?utf-8?B?cVhwU0I3YjI5TE8yMnV3WEFkeDU4cHV1RkpISllyV3lWMXdNU2Zsa3ZTNUho?=
 =?utf-8?B?TlRHUi9QeVE3dmlWU214RVo4OHIvUnB3L2x6U3p5S0RxTlJaa0QrbzZaTnB4?=
 =?utf-8?B?Ylp1Mk9KbmlUaEF5NTdJd0IxR2kyM3BraGJHSFpWTVZLMFNLUEhUTEJvSGdn?=
 =?utf-8?B?QVVodTJaOTlRaGpLeWtJRCtXeGo3NkRDNnd6aENsNEY5clZaYmNWSVhwVkp1?=
 =?utf-8?B?dHlBUkt3OXhLL0NzclRFOXlhMXBsMXBFblpCajMxT3ZzNmRwbndIclFIZlhX?=
 =?utf-8?B?T0JWNmJ1dWRjMlYrVlB4cDBYVmNSQkExdDhzdUpaMW15clNxYm1SUDBkY0hF?=
 =?utf-8?B?eUhkUUZmZlBUQkhhZHpHN2hRMSt1d1RDUzV4bXp2ZmhuYTYxcmtLdElGcXlk?=
 =?utf-8?B?NThuRUc3eWMraHZlQ3pFMGM0VU1ESDh0RHZRZHpHSTNJMXVzZU1NYXhnNHpW?=
 =?utf-8?B?RWVzUmxWNE9GdHB4QU96WjdlM0Nab2RyS0JSbzA1RjNLVnBsRFVIOXJBQzVo?=
 =?utf-8?B?MHluWDVEdUFXRVM2SE1Vb01zNzBtNGtYVG1LRGNqT2IxT0R5VitrSXZUbFFQ?=
 =?utf-8?B?ei8zSUoyV2NBek1PNlZUR2pENXVKT2k3L2VTSEhiWGxlZUNFRXF0b1pHNnZ2?=
 =?utf-8?B?TDI4RmdERlFzOXp3Z2g5K1lBQS85OVBhVkNuM1oveEJJa3Y5NU1hU21PTVkz?=
 =?utf-8?B?L0pCQWNnWkR2M2owM09ZOXJUeGJVYTJiVmJZMldWdEhCNTNIVFIybi8vV2xo?=
 =?utf-8?B?cnN0TDdpbjZ4a0hpSUZSeVBnWHpJNnp1NXRnNzN2c1hzNUZmN1ZYUHFQb1FW?=
 =?utf-8?B?RnQyRnBRVk5DTjVWbjdrSjBaRGRxQmt1K1NCUXBTU3pzZGtjb0QzR2poRFh2?=
 =?utf-8?B?MEdybThtZVBMbTd6UnFqTmFTdU9VSXgxYUtWZGhLUFMzaUEwZDYzc01RTjVM?=
 =?utf-8?B?cWphb1JNL3dJZEVzbWU4RFhWVytLbVRNL2xnYWIyOVJ1OU1QT3VzbFc1UVRw?=
 =?utf-8?B?elBFY2NmM0lraXg5RG43cVpYOGNCMzIxMVNHSmhVUy9WbEdVSVhKU0NEcnFE?=
 =?utf-8?B?QkNMYkNLam8vYWlFNVl0M3JHVHpIakNzTDRsTGk0MW41aFZJUUVHNTJBWGxr?=
 =?utf-8?B?bFhZL3oxUm82a2I1U0RlWitIRmNNemptNGxhdUNLODIyeGZsRFZhK3NYcU00?=
 =?utf-8?B?bzJqanR2QVE3TDQ2MzZXVFJMQVN0bmFSSkhLYkNjczh3MFIyejVTV1NJNGtU?=
 =?utf-8?B?dG9XdTVUSmxOVlR5b2dwSkdjaGtTeTF6TG02SmZKcFJkd2VBM0lhWUFDWHVH?=
 =?utf-8?B?aVp3NUVQWWF0b1lXVWhRQURNY1JNREJURUJpYkFxYWZ0a08vN3lhL2dDbkdh?=
 =?utf-8?B?THY4S0xaZHA0U0ZaeFdPN2FjNklZTEdPbE81aEZ3WG5lMjI3MTU5YTZvY0th?=
 =?utf-8?B?ZlBOcG1lTWtLK1BTamZtTkJiUHpHdDYzSDRmaFZWUWMvUWhTbGN5T2JYVktC?=
 =?utf-8?B?a0lzNloxam9RK1VWcGhUL3VrbFJVNnlTN1huYzJacWNVVlRIQlFwK2JDS1Vk?=
 =?utf-8?B?YzdaQ1Iybm9iSkJKdWNXV0ZTTktVWDdqd1VaY3ZCQnk3ZUZJY1pSVE93cTBy?=
 =?utf-8?B?UzRyZm9Zem9XSUtPR0c0SFN4RjYyTDRPa1RHYlhXdEpTbTNQeFZMYi9mdHpp?=
 =?utf-8?B?Y3JjTnhRUFEyT3ZBYTl2Z2NDNXgzL0JLNk9LQjhPQWV5MEs3TEEweFpnN1F2?=
 =?utf-8?B?dXBjUGZtL0tSLzFVWmRZVnZXdnRUUGk5RHJTSHFNTzNXWWNJYVRIQVd4UmVJ?=
 =?utf-8?B?WFUzY05VMUU2em5INnNKVTNlZG9mcWlRUmlnN2JDZ1puVTlVVHBXRGtHb2w3?=
 =?utf-8?Q?McMUXHDgAhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHA5NU9IM0pRK1FSZmVMb2wyTW15TC9DK3FDc3Vla1cyTjJvZWRHRjdCK0R0?=
 =?utf-8?B?MjllSlo0MlFOOWJCbWNHbWg1ZEpGcVM5WU01Q2FoV1NKOEgrSTdOWlQzalpH?=
 =?utf-8?B?dXVoTy9RN3B0TFkrRmIwTkc4aC9UbkltSDRIUTFuOU5WcStqdVpkZGVIbCtZ?=
 =?utf-8?B?UVB1dG9xV2FHRGVQUzM5WDd3M0JRQ0Ewd2RxVVZJdnlWZWMyd3IxZUlwZzdT?=
 =?utf-8?B?VTJMMjUxUHBaNTV1NlhFUUVXVks4S3J1RW1oNGNkUVI2SGZGM1ZpbkZvcUlH?=
 =?utf-8?B?aEVxK2N6dnpOcEVLRStnMnNWSnpaZ20yVUc4enlLKy93UlBkbXVENmdYdmdE?=
 =?utf-8?B?cklxc2dYdEtHTURlT2pUQXczVUNVaHFvTXZpbnBnRm5WVUhDR0NWdUJKYWc2?=
 =?utf-8?B?UWE4T1kzSnozOXN5d1MvdTFLcVRpZFFiN2xDWjNRTVZzTkpXVENuUEJtME5j?=
 =?utf-8?B?TzZzQXZ6ZkR3V2szc3p4TEQ1N3R6S2hDRmd4dWRmTUFvMkhqN3Axa1ZhVTNx?=
 =?utf-8?B?K1I1TDJ4cUlWNENLZzl6cnV2VlpJTEdSSmpHZDdzL0Y3UC82bWhJQ3QyT0lj?=
 =?utf-8?B?NXVLNTA1MjBRa0czVHFwSDZReUt2Uzd0NklUdXU3MW9obFV0REw1NDVDTkhm?=
 =?utf-8?B?ZlJuRklJcXBZV0tVNWZ0dVo5Y1lJSkFlQjJ1T3JlaVlEMmZybjFoSHdlSlZR?=
 =?utf-8?B?VlFpVExPV3RQUU0yaUZ5bWZVTUJYN3pNdy9ub2hNcmFqZENOZ2thMHp1NXhx?=
 =?utf-8?B?b0tMSWg4NEZzUUpBMlJWb3J3czY2NHU4UHpGRmlGelMwU3BPS0pGUldYN0FS?=
 =?utf-8?B?ZUxqdlRZanVGcVZyMEFJQ2x1RFBkVnVTL3hRY3YzNWRlNlVtVXZsTVVSRHFo?=
 =?utf-8?B?NGNOc3pEeVNsWjk0ZWZTYXlRWFU2TGxqNHR4ZFNveFJ2OVRsREp3cTFCbTlx?=
 =?utf-8?B?S2NCSG45VExVL0JWN2d1SGk0b0RqMkpabXBPbFZNQzlMNWVOemR3YldtVTA0?=
 =?utf-8?B?UU1zMktUSC9zOGJKck85ZG5vWkdZTHZyQjVXd3M2WDF0QTlhd3I4ZDJlNStn?=
 =?utf-8?B?RUVCQTRxUUx3QmEwYXFkNlQvVWJSSGZwUVB1U1JLN1JrYkhCRGh6azFudEtO?=
 =?utf-8?B?UXhFSlhwVEVTVURmMVFvSDVzaWp2YzZZcFV2QWRQcStNY01WVVkyc2h0VjFD?=
 =?utf-8?B?MEJGQjJEbngrWnh3eUxrMWQxYkJaak52WnpkVENMVUVTcU0yZ1RGM1FoalNl?=
 =?utf-8?B?eHVTNGdMVzNiMzNBSDZCbGMzYVl6V2JsdERwc2d2NFQxWVVMVWpNOFBzL2Z6?=
 =?utf-8?B?ZXFqV2pUcjN1TGtKVU1FTVhMVGJtTXNFM0h2NE0vK3RCdDZySDRlQitRQlhM?=
 =?utf-8?B?cXpUTGw4dTlWMHoxbUlUSzZURlUyRjMwdll3L3NzZnYyZ3dmVm5TOG9xZ1Jh?=
 =?utf-8?B?R0ZlbkoxL2E1R1k0bzNuVzFNMFFGdUJOS0pIeUNkcGkvUXRZVitWSjFDUjBH?=
 =?utf-8?B?MnNSeC90STFtZmpFL1RrYUtkZVlGNkFSVVZVSEFhcGpwcnNGTHZQMHViUGl4?=
 =?utf-8?B?Qi90RUdLVDNXM2dlUG5qaUNWSnlFcE9WR0tXZi80aDJXQ0ozZ1NELzRpTEd1?=
 =?utf-8?B?dzZlYlRaM1JEZCtsaDZrKytBYmQwMmFiWHlKSkZHNDY1Um9kQzRSU1V6N1NB?=
 =?utf-8?B?aHBsWnhrMkw5T1FQbzM0SUFlelI2YkpkcTVITEIxdDFTUjY0bVp6NWdVd3pz?=
 =?utf-8?B?cUtocTZBeXBzSHdlZmJOM1RidlJjUDFIVlgvT2JUeGx6TTRIbWkxWmREM0dw?=
 =?utf-8?B?ZVRpVks2ZUZ3NmwvT0dHYlFzN3pmM04zaHM1bVpoMytDeTdrODF3Mml6SDZi?=
 =?utf-8?B?aXNUamx4eG1reWlGZ1l3cmdLMkpTTUVZVjd1bnVzOENNVHkxOWh0a1NkeUV1?=
 =?utf-8?B?RU5LQzd4Y25XZytLWXVHNG1NVjM5TTVjM0U3MU1NRzBsNlkrVmZnRmZSOFRH?=
 =?utf-8?B?NDNoVkttWWRneXdITWtra1pxdTMzRmtPOUE0VWxTem1uQUE3RVQrR0lmU0hu?=
 =?utf-8?B?M2xNRnZwRkN4TTYzOGpDSDJzeDlzN083YVFNdnpvdXRWbXhyOGhLNktnOU52?=
 =?utf-8?Q?W6AjeyAvg2AhVK3UgNOQWPbq+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec818b63-52ac-4ac9-3535-08ddb4a8d32e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:58:55.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwVAa3iM4tr36g6Q9yuLFAppevSCMl7qFBibXphtP9zD37EKWWgXUvTYmW/jQv0u/+Iogc8KcAuvK9OUSXb7yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284



On 26/06/2025 9:04, Mohith Kumar Thummaluru wrote:
> The mlx5_irq_alloc() function can inadvertently free the entire rmap
> and end up in a crash[1] when the other threads tries to access this,
> when request_irq() fails due to exhausted IRQ vectors. This commit
> modifies the cleanup to remove only the specific IRQ mapping that was
> just added.
> 
> This prevents removal of other valid mappings and ensures precise
> cleanup of the failed IRQ allocation's associated glue object.
> 
> Note: This error is observed when both fwctl and rds configs are enabled.
> 

Please target net and not net-next.

Mark

> [1]
> mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
> mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
> mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to request irq. err = -28
> infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while trying to test write-combining support
> mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
> mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
> mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to request irq. err = -28
> general protection fault, probably for non-canonical address 0xe277a58fde16f291: 0000 [#1] SMP NOPTI
> 
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Call Trace:
>   <TASK>
>   ? show_trace_log_lvl+0x1d6/0x2f9
>   ? show_trace_log_lvl+0x1d6/0x2f9
>   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>   ? __die_body.cold+0x8/0xa
>   ? die_addr+0x39/0x53
>   ? exc_general_protection+0x1c4/0x3e9
>   ? dev_vprintk_emit+0x5f/0x90
>   ? asm_exc_general_protection+0x22/0x27
>   ? free_irq_cpu_rmap+0x23/0x7d
>   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
>   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
>   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
>   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
>   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
>   create_comp_eq+0x71/0x385 [mlx5_core]
>   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
>   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
>   ? xas_load+0x8/0x91
>   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
>   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
>   mlx5e_open_channels+0xad/0x250 [mlx5_core]
>   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
>   mlx5e_open+0x23/0x70 [mlx5_core]
>   __dev_open+0xf1/0x1a5
>   __dev_change_flags+0x1e1/0x249
>   dev_change_flags+0x21/0x5c
>   do_setlink+0x28b/0xcc4
>   ? __nla_parse+0x22/0x3d
>   ? inet6_validate_link_af+0x6b/0x108
>   ? cpumask_next+0x1f/0x35
>   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
>   ? __nla_validate_parse+0x48/0x1e6
>   __rtnl_newlink+0x5ff/0xa57
>   ? kmem_cache_alloc_trace+0x164/0x2ce
>   rtnl_newlink+0x44/0x6e
>   rtnetlink_rcv_msg+0x2bb/0x362
>   ? __netlink_sendskb+0x4c/0x6c
>   ? netlink_unicast+0x28f/0x2ce
>   ? rtnl_calcit.isra.0+0x150/0x146
>   netlink_rcv_skb+0x5f/0x112
>   netlink_unicast+0x213/0x2ce
>   netlink_sendmsg+0x24f/0x4d9
>   __sock_sendmsg+0x65/0x6a
>   ____sys_sendmsg+0x28f/0x2c9
>   ? import_iovec+0x17/0x2b
>   ___sys_sendmsg+0x97/0xe0
>   __sys_sendmsg+0x81/0xd8
>   do_syscall_64+0x35/0x87
>   entry_SYSCALL_64_after_hwframe+0x6e/0x0
> RIP: 0033:0x7fc328603727
> Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
> RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
> RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
> RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
>   </TASK>
> ---[ end trace f43ce73c3c2b13a2 ]---
> RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
> Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00 74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31 f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
> RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
> RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
> RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
> R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
> FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> kvm-guest: disable async PF for cpu 0
> 
> 
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
> Reviewed-by: Moshe Shemesh<moshe@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 40024cfa3099..822e92ed2d45 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -325,8 +325,7 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
>   err_req_irq:
>   #ifdef CONFIG_RFS_ACCEL
>       if (i && rmap && *rmap) {
> -        free_irq_cpu_rmap(*rmap);
> -        *rmap = NULL;
> +        irq_cpu_rmap_remove(*rmap, irq->map.virq);
>       }
>   err_irq_rmap:
>   #endif


