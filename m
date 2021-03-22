Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0F3444A3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 14:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhCVNDR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 09:03:17 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:22802
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232752AbhCVNAQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 09:00:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Zx8GCZMSNUC+R/HC3rD1omL8s1Tsqztg8W+pKvHgSee3RSqryEjY/ZpejM9X7YSX4L/RDRtIlDI+xUJa19fAXrtbYYLQsuYE2RJEXKPRrBmiOAJI88n91yOEcH/IqsYQ09rTRXnrGJy+Um5vpic+STAmGls1yJVCCtpo2Tx1g633spUUXvJJFiNIDjVjUD0vCv9xH638SzrLi1GmCPH4lqaVr2yeDledYF5vR1O2Fql6DSr5fjiprGmPlHhVgU+PDqac/BwxKZMbP7xEVNpVIJp4KdYhb3e4ube3mVLk2NqKCZkQXMS+L8j3gfSdYuJUw2XW6+b3087hBQyFwe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATVKnqaqRvR1W52O4PMLG4GOYWxEhujG06Ue8BF46rI=;
 b=FKp01ULbi6cqLtgmOxge6/Qh/8Ye4YGVYC26kQtuIUByForuN3YmJ6VFyNhTFQeHoKNvlvWJoSDs+A2rqMdyQPailBz5MMWiZrK6RCGsdOPhBO3qkQt6MzfulROte6HTaqgph5J9iKD8MDCjX2Nck7whteEvgDbklWTlkF5CplY/fHQyyAlBGUg3sJBC8+rZbze+w/ocowWmnXhqmzm4Lq3OmbLa+70V4fN7a0uHgWKNX6UiFbOIgF0XjF6IEWe3DkA3dD2K/pt0SY9tsYQrdmJkp3N4tim26v7o7Y8CIXqQjSWin70HIhPOBaJnf65ndaewwowgJi4x3WwJG8PiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATVKnqaqRvR1W52O4PMLG4GOYWxEhujG06Ue8BF46rI=;
 b=Ceja+1fGOQUA1GRLRXIwl51cTkjIVieFNQU+ZyYYmu9gDr1r8mnn7ckyTZzPpqVpRBJobO+PGkL0hgDq9Sl7a4uhrD9Gi1B/OHdOMTHWUe4yrkQdkYBh+uPU6oWnn90MycuA9PDD5tuQJzC8uL6fAC7BeTkURPdvzSZZbZOI9aFMBTn5VPAElaEs+TCxXWHBmNHBJth4/D8gPSePnUaI7yp43pfHqBOzWjkyoIWykoI58m4NKzo519Fi+Ma5twDiPM9O4HnxyRi+/qbIg+1SyVzqyAVtIQfSIptpicC2O6frTmQDioe8OIYkv+SFTXkpvDjYfrc2+QYs72EGZxnRdA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Mon, 22 Mar
 2021 13:00:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 13:00:14 +0000
