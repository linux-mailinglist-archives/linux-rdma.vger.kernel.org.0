Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3BD6EACE0
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Apr 2023 16:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjDUO3Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Apr 2023 10:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDUO3O (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Apr 2023 10:29:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BC30E9;
        Fri, 21 Apr 2023 07:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682087351; x=1713623351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9NKg+/FD+B2dMpTzBcossHl+nMbetXbMGHeeEyX6IQs=;
  b=bnh4Kgyt/qAPCSOpVVG+o/q9rECKurhBALbjTQ0DhO5t/7N1bhI+LNLg
   aPtyzScBY7CYLcNnt69YVnA0m9hldrvvVuUeYu0PoT2U0cT05XY/61xbx
   9c1xiV3Hp7CUM1pkKw/gIz6AkvoMteVTbJ0IhuHOOOUsIspXozRCJwv46
   5TM9VocqBnMDAAg5XtzEJjvtwuNtysLY9uWNRvEpnjAOxqVr9iyA9ObJc
   Ragoc98dSNMKMR8dmc0oiQcMb2KGiRLZt5xtgaQ1kwXQpDaE0ZI904X7D
   8z8aZFK6WFeEQaghuRY5SMjBmyVROl+FBBn81l4Wz/g0ZZt494SOhKgoR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="373927062"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="373927062"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 07:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="669739710"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="669739710"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2023 07:29:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 07:29:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 07:29:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 07:29:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 07:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUuEa1fthC5R7Ur82Lbfo++5ioWLVSDgxuee0HPg3RGLmUAp5qvL7llzlhRcQt3HtMZs4jNH0z+w4hAJoZUOoUu29bXiqRsJofTCcQEhgDZEa9jtU9RWS02010sfWePNnfn10VPOPIQE9N4IN2GX5irksMO9863L7dINy35AvA+5+hfQW5ejPfEM3aYHLnGxF8PBVcgEmTrp6yYm9aH0K085UjV23GGBPtvwEJsQUzA1fhCmsN/dZhYOpFLv465u969ekqy9uhaqtuOVfFbffbs+pOl6+H+4VgQNOWsd7bhJDRiF4qtyZLC+et5MmQtwN4WZQopfASh5xdkbPrxV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQZiNGjCUKPF91XpXL1ghFTGDEyb8IzM44Qwjd6IU4k=;
 b=IFPJ6JbpWDQTxHRoq7zdmvwsjMjvIj3NbOXF4ndeSB11L1uO5h12mZE6xH7quiPJdt91QAxkBJyXi2xFyPLM/EKI2x/i/Ehruse+Qit7QbMy+jD8i1sc+k9FlZns7HHZwbAkiZL1a0lLE/ltFEvZG0LNEXqbDebrsihQFwC9A0oeXl3Xiwpc0VdD/I7UkQzx+ahKtw7KRkEyJK9ePudxdz3s+tYgOWrGE8jU+jR1E4TeiOfxk9Tiz96XuLxIg3SDnxkTmqykkEqqN2VVcKxo/SHSbRVfjQhIO1bATx35Wv+v8ePvPovQm1C0flteF8o/u0ShODyuquXzwYeaFcAQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 14:29:07 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::aa88:dd72:6809:9c05]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::aa88:dd72:6809:9c05%4]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 14:29:07 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Tejun Heo <tj@kernel.org>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Thread-Topic: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Thread-Index: AQHZc8EQp4z6xXqwzkCZnEExjd5iQa8105dg
