Return-Path: <linux-rdma+bounces-7035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E0A131F0
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 05:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57B81887776
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 04:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A23482890;
	Thu, 16 Jan 2025 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="iwZU2Wes"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9004414;
	Thu, 16 Jan 2025 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737000988; cv=fail; b=YvfqODRd/2D9pY5w+ZU4L6qOzIRQIyLNl11Bc9+0UOfPUM4QgDGZaGzpIY+2XYePqHv4FM1o5ihpRhsjwXWIOxcJjvStgJhxln5twBmhZch/3PzwcuDK8LfqOo5BdCQqKDJA86OFVn3F2H76DsEQe4LjITqnR3viIUjPTz1jCl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737000988; c=relaxed/simple;
	bh=8zPbicVuP32munAAORCgrfo8aSm6J0kN5UnAH2rKe+0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ii0B9T0nk9WfUANcs91E8vxxwLOIExZ0G6w3JziYNkSb78V0SDW2QPxPt1HI7hpOMYy0+RlH/BmiSZcrq/RWUKImAy2Gd1RDsdxOo3/fQwgIkUzG+bLqMWgWfIsCdBYmAzWmHVX0IpVhAslHh3Z1fLO96BwoL8yHXNLcBUVjWsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=iwZU2Wes; arc=fail smtp.client-ip=40.107.94.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI9fUuQVWZDKvLICtyhXgIZBugMPenvrlN3GYLcxVqSVa8Yl+DekDqiGgVa8omabj8qRt6F1Vkgn1M8kalksLaSTTc5M5rBaFb3P8a8ndh/vfh++TrxECPQSJNLgZ1/3mCJc3he+55XPsYOA1Cg7vHwp6eT6v3atAA5NOpFTvBOHR809v5ZLrNs4YFZYDZAlF9HibvEz0qCzBRK89/XwVQovVq8PTh5sXaJMQW08E+4FfbgoZss3ntycphABVGGYMFWdo30DePUwQDElL/hzOb4QKWNpprpbJams1SlHWiy+JpGzIWMziY/CPMo/NTyF0bTrOMbJXTkIwb3Xog91bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GhxTuSN4JrNDVPwjG/H0CLvIBenrahnjGeuroUATP6Q=;
 b=vEttb2exizwks5t5JAlgREeZwXIFGH5q7BHCzEKMQAlgP1NwbRIEgmsXVzOxS1bC/xTj5leH9s51w+SX7MW8uyqBIDGJD7snLUb6w3lBsv91JgYfQcBDqo2db64EeS1jh6ImrvfcV9jcPv+ZAB2N9pEV3McE8k1dAKk7SqWZB8/91g024bQ9A1eYGcYu4jVtNZ3DGRd5hdXXySVCQI2oYpUXJ13Q7HMmCiuHEtYcvAel+qqDj8kaJfgMHmNJll8eupvgNsCy1TMAptKnKSketcw4KH7BlzG3I/swP3+GxRSbgglXdLehwd9TYWjDNw4gd9Apm4Ws5TV3/aY2LADf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GhxTuSN4JrNDVPwjG/H0CLvIBenrahnjGeuroUATP6Q=;
 b=iwZU2WesJmQwQ9UCnLkmmTbZGjc0WKeaWxGRyVkU5uQCJVxsjT6qcS4LFbNyMSQwcA68LUVxTwC7vK3EtFVkREXWfLehALvZUzHAbVNj7sG+QSwHtY8PYjikxoKHc5pGQz739M1WBeO2KXzEg2Tkl/dwU6qgfooDftJzD3ZY+h9HVBtJlrTgozVpNqt0LiGsOz6KPxoqMud4atKQ+ukh3zuhk3Y7Xn+Hh6xAtC55RPi2Gwidjkg+nUAkD4qpRKjWZYNdwenF94fwrvGDiT5EukC/Pj38rJZKvFIjjdBDKk3ojQ9vVNnQM95wLnqECnySdpurqcmFfrGjAP02eDwjBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from SJ0PR01MB6158.prod.exchangelabs.com (2603:10b6:a03:2a0::15) by
 MW4PR01MB6482.prod.exchangelabs.com (2603:10b6:303:65::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.14; Thu, 16 Jan 2025 04:16:23 +0000
Received: from SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b]) by SJ0PR01MB6158.prod.exchangelabs.com
 ([fe80::d4a8:cb9c:7a0:eb5b%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 04:16:23 +0000
Message-ID: <3a3a857e-7769-40b4-81d2-2a4e71bd301f@cornelisnetworks.com>
Date: Wed, 15 Jan 2025 23:16:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [lvc-project] [PATCH] IB/hfi1: fix buffer underflow in fault
 injection code
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, lvc-project@linuxtesting.org,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <20241227230940.20894-1-v.shevtsov@maxima.ru>
 <4e7675a0-0dc0-4da3-b8ae-2462a5b112d1@cornelisnetworks.com>
 <gwdzoxk5gq5ve5jqklt4mkuoo25nhpjagjwbjuqvcrwhccauet@2frrkt22grg7>
Content-Language: en-US
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <gwdzoxk5gq5ve5jqklt4mkuoo25nhpjagjwbjuqvcrwhccauet@2frrkt22grg7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0869.namprd03.prod.outlook.com
 (2603:10b6:408:13d::34) To SJ0PR01MB6158.prod.exchangelabs.com
 (2603:10b6:a03:2a0::15)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR01MB6158:EE_|MW4PR01MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 214b7251-ff12-478c-7913-08dd35e48948
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1NSEdHM3VEQ1NTM0lCTHBIK0dTd01peEtDNHlYdWZONWRML1ZzTFdrNysx?=
 =?utf-8?B?bUp5Ry8xVTFtdTlGb0pvc2JRQ0kwWW1aaG9JUElVRzRwK0FzVjlrYVdQYURI?=
 =?utf-8?B?Z3JaZm5tUm93YnRtSUc4ZTBQQjFYampCcVl0enpiYW5URFNnSFRwY1I4VFZo?=
 =?utf-8?B?K293NFJyRkdEaE0zSjZ4OWtodXBqc2pTM1V6RXd0WUxpWjZDOU5HdmliRVRE?=
 =?utf-8?B?cFowOTErYjRKdGFVMER1NldvN2JTb1RlNWJhQ0tTSFFRdTZBb2tnaVlZYTk2?=
 =?utf-8?B?cmw1RTFSZzJaZFNrNDZ1djZGV1VsY2NEQmxsUW9JaWpKb05IMG1JcXQ5NTF6?=
 =?utf-8?B?Vm1PajZmdTBmQllrRzg5S1hTeHdDblk2aEY2RExWbWtQK0cxTU1Ob3E3QU5p?=
 =?utf-8?B?cjVWTkQ5eVpJWDI5NDJleWRXVXlVTEN2WTFjWFFCSm5YYmhVM1E0cU5mNUVy?=
 =?utf-8?B?TDVwanhWcGV5SDg4S3ZSWVNUZ2dZbkswd2hXWUU1WjMwcVQ4UHExMnFKS2tH?=
 =?utf-8?B?Q2xtR1VMcFcrMHNhQW5yd2V2RDBiaDU1UnJpcVlzTjBDLzQ4T29idkJhWnRK?=
 =?utf-8?B?TnFMYkpab2tKZ3JUdWRuaFd4WmFaUWorY292TDNmc0Mzd1k5QkRWMVVwclB2?=
 =?utf-8?B?T3RBdG1zZmpoamM3SGVWbGV1Y2s1dy9lS01jY21Gb0xab2dscGkwRWFvQnBW?=
 =?utf-8?B?dXpsTzQxYzlvVjkvT0YwWGtZVmxXN1ZnYmkvSlJBUERvaDhaY2hPMGl6Q3lK?=
 =?utf-8?B?UWlyNHBFMTFUMmxDcUFESk5DbDlkYVFtT0pzN2dxbW05cE9QcDhGVjdZTXpp?=
 =?utf-8?B?dFRBbFd6c2ZkTHoxZ1U4UExZQXQ1bWFsdUMwZ0gvelFJK242aXNtZHZVNlJZ?=
 =?utf-8?B?emFuZHhHUmdyOTdVckR3a3A4dWN2dXdpNkxWY3lBMFFyVm0zdHd2RG9CRFdn?=
 =?utf-8?B?eU5JdnBQN3I2OUpxMG1wRi9GUGhKNTFhSXN4MGdjaUpOQndlOXBMTnJESmRz?=
 =?utf-8?B?SklGOEpCNjA2cUdEeDZDTVVPZ3dSRWdTUUUwKzVhZHFDWnRUdHB3MTMybk1x?=
 =?utf-8?B?OXRlc1lOUGx0RThFMWRHSkJHZFNud04vUzZDSklmOUZrRFNVR25ITGF5S1N6?=
 =?utf-8?B?am1KeEZxbmVOOVMvZFE0Vko4aVRVSnhTUUQ2WGFzNWtJa1BjME03dktoTWFC?=
 =?utf-8?B?N1RqTS95cHFpTUtFcGc3b1ZHSFEzYmtxQkVBVlEyQ0ozMGpHblVma0hOL3NK?=
 =?utf-8?B?STRUUGk2Q003WW5tMWVJZW9ZYW5QUlBlYXRLYlBWVGpsYllLUHJia0UzRWly?=
 =?utf-8?B?VzdCU1Y4TDF0ZHA5c2gxakw5YU4rNGlKVVQ1RktJcDZXN0FiV09jYWRNZDV1?=
 =?utf-8?B?UmhqdUpzeTBTb3FySzZhTXQyUWpBMTlXN09XS0FhcGN2YnpBcnRaQkRrQUFZ?=
 =?utf-8?B?QkhOaXJiVktzSkFEUE53S1hEd3JJejlpZ2Z2YWNaRnZHZHZyK2pES21zVXdZ?=
 =?utf-8?B?aEU3R0RkNjFvdEZOMmJrYnpZVm9wSFl6TWg5Smp5TmI2YWRPWFIyblF2bU4w?=
 =?utf-8?B?WmFyZFNETHNKSmVVYWpWRHRsc1ZuYXF2NkEzd0QvQ28rbzdqVEtIWkN2emNL?=
 =?utf-8?B?djVyeDh6eTRaMGFHeDVoN3JoSk9RaktLaUxRaWJLUXY4L0JFdTIvREFlbzRU?=
 =?utf-8?B?SVowb293L2NPYTVubUJKN0t1VFVlVnd5Qm13cGpFUVp3emxhRSs0NmVFZWNO?=
 =?utf-8?B?MERLOTFzUStsV1NJYlROYmd1WThkN2xQRy9VclJ5anpBcXZnVlhNOTd0azVj?=
 =?utf-8?B?Zm9KTEV4MVNLQ21zNGtYS3B6S1piVWlhZjJTQUwwSTc1RzE3RWVITDBPejJD?=
 =?utf-8?Q?uuuC2uhTfssuw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB6158.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnN6UDNWdmk4VDNPcVUxR1VQMzVNQVMyQWdJaHprdU1EZWZEOUw4SnJHR1pT?=
 =?utf-8?B?N1hPSFVDcWM2TzBORlgvUUs1WThub1kyRndSaGsvbXJGOUlKaHFlYm4xdEd2?=
 =?utf-8?B?UWN0d29hOUhjaGFnTGZmVkFxb2ZIczRCKzc5RC9ENCtlNEdTclRKcXpoTi9K?=
 =?utf-8?B?ZEV5TmZTMGdQN0ZoaDlVTDlIK293QW40T1JSa1lHSURuRFlUbHYyNENjNXhU?=
 =?utf-8?B?N0VPeDZCcytqVjVET05NWTVsV3IvYkdYZit3T0hadXZHaHhnUnRDK3M4a2RX?=
 =?utf-8?B?TS9ZYmhFNFFVUFFyaVJwdlVTUVgrU1EwditUZ3hHdWNaODl4cnE3aktDQWxJ?=
 =?utf-8?B?UDViM0ZrM3pZQ0xCSzVhUVdxTmYzcUhGWXhlRXIva1pjdzd6djNWNkF4dXU3?=
 =?utf-8?B?T2R4S1NzQnNLUVRFcjRuOXBSWUZDd0FITFNWNkNWaUgyOHZrSEhaRzROZGxz?=
 =?utf-8?B?VjV1TXEzMTZVSXJoTlUrdUJVVWhseVVpc0ZMYW1OL1ZZRFBDOGwzUFdZWlo2?=
 =?utf-8?B?SVhkajNXTVhpRjdPOHhjWmJGV1piV0dCeWdkZ0JMM1lVSUZSbk9qeHk0S2ZK?=
 =?utf-8?B?Njhiak51RXR1SlRyTFBwUVBqSHBLbDBPbm9peEFLV1NaSGxnRkRHZDZLOTBO?=
 =?utf-8?B?RkU1dy9PMVZIdHQyY2RKeEVWRjRJZEw3YTVZV1lGT21McXZoT1owYlBqZWx5?=
 =?utf-8?B?cEZPcTVtbGE2SHJNNDlpS3RtTXZZSVR0aWtMOUJHTVVQb2xiaENISTFmcDBI?=
 =?utf-8?B?TGV4YkJZQ3V6K0NwNU41cloxa2NkYWNpR2RPb2Z3SW5ncVpmZ0s4b3dzNDJK?=
 =?utf-8?B?S1hiRHR6SzZPTFJCOHAyUzl1RUJYR3B0aThOTjlBTlNtSDVaRlRDaVYwS3ZQ?=
 =?utf-8?B?czBwb2VMODY3djVmUDNZNTFYcVE2M1BYQzg4WHV4R3FodndvZW5OeWhuYnBm?=
 =?utf-8?B?WmJMdjU5VXUvRStXRG9lVW1jNkx5YjhPb05MdkhQbFkrUHJkdE1UMUcySENH?=
 =?utf-8?B?VitpbGVKTUdFcG5RRHhmeTNBYTVKRmpWdmFuQzRDUDVyL1FkRFIvSXJvRzhB?=
 =?utf-8?B?S2dYMjFmSng1WUVXSTBqN1NLQlF0QzRUczV4VWJMNS9Mc2l5MjFoTFdTYTRN?=
 =?utf-8?B?VUtYdmNYa1dZSVB2S0xwZmJYYVBoUUVwWUtERVY1eHBsWGZEd2VEQ3ZrWTJp?=
 =?utf-8?B?Z1RmUkFPTEQrK0dJTWliVDI4WUFiSUpkVUFFL21zSklYNVNQT1JoSFYweWhm?=
 =?utf-8?B?VFpSejNCZ2d0Z2JDVjVEdnJrMUtWS3QxZ3R1YkdPblNMb0N5SWRmTVlncmI3?=
 =?utf-8?B?L0NNTVh2d1l5aXUvUlYxRUJyVEZCME9KdjFtMlMrRFRsS0Vld3QzMkV6MjVy?=
 =?utf-8?B?dGlULzFtcXJCUkRJenkzc1JBeFBuWFdZVEZDTkJoZzdOcUFCd3kzS2tSN2E5?=
 =?utf-8?B?OGdDVG1WQjRQdTE5WFBGK1dlUGNmcEtxMWowRThNY1hHcmVFa3I4Q3RCdE5X?=
 =?utf-8?B?bXpGYU5UL2RJcFJCbEphUm5Db1NyZkVlWE9MVE5lRkF6WEp6bDdHcytMSm96?=
 =?utf-8?B?Qlo4SlhVR2tTWThYbklkYTB5WWNMRGhoSEM1QkFTRFhUeVFlL0YzRVhLWEZ3?=
 =?utf-8?B?bExwY3JJWHl5MkZyL0Qxc0hCc25jR2c4Zi9FbS9oY01keHRZYi9NRzZUTFpl?=
 =?utf-8?B?OVIzMUtqNUdPd1VkSE1vamFjeUlhelJpYlpjMVJocXVBaG9jL2hDYUFGZWla?=
 =?utf-8?B?RnF0ZllTY2hDVE9MS1ZxMDNvLzVuVDlxV2dSRGlYNWo1YUZJMDYzTTJRQ3ZB?=
 =?utf-8?B?dGhhdUtlMVhZMTRnUTZmaGdzMU9wbmpXTnpna3BRaXVkWFozMkZXYWh0RVNX?=
 =?utf-8?B?T3NKb0w2eTExOVVoQWx6b3BsL3VJNzcxQVUvUkNmV3JmMjN0WDRYVE1TWFRR?=
 =?utf-8?B?eG01MUpiRGEzd2VOaGZSaDB2WStMWmYwU2xCU3VYMVMwQ1U3V3pPMEU4NXJY?=
 =?utf-8?B?cjBwcWV0b1JLQUNpaWpFMFErME1RR2tRV0QwQmhhcFIyOUVOTXgwcktXMzJN?=
 =?utf-8?B?SmYwYjhUWllwdTlKckx1S1ZmS1FMUjNTMzEwd3dCWjhuN09idHp0MngwTTZD?=
 =?utf-8?B?bnRSV3hUT3EyT2c4ZGsxeENzU1pWeDN5bXVWUWlWMDZ0QmIyQ2RWbnh2L3FL?=
 =?utf-8?Q?aF4ry47urEVuFHrmWrdugRk=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214b7251-ff12-478c-7913-08dd35e48948
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB6158.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 04:16:23.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOZFlzmJvtuRvijeFJjlVIdpVj/l1CWX+4qr/hLPZ2M/cwuCfBbUFrzKZqn/Bve4Kzmq5n7eTuOC/iRzjJ3aHnIy+fwVIRePhBuvzlScCjMJfYjOjtgLp9Wp7Mdbtp99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6482

On 1/15/25 2:14 PM, Fedor Pchelkin wrote:
> On Wed, 15. Jan 12:55, Dennis Dalessandro wrote:
>> On 12/27/24 6:09 PM, Vitaliy Shevtsov wrote:
>>> [Why]
>>> The fault injection code may have a buffer underflow, which may cause
>>> memory corruption by writing a newline character before the base address of
>>> the array. This can happen if the fault->opcodes bitmap is empty.
>>>
>>> Since a file in debugfs is created with an empty bitmap, it is possible to
>>> read the file before any set bits are written to it.
>>>
>>> [How]
>>> Fix this by checking that the size variable is greater than zero, otherwise
>>> return zero as the number of bytes read.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with Svace.
>>>
>>> Fixes: a74d5307caba ("IB/hfi1: Rework fault injection machinery")
>>> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
>>> ---
>>>  drivers/infiniband/hw/hfi1/fault.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
>>> index ec9ee59fcf0c..2d87f9c8b89d 100644
>>> --- a/drivers/infiniband/hw/hfi1/fault.c
>>> +++ b/drivers/infiniband/hw/hfi1/fault.c
>>> @@ -190,7 +190,8 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
>>>  		bit = find_next_bit(fault->opcodes, bitsize, zero);
>>>  	}
>>>  	debugfs_file_put(file->f_path.dentry);
>>> -	data[size - 1] = '\n';
>>> +	if (size)
>>> +		data[size - 1] = '\n';
>>>  	data[size] = '\0';
>>>  	ret = simple_read_from_buffer(buf, len, pos, data, size);
>>>  free_data:
>>
>> I don't think size can ever be 0. No reason to change this I don't think.
>>
>> -Denny
>>
> 
> Seems the patch description rather clearly shows the size can be zero in
> case the corresponding opcodes bitmap is empty. Which is the case when
> user reads the file before writing anything to it.

Guess it's OK then.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

