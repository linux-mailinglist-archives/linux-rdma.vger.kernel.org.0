Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B077DBAE2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Oct 2023 14:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjJ3Neu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Oct 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjJ3Nep (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Oct 2023 09:34:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B3DA
        for <linux-rdma@vger.kernel.org>; Mon, 30 Oct 2023 06:34:43 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UDHI2T023018;
        Mon, 30 Oct 2023 13:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pNk7gj4UixQ6QuUxuId1a5uJnSHsOLqY7G89xtLM37Y=;
 b=qs+UmRd0VYJbzUmK5DZYv4laTeHOzLcO6d/0CdAL0ybuQNXNj8U4fcbCDvIY5eJqPzdx
 I/HiRkOCnjyzpv6WHwLpegFfhsdo55ZHgrCIr0kMetTkTVVLs3ppkxwHjWmd+X6ewhJC
 6xeKeW/lNZpMH2feNQOPao8/KyXCVpXUKbpFH5TVr1THkdslez+bL2U424aZQIHhghy0
 BIX5eaOwBC0EiRl8IpWyuLRKW/kbV18V/X6L8HMOeSl+IY3rvSirKD55+8VXEHFF+msh
 AMgc8RxiGxEZNLy3clQ/vsB/VNtEAN0s6CiMpJWyW0Dvu6AnToq5r6rRp8978HjEvc4k MQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2d82gk2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 13:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlAO7v0hxFKst5z0yapCM2DJOvZ3fWKYyF2ieTSNJNcVpwh06bYgTVUDL1z7IW8xVXHQUPF14YB6uiTUcnkYBR84MYbjr0n94pcdC7aM3yhZ5LJ4MXteswirNRb4w6BG9wdoxg+OgvMbVOIUoJOKx/kYZDmGpd8YDu7si9ACHWUcq49ctDecNHivnL3NARaNENy1KZfuUy6HD968TM5AI7sY8NJTTTRBpE843Y4bxDb7SOM93M317EB+6fvp8xUKrvcT4CdPSvaKmyKRCdhAD3AfRqs6FA1srjtjPfEv6PjJGX2P6wtRY1MCcYkgdku0LmkRMhRlpEhWRhAqSKSvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNk7gj4UixQ6QuUxuId1a5uJnSHsOLqY7G89xtLM37Y=;
 b=g1Zza2oOeTNDrJduNyanNbd8rARPh1whAa1ZklAgeOfUl9cFvVjQ0uI4A5C0TKvCHou+JN5H66MEMbsmvuknpD5NRv1IMFPGQgF96PGQgJHV0oslUDy7uUYmvAbLHFL8/2Q4pfMZfmFLKElf0LBa4doznHN9Uuhl4vSNNSujRiAuPpgbr6BpImKM3yfnylso56yjeX4yk7jQp2XkcH1/lLqSN5Hvs7syHgjke26AyhjmpX5jC1GVGEHhYF+UKqgNAMVjYyC/U4ZCbYESUN8BzpQfAaJOfeyA3J3yJbnkSDroSkUZe91LgPt02TqU+vaPfEC57Sep7dO0CcvLQJKgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from SN7PR15MB5755.namprd15.prod.outlook.com (2603:10b6:806:349::10)
 by MN6PR15MB5979.namprd15.prod.outlook.com (2603:10b6:208:474::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 13:34:36 +0000
Received: from SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445]) by SN7PR15MB5755.namprd15.prod.outlook.com
 ([fe80::878d:d9bd:7ce3:8445%5]) with mapi id 15.20.6933.019; Mon, 30 Oct 2023
 13:34:36 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH V4 02/18] RDMA/siw: Introduce siw_update_skb_rcvd
Thread-Topic: [PATCH V4 02/18] RDMA/siw: Introduce siw_update_skb_rcvd
Thread-Index: AQHaCzXS2VAJvI9CdEu0HrYPDF7yDQ==
Date:   Mon, 30 Oct 2023 13:34:36 +0000
Message-ID: <SN7PR15MB57558983F6913C2CD72FCC1E99A1A@SN7PR15MB5755.namprd15.prod.outlook.com>
References: <20231027132644.29347-1-guoqing.jiang@linux.dev>
 <20231027132644.29347-3-guoqing.jiang@linux.dev>
