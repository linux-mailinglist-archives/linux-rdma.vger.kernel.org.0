Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B98074E78E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jul 2023 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjGKGwZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jul 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGKGwY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jul 2023 02:52:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5940F188;
        Mon, 10 Jul 2023 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689058343; x=1720594343;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xmfyUKctCz038dw1lR/RnkSSZj+tRTiIoFCVnQGhR4c=;
  b=SRY0FOdG/ycWK6LOa28bQY2osHtahl2MksQBN65u9HRnkZRNDs5cwSdY
   qdP9Qz7K+xK+p7f/NL6HuRizadDYOR6WzdBJZSoAqBFZAXRnwwdJ0oTRD
   tMK7EESFonwk2m0+4vWY6eZHNA77AuUfz2V1ej+wVq3+0JiHdLGkrg0X3
   LMxSBtgM867cMIDCOazIgrKbpkauy8DiEeKwpOXWBWBSNJOZ4dcUdE2A6
   nhlQyhtB+l1bSWPiX2M4fKl6KsCZA/CfrnnfH0cfemWz3+ggcNa1WycXi
   JpzbOEFPlToVvdf9rNzB7guGv7MXvDgxiW08qQ3MNMfi8y2STYdMkfev8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430628326"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="430628326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 23:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="698331084"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="698331084"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 23:52:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 23:52:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 23:52:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 23:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iq5G5XQduhzgxDV6EPtqBOLnhSG6/k/5lG3btVdnjwr+PrSQTAe52p2RZZWDwG8KygTp1HyP03oK3mjpBaVR0BeR9OjTI6X44vXagUsXuWkUagNS5GzG+P5qQ5r8ntvx1nVVYLdp0RMYp0l+XVx06d07KHllU+tW83IiU6JBqFzNFqmnaChNXXrpXxgooyEbSBDk9baHVUAkBC1T/n0dC7iDU9gVGONhZtyB11HBMmSa8xhXwDwdiVe5fpQa70eg00AG8VrBJYrk3pzy54eA9jx3WJZY1AXc/e1dg4KVQc5yc9bldvWUEuR8SgrhHwtvYDM4lS0JwgBvF7YcouwlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvTT4j1o6+uQ+KN5RKHhuZPQKNry6jQllwG61INyw4M=;
 b=GlKAcY9p+qacbh8MGe5GO1vz6hr8hT1yG+9QaY2IVOE/d8TtpMUtXzsF2VkQ5TNIxWOSnxHtbBXkyJKvc3Le3heHOaQdIzZav/+SStbSty3ux0q3N4KtrxmALJN6cqH4VUdXDW4QWImJeBVSuHx94dfJDqxVg8Qze/lTfL+QKWBkZoNk/VD3tYB77x3co0NcvwKRDG3S4yIGX2xxgjS6bOWzM7ueU7X9wRt1fNcfKQXuPhLU7H03Sq1ltnEXkRQcHnGZ2z+tIMrJ5rIA2HjO5M9BFwO/2RglHB13xyIA8KJdxyitwnax/kr11p6piqpOVfWDHnKE1oe2AJ0tj0xjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 06:52:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Tue, 11 Jul 2023
 06:52:19 +0000
