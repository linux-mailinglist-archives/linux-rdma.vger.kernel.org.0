Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A69F67D509
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 20:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAZTEG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 14:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjAZTEE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 14:04:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62810D0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 11:04:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYLmCe1UpT97mXuW4Hfv+BmuC+dJqkXPR2dOErj+3C5qkraWIERIhuya2jXNkxeamILX+1ivuRdc22hVl75LiCEb2mlmsx4TaQHE73cwyYm6r1B1Z7qyOmQgQAnmZZ7eVHt0/BKi03jlCEKT9xviHqkQjOk3LRoK5EBcs1DyTLTmrsPWfRvOgrj3/A8HMOQFCzeA9ydkyxv5T0hd2rW++nYC3BtsL/p49jRjwfKzV9O7G8vYxPMdPRgYN9Pro/LPeaD2UqEp1MeVqvUfW3ztUOnPOoQ8BAtQwmrE5dx+lqbyj8oy2syIfJdtQC5NOVTM5HVmz0Qoi7ZC3oCf96xTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+knIM1ZXODlVCHSL59KY/UjqLWY6BiZMoLtohA53HA=;
 b=hEbkUEootsj9ou9p2WBhUns3PvhSSlL+zt5DYO85xvCJEEKxf49Oyoqk9ff0eN4IavzufNgvtIzDK4MiBYeMz8ipcaGeQV4CbX1b8yrKaK5z0zkuAveJk8vYTFK/eUNnrlcNArlf/AhuL61Ln/xmc66lPay3rm8MdhrAUDPMiyDTMHTTnqV20kZKLIJfKw0xogzuPUe2E36uUx8OykifhFFYeD4oYo1CsePO6In8COmZHOEdEl3iNEJHzDz8bl8UME+m7gsVgA6mNS9MKPU+Y+LE+r7GZ9Gc1ZAhAe7WB0JP7IYckjOxfSsBCNThjfQdOKmFLTmNjo8HWON2+ETZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+knIM1ZXODlVCHSL59KY/UjqLWY6BiZMoLtohA53HA=;
 b=Qgqw/zkW5cgv6ME+QVsq8BoFBNoGWR/gjlwo9kxLrzBZFw6P2kxXmq1RoySEOfVftnuowF1weGz183bsnF9oluNumoe3hlS7t7BQFc0ydLWPX7sYjcgYxtjo1XE4SAWQsDHmAHcXjI8Zx0rCGuM/OYh5iIKJzt0syNrMaVIMr0QXlJBm5HAk5dZO8rU7hahQyifBkSzdGlx4rlh75H8ox7jq+r71t5o/36FQJ4tOVbsexkyrYneUUrtnMxINBpR8oeJP8yhATCDO2NwGrjzNbD4swH6LfVDCZ4ubNLIC0DNzStQ9sT80pp0LLxrqVcpiqcuj3ceiVf79N303wT5uKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Thu, 26 Jan
 2023 19:04:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 19:04:02 +0000
