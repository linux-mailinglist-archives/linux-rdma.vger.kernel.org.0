Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6165341ED6
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhCSNxV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 09:53:21 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:14497
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229956AbhCSNxG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 09:53:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2MJrlahc6cFi3vWOEY1UXcHTNwR65ioGmSuMmxrWnh1NZh5u+MWVzun3kh/hViIiTI5Fd7myqvHWeYb5lEFH8PnxWJgqfRl/+4e5uVpg+GIKYOevzN68wt3Dc9maxB9EWnAyVL8HqzCTvjYGRhIlKxhnI1SZGCQ19J7h5vmxggmBkUIJ8NnCKCOULlE1o8pC5QNHBdwuTUfNi8a1EDUPi3wyFnvjBganXENlqanqJmRqkOmBxL+nxOUy0ya/0kzhH3ggJ9IH7E5lnl7W2ZPgKSdf59QWpfIO/A5GEliFWDdpbUBCYLWzQSfT/BNsarhD6yIK0V3JDftD6mUZvtqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byl14jWGPSOStJ50J/Wno0uzqUC1POTneQ5sSisIW/Q=;
 b=OX7CBnoTNAIqIHtlWWNyQwIlM0VLoq5KOw4WzAj7OJyZqW+ZnKhwyC0y6SIROnSskaGGvCYDeQEBMVNN6HoNH6dy9kqTSB+2scZmCWk+joauimWF6nz5l2VcErbgjy1ZKgEmGgvG9Fq0mENEjNXAeLKfU08rF4wPRRf4CYjoBPNl20t1Ybvbm1eYBlQgZOT3ztKlCHXn460b67FASjo/CIiv57f6HtGW4jHE3A742O8JGwBjyw0WggeEe1m/2z6mk+L/spZqTh+y47bQ4nvVQVDIW/sMmXUsSLy3HLz8Zu3JvuqKlME4jc0Ycq8PzxJDKRexpHeTZriAPhS4xxhFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byl14jWGPSOStJ50J/Wno0uzqUC1POTneQ5sSisIW/Q=;
 b=keRSDkl3Q9Cw6JLnQCB5e/Gw8TU+AxpCCu6yuy/v+C24nMD/1bPT0QbnqJI6MQ118fRBpecMHU4NZnIvPP55SJJQvu/CikTeh/v9lAOrO9C+aJpwv0eawfnwFj6buVgCmb7avOgprLYhUVMlFJ6K7ns+Tz7WS3xZIGeDTz8LRvT4IhWeQePNpF/raAl1jZvTEtEwr33ntwZ4a9NaHwWZluRALQC8ZE7Czyfh6GfCnxc8HY87PHwgZVPQLzAqmtuQfC9QeGw4LObYJMbkYHrilb5XbYF6iv7UA3zRIb5npbmWyZ1k6iXEWwgEx7CsifZRlTrl9NXHkrDvdFJlFDsK9A==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 13:53:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 13:53:04 +0000