Date:   Mon, 10 Jul 2023 23:52:14 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mina Almasry <almasrymina@google.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        "Jesper Dangaard Brouer" <jbrouer@redhat.com>, <brouer@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Yisen Zhuang" <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "Eric Dumazet" <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Geetha sowjanya" <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <64acfc1e46a80_8e17829462@dwillia2-xfh.jf.intel.com.notmuch>
References: <eadebd58-d79a-30b6-87aa-1c77acb2ec17@redhat.com>
 <20230619110705.106ec599@kernel.org>
 <CAHS8izOySGEcXmMg3Gbb5DS-D9-B165gNpwf5a+ObJ7WigLmHg@mail.gmail.com>
 <5e0ac5bb-2cfa-3b58-9503-1e161f3c9bd5@kernel.org>
 <CAHS8izP2fPS56uXKMCnbKnPNn=xhTd0SZ1NRUgnAvyuSeSSjGA@mail.gmail.com>
 <ZKNA9Pkg2vMJjHds@ziepe.ca>
 <CAHS8izNB0qNaU8OTcwDYmeVPtCrEjTTOhwCHtVsLiyhXmPLsXQ@mail.gmail.com>
 <ZKxDZfVAbVHgNgIM@ziepe.ca>
 <CAHS8izO3h3yh=CLJgzhLwCVM4SLgf64nnmBtGrXs=vxuJQHnMQ@mail.gmail.com>
 <ZKyZBbKEpmkFkpWV@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKyZBbKEpmkFkpWV@ziepe.ca>
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e2411a9-95bc-4816-93b1-08db81db5e73
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lOmx+jWgR4SuCCKZRKsCI1/HZsm+u3676QyWGpb2SsIbAe0C4DmhYpTolb6sdSmucSQLLP38EUhUHlrfA2BUXuQz7sYTmNTMu8RS2EctYZZzLYpvN+DEcmY1zHGxuxJo+pebJ9CGhZD6VupTfrOo4k9papVeGODJD71XkxHgWUM46wQTIdzNH0QLMTbd5m8l17LYTg0C56v5bpgwsVWUyNWpsQfUd6TguU6o3foaE6Fmjnf+yZEYnmLXO++2wXiftHOjwwnJHWpz7I7SF75jAUHWF0bM76NU9/ZOZOhaMc5BNUyGq5mP667mvD4HoRhk8FZ9GqYd7RRxVx0Ls+LFpln6S6/bVbaZxnJqzVa1UyFK3Mh7ai3eisWTsDUc7EJEwOGqXzYpincAV3SPoalSJRkNAYYvRQwzOM8xuctjuT7uZjdKTiRoGtpQO6jFjfxgGj5I8phssADD6qqFufXm21vgr4uayH+F5BStuY5iZcOLIL22fxwPtpMmTpO1e5n7AfyzuKr0cHguM7JTek1AqUPPCMT4yYPJbEP9jaDp1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(38100700002)(86362001)(7406005)(6666004)(6486002)(54906003)(110136005)(82960400001)(26005)(6506007)(53546011)(186003)(9686003)(6512007)(966005)(66556008)(7416002)(2906002)(5660300002)(316002)(66476007)(478600001)(66946007)(8936002)(8676002)(83380400001)(4326008)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJOQ2tUWG8xK09OaTE3YmNINGZDcVBqY040SXdjc0hLZ0E4b25vdTFGS1Nr?=
 =?utf-8?B?RUJtMWJkclFHZHRta1JqM3ZVbm5qcXY2TTdHVUZwb1I2VmlVWm9nd3hzMHhC?=
 =?utf-8?B?VWpaaCtETUE5QytDV2o2Ky9ndGZ1bUZSN25vUTMyRnhRalBvQytVazN6THBi?=
 =?utf-8?B?M0pxd0JMS3lGK0VrajBUTFN2N1ZTdytIWFNRRFlGeTVwNm1IeXZmQ2tKWHZF?=
 =?utf-8?B?VCtiUVk0bUxYVFZ5KzVEMFU3dkM2NEErRWc4RFdiNTUydW5DdW5URmY1ekZ2?=
 =?utf-8?B?Rmt4andsVjJwT21QbmJRaWkrZjIrcmp0NWFKdTF0ZDk0MGw5ZGRnRW9BZnd6?=
 =?utf-8?B?YnZoWm9CR1puT3FBVzZVU3FhL0J4Wlg4RVNiZTNlQkVybWpFcFVnT01iOXgx?=
 =?utf-8?B?UEVtTk9DWjdFRXphdis4a1BCazYxbkFuWUFUMXVZbjVHZnhsak12WlAzV0RB?=
 =?utf-8?B?NUJaWEZmZW9acGxMWjhjODUzVkp3UjlSUUFUUjBSVXdNVGw1SFZBRXFzRFBI?=
 =?utf-8?B?ZVFjRlc3ZnlTeDdYejNvbG54aWt2T1RpZmhQVnIxL2E1WnBmSjBxSzcxWk5E?=
 =?utf-8?B?enY4Smx5Wkw4S0RmRXhrUld5aWpUNmdZb3NERkVkMExOakU4OXVxc1R6bXVO?=
 =?utf-8?B?YWdML29FdUFYOXpOS1VEd3dHalVGZm1uR0VWalFBckRQTno1TXFOSXA4RmRn?=
 =?utf-8?B?cGt2UTVqMjQycE80aDk0SFRnV3FYV2NiYmJFOExLYkVOdDMwdEt1bU1QZjBs?=
 =?utf-8?B?R2crQjZhUzZkOU5hQXh2b3Z1R2JwUzJwRFg2TkM5SytoK1krZjBXT2ZDait6?=
 =?utf-8?B?NG80Rnc3NTcyTGc0Q2IvdXJVeGZ5SzBPR1VOUmRUTE9TQ0FpWGF2VDc2TGdN?=
 =?utf-8?B?eTRERFRKMWFGNkdrdFhaZ2l0c1lpL0d1L0hTWGR3c1UwMFRsNHR1QXY2OW5l?=
 =?utf-8?B?T0N4T2tTRFNuNWFVZy83K05mS0o5aVVZa043RFloU0l0dlVaS2Q5RWUwcTBR?=
 =?utf-8?B?bGdhanQxUFhIQXBWTS9sKytQc1ZjSHF4VFpmTExVaytWa3FWNEdDbEJyM0xv?=
 =?utf-8?B?VEFDN3dQd2NBdVU2QkVhSERvYXQzdU1pd2NaNkZtSzdLenFSaWZvaDhmSzAv?=
 =?utf-8?B?a1RHR3M0ZkZlUzcyaXhtaXFBbXFwRS9lOEdZellBYWNvdXRlZEJFSjA3UjFY?=
 =?utf-8?B?bUFWSndwcFpheVF0TjkwRjh4N0RuaDZ0OGc5MGptYVlBeXNWVGNYbFdRMnpI?=
 =?utf-8?B?Y0g5RVF6V0xaSlIrNnBjLzVnZ3hYRFdtZUdnMmJIWGZSTVdQYUVwaU9rMTlZ?=
 =?utf-8?B?eUpUaXB6cUE4bk43c3NvaDBwbmZvOWVJUzBMdHBmdDNKRDJWU2FkRC9EVTUx?=
 =?utf-8?B?M080amVxTGdRMG5GYWhHT1V6OCtaNDA4ZkRrTGE3a1JDSkJQUVY2dmlzWmdt?=
 =?utf-8?B?ampCOHlTZzNORTlnbmt2cDBWcU5ZZUdoM3lvNmVLVzZEUXNOV2YwVjAwc0RU?=
 =?utf-8?B?VUFwaERvUW5RaHJVaXFNdFZYMmtmSC8raysyZGg4MmxSRHBGQ29sY2pXVUxF?=
 =?utf-8?B?cWxrWDJvdXdNbmhMMURzSWpGcThDYTBmbmRzRXF2MWtOS29QUEU0dGg3b0xx?=
 =?utf-8?B?QjRDanovaWlSVDlHbUJvL3ExRjZJRFpDL2tLdFI3aFBwVTRjL1pvRkFLejQ3?=
 =?utf-8?B?b0Q5clNFVzRqcXc3TVAveS8xWm9rbURtelRNQlkyaWR3aTU0MlFheGlTU1pJ?=
 =?utf-8?B?UzdIMjZPVXNXeVU5eVFnY2gzMTNveUozc2dsQUZGZmVpUXErc1J1SnU2QnFp?=
 =?utf-8?B?bi9qMnBQL1NhYUx2Ui9Vb1A3K1o0ZXJ5bkhESTV4cG1CRWUyV0w0NkU3SGZW?=
 =?utf-8?B?cDk1NEZhQUU3OURwd0RtSDB3enZQeXBzeWNyRTJJdVBPSHdmOWY1elM5bnRY?=
 =?utf-8?B?cHZZajJJd0NodUJQOVdaSjNBREEwSzZlZEYxWmkrL0J4YUF6cC9ZUVdaMkdN?=
 =?utf-8?B?Ui9Mbkg1dmZkRk9nTVQvMmYxeFY3YVVBYlQxUEdBVmJsVUY2ZmlTRnJseGVM?=
 =?utf-8?B?MWhNMWNaV2JkRjl6YU5aRTZKWlJ6Q0pRYUUyM3JiLy8xcUIxUlNPMUxMZkR5?=
 =?utf-8?B?MGMvTW5LdER1clo5S2VpbC9LYVJCeUZSRU5uMkZrTkZKd2ZsNjdDZm16N0x6?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2411a9-95bc-4816-93b1-08db81db5e73
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 06:52:18.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0V9IMFrrRj9ZpKfKDJfLXw42iG7KptrCLlcWI5e0oh44wSCI+gNDsczQvcrTP6UedoQISLU5XS0BnR0qrP+0FqCV8W8bzYh609vSIaR0dE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4952
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 04:02:59PM -0700, Mina Almasry wrote:
> > On Mon, Jul 10, 2023 at 10:44 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Jul 05, 2023 at 06:17:39PM -0700, Mina Almasry wrote:
> > >
> > > > Another issue is that in networks with low MTU, we could be DMAing
> > > > 1400/1500 bytes into each allocation, which is problematic if the
> > > > allocation is 8K+. I would need to investigate a bit to see if/how to
> > > > solve that, and we may end up having to split the page and again run
> > > > into the 'not enough room in struct page' problem.
> > >
> > > You don't have an intree driver to use this with, so who knows, but
> > > the out of tree GPU drivers tend to use a 64k memory management page
> > > size, and I don't expect you'd make progress with a design where a 64K
> > > naturaly sized allocator is producing 4k/8k non-compound pages just
> > > for netdev. We are still struggling with pagemap support for variable
> > > page size folios, so there is a bunch of technical blockers before
> > > drivers could do this.
> > >
> > > This is why it is so important to come with a complete in-tree
> > > solution, as we cannot review this design if your work is done with
> > > hacked up out of tree drivers.
> > >
> > 
> > I think you're assuming the proposal requires dma-buf exporter driver
> > changes, and I have a 'hacked up out of tree driver' not visible to
> > you.
> 
> Oh, I thought it was obvious what you did in patch 1 was a total
> non-starter when I said you can't abuse the ZONE_DEVICE pages like
> this.
> 
> You must create ZONE_DEVICE P2P pages, not MEMORY_DEVICE_PRIVATE to
> represent P2P memory, and you can't do that automatically from the
> dmabuf core code.
> 
> Without doing this the DMA API doesn't actually work properly because
> it doesn't have enough information to know about what the underlying
> exporter is.
> 
> The entire point of DEVICE_PRIVATE is that the page content, and
> access to the page's physical location, is *explicitly* unavailable to
> anyone but the pgmap owner.
> 
> > > Fully and properly adding P2P ZONE_DEVICE to a real world driver is a
> > > pretty big ask still.
> > 
> > There is no such ask.
> 
> Well, there is from me if you want to use stuct pages as handles for
> P2P memory. That is what we have defined in the pgmap area.
> 
> Also I should warn you that your 'option 2' is being NAK'd by
> Christoph for now, we are not adding any new code around DMABUF's
> hacky use of NULL sg_page scatterlist for P2P memory either. I've been
> working on solutions here but it is slow going.
> 
> > On dma-buf changes required. I do need approval from the dma-buf
> > maintainers,
> 
> It is a neat hack, of sorts, to abuse DEVICE_PRIVATE to create struct
> pages for the exclusive use of pagepool - but you need more approval
> than just dmabuf maintainers to abuse the pgmap framework like
> this.
> 
> At least from my position I want to see MEMORY_DEVICE_PCI_P2PDMA used
> to represent P2P memory. You haven't CC'd anyone from the mm community
> so I've added some people here to see if there are other opinions.
> 
> To be clear, you need an explicit ack from mm people on the abusive
> use of pgmap in patch 1.

This thread is long so I am only reacting to this first message I am
copied on, but yes agree with Jason anything peer-to-peer DMA needs to
reuse p2pdma and it definitely needs in-tree producers and consumers for
all infrastructure.

One piece of technical debt standing in the way of any proposed
expansion of pgmap usage is the final resolution of this topic:

https://lore.kernel.org/all/166579181584.2236710.17813547487183983273.stgit@dwillia2-xfh.jf.intel.com/

I am also generally reticent to entertain taking on new pgmap
maintenance. I.e. now that accelerator memory attached over a coherent
link is an open hardware standard (CXL) that addresses what pgmap
infrastructure enabled in software.

> I know it is not what you want to hear, but there are actual reasons
> why the P2P DMA problem has been festering for so long, and hacky
> quick fixes like this are not going to be enough..
> 
> Jason
