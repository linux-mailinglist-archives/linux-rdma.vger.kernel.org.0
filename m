Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3B1AD026
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgDPTIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 15:08:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:58689 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDPTIV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 15:08:21 -0400
IronPort-SDR: 0VncqVuJHZPGmazrFxpf7BC367x8thEF0IpFtjpT6va943ukJyvmEmRjl0cghMVcYZF23ZuZI6
 k6tUDrFlJpig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 12:08:18 -0700
IronPort-SDR: H6IDGTEOSYGrm0rQ70klsZs5WPt4/VHjAOqThyecqwMtctTn2oLUmZkIQ8iHsCgkvwak6lRb/c
 dhTSWjpprymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="427948994"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 12:08:18 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 12:08:18 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX155.amr.corp.intel.com (10.22.240.21) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 12:08:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 12:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpbtLRBS+bGk2o5+4UY4OulhykxZLkDLuBK10VopMSjjn6GEIrmD8bJj8ZFzKNBiAXQD0P6Dl75hlSNv69Re6KMWruj9u5s32x9S2S0IMpYe7M02XwiOtjf5+YlmP1yXnGA6AT9pvzT+lUL2FA8QpkFEyLomEcIBhDtE47QB4nh0VrEVcNnQfSkSbOcjo6xW3uRhZMos1M8pz9/nxMqV9qDPSaCLQEfzdhnPCPkGOD1VJgqJ4/pYLIRAB0AdAE/+04c+E7eIMugS02/OSKOStD520fjF2cEilSrmdU54A+HmGV62Wt29FhKHBEVuVV6wRan6ATF0wPQ636HEyBiJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxUNjInDDa6WxtaVsIDFhSvxY+XvV8ZHAs01MzY3FCY=;
 b=UvLy+p/SnDEvrqanlyzK0+L1DbiMK/Xtm9g3adW08ViKt3A7kZPi+YrUbXRnOj9mOo5qIke5PX4nBLT8lQiXmWR9TEXfLUbly3yIfOc8VI2w/FL7E5JjUuVJzJF4we22xHmjiq8jv0ZZn6hPqFInBBMkB5BCxJuhV2pUAZfcJ6k/MqihiwpGOaDR12W2AkeEJS0K9iVTZc+qsyJNKIRkpYBkr5gNiJHLConXDRfk47asiTQJ6K4Fm387HQswG4D02kWxeONI2hY4mqbxwM0I0hymgERgBxT2QjR5SByZwhJVs358yivl/tfkyaeFAMWDvB7azwHHIo/7RO7kg66Psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxUNjInDDa6WxtaVsIDFhSvxY+XvV8ZHAs01MzY3FCY=;
 b=ODuF32Lr2jloidlcgbPqQbjcXlYp90v9ou3T5QbV+xwjwZUcufrcCY1IzB4nVfi83+HFTs1COPS4YtGOK28nXfxpC6PXSwYzLzcTZzFoWpIMA9FxhW1LCuyD1wOjk6sOuBXXk9VlKEhZc516wTru5AxK3676y2BykQAuLcVkWKA=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4585.namprd11.prod.outlook.com (2603:10b6:303:52::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 19:08:16 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 19:08:16 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Topic: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Index: AQHWFBA3dsUND9lDWUyvrL59SuGKJKh8CCQAgAAKdtA=
Date:   Thu, 16 Apr 2020 19:08:15 +0000
Message-ID: <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <20200416175454.GT5100@ziepe.ca>
In-Reply-To: <20200416175454.GT5100@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jianxin.xiong@intel.com; 
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b92fcc4-69df-467d-5ae9-08d7e2398484
x-ms-traffictypediagnostic: MW3PR11MB4585:
x-microsoft-antispam-prvs: <MW3PR11MB4585E0217496AC01779E229BE5D80@MW3PR11MB4585.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(366004)(26005)(54906003)(186003)(8676002)(33656002)(5660300002)(2906002)(478600001)(9686003)(8936002)(66556008)(55016002)(76116006)(81156014)(71200400001)(316002)(86362001)(6506007)(6916009)(66476007)(66946007)(4326008)(66446008)(52536014)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syKq7R3iuNbqEFoHZOe+kvsLLbxE0g/96164uFXijPY2UgD7goRjkiPA/mSppE9KJXj3J7urxwKS+jyOzH0YrKmi6pFqtDPjjZIcm7gldMn0TA5lLL2bjvkA2bAKUgIF9pYTiE4oLO5mt0Mavo8gSJYc2I1Spo5ib8XWLwfnFdkYYUxozs1HVxVNxw6dnORSQr1N5qUG6NsgH5f/hHKhjvQCjZ7WmCR7ODtsIYPa6baUu5rxTacPZc8M859lhhx1v+OxAOppxqtamrmaH2fCKkQxDUvJ0DOxAiM6ywcYB9gSMWle483l8J78EXSWs4iE99h2yaEuR6D4YYMTFeZnyoUVOSQVpibOgJ2zA+QCnk94Khzigd8fc0V1HZXIjiX4ue3FINYznbRROVeJZ2EZQULFS4Y4K1YYoRuzOf7qcnHb+pJogQk5sET61LSovfAO
x-ms-exchange-antispam-messagedata: LKQePMTVrYURmhSnco38/h6riaP7AGeZ8877sRgOq+QNcudBQwSZfudY8kuRWK9XpBfJWvksGRJuUXv+Ey9sIWU9Wa8aYT87JptNVuYmpp8z2+89u2IXkxwoGE6ZriCYihgF8HJs5bSpCOGSD4pjQQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b92fcc4-69df-467d-5ae9-08d7e2398484
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 19:08:15.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKqq3kM18tlMy18hiCRc6eDmGWlfC0fCNplY4YUQGTTdbBAiYlaaeIZIm835y7dYdlpXBOD+LN0uWeWKNB5MaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4585
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > This patch set adds dma-buf importer role to the RDMA driver and thus
> > provides a non-proprietary approach for supporting RDMA to/from
> > buffers allocated from device local memory (e.g. GPU VRAM).
>=20
> How exactly does this allow access to GPU VRAM?
>=20
> dma_buf_attach() cannot return non-struct page memory in the sgt, and I'm=
 not sure the API has enough information to do use the p2pdma
> stuff to even establish a p2p mapping.
>=20
> We've already been over this in another thread.. There is a way to improv=
e things to get there, but I don't understand how this patch series
> is claming to be able to work with VRAM - if it is that means there is a =
bug in a GPU driver that should be squashed.
>=20

Right, the GPU driver needs to cooperate to get the thing to work as expect=
ed. The "p2p" flag and related GPU driver changes proposed in other threads=
 would ensure VRAM is really used.  Alternatively, a GPU driver can have a =
working mode that assumes p2p mapping capability of the client. Either way,=
 the patches to the RDMA driver would be mostly identical except for adding=
 the use of the "p2p" flag. =20

> Other than that, this seems broadly reasonable to me as a way to access a=
 DMA buf pointing at system memory, though it would be nice to
> have a rational for why we should do this rather than rely on mmap'd vers=
ions of a dma buf.
>=20

> Jason
