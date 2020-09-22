Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CF274D59
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 01:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIVXaH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 19:30:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11971 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXaG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 19:30:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a88f10005>; Tue, 22 Sep 2020 16:29:54 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 23:30:06 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 23:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bxzm+yMfHMtxC/FMFLIk/Rpks7nVH7eN8VV+H3zOyTVN2fog8B9t0+m+YfYoTJPnE6e5mKs6Mu7OKgY9yUZOAu6GzBSBO9E0PlPeFn1oYxmcf5vmel5xFVn4jAKhzJOFOxCw/x2a0CkAWEXsy3M/ybHUb0zxzaIIbaJWjOraLQ6zfk1FhDOFz1EvWMxSEkIdzinLZpEgcJqi1BpuTNfwcNGv+AOV62k1Ibr10R3KoMf2p8zGy9kYxMgTmmOqHK4WWQh/y1Oho71cuQvmZETuuwflRoIUOg4KBarO9AMRnSq1MflukqYVAIojGEPiX0eA6TLzoim0Q3qFzsqpN4ruxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL7l6Hs7VsZNw3swntGVy/Q3zViq36CpsYgVYVM1rag=;
 b=edjiCGGuUNgB3Wn6zOpCddbI8Ser7YL9ye5QUdoi5IoVwADBEh/3OmyQU1IONuc4nD5HN/O2zVlUwNWDONHQTk3V52ndWPZ2/2xhVgrVohKvB+87FPeT8PxlELk4KMzX1VdNeS1FI/qihzEvdEcqHrCy7V3z2TVUm4/SU1KZtLIqyoBSp9SFpKgzTDLJukurfJW9Pcj4ywm1APTEj3jhYs/apVLXoVHjD926EX9DY9CcFc/STGbOUaV6xs8hNKKWeIqRDXhTExVy86k5k2GjWx+yV9cQtw3p7vJLuLLSZ0EOF6xY5XdfgYTT9O5WIeDHI132qQK5nER/cClpO0Gj4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 23:30:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 23:30:05 +0000
Date:   Tue, 22 Sep 2020 20:30:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH for-rc] RDMA/mlx4: Fix return value when QP type isn't
 supported
Message-ID: <20200922233003.GA809877@nvidia.com>
References: <20200922134429.130255-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200922134429.130255-1-kamalheib1@gmail.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0025.namprd15.prod.outlook.com (2603:10b6:208:1b4::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 23:30:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKrjX-003Oiz-U1; Tue, 22 Sep 2020 20:30:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f14d55b1-587a-4d35-6d4a-08d85f4f6f61
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4617ADD9DBDBA7544C9115A7C23B0@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9QixyG4PnRzQjVYPEEpqEQf1h0G+Qlchfpu7/zigOgGZFxfwhAnAUdri3bUxluZcp+NKoKp6ar8d9a1rU/6YnAAwzM8jhsFHqGlNthx6/r+7oDOVNcekBEpOo6J0pLHZRMkpjoR9RAHnWwm3W33Qxwffhj7nnCF3KZT9QoggTOnCs/epspluuFCWQuBCJ2uca4vWPimj6AA6GVIRdOV775fa7d8E+UszpBZVgASKqsCq+ntWrunSllpEOT6wZbONcHdtElaw46ut2yMArnW+oLwUV2STFr8+HX8A1uTbciOLBDPby9idHwnU2ciVLhERU1gUdte4hV/4RnZHj46j+32rLAZ9QIxurqam0bAsrvJY2hVMjtIHznkJlbwI4WHgDRbLqHWA8RSBV7KMV0fwO2ZNQyV0DCBVPld/s2H3Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(5660300002)(2906002)(426003)(36756003)(4744005)(478600001)(1076003)(54906003)(33656002)(6916009)(83380400001)(186003)(66556008)(66476007)(26005)(66946007)(107886003)(9786002)(4326008)(9746002)(8936002)(8676002)(2616005)(86362001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0eiGzOtXPgxzIxdmI8jPVpm+gJ5ForfxCsaD0UgBU52LhFpgjhQwRQS0JgfmxaZ9BOeQHGiM8SpkD6uUkiw0Ob5tcCa5sZlOuIFQN5Vne6CTuPQ1Kb87taogvYjdU8I2DmLhpW8zTEFWzi+l6o4IBroZFmYPWnjXJ0I8x4yvBEigz4v0BPIeR8vSjMhZvkxuz+6aSs+8505z2x/joh5YHFF+vrdggyLapviaX+7UCHPJHKtkRsNe1xzyyJDBXBlTC09EKYWY6G8kL0HjASXbWtUKZsBDkf2Y4QlOnNxpgO+QQYtw464HPdTzUBXWhpVj+YhcCMK05ed7iX4fgOITcG6sRKtGHKGFiZflHbCk9dHCxtn/EDTLXpf6iDdb6ujcipIxzsAc60xSGM6fS0vSfbvoxJE7Qn9wRoYYSwqL1Osme0pc9k2HKn3xaUKZBmlQoYiVzKbgMwlLK+YS1d2FWMdRMsJYnKzA5QSE7oooDT9IU+pd81UWNvSLXQfglVIU7vN4pPO+ygnuv/Prn1kqv1YWS8KdPlVK+Ff+wtrFhiij8Yb8FzFmTClkKQH7n1R4MJdmMGnaXtvoPtHuSpwjVQWL3JEz2UtPfYmwyNCq92J7vgHekdVTd+Vife+MDHscRI+vnRPcbs1OvCEKB/K5oA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f14d55b1-587a-4d35-6d4a-08d85f4f6f61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 23:30:05.0725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXwyPLMenvL70pqHbIVn7IBXGcq1tdgkQIzWMHlrfvj4WAo4LaueEJDxJA3uAkM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600817394; bh=lL7l6Hs7VsZNw3swntGVy/Q3zViq36CpsYgVYVM1rag=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=iiJgUGel6Uc3aUmOqMd8N78Q6lPPE6Q6unlU5BBdnaca9t+ROA+zVml/A/OTG3Nca
         A7xqpJTXNPWEjSoXgk2tyov9hlbInBdpoGE4RZy2H4IDtO6zt40cim8efBmOd5j33U
         QpYvUUemXOm6AeKXWO0QGctSlC2vRwnArEQqi0LCu5h3K1rzzpkuiBnKtL6WfKdV4z
         dytem0ZwmGZixxOY5RgTdRXqJZdmdwEob30P12GIOlsYnGb/UIbQq78eAYJytxjvH7
         FZ7sNCpyGv3vXyUXcZUK+DRRnhW/wflm2ez4E+D5Y7STWe0VcE7VEkyo0eTLjturAu
         IWx2GMg199AIw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 04:44:29PM +0300, Kamal Heib wrote:
> The proper return code is "-EOPNOTSUPP" when trying to modify a raw
> packet QP over an IB port.
> 
> Fixes: 3987a2d3193c ("IB/mlx4: Add raw packet QP support")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Is it? Why? EOPNOTSUPP should be used by the uverbs layer to indicate
that the operation is not implemented in the driver

Calling modify_qp against a RAW_QP when it is not supported by spec is
EINVAL?

Jason
