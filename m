Return-Path: <linux-rdma+bounces-13207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2DB4FEE7
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C2D189CE67
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D07134A31C;
	Tue,  9 Sep 2025 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eTGiGpO4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YBPOFXud"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F92773DF;
	Tue,  9 Sep 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426883; cv=fail; b=EdMXk0erAzUfszVevbZdytZAqWpU+DBcT13xtPYMXIxy99MNGvSoA4/dEZdwB8Z1NOX7gpml67OGodBMZiUb8x/90AjWVMWB8Eccp3Ywh6bHIkjsiEEcZLQEJ/5dAwSKfER4a+S9olwPxS5LXPUCNuqN5qzc88fY7bbaTXA/iDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426883; c=relaxed/simple;
	bh=kBitjyzdWnH6YW/S9B+Jf3a0glpN/G8GVOAcjgMQfsk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldYFiBmnzXsgk6RcVv+agF2QQWXiKURQ8QrC/xMbcyaDuK6XaP4yqyMm7wC1XyKaz4Fou5HlOJR7qBCLxIpzg4oEcOjCV4v7SUrPruK5n1vdtZGb9yg5KVwHrAwubjJPfZvYKLQFVXXLzI9DCmgwPpeAo/kxTqpbmrcyv3PBhYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eTGiGpO4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YBPOFXud; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPUDx024099;
	Tue, 9 Sep 2025 14:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RchAYW4VXegC6yhtNEsvpkgyND7dpJXxMCUqNcyzrFE=; b=
	eTGiGpO4lXukLiLk/opF2l1ycxtFipu3XgXNhuPrxZwsoSKsaY9x2Fzut8gzEmXM
	CtJvZxbEzbk8Rs4gH9+Vggszv7vWE9xFSMj7cZ7nlFpjX6g9ss/52Hyd+kqs2aQB
	M+ED+Z2Mv+2QYw5Brp0OwqSK2ZiTxMj6g37J4y2ziB688h253I8egV0Di0Hlut2M
	HcQUFrTGTPGw0y9afnKArpwNjfiwR7Hcs0gn3kBKEaMjri6CLCa10dKkqbXPyP/I
	EI54PWIgut9jFuYhbqSOpzKgIJQ+tsgfL2CbZQbxqFmXsPELr6OgpJMAqH3HdOwz
	HHfqNBrNfhkK4fiu6pd4NA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgsydp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:07:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589CtEeI026041;
	Tue, 9 Sep 2025 14:07:46 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9p616-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 14:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/xP4NhWXq1Jmu6WXm6ydkKbz8+hhVj1Oa5scqNW7uwp1nLSFGK4znE0P5xxnFp5EQIuuuaZiuGN/M3V2WYO2xt21ZviQyd5QkZDP2Gg2nHTO+3/0q74Ressqqm7HU4jfNn8sXNS6ezjQ7szg2gM2akC9/JEuJiQTBT9PsW7DBeExhtYIKX/qqleR8SP6Ad3LLQlJpEuFKX6w2hZwMSreQCOB0clOr7vFWf1tJhNNNFiTpljHBODtvNor+XDt8cd3lTw9Ymj1Nacq3OG+HZ70OJQKJNO9tOVBnqGJpwY19lL77QOHZMX7pS7ayfNwgWo8GUVwJ+xYsXHHt7RCQQYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RchAYW4VXegC6yhtNEsvpkgyND7dpJXxMCUqNcyzrFE=;
 b=ML/MFryIKguMpb8vY80DB+/t9FxcuxuwRQ88dyOFzuprqvmcj5iMWRQ+WJw7jl8IGFulOKx6AVffp6EViVGq3f6ywf586BBbQsbPbT4vS1TQobi+m0pYUv96Y7bFbFLAnLg5lCX9fp9QhUuPSZAlFtQR6Qw+ZLNntszP8k1W33KQR2JENl6r4U6ulkyiTRQH6eJEwl2QnbFhwayYZvk5AUkpya8sFQOgA2zyDJr4pIXXL9UQP/sKrIemA+id1n6wNif/sx/BjgV8k6RyJ6kRpdAmIdP5n3LnfVqm7P0h1NyPLl8h3f1uFhzxV7Mi7F+0VVy4WhwMhIH/AZWiW6L8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RchAYW4VXegC6yhtNEsvpkgyND7dpJXxMCUqNcyzrFE=;
 b=YBPOFXudGIYYmmmnv+xCEw/JGcB0jWMtYRLvYMkpO7L9ZgxO1nH3L4TNQIU0ql5RPTn9vuziSGbKHcisZUnHt5HNgpOinwLqxwDseX6pFXBOxYqdsKsCd3Px0Rv7Q1rY5lDZStM+upBpGEIVSGGOR1lBmO50TMGRSttoK90L6a8=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6543.namprd10.prod.outlook.com (2603:10b6:806:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 9 Sep
 2025 14:07:42 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.032; Tue, 9 Sep 2025
 14:07:42 +0000
Message-ID: <98538e34-c329-4785-8380-7932a284a515@oracle.com>
Date: Tue, 9 Sep 2025 19:37:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v6 10/14] RDMA/ionic: Register device ops for
 control path
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, brett.creeley@amd.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jgg@ziepe.ca, leon@kernel.org,
        andrew+netdev@lunn.ch
