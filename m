Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DFE3B10A0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFVXf4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 19:35:56 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:5043
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229675AbhFVXfz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 19:35:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHTgjZfpxUKD/ksY5dYpJXnctQ6jOTYO40BJpxbMPkIIimFfcsGFjlcHXjXAzUE6QnVG+mcTSyzgF1/Y1M1cFB+2psofdtvAceUuaxdLeDqcxdyL7X/rF6F0ZX0EqHAvNraBdhWP6FSMdPt39m6C4je6GYpGcjmpJdvNGrBOfNFCtpEmXoJEV5YAOz/3hl2m92ag96s1SGB0h/8r+DXjt4l64lpIVMs44TZQEhJBiaBKNUM0VxwlFcr2k9rFpDK2T8kROxVvduRWWuYgm3MuOGjawl/dOlZanJSoqOmCOPC4cfTQCcXBq34btihitVXuqH4JToYD95BWAfOGg8SwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/vxHbs2wpokklIxvNLveftTuGAPxlO3u/CGgERDYes=;
 b=cIB2QB/QJmVJXeonKr7fEsAEhOA3nn/oGgQjDm+YF/HheSdB/1GEZybNoU1TJtd+HUsW31arQ79fqg1zlPtlXA6RMD4ytjIvYbr7F+RMsYCLdLMr3eDHCI1kiDBQYyAWvRqd0XgJSFFzwlQN1l9pzLlDJpphZlnMpHnT/BvP25JUTZeROHqGvUmavqs5lvvDzxscr5SbO9vhKXdEdCM0SHWlI7VdgO2n9kqnc/5og5cEjUcoptcUp3kxhbpMY8ExCBNTkFl833brEIfXOaS8khxTFGe0Q3T8f3Q9bHBbBXEZdqBqsZyAHarEJIpiz2D9akNG5AiYoMigfEfpf0JK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/vxHbs2wpokklIxvNLveftTuGAPxlO3u/CGgERDYes=;
 b=bGnnCdO5buyFRLYGm7uNlj3v+iw/P+J8LDg986bAjK1KaxzvlTP0daaXkFnOqL6d4DcD3KNW6VSP5vLtYRXOD2S4ZfPGFg60rn22y0g+4HVmBQC0YJOON3G773LzbV+57Y+KAZSK1RIVoiDAqPufIyuTro/X4kFDR2WrI1XrLdQDOGFov++/iyXod91d0BT3iK0l7jVgEpdtdoLfbqQ12bF50xCb4fj054jzRCHYoCCVCS+fO8cIQb5OF1MTCex+x6ZTRpwaucAdWuoeAqz/0KNvOzRIrkGmicaMnF/DvZHvN+LVw7N6O74LSQn+xJJb6h+OwAohwAIJm27j857OPA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 23:33:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 23:33:37 +0000
Date:   Tue, 22 Jun 2021 20:33:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH rdma-next 1/3] RDMA/irdma: Check contents of user-space
 irdma_mem_reg_req object
