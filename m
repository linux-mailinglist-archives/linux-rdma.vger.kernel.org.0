Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0591663809
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jan 2023 05:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjAJEOK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 23:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjAJEOF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 23:14:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED4FDF36
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 20:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673324044; x=1704860044;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y0ukyPCP16ekM9/3VxQROQRe4VziTyKcEJ+Nt9kFgRY=;
  b=kkzw+kqpa5Z1bCKA1mTce+Zcc8yDhJrlSTqCULZJIL7KKjMCyAueXkSe
   7CQ2MsMkDbEa3nWABhLmyX4/giM6f5mN4pkifc5XsrWB+wb6iIxpprGBP
   RMgBnKLhGrwhfO4IsPPxpGKzOihZiG1YqbCr0d4PCPidcrJ2iF0N/AVjN
   WHLF4gcwGZPJ9ZYm4/lldM8VGRNG3q+TxdBRC5NouRmfBETsjwdwY+uC3
   f2+c/vvMsX8HuKnvDlC0mLiVlaME1Tsfrv7yavgGTsHMyVcDIoYTcEO+/
   Buz9u6AI9dt+BWnL8+C80dtVczqvKp2+YOYV8aAUOl0+hn2hkPPjQR2zg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="306569883"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="306569883"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 20:14:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="830855908"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="830855908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2023 20:14:03 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 20:14:03 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 9 Jan 2023 20:14:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 9 Jan 2023 20:14:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGUh5g0r4qU/e46W3LNrFC1n3Bwh7UIAf9qPr9XufLFf6BCaWDimm7jruzY+O8Yi+0Z35LGDOg+ffJ3FeJFrreg1RuVbTT4EW3nikriLoZOv6P4YR9a+JgR3J6QIDL/nDScrBIiHLqxAj4IIEj5tn+81ennmo3FIidvKqTmFjyKfTp6GC2u9H0p6fh1ZiWrTobpXrSPMApPNVUbtBUatTtIN5XQY6g9r6/QGvvKSa7wHPnMpmUsZJxm6DahSQXPWp5z9cxyTf4A2wrHK6nseZt+Ciim3PrAiaPIcWohq53ZgA6HwQLDvVLkgFGji4GK7Ayp2PEzTTCXvBZZiSWTg7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UKCruQ+npDH/lLgm5hk4eheBC+JgVfH2xhwTdngPC0=;
 b=g4ePCUh9Qx+x85/MqTNz8yTnbiM0KhNUXf4LyM8C1SUTnG7zK2SdQeM+wsIpeICC1Wqo/CIpm+UleynM8Tghy6SyfLJtOvsqpggsKfswyD0RhyRBo29OGYDZhVKieV3BWmwtcfZRxNvWYw4l7wjlf6v3eG7dF5Jp1uDbiU7Gf0sMZhT2J1V2jsTLUH1keSigDOu6UbdstPsWBFmF/yfn1oUCu2BtUU32Apdk10KuGic9QgjvZVN5gkDMS5xqP0GnuKElzt7wnuYE4aVdJkVnARpZJKABHdR7ZrL8RPEFgFLtsoAt/3CMKAta+1X8WILYNhs1U/ORZv1TOHQ8Ewocvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0029.namprd11.prod.outlook.com (2603:10b6:301:67::25)
 by DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 04:14:01 +0000
