Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47077E0148
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347826AbjKCKTU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 06:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347710AbjKCKTT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 06:19:19 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B601D44
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 03:19:15 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A3AGO0v021561;
        Fri, 3 Nov 2023 10:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=x0ygaqUmtaC3QgrZx9ylKz9duEZ2Y9Ly3zLrpqaAoXc=;
 b=D2ScQf8ApoHBn57jC3I55TuvcUom4FtXfrH9N+L9MBRgHjVW2Ca0/7SvDl8Z9tmYnKRg
 nxHuHS7aVn8O+tTqFmrbhtZ22EgLGyibcOsRFC2LO6j0fOKPz3D5TI6Yk++DbpLuaw1L
 rE9bIwm/SQo5eLVXLzTrxtBfKS/BydxNC9PRxi9NT+2ls7ljOx5OhFkSft/PNo8+fynP
 I8E5AcbNJjr/xWPn1zTeF4AHpPiaSdXh7Grd8GXHeb7CNKS/ChvuJmjbKTBdFbVhch3a
 5O6uSIbXFY/u411KM/ADlkY+YrH6JWdsxTdRn2i9ubEzHaPBIjOMnEbj6oBXCrXEdcBK Jw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4xdw0v01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 10:18:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZwkyeg7LRs4HZPgGHsohYWTeVkheaNQB9IxzpdUBN4u0nIHea/7VnUZVQm25SbiQErDtD0op7elHFi0KNy/2uFcJ5z/0j3QlxAnXjDjG135BIIAl1cCsI0ZauwjcJcVyb3Em1UyRBvyVi/aefQTJC1+g1BtYYGRTCy1mP0znFGdGfHdfJiIOfhi1Hj2Wr+EGeSOhADtdVTgswdblutM/cZ9Oe0skf8VSTQdATelVAYkkMLOgdw2m9efsXjK4XYVm3NdkU5NLriTTChmltpddMfbKBsXZvCiq7iSYo2lGzuY0IdcET7rjQnmNDFCOE3XBN6VS5/8Vp7YEuFnMfjWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0ygaqUmtaC3QgrZx9ylKz9duEZ2Y9Ly3zLrpqaAoXc=;
 b=NWEVlT0fD5JjJGKCtrpkmduzTZcllz8tESYXxnbbacb+lerNBdGVHC5o4Q8F34Jf0qZZmyvH9z/LZLg/il7q+7ChqRMuYR9GnLKOrAijnSwh1w87oaIMHi7YhrW9UWN4rRoKrwtffFItxl7iMlrXetG+zqgvLSQVTd2lPZ+tiN0ZUBqyWQwlCAHpU6bCDuyaKuNcOHcGIhEqDHPQfkVSIflROZyBfjJGqlvI29v/VgOHV6cIoF7KpVOTnEA+l1ZbCpeIlhlMFcFtTmPNwdoZppZWpzDbWosStVSVGLvDjGF2M4K5gXtdkkvrHddnnIhZxsM5Y5M81x0sHJ7+acxZ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DS0PR15MB6229.namprd15.prod.outlook.com (2603:10b6:8:162::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Fri, 3 Nov
 2023 10:18:51 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Fri, 3 Nov 2023
 10:18:51 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Maxim Samoylov <max7255@meta.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: RE: Re: [PATCH v2] IB: rework memlock limit handling code
Thread-Topic: Re: [PATCH v2] IB: rework memlock limit handling code
Thread-Index: AQHaDj8kshpotTMs60OG/wJZoyd/xg==
Date:   Fri, 3 Nov 2023 10:18:51 +0000
Message-ID: <SN7PR15MB575594FE0EB633F0A7878A0C99A5A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
 <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
 <20231102123216.GF5885@unreal>
In-Reply-To: <20231102123216.GF5885@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DS0PR15MB6229:EE_
x-ms-office365-filtering-correlation-id: 8b0290cb-41be-4360-8758-08dbdc56469f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjaCQo9/fS/NXuygmlv3uJbWuejU1eWyY98xGd4rXuHt5TApv6WmgdlcL16B0YqpGv/InZruZmR4u+ngzVhLVOmURBrl3XgRZWP0cd6aTKzGn/G+i45SPphyTpnEzozki5ag4zX2dRq+WhwHSmLtJTyoc/aorcgvzHAwN5fGhaKliv9MAH9hXldWJHeWD48SY3MnE/DizFjIjThcYSIgIpvI3p5B3rutUPqKoGx/kgiNTBwEmkTRsL3RWmQkPLPGz5FPqlSedEC1J2jl0EcbODC6RoHTtOlKplywcpdMTfxTou2zSzocCjFn/DGqMcMK5y8Qi8MSg7DFPqS1XoQRDziX1NiczJIUrjOJScWNlq8zaThZVqt5wRL3sFliNK0RNL0JX1Avpq28v2BwI2zXCbLHMcTeTSmC2Oblair7MfQYA2Vug/mDiTVFfR/1ltAs1jAL9Q60KCPOKxNxHL+0e05r2WPM4t0Fge3Ug0ajJJ2zn20X+bY1zxBgpYDTcI9kiDV8w+8gXBIo9edJ1GPbKwEKLIrj60xKdITPkhFjrsRbCyg6Dxk5Csme61nekSGVusN4Fd33FzuEHe7UG4Oyd/acsEUtxAgNDnqFOAGY5Tt1tg+91U/4COfIKT0R7NHh4Zcf63BJQvAQ4lK9xlc3DkWzHcONGhsDcTAxOsoyWvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(54906003)(76116006)(66556008)(64756008)(5660300002)(66476007)(316002)(8676002)(55016003)(4326008)(2906002)(8936002)(66446008)(66946007)(110136005)(71200400001)(478600001)(9686003)(53546011)(41300700001)(7696005)(6506007)(83380400001)(38070700009)(33656002)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVRWMTc5U0luaHR1NXlGa1RZS2RTdW9ZU1k1a0dTNW5COWd3TmlBMitBOUZD?=
 =?utf-8?B?bDJzbXRUemZBV3hmWkgxVlpyeXZqWXpublh2UlMvWDVxTDBmQ3BsaStuZk5L?=
 =?utf-8?B?OGZDOC9aZ0VoMjhjZ2FTaytWUzh0WVhSTlQxbmY5VUlqdlBRV0RKUTVsQkFn?=
 =?utf-8?B?ZmkwYVl0Nk16WEVoNVFwSXRyRE1HS1Erb1lvcGJtc0M3dUpNcUMxZFhiZVFD?=
 =?utf-8?B?N05rbE1Yc3NJcnNTOUI3S2RoKyt6Q0dFcExVWkZxUlA0SUtOaVBtWFl6OGM5?=
 =?utf-8?B?TlRSOXIzTzFLNlBzT3laN2d1WVFDWGsrNUZNS1ZrTFI0WlJhTkUyREpLZDFZ?=
 =?utf-8?B?OTh2VXJLY1VXNFliSXM2cFFpeFNvY0RrY2EyQ0drMCtsMWxsWmZrb0FZeENl?=
 =?utf-8?B?bXlzUmtTaGxnWTVOSFU5ZG5GTy80THlpa0FVREttOWhjZ3FsUENvV1NYaU43?=
 =?utf-8?B?RnAvSDlWTmR2NzlCSzBiOExhd3YyWFdaK0Y0bTlXSEFuUDJHQUwvMnVCNkJR?=
 =?utf-8?B?NlFVSUNaNEppUnJxeEhkaEU3OFR2c2pJc0x2d1FZcThtYUdEMytDNG5wSFB3?=
 =?utf-8?B?NmliODZPRTlrN3EyRUtiVmlpOGZIOUVRL24zOU5lSE5STjVOSWovNmpueTdS?=
 =?utf-8?B?THFEU2NOUnM4dnpOaUdWS1dTSGN1VEZOYVo5MDBhMjlNalg4eEQrUUR1QVdW?=
 =?utf-8?B?VUoxZnFCYlhYaGxkVWFkellMNmcwRlI5RXQyNmYvQWpFclc4MzNITEJDbXBH?=
 =?utf-8?B?SFdNQ2QwcUpMMHgvMUpoaWZxNGJmaFpid3lxYjBLQjQ4WHpQS1FwcUdnUUdN?=
 =?utf-8?B?d2pqUGlqdFJFUWpML0tjTnNUKzhuM2p6akUwTjRZTVVQTG5UeDEzWFQ0YWVI?=
 =?utf-8?B?WW5vUGFob1lwU1p2YXh1a1JqSTlqZTFoK2RLSmM5TUFHU3pIWEpPOWp5VitQ?=
 =?utf-8?B?UWZvZ2JOejVuUkY3YWxrMVdrU0V1cHBiRTVISEQvSTZKMnp1aTQ5czIyY2dR?=
 =?utf-8?B?ZGE3ZFZRWXpOcmFqcXh2NXEvcnpERjFhRzFZNWphNS9wRkxwZ3lLblpsQnZu?=
 =?utf-8?B?NU83Z2U0WEt6MjhLajhWbUNxaTBwRmsyT3dtMC9PYnl3RnlnTUlDb1puZktn?=
 =?utf-8?B?ZzVUaEdUUEpHQzIzOGxpR3hNNkpCQTM1QytCbkF2ZWhTOTRONnphMU9GNTY2?=
 =?utf-8?B?aUNJTWVqeUtaOEVQa3Z4Y1VVbFNIeFZaeUVpM1VlQVVSZVNLVVd3RGtPOVNu?=
 =?utf-8?B?cVVVSzdXb0NVZVZNNk92RlhhM1FRNGlMdy9xZmxwN2R1MFI3cTNtblNqWUZ0?=
 =?utf-8?B?eXRWZGNiYUVHQk56ZjJRemp6aDl3aXdDM1hkb2hnRm5uQzVwSE9paEI5SUQ3?=
 =?utf-8?B?eE5pMEJMREZJbmQ5U2Q4WXlVYU9jZ3lzbEw1TjFjd0JnWWVRMmFJWVp0RnFt?=
 =?utf-8?B?SVptLzEwdFJ2dyszNS9DR3BIcjFiTEVTWGFiWVA4QkpEVHZuNCtjeStOaDBU?=
 =?utf-8?B?QXhZY2NpU2psdlVTNHdrZFpDL2sra29QbnpIYk9TYmwyWGwveEo1eVlWUC9P?=
 =?utf-8?B?ektxMGd1b3poeW9HMG40K2tRck1xdWtEUDAwZ1NlSzBHc2hINkVYQW1tTDJp?=
 =?utf-8?B?TmNnZ3E1Vi9GaHo4VEtXdUdheEVGdk9DbSthRHlnTDN2dnc3Z1BFbEpmMDVm?=
 =?utf-8?B?YVhBTjNmK05sY21WME0yNGxQSllxR0o0VTUrYkRQaUxtOXlVNHJZSFBveHZK?=
 =?utf-8?B?TFpVN3dXVGprc0pwbUprckdjMzM3VHVnZzdTSmt1bE9uSFcydUJyUG5FRUNQ?=
 =?utf-8?B?eWxKQ2VTNElwUk9jUU45ZG9qdWIxNzJvMkVCQkwzS01qdmlRTUtpNFQ2Nytx?=
 =?utf-8?B?Yks3UjlpNGRVcUhKa2VlbjlHWGdoeFFSQnBFeTg5ZTQ5UzdFTWhCWFNsOFIw?=
 =?utf-8?B?Q04xaTlQNTVldmJZbHJaUUwrbmR2NUszcXBjNXlobGFEdVFRa3RxMDc4eEpo?=
 =?utf-8?B?Tnh4d3V6UWl6Y3dQRWY5OFFBcFlWOGZtVm9tSC9DRXIxbzB6TkZwdkNMbzFM?=
 =?utf-8?B?ekR6clNhMHVyeDZYQmNOdk93MG4rL3JWR0VwdWplTzVDSDJSeGpScFNXeGlE?=
 =?utf-8?B?RGxMK2JzNFFwYlA1cVZIRG5uOVpGSTViamF6SStEUWZTNlBYWXpDazhCYmo0?=
 =?utf-8?Q?T3UoLS8MHIWR3csb7iOxLdixBV8vS4EM5AfmbR1q2+XR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0290cb-41be-4360-8758-08dbdc56469f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 10:18:51.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJ+BBIW0dyExa+C+oFEr0THs9BlZ3WwA7De3HXqHh3mfnGznbrK6oXsJW+1dQXukvaMbQedKdKCUDX05K1G9dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6229
X-Proofpoint-GUID: EYrE5L4qjwm8IRBOPmeFKstmeowJErWB
X-Proofpoint-ORIG-GUID: EYrE5L4qjwm8IRBOPmeFKstmeowJErWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=747 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2311030085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyLCAyMDIzIDE6
MzIgUE0NCj4gVG86IE1heGltIFNhbW95bG92IDxtYXg3MjU1QG1ldGEuY29tPjsgQmVybmFyZCBN
ZXR6bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+OyBEZW5uaXMgRGFsZXNzYW5kcm8NCj4gPGRl
bm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4NCj4gQ2M6IEd1b3FpbmcgSmlh
bmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2PjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgQ2hyaXN0aWFuIEJlbnZlbnV0aSA8
YmVudmVAY2lzY28uY29tPjsNCj4gVmFkaW0gRmVkb3JlbmtvIDx2YWRpbS5mZWRvcmVua29AbGlu
dXguZGV2Pg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjJdIElCOiByZXdvcmsg
bWVtbG9jayBsaW1pdCBoYW5kbGluZyBjb2RlDQo+IA0KPiBPbiBUdWUsIE9jdCAzMSwgMjAyMyBh
dCAwMTozMDoyN1BNICswMDAwLCBNYXhpbSBTYW1veWxvdiB3cm90ZToNCj4gPiBPbiAyMy8xMC8y
MDIzIDA3OjUyLCBMZW9uIFJvbWFub3Zza3kgd3JvdGU6DQo+ID4gPiBPbiBNb24sIE9jdCAyMywg
MjAyMyBhdCAwOTo0MDoxNkFNICswODAwLCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiA+ID4+DQo+
ID4gPj4NCj4gPiA+PiBPbiAxMC8xNS8yMyAxNzoxOSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOg0K
PiA+ID4+PiBPbiBUaHUsIE9jdCAxMiwgMjAyMyBhdCAwMToyOToyMUFNIC0wNzAwLCBNYXhpbSBT
YW1veWxvdiB3cm90ZToNCj4gPiA+Pj4+IFRoaXMgcGF0Y2ggcHJvdmlkZXMgdGhlIHVuaWZvcm0g
aGFuZGxpbmcgZm9yIFJMSU1fSU5GSU5JVFkgdmFsdWUNCj4gPiA+Pj4+IGFjcm9zcyB0aGUgaW5m
aW5pYmFuZC9yZG1hIHN1YnN5c3RlbS4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBDdXJyZW50bHkgaW4g
c29tZSBjYXNlcyB0aGUgaW5maW5pdHkgY29uc3RhbnQgaXMgdHJlYXRlZA0KPiA+ID4+Pj4gYXMg
YW4gYWN0dWFsIGxpbWl0IHZhbHVlLCB3aGljaCBjb3VsZCBiZSBtaXNsZWFkaW5nLg0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IExldCdzIGFsc28gcHJvdmlkZSB0aGUgc2luZ2xlIGhlbHBlciB0byBjaGVj
ayBhZ2FpbnN0IHByb2Nlc3MNCj4gPiA+Pj4+IE1FTUxPQ0sgbGltaXQgd2hpbGUgcmVnaXN0ZXJp
bmcgdXNlciBtZW1vcnkgcmVnaW9uIG1hcHBpbmdzLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFNpZ25l
ZC1vZmYtYnk6IE1heGltIFNhbW95bG92PG1heDcyNTVAbWV0YS5jb20+DQo+ID4gPj4+PiAtLS0N
Cj4gPiA+Pj4+DQo+ID4gPj4+PiB2MSAtPiB2MjogcmV3cml0dGVuIGNvbW1pdCBtZXNzYWdlLCBy
ZWJhc2VkIG9uIHJlY2VudCB1cHN0cmVhbQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+ICAgIGRyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL3VtZW0uYyAgICAgICAgICAgICB8ICA3ICsrLS0tLS0NCj4gPiA+Pj4+
ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3VzZXJfcGFnZXMuYyB8ICA3ICsrKy0t
LS0NCj4gPiA+Pj4+ICAgIGRyaXZlcnMvaW5maW5pYmFuZC9ody91c25pYy91c25pY191aW9tLmMg
ICB8ICA2ICsrLS0tLQ0KPiA+ID4+Pj4gICAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdf
bWVtLmMgICAgICAgIHwgIDYgKysrLS0tDQo+ID4gPj4+PiAgICBkcml2ZXJzL2luZmluaWJhbmQv
c3cvc2l3L3Npd192ZXJicy5jICAgICAgfCAyMyArKysrKysrKysrLS0tLS0tLQ0KPiAtLS0tLQ0K
PiA+ID4+Pj4gICAgaW5jbHVkZS9yZG1hL2liX3VtZW0uaCAgICAgICAgICAgICAgICAgICAgIHwg
MTEgKysrKysrKysrKysNCj4gPiA+Pj4+ICAgIDYgZmlsZXMgY2hhbmdlZCwgMzEgaW5zZXJ0aW9u
cygrKSwgMjkgZGVsZXRpb25zKC0pDQo+ID4gPj4+IDwuLi4+DQo+ID4gPj4+DQo+ID4gPj4+PiBA
QCAtMTMyMSw4ICsxMzIyLDggQEAgc3RydWN0IGliX21yICpzaXdfcmVnX3VzZXJfbXIoc3RydWN0
IGliX3BkDQo+ICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiA+ID4+Pj4gICAgCXN0cnVjdCBz
aXdfdW1lbSAqdW1lbSA9IE5VTEw7DQo+ID4gPj4+PiAgICAJc3RydWN0IHNpd191cmVxX3JlZ19t
ciB1cmVxOw0KPiA+ID4+Pj4gICAgCXN0cnVjdCBzaXdfZGV2aWNlICpzZGV2ID0gdG9fc2l3X2Rl
dihwZC0+ZGV2aWNlKTsNCj4gPiA+Pj4+IC0NCj4gPiA+Pj4+IC0JdW5zaWduZWQgbG9uZyBtZW1f
bGltaXQgPSBybGltaXQoUkxJTUlUX01FTUxPQ0spOw0KPiA+ID4+Pj4gKwl1bnNpZ25lZCBsb25n
IG51bV9wYWdlcyA9DQo+ID4gPj4+PiArCQkoUEFHRV9BTElHTihsZW4gKyAoc3RhcnQgJiB+UEFH
RV9NQVNLKSkpID4+IFBBR0VfU0hJRlQ7DQo+ID4gPj4+PiAgICAJaW50IHJ2Ow0KPiA+ID4+Pj4g
ICAgCXNpd19kYmdfcGQocGQsICJzdGFydDogMHglcEssIHZhOiAweCVwSywgbGVuOiAlbGx1XG4i
LA0KPiA+ID4+Pj4gQEAgLTEzMzgsMTkgKzEzMzksMTUgQEAgc3RydWN0IGliX21yICpzaXdfcmVn
X3VzZXJfbXIoc3RydWN0IGliX3BkDQo+ICpwZCwgdTY0IHN0YXJ0LCB1NjQgbGVuLA0KPiA+ID4+
Pj4gICAgCQlydiA9IC1FSU5WQUw7DQo+ID4gPj4+PiAgICAJCWdvdG8gZXJyX291dDsNCj4gPiA+
Pj4+ICAgIAl9DQo+ID4gPj4+PiAtCWlmIChtZW1fbGltaXQgIT0gUkxJTV9JTkZJTklUWSkgew0K
PiA+ID4+Pj4gLQkJdW5zaWduZWQgbG9uZyBudW1fcGFnZXMgPQ0KPiA+ID4+Pj4gLQkJCShQQUdF
X0FMSUdOKGxlbiArIChzdGFydCAmIH5QQUdFX01BU0spKSkgPj4NCj4gUEFHRV9TSElGVDsNCj4g
PiA+Pj4+IC0JCW1lbV9saW1pdCA+Pj0gUEFHRV9TSElGVDsNCj4gPiA+Pj4+IC0JCWlmIChudW1f
cGFnZXMgPiBtZW1fbGltaXQgLSBjdXJyZW50LT5tbS0+bG9ja2VkX3ZtKSB7DQo+ID4gPj4+PiAt
CQkJc2l3X2RiZ19wZChwZCwgInBhZ2VzIHJlcSAlbHUsIG1heCAlbHUsIGxvY2sgJWx1XG4iLA0K
PiA+ID4+Pj4gLQkJCQkgICBudW1fcGFnZXMsIG1lbV9saW1pdCwNCj4gPiA+Pj4+IC0JCQkJICAg
Y3VycmVudC0+bW0tPmxvY2tlZF92bSk7DQo+ID4gPj4+PiAtCQkJcnYgPSAtRU5PTUVNOw0KPiA+
ID4+Pj4gLQkJCWdvdG8gZXJyX291dDsNCj4gPiA+Pj4+IC0JCX0NCj4gPiA+Pj4+ICsJaWYgKCFp
Yl91bWVtX2NoZWNrX3JsaW1pdF9tZW1sb2NrKG51bV9wYWdlcyArIGN1cnJlbnQtPm1tLQ0KPiA+
bG9ja2VkX3ZtKSkgew0KPiA+ID4+Pj4gKwkJc2l3X2RiZ19wZChwZCwgInBhZ2VzIHJlcSAlbHUs
IG1heCAlbHUsIGxvY2sgJWx1XG4iLA0KPiA+ID4+Pj4gKwkJCQludW1fcGFnZXMsIHJsaW1pdChS
TElNSVRfTUVNTE9DSyksDQo+ID4gPj4+PiArCQkJCWN1cnJlbnQtPm1tLT5sb2NrZWRfdm0pOw0K
PiA+ID4+Pj4gKwkJcnYgPSAtRU5PTUVNOw0KPiA+ID4+Pj4gKwkJZ290byBlcnJfb3V0Ow0KPiA+
ID4+Pj4gICAgCX0NCj4gPiA+Pj4gU29ycnkgZm9yIGxhdGUgcmVzcG9uc2UsIGJ1dCB3aHkgZG9l
cyB0aGlzIGh1bmsgZXhpc3QgaW4gZmlyc3QgcGxhY2U/DQoNCg0KSWYgdXNpbmcgaWJfdW1lbV9n
ZXQoKSBmb3Igc2l3LCBhcyBJIHNlbnQgYXMgZm9yLW5leHQNCnBhdGNoIHllc3RlcmRheSwgd2Ug
Y2FuIGRyb3AgdGhhdCBsb2dpYyBjb21wbGV0ZWx5LCBzaW5jZSB3ZSBub3cNCmhhdmUgaXQgaW4g
aWJfdW1lbV9nZXQoKS4gSXQgd2FzIG9ubHkgdGhlcmUgYmVjYXVzZSBvZiBub3QNCnVzaW5nIGli
X3VtZW1fZ2V0KCkuDQoNCkkgY2FuIHJlc2VuZCBteSBwZW5kaW5nIGZvci1uZXh0IHBhdGNoIGFz
IGEgcGF0Y2ggdG8gY3VycmVudCwNCmFsc28gcmVtb3ZpbmcgbWVtbG9jayBjaGVjayAoSSBzaW1w
bHkgZm9yZ290IHRvIHJlbW92ZSBpdCkuDQpOb3Qgc3VyZSBpZiBpdCB3b3VsZCBvYnNvbGV0ZSB0
aGlzIHBhdGNoIGhlcmUgY29tcGxldGVseS4NCkxlb24sIHBsZWFzZSBhZHZpc2UuDQoNCk90aGVy
d2lzZToNCg0KQWNrZWQtYnk6IEJlcm5hcmQgTWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0K
DQoNCj4gPiA+Pj4NCj4gPg0KPiA+IFRyYWlsaW5nIG5ld2xpbmUsIHdpbGwgZGVmaW5pdGVseSBk
cm9wIGl0Lg0KPiA+DQo+ID4gPj4+PiArDQo+ID4gPj4+PiAgICAJdW1lbSA9IHNpd191bWVtX2dl
dChzdGFydCwgbGVuLCBpYl9hY2Nlc3Nfd3JpdGFibGUocmlnaHRzKSk7DQo+ID4gPj4+IFRoaXMg
c2hvdWxkIGJlIGliX3VtZW1fZ2V0KCkuDQo+ID4gPj4NCj4gPiA+PiBJTU8sIGl0IGRlc2VydmVz
IGEgc2VwYXJhdGUgcGF0Y2gsIGFuZCByZXBsYWNlIHNpd191bWVtX2dldCB3aXRoDQo+IGliX3Vt
ZW1fZ2V0DQo+ID4gPj4gaXMgbm90IHN0cmFpZ2h0Zm9yd2FyZCBnaXZlbiBzaXdfbWVtIGhhcyB0
d28gdHlwZXMgb2YgbWVtb3J5IChwYmwgYW5kDQo+IHVtZW0pLg0KPiA+ID4NCj4gPiA+IFRoZSB0
aGluZyBpcyB0aGF0IG9uY2UgeW91IGNvbnZpbmNlIHlvdXJzZWxmIHRoYXQgU0lXIHNob3VsZCB1
c2UNCj4gaWJfdW1lbV9nZXQoKSwNCj4gPiA+IHRoZSBzYW1lIHF1ZXN0aW9uIHdpbGwgYXJpc2Ug
Zm9yIG90aGVyIHBhcnRzIG9mIHRoaXMgcGF0Y2ggd2hlcmUNCj4gPiA+IGliX3VtZW1fY2hlY2tf
cmxpbWl0X21lbWxvY2soKSBpcyB1c2VkLg0KPiA+ID4NCj4gPiA+IEFuZCBpZiB3ZSBlbGltaW5h
dGUgdGhlbSBhbGwsIHRoZXJlIHdvbid0IGJlIGEgbmVlZCBmb3IgdGhpcyBuZXcgQVBJDQo+IGNh
bGwgYXQgYWxsLg0KPiA+ID4NCj4gPiA+IFRoYW5rcw0KPiA+ID4NCj4gPg0KPiA+IEhpIQ0KPiA+
DQo+ID4gU28sIGFzIGZvciAzMS4xMC4yMDIzIEkgc3RpbGwgc2VlIHNpd191bWVtX2dldCgpIGNh
bGwgdXNlZCBpbg0KPiA+IGxpbnV4LXJkbWEgcmVwbyBpbiAiZm9yLW5leHQiIGJyYW5jaC4NCj4g
DQo+IEkgaG9wZWQgdG8gaGVhciBzb21lIGZlZWRiYWNrIGZyb20gQmVybmFyZCBhbmQgRGVubmlz
Lg0KPiANCj4gPg0KPiA+IEFGQUlVIHRoaXMgaGVscGVyIGNhbGwgaXMgdXNlZCBvbmx5IGluIGEg
c2luZ2xlIHBsYWNlIGFuZCBjb3VsZA0KPiA+IHBvdGVudGlhbGx5IGJlIHJlcGxhY2VkIHdpdGgg
aWJfdW1lbV9nZXQoKSBhcyBMZW9uIHN1Z2dlc3RzLg0KPiA+DQo+ID4gQnV0IHNob3VsZCB3ZSBw
ZXJmb3JtIGl0IHJpZ2h0IGluc2lkZSB0aGlzIG1lbWxvY2sgaGVscGVyIHBhdGNoPw0KPiA+DQo+
ID4gSSBjYW4gc3VibWl0IGxhdGVyIGFub3RoZXIgcGF0Y2ggd2l0aCBzaXdfdW1lbV9nZXQoKSBy
ZXBsYWNlZA0KPiA+IGlmIG5lY2Vzc2FyeS4NCj4gPg0KPiA+DQo+ID4gPj4NCj4gPiA+PiBUaGFu
a3MsDQo+ID4gPj4gR3VvcWluZw0KPiA+DQo=
