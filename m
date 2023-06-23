Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A345F73B4F7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 12:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjFWKOT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 06:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFWKOC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 06:14:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656B30C3
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 03:12:56 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NA6NZu023846;
        Fri, 23 Jun 2023 10:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7g79ZgW3ZmEPZGI75sNeB4fCVXahn0siQqyNjHzGGvw=;
 b=pcq69wA+LXHkhi9NXCMfDmRWL2Vo1PUGP52FawoXHMu0Uz1ttXkM4ywEChCo+EtgCg7F
 shtK7pW7rBH1AQwplqEzqPQMpjsV4LBxu5vftVYheAxyorGWIBO9VEislv0zPPHOmeDJ
 ZRV4kPXGseJPd89p11m4THFN8ffb34oEUPo9VPeR+xnSKvkgePbpdlzNe6fgW1siBrEF
 O3DDgC2jhFQ65jeAJCLvXRSrBUyis5TjsiK9tC5h4lPabOxwEGaQlsiEjNfNok1YjZ+5
 Me2YJEVTh6gB2BI6Jmf8vO4pzuE0lfja9t2xrT7S+EYQLNuqYnwzTn8Q100aCXjR6FSe zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd927rgq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:11:35 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35NA7NV1030662;
        Fri, 23 Jun 2023 10:11:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd927rgpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mrqz3iEovLsjnlLgpjJjC+HPZC90v1OznrAucbxsthJfjKWxmvqBDt4j9zV6q7fnF9kMCr5Hc41EHnPMm+c6tp4+23bSIq08vpBVRliltFZrSlv9t/1oqW0b0NxE938F3XgsrC3RdIfSU2TXyrbPJprWeK00C4K/l8hxP9iUWB3jt9ET6ozvC2g7WkVQJ9veffaWTuP3RmuBPAsnz3SkD/k+SE67VPiiYF8Rve42q4Rgv3Nyg1ybPs9fUP/Ou3e1QiDz5DI29kkDKPyLLMO3k3QKiNyWdK1j8hzo1nQkitxIl4t8tlAZfZNNKG1SmK36pTlQkUqOnYinI8yGtpNvOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g79ZgW3ZmEPZGI75sNeB4fCVXahn0siQqyNjHzGGvw=;
 b=ZLLaC9Z83fDrtNhvH+xDZnnFEZ1AE0rbDv6ZbaKOhDy39dv5B0z99gIBCwdQPsEOLEffAXISUI1n42lHojQbIc06O9gAdXGMsdaEAtDf76vR4Yg6s4yRNrbJHGtu2dhmXNBB0KAu9KDEhkUILebe96Wct20Q3P0LcDlenXYZTgqqAerLcuhZW2hNilc/mWEcYWuw6FgiTpAq5SKYGi3OszCZl9aT80oXBX/7KEhTsfw1T4rPmhqHR9qlaEtQ6OQIWqjnEMiPtGqG2mlbtGYOrxQkLbwJvzJrIMXHpP6Ti9eQQf3KHzV7T3Z6qMPu6pHHSlUWrfB/MwFhQax8DKhebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by CH3PR15MB6346.namprd15.prod.outlook.com (2603:10b6:610:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 10:11:33 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ec1f:2ff1:71d2:3f5a]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::ec1f:2ff1:71d2:3f5a%6]) with mapi id 15.20.6477.037; Fri, 23 Jun 2023
 10:11:33 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "parav@nvidia.com" <parav@nvidia.com>,
        "lehrer@gmail.com" <lehrer@gmail.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
Subject: RE: [PATCH v6 3/8] RDMA/nldev: Add dellink function pointer
Thread-Topic: [PATCH v6 3/8] RDMA/nldev: Add dellink function pointer
Thread-Index: AQHZpbsWH6bjnOwNHEmTSupVaet9/w==
Date:   Fri, 23 Jun 2023 10:11:33 +0000
Message-ID: <SN7PR15MB5755365175AB370E9AFB19DB9923A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
 <20230623095749.485873-4-yanjun.zhu@intel.com>
