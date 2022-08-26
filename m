Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62E5A284D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiHZNPA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiHZNO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 09:14:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C5109D
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGRTeKjg7QfKtVqKmLx7JGO1ejSofp9EY5voUAsyn6lD+W7tGLCG2cm+vwIIjpPaWhIEzja7zMoXl4gV9nvAPck0D1ViV1bseZFaN3Nm1Ap5zWkYULrIgMLtD+uEe+RJWA0IXl9vIynBeSN7YGPVOlHOLl/pShW9N7sJ31TvNANbCYJfJGIRa3HpRXWOaMkCNOQ7K9oM46m1R6pmZarqZ8PFmllXRzkpd1VTlhZz+LvqXx7qCEqsxaXb00xjTlgYGWiJoVVgaCbQANbbXkcmlrCAbgXDXJ0QAEHZVJByrK4DnDY0feI0lLZQUoBS1QXgKcTcGwNOF0xz1erwjFq7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc++cxemLZvluvjfknqTPKB0oRrJNjivYNDDxcHUfaA=;
 b=R1IXOpLGIjkRq5xKYzihiatHtcSMmXTZehqETmlE3OXdX+lsediec3t1cJWM2FeGKkQIuEobaBmCYSAmVDcF6DcsvoqJv/vgb1+3CM6JBWGkW8J1DGnfJjJQcXQj0YQ9m59LkPaaMEZO8itDTTU8JJxUwv5nwFeLSVfMTUmUFJExQfOE7fGjhiY7A+ycJDU9Q3C2ICwBA+dMgmhFPe3r51cP4a4NIjEx+1oNHZT8HWtZ4g2cJPOlIeBlTIrgg6m2Iek/WjNMlU4nVnJU1hpfPF1Zw4l/6+qe2PjdZnonqxwazMhHJJ3hs86IsOS2VQ9zchdFynpHF1xDw4PAGnRLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc++cxemLZvluvjfknqTPKB0oRrJNjivYNDDxcHUfaA=;
 b=HCoY+piGGcPEGwzFFzXwEKNLRi0Fr3JjMNACbBTHxBNUzFRyqg5pipClgIA7WOrI8GOVTX1lBS8DrQ4J+T8oRDnhv6a92n00O0MRAWUYWkOtew2cF4rqMbzvvkpbyRiCjxD7f6O/IuAkIN1nyDa9ereDpFvfN8YsdE/QVo/AiIWpo2Pwa3LfPbaUWLiW/mtzr11tu5X6XcUMWFFingwLSNp3rdSwUNO/xY7YsItDOesUS2KZWvDGWcSkv8dW4O278xBRHuVojKKvTRvJLpHvUAsX+rx4MQl+hDpmrWcQvqd3TLnrSta9JIlQyrLkG8hcqSinKpoef5B+s16D0WUFIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 13:14:49 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 13:14:49 +0000
Date:   Fri, 26 Aug 2022 10:14:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/core: fix sg_to_page mapping for
 boundary condition
Message-ID: <YwjHSBr3f4o0hXBX@nvidia.com>
References: <20220816081153.1580612-1-kashyap.desai@broadcom.com>
 <Yv7QvMADD7g3yPWh@nvidia.com>
 <2b8cd62b4c5c0f9551977909981246d8@mail.gmail.com>
 <Yv94fYp8869XZKFU@nvidia.com>
 <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2651261c642ca672864c2c6c8e7a9774@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f21150d-e8f2-4db0-13a6-08da8764f426
