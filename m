Return-Path: <linux-rdma+bounces-22144-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /egIBEsXK2rs2QMAu9opvQ
	(envelope-from <linux-rdma+bounces-22144-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 22:15:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B434067502A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 22:15:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=pAn50tb0;
	dkim=pass header.d=oracle.onmicrosoft.com header.s=selector2-oracle-onmicrosoft-com header.b=kKLl8RXK;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22144-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22144-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22C80305EA3A
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DB539DBCF;
	Thu, 11 Jun 2026 20:14:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4C36CDE2;
	Thu, 11 Jun 2026 20:14:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208849; cv=fail; b=IWZILkWS92U1+ziPZosK5ew59KkxH8nU2dgQV43yf5UWmwI0YV6h3DL+E8sSBmuqlB7cIPfzYVL4VJmFvSERhm2ACcvQ05tYjWIjKIaKhD6hEL0ASiX7i3FmHqGeyeV2JPRo923MvyLZ+YLpHAJDtouXl1+FMbjEQRtDCmJo+Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208849; c=relaxed/simple;
	bh=BinLQA45qJphemowPWQqjCmJ/wvLYo1PM+aaFFUHJeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIsqF8rpeTH/OypnOgUVw3ouIjXc9KPKW9YJRKpTXxQtyf20w4ri3LDl22KrAGFQEz9+JUKbPEDU9UuMN4tDfn2CLTYSvTMEjxfyX8sfp608IGCbMPC4FQVgqRLZNtKogvGgX3xyaAzASMdVotDftf4uBtK03YXhQB2o1xytJq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pAn50tb0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kKLl8RXK; arc=fail smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BJMVls2753402;
	Thu, 11 Jun 2026 20:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1OKVDYtzkiSDihtUW27OqyU0Jhq2v5kvB7XnUmggC7Y=; b=
	pAn50tb0fyAfka+S8AWlvMFTaG7IGfsd1DSO9AhbSA0lpkrdOEb5Vc5cql6yjhS3
	LS9tKzgcVJOTKhmvu+ezRsxyyke4TBGsDJpD8DU1aGlkYI+W8FGVKLX7CkNDxplX
	m64YYZb63ux7DIwZwFksDykU6+QpGToSoqsRJlrMud/0XRWIYWyRNlRqhtJBc22D
	6iFKqHeqGJB11V3sRWgRMV3QS5IhxKEOK9RpAGyqq+mu7aF7bA2vK5BDzgTrPuxn
	/n5eoYaIrqRJ/NbjzrtqhMRvEw1DgLrFHxYYkfA+p8o4LylvCSsPSmdLbOsMIYH5
	v9K0q5kudjs8wqWgKTdDHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eqe76a0k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 20:13:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65BKDTQw004900;
	Thu, 11 Jun 2026 20:13:50 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eqx4beeya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 20:13:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etZZoDukz5niBHph3PCn+fDbwOkUdfimCFgfwgleNjiAHfuaXqHPIXqsZHNv6/+LPiHC4lrLkoPhhNHg5556MlQW5AgPsBGkr9dJvUEaVZo9iuqvaOpsl5C+RNJv5qNmMkeZz6gy6RolGZf+2c1qQB9q7cZVegV87x+zSCUlqXp8TMZgohYFq8uaGq6dBjZJ9NsJgy20gW4xr0jr/Uj7lO2FvJMVY/acq6pvPqM1/HqtDcZnDqQwcbmKJ16PuDGS6F5viI86uGzhWvzoRGcHJHHpik5/7HE7ZVG2zmwV0dCAZZ8xw+LW296D+fH/+NzHiYBKYhSZrYa3P5TQfPV7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OKVDYtzkiSDihtUW27OqyU0Jhq2v5kvB7XnUmggC7Y=;
 b=nRkEa+fGYGc/YokJqajX+63+5Me+zmkHeNyheF2otweU3z94BfHvEnS5zeFOOcLIFwbOP9d/IWnZuKlR6BXxmvpthH7q2pXkcL+KGfYNroTEOjQtJNKEL6JErH2ucf/k84uiWjHY+YJeskX/9sQLgOfbHe6PDovHul3jD5Y6u5K4knvWNt84kt/78A8WHdDgJZawY4ouo72kPlcMv32krv7iKjGu5eMk7TK1FQGQM5Zk414F9vPjLYfceKc1WY8ids3eErwU241FE4WKQCz9RpymNM33UmXgWjX9mpLLWU1WMp9n9G9peMnbbhMd8Z46fJ0xiHpUn3+afEoFKTxW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OKVDYtzkiSDihtUW27OqyU0Jhq2v5kvB7XnUmggC7Y=;
 b=kKLl8RXKHFDVH5y0I854R+/qLMQ3kUIFff+miqWwuQAnGubBOgYCpRKDKVa3aTAbBEKMnpVoA0WA2v3ZA+J6sQyBg4HEXjXi5CcI9sXwN1/GPe0mV7o5oN6f7CJNt7WaHUUZ0SXewRgDbOQHSkEosy4iRNeInjLrimdYrAYB1/o=
Received: from LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 by IA1PR10MB7513.namprd10.prod.outlook.com (2603:10b6:208:451::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 20:13:47 +0000
Received: from LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8]) by LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8%4]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 20:13:47 +0000
Message-ID: <3806aa95-fbf7-4713-8013-6dcf81d31535@oracle.com>
Date: Thu, 11 Jun 2026 13:13:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Report link down on administrative
 close
