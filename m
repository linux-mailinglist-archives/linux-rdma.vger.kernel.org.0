Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65194766906
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 11:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbjG1Jg1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jul 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjG1Jg0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jul 2023 05:36:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BBA2
        for <linux-rdma@vger.kernel.org>; Fri, 28 Jul 2023 02:36:25 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S9WNEf031879;
        Fri, 28 Jul 2023 09:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=gdagTSY0c1AHgfGVF1SzjKazY9rtoesNcLId/5spnJ4=;
 b=KFbCbXEj7pN21rQZmTsF9VAbcoIQbvvAQaS0Lml8f7rjIU5+VbWT2nmjMJMvyo+oqsoe
 VAYTcIyZJE/fCWzB2r0mcYpuGTOgYrO0ZLzMThQl+6SnnrO42p7kvnRUpYNI/GozNBWG
 34vJr+6VZw7mYrQXyRU9h8FWHyRvI5jBU4Qehnock7CYTPfCovCT9ZrARX7Mi1EKuBRG
 IK3s0fTHRHJaIWztl+5SGaf6Mb7YeYj+cmZoGK00XJ2rZY+9qeQ0Fqa9HgOIuJ9UcPwH
 Unm4eUmrpEsJ3uq1UqJJ2xs4eoSBOnCENRGDQExlOvskScI7i2izqUf/ydQeYM/nyzIO BQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4b4mg915-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 09:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9jEzTijJYhVGPiRJq2vm1Y8UWAvg/7P0gFTGYvLrt9zmzlKLx370/BM13/TCyxttEZ6XGyhfE4InJAAvntPEWbRBIYfbxmzhiD+HvqSetkgQMJZNOYAu47qOIn9Mv3oz8gyWgVQvNG8GG4A/GWiAaPMQMvyB9Rsm1RX4Qfs6Znnobt39+2SDv8mj5lMxefY0No4W1X6imai3xwrbIzrqC/N9K0h3bAd+yhPW6Ydj1YSXAlzmdWxhV5Ob2GYwv89TWMleadc2tthkUWKyKq/16htMgK2k34yK2HHPbqsA3P3bBiCsUp7rWaB78kGwZUOw4WMD+45R74J23Kl6KmGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdagTSY0c1AHgfGVF1SzjKazY9rtoesNcLId/5spnJ4=;
 b=ZGOp7e4HueHwrBOMQdfCT1M+efAyeLKGbeM0+npaIehQZTCxtLfjnzZqmSn+zACMKkj4DHrfXdjuUzHxrJ+KuAe2vJJtwrEXLa4n/9NApTF+xXO809zJPWMab5KTkv7GfXM7j4wKWoJpdd8scVV2benxizQMAPjIm/dnvL4oly42xeG3XKDh8xlQS7JDZGwhKB8rCJCaB+OG+Z7ldtT+/QxW22fASP+p4WtROTjzIhRcTpC17yD0cbE/RLoJqDouDSQm4iUxtPBpadIVV65BA8/zZfkyLZnx3G/atHsMpKt3XyipLsxpMg5E5+TtjTz9NQFe+weklCZzfeXLBrrXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by IA1PR15MB6291.namprd15.prod.outlook.com (2603:10b6:208:444::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:36:08 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011%4]) with mapi id 15.20.6609.024; Fri, 28 Jul 2023
 09:36:08 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH 0/5] Fix potential issues for siw
Thread-Index: AQHZwK4/o6ZrLeh//E+K+kLVHm/vsK/N3mWAgACCeICAAItKIA==
Date:   Fri, 28 Jul 2023 09:36:08 +0000
Message-ID: <SN7PR15MB575501276B36F7C80EDAC8469906A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
 <ZMKpcQsJ3FBvxYHo@ziepe.ca> <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
