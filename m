Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5366C570F2E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 03:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGLBGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jul 2022 21:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGLBGN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jul 2022 21:06:13 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8922324F19
        for <linux-rdma@vger.kernel.org>; Mon, 11 Jul 2022 18:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657587971; x=1689123971;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=SZEpfTmQidgeA6X10K5nB0Nsqfl6EZxjmHKw/0z3xPo=;
  b=JFN5a1XJGIKwhym8eefpPNsLlU27DpCmeNoUlKUJdUBOFt0T2PJ4pR5J
   FC6QnCBPHpRRt6IHKV/0zag2vIa1wyyCWmT50c4vr12tJ+mg5RqZHg6cy
   mr0DLOaYh2CXlA3rubO7heXMLO6UfpsAcYJf/4Zc811hIhmnZcRILeMTw
   EJm6nr+5+iDwnTfk/M39zQNVc0iLF/iCnHuzBeN/uy4/ONlSgeGLMCOXU
   AQsLjgdQcfJfNTeiOTt2HTqtjNVcmhf4KfOmAkROIurFGqjO72DWWiekm
   o+MkwETUbhx78CVKTdK3GW7ttHFwzGiySjJ1V+unBqNvG8rHqNTW5ebWw
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="60274922"
X-IronPort-AV: E=Sophos;i="5.92,264,1650898800"; 
   d="scan'208";a="60274922"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:06:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw7fmmi/zFxykkTg0tesaJPOvrHuB9/Uh9Itht5vpkKzXhbmXvKp34qyshtwOBjUaBzYJD/np0n+WbsGI1eVbBesrI3pT54Lv5lmlNAKM+MPXyO7baVHN7zuv3knHxouzn2Iv5dWqdog7tdIrjrZph8gqtxxCsEniiwPMV65fkD8ISjFUTuf//XIXvm9b0zKoL7qz53pIM6Xy8FodbzkCeKe2B1hSYQxEz99xTYsCFl88QcpOIC5x6wgZvQxFbWEpuJSuYhFucOn/wBtb82JqqHev1wH0fDoODYq0IB991wB0OoLAqRkdOeYKb9TBZHSyCEjUmUb4QHwhemqj/yLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZEpfTmQidgeA6X10K5nB0Nsqfl6EZxjmHKw/0z3xPo=;
 b=gx4uIVrf8SpqgcHF1Rm4uDgJMczxFC31DIOK7pkB9r8JQGLgVVuEPEEZrtT24teKa+zKuH0vBNuQVMKzJaTyXA6sGLOMQwFJyXwVAG+rL6RP8fGDoWbDfe3TiNWfwgr3szq34fqpbayFFF1L68F99Kb1q/m8EBD8CB8WElbFbzcizFHn4isdR1AIuMtW2DvCtpa7n9hLvhevbXLzo42q6wJDNPRtTRcFOJvZO1t6pAOUN2Zyhh15PtWVKuPl20v9lG4QIKwKrJvsA2ou4KouRrpKEp7HFb0jPII6czI/96GWGpp7dycj5WovzNoRcLbehvv4mOP6cuiH7TzADTaQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZEpfTmQidgeA6X10K5nB0Nsqfl6EZxjmHKw/0z3xPo=;
 b=aBc40NmwOyUEDilspYk4z6wU7P6e4CSomW04gw1+UVblApkNpvUxF6ow27sODswwimXiRwv3zJGDUYuvU96JIE7X4TfLP5Qw0aT7D1aEJblHjJOjIbW/WIxcOSYqrsOxW0ZTjSHDUFZGmeIjavj82JNHqyxv4tiga3nGnW+q/9s=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by TY2PR01MB5162.jpnprd01.prod.outlook.com (2603:1096:404:11a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Tue, 12 Jul
 2022 01:06:05 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::8d7a:baa8:3b18:cd93%8]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:06:05 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Topic: [PATCH for-next] RDMA/rxe: check rxe_pd before rxe_put in
 rxe_mr_cleanup()
