Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCC26319E
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgIIQVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:21:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:3056 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730701AbgIIQVm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 12:21:42 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f59010f0000>; Thu, 10 Sep 2020 00:21:35 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:21:35 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 09 Sep 2020 09:21:35 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:21:30 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:21:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu/mUR/K46DzbyE6ZpefU6yr9uD8d/9zHoErsFlOf85LfjuSyUW4vuhR7Mfj81O7NXxED4P+X1KbQqJ8Q1VeZEaJ1WqbE3UWgkSiGms+Bkl6+I739gbQCdwMSyDK7YAngvj/5ybfLXEc7bre0OkTsxOFaXraazsXt2XAu5xqgHWZ6EhqCE6P3m/B7mVXPo9qh39ETdEuRVNLBy3He9LDKgDZS0T3KsgM/6OeI6CmIuxLGACOKcWhTkvmuZHvtdNTdJQ8BRCwD6yri54aTKHb77s+9cmdEpK55uLUKRHToSYDM1kG7bqfL6rclGYu2eC2Zko+/XCMvcQegcC4tUUO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdxkPg4cqdDqJ8Dl3OzMSMsSkp/jiUhpJqU0D/mresE=;
 b=hwmqcboBZFnG2WBvYou6G0OpbKqsoTbJsFj9GyLGHA99Yv3HHd5tV5xzrF1CbWaLOHrIwy3cSxl+0I0YcUuIisNidv+U+Tjo9y2mlXLCBn46OtscqxVOGmQ5wMnu7/19RKSAOfWVcjvAXBgleOITl7HzQ2QJH1GcYPoaqFjxzOAqh/mx1gzFzcoMe62wzPdy8i1NEq9t2cs63xsV/GXWqBfYH/M9RXGIh4sPDjKcQZPRoulZ4S05B/azuaucNxX8zhGqlIfeR0xVCT3H2tWwakECfMlCUuBQOmC50+YoK7jy6y5li0U1FFjWXE0Yb6cTuR+ICwMGFffzvBqod3ZvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 16:21:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:21:26 +0000
Date:   Wed, 9 Sep 2020 13:21:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <somnath.kotur@broadcom.com>, <sriharsha.basavapatna@broadcom.com>,
        <nareshkumar.pbs@broadcom.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] RDMA/bnxt_re: Remove set but not used variable
 'qplib_ctx'
Message-ID: <20200909162123.GA834958@nvidia.com>
References: <20200905121624.32776-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200905121624.32776-1-yuehaibing@huawei.com>
X-ClientProxiedBy: MN2PR05CA0034.namprd05.prod.outlook.com
 (2603:10b6:208:c0::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0034.namprd05.prod.outlook.com (2603:10b6:208:c0::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.10 via Frontend Transport; Wed, 9 Sep 2020 16:21:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG2qZ-003VDk-SR; Wed, 09 Sep 2020 13:21:23 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a69cabc-d2eb-4a47-8ead-08d854dc65f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17541F593035F1C78B7AEB56C2260@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQ2DTRuIUMxXvd6V8rTqzuIdsOXBm6Y0bCeT6KOhQMAalkSOrNPu+CxdeYYXew5y/asspEuidFvS1BBDwwhu/1k5tXstXg1l763+tUXxNMA31ksFV8yrm8+mH2chJiHv0wqP+krI7EuBQaU7LQcW4YgwBKob8ejcaqWeKpJhTqG+ZGAo4lgJ9g6NaJ6tX+LbmYpWlnGhZ+dY+14ndP0HQxveyMpGuVRf1lLpU3m1lPd2jF0YJnIyqHYpdiq9HxJTZh3q+tWyqnWXoINdYInGpukvwyCuZ0IMkJVZux/T6d76Ft+k9lsIDB6RtuOHRtpoecCf1YFickPvqkznkZMQaEZ4EoJF6KrtrfRu1ep3LDJ7AIEDzpPmerRa4bWW7b3a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(8676002)(86362001)(1076003)(36756003)(186003)(426003)(5660300002)(83380400001)(26005)(2906002)(4744005)(9786002)(9746002)(316002)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(33656002)(8936002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zZ5DjXFpWGn83QpXK7+2bu0fbkzr66999WpZJh08poE6M1A25VnREBC9T4E2e5sxuaFuUS5675+wIBgFxD/ntyZT3v6KyA9EKdWvpE6HNN8MdaLZqNZWb03THzpYN6mpMACMldkJ8mUvZF9cRPDfhx6joJcjg1K47rbUXY7l3on7KsQ9NUBLUFRPinoAqa8Sc3oH85CkI9ZlyowyBi1+VgSINIfkcEkCQVhZ4hH9kVSWlKe/bi4Lo6QS72+aXceOumx7qx9BbgA+IovR5mKbOwN/C3x4jbgHWnVrO9+zXfDSb/d3ZvZ17YzSaJkvNyx0s1GqZfJAxlPM4BfZ/Sm669iO8+FkIA+BkawynUx1yMhaOAUXOPf1G+tn2pwyAGnerYotlOAV/ZVtb04D+ONNJfUMkNU1Z2xJd2WuyXw2M3vsjaw/hs9DnL1fByx1ozg24pisgExl1SDlTZVcmvB8xVlbZCvAORDggJMxiHyTuW259su5v68c2EwMqdZ3W7t+eS+D5S+uGCWRQZWAxxl+9NEMGVqZ+6kiZc4HvbjtiDRlRdRjuVwfH5DlMrCI1MUdlzxGNVIwPKnuIy6RzBNWs5TKJLgK0ZMAsge92HjfjRNlDqR7Jr5ZxeBUCJmA9oQeZaa/EQzo8aR9paAMRGsk+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a69cabc-d2eb-4a47-8ead-08d854dc65f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:21:25.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ym9onbWIeXYUMOouI1mNj/3hM0NUAKpxC2tAbuyxNmgsZVTTclURyGUwFjEFbsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599668495; bh=JBh7Xwr9nXOir7sTeqt4nRVwF9gez2ot/pqAvBeuqgE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
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
        b=alVzraIPWMduqvBUPQF+cv/YmP9s1amSNrV3M+k67VsbaHj34hzmCJP8NILOcx1YS
         RRRzLk4VYOEPJoStStSTfgFXd7TPEWytq0XFyc/RRUiOEhKrheOr3otrSrX/h0imRh
         8flrSk360AhKft+djsRGDBFly3DV/+wQiwMG96tjYT6TIatRXZAdWmnei1b2CUIi+Y
         wBmQz+GnYlyryvA4FR+AKaO9uCvSg5U6ha6AClwb34tDH4B4XSNpx3X56Tvds6AIc9
         eoVDp1gqh8mKxPLftI8tp2Gr85lG3u+1XN3e8tWvLCG8AUBeXFwLWeKq15DtzZIewa
         qLp4dzULVvIbw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 05, 2020 at 08:16:24PM +0800, YueHaibing wrote:
> drivers/infiniband/hw/bnxt_re/main.c:1012:25:
>  warning: variable =E2=80=98qplib_ctx=E2=80=99 set but not used [-Wunused=
-but-set-variable]
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-rc, thanks

Jason
