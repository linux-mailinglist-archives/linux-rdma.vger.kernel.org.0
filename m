Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4F7D8371
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Oct 2023 15:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjJZNYp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Oct 2023 09:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJZNYo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Oct 2023 09:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E02E5
        for <linux-rdma@vger.kernel.org>; Thu, 26 Oct 2023 06:24:41 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QDMrhM018822;
        Thu, 26 Oct 2023 13:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=DnpBHTSn4zlJN/P+08fIY6UsEweRV8HxQrmvzjXyrlI=;
 b=dDmP81/ZicFb9eC2qYaDPhfQeteajK2pIMjXDUsg0GvPTo3ToRB9tmvoAfGrzlLqvP/R
 goaOvRoA84CIRu2pUuMJJJO+KISChswlE0+CEHDSg62OBuhcXzS3ykpow8t/83oPgqVs
 jbOv2g/tg6/lAK3RPX1KrlffRqR5qvy3h5ld4hncssQqYF/BLEgYbTpRI3ntJiwQX5z/
 HCHnfEDfE3ymfOpAxWs4B8k1mGLHD0itojfaSwEtwKwUD7vuU54rbyXC9+URkJVr1AAk
 avTF0h2+stD7GiMeTPCsHRSjjdD15DOMoEN3H5QxPD1YAhS7wt4CpthVHf67mgiJxDJn eg== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tyrsugh8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 13:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K14/9vyg8614LYWhC0/6/F9t2MfOBxL58tmd4szyuxoxaejIvey3nIqdlGrJQCAWSuPHMfeOCj477zKbW8yi/SIjRJ3X9J0sTgOQ6ZqXpPdDNVJLlMUKxUbeNrOpwkq1KH+DnWbmbA1LyVFZk/4zR71EfcKYbzLjk4F/msl1aNPNaQjzvG20xYty/YQMpnxW+unmPFEVk9nKybWNhcTtgUdLdbTTUDI8Yw9aTp/Dj5UF9lGcGfvj4/Bze0XEY51TrLWHBpEGXtyAS0wOEte4z5ZlO4s3IjZwpG9vpTM9wWejFXG02OqPxXEl6AN5g+02tqcwlrA6ywfjP1bsVtWznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnpBHTSn4zlJN/P+08fIY6UsEweRV8HxQrmvzjXyrlI=;
 b=ZC3RAuHiEUbxsreqFYiOFws07CzvAS8dxCgY5AC9bOV7bm3QIAMEuez8MFHjdPy9EHqTTgPwyYe9Q2gArpypB50HMevstJox4RtJ9/q7Zy2Ami3WdvQHByCbI2VfEHnCzwWLtRwt9WJPhsqoagx2NP9NHW1+hKzlY7oEGJx9ihusKOwoXe+D+9NlAZcngVYdc9dlIvHcgLYoM6lZGvlxXZ+AprW5P6QJNhqEZO5pcV31k3w0mc37vQH4FKbmUjaxqXAdgMG3AjP8o47LDunjgMOo/wZwEH83OcdCBUJ2vVOQ7eijDtjSaT9p9r5hzEQ+2Tm79cgkwYzF7o1hDo9/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by PH0PR15MB4816.namprd15.prod.outlook.com (2603:10b6:510:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 13:23:52 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:23:52 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
Thread-Index: AQHaB0O5/SstmxCXz0eivIljVe3Yu7BboLwAgABvuQA=
Date:   Thu, 26 Oct 2023 13:23:52 +0000
Message-ID: <SN7PR15MB5755782542E9103D4A25C00499DDA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-14-guoqing.jiang@linux.dev>
 <SN7PR15MB5755FBAC40BA3C94DFE20DE799DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
 <354714dd-3f9d-9083-97f6-5b9d543563f2@linux.dev>
In-Reply-To: <354714dd-3f9d-9083-97f6-5b9d543563f2@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|PH0PR15MB4816:EE_
x-ms-office365-filtering-correlation-id: 78051c02-5923-4e32-b57f-08dbd626cc24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spDqV+xtHC4qEGO6UbsFMdWarueuGGnL6tIrz7gWNEYDnZqAj3nq89jzSs3j80hbB9t0ICW5alfZUrR95qAx0jlGNppooeoz3XidFtWySY6PjlSgUO/OHVk8IQ3teLJ2flqpEwawXXxAu3EQtoRSoZERDBE5Rt9wHGyQnSYNMxlEWOrTh7BD9FHiCEih9mNm4w0T6p7o01mMEPPRrcnfQdQbeEkXLL3DYbn5CgXA5YZdecmDGtcpRpUZkE9SzpD9f/x1tRF6LXCsFQeKdy/YRyOfRSEW+gw/ZWv+PvFyux9jTBogZ/Vdx8bB7f5u2d9yOAfc5UzfMg475hq99yd4gQUQIqV1MgUtRFcpDtsukEFvy+xQW+hVBI1Ju1Xuj41Xw8rOKJCzebFKMOwhKqa/rA4Lq/836B5iNk9iH7zqybui4QTUISiS30KNDw4nTYCn+eB05YaJxH84bIHzhJGg58dYDzZtpAa6ZcszOEKa3qWCfN1vM7aR3Z/Af72koQz3OtyWS7noKM6AKAcvAZZyIqQUnt2jVO444zGz4G/5EQj+oijGPTLiBiCWR91WkToWur9SwjdwT62ZdtB9iepfxxq0+8NKl4usB6Rsg1cVNs60ga4jh7vwYC+8WKecXTL6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(38100700002)(55016003)(9686003)(33656002)(53546011)(7696005)(6506007)(83380400001)(38070700009)(8936002)(8676002)(4326008)(478600001)(41300700001)(86362001)(2906002)(316002)(5660300002)(52536014)(71200400001)(66556008)(110136005)(76116006)(66476007)(66446008)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEhZVTY0Q3I1M2RzT3VWYjBoaGp4VkpNL2Z5YXEzTjFoVDNld2Z1eVFLc01F?=
 =?utf-8?B?RmoyR2UvU2J0V1NiUE1QS2lRRnlabm81dCtsZHZ3ZjFQSzRsREs0ZXNXZ2Zn?=
 =?utf-8?B?aDdWRFgyMUVIZTVPZVVkMFdtb09NcEN4OUdQSlVzU2hvTW1OZnQ3VnQ2ZmpS?=
 =?utf-8?B?aUNJMytuc2g1ZjN1OEd6MlFucUVZVUFqZTlaRXdWT1R2SHo1a01BenZCYU1y?=
 =?utf-8?B?cjF5c2hlOWc5cy9tRURWRVRPK0t6bmduV1RlUFBqdjhzT1FFUVVnUGkwUDFE?=
 =?utf-8?B?bGZ5ZkkrS1VacXRQRGZLMUFlZFZFa2Z1S08rdW1GUmxsZk9LVmk4MEdvKzFh?=
 =?utf-8?B?T3p2cndpb0hNY1NrVFYyZ2RuVGFuZExNcjY0S2VUNDFCaUV5YVNKUm91WTZ3?=
 =?utf-8?B?c1BTNjdPSEJUQ1dBdUsxZzdwcGdwejliSDcyK3FWOStVdWlKQTgyaG9SdU1i?=
 =?utf-8?B?K0lXQytYZnJNK3RFYTJMYmMwbXpyVUErQmlldCsvS3YrdWJaSTZvTmgraHpQ?=
 =?utf-8?B?cmpFT05vcGdNVmIvNGxCOGVHcGVaNDVkdUJDWjVHOTdDWTdJamxhNnJ2L3Rl?=
 =?utf-8?B?UzZYYVp6SjI1d1pKcW9zN0FTdkhJNWpIVllrQVhlenZKRHkxdjR2Nk4vcEJZ?=
 =?utf-8?B?QjI2bnlWKy9BNGN3cGVwcVVPZTFMVkhidkQ3T1RyR0FBVFhEd1JhOHJsbFlh?=
 =?utf-8?B?RDRBSmZWbk45eVh3ZzBXN2R2VWlVVERNVzAxUDA4cVl6SjRqVDh6MnVMV2tT?=
 =?utf-8?B?dzVLbnU5aXo4UG8rTldpaHNoY1JzQVI1TWxBeTdjOVR6cFdVbDhzTUMvMU5p?=
 =?utf-8?B?ZnhlVDBqODQxS3BJY0QvaXR2OHo3cENUYXhyQVMraGxEcmRnQ28wTmxJUHZo?=
 =?utf-8?B?OGJqb05jS3R3SEQ0cmVXbjhnektsNlBub04xVk54WHc3MTB3Q1RpMjJicjNH?=
 =?utf-8?B?b0RmUHc3ZGtxUkdWWlRGaFV1Q01vaGJ0Nk5DckY0ZjF6VDZWVGJIS3NIdnpG?=
 =?utf-8?B?QUFWME8wWnZ1L1Z3NkFtVjEyZXB0emxKbHFXYmFwUlV0bmRmUUUvSngrenNC?=
 =?utf-8?B?SkwvUk1XUTZRcFpJQ0lYOGJyY2FUSm9Xc0lwTGZhSnpmeTdPVk84bVpjckJ6?=
 =?utf-8?B?YXZ6MWNQRlA3WDFLaXNVcHpWckU3WXVNWERZSmxlMzFVUTJLelNLUWpGTlFN?=
 =?utf-8?B?YzNYRE9OS3A5blpWaUtpZlU0eVJNS0Nxd2g0UEVPTytMMHhPNk8vN3RSeDdG?=
 =?utf-8?B?SVdlWWhiNStaNEM3amRLV3FZMFhaRzFkL2pHTHVrcy9TNTQ2T1poTEdFNFhK?=
 =?utf-8?B?ajUwWkV2cEFmNjJmQ2s0ajNVUTh5Z0o0TTBGbWZkNHdQSGxVakZKNmh3ME1E?=
 =?utf-8?B?REFyNzlSRk4wTTlMRTM0aTFBRlU3ekRlNjJubnBPb0hvaXhXMDlXeEtubGJZ?=
 =?utf-8?B?WWVIcE1DTkhwSEpnSUM4a1hBNExXNFVjeFo5dUM2bTlva2RtNmJWcU9TeGZC?=
 =?utf-8?B?THY4UmExYnNhRnFnaWN5eW96ZkRZMjVTMC8xb2F5WUd2dS9IVjlsL0ZMc21J?=
 =?utf-8?B?RUhUZkFtQmVXbFdnemk1ZXVtc2NDZ2JoeDhMU3FKNEtNNE1lclFjRkxrd3Iw?=
 =?utf-8?B?OFc4U0dlZVBOdXJtZ0xPMTFxWDEyMzg1UEdyd2lFRzdrUG53L2hUemp2emZr?=
 =?utf-8?B?aTNwb28vNTNJeVhBbDd6RFdIaXl0aWx3V1A0bzFac3hQcmJSczN6bFEwMjBv?=
 =?utf-8?B?QnFDZUZ1UHhYc1lUdG5UbXBFZjdid0x1bVhHYU92RkpIM3ZjcEJORkdBRmt5?=
 =?utf-8?B?bGZhckVFRCtBK3JGVUNFZi93UGlhUWxGc1VJbDZqSGFYYkJIRlliNi9DRXMw?=
 =?utf-8?B?L3NHK1FhVHgzSmczcGFBd09QQ3RXOTN6eWM0SENXRExMdVJKTmdtUm81T2NI?=
 =?utf-8?B?bXk2Tkh5d1ZuVFc0dnovazkwd1VoczFvS0xHS2ROK2Y4bmUyK2tldGtWQk5K?=
 =?utf-8?B?RkJ5SXpubjd2Y3p3cEYwNER0L1dZRUp2L2xwSlRTbGgxVzFSalIrNkgrdU43?=
 =?utf-8?B?T2R5aU5iL08xd3QxZ3g5Z2RMNnVDSVNTbFdmdFFLK09HR2MzRGxjOTNDVGRx?=
 =?utf-8?B?Rmc0VFpNcVNWczJ0UU9GVmUydDN1R0lvR2hqT0dHL2JQS0xnZUxZMmtJUDYy?=
 =?utf-8?Q?3IiqpAcEuVGsIVfTM1hfdtY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78051c02-5923-4e32-b57f-08dbd626cc24
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 13:23:52.4540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LD6ayYCdOOp5+hhdN7ipIiXPOUGFCoChva2Q+0wWugV6pBVsplp6kpgGzTXnx0OnsuVs9xGZhc6vDgBtUIJ1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4816
X-Proofpoint-GUID: iKqQueAjE5g8ACJ5TeN8YnyOosamkxVN
X-Proofpoint-ORIG-GUID: iKqQueAjE5g8ACJ5TeN8YnyOosamkxVN
Subject: RE: [PATCH 13/19] RDMA/siw: Simplify siw_qp_id2obj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_11,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=871 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260115
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
MDIzIDg6NDMgQU0NCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsg
amdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCAxMy8xOV0gUkRNQS9zaXc6
IFNpbXBsaWZ5IHNpd19xcF9pZDJvYmoNCj4gDQo+IA0KPiANCj4gT24gMTAvMjUvMjMgMjE6MDQs
IEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogR3VvcWluZyBKaWFuZzxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gPj4g
U2VudDogTW9uZGF5LCBPY3RvYmVyIDksIDIwMjMgOToxOCBBTQ0KPiA+PiBUbzogQmVybmFyZCBN
ZXR6bGVyPEJNVEB6dXJpY2guaWJtLmNvbT47amdnQHppZXBlLmNhO2xlb25Aa2VybmVsLm9yZw0K
PiA+PiBDYzpsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBbRVhURVJO
QUxdIFtQQVRDSCAxMy8xOV0gUkRNQS9zaXc6IFNpbXBsaWZ5IHNpd19xcF9pZDJvYmoNCj4gPj4N
Cj4gPj4gTGV0J3Mgc2V0IHFwIGFuZCByZXR1cm4gaXQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEd1b3FpbmcgSmlhbmc8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+ID4+IC0tLQ0KPiA+
PiAgIGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmggfCA4ICsrKy0tLS0tDQo+ID4+ICAg
MSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPj4gYi9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ID4+IGluZGV4IDQ0Njg0Yjc0NTUwZi4u
ZTEyN2VmNDkzMjk2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3
L3Npdy5oDQo+ID4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gPj4g
QEAgLTYwMSwxMiArNjAxLDEwIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IHNpd19xcCAqc2l3X3Fw
X2lkMm9iaihzdHJ1Y3QNCj4gPj4gc2l3X2RldmljZSAqc2RldiwgaW50IGlkKQ0KPiA+Pg0KPiA+
PiAgIAlyY3VfcmVhZF9sb2NrKCk7DQo+ID4+ICAgCXFwID0geGFfbG9hZCgmc2Rldi0+cXBfeGEs
IGlkKTsNCj4gPj4gLQlpZiAobGlrZWx5KHFwICYmIGtyZWZfZ2V0X3VubGVzc196ZXJvKCZxcC0+
cmVmKSkpIHsNCj4gPj4gLQkJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ID4+IC0JCXJldHVybiBxcDsN
Cj4gPj4gLQl9DQo+ID4+ICsJaWYgKGxpa2VseShxcCAmJiAha3JlZl9nZXRfdW5sZXNzX3plcm8o
JnFwLT5yZWYpKSkNCj4gPj4gKwkJcXAgPSBOVUxMOw0KPiA+PiAgIAlyY3VfcmVhZF91bmxvY2so
KTsNCj4gPj4gLQlyZXR1cm4gTlVMTDsNCj4gPj4gKwlyZXR1cm4gcXA7DQo+ID4+ICAgfQ0KPiA+
Pg0KPiA+PiAgIHN0YXRpYyBpbmxpbmUgdTMyIHFwX2lkKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiA+
PiAtLQ0KPiA+PiAyLjM1LjMNCj4gPiBObyBsZXQncyBrZWVwIGl0IGFzIGlzLiBJdCBvcGVubHkg
Y29kZXMgdGhlIGxpa2VseSBjYXNlDQo+ID4gZmlyc3QuDQo+ID4NCj4gPiBZb3VyIGNvZGUgbWFr
ZXMgdGhlIHVubGlrZWx5IHRoaW5nIGxpa2VseS4NCj4gDQo+IEhvdyBhYm91dCBjaGFuZ2UgbGlr
ZWx5IHRvIHVubGlrZWx5PyBJZiBub3QsIEkgd2lsbCBkcm9wIGJvdGggMTMgYW5kIDE0Lg0KDQpq
dXN0IGRyb3AgdGhlc2UuIEkgZG9uJ3Qgc2VlIG11Y2ggYmVuZWZpdCBpbiBjaGFuZ2luZyBpdC4N
Cg==