In-Reply-To: <35286616-a53d-7aa5-b3b0-09ae44edf510@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|IA1PR15MB6291:EE_
x-ms-office365-filtering-correlation-id: 5a8c64f5-513f-4bf2-a37a-08db8f4e12ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wRGYzoMQ8NOQ4GZKjYDBlRb+mcdsIFfwa1nnqiBUVlmH7BnrYoimEzR2i1lVnjgaX0fWkfyYtnOnRrb8DgohSNN9EJV9dDPcFUUhHkfok7V9wWDc92/tzyQTqXB9lIXPGa3SWqbzLdHfVrKnVIBGWEgcq2sjy3LCtN6B2FDSAmKqOA+CQ+vgt9dCG6Ea5wLVLVyNvpV5ciV9Jf8PFdC7TajE1gFSwmUdiXCydQjS6eL8BEIa6ZFPe6d9Cx6dpk8Pmc/CTEHaZtW+2JJkYSdICWEz+Cx9AYSWAsET6pz38kl4lYawnx866EsfGh8X6A0wOvrvtJizsIekUmdaQPk8CTbt15MXd2U/9SceQSG5OlS3jAvlLZVIUuF3k3Bq9P0O9eHIprg26Qs1Cic3QbeJwTTHRhXyyX0lvut2zWE4qtt8SFZfK24azeBXbuu+eGzME5Ln4vatwnEbte9IBSilEreKgN80C/Nydlff9huAUH1yo9X/9trWJ1PV/ViXn8OvzAlUBHg2bAEQ+NF9rdOcmz2svzttYBLH7b5EbJFy1NhlMWnWI8W6XXChrRZ3OT/KgL8v59UP5JC++E8V2aLGqc7NHHminIFmOxS20VrOxKrLe/pzRet0NUuzzu3cCYA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(2906002)(316002)(8936002)(8676002)(52536014)(5660300002)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(110136005)(54906003)(478600001)(6506007)(53546011)(186003)(9686003)(83380400001)(66946007)(76116006)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhTSjNXejZxbFRBSHRjaDJRcVFIMk53bVU0aGs2Q2NpTlZMbzExNXVjY21W?=
 =?utf-8?B?bE05WWtyRzBRQVJQaDZYb0lsbzNEQS96NDcvME5hd2xoOVdnNVZaRjZMRlAy?=
 =?utf-8?B?bENnRXo5ZkdRMFlyeTV1anNQYVlFTlp5KzJLb0JjcmU2RlFIVVZSbXVuaG1v?=
 =?utf-8?B?cDJoZGdxeG9SbUx5UUxSaElsQi9HaUgzL0hzMFNDUHQ0dkkyZlVlMEt2UUZL?=
 =?utf-8?B?SE5TSXlkeWNuYUsrQnlwZVZ3bGFvL1Yvbk9qTk4xWjhxcDdnSmY3SFoxYWhF?=
 =?utf-8?B?RFU0Ykh2V3RUUytQeUdDSi9sZFd1SjlwZE5Kc3NjOFJkTVljOFltaFNTbDBm?=
 =?utf-8?B?TCtubHVRUENTMmVJK2trellON1BwWHhxRjBWY0pHRnFFaHBUcTdUUzRselY0?=
 =?utf-8?B?R1d1SGlGZnRyZllDRkN4T0tZdGxYZTlob1JoejczVzV0dzEyRGprSUJVaWVR?=
 =?utf-8?B?YWp5aFVYVHNqZTFtUjEyczNkV2VnMHFTWUdXNWx1NS9WWDlOU1pXNFppQWZ1?=
 =?utf-8?B?MURSMDNpdVNtVmVTSGcvZmtmaHl4eFd1dTR0Zlk4YXZFWjhsUTNwb2wrOVR1?=
 =?utf-8?B?ckpUVGk4eTBzc2lVeEdReXdXRWRyWGdmRzQyNW0xRUNEbXVEUEowRE9LaGZI?=
 =?utf-8?B?ZDhGMis2dExrODFxaWRIZWE5MGxuTFcyVWYrYlNwYTRCMXdVTmZrWkFwUmo1?=
 =?utf-8?B?akdoanpEclNCbjUwTys1YlFrUEd3aWMweHN5V1B3anlpbmJTSUNJYVVrUlUz?=
 =?utf-8?B?U3Fqdi84QW9JdU5PYW1xZ2xZQVE1TTU3bHlQcGp6Vjg0d0tkMVZuemdhVzAz?=
 =?utf-8?B?ZVkwWVFsYTU5MDYrVS9oRTZoOGtVVjQwN1daUTJ6Uytyc2dMWFdIbXE4VzIw?=
 =?utf-8?B?dnoxZ1h5UXlaR3k3aFRpdnpGUzdVbnRETWVPOTJ1TDV0YUtnNndSRTQwbGhy?=
 =?utf-8?B?U1lnZ1llWWo2TlQ3NHpIOUtZbFM3OE9JdFoxM0R4WFFzNlIxTXlFYUFjaUZD?=
 =?utf-8?B?RTNlbjZvNDFvZU1wWkQzYnIweEE5eDM1ZHRmSkJzOGFKWnBNeVdzRUcxSTJ0?=
 =?utf-8?B?YWRLNFBBMHpLRHc2cjEwcXIxMUthbHVadng5Zi9PSjkzUjFVcHNTNE1mUkxJ?=
 =?utf-8?B?WTY0RHJycG1hRTVMbWd1VWJBbGRkek42QXdsdStlSU04alVtcEtGZElGYXlp?=
 =?utf-8?B?c1ozOWRrb2JyM1VqUk41RWNwbzdRN1NLaUNDRHpvck5mRkxkTGRaVDc4STZ1?=
 =?utf-8?B?OVduQnlsUTFXckZhUHdwNEQ3UDJEbjlvaUJ0d1UxSUI2ekxrd3NUamUycDM2?=
 =?utf-8?B?b3NjZFAxWHVYTmxrbk11anZtQnhoaHlNMjlOZ2VZTytpSDhPOWxVbzFVVzZX?=
 =?utf-8?B?dW15MkFWeWVNSWEyQkoyWW45aVl4U2dDS1NnNGM4VkFFSFluY1hxWlMwaDdQ?=
 =?utf-8?B?MXJhMkJOZFpsZHdUMmdmQTlLTWFHR0hMWW5uVVF1OWN3dVgwN0gxNjM5Y2pO?=
 =?utf-8?B?Vy8vMFpFVTArMmtMYXhpRzV2OEpRcXdnblJmTHlPaWtjYS9UZTllUHN4aFRH?=
 =?utf-8?B?NzI4dkpoMnpQMXVHK3BQNjc2TWhiWTlsckNHSWhHYWpkaC9hN21NWDJnYkF5?=
 =?utf-8?B?VTcxTU5DZGJHUklKZWRGSFBZNDBjQjJ2WVQ2RTNqcnBxUW1EOGpVcXlxZS96?=
 =?utf-8?B?YmwvUWdBTlc0RGQwdEZGS2pBL1ZnUUZBaTh4M3ZaK1pscm9xTzhacDVuUUN3?=
 =?utf-8?B?Z0d5bFdlcFJ1TGdOT0RBb2c0Z0E5bWhvanVBRnNtQWV6UDVwbVhTK1kvY0Mv?=
 =?utf-8?B?ZkxzelhtYm5hSVFzTnpYNEdudW9VdnFNUURPUTF4allYM0ZtbWlQbWVBQmM0?=
 =?utf-8?B?bC8xeEd6anFFZDlmbWc1VGZya3lUWnMvVllzc3FyTVdpN0N0eUtEVG0vWjh5?=
 =?utf-8?B?dzgwVW40bURVSnY2eXUzdnhRZUxxR2VpNG9wK1IwNkR3enE5YkpYSTQ2ZEtJ?=
 =?utf-8?B?SndueHZxWE5UNG9CaENzbmYwMlJySjd4VnM0QUxQbGc5Y3ZLcDZkNjdxM1pR?=
 =?utf-8?B?K2xZU0VaVHExSm1ueFh4UzJOZ3RYUGdweGVFQzl1N25lSzhkWGtOY1F1UVB3?=
 =?utf-8?B?Z3NoRzhFZUpUTU1yWWxVRDNYY2Z4VlR1eFRwOWZENFBEUDIyOEFya1I3czQ1?=
 =?utf-8?Q?OGMmyTiGAuIXLBP0PPW++IE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8c64f5-513f-4bf2-a37a-08db8f4e12ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 09:36:08.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6u2niL6OFmE4heAhpf8ZOsZ7U0ry3PGqgzp0oV1SdjjxggtA0ECqIJpkU+G6qOCSSKDWzrOHRf8FpMlLuGreAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6291
