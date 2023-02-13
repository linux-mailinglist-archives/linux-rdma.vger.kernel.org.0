Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C86947F5
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Feb 2023 15:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBMO0O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Feb 2023 09:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBMO0N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Feb 2023 09:26:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9359E1114C
        for <linux-rdma@vger.kernel.org>; Mon, 13 Feb 2023 06:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUOBM+IGxSbQ4VVJBu6o1IkJS9bxvfGgRkynZLqxQoUm9YpRMmGebb4gH2cvJoimwUaurdP3aiKPNWtd6W5GNFEJhgp6QTXifHI2lJal1cfkO85n6kQvscYTRmQBpryvjHBYimj+azO57qdpXeqq3hKzVvLBazkI4BlKFzSWChynE7Tc6kRIBJAdRL2HmNU40ZHJbYdFiQdQfwWBK2dpJinoRFzHXYjzWO3nWLWqvRQGKYZ81SsYDUgSPymQ8Bk8yqeEdsUGxek2LReyLBlLjgG1x3/wBVxWGtSm5AYKAiQ4Y6srp67TmjLCGOO93A2f3orc1gIyrWAw+HESWMzw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRoBT9X7VpTOcZ7nYRl2KC+SLwgCCEKcmbGx/BHQJdc=;
 b=SkIWNMckyMDAPRI5A46roFU1tFdkpka5TBJGBMywduHQ0ONn7zkIopx5UAS2hSEoNDTqDlCyxvLe62jSwgzgsRITJgXIuAirfgiw1g7i0IsRkynMvjc1aJsVexVEjy2Buu7yKUiOnnX92PMxDDXMnxS/6vEDZm7aUlsx4cT6M+li2Iy3poFjCDBxAaI52zjkjCxEHIT0RyckI3biLp3IkeCc+TrKZvtd5Puqw/qazujfiEWqNleWQm0apyLQ+LywBnVGIdSnlcKfSXz97/8QmyL0oiBlI9bi9TD9PLYz84SZ5iSyYyCHY+7plmO7+NEbdmPZgG3e9rb5vT0iWYqRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRoBT9X7VpTOcZ7nYRl2KC+SLwgCCEKcmbGx/BHQJdc=;
 b=dFvMtAmXk5LzbsrF2P5N+JGsqWFij7PEenRDjKe8vAw7RlGgCSzdqZaF9wnO832UcL2rHRdSEdPWANLPtc0e1TIfP1tpjbcprye3lb4Fh9YR5f3TWCtnQ/FoGywGDrdkT7STCLojbTycudNQUCutOpXpD8Ryzv5PhMIL1ZuKwQ2OhJm0lMuThHYpaWPw7VhVoFe5v8O09gkMAouPVcbIOmgUl+oj20eTeFXr8n4kTVdH78lzaEZnTa1iHR/TxAxNeYVHk9+PkmROSwxH0Ncsg6VRLSVJpp5Bi1i/XPVVPcrFO3PxLCXk3dnC/5JVweyumNLLkkWqdPNMXQyG1QsEDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:26:11 +0000
Date:   Mon, 13 Feb 2023 10:26:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Sindhu Devale <sindhu.devale@intel.com>,
        linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com
Subject: Re: [PATCH for-rc] RDMA/irdma: Fix for RoCEv2 traffic after IP
 deleted
Message-ID: <Y+pIgRtPanNmqqLN@nvidia.com>
References: <20230208162507.1381-1-sindhu.devale@intel.com>
 <Y+kq5JZ6/BjZgy4e@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+kq5JZ6/BjZgy4e@unreal>
