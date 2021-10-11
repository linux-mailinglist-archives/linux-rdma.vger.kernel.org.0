Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA542999D
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 01:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhJKXJB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Oct 2021 19:09:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:24117 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235569AbhJKXI6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Oct 2021 19:08:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="214138487"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="214138487"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 16:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="591506860"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2021 16:05:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 16:05:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 16:05:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 11 Oct 2021 16:05:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 11 Oct 2021 16:05:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBIWUfZ1LEwo8qcs2zkJh+gTGYU0GIjreHCnj/Y7aVUhSNOjlQD4JQowHJ3TOhHN+NHqlSIacEp/9iOccPo/LEmxEf5kMcbGRa6Inj6uG4om6MjXju0Lhz+Xyb2USaTGqZCZQDlwHYzjuEbPWWs+Kyj5p5zH0bV2c6Hf2H5yyXq68eHG5zNTDC1OtyghDz+mCKUfL6OWlCxC3foCFSHeZGIr4ZctlzbXyCdbS5kHS4zbtg16P8OFtRiVvF8UiMUY9acwzTXCQhscWDg8J+XjYD/KsLsTGfifKCPRH6RednahuLVc3bVYbEDZJiZKJBD5Sfxe4iJ1oLgHikJVs1yfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4VdIseid0UM8RyDOXtB5SWFj7vyhlKKLmHREzgQx7g=;
 b=JydczsP2s/qUtKbPLBSWB1uCCo/ndTbvsqFmWr+ini7LsRy23+xe57R+kXIII11UJ8zwy1P7NkqT1+/WxEB4vkII8XOcGlK45ulEMPk8+fpBhDigXuqRYkzIJ9D12ZF1kGLMdWKX2PiV3DPCqCCNVcnUzFPlwD0HzA6j8vyDOvxrmndUkvhudKgP390jIkbJYnH3ZhE9gF7kvtZWxLsPlIeC5VQGAdlosjmgadWxHnC6eFOzI89MUfGBJRCtusNM6ZwJKcJaPngQlf0mu/AMIMUJkoW07iZ0Wzdb1wDXbvZhHW1g6rrxK2poTo4X2snGBUXVTX9YrlyGwdDG4xx/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4VdIseid0UM8RyDOXtB5SWFj7vyhlKKLmHREzgQx7g=;
 b=ZFWw9q694BGcSyssFUVrTNbeB2Q+waAB1yepvkdbLkvz9GcSwKs95dcQQSXOkTeU3sE8kAioEMOcEyrgWbRTGbgH3Eqcijg1Z+8iBeh6DBbtk0pdhNlInW4IuJVsd7nQmeyS3/BEqFCgiZ7gLyGzZevSAb852veWptc4JAKjSeo=
