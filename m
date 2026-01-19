Return-Path: <linux-rdma+bounces-15730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221ED3B780
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 20:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C7F8301F014
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AB2E2663;
	Mon, 19 Jan 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h1Pv4k2C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rPSl8FHM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA8271456;
	Mon, 19 Jan 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851855; cv=fail; b=ODZhiMJAXh1Hzqkw4Oe1W/ZuC5TRF5zGJpCfTtMCYpBaPNuKRMiiaYdcruWWathjtmjYI5Lf6LuBAENyTUmoqwy1v1DM6QjOYpIcPV/om9xbeAklV528/KAzvMAoBfiIdJS7BHrzrXNzV3u5jgOau0b8OkAhapDfe/Xs1vOp/q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851855; c=relaxed/simple;
	bh=/bfFMr8UTp/QMl5xE0UYbxdezurJY/2ZY7R+VQk9Iiw=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=R8xGi9f/VzOQmA9VmtEiWfhcMIU/xA/11KsJLMDQCujLR0M4NC1TwtXUVALNpyDhjvyBayCGJ2xmep82gBzmtCjeHOeAzvkjT0QhO2miPwstCSsR81Ey3OFUlksLcMa9eMIHJN2nM7XZmD3wY+LgRM0aHCx/BaCbLx8RQY+h+Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h1Pv4k2C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rPSl8FHM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDZEV1512530;
	Mon, 19 Jan 2026 19:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vrdlShM7ma6NdlQz
	5MrHXHtKZqWzVw6m4PkmM0K5RTs=; b=h1Pv4k2CdwtDgTsbT7CjZZI4raAPBFNJ
	bdrPGmSrwb36owJNNVJeQ1/mzyyIXYZEk3iom/zOr/CnsREO8Ki4TBqoLCWn3eUC
	Lprs2S1vheVSIbrtBa/SgP1f4e6FTdv5vsduACmwuwG5eq2dKEjXm607PkCO65q3
	xLqf8FCBwk0oB59J2Yel4XnjfX/Di7A6igFKhrGnuE2/tc8wYVFFBMUXEGjwC9U+
	SDIl6NMI6FfeswEJltCxfUxwAPFeJJmkj1HWHbm/1sUF87IM/q/19a7urkmRnoJP
	QFjLs3Vn8+xxt6tC4sFD3/86H+Uqf+JsYbS1RTCt2D9gAY4cMA1YDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br21qapp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 19:44:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60JIlNJV039307;
	Mon, 19 Jan 2026 19:44:02 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v8q2bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 19:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymSzz6vNQGrjLBGhM/zjEhzF0ddwoGHSZ/PdbL0inBjhMGPNjYXvripMg2bhd+DuX0okcZPTOvDnahJdH+YPHetdfAgwjXJ/qEXKKYtPJ09++m2utO/kUSCDWZB3FVrMe8BZ3+SHz5K0162kn4cI41q+kX/5et7dHOYmKuhWjLyJiBE92JmBE/+cadjvIVPDDPbH0T6SE2ymtOm0H4y+wCSteLUPTE8cGanoFVJ20dScrAsQtkIO93Ix8LblK91bXT+5rCe1Rj+nCD2vYWvfHQRvSHC5OtE3SZJ8K1AlEEI/QH3w2vw97ozuHECOCFpy1ztyEorYm5iEnJB2u805Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrdlShM7ma6NdlQz5MrHXHtKZqWzVw6m4PkmM0K5RTs=;
 b=ZIg5+CThLta3jwMMYq7U6GxZkqJCnLn8i3vJ4arxwTrpH0PpefsgDE0hQ8Bub9Be3V/2lONdKa0Kfk9ZMdbqVFnW2aSF8xFu0xYCh6piYftMHYqYRQABKPo2ZN9vQswtd0EUqRquKqNZ7MMXD/QdEHrzFI/9V2YFX15o5jvzStIpo2F3LRl+z/N1/tcioxLxht7nAgtxAghWxrxYwjzuacEFpzRfQn04e9+qcD0+J2tjBDg6dckpcUSUMYuKoNKTl2tTu5z/jKEPH3p+JaB+L6bxLTCNMb4T5RpmqJTIRE7y/iFNIPuTb8jEzmIe2V+1DUgfr/zBfinWnT0ujMykIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrdlShM7ma6NdlQz5MrHXHtKZqWzVw6m4PkmM0K5RTs=;
 b=rPSl8FHMzoSvT2eoebcNjKiLGnjJubg15SSSeziAMA9w+NrZbZgIjNnsbhafwr6X/BsZwelBBLjx8SquCpgTCI4iM09Cmb26pRRPXC1xpbqB7o1oGWOqJYOR2n74NCBFjo0ziZ1dT6wfedFtb7EopEj+SUgELiSRhalzIeNtobY=
