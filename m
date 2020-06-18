Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508151FF3F7
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFRNxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 09:53:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4584 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgFRNxR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 09:53:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eeb71980000>; Thu, 18 Jun 2020 06:52:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 06:53:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 18 Jun 2020 06:53:14 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 13:53:10 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 13:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUKv7Wif0QJLPwoylXRkRYF5UgnbPnyoWHcurxujH2/pbZKpkWJWnsQR98ezKDq4wGQycVCvXOvrd04ImcFiIwM47Xu2x6vMu1JPoA7uEhNRDDpLyLyl3WG3NUnDVLCXQ+exfZLYlCUze/3L6B2oi64Qh4n5vq6HZHeOBUBq6ZulZtuBoqZokbQKrwJqWFOkXkPYJnCk97ok7DsYqAjO4inqTYV+Lk+z4SY9tKczT9VNTLiSn+8rERcD2fUJ/kbd15iaA6keyzxdO+m0L6N09SQkfGaOtQ0YcqM0BsIsH5rEslHJPjkzkpWWHO7enDuLuc9wMRrqCUwOTslcNgTzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsITEAqegEUjifJGXX0bzZvHQIyIpZ0i1U01ffWhy2w=;
 b=fG5nk79/HoshnKhpX0ozFbhrfy/JOAtd9VkszIURpzqVpHX1JNgeuevT9h25cGKmeyzJ7qZG0FO54Bekrrumf7yoxGIRVyXMkuEjgNEKbhWXIxIStSHZ3kOXQdB1sMN0KVaCSTTsEFpwy3rwBvJZfQyEnB6NKuigE8QB7IY31WP91O69QgZii4ufhbv57sHQTJviJmQ0HCH14zwUagrmlrhNqDvOto2fmldqHlw90f5cdiuHCyLpSNfEQwdVPO2JmzPMCJ4hBvYsZuYRx/lxzPfg0ozXIw8p2KdI3ShLaXJwriA1VZAEKsxwVtZpKcOdJBvTplzpfvEB2cm/6xqBJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 13:53:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 13:53:09 +0000
Date:   Thu, 18 Jun 2020 10:53:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix an cmd queue issue when resetting
Message-ID: <20200618135304.GB2417384@mellanox.com>
References: <1592314778-52822-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1592314778-52822-1-git-send-email-liweihang@huawei.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:208:120::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR10CA0023.namprd10.prod.outlook.com (2603:10b6:208:120::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 13:53:09 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jluyW-00A8tE-A0; Thu, 18 Jun 2020 10:53:04 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 167a243c-0966-4052-098a-08d8138eef11
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13373DA8F84E9368E42F374FC29B0@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw0hqGmDHzzG6kKXk5YzqBOWtjviIIG/N646Ynh/ExVwfRbBf2ljuYdTHQbSxjBuOGnKlgWUTWO1jlLuCm0rfj6K2JxaHjRP1tj21hK3M2BYTJvXHg7AbJNIjIjyU1nrVqU0OnmwxbnB8f9pc6CJClRVSLchZJynE1Oc6eiis7g9N6NbU2QWznz38QQmlVCvXSc/QOu+Uixhfywedc0PI1HNUPZezlm5dMa8yLVpSo4GnxvIwWL/PeMV5tdU0BePX8oI3RFbwHl8GYq7IS1IFipDVKfMluCmSwBZ7+TLtlTDwIFtalPfWxBy05Rpo5T2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(136003)(346002)(366004)(376002)(6916009)(8676002)(26005)(66946007)(83380400001)(9746002)(2906002)(66476007)(66556008)(426003)(478600001)(9786002)(36756003)(8936002)(86362001)(5660300002)(316002)(1076003)(4326008)(9686003)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QP6CcXXKxrZVZeza50nbW4V/wTSOAMn8BlJcL5Xu2/YFE/734WtUwmIps4U+z9Vk8aU+VsvBxsI9wx7qEQWQgpn1fvUTZv8FFGmlD2FXBmC6SsRlNt12Tmyk7I0mHxoIKqbJfOW9bUAFsujlmZzLRz8r7C78Nr0BTPBJnABLShyIvL9VGZ/Jiu2IdxsbAZkyeOiBTPd3NGrcV9RdoXgp/5kjOQD5l9Gbi6WrK0xzGkqfRH09v7nhZbqI1wo/xufmeFGjLEzNfYIL8S1W+B7ZlbjEBIU1e0tfvTpGu+d+n7X7NtuCcu/zycIF9VPpji49Fywua3WPquIainkkOdwc+pKLCCl83EDDRdFpKQcBdRZ2FRp7woLN9+Otc1+f6kAL/kB6OXe2cXfbRw+yIn5SuY9LhzmfMcWFBkk33OKgIawirtoZAkvQ/jQoocTcb5jD09gelVwSa4mzPc2lV7FVoEhPJ1YVKVlsTSBGdixnuqY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 167a243c-0966-4052-098a-08d8138eef11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 13:53:09.1069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0t5tDxryaJig/071wu8xs+BOdj1Gxq53yQscyR636xoq5DwqyMpEd6IbjASffRy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592488344; bh=YsITEAqegEUjifJGXX0bzZvHQIyIpZ0i1U01ffWhy2w=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=SZ3MDLQsMoKPSMN80REQ3vQ3a0dmw1hKBJIDwsDfgWl7uGh0wahLu5Wwk5wgjiK71
         xx6ndFwqop0OS0QGndbe52jV1yyTEjmwidCE6Dk+URS9MWmrbPLYFX/Ps8VpBqdFWs
         9qdY4tbBHTTTTWWe6yCl7XvZbSKRWG+LOkPONYISnFKe1k6XUVACK0Hns9LBri68hp
         OI3xslWJYbmCbwN+u8ffUo3s7RrcZma8hElgqemwHWTxi7WBgPfks+ZDRVfjNgDPrP
         gJ/gF9GFZlupQtKBHe1DiypoK7cQyaoTkxkW+S3SC+g0Dd/vMfkg6OO/0RUweaICPq
         KnuiKnqsPbC2w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 09:39:38PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> If a IMP reset caused by some hardware errors and hns RoCE driver reset
> occurred at the same time, there is a possiblity that the IMP will stop
> dealing with command and users can't use the hardware. The logs are as
> follows:
> 
> [17223.382506] hns3 0000:fd:00.1: cleaned 0, need to clean 1
> [17223.382515] hns3 0000:fd:00.1: firmware version query failed -11
> [17223.382516] hns3 0000:fd:00.1: Cmd queue init failed
> [17223.382523] hns3 0000:fd:00.1: Upgrade reset level
> [17223.382529] hns3 0000:fd:00.1: global reset interrupt
> 
> The hns NIC driver divides the reset process into 3 status: initialization,
> hardware resetting and softwaring restting. RoCE driver gets reset status
> by interfaces provided by NIC driver and commands will not be sent to the
> IMP if the driver is in any above status. The main reason for this issue is
> that there is a time gap between status 1 and 2, if the RoCE driver sends
> commands to the IMP during this gap, the IMP will stop working because it
> is not ready.
> 
> To eliminate the time gap, the hns NIC driver has added a new interface in
> commit a4de02287abb9 ("net: hns3: provide .get_cmdq_stat interface for the
> client"), so RoCE driver can ensure that no commands will be sent during
> resetting.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
