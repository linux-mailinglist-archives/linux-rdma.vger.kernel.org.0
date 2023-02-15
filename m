Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A6697D92
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjBONiL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Feb 2023 08:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBONiI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Feb 2023 08:38:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B1D2CC4C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Feb 2023 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468285; x=1708004285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=joHZGAoNp7S0YmtvkvX9Gb3bSConXBzklOtedFn56cM=;
  b=U5/lNntn0yB9VP3xN2h2tVVk1Zq+VGELBtknJSkrFqnDrOPV1aKsIZIZ
   hJY8Wu2sd7O2duDFreW2R5B8qR0nKs5ryt56lFpP2+xiPjcVG++TqwPIU
   tiyuGn0fuByn3gHkw2gbgZrL31JnZVaMcTmLedTz8Yo5l2/72xFKy4RNV
   c0oU/Mbg/rzbQjPMSiqtMktE//9tvm+zbWSn78yaCyUCqTDLPThqfNIip
   vho9LFtYEmclvt8kPVuQJOvxb69xpSma06qIhXnxNWgHyQlIb+uoVY1df
   gXt3QY2asojKb9ZaiGn81KyvCVjJbmiolDO+nqPrie/CiiCcgQcHdWlct
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="315082139"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="315082139"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="647167337"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="647167337"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2023 05:38:03 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 05:38:03 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 15 Feb 2023 05:38:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 15 Feb 2023 05:38:02 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 15 Feb 2023 05:38:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6pQfH3FUf3jhHC02+nTSYODb52bTIVd253EG1dXTH7ttuavFDl/3cLWAPkLh3KSQCRjQTr/D0PPSUs0tmA/a+4mCAeWDgmcFKfd0vsXCFqXF5ycot4Cpz5MGN71eiJ6qrvPqQajvuP/p2PgHGpQPZgIWVPd3/MKDPMhYH0UeuiZQQxa3CFABNFOeMopuV5VM7F5jrtmS4BMiAXy45ZyoVk9D5Po8o93dA8IuH0A/x6er/5CiYJQnVGlaDC0rHJQCVFtPY6SxDBgsDbpg7ONFLC0XdFRnVwQ7EnHKVx2y+N1z9Z+bWguz6YaQZdR78EuJB9ZO61qV+6HVG8eM3lJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUbysdiJl6zWYQfdfUBPxh7WjwZmlGcXYyX8h0L8Dsg=;
 b=CaNaa6chZlQQf9QZy7ma69qS7yLmZpJV4/pwWARNzPJl+cZKHALDwrAl4A3sMr4V7cwlYZoAe2nppxnuKFVmQcRGY6x5D1xcnRfl5GVoxyqROr672PI5RDxolHk3Vnnv7aVeiJTHsmPwLY7Y8GsjWvHL+Z230+/Ut2m2by9/H33be7JH2OF202RW+V2x5aIVJJ8zawlVdNuae7UJuzlvQjIZpi+WXOf/m5GLZ/i9WVP7mNmRXq3jqPAnpwSeKBNm3qbACh1+FJdYwUkPtUr8psTAs8WRmOyieU6uT1sZimdLPmjeMXqjJfeQPHOgViYFsR+KDkk51DwZy9kW5Y53Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CY5PR11MB6284.namprd11.prod.outlook.com (2603:10b6:930:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Wed, 15 Feb
 2023 13:38:01 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%3]) with mapi id 15.20.6086.023; Wed, 15 Feb 2023
 13:38:00 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Thread-Topic: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
 memory regions
