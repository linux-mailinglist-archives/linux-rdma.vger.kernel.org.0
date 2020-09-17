Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E226DBA4
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgIQMen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 08:34:43 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:23437 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgIQMdz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 08:33:55 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6357940000>; Thu, 17 Sep 2020 20:33:24 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 05:33:24 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 17 Sep 2020 05:33:24 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 12:33:21 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 17 Sep 2020 12:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWj8LObK1fECdsqaVetx+VFv7h+tqUAZICcnrgRkuYlKJsWLEPdRO3IpqPoG5LoiAwzcgnYh8cLnIfPLLI70iviH9JFMifdys3l6o1TpQunvr7YEs1BFZjYB2xo92AMyzo60CCv9S2qThU2h1AvOGs6cfY+wcyjcdezD3zLLWrEgU+bcXdWb5ipa8NSaX+yh5kPsmKEeYkVeX2AZKjwbnNN9YbHg995fVAPSqR7ykc2MqcQnFrQn8/DIe9dd8y/CANbHvrB+BmnDMCusYvEiugSPVyeq8Yjg7xvTK1eWDkUVR7xO1ZlHfMDUqqf1LAUD4ZxY/uoqTzDpw/l6uxOcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yLxJt0yZPPbQtgXBuZx6a6czQdjw3yH6/DsWW2d0YU=;
 b=fTC7MBCRMT/USO3UEF2iptIy9onv6hVduxC2JgcqN1KX8YEAItoD7K28qiB4xRgotJWFCVyS6k7X/bNFIOzbvoeXp+ktKfupFnIvygs3ngqeu2Bmz5hl1O4Z+kjsEJ9Q2lVQcYo9J9LXeRdt7j0mRKqpn+XtUquIPlxNEFkMlxAXtlqmRqU/P6F2yBvogMQkXoW48+Raz4Mm99Z+5KZl5679g1T+KiwOpgToONlyw64EQopSWDal9dByipCYLcwy5lwBhDNh0axMBZamqdgy5/YqWWWSN4ekkxKdXC/We/+1idh+MiVuSzgXBH/MgPIjDfr6ua5UEvv8jdIdVUCJgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 12:33:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 12:33:17 +0000
