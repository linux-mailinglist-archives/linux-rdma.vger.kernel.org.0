Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D46F28407D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 22:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgJEUPx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 16:15:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:24371 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbgJEUPw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 16:15:52 -0400
IronPort-SDR: mTKEQQHBVlHwSMvHK8CVY1zJ8w8LUHDe8wxjuvM20QlW0GTiNhCcM7DYmoEoPMx3UPRhkxkWNl
 vio5onkkzI1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="143898649"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="143898649"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 12:52:28 -0700
IronPort-SDR: hmnrpWZ1fB8jQ2NHhX3/R+teIQRl7T5JWPC/XUv35iRKBXFDQyXlaHkBz1xOrQqgT7QqB4VyYn
 GHlU4W1j0IYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="341382171"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2020 12:41:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 12:41:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 12:41:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 12:41:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 12:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL11yby0QNSi41n52WIz0KChFQ6BSUhGHZsolK3gWY5ur9V1CfctjkgwrQ531jM86GOo/HOvqZUoZ3WUItHdwDm4JvGS0o+AowsttmvrSuRx2dt2E691eHsFxjBtf/lQAATkoWfbEHKJsAGyvOoxzkJowOxsT1IKMsDjge27fkzAbgs+V0al4g4v1dyP8/bQO67dJAKAqzbolDC0+xemkL7MDgldph8AvzxOcp6UGSr7eL/HNkzZ9sI0oGj0uK0zStUWGhNpdpmHkKN+atDZbZ25Be1HVGH4gFJ2nqKtEd5WnqnM1WXFWqU68mYVPUD92Iinm8+ohhBBRz9E2UWn7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tge0R2Qtvl7YoAyI5eIUPp1RwU9bUPQvnGgY4J8v4hE=;
 b=nWZuw8qgeeiDs8nb/I4GpH3j/85rciA7dKQzGBroYMMI9zOVDTfD1+CbGXa7mUf+udxMOG9zPrUFudUa+uFbmuEwACClpDL0KGl7P4V+9g23glaU7/Ya6UB/a9NUcdMpLXYKDEK1SwkIFNperhoXJJuCTVII8bOD9bEzk0QIBc+Hkt31qHUvsDIbpzgKAMIzJsNjKc3d5QHixJRDmpaxvNKapml7RSMi9WStWS5WjWvjW4SA8qs0F74YtFISRhuv0KX9cyHYmn1mPKpX5+ufOwK572bLbS7DGn0ozIxUKe73hTbiXvGX3GBSUKRBZu67iUTBgyQjwEJ+M2zUkK/WkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tge0R2Qtvl7YoAyI5eIUPp1RwU9bUPQvnGgY4J8v4hE=;
 b=zWpeUwATV6AV09EIVZ0amk9soeghrRUOoRAIuyODnjqdIxCUQ3fp+2HBA08+L4AOKF9UmNJI35AZgoZv4cziTx5J3LcoFh4TXTNEpISMr5ANvsb+OHxu9QZawioUxFPzA0dozyfDupEBsji9ticnvQUQFnfrqRnxytn+cfFha7o=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by CO1PR11MB5076.namprd11.prod.outlook.com (2603:10b6:303:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Mon, 5 Oct
 2020 19:41:01 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7067:d996:719:10fa]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7067:d996:719:10fa%6]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 19:41:01 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWmoByzOf02BrPAUWXdhZKsQyBsKmI/YAAgAAfg6CAABhhAIAALlcw
Date:   Mon, 5 Oct 2020 19:41:01 +0000
Message-ID: <MW3PR11MB45557373EFC560F55CE5388DE50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1601838751-148544-1-git-send-email-jianxin.xiong@intel.com>
 <1601838751-148544-2-git-send-email-jianxin.xiong@intel.com>
 <20201005131302.GQ9916@ziepe.ca>
 <MW3PR11MB455572267489B3F6B1C5F8C5E50C0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201005163304.GU9916@ziepe.ca>
