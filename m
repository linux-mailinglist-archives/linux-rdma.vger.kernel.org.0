Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB215721BF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiGLR3I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiGLR3D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 13:29:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8FCBE6AD;
        Tue, 12 Jul 2022 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657646941; x=1689182941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OcB0xIBRkAQFpfQVsAbsXx+O65zBZwMYuAJlEMDqTJo=;
  b=JaNCmKie7e1DHp2AR7jQ1j629TsR266laMxEU92r1J9a8BRK1PLq6Xz5
   NXmuYypgtdoTfU3R7y0lTMRpfdbIFu7LZnBzcsaFqB/evfRIrH2324m3I
   VeBz+SjdOpV3+j7PKUiARUaRnRKdedF2f5GmXPOwGKQoChm7gSZSSpKCJ
   qYyGfZCdqAB5hDOBZBA4HEmjlG8cXHW04Q0ei1YFLhpbQt4Iq+c0BUcZ5
   PORks4B33T2DOWVY6Jl1sNOvFxjkoHn0Csrl2OFeutRPPpYqSg+CvXkap
   plcBY0nGUeoNEQLJzO4vfbsVg0FCSSHMeJ6aD6XaYbp6afw6WuqE5jf60
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="348972131"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="348972131"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 10:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="698097688"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2022 10:29:01 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Jul 2022 10:29:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Jul 2022 10:29:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Jul 2022 10:29:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkLbHi0w4V7LqnvxYZbNtxeoXKk0woklSrTkTmgMv3wv8y7034QwzHiTcifWh4ny3fKAhk2KmdSwCpcU9HHWl7noxEmzeqB9TuYDSmIYFOe7JoEhlxScRwHYlRtnjM1C14utUbFBUZ+L64FnhP7IPdKCwmx8D89CYWAI+nRkPhBpbjQSfsgJi9BIdP7t1LN4P0d5gpqa3PYNcJoznAwn4PDXOp2Kqi5xtTiTL4eAmSOJrMGZWEX5KB466p73CnfoKPCoUNbOEecOUEtnBXeN4+YvCeupSVfmAw1IR25+dDHiGvxVeHpvK9nQ3N8SsHynsFgkWmkjiShtsC17En1JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozyLHbtB1hd4/cBzcsh8UTTSu0hizV6458kw0nx8cEU=;
 b=b3TH0uiJYK70X8ooUoP56pLJI1J41xlOF3Gj/m+62ushN3wZiGN4sXGpMxfIgsGZkYB5f1B+tXiuPvqtARBN91g+Vh/4QSjYiCyamrOY04aAQKaqkl0x41Qod7JFWEk1O96egtwR3Yiqu8hNgTqztuxbeJGsYNHh+bttQSzR8Ey3V78aX0eRDGtisb2BhKRCKPof7bQj9WO6cfh8eOfXqCgHDunbh6vamDOcELw4WHsRTgdwnxF2gw1QHdckJCQPWDLqbvxNtz8aBaxjfYMm1i0Kweq4OiD2Qp0RnQZrJMFr85llMJPkKPTRMedeeG+KeSeWbngQq/yas/cbmekaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 17:28:59 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::158c:bf96:aa84:aff6]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::158c:bf96:aa84:aff6%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 17:28:59 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Use the bitmap API to allocate bitmaps