In-Reply-To: <20231027132644.29347-3-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR15MB5755:EE_|MN6PR15MB5979:EE_
x-ms-office365-filtering-correlation-id: 2810fed4-67cd-4d05-386a-08dbd94cf567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 83EskHOn+v+7OJ+Q9Ix/fGDi/rdsO8U31UswvYLL1dl3EA0RLSn76VyjGxLhlWJYPsPZYB0OS9Qq9EIk+IsBQULuzIszoFT0CNYMrbRUoDf4SH4saRWyrMSqIm6yz/ItEapApyNLjZBud77ajRRK+I+xHDqndV1qpIPDhaQCuWpPg/lN5stZ/Og64Qa/rVp6pTMo4kSVsK6kPr7DNlQFQWKizgr/p5GYQIVDR5K3FAWSKGJue0cW6WwYEiiuSLE964DcTdYZ09a97v03F7qvQAJ76ik5Iwe/5foKa/j+z8di9KIwSczy4Grh4g8oiItW1u1KyLj2qRT9aTH2lrBQhmDk1a4ZAIvaMRK37JLCbasv5zL5Ih9OKWnS7BySkhsxvbZLERdz1rJxICBFeuh5q9jYdVteQGtPRAfJaOa4Y4w15QBf7pE6KD5T8XLi6YVVpRVmT0HiXKDwNZ+GT1vLo/izFvaF3L6eSOXxzyh90x94slGhhH4WeV7SPOxwsP/raKrkYhZh5jODYTID8A/mdl9xsO8aRfOjWkjAvEgAudC/rEXQpQw2idxOM2XHEGGiL591miZdbT3kzUmt/kHo9KWu5npQuMA5I3BzKYJfF3S4nA10yruKH1UzrPwOHlxw06h7W0CboImFhCEibl0jUlbRuTTEV5iVqfHRF+5RtXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR15MB5755.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(71200400001)(83380400001)(41300700001)(76116006)(110136005)(66946007)(5660300002)(2906002)(55016003)(33656002)(26005)(86362001)(122000001)(38100700002)(6506007)(7696005)(9686003)(53546011)(478600001)(316002)(66556008)(66476007)(66446008)(64756008)(52536014)(8936002)(8676002)(4326008)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW1qVXFvdnpoZTNXV1BRS1hZd3hMS3dGZnlpOFE0UTltdnlRaTRYcFBUblh6?=
 =?utf-8?B?ejlwSE9FbjRTakJKSUtrZmppeGFHU0cxRG54ZWNnMnVoRW9DVmVYQk53bldz?=
 =?utf-8?B?aTMzV0FabDR0M3RUSWVtQld3NVJNNXpqK1NwN1hTbXVFWEprNlNsRWVVQU1C?=
 =?utf-8?B?MEQvWXMxZWpQdXdmZmMyNGhVSVN3ei8ydUlOREtpNXNoQ25lTi9EcG1XL21y?=
 =?utf-8?B?Vk9DSFVBS2JLZ3REWDhnWlZwK1YxU2J6em1zM0FralJTbDNWSjc4SDdNaVph?=
 =?utf-8?B?alpvWWEyUkk3U3YrbUN0VXp6c3RSVjc1VmdPaFdMWmlxOHU5aXZRczNFSWd2?=
 =?utf-8?B?b3EzODFPY21xc20yMzBxd0hDWm8ranpDVWhscTBiRUFrM3FCUjNQTHh0Y0Na?=
 =?utf-8?B?YU4zdHdOZmdWYXBnLzJUdW0vZkNXaG1TVS96SUZRNmV0ZXlKeUM0amJFV1Vj?=
 =?utf-8?B?aTFOOXBaRFlGTVZjb3RsSXFCTEp4OVM0UmVyWWRrWGFPRkcxVzZvZGo0SUd1?=
 =?utf-8?B?dE9BR0pqQi8wOUhVU0U4RmN5Ym9aN3A5SlhZeXo0RUl0OGpPSW1BWTVtUmx1?=
 =?utf-8?B?Q0VCTExPbzZSSVV6dllsTHVpL2FvYkdTejcwRGxDanlxWDVJRTRZSzNyNTM0?=
 =?utf-8?B?U3BwZWtzbCtxcCt2L01YcUozdFIvUGI4c1VlZGdEb2JiQ3grTk1ZZnNFU2FR?=
 =?utf-8?B?SUJsZUtVZmZURjFSWlNmRXhLUk5QVS9YTm9ONmZQTE1iS2QrUVlBVkNTQk1j?=
 =?utf-8?B?YllFcFN2Q2ZJRkdHYjhZemJkRUlXOGE1SnFVQklvSk9iaHJaRDE2ZTRHeE1l?=
 =?utf-8?B?QnZEU1FlWEcrN2w3UXBPYVl6dEUydzBTUUNRSklacy8xVnpvWmF6ZUZab3h4?=
 =?utf-8?B?RHVSTVRITmhTUnIvZi8wOUdTVXZUdzRLTUtVQTRpS29SejU0SlROTnpFeENy?=
 =?utf-8?B?WUtGYXhEMnJMeWFQKzltZ1AvMHVkVlZlaUZOUDlobjZCSGF5WGZhajFVNVNy?=
 =?utf-8?B?RVppblVpTHc2bWxDMGVWSUNCSGNIR0pRU1hUQk4zUXk0ZDJKdmY0TE90d1lu?=
 =?utf-8?B?WCtmd0E0QmcyWHR4ZWdxWS9tY2RObThQTUMzQ1JJbVZtd09DY2E4YjkvL3NC?=
 =?utf-8?B?b2YwVysydzN1MTZhZlRFZWFjQmtDeUtnSFk1QThaNFFRaXA3MTdYQkpxbENa?=
 =?utf-8?B?eUtPVTRSS1p2dTJ1ejJ3MzZzdFE0WXRBczJyanFwUVV2WFZUVlp5S2l6RkZ6?=
 =?utf-8?B?V1BOOGpnNXFqZytUMFF3YkhPa0VzN0FuRll3SHFoTWpDbkNOSTk1TStQL3pK?=
 =?utf-8?B?MTdzRkc3enY4SzFiZEZMTElqRzBMczZWczFUbEFLOHMxYTZWa2g4WEtTVWR1?=
 =?utf-8?B?TzJzTEV0UXV4N203d3hVQlBXek8xNTVEbUxobFhkSEl1bGxrQ0pzbGZPbmVY?=
 =?utf-8?B?QlJndEJNQm5RNE4ranlBUHk5NndYYVF0aitWajVQTXhuUE95djZaY0lYUDZt?=
 =?utf-8?B?WGsxSVVIYzdnTmRHLzhZOE5aalRHc3l0Vy8vVWE1dFlEWDNaMXVKZFRPakFh?=
 =?utf-8?B?V3pvZ0dBMzlMVWZjMnB6K1Q0ZGhRRXY5dUxEVmE5eWxOUlFPQ3VQNytJa0cv?=
 =?utf-8?B?VnptVlZMS2FOb2h4WmJYcmdnM3NtNkJ6S3lKbk9XM1BuZTdXdzkySUUrTDNM?=
 =?utf-8?B?L2ZwMitoV0xrNndaMXR2cXVmejFMSktRRzU0QXhTTFBXVnc5TmpBNVVVbnhB?=
 =?utf-8?B?THNUd1d6b0FlZEtybDFpT3phcHR5Ri9BY2hoYlNNV210WEozYWlzR2hBMk1n?=
 =?utf-8?B?aFJYSUVKT3hnbGt5MGkxTEg4RnY4Nko4b0IzZVl6TGlEcjlpQU93K1U4anBy?=
 =?utf-8?B?WEg2ajQzZTVldzFYenpyMmRRVVRLM3M1S04yV1BXOGU0OGxMa2x1aE53Z1E5?=
 =?utf-8?B?aHN5bWJxUUpGQjR5RGg1ZlUyTm5MdFlGTEZWKzB6RFJ1RSttY1ZuTWpqbkRL?=
 =?utf-8?B?R2d0QjVBcWNGeTJZMnhnbm1QL0U1NGU4VG1wVXgvMVpOUzZZR1dacENQRG9Y?=
 =?utf-8?B?SkZOZ2V4UFBNVGNUTm1mdm5ITFkvL21Dd0VPYmVUODFQL1kzNm1ka3JUVkUr?=
 =?utf-8?Q?dmu4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR15MB5755.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2810fed4-67cd-4d05-386a-08dbd94cf567
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 13:34:36.0617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBPBNJsja1a9/pRb8P/HdF2Jk8ZqQNcMEppSNw+H0jIROsUxVapaIA7odS8zOckijFDYTc8Yh/Qp7uzzb4/rlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR15MB5979
X-Proofpoint-GUID: 3Cc0khtPEmb_vLTTjCRyvO4s_lAktX7G
X-Proofpoint-ORIG-GUID: 3Cc0khtPEmb_vLTTjCRyvO4s_lAktX7G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvcWluZyBKaWFuZyA8
Z3VvcWluZy5qaWFuZ0BsaW51eC5kZXY+DQo+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywgMjAy
MyAzOjI2IFBNDQo+IFRvOiBCZXJuYXJkIE1ldHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT47IGpn
Z0B6aWVwZS5jYTsgbGVvbkBrZXJuZWwub3JnDQo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFtQQVRDSCBWNCAwMi8xOF0gUkRNQS9zaXc6IElu
dHJvZHVjZQ0KPiBzaXdfdXBkYXRlX3NrYl9yY3ZkDQo+IA0KPiBUaGVyZSBhcmUgc29tZSBwbGFj
ZXMgc2hhcmUgdGhlIHNhbWUgbG9naWMsIGZhY3RvciBhIGNvbW1vbg0KPiBoZWxwZXIgZm9yIGl0
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3VvcWluZyBKaWFuZyA8Z3VvcWluZy5qaWFuZ0BsaW51
eC5kZXY+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9zaXdfcXBfcnguYyB8
IDMxICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cv
c2l3L3Npd19xcF9yeC5jDQo+IGluZGV4IDMzZTBmZGIzNjJmZi4uMTA4MDVhN2QwNDg3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF9yeC5jDQo+ICsrKyBi
L2RyaXZlcnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3J4LmMNCj4gQEAgLTg4MSw2ICs4ODEs
MTMgQEAgaW50IHNpd19wcm9jX3JyZXNwKHN0cnVjdCBzaXdfcXAgKnFwKQ0KPiAgCXJldHVybiBy
djsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBzaXdfdXBkYXRlX3NrYl9yY3ZkKHN0cnVjdCBz
aXdfcnhfc3RyZWFtICpzcngsIHUxNiBsZW5ndGgpDQo+ICt7DQo+ICsJc3J4LT5za2Jfb2Zmc2V0
ICs9IGxlbmd0aDsNCj4gKwlzcngtPnNrYl9uZXcgLT0gbGVuZ3RoOw0KPiArCXNyeC0+c2tiX2Nv
cGllZCArPSBsZW5ndGg7DQo+ICt9DQo+ICsNCj4gIGludCBzaXdfcHJvY190ZXJtaW5hdGUoc3Ry
dWN0IHNpd19xcCAqcXApDQo+ICB7DQo+ICAJc3RydWN0IHNpd19yeF9zdHJlYW0gKnNyeCA9ICZx
cC0+cnhfc3RyZWFtOw0KPiBAQCAtOTI1LDkgKzkzMiw3IEBAIGludCBzaXdfcHJvY190ZXJtaW5h
dGUoc3RydWN0IHNpd19xcCAqcXApDQo+ICAJCWdvdG8gb3V0Ow0KPiANCj4gIAlpbmZvcCArPSB0
b19jb3B5Ow0KPiAtCXNyeC0+c2tiX29mZnNldCArPSB0b19jb3B5Ow0KPiAtCXNyeC0+c2tiX25l
dyAtPSB0b19jb3B5Ow0KPiAtCXNyeC0+c2tiX2NvcGllZCArPSB0b19jb3B5Ow0KPiArCXNpd191
cGRhdGVfc2tiX3JjdmQoc3J4LCB0b19jb3B5KTsNCj4gIAlzcngtPmZwZHVfcGFydF9yY3ZkICs9
IHRvX2NvcHk7DQo+ICAJc3J4LT5mcGR1X3BhcnRfcmVtIC09IHRvX2NvcHk7DQo+IA0KPiBAQCAt
OTQ5LDkgKzk1NCw3IEBAIGludCBzaXdfcHJvY190ZXJtaW5hdGUoc3RydWN0IHNpd19xcCAqcXAp
DQo+ICAJCQkgICB0ZXJtLT5mbGFnX20gPyAidmFsaWQiIDogImludmFsaWQiKTsNCj4gIAl9DQo+
ICBvdXQ6DQo+IC0Jc3J4LT5za2JfbmV3IC09IHRvX2NvcHk7DQo+IC0Jc3J4LT5za2Jfb2Zmc2V0
ICs9IHRvX2NvcHk7DQo+IC0Jc3J4LT5za2JfY29waWVkICs9IHRvX2NvcHk7DQo+ICsJc2l3X3Vw
ZGF0ZV9za2JfcmN2ZChzcngsIHRvX2NvcHkpOw0KPiAgCXNyeC0+ZnBkdV9wYXJ0X3JjdmQgKz0g
dG9fY29weTsNCj4gIAlzcngtPmZwZHVfcGFydF9yZW0gLT0gdG9fY29weTsNCj4gDQo+IEBAIC05
NzAsOSArOTczLDcgQEAgc3RhdGljIGludCBzaXdfZ2V0X3RyYWlsZXIoc3RydWN0IHNpd19xcCAq
cXAsIHN0cnVjdA0KPiBzaXdfcnhfc3RyZWFtICpzcngpDQo+IA0KPiAgCXNrYl9jb3B5X2JpdHMo
c2tiLCBzcngtPnNrYl9vZmZzZXQsIHRidWYsIGF2YWlsKTsNCj4gDQo+IC0Jc3J4LT5za2JfbmV3
IC09IGF2YWlsOw0KPiAtCXNyeC0+c2tiX29mZnNldCArPSBhdmFpbDsNCj4gLQlzcngtPnNrYl9j
b3BpZWQgKz0gYXZhaWw7DQo+ICsJc2l3X3VwZGF0ZV9za2JfcmN2ZChzcngsIGF2YWlsKTsNCj4g
IAlzcngtPmZwZHVfcGFydF9yZW0gLT0gYXZhaWw7DQo+IA0KPiAgCWlmIChzcngtPmZwZHVfcGFy
dF9yZW0pDQo+IEBAIC0xMDIzLDEyICsxMDI0LDggQEAgc3RhdGljIGludCBzaXdfZ2V0X2hkcihz
dHJ1Y3Qgc2l3X3J4X3N0cmVhbSAqc3J4KQ0KPiAgCQlza2JfY29weV9iaXRzKHNrYiwgc3J4LT5z
a2Jfb2Zmc2V0LA0KPiAgCQkJICAgICAgKGNoYXIgKiljX2hkciArIHNyeC0+ZnBkdV9wYXJ0X3Jj
dmQsIGJ5dGVzKTsNCj4gDQo+ICsJCXNpd191cGRhdGVfc2tiX3JjdmQoc3J4LCBieXRlcyk7DQo+
ICAJCXNyeC0+ZnBkdV9wYXJ0X3JjdmQgKz0gYnl0ZXM7DQo+IC0NCj4gLQkJc3J4LT5za2JfbmV3
IC09IGJ5dGVzOw0KPiAtCQlzcngtPnNrYl9vZmZzZXQgKz0gYnl0ZXM7DQo+IC0JCXNyeC0+c2ti
X2NvcGllZCArPSBieXRlczsNCj4gLQ0KPiAgCQlpZiAoc3J4LT5mcGR1X3BhcnRfcmN2ZCA8IE1J
Tl9ERFBfSERSKQ0KPiAgCQkJcmV0dXJuIC1FQUdBSU47DQo+IA0KPiBAQCAtMTA5MSwxMiArMTA4
OCw4IEBAIHN0YXRpYyBpbnQgc2l3X2dldF9oZHIoc3RydWN0IHNpd19yeF9zdHJlYW0gKnNyeCkN
Cj4gIAkJc2tiX2NvcHlfYml0cyhza2IsIHNyeC0+c2tiX29mZnNldCwNCj4gIAkJCSAgICAgIChj
aGFyICopY19oZHIgKyBzcngtPmZwZHVfcGFydF9yY3ZkLCBieXRlcyk7DQo+IA0KPiArCQlzaXdf
dXBkYXRlX3NrYl9yY3ZkKHNyeCwgYnl0ZXMpOw0KPiAgCQlzcngtPmZwZHVfcGFydF9yY3ZkICs9
IGJ5dGVzOw0KPiAtDQo+IC0JCXNyeC0+c2tiX25ldyAtPSBieXRlczsNCj4gLQkJc3J4LT5za2Jf
b2Zmc2V0ICs9IGJ5dGVzOw0KPiAtCQlzcngtPnNrYl9jb3BpZWQgKz0gYnl0ZXM7DQo+IC0NCj4g
IAkJaWYgKHNyeC0+ZnBkdV9wYXJ0X3JjdmQgPCBoZHJsZW4pDQo+ICAJCQlyZXR1cm4gLUVBR0FJ
TjsNCj4gIAl9DQo+IC0tDQo+IDIuMzUuMw0KDQpMb29rcyBnb29kLg0KDQpBY2tlZC1ieTogQmVy
bmFyZCBNZXR6bGVyIDxibXRAenVyaWNoLmlibS5jb20+DQo=
