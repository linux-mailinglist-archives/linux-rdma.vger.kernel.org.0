Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE93437972F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhEJSyG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 14:54:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35828 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhEJSyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 14:54:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AIY7MU118339;
        Mon, 10 May 2021 18:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ptndn3PSW+3E7d6dmMPh9NlVCoCkupXKLkAYqV6JoEY=;
 b=tY9Is5J7gJG7vLBWA8uIuMFW9gApdebebMqu4oRCPJrnJuvGRzFTm+ADA1T841+7PIdM
 pEz8kczGaYiLPpUaP7xjhy7mtDqti+SkRhqBP/9j7PwpPoEo3agjcz3Ny5YU/0TIK1Ov
 fFOXoYSdXGKhiCigd5sZHFIJfeT5pbuMqu3Z+m7hHGvl0quxbUHC3XJAY8l9R3BDXUzx
 UjafvSCdaorsz6xPvd2nSAH1MzPoP36Li7Azj6Z3FompgP2bK98nbPq3RWrQ8EqkJDFz
 s6SnIrYTZWIJX8COwkv6fDLGxhQMiPL1ZvFuPF1FEyeoB2jLs7p+XyAu86bHAB09jabu Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38dg5bce61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 18:52:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AITxOb151171;
        Mon, 10 May 2021 18:52:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 38e4dsrbn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 18:52:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzPWUR2H/kdKkDnndlrYi4oYyHBOehelgsFMdIUFn/Hx/oWuZw1sDj6Kd/Evxf7GZzMO5ffhAnQFiQ6tS3HKQuADu9pd1TS585Hdv0/t7cX1J9xdHGi2Pny8fNZ65fcCDiOFPDxPOI5HnsC56pjzyjCgivYkdZZfeYaSWMgVAnPtXQbOSrIwo659ZvCFlBcPiiWQIBGqt67/iXSAkELBOZ05SSA720MZFFLQndtGrqhKUCoazqVuKU+c0jWIFJnD6xZ8GvMxOwpo+ar8AUSY4pP3AzRgHH2omC5bORUiv8PA8x3c1kgSc3XHuHTIKQIUh+lV+qqM1KfYLxRgYyux1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptndn3PSW+3E7d6dmMPh9NlVCoCkupXKLkAYqV6JoEY=;
 b=N3qBMgTx46rIEZ//za3Dr3rbcIi2yG+rXs4+H6pO812IOijgMxdDeMh/zqx1YiB7U6NC7b903jXfBcY4VSmUnrfddPqEXC0uX/4M6FsJAKd0F+QEiDLwCK/kDvqIbUK4+G9UoI4iK3RjcgKYEqzHtZnh8C41+fOPURj1slgtE9rlufaELdaYve01sV5Xokho9MIRUhId/i0jt3Cs2dq3xRuYGv+7xUt/K8VRDxkj67HyOypxit3kdqRVUg6B6X5D7GUW9iSJfVJy7F/8RnmmKiAJVmAqY4SvNxiskoix5dju51NhaRqQFKz9fTqaaxrLPR8DCz+4MJEfvD6SjsEFFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptndn3PSW+3E7d6dmMPh9NlVCoCkupXKLkAYqV6JoEY=;
 b=J112yB32mZoNNnJzfoZ32G7pdavjo7vaE+RG6VrURqt6St+i523xyb7mCcKYqxwMyFhtBQiRlsdspg05pJ+I6Afh0Xz8unWi17MHDzSaywzQa3VRkca/YVJw97g16BDEus7U/9gf9f+xor92GXg2qXADLQfKe2UrcSuT9A+HFdI=
Received: from CY4PR10MB1989.namprd10.prod.outlook.com (2603:10b6:903:11a::12)
 by CY4PR1001MB2215.namprd10.prod.outlook.com (2603:10b6:910:49::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 10 May
 2021 18:52:54 +0000
Received: from CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5]) by CY4PR10MB1989.namprd10.prod.outlook.com
 ([fe80::ad28:97d2:76cf:3fa5%11]) with mapi id 15.20.4108.031; Mon, 10 May
 2021 18:52:54 +0000
