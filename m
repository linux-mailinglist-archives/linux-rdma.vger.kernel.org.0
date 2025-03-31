Return-Path: <linux-rdma+bounces-9034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B040DA76328
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB7B167C31
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089591D54C2;
	Mon, 31 Mar 2025 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MSZH+N3C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8F70820;
	Mon, 31 Mar 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413416; cv=fail; b=nFZP9YCmYDXaxoIReleIDhgq8gQSgJKCqvVTO+ffF5CZ5/MWoHhkzKAP6dbDVATaQ8oD9t8urOeWNSHSY3n943suB8mODPEsys4w/BtpO18cVjbdEzgKoHFJe5o6A49Bpq5yk5qu8mpszDE9z1kGDZ8gS3nOV2ECW4mVqjbc2nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413416; c=relaxed/simple;
	bh=shK0Y5nexnV8TFGlWNz1SMpz9AdXD22bxvLyWuj/gK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MCFMS/p8TGJlHcMdWfjmyqJgP+fw7cepJ00syQ2f+HHkTIWWjzVnrc/fB3PqedaBn25w64wAujPFwpv57gEQFi1wUuzqNgTCIw9iVi4kcBwbwEdh/ddgy/J+qYwixnnDF0VyDM5pTqsfGY+sllMKyR0rPrCeD0h4RUv9YJlgt7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MSZH+N3C; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKED8zu0IqdGQUu5Jb5gmEddNPn4mZiKNXhcgMIVM0v8SY9wHP/IoGZ3CUxD7CtTKu+9Cddx3fb/w4+ej6PpU2OgUJaDP4Niwh6F0wPjgSN/2ueUosVddlaJ1hTRTv/IZVMTyTcyvvwjNDhzieBUqufmdRsj13Gnmc2IZxXLFWChgptlflQ5wZCWx5CMA+QURg7RUf7jwZ540HfQJt9dMOjTdxQqH81oL+YukWW9a60JPiyVAcVKW4ZydJlGVn61KdKyDvJdrIr/zZ0l1+KvrOVyMoZOFx7Pp0hxDpZTN7SxWtiY4cOR8rlk0frkinEYR8XTCxIwF8KuQT5vDz5/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoUOp8ZVEJVQlPs0FcKUlwBnvHxTux6AlzFGbQfczyo=;
 b=ZDup010dvd/keu7hHEuO10InUQRovYbR93LNnNnnOJCZ2imq9tmh8PUT7bVfIMyWvmFxdw+hY/7mbtKct8g6s/UIpE8pEfwZQnlJtfOxDOd71sMfSIXqLcyJNHpdi81GoCt1uMFg71e9ZuBHpuf5aYnR3bcm3YSTGv6n5IXm8nj/pCVqKlck08oW2bsJeDfkw/b5VswHS/msTp3IOMiR+lg/BhvLhNQPC3g9vo3FCYoqL8hiKDwVRZSJikNeF682ZDdq6YGJLu/94fdTDNs3dXQo0kLXaD14LtbUSwhKDv9zYYXsjtX3VH9ZnL0xJmxX33d1reLXnTcPswFXy1dE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoUOp8ZVEJVQlPs0FcKUlwBnvHxTux6AlzFGbQfczyo=;
 b=MSZH+N3CeO6D+CLEXi4XBZlsVG5JN4FD6eDTAZb8lrrRot0NHnh3u6wUcgSw7MYrlyZWtSLs2hHO6Q7k8ZUshhjF41s56r+aV08vbnpoX0R6jQeTCkcZmOxz5Nv1Fx6Ndb3aonMjxkSWtwroQpCKN0HFas8xthmUMDNxom9vj8nROL7F4EKoR3pktGnGS8SzRt3ATb4krf+BOyI5pibnl+/ATgf8ntgudBkj4RTfU74YFk9m/O5CGZ3x1Zh058o6D82/n8P8/dbgmzHclTgE/ieT2/s8lthsc+BFGxZeieYIIFs1NNHxo4PVpC57UFGQyRyue1S3my/w4bY+VTIZmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 09:30:11 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 09:30:11 +0000