Date:   Thu, 17 Sep 2020 09:33:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Eli Cohen <eli@dev.mellanox.co.il>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH rdma-next 0/8] Cleanup and fix the CMA state machine
Message-ID: <20200917123316.GA113655@nvidia.com>
References: <20200902081122.745412-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902081122.745412-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:208:a8::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0035.namprd12.prod.outlook.com (2603:10b6:208:a8::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Thu, 17 Sep 2020 12:33:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIt6C-000Tfn-5f; Thu, 17 Sep 2020 09:33:16 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5129e0-5b1a-4b46-b217-08d85b05dabd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3596BAD88EFB275180992A2FC23E0@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 64jmYwlwqcxw2l8iglwd5e8DD2OO9kRaeiMb+qEiadL0xxG9/AAMcTmYUMVmSyjZUrzSzQcqmFlTBivnouK9PrKbY1ewvGe7/7jYdGjWMFxY1gtMo63cxt0zR+0ozItKBkd5avx1PwQ6M5voblySqZ/wO+KsbxsluNxKSvhg0a+rz1G+YXgLVz4KuK6MhhnBfzc9GZ+0b0j/qyf1OhER9tpEvDkMKWwWMbD+oR3UYFAsqY1HDAhgWRKwIv9V/eDlULkIDIqoVZD5yq+SO9eQdw2Xa0M8B3I1N0hwrDDbbQaXhZ9dVukBOEMhr39fH3G7RPtfdym2dWwS8pq12odOJOitXWTzKJVgqRxd9xSSt0xegmyDq4zhZ7UY8AMcneVf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(9786002)(316002)(186003)(8676002)(2906002)(6916009)(36756003)(33656002)(426003)(66476007)(9746002)(66556008)(26005)(4326008)(66946007)(86362001)(478600001)(5660300002)(1076003)(8936002)(83380400001)(54906003)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8fnWdPjsUcT5FWk4qpvHO9hi4u/b4p2WEqpXcHgdB/llG7NPsIBpkF13J8DLt4BM5RqHNKbcIFe9fw0wtYSY08MUQ/d6GXMNvxv1mS7pdkfw+LV2K8mo/sOOvYSegZ6d8jweiWxOUCh1sKmVwhYzgbPYTZ/X75N1Mp8PJ7fZsVt3kj/fztAAgn4xTJekv+nanjniV4XnZuAE8ANtpJk1GZg/DrOFpzJg5yGwO+OeEAfXg7Rgzr3vBF6lnz0Xbn52g1pbgclxETwVz/cIyLnmSgvQIw7CpY/xo5C/LB9lF1xA2Ium4zc9WTmZK40kiTu1iCVqOeT0468hxQMNoAhTwUA93ldxHJ4HwnI6n/C3NOOVmsdBYIUKeglBL2tkL1dPy+AEkNyEY7wXEaSd6AMeIiiZaEiYsr8Ow83EqWB34Bg/voZWA/uzEP+zbeyaI7InpF6mv4tEaFZdJfD0pGeMqr+y3U6xblrc9XUd3VYxVPb/aM5SPUPjMvVD1SR6fAI9iqLnmsgLxQynlSilndKcLlk92doqImIEJGQyPL4TRt0NcZrJ8IUD/bXmNNSIon/VXQd5RU/aQTd7XViC63gTkVu8LCdRhcfiCXBONQ+E0cswEzCdBpe1g/DvuPWg0Au1TDY1K1Rxa59+prVCkVSmMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5129e0-5b1a-4b46-b217-08d85b05dabd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 12:33:17.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fh2Ymu/waGBR8KvpznRGBxW0/VWcTByjadVNABZjCM+WV7rwdQhXuF4dfSxOvfEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600346004; bh=1yLxJt0yZPPbQtgXBuZx6a6czQdjw3yH6/DsWW2d0YU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=nUdnU0cCS7unOAJNa3pHAVVY1vmVVBTR5Pkfh0TII4naZuwaGFQNPl7oJ3m+Hxffb
         pQmP9G8G2fWOnXlmkC3MuYvL26bSkzhJKK+capuUpvZgRbP1K7QISl/Dflf6Ehk2k1
         UWEc8X5+qcbO2c0aG+lp1AfO5/g7n8tFWXU4XuG/p99mdgUTazRTBUIhuSakNoUmQJ
         3yXjV0dSMO7Q3d0CIXi7VBFOG6pqL9kF5pP5iAM/elJolKAhBFhrqcQ+GvgISZ0Wft
         L5FwwDzJQUP4lIk6OntXuHhvPTy0YUXpm12Qx+Y0djX6Tsm+a19a44aTIGojbG8QyQ
         fpZTkAinYrWiQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 11:11:14AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >From Jason:
> 
> The RDMA CMA continues to attract syzkaller bugs due to its somewhat loose
> operation of its FSM. Audit and scrub the whole thing to follow modern
> expectations.
> 
> Overall the design elements are broadly:
> 
> - The ULP entry points MUST NOT run in parallel with each other. The ULP
>   is solely responsible for preventing this.
> 
> - If the ULP returns !0 from it's event callback it MUST guarentee that no
>   other ULP threads are touching the cm_id or calling into any RDMA CM
>   entry point.
> 
> - ULP entry points can sometimes run conurrently with handler callbacks,
>   although it is tricky because there are many entry points that exist
>   in the flow before the handler is registered.
> 
> - Some ULP entry points are called from the ULP event handler callback,
>   under the handler_mutex. (however ucma never does this)
> 
> - state uses a weird double locking scheme, in most cases one should hold
>   the handler_mutex. (It is somewhat unclear what exactly the spinlock is
>   for)
> 
> - Reading the state without holding the spinlock should use READ_ONCE,
>   even if the handler_mutex is held.
> 
> - There are certain states which are 'stable' under the handler_mutex,
>   exit from that state requires also holding the handler_mutex. This
>   explains why testing the test under only the handler_mutex makes sense.
> 
> Thanks
> 
> Jason Gunthorpe (8):
>   RDMA/cma: Fix locking for the RDMA_CM_CONNECT state
>   RDMA/cma: Make the locking for automatic state transition more clear
>   RDMA/cma: Fix locking for the RDMA_CM_LISTEN state
>   RDMA/cma: Remove cma_comp()
>   RDMA/cma: Combine cma_ndev_work with cma_work
>   RDMA/cma: Remove dead code for kernel rdmacm multicast
>   RDMA/cma: Consolidate the destruction of a cma_multicast in one place
>   RDMA/cma: Fix use after free race in roce multicast join

Applied to for-next

Jason
