Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD32232340
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 19:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgG2RQy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 13:16:54 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2496 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jul 2020 13:16:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21aef80000>; Wed, 29 Jul 2020 10:16:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 10:16:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jul 2020 10:16:53 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 17:16:53 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 17:16:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSsNpsbav4rWCKZpPDdoR7k3joMHQU6OM0CwVN7yxOeYJDYLgE39p9afzxmJyipUK0MCbqxXhLL0C8rPNVv/PS2UOVg5UCjyNSaurfTWaO20WHsCs/q5ta+a25ZQsbHBx04KPoKN40ZtSMeHC6jJw3hc7ftDVmoO1T4UbgsMDukVC35CiRsQKfyGWj5eeD3620LB2zqneec8a1VqyWy6dt0ptJEW30Br6aE0ZbypmjbEfNCaQjIlIvm06nA3PocZ/J8hrOjUAUkFxXJM6HfAj/b6lf2PJsGWqzztLUNsO80cOkRezugNGuuWxRsKx53xazV8BAEw7t9iL01S3bPhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5Zbk7sYINEjXUBgX0oFptGT36ANoqiyy19yg+5ckns=;
 b=aFVAh1iXa8W3+CL4h9C3YYbj3Mzeg/d8uq/oiLmiXj26EMehV3m+qD39J2tnGFOH0K8v+XYLifzqTgnmlcrmUeVqW0R9Ib0gM4Ya7EqGxN8bZzE2HoMzRIUnEq71JgwJnRgVl+4ROR+GZ5Q6niui3b0rQ4l2WKCiJqa+0hivJq2wICumNNcScYIcRYcSOuOpc89D74xhOBLDd2tx4b8VKgspMVFwgXYZXixuQVswrq2bO1bvLCHCu0v1BgqhE3H+ylW9kkSPsKIfmLu/MLHIvBeMUU0C6ZnpqhreuXMLqq2nhKCU0vhuuFzWTrqch/6Oa4OpR3m/wpQjOWUllgfA6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 17:16:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 17:16:52 +0000
Date:   Wed, 29 Jul 2020 14:16:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 0/4] Fix bugs around RDMA CM destroying state
Message-ID: <20200729171650.GA250741@nvidia.com>
References: <20200723070707.1771101-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200723070707.1771101-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR0102CA0008.prod.exchangelabs.com
 (2603:10b6:207:18::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0008.prod.exchangelabs.com (2603:10b6:207:18::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 17:16:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0phC-0013Ei-EK; Wed, 29 Jul 2020 14:16:50 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 765c17bf-944d-4560-9575-08d833e32f56
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0105:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0105E54B43A9B2BC8B14D689C2700@DM5PR1201MB0105.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhLP7qbqDfNqRFyhFoXVJQGZnTI18zDHTA63WCFvGuO+4bIZfj0uGtMK/dW8D4QGuwuC/yIDvptmbWtXetaT5tTaoMkmED5c8mjQYK7Xx6szhY8Mhcp3xeKIq3EkjfO1r4OUGOL3RSGmaO9rJ9w2qXeClnZeI7v3Whoq8sRgFXpVuAhWwUThKQxM2SKOchv7pbEmjJJTdvayLi35o6Q8deWOObtYcHbmY5lcX6nI40q385jsKIawPQXqRmI7gdK3gxaNP61o0zIzpBd2u/0AnZQb7D6iPxN9l9Znw3bRLpw3btgfLD3uTVdcbsY2JsZiSkgDyUL2oQKnM8K2N0ykpqPtB4/Zn9lY48iywKeuHtuIkJ5sFS1Gwbb75KWRRy/2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(426003)(186003)(4326008)(66946007)(83380400001)(66476007)(66556008)(2616005)(8676002)(2906002)(33656002)(54906003)(4744005)(316002)(5660300002)(1076003)(86362001)(478600001)(9786002)(9746002)(6916009)(36756003)(26005)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6HRG6lwjFhMSVZe2hMrxK2JnO/votBAoT4qxbormVGQzelf1WX76VmdknncjdqpPQz7BjB48yvrQwMbfOBQLwbTRqY4vq+YH5mNoGXqOfx+Hhwba/Sb5iWRPhFoKRkYc+HdOrp9sMGjLV89Ik7auBNEim+FZ+r3RATs9rQB+h7Eqr/etX/LCt0YjBNgiYIHLr1AgIqX9rDfMr3RIHUzEweYmNcL+c2DWmm5sPEZJIImDz+MBimCVnaGdTmYgYQ9DV7Gs8TS1+ULTiZIzQ/4xz3TXAGTqHdYvOXn47JSVhHAU7dgXG4fggdR1EToR9wLPMBD3P08UHMaTqzPDNO3d5Ywm3ac/V5muBcbVMF4vquInFDnYVyHAaC/OhGO+c0VLrLtxgvNuQ45AdWOtrzmLjxCuX8TJcyS+c8QL2DMYFYVTsmrlFaooOelOG3vQtsDg/M89A1CcARpOL1JmIgb8jxPxPbt6R+W9iquuJ3yqH0kE33gBumMAGBThrrxYiNquQMqz29S2oVIPa89paz5Vxa4UcAgt5G5fbp0x0daesAqcfsFcnlzFlfyfEG9y1NPdK5Jdkw37YtPLHwDIwht8tMULtISYXtvCS0AcP4iQt1i5Fv4iErx9267PBABt4Q5sNpeGTUYvpfR5wisZ5WvCYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 765c17bf-944d-4560-9575-08d833e32f56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 17:16:52.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDnZJBIJh6qHKuSBWN7HnmqJq17ltvYeHuN8ML7S/e9NRdydvaHO+d5G3hn9InnX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0105
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596043000; bh=W5Zbk7sYINEjXUBgX0oFptGT36ANoqiyy19yg+5ckns=;
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
        b=G236nRodlj1fdYrqMGpWfKJImjmzxLzZhIgQhQuKd3aRB4csJgfkCPMzR11VTjN3C
         RllvgvqpTbJwHIPFw6Uuww2CrMDtgf++JIBPVhBm/stQ7OHvgj4uiQ3MR6f0TW3GeH
         1MUOCdqHpFnk8S01sreP+tO/W4eVXslgQcfEZqbUmYkVFy4dbx53o+yfyRvIKxgM+g
         JyfEo+VPkMAJfGW6aW6DjCqKg3+VoGKmZc1ia+zadIcygkmiP3GEnSymwBSQFMtDD8
         JEUmlZJpN3KCf+LCdg2SGBLGk8TzmnH13K7rcP2ag+n/7HelHVFnenQxmovmDqXjGz
         cyo/bwQBZ1FdQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 23, 2020 at 10:07:03AM +0300, Leon Romanovsky wrote:

> This small series simplifies some of the RDMA CM state transitions
> connected with DESTROYING states and in the process resolves a bug
> discovered by syzkaller.
> 
> Thanks
> 
> Jason Gunthorpe (4):
>   RDMA/cma: Simplify DEVICE_REMOVAL for internal_id
>   RDMA/cma: Using the standard locking pattern when delivering the
>     removal event
>   RDMA/cma: Remove unneeded locking for req paths
>   RDMA/cma: Execute rdma_cm destruction from a handler properly

Applied to for-next

Jason
