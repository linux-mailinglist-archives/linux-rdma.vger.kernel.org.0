Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03683F1A51
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 15:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhHSNZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Aug 2021 09:25:45 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:44704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239864AbhHSNZm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Aug 2021 09:25:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJOqL49ajhlHH7jTY6+Caw08OyPAIzS83D9P/GNEBj21RouhsvmBT6asJrKZpdWczrTiVWJ00i0K1+DuJEbvhZmk/XTk1Yc/QkmkNrh7e6Q2kKHOVXSVHb4hcBrW8N2V6gLOlXuj7kNcVsL6Cln4tDnfxw8wqCV3I5/eIofjqokz6/mdytmKiUEjPaz0vYFPaFe6k5LUXBaP257tCM5+8xeucqZNBCdveymWv8s0e0a0ZLO51p0IEoiPMjtbDjo2ivLpAe8vBI3uXy8DbTOIm8P5ho0tiorKOLufWUFQlYUw8v4nfD8DG8dufppWc7k0RsTKsMnN2XybBWrxgRcfhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5e20SeVo7v2wbqUKAOrHuc1DZyvF5LFdCWvVVr7PAE=;
 b=hM2pDx5+iVjGm4a0yLd4QRy2Uv40CHtslxWXYsFrvZVuBqEHHFd9m/eKO+yMsIcPpQS6l/tPjZXmXo7QUPyXhisFeN8pFW7uJva8ySIn9E/Ddz4KOuxLoE3P1IH/bPNV5WHoNveal7GjiK10hhTy+gIRzcrVjHVzqRfDTcZzAIusqvuSScoXtmD2xOryNddSDFqj9bJEF2cdxaz7QxzScNOEBW56mYt6N8Z1kDgXro9OlyaH/sWjx1zPyYUP7BjAWYENkiPPgKajBcmQ74ypRX3Y8E9ysjQbHgACIRy/FAQTLvlFwEh4c0mH94hTyED7O3SV/6utKoshxRrORzRC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5e20SeVo7v2wbqUKAOrHuc1DZyvF5LFdCWvVVr7PAE=;
 b=kNK8zrrcmLysTIjTUP/5BIuVjdYMnDsPMLALRqg7zb92cVeRSJlss2J6vXMJWlJ0sMTFw0Gef195feDhuipJd0jFl7AEehGI1nkx9ck4NZupz4FJ3hiY1eU2DRbYVpDGt9a0et8fH6S+6bCVPbMVGuz07mPmIKXFuENPKvo+8a2q85zmKBThfIiPdG0o/5WPioD3UsdS36RtZllc0zjosspSN/JVP4nZgyjQKO1s91G8IEIPS7nBcMCzpOsyJaN1B+NFn0NQAXMAYsCi2spjJkLtjdsL+J07F4Mq7P81Uye6EaO33OKyiSyaQqt2s2pKQMaE1e1sfYRLogxM9YtN1Q==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 13:25:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 13:25:04 +0000
