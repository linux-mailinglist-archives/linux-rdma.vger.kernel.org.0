Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4C47D6D0B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjJYNXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJYNXH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:23:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE713D
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:23:05 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PD6o0M004559;
        Wed, 25 Oct 2023 13:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=kbpeBgHuM5p8CBsG142dqq6+5QShnCJPhIqN6iR0qTY=;
 b=X4orX/BknbVfW/gcV9un0KPPuznPqMBT0Kxf6royu3G1oPOYLDjC3EAspzGojL/rCE5+
 tG1xjpWyHrg4Ek4XPtg2NBtWXG3wO6oIzqO81JvbVp5obj+pp3yO+5S6jZ5oUHhJ7zg0
 h8QYd7pyxZEq4rvjHXBX3Wt/9bdUQ8eu6jy+G8slFndKrQMTNLTO2SAeBfjPeuLnmaXL
 ywepUx80XhIqbx2MpUszRrvTLkeWTelVgh846PGMklkBkjLMhphGaxwd/ON5P26/5+8L
 sCaoGGOIIpsvXUuxrFev04JO9WzLCJ3hMipq1MkcXfCSjY6UAldvK6qaHfdpL7g4ZRCQ yA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3dfh12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:23:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEbNUNA7ht8hDgCRne1DNxIdgTQfgTM27WmLr38Z6SAJ77v9s92T5SBJKGiWW6ooLT8S/gF48VulioYl6LGFAIcZLIF2lzBc64Nq9tJz/n5Bw0m7lfjPCIo5KCE475w+pnRdfwAOKt/TdCVJcKUuNAi/ciO5ylY/r/1JwQBK8YdF+0L7s3UkgyiubNwU731PjJtVm+KELQvOJi2NEsG0WvmW3v/h9ulqlXk4ZNq5dCDA9bJ4IQy0E4LteyXAMuu8vMOKe74wHKvrXVrJbNYA718z2WXOOYW3x08e7lEB8XTSjhL70Au3Py90Dg0D8mdkMzwEOKBhjihG9Y5JMhk4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbpeBgHuM5p8CBsG142dqq6+5QShnCJPhIqN6iR0qTY=;
 b=PrgM+VD5AgpA7YBDdcktx0qx2FDCWECOrFa3w673zaTGXMLZpqHNcuCO8sANfR1h7K62c3sQJ4Thys3MV0OLk/hU28Z7FP4kaUaWuy9qstJqtq++W4pd38/dQp2br1YQKoUbkXwHdVbOP16zA07l3LmIyR/A8bDCnpsxLqqPH3xYylldsx5KzdZc51djgaiy3sjAGvJ2Jn4LEk1uhccveuJ4nr0Esq9fF6ci2OPvq2LyMR3Nzog038PPRT5UhcvAw5JVRCDYRsUhOl8Ama0Y85lBx3mPxw3LxUS5/1XFYJyWMlHPCuGNIZfMAs+daG5nEA8OX3UwWuue9oB47Ka2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by DM6PR15MB4040.namprd15.prod.outlook.com (2603:10b6:5:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.40; Wed, 25 Oct
 2023 13:22:58 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:22:58 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 17/20] RDMA/siw: Fix typo
