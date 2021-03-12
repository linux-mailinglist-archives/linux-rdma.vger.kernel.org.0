Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4B338E61
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhCLNKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 08:10:35 -0500
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:42848
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231379AbhCLNKH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 08:10:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkcWI8YXSnFkZqSY2KGqFflzAKgTJ9vzhntyXKE0vhdCB419YShFkxS/hyFcfyb+ibByGfy1GHKOV7doDTg70t5nx/CbXnX0skuBE2EK49G53NqjnmO48/hpoaC6Bh0OXZch6RvC/IbDqL72e77PztFRTb8k9YTeC4nkb0I7XSWtIHS4oehvx30yKmkSEkN7KisWn51RRFl5dMGkp1uVDgPILdFzGm3Yn4/HDgHWDT5dp/rj5R5jmaAUkhN0/uHZsace8SYcInKjoG2rVbiWGdW9y/71Kb/5z5/ClC9yuh3uc7QgLezwUuRIzl/jgrPk1WCnP+uV4f44Fwi/teu5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TspJwo0N2Bx6GeI/XaXu9npRawAObJMf6UTI+9L2Myk=;
 b=AjAroAuPAXm1JrwuIy3SkMjzUuCwRSKJ/cF/0pnXXj6AwFbxUrA+WaUsZZafvozvtTQyrpW6S4Y3NyAOtUmZVTXTs3TOrUhk4OaxMFHjrbCIsL3oqJXQh6wDSaeiJ/R3G3dotkI33zpLhoIPTjIm0M+jCesKhb2ulX3Sl6j3tN2xv/iG6ql8qP9c7yJF9/R/FkGVdFyMKBgGkpN+8dmtNGxN7iVLUoW3lsvcTpaCkMVetF7APgHiYzXXT99K8+EaKFJSEkt/I5qsYq9mtlB7+6z0AdFvSMn3VVUTApQ8IIc6PddrT92/46qlkbvujmPsdhjG+B3rr7ao2xaH4lgnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TspJwo0N2Bx6GeI/XaXu9npRawAObJMf6UTI+9L2Myk=;
 b=eOUZccVXEdfQo8s7DA2ALgLLxeBv6r5tYmd9OVtyRCRI00k4AbQIjrKgXpoAu+xE2m6egJgjfIh8fJQVj+I9mfSmIVSwbJBp+5HFf/XWfv6UdSYwMftyidMuTLO105jBEKYNxIIh7xqRSjnT8NahuI3dN4rfCg1YM59oR1t/quggwhcC6TZskzLj+NSk4r9jd/2wSger0NTPwnb6qu9/7R8QfYnu8nHwxset/xxJ/cua7Cnrl24GgDVzptmPpofq6VB3jaPyiBSHEb0L4Id22VkCH6VnmyLRo6WX6h7wDSSnzbQZ2aIKSGtvzcxPNY4MHAkh1SaChSXHVRuphvjd5g==
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 13:10:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 13:10:05 +0000
Date:   Fri, 12 Mar 2021 09:10:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma: delete the useless casting value returned
Message-ID: <20210312131002.GA2835774@nvidia.com>
References: <1615515570-1692-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615515570-1692-1-git-send-email-wangqing@vivo.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:208:239::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 13:10:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKhYI-00BtlT-TB; Fri, 12 Mar 2021 09:10:02 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a85c09-8941-463c-251b-08d8e5582682
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB010672AB203DA9627C7E0E96C26F9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVXXKWBOWMjN5j4C9RlG30Go4hydi1xQlSl9UK/iri/IYYA3w2uS/oy/ML/k3nlleI35YRnk4cvYBaNUMNOLhSVJ8HcrvTefLI6C+HSlFVqzVNPKVq6MQ/JcPK8MRVSj0/p96DMiAiz20r/A3qANPLRWv1qllvbwpPl7V+SGLgTpWXg8npYXMwqz5gfIdrHdjJKkFobH5tJxWlCm4qRXTF/Dti5ToSTAbpnkB2mOB7QEY926UCa3YQayzPuxjf5/zF2UTPBtRu1mwdM1jx3sypQY0nmPNsvMDvNlTvD+fRaqz6QkcHICDkiXflJ7G//4iYaqdrYDh4LWO9jZh+NMJ1CDl7lUlSVw/C2QKbYpmb/ksSvgrT8mPiJECdd+iFFI5PqW2QQnfAwQwyaSYBbkmbGBfQqL/gXDJkfhqQ2ON9a9Kr3HXDYh7GoQFAM5Wdc3QalGohl2zTEKrpjJBFH3lNAf0da1gBGkbE7ADb719HIJX3bS9U6Irkcli2hpwSmbf346ZxJshyIHi3EIetOvSYy0c9YhpM8tixh/yTmsRAIvWVNEsRn7hczKjFWaCeg/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(9746002)(9786002)(8676002)(4326008)(1076003)(8936002)(316002)(36756003)(5660300002)(4744005)(83380400001)(33656002)(86362001)(66946007)(186003)(6916009)(66556008)(66476007)(26005)(478600001)(2616005)(2906002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qpAKaj+XGNKpyHLj7VRr9Ltasv5PVEVxcTKRLrOJs5P2ZqGviIJAyZIY8taO?=
 =?us-ascii?Q?9eUgxtCdkQOdjLokoSmFv0LAS12Paz9ybCGf7A5i3kZyJfv7VLUeB5SXnBhf?=
 =?us-ascii?Q?6zzbz3VBVu4xFJqq1pi1qtWGpYfPGgINW2wYuJfOaLWIM4CLPY8UDW6DRUeo?=
 =?us-ascii?Q?dgD7nnUMiAmqwtdk18C9dsMM8uDrurMFWTCBjEhIMze33peGzD3DAlTqfEFk?=
 =?us-ascii?Q?ia9a2P990bu8j8J6/LPfohn0XADTo6+igawa+i4rYOWsqtWPsidKTdjKLx7h?=
 =?us-ascii?Q?Kf7bI4q8p7MFhnxub5Pn9hdI9mtTKbET1nR7zm4A+2nWd+Nm89yz28ahnKsO?=
 =?us-ascii?Q?jqtRNO7lURscqH7sO6Y6CToEHxi2zXvV/PBqzl6Pbkf/uJjT1muFfSCz/LSR?=
 =?us-ascii?Q?2/dMMt8oXMRXFkC+ohNUburWFfdVFG2vfPXjiwmEq8ZWH+5GJkar9uS+6kp/?=
 =?us-ascii?Q?OMjQ+qOSfvLCuQoy241Eosk2IQOZEkpznZL+TV2X2nodhBnP0B3qvtncwdsi?=
 =?us-ascii?Q?Ah/c6cM7JrExwSs/1r1Aa6vHHH5kuSpAMItN00LTt4/e4U6ypCMZOdEI0p95?=
 =?us-ascii?Q?8jYvIHH7BsrWio/WnuuSgQvUHz8rzo4vgpNuEZWFHNQlmd4fx8L4UsQCVx1d?=
 =?us-ascii?Q?K0e8mRO1Ig2DhNFORfQrTwhe9UEpg6TKtYYObqXgRZMPviH1fupwsDsEBIPi?=
 =?us-ascii?Q?gXFd2ziIAUwNpDc69tlztT0zvJRWaBT7hgRCDHg7bl+S+pweVzwnf9PsiOrU?=
 =?us-ascii?Q?QGuF7cGCmyUNDCvkXOimi0sH67PzdVNX21m4AudIiL1Nn/J9QPbvT8s0Smtw?=
 =?us-ascii?Q?2+wbmm7EbAuupHuWgKFCoEHOl+D28qbU2EVuK5UQze2ZUMsC5trzIArZd0ge?=
 =?us-ascii?Q?0hAHl4GUyyJ7pGaIGbmHqlwBUOAhYtT063Y16FLFx/D51SjDozpQLbTmoywF?=
 =?us-ascii?Q?i8EhwSeR4YtHyXxETbBJNA5LrU/+01W2OHIHRKIku7tdh8UeFqOI4kfLFd9j?=
 =?us-ascii?Q?KtjIG68ghW8MmwyFM/th+De0twIP87eslTIR8WZL+bDzA9p3R1//ZmG3I/X9?=
 =?us-ascii?Q?YRF8ustqxuLy1CDP7nlNfA42489AnTg0Yr6YhfAMOkcj97fCXr4FZCfxAyUc?=
 =?us-ascii?Q?e0Yq2OYZXCZET5ymYqGE+urz1zIVIniFMyT7OpG8TwQKmRD+7tBby9OlwBvl?=
 =?us-ascii?Q?PJHwRsyw16GaJNGp9HV/nAPtQGoa42XuTX2tvPTZxikzQUGCPiZk+wb0fEJ7?=
 =?us-ascii?Q?fyhvonYVTCrSPqPOFxsfY9jTkKXZlgEX3eabflNe3u/2Ncyy8hpI53cbBDPJ?=
 =?us-ascii?Q?a42b+THzhBufvzdncf3T0P9pZm2u8hjP8bMW8Gibl+UWiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a85c09-8941-463c-251b-08d8e5582682
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 13:10:04.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjs/41ZdMIby8y/XIvVwU2++Mo6NJZYvcZqZ6rygCdt1aIwvz+/RT0HdtVBwVICF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 10:19:30AM +0800, Wang Qing wrote:
> Fix the following coccicheck warning:
> WARNING: casting value returned by memory allocation function is useless.

This warning is wrong in this specific case.

The #define is creating a helper function that enforces strict type
safety on the user

So eg,

  struct bar *obj = rdma_zalloc_drv_obj(ibdev, ib_ah);

Will fail to compile because 'obj' is not the required ib_ah type

Jason