X-MS-TrafficTypeDiagnostic: PH8PR12MB6724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zmK4GfViSjc6QsZ5oRe96dxjnVbC2sVZ/VWQz6oOQjzfdk88sTX4SN0cGLV+isGSUJwbvCGp6TBPt9Wq/r0TsrxGeaJX140nLMafxm1cJ1+1EwtGFZc0Sk2hJRqhhnozRX0XcPMb8smJ6Hdlao/QA1Z9QhKzhnCi5Y+pIs42SAauXhqbf/xdNje6XhND7LKPqZYNh8+euM5yIEHR66zp/BYQOd85xa/4WbjXIMhQ9C5IwW6qxxu3egfCChweDrIrnuetpc9DAbysCb9b5BbfntGNTRcB3Knw0S+8P8eHXSZCr8qbzMKN5AR0OL6M5Otdv/1VwMwpfHOgHW+Y8jWaRU5q0Hbhu3C7EFn70Cr1886eAtIf7ys9m0HMknRBY2cJrgYUR6MMd9ej1mhrOgvdyKPxhwtp2ha16qAdIzlqL+iqu+pzHuT9grSIw9MkabpK2JBoh7+HMV3k/2+5WqVjIOrt6Sld7NbtFTPIYuIFpn1YEFQln+xJACNtJbhjS7aNvbvQJMH94Wk/PtTWBJ2E6wR+p+4iLJGBx/2JJ23CMiM+uRAMubUoL4BZp7+atx8b222tbGFK8X0kLmBO80dsjQJDXQ1nZr1od22cPVOv9149jjTHFjt4LjpUEZINNhXGYEG33DF4yTBJK/TdWWFLd/LQxqrijJca6foiDNL3Q3UmJkIFNHeZdbaR9Hxh8fFquXgQ9I/KXAvyMepuMDvGQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(36756003)(6506007)(41300700001)(2906002)(6486002)(6916009)(86362001)(26005)(478600001)(6512007)(316002)(54906003)(186003)(2616005)(38100700002)(66946007)(5660300002)(8936002)(8676002)(66556008)(4326008)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oYbVnbYPOkpBQljQQ/+acQv0RaFOG3evywbDCfVmW2YEsuHRwvzQqs3+QPhp?=
 =?us-ascii?Q?HYXE++0LG+Z/rpI96AwoCm4a1KaEkSOjCgeMuJkjKNIFmUpwp6zxUcTxeX5W?=
 =?us-ascii?Q?wSL9ABaCn1cgh/V2J6XKeblqEVONIoqay1B1NUKNkiLaUyy1mRoSpRAeOU8b?=
 =?us-ascii?Q?nmsLxZf7KdFoWFalPBcGheRpK9zmOuMEPHlTIBFsB6VNCIT8mwuI9tqrTda8?=
 =?us-ascii?Q?6/Aqb20gQmWeGET/AlpYzBLlE/okv7lHFzKm0SUiT+F8YTs9bXZhO17HoCdi?=
 =?us-ascii?Q?y9oZ7dbfnMdIeDLFEc5ndkPdCp4CxQkZGy58BKc6viqbKS7/FLzsXTstjWRI?=
 =?us-ascii?Q?PtpIbQDK1oA0T2qh89fSN5DPXkTZ5UtaTzcTPCevxg5aXAsH6CmkiPlFFFAW?=
 =?us-ascii?Q?/WLOFw60CRt+h632GNimW0LzlZhFHgyJraDaco1kxgP4Jq1gufTVYfPLd6kQ?=
 =?us-ascii?Q?cqvcTKDI2XdTlkbYaIjCcifhl71tJQYmeOOnjdjJL9/46i1qEaljmr4HSasY?=
 =?us-ascii?Q?zLipOOjdAE7tC6eXwB5gXAFvds1lhQFQ7Lg2vdBBpBbjVUDorm9iqSBBKtAI?=
 =?us-ascii?Q?sv861OcKEWT1Kh1lRnbP/DPy04ZzXvOVRW97fDqf2DMClj3hI7ANjcYaRKYG?=
 =?us-ascii?Q?BmoZTZ9RUkPZ3I785h1bYDbtmbe0PAC9hwUUJBxjr0AtCSsztltOzgRTwaQR?=
 =?us-ascii?Q?jVHTMfaBAurdLXmUJS0Sdo6dzsKxLx6AqWLBlOhTxqjoseBD0VMJYLwnMUwz?=
 =?us-ascii?Q?XvOaRl53nOQ+pDA4x/vy4mq39QoI+n58/lk9kMGQK2GJgeEaFvA6LRTi0ij4?=
 =?us-ascii?Q?PBc1QyQ2mMRnjGCEsGE8ipUETsmT8/9ErKVta1+ZpTXU3+5naIMJYhBJcNZT?=
 =?us-ascii?Q?UlnmeEc4DwyciXQPDcs5vHWnhc+F5Ls5XSXWtHouDtdBwPT890++CQfev7Rj?=
 =?us-ascii?Q?GxmNm1YXG6e9a+efTsjfthMNIyeWGA9qmHCiWwvygS3zvJ+ClbgBL2o/Ea/u?=
 =?us-ascii?Q?XKJYmc0GCiDf0yLNWNJICSTELCWIbDQC+dUYMjSyR/eJSSj/lYnrmGHliEza?=
 =?us-ascii?Q?2Yub+iZarSDBwEhbhtwwzPL5E4/oC0KIoZ7s0d0uww+j2otMojDRdQBPzEQj?=
 =?us-ascii?Q?aXh41C8bbH2XKNRJQYTi3SWt/WN3SrWdpJAto7LKqU+bLQTTifNRBewEXWvs?=
 =?us-ascii?Q?n/LtaQWqDD0FLSia9TEFKqPJwZGyvQSxc8i0ccroBdUvvHhCehasspy/utFE?=
 =?us-ascii?Q?K2t6LU1joe+a7jUcHbvrTn7qJO2VPUzZKaguN7ghNOiVvQZdKUIjMdcjHMVi?=
 =?us-ascii?Q?8yqIPY078gR+9GLubEtkDBsbSLTyy0dJke0Esu/wyAIRuaikNbN/dTR3ibsd?=
 =?us-ascii?Q?oY8B8EiulrT5qgoK6RSH3djlPhUeuk9WHzqubIXrBbocOwz/k5s3xnaeYMl8?=
 =?us-ascii?Q?XXuXtfCwCOQ4UjYniwVFg8OiUO2YDv05KSwdRxv+7FTvzUs8voUXAv0I36Zr?=
 =?us-ascii?Q?MUmXDAry4ObBWugR3PgQ0z7fJn/RBPodNO9WUT/qIt6M/t8/LAu6TiNZZF8x?=
 =?us-ascii?Q?TWfjlMbECFxkNWJXPxFIWUfiu9OMRLCDbpHZLv01?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f21150d-e8f2-4db0-13a6-08da8764f426
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 13:14:49.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgFUzDcNioDSdIvm5a6A0BVnrQCSQtM20iO/mokiSJzX6MaixbHqq7XxQgyl1piH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 22, 2022 at 07:51:22PM +0530, Kashyap Desai wrote:

