Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB03FD911
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbhIAL5I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:57:08 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:25985
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243865AbhIAL5I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 07:57:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtbfuUj/Kvd1G0uNnr/6K2TfxF/nkLyAenGg5AvXGay4ZLB3wjszWTLfyO/fV9QASCm7LQGr5w11w2Gc3MJbjoYoCik7xPe7e+T+0ditl8txtpP+sJWsfIRi2rSVxODzF5R0MA5f86R3IEZh2maoJYF2m9Bg6RmBjj5/5/mGTwx9zbPz9JrPd7aYKNvXCRch5Xev2yG0Z1hYgMCv/1yZUt/sl5j5a0K+Wh0f50YWdqQeg5cZvMft2sSdkYlnTdLDO7Wfc931S5WQvyttP5a+5m1zncEd+d7BgDlnO34maG5pZ3QzyeElcjlXmBKWGB8yC4cbxEbC/r2woXnPrN29rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ZwyG1trlqSaddDS4r4A9bljMyMT/9fB3KD2AcQYr3fk=;
 b=kqjhTmT47/aSQVHdlmZTWSL1MYhH9gu6X2G/hbzzqStqd/iFFUql+gzFMViX2PjO9SWdxGKCi/1N8aa3Kjp2i3Aa4UOlEGfKHMcxwqG2KBsqUEZ33A2SiqqEAs5g8njp+kIAcMRpQ2sVrs5CTKngGYyxoGEVxZ9EZx7tYDg5SocFEiYVOLahVsY91p9ndnspd09ZcUzFWPVYAy6KMb/eDSwYpxz4AUB1wauxZgWj14eYarEfH33WlIQq7HPjJn+wCLo4JxbWliRORbQ7GFhZYLm/UOBdrd0XSxaI+Ljmyi5mr7DX7oAvTLYH1GOsrxBNcIZ8ymnKYhl16U2OFRJMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwyG1trlqSaddDS4r4A9bljMyMT/9fB3KD2AcQYr3fk=;
 b=Ic1kkLSD8c8eXZTJj8FJI52IqMGngwnzwtcJ6pUu8jNa9hMljPDDnDG7TSkoDqr4/f9Rg1awYQ/2YduWx0kMp8rJQjXrM3/h8UgyLIJ80/e/q/s9DTHEv7LfLEHcNQeweRCaK0CP9bXzoG6aSnTl7ZmZ7BmWAlCvoKaka+o/LnPiKl+SXPjal+6/GJaEa9cj985947TXQjyOCVyswUjg3Ab1JttXUb03t3cPZzT1/AcibUT0SJjbz6BNqps9OQYHhBZbHPBHZRjSjvkoc+VzQIMMnTfOIKmYoXOpKOE7K68a+LY78dnTnZB3PU/IJTjPVn9p8HbPBYcfwVHCMIVPkg==
Authentication-Results: raidix.com; dkim=none (message not signed)
 header.d=none;raidix.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Wed, 1 Sep
 2021 11:56:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 11:56:10 +0000
Date:   Wed, 1 Sep 2021 08:56:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chesnokov Gleb <Chesnokov.G@raidix.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <20210901115609.GF1721383@nvidia.com>
References: <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
 <20210727173709.GH1721383@nvidia.com>
 <4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
 <57cdb944fa6e445c97692328fb2435c0@digdes.com>
 <b5b8b842-897d-5cad-1f32-a212c9e91737@grimberg.me>
 <c6827ac071364d488a3115d2cdcbff6e@raidix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6827ac071364d488a3115d2cdcbff6e@raidix.com>
