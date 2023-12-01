Return-Path: <linux-rdma+bounces-179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EE800ECA
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F18B2104E
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Dec 2023 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E28C4AF9F;
	Fri,  1 Dec 2023 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H9Ip7rG5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7D1194
	for <linux-rdma@vger.kernel.org>; Fri,  1 Dec 2023 07:47:26 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1FGQon018685;
	Fri, 1 Dec 2023 15:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=V9sA/neCV+YNf5yh3wP3QQ0Q6CKBP5MBd1t74S9Ts+8=;
 b=H9Ip7rG5IAR+ybS755i7hUSLM630pOzgBQ5bFZp6AKiV1wqwAKoVVNUlSVW+nDX0ug0Q
 dt4A95Z+KmEkf85b6vGM7eZVd3A8P+BAoy+Wym0CRrfLRcOcjkTi6wTJZ/LTidmYU2Pu
 tMqguo4Zjniw9K8sF3Ob7B3I5Z3ogF4SRy6Ymw7Q7l2aQ13bi67L5PwCCh+SvmRYS4Rz
 1rj+568bE2lpi4RRzysCa5jwVbdGMI0XYPi+03R3KoNoig/OeM2uvEpXNf4RI11z2VSJ
 4/N+C/WZF3+ejPi1fVwfx+TEBAy7Tt3qWLLPEl+rkfCgQeYUc+PMNmpOcV+Eh2YoSpoK aw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqhyu8q95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 15:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbn6Tr+nRaz+R50XxX1U51j5dxoPCQgnCXX1sWjLKSErhtWDe9pl76IVnweYwNHUPyF13n3vDYsU/fdd51NvfdkDtqD53FnQuFQQadesYMGUmw5UgRYsEGHmBRzuzO4g8ja1h9Nrqqlit+k9ttY8RQVrNXz5itLOLPPLiZjQ7dlHLhW4S7C8eeI5bX6SJtrCF5Lg/zqV7JRO9MRE/+trTbiEFDt8nP69rFW0HAaqIP53DXgxqyHQPjCdxzRPFmTK+IiEP4uSofdi4yQ1yfRRuLPqzVtoqLrsr40k32OFqP/ScbnHPGJnpz6vl6xIBTwFYQXL0W40Ia4zFS3+oXU1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9sA/neCV+YNf5yh3wP3QQ0Q6CKBP5MBd1t74S9Ts+8=;
 b=XYRC8GGFipNlt7Sq7dWk5ZbTQNlmmyepoKn/fnAwu1IGpvRNmcEfs0SFzN61FUws1efkEjiZYZlSEyDjDH/XN4Ol+bN6lOyCjoWQypnd+F6PbSt5Ty7a00NbMKf4xxCgAOoQPegD7I8lCvVtWbFhhJi0u/ujuj1IduTgC6KY4qJx88uAS7APZN09jdHdxRertjTudAfMqnJyk/6SRDRdSsKpAnIFmnPg0pSwG30xAtaKlILh7lr1Dnfc+wv9raLU372KXHGhZZGh3SS5517qm5IL8nJVBfb3RjKSFzSNF4/zBrR8kuSh9uwP1t68cHTlCPF4CZpMY3FC+efGWsu/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31)
 by SA0PR15MB4014.namprd15.prod.outlook.com (2603:10b6:806:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18; Fri, 1 Dec
 2023 15:47:17 +0000
Received: from BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3]) by BY5PR15MB3602.namprd15.prod.outlook.com
 ([fe80::bfd4:393d:3e83:5f3%7]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 15:47:17 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 4/4] RDMA/siw: Call orq_get_current if possible
Thread-Topic: [PATCH 4/4] RDMA/siw: Call orq_get_current if possible
Thread-Index: AQHaJG2pfqH0W58meUSzZuh/yV9Mmw==
Date: Fri, 1 Dec 2023 15:47:17 +0000
Message-ID: 
 <BY5PR15MB3602DEB9CA3010A31907C67D9981A@BY5PR15MB3602.namprd15.prod.outlook.com>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
 <20231129032418.26705-5-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-5-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR15MB3602:EE_|SA0PR15MB4014:EE_
