Return-Path: <linux-rdma+bounces-10163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42448AAFC61
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 16:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9D4B7B6FEA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64B24293F;
	Thu,  8 May 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="fTvb7RwZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020124.outbound.protection.outlook.com [52.101.56.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E323A9AC;
	Thu,  8 May 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713042; cv=fail; b=jKGFs0J4L7n8rQ7KP7g9TbvR6pUEqM6a1GHlEB9jXdz7zw9G45PXbyDMt1RLQQMcP22RYe+LOxilO4aKbfvWHIdJNMDod0CsATrtF4nyKf3sR8GhOze54byqMnEljrjiosYBrFoQFtI0V7Vgr4FG+JLxCixnYPVDQLpY35Jzke0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713042; c=relaxed/simple;
	bh=YbYra91ONZZN47hB1A3X18Bdw8Yolk0ynWWq4WG58cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1RklbeBqQdHHuFxbGnDsQjqNwVEzOXHIgRxWKKkGr46LdJBMc5A2xCzyxnETz7wrvJEoeOeDiaYh6ADTiEU+bt6vZnyaBGER0l1n9ZtGLVvkq8XL/IRrwLsOovCSJ4iIA9Rfu9HJ2SsW+P/NhcxkjHQx52vVxun1WG+BCjLxKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=fTvb7RwZ; arc=fail smtp.client-ip=52.101.56.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8l4ywgVlE4nAwTHZYA1riZnMUqo6q3Gj8DFHpL7zftO58M7RDpTrLOC1esLVec7YARLp2vDXKuh3kmXVdu2vfd7uKHncz7OGSiMba+rc/eZS9VPMxAoO9mCUVLsTzYdwYMDy2UUqvGK1s+fJNdBpdfdutzIbQVkAhfIa0ahD36dV4iKSXE51JwAHxJQgFMVLBbdZy58PqvOH7vEb4LpfQIGwChQzWeuRMDoyaIv9mbFnUNkfTyrJZxtp/XtfPPiLJIrxnnX2OptXlusFycLg+EUwlxaGEMysRrMtnGpd214QN0JXyGaIa6xgMtwi0ailB47VJ+IwVORIivAs4Uq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgd2WRTKjHgSUxWxdY8h/Dk+5EVt6vN7dJ1PgMxXuXU=;
 b=bSCT/SgOuSxf9i9mZ4nERNZn4RkFdNZ8ilQ8CP3afBXesc16zOWsJr+LcWmo9hTLAmPeDAWr+Ez5XYktlmw2vxb8sobMmnMYdxS10wXQSJ9zSsIWJX3jfgvMEZ/L2miibpChv48Pfj/8Um4QBJUWlWrjnEEfmHdy1HczlsVexHl3ZqUIvoP7NmIV+u82KIjbW5/E/vzJVNJjJ3oIo+hAYJqXAMw7J/9MQ3TMepzy5HugolTgggIqcJUSRmiYqVzJ8xANt955s5mIsjiFbP1/+oWgOHZtfPOv67QCXtgEJZIgQF98vyUv3j0v0sKcd5qLsgU5IDXWW/5LKeceC2MaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgd2WRTKjHgSUxWxdY8h/Dk+5EVt6vN7dJ1PgMxXuXU=;
 b=fTvb7RwZ+byDSSKRD4yMJDir1NV2t/ILwxKZB/NO59Ubv8izWwOgdd7hMMevNYA0AAQ+U94eOjf3QxVPrIb6KYx75RM8Hm8dYOVg4L2+nujzQlL6Bpu2DBXRR+LHlrfcyEdOk1UYqBPxnk717jKwjZMa1OZtujmDrAaimDUfD1hVd8dG0x3d5CL5ppQ0ln/sjLVEgFM2fmxIwg2hfKCAoyO7Lwe4/DtaTAPzpdjKQ5r6dSVBUpXOvbxSlWjpBuy3fYuaE4AhWF7Mxwknn+Wl2pVKsX2hgLivxAo33wCHyPAVCtp03CoNB73b1X31sgOR3X3kh+jC6pBwkSrTBbVbTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 PH0PR01MB6183.prod.exchangelabs.com (2603:10b6:510:18::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.20; Thu, 8 May 2025 14:03:52 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 14:03:51 +0000
Message-ID: <654a8058-a699-469d-9997-45090d817f4e@cornelisnetworks.com>
Date: Thu, 8 May 2025 10:03:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] IB/rdmavt: Potential deadlocks in function
 rvt_ruc_loopback()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <CANgpojX70kVOFMoJn=Mu93JEqaYoYCM3d1LhWcP-JKN9bm0F0w@mail.gmail.com>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <CANgpojX70kVOFMoJn=Mu93JEqaYoYCM3d1LhWcP-JKN9bm0F0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0107.namprd02.prod.outlook.com
 (2603:10b6:208:51::48) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|PH0PR01MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1fd8f5-0a0a-47e9-e593-08dd8e3928fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG55ZlZ1dVVWLy82T2RvLzBtWUJEdFZ2MTErcVVIeFZSR2FYd29nSEpIbnR3?=
 =?utf-8?B?aXlDeEhYWEpIaXFicVpTVmlyaFZMb0JZenk2Q2FBamFjNHluM1dOcTNHR3JI?=
 =?utf-8?B?bURhMG1IckZPd3pnZGdnN1A0dUVEcmFhNEtWaDZwYmZJSFJNZlE4eVp0S0Vl?=
 =?utf-8?B?T25KQ0o1MkpyaE1uNElVTUN5aFN5V2hzSWxEUkxXQVhhZmF3NmxtL09UOGt2?=
 =?utf-8?B?R1JURHhveUhXMXBPeWV3NTlRZjdRZUxXeVBxM0Jlcm5OckRHcEdsdkk1NmhS?=
 =?utf-8?B?SGlqeFA0cy84WFNJU0JXZzRSUWhYU2NTcWJiR3EySCtxQWR3SHBZZHFnZGYx?=
 =?utf-8?B?dDVuaFJXWURqa3RsTHRZVkFYcHhSMGcwNFo3RlFLNXV6VDZkRmJ6NXpvV09z?=
 =?utf-8?B?NU1MVFZ5Ym41Q0RsQlc1ZGRjUEhBVkJEUDlERmEzK0U5NERLNzJFL2xKUnFa?=
 =?utf-8?B?UGlNeDVzSE4vYlhXYllCZEdQTmNPRnV6VDg0ZVZ6a0lnWGticTh0VEg0WGNF?=
 =?utf-8?B?MzdmL3VIdTRjU0ltMWp1emVWWVF2K056NEo1UkhkS1RDeDl0N1d3WWU2Z1A4?=
 =?utf-8?B?UDM4Mk9jaGtjOUNrRGZ6NmgvdWZlVmExVk80c0lKK1JlaWZUeU10VmlYZllo?=
 =?utf-8?B?U2lLQ3puRzc2ZjN3bzIwMDRTMHZpc0E4UTcvYy91RWJlY2dzRHVDMi9qTFBE?=
 =?utf-8?B?REk1REpMZE82Q0hSOE1oK2pvUXRtVDJBVDRpa3F1cFRUV2lqb3poOWQwd3Z4?=
 =?utf-8?B?dE9LVjJtM25nd1IzQzU0UUhGWktxV0hMdlh2N0VMK1h2cWRjZHAyZGlSNXY4?=
 =?utf-8?B?ZE5xRzRoa2hMc1Y2dlBaaUJhaWFtTVE1Z1Iva0J0cGQ2Z1hOdHhGVW9PWDlB?=
 =?utf-8?B?MUkzSlRiV2lHa0ZhdlJDdVBZMEprQ3QrZ015RDVvK3BpdTB3Q2NWekF6dGVk?=
 =?utf-8?B?eFoyUVNQbVYwZmJHbFpKQkZhKzJMYXhKN0wrQ1NaUERqdTNEclNTZkt0V3li?=
 =?utf-8?B?RUlmVHpxSGVMbWhxb2d0WXlVS3F5UE5RcUJrZVZYOUFOUE9kUUQxR1V4RjJI?=
 =?utf-8?B?VmpuZ29sZTRFUkN1MTZQTVNTSStGQjk2N3hNeGQ3aDZGdWN0Q3R4blZZK1J0?=
 =?utf-8?B?em9yeVluN3lIcFZyWXhCWitJaTZUeVc1YXJqLzRqUmljSDBCUGhUTnZGZU1B?=
 =?utf-8?B?ZExVYVRzQ25qZ2pSckZnSkRnQnVBUklhaXRFWUFuVXRpMDVQZHZzOUYzNVZu?=
 =?utf-8?B?VVplc2RBajlSUmVmTUpZQUVndXdjeU01Y1ZWWHNDSWF3V1dEeGJ4aUVVMU5B?=
 =?utf-8?B?VkMvN0hNUExta2pIN3RXYUJGOUpvYnVuUis4TFY0U0N1dE80QitzSnpCSEpP?=
 =?utf-8?B?Rzd1ZEVoTjRuQTlSbWxiazNEbXRkTXppdnIwc0RTNVRPNWpYYTBGOVdvMHJk?=
 =?utf-8?B?b1ZYZ3FWSTNlNmdFRjF4RTVmblZGMHJ0TkU4L1dHbUpZR0ZTVUtrN0kxVnZi?=
 =?utf-8?B?RmtrbURMdTNyNHYrZmVpUFduQ0ZPMG9tenFFUWxQRzhlM0ZHUGQwcnorNXlM?=
 =?utf-8?B?SjdvOUNGdWNvajZrQXNJLzU4WVMxUnJwNHl2WUMyaytmUzVtOEJMRTNIdVlp?=
 =?utf-8?B?TWpQNSthZ05xNjN1aGt4OTFWNXkxSG9TeFZ2V0ZjZUhpSHo1MDlIZUlOYjhU?=
 =?utf-8?B?eXZ1TytOYitSM2FQeDNxVWFaclY5aVhvVVJETjF4aHJPSmlFUStvSTZsMzBI?=
 =?utf-8?B?YlkxbWl0d3lmM2VhYW5PMzA0cnZKWC9zazJWem9vOUNyUUVsRUxVQzNJZ1NM?=
 =?utf-8?B?REtoYmNxVDd4eUZnMHR5aDZQR2tNK0ZPSndoTStzR1UreEhZOTI4YTkwbHFR?=
 =?utf-8?B?TXdmcXpXL1N0ZjF0VmhwNU9rcTlZVWZzczZ6T2laUVMrN1lXYXVReWhRWTVk?=
 =?utf-8?Q?T/LRYl5E7Cc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFBbHBXOWM5OHpicndyTTlRWXBPY1BNbDJQeHZYTEY4UlF5Nzh2RFpZVEtB?=
 =?utf-8?B?MGtSTTVSdCtydCtPRENKLy9wczdHdzFVcjVqd2t4VjkycjJ0N1lWWGZFUWlk?=
 =?utf-8?B?VzdZNjZiY3RyQVZVck5tYUZxV2llcWU1NXloa2FYam8rcitJMkVvMEFBNXp2?=
 =?utf-8?B?dGFRVkpQMUxnQW41TVVvL1J5K05HM2d3SmlvY05JNjROTXAwc1pRZThVeTYy?=
 =?utf-8?B?MFRycUlEQ2I2RUxmZ3pqY2R6VWZ3bVpwN2d6RC9LQStQeWJxSkY5TmJaK2ZY?=
 =?utf-8?B?QlhGT3doczVYZTJPcmdFeVVrU3Y1MjRvL3JiUVFJaE92Y3FTUmJXSW4zOWo1?=
 =?utf-8?B?RXE5ZjQvSGtkMTFwNXpUcHpHUnJGRWpvSk5LTEpKeUVKOCtuZjZ2SGYvS0F6?=
 =?utf-8?B?cWdYVTBxM3I3MDNUYmdrQ3NjREQwM3crK2ZZNFB1MWZRTHpSSVdBNzZuLzla?=
 =?utf-8?B?V0VyLzNOTUx5WlFJMmZSRGh1Y3Y4Zml2TFpKY0hyR0YxQ041M0UwS0wvTW9Y?=
 =?utf-8?B?S2JDQWRycVV0VmFjKzBKV1lwNWY1a0VDRlZ5NldxUERlQ21Vc1NFQjFTMVlZ?=
 =?utf-8?B?ZkxKblVLSlk5TkZ2d3RMSW1lcXVMdXpsTHFDazgrTUZBVENUQ2E5VnBDQjgz?=
 =?utf-8?B?ZmNXUGFOQ2dTajM5UXJWS3BWNGQ4NlpwdEJDYXNrUHQrTjlpYmQ5clhhR0xS?=
 =?utf-8?B?cDRXOHdCck5xRWIrMzZGWjBObkQ3WFRHTEI2azlHOVRzNGRvN0dDNkduOThi?=
 =?utf-8?B?TGRvTXV1TDNodEVHNEpqWGdUc1BwbmtNRmRqR2diYVZkZk9pOHZqWHRsN3dP?=
 =?utf-8?B?ZUJtaXZhbWJraWNpUkVRdE1USDc5UkFxT2FYSUY5bVZNWmQ3QmRvc21zMmN4?=
 =?utf-8?B?bE5TVEZLUlo0MkVua1pOWDMraEx1U1FVYlFPV2JpR1Y1VG91UDNSOHQ5cEVj?=
 =?utf-8?B?TWR2eWJOOFRORlQ0dk80TCtpVFJaQjJGSEdOL242ckFzNG9ObFRaS0NWaWxH?=
 =?utf-8?B?NWtyRlBoVUk5UjB4dS9wN1RXZkpJeUd0RGFIQUJOdlpQUE9KZFU3bVFTVlMr?=
 =?utf-8?B?bFl4OWZWYVRkelNpOExBcU15S2hHQWowS3FIMThUd05lUWNLbmU5WWpManly?=
 =?utf-8?B?K1lnRjY2SFFrNnZzdFk4aUJNZ3NzeTlxa3UvV1g1c0g1OVZGa0lWN1FFaVFs?=
 =?utf-8?B?V2M3cC9GcnVEaFhJVWVWVjExdE91MlZKMlJCVmlLOUtGeWhneFFwa3gzYS9K?=
 =?utf-8?B?Uk1FeC9LTTlITEJsNnNua2ErVVQxM3B3TlM0bHEvZGZwdDBGZWdTMy82MUxw?=
 =?utf-8?B?dGlRcFJadDk0SnFDYlBWellxSWxEN0ZHRkJiYmVPVTMvcUJxVkJFUXA4U0lS?=
 =?utf-8?B?MnVMcUMxdHJEa0c1MXdYcFBrSU43VFdCNFhIeGxhdGdGS084L05sNmovaHgw?=
 =?utf-8?B?cG5UUXRUc2p6RVFERWJCSlB2b2FWZENraTloR1luNVU0eVQ2YUJWeHl5a3JG?=
 =?utf-8?B?b0pVbEwxTENyYjhJblpvQlhpd1Bxc1FJTmNOdExDZFhSOGZqZnQxNUtlVTQx?=
 =?utf-8?B?MTlLZkd4bGgzOXozcFFYR0lGT2pZeXBiQ295ZnduZkJ4clBFOTIwSmdXSElG?=
 =?utf-8?B?b2R4SVYrRDIxVjJtdldUQjZtdytFL01LWFF1cUdZS21QaElOdjBLRTRMdHpw?=
 =?utf-8?B?TkswWWl6ZUxPcHk0ODRKdHFMYm51dWI0a04wZlVlNktyZjFYbGgveHFpOGxq?=
 =?utf-8?B?eGczN0tZOS9VTXNOWjBTMVZ0Rjl4VDJCaUc0WFJ2YVFzT1A4Sm4xU0h2WVUr?=
 =?utf-8?B?M0pSL0tRMjBQQUhpemdGR3Zvd2ZHeGNKMHZFL1JMZTFHS0dTY05ISTBCTGxX?=
 =?utf-8?B?U0pWaXZLRytYQmxyVFpYLzIwUVNZemErQ1ZOR205Skc0SlRXejdBM2JnZlB3?=
 =?utf-8?B?SWdlWHZleEEzdjQvT2pjYVVQWGdKbXNpTEplUlVWOFE5SDVzcGxWbXRJZ09Y?=
 =?utf-8?B?QTQ0SklrZXVRNG5BSk5PZjZDSVJpbWxPRDBSYjQxSmtiK1ZtR0RPdnJFL3I0?=
 =?utf-8?B?KzRlZ1ovR0hGQmJyUDlNeEswWERSMklJNWxYWEpwKzQwUXRGNE9BLzhocDEr?=
 =?utf-8?B?bGFUZnp3cnp1YTloeDJ4MG9wcVJ0QzRwVmF0SnFDdU92Q3dpSTZrdllsWXhk?=
 =?utf-8?Q?8Pv4FxXpUkSRdgNLb/QRDuY=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1fd8f5-0a0a-47e9-e593-08dd8e3928fc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:03:51.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URF0zoLoDQGIjdAX+RF7Qx76JQcJr1Iearo4kIMywkDsNgxJePVD3PAlnFYQZpMQMyDpj74vROnLbWXmt6jF2F+HVlbHrUrOCJ1WtOm6JzIv12EI5Bi2TxBEwwtS2vtC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6183

On 5/8/25 4:31 AM, Qiu-ji Chen wrote:
> Hello maintainers,
> 
> I would like to report a potential lock ordering issue in
> drivers/infiniband/sw/rdmavt/qp.c in the IB/rdmavt driver. This may
> lead to deadlocks under certain conditions.
> 
> The function rvt_ruc_loopback() acquires locks in a conflicting order:
> 
> 1. First takes &sqp->s_lock
> 2. Then takes &sqp->r_lock
> 
> This contradicts the established pattern in functions like
> rvt_rc_timeout() and rvt_modify_qp(), which typically:
> 
> 1. Acquire &sqp->r_lock first
> 2. Then take &sqp->s_lock
> 
> This reversed locking order creates potential deadlock scenarios when
> these code paths execute concurrently.
> 
> The issue was introduced in version 4.20 and persists through current releases.
> 
> This issue was identified through static analysis. While I've verified
> the locking patterns through code review, I'm not sufficiently
> familiar with the driver's internals to propose a safe fix.
> 
> Thank you for your attention to this matter.
> 
> Best regards,
> Qiu-Ji Chen

Hi Qui-Ji,

Thanks for the heads up. We are looking into it. Will get a fix out soon.

-Denny

