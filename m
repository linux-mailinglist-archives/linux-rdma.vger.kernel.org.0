Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03768525F0E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 12:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379042AbiEMJj5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 05:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379093AbiEMJjx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 05:39:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250772A7697
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 02:39:51 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24D8l1Co017371;
        Fri, 13 May 2022 09:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : date :
 message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version : subject; s=pp1;
 bh=8907ZxoLM3dGDF3nWe7C46Ixy+GYlJ5mHURnOyquu1I=;
 b=jvZvFPdRvMPKx05rWIqAU/bSWeMHkfzi1Q7iPkbLyebyFB3XSir6gz1YQBmBl5mYg5+S
 rO06r+2+BOrZpPu2Zj6YcLopfAtjKPbTqzHuNg9Qxu7rkC4T9X/tZYsxKB07pTdAyh+s
 XD8RARaRKDBZkoLdpiVVesTphGdU/T4BonnRK87H0jDjj/0cOVyhNJwu4nllHGPOnbMU
 b4F1UqBmPhXE0A2jWYZwoJ55rBAA6SUNwE/vguQAO18q/vZRXLee53Yoywh2jUCiyb0R
 G5nm/TLrFW6Y1i9wE8b4GYaqx7DnYe42+xcX1HyZhkkn8E23owJw5EyFpH0h3fqKO+Fi Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1m4g8whn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:39:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24D9aX2v028480;
        Fri, 13 May 2022 09:39:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1m4g8wh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 May 2022 09:39:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7MfX85ZO78U9515QRoOkiV/YptpOKZc+EAGHhb2IikM/BcAVPz4pBL+LuIB3aiOYPTTZz7WU/FgZMHJem7bbZZbIocg43sBvnihu+PG3h7PoDvHXDctwp6pUwNry/oZxoIZmX3ObnbnD4BtE8DJkZJF0HvWfibCKw30hf28DR5pFBzeovxcqpbBOG6NodMyb5M+xLqc08LVrGcpTfM2sB/pnaMDstTIFEGxzSrjhv3HUY1FYEEavHEfT5ON5jIOgbO+AiwpIPwYyeJ/+WSZglfGmzdER0rlej4mUck6IcUIwh6Otw/F4CZ8YXUA4XZMZELXUrVayPluDNPY9IYbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8907ZxoLM3dGDF3nWe7C46Ixy+GYlJ5mHURnOyquu1I=;
 b=cOsBXu2zzpE30bCC5FrWLsHI3KbpGadMtdDlHeDAv4f+6lWWYujyN8eh37kHF+pMcyncQKIOcVMrhB/E4Uq3JDeHUrPXRULXqFyqQWynfYGriMzFEUp39QYBWt8fOKqjipJ2+AgHVNe0zWQObiKEwSCMQi5jQkK/ofmCAhThawAH5qzmWvf1NFYYcJgDyILpmmmvdDxwqppiC6UG+NmT4FHuwgzIRw4Y45jJwHKcB1auFJ+m0IVZnfH5XttosTWzzuFIPo8NJFlG3TVRxRHMtQ0B7668OVjxrO8OBhWjVvL6fob6aKLR7OAACxJmScgScxHfqZ4oNOX3Q+KINgxjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19)
 by DM6PR15MB2203.namprd15.prod.outlook.com (2603:10b6:5:8b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 09:39:45 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::fc90:e9f2:8fa8:a7c3%7]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 09:39:44 +0000
From:   Bernard Metzler <BMT@zurich.ibm.com>
To:     Anand Ashok Khoje <anand.a.khoje@oracle.com>,
        Linux RDMA <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>
CC:     Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Thread-Topic: [EXTERNAL] Re: [RFC] Adding private data and private data len as
 argument to rdma_disconnect()
Thread-Index: AQHYZn9pOLWQKTdSw0SfpfzU1AqvQq0cg37g
Date:   Fri, 13 May 2022 09:39:44 +0000
Message-ID: <BYAPR15MB26310745FFF0D04D6E73822199CA9@BYAPR15MB2631.namprd15.prod.outlook.com>
References: <057cdabf-997b-6f4a-6877-0be89254166b@oracle.com>
 <22a2ee27-fe80-fc64-6838-0dd272288c46@oracle.com>
