Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D46575032
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiGNOAK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbiGNN6r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 09:58:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9032D114C
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 06:58:09 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EDBtOL013395;
        Thu, 14 Jul 2022 13:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=5nt+F9+kgbj1BLa6CBdusVKHZrAhOLmvhgo3rqur8TE=;
 b=BeuBGnNnO3vG3EALYK0PV/UrypDcTXaPj7vG5oPpmGUcSIGAzHzKdjVdTJysZ5Wy94Ok
 8T07mvhoA5aTV1xQut5e8oF1YYgDfQtH953JUqihXR70o1rZP6nEtjKIQDSseRBSDR3Y
 na9ih95o4aVY/EVOZdYGgOyq4ECEUoZB2IerQJ3+fJcaqNW9ZTD0W8iOX3qWke3MFIpj
 zZ9x+TKsE4e1cFpm2JRCdKlW1XErx5Sx6B3bFaH3HFZu2O++ZqEvOzf8ejgeEw8xNRk5
 22i3ynV7Dteehw6i4eDpw6SDHEvHCiuLb6GoNEFdxjQeMB2dsNSC4SiqGwAogWNX07DP hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hakdqssap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 13:58:05 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26EDDQ7D017224;
        Thu, 14 Jul 2022 13:58:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hakdqssa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 13:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C60oU04Olck+UH6f9tfq4m9Mo4UIMZh3p6Pcd/nTkSwNxsS+SkikAt30+DgnJ1KNYSFlFuJ74YQS8papgAmFYByfMfI158pT11I8UL+GPdy6X9dOxx9k18VyxK6kIAba1jNBI4c3CSikkfI4KT1lYhc6K0RtrOIykHo/fCLc0XE9PBYI9RTxulhwlI+GtluIiPTfWh4rhwVNMW2jZ8c3C9HTo3TwH2U0q4WXb+XyQPLiywL3gjzzgerKZwD8o7aid5X/ptBzy0XTjksh8RaFFiJgJdGc8LbH7byURnDCNfDMaWdLtsDUwVtFS1fuoMh4G6CAU90zrshq3SpRFm5Aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nt+F9+kgbj1BLa6CBdusVKHZrAhOLmvhgo3rqur8TE=;
 b=DO8kq5we22TV0TE2vOQkaKJkB8NZG8EGcWkBohsSaxdz5Yvzf4ckxj3UKqQglSS1lZxNXDn0PLudknzz5oe3E13nFtV/Tdz6vjN8SnNK577oiAB4LWdJC6wu+JqJREeeScqRYiIMbmzHEBRHgclL+5BF0mMDUIwuCFN6FdfquPqS4PYRqui+Bdh5c/3Lnk0fttKeGUV1mzKPT40dlZSZIceotOo74yqHFi/4PrnhRnm2kAHN35xga41ElCMiP2ce2NVPvfb1cdxzavOLbovt7L3h3PL3xIOOjfE8vJ3TEr/txtPP3OvVAPFRlFTZ+kHgx96J4W94oPx4AjlKK36ayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by CY4PR15MB1367.namprd15.prod.outlook.com (2603:10b6:903:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Thu, 14 Jul
 2022 13:58:03 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::8953:534b:e375:a945%6]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 13:58:03 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: Fix duplicated
 reported IW_CM_EVENT_CONNECT_REPLY event
Thread-Index: AdiXgYIQYSBV8VTKSG6mDviRFNpoKQAAusWAAAEoWbA=
Date:   Thu, 14 Jul 2022 13:58:03 +0000
Message-ID: <BYAPR15MB2631A9EEA0F43AFCE86B790F99889@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <BYAPR15MB2631D5F21C907B6145DABE4C99889@BYAPR15MB2631.namprd15.prod.outlook.com>
 <23ee6969-c32d-911a-2430-d9e3f6c52a61@linux.alibaba.com>
