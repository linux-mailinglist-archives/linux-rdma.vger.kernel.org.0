Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E9034A937
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Mar 2021 15:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZODc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Mar 2021 10:03:32 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:17003
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229935AbhCZODL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Mar 2021 10:03:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K06nr8uG8Aim0i7UzNXfgIXKBMHR5R6FgT6mc30oCM5e/DZahn43rayVKHbyVAWXJji78Afh4lnFSDKJVvPzFGIye2VKD+SKI+jaJV38AZXJEV3Klp5hxZmSFZME8Lj5Wx1NlaOUGa6Tz2FW7BiMuGmVuQ1F/CHs+iHeo9ZvveyuuPvPf7XvkVixFTXmbA1BS9lyT9ZThxI9f81ypa5OedSrFfP6QN3+bbncX42evmJ0NiVINv0b7dLroXqTC5+G5HeyL2t66zeAy2eLGuyl6DeACWnjV+W8BOxWmrr1iGtljZ3tjfUxTdkSOicmpqVIQOudki9G8vAXzhiGzM6nVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5F6iF9kFxqdMO+KCgtM2r0plKt4k1PEVtzbY1qqLsE=;
 b=YbAd9E1q4wcQi45CX5zG/JzY9zAtoElRRLE0LMNZMfAcxiM01RsckNt1uk19J6PhlZjp4r0jMCsNOh0Kd7Uwl7zKiWXFGCjZazs7j4lHp/8HXbfRmkOjgPW3rI+bpZC0Qxhc9VfB1pkyNCcruSrdmZZh8CJJjGmgHx9AxKSw3kk9l5lM0EQgiCYJcQxbstgMLw6jgc/TKu88o8yAI6cLM9I1MyHb9x9lkoDhBO+bRQaaborNaZKIx4o3vTZ9i52Y05K4f2huXx6zqYGNiERbk6+MtUqggAqAwmsH/jHQ+c4Mqd9M8bq9Y73DVcSwFLNgG9Hlbwa4JtCX+qQQeDOHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5F6iF9kFxqdMO+KCgtM2r0plKt4k1PEVtzbY1qqLsE=;
 b=CHVEf0lWwg2PsjW1NMCz8Zkwly2SuULMGU0gESwdph8UdPXM6rw/1a34jHGQCqRMJ84iohQ/XU7oTSgGaQu5oCOzOtXC+3JfyC0VYr2JNPB6OSCa+quYAvc087DeiJ3+B+mgc23fiOgGzWDLQSLCOuD33RKjf6EUICXeIbDbpOvfpCsfyJjwO1XdqPQvISR2uCDBE9GpEKcjgzx41i+yr7hcBGJAAC/F1EeCuFBz69apnLtTZnUWXEaOJqBJUMK7GkhNGeVX4/uszRCG76C7XtltuNN8x1vrcamX2D+uje4Mf2S86JpczNJ/2kGVmBBQH4jIfibXNAPtNVDIcoceGg==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 14:03:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 14:03:10 +0000
Date:   Fri, 26 Mar 2021 11:03:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Move device to error state
 upon device crash
