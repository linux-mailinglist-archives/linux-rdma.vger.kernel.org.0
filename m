Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7693B55CB
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Jun 2021 01:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhF0XR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 19:17:57 -0400
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com ([40.107.223.51]:22752
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231491AbhF0XR5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 19:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj5lOwl3nPx6GPyEy6wx7MIXqmoW6prU5p5+UgRQmCKuTwM3UybQc90TEoZK9D8wt071jLQ2cRN+gFPU6ghih65Ftwp1HGQaq9RcU2JyuYkDcaXw9QM5F+DS8HFBeOUysG8/KgYUJfXo4f4+hLyg5pYf1Y/kMu9soIc599IKOp3P5XLZYvOvdxYTO/P6GzrBuPgMVLpalBS/xetJfCN58dMdGGSNy1t3sIraxcC+SOljYxGJrME5IALp397ROMcd/WGg/MBm54scMnpfj908R91tuuFyRCleH6rVYQ8+KnIOVaHRDvghIj1HGES/xcJeemiHdUHSllS4J26KcxhNtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaHCq7YbKYn6V7f+czWXc6WjPBNzZHMwsIOiRD9E6Vw=;
 b=Mp8DhNdpn51EVqP5XM4bxv0ZYhSyYO34TR/dQRmFlClda8LP9yfhjBmoGHcLu20fr568qyb0s2aQYTfNzHnuVnwyWIxWGJlRzPvsFI5LQFjkKmX7Z+I4SptSdw1In8IJTuTT+ZsRGjNBy3raf01h+XvtqRtCl80nP9CEGSQO40X0Qh+xXWsV7/MViLgNm14Hj2Zj3HAyiCVTCpF8TDJ4MJ0TZVQ40aR/O9+ny64g6c1+Lp62kW1zNini5IDJkoJQa0JcQqYdnSJQDmsXaFlU/e3ZXKrcP306PsmNSWVGDAYzba7cH8eNcy3lB32qIx8nPF3RA1OOgpx7+wgHaBK1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaHCq7YbKYn6V7f+czWXc6WjPBNzZHMwsIOiRD9E6Vw=;
 b=ebW/8MLVf0WEeHdvqR+e+0YsSYeev/MBARFAUxLpx/fDEaUQ/aRbfkreFJbOO3ZeVSPOygRgEFv4bQ+4yCoh0Xl/oSwn0zAi+P//L1bAqpyX2uWPHRnU9QUaNlLnAL5lrllGxMyTh5+KVhyBKw9ooTjYVaPCooB4zlAPls0UUM1NvH75Cr5LHD7Zig8r4jsIAJkwME8KRVUQ8DTdqNtQQYzbNIUH4XHNi2RsU7XQ+wocnrzFdArfX3/Be+49w+LWQ3dB5FIk/K6ST28xs6O7AMNMpqi511rrKUSQ+HRsWdTEuQNMToZ+lpDq0qLs9gEq7uHGBnW4AXXok76Jbe2G0w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Sun, 27 Jun
 2021 23:15:30 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.026; Sun, 27 Jun 2021
 23:15:30 +0000
Date:   Sun, 27 Jun 2021 20:15:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <20210627231528.GA4459@nvidia.com>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
 <20210624174841.GA2906108@nvidia.com>
 <YNgxxTQ4NW0yGHq1@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNgxxTQ4NW0yGHq1@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0032.namprd15.prod.outlook.com (2603:10b6:208:1b4::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Sun, 27 Jun 2021 23:15:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lxdzs-000Smj-QO; Sun, 27 Jun 2021 20:15:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 930aecf9-73e7-46ac-b16c-08d939c174dc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53800B94B50833195E34550CC2049@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QtvnixxGD2jvo+h/Vg2Td2Qfv7+Ibzrmj28rBsHMn9cEDMWVwZhI+oDcKVSm5y+tk2vw45LP0Rsi0FyQtuyiDHEDOT4a7A2gaUiCbSj9DO6NthhoWDHbLdjEY2Xjl/D4Y0iytDkQi18fyexhB0lflrvnbNSYvgSp5w2XsfRhAqb6BHkk+sJHvDwu8lFJHYxpJptl9lEKNDWC7HqZc0hQBcIu3DvllaHmpMI4nTTMg/XhKnPo3/qCMr1fdrVbCtoVhLaloL37Xofpn+DKnvlsky32RXzL1fV3p4/yOmZ1JrytYkxVbrR6CdsX4AWxpOAx2vzajpdg0Oin4es9Jk8pk69p5wjZxYTX7mbfe3AQGpGO5qewpx87Mu+UzuI4bY86ohnZG5myUMzmN4yd1Kzi358rPxMHspmH3lUyyKzU0qVzheayNIgKtvbPZx7iKRlpBQcS4gqYftI/9ZNP+TztotsgbENix+IB6jtUe7zSg+/962UwHWcmZ8Qtjl3ChOZVs1D/TyyUIyBmhC9xU8n1wk3SCTaRy0VWNax1VzKOKj9IEQxR+iW88i8JsmOPyctTwJasRgwacLm/e8UEQnlZzXS/FMypQI56dvYdiWEWven4bV/88QVxxNnlrWPS0NCnTLh81ESsT4Kt6dMEQEX8Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(316002)(54906003)(9786002)(426003)(26005)(33656002)(107886003)(186003)(4326008)(83380400001)(9746002)(38100700002)(2906002)(478600001)(8676002)(5660300002)(2616005)(86362001)(66946007)(8936002)(36756003)(1076003)(66556008)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EfzH9y0zu/8SSG+Ak7YlfcjkZ1cs+3sdiqCoUju9SZnDqoo1dSrfqeFcxpIG?=
 =?us-ascii?Q?lXnFrH8XnaSDUV4jSFF74nh1IMw16NrRugrAUESfbT1SJGIIOBPnB7O63smR?=
 =?us-ascii?Q?ya2V1sK5tirr34oIuyAeW/IcDyniC1aQs4zoDhnD9PqnHWJOX7pvFmbu7tpB?=
 =?us-ascii?Q?XloicsxAuxIG1he0r2k8jKxTcqs3ig6uzfOhx7K6RGtjUaurS4lmtt5meb0j?=
 =?us-ascii?Q?GHIHXgsjAYO5yYRzAK2lWjhThHOEiuHOPuYIgMEnPD6VjAJnY/hNPtlY60nN?=
 =?us-ascii?Q?Ajp3IvSkM/pgDaqwElSFYzhCZB/2Suz4ihGl5JLWWG2UX7ZC+sn0trGqQMb+?=
 =?us-ascii?Q?ehJxVAWQ2LTtUfengsZm2QI77E6hiJs/PD42cUpslREHFGS8WEW9+z8SN9JG?=
 =?us-ascii?Q?kxTflPVbUSo4D2hqv86XFBNUsrJCV4zUeaBfQnQlRtlSSkypW+kG5Ma74RJV?=
 =?us-ascii?Q?LeEcB4GHNZeeYljyEBvuaITeKRn0QEawZG+IPPPPQMG4tsCLkMS4h4MGKUBk?=
 =?us-ascii?Q?gDvI84MP0DszoZf+5IcCLDFoWeD9fLsVFWIC+t8VymlTiApIhiDhMAO5UZTH?=
 =?us-ascii?Q?ingERRMGRL71E9dSjsdRFzSViSJRSP84b/2wcMUPvBKooCm+zdKD+OHKh/tN?=
 =?us-ascii?Q?I3o7pVcWim2uLbYj6eYYVKQ+RIE30/FcPHz8ACWE6RHFtGSkybEgm/rnwHXE?=
 =?us-ascii?Q?C1xuCDWevzIFEGzcZ8uFaW3t3UcEzW40FM//n1chJYXHtCitUmQYOA2FECfP?=
 =?us-ascii?Q?DBgsd8d/sPFNQhxBU14SJg+ywhw4P6WJPeSi4yuLPOK8tPr9owhiJwyVn63d?=
 =?us-ascii?Q?7JL5dmsM5ZBh+nRoDZwUncN4b3j75ctN9PaaUzxJnSOtH/P+emAglsFhX9lM?=
 =?us-ascii?Q?vXaB0LuKanW19tuh0ws3QUrF4sWbXLQl9Ssg9yMoQEDxmMz1Z6vKv4Wqd1yY?=
 =?us-ascii?Q?sxSmgd7G4nv9xUVzP0z24Zds6MDcBU210gX6LtmaZPSA8kHYieEBf8nmKL1N?=
 =?us-ascii?Q?MI2Hf+HMXzrkzOJ85zazEHb3X+ifkdA0v89LjpufxJOwT7FOz87CCEErDXFo?=
 =?us-ascii?Q?w7js/oOQDdVjVR3lz/yfL+5OCqFMZANdDy4zV4kdNt/jPkNIUCePTu77AOM3?=
 =?us-ascii?Q?DkK0PFwvYZ/C1/Q6Uhl2aUEL/MtoLbkTQ4eZXY8T3KYR5wU30RXWH6D2JtMH?=
 =?us-ascii?Q?h+DI6oXo/HUjdIW7noY+IE6hBT6uthGHQsdXB5mer6BeTsJuO3KOqw3TQxaj?=
 =?us-ascii?Q?NHHEBGMq8R5/ucUqlf9bMxi7rTU0mstKr+/sQ6/Y3QqMBsuNyw5enEyEkA0T?=
 =?us-ascii?Q?We1f50ThlXWHgeF9rv+7piQx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930aecf9-73e7-46ac-b16c-08d939c174dc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2021 23:15:30.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CbGfZoOcPZGqZj5J56APrVp4usaG0a/4MKvWaKEOCaKiflH4POHjzGYsz0aZhiE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 27, 2021 at 11:07:33AM +0300, Leon Romanovsky wrote:
> On Thu, Jun 24, 2021 at 02:48:41PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 08, 2021 at 08:23:48AM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Change location of rdma_restrack_add() callers to be near attachment
> > > to device logic. Such improvement fixes the bug where task_struct was
> > > acquired but not released, causing to resource leak.
> > > 
> > >   ucma_create_id() {
> > >     ucma_alloc_ctx();
> > >     rdma_create_user_id() {
> > >       rdma_restrack_new();
> > >       rdma_restrack_set_name() {
> > >         rdma_restrack_attach_task.part.0(); <--- task_struct was gotten
> > >       }
> > >     }
> > >     ucma_destroy_private_ctx() {
> > >       ucma_put_ctx();
> > >       rdma_destroy_id() {
> > >         _destroy_id()                       <--- id_priv was freed
> > >       }
> > >     }
> > >   }
> > 
> > I still don't understand this patch
> > 
> > > @@ -1852,6 +1849,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > >  {
> > >  	cma_cancel_operation(id_priv, state);
> > >  
> > > +	rdma_restrack_del(&id_priv->res);
> > >  	if (id_priv->cma_dev) {
> > >  		if (rdma_cap_ib_cm(id_priv->id.device, 1)) {
> > >  			if (id_priv->cm_id.ib)
> > > @@ -1861,7 +1859,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
> > >  				iw_destroy_cm_id(id_priv->cm_id.iw);
> > >  		}
> > >  		cma_leave_mc_groups(id_priv);
> > > -		rdma_restrack_del(&id_priv->res);
> > >  		cma_release_dev(id_priv);
> > 
> > This seems to be the only hunk that is actually necessary, ensuring a
> > non-added ID is always cleaned up is the necessary step to fixing the
> > trace above.
> > 
> > What is the rest of this doing?? It looks wrong:
> > 
> > int rdma_bind_addr(struct rdma_cm_id *id, struct sockaddr *addr)
> > {
> > [..]
> > 	ret = cma_get_port(id_priv);
> > 	if (ret)
> > 		goto err2;
> > err2:
> > [..]
> > 	if (!cma_any_addr(addr))
> > 		rdma_restrack_del(&id_priv->res);
> > 
> > Which means if rdma_bind_addr() fails then restrack will discard the
> > task, even though the cm_id is still valid! The ucma is free to try
> > bind again and keep using the ID.
> 
> "Failure to bind" means that cma_attach_to_dev() needs to be unwind.
> 
> It is the same if rdma_restrack_add() inside that function like in this
> patch or in the line before rdma_bind_addr() returns as it was in
> previous code.

The previous code didn't call restrack_del. restrack_del undoes the
restrack_set_name stuff, not just add - so it does not leave things
back the way it found them

Jason
