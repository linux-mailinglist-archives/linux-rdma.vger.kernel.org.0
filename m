Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8E7C890F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Oct 2023 17:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjJMPp5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Oct 2023 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjJMPp4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Oct 2023 11:45:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81965CE
        for <linux-rdma@vger.kernel.org>; Fri, 13 Oct 2023 08:45:53 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DFinLQ019088;
        Fri, 13 Oct 2023 15:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=vc6xLiaF0j8JeYkzI+/KMRvOdm7yT0jF1vwFC9EtDmk=;
 b=ExsAdBgfkdA81HKWpFmjBPw+QAeIrOc9Nr9lwg4zMRjgvsa8h4lPlh38maEj5mGdsvaY
 C5ALkM4HStV6WzTLBj1xDLBS7PuDvZr7GS5W+nSNDv7Y5wQUbJjR7HHYKgMsipLdiUy9
 mUhSCCGcHJZ+8nuW1DgZRbQvoVon7EyOGbcdK+RxO2djhitn7kH267W5LR2F4pu0LajX
 +qv1dm0ENwKyZmFoEajXtuYo333IseWkY7IJPBuq22pNlly96vD7acyiluSdn9iHXauA
 rcQ1p1+PHJUc4X+kGNh1Cdi/u/h7rdymGc+qx9IDlax4xbqS328VI78DihodHKFlmQhN lw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq8t581qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 15:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAECbNbewFqDvkVYApnONleI5aYu/EX1lz7/2GIBc+gyhOnW/LbVl7IJo+5vyDseZfIqDubH5N4RDMDHF19FW/HpgJJuZu35MQACm1SUptv+KXNN9kKDUUic7BnJKj2DjO4pOcZqpEXoMdZpklpyCb0OzfIS4CRnwhSlOFfX6W2M0bjegimigC31iI8Yik/K3O93B1sUCcEPJQx7mi7Oed4Jgm/wOcEFwmdqBazFGHPSK3F2+zjTP8Y55r3VETo/IFICQY0kT1BQG9y9Q8S43zD8SCdpk974LKqjuh1x/rITRd532UuIw3zZzN5xbnTTzQMdY2GvM8ydgno1CGqy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vc6xLiaF0j8JeYkzI+/KMRvOdm7yT0jF1vwFC9EtDmk=;
 b=Ieotwekry0TZCs84dtgb9hngghn2KCIRDKpQrXUNQ4gJa0KFSYNN9dEKzgX+LgtBq+jA8iouht5iLpLnewSebLq2DpguCK4OAP7fxvpvDv/ZkHBYh0dbvTdwlQ70eEm1TMmIs6wFyFSWlgE/zgsLLtYxYp88qc/QOgbw8hMnM8dsiKruVsHJIogTXMnk6oCAKUkuNnIXx5fNqMkk5dF0hyEyTlNTWlKrzs46yzV04bxUTcfhKDrgzcLmwVAvzovW+f4lM9b+B41l3an5G5Qo7njRl+njnspHto9e9zevvYur07hMhA9XwKSQVrOSvKviROfXcQ7johdWxpoeRuRhgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:45:45 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::22c9:19b7:db90:c653]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::22c9:19b7:db90:c653%2]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 15:45:45 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 00/19] Cleanup for siw
