Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88A6671F1F
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jan 2023 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjARON0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Jan 2023 09:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjAROMX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Jan 2023 09:12:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B578A0F1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jan 2023 05:53:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD6h1kvYb2RpSeKeR6uKqXaUcwDFJlnwQNyC4eYs559ITWLSMz0G4aefIq7ONKjYpWqz2BpGZmb8FjLHL6RgjGDM0Ab2N9xFCSrHzkh3ur7+V9UehiGpnrUp9KDlSV8zPEsKjsrz1+HJ31lZzMLsYzIzt43kMfIu5wM32pkqQFGFLP863sgQbjgYFnMcASXyF5gzre+FJ/CGVYyHNhNE1l7S2KIpPXwIZ4kvvBpzQJ6TcehyKvC60e5gPgnGhp6snfp1nb7wUPlj1+G/Q/Vz62p3Vo1OTC7K/V7m4Ud6bwiYVbqxbvb3Iul/p+VcdJwnF1IYQd5wNAb780JgjBsYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Duhpqw17+6xoToNxzg/pbanPuq2TYqpP6ZKL4sfjgEs=;
 b=RRIbSOFwZ8DK184M/B4Z2yeqCMoPAmv4QbBTXLfM+bGz8K7KEdzDthNwtTrpcFvjO6NKDgBwBDZVQmfmsaiIdQVKgbivT/+CskPcl6Gf/drtOmhWPhC6l0TZ/ZEJjVLuMXOEVDmbt6VaZlafkzq7lxBnaJn6+Al3LnBYKDi+jOu46wlIkkWWpFjmT2R5H77Yj6oh+Ab/3WtfNB3f4/wNp8h7RrAvBl2Sm4i+9dOJ4hVwUshkdTJ97nrLt6PNNCFs9cHWz3fckf882yDrqGUVSuC2YxJU1/Exv2sPW1f8iC6yzdjVQpGROOdEyGn5gKBzfiPISJEVx2h5KmvAF/t5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Duhpqw17+6xoToNxzg/pbanPuq2TYqpP6ZKL4sfjgEs=;
 b=VauWkeZB++IlC/InftQneyufhKWz3k242cgXbow7ys88y8J7yjGrXZMoISc01agbxLF2sFTKYX0ivIDvKGZT3Xl6OmxntTiuSQWBGSPP70qNSoA61/nZ3m1XhODZn9iAn9ogrOsVyFlbmSzxk7/BKiZqXwflLjjpZwnZKHRn19TC3irW28TAIZsrR2Eqrj5337+gBeNgkTCWriP4DA1jIOEObjpLuRItCKtWCIzSjmBGACqEB16Fxm+6qusA6oryotL+bzkr57DgV/HBXeZQ+QIFaNsPHPdXTjHFVhsb/osR+S2eqQ+/o7Vm+HJiuabqktC3/7UQH6efacL2wIHnRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8077.namprd12.prod.outlook.com (2603:10b6:208:3f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 13:53:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 13:53:36 +0000
Date:   Wed, 18 Jan 2023 09:53:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5 4/6] RDMA-rxe: Isolate mr code from
 atomic_write_reply()
Message-ID: <Y8f53jdDAN0B9qy7@nvidia.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
 <20230116235602.22899-5-rpearsonhpe@gmail.com>
 <Y8a6mILrIxIwq4/m@nvidia.com>
 <9a701083-2268-dea5-fe4b-cd2de59fb647@gmail.com>
 <Y8bUAIsqMXvHIJNb@nvidia.com>
 <15174079-2a2c-c84f-3b37-7e0f26b553cc@gmail.com>
 <Y8bjYnQLvw3Uv7CD@nvidia.com>
 <1a198842-91f6-2fe4-a478-1df4dda341c0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a198842-91f6-2fe4-a478-1df4dda341c0@gmail.com>
