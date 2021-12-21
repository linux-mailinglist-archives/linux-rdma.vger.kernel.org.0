Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04B747C97E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Dec 2021 00:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhLUXHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Dec 2021 18:07:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:37098 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235079AbhLUXHl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Dec 2021 18:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640128061; x=1671664061;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=fa8oT6cr6CuqJfhFwXg21FgMxr70p5iqPEamwtNJaAw=;
  b=OzOFvkxFvqpH0Sl48As23QInmrXpaOrQEZBeoxlX0agR25s7A/bodtsq
   P2c//jN8XREVzFDuM3LxLCmrahI8rAz30+c2n4d4JAEEQM/4CL5wZm75T
   G2LWJ7sKuSQnGwAKjj+W2Zbl4QlsblTZSqPCBnUTnjPPgwsVxj8hTvW1k
   daymcGz+FdlIeia41/wp9XNFYA2HNpKbOuOmJgnUr0Zh4d9+4z+JABxGL
   W36kwieoCMkjQrtt18eLYk0GTq2HvxB3g26KtU4tmHjNGNk6vyAmMNudM
   YV5wpaXCMJuE5P/ehHKuMUMBtrhihBU11Msn8x4keGasZiZZMUNjRz+3y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="301274099"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="301274099"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 15:07:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="613632916"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 21 Dec 2021 15:07:40 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 15:07:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 21 Dec 2021 15:07:40 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 21 Dec 2021 15:07:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cwz6MYWGov7d30LGlWJ8C1Kt/6KMn3VOyx0zTn0EgP8qee/1QIAedtD6DgDlBqW90bClRd6i8z0j6M0/L0BuW+nowKC1QSVppXWczAQkvP42yTrsmNPSn31vZMVGMJeM+i6QRy6FU0ifa5Lt29PK2BIVuZmEBVZ72WGjMt1yUiNBiznpU9KUhu+zUpvRq/1HDYCt6r1ZQZjdvg9ik/6ihxvRQ7dGFHe6/l0f/VAQ7rPbYUSkH17VVhHdvkGKcBC3u8Dcm6dA9Cv4pCreQPKRtGrbkG9+X5rnw1coZgDmfGv1QgfBJ/p5fJ/621hajBPYZKJy9Ov0VdOgFr9XQwV20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUvwM0+uFaW+Vh1cdP6GJLXUlgGkElvIYlVxRXqbzdg=;
 b=Vee8W3QihNHRkszpIeEs6QytIHBt05SndB6qqmkIf/RkyQV9n+OWWV3pfjNxN9azkhTEWIkfg1Ui1QW27xt1qIvB/sZAcHaENBF4rX84ptVdnzPVTPqLq1g+8ExrY9suEYCFOzNkx9psfs/JcwF/ebZ9zfUN3L9Pze6kWDSrXK436LXziBRtcTLTLk2UQpdao/6mLd0Rih1sFygx0QAP+AVlb5fIjSJzBNizVSicexLQ8MLiYFzdx/zpOu+IxvqWvIYqWPKVQSDRbkHz/tIkdWbC0qIfrAS34BYRv06eww69uknSxjQwXe0ZT+zo1RZIj6id1VdqrRQsxJaZMhMjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1742.namprd11.prod.outlook.com (2603:10b6:300:113::13)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 23:07:38 +0000
