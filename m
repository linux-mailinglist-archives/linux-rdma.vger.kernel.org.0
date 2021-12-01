Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37B7464F38
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Dec 2021 14:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349801AbhLAN61 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Dec 2021 08:58:27 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:51349
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243353AbhLAN60 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Dec 2021 08:58:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kinsR24i7E9wS5hQDorgUGRD9rSILb2A5Q+QRck115obDrERXw9BHmJ4piJeUbAwifj3wmX8HCG5Mjqp3Wlm/tx9cgFvs6fFHSjEg6toVbjnNMedrNE1eYvWU0VmvPlK16nVoT6VVxs032ZI92BY2UMLXVv3wP3BrACM9eyIbUYTyrKCv78It4LOngNfa53KndiH+R8Gm01Ib9+C0BxCXr6CkdsePccHnr4V0t/bFLUWysiv3lkXg0EFpD6LriUXqo4DmsaMjZ4fQ38wocGmEEajAv90+HL2iPaY0HDfBgz6tVjHNCXZ6IAGB1rhYHcWGsP0iFtgCG4W9s7eFkrx1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtxdcBr4WlS2ZYoZGeZ0n8XzRq0/vP4SK8YFptGzCU4=;
 b=OALK/0qoLFxcP5e5KFGtSH2TPFc8gwkZ6W5Ob7trq9A6evbUsHuMMjMFu6ocPr3xDeoEgp3U04f0jovZsgRwZa1/75d4kpKOVxpwgWaL394E/oyNHg3PJ2UjJkNSnqMFs2rxZbMCguaCMv7xdvydEj0x6j31eQRufQS8Zbwtwme7gqVmD8xLSlfPtGSK8X7UgQ7VTXwBE+JkNUdF2DNsR9VFDC8U6EKWCpXjU3m14ph69EdLPDIHQ/tph8wAYNAMOAZLrwU4QR3nXiRgffI+UyHJwO+pdnj6cjO8UJNgWk0Fmv7QQg/qRzDhLDro/U0Umc9PF8B5/ZD9SIQk3JpdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtxdcBr4WlS2ZYoZGeZ0n8XzRq0/vP4SK8YFptGzCU4=;
 b=aotOznKxYkKje+c1znNsWEox8L9dKGDdJ9IHycw0hzcsE9lqwKq2PDPiLGZBGCeUO/apTnMPReYmkO1/RPnO+VwcnJgHg0mkwbobYIH9QoKsEVwISPLN1XG3VtFVK9NMf93hr99//Y0rAiC52n3EPx9GHlxRo9Y0gDh5PLJBAFlZrJZ7AgNOndxPAPupCiqgFGUrp12Kz52Wjw6nzGolgShUxv4PYoiSeq8CL2GVUchyPkO0x2Ku1H3i+bINrMk4wOFvMCJe7Yb9xQabkSeEARauWrWmi9fXIVf9mvdmIKpXEpnYIzQvX9VuN5AHXB1zSfCcZyJmw4PsQo1Ien1FJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Wed, 1 Dec 2021 13:55:05 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::1569:38dd:26fb:bf87%8]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 13:55:05 +0000
Date:   Wed, 1 Dec 2021 09:55:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v4 10/13] RDMA/rxe: Prevent taking references to
 dead objects
