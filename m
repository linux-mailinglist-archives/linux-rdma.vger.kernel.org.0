Return-Path: <linux-rdma+bounces-8575-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BAA5BD30
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 11:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AC21895017
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C022DF8F;
	Tue, 11 Mar 2025 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UJnp/zaE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2112.outbound.protection.outlook.com [40.107.22.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33022B8A7;
	Tue, 11 Mar 2025 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687553; cv=fail; b=cSD0NpXnYrxbs9kxQnGx5yUm/YOC5YFyw8Ru+EIPMO1Gms0MbN895zRngFlPkwvPTJKHcS3e0yj8db8LxPPhUh0QP5khBBij+aT+LsKbJmbgF1oCpeNQ50bz5DLC+ZvhRn9+71WXiv3Vn9CFaIQ57oq4fhZHNGlkn/KrPdRlzMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687553; c=relaxed/simple;
	bh=COErFOxQ6OttuY/lQ00AVvXyclQ4gdKhl9wLcWMumpk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C3JuMFmQ8dDkZ0179On6+RN/xjlXetS0k2/6XYA4p2l4clOqSIl/d10hhOWmq+KTEITbXoxZjYeHnaB8NJa7FEbJ8WeBXS3n4x1ooA7pmYqoLt6ZmZKXpOUu25o9BkqKAl/fGoW+acavQIuoflLlcEFtIWS3/BXfHiQr+srhBas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UJnp/zaE; arc=fail smtp.client-ip=40.107.22.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4SIIFvn0dZ0eHV11ZPnt7ped4DBDEJL+a7C8BqCKgRlZdW6XaeuYx7GfXWNUN+V8+tqovDv6PNj5lvqDyQc9nRNtO08CwOQCLvaK7v1iSnMlKK6ygW3z+LV6au1WvAq3tQTJzx3w77j4LNos4tzoNkF+8MfyRBDoQyOWl24BsUfUYKa77io1mpq89Oj1jJmpiE4mheSj1wXp2XrWBXJs0fY/xfuIH9imEPit77TeyR1Rf9bELdzsWtXTAuu2VR9n3KpwfI9fldMy/F2lQ1lSQqcvVFhSwL3GBOW88BQse/iTZbrScF0xRyZpkbz7HoY54FonMBoVPjXliGmLe5N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COErFOxQ6OttuY/lQ00AVvXyclQ4gdKhl9wLcWMumpk=;
 b=JHlvE6u0BJV1QLgfPGPG7w/BuBQBcMi5QhXJ9gfw07W5453llTBhK1uXJY3FI5rBmgNonIbA2s1SiB1T+ehe3WS5zcGi7eCtGS83a0WJweATgj5BNSyr636kO+m2mgqwr6cJZ/4lNkW3JNHUH4iJN4cIgTKA9xaxnqr80jUwcTkIns+42As4wKXZatNBZm/wLFKBHCxLWIyadLYOoWPVPApIZmoQ9M36tHrguG0A6J+dZgHb2TVeDOYyqoYA5VLPzcACgp/OSVFMrAYwDW80lNlJHUzYwEeAJnu4rcnaucIJ4vgr57eFkSIPLRTxkYJDdmrpVx/hS/ABn0bnohVQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COErFOxQ6OttuY/lQ00AVvXyclQ4gdKhl9wLcWMumpk=;
 b=UJnp/zaE9cM46Bvn6H6FJYhILjjnBN3eG75rPSMCSZ3O+Vu6HZaoVDYwAFV4Y8C6qDWAGv/K7Xh6/iEM+1tpd7ndN8h4aL+WShJh/BNkFhv0bKHSQLztieLwr1I5YvqYRbbFkYUCC+lLVMIdWHo6XlTISnKhPlfYKR2oSfSoxn8=
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com (2603:10a6:102:44c::19)
 by AS4PR83MB0546.EURPRD83.prod.outlook.com (2603:10a6:20b:4f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8558.2; Tue, 11 Mar
 2025 10:05:47 +0000
Received: from PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4]) by PA1PR83MB0662.EURPRD83.prod.outlook.com
 ([fe80::3c3d:5eeb:9d38:3fa4%5]) with mapi id 15.20.8534.010; Tue, 11 Mar 2025
 10:05:47 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
 queue creation
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Fix integer overflow during
 queue creation
