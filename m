Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D990025C0A2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 13:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgICLyk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 07:54:40 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18804 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgICLyQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 07:54:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50d9520000>; Thu, 03 Sep 2020 04:53:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 04:54:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 03 Sep 2020 04:54:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 11:54:07 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 11:54:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjIzUBq1acpkKEXQWauXMvtoQFkPazE0nPwUmdmLe/g2LFuJg5h4EtomuD7sT36Uc5uOiC7ymWzHZDYxKGZr4qqBUUI6uoZb7BjmJFbNF7ZM0FEAE/AJobJ14HG50UrbPhysfEKqHwqt5ypRy3BAjDK3qriBnTWcPODL7pf+K+TNgTczZa3qnrWT3ug2X/NVDRc+fuwFsSqNe+xdpUJF7cUrYUNq+5N0Zb61UI4Suzq9OQg2CZv2ZplmnMiIeehDAYHfNU5HTOyzMFEucxLvjxmXb4uNb9iSjP9GwpSsGZqpBA46szPzB4zi5I0MwykJDT1UoCVBDCCL7tRAJjxKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HXXXCMwH5Tb78XrVfPSkONcbU6WTOw0Brm85MOBp+g=;
 b=h7lDwUerVcKWNozkJHNaaKUV4Z0wMFsAlMsFJzZxwQAoqYbLRNUr97XHeG6iGGDPIHalh+DqyAq0AllkAvikze2xAMhQpVhdVxUV5CEeCwBSGrzV47Lztoo1XQZS53Jn+Sx21RnTGqnHQmHXC0LIwQPP0A1d6rUgbWmEu4d4LhbichtRd+Ql8O8RyYmeAfZy8/5eLODtvBl3HCghFYrb3a9wX63pIFxTzfCyUnNxdLV6s1ztpVJ0O+PuoTpU+Ir1Sc7FQ6u4cYRVy6vmX2sBIGeazQ4cL+WbYj8Y1rBLEWfZTtCd+9p+Py2IgNILRW0UyEraHh5+BQAKWzs0JjvqUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 3 Sep
 2020 11:54:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 11:54:06 +0000
Date:   Thu, 3 Sep 2020 08:54:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 03/10] RDMA/mlx5: Issue FW command to
 destroy SRQ on reentry
Message-ID: <20200903115405.GY1152540@nvidia.com>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-4-leon@kernel.org>
 <20200903003115.GA1480685@nvidia.com> <20200903050811.GO59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200903050811.GO59010@unreal>
X-ClientProxiedBy: MN2PR20CA0059.namprd20.prod.outlook.com
 (2603:10b6:208:235::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR20CA0059.namprd20.prod.outlook.com (2603:10b6:208:235::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Thu, 3 Sep 2020 11:54:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDnob-006R7V-5M; Thu, 03 Sep 2020 08:54:05 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07cc1434-02ef-40ab-07ab-08d850000f61
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31159076814C9F82848AB97EC22C0@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DD7gY929f1KiIBp1rKDSpuKEI4w5EcXdSpL+WN5L8TktuPOtSyIRkEgFRxY328K1ihMDqIY1RsIt1uewaoqAXp2fRdMY2ZH71ATPxoTX0xGBMTe3W0eDo99QsjSouuQogk49QtxwdWUM6VZL50lJEavPRHaaPKyJuTDRc5+3g3ttR1ZTVrCZYq2ixvHUqPZCOAByZhWEHXTX+lHdQO+JP5hSE9dxdaoRpkXgE+dOO6WtLvJvxIheKWErvGrdFJfwrBz5T2AVhFfvZ0X1RhnlmYqKs3CJzpbs+dgQieMW05w88Cc9NbEbk0mj7F8b9p1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(26005)(6916009)(5660300002)(36756003)(66476007)(186003)(66946007)(2906002)(478600001)(83380400001)(66556008)(2616005)(33656002)(9746002)(9786002)(8676002)(8936002)(86362001)(4326008)(316002)(1076003)(426003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RwnU9b2gX3nRuQZgyp6rSQkO7/XBj59NX6CwwOidHtt+YPK8tOGOT54gMn3HtVqlPLFf7IE89W3jYZ7FtjtCNh5BeCZ3mYu/gj/ZIqrfFU9sIve7x/yiTT2oaC0wACD/hYoSHrAj8dcP+1WChvVILTXBhsvhQjhfnXPRVcZo6hLEKQt185P2ztZoE2obq5x6QgHy3ykXtGGWW7yjEV0iee0gKj1USZJn5DQOQl09uuQz1gxcRBau2umNW5A9oaUK2Bo7o8F2ANHbqssMSlgdm8IajBuYFjTJlpVcB2PDgngXDhum5sOClhSTEYXKHw1QHrTZmHQFCgr4rGpV00AevpMd3oPotOwsO5blKmVrK2A9cX4p0wA7QP5GWdhyxiCzdH0qNKYztoNgMMEA8IlyLwilshhb5zzwkpMGXeAPAf+d9echkwv51MgVdDR6YN5w5z1QrmdhJ8DqiaFMg5UpBV+HKmsByMFiqdZP0ki1I78IvBrEADVPB5p9VN8345U5S8fDbdclOHiuTmHTovrAEQWHWY6Zps/mXamTb/uvvEgZn1v/grWTMPM/peehwD6pCZUZrMaVuzGBDgIawEsfexB4bHykD87Euycx0RmTLx362Uehbt93NVfcaFPpzt/t6mDQDkHIwMGdmhZ0RjWNGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cc1434-02ef-40ab-07ab-08d850000f61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 11:54:06.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5YC+rHVthfUFQwTHIfBm9X/ftYaOE0xeuT620wy1KSRK2A3qEJSKRFfFc/S6ogiw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599134034; bh=8HXXXCMwH5Tb78XrVfPSkONcbU6WTOw0Brm85MOBp+g=;
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
        b=UjxcjZ6vzq7bObrea3j4MmsB5V3J2meXVhtC0+0vp5liQ2yFjJ6gSjvnqaxkBWZLG
         6uhicNqx/cOv37bDocos+AngzayIqYfuR2EneEDq4InPifqyHo7RDzTelsBCQ8rhYE
         oAnmwO19xY0TZ08WZaoZjKRh9qsrAnOprzxv5PncqfMB+TVhIWQ9deTAMpWLYqthQf
         DQ4edLs94kSIOKgwb9d3fcIj4PZekqs2MLEuHsCQ7pTQwxzzzsLwv2eNZSSx9pv9R+
         8L8Ci+m8t6jVinMMtq72w1pP5CPm5m4vTLDLGJgrsCdIhXIuvY+Dhu68Sa3xuf/Y/6
         9EPM0GdUvOf6Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 08:08:11AM +0300, Leon Romanovsky wrote:

> > It needs to be xa_release_irq(), which looks like it needs to be
> > added to match xa_reserve_irq()
> 
> We can't call to xa_lock_irq*() while issuing FW commands.

It is done in place of the erase_irq above, no lock held while calling
FW

Jason
