Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1473426B1
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSUMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:12:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:55742 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhCSUMW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:12:22 -0400
IronPort-SDR: 8YkEnSFHbBX7wRjpi/cTF8W7snISYD6xeUV0m2US/8hebjywNaJw46wzM14j4CpzAxOZ6WrNTZ
 e1Zi1tKWElfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="251311717"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="251311717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:12:21 -0700
IronPort-SDR: HIFaQj9mlNKkMpdRMGL3tClbcGrfwxgil5Z6sdrxqzpLqdKq1VxmYLpLrYPx2MugOueTIQdmGD
 3WTLZb3PQ9sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406928047"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 19 Mar 2021 13:12:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:12:21 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:12:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 13:12:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 13:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elt5MPs8Lrc8PjxftN0c6NVuyTQl3Lv5YUd2IKUlTOj91mR59U4XP7GCnQMAwFp03A4bO6EIf+sjwUqXpMUARb7ICgK44gGQR/5LH+DLW+DXDx5HZvO0LSwcgsoVXAW0nBGAP9h004R+jcpBV5cR75A3SeAv7OxEU40K+tX3J/rZakZNcEcZ41E0oGYRClneDNhFcmcnwTVg+DpQm0KLlRw8SaPmoiAmru1dbXwocLV4I79xOihd0jXxmVsvtwzLoOsELqIZMCCVMtB+ZATCXeFFRc2wxRyTsq54P0A7sMYAOiarWBJKj6YbDr366/lKFxq/S8+UfA1brqfw9JbFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YNWhQY3ylr3Rkj/tryyLzTaQEalh3M8/TXCxCCrRc4=;
 b=FBF6X4j/bSNChlF8q5PwdECBKm2OS7FfW4Oxu3OE7rVz02CszMVZc5ZY0qBcIWs8Pt5hSrR5vEdpZobD1bobYbZJganbBccX5TuhqcOXrHh99La3fLTs2ZK6Npkvt5j54bWEel8bsolA5ySHXWEVo0jRf4sb1P7EZndL9OcIaHMTpRuc4uOQ3ZmXAi0G+t00+XbQLTH65b4pXubd8vLNhizvhOuAqNR3CO+dX9v3hTejdQXvJi3k5aHtO2FxJWY3eSxZBYd8S3RbCI+cdmdL8wuUwupeYIrhJ7M3S4WWWfZNeo+4FNr+YxBnomJeOD2xc2FgqSBSTaPIhqidd0grNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YNWhQY3ylr3Rkj/tryyLzTaQEalh3M8/TXCxCCrRc4=;
 b=rGFIRItagO17urBTSMRG4HcXeAX2/8dfB/TNdctXLGPYukIv2bC9kEBuLpSP1xwLheYWeiDfKGTT6fGHuhNCbkC8QraUpRExbNb33G4t6tBQIvxkhE342Jq0n2IkDrQ16T6/PMjZEcbTMZR7e+yEnJiZhiMhT8pjllXEWzNyGtc=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by MN2PR11MB4510.namprd11.prod.outlook.com (2603:10b6:208:17b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:12:18 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:12:18 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
CC:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgA==
Date:   Fri, 19 Mar 2021 20:12:18 +0000
Message-ID: <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
In-Reply-To: <20210319194446.GA2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [100.34.146.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 491cddad-a104-45d5-27db-08d8eb134be0
x-ms-traffictypediagnostic: MN2PR11MB4510:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB451055223F430B7479C1F5EEF6689@MN2PR11MB4510.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtykxM3vomznFRlX4uwJY5xCyNVmyBhf5FlTlmWSNkk9L4drek46iLMDDtvqSJZP3/PRH/qPcFQSDSbU2w5u6laSAYljtKeaBjyBkM07mx2jnXUs/hXkLpjwEXNYqzCcQt7uu1Wsqb+DfOJZyGZ6Mevg8Zl+zeRHIXtH/JRAfy+H+xnp9jc7ebaDM4JADtC5P3f+fScNgpYDzD5UelO8HNiOLTu2TJx1QLSCJcXpyMtndsG1NGzuAfdLjbpVWX94Nf8Pgp/XQ2rDFYbTxufyShx4ulMt05JaYLVMyXQp/jU21TTDa82t61TVu9iEnQJWRQzYcBw+4fC/RaOIoTgwEoqIwKtGZl/uZVi54ceV18tfJ8a9TuM6szn8jEL2hxxj3kzmJ8VH650EbiYc6rqTDQ2Nl8GWKUDwbCTt83Y7ISzzpWqD59Xo0bA4oOb1N0e/lelbNNATpXsiQMxeliSa61edCTKlW8Ra3Y3euF6hyVBmgEJO4wBl72Mj8HfXg+nSL4bcbNXHm7p+GipbEphsNlj2YFanrz6vcYJVzDGaERPw7UjxOKfm0DwWUwFLVRhxG0FFRo4aCYV8+G3TPtXk7FRbY9LLp1Cx1kL0uMU4KvwovK38zxdzvpX7jzPilqOM2NMerNpp5B4neAEWX+5LpXJ6EUH09e5yUnFe4UdC0NU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(366004)(136003)(396003)(86362001)(9686003)(52536014)(4326008)(5660300002)(54906003)(6506007)(2906002)(110136005)(83380400001)(71200400001)(107886003)(64756008)(66446008)(26005)(66556008)(66476007)(8936002)(478600001)(8676002)(186003)(316002)(76116006)(66946007)(7696005)(38100700001)(55016002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0SNBBfl6Mirk/qlx6vsyx2Mpi0kxe+gTzjit2aAX14p1sBo90zHpCHXB0ew4?=
 =?us-ascii?Q?U1ul9W9Vb7GU2udMLShuNslKXTpnFiLUV+ZlvglRgKTbGTBu34pAOUAv61Hp?=
 =?us-ascii?Q?JziR/Kwr92Am6FJEtmCMD7vuCu1m14E7k6pRdWL1zXjvGWygN/gMOhHhqM/V?=
 =?us-ascii?Q?kX7FYjZMjpHD+7W5xeVn0P9cpnLS6cjZNVtB9gKBLKpZWJ7bgpMKFHoL4due?=
 =?us-ascii?Q?kN+GM0+Bji8PhcopwWbvYkLJTcg2mv1hTur9COeYeOLWPo0j4BgSblmuudKL?=
 =?us-ascii?Q?Q7od9jOB+klzoF88Wq2y1B/eVWrA1vr9Q08/+ngpuSaQh2fVbiss6FJBzqQF?=
 =?us-ascii?Q?Zy8KrgzOGvycf1ph2Deha4AEjmtEeeiXiQr3iU9wCSNVKaSJQIzEWdem9lgN?=
 =?us-ascii?Q?oKZ2z5uf9DdFro6o/79MkT+XGS0/2q29kOH5ZIOHe47T/JB6kO6tyN8gEUQi?=
 =?us-ascii?Q?C/S2ySObEpQXC3Qc8va75UxzKblImcSL9VJnhjHlamW/L9C03iFOENeGNl3I?=
 =?us-ascii?Q?AdwXZqcgfIC4YBIvzE5qHk6QSkRJHh0JB2op6eNdRugnnv6qCVJCJb+MyHVZ?=
 =?us-ascii?Q?a53Jhgo+NgtiW+RIbFehsfNCL8N5+RpV9d6QTWCIwwEJ6jFKa0dX4J9ny+2y?=
 =?us-ascii?Q?Rmxhly5Spo5z4IGMPkBNGDA9zj1L/NUkxs0X1JVIzPkn6nSAJGqjDq7ZzkYr?=
 =?us-ascii?Q?EyDo9gvhOpUCNOrgicsDY69YZF6efn7mqXozFpUzLjtJbvJhgs4HrqKaHSG1?=
 =?us-ascii?Q?yE7T2NYiBGY4juT5vONnhQiXqgktEZqrPzLlpGUBPsemRELdXJSvHpfa25GQ?=
 =?us-ascii?Q?Mq+qAbrsjq2nZeoaWCQ/md47yARFjmCmGOQXMaCKsfitdcM7YnNDjyN5y/9p?=
 =?us-ascii?Q?09ZtQLQZbiH12/H7X4hVkXAomQHX9ZwQEpJEamRhtDl/tqKqBtP/wcfXKHw8?=
 =?us-ascii?Q?piue2kcYyrcW+V3Yw1BH+YuXx9mf5J7TpD7TstkcUpoKLkitWKZPSlW8tgxW?=
 =?us-ascii?Q?oEFGyN3MxLleVn/7lxdELcz3k3/rKTWIagjyfm7aXJ4J+h/B0Xrizba6hfJk?=
 =?us-ascii?Q?Xtu4DZjCdtZe7LuJiFb32bVTglNnnZjdKkCDLln532Jy52w3oCC/rMUmvzNA?=
 =?us-ascii?Q?hEhl4XYpf5uhSNRyAfJeskhjPCEBIWpsun59bD+zTCjtWW4NV01EYLdX5jNp?=
 =?us-ascii?Q?44dELm+I+wiLRJDG9CJTK8vNJJD3eMWm9NIYvyi6u0up32KSr2rv5OQw4GtW?=
 =?us-ascii?Q?GjlCc9EGEcQ4AKqDAXcdlYOL65QiPUB4hOzA/YmmH3m5qj/8xEV2dMGp+OPO?=
 =?us-ascii?Q?pKFZlXmXlLb8k/t52RcE6P8Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491cddad-a104-45d5-27db-08d8eb134be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 20:12:18.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eq1D06SIaTeYd7WJt0OAaJPb1JD+XtnTnbrQpmqEAiELBsnB6SKV5pp+fxmzKXDYxK9DdzjtZSNDsNxwPAxwyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4510
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> hfi1 calls to the kernel for data path operations - that is "fake" in my =
book. Verbs was always about avoiding that kernel transition, to put it bac=
k in betrays the spirit. > So a kernel call for rv, or the hfi cdev, or the=
 verbs post-send is really all a wash.

To be clear, different vendors have different priorities and hence differen=
t HW designs and approaches.  hfi1 approached the HPC latency needs with a =
uniquely scalable approach with very low latency @scale. Ironically, other =
vendors have since replicated some of those mechanisms with their own propr=
ietary mechanisms, such as UD-X.  hfi1 approached storage needs and large m=
essage HPC transfers with a direct data placement mechanism (aka RDMA).  It=
 fully supported the verbs API and met the performance needs of it's custom=
ers with attractive price and power for its target markets.

Kaike sited hfi1 as just one example of a RDMA verbs device which rv can fu=
nction for.  Various network and server vendors will each make their own re=
commendations for software configs and various end users will each have the=
ir own preferences and requirements.

Todd