> Now, we will enter into below loop with dma_addr = page_addr =
> 0xffffffffffffe000 and "end_dma_addr = dma_addr + dma_len" is ZERO.
> eval 0xffffffffffffe000 + 8192
> hexadecimal: 0

This is called overflow.

Anything doing maths on the sgl's is likely to become broken by this -
which is why I think it is unnecessarily dangerous for the iommu code
to general dma addresses like this. It just shouldn't.

> > It should not create mappings that are so dangerous. There is really no
> reason to
> > use the last page of IOVA space that includes -1.
> 
> That is correct, but if API which deals with mapping they handle this kind
> of request gracefully is needed. Right ?

Ideally, but that is a game of wack a mole across the kernel, and
redoing algorithms to avoid overflowing addition is tricky stuff.

> I thought about better approach without creating regression and I found
> having loop using sg_dma_len can avoid such issues gracefully.
> How about original patch. ?

It overflows too.

You need to write the code so you never create the situation where
A+B=0 - don't try to fix things up after that happens.

Usually that means transforming the algorithm so that it works on a
"last byte" so we never need to compute an address that is +1 to the
last byte, which would be the overflown 0.

> Above revert is part of my test. In my setup "iommu_dma_forcedac = $2 =
> false".

So you opt into this behavior, OK

Jason
