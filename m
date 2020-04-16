Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027F61AD1B8
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 23:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgDPVI6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 17:08:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:9473 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgDPVI6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 17:08:58 -0400
IronPort-SDR: v4pdMJ6IeV53HitpjSA/9hRngADLSahNNK1ZQb2ZeyPy8yg5399jzUhdrXqkj3d4AaQAKd7TtB
 2X0owFWkVlCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 14:08:57 -0700
IronPort-SDR: F/mrHh4Q4WO2MD9RBJfoTpFR4d+6JO/AAZVnyQulhgSbsbx0i/0ucDtEh4b0NQE3Xik8yDeCiU
 OgzQh4hyHUeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="289031260"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2020 14:08:57 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:08:57 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:08:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Apr 2020 14:08:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTwvmIt1FsoyzBuPOhGHsx5sWIjpsegrlCph2XIkQp2+Dt80ebunvNfGo6p8DF8vgTcUYoFaeniwYhPo0jyrE0trqWJSHIttUxP6LoaMBUHYcZVCwULuTIa9JMbVUkfrX3T2J6maiRxj/mdmrraObpwNGoIcObBzLbhl3trhvf34UsXt4WsHRo/aqC1aj7/TBILRWUbImf3suapa7w5SM1GPUR0IlkgsQ66lcdq4X/UKgwecEXXQn1jFr+eeYmdTJisjP4jFOENIXce65H8c3tAT7gKY3REGZNy3Y2Rw9H976x6R4xFIxrFH7fA00tBTNShfUTVO8enpk/A5riON/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk5B6mTAdBOS1Iuf0d4JhH3VeErtI3ka3zBka4nD1h0=;
 b=Fmigb4VufNbUVAKwO4Azr4Hjn0Hz4IFllIHZO3I1pzu+f3eAzbKoSnPmfg86DS5f0YED7BBxGMr9LI8lBSenl3UrW3r5UIYRHaasuh9aeZpb0ZIrPQ12gtzFYC2hDuuvLMG48db9blKPEYb8E3Bd2a+XK9PjasmeLRM2dPXazOTNIG/vWkC95OzJgBVufwqCUYT0tGn+DVyBBCErd18yEHSAotkBa0Y0ra5a9vuEiUfBF7Y3IvRhgisEP8ErHb8QgjVs2XGV1f+/DqYWGzxbWRyj9GuNmIR63uT1vhK/ZZc+Xni9m8WIVAfq4zywD3NeFCKnymlqUrNFXXqb+O9Xaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk5B6mTAdBOS1Iuf0d4JhH3VeErtI3ka3zBka4nD1h0=;
 b=vq1o2Rvc3gfGc5trdQCjmRis3PuaATsqS9AnxDYsMbskePMtH+zsoIbAW/S+R2p2GnsX+7zC+RAChQwGi639cY0N/jO0o+aYv+quQJ01fClFY+fZ2Y5+ffInpm7PXztT+sYoAuhfQ6L4dOfJu3e3khI1zNCvzctJ6esEbvI9DnU=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 21:08:55 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 21:08:55 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: RE: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWFBA18200UyEIcUiReZoCYrPtRKh8CiGAgAAb5yA=
Date:   Thu, 16 Apr 2020 21:08:55 +0000
Message-ID: <MW3PR11MB45555D053D389175F030BF9BE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
 <20200416180201.GH1309273@unreal>
In-Reply-To: <20200416180201.GH1309273@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jianxin.xiong@intel.com; 
x-originating-ip: [134.134.136.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae0437c6-0b90-4d5f-cacf-08d7e24a5f72
x-ms-traffictypediagnostic: MW3PR11MB4729:
x-microsoft-antispam-prvs: <MW3PR11MB472969DEA7F5D02D893B41F1E5D80@MW3PR11MB4729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(9686003)(55016002)(4326008)(2906002)(4744005)(6506007)(33656002)(54906003)(5660300002)(7696005)(8936002)(66946007)(66476007)(66556008)(66446008)(64756008)(52536014)(26005)(478600001)(8676002)(71200400001)(76116006)(86362001)(6916009)(316002)(81156014)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0W/ynGfHG4aI2bY5RU9vrdZ4KLji7cF8cDmfEKvYstud6I7rCooz1r77M8PFMpZ68CeZ22Glp9E3Arfv4dBVIGIgbZpZ3FbPBuW3Pcj007bWXMsF2TVQ1gJFMFKtEtdRs1oOvpid3yJqSxnKBjLtPLmBM5eVmUCBSaCLf1LrBYbZFxVhfaY6M3RzpgUbXXC75YfRhQdEw89R4ERnuySnycgC1wbRUlgBXuUDwY1nA/4RYNLvzq1ozf7JEfuopPIDbvDKQNlh7HyQ3yDJaQsbhGAdpTfgJStMgiknDID5WnMkc1cTUHuACKtmA8FNFuPccZgEJO/rIKp0Y08sDVQZefTYkV3DWeIy0mv8xY8fDYetZ/2bm0sBMuYXMt5RLXN0UjYnJ4k4qlok+l0cMkOVX81Ccin+GKa81aV256LDIEostoK5uA/w7C9lXUryWX27
x-ms-exchange-antispam-messagedata: uxGAfHYxS197CfBvGpz6o+coDWZSvMC/gSmZyYem41CLck2yqbrtl4gz0ALbWA59zk8oBcdgnGIneWCv0IHso8e9ck2KFd+lltWj3tjRnsPlWExhUJ3cI81LMVDvmKPbRLkH37MamghQ9rnXZ6Oqkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0437c6-0b90-4d5f-cacf-08d7e24a5f72
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 21:08:55.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Nt/BrKucYYVssE9K51RGRLNS6XXiZVGKXh4WZ8Eye60iogsczltEq/PoRFIE+4l/iPYFBkORgOl6WI6NFw1Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > Dma-buf, a standard cross-driver buffer sharing mechanism, is chosen
> > to be the basis of a non-proprietary approach for supporting RDMA
> > to/from buffers allocated from device local memory (e.g. GPU VRAM).
>=20
> Where can I read more about "is chosen to be the basis of a non-proprieta=
ry approach" part of the sentence?
>=20
> Especially HMM vs. dma-buf in this regard.
>=20

I will write up more details. Thanks.