Date:   Thu, 26 Jan 2023 15:04:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-ID: <Y9LOoU5SBy3SNqoo@nvidia.com>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
 <Y9LH5kim0d5rBKOR@unreal>
 <Y9LJOHWYidVHBDMO@nvidia.com>
 <Y9LMDRBWH+L5CTio@unreal>
 <20230126190200.tsrewoziq5gf7wae@goatcheese>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126190200.tsrewoziq5gf7wae@goatcheese>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: fed1cbf4-500b-47e1-0fdc-08daffd01665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irmN7UiRvIVAH45okUCD3dowWtgg4sfcsbjZ7Gz7bZQbmC94GHv7t5+Yl1/Z7BJrh+dVMznjWDFBp9xAaHix7jJCetvBBP+OQ1ZqMyBXbbztprbyEDFX5FuwsYV197I1/LZsfcsBf73jwLIi8JrjpZKUSs2PgbhEONZlytcBdrwYBrSUqNAT5MqaYupTkZpqMGEa1NUdMfXTwReYWtwkqaODy2M3/JhJHZYFd3LQp/qk6cnyXybI5mQB8KH3luIowUp7IutWng6yri8KJZq/p4WQy0pYrVQz1+KCGVm4rtuMxnIpI/g/4dHVe5CKG1PG2Yu6gl6hdUHaYSoAP7c3xhiYBlT29JtGkC+GukGiHeUcyG40k9TOxpHFa3zOjCOjew43Y10qqAuKblu1H09ygyncYEWi/Ttv2HU9zMsgjU5voaKVljj8h0EFMIJWFrFkoA4GMBD727la2jOUjnUysmJN30IFSaxxBhE4t6fBWuD4xtVKSkop7wKb2iiKQkJmTSE3pebMYEixZ1ulEdwEDhLMZfKN7UyNDLKmZ9Q42P0o3SDJ1eoukAr97B3gy2a5XM6gshKsQAUnarE+NnauV1NO2roZGtvtwZvcm4Slu6kYkWFSfHb6A2qZA+Lbo5LSR1BTK0ugeu+yydseYJN7aKd+G57Ll+AICSMqbg82NfG/W7uVhVXCSNUw7Jz2IWz3bXBQKWRE+fAePbTvU88k/d7CKzMb1AI6kRH7QYB125hUykyw1q8+kzBBtWQgNExGwgO5u2/E918gsJ682wLfLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(66946007)(66556008)(37006003)(8676002)(36756003)(8936002)(5660300002)(6636002)(4326008)(6862004)(41300700001)(2616005)(83380400001)(86362001)(186003)(2906002)(38100700002)(26005)(316002)(478600001)(66476007)(6512007)(966005)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8lnl1c+tz+VzUtNKAwDBuKJkFABXCLf60opcXQUSWFfp3hevc4djTF0EJgTh?=
 =?us-ascii?Q?L3hWz3/hHrISUfBgorNQqcCMSmBZ5PuaCrkW1nwD3x7gIQZdzJXcOAeoCfyR?=
 =?us-ascii?Q?kFJAFIkpNQtTw0tCYFr7MlZDq6qsauzkTtFO3mKldI/IkRQC4Rrk5eUR1Z3F?=
 =?us-ascii?Q?A9Gy2rBXhMXhgMn7RglFiWnqlOsG0MqDJ/sCpg26b5zth/bRNPgdiPZPd5+c?=
 =?us-ascii?Q?ZdmG/6OzljktQbMrlQ1KshBTGZCs8QWpjyRGXPj9fipk3upWxqPOpNAHQUCZ?=
 =?us-ascii?Q?cNMh6MGd8PWwXIGkOsYWynPisQZWhR/Qf2iyeUNW15ng7HtWpeNhKLIMrOBu?=
 =?us-ascii?Q?+RLT2ku8nrI8uwayAOUaPdwzHJEOASYqjxEf86YTl+0zLhkylFFqZrR2PBUD?=
 =?us-ascii?Q?LS3EYvjcP3QxyulcHVooIG6FPBO8Nk6tQs1N5QPWXGy6N5NDffuQbzw2aFmQ?=
 =?us-ascii?Q?dXwkdm9Wyoarg+T/26JrG1BSG/PqLi34CcG3tp5RZXwi6RYutpA9VeQQ8rGj?=
 =?us-ascii?Q?fG6hN+BAv837SpoqsJ/K46ztjGwpOgeQeFs/Bq/dLSWymanRtEJ12QxsK2tF?=
 =?us-ascii?Q?zOkNu2uDCV9rvndnqU3oyocQs3D0vuqr29F4KyUtRc2suuvDlxnH+cFaNOmO?=
 =?us-ascii?Q?JBv2FtIqNo3FglMfquwXK7HifcoB+qQBydxsqLBZMV8foklkohZ6aAn6T1ui?=
 =?us-ascii?Q?n8w4t9lvZ47oElOboP3jdDYhBwGIpCkEmfeK4V6wXqDjs0Bs2oku6sIEmqKC?=
 =?us-ascii?Q?n87oYdwg7gAjApDY0QThglouwcvW+D9Et7b3RHodneFJpl7lUqa+g7GsQZcq?=
 =?us-ascii?Q?KPbNGibtz80HzBhDGeSi6F1hI1770M9qKTmjETnQqgYR+uEwmjHr67JCqzsN?=
 =?us-ascii?Q?lBDCUVgv47SWeL119mVeHAC7E3GmLFqQDzvCoeafmkf1OuMV24dZ1MgtYU48?=
 =?us-ascii?Q?5a3wUqVEKraRsN06mCZ6R34xCi1sKA3IFD1lKfxBMZF3QdukSt6enOwfN0V0?=
 =?us-ascii?Q?WyvS25i4UgtFs6GAJE81aaXRbb7UKEETfoI9Qg7dIKYozKrQ3xvLrJurWaBK?=
 =?us-ascii?Q?MoGquR27HrD2fAwOTjFEUbOJUhmUztIsf40U05G2fHvmdamEjDqQSIYL046Y?=
 =?us-ascii?Q?LDVLHWVdcfGc/YUD2eYqoJQoHRzg7KQrZSR+xtf9qn91t9jtKU4ctRCpjbHK?=
 =?us-ascii?Q?yopbeMzWqOHy97NRsBtadpmxLIGhmDn2gWFwCyQC2sv3825XN2aMrvD8TikX?=
 =?us-ascii?Q?ifXczhK6avlj9MWDpxvnNl//mFc0GoMpeXETToA9M7zjCs0OxklGSvxIEMEj?=
 =?us-ascii?Q?iKIievl27Z1paEgKkbFpUO8PutFqt5l/pa/huObJ3rrX6NRl82oh+OcBPDNm?=
 =?us-ascii?Q?jtRBjIjVFpKY0eRLePZ9TzYNHUNNC/hPdbyn7cuwrs9PgiifRc63k8I8wJiT?=
 =?us-ascii?Q?9b4jgr9ncB+ywzU3AJLc2mGN9/u6dNZKEXzHvMMZWjOhTt/9kQQ47VkSLTy8?=
 =?us-ascii?Q?y7qziwrEycg+VVQyzdIGUTLww8SJpOBparHpSAASat9j9N/m8Bf4Lax1pUl5?=
 =?us-ascii?Q?DUQVvaXbM3ZRTMG1HmpS2n75mOqjNoFsn3r3tAix?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed1cbf4-500b-47e1-0fdc-08daffd01665
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 19:04:02.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9VDVB/TqBHvxra3Lm5SnmAOqc1BBd4SbuSwLpaftRTzVtCfOIB+2gDckWt+n0JT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 08:02:00PM +0100, Dragos Tatulea wrote:
> On 01/26, Leon Romanovsky wrote:
> > On Thu, Jan 26, 2023 at 02:40:56PM -0400, Jason Gunthorpe wrote:
> > > On Thu, Jan 26, 2023 at 08:35:18PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Jan 24, 2023 at 08:24:18PM +0200, Leon Romanovsky wrote:
> > > > > From: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > 
> > > > > Make sure that non-enhanced IPoIB queues are configured with only
> > > > > 1 tx and rx queues over netlink. This behavior is consistent with the
> > > > > sysfs child_create configuration.
> > > > > 
> > > > > The cited commit opened up the possibility for child PKEY interface
> > > > > to have multiple tx/rx queues. It is the driver's responsibility to
> > > > > re-adjust the queue count accordingly. This patch does exactly that:
> > > > > non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> > > > > 
> > > > > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > Signed-off-by: Leon Romanovsky <leon@nvidia.coma
> > > > > ---
> > > > > Changelog:
> > > > > v2:
> > > > >  * Changed implementation
> > > > > v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
> > > > >  * Fixed typo in warning print.
> > > > > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
> > > > > ---
> > > > >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > 
> > > > Dragos pointed to me that I sent commit with "old" commit message.
> > > > The right one is below and I'll fix it locally once will apply it.
> > > > 
> > > > Jason, are you happy with the patch?
> > > 
> > > Why not use min?
> > 
> > It doesn't give anything as we are in legacy IPoIB path and it will be
> > min with 1 anyway.
> > 
> To add to Leon's comment:
> 
> It is making it explicit that IPoIB is using only one queue. Similar to
> how ipoib_alloc_netdev() calls alloc_netdev_mq() with 1 tx and 1 rx queue
> for legacy IPoIB when the parent interface is created and also when
> child interfaces are created over sysfs.

Ok then, Leon please apply it and fix the commit message

Jason
