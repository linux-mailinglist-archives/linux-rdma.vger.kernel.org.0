Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79952DDD46
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Dec 2020 04:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLRD1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Dec 2020 22:27:31 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:10132 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgLRD1b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Dec 2020 22:27:31 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BI3OuX5031567;
        Fri, 18 Dec 2020 03:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=c0eex8cWYwLtQCtk8gTNnu3YlrTPuVf8otX169VsZWk=;
 b=iMCGFrNsu8G88UbiZnAo/vGyHwcszbC2s5mRPnaG/i12VrXbjUUKJTSeAJbDb79lXy9E
 h4RuF2lXdyPqEO6hmemGN09gBL4jjLVKi/b/e+SqozMzxqMhNFGuSZtHKd7Tkrkyl0X5
 wRnb2XIY6gmhsd8EXY8H+3BW5u4SOYYCXNKaiz/gMyqTsgtus6X/c2CrH0D68WrlfJFQ
 i9PfCeqAomGhloyw71w0SxWYktjecEkOnsViDIjbR9W2aFAksE+R5l97Ybosl/BH9Wom
 r71lPpBFgl4b77y1iL2wp3JOaobuHR4VKS2X50xOpXAqXw/N0+GkRjKZMU0xuZ6cfVhQ 6Q== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com with ESMTP id 35f49mn55r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 03:26:49 +0000
Received: from G2W6310.americas.hpqcorp.net (g2w6310.austin.hp.com [16.197.64.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3425.houston.hpe.com (Postfix) with ESMTPS id 85459A8;
        Fri, 18 Dec 2020 03:26:48 +0000 (UTC)
Received: from G4W9119.americas.hpqcorp.net (2002:10d2:14d6::10d2:14d6) by
 G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 18 Dec 2020 03:26:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G4W9119.americas.hpqcorp.net (16.210.20.214) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 18 Dec 2020 03:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwmJCVsXSATnOx0baArJkRH7rH9LGCaZgbE08p2NlFeoVVR8L0FOiiZA2IvZv4Quqb86TWpc1cn8tM8zcLH19vd9EwyJZuim2Hbqm0pLYfnKOHK+txg/BDru1l0Vr/d7dAaDoLoJbOnNU+hwPlJH0pgsOzhZNjMQv5CuUPd2rMfBCjTBNUTKXLajo8XoSy8RB1e0a+v4tp+ZhW0dovr2gvShh73SPgSUyoX6tp5qGXj85YJrBZ65/gZAVpGVv6q1TgJhVB2Yyptuf+090iWsmkBKZNSoH3XU3I4zd66BLa3AED6NGkbii6E7AIOz5J1inbgudT78602msDckKJgVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0eex8cWYwLtQCtk8gTNnu3YlrTPuVf8otX169VsZWk=;
 b=b0wjjwwJh3YbJuVS+Z4tZw6ReBfuDcWU5TyvR0LWFs/4tXVWh0tHElwzFnynH8Df3cOXRx0cTrw9aSNNNAyTEQyvv2+HPFMFx8S+JfcUlQJZYCBg819GhuuUD3jZpmrOouvLQkTDZnXidec+SAcp0oXHKCFP+AxYD8eOktkIefOwsUbd+YZzDa13qhr3RdePLgLvD1s+uG1XxLc+XKBGxKgc1ndxGuextXzfmRVYdrF7uRXDzEsXKF3ahUjm0rDDHUBTOFEm/PPgSePYMdalhqRKz6R6Y/YGS4YOREANnAvUMtm/w3OKZzPcj2ENQXfneGbKmAK7S9rWFMx3uclYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::18) by CS1PR8401MB0933.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7513::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 03:26:44 +0000
Received: from CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::99f9:76a1:a58f:3162]) by CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::99f9:76a1:a58f:3162%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 03:26:44 +0000
From:   "Manikarnike, Vasuki" <vasuki-ramanujapuram.manikarnike@hpe.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: librdmacm: cleanup/reinit API?
Thread-Topic: librdmacm: cleanup/reinit API?
Thread-Index: Adag5Df1zC6SM8fbR1aRdjHCAPFj4gaXad6ABloraIA=
Date:   Fri, 18 Dec 2020 03:26:44 +0000
Message-ID: <5F2E4ED3-0391-4CB0-8774-7703FDDEDBA4@hpe.com>
References: <CS1PR8401MB0614C667E371DC6F8326CE4BD6070@CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM>
 <20201115112425.GE47002@unreal>
