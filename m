Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE74E7267
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Mar 2022 12:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355840AbiCYLqf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Mar 2022 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Mar 2022 07:46:35 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75ED3AEF
        for <linux-rdma@vger.kernel.org>; Fri, 25 Mar 2022 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648208702; x=1679744702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FHZHDA5KUD6LZCa8q+rhzQkF9oZfx5/MPK9y6VSt7a8=;
  b=FlDRF2hD7lFkFRCA9GpXXPadMo+6a0w1l1ebWVDyxAN9qzKfqW7usKkf
   RIRFQW97P1H2pmSHvewbOyRUvAW8trWKTLRL0XK8+K2ZY8DBeu3oB2LKc
   ZdmjF1FYhg1FxlWqY8ZzB+4TD27yUWyMs7V+I4jckQGJl8XvVDxdQ36pX
   NrXPcLv/+CUSPpINA7Mg7q50hswQtXvL+QRIY0QOWLQUFvdCyx6z6v5Qc
   n2lIgYa2/zR0D0odizGcu6Ri7BrAyh2sVv7pZ78DUw5rETTD6Ka4mHmHP
   kaB6wgC2Wx0cvRG1Hol6UVkm6RRNhqKJPGXkq3kCu0sL9U1Z+DjKVhMrZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="52507037"
X-IronPort-AV: E=Sophos;i="5.90,209,1643641200"; 
   d="scan'208";a="52507037"