x-ms-office365-filtering-correlation-id: c362da08-fee1-4349-59a1-08dbf284cbd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ss8i1wLwVOyc0BbLroO64RogmZ0UOrGSDJfFTW9+WaXD0r8b324NyAskiqSxchKKM8lhh82SE6RvllgsXNuUgzkdnRbhJyPbf1seypcbcNPr6E/p1adk/+jBblvn6O6/UHsmSqvp3w3ZMMptI6egibI1YB9skH61Yd0FmyeoFPrD6xvSDkYe/Xr+VDlzHdR5A9moebUxugEqe2k5cJ7x97x/outbEwGIA1d0ATnnKXO2YF+WlIvkUnPhGpzju39km6/P0zH9jpApneZ7QD0ZsnzlqJdLpylPHQIzPkPPcdU1qmEudAq6xl+Yozxewf+lyvjgsgrOVzb32QnFXWa/5VZk0GSJBa1E0/E+PL+u+thlmkm98bohQKibeI/OciH70rg+WIOx9AOqskhnShOh2PjFzVGTCcubtEmo8u3xaYE6TygFSnClojd8py9+QMGG5prI0vsI1LoXi7blt4RUOk2oIzrljg+K7S+Zs9su26j1/nRXJFw3el6MYGhRwPSCyczTVjgy04YOEg3gyKyWVVu5R8+5lqAxW5cNauKWK+aTeV1b4gzq8jVVgkcPkJS/JvgnoZfZwd1tVvBX9XhbD1s8DR4BUtluYYlwn4F/qa13d5AeaHKVjbsMKA6aHLttnDlArY2pKKRp8ySB/F2q2y1Pqktuor6mtGymQ0mdZNg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3602.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(122000001)(5660300002)(38100700002)(2906002)(38070700009)(33656002)(41300700001)(86362001)(8676002)(478600001)(8936002)(4326008)(9686003)(55016003)(110136005)(66446008)(64756008)(83380400001)(316002)(66556008)(66946007)(76116006)(7696005)(66476007)(71200400001)(6506007)(52536014)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RUYyQnFhOFpMUXNDZzluNDhrOXgranBiQnBjTmhaNXBac1gzWDdhUEYybUI4?=
 =?utf-8?B?V2ZRVVBLT0djdE1VRWM0Q3hlaDlXNXk2R2ttSFpVYk9xRUkvS2h1Uzd0MmMw?=
 =?utf-8?B?TXpyN2FvU0xrSHhkaW9nRDBhU0RLM0tjbVBzb0FxeVRCR1M1WGtHTDVBRlA0?=
 =?utf-8?B?YTJaV0ZWN1VQV3l2MFk0MUlHRE9TYUp5Vm1KcVhibk5nQWg0dXA3SGdRcTlq?=
 =?utf-8?B?Szc0N3AySzJWT0FpMlFEMUE5eXpTd0ZlZ1ZFSWdoWVhmNEFVeEozcGdkc0pX?=
 =?utf-8?B?ZzlraE5WUUZSeXpmMk9qSDNtdkJFZ2NGaE1nZ2ZWNU9UM0dYL3VLSEU1aVlJ?=
 =?utf-8?B?dGpRdzY1TnFOMkZrcTIyTFR3U016NHduZHdvNGdiQTNQRDcxcUhkdmVEakJZ?=
 =?utf-8?B?M0hVNDBxT3YycGlvclkxbTIvYmlIMDNHaGRORnU0MWdmQTc3ejZ5M05wSVNu?=
 =?utf-8?B?Mk9WaHgyaEg4TWVQTTZPSkJYVTY5Q0JxMzdvSTNEKzJ1NndqWGZpOFA0Z3BU?=
 =?utf-8?B?TWN0Q3ZZanZ4TGpkWWNFNXdPN25WNmlnbzdteS9KTDcwWElHQ01LRnJveVZJ?=
 =?utf-8?B?dFNUbjFVaWQ2a0oyN08vVS9na0VNakNNOXhHbVlZMjYzUTFMdWdyeXUyMVZV?=
 =?utf-8?B?S2xUWUU2bFN2SUN5bWloZGhRaUFyaTVueWErZzFCYk1Ec2xBeE9rczhKUm9M?=
 =?utf-8?B?RUoySGNsRmgzQjJiRGlNVTRoU1lLR0RpN0VsSmFmZkpaazlkUU1oMjBTUnNn?=
 =?utf-8?B?MlFsUWVycXBhdXNCenE3a040R1FqMkZyTlAwVEZwV0lneE9Ob2RVcTRmU1R3?=
 =?utf-8?B?aEgrOE51MVpIK2VmRVRYQnBXOWJMLzB3UWdSZWYyTXVaNHlIaEw1RXdyakF5?=
 =?utf-8?B?RkNmU3NpZ1lZSkQrYXhnZC8vUThrejFoU0RvWjE1bXg5ejhtMmlmK0J5VjV1?=
 =?utf-8?B?VXIrWnl4SzdEaW93bDdlZUlIRmtvU3BRdm1ORSs3N0xKcGNGazBFbTJmR3ZT?=
 =?utf-8?B?QXpjVm14TTIyMjFnZ1YrOWxPcVIxa0tNbHlodkMzN1F3NC8wRDlvTHlvd2Rr?=
 =?utf-8?B?MU1PRDBnMzRTZm9RWmE2TFZnc1hXcWJobFdNNWRuZTZ1ZUtjTnBaTVYxWVd3?=
 =?utf-8?B?dHV0VnJMRFNBM3pFVnFVbUZ3RUhRWHlQa3UzajgvOURHNzJtUWIvb29MOEhp?=
 =?utf-8?B?bjcxSzd0cmMvRVV3ay9yNzZjbnpEa1ZpRWdSUnhHMUVmV0tVZlBjNDdmOGdC?=
 =?utf-8?B?NTBrQmg1aFJkMXU1Skx3SXY4bmFneFg5a1RYNGo3aFlmbnh6NDh1enk2aTha?=
 =?utf-8?B?WEFkUzBjN3BQa2ZNSHdscndlNlBmWW0vejFlSnc0aytROTkwNDdJM1IrUkFi?=
 =?utf-8?B?NmV5VU5sU0RZTG5YbkZFUVFtazI3MzMyWm9xaXBXeGw5enk0aEJOREpaMkRi?=
 =?utf-8?B?VnY3L0Q1ZUtrdlkyVjlNeU9iZjFUczZ1ZEtOY1Fub1hMUDZNNGVhTEIxRjll?=
 =?utf-8?B?TlJnQUczSGNvdDZxcmVvQ3ZOZVBkdldGdmxPSFEwek9YR0tnMktOOWlPWkpl?=
 =?utf-8?B?eitlaXJybi96K2hlL1VxckhpMjltYTNIbDdmWFRTeUc4VWIrN0R3R3RrTWFo?=
 =?utf-8?B?T2xET1VBM2EzZHh6d2x2ZDlxOUtWRlZxUGUySi9JRkRaN2NlRmlVdjRFMFRZ?=
 =?utf-8?B?bGZxcXViS2Z2SlA0eUNrSXZVZjNucDhpa0grZFNRUTQraC9EWlZ0Nmtid2wv?=
 =?utf-8?B?UGgzNGZvNmtqeklTZUtKcGV4RFE2MUVzRDBNYmdpYWljelJPQUhLaDc2V3dZ?=
 =?utf-8?B?cnlaeFN0cjdzbllhV25VZWJiV2VnM0xjd0ZUdVFXeGxZbTc3Y0g4YWtwTWx2?=
 =?utf-8?B?MjZvN2hxdWlDVFQwUGgrQVNDNy9ZSU5RT2x3OU80SG5qaFExTWxYQzJ2Q04y?=
 =?utf-8?B?YWhFazUwY2t0blo3SndEOWZSK2RIQWxnZHNyZi9jMGVoR1doZGx4RVRxNVd1?=
 =?utf-8?B?dXMwYVUwOFJZS0p5ZWpvMmp1QWZBZndmWjhuTFd0ZU9oMFl4cEpLYUlzczVy?=
 =?utf-8?B?WDBrTzc2M3Ayb0VyZVRTdWQ5OEM0bmZseDZ4T1Jub21kVE5IRjFFcE1ScnMz?=
 =?utf-8?B?anRwTU5ySlpTY3FDbzBxNGlJb2tPNDNLcTRFNUVvOHAzOEZqODNGQ1lpS2R5?=
 =?utf-8?Q?p6EWRu3y/vxZ/wNsaIit3C0S4iUUs2tn4bR7RJOedSTl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3602.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c362da08-fee1-4349-59a1-08dbf284cbd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 15:47:17.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qp/hTXP1CefH8NuIENrJ/eTPfJzryh3xMymWXhcgEcfYYxwBVXdeH9kBdrr7CKQAEQpWMwIo3joUjBO5uyz/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4014
