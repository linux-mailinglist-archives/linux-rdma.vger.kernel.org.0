Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38136FE0D4
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjEJOwu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 May 2023 10:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjEJOwt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 May 2023 10:52:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0B2D64
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683730368; x=1715266368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aYLCKbd5eiILlXKtogri7qpk73LzgekvGJbmn0ANFeA=;
  b=Is6od8ti/kqJ5ubypt37p/6l+PonalM0sPZ1RZC7m/EAqBcJacHrIfpc
   ozcfsPQYWeyIbVaVXuRR1uk4j8WNYS6fOhzGYqOrath90jKYj4y+vsTfl
   uvjSrDZ6HxAumY25znvEf0JcoZYd+Pn1nbKlCt+sY/K1cbVqIMeF7VN73
   wOnSzDBOGTbABX1KzmfKTjc7bSkK2PLuZJD8lCQllh23Oo7tDRRmfJjM7
   1K2oC39HHgYt0LJ8eWUuLJjX+qmsMFKOy4a0BSdPlZikw39VkWEGenB1I
   V595ruU50xho+AI0MvWdDpLeQJkFtGSn1GVQNqLNs1z82374R62PXftSw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="378336864"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="378336864"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 07:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="649762123"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="649762123"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2023 07:52:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 10 May 2023 07:52:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 10 May 2023 07:52:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 10 May 2023 07:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWdsCc0sWnyRpAUZTkgu2grxwI85PaT2m9JbIfEwGCNENyXaJj+JSCL8WZDlh6FHQXykjhQRfHQZMjylMkQms4PZjFeWTRmQ9b7waDlbcRY9l3EchVYiUht3oGMmgWZNKbOegxQOj2DcRrPYRjz5xMRacKDbIzjKNz40iNgPFtQmY1Emgf0Klnp92vIEKaFCsjskcgErcR/XseHIhXaNEtHKEZvidA9HvifkQZrLbpD/oRfXrV+iFDdro39hEUBd8KwDfLvy7yTdO25+7rSumsr4OJqiWTH2z68T98rsEd2efUNkRfwiguoPt7se/5iM+cOnx3/lGfOtAYSVZ2Eivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1C85LGh9kQRVnG60vlTanAym/QaXTgDf1zMSjRpigEY=;
 b=Mwd5j1XdwL2P2G0wezNFi8XRYGRRgNEV8t3swQ+IpxzIOs3pJxAkwqQ9ncBGBS3oxkKQBuBLVmTQ+vIWOp8MIEWEaNqDqMC1+cQhNfVA93zGHISboGb/8iLiOKI6NnbADTcb3ttzHb14yrTW08Mg0W0+r+loKPl00Dcgw0GL8WPIG2GZlSEvhevbQ3IsrCWgp4ahZU2kymLqgYjqYMYdGETMN1PgiAOtP8cissOlCcMLyr+4B5zv7wYYFGU9juy+mf7i+PdxewpPJqjy+dqd6p3n6QD1S6jcoIz3dL/+/rzPfvuJQC9lBbi4sSlnxQO3hTLWengPlPXbtJr+/C2y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 14:52:44 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a29e:39be:c1a:d73a]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::a29e:39be:c1a:d73a%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 14:52:44 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kheib@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Subject: RE: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