X-Proofpoint-GUID: SEcRbyHs432ZY3qBgj0r9TtksDIMryrO
X-Proofpoint-ORIG-GUID: SEcRbyHs432ZY3qBgj0r9TtksDIMryrO
Subject: RE: [PATCH 0/5] Fix potential issues for siw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 mlxscore=0 mlxlogscore=971 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgMjggSnVseSAyMDIzIDAz
OjE2DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IEJlcm5hcmQgTWV0emxl
ciA8Qk1UQHp1cmljaC5pYm0uY29tPg0KPiBDYzogbGVvbkBrZXJuZWwub3JnOyBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggMC81XSBG
aXggcG90ZW50aWFsIGlzc3VlcyBmb3Igc2l3DQo+IA0KPiANCj4gDQo+IE9uIDcvMjgvMjMgMDE6
MjksIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBUaHUsIEp1bCAyNywgMjAyMyBhdCAw
NToxNzo0MFBNICswMDAwLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4+DQo+ID4+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTogR3VvcWluZyBKaWFuZyA8Z3VvcWlu
Zy5qaWFuZ0BsaW51eC5kZXY+DQo+ID4+PiBTZW50OiBUaHVyc2RheSwgMjcgSnVseSAyMDIzIDE2
OjA0DQo+ID4+PiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBqZ2dA
emllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiA+Pj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnDQo+ID4+PiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCAwLzVdIEZpeCBwb3RlbnRp
YWwgaXNzdWVzIGZvciBzaXcNCj4gPj4+DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBTZXZlcmFs
IGlzc3VlcyBhcHBlYXJlZCBpZiB3ZSBybW1vZCBzaXcgbW9kdWxlIGFmdGVyIGZhaWxlZCB0byBp
bnNlcnQNCj4gPj4+IHRoZSBtb2R1bGUgKHdpdGggbWFudWFsIGNoYW5nZSBsaWtlIGJlbG93KS4N
Cj4gPj4+DQo+ID4+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMN
Cj4gPj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X21haW4uYw0KPiA+Pj4g
QEAgLTU3Nyw2ICs1NzcsNyBAQCBzdGF0aWMgX19pbml0IGludCBzaXdfaW5pdF9tb2R1bGUodm9p
ZCkNCj4gPj4+ICAgICAgICAgIGlmIChydikNCj4gPj4+ICAgICAgICAgICAgICAgICAgZ290byBv
dXRfZXJyb3I7DQo+ID4+Pg0KPiA+Pj4gKyAgICAgICBnb3RvIG91dF9lcnJvcjsNCj4gPj4+ICAg
ICAgICAgIHJkbWFfbGlua19yZWdpc3Rlcigmc2l3X2xpbmtfb3BzKTsNCj4gPj4+DQo+ID4+PiBC
YXNpY2FsbHksIHRoZXNlIGlzc3VlcyBhcmUgZG91YmxlIGZyZWUsIHVzZSBiZWZvcmUgaW5pdGFs
aXphdGlvbiBvcg0KPiA+Pj4gbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlLiBGb3IgbW9yZSBkZXRh
aWxzLCBwbHMgcmV2aWV3IHRoZSBpbmRpdmlkdWFsDQo+ID4+PiBwYXRjaC4NCj4gPj4+DQo+ID4+
PiBUaGFua3MsDQo+ID4+PiBHdW9xaW5nDQo+ID4+IEhpIEd1b3FpbmcsDQo+ID4+DQo+ID4+IHZl
cnkgZ29vZCBjYXRjaCwgdGhhbmsgeW91LiBJIHdhcyB1bmRlciB0aGUgd3JvbmcgYXNzdW1wdGlv
biBhDQo+ID4+IG1vZHVsZSBpcyBub3QgbG9hZGVkIGlmIHRoZSBpbml0X21vZHVsZSgpIHJldHVy
bnMgYSB2YWx1ZS4NCj4gPiBJIHRoaW5rIHRoYXQgaXMgYWN0dWFsbHkgdHJ1ZSwgaXNuJ3QgaXQ/
IEknbSBjb25mdXNlZD8NCj4gDQo+IFllcywgeW91IGFyZSByaWdodC4gU2luY2UgcnYgaXMgc3Rp
bGwgMCwgc28gdGhlIG1vZHVsZSBhcHBlYXJzIGluIHRoZQ0KPiBrZXJuZWwuIE5vdCBzdXJlIGlm
IHNvbWUgdG9vbCBjb3VsZCBpbmplY3QgZXJyIGxpa2UgdGhpcy4gRmVlbCBmcmVlIHRvDQo+IGln
bm9yZSB0aGlzLg0KPiANClJpZ2h0IEkgY2FtZSB0byB0aGUgc2FtZSBjb25jbHVzaW9uIHRvZGF5
IPCfmIkgLSANCmlmIHlvdSBzZXQgYSByZXR1cm4gdmFsdWUgaW4geW91IHRlc3QgdGhlIG1vZHVs
ZSBpcyBub3QgbG9hZGVkLg0KDQo+IFRoYW5rcywNCj4gR3VvcWluZw0K