In-Reply-To: <20230623095749.485873-4-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|CH3PR15MB6346:EE_
x-ms-office365-filtering-correlation-id: 60d6ca74-2923-4adc-6be1-08db73d238a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9hvXtbWdHNJnbLTP/S5UMgkj47ARL791Ir9anq9TJyIkxCylkTl3Cl/+kGj9Mh9kJMhpfAzockJtNYWg26yZD9eOskG1MKtThzwQ2tBKvCr2aCuQxOqFCHb9QXbsrAPTQt1C6jBl6Tk8aVtDEsI0WHB9G51Af/5oLMl2Iy3Yv1cTl6jsxFDOtVJYJ/oZVT1m/ooMh5x/NcqyVT2F339pG/kt6QO6MU9HYV6p+rOqH6N+mUd3qhy8NUHTeNhpmq2FOd1mfs2V9GBMz+3rtSgLeL58X90W7JvYLbGwMlvpGiy5SbW3Gaj17IpLFxUDzPHJxwMGm1apw7h/UwKc1b809oU+2mbS31ifWeTw2UiLorcevc43yUJmELI8qNi5IMBirgo72WhWHtUEaMdT/rN6AagvhFayrh59u7O/qOIMt+/qGpQPnS1ZQ//V3qhmc5SZOw5/SIF0sSc0eNn/eWNfpKVtYNc76Tv9l+dY7S5LUOzWfm5AwPCfKB3Em+xCUCv4RiPzAm0gaUc2uLIFnzXiR19Ts7HpE6C/dGvMf44LuHIpmmZiMux88R2vSFiOXepVBPDcKuTyhEwEeNZZ4YNfzC5g9OwWHL3R4uuWe7iHbh9CzrL8whadQGXE62hfLJBi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(7696005)(38100700002)(38070700005)(86362001)(186003)(6506007)(9686003)(71200400001)(33656002)(53546011)(122000001)(83380400001)(55016003)(8936002)(8676002)(41300700001)(2906002)(7416002)(316002)(4326008)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(478600001)(54906003)(110136005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEJyUlRORy9XZVAwam5kZHdoOEowSm1xOUpQK0p3MlRGSnl3UWJMdU5XOTdI?=
 =?utf-8?B?TDl1cWk0MDVsV0ZuZHdoa2cvUjlrdTRja2FYM3F6bG12L2hUSHZUcU1wMk9x?=
 =?utf-8?B?c3RJelgxWHZ0VWNpZDRjZm1QQ0NRb1hOZGQ1UklPcWJpWGU5WXFKVS9BU0lV?=
 =?utf-8?B?bnYyTW5wOCtNWk9CSklCNFpFMjUrMmRBbVJqdk1qdjBVaktvSDEyRGlTdWZx?=
 =?utf-8?B?Ti9kYTA2Z3p1aEJjZExRa2p1NE9ZcENOZHlYNStPQ2xnVDhJbXRGV2Y2WFZL?=
 =?utf-8?B?dHZOTEl1blErbmFTdUxmekxTTmxNb0I3WVVGclJnSXhFc3JacWNBb1JGcXVq?=
 =?utf-8?B?RFNFL01UUk13ZG9Tek9BT2pZTExvN1RSQmRiZnVmRzFnUm9oKy9LRWs1aXpE?=
 =?utf-8?B?VHUvSlUyM1VHOVcxamJQSGErLytta2JzTUh5a0FlNUtGYnFQTCtvVmFXUWRF?=
 =?utf-8?B?NnMyLzZ4cWs4RHV4N09TS2NtaHlINE5LcDZqKzdLYUx2bkVOaSs3b3VzcnN6?=
 =?utf-8?B?UkRmUVVDdXp5U1dBTjh4VnJpYktUQ0ZYalN4OTgrLy81c1ZZOFd2aWVDQ1NE?=
 =?utf-8?B?YTFOd2pOa3JFZHFiSlBEQ3FETnV0VXNCaE5mMGpjTE4yNmt5OGJqZ1pTOVZP?=
 =?utf-8?B?TlhHQ0JldTNrQVRHMm9xSW1aQnhRc3pkNDR2ZjFOdk5DRzRIbnJjSW1oWlNj?=
 =?utf-8?B?K0ZWemhVVnFHeS9SdTkybElxWTA0TUxlTVFtNnoxQVBQRnczS3pUTHlJM3R1?=
 =?utf-8?B?NFM5a3ZWV1d1T1N3MzVQNzlxU1Q0bWNNMnZ1UlZhMlFkOGkweFZ2VDZlMnc0?=
 =?utf-8?B?cWlkTmo1UE1rRUcvelBZZ3NPYU92SmdCNzVkWCtoOVE0MlA1ZmtITGNsTjhz?=
 =?utf-8?B?Vy85NmtyaFBXb3ZrS2hxNGJUMmt2Y2NnWEdUWGMvTkFSWXBlWmIrVWFaTDl4?=
 =?utf-8?B?NDl3cE5rMFVrRGgySElFRGk0ckFEQ3ZGZk9UOTA5VGxHZmNaRm16ckNwKzNJ?=
 =?utf-8?B?Z3RJd0VHZ1FVVVI5N1gra09JUnZ0amlrdU5ZRXBwb0pnbmpqOTJ2SFQzSTFX?=
 =?utf-8?B?TFpjSlFla21vNEtlMHVFSVBIbVREdzVQbmJUSDRveUMxWWNOYllNM25pODYy?=
 =?utf-8?B?eDZIMG5WVDhIUWdvbnIrT0ZhWEVDUnpQdS9HaW8vWFI0bHBhb3NHVjFVSGRN?=
 =?utf-8?B?eG9OMExSY0Uyd3hEVGtmdUtvZE5vWU5sL0JVN3VobUdrMEFwRDBIZTJRbnVM?=
 =?utf-8?B?Zm5aUnlDeDIrc0owcDA3cnRocmMrVHFYL0IvR1FWUk9BakxuWjdGa1JQWkZC?=
 =?utf-8?B?clh2UEVBQUxwdmEzeWJWWGY5K0phaWN4SG1iS3hTbXVRYmYwb0FMMitBK2hz?=
 =?utf-8?B?Y29VQWdLZFNFa0JiL0xhWmFUV2lMNW9qNmpHd24vbktZdk4zRHppWjdhNjlI?=
 =?utf-8?B?MTR1VG9vUGg4bkJVOGhMeWM3QU1hdVAzSXE4WGZyZllOUVU0bkxRK0N1cGwr?=
 =?utf-8?B?UTFFdHZHcWV3Umh2S0J4THQ2RCsrOVFmcm94eEpveSs1WUlkTG1WZlJ3aURZ?=
 =?utf-8?B?bFR1ejhaR3Y2alZSWUpmUFVzMzVmRTEySWFybTRqVWNZNHhWWUJZSCtSdG5q?=
 =?utf-8?B?NFRKbDB0QjdBUEdmaDJFQ2sybW9iT0YzTkM5K0dyZm9mZDdETXpFWW5EVEEy?=
 =?utf-8?B?Y1dkcXJTc0Z5dUhPRUNVeVlZVUtDdUtyaXVxbVdBejVuMW1GS0VmeEZRVWJh?=
 =?utf-8?B?MDJLRmZGN2JEcnJoR3M0MGNjQXZtd3BvekRpa0NaYy8ycVhJTGxzMWk3ZThx?=
 =?utf-8?B?djJGYStrUm80Q3R0VWFzdXNZYXp2dElzZHAxb3p2YkRJZDdNOUpQMWtYbzBS?=
 =?utf-8?B?VVNreFprbnd6c1VQU0hOZVAxNzdnT0NtRHdOOE9TamlEQW45MkJvWmdmVDZz?=
 =?utf-8?B?RjdVUXVUM1Nvc1ZmQUJhU0d1dnRKSyt5UFJMN3pRYjhtQ1BTbU9xdjB2TmxN?=
 =?utf-8?B?cHhzYTJQemNLanlGTldiWmZ0aTVnMFJQRTFVMVg2MWt2V2Nvcng2ZVZTR1VD?=
 =?utf-8?B?ZkVlWDFzVmgwRkYwWHJvLzBBUmk2L0FpZG9DSVB3R2VYOW9JdDBaSytSbjhY?=
 =?utf-8?B?RldlVFhZd2tXOHBLaFFaRXpScHNwWitQV3FpZzlpd3JJTzNVK0toaGE0MnlS?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d6ca74-2923-4adc-6be1-08db73d238a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 10:11:33.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +T27xyAMbYnHPAkhSq3BBwHU2O5ksoiABqY/AdKdK5JDMISavbEcMZzbnZTUii/MLwPU+tzL8zVExfxfqgh1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6346
