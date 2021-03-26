Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298B34ACF8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhCZQ6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 12:58:42 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:7392
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhCZQ6Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 12:58:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFInPOAGNropnO71aqS9OczYY2Rejs89esavFDwI56nl/bbF0eVyO6jtDwZfNpPMzH2nvfC6l8KNEmNzjwyd/3UUCHL4lZV5eWYzaqjgg7kVDlpKXZ6Ar9PyJw8xa7SiUlkPF009FzOxtTh2sxxr1YxoT/R8SQWCZ+tuv6vk2TE8Cs8UcsU7+MH8KEpjJv5AYnIdXVXYNgEU1oB3KICIP+OvvmIogi2K7apVzfgaDotr+WD5H0Nvs5X3JYnPGp5sWnDucabz3KFD82IcvHI53D8oIDzgBNCvcMwt5VuME7kW/VPnLK8fJZCDtC0KS4HuD/NB11BPlAM5HRmHGKN+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QAn29iyrrXlDtbT5Z6vFqwnPqJdGXi+m/mdQRkqP60=;
 b=ZlWHej3nwT4vboiz8OUj8HXixDpYQ7C8/hy1C/s++DJFUs2v91w/ZX9wjK2NO48P+S/QJba+8H6EJJTxvSFtjCfXdtDitvzXSE5O9suxduZyRBKweRIUw+Ft80f6q6N8/bdj7AwYNF5qt45W1CYmhgEJTFisQBlDbE7JRJ+WBFkFrgAFGpdYn8Vmowi5llNbe7TvTL6+uI7oNkJ4Wz/r16qmGIwZUUG9djZ7HWrn64nbZ2TQDwpP7gfUFMOJy0JFnXRTUuMYzgFcHb8VBFz2SKPuF+AkypUShLeCw/b/i1C4oXuVq5iQZnVAXIuU9ZcnBecnU/QgiXrEAH+Y53RUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QAn29iyrrXlDtbT5Z6vFqwnPqJdGXi+m/mdQRkqP60=;
 b=KLbDo7M1g8D514dRPyX7K5khgly1ElFRXOwi3k+yjeUd/srGSw4qMqFyXXXh+G7Je9KJGJe0JsbfGcBhDdutZUhKbh0FafarQFcYPMkw5YcW780jiAwg4if9ImWWxcdRouWrV9zxWobQZnHF7BL6ax9rCkrEBBcPUQA0RgqPagpGmB5SgBtS5dPugfCQXQi0BH/8OprWvxgWD65AGgPPJO0Wju9OQRm31fng9aXVYIDuhAOZvzV79+070ryoR+NKwh2O79S/oQZ/2HcvNhQxvaLTmY/MOf/FuYY4eR23+d1l3XcIdPiElgUMWG5YyBtwRAZmK8jbiaFa0tn1P+HNZw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 26 Mar
 2021 16:58:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 16:58:14 +0000
Date:   Fri, 26 Mar 2021 13:58:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/counters: Refactor
 rdma_counter_set_auto_mode and __counter_set_mode
