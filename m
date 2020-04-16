Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9631AD1A9
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 23:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDPVC4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 17:02:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:27098 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgDPVCz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 17:02:55 -0400
IronPort-SDR: peLxmdjemx2tb44y1kg3lH1dXUyy0a9wYsKDS7bXdcO3Dr0jPlUz0lx9mXhbpxZzNUVzng9n74
 zOWCK+HzkY7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 14:02:55 -0700
IronPort-SDR: xG0VCl5hoV5bx0DYS1QnqBE1iihwJcCVKdFhwX/VRVhfksvDTJaEAwlmwl8fPdHXc3SBSManLQ
 R11RN9RuEGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="278138511"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 14:02:54 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:02:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:02:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 14:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCl6DktjvIPQNHxJ8q1it4BhB0LscZWitdLv7IPGqn8/YHmBsfXV7JCPqxqxHRYoz3Uv/ANeiCoZlUKweaMI0bdYftT5e5lAsX4zcPCEsjr64V18y35ORVNB7LBe6Ip1LXwnNfYk9T8Fg5Pq9Rwuib30YN2CvYna4bNFH2yjRAGpAciPM6xfN3SGaswh2FqSPwka+TUxu227dOBsMGCEz6D0ohsw9xwk7ER1HZjDZCRvWseYXs/TDJB4iXNa0JBx0fhgq4n3jAjNiR3Em+lgtnX/lM+kfwgmtGR3nGKLLqHfEJT+szZ2Huqc3Op/48rqZs0xnqpqE50CamGNq6Cu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz1oZ8Atb+tR8G+kCaiFuaX7jZBx48WzC4iALI7MuNI=;
 b=Ms9k8YbDdpsoRT58WUF0+vqzNNSNPUYEsDQ0PoLikMAdHDhUIEciGx9Ss/yrw4FnL3nBkdheuN/arkVVkqjO7NXTNqWJTUhog3Saa+l3AJn19LKVBifchkSXA2okFj/nXB9rY2L+kcck0lEOg7h1rGOWKWjqDH5sdprDRjm+gkc94P660TSpcQKU/BqFp1tR66i91L8tIa78MfFIfLCoYa9rHoAwPvwZCaccnNCjimg5Ql5T6QUai4cnGhIo7J9u+PcdCuHEjYlX9Z/rPsuZzUrC9L+g98w4f7asYjmNvf803ofKNKSNWbpbEeIDXmAQXbi/NbsOgvi0aVslzR45hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz1oZ8Atb+tR8G+kCaiFuaX7jZBx48WzC4iALI7MuNI=;
 b=ASHxNnIOY3ab5eDKIzqC6xof+x/m+4+DcVFeaSm1ap6B1C2NliJeWhzm4GkGHlheb3zcjwM3Du0UNAK1g5BB2c5IFbohurk9buyFXK2KZ0bZXmIsYYZkSbbjTyxa/TPjUjTNA0920faW6qYW2RofsbtvfR/IZ9jf7SEOtlphjHE=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4729.namprd11.prod.outlook.com (2603:10b6:303:5d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 16 Apr
 2020 21:02:51 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 21:02:51 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Topic: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Index: AQHWFBA3dsUND9lDWUyvrL59SuGKJKh8CCQAgAAKdtCAABFDAIAAD3aA
Date:   Thu, 16 Apr 2020 21:02:51 +0000
Message-ID: <MW3PR11MB455530A5F7B5544A56C0CC33E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <20200416175454.GT5100@ziepe.ca>
 <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200416193408.GB5100@ziepe.ca>
In-Reply-To: <20200416193408.GB5100@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 6c949250-ac5a-43b1-d8a8-08d7e24986b1
x-ms-traffictypediagnostic: MW3PR11MB4729:
x-microsoft-antispam-prvs: <MW3PR11MB4729360D2E45BCD6F38185B6E5D80@MW3PR11MB4729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(346002)(376002)(396003)(136003)(366004)(9686003)(55016002)(4326008)(2906002)(6506007)(33656002)(54906003)(5660300002)(7696005)(8936002)(66946007)(66476007)(66556008)(66446008)(966005)(64756008)(52536014)(26005)(478600001)(8676002)(71200400001)(76116006)(86362001)(6916009)(316002)(81156014)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XfAaqptKTtDB+DHAAhKmL5psdVTdcjenWGwTHnfcbWPHByI+oTTytIjHdU4HaD1p41B5dOI1Xe7RsOLPDWB61IGQHxaKABJ81NswIgaoaKKKHzjFnUBdmGMYr9V1GHwjnH16gNxUjyXRx08R3F4Mq/zyGP3DCkg3rOMlaqZ8XJALwkhZwd+zsGyY7v9BV3Q2ZIomy6YB2RBQM/4j5ezcEpFutcuhd7ggPx/A5TodrOSVNvp4zUydNU3uHuylOawJ0Z+Va40MZEJbw4xbIecwu9PKdUJz+M7XhLBsJbNmRb3Su8F8Kyuuu+iiTDlaKkGQC/xjV7mhJzkiTCnA+utC04Wds4PmOyc2QTr94+2aMC2f2BJISDZ5OxNL0Zkxk/9OUjtMkZBGRCYVVx/cKH3R4qTa4jRNbza/P8dvCMxnlCFZhFTlf1u+Ti6f8/+2fIHwxq6g0qjDANRW1Df9Xo7CKh4HtRw5eMfIgJkIIVGivz0HPukySeGhBpg4U1gPPSdakQY+LOUgVZJmD70Ee4LFlQ==
x-ms-exchange-antispam-messagedata: GACbnuTGrt9KHX20J7mCxO7yxB0hZQm62YjAJ+cshI/yLeOd3Qz3yOS+pti8EOtWdBrzearbgRdWXxvu05lEr9fTlAq1fV3yjHczvflYC1tdMrEsBcEiUMtICMA/5v9YnT2QOxGBe5YEcSaoXk/eGA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c949250-ac5a-43b1-d8a8-08d7e24986b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 21:02:51.5919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NL7ztfrWwy3AGxBzG9vk9pRucd2KN9qHvmTIcr56ZDZsWsQLYBoWoUMZ9cuwieFig/wfetB3yrmFowbmtoZ8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4729
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> >
> > Right, the GPU driver needs to cooperate to get the thing to work as
> > expected. The "p2p" flag and related GPU driver changes proposed in
> > other threads would ensure VRAM is really used.  Alternatively, a GPU
> > driver can have a working mode that assumes p2p mapping capability of
> > the client. Either way, the patches to the RDMA driver would be mostly
> > identical except for adding the use of the "p2p"
> > flag.
>=20
> I think the other thread has explained this would not be "mostly identica=
l" but here is significant work to rip out the scatter list from the
> umem.
>=20

Probably we are referring to different threads here. Could you kindly refer=
 me to the thread you mentioned? I was referring to the thread about patchi=
ng dma-buf and GPU driver: https://www.spinics.net/lists/amd-gfx/msg47022.h=
tml

> So, I'm back to my original ask, can you justify adding this if it cannot=
 do VRAM? What is the use case?

Working with VRAM is the goal. This patch has been tested with a modified G=
PU driver that has dma_buf_ops set up to not migrate the buffer to system m=
emory when attached. The GPU drivers and the RDMA drivers can be improved i=
ndependently and it doesn't hurt to have the RDMA driver ready before the G=
PU drivers.

>=20
> Jason
