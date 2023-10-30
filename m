Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91A7DBA3D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 14:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJ3NF0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 09:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3NFY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 09:05:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6708AC2;
        Mon, 30 Oct 2023 06:05:22 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UD56DK007366;
        Mon, 30 Oct 2023 13:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=9ZKDAnH0RI5WLE4oeSKaygvyIQafVtkxKAI27fTXhK4=;
 b=K+sINTk3iseII8gfkRWC5L4he1cUv8bA8grmG/WAmswIGhuuITaBmeXdyuyTrQJGoXOT
 IO7TKU5it+tECGuoPbh3Z2EyNaaB9eHqVnMNIDtGDQOHUjJ0XRNz9rtId7Lm4qdLglGb
 3+mRuhWNtkkDsEIUyTBtYDDoQK3O9zSO0XvD+J/MxwFq5apANWPkWQVu8IBrWZnN7kas
 rYZDBNM0Wm1+HdyX9lLJPb3Ob9OoUg0oxLhtIbzY9cj7w1eUJdujlaGDvoEt6fm76u5J
 rAGM34B7e3oboetQaTIgS+QsxSmCMsuGcNKb41YVsLStNlNjGwSRsQtIkBR3LfFcymud Kw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2cp0h175-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDfuimKxyAZqOTAHqlGEtbbFuDG3bihBGoI3HR5F3cq7GWqtjHMhEnApufgfUO++ON5G1ERM8V9NUJfD5FWDjuhyOX+lZ6wbLRe7Ed+ch0QKdEyHUCaS5eLQnyPEqznXOltt4HCqXTRey9V8v03QP7GWGctrkDE6Sb/qKdKGzMFULQgZSRIbZfqdXZpMCYmDJQCHEpWGw9IDxT50NePHbJSvQ5iiWFCeCVnJzYMce+u6EQwxehJdLg8JcODnyTKQrqVw3c3XTfw1h26AliHnaMnyPiYlS2pDzZqOuX3/ngqntuTI4XVjsneCKYn/r7uvWXRpohx5L3p99b7bOaH5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZKDAnH0RI5WLE4oeSKaygvyIQafVtkxKAI27fTXhK4=;
 b=SKwjdsTJV/OANy64LzEG8EANxwyF6070mk8QsEvJKwm10DXvYzja8811Ifi7WDqeQeOv1lDajxp6kezwQPwmGiRRFMgyXWPsFjxJJrzoaY/xIsDk+EB1U2UKTZpYjStyoSoIo4+jXy9Jd4rzGFtHdDw3i7tqON441dkYbZLKB/aqMflEUEfcAZFAH9RtWiiekN+nNvq1qM4Q/z+RyJoYmVBnZ0YWNCzJRManYZnhv2XsT2kO1n6Chv7G2NYPYdBOo66pmsUfAw9RPSllInPdRtO0cqCLqWEXHmlmcMZB0ZhaMKyCsNINwTo7yYNq9M0QhnMkf1wB6pLdLb489lRAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB5992.namprd15.prod.outlook.com (2603:10b6:610:166::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 13:04:35 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 13:04:35 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Eric Biggers <ebiggers@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: use crypto_shash_digest() in
 siw_qp_prepare_tx()
Thread-Topic: [PATCH] RDMA/siw: use crypto_shash_digest() in
 siw_qp_prepare_tx()
Thread-Index: AQHaCzGhNrtCSUW0uE66g0ysUK4uew==
Date:   Mon, 30 Oct 2023 13:04:35 +0000
Message-ID: <SN7PR15MB57557953AEA0AF79680CCF2599A1A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231029045839.154071-1-ebiggers@kernel.org>
In-Reply-To: <20231029045839.154071-1-ebiggers@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB5992:EE_
x-ms-office365-filtering-correlation-id: 28d9627a-89da-4095-d5d8-08dbd948c43c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DtMau/Lu2FBFHz8LLRJLTL5cO2aonUG3lPR71eLzAEKcuKDR5wPGQihHIoXLZBNOJAlyiO4LDyQx0yQU+6RKG7OZUU/J45Tf97XDh9b+Fs7V9PSkg+X81qb1DXJdV2VHb4hchVczF17hdCR/w29x+L8Xbl6Po3UEA/qPG1b3spners/sOoEMuvT/IQDoyqw4Nvu10Kb4dDwW1FGymxijzJ8xcMz6GGnTKNFb+8oZr/A9ZA39BWedWz04gIsO7qoO5gZxp65zViaijNLTek5izm0POzf4ZYkgddzlLdB6cnG3x3fSod07byfjUrnL9WvclvlvLRkueuhhSGiSPIqaqTWxRJgacEsH17wQeqCIv+y4O4l8wxJf1QhBQV+kLplbPwe8w9kSVO8x6BUPbdGONLb0XK/AUqlvx7wx2xbGkWYySAKPn14F//rTBXQSOtd2LqLwiKJloxG8PJPnlIArogiEB5/Dmbal9vhH5lXBEUMEv+jDy2k8TiMVf+4Cnb8qEfZTOpJFBCRfN64Ge+wcOJ1qg0mxjLt+Hl53VajbuK5Vd1nAWXsjiAELv0VOHiViv2VxyiBG3KU+p7JIXKg/CBnA1o/ICHVBvu/hhkFxboQJo0UA0t9ZpMYKz7Qu49tBBN4M0kKmwuAhg0qNUm/T+WHloauCNx8AVIPWj9oSEoo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(451199024)(64100799003)(55016003)(9686003)(26005)(53546011)(6506007)(478600001)(7696005)(71200400001)(83380400001)(2906002)(5660300002)(41300700001)(110136005)(66476007)(66556008)(66946007)(76116006)(66446008)(8676002)(8936002)(52536014)(4326008)(316002)(64756008)(38070700009)(38100700002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGR1SDJKdVlNV0J0UkQxVE8vVjltb2F6bXl5NWFMRUxTQVBIcStTcHpIS0tR?=
 =?utf-8?B?bjZhb2U2aGpHWXF3VEQxR3I0ME9kVTc2NFM5V0dVRWo1WGVmdXFPQ2VEQ3Vo?=
 =?utf-8?B?clN5azlLRitSckJ0Y0xjY1Evb0cyeDZESVgrS1pNSEZTNW9ycTg3Sk9IU2lq?=
 =?utf-8?B?Y2gzVGJFVkgyTnZwcG5tL3dTOTJzbFNYc2RVRVJaYStTTHU4M3Z5b3FRdndI?=
 =?utf-8?B?NXlwa093T0ZydzJ1bDlvZEFGY0Q5Z1VIM2Q0Y2pYV1NaaFkwNnVyZW45MktP?=
 =?utf-8?B?TWE5ZUJlUXpybklMOXdSeU0zcmFRbHZIdzhhb05DUW1OeXNETnNCdThFQXEw?=
 =?utf-8?B?RVVDYmI3eXdZMDg4bzZJWDFGdlJWUUxZMmp3VGFsekNCbXY3UFNJZUUvaElG?=
 =?utf-8?B?U2F6U0I0NkM0M0RTNm12eit1Q3g2cEFpNWFiT2I0SGJLTVRkeFplWitndlNk?=
 =?utf-8?B?SmIzNlZucEYwaG9ORXpxNTMrMmJDazd4WEdzaWZwRUVYQWVsc2xwMHcvcTky?=
 =?utf-8?B?YnZxZlFKZzFnNUE3T0hJeE5DS1ZLWFFISDF0U1dYSjQxZlJBWGl3bzhwLzg2?=
 =?utf-8?B?UitKQUFLL1pOc00zVXVBTXZJL25rSVZnWXJkK0NkTTlGL3MwdHpmTFJZKyt3?=
 =?utf-8?B?NDh4YWw3eFpjRzFNVXJ6S05tb0lsSldPOFZ2b3pBSHBHeWV1NnZsZkUxV00w?=
 =?utf-8?B?WTVKR09UUU4za24zSE94RkpsbTg5WllXMDRJakNOSk9qVW5RK1RSZEIyV0g0?=
 =?utf-8?B?ZzJtdGw2SDU5RjFNcTI4aWplYll5eVNRNEdhTjAxSlhmOU5ocnpuejgvZmI2?=
 =?utf-8?B?N1BjT0tZcHM0VHpWay9jMzFyV0tmS2E5VnJKUm4vakJtMHhKOFkyMG1nWE5B?=
 =?utf-8?B?ZlRIN1ZScGJUWHpkekJFRDBiOTJBNFNuRklMM05GcUpDN2RnVy9kcVVRSG1L?=
 =?utf-8?B?SG1GVE1rU1YwdHo0RDk2VlErUjAyODV6NUtVYzU3UzkvWkE3anpkOHU4MElU?=
 =?utf-8?B?NWgvTHFPQTkvZjVTUHMvSStPSURUaU5OdENUcWxqM1phN2k1OWRFUlR4cXFK?=
 =?utf-8?B?VVc2OWlqNTdiSEJpRDlGOVE2RVpMcnJoQjQ1Nm52SzJTYlhXdmZoSHNITlB2?=
 =?utf-8?B?QXB6dEVnQnhsYTJlWnJwZHQycy84aUxKQ3l5VDNUSlRmL0ZjcUkycUZrUDBi?=
 =?utf-8?B?ZGI5cDlDSUxGMUNNYmlMTldDeG8ra1oxNzVxWEkzWk5oUHhjN3RUaWFORHMv?=
 =?utf-8?B?ck8xTlowK2JEbjFhc2RGUWFLZjdDT3BXaXJrNGdIempxOC9ndnkzSTBTSDJO?=
 =?utf-8?B?c0JyZVNpbEVzdjBTbS9pdUdlRkVuQm1yeXpqcmMxTkdveXR1MzJkblRkcDRq?=
 =?utf-8?B?dHo0WjY4QnFEc3dWbHB5VlBsc2Q1Y2dKWkpwSGVlNmFvVFBlOHM0QTlUcUxZ?=
 =?utf-8?B?NCtPRHRZUVM4WTBSVGhmbVZ4R2xSYTR0d0pMUkJVdTZabmpkdFJkSktmZXBm?=
 =?utf-8?B?TkFUeFZidExaTVdHZ1JTbGVXTTBLanpkaXIzOG5kVSt6K3g4YUhJcW1KSWR3?=
 =?utf-8?B?cGdIYlZmUmZydGs0dTNVU3hraU9hL3RQRFRmZEIraUdLaXBnMGpGcy9FTE1F?=
 =?utf-8?B?SGM1Z3lWZHBxUkxQRHpGcGZ4YkY5eWhxdmRIbVJsNEJwZTdzckpNMG4zcTF1?=
 =?utf-8?B?NVhPOWg1SVNlS0ZrcUNhdURmUlBYckZkTzlnNERjOHdlMHdHb0RORkdIdkhp?=
 =?utf-8?B?Y0kvZnJ2QVZYTGlGa2xZaFU1eWNGQ0dFTVRHM3NlTWpoU1hFNHk2Yk1PazlY?=
 =?utf-8?B?MWlkWVdCa3JFeXBKVFFhMkpSY1VJODArblVnNHFZWjhieDkrM3l6ZjRrYnR0?=
 =?utf-8?B?Sks4eFF3QXl3Qk43dE1oQW11dERvS2NBT3NKdnRuR2plM0RXU3FzanYwcnZi?=
 =?utf-8?B?WVNCTEw4TWRPb3h5blk0ZURQM3ZMWmEvVWpORVo0SCt6b2pHbnNpRXRVVGly?=
 =?utf-8?B?ckYwYU5ZVzBSTTNoUk84bG9sM2Y4anZraUc3U0dBWjFXcS9lckQ1ZW4zb3kv?=
 =?utf-8?B?WEY1OUdpbUV4dk9tWEg4TlJiS1dlc3YwKzZDdVA1UHduNndEWGZhVElaMlB3?=
 =?utf-8?Q?9hsw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d9627a-89da-4095-d5d8-08dbd948c43c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:04:35.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei6C7dRNBAEr/eH02w3VDXQ8iiOhtBzWOHAsY3xsdT/m70hpB2CrqDBpYolsV3bqrgIKhgkVjQDR3862Su8yzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5992
X-Proofpoint-ORIG-GUID: BNyGZ1XYCDH51rg138zEqU3c0bmRbxw6
X-Proofpoint-GUID: BNyGZ1XYCDH51rg138zEqU3c0bmRbxw6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBCaWdnZXJzIDxl
YmlnZ2Vyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIE9jdG9iZXIgMjksIDIwMjMgNTo1
OSBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBKYXNvbiBH
dW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47DQo+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwu
b3JnPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0hdIFJETUEvc2l3OiB1c2Ug
Y3J5cHRvX3NoYXNoX2RpZ2VzdCgpIGluDQo+IHNpd19xcF9wcmVwYXJlX3R4KCkNCj4gDQo+IEZy
b206IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNAZ29vZ2xlLmNvbT4NCj4gDQo+IFNpbXBsaWZ5IHNp
d19xcF9wcmVwYXJlX3R4KCkgYnkgdXNpbmcgY3J5cHRvX3NoYXNoX2RpZ2VzdCgpIGluc3RlYWQg
b2YNCj4gYW4gaW5pdCt1cGRhdGUrZmluYWwgc2VxdWVuY2UuICBUaGlzIHNob3VsZCBhbHNvIGlt
cHJvdmUgcGVyZm9ybWFuY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJpZ2dlcnMgPGVi
aWdnZXJzQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYyB8IDEyICsrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfcXBfdHguYw0KPiBpbmRleCA2MGI2YTQxMzU5NjEuLjViMzkwZjA4ZjFjZCAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiArKysgYi9kcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IEBAIC0yNDIsMjggKzI0MiwyNCBA
QCBzdGF0aWMgaW50IHNpd19xcF9wcmVwYXJlX3R4KHN0cnVjdCBzaXdfaXdhcnBfdHgNCj4gKmNf
dHgpDQo+ICAJCQkJY190eC0+cGt0LmNfdW50YWdnZWQuZGRwX21vID0gMDsNCj4gIAkJCWVsc2UN
Cj4gIAkJCQljX3R4LT5wa3QuY190YWdnZWQuZGRwX3RvID0NCj4gIAkJCQkJY3B1X3RvX2JlNjQo
d3FlLT5zcWUucmFkZHIpOw0KPiAgCQl9DQo+IA0KPiAgCQkqKHUzMiAqKWNyYyA9IDA7DQo+ICAJ
CS8qDQo+ICAJCSAqIERvIGNvbXBsZXRlIENSQyBpZiBlbmFibGVkIGFuZCBzaG9ydCBwYWNrZXQN
Cj4gIAkJICovDQo+IC0JCWlmIChjX3R4LT5tcGFfY3JjX2hkKSB7DQo+IC0JCQljcnlwdG9fc2hh
c2hfaW5pdChjX3R4LT5tcGFfY3JjX2hkKTsNCj4gLQkJCWlmIChjcnlwdG9fc2hhc2hfdXBkYXRl
KGNfdHgtPm1wYV9jcmNfaGQsDQo+IC0JCQkJCQkodTggKikmY190eC0+cGt0LA0KPiAtCQkJCQkJ
Y190eC0+Y3RybF9sZW4pKQ0KPiAtCQkJCXJldHVybiAtRUlOVkFMOw0KPiAtCQkJY3J5cHRvX3No
YXNoX2ZpbmFsKGNfdHgtPm1wYV9jcmNfaGQsICh1OCAqKWNyYyk7DQo+IC0JCX0NCj4gKwkJaWYg
KGNfdHgtPm1wYV9jcmNfaGQgJiYNCj4gKwkJICAgIGNyeXB0b19zaGFzaF9kaWdlc3QoY190eC0+
bXBhX2NyY19oZCwgKHU4ICopJmNfdHgtPnBrdCwNCj4gKwkJCQkJY190eC0+Y3RybF9sZW4sICh1
OCAqKWNyYykgIT0gMCkNCj4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiAgCQljX3R4LT5jdHJsX2xl
biArPSBNUEFfQ1JDX1NJWkU7DQo+IA0KPiAgCQlyZXR1cm4gUEtUX0NPTVBMRVRFOw0KPiAgCX0N
Cj4gIAljX3R4LT5jdHJsX2xlbiArPSBNUEFfQ1JDX1NJWkU7DQo+ICAJY190eC0+c2dlX2lkeCA9
IDA7DQo+ICAJY190eC0+c2dlX29mZiA9IDA7DQo+ICAJY190eC0+cGJsX2lkeCA9IDA7DQo+IA0K
PiAgCS8qDQo+IA0KPiBiYXNlLWNvbW1pdDogMmFmOWIyMGRiYjM5ZjZlYmY5YjliNmMwOTAyNzE1
OTQ2MjdkODE4ZQ0KPiAtLQ0KPiAyLjQyLjANClRoYW5rIHlvdSBFcmljLCBsb29rcyBnb29kIHRv
IG1lIQ0KDQpBY2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
