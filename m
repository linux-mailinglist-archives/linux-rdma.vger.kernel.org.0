Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE0B7586BA
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGRVRs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 17:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGRVRr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 17:17:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA3F1995;
        Tue, 18 Jul 2023 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689715065; x=1721251065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Sktf3a7hMiwwC1SqTQSc62guPtfPJu8fgsWvCzPl9Vk=;
  b=DTsHAfJWgpIRH/22QanCmpZNKcgrFIHCsb7WApkdvADXCYEdmxWKIMI1
   NJwMAlPmAZLTz7WZZE4CZeP5HdnPzBEfnqypN/x3LVUQiwTLYNbAa/88B
   bDtFyxNcycUuMPqAoy38Nf8I4OYc58so4uiqZBh0DPspOE58m01o/YHLq
   rlHrjUADYWTsQiwq6uzzVP5wy6ECHatkFIddqEJJ8pfqgfTPbROvS4GrA
   4SB1Hjx8OZ0kDEKJ/dW4oApxzDm6ccWSb4jU2KJDh7blyocC9cs/H7JEa
   XCxbCLFY+3ZXgoE3Q1c8E/o0h8i0nTdrp8LUPVwG3s6oop9Kr49EfRK9L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397162993"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="397162993"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 14:17:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="837417851"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="837417851"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jul 2023 14:17:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 14:17:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 14:17:38 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 14:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5tuYH0aEeQphgfJY+ZH9LLqmNisgFNM2gXbZamWYN550p+DzRVh/ecZCxXoFI/wzw52Rsa9NBaxSvTc9VQLd4H16rC4G7f+5yxM1aGw9qmZGtJmqBpT/0st7Na3ctxoeTpVPHkNZzwojmYcSea5Xr1f5i9uHzTaFoHptvOH7PZKiyYmD7J8Sc28jBn+f9DXMFId3LVCz67331MH7w4W7kkFRB5GmoNvbO2Q8iBlMKMk7uAL17tYIMfbOUUh4rJu1lvH8WGjFxIZqFg3UaZL4RecqVLUbhv7dkKGb1d+MEp2JRY3YYC7HiaQPeWHqxRtSOcrZzrvZj1CUws93bhVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSKqDH6NeqMQqLfp9KGwGEoWlQKpzwvGT/b8jZYG7ls=;
 b=EfYFJsvuif0XkMZCnPlSo6P7IvFseHohneXT8eKNSRGUnFXCvTg+hK3Em4jVmWpw4VnekuJEtGRQegd4tnE7o930K0AUSETuzqp6vZXtRCZGpVbhaOx3a5pgP9NFFIDdsViiJSFjcbuTxW0EPEHNA0Jzh4eCto8hq1G6NItyCviTlD0GwFcZG53iUfW3PJjV/bu8/e8uujCmTUMyE2t/w9y+Ik8ygxeqJ77vBEsG1sfiKAAI+80Iidr2EMXmeI74Aq/Qocv3K1iAEWX7oZ2125usctfdZXJnGu7L7RD1J6P1w7+XcX5IHD9rEyBzC4sUHKclACs/CwoAnV8vTnW3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by CY8PR11MB6940.namprd11.prod.outlook.com (2603:10b6:930:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 21:17:18 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::d640:6dfd:c759:1c0e]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::d640:6dfd:c759:1c0e%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 21:17:18 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Devale, Sindhu" <sindhu.devale@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: fix building without IPv6