Date:   Mon, 22 Mar 2021 10:00:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Faisal Latif <faisal.latif@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next 0/2] Spring cleanup
Message-ID: <20210322130012.GA247894@nvidia.com>
References: <20210314133908.291945-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210314133908.291945-1-leon@kernel.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 13:00:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOKAG-0012Wl-JL; Mon, 22 Mar 2021 10:00:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee6abe74-f8c2-4f72-c91f-08d8ed326f3c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2857DFA1F0DC9156332DD9F7C2659@DM6PR12MB2857.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dB0C/k5LU6wjAMIIUxyytCnry9O8uBpCA7zWMFZ0vtYUNSuz4+Dsi9WBeB4vm7i3vsu05FGJay05BDu+lf5WwPU0qezOIM+UKzF5CE9XEXHnm8u0RcdbgWyTwGWrlmsCKR/aqBN7jqeMem142w/wDNOH1h1jd/O01CH1YFHI3eHk6S8sdBbk0jmz7q0MTgVQ3sxIix9grXMUkHLBY18zPUSS/Sihqb5NYw+jr60hQRq4COJ9eXF1hRl/XHK0p+5/yHrX//SXlW5I6Q4qkkFL1GKSBjFlX74Xs37ry/RzW6m4MbTjkA4hHxj1hfqZ+xggENPw5ziu7wZYEDfWAuKYXSH7CzQXTCtTgayYSJwyF5y4Dg1Yjs5lLYMhroFbu7DxBWYVZrQrroJij1h2YPUaAZaVM09+4YR1oXlHdjfgx+038Fx/z/qdJrii3h6iwuOw6kI7D48cKCQY2lrByozvGKxBjIxyO73Ci6K/7LC/1DwLvqLG4EQcLal1A0X62Q3APDBo8egowY9p6eQ1TTZNedKJY1l5/TuGK2Z0aK2d91EFubVc6jmQHKsQvlYZsNA7rtzJ0GWw9+gH2LCQrDFzR791h3fV07hwwYigytxO/thq3qsc5G8muaBiRwd0BzZtGrcYer4dKvEkuUmliWhcqGruQMS6UkPEw/i/Jly+bVNHnlqcvLyZ1DBoLV9wpJjB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(9786002)(1076003)(186003)(33656002)(66946007)(66556008)(8936002)(54906003)(316002)(26005)(4744005)(36756003)(66476007)(2906002)(9746002)(7416002)(426003)(86362001)(6916009)(83380400001)(2616005)(8676002)(478600001)(5660300002)(38100700001)(4326008)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fWPlWDrR2xT0Vh47zGKJ2cw3Ptnu8c4slZMBYcy1dwIJ2NAsQhKOtgOELNlt?=
 =?us-ascii?Q?6VBg0ECGwdyN3RZFFhPHP40nYOHYAFNz+rt5C0PukG2SaJM7aommQnGgFuHF?=
 =?us-ascii?Q?hetfx5dfB4sdzV6XLdJm/3LcIcmVObjHeNJ5UtmUoBemlk4T4DqVbc8nQb2c?=
 =?us-ascii?Q?+bAkzLmLSwgfArta1VCfX4ebyx/7tGxV+IdZnYAO5bk5YGiis3EDuB3c8gPw?=
 =?us-ascii?Q?u3ypkrdbkxy3Sq7PmTAujvziAwQPEwJ+GNEuKL2cBRZ/NpH0wIyCqt5QsmeG?=
 =?us-ascii?Q?EtEIKHSot11gDa8qJHHDlkgKYAtjdNIE5iyQpy1lGkPESvVChiYg2hDt6XB0?=
 =?us-ascii?Q?HkV85fH2W7Zvu+19NKoJMZ0fEHr0M/FzfdPnDf6UQ8/XhYxzQ4QT54QWSXdA?=
 =?us-ascii?Q?azGKEZkjJN/B2Xty8TEzkZ0jsvxq/XeDKM4UYpwhD8bMQ/eGCrCg5n3TZQtY?=
 =?us-ascii?Q?gdHb9+3Z3xEOwBpn5YuS5u3QSPZfwxABGGBavZPEW/WptwchVMBCSTHAXijH?=
 =?us-ascii?Q?Vi/mtWGrDV1lm1Z448nt+nkcJTJeXoA+p7x+M8WwTl6KlVdbClmRpcAAMCsr?=
 =?us-ascii?Q?GDSknxWll3nLiYD/lBhl0OQ/HrsznTPMYxEjjJknzR0C68anmPOCnn+WYn3h?=
 =?us-ascii?Q?YXOrMwqrR3VqGn4g+xjgCWUxx0HZmAg5KHvJkVj6tt61QHCgCnzclIRBBTxI?=
 =?us-ascii?Q?fFAu7PW8LJAHEivbpmSI9hYmT0Wi9FKS/ariBRJIKs1WeNlWoBv+W2plAp3l?=
 =?us-ascii?Q?ErMxenrWfPZX4LDiLeUAyjdN68mQaq/qdbXs7jaVPmrpBIrDHUrda5jQ4pFb?=
 =?us-ascii?Q?JInXpqr1LtLMm70JZKzmjWhzV+vOerfIuDe/bmmQFhGr7XX5Atlg5uT/TQ8B?=
 =?us-ascii?Q?skG3NxyxobVOZlFG7VATlILC5XYA/AfO3AIbWrBuBUi4TtnKAhcIao7j5un5?=
 =?us-ascii?Q?V0JjHJUBWh/5UUF1MZzI6zOmkrssjQ1geHlniAGQYgQueiazwUGtoJ/tuBXi?=
 =?us-ascii?Q?sge4GNxhPfFDo4zbAHEJPcSuq3Or53feOpnpJZs5yNvYmm3V1o2dcZqY+76X?=
 =?us-ascii?Q?7hGh4V+Aloq0fbK7mEY2owA9Sc/WOpvhlicPQIENAL2Dzw+y/GyVI6omr95f?=
 =?us-ascii?Q?nIHooQDKs+6gjl5d/Wy12PFi06BEI3hSrFxnJv+05RhFnm+dtaklJnkHcN60?=
 =?us-ascii?Q?dyi0OxI0Sxm3B4Zck0AfKWTTGTwJMnMbFMUBIyDtCsa07prbY1FqB0R2mfCA?=
 =?us-ascii?Q?kG4YS7dxQ63kTi0bATbd584XnwU1fWMpz8uUoSRgLlcrq3oiN0ajURis18Z7?=
 =?us-ascii?Q?okof2ZED+VbxuvEhGupseQsR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6abe74-f8c2-4f72-c91f-08d8ed326f3c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 13:00:14.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5z/0ysWgMPqsHXi8W7tWCFnLqKnIGjkvSJscfhT43Up2C9XfWT1gmWA5D7fl+Djv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2857
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 14, 2021 at 03:39:06PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Bunch of cleanup in RDMA subsystem.
> 
> Leon Romanovsky (2):
>   RDMA: Fix kernel-doc compilation warnings
>   RDMA: Delete not-used static inline functions

Applied to for-next

How did you find the unused static inline functions?

Thanks,
Jason
