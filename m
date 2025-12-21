Return-Path: <linux-rdma+bounces-15136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01FCD42A5
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 17:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45F7430084CC
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Dec 2025 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540701EFF8D;
	Sun, 21 Dec 2025 16:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dWjQMPX6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FBHAmZlh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6BA78F2F
	for <linux-rdma@vger.kernel.org>; Sun, 21 Dec 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766333014; cv=fail; b=u79dGWGj6Aj1vZzrCzQRLLWSGDMTAIqyn4KaV1m5KowqSJtl4Vjg10WYb74E2owq8kUIMbpNf5zq2vgxCxaYo0gjWirlUAUsr3fHX1A088SVZrh7eKlU/kvV2zKWOUhVqW4IK/7phvCtKcNgeVRNIj2idF3/tUxZPvWPGnfK+1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766333014; c=relaxed/simple;
	bh=AAhl7NytqFfPoLFnPfDmY5UyZ1dTZtHBKnMhlxAu/uA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JjSXF6YLfmXXsFeK5au/3lfDxoLi+Yh5KYvXGQlsO0i5z10buqDLfm5b3EsyEqh2ytgPua4MGdbEHc78x6CcTKPhsD3hTAooW4JPdNBkAyI2iIp/GbweP4KD66zhh57pKHSCxv4xga4aq4iYNhHh8kzIK364plO0dkBP9GazFnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dWjQMPX6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FBHAmZlh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLEUZar4146676;
	Sun, 21 Dec 2025 16:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=46X77JUGyGNNBPe360niEfRcf90Kuzw4pmj5wFsqvaw=; b=
	dWjQMPX6RwgnYj+bxMLzuc3eJ4Ekiowbmxg21OhTsGXt2s2FuJOi2UlZkJmLwx61
	h8RdilFM6hjrhiA+V4iZ45e/hxHQI1kZmmR5pDNT1KRayKezJQVZ2odWx7+/ZMav
	BjEICs8nQTftYmsgrZBGZv6NsuUbqK7Z1KA75NPc0BPPSBUIOGAgOSVSRasUnIiV
	WNgNxRagoGsXPL5z80cf+dcVSDxIMjkgn3F7U2tKDKVjZyNBptK/5Bqs/L7RP3n/
	2p+DhhQJI08eqYPka1oX8SqH2U3sYX42w2ocf/jeyW0qNAFcqwLAHB4ou6eYAPks
	N41TIGFXMg3IigA6gbVzOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b6f3c0402-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Dec 2025 16:03:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLEY4lB032680;
	Sun, 21 Dec 2025 16:03:21 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j86k5qb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Dec 2025 16:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaUMJZqXAnFlWX4HSgbg7eKhBg0IZbfDyrlXBNl76n5+p9fzSEwAkuq+HTzNfKfFppfSr9HPccCcmNiR9EmFeXRHiTkrRu1KDlusByE66p3uGAewTc7n/2dXt+o3XqdEYALV0H5jZOPFIlAuHJ+NI31+H+x2izn48NLtOf+t7Y77QyRMfhRznNho3PmTAeUVUr9TvdXp3wzOGlo7NTuj1gR7tpM99d/NVG7hJpWKZBS0EadH0qmrhFNte2ZL3VTGpILeMU0+COHwVusjaga2cOmad5NojLPIh7E8C0nhHIRK2vEk2bIVNpU+BRxWIbM54LEtvaRM/F8HNytrYXY/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46X77JUGyGNNBPe360niEfRcf90Kuzw4pmj5wFsqvaw=;
 b=HTt0JISkwmc3nAt3jHS8wqaQ8PU0w6tX7l4JnvKDNSuS9fKxPcDJw3c7lKIEsw5A2Ry8dE/wKvkm/4e3KHxA6wHrSSNo75c1cyBQSiUarfYW3IzpnN+OqnsfIk9W+HOObYnUWSJdtXzMAq6LGevPbNUg3ry8dQGpSE3dt5BdATqkIOoyb+vnv4OxrmFCtP08ZsoCl/Zlb3Nhn+iMLx+u3YoNY9unA72GZ6sOFzhjjbJQOSuoh0aPGTihFd+FJMQC1rm64n5S6pc3/Gh9h1hNmnZEGnjv8o9fLoKmBleQPfLRmW6FEiIxa+13kqobJPraICRLrnXiwf4cmH8xtPHYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46X77JUGyGNNBPe360niEfRcf90Kuzw4pmj5wFsqvaw=;
 b=FBHAmZlhDo3lZZUCCGUy3g1sTiHrbLQD9RsJfI5ZBm0STMXpIp2GUhXSXisNmIi9MssfkXsIyxj5kDpFwM55K6fH5U99cMyqOB0YNgdS/JHuASoZL3v6EBe2uuWhYH6/EOaP4wFnJ7f+6ZYD6J+WO1MpPS2eY0Zr+X53kAzqaDw=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH0PR10MB5819.namprd10.prod.outlook.com (2603:10b6:510:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Sun, 21 Dec
 2025 16:03:13 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9434.009; Sun, 21 Dec 2025
 16:03:12 +0000
Message-ID: <af5ee481-9626-4881-871c-92be62138fc3@oracle.com>
Date: Sun, 21 Dec 2025 21:33:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/bnxt_re: Fix IB_SEND_IP_CSUM handling in post_send
To: Leon Romanovsky <leon@kernel.org>
Cc: somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com,
        selvin.xavier@broadcom.com, linux-rdma@vger.kernel.org,
        alok.a.tiwarilinux@gmail.com
References: <20251219093308.2415620-1-alok.a.tiwari@oracle.com>
 <20251221094223.GH13030@unreal>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20251221094223.GH13030@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH0PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5029d4-d5a4-4902-92ae-08de40aa7179
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXFrWkIrbjd1QTF1TWl6cnBtOHZqeWFBSkl3NXJLYmJNSGxYdTY4RGJjNkpQ?=
 =?utf-8?B?QzNBMHU3NW9NRHFyclFZLy9ERVcwRVkxNnRvUjdKeVhvN3ZwVDZ1ekF3QmxG?=
 =?utf-8?B?c3NRUlJ6TU4zWjFYZmxLbUc2eHhKNTlYbzZ0T1VZOStzZ1ViaUFHa0V6bEpm?=
 =?utf-8?B?WkZGUVNuT3hLQnVvdWVEcDJBUVg2SS9DWkpBTTV1UnpJZUNXSDJGUEVObjE2?=
 =?utf-8?B?dkNLcVliL1ovTTZnMzBPdVNzTnpLQWVIenBHV3IzL2FIVWV2SkJ6TWRjZ0Vz?=
 =?utf-8?B?c0xyZndOVVRQZU9xVFpiYWh4NHprbDlHRGtLWmcwb2swRDZqWVp4MjlnT2hV?=
 =?utf-8?B?MHh1Lzc3Y2pySVlpWitGTFl1QlNHREZnQ3pOUVIvS29YUUdPcEp2VmlZNWQw?=
 =?utf-8?B?TDlYNEZmTElEUlcrVzAxYnNFQnA3UUc0V0V0WXc0UVhEZGFYV3BVdFA1WTRk?=
 =?utf-8?B?dWoxUmg5YklBQ2FkaVhSc2xpclhUYWVuTXFERXF5ZjcwTTNDcnkwQkFJbHdL?=
 =?utf-8?B?eFBSczR5YWtSRUZDUDc1YnN1dk1QcWY0KzJuc0ZHTWdRT1N6NFZIOCtqdG1X?=
 =?utf-8?B?b0o3ajRGV3BzaHZTUUUzVE82M296WGpjSTZWbTQvcVlwWmY3dlAxaWxHbUZ2?=
 =?utf-8?B?K0lta2Z2Q0trdmRuelcxYTZuT3FVa2cxbEJuZkgxdHVFQXlZNDI3T0RMd0Zp?=
 =?utf-8?B?OHM4MjF6dDg2VjFWc1VvcVp3UlRITG5LZ09xbkVBK1RRWTdvb21TakoyVmY1?=
 =?utf-8?B?Y3o1dm94dTdiakIwM0JUNmhxZHJZYytZUVVlZGgyam9uNStTSUVMWEtTM3g0?=
 =?utf-8?B?WVllNDFBQ05aaVBGRGNwa01PeFVFUUN0c2dxMXh4NnlhTUpOaHFpcWpQbXhZ?=
 =?utf-8?B?dnYwak5TaFlzWjBNa3NJdE1PemxodmpnUlZ0MXM0a3pnT1lGWlQ0NHRoRWJu?=
 =?utf-8?B?OGJWZEkzR3JaQUoxWVh3RElCeHAzc1V2aWdCZFVGanJCejJNNmREZ29VWERh?=
 =?utf-8?B?RDR5ZFh2bkpEdldQaTBaT3BrZlphdmE0RlhLVGRkS0FUbWVlck9TL0tIeEhy?=
 =?utf-8?B?c1pJTlZVNHlvQWZpbGxnZEo0aUtiOXJrMFJUdzhVcUNsNWxnVnVLWnlDaTR1?=
 =?utf-8?B?Q3Nxc1Y0cVZnQUh5VytSY0R2MzE3NW5udnZCZEZIMkt2b1RQS3VTOVc1Rzhs?=
 =?utf-8?B?SDBrM1VKZUZtZzFxUElMMEpyOW5yK1hLdzZNMVJCQzZCcldQTXQzaHgzNzJJ?=
 =?utf-8?B?NTRDZ0RIYlZteE10WFFFZHNrZkthbzVTaFlZb2V2bHhBRWlXZ1lubUtVaTF5?=
 =?utf-8?B?bVhxZkhicmJFNlBVekM4bk05Z3VOU0EyWlE0TVJLOXhkN3pvQkxvSzMvNWxM?=
 =?utf-8?B?RDJ1a3d1RWtnbmJGTEtJOUlwcnljSTF6T3JVVlpQYnpIN1VIODJUMjJkSHZ3?=
 =?utf-8?B?ZEs1c1p0MHlZejdwVEFEcmFudHVkQjc1Y2R5QmR5ZFdhN1ZvdlBlNzNrTDFi?=
 =?utf-8?B?N3RJY3RHL0FVME5SaHBPVUNjeWVIUmZJdDZqY2JCWEMrTURvalVLaHR2MnA2?=
 =?utf-8?B?NFNvcDFxcTRWdmpRc25zME83cUtjWngzY2Uya0hhS0VwV1BXMTRjTnl4YnFZ?=
 =?utf-8?B?ektReXo5ak1rVkJnWUgvRklXeUUrMXpyTFd3MEJEQXdzaVpkQktZSlkvM2or?=
 =?utf-8?B?Mnh1RUlNbWpBMnd6c0pPR0M2WFhVNGljYUxKVlNaUUdYdUtMZCtyY0VwSFRn?=
 =?utf-8?B?UjZpdFpBQ2NqV1g4QWZoZzRqRDFBTS9aVkF1Z1diSTkzMkpkZ01rQUg2REVF?=
 =?utf-8?B?dWhFUkNLTkJ3OGpqbjloS2NSUWh4UUVaV20vejdSMTdSMEVjNFRWVTJhNitN?=
 =?utf-8?B?T21NMDJoWnlUSHNjaUNPRmNsUmQ2b0NPVWl0QnA5VTdCTkZjQlJVVFBaZmRj?=
 =?utf-8?Q?SYUNQBCg8ZWcq+bITqF9p2iBiofjyqw+?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NkNoYk9SdlM2Tkt4QnBJZVk0ZGdyUjIrVWh1eFNmMFFza1FZRzl5OEFYYkJ4?=
 =?utf-8?B?Qm5pUEl5VzR6eEU5UVg5eS94ZDhZbHIrRFJaNkdQVnZpUEVGc3dzZE1yZmxs?=
 =?utf-8?B?N2tpUUYvYTZsN044M1BnSTVYUkZzRTd6SnE2dDVncnBKa2w0Zmc1RGNYeXFk?=
 =?utf-8?B?VjVNMTZTOFdSQzdwUG1CdnJ2R2Y3azZBVDVscy9qOTdGRy9pUWo4MkRZV2JD?=
 =?utf-8?B?aU9STG1ZMUFUY1NrYmROZ0dJVkJvTGNlLzVHcHVqeityeWxnR2hYUHFnWUl4?=
 =?utf-8?B?MmM2bFlzcTg3Ym5MKzY1ZlAyQVFNdlpWejVLNXluQSszMTY0bGJVc05sYWc2?=
 =?utf-8?B?NnhSLzNrS0g1d1NPRklTZ09HTkordkhpTzdvZnZIK25HNFVYY1BaWGdjb3lX?=
 =?utf-8?B?Uy8vb29BS2tPa0tjYlZwQThXZ2plWVpKdEYxSitjb1pUSnRsaWRQVHBUcGVs?=
 =?utf-8?B?SW5tMDByd3JUYXRtR1Eyd2pxMm9FT0wxTDhXd2lqNUd3ckJmM2ZacDdpUTlI?=
 =?utf-8?B?QUFaVE5HclR1V1ozTllUM1hCOWRjT1FtYVo3QWJUdVRJTFBBQnJjQjh5d01V?=
 =?utf-8?B?WkhBYlNxMGtOZGNmWGcyS3U4aTFqV0xWc1Z3TW1aMHFTeGVJREpxR1FDSEJy?=
 =?utf-8?B?Q1pEeUlGd1l6ek11cXN4QWwrMWNrQjUzUnZNU3ltOVltWjNIUG5XbTB5VGZB?=
 =?utf-8?B?VFhsYU1BL2hYcXQzU1Q4SUhCTkdobTMvUzhLbnA5L2xkUnUzWmFDYWlXSzA5?=
 =?utf-8?B?MW9RaVNTN1BVNy9qOGhCcHRBeWdsREJ2ODUzc3V5QjN5cTBuRUp5di9VSFJq?=
 =?utf-8?B?MzNGY2ZHSG9TZFVrNnA2dTVlcjV6RjZsdTdray92Z3hXRzhDTVVkNWV2VUc0?=
 =?utf-8?B?UDZUK1ZqaEo0UE9ycWJGNGd5VjV3SDVBZG1BU0x4dnRUdjhzSTZPMDltRTRh?=
 =?utf-8?B?eDZHb3hGVHpDUXRoOU5jSW15UEFUYkFXSHdJK0R4SGcwaHh1YWQ3dTAvU0JE?=
 =?utf-8?B?S09tUUlXa0dBNFdIaW9VVEJTb3VTWUxZUE8rYStaOXlxWjBDdGRPM0RGdUZR?=
 =?utf-8?B?QnV6eUZOeHYwMUNqM2VhSTlmSlpPVlloQXJUa1RJS1JjaExHS2RtNXFBYnRx?=
 =?utf-8?B?dmZHMDV3M1JsNTRNVlR4RFAyampQQU1wWk1HZ3RCYUFNcUhId25nZHNoVnFQ?=
 =?utf-8?B?dzN6YUJjdFdmL0pMNTBweEVzZ3BSbzhwWWxBOU5hUHQ4b0x1VW5ETUlyTTVV?=
 =?utf-8?B?dEl0L2oxVkoxZ013ajRHc0grdWhGM084R2pXeVluQWtUbHo1cmpuQUpRZ0Y5?=
 =?utf-8?B?dUN3RFFHc3ZmQlpJTHZPdEgya1E5bzZxQjBjUWRmR0pySlh1YnJWNVErOHY1?=
 =?utf-8?B?WXp0UGw5MEJ4SFVmYVo0bFJmNzN5SXZGNFcwN0FTQkR5bmwvaW9OaXQ1cXJJ?=
 =?utf-8?B?VW1HZi9iczA0Ti95cHQzTlpPMmlLd1hqUkpUclFjOWVGSk5XZzNJUmlaUzBa?=
 =?utf-8?B?QkRrN0JTUUYvYnZOUGVEQmYzWkd1R1J0WVVJdndjRHdJdkt5S2FSK3ZFakhI?=
 =?utf-8?B?M0xET2FhSjgzQjJlTjhoc3p2ayt0MmJlV2dXT294YW52VGR5aXlxaGRWQjMx?=
 =?utf-8?B?YkloKzgwUmdPVWMzQm1uWjJsWUpROXFRalNJV3g3eUZncHZqL0p4RmxxckVq?=
 =?utf-8?B?YnVUWk9raXAzMUNEelJydzhZaXNIWGtOSTJTNk1ZN3NSQXlaeEF1QnhCSWJv?=
 =?utf-8?B?YjZVOFhuVEdxdXBid2w5VzM2a3VjaENDb3o3WTJ4a0ZmVzdFTG91NS83ME13?=
 =?utf-8?B?bTNMWCt1eFJJckE0ZlFsMzlPSnhLV0xxYTBXY2dFS2l3WE1YMXFGN2g3cnVH?=
 =?utf-8?B?aGVPOS9ucmJYRHFvV0lqSmtBY012Sy90WWdzdkMxTzl3S1B5MVVVUDFxQ1Bl?=
 =?utf-8?B?QTg5QWpYbzRkR09rZFhkUHFkaEx0cXQwWXV0bGw0aFVyc01Na0xPVXF3d0tG?=
 =?utf-8?B?eFJpaHNpZEM3OURMbmN2NzBzZHBzUGtlY0hVU25vKzNvNStEemtlZlZndkU5?=
 =?utf-8?B?dUQ1Ymw2WHdrSlRIcmN6WTQ1UUdmdFJpamlLQ0V6dFJsTWxRNmlpSE1vaUI1?=
 =?utf-8?B?cTkyV0huTHlTZk1HbjU4WGppc3BDc1l0bjVtYVVLSWNOWDRjUFBacHdQRmNC?=
 =?utf-8?B?M1Q5elRyUVkrK3g4eUhMYTdlMTF4RzFMVFlzeTJ6bjNoa001b25Vc3pLeURu?=
 =?utf-8?B?MUpYVUxBVzhmZ2V6dnFzVWdlNUs2OWZOcytRZDAyek5qSVRzTDQ2TjJaMER3?=
 =?utf-8?B?VW9XZ2tsT1ZVK0s2WlBFWHQxT1ZQc1NlajZZclNnQlN6SkhTd2dkMUJQYmt5?=
 =?utf-8?Q?eyA/cZ8PGbOd6dyQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oGp3ca0w7YT8CewhomDXwlTKtBZNbnosmNFr62PZ6tAQII0NPUe+aqV9SyHjTy0G8W+dfpYBPw3QJdgJGmvKCfJfEjX5rWD4gRqfOleAMaietvtDUaPzdF2xoAHtmBX9IphiN6UAokcEc5Vg2odQXRI+1zEmLYzpZ0ua3etM0yhVDs2GjBKTgLjHJVbNzfPV5kOdyAVbHga99Fq543Ql9lABt3UN1uO+dxunml/B6zizFSnV/ANzOgz+rLT2kRNF3nkHeNvJBeVmAc2n1r6fL4VamCjkU10LNhYWwehjDH7G6WHfwmKv9FBu+OfMI7o7kSLDEXbK6MAKsTQJzwajw52n1QsMiKyt/YUqaXTHGKyacdFRk4HzOw7+Ysw6vCs/bsW0saCjr0xXjhBixSxNT5T9DCu+9sEzmP8B/R7Yk+xszgtOCK+KMlTm6rC6kn7icoGrnzp9akWPU6/waZDXNJO1DBjrdV0GezqFybUZXQ2WLkXPBNtcSI37URsCjticlAy8OYckMHEUJTcZG8lW6/frLwQfwC4ElmtQCTvzQLdhr/VJL+iEDwCqV5NO7nwHumDg3dHFu93f95H3Sa05Oux80MDEaTx8DsGsjkED28E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5029d4-d5a4-4902-92ae-08de40aa7179
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2025 16:03:12.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGFBQCPwdnOE1uJCqw51QHCGoM/ClyzmrqsF+07NM0HsiQBejYCbQJDyzqfSB3KwZkm31bO9kbYPj1CsBu49JPxPS9vpu/P2lXx2cA1MPO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_04,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=909 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512210150
X-Proofpoint-ORIG-GUID: wVKM8SClOG8HqtqGDbD4eB5sTe6gyXYw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIxMDE1MCBTYWx0ZWRfXwBG7NkilKxzq
 tVl8Oz6tRUf42kDaWutfJq7f9+NyWPdJo9jFhWlmio5A7BmYSK1f43I/1naoreWBxtH5cAZ30jl
 OQtDzvbAnEItGt2c1WOJOzUEJGgmTxLr7+WGtvD7X7GcEJsZLu9/RY9hE9z0rz6QRPupq9cOOYq
 Rcx8QEEyk2xTd8KaNDwade7wDTqUzmliJLIAz2Qk3RiNXJEtmb0yk6G0nq03uGE0SGzrkTaVwsb
 i1Ucg7rU2+WGioRqxfCjgUdh3Lba2dRO9Kw77PWftXusCPSu7s011RYTfwRwdh8LZ5tzLP/eYIL
 U8ZSPHCTFdK39Z2fsL8ttsE44joTuwuWo1+aA15YK+lp2Phv7Xl6Eu3fm2Sme4tL6j1RbfoMz7d
 6stTcw5HA7dwnh3sSJn5x+AEtFEu1t2N59yATDrUtAvfbv6ORVzFLB7hgrcGy0Qax2u/y1KSHPo
 LOKnMX5UkT04FEj6ypA==
X-Proofpoint-GUID: wVKM8SClOG8HqtqGDbD4eB5sTe6gyXYw
X-Authority-Analysis: v=2.4 cv=dsXWylg4 c=1 sm=1 tr=0 ts=69481a4a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=nkrK2eu8Cn60Qr870EcA:9 a=QEXdDO2ut3YA:10



On 12/21/2025 3:12 PM, Leon Romanovsky wrote:
>> -			switch (wr->send_flags) {
>> -			case IB_SEND_IP_CSUM:
>> +			if (wr->send_flags & IB_SEND_IP_CSUM)
>>   				wqe.rawqp1.lflags |=
>>   					SQ_SEND_RAWETH_QP1_LFLAGS_IP_CHKSUM;
>> -				break;
>> -			default:
>> -				break;
>> -			}
>>   			fallthrough;
> The combination of "default with break" and "fallthrough" doesn't make
> any sense. Are you sure that we should keep "fallthrough"?
> 
> Thanks

I removed the break.

For clarity, in the old code the break only exited the inner switch
(wr->send_flags):

         switch (wr->send_flags) {
         case IB_SEND_IP_CSUM:
                 ...
                 break;
         default:
                 break;
         }
         fallthrough;

Control then continued to the opcode fallthrough. The fallthrough is
required to keep the same behavior as before. IB_WR_SEND,
IB_WR_SEND_WITH_IMM, and IB_WR_SEND_WITH_INV all ultimately require
bnxt_re_build_send_wqe() to build the common SEND WQE, which is the core
SEND WQE builder.

Thanks,
Alok

