Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92864EC3F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLPNq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPNqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 08:46:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C525C0;
        Fri, 16 Dec 2022 05:46:53 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGC77i7016237;
        Fri, 16 Dec 2022 13:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=dEN3PRqBUc3Gmov8arSrIjeeokEkSgwkgi6/SHttFVA=;
 b=JbMFfj/soxldGbY1hMPnVHEVqtofXNq2eO/djkGd43a5xOgnAet1SXncxC0rUcUOYPsc
 zHuSl5WYZIG81mYTzzCgXCkTADW7Rk3VHxplQRRwZshI2vLkulqudWWVFPV+aAQqqDlg
 nPtNgn8Tq+Cjm2ifNnrhBD2n5mb+FaMSAnEr7mSN8F/oFG8YV2TvO/ldxKUJexotbdF/
 CBAadG+tjaJYbP18Tqy5KyYa+ZSrft98brNVTWfvRiKYGp8UvlNlaOjyZZfImnNACnjp
 CuJkDSTm0IHcaxa9+Wg368sSERNGLsgz9gZrpEb2jv+StM3Gf7fU6s+mIxL07bRZHLoD Pw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mgq5847g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 13:46:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRpfj7TZBG6hzyl/vvC1HyWo5FTPUNXPp2NdgB5rWePv+u85/gH46gm/b7FpzTKuuvc9Omt/9YRLWTrv7fyoJT+dJgXYjsyrCz/q8SFDysSmuPm3A7Pt5wPE4MZH+Y/bm2zb2ircIhXRgEVRxVfR8z8M+10/SKmSFfcGSzltDWiVa0hhX/h731O1uTDrBK7jTeaaCWjtIfcdYYfR82SiswsoFpk7axsxOkjfJTIjEyr5W4iaC8mJhoKP1OgzXyptoGwSwiQ+mNYvIGUuXfv76UdHfNmTVIqImaC3Lji2VbIITV77kP6YYK7OZRj+9pwk+PaNYlRy/7ZStjQuPhiefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEN3PRqBUc3Gmov8arSrIjeeokEkSgwkgi6/SHttFVA=;
 b=J6cEo27T9mub9ZbeOlphC6Okhie2wuwSLqv7tloc83CGPYIl+dcttNvf7lLyo6dLCTADYttr395kAFFlF80oZndOgoM7Es1do7PbBXVBiQAcAiGstcincBkUiscuV2RwZ5O+GC8gA16ma96aA2byOMt3CcegOMiOy4pPP54jtMtbpaAwYeA7gg425tCOAIzM/8YPXdhXidwrXg5dvI2b2dwNpfVfrQRCMRlyM5rsMEEETsH+zZIoAi+K2Mg9P7KoYt7p/JuXYm2IEvKsDUviVxgk5CFrEUcyr0NYVNecjEkIyi2zRl/o6PXtf3dC6KiPFi3SzIeIb3qY6+bq4Uiugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by DM6PR15MB3941.namprd15.prod.outlook.com (2603:10b6:5:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 13:46:39 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::31b:e1b3:6868:791d%5]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 13:46:39 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Topic: Re: [PATCH] RDMA/siw: fix pointer cast warning
Thread-Index: AQHZETVNED4pqf+o10COHC+KSVE48a5wTlYAgAAYt1A=
Date:   Fri, 16 Dec 2022 13:46:39 +0000
Message-ID: <SA0PR15MB39197549C5C9F2775F76AA1E99E69@SA0PR15MB3919.namprd15.prod.outlook.com>
References: <20221215170347.2612403-1-arnd@kernel.org>
 <1bba42a31e0a487bbbf67955b674583e@AcuMS.aculab.com>
 <CACRpkdY_050MZ3Gun_bOZiTk=q+7xUkiP0CO7daLEiX2wRi_yg@mail.gmail.com>
 <SA0PR15MB3919F3295251A173D0E14C3F99E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <fa8b6397c285413c83194e471056feea@AcuMS.aculab.com>