To: Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260608234223.3731557-1-manjunath.b.patil@oracle.com>
 <9845fd42-e84f-43d7-98d3-9b2d0d1f23d9@nvidia.com>
Content-Language: en-US
From: manjunath.b.patil@oracle.com
In-Reply-To: <9845fd42-e84f-43d7-98d3-9b2d0d1f23d9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:5:337::7) To LV3PR10MB7796.namprd10.prod.outlook.com
 (2603:10b6:408:1ae::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7796:EE_|IA1PR10MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f1ebac-b3aa-4567-1196-08dec7f5f1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JSUlWh2DPdMi3Zdwrta8Su/FPbM3U2XA3G5jyU0g2nFN2SQ+2Otu0U4aezw5WVkqI8Dj0F8htZ7xVj9W1kaXBaynQG+2sURGDHUdzWXrb3c0/vLTayqO8I3+YjSRZgi0VCLbgDq55SS87uFNGMwhyojsEZVTqoXSYxGmwfXtpCM70wgBtzTTYoulNnJyy8BikRvjXhpHXH+j3PiC6NNxBstjmEXgNocNNuu/mTREqhDt6l81h+pYFvC7FbbkaO0pSRtMCpOVIybDM1DRbFoaSTvB92bDDisDrTDVp4lidYPb7HTOKKxrzPJj1b5R+WFBprltGe6VEoBoqe128rcDtJcf83Xv5s2fJv69gONfI6xhmR8TBizICuqLfQoQsmmZesqHAZXqnCAhQpOoTz+tAK+gmRNM4kyxoXkbX1Oq6SqgmVbPWBdGTw7MU78YGlDLYlprAQhbv9FR58/a0jMYoLdc2BOlvHjkfh4yJzKvKV4tLU6Vt0We7JRq1FNI7r8YMxX/zgb3kDtH30QQ8ho9E/a9uenXv7GA+iZuMmARZssTD4Mo/uc3vTeif8K3AVBEghACNb1pTfZPrnX7pAr+PKs12BSOxN63/BIcfgE0Y9L8yalry4hlqMwnWzZq6PT3mhVFDKOMVxaKif/4ki5V4Pt1i3M5sRop/BlcK12eHOnVHi9Z2JQL09XNs2feOlfz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7796.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzcwN1dNWGxhS1dXQ3R2YWk5b2ZKS3BpMHNJck9nTGJpQS9JNkR6WldFNnBO?=
 =?utf-8?B?SnROeTZyYzJZYUhVTXRac3pMU0ZLalRyZmdCVFNRVXpZRmtSc2ZTZzJRaVpG?=
 =?utf-8?B?bTJia2ZidTkzeWJEZFhsSTVhcWo3S3pWMkN6bHN3QjluT0RIQkYvLy83dExT?=
 =?utf-8?B?eUlPQit5YndiVktrUnpXNHIrVjhKTkIybFlsblR6QU01UDI2QW5COE00Rmdp?=
 =?utf-8?B?dHJFbUxTdU41elc5ME5ZY2hMR3phR0tjUG1kWE40OVlvcUF4VG13bGpFMHFE?=
 =?utf-8?B?aWpMSjlicGhFTVdKM2xjeVZRZ283T0U5OENwRDBpQStVanRQMWQ2WTJKb3Jx?=
 =?utf-8?B?MHRFS3NRSWlUSGxkRWE5Y05zM3Q0OHNUYVJEUFJoYUtQNUVDUnRMbDVPOG4w?=
 =?utf-8?B?US9VZ0dYNysvVTM4Tjg0N0NZNjdVQVBnRUFHdkV2R091b3RVLzdwK09wSkNn?=
 =?utf-8?B?N0YxVXNmdGtsaVp3b1BJS1NhaVJBNnlURUFSZW9NV1Q1MkJlZkxOaFhrcWk2?=
 =?utf-8?B?eWlzaHdIb00zYUZzYituMzZmWnpXeDFBOU9FRWJ5YlBWTTN3bkRweUV4bWc0?=
 =?utf-8?B?UjdCQk1QUmk0Q3VaZ0hXeWd2V1BiYjNDem5ZS1dyZ2RlVWVCR0RVd2ZtQloz?=
 =?utf-8?B?UGYzVjBQN2NCRjJra09HZTd5UGhQRHlQbll2bS9pOVRjeUllUjhrQ3dzMWR2?=
 =?utf-8?B?bHd0cE5IRzBmVWRZbjUxWFo5REEyclRqTmJBV1N6TEcwY2IxeTU3djNVenND?=
 =?utf-8?B?Rlh5Q00yRHd3aG9KMU1UcGowNXZuc3o5RmVXbzNMeUxmSDhkME9VMUkrVkQx?=
 =?utf-8?B?VkYwNnJYN3NsVlFpRUNqQTl2RGRQenNjcFBmUENES0F2SCsyWExkOVlZU2Rv?=
 =?utf-8?B?cEx1eXlNYzdzV0hRZmw3eDROMm9LVHBLMC9tN1l2RisweVpsdlU3Qnp3R2tS?=
 =?utf-8?B?TFFKYXIvS01kbkV6MjVuaXUrdjUvams0YjJja0xsRjRFSTVOek1jekpzOUpY?=
 =?utf-8?B?NUdTQ2pxV0JodkFMRCtIR3BzZXBtTEpWVjdBeGlHL210Nnh5SW9IME9MaDJu?=
 =?utf-8?B?N0lyWFQzSUczTnNxMVJMWlVnRXB3UXA3ZmhNaFI0NDZmRGZFL3UvNVgzTWtF?=
 =?utf-8?B?aFlCV0k2WmdLNzBqSkU3dmR3Z0FkZzQ3alZBcWVCOENZM29FUGF3cER5c3lt?=
 =?utf-8?B?NDVPdC9WQ2Z6MTcyZTA4NmtUVlZSeTZQUm9yL1NSNkNqeUhoL0FKL1hLTlMv?=
 =?utf-8?B?ZmN5Qk5Yb1Z4cURhZ2hiVWRUUXhLTHk1VDRzV2xiOHdpaXJscW5wUVhRb2g2?=
 =?utf-8?B?b29LUGxXK1VQMDh1U2o1MDlVenIzaC9pRThqRHhXVTJjM2Rlb0tLVGRoT0ZI?=
 =?utf-8?B?T0R1RjV4dU84K0IxTWdNekl3YUU2bTJ3N1pDZTl1S3NtQ0JEaGpNblVQUE4x?=
 =?utf-8?B?MnYyUHp0T1U5ZUdrZVZRRE1oS1lTZzA4dTNnY08vUTFKOUFxRDdTTmE0blZE?=
 =?utf-8?B?MzVPNHJLcCtrN3E3YjJodmZuOGhuUVI4TU96U0tFbDU2TEt5Vk9UVytIbUdK?=
 =?utf-8?B?Q2F0dkc0dEswNnBVblBERnJ0SFhIWFlDMVhQR0pGbEh0M1VGdnA0d1d6MG1N?=
 =?utf-8?B?aGpPS3VaaytEeGtRTHliajF1R3pqSTg2REhmRmxBdThkYnpuSWtFRDFIamJW?=
 =?utf-8?B?M3U5WDVLc3N5T1A4K2NKV3A4WU54STYzTDBBSFRyU2JaNjZZOGxZV2k5ZTRh?=
 =?utf-8?B?ZnFGVDdJUWdrMTRyTzZHTFJDK1lmb1lZL1ZBRVV3TWVzRmN6K2hKRm0zcHFP?=
 =?utf-8?B?R1R1S0JrTVVoazU4dHBEc0RObnlXZTZlYy9NalpqRG1hbGRTb01HUEJranlr?=
 =?utf-8?B?cWF5ZDFQTGxRcWlRRjNLeExleUFQNWFlZnRpZEkwcFJXUldKeGJrRjI1QU9W?=
 =?utf-8?B?dHhtVFRRd2tkbFlKVVJLZi8zN3cxaUIzWFhpSjJxZlA5L2J4VXpqUnBOMkRz?=
 =?utf-8?B?ZXBubFN6QVBGTEZ1WmdaZ1cxSzdqNnQ5TUtlN2pIVEROaVc1cm1qeDQvVXNC?=
 =?utf-8?B?MG1haHVkVlRXbitCYTduSDNYa2gyM00wcEJldE0yV2xKRUZpV09KL3RKeE5T?=
 =?utf-8?B?b0poNmlFY2FkcWlWbTJOcWkrUVBtMTl4Q2hBRmlFT01IRjdxWnoyT0lkRm5K?=
 =?utf-8?B?MnBXbGtpNU1zbnhMVnp4aTNBbkc5M1I2aUgwdXRjbkI5SlRha0srRkV2WUxM?=
 =?utf-8?B?R05XcXlRQVdqVEs3aklkbGd6K1JNd055UlRDTEMrMEN6OVZFOWJ5U3lSeDVa?=
 =?utf-8?B?VE5tcWZHVjVacm93TEFPU2UwRXNRU1dQUjZPamgrUnA2YXFBdXZ0bjJ5Y0hm?=
 =?utf-8?Q?gkPffaRzqlycx9rw=3D?=
X-Exchange-RoutingPolicyChecked:
	PWqmJEqI4N2lysY+Oid5jhMb3CD50njqS2SZSO1mT890m+i+tzTTl+4hvzSyFOSgsB2aF+LyNRzXWWE/egBmgvLo3igtZztnRGt9XYAqA/FVs04TKOvWx6nYyiafFeVSS3L7TcABL8ff/oT9Kvxnzo26/FhEMgT1MqHYA4t7hpgFEx79XXCvsJXN/zW89bpuhyQINnvfdIGmAw937siQ2K6p/7SWOMAQ/vcUbZ0dTvvdlZut4nUL33qBeWRbjn/6Yc/NvKl9xAibn8XAE5GRaHN6Nf94afxGXxXZTb6wJk2u62eTuD3yLzdLKbtafhe5mAlMKmHFrPaDcNgtzwPCTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pb4sqJhjJWDxp7F06tdv42bu+sTswcAvImYn2FADUX6cV4xoIH/XXf9jflGhUeO/hUL+9FXcaOIPrCB+41p7Gwc9qk/AyRK/rUayzKgWNocaGibAhckMhMIXUwE+sRVaHtpyGyDPL1VGzU+oR8l9QcykzB02u9K4Q+Z2gsFXLaFpvV8kpd5rSbaH1ebu9ZBY3Q1er9nx0gxvCWY629E0t9NAoE+t0uYt6NZDs1OejTw0ku9PBemM6AcutRYucoSSHfg3tu7LbHezSwpzIA1pbORp4SpYmUwsEPTYWIvFLVXq8uWjjh/04lWbhCBCj4JbNI92H3axClE2p0b4o578vcafOTMJzuIKa9TzvLOecrs9LxXRFGD4n9e9QVcBpqsO7VYyfGJXlM24uRmGDv9CdmBoYT5/MVwr2AWeOoebFfhFMoZ7rJQ21PnNBQZdfxTTg3/P3K598TYS/NcJp5Y7WvXIpNR8sglTk2CfJDvzY68HohmlR7KQ9DPNEWb8pk29hJYfEwzSeKVN5vxY6RUjOWIzCfi8kyq9gmoMFO2ywnJZ++iQZDzj/5TIvumYfwom+e8v99e1r952yrzg9OuI7H4lWpocJqfYb2JBrD+5lqE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f1ebac-b3aa-4567-1196-08dec7f5f1f1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7796.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 20:13:47.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaaCHHNP1HxurTJcakCadgv1rNWEyh8UjgYKFbR0hvFrlSlC0I7oe6OFCGdY2Ilr7njsaDFTH2WNJltZ83oH+wgtZvZnlLEqfJhCekyeX/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_04,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606040000 definitions=main-2606110203
X-Authority-Analysis: v=2.4 cv=W6gIkxWk c=1 sm=1 tr=0 ts=6a2b16ff b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8
 a=DQVH6AwOMGWOuMy25pUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12312
X-Proofpoint-GUID: Arjkit6-LbSJzVsUsnNTAG9I4T8BvbQ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfX+YdT8wZsdyy4
 3OgM+3cmVtxWKmr5MqCVt7n4s0rOze3GszUpkQXvwve4BfIHxLQJYeuZtMNhNNIfZEcdl2VqrDi
 d9vAcpZ1gcZNQD/i7TkBhtu2YkNIS3LuAADRtPqdG+xxJaFWfMW3c0/151HPQfJ4i8r757eye7c
 nattG9GkI2K7pBBCnH7RjtqZFGFj1pW9C2fovKhiooytID3fLo482ZGAN/k9bMXdma7eDx1EuDL
 sscKUGRq+XCbf2nb7kzogYT3WPvOuIZ4wqpGkN51Ab+5qx2x9pp3O7/b8I2jKhSJQHoseYPr3/c
 OXntuAxw7bCxEcmfqDyTE2IcnZQ/n4Ce//lTfDJY/qE9hAiiTfE35k83ahyBKrXO1zTsbYW9/IV
 sXkCOj/AyoXeX+9Sk95Hqm9esIzINyrwy2l+Az29HblSnNVlZRIC115jGO6s8R38HjegvxpjySD
 V5FjW6E/UaNdjvku6fxyCw4Hm4xtezyIYFSVhwY8=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIwMyBTYWx0ZWRfX9IQAyme6EH95
 6jlIxWdbpibbHtOQMnYJQjBVB1Gfnic8HHH2PJNBGoiVcLF89VNeImVBvPDjLz5KBrd1AFAoKCe
 3yjrkOMaQ16A1ytAeGS9g4u3SO/gSN2t8mRmon9ThG9tc8z2ne7T
X-Proofpoint-ORIG-GUID: Arjkit6-LbSJzVsUsnNTAG9I4T8BvbQ9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[oracle.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22144-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:email,oracle.com:mid,oracle.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manjunath.b.patil@oracle.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B434067502A

On 6/10/26 5:06 AM, Tariq Toukan wrote:
> 
> 
> On 09/06/2026 2:42, Manjunath Patil wrote:
>> mlx5e_update_carrier() reports both link-up and link-down carrier
>> changes, but an administrative down does not reach it in practice. The
>> close path first changes the port admin state and then clears
>> MLX5E_STATE_OPENED and drops carrier silently in mlx5e_close_locked().
>> Any queued carrier worker will skip update_carrier() once the device is
>> no longer opened.
>>
>> This leaves "ip link set dev <dev> down" without a matching netdev
>> "Link down" message, while reopening the device still reports "Link up".
>>
>> Report the link-down transition in mlx5e_close() before the common close
>> helper clears the opened state and drops carrier. Guard the message with
>> the current opened and carrier state to avoid duplicates when the netdev
>> is already closed or carrier is already down.
>>
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Manjunath Patil <manjunath.b.patil@oracle.com>
>> ---
>> Validation:
>> - Built an OL8 mainline test kernel from this change.
>> - Booted 7.1.0-rc6.bug123456.el8.v1.x86_64 on an mlx5-backed VM.
>> - Confirmed `ip link set dev re0 down/up` and `re1 down/up` now emit
>>    netdev `Link down` and `Link up` messages, alongside the existing RDMA
>>    port state notifications.
>>
>>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> index 8f2b3abe0092..a04a89f0eddf 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
>> @@ -3628,6 +3628,9 @@ int mlx5e_close(struct net_device *netdev)
>>       mutex_lock(&priv->state_lock);
>>       mlx5e_modify_admin_state(priv->mdev, MLX5_PORT_DOWN);
>> +    if (test_bit(MLX5E_STATE_OPENED, &priv->state) &&
>> +        netif_carrier_ok(netdev))
>> +        netdev_info(netdev, "Link down\n");
>>       err = mlx5e_close_locked(netdev);
>>       mutex_unlock(&priv->state_lock);
>>
>> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
> 
> Thanks for your patch.
> 
> I wouldn't print "Link down" as part of the "close" callback. I'd rather 
> get it printed in the event handler. Currently there is a print there, 
> but the callback is masked by the OPENED bit.
> 
> This made me revisit this area, and it surely needs some more 
> interesting enhancements.
> I'll probably come up with some changes soon.

thank for you taking a look at this patch.
I will hold on and wait for your changes.

-Manjunath