X-Proofpoint-ORIG-GUID: LBXVkRfpVQAlQshWx9JurKnrFbjXK2yk
X-Proofpoint-GUID: xzmE7QokqriuRb9I7RkyvF8RQ7H8jL_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmh1IFlhbmp1biA8eWFu
anVuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgMjMgSnVuZSAyMDIzIDExOjU4DQo+
IFRvOiB6eWp6eWoyMDAwQGdtYWlsLmNvbTsgamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiByZG1hQHZnZXIua2VybmVsLm9yZzsgcGFyYXZAbnZpZGlhLmNvbTsgbGVocmVy
QGdtYWlsLmNvbTsNCj4gcnBlYXJzb25ocGVAZ21haWwuY29tDQo+IENjOiBaaHUgWWFuanVuIDx5
YW5qdW4uemh1QGxpbnV4LmRldj47IFJhaW4gUml2ZXINCj4gPHJhaW4uMTk4Ni4wOC4xMkBnbWFp
bC5jb20+DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIHY2IDMvOF0gUkRNQS9ubGRldjog
QWRkIGRlbGxpbmsgZnVuY3Rpb24gcG9pbnRlcg0KPiANCj4gRnJvbTogWmh1IFlhbmp1biA8eWFu
anVuLnpodUBsaW51eC5kZXY+DQo+IA0KPiBUaGUgbmV3bGluayBmdW5jdGlvbiBwb2ludGVyIGlz
IGFkZGVkLiBBbmQgdGhlIHNvY2sgbGlzdGVuaW5nIG9uIHBvcnQgNDc5MQ0KPiBpcyBhZGRlZCBp
biB0aGUgbmV3bGluayBmdW5jdGlvbi4gU28gdGhlIGRlbGxpbmsgZnVuY3Rpb24gaXMgbmVlZGVk
IHRvDQo+IHJlbW92ZSB0aGUgc29jay4NCj4gDQo+IFRlc3RlZC1ieTogUmFpbiBSaXZlciA8cmFp
bi4xOTg2LjA4LjEyQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWmh1IFlhbmp1biA8eWFu
anVuLnpodUBsaW51eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbmxk
ZXYuYyB8IDYgKysrKysrDQo+ICBpbmNsdWRlL3JkbWEvcmRtYV9uZXRsaW5rLmggICAgIHwgMiAr
Kw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9ubGRldi5jDQo+IGIvZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvbmxkZXYuYw0KPiBpbmRleCBkNWQzZTRmMGRlNzcuLjk3YTYyNjg1ZWQ1YiAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbmxkZXYuYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvY29yZS9ubGRldi5jDQo+IEBAIC0xNzU4LDYgKzE3NTgsMTIgQEAgc3RhdGlj
IGludCBubGRldl9kZWxsaW5rKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdA0KPiBubG1zZ2hk
ciAqbmxoLA0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+IA0KPiArCWlmIChkZXZpY2Ut
Pmxpbmtfb3BzKSB7DQo+ICsJCWVyciA9IGRldmljZS0+bGlua19vcHMtPmRlbGxpbmsoZGV2aWNl
KTsNCg0KVGhhdCBhc3N1bWVzIGRlbGluaygpIGJlaW5nIHBvcHVsYXRlZCBieSBhbGwgZHJpdmVy
cw0KaGF2aW5nIGxpbmtfb3BzIGluIHBsYWNlLiBJdCBjcmFzaGVzIGZvciBkcml2ZXJzDQpsaWtl
IHNpdy4NCg0KDQo+ICsJCWlmIChlcnIpDQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArCX0NCj4gKw0K
PiAgCWliX3VucmVnaXN0ZXJfZGV2aWNlX2FuZF9wdXQoZGV2aWNlKTsNCj4gIAlyZXR1cm4gMDsN
Cj4gIH0NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcmRtYS9yZG1hX25ldGxpbmsuaCBiL2luY2x1
ZGUvcmRtYS9yZG1hX25ldGxpbmsuaA0KPiBpbmRleCBjMmE3OWFlZWUxMTMuLmJmOWRmMDA0MDYx
ZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9yZG1hL3JkbWFfbmV0bGluay5oDQo+ICsrKyBiL2lu
Y2x1ZGUvcmRtYS9yZG1hX25ldGxpbmsuaA0KPiBAQCAtNSw2ICs1LDcgQEANCj4gDQo+ICAjaW5j
bHVkZSA8bGludXgvbmV0bGluay5oPg0KPiAgI2luY2x1ZGUgPHVhcGkvcmRtYS9yZG1hX25ldGxp
bmsuaD4NCj4gKyNpbmNsdWRlIDxyZG1hL2liX3ZlcmJzLmg+DQo+IA0KPiAgZW51bSB7DQo+ICAJ
UkRNQV9OTERFVl9BVFRSX0VNUFRZX1NUUklORyA9IDEsDQo+IEBAIC0xMTQsNiArMTE1LDcgQEAg
c3RydWN0IHJkbWFfbGlua19vcHMgew0KPiAgCXN0cnVjdCBsaXN0X2hlYWQgbGlzdDsNCj4gIAlj
b25zdCBjaGFyICp0eXBlOw0KPiAgCWludCAoKm5ld2xpbmspKGNvbnN0IGNoYXIgKmliZGV2X25h
bWUsIHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2KTsNCj4gKwlpbnQgKCpkZWxsaW5rKShzdHJ1Y3Qg
aWJfZGV2aWNlICpkZXYpOw0KPiAgfTsNCj4gDQo+ICB2b2lkIHJkbWFfbGlua19yZWdpc3Rlcihz
dHJ1Y3QgcmRtYV9saW5rX29wcyAqb3BzKTsNCj4gLS0NCj4gMi4yNy4wDQoNCg==
