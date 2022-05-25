Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416EA534709
	for <lists+linux-rdma@lfdr.de>; Thu, 26 May 2022 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiEYXlM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 May 2022 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbiEYXlL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 May 2022 19:41:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF770281;
        Wed, 25 May 2022 16:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653522070; x=1685058070;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h6SzYjamydZl3JDzURyPzF9etRmY8vV08I78KvWRTYg=;
  b=fyQ9XdWJJa9BFY9kfV/IMXnY+I4igWSeGOn2FSTZ5w/Pkcm/kA5ExX6o
   C6onaL0psQy8yRh0tmchJT1nBrVkAdi289RBH0mxaGAdzKmBFX0CLTvas
   KE/G+H809EQAGvhGKwK7MeFHI6T3Fg9FB55byE5ljA/vWFEsSkTT/51TJ
   nv0+bumSaazlPmmhB3FlQ0jFe44vmrvbp54z9N9Y/1kL1czEV9308lLzX
   eGB2fTZUlrlY0uPd6DrdiSm56vDa5f6MQ4/QZJn2mts3qRY9UbeLhTe7N
   RJDk7m2NPYwbEBsYD/8xR8VuorQBp5Ka4ZZBPnXOFzOlBfbtWUNxz97QH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273689248"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="273689248"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 16:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="559910409"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 25 May 2022 16:41:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 16:41:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 25 May 2022 16:41:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 25 May 2022 16:41:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9MCqzX0qb5XjNbGP1Po7npjcym3bq0ADMWeHGNEtQHl2MYm5Khs6DDqcnGdf4T16zVjGYQu12/uPOlFFNXEbKA1isgjGyvErUEr6/e5ihM62pAEm8ZJscLDc54Upmth8qmxmusZ7CL4e+98fuLnTRnGewXLfKaVVkwcPuVGKmQskDUChegXejrOWyGGxA03/mjUET/jJ3tm180LT6IIksrgEg0uFHc2zrBiYoYmEUeUkNoT57JwPVN7IR4QDxUSOcSGUf/5QIa+x1UxK3loMNaeUCI3g4cQsS+Pr7WICDp+FY47j+kYDJmdstr/cO4iwqsz5s1hc6SDhl90d3dJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UtvgaJ4Poe55GTYrI5CNTe3vi1nGdTqOymXSweSlxYY=;
 b=kEZl+h9+vM8l135r6Lr4EgD6LkKtld8UGbreIYmuTIFk48zFpRqNYrZKCxjkoEM6SF+OIfCq1xwr9dTwOkMIbsj/4OcMT1ZoNjQDovI2ttOtEEPfz8M6iCS04FBPDoQtim1ArBKuWryY9kXp1O5LSi2kdIFsAhqQHXHGoqeCHbtRcWoTHaiqgPPPbzZztthJgCbGwmruLp2Mk1QPNQosoJRMzyF3zCsuXWM3V5Pvc/diWR6Oc0PDvAnls0E1yX4RzNHj/9gyukykrz+jmk9yVf6UtDwlNhQUm56kOLUeoSHGAMaTqhAkE6+TWbW8bx3BqzDqcbyM6sungKhvspC4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM4PR11MB5357.namprd11.prod.outlook.com (2603:10b6:5:394::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Wed, 25 May
 2022 23:41:02 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::4c1c:f0a6:2e85:4df2%7]) with mapi id 15.20.5273.022; Wed, 25 May 2022
 23:41:02 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Topic: [PATCH] RDMA/irdma: Initialize struct members in
 irdma_reg_user_mr()
Thread-Index: AQHYb4Jn++uEhOvAVkqr/YS58HKDLK0uKOsAgAAQZlCAAaiugIAAXlgg
Date:   Wed, 25 May 2022 23:41:02 +0000
Message-ID: <MWHPR11MB0029BF8B08E8AC384157FB5CE9D69@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <Yoz4iXtRJ8jw6IeD@kili> <20220524153600.GB2661880@ziepe.ca>
 <MWHPR11MB0029F37D40D9D4A993F8F549E9D79@MWHPR11MB0029.namprd11.prod.outlook.com>
 <20220525175441.GD2661880@ziepe.ca>
