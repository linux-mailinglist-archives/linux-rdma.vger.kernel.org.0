Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF1A432A32
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 01:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJRXSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Oct 2021 19:18:40 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:29472
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233389AbhJRXSj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Oct 2021 19:18:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnnvL9CByYz62cMLRSnZ39tHdoMYoyDNpuqtYDanwljIQ+Ey53py0obuVZBt450e37bGGBVNnd+VPfAQxDmpmTgA/vluJh3uccA2xi+4RKMQTtedfleKt7xy8Hfv/Vv02Ij8jwE1CUqpaZUH+8qiLe9KwBwECcymOjaIsfUFKbkmMQPWH4Y9P5RkSEmUXpKbySdyS0lKlsg6eN3X7nYRJT56LPyelLM65H6iJ3dYuPKG3Pf8W+pt6l6IzS+sgEtwKIxsHDDU1nRLMjOg9KaY9Ltp+6wF03u36OJpqgW+bQ2w8+egeX3WKTituJa0BqA27KViXNAmT102ZpwOBelAYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYEuwx0IzZMRdOM8r6VZFKtjeCGLAm2GMpxXM3X/udY=;
 b=DeUUC+R8cKt8QYjOwDnunpmLoBmsXqNcV/km6MC/LECjb59fyVYlVJGV92dGkYwD96MKq4z+Lv2Vyr9RF/srPXCPBe/ffLJuh4khJ4hWaDQVlawezDj9XGubj+P2nOon2sK38nUDzJnDkH/WcpLDxc5namSdqaS3mtD3a6hqy5ENhMkMTbcftr3Cde9xWuQoMxJL9mgF+Uh732qdXSP+fQeaiFEX9/QjsmNOoSPf6vn9M9c/MZ4HR1HMsXt7C3BEBIuEBy2f1qGeYpFLB159qKECN6j6LvFsh6ogeD5m6YE8GMC9TBpUFEOVx9MWcb8q8yREDpUrniwl739tVcNrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYEuwx0IzZMRdOM8r6VZFKtjeCGLAm2GMpxXM3X/udY=;
 b=lSwx5WolfskQl1DD60H4xsM9rzdH2qqIgRpedl4nf7qlidi7BM/CfTvrjz43QUMSaujFiZUlBJX3/mL7QUVWFw/0HOEoNyl6QcCk5LE10EkbtXmzFpHHRgo1APfhlwXe+MQ4czUy/k9wch4PgtSWDHXO3y2j2HIwrSKCfCvE/oplev93iW2yIRjyu6E3suRJqoqDPycRUL9JjDSuaA1jiWRUdevOjy5Br4UYmE/9I3PY1LUzGips83t0VhwtYFgx6aaf657eqgNdxlsYT2/3nkgVKoVPjJ7sKfshOc4WH1iTlLWMNtFiJs5tPi4/xSXaegZ0Ulvjy9EMsjrdF4PTWQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 23:16:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 23:16:26 +0000
