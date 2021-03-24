Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE62347E53
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 17:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhCXQ5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 12:57:13 -0400
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:1536
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236446AbhCXQ4v (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 12:56:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0/HSnmRQ1DUIVMHmqt64s0838vGqV3u2uzIoavczqs6+rnTLoVhFpI3gdNEDkO0VeLQISFMMmxJlgLL9J3tmHmuPGJSqltdWBE2WIND0aFG1kH5/Kznc0D8x4ZRWQcHeQNwuDXMJNqGrmJ2LOWiiQkqUiccxJPTxUsYHfyEhacXGpZNI9rnqeDz6fx5OOv2KhBTZnqL44uGAHBzoXaj3dcbAh6kP3bxsFX7ZHxAPMvNG5RPnZ+HWKOnNIVS+6iuDKhJAStcR9viv4af3bm/lCNq0ve3ZdkUdKCkKCHs39E6dme3UuEkGSyIADyaMRPZxhEg8RnAEV98lPvV7AC4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au0vP12Fr23l6YeUcjpTyrIUrpO1tjQuQrTjfQcRVXQ=;
 b=PTh4Ehh/YeA41SRzRTOxnaRia6A2bzDdBtLTnxRASvd/2q5+KYTYH2xRhs4SFMgcXhx7JfptWjYNR2ocSXqexE0KdZQfOjUCFBhaazgnvOVayDdXo/+aa7mlMeOXYPypJesi1R1GrkWzPWLi/7vml18F2YV6JtXqWjjhSLyQxTlIoqt0gtn+SZdsb6f0AI9RE0PpDn2EIjwcF2TadXGWW8EB+A5GMLGHDIRnJaJipuNYVygJXRLMA/oXYmB97TSioyBlkyEyKC0Sk1Z1G5zXeCnfR5xtBvhaOZNfFUj6RMDpDVJl9YeCB+4RRSrUdCRylj6JULExzsW4C/VVn2cO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=au0vP12Fr23l6YeUcjpTyrIUrpO1tjQuQrTjfQcRVXQ=;
 b=LvA9NOep2+eN8j7xxBZHXuoZsEo5mWPyjHi3KP1+hH4UqBbwg5ASIyRsHf00DDq+nv+uP2+1k8qHmkTjxkBZdJ6/A1HBiRaX7/E/SYtl2AOTWkcpePtiypSQFnS6UzMl2ObNQExY3xiJ5IrkNa6Pa02iUZnFN/NJDWbN44svXMX1eWaopK/hmn6zgx5QVRqH/c23tgQZUEmsI+xgAoQTZFHO4cgzlK7qlhepdSk2w0gnsH1kHf4s6rKsRKa+1Cm31S+F9jZRJMQUmeb/0fylevX8VpVpWqSU7Deplr2mI2ZjvoSo9Un7dNteoXMFNAPwn/RIleqSwime6lGcarpuIg==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 16:56:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 16:56:50 +0000
Date:   Wed, 24 Mar 2021 13:56:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module
 dependency
Message-ID: <20210324165648.GL2356281@nvidia.com>
References: <20210324142524.1135319-1-leon@kernel.org>
 <20210324150759.GH2356281@nvidia.com>
 <YFtXw+w7MZFynam0@unreal>
 <CANjDDBjKbDkbwnWV=kk8m2J_NdwjOir0Uoj2xahwEMVDfu-5CQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBjKbDkbwnWV=kk8m2J_NdwjOir0Uoj2xahwEMVDfu-5CQ@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 16:56:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP6oK-0024z8-IT; Wed, 24 Mar 2021 13:56:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5da7192-ddd4-45b3-fa29-08d8eee5d17e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2779:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2779B909F2E961AE30AD5AF4C2639@DM6PR12MB2779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CIzvYtI6xMNOl1zOByL5rRWrvAxBy/EVv5smytY+E/SmCa+crk8RlZQ3f4CFlKBBUEpM3aNEPCm6pNnC9jxvQvYKghhWynvaxpxS6jgefGmrMe+itsbLe6tYnaTyGo6OMpDce6WcysAaM4TkzA0rVsa5s/7Ga5i0BOan+i/cjJFstoOrIAYGS4vCmlptZbqV1v3vhfXQLRxM4fjrQdsedFNcGt+HxfSCSNUmfFbbXgMZ5aYJkWc/E6XUed1SEISAetGNmfmIrIAzsjJWzXA6GT4k/84wrloEGoAl9rYeGtkeEy+dEQl0utw0mWGZncBXzud/kSIfphwYm5hJzGPUSnp0iRWKJG97FOqmNLa/2iK5dcdhMqLhD2o3WjDEvGNcc9jdh1sJsfI8PvhTWAeSs3DaD8fSXFR3Ut7gsoGrQOUFEDTAxx+omyRSQGRLyJDuHOr6JI3V8RV4wmhT03tzg8reMpkE9vaEaFg3Y8d32m9Y/4ylamQ3IRJaQ3hKC+Sa5lf9VSNgRGTTITK87oPBv7zu1BmrULn/+Gq+wWlx9qL8IVwsA6vd/6fyz9cwb6/Rz1fll5/B+57UqIwk9JLBfYrbS/6Ew21N1uq5VR0NXMG4ELjJGoQMWG9T0Mpx3HylAiH1R/YLaD8Krx3Hw5NwDlSJPUv/CNsnjjOAvPV/9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(9786002)(4744005)(8936002)(5660300002)(36756003)(2906002)(38100700001)(1076003)(66556008)(66476007)(33656002)(9746002)(8676002)(86362001)(316002)(83380400001)(66946007)(186003)(54906003)(6916009)(426003)(478600001)(4326008)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?k3vuQudJj3XbV+hcjOOETivr51ukwL193P1LyB+qmMG3jRWgXOrBpXLQ9rSq?=
 =?us-ascii?Q?fqHHIce+Oypu5OjLSpywRZhHEiLGtYu/gB4kvBMo3vBQIotJKQ+oANLi5Vz5?=
 =?us-ascii?Q?QbLWkJOgR9VBzVgu9UwX+Wx7hT3CfYxuR/ILWrtNTE4woT8q0x99oF63g2Qy?=
 =?us-ascii?Q?kPi2ueoyx6F7lNGb3DO34hSSCY5ulKuJijqri8lrv7oLaSqXNH4vhbX7j1qA?=
 =?us-ascii?Q?N3uXMjJNTdoWd4ACxb5LSIJ0Pgp/lXnnOPE4QtYrPUd5MVxzr7lTcV4Vfh7B?=
 =?us-ascii?Q?GpRu2dnNb3cDSzf91tygKLSuGBERtkuOJHxbo40lpTBmGbXqdB1MOza5WYF0?=
 =?us-ascii?Q?n+b4SKShhOq6u15JGLFYmEBqjQEuCHbzE981G04pj0t49qlZwj2rvqrPAYlC?=
 =?us-ascii?Q?rO4ogPzjPwWVucgbtXV/kojzKF0SUQ51EPpRNvid3ChTbcAYqRBXG9G/VuPj?=
 =?us-ascii?Q?ShL00rsyXSvMLZz74cu53y3u2wmEKZiJCSC+6DvJpxuzyJNcYCvvF9B2w8jH?=
 =?us-ascii?Q?JHz/vP7SxEStV9l2KDwDWLju04o5uSBUDBaHa3TtAGl8FDURBI5wVH68blD5?=
 =?us-ascii?Q?mRdnIljD5YaQURw99CvvHxZVWfwr2WHmmzYEwKvGFMOIL42Fzlj376cW43WC?=
 =?us-ascii?Q?NI2dtfxnHfWV017hZ+r0ILQ3sPHy+Cb+cWgPcip+YnfaArT1txfUk2rap9Jz?=
 =?us-ascii?Q?2BgqZYrObmAOKCkTHmwKWQNX9BHqfmw6/gyS6iR78v6Yr8zbkKIC1LKkm/e9?=
 =?us-ascii?Q?D/rP8uRggHAMdfunZ6tHaEBGlhpoyHHJv/4AEvIkA6p7rdhh8zoKQtfNgEfb?=
 =?us-ascii?Q?YBclQZF4NsiK44XTorPbxAbakPdK1b8N1lzoTK/5h0jYpwF64LZLT/dRIp7e?=
 =?us-ascii?Q?cCcyOvnEryTHHRsXcBVEZ+emF+cYsjs07BXN5JtrWlPe8ebSt8xMx4n+0yAx?=
 =?us-ascii?Q?4AlFe9facLHLWnlUpZFPpOhxbxZlGAcqwbttoDDba5Gus18KHrX0uQ9S4ySs?=
 =?us-ascii?Q?gRUjiA+PxUjPNZDE05ppTvho46viZ6V4hJv26WZJkaAWvwqVJFybP7RtKtmM?=
 =?us-ascii?Q?qRqF0wuRLsjn3u3hinqYHPoQRQu+lPU1dBPFMmzWHsbHVLK1Kw69dVqG2FKD?=
 =?us-ascii?Q?jif1XvyktfGHeWEr+ya82KIO+3tuCpT9PVXuObNrFDLmzoIu9VVLo/yDvJNv?=
 =?us-ascii?Q?NBdCHjlPq0BuCIpRHHgyQEuKDCjRw6mG7ZMb9B2JO/b7VvQxusj2ae7XpHd+?=
 =?us-ascii?Q?L6lWzvYha32eXVmFiiJOdTTMg0zTjJ7fKlOXGPhzmkVIR2uAnuysdKZgLONd?=
 =?us-ascii?Q?9kWnbWstNXO9pN/Ihenzazlj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da7192-ddd4-45b3-fa29-08d8eee5d17e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 16:56:50.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXOVNOY9YNcu7voU8y+1zmdy6CiCwIpV5L6k0NDg7WpwY+OBiKobrWMBOFDO51Pe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2779
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 10:00:05PM +0530, Devesh Sharma wrote:

> > > > -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> > > > -                           struct bnxt_en_dev *en_dev)
> > > > -{
> > > > -   dev_put(netdev);
> > > > -   module_put(en_dev->pdev->driver->driver.owner);
> > > > -}
> > >
> > > And you are right to be wondering WTF is this
> 
> Still trying to understand but what's the big idea here may be I can help.

A driver should not have module put things like the above

It should not be accessing ->driver without holding the device_lock()

Basically it is all nonsense coding, Leon suggests to delete it and he
is probably right.

Can you explain what it thinks it is doing?

Jason