Date:   Thu, 19 Aug 2021 10:25:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2 0/3] RDMA/bnxt_re: Bug fixes
Message-ID: <20210819132503.GC282811@nvidia.com>
References: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:25:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mGi2Z-001Bbb-2r; Thu, 19 Aug 2021 10:25:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c0e6515-3500-46c6-6660-08d96314c176
X-MS-TrafficTypeDiagnostic: BL1PR12MB5271:
X-Microsoft-Antispam-PRVS: <BL1PR12MB527162006CB5D165D8CD9ADDC2C09@BL1PR12MB5271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OI8yAjcf3SosJ/WxgUMXpLTnqk9QW4+gwdOLyfSntD44x9c7iw1VXZXi/HcZa3zMm6dNoZ7C5m5AKJxxWG5DyfGQc35aH/b9dZ3n1vloH6xPSUnYwkTpKFbw+MjBMn35aZCkLnQiLyh3H4j2QNVpG2+llYQ6m2DCTJeOwRoZ8UFiqydn2tTf0C1RlO5/L7Li8YQkAS2+ANsMqd1DWIGDUK1nQppNvC2gyaSEnew9jA9eMt3OzVpF4Qof4PBZ0CO6tV4e4t84/bgONh6ih6es5VP27zbLo/heKMfyqn36FFD1vMrbfJU6TDv30ohgme9/8NdU4W7/daBao1mRmQ+l9p3ieHqvCS3pdFwgbUFblW4ZgEBuDihfkd88FeTDXI3JtXL9jBs40m30AisJruYhOGOEllp8L64KQAw4uLiXmcxyd5p0O5Ooe4NkZmUz2FrovZzJg7O11A3qs+P76Z2tGEsLnKHba5Vow9CCGxfUsBUAEQdXiyt+0YbwvCXRnR6iaDo+DhTem6ZfdwN/qsJy/ZhETiXxexK7nmKmNQkInX2flThvD3ke7vfNraVVyTvvVwlN4JeHW6bab6p0jveRTZrLjDceZXFEIooCyCcQ413KNR/zM29AMczgyP+jPAtEHX5rr7yAe2V/vazPptSbcJsOCAfaO8THcW+w2PDMqWR2osV5rvkn5mNqQcjJqOJZ1isLJ9/d46VDwkmRxL5OeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(83380400001)(38100700002)(5660300002)(86362001)(66476007)(4326008)(2906002)(186003)(9746002)(9786002)(66946007)(33656002)(2616005)(316002)(6916009)(8676002)(508600001)(4744005)(36756003)(426003)(26005)(8936002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xW+TDVmYeAypx2OPMjrNbCqdLI3eNRFSQGGY3NWEi9zd/2VDdXq3RB7KFxkN?=
 =?us-ascii?Q?5Hn1Mqdum5IVwva4qHJVV170VTL9WiZvEfoS3zjgFi8pcU1R1S9XfHTGqEw/?=
 =?us-ascii?Q?OtasvgkjsScIIHac4E+1cAS7IoYXZugZppIz693mBvsM13Pzi4X46UKgvqdQ?=
 =?us-ascii?Q?QoJPgDJPkikOiRNMS0f68WK76/5h3zl5lvrxiHqXqTsEm2QfI3umh97621fS?=
 =?us-ascii?Q?dNmgRgTJQAZkoIOnPFnmY01IujMZHs3u1yX3T6wjjNGpVhOW1vp4LCi+lvn/?=
 =?us-ascii?Q?GgdRH4pWJMU/UslYTYM68GeE4KKP71CE98LrFhbjYOclo9QZaPHtkyahvEth?=
 =?us-ascii?Q?pxm6Sbn275oh33xwDlhEYaf037cNsGf+4WrNcLmx+Ry54xi+pgerxjPQwKio?=
 =?us-ascii?Q?1NOWTYGyPjBx2yDX7ui33mjTP0f5I1HlO5wEaKdoDhqDQUaD6Y79OSLDTMFr?=
 =?us-ascii?Q?RBj7RS5/aYvsj9L6etVs+bch7ugdH4OJW9aU3QRA23odhhlfVYY/Li7ocj+d?=
 =?us-ascii?Q?aGaunB4kq+Iqua7n8oj1ZDb2v2qVxenVo+bAUMqODoSRYt4qkie6xoHny774?=
 =?us-ascii?Q?54c+r5I145BC7pdqJ+F7Iabahu/bxMlCrkWmvOxtgKKP3ZJTIXvdS69hmvn0?=
 =?us-ascii?Q?xsQ/N1EWiFRJ9mWm0AFff5duA/QezJmOiAUqD+K1oVqlIsLUb0taz46W/4d9?=
 =?us-ascii?Q?LmqcQ+9Ic2N44ZfeTfF7XzZQgKxYwXpvRuiqc8PTuF361OxDwtDfsONdXJfY?=
 =?us-ascii?Q?3YJFphZe+h5gHsK//VPmEGyZDz2XnpHhVt0Pkyi3tdSBKA0TP9BRZ/549eRP?=
 =?us-ascii?Q?y5L144NFmbqTJ16beCH96xpZ7KDfP/ZwAsluvgWhPJR/41bDP0J7CvX4jgUV?=
 =?us-ascii?Q?6uRF4DfPZ/SzV8UjcDiXn6Bovv5U0IYQDhWv11LCSarrvwTJK7ygQWxMvnpM?=
 =?us-ascii?Q?1sm45queGGdGkaoK6rjkBbKAQNShNneer5Ell9MxXys32/zgMGf1CqJS4d8T?=
 =?us-ascii?Q?JQDzXYM/yAixlpWvAS9r4s3hZVJ77D2ZScWQ/+bl0NtHU3i7tCbMLxRa+t3C?=
 =?us-ascii?Q?kVNzIwXZDpLVltskTcTOrgB8KlrDFKLMg2LPVvPv4KbK6yw7aWSLmnEqvMPg?=
 =?us-ascii?Q?1QQRebT+qc3W/rb3PCzNo2sItKAiH2GVJw+BBnPDDSAKYpBfSpn5BXcbxVci?=
 =?us-ascii?Q?E6dCmMV6GkCXEEH//dvZ7SKf1OFEXiE+jhw3tJx28fguC4de3aARLui9LwsT?=
 =?us-ascii?Q?woMyi0Qlb42rllegtWjXQpE9n3FREDWV82UIb7T/N+o2CD2UKNnDDvlGJ13Y?=
 =?us-ascii?Q?pMrTFwS7xZnq4gEIaUZeyMDw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0e6515-3500-46c6-6660-08d96314c176
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:25:04.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fd5bu6qJgYhfiS2i+3ENuwljk3t+FWIokJHrK7ODCL0UgAs9945QBC2Fz2rhHcmo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 08:25:50PM -0700, Selvin Xavier wrote:
> Some simple bug fixes
> 
> v1->v2:
>  Fix a build issue
>  Reported-by: kernel test robot <lkp@intel.com>
> 
> Naresh Kumar PBS (1):
>   RDMA/bnxt_re: Add missing spin lock initialization
> 
> Selvin Xavier (2):
>   RDMA/bnxt_re: Disable atomic support on VFs
>   RDMA/bnxt_re: Fix query SRQ failure

Applied to for-rc, thanks

Jason
