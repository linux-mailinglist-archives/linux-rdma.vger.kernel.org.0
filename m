Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2A422FE8
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Oct 2021 20:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbhJESZ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 14:25:29 -0400
Received: from mail-dm3nam07on2062.outbound.protection.outlook.com ([40.107.95.62]:56288
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229796AbhJESZ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Oct 2021 14:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5oJUHjlF8qy+f0cAjJ5J3FvTMA7qGJhQYxOA27yXRRhJr5EKGKQgFXuUUvGSlRdprzRfaBVxMZI14aQQrj1BFBAVTVj/xpDlxFe6dUlUPVHrNEyYbI3XgUFFGyc0IBZEqpSzQZbngI06FtQvdhYq9ZE1r/QvwwmbTkMSS9PTEIV38T6Cf7vJxSYYi8LSqhrBxve5t/2IxTW5bUtl+gqD7vap0Ns5V4oocmXyx/Pw46g6WDmIHD4RRlcdwQfUbjl1XGOWeU+otApVKKJlRPuk/Y5NIsk0eD+GYi6sXVJ1K86swPo4/TiD0ZWbimufhHCfWjcgntL2xf25NI/xkMYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkhZDIlNRX4jr0/BvV9loFgB5uWuTLU1gxSadBiRTQs=;
 b=Yx7kOocTlrculz/iYOJ7cDEZESVW4F8iW7RhpT+pc0FB/+994UkY+cjI8hqS+FpysQATpYd9fg6BW/jmPh+ACZYOHcP8nZ034ARnNmUCXPRF+HF/enTWQ4WnhnlYovTIxBw7CLLfODT6iqPgOUEspk1YXXIRCQTNJYQCSlmXLT4tIE8jOyF+OX8I1omX+I+Qb9QjypIB8KSkUaMJai6tJErGm4T65J+sAIRHesozO4dpigeS+1i4gWTm+vw8b7RHrAGfEFatcyOovF1y3z4csVpmKFVH/Fl03Uzk/8EHbP5L0hptFgfrfZhhNZrZmdWUttiZ5bE6xCpnt7tU1Wql7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkhZDIlNRX4jr0/BvV9loFgB5uWuTLU1gxSadBiRTQs=;
 b=RuMDxVT/baeWadF/NBIOJoU37ec7cz0WvZqphOYjGXT4Wc3ez/Y5QWYIB/tERJEqY+K29d5QHZMaoamSmjuZLGFFaOUQ9VMXOMvvip+pLFayRjcDafQHBklAMaphPAvad+QjukKQONmIYi6IK5HL2qCdO5mrGK8JeJJEH7bNRy5MEOqrei3GiJlGox1A0VLLZ635TTQIrA/inaiSQ7Imv7Fh3RMG9I2jrpi3o95LbpIWf2DmDm8Xjk3SoDhvC+MqmrEXcKwZeBDbXceeHMQlZ7gflA/hEvVMzglsKHk5x3EkQeXKO7U7xdi0v8L9FcbVHoKD63YeVaXRQqq93bomug==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 18:23:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 18:23:34 +0000
Date:   Tue, 5 Oct 2021 15:23:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH v2 1/1] infiniband: hf1: Use string_upper() instead of
 open coded variant
