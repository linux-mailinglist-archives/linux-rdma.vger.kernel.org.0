Return-Path: <linux-rdma+bounces-2481-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5E68C5B15
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E86A1F22C64
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421EA17F395;
	Tue, 14 May 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQF5M+LC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IxLq8tW8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9231CD2B;
	Tue, 14 May 2024 18:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711592; cv=fail; b=FA1QbwSrGPhf0VWMm/RdLyV3MY7pcNfV7I7bbu+HXSTQm2Abyiy9q+KPltjkbjQNfcvbZRdwXuYIuSJQXPvHMWgc12c7/Zq8YGxJBfqY2vMIxxfGSRpoJMHgjBnHXA3QNmxvSFM3I8OIO13tFmX6VzQp4akE+dAgW/mGJljPj1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711592; c=relaxed/simple;
	bh=qrBPYw6IbuhxdQ9PV+hLrNlCQ7K1/wVN4hmcAB/QltE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IieG7363fUVfmZ1YnTKadrKELw7iNoJB/1QNxcJtlcFgRMJc3Dq02XqrClRCpSu2nU8kqYFpMKwTJUSA/sqZPYlHKtBCQ7FnI9ZoBEWDo1yraJOIsp487KgaLK59z91ICzE+vTRjZtB78dvKpd+U2ntbS64hSt5uN3iOp5+8imM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQF5M+LC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IxLq8tW8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHK3e6004960;
	Tue, 14 May 2024 18:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qrBPYw6IbuhxdQ9PV+hLrNlCQ7K1/wVN4hmcAB/QltE=;
 b=LQF5M+LCMAdt85KhwdKfMp196GFTz20mCXKGUPmzeKPU7Rqce6ySV11PiB0vARG4fqxI
 70C6srW+wf5UVgo5elFCZYRTe7a2zpW0uacbXhW9qAT9yj10V7sYQDsu/KhAUJFsysuP
 XDO9gG5kIWQ8a8tbD6mXEY5w1HvbmH17xWkEwHaTuH/8wwD1Feu1e2yk2MBnYAB3z7bI
 VUcGumSv2sXfFwcsPogYM6U0Gk/EL3PD0CL93GedwrKB8ZFlVMDWte7dmlw+hv3PAmQg
 3YJ+WldC60141xqmVeQNY30huBi1DBW4eNTsHMYPqhnR2wv3I3aSB/qQ+qBkscunnzYf Ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y4c8r06nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:32:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHdqhA019278;
	Tue, 14 May 2024 18:32:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r857q9m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRKhvryVaB5+JQFSuNPncDvUPxyEkhLm8/SAxx7hMd92iFBaRcFd6W5DslHcz2JnOd2iE48dO9AYn7ueUHYkkt56bRzuQC7PUb5RCXDkv7boxvHWa6kB9Pk9HAHLNloxAStgvdJxod5GtnIXRKHKYcNTrno+S55IdxPD1wb7P4yj2Nq33sR+RVN2s5bVLuJka9kUk+lch9JGZJAbhepOWKM7nyNOwa53SsubsvNpG/Sc8j5w+bgbA7t+3Pv7nfcC8XptZLgBumW02j37Md6tockyLx5KOiD3Ggff2mbAG1/423fiVphl6SykqI3/bmTfpeRN5vv7bmAy+LeLHMrYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrBPYw6IbuhxdQ9PV+hLrNlCQ7K1/wVN4hmcAB/QltE=;
 b=BzDk6MBV24JOda2cNWQmI+9N+VQufJZnUixlem8GpNPMsjct555KEAD7YaXctPd7ZDpSHYNKDJiKpBE8FKjZpSTLx87c9nB4xob/0q8Jx7/6AZpurjypHW5IQ5/xMjBJUXNvPiu4C5VT5aY4RTIZIe6vsglwBI0wjVjvbqoupL8L5wRERoiAD9sTq020RLwYcqnvGf4WaObyBVL9mZRA5dRr+aTcEdgdSJK93YSeSirGvo43GUdiig0dzvV9DQyoj3opJLX/tCBYq0M5iNLCvv/bH+jOrUXsd+uX3f6nbA90AdqArl6hbi8B23WYIZqknwLPvXVWDNg9I9eNp4oVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrBPYw6IbuhxdQ9PV+hLrNlCQ7K1/wVN4hmcAB/QltE=;
 b=IxLq8tW8gbPLSYfvXsq3DswYmxaRAyzFJ3OP2bb8DGE76OWpYFeYsB7Cj5T5k01H/xNqYU4u7qd89ksjSTr3Hjf7Tu5HHxmvnqnoiAU+yWpsJl3EwhWJLhd9LalnttV0vt/a05K04DfeSN4eEq2hApJo6vCTeeHWH+/NZXSXlgs=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS0PR10MB6848.namprd10.prod.outlook.com (2603:10b6:8:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 18:32:46 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::8518:ea67:dd0e:9836%3]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 18:32:46 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: OFED mailing list <linux-rdma@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Tejun Heo
	<tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Allison Henderson
	<allison.henderson@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Chuck
 Lever III <chuck.lever@oracle.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: Re: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Topic: [PATCH 0/6] rds: rdma: Add ability to force GFP_NOIO
