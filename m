Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BB1414559
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 11:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhIVJkd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 05:40:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37100 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234434AbhIVJkU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 05:40:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M8T4Hn013122;
        Wed, 22 Sep 2021 09:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bf+53Or7deMwau7ErjTaIZLRPhUG9jnpdU0MUO98pzo=;
 b=mp5X7l97FKjrcZYh5WfQAZHPTL49QqHMqx4wfrHTHXmsjBfGvXHn6IoiQ69855m0nyv4
 oEEdqh85YRhLB+N70NcBeCHxKZZzo5XRXqEAtxYEYBcLsbtk3GNTbq4zieON9/gYcWhk
 QJL4WJKzp5U/A3IyQOi4Eej+Hzp3XqlbyAvdOJst9K4jbxv0/IfpXyJOlXHms9yUomCg
 Z49U2pupIiOEzV3Z1nZ4jsNXocO2uebSzC5XimJr3APkI32dqWycurMqmtQrOLCyp+m2
 56Eb1sOFQ49Iy8Xbn5HsnpQ0Y+Kp7W2z/8rdy68BphqwIICWiiJujlac+3BYUJV67BH8 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4qjnq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 09:38:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18M9U3wn058561;
        Wed, 22 Sep 2021 09:38:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3020.oracle.com with ESMTP id 3b7q5vxpbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 09:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0pfGqCEIGr5u2kVAOWIhjNVuQscFTlgod6OpmX7ZR5DJTtMHHYCw8U5NcGM5OVBtz1XdxpoEgusd5dW1Zk2ub+Si1AeDx/rh2UpQ5xI8xgIBHjA20bG/l3ntZw4fMDsxZ7RXMNt8HFcm9MTTX/EhbwLxuuIg/Ss/h1bQ2H3EDKXTHLEZHXtyAzEg00uV95d3U5FFCkZfMRoXDl4pilTQJqndIimuztWgrBfhL6rzTlSsv/p2rlp7L6Ozk1REGBkPEsLp4wBRY3EyAzErK8Q0SmHzcfII0/4DJE6c+dwO6uYvhG429RC76fuXn5KWSV0Xn1eu11Qhp/SuBeAtp70/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bf+53Or7deMwau7ErjTaIZLRPhUG9jnpdU0MUO98pzo=;
 b=FhTpr7mreY0y2MoUIG6Ij14QCAnXrknfHysK6tgqp16Gutf6Ac8h8kcuCGMZgRBIo4BSWZd/oPfx/V6HL/QB8AilGY87TCSXUKpfaaJgOQ8x63cX+Iux7RHI+MLNQDYssLPyNkY2drF4wJnh3GYt2elW3RRW0YHAWnq16bOq8sbmUgbVXaYCS5DEXXsfleNj9nAadhGbP6dNQh2hSRxVXat6iS1HLscfvSq/5QjoDO4a5SO99NHWRQCWm9ogmt/wc9mRmeUecviU/QugRWutm0sZySP5LfinQ8+oK+88LxKxH1sa9gCG8hY5Rh8vRHBhn09ttS3I5WCFa1KmwBI2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf+53Or7deMwau7ErjTaIZLRPhUG9jnpdU0MUO98pzo=;
 b=MoOm/gZ7ynynxADMUAMA2oms1e46MGlR5i//tNbmmPAb0f1MZRaVSoXRTySTPZhyZcUutBaHvXD3QIwPD5anfONEyvHXHbNOr4zQgCJgQc0drymXzSd+AWJX+mFzBz1EgjOCYsYCQzrbjbgL0uBG0XPHOhZqcLvN6jNZYBhSLEQ=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB1513.namprd10.prod.outlook.com (2603:10b6:3:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 09:38:40 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::847d:80e0:a298:6489%9]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 09:38:40 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com" 
        <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Thread-Topic: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Thread-Index: AQHXqymRdLoJowIKwkaomXCgdS/EzquvudGAgAAbGwA=