Received: from MWHPR11MB1742.namprd11.prod.outlook.com
 ([fe80::6091:c06e:b304:1ffe]) by MWHPR11MB1742.namprd11.prod.outlook.com
 ([fe80::6091:c06e:b304:1ffe%6]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 23:07:38 +0000
From:   "Ismail, Mustafa" <mustafa.ismail@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Thread-Topic: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
Thread-Index: AQHX9ghHdgtc18Y7oUKGQiug6LKuCKw9gODg
Date:   Tue, 21 Dec 2021 23:07:38 +0000
Message-ID: <MWHPR11MB17427A01EA309FF4DBBCF3A18B7C9@MWHPR11MB1742.namprd11.prod.outlook.com>
References: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211221173913.1386261-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07240000-d1e3-4f0d-8a61-08d9c4d6aec3
x-ms-traffictypediagnostic: MW3PR11MB4554:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW3PR11MB45543F1C7762391744F8773F8B7C9@MW3PR11MB4554.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsQrVqa1YseJU0znj7HZ1VilebuUrFUjPM+vpqE+W8ee/qhMEPYaC6XYG2ZW17s2OGUjoeWe4Bz3LxRqZMtsMORdwl1TgrwQj9Z8ZOzPeAq17lbluvYEoBIE/Wh+pl7n7oVnutj+0aHj3IJu6MwHQmdnAZPUS9PcBKadhQCbwQpOw2eSynKOlO3i9R34/WzQe1UebUvr/tsCHGgIoM9wA92q7Wl1Gm5EXcHfr3n/PC4axQJD3hVnM2LiCmj4NsLF4kwAUss7BkuwA5EJkCu6FsyzOJk4gvVpYO/gZkvDmyFIUDXNdEBr6tbc5JoGqfpKIFN5gWzO575msXHndHJMdaILuUFnKl1b8YYSrNX43AqsvFdDpO9y4k6bNAba/hxvku4x0rGZF8mUYN6VdmLiziobDzZiCkEocFmaaz/W0EWWLjkiKIUHz3bku4LRrh7ieAjZ4pbmRx0jkDinYfJ9nik5ifMHUO/6W+SvPUJeZbrWGCmr+cxTPafP0ajruOHtCgP0RyXNJvD4A92xb1yuaqJuIMBGyjq1EdJFUWJdHwrziRVudRa7FbcHxoHsiXZ2iuipvGWYIhGCRnpQQj54d25W0JWPWwjd4/N1bZlzAqCq0DOx/azMsEkHyN+XOQLDNOOi93DfZoWz+6j9QaZ6o7qe6HUVFFY5o0tNqpmjNWIeES/azqQxZni4R/aCMh0grZJdVKSMV/x8MfvG4RzHzNqEYZe9Jnd5dsAwK65Ctw03TBNgyXONct71mK4Uj/JzzqAQAC4KZxACJLcGXdEQ3+fPo62l+DaAhJ1Lpwd2YCk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1742.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(7696005)(122000001)(26005)(66556008)(38100700002)(4744005)(66446008)(66476007)(71200400001)(110136005)(508600001)(316002)(76116006)(2906002)(38070700005)(66946007)(6506007)(64756008)(82960400001)(33656002)(9686003)(52536014)(8676002)(55016003)(86362001)(966005)(83380400001)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O9MBGPgR6ZzLUoONT8HPLe/nMHjDTTulA9/y3KhMvkZA4G8U635HFkLI3Mi3?=
 =?us-ascii?Q?3lfKL2Bb40Vcl2Tozh6FMMtUxwrK5uLRobQN/3oNcSeM9rlIga9RUC4i6Ytn?=
 =?us-ascii?Q?Gg9wDJ61Tukg+v4Zi9kPBkZYLkN4yJucmWhkZ/8i2wng1c1r+Q6QCjza/ErR?=
 =?us-ascii?Q?lacL8cHs+VvWWwQ0Vb/e8Ek+nbNcuhLpmVTj3bqqi+FAhXB2hlabAXMHNGDG?=
 =?us-ascii?Q?jq4s4jmpzN3cbiSrXEIZz0E4ThbKx7m3TGyTG2RLqeJx6A+EUsvzRTVddD11?=
 =?us-ascii?Q?WCj9VLej0Y4G7ONNOjOg/rvX9fokf8FTf7SG/AYNSDMF9n0tst6wIcnvmZX8?=
 =?us-ascii?Q?+/sond2RXDejZX70md+eHRmmFSe/81109jeHJ3SSOIv1I7NW9//l2RmwMIYK?=
 =?us-ascii?Q?gLwbGOF3kGPdsC63C55qwSTo+ERekpqgxPMbBgldUTz6s5oEBCi9Xavep4FR?=
 =?us-ascii?Q?DCCtcql8dGHAQMhHikUpTgpZxbT51+3Atuk0YC2Eey4YwoujWiv23PKegjVb?=
 =?us-ascii?Q?0BZUfFHJDeqwRZf1JpbxP+X//BXvSIbCkDEnA0dB1X4HwFZD60Xg6pjDgCMm?=
 =?us-ascii?Q?0XOgp75M3OW5jk+4MpKrPBYLGUecuYbJBU8hEapTu3NCMpOY3wGEOQucRc0L?=
 =?us-ascii?Q?TQClgPvwP29mGgiTOgVI+RnG99kR9V3aINh1xzTFXEIfkw7E13UR/0jmZRUP?=
 =?us-ascii?Q?4yrpHAYkuJDQiTMbYFzg+my/uXjHHWGGUUNsseeJO+SOa6eAYzP/Qh35DKkw?=
 =?us-ascii?Q?w0rII2e08Q5iz1iHVt89yIWSXjrvVQ/WGdJOTbiR0+J5hWl5AQVUGAfwBfuX?=
 =?us-ascii?Q?94IcQHMLgnNQxErAqEAsDwif6Lytu4yTF1kF5aFjzZdqbwMekFg5EPo5KNIF?=
 =?us-ascii?Q?Kk8ZkQrndRQTdGPrXXqtBNdPcaEErjLxhqmnbjVnvHzbuw0ergE7GRyeuTML?=
 =?us-ascii?Q?SskEGCg5Z+76TENu7y8lfL2oKrnZ+l2y/B6aC/cWNmzrd3namMulqj3RG/A2?=
 =?us-ascii?Q?fv+e7FcUObsN4DjwkLZHLFyQZVD5fjgrPNRgOuR4jaHigMTv1u6cAE6j78l7?=
 =?us-ascii?Q?zJ9FOMtw2H4AwHTPnByULUgxpFBn2bD26JD4OBSAyOV+8MGYU2OqKcj/rTxl?=
 =?us-ascii?Q?WbkI4PRUh61TPxEHz4YI53xDJ/tY9wNuiR05093T7dKAwSpAfRNewgtePjFA?=
 =?us-ascii?Q?NbohlD7nB+2dyq2JBOqQxLFujfAqvdgs9imEk6oMIInk7N54cpV/LriJGGFk?=
 =?us-ascii?Q?3Bb4OvS7PSaA4+45D8jkWqgHvTJbV/pz4+NlvWCtGGGhyP4U1T+s8q4iV7TM?=
 =?us-ascii?Q?GSDBfFS82P2s1Q7tR7UMyvP/wkTHgWrHJt9VLHuJmtwIE7K/7tchQzRiSR1s?=
 =?us-ascii?Q?J+VgzSV2eJATbDc/fyHe7UFYgW71JvI31g20mPFU4l1Rp8sb7WpTwN8XyjmS?=
 =?us-ascii?Q?G/AQbkoJEIDC93ZI7QBq5yjALWeSdwneZsK9ueExdREexjREcfv/b2+bWHbE?=
 =?us-ascii?Q?otsMQbfEFYWbl2CZGKBozkXGPZ9KNN7HE1J9OnFM0nUCpnCzxmDPopyzAOx/?=
 =?us-ascii?Q?k0Am7sJaYRUL/BTntpZLh1KnXdhpwE9A88QDJRtLP3kbyuGdV4Sn1rXj7ZZR?=
 =?us-ascii?Q?qaweg3C5lwSOcBNdisNNxl+M6ocxZVQk7145xmb2XyqY9LBZtb++/MrO0nx3?=
 =?us-ascii?Q?WqF37g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1742.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07240000-d1e3-4f0d-8a61-08d9c4d6aec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 23:07:38.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy35JFmmbpe9Y3cSedOk0iIy427Du78DiM7H+niuAtK/gklkZZgA+e9jGIvK4qDX0ZuiMvrMc/VuIx7jy9Dc/pND9twVBKKCMKVF2YnH8AQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCHv3 1/1] RDMA/irdma: Make the source udp port vary
>=20
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Based on the link https://www.spinics.net/lists/linux-rdma/msg73735.html,
> get the source udp port number for a QP based on the grh.flow_label or
> lqpn/rqrpn. This provides a better spread of traffic across NIC RX queues=
.
> The method in the commit 2b880b2e5e03 ("RDMA/mlx5: Define RoCEv2 udp
> source port when set path") is a standard way. So it is also adopted in t=
his
> commit.
>=20
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V2->V3: Move to the block of IB_QP_AV in the mask and IB_AH_GRH in
> V2->ah_flags
> V1->V2: Adopt a standard method to get udp source port.
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20

Reviewed-by: Mustafa Ismail <mustafa.ismail@intel.com>
