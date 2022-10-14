Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540AB5FF1EB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Oct 2022 18:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJNQBA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Oct 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJNQA5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Oct 2022 12:00:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8466D14091
        for <linux-rdma@vger.kernel.org>; Fri, 14 Oct 2022 09:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJVVOzixxUGsWLVv6l/TuHUzd/grfKWhNhpKk5LObYYZddEhkjaokdZy+2qIH8J8K2dJiyuKvh6DLrPJn5lOvOjn7iR1aZqyJrewe6JYehZwgrfzEzN0kYffM2Rq1q25+8h6nk/puLQlvMYIHvKqv4xpAZMgVhc914TKQBL5D1ZDMCRx3jrqKrmpdzqU1EbEaPcDAzlIrlbhpdFgkSkz3l64R7z+CoiiRIFMBh474iKoZhXaLaQXi7CNegTu5LysYm1yVh4Bl8G64bwjdkEHPhAkzIALuaMQvdzIeK0Fy8vocgYi5arT+x/ppfD/UcU5IYiwec/5mBcVasZKDuKYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hdV/JTdOdnU4ZgbMHqFODSVE4KOWn+DoU5aqR1OkH0=;
 b=a9/24Xy1sIAc8K4m6DFBz9RjYCFahHIiDvyJPs3eG/jB3chPzsJZE0gSdk9MNeS/oEhsym/1WJP08qcVkXyekr/HLoqT6EU55c7Ss/CjDc8XP/QO9SsA1BOb9SH8y/XKww6DhREXK+NeA/XUevYcGrllvxObdZraSv2ha5oXDcscWsi1Fx1i2GUumPxMel3ssCUbpKEQqoIQxzUNtsaGP11fpInodEhZK6UylQ1/tb/KCv8aCAKmqI4dr8E7UWI/r7du0WMSnFwYk8NCAKCrCPhGiR5cM+5l+4FGSsQ36ZqZ8vp1rXWkIqSIFpASydQgXtN0yY1ySd57Kc31/xj8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hdV/JTdOdnU4ZgbMHqFODSVE4KOWn+DoU5aqR1OkH0=;
 b=po7TyBoJBlrkhQvjqBzqO1Wu98r61WIWXctj7k+P+ru7fHIoWJRDO30AUKzgvIMHKQ3gOXeZdriBdBMG2vRdpepLFm26j38ta3uA+aV1pSPiHyPGidgEVGGEq3YSvxtswOtoOhg8TPdduE3OrbkQtb0GnPWUg0h2OCTNtyFgNkBmnfPmHnxEhz2rV2OCPutkq4mw38dBioJeVeIOZ65n1yOfREVOv86wgMR1zoU839YvttPeIkzNTNG6ZCoaV3YhuCpGS3XHRXgoRP7zzLaNELS+50Und3FUfwz4Npf7CpiarlhvdzXufe9si7T0SUGi5jq/f+NKl3wb038lZDbIYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31; Fri, 14 Oct
 2022 16:00:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 16:00:52 +0000
Date:   Fri, 14 Oct 2022 13:00:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RESEND PATCH v5 1/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Message-ID: <Y0mHslo8ytQNnJ87@nvidia.com>
References: <20220708040228.6703-1-yangx.jy@fujitsu.com>
 <20220708040228.6703-2-yangx.jy@fujitsu.com>
 <Yy4xrlC2lt156nsV@nvidia.com>
 <6a04efb6-84e5-c7b7-25f1-843fa8122875@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a04efb6-84e5-c7b7-25f1-843fa8122875@fujitsu.com>