Thread-Topic: [PATCH] RDMA/irdma: fix building without IPv6
Thread-Index: AQHZua9+pH4mO804dUWGwvttR0llLq/ABrtw
Date:   Tue, 18 Jul 2023 21:17:18 +0000
Message-ID: <MWHPR11MB0029128131B076B77BA55078E938A@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230718193835.3546684-1-arnd@kernel.org>
In-Reply-To: <20230718193835.3546684-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|CY8PR11MB6940:EE_
x-ms-office365-filtering-correlation-id: 76282bf0-eae0-4f48-c1a4-08db87d45e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3haMC7FbEZc6bocgWl65YkTaGO0v+yP+0jb5umE2lUtHBnL6+/4NFuBSLh866gEHKA5XiZ1IATS4EbEH/vN8IbgrLEq2CkKph8q81PQ0seWxuhh0wwTj5BQND46KFt2lObsvmvVCd142GJ/OCi7NzWlGkiBcdTSw2515ZtoKV+Oei6oBC3Zk+UV3HyPDULEXabZZpxq+luVyKnNz5Ni8nx7d7SPgYq3395bnkff21H9+TI/RlhDrlGAAudzCZmGR4At7f8DytNqEppetLFXBIG/RnnAOSk/sd/e9rUi9pOC+zq4tJgfqBXUmikX9oBNBtqaJU4GV5UEi1SCseToWF7kewBaEnr5dtqSBfeISTIUwxDwN/6txb6XHtn1mdvfx5eBxFlzt1ECiUJ5yiO2vJGmOm5x9BcxxQ/R18zkqcdAbk3LZjjUe4sm7UTZ0N27tWXaBvjSt/HbVDzmk2z6T6pxZ6GbBZheaDHCXrTg19BRQdX/eGoc9t6P2tlq3yvwQBsgNk+DpIfrvJfOIXx5WvfYn20p4wMlV9YkhC2MpwLXTqy6dsDsP/lPuKb3kXC4aaTbdWfodbYta+vFkU5J004HoK0QqE4giMEYgS23o1DRnAig/y4krnvpAXgYbpMNA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(110136005)(2906002)(478600001)(7696005)(54906003)(71200400001)(8676002)(4326008)(316002)(66476007)(66556008)(64756008)(41300700001)(66446008)(66946007)(8936002)(76116006)(82960400001)(83380400001)(55016003)(38100700002)(122000001)(9686003)(33656002)(52536014)(38070700005)(86362001)(26005)(186003)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OlyoxaUw5mPmIEPvtyLfWiS1DZxxQxH6kuUQqpzuGj7Lv0qH4wFY16QD+sKC?=
 =?us-ascii?Q?+SpoUvPLBJvwnVzwNdZ+OSsO6FqTgUM3GQ2bJR2so395K/yhqwSE3nKmSPLR?=
 =?us-ascii?Q?msdMF6F5Sg6SVtOc/OU8vS/Rg0IULz2OXibuLZVJ/kekQIRMoEodfUmM1Uir?=
 =?us-ascii?Q?ZHGz25SeVqfP8zH2a7j2uCDMob19JcmHzRdazsQly7KkOEdGK9cu0pJ6Iqhq?=
 =?us-ascii?Q?QjRE7VpKqo1lR+V0HVPnKMWVmpBRA1uTvgsa9jvzr+3Q71uc6q/UCcJxokFD?=
 =?us-ascii?Q?K/VMbfNoWacQkO12opW0TbwGP1bGjIisL2RJ3kR5vjD71g7Sum3o4fbk/e5n?=
 =?us-ascii?Q?LAOuQoD4xZ6i2eD1YbZIqb1m3SOjec0pA2QVWo+Mqo2EePqyyAcGG//zaWeH?=
 =?us-ascii?Q?pi8BIsbZK/WvtTfjQOr8nLZsViLyk/T48PEDWOlklWJMPabb6qYxWoO87fIs?=
 =?us-ascii?Q?GQR9xtYZVHMCtQBggeeDZ2XILGSA8jDI/XPAqWRyw2/IQ4GI4cd4q+moZf3H?=
 =?us-ascii?Q?Qb3SvgR4NbXFPLaUo5EfwZEa4WT2k+EDEy+5Mge/LxBYVaU04kv3yOGdF45O?=
 =?us-ascii?Q?WKExQ7D+zmqEuvmxcLWDfVJUdCZQxnnM/PnZjnSEG12zdu/qR0wo4FKt+Etl?=
 =?us-ascii?Q?fxJRblRUb6sgQuiwZ5LNglL8nmSZJ4CmJRFY/FrtJM812s2JDAB/BKrMkk40?=
 =?us-ascii?Q?CeOYdulByjAoGibTLo07gjyvXOmk0TzUwG4UufHSct8QzcfkPFWWTtzouNi2?=
 =?us-ascii?Q?LDqvRWrtLkPAS9wezSxLtlPMhJjByGA+9zfnDc3tRWqxQJAyTmctm8D+867S?=
 =?us-ascii?Q?pEeS4hoDNIAzTOR7yIe0Oix0ZGaRbkppkhfcJeIeQq2ilkjw8LupzY9gkao1?=
 =?us-ascii?Q?rk7Nf0Z/0hERzgfSg3b1mJojUkQWuOFoHyU8dzD2t39Y8E3liaBnuW2SPQHQ?=
 =?us-ascii?Q?YkjEvle7PD4e8pnC1MSRyplgrmTldyu8+69355idnnElOFQ6+X9Ztzvc/O1U?=
 =?us-ascii?Q?RQfPhqdxG2l6o/zNrIf6mHfdOY2RBdck/O6t80pJQukjMKp/sSC0Jrnqjj/d?=
 =?us-ascii?Q?kXIj+tt/W/Bkx21jgvtS2Wd9Kmk//2/YHph5k2BYXsT7sfVI9QcToa5LjQw6?=
 =?us-ascii?Q?LFMhOSNg6/gpts1adz4rBO5FopR9pQq7Epi9+NNfucz9wQEuouL4E7yqoG7s?=
 =?us-ascii?Q?3+a62mLO72x7pFhFHGsJ0lxKPHSDVG0jbYjtLuTBSr+RU3rGOlCuE6kbHNNT?=
 =?us-ascii?Q?kkfjGQ0Vgv6i/7QIF7NYnfOs5gei1H6Xh+Hq6Mw6krH3dScmiJbObKWXgGip?=
 =?us-ascii?Q?salvFEquO8+KQKcBWOXL62WF9gOGQH21MwU4R9L+Q+gDljfrst7XDiJFFqxx?=
 =?us-ascii?Q?Bu6BFuMUjoG1YC0Sma+Q+nLGRngNHj0bKlj1PkzYT8ouuJ5eokI2ICVHgeWw?=
 =?us-ascii?Q?D1npL9PuVSSghYC8CKW+3Q4oyJcuJNswVj1/87eX0eCvEH3tRJZhzJCmHjBp?=
 =?us-ascii?Q?y+4Xa4XVSbQmO1LLO4VKLe9hotp7ClDCamUVuLXCqNjCa2GQ39fDt6yo/mVG?=
 =?us-ascii?Q?+nI+Cfc+OeSfVDk+bD2DO9OzSCVpra1nJ73j9zgs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76282bf0-eae0-4f48-c1a4-08db87d45e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 21:17:18.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQSTbLb7nipcVTCW5/EqRXbDYoIdikdRda9XvGSLMofayvkrLr8M3rV9LTwlNzzBpycz1F8okDyCx76W5BVj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6940
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

