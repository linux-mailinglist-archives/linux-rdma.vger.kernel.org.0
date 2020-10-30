Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B255729FE30
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Oct 2020 08:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3HDo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Oct 2020 03:03:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:65280 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgJ3HDo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Oct 2020 03:03:44 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9bbace0000>; Fri, 30 Oct 2020 15:03:42 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 07:03:42 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Oct 2020 07:03:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUxfhG5mCS+DF6g5IlrNtxAQd4dFzPEWRG150+7oCqaGOj+3YpWOqdCmDJ/tM9vYh7FaMik84niFrop2t7bzu/IcHO6mXLcL7sgH7aru4plZTnPLci509B0dtxEpkjM5IAdXsp7soZMTdJbz3CpuyX6YEkErC/m3883uPFYYJUxsMu8DD5A5v6J+9m4SzzImFLPDrPCHE63M+AjxfH7XA8gEAY3yZc7SPRxgTx0uQMXgb2s3bTqeu9IxXjevlyMIJ9D9mWqTFlvsjqZhmjvqFLVdqn1gVhlyrlPtykUi8tjcYsHDY+O+roS8VTTfv45wgmYKhsuCGgb9JN636/9iiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oHMfIk+IXV7Jmi4Z+YVAsm8vawbEH4uMGureda0SVY=;
 b=bMnqmRF6U1pGU8P0N0kA5SDtyBxhVgeGObE5Tf5IrrpxfkNx009qPjtciEJ+vcLDL1tPKEI0V0f4KeT31I/xgtsA3akg2L9bl0r77lGTa58346pzWJ3B3rTFj3fXrSMfaxuawlqMWowsX0Kwk//7QoPU8ZGapYH4JMIGUTH8ZmWJEaCTB+37HDA1WyIxT/EsIPRdSvrh7FTf9f/HVpdiz9LrsEygbbfpckMS+x/S/YFWiw1xHauo3SWJOunM4vxHOwnrFuBhzv4ioYGDj5BWy8hEu+NcPJd9B68JTyW+1KdaDin9pFtd+5IJ8Uk+yzlBwpz5xjLMHKCxh0TaT+NgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB4322.namprd12.prod.outlook.com (2603:10b6:a03:20a::20)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Fri, 30 Oct
 2020 07:03:40 +0000
