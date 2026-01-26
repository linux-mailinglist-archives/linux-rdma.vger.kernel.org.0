Return-Path: <linux-rdma+bounces-16041-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLI4AQ7xd2lQmgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16041-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 23:56:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994C8E175
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 23:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58AE5304ADAE
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 22:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F2F30BF63;
	Mon, 26 Jan 2026 22:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ImBZyDKC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9F7080E;
	Mon, 26 Jan 2026 22:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769468116; cv=fail; b=byJXa/SWe25hcZROtNkNTp/125H52G1mYtoz8qFoRRLdoLkWVN2VSTrAN4mu+IZRq9VBthCI/wOeHAgZltDwbrH3OUiEwDKXtMc5YOgV+qqQiz0E8me8OY3BVGgx7z8Q2Q1Lo1D0YBPTJFZLihp14gARaIaN9S7+A1tgKRIfxKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769468116; c=relaxed/simple;
	bh=5gETeWYUfJOfDhvoEaOJYUzEquSdFkAbSGp4Wbnqono=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+UHD9lnGsrlZ6ms0IXiuR1CWzgetmjb/RYblNUwrkN0dVADqHKFRK0TrcvbjF/iGsedubJbx32kTHI6VSmVuHBOfaeiA+J+cUahcW+bLKF5lNLS4IyB/6igGBIrxZNjrd+9KBKQYyWjeiqqX6gYQz64Cq6VZr6j1F7vTL4LVYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ImBZyDKC; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgEwv8edz1cFCKOCWcB2zni+I7Swg3howungsAdVldGg3Dps3SDyuTxll2WBfjssCiE9/2bUdVxgmNCEviTBATuMw1t6XKnSrGUPl07Byr1co/IwPFpaft7lY8hZNDlM0FCVQAXe0Y0axbUSUyuFB9FYHXRkY68UIVxMl5+lIMbVpRRvAMWEoRAzBqL6ZKK3kvnInNC/TXbxriegRtJsDoahSyAChO/lbzGINFCN9b30RnXKa4MpFfyklqO1/CSQkYeLBIAi7DGcrue+XRrqgTfo0YtojRxowBB2UU0Dqnan4ZPcn7kccEWwZjDTS+pjTgWKce+s+h8dO8Dmpnh1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CJk/URBZCmaivYnI0+jBJQWuhhs2HYy/w4DB+BVPiw=;
 b=hac3/iZGIBLX60RYJGEPh9O88eTo1AzF1dsvxYLxFAlFMVhhBj+rKs4v1Dn3pNKu5JYHbkTYaDtqpvLd5yKRoy4Dd8bJEOeAMB6mRM0W2L5CGB9KZfr+4LDlzfEXS29yng+K/qPcnrEzLUMOu3r9/WgtpNdekXp6W+XyO/5Mjdy1YpP+Rl5Z+20Kfgd/afKnrJJWnmc0fOuvpvqx3iB6o/vxN0lYdHn11i6rHIoaqL8gtBjPryItjELfuI5c4Z9d0OmB5W0YRCg6Q/vI3N1AdogOh2N9qWsXxZj9ittOxZuUCJdodzpG5+8spXInbR23kkoIEr+pqg5KWZE2fBKs3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CJk/URBZCmaivYnI0+jBJQWuhhs2HYy/w4DB+BVPiw=;
 b=ImBZyDKC3v7PXZcWM1p3wo0datKKmUIB5siAAygatdIb/yGx6cFx/xm+bkuMpuTJ1ubaG8Ks2DeSMAYNTKXhDeAd2L/vF5sjM3SuF2XpkzBzsW8v6E3R6lj3H4VaN1JjPs63JdSjn61plX2Q8Yl/Y4bzST1KyOn6gym3oGS6v95v2Bc7Z9YgfXyYOswU9A3NSVdXxtaMrc9T1+ktEmYKQ3vYcPAn2Dorcfr8+40aGJE1sbowyTPzUcBlXr8dJQWHJ4/z7l3V+GGc8DClL2FrSq9l3u9XeQV6gLLi1JBobcl7jANJWgS5GBKvRdTi1Q7cReiTFF3Lt2V5cOJlYBH2HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 22:55:10 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::1643:57be:ba7:a15f%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 22:55:09 +0000
