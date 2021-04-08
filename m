Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4ACA358326
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhDHMUa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:20:30 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:35424
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229741AbhDHMUa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7B52cdhZ1uFwmoFokLFlOVYP1rUTiRxs+i1q+dN4ydING7q6aMnal8riM4k93a9FBu9bHShr3GcI6CebSojBuFdsiSiVsBpyf4a29kn/07pi53lp7ZBiE8uz+5QvW0I3g2lIwWujl1WroH3coyv8eD/x28uu1SgF08s5F2wQzHdrEMIv+GPlhjyLTY14lIw8fBa+aLPuV5h8xAs8GWuK576RPeDeNK3axFewKu91xJVWCRaEneAA8oN0CRYdpcJhbn2xgDozoBYETVcHJYsbheLJ9sClOYykcOt3bNKO/WpgFq9A3aHM4LzRJvMv/7XqM+NqTSYkgypORGQ3Gj06g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl6rGxSLCa5pMp+UEeqJ9KLtlr6I4CPf8z1K81Kj9Xg=;
 b=AthNvgwkjwrQ1YVOdURWThKBJvbIZ06WnQNtCDGt04hRf7AhxPf0RiiLizHN2XXvNBOU3NLQ7xKaJobPBH9JVNyM0rCaC0kW4qTc7BRJ2X12xiwtmtKufKAadLXuP91iekjRvzeUGrWdnV9kLl5LhqGIZkfF8KQzc5EfJvjRjkkU2y+mku/zoMKalXYqhhFHfT2izzjn5uTnRxHeTnQV/085xB2ilRWrSHxnLejrjitESo8d/m3/UBH6PWmfJ6bPeUSSVqLcqNTF0Bzf1SV9lWYF0ZZx6eMbivVlnneLAfzQP7TucWVNom45IhT3mohZngxY9xcBmSf7KTrzjH8OZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl6rGxSLCa5pMp+UEeqJ9KLtlr6I4CPf8z1K81Kj9Xg=;
 b=CG2oif1riWyQ2tbynoDC/+z+/jGLa+uRgBdQJ9a9JVEi3dR9Q9EO7fTdlTiLGVdJMdK6eqAhMrBSzefyboQQZGB6u2NC8naGBy+AqdqfSFj+Ci9eA3ykC3kw2I0iHXq1DBFE6g1zkb2p/Ll/KtBQwHepmiHpSMyFpyL/d9FJFf78WgBViIdSHT8h7XJ+arntWv65VRYfJ0hquyS1Y1qR1z0JDz/50QALDCMSiThFV6AWMI/p9vfSfD+JQMWgWV1zWfSN2KR2MRe6SE73r2iZV++HVBlcsA+1KGynF7J6H/n5DPO1vTaUPlOH3YOiryFpIO8dwX1MjITehazt29zziQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 12:20:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:20:18 +0000
