Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03935FC931
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Oct 2022 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJLQ0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Oct 2022 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJLQ0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Oct 2022 12:26:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C8C3134B
        for <linux-rdma@vger.kernel.org>; Wed, 12 Oct 2022 09:26:44 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CG8FOk014626;
        Wed, 12 Oct 2022 16:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XFS4NfPt4NVMJC5ffjq25PjLXQOfh2fq82NYFD6CCTM=;
 b=2npvi0ylGXtq+2KjcRyD+liJvDCWTs2VA87GcsGgQQxiEks6RssDOhXGn4XRVcyRq8+N
 P36aFsU+XG5U+NK4Vx7UXH2jFmKSYVtRrAR9hkC24rJ6eLdauCSNZ85CvzCF7SkoWm6X
 0/q4STcSMKZrk6iMWG1cZvSB7ktTGqS/oIgZOmkljdgtveLg5nhWuB5l1QUsZg7xkl9P
 OTnhQCBAgMTckgviDmdRKHKA+GoWHI1zoptqc7L0WmcoDwe7gFlfxq4Ier/EuF4JKYtX
 58Rrq2h1Ifh+VQlou/snzop2cBQt5/4/PkyrcVZNX+/s+v0Q+edZOt1/Sjb4mmhLXs2H Kg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k313a2e38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 16:26:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CFQP82027421;
        Wed, 12 Oct 2022 16:26:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynbcj0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 16:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF1P2k6Mfx2dNDBmZUXarlDyHtzJQAbkS9A++xCq8f2Myh2StCGFVRTxw+KLwJwK2Apb1WurAic9gT5xWfXwapbAEB26SLkhU+OFrqxk/+LCUOddqv+DwlpP5FZ0Ateqoz6vANnmtZ4If/YRteqcFnDIfloUR9k7+1ZUsrQi4LPKVHB9x3At45YSC1OsXY+E/+OW44mQaM3g6/iJm93QpKGCcSQzDB/rnBHyuqFAxpLDjtIsHsdl0lw6PaF/6VCOJ4f91XDwVSb1Gue09Ovr3ICqxKGvmxHRg/olYnX2y06j290DSdqPAQJLqPw5tcW6GyLsfyPnue6dCY16AOwbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFS4NfPt4NVMJC5ffjq25PjLXQOfh2fq82NYFD6CCTM=;
 b=XNne+UK5sFpqhT9eoSsXpDGrhKCeXvZJSveRQxYRbl1w+uW+xcioktRA+/S79jwe7yF1AJDBtDLEMXInGy5t4KJcBBgIplQHuY9Cec2OyOgscl2J6OvpR450SoUbzBjinIU2Qy1zVia9qNE31nejW8O0xb4p+h8/aOVV0LuaZk9fPRGJV4wRaUM6emmswxT2fUJepYE9st5v9lAgn1FvAKMRugnAuLJcsZ6fmWYODR6YLuQ2CjnO0wh1CKZ9JU4rJnbFJkgLIakzknp+kWUCjTwDjILZwlXEJdh0muQMBP9mc6yGEY8BI9zgWGLc4IP14FxgDcrmEE3/1chdBXzQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFS4NfPt4NVMJC5ffjq25PjLXQOfh2fq82NYFD6CCTM=;
 b=DSCg3U5M0qnZuo3PIoD7TUdqSf1fn85KR9WxXYaaw8nzIf22tYRpis7nBsX5iHr7Zh2MTZP5ElluE6/Z6zdMoszS+ZNI+SkodEacD9qJvd1VeEc4Ch9tcQG/JYhuMEIRepWVAlHAvUQrp5f4ypx71JxPinKnXE+zXKJpmhiFgvE=
