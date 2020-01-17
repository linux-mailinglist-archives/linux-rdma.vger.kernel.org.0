Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1D140F2E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2020 17:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAQQme (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Jan 2020 11:42:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:52423 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgAQQme (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Jan 2020 11:42:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 08:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,330,1574150400"; 
   d="scan'208";a="226398750"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2020 08:42:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 08:42:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 08:42:32 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 17 Jan 2020 08:42:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Jan 2020 08:42:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxz1RqGw/4BXGz7f0gCX4d3BqsTUaHHkcDeCGI7KMOc/pXMdLwwREGNkvKOh7W7MyGrP2VRhiQb/zIPOn9yiJlhShPI5Iqw7Z3CPexTpDPuzbO1dUQhHWq8wRA+ycx9GbW3CnIUsMMeVp/Ubi/wdK698ApL/O7ieDkVmgQPCbBhpejx1pt1AJJKHLKeuXsLnxLkszhsWioqySBlodzgSeChLs0upmkfHsY8R1YuP6UuW6eV/dOVU7l0K6f0eQUC4twyy+Ewy2Xxy1DjovMNT3WtraLuFtts/ZPFT/Qul/oRpBe6qImK8TGdy315Vbk7B6k08qxIVLaN4jdulODwTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPJQ2bAWp9BjmJrDg4yeAIG94/e1jfg7GDY48Y+Qtms=;
 b=O0OCYLqxvcexQQklvwgmGP8v68L4JJtxzsQqS1npHPEp1Q9bSsK915Ox4u21+qLTpEb+F6D2QROheqqpWSfdZlKcCtSQJfSd/166+zOIHA3SipBSJigYbzu17xQp+cSI0Jg9m5/EoeCWlLX3UTyr2D9mEqrN8MZqoV5K+V8r9C1gGrBuy1CINE8IAybwOxFHuEczC25f4sZ7Jz/a/6E3l3+PG1DtDN6Dge+EhYE3GiVm7kIbJiEMMcsPvSUILKK8zr5rhKswIA3F9v4BSVahAU990ac9FyLohxv9bXLk0mMw6ksl8e5oWujP/22JafWSQ8iX6u7BL/mNsqo3gEkkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPJQ2bAWp9BjmJrDg4yeAIG94/e1jfg7GDY48Y+Qtms=;
 b=XIVsoAazuS5j7/CVfv0Iu8ZDzRsDMeHoK9abStyTgAS5k1oNqvzBoCR+mEDatof5jn39FzmbmBOudKAqr+ZMgiWpvu/0QeCcUsBl2lMCf52jnCu+XQIlRspITiRhlBO6X2TaMcUvx3AhKMCR9ds5FPVi7aNslNAIANY0rpplC+U=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com (10.174.97.23) by
 MWHPR1101MB2304.namprd11.prod.outlook.com (10.174.255.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Fri, 17 Jan 2020 16:42:29 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2644.023; Fri, 17 Jan
 2020 16:42:29 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Rahul Kundu <rahul.kundu@chelsio.com>
Subject: RE: [PATCH] RDMA/isert: Fix a recently introduced regression related
 to logout
Thread-Topic: [PATCH] RDMA/isert: Fix a recently introduced regression related
 to logout
Thread-Index: AQHVzCgy/EAeo9jnzE2b5MjLjwBP6KfvEVVg
Date:   Fri, 17 Jan 2020 16:42:29 +0000
Message-ID: <MWHPR1101MB22715AD3606D8C7DCB6C740F86310@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200116044737.19507-1-bvanassche@acm.org>
In-Reply-To: <20200116044737.19507-1-bvanassche@acm.org>
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
x-ms-office365-filtering-correlation-id: 5be2526f-982b-45aa-8ef7-08d79b6c3e12
x-ms-traffictypediagnostic: MWHPR1101MB2304:
x-microsoft-antispam-prvs: <MWHPR1101MB23041FE9E7C13B317CEF2F0B86310@MWHPR1101MB2304.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:348;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(346002)(136003)(366004)(189003)(199004)(66946007)(186003)(86362001)(66446008)(6506007)(55016002)(66476007)(54906003)(66556008)(76116006)(478600001)(64756008)(9686003)(316002)(7696005)(26005)(110136005)(2906002)(33656002)(5660300002)(4744005)(81156014)(81166006)(8936002)(4326008)(52536014)(71200400001)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2304;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7WwQBIHX3C2masl5ABrRAGbQv7LNT2U3ulK6pizuM7KuV6yOlevR79Z2n65VrbgY5uWn8IuHaQiASLz9CFm4xKZ7Lg+kbt9cBhhKslySd2bA1XIodHwwjZp89ejcYjadaCaKNj10/i1TjUYeqYlp+ILVfb7wt7HNEcgCGOwtcOmuTFqZl41/AEycOSi2BLeIWksfxYpoaekpxbzCNbwYrlx5YEOu3gTBITzbyfaXNvT3VaLRtjkfMLLrtlDpHLLw//jGq6rRoBZ/cD9uaCf/f254zLWsf/iBaH56EeAKC69JggdnDy9GttkUn3DjztAauiA9pE2zYmPDL+QMM6t0v6AktwPd1sTGm06wC27che1c6ZaILoPSz0+OFnH5hxC46gOgTRujqXhGiIzYX942P98Nb+QmJ8GYvLPQxcd6cVb3wXr2QM6ArwMGhDhyhXb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2526f-982b-45aa-8ef7-08d79b6c3e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 16:42:29.3382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbdrD53soKdogf8QJ/+F5hXJJ1ju47zi1FM7i51sXFYLeJvi5YWLOocsF0Iqw9s1Xp5ENlQjayg7PD8xEGYGOZqEee75HLOw0O2NyUgGEBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2304
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/isert: Fix a recently introduced regression related=
 to
> logout
>=20
> iscsit_close_connection() calls isert_wait_conn(). Due to commit
> e9d3009cb936 both functions call target_wait_for_sess_cmds() although
> that last function should be called only once. Fix this by removing
> the target_wait_for_sess_cmds() call from isert_wait_conn() and by
> only calling isert_wait_conn() after target_wait_for_sess_cmds().
>=20
> Reported-by: Rahul Kundu <rahul.kundu@chelsio.com>
> Fixes: e9d3009cb936 ("scsi: target: iscsi: Wait for all commands to finis=
h
> before freeing a session").
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

Mike
