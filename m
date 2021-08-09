Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634A13E46CB
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 15:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhHINjR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 09:39:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38450 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhHINjR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Aug 2021 09:39:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179Db0BH006536;
        Mon, 9 Aug 2021 13:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nX9zL5gaFViqaDD98OH3jik1SbD50j9ggag09d1UCto=;
 b=UTgDjvMzFkDJi1cLuQvU6QkCdU2n3OSDUHqpCTUELzi2H/onmU4KBBvrvlS+i0Yh/GVb
 pP90IS0ZwElnXdbTHRxRTAp+t7WSbCqddN7eiPQIdBdMFH8pIyc6UTgLKmL06TLIMKun
 W1reLxhuBiCodWcBT9lKGQkuQ4q5UNYOYArSj1zdNalpBLLv9hfW9EXtLUiKyc11XbgA
 6p++Vlkf/NSXCJDpQJdamHLhqJde2pCIyXD8Je2G71EH+4LNK1CMAp4/2rinQFCjds0W
 VOmO9mnG6TPGPc8yK+pIiRJ77bp1yl+JI0OnahYZ5AKwOEsmeMTwvORfRhCBJ3Lqfm9h 8A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nX9zL5gaFViqaDD98OH3jik1SbD50j9ggag09d1UCto=;
 b=p5iu2Q5c7AKomp+eoKyzpsL01qMy9/9kLdenv8+BSn1O4Po7UrGvjQqeA4eITNtzZDZD
 X0pQ4o6zegSd0bixkovlrX4TGrCvODbFstRmfIz5sTr7UFaxeaHQdoUZYIq9zd8sYcFG
 TJYnW9KIsrEz2EcHJuepoQVnikwmt9x4rpoM4SM+cyMMW6ESt+hGmQgq3lNQha9Ee4Ob
 Zlzrgb39XhpTuqXRNCOwLhFWrLVSoMOVbxTI9nXP89o1OaAY1z72kFlI9WYgv3TtV10Q
 c57AVfcQoRFcXqlO0WMpnM9i5z34ifBMgj7k+kog9qNNIL3bX1rMmE3xtOOexfwJhMnK 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aaqmusa5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 13:38:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179DU46E077209;
        Mon, 9 Aug 2021 13:38:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by userp3030.oracle.com with ESMTP id 3a9f9v2eaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 13:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7nW5AeIPFhuJWr4ih+dWZZLownMVPP6JeucEbfIBr2RgGuTCPi3tbbijRaApxkiQhkPBYgp8RrSsJo9mOg2cKo2+yNxTeWSpY9N8BWfEKovV4d5JPDgp9iadbAoWgXuCpxAIwikoavjfrhNYqB09JzW3dAW65jse7iy0eDLTSoccP6oRxo1VwI5C1i6psjYPrA8rNMFD2G8wzeKZVnr1mgykBCP55OmaxdOWbbxb189Ni1DpBhRYPapzSMW4EIgvqB5jZF+MXO1fgQ/4Sqch2B66dL7yh9cmkYFuTcmD1KYPZZrB7y8oHzxCW2cnrJIH7qrhgelYNEYMBKXEkkXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX9zL5gaFViqaDD98OH3jik1SbD50j9ggag09d1UCto=;
 b=NBHLQsA3YPssvp6wlyBG1tRtUPY4xe9zPaoVzLmvc+91Dh7x/uCSkfZuW65eNx4wxoAHu/Ermq+XXKCI+xuKGTN4M2mEVI0vMwo/CfNNMQGPZCti9zYHSBobiwP1aNpbtuKJVzzBgcYB4pfVfP0OuMdBQHVZo/BoszAiqlNtzKlIBi+W2jUQzLVr2Ou09cN/pz4UEIcFhL8TVUaRexEYSkcnvmc6Q6XExEkBbFP/ez+KhAmXwYn0lRN1RQhlRwCrfvGoMDtrkd5lrWxDylGLeeqefN80bbzlnPTQv3BtGlGnW7lhWLUAL/zizlokMIE4SVNNnROzFGnjkAXah3y9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX9zL5gaFViqaDD98OH3jik1SbD50j9ggag09d1UCto=;
 b=NvKGdz0ic4QtyE3KhiDjnTXR2ju9sM0qzQWocFvV2icubF6k+0vNI1+0Eb4sv75Mau/qXq4Zk1Ucq+fB/P3GXe7o37v9vHbLiAPhNy//T6IDjp454lB/vW+ytjCVPgXSFIbEkatIFT8NVzYyBco7QAcn/WDYkworMp/V0chWYYM=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DS7PR10MB4831.namprd10.prod.outlook.com (2603:10b6:5:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Mon, 9 Aug
 2021 13:38:47 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::496:2301:77d9:de82%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 13:38:47 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: NFS RDMA test failure as of 5.14-rc1
