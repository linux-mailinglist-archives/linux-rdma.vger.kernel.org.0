Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EF334273A
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCSUzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:55:03 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:22880
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhCSUyf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwVtQkmCzkMi2pU+mZ4u+iD1U0KFKJSeQPpCR9A05/uwpK4R39zxwXi5VJ/MfHILlW8g/YihNcuTIk3KqH6D0w5qvAoLBTYACoZYojvibM8iKYa7Z39vfAhhP7fP3biGGOak/EjR/8WIbU3tKMRVj+AlKSfCYtWlzXN7w8GR/uZuP5vX8uKIln1ODc7L0rHOoWzNSFudwHOKDEln9AYXvCXw8yaSuT0jmlaP8bMpNz6YPFGox3ec1VdK980KBhcfe566z+k5NkH3NPImxt68sdpcsY5e7PYBosNVdWBpIEmp2to047SKHDI2jYSAIfEpP0VLGVx4huq+pMj6kTPoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/qaAs6yV2FxkfnOYGlcI/zpvugQGMbydP0dTjw/Hmk=;
 b=J4RFRzT+VAWau0jesl8sAPaHSXp5WKS7XA89w1rqsaRt6Gmp+Oc9qFvvDYbxIC1ZxCWLkr8eHxHNV6L1Bm84/JAu9lgrRZgomcubdcjdnq2VvW6AMYo2i9Z1og7fKF5tSPvmKPsvEY73IYNmEQ44OJVd/4U70ee0QRAXQcpnPbrnrA8xZD6leN+EspkU1Z0sG/O4oza6lcWp83jvDkRQdFk9Hulf2+ydJ/fAoRJHbdwHt3WMp3uY1jwfTyCG8kbty7mEli71CwF2UQRY7w1pKOjH3/DWcSYf6YGj6q3ie2/lKyCg9HK276xhCCP4jrvbGQnWiXCz40bPZqw00cFRxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/qaAs6yV2FxkfnOYGlcI/zpvugQGMbydP0dTjw/Hmk=;
 b=bDLbK01naVjmcfUOIGYh1WBmt7+NROq1/+5/Qah1mNU9RQHCcWdmvH++iHQJoY3ncIihF3TKPyo/xW+J4GqSeoJ272BaZSOflgPR9bh6h38RPZCQHH4t+ECPXUb9q6DERgS+qbxFqslFtpHt3eDE0X5n1PG4haTOirS1IYBqO3Ru6+SX5scW8rTzR1qK55ET0A8p5ySWQKTqlW1XB3crCwIpcmxLQ4Nm89u+H7dhtErXljd8q5jOiIHPc+tzUMP6sPbwuzTmVv2cBnGXRLVzCz4kvemh8N+6xuhxcOEd661hDWx/WLLDunKNM85pifRTm0ZfdMC+HfTFpdnjDulHTg==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1434.namprd12.prod.outlook.com (2603:10b6:3:77::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 20:54:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:54:34 +0000
Date:   Fri, 19 Mar 2021 17:54:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Rimmer, Todd" <todd.rimmer@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210319205432.GE2356281@nvidia.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0033.namprd15.prod.outlook.com (2603:10b6:207:17::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 20:54:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lNM8e-00HSqn-98; Fri, 19 Mar 2021 17:54:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab08c366-a75c-40a1-9baa-08d8eb1932ee
X-MS-TrafficTypeDiagnostic: DM5PR12MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR12MB143455154B3935AF318FC8BAC2689@DM5PR12MB1434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1U0YrZPL8x/VAcUxmXk/i43RCfCEjevCEMkqSUOjZ09ZQCdDMa5Dz8HWSuVhyShO8mXj2bKepAItocmGLZEcSeHtOwC0sqFtWm/6a5qcH0uk53cv/qb+1qP+FJHY4uGsrEwhg7V49L+xVw92FO4Sf0MvDx1LVLuQCAjYoeNlNGqKoTREHTQvEYy8cmGMbP4qqgrk4ITKCZGDJA+ca6K2SfcFVVvTIrVt31cgCQoNDcIqNkj/XROXx3dIYXsrnWs6URjeT48B+9B40kg/7ivD2suYmZLd1M0NbJ5gqor3CMnh/UOTRalLvYYiYQJg0q0r1Or1hGilJ4fR7yThemNGZUFkvdMG6Qi+YI249ox9F762sYWLWr3SbD1IEbSPjQBVFYLgKmJ/whGmhz64ffkrpjUT8GMZqyJNkY+xx0HQbIooWSR64cc6Sp41DwY0dBqzZ9XHmah01mnIi7+9oT39jex7uV/MSPiddc+imiBqlGMGVeoS3xdVFucLSS9TuQTwhel1p/eM9Z1ekN7MuyvGNsHxR1/zsx0RGJvjVLe/9xn+FZJuHkwFR1PUqkBVLqVIanVGui/jqvwjdni+U756tqcQ5lJm5JqNnhiAULlTQb+JkCkepyoSSh+XNZX5zFLU22Y4V+mpZHWof/OKHPT5BocaUAvbIcdjS7DukMFnH/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(5660300002)(36756003)(316002)(478600001)(83380400001)(86362001)(2616005)(1076003)(38100700001)(426003)(9746002)(9786002)(4326008)(66556008)(33656002)(2906002)(26005)(54906003)(186003)(8676002)(66946007)(66476007)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5RBucDA9Gs/3FfM4JlSPb2crHuOaom0AYwb/oyrDW32LV7GxdpukSm1kAuti?=
 =?us-ascii?Q?vP9Yj9DWcrXPrRXAN6JCALW+aNUoUhHPUow9H1+AidC5ntfe3Md+BkzN57+A?=
 =?us-ascii?Q?ZGN1YU5u3Rl1XiS3ab93/aWfsCDNsMUgNnN/mJA1Bs0pGh5t5+kT9DFplcLM?=
 =?us-ascii?Q?f5GMEH+Hw7ORptAQuG8K4FIMOwvDNKst2xjTVlk/aCWiJ/4+GFdblTzdzmuq?=
 =?us-ascii?Q?EX/wjLgTUo9lWRHsNykgWTzLERDI5pi8cgUNmtCQjzi6EBDvy20xWpr+/JvO?=
 =?us-ascii?Q?gh1LRHvSH+T3eCD1GZCJOialK+OYUU7j7KiALOBRgwvAE+RD2TcIfhX2Fkza?=
 =?us-ascii?Q?8uaiADYoqYvZ6z1cgTgWDYPzIMvo0jxFAsPxAgr9zHpj+6d9zSo9vQW6U2Q+?=
 =?us-ascii?Q?8HotTbE7yssD0flm55rIixQjNgHoNoQTjk0cKj13cmvIacISdgQvofyFKf9s?=
 =?us-ascii?Q?7UZ/1sBfJodfdHj1rkmWJH0gaL4Y+iiyvWh/F6jMK/gkAcyK/jOZplp8z+E7?=
 =?us-ascii?Q?rvkh8+jw3NLwQGjUSKOVxUm6a4U6iK8lZJjFGuswMywe3+21NMh7sVvRvvlH?=
 =?us-ascii?Q?sZBIH7u9Ulh9iJkSqsluBnk80R+1TU6uMEVP3P6pLNYBaRdkulSHfx/SKsJa?=
 =?us-ascii?Q?XXvfu25ieKZNuu1jPM3AtP83xJ/JBBivYT+g9ZVHgzn9wNU+jITBpYXgPUH9?=
 =?us-ascii?Q?UOWXrU5qSGKPQuYsOOYBnk75RUoKDqkjQdzCU7JoXCozjNXb1+Z1qwFUdOtV?=
 =?us-ascii?Q?cbJyDoxG2nBEr+klzt/KS0WaIWlQ8G0lCwymSVcFlfWco3sPQxU0FgtUiQnZ?=
 =?us-ascii?Q?JSUqXICbNluD2hBhanz6AL7HYB3dHPoV5w6LYq/vRA1NJ4EXg9Rilx0wfuiG?=
 =?us-ascii?Q?VnGlKr0Ki6ktgbgFyjqnGpayTiXYkjunGM7M8hryqLoNEmdbI9768h0G9ufX?=
 =?us-ascii?Q?QOIjvGQMQauLnkrnTWO46ItSGHPwioIdTSwuTfo3DS6bfZxNMmOG8oGviAG4?=
 =?us-ascii?Q?BK8nr7EAhSnJWEduYrdfZcECd25N8ASIhwnemlDiS6RgLlLcmOERIB3qd8Rs?=
 =?us-ascii?Q?5/j+P2XeO45x6/jjmGgmond35g2IyRGteq8EZXJ7ZpytXyNucy8Virg7APkg?=
 =?us-ascii?Q?+u2mfWLzb4TdThOTMF904dgJFxKDtXBQhszvzP5bwhOhdiI8toGfFkQ/gmOb?=
 =?us-ascii?Q?P0UOpQYRvQqSzufnQuZooOWW8FkHFM9Q3p6WnIXXyQUeGK0Yym1Zw4VV63NL?=
 =?us-ascii?Q?K7j3ZYOOZCCoG0MwhT83TFjfJontXJ4gzaz5O0Tw0xvKTOkkUcEKyiAUMWhY?=
 =?us-ascii?Q?dYvepo6pcLWo2EGN10WwTfxBaeWfyLf6aOTcHqYsxLAW+g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab08c366-a75c-40a1-9baa-08d8eb1932ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 20:54:34.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V6MA8xbsQNufIUj/tyGjYzE0YdOShMzEq5Ink4gAk/tHVJV5stqdxsCEBvAY6EZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1434
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 19, 2021 at 08:46:56PM +0000, Rimmer, Todd wrote:
> > I'm suprirsed to hear someone advocate that is a good thing when we were
> > all told that the hfi1 cdev *must* exist because the kernel transition through
> > verbs was far to expensive.
>
> It depends on the goal vendors have with verbs vs other APIs such as
> libfabric.  hfi1's verbs goal was focused on storage bandwidth and
> the cdev was focused on HPC latency and bandwidth for MPI via PSM2
> and libfabric.  I'm unclear why we are debating hfi1 here, seems it
> should be in another thread.

Because this is copied from hfi1?

> > What is a UD-X?
> UD-X is a vendor specific set of HW interfaces and wire protocols
> implemented in UCX for nVidia Connect-X series of network devices.
> Many of it's concepts are very similar to those which ipath and hfi1
> HW and software implemented.

Oh, there is lots of stuff in UCX, I'm not surprised you similarities
to what PSM did since psm/libfabric/ucx are all solving the same
problems.

> > rv seems to completely destroy alot of the HPC performance offloads that
> > vendors are layering on RC QPs

> Different vendors have different approaches to performance and chose
> different design trade-offs.

That isn't my point, by limiting the usability you also restrict the
drivers where this would meaningfully be useful.

So far we now know that it is not useful for mlx5 or hfi1, that leaves
only hns unknown and still in the HPC arena.

Jason
