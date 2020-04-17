Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B31AE27F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 18:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDQQt3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 12:49:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:36298 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgDQQt3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 12:49:29 -0400
IronPort-SDR: tuV6IdKfphsPkQMeHowmQkL0nR8ZLKcFy9ziGMGLfmnJq1OCCEwYDWlGVAHWFVKaLXtK9k8JI0
 YYtWySjI8DMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 09:49:28 -0700
IronPort-SDR: QB5A9vAiTHpgbvF2UkfwG9kXb9BvDU5EsezBS1meAnFHQNRFS3INKPhGaYtMr/ADWaqXxYMN0g
 t75wvwcc+tVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="455685264"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2020 09:49:28 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 09:49:28 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 09:49:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Apr 2020 09:49:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBedLWj4zhn6ZOsIAFDPDrCHUmCHwV9suToN/WOlq4jpCm8hdksllQ3eYtlZcA0AvVaUGRRPgEivOnVZjBlsvg3kVi76UcQVYm73Qovcu1cdhKak3MA0eIL8/WXqSAsLujGGUh517WDP3c/ggtrRB/4r5I7UrcbCUr/mVTaqUfLKGNfPDpiUcVXTPxsAG9i7wbYAWtuA0gE/rXleCtQBOZDVahL49Tu3Zun9Vj0YahABl1seoz2xiypIrpMMwAndArSZHKkJPO6gSVzz9Qv3l5gozsl7uoL4d6/+0u7BIW8obRTAVKYikrXDlS+/LroQx7+jfKAKdFkgkk/qaGz+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R92ZhHDaAYi+txGxpJ6oyR65nxg1DfwA08k50PHeyns=;
 b=RaUjkgUrzSK80Tf2qPl0V+RIRbAwTC+/WH3qhvb8JBAjQsVPqjplpel4Wz0UcebT9vPWkHo2AApfg1FmUy+KnpyzvaXzRGtSGGX2lMVuZX0vdA1DozdacLsF/RL6qaiPDTEaTe/0KQ109gaEjPHkkw1udX5x/H2Q9QVtcr3/C6so68jXH0lEQvtbN0o3TwQUPBWWIVP+7KGjwYa5cLvql3NkZVYrEdk54hh8MjCbCUCfE9hnarsRKmj2DoOiwyCWqO5Y6g67wgBBfly5mtJKD80uejE+gjQbUaekN9ten2j0g+IrADzqwegTbAjg4X2ephsywz+ePZ7DMUeDS462oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R92ZhHDaAYi+txGxpJ6oyR65nxg1DfwA08k50PHeyns=;
 b=gwZl55W9RSR+8txCyBRGd568ZJd6e8JXnx+c7EgVmspMXwakrmowwkU/TrdGs5DfeM6ZWPAcVlO/VtRHJzYXSk4sDGN0PFaTA6+BlFQ60VhMtNFW6Cr5BW9d7xFP3YDKebNVDTR9dzNQFFLFsZ+0q6UWIgkrSFp3Ctxo2TM8XWc=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MW3PR11MB4619.namprd11.prod.outlook.com (2603:10b6:303:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:49:26 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::1916:3bdd:3f40:fd36%6]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 16:49:26 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Leon Romanovsky" <leon@kernel.org>
Subject: RE: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Topic: [RFC PATCH 0/3] RDMA: Add dma-buf support
Thread-Index: AQHWFBA3dsUND9lDWUyvrL59SuGKJKh8CCQAgAAKdtCAABFDAIAAD3aAgAEN0YCAAEAaoA==
Date:   Fri, 17 Apr 2020 16:49:26 +0000
Message-ID: <MW3PR11MB45557A7C29D0D922D46B0A99E5D90@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <20200416175454.GT5100@ziepe.ca>
 <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200416193408.GB5100@ziepe.ca>
 <MW3PR11MB455530A5F7B5544A56C0CC33E5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200417123511.GB26002@ziepe.ca>
