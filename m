Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9728575A05
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jul 2022 05:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiGODiH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGODiF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 23:38:05 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5FB74E36
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657856283; x=1689392283;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=LELLnPbZGODvdbv8iXOqoKQvsz5Edu5/ykpm+fXkXM4=;
  b=m7VoZ+IcRmQsgFMJKRbXhQnI9XHdkoZlwQvYAhPApKF4cpjB9f2c5Zjt
   qazNxEDbgmEq/NGVUOJ2GPk2qYJdgPC21CRzEEDFf3f3wGqypoYhlVedD
   Qx+nGYfvP22sZtI3dg0dG5XrTwXa2nqCcv2KUAti9eIJivv1a2sczbSaB
   xyI8N9gOA1pXxEzgwaCGUk0ILQFAbvt9i/88DqGdbFMcQNPT8poiIpiNd
   7HLtJfoIPxRmAxqWkJpexbJ6470KuUU6+at6wWVnP2dUvEvRhNPtK4b+O
   GTyBuUljjyOGWZxn2yNKNlAjCznKRjUXy+eYNEGqsDQdJdr577yIKwS8L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="68529034"
X-IronPort-AV: E=Sophos;i="5.92,272,1650898800"; 
   d="scan'208";a="68529034"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:37:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/ElXXVp4RO9xcootwvja+/VR4VMXgORAZjm0vJmG5mxWaHe9nw8gP2VaMoR/jl5207clFNoWuN/3KzPCiCS8iWGweth5+mVYjGllrcO7R41N2ryZxaYGZbMHW9h3TEILMkrQZ7JpwUx5TX9t1Q3j0kpsOKiRCKags3FbtYbgLy9btctcIInShv01EvOluuj6Lwo9Lp0B+aH9CpXvooMFyuFtvSEC4uuDwPZCq3bBVwzhgB0XC4wggurXwKSE9A7Q7S3Vfh9bXgQbsVWwRHksPNZGpy08c6XQGSBx5gnketjga0FY7J3cALA26sEU6Rb5ye1dO4wxm7nOinmQoWYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LELLnPbZGODvdbv8iXOqoKQvsz5Edu5/ykpm+fXkXM4=;
 b=eQcBhWV5IFluVHoEnaAC9Ef1li2q4arlRt0d1vGLQ1WuA12cLJTmFbWA/+E6eV59UXI9Qa2V0kINLI5efW0o8XYuvf/tcqcl9uVtlhZ/2PV3YnImHA4t1c/gWABBCcwynd357hSiGA7IFX0aJ5VRQkJJrk+0W4PRTf9IlzOL9KYn54WA6eY0V89rnvRsCgltVhcnnRoWIJhK6oQzz8bU4XFEsYln4yt+XOU5kOcKytEIwPw8KTehOYI/zQGIxdPpGYLfYVg2GZK8WpbBh6JVBptosQ41r6+85xhE2O5H3689/Kzu8iqsfH9Z+ilZli+p1BgG6Jq/sTAJd+brjE5K0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LELLnPbZGODvdbv8iXOqoKQvsz5Edu5/ykpm+fXkXM4=;
 b=ChEvApXz/WQf63ASHB1hIdKkzfVzSy1+q99ZO4bGpaJlD1xdIj+H0PeyfxJKRYZPC8uPN+TtkLzbIUUhp6NByULn0HR1QfKnk2qIwO8UcP408MP/lCBzw2k9hsuB4iFZbPmuqLAAEsYwxQ8+IRhti8/K/5lFuFmDm7fcwgmgYrM=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB6048.jpnprd01.prod.outlook.com (2603:1096:400:61::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 03:37:57 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%7]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 03:37:57 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Topic: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Index: AQHYkRm6Bw1pQgLwyUy00KjkER3CY61+FxgAgAC/PwA=
Date:   Fri, 15 Jul 2022 03:37:57 +0000
Message-ID: <11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com>
References: <20220706092811.1756290-1-lizhijian@fujitsu.com>
 <c82760f8-8774-a90e-7636-1c8954c007f3@gmail.com>
