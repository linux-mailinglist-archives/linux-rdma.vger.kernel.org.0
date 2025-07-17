Return-Path: <linux-rdma+bounces-12270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96497B09131
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 18:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2D31C46B06
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D10D2FC3C1;
	Thu, 17 Jul 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="StTVtaor"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5A2FC3B1;
	Thu, 17 Jul 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767818; cv=fail; b=e5Svd0JN1NoFTmm9kSC1a03VuVGdR+LVWFDZua1sGG9/+Eqd3tznWk3aRL3Ot2Ols5Y2giitjnLB2nBk1pmxVVO1t7kMBMG7aevKxcEXNlYL/ludFVq2OMusJy0G5V8pz7XluZk+GSQR5ekCK7R+AbG0KF3aLEN2EsNIx5cKjZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767818; c=relaxed/simple;
	bh=bRQVIvC7U/M55o4NPUK71fCDAh9YmYToMaN3t9UBS/Q=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyYw5+xjslozkvcSp2EiTgKc/tMPzQ1kV9EfEqg2L/19TxwhmQJdFpilu1S2lQzL7EqWKbBBdSiZu+q96AThnpOVos42ATn3o3inj4rZlEQH5kDixM86qq21WF9u0J+Ea9qjHT+f9f2uHqALgLrrkdKW+gEqDDEF5NSsAGw4mxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=StTVtaor; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5awxQYoqz0Z9pYvZxLPkc4TjeOpt8ye/ebkS5TItUIF6VjM23wMLgkl0aDUT5JFaAxD29lJvJQWkeZ6xgQJdlZaNcvfYqx02PhPqNcsyF6h4GE1mXV0+AkyqeHMVzzsrpSefuEj+4zutRzRv/bxcdKFGpmqH3Gy3fislcAPExXLxavfOVjzg/m+tsCZf6RWpaU/HJWXklQWLoOL1oO9zF+wEtkXcX6QKWFT6NqXMW2U3ckWdXF/JS8fUXrK5mgZADBrERdiqg88PSWsUxChW1poWUkC9WqOIGPq7/48BQmUST1dfHacIcU7BXyVbmmgY2RTl6zbtLGLRw/WgwcgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvFb9ZwWPqGd5KVtPbk95VDVCFzwLdB05OzrKFOEFuw=;
 b=tB0yB+flyyZJfMJ8s+SY9jZPw/UTN/E9b2P9RSpKsXECyZvJjoqN1+5Lz4YeqtKJ+ySPAFW5YMLym4WErPRYXqjbNIgQ0a5SFMVJ9S3T6HrtDMbj5Qfye/6c/d1Pd/ia0av0P3kCVqknxXs2jUWNvgwWD1b5+6k/1yt8nxX2e4I4T6l0FFJvBIn9pifDn6eqb5ffIYr6W8TFb8Ns1JshQfgRYLpbnNTMbAF9b750qi2LvmDjVvyzHX2hhFkQboxlM1N94BX4/NGoqlFzD5nq+XnTcmBmE/lBuhFIX304xHyfqk2js01r96wvF1q7tkDLJ7pB2poGAdJOAA7xkCwBng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvFb9ZwWPqGd5KVtPbk95VDVCFzwLdB05OzrKFOEFuw=;
 b=StTVtaor41zg7pnQyJO1Gj+594ByYa6pm32ZkduoTtGnfvNqfPAL2vM9rsWs6+PtXwLQSlxF3Hdkuy7ClLVSW5E78u2HCsJ6sodkMxfnHVaSSpLlMXQaX5ZWAJyKorj2M69rBr1h6ej70a2dXECZUgdNWipKn5KvunjSGfdly2sMHl3AUaYfw8BxZ3dExxWv2a7vrR5ISrKZqB+uzeqyW+RL1wD/JwCwNaCe2XffrIX3snZFzhRT/+t/fQXYwpA/zrhh0+h28dC3oTjGsiGiOr8dDqLRgzlDjRCJgtn905SocDKoJGM54j2FDU0vQqJSNOW7nM+/dfzW0dRCb38RTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:56:49 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8901.028; Thu, 17 Jul 2025
 15:56:48 +0000
Message-ID: <4b81bea4-ef05-4801-8903-2affa02d2366@nvidia.com>
Date: Thu, 17 Jul 2025 18:56:42 +0300
User-Agent: Mozilla Thunderbird
From: Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5: Support getcyclesx and
 getcrosscycles
To: Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
 <1752556533-39218-4-git-send-email-tariqt@nvidia.com>
 <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
