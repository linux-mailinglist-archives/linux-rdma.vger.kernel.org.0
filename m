Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BE429D971
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbgJ1Wyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:54:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16469 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbgJ1Wyq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:54:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99b80d0000>; Wed, 28 Oct 2020 11:27:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 18:27:22 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 18:27:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDCt4gUnfcQeWpSX1yljF9tWqxMPYXosm3RAvoP2gTazlsogCVFaYAagfY57FZSc6afU932rzl0rXPbirdDdoMVFk6WprgwieDHyiermzrgv4mhF524Sz8Hzi8ef+iU6/5yTLgCb/NemQ3l0HSIuBit47lAzy6Ld2HjDzf9WT3FT5FocCdfn27Htz7BOjpE/P1S8n9BvZjSj9SxiIyIDLH7mkzibBLmZ/Y6202wdDsXmWMJFsO+wuDWcZI07O/GxaQwc/8Fbmiit+wSP/pzuF25CvXFIimtKY+Sypyxg7Y2cgvAZyXZ8EqjzpimKHsjvji5SAXrotu30QHPUCCdtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBMPHJuyCV1qEvghOQ9mNJcFcIJpFIEfKh71YUrL6qI=;
 b=GG/N4B8f30I0h9lIxoKp1GoLA2HqAp1t1PVKoO1xQXFeweeG+TcyaCoY+LH/nBFT1m/9qqf7fLJrgUGxuaxnToLBwR3rCYTtqnQ+cbXAGuXCHTr9K0kWeituRcfsEjokgn5S6N+v2JdE9Nmj8Gfq4fcvjCN43+1RTDEuRulhzga7yCFjbE1qBYvNOKghVCmBjfSgy1pz5R6TCYJ+dqcnbPNxqNsE8kPjF87EUDDZ/XAGFLgUjUhqtO5yCTFLgqnEmu2y7J+yeI9fZAYZCKp76uZ3ZMj3hlJNsU7vFNmbC+mi0oSgI1qeqY53W7wS+dP+dk6xtlBvUk1aHGSuHtVSEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 28 Oct
 2020 18:27:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 18:27:21 +0000
Date:   Wed, 28 Oct 2020 15:27:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
Message-ID: <20201028182719.GA2481497@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1602122879.git.joe@perches.com>
X-ClientProxiedBy: MN2PR17CA0033.namprd17.prod.outlook.com
 (2603:10b6:208:15e::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0033.namprd17.prod.outlook.com (2603:10b6:208:15e::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 18:27:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXqAJ-00APZ2-O2; Wed, 28 Oct 2020 15:27:19 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603909645; bh=FBMPHJuyCV1qEvghOQ9mNJcFcIJpFIEfKh71YUrL6qI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=npFNQ9zQ2IjKyvaHIWaAEuzLE1Qc3GYbL3qo7p1f/EdYYRO93gJmzM6NTFjSRtFc1
         1LzOVz0GKXWToKtIcdBjjNiiAZ52pZ8+KrzBctjlUq/qEd+LhW1uy0HFhS8QIPR3PY
         6yNt/H/b5MPBqsIYftK7ysfNHjDOzC4yCfCKDzTYBUBBsdArMLPyoFsr/0rNwpUNMd
         BMlW4FeCA85K93z4nRcEgugDcxofFJfIAy+WjeDoRYErK8rAlupWonAGDddAPccY64
         J1jPnyXOeVGQ+/fpWDAUG0J9c3hr++gH9bGhF9JJn5LOsOzqqBxI702hN6MrZCfOAS
         bQCjPbRQ6/KjQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:23PM -0700, Joe Perches wrote:
> Joe Perches (4):
>   RDMA: manual changes for sysfs_emit and neatening
>   RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

Applied to rdma for-next, thanks

Jason
