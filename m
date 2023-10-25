Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F337D6C17
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 14:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjJYMjG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbjJYMjF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 08:39:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BD890
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 05:39:04 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCJD6c010390;
        Wed, 25 Oct 2023 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Kp/W66hFWtynRlQ1U4sd2ErhUll7KXslzzzbAUq1a+0=;
 b=HMEvGACLowGag+2NeKXN0JqYAqSg5bbwPx00Yr4c8BXS9dXGe1peygep8TWkoNp9nF4Z
 GClrWHBUS9th+pyVO/puRFv2SH7DSWQ7m9khSOlXUxET+kCJS9gnTGkGaXhRs2mS877d
 D5ItuWkRtAl1SpLQJURr5X48tFXCG/iEsCW1Yl8ZJv4Ks4hnOxmpaAv+kuy9ZyxOLSk3
 WekR/mvGaAJY3lHfNf4PFgQwA5HjyhtshKxkkZpjuEV/PD8CJI6FLESTN6aKitQVYhpL
 V8PIPx+JX4o5du6BgEZD3YO7jnW8FouIqZO9x5nmvnbCWhNxtdhJXSH9gv3PhvDjIlJX 1g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty2wv8wc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 12:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpIeybTaisTNud6yFegro6bM+oCVPNX+FQCRmOlm+fcQ4P7FZKIE2kmYueNjf6catMAvgyKuZFs8dmI7mqwk4RBwdPERksjLwIf9ooJfi13RpscgyzT6gleo1PSnCHEsIBCqr4EVSComJyoWldrrlm0AqC61fWyxzMTioVcYiuCHfpkxcadGkAG88KWe0ahbMeVFyslRwzQthCYFjUn2NzsyKBjQu0LNHjPDOfwrI7e1YVEP01bL4Q+hE7yXwA2aiow56gdjSo6WWT+ylbVmqNSw5f+0yVD623q2K4PFDZ6Ak3TK4lkuLq3WsxI16OGLPBw9AqR+tbZSeM0AySpahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp/W66hFWtynRlQ1U4sd2ErhUll7KXslzzzbAUq1a+0=;
 b=VWxtpilEWPoFFinmZKT1EOgbnrkrcQUGUF1iIp1FHovqTPf5Q6MOleUw0Y91RmxI8pWRaqtefZiq0yXEBVzi6wVfIgje+zfovyKhcxvYoFZ2lQvV2r4ZSIFP5GaKyuiOVW34GsydevDLF/12Bd3GwcIstWd2PdzeK4OAKD2/+Yw0NYODtGi+wsPPN3waHayj/CQaxxgYijC4vFOluIdPUW1pwf8VTjgOuDmzhUvtmie+XI6kNzKscNyVAr9prZcIEuBeley8m/9UtH+eB2uhEo2JS/V8LveekvLswtcFgHe5fOFkOYJgmSTqkrNUpTDoby2CgBHnSddkCpDKEMJEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 12:38:50 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 12:38:50 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 04/19] RDMA/siw: Remove goto lable in siw_mmap