Thread-Topic: [PATCH V2 17/20] RDMA/siw: Fix typo
Thread-Index: AQHaB0ZfGbV8b7l6fUuk11U3xgjpPA==
Date:   Wed, 25 Oct 2023 13:22:58 +0000
Message-ID: <SN7PR15MB5755E31E1B87B926B97A9EE299DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-18-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-18-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|DM6PR15MB4040:EE_
x-ms-office365-filtering-correlation-id: 6e0ae371-8002-4b67-6bae-08dbd55d8181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukW4cIqbSK625zwYiN6urdH+n5k+zBo/zTg1MEVQbHswX0g+OeszaNlFYvn17iKy3BeVb/gTxMWMbbiDIHDBkzGQSMIJ5kDQTHXsZYc380Y4cw8txM/VMv3/icIvOpBwmf9/4f4+9eAg1O0Ry+1McRn7Hlm5eFEsp02HGUZlNJB1A6yXM8L5Dn8tcSqqoWDYZfLUoj5QZU4xU/nq7snh3pd6LLMM6KAebe5b8oRPd2e8gBgdqPjmWo2CTjkhCojNNvyGGm3iiWidiPKLPl5ovx0yfVm73Q/aD6i7x+sTCTsgWqAsOidmghRTajQXAMzo2dfNNFjGly3sIDQWAfDdUjHJf+RjdGUedvzdXSTE8ENaf/F7Pl9IId5D3n8pC1/ulwkqSMt2l0lx07ubdyo+IeoRP6c+W6Qv6nWONdl0h2EV7OpRmui1pPajXiJYrmlXakucIqz1zdt0E1cqPFUYph5kzd1tYaZdpIsedRyTkd4dPM0ETWGk9uNso5zvqcGOk9HqPyg0BoGLhLHkusPQmj5n5xRLIFfhS4XscTtCzHaH6T16sqXjcZDgtJhkgKPOmyH8aFZPD0t/IvXTebJxdzerYmJQrYQdnHLkbqNye15HNGJpOSXLXhvFAzyyo9zt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(478600001)(71200400001)(2906002)(41300700001)(5660300002)(4326008)(8936002)(4744005)(52536014)(8676002)(66556008)(76116006)(7696005)(110136005)(64756008)(316002)(66946007)(38070700009)(33656002)(66476007)(6506007)(38100700002)(9686003)(55016003)(122000001)(83380400001)(66446008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aS96MGx2bzI1dVN5YmJrSGZ1ZnRvdklFdXZPUEs1bXk4aWFwU1V0bDFCd3Fj?=
 =?utf-8?B?Z1liVCtaMUxjUmQ1NzZkN0l3UGE5OVlERnh0MjRYaE1rdlhCWlVWNGtINkV4?=
 =?utf-8?B?YW15SEo5SVRsTHFFRFlzYnNMVzNLMjZMSXdJWHA1cEM4Nng1azczdUlJUkc2?=
 =?utf-8?B?TFh1WVFhVjVIUmJMVTljRStpMmZBUUZpSzR5YWpZNEJITXAyNHdhY0VHb2ox?=
 =?utf-8?B?ZXAydHlxbGI5Nkt5N3Q0NlI4S1hFNExMa2VZNmx1VVhZRmFZZTEvdUVvMno5?=
 =?utf-8?B?Q0s3VlRUTWZ3dXAzZEdXUjFqS2VGTlVQSkpJQjNOMVJJNFN1R21iSEZYZ2dJ?=
 =?utf-8?B?OVJnRk9JcUQ4MDkrdGVQWlFabCtQRDAxVE9RYmNwWDNpUUJ4ZWxOOEt5NEsz?=
 =?utf-8?B?Q0JVNHpxeXo2YTdOTE16Vlc1WTFFWXpySXo0OG1GbldiTTBQMGhRY0dFa2Qz?=
 =?utf-8?B?ZURBWmhwNkVSREg5RUdpbjNJYUE0Q21UZXk0VHhnUEI2ZFp6VmtmQXlqc3hX?=
 =?utf-8?B?WmE2WS8wMy9tQnJTTGtOTE1LaWtFWHM4WTNDY1VXand0b2ZiWWt3R0kyclE1?=
 =?utf-8?B?a0RRd0FmRFBvQWo4MnE5OUJWeFQrVkEzMlg5RlhmMGV3ZG1mellVWUh5eGdD?=
 =?utf-8?B?eVJzeWNaTHo1NzVJTmlMMzgzaktTNXBkQkpJWldxKzR6WGwvaXF4MlpTUnlH?=
 =?utf-8?B?VDdTeTV2UTVvS0kySW13dzRhTStwbXlEV3hhem9TeCtDZ0RRMldHTk9GMW90?=
 =?utf-8?B?bVlwY01rTkE4WGl2eU8zL1VJR2RZaC9mb1VIai90ZFMwRC9qU2J2aTVjM2Vu?=
 =?utf-8?B?UjdFeUtqNzhmSDJYdEoxMDE1QUVrNmxqS0dnamhVb1Y0L3R6STlmL2NTNm9T?=
 =?utf-8?B?MzBBdEJFMzdmVFdQNmk0cTdkWEd6YmNKTWFOcFVpVUU4NmFGdGNsNSt5MDE1?=
 =?utf-8?B?cGZnVDNXYXlLNm1ESDRJMUU0eEZrNnIvRVo3ckhPNkRTT3ZjRFgxNktzTWNE?=
 =?utf-8?B?c05heU1KMVJ0c2tBdURpWDloVG4zRzV4a1JMMVZERDdlL3hQUk1YODhMem9a?=
 =?utf-8?B?TU4vRlNJY3R5Lzljd2ZhZU4xb3VZS2xrT0x5WmgwRldvMWV3YVp1SHcvMGRk?=
 =?utf-8?B?dmpRc1VaOGdXc1FMTXp3UkZ6b1JNUithRTNOVlR1anFxRFkzSVNjbU9mWk5C?=
 =?utf-8?B?bCtEcXh6Q3VGOUVTTWpuaFJtdXRaYUdqMlB0Ym8zQjBKaUR6KzNLaFc3aHBa?=
 =?utf-8?B?aWRMSzVSRUVKS1I0TVdMWFBPUGQxa2twYzhjOGFlZFA5eFIyazgxLzgxMkxN?=
 =?utf-8?B?VnlZWE5vNTVrblBMMENZU29kMTZzYUs3bEp1L3c0YmZiMzNFSlM2enU5WnV0?=
 =?utf-8?B?UUYvNmxVQXowbVMxMjM1Q3lOcWFhb2t1b0dsdXd0QjBnb2Z4bi96NjRVd3kx?=
 =?utf-8?B?VWhkaWJLNlJ1djJ3aGM5SkVSL3NXUnRMbHhkYzk3RTBMVFovdlNUc3NzcFFV?=
 =?utf-8?B?Ulk3TUZkcFhXR1VxU2pWWXlqWjFqbW1tZXF3UnJUejZIRm5MdE4zaTFoNTVZ?=
 =?utf-8?B?U2FxRWVWd3JHOTRQb0RycUVjcXIyN2dPNjZZaEc5RENYQ3BENnQraU9lemRP?=
 =?utf-8?B?U28vdzlwRnhpR212dTRLRU9Menl6WkZ4TmlWd1QvZmJKRXBSeFl5OFJTdDNw?=
 =?utf-8?B?R0ovYlE2RDV1bm51NVYwWlZKeXB3bU9IMVhJRXp6azhOUUE2UU9OL0dUTUc5?=
 =?utf-8?B?aElnampQVlVkT2U0aGxzMzFHZW9JbUUxdlRmeld2Z0pHUFJFVXBabWFRYXZP?=
 =?utf-8?B?amJPSzFQZEZGLzBtTmR4a3FOTEJvQ0hSelBaai9hdzhlbDJiZlVZQUtiK09a?=
 =?utf-8?B?MTNuTlc4YXVDdmxMU1JjMTY2TFoybGxabW5RYSs5UHF3Zmp0NFdUbzZhcUwx?=
 =?utf-8?B?OStqdVFGcFNVZDUxci9aUURRL1REVE1SYS9yZnR0SCtQRktPeVNGa1hmY0F6?=
 =?utf-8?B?L1VQUE15bDJGVjVvYlp1WkpVQ0xhVDErL1Q3b0ZHbFdqU01ienBLbHYwT1I2?=
 =?utf-8?B?VnZmazQxOG01TzlNN0pkNXRXbmprWDhtLzNLd0haTWtFRkNpYUpib1R3RCtl?=
 =?utf-8?B?aGIzY25zUjZXcExGVzdzTjR0Q29wWTJUbk5QTTJvVmxRbEI4bUk4NGZFUWk4?=
 =?utf-8?Q?7Sv93ecV4TBA+pTOjBOo2Cs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ae371-8002-4b67-6bae-08dbd55d8181
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:22:58.4149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/1WD8shAzJtViuwN5EESbk8/PUsi3YB8kvUw7JeBDyxh+vw9mpCKZencwFfYOhudepMgNIP/rbJ+tXRfTNJ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4040
X-Proofpoint-ORIG-GUID: 3QySWfGeyph6HtvL05V0QTTacH9nFitb
X-Proofpoint-GUID: 3QySWfGeyph6HtvL05V0QTTacH9nFitb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=859 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyA0OjAxIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAxNy8yMF0gUkRNQS9zaXc6IEZp
eCB0eXBvDQo+IA0KPiBSZXBsYWNlIE9SUlEgd2l0aCBPUlEuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRldj4NCj4gLS0tDQo+ICBkcml2
ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcC5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXAuYw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9z
aXcvc2l3X3FwLmMNCj4gaW5kZXggMjZlMzkwNGQyZjQxLi5kYTkyY2ZhMjA3M2QgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwLmMNCj4gKysrIGIvZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXAuYw0KPiBAQCAtMTE4Myw3ICsxMTgzLDcgQEAgaW50
IHNpd19ycWVfY29tcGxldGUoc3RydWN0IHNpd19xcCAqcXAsIHN0cnVjdA0KPiBzaXdfcnFlICpy
cWUsIHUzMiBieXRlcywNCj4gIC8qDQo+ICAgKiBzaXdfc3FfZmx1c2goKQ0KPiAgICoNCj4gLSAq
IEZsdXNoIFNRIGFuZCBPUlJRIGVudHJpZXMgdG8gQ1EuDQo+ICsgKiBGbHVzaCBTUSBhbmQgT1JR
IGVudHJpZXMgdG8gQ1EuDQo+ICAgKg0KPiAgICogTXVzdCBiZSBjYWxsZWQgd2l0aCBRUCBzdGF0
ZSB3cml0ZSBsb2NrIGhlbGQuDQo+ICAgKiBUaGVyZWZvcmUsIFNRIGFuZCBPUlEgbG9jayBtdXN0
IG5vdCBiZSB0YWtlbi4NCj4gLS0NCj4gMi4zNS4zDQoNCkFja2VkLWJ5OiBCZXJuYXJkIE1ldHps
ZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg==
