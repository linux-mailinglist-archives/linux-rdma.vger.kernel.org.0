Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54453F7BC0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242336AbhHYRvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:51:49 -0400
Received: from mail-bn8nam08on2055.outbound.protection.outlook.com ([40.107.100.55]:31553
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242395AbhHYRvs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:51:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrb5QiSaQfD/BGptd9YhIT4QYGclHIxVzVOzQ4sWKtooXg0EY9HkGT8JQc6vAk1TkicCC+i/ooWmOGgsEmibYAqoaWHUDEbdy85hzGhD8kdtFJxkFVWBPOwWb237ADXOJZSPTmlPXupS17M+Z54R8lveZLRCDv34l3Th94LUxV7bdQqb9ZODSMRapx1/xb85agteKFaeY0w+iEt5aF/lqmnMN/jHw3/l+UNjwz2GJdvTSL6AP2htcl2H2AgMcuwDSJg7GFvnIYUk9aHBHq6nRQh8m6+JlRE+QQzL8F8QpV1PA55LxoXlcD4XVCdmDZt7lxeOmszNX9LPpBpBC066fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmHWC/TlGOOITpQXENgiKuzVFwAN/3sxvSIwYEcWY9s=;
 b=XUnnGuMnOJosVlk4R0JDmffLnP6FK7QxKbE06wgWPWOfk/wWc+Mn/FyMDONPa+oq6XBSpDu3hN9Ja+UJr1Pap8uO2VQxFDSOZI9RukRryKNlPgC+zmx7MIKjiIiiWQy+CbSA+zZrEeaERyriyb2E2cp1XMS0kFqspa7jMtpHQQ40JVa7KGs+fLpfz0bfk9qTnvBwsH+9p3mxKiXxwknwQrtKP6GyfSEwbrJr6pKGDB1skhf+NjDyXZJPovyM6hU+MgX1fhqWJx/ThFTqwoNVNJQg6ny9RKfIR0kjTrHCkGq/mVgp0m/5Sd9l9kkYaRsN7A95KP9YYMuthtCbrqE0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmHWC/TlGOOITpQXENgiKuzVFwAN/3sxvSIwYEcWY9s=;
 b=m+IIXtYRfTGp6ufBZl0MQ/sbwAUomxP2C9SN1N8P8DpBJEI5wa+y5BLxJl99aRlMR5rgOYjuSrMjQVmoSC689NleXZObyyaqdDz4P/LhgaCKLG0wXVjRbQML4dOlxxlqZZpZUF9fjfjchbyEeYLA7bV9j4hFK/KWvWXKSmFwcfSqAClOE/N17qkAGjWU1pR7+FESaGr5BQjRo9t9uYpt/BP3B1cya1p/ideAekryEDOzq5dCrwL609Fx37LDNbb+LKvhd+X9/b8ljJRKmzhHgUticdRdOoblF+UPdLP+lVOhvzxK2pzSv4thxDwV3At+8BqMIJvVAbo0orbr1xD1Mg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:51:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:51:00 +0000
Date:   Wed, 25 Aug 2021 14:50:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Fix some errors in the congestion
 control algorithm
Message-ID: <20210825175059.GD1200145@nvidia.com>
References: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629884592-23424-1-git-send-email-liangwenpeng@huawei.com>
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Wed, 25 Aug 2021 17:51:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIx3D-0052H9-R1; Wed, 25 Aug 2021 14:50:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85e59f13-29b8-4dfa-078f-08d967f0e676
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-Microsoft-Antispam-PRVS: <BL1PR12MB517605730C0892D9E182913EC2C69@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kePVyK+/1l2D3iOqvoHuntjnTGYSs5Bb6H00O/4Yjrtg8QYYyM5xHVneqqrBNnLR7cDLbI0ZE40a32MoMTQalikJEZZnmBq62pn1f0mkA/hu12WT09pzXAYlgZxbxTQgMI7UBcqntTAe0feGG6MeYZ4u7pedNKlAdHdGS9S8Uo/vJXhOlR5fBGq8rCFciKr0e51NU+eb8yjMi4UdjunAV2pMlAFbxMyPvW3x8iBfTCMl5laBOug81CO9didGjc97zZbkb6vLKEv737LCPxru2srbhhEglbnPK1TQsO3tsQzOwPX/fxrGXyDsO02qaDZm0LJ2lKC7Uf5IbuLRrfGypDNKa1lFdLkbuK8PGBAaJq2ZGLqciGG3TY4saRKtfz/YjiqOJ0TMN7te4e5PPfPk2JyUq7BXu0QLVynmu8F1KLsiAkswttWvOk9M9aKKkqf9QcXxZIGhQAa2+iZcqk7E5ZNEFBEtvJQRw1JXNSu6Ttr0IihTNQNMaonmmUtWbSO70flIPECAGfo1kXrjG/xFQiA/1gvryG62OvTjuJogyFBdhqVJWC1voTKuupyK1w5OapYiKyFaCDfucnW7YPGHO/bPb7VI+6nmqSLhCH0iUy7AoRNKfb13QLmQe5LknB8YHGYNUUKOdHC6jx/qIwChow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(2906002)(316002)(186003)(26005)(5660300002)(33656002)(2616005)(86362001)(38100700002)(66946007)(66476007)(9746002)(9786002)(6916009)(426003)(4326008)(66556008)(4744005)(478600001)(36756003)(1076003)(8676002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXxICt2E5w93Nkwoc7Zg5g9YTRN1kAckXn916jr0qvodhGTK9F+ud3O5XURI?=
 =?us-ascii?Q?cgLd21AJlv4JKSoeTvlEGlFIQ64n2uUUPoaQNo8krn3Lar24tjHAakq3UE5q?=
 =?us-ascii?Q?eH1CioYkZT1OdlzWvRuy2qOf7/wYzJuUVdt76hki6YiiqLklXQOCkl3lWnB1?=
 =?us-ascii?Q?0/qM8ZrfMiquARy8WAcZ8U2WRCI3qmOFGM5qSLrJtDLEsPHgddal+FRQczZw?=
 =?us-ascii?Q?48A64a0P9Zp/fRVXFA/ESV6HUdAe6LKZ0oaAqg4WopazvamvXS3RB1BHc7gw?=
 =?us-ascii?Q?h3/AsmZezAe428pA7WwSwdAtn/NFCRKIX1wu5cVugtN6+HKqOSzXq8FbmUX6?=
 =?us-ascii?Q?jfcmCKbbwO8//t8n8psxVth4wWs+D7k2jKWGvRB6Negz3lNLyr9YhswDCTdq?=
 =?us-ascii?Q?LAEu96UhJmCzo0a48JV5isCz/QejSJIUmbBeoXmE0V7i1WNExsTrrTy/jl34?=
 =?us-ascii?Q?Xof1G9Kv1B4KoP4i5T07/wCOK+feNbnRMlMyBnQAH7broSwa9pj11P870go+?=
 =?us-ascii?Q?PCptKGz/KsSgd8iz+8ASnYy3Pt3oBmNrhZ5v+Wo05QF0Wk4AHir+q3KPhwFi?=
 =?us-ascii?Q?QrRtxD5uD7YodkV5glZZ164xMFB8JLPZW+cYXB0h36rHANHwZgEBpxoKqyS1?=
 =?us-ascii?Q?g94tJQcD1SyGdtL0ST17Pya36Ms509kUhslMeEuG0d3YQT4ppyFerCAADiS7?=
 =?us-ascii?Q?vg90t+kC08Z8sIcBGDBScMrKYzfrQLpKz2gog0HxLKwXds5OaoZd/oTxnaFK?=
 =?us-ascii?Q?ZKlArCorKZ5H73wHczot4hkHZnAKL+m77c2t1N05tbO3UgQShn2S8PWrVGwb?=
 =?us-ascii?Q?Qp4DKStYerIxFDkpEuBsR9WW+7cV9+7aUFJAM5xJ8BUw02I/ScPjRB3EGOma?=
 =?us-ascii?Q?JhNrXw5g5F18AzhYrC7YwlxBSXxTq9gx2KP7nJLIvJj4Rfid+WNKXZxNeJrR?=
 =?us-ascii?Q?QsLCqi+iAqXuBSGAerZKhsFxCAcjnLD2VkRxwOAsauZabNc/oyJgu3obWWIN?=
 =?us-ascii?Q?4A+rh+AjniFfM2wKKn3FpHpqsUJnnfKdmAbu+UqxlZM9+tEQMc8enpJ87JWZ?=
 =?us-ascii?Q?kNJnDWilwAdK15T7mW+CsnQkfy/xTX7SMGVK5pY27P3l0KoSrUi4JqzxVlUY?=
 =?us-ascii?Q?u7JV2GSCQ8tiEpScC2OArrNdWt0xUw1YhhvhP4P4GISQzy6Mtg5Hyf/7+beV?=
 =?us-ascii?Q?5Uyef9xs80zQDbPOc/fbJ5fBHhthHMJr7HMZL4MIYmtYZt6fBFBwCVibp7Xr?=
 =?us-ascii?Q?f1VoBKB0EABnifVRDF+5Fqwo/F+mji3oDl5TvjqHHa2PTrBnCuH8lP7RI4Tv?=
 =?us-ascii?Q?W+ghY9GYRclYaE8yuupQIEAD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e59f13-29b8-4dfa-078f-08d967f0e676
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:51:00.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viZA4StN54gOOQk7oasuYV5YFKgEJQvn4a6xLf4jUBg3qXy8Ec6Zlmq3YihoYivy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 25, 2021 at 05:43:09PM +0800, Wenpeng Liang wrote:
> Fix three dip_idx related errors.
> 
> Junxian Huang (3):
>   RDMA/hns: Bugfix for data type of dip_idx
>   RDMA/hns: Bugfix for the missing assignment for dip_idx
>   RDMA/hns: Bugfix for incorrect association between dip_idx and dgid

Applied to for-next

Please do not put a blank line after Fixes:, it needs to be part of
the trailer block to parse properly. I fixed it

Thanks,
Jason
