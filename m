Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E925377C1DD
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjHNU4T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjHNUzu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 16:55:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53ADD
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692046548; x=1723582548;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dr5vDxkddS7JqRBcGpuvMQC0MCIYe6tAhpHtgLA1zpE=;
  b=MxVtWNySg6rbf0e7i0EB6FZLxnFFfEeBFG3Jd2wopLmW7Ju0tGmHP/T1
   sx2r+hT2G9zNN2IaO3tNd/hOEApUWQfcRTY6SxZ4Hn841hPs8soQ1upoB
   7jC5O4RaLzAiUUgwk4Y85CwrEkxVSpXLQq2TEsxQ1QFDqYawSPnF0AIOR
   RTOOazteR06uCeZ0f03uWxIPUTJwfMPggsML+GcvfFwYVmHvrbqBPed7i
   URn3UEPeSSCnxTcQE/4Dhxky+YX711u8RoZjbIi0CDiWNZDsKwXLHl8u/
   b1zX7+g6fbvEOFHtk132ihB0iBnCd/pS1fcBu72Xogjyxk6vdjtPsWwLo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352463967"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="352463967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 13:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733600922"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="733600922"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2023 13:55:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:55:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 13:55:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 13:55:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 13:55:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5YjrO52UXqoWZAziGaTFlbvmqTaZ7M5qXF2fXZnMWzDPe1N8CNupFV4z3DHGi+XRe7xYvmSFV9HyZ7YfrTSUc3x2/nFTpQOIiVTB1zMwuWsxZqJpDL5Z6XA1seBeDXl1GTdh2NahVh+lfq2ILh3p/eyqNYwpG0fnsNHPruDbM6UJjnGfS7BZjC/cwnnlXg+aPOj5yTgd0PisrRHcg1wWyxncHMiBLgkwZEaNN9nYPssZF+2nRw+0vvvgHLseCL3z3zFdsV70ECjyKmpD56UI9jF06gwlBEPljs7qudpqQRLDNmRQxLScOgwoYwJKAvlACMDKgRh7DbIfJaYJc6QCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSlzHBiq0PUTLU4eWF3SZqSKaonjJHcXow866yOYPIk=;
 b=Mb0/wIKsju/rv0sUdWo05lzZBuW5smWvfuvRCPOVtSQ2pyeG7YjETw8PRqR01H4jb7DLS2hIC4sJIMYld/vOjI3w7gGsj/BIrTqwpLenyKK3PGH06J2MsVB91q7trdFd7ieqdbkfvnt/MijwgrVqq/4LuZ8Zpo27hMNEMhFc3kNjDgfQGCdOaDYGeob1BKt9KFV59EzHZfNmgLaL8NYfSBOWzh/MQ54WaGjKidDK0LAaCpko6csdMY/xczKzAW1SB4NAw6VDODFxXfcKPdw/PobXSKreSkAr6yKjO0glIZuxVQPizScT5RuuLqjxAvNCYAe0DHklL0pZP+IadWOUFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 20:55:44 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fc26:895e:efab:9269]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::fc26:895e:efab:9269%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 20:55:44 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH -next] RDMA/irdma: Silence the warnings in
 irdma_uk_rdma_write()
Thread-Topic: [PATCH -next] RDMA/irdma: Silence the warnings in
 irdma_uk_rdma_write()
Thread-Index: AQHZzBxWX8mwPg9AsE2fzHbDH3DshK/n9yuAgAI52PA=
Date:   Mon, 14 Aug 2023 20:55:44 +0000
Message-ID: <MWHPR11MB002969B2763A53C37368615BE917A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230811062215.2301099-1-ruanjinjie@huawei.com>
 <20230813092235.GI7707@unreal>
