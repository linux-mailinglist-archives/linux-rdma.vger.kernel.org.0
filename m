Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB75EAFB1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIZSYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiIZSXk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 14:23:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8B22536;
        Mon, 26 Sep 2022 11:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cln1TVgx8yyGxhcNSCZ+3/ZI5SvJ3aw5ToAQxCvQI4MZsWNm6b1Q0QT3QbBSTTuZsZyEf0msAbNiZyD5sC5JFkmbH3WftM4y773/qKRB2W7t7c2FFsV7HACzvADMMl84lSIweU0/Z5jFxT3xAYZnpz1w8NWpxj7kqHTTtvNEr/vuK7sgTQaH/uqQppBCaESjltA3As9R3aDOgeX+O1OU6cAnNxzE0alZuNBCI9xo1HLTy6at/rSiA5LscebqjyQkFcyi1x4yCaqVBh6AMIsbmRfBjlKaDKnkHjW8i7J7Wspb3d0JFiGLtsl3fc5E8q/fBn/EB+UztlrHjQsiK5Ltng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qb4mEtHY+/W9DBXj5cEWY7wdjODscrMZgJlj6AJibn4=;
 b=km6jKDggsuRhDsH+UBjRfaV3csQyx0CrtsPaQ4jhqSUqNMODstWldhKhzYMssWAIjh+WwhQ6gEgXxBjjpM38TuV81FZtNinRxgoHkwANU9zh9uQq3slQfqXCvvNYcQlbCc+nPFxLYKSrTYn5QYLcAzU7zSpmkQmCSfFu7Yc3V55N7Bv9RP0Y0UqGbnInqWylcyRKWuds4viQj1nH0wuPx51KWGy6Nmvchtpd3jneu0RYpuBBdZnL6c2c0sziitJ/v1VsNCjSraQs4+aLiN221vAYRcM5QeRr5GfTZgeK0WH15tiwxexc0+svXX1OzFkcZ4x/rYclEaPBECvFqTaOZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb4mEtHY+/W9DBXj5cEWY7wdjODscrMZgJlj6AJibn4=;
 b=h/vQXRIY+XABFoOtSu5+ok9qfG+PCJWfWdb8Cmgumdei8Tr8BHXsmfCCrOEu66K6RYidNsllkzw5s6hUYdxqjKdnEFVifAg8E095+sxgBPbfqk9lbumxgw1L0f4uj3f+8vLmnZSt7dDeLmNN2aLfHOQsPM8Nd4hml8wg8T9AL4LWilbnkekdusTLhO3T+B0+4ajA9SH7dc0eWeNjY8QTqkyWssdRYaXzkmvEKnG/9u2V4q/hmQhNQqaPdgdMsbPTIoyVqfgWpzcd6CwvfZ8uD92meM/9qFrPmT16kvNSH1TG3VcYplDx2kMWPkMyTRodyKb4BIj5bz11nmm7Eu8eCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Mon, 26 Sep
 2022 18:21:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 18:21:42 +0000
Date:   Mon, 26 Sep 2022 15:21:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] headers: Remove some left-over license text in
 include/uapi/rdma/
