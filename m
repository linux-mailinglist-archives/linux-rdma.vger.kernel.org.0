Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676313CBA8E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGPQcD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 12:32:03 -0400
Received: from mail-bn8nam08on2079.outbound.protection.outlook.com ([40.107.100.79]:51745
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229545AbhGPQcC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 12:32:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWLdEy8AM7Z91YVQOjXj4vQnc84OuZp8YyY8x4dOIFjykyhQ03baFBKk0X5bHxtNaPBWSqBeGvw2LgrA78ei69hwbxdVVH2+BkpzUor6Sccg+F4DXPzxYLzH3HO6mzQ4FoyeBqQhXVxb0GhH4BSxo8VIIsrY8hFM5cR5VbyK0xttGUEFojR4A7z52gPInxwgLM7ozcQMQS3CLyWQ+gZ0aTl2mI8A5snJ6X6TqvJWKPigkkA3GsKentBuP+LU3zzFFnLTEc7SImbit+eZFmTrnZrVnn8UCD+RoaJD8ePa/G7cuNtGrZuuvdA32/kGXa6SnNENlWucZWJo0JaUk5RcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUyjez1SpbvybzGvKP2LrFEP9Ez9P+l62dfoCd2PF4=;
 b=eflhnsvYtBOf9uSQPO7sf/4H2au2AI3yntvLNgA2u0ShZUYN5U1TG9d0l+iojW7YffMdLU9ukIv0dbUya2KP+8dIwSF2mrf7e9CN705Dg13+rQfF8YeSVvcAde1+jJIVerDCgqlNshXafsVCWeceGC+dttJWc2/06LfzpkIPUTxY/EOaNsLNjf7VCrKBqp5/4ZP/5BA0H56cD6eqBY07OQdlDHvcmISc6yx1M38oDbSKjp8f83+SBTSTMnHMHiqoCYGyP2SMzxKHkn3kI7F3nhSc+FH63ll5EzyBXaPWoAD35StI9EnhB3Eja8tkcT884MIyqDA/GSsm8t9VmRU1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AUyjez1SpbvybzGvKP2LrFEP9Ez9P+l62dfoCd2PF4=;
 b=OF7k99UHBpIf3sYRf/hbTfI1RaqS3T/R1bX+tp6lj0eXLwOh4Fp/h4AD4ZQQQedkwjNgyvcTqE/r9oJONrvj7RauSEhUVlnFYeJFfuj3esb/mPbN4nZRscCB8BoCRtTiz/8Mic5B1PB8zAhsTAQtHnADknv506bK2JHDzlhHTKkKlsULOa1G4oVALIgtecJXjng4jywhLd+bFu66d5aX0V+FMn1d11MmEumIgH4Mkk2XK1jWL9YvLEYUlmeKQviJJ8Swqsa2GSaWWmu3H64ce3rQyhy86xUL3wEhA1I+PBh081+AZ1v5kKJPx/0rZSYJclrDVLz9UPTRpWqNxytZFw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 16:29:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 16:29:06 +0000
Date:   Fri, 16 Jul 2021 13:29:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 4/9] RDMA/rxe: Move ICRC generation to a subroutine
Message-ID: <20210716162904.GL543781@nvidia.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
 <20210707040040.15434-5-rpearsonhpe@gmail.com>
 <20210716155759.GB759856@nvidia.com>
 <6a07ad6e-5167-9d71-e22b-94efb9b64401@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a07ad6e-5167-9d71-e22b-94efb9b64401@gmail.com>
