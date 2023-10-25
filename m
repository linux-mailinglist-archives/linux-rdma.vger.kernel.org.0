Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A57D6D00
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJYNVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjJYNVG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE230131
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:21:03 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCeCxX018016;
        Wed, 25 Oct 2023 13:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZUKD8fBaxJyyJXtFnfS5hGuUY2Furyro6mStuXB6b10=;
 b=JFzfzxDmJkUVypaUOXbsYNtfWLNnDZnp3V6vyWI5BHMWV9RPrC2osk4isw6K7h4G83OP
 QVPBS0uuRXx+3oQtli5rTsjTfXuPAfVqnKZmVOf+4rPsisqk8lMQ4nNCOAsGUX71WSnl
 6xoV570l+WinV1eqI4ISlTNiHzePMmn+tq4i5sA1S8etTYTCf4kUOjrlqzcUNFS/BwxX
 WXXOySYLHFj5mwnYU0gvFObJaMAcOZ7MdJH2y78LDjfD8oV/74/+JevBG9PO2CzG7STu
 QmlO0KGsgrJnQ3gTfPxGFhStu8z7zHIkjF4TSiMJ1sw+OjBrNOj1IJqw6L9CBE8Hnac2 Ow== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty37r1mxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5h51JeTBqKxy3jV68QoJHb7IFEEfNLEvQLWOmxSkzTy95gh9079bp67AG3bNfnpkgCoJnQPMPnksWPE7srYlMWQGMUna+R3yBZ6xfX3UJR6YsYGFHUTX7J2ShrZ2K954e/GP5i1OoL69b6fjrYRcB3cxlrMDn415FTkFQ6R5hx6Z/SIon3tysoIzi7nF2j0vdOn1DH1OSY2fcN/W4X1Da80ch51VCspO3Y/aCV5Jp/JmW1e6YzoMJqkZKiPGtpf7thi/EpWAj7FkeNgUvCgh7dWU5TvQRtzd2UDXjfXD2M6+gLeW0dd+NLI9vyeywcNGJ3x2ElUZxEHtPf8HOhmDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUKD8fBaxJyyJXtFnfS5hGuUY2Furyro6mStuXB6b10=;
 b=bsNFsa76mKNT9eH0A6K8HQeUd6Asm2UGitPlw81Mt2BMSzn2XWDmz5faf+Nbed4UpxAASJJdaJG+SC3vJzjDHm/l1wct0KpBIPZv5Pz811vwOGfWaHf1/6uwDWxSPtpjkSJogRZ6PhX3tKMo7f+mQuGqw4YsWBTKjrUBEV/YVM0NOmEhrxXbW4yCpF7DiibYbs0ESgH6gKaBVD57eDys+lWRkn7PcoZCbPynwvzMBX5IwEjcisr3n/5aRJIIZrsGnELIsuxtjdGdMAwjcadWS4+oRqj5Fl9WL5m7+pvVmkrU6bA/gIAE34GS/eQ1vnHajbInwIVRoxHX6mf2a1EwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by SA3PR15MB5656.namprd15.prod.outlook.com (2603:10b6:806:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 13:19:05 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:19:05 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
Thread-Topic: [PATCH 16/19] RDMA/siw: Remove siw_sk_assign_cm_upcalls
Thread-Index: AQHaB0XUA1ZDAo9ne0qoGOWR4Pzm0A==
Date:   Wed, 25 Oct 2023 13:19:05 +0000
Message-ID: <SN7PR15MB5755801084BA9B601315A31699DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231009071801.10210-1-guoqing.jiang@linux.dev>
 <20231009071801.10210-17-guoqing.jiang@linux.dev>
In-Reply-To: <20231009071801.10210-17-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|SA3PR15MB5656:EE_
x-ms-office365-filtering-correlation-id: 259221ec-cc5f-4ca9-41ea-08dbd55cf6a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7amaS66NDwy0wyCQpjJdKlOlTUp+/B2URmaJ8SoOOJBp7rmwpDGf522JGwMoj53JjgccoBw7M4S+f2JQOoO2NkA9A7DKw09XDe6gcOiMHuoVzQHrgisE5bEZRkFnEmZQfTcULD3/dikXQXzFpZs+HZRhcM8USN1HRrbIiFaUdJ053vm+Oxy6uB8MZ6PKfidITpURY8ywUU2Zv1eRqd//ruNX9EqTNrwZM0/QwhO4t9M9EXc3iaHFejEHwSjm03sQ2H8v1Tv6gXH4ANL9PSxPIRp4gcKj86wbcze86MyCZf0XqNzA2dx309YnY2ycHBRedsC0Y6iPKVWNiKF67TQOyRZdlm5ipHwLzgzq5P8iSeG7kLDmbi7Ee5lsI6pgGPOsCMiC5EgTDR3e//fzmlfSCVYLUXQ6sNEIZAjjjHNnA6SgAuUb5b2q1uePxH3vB3X/g0HUDyBmMKjOYkmPP01HhowajNiZJblD77Fjoth4hiKeArp7HAPi9/PUwqXerza3euinkv6fVOREKEmySELOqZtCnE20oooI9JNyFAWwVAnfCeDmwiIul5ZFwDrIW1tfbK4LEGQ7bHJUFBnVy+4Vpu+hH1S34p4q99lQ8FQAGcM1vJdMCumA0xsS51g9TQBY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(8676002)(52536014)(2906002)(8936002)(4326008)(41300700001)(38070700009)(5660300002)(83380400001)(7696005)(122000001)(71200400001)(53546011)(38100700002)(6506007)(9686003)(33656002)(66476007)(66446008)(66556008)(64756008)(66946007)(86362001)(316002)(110136005)(55016003)(478600001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhWVGV0ZExXYkVRL3VkTVBIV2t5cmxQRDNINGk0VFJPVG1jc0NuTzkxWStt?=
 =?utf-8?B?TWh3US85ZkRaK2lWaThHOUh5dW1VaUszZndBWUlwck5zV1NIbHFqeE5CSDhY?=
 =?utf-8?B?YlpGQlQra0xtd1Z3VUovTWFUaVUxdkN6NW5MaXk4U0pPNFFsOGdkWGhLcFpq?=
 =?utf-8?B?MWtVN1FqZkdaamIvdDl1Vm5VZmRKV1BDUE9VeThaK1hWVWp1QlU3aWEvNGFS?=
 =?utf-8?B?RTNlc21maHA0U1hIRFViM3h0cG5RTWZJc2QzeThFdnJEOFFDeXJSWmE5L2Ny?=
 =?utf-8?B?VnRuYm9JcVByY2RpM3JZTjJUSXBxVVl0VFF5L3VYRHpXZEthdUJQWWRZRGVD?=
 =?utf-8?B?dm1KNlNYNlhrZG9HRmFTc0lGMmZTUmxKMlNvdUlRU3ErUkhEcm9Fclh2RWM3?=
 =?utf-8?B?aFJGQS9RNUdYRXpUY2xlRklpTTY2Y1dCRlByRlB6eklWWnp2b0ViTlVpQnBm?=
 =?utf-8?B?aHdsZmJXY0hEWUNkdHRUZnpRV1BDa1ZHM0wvQlFUaC94OE5HYzVnMW5UK3Rr?=
 =?utf-8?B?SXk0bUZDeDZ3N2FEcHlZSHZPelpaWnBmbHNoN0hrTFRQYkc0eG5mS1ZqY1Jh?=
 =?utf-8?B?d3FieWJWS1hYc0E3RE14MHkrRjg2dWJPcDEvai9DV2VRL0hDWXVlaTc1NFdB?=
 =?utf-8?B?RkpNUTREdmhqclhEeU9lZWVJRzBtZjZLTlpHcHhIMnBWdGdLaHc4VzVVYTJ6?=
 =?utf-8?B?MDFNL2Z2c1lBS2x1UUhIekRTeXhvdVVLaS9oVUVZbEhFUHdORzRwRUJoaWJZ?=
 =?utf-8?B?emRDRkprTlB1MDd5Q1dyOUNWL1hrRkcxUjdMbnBIVkx6M1NnWXIrMDZEU052?=
 =?utf-8?B?Y2JMcTJCeWVzMlNxQWc3aWhoeW1ZSE41NnZibDF1V1RsTGZXemo5bnhsOFNw?=
 =?utf-8?B?OTV3eTBiOXlaMUpMSmtWdnAyTTZEcTJ4L2RiZUtUNUdtdENCSDNCSEZwbGVl?=
 =?utf-8?B?UUNEZ1lSMm5hSDlaU1hMWEtXTFYyaC9KYmwrN2oyVDdCWGdJaTdMd29BVi9y?=
 =?utf-8?B?UHZZWGJvcUxkdU81R3YvNktEUnduN3hyZnJ4ZVlOOThYMDY2dFFpTG1lMHdD?=
 =?utf-8?B?dXpzVG9FS0l2UVl3ODR6MVpEWnJJd1ZiRVlqbXloenRCeXJlYytVK3JrQ1or?=
 =?utf-8?B?ekFLSTJuVmIxeFhpOVkvWlY2Z2U4SUhmZDZMYkR0d1ErTHJaMDhTcGx1SWt4?=
 =?utf-8?B?azlYVk1pOGxUOU9vVEFPMlhhWUpQOG1CVEludkhhL2hxbkYvZHdWM1NBTlRU?=
 =?utf-8?B?aEJOMW5uTXk5ait2ZmpmUVFrbU4rbmV6M0NUOFVBanlLRTdPeUZWZTZnSWh6?=
 =?utf-8?B?SWEzcTZyQmhXN0VzN25VanV4YWY4RzdzVmVpOWc0ejRSdTR6RVRaUjlVZUVF?=
 =?utf-8?B?aFNLZWZqMTd5Y3R0RGRkMExZcGVjbFVNa0FwTldYYmtIb2R5V2NYbTN2OHEr?=
 =?utf-8?B?U0FUSGtaVE9rSkVVTi9sQTBPMGFhcjJPRUNrbkZFVGcxMWZ4dmVqZklKUTJT?=
 =?utf-8?B?azdHT0p2Q1JjeU5EUUpyT2JObnpCUHZZY082MWE0WHlObkh1dGg5YmRid1Mv?=
 =?utf-8?B?VjIrdks5Sm5lR3NjM29nNE94UVpnVzFFL2xsSWIydHhwYVdDQ2w5TzNqSlN6?=
 =?utf-8?B?eFp6dElPbXNDRFNJV2x4WmpuVkQ4V05uTm9KVjc2ZVFhbG9WT1FrSHRFM3Bl?=
 =?utf-8?B?OG5iUkJ0SjJrRSt5RjlYRW9kN0F5MlRFSTYyb1hJaG4yNTQzUkJMcE5pZThU?=
 =?utf-8?B?cTgxd1ZqcHRFc2dKc09DNUIrYUd4SVJucldSRDYreG94bzdFZG92S3o1OExr?=
 =?utf-8?B?aGRMN0RVeXFlUUhKM2cvb0NGV281R0FJSi9yU1pLR001bFdYVXBuQXRmYzZN?=
 =?utf-8?B?SWFJWDlrekU2V3lZNlVWTkxKNm9DRXM3bW5ZZ0pQak1VNllmeERyR1JOUVFM?=
 =?utf-8?B?Um9DaUpRQUxiUGNDcndLKzM0UzVSZE9Wd3g4bnJGNWNJYk1odVN1Ym1EZGtp?=
 =?utf-8?B?UEtPUTNiQWRVWVV4djd0NDROamx1SHZOdXRZOFZIWTZQZ0h1MmdERkJySzlr?=
 =?utf-8?B?VjJra05QQVBHRUxyb0dVSTVPeVZhK1k4ZVNjQTdMQnl3TjBSMTF6anc3QnJ0?=
 =?utf-8?B?aDRwU3pzNlFJbDdTcHlodUM2eFBWNG0zOVZ0bDJLUEI3cVdPUzlkOUtPQk9R?=
 =?utf-8?Q?qlVYzXbCKWBBd5JEhK6YhL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259221ec-cc5f-4ca9-41ea-08dbd55cf6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:19:05.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP1I/iskS8BkRi8OgJb+8JqVZVOnqZFSLw+hUWxKgomvcboFzC8ghMEw/Wrac55b2onbpxlWG8SdR563JsuREQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5656
X-Proofpoint-ORIG-GUID: fe2nXvTmARdDFLqAvedzCK3RjpZn2XnR
X-Proofpoint-GUID: fe2nXvTmARdDFLqAvedzCK3RjpZn2XnR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310250114
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
b3JnDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIDE2LzE5XSBSRE1BL3NpdzogUmVtb3Zl
IHNpd19za19hc3NpZ25fY21fdXBjYWxscw0KPiANCj4gTGV0J3MgbW92ZSBpdCBpbnRvIHNpd19z
a19zYXZlX3VwY2FsbHMsIHRoZW4gd2Ugb25seSBuZWVkIHRvDQo+IGdldCBza19jYWxsYmFja19s
b2NrIG9uY2UuIEFsc28gcmVuYW1lIHNpd19za19zYXZlX3VwY2FsbHMNCj4gdG8gYmV0dGVyIGFs
aWduIHdpdGggdGhlIG5ldyBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFu
ZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5k
L3N3L3Npdy9zaXdfY20uYyB8IDE5ICsrKysrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19jbS5jDQo+IGluZGV4IGMzYWE1NTMzZTc1ZC4uNjg2NmVjODA0NzNjIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gQEAgLTM5LDE3ICszOSw3IEBA
IHN0YXRpYyB2b2lkIHNpd19jbV9sbHBfZXJyb3JfcmVwb3J0KHN0cnVjdCBzb2NrICpzKTsNCj4g
IHN0YXRpYyBpbnQgc2l3X2NtX3VwY2FsbChzdHJ1Y3Qgc2l3X2NlcCAqY2VwLCBlbnVtIGl3X2Nt
X2V2ZW50X3R5cGUNCj4gcmVhc29uLA0KPiAgCQkJIGludCBzdGF0dXMpOw0KPiANCj4gLXN0YXRp
YyB2b2lkIHNpd19za19hc3NpZ25fY21fdXBjYWxscyhzdHJ1Y3Qgc29jayAqc2spDQo+IC17DQo+
IC0Jd3JpdGVfbG9ja19iaCgmc2stPnNrX2NhbGxiYWNrX2xvY2spOw0KPiAtCXNrLT5za19zdGF0
ZV9jaGFuZ2UgPSBzaXdfY21fbGxwX3N0YXRlX2NoYW5nZTsNCj4gLQlzay0+c2tfZGF0YV9yZWFk
eSA9IHNpd19jbV9sbHBfZGF0YV9yZWFkeTsNCj4gLQlzay0+c2tfd3JpdGVfc3BhY2UgPSBzaXdf
Y21fbGxwX3dyaXRlX3NwYWNlOw0KPiAtCXNrLT5za19lcnJvcl9yZXBvcnQgPSBzaXdfY21fbGxw
X2Vycm9yX3JlcG9ydDsNCj4gLQl3cml0ZV91bmxvY2tfYmgoJnNrLT5za19jYWxsYmFja19sb2Nr
KTsNCj4gLX0NCj4gLQ0KPiAtc3RhdGljIHZvaWQgc2l3X3NrX3NhdmVfdXBjYWxscyhzdHJ1Y3Qg
c29jayAqc2spDQoNClRvIHNpbXBsaWZ5LCBJJ2Qgc3VnZ2VzdCBkb2luZyBpdCB0aGUgb3RoZXIg
d2F5IGFyb3VuZCwNCnNvIGhhdmluZyBzaXdfc2tfYXNzaWduX2NtX3VwY2FsbHMoKSBpbmNsdWRp
bmcgdGhlDQpmdW5jdGlvbmFsaXR5IG9mIHNpd19za19zYXZlX3VwY2FsbHMoKSBmaXJzdC4NCg0K
VGhlcmUgaXMgYW5vdGhlciBmdW5jdGlvbiBzaXdfc2tfYXNzaWduX3J0cl91cGNhbGxzKCksDQp3
aGljaCByZS1hc3NpZ25zIHRoZSB1cGNhbGxzIGZvciBzcGVjaWFsIGhhbmRsaW5nIG9mDQphbiBl
eHBsaWNpdCBSVFItPlJUUyBoYW5kc2hha2UgaWYgcmVxdWVzdGVkIGxhdGVyIGR1cmluZw0KY29u
bmVjdGlvbiBzZXR1cC4NCg0KDQo+ICtzdGF0aWMgdm9pZCBzaXdfc2tfc2F2ZV9hbmRfYXNzaWdu
X3VwY2FsbHMoc3RydWN0IHNvY2sgKnNrKQ0KPiAgew0KPiAgCXN0cnVjdCBzaXdfY2VwICpjZXAg
PSBza190b19jZXAoc2spOw0KPiANCj4gQEAgLTU4LDYgKzQ4LDEwIEBAIHN0YXRpYyB2b2lkIHNp
d19za19zYXZlX3VwY2FsbHMoc3RydWN0IHNvY2sgKnNrKQ0KPiAgCWNlcC0+c2tfZGF0YV9yZWFk
eSA9IHNrLT5za19kYXRhX3JlYWR5Ow0KPiAgCWNlcC0+c2tfd3JpdGVfc3BhY2UgPSBzay0+c2tf
d3JpdGVfc3BhY2U7DQo+ICAJY2VwLT5za19lcnJvcl9yZXBvcnQgPSBzay0+c2tfZXJyb3JfcmVw
b3J0Ow0KPiArCXNrLT5za19zdGF0ZV9jaGFuZ2UgPSBzaXdfY21fbGxwX3N0YXRlX2NoYW5nZTsN
Cj4gKwlzay0+c2tfZGF0YV9yZWFkeSA9IHNpd19jbV9sbHBfZGF0YV9yZWFkeTsNCj4gKwlzay0+
c2tfd3JpdGVfc3BhY2UgPSBzaXdfY21fbGxwX3dyaXRlX3NwYWNlOw0KPiArCXNrLT5za19lcnJv
cl9yZXBvcnQgPSBzaXdfY21fbGxwX2Vycm9yX3JlcG9ydDsNCj4gIAl3cml0ZV91bmxvY2tfYmgo
JnNrLT5za19jYWxsYmFja19sb2NrKTsNCj4gIH0NCj4gDQo+IEBAIC0xNTYsOCArMTUwLDcgQEAg
c3RhdGljIHZvaWQgc2l3X2NlcF9zb2NrZXRfYXNzb2Moc3RydWN0IHNpd19jZXAgKmNlcCwNCj4g
c3RydWN0IHNvY2tldCAqcykNCj4gIAlzaXdfY2VwX2dldChjZXApOw0KPiAgCXMtPnNrLT5za191
c2VyX2RhdGEgPSBjZXA7DQo+IA0KPiAtCXNpd19za19zYXZlX3VwY2FsbHMocy0+c2spOw0KPiAt
CXNpd19za19hc3NpZ25fY21fdXBjYWxscyhzLT5zayk7DQo+ICsJc2l3X3NrX3NhdmVfYW5kX2Fz
c2lnbl91cGNhbGxzKHMtPnNrKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgc3RydWN0IHNpd19jZXAg
KnNpd19jZXBfYWxsb2Moc3RydWN0IHNpd19kZXZpY2UgKnNkZXYpDQo+IC0tDQo+IDIuMzUuMw0K
DQo=
