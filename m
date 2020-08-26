Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37889252CA2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Aug 2020 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgHZLlr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 07:41:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10293 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgHZLlJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 07:41:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f464a450001>; Wed, 26 Aug 2020 04:40:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Aug 2020 04:41:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Aug 2020 04:41:07 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Aug
 2020 11:40:48 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 26 Aug 2020 11:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMOQ2ALOJ1GcJrAZfycVqGxM60s5l5i04kGzeCVHdg1lwEJuEt2PiWdOX8G0QOjT337Rbv3jbBo76T34wEG99tJKzlHdxGY9sA/mXcUAxeDE9bYstuDGJPVlkeNMfu/HO66Ukx7EryziaPRqPJAwZwGJulH1oxZVsTZagJ0j1Lyf9HBnx1veJ+446QVIwXNH4/cvD8EbCE3frsT2byAuY3O14rVOPgzH30FmWJAaOc3uM4POjPW8HshB5Ptw35jfv2DBh0EEfzs14ucxy3vK5GLcy1xeLiZYKYTTY4aQL2M1dGOg1iGBlW1JXLDIg9Hu9TlDPssYnCqf1EkjY2FwOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orA7a1LHwp4or0I9j6u67EREwA2paCW/vUmEjLhAu8w=;
 b=Mr04UUpxQQIuFigRTZKxTk//jhho7GGMwxGMTSqbReyi6HDnQjLcPlHMo11DPrCy+CpTo+S/adCBk+ookbczQt9+v+b0i1xn/lObslee77tG3k6WKgitXF+AIlS0NtEmc+l4Uqp/aR8j8g4Zdg6aCUFG+BaU2+MKofJVVAojr3mZnK7Xdlo0j3oNym5Q3IJpPRdsCwLCCUyEctX/hoQ0vcHsNe3ub+SH5KzHQkkggu0Nx9LNYXFSIFUE0k+utVk+moZFnnz1ZI26gxWVs+xAKPq0VWRi5Kcfppsak37//u3ZqPoP353TzoeurOnrY3rnV0hvXFIJMUDmuNYce35/8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Wed, 26 Aug 2020 11:40:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 11:40:46 +0000
Date:   Wed, 26 Aug 2020 08:40:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "Lijun Ou" <oulijun@huawei.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200826114043.GY1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
 <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A70106634FB5@fmsmsx124.amr.corp.intel.com>
X-ClientProxiedBy: YQXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YQXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 11:40:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAtnH-00FevC-A2; Wed, 26 Aug 2020 08:40:43 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab0b008-35fe-4094-1332-08d849b4dee0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB165772E797C71B016B997FB8C2540@DM5PR12MB1657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxOXNxqYV9WJ9m6Eudbxp8++jBAQmtM8hhlu0MMs2HE7LWChVH/O9SyW4phyT8LVkB2cr6kKr/OpL1WFl8ffn3YhYYhPWeFDfZbtekwhW9BUtTiFpL60usWCUpUW7SSHhtWXsAI/8xOG49rqcKxtCMi93U/xxMDeFSTRdb+5GZ3EdP1NesX9nZdpb4FpnmWE6i6q2susFn/eWWNdw/GLyt6vx0eNlI4l/WN7QSh33VAetK/vz5TutlcFNPb125pAtaBHLA3AZ/MX8HqD27Yiwl31M4J1nBu5QSvFaqCd39QOEVRL6O+0ak/svm+EOcOHvjuNPeeYRn3EIQxtPFuvYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4744005)(1076003)(2616005)(426003)(6916009)(186003)(107886003)(316002)(8676002)(66476007)(66946007)(66556008)(4326008)(36756003)(8936002)(83380400001)(478600001)(9746002)(86362001)(5660300002)(9786002)(7416002)(33656002)(26005)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OHA8Qt1igLUuyIrKspdeSkMPeOXU9KtI1pEV0xeTFrYQP3OWSAjRc8BuNNWxF9Ja8fdKkhFv5tg7Tm8MKmFKWujhZFj9HfVbc4S8/gwCzkD8JXoPFrViZuyZtvcHEw6MTVHNTZJD57wv7xDdXfVuNTWvJaHZY4AEy5il+k6HjSjlNBwGIcavH/Ua5w28thDrAbP/RpLP3SL9JBJSH787WcPwl4vwN8LY2qfBYSJ337TBEbbP2xHK/5CS8sOBfDCVBJ5Qk18XGM2srCi+ATKMclBFlEy1od52XEhkhAErQ78js4jZa7KjMuNH9p0l8sfAMcpF3hYueBeXu8uyIxQEUMEcU2gRFEzxJiRqxJF2vfJx/OfoE4op/kE1kAfEsM1WCtuPjBH2gQbZ9+eFYI7vv+4ME0NOytqmMheWE3OxQV1TRdkzGfkGJK8GJlB0E9toy/B/cWPccppdDHpJKTKBGzoIhUW6qaC+uueI6yVtMnqyZGg9OO4mo9GvOsFDALkc1WbIRQY0nd5MbzB9iVMKl2jYq92p2PpgSbovrSt8HMNg8HwGHy5Tpi9VthHtXeWHAFJxAik0Iwg2DqpbiK5KYxQZZIyjumNeBMImIWaB/bx5LzjKEnJ8MNYOmsAgGiEylqxrwRlNMLZigenL5gyDZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab0b008-35fe-4094-1332-08d849b4dee0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 11:40:46.2918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XOlYiy89DXjPox6xoXIC4v0T6RKAmXTgz4pgVvURHNHQKzIrMlPfUHOf/1oEOtbP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1657
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598442053; bh=orA7a1LHwp4or0I9j6u67EREwA2paCW/vUmEjLhAu8w=;
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
        b=Wt8CPw3FH6wcilTuaiI0n20UjCofXpeIpnklHW6SCAEUoLbUHeF691ZRkcmdxVfRL
         X/qzt3nK5ZMlO4ZL/vnuNaaZ2JzkXYlTVgUk/RulcdhI2x8YTDdrh8Xca22yUIYkHN
         SMwB/HqYIVDQMRrs99BbeALH6HKo+RLfjLuTKLjYTJiHCzUKmOkp81svDk8hfdQhsG
         +QKpbSGjI2/h9tpJQhCeyZtSBp9naqz5ZovDZB5Pd/K3DoKYBTPGXS1dafm702BQbr
         U4s+aVPSn32IRKIKB7E4GPfivD/att1XvhGVzR7CifM50cwmHsvOHKJXW/GgKKVynj
         A71BTQLn7xGjQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 26, 2020 at 12:49:03AM +0000, Saleem, Shiraz wrote:

> The API is quite confusing now. If drivers are not expected to fail
> the destroy and there is no way to propagate the device failures,
> then the return type should be a void.

More or less, drivers can only return -EAGAIN with the idea that a
future call during the close process will eventually succeed.

Any permanent failure will trigger WARN_ON and a memory leak

Maybe we should switch the return code to bool or something to be a
little clearer that it is request to retry, not a failure?

Jason
