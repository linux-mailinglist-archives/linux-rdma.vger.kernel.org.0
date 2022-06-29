Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF8C5609B0
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jun 2022 20:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiF2Ss2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jun 2022 14:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiF2SsR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jun 2022 14:48:17 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F423FBC1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jun 2022 11:48:10 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TG2J8T010775;
        Wed, 29 Jun 2022 18:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=oM8QYg292zFUUz9mkLrwBJBtr/LDwqeuSx2gEIF92ZQ=;
 b=fpT9KWKA0G4Jl45PdvjjEKx+VJ1Y5qpqL+GiZsMU3y+I7HFauicnKWvfB3qRa043baY4
 i5oF1yEISuHLU8eA0Ad4WE2cZFKs2JJ6fHG9ZjXKhRHTLmSSgfHV83QyrBNkSgt4p1sq
 qjOmZXbcLlBxcphbLJCByTrCUjJgTbce+UhvZpv6hAGGFnlgf3IOeh9UVU0ZSmkFCiYm
 5MZYNMAssV+H4dZHxaCnSdhNqjMMmbVtB/uK/9/Xbi2+pPyyvByuNguMp2fF6NZAKfEZ
 gWETeAlgBI6auzz/+DXGPBQMqn+BqY5HG61qD3/MhzhBuplTvBJIKtx6oyA//VH9seMK dQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3h0h6wxs7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 18:48:03 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 951FC80020A;
        Wed, 29 Jun 2022 18:48:02 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 06:48:01 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 29 Jun 2022 06:48:01 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 29 Jun 2022 18:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eogqeiTMaUXjzRuqaky5zwnRA7u2k26TF65McSLILNX52aHoisccTuo3r/bxj7+esVZp2uyjCsg85CS8TAdWuSV8BFTsMeJgFq9h4P8WaP3GcxrUoXgJIj2rggDwggHOhfjSdWvYPdHHtJlXW/TXCzRJ/xHwjemgf+a4w2m20BpOyDlRARIOuk+S4WSksT8vxV9ltQEjlR1CjtHGs/F6sVhekoj9aEXTKoyVSBaCs9am/4zI1iADgRgJCzd/n5dYuTlfT6kvZafYLb79lTxMFt6usPLFB/VzMeXkGg3Hd/tdwdv2PGXVDlOVxxBU7Ns3TVaYLLO5GEWfDepk/dlURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM8QYg292zFUUz9mkLrwBJBtr/LDwqeuSx2gEIF92ZQ=;
 b=LY/vRWkgogGIoNhHkDZ00lmDmOboAsp8QVMYqoI7jog00T1O89ZWg8KcqGNVPqQ6LjUkxYkm9qbwGMfTQ6Vsv8erTGSE2F5iY3PMmYFNvmg88CtWf15AGEy/aq9ZXbLyvu9qRQSgoEFyBpJ3R4MfQX/wYcwA0v/mrkLBlspK4CZ9wsV2EqYFx/GgRkVTgnJqo9Jri+eNUoEGWUHm7thtEuvqrUa204/DJaqrvv8vWgrwF247t2VTUGMtFt+hGoj5CNdMXZSolsbgKenCGqmEpgbfrZTzxa+DalaUzEd90qd64uG/ys2WzDqhWt8rb9//dHhDDcQFRNu+xgE665I9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1b6::9)
 by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:47:54 +0000
Received: from MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455]) by MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f43e:903d:5607:3455%3]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 18:47:54 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Md Haris Iqbal <haris.phnx@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: RE: [PATCH] RDMA/rxe: For invalidate compare keys according to the MR
 access
Thread-Topic: [PATCH] RDMA/rxe: For invalidate compare keys according to the
 MR access
Thread-Index: AQHYi9iAxovqsOAg+0izN/pZoerKUa1mth2AgAAAztCAAAHuAIAAAGRA
Date:   Wed, 29 Jun 2022 18:47:54 +0000
Message-ID: <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
 <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca>