Received: from PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16)
 by DS7PR10MB5088.namprd10.prod.outlook.com (2603:10b6:5:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 16:26:38 +0000
Received: from PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa]) by PH0PR10MB5593.namprd10.prod.outlook.com
 ([fe80::40b7:1489:ba7e:9cfa%4]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 16:26:38 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: RDMA/rxe: Receive wqe flush error completions on qp error
Thread-Topic: RDMA/rxe: Receive wqe flush error completions on qp error
Thread-Index: AQHY3lY4ONuI9SFojUqrYKnMauXUDK4K8h8A
Date:   Wed, 12 Oct 2022 16:26:38 +0000
Message-ID: <BAF00661-DBC5-4B74-9BA7-FC17BBDEDC59@oracle.com>
References: <3867f7a8-80ab-f3ee-e631-63756fefb82e@gmail.com>
In-Reply-To: <3867f7a8-80ab-f3ee-e631-63756fefb82e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_|DS7PR10MB5088:EE_
x-ms-office365-filtering-correlation-id: bd20f2e2-ef06-4094-8dce-08daac6e899e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDvocSgYRnvxZXv8EaXWFmeoXvwuG4eexx123VWRHhmS9y4HUh7C81FYGX3+Ip3tr6zZC1bHQewdWrkgqa1It27uOrJmGDTjWe5Nk31CAt+ALvgJaKDepCypoBFQcZnuH1I9cH0A9aFIJEXWRbr7c53A7Le74VBME9bnnEZJWM8YcJLdJbVOG9MtJ2stM4Qp6nERhLONdvbkV0WXJlquzCj+FCVI+jGxaiYqeS6buZM5rSAcVCAPlBseQ4MSf9UtiL69H3zbHMZ44yFNKTYQuUiy3Shtw2qLq8GRqGgB9822iXuZrxozfhkO8pP60NuJRQh8asTKXynEdcZE4+orrbSr+gy0k7yfpalZuc7ki0K5BelDipDROyqPnRttyGux0o3/jZT9dcbTp4foELQRS5Rfj8bYDvn/ZUrVu0yDQeZh2xZNIHyXNCeNxIkXrX2oDmaRDMUCbOd5RA8VC/xJWwTk6pZLfOhAfAmSw1Qr9s20EW3Ii0diWISxCAcnHmp9F656JqFqMpzEy5ulafVBVvK+osTr6ITaWnYpvBiNdEzjqB1CSewDWdy+bnOpQN4q5ynzuPdN1zqbHLBpw9ElJqgaYT0vIEpBLsz+rNSwAFKgwRZxPj+Q1I8NSaEjgoL99Mjk1uln9gt7kQKQsgZGFLbjDxgt2Dpe0/TnXqMHQNVaTamdwrtKYpJF1yrouSZlafMqGOQsmOAlbEPx7dCKf9tGstilPaB7TzrlYv9VIYTTVcD95v5oSRrQ39z+STBu8N0hBNwqYsuJi/YJna/aKl1uADhgR/4zOS87eub47Yc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5593.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(36756003)(33656002)(38070700005)(44832011)(5660300002)(4744005)(2906002)(186003)(2616005)(86362001)(122000001)(38100700002)(8676002)(4326008)(6486002)(6512007)(26005)(6506007)(53546011)(6916009)(54906003)(316002)(91956017)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(71200400001)(41300700001)(8936002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZkemRRV001bW5Pd3duQzZiQXYwVGhFcEJuWFYvdGdzYm0xbmhndFJXb0lY?=
 =?utf-8?B?dWRuSHVQSmVxUFFTNEQrbTJEeHhPRDEvY0ZlYzdOck1WdGNzaE5ra0ZHeDFv?=
 =?utf-8?B?UU5FdUI2dFh0dThPRFRJYXp3VmVjQ3RFMnU1Qm5pUWVWa2V0ejNEMTI3S0x1?=
 =?utf-8?B?Wkt0TnBFN1VRYXRqVXI1NGlaWFJ0eG1LVmZpR3I0bFJlaGlLUGFJOFhpWDVl?=
 =?utf-8?B?b0c0MUYvR3lFdWdqUlVmTmFuWWNLN0dpSnZNc2t6M0lSN1dGV00raDcyZEpE?=
 =?utf-8?B?THllTHpaYmtid1VPNmJKbEMrMjdyMnZlKzVqZkFIckp0MzdiMWdSNUJRV2N6?=
 =?utf-8?B?TE9oZ00waXlVQmVKcWJlZjFTa0d4c2hTNFVOSERsb2x6WEc4MHYvQlhLR0Rq?=
 =?utf-8?B?UTFmVGpjbGErT2F5dk9sYVlRVmp1M2pna1pkSVhWdGc1VHNtVGh4QTRIQmFk?=
 =?utf-8?B?TEtZM0dwdnhCRStGYUVkaTBObmhma3RLcTJzOFplRzRDL3ZWSFhZQkEwSnRL?=
 =?utf-8?B?eVEzSmNUNm1vaTdhY1J3ZnJIT3Zwc1hVdE4xaUFjS2JhWmRXcWFqOUNrbU43?=
 =?utf-8?B?K3FyM1dZVVZxeEthY0FZOExsVE1kOUpXejFpbnpWTXdyRHBOejFPYTdTZ3BE?=
 =?utf-8?B?N0hkR2NSVllwK0cvMGlUa2FjRlZwMjVxZEF5Q3Z0cWY4K1NwWExqUkRyMnAr?=
 =?utf-8?B?YVVWbjNZNSs2enROK0ZKcmtwUS8wTkh0eDIrb3M3aC9iNE9BUllsVkJlVXpR?=
 =?utf-8?B?eEk3dlhNZ2NIeFFHeFNxWjkxLzdOak1id0p5ekdBaUFQWm12ZmlZY1YrVDJs?=
 =?utf-8?B?QU1tQitwTjJkZFpjUk9jWm1LVHJXN0tITEhvT1JVYk8vR1FtV0daeXVjUEpQ?=
 =?utf-8?B?d2V5NVVib3ZGQUtMaVN4emR0dW5nNU92cUdIWXlTM1lxK1VQMVQ3QUJEaXVZ?=
 =?utf-8?B?Y0s0NUN0T0ZvK0lYeUZDTFZjMnVmT1FIbFIxRmdYNmdpMjNNTmVDYVhrSHgx?=
 =?utf-8?B?R0srdGVUVFpDTU4remZ6K2FNZXI2SjVQZnhnUjV2UGxmaDV1YXBKYVRBQmg0?=
 =?utf-8?B?S0wzdU54aHJSTnA4VWpac3pPUjhPWWtheSsyUHpPQWoyT3k3VDFqUjhEUG9k?=
 =?utf-8?B?cGtqYXNBUzVESTRjczJOZUtJdDduT2VoVkdXRHdEMHlZbEZKVjNNd1JBQjF4?=
 =?utf-8?B?WUpkcVFaOHJXWFNWaXhrSm9yOEtQeXBOcU02OEsyN1hkTTFrTkhuS3dsUm5I?=
 =?utf-8?B?bGt5am9qOVNiWFhYdW5Kbk5pcFBHRHBTKzNuMmlUcXNVbkcyTG00UnRjdWNU?=
 =?utf-8?B?dmlKSnpwV1AwVmRkdHNCb3pmcG9VaDZSeXFOc0NjeHhpM1E5a1ZMcHJ4UGZx?=
 =?utf-8?B?U2owOWtqVEZqUGRodU93Ky9IZWloRS85ZnMreGVzRmlNV1BWdWNMSFlKZnQy?=
 =?utf-8?B?WjA3REZFVVI3anV4TG1FVloya0h5bXZOZWVSUWNDUTdLckxaNFhhSVlKajBj?=
 =?utf-8?B?RDVSZ2FKc1NSbk5NaXBHZTJXU0hDNmd4SjRXb2t6NURPMzNmSjBHQTFGZTk0?=
 =?utf-8?B?NmErbmJoZURuRDNseDZvWFZ1Y1ZURVZnZDlkWjlubFNzeEVBNEkweURUdnZr?=
 =?utf-8?B?bUZNUU1HTkhNVFlwcUc1RE0wQTE3SU9FT1pMaTFYOW9jazdxVVo3MGFCM0p1?=
 =?utf-8?B?WlBjdVVFQ1o3UWJkaEpUV203K2Q3TEppaDFOMHBYQ0JaWmFoM3pOVDNweXZM?=
 =?utf-8?B?dlBFVUZtTFBpeW52SWZWVkdncUIzd0ZIWjdSMVFKSFdtaGNyUWM2S21VbjVH?=
 =?utf-8?B?dEJkVnBNZVltV2Y4eVJEL3J6T2RNSXVnL2c4V1c4S2ZENmhhQ3lvZXJjLzFn?=
 =?utf-8?B?OUZTeko2QnJJTjJqTjBUV05tSC94R0VWLzVWSDVQaHRpTVFObXpYL2Y1dzlT?=
 =?utf-8?B?NE43TERGd0pvSmMvYnc1WnNCRTZTWXc4azBoaG5NMnN1TzdKbjhlcTgvRFcz?=
 =?utf-8?B?czZGdmZkSDVyN1RjL0JyNFF4eDkxVjFoVnd4Z2VKaFpraUVWNXN5SkZpUDhF?=
 =?utf-8?B?VnZHK0N2cWhkRWxDZUhDU2MzM2RLSEU2emYxaU1Gb2tNY1VhNDlwYUZkQjhI?=
 =?utf-8?B?TVBGUW82U2FMYzJ6d3lIN2s2eDM3ZGJDeVFEMlhIaHdPUVBMcjZnZGVqSkhS?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B711DD8145184B9D390D33463E5B49@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5593.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd20f2e2-ef06-4094-8dce-08daac6e899e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 16:26:38.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH9XE6GmJrE5h10eMsTSL9Fwsmi+XO6TE6sJnYzJ4GudQPTYJGpa+9cENFbVu5lKcDaP7bS4jUcgYxsJ63cDtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=867 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120107
X-Proofpoint-GUID: iJE_zxnCO1GYNEv2CTHsaWV0A-OijWUu
X-Proofpoint-ORIG-GUID: iJE_zxnCO1GYNEv2CTHsaWV0A-OijWUu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTIgT2N0IDIwMjIsIGF0IDE4OjE3LCBCb2IgUGVhcnNvbiA8cnBlYXJzb25ocGVA
Z21haWwuY29tPiB3cm90ZToNCj4gDQo+IEN1cnJlbnRseSB0aGUgcnhlIGRyaXZlciBmbHVzaGVz
IHRoZSBzZW5kIHF1ZXVlIG9uIGEgdHJhbnNpdGlvbiBvZiB0aGUgcXAgdG8gdGhlIGVycm9yIHN0
YXRlIGFuZCBjb21wbGV0ZXMgdGhlc2Ugd3FlcyB3aXRoIGZsdXNoIGVycm9ycyBidXQgZG9lcyBu
b3QgZG8gdGhpcyBmb3IgdGhlIHJlY2VpdmUgcXVldWUuIFRoZSBJQkEgc3BlYyByZXF1aXJlcyB0
aGF0IHRoaXMgaGFwcGVucy4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHRoaXMgd2Fzbid0IGRvbmUg
b3IgZG9lcyBpdCBqdXN0IG5vdCBjb21lIHVwIGluIHByYWN0aWNlPw0KDQpJdCBkb2VzIG9mIGNv
dXJzZSBoYXBwZW4gaW4gcHJhY3Rpc2UgdXNpbmcgSFcgSENBcy4gVGhlIFVMUCBvciB1c2VyLXNw
YWNlIHByb2Nlc3MgbmVlZCB0byBmcmVlIHRoZSByZXNvdXJjZXMgdXNlZCBieSB0aGUgcmVjdiBX
UnMuIEFuZCBpdCBkb2VzIHNvIGJ5IHJlY2VpdmluZyB0aGUgd29yay1jb21wbGV0aW9ucyAod2hp
Y2ggaW4gdGhpcyBjYXNlIGlzIEZMVVNIRURfSU5fRVJST1IpLg0KDQoNClRoeHMsIEjDpWtvbg0K
DQo=
