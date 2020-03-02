Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCB1763FE
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 20:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCBTcN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 14:32:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:8572 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbgCBTcN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 14:32:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 11:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,508,1574150400"; 
   d="scan'208";a="286714801"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2020 11:32:11 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 11:32:11 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 11:32:10 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 11:32:10 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 11:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxAbqzChMfGsDHMO6fZTlCBudOMCcrXYoGubIo+f7UiDDyHojh16DC9j7VkaVXuWqbz/deep+nSYRBNOkzSC+sRSV6E8QuoxbMm3Hh29pOvieCZATPaSD3zK5g6WtF0rwP241U2l7Qvz0VGbhxzpUM3nQAZYmoKYogFzz2kVLpgB3ErMPRje9AeGdJPcWxo78RDLtXral815DUIZpDsQr5CcWAWRoRXZegYXg7dEHSxlgYY/1cdpzZfo5HIapvFRkLW08RAatN6BLvd33IjVRKsx3s5ejgcUACAeHn/3SrHUH34hmAeo9x6CskE8gva+KJUn+TeGQ/kDpHBtXYq0Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAL2sxWfrysZYn3oRXSoSqJRdSSFKR+SssgFW7TisO4=;
 b=cUcWZh8aEUa58a+QZZ/N/fFuSRbK/oVCgD0bjlqTI54wYqWO+XfYoNFNLgeRSru0rNoaTj6iDB9NDp7kLvuEpzLyBTGfNEEw1x7CuRrELWKh7sP6EfywL873o0J2OiXJmcoi7nj1FIp7L9mdrRrrctryLzYKlt15OM6vGMOwR6xfkD7p+WL2WEP99xcFJeFzNmVMmLqMhn/Zw9O/OjH4Ll9OrvrvqpB8m+YrS2A1klyKpPeZmykP2wowCbqCH4ppFFGc7RVl09lton41DtpWj1TkpDy4c1M8XJ2cAuR9v3bakr98uZ0EFroVD02gjrul4sckBToyU2/15bSifuqmvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAL2sxWfrysZYn3oRXSoSqJRdSSFKR+SssgFW7TisO4=;
 b=DERrqHoiroYHHjKPbufkrKIdd+6AxkP1o+MlgJn+hryLEWGeB4qqDzlNHVW3NzUAcuII//IrIwph8A6NPxnTd5H6VPzCwMeYmAxQDL0YfMHXalM72/LngFcnsyI0EmG5JJOyS7o13EnC3GsqWJ4CsZ8Vq1D11qGWTpJDInoOoFk=
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 19:32:09 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::95bf:d9e5:2965:e266]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::95bf:d9e5:2965:e266%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 19:32:09 +0000
From:   "Hefty, Sean" <sean.hefty@intel.com>
To:     Andrew Boyer <aboyer@pensando.io>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: Positive or negative error return codes in rdma-core?
Thread-Topic: Positive or negative error return codes in rdma-core?
Thread-Index: AQHV8KD47VfZ4Jumh02Yvjr5wwGAMqg1r4MQ
Date:   Mon, 2 Mar 2020 19:32:09 +0000
Message-ID: <MW3PR11MB465166095F56EC67C3265EB49EE70@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <7CF6DD61-B611-4C24-98CA-5ADCCBA75553@pensando.io>
In-Reply-To: <7CF6DD61-B611-4C24-98CA-5ADCCBA75553@pensando.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sean.hefty@intel.com; 
x-originating-ip: [134.134.136.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17266eb-82cc-4b63-d379-08d7bee06675
x-ms-traffictypediagnostic: MW3PR11MB4715:
x-microsoft-antispam-prvs: <MW3PR11MB47150B89DD123E672B220AC19EE70@MW3PR11MB4715.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(346002)(366004)(396003)(189003)(199004)(478600001)(52536014)(86362001)(5660300002)(110136005)(316002)(8936002)(81166006)(81156014)(8676002)(2906002)(64756008)(66446008)(66556008)(76116006)(9686003)(66476007)(4744005)(6506007)(7696005)(33656002)(71200400001)(66946007)(55016002)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4715;H:MW3PR11MB4651.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbEomyRRLYu73Boa84Go8tJ3hx/afexA1H/pchh8g6lcZ/hlTHLUpWCSwoMGywjFDS8xV+O6I1vguo96HZyCifYo4xqUyCkXKquMfgcdEeJ/TwJ1xkTdhANilqcIhLNXrg6eqk0jSqCp8Up1/faikqr5wkaBK5s3TptE6YzOH65rBzWUftWkevbiJdFxmR7xVOmJQi2vja+O7JsqJ9pvqQ1WYheYb6k0gtX9ZBGlLKtWRIY1w/H1FJvoo1PeZ+IF+/v6tOBp3r/GjRSSNniJ7RytTf766F8lmOmBRiw/9dOBm0BsppSJ1QaEHDZxjdKhTBPaM81xHD8p8Fotu5zZpD1UNC7X2IQnEhM4Nd5dajDThO4dU+xF3/x1qaFXAJF/1GLij6wIEwHZwLqEidNZRBiNGJAVw5yOCIgQ42Z+4lstqdUhmkIUdGWAvsgd7N9h
x-ms-exchange-antispam-messagedata: oQczHGksFkp/UYBAbWJTjIZF5klPj88Nb+VLXolO4PZv+waME4QXl/j7+zd/eiQOtFbgAylNCQIsg/OR4zjKHawkTPWTMyhDiUDlLEQsVqlY2SkPdnbecn8R30Tn3MvyyVQsgry5nFAW+VT62c4KnQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a17266eb-82cc-4b63-d379-08d7bee06675
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 19:32:09.6487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9rfaeG2Pm1I5XgA2Nr4zGtmQBQzNqKCBRnZDU5Eo1znyNictG45uwi7j+FfZDQy6S/fDUXtHcpIleRRAYGuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Should rdma-core providers return positive or negative errors?

Yes

Seriously, this varies by provider and call.  Libfabric handles return valu=
es from verbs by passing them through a call that does something like this:

if (!ret)
	return 0;
else if (ret =3D=3D -1)
	return -errno;
else
	return -abs(ret);

The exception is poll_cq.

- Sean