Received: from DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c4b) by SJ0PR10MB4735.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 19:43:55 +0000
Received: from DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 ([fe80::5d2f:bb52:4f85:9461]) by DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 ([fe80::5d2f:bb52:4f85:9461%7]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 19:43:55 +0000
Message-ID: <ec221ec7-6abb-41b7-9237-8e799bbb5683@oracle.com>
Date: Mon, 19 Jan 2026 11:43:52 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Sharath Srinivasan <sharath.srinivasan@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sharath Srinivasan <sharath.srinivasan@oracle.com>
Subject: [PATCH rdma-next] RDMA/core: release devices_rwsem when calling
 device_del
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132F7.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::3c) To DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::c4b)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PPFC7DCDCAD9:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: fe151401-5acb-4316-812b-08de579314e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FpaUcvS0pYanFRWGUwU0pHcUE1MEh0clF6L3NZcUNabFB0eVZnQTZlSENj?=
 =?utf-8?B?WTNXd0xoek42dFdvRkIzeG1NRU5ZRUFBdG41N2xaS2ErdWYrMml5YjMyMVQ5?=
 =?utf-8?B?U2hpVTBPNkRWLzZrMnVEdWpNUFFCMCs3cXAxdVNueVV4NXRDdVFqYjJrbC8z?=
 =?utf-8?B?OXBibUNsMVNiWkgwbDZZRjZrYkp6QkZ1WkZvVVhwano2K040V0dBMjdjb2VH?=
 =?utf-8?B?dTBpWW14RlZrb0hJWmxlZzhZVUd2VHVLWW4vL0t6Wm5YVm0ya3VRZGdqOXB0?=
 =?utf-8?B?T0diQ3dwVHpJYmdGeklaZTJCQW4wb3YvRy8vMmgvOFVOeWxOVFYzaHdUbjc4?=
 =?utf-8?B?MGNQYnJiRmhVQWtPNVg4ekJTK2RnTzhUQmdxWWFZQm1PcmszWGduaEJFenhn?=
 =?utf-8?B?YThHdUlwRDZNRDBuNzhqOUJoL1ArT1dkd0U1UGJJSXgrckxnb2xYaVlOMUZM?=
 =?utf-8?B?QWo2NDJmTTdyVW4wRXBPZE5ScDR6NVN5dVVRZDRYMk1uVFlUc09CZXg3S1Rv?=
 =?utf-8?B?aHBSczRlVFcyWXNCNlBjaFMvRmpheU1GUGs5T1V0OExPN3VXb0FpK3VSWENr?=
 =?utf-8?B?aUovOUxiUUJqb1pUMGtNQzFhUkR2ZTJBeXFzcy9hV3JOODZIV1N0a1B5UE9G?=
 =?utf-8?B?djRieUpOWUZ0elJueURWQjlaK05lUzlOdklMTlZ5Tko0dDhVU3NNZmFBNHdz?=
 =?utf-8?B?OWVDbHVQcFNvWm1qUkVIMVFaTFIwbU1rcitlOWlhTTBYMG4wTG1mdXVCM1NY?=
 =?utf-8?B?STdWc1h5eEFha29TS213RlNyZmZzQ1VzK2t3UUY5TVpGMVdCa3oySU8rY2dq?=
 =?utf-8?B?QXY3UGkxV1I0RmNVbTFsY3VCNzA1Rk8rV0lIQ0luVUh4b3pOWFdJdHFyKzhq?=
 =?utf-8?B?YW1IMWZIbnNuYlhIaFljdHVpOWswc1dGajk1TzdYOTJ6b3NHV3FqeFVGUjFM?=
 =?utf-8?B?b3ZUZW02VkJhVGgyeFVmVG1sMnZqV2MwZUZIQjBLRkdrbTl4b0o4NWtUcUhZ?=
 =?utf-8?B?V01rYW1YTlA4dk5BZ3BVZDNOVGZmZS9BRGFkSkl3ZEFkWSt3UkpHMHQ0alhi?=
 =?utf-8?B?WEF4THhhRjRZYXZNWUxBcVkydkg3Q1VYMlpQS1dWNzZpMzBCckZLZmh5b1do?=
 =?utf-8?B?ZHVCRTFGc29PZElyOWVZWlNGdlMvNWRqSjB4V3RJbVQ1YmRDNURObUxNMTFG?=
 =?utf-8?B?cVhJOUNXWlAvSXlZYXpJK0NUN0dCVHArLzh6OUxjbjVTaHJ3N09TdWEzcDhI?=
 =?utf-8?B?ZnlxVHN5K2pjRmp6aTVWcEJMZVoyMEdyOU5FL00vQ1RlbnBSZW1jR1BLeTVM?=
 =?utf-8?B?K25YN0NWYnV4NFZnenpQRVNQSmJuNmROdjN6empsTi9wdG9KYWJSWmU2cWxH?=
 =?utf-8?B?K2wxa3FnUnMraDFoOERITUl1WDZLWU1MVEp6NmJBZ1ZTOFYzdDN0VW94REpB?=
 =?utf-8?B?R2M0MERiMWZOaUI3NnBxVTRwZjY1OW5kTnpsbVd4UnREK0k0YmE5bWlqd0pm?=
 =?utf-8?B?WUtFVTZHY1VXaGsvRFpicldiNkpNNzhPdkNWRGluRVNwamdlSnowTFBmdlFo?=
 =?utf-8?B?TmpnM2pyaHBML1FMNmNmVWVCc1p4ZktpVU1ldnZseHNsaGg5cktMekFON3NU?=
 =?utf-8?B?SVA1cWcrTTNobkxuVWtsWmJMTWhMaTZIeG5COXVabmZNZXpqZ1FidFpGQ0Zu?=
 =?utf-8?B?dit5aTdWR3lRUG90Tm8xSVlmVHBxTGxSYXFHRUdPazA3WmdvVXNOM1BwL2Jt?=
 =?utf-8?B?VjNRQkJDM3IweWJhNHNPWFUrbXhSM2VsNURMRVg5TTFFTFZScitkbGZuN0d3?=
 =?utf-8?B?WlpSbklHRHJHQU52ZERlb1dyYU9VT3k1eXpVR2dkOTJVMmJqdHZHelpKWmds?=
 =?utf-8?B?YzlVbDJ6aUtua25HZHVZWnFwV1poUGpMNWl4V2MwWFUrMm5CZ2hDR2FFcDRU?=
 =?utf-8?B?V09ISm84bDhsY1hOalN6ekt6UmM3Vzl6YjVKU1NVRDdZMzdZOFpvOWluKzRE?=
 =?utf-8?B?cGt4dmx6QU9vWWRITjhYcTUxd245ajRQajFvcW5rR3ByOG40RDVDUXF5c0NB?=
 =?utf-8?B?UFdVUDlKZVFsakRJSmVkUG9rU2I5M3R6WGNJaXdTUGxEeHdkSlRpcFNCTEZS?=
 =?utf-8?Q?S9mQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PPFC7DCDCAD9.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3hjcnlSN0szMnVmZHUwWktWTUluY1RxY0l1VDJ4amRiTFRZWjBtdjNJd0sz?=
 =?utf-8?B?c2lWZHp0eE90b0tqaVBpbURhSVkyWXJ1b21ySTZKcExmWFcyRG4wWWJRVVRH?=
 =?utf-8?B?ZTV2SkIraVNENklob3ZpdkN6bG1ZUHJsTFVUL1J2cEhBTjNQODI5WkVBcnNS?=
 =?utf-8?B?ak5pNk1OWi80SGhab1BCbDZwVTQrWVI0bHZ4WEgycldLTWZkMkMxSUxMWW55?=
 =?utf-8?B?eERja2RoUVZRWjM0T1o1SEJ6c3N3ZFZaV0E5bzZESE1VK1hkM2Vkcm5OS1JJ?=
 =?utf-8?B?YXkzMURmQVNpV3RMMjRacnZ3UWQ1ak5VS1hCVlJ3Z0RiT1RGYXYrMSs2Qk8x?=
 =?utf-8?B?UjgxWExOWlNnT2txeU12Y3E0VUJKUlNTdUY0MVZtQUluQUE3VHByVGdzZDhE?=
 =?utf-8?B?WWNzbTZDYWJQN0MraVY4TTUxNEhzcVlTNGcvQnlCZ2dJblgyOEhGU3Y5bklq?=
 =?utf-8?B?SExINlROQXpXOFdMWlJRQmo3VERuQnhZQXJSOHE1aXFvcndaVDVVNzhPZ3FM?=
 =?utf-8?B?ZWd3em9XUUZLY1VPNEpzM1FIVHRMUGlqdVVWMkxxL0FuckFWSC90TndEdDlv?=
 =?utf-8?B?TE9RTVcyR3ZjZ2YzUkVvQ0VoZ3dkR0VkR0NQcHJDcm9tUmJOamprWkRjTmVF?=
 =?utf-8?B?alpNLy9oWGFGU0w4cHJLWlkxRHdiaVAwUkFFMldVT2IrS3BXK3lYRG1PWTBT?=
 =?utf-8?B?OXlpdkx5cWZudXpUWGFTc3FlL1VRR3FraUtPM01rVThLbXBxcVdTWGJ5bnVa?=
 =?utf-8?B?ZlZDazhuOGxBOWVIMklHc3BQQW9MbTYrbjAxM3lOdTNJZU1JSHRRbCsyQjMz?=
 =?utf-8?B?NHhUOFFKOTYzejdibDRZZ2plUHYrK3dKWU02NVhnQzVPaWZ4UnpMZzFjOVpX?=
 =?utf-8?B?dEFFSTFjRU5iVDdnWm50SUt5YmRLNHFlaTk4T3c2ekpyY2R6VlVFSlVNZFIw?=
 =?utf-8?B?UDBCemhNa1JWblYwRDdHV1phWm5qdWhJVi9YN3R2STNWZ1RJWXBnZVp4R00z?=
 =?utf-8?B?MGtlRWhUVlBkT2Q3QlVGbTk4ZDA5RWdFMVF6RVdRNktjdyt4SzI2b1k1alky?=
 =?utf-8?B?emQydFN1VS8yb2RaZEtFc0pVZjE1RG4zUEJwTkRxZ1cyamhEcVlNeE1LWmcv?=
 =?utf-8?B?Zldtc3lKRlA4Q3B3MndwOWFudnR2SkhmU2xTMFZEaFJCbUp6R3VraEk4ZDlX?=
 =?utf-8?B?NGhLMlhTNTUzSGRaRXdLTjgrU3BxK1FQazVDMlg1NTJuQ285a1d3OUJHaFpk?=
 =?utf-8?B?bndKVEJwVFVkb0FPZ3dXR1ZBV29JMjJPcDlYbnpZSkRYOUd2YkYzK1RNSkFE?=
 =?utf-8?B?K1dxVkR5ZVpuUTY4Y0RMWlV0K0duN25wU0lrVzF1V3JsYVg1Y3lYdW91dmdi?=
 =?utf-8?B?Q2RwU2EyZDdmUEYrbENBTTNtSjlJeUlmTmhaQ0wrM0JKaGxmaWNSUTFUdmF4?=
 =?utf-8?B?anJNOE9tbDN6OEVYT1A3TktjK0w5YVRYQmZBd3FYWEZJZUF0SlZpdWtlbElG?=
 =?utf-8?B?RVBmYkRUd0EyVS91NVBLQjljYncwZFo3ZUxCaDkva05IcUxJZEVMNG9Kb0xq?=
 =?utf-8?B?Q3FWYThEcDg0MS9hSkd5cmJiR1pCT09WYnFoa3RaOTB3cmg5QXhmb1paK1hh?=
 =?utf-8?B?NW1YODJVUnpZNVYwS2NKNzFMbURvVDdQbXVjenJTOHp4ZHpMb3N4RzFFaDRV?=
 =?utf-8?B?QUdBTXNpdDU2d0UyMVQ4MGJucCtPaHVyME5heU56YTBMMEFVeTFwNDRVMmdr?=
 =?utf-8?B?aEp3ZGhWZGZNaDB0WjBqMm9NdURYczhPTE9PVzMrbXVZVVBEeVB6cTY2V3Bk?=
 =?utf-8?B?enhSK1dxeHB4TUZlYmZzeFJ3RURrL25pbHpseUlKUXJyZEpjek9uZEV5cDR1?=
 =?utf-8?B?Y3RtUDBoWlVUa1ZkaDQ2cXhZT0dvdHc2dUd3cjg1dEJKUTByTThCcStHN25r?=
 =?utf-8?B?RnYydWg5WnRycUdMcUNBcW9ZdkVGUm03MTl2aVNFUndNTlI5RS9rSlpQUG1U?=
 =?utf-8?B?T3A5aEY2eVIvTFRWL2gwNlQ3VDBSSHQ2UTFIWUF1UElwemVzWXNHamN3MEZX?=
 =?utf-8?B?QnFNMHo4QlAvdk9rNFp3R21aM1JnZHBKUHVVY3RteENhR2gxN1gvS25sbTRO?=
 =?utf-8?B?U1Era0gvdDU2bDJXZlFkZzkxdlk4SkdQSHlLODM5VjJiL0xFMXBuc2pVc0Zi?=
 =?utf-8?B?YUV2RWV0R2RJYWJiamhucHVwNk81WUprSWc0M2NOS2hVWjU3VCttbG9UZFdB?=
 =?utf-8?B?cG52YU9hb2V1N2o3N1ZpUHNjSmkyS2NUcmN5RndKYmJTSUNHb1dnSDlFQXRn?=
 =?utf-8?B?dW1KSHFBdGg0MUtvRjVISm84RjdnVml4blhMcjJUdnRzaXkwNENDWGxFVTNu?=
 =?utf-8?Q?OU7Rea7kMcFtJnnw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QFTxWgzCFHy7w6F92HPoH3mS6LumCUn5AeCw8YURCmBKavuQ9Ih9FSseenmcxCNY5CxjWuMj2jvIIH7++IOFLop5bHUXiO6eKe7YqgXLIrbW2EQUc/k8BhvzxZvvYHhiLRenYs56A3HPBmPcr1rmxc/MVWtfsgXiXAtA819CFHELohJJzk8j0XCHfhxBVabyiyG6gKMNk4tHkADfWyX6OK0fyetvOy4f0pDzbBoQ1hok+wFmvyL5wtHAUqCLObfq/sMTHysQScjkw8zYRgfcpbzgsshwazsVWOf3z2iIHY/h1O1PfQLNKdKBuNzZXRvnMAa8E+Wm2tGe9JpfJ5bm1ia6N+4sTQXnLb8pjVR3+OjUAD3xnexG/WQkxz3X6KW/7ij9TgBD7Vec7b3tZTmgn+nm910iboTglmrZ5gG64f5z8Lp1SvZ/BERgOzv3KlFpJLMZf25v+pvB/u0csB6PVeIOFaoeUOYMOFTuApyHS4JpjTEjEQNgbSUN9/YedwsZZwDZS/COWI44GTthCw7cz6yU2Na3R2Y2qMQvNFfGTjn53yejN6g/5eLESiFpC6LND+59wuUBVc2JfSj7wu/H78ZZDTwlU6uHe7ECXe7EFK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe151401-5acb-4316-812b-08de579314e8
