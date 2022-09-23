Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC85E85CC
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Sep 2022 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIWWWo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 18:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWWWn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 18:22:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A13D14979E
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 15:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1GzuRiqyWrThNdlw4Ws2pDxVnYVdXJFPDRvhw97OoSNg8DQaWm/b4Y2l2jPPaCnaTsVzo9qVveY2RttlvEN9IUPTnTTQZaMe26/dAms/gAuRU4ZWpRYcReHWvH3fMZsGmSjCObNXTLAv9Ez29ksw2n2/oIGUMs6sPTEoqxL3sgStH+zx8OdBrMnkROPoxQuXTKOlZalZv4B+yWuIAbIFfmS3qYljiPH3XVXy7FjhGsoMoMw5YUo4eR2ABbsFKs+0qsmTH1Qu/SMVlRkIGu1REc6gXWgrCJZCWkylI4nqlwZAQfYyF8ZNsNDBPIU00d8w7m0n6FRLOhg+hVB9gdpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhyyYXzDQ0A8m29z29nDwPZsMV+5tm8svJL7BI4xOTQ=;
 b=JrzmdsPVU8ge8yvH/sK9u0/1Ie4bAJftm7SrW4Tv4SDV/PUv6OVoccZcrKGDGfKufinEQGoW/p6ea/YDjTgf+ZqVOTa4vTCxcyFj/fLLYYbHNaehpx3sPF3MTLScj+kpH0Pl9D7++NYmJmMf79Nos6PQ/3dpQhoHhltksBZmn5+oPtRZkArt21RKD2wWxVpn+vzOLvgfJ7XrlgFqke7zkaqTQjsroUNDl4Y784g2s7P1opWi2bFfBOH8KZ2N1Kk4FcTtV9YvRVfm3mht1FLd4q2Nh6klthTp6+/KwPS7XldsRLo/w7XOQz3r2FUC6/xjIS0nYMFjROdrfFGaJyb1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhyyYXzDQ0A8m29z29nDwPZsMV+5tm8svJL7BI4xOTQ=;
 b=HEotLRengGqR4IJOb+PcJupOWwDO9YUPURxtvlMLw0cLY9utyeq345diqziK3qd3jI1KnLty93SHdyeUy3RuwLMpckwZ41f9VrIMPEZ449gSmD6aGvGNFH2R8Py/yqV7HRRy/63zFwPll8pu0vG5uDNg2vG2hJWqhlIVB3tN1EOP2wZ/yJNv9LSYEk7qim5t3w+t3bC56MwMMZTuFo1QHuRZ9NvNI/+aqS5Eip0W0/UCLjLMPfoZyb4od0MfA9pudKRwIgGPnYnhoYSRyXs1Ujr0Zk7Eh2XA13vi8qYXGESgw+0vCrH+ObGlWcnlaySsOTyLG8hdTKqun5B0h9vMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 22:22:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 22:22:40 +0000
