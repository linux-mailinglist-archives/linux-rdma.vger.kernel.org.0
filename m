Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6853F83B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jun 2022 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiFGIcy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jun 2022 04:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFGIcx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jun 2022 04:32:53 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990A31D0EA
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jun 2022 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1654590771; x=1686126771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5yADaAz8QgsgxJCWiAS/dwEMldRhNFGteibT9X3Y93A=;
  b=LNMpOccMKkTQtQCkSFy/1SXFAIWuHLOT9BOooiITbHFIORIFXfBIMZWV
   h4Tb+8MAZTgOwSnaAOiH1WlKqXhVJXhF2IGuaH0jG0fNw7jEzYxMRMdCF
   6zZpLrKH0/KMGzvZ1TowqOhMCBNdxPJXbLORaDCXKLmD3hw/k70qAjUlL
   H3VedBiuDNz3fF5ThwHJRDc8vfCRoU8Nz3aD9UtedGwWBVRZ9LZWrqFPX
   vuc+Ub/0GDtAakpNDOISWQqo83UejnJ5E+/3U2NIdchRacsOID8Xf+vAp
   2wCZLWISU2OiKRHKJ976gsOtOWREhVtDmdjqHsqvdTM4Tq1ULr3frX7df
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="57634928"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="57634928"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:32:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2leyitU3zoKeEO1c5GnGS7HEO9xr50hdgFOtAxZGcuKasGizEjGmf3HXIcgM5koa42ylsZ63cdeZex/wGG0nFa+lIqDSTqd6z8MnMhY3oazmVUR1iI7lzERx9vDRT85yJ6M3J7vTY/SNkSH2yT9oakSBkY0ASUZI/g+zjvgtpqNY7sFcCY1RWgfcZ8SXYo2MJ1r0rSJlNvRTDeYSwhIcShqSFzgMIVPUB7wmBdZHRvQ6SDaVQYVJZBMf2xsvtXJ7Lt0ydi3sbNrwXsNVDbkpLG+B0wPilAb0XZ5W/PImnaI7hqLglSv0l7SN8U3Ab3sUNWoKOpGVzir9TlQ5WjIbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yADaAz8QgsgxJCWiAS/dwEMldRhNFGteibT9X3Y93A=;
 b=ar9cGMS/eASrc5Zyb+Eonq0FMFo2Md0lG4UJOqiytGHuMVJYWf4VlELyhiR149lymKr8HRtoTI/q9v3OajKtBDYgxfR1Syu0hJf41v6QWNMeSk3YJE08RF5H3TPibf/fU0B03lhAKCppWI3ZjzIOGKBo2Ez+iw+5/UbVx0YFgu133Pefk5F1C3/qd33OlhjLu40FHblpzPqfOSSYmqgy89rmN7e8SrtTZFabQu4k1myyrWTjb4MVIMBKyDaySa43qneNJ/tqFGshPJlo7kk/FWEGQojMAGN0GszKEVNRLvCRADhmOjxK3RlWVOCqrPf7a+LgpeVEO4qY4xR9mCvSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yADaAz8QgsgxJCWiAS/dwEMldRhNFGteibT9X3Y93A=;
 b=cD05//klGg7aiolyRx3LiunAFXXFkhbOrpjHnSQUnf9ra+fl8e3E1o+C5TfsuTROO3Rt3TPEiFJ/g4IOTpTEiIqUeuvOQK2pefoL5ExDcazwshmCNIu/1fbuETnLKcBqHA2iw1X23xlvnBwsHvlJKPiBBb54eSd0Kbz9phJI8Rk=
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com (2603:1096:400:196::10)
 by OS0PR01MB6130.jpnprd01.prod.outlook.com (2603:1096:604:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 08:32:40 +0000
Received: from TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91]) by TYCPR01MB9305.jpnprd01.prod.outlook.com
 ([fe80::6012:5658:1673:1e91%3]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:32:40 +0000
From:   "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Thread-Topic: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Thread-Index: AQHYaMbNflFUBo7urUmV11NGl2lwo61DwLwA
Date:   Tue, 7 Jun 2022 08:32:40 +0000
Message-ID: <fa9863f0-d42e-f114-5321-108dda270e27@fujitsu.com>
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
In-Reply-To: <20220516015329.445474-1-lizhijian@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cab380a1-be21-4b0c-7a07-08da486048eb
x-ms-traffictypediagnostic: OS0PR01MB6130:EE_
x-microsoft-antispam-prvs: <OS0PR01MB61303FD3B33CE5826B80851CA5A59@OS0PR01MB6130.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1Z3rwD1gmcH1cHsD6Vv3+TY69mvns/HbUTSziCznRtYAhyS5phggK+7eMuRzNykuIVjmy388yN9F/UyO7H1oL9j59MXppz6LW0Mhi46+JcW9w6qY4CRJ/DNDi9sNOyEcb7d8Ev3oulf8zwMBrh/MrSELCTUv2Y1WukRnj6FOOWRQrbnUtLfXb+4Nh8bVCb9tclUYpTRkhO3Vbxv/HUwhInBDxXy3ri+XbkahKu8gNE+BMVGbCTfMKPCL0UMl1w01niNjrFw2ebDTltC3HkKUi4QMZ+Kjr/u4sXb0lOc6R3OQJagVJ59ZKx33eJSGgopDZxRAH9fsRRcT+AcVmMbIkkihWITFhrtfKv/APNmxb4pRXaW9+OXORZtLpxm5N41nDzuKlMpEFzFjzA85oqpAhylukJRDZ8z+hJwDwPZ3PAGlM7bEaS+LfLkOCw/5VwTj8sJ67xXOooZ06FM9KVWwJ9DZFPh+V32V4DLcoMo3+Af/sPXMa4SC/uizlVd3B+Kpdv5WdL2luhvatEA1ThncFecoOKbPoIFTWpOfuY1QJ1HbZ+F5iB77oCuk3C0sA21ob8ghKbXOjbJjtURAeqXcAl9hArHICa3Gj9h5JDTrOHmqXOAUwmCsb4llHPc+UKMKLr9bU2IvfC8FF/xVOJTLpQc9egJF+8MstHkUtXuqj7CluCeJq9U+KOgSnum/YH1+qhnWftmrfhNhQC8zgLRpaXnnYkOa5lDZOpJCmxoW/w4RMm2A9tTZ85pv0HDQP4BFrtHoj11znRSvvidmfYcXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9305.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(64756008)(66476007)(38100700002)(66446008)(66556008)(4326008)(31686004)(71200400001)(66946007)(186003)(8676002)(36756003)(2906002)(76116006)(5660300002)(91956017)(508600001)(122000001)(4744005)(38070700005)(82960400001)(85182001)(26005)(8936002)(2616005)(316002)(6486002)(6506007)(53546011)(110136005)(83380400001)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlF2SWI1ZUxwMm85ZjZIb2NCcVFoOTk3NHBYeEQ4VFAydEFFRVZOTmFHWUxl?=
 =?utf-8?B?dFpKbFFtRnkzdDUrUnQrN1h1NTlzSjBsN2pkdEtWSk9qN3JQRnRQTXdkZ21U?=
 =?utf-8?B?QTNKN1psbnFURHQxbFFqV0l6VFRMMWo4U1ZVWktTaGtHM1k2cjJyODRiamFw?=
 =?utf-8?B?TGJRc29xcWpoV2ZiKzlpZ3c5TEduZER3ZUtwMVdkQU15bGkwemZhYTZkSFBV?=
 =?utf-8?B?aG9zeDRNaHNNQnlmcXowNzRHTTVBcUkyQmlaYkEyTnhRWEcwR3RQaXVJaVBo?=
 =?utf-8?B?bkhWQUVkVVVnSk9DWDZpQkhNamc1a3FaY0QzNitnMTJVM3NOclJ2ajgxZE4v?=
 =?utf-8?B?d3RRbXk4Tkk3WEVqUTV4bm80VEUrOWFPRytaNVZxczhMTUIwa2MxK1Q0YnFh?=
 =?utf-8?B?OUtPWlpWTStRRktxM1Y1NjFiZEZ5Y2R5WVNrbkIwRitoQXdtUDBjazhrUDMy?=
 =?utf-8?B?WGRyamFRcmhTQjI4ZEZBYUE1Rkl4WGlLaHF3eEM5N3hLbFF0czFaaGg5U2xp?=
 =?utf-8?B?Wmw5K2NCZ2NMOHVNekNzSjY1UWp1bkZhenBrUlZwZDQvVDc1WXlTY2g0QTMw?=
 =?utf-8?B?Y1FBMzFCTWp6WFdMZ1FXR0l6S0pTa3kwdW9DdUw1YldwUk9xamIrRG5sVXFv?=
 =?utf-8?B?VDc4eWhXcWgxKzFBeWE0em4wTFoxUjhpb3JOek5McVd2ZURVei84dUtubU90?=
 =?utf-8?B?bk5UMCt3YTFxTVZNSkJPcFE0b3FUdHNIcTN3amx2WWlxcDF2eWxPUnBEaUVy?=
 =?utf-8?B?OHNZVm1zaWFKaUlyODYwQjVRdmdyUXJvMFZVMll6VnFBWUJnT1N5UExyNlV3?=
 =?utf-8?B?T2k0dkhqRkRRU1hiT04rNElsVGp4TUs3eXBTKzgzc3lOK3BOcjB3cjRIYlhx?=
 =?utf-8?B?MENjeXFYOTQza2pLR3haSzVsYWZTSkNOU2duUVVCSEJ6SGRSYmVFVFhjdk1n?=
 =?utf-8?B?NldKNDJYOHphTU9sMXZ1NGljYkJEMXl0YWxzdnlVNUhnVERROTNxRUVnT24v?=
 =?utf-8?B?UDlsWUs0dWw1Tk8rNGxYQVI2bWlNYzJ6QTFqQlVlRjM4bEp5dHorOEoxemZS?=
 =?utf-8?B?TWQzbGZMckJscGhkRjl2NjduMnlDRy94OFpoaksrdjQ2cGJwdTM3bzV1cTgr?=
 =?utf-8?B?YUFRVmxQTksyOFNndVBNc1l0QmNKeTlpOHhNOVlISHF4TVBDVWdVWTlOSjgv?=
 =?utf-8?B?cWI3MlRTQVZ0OFBsVFlhV2k0MzlZWlN4MC94N2kxRkpqOHR0VTFuRFJESzJB?=
 =?utf-8?B?NzJheXdTL2pMZEJlNkxJeXFKMkRXaktlem8vT01WVFFKZnRwMDZNbitXaXN1?=
 =?utf-8?B?VG1QTHdVRHRTa1JVdGx0NjlPbkxnUnhpblIzYXJ4bnpLVlBoL1Y4ak5yZVdR?=
 =?utf-8?B?TDBwMkYrczJTUU1CU1Y2RHphTzBtRXhnbytlbWtMNElvSk5oekM4RlFxcGFo?=
 =?utf-8?B?bCtWUVY5M3MwRFprczk4bS81YjdlVGhRZ1F5L0pnQUlFQ1dzQ3VyZVhhcDU1?=
 =?utf-8?B?K1VtcEhWQlFJZkFDWkw3bGFia2JvVnRlOHdWb250NCs5UW9nc2F0QmFpTHZu?=
 =?utf-8?B?Y3hheGM5TE9XN1YwcXBSenZhQktUQ3k2ZDkxcGEzN000SkM4UU5nOWcrUlJ1?=
 =?utf-8?B?TlBFYTBUSTFScG1LMmViTnh6MEtlQjZvRS9IKzRlaURGNTVZWW14dUEvdTFv?=
 =?utf-8?B?OW16UVdlWUNOalZkYU1wOTJBdE9ZTXNjZVBFVkl5bC9ST2hveklNa29wMzFL?=
 =?utf-8?B?R1V4UVI0R2lFRkFSVWpmWDVJMkVxRGdRajJ0R2plOTBycHRPS1NhTmNQU1NZ?=
 =?utf-8?B?YUlIZW01MEJ2TFUvQ3ZRK1ZtRGZ4SUdMNG9Nay8xTStTd2dHSTV5YzlFT2Rj?=
 =?utf-8?B?Ui96VlpsT0UycHdMaWYzbnZiTW9Lc0QwWTNTYkFnNmJJZ2YvdnJMNTFkSnRG?=
 =?utf-8?B?TGdyQ3FPRUczRW1BZHl3OHZBa2dxTUpOOXc5OWxDRTVFbmM5YWZBNnpzbDRW?=
 =?utf-8?B?QlZ3R2orblUzNXNnK0NqbXM3K1QvUGl6TEYwNjMybXR3TnlOaGloZU9zQlI3?=
 =?utf-8?B?em5aOEhNSjFXbk94cGtKOE9VTmJCYjJ6aTh5YXh2VGJUQzVvYldobDdQYUFj?=
 =?utf-8?B?ZG5Qc29lVi9RNzVoSnhuTXg4MytWR3k5MnUvOXBzaThDOFhrN1NNemRZUWcw?=
 =?utf-8?B?cVgzaERkS1NQRVZIWk1Qdmd5QmpqZDNONlB6TDBtU0lTNVBRcHJCaVQ3cjdQ?=
 =?utf-8?B?c1JkU3krcFEyQ0F2bVlseVZlS3Jmb09XbHhCS3VnaXRNRTNiZkRXRi80NHB2?=
 =?utf-8?B?eHpnamoyakI1VlpIdFVCYjBvQ055OGxuNEN4TUJJVHVhRG5NR0VoT0ZDUVlP?=
 =?utf-8?Q?8BYwRD0AzrhOJy2o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2DC274A73B53464DAAE74F27BE74C2F7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9305.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab380a1-be21-4b0c-7a07-08da486048eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:32:40.3173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxJBu9qgy4WP2T2vOdEamzR/11Amps1CSMFiu8Z1g8TLVqlITpxLOhlmz6zbVI19WhoOUdDEQxUTwNsyIdVIfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6130
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SGkgSnNvbiAmIFlhbmp1bg0KDQoNCkkga25vdyB0aGVyZSBhcmUgc3RpbGwgYSBmZXcgcmVncmVz
c2lvbnMgb24gUlhFLCBidXQgaSBkbyB3aXNoIHlvdSBjb3VsZCB0YWtlIHNvbWUgdGltZSB0byBy
ZXZpZXcgdGhlc2UgKnNpbXBsZSBhbmQgYnVnZml4KiBwYXRjaGVzDQpUaGV5IGFyZSBub3QgcmVs
YXRlZCB0byB0aGUgcmVncmVzc2lvbnMuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0KT24gMTYv
MDUvMjAyMiAwOTo1MywgTGkgWmhpamlhbiB3cm90ZToNCj4gU2luY2UgUlhFIGFsd2F5cyBwb3N0
cyBSRE1BX1dSSVRFIHN1Y2Nlc3NmdWxseSwgaXQncyBvYnNlcnZlZCB0aGF0DQo+IG5vIG1vcmUg
Y29tcGxldGlvbiBvY2N1cnMgYWZ0ZXIgYSBmZXcgaW5jb3JyZWN0IHBvc3RzLiBBY3R1YWxseSwg
aXQNCj4gd2lsbCBibG9jayB0aGUgcG9sbGluZy4gd2UgY2FuIGVhc2lseSByZXByb2R1Y2UgaXQg
YnkgdGhlIGJlbG93IHBhdHRlcm4uDQo+DQo+IGEuIHBvc3QgY29ycmVjdCBSRE1BX1dSSVRFDQo+
IGIuIHBvbGwgY29tcGxldGlvbiBldmVudA0KPiB3aGlsZSB0cnVlIHsNCj4gICAgYy4gcG9zdCBp
bmNvcnJlY3QgUkRNQV9XUklURSh3cm9uZyBya2V5IGZvciBleGFtcGxlKQ0KPiAgICBkLiBwb2xs
IGNvbXBsZXRpb24gZXZlbnQgPDw8PCBibG9jayBhZnRlciAyIGluY29ycmVjdCBSRE1BX1dSSVRF
IHBvc3RzDQo+IH0NCj4NCj4NCj4gTGkgWmhpamlhbiAoMik6DQo+ICAgIFJETUEvcnhlOiBVcGRh
dGUgd3FlX2luZGV4IGZvciBlYWNoIHdxZSBlcnJvciBjb21wbGV0aW9uDQo+ICAgIFJETUEvcnhl
OiBHZW5lcmF0ZSBlcnJvciBjb21wbGV0aW9uIGZvciBlcnJvciByZXF1ZXN0ZXIgUVAgc3RhdGUN
Cj4NCj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9yZXEuYyB8IDEyICsrKysrKysr
KysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo=