X-MS-Exchange-CrossTenant-AuthSource: DM3PPFC7DCDCAD9.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 19:43:55.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgVhDsm0mLAsU18gYEsFmpoqLo6a9VT+YRpK7Ly/mtywXg1EdTYVHA4kwi2r/1U48vag1ut03DNhcbL5UI8mUVmfyZhfVb2D+N6TyXdrR8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_05,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601190165
X-Proofpoint-GUID: abwDJrrqFzeinJRiIqA2jUoDcyNFMtlh
X-Proofpoint-ORIG-GUID: abwDJrrqFzeinJRiIqA2jUoDcyNFMtlh
X-Authority-Analysis: v=2.4 cv=QdJrf8bv c=1 sm=1 tr=0 ts=696e8983 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=vqeHtFuH3X1APyjPvOwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE2NCBTYWx0ZWRfXyI/WpT4QI0UV
 Y4YZOfmB6bd4eygci610ROo0tBBr9+xZdaCcF6OSdLKYny1IKlWtEnBJUeeu6jOYh4LZ/buLj5Y
 IiJnNKWkTLOsrljRGCAOhSdgtLBzGGqxlNTkwfGxpEivxxoZAOjATbeLmthBjUmj66D2umbplpC
 PKKa4N1HnMXxTXWjzBuYJ6EFIvo0lRkkotFHjpC99lHajRhECOmPNav8TyUSPX1h4+3wjhsvZ5R
 4ynh9gQuq+8KSdMXNI3YBskWih+tHQkbZIIILQJDepbRL9US/CjmUB3oFaVVb3jqwsVKHPW4wo0
 /JaGngpAX/qubaX4cp4eQI135c+MVqbONVs1koUyK5TEAxHNQlEI7f1ZZfVvjAkXrgnsP2zrxhT
 w4XvwrYthAjyJkZgdHujCf0Y1BOxF89Si+Xpp/14p2xA2PKYDnOgpabtdBHSwpbHXai6OyVc09H
 ogbwWdlIREfqkHYCFPg==