In-Reply-To: <20201115112425.GE47002@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.44.20121301
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [73.189.34.135]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29bed1fb-a76b-42a3-2874-08d8a304bebc
x-ms-traffictypediagnostic: CS1PR8401MB0933:
x-microsoft-antispam-prvs: <CS1PR8401MB0933962148AB505659064642D6C30@CS1PR8401MB0933.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rwb2wiguiD8p/iE6gaCxpjfjFqKf8UikSxocmJ8vDbHpKjvQXqFTv2hqDvFlfcZ3IwPDXXCL3CHnG+gpU5smBeNA4LTRqkHPoJAfUHBK/PhqEO0NjuKLjcoHwflLEqTEq/4fwmbZznscRWxefPzV1pw0zfrT2+CD5CNJNgqrHS0ph7HpE5kwou1O3gODejN//oTB89S3jMBq22Is9hkhWe4+zn9QyNkfLyX93/L1/67+FaPrKBUX2YQfSPz5q/M3/Q3d+GnEmFthre8ur/kbyOJBQYWO4lMFIgeLwwJojeAlQCIHbvY0h992/rda9S53v7pV5bl4KLtPQW0IcePAsFG5zQx9xvjYuLVmE3GTN5yNGYrPJlr/q4/hew4ckVg1ImJ5RKBkDTb5OaxTraYSEKseVVyvDvrqK3ObpjG0xaC3mzjMYzlHUMYQhRlpwTmv+svVdFH37vqoNW9c6rhv6dWQXPdmKNLPewivoMvJJk8bgG63URzW9VjUOdw/cCn1Cfq8Gkeim09pAODXcrQRxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(366004)(186003)(316002)(26005)(36756003)(33656002)(5660300002)(91956017)(4326008)(6506007)(2906002)(4744005)(64756008)(2616005)(76116006)(66476007)(66556008)(66446008)(71200400001)(83380400001)(6916009)(6486002)(86362001)(8676002)(6512007)(966005)(478600001)(8936002)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R2xVcmlUSUh1dnRoRG11QkhFQkpOM041NC9MUnkwQlNyRE5pOTl6ZjhaUXZH?=
 =?utf-8?B?UWxUeHU1QTdPZS84SE5QUjEzUVczb1NzRCtObUUvaTN0STg3N21VS0hWUWd1?=
 =?utf-8?B?YVNOcndERkJ2WHovVDFCbk84cTYrNW9ibVRUWDU4QVhVRG1Za1BHM3VMcHZi?=
 =?utf-8?B?T1I2UHlzQi9weEZGM2Juem83WERqZ25uT2t0MXh4clN3b05jRE5DY2pqRWk1?=
 =?utf-8?B?emZWd2NtOUZ5QjkrMCtEWWpFMXQwN3JFeUtsaGQ1L1N0OUY0UzUrVHhFclF4?=
 =?utf-8?B?Q0pNZ0JEbmpCbng5cGtXdDBsSkQ1VE05SXZub0JqSFZhd1lTZ2hvN29RL3J0?=
 =?utf-8?B?RjlIcWFpWmVScE1jVE1XZzkxYXFKdlRiSy80cHpxNlJUKzJaeFE0R1FkV0RU?=
 =?utf-8?B?UDNzTnpDVkx0Y0U4elp0aGNxMDRubEh1Z0NwYkZtNGttNmhYQThhak5NUmJu?=
 =?utf-8?B?UjhvSFR0aGVYQ2FyVElueHBBY2tPbmdLSExlclhuQTdEUHh5NWI4YkFmTEV0?=
 =?utf-8?B?dnpXSnBmb09Yd3pFTEZGR0lScGxScUcxNUVsTG5EYkVBVys3eVRxZURqSHVo?=
 =?utf-8?B?ZExMQTloRGp6a3dSVSt0cWFSR2FORi9UcC9pdkRRSWlQV20zVi9nR2tJZGdP?=
 =?utf-8?B?em5kYVAyak8rZEtrS09kcnh1YnNybjIycFlmUHhRc21uQUtoRk1xbmRyYmJK?=
 =?utf-8?B?QVRnMkttMHoxRXFIYUd5Z0I3bVZlcXpCMGpidERHa2pXYlU1TmhGK3IvdjRs?=
 =?utf-8?B?WFd0aTZ0VFRVU1o5cnJQTWJjZHJScGVGMVNmTU5MQ25LcnZNYjNtQUZTTVY0?=
 =?utf-8?B?QWhxRHBlaDhFZkI1SHlqNExaMmN1Tnc0alBDbWZKTWV6c3JUZkhhRzNxZHZz?=
 =?utf-8?B?RU1DejY5eVMwZmtkWnpweFdUeTlUY2dJcWg0NGpaOEE1eDZscDdNR2VPVVo2?=
 =?utf-8?B?TVR4TG9Tdzl5QTZCN2NNZ0tUaytNVEZFaEdFQ01qZFJsN1o3d1ZLeWcrbzBq?=
 =?utf-8?B?L2o3WkJCVHRhKzltWi9EMXZWbXZtT1NITUxWSXBCeEZXVHN4YjJGZ1pycE1F?=
 =?utf-8?B?UXhtZklhaU1QSy9PUW96ZHJXT2pjVUZjbnVzc1BSay91TGJUd3dJTThiVTJx?=
 =?utf-8?B?ZUp0OTQ1MUMzc2VLeEJoMWhkM2RkY1hFMnJXQ1MvNzlIUWNXcGRQanMzcytY?=
 =?utf-8?B?d0trbERDV1ByRXN0YUFuK2t0alJBMU5hRzdGWHBGMkVMOVRVN3p5aStuY1ds?=
 =?utf-8?B?R1ZDZ3hVZVgyY3UxV0RLWmF3eG5OU2hQWE9Rd0hreG51M1lFWlBKL0RncDZR?=
 =?utf-8?Q?DaWP/MtaiBIGKQYseuFnsffKAmyrkcDBsa?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <770399BB8D761747A753DAF297B17412@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0614.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bed1fb-a76b-42a3-2874-08d8a304bebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 03:26:44.6864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7YPhfex49cJvjTDj4Yeo1KnlHId0Vwh97IgOjvJNP/vltx3AmA7RuOBtifhC4v90trO/sH+CP0R0fHdoc1VHtdY+Nj5kcpBguFHwvav36D20p6W9upfkIvPOayX+ec+Ny2NIoMDMZab0WWsuc8rYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0933
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_03:2020-12-17,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180021
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