In-Reply-To: <23ee6969-c32d-911a-2430-d9e3f6c52a61@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cdb5ed84-18f2-4533-b8c4-08da65a0deb1
x-ms-traffictypediagnostic: CY4PR15MB1367:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpak/ogWd1Mwjx4BXx3D41SBiOFhp0KlM7o3m9xUsx62rOoKKF2uEA4w9y1sHtnBtXOsMvulRNMrAzpkK6E3hRY30f2ZD9a3kEZOb7SxOLwTqD1wHzeMapR8DTF97igQ3Hafw9CMakqakoV8FfA1lHwGNktRcvM7hlMNA4dFqbKZbsN4VQEh3ZKHuTT2mVrlUspcJitGSVkp0qXGTaQyskQREOzf9zKNYM5EBCCeLJ5ra/bZmrI9Kv7fDH45xmGJekNfgInKra29VPRXWo0oGVAzb8BV+jGzYMEkAnlH3nyfbE2OJiIJiRJ/tMf4+h1M1uuxS84jrihIBManJQ+QUIoqxNuHNCHBMZIiixeTCfAfwK2RA/vgswrX8ooXS8i76Ekqueg3yYsGqZIlPVS7deCyC8BebwEELhIOok84wlyhOlCV3zPoK83/mxy52Z0l5w4q7/AupuyqKIcZUNl5gy3/ux0Qc4sYVFFoLekPpXUxJ3o7Ng8khKn6WDHyum+jvxoAGDSLxkx0N6DEnAqCVF1Z8iMjqYz146joH6syeeR3S2170lNTuke+4yHo5Ix3CSZXBvpZxyTfjW3Nw08BV7buQE84AyNJAKtf/VSfLt+TJiLtd9y3pD4NNhpkau/q5dlbMFSYAWEaLE58dzhsrFEf7K4xKaZl2/dryiIYCaer/I0xGRw83J4tW4LKxKmeUhz63oJgjhGWn4uOgNVZMH80QpIW7mBDa+PNGoTDJzmeLXqGrq1vX2OXjK4pparok/T2KHJXbld0kkHRW/ixGzM/qm4rc6ajATqbimvDdIWoARBTpxpbA8D+Ppu/4njT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(136003)(376002)(66556008)(41300700001)(5660300002)(66446008)(8936002)(8676002)(64756008)(4326008)(66946007)(66476007)(122000001)(33656002)(2906002)(83380400001)(186003)(6506007)(478600001)(38070700005)(55016003)(7696005)(53546011)(316002)(110136005)(71200400001)(86362001)(76116006)(9686003)(38100700002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXI2eTlxbHBlcE1WMHVLREg4VW1LaW9UeFlZQ3lRQlR3dnI1MjZzWkZGLzlz?=
 =?utf-8?B?VWpBVFlTSmFpY2JSSVYzN1Z1QVJOaS9QVGZpWkQ4OWdyQk01bnhYc3NvZlBB?=
 =?utf-8?B?QVVrTG4xL0JPT1VrQnRwbHJUQS9HTk05cWRyeDZCNFRSUldwb2JQangyUkdO?=
 =?utf-8?B?N2hhZ2VNdHJGbWRTL01FNE1ZNytMTFd5bDRmZ1ljeDBWcUNzT0dpeldNYnQ4?=
 =?utf-8?B?RlJzOWc5WkUyQldvNFVrZlppbGFqQUxTaGlMUXJ0aWRZdTF6dEJaTDJPTGpS?=
 =?utf-8?B?aHV3aWpuLzY5TzgyVHNIK0tJNWJvVm82VzJwcUxybUljS3pHZzR1ejVVK2w3?=
 =?utf-8?B?RnJJVHUrSElDWVNqc2FxdGluY2JpSkJadlF3Z3NqQWFzZXJBSkttYWxsdVJH?=
 =?utf-8?B?eFNPbzA3cUowdWRhNGFMOXBEcHhyWXpRbktIWjRSbHVIenZMZit6OStrUTF3?=
 =?utf-8?B?YW12MFFIZVd6bitnaGlwY2lxZTM0eXIzZ2IvdFladjJza0wxNkxQOStqSllI?=
 =?utf-8?B?WkFRSFNIb2JqdndUWTBmaW5lMWRMV2c1djI2bzVETHJ5WVFETGI0cmZSL3Fp?=
 =?utf-8?B?R2RBcU93K2V5SHE3bkFvem1mNjFPOW5XWjZFSGFQSm42cE1uZWU0Y0F1NytJ?=
 =?utf-8?B?aTc2YTk4M3ZRTmtXdDc3TlVteVgrVEo1R2Fxc3VXcTdPelJ1S3pWZytzRk84?=
 =?utf-8?B?QUNlZzl3OC9GU25lZFNwL0tmQWlldTFWMk8yOHhHemZ3L2JIekwwdjFGQ25Q?=
 =?utf-8?B?TW1xODNTZ0RoVzdka2pRZzZRelhIUnVYWlYzL0pZOEk2R3o3MmI4VUt3dTU3?=
 =?utf-8?B?eXlmUWZNVmVHRVNVM01NczRMTC9qOEYvcUtzYng2TzhUbjk2ZTM1bytRb1da?=
 =?utf-8?B?bzg0STYvQURRRDdQRkF4bFdhcXEyWUpaNk9aVmp1bWJPRVFTcjlRRGQxUU5r?=
 =?utf-8?B?VXRZVDJJdHpRVHhoS1pCczYrQnBEYVpiZlNERUE4N291dUFMckM4SFUveHRq?=
 =?utf-8?B?dVovZUY0bG1JeFpJaitqM2NMdmtOeHdkaUR4dDYzdEZod3VXQ2pJL2RyaHFq?=
 =?utf-8?B?UmhRUFZSOWdidUpVNFBPa3oyVEJCeXB3cm42VFhNM2dKYlRnaTZjRmZGOUNZ?=
 =?utf-8?B?ZFJlSTlDNE5VT3F5V3JsSFIraFNvRkZPOFA1b2Vsa3NvK2RjeThqMWozU1I5?=
 =?utf-8?B?dTFlalJQYmplR2J0SkYvdHFNREM5eWVyVkdaMzAxVVowTUFrTmhucmpUTk53?=
 =?utf-8?B?UDhESjA4eTRIZlN6SzdwSkhLdi9VaEdNRXFBUlVJdWVCa09lMEZBWkI0eEtC?=
 =?utf-8?B?VDJrcjMyd1BDUkJhQmdLMzRCV3BQZ2hOR2tiUUV2WkxHM1RtdjIzSkpDVEFl?=
 =?utf-8?B?bTYvQ1dRV01RMGNjSFROMFozS1BwWnpKakxYdnQ2QmJuSHkzY2RxcW9xWExJ?=
 =?utf-8?B?eVBxYm9PLzFUam11bVQxUS9IMjdOR2dxcEM3OEMvT05HYjJNT3hpQXFOeHUy?=
 =?utf-8?B?bkE2b2Y4TXhTNEdDN0RSSnpKSjJNMTBGT1FMVzlVeE54YkV5bDYxcnl5ZFln?=
 =?utf-8?B?cjFzV09mL2YreVRBYXU1dytMWHovMkM5V0N5RjN6emVCMUtIbnRQV0tabmRv?=
 =?utf-8?B?Ym1hdnhJZjM2ekVaYTRVTTlBbWdhai85b1hOMmV3MTBTRm1Zd1l4YXNVampI?=
 =?utf-8?B?UlFrSmxabmQ3UXFnZTlkc0l3cStSc1FwSCtzUWpRMmNzamVIcmZaclRibjhs?=
 =?utf-8?B?KzllUlhPK05FR24zeXF4S3JNY1MyNlBLQlpNcEQvOG0rK3pYRmVrdW9NUVkx?=
 =?utf-8?B?SlY5bnpBU0o5SkcxUlJsRm5GeG1NYm1vd0t0TDNvQlVKS0UrZXlEdjZBOWZo?=
 =?utf-8?B?b3BYK0ZJdVk1K0Zadm1EOVE5Und3YjliSFJvWWd6c3pJR1hYRzVLU1pPeUtn?=
 =?utf-8?B?YkhQRUE0K1pkZzhWUnMzeGFXUHJFQ0RITkE4MU53RFBvd1c2MzA2TTBKSzJE?=
 =?utf-8?B?d2NwQm9pZ3lFdUNkelBFMThibGx1a3hDMmJIRW1qSFJoZ2RoeFl1VENnb2hQ?=
 =?utf-8?B?c3dXaXE0ZU5KUUxMbVNjTTVsVVNUeXBEYUtRaitwTW1LeEZqTExTR1kzUmRw?=
 =?utf-8?B?eW5HUlg1U1VrTFZodjZ0MFdHM1d0WjdpUDh0ZyszVENjWmNZb3BaSHlhWnlj?=
 =?utf-8?Q?G5JThx51z1W2kMWnv1CJx/i5Svndm9x5/j9nueml6bJl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb5ed84-18f2-4533-b8c4-08da65a0deb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 13:58:03.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAqk4i1UUIrDm0eEVG2MdprYCe9IQaGdZYnc1u0zctnaLx6xaGhjKN2vglTiN9RLYutBbVl/Vx/mdmg2bT3exw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1367
X-Proofpoint-GUID: 4QP0atVmiGdHyhs63uHeoh0Q5QS-fXpN
X-Proofpoint-ORIG-GUID: 5KZNrwI3LypVpqJfbZYHjbjdWmkPo0JW
Subject: RE: [PATCH for-next] RDMA/siw: Fix duplicated reported
 IW_CM_EVENT_CONNECT_REPLY event
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_10,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVuZyBYdSA8Y2hlbmd5b3VA
bGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCAxNCBKdWx5IDIwMjIgMTU6MjAN
Cj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdnQHppZXBlLmNh
OyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBmb3ItbmV4dF0gUkRNQS9zaXc6IEZpeCBkdXBs
aWNhdGVkIHJlcG9ydGVkDQo+IElXX0NNX0VWRU5UX0NPTk5FQ1RfUkVQTFkgZXZlbnQNCj4gDQo+
IA0KPiANCj4gT24gNy8xNC8yMiA4OjU5IFBNLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENoZW5nIFh1IDxjaGVuZ3lv
dUBsaW51eC5hbGliYWJhLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIDE0IEp1bHkgMjAyMiAw
MzozMQ0KPiA+PiBUbzogamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IEJlcm5hcmQgTWV0
emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiA+PiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5l
bC5vcmc7IGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tDQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5B
TF0gW1BBVENIIGZvci1uZXh0XSBSRE1BL3NpdzogRml4IGR1cGxpY2F0ZWQgcmVwb3J0ZWQNCj4g
Pj4gSVdfQ01fRVZFTlRfQ09OTkVDVF9SRVBMWSBldmVudA0KPiA+Pg0KPiA+PiBJZiBzaXdfcmVj
dl9tcGFfcnIgcmV0dXJucyAtRUFHQUlOLCBpdCBtZWFucyB0aGF0IHRoZSBNUEEgcmVwbHkgaGFz
bid0DQo+ID4+IGJlZW4gcmVjZWl2ZWQgY29tcGxldGVseSwgYW5kIHNob3VsZCBub3QgcmVwb3J0
DQo+IElXX0NNX0VWRU5UX0NPTk5FQ1RfUkVQTFkNCj4gPj4gaW4gdGhpcyBjYXNlLiBUaGlzIG1h
eSB0cmlnZ2VyIGEgY2FsbCB0cmFjZSBpbiBpd19jbS4gQSBzaW1wbGUgd2F5IHRvDQo+ID4+IHRy
aWdnZXIgdGhpczoNCj4gPg0KPiA+IEdyZWF0LCB0aGFua3MhIEkgb2J2aW91c2x5IGRpZCBuZXZl
ciBoaXQgYW4gaW5jb21wbGV0ZQ0KPiA+IE1QQSBoZHIuIFBsZWFzZSBtYWtlIGFub3RoZXIgY2hh
bmdlIHRvIGZpeCBpdCBjb3JyZWN0bHksDQo+ID4gYXMgc3VnZ2VzdGVkIGJlbG93Lg0KPiA+DQo+
ID4NCj4gPiBjYXNlIG9mIGFuIGluY29tcGxldGUNCj4gPj4gIHNlcnZlcjogaWJfc2VuZF9sYXQN
Cj4gPj4gIGNsaWVudDogaWJfc2VuZF9sYXQgLVIgPHNlcnZlcl9pcD4NCj4gPj4NCj4gPj4gVGhl
IGNhbGwgdHJhY2UgbG9va3MgbGlrZSB0aGlzOg0KPiA+Pg0KPiA+PiAga2VybmVsIEJVRyBhdCBk
cml2ZXJzL2luZmluaWJhbmQvY29yZS9pd2NtLmM6ODk0IQ0KPiA+PiAgaW52YWxpZCBvcGNvZGU6
IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQ0KPiA+PiAgPC4uLj4NCj4gPj4gIFdvcmtxdWV1
ZTogaXdfY21fd3EgY21fd29ya19oYW5kbGVyIFtpd19jbV0NCj4gPj4gIENhbGwgVHJhY2U6DQo+
ID4+ICAgPFRBU0s+DQo+ID4+ICAgY21fd29ya19oYW5kbGVyKzB4MWRkLzB4MzcwIFtpd19jbV0N
Cj4gPj4gICBwcm9jZXNzX29uZV93b3JrKzB4MWUyLzB4M2IwDQo+ID4+ICAgd29ya2VyX3RocmVh
ZCsweDQ5LzB4MmUwDQo+ID4+ICAgPyByZXNjdWVyX3RocmVhZCsweDM3MC8weDM3MA0KPiA+PiAg
IGt0aHJlYWQrMHhlNS8weDExMA0KPiA+PiAgID8ga3RocmVhZF9jb21wbGV0ZV9hbmRfZXhpdCsw
eDIwLzB4MjANCj4gPj4gICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KPiA+PiAgIDwvVEFTSz4N
Cj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2hlbmcgWHUgPGNoZW5neW91QGxpbnV4LmFsaWJh
YmEuY29tPg0KPiA+PiAtLS0NCj4gPj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2Nt
LmMgfCA3ICsrKystLS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd19jbS5jDQo+ID4+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
Yw0KPiA+PiBpbmRleCAxN2YzNGQ1ODRjZDkuLmY4OGQyOTcxYzJjNiAxMDA2NDQNCj4gPj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiA+PiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+ID4+IEBAIC03MjUsMTEgKzcyNSwxMSBAQCBz
dGF0aWMgaW50IHNpd19wcm9jX21wYXJlcGx5KHN0cnVjdCBzaXdfY2VwICpjZXApDQo+ID4+ICAJ
ZW51bSBtcGFfdjJfY3RybCBtcGFfcDJwX21vZGUgPSBNUEFfVjJfUkRNQV9OT19SVFI7DQo+ID4+
DQo+ID4+ICAJcnYgPSBzaXdfcmVjdl9tcGFfcnIoY2VwKTsNCj4gPj4gLQlpZiAocnYgIT0gLUVB
R0FJTikNCj4gPj4gLQkJc2l3X2NhbmNlbF9tcGF0aW1lcihjZXApOw0KPiA+PiAgCWlmIChydikN
Cj4gPj4gIAkJZ290byBvdXRfZXJyOw0KPiA+Pg0KPiA+PiArCXNpd19jYW5jZWxfbXBhdGltZXIo
Y2VwKTsNCj4gPj4gKw0KPiA+DQo+ID4gQ2FuY2VsIHRoZSBNUEEgdGltZXIgb25seSBpZiB3ZSBo
YXZlIGENCj4gPiByZWFsIGVycm9yLiAtRUFHQUlOIHRyYW5zbGF0ZXMgdG8ganVzdA0KPiA+IGZ1
cnRoZXIgd2FpdGluZy4gU28gYmVzdCB0byBhZGQgdGhlIHRpbWVyDQo+ID4gY2FuY2VsbGF0aW9u
IHRvIHRoZSBlcnJvciBiYWlsb3V0IHNlY3Rpb24uDQo+ID4NCj4gPj4gIAlyZXAgPSAmY2VwLT5t
cGEuaGRyOw0KPiA+Pg0KPiA+PiAgCWlmIChfX21wYV9ycl9yZXZpc2lvbihyZXAtPnBhcmFtcy5i
aXRzKSA+IE1QQV9SRVZJU0lPTl8yKSB7DQo+ID4+IEBAIC04OTUsNyArODk1LDggQEAgc3RhdGlj
IGludCBzaXdfcHJvY19tcGFyZXBseShzdHJ1Y3Qgc2l3X2NlcCAqY2VwKQ0KPiA+PiAgCX0NCj4g
Pj4NCj4gPj4gIG91dF9lcnI6DQo+ID4+IC0Jc2l3X2NtX3VwY2FsbChjZXAsIElXX0NNX0VWRU5U
X0NPTk5FQ1RfUkVQTFksIC1FSU5WQUwpOw0KPiA+PiArCWlmIChydiAhPSAtRUFHQUlOKQ0KPiA+
IHsNCj4gPiBjYW5jZWwgTVBBIHRpbWVyIGhlcmUuDQo+IA0KPiBJbmRlZWQgd2UgZG8gbm90IG5l
ZWQgaXQgaGVyZSwgYmVjYXVzZSB3aGVuIHNpd19wcm9jX21wYXJlcGx5IHJldHVybnMgZXJyb3IN
Cj4gYnV0IG5vdCAtRUFHQUlOLCB0aGUgcmVsZWFzZV9jZXAgd2lsbCBiZSBzZXQgaW4gdGhlIGNh
bGxlcg0KPiAoc2l3X2NtX3dvcmtfaGFuZGxlciksDQo+IGFuZCBzaXdfY2FuY2VsX21wYXRpbWVy
IHdpbGwgYmUgY2FsbGVkIGluIHRoZSBlcnJvciBoYW5kbGUgZmxvdy4NCj4gDQo+IEkgdGhpbmsg
dGhpcyBpcyBiZXR0ZXIsIGJlY2F1c2UgdGhlIGVycm9yIGhhbmRsZSBpcyBtb3JlIHVuaWZpZWQu
DQoNClllcywgc29ycnksIHlvdXIgb3JpZ2luYWwgcGF0Y2ggaXMgY29ycmVjdC4NCg0KPiANCj4g
SG93IGRvIHlvdSB0aGluaz8NCj4gDQo+IFRoYW5rcywNCj4gQ2hlbmcgWHUNCj4gDQo+IA0KPiA+
IAkJc2l3X2NhbmNlbF9tcGF0aW1lcihjZXApOw0KPiA+PiArCQlzaXdfY21fdXBjYWxsKGNlcCwg
SVdfQ01fRVZFTlRfQ09OTkVDVF9SRVBMWSwgLUVJTlZBTCk7DQo+ID4gfQ0KPiA+Pg0KPiA+PiAg
CXJldHVybiBydjsNCj4gPj4gIH0NCj4gPj4gLS0NCj4gPj4gMi4zNy4wDQo+ID4NCg0KVGhhbmsg
eW91IQ0KDQoNCkFja2VkLWJ5OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4N
Cg==