Content-Language: en-US
In-Reply-To: <650be1b7-a175-4e89-b7ea-808ec0d2a8b3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: d7313cb7-1424-4e79-4cf7-08ddc54a89b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk5WRzJJbGZMMExQem54Sy9naS8vVDJNN0VCdGVlbFA2ZG5YbnplcTJ3c1J2?=
 =?utf-8?B?ZVBnR2t6dCsxdjRkbTcvOW5YWHBQZGFHRGFpYlBiUmRYUUFKUE1QWFJSSkdk?=
 =?utf-8?B?blQ1K1ZlQ0V2TkNqRDhCdXBYenhMV3NTYVNEbEpOa1MrVzRkMlA2UXErYVQ0?=
 =?utf-8?B?a1lYREdTdGZqcjBCeGcwUVZFZXpzOFF6NDNleldHSjFjTWlmeHNuZ3hoYldh?=
 =?utf-8?B?VXJ4ME1EQTM5U0d2aldGcHF3ZmhJQVBmZjcyUE00MEtMem52VW1wN2IzYlYz?=
 =?utf-8?B?TWQ1M2FIdERRR1FHaWRQUFcrb2syWVRmbTJIL2RXbitQUU9DWW55VU9FWExt?=
 =?utf-8?B?cTMvaVZiNFhaRUJ6RHAyZi82ZGwrNU51VTNxaFZBaWltT2daTG1jTFZBMkhD?=
 =?utf-8?B?NHZGdzVrUWVkZ0QzK1N0SzBwTGI4RWowbXlCSkRSQzIzMFZJNmZEVUxWZ3BJ?=
 =?utf-8?B?U0g5dlJRWGpIQzQwWTcxOFJ4YnlvRjRsTlJwckNhak1WMzlBNE0xRGcvdFpy?=
 =?utf-8?B?Z1FzbGRPVmJtZGhQd1hPVnBiam4xV2JlRlNPVTF4RlpLMzVNMytkRGxtU3A2?=
 =?utf-8?B?VnlmQ1lOZFRXRC9XNWVIaVlULzZsblBqR2ZRUGZlTHoyOVE2Wm02MW91UjNF?=
 =?utf-8?B?Ykc5SWh3N0hmcXF2SEdSUkJ0ckM2TGtrRXRTRWxBaFVuVUFrRlY5R3VwTXlQ?=
 =?utf-8?B?dS84K2N4TUM1aTR2QzBBT01sOUNySmlKSXpvMnRNR2Rod1pQUU9OZTFra21C?=
 =?utf-8?B?NklBeGxYdEVrcUd1ZjVybHRzMHpHcUNwdkdqWVY3ckdncVdMNjJxU3FmN2M0?=
 =?utf-8?B?azRNQitIam40SkcydC9NM2k3ZXBCNjNMOHRUOHliQy9HVzI0RW41Q0FxNzVD?=
 =?utf-8?B?akhuVHBqZWtJKzJySkV3dC9ybXJqY2VXbVF5RGM2ZDdjQmpKaTBXdHdlMk5a?=
 =?utf-8?B?ZGVFQzJ2Syt1OVRLWkNuVTBNd1NLdHlPamVienpuU3c4Y09hdjNzbzJkRjVs?=
 =?utf-8?B?eWNiTk4zbFU0RW0yeEJ4WTlXR2dCY1dLVC90WjVPaXJFcXBNMjNLbnRtNlF3?=
 =?utf-8?B?cEV3WDBvRkYzelZudStTVzNjaGRWU1NCM0F4bjkwMndmTk01cWhrakRaT0Y2?=
 =?utf-8?B?VXVpRElkTUFkdWhOOWV1WGFhSjE5RFFNYkIwUy9ldmZFYzJ1V1pncUhoNUNk?=
 =?utf-8?B?Q3RZYjcxZXRPRHBQUFBVS3QrMkxwMWF2SDY1QTVLdng2L042bmhIaFY2am45?=
 =?utf-8?B?L1pIRHYyWmNUMVZkdWp3Y0lGRlVESWk4dDROVEl2NGRHYjhrUi9wNUMzTnhj?=
 =?utf-8?B?V3BQT0Fhc0Q2M3FPK3QrKzFuSXpydE1obm1nYk91REtaMlJGT0twT3FhcDJk?=
 =?utf-8?B?TElJRGJBZHZTWkpLV2JNQUM2WllVaUtkbmUvQjh6Um1aQkMrbWp4ek1kUFVU?=
 =?utf-8?B?RW0wemRDcU1VZWQzdzVvVktaWmhDeFNKT1JZbyt3RjVCVDFnb3dKRjNkL3Jn?=
 =?utf-8?B?dCt5cHZVUDUzVWRGVkdwY21yc2lGTmhYdGdWdXIxdGVrb2VrOGVJcWlzUU9t?=
 =?utf-8?B?bTdVZmMybmI2dWV6UVpqTWpsZDhiSGN0d2s0ODhiRWJwNnBiRGUxek5Hb2JM?=
 =?utf-8?B?Z1YvSUtXdjBpS0ZNaWV5bkVSbFhvaFNrL0Z1Z1BQT3ZadDZLaGx4ekhwVUZR?=
 =?utf-8?B?T0Y3OHZacnFRbXMxNG42MGpYaWtCS09KUWpVS2ZmRmNUZ2QraWE2UUJCRkpx?=
 =?utf-8?B?OGgyZEJBQ1V1YUNCVzFKWm1nQlNNclQyVFE2Yk4zalhYbHJtRXJ0azQ4cE45?=
 =?utf-8?B?RE0xVFJoK0lMZWRDRUJxU0dzSktxb0hCSjhNeXlEYXM5Lyt3UlViYTBnVFRO?=
 =?utf-8?B?UldwNllVWUNZblA0aGpuR0NZSWMyalZXZFVWczh5VjJmZkNUOXF6RmdVZEdi?=
 =?utf-8?Q?9xkCy7Z0Cmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy9uUVhJUWZBUWwyM3MyVGdTOTBERC9kTGNobDh5SjYwaEJEcS96b3l1cGdZ?=
 =?utf-8?B?MjNjM0NXOWNyNEdYVEZIRjBnKy9qcHpSK0p2T0ZrNkpIWllNR3lLSC9QQWx2?=
 =?utf-8?B?VTZZUnRuWE5QSnpNNUV1VXRKUlRYUmhUWjgwMVRRYlVJOWdnWDdFKzFFVVM3?=
 =?utf-8?B?M1ErNW53aWhXeFV0L0R6TlNsbmhjZFF0YlBENlNsYlc4bHp2VHZCVVp2eUZn?=
 =?utf-8?B?dUFQVUE1aEgyMWpkbnEvVmphUFc0S2xWbVE0dU02Q2RjYWN6ZXNhYVdZU3F0?=
 =?utf-8?B?NVZRUEJtWklvYWU0VnVkdWVhamRJcmN5dUczMWR0b0hLWWZkUDlNc3pycG5x?=
 =?utf-8?B?QzVoSndQKzRLUVVEMkp4ZjFiTm5DcG1iejN4MXZxVW85NHloM2RJYUNuek1S?=
 =?utf-8?B?ZUdzbjNLWlZYQ3dSOTNWOFoyYVg1cU95UXhWK200OTVqZFc3dTk5MEx4c1pz?=
 =?utf-8?B?N1hRNGgzWVFheGxZQzcyc0FyQndkSXpkRFBWUUhhNGJRZXdwcWd2YUpLRlhO?=
 =?utf-8?B?UmlpN0MvbmlabkQzb3pJQ0dNQTgyZWVuMVdBVm9LcG9jL2ZGakdBZ00zeFlD?=
 =?utf-8?B?R29oZGIxV2g2TXNkNDBzbHdMTkMyVkZ1RjVzV1ZmY1JlcFR5K3doVEdzR3dE?=
 =?utf-8?B?Uld5dm10NGwzd29zaVB2RWtsZGxNRGdpQSt3MmVZYkJ6am9xVEpZamlyaWQ3?=
 =?utf-8?B?TmdyRm5xQlh3Y2FnUmVkMitVbzRHTVhVTGdwaVFHMU0zV2RiVHRTZk5YYkpu?=
 =?utf-8?B?TEhjM1VqcE5nQm5LNkovM2ZwNHhqL3VmemFDZVU5YjNETEtidUFnTmpJcDVV?=
 =?utf-8?B?MEp1RjU0T0xweitsZ2RleURqeUdMZHJnWEQzS1Ywc1czVkpkd3Vkc3Y2RWo1?=
 =?utf-8?B?ejc0YWZTa2hQak41Tkx1V002SnE5dFZVekx6N2l0ZUNEbjdLNDVjS1ZoMXJi?=
 =?utf-8?B?OUNHQjR4Q2doa0NyTDdFNndpQkFocG5SQmwwbnc4TkVLSzB5UHFqMUNLQjdt?=
 =?utf-8?B?MlRRZzJSYWxzeWUrS2c1Q3pBSFlxT0hmMFRqOTlRVVhnbkFxQ0tyUThVQkNF?=
 =?utf-8?B?RlhSZEVobk9zV0VUY3FxbHNHMDZpRzdKTzJPZW1BVUMrWVFDQ0VIUXJCQ21Y?=
 =?utf-8?B?NjRaMDl6Y0hodlJvckdKYWFPUzV5OURYZklnK3Y0UjlLOUowYnk5c0FuUWRX?=
 =?utf-8?B?NDl1a2tUb2YwSTB1ckVLRXM3cVZSc2w1aDFSc1ZYN1BidEl6WnU0YTJ3cFJp?=
 =?utf-8?B?R2dXTkdQRTFldk9FR09NQmQzaWZzTG9jVmJBa2w1L0Q4bzRQT2ZmU2pmd0hj?=
 =?utf-8?B?Y09vcFNZN095YUtjZXpPMnB2RXQ4RnVUTFcrVVR4M2hrQUhtVUhCTVZJTDBm?=
 =?utf-8?B?b29PVVRVL0twbGEwbzFHdHlFdzZ2VEl3MWtyUDRvMWEwM09RNjJIclE4R0Jm?=
 =?utf-8?B?ZEJBdGRRem15M0UxTU9WNWYwaXBHVTYzT1lVT2hHNE40a2NlRGoreHRiVlM3?=
 =?utf-8?B?ZG96aUdjeEpqS3A3Q2RPc3hhWDJ2NElrT2ZuUy90ZzJtNldkdHYzTFFyc3Iz?=
 =?utf-8?B?T3RGenhUazh2My8yZFF4eXZXZURSa1hwNzhsOGV5QWlpaUtlSXFEYWh6RzFP?=
 =?utf-8?B?MHVhSkZheUMwcnFEcG5YRTlvKzlDQmtBK0VVUFVxTDRDeGZvVVB5bTY1Y2Q4?=
 =?utf-8?B?Smx3aWlMVDQ2VStyNFZNWnhudlQxMXF5RWF3cWpkOEl2ZWd2MXNRR3RKcnRP?=
 =?utf-8?B?VkpTQ3RQcXoyOUk5bTVMaGxrRzJVQWI4UUZBalBISCsweTlFSTdhbFRVdG9D?=
 =?utf-8?B?YjE3dlpQQXNqUVBPdDdKT20rU1JVeDF2WDBBMm1EY0dQN0dYVWlzc045ckZi?=
 =?utf-8?B?MGN6UHRrSHI5UUJWb2tmaVJrOU0yME1zWVZQUG1EK2hRQXdLSEEwRHZHUXdj?=
 =?utf-8?B?VTRSSk5yUzM2SjdGajU0K3FVUG5DT05KWndDeUcvM3F3QmRpekZZbjlUSkp2?=
 =?utf-8?B?RzAwOU5SYjFQeFVFdG5TeUgvQWpxaXJPWjRDcERjYjJzb0JibzVoWEU4MTBC?=
 =?utf-8?B?eHVUYUYvTURHbk5UN2QwRXpVemZMem9weHZ0RE0vTjNEeDQ3SmhhMlJEYXZz?=
 =?utf-8?Q?nmQzjqTR3ZmvU/IokdiOqUCZk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7313cb7-1424-4e79-4cf7-08ddc54a89b1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:56:48.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lmm9yw/Vtx5WTXdDzNGZN8oXLtEDQjNHqQ7lc9761zYTrWYpU6w7v9Q6ACAX1ty4SsxGgsy4TV/EkXUzPXXYfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257



On 17/07/2025 13:55, Paolo Abeni wrote:
> On 7/15/25 7:15 AM, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> Implement the getcyclesx64 and getcrosscycles callbacks in ptp_info to
>> expose the device’s raw free-running counter.
>>
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 74 ++++++++++++++++++-
>>   1 file changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> index b1e2deeefc0c..2f75726674a9 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
>> @@ -306,6 +306,23 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
>>   	return 0;
>>   }
>>   
>> +static int
>> +mlx5_mtctr_syncdevicecyclestime(ktime_t *device_time,
>> +				struct system_counterval_t *sys_counterval,
>> +				void *ctx)
>> +{
>> +	struct mlx5_core_dev *mdev = ctx;
>> +	u64 device;
>> +	int err;
>> +
>> +	err = mlx5_mtctr_read(mdev, false, sys_counterval, &device);
>> +	if (err)
>> +		return err;
>> +	*device_time = ns_to_ktime(device);
> 
> If the goal is providing a raw cycle counter, why still using a timespec
> to the user space? A plain u64 would possibly be less ambiguous.
> 
> /P
> 

getcycles64 and getcrosscycles already return the cycle counter in a 
timespec64/ktime format, so I kept the new ioctls consistent with them.


