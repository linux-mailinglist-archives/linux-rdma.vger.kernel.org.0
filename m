Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0D3BE9CF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 16:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhGGOfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 10:35:42 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:41120
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231737AbhGGOfm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 7 Jul 2021 10:35:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR2IXh7eBoQ+//GtsAfKVcCG2gzCwwL3pBOUK76Pz7Wfw7kV8yD2TksTQRy0vs9XGsY2nPLozuUDzq42+6JEbXAZXoz2HkA67H1yBSDq7wTfSqEnwe2mOsignCXTOaHi3L9iLTSrPYl4LCn8Wb4H16gX1MC0KPPWu4082MSDU4GoyeGmzUdhDJy3Qmsv/ze041HREYqUPN0Y19GbdXMeQhquiHnMtLjer5bzv20HsCuRspDvJ2PhrT5fCnu8cP5n4xtZlFfmhfJ9q1bG1NnjjSsy3rP0iESzEADqmaKvXocyhn9OB2DHgzCJRmDVapRCztaq+fUPw8uM9Bv/O1NWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1cZCrFMhLV1hzsa9Jm+VHcrwpwULaZgUbyECEz+SEA=;
 b=AanaeBcwo//Sx7BAL5HvqeswdGq2wPIgBvRjD1hYL1POGBzj6sYyd2TJz3DKne4KAQYyV/aTauv4v2zvvN+CmtRx4cbK++If3g+TR9jAo3JeEEHxLD2SX9dJKWPrJdwIscXB2ypxbFAFmf5kYfNsXhV02hvUVVJz6Ey7P+R+IUKtgjNn63ji+OqBA1cXWG89PFBeCe80TPKjx855pmqOE1i4ejTGce4iV05VHF9xe+GfVpb/xIhDVvBKPBrBCMui35421Pc+Fh7dSBA6tLvM/DweyvWmC3mmdgU7pUGwJFn64dbisMYS7z1c48bRQb3VuiI8udLir9nafN0v1ziIvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1cZCrFMhLV1hzsa9Jm+VHcrwpwULaZgUbyECEz+SEA=;
 b=XXn2qIB3vKyoEEf8cSYer4ou5Dfwz5K+EqFvpPE9oMJrDB9AdxMEzKlU4kIDPCP9ufMPHnf65ntRccAj3awypHr9Uz1maRgCb76fgENMaA0eRlMwjMmDsQ+9KMwZzr+30UFtuTqJ2+RvIj3z9SXeR6ow2hzQ+Z4hpTBKd0FO2ezBM1VJNxpeyypimuDad578ct674S/U/LwmLI9Q9kjPHuJPcB1UjmQLxUrd3yc8nkWgpAuRc5NFV1zxZBF2CKmrN+5z/onZzSiC2o5ot2qoHozWiqLukm8ERiJ/PNdFSM8jrqw6b/8QTJt7U6ofLt5KdDyDM3s3TgjT+h50Y9dPrQ==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5419.namprd12.prod.outlook.com (2603:10b6:510:e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Wed, 7 Jul
 2021 14:33:00 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::1841:1b3e:2452:f1f7]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::1841:1b3e:2452:f1f7%5]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 14:33:00 +0000
