Return-Path: <linux-rdma+bounces-4619-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A1A962C75
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62B31F2147F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A5718801D;
	Wed, 28 Aug 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VcINliuo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224313D889;
	Wed, 28 Aug 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859270; cv=fail; b=BGaGgCDw3QeQLOrQai6AtzU1cXmdt0c9Q7vqUBxOTf/X4OS42hUTyeH3YYjbqStxcVVG0PknsqAAFcIQlBjDBBgEDS9Ge4hSsi+xjfzDYy3JMeOe12Bgv5+2McnPehPqEUtSXx+AehsAQ6n4gF7EdsBphHm8RWi0r3IruxI0WY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859270; c=relaxed/simple;
	bh=Bw+u+FvIWoliyERgn+RxMZObaHV6TaojuJvdjoefQKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Md5cvEGkVz5ATQP9mQnSdqVa/Wfw7d55HZwOfJ+oC8HbOKSa3HrtEaqhOvEvdEdp/S+HmcM3yRimvz9OXoNqpGNukiOnFvEMXuToanDLift5hRdtuCOm6Su4UlPEmG4W/0Yt/Fvbdya20SGUTiGDbMmzgX9xQ8V6GCSM+SFU0Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VcINliuo; arc=fail smtp.client-ip=40.107.237.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Exfl8422aa1q9BlSaZ5Gcs6WQAETnGMkrIHR+i4FTYzCOsh73wXDvTLmUH0Rw0D7Mkk/mp7okpP8umnqg0Up//fa01ARAfZp/LgUVb5+JVG0zUUWYvAL3otTXY7gIVsSFguGf9mD6NjdZ8R0HPvSGycRnAg9ZkeGgKEDmiwI1DQHWX0dEUZenOs3j/rO6OuOquSJXPfdNpzymYiU4paKtokaeXCyI5P6GIBtmRUoMvoc5a3GV5A+o/5znRLanRbgMkcsvNiA1tvrvsf4J62VDOE0BQtbMlkNgBUMyDrd9ghp5EF35uMbiSy3u7zmZ99fA0fusmz/JXEFLvWtNiYA6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiZHqD0b2YklXzNSKvOYETt5r0gmDgIA6nY9DGf0HOo=;
 b=aVkS+F8QGkVX4fBS8/LSDDgbbXa/7tMmnb0lNXy/XIZ0TF3vQ9Daj1cxh8ICTEPLYTBUg+U7rJcFdy/BuZ/9Nc8TYQO7lRoeLy85TI/857kJWItHP4YeTeibHv0O+n8Qchlq1qnbyPl2s25qmq/ALeXTR2d2EeOk+br6NR75AnlB5PXfe9BxPJ60mSX67u3ZrybJH9vwZvO8Fa+Bn05msdRHYc3JJu/cD+qJ/H9cg/Crk3b8h68Ctp37g+PtKa+STtGHqpIB3ehgJhHPO7Qx3Fd9pSiImvqW3h4oFuWcz5lvZw4Fr9DlpLib7nOIiD4A8PxvJyU3nRsajXt7pujz2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiZHqD0b2YklXzNSKvOYETt5r0gmDgIA6nY9DGf0HOo=;
 b=VcINliuo3XbURehim85tFWApB1sdRRd8A2cfDYkQkTlbFIWgOZFlDQy7Ct+zuEVHoDimUyfviVYsLqRdJYjd7JF1YCSntzU4AuUAxsAko6YEPaiQBbSPyID7V1WePpJkAYjM7gYyWKxFreCNl+XCLggZaWkMS16MuKnPUY1Mf16IffeFI4AZX7dZpOS2qUxi1L8dazqPxAqk45d78kQCLxlXhoBwcRXb+3+BQSfoQfChPXg+UvBDaUA+IiRPGKzyG4oPEauVxwLjiOlvtSuVe49ITgEO/hnR+U9kw+L5D9I/9JJsW4i8v36kjcFs+FK+GyL4WOjiq3P4TjIHnPP2MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH0PR01MB8021.prod.exchangelabs.com (2603:10b6:510:281::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Wed, 28 Aug 2024 15:34:17 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%4]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 15:34:15 +0000
