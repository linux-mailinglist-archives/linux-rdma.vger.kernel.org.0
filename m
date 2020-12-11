Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7412D7F8B
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 20:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393974AbgLKTk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 14:40:59 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19174 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393841AbgLKTkj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 14:40:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd3cb0e0000>; Fri, 11 Dec 2020 11:39:58 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Dec
 2020 19:39:54 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 11 Dec 2020 19:39:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO9+cP0KxpwSz6J5n4Xf6taFpPUtQw+++dUOyrxVGjWhv5QMIAd6b26BwX8n8qBj/RwK4UuuhRZrw+yWXhbe08PuDNPeS6GCwxL2vZh3LXaEykT7+quMomJ6hTxRN2RDhyjrp5xHCeklOSdiyeRzblmxMq9JH3db1Ucg43fjqq+1l4geeza373jHcpVONjyn6CAdZ+TSLP01qS5IXnw+tZ23mmw36kQ/FzA4lKLioaJccTMquASFLfCrLef21+IRzq+djIdLlnsdZxUf+lhEzopQ58KW+bajBVbYw0BNB1fvi6jfY3RiIM0CUdF5KAhtp36RmNt8vdppHfchIGCnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxXsS4+infaTF8u3TjfuUHp+SfScarQqVxpMIZMIsLc=;
 b=POp4rTASk4H5/2jnnhXvlr6UhQn5N5OqKUbZQUgXq+n9x6FD0qxOq8VpDma3GzuaxAo1LGE4FUvbpDaVHw//45frbjm2C8s75g6WvybJH9VoKzHZkBaMUhnPDTHhyTrRy7SJO+mbF+AvrLnGkz8PgtqsT6SFvIGR89qUFYyo7sbKxD+NU5q489+ETzg7bMYrbmy3FYcr0H/3QNX4nO8JFRuGUFakSfBzec9Q+kc4xrEm1qfumy/5It1x/wHAAxutzdIW9VOQsm3L60VqesgwRQuRLsYC9S6W3Mnd/Fh/XWVDS7qKfo9axoLioSqS29Ts5QhQt7K00ykULCQq7PSTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 11 Dec
 2020 19:39:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.018; Fri, 11 Dec 2020
 19:39:52 +0000
Date:   Fri, 11 Dec 2020 15:39:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 for-next 00/11] RDMA/hns: Updates for 5.11
Message-ID: <20201211193950.GA2222830@nvidia.com>
References: <1607650657-35992-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1607650657-35992-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Fri, 11 Dec 2020 19:39:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knoGc-009KHQ-7x; Fri, 11 Dec 2020 15:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607715598; bh=MxXsS4+infaTF8u3TjfuUHp+SfScarQqVxpMIZMIsLc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=koBZEy7jQqlcsBvOpoe7mVAQPXAeoL2e4H6SPS82/XvFQFuR4bfI9k+u7xiACAFak
         doA5n8rh5R4SB4QORmRw6yBFh8ItugIQEWpY1JVjo88TTL1E5ZHG6jTfJnPY+B/3J3
         mdhxS4kFHVHzp4oXV5JMs3Cv20dyZ50zzbz8J+VWCPMguteBeihPpVI/1UKQcizXGv
         ofgZRooyIRLD4oSmWV932aBufOWLMhIjwAXiOcxd462ZVsPxt9Qi6ACx3QW5gDCBoT
         kpTPfakMjAZC/yBc0WjP0hweMOaO5QAwyqcpB/E52/wnBDPGkTTmlj7EOXpa+KzZG5
         wN3ozDF6k8kLQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 11, 2020 at 09:37:26AM +0800, Weihang Li wrote:
> There are miscellaneous updates for hns driver:
> * #1 fixes a potential length issue when copying udata.
> * #2 fixes the unreasonable judgment when using HEM of SRQ and SCCC.
> * #3 fixes wrong value of Traffic Class.
> * #4 and #5 fix issues about Service Level.
> * #6 ~ #11 are cleanups, including removing dead code, fixing coding style
>   issues and so on.
> 
> Changes since v4:
> - Fix a compiler error caused by #9.
> 
> Changes since v3:
> - Avoid an unused variable warning in #10.
> 
> Changes since v2:
> - Remove WARN_ON() in #5 when filling QPC.
> 
> Changes since v1:
> - Only do shift on tclass when using RoCEv2 in #3.
> 
> Previous version:
> v4: https://patchwork.kernel.org/project/linux-rdma/cover/1607608479-54518-1-git-send-email-liweihang@huawei.com/
> v3: https://patchwork.kernel.org/project/linux-rdma/cover/1607606572-11968-1-git-send-email-liweihang@huawei.com/
> v2: https://patchwork.kernel.org/project/linux-rdma/cover/1607078436-26455-1-git-send-email-liweihang@huawei.com/
> v1: https://patchwork.kernel.org/project/linux-rdma/cover/1606899553-54592-1-git-send-email-liweihang@huawei.com/
> 
> Lang Cheng (1):
>   RDMA/hns: Fix coding style issues
> 
> Weihang Li (3):
>   RDMA/hns: Do shift on traffic class when using RoCEv2
>   RDMA/hns: Avoid filling sl in high 3 bits of vlan_id
>   RDMA/hns: WARN_ON if get a reserved sl from users
> 
> Wenpeng Liang (3):
>   RDMA/hns: Limit the length of data copied between kernel and userspace
>   RDMA/hns: Normalization the judgment of some features
>   RDMA/hns: Fix incorrect symbol types
> 
> Xinhao Liu (1):
>   RDMA/hns: Clear redundant variable initialization
> 
> Yixian Liu (2):
>   RDMA/hns: Remove unnecessary access right set during INIT2INIT
>   RDMA/hns: Simplify AEQE process for different types of queue
> 
> Yixing Liu (1):
>   RDMA/hns: Fix inaccurate prints

Applied to for-next, thanks

Jason
