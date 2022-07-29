Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFABF5855B6
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 21:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiG2Tsa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 15:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2Ts3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 15:48:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED287F55
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 12:48:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzL2zUmECYPqkbrBJDEUfian9WIDQQyHHcZHo6M3U3ty9dBmv8VpP7ReaDbJU4wu1FQ5PMBCU3GYWTYe4wSHD4pJ+KwUCDqamVuNUdwqCrzCpt4nkkm5oMIEiROn4AIkHE2AmZHLYwnOVokP0lE+AINA7hmm6HLqtN7+ANhz+pJbASL8KxvJhckBhi8elVLdB8tV4WNHSiPoT09x34nDpBJN5lLImIbd0gR6V3bFBRy3gA/IWfzpif6cs+uozOdXXdJe2NjY2YGVHGxsGnx9QC7J4PHi3raz4YYBl0uvMz0PTJsODucsxKdcCU15czOrpZ9k2kK54HFu4FCJehvyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT3UoUcSCe2R/6s2jzIa/hFtCzKd4o7WeVGGhEqaH+A=;
 b=iSGxFy0Jd3ujs/cmFKQRT4OQZ94sg1q5M4/mpLHqUogTTx43nEMtTKPB+v1Mlj8h4DWx48J4AHZbc5xl+aK/t1dfp27GMb6aVg79qKbywbkXPixCOq2JzymJx9PoCHsUkWTXQWILYTYKZjO1dQsH9DabzXucr5jVlyVa8UCHu0K6GjTSkEtn+OrzOZQLa0JLV8on8/+4k7xtqEon2lXiqPuZxwGM4dWTAtLeEs+EZ0emN+utJNL80mdU4cbO4tH7NMtzuiY2CyTJjGdlIkMKmmhN/bjp37wupB99ICsSr3LhEj/TGxEqeHUhzbjkud8YDzo/W0YxYQg0Jx/Qu8WUSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OT3UoUcSCe2R/6s2jzIa/hFtCzKd4o7WeVGGhEqaH+A=;
 b=rZaSdf/FTo5HsNwg0kj3ERFHL97n2LsZVeRBrnC2YFM2XRw0aINmuNSlOlYTn1XOI8qrzJawo3Opfpdc7kgMxh2cw9cYxbf3gUK4YXMNkUQjpcdHsZSk4gZ2S43TtKc6meGRvIVSA1Zo8uJc7S+SvBlbqk+bajnww3YEJhQQ/WVpts/qO6nrvbPNV0jXkojgliYqTuPB8ElrhiL1P6eZmQLzMA0VU+ispL+YEzzhN5ZcCl2T3alQXBvvYGO6UHmzDh456oRxTd5kqjIN2TnnSWB0t+LxbMs2YqQZ4AWz72GJcEARCYOXL2X4uM6WhRoVeokzTph62dd3zpAkkOcMjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 19:48:26 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 19:48:26 +0000
Date:   Fri, 29 Jul 2022 16:48:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH RESEND for-next v6 0/4] RDMA/rxe: Fix no completion event
 issue
