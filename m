Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EE937A563
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 13:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhEKLBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 07:01:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhEKLBT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 07:01:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BAx27F131322;
        Tue, 11 May 2021 11:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/H9pxsN/xG64p3bi9aOIV30e3IHoKfCUJq8wcGCnNS4=;
 b=0YwVEliF1WNLh/NoaOgmP3Re+DbBrpMGIWkO9ohRPoDW4KDkNNdkpZHnBL9+ISF1oqgb
 yuod3GwdSpwDOl5NWP7jY2vALSmaiA11yDSCqWfRCw23t+P6m8xkRZSL1gEK2PJgGZKV
 Zsy0bnyjzgzu88GKFEr1uNnMZp7e3bKjr0tKsL3CGJoVWvqDCN6VyptIlpdXS/19JRep
 x3/pA9WTl1zQ9GdtUdUeDqyc5GNPekbKgTSBoQ+zHo3FDulE55ME1xLoL/uSYxPQh0Jw
 u6F6kGsLuddBNwlQkeJfR9Fq+TjpFJ97YLjpnvDPxPnjOXKhmWtFck8EsCxN+hM/rlZ4 fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9ne9p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 11:00:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14BAu1bs046157;
        Tue, 11 May 2021 11:00:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3020.oracle.com with ESMTP id 38fh3whm4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 11:00:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqrWSpCdbeSIRp1dulFXhBysEEhFaRyHLPpyzAFU3WgARbtacS47+Zo+SD8YMcDWBDQnkboGX9GeGcO1WkK9PU1nYuZwbvQSCvGmOOaZknsjjjZnMj8ZRFfdl3WOhxsQRvkIjmhb7x5ft9XyXhRlpGeEMwqFC7DIQ9jzlb6XVHYK26VbDzjCQd6STWm9QrLFJp+T6MbIFrpmj1ajtYNzz3l1aM2pNvrux+j1jm4QPfMZ85jvQ680QNAnh+7BV/4ZzgVACnRRstI1isPzIci3VGUP0yGP3VYakAOTGEUdJUiPip2oSmnc9pYzCq2rRW9aRJJpJ5XdE1Ao/2Z3h7mUeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H9pxsN/xG64p3bi9aOIV30e3IHoKfCUJq8wcGCnNS4=;
 b=l+g/0bX2Yl1g9jDxytOT7cWOL+FI0TVmKZiapc+bLQCYvmmMyViFORi5SsszIxJyqNWG1OMNsQ3X0wUzjRwwgJA9NgZvIoSSSkIQz42fVW/c2uCNxaOamaEx9yhfLqgzHJlodWcEVMbPS/9pUOPEt7xNz9S+mNqIcp3qwtrtJwMSAe2pjsWl2qTfSsFgkhoL7r4C1N+KCnoojevQyJalLXbPHYkrQxe0BC0yGThrXiVgYinD8q1L7JYlG4g6MeOJ/n7tVp2If5o6u34gEdvfPmjdbUz2Gk/LItHZoNgEmQTElU/9KsA8WP2dprLnn6H305KFQFlPphNHwV6nQSh62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H9pxsN/xG64p3bi9aOIV30e3IHoKfCUJq8wcGCnNS4=;
 b=LmDcuHrO5TwUKOb3165M99qoMEC/AEJu86Pl5pBWV4hsN5czLEydErGlvDoujZ5Hncg6rNsoynFR/kytysh8+0Z+Ot5G5xpQg22Vi+ziayU8g7IhE224htzlmsLf6G+Rxb/x2nwUJE8Jr918LOGhZ9uDuRnnqeKcldS1cBZxWDA=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2405.namprd10.prod.outlook.com (2603:10b6:910:3f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Tue, 11 May
 2021 10:59:52 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4108.031; Tue, 11 May
 2021 10:59:52 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Topic: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Thread-Index: AQHXRlGMHIH0DkuZxECo6Tfx0FCU/areHOMA
Date:   Tue, 11 May 2021 10:59:52 +0000
Message-ID: <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
In-Reply-To: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 592da943-d111-49f1-b760-08d9146be743
x-ms-traffictypediagnostic: CY4PR1001MB2405:
x-microsoft-antispam-prvs: <CY4PR1001MB24053D17CB563DC123FA416DFD539@CY4PR1001MB2405.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPMA3vat6yv8cRMe+vL9PonNzu9tlmurUZStXKOxswBArY9My0X4fcLK/nXWaQej1v4gyJyLijRC8fHSVBfwU3NPtv/HpSi0IJbVIisbtCrGgZhsm4MyoKLFYgiHoD06TnSO173iBTT2k4Nx7ohN1+RowagYs5kvO6RkGgU65iSnXrYOxQ8PhE1YSsKW/kUg8wfZ7nu3Amo6ZT/tY20KZNfv4G48PTuVNyTzdTU0aA92DI15FMfTPa5g4jGk5SEzyDQg9+Y0wVY0dKemCwS2K27e6kDcyLR58awDsRMz53FybTHaNTUBIR5kUsU3IDRJkX7+4S5O6sVgmn6VIHrHmjSzUTqRxtu3TXLlALSLGmBPV1PE4bfNsQTNt8WVbv+6iDtpWKL5GzfwbMkapdgmxzklP5w5om3bJsJx4SqVeBqNnpQaSBWdkp2XV6+8LKeQmBVxeSAXH8eM87aze0DF27f8DC7Wth7Z8fnBi3d0m2IhmGNXb1Q911PgPnayPzQpMoNhoh4OlvESF/ELRd9znvlX88zoUnxIWhB6XPXDnKSiHbIpz/iWErKZBjSaZk9NIwiIPEX4nQwH9134sQhQD2Fcj5C3Wl8GGI6PEz2d7m5QQr/1zLgpAYuZ462EoRSoFJlKbIbmZfzCoFL4M4NBW2V3NjMayrcWxzjAE3/ab78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6916009)(26005)(2906002)(71200400001)(66946007)(66556008)(122000001)(91956017)(76116006)(66476007)(186003)(66446008)(38100700002)(64756008)(83380400001)(66574015)(6506007)(316002)(8676002)(44832011)(6512007)(2616005)(8936002)(53546011)(4326008)(33656002)(86362001)(6486002)(54906003)(478600001)(36756003)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cy95dlNZdGtOaHlzU2J0VENFMFo0K29YR2dPdEE3VTdicjZtbDZwZnphQnY2?=
 =?utf-8?B?dkVkeHY4WnExa000QWdWL1JVMGgvSGpJaHI0M2ZCeEZmM2JBYTRzVFk4WnI4?=
 =?utf-8?B?RHVnSVJETkhIVWVkL0VTZWQyajdWYWNydjB5bTNram9ldmx0RW5JZzRxZFc3?=
 =?utf-8?B?R2hKcHIrUE1MaXdkZ0ovS1hRY204NXBFTHhQczlCaHd3VnRaN3ZNdm43Qlpm?=
 =?utf-8?B?UmRjZ1h3bzdVQW9FSW5LUnRhR2l2bEg4RHBvOHM5aGxEQXprWUNPYUNWdTl4?=
 =?utf-8?B?RXFnaG1YbW00M1h5cVlqYzZSTnc2MVZjenROM1ZxS2RLZGZpUVdmR0JkbEhq?=
 =?utf-8?B?SDRZaDJYa2IwSmNVWFBuUzQzaXlGVW8xelZLNzJIZjdjbU9EbnRxZURUWHpq?=
 =?utf-8?B?Q1IwN1ZJT2h2TWJRL2pEYjY5bE42Ry9tZVJhTzY3cUtrTjdPYjNheFEvWk5p?=
 =?utf-8?B?WnNnS211SjNLaUMyWmY1Y0tlaUplTmpoNWo4NE8zRjJyZ25qeTNHV21GUFhr?=
 =?utf-8?B?TDlKQVExL0hrUGxyMGdJNWVUZlh2a2J1MDlOaFdOUVJibGNGZWdXYUxYVVF6?=
 =?utf-8?B?a1lCTmQvU2pDSWIrWFdyYXpPcUdsYjBoN3hVemZkVGo1VWRKZ3Zza0RqU2o0?=
 =?utf-8?B?WTVQVlcwNTFISWU0OTBRRFo1QndUSkxUMHMxOUpXWnp5WlR0dkRaT2NLc2hi?=
 =?utf-8?B?ZDBnVjVTczNubU1pT0pnT1F4bFNyV0J3bmYvdWlXaWovR0JOMTA0YXJXUE8y?=
 =?utf-8?B?VGdrZG9qZWpReWtlNGZYSHI3QWVBbTEzR09ralhzaGtPMEVJQ2lmZ0FDTHJD?=
 =?utf-8?B?emZDSDM4ZHhZTGhycTFWdm9GVzNQRjJ4QjhwNDFIS1p6TVFldVFlOTJONFNB?=
 =?utf-8?B?VGE1bkdHMm13ZTk0Wms4ZVA5dHJJM1VqaGVvVjA3aFlGUjM4emR4OW1GMjZr?=
 =?utf-8?B?RGlUNTkvWitOSHhGK2NJblpqMllOVVhzSDZFd1Zvb2QxTXV4eUZOUmY1OU9r?=
 =?utf-8?B?bmNVeTFBUno1SzNJMTNIZDBUNkhKVWNqNlVTMXlxNCtUdjBaYWpUYnJMZm5j?=
 =?utf-8?B?UEgwQzNQeDNjdnAvRHAyamRDYTdJQUxERkJYaWc4ek5jKzc1TlVOKzg5dER1?=
 =?utf-8?B?MHplRm9yYnl2OWtDMzVpSERGR0Q4RjEyd3dQTUd3bFl1Z0VpQ29FOFFrSGFq?=
 =?utf-8?B?YnpUWDUzTWFVM1NHd0lzZ2FuQjZ1aSt1UURqbWFBaTJLbitzWUNsVDZOQXB2?=
 =?utf-8?B?WW0yL3FBTHJiVkdnMisxbE9OQU5Ub20rYTgwdElGZ3JBNVNHL3EzTXpmaC9L?=
 =?utf-8?B?NTEzdC9zbVBSQ2hKdlYwam9VNjNkTnA4WDlTZms0WGpaL0k4aXNVS2NhV2Y2?=
 =?utf-8?B?L2JjWERRL2ZHcFUzdlNCN2pJUlBJcGd6andMQ0pHYng5a0ZTYTg4bEVwNStn?=
 =?utf-8?B?ZHcxblRtYWxDdVJYUktZcVE4V1dCKzZ6YTVHNnh6UlVoOU1tRDBNUUlVK21N?=
 =?utf-8?B?L3cxMEM0ZTJlQ2k4VkJhbk5oUFRPMzdyUG1uN1pUdmpuTXhVaXg1a3FDSUxS?=
 =?utf-8?B?a3Z0cVZtd0RuUmhnMzBoTjNMRDlJOHJBajUyNnNmLzRIc2ppaHQ4OHM5QUJ4?=
 =?utf-8?B?alNRaTNqVkloSHMwRGlEUk51WmdjZkhyMFVyQXF2OUVWRWtadDRqUmY2aFlT?=
 =?utf-8?B?aGlUdElhYVZzUEcyZ3lodjI5Si9ZVDZsMFVWN2NPdFBoN3RhWUtnTG5qWHEx?=
 =?utf-8?B?cjEzWXZ4WVN2WU5qZFZ4ZCtBRDlja2xpOWJQWndwcDZJYlp5cE5JTFZGZGtm?=
 =?utf-8?B?dzB1NEVDTkhnTSt0QklyUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <33F48EE8D4795045A77772DDCBB64970@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592da943-d111-49f1-b760-08d9146be743
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 10:59:52.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+h2Nz4FTt53FLwtlV94GnWFg3y+dqKQooHCUvfJeA3OMQTrN3H3SMfgtxzTDJ2O5tEiqnwlmI4Dut4ijpwxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2405
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110084
X-Proofpoint-ORIG-GUID: xHjNenhUC2bQvKloIpBfsRxqxIM8ZabI
X-Proofpoint-GUID: xHjNenhUC2bQvKloIpBfsRxqxIM8ZabI
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110084
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTEgTWF5IDIwMjEsIGF0IDEyOjM2LCBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBGcm9tOiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0Budmlk
aWEuY29tPg0KPiANCj4gVGhlIHJkbWF2dCBRUCBoYXMgZmllbGRzIHRoYXQgYXJlIGJvdGggbmVl
ZGVkIGZvciB0aGUgY29udHJvbCBhbmQgZGF0YQ0KPiBwYXRoLiBTdWNoIG1peGVkIGRlY2xhcmF0
aW9uIGNhdXNlZCB0byB0aGUgdmVyeSBzcGVjaWZpYyBhbGxvY2F0aW9uIGZsb3cNCj4gd2l0aCBr
emFsbG9jX25vZGUgYW5kIFNHRSBsaXN0IGVtYmVkZGVkIGludG8gdGhlIHN0cnVjdCBydnRfcXAu
DQo+IA0KPiBUaGlzIHBhdGNoIHNlcGFyYXRlcyBRUCBjcmVhdGlvbiB0byB0d286IHJlZ3VsYXIg
bWVtb3J5IGFsbG9jYXRpb24gZm9yDQo+IHRoZSBjb250cm9sIHBhdGggYW5kIHNwZWNpZmljIGNv
ZGUgZm9yIHRoZSBTR0UgbGlzdCwgd2hpbGUgdGhlIGFjY2VzcyB0bw0KPiB0aGUgbGF0ZXIgaXMg
cGVyZm9ybWVkIHRocm91Z2ggZGVyZWZlbmNlZCBwb2ludGVyLg0KPiANCj4gU3VjaCBwb2ludGVy
IGFuZCBpdHMgY29udGV4dCBhcmUgZXhwZWN0ZWQgdG8gYmUgaW4gdGhlIGNhY2hlLCBzbw0KPiBw
ZXJmb3JtYW5jZSBkaWZmZXJlbmNlIGlzIGV4cGVjdGVkIHRvIGJlIG5lZ2xpZ2libGUsIGlmIGFu
eSBleGlzdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0Bu
dmlkaWEuY29tPg0KPiAtLS0NCj4gSGksDQo+IA0KPiBUaGlzIGNoYW5nZSBpcyBuZWVkZWQgdG8g
Y29udmVydCBRUCB0byBjb3JlIGFsbG9jYXRpb24gc2NoZW1lLiBJbiB0aGF0DQo+IHNjaGVtZSBR
UCBpcyBhbGxvY2F0ZWQgb3V0c2lkZSBvZiB0aGUgZHJpdmVyIGFuZCBzaXplIG9mIHN1Y2ggYWxs
b2NhdGlvbg0KPiBpcyBjb25zdGFudCBhbmQgY2FuIGJlIGNhbGN1bGF0ZWQgYXQgdGhlIGNvbXBp
bGUgdGltZS4NCj4gDQo+IFRoYW5rcw0KPiAtLS0NCj4gZHJpdmVycy9pbmZpbmliYW5kL3N3L3Jk
bWF2dC9xcC5jIHwgMTMgKysrKysrKystLS0tLQ0KPiBpbmNsdWRlL3JkbWEvcmRtYXZ0X3FwLmgg
ICAgICAgICAgfCAgMiArLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRt
YXZ0L3FwLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L3FwLmMNCj4gaW5kZXggOWQx
M2RiNjgyODNjLi40NTIyMDcxZmMyMjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9yZG1hdnQvcXAuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L3Fw
LmMNCj4gQEAgLTEwNzcsNyArMTA3Nyw3IEBAIHN0cnVjdCBpYl9xcCAqcnZ0X2NyZWF0ZV9xcChz
dHJ1Y3QgaWJfcGQgKmlicGQsDQo+IAlpbnQgZXJyOw0KPiAJc3RydWN0IHJ2dF9zd3FlICpzd3Eg
PSBOVUxMOw0KPiAJc2l6ZV90IHN6Ow0KPiAtCXNpemVfdCBzZ19saXN0X3N6Ow0KPiArCXNpemVf
dCBzZ19saXN0X3N6ID0gMDsNCj4gCXN0cnVjdCBpYl9xcCAqcmV0ID0gRVJSX1BUUigtRU5PTUVN
KTsNCj4gCXN0cnVjdCBydnRfZGV2X2luZm8gKnJkaSA9IGliX3RvX3J2dChpYnBkLT5kZXZpY2Up
Ow0KPiAJdm9pZCAqcHJpdiA9IE5VTEw7DQo+IEBAIC0xMTI1LDggKzExMjUsNiBAQCBzdHJ1Y3Qg
aWJfcXAgKnJ2dF9jcmVhdGVfcXAoc3RydWN0IGliX3BkICppYnBkLA0KPiAJCWlmICghc3dxKQ0K
PiAJCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gDQo+IC0JCXN6ID0gc2l6ZW9mKCpxcCk7
DQo+IC0JCXNnX2xpc3Rfc3ogPSAwOw0KPiAJCWlmIChpbml0X2F0dHItPnNycSkgew0KPiAJCQlz
dHJ1Y3QgcnZ0X3NycSAqc3JxID0gaWJzcnFfdG9fcnZ0c3JxKGluaXRfYXR0ci0+c3JxKTsNCj4g
DQo+IEBAIC0xMTM2LDEwICsxMTM0LDEzIEBAIHN0cnVjdCBpYl9xcCAqcnZ0X2NyZWF0ZV9xcChz
dHJ1Y3QgaWJfcGQgKmlicGQsDQo+IAkJfSBlbHNlIGlmIChpbml0X2F0dHItPmNhcC5tYXhfcmVj
dl9zZ2UgPiAxKQ0KPiAJCQlzZ19saXN0X3N6ID0gc2l6ZW9mKCpxcC0+cl9zZ19saXN0KSAqDQo+
IAkJCQkoaW5pdF9hdHRyLT5jYXAubWF4X3JlY3Zfc2dlIC0gMSk7DQo+IC0JCXFwID0ga3phbGxv
Y19ub2RlKHN6ICsgc2dfbGlzdF9zeiwgR0ZQX0tFUk5FTCwNCj4gLQkJCQkgIHJkaS0+ZHBhcm1z
Lm5vZGUpOw0KPiArCQlxcCA9IGt6YWxsb2Moc2l6ZW9mKCpxcCksIEdGUF9LRVJORUwpOw0KDQpX
aHkgbm90IGt6YWxsb2Nfbm9kZSgpIGhlcmU/DQoNCg0KVGh4cywgSMOla29uDQoNCj4gCQlpZiAo
IXFwKQ0KPiAJCQlnb3RvIGJhaWxfc3dxOw0KPiArCQlxcC0+cl9zZ19saXN0ID0NCj4gKwkJCWt6
YWxsb2Nfbm9kZShzZ19saXN0X3N6LCBHRlBfS0VSTkVMLCByZGktPmRwYXJtcy5ub2RlKTsNCj4g
KwkJaWYgKCFxcC0+cl9zZ19saXN0KQ0KPiArCQkJZ290byBiYWlsX3FwOw0KPiAJCXFwLT5hbGxv
d2VkX29wcyA9IGdldF9hbGxvd2VkX29wcyhpbml0X2F0dHItPnFwX3R5cGUpOw0KPiANCj4gCQlS
Q1VfSU5JVF9QT0lOVEVSKHFwLT5uZXh0LCBOVUxMKTsNCj4gQEAgLTEzMjcsNiArMTMyOCw3IEBA
IHN0cnVjdCBpYl9xcCAqcnZ0X2NyZWF0ZV9xcChzdHJ1Y3QgaWJfcGQgKmlicGQsDQo+IA0KPiBi
YWlsX3FwOg0KPiAJa2ZyZWUocXAtPnNfYWNrX3F1ZXVlKTsNCj4gKwlrZnJlZShxcC0+cl9zZ19s
aXN0KTsNCj4gCWtmcmVlKHFwKTsNCj4gDQo+IGJhaWxfc3dxOg0KPiBAQCAtMTc2MSw2ICsxNzYz
LDcgQEAgaW50IHJ2dF9kZXN0cm95X3FwKHN0cnVjdCBpYl9xcCAqaWJxcCwgc3RydWN0IGliX3Vk
YXRhICp1ZGF0YSkNCj4gCWt2ZnJlZShxcC0+cl9ycS5rd3EpOw0KPiAJcmRpLT5kcml2ZXJfZi5x
cF9wcml2X2ZyZWUocmRpLCBxcCk7DQo+IAlrZnJlZShxcC0+c19hY2tfcXVldWUpOw0KPiArCWtm
cmVlKHFwLT5yX3NnX2xpc3QpOw0KPiAJcmRtYV9kZXN0cm95X2FoX2F0dHIoJnFwLT5yZW1vdGVf
YWhfYXR0cik7DQo+IAlyZG1hX2Rlc3Ryb3lfYWhfYXR0cigmcXAtPmFsdF9haF9hdHRyKTsNCj4g
CWZyZWVfdWRfd3FfYXR0cihxcCk7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3JkbWEvcmRtYXZ0
X3FwLmggYi9pbmNsdWRlL3JkbWEvcmRtYXZ0X3FwLmgNCj4gaW5kZXggODI3NTk1NGY1Y2U2Li4y
ZTU4ZDVlNmFjMGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcmRtYS9yZG1hdnRfcXAuaA0KPiAr
KysgYi9pbmNsdWRlL3JkbWEvcmRtYXZ0X3FwLmgNCj4gQEAgLTQ0NCw3ICs0NDQsNyBAQCBzdHJ1
Y3QgcnZ0X3FwIHsNCj4gCS8qDQo+IAkgKiBUaGlzIHNnZSBsaXN0IE1VU1QgYmUgbGFzdC4gRG8g
bm90IGFkZCBhbnl0aGluZyBiZWxvdyBoZXJlLg0KPiAJICovDQo+IC0Jc3RydWN0IHJ2dF9zZ2Ug
cl9zZ19saXN0W10gLyogdmVyaWZpZWQgU0dFcyAqLw0KPiArCXN0cnVjdCBydnRfc2dlICpyX3Nn
X2xpc3QgLyogdmVyaWZpZWQgU0dFcyAqLw0KPiAJCV9fX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9z
bXA7DQo+IH07DQo+IA0KPiAtLSANCj4gMi4zMS4xDQo+IA0KDQo=
