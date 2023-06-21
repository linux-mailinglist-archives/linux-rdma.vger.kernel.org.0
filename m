Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE3738B27
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjFUQ2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jun 2023 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFUQ2q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jun 2023 12:28:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA0E68;
        Wed, 21 Jun 2023 09:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687364922; x=1718900922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V7dxVkJfADfPGFc7hHLR23LZoZb+rkrPlEnBTM/QSQk=;
  b=VVLI/RQt90pjRKBPnyBG3dLR7So+VnD92IJ703kFPhePMNsIkNzTDEay
   M8VxZhyQdbVPEuw569FS/bd5MXi8XAuWAVEAnWpMJDuVy7MWyx7nEUqDq
   lCWB32kYrUu6EYDjpzE4/ETn/7w58zt6UMJmQigXGrFIFDUsYG0j9ft+K
   cuZ3sa4ADhuADNB14ybggqZG0PdwDE3XV9hUhXpguICP9KK7X9qzMF3wT
   oL3TF230vbwlmSMrVkBwGBiYRLzKpWfQTJy3FYk68W3XUE+2yBrRdzyAJ
   qhHu9cbM+euCdro85PQhq1o9HUOnKTdKzhWVONZyhr0UzadY1W/5e8OBi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="360241184"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="360241184"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 09:28:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="744232152"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="744232152"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 21 Jun 2023 09:28:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 09:28:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 09:28:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 09:28:38 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 09:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbVSgnMZ7f8CngBkOT1XapTFaRCUaN9r/tdLnzbTP+PIqb3DgLVF3JV4MqrxLSHqopxqebMOsNPWLv2BAUhobYsm97U0IQm/WGG2vMSBLXWXlpiM+67SMFYRghdC60v0YxKNm0/TTZWh67i8S0AcfXwJ41XXykOKmGdlqNPcwfSfwzSQzccNQ0/0Z52RzW3l0kzCfurbwHL/pCfgcI3RQcd3rS25NxQpzJQDDmtaKFEP6EhEetnQA25cFKGip189MS6ttjLe6MsR0oVlgALv7FbDeMdESMlgQDooHEGd7VcEXeUyTKk0W47zn/Y+k8+8GAkx/TW2iI8KsHcG8PmXjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l10V3h1qezVBo/1w6lSdXqDZ9VxaftxAqLUHmQdjEfo=;
 b=LsqAPG4sXZGr7/jK31Eo29gwTH210gTYef3nyw8SonZDshwSIL9JA+QXLTLTGxudTioKBcv+enzUGsL2xJt+utkkQxmAm7vT+WjCgl+YLA+TMDeJCZv+5R/SY+HEfkoO2uLnYTnSmrJsdRnqQOkCpPA9Ck4IJcoDEVI12ULEnNfTplyAzYOgJjeKeMvmL3qENpd+oMFgr/pZmK/+JJ/jaU546XMBaak3dYDwW6vULmLmh+CgKi2VbcBsJE65GGy8aApJNRaJibz1CMAQftNPTXqyfFGtWbuTEo1VTadCJRNBbiLH4rmMRPand7Ds632/JLofMtFGOQayP0ph17VCRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA1PR11MB6394.namprd11.prod.outlook.com (2603:10b6:208:3ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 16:28:34 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6521.020; Wed, 21 Jun 2023
 16:28:34 +0000
From:   "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To:     Jiri Pirko <jiri@resnulli.us>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "vadfed@meta.com" <vadfed@meta.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "vadfed@fb.com" <vadfed@fb.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "M, Saeed" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "sj@kernel.org" <sj@kernel.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "ricardo.canuelo@collabora.com" <ricardo.canuelo@collabora.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jacek.lawrynowicz@linux.intel.com" 
        <jacek.lawrynowicz@linux.intel.com>,
        "airlied@redhat.com" <airlied@redhat.com>,
        "ogabbay@kernel.org" <ogabbay@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux@zary.sk" <linux@zary.sk>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "Olech, Milena" <milena.olech@intel.com>,
        "kuniyu@amazon.com" <kuniyu@amazon.com>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "andy.ren@getcruise.com" <andy.ren@getcruise.com>,
        "razor@blackwall.org" <razor@blackwall.org>,
        "idosch@nvidia.com" <idosch@nvidia.com>,
        "lucien.xin@gmail.com" <lucien.xin@gmail.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "phil@nwl.cc" <phil@nwl.cc>,
        "claudiajkang@gmail.com" <claudiajkang@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>,
        mschmidt <mschmidt@redhat.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
Subject: RE: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Topic: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Thread-Index: AQHZmsz08ds9noNj60q1X/LUfA+qnK+ETyKAgA8nyoA=
Date:   Wed, 21 Jun 2023 16:28:34 +0000
Message-ID: <DM6PR11MB46577BE1652554CEEBFA98B29B5DA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
 <ZIS1FX0QAqDSvVUK@nanopsycho>
In-Reply-To: <ZIS1FX0QAqDSvVUK@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA1PR11MB6394:EE_
x-ms-office365-filtering-correlation-id: 55eda4bf-8e12-4109-8d7d-08db72748ee0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0T1ZSC9Fv7H4gGeWOa6Q4Q/Gbn4r7UuqzFlvUz6kERu2Fgc3iZXYIcrc3jKcknTiJYtDECGaSSHkcrOzfeRFN+p5N4v/QCdEfNMk6lYwLUW1nY54vYaTvmdJ9Z6yyuo3WOE6aZCqBj6mCyR3pjuqW+6Wm8I+ja8j9UYz6pfkF16yT/pySMPTIimibz8wJ+lL3q9b2THxEOBxxU2De7BIiaIMxRHJKMeP0ncZnds2/8N8vcr6cafewKczvKDpf5ggZypw9LW7z+lYqxjBTnavf/NMbrUGJPEz8GFpEMiGuQ9hIts4uYMnfN8aXs/dVYouAx3CqOHVteL+yPnYh4Xte3PfupekgUv2RHq+j+tE3w/N9Hemg4Ismb7yB7aPEXS/y/aYiKw3peKqcLX4dt3Ujw2PtAgs6B0CR+4JzD2WseSQS7RKyPNHvacTUMjQIWiL5cYGfzA9dzJqAkkjkWF4M++m09RDjLKENqkIWaN3zlPVgB29WX2ny8/zJiYMYFYsXuudwd/KPOHWlAXKl9j4e6BJg7lFp9vRWuQHBMlXVva+YaPr/62r7nfS+KkuhpQEU71xhyE8WMRcxY7iXWiKXdaVRILadvFajjnuR/Ke7ePzHrAmM3PqMzadMOMV83j2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(54906003)(7406005)(7416002)(82960400001)(33656002)(55016003)(30864003)(52536014)(38070700005)(122000001)(8936002)(41300700001)(5660300002)(66476007)(86362001)(66946007)(4326008)(38100700002)(76116006)(66556008)(6916009)(64756008)(66446008)(8676002)(316002)(7696005)(478600001)(2906002)(71200400001)(186003)(9686003)(26005)(6506007)(83380400001)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4PfjxQXpe774IXA+YxynV3GXX6YVDaBFzZnv06/zTdR754/6Ws0UxtC3y7Gv?=
 =?us-ascii?Q?hOYWtvy1nqUHWl3aUJLD1//Gwe1B63aQsF9wi1Dg1+RWu7etfkfZmobOe6W7?=
 =?us-ascii?Q?2rdu7qc7k8qPgD82L2lOHuQnBbM3YvFSKGdz6TZ05O/SUROXuA7viEskGu6Q?=
 =?us-ascii?Q?+LoYFQIn++GzFzdcgpmsB5y+kywy03gC3+jZdoxWuXxQoNk9Q3WqY9k4spUz?=
 =?us-ascii?Q?2wImtBC+cNmgknsa+DU81nPxP1Jlwd7BO2McfdqXQSfFInaT9rB8zl5uJeuh?=
 =?us-ascii?Q?9NmZiv6Ji+NHvxpKvPedxcxBve93jnyziPyvGebSXNsJsCzgmU8qayaQASjY?=
 =?us-ascii?Q?jvXV5iIj3rmGKycs9iWUXoEFJ1YRkEJqAID/H0hZRV5ASKSNlq9su298vcyg?=
 =?us-ascii?Q?s+oZ5lhsayZtJ0AbAkIOBil9VLUhoGY8WjzFVyaaZl3KoY+Olw2o6kkyp8ld?=
 =?us-ascii?Q?6MfajvjY7XuhbD40DpUHQ1C1KG+h9i8i3h2E8AQKquYWH6s63N9ASSK23o9M?=
 =?us-ascii?Q?ClAYrTnRTpezaG+BtZgb1aSl3cMUCCxyWTuZiw68lYkBgqYvq6usuE4fopX/?=
 =?us-ascii?Q?J/vAnNeHzsjaIShMdQFBrPiKVRn6oWoEf5Ln/0xBiBLugKgAdPqtKyw5hL8x?=
 =?us-ascii?Q?7aYhXroSOyAuQ/AlNKjjQb6auOhrUEbuHS5sMlsyvjhAH8vaYabGvvGX9Oz7?=
 =?us-ascii?Q?p2FaH7MetXh0wYIWOyrOEh0oKrjSc0UrG4Hosaos6ackqsDJ8Utq3GRLtGrS?=
 =?us-ascii?Q?ftqALfk2qmrN75l3IAYs9hNfPCgcrrHG+1zjVqlCJM9FvThh51X5RzNW0Rf9?=
 =?us-ascii?Q?amcs8qFYWSAE9gswGOMmqWgMXW1oqCW5wEPh6Fe8hQrioXF2HUAZNUWJqaVP?=
 =?us-ascii?Q?oPGim1uTjpGZozq25rbdN+o9SbZ66XI98ywAYt3+ky1T2Q0o4P/i5oR4TUKc?=
 =?us-ascii?Q?SS4naa/O3snLc4BIOXPaXWAIFj6hzpMnizIm8BiKcnU9z6I1PGy4mEJS8+qm?=
 =?us-ascii?Q?4pM3/bz75Y7Hd37xfJq93POhljef8KuvkVSve935aOzVWZIoJZ+RV1jDND4t?=
 =?us-ascii?Q?QYFK9psIZIsE830LEZCKNhT37Z8k7FrB2icbARmcMIJa0BHc6DWpdXkx9v2F?=
 =?us-ascii?Q?vjlRG5y1RUL5PY7uCDzl264YYJ8IwOiGkRztcHuZCyY1zV1ARNvAvDAfmMEG?=
 =?us-ascii?Q?z1ylGnk3AMTEjgrEVMNIrBaa0RChicgyB7nWNjTCxGAW2UJs8V/p5dOZnaby?=
 =?us-ascii?Q?yF/FESGiGtwnwovck0bqt7kRyXcAigbVEilrwhXW88WT5r6OorXBYNGiMSYB?=
 =?us-ascii?Q?MhcU1++LUk+7IvNamN+MSCr+1LZnL55+GN5WLMedkU9BOmElIrSl+PRtL8Zt?=
 =?us-ascii?Q?6hFFI4JvJ/uwyEy9CI7S3sF2ZxF2ClaUAFNcnn4pfBIcGuiIo3KGew9ky+hA?=
 =?us-ascii?Q?tfjFKMB5rMkKkAMIuVFI9d2vA8vvI/DwzrQK73bLAMyYm2ym5pMcXjDUEiR/?=
 =?us-ascii?Q?YGpvSHMijrbT3zVXvCqTWXXddXfMUsOf+Hhj1YnlKGug6Y+EqdEnDGjZX/82?=
 =?us-ascii?Q?CPGdX26dpbL8EEmYX+zAe3fShmO56yjISLh/L6TTXRlUlrRQRdA+94woMDHE?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eda4bf-8e12-4109-8d7d-08db72748ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 16:28:34.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iz4h0GXdeiDOJCNbw0Rlo7PsFI3G1I8yl9vy0nAZWZELqCBatbEWCXFfTKIUvriSV2ANA5WwfiVZVvA6gYzv6GYAQB31YYrO4lNF9qZG3mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6394
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Saturday, June 10, 2023 7:38 PM
>
>Fri, Jun 09, 2023 at 02:18:46PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>
>>DPLL framework is used to represent and configure DPLL devices
>>in systems. Each device that has DPLL and can configure inputs
>>and outputs can use this framework.
>>
>>Implement core framework functions for further interactions
>>with device drivers implementing dpll subsystem, as well as for
>>interactions of DPLL netlink framework part with the subsystem
>>itself.
>>
>>Co-developed-by: Milena Olech <milena.olech@intel.com>
>>Signed-off-by: Milena Olech <milena.olech@intel.com>
>>Co-developed-by: Michal Michalik <michal.michalik@intel.com>
>>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>Co-developed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>> drivers/dpll/dpll_core.c | 953 +++++++++++++++++++++++++++++++++++++++
>> drivers/dpll/dpll_core.h | 104 +++++
>
>Overall, looks very good! I pinpointed couple of nits below, nothing big.
>General question: Why do you put documentation comment to every static
>function? Does not make any sense to me. Even for non-exported functions
>I think it is overkill. Most of them (if not all) give the reader no
>additional information and only make the code a bit harder to read.
>Care to drop them?
>
>
>> 2 files changed, 1057 insertions(+)
>> create mode 100644 drivers/dpll/dpll_core.c
>> create mode 100644 drivers/dpll/dpll_core.h
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>new file mode 100644
>>index 000000000000..ee515b7c18be
>>--- /dev/null
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -0,0 +1,953 @@
>>+// SPDX-License-Identifier: GPL-2.0
>>+/*
>>+ *  dpll_core.c - Generic DPLL Management class support.
>
>What's "management class support"? Does not sound recognizable.
>

Fixed.

>
>>+ *
>>+ *  Copyright (c) 2023 Meta Platforms, Inc. and affiliates
>>+ *  Copyright (c) 2023 Intel Corporation.
>>+ */
>>+
>>+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>+
>>+#include <linux/device.h>
>>+#include <linux/err.h>
>>+#include <linux/slab.h>
>>+#include <linux/string.h>
>>+
>>+#include "dpll_core.h"
>>+
>>+DEFINE_MUTEX(dpll_lock);
>>+
>>+DEFINE_XARRAY_FLAGS(dpll_device_xa, XA_FLAGS_ALLOC);
>>+DEFINE_XARRAY_FLAGS(dpll_pin_xa, XA_FLAGS_ALLOC);
>>+
>>+#define ASSERT_DPLL_REGISTERED(d) \
>>+	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>+#define ASSERT_DPLL_NOT_REGISTERED(d) \
>>+	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>+
>>+/**
>>+ * dpll_device_get_by_id - find dpll device by it's id
>>+ * @id: id of searched dpll
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * dpll_device struct if found
>>+ * * NULL otherwise
>>+ */
>>+struct dpll_device *dpll_device_get_by_id(int id)
>>+{
>>+	if (xa_get_mark(&dpll_device_xa, id, DPLL_REGISTERED))
>>+		return xa_load(&dpll_device_xa, id);
>>+
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dpll_pin_registration_find - find a pin registration record
>>+ * @ref: reference between dpll and pin
>>+ * @ops: searched pin ops pointer
>>+ * @priv: searched pin priv pointer
>>+ *
>>+ * Search dpll's registered pins for given ops and priv data.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * NULL - if pin was not found
>>+ * * pointer to `struct dpll_pin_registration` if found
>>+ */
>>+static struct dpll_pin_registration *
>>+dpll_pin_registration_find(struct dpll_pin_ref *ref,
>>+			   const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+
>>+	list_for_each_entry(reg, &ref->registration_list, list) {
>>+		if (reg->ops =3D=3D ops && reg->priv =3D=3D priv)
>>+			return reg;
>>+	}
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_pin_add - add pin reference to a given xarray
>>+ * @xa_pins: dpll_pin_ref xarray holding pins
>>+ * @pin: pin being added
>>+ * @ops: ops for a pin
>>+ * @priv: pointer to private data of owner
>>+ *
>>+ * Allocate and create reference of a pin and enlist a registration
>>+ * structure storing ops and priv pointers of a caller registant.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -ENOMEM on failed allocation
>>+ */
>>+static int
>>+dpll_xa_ref_pin_add(struct xarray *xa_pins, struct dpll_pin *pin,
>>+		    const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+	bool ref_exists =3D false;
>>+	unsigned long i;
>>+	int ret;
>>+
>>+	xa_for_each(xa_pins, i, ref) {
>>+		if (ref->pin !=3D pin)
>>+			continue;
>>+		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>+		if (reg) {
>>+			refcount_inc(&ref->refcount);
>>+			return 0;
>>+		}
>>+		ref_exists =3D true;
>>+		break;
>>+	}
>>+
>>+	if (!ref_exists) {
>>+		ref =3D kzalloc(sizeof(*ref), GFP_KERNEL);
>>+		if (!ref)
>>+			return -ENOMEM;
>>+		ref->pin =3D pin;
>>+		INIT_LIST_HEAD(&ref->registration_list);
>>+		ret =3D xa_insert(xa_pins, pin->pin_idx, ref, GFP_KERNEL);
>>+		if (ret) {
>>+			kfree(ref);
>>+			return ret;
>>+		}
>>+		refcount_set(&ref->refcount, 1);
>>+	}
>>+
>>+	reg =3D kzalloc(sizeof(*reg), GFP_KERNEL);
>>+	if (!reg) {
>>+		if (!ref_exists)
>>+			kfree(ref);
>>+		return -ENOMEM;
>>+	}
>>+	reg->ops =3D ops;
>>+	reg->priv =3D priv;
>>+	if (ref_exists)
>
>If you set refcount to 0 couple of lines above, you can drop the check
>here.
>

Fixed.

>
>>+		refcount_inc(&ref->refcount);
>>+	list_add_tail(&reg->list, &ref->registration_list);
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_pin_del - remove reference of a pin from xarray
>>+ * @xa_pins: dpll_pin_ref xarray holding pins
>>+ * @pin: pointer to a pin being removed
>>+ * @ops: pointer to ops of pin being removed
>>+ * @priv: pointer to private data of registerer who invoked pin removal
>>+ *
>>+ * Decrement refcount of existing pin reference on given xarray.
>>+ * If all registrations are lifted delete the reference and free its mem=
ory.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -EINVAL if reference to a pin was not found
>>+ */
>>+static int dpll_xa_ref_pin_del(struct xarray *xa_pins, struct dpll_pin
>>*pin,
>>+			       const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i;
>>+
>>+	xa_for_each(xa_pins, i, ref) {
>>+		if (ref->pin !=3D pin)
>>+			continue;
>>+		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>+		if (WARN_ON(!reg))
>>+			return -EINVAL;
>>+		if (refcount_dec_and_test(&ref->refcount)) {
>>+			list_del(&reg->list);
>>+			kfree(reg);
>>+			xa_erase(xa_pins, i);
>>+			WARN_ON(!list_empty(&ref->registration_list));
>>+			kfree(ref);
>>+		}
>>+		return 0;
>>+	}
>>+
>>+	return -EINVAL;
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_dpll_add - add dpll reference to a given xarray
>>+ * @xa_dplls: dpll_pin_ref xarray holding dplls
>>+ * @dpll: dpll being added
>>+ * @ops: pin-reference ops for a dpll
>>+ * @priv: pointer to private data of owner
>>+ *
>>+ * Allocate and create reference of a dpll-pin ops or increase refcount
>>+ * on existing dpll reference on given xarray.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -ENOMEM on failed allocation
>>+ */
>>+static int
>>+dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struct dpll_device *dpll,
>>+		     const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+	bool ref_exists =3D false;
>>+	unsigned long i;
>>+	int ret;
>>+
>>+	xa_for_each(xa_dplls, i, ref) {
>>+		if (ref->dpll !=3D dpll)
>>+			continue;
>>+		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>+		if (reg) {
>>+			refcount_inc(&ref->refcount);
>>+			return 0;
>>+		}
>>+		ref_exists =3D true;
>>+		break;
>>+	}
>>+
>>+	if (!ref_exists) {
>>+		ref =3D kzalloc(sizeof(*ref), GFP_KERNEL);
>>+		if (!ref)
>>+			return -ENOMEM;
>>+		ref->dpll =3D dpll;
>>+		INIT_LIST_HEAD(&ref->registration_list);
>>+		ret =3D xa_insert(xa_dplls, dpll->device_idx, ref, GFP_KERNEL);
>>+		if (ret) {
>>+			kfree(ref);
>>+			return ret;
>>+		}
>>+		refcount_set(&ref->refcount, 1);
>>+	}
>>+
>>+	reg =3D kzalloc(sizeof(*reg), GFP_KERNEL);
>>+	if (!reg) {
>>+		if (!ref_exists)
>>+			kfree(ref);
>>+		return -ENOMEM;
>>+	}
>>+	reg->ops =3D ops;
>>+	reg->priv =3D priv;
>>+	if (ref_exists)
>
>If you set refcount to 0 couple of lines above, you can drop the check
>here.
>

Fixed.

>
>>+		refcount_inc(&ref->refcount);
>>+	list_add_tail(&reg->list, &ref->registration_list);
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_dpll_del - remove reference of a dpll from xarray
>>+ * @xa_dplls: dpll_pin_ref xarray holding dplls
>>+ * @dpll: pointer to a dpll to remove
>>+ * @ops: pointer to ops of dpll being removed
>>+ * @priv: pointer to private data of registerer who invoked dpll removal
>>+ *
>>+ * Decrement refcount of existing dpll reference on given xarray.
>>+ * If all references are dropped, delete the reference and free its memo=
ry.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ */
>>+static void
>>+dpll_xa_ref_dpll_del(struct xarray *xa_dplls, struct dpll_device *dpll,
>>+		     const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i;
>>+
>>+	xa_for_each(xa_dplls, i, ref) {
>>+		if (ref->dpll !=3D dpll)
>>+			continue;
>>+		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>+		if (WARN_ON(!reg))
>>+			return;
>>+		if (refcount_dec_and_test(&ref->refcount)) {
>>+			list_del(&reg->list);
>>+			kfree(reg);
>>+			xa_erase(xa_dplls, i);
>>+			WARN_ON(!list_empty(&ref->registration_list));
>>+			kfree(ref);
>>+		}
>>+		return;
>>+	}
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_dpll_find - find dpll reference on xarray
>>+ * @xa_refs: dpll_pin_ref xarray holding dpll references
>>+ * @dpll: pointer to a dpll being searched
>>+ *
>>+ * Search for dpll-pin ops reference struct of a given dpll on given xar=
ray.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * pin reference struct pointer on success
>>+ * * NULL - reference to a pin was not found
>>+ */
>>+struct dpll_pin_ref *
>>+dpll_xa_ref_dpll_find(struct xarray *xa_refs, const struct dpll_device *=
dpll)
>>+{
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i;
>>+
>>+	xa_for_each(xa_refs, i, ref) {
>>+		if (ref->dpll =3D=3D dpll)
>>+			return ref;
>>+	}
>>+
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dpll_xa_ref_dpll_first - find first record of given xarray
>>+ * @xa_refs: xarray
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: first element on given xaaray
>>+ */
>>+struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs)
>>+{
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i =3D 0;
>>+
>>+	ref =3D xa_find(xa_refs, &i, ULONG_MAX, XA_PRESENT);
>>+	WARN_ON(!ref);
>>+	return ref;
>>+}
>>+
>>+/**
>>+ * dpll_device_alloc - allocate the memory for dpll device
>>+ * @clock_id: clock_id of creator
>>+ * @device_idx: id given by dev driver
>>+ * @module: reference to registering module
>>+ *
>>+ * Allocates memory and initialize dpll device, hold its reference on
>>global
>>+ * xarray.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * valid dpll_device struct pointer if succeeded
>>+ * * ERR_PTR(-ENOMEM) - failed memory allocation
>>+ * * ERR_PTR(X) - failed allocation on dpll's xa
>>+ */
>>+static struct dpll_device *
>>+dpll_device_alloc(const u64 clock_id, u32 device_idx, struct module *mod=
ule)
>>+{
>>+	struct dpll_device *dpll;
>>+	int ret;
>>+
>>+	dpll =3D kzalloc(sizeof(*dpll), GFP_KERNEL);
>>+	if (!dpll)
>>+		return ERR_PTR(-ENOMEM);
>>+	refcount_set(&dpll->refcount, 1);
>>+	INIT_LIST_HEAD(&dpll->registration_list);
>>+	dpll->device_idx =3D device_idx;
>>+	dpll->clock_id =3D clock_id;
>>+	dpll->module =3D module;
>>+	ret =3D xa_alloc(&dpll_device_xa, &dpll->id, dpll, xa_limit_16b,
>>+		       GFP_KERNEL);
>>+	if (ret) {
>>+		kfree(dpll);
>>+		return ERR_PTR(ret);
>>+	}
>>+	xa_init_flags(&dpll->pin_refs, XA_FLAGS_ALLOC);
>>+
>>+	return dpll;
>>+}
>>+
>>+/**
>>+ * dpll_device_get - find existing or create new dpll device
>>+ * @clock_id: clock_id of creator
>>+ * @device_idx: idx given by device driver
>>+ * @module: reference to registering module
>>+ *
>>+ * Get existing object of a dpll device, unique for given arguments.
>>+ * Create new if doesn't exist yet.
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Return:
>>+ * * valid dpll_device struct pointer if succeeded
>>+ * * ERR_PTR(-ENOMEM) - failed memory allocation
>>+ * * ERR_PTR(X) - failed allocation on dpll's xa
>>+ */
>>+struct dpll_device *
>>+dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)
>>+{
>>+	struct dpll_device *dpll, *ret =3D NULL;
>>+	unsigned long index;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	xa_for_each(&dpll_device_xa, index, dpll) {
>>+		if (dpll->clock_id =3D=3D clock_id &&
>>+		    dpll->device_idx =3D=3D device_idx &&
>>+		    dpll->module =3D=3D module) {
>>+			ret =3D dpll;
>>+			refcount_inc(&ret->refcount);
>>+			break;
>>+		}
>>+	}
>>+	if (!ret)
>>+		ret =3D dpll_device_alloc(clock_id, device_idx, module);
>>+	mutex_unlock(&dpll_lock);
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_device_get);
>>+
>>+/**
>>+ * dpll_device_put - decrease the refcount and free memory if possible
>>+ * @dpll: dpll_device struct pointer
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Drop reference for a dpll device, if all references are gone, delete
>>+ * dpll device object.
>>+ */
>>+void dpll_device_put(struct dpll_device *dpll)
>>+{
>>+	if (!dpll)
>
>Drop this check and rely on a basic driver sanity. I'm pretty sure I
>asked you to drop checks like this during the last version review.
>

Fixed.

>
>>+		return;
>>+	mutex_lock(&dpll_lock);
>>+	if (refcount_dec_and_test(&dpll->refcount)) {
>>+		ASSERT_DPLL_NOT_REGISTERED(dpll);
>>+		WARN_ON_ONCE(!xa_empty(&dpll->pin_refs));
>>+		xa_destroy(&dpll->pin_refs);
>>+		xa_erase(&dpll_device_xa, dpll->id);
>>+		WARN_ON(!list_empty(&dpll->registration_list));
>>+		kfree(dpll);
>>+	}
>>+	mutex_unlock(&dpll_lock);
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_device_put);
>>+
>>+static struct dpll_device_registration *
>>+dpll_device_registration_find(struct dpll_device *dpll,
>>+			      const struct dpll_device_ops *ops, void *priv)
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	list_for_each_entry(reg, &dpll->registration_list, list) {
>>+		if (reg->ops =3D=3D ops && reg->priv =3D=3D priv)
>>+			return reg;
>>+	}
>>+	return NULL;
>>+}
>>+
>>+/**
>>+ * dpll_device_register - register the dpll device in the subsystem
>>+ * @dpll: pointer to a dpll
>>+ * @type: type of a dpll
>>+ * @ops: ops for a dpll device
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Make dpll device available for user space.
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -EINVAL on failure due to wrong arguments provided
>>+ * * -EEXIST if device was already registered
>>+ */
>>+int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>>+			 const struct dpll_device_ops *ops, void *priv)
>>+{
>>+	struct dpll_device_registration *reg;
>>+	bool first_registration =3D false;
>>+
>>+	if (WARN_ON(!ops))
>>+		return -EINVAL;
>>+	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
>>+		return -EINVAL;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	reg =3D dpll_device_registration_find(dpll, ops, priv);
>>+	if (reg) {
>>+		mutex_unlock(&dpll_lock);
>>+		return -EEXIST;
>>+	}
>>+
>>+	reg =3D kzalloc(sizeof(*reg), GFP_KERNEL);
>>+	if (!reg) {
>>+		mutex_unlock(&dpll_lock);
>>+		return -EEXIST;
>
>-ENOMEM;
>

Fixed.

>
>>+	}
>>+	reg->ops =3D ops;
>>+	reg->priv =3D priv;
>>+	dpll->type =3D type;
>>+	first_registration =3D list_empty(&dpll->registration_list);
>>+	list_add_tail(&reg->list, &dpll->registration_list);
>>+	if (!first_registration) {
>>+		mutex_unlock(&dpll_lock);
>>+		return 0;
>>+	}
>>+
>>+	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>>+	mutex_unlock(&dpll_lock);
>>+	dpll_device_create_ntf(dpll);
>>+
>>+	return 0;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_device_register);
>>+
>>+/**
>>+ * dpll_device_unregister - unregister dpll device
>>+ * @dpll: registered dpll pointer
>>+ * @ops: ops for a dpll device
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Unregister device, make it unavailable for userspace.
>>+ * Note: It does not free the memory
>>+ * Context: Acquires a lock (dpll_lock)
>>+ */
>>+void dpll_device_unregister(struct dpll_device *dpll,
>>+			    const struct dpll_device_ops *ops, void *priv)
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	ASSERT_DPLL_REGISTERED(dpll);
>>+	dpll_device_delete_ntf(dpll);
>>+	reg =3D dpll_device_registration_find(dpll, ops, priv);
>>+	if (WARN_ON(!reg)) {
>>+		mutex_unlock(&dpll_lock);
>>+		return;
>>+	}
>>+	list_del(&reg->list);
>>+	kfree(reg);
>>+
>>+	if (!list_empty(&dpll->registration_list)) {
>>+		mutex_unlock(&dpll_lock);
>>+		return;
>>+	}
>>+	xa_clear_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>>+	mutex_unlock(&dpll_lock);
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_device_unregister);
>>+
>>+/**
>>+ * dpll_pin_alloc - allocate the memory for dpll pin
>>+ * @clock_id: clock_id of creator
>>+ * @pin_idx: idx given by dev driver
>>+ * @module: reference to registering module
>>+ * @prop: dpll pin properties
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * valid allocated dpll_pin struct pointer if succeeded
>>+ * * ERR_PTR(-ENOMEM) - failed memory allocation
>>+ * * ERR_PTR(-EINVAL) - wrong pin type property value
>>+ */
>>+static struct dpll_pin *
>>+dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
>>+	       const struct dpll_pin_properties *prop)
>>+{
>>+	struct dpll_pin *pin;
>>+	int ret;
>>+
>>+	pin =3D kzalloc(sizeof(*pin), GFP_KERNEL);
>>+	if (!pin)
>>+		return ERR_PTR(-ENOMEM);
>>+	pin->pin_idx =3D pin_idx;
>>+	pin->clock_id =3D clock_id;
>>+	pin->module =3D module;
>>+	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
>>+		    prop->type > DPLL_PIN_TYPE_MAX)) {
>>+		ret =3D -EINVAL;
>>+		goto err;
>>+	}
>>+	pin->prop =3D prop;
>>+	refcount_set(&pin->refcount, 1);
>>+	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>>+	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>+	ret =3D xa_alloc(&dpll_pin_xa, &pin->id, pin, xa_limit_16b, GFP_KERNEL)=
;
>>+	if (ret)
>>+		goto err;
>>+	return pin;
>>+err:
>>+	xa_destroy(&pin->dpll_refs);
>>+	xa_destroy(&pin->parent_refs);
>>+	kfree(pin);
>>+	return ERR_PTR(ret);
>>+}
>>+
>>+/**
>>+ * dpll_pin_get - find existing or create new dpll pin
>>+ * @clock_id: clock_id of creator
>>+ * @pin_idx: idx given by dev driver
>>+ * @module: reference to registering module
>>+ * @prop: dpll pin properties
>>+ *
>>+ * Get existing object of a pin (unique for given arguments) or create n=
ew
>>+ * if doesn't exist yet.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return:
>>+ * * valid allocated dpll_pin struct pointer if succeeded
>>+ * * ERR_PTR of an error
>>+ */
>>+struct dpll_pin *
>>+dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>+	     const struct dpll_pin_properties *prop)
>>+{
>>+	struct dpll_pin *pos, *ret =3D NULL;
>>+	unsigned long i;
>>+
>>+	xa_for_each(&dpll_pin_xa, i, pos) {
>>+		if (pos->clock_id =3D=3D clock_id &&
>>+		    pos->pin_idx =3D=3D pin_idx &&
>>+		    pos->module =3D=3D module) {
>>+			ret =3D pos;
>>+			refcount_inc(&ret->refcount);
>>+			break;
>>+		}
>>+	}
>>+	if (!ret)
>>+		ret =3D dpll_pin_alloc(clock_id, pin_idx, module, prop);
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_get);
>>+
>>+/**
>>+ * dpll_pin_put - decrease the refcount and free memory if possible
>>+ * @pin: pointer to a pin to be put
>>+ *
>>+ * Drop reference for a pin, if all references are gone, delete pin obje=
ct.
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ */
>>+void dpll_pin_put(struct dpll_pin *pin)
>>+{
>>+	if (!pin)
>
>Drop this check.
>

Fixed.

>
>>+		return;
>>+	if (refcount_dec_and_test(&pin->refcount)) {
>>+		xa_destroy(&pin->dpll_refs);
>>+		xa_destroy(&pin->parent_refs);
>>+		xa_erase(&dpll_pin_xa, pin->id);
>>+		kfree(pin);
>>+	}
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_put);
>>+
>>+static int
>>+__dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>>+		    const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	int ret;
>>+
>>+	if (WARN_ON(!ops))
>>+		return -EINVAL;
>>+
>>+	ret =3D dpll_xa_ref_pin_add(&dpll->pin_refs, pin, ops, priv);
>>+	if (ret)
>>+		return ret;
>>+	ret =3D dpll_xa_ref_dpll_add(&pin->dpll_refs, dpll, ops, priv);
>>+	if (ret)
>>+		goto ref_pin_del;
>>+	else
>>+		dpll_pin_create_ntf(pin);
>>+
>>+	return ret;
>>+
>>+ref_pin_del:
>>+	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * dpll_pin_register - register the dpll pin in the subsystem
>>+ * @dpll: pointer to a dpll
>>+ * @pin: pointer to a dpll pin
>>+ * @ops: ops for a dpll pin ops
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -EINVAL - missing pin ops
>>+ * * -ENOMEM - failed to allocate memory
>>+ */
>>+int
>>+dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>>+		  const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	int ret;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	if (WARN_ON(!(dpll->module =3D=3D pin->module &&
>>+		      dpll->clock_id =3D=3D pin->clock_id)))
>>+		ret =3D -EFAULT;
>
>In other cases like this you return -EINVAL. I think it is better. One
>way or another, be consistent please.
>