In-Reply-To: <20201005163304.GU9916@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.53.14.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bea4fe97-a2f6-4845-51c4-08d86966974f
x-ms-traffictypediagnostic: CO1PR11MB5076:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB50768964C49EF8ABC7CE83B6E50C0@CO1PR11MB5076.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4jPBLiU5XJFxKdOLf93gb2/1+j0gqfXl1QkdyHZQOewKYMzkKzLhPnwaWgNg5Yo8LmWQfAo7f0xVblwp8txvXSr1QVHVrJiGOjMAGrj0jOLCUoyoBRYnbiN5y+TMXGCZenVOkb2j4tXqCjNJaobbnGbM4+aLwOFYDCh85eqohtskrGV1ktM4dtyiMeNpfAWxW+drobwDYgMHB7QwJAD1sGIgay8mkLqo2FWov60fGbFAdStTF4r2oZFhslbrGz1IKgv3exdZJOH7D3TuqxR/XQe9YcgVu2EdWIUq1USLqemQUvi5v1pVpAbNsXuedSI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(5660300002)(55016002)(6506007)(8676002)(53546011)(478600001)(83380400001)(71200400001)(8936002)(7696005)(76116006)(107886003)(66476007)(66946007)(66446008)(4326008)(54906003)(186003)(64756008)(66556008)(2906002)(33656002)(26005)(52536014)(9686003)(86362001)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jxX8zC3+f0zpRfnAd+N01lbgtXwgiCGOT+JL8iMjHjjG1FUPEkV9cS/N+AZnBsTA3VXcyrThxrpEpF3g5IrXVKYYqjPuaKzi+FWDI2cvFk/8oaTkHD0xgOGXqJivkNzALQqmV7uTlUt4cAbjTX+X5qTZlEs8VgVPddlZxBsKFsn1/HFrdOOrpdGZBV2LGvVGq18DUektHAYao1KgkBriMMKbtqTTWtGixvCGMCcf29JjKSvq0ciaQAF/C7sZ45a6+r4GPOAVi3omjtIowP2mk9QpXdVvqdX3buiJFMvNKfUEnuIassi7GFCqTWWk3SbEirTOv5ei9gpF0bkIsbibA7WzyLaJ+w2U4/+M0ke/v+PziQDIjYYCPITZzYaxBsRGSHywbkh7wfGmneRWeh5+4qDksm79bZyHYPX1BrgwLHFVJ5vXwQq6DuhVM9Tfx+7HCpBxFBi8S+XQ0H8CM+ygj89WDXh5vL31zN0PTLyV4WoD8iGFnZTYNrkhTJypctgfrI1YIzQ1EfU3x0qdWfeSI4FgY9yiM5vv0XXCkJ7l4dmrAEJAkoFhvRTtDl7tEY0ZCeqS8tlJYfR6AScrp6OvA1kO4Bcz65NJRazgWhifyvvRh49m8DEE/uQ0KHYajMd8vTpDnQkgRS9uUtvhWVFVlA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea4fe97-a2f6-4845-51c4-08d86966974f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 19:41:01.7450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PNFa8LXQaOKi7+T5g3MxZp7zc8e8w5VRU0uIQZ3WAMli+EoemF8vCfKwdbvRdzrPD8Oitxq0OslyPA1v7oCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5076
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Monday, October 05, 2020 9:33 AM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Leon Romanovsky
> <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koen=
ig <christian.koenig@amd.com>; Vetter, Daniel
> <daniel.vetter@intel.com>
> Subject: Re: [RFC PATCH v3 1/4] RDMA/umem: Support importing dma-buf as u=
ser memory region
>=20
> On Mon, Oct 05, 2020 at 04:18:11PM +0000, Xiong, Jianxin wrote:
>=20
> > > The implementation in mlx5 will be much more understandable, it
> > > would just do dma_buf_dynamic_attach() and program the XLT exactly th=
e same as a normal umem.
> > >
> > > The move_notify() simply zap's the XLT and triggers a work to reload
> > > it after the move. Locking is provided by the dma_resv_lock. Only a s=
mall disruption to the page fault handler is needed.
> >
> > We considered such scheme but didn't go that way due to the lack of
> > notification when the move is done and thus the work wouldn't know
> > when it can reload.
>=20
> Well, the work would block on the reservation lock and that indicates the=
 move is done

Got it.  Will work on that.

>=20
> It would be nicer if the dma_buf could provide an op that things are read=
y to go though
>=20
> > Now I think it again, we could probably signal the reload in the page f=
ault handler.
>=20
> This also works, with a performance cost
>=20
> > > > +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> > > > +	sgt =3D dma_buf_map_attachment(umem_dmabuf->attach,
> > > > +				     DMA_BIDIRECTIONAL);
> > > > +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> > >
> > > This doesn't look right, this lock has to be held up until the HW is
> > > programmed
> >
> > The mapping remains valid until being invalidated again. There is a
> > sequence number checking before programming the HW.
>=20
> It races, we could immediately trigger invalidation and then re-program t=
he HW with this stale data.
>=20
> > > The use of atomic looks probably wrong as well.
> >
> > Do you mean umem_dmabuf->notifier_seq? Could you elaborate the concern?
>=20
> It only increments once per invalidation, that usually is racy.

I will rework these parts.

>=20
> > > > +	total_pages =3D ib_umem_odp_num_pages(umem_odp);
> > > > +	for_each_sg(umem->sg_head.sgl, sg, umem->sg_head.nents, j) {
> > > > +		addr =3D sg_dma_address(sg);
> > > > +		pages =3D sg_dma_len(sg) >> page_shift;
> > > > +		while (pages > 0 && k < total_pages) {
> > > > +			umem_odp->dma_list[k++] =3D addr | access_mask;
> > > > +			umem_odp->npages++;
> > > > +			addr +=3D page_size;
> > > > +			pages--;
> > >
> > > This isn't fragmenting the sg into a page list properly, won't work
> > > for unaligned things
> >
> > I thought the addresses are aligned, but will add explicit alignment he=
re.
>=20
> I have no idea what comes out of dma_buf, I wouldn't make too many assump=
tions since it does have to pass through the IOMMU layer too
>=20
> > > And really we don't need the dma_list for this case, with a fixed
> > > whole mapping DMA SGL a normal umem sgl is OK and the normal umem
> > > XLT programming in mlx5 is fine.
> >
> > The dma_list is used by both "polulate_mtt()" and
> > "mlx5_ib_invalidate_range", which are used for XLT programming and
> > invalidating (zapping), respectively.
>=20
> Don't use those functions for the dma_buf flow.

Ok.  I think we can use mlx5_ib_update_xlt() directly for dma-buf case.=20

>=20
> Jason

