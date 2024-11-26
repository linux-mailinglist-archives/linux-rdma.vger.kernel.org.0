Return-Path: <linux-rdma+bounces-6096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC19D8FC3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 02:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51E1D28AC9F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321F79DC;
	Tue, 26 Nov 2024 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyv3+Gvt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AEEB652;
	Tue, 26 Nov 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732584110; cv=fail; b=BU46Zo18XYODvID+QcrAdECKtZBVv7qiyM59RzcdLa6YJfKRCG2UJVIdJ/M1Goqym0xP6C/2ojTyP1Ro4IflJOWv+JALmC7bIUf707GhYo/Q/xtmZY2b82AqbJY3srFSYrbLqPArDIhKtmiDIhwZ4OJzOsZs4s85r1i9XMdGRcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732584110; c=relaxed/simple;
	bh=8AjNaRU8ZvZMy18QM0uGoAXkzuoL3cAxFT/ZIUij5Xk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t8QltadlMz2g+Sij79stt7p4tAggUTeg/mz8H+2DkkR+HETbNtuzbLvxnl1/rix3+Sn3Xya03z1olDYDgug33YWPizvYVdMQSQJwNrFrELrR2+urLSCcZqMrc9QJAqMY2JsF37VoUDxXsH6kYDqbWzuHrX3GpF5uPre+g0MfkF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyv3+Gvt; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0+RBoysCAHWBlSxAWs98bFUBjptZLQz0YmP4oUE02VpBISg+kI4zn7k9H6JYGxWYlGQAPHNzaOUDLqn2SKELQgC6/3MiOEPQQXxzc1jO1/LXf18lq5pXVsdS/xvvty6UtgsIi7pcYX3RPEPZY+4X9P69msTCNxf+r2zkHx3u1wyV927PTRegCQ9K59BX0Oki23gYJq+IAKxHlgz0rGObyLvDMWcKZeF5fsnGFVN3EmMeEXAYBQYY8ut3LZLWgMvIoxBKOjUBtszKolV4R7kPRaoUpDss+GiGPYuUWb3XPLeHbbrhwhN/8qEvzGTHix4pqxsF7rhzPkmX6Qjinbjkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tjWnF90Hc6OwDVzawNPXmeIki2Jy9rOAlFwBwDfPp0=;
 b=R/tBDIsMWY1/kAqbpQqfH8Qwzd/HU9XNjXe7bPwcMHLhZRS0O7uxDbrnEzG2iGSfDsuTst2/bqFblU2R7B5zccv4btrocdC6zHdKDgnAt6wMUFiwJjQkvj8FAHo3cJqlbsd6kzXYHy4G/83reSO4+mKmY4HtVwh0EjynGyUo2702inkj2gtbBHlDqZNEcaBPWGbftOD8gK+ARPxRiyqnx7BDrGXreHrRcRMXEY3+AYxilqYp3xFELtV77IXOaIkLAp0uXZMk0OERzuSsyZdPQMPkN3V0p5Ai/mpFeVqR9lI6WysrXSbADR27W4nOz075mqrtq/OmPlRu1dEDEY00XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tjWnF90Hc6OwDVzawNPXmeIki2Jy9rOAlFwBwDfPp0=;
 b=fyv3+GvtIm3dMZmqWV8a4HtrY+Br5kaBuEE3rbvv+wK/4IZQcYfTNvVVtNcvGMkSwEH+W2ufx3b0gqeM0NsXgObAzgL49JHq9VTdW2qIR9G44i9HgkYqTI5Xk3bEnzBv85n/etphLIcZrDox9+MEsptMdS6X0qPAnYcmaq1zqApSEIQO0BdvvZKla+VHxy8OF6XRDOEYeiPBOaeWLtnEYdSkzrXNzWoll+sG4BKrPLIwQFMiDxNAMv7JtzOP3ub0eVA35gMwepJqeuJTUn1skv9pOVqzdm8Ip2uprIPQ/REOMsZy4QPri1mweuB/Idc0za9m0Gi9TYeKfJP1d27mvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Tue, 26 Nov
 2024 01:21:45 +0000
