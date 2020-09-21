Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66642726E3
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Sep 2020 16:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIUOXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Sep 2020 10:23:48 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10420 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgIUOXs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Sep 2020 10:23:48 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f68b7710000>; Mon, 21 Sep 2020 22:23:45 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 14:23:44 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 21 Sep 2020 14:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGxBvUfyL2BtiTuYCvo9j3vdwfLOCql1luB3XkwIDKksoevSp3XFyjgFXrIkekp6/IFOWqd4K8s3lHsDp8CWYXmdUSPCa8+WRvDAItgjoowjGgreF5iv7npRu9nDzvnqnVCLZRTPGACsMmfgG251q5Xqo+spkHqV+d/L98bKR3qAOEfMVSs6rD/uz6AH9VJEBT4WL6BduH7dwX9nzXwulzJZYuk+0tkNa5Ig+e4MmdYNFQQXI+EudV38a2rWOrxEuX5zuLjjGB33uKfwUt9X3VcUF4l33ZlhI5ecHFYCyTMGKfA7IUYOh/BtR+8m7iPnH93XeaYvfbUy7erqKimeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2txccHP3MuQ8CZDopk/xtaPUYSAepNpR0TAE8mkgIM=;
 b=aoYWPUZOTfS83eUW3Y5a01/+BZq3nwW+B/4OdhRKziU+p79QU7mOHbWtVIwly/WfV9r3MAAEiPIbCc8oI8kxvVfGkfsev88JNfSARtDqjku8WhF3kisEKpQbELpiXvaeuIelGGuOUSEW1vLVc2jVIC7iuPgcinqZzmer5/W/nZyR5sx0ht9sLMvw+A4PWV2mdeEf4WQ6ydfrWkwWF67YXLafNLO7sv0nhyNeTUZncsg1HbvQJco8Dv8uFmPs6sE4TxZSZd30G3EIaPiwGrYIRI1DoM2HIlS0ULBLCH0RNY7Emu/YwZRI7NYI3lQq9ClwxXaL5oMqFf0hgh8J4EdlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 14:23:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Mon, 21 Sep 2020
 14:23:41 +0000
Date:   Mon, 21 Sep 2020 11:23:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH rdma-next v1 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
Message-ID: <20200921142339.GT3699@nvidia.com>
References: <20200917112152.1075974-1-leon@kernel.org>
 <20200917112152.1075974-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917112152.1075974-2-leon@kernel.org>
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0023.namprd07.prod.outlook.com (2603:10b6:208:1a0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26 via Frontend Transport; Mon, 21 Sep 2020 14:23:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKMjD-002dZH-Nb; Mon, 21 Sep 2020 11:23:39 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ec24a0-06ed-46b5-c76c-08d85e39f045
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24382F57B7D123454D2351EBC23A0@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgwiAhcj+guxM4HfVK4czj3Yr3MP6hy/kMr3Bjt6kjMS11TtbNZIsHAuoS1jkZopBguX0BYIvhp/RdsKMuHaqL4AS8utG6lTHX3EbMZX23StwjmrMfGYvZdCsItyoGnlWwBTNlSICHwC95tH5TC6w8NCSXdv6rjoxif++2fztPJC/OAtcgw8yPOhvInPLEolKPQOmu2j2oSgQgmWyPKjVdnUvtz/ruseby6crO0ZtMOc8pUEflYe1pkBrNHHPFHOZ+U5VJEJj0F9VgeXm4+iaSSwYlI2juPzLjpgvCKiUndFzLkhplJOJS9uwvoKbNt6I1BEbni3lqzjFoZcrThriA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(26005)(36756003)(6916009)(54906003)(2906002)(5660300002)(86362001)(33656002)(558084003)(8676002)(1076003)(478600001)(66946007)(9786002)(316002)(66556008)(66476007)(8936002)(9746002)(186003)(2616005)(4326008)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r1Pw6G5VZME7HKE3Hzf0yMkG3ygHrqAFrLQDx5QUR+9yx+yLVS/MUmnVRyh4qq5v9lmJn3NihIbiT/IH+zd+HL838w6kjladXK9LgPXs5EkxajB7jjo4L8ODc99oOu1SBjsBQLB+/qH4d9zZbWKWnZrZoFyjX3nreFEqCZKtsRX8+Y9ro5jaXIiXZ421wnzl1RrIqDdx6+VlzxFTrmhDZtC8nb7m4U4RRJ8ODGv8EWij/EZwwn8ms0j8Ztw2zGCMVMg9vafUM7hOdQ9zroIa7y9HK3Obf0rjYAXQ9z1dpDVJ6fpSowhYWkG4FOFX9Rh11r7pGc79oLseR0IAMYJuIn7hoeST+IGFx+7HZrw9KukbiW0Mr8qdtUIEpV7GDCAcrfeag/SMkJoP7fjOHTTNX26zE6UKgMfbKHeI3HVTP2wE+H40XOE6/+Ypk/A2wqftF/AlntQ2q/0aeIN9D5em0JIq5ia617sDAUy1N0XJRVRpvjvPeHtbw0q3OOszFo6v6srSQtuaT/lX7z4TXgWy0u7JE/YyLXcBwFXzogAb4gGaAAW4Oe5TCnzLKfLPpnL0AiOZCDjO9jOkVq186lsGRcfGzFmzxzvFv4o3wOL8FOhfXVXwpGybsq/hWIASyOlEx5A/X5b/T183EN3AiBQ/fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ec24a0-06ed-46b5-c76c-08d85e39f045
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:23:41.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+irh/fAjwOc/hfmyRXHtfKqxIo90DsVbFd/z8Rc/O3cM4oR+JUCBqeSQnscvMhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600698225; bh=u2txccHP3MuQ8CZDopk/xtaPUYSAepNpR0TAE8mkgIM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=P4Nu0rIeNDbatZLL9i1dKXnH0vMbdPaaMlWjV3OMXzqW48944Wh0Aa+nZvxWVdlg8
         6Bt8LkFezsm6PgMx9LfRdof2dm3t2I5Tssutba+D1i1kNJ1FqlTSfrlQWWCVS0vqFG
         G01SNn3QXUIWRlemRADo/TiEKMHqhak4mFPPKKd5TsJoJzjbD0WqpqvnqNTQaqjG/0
         PwXhET1h99/0U7GClLt51qV9UuF/IwipUttVDo8t1dUUkj0Qixqu+SeS1PKzkTa8yN
         A24majUTUJRildIk9bYRBLN+lJMJZoztfG8/AvfXvsXfJFsrH0zbwlTe1fisVHW15H
         bboDGmMwcbhNA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 17, 2020 at 02:21:49PM +0300, Leon Romanovsky wrote:

> -out:
> -	put_page(page);
> -	return ret;
> +	*dma_addr &= ODP_DMA_ADDR_MASK;

I thought we agreed to get rid of this because it must be zero?

Jason