Message-ID: <f0b1bc8f-8b3b-4e4a-9043-3b80ede3ac12@nvidia.com>
Date: Tue, 27 Jan 2026 00:55:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next v2 02/11] IB/core: Introduce FRMR pools
To: Jason Gunthorpe <jgg@ziepe.ca>, Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
 <20251222-frmr_pools-v2-2-f06a99caa538@nvidia.com>
 <20260120164438.GR961572@ziepe.ca>
Content-Language: en-US
From: Michael Gur <michaelgur@nvidia.com>
In-Reply-To: <20260120164438.GR961572@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: bb967f5a-f96f-44ce-c7a6-08de5d2df4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG0vRzBrZDF2ODgyVUh5eVJSQUgzc3lMaDlWUVI3T09OZ1ZTN0E1VVgzWDNR?=
 =?utf-8?B?UUJHSHVvczMxTWx1ckJUUWl5dEc5RTFmeGkvTkxQT3ZycStibTRscldwUmtD?=
 =?utf-8?B?MWdteHB2enNDSmR3UUpnakUxeUR0cUFOZE1PS0lXR0NMNEdZY3U4ODJTWm52?=
 =?utf-8?B?czdLck9LVStJaFN2OE5YajNKeDNyOUJ5VnZ1MDI5TVNKdnNkSlEyRjgrR0dz?=
 =?utf-8?B?Q0U5N2E1d0liNkUvZDFFdDZYamJ5Mi9mNHN0NjU5NjJJakx3UmNOQWJJQnA4?=
 =?utf-8?B?S2ZhYUUzMWZ0WGhiUUp4NCtqL0g0S2QrZE51K3ZiSzd3QjIxVHdXM1dOejR1?=
 =?utf-8?B?dENHK3BocHdhWVpVaGlKaUxtUDVtK3ZpRHNWZmlxZ0VLK2FlS1VlbUliUEZN?=
 =?utf-8?B?ayswd1JheVNjTDVYMjN5dEYvUngzY1pQQ2Vlc2xiWUx6bmpuSDVCS3FBdW56?=
 =?utf-8?B?TlROVldWSHBCMEdnNzhtQzZHaWFzWU4yWjk4L0VxVFF4ZERWSzZkcjhOcXNJ?=
 =?utf-8?B?YlhoTmh6Q2xNcEIvb0tIdXRoVW5hcEtNRGZweUFtazIyWDlpMk56WmdZVE0r?=
 =?utf-8?B?L3pxUnlmaTB5U1dLWmJOZ0Y2QjBJcFlieG52dXF1K2x4OWxVT1Y1M2g1aWNs?=
 =?utf-8?B?K2VEWXZzZHdwYTlFQldNS1NSYlhheVZnS2dqbjN1dXc1eFJ2bjE3WDByV0Rt?=
 =?utf-8?B?T0pNVk1pSFNSbXZBTCt1cW9lbCtGWU50WTFWeTJIZ1IyWlJhdk9kZk4waVpP?=
 =?utf-8?B?dk5pZXdlUUhoeVR5S1hUWE5oVjgxZko4TUtLdElBNi8zZ3FyYkRGcGRPdWlL?=
 =?utf-8?B?NElWR202QXhHeGNHRzhwWnhQZDArTTRyTTg5NkRlZVhOZUVHTGRjWWZRakd3?=
 =?utf-8?B?dmhjSHdXaW10dzM1WGxKdnNvU2pISzJGekpnTGdLeUFyb2FUci8vOTVHd2g4?=
 =?utf-8?B?LzBtVHI1eTRwU2hhUUVLaVhpVkc2WEpiWFRoWGg1OE0wT2xJcGsxUjNUOWJX?=
 =?utf-8?B?ZXordkdUaVl5MXdIQisxS01CWGhUMkxVRElML2N2c3VZVU8yZ3BmK0FpWDlp?=
 =?utf-8?B?Q0xhQStBaGx4SzZSdVV1ZDJEVURTUmU2ang5QVpLY3lWNVBDUHZMNko4VVE2?=
 =?utf-8?B?VGYwU1QybEh2Q01TdUNQTWFNZlFnMldjbzRucTE4MGlrY2I0YWpWM2xDcFN6?=
 =?utf-8?B?Qm1OckpMbkc5NmVydGFnVVZNRUUzN0FJeUExa2lRQjJHNjJWcWd0WEl0TnlM?=
 =?utf-8?B?YVBkcHRpSERyNnY5Qy84M1VBK0JrMXFHVFBoN2VSdjA0aERYcEhpdTRSOEFo?=
 =?utf-8?B?QlpmLytLbHRTVlFiby9HQlhocWxDT24rcjRVd3UyTlBwUEJmd244OWlLQUVh?=
 =?utf-8?B?TnF2UEZTMGFwOVpjS1YrYkV0dHordUlJdEFTQWJTc29wZ0RjNDd2WkN3d1p2?=
 =?utf-8?B?anFIVjBBbU9aZitzTmdZUkpvdmpRZkxtejVXNGtzRG9uN0Q5QXBLTjFSOE91?=
 =?utf-8?B?OHMwS0FVM1Z0Nk5XWjRyTUMyRDhIV3V0NG5OMjJxbHNaQ2hqTVpTVHVibExK?=
 =?utf-8?B?cHVJQkk1YXQ4cTRWbGdvWGVscWhyWmttamplRDhBZVI1Y3VTT1Q0OFp3RzN4?=
 =?utf-8?B?WGwxc1QyRDJ5U2l2N3lVTW45dG0yKzJxRTlKeXFRUXFyZDNrdklSN2pJUmFk?=
 =?utf-8?B?SFcxZURvbXJwcGNUV1oxcHYzMkhERXVVMDZpS21taHdObEoxQnBrWURjRFpY?=
 =?utf-8?B?RjdtcFh2NU5PRll4Z2hvaWR6NGd4R1FsckN3UUlZQlZqc2hJQ3ZTRUd6QldP?=
 =?utf-8?B?cU9MK05aYzNnMU1TcjM0YWsySXNMT1huVWtzNGVwUmRDN1A5K1lyaHZRZW1T?=
 =?utf-8?B?VVNOMGQyT3RmZUlLd0lSckhqQTdoMEhqbkwrZ2tlb0NaSnZYNFBqaFFub1k0?=
 =?utf-8?B?eVF5NnBCWEhqWDdRS2E1cEt5OFF4WjdPaHJhS1BjQ2tiVlpkcG1EdTJrTkVl?=
 =?utf-8?B?d0ExeTUxcE9ENjNKSFM3YWhCNm12bk9wVE9KTGluNmdTblJWMHNGd3ByMGdE?=
 =?utf-8?B?dEM1MUk3UGNKT0pqeW1DQ25HRlJZeXkvUEdVSVFXOURkeWR2eDVIQ1J2VU9V?=
 =?utf-8?Q?HZt0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3gyenZ2OTRuT3B2N083RzNjUXVKMVVESTRWYlc3T3pINXVoOEVTMFZyY2hS?=
 =?utf-8?B?V3N2andiMWxUU1g5US9UWlNJTzNkdkdTZGRVN2x3TEg2cW9QS1BPSWo2Z2U0?=
 =?utf-8?B?b3MrY1ZJQTE4Tm9GYkFHQ2JQUnJNd1MrbWFMc25DRCt0VjlWeElETU54R1dD?=
 =?utf-8?B?bmFIWkNVTDlXNmRXdVZCd0JvTVl6QWtmQklZMXFHTUdBMktvMDFsVmhZbjVs?=
 =?utf-8?B?cUpKUGxOSFNLaTJCT29QaG9pNmZXVWJBR1hEZndSVHU3NkhlSDFmUStWZWFR?=
 =?utf-8?B?VmVFeTdMbnN5aWlBaFcyQTZ0NHp2a3JYb2EwUEw1SVVDN292U0tlbDRSRGVW?=
 =?utf-8?B?ZHUwenVZczhZQWVja25qTzh1YmQ3aVZGOXp1S1N0SSthOC91S1VTTHd4MENp?=
 =?utf-8?B?cGFCaEFRS3B3UTZUNjlqVDJwSmVycUNSZHZjRlBISDZLeDZmWXN0Qis2ek8r?=
 =?utf-8?B?bmM2c3hNanhndElnL0ZiOW9WaUYraFZxOFFpOXpjanZOUUxlVnZpUUw1QmQ3?=
 =?utf-8?B?MEc0bExmUlZ3TSs0cGd5NmZXNExyL3FCUHZJVGFoK1RMeTBmNTVaQTJIcnVx?=
 =?utf-8?B?Yyt5OHBReWxXSzJLMUpoRUNGTi8wbW1xTXNtZ0N1UC9aeFNncStKZVAzS0k0?=
 =?utf-8?B?aEkvd01QSm9JdkQyMC9saWtGc0dlMnJLS1l3REZ4bzBOazBvUTdDWXJoM21Y?=
 =?utf-8?B?UFkwd0tOeWh0U1oyWUNkbUhTajNvOUdHQ3ZDUjFMT1NucTJUalFTdnBLQytK?=
 =?utf-8?B?OS9zNWh3aUVBRURvNlpRQkU2WHZZYkExSjdTall4ODJqUnVuQlNPV1Y0Mjc5?=
 =?utf-8?B?UjFyZzR6WlZxeDhFdEVzUVZrNmpobVlOZ1ZZT3FhOG4xWDdMejRlTXQ3NjIw?=
 =?utf-8?B?REdLZlo1NnpBdEthN1dUUThnOVpHLzY3VmNleDJZNmZ0d0pxY2ptZDRIQ0xN?=
 =?utf-8?B?aDk1dWMzck5sYWVQdVl2Zk42R2xYQTZtek1tZ0V3dkFpdzk3a1cyeDdhc0d1?=
 =?utf-8?B?MFNRK0FRVWRrczUxaDBsRlY4bW9xY214bEVXU3ZSRnczQU91TUVrbW9Sa3M2?=
 =?utf-8?B?MytQV1pkbmZRVzZHWG0xK0NGbHk2TENqOGpCemNFQ1FNK0RqQTcvMTJxeS9Y?=
 =?utf-8?B?UHg4QjdkK0ZEd3NFV0ZNc2hnV0IvcnlLajRvWkh1NVNNT2ZONWZzc1RCbXB5?=
 =?utf-8?B?UFVxV1pMVnBQTFVWL00yMjdCYjhhWGxGenJtV3VlbHVSNzQ0MkVhWnN0YjBF?=
 =?utf-8?B?dUE2Mys2V2dnWVdZVHpWalBmZmlXRWpVVGlSNjlFUGllVEVWZXhnczVEOXFE?=
 =?utf-8?B?a0hIYm9kVG5Hc0NuTmpUcDBlYVBocHZ1bmVBZVBla21GRTF5UG5PVzdBRk5m?=
 =?utf-8?B?TFlpRWRIMElFUFhmOHhvMHNpcmNpNWY2anFyTGJlL0JZRkxxYVBPK3pnUk5Y?=
 =?utf-8?B?MzZ1YUJnQ2FEYnB6Y204NmNUQ0dxMXBiMkoxMXcwd0YzdVFReXFHc1I5N2Zr?=
 =?utf-8?B?Y3BQelczNSt3UjN6V3lEcHgrTWM0M2t1VmlpQk1IZisvQVA5UUZibURnM1F2?=
 =?utf-8?B?VHF2L0dZdXlaMzh1MGdnMGRjNkdUTHNHOEFONHplWDM2RDZvbVVCeXUzenNJ?=
 =?utf-8?B?TnU3U0RNZFBWdUFQcit3bzlsdjkyU0xuWlV0YXltYkEzRkRnbUd2c3BRcjZX?=
 =?utf-8?B?My9VM1hWRXFjdHIxZ0dQbWNlVWg3cUJPVHZRUHNLYTljcGtGK0pnd1hwRzNk?=
 =?utf-8?B?bmJCQTZvTSs5N1h6OUt6bVBieWFQSWVlb0UrNGQvVk5xekh6d3NFYUNzKy9L?=
 =?utf-8?B?Y3RyOUZ0cllpb0VDRnhTT0J5d0hwNXhRQTgyMUdTYmhRNDR2QUpxZHdRcWNt?=
 =?utf-8?B?cEVEWTJNU1FodS9BUHVFQS9qWnJOWVdKME90SUZ3MFFzb1B1d1M1MGUvR2xv?=
 =?utf-8?B?UVoxSUJiVGtYekxvQ2RHZ29PMDhCOXV1dVBXcjBYRVJhWWJrRHFlNjNUYjJD?=
 =?utf-8?B?TmNXVWVhRWpJZDNiRlFvWjlYamYrUXdZQngrUTZ0b1R1bVd2cmpuUFVoT1dZ?=
 =?utf-8?B?QjlRUTl6Y1c4U2ZrbU11c1duR2dWc0lFaG1ZU1FBTXYvVk1KOEt6Z29LZ0pZ?=
 =?utf-8?B?WWR2Ynd1YUcwTTVXSHUxWWVJZjlhTHJ0dTl6MTNXWkxCazZKVURQM0ZuNGFM?=
 =?utf-8?B?TWIyNExQRWs4N3cyT1ZsK3lmNklLbk11bHg2YXVJV1JTTnZxeHBPa0I5MFhh?=
 =?utf-8?B?Y1NhVHhnaUpJNDFrdXdJUFFZWTcxUU5ZUHI3UnhXZmJ5UVVXMTJ1NEIxWXNI?=
 =?utf-8?B?ZXVaK25qc3FpRDhqYUZaVythQ3V4UU9ESWg5QzRoaXFRUkl2YkhhUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb967f5a-f96f-44ce-c7a6-08de5d2df4be
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:55:09.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dt/i0+FE07EnjgYL16riYmWuiPXKXgRIz7/4o57xvWkgujfKg9dLmkblbqNj0LQGJ1S1CVSy7y2VGdPFMLRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-16041-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5994C8E175
X-Rspamd-Action: no action


On 1/20/2026 6:44 PM, Jason Gunthorpe wrote:
> On Mon, Dec 22, 2025 at 02:40:37PM +0200, Edward Srouji wrote:
>> +static int compare_keys(struct ib_frmr_key *key1, struct ib_frmr_key *key2)
>> +{
>>
> This stuff should be using cmp_int().
>
>> +static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
>> +                                           struct ib_frmr_key *key)
>> +{
>>
>> Use the rb_find() helper
>>
>> +static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
>> +                                          struct ib_frmr_key *key)
>> +{
>>
> I think this is rb_find_add() ?

Ack, thanks.

Moved all comparisons except dma_blocks to use cmp_int().
Moved the 'find' and 'create' paths to use the rb tree helpers.
While at it, changed compare_keys() to be inline.

Will send these with V3.

Michael