Message-ID: <20211201135503.GK4670@nvidia.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
 <20211103050241.61293-11-rpearsonhpe@gmail.com>
 <20211119174537.GC2988708@nvidia.com>
 <9044234b-76b4-3c6a-6d85-dcfdcff240e9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9044234b-76b4-3c6a-6d85-dcfdcff240e9@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0013.prod.exchangelabs.com
 (2603:10b6:207:18::26) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0013.prod.exchangelabs.com (2603:10b6:207:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 13:55:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1msQ4d-006Fxs-8Z; Wed, 01 Dec 2021 09:55:03 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 504d6081-fd2c-4d61-69bc-08d9b4d22d3d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:
X-Microsoft-Antispam-PRVS: <DM4PR12MB53275DFEC34C42649D37AF1BC2689@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POgbS73ucOnnts268SUlfebvmPl+QhtQm5Og5msS/eQ2LBWGg4wMdLRrC5f/tNO0u96dTQpkvPtoIypg9P/4iCl6jqVwTFZweBXMYnXEyd2O0piQiWl0/vMJzyRYJ2M5jhp90XrRbN4wDSUZiwQ8t5/5S8xf4OU085aN/5HPCjObkUbl/UDDdBETL8BS79BtEHUB9gsXtN1xcxBuYcBafOep4p0lsYid6dUS/pLiUGTed70PC29y/JzKuVh/u8E1EjvX2iBNt1JWo0JrfoSeoneng7zn7UjBecLvEAjzuIMUZKRKPD2Q0vxyLokuHHiKwCrrZAovYtJ8HoOR6C7mk49iTGdp/uRtpGz3hcU5kr2yt7rsclQ2PtwN0d5sP3p3r3EZdza5YIYIdpQe7vZ6X0T0LwJxhDvsH8K6F+iRPEYWxU78AZYq8tVrZgxycsj7TsL6cSnISu5akej1DtmW3EI0RxbGnsp8w20SE7znvgybEDVxEqwSx81F3lvA9Ni0zx0VM9zBTMyxXJdnRR6ZGraOYbKeiPGfq2/uHO8HUmRLP/OknP6akLIWEM3wXiy7TJ7BcUXXKRn1/UhG7QF2pnkWTSlBWDRrBNjZddll3Mwbbu2Xrd5SyPkIxYuxPbYkmRQHg0lRYtIt0bjLNRnqvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(1076003)(9746002)(4744005)(66556008)(5660300002)(4326008)(6916009)(316002)(38100700002)(8936002)(66476007)(508600001)(9786002)(186003)(33656002)(426003)(2616005)(36756003)(8676002)(66946007)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqxPxd22zwx7hA4q1JqCpVsFXR0gc2COIxBsxBlECZyHPciZBiBmKpRH9jYT?=
 =?us-ascii?Q?Xi0oRNr6NKHML5sBqygCrLlfUjzv9ZMGIrCs3v9TOBdaWG75l4XKrzzH5CWu?=
 =?us-ascii?Q?kEXd0hOIuJzkF+m/IajMBrm4uYObOUP56TunJN1nje/ze9SUHPI0JUrujP+F?=
 =?us-ascii?Q?TgHmLEzeT7Tv7LvajBhd2bBfyslMtbde+fbwcUWnzAvXYg//vB4uKQdXvvyG?=
 =?us-ascii?Q?LQfPFSn316iMUbnOc+oA554mdDZ/o1oFvp9ggNz0/iSabyE5Ww7aMPxa8cjR?=
 =?us-ascii?Q?lrJaFjDVLmUEI1lu3bCNwuBbpIP44DrPerdp2IiA+8MkucsLHSkxVyfQ0YWd?=
 =?us-ascii?Q?ZTAtHukKns9pX83NmqlmOiQNgPnVhmJp3DmLprgoIVsZUcWlIIHGyTbIY8jI?=
 =?us-ascii?Q?Zn7nmZ/JmozPwrCgReto9XrE/0jjwT2y4pY2ZxrqjTy8D0OPDY6hXfwnfko6?=
 =?us-ascii?Q?E/buMRXCuhR3jdzpK6x8T0A78gvfr7HVdDQbRqDpafbclV4Q/Q3fNjj0t3px?=
 =?us-ascii?Q?2LEnP9rm7pG2HLLRpPFWEotJGgs9HcICR+x0KluVaz7/PbbR5Q1ZVt0quzio?=
 =?us-ascii?Q?fyKqPrdJgNOWzuRl2iAYLKDeugt9GbcQc523SO3k87gQWztM2cUeby3xir3R?=
 =?us-ascii?Q?n9ywlofHGYXjLFlR0pqv/b9M6B1T53Y9AaJpknZHJuvLBTZUjZMTjZHgnxgE?=
 =?us-ascii?Q?c8T1KfUoH+jXuOrM1v4U8CjXlg5zF8MJ3DAZjyAev27XuQoGhtsqRsYwBbHf?=
 =?us-ascii?Q?Y+dRqcWckoKUb+QOzngQdkJBQw4WrA+2HfX9Kk+Z/WmMjbOsSTPIO1oODcUa?=
 =?us-ascii?Q?wqVzDX3UUd60lEsYPlufbBrUuAwZA6j0axReGYygrZUQEyEeRA9AVWyuW3Px?=
 =?us-ascii?Q?WmssotmVl3Jywt9HRrnHb6mpQDl37lyhw1gvJLeXn0ATVi9+Vbb9hXvAd+iM?=
 =?us-ascii?Q?7wIn+nWMR6T0S/S5XrYRKel8RfJKjljnaRRx/VNQ668xhczEWhPFr+QqvQKu?=
 =?us-ascii?Q?6rLeky3RCCUmmcMAuSAkfwldyFA0DyjreGnEr6ycm8XvTybBEwCFD7qH0faC?=
 =?us-ascii?Q?Mz8n0abvh9ook5TN5z98tDVv0oyxId2VCJIZn6A6RVq0jr7lPhp6xY49BsUK?=
 =?us-ascii?Q?22BwU3+mUOkKnvZDDX/c4P8HV9FDNDgaRvvfS0s86dou9kWaZ1mOfjZbm15j?=
 =?us-ascii?Q?+/j5Zr5GwhIDqyy6sVbpMQXLM+UjZ4+gDeg7MqEqhwkUQkYhrVIvrsvdpggu?=
 =?us-ascii?Q?GAhTlTa/J2PEbm0+wH9eVGJa6x38rhPoHfwjOylztVhfJCakinmuoPO01Hi7?=
 =?us-ascii?Q?qAHL3Lyv4velYNOdilbomoTg6bZ5AhE8glz7Db/dugE0M7u8/SPMOr3/mBFR?=
 =?us-ascii?Q?fsGHZ6D5ttAUbjYZM+wJGo4tfLKJKqCBmokTXOW703atIY4ZRfxmUPPEbYio?=
 =?us-ascii?Q?3r6ETuJBKEptuN/P3fb078CfVJaLUh9S2z8uEXkhzdYV3GSq/k7IfCiQrsNU?=
 =?us-ascii?Q?o2l7/AEZFv/eS0tYBdUvusVOkzVvCGN3B8XqalQdjcGabJviihm5dIabNjkr?=
 =?us-ascii?Q?7VMrxCUh5W84pbmNpD0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504d6081-fd2c-4d61-69bc-08d9b4d22d3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 13:55:04.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEuTFI/HWipikvK9+fIoUIBOX++cNb9mJvpibCVJxIM5iaHgkhDgQkZPcnM57EzH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 30, 2021 at 02:05:03PM -0600, Bob Pearson wrote:

> let the driver sleep if there are currently active packets being processed with a mutex
> or semaphore. Additionally we need to cleanup some bad code that makes things not work as
> mentioned.

Drivers have to sleep in their destroy to fully fence any activity
related to the destroying object.

It can't keep operating the object after destroy returns, that is not
our semantic

Jason
