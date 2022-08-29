Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D35A4EB5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 16:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH2OAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH2OAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 10:00:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D9A38B3
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 07:00:09 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TDlvSM031658;
        Mon, 29 Aug 2022 14:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=muI/2b3XUln5GxaDc4KCnftaf+gNL3jEUj3r7gLe2Vw=;
 b=bBQE0+mQ0OI6LBPHBHCOogJx7tjYnXVh/M3BfFUZCchqF68I9Fn0JPtkfRG91PBKkHBf
 D6yzgfBllL/WknEg7HQ/vEVPRDHkvzVl3N+zVwEsz00HIcMJArxsmrbNgLPBz/xw5bh2
 7CcFL2BTJGzrSVVYvE5OvVMxSnZzX8iFrBhBqSAmZZJLUuorNQ+oUAoesaXasm4k7ZJB
 LSKmbnQJ6sK6IGXWM6REZ/oSdWJ7uQ/FinuuzS78kcGUdIzn34Uuwvpx0Lhe31rfN4MH
 4uHvqdXrcxUn2d6UDa3koI10pNOnLEqOLZzUjHdflV2IGcmE3Eh2O4y9u2aaMol3nTBp aA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8x9c165m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 14:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFpRGp/1fUtVm7J5YKdccXSW+5au5zRGbV9wxg4nHbGuL+Y69AtzosXUkFMtSa5zZL7xNqX90uS+6XTMQmNk4e8liq4CLi77xNBeDjBIP4pYzGBIqV5LvrsM/7ZQWjuC3E/4o4I+a/tXynSuUpnP7DlWISG0g6LftV2ky5ZNB0WncxottXjLi9el1aZybK+w4EtTb9hT1b7jZ7d/Pi8HxP6JswxlUtv6CVl0adTa4LgZbiAFvCMYUl1kJqIG9YGmwneLHW/q194C3yrYreINK2rsrk8Yb+NhjI4bhM2Ffe34Riq/01DYTBKVQNI0S45q5y1yCBDSGTs7MTNFQdkP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muI/2b3XUln5GxaDc4KCnftaf+gNL3jEUj3r7gLe2Vw=;
 b=oMsz9kaRJj5io47NM+E+SqHR/jN0QIUMTamcT1tww8faPIURi5eYCuGqTZFSWXVYfExQf3wGxy2nFEz+LFPVpP/lRC5Tdj03qOyqjMcdy3wC++YVh4PXLS2PQFGcLfy90qT5bXno2PYWlUhXF5ClvNI5GpDY+A8rUvgDzEyFxKq2XBLfhhnVfH1ndsxucgvJZDxA/SwHbvzGiiCUTza92y13Elh2NwLQEgB23Qit2QZJ8aaG4YLJV/fG03S7pU88Mld27vKWJMX+GV01CykGvdVAlrUTXV+hncl6qjYPVuDutgCmPiiZbQNOwn6U7xXJbVnhWrTFaKwhm1CLJPQ9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SA0PR15MB3919.namprd15.prod.outlook.com (2603:10b6:806:91::20)
 by BN6PR15MB1332.namprd15.prod.outlook.com (2603:10b6:404:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:00:04 +0000
Received: from SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80]) by SA0PR15MB3919.namprd15.prod.outlook.com
 ([fe80::5532:77b9:63ce:1f80%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 14:00:04 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Topic: [PATCH] RDMA/siw: Pass a pointer to virt_to_page()
Thread-Index: Adi7rwbUue4/w8sSRG+KluQnITqbPg==
Date:   Mon, 29 Aug 2022 14:00:03 +0000
Message-ID: <SA0PR15MB3919305924CD369C1245047C99769@SA0PR15MB3919.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d76fb04-4d74-4da5-e130-08da89c6c5bc
x-ms-traffictypediagnostic: BN6PR15MB1332:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rxkPtdbfBll82hH9PTUOsZ+s0QDVzrjfnSPfLrAWJNevE4PQ6CiAYgnQysrp0guzesfYTG/5cHVWbuibJ6r92jkY8Bt6Cy9pl5og1EFsLkV8rT3lPUzLhJ0r+uN0vDk2kTvDtF/FkrExpr6SroYYRC3gtfoaifFNY74aHt05D4Lg5O8Kpt1N7YobDM0KDS64GB8oDDGNzqH2bJd+uo6daSFqpkd2YszQ2m9hrZB9X1JrZXZ5cGYRnK+0RXeW7jmOEqorEK9APidjw6k1syKKRICE/pSnQMpY1e4YIrO1gly65NB+3Ofh+ouH7Si7Q+oUQU46FekZL2aJGWHOE5+uVR2vpddZGntMc9E1FcGM8RItA+KUIGx6BFgJp0ihAZJvgiBmuoaf+qi/PPIpWg1fBqiSx//mgqePVZe4gakPnHPiTom+n7LN5GH37NuB9lDrlWcdziffJLoMhRrh6Qo9Toj+3T1+IhuN/uqo/Xt0LdxdP1kWNmBGEKrPkw6gMQeMhpLnowH9OuQDuLNbxfyywZHuCPXpNDdofC4kO824oc+sIerdzSndvitxtsNehOJZsTlURi5HFOdqzZlbqKKPIhqEUfl0OL7TOoRmCbK8GTT7Ho0kYkcpwLgKq7q1WjXCiZU5qaMm+rFcFzLYZeY9ra478Ol6c8msXC/ZFpU9kk4rYxPbJuTDLzhH5OHwC2cy/zwTKMiO69O4ea2bWX1VlLdLgAhBsceB+8SjbGVPFs7KIS3+sny4FZNTXtQp8eDtK+2R5EnkB1OnfkaQpynJrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3919.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(376002)(346002)(39860400002)(38070700005)(122000001)(71200400001)(110136005)(38100700002)(316002)(9686003)(8936002)(6506007)(52536014)(7696005)(8676002)(41300700001)(66946007)(76116006)(64756008)(53546011)(33656002)(2906002)(66556008)(66446008)(186003)(83380400001)(86362001)(4326008)(66476007)(5660300002)(478600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGs4VFN3Ny93TzJYZUl1OXBFWnE3MWhML0VXcmxNSzQxdjZEYWhzRDBBVklJ?=
 =?utf-8?B?WlZaQi8rSzZkRytoMzB6UVBheGxoZmNGSmp2L3Q1bjNBMEkvaTB0aDM0NnVu?=
 =?utf-8?B?ejY2VU5Va0RnblplVWRUREx5S1pncGkyNWZlL0hHZUZEVE1mUmVWeTB5dWZZ?=
 =?utf-8?B?M2xtQ3NNQ0FmVUNWK0dHR1hzZXRzWUtJSWJWZEhaNDVyNS9YeXF4RVEreHFw?=
 =?utf-8?B?UW5zVUJITkpoVS9tSVl2ZHd2eFRMRU1CSzg2MDlIdzdmSDJYTFRtSjR2d29s?=
 =?utf-8?B?akdNK0FoTUxuWDdyMjhVNnNqc1hIOTlIUHBYaUJkL2ZqY2xLOGFtVDlJSHU3?=
 =?utf-8?B?VHgxa1lxdFhjQXF3bWsrSjBBanN4NDVQWU9vREJhZEJHRTdWQXUybEhRd29l?=
 =?utf-8?B?YWdlOGRmMXkvekNWM2lnZnFBTU1Rd2hVNGQzQklwbGJhMlp5Ukt1dGY4eDBx?=
 =?utf-8?B?eVN6VjRqLzl3bzZ0djVOZVJyYlptSVRvRjZLR2pWN2c5bk9HTG1wOFFyZU5j?=
 =?utf-8?B?aUlRSXl4MUNwaUhoR2plTW40RzdwZE02QzVpMGorQzIxV2VVUzV6OUJTV0sx?=
 =?utf-8?B?R3dGNHdXaks5TGQxS2JadWNhZEUrbDZtZnVNVzkzTW9Jakk0cnVXdHpMR3FG?=
 =?utf-8?B?ZnBJZ2Y3MUxxYUQ1NUIvTXhiMFd6RU4wY3c1ai9SSEpUYTNkSU9ReElsSnc4?=
 =?utf-8?B?WHZWVUdjT3lBRWlKVWtRM1h3emF3NVJ2eEpESExPbUJhZy8raGVDZzZSbnlL?=
 =?utf-8?B?N2hScEc0bVd2cUNROEJkNWdZa3IvcktCVFVscDhEQWhHMWFudnRWMWhFY0pQ?=
 =?utf-8?B?UmFCZVExR1o2NU5vNlFzQUZ0cWZQaEh3YTdGN1IxOUM5UlZVbTJSQXJDZ0wz?=
 =?utf-8?B?R2VCYTZuaW9NUXArNm1CeXBJcTErTTFuYkpPVys3Z1l5T1FFK0tTS1BGMis4?=
 =?utf-8?B?N2hrSWw5dExKV0R1eEVGaWhFZVFveXB3K2F2SHNzNjZhQjg1TXZiN3pIM1Ja?=
 =?utf-8?B?eHE1cUZKd0VzcUpBdFRlOWtaaEVRc1lBd2lSMTc0ZXlGcy9SSXZmWEVwZkt5?=
 =?utf-8?B?eHV1QUZyZ2hMdm5OT1FJa2MxYzZvTzVrajh2NFlveHVHSVFTbnpoNitYM1lz?=
 =?utf-8?B?RDhscmxER21sTUZ5blZveHhCQklGbVpIc0NyTmtjelE1dWE3djR0NU5USi9O?=
 =?utf-8?B?TlFodUMyQU9TWmRzbW9walRLRWxwMkpQVFNNeW5qT0hNUkhDdHlvdE5Fb3hG?=
 =?utf-8?B?TjNYd2E0VFlpS0RHWDhlZjZlZndMUWNtYUpxdmlhaFFodlE3UTAzbmpUUFRF?=
 =?utf-8?B?U2VtaXcrTWtIbFZEV0xvcFcyZmQwR2FGSllSa2NhbitObXM3R2lPRThtVU80?=
 =?utf-8?B?U2xlV3lFY1BGUGhUZWgyQ21DSkxXM1JFMitWa0FRU04yckVoODlHczVPNlNZ?=
 =?utf-8?B?OFE5T3ZwSk9ML0dtbDhMU2hhUS9PSjZPVEQxY2wwR1Y3bUVydkNXUHNpQSti?=
 =?utf-8?B?TWpSbHBxQXUwRXBYNmxZMWJ2RndFekZUVnVPWkVQdGkyUTZaZjlJdTVRRVd2?=
 =?utf-8?B?NGFjUUxMejIyZEFIVFBpbjZPdWNiNG81amF0SFhQbVhqK2ZIL2U3d0pXeHBB?=
 =?utf-8?B?enNKVjF1SkYwNnlZRkRQMXpRN01ZVVA0WU5pTnFLbXhoNVNMdEZDTVNSZk1Z?=
 =?utf-8?B?VnhLamdDZldnMGpDYmRhSmJXZTNIUytaYThiaU9WSUh1ZWwyV3RRMGwzTk95?=
 =?utf-8?B?Vk1ESDY1dU16OGRieDRvK2hxMUE0WVJ3UkdOTGx3S2Z2MGpCcmdocGVQN0tl?=
 =?utf-8?B?UG0wU1o5Rmk2QUpLQm80QUhNR0NpQjB6OWxCd0hzTUduSHQ0dFFPdk9XWUZO?=
 =?utf-8?B?d0lmUjRnSXhGZnB3dXRXNU1Wem51MjJ4dzBLa3BvQkhrK0x5T0FuWjZzdjZZ?=
 =?utf-8?B?aVF1VU1aOFJISjBMejQ4QU9kMzc2NnBUc1FMVENESnlrWTF0Q3hzZGlMZVdJ?=
 =?utf-8?B?Z1RPK0t2NnphTjFWTnVDSWttdjBpV2xTSWozWVZ6bFlPMUV0UUJBaU0rN3Ra?=
 =?utf-8?B?bnlFN0N0L1J5VE85RnRsQnllQW9PN0dhVy9NU2ZpWFpMR3h5L0xIK1hxZVJD?=
 =?utf-8?B?QTVSdmFvWTYxeFNEUit2Uk1pQm5MOFhxOUlmeUg0M3A0V1A4SVZNbHRveGo5?=
 =?utf-8?Q?Wy3hLsYoZFD+WW0PBYFBGzM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3919.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d76fb04-4d74-4da5-e130-08da89c6c5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 14:00:03.9585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKwl+5Fal+7v4EiYmTsoqFtZH6IpunONA3boRaxUA7Y2gGLNCEVTbC/I4+woENJks0iMcjNGhTEyf9loV4WZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1332
X-Proofpoint-ORIG-GUID: FoQ7mrmvHZmG8cqutogb-5rOas4SLurZ
X-Proofpoint-GUID: FoQ7mrmvHZmG8cqutogb-5rOas4SLurZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_07,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXMgV2FsbGVpaiA8
bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIDI5IEF1Z3VzdCAyMDIy
IDE1OjI2DQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTGVvbiBSb21h
bm92c2t5DQo+IDxsZW9ucm9AbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJu
ZWwub3JnOyBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFN1Ympl
Y3Q6IGZnW0VYVEVSTkFMXSBbUEFUQ0hdIFJETUEvc2l3OiBQYXNzIGEgcG9pbnRlciB0byB2aXJ0
X3RvX3BhZ2UoKQ0KPiANCj4gRnVuY3Rpb25zIHRoYXQgd29yayBvbiBhIHBvaW50ZXIgdG8gdmly
dHVhbCBtZW1vcnkgc3VjaCBhcw0KPiB2aXJ0X3RvX3BmbigpIGFuZCB1c2VycyBvZiB0aGF0IGZ1
bmN0aW9uIHN1Y2ggYXMNCj4gdmlydF90b19wYWdlKCkgYXJlIHN1cHBvc2VkIHRvIHBhc3MgYSBw
b2ludGVyIHRvIHZpcnR1YWwNCj4gbWVtb3J5LCBpZGVhbGx5IGEgKHZvaWQgKikgb3Igb3RoZXIg
cG9pbnRlci4gSG93ZXZlciBzaW5jZQ0KPiBtYW55IGFyY2hpdGVjdHVyZXMgaW1wbGVtZW50IHZp
cnRfdG9fcGZuKCkgYXMgYSBtYWNybywNCj4gdGhpcyBmdW5jdGlvbiBiZWNvbWVzIHBvbHltb3Jw
aGljIGFuZCBhY2NlcHRzIGJvdGggYQ0KPiAodW5zaWduZWQgbG9uZykgYW5kIGEgKHZvaWQgKiku
DQo+IA0KPiBJZiB3ZSBpbnN0ZWFkIGltcGxlbWVudCBhIHByb3BlciB2aXJ0X3RvX3Bmbih2b2lk
ICphZGRyKQ0KPiBmdW5jdGlvbiB0aGUgZm9sbG93aW5nIGhhcHBlbnMgKG9jY3VycmVkIG9uIGFy
Y2gvYXJtKToNCj4gDQo+IGRyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6MzI6
MjM6IHdhcm5pbmc6IGluY29tcGF0aWJsZQ0KPiAgIGludGVnZXIgdG8gcG9pbnRlciBjb252ZXJz
aW9uIHBhc3NpbmcgJ2RtYV9hZGRyX3QnIChha2EgJ3Vuc2lnbmVkDQo+IGludCcpDQo+ICAgdG8g
cGFyYW1ldGVyIG9mIHR5cGUgJ2NvbnN0IHZvaWQgKicgWy1XaW50LWNvbnZlcnNpb25dDQo+IGRy
aXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmM6MzI6Mzc6IHdhcm5pbmc6IHBhc3Np
bmcgYXJndW1lbnQNCj4gICAxIG9mICd2aXJ0X3RvX3BmbicgbWFrZXMgcG9pbnRlciBmcm9tIGlu
dGVnZXIgd2l0aG91dCBhIGNhc3QNCj4gICBbLVdpbnQtY29udmVyc2lvbl0NCj4gZHJpdmVycy9p
bmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYzo1Mzg6MzY6IHdhcm5pbmc6IGluY29tcGF0aWJs
ZQ0KPiAgIGludGVnZXIgdG8gcG9pbnRlciBjb252ZXJzaW9uIHBhc3NpbmcgJ3Vuc2lnbmVkIGxv
bmcgbG9uZycNCj4gICB0byBwYXJhbWV0ZXIgb2YgdHlwZSAnY29uc3Qgdm9pZCAqJyBbLVdpbnQt
Y29udmVyc2lvbl0NCj4gDQo+IEZpeCB0aGlzIHdpdGggYW4gZXhwbGljaXQgY2FzdC4gSW4gb25l
IGNhc2Ugd2hlcmUgdGhlIFNJVw0KPiBTR0UgdXNlcyBhbiB1bmFsaWduZWQgdTY0IHdlIG5lZWQg
YSBkb3VibGUgY2FzdCB0byBnZXQgdG8NCj4gYSAodm9pZCAqKS4NCj4gDQo+IENjOiBsaW51eC1y
ZG1hQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Np
dy9zaXdfcXBfdHguYyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3Npdy9zaXdfcXBfdHguYw0KPiBpbmRleCAxZjRlNjAyNTc3MDAuLjVjNzg1M2JhODgzMSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfdHguYw0KPiArKysg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+IEBAIC0yOSw3ICsyOSw3
IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqc2l3X2dldF9wYmxwYWdlKHN0cnVjdCBzaXdfbWVtDQo+
ICptZW0sIHU2NCBhZGRyLCBpbnQgKmlkeCkNCj4gIAlkbWFfYWRkcl90IHBhZGRyID0gc2l3X3Bi
bF9nZXRfYnVmZmVyKHBibCwgb2Zmc2V0LCBOVUxMLCBpZHgpOw0KPiANCj4gIAlpZiAocGFkZHIp
DQo+IC0JCXJldHVybiB2aXJ0X3RvX3BhZ2UocGFkZHIpOw0KPiArCQlyZXR1cm4gdmlydF90b19w
YWdlKCh2b2lkICopcGFkZHIpOw0KDQpUaGFua3MsIGxvb2tzIE9LIHRvIG1lIQ0KDQo+IA0KPiAg
CXJldHVybiBOVUxMOw0KPiAgfQ0KPiBAQCAtNTM1LDcgKzUzNSwxNyBAQCBzdGF0aWMgaW50IHNp
d190eF9oZHQoc3RydWN0IHNpd19pd2FycF90eCAqY190eCwNCj4gc3RydWN0IHNvY2tldCAqcykN
Cj4gIAkJCX0gZWxzZSB7DQo+ICAJCQkJdTY0IHZhID0gc2dlLT5sYWRkciArIHNnZV9vZmY7DQoN
Ck1heWJlIGJldHRlciBjaGFuZ2UgdmEgZnJvbSAndTY0JyB0byBwbGF0Zm9ybSBzcGVjaWZpYw0K
J3VpbnRwdHJfdCcgPyBUaGF0IHdvdWxkIGF2b2lkIG9uZSAodWludHB0cl90KSBjYXN0IGhlcmUg
YW5kDQphbHNvIGEgZmV3IGxpbmVzIGRvd24gZHVyaW5nIGNyeXB0b19oYXNoX3VwZGF0ZSgpLi4/
DQpNaWdodCBhbHNvIG1ha2UgaXQgZWFzaWVyIHRvIGtlZXAgbGluZXMgdG8gODAgY2hhcnMgOykN
Cg0KVGhhbmtzIExpbnVzIQ0KDQogDQo+IA0KPiAtCQkJCXBhZ2VfYXJyYXlbc2VnXSA9IHZpcnRf
dG9fcGFnZSh2YSAmIFBBR0VfTUFTSyk7DQo+ICsJCQkJLyoNCj4gKwkJCQkgKiB2aXJ0X3RvX3Bh
Z2UoKSB0YWtlcyBhICh2b2lkICopIHBvaW50ZXIsIGFuZA0KPiArCQkJCSAqIHRoZSB2YSBiZWlu
ZyB1aW50NjQgY3JlYXRlcyBhIHNwZWNpYWwNCj4gKwkJCQkgKiBwcm9ibGVtIGhlcmUgbmVlZGlu
ZyBhIGRvdWJsZSBjYXN0IHRvDQo+ICsJCQkJICogcmVzb2x2ZSB0aGUgc2l0dWF0aW9uOiBmaXJz
dCB0byAodWludHB0cl90KQ0KPiArCQkJCSAqIHRvIHByZXNlcnZlIGFsbCB0aGUgNjQgYml0cyBh
bmQgZnJvbSB0aGVyZQ0KPiArCQkJCSAqIHRvIGEgKHZvaWQgKikgbWVhbmluZyBpdCB3aWxsIGJl
IDY0IGJpdHMgb24NCj4gKwkJCQkgKiBhIDY0IGJpdCBwbGF0Zm9ybSBhbmQgMzIgYml0cyBvbiBh
IDMyIGJpdA0KPiArCQkJCSAqIHBsYXRmb3JtLg0KPiArCQkJCSAqLw0KPiArCQkJCXBhZ2VfYXJy
YXlbc2VnXSA9IHZpcnRfdG9fcGFnZSgodm9pZA0KPiAqKSh1aW50cHRyX3QpKHZhICYgUEFHRV9N
QVNLKSk7DQo+ICAJCQkJaWYgKGRvX2NyYykNCj4gIAkJCQkJY3J5cHRvX3NoYXNoX3VwZGF0ZSgN
Cj4gIAkJCQkJCWNfdHgtPm1wYV9jcmNfaGQsDQo+IC0tDQo+IDIuMzcuMg0KDQo=
