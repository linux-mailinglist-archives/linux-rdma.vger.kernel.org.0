Return-Path: <linux-rdma+bounces-11816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67692AF0A2E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 07:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418CD48555A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 05:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A43B1EC014;
	Wed,  2 Jul 2025 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i8oIcCX8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q9ncAKYr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3598836;
	Wed,  2 Jul 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751432920; cv=fail; b=VOG1+w0Ul12drZWWI7PzSaEbWiGVUqG7iemFSi2TWBT4bR9lqaCP19NeavhDpEZP3atpjmSPJnt+tOh3IZ6rf26kZGFxUGT26flXOG9JbEEagP3hDSzu972rUQJa4RwCtjMGxpajifwNEKQdYP16NfZYD/V/pC9XB1CRzncqCgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751432920; c=relaxed/simple;
	bh=TVa82AIzsew0D23yJy/KL2L86+Pe60KPYM3MHUw52ag=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnhg6wsTiRLbl1oIdsZXx57P6+PnONLCVLdurQQsrBPm01s/xclb5pqZSz6rdGCHosoQw/8wCct/A5OALZI+v/yT/SrnN3RitGmZIZVpqy1jDiZhrTgmJdGLG64D8p2vAY4TuwN4mBv/gck1Upbn7mgiiiKStBQfJdVgUGXmsqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i8oIcCX8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q9ncAKYr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5623fiwu006808;
	Wed, 2 Jul 2025 05:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vLGIbKK1quiQxwqduEV83j6CmGCPoH08rA7wVt7bOuI=; b=
	i8oIcCX8OJDtihRVs4mLcxR1s6ep20o+XJTaT6LkxLiBUyMkJ4WlF2Q+BO8L8sXF
	uer/YdMup7hEhRPFS7MbWaE4P8VHFpdz+PSvmC4TwZXCeSqFUOzJ7haNnL4KGbtA
	yEpstQ6FH0BeroBxRAahGdJc1H/hr8Zr+Qy8hbJTR/uxEDaAuvJELPcYotMufKHx
	gpEMRG5aL3fDp0eWrjgj2RyJLGf7/u71w5JRYngpGiyqsLXXvKJPwWPDAgxLDuZU
	nFV4h+epZ/0F4Ldb4x2jh/UP1XMlfy2iy+AelPkLtzjnN/lKwvIFVRkUOVX2vSTu
	XGPA7OAE4zYDwSPn6/WkhQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8ef64kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 05:08:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5624R2Xo030219;
	Wed, 2 Jul 2025 05:08:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uaqtkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 05:08:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYs9K0bO12xQTdjHpYXscY9XYaoreHIv6wdUu+EFPApAIFo/bZTYrjTt1dtHewRys6i3pgnB6pIHOVcH6X54tutUS5YqAqg41JZE73DXBPDYD9RbgfNfVIb80UiDze4D6vsrkpEPlr6hlbclz89Ib6TkZJ6bn2EXG4YJZ2Uyz0UiZnRvnwDC0906JCbnP1BvUSFTMJqvagbJymPXbG/bbaI8wIbI53dLQcoj/nfpRZUYP6CB1WG+MxbnyZNKrE6MuD4qhomUOu/dofwutLSQGyZhncEpHlzzi+32f+RAEeCdq4ZTrgf6RE7/wi/Tv7xk70FoywEI+b7K0xcRIffaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLGIbKK1quiQxwqduEV83j6CmGCPoH08rA7wVt7bOuI=;
 b=NCi9k6ky4BmUqpkegUHZ1hcTgy0NI9rAbw8QEUBikz8IxOALhIDBBd/PAIL1wF4wDLNu+gxa9c22vaZ+qKw4u3ESJ0D24JH8TZTluaSRaPrwWLYm2QEAVm8+mB32aMBUMcNF8Jwl0PBsB1vvTtUovCnoMMksaQFnsvgxQk7fOo+tH8o+qqWQv7OsbczBi4mu4/ARJZBG1/QMhoQqc3oibNqVH560xFolJxL3WFbaO+NwdUUWNreaEcsbAAhOJ4nvVisjz3NpNgsz+7vhpC8ujAevfXxxleMNG+vSS9RwdjZP4o+fiRLaeYzlmferl7wRdlhHaBUnQM3AvI+JisOQgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLGIbKK1quiQxwqduEV83j6CmGCPoH08rA7wVt7bOuI=;
 b=q9ncAKYrkGiDjkmewciJW3e4rAvHxXDzrJ6BOTGZoGJpEOB5g+e/+8H3ilEHATva/wGaex0zLXUw97X27HmbU4oDSW+qDkiwDR1ia3Va1ThfN/pT8+YfOUuvrw08Kw+UYaalIUUrMZhXgLVf3byist4yL+S4Anf1t5NTKo5m8BI=