Message-ID: <0d68445e-9423-4d3f-9715-9129bb31eee2@cornelisnetworks.com>
Date: Wed, 28 Aug 2024 10:34:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Using RPMSG to communicate between host and guest drivers
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-remoteproc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 OFED mailing list <linux-rdma@vger.kernel.org>
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
 <CANLsYkx2OThcBjs1Qn_Bgd0LE1+EN7c0Dh7NE=1dEBB4xqS9cQ@mail.gmail.com>
 <59cd0c1c-b5a0-471a-810d-65d42b021760@cornelisnetworks.com>
 <CANLsYkwPoLsvLgJu+MqfZsVna_nxyx6BnkSFBrmpbxMC0sv_fw@mail.gmail.com>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <CANLsYkwPoLsvLgJu+MqfZsVna_nxyx6BnkSFBrmpbxMC0sv_fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:610:74::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH0PR01MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 4faeb626-fb36-4e75-93e1-08dcc776dfca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dkak9sRWI5T1gzMGQrRkQ4MmF2ODVycityQ3M2cEpsWUhFVmFpR3cvYUc0?=
 =?utf-8?B?UFRYS202eWdJSnpjT1UwalZtR3pLTjI2SmhlK0Q3OCtKOWxaODV3OHYxUjBy?=
 =?utf-8?B?TWFYRnB3V05nK2xXNjk5anFqUU5yemVzdUcydjExcFBjOVdxMGtPQ0V4endi?=
 =?utf-8?B?RFA3dVR1UlBsdXVEUnJOaDI4bitMbFhDbkRQQjlWM1FpM2prTUZ1NkM1dHFY?=
 =?utf-8?B?ckFya204MDNLaEVEZFNYZExYS1BIdGRFNFVqR0kzT0JuS3dGTzdOTi9UdFpk?=
 =?utf-8?B?ekx3L0V2dUxkeHUwdUNEUHVucW5VMlZ0RTBKZVdXV3BmVk9LM2VkZ3h0WDZ0?=
 =?utf-8?B?c0x3bFZhODYwZWpqSWxNWSt2RHBRWTJtaU1neVdPbEptVWd1Tno2aDA3bzB3?=
 =?utf-8?B?SG51K3pmVzB1SXVTLzlTZUcyaDhlSVhSY2lXV1cxV1Y4cGlMaGF6Mjc3Wk8y?=
 =?utf-8?B?dGRzV1Z3cHk3RmZCdUUvaE9ranhwbjlUSVZsRTNLMzNjV2FQUzhJdWNadlh6?=
 =?utf-8?B?aEI1RjlmWVZ0Q2NWbjdic1ZQUDhTSUJxc2dFemZ2cDBqV21ydE9LWGFUVzJn?=
 =?utf-8?B?dk4yWlF3N3RxUkhxVUNwcGNUaW5LTlZZbkU2bWMrellrQjFGbDlBbDVxNjdV?=
 =?utf-8?B?am11clRCUTF2U0lieFNnMkxkZ3dQY0ZLMFd6aXBGRDRHZ2UrYXVGdzJhQ2Yx?=
 =?utf-8?B?SEliaHd0WWtOcFE3M2J3VU9CdzNsR2hPaXV6bGdibkxrQVVjRE8rRGZkOXpw?=
 =?utf-8?B?K3MraXJZS2NWdlBMeE14cUhkenp4SzcvanVpbTBMemR6UnhGRDErVGdJVU9M?=
 =?utf-8?B?NG5WYlNHWFplamd4YW1QVHBYWUtGSkI2cUxTVDljZU9iS3VQMzhqVTRQcUh4?=
 =?utf-8?B?dUVSbDdmd1AzYUU3c0xmcW9GN3VBL1FjK24rR2VPTlUxUWNIazFBNGYzVnNv?=
 =?utf-8?B?dDk1L3NsRVQ5REFKVEQ0dzJNRE1DcHg2amVGVlhaclh4c0MzVUZtNFZFelp2?=
 =?utf-8?B?NnVZT3ZMdWxHSVl1QjZMcUEraDNlanBWYkMyZzljZmNBN1hLazQwT2pobkNr?=
 =?utf-8?B?MUx5NFgvQkRiOHZqMUk5dS9xOXhoRUhCNGU5dGU2Z01keXVPcDVnY1IzdjVx?=
 =?utf-8?B?WGVBcTByalJhL20rVXI0ZU9yMllPbXpmZjZwTXV6TzJ2MnphKzRkTHJZWjFr?=
 =?utf-8?B?MTdEVXBmRUJCOWJHc0wwWWRNcjdPdUlTTkFub1cxaFBzdHNZa1B6cEhjczJW?=
 =?utf-8?B?UThlY2o2MmFMUFRWQ0g3UWZuckx6TVVsUS9tK2ZMaEZIbkREeXlFR1pQdHhn?=
 =?utf-8?B?c2NFWkllR2Nvd24wb3BVOFl6bnBmaUF6Qi9zc05hS0xJZGd3czAwUzhxQjZp?=
 =?utf-8?B?U1I0cVpvNGNVNTdoM0FIcmEvcUJFSnlTR3ZLaHZLTFN4N05QaG9Odm1oVVJK?=
 =?utf-8?B?ZDZZcDFXNGt2Tkw3TFNmWmdDK28yUkV5SmF5aFBkUzJPOVkrZWxTMDN5WStq?=
 =?utf-8?B?VTlNVTFrWTFodnVCeXVtR2dHRmVCUE9IUGpsOGl1TXk4anBwcW9INFBtVzlx?=
 =?utf-8?B?bnkzVjEzS0luZ2ZheE4vVWRkOVRXcWp4VXNleGJIMHlyM3p5SnlIRjhhVG1k?=
 =?utf-8?B?Rzl4NERiMnlMV0EvZitiK1pEQ1RHSTBmS1ZnUTZZd3V2OVZjZVF3dTFwZ2hz?=
 =?utf-8?B?UTJsOUZjMFUrVGF6VFZQa2h1MFAvazcrY0ZEYlN1aEF0aERibGRUSlNGQTYv?=
 =?utf-8?Q?IRXFhhBWF4QK+ynhw0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3dnQVFGRlpBSGs3NlhUd25uNC8zc1U1bVVwM1Y3aEJhNEVCcThOOUdhNTlu?=
 =?utf-8?B?TElheERWZ1J0VEtJaFZxOCtBTy9KNjJzU3pKdjRtbnY0V0o3dHBWdFoyZ0N0?=
 =?utf-8?B?SWMxQlZySWtRRDk0U0pNZlhPZlBxQmhPZE02VVRuN0c0dWJkZUUrSHl6TXla?=
 =?utf-8?B?ZWlDcU01TkZyaThFeFFmRXRQaVhTUncxelZGcGhoZDRSNGhkVEIzVE1wU2dQ?=
 =?utf-8?B?dFhmcGxqeERTTEdmUjVDOG5IeXhkZHBIajl2cGpGREFlZUJVVDVpWmtwK09L?=
 =?utf-8?B?UmVYbTdSZEM4MFEzUzExWnB3VzZuRTdiQnNpWFZ5bUhLQzNlelVOa2JyUkZm?=
 =?utf-8?B?Wklyb1NUYjltQmpIT1BCOHBlVFZOZ240QzdDd3BaTHhjYWYxZzQxOU5XOTlx?=
 =?utf-8?B?Y0hGV2dPZFB4ZVU5OU1BNGhjMUhNNHI1am10L0NTRlpXQzlWYnJNcE82aVNK?=
 =?utf-8?B?cjNVQXRkT21uSms1dkVOSVQ0SzBIalF0L0F2aytrRmZmaXZhbEpTYjZ4SUs0?=
 =?utf-8?B?N2lma0Fyemxia2VqbTNWcjhsT0RUaC9kMHp4djdya1JhN3NHT2ZSRDBpamdH?=
 =?utf-8?B?VHB3T2VlN1dJQ3htOUllMTEyU3NrQ0YvVEY5UlN2Y3VFZXo3dWpLbHpsVVRR?=
 =?utf-8?B?eE5BVmJVd3dxRnhoelAxcEJmRHNER1VlRHZMc1JWdjNnTEx1RG5BZlVYQ1hU?=
 =?utf-8?B?c0J4MEk5aXhkUnFSelRhb2JqTkF0azVDTUg0emEwRXN4RmNrVVZNMkxjaEVo?=
 =?utf-8?B?R1pjVUc5eDFUWVUwYk9qWE1qaXBLdTFVeFJuRzdSNUYrU3IxR0x0b3NnekhF?=
 =?utf-8?B?UnEzYitobFh2UVAxR1J1ZWxaSnl4RW4wWElBS2U1Y2FDT0RoVzFDeCs4TE40?=
 =?utf-8?B?d1hlc3dNK2VlMVZEZE4za21zQXRkcVN1Vi82Qjh0Skwrb2VCc1Q0d1FZbXBo?=
 =?utf-8?B?Y2pmNW5tRGR5S0grNWpZTnJobTVHM3cvMVVmMW9FVHRnQmlBVGRPSUsvMDJp?=
 =?utf-8?B?VzNvZEZOUkxRSS90TFA1cGR2Tmd5cElRaWVLOWdUbk9nazlkVWJ6UVFlQ0tW?=
 =?utf-8?B?Z2VpWm1TNzJFQzhwN05MVkprVGVYYU1ZQ090MytFUENMbjdlcmlwQ3BqSk5C?=
 =?utf-8?B?U3VGalMwTXlKSkRuU1ZHUDYzZmFBMjdOV0hjVHljb0EvNWppSXM5ZTRIeXRX?=
 =?utf-8?B?bGhGVnJ5UlJNRWhNSGMyc05sUzdGK0lhTzZHTmNVUWsyT1pEaml0UExyc3JV?=
 =?utf-8?B?NTAydmdNaTYxeU1PY092WUJPcElUa1NSbjIzQS9oY3FrM1gybDlNd2tPOFlD?=
 =?utf-8?B?Q2lJZjU2QXMrdmQwYloyOVFMZ2lFZnF6eWxpbnVXYU5oaDE1biszUFRGR2Fv?=
 =?utf-8?B?b0R3bWhROWF1QWM3M2U1VFFKaTd5OGlmU254Skh6cVVFbjkxMGRBMWVoNFJC?=
 =?utf-8?B?MUFIc0JZMlp0a2g5Vk53UXdiSUE1aWJSejQxc082Rk81d3Y2ZkMzYThtNG9z?=
 =?utf-8?B?cE1DWkN3REtCbW9vV1oxRSt6cm14clpFMzgwVDlGVktQU3ZudWYyK1QxWi8z?=
 =?utf-8?B?aVJQcFg0ZlJLNURoMzlNVTdrT0NaSFpCSGV6M0ZRMFRQRWRzOUZWeDhuMVl5?=
 =?utf-8?B?ZzRpV2RoTWZTUmpmR2plUGNTcUFOUHA0V1VJVXhmMVVOUWcyOEIwV1FneGJS?=
 =?utf-8?B?anNQYnlTN0d5d3pzSGVHQUZyVFdNWTEvWWZZUno5Y3dvV0JoRitqMmdJbUtm?=
 =?utf-8?B?S0x4dVMrRldEWEIraTZrVXFYbHVRaXI0VDRBM1VMWGFxdmtrR0J5b0tETm1I?=
 =?utf-8?B?dUlCWlladXp1Q2RLWEJQMUdMZEFDWCtsYUNNV2RUdUJnY3hBWFNiM3hiUmxo?=
 =?utf-8?B?di9XdVpPRnRBWDRMQUlUVG1EZkNTYWh6TzBzelRTTWNwVzBNSjd6NFR4NkFG?=
 =?utf-8?B?YXNVZmJvZmI1Q2lNSHZRN1VlZUt1aWFHRFcvbkh2NzlIUXBiYitoT3dTTFQ3?=
 =?utf-8?B?UUlMbUdOWC84UWFLNnFUVG1kSkJUbVR4LzBuSzZMVVNZVkZvYVZtdUtDK3dp?=
 =?utf-8?B?RHRpd0Q1bXZBUGZwTkVieUl2VWJ0TjBQU3QrMElwVWYrNkVzMmtWRzZXcUo0?=
 =?utf-8?B?ZGd6SkkyNzBBdjJKLzYya3JQbkNiY2Q3ODlHYnNXNjE1Y0cxeFM2TzdmZlRJ?=
 =?utf-8?Q?rmmBhNc5anTji6p3Tj18VkE=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4faeb626-fb36-4e75-93e1-08dcc776dfca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 15:34:15.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHGyCrhFUFhSBvxtnDTH3In/zhQiAgjl7uzCS89bhJLpgWSKBM5WNwDgYF1HMuF0mkjMw4t1wAu76rOf22FJE52K1ussTowAmesgAqasiRJISlwBg8Y2o/LqBsZ/79QA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB8021