The sync strategy in remove_all_compat_devs() can improved
by adopting that of rdma_dev_exit_net() which releases devices_rwsem
before calling remove_one_compat_dev()/device_del().

Also fixes a comment typo in rdma_dev_exit_net().

Fixes: 2b34c5580226 ("RDMA/core: Add command to set ib_core device net namspace sharing mode")
Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
---
 drivers/infiniband/core/device.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 1174ab7da629..81689924fab8 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1078,6 +1078,13 @@ static void remove_all_compat_devs(void)
        xa_for_each (&devices, index, dev) {
                unsigned long c_index = 0;

+               get_device(&dev->dev);
+               /*
+                * Release the devices_rwsem so that potentially blocking
+                * device_del doesn't hold the devices_rwsem for too long.
+                */
+               up_read(&devices_rwsem);
+
                /* Hold nets_rwsem so that any other thread modifying this
                 * system param can sync with this thread.
                 */
@@ -1085,6 +1092,9 @@ static void remove_all_compat_devs(void)
                xa_for_each (&dev->compat_devs, c_index, cdev)
                        remove_one_compat_dev(dev, c_index);
                up_read(&rdma_nets_rwsem);
+
+               put_device(&dev->dev);
+               down_read(&devices_rwsem);
        }
        up_read(&devices_rwsem);
 }
@@ -1168,8 +1178,8 @@ static void rdma_dev_exit_net(struct net *net)
        xa_for_each (&devices, index, dev) {
                get_device(&dev->dev);
                /*
-                * Release the devices_rwsem so that pontentially blocking
-                * device_del, doesn't hold the devices_rwsem for too long.
+                * Release the devices_rwsem so that potentially blocking
+                * device_del doesn't hold the devices_rwsem for too long.
                 */
                up_read(&devices_rwsem);

--
2.39.5 (Apple Git-154)


