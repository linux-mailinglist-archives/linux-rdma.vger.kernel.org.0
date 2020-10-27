Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A57C29C9D4
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Oct 2020 21:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830958AbgJ0UMC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Oct 2020 16:12:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:58050 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1830957AbgJ0UMC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Oct 2020 16:12:02 -0400
IronPort-SDR: bKFcQ6QM7WS9u/VnYtSwcQNB2HXA5tgzZ7C7eDs1ciTNdgF11uOd0ZojIymenxPXeguZ2qJypf
 hwbccCgDbF8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="229796251"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="229796251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 13:12:00 -0700
IronPort-SDR: r1HGGmvGJ2c1rENGkaLSYdTuR9bwG8oEFKH1tLcPoNhga60R+dVTFwABkArvW0Neek8os6sqAu
 2xCAZTNVif2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="304009719"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2020 13:12:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 13:11:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 13:11:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Oct 2020 13:11:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 27 Oct 2020 13:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoVLvBJgWMYP4jW9R0d30Td2gzKZ8bIF/jF/a9MOb4/TDY8egIF8+DPBEl03aA8L+HzyF8zCkIfvrPND4RXM8ZBhfSyGqtMtzL6xIPhE7PtrRG8LM9kjZJxZcSifRU5ThaF/UyaKZ1AYuUdUylljtEXI3BF0Xi4K9qI93Zyzd+4LJsHbeDOmSnuw3paeoNhEcbbs8Cpf2rgzXWvFxhqDO+FC/r9MJQreNCxs6NWP3K7h7EuKo1f0MVzmnPIC9PsAjN9iOKCThbQW6OFN0jX870UBgMrnJN+YFkpsTDEnPRmj1Rk8MfQADeikZ4PUy2RZneFg9VlerFGAihqJAKPBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV3sShGk+xgbxaycCUNkiHsjQviqwKuqSbq0rh3e0fs=;
 b=ZR76+IBH21FG+EIDM+vTJL5rrW8ZogDr6TUieTbF5GqNDgpfygONIiWJuiTk6JH2noLMT/s4x9aF3VFp6/YLlSZBatXIhzbQPCanCdxcAHlYA2bOdV/592pnz0/QHkn7sVMpHWLJuuaB/VUVHbX4pYGf3t55i3aJ8mvazitlFeqgCMUgHGi1RLhtAf2pUA+DFVhIvMJZODMj1iTvd0x4gxGAuaGdWoLWTB43TQyMa4nPNGFDPpR/R1SnhKKOmWj0AZW4LcYOfyJzZvqNPU/sO/wjlQwLLM0JaSQE7+g8r4ZwjgfiCuNMu3y6djU+kcewU+1wUTFWLupEvhpAxMnBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV3sShGk+xgbxaycCUNkiHsjQviqwKuqSbq0rh3e0fs=;
 b=riJxTJE8GodP2crxSMMNoJVsvQwspJl6Z4bElCors1ugGO6SS9PwUZf3fUqY7v/TOpmkLjup9XzCqp0vo3ri8aHCZFzVy+D39DIN2wYI6ucs/erhOVZnFgTXzx6+tRhVBMj/0UJuF7CgQguKiu+hdPazkYrhV9ZHWtic0NjmPxw=
Received: from MW3PR11MB4555.namprd11.prod.outlook.com (2603:10b6:303:2e::24)
 by MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 20:11:55 +0000
