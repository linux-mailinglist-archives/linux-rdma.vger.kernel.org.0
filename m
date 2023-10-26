Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEA7D8422
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbjJZOAU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 10:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOAT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 10:00:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC141A2
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 07:00:16 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QDoce1005226;
        Thu, 26 Oct 2023 14:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=hcYyV/UzDxVlMxYLYRJB4CEwagjYzKxtL4xpbkbS3ec=;
 b=Uqv9OsiGlPx5w1VhS1IZSzcUNEfk6dOHeiMSH4RvXfnlIEY7GuVlI4y67Id5UdX4EgmL
 eVkxwU04aTS2luWsbPh4oVSi3lC1zpH6XHta4WrOpPOvB/3gC2SWz0Wj+ZhuJg1Ozlgm
 nXKlnE8k5aVhTFR7k8dbfc8rTvWCzVLdD7n7Y6XkhvnU1HhRAXL4CMG/sc9iSZ+MaeeG
 GiQkXaGylf+4tyinXz/KmElvaemVLDR1TfOlH/nKzNulO7DO2IC+PXIzMwsx17Pes1HZ
 xpgXZ+f/nOp9F3n1BhBjTa8CG/I670nwhl/hR6Qs1tsGlYlIqT7yxIcU+CTPmHPtJDqn EQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyrn99t9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 14:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUX8k1IrZJHPgHmVY3ZzSYF+snTVcxJjN4rQf4kZ+mSKkQfzL5iBZSBCGXLJZ+cN20mD/2N1FiKYTfYovkS/Otwy4ylKETKQ5fY6/eLqWYKmxGFJ5c6C0t4NLobXERJR4ShxhfVZ4HWcBT1rfJBvsmmgpNEdEt5XtwtRHPFLCmspq8/zZng4S//2uVIOsluZz1Hkzwr6c9W+FSAaeqvCp2ZRJA3RnRa6J+zb+UOh47+0HZbPgOnpeopcvo7gu6MC8hesWbDfX6ZY1xv4kJQ7llAxWmMLullFjEXJaS/PwWfKdqA9LoxAI7H38AeDFuBa8lMK7A/KIGMkq50Fs0eBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcYyV/UzDxVlMxYLYRJB4CEwagjYzKxtL4xpbkbS3ec=;
 b=Ew502uvgxTY+0x+uZ7lLtSOJSbqGvx6jTSignyNQbQMFhviMhpT76keY6WBS9h/WQz/ejhF4RprM1fP9sMf5Cbfjfog0XUvHjpem3HJwl3+Hg8FkHXyyCJBhaD71C44J9Y42YMuJfbX3BJnBsv7ehY1TfkVRG1u8P7oRW0464yIBDhdTdAigOauwu77M1J3S59ife3dFBi9FiCsKTdXFFmvqCQ6EzmraHjxcCoxKWkHcCfi5H7Shvx/R0Z61BkdyvTE58jofVoedAbQxeVAzudx+QjOyqST8bnG3Ru1Z1EJxLT3OOhI4T1t49+C+gXAv/JAeKrH7gg/bWwGtSDCDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SJ0PR15MB4171.namprd15.prod.outlook.com (2603:10b6:a03:2ed::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 26 Oct
 2023 14:00:07 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 14:00:06 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH V2 18/20] RDMA/siw: Only check
 attrs->cap.max_send_wr in siw_create_qp
Thread-Index: AQHaB0cN3eN/mrepR0WFiGT5pkdXPrBbpCgAgAB2YeA=
Date:   Thu, 26 Oct 2023 14:00:06 +0000
Message-ID: <SN7PR15MB575583634865F81E2CAFF65599DDA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-19-guoqing.jiang@linux.dev>
 <SN7PR15MB57558847D886D3A0F1882B7099DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
 <fae6fdff-6437-b24d-1427-8e954153c32f@linux.dev>