Received: from MN0PR12MB6341.namprd12.prod.outlook.com
 ([fe80::4cbb:90c1:e4f:38d5]) by MN0PR12MB6341.namprd12.prod.outlook.com
 ([fe80::4cbb:90c1:e4f:38d5%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 01:21:45 +0000
Message-ID: <cd4ea02f-bcb8-4494-a26e-81cdf6c684bf@nvidia.com>
Date: Tue, 26 Nov 2024 09:21:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1086520: linux-image-6.11.2-amd64: makes opensm fail to start
To: Leon Romanovsky <leonro@nvidia.com>,
 Francesco Poli <invernomuto@paranoici.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
 1086520@bugs.debian.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
References: <173040083268.16618.7451145398661885923.reportbug@crunch>
 <jaw7557rpn2eln3dtb2xbv2gvzkzde6mfful7d2mf5mgc3wql7@wikm2a7a3kcv>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241113231503.54d12ed5b5d0c8fa9b7d9806@paranoici.org>
 <3wfi2j7jn2f7rajabfcengubgtyt3wkuin6hqepdoe5dlvfhvn@2clhco3z6fuw>
 <173040083268.16618.7451145398661885923.reportbug@crunch>
 <20241118200616.865cb4c869e693b19529df36@paranoici.org>
 <nvs4i2v7o6vn6zhmtq4sgazy2hu5kiulukxcntdelggmznnl7h@so3oul6uwgbl>
 <20241125195443.0ddf0d0176d7c34bd29942c7@paranoici.org>
 <20241125193837.GH160612@unreal>
Content-Language: en-US
From: Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20241125193837.GH160612@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To MN0PR12MB6341.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6341:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: a71bbbdb-931a-417e-d72e-08dd0db8b0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bitDcmpYWUZXRWZDOU5FbFoyTnhxL2UvQTlnUGVkdktVeHNxV3l4Y2RlMHg3?=
 =?utf-8?B?UWRZcmVJcHkwVGZDWlAzRGFTSEhLSWFHdlFBSHdZenNXcGg1T2cvSERvdDY0?=
 =?utf-8?B?cjcwdWI0ck8vb2hMVFJzaW5sd2RwbU1qNTkzQmhFalR0QnAxVWZaa3doUXBt?=
 =?utf-8?B?ZXJCRkd0cW4wdmdQOTNGd2tEd3FuNzdhSk9RR3pLcmxaWStWWTM3alFhU1Jv?=
 =?utf-8?B?QnhWVGNVR1FEK2Z6UnpEZnJHWTdKQ1JQbGlmKy9jNHIvTnVLY2lrVzNyZjhU?=
 =?utf-8?B?eWN6bU9iNDZNZzhuRkdHYzR6WHA1TndCYjVRT2M0eG5mUys5OGpHZjRpQ3VQ?=
 =?utf-8?B?Mm1GMXd1emhrZ0pmdWVTUmZnV0xOSEcrK3RYOEFUNzdmekF4K3RITVB0c1Vj?=
 =?utf-8?B?K1Zzb1FiU0NZSWJKdFdNSW41VmlzSGV2OGZIUmVuTjZxMmJYSXVJMjh5MUVU?=
 =?utf-8?B?aEZCQTFZOWEza1pVU2s2VU1OUHA3bHdndzFYK0laa3Vjd2J0VWN1TTYyODVU?=
 =?utf-8?B?VHdKWFdwSjVzbWRVTGFlMXU1Qm14a2JsNWFGN1NQdmhzLzVuZnM1aVkyMUNF?=
 =?utf-8?B?S3gyNnBFUWsyZjFaaWRhUVg5eklJNFNNLy9aY2JDaEZDNjJjQjRiWnQrTW9C?=
 =?utf-8?B?ck0zQnVQbXFzbkZLUy8rRE1hOEVnK0lwZmthOVU5RFltQjIwWVQvQWo2eDVi?=
 =?utf-8?B?dG1ZeDVST0lPSkxZb3RySlpSc3VsR1RQa2NWaUNtZDhKZjdTUGRURGZ4TlVx?=
 =?utf-8?B?TTFGa2tKOUlOOURmVGl0YTVaSGxoNGVBSkxtOEJqOWpteDZhYW9EQjc5d1FP?=
 =?utf-8?B?L25SeFhaRVlWWERKcGtMQzJQekVCb1IrZktWOFB4UldpV0xPMlZWM3BnYnFx?=
 =?utf-8?B?K3FxS3VLWHZ3MzNxbmdWSVFzVEtQRHljL3plV05WbzlZMXAwOCtrNEhFSGRh?=
 =?utf-8?B?US9mK21ZYnE3UlhaclpXdnpiSmxwU3RJTXlpWFdEbEVuV0M5Tk5KVTU0THRO?=
 =?utf-8?B?R1M2cmN4YTRoU0taYnJab0k1V3kzdG9hK1hNZzRNNVNNTWFZdVJxWEExam9J?=
 =?utf-8?B?enpKUFV5RHJEZUc1Tkh1c2xIdGNqdGU0ZTFwVEFRNXkyYWxoZmZEcXliVXhF?=
 =?utf-8?B?TGM1Umo3ZWRUZUthZ3NRQ1d5L2YyK0Rsekp5Wm9hWmRSQUQrRXB0bXUzd1NM?=
 =?utf-8?B?bnFOcFRQRjRGTHNFTFRCc0tITDh2L01KaFFJcVI3VUhKQi9iSGRMVFVIbmJK?=
 =?utf-8?B?TFpWMjVyYWk1d2xaSDgrbnRYd0p6eGc5cTUvY2tmSlBMSmN5cG5KdXVrdGl5?=
 =?utf-8?B?VHhMaFhkNXhueUtsOEMwSE1qYitaWm92bE9MRWtpVmEvQXFXdTE3bmMvb1Yw?=
 =?utf-8?B?R1NpbWlrdWV5RXo3UkMyd3V6QkUxdXJ4Sm5Gb2Ria2IyUlJTbXptZFdFeTVC?=
 =?utf-8?B?VVBrMFRrODJMQ2k1a25VeHJKSGlqbFRKUUp4Qjd3ZEFBT2VyR0dWQ0N0YzFH?=
 =?utf-8?B?bThzRGhzSVBUMy85THRhQzlWcEtTWU8wY09vZDBUVmd2UnArLzEzMTh2MWRI?=
 =?utf-8?B?UWFuWHkxY1dId1dnV1JkUEtlZ2NIdEtLVHdvNnl1SFJoYkV2dHJYVVJtajc0?=
 =?utf-8?B?b2I0aGJINjBPL0R5QVlMMjJSbWE4V1FEMjJCQmM5S3pQOUVqdmxtcnVtQ1Nr?=
 =?utf-8?B?SGtaQU4rTUtsZEVlNllRSFRGZkU0N2NMRnAwTlhwRTU0ZWFmRDBDRk5zZXhh?=
 =?utf-8?B?cHVJd0pqR3J4MlBoVlMxeDJTeFhPSVQ5MDBuK1lsMW9za1ZFa1FTaUNSOW00?=
 =?utf-8?Q?aDggOq6fDzcrZJ3UsLIPFVKMXYyn9Tw9JB5k0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6341.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJKYTUvNG1HRllSYUVOK1cyclJGc1ZpQ2VibDhCaHFNenN1YWFXMHI1UWwx?=
 =?utf-8?B?RGg2Mm9PK2RWcDlBRmgzdzhxelMzRGhNYWJ1QklTM09FbXY1RmpDZ0NDVm9R?=
 =?utf-8?B?Zm1EdnhpOFhHQWlycDNrdG9WdXZpT0NQV0xQZnB1YkdpcWRyalMweFdaejNI?=
 =?utf-8?B?Zytza252Tk5mOHptVWZYM0c4b2k1TllxbGZEYk9JVG5GMVlVMGFWSDE2VDZt?=
 =?utf-8?B?N09DbmdJV0tGcmYwaml0S3ArZkpMRXkvSVdnY0FJM0FUNzNpVkE5eWZXVmI2?=
 =?utf-8?B?U3dEQzVCUElpZFNMNnJRQXlEcExhUHNIRXBjYi9jb2gyT00wbEc1M0tLZ1Ra?=
 =?utf-8?B?T2dHdlFSdW5WNFovMXliSzZUUmdvTGRvMUFiS256MlJiKzBoaTRhMmJzZUxJ?=
 =?utf-8?B?U0lyRStET0FES3dPMkU2Q25VeTdJczd4bFdYMHNjTFZtRnhhZzQyUXB6MHlW?=
 =?utf-8?B?Zjd5Q3E5cEs3aThUZ09aZENDR2pTckZaSlJ1a2hvNlZZcHV6aDZkLzRINys3?=
 =?utf-8?B?QmloK2t1Z2l5Nno4YjYrNjRJTEQ1WW5XTFlLdm80djgySWxhRFQwK2R3bmZT?=
 =?utf-8?B?QnZJNWF6UUErQzdrM3duNkhkbVNOVFhaRzZtN1drMUc5YUFZNERhYzUzazdU?=
 =?utf-8?B?RVdMZlJnaXVSSmtqU0EyUWdZSElJWEJpQ1dFM2xvUnpka0VpdVRJc1EwWlhG?=
 =?utf-8?B?ajNpS04xb3djbXdGRnZhMDVicXJwV3lILzVOM3NrcTVUbjRiL1J1SythcHU1?=
 =?utf-8?B?eFlkdkQ5dEN5Ykp4Ni83eEhyaTF2TmhjUWpMVVN1eGNxQllaOVdabWVjK0M4?=
 =?utf-8?B?cTNaMktIYjZrYVZsU3R2NHNuTHhpQzNoRy9oalpQY3c3TGZUVVpGLytxU09G?=
 =?utf-8?B?MkVQaHlnNklmMkMzZEhkd3dqKy9BaGxMcFhKRXZmaWozbW1ndWxCMjVxRkZL?=
 =?utf-8?B?a0c0NFJvdHAzUlpISWE3ZGNERTMveWY5NFhHYTFuWWdwT1JDaGp4SVVuSWRu?=
 =?utf-8?B?OFVrSmw3aHozN2c5cExSdjNXK1Vaa3NFeHFJeTFKNEhlSDJmV1NiemNJMGt1?=
 =?utf-8?B?cDJHekVjaG1TZFRGUTY0cFlvZTVZQUhsOUpjM0N5OXczeWhINkZYSGxTOGxi?=
 =?utf-8?B?TzdXdlNxcEcwcnJkSG8vU3dGWEsva2N6RnR4RTBCd2VETFZPc0lVNlBvVHVh?=
 =?utf-8?B?d0Z2c1FHajNjT3pwbmYvdDVLbHR1MEY0YWxyYkVvMmxydXFvWHVoamQ0YkpT?=
 =?utf-8?B?a2ZVZWRLeWFEQ1hjaHBXWTUwdTVEZWoyVHFJNWVxcHd5Mjk2QTg4RW51M2VL?=
 =?utf-8?B?SThLU0tmQ0N1SEV1V2xjMXhpQzh6dDlMN0FWN2VTeFVCenlCQUJLMlBtN0xV?=
 =?utf-8?B?YTdLZWxCb2FWWnUvNGtPMzFxUjhaUUFVb1pJOEt2V1B0LzBVNlJoQllKbkww?=
 =?utf-8?B?VlhaTXVPdUEwbCs2dmViYWExRlVjSkU0dUowVS9mL3g4Zzh0YmtSZW9qc0xz?=
 =?utf-8?B?NkpzeFBSajdEbk5LQUlleHF5MnRqTy9vUTN0S1lVcmhHMWw4Z3FoLzFJTnBu?=
 =?utf-8?B?NGNVdUdFa05NZGVWL1dqdlU1aThPdUlJa0s4OVYwakNIYWo1TzFxYkwyQTBH?=
 =?utf-8?B?bGxscWptUUJPVjdPbjdxNXFtZ1c3WEdEeTZLQm1aT1BEOHZNR2tHM1Vmb1lC?=
 =?utf-8?B?ckx5Y1B5VWdhWUsrSXl6Q1JnTTN5RkFHKzFiWDVKUjZrcnJOQ3lOemJFd1pD?=
 =?utf-8?B?cm44ejBWbDY0N3hSRGQzTXNOT2g1NnBiUHlWaGZ6MFZTdnJFYnY0YlJidGZz?=
 =?utf-8?B?d25tR1dTUUU5TlRQQnlCZVM4aHp3MVZVbkY4UGE4ZW9Xc1cyWXNIVjdQU3ZQ?=
 =?utf-8?B?UW9WeGFWWXVmY2tNYm44SFdBZ1RLVXRLb09yZ1dJVWNDTCsweTVxbDNFOWRL?=
 =?utf-8?B?OVNPbTFLS3BGZnpLL01VdHdtakFVOHlyclRMdTBjWk1iRm9taDBSdm9yNW15?=
 =?utf-8?B?TWszb0NUT1cvdEMxZy9jOHhYK0U3c3lpS1JaanpQSDB6aE9ZaUc0SFZscmhy?=
 =?utf-8?B?K1o1Y3RReGViYUVQZkNWYWhMVktYd0U4cnJRbUZJRUZSbnpyMjJzN0l0VVla?=
 =?utf-8?Q?k26Mx6B2CghBU/ApfaQnnaav1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71bbbdb-931a-417e-d72e-08dd0db8b0c6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6341.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 01:21:44.9068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkhqzfoMEkY2IWTosNa/ZCZqIdCRANEQHjnSWGYSr+3N0IvVzX3pYZyxNP19zXSfEC5zk6Gx/eTvlTfSvt96mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106


On 11/26/2024 3:38 AM, Leon Romanovsky wrote:
> On Mon, Nov 25, 2024 at 07:54:43PM +0100, Francesco Poli wrote:
>> On Thu, 21 Nov 2024 11:04:13 +0100 Uwe Kleine-König wrote:
>>
>> [...]
>>> It looks like the commit that is biting you is
>>>
>>> https://git.kernel.org/linus/50660c5197f52b8137e223dc3ba8d43661179a1d
>>>
>>> So if you bisect, try 50660c5197f52b8137e223dc3ba8d43661179a1d and its
>>> parent 24943dcdc156cf294d97a36bf5c51168bf574c22 first.
>>
>> I started to bisect.
>>
>> The first surprise is that 50660c5197f52b8137e223dc3ba8d43661179a1d is
>> good...   :-o
> 
> It is good news, as I looked on it all that time from the day Uwe
> reported it.
> 
>>
> 
> <...>
> 
>> I will try to continue to bisect by testing the resulting kernels on a
>> compute node: there's no OpenSM there and it cannot run anyway, if
>> there's another OpenSM on the same InfiniBand network.
>> However, I can check whether those issm* symlinks are created in
>> /sys/class/infiniband_mad/
>> I really hope that this is enough to pinpoint the first bad
>> commit...
> 
> Yes, these symlinks should be there. Your test scenario is correct one.
> 
>>
>> Any better ideas?
> 
> I think that commit: 2a5db20fa532 ("RDMA/mlx5: Add support to multi-plane device and port")
> is the one which is causing to troubles, which leads me to suspect FW.
> 

Yes looks like FW reports vport.num_plane > 0. What is your hw type and 
FW version ("ethtool -i <netdev_of_the_ibdev>")? I don't think it 
supports multiplane.