Message-ID: <a754f37e-d9ea-4fba-820e-cc56204d954f@nvidia.com>
Date: Mon, 31 Mar 2025 12:30:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/mlx5: hide unused code
To: Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Patrisious Haddad
 <phaddad@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
 Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250328131022.452068-1-arnd@kernel.org>
 <20250328131513.GB20836@ziepe.ca>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250328131513.GB20836@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: a5462969-6188-4d61-bb61-08dd7036a278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmRXREd6TE55NStvMTArMkxvNmE0TkRkakk0VVl1b3E2UThzT05PeFZlaGI5?=
 =?utf-8?B?Y2pkWkNlVWsyb3hTdjVDYTZpN0xxSDh1MGtvSDVDYzUrazNzQzhjdFJLMGxk?=
 =?utf-8?B?RHhiUjcrSW9JZ1Y2ZGRnRlN6ZURrYXBFZ3p3S3VZL1hLajdPZitpWFZleUxP?=
 =?utf-8?B?RGFQWFQ1QmtVWWpjQlNVcDNUeGZsSU5DRVV5a3BDNzl3M2RTYms1SVlzam5Q?=
 =?utf-8?B?ZTAwVUk1dHk1L0thSHI5VURLdWxyc1J5ZEdybUdKeVV4akM2MmFOd0Y5OUdW?=
 =?utf-8?B?cVpaZFQwNHA1eWE2WnhlUDlnRFFZc1NVclErS2FYZXVIL1FsOU1oNW96ZFZO?=
 =?utf-8?B?TVZpQ01wb1lKS1RlMS9oTGpwbEN5N3o4RjFFRzZzcDJHaVp5aktjL001MmpU?=
 =?utf-8?B?RDFxdFU4NFFKNzNxWkJGNDBhS3RtTDdhZFFKYm8xMG9haURpMFNBcHhxVDhE?=
 =?utf-8?B?bGQ5QjVBWUJscmJjaFhBS1R3MkRiRlFRTkIxZVdOa2VGOWFaMjh3MEs4Q0tt?=
 =?utf-8?B?eU1wSlVBcXpnTFRtWGJaeEtscVZTeklqWkZuclMrdzhWaDFyQXRwcnlFSmNz?=
 =?utf-8?B?NmgvaDhrTVo3VnpWdXJpWS8zUmtrSGRINy9MekRQL285eVAzbldmUm4wSjdx?=
 =?utf-8?B?NXp3Mkd1ZjhpR1Irb3RjbTE2d3VEU2RFMWJTUXlRM1JIVmo5c01uZUoxaFE4?=
 =?utf-8?B?VjBxZXg4K043UWdCWWpVV012YTRIdjhXSzMvaGoxc2xTU0Z4cmFJejBHOThD?=
 =?utf-8?B?K1ZibURXdmYvcVcyeGk0MmphZSsyQjBya01ldzNSdTk3cTJzUnc2bWdxYlBD?=
 =?utf-8?B?cGgvdCsxZkpkcmpEYTdPOGpZZ3VBbXZTeEZLRnNGTEh0UzFUd0EvOXFITTFK?=
 =?utf-8?B?VnRWeERLL1l4UnlrME1najEzcHU2WG1FZHFHZ0RveWo1QitWZU1PZ1lWZWRO?=
 =?utf-8?B?UkhsK2UzTjZmcVliWnN4d0dieklNSmZWNEZhZzVHdG5hbVcvQURyLytmZlJv?=
 =?utf-8?B?cWt3aVErdFBMSCsyR21VSGZkVGNUblJpMmVYYjJUcTdRSng3Y0Jzam0weUFi?=
 =?utf-8?B?NGFvSEt0SDYvSFFWQ2liQjVJWmxqbTZ2R1lWZTc4bE9WMExCVUt5YUpJZTlV?=
 =?utf-8?B?eTJRdWlNNXc5NUZ3SEFkSUkydDBYZ20weTJUVStFVGpXUjlsV2d1TTdTQnUx?=
 =?utf-8?B?Z0RMWkhBY05mZG5CdGJCaUdrUGdJalVSQ3QyV0lGN1p2WmlmakNlZWN0cW5k?=
 =?utf-8?B?MTdzcDI0N2YvNm15b2x2NitZT05TMzV0SVVObWpGNTk3YjlyVC9pRG53Ti9w?=
 =?utf-8?B?WXByWXVkemNhN2Q5N0lCcSsyQSt2ZnFsbDZKeFNBTHRYWXFlZlp6TjkyZlJu?=
 =?utf-8?B?eVROK0k0UVZZQVAzZXMrMFNYRGNWNWNKUWxmUG5yTm5DQnlHem11aStuQ2t5?=
 =?utf-8?B?QktlVWViRUwrQmN2dUxoUTZqSWsvUlBBWjV3bktqZlBGT0xITy8xNEtoYkll?=
 =?utf-8?B?bC8zQ1NndmdlcUFDVzFiZS82eU00Vmh1SDVMZm5PQ3JRc2hDU1Nac21SM0kw?=
 =?utf-8?B?R1FJUmViSGo5bXpmK3hqVGVTYkQ3WHRvZHVBOHhnMUEyWEhRWm1JeWJhQy9M?=
 =?utf-8?B?ZDF5ZjN3dUJBQmd3V0Z4WjlubkpGZFFaSFV3aGlpeW05NXUxS3Q2VFlsWGRx?=
 =?utf-8?B?WitJcnU2a3VKY0RNeXhzamJTUGxkM3lkSTVUeSthT05vdUg0WmVRWXZvZ1FL?=
 =?utf-8?B?R0Q3Y08vMkFFaUg2QW90dTh4S1g4NXNmNEp4U2lWYlY0eWJsbWd6dzlINUJO?=
 =?utf-8?B?ZER1c0NpcnBRU2Q0ZE9idFd6d2Robnk5SzhGOTEvbDh6YnpRMUJCcGZuai9I?=
 =?utf-8?B?RGdOdkt0RitMajhKWk1tRWtNUlFMMUJzNHh3anA1V2dLQnRSeFhXQWMyRXdR?=
 =?utf-8?Q?IRpSv5KqZWM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qklwei9JZ0FCNkNlM1ptK3EydFBaTUFrNDJudDVzMEErYkR3dTJzOC9aeUs4?=
 =?utf-8?B?aHdwQzR5c0hlYzllTzlkMkVhQlR0VVhJcW96N2NMVFVGWlg1U2NOaHZuYld6?=
 =?utf-8?B?QmNNZTZwYnlDaGx4Ym8vMmJFVzVHYTlXdjBITWhERkJnMEtnSWZVb09vQmNG?=
 =?utf-8?B?akwyRzZrVFBXK1NpcTEzRUZ5Z05ZNGJUemtRejVCaWU5QVo1WHNoSVlsd2xs?=
 =?utf-8?B?VjM3OVBFdWZ1ZUw1Y2FDK3JLZ29Xa3IwZjNuaEw4MkRrSjdNY0VuRTRyQzFY?=
 =?utf-8?B?cFE2dkEwdHVLVjdEVDByTGhiajlkTXI2OTZxNitZQUd5RVJaV3hncTU0UXRp?=
 =?utf-8?B?bDJTaUdKZ2pscjl1SzBESkNSM3RRb3g3YjFSTzlCLzRnZmRqaXIyTHk2ZVEw?=
 =?utf-8?B?bVBuRG50aTVIQlpld3hESXQ4ZzRKM0RtRjV4T1Fzd2lXN29RdTl1MVZ0alVo?=
 =?utf-8?B?b1B2RmNsbVdDeklGcDArN05TdG5YY0EyajNRVDV5ZzlMOHFSYzlrcFFERzZ4?=
 =?utf-8?B?MGQrUUtGZ29hL2xlSml5YWtEdzBqeTdEaHQ4bmwrZWJZZXdlOW5MWEtmMFlR?=
 =?utf-8?B?aG1iVGNQdEVyVzVwNXJmZWJSQy9TaWlFWUt2ZjRsTzVxVmorc0lKb0hGRjVx?=
 =?utf-8?B?UnNhdklIMEtETDdqalRaNWNHQWVRaEZxdlorS0VYSzF5Skd6VTlVdmJqeUhH?=
 =?utf-8?B?ZDhSc1lVOTFMK05pVHFWRjBpRzdGYnM1VFNXeUtjZ05lQTZuNnM3dXU1dXlt?=
 =?utf-8?B?Nm1MSTZvcGpQWUJuN1JTaExrdFNpQzBLOEZoazJZSDhMQ2diV256cVRiK3pw?=
 =?utf-8?B?djYxNFpkOXd2VmRENk45c2NqdCtBcS82aVZscHdNbGpwM0h6RzNUWXdpSmVP?=
 =?utf-8?B?RUtveGoxdHpUSkZIQ09hRzU1ZlozMU9PYTc1K2ZRVjNpMy93dWIvKzU2Q2l0?=
 =?utf-8?B?dGV3Q1Q1NmU0OXViTnJsTGtLK3VjQThqN21jcWNSa0U0RGVTSmlybnYyc2gy?=
 =?utf-8?B?eWs3K2tzVEpKWkpvT2RQdWFDNmRVMW14YXRGZE5JUCtSZ2x5V0tSWUlFUjgy?=
 =?utf-8?B?ZlBkSnFDR2JnVmkyN1UzY0FLRXFNKzExWkFta3RuVjFVRWx4WlVBU2x1TjBR?=
 =?utf-8?B?bnZYN3JkU2Y0Zkc2Z0tGUzEwNWJnazVKeUtwbzcvN1RjakVpWWhFa0xKVU9C?=
 =?utf-8?B?Nk5LNEhuRlF1TkR6b2RyZnFISTI5cE8xZmxFNExMWWZoa3dJTEw1d25jMzN6?=
 =?utf-8?B?MHBFcElqb01YUk1GV1VlUHRNZSs1SXpmb1JNaHdXYlc5WkZ6MmtnYjV1cHZU?=
 =?utf-8?B?UjZGWCtkTWRZVVRFK0p3YXdQWDBRQ1NncWdxNTQxZW8zY05pTHRrQXE5cW1P?=
 =?utf-8?B?eEw4blloaDRKcXNBZGRPTWRhdko1RWZ3SUdMOWpPK3l6N3htZWlWUGRaV2VM?=
 =?utf-8?B?bnc4RkIzWVlrYVNEUkdTSmpaR1lVWUhGb0tqcTd4QUFQQUNibDFpVTU3UWIr?=
 =?utf-8?B?ZjBwM2FPQWhTeXBDMGVoaEFSTk1EakcweWJjSTlDTlpURk5RNzBkbnEzRlJ2?=
 =?utf-8?B?dDhlQ2MzWk1xeVNUZ2pPemg0MkxFS1pUVnhhbmx5QnhES3R4UGlvVHlaV0dZ?=
 =?utf-8?B?U3pWUFhucmZQYXZYSFI1WkwrSUsvOGV0ZU1UaDFFam1rZWFud0hyZSsyd3Ur?=
 =?utf-8?B?QnBDQkw5d3Q0L2JoOHl0bS9jVExQbTFFeERLa1kzWTRVU1o3NTFWMlZLeTFs?=
 =?utf-8?B?RXdqeU1Gczd0YzFTTkZRWmFUOEVXS01WMWt6YTlXajFGczJSQ2hxL3U2bFJO?=
 =?utf-8?B?MTYrV3lTU2ZpbVVYMnlmRG9QU3hwWU9ZZXNQWlZDMHluNWdEdmx3andSdkhi?=
 =?utf-8?B?dDRMRk4zS01HemhrbDA5TGt4OFhralRRcWNaZ1h0VkxIOWpHd2pyVWxMUlhL?=
 =?utf-8?B?YkVPNmh0RnFKWkxnQmZsMDBwZmwvV3BTRXphd293RjJMVVloMkVJcDJYZFpz?=
 =?utf-8?B?d2FxSEs3MUl5QW5sS0s0SjQwcURyUnlTUStMSFNqc3B4YUhrZE8zbWM1cG1T?=
 =?utf-8?B?UGFwdzk1bnZPZWorTzl2eTZyMllqWllobTBjcldTRlF6TjBkdzBmN2hsaVBj?=
 =?utf-8?Q?dId3xoI094zGfHSjZS4RN4Q2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5462969-6188-4d61-bb61-08dd7036a278
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 09:30:11.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hFso0+at03utRBzUrZDYVvkigiMM5CPI0YEDe4BuwNmfAdxa3K2Juk+FkfWca2StvWUvlvcDgr+MBTtsb1irQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402



