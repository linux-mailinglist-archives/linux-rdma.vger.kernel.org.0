Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E065CA69
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjACXfv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 18:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjACXfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 18:35:41 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420401659D
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672788940; x=1704324940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F/dkkt0rGNMSiIlBjD7VwBJ9nO1U3FyiFnKGvhw/Un0=;
  b=hu11SDuXKCzwPUz1VtiDFGQt9ALNgwF14AO/SSJp0EdGFSdaYIkpj0Qx
   r0f9Q6EaknhXdGHRcClaoTaFuYUbqPS+vsqVgc1grQhlDQsihGkp8x6Mn
   OgX8dmAjMcvRTzyQiJdfgEbqr5OmDNxCFF6T0jTizjen6k8488gnbgjmB
   6u1h2SkD+1I3M3gFcscWYyjCR5AB6csglGsNJtsrhLm5sJD1Ee/HPCcV2
   2R2+fw1HK8L4mzaLy7rDAhuq0XI92zqGujeFl/QZzAd5GuYjv3jSWRRZG
   f35V3c3iXAv4kzzBZ3P1UO1DxcTpREe619SzS0XR1gQI/UPaHdURPJXhk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384074116"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384074116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 15:35:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="685565824"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="685565824"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2023 15:35:39 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 15:35:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 15:35:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 15:35:38 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 15:35:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhWlOsIvbVYK5PzeH7CzjgqVs37MbIdWOEFfYj73h4KjNUPDTUuADqJhrx2OxeiqVOPEI7ugeejU7az9l2l7HgmW2v2Pq5Bu4ay/8TYziZFVtNnyh4wO5XYmfQIqiVuTEukgDq9JzOxNmGdmJYELILoCPiD6CPc76tm64zJG2SFy77SBdb9UP9+pdb1K/j5L1vCaTVPiFZ8uJHYJiidFyssV3L8/Uvx+lBFRQ2ZnPDxZGcPSJBlrd/JS+PeU6CTZv2d53nJh+egNnAXNtQB854YH9GPZXvJIQNGLiOA7zdk4732/i7DqOXRYM4drxbWfDuyr++3fODw8oublWwhIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxSBzTJH7/WcxbdrwR49FJeMEah8Dn72juz6yj/UVWY=;
 b=ccaCm4k5fS7F0VoarKehH4pVWw513yF9uH6ZqdEAF8+TYJVTaU4EYx5tWKkd+QvW/tEHrOWrt1XFVlS8enlzSZb28vMsfN62s/+N06qKXHSaDntvxPZ0FhSlfwkW4iGk4uIFBH/LxvPQwLSQwgz3aw1lOfi5smrzjZQFOFCDRgKIG9pzCcub3M96ZyCQvm5h7BzCVCEU7bt/XMv9DRLO/wGpT8+nmK1JsCcwyoz1rlcfbhJAVhpiA8ll/NwCX+D32mz9mzqVgjY/wZEx5e5YXKStVAWdYZ/E7Ka/QxaXFdSiatVPtauRAv/sTkBToyuQWeO7KZ7ugBtGNfxinGp8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CY8PR11MB7010.namprd11.prod.outlook.com (2603:10b6:930:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 23:35:34 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 23:35:32 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
 regions
Thread-Topic: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
 regions
Thread-Index: AQHZHq/4nu0DPELUqE6mVZi+6ke8S66NUWww
Date:   Tue, 3 Jan 2023 23:35:32 +0000
Message-ID: <MWHPR11MB0029F8368BF8A689F9CBD311E9F49@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230103060855.644516-1-yanjun.zhu@intel.com>
In-Reply-To: <20230103060855.644516-1-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CY8PR11MB7010:EE_
x-ms-office365-filtering-correlation-id: 91a935c1-003a-4975-a597-08daede334f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arnuPkw5ALoSxoatBvIwqqIeDY1NzEghuorW+r3IzhZKdneZ5NweJDdhtwIbiLdYh8uDoGHrdBKwroAjnzDHUC5bv0R76xuFlnaHV8mlnarXQQZHBylD5N46uDTyOylcL7qffFCRB4RbdAkLqyWlcPsXcuZtkFNHT0b9yXXLuUNQCoDq+FvO/BQNHmaCTJzKWoSv1T6A5pQg1symDsdGA5YRiTRcVHQo7QV+Fy8IDCaHD9f6cgf0B8REkRPwz9jv5PLkxHo0BYiTccPdpHlb/Dn2C1jnFTIPhu864ubauIBbv0GJ5po22I2rlIkbjTUhbB/LMcetnUobg4XaJ3jid7uph9k+RB0YB3TQfoEGyhoi9wg2YgjQnx1QpffAhyXLa2zog8j3tTZ19hISc4J8gHXEBCGBDMDd67ki1tSJMZiv8faN4av8XoSji+aIV4aJ6QU46eklE4HlnkNABo5viD5cY1ldaUiBBDskvXxHJLk7skoNrtBOEVYY4ChmWGY0Yp+BPGtZQNB2kMYHo43l00k684duVI+xEW/ApovQGlwemUVSxUBjo2g2fOJRFNzT59M7A5NbqoJ4pgAGUwjJSNEmm3zPlPuRnuDW9pqQUg3draX6mTIdzYOW88byc2BBObsLPtI8XfN6fk74igzIe7BF8TU9G4iaM7/hLKoR9nhmbhzA2AdVCZ1MtAgOPEEbxoWLDaD//G5AbXTapIZmeIuYVNEAcXT7unYJ97WbxvcUCp2bgDt69JCEljpG9ROqmVGHkkvoi4iPdpcrLYMWPcIE7ikRWB2U2wZoHCGZveQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199015)(66899015)(8676002)(110136005)(41300700001)(76116006)(66446008)(66946007)(64756008)(4326008)(66556008)(86362001)(66476007)(82960400001)(38100700002)(122000001)(33656002)(38070700005)(7696005)(966005)(478600001)(26005)(6506007)(71200400001)(55016003)(5660300002)(2906002)(52536014)(8936002)(186003)(316002)(9686003)(83380400001)(22166009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eXzurQjjHrzIttJR4Vmi0q3Nsu5n/UeJTN8TyxnQNtDQB++88uBDnLReigQD?=
 =?us-ascii?Q?qt+Y+9amOvbc+BbCDn+Ee65Cj7jXuzUc9LkB1PKBw5i6CzM/4NLHvau4k/CY?=
 =?us-ascii?Q?FWndiAWuRI57B5dPYQMkk5QFB5fXpI+Trir6zEqlPQwBdxcb2pMJ/z9kkJV4?=
 =?us-ascii?Q?/OsugMxXEg1yil6MvSi68qoL6Eh9Ps8uKl9gHoMIIWIkHlfHVU6qf7x9DXqO?=
 =?us-ascii?Q?LHqb8pFuD2V7sIiI1vdPv1cSZsrdvI5rYMJD7kiNbBohXeKnrd7BRiFdcyRi?=
 =?us-ascii?Q?8wyjlSWrLzviJE7l2klQnv5kw1ys270kaWojgNo/8Ypzc82UeKsdW3HhO3J/?=
 =?us-ascii?Q?vLFMCGGrY3GD6M0WHHr9tEtorNQAck03DrdBr3xtNe2pVYUHNk+cD7H8blLg?=
 =?us-ascii?Q?LDBtuVlj246XQ3eF19u1a+6eFYxUY29bh3211TCJTLXRUD/5XGwvXZBtkfRz?=
 =?us-ascii?Q?BTIazJec8gqwF3MC/8aqOVZbKO/3IrC8ItJvG4vm55Dw9HFY+5+rro4P3z9X?=
 =?us-ascii?Q?nY3pBG8+YqZgdV1SEA2yI2t573k4d9QJc9fRlTGjdb8180ANGYnPccV7mgpx?=
 =?us-ascii?Q?CFwySCXa1CxXqmr+dnBZQhf3XGvwcahzuffDTW/nJ7wEgHhNoNlbhCeCvj4H?=
 =?us-ascii?Q?tLLSej4pUvDzAfaAgaID1tLoiORGC7aKHMf6YR//EIU/XxsqjsOn3YzFARjQ?=
 =?us-ascii?Q?Vqo5aBykRSvz+2VxhnXliWVGmxgrz0TEzdL8xBo24sNEjAiqCu1EuMuS1dCw?=
 =?us-ascii?Q?TENWKCoxuvc0LzSdt1k0iDiG12+mBXVWtUcavwLQ+GOJ/6Y47kK4JSO9ikzX?=
 =?us-ascii?Q?fOv9MllEVf/vuexfJN8RbP7CqpW+TpvTOB4xET3mVYTnMEMBQ6+1e4MgRl/c?=
 =?us-ascii?Q?O6iOdzJDJz6M1gMjSMak/Ywa6KxDW2+maU5J6M+85VZ18gbdAziFRyjncSUl?=
 =?us-ascii?Q?BwLJkgQ4Iy3e146agSPvLFHUPwwHIl4hIDlzZUFg4ZIRRz2lI1le93MN9Xyw?=
 =?us-ascii?Q?KQ5MFjbX8bHPdCMaUsx4sA21qrevP022Y6Ui0EL9oUlg/tyrw6ELfZwZ0owO?=
 =?us-ascii?Q?pIMz/bs650RhKY82PKrXoi0rEOcTbTINj4tmZKYa6Z2eZz1WBtW8NcgvQRWp?=
 =?us-ascii?Q?z34DVkex3Kzujnzn9riqoFHyRq1KE63/doNYkIifaNoz4MEayNyA+1zs4Mwn?=
 =?us-ascii?Q?eVi9SLx1RmuWmMH04lvhOrFcLTf1VSU3QtV2Q9+ElByU8xI0/8qG1KkEwU28?=
 =?us-ascii?Q?cPQeV/FgXDfZbulPJ5aJv7Av0Sq4NTbl3HyzzQaLAiFdSeQ7FxrPfuXi7XQW?=
 =?us-ascii?Q?1/EEzvTsFCVFhO9zeaI1HZH6vYDrUfUAvs5AiY7e51c0oITaesXWBacBUgD3?=
 =?us-ascii?Q?3asdgNnOBRg9sh2QXixjexK9JqIyfbBMA1J1jeXdqHEPffEKi/adkN66KvGY?=
 =?us-ascii?Q?y577iFXOZn7psyhjQ8MG9fxLD6WVPratGBvf3hEJVmqaaMjVZdHsV81RbCUj?=
 =?us-ascii?Q?hLeuGFXOir6/UWO42Dkgi8Y/Ddtly38LVGGY5WkSq+QYEZ2LFfNSVPhhtqHi?=
 =?us-ascii?Q?glvzkdx44MNtmVgjvYfAEAVO/YT/COaphKonBBDg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a935c1-003a-4975-a597-08daede334f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 23:35:32.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7QmZ3+C5fS6zINZ8RuVBA86eTRCJkky96sHxnB+0coJldFxp5BaX9XDNbUdPTJc6c2HcmgqxKm/xbwmyTk4fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCHv2 1/1] RDMA/irdma: Add support for dmabuf pin memory
