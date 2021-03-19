Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222BE342025
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhCSOtu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 10:49:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:55211 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230482AbhCSOtc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 10:49:32 -0400
IronPort-SDR: tjtOpf/Z3pC0NsEUAMQl2l8+tPRQai8+4gfXnDTFX3pOO8B03xHTM+G95BQ9HpwCaCgJKe0sWL
 Kqmw53bz5LfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="253906896"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="253906896"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 07:49:31 -0700
IronPort-SDR: 9KEufB/3c0kJqxm13goI8f//u0Ls8BQGXXotxpvNh3LO59weyYpymeGNwXEtcl6/XP8XdQLhnR
 0L9vXN3AW0TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="440082248"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2021 07:49:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 07:49:30 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 07:49:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 07:49:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 07:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANo0gmMhn9Kzxi91uki7Qm6+NVt+LDqquOQiNBmYm9UfTJIzy2M8H95AXArKJGLp1n/UMOVDcvYYKpQ7XvVkcrMJmmdcfSoPSDmEBkQ6fn+zG4hWRhND/WNXyzIm8cXwxTdkUmhN7a0sfRWVHktlv83TlBBks8/7RBxcPqrjlyfxMzSuvXZs37OltB/p5qIvZrVT40GIHDfcM4WJrEhj6DQkivPoA4HMsD/pdMQgFW28VHO7OF7efr+asexa1r2SCeg6/vQwh9vb+LjJSxY5HVYmw2lqDMWQGS3FKbXxQyfgX233ppo7dZUaaTFbr2utearLkmyuyHxP1YnpzCZjIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0t45Kvkwvu94fIs03O3vqOzqc5GkWscJ90KH8cuUVU=;
 b=UNPO1BdekPh1FMFHzzDxFJG951ElxaOq13Xrm+nDljeiulDXEXV6tyBQdkSKs7htDDvUGxXqDaM9nxVeRPbsxjK9WI3Esgm8mVscEU2U58rj+AC4UmNNoFlXQNPWaAvXeFClJbfIRarhwQRXdWR0OYmsfWetyc7twX0xkilO0PQGOoGXpKditg9fV500nr5eMDoRVqFrrfgzp6YVYzqWhgfYF2lu0TJdAyOezJGz2QAiAisFZL7hUkreg+By4NvMtbep1RFV5PgJovPEdojpDzzDAGaBQvNonBQaM/uWze7UW60wL020RJFc4UFwMGBLxMQeT4AvGo4lobJ1g35QTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0t45Kvkwvu94fIs03O3vqOzqc5GkWscJ90KH8cuUVU=;
 b=XaxIxoE7xsA8RJbf9A4hWRPlvscAqdGDqg4OMIEnUmqVvcXZzer0UJrXzBsK1yswxPGxzKyzVKk6n6/oNJJ6vh3W+5SAyAy5uxHHwIZpiJyX0jCssg2EJTO975rgAa8l2RhXWjiAPW0DP4DptzqZQlMR6Acwb6Ok3BM9Bb9XXpE=
Received: from SN6PR11MB3311.namprd11.prod.outlook.com (2603:10b6:805:c1::20)
 by SA2PR11MB5050.namprd11.prod.outlook.com (2603:10b6:806:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Fri, 19 Mar
 2021 14:49:29 +0000
Received: from SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263]) by SN6PR11MB3311.namprd11.prod.outlook.com
 ([fe80::4505:558b:8f6e:4263%3]) with mapi id 15.20.3933.032; Fri, 19 Mar 2021
 14:49:29 +0000
