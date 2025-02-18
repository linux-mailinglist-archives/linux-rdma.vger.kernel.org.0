Return-Path: <linux-rdma+bounces-7812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E4DA3A85A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98306176359
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148CA1BC07B;
	Tue, 18 Feb 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c/s8NsMG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5B21B9C7;
	Tue, 18 Feb 2025 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908859; cv=fail; b=aVpTn3pUdHppt25MuNoMRkcXoceOAgbjncaSE5REviJptRxno9J6PYoYSFTLDiKkIbiBSDUcXWzAA0Q4qV4lE+rnx+/7K0mk3z/b3Xe3Hiq4e7ksY3m4FhIsMS2rCdp/bjhuHsAVBJYrSA1iSVZ5R/6vOxWvCSkYuvXs8X6sEy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908859; c=relaxed/simple;
	bh=n+b2pb8kbWulOa3t+ixQEJgbF/MhWc1wwor5kEqpJ0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1ZaK0YhI1vPU14ilayK7OGTsVlvTbdUye2LG7oz64oZLChWjC8QY2U/auu+iFFA/8ec6ahBqHQIqGLew5NdhdJy0u/jEJ2KW2hB/0arzxB1SdmUxfREUSUYJ700G8fD85WiFLWch4P94voT3yGU2Xbrhx5kfty3JEe/7VDKNDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c/s8NsMG; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QRgqYSDnBlDXdhjyJ5ONPbAvLgFlZC1Y4MM/XXkfrEsNBDZ4dgWHiLVy3/9DRVTR0bWsMQYaLtEnn1NzfRvvSfLO6vzYbmYxfPJKVnUqFhYNWd47Kp7lmpu7EC8IIC79GqsWe7BXbIY9zsNkyjZjYZB2q2STJD716aZTwUkB5YUqShCD18IeSeicsBrvP1CDzbqXhoMTznIg9eAM0e8nWyzwNyxondErvQRQdnOb6cUfxOM+BKPOLLFh2fKs4R7aAmOr06EeXHraImTaQwm+KGbuEjYpPNK/wI/Q+37DkpjJzGD0I+oY+sUmLh5yW45SG2JyNA+9J6m/BQD1Xv4y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QLdGRB0Y3Wn2ofU1Y1nofDnAkOKZbPnaZBAX8Nau5A=;
 b=vO+6dEkxJkNviN49WYv539VEZIVm5DPmwkWNxDDCKccIT78ZyjoKD5bAlEYm/3/Vs1SzGoWbsLrCkI7ChYYHZmVZh/Bwxa9ooqyagJ7dcEP5468iTi4WybJlMKc1dpD83rTDYpSh4TcuS/S5xHK4FovrgrK0gBaC8++XDeB2qyxqjkc04ZNdxjQ2S7c8saIiASy1ZN/PmmFvD7GGSMLF3Ht2DtI2Wsu2wM5RSVK9EFxIQHV+PBlS2VeWNqIRpBveUPffa55emn87pfAr3IKxxJqzuQcL3WozvY7gozZ2QQ0MEZOH87clZ72p6J3KMyGKUfM87uJ1ycJLQ1JuZVzVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QLdGRB0Y3Wn2ofU1Y1nofDnAkOKZbPnaZBAX8Nau5A=;
 b=c/s8NsMGUtX/MUbr3GpFI2v2M4qF1khsv+WIffpmNsyXLc8osq7S0Sqf1WguKLV/EBui5IKHX8hr9D4ze4ZgNHyVqMtKb2f4HS/toexCCQ85AHU0vwXAk6zZtYydVb04OYZKU9UD/TK93wG3JIhzo2GpShI36OJKQiaK+Y3vy8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CYYPR12MB8889.namprd12.prod.outlook.com (2603:10b6:930:cb::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.19; Tue, 18 Feb 2025 20:00:54 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 20:00:54 +0000
Message-ID: <604b058d-88e8-436d-abf7-229a624d9386@amd.com>
Date: Tue, 18 Feb 2025 12:00:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
 aron.silverton@oracle.com, dan.j.williams@intel.com, daniel.vetter@ffwll.ch,
 dave.jiang@intel.com, dsahern@kernel.org, gospo@broadcom.com,
 hch@infradead.org, itayavr@nvidia.com, jiri@nvidia.com,
 Jonathan.Cameron@huawei.com, kuba@kernel.org, lbloch@nvidia.com,
 saeedm@nvidia.com, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, brett.creeley@amd.com
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
 <20250218192822.GA53094@unreal>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250218192822.GA53094@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CYYPR12MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc16d9c-8c27-443a-f5b5-08dd5056f3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N09nYVM2QzJkSFFBQ2xrRmI1RmtMb2pPd1MxNk5FRy9CSTJFTzE1VXdabytH?=
 =?utf-8?B?TFdvMkRXUEVFOHl6V2VnZjlySmhzRmlDWjJhWHBjb3RidVpTSGdORExlS0xa?=
 =?utf-8?B?TTYzaS9UenBVaFdkbGMxbTZlaUVSOVBvazYzTGVoTldDQ1NMQ1NGU0lvb2ZE?=
 =?utf-8?B?WXQ2SHVGZnRabDZGNjU1NTNtTXlESXhJQzBObkJNMGJmUnVWUjFZV0Exa1Jj?=
 =?utf-8?B?YjRLcnJmaXNxKzMwcjc2Ynp5YlhsdmdHWHk1aTZSdkpXS0RDamNEc1pRL3Ns?=
 =?utf-8?B?MXltV0UyamhPUVdnSzBPN2FZRGlHeFRqTWVjZkFsZ2gzUXRPSGR4ZW43dTZv?=
 =?utf-8?B?R2dERmU4NGIwdU1WY1MvUEtGSkJYc0JXbG81QWpqUDFYM01FQ3ZvbFB4QTd0?=
 =?utf-8?B?YU9JaGhUVDR5R1Q0cVZiYUFYT2toUGNicldpaW5iR1ptTU5XNForeTY5alRs?=
 =?utf-8?B?ZzI5ODMzdFZ4eTdlSEtiZHJnbFo1RFBrQmNGQTRrQVl5SmxyTU9SejBsOVpk?=
 =?utf-8?B?VHAzRUZPYmg0bVh0OVpScVoyN3dKbUFyQnNQS0tPNmtHV0JHaHorcGtkR2Jx?=
 =?utf-8?B?aVQ5YXZIczVEN3Q2Y1VVVSttZkRSYklpd0o0WXBGQzdTYVUwcUd6R0laWUY0?=
 =?utf-8?B?M2lDY1ZzRy9yUzUzVThuMVpWaHE4OEU3U2I1M2hsWGJjeW02MnZWVHVwaFJS?=
 =?utf-8?B?T3VuVXl6dmQzOTVXS3JDUFM2Nm05RUpKWEFKa0ZkTGtwYWFtTHM3MWJhMzVB?=
 =?utf-8?B?YS8vRFUyK3BkUTYxdWV4RXh4RTBIaHVYU2liOXg5TE9NZU5DZEtONktuNTdp?=
 =?utf-8?B?TmI1MjJ4ck93SmtVbDMwSkllclJ5emlkY28vSjd1RmE5eGVYekluak14S3dD?=
 =?utf-8?B?RWxyV3U3QVNBeFBzMnRGMHJkU01KYXdwWWhIanU2TFdVbElhdzBYRWFqTm50?=
 =?utf-8?B?d01OSzA0QXlNbXpJMGtVOTZnNWtRajZhbE1hTmdHaWpLWHR4R0kzZGhGa245?=
 =?utf-8?B?Y1hvR2RrSXlBTWxOVGE5WElQaVNFNU9yR29XNmN6WVdGSmFIbmYrbUtYUFpx?=
 =?utf-8?B?UC8zRDgzVytJM21VL2xpQk5PeGE4dHBNVHBVK3o2T2wzdlN4aGFTYlZUcXhu?=
 =?utf-8?B?LzI1QjFPQU42OUQzazhudnVLdjBURWVqTjBYYUZhazV2Mi9NWGlOcDhlREFp?=
 =?utf-8?B?T21tSm1YSVRUYlZ5REJDVDVGMHNFTmNHeXdROFhLb29tcVZwRmZzc0xqdW1j?=
 =?utf-8?B?SzlYeWNqK2N3MCtQenhRMUUyd3RXeHNVSXU2NlRmTlM1VTVWZnJpWDF0blBF?=
 =?utf-8?B?Z2pQWndrdG9STFVhRTV4MkliNXUyaS9pKzc0bWxDcjVPR2pFVUZNWG5OYVly?=
 =?utf-8?B?SytoSjZUOFBPR0tOTE9iQnhMLzhDWGJOaFl1Q3pwaE1ZZTEyK2NwcEszQjgw?=
 =?utf-8?B?dlNFc1dDTjNwU2ZkODhFNS9Ma3cwUU80QVBSMnFMaDMyN0JLbHZiWDZVM0hX?=
 =?utf-8?B?b3JTVXdYQ3kxaUVSM2I0c2N6dk9jNTB0MDVnQkd5Tm1WL3BXbmFRQTV5SjYx?=
 =?utf-8?B?M28zTDR6RzJhL3U2OVpUUFozUVk2dzVsMlRiNUp3dWJEM1ZsNDdGdGo5UTh1?=
 =?utf-8?B?SitWTUpDRFA5SHJFdjR0KzRKWjZHZkhEQUdtMUVrUDZ0R0JIakdxNFl0QWJ2?=
 =?utf-8?B?UG9MTS9uemR1Ni8yYUtjRVdBOG0wRCt4SlFLaysya1FhZHBhK0JuajRGNm1a?=
 =?utf-8?B?YUJYQUo5UEx6cWRKVWExTm9Veit0K3BRY25GMklWS3p5M0NpS2hqNDY5Yy92?=
 =?utf-8?B?ODBTQ1FhZG9vTUttN1B6dWZ6Y1Q0ZFF4REJsb01aeG9BeUZCSnpYZ0t5dTU4?=
 =?utf-8?Q?7/XzPflbgmWlx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVZYNnRUNW9IUWxPak9CVTJKWXQ4blYrVGRLZVFlMlRJZ2FhV0hydlhjM2VO?=
 =?utf-8?B?V0ZybG5iS1lmZHlheGRieUtBTU5FWDhUN3dFRjJwUy9aelJTNHA2WFFmSFB3?=
 =?utf-8?B?NFl6Q2tPd1h5b29LKzFQWHZreFVVVlIxVjRRODgrWDN4N2hNMnlNYUUzNzJY?=
 =?utf-8?B?QjQxaVBJSWdJUkFsZFFkcXpDbVVBc1ZNWmlWaFVHOVlMaFpRb1NMcEMvZm9y?=
 =?utf-8?B?OCtwQ3pSbmRoRm9jdTRmekN0N3pza3JsbTNvTVVUditTN3pvOGlWS1ZXanJL?=
 =?utf-8?B?b0dzS0VGVGhzYXUzekYyY0MwL2p2SkdBUjJRMU14R1ZRWVBBa3BocGRXYU9N?=
 =?utf-8?B?MThJYmhtT1ZwdnYwRjVjcFl2SGFYbnlpS0FHUkhZNCt1Si8xbmR3SitjNlZk?=
 =?utf-8?B?Vlpxd0hKNmRyOUFUWUVaUVowM1FWRElNUW1vd1E2WnRmeHFtUnRLSHU2NzJo?=
 =?utf-8?B?NCtRZmhXM0t6RDFvM0YvVUowR2xLbkY3cVBrSmpoRXlwTnZFUWFYTis1L2FH?=
 =?utf-8?B?dEJ2RzZBQldNRjJUVlFHVWJKQmNsMlRkS3FSc280aGJOZDhSdVNSdGhaZ1Jw?=
 =?utf-8?B?b2l4ZWZrbDVTK3kwVWl2UUY1R2txU1R2SzJQcENyQ3l2VHJwODBPSVJIVHZY?=
 =?utf-8?B?aFFuQlloekt4V1dScXp4eEJFaXBoMXo5MWxpeUhkUkE5NnlldlFZT1UrRllZ?=
 =?utf-8?B?SlRENzVMQ042c01NbG1sU1dmaGgwdzdVZWhxZkRQKzR6Y1B3c09DaEhqSU8w?=
 =?utf-8?B?ZGMxS21palZwaE9mbDRCWHVteXRQaUJIbVp6bHdDamtTdENZZzF0amF2L0ZR?=
 =?utf-8?B?em95cWg5YXZlMCtTUnlXV3c1ZVF2MGFYa3Yvd1JpeXRQelhBN09oenZTNXVi?=
 =?utf-8?B?cGhLVWhkUDBzTFd2NjQ4TWNuTkdiMmh3aGRrLyt1N2k2VWFFY05TWXpPbTBj?=
 =?utf-8?B?cks4RUNhUlQwOU9RLzAxNFB1ZlFyWGtMWGRVS1ZIWWpCbFE5YUxSL3V5dmg0?=
 =?utf-8?B?VXFtVXBvdThKd2ZsckY5VDlhdTJreHZrbEFzVENnWEJydEJ6dmdXc0hVL2tn?=
 =?utf-8?B?SGVRRHpGRHFISGt2ZUl3azY3azd3KzhnS0tacHpuUExKeXJQZmRQR21NOExM?=
 =?utf-8?B?QkZUT3BFZy9DeGkvUUZXRndIbFp4QkJJelhZZTN5RnJGMmQyTG1XNUtkU2dh?=
 =?utf-8?B?Q0xVZWh3dkE1THorQzc0ZzUwakU5ZC9PTWcwZTk0THg4dGpoNFRPeGt0RHJk?=
 =?utf-8?B?bHg5NlFtSm85NkVxdm9qQXZPSlRoNXpMMTFKZ3B5S2Y1NytZSitrWWlaTjlB?=
 =?utf-8?B?VjJPL1hwdGZVWFgxNSsrZS8zd0NjUVp6T0pTYkp4RVg5TW92RWNlVE04K2ww?=
 =?utf-8?B?bERtOVdOWDI5bVI5UWp1NUl3UC82bmN0T212aU85KzJuVHhIMkdqVGZLdzV5?=
 =?utf-8?B?RS9yb2IyMFpvc0czOXZLZnlqM3RxbWxvUlNhTGthT2s4QmRKdUlGRUNhWGgz?=
 =?utf-8?B?WGxoZ3dGSDhRSTdGOHF5QVZjcGl5enVpdmtFRzNVQVpVaWorcFdBbWxnR2tR?=
 =?utf-8?B?dkhSR3V6VGUzbjJLUHJFditLTTBRTjZXQkRrYjJ6RFMreE1oNTVDRU1GaEli?=
 =?utf-8?B?TjQ1RXVUVkZrZTkyLzZDd0lyaFRrWk5taEdoTFNqRFAwK0FlWmFjM3MvQWE1?=
 =?utf-8?B?SXcybEpaazMvTzdtYU1CT3VSSlNNZGpkcTdOUXNpaklmVkRUUWVodTduTkZO?=
 =?utf-8?B?WGk5MDFvZWxpczFRUkNhOUNsamZoUnBpVFBTRXpFbjVzN2JDcUJxamJLSEp3?=
 =?utf-8?B?VzRSYU9DelhsQ0pOWTR3OS9NSDEvdkdYaXpXREp0MGo5WTcwNEU4azRaMndv?=
 =?utf-8?B?dzJKK3BXd0ZjVW1nRHpGaUVycEVVazFtLzgwVGUzOURaMFpLSjJaRTVQT1FE?=
 =?utf-8?B?bDU3TnZQRWZEaW4yQmVTWlJrWXNSZXBTL29RMnd6d0dQWld4MDZwemxqaXpp?=
 =?utf-8?B?NlcxdG5jdTRBc3FvMmlhQUJQekJGZGh4T3g2T2RWKzQ0M1BXR1A2WkIzdWZC?=
 =?utf-8?B?UU5ueFdlc3hVMTgxRldaWUlXdGVpeDN5TGRNdVRzZ2orY0tiTFh5ZEQ1N2lu?=
 =?utf-8?Q?rLwScJ8siLF2XQNPcdcxe+1hP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc16d9c-8c27-443a-f5b5-08dd5056f3e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 20:00:54.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cu0gIhTnm/gW7kdl8lWfDKlEXxmaFnOAfalulgSf1ryvJ9ROogDNSmPM9IMFWl8C/NCIMbbGwajkr7udlW6unw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8889

On 2/18/2025 11:28 AM, Leon Romanovsky wrote:
> 
> On Tue, Feb 11, 2025 at 03:48:51PM -0800, Shannon Nelson wrote:
>> Add support for a new fwctl-based auxiliary_device for creating a
>> channel for fwctl support into the AMD/Pensando DSC.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
>> ---
>>   drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
>>   drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>>   drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>>   drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
>>   include/linux/pds/pds_common.h             |  2 ++
>>   5 files changed, 21 insertions(+), 2 deletions(-)
> 
> <...>
> 
> My comment is only slightly related to the patch itself, but worth to
> write it anyway.
> 
>> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
>> index 5802e1deef24..b193adbe7cc3 100644
>> --- a/include/linux/pds/pds_common.h
>> +++ b/include/linux/pds/pds_common.h
>> @@ -29,6 +29,7 @@ enum pds_core_vif_types {
>>        PDS_DEV_TYPE_ETH        = 3,
>>        PDS_DEV_TYPE_RDMA       = 4,
>>        PDS_DEV_TYPE_LM         = 5,
>> +     PDS_DEV_TYPE_FWCTL      = 6,
> 
> This enum and defines below should be cleaned from unsupported types.
> I don't see any code for RDMA, LM and ETH.
> 
> Thanks

I've looked at those a few times over the life of this code, but I 
continue to leave them there because they are part of the firmware 
interface definition, whether we use them or not.

You're right, there is no ETH or RDMA type code, they exist as 
historical artifacts of the early interface design.

The LM type underlies the device used by the pds-vfio-pci driver and is 
a value that pds_core will see in the device identity information 
gathered from the firmware if there are VFIO VFs configured in the FW.

I'd rather not mess with this enum for this patchset, but I'll keep this 
in mind for future cleanup work.

Thanks,
sln

> 
>>
>>        /* new ones added before this line */
>>        PDS_DEV_TYPE_MAX        = 16   /* don't change - used in struct size */
>> @@ -40,6 +41,7 @@ enum pds_core_vif_types {
>>   #define PDS_DEV_TYPE_ETH_STR "Eth"
>>   #define PDS_DEV_TYPE_RDMA_STR        "RDMA"
>>   #define PDS_DEV_TYPE_LM_STR  "LM"
>> +#define PDS_DEV_TYPE_FWCTL_STR       "fwctl"
>>
>>   #define PDS_VDPA_DEV_NAME    PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
>>   #define PDS_VFIO_LM_DEV_NAME PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_LM_STR "." PDS_DEV_TYPE_VFIO_STR
>> --
>> 2.17.1
>>
>>