Thread-Topic: NFS RDMA test failure as of 5.14-rc1
Thread-Index: AdeC6xneRTsXNTlrTWuqxyNIUrjEqgAOO93QACMdPeAACJMjAAA1KQDwAh8caQA=
Date:   Mon, 9 Aug 2021 13:38:47 +0000
Message-ID: <A3297641-63BA-4DF1-886A-3620E2A40BA3@oracle.com>
References: <CH0PR01MB7153D5381BBC3D1D0F146E8AF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB715358BA093A504AED855CCBF2E99@CH0PR01MB7153.prod.exchangelabs.com>
 <CH0PR01MB71535949BACC7C43261EDAD2F2EA9@CH0PR01MB7153.prod.exchangelabs.com>
 <20210728170540.GA2316423@nvidia.com>
 <CH0PR01MB7153AC0E62FCE1E9C4C82AD6F2EB9@CH0PR01MB7153.prod.exchangelabs.com>
In-Reply-To: <CH0PR01MB7153AC0E62FCE1E9C4C82AD6F2EB9@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c15341c-b658-47bf-5046-08d95b3b03fb
x-ms-traffictypediagnostic: DS7PR10MB4831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR10MB48317B4F08F68D03287FF0B4FDF69@DS7PR10MB4831.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m6z0WFB5nuDNgYsghj/MvjRdvDIioNM/e7o7u7sgj+X2Qv6TNBBfvZ6Q1T0py7bBIZsTQev0A88/yB+Ia4B/LOYjQzg8x8QR/Q/BP4M0IfOZMoCqhEAXFICCoylXTg3djVS9/dIFG90/SWIU8QobTIbo9A6SRupuLDqiSE5n1BaYmKoQkHzptAGWOANO5BhsG4HLZhJz7PG6JLLtU3wBwT2RN4P2v24iqZutO/6oORRdomfNGsxmLYR1t/WnaKw/wAxgdUcVQPAMTiazeKRWpJPuuZjpZIRFNiwzMYoKGf3CVGrzaXSgT6CCkIm4y9aEZZPjxY0ri6siJy9G0iE/Uj4NtRPdXq82bbPcEnQBWaatQWrv6OmXNv97zRTSzky2TJGyDLpZy8S+nqx5WBKZs6AMfR6MyRCcjpTAutMKkMlIReU9YhjH2Pq2b4AWBfhQRDJVszpdZJXfx12zOTppPsQOlJfOQ3RT8hhKPQcMpGVm8tS4jFaq8ALHbjPE2a5hxJwjZIDswB5gWbZVfHrKvHgWo3PCTNPehh8WvB3jWSj8y0bdXpL9gGRSBmX7702vhs4bbadDGAYAeT9fHGu0vp7ub07IhuubTaqBR/BXxVBzTSgvo1KrCZQUsrB5EUt7mzfdqRSWwwy8ESVadgdZJHOr0Gjn1ord8NQc7RPCDq1KqKO+6nOpOEhJzA3FllL2n1zUpINU5s4kF/Y+9M4k/WMLI3a33u0+sl97svj4/cJBPhfnEyQBFwjptzSL3RipkUZeFYywjePjApMBFhMeGfG0V4pBWDkCWjqihfGNHZwVZ6ISZ/+c/jv2UyKjSW5fjqGXek7Flv2bY457I8BL9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6916009)(36756003)(8676002)(966005)(71200400001)(66574015)(6486002)(6512007)(38070700005)(2616005)(33656002)(44832011)(4326008)(6506007)(53546011)(186003)(91956017)(66446008)(2906002)(76116006)(26005)(66556008)(66946007)(66476007)(64756008)(122000001)(38100700002)(8936002)(54906003)(5660300002)(508600001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZWbWo1SjRqOTM1VHlqcTZNMDFsWHFIM2RHdFJONkJOQnVsU01QTGhYRE1W?=
 =?utf-8?B?RmNncWt1ODI3Yk5NZ0lNSnk1VXVrMitTeFF2aDJ4a1AwRDJzMlFIY0xBdWFO?=
 =?utf-8?B?STVWTU1sYUlpNnBDSDhlTExQUmJQYU92YTAvK0tyM3JPdjlpSDFjNkFNeVlO?=
 =?utf-8?B?YWkyZkdheDg2RUkrTHA3bEFGVmgyUGwwekY2QmpxY0g0ODR1QS82VDBHWUVJ?=
 =?utf-8?B?Nk9yMDFIWGZZZXlsbmpTZTVHUkV4bHo4SlFqWVkyVDJyNFh3ZDAyRm1HNUs5?=
 =?utf-8?B?MzgxNGp0OGZlM0JYcnkzekZCRkU1Y2p3RWdMTUJSbnpNbW5lTGtvNmQ3OTRz?=
 =?utf-8?B?MEVVTjNuaHZVbEtsdnRhZ3pqdmlKTnkvMVRBcUVwSE91YjQwRnI5NFFHU2dr?=
 =?utf-8?B?Znpwc1REUk92MS9JcExBTEZhSUFKKzU5Ly80RlNWVS9LOWlwNEFzTVgwbURO?=
 =?utf-8?B?WWlQNU9BMTR3dmJVVGw0dUxpL0xkcnBTOHYvcExRNWpQNzdpcWFZZ25FdGhi?=
 =?utf-8?B?YWo2MDRiYy9OOWlNMkowR21mSWg5YzEramYvMmE4cy91c0gxZmMxdk5iMlBz?=
 =?utf-8?B?eDMyajFaY3g0ZVlwdGlEdk1CSGk1UktFaFdudVNhNUpWcU1FcHpEK0ZWOTk4?=
 =?utf-8?B?ZGhJdHB6VHRkUWdzbXRWSWdGZTcyS3V4VnYrTjFiUlBaRmhxUGt6SW14dFN5?=
 =?utf-8?B?Z0xYSWdER0lEZFBNVm56YzR5NWd2dEg3M1ZKWFArTmMwSjRYUHByVmpNc3FP?=
 =?utf-8?B?blV5RFZsbXdHdy96M0pwZ0lBa3B5TzBSUXVKbEZCZFpJUmF6d2V4cmZsV0dh?=
 =?utf-8?B?dUpsWDhHWlZMNGhrVWgxcmhoS3lIL1lyam53NnVFdGpaOEVGMGJrNnBmYlpq?=
 =?utf-8?B?bHhQRldLVEJLdklEeXJTd2NUcWkxUHQwSnEvbWhFM1B5RXc1dGczejFqd2RR?=
 =?utf-8?B?QUpEUmxVcWN2a2s3eUhxSURVcXhwM0Uwdk9Sd1I2V0RLS2p2ZEtUZmRPdjAx?=
 =?utf-8?B?RzZtTmkvZDdTTkpSRlZPK0ZQTmNTNmE4NHJKbXBUbG5zcE1ROVBSbWprSWZM?=
 =?utf-8?B?U2g3VWdXVklCakszNGtNSEFWeWRFUXRQOGVyc09SUlVVNWFUMEVMVGZKOCtj?=
 =?utf-8?B?Z0J3OVR5cEVkbG5GK3htQVBUbVJIQ0w2SnlZdVl2T1dOb2lHNytZZXdqd2hK?=
 =?utf-8?B?RjdSY1Z1Rjd1WXNPYmdDWE5hamdMSDh1czcvYkFXQkZ2VHRCMDE2NDhTYUZQ?=
 =?utf-8?B?c3FpSWZrV1pkaTR5T0FqSGZWdGZRc1poUnVmOUZjaGY0OTlqcVI1dkhucTV4?=
 =?utf-8?B?RjgwWEcrMWpiNEw0OEFXUDdzL2N5MjRCTmR5eGI5aUVRSllwLzFybE44Q0dV?=
 =?utf-8?B?MG1wejlyc3J0L3N1aUI5MWt6S1RheTl2a3VKQVVzMjJoejQ0bXkvdmx0Tlla?=
 =?utf-8?B?bEkxTndVZVJvQ2xvVGp4TkptNUFKWnd3YVlIN1owNjBYYVI3aUkyVzRBUzBB?=
 =?utf-8?B?bXI4Q0YwbTFiTnA5OXp1NmRBMG43WXlOek1CcDJJbURNcFdBS2RTZVhCMFYy?=
 =?utf-8?B?YVd2ZC93VVEyUlRJUmNLYmpPNzRMQm9FTFB6bGExajUrOUQ0V085U3E1UGFP?=
 =?utf-8?B?OFdMUFVBRk8yRHVLK0xKekEzT20yREN3d0tOaU5Vc2QvTjA3Z0RqUEphYjJU?=
 =?utf-8?B?QlpxSzhIc1RFUVF3SjdWRlFqVEV6L2pydUJvWFg4SXhhOWVWd1hXckFSblNE?=
 =?utf-8?B?d1NFVFYzMW9qdmJ2cVlFaERsaHo3MU9BQ0tZbmhYTE5IbTQxcm9EQTBTZmN4?=
 =?utf-8?B?VGJMaDJxeVJBU2xicSs0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFF8AAE2E10F064D86F449CD5EAA9A62@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c15341c-b658-47bf-5046-08d95b3b03fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 13:38:47.6998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eacZM20pi3R13okwRbmcCenIMYgVPYlQ8o++mAKgF45kcNcgcC/vjuoSqfAPngQ3Qq+6HV2KaGmxo9p5DkHJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4831
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090101
X-Proofpoint-GUID: G_VK0uZkG1DdU0wVzbyLg2V9dHitJjs4
X-Proofpoint-ORIG-GUID: G_VK0uZkG1DdU0wVzbyLg2V9dHitJjs4
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjkgSnVsIDIwMjEsIGF0IDIwOjI4LCBNYXJjaW5pc3p5biwgTWlrZSA8bWlrZS5t
YXJjaW5pc3p5bkBjb3JuZWxpc25ldHdvcmtzLmNvbT4gd3JvdGU6DQo+IA0KPj4+IEEgdGVzdCBv
ZiA1LjE1LXJjMyArIGEgcmV2ZXJ0IHRlc3RlZCBjbGVhbi4NCj4+PiANCj4+PiBKYXNvbiwgZG8g
eW91IG5lZWQgYSBwYXRjaCB0byByZXZlcnQgb3Igc2hvdWxkIEkgc2VuZCBvbmUuDQo+PiANCj4+
IFBsZWFzZSwgSSB3b3VsZCBsaWtlIHRvIGhlYXIgZnJvbSBIYWFrb24gYXMgd2VsbA0KPj4gDQo+
IFRoZSByZXZlcnQgaXMgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmRtYS8xNjI3NTgz
MTgyLTgxMzMwLTEtZ2l0LXNlbmQtZW1haWwtbWlrZS5tYXJjaW5pc3p5bkBjb3JuZWxpc25ldHdv
cmtzLmNvbS9ULyN1Lg0KDQpIaSBNaWtlL0NodWNrL0phc29uL0xlb24sDQoNCg0KVGhhbmtzIHNv
IG11Y2ggZm9yIGZpbGxpbmcgaW4gZm9yIG1lIHdoaWxlIEkgd2FzIG9uIHZhY2F0aW9uLg0KDQpT
aG9ydCB0ZXJtIEkgYWdyZWUgb24gdGhlIHJldmVydC4gQnV0IEkgYWN0dWFsbHkgdGhpbmsgY29t
bWl0IGRjNzBmN2MzZWQzNCAoIlJETUEvY21hOiBSZW1vdmUgdW5uZWNlc3NhcnkgSU5JVC0+SU5J
VCB0cmFuc2l0aW9uIikgaXMgY29ycmVjdGluZyBhbiBlcnJvbmVvdXMgYmVoYXZpb3VyIGluIHRo
ZSBDTUEuIEJ1dCBpdCBuZWVkcyBtb3JlLg0KDQoxLiBBbiBBUEkgdGhhdCBoYXMgYSBjYWxsIHRo
YXQgaGFzIHRvIGJlIG1hZGUgdHdpY2UgKG1vZGlmeV9xcCAtLT4gSU5JVCkgaXMgZWl0aGVyIGlu
Y29ycmVjdGx5IGRlc2lnbmVkIG9yIGluY29ycmVjdGx5IHVzZWQgSU1ITy4NCg0KMi4gSUJUQSBp
cyBxdWl0ZSBjbGVhciwgdGhhdCB0aGUgdHJhbnNpdGlvbiB0byBJbml0aWFsaXplZCBzaGFsbCBo
YXBwZW4gb24gdGhlIEFjdGl2ZSBzaWRlIHdoZW4gYSBSRVEgaXMgc2VudCAoc2VjdGlvbiAxMi45
LjcuMSBBQ1RJVkUgU1RBVEVTKSBhbmQgdGhlIENNIHN0YXRlIHRyYW5zaXRpb25zIHRvIHRoZSAi
UkVRIFNlbnQiIHN0YXRlLiBTaW1pbGFyIG9uIHRoZSBQYXNzaXZlIHNpZGUsIHRoZSB0cmFuc2l0
aW9uIHRvIEluaXRpYWxpemVkIHNoYWxsIGhhcHBlbiB3aGVuIHlvdSBhcmUgaW4gdGhlIENNQSBM
SVNURU4gc3RhdGUgYW5kIHlvdSByZWNlaXZlIGEgUkVRIGFuZCB0aGUgQ00gc3RhdGUgaXMgdHJh
bnNpdGlvbmVkIHRvICJSRVEgUmN2ZCIgc3RhdGUgKHNlY3Rpb24gMTIuOS43LjIgUEFTU0lWRSBT
VEFURVMpLg0KDQozLiBQZXJmb3JtYW5jZS13aXNlLCB0aGUgV1IgcG9zdGluZyBfYmVmb3JlXyBz
ZW5kaW5nIGEgUkVRIGlzIHNlbnQgb24gdGhlIEFjdGl2ZSBzaWRlIChyZG1hX2Nvbm5lY3QoKSkg
b3IgYmVmb3JlIGNhbGxpbmcgcmRtYV9saXN0ZW4oKSBvbiB0aGUgcGFzc2l2ZSBzaWRlLCBwcm9s
b25ncyB0aGUgdGltZSBiZWZvcmUgc2FpZCBSRVEgaXMgc2VudCBvciB0aGUgc2VydmVyIGlzIHJl
YWR5IHRvIGFjY2VwdC4gRG9pbmcgdGhlIFdSIHBvc3RpbmcgYXMgZGVwaWN0ZWQgYnkgSUJUQSBh
Ym92ZSwgdGhlIHRpbWUgc3BlbnQgZmlsbGluZyB0aGUgcmVjdiBxdWV1ZXMgYXJlIGhpZGRlbiBi
ZWNhdXNlIHdlJ3JlIHdhaXRpbmcgZm9yIGEgY29tbXVuaWNhdGlvbiByZXNwb25zZSBhbnl3YXku
IE5vdCBzYXlpbmcgdGhpcyBpcyBwcm9ub3VuY2VkLCBidXQgd29ydGggdG8gbWVudGlvbi4NCg0K
VGhlIHByb2JsZW0gaGVyZSBzZWVtcyB0byBiZSwgQ01BIGRvZXMgaW5jb3JyZWN0bHkgcmV0dXJu
IGEgUVAgaW4gdGhlIElOSVQgc3RhdGUgYWZ0ZXIgcmRtYV9jcmVhdGVfcXAoKSBhbmQgc29tZSBV
TFBzIHRha2UgYWR2YW50YWdlIG9mIGl0LCBpdCBkb2VzIG5vdCB0cmFuc2l0aW9uIHRoZSBRUCB0
byBJTklUIHN0YXRlIHdoZW4gUkVRIGlzIHNlbnQgb3IgcmVjZWl2ZWQgYXMgcGVyIElCVEEsIGJ1
dCBoYXMgdGhlIChzZWNvbmQpIHRyYW5zaXRpb24gdG8gSU5JVCBqdXN0IGJlZm9yZSB0aGUgdHJh
bnNpdGlvbiB0byBSVFIuDQoNClNob3VsZCB0aGlzIGJlIGNoYW5nZWQgc3VjaCB0aGF0IHRoZSBR
UCBpcyB0cmFuc2l0aW9uZWQgdG8gdGhlIElOSVQgc3RhdGUgZHVyaW5nIHJkbWFfY29ubmVjdCgp
IGFuZCByZG1hX2FjY2VwdCgpPyBBZnRlciB0aGUgcmVzcGVjdGl2ZSBjYWxscywgdGhlIFVMUCBp
cyBhbGxvd2VkIHRvIHBvc3QgcmVjdnMuIFRoaXMgYWxzbyBhbGlnbnMgbmljZWx5IHdpdGggdGhl
IHVzZSBvZiByZG1hX3NldF9hY2tfdGltZW91dCgpIGFuZCByZG1hX3NldF9taW5fcm5yX3RpbWVy
KCkuDQoNCg0KVGh4cywgSMOla29uDQoNCg==
