Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E22631B8
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgIIQYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:24:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:54917 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbgIIQY1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 12:24:27 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5901b90000>; Thu, 10 Sep 2020 00:24:25 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:24:25 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 09 Sep 2020 09:24:25 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:24:24 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxq4x9xeek1yS3EfBl+bwGSIAnHRHQu0n48gawRE9ut77VyxUuA0ONW4leHBUowWokM+4N4aZKESNGSejSHC3ZHQHdVZiB1KIQ8wsAQmxKjSDi+Uktmuc3ZzeKl6gxMe3J3uK1pxH4XrqVFxZbIqDzReX8cLRcCF8yp8d7rlVY2gnw4OHktrgk+nmWgRoIFv0/QiCOzSTx5Cjnhj643h/X4kOcBqUOni+eiS75eVXZ/NsgP830pdKcaF4rZh5xk6XxhR0r/quc2J5fFwa0YuHbxn1XSv6FEyGqTACgsYV+PZybgTWDPQepHxvZuR9wzocgv5e1oQuE5zuT8mw5EVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjZ+0HVqC/2InhoFnP5eifHwi+aozRWS4B9Ml1V3H6M=;
 b=FHYCGiioOI2oXTNCLZvCYvhsy4BFQ03KAI4lYBR0q8eGHzdD5vKtWkGwIsE8G8UAMTT1GVT3YWRARYSKIG25zXn0saUcptcvTmD3j1RPhuqZ/u+CEqpkhmtDLKBbOwIL9fQJFtvxGnrMq+FJgeRmPVPk6Xdio3YcPSlaWOkanCp4kT7XnXEdwtZrvC8JtsAcjohJcsNnJFNxOL0kG1/CtN972072J4/Kxt2jynFE0O/vTLDGGwb8CgIf+zJdYukGPeGDNFQ9Kv75HqEfRtFu8ZXv7cpXee671BbHdbfdKirfhzehcF5U5dA5o1XJeyhTvPv5appVReW1dB9bCJfElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3516.namprd12.prod.outlook.com (2603:10b6:5:18b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 16:24:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:24:19 +0000
Date:   Wed, 9 Sep 2020 13:24:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lijun Ou <oulijun@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/hns: Avoid unncessary initialization
Message-ID: <20200909162417.GA868181@nvidia.com>
References: <1599547944-30671-1-git-send-email-oulijun@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599547944-30671-1-git-send-email-oulijun@huawei.com>
X-ClientProxiedBy: MN2PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:d4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 16:24:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG2tN-003dtC-9f; Wed, 09 Sep 2020 13:24:17 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c51a898c-241b-4032-9268-08d854dccd44
X-MS-TrafficTypeDiagnostic: DM6PR12MB3516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351650B6A690D43A20E775A1C2260@DM6PR12MB3516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nK4PuzA0FEGMGu1rbEu/C1RaAWvwtlB/rx2apmQoZIWKZyblCcjYaAuPVRDlIki1WV4oy2v6xdJNXyn4T8IgvKBRmmjBI0ykdNUChm7oE1d7a36XAg8PnGE2X2L1b7nFRNpmjA5MlNAKwgWcXOtIZCYnnJoRPEvLd5Dz1ATPSLXHTTp0yfgipVWfYBFfMI3t8FD07wlhMu/4HH+jg7hoJgsEeTValQ5HixxGv+cey+TydOs/yT9YwuUzHdywTOy1+2rcRDi/S1ESEl8Lnfudg1lnoSl1num4p1Oh+3ANQDmzKaq/62WBOu0sZFYVIL70u4Q8OBVRSqUsPv3F31SwlBRe8p6iffigjOAYITe7fa20VWBA13zOvv0fhRGUEVBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(426003)(36756003)(4744005)(66476007)(66556008)(8936002)(2616005)(66946007)(33656002)(5660300002)(9746002)(9786002)(316002)(6916009)(26005)(186003)(2906002)(8676002)(1076003)(478600001)(4326008)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FneqV1eOSxg97DVIQzv13mq9FoQaYbeGcA6AIcmKDxiGkUOqZo8br62OZCbbyE9wQTCRshNKuMYPT08/7j6P0oydqpOJUJMfBzhXEo9y3WnSZp0fCQCTQmZizgKlZcmzqnmxRxL332gtkDM09CxOTJfil2htOirVJ+2ZTRU3k9ytGWeuK+FzsCVRNZeqqPncZ/M+7I/QHuFuRIzwQUDJj97YxrRXvl4o5oxZEztoXbLwZbqIanH99AyCpI5P9xrlUoEyCi1ceMzWO094wCG8d7kB7dVsPdMbSoaMbcjRuRpP+rVeBtHFzFcCvXfDKNA6TrnhO9t/VxyzIbzST1qk8MSJLgAfNHl/M106lpOFGgaB1KcTGz8sgmnJB/JcB34LvEz5PLqu4G29Q/xhAPy75sI9rdZnXUvcnwB0OQ3vxRWpDplGuUtEZJWZCuXoEEtbEP8gLaZHBalUf4AugS1HvsM3if9rTmZ+3XFf0Yrn9FRo5j2sXfGvWfQ87i/WzwZNV+DrxrOOLWd+Qu4gVJfrwjWiJVQxhLBDxIvtoNSAf64l51Te15ilRDK8E+8ecoQrjf18xbUFeokGSes0ET46GUx1P3/p8Frwmlp+vNIZSK5AMqilWqIB3dbA+Mlv0GLJ+knAYyGvUuGQPAr6E3ceTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a898c-241b-4032-9268-08d854dccd44
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:24:18.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH2wAGVwq2EK/fqEX7DOEzy44khLrecn4m+Yq0sF4d6wJr3pthCpzc7ffhGdatE4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3516
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599668665; bh=zjZ+0HVqC/2InhoFnP5eifHwi+aozRWS4B9Ml1V3H6M=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=SLgmTQwr3Iy7tgUWejd7zuY6r72R9/zlLqMLBloxj2xYtgSPMAcx7S804zAfZg3ZL
         kfO3DCMUpsJwXRIKO2wZWowPhubnbt+didfE1jA9jggfBHEBWobwhMXzCF3Hci6F6C
         o24V3OxNnm1vsOmPgPKuboVPyvqAHa7FvpNtZmbH6uwS6JnwbqIOj9aO51IXkp12nV
         j+EYAq7S2Zy5ZAIQ5Ai7s92HwKeTl8b7zymXEYbh67d2HiUf3L5u/Im8VJPWq6ZaYK
         NT+yApOHLAGDoRY2akFUe/HXoojdDjVWt6TJ62vsZDD9IHWipytp3PLLhkfGdRTqCP
         OFnaDVCJxYFGw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 02:52:24PM +0800, Lijun Ou wrote:
> @@ -817,6 +817,7 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
>  	struct list_head cq_list;
>  	unsigned long flags_qp;
>  	unsigned long flags;
> +	int num;

This hunk is unnecessary, I dropped it

Applied to for-next

Thanks,
Jason