Received: from mail-os0jpn01lp2107.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.107])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 20:44:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlxE4z2fDNGBhBjjlPEMD/Ojy/ku65o+2G80Vd+kqfiSfBsXYci+H5ikZvFpanm421U2PlpsXGUyP+S6PVnk4XQ8Tpz++uygMmAzxx+7pSslyw/TnUMrCVdhVnTiCnfGvflUbAlUyTamUOYSps8hKpZ/GPT19DSSLN/jXw4aOlHgOGb8lmmiuclOeWmYNOUvTmtaLDKyuQj5QU3iLM8y91ytx43nhsN0zi5Ri2Y+jl4SSjiohxm9Auo91NEkP8pyhf0ZXfEqw1Ijm5NPGQYDf9f/bBrP6sbU5YMyvcmPpMqXTg2Drwd0+WwKfaPAukw47TbbePP5P6aPxWJIdHbAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHZHDA5KUD6LZCa8q+rhzQkF9oZfx5/MPK9y6VSt7a8=;
 b=nl/39aFUwUzvK0G5ZmePcybwuX8oBjhOk+6w2bwC/M7k1fW8fYC1sr7f6L9XMTWn1sK3IK6dHwq0U6c5In+5rx2HYrgz4TXjAAfKWe6xSaRuhxuLt7Hcs8pQoOX0PYPkNHR+9zVO7/cauI3ddGesT4db9BS1EcFpxgWApFGgPacppqP2sokUMawcKawPr8LQNlLBgTf2TmWs3EaNjqlGF6dhLIcxn21wKBEmLWrVloXjkiaMCg3F06y65vWiOoqtW3I1SvDJQ445dFyMcao/uBtuClQqF33st+keuJAW1/ZHM/mjkZG6NmcTuO5e6nPQLiLkwf9uEfTO9mu8Ar9z8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHZHDA5KUD6LZCa8q+rhzQkF9oZfx5/MPK9y6VSt7a8=;
 b=H+AK/gEgmcx0Y4PoEXJMKaGYoWto/MyJc0cDKGooVjk/jEAH3+aP85OFwYpeg3eqUAOifg4O5WCPWnEjNArIEwRVUMrEIDw7EoL4k0mU0gaiLkptvRzw+1/4I48h+ioPAuPLpVfLkytXa46SYy3ybanBpxBsfVHwXi88wAVe3n0=
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com (2603:1096:604:104::9)
 by TYCPR01MB6431.jpnprd01.prod.outlook.com (2603:1096:400:9a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 11:44:53 +0000
Received: from OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da]) by OS0PR01MB6371.jpnprd01.prod.outlook.com
 ([fe80::535:f301:94fd:62da%8]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 11:44:53 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Topic: [PATCH v3 3/3] RDMA/rxe: Add RDMA Atomic Write attribute for rxe
 device
Thread-Index: AQHYNT6Zd/sV5d3li0GAOL19eVqOcazA0W8AgAhy8oCAAMLcgIAGCbqA
Date:   Fri, 25 Mar 2022 11:44:53 +0000
Message-ID: <c4442831-0704-ed6b-f2a7-ed8288d2944e@fujitsu.com>
References: <20220311115247.23521-1-yangx.jy@fujitsu.com>
 <20220311115247.23521-4-yangx.jy@fujitsu.com>
 <20220315185330.GA241071@nvidia.com>
 <0dcc96af-1d0f-100c-aa17-d423a45f9062@fujitsu.com>
 <20220321153225.GX11336@nvidia.com>
In-Reply-To: <20220321153225.GX11336@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df8bae3c-0050-41c5-6cee-08da0e54e0b2
x-ms-traffictypediagnostic: TYCPR01MB6431:EE_
x-microsoft-antispam-prvs: <TYCPR01MB6431D4F3208FB5764FAD1F31831A9@TYCPR01MB6431.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nis8QEoEVt71IeX1vWfQkk3i3jaC5tQGDJ8p4GKifstkNLY8MAQT421ZRUmYc2E9t0r5oNol4IVHyuS9e7vQNOBqfqGxFPbPqCo85Omp0s56EBvfnxEJAoPRPa3trKCaxFkUFYlGjAW2EVxQ1VoJm9gzK6Vgn44LMmhZXlYhFcqfMfHxIhFPow0rP3wBj7O1tNWSbzxCsRvBs1/q9rdaGdu+MaUczqYMZUBzkSw1X13MeCnL8l2bqOtQ8NGtc7gKm4Y1ukMa7Rr/fS23pcfFaL9TB2DVg08lGKUFpNJctr986h5cvEUYdB7mcB/4bllbybEE9FM1rDEszz8MVWDK+db0ii0vNDoWvJEW90MIixTOzU4W987B4OL2h8zFcA6AMxQoBVC+fnBrDdBm4QeHHmNJ842dmYtfdDzcT7gt8oO3XySywOATd47vpasHiw+jFCawveka1Q66OyUTdbyokY6AhKo0TzqoH/1TbbujXk1zvPuOThXqcHAr3UsrE06idevPMgY0P4fITAUsa1t3POGdwpb1gpzBZuzmMID/6ei2VNNKP+BDltUm3aa+JUZjy06tQVxPbpCwFTWVR+hxY0OJQ2Vo0pwAqbZtM44Pykr0CoBY6hOI9blEO5E/9zLyDKQxrEnEIP1D43DwRKc5FjBS+Dn1B1YtjtWq5lp3VxwR45aCrf+Hxy6EsRALVTRovbrbm8SBAQ+3wcE2VG8+D35ubeHX5eR1P4ZRVHJ6BBvdhqQhwDWgHYVO+7kP8hMY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6371.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(71200400001)(91956017)(31696002)(82960400001)(4326008)(5660300002)(31686004)(66446008)(6916009)(508600001)(64756008)(54906003)(66476007)(26005)(83380400001)(66946007)(66556008)(2616005)(186003)(76116006)(38100700002)(4744005)(122000001)(316002)(85182001)(53546011)(6486002)(38070700005)(8936002)(86362001)(2906002)(36756003)(6512007)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkljVFJFQzBDbzQ5MitHWHI1STh1QmxnU1lGZ0lnQnZKemVod3R2di9YcUEr?=
 =?utf-8?B?UHFuZi9aQU9aWVowSzJNODZ3M2dIT1BNZ2NCZFBtcFVkN2tYTGlwV1VXR2Iy?=
 =?utf-8?B?SWhKVm5PK0t6WnNHRFRGaGFZUXlUdmF5NnMzN2hPV0QrMnRSZUZENWs2UG92?=
 =?utf-8?B?S0ZPbWdzdzVDNk5qVzBOMC93Sjc4YXZVcmdHMGorY21hKzJhb1dqSVVFcVdQ?=
 =?utf-8?B?OThrS1JxMkEyM1NDcEU3ZEJzT3FpemZYRkxodzVKZXJEaEJGODVldHRrL0w1?=
 =?utf-8?B?Z0dGUGFhVjFkaVJrMzBHN2FnZUxPNG5mSjhubk8wY2N0ZTlEQUhMOThtMUpK?=
 =?utf-8?B?VXVqcko3K21VQWN6Y0dTOGtwM2NLNjFuVFVVM3doLzJjMVErbkZvbnEyLzg4?=
 =?utf-8?B?WDRMRGk5d3hGYjJKcFIwZjBELzA1bXFWaEk1S2M3RFZ4OXdiaEhxQ3RUbXAz?=
 =?utf-8?B?SGoxVVc0cTE0YVZvS2JpMmFMT0xZdW0wNm52MXJhWnlITlQwYWdPYVArOHk4?=
 =?utf-8?B?dVFJSTlJWHhFV0lkN2NTc2FEdG1PdFhxckdVV1p4TFMwVC80SkZYYU5sRjcy?=
 =?utf-8?B?a2c1dmE3cXJTajVOL3VQUmZIT2pHS1Z6dVBySjBwd2lLeWo3bzFoeUxpWXRx?=
 =?utf-8?B?emlYclEwSE05dkI0V3hvZTZLWk1TVTc0VmthTENLcXkzZm9CWk8yMjkwY1ZG?=
 =?utf-8?B?aUovM1Y0ZEVkdFBPc0JQdDdBSGlKSDVlS3ZiN1JrOWJIcTNEdWpPcHFURzdC?=
 =?utf-8?B?M0lqOEJBUXdZVTREMXdGakxyMlArdlJGRFpXcVRBNk5DOUhBMmNWRktsSHZm?=
 =?utf-8?B?SGNkek93aFljTWh5djdzaWxmNGkwaWZkOUNYZ09Za01Uc1BSNTdXWHJVUEdK?=
 =?utf-8?B?Vms3My9EVWZJeHJwSGRBYkhzMjdHQ2pnd1pJRHczeXVIcUZ5RlRac3BGT3lW?=
 =?utf-8?B?WXpTRm5mZzltS0gwNk5aRm9ndzlXbmVoZUZsZkZNc2VUcm5RdGFSYnllSmVK?=
 =?utf-8?B?R3RsR3hocmR0WUFRTEd3RFNxMEVtNUZFZUFpYWFyRSs5NDYxeExXSEd6RE1m?=
 =?utf-8?B?ODN0TXZxajZaRldZenNxdzBQeHo2WkRRT0pzUmNWL213TDF4MnNyZjlQS3dR?=
 =?utf-8?B?dnNKRVpxMk8zNzVzNWZJQ25NRDByd1NSaHZVNnBFOXl2Nmd2b0kxdXR3cUNN?=
 =?utf-8?B?VjFDSkNNSFlxbjZrdnBIZTA0SVU1Z3JBRFppWE5na1BkZTJwbWtoSnhINlhu?=
 =?utf-8?B?QnJ6b0hpV3hheFpkNFZ5b3VSbDFCTTJaWndOOVJzWFNtQldvVldCYzZMdlZI?=
 =?utf-8?B?WWl2SWNVVXFRdXdaZE0rOFBzQ1BaOUQzVm8zNWhvdGJKRkVQZHhXNnhmd0RE?=
 =?utf-8?B?QWJZQzIwamhqQytJaEZmdStmLzZxSkZoS2ZXaHZnVmNjSTlnQ3FETXNrcUdS?=
 =?utf-8?B?YWwzNWpueVc1OHk5U0tqTVRGdGdsTll3NTZkTFRnNnJad081djFrTG1iTWI0?=
 =?utf-8?B?aHBGZ1dTc2ozanpIdXdiWlZoRW9tZ3dZQjkwUHVBSEdXT1hCY29FTjMvSHBX?=
 =?utf-8?B?V3l6UjRIbkpuYlNUanVSNWpKZ3JRaWkyZUVQUGZyZnBrK0ljUDlxWjhaeUpk?=
 =?utf-8?B?Y3RCSEZkd1FQMUY2Sm9XK2JyblhlazF6K1NZNVN4cDlCQ2t2Q0k2NW9URGV6?=
 =?utf-8?B?eE1CWDhLNjcybzRXUUpDSS9TNCt2TXNDQVU5KzRNdGV6LzFLeWhFS09NTElJ?=
 =?utf-8?B?cFJsS0d6aThzSzQrSE94OVNKUUlPMlNIS2FoM045QWRJcFhOU0NFdUYxcnR4?=
 =?utf-8?B?eXpxZDZMUHU2aUxtUkNoMWtCcHl3anowZUtoenB4QTc3cGRvYlhmeTlWUXJq?=
 =?utf-8?B?SkhDUnN1d1kxcnJYMFJZdEJ4M1pUYlRzUDczZUlYM2RKcWtKNzNwT25relVp?=
 =?utf-8?B?VDBkdG5lZVo2eUZ3TFVtejBNOUZYQkhXT3JNZDRJTmhzankwMm9XZisrSCtw?=
 =?utf-8?B?WGhaWi9RYzlnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <337E80DD322F764BB8DD81FE54F87B51@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6371.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8bae3c-0050-41c5-6cee-08da0e54e0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 11:44:53.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rQWwQWuzlfLq+1nyqcTE+IagBXXtfpUwJUUOcx+nbUyeZFl2EO1G3VAcBEBMrRMGkYhJ5S0AZmGIFjEdZt8Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6431
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

T24gMjAyMi8zLzIxIDIzOjMyLCBKYXNvbiBHdW50aG9ycGUgd3JpdGU6DQo+IE9uIE1vbiwgTWFy
IDIxLCAyMDIyIGF0IDAzOjU1OjAxQU0gKzAwMDAsIHlhbmd4Lmp5QGZ1aml0c3UuY29tIHdyb3Rl
Og0KPj4gT24gMjAyMi8zLzE2IDI6NTMsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+PiBZb3Un
bGwgYWxzbyBuZWVkIHRvIGRvIHNvbWV0aGluZyBhYm91dCB0aGUgMzIgYml0IGNvbXBhdGFiaWxp
dHkgdGhhdA0KPj4+IGtidWlsZCBkZXRlY3RlZCAtIEkgc3VwcG9zZSB0aGlzIGNhbid0IHdvcmsg
b24gMzIgYml0IHBsYXRmb3Jtcz8gU28NCj4+PiBJU19FTkFCTEVEKCkgaXQgb2ZmIG9yIHNvbWV0
aGluZz8NCj4+IEhpIEphc29uLA0KPj4NCj4+IElzIGl0IHBvc3NpYmxlIHRvIGZpeCB0aGUgaXNz
dWUgYnkgYXRvbWljNjRfc2V0X3JlbGVhc2UoKT8NCj4gTm8NCj4NCj4+IElmIG5vdCwgd2UgbWF5
IG5lZWQgdG8gYWRkIGEgY2hlY2sgZm9yIF9fbmF0aXZlX3dvcmQoKmRzdCkgYW5kIHJldHVybiBh
bg0KPj4gdW5zdXBwb3J0ZWQgZXJyb3Igd2hlbiBfX25hdGl2ZV93b3JkKCpkc3QpIGlzIGZhbHNl
Lg0KPiBUaGUgd2hvbGUgZmVhdHVyZSwgaW5jbHVkaW5nIHRoZSBjYXAgYml0cyBzaG91bGQgYmUg
dHVybmVkIG9mZiBmb3IgMzINCj4gYml0IGJ1aWxkcyBiZWNhdXNlIGl0IGNhbm5vdCBwb3NzaWJs
eSB3b3JrDQoNCkhpIEphc29uLA0KDQpJcyBpdCBvayB0byBkaXNhYmxlIHRoZSB3aG9sZSBhdG9t
aWMgd3JpdGUgYnkgY2hlY2tpbmcgQ09ORklHXzY0QklUPw0KDQpCZXN0IFJlZ2FyZHMsDQoNClhp
YW8gWWFuZw0KDQo+DQo+IEphc29u
