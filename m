Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7664487035
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 03:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbiAGCPb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 21:15:31 -0500
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:19698 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345312AbiAGCPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 21:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1641521731; x=1673057731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/yPYSqh1Xmr4oQFI2KCWmsUUGoLM+53Tln+N924ds8E=;
  b=V2sAT/IR71RhkiNm7C63UHPTTLVFAOs0YYagk0UxMeTWAhXvZvRQcK3h
   drnjjxlQfVpXkWeelE9BZ4KhYQQOCvvKV9j1kCp9uXuKym8YSxHu/SOyJ
   1HrDijbK8/gVrsKPqIbpDaepLRE6WbjHbsYbw9xyeeStku0E541N9gRNl
   ZtF8BlZ3f6XigaiGutSFHoiHsi5CJB+intggydZqYf6ScP3I0A9hUjSHH
   HS9BhsRjBdmSIR6zeh0K8w3YtqOIzA+MHfZGp6XRkT6FeCo5+1Dc1TBLw
   xIYhE+wM5hPfRpCCElytNWeB9GvDrNlHbzjLgCy4tdwGEnd8xLcrH0aKI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="47035230"
X-IronPort-AV: E=Sophos;i="5.88,268,1635174000"; 
   d="scan'208";a="47035230"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 11:15:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEUEYuMWX8tsc79rNZBWTEApTtDuCfioXCMPIS/Ue0gdeVBrjMVLVpHrOku+VhLQRyryR3hKKk9+ZU3QKD0X94s0ZYFrheA3zy/5FpRBh4LfI3ro3WwxpFkdKEBE9NKyA8Ci+85eFEAqglSq4n1ZBF5aI7BGdGinXbwLf8Ok70p3a/O//vkCBJVFDJZiOph7ksoi4+eXsjp90TQ33TY4v4ldOfX1YvenzwY0W+zwYZNRkAYzxRzXdRjyiH81KIwsafkbLwHejl7MkSZdcyb72b3lt6yS0stQhvXOkSvKcAhidSBw1Mqb74kA8x/3mcbUyykI/JnNozpJ6U2ILlXR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yPYSqh1Xmr4oQFI2KCWmsUUGoLM+53Tln+N924ds8E=;
 b=A1vYKJOoHyKykjiqA+ij1tB0FbUonZqmNcXsMFmS9LtrypDHCbKWLcQYfWeWYhYM1o+gO18yOzx+WopBvaCdp+NsBkEuwmkIfknTIl5oozVPEnpgLA+KCzE5xW/bwh0CCkSgp2Cm4F6rYHtB4ubDxVvVBRgq5jHUtCoZcuaaFysmnV/HYnj9mV3ehDvw9YhtZt44hb1GWmSWma5osG6hYvhr9gS/3CYjWaR1vzM1Cy8HWsfFjFRHjaGYslpNzjvxTVgE1tfICi7a8o0QtG0H8g5qCGAFZb8fSCV1rLD9iRqBFQuqsWpxeCItXE+CGBKHpGPRMfY4cYb2SpCJ69LTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yPYSqh1Xmr4oQFI2KCWmsUUGoLM+53Tln+N924ds8E=;
 b=npR4/qOQefiNWsuRjqBlk/BzO5FfD3VRkRZG0VF29WipzZC18PTP2N2qmfjtBokqN/qtARs2OP71/WimHbxWthw4mSpWdu1tbj95celD18mIqzLJnR69pgcURKhmTVNwqRl8sbzLKKtuPbhDHkdYHHS9gUxyBsV0TF2XiCaznY0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by OSAPR01MB3492.jpnprd01.prod.outlook.com (2603:1096:604:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 02:15:25 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::99c6:1a48:180d:dfd1%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 02:15:25 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Topic: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Thread-Index: AQHX/XbsojLLXTBWKk+I52jDqCmDKaxLkGOAgAmTrACAALgQgIAAI8AAgADeDYA=
Date:   Fri, 7 Jan 2022 02:15:25 +0000
Message-ID: <61D7A23B.40905@fujitsu.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com> <61D6C9F9.10808@fujitsu.com>
 <20220106130038.GB2328285@nvidia.com>
In-Reply-To: <20220106130038.GB2328285@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e36c980-761a-44ba-4c89-08d9d1839141
x-ms-traffictypediagnostic: OSAPR01MB3492:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3492C288627A38F5C2C1D9EE834D9@OSAPR01MB3492.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUL6/aglICw3sogZTSAoTE8et07Y2iR7kh98gnpwnk2n1tGvT7UVmJ6AsVYo3oNnat5i/pu6MxyikepmbjFn0umxiMkL1xJJfMiUv0Xq0vdJTYw9bzkixxF3y0VK3MfwUWc/6BEG4vGwAuq4cZ0gQzVgbAEyRFkZbuHqUGIth9SDXrd1yjom63OXD+dwjQjtBh7b5Vh4LgGHVL/ca+lZuKnp6KwLsT33Kj7S5ydmvAZXF79BR+/60LQYw3pyffPGDCccAm7MGEEQuKcv8ahdzqM0A7n9X7UjINvtBngjWXn4E/Hva4rd2GcupU5QYCxt7SeL0c8pKeHSlkv7/cB6bsH8MSizbFwsiTio0CBFhj8M70YtecFwUXXWP/pmyJoXA3G6VT6RNrrmvGnqvmkyyFWJ4uWsOZhhq2mdIUbo3yko5KHdSS/T+iF4/yXCib+In7RwE8wKF/kiS/ewZpTf+sKMlGMLSxDcpUai/0inPJK5NEQVmGFHzrQRHh+8ehh16xo/WblsbICba8hXcSSxebRhrW4XPs13N6pS1gLc4KyL9g2xpz2MuiAABPVzhlA9gedx/F+H48OpUrJMt1XN7OWA8iiiEoHr/wuNeemD9lImUNKqa1oNqqJ7/nz4k29VWnqmpFGYBxQhmuAKnOHnvkUGlc3hJ3NxTeIlZnEd9NfZNXmFl26DHFHMZ1lhnHOb0icjn4olSSpmECgeYrtgbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(4326008)(8676002)(38100700002)(26005)(66946007)(66476007)(66556008)(66446008)(64756008)(508600001)(86362001)(76116006)(54906003)(110136005)(38070700005)(316002)(91956017)(186003)(36756003)(2616005)(5660300002)(122000001)(6486002)(6506007)(53546011)(33656002)(85182001)(82960400001)(6512007)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?U01pOVcxbzZ4eG94MmpJSGVzUFo4bDc5Qi9mQmowK2tQSVZFYXAvWnlMUXB5?=
 =?gb2312?B?ODdhQW5zNU0rUVJDYUc5N3NuM0ZWOUNlZHBFeVBrOWZIRmhsa0FrajViTmxB?=
 =?gb2312?B?UmcrWko4OVB1ODVEaEYxcFR3VGZuNk5KREQ1bEJRTitpZWtPUUt1aVdFZ3Ri?=
 =?gb2312?B?Y1RmMHB1a0I4RmpFU2VRbVhsNWVBdTIyL04zbVVjL1FBdktjc0ZCZHVyQWs1?=
 =?gb2312?B?cG1nQloveHlwTzBkQk9aTkVOUC9FL0c4WVBoZ3FhSUlobm0va3FlVGw5cGl2?=
 =?gb2312?B?OW1GV3VFbmtHUmRCTlFaWTlKOTUrb3JSTCtEbkJVaDVzd0poYzZ2M2YzOVZj?=
 =?gb2312?B?RTBpT21rUDJjdUk2UmN6SURWMWtOZ2Rhd0xQZDdCUG1UdmpwbytyTnRRTUZy?=
 =?gb2312?B?NkRmamhGREIxRkN2RnFweldMNHdWYlI4dnhPS2s5c1Npb09BbUFXNWx2SGM3?=
 =?gb2312?B?Zy9GWlgzZXB4UmdaUzNvWkdKdzhONDVSYzE2WDJ1Y0VYWGRaUlcyNVdTQk9s?=
 =?gb2312?B?S0srWUNzbVdJeVNzRmZ5NXlrQU1hMER5U01MTkdISVcwVk43UXE4cXpXM1Ju?=
 =?gb2312?B?U2wwQUlQV0N1MXBvTlpYTzJsQ0dBU0lqY0Y2Y3cyZXlYTVZKcEtFL1BUVXFS?=
 =?gb2312?B?d3lDL2FqZEdEVnZPV0plK1RMVmtvSk4zRTFZUXhEWUZwWjlKb2hRTUtmekJ3?=
 =?gb2312?B?a2RsYmg4VTVtbko1RDFRdGVHbWhQM2N0NU8yZmthNS9NY2lJamZDZmFHVEJR?=
 =?gb2312?B?VHBDUzF2cmplT0hTY25XVkpHa0NRWXI0Y0prSVFwR0NzRG1IUk9BQ0hiNEU4?=
 =?gb2312?B?bVk1V2xLbCs1bGUyR2h3aGFKMHJ6SjFyd2ZCaFhJMWwyVWxEaVBGa0NNbEx3?=
 =?gb2312?B?TG04ckpTNmdLcHVja29xM2pKNGlBRllBM1ZrVWhTLysyQ1RWa2VqelF3WVJH?=
 =?gb2312?B?eDFwbVRTdWJ0RlovK3lGeGR1TVMxMHhGdDJlb2ptWVZ4cUpTa09yUmsrbU1T?=
 =?gb2312?B?cWQyQ09sakQ1VmxyOE1xWmZCd2YzV3A4YXFKTFZiYVhFWUdySUU0cFltVklG?=
 =?gb2312?B?MTBhc05VSGwwRUM2dk8rZjl5elFldDJhbVc1M3ZyeVd2Z0IwZVU3cjA0MWFy?=
 =?gb2312?B?aHh5Z2VzeGJYMUt3QjlQSzkya0p2NFlPb3RPYTkrUlpRZWVteG9iQUVuRXBl?=
 =?gb2312?B?RHNSdTVuTmNmZk5MYkZtWklmUEtHRUdZcXRjeG5rN3V0TTZJRk82OHpvV3Jv?=
 =?gb2312?B?bDZCdkQrTVppcVVGUzZXemQrMldMWWpYQVVJSXJWRnVsWnVuc3BCVzlUV3p4?=
 =?gb2312?B?NXdLcFpqK3lRTDNVdUhHQjJnVVFNQTg2M0FuanArMnRJaUhZZVNVbHNQRWFO?=
 =?gb2312?B?anUvTmxEdWZjam05K0R2eE9ZS3ZOY0U4eWo2b0FoRnkzdGpNYnhBS1ozUTVo?=
 =?gb2312?B?Skd3TG85Q1Z6TllhK3NoZE1JWWp1STlDdDlIZDZWekhrUDE2ek1tQkJjd1l2?=
 =?gb2312?B?RTFrQjVJdEFLYjNySEJ3RmN1RGt0dzMrV2VEVElHU0ZzdjlpZ252aEtNZnVS?=
 =?gb2312?B?VjN5QXI2eTNJUEJGZ1lxelZKL0t6S2s4b21tUnJ0R2tHbFBHUkRzSEJySFJw?=
 =?gb2312?B?eGZQZ3BtYm03c2xVT0FJWkJDR24rSmNIRkVvTGF5TitTKzBJMVR2NWpwUUw3?=
 =?gb2312?B?Z3Jtb09oYVZXR2ErMW9qT25UNW4xWWFQQlRqTHlycFVMMGM0dG9zcUY3RVlS?=
 =?gb2312?B?SEI0dXF6ekJLS1JFSUl4ZSt3ekdmQUI5Y3JqZnhKY1JjelNrNXZka0xJZThF?=
 =?gb2312?B?ektRc29aczN5TEtpcnBlVUdVNHNra2NvcllRK0VKRi83MCtDdWZSeWpicW4y?=
 =?gb2312?B?aWtRSUh0QlM4SVVBY1lhcHZNenUxdkFJNlc3bVB4dlUvbGFxRG9GdENMQUN2?=
 =?gb2312?B?THJXVVp3a0I3YVpkazAxNWNES2pKK0hnT2c0YW9uZDd5c0xpL2lMMDNTcU9x?=
 =?gb2312?B?QUg5U2hlYnl5WkZpbXZDcXdsNFNSeWFoWWtRY3BmbHNNMnNzU0hvYjlyV2ZE?=
 =?gb2312?B?M0drSUVEMlVjQlRmakx3T0s5R3ZxeXNjRkRMUFJLYjNFSDFYNzhLdUY2RUpF?=
 =?gb2312?B?Vmw3Y21tUHNHY2JWTmR3QnlKMmNHOUdBT09WN1NLSG5QMXI1K0Q2NFJKOExT?=
 =?gb2312?Q?2ybDmIbZpNjydhrpGQU9tMs=3D?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <115A14165603A141B66E0EE62AA7FD12@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e36c980-761a-44ba-4c89-08d9d1839141
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 02:15:25.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tv8fgIIf9J+fuyhwNdYjUnayV6WCYtUPZEhdyoyn4UDhBmgw1H0jrkWFcqQMJIfyGuX/eLXVxLFUCTqQNX2Zpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3492
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8xLzYgMjE6MDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gT24gVGh1LCBKYW4g
MDYsIDIwMjIgYXQgMTA6NTI6NDdBTSArMDAwMCwgeWFuZ3guanlAZnVqaXRzdS5jb20gd3JvdGU6
DQo+PiBPbiAyMDIyLzEvNiA3OjUzLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gT24gVGh1
LCBEZWMgMzAsIDIwMjEgYXQgMDQ6Mzk6MDFQTSAtMDUwMCwgVG9tIFRhbHBleSB3cm90ZToNCj4+
Pg0KPj4+PiBCZWNhdXNlIFJYRSBpcyBhIHNvZnR3YXJlIHByb3ZpZGVyLCBJIGJlbGlldmUgdGhl
IG1vc3QgbmF0dXJhbCBhcHByb2FjaA0KPj4+PiBoZXJlIGlzIHRvIHVzZSBhbiBhdG9taWM2NF9z
ZXQoZHN0LCAqc3JjKS4NCj4+PiBBIHNtcF9zdG9yZV9yZWxlYXNlKCkgaXMgbW9zdCBsaWtlbHkg
c3VmZmljaWVudC4NCj4+IEhpIEphc29uLCBUb20NCj4+DQo+PiBJcyBzbXBfc3RvcmVfbWIoKSBi
ZXR0ZXIgaGVyZT8gSXQgY2FsbHMgV1JJVEVfT05DRSArIHNtYl9tYi9iYXJyaWVyKCkuDQo+PiBJ
IHRoaW5rIHRoZSBzZW1hbnRpY3Mgb2YgJ2F0b21pYyB3cml0ZScgaXMgdG8gZG8gYXRvbWljIHdy
aXRlIGFuZCBtYWtlDQo+PiB0aGUgOC1ieXRlIGRhdGEgcmVhY2ggdGhlIG1lbW9yeS4NCj4gTm8s
IGl0IGlzIG5vdCAnZGF0YSByZWFjaCBtZW1vcnknIGl0IGlzIGEgJ3JlbGVhc2UnIGluIHRoYXQg
aWYgdGhlIENQVQ0KPiBsYXRlciBkb2VzIGFuICdhY3F1aXJlJyBvbiB0aGUgd3JpdHRlbiBkYXRh
IGl0IGlzIGd1YXJlbnRlZWQgdG8gc2VlDQo+IGFsbCB0aGUgcHJlY2VlZGluZyB3cml0ZXMuDQpI
aSBKYXNvbiwgVG9tDQoNClNvcnJ5IGZvciB0aGUgd3Jvbmcgc3RhdGVtZW50LiBJIG1lYW4gdGhh
dCB0aGUgc2VtYW50aWNzIG9mICdhdG9taWMgDQp3cml0ZScgaXMgdG8gd3JpdGUgYW4gOC1ieXRl
IHZhbHVlIGF0b21pY2FsbHkgYW5kIG1ha2UgdGhlIDgtYnl0ZSB2YWx1ZSANCnZpc2libGUgZm9y
IGFsbCBDUFVzLg0KJ3NtcF9zdG9yZV9yZWxlYXNlJyBtYWtlcyBhbGwgdGhlIHByZWNlZGluZyB3
cml0ZXMgdmlzaWJsZSBmb3IgYWxsIENQVXMgDQpiZWZvcmUgZG9pbmcgYW4gYXRvbWljIHdyaXRl
LiBJIHRoaW5rIHRoaXMgZ3VhcmFudGVlIHNob3VsZCBiZSBkb25lIGJ5IA0KdGhlIHByZWNlZGlu
ZyAnZmx1c2gnLg0KJ3NtcF9zdG9yZV9tYicgZG9lcyBhbiBhdG9taWMgd3JpdGUgYW5kIHRoZW4g
bWFrZXMgdGhlIGF0b21pYyB3cml0ZSANCnZpc2libGUgZm9yIGFsbCBDUFVzLiBTdWJzZXF1ZW50
ICdmbHVzaCcgaXMgb25seSB1c2VkIHRvIG1ha2UgdGhlIGF0b21pYyANCndyaXRlIHBlcnNpc3Rl
bnQuDQpQbGVhc2UgY29ycmVjdCBtZSBpZiBteSB1bmRlcnN0YW5kIGlzIHdyb25nLg0KDQpCZXN0
IFJlZ2FyZHMsDQpYaWFvIFlhbmcNCj4gTWVtb3J5IGJhcnJpZXJzIGFyZSBhbHdheXMgcGFpcmVk
IHdpdGggcmVhZCBhbmQgd3JpdGUsIGl0IGlzIGltcG9ydGFudA0KPiB0byB1bmRlcnN0YW5kIHdo
YXQgdGhlIHJlYWQgaGFsZiBvZiB0aGUgcGFpciBpcy4NCj4NCj4gSmFzb24NCg==
