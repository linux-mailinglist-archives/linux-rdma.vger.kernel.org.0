Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCB3B7371
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhF2NsQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 09:48:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64152 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbhF2NsN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 09:48:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TDjdrj004400;
        Tue, 29 Jun 2021 13:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+hkRmQve9nMFIpgi2QwCv4bk4LaLLs7mBPlTYCybt6A=;
 b=CAF8GP8ABi1Ra8masP4mmCIC69ZGI+kWiL7UYp5zFJaSZ43GEckfqtaWS9lMs9nRdaPP
 PRaaGOUQLdFHL1xwy3GDKLD1hCPoFoaDMUuLqpviRRJoyNekWJ7QRQLc+U3n0qvnfJZd
 cdYuCR4jq/5iuxH6eAkn8MRltGjAArXuyDL648IAy0Wl31rbjbudTgnhzVM0vIcQOM18
 NCrjBoAwJFaBicu/ik4h1RT6CbIuPwHrgCUxf5z9AnfPR6su0r/sBtPs/akdhoHmpaz/
 b5VbV0nQwjJJTOgEfyopWcKfQXdVVFC+2CqUKsdOhjolVa3v21r0BASzU1sGmGYfcoT2 eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39fpu2hjue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:45:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15TDjeO6046994;
        Tue, 29 Jun 2021 13:45:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3030.oracle.com with ESMTP id 39dsbxvxus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Jun 2021 13:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIZcuPATb3Od6vGY5aQC5fC3Rx9LCpbTlM2m5G7Wp0TOehY3jWfUXREDBRntefp7YgTr0L/W9B+U0eboC04XxxvhqBuZsScAoY46KXdbjyOi5Xgz1Qs6+TJ6mgKyJbz8NV8NB+ZaXfITnOB5KOga5bPmmxh9247KeZpos/JMmdSjk68mgGPIqQbaFndB7z9duVoOPcgFwf4nFNs1k5AJgRqnjqEWUb4qZ29ugo6odXSIVdGbkYgGA6VczFvpFOr+9xSlp7Fi8G/YDrpilaFFMfRk32sBlZa6xSiyCp3b89P2m87IGGnGL87VhusAyMkJh3F93b8C6Sx5zL2mBDojvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hkRmQve9nMFIpgi2QwCv4bk4LaLLs7mBPlTYCybt6A=;
 b=UiAMe5j6rK+ZxMNBhYwhlt25iRYcyA9Wm55GRTrgI9vUlG3xK18w0t7YnCiXauy+P02DxKZA6dLbIdg4DWef2pAbL6yzslyzcALojmyAtkK8ycKV8HjQQynhsUMhTnPqepuBd42ZBGSoXNKMJNT/j6rTEhvP4M65sN+ZneSeVJa2Yrzt1wiLWnlJFQDD13R4aLi04Yc3H2VJnAs0hna/Yf5wOCf9msx/r1KtfVHK1jFITFXKnhOIRRVfws+qDnt11ez7Nr/sFFmMhqaDi6HVoyNJ3CIFZ1C39kOvp3yR0xB1Xd4zfAwWbNAyQprUyYsqPhVRMn+NgCUSMxMawsfIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hkRmQve9nMFIpgi2QwCv4bk4LaLLs7mBPlTYCybt6A=;
 b=vhF/W01pNMWElkPKn2h1sLm8BXZJ0VilRsHqwRPl2mnTa9yGgot3SnFqmwlnbzYUEfRA8KXs0ICQcAJ0WjYduAQFHsjnuHGmc4qMSEcfHUlH7K3TwWA3Usg1Z8JuezLaLUHB5cb01g2I7+8FmqLfzuK6ii5XglbUXtfEy8EWusY=