> regions
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> This is a followup to the EFA dmabuf[1]. Irdma driver currently does not =
support
> on-demand-paging(ODP). So it uses habanalabs as the dmabuf exporter, and
> irdma as the importer to allow for peer2peer access through libibverbs.
>=20
> In this commit, the function ib_umem_dmabuf_get_pinned() is used.
> This function is introduced in EFA dmabuf[1] which allows the driver to g=
et a
> dmabuf umem which is pinned and does not require move_notify callback
> implementation. The returned umem is pinned and DMA mapped like standard =
cpu
> umems, and is released through ib_umem_release().
>=20
> [1]https://lore.kernel.org/lkml/20211007114018.GD2688930@ziepe.ca/t/
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>


Is there a corresponding user-space patch?=20


> ---
> V1->V2: Fix the build warning by adding a static
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 158 ++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index f6973ea55eda..1572baa93856 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2912,6 +2912,163 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_=
pd
> *pd, u64 start, u64 len,
>  	return ERR_PTR(err);
>  }
>=20
> +static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 star=
t,
> +					      u64 len, u64 virt,
> +					      int fd, int access,
> +					      struct ib_udata *udata)
> +{
> +	struct irdma_device *iwdev =3D to_iwdev(pd->device);
> +	struct irdma_ucontext *ucontext;
> +	struct irdma_pble_alloc *palloc;
> +	struct irdma_pbl *iwpbl;
> +	struct irdma_mr *iwmr;
> +	struct irdma_mem_reg_req req;
> +	u32 total, stag =3D 0;
> +	u8 shadow_pgcnt =3D 1;
> +	bool use_pbles =3D false;
> +	unsigned long flags;
> +	int err =3D -EINVAL;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +
> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf =3D ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
> +						access);
> +	if (IS_ERR(umem_dmabuf)) {
> +		err =3D PTR_ERR(umem_dmabuf);
> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n",
> err);
> +		return ERR_PTR(err);
> +	}
> +
> +	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return ERR_PTR(-EFAULT);
> +	}
> +
> +	iwmr =3D kzalloc(sizeof(*iwmr), GFP_KERNEL);
> +	if (!iwmr) {
> +		ib_umem_release(&umem_dmabuf->umem);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	iwpbl =3D &iwmr->iwpbl;
> +	iwpbl->iwmr =3D iwmr;
> +	iwmr->region =3D &umem_dmabuf->umem;
> +	iwmr->ibmr.pd =3D pd;
> +	iwmr->ibmr.device =3D pd->device;
> +	iwmr->ibmr.iova =3D virt;
> +	iwmr->page_size =3D PAGE_SIZE;
> +
> +	if (req.reg_type =3D=3D IRDMA_MEMREG_TYPE_MEM) {
> +		iwmr->page_size =3D ib_umem_find_best_pgsz(iwmr->region,
> +							 iwdev->rf-
> >sc_dev.hw_attrs.page_size_cap,
> +							 virt);
> +		if (unlikely(!iwmr->page_size)) {
> +			kfree(iwmr);
> +			ib_umem_release(iwmr->region);
> +			return ERR_PTR(-EOPNOTSUPP);
> +		}
> +	}
> +	iwmr->len =3D iwmr->region->length;
> +	iwpbl->user_base =3D virt;
> +	palloc =3D &iwpbl->pble_alloc;
> +	iwmr->type =3D req.reg_type;
> +	iwmr->page_cnt =3D ib_umem_num_dma_blocks(iwmr->region,
> +iwmr->page_size);
> +
> +	switch (req.reg_type) {
> +	case IRDMA_MEMREG_TYPE_QP:
> +		total =3D req.sq_pages + req.rq_pages + shadow_pgcnt;
> +		if (total > iwmr->page_cnt) {
> +			err =3D -EINVAL;
> +			goto error;
> +		}
> +		total =3D req.sq_pages + req.rq_pages;
> +		use_pbles =3D (total > 2);
> +		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		if (err)
> +			goto error;
> +
> +		ucontext =3D rdma_udata_to_drv_context(udata, struct
> irdma_ucontext,
> +						     ibucontext);
> +		spin_lock_irqsave(&ucontext->qp_reg_mem_list_lock, flags);
> +		list_add_tail(&iwpbl->list, &ucontext->qp_reg_mem_list);
> +		iwpbl->on_list =3D true;
> +		spin_unlock_irqrestore(&ucontext->qp_reg_mem_list_lock, flags);
> +		break;
> +	case IRDMA_MEMREG_TYPE_CQ:
> +		if (iwdev->rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> IRDMA_FEATURE_CQ_RESIZE)
> +			shadow_pgcnt =3D 0;
> +		total =3D req.cq_pages + shadow_pgcnt;
> +		if (total > iwmr->page_cnt) {
> +			err =3D -EINVAL;
> +			goto error;
> +		}
> +
> +		use_pbles =3D (req.cq_pages > 1);
> +		err =3D irdma_handle_q_mem(iwdev, &req, iwpbl, use_pbles);
> +		if (err)
> +			goto error;
> +
> +		ucontext =3D rdma_udata_to_drv_context(udata, struct
> irdma_ucontext,
> +						     ibucontext);
> +		spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> +		list_add_tail(&iwpbl->list, &ucontext->cq_reg_mem_list);
> +		iwpbl->on_list =3D true;
> +		spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> +		break;

I don't think we want to do this for user QP, CQ pinned memory. In fact, it=
 will just be dead-code.

The irdma provider implementation of the ibv_reg_dmabuf_mr will just defaul=
t to IRDMA_MEMREG_TYPE_MEM type similar to how irdma_ureg_mr is implemented=
.

https://github.com/linux-rdma/rdma-core/blob/master/providers/irdma/uverbs.=
c#L128

It should simplify this function a lot.


> +	case IRDMA_MEMREG_TYPE_MEM:
> +		use_pbles =3D (iwmr->page_cnt !=3D 1);
> +
> +		err =3D irdma_setup_pbles(iwdev->rf, iwmr, use_pbles, false);
> +		if (err)
> +			goto error;
> +
> +		if (use_pbles) {
> +			err =3D irdma_check_mr_contiguous(palloc,
> +							iwmr->page_size);
> +			if (err) {
> +				irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
> +				iwpbl->pbl_allocated =3D false;
> +			}
> +		}
> +
> +		stag =3D irdma_create_stag(iwdev);
> +		if (!stag) {
> +			err =3D -ENOMEM;
> +			goto error;
> +		}
> +
> +		iwmr->stag =3D stag;
> +		iwmr->ibmr.rkey =3D stag;
> +		iwmr->ibmr.lkey =3D stag;
> +		err =3D irdma_hwreg_mr(iwdev, iwmr, access);
> +		if (err) {
> +			irdma_free_stag(iwdev, stag);
> +			goto error;
> +		}
> +
> +		break;
> +	default:
> +		goto error;
> +	}
> +
> +	iwmr->type =3D req.reg_type;
> +
> +	return &iwmr->ibmr;
> +
> +error:
> +	if (palloc->level !=3D PBLE_LEVEL_0 && iwpbl->pbl_allocated)
> +		irdma_free_pble(iwdev->rf->pble_rsrc, palloc);
> +	ib_umem_release(iwmr->region);
> +	kfree(iwmr);

Ideally we want unwind in the reverse order of allocation.

> +
> +	return ERR_PTR(err);
> +}
> +
>  /**
>   * irdma_reg_phys_mr - register kernel physical memory
>   * @pd: ibpd pointer
> @@ -4418,6 +4575,7 @@ static const struct ib_device_ops irdma_dev_ops =3D=
 {
>  	.query_port =3D irdma_query_port,
>  	.query_qp =3D irdma_query_qp,
>  	.reg_user_mr =3D irdma_reg_user_mr,
> +	.reg_user_mr_dmabuf =3D irdma_reg_user_mr_dmabuf,
>  	.req_notify_cq =3D irdma_req_notify_cq,
>  	.resize_cq =3D irdma_resize_cq,
>  	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
> --
> 2.27.0