Thread-Index: AQHbjspA9eqL3gkH0kq12lo3pLVCOLNmlSmAgAcldLA=
Date: Tue, 11 Mar 2025 10:05:47 +0000
Message-ID:
 <PA1PR83MB0662C52043DE3FA1F2EFBCA0B4D12@PA1PR83MB0662.EURPRD83.prod.outlook.com>
References: <1741287713-13812-1-git-send-email-kotaranov@linux.microsoft.com>
 <SA6PR21MB423152087DEEDD4254C414BBCECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
In-Reply-To:
 <SA6PR21MB423152087DEEDD4254C414BBCECA2@SA6PR21MB4231.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ff3bf60f-4213-4abb-bdf0-dbf4741973e5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-06T20:40:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA1PR83MB0662:EE_|AS4PR83MB0546:EE_
x-ms-office365-filtering-correlation-id: f508ed68-7d8e-46ab-203a-08dd60844b90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TnUrWktqc1V2SnR4ZjJqM0J1UGxtZStRc3RnOXJWWnZndFo0WE8yS2ptQnMx?=
 =?utf-8?B?eFdCOTVSQkpBeVRiZHVkYkRsdm1ld2J6dXI2RjNHaGhyMTlTaFJoZGt2VFRO?=
 =?utf-8?B?SG8rUGpvQ2lCM3FRanY5UWNsM1VIRXBSRU5zcDdnakdvMEJsRllZZk54K2xz?=
 =?utf-8?B?cmVCU2t0amtYbkhMUldkWjNDWEhIRWRVYnFuTnk1OUdab09TdVdFZHdEQzNm?=
 =?utf-8?B?dkNoa21JQit3dlRJM21QeUlSNHFXY0wvcXdVVGp5dUsyNzJ4RE9xK0hReDRh?=
 =?utf-8?B?a1NCTGtkSS8wemRJK3BFa2tGN0w0bzNhL0pDZHdVM3JDUGJQL2poOC8rN3lD?=
 =?utf-8?B?amJKaWV2eUFJbndBSFZydE50b05IVFFXS0ZyLzc1YjNsRmpZa1hnb01MTE9l?=
 =?utf-8?B?cytuZFMyVVRJYzMvcVQxUVF6ak1ka1ZEMVJOTXYvQVZPVUNNMGhiOFdVNkdh?=
 =?utf-8?B?SUUzMUFrd1I3NE05ZVN5UDZtTkkzSDlUeVhjNDV1V0RlQkMwMGR4S0NOZGxQ?=
 =?utf-8?B?ZEZ1UVErMWJNUjY1dlVxZWZMSERBMUswV2ZoOVp1WkkzR1JNVmgxSnJkK0lZ?=
 =?utf-8?B?d29xUm9HVkpxYkdPVzl1R2VXMHNRRnFSQVBlQ2hYU3B5S3k1Z1p1d1BNRHh5?=
 =?utf-8?B?bktaZG1BUWJUanVpaVhUMXhoRnBFQlY1TFR2TXBFWlZuQ1plTTJvZzNNbkNL?=
 =?utf-8?B?Ulc2MnBPODBrZGJvbmMyZHBDaXRmc2J6MUkveGxIcEMrVkl4MjlVSDNQLzUw?=
 =?utf-8?B?STRZdS96Vzk1VjhGUCswbjVrWmdWVkNRV2puVkJ4UHFySUs4R3YrcldxeHh1?=
 =?utf-8?B?a0Nqa0d1dFg1MHNQM2paQk5CSDVOclg3SUFYMWR3dDZ1ZlBJbGpZTXRsQm45?=
 =?utf-8?B?NXdWZFZBUVljeENkcGZSbE1MUmYzTERqZE11eW9ISGc4dld5Z0VWZHhZY1hH?=
 =?utf-8?B?QkoyQmxoNTBFdlBFcHkrdEhHQ1l0Ky93b09NUmpOR3BFdzhlaGNOWEV0ZjJr?=
 =?utf-8?B?RXVJbDBvellXRjUvTjdVZjhCYWtlM251bTdSTEQ2N3Q1bXJWRXJaY0NVVUF1?=
 =?utf-8?B?N2hUS1FYWnRBWFNKUVhpRFdMc3lPYUR4aFpKVUx6MFNlVC9PbW1RK2hUQjB6?=
 =?utf-8?B?TjR1d0JiYUpERkFmOG1RQlc1ZEplczA5U2pBNW1QZWNnOXBKUGVWZ1J2aTZL?=
 =?utf-8?B?U0FtZVVHWk1iZ3JnMW9uRzVBbmFsUnp0NXIrQ0NTdjluUTV0OENNODB5YWEw?=
 =?utf-8?B?VGg1U1RZdTZFenRjUzgrOE9oMm9VQnZ5MU9tSEtYOUNlaXNUWjM3bjliakVz?=
 =?utf-8?B?TjJROXdjVWRMa2RpOE15eGdPVWpWdGozR1hJK3RMOEZaVXM2ZFRqMTBxb2pS?=
 =?utf-8?B?OGdidEJtRmw5Vi9oeDFreGRacGRWSnNrZ0djc2NkdExqYkFzY1liWENmL0VG?=
 =?utf-8?B?cllWMXZHdEpYK2hOd2ZJRzZGbkpNbEppZjJ5VVpxTllGVlBRbFdkY0F3QjNm?=
 =?utf-8?B?ZDhLQTI2aktPZk5MbllhdFMzQlhXVUlpRFZQbmR1WTV6WklwV2ZaTWtYQzBP?=
 =?utf-8?B?SzNHSllqL01LTnFyQTRNdFE0TVlmUko2bm1hZDgwUHpqdlNhQnN2U20rK0lQ?=
 =?utf-8?B?di9rU1B2Rit6WGhKdjEzb1daV2IrUGhwTmFUU1ZTVWsraE1CYml0eDJJeHV3?=
 =?utf-8?B?UVpkb3I0SXNIRnlpaDRlaTZIYUw0TmVJckpVVG5lMlpqQlBVTHJObXV2UGto?=
 =?utf-8?B?VXZwSFNFSTZUb01oczEyRFZSMngvNmZ0SjA4bE1RRHZqREZZSDJjak9qaGd6?=
 =?utf-8?B?TytjT2xjeGtSbmdVL0p3OVdmeG9lTVZPQitUNEFXSmpBdnJ4S3VBVGt6UDJq?=
 =?utf-8?B?N2U1eDViK05zZEp0ZGFtYkNwTE1sZ1YrazdvendOaGZUTTZaY1pNMWVEb2cv?=
 =?utf-8?Q?mQ/YB7iCFgPKhlR5gTvezzB25AGr2EhN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA1PR83MB0662.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXlaN3EwaW5SUk1NdS95U0xwUVdXMTNDQ1M5dnZZT1VVUGpCMXh6R0ZLa2lX?=
 =?utf-8?B?bUdYdVRhUytNY1dpbkwrOFZuYXM1ckZ4SUtNRGZ1ZFlLdzJSMWZUdTBYY21r?=
 =?utf-8?B?MnRRQ24xK1RHbHpmbVZ1VGZpVEdZelR6cTZ0UzdqQ2Z5bzVPVUM3anN4elRo?=
 =?utf-8?B?TDZ4aHBYOTMvTFg4NHQrVmQrUlJyMzdzYWhqUWxFSE9aMUhaeWVBNGxpUjFi?=
 =?utf-8?B?b1ZBVnMvdzRzUzByaVVqcks4SDdMNVdEL1dvWlA2VUZpYzNlRVhnN3pPeWpx?=
 =?utf-8?B?QWlSRVp0bjA5NjFmUWw5QWUwRnh1Nm1leWhFS0NZY1pNU1V1dDUybzNPbmdK?=
 =?utf-8?B?d1c1bUlrZFhvOGd5TmtuRE9CdnFuOFJoRlNJcDh6bnplbkNkTm9FMVVxdkVN?=
 =?utf-8?B?MGx2TDk5RW1DaGVHT0JsM2s0YzA5aGZOM2Z0U2NjcVZWdURuakoya0NzVjhR?=
 =?utf-8?B?bXVMbDVqdERYckZ0aTYyM3hPTWpOQnlUNlIyekxmK3dReGsvWkdyRi9LdlMr?=
 =?utf-8?B?SXpIbkxCaFRNMWpiamZEQU5meXZlRnlWS201aUorUGpCbXJYT3ZtQ3FRMmI0?=
 =?utf-8?B?T1Y1V3ZGbDUwam9yNUNKZldHYk12R2lEV0xsa0ZHVFlENUp0MDYvWGg4NHhF?=
 =?utf-8?B?MjR2ZXpjTUhOa3A5RjJjN2FMQU4yaGFGR0RYemhIbjdPVHhRMjV1dHpkZlQx?=
 =?utf-8?B?emkrQ2w0MG5uZHBXYWIzTVltRlIxZXhxVlArUW9hNEZrK3gvZ0ROR1pKTzF4?=
 =?utf-8?B?cktaU1lvYnNrVGFKY2x4RnF3YS9BNVhTSlRKY2F4UFB2eDVXUFgwa28ydzY4?=
 =?utf-8?B?V01hbkQ1aVE0R2dpM1N3MStKTUpPUHk0K3U2VWhPTTFucUh5LzB1K01QNzNV?=
 =?utf-8?B?QjQrMTk2d3l2SFI0dEhTUlpreVNkeVpPU3NoczNyRHR1N0F0Z3UyVnBFUVZ0?=
 =?utf-8?B?NWtBMy9tVm5tY0VzNnhQVFNKU3lYVFdQU2FUVzJ2ZCtzZXdEZzJWYmd0TXBE?=
 =?utf-8?B?OUk5VjdabDF6QXZWNkx4bGsyRDZZb3BzMy94dGlyVmxiSCtNUGhZR0laSzNV?=
 =?utf-8?B?V2VIQVRnYWpydjAyc2pGV1RCQ2pnRnpjSFJHZ2ZXT1hKWGVjcFU2c25UbXIv?=
 =?utf-8?B?TklSQkxhMUxMWGVTWlVrYUhzZ3dJMUtqcDJ2dTBqT2F1VDBrSEdOOHFlakt3?=
 =?utf-8?B?SUl3Q05tT3NFY2Ird1U0T2J5TUlEbFJlaWJtL0lLbG5QdDdFcUxyN2Nqdjdq?=
 =?utf-8?B?ZWdoWW1Jbno0K25RdHdLN0hPRU5wNnpOVG9SNkZSZWYwS1B0clNzRWZOdU52?=
 =?utf-8?B?aGxTQzAwNWpVTzJ6bzBVTEg4aTJqT3lhRHlmYko2K0tIaDBqaXhsTDhKZFBy?=
 =?utf-8?B?NU83czl6MmdxNksxdlBKeUVlNENWZmJjVWUzaDBIdVUvdWl0bHJ5dkRwYUxF?=
 =?utf-8?B?NjB1N2lZUGpYYmVPRk0xcWxNSTY5YlFqSFpBUDFrRm0xTFhTWW4vTG5ZSlFG?=
 =?utf-8?B?azM4L2RKblQ0Q2tkWDNaMlI5d0VFMmw4bGwzcmpMMVNuWktJQk96S0doYXoy?=
 =?utf-8?B?dWQyM0h6My9BeldXODJiV1F2WDBTVUNkOSt6Q2tnVjJsZ2xleXV2ZGRua2d6?=
 =?utf-8?B?cEFvaDBFS0VJOXZFZFkrNzBpVXFSbzBKOVkzcFV2M1phdVNpS1pNdjc3bEx3?=
 =?utf-8?B?NkJtUFFEWUJCYjQvb2RVQStsc2Y0bWE3cFNkWkg5SWpUZVh2QTU4M1ArdEdo?=
 =?utf-8?B?cGxHdTZYajVpbVJZZHErT0Q1V3JQUlVDT0lKQ1FrSExsWEFBcDdQNEg0MXM4?=
 =?utf-8?B?MjBaektGSDZ1NE9SVHdqNjczUmp5eFFCN2NOUm1wU1dwYWR0NUoyL29leWRu?=
 =?utf-8?B?bmZsOEhMMzNieldIVXp4cDFWZ1VkL21WdFM5bThrSzBmK1FwWHduSXA3NndK?=
 =?utf-8?B?dnpJOEJ5eDFmKy9Lb2tYSjRkbUhaV09iQ1dBdDRrck5MQ1RyOGpxU0tqeGhh?=
 =?utf-8?B?Z0Vqb01TVWtMcDNmOGRmMkJ5YkxNMVBjblBSMlVNOWJ6ZXVOUFVYY0F6MUZ5?=
 =?utf-8?Q?ZTAHhq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA1PR83MB0662.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f508ed68-7d8e-46ab-203a-08dd60844b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 10:05:47.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6PJIN2r4W+A6jdmM5CvnQ16esaw55mahe1nje1qO/Mys8W1LwcvHD1Xh4ISNpSsEeFKvNQeFQNZYu4+beQ8Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR83MB0546

