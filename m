Return-Path: <linux-rdma+bounces-16014-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA5QGWE1d2nhdAEAu9opvQ
	(envelope-from <linux-rdma+bounces-16014-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:35:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E81BB86151
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED62130067B7
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B326D329C6B;
	Mon, 26 Jan 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q2IdmYck"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314103064B2
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419946; cv=fail; b=DaIg5/21DP51GDiaDELB2lPwuLE5TlIQbjoEqHAGG2BVI8B/m7dg9mwpwK3HtdggqS33luBuTN9bmit5sMf0JdTgKvuJ5ntAKfSlVz0Q/Ws8J01z2jwljAYtP2h52IoS5lQKkc7uI78yxJEmkqqrnp8UdC/CY36VJgngOFbYZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419946; c=relaxed/simple;
	bh=r88LWLGO2zcbdLrif4zvwrOvZG3kvwO0c1C+TpYwgNw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CxREhyHJp4Eofi3I86ew00uKTCNkHLcVpxbnfzxBdc7XwtyPVDsLh3eaioEh5e+outL+AvsEoSw2jWsKYMbPjhxA/URb+VTVS6cGrSfnXqfexK6ppn7tcdmun4U/em4cJsg/1fHAQiQgINLuZMCgMKwe+hOj2AqozjEfmxAZDgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q2IdmYck; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6CUcMm+I+dNTcgQfHmYogYeDFew1cLGlDxr15fBiu6gg+cB4KRHM5z8njmRzvs3BqZYudmmdsvbi6hwZKbJmegfyQNjZ/uImxsuItNA59597i/abeHAM99jBMlSk5RaM2RIT+sHwnLoAbojrAleaBe/+k5FW80fvZitZPBYOgSnA8HgN8WWW6HVfryoX9ngJT4c8ly3BXpATDXXjbUj/yuKrk7jqjdnLTp6Zkn6jMoFZ0pb80xTbt0BBNQShYUgxFtuPjjLGLSaN0HPe0eCoSWerivU0Qb0x5uGQcq+Ywb/d0conXqs77dw/oFlfqMNGOFHtFI4OuVP+Vp1lBOOPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkGbz0JeQie8Cfq/T/KY2KiJqJkpeNg5u0CILMjfOfs=;
 b=sxE3SqCo/wJ+4fIBtGr+G1AzB6Q617UCCPGJE5pVGDZ61ubvOWhdgugfJ72fsBbVQql1T7ltmhwIJGy2lB+tFhZ/aqgkBpH2lwO2RGutlX6/Ee8ONRBvhPlBUl6tZWKZxfrigngjH4G6/jv2LHETf48h5dbyVbcRZ+xUl9zXk5Wm/2AkBx5qUzfPCxaHrbkvC/oyeO/uRfFRY/I9NMfSvkfOcZLobTbFHQgueBxF1LGZZXZsvIC6HmA2FgD9L20TAZboLBHrgnvgyl0gao2cODlLeUwthYVURYLhc/liXCkfKk6mJLnxaXn1+SEg9TtaOI2P9LFx/Wzl9wYJI/bWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkGbz0JeQie8Cfq/T/KY2KiJqJkpeNg5u0CILMjfOfs=;
 b=Q2IdmYckSD247+6owAMoDFaZ/2UNonEpEP3hSWn5SHLfQFSHBrMvYkmIdDG7TJvwer5tymX0AiojtYfm5KdPQ+zLBFtI3J13F4I03fbnp0Mcy7I+dByUxTndvj4L9TATnSY59KXLtZweRq6bhQe4HXNFhd1UQDYUJjl7xCOCq12onB/zm/i3kPnsWMmVA/WuVZaB9YjMu5EfV7hYrjEl4tcVYFL7ybsQgcUxiennwyS7m9rC9X1xoRzbd/fVG4lN75qvgLNWvmxi1kC96nqa4lWoN0OaXJlUdMQ5HF4074cQGXePKlsWuj7iGt9PDSexyP8aGLSotHwNr+oPz1ovAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9700.namprd12.prod.outlook.com (2603:10b6:930:108::14)
 by SA5PPF8DEAB7A29.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 09:32:22 +0000
Received: from CY1PR12MB9700.namprd12.prod.outlook.com
 ([fe80::fcc0:ffdd:dcaa:22d3]) by CY1PR12MB9700.namprd12.prod.outlook.com
 ([fe80::fcc0:ffdd:dcaa:22d3%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 09:32:22 +0000
Message-ID: <8ff2f0ad-27c2-4446-bb63-d500f5e8201a@nvidia.com>
Date: Mon, 26 Jan 2026 11:32:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: Use mlx5_cmd_is_down to detect PCIe Surprise
 Link Down
To: Jian Wen <wenjianhn@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com,
 Jian Wen <wenjian1@xiaomi.com>, linux-rdma@vger.kernel.org
References: <20251009142326.3794769-1-wenjian1@xiaomi.com>
 <20251009180244.GC3899236@nvidia.com>
 <4b9216b6-25a7-4684-9301-c8128f794541@nvidia.com>
 <CAMXzGWKbt1+U6O2EUuzFRbbUc7Qx7Xy+2+1WCk5_OASejJN=JQ@mail.gmail.com>
Content-Language: en-US
From: Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <CAMXzGWKbt1+U6O2EUuzFRbbUc7Qx7Xy+2+1WCk5_OASejJN=JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To CY1PR12MB9700.namprd12.prod.outlook.com
 (2603:10b6:930:108::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9700:EE_|SA5PPF8DEAB7A29:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d79fcc2-eef9-4eb3-b4ad-08de5cbdceb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|14052099004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmpTdXoweHVpRDBkSGdCdjl3VFc0QXJLUkVKa1Mzc2t1QlB3d2hwSjVrWjFG?=
 =?utf-8?B?UU54NFFOMEdLdTBuZHZDNzQyNkNlTXFtWDhxTFpUT2FjOTZqYmJLcHhNS1dI?=
 =?utf-8?B?N2xJdVdtUmFCdUJISWtNYWdVYTlQVklrcGVzQTNPU3dqQXVGTjYyRWJEYXFu?=
 =?utf-8?B?Yit5NFl3T2poMzNvd29jemlGYnIzQkpHdlpBZnh4djhIUHVkb3Ayc0FlUlkw?=
 =?utf-8?B?QnYwT0R3L0pPcEhpVDNvSnNzanVVRlppOXFzeXRsSW9Ncm9RYmgvazZ0V3Y3?=
 =?utf-8?B?dXpDYW4zbzdhOHdDbmFvdXRKNmZzWG8rd0REZzJxK0FOTmQwdVVmMk5EV05z?=
 =?utf-8?B?eDZsaXR4THlRYVFsS0JDUVlzUVkwUVZHY1EyNmdOdGJiZ3QweEhkQkZkR01o?=
 =?utf-8?B?WVROMTBWWTFybmhRK2pVUE9zR01aV3FETGE5N0JLYUlSS2JmeVVES05jbCtK?=
 =?utf-8?B?U1g5ajFQcm9ZYTRRYmVHaGFmWDR1akxFWk1QN0Z5SzFXQ1YwdXpNNjRkTTB0?=
 =?utf-8?B?N3c5S2tnejFRdG1QVnpPMmR5d2orcHZlV2liVFBUa0ZXQmRWSHkwNGI1d1dl?=
 =?utf-8?B?QXNpemRUdEMzSGU5SHgyUXlsODZrODVoc0owM0tCTmI4b0Yyb0dwWUxKbWlF?=
 =?utf-8?B?K09YRGwyTm95c1dUT1k4eCs1NFpqeU00eHd0NjZxU3Nhc3ZVZXJhZXU5RzdL?=
 =?utf-8?B?aXVxNDZhcmJxdFZpblpXaENQNS9yS1p5czc3ZXNWaEVGVHI4TmJqNDV3OU9J?=
 =?utf-8?B?UVhkZ2Z1M3ZZY3QwcGU2MU5BUTNLNlhwWmd4SjJOTXBYd3g1WEVmOTVmcjZ4?=
 =?utf-8?B?Y1Q5S1M5Z0t3eHV3dU9OK2RQWHhqMm1zSUdZbUplTExrTjdMaE0zeUY1S0Rk?=
 =?utf-8?B?ZmQ4TVA3MUFRVmVRakZxRDlCVlBlMlZYaWpsTnJ6MFM1RXJwanlzMEw1RExX?=
 =?utf-8?B?TkhuMHlmL3NaSmw1aml4M2xvamZXVWYrdS9OL0xhcTR3ZkJGTDJlRCsyUEor?=
 =?utf-8?B?bUtNaUNSNWZCSk0zZDJQR1VBZ0JVYi85VmlkYjNYK2lLRlVaU0tVWjh2RmVy?=
 =?utf-8?B?S3Q3Nkd3MFRyYmdJakJScmFlek4wVlFEcDhZNUZtbFhXQXFmQURDU21WTjRm?=
 =?utf-8?B?VWl5L0pkOUNua3RDaEFJOGhYWXBqTzZidzlGWHo2Q0NRSWFDODJLY0NlZ3NV?=
 =?utf-8?B?UXZ3QlAwS3E4MDVYM3NZVC92bVBtZDV0ZTB1aWxsb0N1c01xNnFRWEcvRWhz?=
 =?utf-8?B?dklvcENuZVpweXcxVEx4ZlNDT2VJRng5V3lsZ2xGVHJiYkhrc1l0YW9kdU5Z?=
 =?utf-8?B?VzN0UHlDaHRVK0VkbVFjTHlGb05rdlhpcUZFOE5HTjEzajRvTkFZeXhoaG5q?=
 =?utf-8?B?aWg2VlRHOHliQmppMmR5YTFoOGY0c3QvaXdaMTRPQVh4Ymk5NFFUbGo5M0h0?=
 =?utf-8?B?c3ZjNHVMKzlxQ1pZeExxL1dCcEhWbERTa1lJT01KdjBkZWNBbjhSbU9JVXVZ?=
 =?utf-8?B?eUh5SlpLUjhFZG01cXhvWnpnM0d3YzZPNVpMdEhaYTlRb3JyRExrb0krK1FW?=
 =?utf-8?B?eWdJTndEZm1IcDZCOHVRc0plOXJXallRVzFZbUp1SW1wL05udFlza042d3RN?=
 =?utf-8?B?Tk1ERjJrVjg4b0VjeDNBZWw1ZTVCMXNvSG5TVEUrY3RwY1dwOERHdi9uU3F4?=
 =?utf-8?B?S0dsVkNRTjlRUTltOUFBUUZTaXFvUWE1ZUhPMmN5bkljWGhJZGFJOURTOUQ0?=
 =?utf-8?B?cEVEb0lNYTVMYVN2OGQ4dGtaaGlpYVY4ZzhvSU00UWN0bWlBWjJPSjMrT252?=
 =?utf-8?B?WEpTbDFGNEZuNTZySlVWeWFSWE9DckdMQlVwcVRwd1F1T0FSQ1R6T3RXZ3p1?=
 =?utf-8?B?b2E0QnBnUjhYOUdwNkFkMmdVL25TMVlDUXJxT2J0bVpNRTZrR3FHVWc1ZnU2?=
 =?utf-8?B?TUZiNWdlV0U2WDdvSVpaL01UclBycUlsR3pWUEpUR21CRVBHdWFOSmwwbWFD?=
 =?utf-8?B?NTQrZHhEdEIzTkdWKzIrc0VpUm4vQ1I3MzROSXE3dSs0OGFIMWV3eWlXY1Za?=
 =?utf-8?B?eWZJanc5S1hiOEx2aXhTcEFISFZzeGVUYjJCZUl0V3gxWkxWdUx6UEJNVnBL?=
 =?utf-8?Q?sRxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9700.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blAvTEJlWEVCd3A0dUx0Vm9ITGxBejlFdHhNTEZZT2drZVR3ejhPTktqWnRI?=
 =?utf-8?B?RFBScVV6aUtpeTBvV0F5UWFYQ294UGhZQStKY00wdm1NVGZUWmczaFdIWDky?=
 =?utf-8?B?RWRYT2I4V3dhZkFDb0U3YUEvOVNBOTJhRFNsUkRXYU00VUNlaUhDUG41QTFG?=
 =?utf-8?B?MGRzNitYVVppc2JXZUV0RStqd1RLemxGRXVtd3BFOWtuWkkxSGdzWjRxNzk3?=
 =?utf-8?B?SkJHZG1JZHN4a0k1aHF5WHRjRFkxMHVYdFJqWHpjMGVPZ3Rsc1FmOWxNSTJm?=
 =?utf-8?B?ZmtDM1AwQzkyQjdtMHlzQ1NnNFo4RUgwMWU2Tkt6MXZXTXZhRXRCZWVyeXdE?=
 =?utf-8?B?TDZ6T3lvZmhpbEJYSmlGcDNBOThPWm8wUzlUUGltQmF4cEhZRk1lRDNuMEhs?=
 =?utf-8?B?VHZoTUg2WW9adkk0Qlh6TS9tQXJhMnllM1Vrb20rT0h0VGRmNVdQYk43bGg1?=
 =?utf-8?B?dDYza05ZUDhOSVhsRFBKSmZ4Yy9oRDM2NjlwQkYrMHB3VnlEMk1BWGpITnN0?=
 =?utf-8?B?ZDd3aUQySlB0VFFsQmlNK0x1emdGeTVvL1JBSERuNmoxc0hBOEhXVTlGTXZF?=
 =?utf-8?B?L2Q4Y0JqaTF4QlRFRnlIOG1mb1d4OVhya3hhaytTMm43dVdpOE1qZ1RyZXRv?=
 =?utf-8?B?Sm5jcGZUYUF1R1I5bmVuUEFPMGNEY2NPeDloK25GQ1kvbDgwZjZpM0VzZXBh?=
 =?utf-8?B?dWxybHdQT2ZNbzZNUXpiL1lrcEdjYVFrdUJPeUhzUitMWEYveG1tRHZrc2Vr?=
 =?utf-8?B?R3dQeEl5L0YxWlNpb1c0dTBrREZCamxLQy9HK2QveEhidVZ1MWtBdTYxQUY0?=
 =?utf-8?B?RHpObno2a3d2blhkeCtNblgrNVByb05idDV5SU1lZGJ5M3F1aUhOK09XbVZR?=
 =?utf-8?B?UE12UVZHR1NXTWZReTNwdDBvTE53VVZLdENtTy9YYzYrcWd6eWFHSE1TcnZp?=
 =?utf-8?B?V2lyNTlTUnZqTERYYm1WRnc0N3FHTUhPbnBZUmNiWFFTNzNsZDJzTk9GcitI?=
 =?utf-8?B?UnBoajlhM1JEc2MzeDRKVkxMR20zR0JhTUhnSXAyZytpbHpnalk5cFhtWFNV?=
 =?utf-8?B?bGNyMlh4WFpVbTRiK3JLYUJqdGZNcDBwRnZsV1dmMXB6NkF5UWZpWGxyZ3do?=
 =?utf-8?B?NTFMajg3Z3UzdUlWck92RE9CV0VzbXBHRWFBZEhjYmpNREdZNVhURDJVTzNq?=
 =?utf-8?B?aTdiTUVuZ2RrbVJtZERHL0pFYk1jWVFQd1oveXMwR3NRNFBRNjY1bVI3N29l?=
 =?utf-8?B?QXBCQmVENU1vVVdxYU9kamRVUkN4Q1k0ZjBhV294WlorMlVYLzlMUEhDNTJk?=
 =?utf-8?B?bHdBamRhV1ZEMEtrWXF1NWF1clhzMXFJekVCVHhGUS92NXk1QU9KYjhNVnFP?=
 =?utf-8?B?Z2g5UHMvYm9KRmZmTW15MEQrVlZSb3VFMGk5MlVZUU01dmx0SXdkcGVPUFds?=
 =?utf-8?B?RVJzSlZtVXk2YVp6bzB2Rk5jZkg0NWJZWnVYVjJWOTR2LzZ5MVRySmhJUG1B?=
 =?utf-8?B?TmVCUWVBWm5VblpXY0N5WUtHT1ppQmZjeGVNVVFRN0VtcnFubjhsYllJUHJL?=
 =?utf-8?B?b0RkUGpJY0kxb1cyNTBXS3BFdFN6RVVEK0ZwTzFjVjlEQjlLcEZwb1RGZVdH?=
 =?utf-8?B?VVpNVFhWSEt1YkRBNjVQeTNYOGJiVUZheFIwVk1BRDdUN2piekd5eUpyMlcr?=
 =?utf-8?B?cDRHK0t0bWp5clhEcE5qSDVWVERmeVpPYXE5cFdpRjRqM3YvdDBOTVJ2ZVhL?=
 =?utf-8?B?ZkxJUEhNTklEWUU2bjEzRWszL2FYYVBvMlNaZ01SYXBaNEZZK29paU1HRTJk?=
 =?utf-8?B?Y0RvSnB3TmtCdkh1WURadWs1NENqTXR0NlZHdVRud1pkcTdTR1FHL0FjTnZJ?=
 =?utf-8?B?ZHVEQytieVViL1ZQVjBndTFmdUxRWkhNQkFSRDdaczZmVzcvaHdYaENUcVlC?=
 =?utf-8?B?MnNmSFlNRFo4b2FoMTZ2TEFta3A3U1F0OU9FbkhXWlFuMmFRbWJJdWFXQ2VY?=
 =?utf-8?B?Zm1LNE1UdzJ0cFdMbVVPUGJyQTE0TjR6TVk0d1RhR3hZSE5qSTB5RnJRcEpz?=
 =?utf-8?B?RlphS3B6NGxNd3JRcHUvYWJRYmtRSloyZmZDYTZQUnZJWXJTVTBuTWFhNlNQ?=
 =?utf-8?B?RzlnQ1BudkFsdWJGQ1E2SE1ZcUpKdVlOU2pQMUk1cGhmeTZYbzdOYlhzUUNS?=
 =?utf-8?B?eHlLeGZUcGRtTmlvU1M1SFFHYnh6SjJWY1JGb242NUxwNWNUOHl1NkcwSnYr?=
 =?utf-8?B?VHJLRy9oVnRwaURiZlZEcHZEWXN1YnRhVDZHakdENG9tT2tHSytpWWptc0ho?=
 =?utf-8?B?YjEzbk4rVmpqL1JwY0VCcU0xSWFSMkNtY1FuakorVDZKTTcwSi9Hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d79fcc2-eef9-4eb3-b4ad-08de5cbdceb3
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9700.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 09:32:22.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST7xyP+GKEcwRRuSRTpduScDQWCmK+3hLnGh0CYxou9iVvRJZjzPapq4lrl/DTldSwwTVqvMLTto3cZBvSjN+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8DEAB7A29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16014-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msanalla@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E81BB86151
X-Rspamd-Action: no action

Hey Jian,

Yes. This is the fix we went with ultimately:
[1/1] RDMA/mlx5: Fix UMR hang in LAG error state unload
       https://git.kernel.org/rdma/rdma/c/ebc2164a4cd431

On 22/01/2026 11:36, Jian Wen wrote:
> *External email: Use caution opening links or attachments*
> 
> 
> Hi Maher,
> 
> Has the fix released yet?
> 
> Thanks.
> 
> 
> Maher Sanalla <msanalla@nvidia.com <mailto:msanalla@nvidia.com>>于2025年 
> 10月16日 周四21:32写道：
> 
> 
> 
>     On 09/10/2025 21:02, Jason Gunthorpe wrote:
>      > External email: Use caution opening links or attachments
>      >
>      >
>      > On Thu, Oct 09, 2025 at 10:23:20PM +0800, Jian Wen wrote:
>      >> --- a/drivers/infiniband/hw/mlx5/umr.c
>      >> +++ b/drivers/infiniband/hw/mlx5/umr.c
>      >> @@ -254,7 +254,7 @@ static int mlx5r_umr_post_send(struct ib_qp
>     *ibqp, u32 mkey, struct ib_cqe *cqe,
>      >>        unsigned int idx;
>      >>        int size, err;
>      >>
>      >> -     if (unlikely(mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
>      >> +     if (unlikely(mlx5_cmd_is_down(mdev)))
>      >>                return -EIO;
>      >
>      > I feel like this is just changing the race around..
>      >
>      > The removal flow for the device is different if the HW is working
>     than
>      > if it isn't.
>      >
>      > If it isn't working then the removal should disable and cancel
>     all the
>      > UMRs, using the umrc->lock. Otherwise there will be dead threads
>      > floating around. It should also be setting
>      > MLX5_DEVICE_STATE_INTERNAL_ERROR way at the start of removal.
>      >
>      > So IDK, maybe check mlx5_cmd_is_down() and trigger the flow to
>      > activate INTERNAL_ERROR befor doing anything else?
>      >
>      > Jason
>      >
> 
>     I agree with Jason concern. While this may serve as a workaround for
>     certain cases, the race condition still exists. We’re aware of this
>     issue and are working on a proper fix. The intended solution is that
>     when the device enters an error state, the UMR state should transition
>     directly to error as well, preventing any new UMRs from being posted.
> 
>     Maher
> 