In-Reply-To: <fae6fdff-6437-b24d-1427-8e954153c32f@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SJ0PR15MB4171:EE_
x-ms-office365-filtering-correlation-id: 626603b5-3bdc-4485-9b15-08dbd62bdbe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSZoXKwdLm4ZhQJU8bBIrE928mV4a3/epjJjghe+lNFuxLVEiyFpxSJiSaOqIWNZlb7astPW/1Dof8vUjDKF12g9HOd9rNJB2cunNpvej2+eHPCE0vzM2DTQFQXWiigHX93XhGexJ88WF8DHMCq0L5BJnPOoT2zfVdbt6OvNNz+15oB9N9vXIoCkP2DZivax2Eoh3/63Csq5krcfdMKPNOxZ0vNjxRNZ8x2qfAUderISy84VfAMR7LOoXk7ZmvSufL1YG7jElOZywWnl5anFisj54sUK++w4wGBoYON9XZtgYQV9nLrZa+WAtaowSaiMXvqnTkHlQ0K6cU37hYI2iaZhTVb2GXFUBexdByjNxam+NNbhYdRBLjUgZFJPbUrbzDoX35Xrree4ER2SN1vhx2YeXtOZh9SwRTIyJiJDdmO6Go8e9sKfRqPps9dHD+X+qONb9ers7aE889AGdnwSde73TtvmOCobnUQreWxmQwMobdFVUXuRqB6FduXGBOk0A8+BJtuMWV+//QHueB165xrevWM0WjWhqyVEdIBRVu7VhQSJM6hsPq20JaCq1mQ/1B4aMnsWrc2h3C9rOAp7S5KLRkrwTh/9p/wjU6WYcdbrLFVZ2Qa8Lkp7ldBabjMm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(8936002)(38070700009)(4326008)(8676002)(110136005)(5660300002)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(64756008)(52536014)(478600001)(55016003)(2906002)(71200400001)(9686003)(33656002)(122000001)(83380400001)(7696005)(38100700002)(53546011)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTlOMVNqMzZtUzAzc1ZjODRiMDJSd2tSckM3K1dmUzVPOG1IQ2toNmZPckhq?=
 =?utf-8?B?YUVDR2Vqa0pEcDNRSUpYcHhrYjF2S3l1Tk5ndEpTQjRwVFBtSlZ0eVFZWkRp?=
 =?utf-8?B?TjFuSERaY3BodmZzYjZyL2NieWxjaHhlK1JmV1ZkeGlMRk5odDgrNCtlaWpW?=
 =?utf-8?B?ekxFengzdFhNN0ZoWHd6NWVlS2dhT05JQzhWb3BTZUNlTGFzdlVudU9MWHBr?=
 =?utf-8?B?bWhCMjYyK2dtazlhcjZEUDNIMndOV25uUkJJTUJhMGJQTWVyWEdYUkNTYWRh?=
 =?utf-8?B?ODJtTWNrL0FDRnBzK0RHSE13Zm5WNzFFTDArclB5eHpOYm5zaHFEaTM5Rjk5?=
 =?utf-8?B?ejNDYjgzTXdKcHF3dWh6eVRMcXJHTFpORitVdU1aQjgvMk1vekwvMit1T1Vx?=
 =?utf-8?B?NWRta2hIMmdycW9PemNlRm54aUN2OWEzOWVmTFF5N2FqbHVUSlJEaTNKbVdk?=
 =?utf-8?B?VGs5Y1ZHc1VkQzUwU1RWRjFaWUpQR1FTWStHVFArMDc4M0xIdmZ6VEhMMjh6?=
 =?utf-8?B?T0xzUW9HSytsaG5UQmpZNmhnNmVObkVDdWpWMDZJS0JTY0Fzc2FHQ0x2ZlMy?=
 =?utf-8?B?MG01aTZ4b3VvZVkxalhXM0pCT1QwSjZVUzhHM1ZRYWF0WWMvblI3OXAyREZ3?=
 =?utf-8?B?TDlJblNVVmR2akFYVUYydWx3YllkODh4S1dTN3VTSWFXMVhrMmUwWlllSTRu?=
 =?utf-8?B?cWpTbVZwdlhQY1BmbUljazVoT0NrdHFPdWY4b3R5MEY5VzlSa3hINGU0UUlF?=
 =?utf-8?B?U1lkUVYrbW5sVXE5MWxJSnpoMWpqOGp3dEpFM2F4NHV3SEc1RzVReW5aN1JL?=
 =?utf-8?B?WXh2NDlFNEp0R3RYaEllWXJZUDBWdmNLN0ZDelJrMUx1TFBZaDBiL09SOXVC?=
 =?utf-8?B?czZjcHpGQ2F6eEg0Vm9zaUZXbDVzUjlrT0RjQ1Y5Z0kzRHhuKzQ3dHUwZ1hE?=
 =?utf-8?B?ejVSaEgwUVp1eVRxemVZcm5XNGRRNFhjbHFkTXh3RlhEVS95dFV3MldnYkFU?=
 =?utf-8?B?RWlGUm9DSzI1Z1BMenFmNHN4b3BmMkdYOU5tNTF3WXZlUktBbkFGL3JNaU0x?=
 =?utf-8?B?WFNkcVRwTVhNdmJJR1JzalRnK3pyRTkzN2FTRGR0OVd0ZEdyNE5YbkhWUzJ3?=
 =?utf-8?B?VWt6MDFtWmlBK1hRQVZyYm9pSGc1S0RINVVJN3lvVTdwZ1ZWVnBBbXVVY211?=
 =?utf-8?B?YjFEYXhSamNoM1BWMGxRdVF1ZllmUUJ2bytRQ0hTMkVPRnJBVVpkUCs5c3VM?=
 =?utf-8?B?eUxJejZoQVhaWC9FWUo5bGlPVG5pRTJPYk5heDhaOUtBNVJnT0RkTDN0TEZp?=
 =?utf-8?B?NjNqK2ZXSlB6TWVoUHNSUTZzUVR3VHI4RGZEdjFJaW9nTFZiTnczOENDOVRL?=
 =?utf-8?B?OERuWU0zS0NJK3B2Q0lvcWhVNUtmbTBleFkwVG5MUXZGak9zOTczRXhkeGlK?=
 =?utf-8?B?b2VuNTB5SUtjb0dGVi9KQlpORW52eFlOR0NXNi9hYzY4MS9jOWx4bVdwU2N2?=
 =?utf-8?B?cWJvdm9McUZsemxvMzBVcDdXT1gyRVI3bEZINDl6MEtTWG8wODQzWDBwK0x2?=
 =?utf-8?B?VVRTVnlXOEZ0Ylh2TDMwOXc0NFBtUmppV21HSStxOTdNWjVRNmNqOGhVOG5L?=
 =?utf-8?B?emFyVUc1TStTaGgrMWFubFUyYmJqTE1mWkd4ZnJocm9TY2N3V295U1pERUVM?=
 =?utf-8?B?NXpYRW95Y1hjSmU3TDZzN1Z5MXpEU3d0RmhUUjRvWndFNUNvZnZOUVlONGZI?=
 =?utf-8?B?cnc1Wm9uT0tMN0R0aGJ0WVppYXl4ZXVyMzBOMzhSZndhL05hZTZuNmNVSko5?=
 =?utf-8?B?cE5TU211QktwVmZtZnlmSUVOZmhSSnAzeXZkb2RFeTB5T1NpOFJ4WlY4K2p3?=
 =?utf-8?B?VjJzdnlnSWxjZWxxVFZOZG9Mc04yaUlJdkRRU3NzRm9hNjBDSGJWbU1KNE5Z?=
 =?utf-8?B?VU03UUJORWNtOHp1N2VQYjc0c0wrWithdzFuRnZRSVU1aGZpYWhndnVRdG8z?=
 =?utf-8?B?OWdaQnVhb0lOVlRocU5XUlVTZytHMCsxNWlKc1VTdG41OVJlZFZZQldNamZT?=
 =?utf-8?B?ZkhOOXRya2JldS9lVC85WFBEWUpQZTFHRHdBeVpleEhvM09lWUx4OFIwb2Y2?=
 =?utf-8?B?SW9FcUs1SDJCdE1kUkIwd1RJMlMxN0tlTFhqQ1dmdTlOaUhrQUlsMTUvOHdT?=
 =?utf-8?Q?+sY4U8ms3gHLFSF96GRIMW8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626603b5-3bdc-4485-9b15-08dbd62bdbe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 14:00:06.4113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epPLdRL9Tty89vF+UbEPDrc767wf7O5KW7xWekB1CGU4H382aJXksPLTIoxZd/cVd51LDmZHRon8+Xi3BRMpmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4171
