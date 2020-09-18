Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8C26FF93
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgIROJq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:09:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1957 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIROJq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 10:09:46 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64bf4f0000>; Fri, 18 Sep 2020 07:08:15 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 14:09:40 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 14:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCh3/K4jg0YlqKMXwWmbsGcfa8WRHiKawCE+qtey8fdvudkUNzo4NlLkDuxaa7Y904GMTjbWFJDGGBDU/C2teHiYOB/3J8S/BlPyKzqP6qa9f8Ki/KlpTVTF3sptOB0VO5bAzd2JQuZfCNHmr6Vxmex3WkNJ4qT+UDZopq8aaXcVvUnhTXFWSAm3SWRPkdN60y7a4PYYOhKgTY56syhaOqlhjg/lMXVPdiiWSsad8Nd+TITxNCotMfi/dAxBdVzKH7AhP4BTlpx+XbNxFUeZaUhIUZRiu4JfHhAFduMNkW30IAoa/97PuTpGifKCxMclZCxssFO+5geaIs+l23tGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yztInR1Uljp5Urs7UMMfAJu6BqUk0F3iLdu+yxc2CJc=;
 b=SKMgCSl4CWal2fhE0xlI5TErnVwDymU5ZpAKHbPWVs9Gg2pY5sO9D5q0/D2N3hl4I7q8y4+CMtLvbMJV0S2hjiq9R8xT5OUV/kFJB9QT7+aIBik/SgPbtwzrLr5NVzj1eMK5+Cs0z8gqCX+0Fy7M8BFd33dgPkyyaBeX2C5/CnmSfoplyQph+A09+hGPVuplJlWVRsKrJ/K01kiaBCwhxCD19txxOnFB8CEoycVOCdVqcgHP/gApAc+ZnBbhHukFUzWSyWfi1svYhtBNeL8gFjCIWfPvXmtpyueivi3i9DO5SqcnP+5WGIL1KboSTmW6HwoOd5wX7B0Dd5BHz5KnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 14:09:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 14:09:39 +0000
Date:   Fri, 18 Sep 2020 11:09:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 4/9] RDMA/hns: Correct typo of
 hns_roce_create_cq()
Message-ID: <20200918140937.GA305257@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-5-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-5-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:c0::46) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:c0::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.8 via Frontend Transport; Fri, 18 Sep 2020 14:09:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJH4z-001HRx-HD; Fri, 18 Sep 2020 11:09:37 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71fb9a5c-8acc-42a6-2ef1-08d85bdc7afb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3739:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3739192B3FC0FC040A3E89D4C23F0@DM6PR12MB3739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6zgAChAviW8xKmVVKs79rEQeOJccxqJk39nbg7Hwq9SAd5mj8DVkUfxqf6hThKNti88IlONhqAqzfnFCtYvsU9kyEc+UupRDt3Iix9yUPhM4DIP8jA4Wa//8bPeEFETxdrsp5Vp7zIO6tZQqwSaof6r2Jet9ssyqHJBysNAiTHJ/6gQ2TIPUFfeFqxsBOxINbKW2om9IuznKrYCXRajdru4FMdf3vT+NKyJ9qSawIBCNjsavqgsnF7QbG/5GWGXI4ByQ+0CIkj/VEKCenpTT4Fad3sPcexrRtVUv4qX3dcfkusQnhZfoio6F6Ut+6Jnt9+c/WMzGgp7bmhHcGR+3ji5bpIrSorACH/SXWHNZAh658W6eESIeRIO49Vf40eN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(4744005)(33656002)(186003)(83380400001)(1076003)(8676002)(2906002)(66946007)(8936002)(5660300002)(9786002)(66556008)(9746002)(66476007)(6916009)(478600001)(2616005)(86362001)(4326008)(26005)(316002)(36756003)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4BN+pbecp7NnQ7sxOVCa2tD608Msfa3hJJjsvTB1IgceEJgnAXxcTY/8pxM+8PWyK4QkY/jKntKABMpUSDITGlLbnDxZV3vNJTKu+4eKWTuq7X/d/ANBsIvhcSxd9YcIfEYNfJlZq6dbrUimY66vwA04/agGjeF8tO48+XatzuzbJtDXtDadkbQoGCfj4BAa1Wl1AWOe3YIvilr14JHuP6Fa8tpeZ3BJ8uT3P+3Y4hMEwmU0aUTGDoNSQnHziHK1E1nacB9JwAbYnH55lnRwzqlHvENbg0ztqtufkAOittGVMGQqqmRSgymXvqVR/jKmCVdWD2cCENaPy+ocgtjLYjMqQ+Cc/XHg3dJWMNCg9n9qCpxxC2E1FRV75lAwRnO1NKMRftmb7RrDzGG1QFs0b5F/rW/vTjSG+n4TfITrkq8RSvlptMg4Q/XBxTU+BIUjXDcOMIeEJ2Qc2Savh17q/CYoN2vss6CGAW1fKeXBao1G5CkGQgR0RzbpqxvipQ1VsinfOGM+rIr12K0Ii8W8MpLTCJ/wLmfA6yAsRSY4kjWE5nJWkBlpgfiyk070fGXvoGgbJjfzP82mDp9Y0B+PFh0+Fhhn6ua6r4G1k4CLr6d93DM0W9/tyX3U7Uw0VdEc2FyRvql9scjEwlMiD/kjZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb9a5c-8acc-42a6-2ef1-08d85bdc7afb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 14:09:39.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPWxVbJWQLXdYHqzMAP6LKkSoh6SdDK2yxeuxaKVAeWC/TObf/yjtKIZUwXWgBo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600438095; bh=yztInR1Uljp5Urs7UMMfAJu6BqUk0F3iLdu+yxc2CJc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=SeAJFvIjmN7cyCi6xwgH1A1Bil+Yn5Hv2g4c4NYYuDjuUgc0k8Kj21MSS5NfCAHvC
         4uGiCgu8g0gS2ymPJXOWmU6I3XPypeYdcTnQdoRQb4PUELxpCPZl6KpPtTpFXceoJ7
         eqk+gC/VOJqig4fpAUfWiD1lyxarTsF+zMWPWcINCNWA4X3X6SeychE4J+uSW6vOlD
         ILm4XG8nMQ12QRwZpFYMAKV43Qc48LAMKbgLNDoxk6ny4DcEgWZW9DI8MjBI46YktR
         ilZlC36rZEldomhqJyP12hX7JzqdRehndkeqCJ6L1qAd42OxFzYgcXXqiXWovcCfiq
         hzZ7FaJGMNKiw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:29PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Change "initialze" to "initialize".
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Missing fixes line

Jason
