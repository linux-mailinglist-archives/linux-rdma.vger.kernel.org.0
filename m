Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2273676602B
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jul 2023 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjG0XNs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 19:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjG0XNr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 19:13:47 -0400
Received: from mgamail.intel.com (unknown [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7402701
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690499626; x=1722035626;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4PD2jbMQHi76JMP/DG6N5tYwA5aDRG3DihWb+cPGXs4=;
  b=NJtKZTwc4gEANv6/TVdjM6KDFXRVsiVkiadhHb8C4N5WewsOtQppqKyl
   qduzI2Jd7jo6+9hkWdc/cxipj1D5+rWIkaVccGje2Q1A3d9y7fvdBWw5z
   pufZNRavv3dfdnzzbXodsr7TvH0XjF4KzdntulDPQpjM0F61SIAmlyN/p
   J2HvRs8PYwIT3YEB0C6mn1ydJ1aTgR4UkiLCidEdxWIXTE7qCzIMlAOt1
   N/f4HvmVSdvTlDd/k9CkR5xUYmSv3Yzm1+lwbTWRQXPuA2/bamIu/36Sd
   J1gSGJYjjMzOwouktfcFc+0rWf8kQ/8tyxZYq1wXgUce4GCf8+vEPXS+J
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348735128"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="348735128"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 16:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="850950136"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="850950136"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 27 Jul 2023 16:13:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 16:13:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 16:13:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 16:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5TtB8bb6VMJLsda+lKsDBkSuuH58oZl255TA9Y5TXryDRB2G7NJRWihnft2tLdnQPLcmLdzkEhjQJnEtFNKd84lK0zoeIecNiiKEg52ia4yoAqwRIJv2IfSySTyu11JWrkmdPlhnOIQRftkPQFo0bvW+LEoNe35DjxljMIRRRrJiat50dLyEGx3BCxXWHQPlit/+AV+KIboMjGTneP7mu2+4YG7anE7fT/SYfGMqXGmBPdhBXrtCnwR4rRpncXkysCi7jbuSCcjU4wQqJ8bENrm4ZMFNJqcgQFRc4fA9GkQIFBEy2yetKv0Sh6P9QRCnnvKX+RI1Nxot505uBZycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bquHHScURA0udF8fUjTBL5EcWIqMYpUKvVg4uF6j2Zk=;
 b=CGUPU7b3kEXtKcb4Rl1JfjIzzWJPzoQzY0Nk2Ac8BRngQEXwQ8RBsxUZlWmtpN9ZWWXCY4hgO+4QEPcXf1fvto3WLOinfzwGVMIjGKi8deHTONu6buRGQEsRAXzb9ZFnilxlhADYF9yPCR54s1Miqk7BNW1gLfHtKqdRleyALkm07FSh7eyTOB9+pUpVpUk73R9s0pVKmeHmbkFsru29pInEQi/xSMiQUWsw9BLFhu7xolU/kaVCnr+L0oUbRVTzvG2HsxpR4E7WaD2/1PuzQw/DT+ywVxnBbuc908C25AduOrNjd0NoK+s3AuY/ELJDC9WuKeMXcjrT2yuqaAQKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DS7PR11MB6063.namprd11.prod.outlook.com (2603:10b6:8:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 23:13:43 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::9514:64d2:1cf8:2eae]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::9514:64d2:1cf8:2eae%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 23:13:43 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next 0/2] RDMA/irdma: Use coherent user/kernel queue
 size
Thread-Topic: [PATCH for-next 0/2] RDMA/irdma: Use coherent user/kernel queue
 size
Thread-Index: AQHZvxB9u7wmAqUeiEuYyVjtK1pYda/OIGtA
Date:   Thu, 27 Jul 2023 23:13:43 +0000
Message-ID: <MWHPR11MB00295E9E067935476E815F23E901A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230725155525.1081-1-shiraz.saleem@intel.com>
In-Reply-To: <20230725155525.1081-1-shiraz.saleem@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DS7PR11MB6063:EE_
x-ms-office365-filtering-correlation-id: 0aab7ef7-8473-47e5-21c0-08db8ef71f37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JAr/wC1lMnSZDgcto/Cquv4KUtXV0ULMWamVm+sBwqvvtr1Cy+up8ILfYC4fODB2yeBrIUoaDSJe4MS/VryrP1Ozz4LxwPnoJpZMalWf6qbxHaOuqampZLm65zN1rCRFVZSx3fnZG97TjiUpCjXNQibZsdeEXXwgjURTKxhoenzoYNTWIJnIYT8Z9I3XBdz557wnLnBVH5cGaP5jHMyIA2FSj7r9rOu2JwDJB999eKxZealhVqzxhDDTyoSZymn8SPcbkY0fVzH1ikMJrfOEeSMW8EFNL+w0XDYHQiRY70srqaxC5Yh/KLVUIJydWCfXaxW+HRC700wutOmJWzkR36tv7+S6Hta6r8XO+iDzCL+gwrUCy9HvDhTKFzWTXJ8qUwKj5a6CpBxhQm2GlB4vUvQz4Bcfs46kc+Ie+e/pgGkasJlWrT4AL6MMorSrF9VxJwV3qvNEBHUrTB5auSvMIKH2Vy0+PyDW6fuLqCG8pGJE3jf+jFjHAy+GD8cHPKQbK64W20d2A/cK5gprcfXRN8ck/eArXm3Ll7D5QWTE0gY627ACfCPtRAjA26CwCXYlUIUR7kZV7Q9+pe+h0hTcdQfymjEId6HvHKglBERV/+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(55016003)(110136005)(966005)(4326008)(7696005)(41300700001)(71200400001)(122000001)(478600001)(38100700002)(9686003)(82960400001)(66556008)(52536014)(66946007)(66446008)(64756008)(8936002)(76116006)(66476007)(8676002)(5660300002)(316002)(186003)(83380400001)(26005)(6506007)(86362001)(2906002)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eEwcpEXiEqpvU+nzgLUBieQG7jSCw+eTbe00rPXMGJjFjpf1hnFAoJ9PtmSe?=
 =?us-ascii?Q?p8NtA1vZvQW/NA/iQWPYhysx4QRLjJvp8wjeSRRJC7ZTOwFxgnI/voSVIckl?=
 =?us-ascii?Q?edREsTB0B4OFaQlRHz0XQvPfTemYlkDzaFXtGaziHBDv2Ru+RA0a5srmdcHf?=
 =?us-ascii?Q?OYzgRDhRPEsfS6+cm/mM7RrdjFtDMoR8lQtIokhijtPC+eeB8aPXZQjyMQMr?=
 =?us-ascii?Q?HZQTv5HzpkYE0UCnZySkX8eCRZK0hhehDA/XbpH0LIDzi6Kg9y3IBsH47gXm?=
 =?us-ascii?Q?ev3QhwUuJ4D8PyJoNhxVbELvIhnGwrB7h8xEQ2gXGv4EUrf/KFz3K1SB2OMk?=
 =?us-ascii?Q?7l8edobpsAOL4jBCMWZg/pLuqaL2XGl3JpmWb+/OyzUQtxQRpuosydW9bgRe?=
 =?us-ascii?Q?0gb98QiKw/jZ9p3VZ6Eqi6nY4ErT2rxSqRGlKuKYFKUHcZpbZ8XRsHJkGy4N?=
 =?us-ascii?Q?y02tdtPb5qz77kQAGTD4Jz2w5fdxXwbogv2HcmpwSiuykIkZQO8MCF0MeSZe?=
 =?us-ascii?Q?vMWBUpxoW4W9P4IfQuYwjhbTJjc7LZNLTfQx/LtRBW8B1K9voxJu6cSqmSl7?=
 =?us-ascii?Q?h8JOLgAqtl9/uVDXKTTGmLZiGgWfldzrw/J3PtbihqFZkechTF+w2IY+MP7T?=
 =?us-ascii?Q?uO5d68b5f1vrZDga7U5zQI8qTrrZm0mW8ZQuQA+SEptn2fzJhRzCVGhPitNf?=
 =?us-ascii?Q?nGz9IWjDk7rEoNbe3HsCRAope4JJlahllaqlbYzDcz9rtuF1EsZhFHNNtYO4?=
 =?us-ascii?Q?X3N85kpOim9c/mATvsdcRmfE1DLQJTaymHmKzzFSfavzJ/tDDbVH3Nu0ZzNj?=
 =?us-ascii?Q?ewLSzULFq9hI2MH2h+qI2q/rJrAozcJIqcuErGQ6S68drIlHo/94Sb0BKF9Q?=
 =?us-ascii?Q?/jOzP5Qjn7d7xPWoyeNM0leMwUUsy+xgKO2PA2jo8UaPXyCzOX3zoyvWcyh2?=
 =?us-ascii?Q?qviafNBHMeZUULkY6BvORUae2nktulGN5mdmtvWLIRYL9qXIQx7Zd/v2DIYs?=
 =?us-ascii?Q?67Ul8V5OCYAwzBF74TLQ2hHDdmMqD7OuO1YC5cVjc2kvdUVWnacoUNPenXd5?=
 =?us-ascii?Q?qGIDlgvuumvHR0a9tRTN1GYY5Qt2iuW/ywiarN+f1Xn1MwQG59kG2bZs0ZoZ?=
 =?us-ascii?Q?oGkJbhFJ4IP+8iLw6jS1tOXtaZx0AdCpN7KrT+Lc1yldmn/bIcUpzGbTzglz?=
 =?us-ascii?Q?kW6cKqPOI8NmD33gt52+7ZGieDYUfBB5cPX2A4i962tqiVy61xZhOBqw4ZY2?=
 =?us-ascii?Q?i/12aM+0TasJoXbtds8TKsDHetKHTFdG6gFQy7eRo17CIJnQkb9icxTk5Jgm?=
 =?us-ascii?Q?vsV8gz3T1sAn22Q5bXAxzlXTuGVipM5SJhQqfdhhoW4cNRnzxOgQDhA/sKA/?=
 =?us-ascii?Q?/i5ZAMBHmd8akXVUqQemMhga3JePA4liLrk82khDz3B0nQnAw2piOcUBSq58?=
 =?us-ascii?Q?9kAPXWHW3AUnAyTtxWvk0FufwnmwljOhpXJZGyrdGA8tg0VzN5NaR6vUXpa2?=
 =?us-ascii?Q?biN5oQUEVyjWDGW9m5+6O8S23rjkxKd8nrZ8oRWr8rb2fQE57SJ5B2G7QcW8?=
 =?us-ascii?Q?FyQBoU/7CUKc+XAvM1BUCO9pvf5objGWQVQT64tW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aab7ef7-8473-47e5-21c0-08db8ef71f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 23:13:43.4803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a2LE42J2UlTizzcjCOr2ok3rlQv5HuJk071mtEKusrEtwnLbRpIcAoqbDsy2qkAzqi+QVkiC2sCyQK8apRBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next 0/2] RDMA/irdma: Use coherent user/kernel queue =
