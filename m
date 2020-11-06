Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228732A9983
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKFQeS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 11:34:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:3209 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKFQeS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Nov 2020 11:34:18 -0500
IronPort-SDR: Gjr9NdhO9F3AataZn96FQ4LPS6QT3FIqpGM957aKbb3P+TV5sdMqPuz+8SLY2j7jhoZ1soKjbO
 vtj3yGVdVcoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="166977220"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="166977220"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 08:34:16 -0800
IronPort-SDR: 9Gxr85BC0XjzlPwsegMgSxy5D9x1gvz14q+2Z3CEMegYfV4PFIqSNtA9layWz0io0Mr3OcKQfg
 wN3DAaJX3IUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="364222047"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Nov 2020 08:34:16 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Nov 2020 08:34:16 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 6 Nov 2020 08:34:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 6 Nov 2020 08:34:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwEEFK6wWUuEl8tYbmW0WbgMokkEAcOIw/P0nQb/sFtaRB3XhmDDo+G0rrGwtD8YNmowmsAXd9SuqZ1NNvgkqenuUrAbrzrqHAHT/8GYCkBYsPk5f7sLFyQmYsZ/Cwnj6g4rEt4kjcTP+FlDWHSDdi6+PKTTScmz+WpngGqDF1bq1YiURfeY6h9vAvSmDcRgfmKslsLdLnV7pnN+sz+KjdN+F/f5yP1mvR0SASDAPWLOm6hAj3J/WzVj2Tp5xqIQpBYXvP1DBjDB7l2UL68pOHqtIT2DwVq3o7/Bhr/x+aTXA97JAsPshZrKnaaweUCBZuKCXY2tw3gST2WhPeVhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDvrsUEZitVn8KQFGIJNLr3d/IJERHr9kY3FnGK0ABs=;
 b=iFo4SaTsWgTyw+HZylSUz6Ean+KFnbYGVCNMNxHF44gHoLxit5HqdFtLcnohBuOMwEfX7R6tRHEEfjJQGZtHFpuR/YixJegX6Hl56FjIREKkjlPzIQJ9J3KGR36SwLDH+FWgWaiRoIkyC0HpqqRr7Mnq9123D4xzw4obQU7DERDGN2DKYkiE6CXhBZfQqzwrIzSmukwg3x9wlXS3o1drKtIC/PR3mVhiXcAT+LjFYYy67arIgTXk9y4iDhv4HTZSVh2banbpgWNr2mVIBXWdUBZ8TNQ1cQrf+j37kwZX3EicO9tM6akr6XV/Cm8cIcYEVv/gHSKkRML8UeVkDwAkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDvrsUEZitVn8KQFGIJNLr3d/IJERHr9kY3FnGK0ABs=;
 b=muReRSj50HtAfrPPGB1oqeYydHU6uLKOnnPT4KOp3e21GoLzYoVSBlzmgXRwxFBP6t93PBikqwCRXw+vxE/Hrm7gjesfzTrT1rRQx7f8rw98/An8cIv3Z+hlb3Z2S/msbqpFx8ouAMIH1T9t6ax8HOFO44pPIrOHph6o4jJEWww=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR1101MB2318.namprd11.prod.outlook.com (2603:10b6:301:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 16:34:07 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::8d73:60dd:89aa:99a9%8]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 16:34:07 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWs8PR1fXMlpsAzEa77sJjy3Zc0Km6OnuAgAEPmYA=
Date:   Fri, 6 Nov 2020 16:34:07 +0000
Message-ID: <MW3PR11MB45552DC0851F4490B2450EDFE5ED0@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1604616489-69267-1-git-send-email-jianxin.xiong@intel.com>
 <1604616489-69267-2-git-send-email-jianxin.xiong@intel.com>
 <20201106000851.GK36674@ziepe.ca>