Thread-Index: AQHZ+oDHWkSMBlARP0awYEyUjMRTRLBH4xRQ
Date:   Fri, 13 Oct 2023 15:45:45 +0000
Message-ID: <SN7PR15MB5755F8C0177A3D305F98C2E699D2A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA1PR15MB4465:EE_
x-ms-office365-filtering-correlation-id: 4863306a-b411-462e-269f-08dbcc0376a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mK/GH4biEtt1eydwSG90Akdl/m1owb0KnHRWVfQ6cI8LOIQ94/xRkSmZyy2fzOfVCON1enjGAiMjMPeZWh9oibimx9qqcAj6i+84o0sMqCkvpdUswzmersyg2PhJVGeTVtNdjotPXUAhh4SNttkWt9YiCm/BeuqeNxnBxc0pTuuSCGhAnXmtnfrDl6JoaVXdFc69h5ySo7AUCmUpHuGVsgQJUMmTzevncmIsWBRn6xfiRbvV3j7snrZObVFjGCfbsPM8MS7OQEq1MMslLLlWSlhI7WdYag1azU39zzP40n/moNljbwuXtj0c6aiUI12317jfC3vJVXEa8ysYLsEQ+eVcF5KDpif2+s/MnyBmQCX3x1s8gD/bnjAks4Sq+3cYAKKw06d69x31ICrqjgQptdcvR7qCetkBY8iG57JdNGkVXyi+9eK0JdJZVjxwHBpfykikUYB3UXf7P7uuNwmB2u6TiLc46+OaMGg+/Bvn+XYuHBP2a3KNU8KvDP3a6EbCEyebFQAhu5FpAnI7UD3PX4o4S05s0j970RtcR10eqruJl66bN1p39JzgotP6uzVdPyIoLbpfOSuZt6hUyK/zDcGkXiUT2Zu9nfsVCx0RH9xlAKdAAs7laX7hXWwzaO9x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(122000001)(8936002)(2906002)(71200400001)(8676002)(5660300002)(52536014)(478600001)(4326008)(6506007)(53546011)(86362001)(7696005)(9686003)(33656002)(41300700001)(38070700005)(38100700002)(316002)(83380400001)(26005)(64756008)(66446008)(66476007)(66556008)(76116006)(110136005)(66946007)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1ZIOGthRXpicE1BZzRReUxWRVhPcDUwdzVBRzc1VGxnMkFlYnhCYWhycnBk?=
 =?utf-8?B?b1BBajNoTHNKS0ljUE9UOEdZWHlGVWUzZ09vMm5Ieit3cW1xdGhQQ1J0MGk5?=
 =?utf-8?B?dFlLZDUxdDZyS0x5M0phOFJ0UWxTWmN3OWFPMEpsYllabjM5NVhKYWFBRDU3?=
 =?utf-8?B?c00reXF0R2hMVWtDK2RqM05NNXVWOU1PeDY5LzY3aTFFRnBIVkhGVi9aU0xt?=
 =?utf-8?B?bEhTdmNYL3pzUnJueFNraXVqK3pEalAwaDJ6dTdMcmthem0zeVAvRGRHK1VR?=
 =?utf-8?B?M1EyZUJMbDJQRlUxc1Z3dklHS1hhZ0ZQQkVTb2R2S1huTHRsWEVVWkRCUE5C?=
 =?utf-8?B?SjN2ZUF2NGY5MTlhc1hWWUI4MFhQZlpHbWVOdEc5U0hwQk9paWxZTFZmTUFF?=
 =?utf-8?B?OG1QazltamRSSStRdE4xR05iQnBSWjB2WjNYVU5HcXoxWjZBRDA2bGVUblVX?=
 =?utf-8?B?UDUvbGcrdlpJNlN6c3ZmeVhReFNqb1B0dnhvOVdxVy93U2c0S1RlN2tmbzdX?=
 =?utf-8?B?cHJRcjN6TmJHUnJUd2dqbmREa3NPcTVxQ0tFWFNvWFpxY0dzMDU0aUVOczdi?=
 =?utf-8?B?VElNUE5hWTc5VmVaYTNia2IvKzBJeElvMTBmNmhGRlNTZWcxTDlGcU5zY0hY?=
 =?utf-8?B?RHBiMGp5cDh1UnI4Ky84cjR0Y3hIRmpoVHArTVI3Um1XTmh0MGh4bkZBUVdD?=
 =?utf-8?B?bXQrVWsySmF3ejBsUWdPY3FFOGdWNUlEcFZGTDhabTA2dGlxa0RJYUFYQ1ho?=
 =?utf-8?B?MllvWWk3ajJNRUNhZ2phanF6QUxmTVJhZllNYVlFOUwxUWNiRSsrbmgzbktv?=
 =?utf-8?B?NGFlRXZPM2NYNjFJMnpHY25Ebnhpb2pHMnc4OXY3emFyc1czaFZyalJhbzlD?=
 =?utf-8?B?Zm01QTVVQ2J2R1RSN2g5ZWF1c1ZiS3pXYnFYcU4wa0lKSGdTMU00WTl2aGRT?=
 =?utf-8?B?d1dzRlNFcWxDMk9jN3ErYW5IZ3dqUGw4cGREdmR4VHFHRXdCbDlLSkxXVDlM?=
 =?utf-8?B?VE92a3U1STh2blpHRmdjWGVhTFFocmZ5dXNHSHV6MVRwWXIxZGVtd0RkKzU1?=
 =?utf-8?B?d3BpM1pVSkNSQ3NaRVhjRXpGVTZLTm9hOWZ1NG00RGhEUUtuOEdQVXI5bitO?=
 =?utf-8?B?TXhweXNLaXRTUkJqZXBKMlBVYTlKQlBIZWg2K0NmS2IzN3UvTll4UExCeDRj?=
 =?utf-8?B?SENjenRRTFpNMW1BZnEyN1htRVJuQldQOUd3ODVFbXh5YlZUWmhJczkzS3Bx?=
 =?utf-8?B?RWpudHNxOU8wemhwS2tuY0dkY0s2bjgyRjB4dnNKN0JHK0d0Q0d4RG5nZnRw?=
 =?utf-8?B?ZDBsOS84ZWV1YXdDY2REQnA0bks1cThhc1Z4SHBlcklvQXJYcTl2SnN3RlJM?=
 =?utf-8?B?QytwaXVBakRzODd2ak9UNGpKaWZVbFRGc3RGU0hPeVVtakhLVmgwdzVlc3Fn?=
 =?utf-8?B?NWkxU3VyeURuclJvbEx6ZWpFODJ4bnhueDRYT0FRUXN3YkwwaCt6UXlMTm9m?=
 =?utf-8?B?VG42NnJZQit3ZWw2RGd0TldzVGl4dmJTUnlLakxXd3FHTzFiSVNybGNFZEMw?=
 =?utf-8?B?d0lFYVU1ekFqRVJuNFA1L3RTS3RUVmhCTjJSUjBGZGRZWTV0U1dLajlEMmtt?=
 =?utf-8?B?bVlKK0RkMEk3MDJDZk1idk5GVlRuNHFFMU5tbEhEemZlYzY0eEtTQTBjL1dI?=
 =?utf-8?B?Z2xiWGtHRERtOEl1ZklHdURrV2plcWk2M0VoUHNIUHhPaGYxRG5NQUgrM1o1?=
 =?utf-8?B?eFFSVTFudTlvZGl3Wi9YZUxuRlpRbUYrdEE1dEx0ampoVUJJRml1TGhsS2J6?=
 =?utf-8?B?TldHQUZBeGx0bDRSL0RjdzlzV0I1SzBiSC8yRzVCd2NUNmdJVUJiNytTV3N6?=
 =?utf-8?B?WWpvOW9IcndEdEFLRzAzVGp4VG1INUdGWllXUzFZRjFpN3lOaU5BL1MyRjdv?=
 =?utf-8?B?MndPT2FyNlBHajVGT3RqbUtsZjRVTDN3YllYNEwzZlFBakRoL0xaTHFsenVI?=
 =?utf-8?B?dHFwcDZwU0xCbFVWQXpINkNPRGM3bnpLV0YxQi9YS3loeldINEZZbmUveUk3?=
 =?utf-8?B?QkFoZVo3Y2Q3QUZpbUVOZWh1TWhqcHlJOCtFcVhQWDllT2djUFZzMk00SDZw?=
 =?utf-8?Q?FNZ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4863306a-b411-462e-269f-08dbcc0376a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 15:45:45.0427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9E1iJy4SkoEPLlIkatTvnD+4kN0JQ9Na7KA2Un9VEocBR71R/dvOp6mmTXdiaBat++3qWfRbIMoc+UgwJYGug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4465
