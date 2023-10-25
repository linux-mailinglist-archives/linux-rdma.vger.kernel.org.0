Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D477D6D1B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 15:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjJYN3J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 09:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJYN3I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 09:29:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBDB4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Oct 2023 06:29:05 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PDMNQN001457;
        Wed, 25 Oct 2023 13:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jtCPn2sfAPcv5TO1MlolfBpgJ0ltLE4K9Au9A0Xsa/Y=;
 b=fsW0ImJLLTa1xg4PDUbEn6RhzkxwyyJpPQifo8wTmd+oJGRGMOyXFlvZxoEwr8CMoy7y
 4SRIm/fECpgge2Oj9hBgiv+/vYVN2Sa7RU4e+lPr/MIBktr0y3h606u8qjdxUoj/ce0M
 jd625b5JbQcxVeEdGqaxjBH2Fy8akRRbsx1uL5l1d2yTXahIuYalTDN5Tjhu02E1YG5T
 JXbSqdHnfpWtlkOHmN6FnBYzW5juM+/mQPlLqn7V2+/byWvEV1DcrL31CGmNN3p3E3Jz
 Sou1Yh/M01YNiNmCBr6oQTxIEQccRKZuxqa6wiHliCr0kYkqn3Dm2L46AAbn849g0nYd XA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty3ueg8at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 13:29:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Suj3KPYOvIx7ccN/3rZWxBGKnOWKKva7W1pfPkcVdto9b5aTQwBVLOt0yJOnSPoaQArvYvyPa/EosoySK3R+fRt/G680L9cOG62Z+GSlpFb66qHqq2gj4nUNsG9+vmh11EQsh8CgJC6Ubfvigqgg4MfqkwsL2coZbfml4W6OZVyT9snk3x8efq6PDUIwKCUygz+MPFT1cJZ0XcIDTmqv6aM65fGTm5wV9ny7oT6OJ25Wc92zaEFdzi7ohQMz+25reUHqXZIMZbblQpk584YqiNWem5JAPNBbHaManwrk49hU6ZcBCe0EbnukB1pW61rKtyacARqwFNHYgMuVigGFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flyHZGZ5ExlDcBqlCWnnavmZbfEvpZguzW2fF7jTX3U=;
 b=GW2QUTRck/B0rCbaFWtx+6zR15JOaiTVSQMOaFUrZNzhuG1zlIY5I7yHvOaenRR+KO0QO0///pGDb7GT6lx91pcS2Pvi2Skt/fHrT49eZaRmlK/dza1333Cmryn0zahzw8H3W1YwF3ecxNmc8qdGFDbvdLECgbyT7fVCkHfj1yi6FIQvXirtqSOcfai+KglLuMs9tfscTpQsD82mwbxA0Up0PuWAmql0YV2NWdAlNbMX2p+kut6I403ut2MYNKH9/y9tkb+7xweEGHjktaHG6CTdXb1pvPYrpggiyQ9SzHWuRijaQpSXGW/eK/Nr8mz0SXT6DCPOrgpYgxS1Gf8ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CO6PR15MB4211.namprd15.prod.outlook.com (2603:10b6:5:344::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 13:28:58 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 13:28:58 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 19/20] RDMA/siw: Introduce siw_destroy_cep_sock
Thread-Topic: [PATCH V2 19/20] RDMA/siw: Introduce siw_destroy_cep_sock
Thread-Index: AQHaB0c1Lwzhcq6Q8E+JYPyJoyHoAA==
Date:   Wed, 25 Oct 2023 13:28:58 +0000
Message-ID: <SN7PR15MB5755863A8BAB337981E7B7FE99DEA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231013020053.2120-1-guoqing.jiang@linux.dev>
 <20231013020053.2120-20-guoqing.jiang@linux.dev>