In-Reply-To: <20220525175441.GD2661880@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20f98219-a384-4928-b853-08da3ea80744
x-ms-traffictypediagnostic: DM4PR11MB5357:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5357E2B0135D8AD75AFACC36E9D69@DM4PR11MB5357.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BSWjATNgDf+RsdqcTNppwte9cXV4tDZXcRWhLj/L57j9RG5Zx3dYW8/2illvIYnhZYVXc0mtbGEfJ7ccDm73Anzs76n+0/oKog9aw9vo2XiDsioIgfbySibb8YD8bBwo+Ce9lCm8ZTPuYsFR5rMr9dUsIhiuvu/8u4LWiY43yo3yk1HLFLkrinCg+dvflWnjA03gY98BpuZoEeyQ2GWoZuqoQk62TY/KAKZTTgeNMeJf24kbv6tNEGqzIMRjYuGAxBlmokMV5MQoDYZ/E/TKZYWiXzMHG1hZowfU9QW/+CvbQSodMoNRhAQHHQGrT8eXx0WBvg3yhxFHBHF3iWsBHbr5snYx703QpxDBUc4jAOI+lYWdZIxc5C7WAbK0KYcyRbDueGtCfyQrcO/C9TLzSSW45r1h+QyqJ8yFa+f+PfVECOr+IXrMgOOU8EgjacxpGgaGQVHjkqfcgGTnYhk/1ybl6ZsHcMDy58N1qwXWYSuzmeDdIOytAgzpPgpmF4u0L9nA4c+cNUHcLQqSVinVOvufaUHKUGgo54+2hoN2kTyQj/EKbPW4O9jdCBQMLGmy+rgfBhKSbKUDi8oXFe8CulHhBaALz4CT8PpCzHkgYNoqdvfVLLhY0/MKmD6MVRBKsziMx/OH3vmJCnLf2bs5zMdMZB0eilZ+QKyK/XLZ2a3O0AcAqbxrq6notER0xfjnu6HSq2v760CJ8L4aqsYFMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(122000001)(26005)(66476007)(66946007)(76116006)(55016003)(6916009)(54906003)(8676002)(64756008)(66556008)(186003)(4326008)(66446008)(33656002)(9686003)(71200400001)(38100700002)(38070700005)(52536014)(8936002)(86362001)(5660300002)(508600001)(82960400001)(2906002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bg0Db24KBcG4O2lPZ8AboL2lqoJ6kEkBFXZoA6XsymCS18EkpSnFWcMIEv84?=
 =?us-ascii?Q?WqdQcf6Wrzj2+aZdBWYp1WdsVvQ119jsasGMHDAy7ScGB+eiM80+r3T6yMZF?=
 =?us-ascii?Q?Rwm1njz7sptBFIfI7mZkebVZymJ83n8o+nrAbXglaAUKdjAjRGIIf3+NdEFy?=
 =?us-ascii?Q?MN/KjCiEkd2jYjyyT5RkpxzhJUWyLon9IgyXZTlaCO/3aCwkrA2axlPEgw98?=
 =?us-ascii?Q?5u9RRgHE0x8xuVehIR2lT5S5ialFGm/4HmNFM8CNTOQ8EJSXluHkCl+ISZe0?=
 =?us-ascii?Q?sJJn/fFnDCn+6aLTdfGp+7lNwfuv5yar+4w/GwQmQlxN1uUicmRr9meTqGKr?=
 =?us-ascii?Q?q6G42ABcFe3ekgstdrsnqJM1HLQ0URrDfoaz29cMNm+VJrelb2fI5yZYVpYF?=
 =?us-ascii?Q?BzWEVr7GThYlOFhx3vgTVIxMgwDsE3sZntWi+821clKlx/+yHahf1sPgqUMN?=
 =?us-ascii?Q?QO0AgqGXBAMaZ2CfEgImHragxNz4DAlmDzmRUABmYfbtohGuHv26VKzFWKPh?=
 =?us-ascii?Q?Kt1utAm4jJnBuqIwXNoex7Ml/EVpXfqA5p04vAHsYWslTIrvusm2BlDgcicz?=
 =?us-ascii?Q?2RfnMDnlel2BJmgilV0IDfmhBumseitSBC+sx2/zDyVqMKbOL0SnH7lfvMXb?=
 =?us-ascii?Q?v30EE05EVyPB2JMMn0+JRgUgR29B9B6EbOHl7u1e74sUdJLr8mvoZvAnNayg?=
 =?us-ascii?Q?eO/1H1WKyCCJWsNDlHNO1gcxO1OKUBU26Y4K61P7CtKV5WQw0XhpIg9A4qid?=
 =?us-ascii?Q?c3EGQyJqR2wZkwpGwR9YdLtDfpIV1Fwb6cNe9RF8yhqJolBO+cWF+WCfiAks?=
 =?us-ascii?Q?CmV5wmlT0xTbMg8cl6KDbQESUHsbK4MRrihN5NOYIlYeLXxbhJ45o4z/8HHW?=
 =?us-ascii?Q?ff4xTDb5oV7sdzR3pMXGXJM/6+zpyGDEkVMnPJDPB/fleny99USrutgphiDh?=
 =?us-ascii?Q?u7vkgqANZd384tmiJUw3c1bMPFWlIMJPaWCWv/2vMefixr+xmhdZHT5/ftgY?=
 =?us-ascii?Q?lyo++/AQIeiuRRBrEx0aQo3HqJs1j3zmsIkDLu8iJZBYPUHy8+x/wtdlVO2l?=
 =?us-ascii?Q?OgHY+OOMHNi1WQpBbYuu5lPah8dqcrwaHyQ4UhE/45WgVJwkV8XAf6W6bW9X?=
 =?us-ascii?Q?MsAl6r3pBWDMKd/9luV/S/5/QGvQx9S5f6Jnzj+sDlUtsPuS9xyH7sbql9n2?=
 =?us-ascii?Q?m579l4vCARa1+X5wFcQmYgRNcO6hwuerebW1qJS7p2b3PF3QBPF+0xeqhZYh?=
 =?us-ascii?Q?Ka6BPkCxSm3u2RXCkw2IS5kHb4GtxNjUsSunZfN4mrO3QPJeCNi3jv7BA7Ua?=
 =?us-ascii?Q?rrO7eonpPo0Ha2dJcKL7A5QOJ0IcI1mENemhOqlQYJ0Z7BvWGvonvnLlPzxI?=
 =?us-ascii?Q?VExPFBNChQ0RdBiKQGNRluNamjS82cK12TcMC/tAxasBiJ5pXX1o9Aaw9rCx?=
 =?us-ascii?Q?Sfi31OXncRFkNq3LZOVZZtn0bL82r17MJFJTbj9k/em8+M8v8QtP66tARsDn?=
 =?us-ascii?Q?w0qVqcgXoxBGNekFEmPE5kwpCiAkXBkKN+SyHnbtGN6jnYKLm9kIJK40jkW6?=
 =?us-ascii?Q?nLrvpaO84f0hpVjIy25ckb13+0qX+N7LUlKFslmSOGNVRzgKlZk6Dg2L8LUA?=
 =?us-ascii?Q?bYKApWTdEUzlwsqISGQMdOO/XI9qXKlB4qTPyZryiomre4CTpWqs+QWwiLbW?=
 =?us-ascii?Q?/IcdxloXw+sWlsAGNx+urd4h1za/sAjmqbukDtiZytI+7lFjW31KvXOWnozI?=
 =?us-ascii?Q?4NqhL0NDzQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f98219-a384-4928-b853-08da3ea80744
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 23:41:02.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A26iTkX5JXecZkAIuiqNvrFOPP4MZ/wh14GOviJ75m8O/gFVS58QKPS1HzzhmWjKFBkqge/xxzM35r8FBa0N0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5357
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: Re: [PATCH] RDMA/irdma: Initialize struct members in
> irdma_reg_user_mr()
>=20
> On Tue, May 24, 2022 at 04:53:46PM +0000, Saleem, Shiraz wrote:
> > > Subject: Re: [PATCH] RDMA/irdma: Initialize struct members in
> > > irdma_reg_user_mr()
> > >
> > > On Tue, May 24, 2022 at 06:23:53PM +0300, Dan Carpenter wrote:
> > > > The ib_copy_from_udata() function does not always initialize the
> > > > whole struct.  It depends on the value of udata->inlen.  So
> > > > initialize it to zero at the start.
> > > >
> > > > Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb
> > > > APIs")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com> What I
> > > > know is that RDMA takes fast paths very seriously.
> > > >
> > > > This is probably a fast path so you may want to implement a
> > > > different solution.  If you want to do something else then, just
> > > > feel free to do that and give me a Reported-by tag.
> > >
> > > This isn't fast path..
> > >
> > > But the bug here is not validating inlen properly and should be
> > > fixed there, not by zero-initing and allowing userspace to pass in an=
 invalid
> inlen..
> > >
> > Hi Jason -
> >
> > So something like this is appropriate?
>=20
> Yes
>=20
Ok. Thanks. It seems we have other places in irdma which should be fixed th=
is way too. I will send a fix.

Shiraz
