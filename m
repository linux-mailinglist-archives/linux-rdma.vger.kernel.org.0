Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDA355445
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbhDFMvR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:51:17 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:43968
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243345AbhDFMvQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Apr 2021 08:51:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C689NO6i9npIE7Ki2hH0thbpd44UEUTjRnc4u2RaM3xqpbfUt/DsY6xAysp0hXH2P834mgneL28tFJW+BlXRoQ4n8OGUVfvftPLybt+W6uE2l+kabF8w6SJKN1qiEQXoUmxX29iroviTRV/6pbmpNoKly51RBovLIz/paZMShCbO1vk/ShsWOocNC1uHGeu5JLi5Z/OuWGOlKwooQ6aAzX0JLrJhIZDtuwHqD/QqQvEkAslCfg6YknNFIpCYnoc5bZbNQ1FgXV9NXvO6zycKo2qqk/tUAZa3RMEEkkMkviva9yryTsL2PF5lUXUpjbMrWzpRFIMHg7GUcEsxDQEF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkNizeMYgiXMKzddDWBRKX/wne4++CqzH8SH0tHz7/g=;
 b=b0+nM9DU+SdKADA33YYh+D1/a7Ty+yqte5MuQYXNXkvYKCUMO66tLCoGgxK+BZxmUQc0ZDn2Wkg4XF8oBzzp1dhXNu3y88ydMqphfiFOtujydi/vhd3o2DVIC6B4H99+0hHHk+WSYAom8Wh1ghAj2e3BSGjPy15Fu+gU3i+e+WQ+eLqCJHsUJVpedhs5F9Jd0AWcK6gLy0/FUNQKx68lP8KE069WaMXqw7DrcHw2orGETmGumft+fp4fyDdMQkgcL5N6HU8BCNinp0KIdWFp+Iz8jpYsfTpo+KZP52RQuWyXH1NNFx70iZMzs9OzY/g48wa3jCfwSDIqaV63cm2XsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkNizeMYgiXMKzddDWBRKX/wne4++CqzH8SH0tHz7/g=;
 b=odBv2PcKM9Sbt97SYj/h7G5fqsyWDuwzHzXHCgdyK0Vc1SYc+qy3hGMkP6OC8DE1XRA8benbiokK82LXJtVc8Ti3e0bala0r7yrrbgABX7DR+5epdVecfAE1j11XqfzUUaRXgguCJ8az0yAUcvd5ERGFSaqnDlzefMJ6Ew9UU+nz4R1ichFDvXbsOzBMdkVqM0EFytHF9cvPXTnNfTEEA8QwiUCb76f4uMa0g5NxNEChKufG23sNS3RLQyq68c2oag2Op/2lQVK+6PCi0c33d9+kDS/pJmVeH2mcerCJQETb9Mong36d5+Sxjz8vehbC4cBOgVdv0ASDORL5DkWvLg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 12:51:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 12:51:07 +0000
Date:   Tue, 6 Apr 2021 09:51:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Subject: Re: [PATCH for-next 06/22] RDMA/rtrs-clt: Break if one sess is
 connected in rtrs_clt_is_connected
