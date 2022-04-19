Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA3507054
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Apr 2022 16:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbiDSOae (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Apr 2022 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238751AbiDSOad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Apr 2022 10:30:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D8E0CF
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650378470; x=1681914470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gQvBmk++t5YKvYqZqKjuf0+4U26CFLEthe3LxsZIQvQ=;
  b=aKFb4jEQYEq2ZOIgbPD1qBUK4yv20zps23/E0MAR7uJq4RtvSFk/MPow
   6nalaY4r2KCOtndgS60LNxGVUL2ssiHupCAmvTy9qXATYbpIgo/mdOUPG
   2h9lslDd9rAC/me/pU8CSst+7xdM80dIbGtilGTzQJGDcMXyOj/DHuA6s
   byN/kMtNeexBaZ0X8AmU4VwyKg3pQF6saJX2F0tR4T80XZhDmJN3+2CUS
   XwcJu0NhGUYfWei8075a2RgbBBvRl+QkpVrf094ZD52YdbRnHQK1TTxrX
   kuU1yLnzXfD6aMy3BLNP/ccnYbE/D1iJr7XHDxh1lXtzx5IV08WUQDXMr
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324219809"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="324219809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:27:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="576124609"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2022 07:27:50 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 07:27:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 07:27:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 07:27:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 07:27:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFb+AwH+yQB/ZBz1bodSq7vW6kITK4xBP5jpWxJ39ZCbRxf4y9AdDz9Unzhn1mpzL4rTG5XHZlR7W+IlneSBxmZ3q9QgdnZ19DdQxCmVywheDjZPIX0nywIIa5MYRIIUeVtYsJ3QDVEYK7pgiq4zBeRxwOsRQf3Fkhk7a5SoWgI4QxPuMhwxpLlYM7fBsrqP/oC+WbMYw79AJFa1TIc4rUuhD2gY7CN05ucI/OeOL9+8fJfNvTp9xMhqBGj59CxX6kxEo8JUuJPO9ABmVLb6wIeK/R+NAFPVzLHKqslKMcz6BpHE6716UJqPdklkgmPHf50YERggwhFWgixZs0/Ubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQvBmk++t5YKvYqZqKjuf0+4U26CFLEthe3LxsZIQvQ=;
 b=jdXB5aoaxjInlbMdLZjLvXeC1j9mew89fqFI3VgTwFFJk7MnO5zvXKrhlKrC61bvwIDT+4MEP09NMGbLzh/gM5N6scpUEMlbSZGQ/77KoHtKCBksRTnMAzw76QCCBpqXd22qI3bUn+3EM8mVWyE1ug+WP7LICOi+J228fkX0OS5IfEP/gKvIKmNbHi1/ynFFzA4kqDRB+wcojdlCjYuejRv87k2vhkp9mmLMK+T+cGWCXW28WSbk76eIZBn0Qbw8GUh/DkfRZmpeWZ3EOEh4G7KA6a1Izu+IMSNzmrIcU/TgjoKY+lqPk9Zo9AGC06vbf8jmKD1eOojkzugWXMeIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by SA2PR11MB4811.namprd11.prod.outlook.com (2603:10b6:806:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:27:47 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a94a:2e9c:5d29:e1bc]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a94a:2e9c:5d29:e1bc%6]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 14:27:47 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/i40iw: Do not manipulate VMA attributes in
 i40iw_mmap and remove push mode
Thread-Topic: [PATCH] RDMA/i40iw: Do not manipulate VMA attributes in
 i40iw_mmap and remove push mode
