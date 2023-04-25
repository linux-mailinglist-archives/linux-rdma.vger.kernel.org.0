Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF36ED978
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 03:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDYBED (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 21:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDYBEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 21:04:00 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C993E6;
        Mon, 24 Apr 2023 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1682384639; x=1713920639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0CLQPKzrRIHHNDhGlpjmejXGRmb1HjpCjKoTgB6R7HY=;
  b=iOYJ+3XmKv/tpEyD+y2aJUmQ4Ecl1o10jIGYJs6lJyhMFBKuECh6ZoUu
   Pv43rFE396e5YDD/UPu14lC6vZ5Mr/LFLIM4fBT1zPg2fs3acjLSxYKJi
   Cy7S4Gkz7Nbk2hGjZuYIBJyZj/HNLkEFyCDy+xt99U2DWl1gMDen8GHWd
   BA7VxlhOL/oP4PZvmTy4Bax23VTOJVlO1uzmgBsnvEHxKQN55233zCAIX
   i/NG4xky2yup1w5J2RcZxkm3XIX6NZG4DviABESkht2g32lKfGJM1/HqO
   LUZMIFWJ7ySmei4xgIkimNxFQlI+nn9eUM5AObXO5NoGcbOAsWOzwldH7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="82785610"
X-IronPort-AV: E=Sophos;i="5.99,224,1677510000"; 
   d="scan'208";a="82785610"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 10:03:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik2yenQy3/VEUbmb3aFCkxYN90v1+vqyzIMrsLb1chxvAlnByikhY6dCbeYjK0sYG/XVCfcwNf5E6NZBG4qxYcsEtImFph7rjhtQ+2sa+TbqZWOUHYrVARu7Fi7QJwDFG+nPqKAnE0rJj7CfxfgxEdbPSFCWafwG2jAeNwdIG+HJoc24elJpOl4qVsd4xyGccNalnxjMRqlP0FpJ2ShZDunhAptQbCjjedsyaVOWOszKxv+egOz0brwMisrCOGFwOhrJIMQq2AbGwVwbDKBihIw2ikoJgoa0fMWNhkmm7ohpkQGVEL1ZHuadTyvInjhj6SMlgLdLuhAQHQDGDhHKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CLQPKzrRIHHNDhGlpjmejXGRmb1HjpCjKoTgB6R7HY=;
 b=aQHOwcId2JpudtUcpZvlO8UGuR8/JCN0cMqauDaKmQB78ZrWjUXZSD/vJWi2jQQJZD/RBy8rYWeNaU6bDLtskRIFva68vav9AlLnLQqpkxEowsbFx5STcbkQakhH/tZa8PH3vRWeRLAr2IdSFypM6yhgb0F83dybEErD2qVJ1uYgNcjO7LrMdsCtuOZFmhDjtVaeWWW0kwxOr/o0/iIvGwZUNw/qO45nbIJ4vB2Ta7E4ufxnx5rPvlmL2ogDaToY+rOgVdD+uqcHV7+Ged8ZxIvlda6EtIYamN+7rCclOEF2D8S9NIn25CD/WqfyF61akB2Ibsg4LV1ewIwQ0/pAOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8896.jpnprd01.prod.outlook.com (2603:1096:604:158::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 01:03:51 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 01:03:51 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "guoqing.jiang@linux.dev" <guoqing.jiang@linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next v2 0/3] RDMA/rtrs: bugfix and cleanups
Thread-Topic: [PATCH for-next v2 0/3] RDMA/rtrs: bugfix and cleanups
Thread-Index: AQHZdYLD3XpxJAxs406CMwBfTLOfsq87OJEA
Date:   Tue, 25 Apr 2023 01:03:51 +0000
Message-ID: <e4f080a5-a9eb-1393-5495-a569b5059864@fujitsu.com>
References: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
In-Reply-To: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8896:EE_
x-ms-office365-filtering-correlation-id: 18d2c135-097b-462f-c49e-08db4528ef12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ZdRe7O0Ww25+jG//1Q+GzLwNMlOyLKXF4Kz/FiRhM5R/r0cHA8AFUH4PNlXJccDbhtTUm9g41Bhkk8GdnMlcOpggmdneoakfsoxCTZvfAIBinKNYjpK/kj3RxD4Bo2ivolUk5Zhtt6jMyRdq8D+90wOXNUNxyPKJKiAZ/kuLoXVVfGRHqw3Sx4xDZOyfOamNbM4xVeuY8ang/a42Vp940IVrKk6LMuWZ0eS5dYYYjZZu3hQs69aTPZwKZ6syxIDIyzx8/rPex81XBLF79IlzjMQJaetPpcgdzVTQCe9Ba82jKUBZcGstwv/u2ziwYdWdMKBZ9CeBoYAQ5xVS2YMolD8IcsDwWRt7eBu35RWTPJSPctox1nitISY8svUso/7ve799eDvvzJesbMFWoh6VY/fiOAwpVtkSK6Fr4NqBiSPColxVI5I2G3+axck/5PkZueLmHkCLDa38f7Ztp13bFwGa8K1FAaQmg3xVP8mJa7sXXnA+vO+OxCNmzM6d5Oz/g2YI/LAVodZ6xE/ZwHGPh1FkSIF8lzaDd+HIIo6ISVtPMI/hf8MVg4p01vMuO7rlqyncV6s8+DpZsUjr+vF+csyof9DT9tC1fn6vClgiu+ZNGx5QHobx5Gho0E4LjewrdzjTudPoF1xwZ/W1Dgj+kRdtN5bsJEqXo1oXAOQuTYPwXpH8fbn4037IKE9lUsJmrLEhztDyVwtNbieaCDqeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB11664.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199021)(1590799018)(2906002)(71200400001)(6486002)(6512007)(6506007)(2616005)(186003)(53546011)(91956017)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8676002)(8936002)(41300700001)(4326008)(316002)(26005)(478600001)(5660300002)(54906003)(110136005)(38070700005)(82960400001)(122000001)(38100700002)(36756003)(86362001)(31696002)(85182001)(83380400001)(31686004)(1580799015)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVXcE5iVWl5RWtYdmVaTkJndW9CdnZXYW9OTDFCS05kZXQ4d01nWlQrSDln?=
 =?utf-8?B?SVA3cVMxaTFjeGZ1QnFJZUlNdjNxR1o5cFhpanRjcWRmbjVFLzh2ZzdtZkll?=
 =?utf-8?B?RVN2dDRDbnpCeGhyVzJBeWRQbmxqZCt0YmVyOXhQMERJR2d3a3BIWWJyUURt?=
 =?utf-8?B?RTBBeWxsNGRNNWtNblJGNzBSOThwVmRudDhpVnhkSlJPRDJrRzdtWkFLQVZ5?=
 =?utf-8?B?TjV1Vld2N2E0RTlpcWZ3dzdOUmJ4M0JZb1FDYzFmVGFBeXNZaXQ5RUJnSURJ?=
 =?utf-8?B?MytaREFCL3dGZkNGbHRrZnFmUlcxOHBoUU9HcUl0RkNhQ1AwWG1tU3UzRlcy?=
 =?utf-8?B?bW9KcUNpdk9nWTVabnpOV2tlbEc3NUpHajBndWhjYzVKVFQyemlTZnlHZ09I?=
 =?utf-8?B?bTU0RFoxVkpDNTRMV1lHaEpnWDAzL1hEc2E0MlI1MXM5NDV5VmZUc2RZaXVC?=
 =?utf-8?B?WWxtQURXaUltUFlUM0swejBDWDMxMVduSklQSVJCRFlELzlVNFdwT0lmT2Vo?=
 =?utf-8?B?UnhJUVk3V1FDRHEyNjN2VTJGcVFNOE53ZmJIR0RkTTVJVnhaZlZHV3pSb1NX?=
 =?utf-8?B?ZGFXMzYyaks2M1d4VUZkSkZlcE51TXRlRDJLNU5yOGJJMjNyNkt4Y3Nmb0Zr?=
 =?utf-8?B?R1NWOTBMKzlRdm1KQjdId2w0N1FkdHdUdW9QUFV4dlNsN0crQlZmOFhpQmZI?=
 =?utf-8?B?NUJpTXZIV256Zk5mamswc2xxcm9TNXNyeWdVODhRM2kwOUpBVkV5REYzM2dU?=
 =?utf-8?B?M0xaSmIyVDRKNHRqV3B5d3NrbUJ4cVlsT09sRlA5RytNYUV3ZVFsMm1vOVVM?=
 =?utf-8?B?dCtKU3VqVGpCbXU5L0ludGs0amVTM1NDK1ZLSmZkdzRIb20zUVRTY1BuWkx5?=
 =?utf-8?B?d1MvVFlET3Y2eFFyYlBRNmZKWXdnTThiT2dGNTdPMnFmT0ZhQ3Urb05IVlhl?=
 =?utf-8?B?UUZtVk1vc0lwaVJ0Q3JJaUNiRGF0L1FCLzhjOXh6QzR6eERiZ1B0azRzOWYz?=
 =?utf-8?B?U1EzRDhYY0lydVMrWXZTeHN2Zi9CNUZ5ZjZ3aDdUc2RsT2oybHl0QkRTcGZO?=
 =?utf-8?B?SHgvMUM4eEZOZEt0RVNPN0k3ZzFPL2RBV2tSSVdqNGxHOUNUcFZsU1BhOFJH?=
 =?utf-8?B?Z2Q0Tnc3eklnSDdUOXd0UTNUbTNmaU5NMGI1U1VSUEsyc1FYRzYydG9kMnRk?=
 =?utf-8?B?UVJmZnowQkhBWC9oQmJhMTl4bUdFTkE1bW9VaGtsd3grNGUzWG1vR1FmRnll?=
 =?utf-8?B?MkhwNzYxLzFYWW5HS2FoTFVyRHd3UHRIa2Ewd25YTi9yOC9MZWFaRFljaTBW?=
 =?utf-8?B?aDhoZHN5aDBGd2kyemhLL0J2T2laSTdYNmVJU0gwOHM4RkthbHMvN2lvdmI4?=
 =?utf-8?B?U1BUR1dDMENXc0Y5N3F1QzNQNVkwNXB6dGY2SUZMSHdVWlZwOUJ2NUlFM1FW?=
 =?utf-8?B?bDVYMFZHSU5xZFZsb3F0TFV6c1BiTWkrWHlFTk1kb2VQZmVRTDZaSXUrUVpK?=
 =?utf-8?B?b3Y2QXBPcjNhcmVwTzhITGwvS241bTZrWXYzbEI4WnEvUmorYzUvQ25oamVO?=
 =?utf-8?B?b2E1MUd6R1JZUHFYaU9Kc2YvSXdQZ1EzUWZ0Uk5vQkRzakFMUFo2WmNBUVEr?=
 =?utf-8?B?M3VzWHRnUHpxcm9MV0loMzA0Z2xzcnV4QUs0ME5BMzV1WVlBb2RwSnVrWGVX?=
 =?utf-8?B?Z28vd3ZNTXJVUXgxUW9XcjZSMDl1MnUxbEJXUlBjaXBncEQyRGMvckw4Zi9s?=
 =?utf-8?B?RTNUbnhtUU5RQ2RaOXJhSlpDMGtVeWZ3eGhZbnpCMXNoODE3RVVnejlWZExx?=
 =?utf-8?B?ejVMcndsbEZEM1JpeXBkZUZ6QmIxUU1DQ2dUV1hzN3dka2Q5VXZYMk1jK1F1?=
 =?utf-8?B?T3hxK2ZlVTJuTTNQbWFqbkV3c2VldGZveCt5Q2hGNW1XczFXQlpTQk1EV1BX?=
 =?utf-8?B?UG9maGhiRmRxQVo4WDJzcGdLckxWQlFiZU9JbVh4RDUwYURFUWlmVkgyZmxS?=
 =?utf-8?B?U3MwSkxNMkVwRlhzUnRwblI5WFROT3piT3QvY3U4UE0yTjJVUjRJZHEyQ0tU?=
 =?utf-8?B?NitET2V1bHMwZVpYYWwyRXBOV3IrTGV5KzMzZGFLM3p4SDdjdXk3TVVrQ0I5?=
 =?utf-8?B?NVhKVE9EN3FhVkpYSFpSaVNoNU1YM1JsZlJXT0RUdkxTVGZ2TW05QTFhTEJW?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8DED199E0815240BE2F19CB0198F2F4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XBVbi+FFmA7rOE5i8xqqQo3AGL6mwxdcduj8NDVxRWYlcXSwmUqTQL6Ljjzrl1WOuw3r7t/JuKM9wkbggY1cKVMNPo1DJ6ArZQd/qvpnoeVLaYS7zIDwR3GsSZDSrGPWeoU//YwDfbzaAZ+XcjtWqj1UmloSj8to+KUGhuTG5DE1X1A5HdVr+/y3Ff8OBq1BdSqKiBvyUd6a2KPEkFUxU/5wX177zO7oI8Igj7/QTmCBQwexbM1/wn/bQw8kn3g0KkIs2pRoSvXeQxpwb3/MCJkBvG6vZ+KDA5f3a1OnqOGGbq0nAAa/zOFTz7x2fnLuaAz2iSB1eKu1J5q34SaFmVCP6ozfNmHXqwG8Mapgt0jt5u9UZCec6XMnf9yWcwz5mFdq7iF79BPf06v9i6CkEbR0jQASn0Ja2uj11jg/NdTBAYmi7QbRc7S6jyBW6sAo5VU1LvoYN79ff3c4fIVlgBtWg2fCOiGqAF/gqTCVp/yP+JNFhQ2hHuYEJkLVaFN6iDYjq4sTip5S64f6aQnd2nUauiC27FfxpOEBCOIvUp3s1sSf7MVKUXMFy7G7es3xa/16ywSiU36yJiuj07fbf1VploEt0ldxnvxPSi54R7vZRiWw1fNMwykcf8izElb9yIaAvGoT4s8TUub1l71P91z965OG/yFr3UH3oUwL1gIH8pylOjDaYlonhjKfCH09GHptR8fRh9+qUTwuBUEciZ8MY0ye8GFYcgaYCFCpl5KVNwqCIUqHZ3B/L5qFM4FWQlW5iD/GNqV+WBj2Dl3Bo89AW0cc3ofbTpa4SBog2TdrYhGjaJmQuQmc6A8IVCzVCGKgOIE89qRQdEQ4GFsAxO2BSoC4R6xLEWAes+eCLQUI2dOmrT9MlRcFzgcVicdS
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d2c135-097b-462f-c49e-08db4528ef12
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 01:03:51.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nWjTVgpgp3aOSbvSlG5VWqcRUrfa5uAya8EDUOpmJETpPTzs3QS38wifDCaKtg90JzUoh58rHYuiVYEHLLC6WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8896
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SmFjaywgR3VvcWluZw0KDQoNClRoYW5rIHlvdSBhbGwgZm9yIHRoZSByZXZpZXdpbmcgYW5kIHRl
c3RpbmcsIEkgd2lsbCBwb3N0IGEgbmV3IHZlcnNpb24gc29vbi4NCg0KDQoNCk9uIDIzLzA0LzIw
MjMgMDk6MjYsIExpIFpoaWppYW4gd3JvdGU6DQo+IFYyOg0KPiAtIEFkZCBuZXcgcGF0Y2gyIHRv
IGZpeCBhIG1lbW9yeSBsZWFrDQo+IC0gcmV3cml0ZSBvcmlnaW5hbCBwYXRjaDIgdG8gcGF0Y2gz
IGJ5IHJlZmFjdG9yaW5nIHRoZSBjbGVhbnVwIHBhdGggaW5zdGVhZCBvZg0KPiAgICBpbnRyb2R1
Y2luZyBhIG5ldyBmbGFnDQo+IC0gRHJvcCBvcmlnaW5hbCBwYXRjaDM6IFJETUEvcnRyczogRml4
IHVzZS1hZnRlci1mcmVlIGluIHJ0cnNfY2x0X3JkbWFfY21faGFuZGxlcg0KPiAgICBUaGUgcHJv
YmxlbSBpdCB0cmllZCB0byBhZGRyZXNzaW5nIGRvZXNuJ3QgYXBwZWFyIGFmdGVyIHRoZSBuZXcg
cGF0Y2gzSmFjaw0KPiAgICB3aGVyZSBpdCBhZGp1c3QgdGhlIGNsZWFudXAgb3JkZXINCj4gDQo+
IEl0J3MgdHJ5aW5nIHRvIGZpeCAxIGlzc3VlIHRyaWdnZXJlZCBieSB0aGUgZm9sbG93aW5nIHNj
cmlwdCB3aGljaA0KPiBjb25uZWN0L2Rpc2Nvbm5lY3Qgcm5iZCBmcmVxdWVudGx5Lg0KPiANCj4g
IyBjYXQgcm5iZC1zZWxmLnNoDQo+ICMhL2Jpbi9iYXNoDQo+IA0KPiAvcm9vdC9ycG1hL3Rvb2xz
L2NvbmZpZ19zb2Z0cm9jZS5zaCBldGgwDQo+IG1vZHByb2JlIHJuYmRfc2VydmVyDQo+IG1vZHBy
b2JlIHJuYmRfY2xpZW50DQo+IA0KPiB3aGlsZSB0cnVlOw0KPiBkbw0KPiAgICAgICAgICBlY2hv
ICJzZXNzbmFtZT14eXogcGF0aD1pcDo8c2VydmVyLWlwPiBkZXZpY2VfcGF0aD0vZGV2L252bWUw
bjEiID4gL3N5cy9kZXZpY2VzL3ZpcnR1YWwvcm5iZC1jbGllbnQvY3RsL21hcF9kZXZpY2UNCj4g
ICAgICAgICAgZm9yIGkgaW4gL3N5cy9ibG9jay9ybmJkKi9ybmJkL3VubWFwX2RldmljZQ0KPiAg
ICAgICAgICBkbw0KPiAgICAgICAgICAgICAgICAgIGVjaG8gIm5vcm1hbCIgPiAkaQ0KPiAgICAg
ICAgICBkb25lDQo+IGRvbmUNCj4gDQo+IExpIFpoaWppYW4gKDMpOg0KPiAgICBSRE1BL3J0cnM6
IHJlbW92ZSBkdXBsaWNhdGUgY3FfbnVtIGFzc2lnbm1lbnQNCj4gICAgUkRNQS9ydHJzOiBGaXgg
dGhlIGxhc3QgaXUtPmJ1ZiBsZWFrIGluIGVyciBwYXRoDQo+ICAgIFJETUEvcnRyczogRml4IHJ4
ZV9kZWFsbG9jX3BkIHdhcm5pbmcNCj4gDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3VscC9ydHJz
L3J0cnMtY2x0LmMgfCA1NiArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiAgIGRyaXZlcnMv
aW5maW5pYmFuZC91bHAvcnRycy9ydHJzLmMgICAgIHwgIDQgKy0NCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDM0IGRlbGV0aW9ucygtKQ0KPiA=
