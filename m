Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D0F745C58
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jul 2023 14:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGCMh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jul 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCMh2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jul 2023 08:37:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85945FD;
        Mon,  3 Jul 2023 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688387847; x=1719923847;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HjiHNQhMZ01EUJU7vez5AuAYnGQw5B3JYvYcQcRQGlQ=;
  b=TvDY1gyIPKOSV4g3hKjvzOhVSUTzq3imo1ZdP6QqXCnJ4gULCywhMwYB
   qaIeIUrJ8SNZy79wdtwCLYIwn2rbuni6L6oeNC8ng3wIJao6d+0VQw6gJ
   +tDDgpx305nF6YTx8/QAXxM9TiPbZLXyN+FgJajh7fxTNV9K6OHNlQ6/B
   8a6I3yOiRZWflIv9tBqkLKklhgCH264J7QOafprAd0or0ZvuYHpU0XcNu
   beWtOlz17txiBuN0HpAbaxJI02wXrA+UOz6a6TunQXP1Odl+mjOBnaLU7
   IV4WNEaISOLAsDwJsdPn8HkebZ7bQgbc6iJV3QzMLXnkuq249b+SVnP7/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="360350015"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="360350015"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 05:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="668744809"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="668744809"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 03 Jul 2023 05:37:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 05:37:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 05:37:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 05:37:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 05:37:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLzXZKXIQCWwp1VVwyQ28rIUbRTcLFP0ydyRKl3ZKZa13qJPzQ1uq3Jsh+T2XP674xWXxOzbK2PB7lcWuRj//yxpGOfgmSgOuJSUV31jZsb4N0eOS0cftkDSo7bvjRmGjM2akzXzorsm8JmCq7RhVcfcDLBc6lUN+/0JRqm8hYywnxL/KE8TPloJWZc63ZuRuJOYN+DyDQnxrAn9OzavKHKlEYbZnFuR6NysT7BHu55suPHe3xMdxw6EDjzT+1qlYA24me4Qg9/sWk9ZMaty86jAIsdpH9oReaci3Bq+pLDDRe6a5wmhrMzVWeKmNKwvzuKG9IRbRoRRi357w8odxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrXxeHNa5q3tMjU+bw7RQye+YKbZLDpQX8fOo4CEVq0=;
 b=PR04Tw745jzMsiHjv/w8oDJhp2m3AXMOvLHpFWDfaiuCR300qBdd6kxomA1/+KebO+cqqzAQ9DzyNl1vhdvpsC/vBfT7vvIMUuCrfhBTv3QQL4EHElPoAIU9CccKVBbnkzHICSXnpGKNCXds/2xuHoxbF3MFRwzXLrzq9IzZVCGl/2vD2f1WL7ULl4e+qaMm+ujW2hT8uy2uP2AAJx7+XxaTQKeMpz0Nq7umldV2C9kJUAAtNjMko05WzAlNxUa2AjZ4GXKQurmuY31b9zZHxz4tRQ26wuhf5+0gAsrtnS94xMON+14+RhCB4aL6TPbLTqQ2hMzLnS4BEc6QFyNr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 12:37:19 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::24bd:974b:5c01:83d6%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 12:37:18 +0000
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
Subject: RE: [RFC PATCH v8 08/10] ice: implement dpll interface to control cgu
Thread-Topic: [RFC PATCH v8 08/10] ice: implement dpll interface to control
 cgu
Thread-Index: AQHZms0YKn5zDyH6hUaEbqiMD+5Ufq+EPdwAgA5hq2CAAqMOgIAMKbiAgAaogpA=
Date:   Mon, 3 Jul 2023 12:37:18 +0000
Message-ID: <DM6PR11MB465726733894C7E64AD3367E9B29A@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-9-arkadiusz.kubalewski@intel.com>
 <ZISmmH0jqxZRB4VX@nanopsycho>
 <DM6PR11MB4657161D2871747A7B404EDD9B5FA@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZJLtR0c+tvCbUgri@nanopsycho> <ZJ0hQRcm6S05r8VE@nanopsycho>