In-Reply-To: <fa8b6397c285413c83194e471056feea@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3919:EE_|DM6PR15MB3941:EE_
x-ms-office365-filtering-correlation-id: cd9f366c-09ba-4da0-2de1-08dadf6bf556
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uykpxALvebsSi7jfDIofGm4vvgU5x4rhwYBKnVZVC1IptGTK7SNtemO0HvGu3VOHlew9YGJGV2e7x9WATpOp3bh2WiZ3QamAH0C4MooIL6NZ8aPSD0mqfppw8D/1H80dX2HWTGRwzMZTZbcQqeV0d08OGve7ZEe9ug9WV7R9FkvB0b2hcIrZyGB1b6Tjjl6l0kiia6dOcpDSHdpKCS1OG5UOB+dCJFWYrQIoYIME9xq5LDQfL5VmDLmr9A7qAqQvWHJja9evl2NyEkRSPj6z0gI+oQ+vjQkykJygvgbrldASSXPgvmeAZ9e/tq7R+6w0yInSeV3CFiiNgzGZlHTR4wBA4zXMTadaU6xGLAIzLcLHoMGpM5WEIFmcQyouuhfEgcgvcGRjxjow1yYntVY6XdPzQNmYnj0myWo8vrauFpZgY4ZFAEYbP2JLVcvJ2ZO4JY+APIZpKpWrQOQF5I4EgKqRFfJi9Qbozv5lpY8Wu9xKYnzu0SnTbjpXrY/u0mYdpcOdz8eSarhkFCLeIFoJIhHPujT2z5Xl6/V7Tu1L4FrABt5UtUZG/qdzSIBBUJyVCrYY4AFHnXdPHUopsglbc2zuFMtAblh3M6t9cqrpzUQ9t9AvUtx4o6Cq6ob1P3n3Q6gHY3D8Yq7G0xLb+z5KSwQ1q6hzb89FAeVGUUtvJathdE3n5U58wji5dzM6rUvopZRySmZs/FktVDe0p2GSjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(478600001)(71200400001)(76116006)(186003)(9686003)(64756008)(66446008)(8676002)(4326008)(6506007)(53546011)(7696005)(33656002)(2906002)(316002)(83380400001)(54906003)(110136005)(38100700002)(8936002)(5660300002)(66946007)(66476007)(52536014)(66556008)(38070700005)(55016003)(86362001)(41300700001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1U0SitGMEhQTktzM2ptUnRXOGxoUFhPSVdDNnZQQVRUMlF4czlVUjdQbWlR?=
 =?utf-8?B?Qk9lV2NGeVB5NXNON2kvWXBYRWpBakdNTzgwQlRoV3Q2L2o1clBVSjFCVzZF?=
 =?utf-8?B?MkdHRjkrNmdWczFTTS91U0x0Q013azAxV2M4YXM2Uy9rdXJMOFhwZmNPdjVa?=
 =?utf-8?B?K290MXpZSkpHVnRoalE0eUliVW5qcDJuMTNyS2lzT0ZCdW1PczR0TzgyVXdH?=
 =?utf-8?B?T29KcncwenR0U3JxYTBzY1RzTkt2K1gzOVUzNUhMdG5VOHJTZ1lKcWZjOFg4?=
 =?utf-8?B?OEtHOVd3UHExQVpzWGE0SFM0M0NPeWFjODBnaDBUMS9RNjZvU2NqZ0ZPNG5z?=
 =?utf-8?B?dVhkWXZiR2EvY2FjazlsLzczeXZ0Vm0yWWlKZkNEZU0vME5MS2czME5qQlJX?=
 =?utf-8?B?eWxUVzloNTUvUkxQT2JHUlNYVWo4cFhlVlpJT3RTbXg1WnVGS3BmemdNYlcz?=
 =?utf-8?B?Vk9scGZTZmNvdWdHVzdMVmpLa29wNmk3YnVIQlJ4SjBETGQ3RVM0NkJpWUtE?=
 =?utf-8?B?UHA4NUpLb1VmaTlkVUNTcC80SEd3U1FRaDFxN3BuaXg1VDgzdjZwWnBHZExF?=
 =?utf-8?B?YzdwZXRZajdGNjZFeG1aRXFYNENBNEd4TXZVSm8wQXFMTytOMkxIdVRPS01U?=
 =?utf-8?B?YmdiSUlkTy9Tcnk5ZHVUMzdWeWdBWjR6UEJOU0YrL0YvMnp4MDgwMDcxV3RG?=
 =?utf-8?B?c0dSY0M0bkdYWEdVM0lKYUM2Y0JUSWVNRnRVUVhML3JmSklxNU8vd0U4Z3hJ?=
 =?utf-8?B?V3pLQUd2MTFYeUltQzREQk9JWjgxN2ZGcHlSWmExR3pUL09UMkVxeVRrMWVv?=
 =?utf-8?B?V1M3a3kreHo2S1kzbXRrU2g3UDNxUGRHZnVXeEEyOExtUmx2MVJUNjN2d0Vi?=
 =?utf-8?B?SXV3TnptMmNTQ2RQSXlaT1VyVDh6M1lET2RGS0NFWmY0SCtDY0NhbllCVG9V?=
 =?utf-8?B?SnVDN1l0N0FFVWdBL29ScWkzMTlwNWdjN3pkaXhsSzEwNm9CWVo4MXduejhZ?=
 =?utf-8?B?MlZteTdNYWhTMkNZcjI0dWVVYmlZQmZZV01sQkhoNGppT3RFM3ZuTXNkN29X?=
 =?utf-8?B?eEtNM0t5eWtPSStUNTFlN1ZvR25JU3JjNDZORm5aLzBFeVk1bk1FNDhabVgr?=
 =?utf-8?B?SEVvOE81YVVGeC9WU0dIMDFqMEtsa3Z4WVZHeHRzRGxnMzRKdzI0U09xRTM4?=
 =?utf-8?B?T1ByS1MveGU3TDJSa0hJR0tNcnVqc2N5WHYvRUdoMXBOVWFPL3VHYjgvbEhN?=
 =?utf-8?B?OWVEOXFxTUpaei9tQm1iVzhxTWVnZGxlQ0lkYm9MUFJGMFhkMHBSeCtqSkFa?=
 =?utf-8?B?L0QrWVloZHpIYlFPSGtKMUpPVDlUQzMxUHVvblBUTlVVRVh3c2xvVmRieDhM?=
 =?utf-8?B?Ny9oNTREOU5yaFdoMkduVEZod2F4ejN5UmlPNEhyYU9ja0d1MHU5VnhUWVdr?=
 =?utf-8?B?MlBMaXZENTEyOVFzRE50TVJSQUFCaU1mNkptaGNKWW9Sdmh0ZzdPdEk2YUFZ?=
 =?utf-8?B?UTNwQ1MwdVVMUUpNM0FjWU5zT1B5TmQ1amp0aFJNYUg3Q1NuN2pFWjZPTlVw?=
 =?utf-8?B?MWUrdngvRXZibS9LdmVTUmlQd3A0YlZlcEdOQXZsclNnZEcyZFRnb2NQTlV6?=
 =?utf-8?B?ZFlEOGxRY0gzNlc3TWd0YlVST3I3UEh2QnFNOHpYbXNJMVQ3SWRuSEE4aHIr?=
 =?utf-8?B?MXBhVHlVRDIxdnowVlBkWFpaRldGSFpDQTJKUDJvVkFWYXhKTDR5WEhXdXll?=
 =?utf-8?B?L1UwV2J5Qkh0dWo2c0lNNFBIRHpIbHFnbkk0bDRzYkZyWWpXWHhsUG5wN3Z5?=
 =?utf-8?B?bGFvcFQrcjVtZHUrUnZMVTVjN2ZPV0VLZHZtTW9WQUR4UmdnSXR5YzRtalow?=
 =?utf-8?B?eE56bVVnSTVpTVVCL2VlZTUrMXhMSW5IWGEraitZcU9BaThLZzBnYWRIMGlW?=
 =?utf-8?B?VE10NTVUenhJNDNyTU4yNk9tUS90MFMyYmRrc0w0T0tDVWI2V3U2SG4vaUUr?=
 =?utf-8?B?ZGozTmFaTWIzMFVpeFpiaE92Y0lzdlVIR0NPeWVHdTlhdFFVNDd0ZWxUbkI5?=
 =?utf-8?B?SzVPR21UdU1HRnRtNzJQNTJrakRQb3M2am40NTVnYzFXaUEzR25yS0F4WHBY?=
 =?utf-8?B?WU5KTkNHa3MweWRKNW85YmhManpMTnBablErOWNJSGphVW9nV0U0c3hidGpO?=
 =?utf-8?Q?+Y9yscsMl3hALcER2teAJhx7XelJ9FflHyfRYa5AALCP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9f366c-09ba-4da0-2de1-08dadf6bf556
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 13:46:39.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PL4Yd/4gO2YQI0HmZ5ysvsDBuq22+eCLFStd9yU6HjEwPaefnmFh9tbeUkERafw55VJtP1ofJEMvlj+G2fk6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3941
X-Proofpoint-GUID: lJIOsT6NmE2gjdjKc2_SjejLnQ9d0PxH
X-Proofpoint-ORIG-GUID: lJIOsT6NmE2gjdjKc2_SjejLnQ9d0PxH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=857 spamscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212160119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGFpZ2h0IDxE
YXZpZC5MYWlnaHRAQUNVTEFCLkNPTT4NCj4gU2VudDogRnJpZGF5LCAxNiBEZWNlbWJlciAyMDIy
IDExOjIzDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IExpbnVz
IFdhbGxlaWoNCj4gPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gQ2M6IEFybmQgQmVyZ21h
bm4gPGFybmRAa2VybmVsLm9yZz47IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTGVv
bg0KPiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5vcmc+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPjsgbGludXgtDQo+IHJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUkU6IFJlOiBbUEFUQ0hdIFJETUEv
c2l3OiBmaXggcG9pbnRlciBjYXN0IHdhcm5pbmcNCj4gDQo+IEZyb206IEJlcm5hcmQgTWV0emxl
cg0KPiA+IFNlbnQ6IDE2IERlY2VtYmVyIDIwMjIgMTA6MDENCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6IEZyaWRheSwgMTYgRGVjZW1iZXIgMjAyMiAwODo0
Nw0KPiA+ID4gVG86IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+DQo+ID4g
PiBDYzogQXJuZCBCZXJnbWFubiA8YXJuZEBrZXJuZWwub3JnPjsgQmVybmFyZCBNZXR6bGVyDQo+
IDxCTVRAenVyaWNoLmlibS5jb20+Ow0KPiA+ID4gSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUu
Y2E+OyBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz47IEFybmQNCj4gPiA+IEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPjsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIXSBSRE1BL3NpdzogZml4IHBvaW50ZXIgY2FzdCB3YXJuaW5nDQo+ID4gPg0KPiA+
ID4gT24gVGh1LCBEZWMgMTUsIDIwMjIgYXQgMTE6MjAgUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5M
YWlnaHRAYWN1bGFiLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4gRnJvbTogQXJu
ZCBCZXJnbWFubg0KPiA+ID4gPiA+IFNlbnQ6IDE1IERlY2VtYmVyIDIwMjIgMTc6MDQNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IEZyb206IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBUaGUgcHJldmlvdXMgYnVpbGQgZml4IGxlZnQgYSByZW1haW5pbmcg
aXNzdWUgaW4gY29uZmlndXJhdGlvbnMNCj4gPiA+ID4gPiB3aXRoIDY0LWJpdCBkbWFfYWRkcl90
IG9uIDMyLWJpdCBhcmNoaXRlY3R1cmVzOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzogSW4gZnVuY3Rpb24NCj4gJ3Npd19nZXRfcGJs
cGFnZSc6DQo+ID4gPiA+ID4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzoz
MjozNzogZXJyb3I6IGNhc3QgdG8gcG9pbnRlcg0KPiA+ID4gZnJvbSBpbnRlZ2VyIG9mIGRpZmZl
cmVudCBzaXplIFstDQo+ID4gPiA+ID4gV2Vycm9yPWludC10by1wb2ludGVyLWNhc3RdDQo+ID4g
PiA+ID4gICAgMzIgfCAgICAgICAgICAgICAgICAgcmV0dXJuIHZpcnRfdG9fcGFnZSgodm9pZCAq
KXBhZGRyKTsNCj4gPiA+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFVzZSB0aGUgc2FtZSBkb3VibGUgY2FzdCBo
ZXJlIHRoYXQgdGhlIGRyaXZlciB1c2VzIGVsc2V3aGVyZQ0KPiA+ID4gPiA+IHRvIGNvbnZlcnQg
YmV0d2VlbiBkbWFfYWRkcl90IGFuZCB2b2lkKi4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEl0IHRv
b2sgbWUgYSB3aGlsZSB0byBmaWd1cmUgb3V0IHdoeSB0aGlzIGRyaXZlciBkb2VzIGl0DQo+ID4g
PiA+ID4gbGlrZSB0aGlzLCBhcyB0aGVyZSBpcyBubyBoYXJkd2FyZSBhY2Nlc3MgYW5kIGl0IGp1
c3Qgc3RvcmVzDQo+ID4gPiA+ID4ga2VybmVsIHBvaW50ZXJzIGluIHBsYWNlIG9mIGRldmljZSBh
ZGRyZXNzZXMgd2hlbiBjb21tdW5pY2F0aW5nDQo+ID4gPiA+ID4gd2l0aCB0aGUgcmRtYSBjb3Jl
IGFuZCB3aXRoIHVzZXIgc3BhY2UuDQo+ID4gPiA+DQo+ID4gPiA+IEkgaG9wZSB0aGF0IGRvZXNu
J3QgbWVhbiBpdCBpcyByZWx5aW5nIG9uIHVzZXIgc3BhY2Ugb25seQ0KPiA+ID4gPiBnaXZpbmcg
aXQgYmFjayB2YWxpZCB2YWx1ZXM/DQo+ID4gPg0KPiA+ID4gSXQgbG9va3MgdG8gbWUgbGlrZSB0
aGlzIGRyaXZlciB0b3RhbGx5IHRydXN0cyB1c2Vyc3BhY2UuDQo+ID4gPg0KPiA+DQo+ID4gU2hh
bWUgb24gbWUuIFllcywgc29tZWhvdywgYW4gYWNjZXNzX29rKCh2b2lkIF9fdXNlciAqKXN0YXJ0
LCBsZW4pDQo+ID4gaXMgbWlzc2luZyEgTGV0IG1lIGZpeCB0aGF0IHdoZW4gSSBhbSBiYWNrIGF0
IG15IGRlc2suIFNlZW1zIGl0IG5lZWRzDQo+ID4gaW1tZWRpYXRlIGFjdGlvbi4NCj4gDQo+IFRo
YXQgd2Fzbid0IHRoZSBzb3J0IG9mIGlzc3VlIEkgd2FzIHRoaW5raW5nIGFib3V0Lg0KPiBJIHdh
cyB3b3JyaWVkIHRoYXQgaXQgd2FzIHB1dHRpbmcgdGhlIGFkZHJlc3NlcyBvZiBrZXJuZWwgbWVt
b3J5DQo+IGludG8gYnVmZmVycyB3cml0dGVuIHRvIHVzZXJzcGFjZSBhbmQgdGhlbiBsYXRlciBy
ZWFkaW5nIHRoZQ0KPiBhZGRyZXNzZXMgYmFjayBmcm9tIHVzZXJzcGFjZSBhbmQgYWNjZXNzaW5n
IHRoZW0uDQo+IA0KDQpPaCwgbm8sIHRoYXQgaXMgbm90IHRoZSBjYXNlLiBUaGUgYWRkcmVzcyBt
YXBwaW5nIGlzIG5vdCBhY2Nlc3NpYmxlDQpmcm9tIHVzZXJzcGFjZS4gSXQgaXMgbG9jYWwgdG8g
dGhlIGtlcm5lbCBkcml2ZXIgb25seSB0byB0cmFuc2xhdGUNCnVzZXIgdmlydHVhbCBhZGRyZXNz
ZXMgdG8ga2VybmVsIHBhZ2VzIGR1cmluZyB0cmFuc21pdC9yZWNlaXZlIG9mIA0KYXBwbGljYXRp
b24gZGF0YS4gVGhlIHVzZXIgb25seSBrbm93cyBhYm91dCBpdHMgb3duIFZBJ3MgaXQgdXNlcw0K
aW4gaXRzIHdvcmsgcmVxdWVzdHMsIGFuZCBkdXJpbmcgYnVmZmVyIHJlZ2lzdHJhdGlvbi4NCg0K
QlVULCB5b3UgcG9pbnRlZCBtZSB0byBzb21ldGhpbmcgYmFkLiBDaGVja2luZyB0aGUgdXNlcnMg
cGVybWlzc2lvbg0KdG8gcmVnaXN0ZXIgcmVxdWVzdGVkIG1lbW9yeSB3aXRoIHRoZSBkcml2ZXIg
aXMgZGVmaW5pdGVseSBtaXNzaW5nLg0KSSB3YXMgdW5kZXIgdGhlIHdyb25nIGltcHJlc3Npb24g
aXQgd291bGQgYmUgY2hlY2tlZCBieSB1c2VkDQpwaW5fdXNlcl9wYWdlcygpLCBidXQgdGhhdCBp
cyBub3QgdGhlIGNhc2UuIHBpbl91c2VyX3BhZ2VzX2Zhc3QoKQ0KZG9lcyB0aGF0IGNoZWNrLCBv
dGhlciBkcml2ZXJzIHVzaW5nIGl0LCBhbmQgaXQgbG9va3MgbGlrZSBhIGdvb2QgZml4Lg0KDQpP
dGhlciByZG1hIGRyaXZlcnMsIGxpa2UgaW5maW5pYmFuZC9ody91c25pYywgd2ljaCBhbHNvIHVz
ZQ0KcGluX3VzZXJfcGFnZXMoKSwgbWF5IHN1ZmZlciBmcm9tIHRoZSBzYW1lIHByb2JsZW0uIFRo
ZXJlIGlzIG5vDQpjaGVja2luZyBvZiB1c2VyIHBlcm1pc3Npb25zIGZvciB0aGUgbWVtb3J5IGJl
aW5nIHJlZ2lzdGVyZWQNCmZyb20gdXNlciBsYW5kLg0KDQpUaGFua3MgdmVyeSBtdWNoLA0KQmVy
bmFyZC4NCg0KDQoNCg0KPiAJRGF2aWQNCj4gDQo+IC0NCj4gUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMQ0KPiAx
UFQsIFVLDQo+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=
