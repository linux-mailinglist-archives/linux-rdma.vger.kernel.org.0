Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C251C103
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 15:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbiEENpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 May 2022 09:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiEENpA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 May 2022 09:45:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4353B037;
        Thu,  5 May 2022 06:41:19 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245DCGYC019438;
        Thu, 5 May 2022 13:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=77ab0Ty5ykqQwDgnYPocLacwmJ+dNP2u8u33Qv8fCfI=;
 b=f8hKKuyh7bz1abW8e3kbwdoxkkdPR3kRH8a+zm/R3pvah9nt+HZbJ8z8WD5tDQIseSSr
 Gxp1XizawxLkMvEbWprrztGCwrh4/E85l+dPVo/KYK+BC5YFArQWpfiprWw64BRH9tiy
 1/tJo33MgLGVENpN3lze+PxrIyBx9BJgCHBw6rBPgrZzwn9f2H4NXM0vDObAgfYC36Pz
 T0JA6GEAe8k4hndUCk2Bz1OKUawk76dQygHnlT7srnC/rTXvSjNOukLcJVlcjQLMeILu
 a6FQh6jmDlwofKvLJG+32tsun/vVnNnZ+eBsaVK4x6tGE5H+buRtzoGx8g+QXwdwIxTQ BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvf8grn1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:41:01 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 245DE6CQ027671;
        Thu, 5 May 2022 13:41:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fvf8grn17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 13:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbYO743AGZX5NGJUAy2kfWYPqT2BapcFqLAyEkVnJIp3hTA7PRh0k0ntwuUQfcOQNP5VLMmk/fsCsigV9l6+4ZOYiwHUoK6iBTb4jMqDIW1JjilWodVz308UrezCWAfQ7Kfna3fYXilHZmoIoKdNpVFXwkqEubrJQ5X+zn/o1rVoKeOQaT6Ii20Uaz/a3qVBzx7zEoGoLm/mkyFgiUym+sd7iVJ1wgZ+Ev3UR/w/u4HLcnvacs3Mb7PgZQwXbkxIjoWfFcdufc0Av7MGhZlJgY1ZOMawozrwBR/r0xBkUOAAAqeAyayzyMy+6GWIxmZugerkfxVn8hcN35upT+EL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77ab0Ty5ykqQwDgnYPocLacwmJ+dNP2u8u33Qv8fCfI=;
 b=muXxwMjRjYAz5b5yqjh391iBXFwfzHbFWorTktD+wBKfL4MT1V4iqUlNLPDgR2gYdAY0PvrpZ/d8G0AeeB0M6frOmcBlgBeIuBths/5BQckhF9+OQqKzQHbtrKUQRVQlIbopnZmTlK7pA8dADBp8YzljQIMe8tCl2DQNIYEt8BzulJl6XpBW6bwh6r9kLwRGVtdkGrQ941KfIIIdt3MSNLqmCNA2Q50vVHAH4oS/RyYkPGr7OqDWqJ2B3fq41LuGE9bSV3E+tKk7clGcTrb8Vs4Zh/p+jiLw/jrq1oEyqvA8UeecJY4noLLNW9mB3jyW2cB16Jh8Q5hkbJSA6JmG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by BN8PR15MB3057.namprd15.prod.outlook.com (2603:10b6:408:8d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 13:40:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 13:40:58 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: RE: Re: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel warning while
 testing blktests srp/002 v5.17-rc7
Thread-Topic: Re: siw_cm.c:255 siw_cep_put+0x125/0x130 kernel warning while
 testing blktests srp/002 v5.17-rc7
Thread-Index: AdhghAgr0FkkgxdCQ1WInjOIf4Ev5A==
Date:   Thu, 5 May 2022 13:40:58 +0000
Message-ID: <BYAPR15MB2631DAC4FC3CB59344879A4C99C29@BYAPR15MB2631.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8632f566-3e6e-4369-e52d-08da2e9ce2f2
x-ms-traffictypediagnostic: BN8PR15MB3057:EE_
x-microsoft-antispam-prvs: <BN8PR15MB305734CB569DB3BCE658DDDF99C29@BN8PR15MB3057.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FuU5oux3OlOQfmZr6I6jfkjPPb4lMpH2EGlCzfTvtnnMcKtcD54J1UmvDBZMD6mOaLAZqAJehi4IZS5FH0Ff40gilYxAw4w089LRx4S2mJgZI/3Si07FXRG8OWxr59nikQg8OJraO+uLWLsIhDO3lw+AH+S4fGuWoimJWTqsCd2V+r3Gdw0Aq2dMb4x50JM+94mc0yZfSg/wMMHy9Isjdf+1JT5WoHc/DS732s6paQk0fQB9cB/n9AJkgSZmrrdD3gnmQErvRT3czFHs6m8JI62fPdyRbb3fktf9OkMAtdhVfz9WNU06W3NP7m2WzoNF62wV4utF3nlUdyUqhpOPRJQKXq4ogv61jnc/0w28RVxKoVZd5+9BPVwJ9vqAoHt6yG1HiUnQkLttHXfFrD8MgHRfvgDSCRXH5qJ9o0DwQEmgQlOczy087nr+/Qy7auFzvk3Abj9hUyuZj2vnWxHgk97qcs7c754SaF2bPWnj6zmLKc+5fJChbHjlQPivfObZTgslpGn22FoXXS9o4n4ZB1xwU7Nf/YA5DgE/IOKap6eIaYIcLPpSjpTWCkwKlxqipbaA9Y0U5GwVp+4fo81KQMLFd3LZjzT8isgXDMCir4v+BxsXrwvg4Zv9wmYoZ3WDJBaw4swT6L2dHsmajo5nzbD/SLkTEQ/KWqN6tcKPAD2e15S+WoizAKyPrFqcJ8CwVaxGxGdsiIIbRUuKpV+2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6916009)(52536014)(19627235002)(508600001)(6506007)(5660300002)(8936002)(186003)(9686003)(316002)(83380400001)(33656002)(38100700002)(38070700005)(86362001)(122000001)(55016003)(71200400001)(8676002)(7696005)(76116006)(66946007)(2906002)(66556008)(66476007)(4326008)(64756008)(53546011)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVR5cllHb0g1TWhWNDJ5dUtERGdXVFNVSEFCOWg4OHM3RjkxZCs2U2lKdDZl?=
 =?utf-8?B?VUpzVmlkWFQ0ZjhUMzlYYjZIWjZCQjM2SllOUmlUb2FSS09DYWoxRXRFSlhP?=
 =?utf-8?B?NjBwcWZEaGZsbVpqRWZ2cTZLY3pHV2hLWUNid0w3VjAyTFRVbmxMcktaSVVy?=
 =?utf-8?B?MnVTWkRJaE9DM25vRHRoa1l6RTk5ZWlXSmhCbWFINWE0R2J2UkU1ODRpYW44?=
 =?utf-8?B?dnJrSlI2LzJDWjFtQis2eDk4N3o4cDRMVE5xRFBOMysvYVI5eS9aZDBOb0Rs?=
 =?utf-8?B?OTB3NjRJMTNOVXZzZzRUOUJIclpmK0VOL2pXSzQxbXhNZHBlWUF2UFJUTzVI?=
 =?utf-8?B?WmNZUmxjdWd6ckpXMXAxV3ZiSmpYQTZwTmxIT0FpQ2J2Wkt1SlNRaWFNNkRp?=
 =?utf-8?B?T0tPOGtLZHNsRklkc1BPeHY0eFJ5NXdhYWJWNzlIZUJzeTV4OVhVQml2WXdJ?=
 =?utf-8?B?UUc2V2VzcFU1RmVpanNRR0pxRXF2dXNEdkRBWUNmS1VGRlNGcHFqRjIrOEhX?=
 =?utf-8?B?TVVaNkYrUThCSDV6WmFOM3l5YVJJSnFmZFdIbFFPaGNOOEJrdWhJK0VaREI5?=
 =?utf-8?B?dHNHQm9yMXJOMVFSMVI2T041TGZZbzd2b2pYTTJheTl1VTBGSi9mR0Y4Rlhi?=
 =?utf-8?B?SndNK2Q2Mm04WmMrYVN5K0ZyRWVtSFI1Mk1YTGJhUXZDL2NiN2tmOGtaTERm?=
 =?utf-8?B?VWNxYk53eHVjUkU4RHBpM28zYW5Rb2xNcWo0R2JMdlUrUTlaNWZGZFljNWgz?=
 =?utf-8?B?aXdwSzdrUUJrbUlOWWZIVldkcGJwcjVWalg2TnVOVTZEYVJoQW8zbGRSRkJN?=
 =?utf-8?B?dklLTUUvSHNhRWx0d0xRS1hwbWFsZm5rQ0Zld08yam1QT1hyWHBzUjFsZzNB?=
 =?utf-8?B?L0FhV09MS3lOL1FoODV6NUNFaEdZYVhQQWdYVFZFVUZlai9ianRMaHpLbzZU?=
 =?utf-8?B?NTRYUE9yZkp1RC85di91RGxwdWxDTUkyakVKMnVJT08rUWcwYnBOcTBxVTJI?=
 =?utf-8?B?TW4vSWxVKy9OdDNnTGkyZ0ZncWdSYzJPd0VUeTI2cE8wbXpVKzRIZ1dYU3lD?=
 =?utf-8?B?eUpGMjNINDV4RGFseDFBVlcrcnRyMHVXNEdIcDBjTnVUaERNK0pHWVFhVmk1?=
 =?utf-8?B?UU5zczZjU2lCakl5bUljcjFFWCtEZkE2MmJPQjlyeE83VDdMRmw2SjV5YUxn?=
 =?utf-8?B?Y3BVOEFNMWNQVUw5K3MrQnduRUF2Tm1iSkl5K3FRSlM1VzRIY0xGazlNSkpX?=
 =?utf-8?B?V056S01WQnEyZVJaQzlYaEZodGZuYlFhaDV3YmJEOERvKzIxQS8xbEhrTHRy?=
 =?utf-8?B?QThHczBldGhPMlpOMzZleG14U3hhcUNwR2JZbTIwbVA0YXFYeVNxRmkwcC9K?=
 =?utf-8?B?VFlhUTFIczJYTGduS0JlbTN3OXNBeFZFc0l3Y0RUa2VjTGJjbENaSVpDTXNQ?=
 =?utf-8?B?UlhNS0RZbFZMSHBTM3pTVWdMcFpRWi9QMnlacUVzaGJOSkNMbUcxNTFuRG5u?=
 =?utf-8?B?cVZpVEtHV3VFdVRQV2VyK2M5aXNkMGJpYXF1WmNBeGlzZU1tVTFyZ0hLZ21m?=
 =?utf-8?B?WmZRMU5YRVZzdnNFS284dTVoKzJxa1Y3T2xuZlB1WFdvSTlLRUhhZHpYYllT?=
 =?utf-8?B?c0xmdnFRU3pOQ3E1dk0wZjJBZGd3WTc5c3RoZWlpZzJRVjIremtJQ1NkcGQ3?=
 =?utf-8?B?dWdiZU9mOUcvWEY0WTFSd3pQWGx1UUQ3bEN3ZWJrdlphYkczTC8vNW41bk9o?=
 =?utf-8?B?RzlKZitmeXhINklTdGx5TUN1NmpSU0NCYUJEcVd3ZTdUeW93VXNGZlBBWkpD?=
 =?utf-8?B?ckZRSCtRT1JnZlFKQ2NjOTB5NTlHek5DYS9QSmJmSElyZFE3ZU9HWGhrcXh1?=
 =?utf-8?B?OTZ2TFBRSmtvKzhCVUdrNkNhcHYxUnU4c2ZqeDNQRjRRaWdjZytDSGlSWGEr?=
 =?utf-8?B?MElFQjMzMDF2d00rdzZOT0NMVFlwUU1FS2ZIcjRtS29zVFNpQTlmZVUzNTQz?=
 =?utf-8?B?SE9nNmRQWFNnSXl4cko1MWlGY2xRckVBbWVkQmtXT0dwekVJWklkbnN6QXQr?=
 =?utf-8?B?aW5kZUhTZ0FycFRiZVJrUDV1SmtxT3JuN25SbDRsRlVXS3NGdU0yQmJicU9T?=
 =?utf-8?B?R2h1MmNPUHppQ2EwNUlPRnhSYjd0ZlNCd09aWk5UR2tGNDFwVk1lcVlqSkZJ?=
 =?utf-8?B?RHVYS3V3L2RFbFYzeFFDWC9LSXl5SHhuc244NlhCemtXOHEyejErZS9kR21G?=
 =?utf-8?B?bUNZTHRQV2prRFNMNEU3MzZBVzluNmFsaldmSmVTYWlja2dUTFppTkhtcHlC?=
 =?utf-8?B?UnNBZGhoK1Jscll2YW91a0pJcjl0cmtjQ1phbkV1S0NZWVpJWE45V1E0akF1?=
 =?utf-8?Q?hgfuSXpXIxEQDZe0PGF9BjJcxOLvE7EAPapo2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8632f566-3e6e-4369-e52d-08da2e9ce2f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 13:40:58.3222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnGGu13DL8KFk0pkZCKfPh9yTzKrrhrlSO7bfzdbmPOS7/eZPpfTfVVf+5ygsJuCpIGIBsAFdTR3/bkT8xtTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3057