Cc: sln@onemain.com, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Boyer <andrew.boyer@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
 <20250903061606.4139957-11-abhijit.gangurde@amd.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250903061606.4139957-11-abhijit.gangurde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f781a21-8066-4bcb-af34-08ddefaa3ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1BOQk4vRmRCVm1RVkNmVGNmb1AzTnlkSjEvSVkrUUJYbWpaanJET3BEQklL?=
 =?utf-8?B?Z0o5UzBVd3BqZjFGYmJGWm81QkpqeWlRanpUWVFMWHFGeVhybE96N1hQZkFB?=
 =?utf-8?B?ckpsNjhVb2VxQVF4Q3hjOW13RVFrWFNWMnFaRENPZTI1V3lEYm9nTWxpcjh4?=
 =?utf-8?B?SGFHeU93eWtQMWlBeXJUSFFwc1ZSU0xPWm1COUUxckswNWJ2Y0Q3VitLWE5o?=
 =?utf-8?B?Z3BGbUVlUVAwSGs0SUUzenlvWmg5SXJhMGRqYUx6YVhkbUtGa01FK3BzUXdQ?=
 =?utf-8?B?aWRIWk9SZ0IwM002VFdIZGhGL2tvbHhGUVEwOXJ6WlprQjBJUmhkZEluRmdv?=
 =?utf-8?B?ZDQ2cmkva2ZNMlRKeGRoYzUvc21kWk55RDYrWUIzd3RNS2xWTmVWaEhCc2Rl?=
 =?utf-8?B?MUFIQnliS043ekI2d2dnMzlEZ2R2d1JqT0tMdzloNHNHZXY1aiswWDJlNVNq?=
 =?utf-8?B?eU1rL1FXZ2ZTUTd4ano1WWlhbVE2YnhlckJCVWJKdlFadEJ0Sm1CblJwN1dq?=
 =?utf-8?B?d2dTQ2p0Tyt4YUhXTnpwWlI5YXdUVkxQNllIUVB3YzhlSDhRM2l4dE9raFlW?=
 =?utf-8?B?RC9MSk5uUm8xejR6Z1dlbGNXQzNNUThNUW92YWozN2ZYZWNaL1A0MThzWlIr?=
 =?utf-8?B?aDlDcTlHbTBqMHNnOGVTaG1XZzNvY2g1OUFvMU5VaU0vVVYvL2RqU3EzeWJK?=
 =?utf-8?B?QjdYNTBWS1ZDQlhYVlUrNFpJQVJGQVJQb1FRcTdPbWh4TkFIV3JBZGpYZDcx?=
 =?utf-8?B?WktXbTgxM2w0K3RNQWdMcERrOGVGTzArc2RPYUlBMnAvRGhacVhvckhXRklB?=
 =?utf-8?B?ZUMxM3RDYmh3SGxCYi9uV3Vva1UraVhReDk1eXNya0Q4eUFIaU9talgzWE9n?=
 =?utf-8?B?dkI0alpIMWFNdVBmckJUY0ZvZXU2dS82RHMvOFlvejVTTDllL3I2VXBSdUpC?=
 =?utf-8?B?MGtYOEV4YUFBTDVrQVpJNGNFOURxUWsrNXBURFJqY3V2NHBqK0lxZ01GRkRO?=
 =?utf-8?B?ZVQxcS8zN0EyUi90VzdMcUVDRE9DZVBETlg0OFd5akx6am9Zcld3R0U3Rk85?=
 =?utf-8?B?VkNrZFdCVFRQcFFqa1BqMnM0T1B4S2JaVjR4a0haTzVqQlk4VnRrR0NoUkdF?=
 =?utf-8?B?aUFSWWd3UHRKSDhEK2d1LzB4U1BqdWVrSm05Y2Vxc0I4YW41bDJ5dFRKY0w0?=
 =?utf-8?B?TGdVeEFYeXhDRVVDRUNTaE1pdFdkV1NMa0FTWU5HSHRDTU1lYTJPazB3YXRD?=
 =?utf-8?B?TFlOdXFOdUo2MUhUdmpxVWlLSjFqQXNteXFWdzFmWm9RcndTaU9TUlEzVzhB?=
 =?utf-8?B?NGVuMDhHcWE1ejBtTFZjOUdldkdFQzF1dERMMFkzUHdNWFdzNlJ0VXJybGQ4?=
 =?utf-8?B?akNOTTRkNUkvSldYSWNTUG5QMGdWOWl2LzFEcTZQcUpDNnZxUk90NjM4S05h?=
 =?utf-8?B?R015Sit2bkFNNVowQjI3L2N1ZzVZR091VXZpemh4eDNmM2Vpak5YeCt2QUt5?=
 =?utf-8?B?YWhIVlMwdFg4WklOakNPZ0I0cmVkMkFyNk44RkZnMDdHcGwzRjIwWUlTdnNq?=
 =?utf-8?B?bUFNZEIvUzdBazQ0ckxoMkZxNTlCMFYyR0FENkFtR2tlYXlld1Bidi92NWdn?=
 =?utf-8?B?dnBqc1dyRG9IMmREZ3RCd2FSTzVhcmRPSzZsK3F3SURMaXpvNG5iN2g4U0Jr?=
 =?utf-8?B?OTd0VHlERXd0eWlCVmhiMGFrQ0gxd0VHMFBNRk44U3J5eC9BZzRMbmFxbWRS?=
 =?utf-8?B?T09BSisyRXU2YjVrRVpGYWF6cWV6UU83RU9mdnlaUSsrK0lyeDh1L0dCZXpO?=
 =?utf-8?B?dVJEdFhrRGI0cUdQWjk5MnBkQm9XN2lGNldVVmFpaXE3OUVCU3h4eGlhRWFE?=
 =?utf-8?B?WVZJcStFcDRzSGVVODJiMGtUYzhsYXJ4V3ZnelJKV2NXMEZVV3M1Z09YNEQr?=
 =?utf-8?B?VVBDMlhHbFNSVzVacStsQ1ZaRlBRRkgwU3R5SkI2aDM5WmNkaDluL0ZKczU5?=
 =?utf-8?B?L1RXblRDV2RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGozTnBLRDJ4RTQwbmw4c1FUbUhGMDA1TVlIUEZSN1kvQUJqUjdmTGJ2YSsy?=
 =?utf-8?B?TnJCd0MxQjlSWG1uQ1NwQnkyVmovcndOZWVRdmR2NHNNOHp6QlIvSjYzUkNs?=
 =?utf-8?B?TnBjZUp4MjBCMWQyL205Rkw5TE5XNVJuQVY3RGhLTkhWV1A2Y09CREtlcTBG?=
 =?utf-8?B?ODNFaWh5cktqU3FpV1pONmtpNVcrZkd2azdMQ0I0dU82aFBhdktTc0FSMEZx?=
 =?utf-8?B?SXdqd2hqRTVzRXZDQnVuK0szSHEyOG5ZNFpraHdsUEQzK2VRRVd1SHdLaDZj?=
 =?utf-8?B?YlVtbXE1RWZ6YVBOTkZMdUt2enRGU2RLSWVVUDBENXVTKzAveWMrVXg0MGZW?=
 =?utf-8?B?Q0t6RUJZZ3E0UUxqd0g3bWtDYWcxY25TYkVGMXo5SDlRSk1vWlVYaEJZY0cz?=
 =?utf-8?B?UGRXRHBka0s5WUpLYmhXZ1F1U2dhV3lvbUNmVzFSQzdYcklLRStEbmkrRHE3?=
 =?utf-8?B?dVp6WDNpY1Z1bHMvZ2lCd1pmY3JXbE05YzhlVC9XakN3QlgvdEMzTUN1VW1q?=
 =?utf-8?B?ZzZ2a1FWQ01yMGV5bmZRNUwzUHI4VExoV3RVMUVabVppdVNhc2MyWWNTcFZ2?=
 =?utf-8?B?aXV2OWhuVDVVczV5MGNnOXNnaVl2K3g3VnZLRXVOck51cHBlYWdhMzdDT01Z?=
 =?utf-8?B?amR3cEN3eGhoS0RIVFMrZlBJeGtqVGNQVEw4bndEb1ZWbnZQS21NV0Fva0VQ?=
 =?utf-8?B?aThPcTh4RXJMcVJBT1NQdkpDR3laUTl5SWZQTU1HOTAzVk5MdjRwL2FSRE53?=
 =?utf-8?B?OFJTM1JveS9TSjQ2VHJNSGxNUWxmQUkyMlhFS0RrcDVjQzlzaVRJTVpBcS8y?=
 =?utf-8?B?SWh4WGV3czlTVmxZd25jWjEwVWcxVzFkRVNXUGJ3VFVmRmQ5RzJPM3dxamVV?=
 =?utf-8?B?MEpud2hLWE81RkZIbklrbEJUaTV4UTA1UVkvM2tMRXZBaUxIaFVmbHNiSG02?=
 =?utf-8?B?Z1BMYmRPYXlOWjYwWnhnLzhMMTdJVjdXSGlENXRNVVplVzZic2ZlZVR5YXlH?=
 =?utf-8?B?azkvOS9kbDNGdmxBTm02TXdlV2I0amtacGY0WTJQM0toYjBoU1NwZlVCdERo?=
 =?utf-8?B?K1RrNUQxUUw5ajBINEZYbmVSTUFLU3ExZUNlcFVqQTN5ellyL0xlbDYxc1ho?=
 =?utf-8?B?NU0rSStHZ0VtZGhtdVNFV2JaOWdLT21Jd3dxOHlQRmxMVlhrZ2JSWXpZZ2NI?=
 =?utf-8?B?aXh4QkZXaU5hTmd1S3JEV0RhblpyUDZjcE83MEhEL2RaVnh2VkJrWVJiVlVZ?=
 =?utf-8?B?a3JkWWY5U3BqeW1OQm1mWEFNVDVvWFBoTThuQndkZ3h3clpxWUtrMDIrUE5Q?=
 =?utf-8?B?eXJmdTFOYlVKSmhWMXJUZWVVQXJsT1pJRUdaSzlwNVQ4dUdJNVVlMno0MEZL?=
 =?utf-8?B?SzIxeThnVEhtRC9XWjNpVVJCaXplZUN6T0oyY2t0L284eXhQYTdRVytWM1c4?=
 =?utf-8?B?WDVva0c3STEyUEpZcFNaMFUwTmNQb3BNajlsVjRjc3ZhOG5wbWhnOXBWZFRC?=
 =?utf-8?B?bnpJQS9rc3lLUHYwdFhLdGh2b0ZURWZlK3o1eC9BMGg5RjJYRlpJTEFJYjJu?=
 =?utf-8?B?ZzA4NkJjWlEyd2FTRmhYRDVOR2NaRXQyeFpxbGtZa2NXL0xraUFKTzRaelFR?=
 =?utf-8?B?Rm02L1BCaDZkYnZsa0gvbFNBbnFlK3NOWThCSE5WRHNTcm1KTEJ6eS9vbGpq?=
 =?utf-8?B?RUxZRTRPWFpsbUxsSytwYmdPUy9oc0tFbVNzRUJKWmlYMC9YdndPQnR5MXls?=
 =?utf-8?B?WWRnWlVTMXVhQTdjMjhma1NSclBuc1FxOEs3U2NFdGZNY1Zva3B5YWtNR2Vp?=
 =?utf-8?B?WFI2M1hhdXorOFAwcmpUZWw1L3hFa3B0RlNmVWxMd3BNMXpMcWtMUFQ2Vkw1?=
 =?utf-8?B?RjhWclJOdFlnODBrQ2taZjIrWS9udjJQaUJkelcrWFRUWHlOV21JYlFqdkh5?=
 =?utf-8?B?QW5OUytqV053bkxZMHErQ0lyR28xMTFVK1dBVUlObDBVM1Yva3JuOWJPZDgv?=
 =?utf-8?B?TzRzdHFIVU5iaGZyNmdaL1B6d3VjbHJySU5LL3MxL1A5TkIvK05vMjVyeHFt?=
 =?utf-8?B?TjNsNnJQa0FNcWxaalk4M0R5ZjNZekJaMHlpS3U1b25uWXl0RHlnK3V6ZzVr?=
 =?utf-8?B?WTJXZGRlSlpuOXYySVEvUld2YnRnY2VNazZMMHFpVFhubEFZc3A2cDZ0OVlj?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uSR0jM0tXqgRgvpaQaWuZnWwAvy0rPRSzcCH6HVji6R5tFcZnNXtqw5GvRAqUU8JNpKpVYB4kV61SVI0r6IhsV5k+Cse2u9qHzdx5ww9lO8yaQoamdwfQbOoX96eBvRZrvPqMZI/0cltd5oULJiAbwEJUDIBAkR8uAjv7XV9xosmyP8F0obtJB1KTtOwFJ3yQbNi7RNEy45H7E0oPgDuEW0BmM7NpLVyuY9z8lTLy4hYhCSJb67WVJMjPXg5m1abTXcjEGM8nlAe8cxjF6P+g2gymtAiWWU+ZWzurE3XsMjjR9iO1X7/H41pIscZqZv/Zk4P3TS5yJbyKmWyHdgKx4GjLaQrPM5wxrluD1BxH8ME4Y31M1LBvB7FxQbvQ5IOTqDPB/NGvcd6lLKT0gY2kzBa5Br8uR/14ZI50/SJek0WPf27TeOdqNYelXYEmO9FfcsmEQ+8a2IK2ho8g7ktyVdMLHBzQhwBCDCltw+W32nCDNIRnuIyvKG/WCdF6pM8GLPLzhfTdgYy2vn8mKCbNNTWgG4FKD69KDaw4e2T+SQm1qtfTMh0Dk95skkRtCbQh58/eeqGH6c6xU184ji3nUUqn8pQIGT40MkJuSk2feA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f781a21-8066-4bcb-af34-08ddefaa3ddd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:07:42.1345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o00PeSmZbisEbPUrOuu6Lq93OdoSZkZr5BnbWZgRQz801CfJXlqONviyZCJsA9udcMmxXcuIG5SxkWzIu1J/DB+/k7fffGacwyxtL9dEIFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090138