size
>=20
> This series extends ABI to allow user QPs max send/recv WR to be retrieva=
ble in
> driver and pass generation specific min WQ size to user-space.
>=20
> Sindhu Devale (2):
>   RDMA/irdma: Allow accurate reporting on QP max send/recv WR
>   RDMA/irdma: Use HW specific minimum WQ size
>=20
>  drivers/infiniband/hw/irdma/i40iw_hw.c  |   1 +
>  drivers/infiniband/hw/irdma/i40iw_hw.h  |   2 +-
>  drivers/infiniband/hw/irdma/icrdma_hw.c |   1 +
>  drivers/infiniband/hw/irdma/icrdma_hw.h |   1 +
>  drivers/infiniband/hw/irdma/irdma.h     |   1 +
>  drivers/infiniband/hw/irdma/uk.c        | 101 ++++++++++++++----
>  drivers/infiniband/hw/irdma/user.h      |  11 ++
>  drivers/infiniband/hw/irdma/verbs.c     | 184 +++++++++++++++++++-------=
------
>  drivers/infiniband/hw/irdma/verbs.h     |   3 +-
>  include/uapi/rdma/irdma-abi.h           |   9 ++
>  10 files changed, 222 insertions(+), 92 deletions(-)
>=20
> --
> 1.8.3.1

Library PR is here: https://github.com/linux-rdma/rdma-core/pull/1374

