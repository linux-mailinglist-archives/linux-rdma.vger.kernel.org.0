Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1839B51FBBA
	for <lists+linux-rdma@lfdr.de>; Mon,  9 May 2022 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiEIL4b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 May 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiEIL43 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 May 2022 07:56:29 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9402179403
        for <linux-rdma@vger.kernel.org>; Mon,  9 May 2022 04:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbL1P3dACmQ0yqfYUhO8lNmJnqi8qsDr0GlIUprToPBRSlPeC3NScOa7IGeWPnBVG39sCLEtIyk9sOeORJ5q1eXl8Zs4Z0vMs9oTHUuWVYIf2JuEPmtPbLtl/7qtrpghIXlb86afOBBlJCKXvC3Agq6mghfO4emO77XAz4F1/CNpf4ryVzDk3pqRaNyUkHwv629WfHGvmLZZTQ9OBP4DzXSUeNIlPDMOcQEs+X7NArIpk87f4q7XTPnoeMMGOw3TA2NHE4Jh1+G4LK7/zyyN/b1jemLOnqUuizQ0ilgkUQqabcuVWhGlklLudT3KoHTxIPU4W8JQ39/+Pw/OGJwxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ch1o7LUA6wPnS0BhNLhx29GFVWByJFNay770vRVl3BI=;
 b=PcYmnMyVZ5Q85Gdxwa8RuaOxHllHGMG5d5I+cfpKvojaA2u3Wxcaf/QWCmxJEp3i/S6hys5qh4GSSh76L3bk7JoXqx0ZZ5CEybFs/u/xP/4TdSF+7uCM/IffUu4SI3YHZKVvQtmP9SjUFCF7Ybbc69EMfXqNaBvzjwQJQ2RjuKb6PaxWuWrpXAGEPiYTTPlmo2wubTNa4wZkXwS0/+RZOKG/juXvsq5h27nfmi9SI/8wwi9l9WaVGpx1Se9lW117wOCksq3vAuesJtTO7czf39vSB5TFmXCz5alKrbm7BZT5QjNKfqZudOTcSXA4uyB8sFZaE3TdjK7FUHsZCGkGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ch1o7LUA6wPnS0BhNLhx29GFVWByJFNay770vRVl3BI=;
 b=T3JId86FZh73mtYi3aP7r2hSvZYhSsp4QcznkZBcgkeSyz4ApDStvsRtlzl9eRQvQgZUR6M2gR3bSNsIW5DmTQbCNAxyVfGfntX1ZbGs0+2EemBsWWK9pdCTs7mZzYSweh1ZMbi/jeQr3LmF3RqVCarxIPx4zQ3Pe4ivWwZ9kqnjR7glv6SRbqPWrEf+hPIe2beAM3XTAM/6nc3qsFMV4zTC3x9d5p9khsiPkitzY1ixxZRkuXnM45CaG8jbuaWNSUcs8YFAhYAOK0+3A52jykA5P8j3OYntjCMzRLU7ZxCWaFPADXkRIYsI3K/r3Dr2zJHRNRzuS4BlQ2saSjJYwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 11:52:34 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 11:52:34 +0000