Date:   Wed, 22 Sep 2021 09:38:40 +0000
Message-ID: <27C1E678-2EC4-4916-9720-00C1B69EA5AA@oracle.com>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
In-Reply-To: <YUri44sX8Lp3muc4@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68617345-3dab-449a-cf3d-08d97dacc2fb
x-ms-traffictypediagnostic: DM5PR10MB1513:
x-microsoft-antispam-prvs: <DM5PR10MB15138D8C3AD960759C57D065FDA29@DM5PR10MB1513.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iolePd1nUCCgI8eyMOJSCKai1HgaT/bvIf5MbzmOwbjgvH2lzH6EI0oNJQQwHohOcBcfRZ2d7XKtFNZkcBhY3HIn5iz2ozkrEEPq43F6d/pIISAB6wWQRJY1O7BjgrDZAzIPLr0OqtozI4gbhCCELBMu7FJnAUvtMMPRJviLo+SYfJsdaLBtsdt85eR6c3XBIjRLZDrmxVn3UxIm/0UHfAsidqzGhWfv8VyaPDFxIC7zNY/YK9BgSGiO8FQ+KBt0WWpOquYpmPzpJgBOvoa+0BY0l+K8rUifzdgOmiqTUVRzD9iGaR92CdeVtUQalQU47AxhSXsNId785knTEUUvVx9IdLzY+rGiSmJsmLQGW1RQ6RJyRGhcBYJpNan/9YBGMZWVC8HJiJD3nBKva/GmlGXTfJKAbSdwqUevzPx288F7kIguThh5YlDFhjs2bpHvKTa25UrZphPxzhYNovZiw5ZFNygGe98SHHonecGEavtfUg+4ZHaeRfpFyCDPk3uPRk8Dg4fzuc3rr44M9oxQXb4lxxLxM6l76pzuxzt0gCOtO1KTJLeOdKxpmQBUwhym/OBVmumL3x3Klvb3EhWM1ALImG/0MlU8VfaQE3J1EZl1bsCGaYPQ9dC6taa1xVJgA5xNTF40HpVdPcXCjiPHfeyB5yJXk1jN0i+lkFY81nW/RwuJVJHGVP4hwfcqwpHTlfAF+cjdNAo9J39tZn4nDM6ROODuP0ZNT3MDbXpWVwVBeuUhEURlbcaNXnj0WEps
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6512007)(36756003)(53546011)(508600001)(316002)(8676002)(54906003)(5660300002)(38070700005)(186003)(71200400001)(66476007)(8936002)(66446008)(66556008)(33656002)(6506007)(83380400001)(91956017)(2906002)(38100700002)(76116006)(66946007)(66574015)(6916009)(86362001)(4326008)(44832011)(2616005)(64756008)(122000001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnRkZVp1Rk04RG9qcTZCRXhaanhmNFZpRXUvdFc5ZDd3aUw2YmFUTEZMNHBM?=
 =?utf-8?B?M2hkWVVpeis2WTRMYUI5Q2dmZGhKa0E0QzBwOXloNVhSMEo4KzdHcVpWUjZQ?=
 =?utf-8?B?K0dTZlNqQWpyWSt0c29xQXV6Rk5LTDRSYjRWMzRoaHZGKzNSeVRQcEZpYUN1?=
 =?utf-8?B?TzFNUGNqYllYZ1JTQlArUWpQUk14OEp0czVlamMzVmxybk5mNXRzZVhDUU5F?=
 =?utf-8?B?bHZzUWYxQmt2T1hGdVd3NEw1S0ZkZ2U1NEQ3b1JZc2FmQnk5R2dKaUo1cmY2?=
 =?utf-8?B?VkRmYmdXV0JzZmVQL3ZpNzRjWXRxaDRCTlNlRkIzNkVIc3NjWXU3MjcydW84?=
 =?utf-8?B?K0hCTkU0c1cyblVNeVZiWEJyc0Y4b2dOZzA4dTNCQ3YyZjhSZms5OEc0a1JP?=
 =?utf-8?B?dm1sK3o1MW5xa3V6bHgwYnQwV3pWb2VyeVVld1ZRMjl2Ri9OODdqUWJvSTBu?=
 =?utf-8?B?dE5aM2VPVzZqN0lockJER01zOEV0YTNrc1JVRjJSYkZiNVdodVZZbGxoL0Ni?=
 =?utf-8?B?MnArQWdZNktGQmJuNHpBV0NTbXNSd3hJTmc0VHNTRTNxdExiWXZOL2wzZVhn?=
 =?utf-8?B?UmRmRnMzcVMvSCtBUENkWDJIN1JweEJEYWNKWjdIUXd0RUZDams0amxZYWZJ?=
 =?utf-8?B?NjJ0RFJGTEtyVmpSTGs2RGtEeXlIdG5MYnY2V0dQYi83OFhhRkYxb2VIZVlz?=
 =?utf-8?B?UnBFMFBVZDV6ZnpDbThESXRrNXpWRWsvckxDTGNPeHl4cWNKd1liS0JZcXFF?=
 =?utf-8?B?Q3N1dWFOdkNET1p1NnJGRXJpMWFrL0tNcHN5d1dPZVhTNUozNnZ6NnhZbzZh?=
 =?utf-8?B?T2t3MUlUQVpoTmZ2cWdZNHczZTYxSjhTOEtuUVN5Z2pydjlFYXJIQU9SdFkv?=
 =?utf-8?B?MGRQWTAvNEZ4WDA1WnJOTURiTUVTWDA0M21RdVJNeXh4YUxwSEJXYkdybXJF?=
 =?utf-8?B?Z2xuenN4aHkrQ1I1NUxSZCtZaWs0emlIVjZIcEtWcllqT3QydlpHcjMwR3E5?=
 =?utf-8?B?aU1qZzhubWQxNjhiTWF5OGo5WlR4cHk1OENpWjluMkU1SzNvUnB2VmY0SlFF?=
 =?utf-8?B?RGJMOVplREZpSWVCekZZeHMxcDNBd2prNU0yQlgrMlVJL2Z5ekhPNndFbWpV?=
 =?utf-8?B?MURmaldxV2I5eTBvMDVVaXdLaVk4M0RMVTlEQ0pyT1pMSWdab0ZNNWhLUDZ5?=
 =?utf-8?B?eXAyRHMxcjR2TjRJa0VETG5VVHk3UzFsWThadngrOFZvN1lCSFdGek9IcEpF?=
 =?utf-8?B?dkZpVDluNktRUUJoNUJIWkg3cTBMc3VSalJ0bjdxbktlN3pFYzJMeWRHVU9o?=
 =?utf-8?B?d0JkU0pMS2c0akdJZjhFYW9lTDhxRzZia2prVGNiR0VsbkZuTmxiR2Y2ZlFU?=
 =?utf-8?B?R1JOMkQ3MTV1bGV1ZHhlOEdIckJzSmlsUVl6Sm81d1lZbVRLKzJBSGVaY0xw?=
 =?utf-8?B?aVVnTnViY1FNZDBZTEFtUHdBcEYyOEtyUitYWE1HV0lZSGIwU0ZRU01TdElw?=
 =?utf-8?B?TTVSTWN5U1AzQmRFMDlmaDRuNWdTRk9RdHZMOFgzVi9rTEFzRWRoc1JFcllp?=
 =?utf-8?B?VWh2elk0ZmlBVTRuSG9mOEJPR3JBVzAycjR2bkluenRrWVB6Yk1kcTIzSGNa?=
 =?utf-8?B?N20xMnIrWVU1YmMyZ2hZOVNKcUw0UXBSR2t2NXUvVThSMWtFbkQ1dXNEQ2E4?=
 =?utf-8?B?VWZ0aUczeFFJUGgzREIvSHozaW1iUFJQM1Jmc3puK201YnIyRVRzeXBzbzZj?=
 =?utf-8?B?YVdWV0d0NUtPK25pbS9hdXI3Z0lIdit5anBOellOUVdaN3hDbk9SdHhZb3hG?=
 =?utf-8?B?WTYzcmdmL2hMV3VFdlNwUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <57FF39831E9F994383AB52853DBAB5BB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68617345-3dab-449a-cf3d-08d97dacc2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 09:38:40.7421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fXzsOSOTT6JLeMMOt05NOaH0s71R/Ic7h47FWxmqsB0vhUwwgwwtDKWiM5+b1GU9zxlEEA6gbqmPNyyOqp0JlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220066
X-Proofpoint-ORIG-GUID: PbbB3k2gKMEpiaslUetVbOgvKJHRZ4Kc
X-Proofpoint-GUID: PbbB3k2gKMEpiaslUetVbOgvKJHRZ4Kc
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMjIgU2VwIDIwMjEsIGF0IDEwOjAxLCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIFNlcCAxNiwgMjAyMSBhdCAwMzozNDo0NlBN
IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBUaGUgRlNNIGNhbiBydW4gaW4gYSBj
aXJjbGUgYWxsb3dpbmcgcmRtYV9yZXNvbHZlX2lwKCkgdG8gYmUgY2FsbGVkIHR3aWNlDQo+PiBv
biB0aGUgc2FtZSBpZF9wcml2LiBXaGlsZSB0aGlzIGNhbm5vdCBoYXBwZW4gd2l0aG91dCBnb2lu
ZyB0aHJvdWdoIHRoZQ0KPj4gd29yaywgaXQgdmlvbGF0ZXMgdGhlIGludmFyaWFudCB0aGF0IHRo
ZSBzYW1lIGFkZHJlc3MgcmVzb2x1dGlvbg0KPj4gYmFja2dyb3VuZCByZXF1ZXN0IGNhbm5vdCBi
ZSBhY3RpdmUgdHdpY2UuDQo+PiANCj4+ICAgICAgIENQVSAxICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIENQVSAyDQo+PiANCj4+IHJkbWFfcmVzb2x2ZV9hZGRyKCk6DQo+PiAgUkRN
QV9DTV9JRExFIC0+IFJETUFfQ01fQUREUl9RVUVSWQ0KPj4gIHJkbWFfcmVzb2x2ZV9pcChhZGRy
X2hhbmRsZXIpICAjMQ0KPj4gDQo+PiAJCQkgcHJvY2Vzc19vbmVfcmVxKCk6IGZvciAjMQ0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHJfaGFuZGxlcigpOg0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUkRNQV9DTV9BRERSX1FVRVJZIC0+IFJETUFfQ01fQUREUl9CT1VORA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZpZF9wcml2LT5oYW5k
bGVyX211dGV4KTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFsuLiBoYW5kbGVyIHN0
aWxsIHJ1bm5pbmcgLi5dDQo+PiANCj4+IHJkbWFfcmVzb2x2ZV9hZGRyKCk6DQo+PiAgUkRNQV9D
TV9BRERSX0JPVU5EIC0+IFJETUFfQ01fQUREUl9RVUVSWQ0KPj4gIHJkbWFfcmVzb2x2ZV9pcChh
ZGRyX2hhbmRsZXIpDQo+PiAgICAhISB0d28gcmVxdWVzdHMgYXJlIG5vdyBvbiB0aGUgcmVxX2xp
c3QNCj4+IA0KPj4gcmRtYV9kZXN0cm95X2lkKCk6DQo+PiBkZXN0cm95X2lkX2hhbmRsZXJfdW5s
b2NrKCk6DQo+PiAgX2Rlc3Ryb3lfaWQoKToNCj4+ICAgY21hX2NhbmNlbF9vcGVyYXRpb24oKToN
Cj4+ICAgIHJkbWFfYWRkcl9jYW5jZWwoKQ0KPj4gDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgLy8gcHJvY2Vzc19vbmVfcmVxKCkgc2VsZiByZW1vdmVzIGl0DQo+PiAJCSAgICAgICAgICBz
cGluX2xvY2tfYmgoJmxvY2spOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBjYW5jZWxf
ZGVsYXllZF93b3JrKCZyZXEtPndvcmspOw0KPj4gCSAgICAgICAgICAgICAgICAgICBpZiAoIWxp
c3RfZW1wdHkoJnJlcS0+bGlzdCkpID09IHRydWUNCj4+IA0KPj4gICAgICAhIHJkbWFfYWRkcl9j
YW5jZWwoKSByZXR1cm5zIGFmdGVyIHByb2Nlc3Nfb25fcmVxICMxIGlzIGRvbmUNCj4+IA0KPj4g
ICBrZnJlZShpZF9wcml2KQ0KPj4gDQo+PiAJCQkgcHJvY2Vzc19vbmVfcmVxKCk6IGZvciAjMg0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHJfaGFuZGxlcigpOg0KPj4gCSAgICAgICAg
ICAgICAgICAgICAgbXV0ZXhfbG9jaygmaWRfcHJpdi0+aGFuZGxlcl9tdXRleCk7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAhISBVc2UgYWZ0ZXIgZnJlZSBvbiBpZF9wcml2DQo+PiAN
Cj4+IHJkbWFfYWRkcl9jYW5jZWwoKSBleHBlY3RzIHRoZXJlIHRvIGJlIG9uZSByZXEgb24gdGhl
IGxpc3QgYW5kIG9ubHkNCj4+IGNhbmNlbHMgdGhlIGZpcnN0IG9uZS4gVGhlIHNlbGYtcmVtb3Zh
bCBiZWhhdmlvciBvZiB0aGUgd29yayBvbmx5IGhhcHBlbnMNCj4+IGFmdGVyIHRoZSBoYW5kbGVy
IGhhcyByZXR1cm5lZC4gVGhpcyB5aWVsZHMgYSBzaXR1YXRpb25zIHdoZXJlIHRoZQ0KPj4gcmVx
X2xpc3QgY2FuIGhhdmUgdHdvIHJlcXMgZm9yIHRoZSBzYW1lICJoYW5kbGUiIGJ1dCByZG1hX2Fk
ZHJfY2FuY2VsKCkNCj4+IG9ubHkgY2FuY2VscyB0aGUgZmlyc3Qgb25lLg0KPj4gDQo+PiBUaGUg
c2Vjb25kIHJlcSByZW1haW5zIGFjdGl2ZSBiZXlvbmQgcmRtYV9kZXN0cm95X2lkKCkgYW5kIHdp
bGwNCj4+IHVzZS1hZnRlci1mcmVlIGlkX3ByaXYgb25jZSBpdCBpbmV2aXRhYmx5IHRyaWdnZXJz
Lg0KPj4gDQo+PiBGaXggdGhpcyBieSByZW1lbWJlcmluZyBpZiB0aGUgaWRfcHJpdiBoYXMgY2Fs
bGVkIHJkbWFfcmVzb2x2ZV9pcCgpIGFuZA0KPj4gYWx3YXlzIGNhbmNlbCBiZWZvcmUgY2FsbGlu
ZyBpdCBhZ2Fpbi4gVGhpcyBlbnN1cmVzIHRoZSByZXFfbGlzdCBuZXZlcg0KPj4gZ2V0cyBtb3Jl
IHRoYW4gb25lIGl0ZW0gaW4gaXQgYW5kIGRvZXNuJ3QgY29zdCBhbnl0aGluZyBpbiB0aGUgbm9y
bWFsIGZsb3cNCj4+IHRoYXQgbmV2ZXIgdXNlcyB0aGlzIHN0cmFuZ2UgZXJyb3IgcGF0aC4NCj4+
IA0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IEZpeGVzOiBlNTEwNjBmMDhhNjEg
KCJJQjogSVAgYWRkcmVzcyBiYXNlZCBSRE1BIGNvbm5lY3Rpb24gbWFuYWdlciIpDQo+PiBSZXBv
cnRlZC1ieTogc3l6Ym90K2RjM2RmYmEwMTBkNzY3MWUwNWY1QHN5emthbGxlci5hcHBzcG90bWFp
bC5jb20NCj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+
DQo+PiAtLS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jICAgICAgfCAxNyArKysr
KysrKysrKysrKysrKw0KPj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hX3ByaXYuaCB8ICAx
ICsNCj4+IDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgYi9kcml2ZXJzL2luZmluaWJhbmQv
Y29yZS9jbWEuYw0KPj4gaW5kZXggYzQwNzkxYmFjZWQ1ODguLjc1MWNmNWVhMjVmMjk2IDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMNCj4+ICsrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2NtYS5jDQo+PiBAQCAtMTc3Niw2ICsxNzc2LDE0IEBAIHN0YXRp
YyB2b2lkIGNtYV9jYW5jZWxfb3BlcmF0aW9uKHN0cnVjdCByZG1hX2lkX3ByaXZhdGUgKmlkX3By
aXYsDQo+PiB7DQo+PiAJc3dpdGNoIChzdGF0ZSkgew0KPj4gCWNhc2UgUkRNQV9DTV9BRERSX1FV
RVJZOg0KPj4gKwkJLyoNCj4+ICsJCSAqIFdlIGNhbiBhdm9pZCBkb2luZyB0aGUgcmRtYV9hZGRy
X2NhbmNlbCgpIGJhc2VkIG9uIHN0YXRlLA0KPj4gKwkJICogb25seSBSRE1BX0NNX0FERFJfUVVF
UlkgaGFzIGEgd29yayB0aGF0IGNvdWxkIHN0aWxsIGV4ZWN1dGUuDQo+PiArCQkgKiBOb3RpY2Ug
dGhhdCB0aGUgYWRkcl9oYW5kbGVyIHdvcmsgY291bGQgc3RpbGwgYmUgZXhpdGluZw0KPj4gKwkJ
ICogb3V0c2lkZSB0aGlzIHN0YXRlLCBob3dldmVyIGR1ZSB0byB0aGUgaW50ZXJhY3Rpb24gd2l0
aCB0aGUNCj4+ICsJCSAqIGhhbmRsZXJfbXV0ZXggdGhlIHdvcmsgaXMgZ3VhcmFudGVlZCBub3Qg
dG8gdG91Y2ggaWRfcHJpdg0KPj4gKwkJICogZHVyaW5nIGV4aXQuDQo+PiArCQkgKi8NCj4+IAkJ
cmRtYV9hZGRyX2NhbmNlbCgmaWRfcHJpdi0+aWQucm91dGUuYWRkci5kZXZfYWRkcik7DQo+PiAJ
CWJyZWFrOw0KPj4gCWNhc2UgUkRNQV9DTV9ST1VURV9RVUVSWToNCj4+IEBAIC0zNDEzLDYgKzM0
MjEsMTUgQEAgaW50IHJkbWFfcmVzb2x2ZV9hZGRyKHN0cnVjdCByZG1hX2NtX2lkICppZCwgc3Ry
dWN0IHNvY2thZGRyICpzcmNfYWRkciwNCj4+IAkJaWYgKGRzdF9hZGRyLT5zYV9mYW1pbHkgPT0g
QUZfSUIpIHsNCj4+IAkJCXJldCA9IGNtYV9yZXNvbHZlX2liX2FkZHIoaWRfcHJpdik7DQo+PiAJ
CX0gZWxzZSB7DQo+PiArCQkJLyogVGhlIEZTTSBjYW4gcmV0dXJuIGJhY2sgdG8gUkRNQV9DTV9B
RERSX0JPVU5EIGFmdGVyDQo+PiArCQkJICogcmRtYV9yZXNvbHZlX2lwKCkgaXMgY2FsbGVkLCBl
ZyB0aHJvdWdoIHRoZSBlcnJvcg0KPj4gKwkJCSAqIHBhdGggaW4gYWRkcl9oYW5kbGVyLiBJZiB0
aGlzIGhhcHBlbnMgdGhlIGV4aXN0aW5nDQo+PiArCQkJICogcmVxdWVzdCBtdXN0IGJlIGNhbmNl
bGVkIGJlZm9yZSBpc3N1aW5nIGEgbmV3IG9uZS4NCj4+ICsJCQkgKi8NCj4+ICsJCQlpZiAoaWRf
cHJpdi0+dXNlZF9yZXNvbHZlX2lwKQ0KPj4gKwkJCQlyZG1hX2FkZHJfY2FuY2VsKCZpZC0+cm91
dGUuYWRkci5kZXZfYWRkcik7DQo+PiArCQkJZWxzZQ0KPj4gKwkJCQlpZF9wcml2LT51c2VkX3Jl
c29sdmVfaXAgPSAxOw0KPiANCj4gV2h5IGRvbid0IHlvdSBuZXZlciBjbGVhciB0aGlzIGZpZWxk
PyBJZiB5b3UgYXNzdW1lIHRoYXQgdGhpcyBpcyBvbmUgbGlmZXRpbWUNCj4gZXZlbnQsIGNhbiB5
b3UgcGxlYXNlIGFkZCBhIGNvbW1lbnQgd2l0aCBhbiBleHBsYW5hdGlvbiAid2h5Ij8NCg0KQWRk
aW5nIHRvIHRoYXQsIGRvbid0IHlvdSBuZWVkIHtSRUFELFdSSVRFfV9PTkNFIHdoZW4gYWNjZXNz
aW5nIHVzZWRfcmVzb2x2ZV9pcD8gT3Igd2lsbCB0aGUgd3JpdGUgdG8gaXQgb2J0YWluIGdsb2Jh
bCB2aXNpYmlsaXR5IGJlY2F1c2UgbXV0ZXhfdW5sb2NrKCZjdHgtPm11dGV4KSBpcyBleGVjdXRl
ZCBiZWZvcmUgYW55IG90aGVyIGNvbnRleHQgY2FuIHJlYWQgaXQ/DQoNCg0KVGh4cywgSMOla29u
DQoNCj4gDQo+IFRoYW5rcw0KPiANCj4+IAkJCXJldCA9IHJkbWFfcmVzb2x2ZV9pcChjbWFfc3Jj
X2FkZHIoaWRfcHJpdiksIGRzdF9hZGRyLA0KPj4gCQkJCQkgICAgICAmaWQtPnJvdXRlLmFkZHIu
ZGV2X2FkZHIsDQo+PiAJCQkJCSAgICAgIHRpbWVvdXRfbXMsIGFkZHJfaGFuZGxlciwNCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jbWFfcHJpdi5oIGIvZHJpdmVycy9p
bmZpbmliYW5kL2NvcmUvY21hX3ByaXYuaA0KPj4gaW5kZXggNWM0NjNkYTk5ODQ1MzYuLmY5MmYx
MDFlYTk4MThmIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hX3By
aXYuaA0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hX3ByaXYuaA0KPj4gQEAg
LTkxLDYgKzkxLDcgQEAgc3RydWN0IHJkbWFfaWRfcHJpdmF0ZSB7DQo+PiAJdTgJCQlhZm9ubHk7
DQo+PiAJdTgJCQl0aW1lb3V0Ow0KPj4gCXU4CQkJbWluX3Jucl90aW1lcjsNCj4+ICsJdTggdXNl
ZF9yZXNvbHZlX2lwOw0KPj4gCWVudW0gaWJfZ2lkX3R5cGUJZ2lkX3R5cGU7DQo+PiANCj4+IAkv
Kg0KPj4gDQo+PiBiYXNlLWNvbW1pdDogYWQxN2JiZWYzZGQ1NzNkYTkzNzgxNmVkYzBhYjg0ZmVk
NmExN2ZhNg0KPj4gLS0gDQo+PiAyLjMzLjANCg0K
