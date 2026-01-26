Return-Path: <linux-rdma+bounces-16031-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHWBLfq2d2nKkQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16031-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 19:48:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5C08C33D
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 19:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CA93036761
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765D2AEF5;
	Mon, 26 Jan 2026 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HmKeyYCx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bYvgNZFJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91C21B185;
	Mon, 26 Jan 2026 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453248; cv=fail; b=R6ZEjEWq9DtfeSi5MrOUTQ11uFn0FdBc07QfRKdiB0HR3B3f6he7gZnzQDF+Lo5G0MzHXKR6UOVKODqFspFn97nXMavNhTY41itM+HsFv5Ba5LvxYGiuCrZ67hfqnhaH23LNio3EfkE8JG3aJ9zolETnsJXb5UWI9HbiyMdVQXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453248; c=relaxed/simple;
	bh=vrBkzk0HCwUZu+9gcamuT9uAYfhcQbFCXzpdFlNn0lQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vmp1uVdtB37zef+bUKCogCRf9Izn79o0WPhQcm7AJexTw/iBDvJ1LwE8e+zFNPErAHdqkQySvtQrCSWWxcLncsJ3UZ3RNLyCssMeNCv3oEXEwAB5Y3X+5Si9x/WdncL2mOow6TU+7ezxvtkEkkgS5Z1TdLmkDfChszeX+H1CtyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HmKeyYCx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bYvgNZFJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QHHjh3247091;
	Mon, 26 Jan 2026 18:47:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FTXGAeHQlvlGsDFm14iAMdU7/HWWyHKgsJW27vUur5k=; b=
	HmKeyYCxBXUFyN+SHGIb7zQYLQR7yerot2IZzZl5XptHqDqOAVjT0uKGzNbpxS0u
	SgJW00cn6F0DHn5GJXgdijQX2jGlWmDMwipwu60NVSvHvsbahm0GkOCmXKj2L71v
	otUlYKWGPLnCe/ZviJV5coXf/wc4ai0LSUyy2GIs8NzHDWzJkaR4OR/K0eOl83LT
	bxkfts8kAYfIjrJJQMcHWn78S7Mfhpgd8ZlsJSTY4huGWUiLCpY3ApC85+DL2W/6
	mgK2XDl02cejBUwVpiV3Lji+RFaxVKbS3/xnumzPVbtNgUDw18MrOCUWo73063JM
	LY3hkAxEjwzWTq03RhVnCA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09jnwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 18:47:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QHoEUr010031;
	Mon, 26 Jan 2026 18:47:18 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh8b7qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 18:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTQm+tgDAvvYhr4tKIoMZxE6OICYWDJNdTP/4VZ58jMg3tV+ShmMdAQM+85//yEl3d+JYayt/7QC5BiIBi1KEFg6rrFhjAgv1EJH+xRCMkzlI0TBO4C75VP5gUyoPOigCk4iy/J4tLu1tUmQa4V/dXm/FKUjgP/JH9tzGZwZ2FtgSAEXa5LAqlbh4PBiQH7tlmqDb4tUEPBXSuACDmFcI6xiC4Q2txrFOATRce4gKcY5RVWkT+ojYwfYjMeVyjKKVIiRkbc6T0z0jKQi21E8fZ9tMR8Hzfq7rueKmycEe6mhl0EQs/N3AXPvXlkSQIsGMykZcS3AM4otoPOuEAd+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTXGAeHQlvlGsDFm14iAMdU7/HWWyHKgsJW27vUur5k=;
 b=pX7wfvFv19L7AGDGHwAHZvS3D6ZP4LNGgn4U3jlgklraSH8wHVaoZqIHYxzGzhmZIK7ymtcDRgo6imsaicyAUr+WUVeIreAelr+9W5guH0eyzxCDUEE1QFKF1tscO5vkCaOBSlWxVc86UfARYj7HcCU/DPy3DvqkTc+K3//QpX+lhNSzkic06eJhaFma7BUJCrduB9V0q/mL7bxzV3L7N6eLbLaX2dmozzGzUK+LNE6vxyyNzz2OwaiccwZofbYryyVGCgKAcLmwmtRtAqMpfbT2L/JWm1k83XAmHTFSj363zn7e8rocwNOddZTo9Uz10VTn9hvYjgDWBtqMclA+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTXGAeHQlvlGsDFm14iAMdU7/HWWyHKgsJW27vUur5k=;
 b=bYvgNZFJl5uAQDnQa4MWo2bwj0953iWmVl/fsBs5WzGTI09rJI6VXoqLveZTGyktcp29sl7+GcvpRviIkj2Hw9ZJO7aVaMG2Lbz9oxgl3dSKIT9TuRvr2u6e/wh7nT9noahI4AanqsOtDSoqL6bFRehkkbuK+hRj1xvH/J900vg=
