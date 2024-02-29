Return-Path: <linux-rdma+bounces-1165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE7386D440
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 21:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33FF1F23F79
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Feb 2024 20:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112381428EA;
	Thu, 29 Feb 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XyxDmteF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425138DF2
	for <linux-rdma@vger.kernel.org>; Thu, 29 Feb 2024 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238654; cv=fail; b=B/UjUoEyk4p+7J/GMqWWNQC5QjIAOby8Fp2ZrX4fefgieHjuScE7zdc6OOZDhNf9/JYJu/jrhGYCT+68zFPIkJ97TGDPP5/AQpbtOhB9Lh6tZ2MwEEopZLY/ZnaYRxww25EHdrrnHZlI7moLNNtkmM+tEuMZGIWu73LoCeWTSX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238654; c=relaxed/simple;
	bh=e9ZVkS6hY/C763vZh0HlCbxtWt+8YhhfLEk4PobB+o0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=as3NecJi4jJxtvU2QKwLFrC6wQRP0vgykYHN9ySGAhT9N3Lf8Ffi16Qc8EuxoFV5OuEQXShE3gNMJM3jTIpPia+5zWyb1iVtbXQ8HOhIOY6uCLkIaM+L0dqL8/cSZjPSHf6sgmRUPluJEevMiQ9SqfDe+ZlkqUB6GzkzavMwU24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XyxDmteF; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T3WD60017010;
	Thu, 29 Feb 2024 20:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:to:cc:from:subject:content-type
	:content-transfer-encoding:mime-version; s=PPS06212021; bh=4tPYt
	mz4jnEAZTAFLYD8GyRfn4gDueXQNdcUwINsjWc=; b=XyxDmteF75Zchg36JWC2r
	yVsvoSkCqEVD+7hVfXiVrjZHxK8ru5AWa9sURUXtzJCkl8qtlNaWmRGetdLHPN7p
	I5Oy0TWhwrpzCFQJ/w37YJCLSczcKDPFvCn0GUs4+OA6bgqVDA5OC7Nr5smfg87C
	/R5LHpFP+W6AlI06OE6RpkWoVl1ych4l8Oo4p8wYo+vUJuX0PaoJIroPQjfd2L7V
	cNPwG8apdw7qnkFHe9g7MCRoY8lJpJllPauFhvfsJkxdUpnraaDdUv/i2FX2VnUQ
	Ly0mZbgNnKYpMFyvfipsr3hbGMQPhCd/RCjXv+NPn5ByHZ4z6QoBP95OpPPCciw4
	Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf5nx5y4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 20:30:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flsDv/lsjD++dzXSsDBmy6icVOTMmOiphzaTp4yIzD2xRc+D56oX7ciwbSvSErxY/X3MH96ynBvN0k94XO1k/JyrYougXUWrBcDtbSqsCiPHCl7aFm7I7zzdS1iGiY9QczrGhMYIkEglAb4PTJalTtbnKWAhMGXL4JN59+lg5GHgoNxiYdqBBbb+rmBkxIhZsvMKlTtbxScKCDYo20rq87pwzp3TXcR5vweo2Dotui5kz1qx0GooE7/aH3dsgTAhui4gOn9bop2Q0zWIQvHbIfW/QK7Y7lsJxtcJtoeSiVW4yDxJoMXeRxZqzcvtFFlvytKtsOKLwGqpwqhwlvrqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tPYtmz4jnEAZTAFLYD8GyRfn4gDueXQNdcUwINsjWc=;
 b=bSJe+nt98jS3d2YRyc6K452UOkex/gfHh63ZByVUhpb+Lw48JpPFkXDXtEEQ/yV+7QA5b1jl+t9xTD8ivhFB8rjpZh10s8eqaDV97+1ootqQ1bf0rzYRzV3bGi55LragUF7V26q9qMsllxh1V/xgY2vD6oo4D2Vrty72zbVPCPHWLy8vAWql6ryLTQY9biyI2ZGP5ul/ucWo4whebwinfSAfHfgymRruqhlvWJ8JsMhJi6iE+FqRRb6PEMUWhdUozgDr0QidgfbmVqp7G8n+4eI9tk/m57kS1OXP18MRLVfEG6TjBik3xr83i8K02mDiQQWzzyv3gzB5uPtePaZ4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11)
 by DS7PR11MB7805.namprd11.prod.outlook.com (2603:10b6:8:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 20:30:45 +0000
Received: from BL3PR11MB6433.namprd11.prod.outlook.com
 ([fe80::5c26:5f21:6237:2819]) by BL3PR11MB6433.namprd11.prod.outlook.com
 ([fe80::5c26:5f21:6237:2819%3]) with mapi id 15.20.7339.022; Thu, 29 Feb 2024
 20:30:45 +0000
Message-ID: <febe07de-d57b-4369-b388-caa461c94b6b@windriver.com>
Date: Thu, 29 Feb 2024 14:30:41 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rdma@vger.kernel.org, selvin.xavier@broadcom.com
Cc: "Asselstine, Mark" <Mark.Asselstine@windriver.com>,
        "Ma, Jiping" <Jiping.Ma2@windriver.com>
From: Chris Friesen <chris.friesen@windriver.com>
Subject: question about in-tree vs out-of-tree Broadcom ROCE drivers.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To BL3PR11MB6433.namprd11.prod.outlook.com
 (2603:10b6:208:3b9::11)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6433:EE_|DS7PR11MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2927c6-130e-43f9-b384-08dc39654e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	arTdKtrpHs3gTaSHjm+rMzMmxwey/PIk0p7zc+78JkCGAROwJ+kHRmr/8TdO7cdIvHYRslLF8BTnQ5iGWZVKKGrFj/87YRyZMkY6HsqgZdE10SAF7ZZ+rMZ/CKUOIetufPdx63ecm2fDG5+mcluMP2cDNHlLLDUU0w6wkuoy4bRik/Fd22iBHoBK5Bnh9qh++Fk0rofVKSy+5t6tYEIL+dPOhbsGyDbl6Y4rpwMLwGP2kY7aSpqAWKsEMAhYxeiTACaAEVBeRIOOJ68svoMp3fkHxwIo5Lfec9W1LRcR3Yz7m7PutdjuCh/4b6a/3PEg51D4GeTE8GfmjoARtjFyiMVmPjw6WwuQvEKQLuBS6NleY3AIWoVA/ung1IGS/OCXt1HYr4cb5+T3c2NUmF1O/cSjaNzLu04E15BGNCd721Ig+xooShtNuXYt8mByElPXDysKqBGTeYkTW1HI2KmGERF1/ME/995VBtT+OY0PsRhOPSV6d2yfa2FBIrtO+syQuXd82okCr0qrSIoDVUI1wuwdqrVarnO6SF5ekucXyFzNJJU6+urUmXQE3YzCilyfdaoCNNM4t6+EAdQtWoaofA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6433.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDZ0SmJXVTJFSVdkdEY1UzlrVEJlYytkVktLL3RGelhmRE9ja1RTcnRZaVg2?=
 =?utf-8?B?S1ovTmNjaDZaU1RVM0JZc1dIUXZHSFEydUgxbVp2eHpuOG9XSVZHazB1NHhz?=
 =?utf-8?B?YnB6Yk1VUVd4b2hHY1hLV2dSQlB4NDhsMlZIZUs3NGVLWEk2YXVJdmFnRDFG?=
 =?utf-8?B?NmVGbU53VUNoUnJlQWY3clBJQmxnQ1B1dkl2N1RnSC9YZERHa1dTU3ljUHFo?=
 =?utf-8?B?UlR5eEp1SUZSdVBRdEM0dU9ud1RpU01ueE5HMGxnZUw2eFFRMG45ZitXY0J1?=
 =?utf-8?B?dDhkb05Fa1hOSHdQQS9KOE00WVFNdW1vQ2poc0JhUEpQWll2djdMZ0FhNEx4?=
 =?utf-8?B?Ny9oTHhHd0dXWTd1eTN1RlBGZE9FOGNlcUJhMkV4aU85NXE3czFhL2pRQi9B?=
 =?utf-8?B?Y2d3VzlOOXdEakVQcGw0eHdXT3AyYmhWd3lKWW4wcjZXNTl6WkhzWlZST25n?=
 =?utf-8?B?U2NSem9BNkJxQ3lpcXl2ZlJKNU1MbjgxRDdja29zVU16ZXdTQjRhN044dWh2?=
 =?utf-8?B?alBLcmRTUlJBZTlnSFlqeFlZRUNhN3JrV21xZEtVbThPQW9OUTdMdEkxTkZy?=
 =?utf-8?B?eUZ5aFJGd2d2WTM4aUNtenRmSTJLM05IT05RalBzbDVXaWpWY2FlTWJ6enFZ?=
 =?utf-8?B?YytQR0x1VEQ3WWxBOVozZjkvdXNHZmFFL09WZXl5ZXBFVHlTWXAzQWMyNEpJ?=
 =?utf-8?B?Z1Z1S0crZnBtcm02NmpLeGlJVzJTeDYvWDNxRnlkUHovU0NNMTNpMFQ3RXF6?=
 =?utf-8?B?OFEyQ3R3ZHFHdEw2enpzWnAvVm55cnRlMlZkWEQzZHNGOXg4ZVdTOUNVZHp2?=
 =?utf-8?B?a2NNNzhrRlduM2lIYmNYamROSTVVS3NwVUNxZ2x0Y25nUmJTbS9vaGsydHBs?=
 =?utf-8?B?dHBsY3VwTk5sZVJWNm4yQWtmUUdsQ3VCM0NObzh6L0pIc2xxWk5wK2EzUll4?=
 =?utf-8?B?Y3JwQXZ6S0dnOHYxNnFTdVdZc0x3SldzOGM1azhxSHJ1K29RN2hIT3R3eWhV?=
 =?utf-8?B?ZkF3WGZIRXNPSWxremNpeFJzUzRBcHFRRzBEdE16Zm1tMVVCUnU2QzlaODRy?=
 =?utf-8?B?Nm1UZzJ1WXppMlorbzM1MEJUekQ0N0lUMHZVMjFndHptUEZIaG4zeGxmYkpl?=
 =?utf-8?B?dTg0NTVJMDBjbVBnNVY4R2h2NCtUanB3R1BCcncrVnRMQ1VTVjNhblg5akxH?=
 =?utf-8?B?QUJjNDdYNHVGWUF2RlBGREZka1JBaGZBVDI5MTlPeW5nSXZhVzJFQXE1TnpS?=
 =?utf-8?B?SjRubW9zZEdtaS9IQzNZKzhMQ3lKcnZYbW9yWnBLcVRBLzVrWkFaU3BDZzlH?=
 =?utf-8?B?cVJ6ZEw0SEdUZUNSMG9RcWppTENUcmZjNENyRGVlbCttN3E1dUtGdFI3ZWxS?=
 =?utf-8?B?eVRuak1pakNsZzV0aHlWaEZqL0NJVCtST2JLbVJTU3FHd3FKdEkxNnBudHc1?=
 =?utf-8?B?Z3p3Q0RvbVdzL0p4SzZaeWg3WTNUaC9EQ3JmRlJMdDQ4Q1ZWNnptSk5VUnpQ?=
 =?utf-8?B?eEQrMHdWRnRhMjNFVURNTUR6Y0VLQlJkb0JyN2Fyc1Y3bG1CRnNJNlQ1WVl3?=
 =?utf-8?B?bFhjaVRIVzZISGxGUnIwZDFERXh0U0Rab1QrdE1SdTlJL3h2TlUxRnlIMkdv?=
 =?utf-8?B?dzloYU5QQ1N3b1ZmMzJPUlpVUmZEdlZ3elh6T3laWmNGaXFJZWdDRG45dnRE?=
 =?utf-8?B?Zmg3L2w0MlZOSmVjSmRQcnhhMUdhZk1yRFRpNGQ1SGdYY2d5SGZ6UTJydmwy?=
 =?utf-8?B?K0VpN0o4TmRBV3p0MmRIRzhQeGJwdDUzeXIyT1RHNkE0TDN1RmZRSTZDSnRZ?=
 =?utf-8?B?NWtwRG5qNSt1NklVTU9XaWozS0oxNVgyR2xWcDFkbXRwcm1iN0dSc3h4aFpp?=
 =?utf-8?B?VmRaVVFYdVNwUGJJQ1Q5dTU2TTYycy92ampWZnhJUlpyS0xLOE1Ec1RuZVN2?=
 =?utf-8?B?TGxqMUJxSE83c3ZTM1Q4Q3pWOStSRTNFenFvZzdPV1JaVnU3WVNGdVdXUHRh?=
 =?utf-8?B?c1R4NDFYK29DYWgxT0duZFdNdkw3SXA3S0s4ck0raFN6dFloQy9NVXVNUkMv?=
 =?utf-8?B?TlRLNTBWTzFqeDJCT25Zc05JN2dVdlU1bHV4WHIwVXdldnorQ2M0VnpWekdW?=
 =?utf-8?B?dGpZY0ZkNGFzWHlIekl4WnZYcy90bVJOVEs2TUc4Rmt4Uks5VHBGVVdYazM3?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2927c6-130e-43f9-b384-08dc39654e61
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 20:30:45.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owFryMR3/gGb30NQoiekFddsGkJ5GPVK0r9FrY0ryY5t/akk2oG7Dyx1vFAEg/RDd0YIBhY/+zSeiOSEUlPzusA0rrIiV8OMuP79A+w8Epc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7805
X-Proofpoint-GUID: 7MYKCQN2QIJzHS_C2ofv-7UIyHglW_rE
X-Proofpoint-ORIG-GUID: 7MYKCQN2QIJzHS_C2ofv-7UIyHglW_rE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=918
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1031 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402290157

Hi,

I got your address from the Linux kernel MAINTAINERS file, I was 
wondering if you could clear something up?

As far as I can tell, the in-tree driver at 
drivers/infiniband/hw/bnxt_re uses a BNXT_RE_ABI_VERSION value of 1, as 
defined in include/uapi/rdma/bnxt_re-abi.h.

On the other hand, the libbnxt_re-228.0.133.0 package and the 
bnxt_re-228.0.133.0 driver embedded within 
https://docs.broadcom.com/docs/NXE_Linux_Installer-228.1.111.0 are using 
a BNXT_RE_ABI_VERSION of 6.

This seems to indicate that the in-tree kernel driver cannot be used 
with the official version of libbnxt_re as distributed by Broadcom.   Is 
this correct?   If so, is there a separate version of libbnxt_re 
intended to be used with the in-kernel driver?

Thanks,

Chris Friesen