Thread-Index: AQHYU/lQd92iW03zokCaz3as/ndEvaz3SsnQ
Date:   Tue, 19 Apr 2022 14:27:47 +0000
Message-ID: <MWHPR11MB0029C11C5330933F934FEA67E9F29@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20220419142455.358-1-shiraz.saleem@intel.com>
In-Reply-To: <20220419142455.358-1-shiraz.saleem@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beb5889c-9aac-4c4b-045e-08da2210c6dc
x-ms-traffictypediagnostic: SA2PR11MB4811:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4811539C2131D8796CF376D0E9F29@SA2PR11MB4811.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svE5JfAxrWAIiWhCf2DVYXWr2qbDv/l8wbUUgYDTq2oj1u/wL5ye8RQo0WsG+rEfP8NajzTP+/HhzvGUst3RZ4yl3cmvfke7ChWpbjucl6BpkdhUyVkUA3oMBZi7YYkZPMEGZmSfUHYSWwkxapoPo/xzwdh8AePTBUifI33+Z8YJ3ukpkefgbtz6m8cWkVZjsvBdUcpKOH0fyZkvt5t0BdEg5Yd4H5/4VfBLQvBlOLigZDO4Hz7s0wBkyFqDacHJ2YbduTaSJfiys1GqkmA5SEMBN4F+kNZko1BfNzE063SJ+ekkkkt/rcqc5bjpyMAHED/Tlc2leuGd+UsOXvqN97qHSXulsFbIS3/A169y53Jehwcyw6uG/gBOFlWt0DZZ0bX1iJlTTqMflqyrxPPCtNWhG7p1nw4phRyW/Z7qgTkPEycFlDGEYsWIaT3fbk4btCPTCdmRQJBpDgrs3uIZmyi14BPu+AzBHr+igWudT+5mNbsJCSPRfNaKyppsWscZXr0IDmlwg5yQLMn2gP6dOYGgQWqYUMbGTOBX/ITW3AJOIbkeEBSNeJXwEw8eux6x/Zi1A+YCGSxMNSP/d1hYQ3TtHv880I6aueL2RyN+7zh8FMnTi54IJy9TRzW6HZuyvVrVdTvOOPU3jMdZuqCiRcqG+SG9uSKasHoVDJHc8YJM64JhKhC+bj6WQXYo4l1PFgA9OYpOne617a0wQnfsFKrnJY1cZ9vvCbmx+FKXYpRC2LJJAOrL5SGSgzDWhznla3j718HWATn4L/JW6ojSdzRWyf1j8b9pOKKS8lEP5pw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(4744005)(122000001)(38100700002)(82960400001)(83380400001)(4326008)(26005)(6916009)(508600001)(7696005)(6506007)(186003)(9686003)(71200400001)(8936002)(66476007)(66556008)(66446008)(5660300002)(52536014)(2906002)(966005)(64756008)(76116006)(316002)(66946007)(8676002)(86362001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZE19NZJRlekpDv7d/xtzyg2LHCQmf26EnvJUvWS+io+quyjv833VCG41BlfD?=
 =?us-ascii?Q?ViUUCivFMSsfobZpYRUAjokU2ubAcslV6oMbH8TN7gGFu/SSO2BWhfqaPdCF?=
 =?us-ascii?Q?NV5dGNhHIwvAjUaon9qr+LsvIGgxcr9ZTvvFavXz9RvmGSsz+OzK19mFMAzN?=
 =?us-ascii?Q?K+QvdZX0KSmL2YYrMhjt1P63YsU1GfcIuKZUjKVPxaCG/XPQ1pff+O8Uzf5y?=
 =?us-ascii?Q?v89Zv5+wiU+I5VyjE7c6jPFcpr7YXMgXa5iyPOsusU8VQvmUYABLdbUFBtBY?=
 =?us-ascii?Q?j3hG295G+pSy+bwwgysRwPPE2a6ix/VPfJwIXpf3auxye1+8X7aVPODCV6z1?=
 =?us-ascii?Q?tBICSd957IKox5fVyOiWAgq+gJCVo24qXudW2O2a1yqHW4QqAoE/1yV1Ftwr?=
 =?us-ascii?Q?5izhrieZlfUepfjQuICzwm8dsqBZ8lgvxyrgzxNNxqqmJ1xNfO1rp9BtuOoX?=
 =?us-ascii?Q?kmoeX9z13coo4A0vLqgiQu/MRdmkbs3Kv9eGXJVd5pwxd1w0lnb9lWYxtfp1?=
 =?us-ascii?Q?5QdwA3oW2Ae5As7Lu9Pa4dwV8KCqCgxNONWs3LSVt+kWp7T9YWPJfb9kAkuD?=
 =?us-ascii?Q?BElWcJONi4esh8CA0ZHvXoharG3HeTFUYe0hrK4mYjg7YXzCieAHsB7GIeac?=
 =?us-ascii?Q?Cqkwzbsh78dCJYIA9IW+P68Bw+s3T2sGvYtqR5mCPrIThbw4yez7gusZfOIp?=
 =?us-ascii?Q?aMIQYNcJ5ErJMLZmIiX90+Ew6J6Rtx6I0Ji7ro9GthwlthX5MVMkrcpx+KoZ?=
 =?us-ascii?Q?Kpw/6uEk15QDb3CWbg5/ZAr2n5JtPxwGZRGUkcv0x6CNzljDFoD3Bz5dlRzZ?=
 =?us-ascii?Q?fQDnoBsV8VSaZpSxqoI4JQsvlKfomciC0KsFaugD7hMUPeOA3plN90ZmBRyR?=
 =?us-ascii?Q?7JgVDSqx05lV8vKDwv3/qRhS1EnBla2SrjgB0Scyjhk3S5RreZPF7osWZk9A?=
 =?us-ascii?Q?IxjExMyJF83JikOYlN5vEJH0jlz5zTFBCPlplrv/jNxJLbdfbowuNnibYY2H?=
 =?us-ascii?Q?8QtHo5uE9dIPbclJiUO7vZ3tJ4SFbJsBpA2vTWLbihx4jxzAOr8R1ueTtoJ5?=
 =?us-ascii?Q?IPEW7qqvNWKyTYDKmuSlXP7PZJHe8AVQYKiziWMzdF9baApw3NlV1Dw6k/Ri?=
 =?us-ascii?Q?z6l4bkWqKNnGjciCnbeTv/Mpi/tAl2qbQecuZs2+YsxbiRg47+ph65iG5zGY?=
 =?us-ascii?Q?f28FWANblTswsAoLkl1qmjZ0yR3h2eLY+RgE5Ra6P0PzBFItadQikWwW00sx?=
 =?us-ascii?Q?b9MU6P0XYxYm1XbaGxyyherwUKdEyhcAjlQ2SStwbVqibj59A2WaDK0J6cQD?=
 =?us-ascii?Q?kzpfezrLhgZPkxpAYuLtQLLzT09JDAVG2FsQZ3d902F7gJRbCW4KIt+d8y0T?=
 =?us-ascii?Q?5i3eID6MlcZsdWF24EdjfThWQbDZ8RoM3oY0I0kdelE2NEfA5tRrOBBpDG/J?=
 =?us-ascii?Q?YaQwlkb2LOI7Dz6C8E9TNauKxSH1bZjYY7M5hD+EDP+3Sgj8w/TYgNxUGV+q?=
 =?us-ascii?Q?5aaSc56x5YUMJ145YVifx10eIhtjhfn6KZKj91IuIreyny6X6aqPUYP66IiT?=
 =?us-ascii?Q?5IlWYiYOb+ThRoVsKokyMwqDEI5nncE3VgpNLeZMpq27DBHOho3XfOGvEyZb?=
 =?us-ascii?Q?ef2uC9zIb8rZF19pnAGwkKFKMCCC6B3+LdoMdAE4kxh2UNpixI0JRpcJ949H?=
 =?us-ascii?Q?U1OEupb8mM+Iwf+tZeXFJCceDOJtz5YvDqIpa+WopBcfZ7gBr5AKYsnbrmqw?=
 =?us-ascii?Q?1KmOpxoTwQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb5889c-9aac-4c4b-045e-08da2210c6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 14:27:47.7006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKA8eRn0vKXZazhhQNua3hD8nLwAAYXTOldT+HZlLNeCwtllZgmxjkQQzkxuHL9hJpg8s+B+0lYJgtts3DKm0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4811
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/i40iw: Do not manipulate VMA attributes in
> i40iw_mmap and remove push mode
>=20
> i40iw_mmap manipulates the vma->vm_pgoff to differentiate a push page
> mmap vs a doorbell mmap, and uses it to compute the pfn in remap_pfn_rang=
e
> without any validation. This is vulnerable to exploits as in [1].
>=20
> Push feature is disabled in the driver currently and therefore no push mm=
aps
> are issued from user-space. The feature does not work as expected in x722=
. So
> remove it along with the VMA attribute manipulations for it in the i40iw_=
mmap.
>=20
> Update i40iw_mmap to only allow DB user mmapings at offset =3D 0.
> Check vm_pgoff for zero and if the mmaps are bound to a single page.
>=20
> [1] https://lore.kernel.org/linux-rdma/20201119093523.7588-1-
> zhudi21@huawei.com/raw
>=20
> Fixes: cd374984179 ("i40iw: add files for iwarp interface")
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---

Please ignore this patch. It was accidentally sent out.

Shiraz