Date:   Fri, 21 Apr 2023 14:29:06 +0000
Message-ID: <MWHPR11MB0029F5F9C9AC249F2BC3E981E9609@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <ZEGW-IcFReR1juVM@slm.duckdns.org>
In-Reply-To: <ZEGW-IcFReR1juVM@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: a18aeff7-7219-44fa-3b55-08db4274c3aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kZnRO92Vv90elKTTA0jNCxnPRuUmtrf5KEgpfEbT+RVQ2/44soGFHZQLSAI5K4Lm1A6/F+EEUIpv3e/28p0c7RobcUnESOJt4F1xHpglVI9L250p5Qnuwyh3rhH39Yl5jfzyav/P6KMYEPAWN8Oscb37rJI66fi7y4RqDcY2joEak+4aLTjn7bgUc3s0uRh/KIF05P6JKuYjgh8eGuDZItvXgJNNSWXjFPit5VgyFhJBTgs1amifobxHCLbBATawK5Dihig3BqGFo+6Om0/WhMCWxgnnn5WsE6geCEkTYoTbn1pS8nkRaHVCoq7Vkr2+h3YTPdGBj3XbEAt50Mo029oX/rz377TlaXNKoKsX9sSZ7jBdzVn5NSOrhfCw6QNX9rdzEBZBkuvm+hG0DuoALfT/6sMDHQ0eU+K+5+g0JTw+C4fr5xw3p6gP7InLXMWdDS7Z7mRJIefaMop3WtDVBCBwsOXpD0QJH/TYVU8X1/zGJ/6KRZ7IH+9sHPvqb9VZyKGzdmamjICAuiOsXVAuT3wy3oUk4nrL3KjzNg7RUpoCk5OU6xA36Rwb1YIVTsV3Tk59rWbFFExjEr5LY6wSWTimzxvO4ayrbT+7ZbacSLh8njkOSeSmzIKrKyWjUI/l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(71200400001)(6506007)(9686003)(26005)(52536014)(86362001)(5660300002)(8936002)(8676002)(33656002)(66446008)(41300700001)(38070700005)(316002)(2906002)(4326008)(83380400001)(66946007)(66556008)(76116006)(64756008)(66476007)(38100700002)(186003)(7696005)(122000001)(82960400001)(478600001)(110136005)(54906003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Zom37mk2BgcBjqW94HUDX0MZ5teVGeo6O1SQZjarz1GEsaNyIrc5i8soeI+Q?=
 =?us-ascii?Q?KddyzL/QsLsFIWuIPttEpvSHtLf8oLgW/PhZ7hW4p2dMv5VQhOIP+nnr+u7h?=
 =?us-ascii?Q?bPsJwsJwJGxCqPjeJiW6+EyRwrR/XCI16PZNdsf/CxruKvdpdScQkXXfJXDx?=
 =?us-ascii?Q?ZrFEfecG1oZK0xetiB41nlaA50mpBuEZ7dSwFy2XlDTjLad3RRr4lEyiDZhB?=
 =?us-ascii?Q?QAhgLhYp/UtizZ3vtBymcfYGpLHid7H8VnA8K9knJPmfItPiM7Ewv7GB4orn?=
 =?us-ascii?Q?YU/veDNcZdpGGgBb0fwtSf6AehZPuMh5ApS2O+NBO/xUXEqF41GyrwHfmERk?=
 =?us-ascii?Q?LBsjLxwDFWmO7r1urcI+r27bltf2EjBnEDVRROz+cTjNsChPj2KjfuhLssRj?=
 =?us-ascii?Q?l4HVtd5EwBtt/pQYRa5lgRH5I83wr0WKJdzqfYwe726JHJVfkG/1fYYyZXJr?=
 =?us-ascii?Q?imd+iyuU39QWIsuvm4zbmCTFwX/yBcpPmxbN4F8A8No/cZ4buXU9vj73i6Nw?=
 =?us-ascii?Q?pw5OkqiWZEug5RDsQCY+WOlv4/BpUdIPbqe00geP8EuYWZ1QuHBLnQ+deGnz?=
 =?us-ascii?Q?VVeJv+WaDlTupDaSe0wO195xJzKp1i5W/xd/J+2IDI/okobixA+xRq9zyUSp?=
 =?us-ascii?Q?0xvRx+PRkhZHz+bSrBL9TL9vGnioyxIBx7CMCu7/FS51SksUWa6g8r5rVL3S?=
 =?us-ascii?Q?s4CV9mqbxZRSh7WdFaHMa4swbk5EL3PMGE7AUib591G/FkOmVKjbmDxjuuv8?=
 =?us-ascii?Q?EBmOSaGVk+Kb6Te5Ym/vphF/NY6MOg+bl3zrNb+YEaLkMkRBpGrQWN5bnR4m?=
 =?us-ascii?Q?DBFF561K23mDE/svqmpE+/A56+plBUgeRTDsDyGaaT9InLKHgdWsL0oS43s5?=
 =?us-ascii?Q?ZOX6/UFaUgzd5GCM8Ch2QMtRk5Kd/LJ39GvdcB22SptRmm50mwH2IwTh3uU2?=
 =?us-ascii?Q?JoZUaKUY91Iysvlh1eVVEigesgirCiiUhptbbV85OoVhMGvvJla/h3eIpOUu?=
 =?us-ascii?Q?eepm3rjwOy+d8FrC2BwgX254n9d1v/DjrdCa7Cza5Iydb7HDP9uHSxXx+0ge?=
 =?us-ascii?Q?G0ayc1ji4X+IwzPGi9BSAFyGAe6MfAuhh1sM3YCpPmtjQE+9N9YNsk/FfJDC?=
 =?us-ascii?Q?lMuFCueqDEfZ6V+hdcLL5G4YEc08anxoE0RfVT4vfFacp7HNPLmp9ozVWvBP?=
 =?us-ascii?Q?B47iboQqzVGob2vPY5JHu5KI/YW5qL2+ibw0hNvcmQa5VizQQHavKjfd8JmW?=
 =?us-ascii?Q?QKQxEmDcPfEhyY3XTbBVo+faY9VAVXuHuSYdQS2ItC7zGrS1no6scVEI52yj?=
 =?us-ascii?Q?fCyTSPyBNM2fP1gTrA+OMYpt4OhbHVFO1qr8Ssk/B1vFyIEv6U/FzOSE40AZ?=
 =?us-ascii?Q?BUfxJ/WHxTErGMOsoKfn9yAzUtszBIZplqGNOoX9Jc792TeAw0z0hPAfarx0?=
 =?us-ascii?Q?BPcThGu1qM12ZyhQ6VT4DAlVZ+nEhh4dFz5KxlDwEcMNGPxN/m0Qv4nEHmX1?=
 =?us-ascii?Q?AuhFD4VYZT1/8VwdLNtzxuCv0v6zw+doKiF9ObQVva8CUL81oMJT+WJNIy+o?=
 =?us-ascii?Q?JN/4k8BKBRLSs4EeNTCcR7aC7XV8L93S92iN4abL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18aeff7-7219-44fa-3b55-08db4274c3aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 14:29:06.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KE7WDC3AX27SXFhra1KKY/wizhE08moPeEh1XakXAkAI/2ZOLVt86B6RxOMoEcmrkWSqwJW35IHc9sgV88SUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
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

> Subject: [PATCH] RDMA/irdma: Drop spurious WQ_UNBOUND from
> alloc_ordered_workqueue() call
>=20
> Workqueue is in the process of cleaning up the distinction between unboun=
d
> workqueues w/ @nr_active=3D=3D1 and ordered workqueues. Explicit
> WQ_UNBOUND isn't needed for alloc_ordered_workqueue() and will trigger a
> warning in the future. Let's remove it. This doesn't cause any functional
> changes.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  drivers/infiniband/hw/irdma/hw.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> --- a/drivers/infiniband/hw/irdma/hw.c
> +++ b/drivers/infiniband/hw/irdma/hw.c
> @@ -1901,8 +1901,8 @@ int irdma_ctrl_init_hw(struct irdma_pci_
>  			break;
>  		rf->init_state =3D CEQ0_CREATED;
>  		/* Handles processing of CQP completions */
> -		rf->cqp_cmpl_wq =3D alloc_ordered_workqueue("cqp_cmpl_wq",
> -						WQ_HIGHPRI |
> WQ_UNBOUND);
> +		rf->cqp_cmpl_wq =3D
> +			alloc_ordered_workqueue("cqp_cmpl_wq",
> WQ_HIGHPRI);
>  		if (!rf->cqp_cmpl_wq) {
>  			status =3D -ENOMEM;
>  			break;

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