X-Proofpoint-GUID: aFz2H9FbqlytSxiV-ebFdw6aIsdrHPge
X-Proofpoint-ORIG-GUID: aFz2H9FbqlytSxiV-ebFdw6aIsdrHPge
Subject: RE: [PATCH V2 18/20] RDMA/siw: Only check attrs->cap.max_send_wr in
 siw_create_qp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_12,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI2LCAy
MDIzIDg6NTUgQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsg
amdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCBWMiAxOC8yMF0gUkRNQS9z
aXc6IE9ubHkgY2hlY2sgYXR0cnMtDQo+ID5jYXAubWF4X3NlbmRfd3IgaW4gc2l3X2NyZWF0ZV9x
cA0KPiANCj4gDQo+IA0KPiBPbiAxMC8yNS8yMyAyMToyNywgQmVybmFyZCBNZXR6bGVyIHdyb3Rl
Og0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBHdW9xaW5nIEpp
YW5nPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiA+PiBTZW50OiBGcmlkYXksIE9jdG9iZXIg
MTMsIDIwMjMgNDowMSBBTQ0KPiA+PiBUbzogQmVybmFyZCBNZXR6bGVyPEJNVEB6dXJpY2guaWJt
LmNvbT47amdnQHppZXBlLmNhO2xlb25Aa2VybmVsLm9yZw0KPiA+PiBDYzpsaW51eC1yZG1hQHZn
ZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAxOC8yMF0g
UkRNQS9zaXc6IE9ubHkgY2hlY2sgYXR0cnMtDQo+ID4+PiBjYXAubWF4X3NlbmRfd3IgaW4gc2l3
X2NyZWF0ZV9xcA0KPiA+PiBXZSBjYW4ganVzdCBjaGVjayBtYXhfc2VuZF93ciBoZXJlIGdpdmVu
IGJvdGggbWF4X3NlbmRfd3IgYW5kDQo+ID4+IG1heF9yZWN2X3dyIGFyZSBkZWZpbmVkIGFzIHUz
MiB0eXBlLCBhbmQgd2UgYWxzbyBuZWVkIHRvIGVuc3VyZQ0KPiA+PiBudW1fc3FlIChkZXJpdmVk
IGZyb20gbWF4X3NlbmRfd3IpIHNob3VsZG4ndCBiZSB6ZXJvLg0KPiA+Pg0KPiA+PiBTaWduZWQt
b2ZmLWJ5OiBHdW9xaW5nIEppYW5nPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiA+PiAtLS0N
Cj4gPj4gICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jIHwgMTggKysrKyst
LS0tLS0tLS0tLS0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd192ZXJicy5jDQo+ID4+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
dmVyYnMuYw0KPiA+PiBpbmRleCBkY2Q2OWZjMDExNzYuLmVmMTQ5ZWQ5ODk0NiAxMDA2NDQNCj4g
Pj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfdmVyYnMuYw0KPiA+PiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd192ZXJicy5jDQo+ID4+IEBAIC0zMzMsMTEg
KzMzMywxMCBAQCBpbnQgc2l3X2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcXAgKmlicXAsIHN0cnVjdA0K
PiA+PiBpYl9xcF9pbml0X2F0dHIgKmF0dHJzLA0KPiA+PiAgIAkJZ290byBlcnJfYXRvbWljOw0K
PiA+PiAgIAl9DQo+ID4+ICAgCS8qDQo+ID4+IC0JICogTk9URTogd2UgYWxsb3cgZm9yIHplcm8g
ZWxlbWVudCBTUSBhbmQgUlEgV1FFJ3MgU0dMJ3MNCj4gPj4gLQkgKiBidXQgbm90IGZvciBhIFFQ
IHVuYWJsZSB0byBob2xkIGFueSBXUUUgKFNRICsgUlEpDQo+ID4+ICsJICogTk9URTogd2UgZG9u
J3QgYWxsb3cgZm9yIGEgUVAgdW5hYmxlIHRvIGhvbGQgYW55IFNRIFdRRQ0KPiA+PiAgIAkgKi8N
Cj4gPj4gLQlpZiAoYXR0cnMtPmNhcC5tYXhfc2VuZF93ciArIGF0dHJzLT5jYXAubWF4X3JlY3Zf
d3IgPT0gMCkgew0KPiA+PiAtCQlzaXdfZGJnKGJhc2VfZGV2LCAiUVAgbXVzdCBoYXZlIHNlbmQg
b3IgcmVjZWl2ZSBxdWV1ZVxuIik7DQo+ID4+ICsJaWYgKGF0dHJzLT5jYXAubWF4X3NlbmRfd3Ig
PT0gMCkgew0KPiA+PiArCQlzaXdfZGJnKGJhc2VfZGV2LCAiUVAgbXVzdCBoYXZlIHNlbmQgcXVl
dWVcbiIpOw0KPiA+PiAgIAkJcnYgPSAtRUlOVkFMOw0KPiA+PiAgIAkJZ290byBlcnJfYXRvbWlj
Ow0KPiA+PiAgIAl9DQo+ID4+IEBAIC0zNTcsMjEgKzM1NiwxNCBAQCBpbnQgc2l3X2NyZWF0ZV9x
cChzdHJ1Y3QgaWJfcXAgKmlicXAsIHN0cnVjdA0KPiA+PiBpYl9xcF9pbml0X2F0dHIgKmF0dHJz
LA0KPiA+PiAgIAlpZiAocnYpDQo+ID4+ICAgCQlnb3RvIGVycl9hdG9taWM7DQo+ID4+DQo+ID4+
IC0JbnVtX3NxZSA9IGF0dHJzLT5jYXAubWF4X3NlbmRfd3I7DQo+ID4+IC0JbnVtX3JxZSA9IGF0
dHJzLT5jYXAubWF4X3JlY3Zfd3I7DQo+ID4+DQo+ID4+ICAgCS8qIEFsbCBxdWV1ZSBpbmRpY2Vz
IGFyZSBkZXJpdmVkIGZyb20gbW9kdWxvIG9wZXJhdGlvbnMNCj4gPj4gICAJICogb24gYSBmcmVl
IHJ1bm5pbmcgJ2dldCcgKGNvbnN1bWVyKSBhbmQgJ3B1dCcgKHByb2R1Y2VyKQ0KPiA+PiAgIAkg
KiB1bnNpZ25lZCBjb3VudGVyLiBIYXZpbmcgcXVldWUgc2l6ZXMgYXQgcG93ZXIgb2YgdHdvDQo+
ID4+ICAgCSAqIGF2b2lkcyBoYW5kbGluZyBjb3VudGVyIHdyYXAgYXJvdW5kLg0KPiA+PiAgIAkg
Ki8NCj4gPj4gLQlpZiAobnVtX3NxZSkNCj4gPj4gLQkJbnVtX3NxZSA9IHJvdW5kdXBfcG93X29m
X3R3byhudW1fc3FlKTsNCj4gPj4gLQllbHNlIHsNCj4gPj4gLQkJLyogWmVybyBzaXplZCBTUSBp
cyBub3Qgc3VwcG9ydGVkICovDQo+ID4+IC0JCXJ2ID0gLUVJTlZBTDsNCj4gPj4gLQkJZ290byBl
cnJfb3V0X3hhOw0KPiA+PiAtCX0NCj4gPj4gKwludW1fc3FlID0gcm91bmR1cF9wb3dfb2ZfdHdv
KGF0dHJzLT5jYXAubWF4X3NlbmRfd3IpOw0KPiA+PiArCW51bV9ycWUgPSBhdHRycy0+Y2FwLm1h
eF9yZWN2X3dyOw0KPiA+PiAgIAlpZiAobnVtX3JxZSkNCj4gPj4gICAJCW51bV9ycWUgPSByb3Vu
ZHVwX3Bvd19vZl90d28obnVtX3JxZSk7DQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMzUuMw0KPiA+
IE5vIHRoZSBvcmlnaW5hbCBjb2RlIGFsbG93cyBmb3IgYSBRUCB3aGljaCBjYW5ub3Qgc2VuZCBi
dXQNCj4gPiBqdXN0IHJlY2VpdmUgb3IgdmljZSB2ZXJzYS4gQSBRUCB3aGljaCBjYW5ub3Qgc2Vu
ZCBzaG91bGQgYmUgYWxsb3dlZC4NCj4gPiBPbmx5IGEgUVAgd2hpY2ggY2Fubm90IGRvIGFueXRo
aW5nIHNob3VsZCBiZSByZWZ1c2VkIHRvIGJlIGNyZWF0ZWQuDQo+ID4gS2VlcCBpdCBhcyBpcy4N
Cj4gDQo+IFNlZW1zIGl0IGlzIG5vdCBjb25zaXN0ZW50IHdpdGggdGhlIG9yaWdpbmFsIGNvZGUs
IGJlY2F1c2UgWmVybyBzaXplZCBTUQ0KPiAobnVtX3NlcSA9IDApIGlzIG5vdCBzdXBwb3J0ZWQs
IGFsc28gbnVtX3NlcSBpcyBnb3QgZnJvbSBtYXhfc2VuZF93ciwNCj4gd2hpY2ggbWVhbnMgYSBR
UCB3aXRob3V0IHNxIGlzIG5vdCBwZXJtaXR0ZWQgaGVyZS4NCj4gDQoNCllvdSBhcmUgcmlnaHQu
IFRoZSBSUSBjYW4gYmUgemVybyBlc3BlY2lhbGx5IGlmIGEgc2hhcmVkIHJlY2VpdmUgcXVldWUN
CmlzIHByb3ZpZGVkLiBTbyB5b3VyIHBhdGNoIGxvb2tzIGdvb2QuDQoNCg0KPiBCdXQgSSBwcm9i
YWJseSBtaXN1bmRlcnN0b29kIHNvbWV0aGluZy4NCj4gDQo+IFRoYW5rcywNCj4gR3VvcWluZw0K
DQo=