Thread-Index: AQHapTSoAznTybBSbUOmaFlIKGsN0bGWbduAgAA04wCAAG0EgA==
Date: Tue, 14 May 2024 18:32:46 +0000
Message-ID: <8F5C99B3-2575-482C-B931-7510CCF55B03@oracle.com>
References: <20240513125346.764076-1-haakon.bugge@oracle.com>
 <38a5ccc6-d0bc-41e0-99de-fe7902b1951f@linux.dev>
 <54d14e4e-63e7-4bce-866f-0e2f2c801232@gmail.com>
In-Reply-To: <54d14e4e-63e7-4bce-866f-0e2f2c801232@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS0PR10MB6848:EE_
x-ms-office365-filtering-correlation-id: 8190fc13-dbbc-442c-972c-08dc74444077
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NEdNb0N0SmhvSDFPcEdEN0NZeXlOcHdNZjRHYkRIVVA2S1hqVHZQampJYXZ2?=
 =?utf-8?B?aDM0dTdXMHpYcFI3Yk9HbWh6QkVTVXpra2s0d1h0RDRNN1FFc1pyZnNDTHM3?=
 =?utf-8?B?S3hTSyt1N1ZLRGlSMzl2OHI1K2Vid3prODZVNXlYMjZyeXBoMTYxLzMzL0dL?=
 =?utf-8?B?bHhKK1ZvRkUzNXhkSitnc0IrcHY1SE1XK0sybzYyTFJJc0x4V0dDdm1UY1p5?=
 =?utf-8?B?bitycnkyK29hWlZoRmR0QkY5TFU3ZGxRemx0VHZxcU9KTFZPYkkzYWNvanM1?=
 =?utf-8?B?SU9JU05RclV4V09zeE9CQ0p5bThiTlk1MlpwWGRSZjR0OFFpYlhsNGFKaGZj?=
 =?utf-8?B?L2QyOFlRbEZyaUlKWTdZYVpoU3dzblJ4RmtRYU12UVhHZW16ZDdvT2dWbzV0?=
 =?utf-8?B?M1FueU5JVjBBNTZCdmVyaEdNK1BNQlhreHMvY1hMVXBza090QWIvUUJrWDdN?=
 =?utf-8?B?a1ZXQUQwTk1SdXZOSjBFWDc3dUVmZ2lzb3l1emJFNFM2SUZWZXo5ZEVjRkJ2?=
 =?utf-8?B?OHNYYXBUTnpiMndRTDRVWnkxekFVSGdNMHRaNm5pL3JoTUxXa3dOVk9IK3ZE?=
 =?utf-8?B?emEwWmJ5OGN1L3hMK1Z1SnJNSStidDlPeGFxUE9WRWJma1pMdWJMQUJqYmlE?=
 =?utf-8?B?QUxqWVAwMjNLSlhGZSt3Y0Vqdk0vV1Yrb3lkaldnRkJyTUF5V0F0MlZ5RTN4?=
 =?utf-8?B?R21WZ1dFZEEvVEduS2dvamVITWp1WUlGVmx5QSs3UlZGa0xMT2h0UlBHVnF4?=
 =?utf-8?B?SXRMVVZXbmw5clNUelZOWWZud0pzMFhtWWNVQlVuSHNXRW52eEpZUEpQRmho?=
 =?utf-8?B?dk5meU5jM3FXMEFTSGMvMEU4Smh4TzVNVU45T2tpa3ZBM2Qxbml4SXVSbGVY?=
 =?utf-8?B?U0lIbWRKSThPdkN4WVl2SmdFKzZIMmJEWm5uTWR3anY4UFBWSTNjUnAxcC9T?=
 =?utf-8?B?bFRrNHBMWDNZMU5qTHYveExXUGQ0QnVUb3Q1RHJURkE0cEd2QlQ2RzJiOFFw?=
 =?utf-8?B?ZXdkU24xaEVQb3VYTmh0bXhubVhhd09rV05DL1d6Y3dFbnoxbEhjUzhoSVBj?=
 =?utf-8?B?YlRqUktnNURGOVBpVUxxWHZnTzI5N3hSUk9qNng1WjVqRXlSQks1VlZyTzBY?=
 =?utf-8?B?WEZ5Sm5ydjBtQVBuMHFnTzlicUIzL0hIQjgzeXRBa2U1N3VGcE9NNmwzTEN4?=
 =?utf-8?B?b2FJZTdlVmNNRlZEZGxwVURrNTNZelk0L0dnY21ZU1lXTFdiUGpHakdzaEdn?=
 =?utf-8?B?b3d4V3BSVmE1VWk2YTVKcVNiUFhFWmdEanhCVnd0cWxPL2JoNEkrQldqaHll?=
 =?utf-8?B?T04zQ2haeUlmelI3VWtTOGRGcmxPTmEyU09YdXpuTTBKVWZ1bU9kc2lzdEZw?=
 =?utf-8?B?VDVOMVZBKzVEcStETHVjQk83QmVWa05xRlR6a0hXRFZEL2lML3hYS2ZPZmJQ?=
 =?utf-8?B?N29ZYmQ2dWJ0eDJxYXM4bVpDZTBrT0U2R2RtZE1yWmM5T0Q3K2hhNTA2dGVN?=
 =?utf-8?B?MzNWNDgxQ25kRS82SXlxZTRmaUFDWFBTK1ErZDI1OUs1cE5iYXpjb0RpSC9i?=
 =?utf-8?B?L09rTVF2elBvbWowcFZvWlZmTmNObDdZNjAwUTdjZ2Z4YWF6RlNuU2lMR0Q2?=
 =?utf-8?B?UmVFS3hZcklNRTR6OGo3UUZtc21WOWtzZVRZZFE1b2dIdjZ5MnljendTckJI?=
 =?utf-8?B?aG5wT2UwRzFkSnUvaVBDYnlzYjVDVjFjYjJjR1VIaGgzcGIzdnU0QXJzZm9P?=
 =?utf-8?B?WjhrSVdrTi90dDBWc3FBSGorT3BrNG8weXdaZEZVZTdQNlBHUERITUpxQWxM?=
 =?utf-8?B?WWNuempPcm0xVlZ0RVpLQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZnFreHR3TFdMdGt0TUk1U1ByWHdDeFZsSmg5aEdzOWxBdDRFcEIxd2FydmJ5?=
 =?utf-8?B?NmdWWE5WcC9mWUhkWjg2NE1SWnNaYUJ0d1c0MjIvVlJ1S0pFbk1aU0NqS3ZI?=
 =?utf-8?B?TXFJa1NMTnhDdWc5TjQrMDBMblJkR3lIelhNTFlXZ1VlY1hTQllNcXdGSi91?=
 =?utf-8?B?MzBvZnhYbFQycnppS0k5Y2hpbXBBNFFsYlozWk1qTVB4Ykt0RWlVeUNQRWww?=
 =?utf-8?B?YUtjeXRTQWdJMUd0aElsek1vaXBsMng3M2lqYzJ2b2tkdGlRV1JaUS9CeUEz?=
 =?utf-8?B?aHRlRi90bVVJM1ZXYXNzOUNwUXZYa3h3MkdwcjAwU2E5S2I5dlFwMDZrTEpP?=
 =?utf-8?B?ZmFMUlIyZkhMT0E1QTVOVDAxK3JPUmZvbVN1SXNiaFVCZUszSTdRUlNVREJo?=
 =?utf-8?B?OVRML0dNenh4VEZvRDF0SjVBYXRGMUFTcmRKSEpiQjJsRXJXM0hmeHFTa1Fv?=
 =?utf-8?B?OWpQcjVxdTNDMnU4UFhucGUxdUdNajRjZGVPU21Cb1VmcHV3Uk5rYUsycWNL?=
 =?utf-8?B?V0ZneU9DZVNYY0h1bUhGUWhFd293dmdBYTlVc2JoNVVZRG9QMDljTW53T0FC?=
 =?utf-8?B?RGxXUzR0UlVxVzFjL01QaTh5WEZxOGRUWklTMWxscUxubEZGeHJMYzUydGNs?=
 =?utf-8?B?SXRPck1LZ0t4eVd4d1RUZFRVREVxTXlyOUJwc2tqUDdqZXNRK2V5TU9tQWE2?=
 =?utf-8?B?R1lJdzVUclFZKzNnNk5wN2pWRng5QzE4Mlk0dnB2bnpLcWM2YllkUmZ1VlVF?=
 =?utf-8?B?UjkrSm80OFlqclcrWFJ2Qlo5SFRZSHROTmNYTVAvQmtpaVFUdEc5cFVMempW?=
 =?utf-8?B?bFJqd2pXNWJSaVZmWlN1U2E2N0w1czcrVmthTUpXeFJyR0xRVDhKYUExaExL?=
 =?utf-8?B?TExOUHpaRWxrL2J3NVBNWkxFK2hrSnRBRmgzYlpHT1JvSTBrRVFjbElHVGhx?=
 =?utf-8?B?TnNRR1QwNmZRdDNQUkc1SW5WcFVLTFFHODZrVG1Ya1Y4YkpvTmRXVDlRZGYx?=
 =?utf-8?B?dzJXRC9ZcFI4Y3B3MEdDV1VhdEpzd25jUCtCN0RneDA3MGQ0SW9teUxxMGQ5?=
 =?utf-8?B?bDBESi9leVJBTXI0VW02UzB3NGxoUE5uem5xT3kzUUdJaU9lTUY3bDg5ajlS?=
 =?utf-8?B?QWgreW45UmhQbXRWcmttZ2xScVlSa0pYU1JOb1RROFZQSU91d3JLSnNrS09h?=
 =?utf-8?B?dE92eGN6aVd2d0RqOXlZdFE0ZUJ4RDRpOFdEeWVPM0J0enRydVVBYjllM21H?=
 =?utf-8?B?UUZZa2ZOa2dyOUR4M1doR0h1dzRubkJrK3BoWjZHRVNHbWxkOUZqV2w3M0tI?=
 =?utf-8?B?TjR3YU1hZ2VwSncrdXczMWQyWEx2QVpScUhraVJCeG05d0I3V2ZUaGEvMFly?=
 =?utf-8?B?N3ZyU2Nsc25Gdm1idlNiZnJlOHZ0V2xqWTlOVlJ3NWtSYkNDdnpObmFjczBJ?=
 =?utf-8?B?YkxlamlMMlVkWUk4WCtFWGdiN1RCMlBnc3F6NWFVdHkrYXUzRVJiUGJxWVo0?=
 =?utf-8?B?cytRMmZqNFJhUXRBQ1ZsQW51ekpuaUhqMG5uSEhvS05Vb0VtdzlBYy9PN1FN?=
 =?utf-8?B?ZWhkNTFWMHJVTXlUeWdLSW56V2VRQ3B4Tm5pTGE5MVFHeXl4MHFyRE9kSmtE?=
 =?utf-8?B?TXV5SXR5UXNraEFkbXNsMHRpZW1VOUNWWVUyZUlCRGxQV0tPQUgxS0pvemcw?=
 =?utf-8?B?SW0rNUk2c0s2UFBhRHJDbVl3QWlVc3M5TTBLcDNBYVA0ZEZ4Tzh6dzdpWXhx?=
 =?utf-8?B?SVZYeEovMjk5d3RWQk9pNE1FK3RWUVJNK1QyRWMxamthS01aNlFUZ2lQb3NM?=
 =?utf-8?B?REFiSlg1aHNuOS9iV1JNNmlXMkcyVnVrRG0yYWJZSXZiOTVQZEplUi9YWEM1?=
 =?utf-8?B?OVRBSjBlSGt0TS8vTFcyclNhVXQ3K0xxNFE0UlF5U2x3b3dOd3ljYTREU1lS?=
 =?utf-8?B?Z3h0L0VaQjU3WGZRajFjNjdocU1zM2ROMnNoOEtYMFFObHY2S043ZVR0bTNT?=
 =?utf-8?B?WHM5a0ZLakhzejhhbkdxN3ZheXc5a3M1cVBSajlCNExyV1lKcTRINitmMEc2?=
 =?utf-8?B?S2NaQXYxU2RiaUxHM3N4Y2RNeFVYRmZnS1BBQXF1ZnlzOTE0SmthVHZHVDZL?=
 =?utf-8?B?dG9HUnBlMWhXY0w5STR4emhnY0M5MXRYaHlXamdFemZJL1h4TU5EWVBuQ2VR?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBC0C844854BF641AC52980DB64CA2A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AWJScvTuaDnja20vt+B0C8hubM9/JI6ni5R9WOCGaVeXjSFlT7HtOmf53F1ucMccQ5kt4Hf1LKPg8QUrjDQoskAgsavdUamSY25URIoeVeTksgqTWJCHtomDc/p71c5Vx1Va3LpXxek74oEWMAuZc7qJC3fNAKXHhHugjkkHsztjaaWvX8q+BlSo/hhQpqDL6iLd+LWsHkSTjDI3/LtJ1TCYTgJzk7TNXYg8ZTbkHG8YGxFUC9Kco+ZjM2rbBG+EKyzl293z+JKc8+t2AYdc2Yg08fdnxYtWityeaf/tHooyG2/UXVtQu6XZ/dLTaEfrU9GXLIf0zVXNX2qGWlX246Ely/tODJ6voXHElK8sTNDjfmZXNO9L+WoXex6J611SeklSnejzPSbkMd170K9aW1HqaATHXVpa2t/GIKW1hcBGqxLdIsjPjzNjIqFiKu2yuUSxfF9xLYTOiKVl9t56K19YnxLE5R6ZIdVDi3JqHX3XhiJEyn2Qm7bDSBHS/AHq6tLrVlVipKmw1/3svZE8WRONoePkvSSfvt/wcqwfFuo7mgzAiUMPxcDf0FZwVTT0joufOe/1yamAR5hwk8yrEtFMBgBqpjd+hN3O01yNIT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8190fc13-dbbc-442c-972c-08dc74444077
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 18:32:46.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yxfQ+BtXTyczzcJunOKO8tbrnY1CMm7R5F7y3101tsZg1xLkm5VrG7WuhtSItmW9pgv9h0HdxmYgTkxR8jyXkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=887 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140131
X-Proofpoint-ORIG-GUID: BPWBTohZcm0Ydpznwvrw7T1-95jmi6df
X-Proofpoint-GUID: BPWBTohZcm0Ydpznwvrw7T1-95jmi6df