X-Proofpoint-GUID: u3_DXo9Xrk4Wg-SFkEzXAQSZVpuQ4yoW
X-Proofpoint-ORIG-GUID: u3_DXo9Xrk4Wg-SFkEzXAQSZVpuQ4yoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_13,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=882 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010109

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjks
IDIwMjMgNDoyNCBBTQ0KPiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBqZ2dAemllcGUuY2E7IGxlb25Aa2VybmVsLm9yZw0KPiBDYzogbGludXgtcmRtYUB2Z2VyLmtl
cm5lbC5vcmc7IGd1b3FpbmcuamlhbmdAbGludXguZGV2DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0g
W1BBVENIIDQvNF0gUkRNQS9zaXc6IENhbGwgb3JxX2dldF9jdXJyZW50IGlmIHBvc3NpYmxlDQo+
IA0KPiBXZSBjYW4gY2FsbCBpdCBpbiBzaXdfb3JxX2VtcHR5Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXcuaCB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3LmgNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Np
dy5oDQo+IGluZGV4IDJlZGJhMmE4NjRiYi4uNzUyNTNmMmIzZTNkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npdy5oDQo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3LmgNCj4gQEAgLTY1Nyw3ICs2NTcsNyBAQCBzdGF0aWMgaW5saW5lIHN0cnVj
dCBzaXdfc3FlICpvcnFfZ2V0X2ZyZWUoc3RydWN0DQo+IHNpd19xcCAqcXApDQo+IA0KPiAgc3Rh
dGljIGlubGluZSBpbnQgc2l3X29ycV9lbXB0eShzdHJ1Y3Qgc2l3X3FwICpxcCkNCj4gIHsNCj4g
LQlyZXR1cm4gcXAtPm9ycVtxcC0+b3JxX2dldCAlIHFwLT5hdHRycy5vcnFfc2l6ZV0uZmxhZ3Mg
PT0gMCA/IDEgOiAwOw0KPiArCXJldHVybiBvcnFfZ2V0X2N1cnJlbnQocXApLT5mbGFncyA9PSAw
ID8gMSA6IDA7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGlubGluZSBzdHJ1Y3Qgc2l3X3NxZSAqaXJx
X2FsbG9jX2ZyZWUoc3RydWN0IHNpd19xcCAqcXApDQo+IC0tDQo+IDIuMzUuMw0KUGxlYXNlIGNo
YW5nZSB0aGUgY29tbWl0IG1lc3NhZ2UuIFNvbWV0aGluZyBsaWtlDQonVXNlIG9ycV9nZXRfY3Vy
cmVudCgpIGluIHNpd19vcnFfZW1wdHkoKScuDQoNCk90aGVyd2lzZSBsb29rcyBnb29kIQ0KDQpB
Y2tlZC1ieTogQmVybmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=