Date:   Fri, 23 Sep 2022 19:22:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Message-ID: <Yy4xrlC2lt156nsV@nvidia.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708040228.6703-2-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::31) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: e243bc20-8d39-4f95-defd-08da9db2207a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXUgfR7q0s0kMRYN/XdQmFzMd6woR0iBxLOGWAI+ckivWi8T0Sb+dy7aGwgPPANJJ+Xhq2U0k6IlW7sbJNabihWzPZ+79ogSaRWD6rWVe8dAziVwkU+khCMzAu3AW5rOcfOSltM8nPeTFnny8ULneA0n666YzRcGg91EuNRn2x8DhtP8W3SAS7Y7P6ZquwIS0xAkicLeiZvOs6khSPkMJSRDhzSvAJORip6XfnlSsZoSkaU9SD8CI0WhhDn/7fVW1Z52eItsSvwZd+I6uvPFZrfp6TTtvXhcS+Blr9rzs75EGMO8OUJgU4S3GegQSN1JgHz2NmsP4Zj+TXWBNS+dMv7cLc+202bZKtW84poe7F4nviX/K5ZjFUzh9X9KxWuPQEks53h0Y/oupM9jy1pV0wRn/Dx85ZXvwIw/l6Xe++E8Oy6JUtGMXT/NTGEUvl7VZdj2abvhg8vfMAsEksABVe1ZKY76CM3wTcVacNkIV1MFZzEJXAiDFspvN8zg2WL9VEageNJTtvdyG82SV/CmB2A+kyCzK70DqG/1Re/yog/f/SXEjIh+RSk1OQ+NavQpBsUx0cJAk6D8ooysY3cwrU8ZeZqgLvvZv32eFvpYFm5anrtTlw4zZIhbdTU+NKCHQWz3TtSpGtENGFcROooBE93FlQr2WE354CEKPlNROfuh5EQKX7+zlt2x6mNanvE8KtlQVGYP6Snx7qehV2aMZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199015)(8936002)(4326008)(66556008)(66946007)(66476007)(38100700002)(36756003)(86362001)(5660300002)(2906002)(6512007)(6506007)(8676002)(26005)(6486002)(478600001)(2616005)(41300700001)(186003)(54906003)(45080400002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RWJbkz7VrzonxD56HhwMvfj0BZpunv2tID0o4gqzrYBbLiP5eNNgQSXU+Yky?=
 =?us-ascii?Q?1Lf5UpAlh8Le/R/NVAsfTYdOY8f2i2kADJNcOfvWWHG4WOVI88ICnkNEE8iT?=
 =?us-ascii?Q?IRk8+OQum7aFY3VtB8leun4P3c6c0C5CHm2FeQEzfp8Q6ltwjhoIGpajTj79?=
 =?us-ascii?Q?i+NC7P/k+TU0yTV2M6RxxRsPv7Oga+PbCKwVKKbk4xIuc94ZEWeFhsjgd87Z?=
 =?us-ascii?Q?/KfrjVWhsBy/fUXTfOs2W/LqGocxRJodR4B4LYcqRx6+p7bSGO9uLYPcbYGy?=
 =?us-ascii?Q?+lGRA25x/lkxonBWjLgxPrVF/jk53iooCZALDGO5ac7FFzseYGmv08lJXBT6?=
 =?us-ascii?Q?wcT5iOcaSg67YWsmH3VsPzuf0gNubfJl/GHGgu6rTObpurG0MTOCOThGC/DO?=
 =?us-ascii?Q?gucOwMbB+djAQKu5THjl6sFdgVNsjyt554jVUEUmn8Wf71y9p13jw1WK1G3x?=
 =?us-ascii?Q?o+hinn0k9cm0t24M7IAWP8YbH2AuGs0na+ic7IE9tQ7AV94ilqr39TMQ4+FH?=
 =?us-ascii?Q?fj8pi5wWnEWi7ES4AhfQpPQdK9SWvfUSzoircCg3EbU1OCLggSEOQfb0fZeK?=
 =?us-ascii?Q?CKDuF+zySwdMKCTidZyRcdsymZrS90aZZmhMJjUqBV2Zu4Al3PnWcx06Le+d?=
 =?us-ascii?Q?GDNVAw9C/O02S9mK4PsaKz8O1GB6OPSF/mCKky8AQ9xRtg3GBkrXMBMnwELa?=
 =?us-ascii?Q?R5A+wYf3FeSGLqzNItzjXGKPRntM61VtK22QU7pOreiSSUsM8k9VBU/RR5rh?=
 =?us-ascii?Q?uRrCRdGycgUBI/Vhyj89B29aseyHf/iGxuKvxh/eXkndS76qhrNFZkUpGTK1?=
 =?us-ascii?Q?hWVg+MrZLn9q5duQXp5thdvhUM6u47dChzinYdCKMh0UV6wTFXpwLK7UqY1a?=
 =?us-ascii?Q?6PXI/RFOBPGqIgVd7S+hfdgIXbGc5i+MMcKV/KVfMa9cmJmezFwWqFo15pHU?=
 =?us-ascii?Q?kWDPnHJSs2EpMfFKVf6/wunCTB24DtYSnKOzbsALFWQdYmF1KBSZdxJ8zrkI?=
 =?us-ascii?Q?Wr7SOihBsX6gdi2vfOkGhDUimTbeDLjB11D4x1FvPWvJCPAr2D249wXUUHsd?=
 =?us-ascii?Q?gMBwLWnkkpdIXzw1HSKo7f9KUZ0rlf3beYi2fFpLnal4X9FnZdN1ahbB2c1g?=
 =?us-ascii?Q?4ojQB+gqY+SLgwsLs2v6Lw3AvUcXiMjdUSvWORWvTLz6BQyagUWrL0foNNZV?=
 =?us-ascii?Q?1HfSjhCfjbPnk8x/Y+ZxVI4lpRGdz3Lp4i5VQmoiv6cMtju4CjHED2aalyX9?=
 =?us-ascii?Q?8KQohv7Spj9SF7tUmHagoRX6dJQYm4p/1XuURWudaX4/1ixcfmKS/127GPEH?=
 =?us-ascii?Q?ugF0Ib9HXB4ceSz0skpV51DV38BmrM81pok3FoMEVcEpQeCjj3FQav3QOCvQ?=
 =?us-ascii?Q?ZSc78vj9VH9j3CYlfe0jAGHSOe5r4w9ewWq4EnrW6MG0OA/lK0GZnuv2+rRH?=
 =?us-ascii?Q?RUsmav8+ZWyTE+o/MPLUfZkIYiArlrYQxUttTSQJdegwzbTumlDeSC7FpZNG?=
 =?us-ascii?Q?jDlJODzM28B2jfLjQwUwnbh+1O92RY4b8mgrr+O+3RxKiDuMuPaii170k7J4?=
 =?us-ascii?Q?Mfq1sf4caeyNntY0biQ/vJv56iWYHEGjoHwytSxq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e243bc20-8d39-4f95-defd-08da9db2207a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 22:22:40.4290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+c8Lr5irXl5XZ6qQAxIhOjYrtmTfb8z2G/E5JVnMQyF3H96seket9I3WJW7juXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 08, 2022 at 04:02:36AM +0000, yangx.jy@fujitsu.com wrote:
> +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
> +					   struct rxe_pkt_info *pkt)
> +{
> +	u64 src, *dst;
> +	struct resp_res *res = qp->resp.res;
> +	struct rxe_mr *mr = qp->resp.mr;
> +	int payload = payload_size(pkt);
> +
> +	if (!res) {
> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
> +		qp->resp.res = res;
> +	}
> +
> +	if (!res->replay) {
> +#ifdef CONFIG_64BIT
> +		memcpy(&src, payload_addr(pkt), payload);
> +
> +		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> +		/* check vaddr is 8 bytes aligned. */
> +		if (!dst || (uintptr_t)dst & 7)
> +			return RESPST_ERR_MISALIGNED_ATOMIC;
> +
> +		/* Do atomic write after all prior operations have completed */
> +		smp_store_release(dst, src);

Someone needs to fix iova_to_vaddr to do the missing kmap, we can't
just assume you can cast a u64 pfn to a vaddr like this.

> +		/* decrease resp.resid to zero */
> +		qp->resp.resid -= sizeof(payload);
> +
> +		qp->resp.msn++;
> +
> +		/* next expected psn, read handles this separately */
> +		qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
> +		qp->resp.ack_psn = qp->resp.psn;
> +
> +		qp->resp.opcode = pkt->opcode;
> +		qp->resp.status = IB_WC_SUCCESS;
> +
> +		return RESPST_ACKNOWLEDGE;
> +#else
> +		pr_err("32-bit arch doesn't support 8-byte atomic write\n");
> +		return RESPST_ERR_UNSUPPORTED_OPCODE;

No print on receiving a remote packet

Jason