On 28/03/2025 16:15, Jason Gunthorpe wrote:
> On Fri, Mar 28, 2025 at 02:10:17PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> After a recent rework, a few 'static const' objects have become unused:
>>
>> In file included from drivers/infiniband/hw/mlx5/fs.c:27:
>> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_STEERING_ANCHOR' defined but not used [-Werror=unused-const-variable=]
>> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>>    52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>>       |                                               ^~~~~~~~~~~~~
>> drivers/infiniband/hw/mlx5/fs.c:3457:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>>  3457 | DECLARE_UVERBS_NAMED_OBJECT(
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_FLOW_MATCHER' defined but not used [-Werror=unused-const-variable=]
>> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>>    52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>>       |                                               ^~~~~~~~~~~~~
>> drivers/infiniband/hw/mlx5/fs.c:3429:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>>  3429 | DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_FLOW_MATCHER,
>>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> These come from a complex set of macros, and it would be possible to
>> shut up the warnings here by adding __maybe_unused annotations inside
>> of the macros, it seems cleaner in this case to have a large #ifdef block
>> around all the unused parts of the file, in order to still be able to
>> catch unused ones elsewhere.
> 
> IDK, I'm tempted to revert 36e0d433672f ("RDMA/mlx5: Compile fs.c
> regardless of INFINIBAND_USER_ACCESS config")

I believe the issue arises because uverbs_destroy_def_handler() is
declared in ib_verbs.h, but if uverbs isn't built, there is no
corresponding implementation of this function.

One possible solution is to provide an empty implementation when USER_ACCESS
is not set, similar to how rdma_user_mmap_disassociate() is handled.

Alternatively, since uverbs_destroy_def_handler() currently does nothing
(always returning 0), we could simply define it as a static inline
function inside ib_verbs.h and resolve the issue that way.

An example of the first approach would be:

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 251246c73b33..0ff9f18a71e8 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -3461,7 +3461,6 @@ DECLARE_UVERBS_NAMED_OBJECT(
        &UVERBS_METHOD(MLX5_IB_METHOD_STEERING_ANCHOR_DESTROY));

 const struct uapi_definition mlx5_ib_flow_defs[] = {
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
        UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
                MLX5_IB_OBJECT_FLOW_MATCHER),
        UAPI_DEF_CHAIN_OBJ_TREE(
@@ -3472,7 +3471,6 @@ const struct uapi_definition mlx5_ib_flow_defs[] = {
        UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
                MLX5_IB_OBJECT_STEERING_ANCHOR,
                UAPI_DEF_IS_OBJ_SUPPORTED(mlx5_ib_shared_ft_allowed)),
-#endif
        {},
 };

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index d42eae69d9a8..901353796fbb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4790,7 +4790,14 @@ void roce_del_all_netdev_gids(struct ib_device *ib_dev,

 struct ib_ucontext *ib_uverbs_get_ucontext_file(struct ib_uverbs_file *ufile);

+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs);
+#else
+static inline int uverbs_destroy_def_handler(struct uverbs_attr_bundle *attrs)
+{
+       return 0;
+}
+#endif

 struct net_device *rdma_alloc_netdev(struct ib_device *device, u32 port_num,
                                     enum rdma_netdev_t type, const char *name,

> 
> I don't think that was so well thought out. The entire file was
> designed to be USER_ACCESS only because it uses all this mechanism.
> 
> #ifdefing away half the file seems ugly.
> 
> Jason