X-ClientProxiedBy: MN2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:208:120::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: d00fbd2a-aaa9-48f0-70af-08db0dce40fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFHsLFx0mzNBS/kXBOu/q4/gpeKJ/M1GFaQFGV3mpiIc3z4eBEzk/UBl1ozlpmHFitlZdI8bhnn/XtbGolsBvIy2wXXIwteTc3d4THG7H1KYOWW/Q2OLyovkBByN3PgnuMQ99lHdJmbM6R8M6QaRz/kDj0HTdKBNheROk7zLujP7mM/PecnJx8olbOBp58REk2Io0fKbYatq9ybAkVomRRG8F7HUYxoAwnfA4actgMSKSGapUkZC1kgDAZWw4Upl/VOBLQbEiKD2b3ZTtNkYDgr76G+jltdufFtVlWRyQQMbg5OJ/oCpJ7H/sKstqg9ezfI0nYVcVAiVe0ZhuEZDyVdQ6tE4q+qcgmXAusDW3JpEV7OostATiY5Dcl+nvzetJKi03X+haRCPHeh0y4OH6dG4ul8Phsg2zbJK0m3eOwVmJwXV6yTdNGDMNoDl9hVDcc37HWBX4M7ByN9chDm4Ncye/whrCp+SsYtf93BaeOtFGmDfypfRYRJVjMsXGavW/mArH4f823UDt4zYTklDPBTho+dmNqe/IwBgSbkmSeQj+OhL0/0aw108mD8+Ox+KNCJvBwW8GntQpvJcrLDZqWv/p+ls2c0ONWp7FJ4OGit7igYENKA4AQp7zkPw/VenL6bHW/x677cwuXr9y13d7y3SezP1e2jx9k04t0SoGzn0ZyR+ieJF+127JArqIbIc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199018)(8676002)(66946007)(4326008)(316002)(86362001)(36756003)(26005)(186003)(6512007)(6506007)(2616005)(38100700002)(83380400001)(66476007)(41300700001)(6916009)(6486002)(478600001)(2906002)(66556008)(8936002)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fIPHdObg+sLjuEiKy4zMX8b0MkIo6A/tYwbDaQk4a0YJpv5m9V6dA1Kenf9u?=
 =?us-ascii?Q?5Rqqo7WiengNkEkejYY6PR/gXDYy5qha4we8FvdsYHzVBVvFhDMt8CnbwncP?=
 =?us-ascii?Q?0v6wXi6OlE7INnaJP5JUFD8xpsrqjexrgF31pvuNKW7CwXxmDDhGGfqFHqnk?=
 =?us-ascii?Q?p0bHT9g+uTvmfu8fZrKfnKuLKgQ1tP8fpBk/QP9jB4gyOD9FL+aZ16U4jrSf?=
 =?us-ascii?Q?HGOUp8FwZ2NJsEtenM0aZXx1eSk8NZGmIfwZyw1oEDviPhUoWPzhvrIM3ZXU?=
 =?us-ascii?Q?nTx/Q0Pe9784zWI73cJHIRXEbT0YWZg4Udj3J2ujCIZlelNQ0hqDgbLtqWt5?=
 =?us-ascii?Q?JmVzRHKbNApHL/NS4AGux0XHDjglGhRf/1Kc33n0FKlHnwOnrqW58hdU9mPk?=
 =?us-ascii?Q?zD05Y04QsYULHeka0MG62Rc3vI360EmyiUc4J/EyZi2MbyAsZ2+Nq1AR5PeK?=
 =?us-ascii?Q?flQfZVMa4av0O1hDZxJNrCmzjQOeXy5w6pp20npsP4Y4RojuIzJ+2M7lMz9a?=
 =?us-ascii?Q?9cOHNP13SXguMYzuCsQfNmSOxW6PpaaqDUk3vYVJvYUV5Q+3S1fLzuljWy1A?=
 =?us-ascii?Q?2E2WXtVgHnytjS6y/fFlRWVmORyh715qNu+B02/dlzZhHk2yKJtpa2X+QoYX?=
 =?us-ascii?Q?DDOdLWHxeujCTC05pL/OfPBf7UDCPihfwSv6jIkrXzA800u7CCOlYZCL/tpJ?=
 =?us-ascii?Q?wooS24f4wJbGOBAGukcglXYm4lUxLcUvpGwHWV0DudumxRsTTa3VRfS/4ygj?=
 =?us-ascii?Q?9ziLyX8w9yxgl2svjhIgEvZsdhxGEFmxul3weXfxWMlBe5Xv36YZMmGFJnx6?=
 =?us-ascii?Q?Q97HL63l/0e/Lr337V9d8hJG8T+KRyaxJrJIIUzep/cFVu1kQFXolzvspb1C?=
 =?us-ascii?Q?JExWrHvaEuCodGviz6QmfFBQi1HsKrOt7BfuVLG5BvBpciIAwcpI+HnO3fha?=
 =?us-ascii?Q?rpf0pGE7IP/n8rxm8GdHwazYnG4kgwJHih2QtN1b/s3fA8Tu8/OlTK0twXTw?=
 =?us-ascii?Q?oWwyUQ0kDZJCHVg7pnKmjF6KU6akzo2ejNK5Z5hTLuvj2ldx9cSwBTKKvYlZ?=
 =?us-ascii?Q?jWiKCvYQrnYFgueQzgTb9hltSY3pdHq0arOzsBB3sfjdY9opzlhfmKHEzkFX?=
 =?us-ascii?Q?DptWmKKgdr3Fyc/sZYJCJNddmlOPM4Or3zW2WzB4P8u5UOJpH1sDbCXwnVRl?=
 =?us-ascii?Q?mk6ZgpcjYFlmlbuVCRY9/F8W9wV6p+hVjnxlwnNGMH6lhmA5ws6dPgpr9ko+?=
 =?us-ascii?Q?KhcDok98B/Y8Zw9Kuap5kTBeMRXCdsBXGPAJiYRsk15cHsD062/Z/Ntvg2Y7?=
 =?us-ascii?Q?+CaJ43sxXCpciRnoENklf4OiNDfFUHRl/ptcwRa8CPrPu08KuoQKJhzg8Dq1?=
 =?us-ascii?Q?K1kqWfvJBLh+6Fz0oLZ6Ypv/zKM6iLDYpmvTynxhi1VpodP0geBa1ml94XkN?=
 =?us-ascii?Q?Q8uowzWHXLrYh6vqB4zX0QV9M9PS/3SwjBUpsYrl0CXb0MCJcKqcB9/o3MhQ?=
 =?us-ascii?Q?FXrpi3j7kjyWqTytCC8H4QoCV2NdmNagpKeJ0ejpSoycL2NctnKClW+ySZag?=
 =?us-ascii?Q?zYIRP6c/Q1KhU++Of4tOp76aNCKoQZVPUkRk8WDu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00fbd2a-aaa9-48f0-70af-08db0dce40fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:26:10.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fd4cSGGYLvuqj7zRMG8KlLWhVp9Ol7vL6HzYg7OxpQA6S9eYxIujoquFd3ZLzK2M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 12, 2023 at 08:07:32PM +0200, Leon Romanovsky wrote:
> On Wed, Feb 08, 2023 at 10:25:07AM -0600, Sindhu Devale wrote:
> > From: Mustafa Ismail <mustafa.ismail@intel.com>
> > 
> > Currently, traffic on a RoCEv2 RC QP can continue after the IP address is deleted from the interface.
> 
> Please break lines while you write commit messages.
> 
> > Fix this by finding QP's that use the deleted IP and modify to the error state.
> > 
> > Fixes: cc0315564d6e("RDMA/irdma: Fix sleep from invalid context BUG")
> > Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> > ---
> >  drivers/infiniband/hw/irdma/cm.c    | 113 +++++++++++++++++++++++++---
> >  drivers/infiniband/hw/irdma/cm.h    |   6 +-
> >  drivers/infiniband/hw/irdma/utils.c |  27 ++++++-
> >  drivers/infiniband/hw/irdma/verbs.h |   9 +++
> >  4 files changed, 135 insertions(+), 20 deletions(-)
> 
> Why is irdma special here?
> 
> I don't see anything even remotely close in other drivers.

Yeah, this doesn't seem quite right

The GID table entry is already made invalid, this should cause the
drivers to error their QPs.

IIRC the GID table entry is not reusable until all the refs held by
QPs are released.

So, everything seems fine already.

Any driver support certainly must not be driven from new crazy
net notifiers.

If you HW can't handle invalid GID table entries properly then add
code to the GID table handling path to fix it, not this.

Jason
