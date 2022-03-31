Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79754EDB00
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Mar 2022 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbiCaOAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Mar 2022 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiCaOAP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 31 Mar 2022 10:00:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2835624F;
        Thu, 31 Mar 2022 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648735105; x=1680271105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iNrU9PF1pwDTiOdHubNwxYbf9ITbSPivx1uf6MLryFg=;
  b=JseYcvc+x/2s7pqbnwZlkdEmZ2yRPs25GrXxUdIG+09jmu9ehTSC+urj
   wSxh6gY6ZO5jdDwezqkZMwbzmlqOErFH65GXdZUQkw+jv+t4kL43j2zr6
   wvCmokJtLnPJmaYsBteRiUeD+2ghwaSsruj/5hbPO0R3JmcSVj5J7YT7b
   /QOxMvftIT1KmuJzemrLdO+JNskhUiVArVpF1kwhTXsVAxaSYzodxtF22
   pj0AFCBKGhA8H42NZsYzksXWILSx67fI0uwze8woDLKklZzh4uAR+iT+C
   fFtJ6fdpBC9az6YlFGiTi/omC3JQcqD2qIX218aye4/IJ7xg6w290xj6p
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="284762333"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="284762333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 06:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="566503951"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2022 06:58:25 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 06:58:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 06:58:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 06:58:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXM9mSQZJEwISQEpLxGcFvwUik1PxMX2KRZhNFRGh3nA6zJI9p4WGdolP7U1ty71SLYi0QjxnEd7bvx/wIbHggMgrFtJzLuZh0g2IVWtDHktdlS8wdxF7IrZIfICW+w5hEYbSHZZ7jgCeQedFmTB65d+574p3Svay73P2Vpvk9g0hmijohugEQweq7IXkLTL99hnz8AwUoQjh2u0rw3w41BL7UQGgrY9SNWnh27nF7oFYM/joAhy12FfY+vnlMlW9WnOPvGyrPy+VBqcxWNXCL3XcsbK2KfMlK8v28N2awp4Gcj6RswAk4O9PDbnhZtZvTDQHRv16PDw2WdwaA19Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnLl6JNqLoT/qRsciQ3jhoojziG14iMEx8fhEWgViQI=;
 b=XsUPCvnoPYI+hxsOAPwjguht9dOMRoloCVIca1eH3m7/K7aPKBy7O7XtqybIL//xY1wMu9xmylQ/7vUl9c5mOJdySXTWtb6RAjD9mG4/E4kDv6h9vR9IBRjOo/gLeufzAn6nhNITGxVZ3bqEeeeM4aveyjpSV0GEM1d3267WmplDByXqfui6320W7M7fxhlSiitqBP3HCE0DNbgEn+D8R1SMZTwlgjmGvf4UdTcxspf2hP68YX9wWJSQQuC0KAaqjCe0PCzb/peS+lJypWGicIseYWgYtGLk2i52CQgQZe6IWlV4ElBT0JL5AQ2E5HRQXg/OnmFoRhYoEtngFAiH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 13:58:23 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::ac0c:4806:934a:636c]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::ac0c:4806:934a:636c%6]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 13:58:23 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        "open list:INTEL ETHERNET PROTOCOL DRIVER FOR RDMA" 
        <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "zhengkui_guo@outlook.com" <zhengkui_guo@outlook.com>
Subject: RE: [PATCH linux-next v2] RDMA: simplify if-if to if-else
Thread-Topic: [PATCH linux-next v2] RDMA: simplify if-if to if-else
Thread-Index: AQHYRQAbWucjaPbV4EKnnrxh7RWX7KzZhJtA
Date:   Thu, 31 Mar 2022 13:58:22 +0000
Message-ID: <MWHPR11MB0029F1FA6EB020D5DD279194E9E19@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <YkVu3vqjIPFRSGtM@unreal>
 <20220331130525.14750-1-guozhengkui@vivo.com>
