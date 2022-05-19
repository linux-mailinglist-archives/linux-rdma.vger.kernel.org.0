Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3AE52DA10
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiESQVg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiESQVH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 12:21:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A18E46B2F
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 09:21:05 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24JGIDJu001024;
        Thu, 19 May 2022 16:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=y/gqQcRFzj6UuMTrt3pjAsSUqv7gRQUlJ7V/7w7n4rE=;
 b=duOPEQnHJ5w/JFKiVLoLm8Kod+lgpJrRdoTBJfzu2EohSLx3SdiIWGbYN1/xd0s6CvpA
 kO0CxtTYCGWO61iaSLKWiXaSbAR3wII43nCOcADbj23ez3ooQg9xHls2gOUZT5v5VlJ4
 yXRFkeCoYODThs/uT8ZogtIrJYDomaUS/HagDoANrGtrc0B1b7fMx1dMs35lZunos1ZR
 FfOSxQdo0tJDaiBAg5h4drUMWwBNxC/IRDnk0ZPsbwDxQiR/p/H0SgONJ9xXBY+USEE+
 +qMEWePSscfUNaEHdpqgQLepEvUtyX3xGt9WwQeoBUNZqphiNrok09Q32M0fTFXVv81E VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5s9v0211-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 16:20:58 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24JGK9oM009079;
        Thu, 19 May 2022 16:20:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g5s9v0208-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 May 2022 16:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgXZ13JVXyGV++qJybGwQc5d+0AeQ7sgTz9BMAIdrIfP/OVGu/w4kIcOlonKGkCGIjpxxTFVBCiSqZcpmCzOV2rS34rEc3JYfzxgAimECTSv/mxnn0CYHQ77IDcwvYzzj73w1LhnTg7EjdPaGBuwSf/SDwhl3depuJMv/51aNAroX+4YDHhcnBry6w3V819HMVHgBn+LW4U+qJSTPYfrjfeRvZH82VOj6YuUP8zSa7z8v3OuHJsyYOhKEdPf7oevXR3dEq7gKOh/fNaPHUnXhg+lQibpGoVhUD9beAPx3K4xiySaDoOEunMvSr/BOVUM+ynUkGMpL7uICDEh5Z48Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/gqQcRFzj6UuMTrt3pjAsSUqv7gRQUlJ7V/7w7n4rE=;
 b=BRW/0lsAEQhlzZncmU+dEGn1L0vyjEM2Agq+1GOzbSzk6LxdzAb0oVXGNFqAhX7JrpZ+PMvFlanmHqeKA8zzHbQ6/1D1iZKK+xnhZua2KHJlWOA4QGT2Eo85MJ5UZlVspcN3WCOCLqct95HoP2EaBsDqkqcOSJ8f41ChSEyky76LUcoAB70JSSZrD3DPL5HuARHC1xUZhjO7OweySZlMN/OV9eDMG3Ek7B2rRjcvtA5sczD2TABWU8T9ukLfWPhtahlAl1WeJLe/bkC6QOl/DO0kMZmfBDl7az/3ciY/aXDJ0cjhRc9V1k31+DTThGJ6hczPvykI69EiDJ3NA+W+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by MN2PR15MB3071.namprd15.prod.outlook.com (2603:10b6:208:f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Thu, 19 May
 2022 16:20:55 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5250.018; Thu, 19 May 2022
 16:20:55 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        Tom Talpey <tom@talpey.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Thread-Topic: [EXTERNAL] Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the
 erdma module
Thread-Index: AQHYZHBNw0eBV8HmDECg3AdB11iSf60kWjOAgABpAICAABtiAIAAAg0AgAF8PrA=
Date:   Thu, 19 May 2022 16:20:55 +0000
Message-ID: <BYAPR15MB2631B46350315B486CA9ED3599D09@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
 <20220421071747.1892-11-chengyou@linux.alibaba.com>
 <20220510131724.GA1093822@nvidia.com>
 <2a46d5b3-e905-4eb5-c775-c6fc227ad615@linux.alibaba.com>
 <20220518144621.GH1343366@nvidia.com>
 <83ed54cd-7893-ea26-6bf0-780e12ca2a3e@linux.alibaba.com>
 <20220518163142.GR1343366@nvidia.com>
In-Reply-To: <20220518163142.GR1343366@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bf1d609-1cd8-43a3-dc65-08da39b38ce1
x-ms-traffictypediagnostic: MN2PR15MB3071:EE_
x-microsoft-antispam-prvs: <MN2PR15MB30717D2F268E1F3E126C3F2699D09@MN2PR15MB3071.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /p5XsKnb7p4s0+Kce3A1Yc/yHto/qoVgQ1WJZNsjaUBDN7vagUtFUcDxQcPR0/pJ+r8uH8YaDUwiKTvxOidzfbPIiCYGPjO8EJX7EF+67Ybeoybfq9w7W6dsSfnM04/PmLJVkfz5xY3Sgitptt2MGOtrmv8YccyCcB3DQPEcRxHB+pqGclajL91FxHxFexI0S/Sc2jHtklN6ze/9myhEm3JRpODore9WxefGjH9+1oey3US8V9WXrQvfDuQDYu3dJjrXUS0Z9xsSPnlPZfkZP5fCap1KY3uzquUBlsnP3+JVTAWhZ5+4W97NHOni6+Etw0RPQ+w3+vPNDOTDJFmVyX8HW4DkmbuMj1PqH1EDjUBHnlibIJTn4buHW+dL6RHCQsvmhN9au44fXK0dKbcq5TPJeDLI+EcxIQeYfEtUsjKHnadhB9lamSgthgu0AZSCbpDxSfzhTS3JNAtwK2BAa0hn6j93qZXCOUr/fOV+FcEK3aRkAPXy6wRLmZ4Qi1FSwu8yzzoVUwRjxK0S4UM8CgFqnDsk1QESFVm8DiY/dbYMStAWT09uqlu5DkFoZsvdr24DfzcYGMhop7dJooaeE1kpBy9+qdr5Xy8aQRl6xFb9kRCL12QQyHuzA5n+to8oJLRQovk6fTL6Vx2d31tQE2J/aWDFc6l0OH1ex0dnKuWwVI7Il4Ql0SjD/Y+pI9hfpQAQT5mUXjyIWub4EiZklA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(9686003)(186003)(86362001)(53546011)(2906002)(6506007)(7696005)(316002)(110136005)(8676002)(4326008)(66946007)(76116006)(54906003)(66446008)(64756008)(66556008)(66476007)(38070700005)(83380400001)(71200400001)(122000001)(5660300002)(38100700002)(52536014)(55016003)(8936002)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bS92WTNoRjBuY3JVNWNqN0tJRjFNWm9BY3oxYnVNWWZLcVg2dzhwMGNLY2NM?=
 =?utf-8?B?MGJkNktBMHk2RlhXNW9wNzQ3cTdtSkpMdVF6VEhrVVE2YkxET1pFQkhnMjBK?=
 =?utf-8?B?Qi9FL3RyZitUWlIwTkpiT0l4WmI5cW0zeGxDb25TcW1TdkdoYkt5emV3b0o1?=
 =?utf-8?B?V214MnY0L0xteGFxN2trdlIyempRLzJ3TG5acjRUNlZtZkw4Yi9qdXRVSkdC?=
 =?utf-8?B?ZmNORFdDTGppWEt1L04vYmh1RTN3TE9WMWUyR1gyK2N3UTlCVjUrbFM1S1lK?=
 =?utf-8?B?Vy9OMDk5aENpdU1RK0I4SUVlbzRYeE5QTXBBTXBVN0ZDMVBhdGVXWEZNdlJW?=
 =?utf-8?B?QlNaRncyZGNmaElFbDc4N0xGYzQxTlVtZVpnOExYbUlNQ3A3aTZraHFMcW5k?=
 =?utf-8?B?NWdlN3Y4NzZ2NkVjU0VBY2RidklNbEVyVkQzSVd2NGVFWXBOKzQyQ05MZ2lF?=
 =?utf-8?B?b1RTc3E0SWR4Qnc2YzhpN2diZGlnNkUzVHRJMHpDTytqRmdMQ3J4WkxaUEJa?=
 =?utf-8?B?MCtKR05qQ0lsS0VhTStHKzJKcnVmbFBhbFNJTWJIclVsWi9xdStHaVA1VnUv?=
 =?utf-8?B?N2VVcisyVmdIeE1qZ3hnMG9QcVBBNGlmVlRCK1FzTU9rd2ZTN2xCU1Q0bUsz?=
 =?utf-8?B?RCtKUzhhM1E0azJUOHZLeUk5czFpSUh6Q3NEdjBoNnFIbjQvYjJvNDkydGxz?=
 =?utf-8?B?U1hiTUtaR1E5Y05GYTFDRVM0L25LNkhwSlhmQkU3RlRhWFluNXpKUDlBQ3ZI?=
 =?utf-8?B?T2ZxTm50QVVtWHhYcURVdFN5UXNaZFlQaXJMa3dVWE1saXF5VWtNOVVtLy9F?=
 =?utf-8?B?TzJndzBVTURwRndiR2hzQTAxZkFlRWl5OGdqUDVyQXdkaHNJaXhMK1c2VmNr?=
 =?utf-8?B?TjB1V3c1MGlpQkczbHI0bkU2cFJLRW5wWjNxZS9Dc2E4SUo1emFSQW01ME9q?=
 =?utf-8?B?WEFoUEVEZ1lSOURHVVl4VTFpWWUwZm1BbC9EeDFmMTRQcGY3U2VHUklUMVUy?=
 =?utf-8?B?QjVrTjdPRDVxRUZnNEt1dTE4NTRxUXc3cnlLOS8raCtlZUpvblMzbkQyYUU1?=
 =?utf-8?B?Zkg3Y1dMMmdzdWxSTlhaR1pTSDZUTWprU3NnSUIzQ1A0VnpZSk45dE5hWEYr?=
 =?utf-8?B?U04wWndKRkNMbmZiN3c1RXAwMlNXZ2pmOFd5b2IxcEFLaVJhTmEvODFHa01x?=
 =?utf-8?B?TFZFQUxWQ3h2TmthNUY2ZmRiWXJyKzVLUDFHcHdmQnBUNC9Nc21kaVlrT3lI?=
 =?utf-8?B?NFNLWGhRamtvcFZPdEpOU0taY3NWQ1AxM0lQQW1DRUxhSkJrSDZjeDV4L09s?=
 =?utf-8?B?SUxzN0RLREhHRFhUaTZ4T2JJbEt6Ui9vVWJXRVdkYXNBRE5ySDZDSitaRFJC?=
 =?utf-8?B?TkJGbFJwQmY3S3M5K3Z0WGFsdmQ3OUdNejVkNFBseEVXeUh6RmVUcFFEdGl4?=
 =?utf-8?B?dEV3b21BbWlhR29STFBLbG85RE1GdFJEZkljMHBCSjltcGs4cVlTcmFWanhq?=
 =?utf-8?B?cWp4QTA3eDlCTGlRYm9kYjhSdlVnbFdPMzNva0hPSUF0WWRtVlVocnZEdHha?=
 =?utf-8?B?bm94MHUwSC9jckJ2UkcyYlRuSGhTQ2RmaWFQZHJmckp1Q0ZqTXQ2UUgrdGcw?=
 =?utf-8?B?cFFvUzk2V3dUVWQvT0FrUkljUzl4Q0FrYVhKYXJwc0ErQUNBUE9KYjkwTXY5?=
 =?utf-8?B?cmp5RSt3RVdZRlo3QiszU2lxZjFLY3Juc3VGd0lSdVp5N2hPOTgxU25henpI?=
 =?utf-8?B?VlZxTFhxbG43MmJscDc0TGpFQTh5ZnM5MHpjaTVUNlAySUYwNWtaU1hJd1pu?=
 =?utf-8?B?UHE4WkIyZ25IVXJyT0ZVS3dQYThYUEhIVmREcHNUbys4Rm1OV1VLZ29rK2lz?=
 =?utf-8?B?bE1KK0g0YlNxTXh5RUt0V1FZY2k2Z2hGZnBGZXp1R0cxQldmc0VNNitYbk9x?=
 =?utf-8?B?WlVJVE4xQlFoNW80MHFtcFNUZ3ZPTW5qTVhWZmd3MnpwVWM1ZUdMKzBSTFJo?=
 =?utf-8?B?ZWF4ek1NeUVNTGhiNFZlSkp0UDQyUGdHRytvWlVWS0pQaXVFL1BjbS9ua0FQ?=
 =?utf-8?B?QnBiUzVpNXFoS0MyNFFpdytTYmEwWWltSzlQbTl2SkNRclg0dCsybEpzTTNK?=
 =?utf-8?B?MzdNeUxJbnoreDh1QTRFekFKUDZTSFM3VEpTRGVYakc0d295L1U5c2VTYXdi?=
 =?utf-8?B?bUNjZG5tTExrcmZZREYyQzAwcnlUT2sxQjczOFFJdlFzWVgwK2pwT1VrdWRM?=
 =?utf-8?B?KzdWMVo3alFjbVJMU1ZUUXAxNXN6d1N0VkFIVzlKK3YvVkFKeEE5T09zNG9U?=
 =?utf-8?B?YTBNTGh6Y2JGY3Q5Q2REZk9aMzdVNEhycU9ta2d3a2E0WHRITWovRUprY0l1?=
 =?utf-8?Q?nnZunI/XHUxmQBOJPgBt14ifISows8jDqyjjvk4r01BMq?=
x-ms-exchange-antispam-messagedata-1: Dnm1tT1cl00iNw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf1d609-1cd8-43a3-dc65-08da39b38ce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 16:20:55.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4o1Z1FStGCbDQ3leFPKie6/mnPSTkrMqTMQB/TK/4IsvvGGZGd/sNPwcMyUs28KgsU69WFMAdyXlnNp2+8rKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3071
X-Proofpoint-GUID: c9sFUV1mjDp9J4daSfk1Ch6xunITDjkD
X-Proofpoint-ORIG-GUID: pderf77BelkOUSQmQmTeNdDq32CMb5VR
Subject: RE: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-19_05,2022-05-19_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205190092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxOCBNYXkgMjAyMiAxODozMg0K
PiBUbzogQ2hlbmcgWHUgPGNoZW5neW91QGxpbnV4LmFsaWJhYmEuY29tPjsgQmVybmFyZCBNZXR6
bGVyDQo+IDxCTVRAenVyaWNoLmlibS5jb20+OyBUb20gVGFscGV5IDx0b21AdGFscGV5LmNvbT4N
Cj4gQ2M6IGRsZWRmb3JkQHJlZGhhdC5jb207IGxlb25Aa2VybmVsLm9yZzsgbGludXgtcmRtYUB2
Z2VyLmtlcm5lbC5vcmc7DQo+IEthaVNoZW5AbGludXguYWxpYmFiYS5jb207IHRvbnlsdUBsaW51
eC5hbGliYWJhLmNvbQ0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggZm9yLW5leHQg
djcgMTAvMTJdIFJETUEvZXJkbWE6IEFkZCB0aGUgZXJkbWENCj4gbW9kdWxlDQo+IA0KPiBPbiBU
aHUsIE1heSAxOSwgMjAyMiBhdCAxMjoyNDoyMkFNICswODAwLCBDaGVuZyBYdSB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4gT24gNS8xOC8yMiAxMDo0NiBQTSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0K
PiA+ID4gT24gV2VkLCBNYXkgMTgsIDIwMjIgYXQgMDQ6MzA6MzNQTSArMDgwMCwgQ2hlbmcgWHUg
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9uIDUvMTAvMjIgOToxNyBQTSwgSmFz
b24gR3VudGhvcnBlIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgQXByIDIxLCAyMDIyIGF0IDAz
OjE3OjQ1UE0gKzA4MDAsIENoZW5nIFh1IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAr
c3RhdGljIHN0cnVjdCByZG1hX2xpbmtfb3BzIGVyZG1hX2xpbmtfb3BzID0gew0KPiA+ID4gPiA+
ID4gKwkudHlwZSA9ICJlcmRtYSIsDQo+ID4gPiA+ID4gPiArCS5uZXdsaW5rID0gZXJkbWFfbmV3
bGluaywNCj4gPiA+ID4gPiA+ICt9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2h5IGlzIHRoZXJl
IHN0aWxsIGEgbmV3bGluaz8NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBIZWxsbywgSmFz
b24sDQo+ID4gPiA+DQo+ID4gPiA+IEFib3V0IHRoaXMgaXNzdWUsIEkgaGF2ZSBhbm90aGVyIGlk
ZWEsIG1vcmUgc2ltcGxlIGFuZCByZWFzb25hYmxlLg0KPiA+ID4gPg0KPiA+ID4gPiBNYXliZSBl
cmRtYSBkcml2ZXIgZG9lc24ndCBuZWVkIHRvIGxpbmsgdG8gYSBuZXQgZGV2aWNlIGluIGtlcm5l
bC4gSW4NCj4gPiA+ID4gdGhlIGNvcmUgY29kZSwgdGhlIGliX2RldmljZV9nZXRfbmV0ZGV2IGhh
cyBzZXZlcmFsIHVzZSBjYXNlczoNCj4gPiA+ID4NCj4gPiA+ID4gICAgMSkuIHF1ZXJ5IHBvcnQg
aW5mbyBpbiBuZXRsaW5rDQo+ID4gPiA+ICAgIDIpLiBnZXQgZXRoIHNwZWVkIGZvciBJQiAoaWJf
Z2V0X2V0aF9zcGVlZCkNCj4gPiA+ID4gICAgMykuIGVudW1lcmF0ZSBhbGwgUm9DRSBwb3J0cyAo
aWJfZW51bV9yb2NlX25ldGRldikNCj4gPiA+ID4gICAgNCkuIGl3X3F1ZXJ5X3BvcnQNCj4gPiA+
ID4NCj4gPiA+ID4gVGhlIGNhc2VzIHJlbGF0ZWQgdG8gZXJkbWEgaXMgNCkuIEJ1dCB3ZSBjaGFu
Z2UgaXQgaW4gb3VyIHBhdGNoDQo+IDAyLzEyLg0KPiA+ID4gPiBTbywgaXQgc2VlbXMgYWxsIHJp
Z2h0IHRoYXQgd2UgZG8gbm90IGxpbmsgZXJkbWEgdG8gYSBuZXQgZGV2aWNlLg0KPiA+ID4gPg0K
PiA+ID4gPiAqIEkgYWxzbyB0ZXN0IHRoaXMgc29sdXRpb24sIGl0IHdvcmtzIGZvciBib3RoIHBl
cmZ0ZXN0IGFuZCBOb0YuICoNCj4gPiA+ID4NCj4gPiA+ID4gQW5vdGhlciBpc3N1ZSBpcyBob3cg
dG8gZ2V0IHRoZSBwb3J0IHN0YXRlIGFuZCBhdHRyaWJ1dGVzIHdpdGhvdXQNCj4gPiA+ID4gbmV0
IGRldmljZS4gRm9yIHRoaXMsIGVyZG1hIGNhbiBnZXQgaXQgZnJvbSBIVyBkaXJlY3RseS4NCj4g
PiA+ID4NCj4gPiA+ID4gU28sIEkgdGhpbmsgdGhpcyBtYXkgYmUgdGhlIGZpbmFsIHNvbHV0aW9u
LiAoQlRXLCBJIGhhdmUgZ29uZSBvdmVyDQo+ID4gPiA+IHRoZSByZG1hIGRyaXZlcnMsIEVGQSBk
b2VzIGluIHRoaXMgd2F5LCBpdCBhbHNvIGhhcyB0d28gc2VwYXJhdGVkDQo+ID4gPiA+IGRldmlj
ZXMgZm9yIG5ldCBhbmQgcmRtYS4gSXQgaW5zcGlyZWQgbWUpLg0KPiA+ID4NCj4gPiA+IEknbSBu
b3Qgc3VyZSB0aGlzIHdvcmtzIGZvciBhbiBpV2FycCBkZXZpY2UgLSB2YXJpb3VzIHRoaW5ncyBl
eHBlY3QgdG8NCj4gPiA+IGtub3cgdGhlIG5ldGRldmljZSB0byBrbm93IGhvdyB0byByZWxhdGUg
SVAgYWRkcmVzc2VzIHRvIHRoZSBpV2FycA0KPiA+ID4gc3R1ZmYgLSBidXQgdGhlbiBJIGRvbid0
IHJlYWxseSBrbm93IGlXYXJwLg0KPiA+DQo+ID4gQXMgZmFyIGFzIEkga25vdywgaVdhcnAgZGV2
aWNlIG9ubHkgaGFzIG9uZSBHSUQgZW50cnkgd2hpY2ggZ2VuZXJhdGVkDQo+ID4gZnJvbSBNQUMg
YWRkcmVzcy4NCj4gPg0KPiA+IEZvciBpV2FycCwgVGhlIENNIHBhcnQgaW4gY29yZSBjb2RlIHJl
c29sdmVzIGFkZHJlc3MsIGZpbmRzDQo+ID4gcm91dGUgd2l0aCB0aGUgaGVscCBvZiBrZXJuZWwn
cyBuZXQgc3Vic3lzdGVtLCBhbmQgdGhlbiBvYnRhaW5zIHRoZQ0KPiBjb3JyZWN0DQo+ID4gaWJk
ZXYgYnkgR0lEIG1hdGNoaW5nLiBUaGUgR0lEIG1hdGNoaW5nIGluIGlXYXJwIGlzIGluZGVlZCBN
QUMgYWRkcmVzcw0KPiA+IG1hdGNoaW5nLg0KPiA+DQo+ID4gSW4gYW5vdGhlciB3b3JkcywgZm9y
IGlXYXJwIGRldmljZXMsIHRoZSBjb3JlIGNvZGUgZG9lc24ndCBoYW5kbGUgSVANCj4gPiBhZGRy
ZXNzaW5nIHJlbGF0ZWQgc3R1ZmYgZGlyZWN0bHksIGl0IGlzIGZpbmlzaGVkIGJ5IGNhbGxpbmcg
bmV0IEFQSXMuDQo+ID4gVGhlIG5ldGRldiBzZXQgYnkgaWJfZGV2aWNlX3NldF9uZXRkZXYgZG9l
cyBub3QgdXNlZCBpbiBpV2FycCdzIENNDQo+ID4gcHJvY2Vzcy4NCj4gPg0KPiA+IFRoZSBiaW5k
ZWQgbmV0ZGV2IGluIGlXYXJwIGRldmljZXMsIG1haW5seSBoYXZlIHR3byBwdXJwb3NlczoNCj4g
PiAgIDEpLiBnZW5lcmF0ZWQgR0lEMCwgdXNpbmcgdGhlIG5ldGRldidzIG1hYyBhZGRyZXNzLg0K
PiA+ICAgMikuIGdldCB0aGUgcG9ydCBzdGF0ZSBhbmQgYXR0cmlidXRlcy4NCj4gPg0KPiA+IEZv
ciAxKSwgZXJkbWEgZGV2aWNlIGJpbmRlZCB0byBuZXQgZGV2aWNlIGFsc28gYnkgbWFjIGFkZHJl
c3MsIHdoaWNoIGNhbg0KPiA+IGJlIG9idGFpbmVkIGZyb20gb3VyIFBDSWUgYmFyIHJlZ2lzdGVy
cy4NCj4gPiBGb3IgMiksIGVyZG1hIGNhbiBhbHNvIGdldCB0aGUgaW5mb3JtYXRpb24sIGFuZCBt
YXkgYmUgbW9yZSBhY2N1cmF0ZWx5Lg0KPiA+IEZvciBleGFtcGxlLCBlcmRtYSBjYW4gaGF2ZSBk
aWZmZXJlbnQgTVRVIHdpdGggdmlydGlvLW5ldCBpbiBvdXIgY2xvdWQuDQo+ID4NCj4gPiBGb3Ig
Um9DRXYyLCBJIGtub3cgdGhhdCBpdCBoYXMgbWFueSBHSURzLCBzb21lIG9mIHRoZW0gYXJlIGdl
bmVyYXRlZA0KPiA+IGZyb20gSVAgYWRkcmVzc2VzLCBhbmQgaGFuZGluZyBJUCBhZGRyZXNzaW5n
IGluIGNvcmUgY29kZS4NCj4gDQo+IEJlcm5hcmQsIFRvbSB3aGF0IGRvIHlvdSB0aGluaz8NCj4g
DQo+IEphc29uDQoNCkkgdGhpbmsgaVdhcnAgKGFuZCBub3cgUm9DRXYyIHdpdGggaXRzIFVEUCBk
ZXBlbmRlbmN5KSBkcml2ZXJzDQpwcm9kdWNlIEdJRHMgbW9zdGx5IHRvIHNhdGlzZnkgdGhlIGN1
cnJlbnQgUkRNQSBDTSBpbmZyYXN0cnVjdHVyZSwNCndoaWNoIGRlcGVuZHMgb24gdGhpcyB0eXBl
IG9mIHVuaXF1ZSBpZGVudGlmaWVyLCBpbmhlcml0ZWQgZnJvbSBJQi4NCkltbywgbW9yZSBuYXR1
cmFsIHdvdWxkIGJlIHRvIGltcGxlbWVudCBJUCBiYXNlZCBSRE1BIHByb3RvY29scw0KY29ubmVj
dGlvbiBtYW5hZ2VtZW50IGJ5IHJlbHlpbmcgb24gSVAgYWRkcmVzc2VzLg0KDQpTb3JyeSBmb3Ig
YXNraW5nIGFnYWluIC0gd2h5IGVyZG1hIGRvZXMgbm90IG5lZWQgdG8gbGluayB3aXRoIG5ldGRl
dj8NCkNhbiBlcmRtYSBleGlzdCB3aXRob3V0IHVzaW5nIGEgbmV0ZGV2Pw0KDQoNClRoYW5rcywN
CkJlcm5hcmQuDQo=
