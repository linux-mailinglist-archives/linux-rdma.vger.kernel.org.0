Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A1A565736
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiGDNbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 09:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiGDNbZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 09:31:25 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9812610;
        Mon,  4 Jul 2022 06:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhPwTk2nuJdOym3HL1WBtQNOWJaGhHm5/K4CSQgkII01+lj41UiW8t/hqlgaYfWXbHUh081vO5iKJXLu5lw7QsfNsv+T6dYF9nshICRpIu0I048YTXu2EpAI0bWAF2qhyeB77tfWKFnzXkY/DQMDreVh7q08L2mNcDFLR8Ps9mun3SV/GJPnnXKO0VsfXjuSS/p4wxs2rgxvDNfdrao1YlDsfPbsU7YyJylOzpCOxMwlpJ+kB7S47DzbFyTBGUbVqhI1rKS2o6uaBZRedcOeLhsUhPpGI03joYpOHfpXR0AnHR1R3fKSpTn0GrRYOJUi3Mz0WmTssc0xxZ4opd/GRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAgB+i01iAhpB6aqbybU0guWJyIobvnjpdq6YDJxw5k=;
 b=LYOnvS0C+JIcFds/7pGGMLHkmsmLjxDRsvmw4VFyZA1HRiDXLUxN0ou2l25SemnleQ6XH3uq+Y7vblik83QazVNNyrGfw4VonxqsurORkdKHAg454RVWzKhTNXizYZZs/JhDU4fS7kysawAf1VgTwfHxpGcuuxQKy2tyx7nLQT//pBAzBzl1PoAb7CnXC4gkQrhvHzptc17OOrh5sOSXPz2Z0Ejo1xLc1k1q99mDS71mOoDca6ugTDX8yUAEI5tscnS89bzJFJscUJ9dU6EVHerdIvpxXyCQlVGElXAu8ccOjmB3ldqST4iv+Z14Xv3docmMi/X97AcGNmGTb9z9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAgB+i01iAhpB6aqbybU0guWJyIobvnjpdq6YDJxw5k=;
 b=KHtMmFihhQZgaI7gO/u8oYfN22zRkMkBSIUuVTfzSJCh+iqmFa7M76KXm8reXSzH8EzBZRKbXmbs4DWI/tdVWSWLBkzsDLSw6sBt/d5P7UpB9stDoRkgT0h0yq+jpjs11DD++yQ4rtKibAWTeYUjos2YpvAehjnLa0xRwe5b64+6Jp+Vgm5ZkKUNCDtw2p+3jWCTWsr1HwOMwJRiDi3yHYdP2zKNV60rSMzRfVRkaj3dVYSnqEnonWCFCgxFNPp6V/MSl2pp3dP0JqSDBnuSZGBRQe7pY7SElmQJasyaBkIsvuWpflkZ5uR4qM31FlTe7AAR6WunRLrNkS65/rgr7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3614.namprd12.prod.outlook.com (2603:10b6:208:c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:26:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:26:24 +0000
Date:   Mon, 4 Jul 2022 10:26:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com,
        aharonl@nvidia.com, leon@kernel.org, tom@talpey.com,
        tomasz.gromadzki@intel.com, linux-kernel@vger.kernel.org,
        mbloch@nvidia.com, liangwenpeng@huawei.com, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, rpearsonhpe@gmail.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH v3 0/7] RDMA/rxe: Add RDMA FLUSH operation
