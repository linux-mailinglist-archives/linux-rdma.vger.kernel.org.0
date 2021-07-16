Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667A33CBBA0
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGPSGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 14:06:14 -0400
Received: from mail-co1nam11on2055.outbound.protection.outlook.com ([40.107.220.55]:12156
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232048AbhGPSGO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 14:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB7V69iU9yyuZAO4Dr1Ns4l9zrsc/ZyXgyDIE6AkzIv8LCSyh06vaS/XC3SWrv6ghG6xjCn4ePjQytBSe7PObDnQrm5vHUi1DRQQzjvgEpMKSdVhSwX6raqsSzrmViYR0kTw1dQm9DQPcyCkclrTvnLTHIyYvYqI4NQduUzsMHm+e/nktPGgR6r43tRXY5J1VvFI3YqAmQwPhcpdz57ZN2iOrSM8UUFLPhxKr8pjtG3zXMoCIRfO7Jh2asx0RzSDPL02/NwuLvbHLuxWeEglW6V2gxZ3/R0LqLqngwYHLdSrSmbR9KPtImMBVjYhzpah85/NHrpcjWNJ0fnmXf/qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddj6K+MyP1QLbAYJfDcfW2pDFbii5Slwt6Hd/tsPQmQ=;
 b=g9VhHx0SWQZMAG99p4cH3kz040Yoqz2T6Hf8mJT4phDI5bFQuF4RuD1ohDiKyrcws+ifCiotrSrOXXcpQ0Iovg3tluWE48uBx3aTJ8RtjbH3qaPwAE7y991jjS2vOAkW3B9zCcp4uvyRW2qH7481BmlWhTBgsaB+8ipUpzzL46Jsw7fWD88okwQWI8OUOqiwd1MHecnA/wtx05JHHHpxctN1ku1VLW6ty9z9zWkfO8SBcB+dJ/NpskzlNaSbUOaVUXAh+BM/J5QMyvtBpHsiqt01ly6kKnWJorQ9AYsn8fCAK0vEOYZQcLaFkWI32kxsyFYd/5J6gL/w1hPMUPxHjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddj6K+MyP1QLbAYJfDcfW2pDFbii5Slwt6Hd/tsPQmQ=;
 b=Wl7Ca9CiVuOgbJspjnrIdZFCeS4Xf1C/6gjeaXlfTc1I4z7O4Id+lZUXlWXvk/CQhQ0bP6vICB1PQogmxS1X7SbA1lh4iNgbUZWgY4QNcaap5Hftjc9YmvO0YJwkGex04EL1J1zusKvQE7E/0yHHCFDjhOaia8cWpqxIQal6qc4JPAMiSWO3M8Dau0ciQ5PQ41TFYHW3hNwWkUFar1OcJSOsEnj5I76G/g+g6Cljf/jLrwteM5Jz1vpecN4oB1MDqHZALhPQBsljMbTk0PuN4+Xz30qsyaTBQHK4w22R+tyE+BFu1pSNS010PxlWnfHpi3kdg1q3efS6qYpsYYB8MQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Fri, 16 Jul
 2021 18:03:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 18:03:18 +0000
Date:   Fri, 16 Jul 2021 15:03:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] RDMA/rxe: Change user/kernel API to allow indexing AH
Message-ID: <20210716180317.GM543781@nvidia.com>
References: <20210628220043.9851-1-rpearsonhpe@gmail.com>
 <20210628220043.9851-2-rpearsonhpe@gmail.com>
 <20210716174412.GA768036@nvidia.com>
 <ede35d21-2af7-92c3-7289-ba14c8a6bb5a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede35d21-2af7-92c3-7289-ba14c8a6bb5a@gmail.com>
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 18:03:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4SBB-003I63-97; Fri, 16 Jul 2021 15:03:17 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db2e314-415b-4583-ca97-08d94883fd7c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52408076DE6913FAF19F0C6FC2119@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjwVbvExbFoGJq1F0+6kfEmsxczucREniQDFflAxd+R/DrZ+mDeJYOzEol0cL2QarEK7UCuWWTJod/00MiETIsxvANhnxww/vZA9khKGR3KLjQWA8LduTwaq6oDKVLGwTjaPEPjl5YtYozpa6Nt5Hzw9KJ8QpexUtHzKnh3Kc13C/A3ftdbLj6RrkzaMrGoKUr4sKQ1N8rRDEpkwydIhS0qkyj536OpkRJ25p0gdyYlDlCV2EjjcfMVmiOjVZacIVYjwq8dlP3uRf9D15E3foabM6+VEEGyM5inp4hw2XlhWpbjmn2z9PaRkj4hLiobKaaSz9HeHCDHFyYjRMZi9ZEyrVcLNXOn0PjHjDh3L4Vw+xv0A6uVdH8x/3xnDVQF4dBlrzno1yz/jcpscCJMMBllzeTwrkpIuevks4vICFWuPXOtzFI90dio7Zdq9WQ0zmq0wGqR7tlmq4CUvChJdWocOSNoRNTeZDnijOQaMWha4q9tXo8cDvAHjB+PmBctgG6/s/Eslk2uJtLBJb6zLv5wV5rzA2a46Xlu+2Hp2I4Q6+rolDY71LPLP/nuF4vRWSxSM8LPdA8k4CCXON34N44yPout10YuQ5RZkF8iyu10s8gbxmJcIwrp7HPP0t/vmg9s4YtLWfIhEtFifsQ9S3qnOCoj9mkKI50j4zratf0fAKMqkMCFJEv1NtEAMBjCOePYYe9+aL6TyEO/pA96DlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(38100700002)(8676002)(2616005)(2906002)(426003)(6916009)(5660300002)(1076003)(53546011)(316002)(83380400001)(86362001)(66476007)(66556008)(36756003)(33656002)(186003)(4326008)(9746002)(9786002)(66946007)(478600001)(26005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nddjL2mJgcvClz4g9ullWAEKeeqe+wrgaKODPBGz6zjW1dEPSQ51AR9Q8VpA?=
 =?us-ascii?Q?IjyL/GAjvcJL3HuothJjD1i10do14AXwbjteEwR2qXuwLNkg6EQAbQQsu5yR?=
 =?us-ascii?Q?DlPA3Cl/mytWGBoatoG53ZYrpskpdpauskHyYKAcmMqnIL4M8eYk23dKiiiA?=
 =?us-ascii?Q?LskZvswK4Gq/cbGLw6/mxY4RF2QU0BMNnqyL6aHFkxF6x0X3bfvwrQSg1nbO?=
 =?us-ascii?Q?vvtPtMiq0okYYiCu3LatHACyPdOs0m3oT1Rkwx61BKeJRUtzQDE4OZaa8d8i?=
 =?us-ascii?Q?71lsa8N9/NDdFdWvlcI/yIumtCr82xXBBf/FeVGzN7EETLGdpH3mAAtBy+Yl?=
 =?us-ascii?Q?dq8bciNsuSsEjllL5kA4LGgBh+Molovip4GP10C+pHuGIGl8uvXLcKpJEhrs?=
 =?us-ascii?Q?IQpHu2J6cE4P5v5b/DgriP30WD3HQqOzZloSijrduVRZ89GPIkg+Nfj9mAI8?=
 =?us-ascii?Q?Cl8x2IcKPLAM0UNyiDuTExdHZYGbxbpO3SkS8OeDE+x1ybth+RScoIlIQ6P6?=
 =?us-ascii?Q?qysTNr6CXTFwIUFOLQRhnGcD2eGazlBts+xlaToFv0l/pCN0ZIV5dHs2B4MR?=
 =?us-ascii?Q?PjNog4bUzfKVball62UMZ3u1DWGPZZcdK3MvFad6zs1KpBhuKq1XdizZUPNa?=
 =?us-ascii?Q?OuzYXUWf34I71Ba3NcBd027znewDOULDcJIdQN8iv0KT4yOfCpD/C2d3khAI?=
 =?us-ascii?Q?2vrHF19aEkDSnbvbOUsxcIFXj6SmTajDG7Ydo8atittm0j3ewjyXwV4hMyQm?=
 =?us-ascii?Q?lxHmsRn4bqJlaw68f3rzxEpWfgkJFQvYjVEuxaIEPhUC/3pytjqrGvNpxgb0?=
 =?us-ascii?Q?jxD0dR4APh61vLNTQzLlpJnNm45krT1cR6BwUoAiLo0toDnNSMYp0yCVRk5G?=
 =?us-ascii?Q?UuBisQCzfPXpu6t4nNLAu7tbvag4fh6uWQHb0KM9V7c1XQD+zZfuF0Ik7/7N?=
 =?us-ascii?Q?tPHQiRtAPZt84Gv+TGugJKHo2qyObQ8zhK8f9ZEgX17gxAAdjdFszudocM7K?=
 =?us-ascii?Q?NFyXnjg1PEKpnOkIPaabHhc3xofEWA8UdR640xvf3lAoOVCcTYWGvbbS8ggD?=
 =?us-ascii?Q?KsH9s3AJdNUvukddymfsYRka3SbyIDeqcXcgL/nx+7Mg8CkIQILI88QAGrhi?=
 =?us-ascii?Q?GcB95SAdussJZdQ1EYmbHsspSzxtxhqM+oJnccRsdrZPodc3sOYNN4owBoUa?=
 =?us-ascii?Q?G4+a6Xr6w84/6a4xIZ93LWvkoFzpvRftBTy4sWS7QMAdiUVWnD8ByphuFCue?=
 =?us-ascii?Q?ZaF02Ibg70JPJdxhr2ZUs9+H6o3z5fIJ//5BLUVGj82/WyF53waJgMWvAOgW?=
 =?us-ascii?Q?O3SU6F1cLKoP+YHUpwsbODlH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db2e314-415b-4583-ca97-08d94883fd7c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 18:03:18.1520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXVeK6jaw4YTil7Yi0VYJNeji0PSAcI3Y9eBQQ+LzxSdf5Q7jsk5fBMrihcUtKC9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 16, 2021 at 12:55:05PM -0500, Bob Pearson wrote:
> On 7/16/21 12:44 PM, Jason Gunthorpe wrote:
> > On Mon, Jun 28, 2021 at 05:00:40PM -0500, Bob Pearson wrote:
> >> Make changes to rdma_user_rxe.h to allow indexing AH objects, passing
> >> the index in UD send WRs to the driver and returning the index to the rxe
> >> provider. This change will allow removing handling of the AV in the user
> >> space provider. This change is backwards compatible with the current API
> >> so new or old providers and drivers can work together.
> >>
> >> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >>  include/uapi/rdma/rdma_user_rxe.h | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
> >> index e283c2220aba..e544832ed073 100644
> >> +++ b/include/uapi/rdma/rdma_user_rxe.h
> >> @@ -98,6 +98,8 @@ struct rxe_send_wr {
> >>  			__u32	remote_qpn;
> >>  			__u32	remote_qkey;
> >>  			__u16	pkey_index;
> >> +			__u16	reserved;
> >> +			__u32	ah_num;
> >>  		} ud;
> >>  		struct {
> >>  			__aligned_u64	addr;
> >> @@ -148,7 +150,12 @@ struct rxe_dma_info {
> >>  
> >>  struct rxe_send_wqe {
> >>  	struct rxe_send_wr	wr;
> >> -	struct rxe_av		av;
> >> +	union {
> >> +		struct rxe_av av;
> >> +		struct {
> >> +			__u32		reserved[0];
> >> +		} ex;
> >> +	};
> > 
> > What is this for? I didn't notice a usage?
> > 
> > Jason
> > 
> 
> Nothing yet. Was just pointing out that this is where we can extend the wqe without breaking ABI.
> I came back to this issue because I started working on implementing XRC and realized that I had to find someplace to put the xrc extended header info (the srq number) and the wqe was full up. Being dense
> I didn't figure out until later that the AV is only used for UD so this space is free anyway.
> Never the less this the patch set is still useful because IMO.

I think you should move the rxe_av memory from the struct rxe_send_wqe
to the rxe_send_wr.ud struct by padding out the ud struct and placing
the av in the proper location.

Then you don't need this confusing union and the whole thing is much
clearer..

Jason
