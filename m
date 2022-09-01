Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B855A8F3B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Sep 2022 09:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiIAHGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiIAHF7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 03:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0E6A4056;
        Thu,  1 Sep 2022 00:05:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2816pUGw012348;
        Thu, 1 Sep 2022 07:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=PJa6VY+x9ExtRlbLoUZ5momYotDf1x8P1TNB1tCLlR8=;
 b=r9AmGfBZXI4IdeiV2H3+57mBCH4DKqTik1fKduG4p1oKYq9f4J/Gqsjf4ruojVEVYnYW
 tOUMo1vikxvBgaSy8nCXD+VY33zOeuiaw/0Ue2kSaMGoJiNYWqlatFoEo7ALxqMGY7Be
 RAhrtLFZmYq/ZD9NukpNjTetu1T/g13E4Ky0jWKlk7jSkxnf0eJmnl5xziSjn1svhyxn
 HtEmYbu16jub8GwKuOxog+cba3qmgbbOSNfsIng5VjFR+0wf/sDsS0WEPJz6X046gNoq
 drTpc3qNXM7ci4iG2FqDCh15M0E1iX4Ne1vOHrZpfR5dSaYeCVYHtAWL1Yy0AXQ4q1oF 3w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jaqua8fer-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 07:05:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6oDFiHs6tWlTbkO6ODDXd/PoWNN/VI8yLQ5ZJpTH8OPpgSc0pe1aA+s+ytWJwCVgaO53ZQHOml3DOKDeHrLWRrHIT0xKUP249qUAElBhrbfxvqQyryEB+xHoVLUkR5+ACEhKxNpKwSH05dEftXByJ2GvTCX5vp86ljn3BsHDC77JammUP8xpG1n0lVTMRYBPShLmJTT7oPlQV4vvPd5RtYhFtCGgHhzSigVqdxgB/R2vB/WLk6PcYWHLqaPtbuLKzCHdO/JKAa6r8mnUxGCxlvy95FlF0PSH2MQqQQIqT9xLmKKvq7eAxQvERfXLzSb/0jUfUc2+MzjCHNeAbVMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJa6VY+x9ExtRlbLoUZ5momYotDf1x8P1TNB1tCLlR8=;
 b=PSYX3PSe8oVtscEIvUAfyTuqKWfT400jKNViE7OIEFZ7a4/ZWYd2THCNi3NynIh5/NIZXWDAvSZFhov3TpgdIKMOT2wfbLx+Mtiy9OhU+TcXzkZo8OtOMyhq6EBMEH8+HybIR7BOv47H1v1mINTzbp2qumL/eWPJ8DctFn4UVpoF/42AKVdTYicrCLUC4kOrx3uE5VX5TfzZkTbD+1s6X6HyR/V2JMFsFjR8EMA8xP2PAa5SyFmwNeelbNAlW93pFsrnQHY1A+T6Z05yPTMrPmKU+8asvCjcwUV/DcuforGJwT+bmHgBPonxAwarlaVL68xxEAYMdE0okusDy1uH9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by SN6PR1501MB2077.namprd15.prod.outlook.com (2603:10b6:805:10::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 07:05:05 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 07:05:05 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     jianghaoran <jianghaoran@kylinos.cn>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
Thread-Topic: [PATCH] RDMA/siw: Solve the error of compiling the 32BIT mips
 kernel when enable CONFIG_RDMA_SIW
Thread-Index: Adi90Sk0eVjrRSQWSMWwYVZJ6fgxsg==
Date:   Thu, 1 Sep 2022 07:05:05 +0000
Message-ID: <SA0PR15MB3919F42FFE3C2FBF09D08026997B9@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b02a2329-9a11-4b52-4bcb-08da8be84c22
x-ms-traffictypediagnostic: SN6PR1501MB2077:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QgoV9wDcVzgtrP9tPR2oFsCC/PDX4bni26gcrdsP5TefPJW2pLPwyWPauYybnF/RRG1TMfKysgkdancNu7epne5dcfvZMy4DbM1U7GpgWTB/FihMAg213jvSn3i3BB/XIu1rNg1+Q1bUNiYXmsTQ0Y0SzuRMsBdWHEEO4nuc45QXurHSXgp/6MzkysZqtPDF4FvSeg16xFhOgpsWs9J6mDUSecooIAYy4uEaA5lqG8pTiODcW6q0EMAkQCCRfw70MntHfxtbSHb2VIrxcx2pxMXqmXjbkHzvtQ3YHZ4UgVCzVCBVqnu8xrkZsGo8i3oywQQPuf/d5DAoW+1GBzNDNNf2Tg3dOlc1XF4U2S5PoqpMzvRRklccjJoZuk+jeUfAVtV2N2ApJ42Iv41a0KWmSlCNOXFX2pFpn3BrQfqBF65JDFuTjPQH+GgxQ5w80X7g3EF8bV2wO2J6Gvsd1v83wPIXovWnq3dz8JYeDrg+F6MRaKDimg1c3/jiJq4nSHFhjHms6h2LrLwpjCH380/MEjqgmLrOQzl4vFa1005kbzTV1I2sgOKY6xePK5SnXutJTh+abNuim0EAwT8gvUOYX76EoYfCNH6v90QZZrBzh+ZloCR037wmqNixMKm/gY+9x838eADZHor/P6cWCoegSvtr02hzzbTlEE3Fa9pXp8H59pbaj3//xcmgDtQQ4pYwq8CWAIVpZZO0pGa9li20JC1Cp+cFZJ6MAQKM7O1GvkY+ZmmGI17sVeZLRucqymh2u8vzFKyGSueCDpbK49GKnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(346002)(366004)(4326008)(8676002)(66556008)(64756008)(86362001)(66446008)(66946007)(76116006)(54906003)(6916009)(38070700005)(66476007)(316002)(6506007)(7696005)(83380400001)(53546011)(41300700001)(9686003)(186003)(122000001)(38100700002)(71200400001)(55016003)(478600001)(2906002)(8936002)(52536014)(5660300002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1F0S1QvMVc0UkZPQnNNZTQxTWMwYVQ5NjlWZS9kRlh3dkg0UE95RG5Wc05O?=
 =?utf-8?B?L1FWbE1Uc3F4ckhKM0hBNmZHemlMYXliUUNPL01rQ3hoT1RqSGxnbTdlR1pr?=
 =?utf-8?B?VDNCYkZoeitvZk56VUpWU2tSenUxVlhnT1BiQkhFclZ2bHlBK21kSGR2Y1Vp?=
 =?utf-8?B?c2JzcWRmcUJjbmI1TktCZFBUVzFSZkJsemloRk8zVlBvRTBKckxzTkZFWnpm?=
 =?utf-8?B?eHYxeXo4Zk9ZSzlMVGJIczhlU1FVT0diQ3JIWkdQbU9HS3ZheHNBTTh5QmJX?=
 =?utf-8?B?R2dPREY2dFRwUUgrbWpTS2FKWFNoaHN6b3MwZkFGMWtxaG9INUUvQWEwM20w?=
 =?utf-8?B?RDhKTTcyRE9CNXR5Wmtxc0JnaEJQeE5MR01iU1UyUktNc29LT0lGYTFsL1Ix?=
 =?utf-8?B?aklQK2cxVTNQRjEzdWlHMEJrekcrblM0WnZQTk55bXI0aHF6amhKWUlEUDJ3?=
 =?utf-8?B?Qm1uZzlpQ1N4b25TaUhpbC8vYWxCbHU3M2NML2tlMjQram9QWVNVcFJoR290?=
 =?utf-8?B?bXRZQlhaWC9GTUNoZW80VzJmbVFEdUplV3ZkSVJ5SHhVbGsvWFBUWk1TOHFI?=
 =?utf-8?B?SGZzZEpZQ2FMT3VoWVVTcFFQdXRCMjQ3RU1uaVBnRGNMQ2syd3kvN0VVODM4?=
 =?utf-8?B?QU5QRkxDMHF0Mml5eGdSMGNmck5XWjFLUUQ1UWRoS3JEbVdFOW1VdVFWUnpq?=
 =?utf-8?B?d1VlRlFlREpBL1ZCK0hHL1ByUVNZVlRFeUErS1dWTEd5OWoxQkxUeFFab3cv?=
 =?utf-8?B?blRTaHRWNHM4L2phUDdSYklYSkRsZEdLekJWYmN0eXBhdWhKc0d4RHgyYUNJ?=
 =?utf-8?B?VUg0VTgzNEtldGNmd1VMOE4vRUsvV2FETlBYOGY2RVIwdFpWdEhsdGRUc2lh?=
 =?utf-8?B?bXNxYW5NN0lUUEFkeFl6MWdPSEprMnZNdkQ4UnRVWjVueCttU3Q1ZzJ6SnFt?=
 =?utf-8?B?WWdRck5kZWowWTlsVjg5Y1FWUU1BdVBYend3QmIzMERKbS96ajNpaUZ5VmYy?=
 =?utf-8?B?cDd5TGJlL0V4aE9QbFlEMVlXWldocXIzUjFmK2ZmRFNrNkQxQXl3K3FxeEpI?=
 =?utf-8?B?by92Zlh1R3lyNll6V0l3eUNuZ0hjZERFRzlyajR1b0R2UnhrYW9pVU1zZjBh?=
 =?utf-8?B?aEo1Uk5qNytPWS8rRjhXS0VwanFwcWlpUGlxMkY1M1JvU3BvUWZkSDExRnBp?=
 =?utf-8?B?MS9pZDBBRkxLeDhxVHI4TXhiT3ZkOUQ4WE50Rm0vVG1XTVoxODE2MGFXdXpI?=
 =?utf-8?B?bDd5UHhMeERtb1VpN2dtM0wrd2crSlhZREhDZ3BmdVZJektYcUJFSWlYY3Y0?=
 =?utf-8?B?S0dTVzdBTlBrR0ppNjVzT1RtenI3Q3ZKVVM5MFp3MlpacFIrYk1wdkhIL21I?=
 =?utf-8?B?dEpoMlFacllUKzIzU2Fkem4xd2VPcE9GMmo1NCtqRWluaCtOVlNDVGZoam9v?=
 =?utf-8?B?MW5MOEgzYUkzTFRicyt1NVBwczl6TitKR2RiSlJPTnB6Mm5aRENhTFczZWo4?=
 =?utf-8?B?SmJsRHJ2QkRrci9RMnEvLzFNWUpDYTJ5WlNwbXpRdU1VVitSdXUzMldzajZ4?=
 =?utf-8?B?bXM1U1E1L29CLzAxSnQxekQ1enpLYVRnOG5vQ050ZmtGV2NMMmVIZEdrVkJF?=
 =?utf-8?B?RFZvRXhKcFpzV1ZTVkUxOUVEU2t1ZzJwZHBJRnJsM0VMTGxOR0ExdWd3UEUy?=
 =?utf-8?B?S0h0NWtlbjlKU3hqU3A0aTlPWXI2Q1hNdkNDK3ZKY3lYT3lrdlZTNmhhTjZl?=
 =?utf-8?B?R05wK2pSOGp4OHdvdVo5RnlsTURsNHl5aXBKUHdKM2lqajlDZlBCV08rdVJs?=
 =?utf-8?B?cTVvRnBrQkJQYkZsRW4vaW1LeWVUR21WSm9pTHZhSDJ1K21KVWhobGw5RFhP?=
 =?utf-8?B?ajdIUlMvbnFVUERCV3A3Zk9CemcwV2tSZnB4bFZEbDdZODNxanhOV2d0d0VR?=
 =?utf-8?B?VVdlNFhtSWU1WEhqaUdDWjJ4SWF5TDdGaUtYOS9tZlZ6WkU4VFdublF2SVJn?=
 =?utf-8?B?eS9FV2loMXgzY3ZMSkNFamE4QUtOb1M0RmtqQmxWbHE0SDY5dTIyWUxMMCtq?=
 =?utf-8?B?NjN3Qm14Nm4wYUhUajJPdkNyYmNWUFNKS1oxTlo1cFg0emNuZStDRmFWMDlp?=
 =?utf-8?B?UmlDNGRYRjJQejlRWXVCaEJOTEtFMnYwOWhWT3FiSjllS1pMWDJENmFEMXJ1?=
 =?utf-8?Q?T1zgM51SxYp6PM+N9EkgzgBuXA485SrbqIhCddVa3pwi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02a2329-9a11-4b52-4bcb-08da8be84c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 07:05:05.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzfXY5VK1PNIabUpMRkKRw8SWfgj542Ktv8rjYchjFkKzYPMHQ5NKzjhgcYB/m/sA62daEoV268LUQGz0oG4vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2077
X-Proofpoint-ORIG-GUID: Ni9wbrpkVetUF1IvMGE37ea9QWRunFic
X-Proofpoint-GUID: Ni9wbrpkVetUF1IvMGE37ea9QWRunFic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogamlhbmdoYW9yYW4gPGpp
YW5naGFvcmFuQGt5bGlub3MuY24+DQo+IFNlbnQ6IFRodXJzZGF5LCAxIFNlcHRlbWJlciAyMDIy
IDA3OjUyDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6
IGpnZ0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnOyBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFM
XSBbUEFUQ0hdIFJETUEvc2l3OiBTb2x2ZSB0aGUgZXJyb3Igb2YgY29tcGlsaW5nIHRoZQ0KPiAz
MkJJVCBtaXBzIGtlcm5lbCB3aGVuIGVuYWJsZSBDT05GSUdfUkRNQV9TSVcNCj4gDQo+IGNyb3Nz
LWNvbXBpbGF0aW9uIGVudmlyb25tZW5077yaDQo+IHVidW50dSAyMC4wNA0KPiBtaXBzLWxpbnV4
LWdudS1nY2MgKFVidW50dSAxMC4zLjAtMXVidW50dTF+MjAuMDQpIDEwLjMuMA0KPiANCj4gZ2Vu
ZXJhdGUgYSBjb25maWd1cmF0aW9uIGZpbGUgYnkgbWFrZSByYW5kY29uZmlnOg0KPiBDT05GSUdf
MzJCSVQ9eQ0KPiBDT05GSUdfUkRNQV9TSVc9eQ0KPiANCj4gdGhlIGVycm9yIG1lc3NhZ2UgYXMg
Zm9sbG93c++8mg0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vYXJjaC9taXBzL2luY2x1ZGUv
YXNtL3BhZ2UuaDoyNzAsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9hcmNoL21pcHMvaW5j
bHVkZS9hc20vaW8uaDoyOSwNCj4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2FyY2gvbWlwcy9p
bmNsdWRlL2FzbS9tbWlvd2IuaDo1LA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi4vaW5jbHVk
ZS9saW51eC9zcGlubG9jay5oOjY0LA0KPiAgICAgICAgICAgICAgICAgIGZyb20gLi4vaW5jbHVk
ZS9saW51eC93YWl0Lmg6OSwNCj4gICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGlu
dXgvbmV0Lmg6MTksDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF90eC5jOjg6DQo+IC4uL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X3FwX3R4LmM6IEluIGZ1bmN0aW9uIOKAmHNpd190eF9oZHTigJk6DQo+IC4uL2FyY2gvbWlw
cy9pbmNsdWRlL2FzbS9wYWdlLmg6MjU1OjUzOiBlcnJvcjogY2FzdCB0byBwb2ludGVyIGZyb20g
aW50ZWdlcg0KPiBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJvcj1pbnQtdG8tcG9pbnRlci1jYXN0
XQ0KPiAgIDI1NSB8ICNkZWZpbmUgdmlydF90b19wZm4oa2FkZHIpICAgIFBGTl9ET1dOKHZpcnRf
dG9fcGh5cygodm9pZA0KPiAqKShrYWRkcikpKQ0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IC4uL2luY2x1ZGUvYXNtLWdl
bmVyaWMvbWVtb3J5X21vZGVsLmg6MTg6NDE6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8N
Cj4g4oCYX19wZm5fdG9fcGFnZeKAmQ0KPiAgICAxOCB8ICNkZWZpbmUgX19wZm5fdG9fcGFnZShw
Zm4pIChtZW1fbWFwICsgKChwZm4pIC0gQVJDSF9QRk5fT0ZGU0VUKSkNCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+DQo+IC4uL2FyY2gvbWlwcy9p
bmNsdWRlL2FzbS9wYWdlLmg6MjU1OjMxOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8NCj4g
4oCYUEZOX0RPV07igJkNCj4gICAyNTUgfCAjZGVmaW5lIHZpcnRfdG9fcGZuKGthZGRyKSAgICBQ
Rk5fRE9XTih2aXJ0X3RvX3BoeXMoKHZvaWQNCj4gKikoa2FkZHIpKSkNCj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fg0KPiAuLi9hcmNoL21pcHMvaW5jbHVk
ZS9hc20vcGFnZS5oOjI1Njo0MTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvDQo+IOKAmHZp
cnRfdG9fcGZu4oCZDQo+ICAgMjU2IHwgI2RlZmluZSB2aXJ0X3RvX3BhZ2Uoa2FkZHIpIHBmbl90
b19wYWdlKHZpcnRfdG9fcGZuKGthZGRyKSkNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn4NCj4gLi4vZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfcXBfdHguYzo1Mzg6MjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZg0KPiBtYWNy
byDigJh2aXJ0X3RvX3BhZ2XigJkNCj4gICA1MzggfCAgICAgcGFnZV9hcnJheVtzZWddID0gdmly
dF90b19wYWdlKHZhICYgUEFHRV9NQVNLKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgXn5+fn5+fn5+fn5+DQo+IGNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJy
b3JzDQo+IG1ha2VbNV06ICoqKiBbLi4vc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoyNDk6DQo+IGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4Lm9dIEVycm9yIDENCj4gbWFrZVs0XTog
KioqIFsuLi9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NTogZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npd10NCj4gRXJyb3IgMg0KPiBtYWtlWzNdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQ6NDY1OiBkcml2ZXJzL2luZmluaWJhbmQvc3ddIEVycm9yIDINCj4gbWFrZVszXTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBrMmNpIDxr
ZXJuZWwtYm90QGt5bGlub3MuY24+DQo+IFNpZ25lZC1vZmYtYnk6IGppYW5naGFvcmFuIDxqaWFu
Z2hhb3JhbkBreWxpbm9zLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcv
c2l3X3FwX3R4LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npd19xcF90eC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0K
PiBpbmRleCAxZjRlNjAyNTc3MDAuLjU1ZWQwYzI3ZjQ0OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IEBAIC01MzMsNyArNTMzLDcgQEAgc3RhdGljIGludCBz
aXdfdHhfaGR0KHN0cnVjdCBzaXdfaXdhcnBfdHggKmNfdHgsIHN0cnVjdA0KPiBzb2NrZXQgKnMp
DQo+ICAJCQkJCWt1bm1hcF9sb2NhbChrYWRkcik7DQo+ICAJCQkJfQ0KPiAgCQkJfSBlbHNlIHsN
Cj4gLQkJCQl1NjQgdmEgPSBzZ2UtPmxhZGRyICsgc2dlX29mZjsNCj4gKwkJCQl1bnNpZ25lZCBs
b25nIHZhID0gc2dlLT5sYWRkciArIHNnZV9vZmY7DQo+IA0KDQpXZSBkaXNjdXNzZWQgc2FtZSB0
aGluZyBhIGZldyBkYXlzIGFnbyAtIHNlZSBQQVRDSCBmcm9tIExpbnVzOg0KJ1tQQVRDSF0gUkRN
QS9zaXc6IFBhc3MgYSBwb2ludGVyIHRvIHZpcnRfdG9fcGFnZSgpJw0KDQpXaGlsZSBoZSBzdWdn
ZXN0ZWQgY2FzdGluZywgSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2hhbmdlDQondTY0
JyB0byAndWludHB0cl90Jy4gSSdkIHByZWZlciAndWludHB0cl90JyBvdmVyICd1bnNpZ25lZCBs
b25nJw0KZm9yIHJlYWRhYmlsaXR5IC0tIHNpbmNlIHdlIGhvbGQgYSBwb2ludGVyLg0KSXQgd291
bGQgYWxzbyBzaW1wbGlmeSBhIGNhc3Qgb2YgdmEgYSBmZXcgbGluZXMgZG93biBpbg0KdmlydF90
b19wYWdlKCkuDQoNCkNvdWxkIG9uZSBvZiB5b3UgdHdvIHJlLXNlbmQ/DQoNClRoYW5rcyBKaWFu
Z2hhb3JhbiENCg0KQmVybmFyZC4NCg0KPiAgCQkJCXBhZ2VfYXJyYXlbc2VnXSA9IHZpcnRfdG9f
cGFnZSh2YSAmIFBBR0VfTUFTSyk7DQo+ICAJCQkJaWYgKGRvX2NyYykNCj4gLS0NCj4gMi4yNS4x
DQoNCg==
