Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C944F1B7C4A
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgDXQ7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 12:59:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:18709 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgDXQ7k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Apr 2020 12:59:40 -0400
IronPort-SDR: N1Wc5K4qCvS62ssH18gAXYW8BsGnLwMDiTzDcJmEegjaYazMl1CXUqd3Pl9XeD1Q++XsmUXqaw
 RIoJIGFyWIXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:59:39 -0700
IronPort-SDR: tOqx2VmrqyzfsKV6KFKzu0hNks9DG75RbUMG/T5yJpIdZplkBvI78cmFGNZu7OBdmWoMu4vu/j
 Jzp303W0lEQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="292698169"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga008.jf.intel.com with ESMTP; 24 Apr 2020 09:59:32 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Apr 2020 09:59:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 24 Apr 2020 09:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP6skHO+9HF1ibZBDPy7QOqTssUCIfw8lsDcsuKz22r4hEAV00kUZ2cru3R/MueFbbEivS87E2Ky5H7uh2KUhzkA0q6dvgV0EqL/uRINENZVHInfHLVWgVKWXn/wiU7RhMq1N+i4E1P10as8oBjtEtrKBu58DUlmCG4l04mJWXdeeMM6OEgpZYT6LQ70xphiSuUdIeuxDWqsoqa1WzALSUZhuRp+D3e4wgiv0TnbFoOUoEPDOHKUUFeJeyBUGqhzb2D24YprP880QolLK9Kd4yta0Cf5iX8M2fEv15N/gyalTd6o9Pe0qb4eskgTRkAOvyuU/MaS8WHhIaTxZ2kgqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FTif9ny2lTWkbBSJY+HSDEIMyuIfrfR0YRYSbX5dW8=;
 b=cCLGx4/Je6/F+ZPTKRKEumh0J3Ht6KlaSNjIQgqJrJ95ExDkqZjlB5AUMra1pT6+PLO5XutZWh6TrHC3dGBfx1np6mrrvU0tqjiY9v0wARXKH0uyiZ2Gmc4z9INAVPaEdy1VRtyk/BHYsoG5UfKAnyBDSAyX+/dguF2/kMKIxbpQosztkPmznnaR/kuR0LiuVKtPrNI/D3H4wiRbD5cjLCTIFWJ6DgPWZNfvDJcdLcqstzNSwWARL3k+XzxWT0aSFMpNf1jf227Kll78emf5qfE2g0x9/LI/9ZfmWkW+Bu/AM+vgvFSWCZ5hWPAYQBi8GGP/lwuOUoesaWzKBpCpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FTif9ny2lTWkbBSJY+HSDEIMyuIfrfR0YRYSbX5dW8=;
 b=SWXKJVWYMgokvcjUVts3fTQeEfeacgEIOWXPTKL1BiYfMNlAeNjplZkWtHU2+wtrdPwCR9QjeOaizu/3lWZ6BqNApiYCj27aYwXprCNlkkFfi7aipBssrhXTQdnVjGoV6NLHoBf7iyzejPK7i0Fs4M+6VmhjqaDRoYPkV9ElOxs=
Received: from BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19)
 by BY5PR11MB4259.namprd11.prod.outlook.com (2603:10b6:a03:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 24 Apr
 2020 16:59:30 +0000
Received: from BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::e57f:cc7f:1fda:69c1]) by BY5PR11MB3958.namprd11.prod.outlook.com
 ([fe80::e57f:cc7f:1fda:69c1%6]) with mapi id 15.20.2937.012; Fri, 24 Apr 2020
 16:59:30 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v2] IB/rdmavt: return proper error code
Thread-Topic: [PATCH v2] IB/rdmavt: return proper error code
Thread-Index: AQHWGlHHpQ9/5ohPoE6ZUTbdvZaHxqiIfaHg
Date:   Fri, 24 Apr 2020 16:59:30 +0000
Message-ID: <BY5PR11MB395888228F5FCA3861A21AE086D00@BY5PR11MB3958.namprd11.prod.outlook.com>
References: <20200424160114.7139-1-sudipm.mukherjee@gmail.com>
In-Reply-To: <20200424160114.7139-1-sudipm.mukherjee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ada518c-f7d1-49d1-40fe-08d7e870db35
x-ms-traffictypediagnostic: BY5PR11MB4259:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB42593F4B75B0AF64EE4F44CC86D00@BY5PR11MB4259.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39860400002)(366004)(136003)(7696005)(55016002)(2906002)(76116006)(26005)(6506007)(9686003)(33656002)(478600001)(4326008)(110136005)(66946007)(54906003)(8676002)(8936002)(66446008)(71200400001)(4744005)(316002)(52536014)(86362001)(5660300002)(81156014)(64756008)(66556008)(66476007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azO0JnDWsuXfe5NECeirMN7ZYmvxIsbWxdJDshHu9Fr0gnGiKHTQxsF0lqswcYjNVVPvXZrKP/VucM2BEvRBGjBVeCkdLX6WGygtRKemdzMuFoeVzfVLjzHuwtl3swlgeRczHtBzvpArmGMU9XOTah41YXOjZBZg6OE7YGDFI9kNrGrfZ851GXosfRlTkrbyy/dAuVptspXH5zA7kzcrThuTM5CK0YE1DeAbPaTuajxPZ7IDWCiZLb6S6Kj8RruK8LDCyPaQC6MNbBzv7r46QFJxU/p3GuI/FCg0TkikcolOd4FiV3ZMBrHu3RchlFnOQvvEJb2uKeVXo5ebtpSpgXB9S42RkMF5RaxldAUAnESzLi9uekmEcrwzYtBPbAbpH7vDcbQswGTEBIizzCSGXAHh1VbpACmMd9lPlIW/Hud/ZCKkaPijX+a6i5XBrUu4
x-ms-exchange-antispam-messagedata: bKQX/y35s1/WZ1WIMebRl0O1weuYE9PVFmLFvVFvnprn/sadbzhEZrraCwwnqvBZUfQTZUMps7Sp478Sj5kc2niPPxyJW5FgqmKd3XPxeUyQ2TWPEwDxT/eQoS9yC6SKqdkTlq1kJdMo7q7uHQ+fkA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ada518c-f7d1-49d1-40fe-08d7e870db35
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 16:59:30.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGqvwt3oHQ7AM06trTkWUj5/yCuss4TMCnlQLKiHAInvNZ8e44PuiE0LeuwaNd4HZr7Ozm1MSB9PbZZHKd9kKFCqlu1f0NyJ+U8m8yLjWys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4259
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH v2] IB/rdmavt: return proper error code
>=20
> The commit 'ff23dfa13457' modified rvt_create_mmap_info() to return
> error code and also NULL but missed fixing codes which called
> rvt_create_mmap_info(). Modify rvt_create_mmap_info() to only return
> errorcode and fix error checking after rvt_create_mmap_info() was
> called.
>=20
> Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
> Cc: stable@vger.kernel.org [5.4+]
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

I just tested the exact same patch!

Just a nit, adjust the comments for rvt_create_mmap_info():

* Return: rvt_mmap struct on success, ERR_PTR on failure

Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Mike