Thread-Topic: [PATCH 04/19] RDMA/siw: Remove goto lable in siw_mmap
Thread-Index: AQHaB0A0MpjdNyGQEE+OlLfHevMQzw==
Date:   Wed, 25 Oct 2023 12:38:50 +0000
Message-ID: <SN7PR15MB575501E02141D857B6A9E48699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-5-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-5-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|MW3PR15MB4009:EE_
x-ms-office365-filtering-correlation-id: 37a955f0-2beb-4481-f029-08dbd5575764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjDOaKtnchyUV0yji3az69ipJd+kOnLaHG29mQoQiRrV/L5VqvQVBgm9J6iolInnve71hFbzDOQD6OHp5vRJjryVJlpzEvnXwhcG5ax0zIKACtkhTaZQgc346OcO3c0FS+3L9AeBJNtqUN1/wnnN4F00Tm1Qrq9gppat6MZMtr28QI+TTrQ/+9IfxBY2mHhYwI1QQKvMcCf5V3IqOaxf36STs5qwV8Ss+Gf34EyZGfGLD+VegWJi9mmHga8ASWavF+jPRo1zXRcwLiWV98Vfvxo+qW5xwiLB+tiNljSZ2WdP1o9CaFvOeRFQTmYiqVq3b1UacV3UXmrfVkMkPdlcFvbTIUaJVElJq1FcqAar7/oCN9Mto+Ne9xo3B4nCwtYfPBplxwWvxolKTxwqbHjAtc5SWDIIqA4JY/3Tq0cmTQEDn2kloo0PV62I6b2PtkQCvPR5QHOK7NQl3MtDnD08WZ3+aD4SV/8DpgyWmAsXOD52XyGblnfMVvpwUCQLol2kj8IxpLY313AF66+9ho+n8p9TpSjee1J+yf1FdzUQRrDOFLl4eO+d4ETH3nY6u5IsyTRvBkHDOHvk4uI0/Lu/hSXgItaWxBnYnaqXy6nC6+m4AYJbkKIbc4YLEZgptY7s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(9686003)(83380400001)(7696005)(53546011)(71200400001)(38100700002)(6506007)(2906002)(316002)(110136005)(41300700001)(4326008)(66946007)(478600001)(52536014)(8936002)(8676002)(76116006)(66556008)(66446008)(5660300002)(66476007)(64756008)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVlUSHBJaDJ2MDNJeTVVWEtHQ3hhclpjNE01amlYSWtDdTNRMWFvQlpaZmtS?=
 =?utf-8?B?VnB5UTZHcFNwZDRwTjNmUTArZHFvbVM4WEdFY055ZE1Pa08zb2diVjB4V1J4?=
 =?utf-8?B?eDVldzdMYUx6ZnlNRVVTMS9DT2JxbkV1OVFZRWVVZDdiQWFRdnpKRTZsRGlk?=
 =?utf-8?B?eFhwS0diWUU2dTVRS2RvU3hmbUFpYVJFOFFNZWZFSm1HTHR3RmZXTGp0dDVS?=
 =?utf-8?B?U1ZHenhGRGxVb2MvdkZ3KytsTlU4V2doM0orSmthT1czZHM1UWFZK3BUYitp?=
 =?utf-8?B?UFJCdVdIWDcwSDlsemZlaitKUGRYL0RndWh4N2xieWE1VlVUZ3AvR25GQVdn?=
 =?utf-8?B?WmlCQy8wMlkyTzdKckw5YXRtbWhHVmQ4cTFNQlRHeTQ1elRJdzNxcWN5M0FM?=
 =?utf-8?B?cEZTSFVTSmg2OVlLaUwwRHdlTExkU3VjUFVUUUVzeWViVVVZLzRjSHk4MGVl?=
 =?utf-8?B?bHZjUWxBcGRZdTR0aHo4dDVjYmQvS2N1dTg1bHR0TzBacnJMVVc5T3ZScXh6?=
 =?utf-8?B?TUVuVklhN0hJT0JOeElDWHplRDQrcTdJcHVYNjZ6SkVaY1NseWVCT0FneGNl?=
 =?utf-8?B?TzFLYzZKcFBiN0RWaVdGbG12QUFYK1pVWVBiaEFiTTkyWmVvbndGdUo3Nm1C?=
 =?utf-8?B?MW9Rck9QRng5RU04NXZxb3JQZUZZWk1HZTJrTGJRWnhEY3JBYjFYQlljaWFh?=
 =?utf-8?B?OW4waTdpNUxRSVlIZFMvQ1JEQnUrK0ovT3gzWDd2UnBIRnlXMG8vU2tlaDJt?=
 =?utf-8?B?b1dEcnBrNlhuNFgwMWhSZnFETE1zVFdjeWxiMU5oWFpjVzAycG0zS2l4MXRO?=
 =?utf-8?B?SWlNYlg0OVV6aVNyakVodFYwbTlRRVU5WXF4UU1Sa3dQbUtleC9Sem5JaCtL?=
 =?utf-8?B?TFN3RERYb2E4UXBjTDJlUlBjNmsrdll4cDdEbVpiWlpObE82d3FHT2NBWlNr?=
 =?utf-8?B?bUJPRlhpaXdxNXNzZkFBeEdONVlmRytSREZBSCtFdzQ2c1gzUG5CTkp3MjFD?=
 =?utf-8?B?SUQ0MEFPTUpFUDdIem5vYTFWZnVrWll0R1lVT01BRmkxS2RGOUJaOW0wS2pO?=
 =?utf-8?B?U3E0YmhyVHpZajg3eERPQzZnTzBoRy8xQ1Ywd3BGMW16ZEhOYlZoN3hNK0o4?=
 =?utf-8?B?Qy9xMGY1V2pWK1J0alR3NERBSHcrZHJLRGpIS0tQZnpMNDVWM0NadUc3bmpj?=
 =?utf-8?B?WXdpTThnTEk5UEt5K3J4RFdHbzR1dnBUeWN5MlBabEJXVUtUZk5SZHdDbDJ3?=
 =?utf-8?B?Y2xsYi82ZUZMdzlrb1U3ZElMOXZvQlFOcmVPSVBnYWxXcU12dkZBSUc3M044?=
 =?utf-8?B?TWxxSXBJYWRad2drRFpnWTBRQ3lTVHR1YTlhb1FQRTJJVmVKdE1XeFc4dllY?=
 =?utf-8?B?WkxSUTB3WUhucWJveVV2VGUySWNidkRmUGxvTUkvMzdxb0FyZWN4ZWJNaWUv?=
 =?utf-8?B?MWZCai9ESklLUFc4Nm1BSUx4SzJTR0lxVG9IdEEzUGlmUFdxTno0eEdnTyt2?=
 =?utf-8?B?bEttREJHTFUvaGN2aEpSNDY4OTl2YnZCZXI2RUdIVUNScHJWTm9kbmw3cWMy?=
 =?utf-8?B?RDBhODNLMGE5MXRZYmNwaUlUT2tpVGtPeEpxNzV3RlZaNWNMcjZocStYZUZl?=
 =?utf-8?B?L0ZoRm5pMnQ2MWRHcUVuVFIyYTYxK3dKak8rTjFBR2VSK0VKajVqVHVJei9K?=
 =?utf-8?B?Tmt2NUJJRG9aMmZvQ01SaHRVYmt5TUpZZHN6MnhSd1FyTENWb3RMbHBaVDVa?=
 =?utf-8?B?UE9WaFRIWXVYYnZESGk3alJKYjQ2Rk9mZWtXSDh0NDRjVzhWL0ZzRzlMTzVr?=
 =?utf-8?B?M2hvQmVQOXc3TGczQ09RQU80bkdFbzVTOFlqVC9jZDE1SmEyOW5TM2FGQXFo?=
 =?utf-8?B?L0Z5SWRNYjJwVWJST3QzaTFJVXo5RUk1Y0VtMUY2M0cxSGx4ZjlRb3BSQjVi?=
 =?utf-8?B?U0VEb3JuRUlGQmdKeXMvRWZucFhSYVhsc0NTWVZ6bWR3R1FPeHFJMEFQbDRi?=
 =?utf-8?B?UEpjaUw1eloyUjdjdU5OYlYycEhPRXppWHF5S0l1ZUZCWHJJUm1ka0djelRO?=
 =?utf-8?B?cnBXM01EbWdoUTNmdWlMRTByNW4xVzJWWDF2cHBZUFdETVlkQ2RMYkdaVnR2?=
 =?utf-8?B?RXlhWlhtMlpjOTBvZ3hPQzlHN1FlTUVJai9JSG9wSTcwZkNuemovMmUrakUy?=
 =?utf-8?Q?wf38nDtBPAtDx5qZCCUMynQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a955f0-2beb-4481-f029-08dbd5575764
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:38:50.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7G2/WTvm5dBw7UmQYQRrPOqTtvtrRqxExmE3szm63Dw4nqR4YttwrpU1L0QlAbABk9zjzdumSwMj3zO2u4GfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-Proofpoint-GUID: FoJka4ODDNfUnlVq6IKCJYmXXHUn3v-j
X-Proofpoint-ORIG-GUID: FoJka4ODDNfUnlVq6IKCJYmXXHUn3v-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 mlxlogscore=811 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciA5LCAyMDIz
IDk6MTggQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdn
QHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDA0LzE5XSBSRE1BL3NpdzogUmVtb3Zl
IGdvdG8gbGFibGUgaW4gc2l3X21tYXANCj4gDQo+IFJlbW92ZSB1bm5lY2Vzc2FyeSBsYWJlbCBz
aW5jZSB0aGUgZmFpbHVyZSBjYXNlIG9ubHkgbmVlZCB0bw0KPiBwcmludCB3YXJuaW5nIG1lc3Nh
Z2UuDQoNCkkgdGhpbmsgeW91IHN1Z2dlc3QgcmVtb3ZpbmcgaXQgc2luY2UgdGhlIGNvZGUgZmFs
bHMgdGhyb3VnaCB0byB0aGUNCnVzZWxlc3MgbGFiZWwgYW55d2F5IGFuZCBub3Qgc2luY2UgaXQg
cHJpbnRzIGEgd2FybmluZy4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfdmVyYnMuYyB8IDUgKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
dmVyYnMuYw0KPiBpbmRleCBjNWMyN2RiOWMyZmUuLmRjZDY5ZmMwMTE3NiAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+IEBAIC02NiwxMiArNjYsOSBAQCBpbnQg
c2l3X21tYXAoc3RydWN0IGliX3Vjb250ZXh0ICpjdHgsIHN0cnVjdA0KPiB2bV9hcmVhX3N0cnVj
dCAqdm1hKQ0KPiAgCWVudHJ5ID0gdG9fc2l3X21tYXBfZW50cnkocmRtYV9lbnRyeSk7DQo+IA0K
PiAgCXJ2ID0gcmVtYXBfdm1hbGxvY19yYW5nZSh2bWEsIGVudHJ5LT5hZGRyZXNzLCAwKTsNCj4g
LQlpZiAocnYpIHsNCj4gKwlpZiAocnYpDQo+ICAJCXByX3dhcm4oInJlbWFwX3ZtYWxsb2NfcmFu
Z2UgZmFpbGVkOiAlbHUsICV6dVxuIiwgdm1hLT52bV9wZ29mZiwNCj4gIAkJCXNpemUpOw0KPiAt
CQlnb3RvIG91dDsNCj4gLQl9DQo+IC1vdXQ6DQo+ICAJcmRtYV91c2VyX21tYXBfZW50cnlfcHV0
KHJkbWFfZW50cnkpOw0KPiANCj4gIAlyZXR1cm4gcnY7DQo+IC0tDQo+IDIuMzUuMw0KDQpUaGFu
a3MsIG1ha2VzIHNlbnNlIQ0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNo
LmlibS5jb20+DQo=
