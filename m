Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1690941B25B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbhI1Oup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 10:50:45 -0400
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:29569
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241152AbhI1Oun (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 10:50:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3SxC95f2HwLkzQFoFlaN6f58B/qpsR2vfDFJQevFIUUpbT21Vwg2NUvlln1KpIxZBoMUq+2UNuYhyx5++V8jHXbeP/WfdEoQxe8VJEWpufbj/O7yrdjbJIzRN+uxIfczsAYbdCcyf6AuvRw3d1Ylxfi2TFXGTJsRlG24tn9saNKoNUKbT6DnM8Zo5Y1DJEDbDqLQ3tED2pimSq7vFURv7g3FX1t0v40l5JsZ+EIpnkPXB53DfHknTd7LpkmYW/k7iWAGCKw8qr7DjpRD9DPfX4eEQpioMpBrVHLXJG9e2v09ml5esuGN7rMfzmiWIOgwbM47RxT6gCGdhDmeJXmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OBkd3czlyMM5vtg6xmRXJFXqk1dc4ips4NIcEsZ7lhQ=;
 b=YROekv2ejzV7mlZFVtSiDQdx3bLR3Kyi0Ul0pzCXrcNuta6PTIIent8W/ETTDVN29rFQZP7hEYGOuEPu3N+EtzfLx7fP4o5/0kNdHjUqqA9snpo5sYBvCiKDg0A0dTGsvhS9+CSgMLSsAXezVPew07S7Sxf34PJvO8AtiStP+PGAs7tO5RtolDZAyyPHrO+aeGnQTpNd6Kel29O4SOFNH4yiK9FBw+8dkFUG4DaZN4kOQ0Ug598pZd8Y7TBb5jnpV/iNk0p4kgIbkX2JEJUhDcsKM6Yw8O6k2LD0v2xz7WPFynRp4O/zj64hdfM7zbKcMxXi/ep946bb/afvYewaCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBkd3czlyMM5vtg6xmRXJFXqk1dc4ips4NIcEsZ7lhQ=;
 b=jJggL9yOejXUxfWav2z9NMT3Fp8c/ri6iTQ7f7wXaUx2j5++PVNmjcR8ick98IrZfuQF/mJdU4xGHBZY+nBjRN2dP0RUjGoH8OSzhm8/lBJc4BEnJHVuceglvy7raeVukkqGwnayJleLl+QWmu4D3/xKXBrPg6BxlDb2nDTeW5+2fp8GEb2XkoiFlsveZ31qZorkWeggNTyALNJMX3lj/ONUt/r8EUzXkCoXXJiuS7lXQAcd7TWyQPbDIvxUiEZUQ5n+tvg93W608LM23Ah7X4HoJQa/sY+jxluIMlYUL3bS19icu5mqMiEEPMZYI3syuEzumKfkQd0iOLhaltjukg==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Tue, 28 Sep 2021 14:49:02 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 14:49:02 +0000
Date:   Tue, 28 Sep 2021 11:49:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Subject: Re: [PATCH 0/3] RDMA/rxe: Do some cleanup for macros
Message-ID: <20210928144900.GA1674272@nvidia.com>
References: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914080253.1145353-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:208:32e::19) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0134.namprd03.prod.outlook.com (2603:10b6:208:32e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 14:49:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVEPk-0071Z8-GE; Tue, 28 Sep 2021 11:49:00 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0396995-09e9-4596-39a3-08d9828f1c48
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5040FC17F94D2D94A2C54542C2A89@DM4PR12MB5040.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F8LFvWOqIRe5d2bYqsFDIiP6DMcg6jNlnR5ZQ7KM+Frulv+cmvVOvSFSps2w00Aac/ZZMVtxkpMOmSPeMln4VfQ+BIHN3VrboNoZ+9MBBprf9+fdyXvNCHFVdAh9cT1Q3K2CDlFYEzhnH4XYY3Zhli5dJT872mO7OPEm9aoNTNqZysRFHIF6WnsMOtODzqvK8R8/qQ0JBYwd9e60jafPl34SxrW7J+B8Tod8K2e2M19KOzwL6AoLgRfhbzwpYLQyB5lGFzV/9QATzPquMWhpB+L/09pd1Pb8aMUmgJtf50Z0S9qr/gpYFfpOhM1PUuxtQAHG8wFFGtDgC3hW6hYcjOm55KRHoWfPb7qwGfRrVnOWpoGsiuG/NZ1p+TnIlok8Q1kSdfGJoUmmFys3C4S5jUfL4n/yKmwZ/0Vv2OjWjtwsL7n1OE1aIGdAR0rL7Y8ksznRCyc5joSq7zQtO5fPFsxjh6LJawogYeX0gMh8dGOBLFBray0l9Xr3i0WAYvi28CkIti8L7ep97WyFbs2Ied0uuiZLvUJHrqD+61lWDHD+KS/cZjEDcPfQK8AR7KarwvOuxwSLBfwWmihbKjO4kJdR97HSbdhrfBt6wzqH9ZpaMxmVTJTN4WRejmTO9/UnKvlq2gkqj3wbtO7/kW0Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(508600001)(36756003)(2906002)(8936002)(5660300002)(316002)(66946007)(66556008)(83380400001)(1076003)(86362001)(26005)(6916009)(186003)(9786002)(9746002)(4326008)(4744005)(38100700002)(33656002)(8676002)(426003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7oBlgi3D/i7UONUAUB0CwS10erbnM6LphZTxAdK/kZjcasgaxdHFHL7fOi6?=
 =?us-ascii?Q?KAVcNbzjqw+QnJGOGYT7Y6/Cj4QjjNz0MRgfOA8AneK4lcuoe+Fg5THfCVRc?=
 =?us-ascii?Q?FmjY+xDfAKnTFEGNSLYLd3GfPQo6QoHEDwYGziq97nOvr+T0frTXuwMUsbx2?=
 =?us-ascii?Q?q0RjYFisHSBuHBWHVZ1d+VSmZAj6YAJYaiF7TPemkN6Fb3wVZ0BxZ/WxmZkp?=
 =?us-ascii?Q?IPJL52jR9h2PCL+Md4ZMYJtaCbYFaGSCGRs/tYgQFqSxMNXoo6ZQFp72B0bP?=
 =?us-ascii?Q?fSYjkk7M0z7x/wJqq+EpT9qhXsvrw8rHoRyJ7G4XVT51YaKGRTuonOVHmAxt?=
 =?us-ascii?Q?rW3bPGGtyYNzwPhVhoJ9fwcLuqqdZ8L7cPNzrTTaNk73nslXKOh/g5Y1Rr3C?=
 =?us-ascii?Q?8yOyuqPZf+WhLbkTxdRFLYWn4UYo1Hu2pwAAoGCO1jN0DwJ5694hyhuyJtYs?=
 =?us-ascii?Q?+QBeYlOuRY5ov2ggqOXQChfxPFRKeoWAZMZEQh5pf/BYdZedq0WuEpV/13oa?=
 =?us-ascii?Q?1HMbhnXOvBs16BSPyHeoM4wpC7bjpo2KNzohs/TB+Ff+yUNxYBXNzlhx3oIT?=
 =?us-ascii?Q?OOmuF0vcKHmkWFcDIxmEA2SXC70c4A/4f2y85Ua9w/ij5b/jU9u47SJKzwPk?=
 =?us-ascii?Q?BwRptUzk39HJFM18+aHA+WdLy+T0dDocjbK9t5WdYQE2AavJVDsAu8q/l14o?=
 =?us-ascii?Q?eXWKtDcjNQPKrmOctbpWOB/yWUn3XGSCMUSO4OwTsfRVVyv6EakXXb7KQYXP?=
 =?us-ascii?Q?0N6fc5E9zdeTo1RqgA1mgV7u/c6Uqnf/Gu2a/7Z2aAh3924OGDIe3YWcYBy/?=
 =?us-ascii?Q?7GVYvsqep6VtgioC7pDx3fCv/7A4WLBVeZT9p0ckVfTEFWyu5yXWz/M9eCZ7?=
 =?us-ascii?Q?IIM9u6sFiZV3IJ7SN2IGbI5eiNENcuom1JChEBVIfFnfIekgaXDiKOcr97mu?=
 =?us-ascii?Q?PN0hAJE2LsxnpBT4xuAy5nwADdLzWhgENyALVEdDTITskNU3+YYRjhqtJ/1t?=
 =?us-ascii?Q?Cbjgt2rO6a7mfVJ5ADW+8jy0IDnZjBS2Wy14SurmEbx269JX/1RGrpZw0goQ?=
 =?us-ascii?Q?o55V+SRW81rUfupmrBfYcMx6ZYDWbw44j5M1kh6C88M91Ufa/uR7hI/vPsst?=
 =?us-ascii?Q?61SzjMIencgvwlDIDYlqynvbBqRpqY4fHIYqWB8JkmbHaZQLx6fNKxjomqSp?=
 =?us-ascii?Q?7jf5ww0K3rzcynEJAei5uCvD2V+jznpuCkAYJ07ATEQwhF0b5VboMZqufvOi?=
 =?us-ascii?Q?rmmrRm2x9qb4jS/qQcXVoj3QV+RsDh3tmtOuPyQ0TCmcZESaR9MgGaGlwegI?=
 =?us-ascii?Q?F/Z4UcdHVfL41MdVgCf08W3X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0396995-09e9-4596-39a3-08d9828f1c48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 14:49:02.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CymLs4GKsvjQ0UoiJcrldxStWqcG0ESdO++2J0PEnMXl+/F/Qsp86Suu8gFGjsac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 04:02:50PM +0800, Xiao Yang wrote:
> Xiao Yang (3):
>   RDMA/rxe: Add new RXE_READ_OR_WRITE_MASK
>   RDMA/rxe: Add MASK suffix for RXE_READ_OR_ATOMIC and RXE_WRITE_OR_SEND
>   RDMA/rxe: Remove unused WR_READ_WRITE_OR_SEND_MASK
> 
>  drivers/infiniband/sw/rxe/rxe_opcode.h | 6 +++---
>  drivers/infiniband/sw/rxe/rxe_req.c    | 6 +++---
>  drivers/infiniband/sw/rxe/rxe_resp.c   | 6 +++---
>  3 files changed, 9 insertions(+), 9 deletions(-)

Applied to for-next, thanks

Jason
