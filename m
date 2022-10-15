Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8775FF8E2
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Oct 2022 09:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJOHAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Oct 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJOHA3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Oct 2022 03:00:29 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94031359
        for <linux-rdma@vger.kernel.org>; Sat, 15 Oct 2022 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1665817227; x=1697353227;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=uSt7brgoF+lCK5YiTsEm/CMCapYTRkTOwdDaK1BWu/o=;
  b=KOPSrj1xrcnQ9R7pM6JxAz1MbTYCfcfBQiApfkJpR2gZxaWj2QdTeggc
   Yb+ZlsD8Lck/y06h5CHvV90wmtqyjJ/E9YQkUymPs+f/3n5g0C2w82oNj
   A/T2Se9P8czFrgcQynEHncZtTXpTap4wyyO4lUTw/MT7wB9WoMznAf8LW
   8Ndj8Ug9YszmjKdtG+kExSpNBgDtOLR2gr/wL9jSkbLQ416gfLRquLogJ
   EFT/Qm0BMU7KPuy7G0TAPiMFTAeriVBXPt3DTOHOkEnKmWwAGZ67aBnhn
   jXUcupKCSgVQKIQbA0PgCOXaB+wyZvkGW7YeZW8DaaMUgDL9Bp4Te4z1i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="67689746"
X-IronPort-AV: E=Sophos;i="5.95,186,1661785200"; 
   d="scan'208";a="67689746"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2022 15:37:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al6Ar50kPC/0k0IWGww38OfkakpZKVNbPABWkTrFAAGlDAYqrFYO2X5XrS3Lb2jQNO/75x99zQS0KTWBF9ZQJ7AYsYyamBAOUsQ9XgiC9Sgwj52FKfXWyub4VmZ/KgHvZ5LBKbvG/Fh1dc6Maft78UExtsXVaiur39E9NosoEYSKI51t1hYzX1Hrtl3OyoGR0PvuLpRspmsYQLV/7nTzffQvbDr5aJs/OmsT6CF9CtiIupPR410/qC4TfYbG8gU/AaZ7U36/uWvPo1zm9hQZCLoI7bFN/OedY29AfsvoHdkmqj/kAen7iVvrVE0+iq4QK87WSVj5oErIZlBpPD+csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSt7brgoF+lCK5YiTsEm/CMCapYTRkTOwdDaK1BWu/o=;
 b=btDru/cW0kV1Mkg5OnxrP6qmIvP7TMt0Nb2Ic4DIoDL3uQmzjYCbETa/ezepODjv9NCUqQq3hqI3dpNBPNgAXJTMOasgeM/FTe0jE+pDzpRCtqGAYKCsgBOaxkrtpevLO6neWJKfjYn8Ovqkku9NBVecgIg4D790UKu1GqGlAewRwyntmfmK3ZJx+L0QtmOEpgn/WlFKqYXxsuxuR0kdRQzkuOnXeswdDL5SQMkOLYjl+hrJdjcCaoYCN7D6YdJN0fwZsyeU+8+JABwNK7mrFJ0hEf2YNWacKf9OoWnLETx0kFhHeAqLAB+G9EiRjkOuhs8h9CIEgDMqIV4pk25DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 06:37:04 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::5989:c90d:abf4:e100%6]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 06:37:04 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Subject: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