Fixed.

>
>>+	else
>>+		ret =3D __dpll_pin_register(dpll, pin, ops, priv);
>>+	mutex_unlock(&dpll_lock);
>>+
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_register);
>>+
>>+static void
>>+__dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>>+		      const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
>>+	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv);
>>+}
>>+
>>+/**
>>+ * dpll_pin_unregister - unregister dpll pin from dpll device
>>+ * @dpll: registered dpll pointer
>>+ * @pin: pointer to a pin
>>+ * @ops: ops for a dpll pin
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Note: It does not free the memory
>>+ * Context: Acquires a lock (dpll_lock)
>>+ */
>>+void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>>+			 const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	if (WARN_ON(xa_empty(&dpll->pin_refs)))
>>+		return;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	__dpll_pin_unregister(dpll, pin, ops, priv);
>>+	mutex_unlock(&dpll_lock);
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_unregister);
>>+
>>+/**
>>+ * dpll_pin_on_pin_register - register a pin with a parent pin
>>+ * @parent: pointer to a parent pin
>>+ * @pin: pointer to a pin
>>+ * @ops: ops for a dpll pin
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Register a pin with a parent pin, create references between them and
>>+ * between newly registered pin and dplls connected with a parent pin.
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Return:
>>+ * * 0 on success
>>+ * * -EINVAL missing pin or parent
>>+ * * -ENOMEM failed allocation
>>+ * * -EPERM if parent is not allowed
>>+ */
>>+int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *p=
in,
>>+			     const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i, stop;
>>+	int ret;
>>+
>>+	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>+		return -EINVAL;
>>+	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
>>+	if (ret)
>>+		goto unlock;
>>+	refcount_inc(&pin->refcount);
>>+	xa_for_each(&parent->dpll_refs, i, ref) {
>>+		mutex_lock(&dpll_lock);
>>+		ret =3D __dpll_pin_register(ref->dpll, pin, ops, priv);
>>+		mutex_unlock(&dpll_lock);
>>+		if (ret) {
>>+			stop =3D i;
>>+			goto dpll_unregister;
>>+		}
>>+		dpll_pin_create_ntf(pin);
>>+	}
>>+
>>+	return ret;
>>+
>>+dpll_unregister:
>>+	xa_for_each(&parent->dpll_refs, i, ref) {
>>+		if (i < stop) {
>>+			mutex_lock(&dpll_lock);
>>+			__dpll_pin_unregister(ref->dpll, pin, ops, priv);
>>+			mutex_unlock(&dpll_lock);
>>+		}
>>+	}
>>+	refcount_dec(&pin->refcount);
>>+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv);
>>+unlock:
>>+	return ret;
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_on_pin_register);
>>+
>>+/**
>>+ * dpll_pin_on_pin_unregister - unregister dpll pin from a parent pin
>>+ * @parent: pointer to a parent pin
>>+ * @pin: pointer to a pin
>>+ * @ops: ops for a dpll pin
>>+ * @priv: pointer to private information of owner
>>+ *
>>+ * Context: Acquires a lock (dpll_lock)
>>+ * Note: It does not free the memory
>>+ */
>>+void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin
>>*pin,
>>+				const struct dpll_pin_ops *ops, void *priv)
>>+{
>>+	struct dpll_pin_ref *ref;
>>+	unsigned long i;
>>+
>>+	mutex_lock(&dpll_lock);
>>+	dpll_pin_delete_ntf(pin);
>>+	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv);
>>+	refcount_dec(&pin->refcount);
>>+	xa_for_each(&pin->dpll_refs, i, ref) {
>>+		__dpll_pin_unregister(ref->dpll, pin, ops, priv);
>>+	}
>
>Drop "{}"s for one line statement. Didn't checkpack warn you?
>

