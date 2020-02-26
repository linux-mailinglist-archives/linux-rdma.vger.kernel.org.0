Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6F1700B9
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 15:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgBZOI4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 09:08:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:29905 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgBZOI4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 09:08:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 06:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="438434486"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by fmsmga006.fm.intel.com with ESMTP; 26 Feb 2020 06:08:55 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX101.amr.corp.intel.com (10.22.225.128) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 06:08:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 06:08:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoJV65F2EeiX5IJmFSlsfHf4mVT4J5yCPKQydndcsgz61eTquN3rGkbW8bkai9lfeCjZbALZdD2OwWiStd2BNtrgBFHwPUhE9kgbVDKxvJE7BAI11N6QFf3Z65EbDrfXnf6X9GO8MVnrT0LMSLgbTXsmlE8WbyldMO5t4Xt3bwYcPGONcV7k6doh+sOcKoG8nGewIBguWalJNJTsOK6Dr/SFU1lUa59RuMOWjU5PQZZw4555gYpHAu4JN3zuWIEoEhnZAJDPsOhrnoFcX9iUDXXMoAOf1l+EDMA0KW05Z6n3EYkIJRPLqGAn4/MYtqnL+AFvqcs9CZysZk3oxHAPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLyfq1tt5nfC4+LL0k2EgvqeDMSMs7RVubWnhTSbA3k=;
 b=cPX2B7JgybMWbaNaYY7hAjzKnU+r1GL/uY+Bg4ybRzSaWzV7+DaFgVIv6DsWiXKGmDvgabbj0Umd7mmImj4JW8faTw+vEVaV0eChsTIJwhI4kvSSKWwg1QHc/jR83YMWPYhekk33rgTRx4MJIc/fmfldfrwAdA9mKpfH9kUpaCs5LeyhktCoTuV9VbjRE+c/VK0NCMjG9gNsV4zk2eh6QNZuPN1R0ojWarRuiy2bcKnsBbrvZZbE4WoD6MTj9PnZa7bfVOgDri59R6Tjljajfa1kqm9uEDOyJy/QkUjnR0fXrdQVekHcvI+H/QE6rOyg0FAfZ1C7jjt4qWkjzF8teA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLyfq1tt5nfC4+LL0k2EgvqeDMSMs7RVubWnhTSbA3k=;
 b=W8AwQ/B2fZwl4iW6/RMN6NaQtyZAcftEgj2vINCMl9T0fOj4ISRY2kJbfQj/w+NXQ/PzyqGjJpyhM8x3TLd+VzxYO2KUROhYc4jSam2XgithlfWcP5j/amSVOc9FgwBpflSrYHQAyXIfHnjQXFzdePc2ci4tWaYYcF5qAosqP6E=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 (2603:10b6:301:52::23) by MWHPR1101MB2287.namprd11.prod.outlook.com
 (2603:10b6:301:4e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 26 Feb
 2020 14:08:53 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2750.021; Wed, 26 Feb
 2020 14:08:53 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
Thread-Topic: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
Thread-Index: AQHV6+AJn6O5sTpnyEufWANZxzLkFagtctIAgAAFugCAAAZtAIAABJ2A
Date:   Wed, 26 Feb 2020 14:08:52 +0000
Message-ID: <MWHPR1101MB22717251968B09F6D695214486EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200225133150.122365.97027.stgit@awfm-01.aw.intel.com>
 <20200226130432.GB12414@unreal>
 <a6c9d82e-59ca-eb27-fe53-ca6edd55fb5b@intel.com>
 <20200226134802.GC12414@unreal>
In-Reply-To: <20200226134802.GC12414@unreal>
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
x-ms-office365-filtering-correlation-id: f3908c6d-fdda-46cd-2ac6-08d7bac56925
x-ms-traffictypediagnostic: MWHPR1101MB2287:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB228772F29BA873962B17051A86EA0@MWHPR1101MB2287.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(199004)(189003)(5660300002)(66556008)(33656002)(66946007)(66446008)(64756008)(110136005)(6506007)(966005)(7696005)(558084003)(54906003)(52536014)(71200400001)(8936002)(76116006)(2906002)(66476007)(86362001)(9686003)(478600001)(186003)(8676002)(26005)(316002)(81156014)(81166006)(6636002)(4326008)(55016002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2287;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M5DjeURFcxffXK92fYmC3dzVFYtRL6Dy2LUhSQawD8XqVVDx4mmP10Dm0zjBoUtL2CJEZ14qeVG1ysDTpfBDCcqLioKH9cmr5SbQa9Hwhgj4f+jqM5WAuEygj898OPx7iP81PM/AJgLuQfUyyU/GPQCy3mq7KMlLrv7rPVCpK3ocx8XHwK1bFC/PGy5O1a9IEE96GjElksTmQmvFHQZqRIqB8vrLYonyat2T67OT7h8CpKCTO+rIOFrcfBXIuKbw2pgDXAER0p5jtyJHcvtOFvoTLh/QhMRk6BpaDU7ycEbqPpeTgSJyk0GxASaVVDl6YarX0DjhJoniJ68jR/KTg8Yy6iqeFGoCVcbp4NgyGhk+F0BfPmZUkHo4rwpevhr+5Qh9qlJcxk4XgGMj4OlMwZuljms52LpF4oFvbbq/Al7IjtQ0cjny2bMgwOTOheaz5oyDUO9s7sTP7nfL0mp47L0M+k5CfwcVDL7Gyju5CNA0bM3ZsGzmFkniQ0Ar1W2BqXZQ4fOfAHtbWX8P/ZcQCLckRmHWf0UT8YAgrjjfB9GJXWjzhGTQhbP55NFw9l2j
x-ms-exchange-antispam-messagedata: OfSqNiVCQgv4wxNVxQ8Y9yCUOSBThbUsoGqV+tvqxsSyOgGyySZCXcnHzSvUOKLTvwwzJmLT3Yc/pnUYcelPJR2muQnD96BEH7/mScrVBO0a23vBNNDeUtNRcX+133QuJbCAibxZIJc5twIrE5trNA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f3908c6d-fdda-46cd-2ac6-08d7bac56925
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 14:08:52.9412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBA1hk9MHact1lYc9dYx875FuMgGommll4e2c/jHs4KGPkqZNHVbGUFpuSWJWUVGTGbABiaMaCad1d76Zf/1q5q+D9tGZYDXDXm3kzxRMxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2287
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > You mean this one? https://marc.info/?l=3Dlinux-
> rdma&m=3D158263596831342&w=3D2
>=20

Ok.  I will test the patch.

> Yes, this is what I wanted to achieve by "if (!(qp_attr_mask &
> (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {" line.

Was a non-bitwise || what was intended in this statememt?
>=20

Mike