On 8/28/2024 9:44 AM, Mathieu Poirier wrote:
> On Mon, 26 Aug 2024 at 11:22, Doug Miller
> <doug.miller@cornelisnetworks.com> wrote:
>> On 8/26/2024 11:50 AM, Mathieu Poirier wrote:
>>> Apologies for the late reply - this got lost in the vacation email back=
log.
>>>
>>> On Mon, 26 Aug 2024 at 10:27, Dennis Dalessandro
>>> <dennis.dalessandro@cornelisnetworks.com> wrote:
>>>> On 7/31/24 4:02 PM, Doug Miller wrote:
>>>>> I am working on SR-IOV support for a new adapter which has shared
>>>>> resources between the PF and VFs and requires an out-of-band (outside
>>> It would have been a good idea to let people know what "PF" and "VF"
>>> means to avoid confusion.
>> "PF" refers to the Physical Function of the PCI adapter - that which
>> exists always, regardless of whether SR-IOV is active. The "VF" refers
>> to the virtual function(s) that are created when SR-IOV is enabled and
>> configured. Typically, the VFs and the PF are assigned to different OS
>> instances running in different VMs. So, the OS that owns the PF needs to
>> be able to handle resource requests from the OSes that own the VFs (and
>> also send notifications).
> Thank you for the clarification.
>
>>>>> the adapter) communication mechanism to manage those resources. I hav=
e
>>>>> been looking at RPMSG as a mechanism to communicate between the drive=
r
>>>>> on a guest (VM) and the driver on the host OS (which "owns" the
>>>>> resources). It appears to me that virtio is intended for communicatio=
n
>>>>> between guests and host, and RPMSG over virtio is what I want to use.
>>>>>
>>> Virtio is definitely the standard way to convey information between a
>>> host and a guest.  You can specify as many virtqueues as needed
>>> (in-band and out-of-band) and it is widely supported.  What
>>> information is conveyed by the virtqueues and how it gets conveyed is
>>> entirely up to the use case.  Have a look at the specification of
>>> existing virtio drivers to get a better idea [1].  If the driver you
>>> are working with hasn't been standardised, I highly encourage you to
>>> submit a draft for it.  If it has then add to the current
>>> specification.
>>>
>>> All that said, you could use RPMSG as the protocol that runs on top of
>>> the virtqueues - that should be fairly easy to do.
>> I had initially started looking at using virtio directly, but it looked
>> like I was going to have to get a new device ID defined upstream and it
>> would be a significant effort compared to using an existing facility. I
>> then saw device ID VIRTIO_ID_RPMSG, which appears to be exactly what
>> we'd have to create if we were defining a new virtio device for what we
>> need. However, the problem has been understanding how to write code to
>> provide the rpmsg "device" side. There does not appear to be any
>> documentation and there is no example code to follow. It seems that the
>> device side is typically contained in a GPU or accelerator, which was
>> not written for a Linux kernel. So I have many questions on how (and
>> when) to use the interfaces (rpmsg_register_device,
>> rpmsg_create_channel, rpmsg_create_ept, rpmsg_find_device, ...).
> VIRTIO_ID_RPMSG is a special case - it was defined to establish a
> communication channel between a main processor (typically a cortex-A)
> and a remote processor, something like a M4 or an R5F.  As such it is
> typically used in conjunction with the "remoteproc" subsystem.  The
> device side you are looking for is part of the openAMP library [1].  I
> am not aware of an implementation of a virtio device that would use
> VIRTIO_ID_RPMSG in a MMIO area or a PCI config space to instantiate a
> generic message passing interface.
>
> [1]. https://github.com/OpenAMP/open-amp

I had been looking into OpenAMP, but was stuck on the examples which
appear to be running from userland and do not appear to be what is
needed for kernel modules. I'll look at the larger project to see if
there is something I can use.

I had assumed, and obviously could be wrong, that the fact that
VIRTIO_ID_RPMSG was using virtio meant it was suited for VM-host
communications. I was looking at the interfaces that are enabled via
CONFIG_RPMSG and those appeared to be what was needed for the device
side, although it's not clear to me how they are used.

I ran across "pci-hyperv" which looks like it might be providing the
same communications path, but the only use case I'm finding is mlx5 and
I wonder if this is really intended for general (future) use. Also, it's
not clear to me yet just how the host side of that works (yet).

>
>>> Thanks,
>>> Mathieu
>>>
>>> [1]. https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-c=
sd01.html
>>>
>>>>> Can anyone confirm that RPMSG is capable of doing what we need? If so=
,
>>>>> I'll need some help figuring out how to use that from kernel device
>>>>> drivers (I've not been able to find any examples of doing the
>>>>> service/device side). If not, is there some other facility that is
>>>>> better suited?
>>>> Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folk=
s as that
>>>> is where this will eventually target.
>>>>
>>>> -Denny
>>>>
>> External recipient


External recipient