Fixed.

>
>>+	mutex_unlock(&dpll_lock);
>>+}
>>+EXPORT_SYMBOL_GPL(dpll_pin_on_pin_unregister);
>>+
>>+
>>+/**
>>+ * dpll_device_registration_first - get first registration of dpll devic=
e
>>+ * @dpll: pointer to a dpll
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the first registration of a dpll
>>+ */
>>+static struct dpll_device_registration *
>>+dpll_device_registration_first(struct dpll_device *dpll)
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	reg =3D list_first_entry_or_null((struct list_head *) &dpll-
>>registration_list,
>>+				       struct dpll_device_registration, list);
>>+	WARN_ON(!reg);
>>+	return reg;
>>+}
>>+
>>+/**
>>+ * dpll_priv - get the dpll device private owner data
>>+ * @dpll: registered dpll pointer
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the first registration priv data
>>+ */
>>+void *dpll_priv(struct dpll_device *dpll)
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	reg =3D dpll_device_registration_first(dpll);
>>+	return reg->priv;
>>+}
>>+
>>+/**
>>+ * dpll_device_ops - get the dpll device ops pointer
>>+ * @dpll: registered dpll pointer
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the first registration ops of the dpll
>>+ */
>>+const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll)
>>+{
>>+	struct dpll_device_registration *reg;
>>+
>>+	reg =3D dpll_device_registration_first(dpll);
>>+	return reg->ops;
>>+}
>>+
>>+/**
>>+ * dpll_pin_registration_first - get first registration of dpll pin ref
>>+ * @ref: pointer to a pin ref struct
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the first registration of a dpll_pin_ref
>>+ */
>>+static struct dpll_pin_registration *
>>+dpll_pin_registration_first(struct dpll_pin_ref *ref)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+
>>+	reg =3D list_first_entry_or_null(&ref->registration_list,
>>+				       struct dpll_pin_registration, list);
>>+	WARN_ON(!reg);
>>+	return reg;
>>+}
>>+
>>+/**
>>+ * dpll_pin_on_dpll_priv - get the dpll device private owner data
>>+ * @dpll:      registered dpll pointer
>>+ * @pin:       pointer to a pin
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the data
>>+ */
>>+void *dpll_pin_on_dpll_priv(struct dpll_device *dpll,
>>+			    struct dpll_pin *pin)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+
>>+	ref =3D xa_load(&dpll->pin_refs, pin->pin_idx);
>>+	if (!ref)
>>+		return NULL;
>>+	reg =3D dpll_pin_registration_first(ref);
>>+	return reg->priv;
>>+}
>>+
>>+/**
>>+ * dpll_pin_on_pin_priv - get the dpll pin private owner data
>>+ * @parent: pointer to a parent pin
>>+ * @pin: pointer to a pin
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the data
>>+ */
>>+void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
>>+			   struct dpll_pin *pin)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+	struct dpll_pin_ref *ref;
>>+
>>+	ref =3D xa_load(&pin->parent_refs, parent->pin_idx);
>>+	if (!ref)
>>+		return NULL;
>>+	reg =3D dpll_pin_registration_first(ref);
>>+	return reg->priv;
>>+}
>>+
>>+/**
>>+ * dpll_pin_ops - get the pin ops pointer
>>+ * @ref: dpll pin ref
>>+ *
>>+ * Context: shall be called under a lock (dpll_lock)
>>+ * Return: pointer to the first ops registered with the pin
>>+ */
>>+const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
>>+{
>>+	struct dpll_pin_registration *reg;
>>+
>>+	reg =3D dpll_pin_registration_first(ref);
>>+	return reg->ops;
>>+}
>>+
>>+/**
>>+ * dpll_init - initialize dpll subsystem
>>+ *
>>+ * Return:
>>+ * 0 - success
>>+ * negative - netlink init error
>>+ */
>>+static int __init dpll_init(void)
>>+{
>>+	int ret;
>>+
>>+	ret =3D dpll_netlink_init();
>>+	if (ret)
>>+		goto error;
>>+
>>+	return 0;
>>+
>>+error:
>>+	mutex_destroy(&dpll_lock);
>>+	return ret;
>>+}
>>+subsys_initcall(dpll_init);
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>new file mode 100644
>>index 000000000000..ef95e272937c
>>--- /dev/null
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -0,0 +1,104 @@
>>+/* SPDX-License-Identifier: GPL-2.0 */
>>+/*
>>+ *  Copyright (c) 2023 Meta Platforms, Inc. and affiliates
>>+ *  Copyright (c) 2023 Intel and affiliates
>>+ */
>>+
>>+#ifndef __DPLL_CORE_H__
>>+#define __DPLL_CORE_H__
>>+
>>+#include <linux/dpll.h>
>>+#include <linux/list.h>
>>+#include <linux/refcount.h>
>>+#include "dpll_netlink.h"
>>+
>>+#define DPLL_REGISTERED		XA_MARK_1
>>+
>>+struct dpll_device_registration {
>>+	struct list_head list;
>>+	const struct dpll_device_ops *ops;
>>+	void *priv;
>
>You don't need this struct in the header. Move to .c
>

Fixed.

>
>>+};
>>+
>>+/**
>>+ * struct dpll_device - stores DPLL device internal data
>>+ * @id:			unique id number for each device given by kernel
>
>Who's kernel? Say "dpll subsystem" instead.
>

Fixed.

>
>>+ * @device_idx:		id given by dev driver
>>+ * @clock_id:		unique identifier (clock_id) of a dpll
>>+ * @module:		module of creator
>>+ * @type:		type of a dpll
>>+ * @pin_refs:		stores pins registered within a dpll
>>+ * @mode_supported_mask: mask of supported modes
>>+ * @refcount:		refcount
>>+ * @registration_list:	list of registered ops and priv data of dpll
>>owners
>>+ **/
>>+struct dpll_device {
>>+	u32 id;
>>+	u32 device_idx;
>>+	u64 clock_id;
>>+	struct module *module;
>>+	enum dpll_type type;
>>+	struct xarray pin_refs;
>>+	unsigned long mode_supported_mask;
>>+	refcount_t refcount;
>>+	struct list_head registration_list;
>>+};
>>+
>>+/**
>>+ * struct dpll_pin - structure for a dpll pin
>>+ * @id:			unique id number for pin given by kernel
>
>Who's kernel? Say "dpll subsystem" instead.
>

Fixed.

>
>>+ * @pin_idx:		index of a pin given by dev driver
>>+ * @clock_id:		clock_id of creator
>>+ * @module:		module of creator
>>+ * @dpll_refs:		hold referencees to dplls pin was registered with
>>+ * @parent_refs:	hold references to parent pins pin was registered with
>>+ * @prop:		pointer to pin properties given by registerer
>>+ * @rclk_dev_name:	holds name of device when pin can recover clock from =
it
>>+ * @refcount:		refcount
>>+ **/
>>+struct dpll_pin {
>>+	u32 id;
>>+	u32 pin_idx;
>>+	u64 clock_id;
>>+	struct module *module;
>>+	struct xarray dpll_refs;
>>+	struct xarray parent_refs;
>>+	const struct dpll_pin_properties *prop;
>>+	char *rclk_dev_name;
>>+	refcount_t refcount;
>>+};
>>+
>>+struct dpll_pin_registration {
>>+	struct list_head list;
>>+	const struct dpll_pin_ops *ops;
>>+	void *priv;
>>+};
>
>You don't need this struct in the header. Move to .c
>

Fixed.

Thank you,
Arkadiusz

>
>>+
>>+/**
>>+ * struct dpll_pin_ref - structure for referencing either dpll or pins
>>+ * @dpll:		pointer to a dpll
>>+ * @pin:		pointer to a pin
>>+ * @registration_list:	list of ops and priv data registered with the
>>ref
>>+ * @refcount:		refcount
>>+ **/
>>+struct dpll_pin_ref {
>>+	union {
>>+		struct dpll_device *dpll;
>>+		struct dpll_pin *pin;
>>+	};
>>+	struct list_head registration_list;
>>+	refcount_t refcount;
>>+};
>>+
>>+void *dpll_priv(struct dpll_device *dpll);
>>+void *dpll_pin_on_dpll_priv(struct dpll_device *dpll, struct dpll_pin *p=
in);
>>+void *dpll_pin_on_pin_priv(struct dpll_pin *parent, struct dpll_pin *pin=
);
>>+
>>+const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
>>+struct dpll_device *dpll_device_get_by_id(int id);
>>+const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
>>+struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
>>+extern struct xarray dpll_device_xa;
>>+extern struct xarray dpll_pin_xa;
>>+extern struct mutex dpll_lock;
>>+#endif
>>--
>>2.37.3
>>
