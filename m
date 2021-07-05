Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338B93BC143
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhGEP4l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 11:56:41 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:17152
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231804AbhGEP4k (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Jul 2021 11:56:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrARZTJryEO4GUsExknbDMOsc9BbvbcSKyXCWLTN206rgyxwAbJCkpfDPqCMPms6IzlwVeyiuKHCgqgo7Q5aeY13eXAibYsRaKRwr1xDe1NYndH/7pkKrdrI/aCbkvYNPeQvjpxM6SWWnvs6JNNHocjpCDpju+bhPNYNgajKCCngFUIn4clZUcV/1Xvml2d6DTMeSvEIyMLF6S/OYA6iCuz1eUkNKbd5uRf4ispcVFS8C+mKnVcL/RmRc3zLQALa2yrnKy2vq830BDbNradtN8oQPus7y1lP6XWtWsrKfwK1xHrGykV1dXXanRS3UcvGdGZcUwAnj+tZLA6eOcJRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4TGTUO7VhaqfIfsFGVu0NQUsWs7pZTquAC7UIjEMB8=;
 b=Jfk+PVy+pN++PYVVq+utcB+vkp0IrX2LawHcXlWYn37N/jnjCiKfJVNIPTnMVJzgwsDyWp9vOhhmkY+oBvM2dpYSYFEB5cdGltHyV41x1q1FskUnjhdxk+Td/2Jvvbel3dlCnsB4ZbaaWh/imBX+yF9UennVSgmHV67ZacUICBlnbCG+UeBX1Yjwz0/JaaI8l0limMxeZztfCJakEucBrwiuFh9Y8VTCrVnYt0o+rTOyStNga2x4WKXjFVV/QlDamXvWzkgufH3T6CBPduKRMgJEz6u9LWBNfP75/HTzZFjoCFCn2msR2eqDI6xZjEXktxfNZXoPGD7qGcll+ET/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4TGTUO7VhaqfIfsFGVu0NQUsWs7pZTquAC7UIjEMB8=;
 b=URAT/WHvlLTv4cp6l4V6R1I9u8WdmsqGkI7p06v3GNJIkl6A+ae2YQOpNozhyGezyLzBKLNgJ1fZmBR58SaboamDKkqlwOGtqj0d4lkgCh78+Qy66/X1dbQNRnheTjwngwnUslNX1crlQ56bYBCRELq0U2c6JD8JreWnxomwJKn+wF4TpVfszc2lQo49ZN/hSoZfE+7LAud4fLxMMrNnj4rSEJNRCKYYYto9rLitlI6pevLkPyiEkonobfoYKP5DHh5u+tav7lvPgHq4VpZn8vm8a+QFFkV4poNXvP86/pkphV3Dh+4lqV8XEv0JHc/UpcHpe9T8PBK8vRdrfTt2Ew==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Mon, 5 Jul
 2021 15:54:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:54:01 +0000
Date:   Mon, 5 Jul 2021 12:54:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robert Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "haakon.brugge@oracle.com" <haakon.brugge@oracle.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory leak in error path code
Message-ID: <20210705155400.GO4459@nvidia.com>
References: <20210704223506.12795-1-rpearsonhpe@gmail.com>
 <CAD=hENeHRjL8YhjwWi-dnknFAJeDUyHK3s-TdQf2AF853MHCMw@mail.gmail.com>
 <E55ABD6F-18FB-44FE-B103-3403CFD21274@oracle.com>
 <CAD=hENfwA3xEuoQp0O4uxKqeG8-sJsUNOCpcCKNUtSgk_ezepg@mail.gmail.com>
 <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFc_bgagW37Z1dNw_3T7h4eQCKTwmJypAWdh5QhnzGNOLrEEZQ@mail.gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:2d::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 15:54:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0Qv2-003qm7-MK; Mon, 05 Jul 2021 12:54:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd7ab1b1-a37c-4e93-b9b6-08d93fcd1baf
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5539AD7E9043279EDF266C94C21C9@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1CVDTn6j8U9iNmTUv5ZJa+1OLWovh8hE0mNgvV8oePDSW4eKo72lQ57o/PH/d0l1zU5A0QiBAx3TbO1L4sUPtFreAJa8O0Xg/fF3ff2WEknWULqK5WZZlGUOEOfs3RGD5kNaDGBs2wI8AGTIeWSl0YqcR7Yh5N8iPJnqXjctPk/j7vmfSTUVg0nCREf5oSZqHNrbJajSXjlDLU6HzMkYcGezRWCBWRdPA7Pw1BYKmGYTY/ZmavQkcUzSopq77rOPIsKr0Sun8XoGPhDyFxl3vOouLWz+ZURCRKelWtzDJ/K6dy/sCZN6t43MLmxTyK66gefgD3nYQxk8h1/9Hi3rrY3ScI0w/JKx1IEeeRXWA5vNdmzYPXI29O6TE2nrz0aqdnnyL0T50jl8ayNheTnnaH1ijIaSj6Ad9VMAb+8PIhDjylUj4VUF+xDgwt+Lf8O9CAFE1lOWmcfq4acsbF3cqeBlaXrG4JcKOTv9C6FWRxgY8iZSjzu4t9W1hT+UeZAEprnqgn7om+vGqtVCPHnRd9FrVJdf/UYfCSctZ6mtKaeLCM5JMe4izIS5cMe+Go7h8hlo4v2Yc9Frz1IfgSteTFxjlz+XQx8ZKMvAN+FdwWP+1obbbmpruCnPLIK3bERWasPyyN7MTDRoMuk30pARg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(186003)(8936002)(26005)(478600001)(83380400001)(38100700002)(2616005)(66946007)(66476007)(9746002)(6916009)(9786002)(426003)(33656002)(8676002)(66556008)(2906002)(4326008)(5660300002)(4744005)(86362001)(1076003)(36756003)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f1xtrxSXkeH27u26ake1S0+NKJ9jw6CnBX7FdJUfTLpxzXcpCLQ+Y/XpPrLE?=
 =?us-ascii?Q?0mIoAgMc4ca259kW4S3/LdVOOZhsK1xkmR504pvh5h9sm7GMez2zaL9Uh9gJ?=
 =?us-ascii?Q?FdeVE2+3QJqXWneHq/ScRv7C3a55vEKmMoSJCmfpSxQC+X4jmPoS4xo1veEA?=
 =?us-ascii?Q?QeA9r0SAm/h4+G6cp2X80zMI4WFN8hI6KPK4vqH0SlWVhwvnb3AbEFXyfB78?=
 =?us-ascii?Q?lyucfGAoCf+Wwfdx9BLjoca/p14HptM5CjyGMcD7Eqx983AVoiP4EofjYnc4?=
 =?us-ascii?Q?6jt49DOQkPsXAdIj7LIXVNByNODCZb+Uu72rjJHLMd4bMEV28hNa5OiNXDga?=
 =?us-ascii?Q?7fFKn999bMJBUh1EYJjbY3wgBErsug8z/0lmyvoaIDDSA8ybEll4vX3iJ5rH?=
 =?us-ascii?Q?0fKb18SrM3ccUfOTcTStwJVSdHqKx8fOWlZtnFv6ggClB1pzYZYiO/er6+ly?=
 =?us-ascii?Q?tzeR2xmtJCTSpzQNhT3fTnQFBVCNFVNkZieWjfdZ58DI8mMoBXrklKwOAYZp?=
 =?us-ascii?Q?2/Edic5CZfwX73gp5B9RfWfRxJUxvEhEPIzi3drx80X7esIMGSLyvaN/W5AL?=
 =?us-ascii?Q?Ht5Vb42eVGtnJfSOZBdwxkPBMw+kr2yrONQsPwFn3elpP3uL0j0CnZGzQkHR?=
 =?us-ascii?Q?cvZ5KqPPRBozH0ueQAMJtN7IF4ugDe4m1diARfVZjuV0JChEwPpYNYnlJelz?=
 =?us-ascii?Q?2ILTBaBC0ARz8Ha8uY4r0ASs1lQpirNn6cQrWraiotFzFP6f2TnH9xAqHT+w?=
 =?us-ascii?Q?dsGKbMJBzwbHTUure41SrPQy6xs+LGzcyPh9nVbsN23dCdl9RkZ6LQ2aX7Qn?=
 =?us-ascii?Q?MSXfBm+jQtK0T+KVOcO9j38sXhKIyCP9TacLDCMsLlxu+CI4kDV3e3xY71F8?=
 =?us-ascii?Q?eav1xkRhdTzZxTP5rfMuzNuw3kM8mYS1gwWszD0QvungbiYb4wBZp6cKwSQc?=
 =?us-ascii?Q?Ah5KOB5S9qnBYAoWj1uOqEqKCzPuiE8fOc1A39lMK90W3G9eMYP1nLefw1f1?=
 =?us-ascii?Q?I/pTFAS954zMYtTfRk5JV8Fum0GsP2DnJwc8gbiO1KrYmgLiNZUAB5dWOEKj?=
 =?us-ascii?Q?1lERiLqPWSrVJz93DNLwIsys61nhGOWKB8K3r8lIDnvZFK7pQtn82fBm02xZ?=
 =?us-ascii?Q?ob8UMk7oiBNh9SC0flHVIWGc57aRMplcE34adECRpJrqkepPYu99H4Oc5e3Z?=
 =?us-ascii?Q?X6EVpgeMnXZsMFFHp+gB5lSifdmpXstTCtmhaD7wpBWGAWwfSk6NKM/ZWoCx?=
 =?us-ascii?Q?vf5ElGEbyTJSn3dTqsYfpttl4ls8qgfxqE9ZEbE/PmHMIMTq3x8WUPU8ouLk?=
 =?us-ascii?Q?HR95A61BvcvAGnx0hfg8d/N4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7ab1b1-a37c-4e93-b9b6-08d93fcd1baf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:54:01.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vk14KCkX3UQ02hE/OO4r0wRVY8d60Kux8W02Jdq/M7D9Bi+cfe5cPDP1l0MPeD/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 05, 2021 at 10:40:14AM -0500, Robert Pearson wrote:
> Jason has been asking for patches to pass clang-format-patch so I've
> been cleaning up the code near functional changes since it doesn't
> like extra spaces such as for vertical alignment.

don't mix things though, new code should be closer to the standard
style, but don't mix significant style cleanups with bug fixes

> If I could figure out how ib_umem_works there is a chance that it
> would fail if it couldn't map all the user space virtual memory into
> kernel virtual addresses. But so far I have failed. It's fairly
> complex.

It can fail for lots of reasons?

Jason