Date:   Mon, 9 May 2022 08:52:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: Apparent regression in blktests since 5.18-rc1+
Message-ID: <20220509115233.GI49344@nvidia.com>
References: <e7c31ebb-60c0-cd57-2009-5e9383ecc472@gmail.com>
 <cf8b9980-3965-a4f6-07e0-d4b25755b0db@acm.org>
 <4b0153c7-a8e9-98de-26ae-d421434a116d@linux.dev>
 <20220507012952.GH49344@nvidia.com>
 <CAD=hENd1kTsy42qDmMjcAhB_rO7aa7eP-G377R2DDE7qkqRB3Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENd1kTsy42qDmMjcAhB_rO7aa7eP-G377R2DDE7qkqRB3Q@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0232.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e8175bb-63e0-44d5-4710-08da31b267b4
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB61326BAFE32CB97260272922C2C69@CY5PR12MB6132.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVNnQbLyGvtCjq/Cw+9083BVtewcbfdMiHgdEKv7PfwuTvb/4OgXRMogIzQacnuy7CWjNLiNNrWEwFgVWQecVMEoY/GUpPlECs5k7I6pvtLPx4XKsLk4jQVpdc4XBF2R9ya4eBDPAPpBJj3veLepZ1f6pxy+iIpCHWGsEW8n6jRZRWRzSGTtce/2vhkvIid6PaWHIsE142ZfwQ0hayH/wDlUiZHa62YrKFYNV/vwmTs9H+dbSFd13g0XlzBAsuQmkgCB5r9goW8mBgrie1rPU6qj6XMHmzp/HtDppt3MM7Kp+dG20AWg3WVJPMdD1sk+VQi6131k6Zbt6g1e+oTSTXm89d2+kzFg7CMJ4kBOlm/HF2zqrpbMGfJyaB01zc/1RvXQpO6uFbiIYunXnABfAz4g+vC7PXUSzPLJrG//xwIQ591wgz5RYk7c6u3fXuTD3fsq2pEY6uNtK3GNw+uE2yA7DtdkCJhhrob/p6n5gFXjT4+rhVsOljh9CQKJ+FNwYJY38yDcEdS6VfAS6oosZSw4WFy5iFV7reGXHgYgoV/7RUTEW+9c5YjEybc4ootB6uFg2XMU5qYfqLdwua+7zrPcjscmLlcIFz5+qLQ93TMCylCSiard24Uk3m4alveQhOzEajv7/LMQUIta1DBtjMyywl4NnoJZ4PJDFfo0Qk7PzkyrpZMGhmmHSM/ucxtilzFOKmWhrvrVlV+jWW2SYSuHOSM6qYAZOl+boe0hixIRSHTIt2OoneLhITqyXgbxTdmY41ceLwxAwayhwbItog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(508600001)(966005)(38100700002)(6486002)(8936002)(54906003)(6916009)(8676002)(66946007)(86362001)(4326008)(66476007)(83380400001)(26005)(6512007)(6506007)(1076003)(186003)(2616005)(2906002)(33656002)(36756003)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9z9T/4WZKfVLLdnaYF1+ExdUvMOGHQRrmGk3ne2d+oXvt5lyNMvEN6N2HCmI?=
 =?us-ascii?Q?VRvCEeQBzIQF8Ig8Z7hYZM9For6wqHA5F5SfbePFBpqZzYsQefQE25V3ZHKV?=
 =?us-ascii?Q?d1XFmgZzcHa8KkC7cT223Bq9nficdAkISlIf1/Wnhr0BPnV/PY/ZDnoSCqk5?=
 =?us-ascii?Q?UkUwqG7U+DZVAiIm8poUYMtxkqkCqjC4cg7ueq8h10U2fQ9rl2vZXO09/ynK?=
 =?us-ascii?Q?7V7g5xQ1ia+r7zOMVQenvSUNb/Ek7VvvzW9VCl7liQ9YV5yKJQKqV7YZiuGS?=
 =?us-ascii?Q?6pppjCCTo/tTjDis1tk0a8Xg/nCy2d1Hpdatq7fKyW3kyDsWe+mNQcqFqvyN?=
 =?us-ascii?Q?LhQQLQCoHiJP3ZtzJ77Z4E7qD753bxXktThahH+oNyLdrF1KmmvBn1gVf6Tg?=
 =?us-ascii?Q?Yl3n9XwZcwZ3obJL0csaIh5N7Wh5f+KSwalpVJxs9a8iYoMP9HAP8L9Ijf0/?=
 =?us-ascii?Q?dQNIgc4bj6cBwMGYBCQgPus9eXLGKyvsPtD2tIGsDiQTn7a4XArQFmBcYDbL?=
 =?us-ascii?Q?FuxmH4QpxLz2iS1K6XVrby1oT3rhmUybO+jPDiCAdU9nP8nrERdjsCUcTfi0?=
 =?us-ascii?Q?HlsaPZKqV0lara9RST8jT8qvd2IHRusFCTJ8nabgp0onuWG3r1S2NdBF5NWg?=
 =?us-ascii?Q?5J/tbINpMCJ8KzT7dY52vre25G+O0AslwcKtQ2rb2byxc+Tq/9J00oBc8T6E?=
 =?us-ascii?Q?oidzaWHJ7GVIFgx9LJ4seJyjb8RohQYygraQkd+76n6Cw0EcETL6PLDU+Nsg?=
 =?us-ascii?Q?OzPaQG3eglH/WxUdXRmvYmSWg453hOtAosNPAYNN8cQlNxH+1mah83jQoMRU?=
 =?us-ascii?Q?aAElA7A4ciyg/rHQjRPgEWjtR+wDDMK0/a33SD/pTcWQbPWtYrIiHrrq3YX+?=
 =?us-ascii?Q?qAwaqccSDKkPWDVyZMy6uGGLXR/fuS7jvFyG80oDr3x9hZmpmdTm+JrtIALT?=
 =?us-ascii?Q?UNBHJihlDxU+dPPOSRWtTiv3Gmaqk/wvPDhCiFv7fo0xYN2mArMdc3nc6TM+?=
 =?us-ascii?Q?gC7alntQNXa40hQsuUIvzCj0HQOMtq7IkFYkfaRdnA6eZ7tUfp2x247yMgpy?=
 =?us-ascii?Q?Xc7EqtU0jl71y82aH7oruGv5TJZmZcQAXZqah73Igoe1aHUxg2l4mcuXwP4p?=
 =?us-ascii?Q?rIkOo4BD7aO3D2FACN9rexPxGxT+FOcB4SyZcvtTTkv7z0PMj3E9xWHfK1DF?=
 =?us-ascii?Q?tI6KgXbuXy0pDHP68tKnDglZRPaHmdSIgeEgFE/rdb2OcGaPM83JyE5z5i56?=
 =?us-ascii?Q?jkPjTuGwNv3hXdRkJiJtlEwgE61bpWfnA+rj+hMt0nsu1C71BeWH0WNmQHse?=
 =?us-ascii?Q?hTGPb5VE414Xf3MqO/Gb4MB1LH4OWBYIw2BF/iF6FFIV/AFljD/LOdvZ6wCA?=
 =?us-ascii?Q?kDSiAh1JK54p1qMNJutaYkLFFCzQerCMSvJY6v2oQleN1Ba6nSu6o25luzRs?=
 =?us-ascii?Q?ozQ7pi7aXqlI4SmR+4Lc8666KvAE19h7wh0BNtJZWT2y3w/+8oSjtJpp32ov?=
 =?us-ascii?Q?IHOaIH/fgLhu8DKe/Y/ZUniP3BHQCqljAhrwUJlBN8TpHrX/wjVd1dbV65Fd?=
 =?us-ascii?Q?MBahmIeLIg+plGC18h2XXUom49yM9Z+sqxBx9ojo4cgfLm3T26p+zK5umoXW?=
 =?us-ascii?Q?YgGsTLsBaM/C09Jo2xHDDwTsAdCckVV8IlCenFMMJFt9dcW1UMhCMK7TAznb?=
 =?us-ascii?Q?zNmifI8v3wb4G6BpEIBsNqLEcy9btMzE74fFV0Hk7+TMPfbmzoMA6o9wKSi3?=
 =?us-ascii?Q?2USJVBXBFg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8175bb-63e0-44d5-4710-08da31b267b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 11:52:34.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEum61RSi/vC7+MV906dCkyVCFySYaldBvx8sRsZll7tgVGG810tM6IP41Y6aAtt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 09, 2022 at 04:01:19PM +0800, Zhu Yanjun wrote:
> I delved into the above calltrace. It is the same with the problem in
> the link https://www.spinics.net/lists/linux-rdma/msg109875.html

Yes

> So IMHO, the fix in this link
> https://patchwork.kernel.org/project/linux-rdma/patch/20220422194416.983549-1-yanjun.zhu@linux.dev/
> should fix this problem.

I'm not going to apply a hacky patch like that, it needs proper fixing.
 
> And if we want to use BH, it is very possible that the problem in the
> link https://patchwork.kernel.org/project/linux-rdma/patch/20220210073655.42281-4-guoqing.jiang@linux.dev/
> will occur.
> 
> And to the RCU patch series in the link
> https://patchwork.kernel.org/project/linux-rdma/patch/20220421014042.26985-2-rpearsonhpe@gmail.com/
> I also delved into this patch series. And I found that an atomic
> problem will occur if we apply RCU patches onto V5.18-rc5.
> And because of the atomic problem, I can not verify that this RCU
> patches can fix this problem currently.

What is the oops?

Jason