Thread-Topic: [PATCH] RDMA/irdma: Use the bitmap API to allocate bitmaps
Thread-Index: AQHYlVt77REEJ3mifUW85Sv/R+ZtIq1621cw
Date:   Tue, 12 Jul 2022 17:28:58 +0000
Message-ID: <MWHPR11MB0029903FD82CEAA01543F90EE9869@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <1f671b1af5881723ee265a0a12809c92950e58aa.1657567269.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <1f671b1af5881723ee265a0a12809c92950e58aa.1657567269.git.christophe.jaillet@wanadoo.fr>
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
x-ms-office365-filtering-correlation-id: 4d6daa8e-23fc-4299-64fe-08da642c0152
x-ms-traffictypediagnostic: PH0PR11MB5626:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqcYcekHFu9AZAlYiMHoEMnjBTqeApVCI2XcpG6ix6fUAjW12bsAmQ/KAZ5SxTy0Z1uxnqMzZqKkzJkLFtQ8X1Gk9AfqiRt3E01IWiK5BGS5rBeQcde76JViEtsCBonIaqXLIVU+/ad4FMQYe6mP2BnCJOP0SAUY5oeggpZToTrhdfh9e8h4KO8Ovgf9I6BLbxXJPviRLfA6wz7yBbSjqFQ8vd8exHQmsu8DY+ojjMT6CPlQYx2vfXVvJNI/uY6xnJwFJ0z6lSrkYPQiJCtNytJE34wVujAZRBojBebkizLrXyvhpbtfoF+JU7Y7tJVrOMY8iIb6zliNxwaQUXZsrkiID4gBArqbaBAiuyF+OLEwkfp2Bn9fNW9F6Q4nu7OropJbpDP3moD28ZOOIeCRfMfB/fCM7u90xsBbb5yBVzGleJ7USlAB0++G7uPKsXJ++diIcZfS1hL/DdKHvIjda+OwmG/TmwWaV9NfuX6a6ih83Mg547GDfRI2jCXYxzKB5Of+/mLhd94DufSVuDm/BiMsnt8yW1FMRlg+kRjSYGV+bkF7kirRgnlHzky4H2jyNbB9NJk5guO3GVU6qWe8z+e0AjuBBj3h0mTKVlHYmORBdbxY4qe+AE3cgN48ewNVMhd1OHmXpW1QYTK2/Sdty80oTdBpP0Fs8oq05rY7yhXXXhziusTXke5uBhpSxdIE+30ZjKFzj7sAJT3HOz3ouW/gRi6Vxi5TTHYfsvJXnbpOj05lTc0pFJQeHUQD1iww1CLo6A8Kvvc/qanEngXuj3qrAEjSgG/age92Id1m9QOvK68Pwgbb5sJ6Z/apKEfJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(366004)(346002)(396003)(8676002)(38100700002)(9686003)(83380400001)(55016003)(66556008)(186003)(122000001)(54906003)(5660300002)(76116006)(71200400001)(64756008)(110136005)(66476007)(4326008)(66446008)(82960400001)(478600001)(26005)(52536014)(2906002)(41300700001)(38070700005)(86362001)(7696005)(66946007)(8936002)(6506007)(316002)(33656002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SyN3Pj9aPdf0wv/eNQwLmc/R1f4ChSiuDZnASJh1SGQa1GnTmVlfN/rlH5DH?=
 =?us-ascii?Q?PEtQqaDezm3DuCuTOtIwxahQ/KGMFzB5wOYjytrOiVfT5sJacsaScA3oyBvC?=
 =?us-ascii?Q?Jh/VhFGI6Y1QcTfcXATNsgx7ZANvd2LLiky45hbxmU64MJNH6x8YIAuRC+k5?=
 =?us-ascii?Q?MJIW2zkizcUrVnz08NUoMKFXhEhlVX00DV5LQgs1UvjfD5e2DGPgOGi8TyRd?=
 =?us-ascii?Q?u7QOvuNsknQKb/8EU3p+79mPiiXknnwKZPjpIyEFRLJ/h9g3KvYiixdu1QhD?=
 =?us-ascii?Q?OBfEa5i0lAnrCtTA9SfXwgkabPtnFhxJa6wKPxfZJSzWzbguRAe3gj770rYk?=
 =?us-ascii?Q?qUarPy+/dO/pNmCmWJcImV3n89ZW5DoMXZC5CpcR7jOL8UOmpdHrf4aBQ70g?=
 =?us-ascii?Q?HITTbrzJnJqfi2V31xZsOCFgPb5dcGOR0UKXdehFCdvsQFSCCwG2YP1qCUgV?=
 =?us-ascii?Q?tE+5b5WYUV5QBVPScb7HVSMUOM2U+WX92wb7/W+0kCBOX36awTj5y0ljgLR8?=
 =?us-ascii?Q?rxN9MuFtIyV0fPLmUYkYpK6xw/NMiEQrNQdLO2boqtr3eXVTmhrrCOVwHOBw?=
 =?us-ascii?Q?lJP++njSRbb4HACSLnhh2GHyfYYQkIETXsxBw1BtuY4MXc+KhF3gSiIe4yTi?=
 =?us-ascii?Q?mQr3fnRMgZBnSiqn9g0ygzzEcTIuBq5PSo2spfSnmHEYhn2fd82n8RZUmki9?=
 =?us-ascii?Q?+PsG+3hF+p7b0mKnFNCoPvLsToR36p2IV6CEOYw7W9KWFEyXLlAabXqCu18a?=
 =?us-ascii?Q?zLOtrNPWXPb1q0c/RKJMCcMwwh+4GSnYL3jl5UnoI7MvuKqsfPAcEmVP6mOh?=
 =?us-ascii?Q?D4UDzE7l4K0z4LFv/5/OH3JTpqHSjbK8rXT2qYsrfv6r+nd5sQSh/glqggDH?=
 =?us-ascii?Q?OdSAOSz61tF1f7ufCUEV1aNSemoKX+npecTQgrAL/fKE2NWcAKpRjKbX8Nmt?=
 =?us-ascii?Q?LHO1VNJJKmGnzI6X7PbW6zSBlP8pWqZaMkKdtVv/R5vcHG+rvN129DMx6KB5?=
 =?us-ascii?Q?GAokYShqLvEd6iq+HPEHeWWwJZNSzpuDz/pWkkvCeby5Ib0URCGUCHLP07D3?=
 =?us-ascii?Q?jghA6gxa66cH2GtFM53uSv2/bxSD4o6+9H1V4KrxBTEuF8ZFMMqI20zvoXHE?=
 =?us-ascii?Q?Cmi9tLETaeIEkvJk/vsY/yzZ+JD1rdIc3boYNEs7ejxImegjmOh0GN5Eps7o?=
 =?us-ascii?Q?arRbrlHf8bZspVdxQQUcJtXGjjRZpdSVumzyKJz50TxBnXaWlCnS3G87VzSG?=
 =?us-ascii?Q?6F+hi/Td9yzQZ3QwZRSy6IHLFQT+0TGyPGcs1/4jYQNyk+mXCe5rb5f8VQh1?=
 =?us-ascii?Q?mDl0BjyDU0LMEtyr5xScNnlgCj6i3LGKoNt69mBKizzgo4efP14lV2Ksp1f/?=
 =?us-ascii?Q?DVNixcvcZlztw1F4E9CsMLnF8WfPGvxbBJWPBWEq5uUy4jgYUPwH/BQElhq1?=
 =?us-ascii?Q?Lm9hq7RM+IMMzgkY5yHekaramMn/D5cx1dT6m6qyfBqlZN5M0j+MhaE2lTA5?=
 =?us-ascii?Q?c4I6aXSidpEGPbAI666YkiVs1DnFg6sbV8Z/yjgpLhlr78WNeuNZAZRian/O?=
 =?us-ascii?Q?kZhX3RrdKlCYdMZTA9WVFD4KFaDCdisflVFHRK4l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6daa8e-23fc-4299-64fe-08da642c0152
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 17:28:58.9549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCKm2gELYxUFCwloHfQBxseFktJnWagolz94aNZqgxQewYr9iUGegICZVb14Wu74MEQ7DGiI2DgXboE+jpmtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/irdma: Use the bitmap API to allocate bitmaps
>=20
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
>=20
> It is less verbose and it improves the semantic.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/hw.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Looks ok.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>