VGhhbmtzLg0KDQrvu79PbiAxMS8xNS8yMCwgMzoyNCBBTSwgIkxlb24gUm9tYW5vdnNreSIgPGxl
b25Aa2VybmVsLm9yZz4gd3JvdGU6DQoNCiAgICBPbiBNb24sIE9jdCAxMiwgMjAyMCBhdCAxMDoz
ODo1MFBNICswMDAwLCBNYW5pa2FybmlrZSwgVmFzdWtpIHdyb3RlOg0KICAgID4gSGVsbG8sDQog
ICAgPg0KICAgID4gSSBub3RpY2UgdGhhdCBsaWJyZG1hY20gZG9lcyBub3QgaGF2ZSBhIHJlaW5p
dC9kZWluaXQvY2xlYW51cCBBUEkuDQogICAgPiBJJ20gbG9va2luZyBmb3IgdWNtYV9jbGVhbnVw
KCksIHNvcnQgb2YgdGhlIG9wcG9zaXRlIG9mIHVjbWFfaW5pdCgpLg0KICAgID4NCiAgICA+IFRo
ZSBmaXJzdCBjYWxsIHRvIHJkbWFfZ2V0X2RldmljZXMoKSBmcm9tIHRoZSBhcHBsaWNhdGlvbiBj
YWxscyB1Y21hX2luaXQoKSBpZiByZXF1aXJlZC4NCiAgICA+IHVjbWFfaW5pdCgpIGJ1aWxkcyB0
aGUgIGxpc3Qgb2YgZGV2aWNlcywgYW5kIHN1YnNlcXVlbnQgbGlicmFyeSBjYWxscyB1c2UgdGhp
cyBsaXN0Lg0KICAgID4NCiAgICA+IFdlJ2QgbGlrZSB0byBpc3N1ZSBhIGZ1bGwgY2hpcCByZXNl
dCBvbiBhIE1lbGxhbm94IENYLTUgYWRhcHRlciBieSB1c2luZyB0aGUgJ21seGZ3cmVzZXQnIHRv
b2wsDQogICAgPiBhbmQgd2UnZCBsaWtlIHRvIGRvIHRoaXMgd2l0aG91dCByZXF1aXJpbmcgb3Vy
IGFwcGxpY2F0aW9uIHRvIGJlIHJlc3RhcnRlZC4NCg0KICAgIEl0IGlzIHN1cHBvcnRlZCB3aXRo
IHRoaXMgYWxyZWFkeSBtZXJnZWQgUFIuDQogICAgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJk
bWEvcmRtYS1jb3JlL3B1bGwvNzUwDQoNCiAgICBUaGFua3MNCg0K