X-ClientProxiedBy: BL1PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c348b7e-a21a-42f7-42d7-08daadfd44cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qI2NHrsapaS3gUjC1/dYsoCiJ+aezRVwcyCg1/b2nYuweDp2rmVlvdo3URD7pzS7Zj6phSUQSrxqtGliuyNxRAVBGzRBGGpIMymqxF2e6MLfKjQGlLHZ/TP6R08jqa4/Nxp2CaXOiiC7luiwY4xUAuxzjaikRMdQF/d+XASDKvqi8l9tiCOenmEkit92VzirCJy3oaRJrYfeb01uTdVo/OuzDbW0AvrD+1HKWmI6QXsN4/iYi5WhgbD8ZfXVtk6v389E/fayxLPAfDaPVKPiint8GJrDSETe7FCnc/UtnhNHLJuHX6IvKZgLnGUBpI+q59yKjK2HsCC/4gA50MBAlCSjlCNDp4azzlsmSc80KZ/OOq9fKzkv3QBXIJcHzSWNVb3WxiRNNGh2CsVb2qEPWpM6OvRMQ65GWgYnkvv9qOtwDJuPaaIx4CyYcs0/V3bZ6KWzV1rAjRNNgG5Aqvy7IZtX42pFra5Rr6UvrLSqay9OFDVnd0oyBLmuIqMvV4uDRRGf6XOGbQh85VW2ZBczEJun/+2u7uf/0aOw+/pET6nOODi4bcKfvNQL9IkCqqOfO7aBBzhgLKjbziqRA1hf649ZGF8rBN9i35jnBtR3JN77N+w49fQlkXMletZA2lJQ9qUJWOP02UF4R6RaPKPvbTnM+b9qnuNzNy4WAEaLC/zl3n7sT7Semkh3zCozufzW5tPdqtJgXK3yxPW00Hqb1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(54906003)(6916009)(316002)(478600001)(8676002)(4326008)(66946007)(6486002)(66476007)(66556008)(6512007)(8936002)(41300700001)(53546011)(26005)(186003)(5660300002)(6506007)(2906002)(2616005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NJc004a1JHSkQ1cmZibVI3MzNyMWd5cDlGblNnN214c3puU3JVamQ5b09X?=
 =?utf-8?B?TEFhNUtTWmlxYWtrMGhWYURHYzh6UDBDOXZNTmZpS3JBSy9XMnN4eDF3TGFY?=
 =?utf-8?B?VnFVTWFwNXZSVUc3OU5LeEtrbmVOUGtwbUQ5bC9YMTJrYTIwV3JaV0RRaFN3?=
 =?utf-8?B?Z1dYY2d4RkU3NmEzaDl4MnloclZOMDM4ZUZUc3Q4bXNSM2h0bkNRcUhuL3FD?=
 =?utf-8?B?bnhJTTFybWhqMEV6S2RjWGVzUi8xdm9JTjdlUnBtRUtHS0o5ZVQ5SUloaE0w?=
 =?utf-8?B?ZERiT2I0T0xMLytVZXdYR3VEM0VUYXBXdHhFUmRjZExpK0VVTmxjb2hFQXFq?=
 =?utf-8?B?UzhjTC9la2hPVVJ1NVVOZEwrNEJpSm5BT2Z3cGxLM05JUEdlQm50UjJlc1RJ?=
 =?utf-8?B?NmY5cW1VRklIelNLcFFSbUdnVHhtbjJSNkxoUzNlTVlLak5LSkowKys2ZFJD?=
 =?utf-8?B?dVNaU1NOK2tiNFdtcmsrVkMzaVdpdE5VdXZRekUyRy9BMjFjWlpRR1JJWWRu?=
 =?utf-8?B?UFluaHRLK3A4ZlN3R3NmSzI0M2hGRXlrWnNvT3pjYXF6VCtVcUs5T3hVWlp5?=
 =?utf-8?B?R0srS25BN2ZUVllPUi9NV1FVQVRUZkh0eDBlVjBkaXlsK1VpUmorWERnSzhO?=
 =?utf-8?B?U3BRZ1pKcTA0S3cwYUllSXhGbGlObzFodnhLeVRocFROU29wdVNJaWRXM2lN?=
 =?utf-8?B?K3YyWkJRZTFRTkRPQ1RucE5GVG8ydEtJa29lVW04U0lvc1FqaEJVRTJnWkYy?=
 =?utf-8?B?U0c1Y3QzekNVVk5DWnVubTJhY1daNFdGbVhUZEEyd2xlTkI4alVjanlFalV3?=
 =?utf-8?B?WGF3dVQ5M3hOQWlyTXZ2Ry9HU25vT25WQUs2SGJxYVRTYXJ0ZnNzS2NxSHlO?=
 =?utf-8?B?MTBIMHJRY2w2WEdlVFQxdVZhZW5NeUowcTFIU0t4cnRFWEQ3MlVEN243U1JV?=
 =?utf-8?B?UDJLVUJEZjdiVTJ4ZEx1YzhuM0dTbllLWUxNMjFnZmxIek80YldjcDBzOEx6?=
 =?utf-8?B?Z0RZQlk3RWsxazhtZzRVOVlpa0NUTk0xUnJWQ2hnYmViRFFrMmh0L1JtSlJD?=
 =?utf-8?B?eDE2QWlCLzcxVjFHL2pkdnBwbFZaM1o3QW1OTk40QTZJVEhmVkZFVnMvdHhX?=
 =?utf-8?B?Mk1hK1BrRmp6Nmg5VVdadjNrRDlWeDFWdTM3SkpERXdMd2lpTjJoelUvYXNE?=
 =?utf-8?B?RFd4QnBRSWpRcERycUF2dUc4VHpHb3FZTFAxWXhSZTFjeE1ocXJ0a0lxQmRP?=
 =?utf-8?B?MjZtbkhYL2liRWhwRFJRZEFkbENXRHVPdklVOTl1Ujd0WGN2b3ZDRzdYMk9G?=
 =?utf-8?B?TUVpYVlqaHVNY3lOaERMN3Mra05TVDBtY1hLRGFyUFd1SERua09XRU0zN01m?=
 =?utf-8?B?WGZNNTNXQUtUOGJjNGE0RUJOUjVrN29vLzV4YU84MGxhSmw3aXBRdFlOTWZz?=
 =?utf-8?B?cmdrSGxUYzZzMk1mUFVrU3Yxc3hZa0tDVnBMUHRxRkxzOGlvU1lrVUxGUEpu?=
 =?utf-8?B?MGQzNTY2ZVdCTllEaU9BK2Z2L3JlU3lQb0tmUEpjRkdBTk53eHdqdW5ScGJx?=
 =?utf-8?B?dG0zdVAzK2IxNlhodkxOOUhUS2NyeU90Tll3bVFnbEZUa1FNenBaSDFyelhY?=
 =?utf-8?B?OUh2bW9WQUk2Rmo3QVU4bUlDZXlwZXRXOU1BY0sveVhtYzZEQ2kwbDdaL1I0?=
 =?utf-8?B?L1doQ1JqRkRhZFdvY2pvaWk3U0R6djY1dlpXSFhqcHEwdzVRSTBEZ1M5bWVp?=
 =?utf-8?B?aUtzanRTUHBISERGbC8vNkRIdnZwN2NOaC93dXk4RTZsazYxYkdYQlVlVjBp?=
 =?utf-8?B?c3pGdFpKWFZVNlUza01PUU9RMm50aFptcG1Fd21XMkNCUHY2NS9acTBFZVpy?=
 =?utf-8?B?MFVYMTBVV0FYL003OWdYdjNWNkd1Qi9iaTQ1bFZGVmhlQkZyb1NGdjh5MDZp?=
 =?utf-8?B?MDM2dno4NzFDWi9rYzR1bkI5Z0t5SGhWVkVpMTZkUU1vejRhdUFXVGFIMnFW?=
 =?utf-8?B?Y3plN0ZRZkp3eWw5eUtUY0VkcDM2UEowdVJFRnREdk16MHZxalV5ODNzYVRE?=
 =?utf-8?B?ZjJ4VFRpb1pmZGpMamt3cG5PZ1A5cFIrVEJPMzhlUnMxQmFTM0lxMklvRzBn?=
 =?utf-8?Q?3zbs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c348b7e-a21a-42f7-42d7-08daadfd44cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 16:00:52.0829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bro7MDWZ4h/E/BMUU2hctEQ8LTqijNQHO/2FJEn+0EH8f4nxEKlNZB2SaKueLW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 03:53:36PM +0800, Yang, Xiao/杨 晓 wrote:
> On 2022/9/24 6:22, Jason Gunthorpe wrote:
> > On Fri, Jul 08, 2022 at 04:02:36AM +0000, yangx.jy@fujitsu.com wrote:
> > > +static enum resp_states atomic_write_reply(struct rxe_qp *qp,
> > > +					   struct rxe_pkt_info *pkt)
> > > +{
> > > +	u64 src, *dst;
> > > +	struct resp_res *res = qp->resp.res;
> > > +	struct rxe_mr *mr = qp->resp.mr;
> > > +	int payload = payload_size(pkt);
> > > +
> > > +	if (!res) {
> > > +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_WRITE_MASK);
> > > +		qp->resp.res = res;
> > > +	}
> > > +
> > > +	if (!res->replay) {
> > > +#ifdef CONFIG_64BIT
> > > +		memcpy(&src, payload_addr(pkt), payload);
> > > +
> > > +		dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> > > +		/* check vaddr is 8 bytes aligned. */
> > > +		if (!dst || (uintptr_t)dst & 7)
> > > +			return RESPST_ERR_MISALIGNED_ATOMIC;
> > > +
> > > +		/* Do atomic write after all prior operations have completed */
> > > +		smp_store_release(dst, src);
> > 
> > Someone needs to fix iova_to_vaddr to do the missing kmap, we can't
> > just assume you can cast a u64 pfn to a vaddr like this.
> 
> Hi Jason,
> 
> Sorry, it is still not clear to me after looking into the related code
> again.
> 
> IMO, SoftRoCE depends on INFINIBAND_VIRT_DMA Kconfig which only allows
> !HIGHMEM so that SoftRoCE can call page_address() to gain a kernel virtual
> address for a page allocated on low memory zone. If a page is allocated on
> high memory zone, we need to gain a kernel virtual address by
> kmap()/kmap_atomic(). Did I miss something? I wonder why it is necessary to
> call kmap()?

People have been thinking of new uses for kmap, rxe still should be
calling it.

The above just explains why it doesn't fail today, it doesn't excuse
the wrong usage.

Jason
