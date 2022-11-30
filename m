Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5963E58C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 00:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiK3XgQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 18:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3XgP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 18:36:15 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4A102F
        for <linux-rdma@vger.kernel.org>; Wed, 30 Nov 2022 15:36:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5HVhTedV1HXo5GQR9eWF9RRgiZGC7YvGED+sZvyObyyv1O3YY7iWm3vFG2MB2CRBGzbyy3fM37NwgtO/tYNRHCytoVwKgl2suXDH9KkahOncNMxaByamv4qqHghSS32iIjpTpHAVNYozCC0FjsHSoC0tU5dGE9permh/Xn77So/zIExULOhFIFqiTnMNGH9FhhvARU+Q0wEp1RV2LsbM9EH67LwSWtGR7mPFhb7rHsX1zdfTOSt67kbD398hWLvZUlBWkk33iysAgBHvAHDKYoZGsqGqXjLGkHX5EvsbNaAIlLOqHU7bGdM6kiFR/UUJDSc8z12L7Ayj+SWhlDc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InEi9DR7TmOuQMzYYBvchDn+RnMT496IGLUcC4DyyDo=;
 b=QcKXO6icxkt3F5+Ug8W/ofRSqmZNcp45+QRl8TOtnyI+d1OfG8OJv6TASFD3eYg8PDOvb0GzQ32vq9d0tkwWiMTcq59sGYdwooRP29HB3Zp5/ttmv7bv5+bonewvpMu76CpKFxnWVbhdWIKhMELJRMP50SpzWnNwa87vGhPUS+H+m4faF24IyZTNJiSlIBmfqrVNZkX6XJ9LG+EVukP6Txl4b+oss2axQcOuC1bBFdJ13chRMLitPsvcWc4gy8Od0CiGI/Pu7sO7J1/PgnszzLQ9D4IbUe31zYRzVUSom3c776NQr4+7mhowHUn7q5T6AUwDhzuoDY/oK/HVjnj/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InEi9DR7TmOuQMzYYBvchDn+RnMT496IGLUcC4DyyDo=;
 b=S1FZqmz6QQuAG63DJM51wf0ERI5Q/FErtusVOk/LrG60bACYy7xDclCDf3yMF5SPlO7JXjNW7A0B4wkFsOtagIl3ivhiKt5k9hROBvg5BJwFQKed6cm3sDQ3E4yAjjxtj4GvxiosXUHO78f61/syPCuQ6657WDTmL6PGhpHVADjVRNR+ODBs0JSiMSNrwkljO29SnWFw80PRiLO3WEFPg94X6V8za1CQTnR1aC5NbTtm/9DipHFBUwz9vMtDTjMJP1g3XWZenzVrjNr57ds4r5cA0/Jcd7W+k3mVCfLn4vAawSBS6exN8QnAHeS4uEtvFOWQlm6fyeupcUWnuW8+/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6477.namprd12.prod.outlook.com (2603:10b6:930:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 23:36:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%8]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 23:36:11 +0000
Date:   Wed, 30 Nov 2022 19:36:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 06/18] RDMA/rxe: Add rxe_add_frag() to
 rxe_mr.c
Message-ID: <Y4fo6tknpuCveRgq@nvidia.com>
References: <20221031202805.19138-1-rpearsonhpe@gmail.com>
 <20221031202805.19138-6-rpearsonhpe@gmail.com>
 <Y3/Bqa7obMROAtr8@nvidia.com>
 <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ebc82bd-3d1c-e2d3-be4f-2e5c95073a65@gmail.com>
