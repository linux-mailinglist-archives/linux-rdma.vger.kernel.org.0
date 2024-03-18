Return-Path: <linux-rdma+bounces-1475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E787E5D3
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 10:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B03B22035
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Mar 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D212D042;
	Mon, 18 Mar 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RBwlGAWY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2115.outbound.protection.outlook.com [40.107.105.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A8B2CCA7;
	Mon, 18 Mar 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754304; cv=fail; b=bANzv+XV0hPCiR0YEZsjocw2AiorYlyyzmOPEcLSFYAR5qvD+FGc6JPfHgxidKbMBEs6jdB+J9jRLpqQEgPO8eVBTz4YnQWmUKuvibG+nj5XkjmATcM1GRoCaVp2rtrZsoj46YKknZoHSa/NCjrbE3w+hXj3TgEZbwx3b2VemJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754304; c=relaxed/simple;
	bh=fcf5oMlm/SHkuPG6qc6Q7K5LboQwMWzxp2uBnrThNdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1GWiZKPEgLZ2qNGHYlWpsRB/z3g6CT+RjvLvigJeCLBp9t9suIb+IYOVJj1H5d6YQlAZpVgUMBhEsJK56iqD8Mb7Vv0Z51ey0ovGDsnn/Akt/Ms5aCeeD3Hr8dsnPzve3/DmzZwXZnFdddZ5vbhnZJBgiVwQ0X8DQmLBAfyLls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RBwlGAWY; arc=fail smtp.client-ip=40.107.105.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAX/h+fw+oraFTw0Nu8FH8LX76TYwY8aWH33ra0UlCmXHtFe6McyqefvadUFTVIDU3+A9mNc2YV1JhMrITMDAdEeMfn3I4WzwRnfQf8j7atHPCMG9iv4YLqlWUI+MFgQMVhvGucIsS6iXhdhxsZ864lH4M/svCmqr5gWlifvVumtmB8kbKnfBO1qZJtDLMos9Hb8AIcifaYIq13K2U3Z/MfCidXKKJ973P6WROYqJveqpi9kjuQXY1cLBlVmjts7djYUqMVP3BvHxyGTfCYtAcBTxy1fbGeWcW3QOmyPMVAzDtnNfRFOdvY8S/a91cG1zHjCk10S9yok5eWBi5VhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcf5oMlm/SHkuPG6qc6Q7K5LboQwMWzxp2uBnrThNdk=;
 b=H7bXceEoFC4M3C/bNer3INtAs8e3ZBChm+YmBFD4YHb3PvIRyo5qxcAVHm996zbv5sH8XIF6Ec6xtOhVJMaA+r4s4gfugMHtauV6FB30zkXVmgLrBZrSFbt9uyaTBxrM4OCXO0v+v8p1ZEWfJ223mr8c+wGw5h7M9BhfgbqC9dvS2I+A1fqI7fW7QzIJFdcYdUU7C0XQmPLSHZrUO6yZOfZ4GwoGXAFTIE4RInu/bsscyjVDWD5600KhjSj7ydNglMq8F/1DEiG+AfNSt9DQSU0pM3uJO6jNR2FcQHgPTgkwgS4twxS5+WbsJ/xFZUtt1cQ02gBRrdHP9B51zkx1IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcf5oMlm/SHkuPG6qc6Q7K5LboQwMWzxp2uBnrThNdk=;
 b=RBwlGAWY01E9PA/7tV2dVUIy14G9dpPjJ7gHBwafD+/+dtP4+Njz/6r8mToPU9ewc8CVQ3WztFh4PwU7Uvt5YQsbZbPYCfVng7pQzZvktyVv/quArqC5qYYAeHrDw2j4zBymfpYS7xHdZc7oSuoURfYL5qnG6FZKkWyj0GrRGRU=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by DU0PR83MB0553.EURPRD83.prod.outlook.com (2603:10a6:10:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Mon, 18 Mar
 2024 09:31:38 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7409.010; Mon, 18 Mar 2024
 09:31:38 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce
 helpers to create and destroy mana queues
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce
 helpers to create and destroy mana queues
Thread-Index: AQHadUnfQBQJ0tyxLUmNQWQV4RJbw7E7ggqAgAG+8pA=
Date: Mon, 18 Mar 2024 09:31:37 +0000
Message-ID:
 <PAXPR83MB0557CAF749EE4161E3EE5A31B42D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
 <7956dd4b-3002-4073-aff7-f85ea436e6e0@linux.dev>
In-Reply-To: <7956dd4b-3002-4073-aff7-f85ea436e6e0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a786e0e-cae7-4524-b49d-73bab460036d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-18T09:22:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|DU0PR83MB0553:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5ew47zgRulVl71hSwx2E46+XyTvrn4K80/wohJ4GtonTGITVqMXD9tZEZGEAmNf0waxBjVvX/8AU5r04GuCaJh7yr8h0RnNkuAKbboxYnn1jbTPwZEb9qWng2Mgwxxvksep6iwUE2aBTpEJoENpLAcpckO6swZ9p7unrx0E3MgSdsFFv0PYHMXqSX7Fm3jYanPPunzMGbctfxNaJ+Ce4IxLCWA9Ns+/FQoLpziNUbuC2mQWemk7nozEpYYpB1LCc6inOn+7EWZhoadYN5mCe5MVmJfqBwhctjPnDeeS0tz+Wnmd6/W7jV5smX19vkfekXodHPxUlkZnUCOCcoPthGjMuu43Bd35pvkhI/YYu4/jUAAicT4YYg1otBplFJO4IiD+AJ4zJk/XYtAzpmgUWuOtkCUK6WUdxNNw5vmy1X8DeEcrEzbP+aGHg5wwycHGdGb6Aba8gB26QWii2PnfOhSZP19A9GUIYoJVTAMZ0cOCb4JcqtWEdIF6elRH8DDaFEeeZUtlCbpulZkhC3V8bkJy8knSGn39pT6TCecuvtLGpTBjKdvuDPovWkIqIc0jxxY47RK3aejswBtvNyw+FRSeu8TbOdJ3/coAmWCg0CAPrc0LF/+9PLJGigoSm4AP1Iba6sfDsZi5ov5DPOViiM/THx2+lJ0fa72qe+45reto=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEZVUzlpQ0JmTWNLTVczNllENWdxT1dHY25iMy9QM3VuSXBWa01nZUpiVEpl?=
 =?utf-8?B?UjM5T2REL1g5N1FmSTVjcXJLUFFjWmJ1Q2FsTklVeGpRVzVGMlcwTHlFSE0v?=
 =?utf-8?B?T2QrdHAyak9OckVrSFdrRldGMytHeGN0RERWaElqY1lQV1hIMU5tQ2lrTm1C?=
 =?utf-8?B?TFk3SGgrUytXbXV4Z2FPOGhNbWc5UjF3UU1zdExzeS84ME5jSnFvNTZCM3dC?=
 =?utf-8?B?N3V6QUJtK1gvcGJMYTUvNXVIRzAxcHJXb0s5YVRNQVRRbVc3OVpVanpnVS9G?=
 =?utf-8?B?UVlTYm9BWWdpb1Jnc0lQWUQ3cVVjdU9zUktUWGI5T0k0SUI3MHVNbmdBeHh0?=
 =?utf-8?B?c3VvUFIwNDF2azNiWTlnYTZuaElvMzY1Z2s5YTdjVlgyKzBlMEpsUGVPTnRQ?=
 =?utf-8?B?cnRjYWxQVDZFY3dLQlFNSmtxQzJNckk0RjRIM2ZRUTlvZDBMb2krbDdCUW1h?=
 =?utf-8?B?SVplUEE3KzU5ZkNwYW9GTlY3VVZoWVVjN1gvNk85WHNyUTM2c0xqcDh2MFRD?=
 =?utf-8?B?QkJPSmNQVGRYRHRIeG9GcmUrT1BqZjJKcnV1Z29aSDdhVDRMeGlXMEtxajN4?=
 =?utf-8?B?ZWZLYzZPdlBRK1Z3V0R2RGhIVnVaWWxkUkk2VUZ6VjROeGJBcGE3bmhBclJG?=
 =?utf-8?B?RDB3S09mcUdmSUdQT1RRV3daSGNWZTg2ckhkbkdUM0Mrd2xkSEhTT3NLNWg4?=
 =?utf-8?B?RXViN1ZHc1ZMeW8weFdubWlyZmRPMHR6TThCM0Z5S09STHFGRlBNRk1LVjFa?=
 =?utf-8?B?NHNJSFo1QkJlSVEwZ056ZTRNejhHK2lqTGFsS1lyK2V4TnZoM2RUOUk1em9m?=
 =?utf-8?B?SFV4YU1UOWI2WUZ2U0VqYWNlakd5dm83ZEw1eFVzTGZmeDNDMEZId0ZRcktB?=
 =?utf-8?B?R3h3ekdJcWxreVpTN0crUWRyVmpCQWkvVWYwU0N3YVZrck5jSkQ1bnJtcThk?=
 =?utf-8?B?czZXRDgweXE2MmVqMlphalAzRFhwaVk1ZElEQU41WFNnOVNtN0UrbzBNZTEx?=
 =?utf-8?B?cUVabVRidXFGM0JNUitGcndKQXlIVERobHI4aVdpZ0EwQkIvbGZxN3ErWkk2?=
 =?utf-8?B?Tlg4bCtMZkdCeG1Lb0E4UW9QTmRQQ0lXbC9SVFB3Q01OdkRVWVR5Q2pVU1pj?=
 =?utf-8?B?TGlwQXBCUDMzZktQa2xLNlRnVUQyS09KZjRVaWYxZVkrOGZQdmRVY0s1K1pW?=
 =?utf-8?B?eURRY0dvYmpVMFhsejJzK0o5c000RzV2VXFtN2VoVVRiMGNKV2tYdnNocVk2?=
 =?utf-8?B?QmZWRkI1TjQxQ0xaSFczQnVUaW9nVklha2o4VlpXNi9xYUZBZHVic0lBMnhF?=
 =?utf-8?B?VjBtczUrS0VyeTRyZWxkTW5meUpkMXl3QTlrODlCbnZ1RlJtbVRkUWJ4UCtR?=
 =?utf-8?B?aUhBc1hiL2N1NW91SUhiK0FSSnB6alpGWUJpL3VoUHFIRldiak11Z0VIQVE3?=
 =?utf-8?B?UHVnS0tLbzhpU28wT3N0TUEyWERkTi90S0VYSWxwVVQvbTVvVDJXRUVJRXpp?=
 =?utf-8?B?Z0YvL05zMUwzM282Y1FPVEVxK1htblc1Nk9LUUF1VWRpaXdGYXNUNUhxa0lV?=
 =?utf-8?B?Ry9FUk1xdjJvUjFZSXFRZ1lMSFJ1U3pldTIraXB3R2dwc2ZEQkVubG01QWRu?=
 =?utf-8?B?ZUdLWkZYcFY3SXdtWDZFbitSeGNTRU8rZloxR1AwdTlBS3pBZUk0S0xWVllG?=
 =?utf-8?B?L2Erd0FRWFg0RktZUTRQODU0elJsTS9qSDZRbTQyZCtLYndSS0x1UFZYZVdr?=
 =?utf-8?B?T3lFZndxYWJhUnVOa3dvdzczMG1yVFRmSWJrZThpNXBXbGRibU1pLzgyNWVu?=
 =?utf-8?B?STBYQkJhZVFzcGlBSGkxdUc0KzQxSXNLWTQ3cTA0azhzVk1iSG9pcFhjWDRN?=
 =?utf-8?B?djl0NXN5cHAxNHYvWEhHL1l0aG1qMHpBaUFab01KTkxrS3NtRTBYRjVQQnNO?=
 =?utf-8?B?T2JnRmpPRFZJaDN2T3FnS2ZwU2hLcmwvakh5WjBhcG1jUmxtZnIxR3lQUXV5?=
 =?utf-8?B?Q01ka3hiOFJsak9ac0p1SllUN25qUzVuRkZpNDRDUzZZQU1tS2pzV2hpVHNw?=
 =?utf-8?Q?/1KAjH?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49be5081-1a56-49c6-15dd-08dc472e3605
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:31:37.9941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ie9GKoV5xwzllSdz0X4FatQF4BsG/etFC0FYNXT/AEzq229zy/DJVK1iE2Ne20S3sItVIq0Rx5q340ZWHj18hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR83MB0553

PiA+IEZyb206IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+
ID4NCj4gPiBJbnRvZHVjZSBoZWxwZXJzIHRvIHdvcmsgd2l0aCBtYW5hIGliIHF1ZXVlcyAoc3Ry
dWN0IG1hbmFfaWJfcXVldWUpLg0KPiA+IEEgcXVldWUgYWx3YXlzIGNvbnNpc3RzIG9mIHVtZW0s
IGdkbWFfcmVnaW9uLCBhbmQgaWQuDQo+ID4gQSBxdWV1ZSBjYW4gYmUgdXNlZCBmb3IgYSBXUSBv
ciBhIENRLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3Rh
cmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaW5maW5pYmFuZC9o
dy9tYW5hL21haW4uYyAgICB8IDQwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaCB8IDEwICsrKysrKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYw0KPiA+IGIvZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gaW5kZXggNzFlMzNmZWVlLi4wZWM5NDBiOTcgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gKysr
IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFpbi5jDQo+ID4gQEAgLTIzNyw2ICsyMzcs
NDYgQEAgdm9pZCBtYW5hX2liX2RlYWxsb2NfdWNvbnRleHQoc3RydWN0DQo+IGliX3Vjb250ZXh0
ICppYmNvbnRleHQpDQo+ID4gICAgICAgICAgICAgICBpYmRldl9kYmcoaWJkZXYsICJGYWlsZWQg
dG8gZGVzdHJveSBkb29yYmVsbCBwYWdlICVkXG4iLCByZXQpOw0KPiA+ICAgfQ0KPiA+DQo+ID4g
K2ludCBtYW5hX2liX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgbWFuYV9pYl9kZXYgKm1kZXYsIHU2NCBh
ZGRyLCB1MzIgc2l6ZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtYW5hX2li
X3F1ZXVlICpxdWV1ZSkgew0KPiA+ICsgICAgIHN0cnVjdCBpYl91bWVtICp1bWVtOw0KPiA+ICsg
ICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIHF1ZXVlLT51bWVtID0gTlVMTDsNCj4gPiAr
ICAgICBxdWV1ZS0+aWQgPSBJTlZBTElEX1FVRVVFX0lEOw0KPiA+ICsgICAgIHF1ZXVlLT5nZG1h
X3JlZ2lvbiA9IEdETUFfSU5WQUxJRF9ETUFfUkVHSU9OOw0KPiA+ICsNCj4gPiArICAgICB1bWVt
ID0gaWJfdW1lbV9nZXQoJm1kZXYtPmliX2RldiwgYWRkciwgc2l6ZSwNCj4gSUJfQUNDRVNTX0xP
Q0FMX1dSSVRFKTsNCj4gPiArICAgICBpZiAoSVNfRVJSKHVtZW0pKSB7DQo+ID4gKyAgICAgICAg
ICAgICBlcnIgPSBQVFJfRVJSKHVtZW0pOw0KPiA+ICsgICAgICAgICAgICAgaWJkZXZfZGJnKCZt
ZGV2LT5pYl9kZXYsICJGYWlsZWQgdG8gZ2V0IHVtZW0sICVkXG4iLCBlcnIpOw0KPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIGVyciA9
IG1hbmFfaWJfY3JlYXRlX3plcm9fb2Zmc2V0X2RtYV9yZWdpb24obWRldiwgdW1lbSwgJnF1ZXVl
LQ0KPiA+Z2RtYV9yZWdpb24pOw0KPiA+ICsgICAgIGlmIChlcnIpIHsNCj4gPiArICAgICAgICAg
ICAgIGliZGV2X2RiZygmbWRldi0+aWJfZGV2LCAiRmFpbGVkIHRvIGNyZWF0ZSBkbWEgcmVnaW9u
LCAlZFxuIiwNCj4gZXJyKTsNCj4gPiArICAgICAgICAgICAgIGdvdG8gZnJlZV91bWVtOw0KPiA+
ICsgICAgIH0NCj4gPiArICAgICBxdWV1ZS0+dW1lbSA9IHVtZW07DQo+ID4gKw0KPiA+ICsgICAg
IGliZGV2X2RiZygmbWRldi0+aWJfZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAiY3JlYXRlX2Rt
YV9yZWdpb24gcmV0ICVkIGdkbWFfcmVnaW9uIDB4JWxseFxuIiwNCj4gPiArICAgICAgICAgICAg
ICAgZXJyLCBxdWV1ZS0+Z2RtYV9yZWdpb24pOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsN
Cj4gPiArZnJlZV91bWVtOg0KPiA+ICsgICAgIGliX3VtZW1fcmVsZWFzZSh1bWVtKTsNCj4gPiAr
ICAgICByZXR1cm4gZXJyOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIG1hbmFfaWJfZGVzdHJv
eV9xdWV1ZShzdHJ1Y3QgbWFuYV9pYl9kZXYgKm1kZXYsIHN0cnVjdA0KPiA+ICttYW5hX2liX3F1
ZXVlICpxdWV1ZSkgew0KPiA+ICsgICAgIG1hbmFfaWJfZ2RfZGVzdHJveV9kbWFfcmVnaW9uKG1k
ZXYsIHF1ZXVlLT5nZG1hX3JlZ2lvbik7DQo+IA0KPiBUaGUgZnVuY3Rpb24gbWFuYV9pYl9nZF9k
ZXN0cm95X2RtYV9yZWdpb24gd2lsbCBjYWxsDQo+IG1hbmFfZ2RfZGVzdHJveV9kbWFfcmVnaW9u
LiBJbiB0aGUgZnVuY3Rpb24NCj4gbWFuYV9nZF9kZXN0cm95X2RtYV9yZWdpb24sIHRoZSBmdW5j
dGlvbiBtYW5hX2dkX3NlbmRfcmVxdWVzdCB3aWxsDQo+IHJldHVybiB0aGUgZXJyb3IgLUVQUk9U
Ty4NCj4gVGhlIHByb2NlZHVyZSBpcyBhcyBiZWxvdy4gU28gdGhlIGZ1bmN0aW9uIG1hbmFfaWJf
ZGVzdHJveV9xdWV1ZSBzaG91bGQNCj4gYWxzbyBoYW5kbGUgdGhpcyBlcnJvcj8NCg0KVGhhbmtz
IGZvciB0aGUgY29tbWVudCENClRoaXMgZXJyb3IgY2FuIGJlIGlnbm9yZWQgYW5kIGl0IHdhcyBp
Z25vcmVkIGJlZm9yZSB0aGlzIGNvbW1pdC4NCkkgY2hlY2tlZCB0aGUgY29ycmVzcG9uZGluZyBX
aW5kb3dzIGRyaXZlciBjb2RlLCBhbmQgaXQgaXMgYWxzbyBpbnRlbnRpb25hbGx5IGlnbm9yZWQg
dGhlcmUuDQpJIGNhbiBhZGQgYSBjb21tZW50IHRoYXQgdGhlIGVycm9yIGlzIGlnbm9yZWQgaW50
ZW50aW9uYWxseSBpZiB5b3Ugd2FudC4gDQoNCj4gDQo+IG1hbmFfaWJfZ2RfZGVzdHJveV9kbWFf
cmVnaW9uIC0tLSA+IG1hbmFfZ2RfZGVzdHJveV9kbWFfcmVnaW9uDQo+IA0KPiAgIDY5MyBpbnQg
bWFuYV9nZF9kZXN0cm95X2RtYV9yZWdpb24oc3RydWN0IGdkbWFfY29udGV4dCAqZ2MsIHU2NA0K
PiBkbWFfcmVnaW9uX2hhbmRsZSkNCj4gICA2OTQgew0KPiANCj4gLi4uDQo+IA0KPiAgIDcwNiAg
ICAgICAgIGVyciA9IG1hbmFfZ2Rfc2VuZF9yZXF1ZXN0KGdjLCBzaXplb2YocmVxKSwgJnJlcSwN
Cj4gc2l6ZW9mKHJlc3ApLCAmcmVzcCk7DQo+ICAgNzA3ICAgICAgICAgaWYgKGVyciB8fCByZXNw
Lmhkci5zdGF0dXMpIHsNCj4gICA3MDggICAgICAgICAgICAgICAgIGRldl9lcnIoZ2MtPmRldiwg
IkZhaWxlZCB0byBkZXN0cm95IERNQSByZWdpb246DQo+ICVkLCAweCV4XG4iLA0KPiAgIDcwOSAg
ICAgICAgICAgICAgICAgICAgICAgICBlcnIsIHJlc3AuaGRyLnN0YXR1cyk7DQo+ICAgNzEwICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVQUk9UTzsNCj4gICA3MTEgICAgICAgICB9DQo+IA0KPiAu
Li4NCj4gDQo+ICAgNzE0IH0NCj4gDQo+IFpodSBZYW5qdW4NCj4gDQo+ID4gKyAgICAgaWJfdW1l
bV9yZWxlYXNlKHF1ZXVlLT51bWVtKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQN
Cj4gPiAgIG1hbmFfaWJfZ2RfZmlyc3RfZG1hX3JlZ2lvbihzdHJ1Y3QgbWFuYV9pYl9kZXYgKmRl
diwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBnZG1hX2NvbnRleHQgKmdj
LCBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9tYW5hX2liLmgN
Cj4gPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaA0KPiA+IGluZGV4IGY4
MzM5MGVlYi4uODU5ZmQzYmZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9tYW5hL21hbmFfaWIuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21h
bmFfaWIuaA0KPiA+IEBAIC00NSw2ICs0NSwxMiBAQCBzdHJ1Y3QgbWFuYV9pYl9hZGFwdGVyX2Nh
cHMgew0KPiA+ICAgICAgIHUzMiBtYXhfaW5saW5lX2RhdGFfc2l6ZTsNCj4gPiAgIH07DQo+ID4N
Cj4gPiArc3RydWN0IG1hbmFfaWJfcXVldWUgew0KPiA+ICsgICAgIHN0cnVjdCBpYl91bWVtICp1
bWVtOw0KPiA+ICsgICAgIHU2NCBnZG1hX3JlZ2lvbjsNCj4gPiArICAgICB1NjQgaWQ7DQo+ID4g
K307DQo+ID4gKw0KPiA+ICAgc3RydWN0IG1hbmFfaWJfZGV2IHsNCj4gPiAgICAgICBzdHJ1Y3Qg
aWJfZGV2aWNlIGliX2RldjsNCj4gPiAgICAgICBzdHJ1Y3QgZ2RtYV9kZXYgKmdkbWFfZGV2Ow0K
PiA+IEBAIC0xNjksNiArMTc1LDEwIEBAIGludCBtYW5hX2liX2NyZWF0ZV9kbWFfcmVnaW9uKHN0
cnVjdA0KPiBtYW5hX2liX2RldiAqZGV2LCBzdHJ1Y3QgaWJfdW1lbSAqdW1lbSwNCj4gPiAgIGlu
dCBtYW5hX2liX2dkX2Rlc3Ryb3lfZG1hX3JlZ2lvbihzdHJ1Y3QgbWFuYV9pYl9kZXYgKmRldiwN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hbmFfaGFuZGxlX3QgZ2RtYV9y
ZWdpb24pOw0KPiA+DQo+ID4gK2ludCBtYW5hX2liX2NyZWF0ZV9xdWV1ZShzdHJ1Y3QgbWFuYV9p
Yl9kZXYgKm1kZXYsIHU2NCBhZGRyLCB1MzIgc2l6ZSwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBtYW5hX2liX3F1ZXVlICpxdWV1ZSk7IHZvaWQNCj4gPiArbWFuYV9pYl9kZXN0
cm95X3F1ZXVlKHN0cnVjdCBtYW5hX2liX2RldiAqbWRldiwgc3RydWN0DQo+IG1hbmFfaWJfcXVl
dWUNCj4gPiArKnF1ZXVlKTsNCj4gPiArDQo+ID4gICBzdHJ1Y3QgaWJfd3EgKm1hbmFfaWJfY3Jl
YXRlX3dxKHN0cnVjdCBpYl9wZCAqcGQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGliX3dxX2luaXRfYXR0ciAqaW5pdF9hdHRyLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpOw0KDQo=