In-Reply-To: <20220629184432.GW23621@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcc0b931-1b3c-4abe-873f-08da59ffe0c5
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imQ10caAxtqBFvlvon2O2paz/5ZBSzrNvFn1vD1geFzLgd6zjgkTkcR/KZ1cjTuv0vEl5uO0kcYE003kDwjpTr4SEgFE067B+BvQ0dF5mn+JspqybOGFsywfktC4hVKKZzZQmoLJWptjYi2HbIvT1tyO3VJ8exYSfok7EilzbQosuAxOLpjaRphhxHSaXkBX+8GXKp33Ab8/HLkONsaWsgeqQsdqXSfPvE7lm71kzzmaHPX4KukQ0Ho8Z61gU2HgWLIo9h+98100bXY8938M4ufRbWqpdNlJWl4TKwaxuzo7G/s668yBs8/A4J5CyMWSa419UknyQuY3rkQoIGIAuUADCVZ/cgPMTtKsQImLGJiqJbGPkwbBpzIxbePkZ0orzvWr+IXDQjGL6OxwX5mKQxIAoTxB3dj8KGuakd2dO3WT94XBhrmmqUsgJI5bjLo5AzSAezU8VjSvU83po3AiyRia8go0ibmid2YXS6+XELRRJ4OARBbWJTmqaJE9CeySGVkfeDOz/3uXBxpT1aPbCV/gxh0PC68QXKRdmJy0TBeI04EiT1zj9akn/LAZvajk/i2gBBThDbQ6gc6D0A2P2uSPRbm8X1IoaYwuvoAbWrMcTmsSYPDxTstY17jgkrfEpsOg56XI9W4SRo/QdT5ooUoptk9P4n0ma9uuF3uU4LagVqKCCVdQ4YDYTYflgMNQTorebWlJzf2QDhwsKpf9rvNgBNLsX4rD/+8jgfdrb3K9F7+sWjgHX9uisONemqfU01rvG2t4CnHPIEbWIdd5GYIek0f5xduG2ew7WY9aRUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(38100700002)(38070700005)(8936002)(478600001)(33656002)(52536014)(54906003)(41300700001)(6916009)(186003)(82960400001)(122000001)(83380400001)(5660300002)(55016003)(66946007)(76116006)(71200400001)(66446008)(4326008)(64756008)(8676002)(66476007)(86362001)(66556008)(7696005)(6506007)(2906002)(4744005)(316002)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U21rd0VUVGtFK3IxV3lac0xJUVdpcHlNYkNYQjliK09UT1d6K2dDbzltWGlr?=
 =?utf-8?B?TFlTU1F1MjRXR1didE9GaCsxcm9FR1hub1R2dkdpVzlRVTllZm9paWhTYnB1?=
 =?utf-8?B?ZXRLYnc3RkwvdjdmUDFGemVGVHVDdGV6dWlxZm5BbDdINVV5cHdsQjgxTHFY?=
 =?utf-8?B?dE1hcE0rR3JBQ0lNR2ZPMnhLVjBoRzdIRWtPVE1jQ0xIT2ZDNEcxOUIyS0pi?=
 =?utf-8?B?aHBwT1FCZnl4VXlsNGF2T1VhSlovMWJ0RHl2UlNsYWZlZHBuZjRwUlUwaHNo?=
 =?utf-8?B?VVRXckxtMVh3dDdIaWNsV2UrMERtRitudldtZzVRVnBuWW15SUJYN2tiZ2la?=
 =?utf-8?B?clhUdlk0TDcyYlBpZ0Y1T2xHL0RzeEt3V0hRZkdCdUxOZXU0WjhtLzVpMU0v?=
 =?utf-8?B?VUdxVHlrSm11MUM2cmhLVnU5ZHhKeUNXc3N2cjFhV0tvNHhMNkYzd0dPdGk1?=
 =?utf-8?B?SUhRRTY4V0dlendndURDckRucFVFNlNmbElaTHpqdVJzYWNsWGxLb2dZNkxS?=
 =?utf-8?B?MFJYUyt5cyt5cW5wN1FmZlc3ZEFid242V3lQUW1wYnk1TjVGL0tqU0drNUx5?=
 =?utf-8?B?YVdGUU04ZFJCZzhhUlMyaWpVSDZGNjRZaXE4NGZPbHFzUTNQRkc0Mld4U3pO?=
 =?utf-8?B?em9CZElRcEttY2tqSGdYbWtpVU1IbTFLRk1aL2owa1NGR2hjVUg0UVErc2Uw?=
 =?utf-8?B?R2hORFZEOHhsSlVOZldSSzVFU1Z1Z2RGeE1BYm5xK0ZaTFJ1U1M4NzFUNFVB?=
 =?utf-8?B?YWhUaVR6dTRDMFZsUURuaEMvNU5MNDBSTmVSbXRIVFVETHVWMDhUZzBkcHVC?=
 =?utf-8?B?U0RjeU5xRmFJQ2JlSVhzMThLMU9KMnJKQjN3ZDZDbEZMTzNWeTlNRS9MYnJR?=
 =?utf-8?B?Tmh3bmk3RmNzTlZ2ak5UdWxneXFQUml6YStGcUdDNVMyaVVPTXNXOHV0c1kz?=
 =?utf-8?B?Z3hISUVweVgwSm5sSE1MTmNZZW5OQVhjajAxb0h6VnhHRG1SQXhORVB0dGdQ?=
 =?utf-8?B?RzVwVCtRM1dxZXZRTmNuS3g5dTVJSEVPQ2NFUm1lMUY0Mm5sRVdHUDlVYkwr?=
 =?utf-8?B?VVRKRmdQNlB5Y3BzNlAwRkF0aVVHeHRaZ2lrTjl3Nkc2Sktabkh5SkUyTTBC?=
 =?utf-8?B?KzR5c2ZSTUovS0g1M3ZNWkc4MFZvV05NQXh3cnVMcWlMdkpkSXJXWXNIQVVO?=
 =?utf-8?B?cTdFVmJrL3hubjJKeExtbmV2VWE2U3M0QTNGRG9iMWFyODJoazBCMUpPWWJK?=
 =?utf-8?B?dnZRQWNpcXBSRStpcEp0Wk80T2xSSURaeWx0cTZ2b0pjN09GRzloVnI1VmtY?=
 =?utf-8?B?K2N2WFZ2d1VHZ2g3M3lXRVFQbnVQNml5VVExbTRyK3NvMWwzZDFLM2Jxc3N3?=
 =?utf-8?B?RkwrSjZySHNQUUtkekVabzBIeTFZVVpQTGVxdURoY3ZuZDg1OWY1bk9UcHNB?=
 =?utf-8?B?amtUbHVjZUFPSk9xaFhjT3kyV1VXR1VJTm81STB5TGVSWFpvK3FucXovMDVL?=
 =?utf-8?B?a1Nwam85RXU5cXh2aTFvb2crR3hEZFdVZ1d2M3Rsa2pGRHRMbDVNV0ZGMnhw?=
 =?utf-8?B?RFFYcDhoYlBzZFIrY2lza1RVT0JrRTJSQ1ZCdnFYYTg4Q1NYRzZYeHF5MWxu?=
 =?utf-8?B?VVZXaFVBSm1QMUJWaENTeTMyN25qaGJTc251K2dGeWZqeW1wb1BOUTFvL2ZN?=
 =?utf-8?B?ZDhiUXdoZkpUM0NnbzlxU01STHhBS0VRT0gxVmFadlZLYnNHaWxmWm84NE04?=
 =?utf-8?B?ZVN0K295MVRNTWpUVHZIMjlKOUpVUVdCaEc1QTZZY0ZNQ3ZTUlhOMmcxdEIr?=
 =?utf-8?B?M0VsNUF0NXlGOUxZMHRqL1A4OHVWSkVDUlZSTGw5VFd1YXlCWkwzc0hjbEYz?=
 =?utf-8?B?MitOaDlnTlJZMlk4RWJkbWhIV3M0MWFxMTNEYzE3VDBHbDJaMlBlTXYzVkZE?=
 =?utf-8?B?TURiK2JIUlJYTnpxdk1NVVlkcEY3MElSc0FzT21xYVFwd3VNTk02ME5OdkdK?=
 =?utf-8?B?bTR6RktqUmNuMTFMaWxnK0YxVy9RVkJBSmw1QVFjQXBiakhNd3dNNllybnhW?=
 =?utf-8?B?OGhOWm1jd0VqbkRENTl5aFBRWFF3TUZEaGhBK3I1SGIzTnk4YUFRRkw5ZG5w?=
 =?utf-8?Q?3fFojSozFbIcJNtmldaVYdq9H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc0b931-1b3c-4abe-873f-08da59ffe0c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 18:47:54.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnhKHZQfPV+KmR5e9WSXaBxiVxTXrDTB2cDTslURrgsIv4ORI0EoKdglPNpYjhCmMLx+hGXsR2vBF3oU/dyqkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1927
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: pLDUaOKRHWf1Yy10wY7TLsa2hRoC0eeR
X-Proofpoint-ORIG-GUID: pLDUaOKRHWf1Yy10wY7TLsa2hRoC0eeR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_19,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=657 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290066
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+ID4gSWYgdGhlIHJrZXkncyBhbmQgbGtleXMgYXJlIGFsd2F5cyB0aGUgc2FtZSB3aHkgZG8g
d2Ugc3RvcmUgdGhlbSB0d2ljZSBpbiB0aGUgbXIgPw0KPiA+IA0KPiA+IFRoZXkgYXJlIG5vdCBh
bHdheXMgdGhlIHNhbWUgY3VycmVudGx5LiBJZiB5b3UgcmVxdWVzdCByZW1vdGUgYWNjZXNzIHRo
ZXkgYXJlIHRoZSBzYW1lIGlmIHlvdSBkb24ndCBya2V5IGlzIHNldCB0byB6ZXJvLg0KPiA+IFlv
dSBjb3VsZCwgb2YgY291cnNlLCBjaGVjayBib3RoIHRoZSBrZXlzIGFuZCB0aGUgYWNjZXNzIGJp
dHMgYnV0IHRoYXQgaXMgbm90IHRoZSB3YXkgaXQgaXMgd3JpdHRlbiBjdXJyZW50bHkuDQoNCj4g
U3RvcmluZyB0aGUgcmtleSBpbnN0ZWFkIG9mIGNoZWNraW5nIHRoZSBmbGFncyBzZWVtcyBsaWtl
IGEgd2VpcmQgb2JmdXNjYXRpb24gdG8gbWUuLg0KDQo+IEphc29uDQoNCk9uZSBhbHdheXMgaGFz
IHRoZSBjaG9pY2UgdG8gYWx3YXlzIGp1c3QgdXNlIHRoZSBsa2V5IGFuZCBjaGVjayB0aGUgZmxh
Z3MuIEJ1dCByZWZlcnJpbmcgdGhlIHJrZXkganVzdCB1c2VzIG9uZSBtZW1vcnkgcmVmZXJlbmNl
IPCfmIoNCg==