X-Proofpoint-ORIG-GUID: jIqQZUXNcK8vBg7ronReTlye-BUlEWwO
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c034b2 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=CVY2a8O7gXcs5Zw9GIEA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: jIqQZUXNcK8vBg7ronReTlye-BUlEWwO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX9M/3eawiK8uU
 3okz0CD8RHHrNlG4RiSeiEsLABJFtxEuyMGT3U6yQLuKq3s4s8opQXfB3mWMOV6gSyqVTYD9C0C
 VarVB0A//aKqso6axPtPkLu/mPT1knR6x6uZp0byxl9dfq8eBbM73ijhsRwmBKdpZwaCY92jlMT
 S9rt3vDOaID514LQcN2bJr/O28KYY+Mzc/v+7DtkoeyQXAFT3r2tgczqdUjHDyYICepYU44fNN0
 +dmYSQaIwaFmHRRNLZWUJuCH/mthDpj7LmOO2tolrPvNkZ52cyeslLYsqul61tGAKMyEZHqDD55
 i+q2B1Y09ajYcqKXVb89ngQOuCx8gly8iV5jKIbK/6MTQXeWuIQftXnMpJHk4VwuHbOdX4X7aN7
 kEqQtpJi4uF4jtv4ILSqv2Dd7wRIPA==



On 9/3/2025 11:46 AM, Abhijit Gangurde wrote:
> +/* admin queue v1 opcodes */
> +enum ionic_v1_admin_op {
> +	IONIC_V1_ADMIN_NOOP,
> +	IONIC_V1_ADMIN_CREATE_CQ,
> +	IONIC_V1_ADMIN_CREATE_QP,
> +	IONIC_V1_ADMIN_CREATE_MR,
> +	IONIC_V1_ADMIN_STATS_HDRS,
> +	IONIC_V1_ADMIN_STATS_VALS,
> +	IONIC_V1_ADMIN_DESTROY_MR,
> +	IONIC_v1_ADMIN_RSVD_7,		/* RESIZE_CQ */

typo IONIC_v1_ADMIN_RSVD_7 -> IONIC_V1_ADMIN_RSVD_7

> +	IONIC_V1_ADMIN_DESTROY_CQ,
> +	IONIC_V1_ADMIN_MODIFY_QP,
> +	IONIC_V1_ADMIN_QUERY_QP,
> +	IONIC_V1_ADMIN_DESTROY_QP,
> +	IONIC_V1_ADMIN_DEBUG,
> +	IONIC_V1_ADMIN_CREATE_AH,


Thanks,
Alok