In-Reply-To: <20201106000851.GK36674@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: edb526f9-64d2-44fd-64f1-08d88271c83d
x-ms-traffictypediagnostic: MWHPR1101MB2318:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2318695F5374BB2BD5780296E5ED0@MWHPR1101MB2318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ia5eO8ZY4g3qy5JKA6pMYL+sGP0KJHKbrvnB6MwM6DVAWoxyNqruuEayszcZh2byWRPmDQD+aEcFFoWYIWGCO7edyxQJY+EAc4fXWtKz4StmynUPKII4plMY2eBl6Pf5XoI2VAPvZhHCr+yaIwnXQdDMFlAPwwk0wUCmk6+Sq2HvgIwUoXQ4hOfITBOVoFU5ir9MI/GEKwb1VJe63hSqT4mMNZBSToV/2U+muGWxgsst/9Ti9OB7BdJwSZLwykieQQ2XsBtPXS5KIxqEKUnLeIbhlR/h+CTBiHkbZ8Dm6Gv1yq9M6rDMqa0EolUh4AjCa+gVmcwICO2q+phD2bC8sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(52536014)(54906003)(55016002)(53546011)(33656002)(6916009)(6506007)(5660300002)(83380400001)(86362001)(4326008)(8676002)(66946007)(66476007)(71200400001)(107886003)(66556008)(64756008)(66446008)(76116006)(186003)(316002)(9686003)(478600001)(7696005)(2906002)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fwnrzGA5aIGkwVuGeNDnWBGcAIxro/ULW6g6vwNA+N9P9rrh50dHWSUd8rsMalzghnYdRwkxoU776I0J4VMBeewm0j2ptFgV0j54BX37+JcU8bAYjCoIJVM2PMslqzazFJHHYbNPu1TUZAX8WdjAyYiXV5Acc2m+6Su5BX5KY6x3N/62Zt4T1QJvVPI9+iqGJEvWhbtOwq+98LGRd8ctWS0UA8rl8vjOBnZD9tKkd6Ci2VG2jova35ThuX4u3lecdt91Oy+DUEzgcc8jIEDrgcE4WkgmCu7tAmpJ59HE/5ANK4OBM5XvP9LC89oKdepNJwo3M1qUgHRWdUDTU0sIM4DC81GylcH9tTRjlge5kedcO+b5p+c7NPxXDcmpkQqBS/pI7AlivYw77zCutIUaMgdfZfrdxfC7gWThiv/vUMdAcNJUR82tO6o8S2NDJY93lOzMMd/M2D/q0/pNc0CMhbwkr0u/x5BSjyHxJMmlDQaPIEPN+Ggfbl/+4+QJ5h8sYkcf7PMMBnnOBNqvRATXVfBtC8VMJDlzbLnxGX12/OGB+2SuGMVAfb2BrbRTaNBLXe1Kxb4Ptkyix0EeXQpDLPKGcMkWOolwLV338Vzdz5LmPwO0AJXXzSreyWMDsxLQS+1NnPIN7ScbhzV9iABzug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb526f9-64d2-44fd-64f1-08d88271c83d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 16:34:07.4809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB/tceeUnU2uEAOLa3ZqfCnTy7gyQPJj0PnR1Hz3vK8XokR427vllNqfAHz/6oiv9fQUAxpzD5BlXqRkjFpP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2318
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, November 05, 2020 4:09 PM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Leon Romanovsky
> <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koen=
ig <christian.koenig@amd.com>; Vetter, Daniel
> <daniel.vetter@intel.com>
> Subject: Re: [PATCH v8 1/5] RDMA/umem: Support importing dma-buf as user =
memory region
>=20
> On Thu, Nov 05, 2020 at 02:48:05PM -0800, Jianxin Xiong wrote:
> > +	/* modify the sgl in-place to match umem address and length */
> > +
> > +	start =3D ALIGN_DOWN(umem_dmabuf->umem.address, PAGE_SIZE);
> > +	end =3D ALIGN(umem_dmabuf->umem.address + umem_dmabuf->umem.length,
> > +		    PAGE_SIZE);
> > +	cur =3D 0;
> > +	nmap =3D 0;
> > +	for_each_sgtable_dma_sg(sgt, sg, i) {
> > +		if (cur >=3D end)
> > +			break;
> > +		if (cur + sg_dma_len(sg) <=3D start) {
> > +			cur +=3D sg_dma_len(sg);
> > +			continue;
> > +		}
>=20
> This seems like a strange way to compute interesections=20

I can rework that.

>=20
>   if (cur <=3D start && start < cur + sg_dma_len(sg))
>=20
> > +		if (cur <=3D start) {
> > +			unsigned long offset =3D start - cur;
> > +
> > +			umem_dmabuf->first_sg =3D sg;
> > +			umem_dmabuf->first_sg_offset =3D offset;
> > +			sg_dma_address(sg) +=3D offset;
> > +			sg_dma_len(sg) -=3D offset;
> > +			if (&sg_dma_len(sg) !=3D &sg->length)
> > +				sg->length -=3D offset;
>=20
> We don't need to adjust sg->length, only dma_len, so no reason for this s=
urprising if.
>=20
> > +			cur +=3D offset;
> > +		}
> > +		if (cur + sg_dma_len(sg) >=3D end) {
>=20
> Same logic here
>=20
> > +			unsigned long trim =3D cur + sg_dma_len(sg) - end;
> > +
> > +			umem_dmabuf->last_sg =3D sg;
> > +			umem_dmabuf->last_sg_trim =3D trim;
> > +			sg_dma_len(sg) -=3D trim;
> > +			if (&sg_dma_len(sg) !=3D &sg->length)
> > +				sg->length -=3D trim;
>=20
> break, things are done here
>=20
> > +		}
> > +		cur +=3D sg_dma_len(sg);
> > +		nmap++;
> > +	}
>=20
> > +
> > +	umem_dmabuf->umem.sg_head.sgl =3D umem_dmabuf->first_sg;
> > +	umem_dmabuf->umem.sg_head.nents =3D nmap;
> > +	umem_dmabuf->umem.nmap =3D nmap;
> > +	umem_dmabuf->sgt =3D sgt;
> > +
> > +	page_size =3D ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
> > +					   umem_dmabuf->umem.iova);
> > +
> > +	if (WARN_ON(cur !=3D end || page_size !=3D PAGE_SIZE)) {
>=20
> Looks like nothing prevents this warn on to tigger
>=20
> The user could specify a length that is beyond the dma buf, can the dma b=
uf length be checked during get?

In order to check the length, the buffer needs to be mapped. That can be do=
ne.

>=20
> Also page_size can be 0 because iova is not OK. iova should be checked fo=
r alignment during get as well:
>=20
>   iova & (PAGE_SIZE-1) =3D=3D umem->addr & (PAGE_SIZE-1)
>=20

If ib_umem_dmabuf_map_pages is called during get this error is automaticall=
y caught.

> But yes, this is the right idea
>=20
> Jason