Message-ID: <20211005182332.GA2681844@nvidia.com>
References: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001123153.67379-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0219.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend Transport; Tue, 5 Oct 2021 18:23:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXp6C-00BFgI-Uw; Tue, 05 Oct 2021 15:23:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0462ea3e-e151-446b-e4f8-08d9882d3e15
X-MS-TrafficTypeDiagnostic: BL1PR12MB5093:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5093EDE1F06300F65FFB0C8BC2AF9@BL1PR12MB5093.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WI9zYWPynq9rdSbWHv3gC6R3ZLEF0+ocJzjrXUomFmvQp3gEXd76lpeiNdNsk6pG2s6fTPWZenWxy7JcMEl31XGNZ1ZxlU214RLIdNRWXCFpNO4HzPONAHgbBuY+z49JeFGTrQKxCmgSsV7NW/Q5Rif/lQSRZHwtV9g5HI4EIMOaQxxlUE+3ls9LzyBK/nv/j/CaAo7fI4uKZOYd6J2vuMUnNCH4RnHj+W18h7d2B8keHJiPRdwHyNCXWK0gskIyefWyr/nVSvqXonPKKXIqBou+ptyy6uq/oOX7yMqvyruWRv17LUokHDoeyeq1UJLu+kWnkTYaE2k0c+S3GHeXBtPKEL6zsTsH1PKmMaxHVhE0p68G9+lmVItRu2nfVW0FWN5EyvvoDc5mkvOkutM/6LKGeM84OeeyeDO0431WVl9EDSujohkjeqaEpCqcgF63Iwrs8H1MWL7Imun5nymiQuyT/+Gs2yMxDi/C4iGSgoIHVqeLubiGOiM9hk0Aktap1VycXF26y/ueqPRlevmCkwwhNTEHGVI3Adt22Oi3hI1ycM71f4yFJF+toKyIYplfe0An+NqeJFmqwaRU/LsMDpP85ZoktrC/gf0aOl1klNc7Fvsch5BMtvH3DkHDl4lYRfJAc2X1BnCU5H+fPVnlMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(426003)(33656002)(316002)(8676002)(4744005)(86362001)(36756003)(83380400001)(508600001)(26005)(54906003)(1076003)(66476007)(38100700002)(2906002)(8936002)(66946007)(5660300002)(66556008)(4326008)(6916009)(186003)(2616005)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ftWNmQGFE+zhCrtVFTi9WcQ8IRT8XlfCDYosv79KXWRvxTheGCDaTfePKJwp?=
 =?us-ascii?Q?fI3k58RoB6t3Tc7n9YqnVuHSYElZqmmpf/iL+bZYxr/oLXcvVq1KwLq4tLh/?=
 =?us-ascii?Q?8z70usrwdjcCpYR8XF2ZK8pzRsK/N/PKuI5VCNVNnXrWHf+4VXGEZjcXWuOu?=
 =?us-ascii?Q?C9EOvuoHHokt9WLBb+atwJoQ5FNA3Q+Z3AGch/kpDWPPGD0y1woScRf0x8De?=
 =?us-ascii?Q?QjrDwRKgQpTu6hneOhBvlrYP5RvvxaGQEztgSs6+2DcayibAES8SBmW0U9zu?=
 =?us-ascii?Q?mfZa4mc9aFQAXtFOm8iArxseXSN8MBvJZPvE5Mmo5NTMpBpxTSyChpFn+23o?=
 =?us-ascii?Q?F/EMX5qItUIxLQW7UDE/Sf/KCDNy26CrN/k8zW733nmTm1CuGF0agNPxGi+q?=
 =?us-ascii?Q?Thn/cE2+1kRjUaO3mPN10I+l1CpMDRCOWDBXtN183xRk+L0sPaPeBT9vc3DW?=
 =?us-ascii?Q?+e5q9s+Jhy24s5z06ZfmqsfLCQQKhUsIuMcVrdjkPlAcGU2jOZR4TSlmFp0Z?=
 =?us-ascii?Q?QXEpobxJVcDfBtGCJ6PaXdW4EtltI4VofPZzl/0eopbuOlN9+kTujJLYPs7K?=
 =?us-ascii?Q?9huN2EJNRCnEVWcmuCNY1HwZhpxmar95bAEaLSrVswDcGsjBZv2kLuMdr0Vc?=
 =?us-ascii?Q?MQ1DaPrzM8kcNhdBqox3r/+ZiU1hvgtkExMFOk+K2NThmd1qiKlgis/nz0hX?=
 =?us-ascii?Q?5lLBpondvhWw/XPPiRmgtn9TBM/jXn2YZvwcV34bXExfWEtKmKWi5T3d30V1?=
 =?us-ascii?Q?tm+wpk/O1HuMibrvRpnrW8knjIl7nradkrenZtP5UyJ5e6NBq+Zd4uxGRfqx?=
 =?us-ascii?Q?wV2hDCbdI7oLh+t4kK9qXHvlnH2nc7ZC0DFfyedxle4hnFNY9BaQJrdqsL+V?=
 =?us-ascii?Q?479LnMRvySOpyTT18cDV55pzeYSfXijPvq3LOLnlYqLcIpzYcdSp4NLvuTRx?=
 =?us-ascii?Q?57NHkrK9MOHWf+tiAQXwq/cy/3w5rRfSDOPH7cf7mHszcFFK159XiPtC505B?=
 =?us-ascii?Q?/l3g1hZzJm3npIGbh72h9Wbm9ZU/6pOIlF60xyfjYojJLzOUkbr+LHQIRkEQ?=
 =?us-ascii?Q?of0bjKlJoCu2KM3op0OXLAKCz8CcyTUJlxfZh8t9FRSrAcsVXBHXqGoKpGjx?=
 =?us-ascii?Q?zutvRJpNAMd8I4vIGp2lQ7/wc1/UIPg7HJu55pSttVVmfBz0NPmEci6ZBOBl?=
 =?us-ascii?Q?eDmwQwsU0wYyENIVf0yejcWlQGkmiBVCc+uQuh+Z70y+Cs2mN1Qirs4sNfpu?=
 =?us-ascii?Q?WFkqoqtkqgUFame+fILGa+T0WQt7BDbRKGiSPgvNHwgMRM78b8AtV+cgTc8n?=
 =?us-ascii?Q?WiCSEPDfiRw9hhoFdruCQGjQoFYFVXf4+maUaDQrKIrWTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0462ea3e-e151-446b-e4f8-08d9882d3e15
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 18:23:34.7796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuVqeEBZ9pT5hNtuny/GhcERp/05v37O3cfoWuVP3mzVfgR7mHUg4QrErR4Kmu7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 01, 2021 at 03:31:53PM +0300, Andy Shevchenko wrote:
> Use string_upper() from string helper module instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed compilation error (Jason)
>  drivers/infiniband/hw/hfi1/efivar.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
