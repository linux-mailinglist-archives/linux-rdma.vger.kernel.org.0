Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0A59D0A4
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Aug 2022 07:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiHWFnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Aug 2022 01:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiHWFns (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Aug 2022 01:43:48 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711813DDF
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 22:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1661233427; x=1692769427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1gjDReJVhFocmBZ+wspn7M697copEZ8uKPPcnQlblMI=;
  b=bo4P2DQdJf7cOEKyaLMOt3ONONJ2/ABtz/FsUKMkRf6euk/p8Wzq8zti
   eUqlRRu1X+n9p5RhDmlgc8Q7RZlBTThU6OCYg+5xEOYSHhTa3Rse7Adco
   3c/dxAC/7WTkb1cgSam8OO6Jjcqh/weyxmDAxmUCCZK+7ZqsaurIDKhYs
   P/lRRMpUA0AgjhbdDC3DvnLUx7rfPdgUG995CfxA5yoU8/78jWcM3IVwr
   SIenCueqsWNVJVVkmd1XS8X1rv5ONmGPEdwkzvblbUDriAq56wtPaukg4
   E2NpalWifQuScdZ1+oXXEQblMyyf09OP8r1sqghRXdYymQOAwqhosr44+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="62889454"
X-IronPort-AV: E=Sophos;i="5.93,256,1654527600"; 
   d="scan'208";a="62889454"
Received: from mail-os0jpn01lp2108.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.108])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:43:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpDkNcPDDCHTb6W8rWZRCaOZ/wjS7jG7qX2bQ0D3IBHGUd/64aVNIao3WxEM9/+4hkLs8ybQFRWgjOf9TIdQChbE9RHP/VVkuvA0DfBhTwOJCqXZfzD23F1GKAXvK6+hbgDbqkIl/YWyOM9BdoC/73tQSInSN73DzlPvoFmd7segotwnzXTt6oew/spDmvhSQmUYIxOSrbwIoZoavJIfM/efSQuGasanqgv6q1r7//NOiydv7Cr095uzBjwBQ2m1d2zLUlQnWztWGAGl6VmfWLFQAKZWmgJs9XEN1fgrSugOlpsu5PGDkXJ27mJN4rLATn9O+hXjooWJz4wXVENyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gjDReJVhFocmBZ+wspn7M697copEZ8uKPPcnQlblMI=;
 b=e8qcZYdheU3VZ8bAv19rooPOi5qP/kFN64nQKRGA17DFiAguGg3X4f9KWwnA6sat1FD33qVWq4YjtYtqXrb/4MJDGyWeumdtunZSD4WeWA7SkYeCkMiVzG165cRGTISdFDsrZQdJJEwb15USldp2YJ08bVgPxIynS/hn+fSZ78toty3QXxH8uWn6k14xK1SU7DY5AeG9lepbPlnmEEJgfxiIR2+WmRzQXAas6zA30E7Xnddtw5WKeO9ySElbDMOAb53RoaLKNoAilipEiPE2x/AqYXxAdPmT1Zt8Rmkjo1GjzjPr9a4Ays0cyEM2m3bOSzYRnUPqZOpKlvI+82v4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TYCPR01MB9416.jpnprd01.prod.outlook.com (2603:1096:400:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Tue, 23 Aug
 2022 05:43:39 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::924:47eb:4e0d:13d6%9]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 05:43:39 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
CC:     "syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com" 
        <syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com>
Subject: Re: [PATCH 1/3] RDMA/rxe: Fix "kernel NULL pointer dereference" error
Thread-Topic: [PATCH 1/3] RDMA/rxe: Fix "kernel NULL pointer dereference"
 error
Thread-Index: AQHYtTrtKX7nnpocxEC8jXNk9t8L+627SGEAgACzkoA=
Date:   Tue, 23 Aug 2022 05:43:39 +0000
Message-ID: <55c5d923-82ea-10a0-e709-696e8013a159@fujitsu.com>
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-2-yanjun.zhu@linux.dev>
 <6aaad445-0c9c-ad35-4941-7d3a6653cab6@gmail.com>