Message-ID: <20210326165813.GA863945@nvidia.com>
References: <20210318110502.673676-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318110502.673676-1-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:208:23b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 16:58:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPpmn-003clK-7H; Fri, 26 Mar 2021 13:58:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ee90af5-25c6-43b4-a2ec-08d8f0785862
X-MS-TrafficTypeDiagnostic: DM6PR12MB2811:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB281121ACDCFD2D9D2F51106CC2619@DM6PR12MB2811.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7xlSzVzjlu/CJKxaoB/uj4BqIeF8BYO8aq0bmi1CFNN3X/Pje0w/MGZO/4xtx4wptQNwU3Po/wnOFN/ZHfSovp2zmT2u01u7yUZyGqLywnH7syabSW8Imd34IhLQ0yH91qEsD5nPjfAAXCjRB3U399NZVnSeM7PLZQd9RL3GEdMfS84ivYIx/FSNo9GFuXvH/iWPqtLFLW3fTY3lJ24c1WWUzFUYnh9a6u7eGN26qlW0iVLAFdfxyAfUTImEIyLBmjBV494JmSpCDCar3t1HvMgX7fjRRMGYnKMA1oAa3+VO3Cvw/Z0tY0Z7SuWyIpHat36nJpWBvpDsIU+kyrzRi1dznHZd/Zqcc6DIrxgZ6LImkt1jxOfs7Ebxn5nuLM8h1wbsRli8kxxpw1Rv65BOPODhkgIqBP0lMk0+3mAXpKlrWS+JWhcHg5ZIUYLi3pIxpoANopuRV24595y16/7jVvFhXH0uBculd2psWMHmZHkEjuj3/T9H0Jpj8SjzQVfrBE7HEVDVCc2g+Er/mOyw32u6x7xEO4UCEDvewJxHek1gHC/bGRpY1VSHtX5FSUD8GS8Ol3lbT8/uc1HhpBkFF4VnJBYu5g92nCsIV0FUaqu34FybbwrnEL64791yPUnSO3pwNKwiVFC1mw144SMulmmEzjDJqYYXuqI8MIqWJhcTr8SsUN1PlJ/D0Ta/4Wz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(426003)(316002)(107886003)(38100700001)(6916009)(36756003)(2906002)(2616005)(8676002)(66946007)(9786002)(5660300002)(66476007)(66556008)(4326008)(33656002)(86362001)(8936002)(1076003)(26005)(186003)(54906003)(4744005)(83380400001)(9746002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0kR4RGxLni9bmV/1tF+cebh7jJY7SeFzd7pI7TQNOneh6f9fTgDBfnvZaf0c?=
 =?us-ascii?Q?81KDwPJp2SW43qCeknQHYYzSLH3K392CSwht4A93gQp3KZI3Tjgp11rrkcJe?=
 =?us-ascii?Q?O1MLfQj5SolSCieuBy9QmW+RK4oyi4bzbJS5Wae54fWZPejj8cLyJYTFivkj?=
 =?us-ascii?Q?ImsPLR/c5kW4aBs/1MRZDeUynn90t4a/YvYAzXcyjMdV97Tmoo2aMmcNoWyr?=
 =?us-ascii?Q?+zQrrdEISLf+9DWIq1ruvqMUtTj11/nVeenYfOFM6zIPAo3SCP0bBAk3Upjn?=
 =?us-ascii?Q?PZpjfXEDfY5rKwzZtTFOfDKIjXnlX5JZX0LPhjYanZyzYbhIlzq6x10/C5Uh?=
 =?us-ascii?Q?YOMVp2Ojg/XCH28dJLelWQaEE02L9bPhUbLAzSVHu6EEbAwBUIxgMaitbvmp?=
 =?us-ascii?Q?B6GMImGSp8ulpDkPKw5Vi2Wdtxg2xjJLH2VMW+hSMz26knJDLlq2WHvJ1FJp?=
 =?us-ascii?Q?fNST5YQA0yjqyf/SBewFeYyyM0MZOL/uA9VcaV86tvQU3bSipSpAMDtzfcIn?=
 =?us-ascii?Q?eUjuayLCkz3pAWNdo2qFgMmv339jNewprE2n/jBjov+5giJ4kY4PPX7Kyr+e?=
 =?us-ascii?Q?T+K42312uUDBtiLOZ2GFBCy4ida1V6F2lDUrePh7tKx/RY7uiJYw2jGqSdud?=
 =?us-ascii?Q?50otQcWVrIKcpADGCwYr9nWR1iZzVBs5UWQ2rEaGElE5kGVg1xMQd2bSr6mA?=
 =?us-ascii?Q?Q4XZehpcvPKbf3PX8fu53PD/dbTLyp38sqgaqbPW2yYjSzVbe7LCbLJDSeNk?=
 =?us-ascii?Q?jAzsTlgQo3LqUbOV7axU8PJBX8ZK47AC1LIx7sbg0kgthZTGsnCNFKvG9BMo?=
 =?us-ascii?Q?za41bwUBORSuNLujKoX6rk4x7AneG0WETqcfahyQDwm+uok/Hszzv9UaAsE4?=
 =?us-ascii?Q?9CkawKJTmmda/BA9vyxPPNak8VxhWZgrimEwKelx/WymcolUILp8sY/6SGSk?=
 =?us-ascii?Q?sm2aUlDrMvZd5cXSCZiHQVLs/qJ3Mih48XBU4FdoXth4lAysd0hiZ7Jx+BpR?=
 =?us-ascii?Q?5IShQHSqiyu00/RlWJqHQ5LY6wRaqX7heP9oQEGgeyQmGjEyBIHvecWOwGtg?=
 =?us-ascii?Q?mxS+fnEX4X0ts1Cje9VLy/nVBLq5BB3IRn7AgDtiwJYQmwn6oW8C+dflzxsj?=
 =?us-ascii?Q?Jm6Ime24f4mp7TcQxBagtH+qbK6/V+BlvPpwB2PbSXPaMBpzrX2n9ISV1HKp?=
 =?us-ascii?Q?8lY9SfOIVp+RQSLGVm8N4qHrlnnDbQUvNVOgTbUDDBfGVi/r/7DWCTeS/9kp?=
 =?us-ascii?Q?XkcFpr8ik+TQNjWPrlttn9DfBTwBuddwLtHgeuw39bucDmDzaeLkaRINl7ip?=
 =?us-ascii?Q?VHheAdVbz59pOMXitVcB91Inn14ubwgeTA3N4cFAjgTtUg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee90af5-25c6-43b4-a2ec-08d8f0785862
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 16:58:14.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJLgzxHEbRzKOCKxtoeF7yqeSr7If8aLrGkcx4H/STQ03T0jr81lATPYRC1GNDl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2811
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 01:05:02PM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> The success is returned in the following flows:
>  * New mode is the same as the current one.
>  * Switched to new mode and there are no bound counters yet.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/counters.c | 42 +++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 18 deletions(-)

Applied to for-next, thanks

Jason
