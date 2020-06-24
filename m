Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F39207C0F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 21:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404473AbgFXTOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 15:14:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17984 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404434AbgFXTOm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Jun 2020 15:14:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef3a5c40001>; Wed, 24 Jun 2020 12:13:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 12:14:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jun 2020 12:14:41 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 19:14:41 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 24 Jun 2020 19:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQmdRdmicHhy5uw+vyH/J8vK0PZdMmeaWrmApCuLbup6nd9HTP6piPjaCCXQsqd5N7M/lUgpmJsU7/HBCGlkuazR9yNJfUgS3AR3sD43io8D0w6r1CWGT9z5PPEJQx695/XTlAw9H+xNP9RTuYG1j18NmmF6+Gl5YoVb5PtvO6y7J//rxDTMAnAZh4sCyroa9LYsI/oTgZmnBVVmj3+20NX0fp4Aa4jIvkwDdUs/BS/qGNTWwc6/pCuP+lO3qtWk1odLvfgeJpsoxE3W1rQi1cZvdaHZJxOiF2mQnjN9TaxRPlwnSVzWCVCed23cvYeMidJ1RCEoGmZdcClc3vefgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttlhL/rW0f51RBIqrFiR89/o45hHNLK1PsT5uJ0ExZ0=;
 b=DBFPr3uXXYAIQ7p75Cd+5Tc2uFfTmiJS7hI0s/H5a6k8Aae3M5hkN+lbfR2mq+cBniHfYLEsshaM51umlzSZ3BPRcyKrtIlTxAUsjkv4kcDVXa+0RM25vT9VQNoOq/GHATKY++H00fy40ykZpAebWauZeMvH16sifNwe/Oi3BkL5SN30MIFLPbgL8cAV47jXsiO5I4Mu4pjLLIISVmD8uiStnAizobL22HtAV5r4ul94cLQ2+Yjfzees9BN3KJC1/tyHXsGXDxhE1paO15z4wXDm4WVsZQDnfMDpfmuHypnztu+Fj2H3XTvfsbBrJTjBKc95GAXsEg2U1njvIEJXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 19:14:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 19:14:40 +0000
Date:   Wed, 24 Jun 2020 16:14:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc 0/2] AIP fixes
Message-ID: <20200624191438.GA3270567@mellanox.com>
References: <20200623204237.108092.33229.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623204237.108092.33229.stgit@awfm-01.aw.intel.com>
X-NVConfidentiality: public
X-ClientProxiedBy: YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Wed, 24 Jun 2020 19:14:39 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1joAr0-00Dipc-8q; Wed, 24 Jun 2020 16:14:38 -0300
X-NVConfidentiality: public
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eac0dc5-bb07-4d48-39b1-08d81872d7be
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42662A98CFEE43592205E181C2950@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux5v3s1x2DVSzF/GB+9DaJvgnGeOwigVGJoLaD5jt5X1e31lk0Pe/dKv6td5FhNvZ9rGreH/FnJXHwdNQQ7pKGZBwRW4EPdckstoUJNhPOdgi7lM2HXvNsN0C6XbU0egHn+saGxzguZOI2eZC6rJ4plPWZRis8AkN9ZHeu5padRsRjWrRT2fpQkqKlAJGE+4PuzsC0QPcuS/jhgEVV4qSB/8I1KAf0Uzyg9uxBlNQyJrGBHkc43o5rPZETqeH5cuVQibRHMPzqhF7t/LiSdnSFOUke+RCihN877VIHX8BJdHAmENzsXKdlRj7vOEIUASAHR2V608bKwWSJudt2y3WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(366004)(346002)(136003)(39860400002)(186003)(4326008)(9786002)(33656002)(6916009)(2906002)(66946007)(86362001)(66556008)(36756003)(426003)(316002)(478600001)(5660300002)(9686003)(66476007)(9746002)(558084003)(1076003)(8936002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hs16aUEA5dxOTHD4wkpzApQYtJDcggUUtewc+tMvEEOkjg7SgO3Yb6Tl6sw1V7mjbHxmCA+unoZYTB/kT2c2nEZSCzYS68KFnH2SKA46j81WDRkM5tIljAY3+6uv+A/310Zk0+QUEic8dIS01ixtFFfkLv+wLR2YVPr3RRnCbACEx4F/6y5SKiGViJmycO+tiZvftZFxN+upEW1uGJqc2XJcixKXwz40fneQ1LEtVXxPZmhUHYWGsqod/+sP5pBlymsNWr+g0Tp/DWCuNQeBc4aq8bDiX0khfglsVRUUGxNsQ2lDQh8cdwHEFGWi2u3vOqVpSpdDM6lGa01WQZ0Oi+83+UKFTLc4oKIEmXOq07mxFCuY/XVrHTaOebGSRvpvMIx9fGpW0lvhY9tW+gWUVWhX4ri8qQE5c9/9jMxkhZeKa7VsaMojEF4S650+QnsSJb6KlKsvVhzXKht4mma7Evz9rzwJqMK4qzga9q9oMgJqBelimOnpQFikPTaktSKt
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eac0dc5-bb07-4d48-39b1-08d81872d7be
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 19:14:40.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2rF4Dhj4zeyXx9GkbPyMucUwR9SiwS9K1kUxemHQMvuWfu4cbN5+F73c9TPfII8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593025988; bh=ttlhL/rW0f51RBIqrFiR89/o45hHNLK1PsT5uJ0ExZ0=;
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
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=oNvmZTX5Vt47TzWXdbClQPhH6mX/A7qFSz3h7FpxWX5e6DPR8w2W8sZwDps98VdUe
         Qyh2aM0fw8S5IiHP2YRcvX4lkVuvT2NCowiZ1hEit+lr9V/5ehi2jYZDXV9DTGVU9l
         HlAVQNbLAM8/gbMt9N/T2g6sWBMvL1//GUsxhNq67GaTSeLGRkUIBxXgjqeae3w+G4
         xUbFpt8HJkHtqv2jmWBBV2n8JKMXKUKcs3QffmfN8b/QssfNMpBwCtHqckIe/aywqQ
         oxtArcjR+XZ0notKzYQ6UF0pZtHUqRyDD6okqqAZ1feZYtRAkpEBbR7Kq/806JceRm
         WVfOldeCFL2QA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 04:43:16PM -0400, Dennis Dalessandro wrote:
> Two fixes for AIP which was accepted this cycle.
> ---
> 
> Mike Marciniszyn (2):
>       IB/hfi1: Correct -EBUSY handling in tx code
>       IB/hfi1: Add atomic triggered sleep/wakeup

Applied to for-rc

Thanks
Jason