Date:   Mon, 18 Oct 2021 20:16:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Cc:     PavelPasha.Shamis@arm.com
Subject: UCF Workshop call for papers
Message-ID: <20211018231625.GA3936147@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 23:16:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mcbrl-00GXC8-5d; Mon, 18 Oct 2021 20:16:25 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d48e7d3f-cf69-437c-79ce-08d9928d4ee0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5361C07A0D73534C1478FC10C2BC9@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wEWTUr4I6+ClGn1F2TQvR6HUXpFRzjgy3iU9ngRx/FBuCgssDu4x3I3lc9rqkgaiJCL1KYaqU9KNQGX30JgRWauZXPZn/o/zgTItmr09OKx83+2HYRCDSqI5lEwuGU9Vy53g2qjYlZxmtn7942KxkmII4xiMHo3+DaPUPep2vhMSy58yIcQTzPXUcmsGzs1QquUxu9FKUD4UdDwv9d4Zl4zKpoKdwcZ2kPxRb9DPgIo55cKzBHqfBfvh02YB7RThA9Hudzt8g1vIkSz3JU0pwDROratM2PWnwfFVA18PMM/vfAZ6chFBowDh+WSHMmUKDpS+opeC+snj0uvNiZ9zf3VVcfftYq68wp/o2ZJ9F6izbWJuEMF+iR0b2xoffbb86zMarvJURVqqUza0X4KD/HkMeJPzNhHcezSd70SvOAsDxP+ZbHyXiehMk1IqNninP8bgcnsAmz3aQ92oSiJg6KrQlSpXl2aDTKAz5ZyFdrvubgIOk4ND8COR2tRXs3MWB8j2wsg9CjhTLYge9ccJGlznbPv0OMePtolKsRcGsIgNCkRMG8V+eKDE5Mvl5yO5M/ub/JtV9Hdr4tNbcKNrQkmFafdyvpIDLxJ1UfHFMmC+fPMtXzT3pSk/Z9l21I3P0T1ia02DL07lzL54lu1MVpwavzQrkgTCPD41yR1ijnmKKcUDR9TBMPRs4Qnf/IQiZxK5dj7YtPUX2Fz7F8MGE+UuezptXj5behUZLlGk4lS4PLT2uGcHSammwV1DX8DpaQcy1UjVwx3QVwLdejWnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(38100700002)(508600001)(966005)(2616005)(2906002)(66556008)(66476007)(9746002)(9786002)(426003)(36756003)(8936002)(1076003)(26005)(33656002)(66946007)(186003)(5660300002)(86362001)(4744005)(316002)(4326008)(8676002)(225293001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NFpXpN8YwsLbw/JciplLGZIyl+kG6qLuacuxjyOvPgRQnIXR9qTPIPncgdmq?=
 =?us-ascii?Q?GiSZD94TatOsE6xMNhmJMPXsqhij93KIVs+g7S/kLAnBy2/UFfg9u4onX7sH?=
 =?us-ascii?Q?s+TJXHhDcUcp/91uAVY6UycAIEP4m2ArW4k4GQOKVhW7SV0QXPo1YBcWj08N?=
 =?us-ascii?Q?emAFKGmQ8MOc4pKsAXKpcd9jKT/4rsQnz5i9XvEugxmbRIknceHRniN3RaZX?=
 =?us-ascii?Q?9KoMF6Pu2PrOrbK4xBuuMi/A5SYaS9pGBdaR2vxypU9hKOQk1QKJXKeynM5o?=
 =?us-ascii?Q?43zZwdEto5emVqbLFqmNriRCS4zbtHEQhG/WdYo2ipvVwV+arnouAfpGAkO0?=
 =?us-ascii?Q?QEtGOsxM5/loj/37xt3vWiwaQaR9BdzohAcGIJLYpBkxSrqLN5RFeFzBRv3Y?=
 =?us-ascii?Q?L+ARMcf69zEtH3wCYqTx4skHswGspr4nTzkymG8MuDSIFpZMvYJqRqEheQfT?=
 =?us-ascii?Q?X7knoVXtwyUKAhrGuprYGrtEPOC56md0lgDjElXgzphs631L4E2eztgo7Y/t?=
 =?us-ascii?Q?wprJgSIL87yNlhxWNGX/9CRnwkVhnXKyZMYQcau3O8xVIs/uUFMcW/mgTor9?=
 =?us-ascii?Q?SdKxI5aB9yt3gMftGEapnOihboW034O4Y7iwtroPPPE1+78w6S6XyF4MSp6H?=
 =?us-ascii?Q?zcC67ocHhiY5eGaJdqpE6KmYOwFukDuUzbqC10yUHFzQRgHVSdO8/EsJPh/W?=
 =?us-ascii?Q?J86ZklZgq1wptnMnvL5uXbpmT3P6xE6EAGwnKoOEkVxCsi9zjUzkQ2e5DJDc?=
 =?us-ascii?Q?b4ZevNnju2mAKA+eg+wewU4gTgxyzVM0Oq3bjRz5Xuek/9q22nzZEonDLDxS?=
 =?us-ascii?Q?a9TByhmkYq6Gtthoc6Tj0+T7Uzih2rgZ+0m1jKNyomZWbZ/Db+3tTfwhhvDw?=
 =?us-ascii?Q?M6m+TluOK5S2KwljfVc4sHOJYAS3P4qmaEh8yDw+Hi8j5r5pyfFnLA1jfxCB?=
 =?us-ascii?Q?F/T4hMt5vWkq04D3YaSLibmAqPrKiL/NV7NNDxwarozDPyy8lFOhidfc9g+T?=
 =?us-ascii?Q?8JbmD0RRjsRZEzd0zdCnAGYFI7ZfCSIDzALa2jPzfCAhMwTd5NKGlsk6ZoQx?=
 =?us-ascii?Q?M7iJmodUuZkbVfogOo21uOjz+9WNkE8SkPwgPYuEJwUfIrNe/mavyFv9IBGM?=
 =?us-ascii?Q?sPTCcZfR+fnzrMwtwQmCkY/h0FTC3vz8fTCS/D2A3rRA3KkiYPiZlkfh6R0X?=
 =?us-ascii?Q?3ayenUnf+xwLnz0k6H5ah2cQw086L3JZqbvhSAs8PFUMvkETwE/O3M2bMKKQ?=
 =?us-ascii?Q?Fk4lePO0CmpetaJ+LaftJJpgV81SmO8Ojb2uWDsWnpaGHdEB6bmgoNIbBx20?=
 =?us-ascii?Q?FaTJxXv+N271emGjBltthc+u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48e7d3f-cf69-437c-79ce-08d9928d4ee0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 23:16:26.3353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lT3rBnWxmCJWlO9YtnL3S+Ranm9V7rl3nVnv14HMTbOegVdVMbzEe5c+bJbXngOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Everyone,

The UCF Conference organizing committee is soliciting papers for this
year's conference:

https://ucfconsortium.org/annual-meeting/annual-meeting-2021/

This conference focuses on HPC middle-ware that typically includes RDMA
technologies with a theme around libucx and its ecosystem.

Please contact them directly if interested.

Jason
