Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ECC355F21
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 00:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhDFWz7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 18:55:59 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com ([40.107.92.85]:45355
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232452AbhDFWz7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 18:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuzymBtgQmh3J69duZD2bqfdW3D3ASiOroVykRvrSf4oWSTwjerjipT7WeSlPKh6+U48KQhA0TPoHvJvX7S+DxNpP4JRwMQD8sNkosbFepU28lVe7ACFvgKKFjoxJfOO70EeL6Fy3Q0CxltTvW9AwJ0MOuimYFkKexcfe1HoVwgb50tfKloJAmFxThWMFM1apxZnc9uwahNf+xggyRYfXPeffcOC0a+kBfCszdFIxxQ4tOy0u7cL77o04TAslWYraHCMeQpHFGwgHmTo/Dn3E8OzJSzyFG0bze3rCZCB89046dp5Ft2e1/dcohxNMmqGoGJOOgOZvhTl21Zp5h35AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENZY/89vgFJKGWB3hxQ3xVGI2PG6GD3t9NtdRokbOAg=;
 b=iBjDY4zmFu/MSv+vILPCUADKRAbrNhdmu07f+jjud+Vpm8vQ4fhtmtxHyFTfokfRzyhVg2wrhqb0qOKJ65zanMNuN9xu9uete4uuHb3MojJWMFrbfQ8VMS/NvRoDmB/GLI+PtyMosGNTm2V5lDOshoAEvw/QBTPJhMPbV2qBU+SVv57+GFXObDbNbMDohGQP9JksYIMS25JuT0eCRruJwSS5PogODufVIZB9XurGiX8tn2+XUlWdkK6LpM41gUdlzzwYRM4xVe69kN2JllVRIvzKYHXOgVikapYKiOprGlmlnEgsoGkXBLec59Ih5G/xX+s+E/j81i8gVE5MUkjBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENZY/89vgFJKGWB3hxQ3xVGI2PG6GD3t9NtdRokbOAg=;
 b=p/DT4d6lv3ENgUP095aoNe4iwARMLEMeoez8tYZQH60GIxd7XKrCY1wQif3sHhVgBdZAnQl+CJthqqHQdMLmYASOh9FEMZBtLhSVoO1vxLFOf4HREVZvdvjR5UYQ6C3xyUpP7fDazcLwlEG36S9tYF6XgGI6ZtSuWmszRpCcon1W4wjixuZIX3y/klK6JmxjWjPEcE5ahLd26n/I2B0q3Vq+Pbr1MTOT7XgicNQC7JfcMfdltWVU2pOUYrHE1iXY0rk4jTWJI3Tv+WP5lDdUvc3ycMTzVvqwYl8clkQuScsqHqeMHUbTkR0uArRSdIaJm0br2H5mE7ubvZlUSvSsaw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 22:55:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 22:55:48 +0000
Date:   Tue, 6 Apr 2021 19:55:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] rdma-core/i40iw: Remove provider i40iw
Message-ID: <20210406225547.GZ7405@nvidia.com>
References: <20210406211728.1362-1-tatyana.e.nikolova@intel.com>
 <20210406211728.1362-2-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406211728.1362-2-tatyana.e.nikolova@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 22:55:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTubr-001pK4-3x; Tue, 06 Apr 2021 19:55:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58bf866c-e154-4efc-6100-08d8f94f1e82
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404591E05F31F97558EB5B5C2769@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: of5UpPoM9nbRXjOjyoA1F+FU4x7qqyteuXENo0NSw1RPt3NLEkWdPkZEDF6Tb+cvIfpm//fZ4BgfZ9IkaLBTTYZE9B/XPz9ksLnh5WKMa+rdZBwYaddJaGuFKRjsJ5zK/UyrMIcQgK8TuznQU+I1zzEoEYWPTLWoes/aS8arNM+uHFWUNzP3aCUixCDbLBd/QEB13632mvvKP4OSG1UiBUJv2bt82PnrEU0llvvPVqjye5eqAxjB5icCEFg1ARVOqEYGkIp2UGLqMOhnrzXKUJu+VQE5jpUYz4pxjisng/ntTEaFVy7/X/U8DilHk2YRZqieFbwvdHX/twBDee74eeZHXIyOnILdiBtc8kxPxmPos5AvH5cDwv7NnYncIZDvFRe1g4V/yK3wHPTPrPh452dC6eOe9gNRlVUoZDnUObFgyMp/9u0YRqfT77rrJM/wQToqNmUX6DGITlHs8O0z3H6bI52ARqx81TIOXE8aJNMxAZbiheOuzMCmr2D5Tlaqbgg5g9xv9qN6w4M98yYW+vppoyJ8imdMPzpDapjwB4WY4MDbMyHdGBI1IpSb1Q5L+NqD6pKIHTPLDkPijhJryXoQM/uXwEOeNeZ/R8ys88rDS8AkfvcGLLFyFWN5sVy6dzTiDZp9Uc6p7b8C7G/+qEeSsiSLJusidQHYVAC17VU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(19627235002)(4326008)(8936002)(8676002)(2616005)(426003)(316002)(186003)(6916009)(9746002)(33656002)(5660300002)(66476007)(66556008)(66946007)(2906002)(26005)(38100700001)(83380400001)(9786002)(1076003)(86362001)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fUFIOMvRVjtoUUtaK+AboitCRKaqQbVZAB7ArKMJMhdDoQpqEWno+c1/iU1O?=
 =?us-ascii?Q?W2P/smpu+dbz5rj+m2dQlffVlW0SiRT4xTu0u58dzl0BB5r4u0Sf9Y9okBPR?=
 =?us-ascii?Q?VvdFa5Nnc5m+S8rwqFr/I+qUf0TC9OZ0WXSQ2jAH0NuoNQhXsJnEaStDnOBy?=
 =?us-ascii?Q?LU9dAH2jFoFCLO7Js+YFjFa091DySFYB76If7gyiHdgFij9X5SmjU3XK+zIa?=
 =?us-ascii?Q?Rn5xXUIPX/mqRzkKO2BZHikim9ZjNy5EMcmmWTn9VeinWHk2yvruubJEDQ9L?=
 =?us-ascii?Q?F6dnwPBrFseHCn/fLbfPEZMNgRbcHU3/HwCzcH4KpoQWrOJsp9fE9rE89Ph+?=
 =?us-ascii?Q?hrS1BJEPNWMGWGABSVx/ABaZdJey5diOmgSpjBO1F/FwaWiyfpO09JCXGEnd?=
 =?us-ascii?Q?hdz/7XS6CeXQ99cSTWS7hz8DEDgRZklXx7wrVgjLFbkNNg0mhP78jNkPdUEO?=
 =?us-ascii?Q?caD0hoaKO7X4ozsaxHz6E+RGjaVtJdKMKpEZdxDhd1FfSmMw0FuCTGUDDw/U?=
 =?us-ascii?Q?Zh11fyPW4CYWrFV7uCeS7QqBrPGDBaCyor4nN0RBZ9a5jFDVGXDwxHpPqS+h?=
 =?us-ascii?Q?L3tOLAHTA8Ye/63Zv7C7P6rLlG+JfYMZzaa4m1lKAM4LERd4fU1lH1aCDdgz?=
 =?us-ascii?Q?/gqhuIoQ75kLh9wt2qem+AYgdkRCT4RCvi8r77UfIOaC4hWDf9rEsRpYrwl9?=
 =?us-ascii?Q?7CllUjGG+pNrpc3uqyv6lmiFkH68aVBZYk3yVJGeVEjxUQHcn8oA6zM1yM0Q?=
 =?us-ascii?Q?u5Lrqau1sstQhAlWyAOIIq2rN2JF1bWK/AXp2F53fx4D9uhKf3UP+lkeMi6C?=
 =?us-ascii?Q?TpTe6DRUHoF+zawlkR4y0rOJGDgnjDP3yOdLpYiAsFm9yJdZiOYfoFBJYxlX?=
 =?us-ascii?Q?PrOA4FoshaJNfYPFJ0MA/iI4VxdKUqbDn5CqMhi0WQ3iSo0Dn/0K/ICbjWKm?=
 =?us-ascii?Q?zs0j5SRqg0qRpSP2dVjOkGnbIetfYaspLYUefjBlY+0wJoWUNl0Xe1pLsIlI?=
 =?us-ascii?Q?aZD+YX6I6rOFQZ20h5pw8DbH5gbomQ0gdLJVkj3WZ5qw5ZXRYLI5M821qZPH?=
 =?us-ascii?Q?VlcyNllmGVahoXsKB9UfqsnugU3NKHKl77XlBI7srTeM2lnkQvr7xCIJn15n?=
 =?us-ascii?Q?9+LriuRR+rH/fsZN9rsTNzfCHvABlbBUaHCTmwqt5d+K4EZWGfjGSFvlHfGn?=
 =?us-ascii?Q?NcGmTMuKGcwSG/D9nrhEEunN4fd7LXgvJG/qYJuz1g416Fl5b7MkeGx2uOmd?=
 =?us-ascii?Q?ryOO3uiLeItPATlu56RaTK/IsJ9cSAiBKBQFjDPqCCcCD3WnhzLQ5C8shdmu?=
 =?us-ascii?Q?Yl9aOq/J1GGiRruI+LxoDBUUTFn3buDGuamI/G4PAz7PiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bf866c-e154-4efc-6100-08d8f94f1e82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 22:55:48.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGWT9GoRN2wnhsdD1v/ri8h+vYCAbbYgkoIBOQ+C71OEkZq5vblyDPSvO4P3XNZc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 04:17:24PM -0500, Tatyana Nikolova wrote:
> Remove provider i40iw and set up the environment
> for its replacement - provider irdma which
> supports both X722 and E810 Intel devices.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  CMakeLists.txt                            |    2 +-
>  MAINTAINERS                               |    7 +-
>  debian/control                            |    2 +-
>  debian/copyright                          |    8 +-
>  kernel-headers/CMakeLists.txt             |    4 +-
>  kernel-headers/rdma/i40iw-abi.h           |  107 --
>  kernel-headers/rdma/ib_user_ioctl_verbs.h |    2 +-
>  libibverbs/verbs.h                        |    2 +-
>  providers/i40iw/CMakeLists.txt            |    5 -
>  providers/i40iw/i40e_devids.h             |   72 --
>  providers/i40iw/i40iw-abi.h               |   55 -
>  providers/i40iw/i40iw_d.h                 | 1746 -----------------------------
>  providers/i40iw/i40iw_osdep.h             |  108 --
>  providers/i40iw/i40iw_register.h          | 1030 -----------------
>  providers/i40iw/i40iw_status.h            |  101 --
>  providers/i40iw/i40iw_uk.c                | 1266 ---------------------
>  providers/i40iw/i40iw_umain.c             |  226 ----
>  providers/i40iw/i40iw_umain.h             |  181 ---
>  providers/i40iw/i40iw_user.h              |  456 --------
>  providers/i40iw/i40iw_uverbs.c            |  983 ----------------
>  redhat/rdma-core.spec                     |    6 +-
>  suse/rdma-core.spec                       |    4 +-
>  22 files changed, 19 insertions(+), 6354 deletions(-)
>  delete mode 100644 kernel-headers/rdma/i40iw-abi.h
>  delete mode 100644 providers/i40iw/CMakeLists.txt
>  delete mode 100644 providers/i40iw/i40e_devids.h
>  delete mode 100644 providers/i40iw/i40iw-abi.h
>  delete mode 100644 providers/i40iw/i40iw_d.h
>  delete mode 100644 providers/i40iw/i40iw_osdep.h
>  delete mode 100644 providers/i40iw/i40iw_register.h
>  delete mode 100644 providers/i40iw/i40iw_status.h
>  delete mode 100644 providers/i40iw/i40iw_uk.c
>  delete mode 100644 providers/i40iw/i40iw_umain.c
>  delete mode 100644 providers/i40iw/i40iw_umain.h
>  delete mode 100644 providers/i40iw/i40iw_user.h
>  delete mode 100644 providers/i40iw/i40iw_uverbs.c
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index e9a2f49..ed43f59 100644
> +++ b/CMakeLists.txt
> @@ -666,7 +666,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
>  add_subdirectory(providers/efa)
>  add_subdirectory(providers/efa/man)
>  add_subdirectory(providers/hns)
> -add_subdirectory(providers/i40iw) # NO SPARSE
> +add_subdirectory(providers/irdma)

This doesn't seem bisectable, why did you organize the patches like
this?

Jason
