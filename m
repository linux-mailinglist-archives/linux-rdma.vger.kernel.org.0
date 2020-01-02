Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8512EA4C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgABTZi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 14:25:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:62620 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgABTZi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jan 2020 14:25:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 11:25:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,387,1571727600"; 
   d="scan'208";a="221449783"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 02 Jan 2020 11:25:37 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 11:25:36 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 11:25:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jan 2020 11:25:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g213YqV11sKk+yiuoqCZ5ZY/0g0fQmvMowdSj+fVFrv4QfZlDntkciW6YQYm0OgrCc/QCJb3c41aG4PrlCuKz04LTRQNciu2gtp8eQq5bfX9M8YOv0s6EksVxD0IEErzboPWIKvD/YKM2gUfMwEFEJz8tiTSw+Zypr5sAnBnnERMDyHC6Vs8mECd/Sv3MnCIiXq/JCBy5J0y2vxWQv580JdumxdVTWMm8iG1qEdPTSEf/TTgQMGIr4Mt74EtHdn+p1rc0KlyfD7d+z1cOXfVycNyVC3agUTGBbjlGKx+rgGVhuYYeHfn/RdrDtUsf0lVGcMcvwz84/XWhE2tGAu4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfgsJrtB57S6dHNYI3jv/vsChSYhdztv5JwOwhM0owI=;
 b=cLK4j5DxblkCQbLWZMG6vIbpfA3mAjeJtIDq5fY3Mmzke3YZcX9J3rVcGuNgPBnnKVrt0vlsCfSnc9ax9nkBIPJxRpcGLLqejWc3BPJdm4HK2I5rNKI6KHi/P4v2VABOyRBnnBxHrzVhuQwIjSF9rchVQxVeSyKnchd+FOgfPFMYZEFmJtoLWrbquIEdlW9NGuFmsxxhW9e4ZdL7ir0cXwaabmxx56P/VshwHx6Qk4gdf9Ny5Gr7xYXjIQZB8Hakw+GEaUsb6O9ryYBNHTNu1514h6p5xoI9pfOJhxDkVX117J1Y0Fm5vj+8GOOcf6Rap3aTN7HuTacuYRTbpEiz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfgsJrtB57S6dHNYI3jv/vsChSYhdztv5JwOwhM0owI=;
 b=yg8SPf/jSbtRYTpueAEuM1kOCa0y4FCkp8uylKXkRC2NNO4Qoinnw9r3R7Tvmccu0yKoQfcAIPtX+SNNJxJA8imBMr7MMmS4vGrjtDjuB08sZmCv84ze8sUnY7KziCwC4HlxU16vpQ8L0hkaPrzwK2PIrjKX2D5i8J8MfJSxsIw=