X-Proofpoint-GUID: YlfIdyUBg4MnEsz-4MLDxhsHDAGjmNh7
X-Proofpoint-ORIG-GUID: YlfIdyUBg4MnEsz-4MLDxhsHDAGjmNh7
Subject: RE:  [PATCH 00/19] Cleanup for siw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=922
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130133
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDAwLzE5XSBDbGVhbnVwIGZvciBzaXcN
Cj4gDQo+IEhpLA0KPiANCj4gVGhpcyBzZXJpZXMgYWltIHRvIGNsZWFudXAgc2l3IGNvZGUsIHBs
ZWFzZSByZXZpZXcgYW5kIGNvbW1lbnQhDQo+IA0KPiBUaGFua3MsDQo+IEd1b3FpbmcNCj4gDQo+
IEd1b3FpbmcgSmlhbmcgKDE5KToNCj4gICBSRE1BL3NpdzogSW50cm9kdWNlIHNpd19nZXRfcGFn
ZQ0KPiAgIFJETUEvc2l3OiBJbnRyb2R1Y2Ugc2l3X3NyeF91cGRhdGVfc2tiDQo+ICAgUkRNQS9z
aXc6IFVzZSBpb3YuaW92X2xlbiBpbiBrZXJuZWxfc2VuZG1zZw0KPiAgIFJETUEvc2l3OiBSZW1v
dmUgZ290byBsYWJsZSBpbiBzaXdfbW1hcA0KPiAgIFJETUEvc2l3OiBSZW1vdmUgcmN1IGZyb20g
c2l3X3FwDQo+ICAgUkRNQS9zaXc6IE5vIG5lZWQgdG8gY2hlY2sgdGVybV9pbmZvLnZhbGlkIGJl
Zm9yZSBjYWxsDQo+ICAgICBzaXdfc2VuZF90ZXJtaW5hdGUNCj4gICBSRE1BL3NpdzogQWxzbyBn
b3RvIG91dF9zZW1fdXAgaWYgcGluX3VzZXJfcGFnZXMgcmV0dXJucyAwDQo+ICAgUkRNQS9zaXc6
IEZhY3RvciBvdXQgc2l3X2dlbmVyaWNfcnggaGVscGVyDQo+ICAgUkRNQS9zaXc6IEludHJvZHVj
ZSBTSVdfU1RBR19NQVhfSU5ERVgNCj4gICBSRE1BL3NpdzogQWRkIG9uZSBwYXJhbWV0ZXIgdG8g
c2l3X2Rlc3Ryb3lfY3B1bGlzdA0KPiAgIFJETUEvc2l3OiBJbnRyb2R1Y2Ugc2l3X2NlcF9zZXRf
ZnJlZV9hbmRfcHV0DQo+ICAgUkRNQS9zaXc6IEludHJvZHVjZSBzaXdfZnJlZV9jbV9pZA0KPiAg
IFJETUEvc2l3OiBTaW1wbGlmeSBzaXdfcXBfaWQyb2JqDQo+ICAgUkRNQS9zaXc6IFNpbXBsaWZ5
IHNpd19tZW1faWQyb2JqDQo+ICAgUkRNQS9zaXc6IENsZWFudXAgc2l3X2FjY2VwdA0KPiAgIFJE
TUEvc2l3OiBSZW1vdmUgc2l3X3NrX2Fzc2lnbl9jbV91cGNhbGxzDQo+ICAgUkRNQS9zaXc6IEZp
eCB0eXBvDQo+ICAgUkRNQS9zaXc6IE9ubHkgY2hlY2sgYXR0cnMtPmNhcC5tYXhfc2VuZF93ciBp
biBzaXdfY3JlYXRlX3FwDQo+ICAgUkRNQS9zaXc6IEludHJvZHVjZSBzaXdfZGVzdHJveV9jZXBf
c29jaw0KPiANCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmggICAgICAgfCAgIDkg
Ky0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMgICAgfCAxNTQgKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21h
aW4uYyAgfCAgMzAgKysrLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21lbS5j
ICAgfCAgMjIgKystLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXAuYyAgICB8
ICAgMiArLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYyB8ICA4NCAr
KysrKystLS0tLS0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYyB8
ICAzNCArKystLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3ZlcmJzLmMgfCAg
MjMgKy0tLQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNDIgaW5zZXJ0aW9ucygrKSwgMjE2IGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4zNS4zDQpIaSBHdW9xaW5nLA0KDQpJJ2xsIGhhdmUgYSBs
b29rIGxhdGVyIG5leHQgd2Vlay4gQ3VycmVudGx5IG9uIHZhY2F0aW9uLg0KVGhhbmtzLCBCZXJu
YXJkLg0K