Message-ID: <20220704132623.GA1420657@nvidia.com>
References: <20220315101845.4166983-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315101845.4166983-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: BL0PR0102CA0009.prod.exchangelabs.com
 (2603:10b6:207:18::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bef4fb69-073e-48dd-a9ef-08da5dc0cab0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDf1xNCRcyJAIWaDqIox3AuT+7L/IwTgjR+hwTtmzizoyW/RFogEsmDbBsJUUOrmB4XJjGJah7L4HtOBRDjQk0Cg9jVx6F6qAqZhCQCmT/noHvupTFdT1lE5Do0uBfX2OrG3naOMwV6PDfgjbQPZJD15tQbHhfg5dsUDeGQLN13JM2TDNil5I/RAV75Jedt0+4EV1Rm5Lk67N92XDRRQzk4h6AcyOe+WZ0wy/ZHxJvFfbutzOke+aV/cvD549Z3girEq2Z8ePsiwOQGC2YAkVv7pOAaBjizhXbB+RFzfppL7rTjkT6YdSnzb0axWQpBqpdUxGBm0IM96ZcTak0Xc9MB9quEbt0JePiHpVkEMX4p+JQ51FFJjKYQ9L9ZrtAwGZkAOFWEjNtafzuKCsa+omKPVRvybOmToL2pAG04DCGatoCAXeXzWWEt46C7fci1YW4Q37Q5Kxeb+JFN8cAEgzJsyXSYR5iLdSfYEPEmRfcLF5QnGgprDMUN3tw19LKWqhGVdC+FShdcSOibct7hSO+6HUNq/z18Bm2nmcWvvu7BUmBY3t+K2SgkKbWJAYDbmTakZjPCkhXRb1LMxQM0TcDLqKr4DErm5u37LDDB0kta1FPDdXWvFhxIJUJYBO8ylcC3OfYZcFs3nG+bXaDo6UntsIC4iM21oyTVg3xmXRy/RIIKR6h/v3BxuCgpq9t/IHCoSOQg66lcAKligzWD2AyKshHIl0bEbkgkRaDnSMmcbpKZ+hyDaEhFq1b/dRG8SY8DKtMHGwn6tBY0Pq9ReLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(83380400001)(186003)(1076003)(36756003)(41300700001)(38100700002)(66946007)(316002)(6916009)(478600001)(6486002)(66476007)(6512007)(2616005)(86362001)(8676002)(6506007)(8936002)(4326008)(2906002)(5660300002)(66556008)(7416002)(26005)(4744005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?79B2/iS72cwRX+FNHGB7AnZfpI1G6E/BWDYd8XWkdS8Rllk0C5aM3sNiTVYg?=
 =?us-ascii?Q?UImZDMeJboy5JVrUNKenjnbW59sXdwIA3tMXEYznanAkswlf+FnRc1lacqbc?=
 =?us-ascii?Q?yupCh4I9N+sIzV1GPD9SLpvR9IVFSo2Aiz2UbYkkS4kPasCxniakeL40bB7F?=
 =?us-ascii?Q?mKCo8osz8Rton4q9WQ1wvs7WkXdphSEwhu3H0ARtFhA54ZN7BImYpdi3l0hi?=
 =?us-ascii?Q?AJt+sw9nf+KvI2OoW5BRcH1DiZkerzqv31Fg3wrmcGZ8JYf2EXfkY7ckFWaU?=
 =?us-ascii?Q?xuF71S2E9NQQtx+UChTf/nsqJL6jeE6Fhu/X73xr0cVNVWGz6QmcOl+gFzp4?=
 =?us-ascii?Q?LjP3cqysQxtuYeaBj2UwpR7845x5rdw+A53e0MGgzdQE3U260WYVpfdaZXjJ?=
 =?us-ascii?Q?rERDU34clZxbYBlsJaF1xPL9AkBlvhfaX6vEUqA22ZOZCVXSmL/GNwqdnL2D?=
 =?us-ascii?Q?9Y6g7nxdpvWg16aPFbXKneB1m8RxHYQYEThjm+Y8UL97BHI3/ZH7yvvzvgQJ?=
 =?us-ascii?Q?1MZqmtp0zgJnMbPUEi2E/BaBLlC9KtInUHKXJod7hqtg05KLnbuYi2nry88C?=
 =?us-ascii?Q?ZiRgB4f3E4MyIv0qi0Qjnk5bDPGISzuDfOAPYRzuAYtLWWNkE+r3Ei6Ddp3Q?=
 =?us-ascii?Q?U3+jttTJS19XOQzdqiY70TXfMdKThgT9zklPCkPeIRKhN8SYX+QQ76egwgji?=
 =?us-ascii?Q?aXdRhTQ2S+OsgZ+fO0y49XZZ7K8MOZbhAc20q06er5FPZ6jaZ+UMDCVCDeNw?=
 =?us-ascii?Q?lLQPQ5tRCuRLPm8cQKFSHvPHaB+npwRaPiN7ztHO/rm+QZ31gz5iBAyeZMH5?=
 =?us-ascii?Q?dl9PYLo6e6qWwT3Y/9R5vUIfu2AW0Gs00xiFDSQBIPmOR6G+9+N1ZOsAIJxb?=
 =?us-ascii?Q?byAN7x5cctGNtoaRVU8joscourPA7bFI4sEqMXwxPEob1Zhce7kUMSdJELOl?=
 =?us-ascii?Q?HkLJ9ngBG7TelYXTQMkDWbzYk8Pse477CC9KTqJABerChlb+ECJXQmCRJePj?=
 =?us-ascii?Q?fHTztgxPELvBbtqwSNI4QDMNtgBtYbcFnP8uiqWc9MAC2LeKSNA2zOfc2wfh?=
 =?us-ascii?Q?yHp4QTaujT8B+PYzC0Pu2oplfy8jSFQ4tESQxOP8/6TDToJdkqA/ColnADbm?=
 =?us-ascii?Q?utCsucXFlvo7r8zHAD0krvIO7w//AovJSS8Ffzl337aKecZkFpfeD/tYsKUN?=
 =?us-ascii?Q?o51Hu43R5037p4b+UyFkAy9nDDluBahmsAyEcIrB82IJA/pST6GMQnUAvx1R?=
 =?us-ascii?Q?f2ZQxy5s7PNyqRISZ5o1AbfCArfK6Lik54yUzTTlMplec6Qt4z1F1QSdGHbU?=
 =?us-ascii?Q?wRT5Roqp/fzOAtuuJHK8MkTJllC8ln6xMSM4Id+q0BFh4U7QRlIexEpG0G4P?=
 =?us-ascii?Q?4PBZjG9aZucWOMMF+SdwnIVf3mmj9dq7VdGQKb1XA1VWknC5U7GJp8J3Gltc?=
 =?us-ascii?Q?Q7cuagD4oLSwULzzDRizi43Z432VUcT2NOhqFE6urxPeEm2PF7YN8bgmYKQi?=
 =?us-ascii?Q?QXqdcxRjzWmozGXSJuG5m3eK0s/wsXz3E0FiyVNEFJ968VXa/sB6EHp7KJBk?=
 =?us-ascii?Q?XODcIK9mftYdBVNhn/WiRcI/mcS8nAV6l9k6Ep4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef4fb69-073e-48dd-a9ef-08da5dc0cab0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:26:24.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENr6UqSROMpj2W7sL1+KnqqVexvpp9Q/ZMqQxdysojqTOl94I8dvHp/UJt1R7Q/u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3614
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 15, 2022 at 06:18:38PM +0800, Li Zhijian wrote:
> Hey folks,
> 
> These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
> In IB SPEC 1.5[1], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
> added in the MEMORY PLACEMENT EXTENSIONS section.
> 
> This patchset makes SoftRoCE support new RDMA FLUSH on RC and RD service.
> 
> You can verify the patchset by building and running the rdma_flush example[2].
> server:
> $ ./rdma_flush_server -s [server_address] -p [port_number]
> client:
> $ ./rdma_flush_client -s [server_address] -p [port_number]
> 
> - We introduce new packet format for FLUSH request.
> - We introduce FLUSH placement type attributes to HCA
> - We introduce FLUSH access flags that users are able to register with

So where are we on this? Are all the rxe regressions fixed now? It
doesn't apply so I'm dropping it from patchworks.

Thanks,
Jason
