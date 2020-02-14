Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206EF15D971
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2020 15:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgBNO22 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Feb 2020 09:28:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:36260 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgBNO22 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 Feb 2020 09:28:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 06:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="267572005"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2020 06:28:27 -0800
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 06:28:27 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX125.amr.corp.intel.com (10.22.240.125) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 06:28:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Feb 2020 06:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHn67U3gPl2AvUobbmZrIdkfCtrZj/HnNHCkFhJ4gIImVSKDetMW/6vzdq0zevGW3iTWaj2VUY+4AoRgI8tMIK4S2otpxDV+6CucuJrYB+ZYlGPRmuBgZbfKXlReoMzbhQPyY1AzmUstBlSuX5rfx35+LxFZAh7b4d0PGe1By/1v8dDNlQ6DAHv3ciUtb5g9liEM8c1biAEqIW1chm6AyVCldkGExoGA5TJdWjhAslCFT8vnw1vf+zX58KiYui/wMNPg3h7EMt/4XL1+fM6WfZNk1+DnkF548VnnXleAP/e/oMzZmHpQDciiQ6N8nILRumP9Z8GbSU9gWPZCbeL4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPEjck0HkDCpNvPpqI9ZQJePC02ZdCs1LJCMUuwcxso=;
 b=LsT496tb4Je5ssmO9qhIjzhTcEBAS3AqVCBQVjyuTw7hiLPoKo2IWmi7mEKmOgDz0+Jhle4VuX1Qt4jnmi5LfN3Rm7hAwHhOU2gBxA7k4DO/okwGES5FL6+8+8NBnpWLVsVOSdvbkt9ovPE2ysGVIJb1rGXjWtEPzBeysrxighUAuAKhK8tsfSEN7HvIz9ArtxkrkZ+W2rfzwo1Hu2FOP7FKaX7tD9lzj0ylw6SMNQAhZ//tSJcxID0UPSS/XvOd7fbGYNX0Ew4aWXY1j8i/emrwhnfmlUX3LpGK9nXIO+r1KM/K0psuNEkJiNq9PpdqKznJRM2wdzFPMj9XR34zag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPEjck0HkDCpNvPpqI9ZQJePC02ZdCs1LJCMUuwcxso=;
 b=Rikaohz1qU5J/y7DA5nt8Q4iyF+i+pFz8dAi1tD6Rm2T4sQGX/jYIrwuzsw8dbdc51/2kjBBI/br9O3T+EejQd9ewAt8C6qMZybu1X3VVRsxDJsOsQGRH8Fnd9U5Yma9NaJ8r0nLjg34ubi937Jf4rpDoxFOk1O8tJc6Zz9X2Vk=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com (10.174.97.23) by
 MWHPR1101MB2093.namprd11.prod.outlook.com (10.174.96.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 14:28:25 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2729.025; Fri, 14 Feb
 2020 14:28:25 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Dakshaja Uppalapati" <dakshaja@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rahul Kundu" <rahul.kundu@chelsio.com>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced
 regression related to logout"
Thread-Topic: [PATCH 1/2] Revert "RDMA/isert: Fix a recently introduced
 regression related to logout"
Thread-Index: AQHV4ivLgmScrKAfbEGyOyATWy6cNqgYl5YAgAIpPIA=
Date:   Fri, 14 Feb 2020 14:28:25 +0000
Message-ID: <MWHPR1101MB227101D7C2DFEB8ABACD0FCB86150@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200213050900.19094-1-bvanassche@acm.org>
 <fcc55797-40d0-a04f-e2de-6a20a02e6fb6@acm.org>
In-Reply-To: <fcc55797-40d0-a04f-e2de-6a20a02e6fb6@acm.org>
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
x-ms-office365-filtering-correlation-id: 6d711125-7c51-4f99-efca-08d7b15a26e3
x-ms-traffictypediagnostic: MWHPR1101MB2093:
x-microsoft-antispam-prvs: <MWHPR1101MB2093E170453151226568ABB886150@MWHPR1101MB2093.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(110136005)(54906003)(71200400001)(52536014)(9686003)(478600001)(8676002)(81166006)(316002)(81156014)(55016002)(558084003)(33656002)(5660300002)(4326008)(8936002)(66946007)(26005)(66476007)(76116006)(186003)(7696005)(64756008)(6506007)(2906002)(86362001)(66556008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2093;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNJUBuXh6+8ZJwY6zE+EQwVH3udmqPlwYK9VKLE8tkLVTqD6ZKomj4xdkgNgzfrWA7CQr6wf0u3eNkMwTusDwbTTTqVaY8XK7ErtO4r3QZ2n5QD5Fz5HEpLtYB9iwbjXRXYzOn5KFFXsR9XgawiNhd7YTbG1bzC1hx5Z0c+WpVq2vdWqEqVcs0/TIQwzygFMJO3hN7W2zumD0Tg0WxISXJQ0O6ErifmEWhbD0srEN91B0ossWsBJPdSVNipnUF62bezsDBjposlf/9FmsoK17y7uNK4tZ7i2cKj8ozPfS1Mcc0XG0br4LlJ2LnPlHwwJNA/u+rVCCTnrDf5Psy0eKWH/AoGuxy0NKouVoSwbYtZPM0c/OSDLXuKBQtCHDujAoKgxAW/qXMS8xKCK8BslTXUgjX+0xcxSf5iI8E8ZWiYC7+zg7JyomRyd8Y+Sewwl
x-ms-exchange-antispam-messagedata: iU2pwF3hHq/bvxoXRszgZOD4B531bPJlLjGjTXNeqIhYTUj9CL/vjRnYpHcA1PwYC0eSeT//LLODU3rD3s6m8kXDFN31T/UeNZ2W6Pf6g1UxWPlC50sBoyTwwKgHweHLKNcCvQfPIulNeQEr1A7ERQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d711125-7c51-4f99-efca-08d7b15a26e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 14:28:25.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3cxy4BPzHAM9ApLesEB3l6war38M67feT4MHZi8iC5PLfMhEsB/yZhWyxtcDuo9j6NxRaAIc7bhhVTC9GyL+enq20g+K2PPVnS3ML10gLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2093
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiANCj4gW1BBVENIIDAvMl0gUmV2ZXJ0IHR3byByZWNlbnQgaVNDU0kgLyBpU0VSIHBhdGNoZXMN
Cj4gDQoNCkJhcnQsDQoNClRoaXMgd2lsbCBtZWFuIHdlIHdpbGwgYWdhaW4gc2VlIGZhaWx1cmVz
IGluIG91ciBpbnRlcm5hbCBpU2VyIHRlc3RpbmcuDQoNCldoYXQgaXMgdGhlIHN0YXR1cyBvZiBh
IGZpbmFsIGZpeD8NCg0KSWYgeW91IGhhdmUgc29tZXRoaW5nIHRvIHRyeSwgSSB3b3VsZCBiZSBn
bGFkIHRvIHRlc3QuLi4NCg0KTWlrZQ0K