In-Reply-To: <20200417123511.GB26002@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 989e5055-30f2-4443-d187-08d7e2ef4a36
x-ms-traffictypediagnostic: MW3PR11MB4619:
x-microsoft-antispam-prvs: <MW3PR11MB46191765C8124D622EC8C17DE5D90@MW3PR11MB4619.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(39860400002)(136003)(376002)(316002)(186003)(86362001)(54906003)(81156014)(8936002)(6506007)(8676002)(26005)(7696005)(64756008)(966005)(66556008)(66946007)(76116006)(66476007)(478600001)(6916009)(5660300002)(52536014)(4326008)(66446008)(9686003)(71200400001)(2906002)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0I51mscbrH4IKUeeHxw7/HzpRFQNa3kq8Z+lmBWf3kXRJhj7ulVqWQHqz8k94dUjIV/zQz6rcI108+LSQHVRchD4Z//NkEy8K5i5148iXu6EvoKOiYmUFIU/ji7jIXyGhSl7mWtmaQyxp+SjKeodVXcu9zBTREKuQUDn6R8Stdg0rhSIdwbatTRdVZc3IrpcLb66p47q3TNPdFccmgERxrq9LSvjqVlk/mPT9z4S15SnU2Fd+W2Mb25jSczg1lU3Cor++Sz+YdOPiF1o6qQVGjs4x3BR/GzBzK5CySROgSFff8gmPf/OPlSesSGdCXbgbCiMsQG2MKn6lvvSmMqOT+8oQP3GZt7qvBOf+POM33tYUPdfr37jzTt1d+TdnxkT/l7dZkWg78sTe8WosH6q5m5BJOqD1VYpBxQTPl4sRJ8zjM3uNkT95gMrVBmkkO7VFAyo9Hkzjj9SYH4Qd/WPaSSmjmPCE3qO0KWnU5fUdOR9jjA+LgRLA9MAWgt/BHBfGmOEKhCp85YxV2Y5MGScWw==
x-ms-exchange-antispam-messagedata: O/gXe+Oz7/iJHHXjB3l23XmDjiCvFm1LnKXHDZPMmPa46OzQ/JpZydLd91OQrlBzw91YRURB/TRViWzZ6ob2Jtf7Ws4MwEimcgTqXVelGleXayGHTqlULYUTJUSq36Na1lrMlpKUfVjdr1dOswVxrA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 989e5055-30f2-4443-d187-08d7e2ef4a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 16:49:26.5297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RgV3IIRpcvkBlgi8W3yWLhMYl9+iNdmQ+M9NOFDb2fcDQKeHN3AW+7cWriIBkOejPwsHkVFW+MWzcn1fIjNSSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4619
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > > >
> > > > Right, the GPU driver needs to cooperate to get the thing to work
> > > > as expected. The "p2p" flag and related GPU driver changes
> > > > proposed in other threads would ensure VRAM is really used.
> > > > Alternatively, a GPU driver can have a working mode that assumes
> > > > p2p mapping capability of the client. Either way, the patches to
> > > > the RDMA driver would be mostly identical except for adding the use=
 of the "p2p"
> > > > flag.
> > >
> > > I think the other thread has explained this would not be "mostly
> > > identical" but here is significant work to rip out the scatter list f=
rom the umem.
> > >
> >
> > Probably we are referring to different threads here. Could you kindly
> > refer me to the thread you mentioned? I was referring to the thread
> > about patching dma-buf and GPU driver:
> > https://www.spinics.net/lists/amd-gfx/msg47022.html
>=20
> https://lore.kernel.org/linux-media/20200311152838.GA24280@infradead.org/
>=20

Thanks. We are actually looking at the same series but somehow I skipped th=
e details of the single patch that looks simplest which turns out to have m=
ost complication. I agree if scatter list is not to be used, there are goin=
g to be significant work involved.

> > > So, I'm back to my original ask, can you justify adding this if it
> > > cannot do VRAM? What is the use case?
> >
> > Working with VRAM is the goal. This patch has been tested with a
> > modified GPU driver that has dma_buf_ops set up to not migrate the
> > buffer to system memory when attached. The GPU drivers and the RDMA
> > drivers can be improved independently and it doesn't hurt to have the
> > RDMA driver ready before the GPU drivers.
>=20
> Well, if there is no other use case then this series will have to wait un=
til someone does all the other work to make P2P work upstream.
>=20
> Jason