Received: from BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105]) by BY5PR12MB4322.namprd12.prod.outlook.com
 ([fe80::3c25:6e4c:d506:6105%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 07:03:39 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: hfi1 broken due to dma_device changes in ib_register
Thread-Topic: hfi1 broken due to dma_device changes in ib_register
Thread-Index: AQHWrj4VRTrcYY80FECVKd9j8ZIlXKmvIZqAgAAEkQCAAJLVAA==
Date:   Fri, 30 Oct 2020 07:03:39 +0000
Message-ID: <BY5PR12MB4322B02BCECDCF555B4969C4DC150@BY5PR12MB4322.namprd12.prod.outlook.com>
References: <ad690c34-4260-91a1-d64a-2954a8ae1c54@cornelisnetworks.com>
 <20201029220125.GZ36674@ziepe.ca>
 <de2291bb-bf8a-4d07-960c-2bf93bbbdcbc@gmail.com>
In-Reply-To: <de2291bb-bf8a-4d07-960c-2bf93bbbdcbc@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [49.207.200.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39a9acac-20ba-4147-f98b-08d87ca1ee24
x-ms-traffictypediagnostic: BYAPR12MB2775:
x-microsoft-antispam-prvs: <BYAPR12MB2775928707E9C4EE3F3DCFC5DC150@BYAPR12MB2775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GFI9MDqhvyS4eu+Bv07m5NI3lRWgXTfmT4HctDNcR3bxEkup1nHtXgZMcY8Yn+IMlbW/Q7sEtKK3n8W3LTQL9icOuM1sHyd39G26FtDHXRV+HoLHzCG/8wRr2RQS43mkzXaJ5EKR1+guX4twvgiY5wf2bE7+vDkxE6xBzKPbFJnbkCDNEMxJLCIxIWZPkPy9K8TulQkLu1/ACwBLJpd3HPYY4a9fbw7xca/jQt9V8tb347LNyy8nhAt6JMD0En5FwL8BIPC/n8ExdaBBpTG91bQBmWE80xWhgarpRy4NFhsJ5lJfOpfqoGKHDlBLziNLHSiR2I1qn0jkYtFE7UFjuN1dMZXVwuR6j6KR7kYZKfxcDvFFRa1DVzUcbCi+jOxgVLhPBVcaOgtLNiLGyUDfBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4322.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(5660300002)(4744005)(9686003)(316002)(33656002)(110136005)(4326008)(66946007)(76116006)(8936002)(66476007)(8676002)(66446008)(64756008)(66556008)(52536014)(26005)(55236004)(186003)(53546011)(7696005)(2906002)(478600001)(966005)(86362001)(6506007)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: H58kzrEA8rLmWUbmhBf5rXoJQ800M6eQlO3IQmFUt4qiNFgvyKUknMnF6oJ0eFkHEBgzzC5w2EYhebdEYzNlW1lWT5X8Fgj5x4RCQG89xga/avkmBXW7o+KDNMYeJzuxV4apoa1P90kzyT7RGhAhdXoTYaltuxnou94egg4fci/VmsKaRa74Ba1RNww3aiHnxVoxJMzJI3ekNDJzaKIvgXJ0/JIhA/UJ2FB+SZox8EfyNCBJjXSKYNezdBsNecAXviukYTj9Ttw96su+AQIr9+3nK7/PGzd0JPafqhPPskvenKxlG6ZYBLNkcJ6sghDOyPMuVTRR+bjIOyYHx4nkulrWvDAT7Bh8nbV7e5Ev3kPEEJ3rkSfeYpvsDhwyTVZM/yVdkKKVRnRYFiV8djPJCA2CWP3CyfMcwm5t3Ha55PahQGjyNULFXaGF9XIjsZle5dCLbsl5pC9txULynUkOFx8nevMNtnT6EHYg2CfpTezu6iWceCAnyYkIHRf8ckRd9dE75wM+Wl7ylDpVx/6j/l0Q1RoK4dgz5qbwSghdmG+l+3Nmhzo1lsvpEqWj4px1nvAu0VRbMKehf3j8ubI+etTZCQxtyzHZFPhEdW+5iA+DfImGGsMSv8m6q6jVApGINTJtAMuKn8m0VTh5i5sujQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4322.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9acac-20ba-4147-f98b-08d87ca1ee24
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 07:03:39.8779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG0O7/WfvlqBtdqEMGrmYbvesIIADSJcW6pzyhgLZamdjFwbCYeHey0mRgr5l7JIOofGVz3oHi3eVetzogzVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604041422; bh=4oHMfIk+IXV7Jmi4Z+YVAsm8vawbEH4uMGureda0SVY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
         x-microsoft-antispam:x-microsoft-antispam-message-info:
         x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
         x-ms-exchange-transport-forked:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=psVfxxZc17GCr8VT78dO+UGDZjbNz4Gtxb82Ua8dOpuSpqCkKt916+hMzb0S1nnuh
         yhNpOgYdNKrB0f9arLTitn1063mm9rbALgdjAlO00LZa7wz61QoSTfALegll35uoxf
         sUMrKnbSi7i8ljbn02T5G6Uf6PUAJ6v722aJ7TTLf2dphMCpMIwp3VgIi6d3+Lb46e
         n9SGsHbFra2WxISJeSWKs3FSQDBms3y59kmOFIuys0wx/tazn1e8epUvAksmRMXX6c
         iS0YldQjKgKegEBfhHuVTx6qiCLU6FMY1WHczn5+051l3HRxhm8PJqshBnDFE2pr0f
         4UNDHmI6IPFgQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

DQoNCj4gRnJvbTogQm9iIFBlYXJzb24gPHJwZWFyc29uaHBlQGdtYWlsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBPY3RvYmVyIDMwLCAyMDIwIDM6NDggQU0NCj4gDQo+IE9uIDEwLzI5LzIwIDU6MDEg
UE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBUaHUsIE9jdCAyOSwgMjAyMCBhdCAw
NTo1NDoyMlBNIC0wNDAwLCBEZW5uaXMgRGFsZXNzYW5kcm8gd3JvdGU6DQo+ID4+IEp1c3QgYSBo
ZWFkcyB1cCwgNS4xMC1yYzEgaXMgYnJva2VuIGZvciByZG1hdnQvaGZpMSBhZnRlcjoNCj4gPj4N
Cj4gPj4gZTA0NzdiMzRkOWQxMSAiKFJETUE6IEV4cGxpY2l0bHkgcGFzcyBpbiB0aGUgZG1hX2Rl
dmljZSB0bw0KPiA+PiBpYl9yZWdpc3Rlcl9kZXZpY2UpIg0KPiA+Pg0KPiA+PiBSdW5uaW5nIHdp
dGggdGhhdCBjaGFuZ2UgY2F1c2VzIHRoZSBjYWxsIHRyYWNlIGJlbG93LiBSZXZlcnRpbmcgdGhl
DQo+ID4+IHBhdGNoIHdvcmtzIGFyb3VuZCB0aGUgcHJvYmxlbS4gIEkgaGF2ZW4ndCB5ZXQgaGFk
IGEgY2hhbmNlIHRvIGxvb2sNCj4gPj4gYXQgd2hhdCB0aGUgYWN0dWFsIGNhdXNlIGlzLCBidXQg
d2lsbCBhbmQgZm9sbG93IHVwIHdpdGggYSBwcm9wb3NlZA0KPiA+PiBwYXRjaCBob3BlZnVsbHkg
c29vbi4NCj4gPg0KPiA+IFRlc3QgdGhpczoNCj4gPg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXJkbWEvMjAyMDEwMjgxNzMxMDguR0ExMDEzNUBsc3QuZGUvVC8jbWQNCj4gPiBl
MTA1YTgxMGZiOWQyYmY3MzQ1NTRmM2E5ODc1NDY4MTg0ZGQ5NmMNCj4gPg0KPiA+IEphc29uDQo+
ID4NCj4gVGhpcyB0aGUgc2FtZSBpc3N1ZSBJIGZvdW5kLiBJIGVuZGVkIHVwIGp1c3QgdXNpbmcg
RE1BX0JJVF9NQVNLKDY0KSBhcyB3YXMNCj4gc3VnZ2VzdGVkLg0KT2suIHNlbmRpbmcgZm9ybWF0
IGZpeCBub3cuIFRoYW5rcyBhIGxvdCBmb3IgdGhlIGFjayBhbmQgdGVzdGluZy4NCg==