> Subject: [PATCH] RDMA/irdma: fix building without IPv6
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The new irdma_iw_get_vlan_prio() function requires IPv6 support to build:
>=20
> x86_64-linux-ld: drivers/infiniband/hw/irdma/cm.o: in function
> `irdma_iw_get_vlan_prio':
> cm.c:(.text+0x2832): undefined reference to `ipv6_chk_addr'
>=20
> Add a compile-time check in the same way as elsewhere in this file to avo=
id this by
> conditionally leaving out the ipv6 specific bits.
>=20
> Fixes: f877f22ac1e9b ("RDMA/irdma: Implement egress VLAN priority")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/irdma/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/irdma/cm.c b/drivers/infiniband/hw/ird=
ma/cm.c
> index 6b71b67ce9ff0..8ea55c6a3fba5 100644
> --- a/drivers/infiniband/hw/irdma/cm.c
> +++ b/drivers/infiniband/hw/irdma/cm.c
> @@ -1562,7 +1562,7 @@ static u8 irdma_iw_get_vlan_prio(u32 *loc_addr, u8
> prio, bool ipv4)
>  	rcu_read_lock();
>  	if (ipv4) {
>  		ndev =3D ip_dev_find(&init_net, htonl(loc_addr[0]));
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_IPV6)) {
>  		struct net_device *ip_dev;
>  		struct in6_addr laddr6;
>=20
> --
> 2.39.2

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