Message-ID: <20210406125106.GP7405@nvidia.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
 <20210325153308.1214057-7-gi-oh.kim@ionos.com>
 <20210401183825.GB1645857@nvidia.com>
 <CAJX1YtZTDboK9pP5KzFB0ZEwXMmOYXANhdyhnuBsqAErvaoUag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJX1YtZTDboK9pP5KzFB0ZEwXMmOYXANhdyhnuBsqAErvaoUag@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 6 Apr 2021 12:51:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lTlAg-0017Jw-8k; Tue, 06 Apr 2021 09:51:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40994357-fae1-4677-1f4f-08d8f8faa55b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4546396E9E07249E845767C1C2769@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQSXOz9rkCVVmlp+so2TJnRsA6GMeSvHQecbEqQpBSjNXJUjRirtja8nLfvn/LSatjD6zwk04RymvAcNmX6/MjwW6M2Hmw991G7CbQMf9hMCeF+6OF3uDyg2/61+TR5zvqfzDIAIAl+dadbrrjJ04tlHpv4wXXj5kIa905lQHcbFN+XdAWvndyAQs/+pPCIrk3ok+T2hn3mhEaVLZ0S66PIBeizQq4eYBkj53663IYtZOHwhcKbTE3WEMboAV8H4hvJeqcX61VmTmN9Yol/oeRDMW2rHj+wPW8soUE4pJOjvDSXGbSB3nHx+woHOtyORSmrLPGahHci0AHNrI66gCQXXZvj0Ar5FW7ai3ZBUqdK3gc8krRnykvyshbM9LJNMUOgVgfmEwdGfE9IYL52PbVQdfhNCouFTmpZMUWH2YP96TLqaGPxszYishUyE9AgM4FYHoE3skT6el4LYDziNfd93p2W5h1RwQ1xxatgCdJzPhIkVECUgyaRyWT45p1WaVWDB9wUUd0i0+sVOwECd+aZgzlGJQaaF9BYIpKiFW5KpY3zsC4oZwgF0k2X3QHScvPHJWhVl/H8ZRFGK8Eo7uXBuJ8SJvyFtGX9vzItbRZJRxhYppOk7WSoHwcQ+evK5NKDfeU1yfP0B2VagJ1WGEjXEp7J6EWk6WflkbdOA4PEQ7UodmeXlveMz6aWQuS8Rt9YlXY1CGToxEBzJXHlB6THjCJ0ZyzbXWDK+qje/i3Bsgoj7imr8LLUvGccgiKK2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(66476007)(1076003)(9786002)(9746002)(478600001)(66946007)(36756003)(38100700001)(33656002)(316002)(426003)(4744005)(54906003)(2616005)(6916009)(7416002)(8936002)(26005)(4326008)(5660300002)(966005)(2906002)(86362001)(186003)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sjWV/hkvznZx2XgkvB1NRcf0KDr3H84gVD9/bdfN3quJA3jyhz5Vf7AXWzKF?=
 =?us-ascii?Q?roZ6Pxs6bEcRT1dPxKturpCLbhFHA6HANWb9F+JzJAH/TQECOjdue+c1DAf1?=
 =?us-ascii?Q?XMVQ3SUnz5wGcva7hlUnr+00I/bYv1wLKy8WChjJKK2OuOFmHa7Wyi4tICAy?=
 =?us-ascii?Q?C/tidktBy+BAgUOA5qtwAZOn4yLIriPaTSmiG4cFlLxf44THtCGlD1MJ7Rtg?=
 =?us-ascii?Q?vl4TXibhznzUgC8CjmoufSmtV8FqnEmX2XckDGVQFvCtw1y8ig6MXTKGophg?=
 =?us-ascii?Q?bkEtCsgBYPvlQrcrM+ZpNfS33u2xfJ8t+EwB7FiX/yKE/kiTUlJe3SGq3hsZ?=
 =?us-ascii?Q?DSPNrbCMFPxbeTIHaG8f16Hv33IFBXVBzx7TraGnjmbXiEAcJ6UUSnMoIhBX?=
 =?us-ascii?Q?hjFt7iPhevYUE3hlkn6nLg500Bl2jeZ8eosajpCDUU7XXZT7e6mKwsMq9Qst?=
 =?us-ascii?Q?zgUhjIeT1p3+3zvPxEMTxdd9FQtAxqCZErKVjD5k+sAU+/CE1SCjKL38JutD?=
 =?us-ascii?Q?WjjnR12QsoadEZhmTZkx1giNzrG+8fIMoDOz721JVBXfPbEllmOco+2wdKGf?=
 =?us-ascii?Q?A0jWUpX4ZTfqRzKFoMk25nASRr9C9cWJR0zqP2Vw455KUPdjb7SgH/DeIz0z?=
 =?us-ascii?Q?oZyIRmyu4y6g5CzyaBrqVSDLFIW97yuI7T6F+9DqmGMRzYUoUGHTVLiywG5L?=
 =?us-ascii?Q?lL/D1lBWTZhiujYYCqUdrGjNpfD+Tkrpkfrv3RXRqwEOz8utA1hzY24rsdde?=
 =?us-ascii?Q?oDeGNB5msbTjpNl4yixuBVzCNJmIKLsAU5yZDoU6QrTwhZpAIKxpGV36y2ID?=
 =?us-ascii?Q?peXKxXCd1C9QjObX/GntGrnb5XOS+iOOfhFkUPNaVdWKla4miQRBeAadnRTt?=
 =?us-ascii?Q?vKGj6DG+xP2DDZzt9eucP6xLLY+ig/3DlLF5tiCs1cb5zzbYNbi1sUrXBMp6?=
 =?us-ascii?Q?Ys8d/VY85E8StaugxePq4rBzv5emj8eAtcoevc2aFws5GBIndncQ4Yg6v3j4?=
 =?us-ascii?Q?dI9wOYxqZdT9wNqIpb0dp8QIX1K8HXFbVUzgEvVY/ZyESjP5bPyM0wtGXAmy?=
 =?us-ascii?Q?0l6A+5Uu0HWtc6SC2a3rDKxysk2KLpuGC2nzvl+bdZw+bU8NRJo062TLdmnd?=
 =?us-ascii?Q?fzVeAGIGYdGJmNUglwvu9vSgxxclfY8XW/X6Vl/iZQDgMqmZEjTozHML1+SR?=
 =?us-ascii?Q?z0LofMJ2SBE/U5Biv9lmiwnGTSjjBIdiYR7o39lkwjpKwGl88PFH2IXfJekJ?=
 =?us-ascii?Q?/PUhagQAvpg8r3zwvKxlC4a/1q2JSM99jrP7iI/hu3GOdp3xeJupBkIQSzTf?=
 =?us-ascii?Q?b/jZe/ohHxQJEPsrYBf1J/4Q6f/ISkrqVz+SB1s3u581SQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40994357-fae1-4677-1f4f-08d8f8faa55b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 12:51:07.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWYk6wLIteLbVXtlWzdZLNznhVrVz517E6MvzUAMvW9QV/v3U5i3Pr/TE4fpAO65
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 12:23:49PM +0200, Gioh Kim wrote:

> It is a rebase error.
> Just in case, I copied the corrected patch below and also attached it.
> If you want me to send the patch again, please inform me.

Follow along on https://patchwork.kernel.org/project/linux-rdma/list/

If your patch isn't there you need to fix something and resend it

Jason