In-Reply-To: <22a2ee27-fe80-fc64-6838-0dd272288c46@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dad658d6-a3cb-4fd6-5cb0-08da34c48344
x-ms-traffictypediagnostic: DM6PR15MB2203:EE_
x-microsoft-antispam-prvs: <DM6PR15MB2203BFC351BCB90595035A3399CA9@DM6PR15MB2203.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDD+nPpJaMEyCnKxy13h34QDpj8P0HyMBPUrpiNv6+V4zRylhOBHi9U1es1qOKdMvF4+uqyUTgJLRepbh46WUlL6AJ7ssvILSr7WE1ZhG4/z/F7XQx/Eoc23Vf/KakhXSHwzpq0VwmsqiFYlQ9t2ohQPuCFPp5vaovpFeR70goW+NYJPmDqfYBm4S5Q3aQV3DMq9b+afkElFqRrDCei2KOiEPGDmdOGgsvoZWwz7UegnoS1ibPM0cmAoRFuE/Kf2JBRhvQoGzZMB62uOr7qFL6hH3X/tJdl5B8pgAZZfaJc/QIyOnE/FfE8+mi1CMQ/VPZI7EB2GxMmlGjxHg6Id3nq1UrNpL+gdvPDtlNTuTSnO8uN3hAYT+TnnQubKwBcij68Z3rkWL5e5Etcb1hOvYcPqXueucKkRIarxX4vlHPVsK33OjtXtBNLEnIeJ0a7VD9s3Y/3RugrmUlPl8GoSJxs8ag9jr+0kG8A+sAgfDV3qlaNoqHzAdSYJDUjwt5zB1ruZpQA5CxLO+WeA4l/N1oAGliWxjSYUW4LDS4g7qKwr6YjWjwSTw6vHsjAPIb+Ccmm6jpAJhYzcFIXp36MsajWkJ5ZjClaDbRNbvOsrB830GjH1H+xXxFEJIXlnoWDPa8wDejA9eHpf6EmwaHEjqCIoBbmoIOETF9F8TFWGenoqogjUL2ZIjuwggNX1F/6awpWaoRfiLaRYw3WrHBIxhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2631.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(83380400001)(316002)(9686003)(52536014)(122000001)(71200400001)(76116006)(7696005)(53546011)(6506007)(110136005)(54906003)(508600001)(86362001)(8936002)(186003)(55016003)(64756008)(66446008)(66556008)(8676002)(66946007)(4326008)(66476007)(33656002)(38070700005)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aExCeUFGREVoWGlWT1Eya1VYcndsMVpDSkxCU3VITzZORHhEdnRZc2V2MU1F?=
 =?utf-8?B?Y0luY0hQTUtYU09OaS9HUnRUcDJseldYclFxeDJOT1BvckVrdXNsb2ttei81?=
 =?utf-8?B?OXF0TEUwUUNkeXFQUytrNm5lR1BvaXVUZ0kvdGJWdzZvR1NKTWtrMHE4aHZq?=
 =?utf-8?B?Rk1FL0xUWTdJWHY5SjhZNjRNdnV5RUM2YTJHS3NyWkpkejZsRVI4K2VjaGRX?=
 =?utf-8?B?OStQTTVVb2RFQkJmZnNVS1VzWVd2Zk53amlYdFlOeDh5eE0zMmxVWFRYd2Ux?=
 =?utf-8?B?U0FVS1RYOTlpdnZQeUVNMmFLSHQ3UzVsdkhoNjRjcU05bStqSFE5Tkp4bkhx?=
 =?utf-8?B?NVN2aTNyOTg0RUpJNkh3MDNGKytzSHhSbUFKQXd4dzQxTXNqU3FydUdic24r?=
 =?utf-8?B?WmZ6b3VFdEdMNHdvbmFVTE5ndk9URk54YkJ3NCtWWlBidHBJUDRRYWdlcXo0?=
 =?utf-8?B?VTZTSnJpRnFYdmpuSklZZkQ3OTJGQi9qVEFrM3lxZlVKSkxMcUhBNm1jU3lS?=
 =?utf-8?B?cG5acUlUV0JSUGNKNm4rZ0lkOVErMTJ1NDlHWmpVNld6SEJJdVdnL3A4QXV4?=
 =?utf-8?B?V2FKNytxMWJRblJEaVB3NXFpZUxuWTRqTlUzd0xxMG1wOXo0djIzdDJiY3Ra?=
 =?utf-8?B?ay8xVGNqOER3VUNIVnZWc0l3V2ZzVEYxZTBGK09sUTB0NkNTV0EvaWxaYTZs?=
 =?utf-8?B?M2plUGVzczV1bGllUktmdWdOWHhpZmY2T3h6SENET1d6VU9MeVI2cUtQaWZF?=
 =?utf-8?B?Rk1DWlFuSEZBVDZXN3dXaDNCM2hFYkJSci96RlFsbFJaSEt6NzlPeUwreUJ3?=
 =?utf-8?B?cDQ3VmZ2VDhoWHdBdnoxRkgvbnc3NEdLYUlVVGZmbUxJTzV1SkNTSUZiREhj?=
 =?utf-8?B?TmJmRXVvWW4xQ3FmdTI4STgveUVRdjNlVGwwUVVvUG04S1VCaDI3Qk1lSnhZ?=
 =?utf-8?B?MWFGSng0VEw0ZU03WGdCTzBjQmkyNkJLOUcwL2w3VG1RcGg5RTd6bVkvd1JK?=
 =?utf-8?B?eFYrUUVzelYydTFlbTc4S1prWVoyK2FxOTBtQnFic0JuSGJrMlMyd2ZHeHlV?=
 =?utf-8?B?eVRhZHFTNUNka0U0aFR2UXVGcUxqc1lMMG1WYklLZTJGblEvSGhUWGZOaFE1?=
 =?utf-8?B?czJFdmxqcWIvbWlObjZneS8zRk5SNG5TYm1iNjQ4S1ZUUUhpKzRQVWUzUEtI?=
 =?utf-8?B?MGJyVUhWTUxSZG9sSkhORGswRDM1VXltNVF3ck9JdmlaVS9DVTMrVHlnSWJB?=
 =?utf-8?B?aWZCZUZPdlEvaWE5VlVoL3RmaStBSFM2M0FabmdsNmQwZHV0OW1laWFoN3NI?=
 =?utf-8?B?U3c3UmpVZmh2SFFvbTZSSk1QcFdnY1RNTEtYOE4zMm00eisrY2RLV3VXbnJL?=
 =?utf-8?B?RDUwN1lYaDlJYVFSWWlTZE5nWTVVeHl3elp0eU5LbGZUeEt3cTVRYmZ0VnZZ?=
 =?utf-8?B?Y0Nlc094aVdoeGQ3YVhOU3drL1gweE4yWkZIUytxZFdiUGNHK3RqSTAwVjlY?=
 =?utf-8?B?QVBURzVTQ3A2UE9EdkhBT3lWRWxCdTF6Y3d2bnhpRjJhK015dkg3cWlsMFRh?=
 =?utf-8?B?NTA0TWx4MTNaSU1VSXA5bmdHbXI4VTlRYXlJZXAzakNzdkRKYzNlMmdIWjl2?=
 =?utf-8?B?czIvano4OW5qSEVFZUF2aWd3QUNJcmNkQ09MZEtlcklqcFdGcmQ0VVJXOHRG?=
 =?utf-8?B?R3k1TzlvOWFsYXBFdnBuNFVzYjhSQnAyZTRkeW1yVEQyQSsvTWxqcTlKcngr?=
 =?utf-8?B?WTNkanY2NDhSbGFKd0VjeGM4a0ZhY3NtellhTmpzYlUvRlpxK0dzbFVoeXU4?=
 =?utf-8?B?TnRiSU5YSWw3U2NTejRwQnVOWFE3cXoyRGlJN3hxL0V3TlRxRFYyOHArdzdR?=
 =?utf-8?B?ellvazJxK29iV0c4YUM0ZVFwVnlRT3dpQnU0UExYd3I0V3o5ck1xMVVLSlMz?=
 =?utf-8?B?T2xQbllpQksxNGVhZGNxUmJVeUFjaE90cDBya3lJbXZDUjlDeXRRSCszM0Zm?=
 =?utf-8?B?enlHVnEvbVBEalIvZ1RJMWJ6T2JCMTJZZk8xcGxNTFpsTUVxS3NDNlFVZTJv?=
 =?utf-8?B?WXlOeE5tdGFEWWtqNTFTVVpkUEVyQmZQaGhrL2dyWHArRnpqN2NoTjJHNkJy?=
 =?utf-8?B?MThHNG91enp0UG5hSkY4ZkNCS20rNmNsTDUvV2Y4bkxZV3pJdjBSalQ3OHBM?=
 =?utf-8?B?b2NFWTRUT0dPNUI1K3l6VXJMR2QvOGNFWm9XejNOOGhjK1o0VHhnNEU3M0xz?=
 =?utf-8?B?a1pJR25rWFhnWGlpTi83bmpRcFV2cXdrbFBVUWNYb3NKRHJtQjhOMk1vZnpM?=
 =?utf-8?B?MUhGR1NSanZqbTd4VWU3K0dBOXhKMGJvWE42RWU2WGxNZ05kclJYaW1oRWI5?=
 =?utf-8?Q?KWtv1cQZC6PIMrbsBWHDXGTFfGCCjn/qSktvr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2631.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad658d6-a3cb-4fd6-5cb0-08da34c48344
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 09:39:44.6251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbJdPGcmdSa3tXTaPF+525K72ojMvbzxQf2QIvHzjVlj/3QHoWgWYWrdG3Ks55GRqOKF2JrUGoN0w3kXqv6hsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2203
X-Proofpoint-GUID: OhoX-tAoIZ57y97pVvpCMbzGo0RAg1a-
X-Proofpoint-ORIG-GUID: rQ6kPMux3WlCCkOPNf2clec1xJbfIkSR
Subject: RE: [RFC] Adding private data and private data len as argument to
 rdma_disconnect()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_04,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205130041
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmFuZCBBc2hvayBLaG9qZSA8
YW5hbmQuYS5raG9qZUBvcmFjbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIDEzIE1heSAyMDIyIDA2
OjEwDQo+IFRvOiBMaW51eCBSRE1BIDxsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZz47IEphc29u
IEd1bnRob3JwZQ0KPiA8amdnQHppZXBlLmNhPjsgRG91ZyBMZWRmb3JkIDxkbGVkZm9yZEByZWRo
YXQuY29tPg0KPiBDYzogUmFtYSBOaWNoYW5hbWF0bHUgPHJhbWEubmljaGFuYW1hdGx1QG9yYWNs
ZS5jb20+OyBNYW5qdW5hdGggUGF0aWwNCj4gPG1hbmp1bmF0aC5iLnBhdGlsQG9yYWNsZS5jb20+
DQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtSRkNdIEFkZGluZyBwcml2YXRlIGRhdGEgYW5k
IHByaXZhdGUgZGF0YSBsZW4NCj4gYXMgYXJndW1lbnQgdG8gcmRtYV9kaXNjb25uZWN0KCkNCj4g
DQo+IEhpLA0KPiANCj4gDQo+IEEga2luZCByZW1pbmRlci4NCj4gDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiBBbmFuZA0KPiANCj4gT24gNS81LzIyIDE1OjMyLCBBbmFuZCBBc2hvayBLaG9qZSB3cm90
ZToNCj4gPiBIaSwNCj4gPg0KPiA+IEkganVzdCB3YW50ZWQgdG8gZmxvYXQgYW4gaWRlYSBmb3Ig
YW4gZW5oYW5jZW1lbnQgYW5kIGdldCBvcGluaW9ucy4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgcHJv
dmlzaW9uIGluIGliX2NtIGxheWVyIEFQSSBpYl9zZW5kX2NtX2RyZXEoKSB0byBzZW5kIGENCj4g
PiBwcml2YXRlX2RhdGEgYWxvbmcgd2l0aCB0aGUgRFJFUS4NCj4gPiBUaGlzIHByaXZhdGVfZGF0
YSBpcyBoZWxwZnVsIGluIHNpdHVhdGlvbnMgd2hlcmUgdGhlIHJlY2VpdmVyIG9mIERSRVENCj4g
PiBtYXkgd2FudA0KPiA+IHRvIHVuZGVyc3RhbmQgdGhlIHJlYXNvbiBmb3IgdGhlIERSRVEgYW5k
IGRvIHNvbWUgYWN0aW9uIG9uIHRoZSBiYXNpcw0KPiA+IG9mIHRoYXQNCj4gPiByZWFzb24uDQo+
ID4gV2UgaGF2ZSBjb21lIGFjcm9zcyBpc3N1ZXMgd2hlcmUgaXQgd2FzIGNyaXRpY2FsIGZvciB0
aGUgUkRTIGNvZGUgdG8NCj4gPiB1bmRlcnN0YW5kDQo+ID4gdGhlIHJlYXNvbiBiZWhpbmQgYSBE
UkVRIGFuZCByZWNvdmVyL3R3ZWFrIHNvbWUgcGFyYW1ldGVycy4NCj4gPg0KPiA+IE5vdywgcmRt
YV9jbSBsYXllciBoYXMgYSB3cmFwcGVyIGFyb3VuZCBpYl9zZW5kX2NtX2RyZXEoKSBpLmUNCj4g
PiByZG1hX2Rpc2Nvbm5lY3QoKS4NCj4gPiByZG1hX2Rpc2Nvbm5lY3QoKSBpcyB1c2VkIGJ5IHRo
ZSBjb25zdW1lcnMgb2YgcmRtYV9jbS4NCj4gPiByZG1hX2Rpc2Nvbm5lY3QoKSBkb2VzDQo+ID4g
bm90IGhhdmUgYW4gYXJndW1lbnQgdGhhdCBhY2NlcHRzIHByaXZhdGUgZGF0YS4gRHVlIHRvIHRo
aXMsIGNvbnN1bWVycw0KPiA+IGFyZSBub3QNCj4gPiBhYmxlIHRvIHVzZSB0aGlzIGZlYXR1cmUu
DQo+ID4NCj4gPiBJbiBjYXNlIGlmIHdlIGFkZCB0aGUgYXJndW1lbnRzIHByaXZhdGVfZGF0YSBh
bmQgcHJpdmF0ZV9kYXRhX2xlbmd0aA0KPiB0bw0KPiA+IHJkc19kaXNjb25uZWN0KCksIHRoZSBv
bmx5IGNoYWxsZW5nZSB3b3VsZCBiZSB0byBhZGQgdGhvc2UgdG8gdGhlDQo+IGNhbGxlcnMNCj4g
PiBvZiBpdCAoTlVMTCBhbmQgMCkuDQo+ID4NCj4gPiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0
aG91Z2h0cyBvbiB0aGlzLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gQW5hbmQNCj4gPg0KDQpOb3Qg
YWxsIHByb3ZpZGVycyBzdXBwb3J0IHRoZSB0cmFuc2ZlciBvZiBwcml2YXRlIGRhdGEgaW4NCmNv
bnRyb2wgbWVzc2FnZXMgYWZ0ZXIgY29ubmVjdGlvbiBlc3RhYmxpc2htZW50IC0NCnJkbWFfcmVq
ZWN0KCkvcmRtYV9hY2NlcHQoKSBiZWluZyB0aGUgbGFzdCBvcHBvcnR1bml0eQ0KdG8gc2VuZCBw
cml2YXRlIGRhdGEgaW4gY29ubmVjdGlvbnMgbGlmZXRpbWUgZm9yIGUuZy4NCmlXYXJwIGNvbm5l
Y3Rpb25zLiBNYXliZSB0aGF0IGlzIHdoeSBpdCBpcyBub3QgZXhwb3NlZA0KYXQgdGhlIGRpc2Nv
bm5lY3QgQVBJIGNhbGw/IFdvdWxkIFJvQ0Ugc3VwcG9ydCBpdD8NCg0KSSB0aGluayB5b3UgYWxz
byBhc2sgZm9yIGV4dGVuZGluZyB0aGUgQ00gZXZlbnQNCmluZnJhc3RydWN0dXJlIHRvIGNhcnJ5
IHByaXZhdGUgZGF0YSBpbiBESVNDT05ORUNURUQNCmV2ZW50cz8NCg0KVGhhbmtzLA0KQmVybmFy
ZA0K