X-ClientProxiedBy: MN2PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:208:23b::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6477:EE_
X-MS-Office365-Filtering-Correlation-Id: d881f942-cfa8-43bf-a254-08dad32ba9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OLEE+DoyJYpyqRLnll/ki8C6JfrxSrDjnZ4hO3lSRnA0yu6CRu8p7u7V6ovt7/rEINA2iIJHU0msXDymYo+ytAKhWAwAp2soPCdXhYnDFGjHkQo937oZ6bTcRAF5aU1AIGCiIy3LTOdqNoJVG2K2lwXQLMPnVVm6PrCKu0mnNAUay4/V+hu9MzULEBJxsdI6FwxA6zHMuYeya79M4O0u6YxQpDB0tSomDiTLtpeo3uNiaUi6Fs/emIu3GIEghSgrk5M0Sr9XE0/D7CIyizWXt/hhEFgoYQUMr0cf6foCYsBXOAZU3xCqrEjsId5UG84YGIDoUys56CCjWc7POSWUvB140ok5Yg3tuxSCGZJ7bZkOuzOv0R5DeyVT9AxnzjVSNv0Re1UF/X3taXGPlIviEPydyyhCD0j5CIYQkiQ3CF1K4StX/ZVFjgoJ8k3DKsPM6uVqy8RbzoEjaDK5a6BgH51Ns50ZeW1/1HYy4lvsGKCcfh58KU22fE/Tu+Q4Ua0fasASeCHlwqHoDOqaeVa8ioCWPUpXSPqs7erUGuzcMQ2/QMEzExKrISZBg15n60GjEDPhrTWkHd93CkGGwBe6cfEkRdCycd0HnJgfe7uvkL/2Ao1qPKWDzv6JVhRO/79o7rom/7JReiYfLfxcfJeoif6TG3qxW0Vb7lLK728caeY7ToMT7y6f70mqNQWmN4dHAQoJfXanIFIoNizDSvJv/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199015)(2616005)(2906002)(966005)(38100700002)(41300700001)(66946007)(6512007)(66556008)(8676002)(26005)(66476007)(53546011)(6506007)(478600001)(6486002)(36756003)(186003)(5660300002)(8936002)(4326008)(316002)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PD4qJjZ3/0lzHPfjn0qejAlhAgYWXE8DdnQUSXkWYQR2lNk+c23ej1/iO7SA?=
 =?us-ascii?Q?kbSclCHsKRqCpzXdgwGlsGwh14mV3CYCWj4EX/WkAAH+3q2WaPO3W3LTRZbk?=
 =?us-ascii?Q?gzQjYU9SfGQQLCN+2fJVwzrtHvyk0YHr5t1TbuxSIMnVniwk6tRS2CyhuErt?=
 =?us-ascii?Q?tvk9r/aq25mk8VMneOwm+8Ho+vWMYQPH3wAPBLkDgF5iID9fpfUo8D/OsT+2?=
 =?us-ascii?Q?BWGKX5so+GeTumj36l4SGMda/PT2NYxMRfVkqE8tb7UpFEUzJN9NGcF/lkmn?=
 =?us-ascii?Q?qrknmv02eMFwrNcokWtFRhn63K7NBNU+qeYMuCwF0bc5+aE2nVqBJIL9dCcQ?=
 =?us-ascii?Q?UCN52v4LDlddt7iXQ4r2Q1JB8UD7kXb6SVPwu1s6czS+o9JDXwW+lCOizUh1?=
 =?us-ascii?Q?+qDO3bfMTMUcLzkyh7ppzfwUaiqdwbWuzH34/yXV9ugcLRC9t9YB38Kp8Bpi?=
 =?us-ascii?Q?aBYiHz/4M/mbwiQQQSYyroUVFtKaERyUhC2LTArNj+kZ1S8y7JSJjwlmGuy7?=
 =?us-ascii?Q?C2wiCD56DgFnDqsUx3KVgH9jIu8uiRWDiMKF5lE4SKcFZ6iDQ/eWEqmgz4Ny?=
 =?us-ascii?Q?2uGk4vUCB4qyeumxv46qEbWcpCDkDN+ch8TSG31/kXhr95SPYnt2W+uaGlSh?=
 =?us-ascii?Q?BUDOYAGS/0ZCYtWqjD2IruOR5YTMqGRa5/8+lZaxaxH0C1JyG5pP8H8Um6i+?=
 =?us-ascii?Q?VCIbm53DiUj/f4xXiIo9HqXRERbRi572JBUALYN3jdCoM3//02UkDWx8DHZy?=
 =?us-ascii?Q?DvcHivHOhEXG5l+sVJ08cB9g/XqN2TmOZv/KK1c3WfwyCQgeGRIr2Brs3YcG?=
 =?us-ascii?Q?pIdag5XvdArUeCjcEoTY666XCy9U8v8QYMBORvw7aTOTNB95r+0ROi7SZPyG?=
 =?us-ascii?Q?AinzAFxTzon/pAcuuUW37cGeVH3W/9UVCLnTYFYcBkmsCowbFCmiHXQ/Bjp5?=
 =?us-ascii?Q?T0wzltBUy61GIjzvbNQz2Xf1undb1DFvBjE5Wpq4MeyTFGd/25cSHLI3jNqc?=
 =?us-ascii?Q?m2OOgOw8Kak9t/8nnTmzlLes+AkeLcYBiC1Rb4n90l7Jrq1Sosqp/C2Dqe5E?=
 =?us-ascii?Q?EHRuZWvNGmp9kHiuG6Q63NveuO8SoPGke9ZRA7mUCFU796l8bfBJqrV0O99I?=
 =?us-ascii?Q?wjc+0cGdSxRjlkYV+U6HLy3XJI4U6raep/dcVZIMc1+SgBzJopY0m5O45o4t?=
 =?us-ascii?Q?aXyqZX3OuM+lWemmQs7ePUZOnHxuJB+Bhcm4XQaASpuvtXpIwhLLW5mZP1LI?=
 =?us-ascii?Q?WuCxQXc41SPVXaBSCCHsJLAp3mqS5HBMFXelbUdj6EKvo+8o+sGjkNKBZkpK?=
 =?us-ascii?Q?4z8FNoALUJiwIrGkRbaRB5KPAZy/vARjjSVbB4SyA4lcKvfvnvtccRAJjcYB?=
 =?us-ascii?Q?F3tHbgXmYA2Ex9C2/eoJJESqSFANiAuFk8JF7PsEtx3rhE5Ec33KFPj4JIQ4?=
 =?us-ascii?Q?NUE10LtBvcVakDyN+52jC7PiH9bxBgbpa958CQKu5XZobw6he3n4ry4pSOK2?=
 =?us-ascii?Q?83EWxLY4z3ys1BdP9mfayvSZRDhhtRG8el9yXpW87/+FiaNiq/8gCoarQKwi?=
 =?us-ascii?Q?s+DSDE8alifND65hlcM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d881f942-cfa8-43bf-a254-08dad32ba9e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 23:36:11.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgvutEtJr57TCDBZAkLqrufP31io71rYP7sG/0VHSIyp8GVB6n247hc4vYPXxtAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 30, 2022 at 02:53:22PM -0600, Bob Pearson wrote:
> On 11/24/22 13:10, Jason Gunthorpe wrote:
> > On Mon, Oct 31, 2022 at 03:27:55PM -0500, Bob Pearson wrote:
> >> +int rxe_add_frag(struct sk_buff *skb, struct rxe_phys_buf *buf,
> >> +		 int length, int offset)
> >> +{
> >> +	int nr_frags = skb_shinfo(skb)->nr_frags;
> >> +	skb_frag_t *frag = &skb_shinfo(skb)->frags[nr_frags];
> >> +
> >> +	if (nr_frags >= MAX_SKB_FRAGS) {
> >> +		pr_debug("%s: nr_frags (%d) >= MAX_SKB_FRAGS\n",
> >> +			__func__, nr_frags);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	frag->bv_len = length;
> >> +	frag->bv_offset = offset;
> >> +	frag->bv_page = virt_to_page(buf->addr);
> > 
> > Assuming this is even OK to do, then please do the xarray conversion
> > I sketched first:
> > 
> > https://lore.kernel.org/linux-rdma/Y3gvZr6%2FNCii9Avy@nvidia.com/
> 
> I've been looking at this. Seems incorrect for IB_MR_TYPE_DMA which
> do not carry a page map but simply convert iova to kernel virtual
> addresses.

There is always a struct page involved, even in the kernel case. You
can do virt_to_page on kernel addresses

> I am curious what the benefit of the 'advanced' API for xarrays buys here. Is it just
> preallocating all the memory before it gets used?

It runs quite a bit faster

Jason