From:   Haakon Bugge <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Topic: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Thread-Index: AQHXQa3Y4CAWkou9VES/lh4Y7MmmMarc+byAgAAeRYA=
Date:   Mon, 10 May 2021 18:52:54 +0000
Message-ID: <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
In-Reply-To: <20210510170433.GA1104569@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [51.175.204.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0e4c441-3495-4f10-595b-08d913e4d1e1
x-ms-traffictypediagnostic: CY4PR1001MB2215:
x-microsoft-antispam-prvs: <CY4PR1001MB221540ACCDE6C0300E63751EFD549@CY4PR1001MB2215.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:260;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gHV9uCmB81/REYRPJiPHHmk9widZwZP0Mq3IlpstiFrqsQEQx+0BBwJtULZA+kG8FIx24PMFbjeHTuDL2/WV6cGH/ssM7j3a1Lbwt+LIzz2EBFjOA/Pk/FiQ7jqfP9+ZfoKxLRsR6vU6dQ0tAkn9yY4hW59sVghLjh+6ExYZzncB/vXCOxyk6+mMWAzqqi14FgM40aV1GluvVIyvCmQWEvmCSNrKz+a7Z+IgCfSpWej17Kkh/2KzFlO/PUY0ydzE/F2RwXO3r9APkFmgkMTTJnFCed4uYx1Y1brKfEZKLJQfmspNPcMNPMPZkdvYIvQudOS14LLUdcbZAhhrcW3zc3wR62c9pb1TVZfjcnlkD+oEM4o8ZbbqiDVsoScOL7KVmK/CVasxZKX05ZIdISrHJ28Aht9KOb7EV+/TIW3pC/y3W5+5Ks2qCqB3O7oIllAx9jZXEgG/jU835wfBeHugbWcASj9P98Au2Lsab0djw5JkYBvQVycEva/UIqrRIdbkszI42rwZwC+xkv7qpDpOrCoVgTF2AlNUvCNBUHDb6Wy7D9WMaPLeT26IXPg323bIWwotP4+VNzfOLNXcT5tpQEjVn00D/7vrk8mL5E2QLS+xkkWu8J+/YpJq4Y1WPjG+YyTTb9uh99iBN8/BoliL6lFS6aGn/9OJ6x5Sn1PZOoc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR10MB1989.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(5660300002)(83380400001)(44832011)(54906003)(36756003)(53546011)(15650500001)(6486002)(6506007)(6916009)(186003)(33656002)(26005)(6512007)(478600001)(4326008)(71200400001)(2616005)(8936002)(316002)(8676002)(76116006)(91956017)(64756008)(66446008)(86362001)(66946007)(66476007)(66556008)(122000001)(66574015)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RXNCdzNlZ3AxQ3JVWFV0dFRsd2ZpRWRHc095NmhaQWhZNGVEenpJaDJmUjNi?=
 =?utf-8?B?R1FvSHpBa05SeW02VFhJQ2ROR1g2WDh6ajNWYVVYMmlxdnc0WFlaVmF0OFBl?=
 =?utf-8?B?MGUyZnhmOGVPL3E3clp4L0VPeHN3M1R2a0ppMFZUYmlDYkVUL0dXUDBCVm82?=
 =?utf-8?B?TFdPNDdmeGZKMkNieW9ZcTRtSGRSa3g4L0lodGZXTzJxTkpMU1dkMjAyWW5Z?=
 =?utf-8?B?VDNOY1dETG5nek50SGhnemZueTZXZVpHb3l1dzNDUmZmRDBlSHRCdEx5TUpG?=
 =?utf-8?B?SU9qUGphNFZOa2FxbUR3TU0zVURtM0Zmc05DS0M4MXRuclVlci9rcnlsRnlx?=
 =?utf-8?B?Q1ZQUFdjY2JlYjlPcFVrM2hrMWxHZHRmMGlrVzZPNElvWkNZbUF5TWZoQjhV?=
 =?utf-8?B?aWlra1Bob0E0Y0JVVEFaMy9KZ0oyMU5PWlBPdWRTcW5SNkVmbU8vUVZVK3Y1?=
 =?utf-8?B?QW1GbGZYNE5qcTJVbWZsbUx5dGlnQTZiaVJzSTQwaitvM0VtMHo0MWlKRjdH?=
 =?utf-8?B?aTgvU0FWekt2SHZCWnlFN3ZuUVNvcTc4aCtpekc3UXhMUk5WYnY1K0pvdWhN?=
 =?utf-8?B?THJFYVNGWXE3QWdncWFhcWVDTTI5UDUrK2ZwTTdIWU1DRmpYWDJaWGJVVHM1?=
 =?utf-8?B?ODAwZkxUMXNCK2dBd0FqYVhSU2lLeURxN3RmMG1udDJZYzJtU1p4M1JlbDlX?=
 =?utf-8?B?eUJUMWUzNWhMblZDWEJrYXRQcDhieE9sSDd4dVhWejRPOXNBZjhtais5RXY4?=
 =?utf-8?B?ajlQSXoxTkcwNGNhanVJTCtySlJURkZjeE15Umh6aXB5MHExVFl2Y3FiNXdi?=
 =?utf-8?B?bTNhdHFPUjRjVE9LSzd2cGsyZjVRNXByL2pGaWJUN04rTzFJS2F1c1FaMDZs?=
 =?utf-8?B?eTBkek9JMW5DTElBR0tveC9aajNLbUpPWWkyUDk2SHZsSkd0Rmg0cnNUTkVX?=
 =?utf-8?B?QVpoOXhNTU1yNGRPdlR4eVNnWXpmUkRGYUVOMGQ3YjRjdU5iQXh5M0JDWUdt?=
 =?utf-8?B?cHRtN3VnUzVrUnpTazBpMTZReWF2dWpuWUhNV3dhejVTRTBkc2VNS1JsMWw4?=
 =?utf-8?B?VlBCT2ZsUWtlc3pqMXl1Z1lXSWtHRHN0SzA4K0JWOUpRbWhrUEVQQUNZOHpt?=
 =?utf-8?B?bTdtaEIwMDF3WWNQbllPVW1lVlJReGsrVUVpWkdiT1RCZVZMamQrQmhLTVpL?=
 =?utf-8?B?YUppYnNhQW1UT0VpTytGWm8zT0lhd094dm1JRFJGZVdaSE1ybHpGazNMSnNo?=
 =?utf-8?B?b3p3VGhTV3lxZHA0Vm9hTHF2NWRCRklReGpEK3lJZzJsaWRrUUwrZ1lDcXZj?=
 =?utf-8?B?TFp1Y0FJc2xqMHdMazl2UENrZ0VrazZmOVhrYUZZUGNlL2M4V0RxZkpRY3F5?=
 =?utf-8?B?MSs0WnM0ZVlXQmVPRnRjaGFha0JnMUpWaktqU2pjSmlVK1BVZTQ5cFNHWlBU?=
 =?utf-8?B?WG5qcVVBQzI3OWYwcExWbEJOQVBPOHl6c1I0WGJJWDgvNVZyZWltMlpDU09E?=
 =?utf-8?B?UlR2eWs2TlJvOERqb3FZdFg4RWhlTWFKTnpTMkdkM3grR1NZbmE0UjlTc2wv?=
 =?utf-8?B?N04wWStVNk5ySVZkR3FtQ08rWFA4WGVIWUlZWk5PU2JSc2lnMzZzcEx0NVZM?=
 =?utf-8?B?Wlpua3hhOXBwR0t2NU9BcklNVDlkdld6ZFlqRFhvYjdidlhqVU9JSHJGdkMy?=
 =?utf-8?B?MDl2bmdiWjZLWGlQZHRJVWxLZ2RuQTlteFk2cnZncXU2SE1Td2FYQnhEQ1Zu?=
 =?utf-8?B?b09zS3ZVa3lrZUtkZ2FMaUc3MERxc2d2MEw3ajF4VHdXa295Sk9iQnlUZUw2?=
 =?utf-8?B?VFEyWTZIK3c1bVJQcHVVUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AFCE187BC19B14FA90E8D534E1E4613@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR10MB1989.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e4c441-3495-4f10-595b-08d913e4d1e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 18:52:54.2674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VAvJogbDAKV+cZ6KjEE1lxUq6jrMCvpmQ21YeiUnZE68r8EQMlXg5OJ41iB4jp+vtKZxHGf6PIvWMiCIONvt0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2215
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100125
X-Proofpoint-GUID: mIjk8vntjWRlrC-TcySmQpMEyCITS8hh
X-Proofpoint-ORIG-GUID: mIjk8vntjWRlrC-TcySmQpMEyCITS8hh
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100125
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gT24gMTAgTWF5IDIwMjEsIGF0IDE5OjA0LCBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgTWF5IDA1LCAyMDIxIGF0IDAyOjU0OjAxUE0g
KzAyMDAsIEjDpWtvbiBCdWdnZSB3cm90ZToNCj4+IFRoZXJlIGFyZSB0aHJlZSBjb25kaXRpb25z
IHRoYXQgbXVzdCBiZSBmdWxmaWxsZWQgaW4gb3JkZXIgdG8gY29uc2lkZXINCj4+IGEgcGFydGl0
aW9uIG1hdGNoLiBUaG9zZSBhcmU6DQo+PiANCj4+ICAgICAgMS4gQm90aCBQX0tleXMgbXVzdCB2
YWxpZA0KPj4gICAgICAyLiBBdCBsZWFzdCBvbmUgbXVzdCBiZSBhIGZ1bGwgbWVtYmVyDQo+PiAg
ICAgIDMuIFRoZSBwYXJ0aXRpb25zIChsb3dlciAxNSBiaXRzKSBtdXN0IG1hdGNoDQo+PiANCj4+
IEluIHN5c3RlbSBlbXBsb3lpbmcgYm90aCBsaW1pdGVkIGFuZCBmdWxsIG1lbWJlcnNoaXAgcG9y
dHMsIHdlIHNlZQ0KPj4gdGhlc2UgZmFsc2Ugd2FybmluZyBtZXNzYWdlczoNCj4+IA0KPj4gUkRN
QSBDTUE6IGdvdCBkaWZmZXJlbnQgQlRIIFBfS2V5ICgweDJhMDApIGFuZCBwcmltYXJ5IHBhdGgg
UF9LZXkgKDB4YWEwMCkNCj4+IFJETUEgQ01BOiBpbiB0aGUgZnV0dXJlIHRoaXMgbWF5IGNhdXNl
IHRoZSByZXF1ZXN0IHRvIGJlIGRyb3BwZWQNCj4+IA0KPj4gZXZlbiB0aG91Z2ggdGhlIHBhcnRp
dGlvbiBpcyB0aGUgc2FtZS4NCj4+IA0KPj4gU2VlIElCVEEgMTAuOS4xLjIgU3BlY2lhbCBQX0tl
eXMgYW5kIDEwLjkuMyBQYXJ0aXRpb24gS2V5IE1hdGNoaW5nIGZvcg0KPj4gYSByZWZlcmVuY2Uu
DQo+PiANCj4+IEZpeGVzOiA4NDQyNGE3ZmM3OTMgKCJJQi9jbWE6IFByaW50IHdhcm5pbmcgb24g
ZGlmZmVyZW50IGlubmVyIGFuZCBoZWFkZXIgUF9LZXlzIikNCj4+IFNpZ25lZC1vZmYtYnk6IEjD
pWtvbiBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IGRyaXZlcnMv
aW5maW5pYmFuZC9jb3JlL2NtYS5jIHwgMjIgKysrKysrKysrKysrKysrKysrKystLQ0KPj4gMSBm
aWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBXaGF0
IGlzIHRoaXMgdHJ5aW5nIHRvIGZpeD8NCg0KVGhlIGZhbHNlIHdhcm5pbmcgbWVzc2FnZXMuIFRo
ZSB3cm9uZyB3YXkgdGhvdWdoOi0pDQoNCj4gSU1ITyBpdCBpcyBhIGJ1ZyBvbiB0aGUgc2VuZGVy
IHNpZGUgdG8gc2VuZCBHTVBzIHRvIHVzZSBhIHBrZXkgdGhhdA0KPiBkb2Vzbid0IGV4YWN0bHkg
bWF0Y2ggdGhlIGRhdGEgcGF0aCBwa2V5Lg0KDQpUaGUgYWN0aXZlIGNvbm5lY3RvciBjYWxscyBp
Yl9hZGRyX2dldF9wa2V5KCkuIFRoaXMgZnVuY3Rpb24gZXh0cmFjdHMgdGhlIHBrZXkgZnJvbSBi
eXRlIDgvOSBpbiB0aGUgZGV2aWNlJ3MgYmNhc3QgYWRkcmVzcy4gSG93ZXZlciwgUkZDIDQzOTEg
ZXhwbGljaXRseSBzdGF0ZXM6DQoNCjQuMS4gIEJyb2FkY2FzdC1HSUQgUGFyYW1ldGVycw0KDQog
ICBUaGUgYnJvYWRjYXN0LUdJRCBpcyBzZXQgdXAgd2l0aCB0aGUgZm9sbG93aW5nIGF0dHJpYnV0
ZXM6DQoNCiAgICAgICAxLiBQX0tleQ0KDQogICAgICAgICAgQSAiRnVsbCBNZW1iZXJzaGlwIiBQ
X0tleSAoaGlnaC1vcmRlciBiaXQgaXMgc2V0IHRvIDEpIE1VU1QgYmUNCiAgICAgICAgICB1c2Vk
IHNvIHRoYXQgYWxsIG1lbWJlcnMgbWF5IGNvbW11bmljYXRlIHdpdGggb25lIGFub3RoZXIuDQoN
Cg0KSW4gb3RoZXIgd29yZHMsIGliX2FkZHJfZ2V0X3BrZXkoKSB3aWxsIHNvbWV0aW1lcyB3cm9u
Z2x5IHJldHVybiB0aGUgZnVsbC1tZW1iZXIgdmVyc2lvbiBvZiB0aGUgcGFydGl0aW9uLCB3aGVu
IHRoZSBwb3J0IGlzIGdpdmVuIG9ubHkgdGhlIGxpbWl0ZWQgbWVtYmVyLg0KDQpMZXQgbWUgZG8g
c29tZSBwb3N0LWNvZmZlZSwgcHJlLWx1bmNoIHdvcmsgdG9tb3Jyb3cgdG8gY29tZSB1cCB3aXRo
IGEgc29sdXRpb24sIGFrYSBpYl9maW5kX2NhY2hlZF9wa2V5KCkgZm9sbG93ZWQgYnkgYW4gaWJf
Z2V0X2NhY2hlZF9wa2V5KCk/DQoNCg0KVGh4cywgSMOla29uDQoNCg0KDQoNCg0K