X-ClientProxiedBy: MN2PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:c0::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:c0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Fri, 16 Jul 2021 16:29:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4Qi0-003CMh-Pb; Fri, 16 Jul 2021 13:29:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5cf2ec0-c4c0-4d45-fe53-08d94876d489
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5029DB8366ACA7F4BAE6A71EC2119@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFjGj9QAX1DJQGRdeeizVIc+44Z//HSZxRbBuH8aOCtqIy9YyhsDTCHyBhJxAt/2kRfHB3noka3GAofSpDiVbDPIkTW3vBnCBPFUBkwvWy1eFpEsZwYjD+59h10NGUnwAXuCppPjlfa+vWrDHW7JIICN1TISREYpwudbsaPMKzmsFL6wYF4AI5NpAN6d+qyxu/AUBrbjBr74JxItU0NEim07FDxXnc5hn2MMij4C9D/MVMFLomlgNGuCXhro4zaf+j+W8/Il6zdjdTZSrkt00m2yKvaAB7jEzHllf+BUIL9+ri5nuu7m9kDc58GZSQ798qYfltUxfY3ghoQfeeo3spGqZaJK2MWQHboXG7HbIQ3tA42qRgJ8Wl7PaZ/0+zUAujvG8Y58F6+qXIko6lZ1hzLKZEN1o0GkIYSKlZQPCy108jUWSCBOSrkkCz0eRovjomb9i161oHvCxx86vT4I8r/abSVQXVBv9kjEM8D+9y8XZjqEYLVUyyo78J8w9tv+T5lqeYeFHD8ZgHBfmOIiWzfnAw0mEUMPQgr6eZxm096sr1ymSBzy7PHaQsTTgwkFnCvHYDXIhkn2jObkFhUBKf27ZfzH3Q75yB4AFSZvEjqPvA2Tbod2Inu5yyRYYIUbOBQbGRi9KKl3J6BXTZ3b4imlEXLK/5SsJK9B7cTwj99sDUnuEZTm7NHz660UBAK/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(66946007)(426003)(6916009)(86362001)(508600001)(33656002)(316002)(9746002)(9786002)(66476007)(66556008)(53546011)(4326008)(36756003)(8676002)(2906002)(26005)(8936002)(2616005)(186003)(38100700002)(5660300002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EP/AlKq8k1rLDlGeOT4Qj/nUCJ3433egiliVjPQ6tZ7350imCzPUgIGWNmHs?=
 =?us-ascii?Q?dVU1OCnAsZbBPzB/uJoooaVO0huLHzgg6V3KRHbLf10PeK7/nKIELLlfdloe?=
 =?us-ascii?Q?WxfUxUPugljGkLhHOFNw/0mtreabyvpmiU5HQ7/Pf/03CoVt+SOqm2l2P3CY?=
 =?us-ascii?Q?zl8+RvRHT4dbFgPrzviSDbRHqq23BKbim94wCbtkg8CyY2V9JHJGcs2j7XNT?=
 =?us-ascii?Q?vvVYjops2xMTmJwr2Lw3MHLBVZKvt+X13DoZNcu0n1LNcz5ZHNj5B9mokKW6?=
 =?us-ascii?Q?bxrmnUMtSQ/bqdHTqdzindP3s7Okcu9E+Ho2bPm2Gd9l3zrS2CetEfY0wM6e?=
 =?us-ascii?Q?YCFMSgzvhwrAwJ7bYexbKi/t1nVMB4ML8igew6l1jMUAkJn0ACrpUyZArSkQ?=
 =?us-ascii?Q?hYWbZ8JPXoCpmKnpNftCXe6EnMpCCAbyeWgAUTXJzdaRsFe973YB089ESwdw?=
 =?us-ascii?Q?iihy5zzSL8PyDbc7ipVR2WeuSYWQ3LL43dOQ+/28o3p7ciyGT1cCZXlqlz4l?=
 =?us-ascii?Q?/sV4k95L36Zj7PZvFhyEGEJjurQYyY2n3wuBX9f3SG0EIT3bxDOrdVXdWHOQ?=
 =?us-ascii?Q?9qnpJDpnwlu2DSa/YbypY252Ajf2jVEG3dxZ1Fjhj6K9eH25Fz+El0bgcIlb?=
 =?us-ascii?Q?D+/EMNr+ekv6xvdC7Mdv0N5MkNjEdqhFBL01fr4fZwNGXXenNhXLwCPAeRn4?=
 =?us-ascii?Q?Et16TDZ5Z9gS5QcXorMri31bQEu4yz6g08tNpEIxVCKO4uPGK4AGfYkq3lv7?=
 =?us-ascii?Q?WBwCVF6qtNJmNjjirEThLKXXB/n/rigRMkxIFDf2wg64zg1OG2D5GA46bKPK?=
 =?us-ascii?Q?b9pWCAIr0Fl31/f30b6QV7iN3bQwfYNK5AhPEHoHKLbvEIGpC5MU2tQgYGl3?=
 =?us-ascii?Q?0D8jcEZZEOr9VIb+vRs5iBQvn0pE56ZcWM5z+AZGcIrOV0i9CWJfue8XMjLA?=
 =?us-ascii?Q?o0tSm9EGPkRoRuAI/WFIdR+SgWngv8c7TpXYYxf5suXsKrrhEzl4NWxVP1tB?=
 =?us-ascii?Q?JbSaonYdZGdh3E3eQ9wFgvh7dBKCLyWguW+/E/IXTAqSv92mpXNM4HSFnLtc?=
 =?us-ascii?Q?UYQlYMWATKBJnsiUYIBlsyzvnFtEOMMXng1vsGo+FbjOJVuKJuN1a/7OX91B?=
 =?us-ascii?Q?Zca74iWu+MYP3pGNSatefM4idTGEMWlUtpz+hQ9XTcRG+rYIh/5nCYCWlBbn?=
 =?us-ascii?Q?4lOBMfhi51xUB7wk4ocB33aUuiU+Z5I36C/JvfW7l35FW+TA4+BKYEdxYYz7?=
 =?us-ascii?Q?8B3B+f+K10eZ6PrVmAM1oNLbaCZ+gyM0PLZLk05iY6pgqF2oChn/yS53ZQVG?=
 =?us-ascii?Q?DhNPna35eD21xeA/STOPLcRi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cf2ec0-c4c0-4d45-fe53-08d94876d489
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:29:06.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytXepRxdSegJ6Zw2rmG5jqYRZBeA8/e14qGVyob29ATGaDhR7rrZJQeY3priXUjP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 16, 2021 at 11:08:42AM -0500, Bob Pearson wrote:
> On 7/16/21 10:57 AM, Jason Gunthorpe wrote:
> > On Tue, Jul 06, 2021 at 11:00:36PM -0500, Bob Pearson wrote:
> > 
> >> +/* rxe_icrc_generate- compute ICRC for a packet. */
> >> +void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
> >> +{
> >> +	__be32 *icrcp;
> >> +	u32 icrc;
> >> +
> >> +	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
> >> +	icrc = rxe_icrc_hdr(pkt, skb);
> >> +	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
> >> +				payload_size(pkt) + bth_pad(pkt));
> >> +	*icrcp = (__force __be32)~icrc;
> >> +}
> > 
> > Same comment here, the u32 icrc should be a  __be32 because that is
> > what rxe_crc32 returns, no force
> > 
> > Jason
> > 
> 
> I agree. The last patch in the series tries to make sense of the byte order.
> Here I was trying to take baby steps and just move the code without changing anything.
> It makes the thing easier for Zhu to review because no logic changed just where the code is.
> However as you point out it doesn't really make sense on the face of it. There isn't any
> really good resolution because both the hardware and software versions of the crc32 calculation
> are clearly labeled __le but they are stuffed into the ICRC which is clearly identified as __be.
> The problem is that it works i.e. interoperates with ConnectX. I would love a conversation with one
> of the IBA architects to resolve this.