Received: from CY4PR11MB1430.namprd11.prod.outlook.com (10.172.69.137) by
 CY4PR11MB1814.namprd11.prod.outlook.com (10.175.60.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Thu, 2 Jan 2020 19:25:35 +0000
Received: from CY4PR11MB1430.namprd11.prod.outlook.com
 ([fe80::119a:24b1:20bb:6a87]) by CY4PR11MB1430.namprd11.prod.outlook.com
 ([fe80::119a:24b1:20bb:6a87%12]) with mapi id 15.20.2581.013; Thu, 2 Jan 2020
 19:25:35 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Terry Toole <toole@photodiagnostic.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Is it possible to transfer a large file between two computers
 using RDMA UD?
Thread-Topic: Is it possible to transfer a large file between two computers
 using RDMA UD?
Thread-Index: AQHVwXueH8xDMADLcUKl7RjbvEP2UafXsjWAgAALuoCAAAKYwA==
Date:   Thu, 2 Jan 2020 19:25:34 +0000
Message-ID: <CY4PR11MB14302D923E9CFF0665E67B3F9E200@CY4PR11MB1430.namprd11.prod.outlook.com>
References: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
 <20200102182937.GG9282@ziepe.ca>
 <CADw-U9BTH1-2FztrKnC=tTTH93wOZg3FM2qJgjneNz-6-kywiw@mail.gmail.com>
In-Reply-To: <CADw-U9BTH1-2FztrKnC=tTTH93wOZg3FM2qJgjneNz-6-kywiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDlmNjkyOGYtNDBjZS00OGRkLTkyMzUtODYyNjExYTZmMmVkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMEI0VFdkYXRLeUlBUjJtOWlrYmZQMUw1RXhDbWkyRVZIXC9uMVU0N3NVVHUrcXdYUGJweWEyRlgrUHFrcDliR2UifQ==
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sean.hefty@intel.com; 
x-originating-ip: [134.134.136.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05b21374-d13c-4993-96ec-08d78fb98a6f
x-ms-traffictypediagnostic: CY4PR11MB1814:
x-microsoft-antispam-prvs: <CY4PR11MB1814F27FA41F062B6C7EFF5D9E200@CY4PR11MB1814.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0270ED2845
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(55016002)(2906002)(26005)(86362001)(4326008)(5660300002)(4744005)(110136005)(52536014)(9686003)(316002)(81166006)(81156014)(33656002)(66446008)(64756008)(66556008)(8676002)(71200400001)(7696005)(478600001)(8936002)(76116006)(6506007)(66476007)(66946007)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1814;H:CY4PR11MB1430.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qgjBlBs9Ccl70UnjecXLdXWXQiHPM+AZ9CkXNcrbVFmFhz8gilF8dyKtISb9QDZV6A7NBasGummTuV16EfJu30y3al8XxYXd+Kiqo9csnHk1Z743wUI3fSWbiqpSgHwlizHxthd9v2cQyNK5GL1bGtcPX+k0OXaAaQNB+dmZ+C1Hp/9dDNO8HJR8rqb8tIKy8E2iG6uVyjR2uQxTtLqnoErREDs4703BhvhZz1r6i5bfiNo4pODImZTs05S8WnrIhWXRt98/mm5Q1wVuwH4RodC8l/Oyr3lXNj2WvHiUSYUFsNKr5e5trupRSzR5mPHEzSiZvawBCrokT3d97yYGUEf/U3tNe0vN957DRM2eRMe/lt2lGTLRB/6xbCpFfeeB/dH6d9q9fuJ/43hBWfrsyMTQ4kioOHwnGrGr3yuLJwFcs0rrzTM5tmNZ7IFnHSY/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b21374-d13c-4993-96ec-08d78fb98a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2020 19:25:34.6167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXwLJSWYx+JTKiaTmRBazx5czB1JM8AzeZhRiuO8iv/N2Sdof7Et7IEDMx9DqQRo3fdyNDD0aRYTH2+khgCHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1814
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiA+ID4gSXMgaXQgcG9zc2libGUgdG8gdHJhbnNmZXIgYSBsYXJnZSBmaWxlLCBzYXkgMjVHQiwg
YmV0d2VlbiB0d28gY29tcHV0ZXJzIHVzaW5nDQo+ID4gPiBSRE1BIFVELCBhbmQgaGF2ZSBhbiBl
eGFjdCBjb3B5IG9mIHRoZSBvcmlnaW5hbCBmaWxlIG9uIHRoZSByZWNlaXZpbmcgc2lkZT8gTXkN
Cj4gPiA+IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB0aGUgb3JkZXIgb2YgdGhlIG1lc3NhZ2VzIGlz
IG5vdCBndWFyYW50ZWVkIHdpdGggVUQuDQo+ID4gPiBCdXQgSSB0aG91Z2h0IHRoYXQgaWYgSSBv
bmx5IHVzZSBvbmUgUVAgSSBjb3VsZCBlbnN1cmUgdGhhdCB0aGUgb3JkZXJpbmcgb2YgdGhlDQo+
ID4gPiBkYXRhIHdpbGwgYmUgcHJlZGljdGFibGUuDQo+ID4NCj4gPiBJdCBpcyBub3QgZ3VhcmFu
dGVlZCB0byBiZSBpbiBvcmRlci4NCj4gPg0KPiA+IFdoeSB3b3VsZCB5b3UgZG8gdGhpcyBhbnlo
b3c/IFRoZSBvdmVyaGVhZCB0byB1c2UgUkMgaXMgcHJldHR5IHNtYWxsDQo+ID4NCj4gU28gZXZl
biBpZiBJIGFtIHVzaW5nIG9ubHkgMSBRUCwgaXQgaXMgc3RpbGwgbm90IGd1YXJhbnRlZWQgdG8g
YmUgaW4NCj4gb3JkZXIuIE9rLiBUaGFua3MuDQoNClRoZSBzcGVjIGRvZXNuJ3QgZ3VhcmFudGVl
IG9yZGVyaW5nLCB0aG91Z2ggSSBkb3VidCBtZXNzYWdlcyB3b3VsZCBldmVyIGJlIHVub3JkZXJl
ZCBpbiBwcmFjdGljZS4gIFlvdSBjb3VsZCB0cmFuc2ZlciBhIHNlcXVlbmNlIG51bWJlciBhcyBp
bW1lZGlhdGUgZGF0YSB0byBhbGxvdyB0aGUgcmVjZWl2ZXIgdG8gdmVyaWZ5IChhbmQgY29ycmVj
dCkgcGFja2V0IG9yZGVyaW5nLCBhbmQgZGV0ZWN0IGxvc3QgcGFja2V0cy4NCg0KLSBTZWFuDQo=
