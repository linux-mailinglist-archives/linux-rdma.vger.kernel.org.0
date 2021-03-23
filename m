Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079E9346DE1
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 00:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCWX3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 19:29:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:47002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCWX33 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 19:29:29 -0400
IronPort-SDR: yeZsuhgkqV1+ndDeOEBpI524BpH8OU3EUSS7oYFWw4hb9WYn+hRPMHxf8U7j1dUCSMNjOWeJOU
 9jien1bZGTHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187272013"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="187272013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 16:29:26 -0700
IronPort-SDR: iyvujgY0r/x7Kz2FNTKXayXBOTaaS2y8Xq58bol4kWTmSZ2aZqo2bWzRCBPPdyxlPE/B3V1SQR
 UbXwo8XQh4sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="593174639"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2021 16:29:26 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 16:29:25 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 16:29:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 23 Mar 2021 16:29:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 23 Mar 2021 16:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnYS6iynpmPpbLT6RCsseNSu/F2+nbCxKjtY1oT5yDQLJoJanMaiiPyT6prxB4gn2LOwcG/qsU0Zoaips5aN7+7PNeAE8ZLl4Z1i5f5yrnGjvRQhmEmTfeEHqp3sE8f2vAvQNs6iotXeCQdsf5cnz4udSzyL1bRArKTHzj0LZ4uvMlVXl0ps5iggr7dkIxB50ILrZXjmcSkqdR5AgTdwwwjUSIpJlIvf8zTKR1QWhlitki8ZUjLjp8afgOgLEzvsbJO8oISagNrORjXz2Ul5jIaWSeKhpLr01CjlhhkcB5zszKEUsc3ukq+bXfUDQQW7caS1Z9DtqPAHXJ3zq3xQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id8L2bBQ8ZqWNk7X7tPt2B8iEhl6XKdQhKgaFtM+dDE=;
 b=Z2OqWIwx40/upM7Y7GkwKDacmgfZwAE8H/0NJRFHgbK3ys14sWDRMYsYsqgAOmsZ9Fk5JrsXPSftcWnekfxNvd9O0XKs89fc722IAxlVNrq2RtYrmDxBdY0lWtxrgWocJsA/r5MX54YvnVHT4aF33DWuFikf9A7uPRt2noFvxQliCWKwdOCyGekUkZ7z+8MCcynjWSyUtLh+NiCVKsezCgKpRJFANSK3Gzh5xZEzo3jiDsuBNDTwxvA39Y41vHqxcZ/P0RCKbzl0jB7apleeyL6QGlWicWPimSfntxygGpyyt6NGQQVSgMWKMqyPl/TmF7YuSFuaW2JnQ7Dass3xJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id8L2bBQ8ZqWNk7X7tPt2B8iEhl6XKdQhKgaFtM+dDE=;
 b=H7otQ/k/2DKtWTYlSGYzLajsZaWBEHQ262WfhbJkhUVWjiNPpEygd1K50Qj04dp9W5ifgNRbczZNouYy1lLiPaluCLp718qE2Sh2C8cFNSw8GuiTWe2Xa8uyJ9wkM9oUVXoNxRoKZnId3Serj4DgkckYWeYAWFH3LUpw1mvY1+g=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by BL0PR11MB3251.namprd11.prod.outlook.com (2603:10b6:208:64::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 23:29:23 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::818a:c8c3:663c:f9a3%6]) with mapi id 15.20.3977.024; Tue, 23 Mar 2021
 23:29:23 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Hefty, Sean" <sean.hefty@intel.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgIAAB86AgAAC+OCAAAThAIAAAWWAgAAIBgCAAA2d0IABNB8AgAEQ+ACAAH0jgIAABbUAgAAKGgCAAA1NAIABh8uAgAHtSACAAAOiwA==
Date:   Tue, 23 Mar 2021 23:29:23 +0000
Message-ID: <BL0PR11MB329929960DF5EB86F07BD49FF6649@BL0PR11MB3299.namprd11.prod.outlook.com>
References: <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <be96ccbb-17b7-27e3-a4f2-5b2cc4184ecc@cornelisnetworks.com>
 <YFcKTjU9JSMBrv0x@unreal>
 <bc56284b-f517-2770-16ec-b98d95caea6f@cornelisnetworks.com>
 <20210321164504.GS2356281@nvidia.com>
 <1aaf8fd0-66c5-b804-26dc-c30a427564fa@cornelisnetworks.com>
 <20210321180850.GT2356281@nvidia.com>
 <DM6PR11MB4609382524AE6EA1EAFB15B29E659@DM6PR11MB4609.namprd11.prod.outlook.com>
 <20210323225638.GP2356281@nvidia.com>
