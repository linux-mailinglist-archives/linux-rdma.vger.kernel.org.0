Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B097782889
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 14:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjHUMG3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjHUMG2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 08:06:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FAA90
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 05:06:27 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LC0CRP025813;
        Mon, 21 Aug 2023 12:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=YDnoji1EUG4H/Jj7cH7AGktyjmu3NNUOvbhPjhh/v0c=;
 b=B03Jt/H7JUrM54CJUiGWbLiuKybBrkyBeAhAqkzFdZcfYpoNqq7kXzIIzAkZIJ1KuYoH
 tDqkCTOAl/dYOZGH1uqZBXrUX1KDHYBqHHRc5wrx7UNoyX0n3/ArWrd6b71Wue6VR5mx
 O5GYsA2eYv8xCLTRj2Y6qolqOwjIiLn1BB9uNSqJQwqkFP3/K2t4eZwpLyI24hG+T1rn
 ukO3pm409b9r8UverRKA0bTzq0g+LWqxXNemM9VyMTGYLyVYLvlHVZWqahf8lgyCV2GN
 HTLKG3ka6OT5jrALt/QyDgdbMWInRwxA+X+/wJHD9BUv3zb+molB8d2vlo3f1pjNUBQw uw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sm7ht08bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 12:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTgcQXNughtHxBk0WysOL79bxNqeMrltuQjiKBoT8knbLmbIWRQ2YWBOAyyX0754G7/9+KOK/HIZJP0McjCNRmd0I555M4CXLes8iW0UXWr2f/US/8CH+dTTI6dKw/7VALbAw34UeqK9Y8y84SGETNoREmx/xHU9vzSMa7+aT3oLI+jYac9gFwihpSjPjQtdDx0WckvkbzQIZr47KqKMddl06ejillqiNMXiNvRTRZAtDslJCPgHCfetMQLKPG8hv475EwgbWTJFkCnNyGMkuuXEyjz9PUMRs8DIMJ2Eh2AnACL+VQ+nL4Vxap87TWb1bmk28yMCun0An0nEQYPB2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDnoji1EUG4H/Jj7cH7AGktyjmu3NNUOvbhPjhh/v0c=;
 b=AN3egM2gRhCwEU3885MeNp8bhPrnIQQxMGajhR0bCIKgV16Jkw+zL4hTmlVFjtQ+N+/1t+qXvx/BxFGFbaSLCaZlldiDT2nbQ2uHGeKfrLI65pcnUojuZwSPAEbupAjodgPUr60rNHQyC9tD5sFp0psiNAMSA5Z1GInEBtP8PfIcOpV73Rt4qs5BCTpPRy7ndgsSmorUe/+mjWORa4mCeLYelSN9QyRMTjwyoARwUwd9aOqQT45XooQEyl82G2uwU3DklnoCrEoCpVc1lwp8J8KraMgKn74FMT7BVhIYC0GuL20wLINCL0B4uO7yZRMIZFSrxRCSr8YqgvLBAV817A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by BLAPR15MB3891.namprd15.prod.outlook.com (2603:10b6:208:27d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:06:11 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::1dd2:5249:6029:1011%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 12:06:11 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V2 1/3] RDMA/siw: Balance the reference of cep->kref in
 the error path
Thread-Topic: [PATCH V2 1/3] RDMA/siw: Balance the reference of cep->kref in
 the error path
Thread-Index: AQHZ1Cffmwfw58Sj/UuiIuQO052Rqg==
Date:   Mon, 21 Aug 2023 12:06:11 +0000
Message-ID: <SN7PR15MB575508212552855643CCC83A991EA@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230821084743.6489-1-guoqing.jiang@linux.dev>
 <20230821084743.6489-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230821084743.6489-2-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|BLAPR15MB3891:EE_