X-ClientProxiedBy: MN2PR10CA0034.namprd10.prod.outlook.com
 (2603:10b6:208:120::47) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1398f1-ec9a-4e63-6c32-08daf95b651d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vn8i8eZ8CdazysYjNcogc4b+5ug3mDhQoxRxxnLan1hIIVUCC4Ir0tI4b1deiefidXF4jpJpqI45voN8JJ8WRB8zFcAlv22+Etytz8X1a8Q5morVx0sAoTGD6KhgB+vI8d0/NwCdv5faoKHFFeZ6jFVg6BjVHXxXHXW2o8tRX8HNyyILK6iExZRjFPz3DOU9MRym/l6YZcGlgNZ2Ns0X5yW9xwYCSlyv14EkIEIeFsB/LXuXR9m7RCnhHthYRwcm9YjL4i8pAu2XM9/9YNhJrafX7QRbyRKs7uJjcPJ7oewcgitBsIgqn3YiS+xtVKeky7wmYdSwjxleb84R5mHBA13dBWE1i+RU3zX8cBgSI6+D9+8uSsY1ZU9WzNasRzG7aE8/B4bIc/UAF3h+RaQA2soxM8EsUzXiRNDobiqzVCm9/cAFxlRaWbQ43+DSc5I/KhpwOQM4bzdoaLjsQ8xP2vEchEHN7D4Bk49vPiP391LlonmIDz0ky9NQfqMLjn6lvv3Tix94vnOupzLvejlLrFtEWHufC02kowH0wOLkrNKw520fPpPcnDvPQbO06OfvSw5c890PcotZuuHgQG8yFo12z1fBJX0Iw8m9c8OV1/Bb3g4/zt+TOFIRM5nMkZwkBOVdoXN+octdJDMRrccBJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(38100700002)(36756003)(86362001)(6486002)(186003)(6512007)(66946007)(66476007)(6916009)(66556008)(4326008)(26005)(478600001)(2616005)(53546011)(316002)(8936002)(8676002)(6506007)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pRLxwAqjdTwOm1+hIIgwjQvA+gVyKtoIJYvtLYq9FXplg9z+82C0rPg7Ejml?=
 =?us-ascii?Q?DsUG17k/oEg8+awLUlxKapAWoD6dt/OykI7EvvYd0DOWt7U9M3tcffK9O8bU?=
 =?us-ascii?Q?Ej6tDG/us0uof2TjQO0wbY0HVLw6TZRujDOZoSCERKSpRvowH3f1tq3eJ0qY?=
 =?us-ascii?Q?vAEEbHd86+3zSMrAcHrVFvtpF4yMm3sNhtjjgYWivWkos8ruj0r61rI7u9u3?=
 =?us-ascii?Q?oJ0FVENNMGVOomF5/bBCW4zezXS7P5vxHATla79F2NsLjELxocn9xpguAFq/?=
 =?us-ascii?Q?9A19mg68jRQMa0jGwjEEOpXZmsyCFwCl0bhodWVw6tgkNCNUB1Dpg2mtQt5m?=
 =?us-ascii?Q?eTscQpFW4vnApG3Q4TGI618pJyT2RDpjGThYm3GqdgPnDapLdBzRxW+zrxVB?=
 =?us-ascii?Q?59Xg5ZFt+XvZZJCAN5gj2dMBa0mfV5wmKO0Jq+oMBSAqhoYEuvAS6eDz3m6L?=
 =?us-ascii?Q?DDRubb9QTJ9BNFNFO/Qjotzt1hM9Cxeuv76bRAT7VPDidDt9WQChKkHV097s?=
 =?us-ascii?Q?nel3YHoQAP15H/IVHSGefQSP2MrDIVM0/Kfx9clicA8ab9nO0W5fBj51ZCe3?=
 =?us-ascii?Q?7bpnMu5dVejOJunrCnl+35iCOKSXPMRQRjWSVCVsK00YEgneKMEMupSVdhBR?=
 =?us-ascii?Q?OdAQdktAdY4uC4Er2hn8gPDGseJQr1yXLlkBOCe4FRAp20qdm0I+KHEVMv7n?=
 =?us-ascii?Q?3tGWhfAWbfJAInHP1iW6dT0hM03lDRL1QoOGIbh+2sP8SJH2OKAnCJgco0vy?=
 =?us-ascii?Q?vTHBYJmDZC4G6Drc/pkQPbPnbtVOguZLV5ujVTrWKL5CNQ2gXf9NxMI4sFiM?=
 =?us-ascii?Q?GMbDsrmX+rdtNfJaZ8eOt+9xaS1O9jtb8oBaMLjg1pJd4V6FvX5h9YeZ09b5?=
 =?us-ascii?Q?4oIAatchWrWACL3xd23b4VAzcma3vjyGRCU3RcDD8qOBwvq4cssjkkAWZKMC?=
 =?us-ascii?Q?z9B7qiIjwUyowVxHiCgxAWraUlManjwpEv11kst+x03fCrTnV/E3kgK3dt0z?=
 =?us-ascii?Q?2Njj4/ddW2PgP2vcmlf7cv9N97rj0/Qm+cpwiRqMY+QVIeu2vDEfqgloQ1X4?=
 =?us-ascii?Q?T+cK8asdDtjB+2I4XTI8tBqmGI4FCfDEvo5DYTvDvxopBGla40oarrrB42rT?=
 =?us-ascii?Q?68GRbjXYZkIflhWIrYihd+1/aRgNAMA1JP2bF/qYuVSivee67LsMUcAFdXtt?=
 =?us-ascii?Q?u+mZ3J2ChPKJ1Yo038BhyD+l3BsMhWKHuNsYbMfdgWKtHg43utNDXrTA9PeR?=
 =?us-ascii?Q?azqKt0o24qYbnkzd+0QpkV/ks1bH/Xh1WeyU+KWfCw6go/Za9INPdOHJ2l/w?=
 =?us-ascii?Q?PtSFo4d6364R19oDDwbk5DM85kv5VS6Q08yNhUhlGTdnuXauqFrb+WYfbY5r?=
 =?us-ascii?Q?PJi0Zkby6/Qu8yP8oeGI9Mb+ygYkAsUYkoopM1stii+POZCFSb5b51UwNQJs?=
 =?us-ascii?Q?E/f5HPVfdWho8buEUSKjs9efi3PJR0Cfng9V6RPUUYV5eltFP6atqAZ00z72?=
 =?us-ascii?Q?gKTl7O5DPnO/EhrByeu0QJxJOQ24i9I1+RELoDQ3l7kZI51ewYAnzsLpt3v+?=
 =?us-ascii?Q?hR9MzIujz5FryaeffTtbb/CFBwCbhOPAVntyC47E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1398f1-ec9a-4e63-6c32-08daf95b651d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 13:53:36.1207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtLn48obTw+U1tPcrbfbPjqkQ9fAuauHC9hVUZak1sW4LAUE/DL4/M3sDPKAzASx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 02:41:53PM -0600, Bob Pearson wrote:
