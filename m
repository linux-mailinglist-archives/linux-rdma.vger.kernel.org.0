Return-Path: <linux-rdma+bounces-3466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34179915DE4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 07:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850D4B229A4
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB598144D1C;
	Tue, 25 Jun 2024 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cp9V2dCA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Md9nCEnN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207E1428E0;
	Tue, 25 Jun 2024 05:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291657; cv=fail; b=jy6GvXEJNWN9oTAi6I96POJxmakNDJPJ7gSruyzhGbeyME36Ru8tJ/Sfgog5pq8kn+XJffnWI+HaBYGC/ElisOLkFKAWdfOfTb4Jk/Jh3dSzh4U//xQOL6Lup8p8Jt4woTk29E/5bRu9IrsfY43gdaTunniVvbvUhIyUaLmcfG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291657; c=relaxed/simple;
	bh=8ycouIqQR3KzWanpH0Gt2gFA6dh3yhbE9U9FfZ5MmNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqbN67GmFJ7cRWR8LpCr/zGzqAVH/DGlZGgDiKUvMiw3zIze1tTaf1v7OsPmKe+G8VCMnqs2lSc/+bnVaD7UHyahtPjlgnnpQmmL+ypX5TpX+gzJ8rDcHsjQ7RB8ocMRti2xf5H5WfAjHajT7FkyTHiJNGb3omRtKApT6vbtUL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cp9V2dCA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Md9nCEnN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OLanod026210;
	Tue, 25 Jun 2024 05:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=2yRkvUMMpWRiVn1BzoVaXfBnimCSmFIAZkVrw2MBJI0=; b=
	Cp9V2dCAGMHREVDNmU/yx1jEHEbRJtMFKwdHKLC/CLq3/JYMkRJJ+B3yA9OIkgzg
	nKwA6Bf8keVdaiK7huPYI9PZzDClh2BjkaTSCMVOvAjT07vVOBa6KXLi5vDjCCAD
	ZnoVL2PsD8bOLvb6w7MJSNYt8gEY/j0ChReYOCBct4z2lwRMwwiLhdzbz7pRwaBP
	vJKbusV6i/MbeJunrm6wdiV3odpzfImyVFu6GPYDSXKsZ+GA6smCMamot2LmNi0S
	rCKIwBQBA2nAlV/L6wTkRSXPAAEU8UjPHVec+4nTnUVtxiIurrfWjEU/cZ/JMGWq
	6bTcFLTjeLc6frB8O2B89g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg97kv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 05:00:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45P4WxiM037044;
	Tue, 25 Jun 2024 05:00:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn27dc3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 05:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfwTDhAdDx+If1K6kraxYS3Kf8aqytA15CV3YXiyBDIiWmlAB1yfDV2tuaM0cdWCdI4gjIdlcnkcbkWEUVf2Hm0cL5haSO1yjYeV/Olm2EODDFNimeyV7I7CINNL27INFImAdH2WWzR0Vx/Dvh1HI/q/cXMt4w4Y7n5zu2mIGA6ffO7NaZoX886vV7+Df/jg134WWJFffHNvwhw8ezjFsPCOGJpnHdLpTGOk9XsH8PERVqgwWFI+zHS1xPURCM1yFN6sy1qMl97rQ2g+/hfmRvriiE1eLWR3KNGED52rwChjCeJqeS2wdfMo521bofbz7ENnBZlEO85ecV7lw/tApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yRkvUMMpWRiVn1BzoVaXfBnimCSmFIAZkVrw2MBJI0=;
 b=I+H9XvMPpyzs0OtZXon9WWelXXqU02Em0tvHJsBnoCcTEmdNOZ4R1PC5Zc3ox+tyRWbvyqaRN3Qe1eeszgCrtJMOeUnhbQq3s+osrUj9GUg2WFPDvd37EK6BN9DDK5MnJ/zlESxp+n8eRpyGbmmsZ4Qpahwenbn4sICmg3NsUActC8tP4ukuCq3snVXu5woVFx+y5BTym4out6sAmldD+LdRsNzc1wdDUJXwSwFTlaCtwPryUd9cts4b7VTfifYu3z33rhBodeJIFHvgunUy/BlZ2me3T90h3WCPTWksgUrE3OyRrufc79dVjcmfZaCRAKa8kXUFReWzYUmTtNnvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yRkvUMMpWRiVn1BzoVaXfBnimCSmFIAZkVrw2MBJI0=;
 b=Md9nCEnNtQa54LA/I8wvs+Yfhln2ODJ1z5ECyTi1YQXs+dcObI4RdMvi2uabKnu4ejsPau9nGZHrieI4c6lBjhQsXfTW9FlPwq+5aGI1dFTi9x4/CmSt2jRQ0YfpqOtpqDEwhHPCzOnd11/5XzXYrMYl0xd2i4+pQj+Qv8aqgnk=