Received: from MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7067:d996:719:10fa]) by MW3PR11MB4555.namprd11.prod.outlook.com
 ([fe80::7067:d996:719:10fa%5]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 20:11:54 +0000
From:   "Xiong, Jianxin" <jianxin.xiong@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Doug Ledford" <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Sumit Semwal" <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: RE: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Topic: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user
 memory region
Thread-Index: AQHWqVlE332Lg1o1rU+Qqd8CQ3VTXKmr5NkAgAACHAA=
Date:   Tue, 27 Oct 2020 20:11:54 +0000
Message-ID: <MW3PR11MB45554BC784229BAF55469390E5160@MW3PR11MB4555.namprd11.prod.outlook.com>
References: <1603471201-32588-1-git-send-email-jianxin.xiong@intel.com>
 <1603471201-32588-2-git-send-email-jianxin.xiong@intel.com>
 <20201027200010.GW36674@ziepe.ca>
In-Reply-To: <20201027200010.GW36674@ziepe.ca>
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
x-ms-office365-filtering-correlation-id: 772e9f57-fd37-48b5-97e4-08d87ab48c9e
x-ms-traffictypediagnostic: MWHPR11MB1423:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14239D5DB482E8C76D743C15E5160@MWHPR11MB1423.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: khYjCLrkJ/+bskAEfqB1k6+i+xlM52EEIf4HVRBtzZHmakmNkHLHjDTVxYL0WpUAi0NC0aWqlXuwXwo2Iedhu3jtC8udAqO8MbUcmSM5w8PVAPY/Q3+cdsmzxcduFkDmmnK8glw5p02tB7T3srv5bxQXmgLYnTy+jz2fU2v3tmpwtGDkrtQMMM75OOBK1MgCspfgbfH+nAhEWcKQ0metz1/f5fkkyzNe43LSoKvIogyU236h8aL2VvSujsHNNZhgxTaMqqZWXYiMLe9CubsPGwSvorKNgM12sYaO1odEQ3wxoFK16kBykIw2FQhvKG+1eLjHsN4MOIPpYzcqz8A5r9ztOwSfIamItdPeZzoyJdjyZoyYLx/wZk9hTRH1dpQ/2N3Om2ucPOffAC9W/wWqbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4555.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39850400004)(396003)(966005)(71200400001)(33656002)(9686003)(86362001)(186003)(478600001)(8936002)(6916009)(8676002)(6506007)(53546011)(7696005)(26005)(64756008)(55016002)(76116006)(66446008)(66946007)(5660300002)(66556008)(107886003)(66476007)(2906002)(4326008)(54906003)(316002)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nPZfC8zI9HAdbrFIQvVJCRQvSV3aI1d09aIPi9VkKUdveZij50Yh+vtl0+/miV491eJZKIwx2jkUskup7Rkoc9rzZ53mnl/zYLVpT3gORvfJBYWYq/uBtlaf0bRfFGbpAAnF64hKF5gfWzNWxZy/QADRh3KyE/hiiEN2OfddAQ/PE3fsVY81VUKhdBR/jpclJTaXAI4x2OoDrFBTrd8N4ejIoJI7LmfmftiDlowMNTq4zjvtbSTxycp8mnAXj1sC6uGmIzsgBJmxzfB4gBYvpe7KTo4TqR2S5p30aQgMefxMHavpe6L3MNgnFLjzvKT+firr7IpJX0p2pE1bHSEb3s1ek5i4nhUvr2F0Ez/3tHXeL1eabjGtRFzZiXPdjfKVR78qVyK0ryCDkO8paUKO44LvnYKF0qdGfDD43Duxk7/AXfwboBnXS+dzUlhhLoLKYluJofJJyNPsoLUZxrJmUUdeW3lf8MRiVBFi2C3XGOhONW8o27uoqN6V96Y85fWsfjA8l6Uw7IW8tOQrBwiEMKAb9anQfYYZYvTC8t9hzTe6mVBeosvbj7F7N1d6N2zZUUmv7H6DxvUUsqB84UhrI2JC3Ax2O7wUCYKDBx9RyvapDrFVJ3I8fpM+QIuYZ8JM2DfZAuhoySZzBP9CfC84VA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4555.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772e9f57-fd37-48b5-97e4-08d87ab48c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 20:11:54.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7sjKPpr3MP6fRWv0T9IyJjKQZlH9lmPjq+qypSRz5HlUHnb4fI6ijzPSVDKwlhyt5wlgZk0Jxr37ICQGnBTqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1423
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 27, 2020 1:00 PM
> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> Cc: linux-rdma@vger.kernel.org; dri-devel@lists.freedesktop.org; Doug Led=
ford <dledford@redhat.com>; Leon Romanovsky
> <leon@kernel.org>; Sumit Semwal <sumit.semwal@linaro.org>; Christian Koen=
ig <christian.koenig@amd.com>; Vetter, Daniel
> <daniel.vetter@intel.com>
> Subject: Re: [PATCH v6 1/4] RDMA/umem: Support importing dma-buf as user =
memory region
>=20
> On Fri, Oct 23, 2020 at 09:39:58AM -0700, Jianxin Xiong wrote:
> > +/*
> > + * Generate a new dma sg list from a sub range of an existing dma sg l=
ist.
> > + * Both the input and output have their entries page aligned.
> > + */
> > +static int ib_umem_dmabuf_sgt_slice(struct sg_table *sgt, u64 offset,
> > +				    u64 length, struct sg_table *new_sgt) {
> > +	struct scatterlist *sg, *new_sg;
> > +	u64 start, end, off, addr, len;
> > +	unsigned int new_nents;
> > +	int err;
> > +	int i;
> > +
> > +	start =3D ALIGN_DOWN(offset, PAGE_SIZE);
> > +	end =3D ALIGN(offset + length, PAGE_SIZE);
> > +
> > +	offset =3D start;
> > +	length =3D end - start;
> > +	new_nents =3D 0;
> > +	for_each_sgtable_dma_sg(sgt, sg, i) {
> > +		len =3D sg_dma_len(sg);
> > +		off =3D min(len, offset);
> > +		len -=3D off;
> > +		len =3D min(len, length);
> > +		if (len)
> > +			new_nents++;
> > +		length -=3D len;
> > +		offset -=3D off;
> > +	}
> > +
> > +	err =3D sg_alloc_table(new_sgt, new_nents, GFP_KERNEL);
> > +	if (err)
> > +		return err;
>=20
> I would really rather not allocate an entirely new table just to take a s=
lice of an existing SGT. Ideally the expoter API from DMA buf would
> prepare the SGL slice properly instead of always giving a whole buffer.
>=20
> Alternatively making some small edit to rdma_umem_for_each_dma_block() an=
d ib_umem_find_best_pgsz() would let it slice the SGL at
> runtime
>=20
> You need to rebase on top of this series:
>=20
> https://patchwork.kernel.org/project/linux-rdma/list/?series=3D370437
>=20
> Which makes mlx5 use those new APIs
>=20
> Jason

Thanks. Will rebase and work on the runtime slicing.
