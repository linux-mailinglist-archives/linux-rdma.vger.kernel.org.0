Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4754152EED7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350658AbiETPOG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 11:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiETPOF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 11:14:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96817066D
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 08:14:04 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KDikhN010053;
        Fri, 20 May 2022 15:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=51rYGzYx9895okE/WXEKsEUzdcx+0XKrv0kN5gIC4JI=;
 b=huTW6ReMYQDp5YhvAW3hq93E9MtGUnODyt0Y9l0pI9u7xRjZf5zN7DnmbYxhnc9hYG8o
 VKjxZzdWt7DX9z0NdM16MU2A3m4RkKDZJvKJ1uZ8tIAgbTvLFe0f/AbEF7fqEHKgUHnc
 kbAXzDAvba0amfBjYnIglr4sNGvwM1fP7bu9wUnZZcF57nfbHq/WUa4lRJgefx9SK9ES
 9WtldpKCZtuyo3uP9FbQzRoX2wnHEy+dsGgOzGqFVgHZDm3TMrdOLQ/ldzeJ6KyG/331
 imhUsoH7a5va6xKHgSxbs8FfvaJnpvQNUKvoYUvG8+SmhXoaSar9TXKDlu8z1/H08lyh Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g69jhdm29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:13:48 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24KEnWQk018156;
        Fri, 20 May 2022 15:13:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g69jhdm1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 15:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxHv3nQJKToDGkSxpcM8o0j14HAgtKzFkGUPgpWNHF5WSvGD5qCuxd6s6MfvNR1tYInAbGC4pxlG1v3NQatV3xEoVAVyGtC+nNkS9NE1QeTnJU5xG7Y/QUG3JJAgiboKBAiDT2Bi2/oxWNrvnflmB9PMQ1LEj0sAbtHvGQnPADoe6r0O8p2AuT5LCwZO42hRUM+0faPong1EEmUfKKMG5uNyoW8p9RmRYIbGMYao6rH+LSBKQZwmLVhX0cQPsMiUjY8ynmEoXxdeLn7PGRt8Dx9ImkUCfkZvoRzrzV9UfHZ/ORHQAUlQdgjpK2YkXTI6ZmzD41ws1VzQyqD0Icn4YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51rYGzYx9895okE/WXEKsEUzdcx+0XKrv0kN5gIC4JI=;
 b=RrbiivL5pRQAHiEePeoIAVZcwwgv6vWo7is76b71EGCEYpSxvQkzAGTBsTJCHpC/0Jno0SIiSmkVgIdRfpMpoYWAYvGCue6721CqdGsl+ai445H729Rme/PMe79Vkz47LUlxxW+KOM0ZK0f/nh1HRO8VfxmV/BhEzNfeT4OIkY4RfXwTj0jqwBEX0BX/5q7Nbum/KApwUFFJ7zl+GFLEBcX5lXH9GsEs3/785HK34zWBVW5pfeodZMZfccwTDMAnI5eaxyKul+cIe+tfsLjTn8SYc1yzQbX3izwQX/ouMEW8XmpmC6ZZpiAAWaZFiVHsy9L6RENJpuULCbNI3IBWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM5PR15MB1513.namprd15.prod.outlook.com (2603:10b6:3:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 15:13:46 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 15:13:46 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Cheng Xu <chengyou@linux.alibaba.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Tom Talpey <tom@talpey.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Subject: RE: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Thread-Topic: Re: [PATCH for-next v7 10/12] RDMA/erdma: Add the erdma module
Thread-Index: AdhsXDHlQIVtTeTmSxiMxOeNRJpNXg==
Date:   Fri, 20 May 2022 15:13:46 +0000
Message-ID: <BYAPR15MB263173D47513D1B16E1B00C199D39@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 966184eb-db82-4bc5-6ab4-08da3a7355d5
x-ms-traffictypediagnostic: DM5PR15MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR15MB15130D5AA4D4614D74D0EE4F99D39@DM5PR15MB1513.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CbPst/1Oqmcopwq/Su90L3Qgk1fQ5Hp+3ib/pvd3KKdDnfAT+FpXplP+ExItyFwY2tVvAkhjJgb5sv4gbkyX+21UNgRop9bX6Rz72+vjwT51Um+bDIoEVZdnnauXzKzKdIxyG+LIukH5qj1NvFoO+dTaiNh4CkC9ZjFNiIEjzoEK/4UxSwkeSuTkmQmYPeCkGIBFoBR0fznB2wC9PTJpWrgfKhoMyZ48sfIhIYSDtnNpp/Bv8ES7+YtbGy6nTjZJnHaR9PVLSoCzd7zdEcs2as6l3v1TI+U5Xu3/zi7XB0d2Ccs/Nekas8+/inyrL78yzgwBgnTnP7qz7Zx0mo9G3NwIoYHGe0sf5Ep5fRlhRh5eMMj4LkkIoiEhMCnC00MKT0VfnwWs2Lx017hC7LstKz23Xe/+3XSKgbXYEOwANnZFVufW31V+DfYZ0bGfvS0q75D9S/pgAJ7X0RyJclSMMtUTBT454oEMLF7evY7daX7sBLQT1uiryB73BpG3of2GMliW12mszCMFWh5CF45PHz93/2tU+d7DffxXEAlzd4R7LyZA2osCrrpaBaCVHkS9iC77qu7/018hcVzHH1vRGc90NJzWRdZMKPXkQ6efeZdC5AnwR3fqOSFBjHF+8h8jNnKKggE31EqZxJko1KUr0owkFb8okhkVY9d9FVQVJr5X2QvxlB3DY1OgXjUmoREpBo3EsYakPBCjQ0CFtPmGKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(8936002)(5660300002)(9686003)(86362001)(6506007)(55016003)(508600001)(33656002)(2906002)(83380400001)(52536014)(7696005)(53546011)(186003)(71200400001)(38100700002)(64756008)(66446008)(66476007)(66556008)(8676002)(4326008)(66946007)(38070700005)(54906003)(122000001)(316002)(76116006)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzNaOUprMmdwZjlnU1FITm16Q2xSUkFlMjAxZ0g1YVF3QmNVTGdOZUtFbTFx?=
 =?utf-8?B?RDMrWXcxU0pUTVNta2ltQUVDYzZMZUYyTlNzMlF0WVd3OVVNdkxjZ3NBQTk1?=
 =?utf-8?B?bzNsR2w4cWovODd1QkNYbkJEeUVCT0p3NFR6Q3hXYkRkeGY3TVdoVlpTUkxE?=
 =?utf-8?B?S2hNS3E5Qmd5ZDBMQld2S0I1QjZ5NHVGd0Z4aWFrQ2NBanBSZGYrMjhQUmFN?=
 =?utf-8?B?aU1tdWc3bng3RThTUHpRbXVFNmJ2TzhxcjFpbGpoMGtWR1d2Q0xNTjdWM3dx?=
 =?utf-8?B?NkNaaFYrYnRYWWg3WXpFT09NQ1dtTVRvWWpsMjFKQS9uNVdaZlJHa0V1NmQx?=
 =?utf-8?B?anJWYVZBNjZqa2JoVXhwbHRhakZyRm0vUWI4ZVl4Q3pialNia2dHc1RTQkdk?=
 =?utf-8?B?ZXBkUHltU2ZUS3NST2JWcElJQmd6UkhxbUk5LzFuUk9GSG8rOFRPQ0RvVHM0?=
 =?utf-8?B?SVhhZGY4eFlOL3U5YllXZ1hhM0NTZlhWNmlUWUs2cld4bldkeUd5cSsvaDky?=
 =?utf-8?B?K2xKelYzV1pYNmUvVmRpWTgzV3V2cXJOd2FEc0lablVzeElFUWRKa3dXTDY5?=
 =?utf-8?B?YmhrZDA5Vk1UL3pibkxoTVFaMXpHdDNxVEQwWlhSQlV3bGlRSzhQOTZmdHg5?=
 =?utf-8?B?OHBCakt3ZmtZaTI5VURYWGdjQitiTnQ5ZXdsWE8wYTIxY1RudXNrSmFMMTlJ?=
 =?utf-8?B?eXZlQm9reFBSSnhrWFZFdkNvK2k5VXhYSTBDdUdldmllL2pNVEEzckpwYkhw?=
 =?utf-8?B?QkhQSDJrb1lxUmpDNUpLUFdZK1FJSXV6K1dZZ0xNZ293aWlIRStIQk9oTTFq?=
 =?utf-8?B?bXhBRWRza2g2STcwYWdqdUVsU3BOM0tienlBMEt3S3E4UkFqbDJiZlU3aWZF?=
 =?utf-8?B?NVhoQW5aT2ZDWFJGV25JR1IxRE1JUGJmVzhSZWFqcDFmSGVSVFhOSUU1RVpv?=
 =?utf-8?B?UktIOWpsZnRlZmF1TFg0Q29GcnlmS0JDY1JHTFJ3bkpsRUZMbWd5djdYNWRM?=
 =?utf-8?B?MW5UNVo4Qkp3OVc0b2tiV1YvOG05dzB2aDBsM1AyVjNJeWlLSmQ5NWxKMmtE?=
 =?utf-8?B?alorL3dNbnlrb1Nua0NsTGlGMkdDZGxUbVhMeC9RT2t2bVE4YXhycWNaUVZT?=
 =?utf-8?B?K0k3VE5EUFNLK1Avd2tNMWtHdEVjNlROcjF2MysrdUkzQ0RJb2dmZ250N0l2?=
 =?utf-8?B?aGJTbTZjT01TU1R5blJlZzRWQjBPTmJzQTRFRmRad0RFRC91NitZNE1LM29u?=
 =?utf-8?B?YWpRYXcxeEVaVTNFMFo3VHdEcHJKN1U5VEI3M1lDR3dLQ0lwT2RQRzdkQzhp?=
 =?utf-8?B?SXlya1FDTFZzOElkV09nN2NrYjBYTUhtT2tVTjNzV0FyLzcxTVNFNWZIOU02?=
 =?utf-8?B?WkJnTG1kMkwyRHlKVXRwdmhRSGFWeXZjNGM0bkZxRWZkTFpVVThlektMZDV3?=
 =?utf-8?B?STFJSm1aMjlITzAxdVZqQVcwR1Z4bktldEEyREpuR2lqQ2lDOGoxZllrOGEy?=
 =?utf-8?B?SGVhczhsT3JWYmJadkVoNm8zakZzRVVCWHZyM1UzK1hmM3U4aGkyelI2N2hj?=
 =?utf-8?B?RXR0aDdjakROdUFSVktwckVUa0MrR0dzeFpiVGRMbE1UelFPeUxKUnZmUmtY?=
 =?utf-8?B?dkxFRUdXQklsbmZ6RnArOUVLVnJpcmtXTE9JdHYwR2pKa1ZrRGhLKzNueXR1?=
 =?utf-8?B?dm5WYWs2ZWZrOCsrRUhjVlNJcFdHK0Y3MVlOaTdSQUd4c2YraE9EWGxxcmtn?=
 =?utf-8?B?dFdhaG5BekpraloycXJkT1NDU1BNNDJ0QnhsNHdpdnZjU0RZQ0hpYlNrR2dO?=
 =?utf-8?B?YkY2bWNsdDNhRGpRd3MrTS9ITkJtUjR3ZmlIK3djTWpyUFlGZk9VMnZYdXln?=
 =?utf-8?B?THNubXBiQXQwaTlJVkZLRFR0alZ1clU4SmJvZFNlRjZuYVJRb1BlQWd4dytF?=
 =?utf-8?B?Y1dtZzN5c0VLUnV3ejluTXRDOXhER25oRkcwSWMwbTV1US94NmV4RWc1aVV2?=
 =?utf-8?B?ZFJFYTZqSjJLQXJaK3pkYzVEZWpIOVc4cXVZTG5wbGRFVm9BSnk0QXpYWmhl?=
 =?utf-8?B?RFpDZWpWWmtUcFk2UjZTR0NueENxdE9kRlQ0VDdiSFdpRGxFUTlWZXJ2S2E2?=
 =?utf-8?B?ZFRGZE1zVm1BZldCc3hKcktiSzQrbXJWT0V4cm1WS0xxbjFBU2pvWmp6MG5Z?=
 =?utf-8?B?OFg5SFhwRjhEdFlFSVdqcndUK1NONGpWaXBuMjBncGpuaGNWZVQyc1ZZNUla?=
 =?utf-8?B?MUYzdHNVWENQVmIrbk5jM010YVBRUWZnZEpydnQxNzdyQUxFVWhXbG0xeW52?=
 =?utf-8?B?eTk5dVAwaktkN2dhMzNxK1Bob2kzeWhOblZURVhMejN6bFJmc1ZWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966184eb-db82-4bc5-6ab4-08da3a7355d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 15:13:46.1421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDPV578SXQMrdOu2Oe4aak7dYpKbcwN88OjsfnHxVFovQMOnaP3qVeg5LjG4+AKSEb8B3gFUhOrpWbx2vA2NiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1513
X-Proofpoint-ORIG-GUID: qfso5FECzF3Bp4qj9dXrSsMYrFM5O-FB
X-Proofpoint-GUID: LXm3T-e6EaruSXWQUgWBoH9fhECBVkDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205200104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENoZW5nIFh1IDxjaGVuZ3lv
dUBsaW51eC5hbGliYWJhLmNvbT4NCj4gU2VudDogRnJpZGF5LCAyMCBNYXkgMjAyMiAwOTowNA0K
PiBUbzogQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+OyBKYXNvbiBHdW50aG9y
cGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgVG9tIFRhbHBleSA8dG9tQHRhbHBleS5jb20+DQo+IENj
OiBkbGVkZm9yZEByZWRoYXQuY29tOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LXJkbWFAdmdlci5r
ZXJuZWwub3JnOw0KPiBLYWlTaGVuQGxpbnV4LmFsaWJhYmEuY29tOyB0b255bHVAbGludXguYWxp
YmFiYS5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENIIGZvci1uZXh0IHY3IDEw
LzEyXSBSRE1BL2VyZG1hOiBBZGQgdGhlDQo+IGVyZG1hIG1vZHVsZQ0KPiANCj4gDQo+IA0KPiBP
biA1LzIwLzIyIDEyOjIwIEFNLCBCZXJuYXJkIE1ldHpsZXIgd3JvdGU6DQo+ID4NCj4gPg0KPiAN
Cj4gPC4uLj4NCj4gDQo+ID4+PiBBcyBmYXIgYXMgSSBrbm93LCBpV2FycCBkZXZpY2Ugb25seSBo
YXMgb25lIEdJRCBlbnRyeSB3aGljaA0KPiBnZW5lcmF0ZWQNCj4gPj4+IGZyb20gTUFDIGFkZHJl
c3MuDQo+ID4+Pg0KPiA+Pj4gRm9yIGlXYXJwLCBUaGUgQ00gcGFydCBpbiBjb3JlIGNvZGUgcmVz
b2x2ZXMgYWRkcmVzcywgZmluZHMNCj4gPj4+IHJvdXRlIHdpdGggdGhlIGhlbHAgb2Yga2VybmVs
J3MgbmV0IHN1YnN5c3RlbSwgYW5kIHRoZW4gb2J0YWlucyB0aGUNCj4gPj4gY29ycmVjdA0KPiA+
Pj4gaWJkZXYgYnkgR0lEIG1hdGNoaW5nLiBUaGUgR0lEIG1hdGNoaW5nIGluIGlXYXJwIGlzIGlu
ZGVlZCBNQUMNCj4gYWRkcmVzcw0KPiA+Pj4gbWF0Y2hpbmcuDQo+ID4+Pg0KPiA+Pj4gSW4gYW5v
dGhlciB3b3JkcywgZm9yIGlXYXJwIGRldmljZXMsIHRoZSBjb3JlIGNvZGUgZG9lc24ndCBoYW5k
bGUgSVANCj4gPj4+IGFkZHJlc3NpbmcgcmVsYXRlZCBzdHVmZiBkaXJlY3RseSwgaXQgaXMgZmlu
aXNoZWQgYnkgY2FsbGluZyBuZXQNCj4gQVBJcy4NCj4gPj4+IFRoZSBuZXRkZXYgc2V0IGJ5IGli
X2RldmljZV9zZXRfbmV0ZGV2IGRvZXMgbm90IHVzZWQgaW4gaVdhcnAncyBDTQ0KPiA+Pj4gcHJv
Y2Vzcy4NCj4gPj4+DQo+ID4+PiBUaGUgYmluZGVkIG5ldGRldiBpbiBpV2FycCBkZXZpY2VzLCBt
YWlubHkgaGF2ZSB0d28gcHVycG9zZXM6DQo+ID4+PiAgICAxKS4gZ2VuZXJhdGVkIEdJRDAsIHVz
aW5nIHRoZSBuZXRkZXYncyBtYWMgYWRkcmVzcy4NCj4gPj4+ICAgIDIpLiBnZXQgdGhlIHBvcnQg
c3RhdGUgYW5kIGF0dHJpYnV0ZXMuDQo+ID4+Pg0KPiA+Pj4gRm9yIDEpLCBlcmRtYSBkZXZpY2Ug
YmluZGVkIHRvIG5ldCBkZXZpY2UgYWxzbyBieSBtYWMgYWRkcmVzcywgd2hpY2gNCj4gY2FuDQo+
ID4+PiBiZSBvYnRhaW5lZCBmcm9tIG91ciBQQ0llIGJhciByZWdpc3RlcnMuDQo+ID4+PiBGb3Ig
MiksIGVyZG1hIGNhbiBhbHNvIGdldCB0aGUgaW5mb3JtYXRpb24sIGFuZCBtYXkgYmUgbW9yZQ0K
PiBhY2N1cmF0ZWx5Lg0KPiA+Pj4gRm9yIGV4YW1wbGUsIGVyZG1hIGNhbiBoYXZlIGRpZmZlcmVu
dCBNVFUgd2l0aCB2aXJ0aW8tbmV0IGluIG91cg0KPiBjbG91ZC4NCj4gPj4+DQo+ID4+PiBGb3Ig
Um9DRXYyLCBJIGtub3cgdGhhdCBpdCBoYXMgbWFueSBHSURzLCBzb21lIG9mIHRoZW0gYXJlIGdl
bmVyYXRlZA0KPiA+Pj4gZnJvbSBJUCBhZGRyZXNzZXMsIGFuZCBoYW5kaW5nIElQIGFkZHJlc3Np
bmcgaW4gY29yZSBjb2RlLg0KPiA+Pg0KPiA+PiBCZXJuYXJkLCBUb20gd2hhdCBkbyB5b3UgdGhp
bms/DQo+ID4+DQo+ID4+IEphc29uDQo+ID4NCj4gPiBJIHRoaW5rIGlXYXJwIChhbmQgbm93IFJv
Q0V2MiB3aXRoIGl0cyBVRFAgZGVwZW5kZW5jeSkgZHJpdmVycw0KPiA+IHByb2R1Y2UgR0lEcyBt
b3N0bHkgdG8gc2F0aXNmeSB0aGUgY3VycmVudCBSRE1BIENNIGluZnJhc3RydWN0dXJlLA0KPiA+
IHdoaWNoIGRlcGVuZHMgb24gdGhpcyB0eXBlIG9mIHVuaXF1ZSBpZGVudGlmaWVyLCBpbmhlcml0
ZWQgZnJvbSBJQi4NCj4gPiBJbW8sIG1vcmUgbmF0dXJhbCB3b3VsZCBiZSB0byBpbXBsZW1lbnQg
SVAgYmFzZWQgUkRNQSBwcm90b2NvbHMNCj4gPiBjb25uZWN0aW9uIG1hbmFnZW1lbnQgYnkgcmVs
eWluZyBvbiBJUCBhZGRyZXNzZXMuDQo+ID4NCj4gPiBTb3JyeSBmb3IgYXNraW5nIGFnYWluIC0g
d2h5IGVyZG1hIGRvZXMgbm90IG5lZWQgdG8gbGluayB3aXRoIG5ldGRldj8NCj4gPiBDYW4gZXJk
bWEgZXhpc3Qgd2l0aG91dCB1c2luZyBhIG5ldGRldj8NCj4gDQo+IEFjdHVhbGx5IGVyZG1hIGFs
c28gbmVlZCBhIG5ldCBkZXZpY2UgYmluZGVkIHRvLCBhbmQgc28gZG9lcyBpdC4NCj4gDQo+IFRo
ZXNlIGRheXMgSeKAmW0gdHJ5aW5nIHRvIGZpbmQgb3V0IGFjY2VwdGFibGUgd2F5cyB0byBnZXQg
dGhlIHJlZmVyZW5jZQ0KPiBvZiB0aGUgYmluZGVkIG5ldGRldiwgZSxnLCB0aGUgJ3N0cnVjdCBu
ZXRfZGV2aWNlJyBwb2ludGVyLiBVbmxpa2Ugb3RoZXINCj4gUkRNQSBkcml2ZXJzIGNhbiBnZXQg
dGhlIHJlZmVyZW5jZSBvZiB0aGVpciBiaW5kZWQgbmV0ZGV2cycgcmVmZXJlbmNlDQo+IGVhc2ls
eSAobW9zdCBSRE1BIGRldmljZXMgYXJlIGJhc2VkIG9uIHRoZSBleHRlbmRlZCBhdXggZGV2aWNl
cyksIGl0IGlzDQo+IGEgbGl0dGxlIG1vcmUgY29tcGxleCBmb3IgZXJkbWEsIGJlY2F1c2UgZXJk
bWEgYW5kIGl0cyBiaW5kZWQgbmV0IGRldmljZQ0KPiBhcmUgdHdvIHNlcGFyYXRlZCBQQ0llIGRl
dmljZXMuDQo+IA0KPiBUaGVuIEkgZmluZCB0aGF0IHRoZSBuZXRkZXYgcmVmZXJlbmNlIGhvbGQg
aW4gaWJkZXYgaXMgcmFyZWx5IHVzZWQNCj4gaW4gY29yZSBjb2RlIGZvciBpV2FycCBkZWl2Y2Vz
LCBHSUQwIGlzIHRoZSBrZXkgYXR0cmlidXRlIChBcyB5b3UgYW5kDQo+IFRvbSBtZW50aW9uZWQs
IGl0IGFwcGVhcnMgd2l0aCB0aGUgaGlzdG9yaWNhbCBuZWVkIGZvciBjb21wYXRpYmlsaXR5LA0K
PiBidXQgSSB0aGluayB0aGlzIGlzIGFub3RoZXIgc3RvcnkpLg0KPiANCg0KWWVzLCBJIHRoaW5r
IHRoaXMgaXMgcmlnaHQuDQoNCklmIHlvdSBhcmUgc2F5aW5nIHlvdSBjYW4gZ28gYXdheSB3aXRo
IGEgTlVMTCBuZXRkZXYgYXQgQ00gY29yZSwgdGhlbg0KSSB0aGluayB0aGF0J3MgZmluZT8NCk9m
IGNvdXJzZSB0aGUgZXJkbWEgZHJpdmVyIG11c3Qgc29tZWhvdyBrZWVwIHRyYWNrIG9mIHRoZSBz
dGF0ZSBvZg0KaXRzIGFzc29jaWF0ZWQgbmV0d29yayBkZXZpY2UgLSBsaWtlIGNhdGNoaW5nIHVw
IHdpdGggbGluayBzdGF0dXMgLQ0KYW5kIG11c3QgcHJvdmlkZSByZWxhdGVkIGluZm9ybWF0aW9u
L2V2ZW50cyB0byB0aGUgUkRNQSBjb3JlLg0KDQo+IFNvLCB0aGVyZSBhcmUgdHdvIGNob2ljZXMg
Zm9yIGVyZG1hOiBlbnVtIG5ldCBkZXZpY2VzIGFuZCBmaW5kIHRoZQ0KPiBtYXRjaGVkIG9uZSwg
b3IgbmV2ZXIgY2FsbGluZyBpYl9kZXZpY2Vfc2V0X25ldGRldi4gVGhlIHNlY29uZCBvbmUgaGFz
DQo+IGxlc3MgY29kZS4NCj4gDQo+IFRoZSBzZWNvbmQgd2F5IGNhbid0IHdvcmsgaW4gUk9DRS4g
QnV0IGl0IHdvcmtzIGZvciBpV2FycCAoSSd2ZSB0ZXN0ZWQpLA0KPiBzaW5jZSB0aGUgbmV0ZGV2
IHJlZmVyZW5jZSBpcyByYXJlbHkgdXNlZCBmb3IgaVdhcnAgaW4gY29yZSBjb2RlLCBhcyBJDQo+
IHNhaWQgaW4gbGFzdCByZXBseS4NCj4gDQo+IEluIHNob3J0LCB0aGUgcXVlc3Rpb24gZGlzY3Vz
c2VkIGhlcmUgaXMgdGhhdDogaXMgaXQgYWNjZXB0YWJsZSB0aGF0DQo+IGRvZXNuJ3QgaG9sZCB0
aGUgbmV0ZGV2IHJlZmVyZW5jZSBpbiBjb3JlIGNvZGUgZm9yIGEgaVdhcnAgZHJpdmVyDQo+IChp
bmRlZWQgaXQgaGFzIGEgbmV0ZGV2IGJpbmRlZCB0bykgPyBPciBpcyBpdCBuZWNlc3NhcnkgdGhh
dCBjYWxsaW5nDQo+IGliX2RldmljZV9zZXRfbmV0ZGV2IHRvIHNldCB0aGUgYmluZGVkIG5ldGRl
diBmb3IgaVdhcnAgZHJpdmVyPw0KPiANCj4gWW91IGFuZCBUb20gYm90aCBhcmUgc3BlY2lhbGlz
dHMgaW4gaVdhcnAsIHlvdXIgb3BpbmlvbnMgYXJlIGltcG9ydGFudC4NCj4gDQo+IFRoYW5rcyB2
ZXJ5IG11Y2gNCj4gQ2hlbmcgWHUNCj4gDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEJlcm5h
cmQuDQo=
