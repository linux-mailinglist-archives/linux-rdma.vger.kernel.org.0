Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC534FE30
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Mar 2021 12:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhCaKiQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Mar 2021 06:38:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39960 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbhCaKiL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Mar 2021 06:38:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VAZAMB085156;
        Wed, 31 Mar 2021 10:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wTj/lEiDm43ixPru4SHlPuaOP7sfFaiUleWM1wMTB8c=;
 b=H8LNLcqjc/ntjyAId3TOPQBrH1yV5Ojs+m02W89BQzChcI851s0G6MojfgRzJ0KfePtX
 mBdUPTukzUcP/X1ANmRa99I6TfmHJ8D7Y9yzrSrMl5dGfb8NL3Wc+ipF3JTznU9gHfwz
 g/VNy/WfpxxP9BGzk34qVvH/iGVko6Z+EXpg1ZnazOkwyT9NBAh1X/QiLyS5K34QNHQy
 fCTjZaPLCbOp+vFl4q/uIaFhQl/MgGu0dpxx77UKSpo2HwvD/RcqjBfO5DLUdbGmEMiY
 2AjMCXKn5HyA1TU1MIHfCjBorTpUl0BvgUmlRemg0h3GymgaXQjPb3IUqEXWyeeU30yZ Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37mafv1s2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:38:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12VAZdkF136251;
        Wed, 31 Mar 2021 10:38:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by aserp3030.oracle.com with ESMTP id 37mabp8b7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 10:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWkGl/8mzopoOfXUn4csJskhIrPzDzvVXVByRdeBtIuBpHRLWlgMPbBvroI3nyUrd7Kf4e3kISvFQXfWUg6+7w5wYq3xiRM26xJGiuEi5dBm/lLpWZBAm8zhfKLpKgvvT9vTglWr1EklSVfJpgsoOanxXurbr+cN52Br3s0Acasd7FcNKIiBOiM/We/RBPHVCrLoZU1qvWHabEl7wD9OaXqSvYGOO9F9dMDh3Kytj9BtG+Q/bHx5iekUAGsup1oFyoFwIQ0Qhzkr9mjCHyRMQTZwfcscTzBQqE2chebth5s4ylm6kFz80EkxiPVfGpwuIjuVwTH68Lkl2V8zQv6fIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTj/lEiDm43ixPru4SHlPuaOP7sfFaiUleWM1wMTB8c=;
 b=B3TYdqT8/OmKT3r4QFm3rTl0sw0jINAt5o/2eqaoZlbtNTDjo0JVTZOSnGukK/oTSHpIMkqthgtegsARJlHh4zx7U7ji3PxCp5OTOsE+0hLxjvJlnE6RQqBuR+hyxr0kdBnyh5WIww+fNp8Lu0TxnqHci7M56YU5ggSWFlmzVVbBu6XHDiO2Gd46fo3yfZElrwMe6H4JQEcz9uUqrMrr0X47IMxxiaBSEoNbYs3aL98VyEd5R3yCJQqX12R7ghgY7obTRTnNJMNr5toJqQJTy8dmJcQNHVW4CUsX5ZfoWMlfPSo3ezWA/iPglwTYzZW8pb89TRQY6Ljj0syRV6Dk+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTj/lEiDm43ixPru4SHlPuaOP7sfFaiUleWM1wMTB8c=;
 b=xzEPhkmlnaX7g2kIfudl9bBYdjZoYkeFi0N4n0rHaIESIpCuixVn7puHjybii9cz3x10cHQNz/bAnsbf9Iw+nI9TIGn5kcmIs9k0hxZl3cS80vMlfxpv1X9U7au4g2Xq5JMQw3uyzf7J1Fovcc+0rTBJbdT7/5+3I5I+LB0A5Fs=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1302.namprd10.prod.outlook.com (2603:10b6:903:27::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Wed, 31 Mar
 2021 10:38:04 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.3977.033; Wed, 31 Mar
 2021 10:38:03 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Topic: [PATCH for-next] IB/cma: Introduce rdma_set_min_rnr_timer()
Thread-Index: AQHXIXfEcjVZJS51L0umIr0ZkYgnuKqdMUWAgAC/ogA=
Date:   Wed, 31 Mar 2021 10:38:02 +0000
Message-ID: <FF7812F0-B346-40A9-AC34-0D87CAB74753@oracle.com>
References: <1616677547-22091-1-git-send-email-haakon.bugge@oracle.com>
 <20210330231207.GA1464058@nvidia.com>
In-Reply-To: <20210330231207.GA1464058@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca140f90-e677-4a1e-0f05-08d8f431102c
x-ms-traffictypediagnostic: CY4PR10MB1302:
x-microsoft-antispam-prvs: <CY4PR10MB13029A00CA0BFE6C7DE3CE33FD7C9@CY4PR10MB1302.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBgLHuAjsSzkRC8USAGQ0fg2qCgUDGckgZQiF6yN0kPAHb2JhdtdkFU6vsyftNZsU2+N3yoGegKrtnwnMWNWz/yIoQ63MaWfFdGm7ZK43VOEfUz4QKEIm7a1jYxAAT3QGrRkY8UeLobyJpdURM6gZ6p6eiaZUl8J0F99sJ7LoFjvAP+5I06YcT3xV9pxWXvqGJRvXdx/rQgtWTbEFp6xb/ZUoOnckX8etlKeCqgmKxpzSq20I+h8h+dtHH/FkvkDu7EvsycXk3qnpf9Pn7CYoKhwXhaazHpWscQfrg0pt1mrVM3mOWYHYyIrz6ThBehDIaN6irzrOWOBxG7l0EzQzQh75fH747SkN0iE2+ZCraSnggpJz/GwQ0UY68YDesm0rMI8izI426PwDW1mGFBeFyQqSBlXTsi2NWfBxofJFJ/dpWVS/v3VSFMlRkYqODHvXJdTxvp7DCKn8qGl4a/RYs8eX8jG8TyiybJQ7606Q7mzOfehtBgnF2WSSDStiaY+xhflyNebbRahedF5xan0R9BkguMSfSriCOJ86QdFXswxpHugz8KhHYGe1kU/HNocXE/QHG9gDpAjJq2q0Ub0SyY0ePSwNhKxQKd/pRMC6uPYp834Mxho9zk9g4M9aT+cZtuAzGfiZFV4WzpIuIJZxqI3ONGWPttvu23hKbjDkKv1gcaWAorHgwkHMigNYVKJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(2906002)(4326008)(36756003)(6512007)(44832011)(6916009)(33656002)(64756008)(478600001)(26005)(66946007)(66476007)(54906003)(53546011)(6506007)(76116006)(71200400001)(91956017)(4744005)(86362001)(8936002)(6486002)(316002)(8676002)(5660300002)(66446008)(66556008)(2616005)(38100700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkdCcXVhV2pFM0xnc3luVmlTYXdkY29naW1FZUZLWWdieSsyaTNDM2tkTGdW?=
 =?utf-8?B?UFZnUUZvSzl6TnVYazk0ak01b25wTTRnNUQ5Q1JHUFI3YVd6c2toYnUxM3Bx?=
 =?utf-8?B?cVd6RytJNlBiSlc4YklVWkk4Skp0bFU0bG81cWNHdnFTa0RuSThSSVB6UExz?=
 =?utf-8?B?QjZna1ZsSHJMa2VROG1MQ05ES0U5MnZabXg0WHJQUkRTdlJoKy9qQWhzK3M3?=
 =?utf-8?B?K2JqZmVzclAvN0YrM09raWV3S2twdGprWHFMNHI5RlZtdEwrYm9jL2ZMVU9H?=
 =?utf-8?B?ZDhNa0NsYlNmMFU3RFVGNStGeFQ2cG1HL2VqRXF4M2ZhS2I4cVVOV3UxUXg1?=
 =?utf-8?B?Wm5TVFYzamx1Z0ZzeVJjcGVrT1puZUpSOWRCSlJYRXFrZXVDNzZtMjRMWGQ3?=
 =?utf-8?B?SUdZOFRaVHFrRXdORkFwQ3IxVnRSSldSTFhrcTRWMWhoN0NjZFVWU0tQSlAx?=
 =?utf-8?B?cEdsNXVtWUdOSlZYNE1QM0dEeXBMMlBpTnVoMk1EUUpjN1R3Q1ZQb1c0OC9q?=
 =?utf-8?B?WFpsUTAwRjNjZUJrOTcrV1o2ZnBUS3dPQW1sVDVTQ1VuWUhvZEdYM0dqc091?=
 =?utf-8?B?MVhYN0RZMnB5b2ROTno5VjNsTG9qOGdLYnJzaTBhazJaaXFVWWx4SDV4VDN2?=
 =?utf-8?B?NUtoNVorUkFDZHcrR3oxa2xwdHp6eEdrVmV6N3BkeHc4bS9RaEFGN0FGWUFl?=
 =?utf-8?B?WnZKR3l5czBoOVBScmlvd3FCOXdQRUVpQkdnaUt4MFNLVXlrZXhXMmdSR25O?=
 =?utf-8?B?Rm1ialpiZWpUSmdUSTZRMVVONzZadEVjcnBYbVVreExWaVlMdkhwT1h1UFdU?=
 =?utf-8?B?aWsrNzZ2aFFIWmMvOWpMc3IvaGNMTHh5RE1ndTVKWjZOanVVZ2tXL3lyRTl6?=
 =?utf-8?B?UXpOcWp3K1dQUndFTDBYN0pIZnJCU1Y5cjVPVHdEaFVmUUNZbG9iQmJoeFRq?=
 =?utf-8?B?dWw1eU1lQ0JqRytuMzRSdGFqbDFzZFpDU0NuV2UvTjFmVlBYLzNRdWg4MjFD?=
 =?utf-8?B?MjBudTlFVzRhcWl4VVNUczcvb0VGRzhSS0t2eC9xcDlFYVJHU1Mvc3BnY1hj?=
 =?utf-8?B?a1FGMFNDL2RBQVMxamhFdUNFajQ3U3BmZHJpZW5Idk9heGliVXl1SXNRazBq?=
 =?utf-8?B?ZklPamFDZnJlUTByc0Z1NnIxTW5DMEhvZWJweHAzakxtbXdVZHlTYUY1dE5M?=
 =?utf-8?B?ZmFmWlpTTjRBRTQ2aTY4bHBwYWdTQUhpQm9hT0dEdnNHZlExSndRZC9DQXV4?=
 =?utf-8?B?eXBJb1NKNUxNSnFVb3M1K0JkR0pFejNITU90bEwxRnYvVVhDOWpBVEQ0ZVRQ?=
 =?utf-8?B?emE0TFNXcEhwSUVqemlPSjFCR2l0eFdCajg4dXlYV3BSdnQ1M3k0VmpndmZ5?=
 =?utf-8?B?VG1NclJMbVgyRzdabjFpZEFvWlhpTnBnUytQMGxPQ3pOKzdVNGVFajQrU1ZQ?=
 =?utf-8?B?UFU2RjhSbC9ZbFlsRGFCdzMwMFl3UDB6a3cwUnowM3VZL0hzVXd0UmkwZXZX?=
 =?utf-8?B?bWp0MXFJbXlSQ2U4UnVoWENrSHBnZ2tYaEhqSXRqdVE1L3pZZDZIeEJCYmt6?=
 =?utf-8?B?aVRXSnpsZFlucy9PUnIyZ1BwVm9ZRFVoU2h3bzMxVnp1YmV6RkNNV3llVEZn?=
 =?utf-8?B?V3IrN2pWeDBxQ3Q4ZnNIb29QS0c3OTllaFFVU0loMG9PR0hqNkV5ZVBFSmNs?=
 =?utf-8?B?bEFDOWhtbjc2OTArMnA5N0plR1lqVWh4bVZSLzB1MUFHb2dyQ1RxMi9EeDdn?=
 =?utf-8?B?cnZMSnB1MERRZVRtaXJqRXFDcDZqSWM1R09rWkd2UjlYRUtheklmM1dKK2JK?=
 =?utf-8?B?Ym1TSUc2UVZ0UUJwRWxBdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <133DD702E1858A44BF07ADB5E4C3D835@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca140f90-e677-4a1e-0f05-08d8f431102c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 10:38:02.7736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItGO4Qt2Bw52g1V9ojr4v5CqWfCsmicq1G6GB/1nML2N2YVYV9nYVBr3IyaSHOSMbZPpxd3/sCDFVN/KbhQ+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1302
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310076
X-Proofpoint-ORIG-GUID: tIvzq_KgYIUlqPjw26ScD2odx0otLw9k
X-Proofpoint-GUID: tIvzq_KgYIUlqPjw26ScD2odx0otLw9k
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103310076
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjEsIGF0IDAxOjEyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWFyIDI1LCAyMDIxIGF0IDAyOjA1OjQ3UE0g
KzAxMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IEludHJvZHVjZSB0aGUgYWJpbGl0eSBmb3Ig
Ym90aCB1c2VyLXNwYWNlIGFuZCBrZXJuZWwgVUxQcyB0byBhZGp1c3QNCj4+IHRoZSBtaW5pbXVt
IFJOUiBSZXRyeSB0aW1lci4gVGhlIElOSVQgLT4gUlRSIHRyYW5zaXRpb24gZXhlY3V0ZWQgYnkN
Cj4+IFJETUEgQ00gd2lsbCBiZSB1c2VkIGZvciB0aGlzIGFkanVzdG1lbnQuIFRoaXMgYXZvaWRz
IGFuIGFkZGl0aW9uYWwNCj4+IGliX21vZGlmeV9xcCgpIGNhbGwuDQo+IA0KPiBDYW4ndCB1c2Vy
c3BhY2Ugb3ZlcnJpZGUgdGhlIGlidl9tb2RpZnlfcXAoKSBjYWxsIHRoZSBsaWJyZG1hY20gd2Fu
dHMNCj4gdG8gbWFrZSB0byBkbyB0aGlzPw0KDQpOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFRoZSBw
b2ludCBpcywgdGhhdCB1c2VyLWxhbmQgd2hpY2ggaW50ZW5kcyB0byBzZXQgc2FpZCB0aW1lciwg
Y2FuIGRvIHNvIHdpdGhvdXQgYW4gYWRkaXRpb25hbCBpYnZfbW9kaWZ5X3FwKCkgY2FsbC4gTWF5
IGJlIEkgc2hvdWxkIGhhdmUgYWRkZWQ6DQoNClNoYW1lbGVzc2x5LWluc3BpcmVkLWJ5OiAyYzE2
MTllZGVmNjEgKCJJQi9jbWE6IERlZmluZSBvcHRpb24gdG8gc2V0IGFjayB0aW1lb3V0IGFuZCBw
YWNrIHRvc19zZXQiKQ0KDQo+IFlvdSdsbCBuZWVkIHRvIG1ha2UgdGhlIHJkbWEtY29yZSBwYXRj
aGVzIGJlZm9yZSB0aGlzIGNhbiBnbyBhaGVhZA0KDQpPb2gsIEkgdGhvdWdodCBpdCB3YXMgdGhl
IG90aGVyIHdheSBhcm91bmQuIFdpbGwgZG8uDQoNCkkgYWxzbyBpbnRlbmQgdG8gc2VuZCBhbiBS
RFMgcGF0Y2gsIHNvIHRoZXJlIHdpbGwgYmUgYXQgbGVhc3QgdHdvIHVzZXJzIG9mIHRoaXMuDQoN
Cg0KVGh4cywgSMOla29uDQoNCg0K