In-Reply-To: <20231013020053.2120-20-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CO6PR15MB4211:EE_
x-ms-office365-filtering-correlation-id: bfaaca11-e2b1-42a8-4c5b-08dbd55e5835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GXqfErBiv9K1SRDdEtS7TwTMWsI7NqiH9E1LbfDZH0BcJrh9RCccvZsvwIJazv1ZW+gj+23I/t7SOexWQqbfgm5ESCm8MN0xYZYqK7cboSnwJn9///HSMMIlfbRPLixLLLijKtuzHXobkWmhCVsI6bf/vZA3uSeX4P+/y7YcthoZ6rxs54HxPyjoAYYQYQBbRODuMEenSZqT/P1v33C2jPwRWZQgrxlnA854Mfnalt0h2GhiiGnmQR+QkE+In5S84gHpa0yrtP4CGcPv+RZr2A2z19cGZUCxAf0kx9XWAaP0F2AjZgYwuHK7K6UhmYzF1NVCPEDA+9DAYQS4eJmWrpvIhGUXhzDSUSRoGpDrc8RaZSztN29UavH2svB+2y7RhSDC42qwgA9r0TSLJEy/yS4KqptqqQIwI9orBVZCtP/xX8WfaIIfbCV49rCLgd4aESV2uzHNm8xZvoVrR2qEvD4X3PT/tNODedBbEwjWE7KARkVpQvJ0THmQ8aFPGxXeV/9ex/JWkQQ/pRQfCd4iZ9f5aVwF60S+sQ5IR9FFehPDJvXbXEUs3Uskam7kXqTAPh1st5YBTfj4uaiSf5Bj6jDZWG8iszniykYAWUOTaNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(478600001)(66556008)(66476007)(66446008)(66946007)(316002)(64756008)(76116006)(122000001)(110136005)(966005)(8936002)(4326008)(9686003)(2906002)(8676002)(33656002)(7696005)(38100700002)(6506007)(41300700001)(52536014)(71200400001)(5660300002)(53546011)(83380400001)(86362001)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blQvb0NNcTlXVUtoUHBTK0kwVGwrdjlXRDVyZ2YxMUg5RjhvandUWVp6dHFG?=
 =?utf-8?B?ekI3ZmhWUUFUM09Ed0FvS3BoSVg4eWFjaEVrWE5QN1VDL0U3U0M3Tmg2VFFs?=
 =?utf-8?B?NHFnU0xsck82RWlGaTBZcG13RWxoUWdmMnJOd2xzK2UrRFpOc2QzUVV5VUhr?=
 =?utf-8?B?L1JiMkJIbkFoc2ZrT2tMUkxFV0pjWUE5ejNpSkMyTC92K0pOTzNWZ3dHOUxV?=
 =?utf-8?B?VXRjTUcxblN3WWEwRC9GcFVBSDNYckpuLzlOL1gyS1BWTHpqWHkxMzVRNFVx?=
 =?utf-8?B?UDJvV2pBZEN0SEc5QjBQcTIyNE1nRUJqYnFRcFU3em84NUJzYTRGcHRwQ09S?=
 =?utf-8?B?dzVQZGpUTFg5V01IbmJCVlRLeTVkbEZMNWEvOHp4ck5BcFEwbm1KR0tCOTlw?=
 =?utf-8?B?UERkUTJ3aEdNZU51TzZ3TzlIaUNNb1FwWXEwc3I5S1lvUDVnODFNQXV0YUhs?=
 =?utf-8?B?RDl3NVhKTTRCV09CTlZLalZ0UUg1UzlWdUplb2JLUDVnVjYrY0kzZFpSQStK?=
 =?utf-8?B?RkM4WUl4RmpPT01tdDJKcEhxOE1jUFplTkw5eitwTFpYR3lRQ0syVzAwLzJZ?=
 =?utf-8?B?R2Q1WUJaUTN5eUk1TnJnRGRxeG1LTDBtS1RSd2YvcU55a2d2UmZscWM3aXFp?=
 =?utf-8?B?S0hZM3RyeDFhK1FrRldNa1BDZysrZlAwcUtkeHZqTUtMN09nQnYzcVJSR2kv?=
 =?utf-8?B?b09sOFdrQThPU0h6dXF1THRpOFVIeUdMYUNDM3dpZzcwdGJXY3VqNFpGd1BJ?=
 =?utf-8?B?RStqc0VQTS9iNFZXakI1eWs2ajRJK29hQ1BMTEZkb0tFWW1vNkk3SHVMakFT?=
 =?utf-8?B?ZnRXSmd4MWJ2Y09VWk11cUxUVjBHWXN0Zlo1YmlzbTV3aXBtYnhxOW0reXFI?=
 =?utf-8?B?WWEvR0liZ1VZVTN3REp4bzNkUWRNZlNISllvL3hRajFlVkg4bnM2TFVMcllD?=
 =?utf-8?B?Nm5mRjRIZXpmanhubU84RnBBVkZrby8wazcwZzgvOFNJQWU0bFRLOGcvN01u?=
 =?utf-8?B?S1dxVDg5TWNaWnNnTG9jdnc4dVhabHZvdGxuZzMxSUU3VTJnWlRuV2JiMldz?=
 =?utf-8?B?YVI4cEVFR0gwRERQQ2xMT3JDRnNxQmhYbTFyT08vbGI2UG1NMkxUazZzelln?=
 =?utf-8?B?MW01L2wvc1hIeGNqZERNK2NFc1JLZVhiS04zUGMxT1R2clpwSzcvRjBmaWRH?=
 =?utf-8?B?VDZPbDZSdUpuQUxLYkVtS0xPVHJqc3d6Zm1rTHJVQkZFbExEUmNhMHNNMDZa?=
 =?utf-8?B?dks4QUowdXlqenZkMXpDb0xzR3k3ZjZnMnBYU1c4V0MzaWQ5M3VJUzVuMmJY?=
 =?utf-8?B?Uk83a29IQndacFFOUERCVU90dDFVenQ2VHdCelVUajgzMC9hbE85QjZFMlly?=
 =?utf-8?B?UHU4S0RVNm9oVnhCNWJmcXhNQ0IwUENZSVQvTGtCRVRZLzdYYjE1WEI2SnFV?=
 =?utf-8?B?eDh0ZzlVUkVXMmFlNThYdFBYK2xYdFhFaW5ZazEwWTArM1ZEc1k1L1JZTisy?=
 =?utf-8?B?M2RRVzlUUW5sVkFTdXhOcFZSYW9Cc1lyR1pyK25yL0RIU1dQSmQvRWp1Zkpp?=
 =?utf-8?B?djB4cEZSbXpWQ0kramszaVhwNnJDZlU0emdaQU9HdWxxd2FjdGtueE1LQ0k3?=
 =?utf-8?B?NkxLS1NheGZzKy9qYm90Y21XSGc3K1ZvQXNaNlVpeEhOY2Z4UUJZeFNqU094?=
 =?utf-8?B?bG5ySC9OTzFEMTNTL2ozLytHZTVwcHJSNHE0ZUY1eE5mL1ROTjBXMlUya2pj?=
 =?utf-8?B?UVR4WlJxbGlQVTNETFJEWXlIc0hCK0xqa3BDbUtyRW94SmoxYmtnRkF0d3Q3?=
 =?utf-8?B?cEVrVk5RS2NKSlNVZ2JoR0lDU21PNUdKUHArazM0eE9QVmZyOWQ5RkR5c3ph?=
 =?utf-8?B?TzFOc2ZHQ0tnNHRHLy80OWJGNTVFRDlEVWdkOHJ5L1RzN3RDMVp5bEdRUVhS?=
 =?utf-8?B?OXYySkQ3U3hWWDNIUXlmcG4vRUlmdVBCcFJ3NmhyNkFRS2Q1KzhQQWtzTkdi?=
 =?utf-8?B?cmhFQmFTeHhLclUxYXBoTmd1NWxOYTlIaHVQeHQ1Z0pFcXlHNExTY1U5SXRn?=
 =?utf-8?B?Ry9WK2pCQ0VOUXlXN0xhR3hXRXJyS3BzeWRIV1krM2FwT1JtMlhqYTFwNThM?=
 =?utf-8?B?MDlsSG5leXVlcnY4cmluSklER29QWGVRVnNFRVFUWE02TmpFNHdXUVJSZFZn?=
 =?utf-8?Q?U+PGHq5fwP+EX8hxTNBw00s=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfaaca11-e2b1-42a8-4c5b-08dbd55e5835
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 13:28:58.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZAapuz7YozXbvyOe2RjVycE7aE70EtS7rjcdMRTjqaZL4g/fR48piRstKFxFbLYyU1ybi6INsCnjsPf9pOidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4211
X-Proofpoint-ORIG-GUID: AAMWqNKJ8IowSFQzdcf8C4Vei39jByj8
X-Proofpoint-GUID: AAMWqNKJ8IowSFQzdcf8C4Vei39jByj8
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_02,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAxMywgMjAy
MyA0OjAxIEFNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWMiAxOS8yMF0gUkRNQS9zaXc6IElu
dHJvZHVjZQ0KPiBzaXdfZGVzdHJveV9jZXBfc29jaw0KPiANCj4gQWRkIG9uZSBoZWxwZXIgdG8g
c2ltcGxpZnkgY29kZSBhIGJpdC4NCj4gDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8bGtwQGludGVsLmNvbT4NCj4gQ2xvc2VzOiBJTlZBTElEIFVSSSBSRU1PVkVEDQo+IDNBX19s
b3JlLmtlcm5lbC5vcmdfb2UtMkRrYnVpbGQtMkRhbGxfMjAyMzEwMDkxNzM1Lm9HN2JUdkxSLTJE
bGtwLQ0KPiA0MGludGVsLmNvbV8mZD1Ed0lEQWcmYz1qZl9pYVNIdkpPYlRieC1zaUExWk9nJnI9
MlRhWVhRMFQtDQo+IHI4Wk8xUFAxYWxOd1VfUUpjUlJMZm1ZVEFnZDNRQ3ZxU2MmbT1nbGdZcjBa
VFg2OG1RUTVLcUxLVmd0TXdDZUJVYTJnNkNNY3NJLQ0KPiBhdFhXaHlhNWY1cUZFSGxYeFlhOHBm
ZVc3biZzPTFtQU0yREFLVnBOS3I2ekpRb2ZIVU9NUTdyWHRQdlBVbVpETHdwTnlTWjQmZT0NCj4g
YA0KPiBTaWduZWQtb2ZmLWJ5OiBHdW9xaW5nIEppYW5nIDxndW9xaW5nLmppYW5nQGxpbnV4LmRl
dj4NCj4gLS0tDQo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19jbS5jIHwgMjYgKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19jbS5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
Yw0KPiBpbmRleCBiZTBkMDlkMThhNGYuLjRiM2ZkZTZjYTljYSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20uYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvc3cvc2l3L3Npd19jbS5jDQo+IEBAIC0zNjgsNiArMzY4LDE1IEBAIHN0YXRpYyB2b2lkIHNp
d19mcmVlX2NtX2lkKHN0cnVjdCBzaXdfY2VwICpjZXAsIGJvb2wNCj4gcHV0X2NlcCkNCj4gIAkJ
c2l3X2NlcF9wdXQoY2VwKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBzaXdfZGVzdHJveV9j
ZXBfc29jayhzdHJ1Y3Qgc2l3X2NlcCAqY2VwKQ0KPiArew0KPiArCWlmIChjZXAtPnNvY2spIHsN
Cj4gKwkJc2l3X3NvY2tldF9kaXNhc3NvYyhjZXAtPnNvY2spOw0KPiArCQlzb2NrX3JlbGVhc2Uo
Y2VwLT5zb2NrKTsNCj4gKwkJY2VwLT5zb2NrID0gTlVMTDsNCj4gKwl9DQo+ICt9DQo+ICsNCj4g
IC8qDQo+ICAgKiBzaXdfcXBfY21fZHJvcCgpDQo+ICAgKg0KPiBAQCAtNDIzLDE0ICs0MzIsNyBA
QCB2b2lkIHNpd19xcF9jbV9kcm9wKHN0cnVjdCBzaXdfcXAgKnFwLCBpbnQgc2NoZWR1bGUpDQo+
ICAJCX0NCj4gIAkJY2VwLT5zdGF0ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gDQo+IC0JCWlm
IChjZXAtPnNvY2spIHsNCj4gLQkJCXNpd19zb2NrZXRfZGlzYXNzb2MoY2VwLT5zb2NrKTsNCj4g
LQkJCS8qDQo+IC0JCQkgKiBJbW1lZGlhdGVseSBjbG9zZSBzb2NrZXQNCj4gLQkJCSAqLw0KPiAt
CQkJc29ja19yZWxlYXNlKGNlcC0+c29jayk7DQo+IC0JCQljZXAtPnNvY2sgPSBOVUxMOw0KPiAt
CQl9DQo+ICsJCXNpd19kZXN0cm95X2NlcF9zb2NrKGNlcCk7DQo+ICAJCWlmIChjZXAtPnFwKSB7
DQo+ICAJCQljZXAtPnFwID0gTlVMTDsNCj4gIAkJCXNpd19xcF9wdXQocXApOw0KPiBAQCAtMTY4
Miw5ICsxNjg0LDcgQEAgaW50IHNpd19hY2NlcHQoc3RydWN0IGl3X2NtX2lkICppZCwgc3RydWN0
DQo+IGl3X2NtX2Nvbm5fcGFyYW0gKnBhcmFtcykNCj4gIGVycm9yX3VubG9jazoNCj4gIAl1cF93
cml0ZSgmcXAtPnN0YXRlX2xvY2spOw0KPiAgZXJyb3I6DQo+IC0Jc2l3X3NvY2tldF9kaXNhc3Nv
YyhjZXAtPnNvY2spOw0KPiAtCXNvY2tfcmVsZWFzZShjZXAtPnNvY2spOw0KPiAtCWNlcC0+c29j
ayA9IE5VTEw7DQo+ICsJc2l3X2Rlc3Ryb3lfY2VwX3NvY2soY2VwKTsNCj4gDQo+ICAJY2VwLT5z
dGF0ZSA9IFNJV19FUFNUQVRFX0NMT1NFRDsNCj4gDQo+IEBAIC0xNzI5LDkgKzE3MjksNyBAQCBp
bnQgc2l3X3JlamVjdChzdHJ1Y3QgaXdfY21faWQgKmlkLCBjb25zdCB2b2lkDQo+ICpwZGF0YSwg
dTggcGRfbGVuKQ0KPiAgCQljZXAtPm1wYS5oZHIucGFyYW1zLmJpdHMgfD0gTVBBX1JSX0ZMQUdf
UkVKRUNUOyAvKiByZWplY3QgKi8NCj4gIAkJc2l3X3NlbmRfbXBhcmVxcmVwKGNlcCwgcGRhdGEs
IHBkX2xlbik7DQo+ICAJfQ0KPiAtCXNpd19zb2NrZXRfZGlzYXNzb2MoY2VwLT5zb2NrKTsNCj4g
LQlzb2NrX3JlbGVhc2UoY2VwLT5zb2NrKTsNCj4gLQljZXAtPnNvY2sgPSBOVUxMOw0KPiArCXNp
d19kZXN0cm95X2NlcF9zb2NrKGNlcCk7DQo+IA0KPiAgCWNlcC0+c3RhdGUgPSBTSVdfRVBTVEFU
RV9DTE9TRUQ7DQo+IA0KPiAtLQ0KPiAyLjM1LjMNCg0KT0sNCg0KQWNrZWQtYnk6IEJlcm5hcmQg
TWV0emxlciA8Ym10QHp1cmljaC5pYm0uY29tPg0KDQo=
