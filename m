Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8662C3028
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404301AbgKXSpi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 13:45:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:25844 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404000AbgKXSph (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 13:45:37 -0500
IronPort-SDR: VXZvW+D+/sJ/Kh/BJPRZXBZVWmtww+n9vioPnMffm7QPJ/1/qI4eyPrMlfA9vc7INB++jFLl+z
 5u2iot9EVzXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="168489418"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="168489418"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 10:45:09 -0800
IronPort-SDR: Cv1Nil7uc2S4TuVkGt4za36Vjipr+J+QM9Aob3omj2L5pG99xKyjO5e0kktelZ+oOT2LbzIvO/
 rvNQ0qewC+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="361986366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2020 10:45:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 10:45:08 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 10:45:08 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 10:45:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 10:45:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaqxxzOBJCYM9RwpWnZ7mrSbAbv86lk0hgiHVHYzJDsiiuJI4wX711yFe7OYchx9cAWwsMY4YpqFUPegvJpq8fvNo+AA7rbfdPycqP3ygMs9LS7KDGkyVl94clyoxNTfpNC+FIu9QZfO7RZo2GVU9cfINCal10lXw+4oYjdmsbaZe4x8KB1jDDJPzXjpqW/CBCuvTRtBSTNmY0s3Za6cmmKm0dJ11OOKRcnruG95+3b+4MpxI0miTWZ3iROVOHwVgeVT6+rpVWImEKqJXMLGpmYx0MpM0hw4ldXvEdhg9lCU0P56t4KOf7pKe2FvbYUM+OtmL+iVKnqLd1T5cX0J8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zARWarUopNdu6+c+NvPv50QcCJ0XEyMiM4XN1LUTWKo=;
 b=IrrKJqUjt0NwMV72vJDLZEf9cYhRDU4EccXO8oe+KwJ54uP1J5nvAVFO5LgDwnFUJcDD5FEoizqoGDtzz7JtYbqLwliojID3TDIX6KAKd78dfkCwf4nSZq7uZs29KFXe+Ovl+pIu4QttD03mWpXzOeEP8wXtldYTl1fUUmK3Y5HOUOJ0Efng2z0F8sbIgBwi7rJlIH6dc30yMLV1Ak0PuW77RmSz2IJin+CdNrZYfHSj9VFV+yCVl55v9jJUC+3r7/s9k6ImS5pEWha9VhyrmRJTnHR4/q+uHj827RrbfPmX88Lv9BBFYhbmGi48eVxxLdDlLPRtULrkn8+jgjwxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zARWarUopNdu6+c+NvPv50QcCJ0XEyMiM4XN1LUTWKo=;
 b=et6rCQ3DHpWOSu7b1YGZeQvQjevV+7I/AZqxQfbWGyWqI46xeMpfRFZAmE9MWVga3n+ARA8xwdV1jKgY+E9KvijdeJA9sDLmX6eFk5uwNzEvLaqOHS4xuuo/4J610UTb4ArReSjksiUKvuvFKeQ6E9QccYgoUa+bQOE6CR4c5do=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1261.namprd11.prod.outlook.com (2603:10b6:300:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Tue, 24 Nov
 2020 18:45:06 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7510:71a5:3cfe:ab94%8]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 18:45:06 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: RE: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Thread-Topic: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Thread-Index: AQHWwb+RTBTJqBZYLEWXdlNPeqTq1qnWAtcAgAFjXQCAADV8kA==
Date:   Tue, 24 Nov 2020 18:45:06 +0000
Message-ID: <MW3PR11MB45554AAEB1C370A78EB87816E5FB0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-4-git-send-email-jianxin.xiong@intel.com>
 <20201123180504.GA244516@ziepe.ca>
 <20201124151658.GT401619@phenom.ffwll.local>
In-Reply-To: <20201124151658.GT401619@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24153831-b3d2-42f0-9b31-08d890a90fee
x-ms-traffictypediagnostic: MWHPR11MB1261:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1261BAABE0C9FF673283020BE5FB0@MWHPR11MB1261.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:42;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Os++LVB8j5h7BGq+KLqAEFW2GOVqsHZfirIHfasGqFchfa1xmhM2eqIbrF+ByNSaZ+DqKEOCDxI/Y49x6paLYBH5FFqfMR+dEPNa4dE6hD4ooF9D3QbgjDOAQuK+1LaWy1zRsyWa6TwpIKNpV5RYOLrkAlcMDDH9S2fnKX/BaBMs+UqedvgnpajxtHryz88n2jfHIjx9NtkNPkvGdm0cdegvtBp3J24VClreIlB+I0gXOl2ZjAAbZupI2fIaJy2xxLZGVjWq0vB9BbgL7NsCCc6UD0R2/yeq77dtI2JecG9mz+mptfMWRf9M2xAqIBtGzlBmeLQH76c/BmYfJ5+bxMm3cvEOrEbaVBppIw/3cs5GVS443eXS+CC6typLtAfdM82vthQ+KrLhF+1rinXSXfCEnCMjwAJ/x/BFiWIb6J5mh1ZqDy+1Pd1oI2NRU9DmvpB/Jw359gE1dSpXe3ftyM0vu2vuTH7gebpX3Dxfy6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(8676002)(52536014)(55016002)(5660300002)(186003)(4326008)(83380400001)(966005)(53546011)(54906003)(7696005)(478600001)(33656002)(6506007)(110136005)(86362001)(316002)(26005)(66946007)(71200400001)(83080400002)(2906002)(66446008)(8936002)(66556008)(64756008)(66476007)(9686003)(76116006)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?omvkWQ5skvhxbilUDRKBSupD2d/R+bI54+gDoJ7XaXGHX1JzLA0oAfsX0ByL?=
 =?us-ascii?Q?hN3jr8LL6sKE1udcu2/6c4bENE/RlaOfk48nd9vi9pDBFbSlspYE1IxlhNuh?=
 =?us-ascii?Q?Xk9Ml45hBVhW4E2gJbXqyE8iBeBfmhZ3RH4JDdwwUemXU3r4q9KaBdPPA9tT?=
 =?us-ascii?Q?ApzU7leZ1fnzS/gwm1G/hI7BPnTgc7vJ34gpGr4GBhqvOyb52LLSYEQoaouP?=
 =?us-ascii?Q?3jxUkscH28Fr1pN7DZnQ0Ettx0M+NHEAT/A2kLPjz+G+XmPEvxKshRT/6MKE?=
 =?us-ascii?Q?PUzY+QOOuosSmbyT9w3wD8TmQpzsYEieYR0o8khSiUWkMJdUNwWAMuWuCvba?=
 =?us-ascii?Q?4fDvQ4C+yZuCd1GzzdUDhD34alWvPrFXYrQx5ADNEzcO+tyxdECkP2e1h88Q?=
 =?us-ascii?Q?DEbqZ3Mfe/i/f18lvf86Aw1ryJYfOjHTmvPXdLYdGtnkt+yUDfX64A1M7B9v?=
 =?us-ascii?Q?UQMb5VjMIagzGrhOc0IteQ4YoHVOoSnAEk3pVJw2fABsvANCqb4PpsQSlhOD?=
 =?us-ascii?Q?p75w2oi/I6LwwpAR+Qrxw69fOmsmhRhr+hCZTinwN5nJ0R70gPkZtx21MBrs?=
 =?us-ascii?Q?27ZIOHiIW+XUGOFfJUxeGu17jERWARpwFtaxJaD1IZ/B+95gX1KWyWGSCATR?=
 =?us-ascii?Q?MEnCuwxhobQ9MaWhS3ApytfUxJZffJ6ObARVv+JOrEJ8eFy5A+fv5kWJQOyX?=
 =?us-ascii?Q?9bP0+QJ6Iel9irui21axOhZpC14IHRMQCIdfjg/DDKQod6RfYRnjQPsSmQxl?=
 =?us-ascii?Q?rUxT9jg5Em4ALFEUPmEF00kO224JStSpGs92LYBqIVlcHZfjdg3h+ywDDDsC?=
 =?us-ascii?Q?fTeNDPSkB3eW5LZXxL9LWFv5pGGvyntG3imcrt1fzIPvZVoeZl5nXOCS6duF?=
 =?us-ascii?Q?b/m6zL3gq85hQ/sBVJe+HDRrgfLPzNbUFsOCSzw76gKWNWtw+e9ZA2y9Qx0/?=
 =?us-ascii?Q?DD7g57fIXcUdzmxy3bT0dgzbD4/pBQR6sglUuVXTIpA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24153831-b3d2-42f0-9b31-08d890a90fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 18:45:06.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHk2adrHIx4x0YXJaUHcZcbDD0JWENO4CfwDqTNKMUnZnmGc07wM+Bpf3sAobywKebsy7D6qmV6WaD9HG91eMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1261
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Daniel Vetter <daniel@ffwll.ch>
> Sent: Tuesday, November 24, 2020 7:17 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Xiong, Jianxin <jianxin.xiong@intel.com>; Leon Romanovsky <leon@kerne=
l.org>; linux-rdma@vger.kernel.org; dri-
> devel@lists.freedesktop.org; Doug Ledford <dledford@redhat.com>; Vetter, =
Daniel <daniel.vetter@intel.com>; Christian Koenig
> <christian.koenig@amd.com>
> Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
>=20
> On Mon, Nov 23, 2020 at 02:05:04PM -0400, Jason Gunthorpe wrote:
> > On Mon, Nov 23, 2020 at 09:53:02AM -0800, Jianxin Xiong wrote:
> >
> > > +cdef class DmaBuf:
> > > +    def __init__(self, size, unit=3D0):
> > > +        """
> > > +        Allocate DmaBuf object from a GPU device. This is done throu=
gh the
> > > +        DRI device interface (/dev/dri/card*). Usually this
> > > +requires the
>=20
> Please use /dev/dri/renderD* instead. That's the interface meant for unpr=
iviledged rendering access. card* is the legacy interface with
> backwards compat galore, don't use.
>=20
> Specifically if you do this on a gpu which also has display (maybe some t=
esting on a local developer machine, no idea ...) then you mess with
> compositors and stuff.
>=20
> Also wherever you copied this from, please also educate those teams that =
using /dev/dri/card* for rendering stuff is a Bad Idea (tm)

/dev/dri/renderD* is not always available (e.g. for many iGPUs) and doesn't=
 support
mode setting commands (including dumb_buf). The original intention here is =
to
have something to support the new tests added, not for general compute.=20

>=20
> > > +        effective user id being root or being a member of the 'video=
' group.
> > > +        :param size: The size (in number of bytes) of the buffer.
> > > +        :param unit: The unit number of the GPU to allocate the buff=
er from.
> > > +        :return: The newly created DmaBuf object on success.
> > > +        """
> > > +        self.dmabuf_mrs =3D weakref.WeakSet()
> > > +        self.dri_fd =3D open('/dev/dri/card'+str(unit), O_RDWR)
> > > +
> > > +        args =3D bytearray(32)
> > > +        pack_into('=3Diiiiiiq', args, 0, 1, size, 8, 0, 0, 0, 0)
> > > +        ioctl(self.dri_fd, DRM_IOCTL_MODE_CREATE_DUMB, args)
> > > +        a, b, c, d, self.handle, e, self.size =3D unpack('=3Diiiiiiq=
',
> > > + args)
>=20
> Yeah no, don't allocate render buffers with create_dumb. Every time this =
comes up I'm wondering whether we should just completely
> disable dma-buf operations on these. Dumb buffers are explicitly only for=
 software rendering for display purposes when the gpu userspace
> stack isn't fully running yet, aka boot splash.
>=20
> And yes I know there's endless amounts of abuse of that stuff floating ar=
ound, especially on arm-soc/android systems.

One alternative is to use the GEM_CREATE method which can be done via the r=
enderD*
device, but the command is vendor specific, so the logic is a little bit mo=
re complex.=20

>=20
> > > +
> > > +        args =3D bytearray(12)
> > > +        pack_into('=3Diii', args, 0, self.handle, O_RDWR, 0)
> > > +        ioctl(self.dri_fd, DRM_IOCTL_PRIME_HANDLE_TO_FD, args)
> > > +        a, b, self.fd =3D unpack('=3Diii', args)
> > > +
> > > +        args =3D bytearray(16)
> > > +        pack_into('=3Diiq', args, 0, self.handle, 0, 0)
> > > +        ioctl(self.dri_fd, DRM_IOCTL_MODE_MAP_DUMB, args);
> > > +        a, b, self.map_offset =3D unpack('=3Diiq', args);
> >
> > Wow, OK
> >
> > Is it worth using ctypes here instead? Can you at least add a comment
> > before each pack specifying the 'struct XXX' this is following?
> >
> > Does this work with normal Intel GPUs, like in a Laptop? AMD too?
> >
> > Christian, I would be very happy to hear from you that this entire
> > work is good for AMD as well
>=20
> I think the smallest generic interface for allocating gpu buffers which a=
re more useful than the stuff you get from CREATE_DUMB is gbm.
> That's used by compositors to get bare metal opengl going on linux. Ofc A=
ndroid has gralloc for the same purpose, and cros has minigbm
> (which isn't the same as gbm at all). So not so cool.

Again, would the "renderD* + GEM_CREATE" combination be an acceptable alter=
native?=20
That would be much simpler than going with gbm and less dependency in setti=
ng up
the testing evrionment.

>=20
> The other generic option is using vulkan, which works directly on bare me=
tal (without a compositor or anything running), and is cross vendor.
> So cool, except not used for compute, which is generally the thing you wa=
nt if you have an rdma card.
>=20
> Both gbm-egl/opengl and vulkan have extensions to hand you a dma-buf back=
, properly.
>=20
> Compute is the worst, because opencl is widely considered a mistake (mayb=
e opencl 3 is better, but nvidia is stuck on 1.2). The actually used
> stuff is cuda (nvidia-only), rocm (amd-only) and now with intel also play=
ing we have xe (intel-only).
>=20
> It's pretty glorious :-/
>=20
> Also I think we discussed this already, but for actual p2p the intel patc=
hes aren't in upstream yet. We have some internally, but with very
> broken locking (in the process of getting fixed up, but it's taking time)=
.
>=20
> Cheers, Daniel
>=20
> > Edward should look through this, but I'm glad to see something like
> > this
> >
> > Thanks,
> > Jason
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>=20
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