In-Reply-To: <ZJ0hQRcm6S05r8VE@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SA2PR11MB4873:EE_
x-ms-office365-filtering-correlation-id: 80a3dd08-d2b0-4de1-a9f5-08db7bc23d46
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A2Z4y3B8wue1C8DUHhJgmx4Yd2hJIxQoHWTvck0frjVtQDbnTv3Xvwid+iG6IsNojrS4EoEXh0L7iCeO7HzHbtb/zZ6u842FBci0lyNDlgQw4LTOqk258mFsNAdRFStL71wNA1tTjbCehZhtKRSDXQUSvV2IMG/9FN38CtANk0jOiUllKcexr1equTr3Km+l36jAc5fVQ824IZKpUnk5fS9e6t2DChL5tqN0tva5G/RhDS2JvPxY3rpMjDerDx0fUW7JFQ+ZtdlC0l8boYoaTpHn+IvXZfgydcGv1SVCJiTYYNTMvlS3AVwbqR050BfoXcFbq7ElgM2vya5TVcGpl1jHy8Zxgb+rxUyWvk5Qmida1EnwpV4EI9tZXMuBUcG8wtme4UTF0bL1upbegib6PyHdAq4XNQ+DoHq6egmfMXLxAZMwLYxsxsZCHb6ZRyun90Nwa+gdPzYMI46fabgJUrQNhbQrrrTV1pCp9lAwBqoxhBJL3ekUn8PXWNPuKFn5LqzpxlzP/MeQWnfqbxmhkbZR6VUSEPKzFmZp7e+IAaXta2hNHYFUqaeJ6W0bAsnMMRId1a1NDiLD/Inqeazq2+h3gmn2C0U3ktUJBfXRnxb1oERcY3/Ucspi+CH8Jp7W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199021)(54906003)(9686003)(26005)(186003)(33656002)(86362001)(71200400001)(8676002)(7406005)(7416002)(2906002)(5660300002)(7696005)(52536014)(8936002)(41300700001)(478600001)(38100700002)(122000001)(38070700005)(6506007)(66556008)(64756008)(55016003)(66446008)(66946007)(82960400001)(6916009)(4326008)(66476007)(76116006)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PVXDhTcKNm0wvh8f8ozk+IbG4sqwZiGSXVSbwV7mVnY7opJCwx9EYpp6SaU1?=
 =?us-ascii?Q?ZAhHoWJr5M6mCpDkroKrvzCgKnHdHyqvOihnr3SFTpehT/YveBKMq06yGk9A?=
 =?us-ascii?Q?ChHYgBC/t9PCHcEJ+Irh6Bqv+bhJY2GP8L6R8ixL8kTLUHrA5vHnkhbrP9gv?=
 =?us-ascii?Q?aWiR3A+Eq1re/ZpVryKZRUuzud3oo5721gzi1lw9JRE/x7VVJHfieGcOsfIP?=
 =?us-ascii?Q?G8GLRvRp5nw5kpb01jBv8p9cSuyV9xtT7ULDFzl/W1y9k/+57R1Qh8/s7JH0?=
 =?us-ascii?Q?CmpCLGYiWyQmCCXGdoCf0j7I+K065k9vHl2P6Ae+RWg6P/C7MzcSrzs641r6?=
 =?us-ascii?Q?v7IwcwN0GiBpJqmfqRSw9UJBmYOJoZZJZ5C6sQfrvQQ9b4AgPH938cjXd35L?=
 =?us-ascii?Q?VvZOlCSRgsc1AXwDXQappgpZ23uAwsqcqR9qyXsofj/bWqr4LKSD37tkmx5F?=
 =?us-ascii?Q?MR7KRLkX9xDY3y32f9PTqb8HapWES8ZxBrQy5K2fCKt9hu3lH7G+QTMHPA3A?=
 =?us-ascii?Q?8xAZIMSvzOJcqOjVtPjgIMeAgGU629OUNXhVclDME960p7axuaSezIB399de?=
 =?us-ascii?Q?xjCb3sMP0wePZAi/ZH3JXKv4ySuZU8yBlPPojeZl47G1g8q/4Rl6liQBTH2A?=
 =?us-ascii?Q?Lhn3NhTykLv0GTJD4r9ZnxD5I0s24lfYqOYEVrPpnSF+YKnWEGrCx83J6kgf?=
 =?us-ascii?Q?O43K5VSbTzCuRVsxp53uIzqD1bCdDPvih0qdtZWiLLrJ5zXX5ese4I427tLM?=
 =?us-ascii?Q?MQHiXFyuhe7X5ykpVmi5/bHcFy+3qOc0lMNwkvCjc/TAQWPGfBNkMZMAxcAY?=
 =?us-ascii?Q?I5hGy6cBtExrl6+OFxhum6NlrnEk7z9uj6HOINGjXeGpRQXjPWoK9EklOPWL?=
 =?us-ascii?Q?AUi6XEYFwXe8GeM13z8Als7Xsh7Pd5zI6h9ymmGpiisEcbFFov1zid/isIlL?=
 =?us-ascii?Q?XsiJ9KlfnQnwcKOaCPCb5awblqAonoGnB5z9bVvozY8THEIPM0LcDvpDflC9?=
 =?us-ascii?Q?bTlgv5Xj99w1olueAuN9syRg4ze9hyiBQsa/jF1SZjjicqYYk6xJ8Xyc6SsA?=
 =?us-ascii?Q?spsnwUbFx3SScDpGypTcB+Cnht8S5JN5UtcS8pxdzW66KKASrrnwmbGZ1a8H?=
 =?us-ascii?Q?fBn0CCOGAwhFFo/NnAe8W+5ROfp9EvWkfVfm2noTlL6bwSqSxRJ8B0i9HFyW?=
 =?us-ascii?Q?vRN2GhJtdBnCL2cq9eIr9v1T/Vm6sfyifCtx/21S+vL+pOf1hKKWWJU9l5K9?=
 =?us-ascii?Q?1vmgh0ggl2mTYwUfOyUnL2qJOdls7xH+PfOPFC9LZbfxEuIobMvuVyZDbW7w?=
 =?us-ascii?Q?+oKa+YZOC5lbYN9FVgfT11FuPqbKcZ7O8Vx6dU5j0z9L2R0isNczA+9cEGfD?=
 =?us-ascii?Q?Wz7CdCWgEH7iwPfXEofEORQ195XgNNfaN6aHBqJmn1xjY0dOMqq8UZw/I6B2?=
 =?us-ascii?Q?QvLk2u1KrvTVsaLOCAMktQe8EeBgVFnVGJ5oI9vmlAjHxsBaT9egox8/c9Ni?=
 =?us-ascii?Q?zFyK28/dLy5PFe6ifFr0v4sdSedtvsh3FST1uwehK98Q4kL2dJfV+dXynvEN?=
 =?us-ascii?Q?uDYH0Pt8Ys8+cBfEWyZUrSRpp4vhw9uZt6WileIZUVba5QxwPqeujYwEvvpW?=
 =?us-ascii?Q?Ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a3dd08-d2b0-4de1-a9f5-08db7bc23d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 12:37:18.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sYxsVzJgtF3aR9uS3FXMLuCua+815Q/tjvXirD5qgtak9TeulrplJ/ztthbgR/Ekie8sec84A69Aiqw5n+5RP7mAEvIEd/JqqoAfZavjE7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Thursday, June 29, 2023 8:14 AM