X-Proofpoint-GUID: vNaChS6Lx1vG-ymdrt10Y15YXG_EsthV
X-Proofpoint-ORIG-GUID: Ut2TdMuKvyTmzvF5vLHUdIFF5UwSE7uc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpcyBDaGFtYmVybGFp
biA8bWNncm9mQGluZnJhZGVhZC5vcmc+IE9uIEJlaGFsZiBPZiBMdWlzDQo+IENoYW1iZXJsYWlu
DQo+IFNlbnQ6IFRodXJzZGF5LCA1IE1heSAyMDIyIDE0OjQ4DQo+IFRvOiBCZXJuYXJkIE1ldHps
ZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IENoZW5nIFh1IDxjaGVuZ3lvdUBsaW51eC5h
bGliYWJhLmNvbT47IEJhcnQgVmFuIEFzc2NoZQ0KPiA8YnZhbmFzc2NoZUBhY20ub3JnPjsgbGlu
dXgtYmxvY2tAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcmRtYUB2Z2VyLmtlcm5lbC5vcmc7
IFBhbmthaiBSYWdoYXYgPHBhbmt5ZGV2OEBnbWFpbC5jb20+OyBQYW5rYWogUmFnaGF2DQo+IDxw
LnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogc2l3X2NtLmM6
MjU1IHNpd19jZXBfcHV0KzB4MTI1LzB4MTMwIGtlcm5lbA0KPiB3YXJuaW5nIHdoaWxlIHRlc3Rp
bmcgYmxrdGVzdHMgc3JwLzAwMiB2NS4xNy1yYzcNCj4gDQo+IE9uIFRodSwgTWF5IDA1LCAyMDIy
IGF0IDExOjQyOjU1QU0gKzAwMDAsIEJlcm5hcmQgTWV0emxlciB3cm90ZToNCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4NCj4gPiA+ID4gKnBva2UqDQo+ID4g
PiA+DQo+ID4gPiA+IFdvdWxkIGJlIGdvb2QgdG8gZ2V0IGEgZml4IG1lcmdlZC4gQW5kIGlmIGEg
cGF0Y2ggaXMgcG9zdGVkIGRvZXMNCj4gdGhpcw0KPiA+ID4gPiBuZWVkIHRvIGdvIHRvIHN0YWJs
ZT8NCj4gPiA+ID4NCj4gPiA+ID4gICAgTHVpcw0KPiA+ID4NCj4gPiA+IFRoZSBwYXRjaCBoYXMg
YmVlbiBhY2NlcHRlZCBhbmQgbWVyZ2VkIHRvIGZvci1yYywgc2VlOg0KPiA+ID4NCj4gPiA+IElO
VkFMSUQgVVJJIFJFTU9WRUQNCj4gPiA+DQo+IDNBX19sb3JlLmtlcm5lbC5vcmdfYWxsX2Q1Mjhk
ODM0NjZjNDQ2ODdmMzg3MmVhZGNiOGMxODQ1MjhiMmUyZDQuMTY1MDUyNg0KPiA+ID4gNTU0Lmdp
dC5jaGVuZ3lvdS00MGxpbnV4LmFsaWJhYmEuY29tX1RfJmQ9RHdJQ2FRJmM9amZfaWFTSHZKT2JU
YngtDQo+ID4gPiBzaUExWk9nJnI9MlRhWVhRMFQtDQo+IHI4Wk8xUFAxYWxOd1VfUUpjUlJMZm1Z
VEFnZDNRQ3ZxU2MmbT1najJBeUtvT01fazlmWUYtDQo+ID4gPg0KPiBfWFE0SGNZd192aU9Jd2w2
bEROUEhxcDdMMXkyT2lWUld2WmtURkdGSFNTWklub3Imcz1QX0hhWElYdDltQmJDZUJOQkxzV2UN
Cj4gPiA+IFJUejVodm5VR1V2T2J6czhsb3d6Q00mZT0NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRo
aXMgcGF0Y2ggbmVlZCBub3QgYmUgbWVyZ2VkIGJhY2sgdG8gc3RhYmxlLCBiZWNhdXNlIHRoZQ0K
PiBpc3N1ZQ0KPiA+ID4gaXMgbm90IGEgZnVuY3Rpb25hbCBwcm9ibGVtLCBidXQgb25seSBwcm9k
dWNlIGEgV0FSTiBpbiBkbWVzZy4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBDaGVuZyBY
dQ0KPiA+DQo+ID4gSSBhZ3JlZS4gSXQgZG9lcyBub3QgZml4IGEgbWVtb3J5IGxlYWsgb3Igc29t
ZSBzdWNoLg0KPiANCj4gSWYgdGhlIHdhcm5pbmcgdHJpZ2dlcnMgb24gb2xkZXIga2VybmVscyBp
dCBtZWFucyB0ZXN0aW5nIHVzaW5nIHRoaXMNCj4gZHJpdmVyIHdpbGwgZmFpbCBhbmQgdGhvc2Ug
dGVzdHMgd2lsbCBiZSBza2lwcGVkLiBJbiB0aGlzIGNhc2UgdGhlDQo+IHRlc3Qgc3JwLzAwMiB3
b3VsZCBiZSBza2lwcGVkIHVubGVzcyB0aGlzIGlzIGZpeGVkIHRvIG5vdCB0cmlnZ2VyDQo+IGEg
a2VybmVsIHdhcm5pbmcuDQo+IA0KPiAgIEx1aXMNCg0KDQpBaCBva2F5Lg0KU2luY2UgaXQgd2Fz
IGFuIGVhc3kgZml4LCBJJ2QgZ28gZm9yIG1lcmdpbmcgYmFjayB0byBzdGFibGUsDQppZiBpdCdz
IG5vdCB0b28gbXVjaCBvZiBhbiBlZmZvcnQuDQoNClRoYW5rcyENCkJlcm5hcmQuDQo=