Thread-Index: AQHZNeyES5+dLjP/mEyp7v4aL1QxLq7QErDQ
Date:   Wed, 15 Feb 2023 13:38:00 +0000
Message-ID: <MWHPR11MB0029CFC36AECD29382B4ABC5E9A39@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230201032115.631656-1-yanjun.zhu@intel.com>
In-Reply-To: <20230201032115.631656-1-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CY5PR11MB6284:EE_
x-ms-office365-filtering-correlation-id: 7115e58c-66eb-4abc-4324-08db0f59db33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6cpcY1qkMMmrxm8iLVYGFuPlkNCiLXDa8C8m8IbRwD7Urw5yIUXW/u7O2+bkoT8PYH5SJmJ/NoiZlC6NxEHCrYMH4nOfkEHQKnte/jX4qDmGTS2EH6Hi8E3a6/IHcExzZY8Eb7sN31G5y7ObOTZGF8/8VDlgCeX0V65UA3sLRcUwcBKw/vPLSsvWyr7hM1BFcPTPWWsfXlFiZmn2ldGFY8EO6IOlzTxfzx453GJmt9WRP9NMXAm+X5jz+54DNwoivsZHK7GDaQBIoBRdiIrCYIUYBqHx58oG/9WV5ATG4RDBd2riXjOxSVC63MAqGLQlcfsatHydO94RNQscqLYZxCv1QTK/+qY4sa/WhIYXKaQ4oyL30cNct/jkpg6bnKO1+7IX+9/ZwjFLfAtZp2SjHs6IMkpIWrwVsAkYH61F+TYaBKrnf14EbaIxCWcR53sLx6i6r+98njqwahqLP34zWtBjXeGrsC09c+MRMompmLOPCXH5QQCJl9+HUGsrZVlfB92dAQk0dnyg5ZdvMFQ1Zvi2oLQjeROIEoQzUSmXMmdmW/Ejk7a7Pp6VEHlMs9oOc4oD6/EhbHHFyyLKxxesy2grzfdABF1iL44ksVZbLpz2lfwkxDF/nggweiesJXpstzuAJCU0rA0HxinEZh5df3UBixSdztp9uBKkxtSUsbdqCAfRselmKljYI0s265b
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(82960400001)(38100700002)(33656002)(55016003)(86362001)(38070700005)(122000001)(4326008)(66476007)(52536014)(64756008)(66556008)(66946007)(76116006)(41300700001)(110136005)(316002)(8676002)(66446008)(8936002)(2906002)(5660300002)(478600001)(83380400001)(7696005)(6506007)(71200400001)(186003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aC9bhwaubG3G1wvWjFrwAw43yC6E98Ip3VyrT4SF3bCljJTzNgr33heLIgXu?=
 =?us-ascii?Q?/1FiLTonWQs8VjbdotM5iVPosCwzZkb2Yq5Zx9AX24wHBSzU7y+xlB/rRgI4?=
 =?us-ascii?Q?eQkY5AqfJ0eoccdH7yyZ0DOOvbURQPpmub0L29YgeYk3y8cBmlGvusDNhKCp?=
 =?us-ascii?Q?sm8X1JTKBpJYlDUusqpFsusUAnusmtieYmh3Z7oK5DesgrUc3kH9n2xwMOlw?=
 =?us-ascii?Q?F4Vh5zxt2+ikpZ/oc8EnFflow6+sq1gUsD+YPju072G9RU0iBrCqxVRpRC07?=
 =?us-ascii?Q?xvF5S7J8zBWlXyhSqPGSluGn1wNtpF+VPu/GiJemfzZ5KlomySyl3G5uVA1F?=
 =?us-ascii?Q?JBscYTqs6VpUeKHm/ye0eqqECKvABqUtrXs9sBUOoUukq8t0Qr95YT826gfv?=
 =?us-ascii?Q?pJrfr7AjWdf2LpI941vNtspEkVVFbBl+Y8JIxYFCfLleeZdTwvivHT949AvB?=
 =?us-ascii?Q?R21zF8PAAciqWQDJufGLkbf65ceA3lf8dJ2IEWTZFcPxuzdmg/BZhIoSq00K?=
 =?us-ascii?Q?Kion2MHmb9r5hUgrM+AUWj3G/Dq4e3Vyt6YQlnCD8V9DmTIDAdCqib16xe3E?=
 =?us-ascii?Q?oAQKf5tJl7SseeX0OcF2qdm+Mz0CUdI7oA3MgrqOBX61ZoPj1DYmjt0TdQhH?=
 =?us-ascii?Q?g1ieMQICOqimZAfLycWWOGoCrtBgevQLh1A1AATclUnwwfVD29OBaZltCjRH?=
 =?us-ascii?Q?bBBpVK/dNyscnOKmvP4o5IRrI8951W/XqE0GePPh5FIMo7WCKT0Zp8HJpfEb?=
 =?us-ascii?Q?EhHc1NcNM9cYhp3SMSf/0KXeqfcE2j5isq9xYXAPzQUycrj1P+XZUfGfueh9?=
 =?us-ascii?Q?ydInz1YwyCvfdFB0fgG+dE1qY/ppTrLa3rtP4X0EFFUOCVijPJH05KqIVLYi?=
 =?us-ascii?Q?//BTYQjCd1g+wgW5r+J6CNcW8BxQtIn0qtuTR+yPZcqQi6lAbj43zMc5122W?=
 =?us-ascii?Q?T3bJihpo7qCCYfs1W59sU3b2PONON/S1Xp/7CpzkN8Avguf53iy2Obz2EF75?=
 =?us-ascii?Q?crUs4aBwXEA/o4U47p0HpGaOsf9o6wjAz5cYFPqvnRr/innAtfcuE7cW1GG2?=
 =?us-ascii?Q?HofqWkbnKwPmg5P97zzrEzOesvNVdAgKSXEHyqfLonlwBfeYsFq+kSgmnLyW?=
 =?us-ascii?Q?5ezXyblvFYCAZNIzTF+ukMbG2TSYpIVnwdz4Zzsy1D6bmGeYrgyu7iWtET/B?=
 =?us-ascii?Q?BRXQXi/i/JAF3sNVsKc356pG7AnsND12vzVCwriYeMSo7aABZjqZnHUIGAVI?=
 =?us-ascii?Q?dEbaLP7E5fWtbfaHYanMw4AuAWhPc4No6is1zfE9/xLGpC38xsl4JaXbeQUg?=
 =?us-ascii?Q?dZS6g97tAqdOwxVWwmQzmXjs6XkNKWP5+j59FIZz3I8c+0Tta2df7wR7i53W?=
 =?us-ascii?Q?m53kEcF0Cr+RUomLHsXuAHeyqiQbhwV6xWtnvwadzaYsrordnGlPGOBSpJ7b?=
 =?us-ascii?Q?fdjWP1U852NXbqRC3kTKZtQmMLJN1TOO1ZoXSNuAArjWYhTx+4cpLosFPaoL?=
 =?us-ascii?Q?z+PEGJuO3uL1IyBwws9bjkzUn5/AmnBdNS+yxEY6L8DyyePYtxOetmB8LK1g?=
 =?us-ascii?Q?WsycHkrPkme2q1EgGjkR1HbUwA5l0pZx+MtqN2uP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7115e58c-66eb-4abc-4324-08db0f59db33
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 13:38:00.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zBbetsN0xsa3WU4Jgw5opnYhl6NyLhRDuRP88FrLjnFZ+aSJj6jGA0H3GClT7Mnwgtst1GaEn5rK90Xj/9QslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6284
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCHv3 for-next 1/1] RDMA/irdma: Add support for dmabuf pin
> memory regions
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
> ---
> V2->V3: Remove unnecessary variable initialization;
>         Use error handler;
> V1->V2: Thanks Shiraz Saleem, he gave me a lot of good suggestions.
>         This commit is based on the shared functions from refactored
>         irdma_reg_user_mr.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 45 +++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 6982f38596c8..7525f4cdf6fb 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2977,6 +2977,50 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_p=
d
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
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct irdma_mr *iwmr;
> +	int err;
> +
> +	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (udata->inlen < IRDMA_MEM_REG_MIN_REQ_LEN)
> +		return ERR_PTR(-EINVAL);

