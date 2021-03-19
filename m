Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE35342746
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 22:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCSU7z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:59:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:9413 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230235AbhCSU7e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:59:34 -0400
IronPort-SDR: 0sVeGLP/T05b0GX1BoFhsp5Ib8Yrg+8EtPz6DaypXSjKEg5B7riMez/Jpciu261wVob7hs7w6T
 kbD8Fn82o8RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="169902039"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="169902039"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:59:34 -0700
IronPort-SDR: RoF/4foUKE6vLrAJ0ZA3/SIJFzKMI+xDyPldCcYXKK6MQLA7k5p35eM8EFIIr7PGXmAtbDONTc
 k6AVe3uBfTnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="373186096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2021 13:59:33 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:59:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 13:59:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 13:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoPWYkkZhadfaF/KX1jZbS5E90kADoYN7mz/IRWQc9jKymJylv/zgwkUw3XpZIV4htjyscbEyL9jyCDjPgRuctw02952nHVtauMQ0YmbkwzKelztDtw1tj1pVliUgP/cU/gZal+cE0OvmRXXVyMts1HnIw+hqKx5JJXO3ZqdvwQ6v45ICwByzILevxVlK47UUx/CYA2TYHGNWM53O/DWZIOlPTi++gLrRfah+8nFkL+V/wSwdagV8BLeVvg5NdgbNp95RWh6FIIqLpNoRJ615M7G8uIgjoo3NNo1K7k5w1j2ZCwX/RTqCr+fziloGjhuS91YYb/zEzHKcaLpiENpyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AayoIJS0aTe8XjzyhcpQ5t6h5hKvPKYVivz03gUts60=;
 b=fmDxVpYZvS4jGQKpvz1g3lDmUnJckCh/TuEqYXv+FOKh4QRJe9f9mi88MoFhyZsRPG8skcpH9pDhSrCeyLpd7DnrO193eccNKwYsTm9gXUPHu66/7aA4Cj1u0LwTbcbQjp9yDttH0WYM11hiIoE2gBpsBCz16WudopLESvzuBjmgTUFgXsAwn8IRR7PK5khuwYrR4rGDI51UF/lKbtyorZBzQeO94ZtaTEMryiGaD8vHVe9f25DtE3QRj/Tuf2TVlZ908lneVLvcOEZjWuI5AcLx5GI7tujRlL169tgxgKvD7GlW5Pbb7/X6iWn9AhHhOjWMaAA74x61folTExSHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AayoIJS0aTe8XjzyhcpQ5t6h5hKvPKYVivz03gUts60=;
 b=j7+PwxDS8UF2Vl4A0gQSVD1Vsifa3GoNSy/KApiF62L1fn679VyhyfHjkEuqWmLi0PeVK4hVx1UQ4dGMFSCz6Ke4Z4PjW3SJtxhP7B6uPw91OLSPMAZFUxAPU+JoAkk1SiplNqb/i65husbfrbYSHy8tMN4mIcy9pd4GRK1r3yw=