Received: from DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c4b) by SA1PR10MB7753.namprd10.prod.outlook.com
 (2603:10b6:806:3a9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 18:47:13 +0000
Received: from DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 ([fe80::5d2f:bb52:4f85:9461]) by DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 ([fe80::5d2f:bb52:4f85:9461%7]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 18:47:13 +0000
Message-ID: <4ec19bf5-68da-4a6c-adcb-c8e127a7fcae@oracle.com>
Date: Mon, 26 Jan 2026 10:47:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rdma-next] RDMA/core: release devices_rwsem when calling
 device_del
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Parav Pandit <parav@nvidia.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ec221ec7-6abb-41b7-9237-8e799bbb5683@oracle.com>
 <20260119195329.GK961572@ziepe.ca> <20260125134759.GD13967@unreal>
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
In-Reply-To: <20260125134759.GD13967@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::34) To DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c4b)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPFC7DCDCAD9:EE_|SA1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: eb249976-568b-4672-5f7d-08de5d0b51f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmxlQ09qbXR4U3FuMmVKUjdmKzlqb1BJMWxjQkVyTDczVkdJNERSbTdnNzdB?=
 =?utf-8?B?UTNJb0VsYURheFUxODFRZU9pT1ljVlRjWFlPNkxVMmR1NmFDWjkyc0lPd3BY?=
 =?utf-8?B?U3lSbUhsNVhYakVubThOaHhZYkZNa2swVUxZeENyaGEwaDN5TVlLQ0k4Mlpw?=
 =?utf-8?B?Qkw5SURheGtGRFZhWTlNYzRrSDlSUk9vSktpWU9nZzhzUGkwcGtGVW1oanhQ?=
 =?utf-8?B?WW4vSG1NZGtPNGRhT0M1aldQYURTS2pWcnFxRk1nWVRIS3pIUEg3dE5TcFJZ?=
 =?utf-8?B?eVhuVGVBMzdEQ0oxYmQzL0R2ZEJWN1JLSDhlM3M2QUZhNkJjSXNtUkZJNnpv?=
 =?utf-8?B?M3M4OFB1QWNjVHRwT0Z6VzNyQUJuYWIySXJBalhlL0VYamtKMlFnL0pjNU9H?=
 =?utf-8?B?YnhMUERDLzN0dDVuSjZ3UlJwYXpzSkxlTjFiUG9rMUtrWHFwN3ZwdGpBUDgr?=
 =?utf-8?B?YXdOZWd3V1VzM1FyS1UxZS9FRlV4Sis3OTV0SGNJY1paUVZTaEYyT2pDMmJs?=
 =?utf-8?B?c2M3TGE4NERTN0N4SEVOM1pHeG5ESGU5NU53ZFZsQUhIWlZNS05KSmZ6NDBy?=
 =?utf-8?B?NHRwZHFLNjgrVE0xOUwwbWtTdVFnZkZvSWZkcVNvd1MvYUFuZCtxL0ltOUsr?=
 =?utf-8?B?Q2taKzRONm1KZG13c1gvMllZVmdybFRLQmRsRGp5TlJvdkVhaU95Y2pPMzRC?=
 =?utf-8?B?SUlldmx5Q1RVQXdwb3dUZ1Awd0JBM2dWVWFVSHh4OE1yV042ZDZSMy84Tm9N?=
 =?utf-8?B?UkxCbGJudnBNb1BjaVN6MkFteTNyOE45THdmVE13SzlJSWZwQjlwOWxoVER4?=
 =?utf-8?B?QWJJY2dKUDNyTU83ZWN5MEhjM0VpUXd0TUU5K1pvSndoUGNaK280OHRFaTlw?=
 =?utf-8?B?Tm9oaTdSQmtxcTh6Y1ZFM1c2QncyU0FCRUN3UnhuK0dvd2g4YXVPaXkvS0pF?=
 =?utf-8?B?WnUyU2pTZGRaYWV2ejRSdm85a2xNcjM1aElCdXRzd2pYdFUvc21DUnIvYVJo?=
 =?utf-8?B?S0Vxb2VkYzlhRDg3amhuVThmTEV6SjNaK2RQWXpuUTQ5N3N2Ty80d0dJOHBH?=
 =?utf-8?B?S3dYN3J4NFYxZ3N6OVcwTk5pOFJETFJIb3JCSWVqdVBMUWdTMkVqZXA2YTd2?=
 =?utf-8?B?ZU1LUlZ4U3VnT3JwdW9VWkdrMXZUbS8veWljKzRLRmxGeEo0Lzh6NUx1aUt2?=
 =?utf-8?B?WkVUUzdYY09HOUZKNzdDTnFySWdXNkwzK3NXODRnUFF2ZDFETUZZeWIrVXVi?=
 =?utf-8?B?OEZIUjFwWkhUUU9rSFFkNE5Menc1Y0FSVDFVeXF2SmJKSkZIQTNBSHM5bnQ2?=
 =?utf-8?B?VklNUUprSmIvRTltMUp3V25VYnpFOWloam5TbFJQb1ZYR3h5d1pKOW90cXZu?=
 =?utf-8?B?VGtvN2gvRjBaZlVmVmkvU0piWVdXTEJoVVJyQnpEM203bG0xRVB3WWZCQnBv?=
 =?utf-8?B?dk9KcWwrcDJzcGxOZ29YNmJqbWYvbHl6Qjl3cEpBaVRTb00vUmR6cFlKdW1C?=
 =?utf-8?B?VXJnV2NjV3ZQcVQ5YjRNQ0drTkdqU2tOb2hiQmk2ZTVoOUVVYTdLYVJwalFW?=
 =?utf-8?B?N3FaVmdPdnhndWl6K1V4REdlSEZDSG83ai90NksrSFlHWW9EMUhScjFXa011?=
 =?utf-8?B?cnE1Q2hqdmx6ekk5UzlhekNTL3djNFJ0cVlZWFU3U3UvRVJjcittUEtXbnpz?=
 =?utf-8?B?L05sVHV1WVZpWTV4NTNkWlF1QnlYQVpnL045SzhOaERmMkVpSDgvVkk2WHVu?=
 =?utf-8?B?cnd6dTNVSXhwVUd4bjh4czczS1F5WkdYMlY5Q0FvYkVXL1FFWFlrUytVWE8v?=
 =?utf-8?B?ejQ3elUrUzIzUXNKWWppQXFSMGRzR2MrQWFmN3JzbU1NL3ZWNFhGRTZseDZ4?=
 =?utf-8?B?cmhwOEs2bVc4RElXSUxiUnVWUjFvendvNjk2MTdUckNYUVQ5YklSdWUwMC9s?=
 =?utf-8?B?YjRQd2lWekJOc01JQ3VZSzd5elIydjNmZFU0SWNUem9RdmpsS083eitlWHFJ?=
 =?utf-8?B?Mmk5TUNyQmpXVzR2Ris5TmtHODR5bDczdmZNNlhqZ3hFTFJJMzUrbFhidU5Y?=
 =?utf-8?B?bWNwVjdSazB6dUttTDJHT29GTEdRWUxLY3NYd2x1S3ZzKy9OL1c5Vlg4THZQ?=
 =?utf-8?Q?gkb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPFC7DCDCAD9.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmY5NWMzVVgwQlA3dG4yMHdVODBDRTNEOFYralQzNVUyQlplTmloWHFDZ2ZJ?=
 =?utf-8?B?NVZ3RGJCelY3YTRORitzUHB5akdiT3VnTDBNemlaTWJ1djBvRUE2Ymh5NkxU?=
 =?utf-8?B?MTFEUXk5WHlmZ0Q0V0Ztblo3anNOenhHaEdWOVB0TkE4UnNmVHVsdm9lS3Zx?=
 =?utf-8?B?a0lyeExBNXJSYWpHNWlrc1htaFFyRWNHWWZPbFJxdDNaSzg1UDBBUjZ1OCtD?=
 =?utf-8?B?Rm9yZmJEYm44K3QzRkk2VWhyTTVOU3BFSTJ3MExYemFNVGk4cVRycmJ1Z3Nx?=
 =?utf-8?B?RTUwNmpvWkd3TzVLeDNkU2RLTXhtVVFwdTNsZkFNN3JWd2FYSksyUDdlbFY0?=
 =?utf-8?B?WGVNbzVNVkZZc1pRQlZkNTlQbDFxUzg3OXRnMXNlakhTRWVXT0pHV2JSa2pI?=
 =?utf-8?B?QldPRHJEc3dqYzN1YUJXRWgvQTdmT01QMnNFMkVDR0NsQXNGTFJ6Wk55TmVa?=
 =?utf-8?B?TmxTSE51NDJoZXI3NDV5aHhEby9PQy9xa0o0bzc2MEJUdnVEalVvQkZwRFRr?=
 =?utf-8?B?SnUwb2svZWh5UTJGZG96emJZdFMvTXViWUlKTjJaV1Rzeml0Z1BYNGtGV1hy?=
 =?utf-8?B?V1VZOXVsMzBLaWhHTDNRY2xBaVF5Tm1oaTZEdEZRcWJ5amlSaWNqR01JOXlP?=
 =?utf-8?B?ZHp6NnNKbFFZZVN0M1RsOVpBM3N1SWNydkxsZ1ZvdnJ2MzZHdUNqejNNMFRX?=
 =?utf-8?B?Vno0ZlR1N2VrV2Q1Zk5NMTBSUkhjQWlPdFcvL29RU0dRRmNXeXNjQjBkQk1G?=
 =?utf-8?B?bXdGYzlZcWpGUE91eHEwTG1UQnA3czdwVnJkZjZITGlCTU16S091M2taaGVz?=
 =?utf-8?B?V05FMllYd3V0d1lXcyt3KzJicEpJc0JBQXRqZGd6OEoweVUyNHhjQXBwOStH?=
 =?utf-8?B?QzRCTVNuMThZeTNQZUw5Qnh4bllxUnl2QVRHSGYwNmNZSlNhMTdnYlJqKzRE?=
 =?utf-8?B?WG9TbWk4QzBsTno1dWl2Y3NKVzVZcTlDTFpjM0JHQ2Y0WVJMdWRaR3B0QVo5?=
 =?utf-8?B?TWs1cmNUZENTSjN1YTNIUytYT0RTdE92TDNUNW9BRDZDb0EvVFRuOGl4SFBE?=
 =?utf-8?B?QWp6czZ6N09UNHo5eStYRFlrRHBKNXNJcW14bjNDdWUvYXBjU054RTdBRHln?=
 =?utf-8?B?TVA5d1diWWh6WFhZRE1WWnJLQ3pqVTFCd0d6OXhHWS8xM25adWRsTUlBSmx3?=
 =?utf-8?B?amN3SFVQODVSQXFqdjRjTmVnY3pBUThvSHJhRFRkeG5HaXdqQ0RFMEVXNVd4?=
 =?utf-8?B?VE5WT09PY21lb0ZWTGkyT1ZkbzQyUFlLQ1RQN3Z0MXJSNVBxbnZKeTR3SFVB?=
 =?utf-8?B?S25Tb0Q0bzQyalVOY01ZRlhyMHlBVml1Wnl5VlFKdEhmWnB6dG1BOWFJc0Vq?=
 =?utf-8?B?RElCcUszbk81OU5wbnU1ZjYxTGJvcm93RDhYaWttMHpEeUtFdlRKOXBZbE1Q?=
 =?utf-8?B?NFROSk9YTXk5WnBTeTJaenAzSmtEYy90S3NQWlVLUHFqMHVjM0RKdUxKT0N3?=
 =?utf-8?B?eTd4Z1FMc3FTU3pSRzNQczRtMXJNVzAxckFKQi8xb082dm83RE53ZWp5SnlK?=
 =?utf-8?B?Y3lRMG41NTlXaHFLU1BPWncrMnRkdlU0YUMzeTlzdHZSWENxSW0vQWdMM2Nn?=
 =?utf-8?B?ZWxDcE1xRExSQkFyMnd2OEpHRTcyV24vQjRSR0VFakxYejRjUFl3dlZmdFZh?=
 =?utf-8?B?VkFvVTM4aXVCWDNHVGNOSnRSKzBENzd2cGZ1VXpFdWIrZE9jSjBWcm1XSTds?=
 =?utf-8?B?b1BPdG9sV3J1VHZzUm9UUFhoSTlQQ1AyRTNITlVRRU14VlVWY04yVXErZGZh?=
 =?utf-8?B?bnk4U1h5QjJrY1U3ZmlheUdxU3BVVUN2VldQcm5nTm9iV08rL1BvdkpzcGp4?=
 =?utf-8?B?Qys4VlVVNEpDc3dLZWhaNit1WERBZ05rQy9vdVRDWS93YVgzQ1JZQmF6d3Yx?=
 =?utf-8?B?UjBjeE1DdWUrV2RhT1JOOUZpa0dqRlBwT3pIZlJzWWw1MU9yUFdkWm9UTVBV?=
 =?utf-8?B?RWFGYWljS0twczZhdTlwMC9jQkt4R2NLVkRySEhrZXBwWlIvWEl5Tko5dnl2?=
 =?utf-8?B?aHZqRit1cS9DM0QrQXQ4RGRFaDVhT1hrVXkwL1VZcDJyUENVS1B6K25hWFBF?=
 =?utf-8?B?b3l5S2tQOXZSN2FaeUJjZjVhNTNaM3c0QzdSRWxFcGoycHlyblNjSWdidTgv?=
 =?utf-8?B?ZHRiaDZ0ejIzMm5DQ0dVYTc0UzArbUFINnZNR3NDVDczMFJsUFN3TDZCR0Zo?=
 =?utf-8?B?L3JxTm83aUYvTHp6Ykc0UjF2SHdSR0JycUJXd1dLQWJ6Y2l0RjdBSyt0U3VP?=
 =?utf-8?B?VGJQRUo4S0xYcHJQamZ0VXQvU3VsN3lWNndKbkdVVmEzNmM0cXRTTk4vbENJ?=
 =?utf-8?Q?nSP48hcOXyKZP1Gg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tt6m6/8NyHnInogWEe++HKD2zCCK+EjBBSv6eiGmfIVd2+u/mBGKLopGuwWlIcVfSMSfntd8mYI8bByQxneAO7PswpuDtb2OHJCir9SiprEuXib73K50cvK/iOlJ2LwM8TvqOVcW6ymS4UxpruL0kD8rUKK8rCtZtf8+8qWNpO17ppsGLzvt4UFl90HMrtTKms+7itNInnzTFEt5ZzGKEmNvbzOFYaYIxnloARuqvy2tCrgkKLs1ahZX6bJgn/GNvz2aBoZNO6T9kD9foukf6kkrfcuO8Cf91CmDMPXeMzHwLICESaTdvcZ/P3GAqD2P4Qcwl+7bkVLjpU7i68UC2ueJmJXd7sbkz94oPJ39TDfFaFteOAGtW8iTtAQ0kqhVkq8yScDep2AJWVELRQ3DJJqVakAWUcIhz+dUgmRj+6gL0Zf2Kc0lxegPisa7OblRTjoRZNkD/UnbrSx9tJ9E90lu3ttoP8mGcbB4fCn5/POwc9lzElH2cfm7M50V4dYIMNLiu6ruGN8/RfdBUUvzaGYe2JogdMWnBenCzFL4WB9Ot6eQD7utjK94fgv25xLAo5TQX26mrlfdipdsaB2Iz4feoCBuyMXNwyqX2B79jvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb249976-568b-4672-5f7d-08de5d0b51f0
