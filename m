Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E4025B796
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 02:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgICAUw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 20:20:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14382 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgICAUv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 20:20:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5036b40000>; Wed, 02 Sep 2020 17:20:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 17:20:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Sep 2020 17:20:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 00:20:50 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 00:20:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8IQBlIStYjEDlxjuoao5TStDkN2s4O2sPdNqMsPlu0BmEq0WYADQryS7PYx8xxuKZmkxjYNwlGvpAHMc+MO/FKUAw9UzYJBr7xpNJTt0bxm2BecUJ9RCbzHu4tIeMt8QhBsKZWG4XPnIHJE5I7HkH4Iwc2kB1jxjyYEJnoHiHpCS4ERoCnL3eEr94ZPggh6TDZq/pFyu7902MFeZeITnX+nVFKzw2GA5Ezck7i3gS2TwAnNTAm+oBpiXgtzFYrDNU/ImwzfjIQUFi5zW2Rqb2dO/zKArwon25163Xd6ThJ0/ZbqZEFy4oxFfVImpE/xtUt4g2xzHzDlTAI7NoBUEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F97t3AWeurh3XaNYjCxl+lqfjcQGSLqTEPAU4zREVwg=;
 b=ENwH9VeIglfmQLc8dQYMTBDsei1PyG8oxP3erla/WSdBjZdyf/DTMPpnagVwm2PHUYLdvStu2WMyfKpLGialLuspaOyvfTIiCW7ReoIRQhLatv4s5ivtoW+6c4KoFp/smimCldHi15S8NhwJzyseNaS+vYDbeb0l5vYyIeKJ+fMl7K7Lkq8lQ6Zn4GWpCbk2kg1PSZ7Lb8NWsolbkLyBCopldJESY6rRc1lKoyWXHhVjeXoIGNr0URIP6pmJOdilmAR2ivyw4qUmfaMWggF6dKO/SVRsP0oAHvS4noxnXE9HVGfczKL/YozEO37i+HJJz7JIcGDFf/xY9bXd5fO14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Thu, 3 Sep
 2020 00:20:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 00:20:49 +0000
Date:   Wed, 2 Sep 2020 21:20:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 06/10] RDMA/core: Delete function
 indirection for alloc/free kernel CQ
Message-ID: <20200903002048.GA1480415@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-7-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830084010.102381-7-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0101.namprd02.prod.outlook.com
 (2603:10b6:208:51::42) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0101.namprd02.prod.outlook.com (2603:10b6:208:51::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 00:20:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDczg-006D8t-65; Wed, 02 Sep 2020 21:20:48 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70e62a5-3ba1-4922-9d14-08d84f9f35c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28594DE860396D38E03F7D8BC22C0@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSwYXw7p4Yi/AxXf1mqQOGy02IJOGC+OOZXLr9cjqkbCm1NxBMXUuivrVOuTDgz6J7MPzgx8FI5XyUXkJZRHG2g+rD3VzlaAhjMXpCXbGrgfD4mVfT/aNEK7g0BfyuBH9UotCH8IHmIqylVXdjm0DfM3dq71qgOe+A/yh2XrfnI7jJRAQyegG+fOpB/zwtncfKRTJ1NFlwGdcDIo3+xMR+AsZjl/Ekd0NnsK1bM/Z56VLXSXRCAlw1kkT7jh75SOecLwKHfSwKVF8bIHx7vhHtgJbBtBIxNjJHQnZc7bj2lurHi+T+gfO6VTsVuml7mj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(8676002)(1076003)(4326008)(33656002)(8936002)(86362001)(2616005)(36756003)(426003)(6916009)(66946007)(316002)(2906002)(186003)(66556008)(66476007)(478600001)(5660300002)(9746002)(9786002)(4744005)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OnU1JfsxliJc5zZVzJcnlEF/4KxT+2h99CybnWEvR3cb29eNI/gMiw9a4q4O02FLLBMVPHt6piaEDOopQ02IfGq3+PITGXvLOJqdPNSTmrjiFedHF9XHqqNH9yRJabeDpkjjWcFCNu+jVK/lesvqqRt7cYk5Kel/Lhh0UlDUC8/m3AIZ/mQsV0zKbQ9Zx5Crt6vgWGeq1jD2Jp+4i4c5NxM0apq1Qu74oTTqtDspr9bH3RXNKrIMYUNalk01De2cao9Npohq/5mUulXwa3FYDmdImtY+UZwfnJGpIQNHODk16GS4FHBQ9jDxMouix9yJm4phl1LnN9tM+bewFaoOGiNmMkonCI6I/GrPCjmjfJ4Q9HQ0vx1M2faQaQjrDAZzCrW/04mGOyKtLBMttTT9slTH262rqEJgc0+66ASIpRdHK17sSHb0nMWd+kmpDmhRPtNl0uMv7EoxBP179hsuoM8Ks19HEFHIRZFtyGyKB23e3ePoKUqwJSPlaDlk50AWpr7WGkCwxiAOxuc0JTgFSf1ofyEB0rZjPpdcLh/mRsWi6VVVTZYLOcqoSjgU6l9s7gHYGE/HsF+wHxT/noKJTK1pQUiyIZw5wd9q5eHF/DPwwjtLcBi3Z6+ypfOXyVUnz0lyLa12YJEEUVDgGKWUeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b70e62a5-3ba1-4922-9d14-08d84f9f35c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 00:20:49.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKxeqj8BoV7YIVbPvFKFoHY65TD70GriMmj0hWAhkxzQu4UAk0jz/k3XCKSvg37z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599092404; bh=F97t3AWeurh3XaNYjCxl+lqfjcQGSLqTEPAU4zREVwg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=sDCvMWO0ELczJ4puaIDxhAlvhlW97deWBARKVGamgBhDsPGs2AF5OJMQ4sSu7eG4Q
         9XwOt/k1BA3pTQswemzVbC6btxwJsbIITZ6RLKwATVtO6r+0hB9vaGy3/Bydy58BLF
         cRxkAHZX9SAEVv6DDBOGRG1ErDOuvSOp4xDRMqqyQrNzDdyx+Q+1M3w3k+a6/wlV2g
         YXWqjcN3MPEbHUZ7ywuWAiaPpqtm9t7UJkJViY1Fh4n0qMqpYiyxb6dJhfdHo8+lLz
         S0C2xT5fZbmkOf8UC1/gCD4l42nCpsWRiORWLNvdDiPbOzSqTzvb5ny0umWQZ0uOAy
         8KGGfnHCpezFQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 11:40:06AM +0300, Leon Romanovsky wrote:
>  /**
> - * ib_free_cq_user - free a completion queue
> + * ib_free_cq - free a completion queue
>   * @cq:		completion queue to free.
> - * @udata:	User data or NULL for kernel object
>   */
> -void ib_free_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> +void ib_free_cq(struct ib_cq *cq)
>  {
> -	if (WARN_ON_ONCE(atomic_read(&cq->usecnt)))
> -		return;
> -	if (WARN_ON_ONCE(cq->cqe_used))
> -		return;
> +	WARN_ON_ONCE(atomic_read(&cq->usecnt));

In this case we expect ops.destroy_cq to fail, so no sense in
continuing, leak everything, the ULP is buggy.

Jason