Thread-Topic: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
Thread-Index: AQHZgoXLKSlKiKfwJ0ysyWC66mLxVa9TmHTA
Date:   Wed, 10 May 2023 14:52:44 +0000
Message-ID: <MWHPR11MB0029A7D0C0B0063D2F070586E9779@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230509145127.33734-1-kheib@redhat.com>
In-Reply-To: <20230509145127.33734-1-kheib@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|MW3PR11MB4715:EE_
x-ms-office365-filtering-correlation-id: 8b2bd9a1-ea51-4bb8-81b7-08db51663663
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JySwvQbcjsb65e/5ytsgOwF4HOdY+gCogKNW8IASuEeMsTFY2CGbXovsr7cEkcslpCfWz6L0a3urDfNmHSr/VVCVVFAEh8R3IR06OJqLe4RU7wIScS3/jIFuKyhYaDqbm5+tQwRsd2wtOXRc99IU0lakotkBt1LYRB3Ui/G4KsQpmL0BaifxyFTnKWM8xvquTEMnlurP46ew0aCkWyl63hSX5gLYqmlC1axxP3njekLthkyI0JeLqUxcDeuqjJbo5sUjtg4gc+EpoV5R3q43qZNtNWVFaNDOBzTiH+VQyn06iZZfzvxzXRID8h7I6LxLkJaUwPGp+dNLc2J11hAjkrBGmR3VLWLBR8ocqmZhtvE9diE5ZS3t3U4Oc/7yorZL5zsf6BuB9SSeGuepFZqKuqpRXs2ib80lp8Tm2CXG1z+uCHdlpJNmd8wj1cgS1tOkDOzd5tB9QgXwwjGt7QsXT5DaeNfbDVoiBa7lGX7wi7k23n1UEmeuN+CPtU8rXu23M9NfgIFyQyeTJOQmY39LcVjlIxBfoDz5CuzBGxe69AX8iIHsDsni45ScT7mhVjwPCLPxoiyxO+omzbtshnWeDCytlL2Wj5dZeW3ALqQWYzm1fUPYUREF6gDXayv0nrf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(122000001)(64756008)(86362001)(66446008)(76116006)(66556008)(66476007)(66946007)(83380400001)(52536014)(71200400001)(186003)(26005)(9686003)(6506007)(478600001)(8676002)(8936002)(5660300002)(110136005)(54906003)(4744005)(2906002)(33656002)(41300700001)(82960400001)(38100700002)(7696005)(4326008)(38070700005)(55016003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W2K+pX+kwyhho1x4XYdKk/jT32/CWFZciSPYjsdgb0XhJvKzWHdOrfn4tYdc?=
 =?us-ascii?Q?HmDX7jyhgpOtiC0PNtfhzXMieQWyjWMxRFAeQTN8YAskiwpbJ9ORNdVKft/O?=
 =?us-ascii?Q?sfnzhKWNZIjA+7OPRSU9RDv93Q+3kijCimQzLae0Uyf8oGyr1pWWmVA4owNY?=
 =?us-ascii?Q?ln3xaVo41lR12vWyaZ9MJypD2Jysmd/r34TyIDnZLjA6vNvGA2IsYQQO83K5?=
 =?us-ascii?Q?W6faO3opNXDIgGTkAthempmZksuAB7JuTkNIhAKBEKznHRZRKKAWevZI2/gE?=
 =?us-ascii?Q?kUtra8LPAsRWwfA1Be2bBQQ6HS4GkSwykBZfbmEW7yBNPXDCn1MfSFYog5y9?=
 =?us-ascii?Q?rDY3QrfWOu0+o9KEX7SGwhcZejzQQQtXbt++szzeeuY/LctwvttSMkslASPI?=
 =?us-ascii?Q?T66iEXXqxAhWwow/sGrjHBNQEALz1iIzC3l9IS4SEcwMQb7o29wEmVTpsJww?=
 =?us-ascii?Q?Q3ZiQmt4HFIbF1gIqzIA5dpgqrVpeq80iJ83OiZr3LBgDqWKC0wFx53+nDkm?=
 =?us-ascii?Q?nnd8OlOUY3L5Kx30XZWMlURLIAe8Hp8/8FEXTofPRKIZtW44+Xo2ECSjDX63?=
 =?us-ascii?Q?pzcVS8NcqK8qtF49cwMfm47eupEs20NtmsVljq9TtRmIEl9NLaLPQUI77vmD?=
 =?us-ascii?Q?0L2pPHOd4GVOpBjduJBGrmtmtNBW87Kjxwit8NXk7HkN0OBfw4Tneu78rn08?=
 =?us-ascii?Q?nqPDL4JkBJc/QwLnPFLcmSCl74+hHkI8XI1vplfZCDxD2FnRtB/fdwNPPGAl?=
 =?us-ascii?Q?2jRgxK9rWoFPydSdv0Fd34Vecimb6PtoKyaSvDWeK/OfgGffyX8WwA63RHUi?=
 =?us-ascii?Q?i5O8WXPLs+cCOaPEWB3nCFpOY7sO0cxkaJeZoGROoRM0qBwu1s3hQWVCQNQ+?=
 =?us-ascii?Q?qXpvCwZ51CtsIHvaE+3SLomJXTzvfjq09U4gKSzym1c3OH3hEuIVK11XH1vM?=
 =?us-ascii?Q?LcJZdui1UFDCLXhboTtN8eyl0zn799IglK+S45BH8xjJm1GCpbRUCF10FcZ6?=
 =?us-ascii?Q?3/sERgWriKhHScHhomUH+UquqHDJZ4eZ30TpVM8U5vn1W957f6daoxNDGaAu?=
 =?us-ascii?Q?TXJAOaPdChpF/314hh1uHV6X9A03iNFUtdi2s+tXVDrBsa8q+EyD19sWWUmt?=
 =?us-ascii?Q?kjSSJ0ih8J7GsWUcNuxwzo9oJoec4l9AH9RLJjJKTvWwu7cNOGtAuOhr4D+R?=
 =?us-ascii?Q?6mWQsCNe3DPv/A3xyTuEuoJ6giHkAt1OZEbijZniHOXSrlA1fVv+Lue+eLqf?=
 =?us-ascii?Q?FCrfYu4trWxsiF0qCj7umThZr2opwofTlGMSeADPkOdskDqNb019vS3jRixU?=
 =?us-ascii?Q?PKj5V9ZbSseJ1/SO9H2xIlpynsL9KhpvG5nUu7zOdi9Yl1Am3nQbXU1cwMDJ?=
 =?us-ascii?Q?CP6sFmQ+auefEwW8Ol7b0btOZe5lKTVbpIyFz4e/zdkI4DqA7WG1u8+XcDsH?=
 =?us-ascii?Q?pY/q91yjBz4jhqR7iWcJU0Cu29A7lYkJlVkAT3b8RzZKVL3lm7iWQw4gVj+C?=
 =?us-ascii?Q?auV+CgYPrxXdsv/ri0EUUtHbAHUFkpFUY23pc1Pzfz38h34lRKsQhlkv36uX?=
 =?us-ascii?Q?cQlk07qc4ic1IYYMdZ7RWxvVdPyddBMWKHcbrPN3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2bd9a1-ea51-4bb8-81b7-08db51663663
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 14:52:44.3489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkoJ5B6zCIcd2taLNkTPmlz6qX8ewcHhNCQW7yKKKKDVjmoz9NLcsZrsskEk423ZnCmjN4KMtWZVAexCoMYElw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 0/3] RDMA/iRDMA: Cleanups and improvements
>=20
> This series includes a few cleanup patches for the iRDMA driver.
>=20
> Kamal Heib (3):
>   RDMA/iRDMA: Return void from irdma_init_iw_device()
>   RDMA/iRDMA: Return void from irdma_init_rdma_device()
>   RDMA/iRDMA: Move iw device ops initialization
>=20
>  drivers/infiniband/hw/irdma/verbs.c | 35 +++++++++++------------------
>  1 file changed, 13 insertions(+), 22 deletions(-)
>=20

Thanks! some minor nits.

RDMA/iRDMA --> RDMA/irdma in subject line for the patches.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