CRC's are complicated. There are 2 ways to feed the bits into the
LSFR (left or right) and at least 4 ways to represent the output.

Depending on how you design the LSFR and the algorithm you inherently
get one of the combinations.

Since rxe is using crc_le, and works, it is somehow setup that the
input bits are in the right order but the output is reversed. So

  cpu_to_be32(byteswap(crc_le()))

Looks like the right equation.

On LE two byteswaps cancel and you an get away with naked casting. On
BE it looks like a swap will be missing?

SHASH adds an additional cpu_to_le32() hidden inside the crypto
code. That would make the expected sequence this:

  cpu_to_be32(byteswap(le32_to_cpu(cpu_to_le32(crc_le32())))

Now things look better. It is confusing because the bytes output by
the SHASH are called "LE", and for some versions of the crc32 they may
be, however for IBTA this memory is in what we'd call BE layout. So
just casting the memory image above to BE is always fine.

The above will generate 0 swaps on LE and 1 swap on BE, vs no swaps on
BE for the naked crc32_le() call.

Most likely this confusion is a defect in the design of the CRC that
is being papered over by swaps.

You'd have to get out a qemu running a be PPC/ARM to check it out
properly, but looks to me like the shash is working, the naked
crc32_le is missing a swap, and loading the initial non-zero/non-FF
constants is missing a swap.

Jason
