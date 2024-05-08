Return-Path: <linux-rdma+bounces-2353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03128C01D5
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42E24B21545
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2024 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CA1127E28;
	Wed,  8 May 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tom4M+OY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZZks5/a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F19126F1F
	for <linux-rdma@vger.kernel.org>; Wed,  8 May 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185209; cv=fail; b=Yc0FPcIo67Gl++iKAkHpBcNADwri6gVYISeZo2SEB2f/GS/TBMSJjaZsYHNzu8NWn5LYbzb2f0HierB4Dz5mUySSE5OAq42PLK0vrrp+kjU6yriAp8pHkw0oIoju/MdXVouiYO5+t+fCVSD7kqAD+7ZkxPWs+INZ9ZfLJNlxW8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185209; c=relaxed/simple;
	bh=Qt8m+Wy8D1IA7nB1T7PglbhYI2wYwhQb8q7nOr0PrUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g5ZXRZI7cdqeEGbmiFr/VFi0zD+kYb1qzrjxIEsmZlh7gvxsCnvJcFyhlwiAnbI4pA7oENT4Dlyrx116jOzR1BsXIkRbgcHivzbLGKzPoti1QDWPsBTxRQNqFyte/ecEvdkJXdIb2yF2o3ZzRCJ7apGNaWRLIk0VJWks7vXHMPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tom4M+OY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZZks5/a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPe17022490;
	Wed, 8 May 2024 16:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=ePXiQHolGZF+J9g5E2Nzrpp+Bty3NolNP63/mktZtv0=;
 b=Tom4M+OYYlyjIeCfuJz2AzFctnV7gg0p+ZP7XWphXpEas/jAUaZtOq8sLnjs21kg3I4d
 WGAf7rktzqx0hSaWHR2ggLFac38o/Ena7wdWqwZ7RDoy2bJ39IcvUl+LmFJB+6lNqypa
 YpndGy9bETMH00LaO70IiA16dHX4zqes0jfH3+/oV4OiGBdqMeSe9UPLTeLnILZ+3lga
 Zz77RyINs+E17LwGpT2hSz5dsAsbMOQjRXmWNjxMSYNKmRt9hKK71UTzxEJNNYrzC/rF
 8sUenCj7Zdw9m6FvxRvBpuk4+5TIraU+ooCk34yJXDabBnvBg5grBxOBtUTvP+p2F0n5 +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfvj73f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:19:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448G0mfK020195;
	Wed, 8 May 2024 16:19:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfm9qhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:19:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLm2wmAc0oZtaDqrShgF7IuKm/vpzWEW84yk+ezRqVxTvFsmPVUVwSlu7apgiQRQ56/AdZuwAy4Qhqyxt2MBnvyU6FyVADScxD6zVIbe+aGe2IZ60vjuYD6lf1hNRCo3GjoZ+R96+ttadrO3+srzf8dojhHtONXzpG0DSeOip8xMzDboPEvhzuSqY0ukLAxdLAHEtOCwambU2nYcIwSRv0DrxMCaQf9ROmgxC206naJXJDfgYcaH8EO3+fSiWXls2cgnayp+mwkITQihXaY/IKgVFnQk9+q2SuAibRTuZaWrwtsvFjqpdo4NjrzaM2cXt+9vNsUPHEoHlCYCbMltUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePXiQHolGZF+J9g5E2Nzrpp+Bty3NolNP63/mktZtv0=;
 b=NOg41yJ5nzrWd+F70l2hHlKLqro05abclagFTBAwlNn+YqV4vN+crEUAIqYhCy5dc/vCBvO6BSLn/VqAhhZa57lDodFT3/N03u7NS4MYcya/UX0kz78wwW1+ePJscDOXWaZIkZwI/aTzJYLJzkdbVkfjsVLPs7ofdbor0hUbU18JwQt1U3IQzuUZuFP7jIgPXyq1KTtyO2oaM/1SitZlQ1O/x7XdoNxt5PFRKy9sD98CtHKCXIkTfmRR6+zSYGzBAma3JGSXAglEZuUpTElNvyZZPnlhahVCo6M8PdAGSZ6H/LoeCQYNlwRbjmGkEqraislV0NWruNWU9A7SkXxUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePXiQHolGZF+J9g5E2Nzrpp+Bty3NolNP63/mktZtv0=;
 b=GZZks5/ay36DklWXJ6cCoqtzHQM+uT2s6FmCujW3yKNRvP4kcxLV2CXfaAv9KDKK5k9AbDWPsrFNYZyhoen3/EozxzOQUrL66CmXcTwh6hQxtRSnoGTdYG9qU8is166z7pDXo2UhQTok0Nz+M3GhQn3yxImQLedz/3RC9dGXfa0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6871.namprd10.prod.outlook.com (2603:10b6:8:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 16:19:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 16:19:12 +0000
Date: Wed, 8 May 2024 12:19:08 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Yi Zhang <yi.zhang@redhat.com>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, leonro@nvidia.com
Subject: Re: [bug report][bisected] kmemleak in rdma_core observed during
 blktests nvme/rdma use siw
Message-ID: <Zjul/Fh2CPWqs/YC@tissot.1015granger.net>
References: <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
 <CAHj4cs-RiZXAdz131ihQ=wsW8nsViphJeHAD_i6qi7_DtW7NwQ@mail.gmail.com>
 <CAHj4cs-HWjMq__89RR1WwLcOa5H46H8+d2t=jj=qFJ_m5kRwFQ@mail.gmail.com>
 <c9e68631-0e60-578d-e88d-23e1f9d8eb2f@linux.dev>
 <CAHj4cs99vDgjfA8So4dd7UW04+rie65Uy=jVTWheU0JY=H4R8g@mail.gmail.com>
 <54eea59a-efcd-c281-e998-033c6df81a28@linux.dev>
 <CAHj4cs9xwzrhRPoZ2t69b6F2JL8X9mZNVmwBfW2y5g7ZdbR8vg@mail.gmail.com>
 <CAHj4cs-mz5Dh6WrqB3PzoV89YaMTHrt9PbJv_4ofQD2r0BktTw@mail.gmail.com>
 <9eb4ed5e-0872-40fd-ab96-e210463d82ee@linux.dev>
 <20240508155637.GL4650@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508155637.GL4650@nvidia.com>
X-ClientProxiedBy: CH2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:610:4f::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a35735-9b2b-4490-4223-08dc6f7a98ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TE11YStjMU1pN3JReGtPNkM2QnFuQzA2ZmlkbXB0L3RlOW94M0RFNmtUUzh5?=
 =?utf-8?B?bytBN09GcHBsSzB0Q0EyQXp3MndCMzlZMVdaQlFtSEVsUlpZWnM1c09JcWxo?=
 =?utf-8?B?QmtORncvdm9BZStzaW9IdkJsdnQ4dnVBRXhIK3oyS29jaTNzYVBDallDeFlX?=
 =?utf-8?B?VWI4ZnpwMEhEeWpaa1dPVnYzNTBld0ZUcWNYUWY3MDIwS09WbVVWMkxZbzFz?=
 =?utf-8?B?S3hrVWdldTNuRXhOaUxXRHJnbzVEdmdEM3lSeEFCbWhzSWJ2WDBrNkpiZ3Ra?=
 =?utf-8?B?dEhxbUowYUVJbldvbkQzZTRxeVBuWWpvOVpXOG96c3M3RmQzbDNxK0tXMVN0?=
 =?utf-8?B?UnVHNTdvQkNFUkRmeUUraGg5T25IVmZqK3Qza3pMVldZRjhpQTV5QjBVMUtW?=
 =?utf-8?B?LzlKTGM0bldnMXNmNDVQS3pnR2pPNGNRWTE1RThQM0xmRy9uanpRbGVvZUpm?=
 =?utf-8?B?NHRiR0VlTkRvV2c4c2FGNGtlUzhhOU1GbEk3ak5tQmw2UEhnZnpEOVN4VGE2?=
 =?utf-8?B?cy9oNnlOTTRxMExtdlQ1UCs4aDVZcUlWTHlkVmlPQjQ4S2U5S204eWRSMWxS?=
 =?utf-8?B?ZEoxOWdxOUsrQlZYL3pRV2U2YzNzT1pnZ0EyVXFJRnNEQnVrYjRVSXJ3cWFJ?=
 =?utf-8?B?VTNBS0p0MmRIRWZDdUx6U08yd2I4dGltNHhIZklOODMvMWFWcVhsOWg1WE5w?=
 =?utf-8?B?d2NJbkwrZ20rbHE3cFNyT0hhcFZ4YXByWVRSN3FibngvbWZlNE5vQy9Db3ZY?=
 =?utf-8?B?YXpGcVR2ZEZYRlp6RmcrVVU2bWdUWnlpNmVNTnNXTEMwSjRFRmVoYkl5RWJt?=
 =?utf-8?B?Nkl2YzUwS1QxK1A3V0U4ZW9pS3EvUW5jQ2ZhVGU2eEpKZktSMTRwcVJaK2Rs?=
 =?utf-8?B?anNzRkRQVXdwVFJlU01oNmdNMnB0QTNvdXU5Sk8yRVYrbzNKS1BSeEtyeTNh?=
 =?utf-8?B?bzdhd0VvajJPSVU2YlFzSlN1VVJLcXVObCtvdWdLaGtJMTlRZk1SVjFMVTd4?=
 =?utf-8?B?TmIrZDZVV3RiSTFFNE8vWXJMTVBUaUxMcWsrcHJESU55K1Nsc2Q3VStDdXBh?=
 =?utf-8?B?NDlZd3owcTNRMWRRTFQzYmdhYXVBSEpFVE5DZ01iaFFVbkdzSkgrNE1VakJ4?=
 =?utf-8?B?MUNyMDlYL0RWMVlIbkdKRndUdVFhb0xDMEdoNDRvMjZGSzFRbjFFek9YKys1?=
 =?utf-8?B?aG11VUZUd3ZYVW5vcjFkdUZ4UGM4d3F6SVRjV2hhZkNtYTZENlQ1aXJ3VHUr?=
 =?utf-8?B?VVFPdGtQcHQ1MmtpSldzVThQbFNXSEV0RjBpUjgvUkhZZlBUQVovN0dvZW1Y?=
 =?utf-8?B?Mk1pejBaM25HRGNBcktTN1I0UVpOZ09mTTdWSURTZFFiMG02TTRLOGxoRVV5?=
 =?utf-8?B?bVFLSWw1R3J5V3oyTDN2a201djVqQUVGWTJjMFozbWtacWIyTlB3YjdpdDZX?=
 =?utf-8?B?S1dzdjNzRStUQUkwcVRLeGJ4UTNrL0xzWk5KSFFkZ1lYNlc0M1BaK2xzSUI2?=
 =?utf-8?B?azRpR2ZJYy9vMmtJVjZwdEpwUnZEQzdkWWhSL3VRUjVWa0gza2tpeHEzampB?=
 =?utf-8?B?MWphNDNTTk1EVlg1UlYvK1c3ekZLU0pzeTFUNFVORElqc3Nya28xZEtRbDFS?=
 =?utf-8?B?N3dyUCswQjVxQjN2Sk9uMnpEYkxZRkRYNEJzTnpCZGFSVkF5dFFxN0xxNVNZ?=
 =?utf-8?B?VThwYmttNTF4N1ZKejkyM0g4cTRva2ZOb3RvV2lQVUwvSStvdzNTYk9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnpOWUEyODlIaXdvV21ZUFBkTlpWR3RjbWxEdHljRUV4UlFyTnA2WmdGTW5W?=
 =?utf-8?B?MGVHYThUSkwyMUowZ0NFTkZBdVQ5Z3VtZWxDeTBMd3lvU21GTU1UU2dwai9C?=
 =?utf-8?B?N3A3cENndDR1N1UwbTNrb2pHUHhLWFlyUjBMcXA5L0w2N0doMFNIbS9LejJ0?=
 =?utf-8?B?ZUc5ZFdUcTB5d1V2UmVia1ZxK0ttOTNIQzVBZkd6Mk4vM3ZYclBWc3kzYTBq?=
 =?utf-8?B?dFJZZ1h6RUF2RFFha3ZhbW9pVmUyUTNJVjNLdXVMemZsdWVTWElMZkRQUWFi?=
 =?utf-8?B?WjVWS3Noc3FzRW1sS1F2RmJEeUUwUWdFSWx0Z2FabmZEb1RPZmxMOXc5YWd2?=
 =?utf-8?B?WTB1U3h4WmttaGZSNHVHaEI0SllXd1p1cEgwTmI5M1FWMGpydCtzcTdmLzZl?=
 =?utf-8?B?VEJHa0hKN0UzSUtLeFozanE4MEpxaXptMTRZRVp2UTVmcW9wVktvVk16ZWRW?=
 =?utf-8?B?Y2pLZllab2lCK29USUV5S0gybk1zN3FMazlSaVZQZmNMcWw2ZGpxNUc4SUMx?=
 =?utf-8?B?NGtaOS9jdFBUV1Z3TDhQRkI4ekxCS21QQVVJYTRaUGxrOC9HVHFhTUtJNWZx?=
 =?utf-8?B?MXcyUWIyMTFVYTBHa3pPOHBYcVVVWlJIcXlhZWltanRyR0hkREdVbXA5UW9u?=
 =?utf-8?B?R1NPb1pPTXFJTERKdURSUm00YkZEbXg2dm55Y0xtQjVTcUVzbTVQUlBNNEFa?=
 =?utf-8?B?TklvSkg0cm40VkxvUjFlaXR4MnhJYU5tQzR6bEFWQ0pHb3RuaUoxTWU2QUQ1?=
 =?utf-8?B?aXFwak03a3JDVGJvSjA2MTZzMUZvSkVIS0NHZXo5YmhlQVNrZUduM21Qa01o?=
 =?utf-8?B?Ung3dmJ6U2RYL25UajVVWXJKZmUvQ1FESUk3S3lUZDdpNnlBNS91OWliQmFK?=
 =?utf-8?B?RFh4RDk3aDhRQ2dKaGtjd3lEMExaRnF0bEF0TDR3ejNQeXJGT1NmaWJnb3A0?=
 =?utf-8?B?dEtLclYyT2c0ZUZuVCtLSis3S2d1bzY5d3RvRnFJV2phbVp6ME9pRGhzWVN3?=
 =?utf-8?B?TERyZUM1eU1nNEJFc0RqcG5SUGlLQVZEbE5UZmI0ZTM0djBUTW0rTllXZXpS?=
 =?utf-8?B?RVlxWGlHaENMWlpYMk4zdkNJdFE2dzhHNXVhbWhqRERma3dvVC9YNWlxRnZG?=
 =?utf-8?B?d09LdXhyU1lhVFdBNHhMMXZNUmp1UC9zYURFRXBPWmV3anl1eFNkNWRFMHZ5?=
 =?utf-8?B?RCtTRlZ4dzAxY1ArUGFEZjFTaFJMWUozelFJNnBqcDFLZlYxcEZST29MTjlr?=
 =?utf-8?B?aUUwT09hVTE4NFpXU1JoU0pLQ1h6aHNIUjBVZmNpYTB2UVZPbDhnS29aTjVT?=
 =?utf-8?B?NDNrRTJNNC95TVEvNmVGRE5HQUJMdFhRUGJPWStTZzhtUksxbStWOStvVVRz?=
 =?utf-8?B?MmlvbHg2dm5OaWhhZW1FZnZiVmNPa1loTGNJa2pHVFM0c3JrcTZUcDdzbFpK?=
 =?utf-8?B?TUl1UDg5RDFEa0VEUFY1WjZqaDVWa1M3TGs2QzhiT2REcC9LK1AvcjkzR3Nr?=
 =?utf-8?B?YVFaTEFMZURoNWh3Umg5MGwrT2xOUERSV25ROTVZU0taZ3NTcHZ4UmJOOHpF?=
 =?utf-8?B?OW11RXdlanJBTC9KdGVMUGVpVWhOSjdpWUxJbElFRXdzNXc0N0hxbkN1QlM3?=
 =?utf-8?B?QVZML1cyWUlONElJZWRvUXhQY0RBak9kK1R4eDJ5YzROYVB2QzR5NlU4S0Yr?=
 =?utf-8?B?Qk9YWGh6VUJiSy9vSTNjOTkyb0FWbHREZEpOUWxJUGRIQjcrRmZZMVd2SzJW?=
 =?utf-8?B?TzZEMmhXa1YzL3B6VGxCTlFTeW5MNys4VjB6UFY0T2YxeVE5V1VoNFVYbDFD?=
 =?utf-8?B?UWdaTEUyYjhZWUhkd0RiaHhSNzRSQVdRN29tVDhZejBHc2x5elNsUkxHR1BE?=
 =?utf-8?B?VnpHYXlkSGhXaXBZR3BMUFA3bWJWQVB4clRaTFRMRmFpWG5OQVFLNUQ4b3px?=
 =?utf-8?B?aXViYzRQcTdtdTRhVzdhM0twc2tuRTR3b2plZStNM2ZHcWtRd2xBZHNnVXV3?=
 =?utf-8?B?R0pRVlhvcWs5Q2dtb2hjcUt4c1VIbWhoSW5zekZiQmtxMGdSdCs2OG80S05T?=
 =?utf-8?B?UEpVWk5wVTVJbW5zeGg4SXFKLzV0ZUE2UzcrSm9JWk5Ja2RSYWNhRjE1Sjd0?=
 =?utf-8?B?M2NSVUQxRWlaRkU4aDhTb0pGV0lCbEszT2paMjcwK3gvYUJCdGsxUkRnQnN0?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VeQU9VT2nEtDfRG8+PEWJzozaHWw6M/+dyo/l6id9Ah8EFi5FMkmmkwoSWiE55Q4ZsDLQ5XAeqp44yHCKW1l5cARSIR/lbU1PtNsSSqDP2heS8WgYShO3bdthtYxxHu0J/ycCta0pnFz8PVC5C5BTNxe86YhI/9us7MzFF/M/KrHUFmLKZEj5xIlccdkiw6aKDx51ove2a731AZ26Xaa7Zc44nn2+oG0BiGL/oeyVIvJ+kTP6ukXxb07mQXYqIRi4c6tA7IppNaa7S+MIyb6ll3EJN4thty5mGPsaVUlzz5yPMpPXZIlz16tK4eeLppiPzsH3D4eZoyaLHyPDa28axcodGxXGx/Rn/y1YqDIDSx1HZN03ElsMZYuSyQyG8NDfXKqcrEgxRD9a2eKsNsd962g7IqNQb6sNyRDSQjcvmsjUNwct4jdFhKLCDxgqbARg7ljjIHXnHa/Wb9SpsWxiKYXrKfonXsqceJJQZuEXiYIBee+5UhZBDLVYkyXDuZts8HG4PlTBGin5eZzNY1H09RpTJZRlLXiqSaQCUoeACY7qPRHMJTAfyx8Cfue05+gO+66jx9Appa5Xk4s1MWx6lHOpmxkZM11mtlpYD2nWn0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a35735-9b2b-4490-4223-08dc6f7a98ba
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:19:12.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWUx/9sjq/el4kdkxKyeU6pOaFFU3udrFnfKn3QKtimDA7Yg/XXn8uXR4iXgh40UErMCy6rYRWOaRFpxaZpxyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080118
X-Proofpoint-GUID: VAa_5XR1Pbg8mbpLEnFvq_jR-Y7qrExA
X-Proofpoint-ORIG-GUID: VAa_5XR1Pbg8mbpLEnFvq_jR-Y7qrExA

On Wed, May 08, 2024 at 12:56:37PM -0300, Jason Gunthorpe wrote:
> On Wed, May 08, 2024 at 05:31:00PM +0200, Zhu Yanjun wrote:
> > 在 2024/5/8 15:08, Yi Zhang 写道:
> > > So bisect shows it was introduced with below commit, please help check
> > > and fix it, thanks.
> > > 
> > > commit f8ef1be816bf9a0c406c696368c2264a9597a994
> > > Author: Chuck Lever <chuck.lever@oracle.com>
> > > Date:   Mon Jul 17 11:12:32 2023 -0400
> > > 
> > >      RDMA/cma: Avoid GID lookups on iWARP devices
> > 
> > Not sure if the following can fix this problem or not.
> > Please let me know the test result.
> > Thanks a lot.
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 1e2cd7c8716e..901e6c40d560 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -715,9 +715,13 @@ cma_validate_port(struct ib_device *device, u32 port,
> >                 rcu_read_lock();
> >                 ndev = rcu_dereference(sgid_attr->ndev);
> >                 if (!net_eq(dev_net(ndev), dev_addr->net) ||
> > -                   ndev->ifindex != bound_if_index)
> > +                   ndev->ifindex != bound_if_index) {
> > +                       rdma_put_gid_attr(sgid_attr);
> >                         sgid_attr = ERR_PTR(-ENODEV);
> > +               }
> >                 rcu_read_unlock();
> > +               if (!IS_ERR(sgid_attr))
> > +                       rdma_put_gid_attr(sgid_attr);
> >                 goto out;
> >         }
> 
> That does look needed regardless!
> 
> Chuck?

Releasing the sgid_attr looks sensible.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