Do we need this? we don't copy anything from udata. There is no info passed=
 via ABI struct irdma_mem_reg_req.

> +
> +	umem_dmabuf =3D ib_umem_dmabuf_get_pinned(pd->device, start, len, fd,
> access);
> +	if (IS_ERR(umem_dmabuf)) {
> +		err =3D PTR_ERR(umem_dmabuf);
> +		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%d]\n",
> err);
> +		return ERR_PTR(err);
> +	}
> +
> +	iwmr =3D irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt,
> IRDMA_MEMREG_TYPE_MEM);
> +	if (IS_ERR(iwmr)) {
> +		err =3D PTR_ERR(iwmr);
> +		goto err_release;
> +	}
> +
> +	err =3D irdma_reg_user_mr_type_mem(iwmr, access);
> +	if (err)
> +		goto err_iwmr;
> +
> +	return &iwmr->ibmr;
> +
> +err_iwmr:
> +	irdma_free_iwmr(iwmr);
> +
> +err_release:
> +	ib_umem_release(&umem_dmabuf->umem);
> +
> +	return ERR_PTR(err);
> +}
> +
>  /**
>   * irdma_reg_phys_mr - register kernel physical memory
>   * @pd: ibpd pointer
> @@ -4483,6 +4527,7 @@ static const struct ib_device_ops irdma_dev_ops =3D=
 {
>  	.query_port =3D irdma_query_port,
>  	.query_qp =3D irdma_query_qp,
>  	.reg_user_mr =3D irdma_reg_user_mr,
> +	.reg_user_mr_dmabuf =3D irdma_reg_user_mr_dmabuf,
>  	.req_notify_cq =3D irdma_req_notify_cq,
>  	.resize_cq =3D irdma_resize_cq,
>  	INIT_RDMA_OBJ_SIZE(ib_pd, irdma_pd, ibpd),
> --

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