In-Reply-To: <20210323225638.GP2356281@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 613a0ba4-1d72-49ce-a4a0-08d8ee537ded
x-ms-traffictypediagnostic: BL0PR11MB3251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB3251447B2FD5F1A6F298B61AF6649@BL0PR11MB3251.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYTYmOp6NKaZSIuU8k+DDoRMSiiQuTSZ5NFnKkyPCgTPcM5AoNptc2klawCcGFkuPnHMyKpKZLLH/G8bMqB55qzV4ecdnERxURLW0zu1hs2elVqkpAp1FiIYA3w77UhQrgr2U9vku5KUSt5Fz1dq1xU+GOuO5TJLOzhoLSBL3Nu9QSVIZ9nKAxWtEJM+w+QZtUsvGvUvEuNXU3bOFxMyERSqPiTaR6KMUegEbZC2UN593Tv/u3e7dkWC9+Hf9oAelXgRPwvKbtR8hkzx7m1oucFt67rbHRMEuUpk4iQ5Q0fjf3wnh+GzdtAkP1wjKPIRQO/5cmirREjXEVzyxGp24aRRnM8kOJ0OPeaBxbDerIOTab5cNxtWqjva0hTbv5dv8+EBu/D15Xe3/j0gnVgKM87jUDHM3xx4OdI4ONI8bfXxBr8tQ8VNIK/LW0/Y1Gb6JzyqetYtnV9nUVCg2vMVSLgZaGJ+HCejl7O9wYzYZsdHsW4Th+WKUtDQj94LTdWI+hnVlOZF/PdSQlxJ6GfTheKsF1WnMXPW4NWCDlF67N3PPIJYrUU5fj9qt11jpLTjd046iEmb5rnVlAEkJ66dCXqkQOeRKFTE6Ze8AqunFw6sXEKxD4qRUhKfQGqxJOf6Ncm2aJ5v36lYbNp2uHa4NFjDCoQPbdCWINb8jv4uVRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(54906003)(110136005)(66476007)(66946007)(478600001)(316002)(76116006)(64756008)(5660300002)(4326008)(71200400001)(2906002)(6636002)(66556008)(66446008)(55016002)(8936002)(86362001)(107886003)(9686003)(33656002)(6506007)(7696005)(52536014)(26005)(186003)(38100700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?70LuD8lqFDDnXJz9NAX+zIK+18W8NGR8YE177K2GZ2e6Tr2S4vQ6Cihn5KWr?=
 =?us-ascii?Q?5+2T5OcxyUbY13tqltwjqiCpjLW0A93/AOVspx8WDzIvE51c2buGwKLiVW7o?=
 =?us-ascii?Q?QKQoxp/cTreIpDmABQVWiMbIN6YtJJHJ3UTrpSgjJ9ExM32aPJSewMNReXdy?=
 =?us-ascii?Q?hFNOZX5WrTUqu+EOf2fvZiP6mHpEdWPIMIFKrhCbm8316TLJcdSKKaeUrOpQ?=
 =?us-ascii?Q?pZaavjbLk62KYC0bYoFN8EgcEdjjG/oajV+kMbWOB5csa6Y8KW+uJcCS3e+V?=
 =?us-ascii?Q?itAmcfHjXIz9DJjT7CavdKv0/17OvNxVxOJIiRW85CMqtQT4Cg+8wkoKKE7r?=
 =?us-ascii?Q?cd4NmWo96fnoaAH0+io0WGEMMeRewbqFfsE1xv4azfGrJSJoxvfiytsRGh7y?=
 =?us-ascii?Q?/FyoJM238UhNc4QdIVtyTmgvVWuB1glHm+32s0dihujHFVxJX5pIp6JPcV35?=
 =?us-ascii?Q?ZEdVnO3DU9z47qR7UDfvrjcfL5fz2gEyFhaysISFakZrxReh47CTSjaXP727?=
 =?us-ascii?Q?3dtZsxyE64DY4BQXedBye9LTaVrNfwiifK3Mq/2tsQnU+VJQki4eyWFGwJgd?=
 =?us-ascii?Q?nbZVwFC1A6M8NI1G/v7UWArugldQF94OXkI1yaclz2ig7iZ7PYyBsprrvSJb?=
 =?us-ascii?Q?o55Kn+SBFRBl+rW4M7aMmqcbwoa66ACG5djurtuGbogtqxN+12gug+rgK3G0?=
 =?us-ascii?Q?03UZgCCFR6Rq6dHEN/EoYo26GIrqGwuIRCTaJhiuRRqXrPy5v2rg6Z5WX1Q6?=
 =?us-ascii?Q?EZxcYTqsgOLrZWoHC1kQlz7SD97RhqIGbsWRkUnjM7yKkNScBaE65IeFH4kg?=
 =?us-ascii?Q?82/H8R0qU2CfuKRyxDGFbMGJKP/5CiIYZ/QJaEB4kArjqTf85bugl8Sg5UZg?=
 =?us-ascii?Q?M/D2h2cTOPEzZJG9j/l2iiHFjAu44TUdDGS5PdsX/qLsQc8OCBLOAP29vJy/?=
 =?us-ascii?Q?0Zp5ma07o60T6qR5+/b4mdji5+QWepr0Je9GU8YuAb1jpuFmNP6GXLNgCLLV?=
 =?us-ascii?Q?F5MuHfSq3ssWG8RXcna2JgoU/9oi2C1LyNNIfsRnnbQ39tWtW0vO/CWikWq7?=
 =?us-ascii?Q?mdoQykbLevsTIest6Ys4nK4RwRbqVZ1oHnHTJ3ocMgDPlgPcTJnKQbt1QJHB?=
 =?us-ascii?Q?VURrIqpwvhpghxxSsRbZ5qPCFe7GULmeuvj6wiBGCkZQp+CfEOraC7NcoWkH?=
 =?us-ascii?Q?Qx2EaLBvN2wszwh5IPYmiM173j5J8injzJ7rw97His2A1dXGaDhuKnxQRzLR?=
 =?us-ascii?Q?oTNu91/zGrPZ/fNorBcsQ0KnJl0qfdOxFzCl8LwCupS4pkUyL5Eui02N5yxo?=
 =?us-ascii?Q?t5l9IRcfh4BF+qTzdGMeXjjr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613a0ba4-1d72-49ce-a4a0-08d8ee537ded
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 23:29:23.3848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTwrC7Qcb71Vk5914LkEu7bVP2W0cVnTqel9pBWF5VCZtpHkJqsL8P7U7xH4Z4Z1RBkeRPlwule6JDUNuw96Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3251
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> How you create a QP owned by the kernel but linked to a PD owned by uverb=
s is going to need very delicate and careful work to be somehow compatible =
with our disassociation model.

The primary usage mode is as follows:
The RC QP, PD and MR are all in the kernel.  The buffer virtual address and=
 len is supplied by the user process and then used to lookup a MR in the ca=
che, upon miss, a kernel MR is created against the kernel PD.  There are se=
parate MR caches per user process.

The IOs are initiated by the user, matched to a MR in the cache, then a RDM=
A Write w/Immed is posted on the kernel RC QP.

In concept, this is not unlike other kernel ULPs which perform direct data =
placement into user memory but use kernel QPs for connections to remote res=
ources, such as various RDMA storage and filesystem ULPs.
The separation of the MR registration call from the IO allows the registrat=
ion cost of a miss to be partially hidden behind the end to end RTS/CTS exc=
hange which is occurring in user space.



There is a secondary usage mode where the MRs are cached, but created again=
st a user PD and later used by the user process against QPs in the user.  W=
e found that usage mode offered some slight latency advantages over the pri=
mary mode for tiny jobs, but suffered significant scalability issues.  Thos=
e latency advantages mainly manifested in microbenchmarks, but did help a f=
ew apps.


If it would simplify things, we could focus the discussion on the primary u=
sage mode.  Conceptually, the secondary usage mode may be a good candidate =
for an extension to uverbs (some form of register MR w/caching API where re=
gister MR checks a cache and deregister MR merely decrements a reference co=
unt in the cache).

Todd

