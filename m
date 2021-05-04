Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487AA372C16
	for <lists+linux-rdma@lfdr.de>; Tue,  4 May 2021 16:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhEDOgH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 May 2021 10:36:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46540 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEDOgH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 May 2021 10:36:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144EY6u6144747;
        Tue, 4 May 2021 14:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OERTcleYUt2PlqDie5ap0gAi2Z+oRaDCOwywUi+NeM4=;
 b=GlfXEXUaB2+c1SnwBx3GcfmlDoB9Qeb7FM2eXC/EKCRapqlGCl0QHCv+YjH3oJSHmPpP
 ThfcX4fvp0zqhRpdHQpI7n/tfmkidxTMOj8t3j+94CtHkX1x452uFcWVgnwT2xiwBXb7
 Xf/qtmOp3ABC1+DUSfpD30xS33P7ZQW0Cd6XwoQTD//Pg9U17rlsqj+gmdJOjk9MGJoL
 gDDbAKJ/lgOf147dHa3L0ptPfKWzXYShpcocnL1vsfDmdDuyQZdSuxHJf2CyNhaGiNDF
 aAusI/8iv48rdRzFBq1/ShoPo8/nbhg7RaW+kth2dbQ1gjgEPZEI41NoeuyfNRD1W7TB Vg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 388xxmy5hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 14:35:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144EQGN7052196;
        Tue, 4 May 2021 14:35:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 388xt46g4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 14:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0SLD8Nw9G5vui1xHd5A1bk1BIvJVYoOCRK3A8Bils84fLM0x4fJNxKMwBsgIXQbX9rroPtqUfbCFXssyIQuNBUL3E9JcFKwyoMQ1cvjSoT3KQRd61km4TGP/opDBrWOkwD0ENE72NAUGX/xnRE8hXldryLzUWiOtQe+6goYyfQprkosbszMa4YujX84azh/42VhqYKXa64cOymnVKm2qHWlQoH2GcnGmSu2EgkoK/DN//0xKvGNPClMnZzThKfmQtFZE4dsd1ha6ur5oZjtVCpCq4q1yEcNLUhKfl2F/taK6rYagBnBit1xtSLahtZjFlMoBtwGczZLaoxKQ/f0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OERTcleYUt2PlqDie5ap0gAi2Z+oRaDCOwywUi+NeM4=;
 b=Ef2HTp7Wm+MTFhF8Pw55ACJAPfAW2W4tuDMU09WefWlFkByrwF0Pf5yH35xFwslMotgBmoSRpA8bKa1c4sHPXMz/LzYsXR9Zp4zJy8vspecjQs/CP/OZBdtwZ96rt4iIY4Q0aM36oB0qb6CL6YKm+1VsCANyBwvqmmBL3cr9zIiwj4o6EbfAyfuQxX5OrL4Ddp5FhoA2D+35iSQd7lfc8+6wz//zRAZqm6O9Kqta2dn5ClmxstWAhP2aAhecfDJgzBvbvssgLBRQdfCXwmkSf5nj+rl8huKWTSdoVECanqSQsKMdyZ972tV79wyxRnZQcOTAuYV5eV1DAiOf2bmtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OERTcleYUt2PlqDie5ap0gAi2Z+oRaDCOwywUi+NeM4=;
 b=xP4rd+xwOMRpbjUFewc6bdOG+dFbHg6BSRaXgAAWtN59HmTYHyNoEaaoKT0wcA6woP+EscUwEExjO/r9xX3OBcLO78+OGyOG4+ZbG0pRcPqrbUhBzP54dfP0NWowgt0QxFDBp8GPDDbVHlVMBiu49FkzwBsRTgGqhBdsfO5d7Ic=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2135.namprd10.prod.outlook.com (2603:10b6:910:41::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 14:35:05 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:35:05 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Topic: [PATCH for-next] IB/core: Only update PKEY and GID caches on
 respective events
Thread-Index: AQHXQNsoKNg9ZANZeEOoJCtxKjVql6rTXjgAgAAFaIA=
Date:   Tue, 4 May 2021 14:35:05 +0000
Message-ID: <BD9C7199-712F-4FAF-AC29-D91BAAC2F5A3@oracle.com>
References: <1620128784-3283-1-git-send-email-haakon.bugge@oracle.com>
 <CAD=hENfQX=oCsAsbvsp5SXLYUD6vxRszBZ8SpjkgYzrziPWz_g@mail.gmail.com>
In-Reply-To: <CAD=hENfQX=oCsAsbvsp5SXLYUD6vxRszBZ8SpjkgYzrziPWz_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d44c904-919f-4f2e-fc10-08d90f09cf64
x-ms-traffictypediagnostic: CY4PR1001MB2135:
x-microsoft-antispam-prvs: <CY4PR1001MB21357767E0374D60BAC1209DFD5A9@CY4PR1001MB2135.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxYcOb7AeViei951B9J2W8g5J6Xm0xHA7Dsc1mJpLeOjIJbyLM9OVBOe1ZGE3at8oqrJo4KYzt+LnFLZcuEzVljM4Ff+hCC3LsCqwgABjTT8P1/FVtfOIgSH7OU/Nlj8Y4VhRA6wIhKyLDkekS+BZYIGEhPs41j9xmB/4/d/ntZaGyNK79HyEcCoC4ivdn23/0S84abFR7VDKWr5uq6HKFaH/oaa8Od1NZlRbzcS20sK+jYI9RxS8P82sO4S15NljxVvL6PuldEY27gJ7w3gZTWh56pgU5OAh9Aur3oQswLBl7IREPZ0AaQqDDefTU/k9Ce8kquAkq/NMzJtRVw8xn/OFfcTecWhQeC2j8VDF3nhH6qqBOlP345bbhDZYCsU6fwOG5tEHWZSe2a4lHffJM8rV8es5pTK50u80ujDvYtJkC/uOarevmltdt2a7TBn6FjWP1Z+h2SufLfTlxU/3P6Y3EvF/VZm+WUukSilhjV7a75lhrxuVRFsR2oHFlWO2VOsL7I+TeZGx1f+mRq+cpe034rNskOeu+v07hdrxn3NhykHUm8ejvS5chcmeVNr8rQ6d3nfHa824aCMUBslOYZ2V85u7hdX0Xx8t3HxdCejwNbjZDe7L8ZzdBcsWundGe9z3XoFmu0ijTd1hMgrsXcRlqNosMTCHR5KlzpKqM51toin8w6MtYMdepOcDkxO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(4326008)(122000001)(64756008)(26005)(186003)(86362001)(66946007)(5660300002)(91956017)(6916009)(6506007)(76116006)(53546011)(66446008)(66556008)(66476007)(15650500001)(2906002)(6486002)(33656002)(38100700002)(54906003)(8676002)(6512007)(316002)(83380400001)(71200400001)(478600001)(44832011)(8936002)(2616005)(66574015)(36756003)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OFNpQ04vODRSVVo5ZVB3ZXp1ZllYRVdld3orUEJueE5jQmVXaHF5OUFTVndi?=
 =?utf-8?B?SHBPOGVJd2V4dFVyUTEzSzBrVDFpNUVpWE1pT1BXMVF0enQwOGo4cnVWS1R1?=
 =?utf-8?B?Rk1FV0h3dkIrZkwxRWpWME16c3hsM1p6ejlBUHBSeTVsZWtkVE1MditJQnhN?=
 =?utf-8?B?MHVlNGwySDk5ZW5TYnBsMEYyUm5lNDNVNjF5OGo1azJqK2VQNUxhN0R0cnNz?=
 =?utf-8?B?ZjBJRGRFWXNCN0g3bWdiMWdyN2kyY1c3M01ncFBGa3B4M2xtZkI3aHZGQU5Q?=
 =?utf-8?B?ZGxRZTM2MGIrc3hNT0ZWOUVtUmxzQXplTGY0OElCTWVMT2NicExNeGpRTXh5?=
 =?utf-8?B?a2VHL2NVV1hTY0o1Z2EvMUxMcVpBLzMyOFlkVXFvZUo3a3kvcXl6N3RuUFFD?=
 =?utf-8?B?SDVqWHpNZkh3N0VUZVpsS3RmSWI4cVdyRzBNVTJhTXpuay94Y0RmRXBHUlF3?=
 =?utf-8?B?UXBQTENkbkZxeThSOWRzcHBvb2JPNjM0WUY1cmRzeEdOaitDS3dzdXdlcDg2?=
 =?utf-8?B?bXA1VWJmekFYb0txU3FrTTViajJHckpISG1hakJwNXFaZ3orWUI1OTJ1THhv?=
 =?utf-8?B?dmk0bVp6dmJ4RHpzK1JMSEhSYitERVQvWXd5bzVMTGptTjdUS2plcy83K3lq?=
 =?utf-8?B?MlpvbXU0cCtleWVhNEVVUG1RRFRzSzJXRTV2RnFaUFo0MTZqckNKd3RPa1BI?=
 =?utf-8?B?SThyeFBrWnZPeHk3cmREZGdJV0thMUE2UzVRUkxIN3M5TGlGYkxwUEt6MUEz?=
 =?utf-8?B?UXRmTjFvdllONXpVTkNRMGNlU2d6bFAyWDNOTkJHQTh4MXhxK0dKNjlycUd1?=
 =?utf-8?B?YnZzYXUvRExIN1dVcnRWZ3I5SElIaERra3hKYUVxYmxWekdKZzVnUEIxU3kw?=
 =?utf-8?B?cGVFdDZ0S3k4S0c1NzlidFpQWnB5VlhsNXlLMkRvNDVMZ2U2WFlRM0NCSmR3?=
 =?utf-8?B?TTVSaUJSeWpDOGhqUnNRTlNZcXRnaHdzMXVGZzdzN0VVUGhSbG56RnZ1ayt1?=
 =?utf-8?B?aDlZcHArNFRMSXN4TnQ4SEVIckl5TnRNc0J3MUEzd3dDRXJCaDE3QUJwcjNI?=
 =?utf-8?B?aXFGTitVNmZwTmxkRDZFakFEamZZNC9NbUVyb3hid3lBa1NOUlBnZ3pHaHhM?=
 =?utf-8?B?U2pMMHBPK3I3TW5ZT1BheWJtYlBVM1g0dXIxRmVvZkFsQUxyMGJ6a0thRW1w?=
 =?utf-8?B?Z3dWTHVGNE91MSsxNXZMek1FNnRFOFhCbDloMXNmQm02eGdRMC9wb280ZUh6?=
 =?utf-8?B?ZytlS1A2dTgrMS8wOHFHdis4UXp2Skt0U1M2cDNuWm1pOFFVN2JkZ3BaaENx?=
 =?utf-8?B?QTVkMk5HbGdWazl5MEVWZXRsY0Z3Z055bDg0RkZpM0pjK1RVcGx5d0NLZzlE?=
 =?utf-8?B?Q1VFZ0wvMTJhYlk3VDZmeDJFUjc1YTNTM0hEZG1YZGIxblRSUG9vSjYvRVpF?=
 =?utf-8?B?YmlNOG92UE1ZTklUampLWU43UGtSaU9IRHdBQ3Zvdmc5VzA3WU5yWElieGJE?=
 =?utf-8?B?VWkzNGg2c2MxcFpXUTYrZU5BWS9VMXEwYzArMTlaamY4K3NGTnZzNFp3Z1Yx?=
 =?utf-8?B?dnVyMit3VDF3OEFib1h2V3RRS2VBbkxRaFQ2RHdob1h6RTN5VHNaZmtUYnBh?=
 =?utf-8?B?dkFoRmEyMTh5S2N0WktYblZldmc1TEg2V0o3Z2xqbGQvNW9CbHh6L2NQNDUz?=
 =?utf-8?B?WUFyc1VvYUh5R2l3S0VpR2VnRWFNUDZ1QjBVanErZTU2dndJSVYxR2JENlFX?=
 =?utf-8?B?OERmY1ROMkM4R2RXbTJKUVIzanhDcjNMSUxUbkN0Wk45dTYwZXpUUktvb0t1?=
 =?utf-8?B?VlMxcGpDNmFwa1dKV3pzdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFF41912AE0DA14C93136E2021E4D88D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d44c904-919f-4f2e-fc10-08d90f09cf64
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 14:35:05.7600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P6mmh2M2GKNhRlZXON+Y8masvZTD3/gcZr7gxdZb74tee1bzaKSh7a4eLRA7TihGRjl5M92kWy0a694c+3gi/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2135
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040109
X-Proofpoint-GUID: Z3bQz4YhJnY0ol6HRJc1QptmVW1EddoX
X-Proofpoint-ORIG-GUID: Z3bQz4YhJnY0ol6HRJc1QptmVW1EddoX
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gNCBNYXkgMjAyMSwgYXQgMTY6MTUsIFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21h
aWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgTWF5IDQsIDIwMjEgYXQgNzo1MCBQTSBIw6Vr
b24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPiB3cm90ZToNCj4+IA0KPj4gQm90aCB0
aGUgUEtFWSBhbmQgR0lEIHRhYmxlcyBpbiBhbiBIQ0EgY2FuIGhvbGQgaW4gdGhlIG9yZGVyIG9m
DQo+PiBodW5kcmVkcyBlbnRyaWVzLiBSZWFkaW5nIHRoZW0gYXJlIGV4cGVuc2l2ZS4gUGFydGx5
IGJlY2F1c2UgdGhlIEFQSQ0KPj4gZm9yIHJldHJpZXZpbmcgdGhlbSBvbmx5IHJldHVybnMgYSBz
aW5nbGUgZW50cnkgYXQgYSB0aW1lLiBGdXJ0aGVyLCBvbg0KPj4gY2VydGFpbiBpbXBsZW1lbnRh
dGlvbnMsIGUuZy4sIENYLTMsIHRoZSBWRnMgYXJlIHBhcmF2aXJ0dWFsaXplZCBpbg0KPj4gdGhp
cyByZXNwZWN0IGFuZCBoYXZlIHRvIHJlbHkgb24gdGhlIFBGIGRyaXZlciB0byBwZXJmb3JtIHRo
ZQ0KPj4gcmVhZC4gVGhpcyBhZ2FpbiBkZW1hbmRzIFZGIHRvIFBGIGNvbW11bmljYXRpb24uDQo+
PiANCj4+IElCIENvcmUncyBjYWNoZSBpcyByZWZyZXNoZWQgb24gYWxsIGV2ZW50cy4gSGVuY2Us
IGZpbHRlciB0aGUgcmVmcmVzaA0KPj4gb2YgdGhlIFBLRVkgYW5kIEdJRCBjYWNoZXMgYmFzZWQg
b24gdGhlIGV2ZW50IHJlY2VpdmVkIGJlaW5nDQo+PiBJQl9FVkVOVF9QS0VZX0NIQU5HRSBhbmQg
SUJfRVZFTlRfR0lEX0NIQU5HRSByZXNwZWN0aXZlbHkuDQo+PiANCj4gDQo+IE1pc3NpbmcgRml4
ZXM/DQoNCkkgd2FzIHRoaW5raW5nIHRoYXQgdGhpcyBpcyBhIHBlcmZvcm1hbmNlIGZpeCwgbm90
IGEgYnVnIGZpeC4gUHJvYmFibHkgbm90IHNldmVyZSBlbm91Z2ggdG8gZ28gaW50byBzdGFibGUu
IEJ1dCBieSBhbnkgbWVhbnMsIGl0DQoNCkZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYu
MTItcmMyIikNCg0KDQpUaHhzLCBIw6Vrb24NCg0KDQoNCj4gWmh1IFlhbmp1bg0KPiANCj4+IFNp
Z25lZC1vZmYtYnk6IEjDpWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiAt
LS0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmMgfCAyNSArKysrKysrKysrKysr
KysrLS0tLS0tLS0tDQo+PiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOSBkZWxl
dGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Nh
Y2hlLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jDQo+PiBpbmRleCA1YzlmYWM3
Li41MzFhZTZiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUu
Yw0KPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYw0KPj4gQEAgLTE0NzIs
MTAgKzE0NzIsMTQgQEAgc3RhdGljIGludCBjb25maWdfbm9uX3JvY2VfZ2lkX2NhY2hlKHN0cnVj
dCBpYl9kZXZpY2UgKmRldmljZSwNCj4+IH0NCj4+IA0KPj4gc3RhdGljIGludA0KPj4gLWliX2Nh
Y2hlX3VwZGF0ZShzdHJ1Y3QgaWJfZGV2aWNlICpkZXZpY2UsIHU4IHBvcnQsIGJvb2wgZW5mb3Jj
ZV9zZWN1cml0eSkNCj4+ICtpYl9jYWNoZV91cGRhdGUoc3RydWN0IGliX2RldmljZSAqZGV2aWNl
LCB1OCBwb3J0LCBlbnVtIGliX2V2ZW50X3R5cGUgZXZlbnQsDQo+PiArICAgICAgICAgICAgICAg
Ym9vbCByZWdfZGV2LCBib29sIGVuZm9yY2Vfc2VjdXJpdHkpDQo+PiB7DQo+PiAgICAgICAgc3Ry
dWN0IGliX3BvcnRfYXR0ciAgICAgICAqdHByb3BzID0gTlVMTDsNCj4+IC0gICAgICAgc3RydWN0
IGliX3BrZXlfY2FjaGUgICAgICAqcGtleV9jYWNoZSA9IE5VTEwsICpvbGRfcGtleV9jYWNoZTsN
Cj4+ICsgICAgICAgc3RydWN0IGliX3BrZXlfY2FjaGUgICAgICAqcGtleV9jYWNoZSA9IE5VTEw7
DQo+PiArICAgICAgIHN0cnVjdCBpYl9wa2V5X2NhY2hlICAgICAgKm9sZF9wa2V5X2NhY2hlID0g
TlVMTDsNCj4+ICsgICAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgICAgdXBkYXRlX3BrZXlf
Y2FjaGUgPSAocmVnX2RldiB8fCBldmVudCA9PSBJQl9FVkVOVF9QS0VZX0NIQU5HRSk7DQo+PiAr
ICAgICAgIGJvb2wgICAgICAgICAgICAgICAgICAgICAgIHVwZGF0ZV9naWRfY2FjaGUgPSAocmVn
X2RldiB8fCBldmVudCA9PSBJQl9FVkVOVF9HSURfQ0hBTkdFKTsNCj4+ICAgICAgICBpbnQgICAg
ICAgICAgICAgICAgICAgICAgICBpOw0KPj4gICAgICAgIGludCAgICAgICAgICAgICAgICAgICAg
ICAgIHJldDsNCj4+IA0KPj4gQEAgLTE0OTIsMTQgKzE0OTYsMTYgQEAgc3RhdGljIGludCBjb25m
aWdfbm9uX3JvY2VfZ2lkX2NhY2hlKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSwNCj4+ICAgICAg
ICAgICAgICAgIGdvdG8gZXJyOw0KPj4gICAgICAgIH0NCj4+IA0KPj4gLSAgICAgICBpZiAoIXJk
bWFfcHJvdG9jb2xfcm9jZShkZXZpY2UsIHBvcnQpKSB7DQo+PiArICAgICAgIGlmICghcmRtYV9w
cm90b2NvbF9yb2NlKGRldmljZSwgcG9ydCkgJiYgdXBkYXRlX2dpZF9jYWNoZSkgew0KPj4gICAg
ICAgICAgICAgICAgcmV0ID0gY29uZmlnX25vbl9yb2NlX2dpZF9jYWNoZShkZXZpY2UsIHBvcnQs
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRwcm9w
cy0+Z2lkX3RibF9sZW4pOw0KPj4gICAgICAgICAgICAgICAgaWYgKHJldCkNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBlcnI7DQo+PiAgICAgICAgfQ0KPj4gDQo+PiAtICAgICAgIGlm
ICh0cHJvcHMtPnBrZXlfdGJsX2xlbikgew0KPj4gKyAgICAgICB1cGRhdGVfcGtleV9jYWNoZSAm
PSAhIXRwcm9wcy0+cGtleV90YmxfbGVuOw0KPj4gKw0KPj4gKyAgICAgICBpZiAodXBkYXRlX3Br
ZXlfY2FjaGUpIHsNCj4+ICAgICAgICAgICAgICAgIHBrZXlfY2FjaGUgPSBrbWFsbG9jKHN0cnVj
dF9zaXplKHBrZXlfY2FjaGUsIHRhYmxlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHByb3BzLT5wa2V5X3RibF9sZW4pLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgR0ZQX0tFUk5FTCk7DQo+PiBAQCAtMTUyNCw5ICsx
NTMwLDEwIEBAIHN0YXRpYyBpbnQgY29uZmlnX25vbl9yb2NlX2dpZF9jYWNoZShzdHJ1Y3QgaWJf
ZGV2aWNlICpkZXZpY2UsDQo+PiANCj4+ICAgICAgICB3cml0ZV9sb2NrX2lycSgmZGV2aWNlLT5j
YWNoZV9sb2NrKTsNCj4+IA0KPj4gLSAgICAgICBvbGRfcGtleV9jYWNoZSA9IGRldmljZS0+cG9y
dF9kYXRhW3BvcnRdLmNhY2hlLnBrZXk7DQo+PiAtDQo+PiAtICAgICAgIGRldmljZS0+cG9ydF9k
YXRhW3BvcnRdLmNhY2hlLnBrZXkgPSBwa2V5X2NhY2hlOw0KPj4gKyAgICAgICBpZiAodXBkYXRl
X3BrZXlfY2FjaGUpIHsNCj4+ICsgICAgICAgICAgICAgICBvbGRfcGtleV9jYWNoZSA9IGRldmlj
ZS0+cG9ydF9kYXRhW3BvcnRdLmNhY2hlLnBrZXk7DQo+PiArICAgICAgICAgICAgICAgZGV2aWNl
LT5wb3J0X2RhdGFbcG9ydF0uY2FjaGUucGtleSA9IHBrZXlfY2FjaGU7DQo+PiArICAgICAgIH0N
Cj4+ICAgICAgICBkZXZpY2UtPnBvcnRfZGF0YVtwb3J0XS5jYWNoZS5sbWMgPSB0cHJvcHMtPmxt
YzsNCj4+ICAgICAgICBkZXZpY2UtPnBvcnRfZGF0YVtwb3J0XS5jYWNoZS5wb3J0X3N0YXRlID0g
dHByb3BzLT5zdGF0ZTsNCj4+IA0KPj4gQEAgLTE1NTgsNyArMTU2NSw3IEBAIHN0YXRpYyB2b2lk
IGliX2NhY2hlX2V2ZW50X3Rhc2soc3RydWN0IHdvcmtfc3RydWN0ICpfd29yaykNCj4+ICAgICAg
ICAgKiB0aGUgY2FjaGUuDQo+PiAgICAgICAgICovDQo+PiAgICAgICAgcmV0ID0gaWJfY2FjaGVf
dXBkYXRlKHdvcmstPmV2ZW50LmRldmljZSwgd29yay0+ZXZlbnQuZWxlbWVudC5wb3J0X251bSwN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHdvcmstPmVuZm9yY2Vfc2VjdXJpdHkp
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd29yay0+ZXZlbnQuZXZlbnQsIGZh
bHNlLCB3b3JrLT5lbmZvcmNlX3NlY3VyaXR5KTsNCj4+IA0KPj4gICAgICAgIC8qIEdJRCBldmVu
dCBpcyBub3RpZmllZCBhbHJlYWR5IGZvciBpbmRpdmlkdWFsIEdJRCBlbnRyaWVzIGJ5DQo+PiAg
ICAgICAgICogZGlzcGF0Y2hfZ2lkX2NoYW5nZV9ldmVudCgpLiBIZW5jZSwgbm90aWZpeSBmb3Ig
cmVzdCBvZiB0aGUNCj4+IEBAIC0xNjMxLDcgKzE2MzgsNyBAQCBpbnQgaWJfY2FjaGVfc2V0dXBf
b25lKHN0cnVjdCBpYl9kZXZpY2UgKmRldmljZSkNCj4+ICAgICAgICAgICAgICAgIHJldHVybiBl
cnI7DQo+PiANCj4+ICAgICAgICByZG1hX2Zvcl9lYWNoX3BvcnQgKGRldmljZSwgcCkgew0KPj4g
LSAgICAgICAgICAgICAgIGVyciA9IGliX2NhY2hlX3VwZGF0ZShkZXZpY2UsIHAsIHRydWUpOw0K
Pj4gKyAgICAgICAgICAgICAgIGVyciA9IGliX2NhY2hlX3VwZGF0ZShkZXZpY2UsIHAsIDAsIHRy
dWUsIHRydWUpOw0KPj4gICAgICAgICAgICAgICAgaWYgKGVycikNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsNCj4+ICAgICAgICB9DQo+PiAtLQ0KPj4gMS44LjMuMQ0KDQo=