PiA+IFN1YmplY3Q6IFtQQVRDSCByZG1hLW5leHQgMS8xXSBSRE1BL21hbmFfaWI6IEZpeCBpbnRl
Z2VyIG92ZXJmbG93DQo+ID4gZHVyaW5nIHF1ZXVlIGNyZWF0aW9uDQo+ID4NCj4gPiBGcm9tOiBL
b25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+DQo+ID4gVXNl
IHNpemVfdCBpbnN0ZWFkIG9mIHUzMiBpbiBoZWxwZXJzIGZvciBxdWV1ZSBjcmVhdGlvbnMgdG8g
ZGV0ZWN0DQo+ID4gb3ZlcmZsb3cgb2YgcXVldWUgc2l6ZS4gVGhlIHF1ZXVlIHNpemUgY2Fubm90
IGV4Y2VlZCBzaXplIG9mIHUzMi4NCj4gPg0KPiA+IEZpeGVzOiBiZDRlZTcwMDg3MGEgKCJSRE1B
L21hbmFfaWI6IFVEL0dTSSBRUCBjcmVhdGlvbiBmb3Iga2VybmVsIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jICAgICAgfCAgOSArKysrKy0t
LS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jICAgIHwgMTUgKysrKysr
KysrKysrKy0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaCB8ICA0
ICsrLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvcXAuYyAgICAgIHwgMTEgKysr
KysrLS0tLS0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFu
YS9jcS5jDQo+ID4gYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jIGluZGV4IDVjMzI1
ZWYuLjA3Yjk3ZGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEv
Y3EuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiBAQCAt
MTgsNyArMTgsNyBAQCBpbnQgbWFuYV9pYl9jcmVhdGVfY3Eoc3RydWN0IGliX2NxICppYmNxLCBj
b25zdA0KPiA+IHN0cnVjdCBpYl9jcV9pbml0X2F0dHIgKmF0dHIsDQo+ID4gIAlzdHJ1Y3QgZ2Rt
YV9jb250ZXh0ICpnYzsNCj4gPiAgCWJvb2wgaXNfcm5pY19jcTsNCj4gPiAgCXUzMiBkb29yYmVs
bDsNCj4gPiAtCXUzMiBidWZfc2l6ZTsNCj4gPiArCXNpemVfdCBidWZfc2l6ZTsNCj4gPiAgCWlu
dCBlcnI7DQo+ID4NCj4gPiAgCW1kZXYgPSBjb250YWluZXJfb2YoaWJkZXYsIHN0cnVjdCBtYW5h
X2liX2RldiwgaWJfZGV2KTsgQEAgLTQ1LDcNCj4gPiArNDUsOCBAQCBpbnQgbWFuYV9pYl9jcmVh
dGVfY3Eoc3RydWN0IGliX2NxICppYmNxLCBjb25zdCBzdHJ1Y3QNCj4gPiAraWJfY3FfaW5pdF9h
dHRyDQo+ID4gKmF0dHIsDQo+ID4gIAkJfQ0KPiA+DQo+ID4gIAkJY3EtPmNxZSA9IGF0dHItPmNx
ZTsNCj4gPiAtCQllcnIgPSBtYW5hX2liX2NyZWF0ZV9xdWV1ZShtZGV2LCB1Y21kLmJ1Zl9hZGRy
LCBjcS0+Y3FlDQo+ICoNCj4gPiBDT01QX0VOVFJZX1NJWkUsDQo+ID4gKwkJYnVmX3NpemUgPSAo
c2l6ZV90KWNxLT5jcWUgKiBDT01QX0VOVFJZX1NJWkU7DQo+ID4gKwkJZXJyID0gbWFuYV9pYl9j
cmVhdGVfcXVldWUobWRldiwgdWNtZC5idWZfYWRkciwgYnVmX3NpemUsDQo+ID4gIAkJCQkJICAg
JmNxLT5xdWV1ZSk7DQo+ID4gIAkJaWYgKGVycikgew0KPiA+ICAJCQlpYmRldl9kYmcoaWJkZXYs
ICJGYWlsZWQgdG8gY3JlYXRlIHF1ZXVlIGZvciBjcmVhdGUNCj4gY3EsICVkXG4iLA0KPiA+IGVy
cik7IEBAIC01Nyw4ICs1OCw4IEBAIGludCBtYW5hX2liX2NyZWF0ZV9jcShzdHJ1Y3QgaWJfY3Eg
KmliY3EsDQo+ID4gY29uc3Qgc3RydWN0IGliX2NxX2luaXRfYXR0ciAqYXR0ciwNCj4gPiAgCQlk
b29yYmVsbCA9IG1hbmFfdWNvbnRleHQtPmRvb3JiZWxsOw0KPiA+ICAJfSBlbHNlIHsNCj4gPiAg
CQlpc19ybmljX2NxID0gdHJ1ZTsNCj4gPiAtCQlidWZfc2l6ZSA9IE1BTkFfUEFHRV9BTElHTihy
b3VuZHVwX3Bvd19vZl90d28oYXR0ci0NCj4gPmNxZQ0KPiA+ICogQ09NUF9FTlRSWV9TSVpFKSk7
DQo+ID4gLQkJY3EtPmNxZSA9IGJ1Zl9zaXplIC8gQ09NUF9FTlRSWV9TSVpFOw0KPiA+ICsJCWNx
LT5jcWUgPSBhdHRyLT5jcWU7DQo+ID4gKwkJYnVmX3NpemUgPQ0KPiA+IE1BTkFfUEFHRV9BTElH
Tihyb3VuZHVwX3Bvd19vZl90d28oKHNpemVfdClhdHRyLT5jcWUgKg0KPiA+ICtDT01QX0VOVFJZ
X1NJWkUpKTsNCj4gDQo+IFdoeSBub3QgZG8gYSBjaGVjayBsaWtlOg0KPiBJZiAoYXR0ci0+Y3Fl
ID4gVTMyX01BWC9DT01QX0VOVFJZX1NJWkUpDQo+IAlyZXR1cm4gLUVJTlZBTDsNCj4gDQo+IEFu
ZCB5b3UgZG9u4oCZdCBuZWVkIHRvIGNoZWNrIHRoZW0gaW4gbWFuYV9pYl9jcmVhdGVfa2VybmVs
X3F1ZXVlKCkgYW5kDQo+IG1hbmFfaWJfY3JlYXRlX3F1ZXVlKCkuDQo+IA0KDQpZZXMsIEkgd2Fz
IGluaXRpYWxseSB0aGlua2luZyBhYm91dCB0aGUgc21hbGwgZml4IGFzIHlvdSBwcm9wb3NlZCBh
bmQgdGhlbiBlbmRlZCB1cA0KYWRkaW5nIGNoZWNrcyB0byBhbGwgcGF0aHMuIEFzIEkgc2VlIHRo
ZSBzYW1lIGNhbiBoYXBwZW4gaWYgYSB1c2VyIGFza3MgZm9yIGEgbGFyZ2UgV1Egb2YgUkMuDQpJ
IGJlbGlldmUgYSBrZXJuZWwgY2xpZW50IGNhbiBhbHNvIGNhdXNlIHRoaXMgb3ZlcmZsb3cuIFdl
IHBsYW4gdG8gYWRkIGtlcm5lbCBSQyBzb29uIGFuZCwNCmFzIGZhciBhcyBJIHVuZGVyc3RhbmQs
IGEga2VybmVsIHVzZXIgY2FuIGFsc28gYXNrIHRvIGNyZWF0ZSBhIGxhcmdlIENRIHJlc3VsdGlu
ZyBpbiBzaW1pbGFyIG92ZXJmbG93Lg0KDQotIEtvbnN0YW50aW4NCg==