Received: from DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) by
 LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 2 Jul
 2025 05:08:15 +0000
Received: from DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92]) by DS0PR10MB6056.namprd10.prod.outlook.com
 ([fe80::c672:69bf:51cb:db92%5]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 05:08:15 +0000
Message-ID: <d1b697de-ea53-4634-9821-f403090d3e09@oracle.com>
Date: Wed, 2 Jul 2025 10:37:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next 1/1] net/mlx5: Clean up only new IRQ glue
 on request_irq() failure
To: Jacob Keller <jacob.e.keller@intel.com>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org"
 <leon@kernel.org>,
        "tariqt@nvidia.com" <tariqt@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com"
 <pabeni@redhat.com>,
        "shayd@nvidia.com" <shayd@nvidia.com>,
        "elic@nvidia.com" <elic@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Rajesh Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Rohit Sajan Kumar <rohit.sajan.kumar@oracle.com>,
        Qing Huang <qing.huang@oracle.com>, Mark Bloch <mbloch@nvidia.com>
References: <7cb171c4-3c36-42ea-bd6f-52dfe6bc5dab@oracle.com>
 <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
Content-Language: en-US
From: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>
In-Reply-To: <06e99d8d-a6de-4687-b109-0d1557ac2779@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::9) To DS0PR10MB6056.namprd10.prod.outlook.com
 (2603:10b6:8:cb::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6056:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a19401-04d0-48a0-bd6b-08ddb9267300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzEzOGZYVVVyQ2U5cHd6ZENYWUovNnVYeGtOYWFWNVJUOUx4K3RzeXpDU09l?=
 =?utf-8?B?T05qdVlyN25wMzRYemhwSHJQZFYydTR0L3UrV3FzU29DenVCRFdKamNQU2dw?=
 =?utf-8?B?M3BUMnlkQy8rTHRobHdXaXNnNE94SU5weDJ0MmlmKzliYW04Nkl4WUhwQmd5?=
 =?utf-8?B?bXhkdE81dU5yRXBva054V0lhR2xyYVBVVFJKdStDN0VVS3pvbDd5NTl5TCtP?=
 =?utf-8?B?Q0dncnFVb0hjN0QxbHVaVDJmK1R1a3dyQjlmakk3ekRLeEJDVXVHVzhIa0V0?=
 =?utf-8?B?eXlzbTlGaXB5N3BQZFhVZE5ObEJFNmpsMTdZTWc3QStTU256a0szVlF2S29n?=
 =?utf-8?B?TzBwWHRpZHVJbXJGWTFRMGt6NmRmVlc0dVU3YnYwQUtpWkltY3MvMHkvMWY5?=
 =?utf-8?B?SHYyaFBUM0czQ0NaZlB6ck9yemVYTk1lQkg3eDRoTWpnWGpacDNxNnlMRXcw?=
 =?utf-8?B?K1c1QVBtWDU4eFlib0lqdXEyQzQxSnZlZjZVZExOWGpuZktRdWNtT2lOYkwv?=
 =?utf-8?B?cFdPVml4M0lOemFFWFJtbkRtcU56Z1NoRUVjRGVrR29ta0pVR0kzN042NHhn?=
 =?utf-8?B?N0R6RFJxbzRIaytzNHJMVG5lSUxyZ3htSUtUekE3azZNWnpnRy9yYlRxejhP?=
 =?utf-8?B?ODhpTE9VMjR5VGVlRENlcmgvTEJzUEU1V25heE5QUzkxVFd4d2NpdjJWSVFm?=
 =?utf-8?B?K09iZnFXZ0hyYTBsQUk2a3pNQXdnSFJkQzMwbm9CYkhlRHp2bmpJd1l4eXFm?=
 =?utf-8?B?NmhZdzV5SXVLMnhudDhRY1Brc21ISWVIT0t2dXM1aU1rbkhGelBrc0hHM2dh?=
 =?utf-8?B?ODNKWWYrZWNKaGdyRFFGdjRZVFdZbzVaam5CTm9hYzlEN0NlL1dRMlROVUNJ?=
 =?utf-8?B?M3BwWlI4SnRyUlJKeW9zK3lHVkRxWGZaUEdoTEJSQ2ZMKzArU000NXppL2JH?=
 =?utf-8?B?RHhNbzFxbzE3SGhDc2tpZ2c2bi9SU1U1TStMeW04aXNCWnZHbWNQbUdEUHZU?=
 =?utf-8?B?ZmlPSlJQSGpxYWhKL0xnR3QrdHJ0T05ueTJzaHdpL3prWndXTUYvQ0k3OHpB?=
 =?utf-8?B?OENVdU1ROFBiOUZHeTNPYlNrTUpCVGJVTzFLWjFoYjFKcFkxVnp6SS9YU1gx?=
 =?utf-8?B?WjJsVlpVL2ExcVdiV3JzMzROOWJ3YkVqQitUdW4yakljRkVXQW9iR05nR2Uv?=
 =?utf-8?B?aHdZd2cxSEtsVVhaSWFlU3VZOUVOUHBudkxqRTVvZW52S1QxbkdDbmFGY21t?=
 =?utf-8?B?WWNGbFJDZlhxRU1DaTdMWWJvRG9zelZ2Wm9iNkxlQXRhelBsR3ZWcldOZHZD?=
 =?utf-8?B?TTRKZHpBZGZjRGx4NWFNQ2FkVXpGMy96ZmkvcGl1aEM2d2hpU2tkbTZLNkxr?=
 =?utf-8?B?RlFMMU1yc2VJdVg5emtpa0pKaHd0UDQ5ekFaWjZhMzhzdlVRWWtZa2dqWG0x?=
 =?utf-8?B?QUpJakF3aGdEYXhQL2RhelpwSU1OTnBUWEZGRDQ3NElhL3p0RzFIZ29yR1VH?=
 =?utf-8?B?WnRMdm9XcXpsckM5QU1EZkI3N1Z4K1llYy9HVlRLOFFRMnE4eXpoQk5IVDM3?=
 =?utf-8?B?OXJTTFUyam1nVXJIV2xRR01hOElXdE4yZlN0Nmg3dGxGSmRFaHZManBaVnlJ?=
 =?utf-8?B?VngvdUwvS2pUZFIyRDdOeXQxNS9xQ1JaNk1OMVBCY2lGZjRMU3RRYmhHVEQ1?=
 =?utf-8?B?WTY2RktXTkRPbytHR044RittMUVqdVpqd09jbW9Gd213emp6d1ordHllRFRv?=
 =?utf-8?B?YVpmdXdpTTVYZEZGN2Jwb2sraTJ6dWtCSy9KeWJGQTVXVkVXZUdreDBwRzFC?=
 =?utf-8?B?c3JOSE01b2szMFl1WU9iMFJkdlhxUE10QTJzZGtRZldMelU2WEdGcE9PeGxW?=
 =?utf-8?B?T1VVQWhjVTM0YmUvMnpBNFNjNUVMQXlBZGRaQ3c5VmpZdTJ0Z2U1c2lLbGlK?=
 =?utf-8?Q?OtpiVT+TnEo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6056.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlhQMFdUVHNDeWdrOFRQUzZJbjNMR3dZOGNvbUtEVXB4Q2NoQkozb1pDL0pR?=
 =?utf-8?B?cThKby9NZy9DU05KOTRqdEl1RUlqQnpkNzAreXhDa01TMUxzaWVHYUlPTWVy?=
 =?utf-8?B?V3QxcmRHdWFpa0R5WDcvMHlLdnFiSWpxa0RDazU2MEpIK0t3ejg1UDhBQ2dL?=
 =?utf-8?B?M1J1WjBNL2FOdEZic3BSS2EwYXQ4RzJNeGFIQlFieGFMVzVpcm5BWHBEZEsx?=
 =?utf-8?B?a3ErQTVTbkxKZ1JMcFRmaGtCN0xhbjB4Q1haQUV2N1MrYkRzMUlBVkRjanF5?=
 =?utf-8?B?cTY4dG1od2xXNFZyQVRieTZHUnI3aHZORzdncnBLRmdlVTgxNS85Znkxalpj?=
 =?utf-8?B?Y2pjU1pTa0ozMTF4VkpPNzQ0VXJQUy9GdStJeHlQTE1jcTJTa3pnOHlyUzNm?=
 =?utf-8?B?bWlBcnd2VmF1ZTE5NlVhcWo1VjNnYzl4RUhxa0RuNytpaDIrc01RcWZOQmgz?=
 =?utf-8?B?OHhFQ1JCZU5wNFUvNFhzNi9QU0ZoWFZncUlYTnNRUStVUGdwS0hQSFk0NE5x?=
 =?utf-8?B?cngyaFhFK0kxdmF4c2pLZ0tBT290TGRJMi92dDcwczZJYklDY1AxUEFKM2Vz?=
 =?utf-8?B?cDFXWFZ0b2JpbzU4UE5ZRis5WTBiclN3bFVxSXFxcFhkYWg3aU9vaUdPTVFa?=
 =?utf-8?B?YXVQbUc2OXVSczNzS21WbE5jS00rcGRYSFIrRjlVNUJRemUzYTRIUzVOUXNk?=
 =?utf-8?B?bHkrR1pKS2F4c0hidDRmaERObFlZWjR4dzFUaUtjd0ZRVTViOE9TcTBwV0o0?=
 =?utf-8?B?YXdrOUlZWndtdXJZbG5PNGRKOEtZZ0x6ZE4xa29PQ0IwQ29ycVBrTXRkbzhx?=
 =?utf-8?B?ZkRCaTlwVkRTQy94YlY3a3VvSVJaM2R3NjJra01VNFhtWmczV1hCSG1LdVdz?=
 =?utf-8?B?dEd4aDVJdDZvK0RBWXlHTGxBY2VVYjR1eHNOZUdrKy9kM2JYQlQ5dVg3dEVi?=
 =?utf-8?B?cUxndVV5ZEwxQWRGSlA0RW1rWFhvcUc5SHgydHZUcnNZREx3ejRPamtXSXFY?=
 =?utf-8?B?cEZMdzhzcWtjTGpLZzJITnZrMWJjVmV4eGptL1d0NDM2aTRnZ05ydUh0anRX?=
 =?utf-8?B?ZWdpMXkrUDdDWWp5WndEZGRKUFArejZoYW16Z2RSbHRqMmRDYVNjQ1pyWkp0?=
 =?utf-8?B?a0dhVm1sUS9nb0RKaS94ZHRMbVNQbEY0dWZNTEZkTUM5Q1piTzVpdHBnSHpK?=
 =?utf-8?B?L0lnODdBcldGNTBpWThPVC8rc3JzQzFsUWNpeG1waWV6aGlXeXBQZHdOZXBH?=
 =?utf-8?B?dEUzVE5qV1pZdldyYVpsYWh3ZTdpWitkUVlNaFZOYm5oSk5lVjFHSFBJQVcw?=
 =?utf-8?B?WWdyQnJzZmZFVlFVS0w4YUFHZTI4aGc2d3d1QTdyVndBVHZjeHFLTFhtcnFG?=
 =?utf-8?B?Sk4xWGhwcFJhUzRuMUFRQ2o4dWxacnZFMWRKTkFSbnZSc05VUmtqWHJ5RmRs?=
 =?utf-8?B?QmxLR2ZtNWtZNUlVR1lONTU0Z0RieC9SRHN2Y0crRkpCdTJsRXltQ1NGNWVW?=
 =?utf-8?B?aTVVTXNseWkvOW5yUFBXNEJyejZiR1o3L1hmakpXTEhJZXkxTVFKNjQ2dmpC?=
 =?utf-8?B?MXd0OHlYSVJzSlNRdzZtYmNqSDZsdlFYMWJDVjE1ZnlJQ3RPMjJPbFNCOFg3?=
 =?utf-8?B?OG1FVitJSTZNTU5Ib2N4bGN1eml6RkRzcTI1bEhqYlBDVkNvOGFZaWVMZHBU?=
 =?utf-8?B?UkNSSHNsUkhsU3R0bkNGQUZDV1JMdHBmNGt0eEFNbmdBWWIrbVRrOTNFUzBv?=
 =?utf-8?B?cG42NUZsclZRTXpXaERVSnB6MjdSYmdlNGZBajkyZkNvdUFhT21YenpvaGEv?=
 =?utf-8?B?Yk9RbFVTc2RGeUtTbWVGQm9PZFltRXVmdkE1cW1RSm9Vdmp0dWxlaUlPNXNt?=
 =?utf-8?B?dDM0UlFKcXRxWDh4alFTUGNURDFSRGxqcWE5bWJsM2VhYlhDR0JhM2laNG5v?=
 =?utf-8?B?TFVFa0JUamRweUM5NW9XSXpPRjZGY3N3TXNPbjRrWDArTmU5WWlkUmNXVGp3?=
 =?utf-8?B?R01rWGRoV0JYTU9lTlNOdFpkclFMQlFrY1B0VFRrOFdTdGFPaCtTYzlLc0dP?=
 =?utf-8?B?ang0VUNUd1UrM2VsZ2orR2xBRE5rUlFQN1RPVXcyOXN0Ykx3UjltMU5NQzVt?=
 =?utf-8?B?dVZYR1BtdmNhUUgyd2xJYk1lRTJpYUppSTJtR1NTbUNCbjJyaFM2T1BlVkx1?=
 =?utf-8?Q?29Zct+4/dXfZFVFSvf2WW/w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uSVO1S19kpczn+d9DJBkWiPScNZj5mzg7CBsOE6xJKifVZkcuvP3972vQwxNjd45GmrNIKa6QfLSNLVsxCOiYD6FIqBh+gYwg5lQa1aE/i82Q1t+2v1We+iF0uyxIZizNC8zyr5T6FlLMLqwWSbg2/LwaHWWo9ZTb8/LbgZ2WCcssVEUR6qWxA7AzebTF9PUtbwYbbEKkspIRhQuMSxuhFBqlUO0dx1s9fTrO5kuU8yO5Zrdr8JleJ+K9PlTlBDSBe5lY3yOPHfJTE1DMr+8NbqzybMzhi/JZvpCXsKwyLowaNWBOCPt2v2vf2sOOHZTyFlzM34qvnmP1tA+w1Qov0oSokiQU3Vc7n2dhKHbbOI/OcX0XEwqpcKDcChTqsOQQIQHEjDgMqa0gTKuxpLM91h+CKwJBTXfK5sRLfgCnU1Ht1EFHXnqcPecqxtMCDCA96ync2bBMoAe7hcwPNXLNUPUJxiRzdp+pe/UJ0bX4VH+f/9bdsLWwT9I4Vgc6QjGyRcJnKfXWi3gdlsh4MrKvYSVVIYjm4SXfVtZpj8sdFt90dcmJBCZU0qxD7nkXgGke4Wqcvgn+kzHYxVQ6SXv0BaCcClx5t2bkhejNL2ec4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a19401-04d0-48a0-bd6b-08ddb9267300
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6056.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 05:08:14.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ8a8qVxq0xwXhx+ZukHLsc38ekmCJZ1GBJ6PfQF5XLDtZPkPTJW0Oh0HqTL22quEY7hwt0ChzlA+wyUXSDQkINtg3vMm2fAzIRkj30Uh0jnLmF7NF/Lx4Mu7Bpqr0cG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020037
X-Proofpoint-GUID: Vrx8sPixLj0i34QPvbANX39Q--C8HDQO
X-Proofpoint-ORIG-GUID: Vrx8sPixLj0i34QPvbANX39Q--C8HDQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDAzOCBTYWx0ZWRfX3+Yxq9Nak1yz fVhTDcVTIG++JGFCPXb6izRjKOqz3b+CWr7I90b6FEelvTsVwKGRVyUdhBnL9kGCNFsgLDTDxlP M3OW6/Tfer4b8oiLTfRmGWW2w3flLoww9rdOVnb1rqj3xFrMbXGLbM9ihitN80mUXa9rejZK0/m
 16jNtDnAzoJtwc5ShFWrjLaYQXaSf6ss/bfmTCCBIBOEjCinog875zfqtofRF1uKUAUVpZWRtxv xzkBddFizdAhZbfu9WLioyT+PxT8wKKK8rSIRQZzeFVoQHQszN7XOElfMQjCWjOl9DYbl/qKWwY 5EDrM722uSG/K8ajlht2y/8BGQRIBcIz8Un3Z5lxQMY+kKHEY63WXQH9YccVLfO+udEQGfGyt7o
 fsAswliNYO563AcjcDPP2jvECx7FOlXYNmfM+WtX2wo3rfMLK/zOc30EeNNHgXhJFXDZiwvJ
X-Authority-Analysis: v=2.4 cv=ONgn3TaB c=1 sm=1 tr=0 ts=6864bec8 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=o2t7t-9uB7ZXtTONCy8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf
 awl=host:14723


On 02/07/25 2:21 am, Jacob Keller wrote:
>
> On 6/25/2025 10:32 PM, Mohith Kumar Thummaluru wrote:
>> The mlx5_irq_alloc() function can inadvertently free the entire rmap
>> and end up in a crash[1] when the other threads tries to access this,
>> when request_irq() fails due to exhausted IRQ vectors. This commit
>> modifies the cleanup to remove only the specific IRQ mapping that was
>> just added.
>>
>> This prevents removal of other valid mappings and ensures precise
>> cleanup of the failed IRQ allocation's associated glue object.
>>
>> Note: This error is observed when both fwctl and rds configs are enabled.
>>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review, Jacob!

Based on Mark Bloch's input, I’ve sent out another patch targeting the 
net tree. You can find it here:
https://lore.kernel.org/netdev/1eda4785-6e3e-4660-ac04-62e474133d71@oracle.com/

Regards,
Mohith Kumar Thummaluru