In-Reply-To: <20230813092235.GI7707@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|SJ0PR11MB4927:EE_
x-ms-office365-filtering-correlation-id: f06cd6b9-a58c-416c-bdfc-08db9d08d3dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nnmfoUIsSD07OuWNDgGY8KqS4pOYVhBv5G1uqkq8EraU74Xe7prEvSAWnJbJGCo03WqQ9ewFPqxYW/0fxa2XtsJ+o7sgjwvaej4tsuyOicO7ilNJ+nqaEGiwAK9Q42iqyZwMrDDPhpDQUma4+VBjiOirMmxJkWm3mdvrvQHGqiCormAjy6mB1l/3nNaO3LqH07nc7fs2iij2cW7ngLxeLVVSriK1KZaTDG6pjM4Eu+7wv4tm+RYiyTMeM0ytP/ceTWkSgxSnYraL2FjAGPPkAQhJitzd7kDkXogZON+TGdvWByUesJYWOX66AdB1V+fTy64yCihTKMpNAgzN4YR+OjxWUuk39zo56wB0UrALrskaHGntOUVS3dDigLhnUfBOKv6qNwg8DSdIoXNQl+cGpeoQMba3Zz1OW8ockgeYkZZ0ETIGwYiL264EZ7/OAI9HB6h4guGwhrOHmB6BMMNtQo/q2erb/RZ+O1GGbt7+v79z31HWFGofKRBCVlu9pq5ceMWBHgnsGhrJ8lajJRsY50XN5ZylquH/bpp7RcO0OsCTqgpjBFmNB69xVyNfIfFDt6z6qNK+iEFWFr/Ugt6409066fZ5EejI9xUgGEwCWpjztqMIZGMPOdZOd9DOdatO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(366004)(376002)(346002)(186006)(1800799006)(451199021)(55016003)(83380400001)(82960400001)(966005)(478600001)(122000001)(71200400001)(8936002)(8676002)(316002)(66946007)(4326008)(64756008)(76116006)(66476007)(110136005)(41300700001)(66556008)(54906003)(66446008)(38100700002)(38070700005)(7696005)(6506007)(26005)(9686003)(86362001)(2906002)(5660300002)(52536014)(30864003)(33656002)(579004)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ocqnAfnKqhvI/cQkNkBwxW9jmIV/5s3Gz9LonZ2YYrgbZA2r/mElY7XdDJka?=
 =?us-ascii?Q?oGN2oNJkaMjrqPAyN+rUTyVeJ6VQiNQE7Eej2fpqjNGJKPI0Wkj6E/Wa/Hnd?=
 =?us-ascii?Q?TuwC5Zm5bdftLTC3NqMYTXtcD2OVgsa7pg6LK0i5UrKKz6tAQlozKr8AwUpN?=
 =?us-ascii?Q?ZL/LXPgAQPOjbc0j8Zb7rxE3bsocUY+CJfkbZ6qin7pJyyyreLEYH73uaRui?=
 =?us-ascii?Q?+S4PqwR/1EPyxraLUAfpuiEc9b7WB0KHdZPFn3v6JQIsGPun4PjY4SdhkCxO?=
 =?us-ascii?Q?/6HfFRmZpLqv7xExBqF9FwUZ2F3IeeOemPBpfd3C3x3Z8swoe6ld1kbWIFdp?=
 =?us-ascii?Q?ioj/HjlVrGz073U+9Dftx5lDlfPi7nq/HhqBgFtLIL6k9nPOiVTIvY6TwZ/2?=
 =?us-ascii?Q?a3OYfVDumXbJYekMzCFZSkzWPsalr+pGjeo+Bb8LSoyWCb3aoioBr9f7qXNU?=
 =?us-ascii?Q?bB5qZPbxA5pOdf8PjObHtTennklWgf9JwFNzSLEOiSBoIlILlZDdqCKtd2ks?=
 =?us-ascii?Q?p6+mZKVRy5hz/R696YYzGu9EzbiakdXVvyePdfJ2lpQNK7X2ClDNmDf5MpZp?=
 =?us-ascii?Q?scZAMSzWH/SdDZ5rX5nPFQ6nZXLMePVakg2kabXLBSHPxjUQaF9Xk1PsIt1Y?=
 =?us-ascii?Q?BiX1Grzl2M3ecpq+sAPzfzeDALZK3VY7VMWeqcZvA2aY3dHnhqrbbDu5sUKd?=
 =?us-ascii?Q?EEM54tSEzH3ix1Dd9gABFLUVv2B/UpiFNkkwR9tLenS2qR+UbqnWcamAjYDh?=
 =?us-ascii?Q?ErTQOsUo3T4ENaAlnxw1nLl1DpHVKGvdALWsNcR2nrzN8YTEwRoFZWT5gaLn?=
 =?us-ascii?Q?/Q06NbFJEcApy1LiZReoh8C4G7VSb/F6VGQa88vvU9RkUP08egsliLozlJU4?=
 =?us-ascii?Q?OuZShD7n7JZcGKNvSWXRsVDb6QYwOt2EJd0LJeR57erhOo9IIaAHyYE1xJRy?=
 =?us-ascii?Q?ppxhyAJLs4zohypfOJVTadhfw6a41++6sXZsuncGdVDtGn81+SJscPc9Phhd?=
 =?us-ascii?Q?REebFLnFxqektsukqNyJVNRmi3cuCji8KMhCSKHL2kB7UuiudslVYqhoxZPJ?=
 =?us-ascii?Q?3Dw4v3+pjbf109lAf5+TZxlN4I9XaObYDO+gaqxJ3K6m6yUJ9/+8tyv6yOEb?=
 =?us-ascii?Q?/epp29gKNVpRVCs0qU/nVjQyPUTAMG+TEo3Yk8M0rUq2p8Ya9s1ljylAVPMR?=
 =?us-ascii?Q?N44H1PhIicK2ASprolhetC89ltMsOhmP8ssSeEXMH6hmW4wpV7P0FrJuGCdB?=
 =?us-ascii?Q?SGBNjsByZbmofqXZmRFSr7OBY9W8H8CUnpBFSn8G6fgtTnsqMFsDDyBAt+9f?=
 =?us-ascii?Q?NZZnY4ZvtnPQ62N20HFfvbr4ikfRjob1wMGWvDXfrNpCyT/Vqi4Uggm2jWYe?=
 =?us-ascii?Q?L+LQo9fllVSjRxk8XZmv3lG9ULz2mAYIRzDntgmVxnRJv/wSjOQL6I0/O23Z?=
 =?us-ascii?Q?y0Eb/G6nMT07trjp1p+Cb8fvTioKQrPTlzUwJqIuc2yHS6eosAov+Oi0T0Yr?=
 =?us-ascii?Q?y+2yT2Cqeq8F8CAB04tpfivUikxEXQcpXiDz3QDkIjS2veb/Nzph5bod5zTX?=
 =?us-ascii?Q?UbqAUFfBsZAosSQ9+70A8MXxJ7y16YV9B4wB/9LY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06cd6b9-a58c-416c-bdfc-08db9d08d3dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 20:55:44.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hboSRDFjLTDQIC+T0R5VaIFpP0xPGFl66Fq747hQe+DGLtYkLT1zOea49OxUa/X317MUfxcTqcMAJZDln8DRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH -next] RDMA/irdma: Silence the warnings in