Received: from MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55]) by MWHPR11MB0029.namprd11.prod.outlook.com
 ([fe80::61f7:7850:6203:bf55%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 04:14:01 +0000
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "Zhu, Yanjun" <yanjun.zhu@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: RE: [PATCH for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
Thread-Topic: [PATCH for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr
 function
Thread-Index: AQHZI9pHVQYgu4xkIkS0T/krQbPAsq6W0/gQ
Date:   Tue, 10 Jan 2023 04:14:01 +0000
Message-ID: <MWHPR11MB00294ADE32A8EA99F1840D89E9FF9@MWHPR11MB0029.namprd11.prod.outlook.com>
References: <20230109195402.1339737-1-yanjun.zhu@intel.com>
In-Reply-To: <20230109195402.1339737-1-yanjun.zhu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0029:EE_|DM8PR11MB5574:EE_
x-ms-office365-filtering-correlation-id: 8b88aa7e-aadc-4315-15ed-08daf2c11a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szoMlbS/qssO7tZWZP1ebG4FGbxvsnGeQFQAIO1rZTJWSjwu6k1/5C7zWY5RLqPUGOZDuQfrGjGO3ERJbChp2h7+RhX02fuH13t9X2q7A0EbPRkvDiIix2DVq/FJz6bDyiu4Ayt7UX4fVhzllM47ak/Pbk+7Rs95wuNhl8iBSgixOmPz+ipq7MPt9nJD03AXrn5n6rno4swCRhqALk9RtkJQTs1tQ67ntfUYEpFRvv7kLEzlC14P0SDvt0WeZLYnGb5ffyFj5sYN7GCnPhebJHse83qcJP/7CgO49XGSvVdV9NqhFiSmRKOzVXroyiguVTDHnDY2EEOMGc//L/DVguXKESmpbyL6pzAbmANhz9fEgWHDPwk9KRLBkLUzLOyNZM/9quP54y0g1mw1cc5lyH/Ubb11xB5Twk2d0+m04XCY9eNfxUIJq57pfmbIjbyRSAKaK+vs5qdJ6evju6H5wzeEXY966romGIwy5Q1hXa5okBRo8ZfzdEIBYWQmGfu2sI4pMQUATnwm+b4eGC3blF9HpVgiRSPEtGXFE2Q0KUngiTOvcTRmFdI+V75wq4mtBnic6OMkHwcGj7hHQnVWSMeznHsP+y48rvxO0R01GoIdhAKn415boiQkhPZcQuz9czK4JsGsApui3YnqNHH0f2QkuKlA74KKLMch3aRBHA0Sc/7ZAAURzLi9Oz1eaBcMRRULxzLdPdWi2slezZi7iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0029.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(33656002)(5660300002)(71200400001)(316002)(26005)(9686003)(7696005)(186003)(478600001)(41300700001)(110136005)(76116006)(64756008)(66946007)(66476007)(4326008)(66446008)(66556008)(8676002)(52536014)(8936002)(38070700005)(83380400001)(86362001)(55016003)(6506007)(122000001)(38100700002)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AC9MKNOz60X7pc3XBIj88gwRZlKRJ+ar2Sz/GQ6/5bDNOpTJhNNKijAyr614?=
 =?us-ascii?Q?XPWi5H7cHQugGIYxLM4qt5o83vcycHp4wEpmL/vdp+kaYln0jEpty9OVkENm?=
 =?us-ascii?Q?JQx8Kug33OPtWKVpSH2A1VvhcnoyFGxgUeJ7GiJVn3M3tDVYifVp2CwoYqNT?=
 =?us-ascii?Q?yh6LwJ6SGzrW9DsMi6aaUGJSE1EEUF1KwSUlu7QqOhOm0KDHx5fWsBg8sGV4?=
 =?us-ascii?Q?xaujJRJOd7CuhXz+6UF6ljxbVAWalhwYV9LwA9F0WBZHpWF82JIJrLjQuHfD?=
 =?us-ascii?Q?z2ClFocZwoFO6YD4RVwFcc9Bd3+2WlCTGPcGPw+PG+DgXjbp4GWZL9aoNsxo?=
 =?us-ascii?Q?PnWP+t6jJMp2H42Ashqzx0CbzoBncLewvE1wC4sulmBtwcewJr8lpA8QJVAT?=
 =?us-ascii?Q?T8wnzwaUJHpZmuinUuA7b+OBn3N/sJ1qPrX9hqSiZaDxS9ETt8Fum/xAlrQe?=
 =?us-ascii?Q?f8HkQ1j8m6mKfNLmG5YH6gSJAYNDsztKRjeWtKkHFR8QY8PRknbeeB9jWH0w?=
 =?us-ascii?Q?q6xQn7NXSx85NEWQ6M7f1DB9bZKD+6Ykp5gEghxRledfWeGts7s1+Z+VkRNm?=
 =?us-ascii?Q?sNoQnXsbDfQD6GT4839wvBb5RPuzDCpUuOAWD2geRGv9Uq49GHdIrQixkVp7?=
 =?us-ascii?Q?EpO7joezfVHe977BxmFzSi52Tarc59R7ACnItGOA0uxKHV7zzTIp8Dpn475+?=
 =?us-ascii?Q?C5Da+snjX2qtEHuvzwRVY10+H5t/U6G84OTOQtpZjIP7uIk0kLy1ouRftAEh?=
 =?us-ascii?Q?WRYgdbgzTk53fIgEJTDnDoPdEV2WO0/htcU2lM8pM4b599ZuR0sA/SgXJH4R?=
 =?us-ascii?Q?ggSMUF5bVJrr/3lLgrlZB4UVooTO8q0vfzPdq8lSC4qBmnv9hpwQa/mRwWCY?=
 =?us-ascii?Q?bhKenY7DADq55ijMvUkZ+468x1ZyiPegz7G5cIi0+ZhhNek39Lzhk1nrUHaX?=
 =?us-ascii?Q?o8zalXHEWLkQ3b7ixnM3+XJZ6aBPH6qsbTM2q/IiV8uF/7CUpb5GtR360q9w?=
 =?us-ascii?Q?T63EZfm7jmjPeVbWX1vziPOaTvKHpeN+ILNGTqGSSkP8+yBupWuEBqztfsb4?=
 =?us-ascii?Q?/THDkGOTM05K0aRDLAOZfmZTVZNOG+Ln75suRwbeTH3Waa2ijokBQ9lux9SJ?=
 =?us-ascii?Q?agKfEqf3ybW30OMqGrMvNnDU7NI0ovTFBGMqyxDPcnM5ir25SQYpHrweB0IA?=
 =?us-ascii?Q?iMshVkwH6uk6Eq2M9qwd/rGZ/zdTtays1TgfJ6CwE8Zj61yZ4jBuALabatuc?=
 =?us-ascii?Q?QpEyq8mLVkFYdEYN/jxhT054qfdD8320JMwaI77MTAS11PrR4Zpu/KldRrP0?=
 =?us-ascii?Q?9zoSVOEBtx+9n5bhIkE8SXid1KgLbiWUQcEITn/YShwi7f8VfxQ6evklsCNf?=
 =?us-ascii?Q?A8js+JVAc312yRwTUfeQf7eIWzmy4KWCCiaC2l2E7gX0GCslYnqmdJHAvWXq?=
 =?us-ascii?Q?Au0h4fibY89o7XAG/X+JJTfukDIwTAfeb6pKsi4vrTkXqmywMhVT/OjDgtq6?=
 =?us-ascii?Q?r09qOnkxgbeCAtF0InadK0H3vJlnlKT4ss9+k3318iJI2Mz5k2aVpc1eyB3G?=
 =?us-ascii?Q?0o5MGPrkME1z+hfMCuwyKNlV9Lzb6qyrM4yYQ4kn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0029.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b88aa7e-aadc-4315-15ed-08daf2c11a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 04:14:01.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRzKwuzn9pC7GUZuK2zW//wxzjAM1jXWYT7SFuiGGJvcflNf/R7VeunV/Je/eg3F6UXxQiydkV/vNouW1HHK+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next 0/4] RDMA/irdma: Refactor irdma_reg_user_mr func=
tion
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Split the shared source codes into several new functions for future use.
> No bug fix and new feature in this commit series.
>=20
> The new functions are as below:
>=20
> irdma_reg_user_mr_type_mem
> irdma_alloc_iwmr
> irdma_free_iwmr
> irdma_reg_user_mr_type_qp
> irdma_reg_user_mr_type_cq

Thanks! General direction is good. I provided some feedback.

>=20
> These functions will be used in the dmabuf feature.

Do you want to add that dma buf patch to this series too? So that we can se=
e it how it re-uses the new APIs you created.

So 1st 4 patches would be clean-up/refactor patches in preparation for patc=
h #5 which is the dma buf API addition.

>=20
> Zhu Yanjun (4):
>   RDMA/irdma: Split MEM handler into irdma_reg_user_mr_type_mem
>   RDMA/irdma: Split mr alloc and free into new functions
>   RDMA/irdma: Split QP handler into irdma_reg_user_mr_type_qp
>   RDMA/irdma: Split CQ handler into irdma_reg_user_mr_type_cq
>=20
>  drivers/infiniband/hw/irdma/verbs.c | 260 +++++++++++++++++-----------
>  1 file changed, 160 insertions(+), 100 deletions(-)
>=20
> --
> 2.31.1

