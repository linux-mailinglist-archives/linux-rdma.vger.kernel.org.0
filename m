Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E137978F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhEJTXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 15:23:12 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:16912
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbhEJTXM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 May 2021 15:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCoF83T+bfjOXYE0h8HfMfN+P69/sbzY3EW5bh53NHm1cvU1r9bprpTUIyk7Zzd7Uadvuolk3Fa1yTiauYVrL6vR28AgAfy2bVPCz2uPe9DAYC8m28/NptFjW7V0WTTn0uKAT5l4CFGo06npB5ryUfb0c6g+uxLhsVmuJrE7aSII1pEB13/xkRILEdWGbGmzJg7pQQ7B9JSEWuZ7zyq+pX8NOQ+65GPxcYi076oLDdSwuDxgWGZfE6I50Oj0eAoVoSeAL2HRhWQmNiCxyYYBJ3r0NZKpjZY9IrgsxwTZgnnGOFiZKgl90tAmfoBxl0eJ4b8zZatqrQ+lkkcQ2AF5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHaqm0ezpRydeQd3pMsvveK6E+j9cFr+H0zRq99RGyo=;
 b=Ka5Al3TrgwKn7SA2qPUmZcBRJ1FQO5tPRuHjirzLX6Qrv/uT5DSFx9XuS7bsTiH0D+4P0YCBTi18cPOwOYRCpwRINhSweLVzRlmo9qcuSRObbg5EXPZ22yFPOx4p7TSVuDqL/XRmvEthG1fttlauVuN6dv1n6/I7KYuIQ4dAEPFY4aQXTuumsnUpW5DyQMehtUT2JaO3H+OVbSW4IZsFpuSFXpQ6fY2B0JQffsYIHrTYOpAJaMY59ONizyptV7I51yUN9blSaEc3nY1n4jHKLncJSC0d1AXtwRvjeRtM7c4gYs8yaU8JVR1qzODZ8NYvUgAYXOKkbf62EV9ePWpGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHaqm0ezpRydeQd3pMsvveK6E+j9cFr+H0zRq99RGyo=;
 b=WSVOCFLy32w/1cJcnlz1fDBqb7XQbgPws5CIIaVRfq4vzr4H3UV37vGeQLQO0nKZZ0Xzb3O0RzXbENITweWYTH9bI9x7w2ZMIGm8GMMSQPHNn0qvl//q8s0IOpOmOEn4cI05QYRVdAa/j+NeEjbPG9WozdKr1VHX4tl4M9w8nX594ICbDSi6KFYTTGYnbXeJZ5SKGF9/03j5CwMipjON+5lWLLTGZKzIXdRum3PCIXR/yvjVKMqAtiBnldTMSrrvvQX+NkXb4ueqVQECOYbxJXLpPD7AJ5CEKwDWJd/ecVS0Cg31hZvvo1nhpCmo5WpoDf252gxtCvxxo27ojAeLEg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 19:22:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:22:05 +0000
Date:   Mon, 10 May 2021 16:22:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/siw: Properly check send and receive CQ
 pointers