Received: from DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17)
 by DM5PR10MB1818.namprd10.prod.outlook.com (2603:10b6:3:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 13:45:35 +0000
Received: from DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::8833:8136:cf8b:5f00]) by DS7PR10MB4863.namprd10.prod.outlook.com
 ([fe80::8833:8136:cf8b:5f00%9]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 13:45:35 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Topic: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Index: AQHXQa3Y4CAWkou9VES/lh4Y7MmmMarc+byAgAAeRYCAAAWSgIBOOSGA
Date:   Tue, 29 Jun 2021 13:45:35 +0000
Message-ID: <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
In-Reply-To: <20210510191249.GF1002214@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [92.221.252.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ca7963-9381-4fa9-15f6-08d93b042bfc
x-ms-traffictypediagnostic: DM5PR10MB1818:
x-microsoft-antispam-prvs: <DM5PR10MB1818AE8D54AD50B20CCF8C11FD029@DM5PR10MB1818.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:76;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1ZlqrFiA7rtQm4h1Z9lUgD2RNrtihFwV4Pdk+H4gtYEIueG+eGlrY0oEzv4sH19y5xzR1qlky81zAbOzUzgbZbChld9LUql3Og/Mt7zkuqAQUAZIyb/1mpCqRXRtCrFmgq34mv+O+nW1zhTy5ntU0ZGck59Lfuha/z5vGqirNpUu6AfAomWfCpfpYrH87BJs+2PfugHvBIXssEdFYmVv1NNA9f9Ex1rR6o+Pj27HPm9q0OlDtcQfJADl0X1g4qzQ/vRUvYpnXo9s9A6SowxqzXDz23XM4jq0JHPsWIjzBgx1l9PaHluULuwbrNp+a8rZnY1tSglMxPQ0VWHNvnM1j6kIJHqOfzbeVTLn8q5vdbZAzENLv4w9R9AVxow7EKqhcDaAHg6LT0hTXtye9ckpv6Fu9DKQcAPaY3WjMETfu223HW49LKKB3pXt23VXAubzetwqbqkws+0mzfkkjk+MS9OQLzA+a3GA6gcMGBtVVupAui64iziAs/Vh+LFrZj32Nn8tq6tGxvn9PQr/fiWMklkwXzxMPpu9wvq428GnOJAHE8ceYrcDeH4DMVHJC7zkKBRQ11ys/5NwGAf61nw5ZoQKOQ1Fip//YGbn7SqktQe96bjdqeKUEIVg1bAnDzbheew5LejT6I7VeFEH5myP2vIHUeaSebmXE6fuS0r+DhhXCZdyrmZuJBPTX6mJ4u77RpXWglug0n0QKGA+2uTmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4863.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(186003)(86362001)(6512007)(71200400001)(122000001)(478600001)(26005)(38100700002)(44832011)(5660300002)(6506007)(53546011)(33656002)(36756003)(316002)(6486002)(54906003)(2616005)(4326008)(66476007)(66556008)(15650500001)(83380400001)(66574015)(2906002)(66946007)(64756008)(66446008)(76116006)(91956017)(8676002)(8936002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0dYUENZVktwOVE1TzdZUlVWZ2xZQVluaG5qQnZUaXFoclA3dlJzWEc0UnY2?=
 =?utf-8?B?dlFneHBSdEpaN3E1Y201OXE3WXIyV0FLUXgveEF0UUs2UHRLZXdsMDU0RzJo?=
 =?utf-8?B?ekFWRnRjaUxQNVVhZWFOYk00YTNQeG9nNytiMFZJUzQ1dUlvamRPYndBV3Bs?=
 =?utf-8?B?OXdnSVV2djMvWkdSZmdjSnNtNjlZS2ZyMUdWdDhTNTRJZ3hycmplSjNKb3Iv?=
 =?utf-8?B?MGhEUGFyeFFPOUVaZTgvMjVEOXpqNmtYU1lCajdFVG5sSUozZEZhK0VXTEhx?=
 =?utf-8?B?eG9PQ3BqU2hBeXlpZDVCa085THBxcmhlblpFc1E2cXpDY1dDUEk3aThsbkRr?=
 =?utf-8?B?VnUrZzB0OWs3QmM5cTh3bng3R0wwUzJOTDdLMms4UnNRV2paVW0yY0JZaWhq?=
 =?utf-8?B?ZWZSSFJtQUFFVlhDN09hcHJwTXdrR05nTUNTc1phMXI5WmNIZG5EU1MrQkY5?=
 =?utf-8?B?bXA5eU9MS3pSR21RRHFaeElUTnFOSDQ5QnJJWGR5QzdrVmNmNEhNTGVjdzkx?=
 =?utf-8?B?VnIzSzhHZzdqSXF5U3B1MnprVk5tbHVsc2lSQUdkc1owWFdXN2QwTURVck5x?=
 =?utf-8?B?YklSZUFSanFhRlp2YTQvQ3E2Qy9qT3hDSVZ5ZXRpWTFvc2N3VzR4a1IrRERt?=
 =?utf-8?B?MTErYy91RWNMQ1g5WEZFZ3VaTzk4YVpBdTRTSFYva0p2NDFJdkgwbEJvUll1?=
 =?utf-8?B?U2pqMVdwY1phZ1JHUGJrdHBTVFllYnUwM1JDM0RFY3A1Y2FlZUZEQmFHVTRX?=
 =?utf-8?B?bE4yUDJHVCtjTzJrMExpdjR1a2IxTkxGMWVlQ0xmK2htZlZlTWZtQ29tTnVE?=
 =?utf-8?B?eHo3V0Yyb2VReW0vQWVyNmYvWTJ5OG9jcXdOcFFTSlZTZlY1MFFjYlVDT3VH?=
 =?utf-8?B?elFuSk1HM2ZCNHhkc3FBRUN4SHM1Q2wrL280WXBxYStHelJCWTRNV1orOElv?=
 =?utf-8?B?d1k3eFBKTjJ3TlRFUStHUXM2MXczcmlDSGNmWU1Tc3BzMjlnNSs0cGlhRmtm?=
 =?utf-8?B?Y2o0MjExWWFRWkQ2a0UzNWp0TldWZnNFNXVxdXBsQTc2bDBTaC9tcmJDVkNZ?=
 =?utf-8?B?TjEvRjd0cE95VlIxQTg3bXlFMDVubWpKcm5WYjZGOGt1TzhoUC9kSS9uNHlH?=
 =?utf-8?B?RUhpUlE3dXFKcW5SNllGV1JUaHg1V0lDWnRUWWU5OHhkR2xFSjczc1VEdWhk?=
 =?utf-8?B?TUNiY2QwTzFNcnIrVXZLbUgzcnI4cFB6UEtYYUNwZ21YYUF0VFpOd3JyNXVY?=
 =?utf-8?B?WWlUNHBERm0zdTZLK25Ya3hySmtiZjd5amZEUXk1SVdxajhXKzVnUnJMWmxk?=
 =?utf-8?B?L3NhUzFSNWdlcGRxbGpCOGJnWG0rSnRnV2MxZ056M0xMU21LYkl2dE9MSjhh?=
 =?utf-8?B?azhDdUw0SklKS2FjSkx4cjRJYUJoZnRvYVorK25ROVNWTzRFWGYzOWdsOFU0?=
 =?utf-8?B?QUtMMTNEa2hnZVNldVZzUHJyQ1prMFRSZnRtSkE1cEhUaUE1WVlPYjlhNlBO?=
 =?utf-8?B?YmZPNGJabXpqMnBJcWo3dHYyMmFOOUZuTDBNL2pQclhiR3JncXpUVUJ5UkEr?=
 =?utf-8?B?TDA3WWRsSDM1OXFRMzVlc3JhQnJuZk9Mb3ZWUVRkaDd0eG1WaHZxMUZaL2dX?=
 =?utf-8?B?WmtvK3ZCSWJXNnJ6R2ZpKzFvK0ZkRlh5RXFDamMyeHI0eUU1dHFhMGRlRS9I?=
 =?utf-8?B?UlJIMlZGM1ZRei81V0Yvc1VuekFYRFJTa1JPaFRMTElWZXptVmdEaWJRcDRG?=
 =?utf-8?B?dVNLa1I0VVdoNy9ITk4zQkhyRHN0SVczeXFjNGRld3NsV1ZwSEExYi9kSlF6?=
 =?utf-8?B?VFB4R2ZhQjcyMzVXczVFQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB90325D8146814BB121E062814DA778@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4863.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ca7963-9381-4fa9-15f6-08d93b042bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 13:45:35.2389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdqxNzxBd1hQjSrR6jmYSa6h89fncX6JSxokvWTVbYPU2BKN9lWP4x9jElPmnjR34KW43VCnsoSTMsntGrYv7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1818
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10029 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290093
X-Proofpoint-GUID: 2lH_d3vgLlXaREkEETiK95ltZabSkEbg
X-Proofpoint-ORIG-GUID: 2lH_d3vgLlXaREkEETiK95ltZabSkEbg
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgTWF5IDIwMjEsIGF0IDIxOjEyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWF5IDEwLCAyMDIxIGF0IDA2OjUyOjU0UE0g
KzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMTAgTWF5IDIwMjEs
IGF0IDE5OjA0LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPiB3cm90ZToNCj4+PiAN
Cj4+PiBPbiBXZWQsIE1heSAwNSwgMjAyMSBhdCAwMjo1NDowMVBNICswMjAwLCBIw6Vrb24gQnVn
Z2Ugd3JvdGU6DQo+Pj4+IFRoZXJlIGFyZSB0aHJlZSBjb25kaXRpb25zIHRoYXQgbXVzdCBiZSBm
dWxmaWxsZWQgaW4gb3JkZXIgdG8gY29uc2lkZXINCj4+Pj4gYSBwYXJ0aXRpb24gbWF0Y2guIFRo
b3NlIGFyZToNCj4+Pj4gDQo+Pj4+ICAgICAxLiBCb3RoIFBfS2V5cyBtdXN0IHZhbGlkDQo+Pj4+
ICAgICAyLiBBdCBsZWFzdCBvbmUgbXVzdCBiZSBhIGZ1bGwgbWVtYmVyDQo+Pj4+ICAgICAzLiBU
aGUgcGFydGl0aW9ucyAobG93ZXIgMTUgYml0cykgbXVzdCBtYXRjaA0KPj4+PiANCj4+Pj4gSW4g
c3lzdGVtIGVtcGxveWluZyBib3RoIGxpbWl0ZWQgYW5kIGZ1bGwgbWVtYmVyc2hpcCBwb3J0cywg
d2Ugc2VlDQo+Pj4+IHRoZXNlIGZhbHNlIHdhcm5pbmcgbWVzc2FnZXM6DQo+Pj4+IA0KPj4+PiBS
RE1BIENNQTogZ290IGRpZmZlcmVudCBCVEggUF9LZXkgKDB4MmEwMCkgYW5kIHByaW1hcnkgcGF0
aCBQX0tleSAoMHhhYTAwKQ0KPj4+PiBSRE1BIENNQTogaW4gdGhlIGZ1dHVyZSB0aGlzIG1heSBj
YXVzZSB0aGUgcmVxdWVzdCB0byBiZSBkcm9wcGVkDQo+Pj4+IA0KPj4+PiBldmVuIHRob3VnaCB0
aGUgcGFydGl0aW9uIGlzIHRoZSBzYW1lLg0KPj4+PiANCj4+Pj4gU2VlIElCVEEgMTAuOS4xLjIg
U3BlY2lhbCBQX0tleXMgYW5kIDEwLjkuMyBQYXJ0aXRpb24gS2V5IE1hdGNoaW5nIGZvcg0KPj4+
PiBhIHJlZmVyZW5jZS4NCj4+Pj4gDQo+Pj4+IEZpeGVzOiA4NDQyNGE3ZmM3OTMgKCJJQi9jbWE6
IFByaW50IHdhcm5pbmcgb24gZGlmZmVyZW50IGlubmVyIGFuZCBoZWFkZXIgUF9LZXlzIikNCj4+
Pj4gU2lnbmVkLW9mZi1ieTogSMOla29uIEJ1Z2dlIDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4N
Cj4+Pj4gZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY21hLmMgfCAyMiArKysrKysrKysrKysrKysr
KysrKy0tDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQ0KPj4+IA0KPj4+IFdoYXQgaXMgdGhpcyB0cnlpbmcgdG8gZml4Pw0KPj4gDQo+PiBUaGUg
ZmFsc2Ugd2FybmluZyBtZXNzYWdlcy4gVGhlIHdyb25nIHdheSB0aG91Z2g6LSkNCj4+IA0KPj4+
IElNSE8gaXQgaXMgYSBidWcgb24gdGhlIHNlbmRlciBzaWRlIHRvIHNlbmQgR01QcyB0byB1c2Ug
YSBwa2V5IHRoYXQNCj4+PiBkb2Vzbid0IGV4YWN0bHkgbWF0Y2ggdGhlIGRhdGEgcGF0aCBwa2V5
Lg0KPj4gDQo+PiBUaGUgYWN0aXZlIGNvbm5lY3RvciBjYWxscyBpYl9hZGRyX2dldF9wa2V5KCku
IFRoaXMgZnVuY3Rpb24NCj4+IGV4dHJhY3RzIHRoZSBwa2V5IGZyb20gYnl0ZSA4LzkgaW4gdGhl
IGRldmljZSdzIGJjYXN0DQo+PiBhZGRyZXNzLiBIb3dldmVyLCBSRkMgNDM5MSBleHBsaWNpdGx5
IHN0YXRlczoNCj4gDQo+IHBrZXlzIGluIENNIGNvbWUgb25seSBmcm9tIHBhdGggcmVjb3JkcyB0
aGF0IHRoZSBTTSByZXR1cm5zLCB0aGUgYWJvdmUNCj4gc2hvdWxkIG9ubHkgYmUgdXNlZCB0byBm
ZWVkIGludG8gYSBwYXRoIHJlY29yZCBxdWVyeSB3aGljaCBjb3VsZCB0aGVuDQo+IHJldHVybiBi
YWNrIGEgbGltaXRlZCBwa2V5Lg0KPiANCj4gRXZlcnl0aGluZyB0aGVyZWFmdGVyIHNob3VsZCB1
c2UgdGhlIFNNJ3MgdmVyc2lvbiBvZiB0aGUgcGtleS4NCg0KUmV2aXNpdGluZyB0aGlzLiBJIHRo
aW5rIEkgbWlzLWludGVycHJldGVkIHRoZSBzY2VuYXJpbyB0aGF0IGxlZCB0byB0aGUgUF9LZXkg
bWlzbWF0Y2ggbWVzc2FnZXMuDQoNClRoZSBDTSByZXRyaWV2ZXMgdGhlIHBrZXlfaW5kZXggdGhh
dCBtYXRjaGVkIHRoZSBQX0tleSBpbiB0aGUgQlRIIChjbV9nZXRfYnRoX3BrZXkoKSkgYW5kIHRo
ZXJlYWZ0ZXIgY2FsbHMgaWJfZ2V0X2NhY2hlZF9wa2V5KCkgdG8gZ2V0IHRoZSBQX0tleSB2YWx1
ZSBvZiB0aGUgcGFydGljdWxhciBwa2V5X2luZGV4Lg0KDQpBc3N1bWUgYSBmdWxsLW1lbWJlciBz
ZW5kcyBhIFJFUS4gSW4gdGhhdCBjYXNlLCBib3RoIFBfS2V5cyAoQlRIIGFuZCBwcmltYXJ5IHBh
dGhfcmVjKSBhcmUgZnVsbC4gRnVydGhlciwgYXNzdW1lIHRoZSByZWNpcGllbnQgaXMgb25seSBh
IGxpbWl0ZWQgbWVtYmVyLiBTaW5jZSBmdWxsIGFuZCBsaW1pdGVkIG1lbWJlcnMgb2YgdGhlIHNh
bWUgcGFydGl0aW9uIGFyZSBlbGlnaWJsZSB0byBjb21tdW5pY2F0ZSwgdGhlIFBfS2V5IHJldHJp
ZXZlZCBieSBjbV9nZXRfYnRoX3BrZXkoKSB3aWxsIGJlIHRoZSBsaW1pdGVkIG9uZS4NCg0KVGhl
IENNQSB3aWxsIHRoZW4gZ2l2ZSBhIHdhcm5pbmcgbWVzc2FnZSwgYmVjYXVzZSB0aGUgUF9LZXkg
aW4gdGhlIHByaW1hcnkgcGF0aCBhbmQgdGhlIG9uZSBpbmNvcnJlY3RseSBhc3N1bWVkIHRvIGJl
IGluIHRoZSBCVEgsIGRvZXNuJ3QgbWF0Y2guDQoNClRoZSBwb2ludCBpcyB0aGF0IGNtX2dldF9i
dGhfcGtleSgpIG1heSByZXR1cm4gdGhlIGxpbWl0ZWQgbWVtYmVyLCBldmVuIHRob3VnaCB0aGUg
cGFja2V0IG9uIHRoZSB3aXJlIGhhZCB0aGUgZnVsbC1tZW1iZXIgcGFydGl0aW9uIGluIGl0J3Mg
QlRIIFBfS2V5Lg0KDQpTbywgSSB0aGluayBteSBmaXJzdCBjb21taXQgaGVyZSBpc24ndCB0aGF0
IGJhZCBhZnRlciBhbGwgOi0pDQoNCg0KVGh4cywgSMOla29uDQoNCg==
