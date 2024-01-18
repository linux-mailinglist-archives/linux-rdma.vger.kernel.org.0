Return-Path: <linux-rdma+bounces-657-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3878832123
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jan 2024 22:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C762E1C24FA3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jan 2024 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294F22EB06;
	Thu, 18 Jan 2024 21:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nhJAsxFj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iN7dURMB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3A31A69
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jan 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614865; cv=fail; b=igHx06anwBhYpY1k87A82D+vHJC5RQVYCoZntITPsGtB6Etxo9Z7F5RUgYEGpdnwEw+/87+HvJl+luiDq9sbh/f8TvdJM/hLAGMfNomZ77FQ5ifyz29E71bmkt9U+imUVE1+aEV8NBu5SvAZL3HANkznKQ13896hcTmYMsf3g5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614865; c=relaxed/simple;
	bh=N9Og7RmuaEiSVNCVvZ6t8BTPVq1g953yxUofuGvqrpM=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=sRpT2BGhvIC2UbA2tV2tCyCSMoQguV9BPP6af8be+ys/NbbiCaRwcUIX3Po76I8zc+BkRwTTLGpdKHxauU5RHufxWoPg1vdKTRoDH+Zf/thrUUMuP+SBtLEL47D2Am2pFD8vIdw7qNIE3Lgm8qqqdRLZf/0xlbjGHB/dMIKSdL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nhJAsxFj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iN7dURMB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ILS6Ew008649
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jan 2024 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=suvrRQjooxj9Ft3nrAXoNW3jCRPFNY9auWu32AGc/8M=;
 b=nhJAsxFjmKswxl/dNCOA2LbE6n0LeXBFDl8bE1sRDTOUAMiX6dbLsP5iSb1ioAGrDX8Z
 dM4XLRf/2RaVGvJuL7KsfWclng4sZwCMlDuZaP62hkVoUwTeF8dtIktGU+/o47xjKNub
 kRnMn22iavvvwXoADel2dWS64ScufG+aLXxRBbXA5D4b2yD0yWq/lhLD1cvN9Y8KW7uz
 bSa1mns5jBYUDZ8wS6Y7/UI8IV21bXQN/mELp18Fw7R1eOgbL5gCA7ONDz4BrG09bJp8
 FIALe7auHPwia7x8bXPqLj8hEqe5hYjrvVzmbs8qVGYSLo58Kj6gwFjd1tbwTTUH+zyi ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vkq3h3spf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jan 2024 21:54:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40IKScZL025670
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jan 2024 21:54:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vkgye0qs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jan 2024 21:54:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOeyotoecl5FEgJbvvNrw7MiYfgj36pwlqm24Mp6lxIJF5z9mqdsVnc/gY/SOvx9ahyjsjqK+EaInG881/gLesXt2oeu0/Lvyl4+UZXQlYvb8wZ9SVpWG61QCRCODqNODELZY4oOF6tM90NTaOn7sKyivAyXmnrNdmSZ2qYvz5oFQJap10P24tg8mCuxV+MLDgR9ZKis4xDKEVUvmCHkZ5O23Yl+lQnukmpUtCBB6rzh0X5V2q+Q9aVHv2dSjxMnL2pJoo48PwAktXAF8vOvaa/P8jj669OsPmRtF0TDXWVaCfAyjvvFb89Uz3Vlf7TzE5Fg1cYQCicmUUwlzYxk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suvrRQjooxj9Ft3nrAXoNW3jCRPFNY9auWu32AGc/8M=;
 b=YVW0gNzIcrCGhph6zGpgE2U/o/emslaEQGhRPzigiqBMy1LDWlgLF2IBMczv6s4KMLbv4+6Db5gaThwR1TrSBnvhNi8dc9lC12vCHSAindsg0sSRcOd5nrgqlgiXWiT8sHEQgow1dBTkyncP7ax8f6m+eYqJyJF6+vdpGqKBxO1PTU23vIJkGfvfPKS2knuEOEjqukjQxsmtWBDwRnIqYHIQflhjBanhTbC6iIs804hyEQmRAy8yV+ZHDOYhMA5UfXlDIMq0+xW2K0R77RcqTPX4iDSYL8CfSsmteTeLnnWbp2O9NQ15esdw2EzSjdcYqBo155q6vkeDx1hFTGNP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suvrRQjooxj9Ft3nrAXoNW3jCRPFNY9auWu32AGc/8M=;
 b=iN7dURMBTqOrEhkbVxSma5JUWCbX0qvBF35JrxvAezlc8eo20BNMUmpRf5fCKXyxlSKCqmRgaOEU9sOCBaj0Q8hxXEkJRsJqdRbFCQf3yF5W9o5e8hWrTr6NXFLeyGfBdZb6pL87ds+Haj9PbAROQ/NtNNgY7J1s+CPgCzu1Yds=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 21:54:19 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::b4df:a313:3cfb:41c5]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::b4df:a313:3cfb:41c5%4]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 21:54:19 +0000