Message-ID: <20210510192203.GA1121391@nvidia.com>
References: <a7535a82925f6f4c1f062abaa294f3ae6e54bdd2.1620560310.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7535a82925f6f4c1f062abaa294f3ae6e54bdd2.1620560310.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0087.namprd02.prod.outlook.com
 (2603:10b6:208:51::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0087.namprd02.prod.outlook.com (2603:10b6:208:51::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 19:22:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgBTf-004hpe-UH; Mon, 10 May 2021 16:22:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71ad5426-22d3-4e92-de5a-08d913e8e56a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40109624216E7B4862CF0245C2549@DM6PR12MB4010.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xmibC7IwlpUAc0MZxxxq4KvVBpbxvL7hXHYK2fRzi8AyHpU1anLgChnbylUyU0MhkOgVmh1l1DfrzaNBJlWzHfHyk3Xxv3WTZXeybvcRyrtAOL/ooQZDKwBAtYU90GBDsBfKC93idGUHX6skHLDCgOZgEaZI3A37qcXNuk2qkvwg1fjnfhdYXNh8na3Lx0mjtW3Jv8Ox2lPiT3GsF39LOY1jLCDQkuvmyvtTXFxJwu/4IDChfdirUlxANbzRQSSL1TdO1pkqv0mXs6GIkFcoAQK9DiznMwDP3fvoq/iGikGzxrVtpoJgIokyxckSP1c0y1lXbvAK4uDpAsMnB0W5znOOVgyV7ztxI47vNh5Bdtq4z+kgbsAMO2/VCP/NUGEwKHdytk73x9roligwjqynrR4CxSlvh36Zy9+fuuAfeiHEWBUPaw433j5LIK66MhJfL9GEwSderA+MCkfLZ0YTffj5TvVLRAO0qzosGFH0IksdivY0VqGwLFqpPK4eCSCJihMXzx/r9WlhyOYyuCAPwlg/SF7TPNZJrZaBANvkRgXlpjFO0RvUUaMJ5zCmwkoEpLssOFyQY80hDZdfQyHTqGd/kVbfz536j8bs1RTqaZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(9746002)(478600001)(1076003)(9786002)(86362001)(2906002)(54906003)(4744005)(2616005)(38100700002)(26005)(186003)(83380400001)(36756003)(4326008)(33656002)(6916009)(66476007)(426003)(8676002)(66556008)(8936002)(66946007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SRCvJW6E5c2HnlvWonk5v5Jo2F7XaP89xYXjiVvwuwXiIqfR1n+hLs7S/Ar/?=
 =?us-ascii?Q?p5DW3uSLiagZhQ5rcCK0npg7T+Eonp0pKPfmNenJKCXuHU7zrF4vpIesToG9?=
 =?us-ascii?Q?Q/wJzZ4G+WhL+wpLG4o4402oESeX0tibVJ3+s4HShLomcuE8giGJJxE37waO?=
 =?us-ascii?Q?x5piB+D0o8j0WuV5ww7PUMTa3na96Wk+9zSJ9kUqdLGGCk62iYy3NFno33wt?=
 =?us-ascii?Q?kKf5TOd9JGgPEGIMMJd2mcoLwmQ/2gBGsg7FrevR/41Q+IZBuxBocVbHHLf9?=
 =?us-ascii?Q?cB6yeJH8wLHO3aEhg1Uotg9YrxshzkCMisKSLsMtth9KuGRKqbUA+R50C/e+?=
 =?us-ascii?Q?DLPqCRv7LVYqax74HvmzR1Tu74F3747WeupWgyzo84JcHnJYZFonBUu+QHI4?=
 =?us-ascii?Q?2giFE91tbONAxTOYOD/y3MATsjJXd8o7tu8gw0cv3iKFt+6q1+y1i4a0Zigb?=
 =?us-ascii?Q?zPQt8UDde63J8IbTdRGoFHaAoWK2t879AETdGcPVOlLtRLBCVjo6X/5EpPD3?=
 =?us-ascii?Q?J2DlOI6pMr0VhSsr45Ewotjmjp4WWsy4Ps6q6uFTMdg77YGutpaCDmhSvMlT?=
 =?us-ascii?Q?5RBMRiiwxRZpIlpVi9GfZObvlIBTk4leaN8sIuxo63YTp2p8z1kZvUZx1XXK?=
 =?us-ascii?Q?G8gCeWfs6EpLtaUu8mjOxvQyMItyBuc4qZteQl30gh93a5uvptrjV+krTQV+?=
 =?us-ascii?Q?LTF/LNCjxnmvp6/GU/pOq5cbvCazE3OABFHMb8fN3qyFBAbRvE9sqCfFUO3H?=
 =?us-ascii?Q?cKqJMo/fd6rRmVXBeyK8EcA5imPuo9ymPDrHfckhK/J9FnCfvQaPLXYwoNn5?=
 =?us-ascii?Q?2LG/fdq8jKjmAqfIdh7XmUb1T6ctfnUSoYJ9oEgqwVi0y8PLd28RIphaIbpN?=
 =?us-ascii?Q?w7P3QYKn6kOI4dgScqs0EGb2DDLMl47mH/V1nVyQxO1AV3nzyBTuGaw7vX60?=
 =?us-ascii?Q?WKYRoov+P3OFILsDGuHxsU3G4G2vOfO75wJsCk70if9I3lPDEptQ48IYCMcb?=
 =?us-ascii?Q?78spQzVvFmUe/KxlL7hCpMZmPIvw7hjwo/YWHwMX3n/s59btiOA/rjAAlfjY?=
 =?us-ascii?Q?I9t9Q7/hQWBZ4VLHCDyJVfyS/fK16OxVY/2OOY3PZpjwirppTEq+MfHLY4nK?=
 =?us-ascii?Q?NbOCIh8DPCYkz4siYFH8rSaniIEt/3p/pUV4Xt+N5OFdL9O/AhvgxOfuPYgi?=
 =?us-ascii?Q?8qYhk5HVcVRzbV5m+aCXodcqmZGhIkVD7Il5jBqfXmtpqJI0FOJL6kFJkmAl?=
 =?us-ascii?Q?s6uveLevYMux3+9usnt/PaFozJ1lp/A3Cx0QZkpK4/Y9BL5c4FR9hhlLpcvC?=
 =?us-ascii?Q?AwA1ewna9cZleDfrSna+ZIAM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ad5426-22d3-4e92-de5a-08d913e8e56a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 19:22:05.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kDQwLpQfG9R4Y0amKrkJqfgqMLv8F/PPnRHsiSD81DJe4YzsznFW4lrjZK+tBxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4010
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 09, 2021 at 02:39:21PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The check for the NULL of pointer received from container_of is
> incorrect by definition as it points to some random memory.
> 
> Change such check with proper NULL check of SIW QP attributes.
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to for-rc, thanks

Jason
