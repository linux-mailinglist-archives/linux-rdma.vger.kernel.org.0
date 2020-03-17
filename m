Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D93F18770A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 01:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbgCQArc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 20:47:32 -0400
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:65446
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733005AbgCQArc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 20:47:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGZlLRt83yjlLnw1JFH73evZqlKhvAkkC23JXaQCnVau4VTPILx6+/vMwp1FeR/s3mj700DQCmXjxYRdLxSiyEo2AEDtQi3EGU/YaegXOykS5P+1Xw9KW4cqF0sOwWtos3VclAhYzFVoMi//ubjgMiAW3D4ttxvb6jIhiqjAE9QwaeM1ek7pa5veAGKYDnMzjXH7CLpFaiEnmnVfNsX8ndDQGtTVIujtPgm8SKfDekop9y4olZVINjMZ8vyY6ARxM0C77DvQwLIu/ofkht8isEEnMwBSXCl9CIEBxUtW6Pk+/9LZHqfBXUa6wlFtrAKlpkhLjlcNf70yko57XU4hkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpMYPZ6J0NpO3GH45v1GtmyTzYyfuW501ofyMA5DC+Q=;
 b=Ez8rfRPgylFfXt5DTbj0h8HF0kstDlZDJ8tTSgh5HhLtKsh4u6lhbx8zYta2NBsNh9BnsLokC/Hg+wyrJF/LFlJFKrizYPeVjCl6cOGOYmq5FuuNev83rXrVqhSmNVVzEgwPIwHljIkR91yEjcUVuVgeP0WTYsBAQxhiHgLXPaxY0o8LIepMJFBDSclW6SthtE0c2bgUGjVjqDkUPLBbGkIyJwefjH8R3GJafTultgkFUtOOZ3FE5vN1XKvCGIUjc3L8ox7nr8AqzHBBC3hO+88SZWWRlfuCCdNChV4fNyZV7HdwbBkdFqoC8k08zp4VIfnUNBUQZ/CfS+VqQ6n4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpMYPZ6J0NpO3GH45v1GtmyTzYyfuW501ofyMA5DC+Q=;
 b=0pM9Pq9PmJ8fXVMGHnHvyGPwRMrk8g0m+yrWkO3YezN3nQcn/fcF3tLXCBGYF8j/TFgWp+guOfYu9541HWEgGLRRQY3q0GAWK1tFWTpZ7o6Erx+e91tDGkvL6QnOUcCksrmPR0KkQWWGJuWKv2p5hcbF+fr5QOJL6v3NtjvYKsE=
