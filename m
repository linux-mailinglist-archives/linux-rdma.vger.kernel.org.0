Return-Path: <linux-rdma+bounces-4859-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FD973859
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3E92831D6
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B832D192D9B;
	Tue, 10 Sep 2024 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Wo1QsVvz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020087.outbound.protection.outlook.com [52.101.85.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59782192D71;
	Tue, 10 Sep 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973937; cv=fail; b=UObwN3HDW7nvXhCEwOg+kOfxs+R4usSE6XK1Z3gsUUe8Y4CG3nY/tvzPbd6voo5Tv2Gz1687XTUWvZgZLdu2WERChEgp8XwWpe9YHn3dAOfGzUvW7a0seo2JMcqdszpeHCcIuPm03Qsc6Jvsvl8IudPnvAF72RCFyucq/w1nZ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973937; c=relaxed/simple;
	bh=ZwKEXv/n0aKsj91SO53tCXjRP/gpf05NI4PT2RyXn58=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kpDbWgnxDI5DILKYU/+etrM9q+Hpc5LLNfZgLOZviGJFqc1wwoWwAHLk16Q9K6Yi4Afesf4WbRKxAz3EQuAuSP7KSveNKeg/NKrC1qBug8xS+D4A5dJawK+68q5+oauxsOWDSJUng1ftK76bj5gjN7NCsWupz3UkP06a0Mu32g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Wo1QsVvz; arc=fail smtp.client-ip=52.101.85.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFRKAkDLUPzTQrY05bOACdH2kOmXqFMZPvlMLh5bs4hvRF3L/0BZZf+G7Tf9lD6gLPVWIYUhRg3MDoG6v6Is2rRyz1I4VqXZfRkkp1RlHkgMY4+MoibY/qmTzOXRN5Ma35lYN19vR1glb6vmVB3YdYm/0R1a1h+tPimXDViBqRAOj95g5n69PWgqKSDBleFRzTEugFg1/OH5iz6MhWwcMiKty9c3EkVg9ldHBcxCGxNbUFWmMP9HCtxcvmZE46Pt9CG5O57VtE+qjToGJLhSVsRU6jwPdwGs4rcwy8dZzRJhZ3BNo1KXmDXxIbaTkqdd8lfpqhEMVFHq+S0Hbu35mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwKEXv/n0aKsj91SO53tCXjRP/gpf05NI4PT2RyXn58=;
 b=JaGeEijWbFcLUnSk034+N4roNNRCoy3pgO6n3umWFFaOPqMEOceSciYv/qeuqMrjFuSfvqUXUb7RE5uZujPGqNQ8XPyifSD/Ioo7KuJJhQ4ftrP52+JUxI1bgRwUCA2d7wqih1IYc/vB/wZxH8V+D0NA5L5dAmfiMNlfQJloZ2tKcUHJUvT27UKYciRP/AJ2qQMdsrWcb+ECl3Cn0QZIfWXsV56bZ6Jzc4zRTPlRCaVuraAhvVJ7o5VpzKQ7iuhR894b7aFxTntr+R+qQOUvbsihtEX2UqP8Kz7SUx4/a48jjmnJAVM86WrWpz67MNXfdaI3Lh/n1OoD1PO5kXB8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwKEXv/n0aKsj91SO53tCXjRP/gpf05NI4PT2RyXn58=;
 b=Wo1QsVvz+4h8Iscja/t+5NotZJFFFk015WWkPrlHrqUFhjduFtaqSqyPJn5zagV3+PpeoGgY6ooqclg3Q5Z8kB5d2EyFF3JLeZT9skrYIkWAbUltYxl471S/sEoIVNDRLpXJXg81fy8M1HemHn6xImbuMPk3gZgy25zi7t4F/ZwohMSjvkyyIKwIwQM0a3e6Yj94g2O6Usv31tAFDrUXTXpE+G6zDQbP1/QGrTOBkdTXuorbF1Kg0oz3nqje1pB8lZ7j+R/p0yLK2rXOovl23nRe0UJd7ascmNdU5UBVF9zodDlXRlmxY72BRP54PSMN3+nvZQ8fVe7ft1f1g/hWvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CH5PR01MB9055.prod.exchangelabs.com (2603:10b6:610:211::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Tue, 10 Sep 2024 13:12:10 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:12:09 +0000
Message-ID: <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
Date: Tue, 10 Sep 2024 08:12:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
From: Doug Miller <doug.miller@cornelisnetworks.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>
Cc: "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
Content-Language: en-US
In-Reply-To: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CH5PR01MB9055:EE_
X-MS-Office365-Filtering-Correlation-Id: 078033e5-30fb-40a8-cde9-08dcd19a2d43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2w2c1N2V3dMMnZ0RU9yd1Z2TW1LdHVsdmM5THJTTDQ2aDhjTkxLd3Rod3dG?=
 =?utf-8?B?TVJVb0wraCtnTElmaHBrTnlsczh5RzMrUVM5ZlRCYjZxSnZFN09xR25qcWwr?=
 =?utf-8?B?blpwdTd2MnB6Nkg5Nmg5alNLS0RLdlRoWHUxWGpreENYSGFYUmFLTnVLaTNp?=
 =?utf-8?B?NDY0dzJYTDJBQkZwZ3pBakEyTnJhR3U5bnVDR01uZjgxU2lWL25vakYzMFBB?=
 =?utf-8?B?R3ZLbUJTMk82WDBydjE4ZE5nMVh6c2xWOE51WDdFUzdEK0xIOVhTVzRBb2lp?=
 =?utf-8?B?QXUwTWtMZkNKQ3YybWxPWnVTem8rNnRPZHVIWWRLalQxajBRN1BtZGpFVjdt?=
 =?utf-8?B?Y28xSEM3MmZ1N3dERWYyVkhJUXllcUlER3VidmhNdTV1ZytCRWk5eW5qd2My?=
 =?utf-8?B?VUVYVFVkOXlXNW1lM0psYS9xK0VSZWFOV1dNNGo2SEgxcHpsejJoZ05xNlJx?=
 =?utf-8?B?UzZGQ3JtRWtIMXJVUXVaMUZJR3llVUFDUXN0NmFXak4rTFZTeUVWU21TWHRY?=
 =?utf-8?B?M3Y5L1dGU1dHcFduR0d5TDZIYlRRdXlOdkdua3J5Y2pQNzkxQko3UFRML1Vm?=
 =?utf-8?B?S0pBVEl3dGp3b2FBcStrUXJwaG9MRUtiMkJWSFRyUnRSTDZhQkd5ajJvTGZl?=
 =?utf-8?B?dXFMSTNxeWpVcnVVUEkxZ0dFSHkwV1J6WmlMbmtnQitPWlp5MHVqeVN4SnE4?=
 =?utf-8?B?Tml2a1YvbDEyTVRLeDZNUU1CL3BLeG0wRmlVd2ZCblI4TUM3bXlJZ3JBcHdt?=
 =?utf-8?B?alhrd09TTXBDWk1xbythaDZsVy9QbjVxS1MzYzF1S3lnY1B0d3RzZGVKcHMz?=
 =?utf-8?B?cTZ5eVpMT0NidC9keXo0L3hiUEpIU09pR3BIY1FpbFc4aHR2TWtoN0k2U21L?=
 =?utf-8?B?Mm5PQ0M4T3kxVGxjbno5WExwNnp6YXRWNGhLZkJNVEJJUEF0dDdPcUR5V0F6?=
 =?utf-8?B?bVhBdnFCMWpMa2cxdzR1U0t3Mm41MTdBcFdXajdwZHRuUG1nR2pCT0xISmRt?=
 =?utf-8?B?UmFJSTVHQmhhL04rdE95Nk9hOFJQSDN3US9MOHplbGJnTWNzZTZvRXEyNGR6?=
 =?utf-8?B?SDMvZWdyVTQ1cFVzVy9nRUowNFU0VFAxTzRUa2xrekV4dEpHOTQ2a0xDWWxT?=
 =?utf-8?B?eVR5WDJBT0gwOFh0aXNPQ1NGbXQvTnd4OXo0MFp1a0loTVdCdm1oeEF2OUt3?=
 =?utf-8?B?a0ovZWlmbmpLOGcrZm1xcU8ycndRRWlJeWRqelhGQjNUVGZtVkJITk42RTdD?=
 =?utf-8?B?YkRxY3VuamNRRTFRU3pZcEZWQWpRRVlnTEQvOFc1eTVDdHA1QmRCVHQwVzJ0?=
 =?utf-8?B?aFJoNmR0Y052WjRJRVJod2F2MzFDTlI3QUZObG9KaTZ6Y1RKTWZFc0lJbGRk?=
 =?utf-8?B?N29TbS9wdks5VDF3akM0aUZrYWxuRktPUEo1TCtVWURPR3o0OG1GcVY1b2Y2?=
 =?utf-8?B?T0pWd1VFb1luQUFubmU4a1cwWjk0Q2t1NGlkNC9ZaHVMallsNHNMTVlwWnMv?=
 =?utf-8?B?TTYzNTBJb3c5dEU2Ump5T1pGaGNlaXpXdXBNU1J3T2xwdjkrOVF4YlN1cFVo?=
 =?utf-8?B?QUg2OW4yOTlaQWQ1bVBKYzZoTEdGZ3FvVlVCb1J2ZkhodWppbnk3UHYyV2Z2?=
 =?utf-8?B?OHBwa1FUeWhpdnJ3Z3dvNjEvcFdiRlp0OTlJdlFKVlVpQTlHNkxqNHpKVjcx?=
 =?utf-8?B?Q0dsK2kza2lhNWZMN0EzVWdrY1ZzOVRRLy9qRFlGRE40S2R3SlJyQWRkRjR3?=
 =?utf-8?B?c0k4WVlWNjB2WFdkVEhGa1p2dUkxdFNXUzF5cmRaSThOSVY5b2tSQzg1QmR2?=
 =?utf-8?B?SmthSmY0WXRnOWJxTWJQZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3pqNk04T3d2OFBJcDVsaWRPQ3J1OW5Fb1RYc0t3MzFhUC8wa0NPTnZORTVq?=
 =?utf-8?B?azREQStlc28wbVpsMDA2alZQTEMzTjFRNHFmRGg2MGorTmd6TnZUd3h0eDJi?=
 =?utf-8?B?N1Z5dEUybWh6TThEdHRNREEyQ0s2SVBUT1R4MzdLNW51dTlkRnkyNFpNQytE?=
 =?utf-8?B?TjlSemxFNUl1dHJzMzZRaWVNVWZUMk1rRlJtWFgxczh0N2QzUjdySXhpYVkr?=
 =?utf-8?B?UUlWeUtKMm5lZkR1U2hrUyt1YmpzcFJtT1dhc2N3MUFzbE56VG4rdFFDWW9w?=
 =?utf-8?B?aUdxSUd6cWxPR3R5Rm5KYmhkRmExQnlkTTRWMFJ2Z3pvU3ZQU1FXdWJlQXQ2?=
 =?utf-8?B?UC9nTkpxZlRFTGZFZVZZTGhOcmhUaElKV0MwZXhCKzBYUlpGZEFsRko3VTJD?=
 =?utf-8?B?WlBtdWxYa3NEUStGeGNneGZOQWZxMHVscXpLdXlIYU4rTVVkM0lGTjI1ZVBR?=
 =?utf-8?B?MWZUelU3cW5wQWN1d1QvVVJPcFMrSDlkRVk0T1d2Z2ppb0p2VDJCSU5yOHlJ?=
 =?utf-8?B?OUdpeWJBWno5ZEJGU1B1K3JSL05zU2o0Mzl1VklSZjZIQXVVeWhiZEFWM3hj?=
 =?utf-8?B?VC9zb1J4WU8wME9FQlVub3lOcGFnZVdxY0NUSFRIa3pqUjlNRWROblpOd2Jk?=
 =?utf-8?B?d3ZVQkRkd0JvdzJ0UUhBK3RTZ1VwUFdoMDVCU3RhYjk1empBS2VMKzVKSHBS?=
 =?utf-8?B?amxLbnBwS2RNRUZ1aEZ4OTNwVHM0bUErczFYU3FLbVdUcC95Vm9TRFZzRjVo?=
 =?utf-8?B?ejl4VEtabFA0SkVYMlpONCt2Q0FlYmJkVUdDV1J6c1dGdVY1NTBFVFJKc2c1?=
 =?utf-8?B?bVdwdCtuVXpuNjMzd3FDSnd6d1Q0MlBnUjljV0hDd1EwU0hmZVlualZ5Z2dm?=
 =?utf-8?B?Q0hrWGVJYjlTK0hna24zS2ZOZHBzZGJ0RGplZmYzbVRETSt0SVg2VGF3b0VU?=
 =?utf-8?B?YW5qdkVMd1ZJaTRmTW9YWHhzMTdTaGxsQUwwS0hKeDJhOWNVYklWL2JkVmJi?=
 =?utf-8?B?YkVzYnlId2pHQ2c2bHpLaEFpdUdjSnF4WVV1ckNwNDQ2RkNYbGNoTVRjTVZw?=
 =?utf-8?B?MUZHMWJBRDFJM21TZjlybVMyelF0WHlZbUdhODgzM1NsWGFKZFFCbzUrYmZS?=
 =?utf-8?B?THNnZEE5ckcyZk9xMEVkNWFFSnN4Q0NGNnBja0VIOSsyWmJ4aHEzVnltNVZK?=
 =?utf-8?B?dVNhc21iYnVSaHBXUllYeFl4WTlobnIxMVlSNHh5REtNeWFLcHpsazFLSGx3?=
 =?utf-8?B?TnoxbC9kRld0UnZSS1R5cWJjdFRDMHlYdk8yc3Jua1hKdTBhSVhlcDBoVE1a?=
 =?utf-8?B?SzhwVUJMSUlqaDBUMDQyN3cwUlo4S29hWGdIbnhHQmN1OXppOHV0ak94eWFP?=
 =?utf-8?B?TnQyVzZhRDBibDlLcVUyK0pWN0swNFJEbTJsQmp4MEpZNG44eExRbVltakJK?=
 =?utf-8?B?dDdZbFltbWkxajQyR050ZXFod1lEWHpVdU9QUEFETUVTRTVCN3E4SHRXd2dq?=
 =?utf-8?B?UXErVDdaY2ZtMmphQkdBQWNVbThFYlY1eWtyT0hNdG1vbUt6eDJna0Rpc3I5?=
 =?utf-8?B?bEJTdENhcklYTU1CT1BlY21JanduZ1V5ZVdZOWdMNXJOY2FrUnA5M05nSDZF?=
 =?utf-8?B?bksvck1mZmRWeDJobVh4SFpqdFFVRWQ3c1oxRWx2SmN4M21pKzk2eGdiLzg0?=
 =?utf-8?B?UVkvcGxNQU5QSitEaE1PQW9OVGp4T0haVVhjMEQycG81dUR1UWpGbHQ0d05H?=
 =?utf-8?B?UHlHME9uVWQ5aGxtSDd0SHhvTk5CMWNWWGRFcVJLN1VjN1E5bWdleEx4WEcv?=
 =?utf-8?B?MU9jaGlEbVFhT2NZb1djYzJaY2hPeGlvdWxQdGZrNjY4L2NEVHdacGlYUGlF?=
 =?utf-8?B?d1dlcFIzQkR3Y3pkYUY0aUtJSlppQkt3UmFrRHloTndFQVBMQmMzZzZ3QWsv?=
 =?utf-8?B?UlR2MWNzSE5nT1lBVFJJU082SURIaEFjOFIxTktBYmtFd1h1ZW9lRFhUbGdn?=
 =?utf-8?B?RzFNSmpSSlFLbXJmSVQrN2pSQURKZ0RYMnFWbGErK0thTmtmV3QzTUFhcDR6?=
 =?utf-8?B?VHI5ZG14WXdVMkdtaDFRYW0wem4rWGN2cHZnTnUyVDZodGdjNHZBYXQvZ3VD?=
 =?utf-8?B?eWVGSE9KVFJqU2RxcGxFbFFET2g4WkFQMUtNazZlelo4L0NsYnFMUjczVWRU?=
 =?utf-8?Q?XlKR4aeYbO3TbLpn+0Jfxdo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078033e5-30fb-40a8-cde9-08dcd19a2d43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:12:09.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /NzjdmLHUrx73wqGj2ADSS1QgAGW7z1VWJvD95R1yqmZ1N/+0zpztDJSDdp9uq1b67XqcF8yOIFwcJy2osKz+BkPaho7r/jZUPIc8De8Oy489iuTFqFJDpGjyaV3D3Z+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB9055

On 9/3/2024 10:52 AM, Doug Miller wrote:
> I am trying to learn how to create an RPMSG-over-VIRTIO device
> (service) in order to perform communication between a host driver and
> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
> well documented and there is a good example (starting point, at least)
> in samples/rpmsg/rpmsg_client_sample.c.
>
> I see that I can create an endpoint (struct rpmsg_endpoint) using
> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
> the rpmsg_rx_cb_t cb to perform the communications. However, this
> requires a struct rpmsg_device and it is not clear just how to get one
> that is suitable for this purpose.
>
> It appears that one or both of rpmsg_create_channel() and
> rpmsg_register_device() are needed in order to obtain a device for the
> specific host-guest communications channel. At some point, a "root"
> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
> subdevices can be created for each host-guest pair.
>
> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
> to get things setup but that does not result in creation of any "root"
> rpmsg-over-virtio device. Presumably, any such device would have to be
> setup to use a specific range of addresses and also be tied to
> virtio_rpmsg_bus to ensure that virtio is used.
>
> It is also not clear if/how register_rpmsg_driver() will be required
> on the rpmsg driver side, even though the sample code does not use it.
>
> So, first questions are:
>
> * Am I looking at the correct interfaces in order to create the host
> rpmsg device side?
> * What needs to be done to get a "root" rpmsg-over-virtio device
> created (if required)?
> * How is a rpmsg-over-virtio device created for each host-guest driver
> pair, for use with rpmsg_create_ept()?
> * Does the guest side (rpmsg driver) require any special handling to
> plug-in to the host driver (rpmsg device) side? Aside from using the
> correct addresses to match device side.

It looks to me as though the virtio_rpmsg_bus module can create a
"rpmsg_ctl" device, which could be used to create channels from which
endpoints could be created. However, when I load the virtio_rpmsg_bus,
rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device created
(this is running in the host OS, before any VMs are created/run).

Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
need to be taken to cause a "rpmsg_ctl" device to be created? What
method would be used (in a kernel driver) to get a pointer to the
"rpmsg_ctl" device, for use with rpmsg_create_channel()?

>
> Thanks,
> Doug
>

External recipient