Date:   Thu, 8 Apr 2021 09:20:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 00/10] Fixes for 5.13
Message-ID: <20210408122016.GS7405@nvidia.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <20210407232157.GA578406@nvidia.com>
 <30099b55-7cea-dbdc-d3c3-31c236678492@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30099b55-7cea-dbdc-d3c3-31c236678492@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:20:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lUTdw-002hsB-Cq; Thu, 08 Apr 2021 09:20:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2268fc1-7e67-4618-b4bd-08d8fa88abc8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4499A09C62E4DAA0A6854CDBC2749@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lvHbhFjXXkn3Lnxdyz9j70Y+Mz+Zc4T8zmncIZ7GtxY5inFyirqtWNYut4v0dMrGUI4LtEE1m6ZBFt7KuGuxkidnVcQEmyv/6j5n1CE7fe871UckTnvUVMA08d/v/P1wUYNwKN8QtB+NF0WzbeIhG5ACZL8j1gK8bWZ8vOmc+oSgpdhQnRnnlR7HopOl68BB9EmOgZ97tvnxdk3w6i9bOIia+np8da8Eq7lfoBH4tOQY22I6BDiA9QERjDjR1i3xt9OcFPCNly+9sMHB+nA2yxqMDlYK5wN4X+Wye8ksoNGkUzDFSZMUZdSqUEV1nD4icjR/l1Jtr50+psHANED7rEyzPEXWInoTGZJ8GwJXfrHZy7jsHLY22+ntjgnY6iOssa/BG3LFLZCXgo+izKMa7UWOw6GjmZxrhoS/Gwua3ROEZDlTppMTBFNncNfqiWWPe9espwb7LChtdcflSkBCxEIGHI2HeH7wAFxgqM6B9iNZ6vGkS1MZ92X/mkzTxf+LvZ0NjU9sxapy6rjAQm9raL33lJIE9BVFvAMM7VEhfMkdm4+NIZMU4OI+F5Zj6QoBq4crjLgeI01C0fvNgQRWIQqCwJizlu9evhpMBgMiizg3DZFgQQSEFyoonit1MjpmbhRsvDvSKCMM4+9W370gO+AM2C4BKTAPbAp325svzhM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(66556008)(5660300002)(33656002)(316002)(66476007)(66946007)(86362001)(36756003)(8676002)(4326008)(1076003)(186003)(4744005)(2906002)(26005)(9786002)(6916009)(9746002)(426003)(2616005)(478600001)(38100700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/ND7StRzE7FZKDhwzQueMufOL3rjGl/kgqYjUVg+6YgtF6bgXWq9S79fFl6R?=
 =?us-ascii?Q?zoiGsHqGgku50RX0BB4A/jWc58+2wqUfH5PFrj+yZNVTAvnVj4CjA5djCn0H?=
 =?us-ascii?Q?Ad4iBpalu+XPBxdD7Q63FPVC/TmMZII1TD9vzcRzppXMmtbL/23/7Fc9Dpie?=
 =?us-ascii?Q?2Cc5unJUKOSo/2sIjtjBgiShHooC0AEUpuwagV8TPHE8WanY8FlbeE4lQlf7?=
 =?us-ascii?Q?jGgMvd+6GDFugRSQBIVD9JzBcPcLKHCMIpe/6AjIqlI0Z3wxoZpnYX3/C+op?=
 =?us-ascii?Q?zy49j/ghPOikCNPkQA6thAMEXwlD0P7IE/U80mof9n+RDWS1TQVww4JcliHj?=
 =?us-ascii?Q?STzJy2E0mU3J357wN2ZTI5U3B7JMFo2wPDH8KrZNXTQMoOOaUKkt4n5pW6Eo?=
 =?us-ascii?Q?7ADqTAKa7DQmVc0eOYqbXHzx4l/tGBFOXg6gBmQWrWn07aZN3Mui7oR9b/qK?=
 =?us-ascii?Q?NHYsnRB6afyIbjbCx0hdCpImgWHvTUVFGbqJBkQ/6/WY4FWj9tvhUJyUo4tC?=
 =?us-ascii?Q?OuQFnU5jtCUMUat9AkrTBCZeEF3yN2lvjdg3n+u1fTgvMfNwM/vG2+6cZJGd?=
 =?us-ascii?Q?yhdAZHrc5nHJocfN1ZsmIJd2idYNgG1tAbTRXoO03wb0OF5vNMCpzyDAGO8n?=
 =?us-ascii?Q?2QmjdbqeE1bPuxWu/00VUvljoiboNbdkzOa9xcxe2uBlJogdNHZ1xFJyJ/X9?=
 =?us-ascii?Q?KW7cI5PZRxq3RRVo+Rfg693pCdCqrO2KRSHfJTH1b5jCHq2GSmU9jSpDnvwc?=
 =?us-ascii?Q?RBtaqFaBWj0bHoo+b4ThbGa8OsVas7zUcEYIZ+fPCfh0C3dqXu3XBcroS9b+?=
 =?us-ascii?Q?N2t+sz00csoAQLhVVVgaEok058dG0uBJGQBotaHsJ+MaLvDHqfY1utsqEbH4?=
 =?us-ascii?Q?LCbU8x4OfpkhD2g611VEYs6o4Z3jqMx45F1Wd/98TNe53y9zSxE36Hz6PZvt?=
 =?us-ascii?Q?lFDbS9IZsiKza5V28+wkgFsWK6MqmlzM+TPe8jRrPd55bxaJ0LWLbIBzQOHH?=
 =?us-ascii?Q?ud3NbGIpzNiYeTInrJt0/Va8BU0xXWCfKxBD71TzB7p2ycYkKI2hK/+3a+am?=
 =?us-ascii?Q?+VcOMXmuA9ls+bGKVCnuQwl0G3InExmqOA5hFdesmceYXXX9VXLElTb5yIoz?=
 =?us-ascii?Q?DlI6elrsVAYfmFFiET1o0ZYyO5WnY8O/TjdVSwL+rdK2tC9R5j0xqCRuPwp4?=
 =?us-ascii?Q?andRQHVJ+YrlBbYgf+jdWAKQz9o5I2oY0M9lKgRYTQ5JUq9SyKumECzXctC5?=
 =?us-ascii?Q?+XKppyCwQv9C+3MDafA52I3ZZlHboiq2jUsdGYO/VgM8AmQwjEAv/hDftLBb?=
 =?us-ascii?Q?fOYjKrBH5XnjnBTeJB/8tOcFhZoe9+i8ipdTMXuAViFj3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2268fc1-7e67-4618-b4bd-08d8fa88abc8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:20:17.9757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z83cAnsOgZMhWi+L+6mvfna26gfjknGi4Nh3knNgX2ceFrjJqDkz92HZHhcuJTFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 08:19:22AM -0400, Dennis Dalessandro wrote:

> > > Mike Marciniszyn (8):
> > >    IB/hfi1: Add AIP tx traces
> > >    IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
> > >    IB/hfi1: Correct oversized ring allocation
> > >    IB/hfi1: Use napi_schedule_irqoff() for tx napi
> > >    IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
> > >    IB/hfi1: Add additional usdma traces
> > >    IB/hfi1: Use kzalloc() for mmu_rb_handler allocation
> > 
> > Applied these to for-rc, thanks
> 
> for-next?
 

Yes, typo here

Jason