Received: from DM4PR10MB6111.namprd10.prod.outlook.com (2603:10b6:8:bf::9) by
 DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Tue, 25 Jun 2024 05:00:40 +0000
Received: from DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777]) by DM4PR10MB6111.namprd10.prod.outlook.com
 ([fe80::d8b5:ffc:6b9a:b777%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 05:00:40 +0000
Message-ID: <1f9868a7-a336-4a79-bc51-d29461295444@oracle.com>
Date: Tue, 25 Jun 2024 10:30:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net/mlx5: Reclaim max 50K pages at once
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        davem@davemloft.net
References: <20240624153321.29834-1-anand.a.khoje@oracle.com>
 <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
Content-Language: en-US
From: Anand Khoje <anand.a.khoje@oracle.com>
In-Reply-To: <0b926745-f2c9-4313-a874-4b7e059b8d64@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To DM4PR10MB6111.namprd10.prod.outlook.com
 (2603:10b6:8:bf::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6111:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1d7bf6-7c2e-4814-afa1-08dc94d3c230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ak41cjN3dkxXYklTdTZnWWdLUDIzRFZJRStZL3h5OFNSMUNCYWtqU1g3ZDhG?=
 =?utf-8?B?TVk0VTdvR25yRGpxdTVOOTlFU3AzUnZNWlVRSEtJcFErTDlNMUZKSXdwRU1k?=
 =?utf-8?B?dkhKVmxmY3NVd3BVdXJ5UThNMnJINkxuTVVFRUJIOVhqQWt2Y2o1V2I1d1Rj?=
 =?utf-8?B?MTF2NkwybDYxd0JybGJqb2dUS2dxMDFXNFFXaHhISjlodGNYNVRJcHZtQ1NF?=
 =?utf-8?B?U0FhWHlZdjVodzNNeER6eEtqeEdWN2F3MHlteTU3Y0d1K0R4YW53RERNa3g4?=
 =?utf-8?B?c3ZJVU1LQjNFVlVYM0wwbjVnYnBzZWI2NHNBbkdxc2dBSVVGaHdITG9Fb0xQ?=
 =?utf-8?B?ckVoK3BKRlg1TGdQUmNVNS8wRkxSWHB2R0I5d3ZXNzEyc3NuZXYyQlFPSC9E?=
 =?utf-8?B?ZkxBMWNkVHE0NmMzT0tYbUNqcis2S0w4dE90QW9pZzk4UE9vSGU1L1BDT0JS?=
 =?utf-8?B?NXhHcSt5RUVpalNIQXdUejNNWXR3TWhLNVJBNFZWdGxYN05UMjlwSkdiWGVy?=
 =?utf-8?B?WjhUUXVJekhPVXZoWWlWK3k0WmVsRWNyNGNaWFVYaTNCVUxyWUtzMkw5ZEpV?=
 =?utf-8?B?bDVZNFg1dWFhNW5LTjR5QWgyaW92UWdjRVRuWE5vY04xbWNDaHNGcjBlQWRm?=
 =?utf-8?B?YW5kY3ZmUmVEZU9lUS9zRXVTczU1QUMvSEZFWk9GNGdYRlNTQU90UkxZbmdI?=
 =?utf-8?B?UXlKWlVvR3ovaE1mTGJ0dVcvWGVsMVdldTZEYlF0WVZSV0FRQlM4c1dNT2hD?=
 =?utf-8?B?UWJoNEYveW1MMkt2dGI4VFpYVWluQjNVd1pXd0Z2cXZZS0Zsa0xmUmRqc1Br?=
 =?utf-8?B?M0grTUNLNlB2T1N5UGZNblhra2ZaVFl4Uk82aERTRjNIK2ZGQWRQOEQzTmRv?=
 =?utf-8?B?TitsMWFWbmVid0VzYVRBN2NoY0o2U080dk9IcmJzSUJuSHBNczM3S20xUEVx?=
 =?utf-8?B?cWtCcmdObzFSRlpRRmhRUUd3WDJ4VUoxejRXZ2owMXJwUGtZWS9OMEQ0eGpI?=
 =?utf-8?B?dnBKN3ZIOUdqSHNIZXhFSnI2K0pUSWlJQVc5SThrTzB5NjFpNVRCY01vYmxU?=
 =?utf-8?B?VTdhS3ZXZEd1N29WL3pabHd2N29JaThDbUVDVExZU29aUjk1KzFRbXVNL2Ns?=
 =?utf-8?B?ZytxbzRSRkx4TlhKMXJFcnFpUXArZDBrNnZiN1lGOCtBK1UvSG1Pck1WM3Uv?=
 =?utf-8?B?LzZMUEtiL1dGTmxtanl3eW5TYXZadll5RWFEem1Rd29iWHVwWm9yYjRTcStH?=
 =?utf-8?B?emtybXJYNHVjdzJuaGhsUGJtL3BFYnB4NGQ2ZGhna1Voam5LRGt0WWJvWGw1?=
 =?utf-8?B?VGkxeHNjNVNLMkl0RHVWZ3lkWjE1dTJXUjN1OTFzK3REdXYyQm9ic2lJejZk?=
 =?utf-8?B?VnpGUXNadDU0c25kc1hjd3BxeGtBS2VuMk92ZzV6NDNxOXcwV1QvRDZocGN4?=
 =?utf-8?B?V1doZTlPZHBQckFtcDYybE5IT1VNc29mUFQ0Nmc0MjQ3K2MxVDN1NVJ1YUJz?=
 =?utf-8?B?YkZpUlVzU3JvK0lIRXozYWh4bGE2d3l6VThQU3JmbzBGK0M3VXhIV1FmQUdF?=
 =?utf-8?B?bTZsWkxraSswdGdZY1Z0T2ZiaXUwWTdYTm1PUCtMRm5BNHl2TzBiMUlSd0Vi?=
 =?utf-8?B?RVVqY1RVS2Fzc3JORGovVnl4VmZHaXV5NVlMVUhzellMM2FUbmdtaVpLcXIw?=
 =?utf-8?B?b25vUExMTk9oY0RtVElVaU04TldhSElqd3daUHRuYlo5aEIxaXBJamNEZW42?=
 =?utf-8?Q?8rCHck0syHqFIpGSRmgTtx0TsR9OIJShcVDltt5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6111.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2xzbndEV0xvZlZQamh6Q0RJVk1rSkRGaUFmRytOWHZSRE1jR3NEbU5rNi92?=
 =?utf-8?B?ejYzMy9YTjd2cFdFMkRYQm5VbUhEc2tRUmtVTS9xdGNleDdqSzcyYk9pUWN5?=
 =?utf-8?B?TEpOb2VFSEZKdXFLODVnOVBoZ3FoYi9IVkRRVVBodnhTT2dqd2tTVHlNSkV6?=
 =?utf-8?B?azV6cVFOTVkrRkoyK1FGU1Z1WEhDYXpIbmE4WjJsd2gzend2cjl5VCswbk1V?=
 =?utf-8?B?LzZQOTZvb3FWOTNpc3pJTEVnTnUwTzdZbjRXR2swVWdOYjQvUVRQT3ArMkMw?=
 =?utf-8?B?M2xSUUN4STViM1dCSVJxM2VKTWVUWkFIOXo3dC9sMnhBRkMvYVZRbGJWdGpF?=
 =?utf-8?B?WmR6ZmN0aFBUYTBESGRadEJ2eWIvMjJVYi8rM2VSTndKM1IwOW16WC80Z2wv?=
 =?utf-8?B?SFY2WGhyQ2NJdHY1WGtDcWFBYkdBQ2pYZUhtRnZBTUpYSXVFWHp2N2IySXF3?=
 =?utf-8?B?UnBRdU1rMVkyaU1JWnp1Rkw2UmQvaHBVelgwSVZaNm9Ndkkvb3pCWXJyZ3lH?=
 =?utf-8?B?bFZsanhXQnA1Q20xYkFQT2thZURoc05ENFpjMGVhMWFTOFBGNm5QY3JRQS9u?=
 =?utf-8?B?SGFFdnppQ1lzS3R0Z01LSUpqZ1MzMXFxNlQ5T2c0WXV3enRJYUNaNHNDSWRo?=
 =?utf-8?B?V1pCcUlaVXNieHVYRElaWHRsSXdnRytkZmNUbC9MOXpuMmgrOWZRRy83OExw?=
 =?utf-8?B?K0JZcFl3OVN5akZPSUhEYUdrWGYwQlJwUmRGeXVYaXhZcUJ1RVFmWDQrZm0w?=
 =?utf-8?B?NnFCR215NFN4ZXhXcWlEUG9rVEI2NTZGUFVvNThCdnZnbkIyTmJiK2p1RnZM?=
 =?utf-8?B?VnhKR3Z2dVpUNldIYW5sQ2NXRytEaUljeml4V2lJNkVUMS9ZQUljN1hpaWNW?=
 =?utf-8?B?V3NvdldwSzVDYkNMVlYwT25qVUw5RG1UWUZHVkhxVkMvN3ZZUjduZmpYS0ND?=
 =?utf-8?B?N2VZdkI4VnRGUWQ1WEI0TkxLNk9aRlBteWpZSjBFNTE3RENtZyt3UkRNcUxK?=
 =?utf-8?B?b0dLMmdYWUpxeEY3Uyt3WkwwelhUMzE2Qk9oU0kreVUrUjdEeUV0OWdrM1lN?=
 =?utf-8?B?WE5jelZZVlpoaW0xV3FnUERtdVk3ZTc3ZFJJKzVDR0JyM1UzUXllUFRsb2xt?=
 =?utf-8?B?RjE4NW9vWkswSjlsblcyNVRQZ0VtZm5Va09RWjBtU1p5MGlybVJvdzhnaGNr?=
 =?utf-8?B?ZmVVeE44UGRtOGVhU2N6bS9hQS9pZGRiUFdoQldnQnNySVJMUE5CRDN5T3da?=
 =?utf-8?B?eEcwWmxYNVZ0OFNyUEQxdlBGVjV2MlJwcWJxNnZrSWUzQlg3clRYR3RUU0pZ?=
 =?utf-8?B?RWFhRTQ0MUdXT0d3VS8rZW5VaWFHZi9Ba0ljVDlmN0NsdlpOSnYzcVpxVnVK?=
 =?utf-8?B?WFArNnZkdkR6dTh4dGQwbmF3cFpYanBSSWk0eDR2Y284TUpDREZEOFloTU5h?=
 =?utf-8?B?bytGdC9WSGFSVlNTdW1GeGYrL1puNVhFMVNaaFFLTnFnSzFqa0w2OW9pU0dy?=
 =?utf-8?B?ODRuSUFzaW9Ya0RJWXJ3V0U3bFN1YnlRK1B1UUZwaUZaRUtDZlNBaEsrYWpE?=
 =?utf-8?B?czdqRnAxWVJXdXByM0IvL0hoQy9ucWRYMGFOUnJtemtuNU5RT1RubzVBSy9w?=
 =?utf-8?B?RGVTUlhsYWhMOHdYZGZKWFpsTlR5aCtGSnRYSzRla2pFQlZHMGlLWG1oOVF2?=
 =?utf-8?B?MytPT2hsc0FpeTl2ZmZvU2thZ3MwZHl4bmlQbVNtYmFsVEtkVWlKYzFFbUJH?=
 =?utf-8?B?VjNKVThNd3g5RnorcjhaVisxNUNIY0U1Sm1IRmU0ektFOU5pYkN0d3NRbnMy?=
 =?utf-8?B?dWJaNUdKUUl6TFI0TWNHZVV6UEJaR2I3WGhOZkpTSVlJS1RlQkczUFVnVVhO?=
 =?utf-8?B?a1pLazZwaEdPelZiS3pERE01aFpsS01PbnVMaHpCazFqRkxrMTdOUWFadVZi?=
 =?utf-8?B?NWJ3OGljdm9QQ0wxQXcwRWRVTWZIT3lNMkNBdDNOWlluM2RhRlB2NklOTTMw?=
 =?utf-8?B?S2J2VHZsa090ajdBYlVLMEFFQ2lWMGdKTnAyM05WU0IyZndHUGZjdnJDS05Z?=
 =?utf-8?B?bHQ0ZVBDT2lvR3dwWW0zQzhDdm8zZnA0OFd6RmdkK2crb1JEd1JlTWVYMjcw?=
 =?utf-8?B?VURmRVp6QjZpam80eUpXUEYvSHR6M1lWMWx1WW0rQ2Nmd000VTFwYWFxZllu?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gcDY/8KIfibvFcmgfPIwVhs+XdD1IsHzlI5nmp2hgTPXx9eGxVOcMZNqKRVtLpC6CK9zY6g7LIZe9qOIKKars+0LLc/6NFJc7wsgzAMJBdGYHFXmijeeOMq0FYn/gQs25qBFir3wvf+l5BsZNgLs4Y7/+pCDIH1ZHPqHgI7sDSUwJP8DYxHcmjXjIIkG78EVnzTW2lwc8lbOtcA6826hFHFz+oJJ/TX8sNbzTlJV+aQDkTJW6/CLSa18U9M3HnJFHkSQeB0kqaXm0p9k/Gzx9CzDhQ5EiEm5Q2NCapVXyORJWsn8Mz+EANmTYeaL3hK+gIouude130gCKWmy5zxE8KncguBIlTPxHUVugeaiBxRLfZC0Uq7WKRf+7m7wnHhHy0fXqqwu7pehr6YmUabYItZUVgz9Xim5yDO8T/4ovrVmrmqvA0o0fA/R7Up439fRxvXw9ZkpHeqay2hxlIxZ+irzFKfBoZmIX1fcaDwNMJYylGjfwfh+YnyfIe73VDzlFOvHx5h0YFkRQs2JhRrgdJCGPfDShgls5HGhj/IfNGgv3decvHfgO7CCPqJBmNWzWAAyps6KUiAx4LlBAtDEnmK1zm9H3qx5HQi5sWDBt+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1d7bf6-7c2e-4814-afa1-08dc94d3c230
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6111.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 05:00:40.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mdn5EmJBj99fcqD8+oeET+B+puBCBIJ38J+WSMh44k72SxUotq1hhhL3hmfSqlaQ1pNpTzfyV88QRtIjABMqzI0RKsekFddHTjCDZWTcz8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_01,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250036
X-Proofpoint-ORIG-GUID: dPF6H9W_WMRqZZx-x1AVJ6jgOH1X38YE
X-Proofpoint-GUID: dPF6H9W_WMRqZZx-x1AVJ6jgOH1X38YE


On 6/25/24 02:11, Jesse Brandeburg wrote:
> On 6/24/2024 8:33 AM, Anand Khoje wrote:
>
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>> @@ -608,6 +608,7 @@ enum {
>>   	RELEASE_ALL_PAGES_MASK = 0x4000,
>>   };
>>   
>> +#define MAX_RECLAIM_NPAGES -50000
> Can you please explain why this is negative? There doesn't seem to be
> any reason mentioned in the commit message or code.
>
> At the very least it's super confusing to have a MAX be negative, and at
> worst it's a bug. I don't have any other context on this code besides
> this patch, so an explanation would be helpful.
>
>
>
Hi Jesse,

The way Mellanox ConnectX5 driver handles 'release of allocated pages 
from HCA' or 'allocation of pages to HCA', is by sending an event to the 
host. This event will have number of pages in it. If the number is 
positive, that indicates HCA is requesting that number of pages to be 
allocated. And if that number is negative, it is the HCA indicating that 
that number of pages can be reclaimed by the host.

In this patch we are restricting the maximum number of pages that can be 
reclaimed to be 50000 (effectively this would be -50000 as it is 
reclaim). This limit is based on the capability of the firmware as it 
cannot release more than 50000 back to the host in one go.

I hope that explains.

Thanks,

Anand


