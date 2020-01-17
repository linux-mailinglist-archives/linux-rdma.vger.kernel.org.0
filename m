Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEE140E60
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 16:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAQPzc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 10:55:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:43121 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQPzc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jan 2020 10:55:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 07:55:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="262689744"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2020 07:55:30 -0800
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 07:55:30 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 07:55:30 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.50) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Jan 2020 07:55:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj/4MiAKk6y6MVmuvZzzx/yW9o3Dsy2LeoZvaEE/VidTbk0vnCBojc91x+rUOeU187OwTzfCt0G40VKqxuJk9OxevGiGBDloHgb+diTWr1OHr3K3NbmUIXhHKabyt1RU4lwUS4FsS25dZcMpsHpFJQsFlhiTTiwi0am61FA5oxLNAScrgcptHIjV5vNXVoTZNbkSEub1JQbt4LEYSafrMyCspBMI6u0zTaHcBLwx5wDqr8LD7C8Zax1lkUuObuTeHh6Q787uwF8PJD8nIT2WJk8rAV4g9swRmz+4Vr3WN0ndjEoF2Ivj30a96iszz9TPEFJnjZHioIrsaLHCPx/hzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy1zplB+E5SrINAT+5AwIeT+rHrJGZBJwIL+qGNuyRc=;
 b=VFbMFxWNX4N6VNZphWxVjlVfqyAKY5PfsSvAbgcL+avUrxyy/+aktqa6kRqGL6+QVwS2hj8sxrfZsw9N/+gH/xNodQgdxsj2e6G/DaCrmwwpX5IkNwzzL5oDmlX3KjZKZqAc8Xn0CFs5oSbZnaH2f9wX9gYjXLAIO8/NE78VtUcUaGRd5PPMJ9S9li9ov0RxLC2fR2np328/00jgQ1J2JSxzKdokLox7ldp+W29ELgI49BjHw6nRCsnoG71SEs4qTFJDv5y76OcBFxMDe2rFZG0/nsD67EEsn1ZS418DNhkGHEFbMKwYwJ+6+n28VIA1K9mqHJJDr56u8KXo/nE51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy1zplB+E5SrINAT+5AwIeT+rHrJGZBJwIL+qGNuyRc=;
 b=xMeejdXSSfODXoqQiC9qJTcfSSNMLFSf3bZRclHknbeouWqFxDfhqsFwMbV5VtrGSAHm7l3MPdVR7ebSRuPTSFG5k8tRnvIWOM9KTiy6SqYwuGURngDXvCxlHbr5tS+nc7FxI84JUrfD4gI0+EJcuxwiZBbBk1mzQ+9w5rkJAvU=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com (10.174.97.23) by
 MWHPR1101MB2141.namprd11.prod.outlook.com (10.174.96.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Fri, 17 Jan 2020 15:55:27 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2644.023; Fri, 17 Jan
 2020 15:55:27 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
Subject: RE: Recent trace observed in target code during iSer testing
Thread-Topic: Recent trace observed in target code during iSer testing
Thread-Index: AdXEvi9yRk7s01oGS3qaCUi6aFPrnAAR+a+AAE5GdrABw8E5AA==
Date:   Fri, 17 Jan 2020 15:55:27 +0000
Message-ID: <MWHPR1101MB227156761E41FA7C47DAE5A486310@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
 <3b724797-275a-9a14-1503-1778780a5872@acm.org>
 <MWHPR1101MB227100196B12AF2494BB184F863E0@MWHPR1101MB2271.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR1101MB227100196B12AF2494BB184F863E0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1498be94-131a-4511-4ecc-08d79b65abe2
x-ms-traffictypediagnostic: MWHPR1101MB2141:
x-microsoft-antispam-prvs: <MWHPR1101MB2141571875FD533FE28D2B1C86310@MWHPR1101MB2141.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(26005)(5660300002)(52536014)(8936002)(186003)(966005)(71200400001)(6916009)(9686003)(316002)(66556008)(4744005)(2906002)(66476007)(478600001)(4326008)(76116006)(66946007)(64756008)(54906003)(6506007)(55016002)(66446008)(81166006)(33656002)(81156014)(8676002)(86362001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2141;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/2oaFMgoDqwQvNc01IelU6e+mQLJvBEFZc8dtDfn2FraAXRsM8lBluZiWTlTaf1HXHXW0oRMZ00YXQAXFoJn+zDQqd2WTjemNO7DnQahO5Hb4cmmfIn8GQKSfCcxG5yRxUiT7T4Ik1D5pscT9bv2p9CpGC21oWJ/EkA1apm09Fx4+cCizlm5mjqwzlTGvI1fX2wJt8Mj4nIO9xVb0dxJjCCcB+VTo43PVyZqv7jIZG/+O4JsmMMB4AU9G4wRNzE9XVwJ/TcCYUJzeT+M1aWamd8U3mArDAQWUl1Ne9Wr9267oXyp7zh0hUrCD5TPM5BqGT17Ri3RevED6ZahQKv8olMrivq+kWEgnGYA4gpl44jokP4CPKP5VPdWLUjwGnaBgTYzIo1zG8/ohIs2ewoI/OFEAKDBp2UfML1/SPRBvnb10xeQKBS8RvoxXuHvym1ckEujWnFcqG6RHE7j9SafthWdcigmHKei5/r3PE55dk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1498be94-131a-4511-4ecc-08d79b65abe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 15:55:27.2172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +D6SNM/G+Pg8vC7e0Lbi4ctcrqJEYAxj1XPICXCrKJMk3pvDzjDziuKC7apNKGlL7hqQvwe/vWg4dMLFA0ui5R9hUzwdnrKNmPUTdQ7nFPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2141
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBTdWJqZWN0OiBSRTogUmVjZW50IHRyYWNlIG9ic2VydmVkIGluIHRhcmdldCBjb2RlIGR1cmlu
ZyBpU2VyIHRlc3RpbmcNCj4gDQo+ID4NCj4gPiBBIGNhbmRpZGF0ZSBmaXggaGFzIGJlZW4gcG9z
dGVkIGJ1dCBuZWVkcyByZXZpZXcgYW5kL29yIGEgVGVzdGVkLWJ5LiBTZWUNCj4gPiBhbHNvIGh0
dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL3RhcmdldC1kZXZlbC9tc2cxNzk4MS5odG1sLg0K
PiA+DQo+ID4gVGhhbmtzLA0KPiA+DQo+ID4gQmFydC4NCj4gDQo+IEknbSB0ZXN0aW5nIHRoaXMg
bm93Lg0KPiANCg0KSSBoYXZlIHRlc3RlZCB0aGlzIGNoYW5nZSBhbiBpdCBjZXJ0YWlubHkgZWxp
bWluYXRlcyB0aGUgcGVyY3B1IG1lc3NhZ2UuDQoNCkhhdmUgeW91IHN1Ym1pdHRlZCBhIHBhdGNo
PyAgSSBhY3R1YWxseSBleHRyYWN0ZWQgdGhlIHBhdGNoIGZyb20gdGhlIGVtYWlsIHRocmVhZC4N
Cg0KV2hlbiB5b3UgZG8gZmVlbCBmcmVlIHRvIGFkZDoNClRlc3RlZC1ieTogTWlrZSBNYXJjaW5p
c3p5biA8bWlrZS5tYXJjaW5pc3p5bkBpbnRlbC5jb20+DQoNCk1pa2UNCg0K