Received: from SN6PR11MB3311.namprd11.prod.outlook.com (2603:10b6:805:c1::20)
 by SA2PR11MB4969.namprd11.prod.outlook.com (2603:10b6:806:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:59:31 +0000
Received: from SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263]) by SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263%3]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 20:59:31 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9OhYUmp6U+V0qfjE0DBnim76qLVNwAgAAMHVCAABQIgIAAO/qAgAAGJwCAAAexAIAAA/SAgAAFugCAAAIfAIAAAPRw
Date:   Fri, 19 Mar 2021 20:59:31 +0000
Message-ID: <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
In-Reply-To: <20210319205432.GE2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [96.227.240.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b392bf5-865e-41a1-82c2-08d8eb19e4cd
x-ms-traffictypediagnostic: SA2PR11MB4969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB49698DC7E9188617A350ED9EF4689@SA2PR11MB4969.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKS28rDqYs3bDowNvBwbdO3CM4z4T3UH2oJkbMH+KHYP9dLb7g0huOAQaFK/DICDt9qEL43Fs59bP3+f2aaa5Q8rnsYOMcimv/shUeCD2L6vw76gdl9RpYx5PV20lzcer8UhDGtwMBF4akgbfp9jaA5Qa/vmgn13kGQmRrpUm+i/v2ySgcP0RPbtDcp1A+mFKzeh3b3knbwP98kryQOT2msuHKPzIoBrU5Y6c5c+xQKUJooQy3P5CQUFWfoaAJM9n1aIZlQu5KpbRqxQA6apbV+YezdXkmxe0t3/CwngSD1+cXY9CvYIka94H38bcsxtKtE6INYenkXYyZlr8H6gpFdJwbFxfPABN609MfH5eCMC+Etor68PlMlxG7p2DzSksMGHK3BcttJZ3pwMrhHmQo9iiy2kmNqXWuPH+czSxqBY08MQZcmEeDJjvemIl/qxJsvfTRKetX1GIhxyXkeysb02ZfgftOjdVoX6BqlCUHDx4YIW71+6RSknPJCD6+yvQ60mRjcThbJ/ZOAagUMX/r+cIrkREWK1b0HNYqbJ3RNaEOwLNbkx3ah2GIOqzX2OrBAlbJuLPP1XQJh0TeYTWWsQ0xQccj5IsD+LFSpX83lWKBx7ZmdF8HfaNjl96tEdCoGfjgS0VUQHXKCmg8Yx/NgDIk9btM18J4VbYxrHTuw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(6506007)(53546011)(186003)(7696005)(66476007)(316002)(110136005)(52536014)(26005)(71200400001)(33656002)(2906002)(478600001)(86362001)(6636002)(4326008)(76116006)(66446008)(5660300002)(38100700001)(8676002)(64756008)(54906003)(66556008)(66946007)(8936002)(83380400001)(55016002)(9686003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ldFPVUAiWruGnY5A20JtVnBw5YuMqjtfnA2fMoSP5sC4e4kXrNdJ2lKQ8roP?=
 =?us-ascii?Q?HivuYk6BGfylxA9bxauGmtm/UDanI/FVYptqfZ6xXnQ+LXETXA7i885kA+Gj?=
 =?us-ascii?Q?9sHnL9E5aQA0ZdgHz5AdquOkPTJmI6qcS9ywA0JG/hZSEKEfH52f8Vh12uA5?=
 =?us-ascii?Q?FNPlhdfckUaY7ON8gaoj+3Cb3xaqyOC6ZZtbSTlma1AmRdqf1pqfAM34HsMV?=
 =?us-ascii?Q?fnPfmpLWQuMXZWS5Al9+jkQDnEMrHsMoMTen6OcNM4ZShh0QBJShVwvQgrIH?=
 =?us-ascii?Q?5ZfnI7lxaS3+twVLt/o6SqTvFsL9pZDBz21Djt81lade08DaHIK4JGDu7FVf?=
 =?us-ascii?Q?zjfXosXa1AW4e7Au0ggHiuDMWDuxwu4nluXvGGj1UCOAs4hoSDh64FlK8XYE?=
 =?us-ascii?Q?zigh2r1pFAN14Zjk4yP/XILKM89KQPZ8FJ7ufATrbU5tFWUv6QL57LcVp8F+?=
 =?us-ascii?Q?j2THXdMV2f0ySf9WD/RTi4UR2zT81zYCS1SwIPwrN9Y9vLB0KCaVWGlddGd6?=
 =?us-ascii?Q?0I+XjZvQwGVF1HBVi8AcMOyQAvSZoJ9ssgojqah/u3acGUwRqigj2tj05Et0?=
 =?us-ascii?Q?oC/XRZwz+UAblxZogRdCJWPxQWDWfkDlH5fypo7iaq2cPSz/JTCdO4yOPUiE?=
 =?us-ascii?Q?/BR1UA50TqsH+cjRKHXYDbAcCuGMkc3xxZ1+YVPf/ZJbWiYgb7+2p5GZJwND?=
 =?us-ascii?Q?I4jrSNae658WR+3BP4R41DgTmVqm7bb3hNQXrMIar07wK9FzPC1X728UwWzb?=
 =?us-ascii?Q?2S3LU9091DJvPRgh62yXJwwFbD7L1oIIVidaYrERJTJGPEMCBlkwlXZ74qMY?=
 =?us-ascii?Q?+UOaG7ZGuSD6ry33IVUv77ITHmAVrQCGnYBQglSRtzvsEZlT1kQbE+5/Z6Nj?=
 =?us-ascii?Q?BZhNb6V5S49SblQxOXm18dWOPTtYnLGZgVM5wKwCyI93KdWEA65Wenw33EhZ?=
 =?us-ascii?Q?4s0ZuAELpjC31NTqgtLvPzP4N/ssdhr9MmudezDCKuejfPo1TLOPLNbGV7xB?=
 =?us-ascii?Q?+Zikuh1D3H15RqcZo2PFi9ohtEDfrisL4cmzcdKxYVL6CAqCR8B84HN+vu6W?=
 =?us-ascii?Q?GGiYJemG6BnUN4ySuZFXGaon+TgWsOk+P8khEASw3Hjwbw3WV/gdVcO8hzeh?=
 =?us-ascii?Q?3ige58jPXyvTbOUCIANfHmyOEz6ezFkbV+7JVfM9I8UHcrqAEMLwAAVS6OSG?=
 =?us-ascii?Q?Olz7TwgVb04Kz9rC+n5XODOWicXaiuvaHoQAFD+e66KE3tRp57Uiao9A8Cpa?=
 =?us-ascii?Q?to22VPpIggroe8OrZjE2jV27cJ8bg/8dKYWHxzuphlT3PBKzKg5L+BEoQ66q?=
 =?us-ascii?Q?Ixwja/2X+fCpqytAH9rsGomM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b392bf5-865e-41a1-82c2-08d8eb19e4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 20:59:31.7515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIx+wg3gHtTE7oeYQek9CiPPAwzSQGuXW3DI5C7gtbfjbVv9dgq7Z06CQrBlb3gRA7flIMC6gngZDlcdXWRvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4969
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 19, 2021 4:55 PM
> To: Rimmer, Todd <todd.rimmer@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>; Wan,
> Oh, there is lots of stuff in UCX, I'm not surprised you similarities to =
what
> PSM did since psm/libfabric/ucx are all solving the same problems.
>=20
> > > rv seems to completely destroy alot of the HPC performance offloads
> > > that vendors are layering on RC QPs
>=20
> > Different vendors have different approaches to performance and chose
> > different design trade-offs.
>=20
> That isn't my point, by limiting the usability you also restrict the driv=
ers where
> this would meaningfully be useful.
>=20
> So far we now know that it is not useful for mlx5 or hfi1, that leaves on=
ly hns
> unknown and still in the HPC arena.
[Wan, Kaike] Incorrect. The rv module works with hfi1.
>=20
> Jason