Thread-Topic: [PATCH v6 0/8] RDMA/rxe: Add atomic write operation
Thread-Index: AQHY4GCJKHXhw3vt20eBf1hwuOqTxw==
Date:   Sat, 15 Oct 2022 06:37:03 +0000
Message-ID: <20221015063648.52285-1-yangx.jy@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: 30a52455-766c-47ac-bdd4-08daae77ac2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blvdf3rCaL2vng8hROiU4uOVNsI/U12DW/XNTrhSgCCCvVvhdyrPkTijahOx88KkVDlp1cTXdYOCU1rJuCX9T+/sSoxqE5igTY76LrE0K3KjQ6aNbttfpD6/WQIgm0efvc2snbZm4SLMDsiXlzpEkLKYM6J+QSi/IsAZb/8kstjNuV7YGnDVIaogNgvuv2q5b6VZNDHZT/cRMTgoxMqW/q3NAAAMKW1mUXNxNSLrRSoBfSWb8kVxJoRMT44jfAVA3/XBXsxAzMk6yquAuRNKFRxcBATsxAX0We1iPWpOIOF/fFI9YEsHtfBY2n9vIxwAe8X4jHJtk+OvRqa+9jGCJUDgAo4mA1RoXgQHNrT4ARuxuOXXCGVN8iAji53DnnpGirFUUMvVBswcwzaAqk9k6h7RTm5ZXeyQzLzm/EpVHPdEEb+x2XlaksAe6N6zyt0MQdCj+vpjA6JXJDvFufDz4wM+v35BYv7/caI82I97tb4h9y+aicymll751GM5xos/C44Kq2fPA+7tH/cDBzmGsS2Ry/EN3iRWiJiiULwCH0GtvCQ78WlUUDRFvVJtnueWPdjT+MAY+ce2GWLGaGLSOnBzKtfVIjAwDdhyar9vtDLOxoObJp5B7fVCp/zcqq7hkn9OAwONM7d5S8f/FzznnfwycCAzv+M2eaCs93Qwjn1SLNI6WwWoTcEd5jgBhoCx7oiOj8lBQwFSAO9ikaVfZCATRZjnntSOio2QrcuPAEHbmlgOh1+McFlc6W++oz9vQKZtISiNsg2ue8iifz4GKh9xYH+GyvN0zceYVehELW7Ld8iqZbDSqaGmZDIy6SUoTytXA88REez74g6F6E/unMx+rrkd3Lg/LsQwDImKrDYbHPfw7vlDRzIq1zP1Hmscxdm2U+xDlv/zLbgpRdaY3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(1590799012)(6486002)(85182001)(316002)(86362001)(966005)(38100700002)(36756003)(5660300002)(110136005)(26005)(6512007)(54906003)(478600001)(122000001)(83380400001)(8936002)(82960400001)(91956017)(1580799009)(66946007)(76116006)(2616005)(107886003)(66556008)(66476007)(38070700005)(41300700001)(71200400001)(6506007)(66446008)(64756008)(8676002)(2906002)(4326008)(1076003)(186003)(43620500001)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dUx2SDBQRzRna3VVRHdXek5iN2lPZE5hVkM4WWcxTTl5L2Jsb3ZsZCtuaSsw?=
 =?gb2312?B?QkV1Q1VsSXlqdWE0K01ZVlJYcmRhOXZ1aFByUjhJTzN2aXB2VnBBTWZyUExU?=
 =?gb2312?B?eDNlRVBSS01hN1ozL0c4a0hqdVFzS1lZdU1aR093eGM3MnQxdzVTWWV6dW5r?=
 =?gb2312?B?REZON0ZPdmlobzUzdTliZXphQU1XY3d5VG1BRHlYMmVEVXpYclJYNHBHOUpC?=
 =?gb2312?B?ZWFFb0h1cWpBcUY0R05vQUF1Z2ZBVlFWU0x6TFE1OENZUlhGTk9NZ1hSTk9R?=
 =?gb2312?B?Yi8vMmlFL1RTZnNub0NUR2h3bUpZUm5GdmtOQnprTmVDYVBTZTlZNVVBY251?=
 =?gb2312?B?L3BPTzBxNGtqY0cwZkRrdXphSElQWXN3MDNsZEU5S1Fqb2VnMnkzaWptWDBX?=
 =?gb2312?B?eGJKVUVvQk0yVkQ1cWxUNUEvZVZIcm5KWkdvWW9wdVl4akZaTVYrQ2FsNlp6?=
 =?gb2312?B?VUVRbmdZemdtU09CNlZwYmZjc0V0SlpRaENmZDRZL0R2clhpZzh2N2lrbWY1?=
 =?gb2312?B?NE5CVTlXUVhwd2VzZVVJckVaZW12TTU1dURzalZCVlhnOXFlTEZkZFluMGlo?=
 =?gb2312?B?SnhVZHNobWRJVWpkQzk2UGpPMnIvZ1dQOUlaTUJ2M1Y2cnhPbUlSeERoT3Nv?=
 =?gb2312?B?bVNjMzhnRmZoSWpRUXNTbDl4WFF1bG5YMGh3Z0R1OGNrR3kxT01wSzBWbGtw?=
 =?gb2312?B?MXRsNFNGK1dldjQ5ZURLSzd4b3VMYnNMaUxDK0UwdGNCUGZvcW93Q1VnWTJs?=
 =?gb2312?B?dy9ONDdwSTFFN1hLR2MrY2FTa0tsVDRGMUJwSWdQbFBVVXFpNzFIeFQ3ZklF?=
 =?gb2312?B?Ukc1aGt6QzhIR2x2aWZ2dzJZWk12bnJudHFpN3Z3L3orRFRKVDc0SWpkdGlF?=
 =?gb2312?B?bktwS1dxNTlXSGZ2blU2UVlaWk12RmIwemZPMjdMd0RpZ3JXcHQrQStTdWZS?=
 =?gb2312?B?V09Ka0RPcHgwMzluNU1BQW8wOVFqNTRSWi9ZSzg4N0hoazNqMDlIN040M2Nj?=
 =?gb2312?B?U3kycWorNTFKV3hFb3R2NmZUZUthRllLRVhqMGNaN1hmdmZnWFhlQ092NjFa?=
 =?gb2312?B?Tlk1dnFkd25BaU1xb0JwNzNQb21JVVJmS21Jb3BzNjdBV3NOam9qcTlOeFdp?=
 =?gb2312?B?enpRdEFsMkp5V1ZMR0tPckcra2IrZ1M3QmUyVk9WVFJKQzRPVk01aTVXOGZT?=
 =?gb2312?B?Q1BiaFZUbGxnN0NEVWgwTXVneUYzbDhnSzZMZURmWEJrVUhJNzBTS3hkbkR5?=
 =?gb2312?B?MmlyLzRFbzJVZTFZT2xLc3FLZ2hraGdtN0ZVanlUM2pOaUFNVGVyUW9jZHo0?=
 =?gb2312?B?ZkJDZGFwT2xQR3dlWGl1cHhLZjFqTExGazNPRjhGVEJZL0Y3RjZuTzZ4VllT?=
 =?gb2312?B?ZnNCSFA1dUpXdjRNMmVjRTNBKzRCclltLy9McnVQWWxlaVZFalNKMEtURGpw?=
 =?gb2312?B?STluZjU1MGljYnJJZVgzZVRxTmtRZ0U1SnlRVkpBV25icS93anV6OEFmOUtT?=
 =?gb2312?B?Y2J3dU55MXFIb0o1M0hRanhDMmI4TmlaeFJRQUZZVjJlSlhuWUhpU3RXMHRH?=
 =?gb2312?B?U1Y0bWZDOUxnUUVFdmcvdXZ0N25UaTFNSi96dUdXcTNDN0hRT2x4MjJqU1ZH?=
 =?gb2312?B?ZzR2NE9zNVRtbUF6ZWRrendxVWFhVmJvYVcrdEJRamU2RG1OaU9qSGdkZUVw?=
 =?gb2312?B?QUx4cTg2SjAzRXk0L0g0Sk0weXdWWmIwa0UwT3RyK1Fta1hBSWRNWndIZ0JQ?=
 =?gb2312?B?ZzUxMGliMEJkUUFkWDFiUzJud1ZFYlBoNXZKeStSNG1FdGhzMnU2MkVIWnBW?=
 =?gb2312?B?czZDeVpkcFBIL0tZbHYxOGVGV2JmN3ZObTg4U0YwOGV4clJqamFSZFF4d2wr?=
 =?gb2312?B?UDlBTlFrZTk3eGh1YlZvT3NSbGU3OHAvemJid0J4Z1E2Zmh3Y1U4ZXBicVNL?=
 =?gb2312?B?a0o0Y3ZONUY2aWVFcnRaZGxLeWtwaURpMVlkSDdWUjhOUW1RYzBES3BKYVhV?=
 =?gb2312?B?Qnh3aUJpd3hhcXFJVnlsSnZ0ZmdpOUFGYnZ4bG4zcG9KQ2VnNHBRWU9HNnZF?=
 =?gb2312?B?QXVzZmZCdDZpTDlTTkhwZkRDU2UvTnBFSG0vZytrcjF0N3hiRVBFVnpoUHg3?=
 =?gb2312?B?aTJCamUwMFhMQWs3L0htcDZ3R0RYR1EwNGpuWUllbzJFdDBiamtQYURXNXVX?=
 =?gb2312?B?dXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a52455-766c-47ac-bdd4-08daae77ac2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2022 06:37:03.8832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QHv7PDYQA+KQhkMtNjc3CW2/rI11VCn5zEZokW0dPwLa2wvM5Q4vdjw46mK+2Mq0GZ2a3UChCxryYLl9LrKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhlIElCIFNQRUMgdjEuNVsxXSBkZWZpbmVkIG5ldyBhdG9taWMgd3JpdGUgb3BlcmF0aW9uLiBU
