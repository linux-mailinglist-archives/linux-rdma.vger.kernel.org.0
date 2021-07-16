Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5686D3CBA31
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 17:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhGPQA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 12:00:57 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:31136
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236232AbhGPQA5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 12:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZuHrgL6jvOPwjE8DaQ6xreIDODrwgO7SyYrIKcg847Mn9bW6IAJU1UNgoutg2S+d9+Mm5IfUhzq4JspIEwQIzn22JYeFCLqmNudbM7ee2y0y9NRJq5/WtQZf0hZFzQuyJpHYDhEx7L/ihFN+VDu7qfbowP0Sd0TpHh5SXHFTPdjJtEhXFwpEbY8JQM7+omKS69LrSn3Fn0Be8FGdLKlw8gDEeVVZx+gPHusz5p8ZJVnc3LdE7K6p+H6JMMyAZV/+j50qsa0tTTsDfnjA42F+d4BAqL4zXpDj1l7q0K8tf68upo42KKkvUQPeNAqoUwhNnA13XOZeTaf+lTozjBgcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXCpBVfh8v5zDZKjXk6gZEsiDoogUgzXV3ZmH9j3dpI=;
 b=hXX8fxl2AlhtRSkAAYc6cte4sppTC/5VB9/9emviByVfDL/a8usu4vqC/D+x8GELBGWk6v/uTxnnV/+BxLt/I6sXpTd1Kpd1mcALg3ztqtHXavR7PjBNWffU7/Fku3vCoQhS+Vfw4uMqdjIwpH+le85Jr+CUtEEoqQbVPbxr134MzDbz7+1vchz1iDAiDh3sYH74uBe7g4vRWcLQ6lB/rJmDSmmW4uPbnGu/0Jg0L93+3M04XotWfzlckywOK/QcHcdQzDhqEApOcCSvNtg6TjBTl8/HUyKcxJNQ+oisbtlTdl87Acv/HUtKHdjWI/9RmxYA+GKeudEfPQ0rZ8xzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXCpBVfh8v5zDZKjXk6gZEsiDoogUgzXV3ZmH9j3dpI=;
 b=bD8kZaCqcHghlWBXQtHxobhb0Um04oqNOjDH7NTr/IeMLq8miPBjYlp5iusENRsKL2oxeReVLfaAtst4Lh+JohtOy2dEaxXNUlkQALul5Xd5uWDpAhoDg0AcsKP3KfAzccCM9Zf1OE84ymrZpE8KbZVhQBZpBumumg8ghybIrOIPHPvelMedwt8781EZXG+7etmG8iJkOhXf6OSVenwmk9p/AU+xUfrfrqrYFpEHKtKLpiXGc8d3hOhWmcLsUOzrjlCcUuR3dfsU8Cp/E3s5EMlomFE6WQQkHIx74EbSUKSZn98ONnlnq5ueSi60xy6i7BM4YMlifORx2uex9r/rNw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 15:58:01 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 15:58:01 +0000
