Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B74A2D76A4
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 14:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgLKNec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 08:34:32 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:37130 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgLKNea (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Dec 2020 08:34:30 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3753b0000>; Fri, 11 Dec 2020 21:33:47 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 13:33:47 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Dec 2020 13:33:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFHw7HDpZYPyXDX51wCkEGBTEBv3n/sYmYY1j6yF9bjRyFUtYmfWcwpXXNx6AjkjVn/RMYC4Lda6S3hAk78AdQybIhHo0blb8JD5AQ9n5Dpl0ATjp+NdmJnZRSY8b7hjWQA5ctYclvKhw70yLAyZOkxrSkR/kULKvGg62rd0G9MGAiH073ddYItYJ6JozTdkjRjWrqd2kp1sePpLrpJDKPz3ci4S+AXvvriNqTl60MSm4aI5pnsxUga0T3067e0j9T+gSvjVOI5wWz0FoWvEjjFfy3N9EVwGScW3jbDMcvzC2WjjwKOdyHoiDdd8uLl489UV9cudFHvMlShlAZjXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGZymeefkB2nkR9tJCfwsf0k9ITtMbXnzJz7olLe7CE=;
 b=RNxg8ccOQKUDOdwk6+NbURum0X8lxJX8m+SrYku2LF9q6PrerlelbxqIOJ1FjzGxPva7z4GM80qP2QefjLnGPz+OGRG8vXAiu9YmB7ebC8MXE9xoPQfhVAogaphXUQnBtM8yxAq0WEx8MQNk0SsvuT5JWOSUQquLn1DUkgwMd/tu5vW52sDRgwq48iskznWk/dFoeYbyqoa7zbQzeWkWhzcgsqBgt0WuvFA78yBHUyQcsPy9qCvLD12ddMpIOExW19pRdup18YLyXp3lXO6KDitpTKUoyeMxeh44GVabH6dgyzFXeYMO+HIzpep37RTonXDzwOZC49zZg8CGhdx1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 11 Dec
 2020 13:33:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.018; Fri, 11 Dec 2020
 13:33:45 +0000
Date:   Fri, 11 Dec 2020 09:33:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: Holiday Schedule
Message-ID: <20201211133344.GA5487@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BL0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:2d::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:2d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 11 Dec 2020 13:33:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kniYK-009DF2-G1     for linux-rdma@vger.kernel.org; Fri, 11 Dec 2020 09:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607693627; bh=uGZymeefkB2nkR9tJCfwsf0k9ITtMbXnzJz7olLe7CE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:Subject:Message-ID:Content-Type:Content-Disposition:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WejOUrcTLTnS5JjbvD+B6gfrEjOVwBWGZR4qUwZS6Mi+Ude9QNktMoXJXl7YhHaL2
         TlPXGxl+PlyD6PJQBv+6+LconzLycjLEv8eJCB7e6WWdL3vP2LE3HWmtiLkiIEJfV+
         vWPPT/BeMdTs2yRf2U2yEbWzSXI/HDWbOuUh4/I70oxKPi99ic7txYNJYmkQd3ss5K
         L+HsYZzwWM7gWPKTDdu90HSMBAkRI9guCqpvx2iRVdNCBzGltzGsUjuCbC5mbXPoR8
         F+u7t5ndl85qAGFIFsZ3McoqYTqlpMn7Ny9sN6LZDVMOofaUqH87E/R+brYPp3Y6uc
         Oxb/iLejwgPNg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just a FYI,

The merge window will open next week and as usual I will stop taking
patches for the next two weeks. Additionally I plan to take the third
week off so things will not return to normal till January 4th

Happy holidays to all

Regards,
Jason