> irdma_uk_rdma_write()
>=20
> On Fri, Aug 11, 2023 at 02:22:15PM +0800, Ruan Jinjie wrote:
> > Remove sparse warnings introduced by commit 272bba19d631 ("RDMA:
> > Remove unnecessary ternary operators"):
> >
> > drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> > drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> > drivers/infiniband/hw/irdma/uk.c:471:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> > drivers/infiniband/hw/irdma/uk.c:723:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> > drivers/infiniband/hw/irdma/uk.c:797:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> > drivers/infiniband/hw/irdma/uk.c:875:24: sparse: sparse: incorrect type=
 in
> assignment (different base types) @@     expected bool [usertype] push_wq=
e:1
> @@     got restricted __le32 [usertype] *push_db @@
> > drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     expected bool [use=
rtype]
> push_wqe:1
> > drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     got restricted __l=
e32
> [usertype] *push_db
> >
> > Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.
> > com/
> > ---
> >  drivers/infiniband/hw/irdma/uk.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/irdma/uk.c
> > b/drivers/infiniband/hw/irdma/uk.c
> > index a0739503140d..363c67c18924 100644
> > --- a/drivers/infiniband/hw/irdma/uk.c
> > +++ b/drivers/infiniband/hw/irdma/uk.c
> > @@ -282,7 +282,7 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, str=
uct
> irdma_post_sq_info *info,
> >  	bool read_fence =3D false;
> >  	u16 quanta;
> >
> > -	info->push_wqe =3D qp->push_db;
> > +	info->push_wqe =3D !!qp->push_db;
>=20
> Shiraz, push_db is declared as pointer, but I don't see where it is alloc=
ated. Current
> code works because push_db is always 1 entry.
>=20
>   316 struct irdma_qp_uk {
>   ...
>   324         __le32 *push_db;
>=20
> and
>=20
>    156         set_32bit_val(qp->push_db, 0,
>    157                       FIELD_PREP(IRDMA_WQEALLOC_WQE_DESC_INDEX,
> wqe_idx >> 3) | qp->qp_id);
>=20
> Such variable use is not great. can you please fix it?
> Can Ruan use "qp->push_mode" check instead of "qp->push_db"?
>=20

Hi Leon - Thanks for bring this to my attention.

Seems we don't have all aspects of kernel push implementation and yes
the push DB not mapped renders it void. And this code is also in kernel fas=
t path :/

kernel push is not plan of record at this point and the patch (below) clean=
s it up. I can send this to the mailing list.

I am fine if we want to spot fix the sparse issue through Ruan's patch here=
.
qp->push_mode and qp->push_db are not really equivalent.
The latter is constant once db is mapped. The former is transient per qp, c=
omes and goes.
But its all mute anyway as it stands now.
=20
Or we can just use my removal patch to fix the sparse issue as well.

diff --git a/drivers/infiniband/hw/irdma/ctrl.c b/drivers/infiniband/hw/ird=
ma/ctrl.c
index b8e96992f238..55421a92882c 100644
--- a/drivers/infiniband/hw/irdma/ctrl.c
+++ b/drivers/infiniband/hw/irdma/ctrl.c
@@ -1307,7 +1307,6 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
=20
 	sq_info.wr_id =3D info->wr_id;
 	sq_info.signaled =3D info->signaled;
-	sq_info.push_wqe =3D info->push_wqe;
=20
 	wqe =3D irdma_qp_get_next_send_wqe(&qp->qp_uk, &wqe_idx,
 					 IRDMA_QP_WQE_MIN_QUANTA, 0, &sq_info);
@@ -1341,7 +1340,6 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp,
 	      FIELD_PREP(IRDMAQPSQ_HPAGESIZE, page_size) |
 	      FIELD_PREP(IRDMAQPSQ_STAGRIGHTS, info->access_rights) |
 	      FIELD_PREP(IRDMAQPSQ_VABASEDTO, info->addr_type) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, (sq_info.push_wqe ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -1352,13 +1350,9 @@ int irdma_sc_mr_fast_register(struct irdma_sc_qp *qp=
,
=20
 	print_hex_dump_debug("WQE: FAST_REG WQE", DUMP_PREFIX_OFFSET, 16, 8,
 			     wqe, IRDMA_QP_WQE_MIN_SIZE, false);
-	if (sq_info.push_wqe) {
-		irdma_qp_push_wqe(&qp->qp_uk, wqe, IRDMA_QP_WQE_MIN_QUANTA,
-				  wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(&qp->qp_uk);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(&qp->qp_uk);
=20
 	return 0;
 }
diff --git a/drivers/infiniband/hw/irdma/type.h b/drivers/infiniband/hw/ird=
ma/type.h
index 16ada4c2ced0..bee9609f4be7 100644
--- a/drivers/infiniband/hw/irdma/type.h
+++ b/drivers/infiniband/hw/irdma/type.h
@@ -1017,7 +1017,6 @@ struct irdma_fast_reg_stag_info {
 	bool local_fence:1;
 	bool read_fence:1;
 	bool signaled:1;
-	bool push_wqe:1;
 	bool use_hmc_fcn_index:1;
 	u8 hmc_fcn_index;
 	bool use_pf_rid:1;
diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma=
/uk.c
index 6f9238c4fe20..e803c30d88d9 100644
--- a/drivers/infiniband/hw/irdma/uk.c
+++ b/drivers/infiniband/hw/irdma/uk.c
@@ -127,10 +127,7 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 	hw_sq_tail =3D (u32)FIELD_GET(IRDMA_QP_DBSA_HW_SQ_TAIL, temp);
 	sw_sq_head =3D IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
 	if (sw_sq_head !=3D qp->initial_ring.head) {
-		if (qp->push_dropped) {
-			writel(qp->qp_id, qp->wqe_alloc_db);
-			qp->push_dropped =3D false;
-		} else if (sw_sq_head !=3D hw_sq_tail) {
+		if (sw_sq_head !=3D hw_sq_tail) {
 			if (sw_sq_head > qp->initial_ring.head) {
 				if (hw_sq_tail >=3D qp->initial_ring.head &&
 				    hw_sq_tail < sw_sq_head)
@@ -147,38 +144,6 @@ void irdma_uk_qp_post_wr(struct irdma_qp_uk *qp)
 }
=20
 /**
- * irdma_qp_ring_push_db -  ring qp doorbell
- * @qp: hw qp ptr
- * @wqe_idx: wqe index
- */
-static void irdma_qp_ring_push_db(struct irdma_qp_uk *qp, u32 wqe_idx)
-{
-	set_32bit_val(qp->push_db, 0,
-		      FIELD_PREP(IRDMA_WQEALLOC_WQE_DESC_INDEX, wqe_idx >> 3) | qp->qp_i=
d);
-	qp->initial_ring.head =3D qp->sq_ring.head;
-	qp->push_mode =3D true;
-	qp->push_dropped =3D false;
-}
-
-void irdma_qp_push_wqe(struct irdma_qp_uk *qp, __le64 *wqe, u16 quanta,
-		       u32 wqe_idx, bool post_sq)
-{
-	__le64 *push;
-
-	if (IRDMA_RING_CURRENT_HEAD(qp->initial_ring) !=3D
-		    IRDMA_RING_CURRENT_TAIL(qp->sq_ring) &&
-	    !qp->push_mode) {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	} else {
-		push =3D (__le64 *)((uintptr_t)qp->push_wqe +
-				  (wqe_idx & 0x7) * 0x20);
-		memcpy(push, wqe, quanta * IRDMA_QP_WQE_MIN_SIZE);
-		irdma_qp_ring_push_db(qp, wqe_idx);
-	}
-}
-
-/**
  * irdma_qp_get_next_send_wqe - pad with NOP if needed, return where next =
WR should go
  * @qp: hw qp ptr
  * @wqe_idx: return wqe index
@@ -214,9 +179,6 @@ __le64 *irdma_qp_get_next_send_wqe(struct irdma_qp_uk *=
qp, u32 *wqe_idx,
 			irdma_nop_1(qp);
 			IRDMA_RING_MOVE_HEAD_NOCHECK(qp->sq_ring);
 		}
-		if (qp->push_db && info->push_wqe)
-			irdma_qp_push_wqe(qp, qp->sq_base[nop_wqe_idx].elem,
-					  avail_quanta, nop_wqe_idx, true);
 	}
=20
 	*wqe_idx =3D IRDMA_RING_CURRENT_HEAD(qp->sq_ring);
@@ -282,8 +244,6 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct =
irdma_post_sq_info *info,
 	bool read_fence =3D false;
 	u16 quanta;
=20
-	info->push_wqe =3D qp->push_db;
-
 	op_info =3D &info->op.rdma_write;
 	if (op_info->num_lo_sges > qp->max_sq_frag_cnt)
 		return -EINVAL;
@@ -344,7 +304,6 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct =
irdma_post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt) |
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -353,12 +312,9 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct=
 irdma_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
=20
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -383,8 +339,6 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct i=
rdma_post_sq_info *info,
 	u16 quanta;
 	u64 hdr;
=20
-	info->push_wqe =3D qp->push_db;
-
 	op_info =3D &info->op.rdma_read;
 	if (qp->max_sq_frag_cnt < op_info->num_lo_sges)
 		return -EINVAL;
@@ -431,7 +385,6 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct i=
rdma_post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE,
 			 (inv_stag ? IRDMAQP_OP_RDMA_READ_LOC_INV : IRDMAQP_OP_RDMA_READ)) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -440,12 +393,9 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct =
irdma_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
=20
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -468,8 +418,6 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_=
post_sq_info *info,
 	bool read_fence =3D false;
 	u16 quanta;
=20
-	info->push_wqe =3D qp->push_db;
-
 	op_info =3D &info->op.send;
 	if (qp->max_sq_frag_cnt < op_info->num_sges)
 		return -EINVAL;
@@ -530,7 +478,6 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_=
post_sq_info *info,
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_OPCODE, info->op_type) |
 	      FIELD_PREP(IRDMAQPSQ_ADDFRAGCNT, addl_frag_cnt) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -541,12 +488,9 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma=
_post_sq_info *info,
 	dma_wmb(); /* make sure WQE is populated before valid bit is set */
=20
 	set_64bit_val(wqe, 24, hdr);
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -720,7 +664,6 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 	u32 i, total_size =3D 0;
 	u16 quanta;
=20
-	info->push_wqe =3D qp->push_db;
 	op_info =3D &info->op.rdma_write;
=20
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
@@ -750,7 +693,6 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, info->report_rtt ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
 	      FIELD_PREP(IRDMAQPSQ_IMMDATAFLAG, info->imm_data_valid ? 1 : 0) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe ? 1 : 0) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -767,12 +709,8 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
=20
 	set_64bit_val(wqe, 24, hdr);
=20
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -794,7 +732,6 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 	u32 i, total_size =3D 0;
 	u16 quanta;
=20
-	info->push_wqe =3D qp->push_db;
 	op_info =3D &info->op.send;
=20
 	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
@@ -827,7 +764,6 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
 			 (info->imm_data_valid ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_REPORTRTT, (info->report_rtt ? 1 : 0)) |
 	      FIELD_PREP(IRDMAQPSQ_INLINEDATAFLAG, 1) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, info->local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -845,12 +781,8 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
=20
 	set_64bit_val(wqe, 24, hdr);
=20
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, quanta, wqe_idx, post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -872,7 +804,6 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *=
qp,
 	bool local_fence =3D false;
 	struct ib_sge sge =3D {};
=20
-	info->push_wqe =3D qp->push_db;
 	op_info =3D &info->op.inv_local_stag;
 	local_fence =3D info->local_fence;
=20
@@ -889,7 +820,6 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *=
qp,
 	set_64bit_val(wqe, 16, 0);
=20
 	hdr =3D FIELD_PREP(IRDMAQPSQ_OPCODE, IRDMA_OP_TYPE_INV_STAG) |
-	      FIELD_PREP(IRDMAQPSQ_PUSHWQE, info->push_wqe) |
 	      FIELD_PREP(IRDMAQPSQ_READFENCE, info->read_fence) |
 	      FIELD_PREP(IRDMAQPSQ_LOCALFENCE, local_fence) |
 	      FIELD_PREP(IRDMAQPSQ_SIGCOMPL, info->signaled) |
@@ -899,13 +829,8 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk =
*qp,
=20
 	set_64bit_val(wqe, 24, hdr);
=20
-	if (info->push_wqe) {
-		irdma_qp_push_wqe(qp, wqe, IRDMA_QP_WQE_MIN_QUANTA, wqe_idx,
-				  post_sq);
-	} else {
-		if (post_sq)
-			irdma_uk_qp_post_wr(qp);
-	}
+	if (post_sq)
+		irdma_uk_qp_post_wr(qp);
=20
 	return 0;
 }
@@ -1124,7 +1049,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
=20
 	info->q_type =3D (u8)FIELD_GET(IRDMA_CQ_SQ, qword3);
 	info->error =3D (bool)FIELD_GET(IRDMA_CQ_ERROR, qword3);
-	info->push_dropped =3D (bool)FIELD_GET(IRDMACQ_PSHDROP, qword3);
 	info->ipv4 =3D (bool)FIELD_GET(IRDMACQ_IPV4, qword3);
 	if (info->error) {
 		info->major_err =3D FIELD_GET(IRDMA_CQ_MAJERR, qword3);
@@ -1213,11 +1137,6 @@ int irdma_uk_cq_poll_cmpl(struct irdma_cq_uk *cq,
 				return irdma_uk_cq_poll_cmpl(cq, info);
 			}
 		}
-		/*cease posting push mode on push drop*/
-		if (info->push_dropped) {
-			qp->push_mode =3D false;
-			qp->push_dropped =3D true;
-		}
 		if (info->comp_status !=3D IRDMA_COMPL_STATUS_FLUSHED) {
 			info->wr_id =3D qp->sq_wrtrk_array[wqe_idx].wrid;
 			if (!info->comp_status)
@@ -1521,7 +1440,6 @@ int irdma_uk_qp_init(struct irdma_qp_uk *qp, struct i=
rdma_qp_uk_init_info *info)
 	qp->wqe_alloc_db =3D info->wqe_alloc_db;
 	qp->qp_id =3D info->qp_id;
 	qp->sq_size =3D info->sq_size;
-	qp->push_mode =3D false;
 	qp->max_sq_frag_cnt =3D info->max_sq_frag_cnt;
 	sq_ring_size =3D qp->sq_size << info->sq_shift;
 	IRDMA_RING_INIT(qp->sq_ring, sq_ring_size);
@@ -1616,7 +1534,6 @@ int irdma_nop(struct irdma_qp_uk *qp, u64 wr_id, bool=
 signaled, bool post_sq)
 	u32 wqe_idx;
 	struct irdma_post_sq_info info =3D {};
=20
-	info.push_wqe =3D false;
 	info.wr_id =3D wr_id;
 	wqe =3D irdma_qp_get_next_send_wqe(qp, &wqe_idx, IRDMA_QP_WQE_MIN_QUANTA,
 					 0, &info);
diff --git a/drivers/infiniband/hw/irdma/user.h b/drivers/infiniband/hw/ird=
ma/user.h
index dd145ec72a91..36feca57b274 100644
--- a/drivers/infiniband/hw/irdma/user.h
+++ b/drivers/infiniband/hw/irdma/user.h
@@ -216,7 +216,6 @@ struct irdma_post_sq_info {
 	bool local_fence:1;
 	bool inline_data:1;
 	bool imm_data_valid:1;
-	bool push_wqe:1;
 	bool report_rtt:1;
 	bool udp_hdr:1;
 	bool defer_flag:1;
@@ -248,7 +247,6 @@ struct irdma_cq_poll_info {
 	u8 op_type;
 	u8 q_type;
 	bool stag_invalid_set:1; /* or L_R_Key set */
-	bool push_dropped:1;
 	bool error:1;
 	bool solicited_event:1;
 	bool ipv4:1;
@@ -321,8 +319,6 @@ struct irdma_qp_uk {
 	struct irdma_sq_uk_wr_trk_info *sq_wrtrk_array;
 	u64 *rq_wrid_array;
 	__le64 *shadow_area;
-	__le32 *push_db;
-	__le64 *push_wqe;
 	struct irdma_ring sq_ring;
 	struct irdma_ring rq_ring;
 	struct irdma_ring initial_ring;
@@ -342,8 +338,6 @@ struct irdma_qp_uk {
 	u8 rq_wqe_size;
 	u8 rq_wqe_size_multiplier;
 	bool deferred_flag:1;
-	bool push_mode:1; /* whether the last post wqe was pushed */
-	bool push_dropped:1;
 	bool first_sq_wq:1;
 	bool sq_flush_complete:1; /* Indicates flush was seen and SQ was empty af=
ter the flush */
 	bool rq_flush_complete:1; /* Indicates flush was seen and RQ was empty af=
ter the flush */
@@ -415,7 +409,5 @@ int irdma_get_sqdepth(struct irdma_uk_attrs *uk_attrs, =
u32 sq_size, u8 shift,
 		      u32 *wqdepth);
 int irdma_get_rqdepth(struct irdma_uk_attrs *uk_attrs, u32 rq_size, u8 shi=
ft,
 		      u32 *wqdepth);
-void irdma_qp_push_wqe(struct irdma_qp_uk *qp, __le64 *wqe, u16 quanta,
-		       u32 wqe_idx, bool post_sq);
 void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx);
 #endif /* IRDMA_USER_H */
--=20
1.8.3.1



=20
=20