Date:   Fri, 16 Jul 2021 12:57:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine
Message-ID: <20210716155759.GB759856@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707040040.15434-5-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:256::18) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.13 via Frontend Transport; Fri, 16 Jul 2021 15:57:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4QDv-003Bqn-2k; Fri, 16 Jul 2021 12:57:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910f574f-a25c-4050-24e8-08d948727c5e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5110D6CF0524976662B700A8C2119@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAvRglorMDnBhk+ARWTQy1ZPV7SY+ZqoNDsLYna2NYGCFngYsTckoSliYbl1a18ZwiVYXQgcWllyqRNBtr3PcbwwY+b4PZAGZGE8220arEWrgB6I/AzLSOArbG7FNU2g08Ytdbn5J+xAmlkr1f3IPwO3/Dbg6Ln6MD1r6bT7Km7IrGjcEM8VlfiXXEOrWsFEPhCBFBB/Ds1xRasSENtxaKmlGIHOlohRKS0abZDcbstRzN8BK0tGOhetHov4+tjfKRLEJDsis8JDjMN0OUECvH+X5VlVH+zCCWkZbTbYWJ17r8/oorRWv7nmxaDk8FhWgNyisK9k1EkfYS/7LMEtLlEHgR3fmyjo+xG5S2nODfKRlzbU1TeOYdhPQGynyn7YGMRty1vJ1n7Sd76GWeK6ZIqVtwB6e/hOl7UJCPMGMu1X1fWBLZqic8LIbdTwoeYJR4RteI+Wna4PbHRDrmAcXbv0x41TKLqXtRv+y8U7zb69pP0uGzpubpcrs2Z34zMHrUQ7BZNoaNp7T4fv9wNWq9pdtIiZ6JSgkQ0grBur3bZAj8vVcSqHRjhFJI73dJL0Lbm0FDLYn+A0/D3eoGRQfQpZe3dgW/lLHkaVy687Gw+5+XW3Q4Xry7KVqxGsbcNv0nu2OA+eaxSSbPDBroYcUABgG4VzdxOa087mDyOF3qaVy011mTzB9HnS5oM2hcOUE6f7tEwz5NfhJLnp/TOhjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(1076003)(4744005)(9746002)(316002)(8676002)(8936002)(2906002)(478600001)(4326008)(2616005)(38100700002)(9786002)(26005)(426003)(186003)(86362001)(66946007)(66476007)(66556008)(6916009)(33656002)(5660300002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oFfa1LPm3CcbXuA2OK3DkNg7OBhJPp6gpoSrqEIMZvuJE7CHEUjExhbL9n9G?=
 =?us-ascii?Q?H0h6nhlFLXemgJrjry9zGSK+eNH+5tfjpSAqqwTQRBkXbaH+8sz3T/3jWZ85?=
 =?us-ascii?Q?TfPOsJMgDqclQ9OISqJUuqFQVcnYg3/HURfqjii6kinsloStUb013I7r6rlW?=
 =?us-ascii?Q?gwrXB9H+HRMBowzXn3UE5a/r4nYgtpPnsmyeyuILOqhXpgtXDg1cuD7Cu3LX?=
 =?us-ascii?Q?157FZPCWSRvY/MB+u/jF2W9IrqALagD6vQAsZxyB23rMva946EmR+6hPx8iS?=
 =?us-ascii?Q?+Fd/UJ1X8/q5VlxILXMwcP2Kha8QDVATo0GtDFpTQbjyzn9VQzBo0+qbJYhI?=
 =?us-ascii?Q?Jlk3YzRS/Jdx08v31HPEIon/pNqIdp6btc88ZeGn4UzFk9CChS2L3uS+ihvY?=
 =?us-ascii?Q?BhF/8PMH/Qw+gDlYKY72ghZt8lbeScObFPVdXdWl9XQd5mr0DtIo58JkL/Y6?=
 =?us-ascii?Q?pwEwli0P80KkPaJKq11wvTySUBL4k3N5BVZFU4jnJqY9QObDNa76c9k8eIja?=
 =?us-ascii?Q?gYVkkuPpdszkKm9Wh1lpMPAAOhgbxbDpRF2MIL/9hEW9njtsjLi1fClhwreS?=
 =?us-ascii?Q?l96QnTFfOZwXNouPb1/37OpbwZdeot+X4RwTeUjZp73OC2MCFrR3ItdWJWcc?=
 =?us-ascii?Q?oBJibCyzcbB1ED6xj11Ng/shelkjAGs4C2oMODqibfkCNLHvueFO1ZvUPkf8?=
 =?us-ascii?Q?+rKZUO0xv9i5OuZaIEZr3/XWWD+omCbi0FLojo5OIq7tdpetqmk/DtNmX6+m?=
 =?us-ascii?Q?DOSqyNP8gK0HYNtlOL4GWk5tCJjRQWHC6usmnLYGcGkkkK6e4Z9JC/LgS+6t?=
 =?us-ascii?Q?OQ0Q0APIaD5T14VjgvlehIBOTHYmKxlcQtQagh5QnvEttXmJ5f5jLpwYYnq8?=
 =?us-ascii?Q?naLCjKjJ5vkg6R28wXKxezzUHjiz1hhhEmPuOwg+NchrkUoTRdlN4FkKJV3W?=
 =?us-ascii?Q?meQdbhQiVldyA0MN/RrGzvQn3xOtL9JzbC1BC/uCrA5xbiLACh6aHj8wJZRm?=
 =?us-ascii?Q?u4WZbEKC8Cc9xvNi2AXcB03RwdPO1z6ysOEzAUDKdAcn3Mdf0xGlTtpK12EK?=
 =?us-ascii?Q?b+l0RSNz8l1nEd6AydH+UXF3PFeOm0wV3AnIAA5dJJlN7EJu7mV0BNjfxR53?=
 =?us-ascii?Q?9z9T/Ve4P8L9zGM+vwCR9d2LNI16h84ZM6fYdaausOh+teK4qxnkXaZdQVns?=
 =?us-ascii?Q?v9iev94uaRwMX5XQo2ovlyl5jkMj4Hg9xc0itgarol4wi5VyQlVvw8pTH8xm?=
 =?us-ascii?Q?Ui6/HjYlHGpDIl01SwLiHU9f1r/6kksxa6FgYJkOLwNatrbbA1Y+5nfalzjW?=
 =?us-ascii?Q?FyIQln8Poh/Gjzz/vo6X+atE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910f574f-a25c-4050-24e8-08d948727c5e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:58:01.2774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di7oT5Qc3PCl/3+PmF0kJU0Re/y7/qP5g34Xju1ySY1d1DXwYNIh19aA8r+uptaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 11:00:36PM -0500, Bob Pearson wrote:

> +/* rxe_icrc_generate- compute ICRC for a packet. */
> +void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> +{
> +	__be32 *icrcp;
> +	u32 icrc;
> +
> +	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> +	icrc = rxe_icrc_hdr(pkt, skb);
> +	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> +				payload_size(pkt) + bth_pad(pkt));
> +	*icrcp = (__force __be32)~icrc;
> +}

Same comment here, the u32 icrc should be a  __be32 because that is
what rxe_crc32 returns, no force

Jason