From:   Majd Dibbiny <majd@nvidia.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
CC:     "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "mustafa.ismail@intel.com" <mustafa.ismail@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/irdma: change the returned type to void
Thread-Topic: [PATCH 1/1] RDMA/irdma: change the returned type to void
Thread-Index: AQHXczvdHeWytAwHNkWUMZKgz7n4jKs3k4HH
Date:   Wed, 7 Jul 2021 14:33:00 +0000
Message-ID: <AA895EB3-CA70-4907-83CB-ACFB56CF58CB@nvidia.com>
References: <20210708064752.797520-1-yanjun.zhu@linux.dev>
In-Reply-To: <20210708064752.797520-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a42049-4a31-42db-20d2-08d941541f46
x-ms-traffictypediagnostic: PH0PR12MB5419:
x-microsoft-antispam-prvs: <PH0PR12MB5419D22C4039DC48A811A8B9AA1A9@PH0PR12MB5419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vSP+r3HBSzIDJZ4+ikHN/4tMSxCgvZ+W/8IMJFROvuoi+RpQDn0tSs+g2R3bz3hwGzAzWznGxnGGYWOgtpwY7mhHOijIRsIom/iR3Y5/cXA89ArGY47Q17eZFxF2CxM4hG34a8dKgd5h1u9+UxspfdCM/2aKcHKr8SjbQuxT/aEUG7nlzfAuN++e34wZRTBqqHjG3gk/9i2zPsKi+saHSxdGD2XoV8eBG8g3iEpHTsLJiPPTPx//k4Es1qvUv87kk7kQLVrYA7tm9AMvsWB61wCjyYKrORmT5dYjmqUp4hCl2lFJOG8jqGL5pecJXcD8kGDdyGKBkjrmk1PnPw3ksHwTrKIXLSFNb5Uv6GkfN+S39nBhL2cABT+FxTY9kcBtIW7sSUULZIpR0fw/g/we871513GqMnYB+1un5EOwI3MQ7FF8M9zY72SWsmQNw/UwTHzVEyu3KEsyCRAiCr41Nmj3tBfJiKa773RTxU2v31SZJGK3j+jBSeQlyjFWTUT+va5dR2/T1/qemPWVRYLhdJSg37Wt85PqhfSUTMoFxWKKWbmtu+3zwQ9GRwyu3AlTxgr3oMLSJXgSgWTOKcBJR7eaqwbvJzEd3E/r5OM8OKLW6MixYBQAlm/OIW4YHZwa42ey6DrhbEzGQgxAUpwE15N+sJOQw9crXak+d5XwGQDtCVKeNoZPm/ZZEz5Ru064qlTe8H3X4FyV6J6vDk0gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(8936002)(83380400001)(2616005)(86362001)(478600001)(8676002)(71200400001)(122000001)(38100700002)(26005)(6506007)(36756003)(186003)(6486002)(53546011)(66946007)(316002)(54906003)(33656002)(6512007)(6916009)(4326008)(2906002)(64756008)(66556008)(91956017)(76116006)(66446008)(5660300002)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJxRUxFa0VyRk4zMWU2Y3JEYW9wU092QmxOTS9CSnJaaTJuR09zdHpvYjdp?=
 =?utf-8?B?b1FkVFp1UnJ0VFdDa1MxYXh3UnIxak1xUXppSzJpYkh4M2NnUitxWGY4TXBr?=
 =?utf-8?B?WUdES1BuMUFlOHpTekthOGV3U2lEL3dpQkhzOG5kWjU5YUtQR096Z28wRzI3?=
 =?utf-8?B?Z3RWcEZQMkxSZzVlTjJ1SXpma2g5dDAzQXNvb0dkMmF4Nzh4SndmYVl3THAx?=
 =?utf-8?B?dmd6NWlCSW1wK081dExhWVJacG8yTC9qeEtxOGJxcHpva3p6cHAwR1RsS3Ay?=
 =?utf-8?B?SmJMbzdXSlVZajcwcmkyUmVVd29jeG9rUHM3YXBMTkp5YVFsWDJQbnU4MW0x?=
 =?utf-8?B?UlZJK3ZBQVJERWp4V0MyazVLbDZKQUEyRlBmUFlmcGlWZmxPRkpjTnE1c3Er?=
 =?utf-8?B?ZS96R3FpQjlWb0V6Q0JPVnJSbjd5aWRzckJMbkJKTXRHNVVNbXAwYTNLcCtz?=
 =?utf-8?B?eHRUVjRxRXUxTGhxMHJNNzQrSzJLOWRpWE9wUjVVYVlxUEhHTWJPd1g2TEsz?=
 =?utf-8?B?d1hkcnFVY0Z6NVU0OCtMN0N5M3VTQ1pYV2V2RGk1ZWR6MDNEcWlxQVZFZHM5?=
 =?utf-8?B?cnNjWlZVSVhocFNoQTc5bFJGdnlGUXVhTXZqaFM0MXpJOW94a1VjaFQyZXQx?=
 =?utf-8?B?Y3ZJOWVwd0JTa1hCdkZYbVFPM3pWRHBkdHoyMUpaL0NzUmpEbHFvdW9CZjV5?=
 =?utf-8?B?OUpiU0t3bHpiREh5U1o5VEluSmtXWmgrQUkyUURPSVo1S2ZOcUtHM0RXS2R3?=
 =?utf-8?B?eHBsZ1VicGczV3FXZi9MTlhIVi9SeWFQNHNoU0prVVk3a2M0Wk54OTF3SHMw?=
 =?utf-8?B?WElKaFVsWm9Ba2RUdFZvU29sTXlwdGVCZkVMWE12cm9FRmQvWmdtTVNKa0JC?=
 =?utf-8?B?bW5KYzBkTllXVk55L2h1NEVoWm5MTkwxTDFXMjFPMUM3a3dOc3JHWjk5UlFQ?=
 =?utf-8?B?eXI1bWV1YVFFL0ZGaCtCOWNnNXFBbkU2Ym9pKzJud0ZoeTVpZkR0aW5YMDly?=
 =?utf-8?B?cmhKZ0g1b0NaMzNRSTM0cEEvMWNZMGhrSm95cmRzNFlFQmwrWU9yTUNjRWk0?=
 =?utf-8?B?RWJPSHFHc3V4ZzFpQjZwLy90SmF4Qm1HdWJFcW9uV05GanBwelgwMmVLano4?=
 =?utf-8?B?MDhWYTMyNlZNVjgzUW1mUUE5MG1HZ2hUL2lYaE10RTRvQTlNaFF6Z2JFL2t6?=
 =?utf-8?B?WFlyQ0M1RkZpd3NZNW9BVGdkUDREakZRSTRXWTZaL2N2c0tsRjg1MU9lU1Mr?=
 =?utf-8?B?UTU5Tkw3OEFjQUZuM2RGWGI4L1Vvc3FyMUtPT3lpb1RTb25qMlNXYW5UaTJI?=
 =?utf-8?B?N3YrWDJhNTVjclY3ejEvVWtRWEh0QnowUEQxTEdqcEUxRWp0NXUvMVZpdFhI?=
 =?utf-8?B?Z1F2emU2NWZrTmxIUjJSOUhTNnZrRU9PODZMemcvZVUvL3RjQ2ZzY1dsYjJl?=
 =?utf-8?B?UEU5MEpJejhST1hqWUlZR0VnSHEweFVFQTZDN0lIcmplS2puSWFyRjFQMG5Y?=
 =?utf-8?B?eHBPYnhhcVgzcVNYNS9zWlF1dHRNdXNrbTFNZEwvTW9Ic09INTdGUDQzbkkw?=
 =?utf-8?B?aG1ObEQwSGhoUEExZnRNZVM2amtBRWsyOUt4YnA0M0hPMnNHaTZ0bUZab3VU?=
 =?utf-8?B?YkxLT0NyRkxPc2VRT1d6V2RlOXI4cllJWmdDRkp2bTgxR0ZuZVJmWXp4a09v?=
 =?utf-8?B?elplUzBzT3dQbXAyZ3hhaW5xRWZyMndJZDNzRWk4VG03cVdRT1NxQWhYVUg2?=
 =?utf-8?Q?RomkKA2wKpKxHs5s1gqC1XJ/SvyilIperq+stDo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a42049-4a31-42db-20d2-08d941541f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 14:33:00.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bnwms9A02QdzdKF16HJBma9ys6UGuIUjvmT/TN/23CJtWfnYMU0Gfa04dsDyWV4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5419
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IE9uIDcgSnVsIDIwMjEsIGF0IDE3OjI0LCB5YW5qdW4uemh1QGxpbnV4LmRldiB3cm90ZToN
Cj4gDQo+IO+7v0Zyb206IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2Pg0KPiANCj4g
U2luY2UgdGhlIGZ1bmN0aW9uIGlyZG1hX3NjX3BhcnNlX2ZwbV9jb21taXRfYnVmIGFsd2F5cyBy
ZXR1cm5zIDAsDQo+IHJlbW92ZSB0aGUgcmV0dXJuZWQgdmFsdWUgY2hlY2sgYW5kIGNoYW5nZSB0
aGUgcmV0dXJuZWQgdHlwZSB0byB2b2lkLg0KPiANCj4gRml4ZXM6IDNmNDlkNjg0MjU2OSAoIlJE
TUEvaXJkbWE6IEltcGxlbWVudCBIVyBBZG1pbiBRdWV1ZSBPUHMiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4NClJldmlld2VkLWJ5OiBNYWpkIERp
YmJpbnkgPG1hamRAbnZpZGlhLmNvbT4NCj4gLS0tDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9ody9p
cmRtYS9jdHJsLmMgfCA5ICsrKystLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9ody9pcmRtYS9jdHJsLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5jDQo+
IGluZGV4IGIxMDIzYTdkMGJkMS4uYzM4ODBhODVlMjU1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2luZmluaWJhbmQvaHcvaXJkbWEvY3RybC5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9pcmRtYS9jdHJsLmMNCj4gQEAgLTI4NDUsNyArMjg0NSw3IEBAIHN0YXRpYyB1NjQgaXJkbWFf
c2NfZGVjb2RlX2ZwbV9jb21taXQoc3RydWN0IGlyZG1hX3NjX2RldiAqZGV2LCBfX2xlNjQgKmJ1
ZiwNCj4gICogcGFyc2VzIGZwbSBjb21taXQgaW5mbyBhbmQgY29weSBiYXNlIHZhbHVlDQo+ICAq
IG9mIGhtYyBvYmplY3RzIGluIGhtY19pbmZvDQo+ICAqLw0KPiAtc3RhdGljIGVudW0gaXJkbWFf
c3RhdHVzX2NvZGUNCj4gK3N0YXRpYyB2b2lkDQo+IGlyZG1hX3NjX3BhcnNlX2ZwbV9jb21taXRf
YnVmKHN0cnVjdCBpcmRtYV9zY19kZXYgKmRldiwgX19sZTY0ICpidWYsDQo+ICAgICAgICAgICAg
ICAgICAgc3RydWN0IGlyZG1hX2htY19vYmpfaW5mbyAqaW5mbywgdTMyICpzZCkNCj4gew0KPiBA
QCAtMjkxNSw3ICsyOTE1LDYgQEAgaXJkbWFfc2NfcGFyc2VfZnBtX2NvbW1pdF9idWYoc3RydWN0
IGlyZG1hX3NjX2RldiAqZGV2LCBfX2xlNjQgKmJ1ZiwNCj4gICAgZWxzZQ0KPiAgICAgICAgKnNk
ID0gKHUzMikoc2l6ZSA+PiAyMSk7DQo+IA0KPiAtICAgIHJldHVybiAwOw0KPiB9DQo+IA0KPiAv
KioNCj4gQEAgLTQ0MzQsOSArNDQzMyw5IEBAIHN0YXRpYyBlbnVtIGlyZG1hX3N0YXR1c19jb2Rl
IGlyZG1hX3NjX2NmZ19pd19mcG0oc3RydWN0IGlyZG1hX3NjX2RldiAqZGV2LA0KPiAgICByZXRf
Y29kZSA9IGlyZG1hX3NjX2NvbW1pdF9mcG1fdmFsKGRldi0+Y3FwLCAwLCBobWNfaW5mby0+aG1j
X2ZuX2lkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgJmNvbW1pdF9mcG1fbWVtLCB0cnVlLCB3
YWl0X3R5cGUpOw0KPiAgICBpZiAoIXJldF9jb2RlKQ0KPiAtICAgICAgICByZXRfY29kZSA9IGly
ZG1hX3NjX3BhcnNlX2ZwbV9jb21taXRfYnVmKGRldiwgZGV2LT5mcG1fY29tbWl0X2J1ZiwNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaG1jX2luZm8tPmhtY19vYmosDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICZobWNfaW5mby0+c2RfdGFibGUuc2RfY250KTsNCj4g
KyAgICAgICAgaXJkbWFfc2NfcGFyc2VfZnBtX2NvbW1pdF9idWYoZGV2LCBkZXYtPmZwbV9jb21t
aXRfYnVmLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBobWNfaW5mby0+aG1jX29iaiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJmhtY19pbmZvLT5zZF90YWJsZS5zZF9jbnQp
Ow0KPiAgICBwcmludF9oZXhfZHVtcF9kZWJ1ZygiSE1DOiBDT01NSVQgRlBNIEJVRkZFUiIsIERV
TVBfUFJFRklYX09GRlNFVCwgMTYsDQo+ICAgICAgICAgICAgICAgICA4LCBjb21taXRfZnBtX21l
bS52YSwgSVJETUFfQ09NTUlUX0ZQTV9CVUZfU0laRSwNCj4gICAgICAgICAgICAgICAgIGZhbHNl
KTsNCj4gLS0gDQo+IDIuMjcuMA0KPiANCg==