X-MS-Exchange-CrossTenant-AuthSource: DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 18:47:13.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTFePPYJvrcCckzD9LYjMXJ5jLtmVo0Bs/oiaJbo52RWHlIYu3rE9d0/rStreNCnSdSAM2+lhAnqwa8G7tgqVM2rgCIngbuobqU0FE3yOZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE2MCBTYWx0ZWRfX2yXRFgtmKfjQ
 v4VaafXPZKuR6SEMmsHxifvp+yXg+V7I4QE5tQYFp0lUoS39oXeQ8IRRJ0bvy/Lnq3krGnPmcLI
 mV4Nq91S4UDtsjcurjnfpKaBDdgPy43eZ/tUatJdeSr9B8zQ+oVURDSZ2W/eRzBXfGvUfQr0WaV
 9X0yTYOP6GEKW+sKW6bBsioaQ4cwVA0/FGSvnBg2pgerwFNtUNdzhNh9KXaWdda7wxdDC7Q8LRc
 UwkFsnvh5tcr0idri0pr0navKRR/wuwjjqjlnjnGm3cRM7ipeSsVBnUcAeHFlEr6bks3ZDUfzwy
 cxQv1cYE7EUg13l15wFgHGWMs1JU+ezVTML59EnzbVtiwv2U0pf2XHdjeFdZqwr7l2hKsZ2LoBH
 yICitCmJblZEYlAWfSWZay9rygh34U3+4CRWIS0FIRiTCByyQK6SgN8y5wJuMRm8jgEC3N3W6by
 8ft26o5WXaZ2tbjJ/Pg==