From:   "Wan, Kaike" <kaike.wan@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9OhYUmp6U+V0qfjE0DBnim76qLVNwAgAAMHVA=
Date:   Fri, 19 Mar 2021 14:49:29 +0000
Message-ID: <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
In-Reply-To: <20210319135302.GS2356281@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 7dcf48a3-a1c7-4d26-b1fb-08d8eae63356
x-ms-traffictypediagnostic: SA2PR11MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB50508631A0B984EC17BBF6D7F4689@SA2PR11MB5050.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KrWvzJPdppaNGEbfqh+7w+hCY/0oLGVFGinYMbX7N0gmmThOO/iddxBcT7kMu5ZM4yW6PGl/XIUisdo9MPKDCelp6DhnkIqNsiiCoLjqaMPDZ4yWJ8M87Ya19Q1UkVJaKa3ZfmRABdwsTgtBw/yjHpQA4mCbmo2OczXJlrD+3Ud6peTaByuc6qWmNruJpYSVMjZULwYdR1wgu/w+R17nvOP5z9x2eyljMondSYwKTVPr/nZNCMMDrbzrwUD7LI3WlSJf8ik2YDQhu2B44GLyMbrlk3iahE8GfeevBW198A7My3YOZEMqOJOxQ8ZOuGn7OR2+hfAUTcY+z8hC1cBQ8vJ0/w/wHbBV3dEqze++FEQfI21lOCmfF97bZxxqMuuunrgtK+gKLriCU56Vox7pxmJiUMjfSTF1BPVSh+mA7Pq77eDBLfdyayOU9WgxzDNSFyvov5RwgAeWedg1jeO2k2YCIHMA90zJ0qKWLMHoF1xo77E1eVr26b0gpjH0uN7ALhVc3mDAWWl1JZfYe3xmMX6E+R1g5i3dz0lih5GfebqUqNDmKHtIbdN9OEw/oPX3hg4reoLUhcrUt4E3bPKUUB6DS+r8TIKVnBE3FFDQkwnfeVdwigQN9w9hgSu7PIBRoIk8qa6nVJfGy1qavs1YEhxdVPRAHOhAo0SuqK/cS+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(55016002)(2906002)(8676002)(64756008)(66556008)(186003)(66476007)(9686003)(316002)(54906003)(478600001)(26005)(66946007)(8936002)(53546011)(71200400001)(66446008)(33656002)(107886003)(5660300002)(83380400001)(7696005)(6916009)(6506007)(52536014)(86362001)(4326008)(38100700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8w/aS8/HCg/iLWwidGmGuh+q4k4pIOTZ5JlJSFUA2loWnQXMEt4WIMpLHp09?=
 =?us-ascii?Q?dbztY3ZZEgbDdfmNPPqqak+7F/Y0YOS0f9rm5bY0hF0hvfvPKnsvVQJtVoIc?=
 =?us-ascii?Q?U2w0m8z9SU3JW5hvsQBDtfmrQlh/Up6yPYCsOYF2FD0Xd6mjAfbmBO1B0dyf?=
 =?us-ascii?Q?5/lRXRh7U+z0CRL/7TcSygkrPzigSbUnoPiw1lMSO2D+LHoVQz4YWSZCVP1F?=
 =?us-ascii?Q?88+u7pLiGOWGn5EuD020VYx5oW2VysiW0L5o6kpv8KiC+nfrokDqFMcCCybD?=
 =?us-ascii?Q?GHBvp80MvDdVFbeMiSxtXZBsTBDSSuCqBKzpWGBr4ccmLHOjYPiVzLI1sdcP?=
 =?us-ascii?Q?kt9xOcKOYCJUOUcJUaxt73YnLQI94AAZmkxUmI5I8kKpdDDMkv/Ei36hJ5Ru?=
 =?us-ascii?Q?0h85uWnMsuRmc6WqY+lxwAqBBesq+uU5Lbj7du3N4FXDUZcMAferTjleu1Bt?=
 =?us-ascii?Q?ly/xEl+M5S1V7y14KaObyCr9NAYcmtzRD6w8LChiASLnPmCt9h9nJiqMvsD8?=
 =?us-ascii?Q?13g6G0wBfVrPjHX0wV8ynXu4o9yi9tOpOfkJsWVRrUVdleKQ40CIE1soJbq9?=
 =?us-ascii?Q?w+4R7xeT47O6FVYB/J8oBtVqCVV44VC4k40FGYeWnqUC5zeZNj56Oph2Xwsq?=
 =?us-ascii?Q?ycX5KJiYjslbTPIYgBoWTD/ArKp+oQoq8VGoNjZVxTm3gfWAC4Eo9yrBfkGt?=
 =?us-ascii?Q?BkUiaKlFH+gKRks20acd4lc95Fozh9zmvOcSQb8wlCBiqgxtNfnHL4ofXtWH?=
 =?us-ascii?Q?ExFAVrgkVlRc5nVJm8SfQwQJt3S7iSI6DZcG7/YAVMkIv7+nOfDk4jeZHh/i?=
 =?us-ascii?Q?8E5tmO4z3FCUDPDYIva+tgxzjf0kHNh1PqFctv5mlf5ja6BStpi9ESTeYi6h?=
 =?us-ascii?Q?BO8/ZoHOuNHt6G3dg3An11ka3Dx0j4iJ/DY0dQxiMHvM9P7iPZhXbGvhruWD?=
 =?us-ascii?Q?0sjuiAM5N67O5DdayljvDBq7ABBIMXT68KJiz5UAyO7M2gDl2FA0TwGmBKEZ?=
 =?us-ascii?Q?NE+JB9toyIpE28aR1p1jg3lTyH6g/mrSFxdzE5h/C7vHF8SNBsX62JSoSCbS?=
 =?us-ascii?Q?ODBI8laLipjopaGOVzMFXi74B4cgrFcVJ1J+Ly8mrVF3JQ/9ukkP/8F1jH6R?=
 =?us-ascii?Q?qLakRcMnT93oZrWBZPOJ01swyXWtFWNpzSccLxqcD6M+XdB4ZvJgWdYyCYmJ?=
 =?us-ascii?Q?XNwC3opxICKDMIsTxmIhaIm4qJ/3l8HYUefYJ87Td3uPklrqBlSa/uuxJMGO?=
 =?us-ascii?Q?NbsVTacn1TRlT0oBDP05/P+3p4PA2RWh9afeF7r+sA3e5Sq2gNXtE1SGGODX?=
 =?us-ascii?Q?gBlQ5VclG/vJvPO0J+yGBAD0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcf48a3-a1c7-4d26-b1fb-08d8eae63356
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 14:49:29.6449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e61QicIwHnyuYwr9LED0LRldVfItY31lvQdJIm8fdzBrHgZgzwbramQAPhbbX65xDMrQcxojYe8drz9m1gXiYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5050
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 19, 2021 9:53 AM
> To: Wan, Kaike <kaike.wan@intel.com>
> Cc: dledford@redhat.com; linux-rdma@vger.kernel.org; Rimmer, Todd
> <todd.rimmer@intel.com>
> Subject: Re: [PATCH RFC 0/9] A rendezvous module
>=20
> On Fri, Mar 19, 2021 at 08:56:26AM -0400, kaike.wan@intel.com wrote:
>=20
> > - Basic mode of operations (PSM3 is used as an example for user
> >   applications):
> >   - A middleware (like MPI) has out-of-band communication channels
> >     between any two nodes, which are used to establish high performance
> >     communications for providers such as PSM3.
>=20
> Huh? Doesn't PSM3 already use it's own special non-verbs char devices tha=
t
> already have memory caches and other stuff? Now you want to throw that
> all away and do yet another char dev just for HFI? Why?
[Wan, Kaike] I think that you are referring to PSM2, which uses the OPA hfi=
1 driver that is specific to the OPA hardware.
PSM3 uses standard verbs drivers and supports standard RoCE.  A focus is th=
e Intel RDMA Ethernet NICs. As such it cannot use the hfi1 driver through t=
he special PSM2 interface. Rather it works with the hfi1 driver through sta=
ndard verbs interface. The rv module was a new design to bring these concep=
ts to standard transports and hardware.

>=20
> I also don't know why you picked the name rv, this looks like it has litt=
le to do
> with the usual MPI rendezvous protocol. This is all about bulk transfers.=
 It is
> actually a lot like RDS. Maybe you should be using RDS?
[Wan, Kaike] While there are similarities in concepts, details are differen=
t.  Quite frankly this could be viewed as an application accelerator much l=
ike RDS served that purpose for Oracle, which continues to be its main use =
case. The rv module is currently targeting to enables the MPI/OFI/PSM3 appl=
ication.

The name "rv" is chosen simply because this module is designed to enable th=
e rendezvous protocol of the MPI/OFI/PSM3 application stack for large messa=
ges. Short messages are handled by eager transfer through UDP in PSM3.

FYI, there is an OFA presentation from Thurs reviewing PSM3 and RV and cove=
ring much of the architecture and rationale.
>=20
> Jason