Message-ID: <20210326140308.GA839155@nvidia.com>
References: <1615968942-30970-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615968942-30970-1-git-send-email-selvin.xavier@broadcom.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:208:19b::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR19CA0058.namprd19.prod.outlook.com (2603:10b6:208:19b::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Fri, 26 Mar 2021 14:03:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPn3M-003WOl-3B; Fri, 26 Mar 2021 11:03:08 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a8c9fb-c602-41d0-8f02-08d8f05fe2dc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311662A4607BE62FA151ECDCC2619@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhBHosGGXeinlbpsLt0G6DSmgew2P4KjFBXPfrIQqk6mgnSww+oOLWSlk7xQCFrlur9AGRDUBltCjTZs1DW5TggHHL0VF6dU/KzacyYUlSy7wueCeMJMYm6UIhBbLuSGeBQRp+5VOB32B0cZQDJiUb8ByUWXfKhgAtEzmm2Px0jctkWsq6HmwBNEkEnpDGVk+fN8NGm286RHV4gcgPlwhBHKPVPa+obfauNYNF0lbEeXPgl5eFUi98YCTWRlZWJ5zregSFOLjp/ViN/UKLBJEaD2kMifnwEPJOyPk0KeGm6rBlL0YvOJMmT1cq/XsRqyBSuhbgtcQlAKxSsHqt02Xb+YAJGlQ1343ryeJvQlGKIOW5En6XB5WShHH1WcYaDzpCcdyixUp2/CNXG9a3Sq8/4DXm76OVjcSHE+ybWZMwnFsy9i1pvsD16Nb1dkx9nqE9hNs3VFL2U1u6F9ZnIMkuK/2Wk750DcUKgFXY2wNt7tJuuVwJ08zUjui5s0V+wXbICFlJkUlQ1VZJ1Ha2xetr6guxwzfcZBPwp9WrrauOsAM/sTEqaKEt6yX63dm8sTyQ9F6Jespe+9+z/a/A1skEzgGN3TzAmYfAEYRpAmZO17Z1b/hfB7/mWLtbOnnQeLNCp1zlyNByr734RxBKg/G2/sqELhZPK9qGmJW2JhtygUfOzv7wNM/FtfETN4A0I3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(426003)(8676002)(8936002)(54906003)(2616005)(86362001)(33656002)(1076003)(38100700001)(5660300002)(4326008)(2906002)(66476007)(6916009)(9786002)(9746002)(26005)(83380400001)(66556008)(478600001)(66946007)(316002)(186003)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ySODb/2oEw6LN8jhwoZ+6D9wHx6NxcZC/bfsqxyvyOykuZp1NVzg9UbC2IZ3?=
 =?us-ascii?Q?/eHCgILn6NeU7X6R5Ut/oZQgQXeY2Vu0K2oLPXv6uBCQAWWzG2Ks/RO0zlJe?=
 =?us-ascii?Q?ma9RQ4vJwVF7+pQGUGiIqtRKXNgdtrkIcGRGubLsqXKp5ids2gz3fZSso2jY?=
 =?us-ascii?Q?1Cfuliv0QkQ3DziOpAyBMcTyYEJpFeqpksrbF3BeB46+0k/1Yd6h4lhyqGak?=
 =?us-ascii?Q?sj5BZHENfjVI6QXDdOTuUmEHV/KYNBd9/DoTXFgRMhY+OM1wPxL1Ko9zk2nP?=
 =?us-ascii?Q?x2vonAMdns2Ib7vCDSFzZGYu5BH1EPUhMIIPo7C8Hb1qkLewGZILb4HxthQy?=
 =?us-ascii?Q?Eu1IzzTtlmfMkG5QwO4NuGwVY7MnQ9uBZ1UFXUTgJfORoGIsQ7o518dNy6Xg?=
 =?us-ascii?Q?bV/itS6fNEMj2cVoD0YvboY+3MfXA/r0kGPQbXMA42dB3rWP8bxJTw4E8al+?=
 =?us-ascii?Q?aQuhDzBHMGS042t9AqHX+ypKxPqDmwnMW1fUeaV7W6ASDAwU9lOA3ABuMJL8?=
 =?us-ascii?Q?peH87qDhpMXh5eYlr1D6wpvCtoRpgxx29B175zDWQ9dJiwPlFHoiiCHLtDp7?=
 =?us-ascii?Q?c7baeZVNyuI7yZHScL7qSUPOUm/Hb5bt182nuB/c9t0qKaf0/gQrAW9C4z7H?=
 =?us-ascii?Q?P0p1buG+rKn3ZDcBG1IIQmCYs7DQwVyak97G1GeQmJHNhc0kX3yhmGGIxaOe?=
 =?us-ascii?Q?kn1FTDIXgpBKvd4HOTHjZawj9F1zwwqsnRC6i7Vv1PUTlBLBL8KqfoOIzllh?=
 =?us-ascii?Q?RO9XQO9ahnaLNxzcVC2T6h8rX8SJvqg/sCBWreBgK6KKmpKLnXY3zev+kpg1?=
 =?us-ascii?Q?HBPQYPILAKmtKE0mOoegcojMdiCsNGuzgE7e33p86Sc2QZ1mCspVt1E5yPRM?=
 =?us-ascii?Q?lLD7gA+YhfIwrHjbVxr/N1J3S4U2wDAc/51U9jBFF9ZD/6zNobJSVvBMSihn?=
 =?us-ascii?Q?VWUNMmIkySV5PkwUZpmxH/OOIon2gtF6PAeaKwyNlf/NydJ7Qqmf/SPX0Qe2?=
 =?us-ascii?Q?MQXFpBYtN28UA7AhUTMzUl7/MhFeBAjbWijFJkt6rxq0TVbF3eiy24u/hC0T?=
 =?us-ascii?Q?eyXneYBelbw4fqpFoAHC+F21tesuYstJDWzid3boy6PMiulNTDzgNwV288I3?=
 =?us-ascii?Q?aEivnLFj3PVBOV3wlrMS0yCzSmkIb35yAzr/jtC5eq+AeiCHTUm5A4Navns6?=
 =?us-ascii?Q?2nRodHwJKEqiCIQe9vaSZbL+WAT6pyTzbYQQUYMqgUTz8AuSO9D4g0riMGqQ?=
 =?us-ascii?Q?+DViECbs2fsJkkM1R2zz3Sv16E0TTQUAefG+xtN6ttbQgN8KbI8+dHBKUv1J?=
 =?us-ascii?Q?AqAM9IMZUMd4sY1A2hAVPwew2fXTKxQULkzv7NaU5112gg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a8c9fb-c602-41d0-8f02-08d8f05fe2dc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 14:03:09.9465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxMBhypy6aJdIK8VmozOJ2V650CLM4wPJFkieCsZsRF/U5l39UUBcUqg2EyJkwqZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 17, 2021 at 01:15:42AM -0700, Selvin Xavier wrote:
> When L2 driver detects a device crash or device undergone
> reset, it invokes a stop callback to recover from error.
> Current RoCE driver doesn't recover the device. So move
> the device to error state and dispatch fatal events to all qps
> Release the MSIx vectors to avoid a crash when  L2 driver
> disables the MSIx.
> Also, check for the device state to avoid posting further
> commands to the HW.
> 
> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
> v1->v2:
> Fix the build warning
> Reported-by: kernel test robot <lkp@intel.com>

Applied to for-next

> +	bnxt_re_dev_stop(rdev);
> +	bnxt_re_stop_irq(rdev);
> +	/* Move the device states to detached and  avoid sending any more
> +	 * commands to HW
> +	 */
> +	set_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
> +	set_bit(ERR_DEVICE_DETACHED, &rdev->rcfw.cmdq.flags);

But I'm skeptical that all this set_bit stuff without any locks in the
driver is sane

Jason