X-Proofpoint-ORIG-GUID: iFpQXjI67BHynJIDoDQ0EJ-Cc1HZ6Vci
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=6977b6b7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rTe0Ctux868Wug-MAtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iFpQXjI67BHynJIDoDQ0EJ-Cc1HZ6Vci
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16031-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sharath.srinivasan@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1A5C08C33D
X-Rspamd-Action: no action

On 2026-01-25 5:47 a.m., Leon Romanovsky wrote:
> On Mon, Jan 19, 2026 at 03:53:29PM -0400, Jason Gunthorpe wrote:
>> On Mon, Jan 19, 2026 at 11:43:52AM -0800, Sharath Srinivasan wrote:
>>> The sync strategy in remove_all_compat_devs() can improved
>>> by adopting that of rdma_dev_exit_net() which releases devices_rwsem
>>> before calling remove_one_compat_dev()/device_del().
>>>
>>> Also fixes a comment typo in rdma_dev_exit_net().
>>
>> You cannot change this locking without writing a huge commit message
>> explaining in detail the reason why any change like this is safe..
> 
> We can drop this patch, it doesn't even apply.
> 
> Thanks
> 

Thanks for trying. I'll send a rebased-v2 with an expanded commit message as Jason suggested.

Regards,
Sharath

>>
>> Jason
>>
> 