Thread-Index: AQHYkRm6Bw1pQgLwyUy00KjkER3CY6159OgA
Date:   Tue, 12 Jul 2022 01:06:04 +0000
Message-ID: <42ec06bb-9e97-3b43-5fb9-9801407d301e@fujitsu.com>
References: <20220706092811.1756290-1-lizhijian@fujitsu.com>
In-Reply-To: <20220706092811.1756290-1-lizhijian@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ebd8c36-8873-48d6-cedd-08da63a2b216
x-ms-traffictypediagnostic: TY2PR01MB5162:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ughxEDJj2kvuTHkI2Gqq2GNB1+/SoWrA5rxqOR391NkMtDaRdP2x24OzDTaBVoFWipKrcDoFDvA4yLe9rI6GBM9AowF885lQ9FNKQ/ZFP1XhyBRR8UhLYL2HoT+lkZkIUeDzgcBXywIvP3a+XbsM8GBZyp1JqHSdzvsBEiwkxdUj5AKOrovIu7Y4enD9ACAMLgn+/QlX123vsgPkx73lfUoEEpUE1Y1Q6GJN8ItpUIbtsyO66JAwpb3GSQNAX3DWG91vh/xvD5jykGPOj2NlUX/SKYQ65uXSWDcGKbO5rhIorw3W8ZVtRm3cbII7f8xJlVd3GFQF3qyMUfYwDD0btR1Z/4jhwu72KrJucneMSnlXrU/RCw8Ys3vLWH8MGfix5Ju0oOpdnQIDfXZIWl0zACju4tTYA3BcUlYq0P6zoOpFJPNWBih2erHC0f5xzXgzGe7B8EWWDrsTLH4do1xTfI39LnRzqcnItBkqcYJuVbSijag/zPXH9/6YQehNQwIfNvO9t6o7MjMXrdxe+gdn0ILDQHBogES82PruvBsayakccdxRcKE0JqeOLyp62FSAuRS7oe1mg70LZBqZkFkTFqIyUuSgBwfKT56rTYGzroj3301uom7b0ZwrAnXypTrHatE+H5e9VIl7h4Nj4KDkYF1ZqsqC8vcHf083d2S4D/AQ0GZu4nsyrMbLi1Me89kLm3OVd89qEoTxFmGEv9ehs7CN1nxjHsqlUOZZgUH7f/gDun7dDkskSL7nGcZfsBbozE9AJEYkDn1ARyHJEPLsvJ0zqrSUbXfm+fJ9KLmRKnu1eAa25tOBSRr1OMxuenLq6N2WcfUQz7QIWHEHc7Weralzb7Jf9WfqQxjNA+ZlMp7NS3Bipmjz6O6JBKEZaoR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(64756008)(66946007)(66476007)(66556008)(5660300002)(86362001)(76116006)(66446008)(38070700005)(8936002)(91956017)(8676002)(53546011)(31696002)(71200400001)(6506007)(41300700001)(316002)(110136005)(82960400001)(478600001)(26005)(38100700002)(6512007)(186003)(36756003)(83380400001)(6486002)(85182001)(31686004)(2616005)(2906002)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1p3MFFZVVhYMlMya1lQSEdmWTkrM2wzSFJ0eStjNmNoaDMxWDJsbVM0WlF6?=
 =?utf-8?B?RlhCY2g4b0pwK3BnMWxYdmpBZzQ1T05GOEVERnVUT2dhZHdDaFpuYUNITVZp?=
 =?utf-8?B?d3VXaTU1ZncxR0p2ekpvaUhoVFhmYytwZTNUUzFKQWFNdXhKQysya2IrZWhD?=
 =?utf-8?B?WVNteUhseldmK0RMYnBJVTJWYVpraE9JaGNOMTgxQkFmd2xmVXcwN1Zqektq?=
 =?utf-8?B?VnBWQlkrZ2gzOGJwUUhUblVmZGsxcURrZnBlOWxQaHJmYUZlNyt2RkVodFRr?=
 =?utf-8?B?QVdTRmNkS2U5dzFTQklaNU04cVd4UHJiZG92ditldm93SWV3UUN5Qk8xcEEz?=
 =?utf-8?B?Nm4rS1BScTNWOFVuM3RHUVdZOXRrTk9henhITnNTV01tZkZhSWt6Wm1nbktU?=
 =?utf-8?B?ZVF5VTBVYWswNHNuaWxMcUpPMmg0Z3hxeFhSTzViTEdvaEFET204cjZ2dVJT?=
 =?utf-8?B?c2U2elZuR3BzbHpaWG42eFp0TysxbXAxcnNNVWcydy9PbER3L2JpU3FtdmJI?=
 =?utf-8?B?WnZwZitsQytFdnVZS1VUUkVhaXJuRldJYnZEM0tmakk2cVAySHp4MDlvckZB?=
 =?utf-8?B?VVhLMTBQOTBRd3ZSYWhvVEF5akF5TnZzQTNKU1NwaFFFMk1uSDk3NmVCQUQz?=
 =?utf-8?B?MlFKMDZTRzRMNjVpcGpwZHFXb3JpU3ZsQWdtek93c1dCTEJKdFozckZCMmZx?=
 =?utf-8?B?eWVVZGFDMVFJRmwrTXJLMUpTalRPSUw0K1RKclhuRW5HOVhUc1lQQXN2YkJk?=
 =?utf-8?B?Zkw2Z09nTGlOREhDajNIVVlCR3NCYzJzcUF4blNnd3BubUJmMUFIZlhVYjN0?=
 =?utf-8?B?UGlJN0lLK3I4c3g4emhzR0VhT1R3RWZWVis2bjNSUHB1dTZIVWFxa2VSMVZU?=
 =?utf-8?B?cHdCaGtONjB6VFlXVVloL1pUamJOUjBWckhBSzVkbERjb0syZFo4YzlMcmVV?=
 =?utf-8?B?eTBMRjBMdmRsODlZTUh0b01mRGpKNmpOVExZaStsNFpXVmsrNTJqTTM3bXJD?=
 =?utf-8?B?TUVGRzVHWTBOWlZWTlJadFBEY1hVYjhBYzhKeHlncCtnWExaMnZQUkdMK1dC?=
 =?utf-8?B?YnVQNjlxQS90SFc2VGM3OUp6dzBBTi9UK3Y4aFpJNlNDVFdLaWdCSWpQcW02?=
 =?utf-8?B?TzNFR0JkYWhrTjFhS0JUWStaeUEyd09YdUFtV0t3bGxMVVF4YjV5bXdoSW1S?=
 =?utf-8?B?dzc4SmRjR1AxTDlRcmo5Nys1TG5TZE90ZGJrMVlidWtoaDlGU1pwdFZFNnE4?=
 =?utf-8?B?Sk1Db2pFc3pZYXd6NllxYnBOZmVxQ2swWVdGOWMycGlvRmpiWmgzTkE1QUFq?=
 =?utf-8?B?MGVmY2hmaitwekhINzZ5RmVDcHdaaFRreWVacmRLN0pVZG9PRXZzc2RHeVZy?=
 =?utf-8?B?Mkgvd1B6WGFrZ0R3NVlrWmQybFZmN0pKUzRWSnRtKzFSbmdMVWpENDluemI1?=
 =?utf-8?B?aHpOWnFIZXlHUFRDZjIrbCt4MU44dVc1OEdiYnd4OW1UK09ZYndRZWZiRFpx?=
 =?utf-8?B?TW1DS25MWEk2aTdIQmNIVFZLUjc5eUxBUWsrL3pXbVVqSmtSam5DVUNGYzRt?=
 =?utf-8?B?bXdsUHc1ckZja2pVcUlEZGY5S0FhdnV2S1UybW96dEdNNXUyNitZcmNFMXhv?=
 =?utf-8?B?dHBnWjg1TWZXdDExa2xRR0JOWTJiU1dLZVJqQW1qMWYxZXk1WklqSkovV1NF?=
 =?utf-8?B?c2lOWDRnT24vZ1lIV09JOHBGTHBiS3k1c1RiODhqcjlod3c4Y1BZVzFydTFF?=
 =?utf-8?B?eWxDVU1NamZtVjd3UWI2d0NiNG95OFovWHV0R1M3VytnLzNMdUNISHUwZU10?=
 =?utf-8?B?Z2plNGxSN0ZzTnNlQmsvWUVnUzh1dVV2V3F4bmZ0c3VvbURlOWsxa0oyYUY0?=
 =?utf-8?B?ZW5NYmpQMzlBWDRJbnBXT3BVVlFLbTYzSHdzYlFjclpFdTh4cnBydlNiRXd1?=
 =?utf-8?B?WkRhMjFobG53Q3Zuc0Uvb21TMCtHUVdoM0lSWW1ZeFdkOGFMNnVBUGNhTmYw?=
 =?utf-8?B?cHNBcWtyN2VNdWZvOFlaVFRoOExPcGpia3pRMy9DWEdmcTE0N0dVcm1jRFlL?=
 =?utf-8?B?ZlJ0TEcxMytaTVQ4UktWQ2pnbEIvMGNCMmRwU3NaTUZUNzNhVnlRYU11MmFq?=
 =?utf-8?B?ck5YS2dWMG9EQmVFV0MrZnkrbWxvbXFBMVBzbHpwZTUrcHpCd0pLWEwyRFJm?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F747AEA5FD65114983DB57FD8214AAAF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebd8c36-8873-48d6-cedd-08da63a2b216
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:06:04.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RwMerbc96qWFfbDrrNRctuOGQ3x29sHfkR/vbcPxwbK/pCcjmMHFozGuHXH+8PSf4afLJYIglxueBWSDzIsFXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5162
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCk9uIDA2LzA3LzIwMjIgMTc6MjEsIExpLCBaaGlqaWFuIHdyb3RlOg0KPiBJdCdzIHBvc3Np
YmxlIG1yX3BkKG1yKSByZXR1cm5zIE5VTEwgaWYgcnhlX21yX2FsbG9jKCkgZmFpbHMuDQo+DQo+
IGl0IGZpeGVzIGJlbG93IHBhbmljOg0KPiBbICAxMTQuMTYzOTQ1XSBSUEM6IFJlZ2lzdGVyZWQg
cmRtYSBiYWNrY2hhbm5lbCB0cmFuc3BvcnQgbW9kdWxlLg0KPiBbICAxMTYuODY4MDAzXSBldGgw
IHNwZWVkIGlzIHVua25vd24sIGRlZmF1bHRpbmcgdG8gMTAwMA0KPiBbICAxMjAuMTczMTE0XSBy
ZG1hX3J4ZTogcnhlX21yX2luaXRfdXNlcjogVW5hYmxlIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3Ig
bWFwDQo+IFsgIDEyMC4xNzMxNTldID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiBbICAxMjAuMTczMTYxXSBCVUc6IEtB
U0FOOiBudWxsLXB0ci1kZXJlZiBpbiBfX3J4ZV9wdXQrMHgxOC8weDYwIFtyZG1hX3J4ZV0NCj4g
WyAgMTIwLjE3MzE5NF0gV3JpdGUgb2Ygc2l6ZSA0IGF0IGFkZHIgMDAwMDAwMDAwMDAwMDA4MCBi
eSB0YXNrIHJkbWFfZmx1c2hfc2Vydi82ODUNCj4gWyAgMTIwLjE3MzE5N10NCj4gWyAgMTIwLjE3
MzE5OV0gQ1BVOiAwIFBJRDogNjg1IENvbW06IHJkbWFfZmx1c2hfc2VydiBOb3QgdGFpbnRlZCA1
LjE5LjAtcmMxLXJvY2UtZmx1c2grICM5MA0KPiBbICAxMjAuMTczMjAzXSBIYXJkd2FyZSBuYW1l
OiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNC4w
LTI3LWc2NGYzN2NjNTMwZjEtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNA0KPiBbICAxMjAu
MTczMjA4XSBDYWxsIFRyYWNlOg0KPiBbICAxMjAuMTczMjE2XSAgPFRBU0s+DQo+IFsgIDEyMC4x
NzMyMTddICBkdW1wX3N0YWNrX2x2bCsweDM0LzB4NDQNCj4gWyAgMTIwLjE3MzI1MF0gIGthc2Fu
X3JlcG9ydCsweGFiLzB4MTIwDQo+IFsgIDEyMC4xNzMyNjFdICA/IF9fcnhlX3B1dCsweDE4LzB4
NjAgW3JkbWFfcnhlXQ0KPiBbICAxMjAuMTczMjc3XSAga2FzYW5fY2hlY2tfcmFuZ2UrMHhmOS8w
eDFlMA0KPiBbICAxMjAuMTczMjgyXSAgX19yeGVfcHV0KzB4MTgvMHg2MCBbcmRtYV9yeGVdDQo+
IFsgIDEyMC4xNzMzMTFdICByeGVfbXJfY2xlYW51cCsweDIxLzB4MTQwIFtyZG1hX3J4ZV0NCj4g
WyAgMTIwLjE3MzMyOF0gIF9fcnhlX2NsZWFudXArMHhmZi8weDFkMCBbcmRtYV9yeGVdDQo+IFsg
IDEyMC4xNzMzNDRdICByeGVfcmVnX3VzZXJfbXIrMHhhNy8weGMwIFtyZG1hX3J4ZV0NCj4gWyAg
MTIwLjE3MzM2MF0gIGliX3V2ZXJic19yZWdfbXIrMHgyNjUvMHg0NjAgW2liX3V2ZXJic10NCj4g
WyAgMTIwLjE3MzM4N10gID8gaWJfdXZlcmJzX21vZGlmeV9xcCsweDhiLzB4ZDAgW2liX3V2ZXJi
c10NCj4gWyAgMTIwLjE3MzQzM10gID8gaWJfdXZlcmJzX2NyZWF0ZV9jcSsweDEwMC8weDEwMCBb
aWJfdXZlcmJzXQ0KPiBbICAxMjAuMTczNDYxXSAgPyB1dmVyYnNfZmlsbF91ZGF0YSsweDFkOC8w
eDMzMCBbaWJfdXZlcmJzXQ0KPiBbICAxMjAuMTczNDg4XSAgaWJfdXZlcmJzX2hhbmRsZXJfVVZF
UkJTX01FVEhPRF9JTlZPS0VfV1JJVEUrMHgxOWQvMHgyNTAgW2liX3V2ZXJic10NCj4gWyAgMTIw
LjE3MzUxN10gID8gaWJfdXZlcmJzX2hhbmRsZXJfVVZFUkJTX01FVEhPRF9RVUVSWV9DT05URVhU
KzB4MTkwLzB4MTkwIFtpYl91dmVyYnNdDQo+IFsgIDEyMC4xNzM1NDddICA/IHJhZGl4X3RyZWVf
bmV4dF9jaHVuaysweDMxZS8weDQxMA0KPiBbICAxMjAuMTczNTU5XSAgPyB1dmVyYnNfZmlsbF91
ZGF0YSsweDI1NS8weDMzMCBbaWJfdXZlcmJzXQ0KPiBbICAxMjAuMTczNTg3XSAgaWJfdXZlcmJz
X2NtZF92ZXJicysweDExYzIvMHgxNDUwIFtpYl91dmVyYnNdDQo+IFsgIDEyMC4xNzM2MTZdICA/
IHVjbWFfcHV0X2N0eCsweDE2LzB4NTAgW3JkbWFfdWNtXQ0KPiBbICAxMjAuMTczNjIzXSAgPyBf
X3JjdV9yZWFkX3VubG9jaysweDQzLzB4NjANCj4gWyAgMTIwLjE3MzYzM10gID8gaWJfdXZlcmJz
X2hhbmRsZXJfVVZFUkJTX01FVEhPRF9RVUVSWV9DT05URVhUKzB4MTkwLzB4MTkwIFtpYl91dmVy
YnNdDQo+IFsgIDEyMC4xNzM2NjFdICA/IHV2ZXJic19maWxsX3VkYXRhKzB4MzMwLzB4MzMwIFtp
Yl91dmVyYnNdDQo+IFsgIDEyMC4xNzM3MTFdICA/IGF2Y19zc19yZXNldCsweGIwLzB4YjANCj4g
WyAgMTIwLjE3MzcyMl0gID8gdmZzX2ZpbGVhdHRyX3NldCsweDQ1MC8weDQ1MA0KPiBbICAxMjAu
MTczNzQyXSAgPyBzaG91bGRfZmFpbCsweDc4LzB4MmIwDQo+IFsgIDEyMC4xNzM3NDVdICA/IF9f
ZnNub3RpZnlfcGFyZW50KzB4MzhhLzB4NGUwDQo+IFsgIDEyMC4xNzM3NjRdICA/IGlvY3RsX2hh
c19wZXJtLmNvbnN0cHJvcC4wLmlzcmEuMCsweDE5OC8weDIxMA0KPiBbICAxMjAuMTczNzg0XSAg
PyBzaG91bGRfZmFpbCsweDc4LzB4MmIwDQo+IFsgIDEyMC4xNzM3ODddICA/IHNlbGludXhfYnBy
bV9jcmVkc19mb3JfZXhlYysweDU1MC8weDU1MA0KPiBbICAxMjAuMTczNzkyXSAgaWJfdXZlcmJz
X2lvY3RsKzB4MTE0LzB4MWIwIFtpYl91dmVyYnNdDQo+IFsgIDEyMC4xNzM4MjBdICA/IGliX3V2
ZXJic19jbWRfdmVyYnMrMHgxNDUwLzB4MTQ1MCBbaWJfdXZlcmJzXQ0KPiBbICAxMjAuMTczODYx
XSAgX194NjRfc3lzX2lvY3RsKzB4YjQvMHhmMA0KPiBbICAxMjAuMTczODY3XSAgZG9fc3lzY2Fs
bF82NCsweDNiLzB4OTANCj4gWyAgMTIwLjE3Mzg3N10gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJf
aHdmcmFtZSsweDQ2LzB4YjANCj4gWyAgMTIwLjE3Mzg4NF0gUklQOiAwMDMzOjB4N2Y0YjU2M2Mx
NGViDQo+IFsgIDEyMC4xNzM4ODldIENvZGU6IGZmIGZmIGZmIDg1IGMwIDc5IDliIDQ5IGM3IGM0
IGZmIGZmIGZmIGZmIDViIDVkIDRjIDg5IGUwIDQxIDVjIGMzIDY2IDBmIDFmIDg0IDAwIDAwIDAw
IDAwIDAwIGYzIDBmIDFlIGZhIGI4IDEwIDAwIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDEgZjAgZmYg
ZmYgNzMgMDEgYzMgNDggOGIgMGQgNTUgYjkgMGMgMDAgZjcgZDggNjQgODkgMDEgNDgNCj4gWyAg
MTIwLjE3Mzg5Ml0gUlNQOiAwMDJiOjAwMDA3ZmZlMGU0YTZmZTggRUZMQUdTOiAwMDAwMDIwNiBP
UklHX1JBWDogMDAwMDAwMDAwMDAwMDAxMA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQpBZGQgRml4ZXMgdGFnOg0KDQpGaXhlczogY2Y0MDM2
Nzk2MWQ4ICgiUkRNQS9yeGU6IE1vdmUgbXIgY2xlYW51cCBjb2RlIHRvIHJ4ZV9tcl9jbGVhbnVw
KCkiKQ0KDQoNCj4gLS0tDQo+ICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbXIuYyB8
IDQgKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9tci5jDQo+IGluZGV4IDlhNWMyYWY2YTU2
Zi4uY2VjNTc3NWE3MmYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhl
L3J4ZV9tci5jDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yeGUvcnhlX21yLmMNCj4g
QEAgLTY5NSw4ICs2OTUsMTAgQEAgaW50IHJ4ZV9kZXJlZ19tcihzdHJ1Y3QgaWJfbXIgKmlibXIs
IHN0cnVjdCBpYl91ZGF0YSAqdWRhdGEpDQo+ICAgdm9pZCByeGVfbXJfY2xlYW51cChzdHJ1Y3Qg
cnhlX3Bvb2xfZWxlbSAqZWxlbSkNCj4gICB7DQo+ICAgCXN0cnVjdCByeGVfbXIgKm1yID0gY29u
dGFpbmVyX29mKGVsZW0sIHR5cGVvZigqbXIpLCBlbGVtKTsNCj4gKwlzdHJ1Y3QgcnhlX3BkICpw
ZCA9IG1yX3BkKG1yKTsNCj4gICANCj4gLQlyeGVfcHV0KG1yX3BkKG1yKSk7DQo+ICsJaWYgKHBk
KQ0KPiArCQlyeGVfcHV0KHBkKTsNCj4gICANCj4gICAJaWJfdW1lbV9yZWxlYXNlKG1yLT51bWVt
KTsNCj4gICANCg==