Received: from SA2PR11MB4953.namprd11.prod.outlook.com (2603:10b6:806:117::15)
 by SA0PR11MB4718.namprd11.prod.outlook.com (2603:10b6:806:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 23:05:02 +0000
Received: from SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::4c59:5b71:1565:c713]) by SA2PR11MB4953.namprd11.prod.outlook.com
 ([fe80::4c59:5b71:1565:c713%9]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 23:05:02 +0000
From:   "Devale, Sindhu" <sindhu.devale@intel.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Subject: Question on PD validation
Thread-Topic: Question on PD validation
Thread-Index: Ade+81LejqFTfzQERh6UiH7MG/Fbmg==
Date:   Mon, 11 Oct 2021 23:05:02 +0000
Message-ID: <SA2PR11MB495343C46850C730BA4203C1F3B59@SA2PR11MB4953.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55d695b4-20ad-473c-cbf2-08d98d0b8e51
x-ms-traffictypediagnostic: SA0PR11MB4718:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR11MB4718AF3DBF4D58937102CE53F3B59@SA0PR11MB4718.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: osyUF1wECEeOvjemfWo+WRfX7A0MMCE9x+mA07wJdgjUGVKMXsJVK+xLMTk58Z2Oepsxdh6l1M5ZX4hkOnyRU1aPo1kmVJjOOwAfsVVQN9ozw7kaOwcL4/C5WVPNIFXE7myLHbLmQVrn2hDiS1pprQAb7JaQyFb64Qf/AYePgAoq2krr7IPR21JzLc5NmPzxm0aPnLz+YDPkpWNqQId6VdgY935J8KlcrOKafb1g3kn2aj4JnI6c25ou1UAnai5BLLW7lF0dM/6jERBRqY4XSWqzprujORC7Gsi0KVE+SUomhkN+25BY5WEXL+nau8LsfddmAmeiVJOp7ZFoIcxzyvsF8gL+tOHiDkZv1r1C8nNW+LnpdbysaGz5GB0iumHW6YIiRz/tHqwRQSpSy4OQy9XB4xiyOYQ9mv0sST1N5XZJBUKbzngEnmZETsbPGx8UBmkz4e++4WJFBcz+N2Uz1F+shaHAM9Uy+i2pV2bi36STOIejDy5qF7kVx/u0917ovM+ekO2e7cZMXDxBLVUKnfyMSLdj77e6R4xmEleC5/m1IDh6G19myt2E9ORwluL6INRYL5mVJbfy3YavZu+UvhtzbacikBmNB/+JEEAZ5x9hdtCKfxWsFdxoQTRV4kpiWK+WVB516Cz/oZzUmVgVvENXiYogno8dK+Xv57Bk51PFx5Dnwo47h5ucT7BLLGLthBHj3qW4KV8XGOfmUD4Ksw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(5660300002)(8936002)(71200400001)(38070700005)(55016002)(4744005)(26005)(52536014)(33656002)(9686003)(3480700007)(8676002)(86362001)(38100700002)(508600001)(4326008)(66556008)(66446008)(76116006)(316002)(64756008)(107886003)(2906002)(186003)(122000001)(66946007)(66476007)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VIzxicE3mh6d9qinSxoJcK+Nr9MMaQLWQudquWEz07eri4kmyzynycnzEGni?=
 =?us-ascii?Q?cAg3aVPU5XzE97FTLLd5gKGKVvavJqQwBxU/+7MW59iLdoACUd2Z+uha0z04?=
 =?us-ascii?Q?PvA8NAVCf03IoqnUFUjXzIDv7r356Uozkfs763pYlrJ/65ZYJ1jNfEle8/5h?=
 =?us-ascii?Q?8LeA84kZrHZnnzWzBS3nwxmcs8InKDow6W5UNZo8BKWItHz9JOSjNcAsCMb/?=
 =?us-ascii?Q?DFqs6kc6nCLuSMGv9icu/LA+n4VxvM7h0t6dX7n9YoaytT1d6Fm29GIeWv4L?=
 =?us-ascii?Q?8lpHtXvmyzE9vhWE9yeGr5IR8M8VLvC49Sb90zUidbvYuAAsPJBnorUsRmSv?=
 =?us-ascii?Q?2UtEm6e0Kq6hdXhz4ebqMwfRYqYzKlsqQLpFeY1t2WJ51TKDmt50XXCaos20?=
 =?us-ascii?Q?2h/W58qdoxUj0znC/LCnTqIp6R6U3ADxvknAHVZGNvrbVbI/bp8xXEq/tmy4?=
 =?us-ascii?Q?Bk5d64yk+o33Q/PpHuz4vB7fH7D5Rl/DL4kFWbbec+yocpXI8IhXtgATeWkC?=
 =?us-ascii?Q?y46RJPnwCr/IIf6WPh97TSrD2YOly0QhKOZwWR9Wro4Gnp8UsVX6CC38Kz9v?=
 =?us-ascii?Q?uVzcGo1N92OqIJOs9n7ZOJvNl6lhoJn8ZXZgFL4qvrMiElPt13285oYi7OVW?=
 =?us-ascii?Q?916YSzWuwoY2d6eE6pD4ax/PNi6+/ocJ4lOyouWcKswaN/0+UX+qb5tC2+P1?=
 =?us-ascii?Q?hsheA8qW+pqdTI3P012R/IUqVPD4taRPWJtI2J6JK5jClHYR6oweUcpVbUDM?=
 =?us-ascii?Q?z2vx2+JF9yY7RLcJ1zcc7Y/dkO3JLEAujtKgne6CVpytDg0D+h3DHvHm09RA?=
 =?us-ascii?Q?3kdeuf5D/eg6if2j1di36IozrRTRWtPnbnBGmDdfJN7oHlZe3ibgi13eQ8Ie?=
 =?us-ascii?Q?reZfDgNSZuSuiZe61cDjRVtIt9lJxaNWXXR1K/zJRiNK6qtEA5/k4H9ci7Ks?=
 =?us-ascii?Q?l5XLKF4mvZnHrUJeSMi7vJoH/nsME9+0eEEC6qRCnhR3SdaLy13fwiUSLJg3?=
 =?us-ascii?Q?O53rk7I3LJjAZQ59Ne4Wg5Z6aWgNbzafUuDoG+W4B6EOWi93BGXrOS8mek67?=
 =?us-ascii?Q?CMzy46vo74GfZt2zX+ywa/39T5xA8ViEkRZaYu5/ZzVKfgQZOY8kn/FrA61H?=
 =?us-ascii?Q?QhagKKiig/QVxkA47ALtCC1mnUCOk72uVbJZz3Jswyb6zOWR57D4hnpZQqnY?=
 =?us-ascii?Q?iZeeZi3mE185drNuj5z8vuzjPhfhCOvXXR3Gw68iuTjnKCUb+QAi+VmDVUuB?=
 =?us-ascii?Q?u3OUhdhSMEPaLAT31uF4C5iCzzZZ0FM/meUrWTPwPpilcBz9jwy6oTk1Td/g?=
 =?us-ascii?Q?IK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d695b4-20ad-473c-cbf2-08d98d0b8e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 23:05:02.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o4KCBJCSdbQqLrp62rPMdQfvJeJac/EL3e12UxVLGG3iLnRI9NLer1yX5ptYhncIP6VeAMI2sJMaxeHaa1fvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4718
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

Currently, when an application creates a PD, the ib uverbs creates a PD uob=
j resource and tracks it through the xarray which is looked up using an uob=
j id/pd_handle.=20

If a user application were to create a verb resource, example QP, with some=
 random ibv_pd object  [i.e. one not allocated by user process], whose pd_h=
andle happens to match the id of created PDs, the QP creation would succeed=
 though one would expect it to fail For example:
During an alloc PD:
irdma_ualloc_pd, 122], pd_id: 44, ibv_pd: 0x8887c0, pd_handle: 0=20

During create QP:
[irdma_ucreate_qp, 1480], ibv_pd: 0x8889f0, pd_handle: 0


Clearly, the ibv_pd that the application wants the QP to be associated with=
 is not the same as the ibv_pd created during the allocation of PD. Yet, th=
e creation of the QP is successful as the pd handle of 0 matches.=20

It appears there is missing infrastructure to check if the incoming ibv_pd =
during create QP, MR etc is a valid one.

Looking for inputs.

Thank you,
Sindhu

