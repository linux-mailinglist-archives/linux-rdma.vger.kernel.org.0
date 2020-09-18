Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8426FF13
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRNrZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 09:47:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41516 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRNrZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 09:47:25 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f64ba6a0000>; Fri, 18 Sep 2020 21:47:22 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 13:47:20 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 13:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAXTphGdqy8u1ANQNeIA9Qj7C3HvadmbyZuaCumQRb5bfnW0nnKC85/bfmiOBrVsTnHD3qFywzBoXfZ05O1xXxovr4dnPUbG3m8vwwjDR03InfsDQ/rkR6jkNXY5pvOeEMZNfNsuwnyOQcJUAYgbzfLkrjlS2EVALuO6wLy9LJj6g0iYSrR65gE/surAA6PYRsn0PKcsrtS4FM51X0IyWiyHnll2HDVpfUsiCtoCmYS0ConvsRMsFzeoZuuAEpZldsOxDpZ1mfH5RYXxXKggcRF7ThkYa5ScL1z4BseeNtQTP+72MncQp8EP1ufvI1auCJVqK8Ns/1bbIpvXaLTMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84FBCZ6OB/dORUJj33b1skh4f8zKJexyMXaaeyVNUrE=;
 b=N4Pv00Hcp+UvEZToWSJsyWbUPN0LdiIkj4JMYQ/+VcDZC7A34OCHqLtYqHRWkyXA4LQAinX0wBxT3l0lLhEgKkhVo7gsndsKsOkVRb23lblz1TuiXoH4Ah5L6jr288NyAOT5RgI2dgbQaQZPXbpXfvYWIj/U1SpbVfn5iF6rVfPmNcIrl+gC3HVwyfbEuG0SPcRg3BDcZORKaExViRH3hJ8Macr/em1+0wyvkh+70ch/46ygFZIC/KkeSFW/VOUXkteibWV97ox5HuwR7xfD4ttdx83cX2qoSKUaPF2Q6/qF6hbWhalGcAIWN5GncScYPVbGyDlbJyL5SyWt/ugAAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 13:47:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 13:47:17 +0000
Date:   Fri, 18 Sep 2020 10:47:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 1/9] RDMA/hns: Refactor process about opcode
 in post_send()
Message-ID: <20200918134715.GA304004@nvidia.com>
References: <1599641854-23160-1-git-send-email-liweihang@huawei.com>
 <1599641854-23160-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1599641854-23160-2-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17 via Frontend Transport; Fri, 18 Sep 2020 13:47:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJGjL-001H6e-Ip; Fri, 18 Sep 2020 10:47:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee72673-7789-4c89-7f57-08d85bd95b12
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487DE9780E67C15528DE444C23F0@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqrTSBgFNrw85lfm/G1ZMBdc07jt2J9Oyx++/R6hx768oWb2V+Kb5PqdzvIuN+GHk0rTSgZQXdQZCyFAwZbxBBiRJAd8sl/y/6251W4sXkJVed4djrMTC42tX6Sy6O3ugOsCWmVY5kSRRD7ZxZJgNbYcjmR5D2Ji96IU5FmfLal8RhE0BCQ3E0cz9T3FfoTASK+8XfIPnYboikDJlWyAZ8L/1QI9tCSL3ffhf8uR3I2uMkfOxQIkhVFKfw155XJzZU89tfpQR2b+N2imPp69G8plLyBN8UVj3kc4A+VBu8RvxcszxMrkkwxBhGdrScm6/aO6OiKP6gEWD9W/2HKYrcfcVvILIvNMWkm8X6FqwKF62GJ2fxlrgRjkOW07EFQe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(66946007)(426003)(26005)(9746002)(2906002)(186003)(9786002)(33656002)(8936002)(6916009)(2616005)(4744005)(5660300002)(478600001)(66556008)(36756003)(86362001)(66476007)(4326008)(1076003)(316002)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Le9fvaxXaS+I27O9RWMBqlSSvezf7SJJm2RGUg+blfmi3QSsCE+StoNKFbPCAAud3Rv46OenQjjX2EjsixvlHE3zHZkqSlvpj4N+BpX9r1d5sBjxQA9GxEx60OlegXZuGu6TirvKmpuVxAVv/o9Dc9O0aqRCI+J0fB13wvNz7uF4PGjpolpIZxoq70ZA0HyrTszAQ5RSQ5A2sEFGIY+UjNNzEAsAjoFMMKUUGciOgy5Y07nsET7Zr8l64GG/CxPHelWxFL50QMQKUNIaH3x5Nmv2UZCwnBbwVbCqmwo2wKX7YwOTTPgNA1r7NW3NDbgZbdcq+RIgnP8S+FPBWyttS60AhqBpzCKbPhw/i5mPADxkjTMaR47CCV7ll0KjOwnTCBc5bL9Pea5WMQe6/NSzMyJmpld4PbWbTkkYAQIF8cv17cuIgQYj17acfsOwMyCGs1NA8mqaYoaptggPlZheTdT5pQK3WU1InV2uJZ8RoMn3vl/0FwN80eqOE05wvbLscO/4By2Cm2FVc7qJoimQqshSzPhWPNt4VtqZgK9R4rfa1wjEUTg5wACyKUDbY13OxmWF0MRtrHg57t8ivAtxE76sqh+z1X9FwRQYWC+nR8LGi1kfHQB6/PAwODQZA6R5HGsfDWtnjMtVl2oBhr1aGg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee72673-7789-4c89-7f57-08d85bd95b12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 13:47:17.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWISbEtLz3xghFBMMmaYOQcV+81/Kis5sEtYjqHar6tzN8A8HGPCX2g7Vkw8zbT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600436842; bh=84FBCZ6OB/dORUJj33b1skh4f8zKJexyMXaaeyVNUrE=;
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
        b=qmEcZBOAau9osUurtphy6m1a3AJ94MtCtp/Sy+7mFHZXRpnTb2rOcnTlRMYR8SivH
         3liybtlt47GWTHL/9isQGJNJWyZg388uTw4B/M//OElGaswceRMbJm9e5sTGNhYn+A
         C2sw0XlGalLFt4uqpNXNEXr1F5aNmm5yNStMFIhW8nj92D19oOe1z9KM3lhspQXibR
         AZv53kaV6BpR5ck2WpnMqCC/qZuw8AbN/oJFtBdbYcRwQUjHYjh0nXu0b1WfhIvi4u
         mewsbOmsUqfdsUZK+n+GZqeUmaoPSe5XXogquKBSNa4IlPeAFYoaOCa7Zxu0z1rWyG
         gKsp5H11aU08w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 09, 2020 at 04:57:26PM +0800, Weihang Li wrote:
>  
> +	ret = set_ud_opcode(ud_sq_wqe, wr);
> +	if (unlikely(ret)) {
> +		ibdev_err(ibdev, "unsupported opcode, opcode = %d.\n",
> +			  wr->opcode);

No random prints like this. If this is kernel only and something
in-kernel is busted then it is just

  if (WARN_ON(ret))

Same for every place in this patch

Jason