Message-ID: <YuQ5iYNSOSyVLZsz@nvidia.com>
References: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 506af436-d757-479e-cb56-08da719b4dcd
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJ4skgZuymDc0Z+xEgifX53KSrqclcc2Ngfzk1veggAWJTDSobItk91oUJeQaGQ2OZiJvySNEnUPa2LmNrTWSCyrNLnDK+rN9zpdpm/TFH5zxGYK8YwEF41wuY5ZQuNlkz7tlgTpzZI9rYFthoM0je92017twghN14c7wicXiXwMwzUtusoUw77Gy/Y9NNIPBf6q+UUp/sYcjeYFOApabNHicklYOY+f3ia12VuN79uKIupa+rK/CT6zcyXYKH5BrofC2gTwKp+ujAdWkMfK57J+FZk4goOoAmO7nvmZk4lxo0Wl5EZz0XeZLPBHl05hhA0akEcuk1x5ZhXz39I+vGbGoHjYy6YtJaYf9R3ArAdm+soTboUSHyZUD0284X/ZMVYkLpgNBTWM2fbdArknpmp0FDN1nW5N7Xob4Q/ZPf+vWwo+xXQ+mKMe91MQw4YrKndbnpw4lFt1EwOxFaPxmsbCV1mp7+GS4Z1+mX1lpRqTJB7kViYCvA2zgAXlXdSo4oseKmqJzvpZEGvg0SnyISE3thqcLGZdwCB6F1BQYXYqUs3ZqjgCbePY4GnkU5c1ThXi8GFqWJwxxPSBPflQCBiCNzcnlq8WDPS7yEHPTVfjgB9r5XhKtnJkCxW8u7sIcsovd49aw9rsnHHTW9jTKjaSjUvcznrgr4h0c02Q8ogs3swG4BkyT2rn86dcEDrxEgt40GbeyLEXRUq+eD1OfMQEMD3b9PRV8dK5Zcjh/KQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(66946007)(66556008)(38100700002)(4326008)(8676002)(66476007)(8936002)(478600001)(5660300002)(4744005)(41300700001)(2906002)(186003)(6486002)(83380400001)(26005)(54906003)(2616005)(6506007)(6512007)(110136005)(45080400002)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5wzl+9Jvkp6oo5NwYo70EYU2Gb8Eao/s1190aMlM47pik0q2NfTn/yza2s3H?=
 =?us-ascii?Q?fxj53eRT9Jpg6sSbPblHNPi+euDqhcpavABIC3G9IbOjEseCfWRqlWGg5noT?=
 =?us-ascii?Q?MHkhvsiCpXXR41Xc0kA/+NaG10hPQNFUZ/oO/sZHoB7IbRU5WYIaEm9lsQL0?=
 =?us-ascii?Q?qXyCuEbZHak5HDWJU+PDGfdiJygQYe3ebx+VHI51VrACJeqho2d++vMFBI2z?=
 =?us-ascii?Q?WYOgS1/UO440wZvHbYuPGMS+7xWRxHh0hK8gpq8zFZf7kPQHXOqDyRF8cYuT?=
 =?us-ascii?Q?X4WQnq9IoZ3HQdQmN7xJ1St1mRFId5mSsj22JsKYbFzDG541EYz6ddETPnXw?=
 =?us-ascii?Q?e2f546LjzF5m1Qk/X143utTWLyIgFdd4MkAsbhT4KH9bLSbanPnf/IoVyjbC?=
 =?us-ascii?Q?pkm+MCTJco3+93Pl8ZYsEIT7hiR6sM9BbIbwsv0zHP95bVZ6MC84EZf6o91Y?=
 =?us-ascii?Q?ABqC4oLt7ien9KzbnQykGwNee6Bi5Uui9wMEK2cDKVFQry+QQN9N0uoAYoG7?=
 =?us-ascii?Q?xMHimBEaOSWhQLDRFssqLF6tyzCuG8ppX8x2BrBXSXRWyAKuM7WhpgMS5Kse?=
 =?us-ascii?Q?Ji5BA0kPlTTSl1KEKztbmsxfQaPCVLtqxWNmaqycNzoc8mi8gnlylIZ1+WAO?=
 =?us-ascii?Q?4jdgGLnydqNmfl5EOAImrwh5MWh4wKpGXYVzpeSstdOkXPrF45Mu1f8OPMwU?=
 =?us-ascii?Q?10Gaxy25PcprpqOGcAfWt8erFe0aM6BSOax348VxkkNYzzGVXIHgnHi+Zrfh?=
 =?us-ascii?Q?TdTVFnVHnm7CjzN6/BTF8/QEdcx+tiZb91+U57ewe/FwPtmv7zU37knsH/3q?=
 =?us-ascii?Q?UF2QeLP8FK56kU92zeySbCDuF1S7hoC+37ZM05jWjaC8qVOO34jbqaisXqW9?=
 =?us-ascii?Q?chNTJoARkQg0PyrL3yzWz/SKmmkDglYTxyAhfcPs6VbG/ryTaxowyY7Am5hf?=
 =?us-ascii?Q?zxrQI/oKLF8cmV/ycuHAdDFmlaulL+irrA4TQxwmQTF7tvongDXeF/EEuJ8w?=
 =?us-ascii?Q?ik8C8396vmFae33+KESmc1vNYywFTTv0UZy9DpqPfg4lH4PhjeYf14GSvrIY?=
 =?us-ascii?Q?Uq+0p0fHZAhPOAKRUEs+Bxw6NK8rP2cMlkMF1YRGJkGdnN6TrM9MJCiPnYlc?=
 =?us-ascii?Q?2SH5rKWzEI74V0YQ5y54+E9V/3glXksTmCN4StXc/9/Iw8ZnyYtLUGsjmoN/?=
 =?us-ascii?Q?yk+xUTc/RFkFm8J5GlZgJSbqajtgQZtb4PauiJhFTBMsPrTHoUot7CQBAab4?=
 =?us-ascii?Q?rA+fux9XaEj1r5n0JFjrS4oz9H+bUN4zYfMDY0gpBxBXSFHosTUYhKGOUJU1?=
 =?us-ascii?Q?Tw7cMtFrzpH19T/Zp6sIwFURihpuS0d568qRn+WWflAiuYSQm8OaEpYTS+E1?=
 =?us-ascii?Q?FtfqVKrblo9M/P7HjOI3jAV+dVIZPbCLFS6crs3bbnmDo4rSvItMF4B27p8j?=
 =?us-ascii?Q?znwUnsp84BhzxRgrOT1XB5wQvDuu+FKJnEPLQVSz2/gSVX24PRwUPrdoI5zr?=
 =?us-ascii?Q?mWbanu/OWT5mfJsEylNxEPeZpkaHD0lKjI2wIggpAJbBAFBfuVG1kRFnMOOx?=
 =?us-ascii?Q?aGnIrlYiyzFuMMrvH0rajL+e3wngsVoU3KbTbeyN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506af436-d757-479e-cb56-08da719b4dcd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 19:48:26.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNsgS4+GqWi7cau8+oVaVxy7EU+BSr5jA4oeU/CsaCss7q5bvs2QlRaYEo/sBJ/0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 20, 2022 at 04:56:04AM -0400, Li Zhijian wrote:
> No change since v5, just resend it via another smtp instead of
> Microsoft Exchange which made patches messed up.
> 
> It's observed that no more completion occurs after a few incorrect posts.
> Actually, it will block the polling. we can easily reproduce it by the below
> pattern.
> 
> a. post correct RDMA_WRITE
> b. poll completion event
> while true {
>   c. post incorrect RDMA_WRITE(wrong rkey for example)
>   d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
> }
> 
> V4 add new patch from Bob where it make requester stop executing qp
> operation as soon as possible.
> 
> Both blktests and pyverbs tests are passed fine.
>
> Bob Pearson (1):
>   RDMA/rxe: Split qp state for requester and completer
> 
> Li Zhijian (3):
>   RDMA/rxe: Update wqe_index for each wqe error completion
>   RDMA/rxe: Generate error completion for error requester QP state
>   RDMA/rxe: Fix typo in comment

Bob are you Ok with these?

Jason