Message-ID: <1ad5dadb-f6c6-40cf-83cf-f269233d8cfd@oracle.com>
Date: Thu, 18 Jan 2024 16:54:16 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-rdma@vger.kernel.org
From: Mark Haywood <mark.haywood@oracle.com>
Subject: bacm address config file no longer generated by service
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:208:a8::24) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5629e264-1576-4167-eef6-08dc187005a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QMnHFWgTzEAOK/SeE8DnMn0XfeXnDSvbNsLBgIprauduaKQJgoX5O8tKFHRSKgUqK1xKYWJ1VpmWXgqoai75PjKFGDtVj+HysTxK+JqpQF2j2IMDOUuEn3+cF27S9u6AXDMiXPZ4WsgYQTIxm/9jP8Kf2HHzydMdcPexG8ag5BzoeoHNP+rAyGmqOMw/VvAAvnRdkhOUK7VtT3L546240eQ5BpYgKKvjswDwXHgVuF2Tv8s3oHiAzQG3U4v2gn3j8tCNB+Wa613XtkNwW8iiczNQujPiYg9IqSSducGBzJs0ix9fT0FRAaKNLwD9SCGAVQ+KDvgni4VPzmg2SvzVhXP7hWJ0xo1KdwMw91cjsOBVBf5BcRLOp344vW21RFQnPnwfUkC+hkWuhzEwxuKFy1DYCf9y0xtq0oCFbmoJnqSMCRzCIgWHTDYropWOmuSuq/iZ/+vUoik/wx4/Yn8jpzdBvcRq0DJg3dW0GxClR8xZX3Ns+e3WWkuM5L7K0qkK4dXkve18PwecY9wEQjkLah0ciqkgcVUUdbTCgIbUkAyN+KyisAGeexkxfohl6xFOlK+9oHPP4GQ/xehY/VnimUu2TITBJin+1zzatUVJ50kVGle1w/vRsWzhJ3mtY/sUC7MgD7ds5H9myfpHQJLQUA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(6512007)(83380400001)(2616005)(86362001)(31696002)(36756003)(8676002)(44832011)(8936002)(5660300002)(6506007)(38100700002)(66556008)(66946007)(316002)(6916009)(66476007)(6666004)(2906002)(6486002)(966005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVVETUxtYXJlcnR5NTNac1hYeUp3TEk4aStiYzhwUTBrM3RDMUFZcWpDYWI4?=
 =?utf-8?B?Y05VZlFGRVF5N3hwMldKT3BQaDZ5SjNZYWFkVzY5MnR5ck8wcExXWW5pTzlw?=
 =?utf-8?B?dHJnYjY2OGFTRUg5SXhpemFyNW1QaWg2NjIvK0c4RG5lZGJkbEh3TWdTZ3dF?=
 =?utf-8?B?dXcrSHBTWW9OdllUL2dkWWE4NHFqKzJOWktKUlRBSE94bERzV0xjV1YybXUx?=
 =?utf-8?B?QzZOMVBMRWxyTjJYSzJWMXVrYXU4Q1ZVY0lEcS9ZSEN6TzNHVnI2bTY4YWxr?=
 =?utf-8?B?WjZmZitFL2pxV3pERzIySHBvMldaN1ZhRVA2ekt6bmdYQU1rbk5tQWtzZURt?=
 =?utf-8?B?ZWxNeXo5UUpZdFhhamVOYkdSSmxyaUl0ckg3eVluaSs4b1lCSDJNa0hDZzdV?=
 =?utf-8?B?STlydEtDemxhOHA3WFJDTzlYRjhGdWJJeUV0SlFiUC96YkVJWGMrMWtyUzVo?=
 =?utf-8?B?QUNBSVBCbTB1ZDF2UFpDSDljKzZsSjVaNXhSczIwbzZkWHMwd0NGdU5JQ2px?=
 =?utf-8?B?dkRTempURWpBT2JyaVdrYUo4TDFDTkpaTkdBZ0ltL2x4VGkvSUJxL0JZZ3hu?=
 =?utf-8?B?Y01kL3RqeERLL1pzdVErdTc1L2ZHc3FLWGVkYWlIcXhDRmJkaUNWMGM4aTd4?=
 =?utf-8?B?citYektzeHhpdStwVlBkY0lseXlPTkJmTlFQQ0xXcTJkZWxBYjN5N3FWL3Fi?=
 =?utf-8?B?cHRIWU9aQXdKVHcrN2MzOFM3TGdhNW1BU1pDcDlhM2ZsQWdzMHhac1dXOVRI?=
 =?utf-8?B?LytzUmZUM3owQ3BiNWZzZUFobnowS25VTUJHdXcrMTkvMFdjOWFHOVd2NDVj?=
 =?utf-8?B?Y3Y0RkxlRW9NeWpNYjlaSGZzazJaUzNlZWsvZXh2dGFQSHVRcFE0ZThraVN6?=
 =?utf-8?B?UUpaVGoycCtQR2daMXF2OGV4eTdUZ3pIRlJ4b3JvY1VybWwveVpDdlNhcWkr?=
 =?utf-8?B?d21XdEFQVmRvVHMxejhFU0Y0RW5UbFV6SzBCK0ljZHZtTlB5MzVuam4wemQr?=
 =?utf-8?B?Z2dhVFl2cTAvdWVyZmlnOXlYQ2MrU0RrMkZsQTFUMzRzSitad0xrWGhhVUF4?=
 =?utf-8?B?YnVlaWthQklpMGYrTUFtdUlaejZ0cURJWHVqWUlKbmVWM0NJbVZPT0g4T1hO?=
 =?utf-8?B?SWZwOVc5QXdJakZKZ3IwWW1RelhCZkQrcmZmanFFQXpMSXg0eE9iMTZIeTBt?=
 =?utf-8?B?ME1sbTFDZmF4dHlpODJwcDJoVC9vUGNYZ0FPeUYwdDVqQWltdzVHa1VvUWtQ?=
 =?utf-8?B?VnNXdGtQeE1BVy9tTHpHR3c2bW9idEF2UjBLM1JwTG1MWlFZemR4QnVtVUtq?=
 =?utf-8?B?dUhZb3JmZ3NlRklaczF6eVozaTZxaFdBcFZSb0pVeDVwR1AyMWlJUWZ1bW1F?=
 =?utf-8?B?ZHpiYjFYc2NuajhFL0hEOWNoam1meWpORHdRMjNvVDNPUVhJeTV6YkRDVUt3?=
 =?utf-8?B?UytCUkxhSzRaRFdlOVE1eUgzZGF6RFJNRHVxa05vVVpPamZZcStrcjQwUEw3?=
 =?utf-8?B?VHFNOEpNU0t6UzZSMXBIdW95NnNEcXVPRXhqZ0xCeUhRRkc0T1FVcXllREEx?=
 =?utf-8?B?Y2lUdGZDb3MxdlVxdDVtby9Zd1pBZTVJME94MzZ2MFBOZTc1Q2dJa3poc2gv?=
 =?utf-8?B?cE1pREFkUkJaOTFyVUo1Q3F5QzlxMUpLWlFqZGlUcklUWUpxMVFXaE5QcmRo?=
 =?utf-8?B?a2h2dWlMYVF5R2FxOWV5djZNcTUxcjd0R0djdmJSbW1yQzJmYzZCUTVMeG1F?=
 =?utf-8?B?YktMb3Nkb1RhN3FsVzI3TmNIU3I5Tm5vWVR1L0lZRVB5STQ0T1paRGJIZlly?=
 =?utf-8?B?a1Bpd3ZBR3VKOGpJcDgxNktRcXo4TmVZTVVaQmVBU29UM0xCWnJLUmZudkI5?=
 =?utf-8?B?Q2RhRm9qNC9hOC9VTGJiK1lHekY5L2xSd0hsSGxucC9yd0R2Q2lhTkpyZWZq?=
 =?utf-8?B?cTlleEhHb3hTWnE2cHFmeCtYK2QzMGxFMFc3Y3ZpQTlnN0pKRGM5bFBVTHFF?=
 =?utf-8?B?SmdoWndtU1pyVnJ1STA2S0VQN3ZQUGlHNmtLbzRHUVdEQjVNS0xqMHV3VjFq?=
 =?utf-8?B?cDlXWjZCK1V6eGdCd1RBNzhUYWVSYTlZQUVCSFcvckRCK1lTSWl2Nk5GaGdu?=
 =?utf-8?B?TkJzWWRuT3BNekMySEMvYzI5VkFMNU13Nm1MQlZoc2tQOFFtaGFGZlR5dUNG?=
 =?utf-8?Q?mHkilmnra1Xt81KpwghGvFk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PXxJiXJRt+mXD147wMrYxp636V21Z4giX+2AJI9ORHLhtIhS53a+cuXUITBtiyFGlY9i7K/dDihZvhv3gwymd8MN698kw9hbUK5cq6m+WHOz0Xi/q9uHhIsEpSdy3zU8v9kTQSUa7lxM3sYcvZPMAuyLcGPwokskv0GEabDy+e7r8q/O3/LcZo+4fWwlBMncGqdGPACqPk3QGPldWtaZtpfv5jrqrYr5Snxo4YTN+Dn6zrk/XIT9qRYoJ6jWzku0cv/MxkdHYEu4jY5nWMcfd+VfHNNi4frssFQODElqxFlAxRl4/ONc8v4Ut2Yqht9d+O5gpWOXrgu5QoD5svP9BkkcLqMnJSrLEBNt7avSgec7v9fXNyrCLWt23/qb1ypS7vloOKpHx5iYlOI7lIxAy+xGpWVZaj6Dk+D6yEWFKWVMxHZGROne8ipN/58wU+7mCZbqBMZfRrQM/zjdteCpVPfXrZdA0caZD1TxVLXripGcKaNtuirAm7pR+cbSEdthPV6ppem356bd8k5A8y0vlihEJgN4gln1aMNqdCpp6iefTYavd16c2yZZqktZFuff+zMbA1wW+DtousqIgYQlbTmGG/A/5vfEribnYMSWznU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5629e264-1576-4167-eef6-08dc187005a4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 21:54:19.0979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDGX6i8/MD/KKnxyKvjvy1KA8Q/widiqI8GYG8DkQyJoKbTAkXgwNd6kLNNwNBh+pyXd25BI5E6GeI6Aj782vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401180151
X-Proofpoint-GUID: ekxOFCPhGFSaS0Dd2khJujPQKr4rIYtx
X-Proofpoint-ORIG-GUID: ekxOFCPhGFSaS0Dd2khJujPQKr4rIYtx

I see that the ibacm address configuration file,
/etc/rdma/ibacm_addr.cfg, is no longer generated by the ibacm service.
This change in behavior occurred as a result of service hardening
implemented by patch 
https://github.com/linux-rdma/rdma-core/commit/c719619aaa0ec2651edc4e5dee9f5ff81208b185.

The patch hardened the ibacm service by adding the following options to
ibacm.service:

 > ProtectSystem=full
 > ProtectHome=true
 > ProtectHostname=true
 > ProtectKernelLogs=true

ProtectSystem=full setting makes /etc read-only for processes invoked by
the ibacm service.

As a result, the code that generates the address configuration file (if
it does not exist) fails:

static FILE *acm_open_addr_file(void)
{
         FILE *f;

         if ((f = fopen(addr_file, "r")))
                  return f;

         acm_log(0, "notice - generating %s file\n", addr_file);
         if (!(f = popen(acme, "r"))) {
                 acm_log(0, "ERROR - cannot generate %s\n", addr_file);
                 return NULL;
         }

         pclose(f);
         return fopen(addr_file, "r");
}

The popen() code above is supposed to generate the file if it does not
exist (i.e., fails the first fopen()). The popen() now fails as a result
of the ProtectSystem option setting.

ibacm(8) does say "If the address file cannot be found, the ibacm
service will attempt to create one using default values."

I guess my question is simply was this change in behavior expected? Are
admins expected to run ib_acme to generate the address configuration
file prior to starting the ibacm service?

Is the popen() code in acm_open_addr_file() being left in place in case
an admin decides to remove the ProtectSystem option from the
ibacm.service file?

Sorry if there was discussion around this previously that I missed.

Thanks.
Mark

