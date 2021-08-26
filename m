Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B443F7FD4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 03:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhHZB1D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 21:27:03 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62]:60659 "EHLO
        esa19.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236055AbhHZB1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 21:27:02 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Aug 2021 21:27:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629941176; x=1661477176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hJpCs+BVhUCsc6cWJKovqyReMhU7mPiD+g9XNiZRIQQ=;
  b=lJxjTYh++VRXh5DdVBApG5JagPkmQggq7SZgk3VIb8zkmsJdxyBBuETI
   Q3XlyCeWucTqD6vQhSGel0YOOCntIkPliBr2hg2h9CDqiJSoBlm6fwriu
   5zRYpb589BFk9vrTAgLQZvx9vWZlUYFLpflBV0tRjMyhosA5JfUqnOE6s
   KmCPZHUe51SdCaouFy2yRo/3oRYukwL1bslmnGz4cjHfBQxHi1fYRKtru
   tvK0v8wYxGSXifHUxzahRQmU0ZAhUZNxM17U/YkXNyqLCnmYB4KnXlbo4
   qZawIbG+BRm1WcdGH9UXzsTnmGJmVoIaPYJ1eWUN/arBuVjhvZgbl+M4a
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="37499509"
X-IronPort-AV: E=Sophos;i="5.84,352,1620658800"; 
   d="scan'208";a="37499509"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 10:18:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH1WIeq6Qbo5UtkP8avMUHiVvAdqq3DBXkfzS4T4D68zcXtd4LXwSyaMxS6gIFTUs44jw1/k7Lpc1XqqaREQzRLMsvUcJMoyE2KK4NB+IHoCrTgh3rxZ+LoH5mHkTMnEJdZKni4uQNy/hDTYEciUsy1vvXk85Wq7uReEX99vojunPv80S0GJ59JM4hg5+z6HD8OrD8QfMoTBExYwiQvzWkEJMvhzyVFCb/XGZg3+Gj4TOwsJWploqHAoa4BL7q7YOAzNpPL3gznnT0yeC20nkucbbNpM/vEncXulM7TjplRnnTEBz00bjzjsBxXR5h7qPm1Ag+McGwJACgw61ZtXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJpCs+BVhUCsc6cWJKovqyReMhU7mPiD+g9XNiZRIQQ=;
 b=WEQiWzSbsRVtC0kycnlBmsrp07Pck/xYBTmW14m4cI9ErXVx0i7y5VnA9zbDsj8gXia5xLFxqb/AnM3twm1Fk6cGZW43hNtGccgwvA/2I2WQDdpZGFGkoFmCLEGErsNRY6IhBXVC2rVkOSj3KAVHRPSL3n86d4YIyiUqYuEdzQ7TLDF//84y5YBi73/kJxExDBVb/ZtXIk57CNioVsVwfV2F9Y4RtCPIWA/kkvB5wbs3cRdULkm6cGoINobdm4Y+TQGNwEPvD4EvkmCy2+8cEiQVsFPPa5d94S59rlKKDhHjD43t5BzXyTypPD2OMUgJWbr1VmB1FXWwbOoDxOV67w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJpCs+BVhUCsc6cWJKovqyReMhU7mPiD+g9XNiZRIQQ=;
 b=bMqvtx9Soj3CH4k6+B8cqqEXRlbIE4eXuy6AYi22BIUtIBTeGUss3NyN5kccMGijrtD0XB6N0raTzhZa9ugV49DwmnErEKcPxTIsdDnAeO6LM1bySsKLGPmUX7NhVod+gIQOHHuv/89Jn5Ih4t9J82ss5g9GZLf6iSED6Dgj8u4=
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com (2603:1096:604:14f::5)
 by OSAPR01MB7421.jpnprd01.prod.outlook.com (2603:1096:604:142::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 01:18:47 +0000
Received: from OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::7407:c85b:2ea4:2ba9]) by OS3PR01MB7650.jpnprd01.prod.outlook.com
 ([fe80::7407:c85b:2ea4:2ba9%5]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 01:18:47 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Thread-Topic: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Thread-Index: AQHXhrbNDgu/BY8sokOKZIxuzo0WFqth+tCAgAAZpQCAAASwgIAAvoAAgADeFQCAAMdDgIARCoCAgAhNa4CABsr5AIAAgsWA
Date:   Thu, 26 Aug 2021 01:18:47 +0000
Message-ID: <fb1c7505-62d3-a64e-4c57-170f9f5f86a4@fujitsu.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com> <YQmDZpbCy3uTS5jv@unreal>
 <20210803181341.GE1721383@nvidia.com> <YQonIu3VMTlGj0TJ@unreal>
 <20210804185022.GM1721383@nvidia.com> <YQuIlUT9jZLeFPNH@unreal>
 <6b372500-ebc5-bc42-11c5-99de381b2e50@fujitsu.com>
 <7b930773-0071-5b96-2a85-718d0ca07bfa@cn.fujitsu.com>
 <20210825172844.GK1721383@nvidia.com>
In-Reply-To: <20210825172844.GK1721383@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c834fe0-117d-47f6-d928-08d9682f7465
x-ms-traffictypediagnostic: OSAPR01MB7421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB74218AAD8AD9AE12BFF83BC3A5C79@OSAPR01MB7421.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: raUET94Zk6RnLTr2Lj8D6e0EpgCiD4OuxRM/0ZTy0mhNFk1uc8htu1bSOATQOZrkma5vhzXrRYdhUct5FgFrSotEwxqAOrYAfp5HbDIN1vtOGjy5v8P/PrAvJXKwVFCpqHXp3WdDUtJ2GXkoitwLLnHbUHJUCn1RfvPbq7SFy7sNeSFpv7Ql3xmKjxO5CLZufwlAp9pL8dr0EnWiccLMmyDp63mUeLCrvAyxG6g61P0fDCZWQB6O0tm39UejEkYugif4TlBTUcoV63A4tPGmG0sGbVmhDTOaOFQmGfx7AgNMtNY9UeNbQJXziBJlwLmBQgx9bg8tooSKoXM3dxemPqRBVQaPW1N4KCFyTFtOcG2RsC3s+5kCuk7d0KVRMWHarHU0C6vrJy40lXLaWtxYa7g/uVnRb87T6tzbVqa17HknmeBWtEUvSyj9YEtRh85K6SaWdK5yiHtp/nTYSI+Jp3/5qywaFwgKAnZi0Naaw3Mr8a0SDiUsNF9530JxiUpeL6TAGtx2PbBXgVxAPnE3EWlwtrIt1edxHKA4AqqoCdfO+xsTnFKxEft9z75bAGOhnEOiZoc2/OooPVDUvA/a73it8rsu3um+RJoX1z5tzpPK/73wr3Sdahc3g9C1ptPqPfkncdQL/Gw7tR3NWlrD5AUtTWmXRFgTJTd+KWRLyD+DRd/0ENHbh4OHgAfMv1sony1BQkTenQgTpDdXeUJOqUxBW1ajOlLsiHLrFi1z+eyTTSMoK7YjfjBpXJgsdmr9Vp1PK7Vt/k1IvHrKjFAMaBqFT0ro7ofakSdRGyKcp5ZlQGZCkcx65BqaToCN2K7zhop1NcoOlut0Oip6k6Inn7mvHlQZVuGK6jYv9elXmzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB7650.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(966005)(36756003)(31696002)(2906002)(5660300002)(31686004)(508600001)(186003)(6486002)(316002)(54906003)(26005)(110136005)(4326008)(6506007)(85182001)(4744005)(53546011)(71200400001)(122000001)(2616005)(38100700002)(76116006)(66556008)(66476007)(91956017)(66446008)(66946007)(8676002)(8936002)(86362001)(64756008)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JwUjJuOHZqdHcrbjVxZzN6WDNJK21lYTlwUWM5MUVISUFMa1owRUtTRXFj?=
 =?utf-8?B?ZWhzaTBqTUJGZUtPaHl2Nm12d0xtMFp4SDZVWlo4WU5HY0xwMWhvbmxIQUdI?=
 =?utf-8?B?eDNhajJobGJsS3BJOXIxUUtzSkpMNG1hMDc2Q0NibjdNTGpmT1Z1MllHTy91?=
 =?utf-8?B?blMzNjV3elZlbjVnTXQrSWZZOWdzQWtIVHhDTVFoNnRvVFRUZFpqVXg0RGdH?=
 =?utf-8?B?MElHWmxYcnpqVVdYRnY1S1Bhd2NTOUwybEJzMW1BWHRGdTVoak9CcDg2Qklu?=
 =?utf-8?B?YWw2YTFwbXlDUnh6MW9qcFNMWjgyM0Y5M3V6ek5kekVrb20xLzR5WjBxQm5O?=
 =?utf-8?B?UWZxQy9FQUJidzlTelNDalFTVGlNdldOVk1XK0tVTXdOZE5pa3JIc2Nqc09U?=
 =?utf-8?B?K2YvOXFXcnoyaVVJbHBpTG1HVHBGVnkrQWlFa2FKUjNGejRkTkFZcENmTnB1?=
 =?utf-8?B?VXNhT1NyR0RjS0JWdm12MGVZVklvanZLb25tclRyTHdyUDJWWWUzYi9HNkRa?=
 =?utf-8?B?cTJDS1Bld0s0eDVkT0RQYWxpbldSbHd2Vmswdytmc2NJaS9FUTlwUktuNHdP?=
 =?utf-8?B?M3dyRGNaZ1RlYjlpbjNJTFdFRFdCekM2SHFpejhsWjRJSlFGZHBIM24rNC9x?=
 =?utf-8?B?THpQNjZUNlNhWis4eFRyVVdOSysyNGkwaWJoNFpuTkE4TzMzaTlCN0p5a3lm?=
 =?utf-8?B?bU9USzFTNDkwd0NGOXpXVVZtRlpPbU9JakFhOStCR1A4MUNmTkpRNVRGTzR5?=
 =?utf-8?B?Mk4xQldXcXF0SE8rUkx0cUNSNVdBZmZzdEVLQUxwSDVBQVFLYSt3YlhQcHlv?=
 =?utf-8?B?NDErQ29MZi9INTl1ZEpIMGVjYVM0UlZkNWROM0Z0dWszbEYxVEh2L0s1OWZo?=
 =?utf-8?B?Z0ZFZEJNMUIyTnlKRWFsZ1NxaXhPTkVJT24yQ1JtbXVyc0pnRE1ZRDcrWHl0?=
 =?utf-8?B?SG5lc3lrN1VLblI1UytDTXlLSUNlOWpnL25LdnhZWlphVmNCeGtUUFFCL0JE?=
 =?utf-8?B?cEVGbXpjbFVOckkzTk96S3JRd1Fsa1huZ3BhRTJhUEFaYlM2TUUycDM4WEJ4?=
 =?utf-8?B?aHZOSEVQMTgzejRSbFEyNVBZVk1ZV3JHZ0JGb1MzSlZscDM5a0cvNzYyeWJx?=
 =?utf-8?B?UHErRm0zOTBTR3J4enQvOHZ2RDYreUdjNFNEMmNhOFlBY29ieURzaUFWQmN4?=
 =?utf-8?B?N2ZTRmpUR3ZHOG85OGtLQTlyN3FmUFBPSFEvMFlJUFRoK0J1M2ZyTUsyQ0sv?=
 =?utf-8?B?SDBDbEc1Q3pVRzhlS2RTc3hBRmkybVhtZkwxNHR0bk1nWDczUkhJTzJLS2x2?=
 =?utf-8?B?cUppbEx0bDl6ZzAvRDNHd29pK2REOXQxSm1xVXR1ZWVmbmdScHMxOG9iNUZQ?=
 =?utf-8?B?aUlCYVZpVFQ4OEROd0szV3Q2dVVoQlhXcG5LZGdNK0NsWDdMU3QyNzQ3a1kx?=
 =?utf-8?B?TUlhNUdtY1ZNaTZUbnpncWErMmtMUmQvOXk1TG83MFo5TDNacmg4ZUhhTm51?=
 =?utf-8?B?M1liaURGSmZDbStTelV1SEZOaG9wd0hzbURBZW5XbGRIV0doM2VBVWMvNDJV?=
 =?utf-8?B?d1ZyYnk2OHJhNitYdVJNV0orSjBKZzk1TWVFYXFnK1pTVGs4dWsxTUlQZGpo?=
 =?utf-8?B?VkVJRC9xQjFWTkdFd296Z29mRUtFa1hYNWs4ajlabCtkdU9lOVR2QVBRM0tz?=
 =?utf-8?B?enhydXVHRVhYUXVnamVwS1RiYldhMnAxMUYybG5aRW5UOUFESGFyc0lzU0Ju?=
 =?utf-8?B?ZkxTQ2o1am5TK2xtck5RYldVNk95ZUJ6blhpN3BtL0J0Y3JIc2l5N1dGZjMy?=
 =?utf-8?B?aTcyQkFhS0YwaERscE1IUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C21F03472D5F94B8F56F7BEE0E2E116@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7650.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c834fe0-117d-47f6-d928-08d9682f7465
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 01:18:47.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJ2LqKc7/vXqa1/ybVN1FOEkQdubGi1riDaNpIEsakAtzDwWY4szABB3/RF8MshM+pJuRITf32NkRXNNnyf0mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7421
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDI2LzA4LzIwMjEgMDE6MjgsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gU2F0
LCBBdWcgMjEsIDIwMjEgYXQgMDU6NDQ6NDNQTSArMDgwMCwgTGksIFpoaWppYW4gd3JvdGU6DQo+
PiBjb252ZXJ0IHRvIHRleHQgYW5kIHNlbmQgYWdhaW4NCj4+DQo+Pg0KPj4gSGkgSmFzb24gJiBM
ZW9uDQo+Pg0KPj4gSXQgcmVtaW5kcyBtZSB0aGF0IGlidl9hZHZpc2VfbXIgZG9lc24ndCBtZW50
aW9uIEVOT0VOVCBhbnkgbW9yZSB3aGljaCB2YWx1ZSB0aGUgQVBJIGFjdHVhbGx5IHJldHVybnMg
bm93Lg0KPj4gdGhlIEVOT0VOVCBjYXNlcy9zaXR1YXRpb25zIHJldHVybmVkIGJ5IGtlcm5lbCBt
bHg1IGltcGxlbWVudGF0aW9uIGlzIG1vc3QgbGlrZWx5IHNhbWUgd2l0aCBFSU5WQUxMIGFzIGl0
cyBtYW5wYWdlWzFdLg0KPj4NCj4+IFNvIHNoYWxsIHdlIHJldHVybiBFSU5WQUwgaW5zdGVhZCBv
ZiBFTk9FTlQgaW4ga2VybmVsIHNpZGUgd2hlbiBnZXRfcHJlZmV0Y2hhYmxlX21yIHJldHVybnMg
TlVMTD8NCj4gTm8sIHRoZSBtYW4gcGFnZSBzaG91bGQgYmUgZml4ZWQNCnRoYW5rcyBhIGxvdCwg
aSBoYXZlIHN1Ym1pdHRlZCBhIFJQIHRvIHJkbWEtY29yZSBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXgtcmRtYS9yZG1hLWNvcmUvcHVsbC8xMDQ4DQoNClRoYW5rcw0KWmhpamlhbg0KDQo+DQo+IEph
c29uDQo+DQo+DQo=