In-Reply-To: <c82760f8-8774-a90e-7636-1c8954c007f3@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7597391-5f8d-4e8f-3ae5-08da661368be
x-ms-traffictypediagnostic: TYCPR01MB6048:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oLuz/chIpez+7oGStC65k2UPnQz1FRiWHWV9g6eu8W5T5FYT68kWzpMQY05fspx+wpv9d+FenQ91H2U6x1BJfDd0bTWa+TwGnsP316HqFezj90byXi18CcZdaWogW/fLwUl+lmeS7DpwV80Mac1R7OEu+xHhMuM8CuukSiW0aEKp4sI9IyGHJI2ijL+c8qzMlv1+ehKyDY0lrWy7ZOZDgvlpruFvGyV2I/LEu7iuNBR8P7PhjokvA0GQvL2NuxxyLhhtfwQSM5AZGEpK1p3Lgb7v5cwb0mzspNDqr5Jts+0aoUk7lN7502W31WmBgSzpIQuXWv0tJ98y6lqSgtb14/fmOKLF8A+kOqsqHHYiQdNfpCUpr4tPl1vf6qaCe+CnH9iuvta2p0eUa6TQFrDUwiEmMC7dT2E7elmFuxvgDizb9+JIuzdP/rMRCZqR7dNF+JrAX5WisRsWG+Ohi2lMs6AfjQ68EVgPHF8Fggl1+MNQeOYWoZKESdNxBYL6cHPJMYm+O0EfAc6yrexQVZI61dY39Om+2uMGlBH8lXZGA+ki49aI+TAeDRDSP++/PgQbedICyCYJqteMMzRrHx5dB2uuWwtgMMDMajmn/I/ESsxDc1CxuSmMtaGP1h7QCkNTtA/gyh3aA6xfVLeogWDjytNZ2iP5X6uhz7Wj+FcXat0Ghr6p8KhDVFMfyYtTBAK3f5oIZOFaT61MqGx+JKJGp+16wh0qiHSomipRMdhhEd+S+pXyGvMhvKbM736ZMcz9Sn33+qFYQWtvaEgb/bLiNo83ALdXpOKKUBqODZkrgNrFq/ZqlZq1PfAYVNUk9R4qhN5QjFsJZaV/z2qL5eviAvXan/m8fxDcWhf+a0yhXUTr8vtkBK9IYwJ9in1LP9us
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(8936002)(5660300002)(8676002)(2906002)(66446008)(122000001)(86362001)(31696002)(83380400001)(36756003)(85182001)(38070700005)(38100700002)(82960400001)(71200400001)(6486002)(478600001)(64756008)(66946007)(76116006)(66476007)(186003)(2616005)(91956017)(316002)(110136005)(6506007)(53546011)(66556008)(41300700001)(6512007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUphSzNrcFJXdmtjVWVzV3Y4TkZJQlhraUJ5clJMcmdjT1licmg1MlFqRkkw?=
 =?utf-8?B?ckYrSGQvMEJvUjlQMHNHTzI3d3QxaDdFdkwxMGJzM0dLd2ZZVmdrQUhZcGlH?=
 =?utf-8?B?VzRKdDFRc29uUU5MNVFkNkVFWFcvQVNYdHEwUGpodlJNcW8yTGhKakZDNWtG?=
 =?utf-8?B?czV4OG5RMUE5Z2xib0wxZGY4ZUk3Zy9XZmQ3ZWUzVVVXNGFYcVB3SlEzajZI?=
 =?utf-8?B?U3hkZTFVRThuZCtPWjFvMlBFS1hUVGE4SzU5eXBlZkdHSktxeFUxdmI4TWJS?=
 =?utf-8?B?Zk93R1lXNEhQNnc5SmxJOGEwdjNvUjFyS0hkOGUwZFBPMFR6Y0Y0Yzk1bVlI?=
 =?utf-8?B?VkZSckVDV2ZKWVFuTC80Y3U3MGZQQUpTaDVmT3p4dVpIY0F6NEFoK2w4SGd4?=
 =?utf-8?B?Vy9LUmlxbzNMckZJaWhWSUptR1NiV2tQTE9kRUVlRHc2cStDZHQxRkczM2Vr?=
 =?utf-8?B?VStTSHRuT0hDK2QyZXdMdjNLamt1NGFxQlVLTzF0Z1JLbk5KYU40NEx0WVZo?=
 =?utf-8?B?cVoyem9XeVB3V0hPQ01TRGFTNWtBeldMKzdsWGR1WTMvZU53aVJWYWpWSTJF?=
 =?utf-8?B?NDJDOUN5cVFlaFdteFRDMXhwM2cyMXRBbEpPaFJ3K25VOXl6dmJIQ3hjQU5P?=
 =?utf-8?B?eDFjQ0xka0VhaXRZRDVhUTVsWFU1c0wwV2paWWZCL0Fnam0xeTV1VGg2MEd4?=
 =?utf-8?B?c2NVR3lwdkxhRzlLdDJjUUJNSytjNHRHMkdENjM0SzRmbXU2M0dIT1R2Wk56?=
 =?utf-8?B?Z24rb2tzRlJHaGtqQ3RNWks3Q0gyTnNod1hST1VDZUNKWFcwY0JsRU5DNVB0?=
 =?utf-8?B?aHVNMXczZEJBa1o2Q2YydkJDWlEyWm9kVkVGZm9EMmdwdWQwa3FhYkc5LzYw?=
 =?utf-8?B?YUVITGZCWGFpQ1BBbnhSOFBCdkF1WElLeEhzaHphTXNsQVNjbm9PbTFKM1R3?=
 =?utf-8?B?Yk90VmFSLzdCU01zY1VCakdaaStKaUl5aS9MQkdxbzNkekNJUDBTTFVPTHFs?=
 =?utf-8?B?bkVRTVBZcm5FTXlxWDlwUkpjT2UweUUzaDMxN0VjdjB3YmJQYWxpQUZNNVo4?=
 =?utf-8?B?aXBpcGY3Y3pnL2JzWk05Vnp6Z0QxSDZERVZyS2poQVZMOWUrWEUvc0tUZmxR?=
 =?utf-8?B?M1lTWDJCZnVTRUYwWnc2UnZlOFJvbjhJZTNwc3RGOWtvZGpYQ0lJZ2h6UzVR?=
 =?utf-8?B?OFdVWGlCNnRCSFhpYzFpSG5uQkNPMUxhL25lNWR1aC9Yd1ZhTnJPaWplZGlB?=
 =?utf-8?B?K21ienJRK2F5ZXhTM3lWcURLY1cySERucWtlYlBQM2dZQmk5QmlUZEZOeXhu?=
 =?utf-8?B?WEZlU3EvRXdWWnN1R29FSm02Qjh0WUErNFY2OG1QeHNIMWJMM3ZFZmNta0Ez?=
 =?utf-8?B?SFV5VWNuY0xWVFI5Tm5qN0h6SGFCVjNXaUZpY1FpbzZNdmFWZC9DZk9saFgy?=
 =?utf-8?B?bEo1ZTdUeGFmMFlSdEZkeWdLMWxpQm9LNnI5OWpnazYvd1BWOUMwSmIweXp6?=
 =?utf-8?B?WG1pV0lacW5BOGprajE0THZBUGdCRWpvNFhNUUZ5V256MjJDdHBHeFZLbzFh?=
 =?utf-8?B?UFdULzZsblBnWWM1QU9XY0M4aWpIN2xRMXBTWDVGSC8yWkVsRkg5cUV5UGVK?=
 =?utf-8?B?NnFJVmorUFpBQlN0eDBYU2Nzd0kvQTByNjRkTEptNzdHd3dqNVRMQmhtS3dU?=
 =?utf-8?B?czA1b01GNkc0MXBablJYTzFCRHM4bDREaS94Rmk2eVMyVXRsakc0K3Z5bmdZ?=
 =?utf-8?B?ZUIxT3FYbXIyYWsvckdIR2lMSU90WFFJbkxnL2hRM2lNbjlqK1dZcDh1YWRk?=
 =?utf-8?B?d2lvVERPWkVQenVKbFVSY0RaNVRlT0phVTBEUGdRRWRIb3JQVG9vSEk3VXFO?=
 =?utf-8?B?cFBSRUNwbkVzOUg2TytTQ3p1dG5qK2s3MEVHNm0rRWpxZlJKZzJTN05NdTRV?=
 =?utf-8?B?NEZNRW04N3Q2Q3VmaE5RbGlXZEQxTDFxTW5rVGdLTmxFYk14N3JLWTArMmE0?=
 =?utf-8?B?d3B4M0h0RkNDUHFFWEdKejcvT0trcmJFMUJTSFEvVVBIZDR6TmdzbHVhbS9v?=
 =?utf-8?B?ZElzZ3l2L3ZCU21DL1JCdDNTT0tFWnF2cmU4Mkc5VWRIOG1TcHNpK2ZsM1NW?=
 =?utf-8?B?dXpNTklhV3BYZFBqQVVBUWFHdHdZMlJGd1ZlMW1ZTFpUbi90N3k2VGM2akxF?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22D660EE5AC56F4591924CCCC6D2AA4B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7597391-5f8d-4e8f-3ae5-08da661368be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 03:37:57.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+L+xYSzB0b3RTwr8iVZ4+Zgh4uYfuifG4/4qoq0XYmEh7sK52sgSWHQkafYNi2wekPDFDXGmksUAE1qLLQPmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6048
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDE1LzA3LzIwMjIgMDA6MTMsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA3LzYvMjIg
MDQ6MjEsIGxpemhpamlhbkBmdWppdHN1LmNvbSB3cm90ZToNCj4+IEl0J3MgcG9zc2libGUgbXJf
cGQobXIpIHJldHVybnMgTlVMTCBpZiByeGVfbXJfYWxsb2MoKSBmYWlscy4NCj4+DQo+PiBpdCBm
aXhlcyBiZWxvdyBwYW5pYzoNCj4+IFsgIDExNC4xNjM5NDVdIFJQQzogUmVnaXN0ZXJlZCByZG1h
IGJhY2tjaGFubmVsIHRyYW5zcG9ydCBtb2R1bGUuDQo+PiBbICAxMTYuODY4MDAzXSBldGgwIHNw
ZWVkIGlzIHVua25vd24sIGRlZmF1bHRpbmcgdG8gMTAwMA0KPj4gWyAgMTIwLjE3MzExNF0gcmRt
YV9yeGU6IHJ4ZV9tcl9pbml0X3VzZXI6IFVuYWJsZSB0byBhbGxvY2F0ZSBtZW1vcnkgZm9yIG1h
cA0KPj4gWyAgMTIwLjE3MzE1OV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiBbICAxMjAuMTczMTYxXSBCVUc6IEtB
U0FOOiBudWxsLXB0ci1kZXJlZiBpbiBfX3J4ZV9wdXQrMHgxOC8weDYwIFtyZG1hX3J4ZV0NCj4+
IFsgIDEyMC4xNzMxOTRdIFdyaXRlIG9mIHNpemUgNCBhdCBhZGRyIDAwMDAwMDAwMDAwMDAwODAg
YnkgdGFzayByZG1hX2ZsdXNoX3NlcnYvNjg1DQo+PiBbICAxMjAuMTczMTk3XQ0KPj4gWyAgMTIw
LjE3MzE5OV0gQ1BVOiAwIFBJRDogNjg1IENvbW06IHJkbWFfZmx1c2hfc2VydiBOb3QgdGFpbnRl
ZCA1LjE5LjAtcmMxLXJvY2UtZmx1c2grICM5MA0KPj4gWyAgMTIwLjE3MzIwM10gSGFyZHdhcmUg
bmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgcmVsLTEu
MTQuMC0yNy1nNjRmMzdjYzUzMGYxLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4+IFsg
IDEyMC4xNzMyMDhdIENhbGwgVHJhY2U6DQo+PiBbICAxMjAuMTczMjE2XSAgPFRBU0s+DQo+PiBb
ICAxMjAuMTczMjE3XSAgZHVtcF9zdGFja19sdmwrMHgzNC8weDQ0DQo+PiBbICAxMjAuMTczMjUw
XSAga2FzYW5fcmVwb3J0KzB4YWIvMHgxMjANCj4+IFsgIDEyMC4xNzMyNjFdICA/IF9fcnhlX3B1
dCsweDE4LzB4NjAgW3JkbWFfcnhlXQ0KPj4gWyAgMTIwLjE3MzI3N10gIGthc2FuX2NoZWNrX3Jh
bmdlKzB4ZjkvMHgxZTANCj4+IFsgIDEyMC4xNzMyODJdICBfX3J4ZV9wdXQrMHgxOC8weDYwIFty
ZG1hX3J4ZV0NCj4+IFsgIDEyMC4xNzMzMTFdICByeGVfbXJfY2xlYW51cCsweDIxLzB4MTQwIFty
ZG1hX3J4ZV0NCj4+IFsgIDEyMC4xNzMzMjhdICBfX3J4ZV9jbGVhbnVwKzB4ZmYvMHgxZDAgW3Jk
bWFfcnhlXQ0KPj4gWyAgMTIwLjE3MzM0NF0gIHJ4ZV9yZWdfdXNlcl9tcisweGE3LzB4YzAgW3Jk
bWFfcnhlXQ0KPj4gWyAgMTIwLjE3MzM2MF0gIGliX3V2ZXJic19yZWdfbXIrMHgyNjUvMHg0NjAg
W2liX3V2ZXJic10NCj4+IFsgIDEyMC4xNzMzODddICA/IGliX3V2ZXJic19tb2RpZnlfcXArMHg4
Yi8weGQwIFtpYl91dmVyYnNdDQo+PiBbICAxMjAuMTczNDMzXSAgPyBpYl91dmVyYnNfY3JlYXRl
X2NxKzB4MTAwLzB4MTAwIFtpYl91dmVyYnNdDQo+PiBbICAxMjAuMTczNDYxXSAgPyB1dmVyYnNf
ZmlsbF91ZGF0YSsweDFkOC8weDMzMCBbaWJfdXZlcmJzXQ0KPj4gWyAgMTIwLjE3MzQ4OF0gIGli
X3V2ZXJic19oYW5kbGVyX1VWRVJCU19NRVRIT0RfSU5WT0tFX1dSSVRFKzB4MTlkLzB4MjUwIFtp
Yl91dmVyYnNdDQo+PiBbICAxMjAuMTczNTE3XSAgPyBpYl91dmVyYnNfaGFuZGxlcl9VVkVSQlNf
TUVUSE9EX1FVRVJZX0NPTlRFWFQrMHgxOTAvMHgxOTAgW2liX3V2ZXJic10NCj4+IFsgIDEyMC4x
NzM1NDddICA/IHJhZGl4X3RyZWVfbmV4dF9jaHVuaysweDMxZS8weDQxMA0KPj4gWyAgMTIwLjE3
MzU1OV0gID8gdXZlcmJzX2ZpbGxfdWRhdGErMHgyNTUvMHgzMzAgW2liX3V2ZXJic10NCj4+IFsg
IDEyMC4xNzM1ODddICBpYl91dmVyYnNfY21kX3ZlcmJzKzB4MTFjMi8weDE0NTAgW2liX3V2ZXJi
c10NCj4+IFsgIDEyMC4xNzM2MTZdICA/IHVjbWFfcHV0X2N0eCsweDE2LzB4NTAgW3JkbWFfdWNt
XQ0KPj4gWyAgMTIwLjE3MzYyM10gID8gX19yY3VfcmVhZF91bmxvY2srMHg0My8weDYwDQo+PiBb
ICAxMjAuMTczNjMzXSAgPyBpYl91dmVyYnNfaGFuZGxlcl9VVkVSQlNfTUVUSE9EX1FVRVJZX0NP
TlRFWFQrMHgxOTAvMHgxOTAgW2liX3V2ZXJic10NCj4+IFsgIDEyMC4xNzM2NjFdICA/IHV2ZXJi
c19maWxsX3VkYXRhKzB4MzMwLzB4MzMwIFtpYl91dmVyYnNdDQo+PiBbICAxMjAuMTczNzExXSAg
PyBhdmNfc3NfcmVzZXQrMHhiMC8weGIwDQo+PiBbICAxMjAuMTczNzIyXSAgPyB2ZnNfZmlsZWF0
dHJfc2V0KzB4NDUwLzB4NDUwDQo+PiBbICAxMjAuMTczNzQyXSAgPyBzaG91bGRfZmFpbCsweDc4
LzB4MmIwDQo+PiBbICAxMjAuMTczNzQ1XSAgPyBfX2Zzbm90aWZ5X3BhcmVudCsweDM4YS8weDRl
MA0KPj4gWyAgMTIwLjE3Mzc2NF0gID8gaW9jdGxfaGFzX3Blcm0uY29uc3Rwcm9wLjAuaXNyYS4w
KzB4MTk4LzB4MjEwDQo+PiBbICAxMjAuMTczNzg0XSAgPyBzaG91bGRfZmFpbCsweDc4LzB4MmIw
DQo+PiBbICAxMjAuMTczNzg3XSAgPyBzZWxpbnV4X2Jwcm1fY3JlZHNfZm9yX2V4ZWMrMHg1NTAv
MHg1NTANCj4+IFsgIDEyMC4xNzM3OTJdICBpYl91dmVyYnNfaW9jdGwrMHgxMTQvMHgxYjAgW2li
X3V2ZXJic10NCj4+IFsgIDEyMC4xNzM4MjBdICA/IGliX3V2ZXJic19jbWRfdmVyYnMrMHgxNDUw
LzB4MTQ1MCBbaWJfdXZlcmJzXQ0KPj4gWyAgMTIwLjE3Mzg2MV0gIF9feDY0X3N5c19pb2N0bCsw
eGI0LzB4ZjANCj4+IFsgIDEyMC4xNzM4NjddICBkb19zeXNjYWxsXzY0KzB4M2IvMHg5MA0KPj4g
WyAgMTIwLjE3Mzg3N10gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ2LzB4YjAN
Cj4+IFsgIDEyMC4xNzM4ODRdIFJJUDogMDAzMzoweDdmNGI1NjNjMTRlYg0KPj4gWyAgMTIwLjE3
Mzg4OV0gQ29kZTogZmYgZmYgZmYgODUgYzAgNzkgOWIgNDkgYzcgYzQgZmYgZmYgZmYgZmYgNWIg
NWQgNGMgODkgZTAgNDEgNWMgYzMgNjYgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgZjMgMGYgMWUg
ZmEgYjggMTAgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4
YiAwZCA1NSBiOSAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0OA0KPj4gWyAgMTIwLjE3Mzg5Ml0gUlNQ
OiAwMDJiOjAwMDA3ZmZlMGU0YTZmZTggRUZMQUdTOiAwMDAwMDIwNiBPUklHX1JBWDogMDAwMDAw
MDAwMDAwMDAxMA0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBm
dWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9t
ci5jIHwgNCArKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4+IGluZGV4IDlh
NWMyYWY2YTU2Zi4uY2VjNTc3NWE3MmYyIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmli
YW5kL3N3L3J4ZS9yeGVfbXIuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9y
eGVfbXIuYw0KPj4gQEAgLTY5NSw4ICs2OTUsMTAgQEAgaW50IHJ4ZV9kZXJlZ19tcihzdHJ1Y3Qg
aWJfbXIgKmlibXIsIHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpDQo+PiAgIHZvaWQgcnhlX21yX2Ns
ZWFudXAoc3RydWN0IHJ4ZV9wb29sX2VsZW0gKmVsZW0pDQo+PiAgIHsNCj4+ICAgCXN0cnVjdCBy
eGVfbXIgKm1yID0gY29udGFpbmVyX29mKGVsZW0sIHR5cGVvZigqbXIpLCBlbGVtKTsNCj4+ICsJ
c3RydWN0IHJ4ZV9wZCAqcGQgPSBtcl9wZChtcik7DQo+PiAgIA0KPj4gLQlyeGVfcHV0KG1yX3Bk
KG1yKSk7DQo+PiArCWlmIChwZCkNCj4+ICsJCXJ4ZV9wdXQocGQpOw0KPj4gICANCj4+ICAgCWli
X3VtZW1fcmVsZWFzZShtci0+dW1lbSk7DQo+PiAgIA0KPiBMaSwNCj4NCj4gWW91IHNlZW0gdG8g
YmUgZml4aW5nIHRoZSBwcm9ibGVtIGluIHRoZSB3cm9uZyBwbGFjZS4NCj4gQWxsIE1ScyBzaG91
bGQgaGF2ZSBhbiBhc3NvY2lhdGVkIFBELg0KDQpDdXJyZW50bHksIGluIHJ4ZV9yZWdfdXNlcl9t
ciBwcm9jZXNzLCBQRCB3aWxsIGJlIGFzc29jaWF0ZWQgdG8gYSBNUiBvbmx5IHdoZW4gdGhlIE1S
IGFsbG90dGVkIG1hcF9zZXQgc3VjY2Vzc2Z1bGx5Lg0KDQoxNjQgaW50IHJ4ZV9tcl9pbml0X3Vz
ZXIoc3RydWN0IHJ4ZV9wZCAqcGQsIHU2NCBzdGFydCwgdTY0IGxlbmd0aCwgdTY0IGlvdmEsDQox
NjXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGFjY2Vzcywg
c3RydWN0IHJ4ZV9tciAqbXIpDQoxNjYgew0KLi4uDQoxODjCoMKgwqDCoMKgwqDCoMKgIGVyciA9
IHJ4ZV9tcl9hbGxvYyhtciwgbnVtX2J1ZiwgMCk7DQoxODnCoMKgwqDCoMKgwqDCoMKgIGlmIChl
cnIpIHsNCjE5MMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oIiVzOiBV
bmFibGUgdG8gYWxsb2NhdGUgbWVtb3J5IGZvciBtYXBcbiIsDQoxOTEgX19mdW5jX18pOw0KMTky
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfcmVsZWFzZV91bWVtOw0K
MTkzwqDCoMKgwqDCoMKgwqDCoCB9DQouLi4NCjIyN8KgwqDCoMKgwqDCoMKgwqAgbXItPmlibXIu
cGQgPSAmcGQtPmlicGQ7wqDCoMKgwqDCoCA8PDwgYXNzb2NpYXRlIHRoZSBQRCB3aXRoIGEgTVIN
Cg0KDQpCdXQgaWYgcnhlX21yX2FsbG9jKCkgZmFpbHMsIHRoaXMgcnhlX3BkIHdpbGwgYmUgcHV0
IGluIHJ4ZV9tcl9pbml0X3VzZXIoKSdzIGNhbGxlciByeGVfcmVnX3VzZXJfbXIoKS4NCg0KIMKg
OTEyIHN0YXRpYyBzdHJ1Y3QgaWJfbXIgKnJ4ZV9yZWdfdXNlcl9tcihzdHJ1Y3QgaWJfcGQgKmli
cGQsDQogwqA5MTPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1NjQgc3RhcnQsDQogwqA5MTTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1NjQgbGVuZ3RoLA0KIMKgOTE1wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTY0IGlvdmEsDQog
wqA5MTbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgYWNjZXNzLCBzdHJ1Y3QgaWJfdWRhdGEgKnVkYXRh
KQ0KIMKgOTE3IHsNCiDCoDkxOMKgwqDCoMKgwqDCoMKgwqAgaW50IGVycjsNCiDCoDkxOcKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IHJ4ZV9kZXYgKnJ4ZSA9IHRvX3JkZXYoaWJwZC0+ZGV2aWNlKTsN
CiDCoDkyMMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHJ4ZV9wZCAqcGQgPSB0b19ycGQoaWJwZCk7
DQogwqA5MjHCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByeGVfbXIgKm1yOw0KIMKgOTIyDQogwqA5
MjPCoMKgwqDCoMKgwqDCoMKgIG1yID0gcnhlX2FsbG9jKCZyeGUtPm1yX3Bvb2wpOw0KIMKgOTI0
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIW1yKSB7DQogwqA5MjXCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBlcnIgPSAtRU5PTUVNOw0KIMKgOTI2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ290byBlcnIyOw0KIMKgOTI3IH0NCiDCoDkyOA0KIMKgOTI5DQogwqA5MzDCoMKg
wqDCoMKgwqDCoMKgIHJ4ZV9nZXQocGQpO8KgwqDCoMKgwqDCoMKgwqDCoMKgIDw8PCBwYWlyIHdp
dGggcnhlX3B1dCgpIGluIHJ4ZV9tcl9jbGVhbnVwKCkgaWYgcnhlX21yX2luaXRfdXNlcigpIHN1
Y2Nlc3Nlcy4gb3IgcnhlX3B1dCgpIGluIGVycjMgYmVsb3cuDQogwqA5MzENCiDCoDkzMsKgwqDC
oMKgwqDCoMKgwqAgZXJyID0gcnhlX21yX2luaXRfdXNlcihwZCwgc3RhcnQsIGxlbmd0aCwgaW92
YSwgYWNjZXNzLCBtcik7DQogwqA5MzPCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpDQogwqA5MzTC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycjM7DQogwqA5MzUNCiDCoDkz
NiByeGVfZmluYWxpemUobXIpOw0KIMKgOTM3DQogwqA5MzjCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAmbXItPmlibXI7DQogwqA5MzkNCiDCoDk0MCBlcnIzOg0KIMKgOTQxIHJ4ZV9wdXQocGQpOw0K
IMKgOTQyIHJ4ZV9jbGVhbnVwKG1yKTsNCiDCoDk0MyBlcnIyOg0KIMKgOTQ0wqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gRVJSX1BUUihlcnIpOw0KIMKgOTQ1IH0NCg0KVGhhbmtzDQoNCg0KPiBUaGUg
UEQgaXMgcGFzc2VkIGluIGFzIGEgc3RydWN0IGliX3BkIHRvIG9uZSBvZiB0aGUgTVIgcmVnaXN0
cmF0aW9uIEFQSXMgZnJvbSByZG1hLWNvcmUuDQo+IFRoZSBQRCBpcyBhbGxvY2F0ZWQgaW4gcmRt
YS1jb3JlIGFuZCBpdCBzaG91bGQgY2hlY2sgdGhhdCBpdCBoYXMgYSB2YWxpZCBQRCBiZWZvcmUg
aXQgY2FsbHMNCj4gdGhlIHJ4ZSBkcml2ZXIuIEkgYW0gbm90IHN1cmUgaG93IHlvdSB0cmlnZ2Vy
ZWQgdGhlIGFib3ZlIGJlaGF2aW9yLg0KPg0KPiBUaGUgYWRkcmVzcyBvZiB0aGUgUEQgaXMgc2F2
ZWQgaW4gdGhlIE1SIHN0cnVjdCB3aGVuIHRoZSBNUiBpcyByZWdpc3RlcmVkIGFuZCBqdXN0IHNo
b3VsZCBuZXZlcg0KPiBiZSBOVUxMLiBBc3N1bWluZyB0aGVyZSBpcyBhIHdheSB0byByZWdpc3Rl
ciBhbiBNUiB3aXRob3V0IGEgUEQgKEkgaGF2ZSBuZXZlciBzZWVuIHRoaXMpIHdlIHNob3VsZA0K
PiBjaGVjayBpdCBpbiB0aGUgcmVnaXN0cmF0aW9uIHJvdXRpbmUgbm90IHRoZSBjbGVhbnVwIHJv
dXRpbmUgYW5kIGZhaWwgdGhlIGNhbGwgdGhlcmUuDQo+DQo+IFtKYXNvbiwgSXMgdGhlcmUgc3Vj
aCBhIHRoaW5nIGFzIGFuIE1SIHdpdGhvdXQgYSB2YWxpZCBQRD9dDQo+DQo+IEJvYg0K