> On 1/17/23 12:05, Jason Gunthorpe wrote:
> > On Tue, Jan 17, 2023 at 11:04:29AM -0600, Bob Pearson wrote:
> >> On 1/17/23 10:59, Jason Gunthorpe wrote:
> >>> On Tue, Jan 17, 2023 at 10:57:31AM -0600, Bob Pearson wrote:
> >>>
> >>>>>> -	dst = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, payload);
> >>>>>> -	/* check vaddr is 8 bytes aligned. */
> >>>>>> -	if (!dst || (uintptr_t)dst & 7)
> >>>>>> -		return RESPST_ERR_MISALIGNED_ATOMIC;
> >>>>>> +	if (res->replay)
> >>>>>> +		return RESPST_ACKNOWLEDGE;
> >>>>>>  
> >>>>>> -	/* Do atomic write after all prior operations have completed */
> >>>>>> -	smp_store_release(dst, src);
> >>>>>> +	mr = qp->resp.mr;
> >>>>>> +	value = *(u64 *)payload_addr(pkt);
> >>>>>> +	iova = qp->resp.va + qp->resp.offset;
> >>>>>>  
> >>>>>> -	/* decrease resp.resid to zero */
> >>>>>> -	qp->resp.resid -= sizeof(payload);
> >>>>>> +#if defined CONFIG_64BIT
> >>>>>
> >>>>> Shouldn't need a #ifdef here
> >>>>
> >>>> This avoids a new special error (i.e. NOT_64_bit) and makes it clear we
> >>>> won't call the code in mr.
> >>>
> >>> ? That doesn't seem right
> >>
> >> that was the -3 of the -1, -2, -3 that we just fixed. there are three error paths out
> >> of this state and we need a way to get to them. The #ifdef provides
> >> that third path.
> > 
> > I feel like it should be solvable without this ifdef though
> > 
> > Jason
> 
> You could get rid of the ifdef in the atomic_write_reply() routine but then the rxe_mr_do_atomic_write() routine would have to have a second version in the #else case
> that would have to return something different so that the third exit could be taken i.e.
> whatever replaces the original -3. I really think this is simpler.

You really should just return the RESPST_* from these functions.

Jason