aGlzIHBhdGNoc2V0DQptYWtlcyBTb2Z0Um9DRSBzdXBwb3J0IG5ldyBhdG9taWMgd3JpdGUgb24g
UkMgc2VydmljZS4NCg0KT24gbXkgcmRtYS1jb3JlIHJlcG9zaXRvcnlbMl0sIEkgaGF2ZSBpbnRy
b2R1Y2VkIGF0b21pYyB3cml0ZSBBUEkNCmZvciBsaWJpYnZlcmJzIGFuZCBQeXZlcmJzLiBJIGFs
c28gaGF2ZSBwcm92aWRlZCBhIHJkbWFfYXRvbWljX3dyaXRlDQpleGFtcGxlIGFuZCB0ZXN0X3Fw
X2V4X3JjX2F0b21pY193cml0ZSBweXRob24gdGVzdCB0byB2ZXJpZnkNCnRoZSBwYXRjaHNldC4N
Cg0KVGhlIHN0ZXBzIHRvIHJ1biB0aGUgcmRtYV9hdG9taWNfd3JpdGUgZXhhbXBsZToNCnNlcnZl
cjoNCiQgLi9yZG1hX2F0b21pY193cml0ZV9zZXJ2ZXIgLXMgW3NlcnZlcl9hZGRyZXNzXSAtcCBb
cG9ydF9udW1iZXJdDQpjbGllbnQ6DQokIC4vcmRtYV9hdG9taWNfd3JpdGVfY2xpZW50IC1zIFtz
ZXJ2ZXJfYWRkcmVzc10gLXAgW3BvcnRfbnVtYmVyXQ0KDQpUaGUgc3RlcHMgdG8gcnVuIHRlc3Rf
cXBfZXhfcmNfYXRvbWljX3dyaXRlIHRlc3Q6DQpydW5fdGVzdHMucHkgLS1kZXYgcnhlX2VucDBz
MyAtLWdpZCAxIC12IHRlc3RfcXBleC5RcEV4VGVzdENhc2UudGVzdF9xcF9leF9yY19hdG9taWNf
d3JpdGUNCnRlc3RfcXBfZXhfcmNfYXRvbWljX3dyaXRlICh0ZXN0cy50ZXN0X3FwZXguUXBFeFRl
c3RDYXNlKSAuLi4gb2sNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KUmFuIDEgdGVzdCBpbiAwLjAwOHMNCg0K
T0sNCg0KWzFdOiBodHRwczovL3d3dy5pbmZpbmliYW5kdGEub3JnL3dwLWNvbnRlbnQvdXBsb2Fk
cy8yMDIxLzA4L0lCVEEtT3ZlcnZpZXctb2YtSUJUQS1Wb2x1bWUtMS1SZWxlYXNlLTEuNS1hbmQt
TVBFLTIwMjEtMDgtMTctU2VjdXJlLnBwdHgNClsyXTogaHR0cHM6Ly9naXRodWIuY29tL3lhbmd4
LWp5L3JkbWEtY29yZS90cmVlL25ld19hcGlfd2l0aF9wb2ludA0KDQp2NS0+djY6DQoxKSBSZWJh
c2Ugb24gY3VycmVudCBmb3ItbmV4dA0KMikgU3BsaXQgdGhlIGltcGxlbWVudGF0aW9uIG9mIGF0
b21pYyB3cml0ZSBpbnRvIDcgcGF0Y2hlcw0KMykgUmVwbGFjZSBhbGwgIlJETUEgQXRvbWljIFdy
aXRlIiB3aXRoICJhdG9taWMgd3JpdGUiDQo0KSBTYXZlIDgtYnl0ZSB2YWx1ZSBpbiBzdHJ1Y3Qg
cnhlX2RtYV9pbmZvIGluc3RlYWQNCjUpIFJlbW92ZSB0aGUgcHJpbnQgaW4gYXRvbWljX3dyaXRl
X3JlcGx5KCkNCg0KdjQtPnY1Og0KMSkgUmViYXNlIG9uIGN1cnJlbnQgd2lwL2pnZy1mb3ItbmV4
dA0KMikgUmV3cml0ZSB0aGUgaW1wbGVtZW50YXRpb24gb24gcmVzcG9uZGVyDQoNCnYzLT52NDoN
CjEpIFJlYmFzZSBvbiBjdXJyZW50IHdpcC9qZ2ctZm9yLW5leHQNCjIpIEZpeCBhIGNvbXBpbGVy
IGVycm9yIG9uIDMyLWJpdCBhcmNoIChlLmcuIHBhcmlzYykgYnkgZGlzYWJsaW5nIFJETUEgQXRv
bWljIFdyaXRlDQozKSBSZXBsYWNlIDY0LWJpdCB2YWx1ZSB3aXRoIDgtYnl0ZSBhcnJheSBmb3Ig
YXRvbWljIHdyaXRlDQoNClYyLT5WMzoNCjEpIFJlYmFzZQ0KMikgQWRkIFJETUEgQXRvbWljIFdy
aXRlIGF0dHJpYnV0ZSBmb3IgcnhlIGRldmljZQ0KDQpWMS0+VjI6DQoxKSBTZXQgSUJfT1BDT0RF
X1JETUFfQVRPTUlDX1dSSVRFIHRvIDB4MUQNCjIpIEFkZCByZG1hLmF0b21pY193ciBpbiBzdHJ1
Y3QgcnhlX3NlbmRfd3IgYW5kIHVzZSBpdCB0byBwYXNzIHRoZSBhdG9taWMgd3JpdGUgdmFsdWUN
CjMpIFVzZSBzbXBfc3RvcmVfcmVsZWFzZSgpIHRvIGVuc3VyZSB0aGF0IGFsbCBwcmlvciBvcGVy
YXRpb25zIGhhdmUgY29tcGxldGVkDQoNClhpYW8gWWFuZyAoOCk6DQogIFJETUE6IEV4dGVuZCBS
RE1BIHVzZXIgQUJJIHRvIHN1cHBvcnQgYXRvbWljIHdyaXRlDQogIFJETUE6IEV4dGVuZCBSRE1B
IGtlcm5lbCBBQkkgdG8gc3VwcG9ydCBhdG9taWMgd3JpdGUNCiAgUkRNQS9yeGU6IEV4dGVuZCBy
eGUgdXNlciBBQkkgdG8gc3VwcG9ydCBhdG9taWMgd3JpdGUNCiAgUkRNQS9yeGU6IEV4dGVuZCBy
eGUgcGFja2V0IGZvcm1hdCB0byBzdXBwb3J0IGF0b21pYyB3cml0ZQ0KICBSRE1BL3J4ZTogTWFr
ZSByZXF1ZXN0ZXIgc3VwcG9ydCBhdG9taWMgd3JpdGUgb24gUkMgc2VydmljZQ0KICBSRE1BL3J4
ZTogTWFrZSByZXNwb25kZXIgc3VwcG9ydCBhdG9taWMgd3JpdGUgb24gUkMgc2VydmljZQ0KICBS
RE1BL3J4ZTogSW1wbGVtZW50IGF0b21pYyB3cml0ZSBjb21wbGV0aW9uDQogIFJETUEvcnhlOiBF
bmFibGUgYXRvbWljIHdyaXRlIGNhcGFiaWxpdHkgZm9yIHJ4ZSBkZXZpY2UNCg0KIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlX2NvbXAuYyAgIHwgIDQgKysNCiBkcml2ZXJzL2luZmluaWJh
bmQvc3cvcnhlL3J4ZV9vcGNvZGUuYyB8IDE4ICsrKysrKw0KIGRyaXZlcnMvaW5maW5pYmFuZC9z
dy9yeGUvcnhlX29wY29kZS5oIHwgIDMgKw0KIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhl
X3BhcmFtLmggIHwgIDUgKysNCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyAg
ICB8IDE1ICsrKystDQogZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfcmVzcC5jICAgfCA4
NCArKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGluY2x1ZGUvcmRtYS9pYl9wYWNrLmggICAg
ICAgICAgICAgICAgIHwgIDIgKw0KIGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oICAgICAgICAgICAg
ICAgIHwgIDMgKw0KIGluY2x1ZGUvdWFwaS9yZG1hL2liX3VzZXJfdmVyYnMuaCAgICAgIHwgIDQg
KysNCiBpbmNsdWRlL3VhcGkvcmRtYS9yZG1hX3VzZXJfcnhlLmggICAgICB8ICAxICsNCiAxMCBm
aWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KLS0gDQoy
LjM0LjENCg==