Message-ID: <YzHttWsmFSMR8vCY@nvidia.com>
References: <6b2b69c1eb89a37b95d17a1e866c2e8173c6fd15.1664113175.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2b69c1eb89a37b95d17a1e866c2e8173c6fd15.1664113175.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: BL1PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:256::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efebcb7-6c87-43ff-ed96-08da9febf64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX13WgXlV5eZkRQeLiNtI+1xFl/3gnNPIE5SFmq70cBi4L7tnMVpFF1Jehh0auYJa1apRoU2fQYTTNA2d8eqVlHq7PsdA6rxxfmSQGQlba+TaIrPnHzd75xGlw8pRf4d0YIxWgTy5MxyKWLz/K+tTSy/bSlecDHglmHE4ZZzJtAujq0mso+YeGUSBKdWG5zwUGWs/Lq8q+92Qr6o61JnK3BJhZxbxCB9sYbVYqCidywQj+SZUZNeB0u541nKjeSa6j0dwW63OBp/FSTqtN5kE49Z5/CY7qBdMGpHMnxHbtnF/5yduoeHy/CX0MfLdwx71ud74WCBgaxJ1Nkp2bcqZZJAQld7IREn16LB0KyCY4ovzxlSTFU5/cT9zKMHHdxh0g4w63AjKpY6eltIF99K2GC1ue64Wgv3P/sgwIEgnGcAbaWV2Z4ONN2yXkQY0j7I3QPzvqceoJDA2H3YTquMnvRDQdxzn7FoUJZWT/HvFnFO8ZO4RgJYVMoIOKhW1fVGhFhpknlEmRC6svEaWsW7wjMW+CJUwS76mKMPkM95JDAXy2wysBUavPq7uAZQGI9RtuF+WYnEop/rNU33wBuwVDyjEoqRNF8Axn9Rc4UuZV/X1e6nfSCr6O1I4iO1UAYTrLQdyywyhsZ0IGz+fgqZCZQ9BAfXtQtc2CBN2BxSSjjDsfuz0nXwqPIjUS29yjbtVNo5jQf5mCVCKViAea2vXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(8936002)(66556008)(66476007)(66946007)(4326008)(54906003)(5660300002)(6916009)(316002)(8676002)(86362001)(41300700001)(7416002)(36756003)(4744005)(2906002)(38100700002)(83380400001)(6486002)(186003)(478600001)(2616005)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yf0y1kiCgIYB0rLojaMzVaBl47h0rp+WcgarQB6WLOZzOffOHM98ZVols+ce?=
 =?us-ascii?Q?TjBTGXcQutFsFgMYf1fDaOXd+1ZBJvPkE0aVTKn/t1v7JhmQFJPVHbifjaGG?=
 =?us-ascii?Q?TDs0HJicdINjT+A0ZJbuGkgI9JLkTno9rdYlam4HcpYlcyJSW5TJpw8dbWAv?=
 =?us-ascii?Q?FU4/jP+lZzffGu8mUWQbL2xtOXd5+BEBDuP/DAraavGajZQPxCMiFS/gXIO0?=
 =?us-ascii?Q?1uTE+d/loFAjUkEmNxrmQJ2jNv3fngEOdiIIA+nTTv49NHcUEWc4bLt4WqUt?=
 =?us-ascii?Q?0xBS3rmsaUSN4QkiUsdnjB4E16tFPMkiCJdWybJgchObxGyO0sZzxMQYZoUz?=
 =?us-ascii?Q?46qcMfIz5CTThjnGQqMkmv4uEyewxlK9nLMvgBMo5ym3VqU0pGTFd06VLpEK?=
 =?us-ascii?Q?xwqQbFMRRsD4wavKgaeMbfC1aMpq9mnDgKJJoINzoS8Z14HeIhEfS8Dba/cC?=
 =?us-ascii?Q?J9l+D2+8FFcfaaDnE28yTM1oGTnjpkMXK+NxjlkwhdWgw9glWBZhzcSKL/bB?=
 =?us-ascii?Q?1+biL/WHggjZ+Cdzr8jkIDdN929k7G05b4xRZ9nOJ5hn9e2v3541B6d2DH9x?=
 =?us-ascii?Q?me6PXSAb6Em85o7tMHwe0bjxeXo9oa4tMmuDF8iC8GTkMW8vk3l9ZVn2RqYJ?=
 =?us-ascii?Q?FjBIUoa9HaQ2PFoWy7lg4UwYf+EXkWy5t2VqdBbCoL96gHEceAxwjvZ8VImn?=
 =?us-ascii?Q?BDktrD4gKPED/3qsHVscjTSSVTXLaOZUjNoX/yttaRBzab9nJyKkkIqru7WK?=
 =?us-ascii?Q?CE59c8PsKK6ukOrVMderap/DwSJG9AUGbriQvmd0HFIdt8S8hHzDBo7hvONO?=
 =?us-ascii?Q?24a/5l0EEd0XJaoylGBWCgQ+Jf31IsduF/rEheBZOup00pQ7ufRrcuIjWpA3?=
 =?us-ascii?Q?C4iK91D8kxTC/XqJmr+Dgvdu8imUUzG8Bc2eKFLrq24V/RZJ3yUYPQIqK1IS?=
 =?us-ascii?Q?4Tq3M2lqLORyb6X4sNN501NN5DyrG7nNAh325Mbd8STm78fwBmxLP7UGd7RB?=
 =?us-ascii?Q?w1+U536vDq2ktlb17u4a579wqumPGwNwWSi43ijqXiVTJNwFVfZmL65DptyS?=
 =?us-ascii?Q?1bdkRDzUJHb+rsyTBKjNSZeZ84j25+5Px1cGyczbrPC1YNhjkcXbjxuhxdda?=
 =?us-ascii?Q?ImfPrGP1xrtbdmUZw7x1liQpM7OUqoruKqmScY3Ozgsa5Z47rBNfCjQAAXJ/?=
 =?us-ascii?Q?u8Wb83+FwmA64msmgYr5blDV8FisXp25ou0ZnhrfGuXJ7JZPhEx/9BtOSKsr?=
 =?us-ascii?Q?8YwrV8vtwzqnI6Ga+yyV81W8vr3Sip1OZifCCyLDcyta1uikSf2/wCVAO+RN?=
 =?us-ascii?Q?iiRAP6h9mRZfsBwf7Z1G31cd1m4vMkyJqg9L2OR/4+a+g8mSH1bsY/C0fvP7?=
 =?us-ascii?Q?Dq+vqXJVUkyhlkLniuw+DPIiqHqApJy11PwyPeSmc0RII9qwIojbro0zY+4o?=
 =?us-ascii?Q?ptRxg6O8cxC/UV7yp6pC4CwuKQp0lHd0AJDAvvrZw2aPlN35FqtdlUYSp6gZ?=
 =?us-ascii?Q?ahovCQv1dL5MEAGjZQLmTiQtLyoWpoRfC8V7xzFini3av8b3vw8qVGErYg7c?=
 =?us-ascii?Q?UdqCwskIsqcqQ2330uQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efebcb7-6c87-43ff-ed96-08da9febf64d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 18:21:42.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxg7/GhNGFHa5n676ROp9E9g4I+9BWelBZLJi2zqy1FYMmMXdJDRGTPx/5zobMMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 25, 2022 at 03:39:58PM +0200, Christophe JAILLET wrote:
> There is already a SPDX-License-Identifier tag, so the corresponding
> license text can be removed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Changes in the 2 files under rdma/hfi/ is a bit more than just removing
> the license text. There were some Copyright(c) for GPL and BSD licence.
> I have simplified it to what look logical to me.
> But in case it matters, review with care.

Did you use a script or something to verify that the text being
removed is word for word identical to the text in LICENSES/ ?

I had understood this was the reason the original SPDX conversion left
the license text around?

It looks OK to me, but I didn't check it word for word :)

Is there a reason this series is coming up now around the uapi
headers? Are we doing them all or something?

Jason