Received: from BY5PR05MB6881.namprd05.prod.outlook.com (2603:10b6:a03:1ba::16)
 by BY5PR05MB6979.namprd05.prod.outlook.com (2603:10b6:a03:1b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.14; Tue, 17 Mar
 2020 00:47:25 +0000
Received: from BY5PR05MB6881.namprd05.prod.outlook.com
 ([fe80::a110:5949:fff0:a24c]) by BY5PR05MB6881.namprd05.prod.outlook.com
 ([fe80::a110:5949:fff0:a24c%6]) with mapi id 15.20.2835.013; Tue, 17 Mar 2020
 00:47:25 +0000
From:   Earl Ruby <eruby@vmware.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Bug in rdma-core / iWarp 
Thread-Topic: Bug in rdma-core / iWarp 
Thread-Index: AQHV+/WgL7rn9afE8UWXq+HZAAekMg==
Date:   Tue, 17 Mar 2020 00:47:25 +0000
Message-ID: <F606D8D2-6945-4329-891D-75CC1CEF97B8@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=eruby@vmware.com; 
x-originating-ip: [76.14.48.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a7abb66-ed8b-4704-a0c5-08d7ca0cc31e
x-ms-traffictypediagnostic: BY5PR05MB6979:
x-microsoft-antispam-prvs: <BY5PR05MB697925B3B066892E30F6BFD7D6F60@BY5PR05MB6979.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(2616005)(33656002)(81156014)(8676002)(81166006)(8936002)(6506007)(26005)(66946007)(66446008)(64756008)(76116006)(66556008)(5660300002)(66476007)(186003)(6512007)(316002)(86362001)(36756003)(4743002)(2906002)(6916009)(71200400001)(966005)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR05MB6979;H:BY5PR05MB6881.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BhDYDx2rC8iGrXTVdOAWuaocCij4fkGzulmHyjO3kDa0UMWvw6jnjJww6/D0CIecDDfqdA0GZcbnPDz/cKiC8m14rg/47Fr6P/18V/L3ebAPRVnhT5UulzwbjmpEcpZKOrvEb4IjkXEp6FtWxyWeChFiqGZkGh6pPJMnt7Xsh2LmT+CINngrjValGbeVu0rSBOyjAKGCEn2MfSHtCn6IIeGUCARDT8MH0dSU1UUbSV3hGIv0FB3VaL5SIwrkRJMaPnsdti/YBgWKQpogCgqjRn/ahMVHtsQALmWYsOKt5wWTcAvNY9U94kSfa7H1r6N0JOOiPyitNErtx/j2YCSZkiX2w1qhB33ma0krteZHqNsV4q3n2CWqoF9cnUPCNhIw8f5dowbepaisf/j/0n4jPOqUc9L8w2qyBPnCLz1j7ty2MSEho41jeMoVZaGQ8QMLEqE7kz5NADQ0c4EpnG1vdr+eOUPgPegsUBl1iYWOcEnFXAXHMZ5KAMwyLjd9+7kaMEJff8rKyFEoD/HJSr6QHQ==
x-ms-exchange-antispam-messagedata: pRn8uRb6bGP8FTR6WbyXWXAySH9gjET9GsGKhs+s4R9jgXxFRHWzrg55iEsFN7kYZktPJTRm+vxq9zycLV+lQ22PxbPS6ayWflmCBy2DnzsJ5D0MtOO76PnKsGGy1Rg+PRmcd1A05kTX43LV68OWqA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F08C2D218CD964582A6957DE8228717@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7abb66-ed8b-4704-a0c5-08d7ca0cc31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 00:47:25.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEMfSoWfpQnrTWmLOK1ZjAqiWGVEIvrLSublA+JKLimO/HoozirSTTVmqObAp9eBdFJZOA5DQf4RV7N9v1CdOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6979
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

SWYgaXB2NiBpcyBkaXNhYmxlZCBieSBhZGRpbmcgdGhlIGxpbmU6DQoNCkdSVUJfQ01ETElORV9M
SU5VWD0iaXB2Ni5kaXNhYmxlPTHigJ0NCg0K4oCmIHRvIC9ldGMvZGVmYXVsdC9ncnViLCBydW5u
aW5nIHVwZGF0ZS1ncnViLCBhbmQgcmVib290aW5nLCB0aGVuIHJkbWEtY29yZSB3aWxsIG5vdCBp
bnN0YWxsIG9uIFVidW50dSAxOC4wNC4gSW5zdGVhZCBpdCBmYWlscyB3aXRoIHRoaXMgZXJyb3I6
DQoNCnJvb3RAYmFsbG9vbjp+IyBhcHQtZ2V0IGluc3RhbGwgcmRtYS1jb3JlDQpSZWFkaW5nIHBh
Y2thZ2UgbGlzdHMuLi4gRG9uZQ0KQnVpbGRpbmcgZGVwZW5kZW5jeSB0cmVlDQpSZWFkaW5nIHN0
YXRlIGluZm9ybWF0aW9uLi4uIERvbmUNCnJkbWEtY29yZSBpcyBhbHJlYWR5IHRoZSBuZXdlc3Qg
dmVyc2lvbiAoMTcuMS0xdWJ1bnR1MC4yKS4NCjAgdXBncmFkZWQsIDAgbmV3bHkgaW5zdGFsbGVk
LCAwIHRvIHJlbW92ZSBhbmQgMCBub3QgdXBncmFkZWQuDQoxIG5vdCBmdWxseSBpbnN0YWxsZWQg
b3IgcmVtb3ZlZC4NCkFmdGVyIHRoaXMgb3BlcmF0aW9uLCAwIEIgb2YgYWRkaXRpb25hbCBkaXNr
IHNwYWNlIHdpbGwgYmUgdXNlZC4NCkRvIHlvdSB3YW50IHRvIGNvbnRpbnVlPyBbWS9uXQ0KU2V0
dGluZyB1cCByZG1hLWNvcmUgKDE3LjEtMXVidW50dTAuMikgLi4uDQpyZG1hLWh3LnRhcmdldCBp
cyBhIGRpc2FibGVkIG9yIGEgc3RhdGljIHVuaXQsIG5vdCBzdGFydGluZyBpdC4NCnJkbWEtbmRk
LnNlcnZpY2UgaXMgYSBkaXNhYmxlZCBvciBhIHN0YXRpYyB1bml0LCBub3Qgc3RhcnRpbmcgaXQu
DQpKb2IgZm9yIGl3cG1kLnNlcnZpY2UgZmFpbGVkIGJlY2F1c2UgdGhlIGNvbnRyb2wgcHJvY2Vz
cyBleGl0ZWQgd2l0aCBlcnJvciBjb2RlLg0KU2VlICJzeXN0ZW1jdGwgc3RhdHVzIGl3cG1kLnNl
cnZpY2UiIGFuZCAiam91cm5hbGN0bCAteGUiIGZvciBkZXRhaWxzLg0KaW52b2tlLXJjLmQ6IGlu
aXRzY3JpcHQgaXdwbWQsIGFjdGlvbiAic3RhcnQiIGZhaWxlZC4NCuKXjyBpd3BtZC5zZXJ2aWNl
IC0gaVdhcnAgUG9ydCBNYXBwZXINCiAgIExvYWRlZDogbG9hZGVkICgvbGliL3N5c3RlbWQvc3lz
dGVtL2l3cG1kLnNlcnZpY2U7IHN0YXRpYzsgdmVuZG9yIHByZXNldDogZW5hYmxlZCkNCiAgIEFj
dGl2ZTogZmFpbGVkIChSZXN1bHQ6IGV4aXQtY29kZSkgc2luY2UgTW9uIDIwMjAtMDMtMTYgMjI6
NDE6NDYgVVRDOyA1bXMgYWdvDQogICAgIERvY3M6IG1hbjppd3BtZA0KICAgICAgICAgICBmaWxl
Oi9ldGMvaXdwbWQuY29uZg0KICBQcm9jZXNzOiAyNjY0IEV4ZWNTdGFydD0vdXNyL3NiaW4vaXdw
bWQgLS1zeXN0ZW1kIChjb2RlPWV4aXRlZCwgc3RhdHVzPTEvRkFJTFVSRSkNCiBNYWluIFBJRDog
MjY2NCAoY29kZT1leGl0ZWQsIHN0YXR1cz0xL0ZBSUxVUkUpDQoNCk1hciAxNiAyMjo0MTo0NiBi
YWxsb29uIHN5c3RlbWRbMV06IGl3cG1kLnNlcnZpY2U6IFVuaXQgbm90IG5lZWRlZCBhbnltb3Jl
LiBTdG9wcGluZy4NCk1hciAxNiAyMjo0MTo0NiBiYWxsb29uIHN5c3RlbWRbMV06IGl3cG1kLnNl
cnZpY2U6IEZhaWxlZCB0byBlbnF1ZXVlIHN0b3Agam9iLCBpZ25vcmluZzogVHJhbnNhY3Rpb24g
aXMgZGVzdHJ1Y3RpdmUuDQpNYXIgMTYgMjI6NDE6NDYgYmFsbG9vbiBzeXN0ZW1kWzFdOiBTdGFy
dGluZyBpV2FycCBQb3J0IE1hcHBlci4uLg0KTWFyIDE2IDIyOjQxOjQ2IGJhbGxvb24gaXdwbWRb
MjY2NF06IGdldF9pd3BtX3BhcmFtOiBHb3QgcGFyYW0gKG5hbWUgPSBubF9zb2NrX3JidWZfc2l6
ZSB2YWwgPSA0MTk0MzA0MDApDQpNYXIgMTYgMjI6NDE6NDYgYmFsbG9vbiBpd3BtZFsyNjY0XTog
Y3JlYXRlX2l3cG1fc29ja2V0X3Y2OiBVbmFibGUgdG8gY3JlYXRlIHNvY2tldC4gQWRkcmVzcyBm
YW1pbHkgbm90IHN1cHBvcnRlZCBieSBwcm90b2NvbC4NCk1hciAxNiAyMjo0MTo0NiBiYWxsb29u
IGl3cG1kWzI2NjRdOiBtYWluOiBDb3VsZG4ndCBzdGFydCBpV2FycCBQb3J0IE1hcHBlci4NCk1h
ciAxNiAyMjo0MTo0NiBiYWxsb29uIHN5c3RlbWRbMV06IGl3cG1kLnNlcnZpY2U6IE1haW4gcHJv
Y2VzcyBleGl0ZWQsIGNvZGU9ZXhpdGVkLCBzdGF0dXM9MS9GQUlMVVJFDQpNYXIgMTYgMjI6NDE6
NDYgYmFsbG9vbiBzeXN0ZW1kWzFdOiBpd3BtZC5zZXJ2aWNlOiBGYWlsZWQgd2l0aCByZXN1bHQg
J2V4aXQtY29kZScuDQpNYXIgMTYgMjI6NDE6NDYgYmFsbG9vbiBzeXN0ZW1kWzFdOiBGYWlsZWQg
dG8gc3RhcnQgaVdhcnAgUG9ydCBNYXBwZXIuDQpkcGtnOiBlcnJvciBwcm9jZXNzaW5nIHBhY2th
Z2UgcmRtYS1jb3JlICgtLWNvbmZpZ3VyZSk6DQogaW5zdGFsbGVkIHJkbWEtY29yZSBwYWNrYWdl
IHBvc3QtaW5zdGFsbGF0aW9uIHNjcmlwdCBzdWJwcm9jZXNzIHJldHVybmVkIGVycm9yIGV4aXQg
c3RhdHVzIDENCkVycm9ycyB3ZXJlIGVuY291bnRlcmVkIHdoaWxlIHByb2Nlc3Npbmc6DQogcmRt
YS1jb3JlDQpFOiBTdWItcHJvY2VzcyAvdXNyL2Jpbi9kcGtnIHJldHVybmVkIGFuIGVycm9yIGNv
ZGUgKDEpDQojDQoNCkxvb2tzIGxpa2UgdGhlIGlXYXJwIHBvcnQgbWFuYWdlciBpcyBmYWlsaW5n
IHdoZW4gaXQgYXR0ZW1wdHMgdG8gY3JlYXRlIGFuIElQdjYgc29ja2V0LCBmYWlsaW5nIHdpdGgg
dGhlIGVycm9yICJjcmVhdGVfaXdwbV9zb2NrZXRfdjY6IFVuYWJsZSB0byBjcmVhdGUgc29ja2V0
LiBBZGRyZXNzIGZhbWlseSBub3Qgc3VwcG9ydGVkIGJ5IHByb3RvY29sLuKAnQ0KDQpFcnJvciBp
cyBjb21pbmcgZnJvbSBoZXJlOiAgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXJkbWEvcmRtYS1j
b3JlL2Jsb2IvbWFzdGVyL2l3cG1kL2l3YXJwX3BtX2NvbW1vbi5jI0wxNTgtTDE1OQ0KDQpNeSBl
eHBlY3RhdGlvbiB3b3VsZCBiZSB0aGF0IGlmIElQdjYgaXMgZGlzYWJsZWQgdGhlbiBpV2FycCBz
aG91bGQgbm90IGF0dGVtcHQgdG8gY3JlYXRlIGFuIElQdjYgc29ja2V0Lg0KDQoNCnJvb3RAYmFs
bG9vbjp+IyBjYXQgL2V0Yy9vcy1yZWxlYXNlDQpOQU1FPSJVYnVudHUiDQpWRVJTSU9OPSIxOC4w
NC40IExUUyAoQmlvbmljIEJlYXZlcikiDQpJRD11YnVudHUNCklEX0xJS0U9ZGViaWFuDQpQUkVU
VFlfTkFNRT0iVWJ1bnR1IDE4LjA0LjQgTFRTIg0KVkVSU0lPTl9JRD0iMTguMDQiDQpIT01FX1VS
TD0iaHR0cHM6Ly93d3cudWJ1bnR1LmNvbS8iDQpTVVBQT1JUX1VSTD0iaHR0cHM6Ly9oZWxwLnVi
dW50dS5jb20vIg0KQlVHX1JFUE9SVF9VUkw9Imh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0L3Vi
dW50dS8iDQpQUklWQUNZX1BPTElDWV9VUkw9Imh0dHBzOi8vd3d3LnVidW50dS5jb20vbGVnYWwv
dGVybXMtYW5kLXBvbGljaWVzL3ByaXZhY3ktcG9saWN5Ig0KVkVSU0lPTl9DT0RFTkFNRT1iaW9u
aWMNClVCVU5UVV9DT0RFTkFNRT1iaW9uaWMNCg0Kcm9vdEBiYWxsb29uOn4jIHVuYW1lIC1hDQpM
aW51eCBiYWxsb29uIDQuMTUuMC05MS1nZW5lcmljICM5Mi1VYnVudHUgU01QIEZyaSBGZWIgMjgg
MTE6MDk6NDggVVRDIDIwMjAgeDg2XzY0IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4DQoNCnJvb3RA
YmFsbG9vbjp+IyBsc3BjaSB8IGdyZXAgLWkgaW5maW5pYmFuZA0KMWI6MDAuMSBJbmZpbmliYW5k
IGNvbnRyb2xsZXI6IFZNd2FyZSBQYXJhdmlydHVhbCBSRE1BIGNvbnRyb2xsZXIgKHJldiAwMSkN
Cg0K