>
>Wed, Jun 21, 2023 at 02:29:59PM CEST, jiri@resnulli.us wrote:
>>Mon, Jun 19, 2023 at 10:34:12PM CEST, arkadiusz.kubalewski@intel.com
>wrote:
>>>>From: Jiri Pirko <jiri@resnulli.us>
>>>>Sent: Saturday, June 10, 2023 6:37 PM
>>>>
>>>>Fri, Jun 09, 2023 at 02:18:51PM CEST, arkadiusz.kubalewski@intel.com
>>>>wrote:
>>>>
>>>>[...]
>>>>
>>>>
>>>>>+static int ice_dpll_mode_get(const struct dpll_device *dpll, void *pr=
iv,
>>>>>+			     enum dpll_mode *mode,
>>>>>+			     struct netlink_ext_ack *extack)
>>>>>+{
>>>>>+	*mode =3D DPLL_MODE_AUTOMATIC;
>>>>
>>>>I don't understand how the automatic mode could work with SyncE. The
>>>>There is one pin exposed for one netdev. The SyncE daemon should select
>>>>exacly one pin. How do you achieve that?
>>>>Is is by setting DPLL_PIN_STATE_SELECTABLE on the pin-netdev you want t=
o
>>>>select and DPLL_PIN_STATE_DISCONNECTED on the rest?
>>>>
>>>>
>>>>[...]
>>>
>>>AUTOMATIC mode autoselects highest priority valid signal.
>>>As you have pointed out, for SyncE selection, the user must be able to
>>>manually
>>>select a pin state to enable recovery of signal from particular port.
>>>
>>>In "ice" case there are 2 pins for network PHY clock signal recovery, an=
d
>>>both
>>>are parent pins (MUX-type). There are also 4 pins assigned to netdevs
>>>(one per
>>>port). Thus passing a signal from PHY to the pin is done through the MUX=
-
>>>pin,
>>>by selecting proper state on pin-parent pair (where parent pins is highe=
st
>>>prio
>>>pin on dpll).
>>
>>Could you show me some examples please?
>
>Arkadiusz, could you please reply to this?
>Thanks!
>

Sure, sorry for the delays, let's try that.

'ice' use case:
Enabling a PHY clock recovery for DPLL_MODE_AUTOMATIC dpll (ID#0) with PHY
recovered clock signals (PIN_ID#13) being muxed using MUX-type pin (PIN_ID#=
2)

1. Set MUX-type pin to state selectable and highest priority on a dpll devi=
ce
(or make sure it is already configured):
CMD_PIN_SET:
	PIN_ID			2
	PIN_PARENT_DEVICE	(nest)
		ID		0
		PIN_STATE	SELECTABLE
		PIN_PRIO	0
(assume all the other pins have prio >=3D1)

2. Set connected state on a pin-parent_pin tuple where parent is a pin from=
 #1
CMD_PIN_SET:
	PIN_ID			13
	PIN_PARENT_PIN		(nest)
		PIN_ID		2
		PIN_STATE	CONNECTED

Thank you!
Arkadiusz

>>
>>
>>>
>>>Thank you!
>>>Arkadiusz
