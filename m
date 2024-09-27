Return-Path: <linux-rdma+bounces-5140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F20988BF0
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 23:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A9C1F22521
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDB51779BB;
	Fri, 27 Sep 2024 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L1D2neDD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5914BF8B
	for <linux-rdma@vger.kernel.org>; Fri, 27 Sep 2024 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727473559; cv=fail; b=YWyDnIk8teRUaJbg5DQ9i9lmNTi0iUUwSL7P9YeewlDuhAEf3kp8/6s3FMoqZD1O1q+ZzDNPCV4xv3RQeflNz/aBIr3bI3XfU5dZXzVxMWNdw7ZthAMm36F589H/bAhInrCnf29pam2ApmwdfkJyf3+IVH8degMhTeWUfdjZJRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727473559; c=relaxed/simple;
	bh=NgKl4nNGTarK+xCUdx65/M955wAwFgAoLoH7kbNUzRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s1UNLuxFY63BO/kb8P+b4JqBqmo678gOFTGK4dBpxHv36IGmlIdLXhJ4uyyfjRz/bZ6V1aG1AKUHhEnQBIIsR2qi6hoh9ctiELjiIbzkL3cwwjzXVmI//XHB/EHcU5u5wfN1Bc0s4vY+Z21/Pm3dJZsSZntG4104dqfHy21zcZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L1D2neDD; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIKCbLTuejNf37liXLpj/7QYbhbcCCN651P3Sou/qRqnv/JXBMisLoT3I8qp4GRGOjwYfZaiImC5CoVqcjeSsZ+GRXf290TjIJXxwKgHcyPoRdLPX+TcVzMMoSPT21WvqBrCWckCk7ruOzCqFmOuxf9FjcjBc4sOJfXEDpJ41JV6DxopwvOmeI9Crg3PintBHnUCD/dmBW51AxPJ4FrddQ2V78CrtvsbxSsCWARTUwq+rIQSueFPA+i15SRjQrz/OBlHu8YajmbwxJJH1xkyD5u4sh8O0IcarSDbXzVZhMQIOoX8RmaOgfsu5tBv3sOyC6WOITJNOfc9ma2WUy2LAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgKl4nNGTarK+xCUdx65/M955wAwFgAoLoH7kbNUzRA=;
 b=Wmh40in2DSToSo3zWlhiq3zuvC1b2L6pGl2Fcveukb5JMXdzQpG6Gu+OrGWV3tlE6aNfDzznNdAbyw3B5uGxMTQzfKcuLW2EsBCUniJFrQC9GZhXxxlQYO5TP/NT32MliXM55v7mGBztj32QEIQ9n2jDau/+ZgXpX4HARN2oyWMOrAyTZzE/9EYSH2OVgVKK/4yVEa6JaW71HORgDJ8CYaFkud8zV34A1fL2Sk75OHQ3W3q6j/lFksRbFU3nt7liTC1Z/fyzKKIWd21ZXYKLh+QfxvlSx1U/S24UmVE3edKLwUy3hdx50Ko1mbOvnYkmQ80le5JpOSm2biMQf95cUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgKl4nNGTarK+xCUdx65/M955wAwFgAoLoH7kbNUzRA=;
 b=L1D2neDDA7G6lefUVI/MehJrNjlvOKFU+d5E7XBLxF71lpXt+se5pGhe+u6y2dFbJcy8npLYqV70sNbdL0ER3ldALi2VIcbQ+LWeTFSwhOEtD9nz7X/rRmEv3c42POv4F/PgeTdtcG6P8DBYSFgMh79Xj7XTnGoJC9AH+6eTcti3m8L9hcR5muMA7hfQ1t+7iGT1GIFo9nNrKDjZS7QYB0FYrsvAxXdnNGu+x4SbcciXrIFQstPbpgZEBW60/YziSVAGp4G+pYCo1yfjbHQOtijxO/ZutQXYycN59mjOqKbhVAG7NlgcciPtCVEXAVcly5YL4V4dQea+qsr3bEn9rg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 21:45:54 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 21:45:53 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Peter Xu <peterx@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
CC: Michael Galaxy <mgalaxy@akamai.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>, "elmar.gerdes@ionos.com"
	<elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com"
	<armbru@redhat.com>, "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Xiexiangyou
	<xiexiangyou@huawei.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin
	<wangjialin23@huawei.com>