SGkgWWFuanVuLA0KDQoNCj4gT24gMTQgTWF5IDIwMjQsIGF0IDE0OjAyLCBaaHUgWWFuanVuIDx6
eWp6eWoyMDAwQGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gDQo+IE9uIDE0LjA1LjI0IDEw
OjUzLCBaaHUgWWFuanVuIHdyb3RlOg0KPj4gT24gMTMuMDUuMjQgMTQ6NTMsIEjDpWtvbiBCdWdn
ZSB3cm90ZToNCj4+PiBUaGlzIHNlcmllcyBlbmFibGVzIFJEUyBhbmQgdGhlIFJETUEgc3RhY2sg
dG8gYmUgdXNlZCBhcyBhIGJsb2NrIEkvTw0KPj4+IGRldmljZS4gVGhpcyB0byBzdXBwb3J0IGEg
ZmlsZXN5c3RlbSBvbiB0b3Agb2YgYSByYXcgYmxvY2sgZGV2aWNlDQo+PiBUaGlzIGlzIHRvIHN1
cHBvcnQgYSBmaWxlc3lzdGVtIC4uLiA/DQo+IA0KPiBTb3JyeS4gbXkgYmFkLiBJIG1lYW4sIG5v
cm1hbGx5IHJkcyBpcyB1c2VkIHRvIGFjdCBhcyBhIGNvbW11bmljYXRpb24gcHJvdG9jb2wgYmV0
d2VlbiBPcmFjbGUgZGF0YWJhc2VzLiBOb3cgaW4gdGhpcyBwYXRjaCBzZXJpZXMsIGl0IHNlZW1z
IHRoYXQgcmRzIGFjdHMgYXMgYSBjb21tdW5pY2F0aW9uIHByb3RvY29sIHRvIHN1cHBvcnQgYSBm
aWxlc3lzdGVtLiBTbyBJIGFtIGN1cmlvdXMgd2hpY2ggZmlsZXN5c3RlbSB0aGF0IHJkcyBpcyBz
dXBwb3J0aW5nPw0KDQpUaGUgcGVlciBoZXJlIGlzIGEgZmlsZS1zZXJ2ZXIgd2hpY2ggYWN0cyBh
IGJsb2NrIGRldmljZS4gV2hhdCBPcmFjbGUgY2FsbHMgYSBjZWxsLXNlcnZlci4gVGhlIGluaXRp
YXRvciBoZXJlLCBpcyBhY3R1YWxseSB1c2luZyBYRlMgb3ZlciBhbiBPcmFjbGUgaW4ta2VybmVs
IHBzZXVkby12b2x1bWUgYmxvY2sgZGV2aWNlLg0KDQoNClRoeHMsICBIw6Vrb24NCg0K