In-Reply-To: <20220331130525.14750-1-guozhengkui@vivo.com>
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
x-ms-office365-filtering-correlation-id: d2628f43-36de-4222-4b72-08da131e8529
x-ms-traffictypediagnostic: BN9PR11MB5545:EE_
x-microsoft-antispam-prvs: <BN9PR11MB5545D6877BF53F9A7150F018E9E19@BN9PR11MB5545.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sEadfB+VReRr26YYRYdDOI+A04g/YOBZyrUwFz5QazSl0pPcy/CGQ0oOmRooqt93q9JHgw0FEZ/eLPr4kUnMRgnW9bzlgonRU376KpQhPEhcqwduHKoVlSk/LXeF4l3jXCyINhJcrmKeytrbXENIqnX5PIdIl7bZGa5pcCBvD4zUFhpuzT1LjV5bcnRuN/MXJRqZmF5MmLg5JhXNa8iYrcnnnbgGA/OY6HuVEfqAQAp0cC7d0uGTvQabAzLyy2x+LB7Ys1HtoGvQ5ESaERnWwmyp0BxLnFMYCTSYzS4Gv6ZkGa2jaTJrHTBLvdphPKQZAgvtH8npU0yZN2YYG8rpLyhGCAuL4fgVdqFsggFTf5aaO4cj7yH0yHHK7GqfM+om0vg+PacOO9p3jKSWizO5+p1B+V6eKNLAwFL3DH8K/2H8iU9UD0ATNgTG0eQmH2Bcr14RyJbOspPHPLWGu+nNxuNLQuxGbHrLC3YptGZHxOECmEeCj9gHqMc//kp3Jo9m7lkaNNaew8CC4mqJCrtUREbfwCt55AOn4eDW4anlnjxl0BWnmpkpQeKx8ENVH+G0lKSYwe2gUkFCWr8tvRxcTvhAKdEQlvrSlRWUynWyuW9fswlxLtlxLowtS7WACs/E/MVF3kICVlydd5JQORy6xBscvhuiA0RWk0Deis/zLbPdUcWDJStv/tO5+M69j0OzECjRn1DY3Xs6IVkqlQxa5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(316002)(8936002)(110136005)(55016003)(52536014)(66476007)(66946007)(76116006)(64756008)(66446008)(66556008)(4326008)(122000001)(38100700002)(38070700005)(86362001)(33656002)(8676002)(82960400001)(508600001)(71200400001)(186003)(26005)(9686003)(7696005)(6506007)(2906002)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c9QgO2qHmH1RzKfq3VZBNnhfBG31Tr0PSrHMwiDacF8oTBfo9qoEta3rGDdB?=
 =?us-ascii?Q?Ao7jiTiAu0AnrPT5TzkGlN7hABf6/G05J4Imi55ZvJ1PjqHicply7uSlwWmG?=
 =?us-ascii?Q?ZjgNTiMqzaZa1a41REOyh1X12DC8fSxEWnDEyxGSr11jx6oLLcuxNPTevAnc?=
 =?us-ascii?Q?kxh8fzHagKZ9xfEcV7G9P68CeY/Xynv6QSKDyXSenenKk/EPEi21x37UDd3E?=
 =?us-ascii?Q?8ZQ1UoqdUgUDEQTZ6cr6qrewzW+h/p2XYSlU2kir+R3WL9ZB6nlA2L6YKkdL?=
 =?us-ascii?Q?J6FzFKQ2OlxO/8ivOD2cqIVAy4xillDPQvXAMjjK99wyjPbSQ5Mcc/aFtxn+?=
 =?us-ascii?Q?tBhrCyiFHSHzipsrqzreldyWmYFFy8IILiDRT7b0JqBLRnLIuLpr5n0HnyiW?=
 =?us-ascii?Q?N1vpTDLWNUHZHDJCjDJ9Q4LhzH5Z2C5TjVO/nimi7VAugIxvoJjtAx5gjLRq?=
 =?us-ascii?Q?0f+HD0l8PnqGaXUJRPXnxrtyLAXMS6No2IgO0grjVopE89cU2EwsLQhPXJ9X?=
 =?us-ascii?Q?3Hg+EvRWjyTUix/eCuh8z7i7km9VrzzhdlSLObqJGvTcwHYyWQrOOLAaTNdZ?=
 =?us-ascii?Q?EjNoImnBNN9/3kyN6e/UoO/JrxZVx4Zt5RgsvGag64Oee+QOXrfn9syxNRwJ?=
 =?us-ascii?Q?B3T/4uE/uOoLqbESVNCZt/d3DAGCSGzR4PmX/fvcxd1huWRWGcoiRYg9RWmC?=
 =?us-ascii?Q?KAEod4exW2HpefWi02mrGNvXdc2T8o2J2gpKaST2tKuO4UMUmRs8trnGHH0b?=
 =?us-ascii?Q?VFFg44Q3HrPVKr8xM+ss8d5iVWrUtOBOrU1GtjWKHQ7HufWeudzyNwrjMxdI?=
 =?us-ascii?Q?YapVfNN+bVAtjXNPbDnsHPQs/iSpDzTlXi214gkWgS/S0Lqpz9BSny/NylUZ?=
 =?us-ascii?Q?2bSt+zIT08VTpeZ6LGzJFziI+ZR+bFsxirk1wK50bg6ikLjSfT04Pp6SCDdO?=
 =?us-ascii?Q?756nRS4crTEtc57/UY27GXYSuMzKcqOz1xiFBRnJJ+JrJGgxthsO1v/Iqwh1?=
 =?us-ascii?Q?bPs3GoKCiU/HDrgXk3uI/RMkB277grDQp0yTaHnMMbssYZx/9UpOhdIWU8r5?=
 =?us-ascii?Q?YxiKeLotevKWpBMkZzMVnp9EprXMB3oidVk8yHEquD/a67vvQ24bCvgX8ZhY?=
 =?us-ascii?Q?LpOJtRix0bhZMxNOLMU9RoWA13dGFRkpgEHvBny63zk6FGZT6lccp3oQc0cR?=
 =?us-ascii?Q?uA/7dfqrMBHMOJZh2LIBq17tLn/jmrKDvNVRbraiUZrh7JQRu8aZPak2sv4c?=
 =?us-ascii?Q?CmfHkfl44lnMVuaCj4AC5NdNc6hhDxpOSBH08prx4zhhPyDAqsnN8TaAcJKy?=
 =?us-ascii?Q?rkAxXUH8mTeNCSwvMQGVbaRteP7hmHBBO9BqynlWyChbbn7iVIDTHpBh8OKw?=
 =?us-ascii?Q?M68twlK6U+riupD/lig+4X7aDLS/4OB80stT1cxAJ2Yk6z7Z57oEWQ1sdAeQ?=
 =?us-ascii?Q?lvQolBm9Qt3qgIGURPIfKZ4qd06k8QziuPmLt2+/wnRwol5IP4vXkn0vomJ5?=
 =?us-ascii?Q?WUI/lj3zujZvEEE44zHNelF5KcedoT/eQKWoTJs+GKPBF2zXjVrMewZxK0CM?=
 =?us-ascii?Q?Ms6AMWsRIUI6we8MoPXArHSRB3TDhdDIrT4DjeLiN6O+oQxcYZbx5q6Gozpk?=
 =?us-ascii?Q?8NLlCgZhO0QvdY18yrfxG5n3U3SnVfAcKC4ql33L8CKSufFCs/9+RA926WaW?=
 =?us-ascii?Q?E0WadSCmfqrvR7kxhAfzvHJt+P1SHcMY7loIFBvdquZL3fNKgONoIobeRJn1?=
 =?us-ascii?Q?ZBVfhPqU3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2628f43-36de-4222-4b72-08da131e8529
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 13:58:22.9431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WR1N+vVcRVjEDM+FDgG1/1wf8oLhwSzjOqxbOWhgBw7eFO3kjVVq8OfHxyKDRHlpIoLJ4agic31PGADNigvRjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH linux-next v2] RDMA: simplify if-if to if-else
>=20
> Replace `if (!ret)` with `else` for simplification and fix the unbalanced=
 curly
> brackets.
>=20
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/infiniband/hw/irdma/puda.c |  8 ++++----

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