Subject: RE: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Topic: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Thread-Index:
 AQHatnjBzD0Q+/leUkmGnsu3pioCmrI8DtYAgAALpoCAKMQMgIAAXY2AgAQQioCAA47yoA==
Date: Fri, 27 Sep 2024 21:45:53 +0000
Message-ID:
 <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n> <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com>
 <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com> <ZvQnbzV9SlXKlarV@x1n>
In-Reply-To: <ZvQnbzV9SlXKlarV@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|LV8PR12MB9263:EE_
x-ms-office365-filtering-correlation-id: 36e464d0-d32a-472f-16b0-08dcdf3dc2ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUxteW05SlNMZGxOdHNORkNTU0dOTkFYY3ZVWlFDd1R1dVJkVS80Tm9oUWdY?=
 =?utf-8?B?bjU5U2U3ZzExYU55Rk9oajdzOCtxZWFDYnhMZTh1VTZNZ2l3Q1JoOUJhQU5E?=
 =?utf-8?B?Z0ZqMzNjMVZFZ0RqNHFrY2cxQkFobzk5TGFDSDZEU2xFMWFGeVBnbHhaTVZF?=
 =?utf-8?B?anNTYjRrUU11RE0zdkZlOXVRMlhOVUNwRFZTR0ZIbjVhcXdXZWdmd21lOGxU?=
 =?utf-8?B?ckNEU0lJY3JpVStCdDREczRTL2xMeHlrVFUzb29rbFdMendYNkh3RUxyNWZk?=
 =?utf-8?B?aU90UENwaVFETUdIMDBhcTdQb0IvN0ovYVl4ZndCMFk3Y1g0aWRWWnB3TVJ4?=
 =?utf-8?B?UDZ6YVVNMm9IL0xmN2NsMk9hZHNqZXgxWHVjSlpNTmtHaUNIazFhYzZqcUpw?=
 =?utf-8?B?R0xoeUMwcmZWb1JDZzRLUTkxNjFGTEM0RU93TjVSWjdaelJrdWF6bUNnSDJn?=
 =?utf-8?B?UlFVY0pXcngyWmQyZGxwK2Izc25GQTI1K0FHTExCak0yeGtTeUtLbHpabzY3?=
 =?utf-8?B?UlJRTUFsZHZSTmtmQkp0NU1Td1YzMmlCNlpKY0p0ZDNreGs5cHZZNElnN25E?=
 =?utf-8?B?WEx0aHc0S3ZodjhkMnpVL1Jaa3dYMzZIZUY3am44WVJmOEMrYUNsT0Y4MWx3?=
 =?utf-8?B?dWN3WFYxb2VhNFFZZ1FQZHVrV0FVSEVsMGtKWnNqc29Nd2w4VGI5TktmaHhp?=
 =?utf-8?B?T3dEZk1iL2l1NHZSUXVkTGVRalRkSXVQWmt4Z0orWG1xMDZ3ZktJK1lPYm55?=
 =?utf-8?B?N2d3dy9ZT1Q1bVlVSXZOcmpmNkhWT1FrWUxXdlNGV011V1pZWG5USE5KZ3lR?=
 =?utf-8?B?eWN6bGJpdDloOFFBS1Yzd3dBUENkQ1RUc2V6dHRRcGpKemZwd29uVEZMRml4?=
 =?utf-8?B?ZjZtaGpLNjlHMGhBSUZWa0JLMHQwREhzSGVnRzFQSXh6OHpXcjZIK3FvQWVK?=
 =?utf-8?B?MjI4dWN3aHFLZXhicHh6NW5rQ0xDWkdpWVQ5U3BKenpVYmV6bU1RbTJwR093?=
 =?utf-8?B?d0d2QVdyTjlIbk9yWG05clZwbDdBaGtGN1crODZEdDFpdHZKVTRWU3FvTVZU?=
 =?utf-8?B?dWpSYVEvY3NSQXBROTdQcVNBZkFURWNhMm5tSTdLZFd3RGNIL3hiU3JCSFk1?=
 =?utf-8?B?eWFxT0QyQU1CcFkzV0FaVEN3MVJkTGtLYjlPVkV6MU9wTDlOMmluK0xsWkt2?=
 =?utf-8?B?MGlOYWtqZFVUQjlidERmTFlQU0N6bklwc3d2K3pQRlpkZWVLTTNUU1dBK1hn?=
 =?utf-8?B?UkdLQ2x1U21zRTFjVjlmVjVZOHhGTUVBRDh1RjE4U2xVb3BKeFF1OFVWR1pu?=
 =?utf-8?B?UzRhWEU2U1ducS9JWWJXUEFOemxCbm5lak9VZ0J6K1hqYWFuZXF5bXE4bHJN?=
 =?utf-8?B?eGdHZ2RMRFBSeFdxUitBbUVPcEdBTmFDa1F2ekc1MlM4TGtlMUs5Y21JU0ox?=
 =?utf-8?B?a3grRnNoc25WVVYzcjRjVDdvbE15YmNWNUxBUm9rci9UR3kvSkZhcTZsaFNp?=
 =?utf-8?B?bHZROEphVVZnUlRoWFZGdHhwdzdYYjNYR3RlMjY4QlJlQi9hN3hLeEMybUxJ?=
 =?utf-8?B?WVV0OTh3K09DTHFHZzFCWVcxRS9FcWt1aGdMUHI3dmVSRUFGNmRBV3kzSFpB?=
 =?utf-8?B?L1gzVTNqSWNvelJGNWJRQ3BRUzhrTUs4Vm05RXdITGNTSXVWN1JZSjFCYUdI?=
 =?utf-8?B?c3FtdWFvV1ZYZEJ2QWNkQ3FsMFBNWHlQSmFVWmpOaGhpQlJGbHFjSGlaaFhy?=
 =?utf-8?B?cWQySFhwZ3B2NzI2TTJ0ZStrZEluWDRVN3Qyd28zVHNjNXZYd1hCc0F3WDhS?=
 =?utf-8?B?R05jSXVDRGRjNDJlcUhZQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1dFUGw1d1BWWnVvTCs2N3BZQ1dYTFVxaDBiVzBDOHFGSnNBZlJESnljVW4v?=
 =?utf-8?B?Y0pMUThkMjVSVXFnelBOMUpkUU0yTjBDMUpZN1lPYXFVSjYyOUEzMnRCVHFN?=
 =?utf-8?B?STdiejdHMU9tT3FFUndYWXNTbVJpMzUvSEhsR1lNM3FYT0tNVXM4d3pZcHZV?=
 =?utf-8?B?cmxYdmpHUm05VkxaMWhDZUY2aVIzYk40S2ZOMGFWczZaTEVScUM1ampzMHox?=
 =?utf-8?B?YVJheDNTamVoR2t0a3FzZHdxbGNCSUVpdGV0M09IZ3JlL3pRZDRTZWl4SkVy?=
 =?utf-8?B?TDlPekFyOWxvVkRXMW5tMTJ5SXlkOFlLSnEwOTdZNmNXYjJUM2pMU1NzOThP?=
 =?utf-8?B?OTdkMkRwM01UTHFUalFCQXJIK1cyWWZwblFDb0ZZZi9LclFvWG5RSExEQ3A0?=
 =?utf-8?B?ZXREU3VJemZFRG4wZ1F6eU81aUNXQzZ2OTRCdDhMNjRXZG5VdnArM3FOUHdY?=
 =?utf-8?B?ODc0eGRrZ0VyWnZOcUF5YmdlT2Z4WW8rUHlDSGtmK3dtQTdURGJVZkVkNEhY?=
 =?utf-8?B?Y3BmWm5wRkpxd0FjLzVpK1huU0hYdm1FWVZxcXgwdlJ6MWxIaGpsSDl2WkpI?=
 =?utf-8?B?bDMvQWRmTnpPMkVrRDlZN1lpeTdFNUNzT05vb0xzZHdiTTlIaVl2UkFDZUR0?=
 =?utf-8?B?WXRrbUJzQ1oxM2lDZlhacXM2elFqUXFxR01NeUJrRlNkd2xmLzBGeHdCbUJ5?=
 =?utf-8?B?c0QxbmJoaHgzdytteU9mUyt1NllLL2hnU0tndEpGc0o1ajk5S1JOL3FTZzd2?=
 =?utf-8?B?bXYrZ0daYW1OWlBmcHZLZXdyMWowRmMzeWVGVStPSHBmeXJHZ2xQOHpkSE81?=
 =?utf-8?B?TFcvbFhhcXRza1prbWJKQVVYNVUyQzZFZVdyMWgzc0FPVFBobDU2NmhxUlRV?=
 =?utf-8?B?M1ZUQyt5dkpacm0reWJSTk1lUWFjdWZjSElKVVNzQkhpaUM4dHlmWTV1U2Zr?=
 =?utf-8?B?Mkp2UWw1NDVsOXdjbnhTTkRkZlNQMUhtRnc0MzJaamlVMVpKak9sZCtmVi9R?=
 =?utf-8?B?REVmQ1pidTM4Rk11b3BneVpWbUlQSkFORDN6NHRaNkNDV210KzQyQ2lxZjd3?=
 =?utf-8?B?RVp0K1BBaWYzTTJLY1BKekdZYmxWMUM3ekh0YnVpT1dBc0lzUzEyU0wxRkJH?=
 =?utf-8?B?cy9CQ04weHlSc1lVejgybTJRL05oakVvZ0RqcDlmVVBFME5BQmQxcU5hUlFJ?=
 =?utf-8?B?TlJ2U3BUakEzbnd4TTJyOENjWStKaExvdDA2RUtwVHh5YzZxOHU2b1cyMlRv?=
 =?utf-8?B?M2pwT25NdGx3NzhSVVJraithQVVyU2lsUko0aTF5b3dNRG9UeDdRUitMV2E4?=
 =?utf-8?B?cnlUYnIzUlAxeG5ickh6Sm95bTZCVC9QUEJvdDlYbU5oOEJSblFsbXR4ZytL?=
 =?utf-8?B?TFMvaW95Zk5mOHJNUm5VNlVIVWIxRjVNNG4yVUdDLzlKbG8wSzJPeDFSL1Iz?=
 =?utf-8?B?R0p2V2lWenFvdWIvQVZkVnNQRTI0T09ZTUIyVXBPc1AvVFU2bGQ5S2pzWUls?=
 =?utf-8?B?N3R5NzlwQ0F4TFIxQmZzdUE2VTFBZlJVWDIzaVl6allnWUdNbnlLWlNNK2Mr?=
 =?utf-8?B?R3lQRUsxOEY2Zk5HT1pCaGU0NE10ZEFOWWRULy9XVnk2RWpJSmsrQmtnVEV2?=
 =?utf-8?B?ZlhFZjF1ZWpRWFBOd0p3ZkEwOXRJUEFxLzRhSFA2QmlxdWRBNTQ2UEhuV0lH?=
 =?utf-8?B?REtNckxqb29rTXUwVzJ1ck9RMXdlUUdWTTcxT1ord3Z1N1hHczlyZEtaazRB?=
 =?utf-8?B?M3Uray9vVWVnZ3c1RmJObzFzZk1yMjdiWWRGU0FqYXFXdm93N29qSkRTSGJ3?=
 =?utf-8?B?cFo3M3diSUNOWXhHWjN4Nm1ZYmVPa3ZIaEZnV3dtSHlEb0hrWGhpbTJqWk9r?=
 =?utf-8?B?WTlKdGJDaUNmcUtTeWxsVHJvYkRhMHFRRWxTdDNINU9jcWExSjBrVXhpVGFq?=
 =?utf-8?B?WUJ5Rlk3dGRab3dsVW15ckNPMS9rZjN0bkw3TjQ1aDZpSHFLbjRFSXRLblUx?=
 =?utf-8?B?MlRoYVFVa3o1N2tOdXZmeEVySnMyYmlQMXVETStvL3M2Y0t2QndtZ0J3SmxP?=
 =?utf-8?B?SysvYVdiYndzU0pZYmlEV3A2SmlHd0xiQzQ0VFpVZmZSZmVCc1o5akJSb0R3?=
 =?utf-8?B?VGxTTnlIS21uaFFaOURKWFU1TTlQNExEblJRV3pDRStpMVpBTEtQUGFMRGFY?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e464d0-d32a-472f-16b0-08dcdf3dc2ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 21:45:53.6874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv2K1I7ff9HIZ2l1S7C8SJJADVvcqY4cbzNk9KnHvp0GlNMydAEqiOp4j8Kg5H2nhPQWI/b7h64y4eI3l5eUQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

