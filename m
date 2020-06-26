Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B489F20B92E
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2020 21:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFZTQN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jun 2020 15:16:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:32707 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZTQM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Jun 2020 15:16:12 -0400
IronPort-SDR: R0LiI3prC39tbQY/PU1H6cwLZBdPr5K8Ouq14WrkukdnPNt8iaP5DO3GBrBJZna1Zqer1gVRYQ
 rnadXa1LyXhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="206962523"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="206962523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 12:16:11 -0700
IronPort-SDR: Hv92bWRIsr8OMOUEftkUaJYZaF1VbwinCWoN0bSSJCu57IB/NaoKWN+3j5iTeAhEaybA8FiP0N
 5bDiLSAURnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="479916296"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2020 12:16:10 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jun 2020 12:16:04 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 26 Jun 2020 12:16:03 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 26 Jun 2020 12:16:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jun 2020 12:16:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la33yntRInkkCPKJd3jQckUgM12p5dp4bTFLEFiDgnpakLvfvaej6UZA4TGD0ZNCFpu2ek+1vt5F3uSBeW5xN+d/jxD80lQYzewi3cSS0XdQLYSk5QmJiydJsP54EWkSPjqE/HO+GHnoL3ow/nFmdEMZXOLTbveR3PHL9sO3AufJN+h8MTGd1RDM/ule6C2DMb1B5QvEHM8k20G8Khki5z1iyKwkYdX9hVAWymKoeGb9SZrRLC+q9PKTe08pS3sqUjkp9PhhKVaXpuF3cMMyIm6sUi8CYXY1ixJUjBu82thDN8qjeX06IEA2u0unsIRhRHD9Y1J7dGpF6RjFEGZ1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NwSoHrNodcilh4EnpPiGtBVwpAmrNAtQwRYPzkOODE=;
 b=EpQt0Qeb/jfKR8lEkw7B0rMZ2JASRG7FSETYPPW1dE2xbw88dx8WxQqnvJsAn1PSuXlTBQKf47ieipfAacD2uDchP6ntP7iswfYg7lWk7esVBOkh6KhUAz/QK+egAbwtWTulwjPDfi/I+OKscXVXNfQW3YLJbUNyGN72yr6G6mX9jsuUSBsPAncy+Q5Z0O2QV5Dbpn8ppeyPJFgYgpz/ZOze6MZ+bX09deJ9Xtxrp6gG5FYrsD8bJGNLvPXYfIBiNEL1bjq0X1IsImUiysPWdVf2u8fbYomu2CXjuu+ILyzy1dw0OoxLalW+/x6EWQAqa+n3YSGXo/jaIuoTDO/A8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NwSoHrNodcilh4EnpPiGtBVwpAmrNAtQwRYPzkOODE=;
 b=qE2bhIwkBfaDiVzwxeyxTHXGeBWDdkcRzyRDtMNJwxNp80Xm7TDIwCbbmd2z4t5/tUu4cdQFAo6Dd/lDTzgS6b98WrKa03YeRczX4cb6g12g01qIhiPamc729NfyueKsLL/JDePoHZUk6/dHKQUDd0Q2e6EfVz4EQkX1DetOWSU=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1487.namprd11.prod.outlook.com (2603:10b6:301:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 19:16:02 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::ed68:a00b:2bb0:21cf%8]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 19:16:02 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Doug Ledford" <dledford@redhat.com>
Subject: RE: CFP for RDMA minisummit at virtual LPC 2020
Thread-Topic: RE: CFP for RDMA minisummit at virtual LPC 2020
Thread-Index: AdZL6+GwSe/z/08iTdmJAMFoOy4kfw==
Date:   Fri, 26 Jun 2020 19:16:02 +0000
Message-ID: <MW3PR11MB455515AF0D14A0C07360AFCDE5930@MW3PR11MB4555.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f61118d-a01b-46c0-6e3d-08d81a055db5
x-ms-traffictypediagnostic: MWHPR11MB1487:
x-microsoft-antispam-prvs: <MWHPR11MB1487069771CCC1CEDFF821B8E5930@MWHPR11MB1487.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OFLMNMDfIkvhCCHmq+mJesmP8uH2+0qvPbLMcXM9Evmnf0Ho/SeRps0FE9VHoxbVGRJ55xgRBPUjJ0AIfoek9u9QTfNMg4TngCP0LX0bAMsqUXVHVB5RdyRQSR0a+mtkgHrWvbMklCIzL4ZgabRcapjAI9PUJDlaYfDoX5X7LQP82+EjkjLIqqKbIg3+5z/lJkZiSBOZ2dwYSIfMMTRLXofQ0BZtWYlRnFDrsXaSrsUQz8UceF3IHG1K8U7mbYNcX47bB/1Z4wExzTAha4P/TL8akiH1+uzaQTC9BBFjGsIhy4XqTFvIsjUUX47ES9Um
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(6506007)(54906003)(9686003)(52536014)(26005)(55016002)(4744005)(7696005)(8676002)(76116006)(66446008)(66556008)(8936002)(5660300002)(64756008)(66476007)(66946007)(4326008)(186003)(71200400001)(6916009)(86362001)(2906002)(33656002)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X3+p5/9kUZ25SeMn2y/PUghNwRgfKaxkPxpNdHasUoO5ajkFF4X6A+B37J3V4Nnd/fTzhWCfwxxFBYzY6igF1l5klUXYVioFASFZPZFqq6KtBGJDjIQK1GBmpwFg3nxvJdiQAfej6foQaJibysnzrAyLHaxI0b1RlgoKt5/pFFvkvGYSC4/ZILM4pOT3Re7BDSZctBVigO3s26esXi1OCoreiCKDXqN4VR9uhmm0h38MUMi2hqMTBJAqKNExQyD40xNy8rrplFZf9n5GCKjH9N/Aqq7huv7b8YvzrdpKgil+IC/sbDbjOiPj0PK62lgS/gCnV7WAnbQQKyWCBznbk8aule8MrOsRTFRJXUxu8H+/vaTXO6SM8w9mTUcc4kDgjKxzx7mSUiNytXlrBywulM0/TDOldfDXnysTSsDjZoKaXmCWbr4WhisJbyA12q06NmP8l/I5hzHE8ParC32Fg1Fk8MLfBqqgN15FRVNkH254vXmN33Ng1WxhW66YAj2r
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f61118d-a01b-46c0-6e3d-08d81a055db5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 19:16:02.1169
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3XcrG8OHbaezyE0HsUIod9MA4FwyR9lmLnzCKmzT+w74yP4om8LiZiNuvs2Kg5rMTFMam26I+V3SDHhtvKHmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1487
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Hi,
>
> I will be short.
>
> Please send me/Jason/Doug/"mailing list" the topics which you would like =
to discuss at RDMA minisummit at LPC 2020 which will be virtual this year.
>=20
> Thanks

We would like to have discussion on RDMA and PCI peer-to-peer for GPU appli=
cations, using DMABUF.=20

Thanks,

Jianxin