In-Reply-To: <6aaad445-0c9c-ad35-4941-7d3a6653cab6@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29bba002-83f1-46be-ba2e-08da84ca6e35
x-ms-traffictypediagnostic: TYCPR01MB9416:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7JKKU03UW6nvc9nrnQdy8WBUVYPAzzqHnkrW1MHY5/ej60Dd33vJA+ypmWLotatSZlQmvLvBPF6iTGmZKxd1iBof4kg1xqhePHZdk64vtanncViazPHtpP8L7qrBL15SSmOD739DVb/LSn77gHet5qLxZ8QgQWWtssFOOzNa3yoWzqS5h6TQ/1Owfucn3+50SqqGqbS/J0IIpAiLj6RhrwzwthlA2QQu7iML9EYuVzNsPas11zPPa74yAk1KEDqtFf6kPD/x8fXsvjztNlvOOOWBXfhVWXmPUZQGlNoX0jRuTUYIy1nikOWMFOY/tiyjCuAJNpCq/Lsoq7vdUuvbuOvrV7v93ddLLZ0c4LikVjRsDxVhCQV/wjpna5V6DzsHpeOCbui45zuguRFH85KYT/M7Eie35a0yR6EnQVpct6O60WEglI3jGrH3pJC7hB8lA4rmuDK9csKtE1fm1+/0xCPo+CNgNPhxvBVNUGlhLUELzMilerECgxbOOqNthfMObETh2q+O8M3w4i8VBrZGL+YP8DnBs6vWYueghwp0JM0rDLvyJL/RQNqvidb3C+vt8ZiMA3T0QvdXVjx7gs70jUP1Rf40LXbi6HKWXhOwa8RbjIiYdJpXgw6JsGbrIq8G9rNBGM0hAwTw0AoIjbzm/o9KYJBguz1sKTliLINffhAWZ7ILZswXrIN79uI9OEuJMMaqGZn1s4MhYUhG7rXj3cvb02xacNRThhggjUvAQ1LlvdLYXAuBEJP5h+Ng03UkbeOPQa3+YKdbKT4ofjw68XI+C4nxV7A6WbWgXfmXeXjqBphz9kzQN83xG+3TE8b5lQvsWPX/ILRVbH1p+OekqNwp1KYcu7NGnxEpCKaC/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(1590799006)(6506007)(53546011)(41300700001)(64756008)(91956017)(2906002)(36756003)(478600001)(85182001)(86362001)(31686004)(71200400001)(31696002)(110136005)(6512007)(1580799003)(26005)(316002)(6486002)(82960400001)(38070700005)(122000001)(38100700002)(2616005)(186003)(5660300002)(8936002)(8676002)(66446008)(66476007)(76116006)(66556008)(66946007)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1R3VGFWalRmWXE1MlhsRlJWckxzeldxeTdjaHNIYUdTSUJlWDRHbm9MSVNO?=
 =?utf-8?B?RCtKekhGREJpbnVNOUlQTmk0WWVBMTRvZVMxK3ZKKy9WMkg0dzRPeHZzK053?=
 =?utf-8?B?NGJ0OHFuU2l0ME5XeGQ0WmYwOVpQa0VsRzBJazlxRFhlZHcrbVRpOTcrbk5s?=
 =?utf-8?B?ZVFoVlNmSlhlbHRENm9neFQ1VFlNeDlabTFZWitFaWw4bk9OeWNwYUV1N1N0?=
 =?utf-8?B?VmJCTFNialhjb1RhMWdOcjZDQWN2aTh5bURCRFhnLzgwbW5DRG1UcVQ5OVpF?=
 =?utf-8?B?aEtGOHRnMEMwU1RZMGxmSWsyUUtBNkJ2ekJkZXlOQnJpUUcwL2gyUnB3RzVu?=
 =?utf-8?B?a0ZmOEdkRkZuMWtpYVN4aStrVnQzeDlwUTA5dVpvNWZFQ2ZQQmZDQmFkZHho?=
 =?utf-8?B?aEtuU0V6bGFzbWpOTzh0aU1RN0lhWm54Zi9CaEJtMTJMS2JObGhpMUhENVAx?=
 =?utf-8?B?RGt3Y0ExajBrOXVyQTJTd3RocWhMQ3VjOGJHbHY1RThNL01FSkVCOG05K0c1?=
 =?utf-8?B?THI2NVZ0YVJYVHpHNnRIWEVoV2owWmlZOFJPcUwxU0t6Wjd5cW1tN0pGYTIv?=
 =?utf-8?B?MjZYb2JpczUyeERKM2FjWDFCMlFmMWIxa29uRjV6SE5xajJjTlU2UGRVSUtw?=
 =?utf-8?B?a1NzRGNhcTdobjNEbXNlM1NYaW81VjBheUdzdyt2TWpSRTh3RjV3SFY4VHgw?=
 =?utf-8?B?MXJ5VkZpUjZLZGNXK2VKRE9ZWFV6amVZSW9yL2Q4ZkpRRkVUaGV3bU4wY1Fk?=
 =?utf-8?B?Q1V3clB4THNnbDZ5dzNUKzJ2bG5ncUFNWDdDdkFmQmhwN3EzQUYxZU9LdzNK?=
 =?utf-8?B?VjJSaXZQWHJ6QnUzQmJXeURPcFZPeVQ0eFdCZmZDRnprRGxveXRpT3YySkx1?=
 =?utf-8?B?UCs3QWJuMk1ZWnVtdGVWaC9XYi9Nd2luM21TQUVHZDJzREZHYXpkbk5xNVJQ?=
 =?utf-8?B?REFGOTdtdkpWWlJwcXhkQnRNOExUcUNVMjRtaEJkQW1hWElxTjNVMEtoQXpF?=
 =?utf-8?B?aVNta241ME9INnp0eWlZVlRIQWJvOXY0SXhGZGF2L3hlU2VpdmI0Szh2akpF?=
 =?utf-8?B?OEtnaEFsbGgrdms2SEhSb20wYUFZQjNHNkU2NkxkdDArb3EyNWRHTVp5ZmY5?=
 =?utf-8?B?bGI3dktvcEFUeWpNVDZWZTFXRElhN21hTmhqMXBTQTRlaGIxR201ZnVNN0VE?=
 =?utf-8?B?SlQ3Z1Bwd3M0SmN0eUt0TUIxMlZvVk5BTkRlRksxUGt2ay93MDVaRFVveXNJ?=
 =?utf-8?B?MEFRYVV1YTlNeFJZUmxKLzRtZWV4KzVMaDlteG5RZlA5K2RxNzN5ZHNNZ0Iw?=
 =?utf-8?B?K0toellwcWFjQVhBUXJQRlgvYWNEMHUranBlcTdldytEYzNDZ0svZ2w1YUFU?=
 =?utf-8?B?NG43cEhaQ2p3WDhnSFZHTnlZWTlmQWdSQW1RTWQ5VnRnNklEdm9CWGYxREdr?=
 =?utf-8?B?andCK1JZVi9uNkdGaXl0S29QUTVFZURpeUtRMWVDL1RlallhYlN0bUl3MWF5?=
 =?utf-8?B?aUI3a3EzcFpFaDVXMncyejc1R1g2eTdmMCtSZElsSGF5S1RyNHpxYUl5dW1T?=
 =?utf-8?B?dGFEc05GTTI2YklqREZSK1VUNmZRV21yd3M4cCtJNTRwQmw3cGdZYncwZktE?=
 =?utf-8?B?UHJWeEFLWU40NmlkcUdBb3BLZXYyQUhsME9PNDR4VEFwakVpbCt4aGE3K2hp?=
 =?utf-8?B?ZDRlYmdxUkt3NU84U1kxZzZlVjArcFpVMFRBY2wrRWoyYjA2dzM3QmtWRGF0?=
 =?utf-8?B?NVpCNkZyQVROcEFXakx4TDNBR3hndkh5d0RUeHpLdjlkOHA4SjEvcHorSU5w?=
 =?utf-8?B?VXRIS09oSSt5d25aR1pNT3ZrN0k3bmpiQmZzQ2ZTY2pKbS92U0tsRG9nUmlx?=
 =?utf-8?B?eWMzRzhJd1lJaG00a3FENW9GWGJzN3czM0dic3BPbnpEUExlRElCMkQ5Sy9v?=
 =?utf-8?B?SXBkQ1VmOFMycTl4Nm5vUXpoV0p0Y2FCRmxzbzFFUk96dmo3S0VpdFQ2eHo5?=
 =?utf-8?B?clhsSUZqSytuVkg4blB5d2I2WFkrZUdFTTNqckpmSTNBU2JVbTRmTnBoYUlO?=
 =?utf-8?B?VGkzWnI5KzZtek1rMFBXMThxdDFyNG1KN091cGEycWJIWEgzb2o0TSticzA4?=
 =?utf-8?B?WDhjTWVJSFZkZE9KcnRTTkFHMndONTlOeXBCeUVWS0hOVWQvWjIxL2VVWXJ2?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58289702B16C6043AECBD9BEE6BA63F9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bba002-83f1-46be-ba2e-08da84ca6e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 05:43:39.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AXW7C/Sxi+3icALycdwb/RpR3SfL3ta/5t62Q1r5gObvI2hxgwBR8L5S5X54m3tleHlrid6v95CIMPiRtS0WqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9416
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDIzLzA4LzIwMjIgMDM6MDAsIEJvYiBQZWFyc29uIHdyb3RlOg0KPiBPbiA4LzIxLzIy
IDIwOjE2LCB5YW5qdW4uemh1QGxpbnV4LmRldiB3cm90ZToNCj4+IEZyb206IFpodSBZYW5qdW4g
PHlhbmp1bi56aHVAbGludXguZGV2Pg0KPj4NCj4+IFdoZW4gcnhlX3F1ZXVlX2luaXQgaW4gdGhl
IGZ1bmN0aW9uIHJ4ZV9xcF9pbml0X3JlcSBmYWlscywNCj4+IGJvdGggcXAtPnJlcS50YXNrLmZ1
bmMgYW5kIHFwLT5yZXEudGFzay5hcmcgYXJlIG5vdCBpbml0aWFsaXplZC4NCj4+DQo+PiBCZWNh
dXNlIG9mIGNyZWF0aW9uIG9mIHFwIGZhaWxzLCB0aGUgZnVuY3Rpb24gcnhlX2NyZWF0ZV9xcCB3
aWxsDQo+PiBjYWxsIHJ4ZV9xcF9kb19jbGVhbnVwIHRvIGhhbmRsZSBhbGxvY2F0ZWQgcmVzb3Vy
Y2UuDQo+Pg0KPj4gQmVmb3JlIGNhbGxpbmcgX19yeGVfZG9fdGFzaywgYm90aCBxcC0+cmVxLnRh
c2suZnVuYyBhbmQNCj4+IHFwLT5yZXEudGFzay5hcmcgc2hvdWxkIGJlIGNoZWNrZWQuDQo+Pg0K
Pj4gRml4ZXM6IDg3MDBlM2U3YzQ4NSAoIlNvZnQgUm9DRSBkcml2ZXIiKQ0KPj4gUmVwb3J0ZWQt
Ynk6IHN5emJvdCthYjk5ZGM0YzZlOTYxZWVkOGI4ZUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgWWFuanVuIDx5YW5qdW4uemh1QGxpbnV4LmRldj4NCj4+
IC0tLQ0KPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9xcC5jIHwgNCArKystDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX3FwLmMNCj4+IGluZGV4IDUxNmJmOWI5NWU0OC4uZjEw
YjQ2MWI5OTYzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
cXAuYw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcXAuYw0KPj4gQEAg
LTc5Nyw3ICs3OTcsOSBAQCBzdGF0aWMgdm9pZCByeGVfcXBfZG9fY2xlYW51cChzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+PiAgIAlyeGVfY2xlYW51cF90YXNrKCZxcC0+Y29tcC50YXNrKTsN
Cj4+ICAgDQo+PiAgIAkvKiBmbHVzaCBvdXQgYW55IHJlY2VpdmUgd3IncyBvciBwZW5kaW5nIHJl
cXVlc3RzICovDQo+PiAtCV9fcnhlX2RvX3Rhc2soJnFwLT5yZXEudGFzayk7DQo+PiArCWlmIChx
cC0+cmVxLnRhc2suZnVuYyAmJiBxcC0+cmVxLnRhc2suYXJnKQ0KPiBmdW5jIHdvdWxkIGJlIGVu
b3VnaCBzaW5jZSB0aGV5IGdldCBzZXQgdG9nZXRoZXIuDQpBZ3JlZWQNCg0Kb3RoZXJ3aXNlLCBs
b29rcyBnb29kDQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5j
b20+DQoNCg0KPiBCdXQsIHRoaXMgaXMgc3RpbGwgZmluZSBzaW5jZSBub3QgcGVyZm9ybWFuY2Ug
Y3JpdGljYWwuDQo+PiArCQlfX3J4ZV9kb190YXNrKCZxcC0+cmVxLnRhc2spOw0KPj4gKw0KPj4g
ICAJaWYgKHFwLT5zcS5xdWV1ZSkgew0KPj4gICAJCV9fcnhlX2RvX3Rhc2soJnFwLT5jb21wLnRh
c2spOw0KPj4gICAJCV9fcnhlX2RvX3Rhc2soJnFwLT5yZXEudGFzayk7DQo+IFJldmlld2VkLWJ5
OiBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVAZ21haWwuY29tPg0K