PiA+ID4gSSBoYXZlIG1ldCB3aXRoIHRoZSB0ZWFtIGZyb20gSU9OT1MgYWJvdXQgdGhlaXIgdGVz
dGluZyBvbiBhY3R1YWwgSUINCj4gPiA+IGhhcmR3YXJlIGhlcmUgYXQgS1ZNIEZvcnVtIHRvZGF5
IGFuZCB0aGUgcmVxdWlyZW1lbnRzIGFyZSBzdGFydGluZw0KPiA+ID4gdG8gbWFrZSBtb3JlIHNl
bnNlIHRvIG1lLiBJIGRpZG4ndCBzYXkgbXVjaCBpbiBvdXIgcHJldmlvdXMgdGhyZWFkDQo+ID4g
PiBiZWNhdXNlIEkgbWlzdW5kZXJzdG9vZCB0aGUgcmVxdWlyZW1lbnRzLCBzbyBsZXQgbWUgdHJ5
IHRvIGV4cGxhaW4NCj4gPiA+IGFuZCBzZWUgaWYgd2UncmUgYWxsIG9uIHRoZSBzYW1lIHBhZ2Uu
IFRoZXJlIGFwcGVhcnMgdG8gYmUgYQ0KPiA+ID4gZnVuZGFtZW50YWwgbGltaXRhdGlvbiBoZXJl
IHdpdGggcnNvY2tldCwgZm9yIHdoaWNoIEkgZG9uJ3Qgc2VlIGhvdyBpdCBpcw0KPiBwb3NzaWJs
ZSB0byBvdmVyY29tZS4NCj4gPiA+DQo+ID4gPiBUaGUgYmFzaWMgcHJvYmxlbSBpcyB0aGF0IHJz
b2NrZXQgaXMgdHJ5aW5nIHRvIHByZXNlbnQgYSBzdHJlYW0NCj4gPiA+IGFic3RyYWN0aW9uLCBh
IGNvbmNlcHQgdGhhdCBpcyBmdW5kYW1lbnRhbGx5IGluY29tcGF0aWJsZSB3aXRoIFJETUEuDQo+
ID4gPiBUaGUgd2hvbGUgcG9pbnQgb2YgdXNpbmcgUkRNQSBpbiB0aGUgZmlyc3QgcGxhY2UgaXMg
dG8gYXZvaWQgdXNpbmcNCj4gPiA+IHRoZSBDUFUsIGFuZCB0byBkbyB0aGF0LCBhbGwgb2YgdGhl
IG1lbW9yeSAocG90ZW50aWFsbHkgaHVuZHJlZHMgb2YNCj4gPiA+IGdpZ2FieXRlcykgbmVlZCB0
byBiZSByZWdpc3RlcmVkIHdpdGggdGhlIGhhcmR3YXJlICppbiBhZHZhbmNlKiAodGhpcyBpcw0K
PiBob3cgdGhlIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIHdvcmtzKS4NCj4gPiA+DQo+ID4gPiBU
aGUgbmVlZCB0byBmYWtlIGEgc29ja2V0L2J5dGVzdHJlYW0gYWJzdHJhY3Rpb24gZXZlbnR1YWxs
eSBicmVha3MNCj4gPiA+IGRvd24gPT4gVGhlcmUgaXMgYSBsaW1pdCAoYSBmZXcgR0IpIGluIHJz
b2NrZXQgKHdoaWNoIHRoZSBJT05PUyB0ZWFtDQo+ID4gPiBwcmV2aW91cyByZXBvcnRlZCBpbiB0
ZXN0aW5nLi4uLiBzZWUgdGhhdCBlbWFpbCksIGl0IGFwcGVhcnMgdGhhdA0KPiA+ID4gbWVhbnMg
dGhhdCByc29ja2V0IGlzIG9ubHkgZ29pbmcgdG8gYmUgYWJsZSB0byBtYXAgYSBjZXJ0YWluIGxp
bWl0ZWQNCj4gPiA+IGFtb3VudCBvZiBtZW1vcnkgd2l0aCB0aGUgaGFyZHdhcmUgdW50aWwgaXRz
IGludGVybmFsICJidWZmZXIiIHJ1bnMNCj4gPiA+IG91dCBiZWZvcmUgaXQgY2FuIHRoZW4gdW5t
YXAgYW5kIHJlbWFwIHRoZSBuZXh0IGJhdGNoIG9mIG1lbW9yeSB3aXRoDQo+ID4gPiB0aGUgaGFy
ZHdhcmUgdG8gY29udGludWUgYWxvbmcgd2l0aCB0aGUgZmFrZSBieXRlc3RyZWFtLiBUaGlzIGlz
DQo+ID4gPiB2ZXJ5IG11Y2ggc3RpY2tpbmcgYSBzcXVhcmUgcGVnIGluIGEgcm91bmQgaG9sZS4g
SWYgeW91IHdlcmUgdG8NCj4gPiA+ICJyZWxheCIgdGhlIHJzb2NrZXQgaW1wbGVtZW50YXRpb24g
dG8gcmVnaXN0ZXIgdGhlIGVudGlyZSBWTSBtZW1vcnkNCj4gPiA+IHNwYWNlIChhcyBteSBvcmln
aW5hbCBpbXBsZW1lbnRhdGlvbiBkb2VzKSwgdGhlbiB0aGVyZSB3b3VsZG4ndCBiZSBhbnkNCj4g
bmVlZCBmb3IgcnNvY2tldCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+IA0KPiBZZXMsIHNvbWUgdGVz
dCBsaWtlIHRoaXMgY2FuIGJlIGhlbHBmdWwuDQo+IA0KPiBBbmQgdGhhbmtzIGZvciB0aGUgc3Vt
bWFyeS4gIFRoYXQncyBkZWZpbml0ZWx5IGhlbHBmdWwuDQo+IA0KPiBPbmUgcXVlc3Rpb24gZnJv
bSBteSBzaWRlIChhcyBzb21lb25lIGtub3dzIG5vdGhpbmcgb24gUkRNQS9yc29ja2V0KTogaXMN
Cj4gdGhhdCAiYSBmZXcgR0JzIiBsaW1pdGF0aW9uIGEgc29mdHdhcmUgZ3VhcmQ/ICBXb3VsZCBp
dCBiZSBwb3NzaWJsZSB0aGF0IHJzb2NrZXQNCj4gcHJvdmlkZSBzb21lIG9wdGlvbiB0byBhbGxv
dyB1c2VyIG9wdC1pbiBvbiBzZXR0aW5nIHRoYXQgdmFsdWUsIHNvIHRoYXQgaXQgbWlnaHQNCj4g
d29yayBmb3IgVk0gdXNlIGNhc2U/ICBXb3VsZCB0aGF0IGNvbnN1bWUgc2ltaWxhciByZXNvdXJj
ZXMgdi5zLiB0aGUgY3VycmVudA0KPiBRRU1VIGltcGwgYnV0IGFsbG93cyBpdCB0byB1c2UgcnNv
Y2tldHMgd2l0aCBubyBwZXJmIHJlZ3Jlc3Npb25zPw0KDQpSc29ja2V0cyBpcyBlbXVsYXRlZCB0
aGUgc3RyZWFtaW5nIHNvY2tldCBBUEkuICBUaGUgYW1vdW50IG9mIG1lbW9yeSBkZWRpY2F0ZWQg
dG8gYSBzaW5nbGUgcnNvY2tldCBpcyBjb250cm9sbGVkIHRocm91Z2ggYSB3bWVtX2RlZmF1bHQg
Y29uZmlndXJhdGlvbiBzZXR0aW5nLiAgSXQgaXMgYWxzbyBjb25maWd1cmFibGUgdmlhIHJzZXRz
b2Nrb3B0KCkgU09fU05EQlVGLiAgQm90aCBvZiB0aG9zZSBhcmUgc2ltaWxhciB0byBUQ1Agc2V0
dGluZ3MuICBUaGUgU1cgZmllbGQgdXNlZCB0byBzdG9yZSB0aGlzIHZhbHVlIGlzIDMyLWJpdHMu
DQoNClRoaXMgaW50ZXJuYWwgYnVmZmVyIGFjdHMgYXMgYSBib3VuY2UgYnVmZmVyIHRvIGNvbnZl
cnQgdGhlIHN5bmNocm9ub3VzIHNvY2tldCBBUEkgY2FsbHMgaW50byB0aGUgYXN5bmNocm9ub3Vz
IFJETUEgdHJhbnNmZXJzLiAgUnNvY2tldHMgdXNlcyB0aGUgQ1BVIGZvciBkYXRhIGNvcGllcywg
YnV0IHRoZSB0cmFuc3BvcnQgaXMgb2ZmbG9hZGVkIHRvIHRoZSBOSUMsIGluY2x1ZGluZyBrZXJu
ZWwgYnlwYXNzLg0KDQpEb2VzIHlvdXIga2VybmVsIGFsbG9jYXRlID4gNCBHQnMgb2YgYnVmZmVy
IHNwYWNlIHRvIGFuIGluZGl2aWR1YWwgc29ja2V0Pw0KDQo=

