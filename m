Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35644399DC6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFCJb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 05:31:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Jun 2021 05:31:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1539Dr7I155595;
        Thu, 3 Jun 2021 09:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oye7wMfkVISlrHmKwmKayXIAEnGrbzYSrrdCoLKYubc=;
 b=CfLrNS2GCvtu1SFNnrb0DGkhJzH4tWsAuBvbsIYmvJrro0S9qCPV+I8msHAAA2ZIMW80
 dewZKYvRoegPlqaWTxmcOVrJW3hw3dTSA2dt5Tsosl7Bx0e0H87pm/LwSJaCJKT1zmhq
 kf4+5BH0ezgyiOItm1om0PAA/noHYAy2uJaFvVbNh5EWhrONfVvuPqUNR63o0pAdmztD
 Jnaz9Aomb8eja4/2skMDGZ6lhiBfCajhUEwz8PRP3/L3I47UOJtT6FipdqPopD87VS2C
 hPYjnf9byGVXaFUd4UzdqFKGlzJQN3UaL5IPyicNm76ZOGRIhicjy6dUnCnzhWpU8T03 ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38ud1sju5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 09:29:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1539FUwC076027;
        Thu, 3 Jun 2021 09:29:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 38udeeepv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Jun 2021 09:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhLEc93pf3DE7tsgXrI1KbmfcsOrmbPxttTwC4nhI63TaxFKs6RpPaL5fwV7FuhrANeYWmFDfdOunyoH1mQWhs/UUKV4Soq0XmMDRI/TaqQB2VvkMmqf/Yx2VoXFuakCNqb0ZjFTChD2+zxA6XRQ0Mdxlqqyyto2U6n3/AZ929KRxvnCnlAXjTjcVNr3JejM7eRdXrRmuBle+tvjNNQ8r5nVBIsyL10qduiHlOlR5IpQIpQtDZAXBB9AecHs1Wp2ovkMYDbGCsQYJEgXlZN9/3KpRnf+H2JcQHqheDdb4YCUZRyTJiiJB65/P7qifHSoHoeOmUGtYx3ICEbZVLFM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oye7wMfkVISlrHmKwmKayXIAEnGrbzYSrrdCoLKYubc=;
 b=K57ypQzdpwFyyxiQqCwIRRUdZcQ7r9+bjY0+0a4XxlOJpCg2EmfboFONuNrPZj/NkovmqMjnPanspoqEAzlTN3rJvdaTSL66DWdLUfl+yZxwlhbecbVf4GgqkLr3wGaJHBpmybXOUWB5yt4rZFhMXzF6TEeAdMvtSaCvuU9uY9BBhaQQ8+nq4PLgPkm0VoJu9v14YbRrzN5uGwGeavMMKZDJlsyFXotYNFOpaA+0cAF+17NDQuofmurYZyF43QMZlunjNoecw3bUcCF87Yen5ZL4ojijhPQ//qsoNETt9Mvo4CSc8xaBEAl3Kn/vrnarGr4eUkvtMkeiSJu3lS8IIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oye7wMfkVISlrHmKwmKayXIAEnGrbzYSrrdCoLKYubc=;
 b=aZ/15vpec8qUd7k6UW+q6SINVENBQfbWZy6ahCN7OmZkyDlhkrmZ5Si/iwvQMWaxQPzElxI1zRqbA9UxeoVSf7+CgK7vokdNQ248VDkoiYZeJNZ94PizjY1n6Y1qywdXEKV6/BlAEq5PIXJonjgwJE2Yc2rpXYxBdiONhYMSBqI=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR10MB1766.namprd10.prod.outlook.com (2603:10b6:910:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 3 Jun
 2021 09:29:33 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::2cda:5611:238a:17a3%8]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 09:29:32 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Topic: [PATCH v2 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices
Thread-Index: AQHXWETJKd1twDrD1UCPHUswQ9RvnasB/04AgAAGEwA=
Date:   Thu, 3 Jun 2021 09:29:32 +0000
Message-ID: <D188B984-4B47-4992-80E6-6927ADC3DA26@oracle.com>
References: <20210603065024.1051-1-anand.a.khoje@oracle.com>
 <20210603065024.1051-4-anand.a.khoje@oracle.com> <YLib5BhTX6tEMTfe@unreal>
In-Reply-To: <YLib5BhTX6tEMTfe@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57b8ad06-d79d-43ca-1d2f-08d92672188f
x-ms-traffictypediagnostic: CY4PR10MB1766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR10MB1766478C87C76ECF3CBC0D78FD3C9@CY4PR10MB1766.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPEBJqKKuPi7HWFOUroGoahnGvxRU7N6b0x9fWzA5eo2x414HOkeuaxSf31DQ0Z37rLHxL/OO58VNvPVs8fMt+LV+HoCf4PQF+OKMb9V/2BJqIO+l8oilhCzIWK3wKFwRS2Xc/QW12h1TnAs26KWrl+QVa6NZKQZo07i6xNvQcPqa3nKPIGV51zLXL1Lgujyjg9rq/7xzbNpPBQJcXWOou/rSyG8zenXLKJOaId9see8hf57cPv3/VLVH8NggUPCWawpWZxcHeh9qNDjp6gVoJGwpYEVwcvCzlDinclrf5Aagmo4uQfU2OW6bbXmekRVd7murpuLtblaRCdDEiK39AUU4GONDiMm8PVg+uhxuKTy8kt6yI3n0Puq/OQaIEu37yLuDl9mR0hjJ6Tk8YCBY8vOy4TrQ98j239JHJRRUJlII13rlSPoHlpRb7d729X7w0A3GJ+c7B8cQ7iH+fVbdKV9kG/ijGuAB8G96fHse02ULb+l4guIVu0OWXqY0q8oygb8f5pFswhj2dtXjT4v4cfBfIuFiEeED78hNak0LmmSpgdzC9KmOtdG6G1Uk27tfMWt8dIwqZU2XQyN+gM1wz7uA6tx6+I181i1nM2M7rLVBSznr1puecaQ3RX/RXmCIaB9gk3y5HgA9CP84sdD0qze9y2R1528/33pN7b+dPY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(396003)(136003)(2616005)(122000001)(66574015)(44832011)(5660300002)(26005)(478600001)(64756008)(6506007)(4326008)(66556008)(186003)(33656002)(66446008)(83380400001)(38100700002)(53546011)(66946007)(66476007)(6486002)(91956017)(316002)(54906003)(76116006)(2906002)(8676002)(8936002)(71200400001)(86362001)(36756003)(6916009)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OGNWUEFST0cyUm40M3lKMks1dU5vN3AyYS9MUUxGYXJBWmRkck95K3lLODk5?=
 =?utf-8?B?a0MyYzlQSU5vczAvc2JuUWtqeWxEU292UXFzQTdsejlkUXlZQ3BPUHBXa25G?=
 =?utf-8?B?Z25RbFBYaVhIaHVESjNPSnFSUmJnckxzN0tvRHVFQTVqMVVwZHplQXNhRGJD?=
 =?utf-8?B?dUgveGVnVDh1T2tRRVhxbnk0Y0ZWSjJXVHpHREpjdGFUbEtCTjJ4eUxQNWtL?=
 =?utf-8?B?cVFjUkhFcEtzNm5oUG4yTW9ZT1d0QTQyN1pHUEFyRjl1cklBaTVuMWVaY0tm?=
 =?utf-8?B?WUxmZG50KzdScmRpNktBMHVtNk80WVBBNUtNOVRQSGpSUHlRWUhjWnJVVXFm?=
 =?utf-8?B?MGQ5TVFFbU95Q09zbzl2b2JiYzhER1lzQU5WT2xHZmhvVkhLNDR1amIvRHU5?=
 =?utf-8?B?SEVUYjF5QjZlM25NNTV3blNEQzYySzlYYjVWKytlVFFVeE9RcjdLUUdkYTJv?=
 =?utf-8?B?NThJZVNpdHpoV0RiWFVTQ3IyQS9VMlM2WFZsSGRJVlRoUVArR3Q0Y2p5QUVO?=
 =?utf-8?B?aGJtWUI5U1hGbDUrTlhZQjQxbERJMFVNOW5QUXFQN0tCTE03T25PeVBBTVZk?=
 =?utf-8?B?V0xyRU9oeVZGYk9UWUFwckM0aTVKN2lMRFRXVkRRbUFBeS9jM0VXdVpBVUFU?=
 =?utf-8?B?dk45YTFYQkgwTWhBZEJXbXhsL21CSUtQdHh2MnVoN3BqMjQ0N3c0TkZvTVpB?=
 =?utf-8?B?Yk1CM21JdGlHSW04M1Q1ZnBlYzM3ZDBTZC9zUXBvUEQ0cWw1K0tCT0NsRjNF?=
 =?utf-8?B?L2xYbjg4aDVYQWUvcWp1WG1QZHR6bE5SWGlkdHJMTkdVa1dZVDJqeFA1bWxJ?=
 =?utf-8?B?YmY0QUcwekNVRytUaktTVncydmhhMVRtMjJMQ0ZGNnBEYnYxUVZiZFcvTW13?=
 =?utf-8?B?ekE4RExVL0VSaWVzQWd2czVUUHkvWG02ZVlSOTR5MVdBT1FyaC93L0FsQ01h?=
 =?utf-8?B?cS9MNWF2UHFNdk9naktoQldsYkdiRDk3TGk2OEFXOVdKL2srZFhOQUNqREhK?=
 =?utf-8?B?ZFlFcnZuQ1diWW8vOWhHa2M4dTVja2t4NXAwSlRHN0RXOWJJZWdYVnkzRU5s?=
 =?utf-8?B?WU0wcGc0ZVpZdkdDeUtSdjdldnlFRFBwRXQ2MFpLdnZwZ3QyQ2VxZWJQemFH?=
 =?utf-8?B?ZVltR3hmOUdFbmR2dkR4TmhMSitDUmI5QU1tN3grMWU4WGh2dWxsa29lVVY3?=
 =?utf-8?B?TDFhQkFEeXVSUXN2aW9GeGNCRFlESDlKeFNrSmJhRFFkLzlFZGN4OWt0L2FC?=
 =?utf-8?B?emJHK29sdWViV1p0R1VmMlJ4aDFac1dqT2pOS2xTTGpYc1JteUM2QXNIMnBV?=
 =?utf-8?B?eHRuTjVQSVNveUhtUDdVV3FkOTY1M213Nkw4NFVObWtFUVY2UmxMNUg5SmU5?=
 =?utf-8?B?djhwVkxSNVpNeUpRZzhheStQN2Uzd1Y1NmJzYVhvK0VpTiticDdFUVRKVlJJ?=
 =?utf-8?B?dFRwWWEvL0lCS0lZSVF4TW1kb2t3bEJMaUJWeU5SeXpIeUZaMmNWUlMwM2J1?=
 =?utf-8?B?ZThSZEpIQ3UxWERUTUhSV2FxUWhIbmlodFpLUk1WdUpSTTNnWGpCSTA2K0dZ?=
 =?utf-8?B?aWRRV1lWaXYxekFYUUhORDVDbXlUa3lkNHkvS0VDcE1sc2tQY2hZNmZIR0I4?=
 =?utf-8?B?KzI2bmg2SGg0ZTAwTXRpaWQvUGUvajBwUHpEb1c0Z1pEbFFNOE10bHFoV3Q0?=
 =?utf-8?B?UzVmbWlsdXovd29TL0FCalZndUduckFhOTlUVHQ0WTA2NWo4S2ROYk9KUHFo?=
 =?utf-8?B?bHVnbi9iWStVaVlCMEZNVTJqMmRwNVBaMnhUb1J0WUtPa1FpYWtneVRmY3Zr?=
 =?utf-8?B?NGVHQjh5VzNSU2lLWWg0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <321E2FA23B1CF04F8252687459B844E2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b8ad06-d79d-43ca-1d2f-08d92672188f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 09:29:32.8465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQf8XA6W0EUGwI59wsNyI4IGPe56fC2M18kKBjJyERkZ4VYCLCh/3t4vpXLYscSPzD3R2eHBz9ExYRPtj8HQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1766
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106030063
X-Proofpoint-ORIG-GUID: CA0C_tskbg0SjbXwv94z5jy4tRd4TKrp
X-Proofpoint-GUID: CA0C_tskbg0SjbXwv94z5jy4tRd4TKrp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10003 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030063
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMyBKdW4gMjAyMSwgYXQgMTE6MDcsIExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgSnVuIDAzLCAyMDIxIGF0IDEyOjIwOjI0UE0g
KzA1MzAsIEFuYW5kIEtob2plIHdyb3RlOg0KPj4gaWJfcXVlcnlfcG9ydCgpIGNhbGxzIGRldmlj
ZS0+b3BzLnF1ZXJ5X3BvcnQoKSB0byBnZXQgdGhlIHBvcnQNCj4+IGF0dHJpYnV0ZXMuIFRoZSBt
ZXRob2Qgb2YgcXVlcnlpbmcgaXMgZGV2aWNlIGRyaXZlciBzcGVjaWZpYy4NCj4+IFRoZSBzYW1l
IGZ1bmN0aW9uIGNhbGxzIGRldmljZS0+b3BzLnF1ZXJ5X2dpZCgpIHRvIGdldCB0aGUgR0lEIGFu
ZA0KPj4gZXh0cmFjdCB0aGUgc3VibmV0X3ByZWZpeCAoZ2lkX3ByZWZpeCkuDQo+PiANCj4+IFRo
ZSBHSUQgYW5kIHN1Ym5ldF9wcmVmaXggYXJlIHN0b3JlZCBpbiBhIGNhY2hlLiBCdXQgdGhleSBk
byBub3QgZ2V0DQo+PiByZWFkIGZyb20gdGhlIGNhY2hlIGlmIHRoZSBkZXZpY2UgaXMgYW4gSW5m
aW5pYmFuZCBkZXZpY2UuIFRoZQ0KPj4gZm9sbG93aW5nIGNoYW5nZSB0YWtlcyBhZHZhbnRhZ2Ug
b2YgdGhlIGNhY2hlZCBzdWJuZXRfcHJlZml4Lg0KPj4gVGVzdGluZyB3aXRoIFJEQk1TIGhhcyBz
aG93biBhIHNpZ25pZmljYW50IGltcHJvdmVtZW50IGluIHBlcmZvcm1hbmNlDQo+PiB3aXRoIHRo
aXMgY2hhbmdlLg0KPj4gDQo+PiBUaGUgZnVuY3Rpb24gaWJfY2FjaGVfaXNfaW5pdGlhbGlzZWQo
KSBpcyBpbnRyb2R1Y2VkIGJlY2F1c2UNCj4+IGliX3F1ZXJ5X3BvcnQoKSBnZXRzIGNhbGxlZCBl
YXJseSBpbiB0aGUgc3RhZ2Ugd2hlbiB0aGUgY2FjaGUgaXMgbm90DQo+PiBidWlsdCB3aGlsZSBy
ZWFkaW5nIHBvcnQgaW1tdXRhYmxlIHByb3BlcnR5Lg0KPj4gDQo+PiBJbiB0aGF0IGNhc2UsIHRo
ZSBkZWZhdWx0IEdJRCBzdGlsbCBnZXRzIHJlYWQgZnJvbSBIQ0EgZm9yIElCIGxpbmstDQo+PiBs
YXllciBkZXZpY2VzLg0KPj4gDQo+PiBGaXhlczogZmFkNjFhZCAoIklCL2NvcmU6IEFkZCBzdWJu
ZXQgcHJlZml4IHRvIHBvcnQgaW5mbyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmFuZCBLaG9qZSA8
YW5hbmQuYS5raG9qZUBvcmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSGFha29uIEJ1Z2dl
IDxoYWFrb24uYnVnZ2VAb3JhY2xlLmNvbT4NCj4+IC0tLQ0KPj4gZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY2FjaGUuYyAgfCA3ICsrKysrKy0NCj4+IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2Rl
dmljZS5jIHwgOSArKysrKysrKysNCj4+IGluY2x1ZGUvcmRtYS9pYl9jYWNoZS5oICAgICAgICAg
IHwgNiArKysrKysNCj4+IGluY2x1ZGUvcmRtYS9pYl92ZXJicy5oICAgICAgICAgIHwgNiArKysr
KysNCj4+IDQgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gQ2FuIHlvdSBwbGVhc2UgaGVscCBtZSB0byB1bmRlcnN0YW5kIGhvdyBjYWNoZSBpcyB1
cGRhdGVkPw0KPiANCj4gVGhlcmUgYXJlIGEgbG90IG9mIGNhbGxzIHRvIGliX3F1ZXJ5X3BvcnQo
KSBhbmQgSSB3b25kZXIgaG93IGNhbGxlcnMgY2FuDQo+IGdldCBuZXcgR0lEIGFmdGVyIGl0IHdh
cyBjaGFuZ2VkIGluIGFscmVhZHkgaW5pdGlhbGl6ZWQgY2FjaGUuDQoNClRoZSBjYWNoZSBpcyBp
bml0aWFsaXplZCB3aGVuIGl0IGlzIGNyZWF0ZWQsIGp1c3QgYmVmb3JlIHRoZSBiaXQgSUJfUE9S
VF9DQUNIRV9JTklUSUFMSVpFRCBpcyBzZXQgaW4gZmxhZ3MuDQoNCkFmdGVyIGNvbW1pdCBkNThj
MjNjOTI1NDggKCJJQi9jb3JlOiBPbmx5IHVwZGF0ZSBQS0VZIGFuZCBHSUQgY2FjaGVzIG9uIHJl
c3BlY3RpdmUgZXZlbnRzIiksIHRoZSBHSUQgcG9ydGlvbiBvZiB0aGUgY2FjaGUgaXMgdXBkYXRl
ZCB3aGVuIGEgSUJfRVZFTlRfR0lEX0NIQU5HRSBldmVudCBpcyByZWNlaXZlZC4NCg0KQmVmb3Jl
IHNhaWQgY29tbWl0LCBpdCB3YXMgdXBkYXRlZCBvbiBhbnkgZXZlbnQuDQoNCg0KVGh4cywgSMOl
a29uDQoNCg==