Message-ID: <20210622233336.GH2371267@nvidia.com>
References: <20210622175232.439-1-tatyana.e.nikolova@intel.com>
 <20210622175232.439-2-tatyana.e.nikolova@intel.com>
 <20210622175844.GE2371267@nvidia.com>
 <DM6PR11MB4692C781B07DD976DD9D7C7FCB099@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692C781B07DD976DD9D7C7FCB099@DM6PR11MB4692.namprd11.prod.outlook.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0005.prod.exchangelabs.com
 (2603:10b6:207:18::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0005.prod.exchangelabs.com (2603:10b6:207:18::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 23:33:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvptg-00B3Ns-Ow; Tue, 22 Jun 2021 20:33:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe698bb-7047-404e-9da3-08d935d628f2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51125C0A4FC73D1F6EF63A1EC2099@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFW21KIwB6Snasm8W2di6gofjl0D1w6c0ndOtAFktd2pZr5L8WVMicZ1Pif8qVK751xZiDkf36OmGTdzMyDVaxOcpSHzG4/6g9P1wWU2RtAUmVRKk6qpRpWFEKVM8NhdqqaAc+G9IoB2uC0XFmSrohuKoL+5Ngq7+ujJo1+z6twlPuobMKIiaCG9F092pZmntSr7X3Zlco2XJavc6RuC438+gBHuylmh2nsC/93k3MACruw7dqHrbE+fInsL6+dGjQEw1B4+0/GQiLDM+XIHFcj8TDJT1dB6zSrifcME1Cg+xP3i57N3V7Hi0SM5s7FJ2NJg7Rxh/PaHJJtxR5LwZVThTV7D35DczyAdiZTlSiQwjBL7b2n2KrAREs26hYxZYmnXDLHZT7ont6PYCYBZmPb7sI+uPS2lcN2NnsG4rMxJLs1480ek8s1sJ6aQvXGLhJ4hJ6UwYFonlnCLRjZQD2kOhPYu+AXTpfG5kZAnHveLZGvQZnJ/FLglfZN8fBHAqqNWC++SDhcIE+vXDWIsnSeriYnFIdZozASgi58IaDuOqIYfcbx1O+dXE3vQKgdnVSFq1jEZDg81W2HyAJwXaT9V+phLTZRNNEak0GM9X2QkDlhSyE+0WYF3FpTmKSv5JJGnk6zaH2vc7ohUkdW4JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(8936002)(26005)(4744005)(38100700002)(36756003)(478600001)(186003)(1076003)(5660300002)(83380400001)(33656002)(54906003)(66946007)(4326008)(316002)(9746002)(2906002)(9786002)(6916009)(86362001)(66556008)(66476007)(8676002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ty/eN0Bc8Hj4tQjQRgVicMm/7BVXEMOcx8I2sVoOHFSn6tSidEoqYTESh2A7?=
 =?us-ascii?Q?FA6Y6vjTzGthjGHDrl6YwPZheDIPlIh/X69vM2zMH2PURy2cpKmrOZtyQGOb?=
 =?us-ascii?Q?ZIMflvlqzzJYqOBKh/4bPuwBu068GxBPij0CgurcKKCuSW9Ynovl7ugTxd1q?=
 =?us-ascii?Q?wSm97RzLj3X0J2oy7PmYVN4KWq5wMg92kjf9pXjlr0qVj/5KXaQzOFy66fit?=
 =?us-ascii?Q?MrnHD9X+0cMK1hDKrE7QLNnwVtRPY+q8GYkZvbxzA74zM+dgVjy0V3xBwZea?=
 =?us-ascii?Q?sfsEZCHgkAS+VZ+ZOwSCXNIUhNi2reQktbCY79hK8SRNc4CiJGbJa8To1Dv8?=
 =?us-ascii?Q?+1sys3Gaj/o9PnuI4LhvYExVlBD5gVsARbBUiIbcabbZABbY62hs4FiGmnPA?=
 =?us-ascii?Q?91H58/xHkl7/S3O/BXEVnHMsWPIuTa2SDGahi0Eja4hMwUdbrNgEiGIZ6nFA?=
 =?us-ascii?Q?xAscfJipzsmx+1tz954SN9T+S8Fc3pLw6pQopQ3JQlMgMCefSVnQBVY3uv8C?=
 =?us-ascii?Q?lRepsoQ/JQuVJUaKtF3QqEpDHwgTKnERJQDGJvsMeJjZTZCmBwTyh/XARUwE?=
 =?us-ascii?Q?pEzp6iKQChJJG9qc8Ry3jEK9hWspCgwixZnPKKhi5dZ2d9x/69hj0NxlR74Q?=
 =?us-ascii?Q?+ZVrQa9hUVW1QHrAZf5Bxn7Y0/c8A4KXLsF3SvOcF41YmsNAQUu+gHz7w3F3?=
 =?us-ascii?Q?C5k50TOjK6xQjfNfLavgYClVi7FL0L0ihj5j6h21pLxQE1ImOend2m8Iv5mP?=
 =?us-ascii?Q?Xjlu2RmHWlsh6SdQm6qhyr3l5y1Gdvcx/+D1jWfNT7blLAimX/uXu5N6wfoD?=
 =?us-ascii?Q?sb73gdYBKjQRKeaoxE6+0sk6RZ6KpDc2yk5kksZxsG8gAnxkKPh9ip+8tJ5r?=
 =?us-ascii?Q?9a+j2iT1HAxmvJwq4rinYtbQx4qQ3/tf22F383Dh20f+oipoWnYh96e4yAmg?=
 =?us-ascii?Q?G9/oRW2mUPYnnX5lGyqyNz7eFcXuOs/cGYqJLzXy2M8gug6LKeGKVq9K4XRf?=
 =?us-ascii?Q?C0ItfDm7EB14U6CmBG6ER8q6EFFC06Aid56iijacRTtXWJWGBRIThuSSuzbR?=
 =?us-ascii?Q?6+e3Y5rkH5JZ1p2zHXU2/KktniZIP3/pldQn+zDzv4Xgs1mY61xos1Wa/2QS?=
 =?us-ascii?Q?VnCZBDbwiMzojzAUyLxxFVXCPwpgCOwsQ4ky7SbT/wiCwWkgOM9zBYR9pyO+?=
 =?us-ascii?Q?DUfi3NfL73ID84kNnqZ2yboM7CKaMVytLv2vIgBSY4x+K8xSsOLtSLcOY5C0?=
 =?us-ascii?Q?EMZX3+aAMKPveacEgqkchw1Lug3ECIS04oE/a0C2osub5dAsu0p6ck9IaC5v?=
 =?us-ascii?Q?0G7oq1KVNFmtoyOCQ5aluMxh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe698bb-7047-404e-9da3-08d935d628f2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 23:33:37.7122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjLvS59ZKJtuunoJb2Rl3MOdqQesAK56bhSOp1isxiLKIHKglkwM6Y6FvdSMm9us
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 09:56:42PM +0000, Nikolova, Tatyana E wrote:
> > >  	switch (req.reg_type) {
> > >  	case IRDMA_MEMREG_TYPE_QP:
> > > +		if (req.sq_pages + req.rq_pages + shadow_pgcnt > iwmr-
> > >page_cnt) {
> > 
> > Math on values from userspace should use the check overflow helpers or
> > otherwise be designed to be overflow safe
> 
> The mem_reg_req fields sq_pages and rq_pages are u16 and the
> variable shadow_pgcnt is u8. They should be promoted to u32 when
> compared with iwmr->page_cnt which is u32. Isn't this overflow safe?

I didn't check the sizes carefully, and I'm always nervous about
relying on implicit promotion for security properties as it is so
subtle and easy to get screwed up during maintenance

> Is the issue you are mentioning about this line:
> > > +		qpmr->shadow = (dma_addr_t)arr[req->sq_pages + req->rq_pages];

I assume this is safe because of the if above?

Jason