x-ms-office365-filtering-correlation-id: 85f32f53-aa0e-44e2-1822-08dba23f027e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2S/mdRAAQp+dNT9GBpN3mdehucQvnlxAyY5YkXfbIhVfzrnzsWPs3C/ZzgsdABOPfxUYiUa+/GiDaPORWM+Vmfg3ino+5l7mgxFpYpteebJvbwRZ4Pq8TZmPfzCcWrhrDMiYCIq/T5T25PIbIiYO6Bd8v1MqzGD8G3LQgtHVvl7BHPlZq0gG63q/Uw4Tj1KKgARev+MeU8SUjBrzruuRUUg9lYZexQAYTMA7VZKFiw55nsi3+K665WCWeM7q43KXROynj/uHdTx3OSFaIxcDXOxKGieOW8DSPdJPaLi8tWbIqxIlyZrXFB4n2vyBJqGCKxlHGr9qxfdob9Sjzyol1cCfdHQodvxsLa+BgF9EWr10kxizgO48YdJKkCcAR9MCaRNngoaCTNVuTow7AO76r0u40nT0GQA0TurKYhGiXaU21tFwlj524/7C2UKaKoy9TIdYWgVS/d/XxVdJ2hgB7mrY/pt2IFclUt4SWx0tjxVaHjPBvmJko47NaSaz3Ij6jWlmywzRMXkWN2LlYEh/yfzQze3h2uthjCb1ruRD7GrKEpukztOmI0d3TW2Ceg6Notd+1K3Lylt1OpDBlMwHopa/11xXvnvqBhMKBJu6ANuoqlcCTM22Ik0xeCwsLEG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(38070700005)(6506007)(83380400001)(5660300002)(52536014)(33656002)(7696005)(86362001)(8676002)(8936002)(4326008)(316002)(9686003)(66946007)(64756008)(66446008)(66556008)(76116006)(66476007)(110136005)(478600001)(122000001)(55016003)(71200400001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1Voc0hOVG53d3MxNlM2RjZFTHhWY0ZOZ2dhcHBiK2gzcWdRVU85WWdlUFVn?=
 =?utf-8?B?Rk1YRWJIOW0rU2ttVkhPNTEweWVvUkFrdThRQnlHOHcyZTFGUzcwL2JhRUNH?=
 =?utf-8?B?WFp3UkJ2aEhuWFBGM1RDM1JNRDczWkdwODJJT1VnMTRPcS9RWFZjcGI1ZDV1?=
 =?utf-8?B?TjliczVPanA5T09LU1dLMGlpTXJvRlZhSWVkNURsclpVc1FZdVJQSGdOZG1Y?=
 =?utf-8?B?Y2w0Z3ZxQ3YreFFCdXJZZ1RSSEV3MGd5Z3hSUzVydmZxS084VGVUZUM4OWM3?=
 =?utf-8?B?N1ljQUs5OVdWNDJoZUZvUU9TR0ljMHBtVklHMU5ET0hPVDFkTGI4UUNFbHF4?=
 =?utf-8?B?MlRNS25EdkpkT090TlFZRW1qMlNjd2ozTjR6YmxTQkVPY1NHb2x6RHhyeExv?=
 =?utf-8?B?NTRkTDVvSzh2aFVOTlZ3aS8wUHFydlZWQ1FEckR0RUUzaDJOZnpOSjR4WUtB?=
 =?utf-8?B?TG93b0ZteEhJbDRmMEwreU1tdXJ1L3h5ZU9aVk9hWFN4WFZENHdad1Z0bU5R?=
 =?utf-8?B?NVV3eUxKMEZFUGVqSkFId3o4OVZrTFoycEt5M2VnMkhMUUJNUzVrK0VCTHNx?=
 =?utf-8?B?VnZXdDZ0SkQ5S2hmTGRlUDFJdFNTYmF1NVFua3JWbG90ZWVYQUQ5QnVLbEdH?=
 =?utf-8?B?VjVHTWJWamZqSFdzK1ZSYklnR09xd0FmRzFseU9NQUUyUGxQUUZSTGZlQ3RR?=
 =?utf-8?B?RzNZb2VjOTk0Vm9wL3pNd1UrY0tJMEJZVUdDRnM3R1dJMHRRVndzQU54NXJ5?=
 =?utf-8?B?ZkdvVnVjcERJanJjWWpmbkUwOGlqcGVRNXd6a1hzZnhJenBvZ1czQmZpeUh6?=
 =?utf-8?B?TDhFUXZKYUpQY1lIUGRhQUhmTUh3aWNPa1Nock1yd2hJTTEyUndwalRvRG53?=
 =?utf-8?B?N3Y1WEpwblJNWEVlN0tpdWZIdTVuRTkyLzZPYVlFQnJTY0lkbTJ4Wk13c3ZG?=
 =?utf-8?B?QTFRcUVOTUlpU29yWjNVOGliNDZPSE54bDRhN2xDeDBXUnBncE9xZkVUTHB5?=
 =?utf-8?B?YTZXVGlBVnBIVlYxcEp5SnM2VGdXM2FFTnF0N281N2NHYWdJVy8vcFBuQVVB?=
 =?utf-8?B?Sjg3bmRJMFZRTnpVN3RiVGVKNXVFN05VcWMwaGZvN0hmOCs5MXN4ZE03L0c4?=
 =?utf-8?B?anVJYXRXWXhkK0dkMnZjS002T05kUlRxVHd2NWdqWVFUc1pwaUNSVHV5WE8y?=
 =?utf-8?B?V3pVWGNKakVEMm5hL1Q1UWZvM3RoTWdDYTVPbnhyb2ZoU3NJd1ZYc043YlhB?=
 =?utf-8?B?M0tzYTNBU3hreEZyVnBoblRYN2RjVFg2eGxOWUdxRFdUVkdhWHJQaW9acEtQ?=
 =?utf-8?B?NDlrM2MwM0FaVzhUNUw1a0hCU1VidlhKRkdjOEc1b0VrYlBzMlArN2JDTXkz?=
 =?utf-8?B?Q3RjVjlmMzV1bzFGanNoVzl1ZERjTE52em5Pbm02ajZGdHB2dGtTYjRCMjFK?=
 =?utf-8?B?T29jejNseVlNb3Nyck1wMjVWeFM1RG1EYjFTRzBpZW0za212NUpaMmIzZ01n?=
 =?utf-8?B?djIyakV4ZnBjUERvTEZRVW1uWFllSTJacUZ5Z1pRM1Q3UlI0dXA2S2tvNnhZ?=
 =?utf-8?B?NElYQzM1NGdrVmpuSi9ySUdLOGpiN0pvQnN2V1EyZTRGWVZXNitHTXpVcDA4?=
 =?utf-8?B?bEJmVitFZ0x0YXlLVk1MZWJ0WUJUdFFyeEdWcEpib3d2Y3JFaFJ4M210dFNO?=
 =?utf-8?B?aEtZYXdRcTJ2bm9TVFpqVW1XdTVORTVTeE1tUkIwZ0oyVXNOSkNzTGZ0aGlU?=
 =?utf-8?B?bGF3ZTJBWGJ3VEo4Z3k1d092VFMrWUdsZTFjdU94K2pDYzV3L3dBTHlZR0Rq?=
 =?utf-8?B?V3pqbmk2dlY5a2E3UitEclU4NnlFYWlqY3pQMVR4MlpRVlZzVzZHcmg1REFQ?=
 =?utf-8?B?WS9nTHdVOGtTSTJmTW43aTNVMjdFSG96c3g2aWNqTG5NNU5xOHZRZ2FvK2p6?=
 =?utf-8?B?eWQ4TFlPTmxKL0dEWGdvTENWS1lNUmx4Uk1WZi9DdytIbTVldXJETWhXNkJY?=
 =?utf-8?B?WFBzQTFDTnVLK2NhYXVHSnV3WjlHSjB1OUJERmFzaHkwdjV2R1d5L21iNS9h?=
 =?utf-8?B?dnhzeG9DU2FmSWxPdWpMWWVPM1Q1SlNKYWNuUmJMalBpMlh3M0ljTTVSdlNP?=
 =?utf-8?B?b1NTUDZJbis5OEdyV3ZhME1BNjQ2dFA2WkFqdklUcjJNYzNMTWh2M3BxUUNN?=
 =?utf-8?Q?URiHbNojSjsxnslt9Akfv6M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f32f53-aa0e-44e2-1822-08dba23f027e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 12:06:11.1345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGlI8n+PNh5pnS6D+I8GNsjUz/jr3uTyMRhSvhYGFMwfbUrLQT9DK8Uc2XJ+3NYs35XOfvggEi3JGGUFk4vClA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3891
X-Proofpoint-GUID: tfg-kBq2Rba3YYg4lHOC_jaXlRiK9zsT
X-Proofpoint-ORIG-GUID: tfg-kBq2Rba3YYg4lHOC_jaXlRiK9zsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IE1vbmRheSwgMjEgQXVndXN0IDIwMjMg
MTA6NDgNCj4gVG86IEJlcm5hcmQgTWV0emxlciA8Qk1UQHp1cmljaC5pYm0uY29tPjsgamdnQHpp
ZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIFYyIDEvM10gUkRNQS9zaXc6IEJhbGFuY2Ug
dGhlIHJlZmVyZW5jZSBvZiBjZXAtDQo+ID5rcmVmIGluIHRoZSBlcnJvciBwYXRoDQo+IA0KPiBU
aGUgc2l3X2Nvbm5lY3QgY2FuIGdvIHRvIGVyciBpbiBiZWxvdyBhZnRlciBjZXAgaXMgYWxsb2Nh
dGVkIHN1Y2Nlc3NmdWxseToNCj4gDQo+IDEuIElmIHNpd19jbV9hbGxvY193b3JrIHJldHVybnMg
ZmFpbHVyZS4gSW4gdGhpcyBjYXNlIHNvY2tldCBpcyBub3QNCj4gYXNzb2ljYXRlZCB3aXRoIGNl
cCBzbyBzaXdfY2VwX3B1dCBjYW4ndCBiZSBjYWxsZWQgYnkgc2l3X3NvY2tldF9kaXNhc3NvYy4N
Cj4gV2UgbmVlZCB0byBjYWxsIHNpd19jZXBfcHV0IHR3aWNlIHNpbmNlIGNlcC0+a3JlZiBpcyBp
bmNyZWFzZWQgb25jZSBhZnRlcg0KPiBpdCB3YXMgaW5pdGlhbGl6ZWQuDQo+IA0KPiAyLiBJZiBz
aXdfY21fcXVldWVfd29yayBjYW4ndCBmaW5kIGEgd29yaywgd2hpY2ggbWVhbnMgc2l3X2NlcF9n
ZXQgaXMgbm90DQo+IGNhbGxlZCBpbiBzaXdfY21fcXVldWVfd29yaywgc28gY2VwLT5rcmVmIGlz
IGluY3JlYXNlZCB0d2ljZSBieSBzaXdfY2VwX2dldA0KPiBhbmQgd2hlbiBhc3NvY2lhdGUgc29j
a2V0IHdpdGggY2VwIGFmdGVyIGl0IHdhcyBpbml0aWFsaXplZC4gU28gd2UgbmVlZCB0bw0KPiBj
YWxsIHNpd19jZXBfcHV0IHRocmVlIHRpbWVzIChvbmUgaW4gc2l3X3NvY2tldF9kaXNhc3NvYyku
DQo+IA0KPiAzLiBzaXdfc2VuZF9tcGFyZXFyZXAgcmV0dXJucyBlcnJvciwgdGhpcyBzY2VuYXJp
byBpcyBzaW1pbGFyIGFzIDIuDQo+IA0KPiBTbyB3ZSBuZWVkIHRvIHJlbW92ZSBvbmUgc2l3X2Nl
cF9wdXQgaW4gdGhlIGVycm9yIHBhdGguDQo+IA0KPiBGaXhlczogNmM1MmZkYzI0NGI1ICgicmRt
YS9zaXc6IGNvbm5lY3Rpb24gbWFuYWdlbWVudCIpDQo+IFNpZ25lZC1vZmYtYnk6IEd1b3Fpbmcg
SmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW5maW5p
YmFuZC9zdy9zaXcvc2l3X2NtLmMgfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
Yw0KPiBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X2NtLmMNCj4gaW5kZXggZGE1MzBj
MDQwNGRhLi5hMjYwNTE3OGY0ZWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9z
dy9zaXcvc2l3X2NtLmMNCj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfY20u
Yw0KPiBAQCAtMTUwMSw3ICsxNTAxLDYgQEAgaW50IHNpd19jb25uZWN0KHN0cnVjdCBpd19jbV9p
ZCAqaWQsIHN0cnVjdA0KPiBpd19jbV9jb25uX3BhcmFtICpwYXJhbXMpDQo+IA0KPiAgCQljZXAt
PmNtX2lkID0gTlVMTDsNCj4gIAkJaWQtPnJlbV9yZWYoaWQpOw0KPiAtCQlzaXdfY2VwX3B1dChj
ZXApOw0KPiANCj4gIAkJcXAtPmNlcCA9IE5VTEw7DQo+ICAJCXNpd19jZXBfcHV0KGNlcCk7DQo+
IC0tDQo+IDIuMzUuMw0KDQpUaGF0J3MgY29ycmVjdCwgdGhhbmsgeW91IQ0KDQoNCkFja2VkLWJ5
OiBCZXJuYXJkIE1ldHpsZXIgPGJtdEB6dXJpY2guaWJtLmNvbT4NCg0K