X-ClientProxiedBy: MN2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:208:e8::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:208:e8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Wed, 1 Sep 2021 11:56:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLOqf-007m5B-HB; Wed, 01 Sep 2021 08:56:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 711d75a3-af14-41a3-09b3-08d96d3f7d40
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5224E42D9633D5E9233D3AB8C2CD9@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIZiI+4eqO+U76RKSu0PQCaf9HM4GBlCho/lT3DELynUg1uKuP+3f5KMiePhhhTP/CMPlIqNE8IpqbDnIcTfFjrxYi0omwQAChvkw8Y8qPs9LYgSavjLwcYVxytvUyYmcO0z7THDRB3SOpUGaqcg9YAbz9jgpeWVGtkprtKZ0f72tHotUr9Q4zZHuFnzes636hAXGYmvqsDf7l+TndNkBMoMVzJrXc/qY4VDOsYhJcx3MA1NQLEp12Wol4TUsFG2DYjF5ug6UWYa59mpRwAfxbNRml/fu+MM2NTUYUmJhJ6tvhTG6rzf0LD+R/zas+oYY40ALzIHiM04Smgf4uNMz8MnaODzrjYdBlDZaHrxvD5ue2pFYqGDCZxYVu1r9uaKoX0QicehLAiBpjr7/NiAQul9LpTC3m2tJ5BSZDmlVib3fBGFO9F25FwJE/FQ08Rq98FUjU/pAqmRTJdOrRF6QxBRbTkVMdSBI8qsrvoLxX3dKpjjpslZaRUI7utwTiIZJj1wpfhQTK1J517jE9ivnIOXEvOy871tiZr6VdJKL894Sxic6+1CtmijuSVG+li+G26vvrfZdqBrHK1CJPnd0EKbOSgOqzwRo8NSNBAFDyQ/Dh8l6+dMpnzRH400vs6AFDWjtMPaTeERmx6hzKrHlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(38100700002)(478600001)(5660300002)(4744005)(2616005)(33656002)(1076003)(36756003)(426003)(2906002)(4326008)(186003)(8676002)(9786002)(86362001)(54906003)(9746002)(316002)(26005)(6916009)(66556008)(66476007)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7iiedHUEZwAP0F1n0iETVyEX5yLCUtHrU7WIR95Ylhpp8ifpqec9Q90CWWIy?=
 =?us-ascii?Q?+on7zexMw/gN7Twl0ADOUR4fn6WVxIWclAHgPC9BUpgIZr3IOjycBNgrC8ON?=
 =?us-ascii?Q?+8rZk4Yvh5H/0h//UlK7+hMuBwMk0vtee2gCCDRh/nIRJN0iRbeHdVUw95a9?=
 =?us-ascii?Q?v1+hAz+eQCMKi5roYwVaijm9q1lVtLoIl8jROmojZsXCjOCJFOmOtoWHr73C?=
 =?us-ascii?Q?+ZyzVjiyDXlz2Cwfw+f2I05ItGiqQQItoxdirv46vZ6yV8f0Yk4G+YeO3Glt?=
 =?us-ascii?Q?Pxm4Adx9/QmkTzJ6zcQUwD6AleLnfLI8FP3C8mtCgJlQAYl+sXYTzsOb8M/u?=
 =?us-ascii?Q?F5lzywAVV32HpOlOhUny74FV9edsP3taY4VmMwRhUtwx7m1rvdgCUtIy9vZl?=
 =?us-ascii?Q?X5Xkvk9B5CjK8N4IfgIJj1KeGew7H7RvdlgEvqHSJUMQWS8DqKs3JCY0hvpz?=
 =?us-ascii?Q?nhy8N6PEOvyZhpW7CWBgXUwSp6AOuDqxrbuea9OX+QhFvNQ9tKayUmqzWTXF?=
 =?us-ascii?Q?qBLRPpTHKA+w2D8YL2n+u3JvAymNn3QZak8n9lQv2Ko+Ni/ywnr48Wqrd7GU?=
 =?us-ascii?Q?3eruVhr4vJVYmGCFNOyGUswjpfdj4ORhU1DfB1EmR4FU8Ol/3+oT620oaCAw?=
 =?us-ascii?Q?zjcb+eIQeYow0fh3GheK/8N+/u0WEsA7Mp6sRxT20l/Ho9+YfYlC9Nia2yrA?=
 =?us-ascii?Q?c/GowNKOF2dZEg8SsrJV+rOT6ndgwkah9jrLWZ77aENbY5xBf9voVxhzBJ/8?=
 =?us-ascii?Q?cDSRHAlAp3WjAPMYAoFfQhanfJ2yx4zmkzSfNBA1N2pnyTyFZGzliqtcCr1R?=
 =?us-ascii?Q?dhnoRzsVAOrI5aF16Pz/eyo3X+uI2AT4nFcUX32Fgzwr6dteD+5+EtbChLKG?=
 =?us-ascii?Q?L1njTb6nWq9Co+oHxC9h3JpxHn30MxIE+esmdd1kHkvmMMvIGISVnPx3INdD?=
 =?us-ascii?Q?plS3ZcARszm5xvbg8BDbXcOpcmAczwPtBtPTsz5gMKtG5sdDFMW9Q06m/BRM?=
 =?us-ascii?Q?Ybtl1cc2CAxcEbZ4nKCR7723RnjKBwNBzJ9T5IjkwHANJNBCJe7RkmrOPd+D?=
 =?us-ascii?Q?/pov5R/xIwPXc+fM1gHABMhZLVfnMGM9MgD2XVS6Hc059A1FqV91bUgZHCbC?=
 =?us-ascii?Q?bqs4xoZNQXNlT5vEF3UDtOb4DKhOBuhxKBjI/Xxym868CvHeH6v9+PXWPC8m?=
 =?us-ascii?Q?Q2uaDvDx+lqE/7oLb6vYgnJqT96xsjjjSpvPRL5MT0ybrJgQXaMvwYuAUnAt?=
 =?us-ascii?Q?/kMrvpeoWHAd9yDv7G0Dih8Rv0zOMCSr8KhAi6GEYRkqemwIe+8CX9if8GUp?=
 =?us-ascii?Q?/fi/RPavEeJdWbEE0aB8FW63?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711d75a3-af14-41a3-09b3-08d96d3f7d40
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 11:56:10.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYDgq4NmQItoA+Paq64cgN03e001uatoESW/PgaDG5thMTzI1ip+Zp+0AzXlp2lL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 01, 2021 at 11:43:34AM +0000, Chesnokov Gleb wrote:

> b) listener cm_id does not need to be recreated,
> that is, RDMA_CM_EVENT_ADDR_CHANGE is informative for it.

I depends on what is in sa = (struct sockaddr *)&np->np_sockaddr;

If that is not a wildcard then the listen is only good so long as that
address the one assigned to the interface.

I'm not sure why isert would use a non-wildcard listen?

In any event if the isert_setup_np() was called with a specific
address:

static int
isert_setup_np(struct iscsi_np *np,
	       struct sockaddr_storage *ksockaddr)

Then the np should operate on that address, and only that address, and
not quitely change to some other address during operation. So again I
think the original proposal is not right - though I don't know enough
about iscsi insides to suggest what is wrong here.

Jason