Date:   Fri, 19 Mar 2021 10:53:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kaike.wan@intel.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        todd.rimmer@intel.com
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319135302.GS2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319125635.34492-1-kaike.wan@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 13:53:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNFYk-00HCs6-Qt; Fri, 19 Mar 2021 10:53:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73bfee24-29b9-468f-26bf-08d8eade5147
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939287EA2A7E8E9398214FEC2689@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spHkF0y9+jgvBWsqvoK855TziipeBCXbf033mzgT3CnIgYm5u5V6Ylty5BxPRAoGTcofznnWTOjPKA2xPXS5lde67gYyI2Cl3LP6DSIHQuYBBxzUMENq3nZM2zW+zXzbyKPkeDKAvrbA+CnLnLe6L0bWfVwV0VjDBsC7XAvqAqQ8IZ96ZGYWmNC6sK+SUA3KniDJK0IebaT9f2kmxy72jH6993Lo8R4wc2v4M/BN/Oo8V3sMRfrDdkCZxbxOrCmQoAPqJtR59IsSGVrzBrBKC2gAOG3Va8ELOXIOq+8AGPcJo5lRV7squnw2hJ2kD/mWbgLIvG+MVqpYAosTvlOqYKUgCN0pM1rrl6LnnChBHIEzHBQfxnF7VTZ5Ebwr5xqvB1QlmENK5yxNBVRajVuS3C3eioC1C5C/9Y/7T754OiGy1zN42BUEnpDbbqIqF9xhq89JJwhenWYrk5t21d23k4WidnLTRL8i7d6b77viNmJko24Rc+K6Sl8i79tvs5EYDOpRPeW3BlgPqS8iEBahYU2WnVPD+czJpkKUe0Wx/1XDvcPO+8mNEaXz+SAIK4+9FGnTUf68y7sPCUPj4hlGRdiuZ4zLmWg7I7QGT4etb6qtBejb/ol53HOc1PaGck0zq6Nm/BQgeUCBTJBJjEGGCLEDh6jt5QYFn6o/UDiqo60=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(8676002)(9746002)(26005)(8936002)(478600001)(38100700001)(186003)(1076003)(426003)(4326008)(6916009)(33656002)(316002)(2616005)(2906002)(66476007)(86362001)(66946007)(66556008)(5660300002)(36756003)(4744005)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hMUJGRW0dsbiKT06wZMeiafU9izOvDTFq8+ved46Ag994Y0AuS3t/gDnv3qV?=
 =?us-ascii?Q?trn3UkCfWyY2d8cDxfDzrqTn2qeFaoJxiYVa+OiPywypuWmiPsH7ro/Mq+Ia?=
 =?us-ascii?Q?4oShEQEShqndVGsbrXP+9I4UlRM5rK6yPEvvrZWnrZfhydXW2pynd1I7fqy4?=
 =?us-ascii?Q?eVzG4lO4emgMSFillgjYkebVrNRwTaRKIr6CE8P1BWN05B4mjGE6mW+vTyxA?=
 =?us-ascii?Q?4Wh73ZgOXFZ+I2/LynTet4nYm2iJmg1IsbaAd7cUnVZB+YcmCqWTHnW/xPiv?=
 =?us-ascii?Q?iUz7A8QvZNreEEaJEg/v+fTC4nwAa4QCrLmoCIZijYUfobTXSioohp8+ebtW?=
 =?us-ascii?Q?8eNyeb3XYHQIdtC6V1LBMPMY2Oq9cGZPM0nmKYNfbD2RmlSsylBKa/Rk48H1?=
 =?us-ascii?Q?8Xb6KO8Xs4c/fdqooKDMvvqkaWUOScL19NlUR7LhKPl662AaAkb+evOWJzsP?=
 =?us-ascii?Q?tFOSoMPQLTTGAyqXerJ2NDcsZv0wEUErThPTWQDD4ZIC8QbAaEWXHrwfxx9o?=
 =?us-ascii?Q?vw34MayzaJzGopZop0Wd0QEFOoyGIAIkH+4kTQ3R+XEJWZBBWf/n4SSQ2dMR?=
 =?us-ascii?Q?zSxH5IjHMQs3nAN2L2oGXM/xX4jQ1vrdTeJp87t55oVWtxQI4ihJCPcl/CrR?=
 =?us-ascii?Q?cjQt0RCv4rESNJ/jfSoAi6dCDjSxuUz2cVFJvviOJo81u8T66G5cQjr5gjtT?=
 =?us-ascii?Q?PAjQ/kelkc8NyVXlKfptIXwtdACr+nlTlUaKNmaxg0Mlbr5URwMul6F0nubg?=
 =?us-ascii?Q?nAzfK/tD73pIE/1YkJBQQoPMW6D3TXGc1Zla2WqScGHPhEZCkmHI9W0wvXGH?=
 =?us-ascii?Q?zPVc0A6Kjny83Mcf1cNBSWRFVOh9Ffxm1nR9cnQQPLEWJ6lFtD6minHfFUh4?=
 =?us-ascii?Q?2CADsMHQOLtsrY8mXNiQqpDS2jdFETSQQIJcL3NOv4cXWinf/LCP+Ns9Omvc?=
 =?us-ascii?Q?Wg7Y0IPRPz56Cgx6KpooPddSCmbPP/zZswRKIgNBgmPNifjNTKFAPtHDYLnD?=
 =?us-ascii?Q?6vLHLFYuiHxnE5oQf8tRbai18Y+9W/SntSMgLYGDr7zv7in8uFXWh9LZRIbw?=
 =?us-ascii?Q?nH9L/GELEhQvuaFRkPYJQMVn5FTNADj4UHr6L+NSDjfINZA0PoCXdGZzR4cS?=
 =?us-ascii?Q?4do5Iy7c0UJ9g4KjN1gaNEIoMO555FC7YiPdjswhsWXUrGZwx1PKyerfq5mV?=
 =?us-ascii?Q?z9NUJMUz7zNft/l8PvRE7zP7RoPB2RnXnaUDf/z94ZPyR8I0/dA+oKiabxi6?=
 =?us-ascii?Q?GfLB4RnFUwFxtm8Iozde3RbsFXqSPl+9eneJGEoZ9hb6+kOAEY6mECDJaYvf?=
 =?us-ascii?Q?A2ITCop/W/ldWIefux8oXv0U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bfee24-29b9-468f-26bf-08d8eade5147
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 13:53:04.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvenGnyrjwHftUW+avRsajAjFfwPBTa1Nj3XdCKeaL7it14v8HWV6AA83k/kR/ac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:56:26AM -0400, kaike.wan@intel.com wrote:

> - Basic mode of operations (PSM3 is used as an example for user
>   applications):
>   - A middleware (like MPI) has out-of-band communication channels
>     between any two nodes, which are used to establish high performance
>     communications for providers such as PSM3.

Huh? Doesn't PSM3 already use it's own special non-verbs char devices
that already have memory caches and other stuff? Now you want to throw
that all away and do yet another char dev just for HFI? Why?

I also don't know why you picked the name rv, this looks like it has
little to do with the usual MPI rendezvous protocol. This is all about
bulk transfers. It is actually a lot like RDS. Maybe you should be
using RDS?

Jason
